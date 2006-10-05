Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWJERgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWJERgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWJERgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:36:36 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:65414 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751654AbWJERgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:36:35 -0400
Date: Thu, 5 Oct 2006 13:36:28 -0400
To: Paul B Schroeder <pschroeder@uplogix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Exar quad port serial
Message-ID: <20061005173628.GB30993@csclub.uwaterloo.ca>
References: <1160068402.29393.7.camel@rupert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160068402.29393.7.camel@rupert>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 12:13:21PM -0500, Paul B Schroeder wrote:
> I put this together real quick to get all of the ports of my "dumb" Exar
> quad uart card to work..  Patch applies against 2.6.19-rc1 just fine..
> 
> 
> ---------------------------------------------------------------------------
> 
> diff -urN linux-2.6.17.i686.orig/drivers/serial/8250_exar.c linux-2.6.17.i686/drivers/serial/8250_exar.c
> --- linux-2.6.17.i686.orig/drivers/serial/8250_exar.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.17.i686/drivers/serial/8250_exar.c	2006-10-02 17:11:31.000000000 -0500
> @@ -0,0 +1,52 @@
> +/*
> + *  linux/drivers/serial/8250_exar.c
> + *
> + *  Written by Paul B Schroeder < pschroeder "at" uplogix "dot" com >
> + *  Based on 8250_boca.
> + *
> + *  Copyright (C) 2005 Russell King.
> + *  Data taken from include/asm-i386/serial.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/serial_8250.h>
> +
> +#define PORT(_base,_irq)				\
> +	{						\
> +		.iobase		= _base,		\
> +		.irq		= _irq,			\
> +		.uartclk	= 1843200,		\
> +		.iotype		= UPIO_PORT,		\
> +		.flags		= UPF_BOOT_AUTOCONF,	\
> +	}
> +
> +static struct plat_serial8250_port exar_data[] = {
> +	PORT(0x100, 5),
> +	PORT(0x108, 5),
> +	PORT(0x110, 5),
> +	PORT(0x118, 5),
> +	{ },
> +};
> +
> +static struct platform_device exar_device = {
> +	.name			= "serial8250",
> +	.id			= PLAT8250_DEV_EXAR,
> +	.dev			= {
> +		.platform_data	= exar_data,
> +	},
> +};
> +
> +static int __init exar_init(void)
> +{
> +	return platform_device_register(&exar_device);
> +}
> +
> +module_init(exar_init);
> +
> +MODULE_AUTHOR("Paul B Schroeder");
> +MODULE_DESCRIPTION("8250 serial probe module for Exar cards");
> +MODULE_LICENSE("GPL");
> diff -urN linux-2.6.17.i686.orig/drivers/serial/Kconfig linux-2.6.17.i686/drivers/serial/Kconfig
> --- linux-2.6.17.i686.orig/drivers/serial/Kconfig	2006-09-06 14:50:05.000000000 -0500
> +++ linux-2.6.17.i686/drivers/serial/Kconfig	2006-10-02 17:13:25.000000000 -0500
> @@ -211,6 +211,16 @@
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called 8250_boca.
>  
> +config SERIAL_8250_EXAR
> +	tristate "Support Exar cards"
> +	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
> +	help
> +	  Say Y here if you have a Exar serial board.  Please read the Boca
> +	  mini-HOWTO, avaialble from <http://www.tldp.org/docs.html#howto>
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called 8250_exar.
> +
>  config SERIAL_8250_HUB6
>  	tristate "Support Hub6 cards"
>  	depends on SERIAL_8250 != n && ISA && SERIAL_8250_MANY_PORTS
> diff -urN linux-2.6.17.i686.orig/drivers/serial/Makefile linux-2.6.17.i686/drivers/serial/Makefile
> --- linux-2.6.17.i686.orig/drivers/serial/Makefile	2006-06-17 20:49:35.000000000 -0500
> +++ linux-2.6.17.i686/drivers/serial/Makefile	2006-10-02 17:13:52.000000000 -0500
> @@ -17,6 +17,7 @@
>  obj-$(CONFIG_SERIAL_8250_FOURPORT) += 8250_fourport.o
>  obj-$(CONFIG_SERIAL_8250_ACCENT) += 8250_accent.o
>  obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
> +obj-$(CONFIG_SERIAL_8250_EXAR) += 8250_exar.o
>  obj-$(CONFIG_SERIAL_8250_HUB6) += 8250_hub6.o
>  obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mca.o
>  obj-$(CONFIG_SERIAL_8250_AU1X00) += 8250_au1x00.o
> diff -urN linux-2.6.17.i686.orig/include/linux/serial_8250.h linux-2.6.17.i686/include/linux/serial_8250.h
> --- linux-2.6.17.i686.orig/include/linux/serial_8250.h	2006-06-17 20:49:35.000000000 -0500
> +++ linux-2.6.17.i686/include/linux/serial_8250.h	2006-10-02 17:12:34.000000000 -0500
> @@ -41,6 +41,7 @@
>  	PLAT8250_DEV_FOURPORT,
>  	PLAT8250_DEV_ACCENT,
>  	PLAT8250_DEV_BOCA,
> +	PLAT8250_DEV_EXAR,
>  	PLAT8250_DEV_HUB6,
>  	PLAT8250_DEV_MCA,
>  	PLAT8250_DEV_AU1X00,

With 2.6 kernels at least a lot of Exar chips already work.  Perhaps you
could be more explicit about which Exar chips/boards this is supposed to
cover.

--
Len Sorensen
