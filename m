Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWHKXtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWHKXtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWHKXtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:49:49 -0400
Received: from mail02.hansenet.de ([213.191.73.62]:49574 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S932111AbWHKXtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:49:49 -0400
From: Thomas Koeller <thomas@koeller.dyndns.org>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Date: Sat, 12 Aug 2006 01:49:23 +0200
User-Agent: KMail/1.9.3
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com>
In-Reply-To: <20060811205639.GK26930@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608120149.23380.thomas@koeller.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 22:56, Dave Jones wrote:
> On Thu, Aug 10, 2006 at 11:19:13PM +0200, thomas@koeller.dyndns.org wrote:
>  > This is a driver for the on-chip watchdog device found on some
>  > MIPS RM9000 processors.
>  >
>  > Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
>
> Mostly same nit-picking comments as your other driver..

Which one?

>
>  > +++ b/drivers/char/watchdog/rm9k_wdt.c
>  > ...
>  > +
>  > +#include <linux/config.h>
>
> not needed.

It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.

>
>  > +/* Function prototypes */
>  > +static int __init wdt_gpi_probe(struct device *);
>  > +static int __exit wdt_gpi_remove(struct device *);
>  > +static void wdt_gpi_set_timeout(unsigned int);
>  > +static int wdt_gpi_open(struct inode *, struct file *);
>  > +static int wdt_gpi_release(struct inode *, struct file *);
>  > +static ssize_t wdt_gpi_write(struct file *, const char __user *,
>  > size_t, loff_t *);
>  > +static long wdt_gpi_ioctl(struct file *, unsigned int, unsigned long);
>  > +static const struct resource *wdt_gpi_get_resource(struct
>  > platform_device *, const char *, unsigned int);
>  > +static int wdt_gpi_notify(struct notifier_block *, unsigned long, void
>  > *); +static irqreturn_t wdt_gpi_irqhdl(int, void *, struct pt_regs *);
>
> Can probably (mostly?) go away with some creative reordering.

Probably, but should it? I always considered it good style to have
prototypes for all functions.

>
>  > +static int locked = 0;
>
> unneeded initialisation.

Not strictly needed, that's true, but does not do any harm either
and expresses the intention clearly.

>
>  > +static int nowayout =
>  > +#if defined(CONFIG_WATCHDOG_NOWAYOUT)
>  > +	1;
>  > +#else
>  > +	0;
>  > +#endif
>
> static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
>
> should work.

Does not work. If the option is not selected, CONFIG_WATCHDOG_NOWAYOUT
is undefined, not zero.

>
>  > +static void wdt_gpi_set_timeout(unsigned int to)
>  > +{
>  > +	u32 reg;
>  > +	const u32 wdval = (to * CLOCK) & ~0x0000000f;
>  > +
>  > +	lock_titan_regs();
>  > +	reg = titan_readl(CPCCR) & ~(0xf << (wd_ctr * 4));
>  > +	titan_writel(reg, CPCCR);
>  > +	wmb();
>  > +	__raw_writel(wdval, wd_regs + 0x0000);
>  > +	wmb();
>  > +	titan_writel(reg | (0x2 << (wd_ctr * 4)), CPCCR);
>  > +	wmb();
>  > +	titan_writel(reg | (0x5 << (wd_ctr * 4)), CPCCR);
>  > +	iob();
>  > +	unlock_titan_regs();
>  > +}
>
> As in the previous driver, are these barriers strong enough?
> Or do they need explicit reads of the written addresses to flush the write?

I think they are. Remember, the entire device is integrated in the
processor. No external buses involved.

>
> 		Dave

Thanks for your comments!

Thomas

-- 
Thomas Koeller
thomas@koeller.dyndns.org
