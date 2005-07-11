Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVGLBd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVGLBd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 21:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVGKOAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:00:11 -0400
Received: from fsmlabs.com ([168.103.115.128]:47069 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261741AbVGKN7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:59:33 -0400
Date: Mon, 11 Jul 2005 08:03:54 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] i386: Per node IDT
In-Reply-To: <42D26604.66A75939@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0507110747480.16055@montezuma.fsmlabs.com>
References: <42D26604.66A75939@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleg,

On Mon, 11 Jul 2005, Oleg Nesterov wrote:

> Zwane Mwaikambo wrote:
> >
> > --- linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S	3 Jul 2005 13:20:43 -0000	1.1.1.1
> > +++ linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S	10 Jul 2005 22:33:37 -0000
> > -
> > +/* Build the IRQ entry stubs */
> >  vector=0
> > -ENTRY(irq_entries_start)
> > +	.align IRQ_STUB_SIZE,0x90
> > +ENTRY(interrupt)
> >  .rept NR_IRQS
> >  	ALIGN
> > -1:	pushl $vector-256
> > +	pushl $vector
> >  	jmp common_interrupt
> >
> >  [...snip...]
> >
> > --- linux-2.6.13-rc1-mm1/arch/i386/kernel/irq.c	3 Jul 2005 13:20:43 -0000	1.1.1.1
> > +++ linux-2.6.13-rc1-mm1/arch/i386/kernel/irq.c	4 Jul 2005 21:39:56 -0000
> > @@ -53,8 +53,7 @@ static union irq_ctx *softirq_ctx[NR_CPU
> >   */
> >  fastcall unsigned int do_IRQ(struct pt_regs *regs)
> >  {	
> > -	/* high bits used in ret_from_ code */
> > -	int irq = regs->orig_eax & 0xff;
> > +	int irq = regs->orig_eax;
> 
> Could you explain this change? I think it breaks do_signal/handle_signal,
> they check orig_eax >= 0 to handle -ERESTARTSYS:
> 
> 	/* Are we from a system call? */
> 	if (regs->orig_eax >= 0) {
> 		/* If so, check system call restarting.. */
> 		switch (regs->eax) {
> 		        case -ERESTART_RESTARTBLOCK:
> 			case -ERESTARTNOHAND:

The change is so that we can send IRQs higher than 256 to do_IRQ. That 
looks like it tries to check if we came in via system_call since we'd save 
the system call number as orig_eax. Now that i think about it, doesn't 
that path always get taken when we interrupt userspace and have pending 
signals on return from interrupt?
