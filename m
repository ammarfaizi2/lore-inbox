Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSGWXsy>; Tue, 23 Jul 2002 19:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSGWXsy>; Tue, 23 Jul 2002 19:48:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43732 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315629AbSGWXsx>;
	Tue, 23 Jul 2002 19:48:53 -0400
Date: Wed, 24 Jul 2002 01:50:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] big IRQ lock removal, 2.5.27-G0
In-Reply-To: <3D3DE984.A6FEA4CB@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0207240137190.3812-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Oleg Nesterov wrote:

> I can't understand the preempt_count() check in irq_exit() and
> local_bh_enable(). Did you meant irq_count() instead? I beleive
> preempt_disable() should not disable soft interrupts.

yes, you are right, and i fixed them in -G3.

doh, i *thought* i fixed both places in -G3, but i only fixed irq_exit().  
the local_bh_enable() fix is in -G4:

  http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-G4

> In local_bh_enable() it is probably unneeded at all, because nested
> local_bh_disable() is rare (i think), and do_softirq() checks
> in_interrupt().

but still we dont want to call do_softirq() all the time. local_bh_enable
is used in quite performance-sensitive networking code.

> Now suppose preempt_count() & PREEMPT_MASK == 0.
> 
> Then local_bh_enable() has a small preemptible window between
> __local_bh_enable() and do_softirq()->local_irq_save(flags).
> It is only latency problem.

i dont think getting a preemption before softirqs are processed is a big
problem. Such type of preemption comes in form of an interrupt, which 
handles softirqs in irq_exit() anyway, so there's no delay.

> But in irq_exit() case interrupt context may be preempted
> while doing wakeup_softirqd(cpu) after __local_bh_enable()
> in do_softirq().

okay - i've fixed irq_exit() once more in -G4, could you double-check it?

	Ingo

