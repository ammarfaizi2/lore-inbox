Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWASFrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWASFrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWASFrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:47:12 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:29636 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S932543AbWASFrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:47:11 -0500
Subject: Re: [PATCH 5/5] stack overflow safe kdump (2.6.15-i386) - private
	nmi stack
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20060118015111.GD23143@in.ibm.com>
References: <1137417926.2256.89.camel@localhost.localdomain>
	 <20060118015111.GD23143@in.ibm.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Thu, 19 Jan 2006 14:47:06 +0900
Message-Id: <1137649626.2985.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 20:51 -0500, Vivek Goyal wrote:
> On Mon, Jan 16, 2006 at 10:25:26PM +0900, Fernando Luis Vazquez Cao wrote:
> > Use a private NMI stack.
> > 
> > ---
> > diff -urNp linux-2.6.15/arch/i386/kernel/irq.c
> > linux-2.6.15-sov/arch/i386/kernel/irq.c
> > --- linux-2.6.15/arch/i386/kernel/irq.c	2006-01-03 12:21:10.000000000
> > +0900
> > +++ linux-2.6.15-sov/arch/i386/kernel/irq.c	2006-01-16
> > 22:04:07.000000000 +0900
> > @@ -37,11 +37,6 @@ void ack_bad_irq(unsigned int irq)
> >  /*
> >   * per-CPU IRQ handling contexts (thread information and stack)
> >   */
> > -union irq_ctx {
> > -	struct thread_info      tinfo;
> > -	u32                     stack[THREAD_SIZE/sizeof(u32)];
> > -};
> > -
> >  static union irq_ctx *hardirq_ctx[NR_CPUS];
> >  static union irq_ctx *softirq_ctx[NR_CPUS];
> >  #endif
> > @@ -154,6 +149,8 @@ void irq_ctx_init(int cpu)
> >  
> >  	printk("CPU %u irqstacks, hard=%p soft=%p\n",
> >  		cpu,hardirq_ctx[cpu],softirq_ctx[cpu]);
> > +
> > +	nmi_ctx_init(cpu);
> >  }
> >  
> >  void irq_ctx_exit(int cpu)
> > diff -urNp linux-2.6.15/arch/i386/kernel/traps.c
> > linux-2.6.15-sov/arch/i386/kernel/traps.c
> > --- linux-2.6.15/arch/i386/kernel/traps.c	2006-01-16 22:00:54.000000000
> > +0900
> > +++ linux-2.6.15-sov/arch/i386/kernel/traps.c	2006-01-16
> > 22:05:51.000000000 +0900
> > @@ -643,6 +643,13 @@ static int dummy_nmi_callback(struct pt_
> >   
> >  static nmi_callback_t nmi_callback = dummy_nmi_callback;
> >  
> > +#ifdef CONFIG_4KSTACKS
> > +/*
> 
> Does not work for 8K stacks. Also we are switching the stack all the
> time for NMI. I am not sure if that is really required (performance?).
Yes, it does not work for 8K stacks, but this is something premeditated.
Since private stacks for interrupts are only used when 4KSTACKS
is enabled I felt that to be consistent it should be the same in
the NMI's case. Anyway if it is deemed correct (I agree it is desirable)
I could implement it.

Regarding the impact in performance, note that when we use 4K stacks we
are switching stacks _every_ time an interrupt occurs. I do not see why
we should not do the same for NMIs. Specially since the cost of
switching stacks is relatively small when compared to the cost of
executing the NMI watchdog's handler.

> Can't it be made to work both for 4K and 8K stack. And switch to reserved
> stack on NMI, only if crash has happened.
Yes, it could be done, but I think it is safer to use a private stack
all the time, so that the NMI handler does not contribute to an eventual
stack overflow. I would like to avoid the case of the the stack
overflowing inside the NMI handler.

Thanks for your comments.

Regards,

Fernando

