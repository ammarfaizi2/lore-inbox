Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTDXPvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTDXPvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:51:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:43655 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263729AbTDXPvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:51:21 -0400
Date: Thu, 24 Apr 2003 09:04:31 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, chrisg@0-in.com,
       sensors@stimpy.netroedge.com
Subject: Re: it87 driver converted to sysfs
Message-ID: <20030424160431.GC18690@kroah.com>
References: <20030424150113.GJ1069@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424150113.GJ1069@iucha.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:01:13AM -0500, Florin Iucha wrote:
> Greg,
> 
> I have converted it87 i2c driver to use sysfs. Please review it and
> submit it for inclusion.

A few comments:

> +static struct i2c_driver it87_driver = {
> +	.owner		= THIS_MODULE,
> +	.name		= "IT87xx sensor driver",
> +	.id		= I2C_DRIVERID_IT87,
> +	.flags		= I2C_DF_NOTIFY,
> +	.attach_adapter	= it87_attach_adapter,
> +	.detach_client	= it87_detach_client,
> +};

Isn't that name too big for sysfs?  Why not just drop the 
" sensor driver" portion of it, as that is pretty redundant.

> +/* The /proc/sys entries */
> +
> +/* -- SENSORS SYSCTL START -- */

<snip> 

These are no longer needed, right?

> +/* These files are created for each detected IT87. This is just a template;
> +   though at first sight, you might think we could use a statically
> +   allocated list, we need some way to get back to the parent - which
> +   is done through one of the 'extra' fields which are initialized 
> +   when a new copy is allocated. 
> +static ctl_table it87_dir_table_template[] = {

Nor is this table needed anymore either.  Yeah, it's commented out,
might as well just delete the whole thing :)

> +static ssize_t show_in(struct device *dev, char *buf, int nr) {
> +	struct i2c_client *client = to_i2c_client(dev);
> +   struct it87_data *data = i2c_get_clientdata(client);
> +	it87_update_client(client);
> +	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
> +}

Please use the kernel coding style as documented in
Documentation/CodingStyle (hint, use tabs, and the '{' for a function
should be on a new line.)

> +/* OK, this is not exactly good programming practice, usually. But it is
> +   very code-efficient in this case. */

This comment can go, as it is good programming practice.

> diff -Nru linux-2.5.68/drivers/i2c/chips/Kconfig linux-2.5.68-it87/drivers/i2c/chips/Kconfig
> --- linux-2.5.68/drivers/i2c/chips/Kconfig	2003-04-24 09:46:09.000000000 -0500
> +++ linux-2.5.68-it87/drivers/i2c/chips/Kconfig	2003-04-24 09:57:32.000000000 -0500
> @@ -64,10 +64,20 @@
>  	  in the lm_sensors package, which you can download at
>  	  http://www.lm-sensors.nu
>  
> +config SENSORS_IT87
> +	tristate "  ITE IT87 and compatibles"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  The module will be called it87.
> +
> +	  You will also need the latest user-space utilties: you can find them
> +	  in the lm_sensors package, which you can download at 
> +	  http://www.lm-sensors.nu
> +

Can you place this in alphabetical order in the file?  Makes is nicer
looking.

> diff -Nru linux-2.5.68/drivers/i2c/chips/Makefile linux-2.5.68-it87/drivers/i2c/chips/Makefile
> --- linux-2.5.68/drivers/i2c/chips/Makefile	2003-04-24 09:46:03.000000000 -0500
> +++ linux-2.5.68-it87/drivers/i2c/chips/Makefile	2003-04-24 09:55:21.000000000 -0500
> @@ -6,3 +6,4 @@
>  obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>  obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
> +obj-$(CONFIG_SENSORS_IT87)	+= it87.o


Same thing with the alphabetical order here.

Other than those very minor things the patch looks good.  Mind fixing
them and sending it to me again?

thanks,

greg k-h
