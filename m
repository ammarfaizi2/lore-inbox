Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUIHMoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUIHMoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUIHMoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:44:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2689 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263429AbUIHMoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:44:19 -0400
Date: Wed, 8 Sep 2004 14:45:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908124547.GA19231@elte.hu>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908133445.A31267@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > @@ -99,4 +99,6 @@ do {									\
> >    extern void synchronize_irq(unsigned int irq);
> >  #endif /* CONFIG_SMP */
> >  
> > +extern int setup_irq(unsigned int irq, struct irqaction * new);
> 
> This doesn't apply anymore because most of <asm/hardirq.h> moved to
> linux/hardirq.h in -mm and a the patch is on it's way to Linus.

(yeah. not a big issue - can happen in any order. this patch is against
BK-curr.)

> > +extern asmlinkage int generic_handle_IRQ_event(unsigned int irq, struct pt_regs *regs, struct irqaction *action);
> > +extern void generic_synchronize_irq(unsigned int irq);
> > +extern int generic_setup_irq(unsigned int irq, struct irqaction * new);
> > +extern void generic_free_irq(unsigned int irq, void *dev_id);
> > +extern void generic_disable_irq_nosync(unsigned int irq);
> > +extern void generic_disable_irq(unsigned int irq);
> > +extern void generic_enable_irq(unsigned int irq);
> > +extern void generic_note_interrupt(int irq, irq_desc_t *desc, int action_ret);
> 
> Please don't introduce the generic_ names just to have every arch (in
> your previous patches, that is) provide a wrapper with normal names
> again.

some of the architectures dont want to (and cannot) use the generic
functions for one reason or another. So the proper approach i believe is
to provide these generic functions the architectures can plug in. I can
do an asm-generic/hardirq.h that adds all the definitions, for
architectures that dont need any special IRQ logic.

> >  obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
> > -	    exit.o itimer.o time.o softirq.o resource.o \
> > +	    exit.o itimer.o time.o softirq.o hardirq.o resource.o \
> 
> And make hardirq.o dependent on some symbols the architectures set.
> Else arches that don't use it carry tons of useless baggage around
> (and in fact I'm pretty sure it wouldn't even compie for many)

it compiles fine on x86, x64, ppc and ppc64. Why do you think it wont
compile on others?

wrt. unused generic functions - why dont we drop them link-time?

	Ingo
