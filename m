Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUIHMgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUIHMgV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUIHMfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:35:51 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:60423 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263003AbUIHMfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:35:14 -0400
Date: Wed, 8 Sep 2004 13:34:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908133445.A31267@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
References: <20040908120613.GA16916@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908120613.GA16916@elte.hu>; from mingo@elte.hu on Wed, Sep 08, 2004 at 02:06:13PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 02:06:13PM +0200, Ingo Molnar wrote:
> 
> the attached patch moves generic hardirq handling bits to
> kernel/hardirq.c. It is not a replacement for any of the existing IRQ
> functions, so architectures can use their existing hardirq code in an
> unmodified form. It is a library of generic functions that an
> architecture can make use of optionally.
> 
> I've fully converted x86's irq.c to use the new functions, and Scott
> Wood has done the same for ppc/ppc64 as well. (the arch-ppc* changes are
> not included in this patch because i couldnt test them myself in the
> current port of this patch - but the generic bits were tested on ppc.)
> 
> i have test-compiled and test-booted the patch on x86 and x64, on SMP &&
> PREEMPT and !SMP && !PREEMPT kernels. x64 needed only a single change (a
> setup_irq() prototype) to work fine, which makes me believe that the
> patch will not break other architectures either.
> 
> (a more complex version of this patch has been tested for weeks as part
> of the voluntary-preempt patches as well.)


> +++ linux/include/asm-x86_64/hardirq.h	
> @@ -25,8 +25,8 @@
>   * - ( bit 26 is the PREEMPT_ACTIVE flag. )
>   *
>   * PREEMPT_MASK: 0x000000ff
> - * HARDIRQ_MASK: 0x0000ff00
> - * SOFTIRQ_MASK: 0x00ff0000
> + * SOFTIRQ_MASK: 0x0000ff00
> + * HARDIRQ_MASK: 0x00ff0000
>   */
>  
>  #define PREEMPT_BITS	8
> @@ -99,4 +99,6 @@ do {									\
>    extern void synchronize_irq(unsigned int irq);
>  #endif /* CONFIG_SMP */
>  
> +extern int setup_irq(unsigned int irq, struct irqaction * new);

This doesn't apply anymore because most of <asm/hardirq.h> moved
to linux/hardirq.h in -mm and a the patch is on it's way to Linus.

> @@ -71,10 +74,21 @@ extern irq_desc_t irq_desc [NR_IRQS];
>  
>  #include <asm/hw_irq.h> /* the arch dependent stuff */
>  
> -extern int setup_irq(unsigned int , struct irqaction * );
> +
> +extern asmlinkage int generic_handle_IRQ_event(unsigned int irq, struct pt_regs *regs, struct irqaction *action);
> +extern void generic_synchronize_irq(unsigned int irq);
> +extern int generic_setup_irq(unsigned int irq, struct irqaction * new);
> +extern void generic_free_irq(unsigned int irq, void *dev_id);
> +extern void generic_disable_irq_nosync(unsigned int irq);
> +extern void generic_disable_irq(unsigned int irq);
> +extern void generic_enable_irq(unsigned int irq);
> +extern void generic_note_interrupt(int irq, irq_desc_t *desc, int action_ret);

Please don't introduce the generic_ names just to have every arch (in your
previous patches, that is) provide a wrapper with normal names again.


> --- linux/kernel/Makefile.orig	
> +++ linux/kernel/Makefile	
> @@ -3,7 +3,7 @@
>  #
>  
>  obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
> -	    exit.o itimer.o time.o softirq.o resource.o \
> +	    exit.o itimer.o time.o softirq.o hardirq.o resource.o \

And make hardirq.o dependent on some symbols the architectures set.
Else arches that don't use it carry tons of useless baggage around (and
in fact I'm pretty sure it wouldn't even compie for many)

