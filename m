Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTFLC02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264672AbTFLC02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:26:28 -0400
Received: from gateway.penguincomputing.com ([64.243.132.186]:58535 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S262498AbTFLC00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:26:26 -0400
Message-ID: <3EE7E809.1000005@penguincomputing.com>
Date: Wed, 11 Jun 2003 19:40:09 -0700
From: Philip Pokorny <ppokorny@penguincomputing.com>
Organization: Penguin Computing
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
References: <10553638062379@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there is a race condition here in the "set" functions.

I had added a  down()/up() semaphore pair to the write clauses of the 
functions in the pre-sysfs driver to prevent the xx_update_client() call 
from modifying the cached values at the same time that the set_xxx() 
function was trying to change them.

So for example:

 >  static ssize_t set_temp_max(struct device *dev, const char *buf,
 >  		size_t count, int nr)
 >  {
 >  	struct i2c_client *client = to_i2c_client(dev);
 >  	struct lm85_data *data = i2c_get_clientdata(client);
 >
 >  	int val = simple_strtol(buf, NULL, 10);
 > +     down(&data->update_lock);
 >  	data->temp_max[nr] = TEMP_TO_REG(val);
 >  	lm85_write_value(client, LM85_REG_TEMP_MAX(nr),
 >                                     data->temp_max[nr]);
 > +     up(&data->update_lock);
 >  	return count;
 >  }

Isn't that still needed?

:v)

Greg KH wrote:
> ChangeSet 1.1419.1.3, 2003/06/11 11:42:47-07:00, margitsw@t-online.de
> 
> [PATCH] I2C: add LM85 driver
> 
> Nothing extra in sysfs (yet) but I have left the way open in the driver
> to do this.
> Provides vid, vrm, fan_input(1-4), fan_min(1-4), pwm(1-3),
> pwm_enable(1-3), in_input(0-4), in_min(0-4), in_max(0-4),
> temp_input(1-3), temp_min(1-3), temp_max(1-3), alarms.
> 
> 
>  drivers/i2c/chips/Kconfig  |   19 
>  drivers/i2c/chips/Makefile |    1 
>  drivers/i2c/chips/lm85.c   | 1223 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1241 insertions(+), 2 deletions(-)
> 



> +static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm85_data *data = i2c_get_clientdata(client);
> +
> +	lm85_update_client(client);
> +	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[nr]) );
> +}



> +static ssize_t set_temp_max(struct device *dev, const char *buf, 
> +		size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm85_data *data = i2c_get_clientdata(client);
> +
> +	int val = simple_strtol(buf, NULL, 10);
> +	data->temp_max[nr] = TEMP_TO_REG(val);
> +	lm85_write_value(client, LM85_REG_TEMP_MAX(nr), data->temp_max[nr]);
> +	return count;
> +}


-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com

