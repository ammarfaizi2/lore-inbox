Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVGFW7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVGFW7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVGFW6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:58:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:59051 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262170AbVGFW5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:57:24 -0400
Date: Wed, 6 Jul 2005 15:57:10 -0700
From: Greg KH <greg@kroah.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Message-ID: <20050706225709.GA26801@kroah.com>
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com> <200507061414.48764.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061414.48764.mgross@linux.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 02:14:44PM -0700, Mark Gross wrote:
> +#ifndef __KERNEL__
> +#  define __KERNEL__
> +#endif

Not needed.

> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>	/* printk() */
> +#include <linux/fs.h>		/* everything... */
> +#include <linux/errno.h>	/* error codes */
> +#include <linux/delay.h>	/* udelay */
> +#include <asm/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/ioport.h>
> +#include <linux/devfs_fs_kernel.h>	/* Devfs support */
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/timer.h>
> +#include <asm/io.h>		/* inb/outb */

Put asm/ at the end.

> +
> +#include "tlclk.h"	/* TELECOM IOCTL DEFINE */

No new ioctls please.  Use sysfs or something else.

> +
> +MODULE_AUTHOR("Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>");
> +MODULE_LICENSE("GPL");
> +
> +/* Telecom clock I/O register definition */
> +#define TLCLK_BASE 0xa08            
> +#define TLCLK_REG0 TLCLK_BASE
> +#define TLCLK_REG1 (TLCLK_BASE+1)
> +#define TLCLK_REG2 (TLCLK_BASE+2)
> +#define TLCLK_REG3 (TLCLK_BASE+3)
> +#define TLCLK_REG4 (TLCLK_BASE+4)
> +#define TLCLK_REG5 (TLCLK_BASE+5)
> +#define TLCLK_REG6 (TLCLK_BASE+6)
> +#define TLCLK_REG7 (TLCLK_BASE+7)
> +
> +#define SET_PORT_BITS(port, mask, val) outb(((inb(port) & mask) | val), port)
> +
> +/* 0 = Dynamic allocation of the major device number */
> +#define TLCLK_MAJOR 252

Is this a reserved major?

> +/* DEVFS support or not */
> +#ifdef CONFIG_DEVFS_FS

DEVFS is obsolete and will be removed very soon now.  You don't need to
add support for it in your driver.

> +/*
> +*  Function : Module Opening
> +*  Description : Called when a program open the 
> +*  /dev/telclock file related to the module.
> +*/

Function comments like this are not needed at all.

> +struct tlclk_alarms {
> +	unsigned int lost_clocks;
> +	unsigned int lost_primary_clock;
> +	unsigned int lost_secondary_clock;
> +	unsigned int primary_clock_back;
> +	unsigned int secondary_clock_back;
> +	unsigned int switchover_primary;
> +	unsigned int switchover_secondary;
> +	unsigned int pll_holdover;
> +	unsigned int pll_end_holdover;
> +	unsigned int pll_lost_sync;
> +	unsigned int pll_sync;
> +};

If you are going to pass a structure accross the kernel/userspace
boundry, you need to explicitly mark the variable sizes.  Use __u8,
__u16, or __u32 here (unless they are signed, then use __s8, etc.)

All of those values look like they should just be exported as individual
sysfs files, right?

thanks,

greg k-h
