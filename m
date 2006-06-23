Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWFWEE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWFWEE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 00:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWFWEE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 00:04:57 -0400
Received: from xenotime.net ([66.160.160.81]:47029 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751130AbWFWEE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 00:04:56 -0400
Date: Thu, 22 Jun 2006 21:07:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Straub, Michael" <Michael.Straub@avocent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/13] SST driver: tty_register_device() change
Message-Id: <20060622210742.e7bc1e35.rdunlap@xenotime.net>
In-Reply-To: <4821D5B6CD3C1B4880E6E94C6E70913E01B710F1@sun-email.corp.avocent.com>
References: <4821D5B6CD3C1B4880E6E94C6E70913E01B710F1@sun-email.corp.avocent.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:06:40 -0400 Straub, Michael wrote:

> Adds Equinox multi-port serial (SST) driver.
> 
> Part 1: Modifies the tty subsystem routine tty_register_device so that
> it
> returns the class_device allocated for the tty device, thus making it 
> available to the tty driver.  The class_device is used by this driver to
> add additional sysfs-based attribute files used for status and
> diagnostics.
> 
> Signed-off-by: Mike Straub <michael.straub@avocent.com>
> 
> ---
>  drivers/char/tty_io.c |    8 ++++----
>  include/linux/tty.h   |    4 +++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff -Naurp -X dontdiff linux-2.6.17/include/linux/tty.h
> linux-2.6.17.eqnx/include/linux/tty.h
> --- linux-2.6.17/include/linux/tty.h	2006-06-17 21:49:35.000000000
> -0400
> +++ linux-2.6.17.eqnx/include/linux/tty.h	2006-06-20
> 09:49:54.000000000 -0400

Your mailer or (exchange?) server likes to break lines where
they shouldn't be split, as above 2 (now 4) lines.

> diff -Naurp -X dontdiff linux-2.6.17/drivers/char/tty_io.c
> linux-2.6.17.eqnx/drivers/char/tty_io.c
> --- linux-2.6.17/drivers/char/tty_io.c	2006-06-17 21:49:35.000000000
> -0400
> +++ linux-2.6.17.eqnx/drivers/char/tty_io.c	2006-06-20
> 09:49:54.000000000 -0400
> @@ -2965,8 +2965,8 @@ static struct class *tty_class;
>   * the tty driver's flags have the TTY_DRIVER_NO_DEVFS bit set.  If
> that
>   * bit is not set, this function should not be called.
>   */
> -void tty_register_device(struct tty_driver *driver, unsigned index,
> -			 struct device *device)
> +struct class_device *tty_register_device(struct tty_driver *driver,
> +					 unsigned index, struct device
> *device)
>  {
>  	char name[64];
>  	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
> @@ -2974,7 +2974,7 @@ void tty_register_device(struct tty_driv
>  	if (index >= driver->num) {
>  		printk(KERN_ERR "Attempt to register invalid tty line
> number "
>  		       " (%d).\n", index);
> -		return;
> +		return NULL;
>  	}
>  
>  	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
> @@ -2984,7 +2984,7 @@ void tty_register_device(struct tty_driv
>  		pty_line_name(driver, index, name);
>  	else
>  		tty_line_name(driver, index, name);
> -	class_device_create(tty_class, NULL, dev, device, "%s", name);
> +	return (class_device_create(tty_class, NULL, dev, device, "%s",
> name));
>  }

Don't use unneeded parens around the return value.  Just:
	return class_device_create(foo bar blah);


---
~Randy
