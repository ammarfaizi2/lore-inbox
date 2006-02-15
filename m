Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWBOD1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWBOD1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWBOD1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:27:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25263
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030617AbWBOD1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:27:14 -0500
Date: Tue, 14 Feb 2006 19:27:00 -0800
From: Greg KH <gregkh@suse.de>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH 2/9] isdn4linux: Siemens Gigaset drivers - common module
Message-ID: <20060215032659.GB5099@suse.de>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overall, all of these look fine, I only have a few minor cleanup
comments here and there...


On Sat, Feb 11, 2006 at 03:52:27PM +0100, Hansjoerg Lipp wrote:
> --- linux-2.6.16-rc2/drivers/isdn/gigaset/gigaset.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-rc2-gig/drivers/isdn/gigaset/gigaset.h	2006-02-11 15:20:26.000000000 +0100
> @@ -0,0 +1,938 @@
> +/* Siemens Gigaset 307x driver
> + * Common header file for all connection variants
> + *
> + * Written by Stefan Eilers <Eilers.Stefan@epost.de>
> + *        and Hansjoerg Lipp <hjlipp@web.de>
> + *
> + * Version: $Id: gigaset.h,v 1.97.4.26 2006/02/04 18:28:16 hjlipp Exp $

$Id: isn't needed within the kernel tree :)

> + * ===========================================================================
> + */
> +
> +#ifndef GIGASET_H
> +#define GIGASET_H
> +
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <asm/atomic.h>
> +#include <linux/spinlock.h>
> +#include <linux/isdnif.h>
> +#include <linux/usb.h>
> +#include <linux/skbuff.h>
> +#include <linux/netdevice.h>
> +#include <linux/ppp_defs.h>
> +#include <linux/timer.h>
> +#include <linux/interrupt.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/list.h>

asm #includes should be at the end of the list.

> +
> +#define GIG_VERSION {0,5,0,0}
> +#define GIG_COMPAT  {0,4,0,0}
> +
> +#define MAX_REC_PARAMS 10                         /* Max. number of params in response string */
> +#define MAX_RESP_SIZE 512                         /* Max. size of a response string */
> +#define HW_HDR_LEN 2                              /* Header size used to store ack info */

No tabs here, yet in other places in the file, you have tabs.  Try using
them everywhere.  Also try to follow the 80 column rule where ever
possible, as per the Documentation/CodingStyle file.

> +#define MAX_EVENTS 64                          /* size of event queue */
> +
> +#define RBUFSIZE 8192
> +#define SBUFSIZE 4096				/* sk_buff payload size */
> +
> +#define MAX_BUF_SIZE (SBUFSIZE - 2)		/* Max. size of a data packet from LL */
> +#define TRANSBUFSIZE 768			/* bytes per skb for transparent receive */
> +
> +/* compile time options */
> +#define GIG_MAJOR 0
> +
> +#define GIG_MAYINITONDIAL
> +#define GIG_RETRYCID
> +#define GIG_X75
> +
> +#define MAX_TIMER_INDEX 1000
> +#define MAX_SEQ_INDEX   1000
> +
> +#define GIG_TICK (HZ / 10)

What is this needed for?  Timeouts should be in real units, right?

> +/* redefine syslog macros to prepend module name instead of entire source path */
> +/* The space before the comma in ", ##" is needed by gcc 2.95 */

gcc 2.95 isn't supported by the kernel anymore :)

> +#undef info
> +#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)

Care to use the dev_info(), dev_err() and other dev_* friends instead of
rolling your own?  It gives you a much easier and standardised way of
identifying the driver and individual device that the message is
happening for.

thanks,

greg k-h
