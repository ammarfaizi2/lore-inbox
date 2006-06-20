Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWFTFXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWFTFXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWFTFWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:22:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964993AbWFTFWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:12 -0400
Date: Mon, 19 Jun 2006 22:22:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 13/20] chardev: GPIO for SCx200 & PC-8736x:  add new
 pc8736x_gpio module
Message-Id: <20060619222210.f275dde7.akpm@osdl.org>
In-Reply-To: <44944B3D.8040604@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944B3D.8040604@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:34:37 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> --- ax-12/drivers/char/pc8736x_gpio.c	1969-12-31 17:00:00.000000000 -0700
> +++ ax-13/drivers/char/pc8736x_gpio.c	2006-06-17 01:39:58.000000000 -0600
> @@ -0,0 +1,295 @@
> +/* linux/drivers/char/pc8736x_gpio.c
> +
> +   National Semiconductor PC8736x GPIO driver.  Allows a user space
> +   process to play with the GPIO pins.
> +
> +   Copyright (c) 2005 Jim Cromie <jim.cromie@gmail.com>
> +
> +   adapted from linux/drivers/char/scx200_gpio.c
> +   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>,
> +*/
> +
> +#include <linux/config.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/nsc_gpio.h>
> +#include <asm/uaccess.h>
> +#include <asm/io.h>

New code should use linux/io.h and linux/uaccess.h.  It won't matter in
this case, but you might pick up some goodies in the future.

> +#define NAME "pc8736x_gpio"
> +
> +MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
> +MODULE_DESCRIPTION("NatSemi SCx200 GPIO Pin Driver");
> +MODULE_LICENSE("GPL");
> +
> +static int major = 0;		/* default to dynamic major */

Unneeded initialisation.

> +static int pc8736x_superio_present(void)
> +     /* try the 2 possible values, read a hardware reg to verify */
> +{

weird comment placement.

> +extern void nsc_gpio_dump(unsigned iminor);

Goes in a .h file.

> +static int __init pc8736x_gpio_init(void)
> +{
> +	int r, rc;
> +
> +	printk(KERN_DEBUG NAME " initializing\n");
> +
> +	if (!pc8736x_superio_present()) {
> +		printk(KERN_ERR NAME ": no device found\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Verify that chip and it's GPIO unit are both enabled.
> +	   My BIOS does this, so I take minimum action here
> +	 */
> +	rc = superio_inb(SIO_CF1);
> +	if (!(rc & 0x01)) {
> +		printk(KERN_ERR NAME ": device not enabled\n");
> +		return -ENODEV;
> +	}
> +	device_select(SIO_GPIO_UNIT);
> +	if (!superio_inb(SIO_UNIT_ACT)) {
> +		printk(KERN_ERR NAME ": GPIO unit not enabled\n");
> +		return -ENODEV;
> +	}
> +
> +	/* read GPIO unit base address */
> +	pc8736x_gpio_base = (superio_inb(SIO_BASE_HADDR) << 8
> +			     | superio_inb(SIO_BASE_LADDR));
> +
> +	if (request_region(pc8736x_gpio_base, 16, NAME))
> +		printk(KERN_INFO NAME ": GPIO ioport %x reserved\n",
> +		       pc8736x_gpio_base);

Isn't this fatal?  If this IO region is in use by some other device, we
don't want this driver poking at it?


> +	r = register_chrdev(major, NAME, &pc8736x_gpio_fops);
> +	if (r < 0) {
> +		printk(KERN_ERR NAME ": unable to register character device\n");
> +		return r;

release_region()?

undo that device_select()?

> +	}
> +	if (!major) {
> +		major = r;
> +		printk(KERN_DEBUG NAME ": got dynamic major %d\n", major);
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit pc8736x_gpio_cleanup(void)
> +{
> +	printk(KERN_DEBUG NAME " cleanup\n");
> +
> +	release_region(pc8736x_gpio_base, 16);
> +
> +	unregister_chrdev(major, NAME);
> +}

No need to shut down any hardware here?


