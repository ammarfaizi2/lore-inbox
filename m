Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVF2SIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVF2SIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVF2SIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:08:52 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:36536 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262335AbVF2SI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:08:29 -0400
Date: Wed, 29 Jun 2005 14:07:56 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Timur Tabi <timur.tabi@ammasso.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Arjan van de Ven <arjan@infradead.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <Pine.LNX.4.61.0506291337230.5067@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0506291349510.22775@localhost.localdomain>
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
 <200506291714.32990.vda@ilport.com.ua> <42C2D0C1.4030500@ammasso.com>
 <Pine.LNX.4.58.0506291306530.22775@localhost.localdomain>
 <Pine.LNX.4.61.0506291337230.5067@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Jun 2005, Richard B. Johnson wrote:

> >
> > task 1:
> >  spin_lock(&non_irq_lock);
> >
> > task 2:
> >
> >  spin_lock_irqsave(&some_irq_used_lock);
> >  spin_lock(&non_irq_lock);
> >
> > Here we see that task 2 can spin with interrupts off, while the first task
> > is servicing an interrupt, and God forbid if the IRQ handler sends some
> > kind of SMP signal to the CPU running task 2 since that would be a
> > deadlock.  Granted, this is a hypothetical situation, but makes using
> > spin_lock with interrupts enabled a little scary.
> >
>
> But it wouldn't deadlock! It would just spin until the guy on
> another CPU that had the lock unlocked.
>

Since Timur specified that spin_lock is used when you know that the lock
is not used in an interrupt, I'll continue as if that was the case.

This is a deadlock, because sending most SMP signals expect a reply when
it is received, and will wait until it gets it. Here's a more detailed
version.

CPU 1: running task 1

   spin_lock(&non_irq_lock);

on CPU 2: running task 2

   spin_lock_irqsave(&some_irq_used_lock); /* interrupts now off */
   spin_lock(&non_irq_lock);  /* blocked and spinning waiting for task 1*/

back on CPU 1:

   interrupt goes off a preempts task 1 before it releases the
   non_irq_lock.

   Calls some stupid ISR that needs to send a signal to the other CPU.
   Sends signal and waits for a reply. (for example the flush_tlb_others)

Now we have a deadlock.  The interrupt on CPU 1 is waiting for a response
after sending an IPI to CPU 2, but CPU 2 is stuck spinning with interrupts
disabled and wont ever respond because the lock it is waiting for is held
by task 1 on CPU 1 that was preempted by the interrupt that will never
return.

This is probably the reason it is not allowed to call most IPIs from
interrupt or bottom half context.

 > FYI, spin_lock() is supposed to be used in an interrupt where it
> is already known that the interrupts are OFF so you don't need
> to save/restore flags because you know the condition. IFF the
> ISR were to enable interrupts, with a spin-lock held (bad practice),
> it still wouldn't deadlock, it's just that the entire system could
> potentially degenerate into a poll-mode, spin in the ISR, mode
> with awful performance.

I stated earlier that the only times I use spin_lock is when I already
know that interrupts are off, and that includes ISRs.

-- Steve
