Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030893AbWI0Vgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030893AbWI0Vgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030897AbWI0Vgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:36:39 -0400
Received: from www.osadl.org ([213.239.205.134]:9178 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030893AbWI0Vgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:36:38 -0400
Subject: Re: [patch 2.6.18] genirq: remove oops with fasteoi irq_chip
	descriptors
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com
In-Reply-To: <200609220643.07750.david-b@pacbell.net>
References: <200609220641.58938.david-b@pacbell.net>
	 <200609220643.07750.david-b@pacbell.net>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 23:38:17 +0200
Message-Id: <1159393098.9326.546.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 06:43 -0700, David Brownell wrote:
> The irq handler code can oops when used with an irq_chip with just
> enable/disable/eoi methods, appropriate for handle_fasteoi_irq(),
> either by (a) uninstalling, or (b) using it with a chained handler.
> 
> The problem was that the original code expected there would always
> be mask/unmask/ack methods, and the fix is to instead use methods
> which are always present and which more closely correspond to the
> flag manipulation being done.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

NACK. 

# grep startup kernel/irq/manage.c
307:                    if (desc->chip->startup)
308:                            desc->chip->startup(irq);

# grep shutdown kernel/irq/manage.c
386:                            if (desc->chip->shutdown)
387:                                    desc->chip->shutdown(irq);

startup() and shutdown() are optional and mostly there to keep the not
converted do_IRQ() users working.

This patch will simply break _all_ ARM and PowerPC in one go and as well
the i386 and x86_64 conversion which is in -mm.

	tglx

> --- d26.rc4test.orig/kernel/irq/chip.c	2006-09-21 16:41:11.000000000 -0700
> +++ d26.rc4test/kernel/irq/chip.c	2006-09-21 18:04:07.000000000 -0700
> @@ -482,10 +482,8 @@ __set_irq_handler(unsigned int irq,
>  
>  	/* Uninstall? */
>  	if (handle == handle_bad_irq) {
> -		if (desc->chip != &no_irq_chip) {
> -			desc->chip->mask(irq);
> -			desc->chip->ack(irq);
> -		}
> +		if (desc->chip != &no_irq_chip)
> +			desc->chip->shutdown(irq);
>  		desc->status |= IRQ_DISABLED;
>  		desc->depth = 1;
>  	}
> @@ -495,7 +493,7 @@ __set_irq_handler(unsigned int irq,
>  		desc->status &= ~IRQ_DISABLED;
>  		desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE;
>  		desc->depth = 0;
> -		desc->chip->unmask(irq);
> +		desc->chip->startup(irq);
>  	}
>  	spin_unlock_irqrestore(&desc->lock, flags);
>  }

