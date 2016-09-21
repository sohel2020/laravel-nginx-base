
FROM debian:jessie
MAINTAINER sohel2020@gmail.com

# Using this UID / GID allows local and live file modification of web site
RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

RUN apt-get update && apt-get install -y php5-fpm php5-mysql php5-sqlite php5-pgsql php5-mcrypt php5-curl php5-memcached php5-gd nginx supervisor cron ssmtp


# Install composer
ADD https://getcomposer.org/composer.phar /usr/bin/composer
RUN chmod 0755 /usr/bin/composer

# Configure supervisord
ADD supervisord.conf /etc/supervisor/
ADD supervisor_conf/* /etc/supervisor/conf.d/

EXPOSE 80
EXPOSE 443

ADD docker-entrypoint.sh /root/docker-entrypoint.sh
ENTRYPOINT ["/root/docker-entrypoint.sh"]
