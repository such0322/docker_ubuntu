FROM ubuntu:14.04

MAINTAINER Moz Zhong "such0322@hotmail.com"  

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
ADD sources.list /etc/apt/
RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y nginx
RUN apt-get install -y php5 php5-fpm php5-mcrypt php5-memcached php5-redis php5-gd php5-mysqlnd php5-curl
#RUN apt-get install -y redis-server redis-tools mysql-server mysql-client memcached

#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#RUN php composer-setup.php
#RUN php -r "unlink('composer-setup.php');"
#RUN cp composer.phar /bin/composer
ADD composer.phar /bin/composer
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com
RUN composer config -g secure-http false

RUN mkdir /var/www     
RUN mkdir /var/www/html
RUN git clone https://github.com/such0322/larcache.git /var/www/html/larcache
WORKDIR /var/www/html/larcache
RUN chmod -R 777 storage
RUN chmod -R 777 bootstrap/cache
RUN cp .env.example .env
RUN composer install
RUN php artisan key:generate

ADD larcache.ali.conf /etc/nginx/conf.d/larcache.ali.conf 
#RUN service nginx start
#RUN service php5-fpm start

#EXPOSE 80

#ENTRYPOINT service nginx start && service php5-fpm start
#ENTRYPOINT ["/bin/bash"]
