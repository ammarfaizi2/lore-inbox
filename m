Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUFVUrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUFVUrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUFVUqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:46:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265958AbUFVUhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:37:16 -0400
Message-ID: <40D89865.3040606@pobox.com>
Date: Tue, 22 Jun 2004 16:36:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Eger <eger@havoc.gtf.org>
CC: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jeff Garzik <garzik@havoc.gtf.org>,
       jsimmons@infradead.org
Subject: Re: [PATCH] cirrusfb: it lives!
References: <20040622202758.GA10135@havoc.gtf.org>
In-Reply-To: <20040622202758.GA10135@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Eger wrote:
> Dear Andrew,
> 
> This patch brings the cirrusfb driver up to date with 2.6.  cirrusfb
> has suffered bit rot like you wouldn't believe (last updated... 2.3.x era?).
> The driver will now compile again, and you can change to a high resolution 
> text mode with stty.  Known defects: doesn't play nice with X, nor fbset.
> Nonetheless, please apply to -mm and forward to mainline.

Groovy :)

If I am listed in MAINTAINERS somewhere, feel free to remove me... :)



> cirrusfb: port from Linux 2.4 to Linux 2.6 fb API
> 	aka The Big Overhaul(tm)
> 
> Signed-off-by: David Eger <eger@havoc.gtf.org>
> 
> diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
> --- a/drivers/video/Kconfig	2004-06-22 16:12:19 -04:00
> +++ b/drivers/video/Kconfig	2004-06-22 16:12:19 -04:00
> @@ -40,7 +40,7 @@
>  
>  config FB_CIRRUS
>  	tristate "Cirrus Logic support"
> -	depends on FB && (AMIGA || PCI) && BROKEN
> +	depends on FB && (AMIGA || PCI)
>  	---help---
>  	  This enables support for Cirrus Logic GD542x/543x based boards on
>  	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
> diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
> --- a/drivers/video/Makefile	2004-06-22 16:12:19 -04:00
> +++ b/drivers/video/Makefile	2004-06-22 16:12:19 -04:00
> @@ -39,7 +39,7 @@
>  obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
>  obj-$(CONFIG_FB_IMSTT)            += imsttfb.o cfbimgblt.o
>  obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
> -obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o
> +obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
>  obj-$(CONFIG_FB_TRIDENT)	  += tridentfb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
>  obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
>  obj-$(CONFIG_FB_TGA)              += tgafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
> diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
> --- a/drivers/video/cirrusfb.c	2004-06-22 16:12:19 -04:00
> +++ b/drivers/video/cirrusfb.c	2004-06-22 16:12:20 -04:00
> @@ -1,10 +1,13 @@
>  /*
> - * drivers/video/clgenfb.c - driver for Cirrus Logic chipsets
> + * drivers/video/cirrusfb.c - driver for Cirrus Logic chipsets
>   *
>   * Copyright 1999-2001 Jeff Garzik <jgarzik@pobox.com>
>   *
>   * Contributors (thanks, all!)
>   *
> + * 	David Eger:
> + * 	Overhaul for Linux 2.6
> + *
>   *      Jeff Rugen:
>   *      Major contributions;  Motorola PowerStack (PPC and PCI) support,
>   *      GD54xx, 1280x1024 mode support, change MCLK based on VCLK.
> @@ -15,9 +18,9 @@
>   *	Lars Hecking:
>   *	Amiga updates and testing.
>   *
> - * Original clgenfb author:  Frank Neumann
> + * Original cirrusfb author:  Frank Neumann
>   *
> - * Based on retz3fb.c and clgen.c:
> + * Based on retz3fb.c and cirrusfb.c:
>   *      Copyright (C) 1997 Jes Sorensen
>   *      Copyright (C) 1996 Frank Neumann
>   *
> @@ -31,7 +34,7 @@
>   *
>   */
>  
> -#define CLGEN_VERSION "1.9.9.1"
> +#define CIRRUSFB_VERSION "2.0-pre2"
>  
>  #include <linux/config.h>
>  #include <linux/module.h>
> @@ -63,15 +66,8 @@
>  #define isPReP 0
>  #endif
>  
> -#include <video/fbcon.h>
> -#include <video/fbcon-mfb.h>
> -#include <video/fbcon-cfb8.h>
> -#include <video/fbcon-cfb16.h>
> -#include <video/fbcon-cfb24.h>
> -#include <video/fbcon-cfb32.h>
> -
> -#include "clgenfb.h"
> -#include "vga.h"
> +#include "video/vga.h"
> +#include "video/cirrus.h"

should be <> not "", no?


>  /*****************************************************************
> @@ -81,20 +77,20 @@
>   */
>  
>  /* enable debug output? */
> -/* #define CLGEN_DEBUG 1 */
> +/* #define CIRRUSFB_DEBUG 1 */
>  
>  /* disable runtime assertions? */
> -/* #define CLGEN_NDEBUG */
> +/* #define CIRRUSFB_NDEBUG */
>  
>  /* debug output */
> -#ifdef CLGEN_DEBUG
> +#ifdef CIRRUSFB_DEBUG
>  #define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
>  #else
>  #define DPRINTK(fmt, args...)
>  #endif
>  
>  /* debugging assertions */
> -#ifndef CLGEN_NDEBUG
> +#ifndef CIRRUSFB_NDEBUG

IMO it would be nice to split up your patch into one that does all the 
cosmetic renames, and one that does the "real stuff".  Makes it far 
easier to review.


