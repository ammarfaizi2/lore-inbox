Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWKAUoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWKAUoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWKAUoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:44:10 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:7146 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1750708AbWKAUoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:44:08 -0500
Date: Wed, 1 Nov 2006 21:43:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Thomas Koeller <thomas@koeller.dyndns.org>,
       Ralf Baechle <ralf@linux-mips.org>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Randy. Dunlap" <rdunlap@xenotime.net>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20061101204353.GA691@uranus.ravnborg.org>
References: <20061101184633.GA7056@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101184633.GA7056@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wim.

Not much of my area so only some nitpicking stuff.

> /*
>  *  Watchdog implementation for GPI h/w found on PMC-Sierra RM9xxx
>  *  chips.
>  *
>  *  Copyright (C) 2004 by Basler Vision Technologies AG
>  *  Author: Thomas Koeller <thomas.koeller@baslerweb.com>
>  *
>  *  This program is free software; you can redistribute it and/or modify
We have COPYING in top level directory. No need to include GPL here.

> #define CPGIG1ER               0x0054
> 
> 
> 
> /* Function prototypes */

Too many empty lines. Get it down to 2. Seen on many places.

> static int __init wdt_gpi_probe(struct device *);
> static int __exit wdt_gpi_remove(struct device *);

> static void wdt_gpi_start(void);
> static void wdt_gpi_stop(void);
> static void wdt_gpi_set_timeout(unsigned int);
3 prototpyes not needed

> static int wdt_gpi_open(struct inode *, struct file *);
> static int wdt_gpi_release(struct inode *, struct file *);
> static ssize_t wdt_gpi_write(struct file *, const char __user *, size_t, loff_t *);
> static long wdt_gpi_ioctl(struct file *, unsigned int, unsigned long);
> static const struct resource *wdt_gpi_get_resource(struct platform_device *, const char *, unsigned int);
80 char coloum
Prototype not needed.

> /* These are set from device resources */
> static void __iomem * wd_regs;
Good to see code annotated.
I assume sparse did not give any warnings on this code?

> /* Module arguments */
> static int timeout = MAX_TIMEOUT_SECONDS;
> module_param(timeout, int, 0444);
> static unsigned long resetaddr = 0xbffdc200;
> module_param(resetaddr, ulong, 0444);
> static unsigned long flagaddr = 0xbffdc104;
> module_param(flagaddr, ulong, 0444);
> static int powercycle = 0;
> module_param(powercycle, bool, 0444);
> 
> static int nowayout = WATCHDOG_NOWAYOUT;
> module_param(nowayout, bool, 0444);

Locate parameter descriptions clode to parameter definition - not in
 bottom of file.

> static struct device_driver wdt_gpi_driver = {
> 	.name		= (char *) wdt_gpi_name,
If this cast is really needed then struct device_driver ought to be updated?

> static int __init wdt_gpi_probe(struct device *dev)
> {
> 	int res;
> 	struct platform_device * const pdv = to_platform_device(dev);
> 	const struct resource
> 		* const rr = wdt_gpi_get_resource(pdv, WDT_RESOURCE_REGS,
> 						  IORESOURCE_MEM),
> 		* const ri = wdt_gpi_get_resource(pdv, WDT_RESOURCE_IRQ,
> 						  IORESOURCE_IRQ),
> 		* const rc = wdt_gpi_get_resource(pdv, WDT_RESOURCE_COUNTER,

Separate variable definition and assignment => nicer code.

> static long
> wdt_gpi_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> {

arg is a __user pointer - why hide this fact?

> 		res = __copy_to_user((void __user *)arg, &wdinfo, size) ?
> 			-EFAULT : size;
then you get rid of this cast.
And code this as if () else
Using ?: is just ugly here.

> 	case WDIOC_GETBOOTSTATUS:
> 		stat = (*(volatile char *) flagaddr & 0x01)
> 			? WDIOF_CARDRESET : 0;

Use of volatile almost always indicate a bug.
Please explain why volatile is needed and consider the other options.

> 			printk("%s: timeout set to %u seconds\n",
> 				wdt_gpi_name, timeout);

I just noticed this pringk miss a <KERNEL_DEBUG> or similar specifier.
I guess this is all of them.


> 	if (!unlikely(__raw_readl(wd_regs + 0x0008) & 0x1))
> 		return IRQ_NONE;
> 	__raw_writel(0x1, wd_regs + 0x0008);
Magics suchs as '0x0008' deserve a comment.

> 	*(volatile char *) flagaddr |= 0x01;
> 	*(volatile char *) resetaddr = powercycle ? 0x01 : 0x2;

volatile again...

> MODULE_AUTHOR("Thomas Koeller <thomas.koeller@baslerweb.com>");
> MODULE_DESCRIPTION("Basler eXcite watchdog driver for gpi devices");
> MODULE_VERSION("0.1");
> MODULE_LICENSE("GPL");
> MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
These five tags belongs in the start of the file.

> MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
> MODULE_PARM_DESC(resetaddr, "Address to write to to force a reset");
> MODULE_PARM_DESC(flagaddr, "Address to write to boot flags to");
> MODULE_PARM_DESC(nowayout, "Watchdog cannot be disabled once started");
> MODULE_PARM_DESC(powercycle, "Cycle power if watchdog expires");
Same here - but already noted.

	Sam

