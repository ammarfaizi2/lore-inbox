Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSGXAFi>; Tue, 23 Jul 2002 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSGXAFi>; Tue, 23 Jul 2002 20:05:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2774 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314396AbSGXAFh>;
	Tue, 23 Jul 2002 20:05:37 -0400
Date: Wed, 24 Jul 2002 02:07:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption in
 2.5.27?]
In-Reply-To: <Pine.LNX.4.44.0207231650200.6537-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207240155550.5644-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Linus Torvalds wrote:

> 	/* BIG comment about what we're doing. */
> 	/* We're dropping the spinlock, but we remain non-preemptable */
> 	__raw_spin_unlock(..);
> 
> and then later on, when preemptability is over, we do
> 
> 	local_irq_enable();
> 	preempt_enable();
> 
> so that we _clearly_ mark out the region where we must not re-schedule.

agreed, this is much nicer.

i removed the spin_unlock_no_resched() define, and modified the slab.c fix
(and the other spin_unlock_no_resched() places) to be more verbose about
what they do.

we still have preempt_enable_no_resched() - that is legitimately needed in
a number of cases - i've added comments to make its usage clear.

these cleanups are in the -G5 patch:

  http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-G5

i've test-booted BK-curr + G5, CONFIG_SMP, CONFIG_PREEMPT and
CONFIG_DEBUG_IRQ_SCHEDULE kernel on an SMP box, it works fine.

	Ingo


Changes in -G3:

 - slab.c needs to spin_unlock_no_resched(), instead of spin_unlock(). (It
   also has to check for preemption in the right spot.) This should fix
   the memory corruption.

 - irq_exit() needs to run softirqs if interrupts not active - in the 
   previous patch it ran them when preempt_count() was 0, which is
   incorrect.

 - spinlock macros are updated to enable preemption after enabling 
   interrupts. Besides avoiding false positive warnings, this also 

 - fork.c has to call scheduler_tick() with preemption disabled - 
   otherwise scheduler_tick()'s spin_unlock can preempt!

 - irqs_disabled() macro introduced.

 - [ all other local_irq_enable() or sti instances conditional on
     CONFIG_DEBUG_IRQ_SCHEDULE are to fix false positive warnings. ]

Changes in -G0:

 - fix buggy in_softirq(). Fortunately the bug made the test broader,
   which didnt result in algorithmical breakage, just suboptimal
   performance.

 - move do_softirq() processing into irq_exit() => this also fixes the
   softirq processing bugs present in apic.c IRQ handlers that did not
   test for softirqs after irq_exit().

 - simplify local_bh_enable().

Changes in -F9:

 - replace all instances of:

	local_save_flags(flags);
	local_irq_disable();

   with the shorter form of:

	local_irq_save(flags);

  about 30 files are affected by this change.

Changes in -F8:

 - preempt/hardirq/softirq count separation, cleanups.

 - skbuff.c fix.

 - use irq_count() in scheduler_tick()

Changes in -F3:

 - the entry.S cleanups/speedups by Oleg Nesterov.

 - a rather critical synchronize_irq() bugfix: if a driver frees an 
   interrupt that is still being probed then synchronize_irq() locks up.
   This bug has caused a spurious boot-lockup on one of my testsystems,
   ifconfig would lock up trying to close eth0.

 - remove duplicate definitions from asm-i386/system.h, this fixes 
   compiler warnings.

