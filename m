Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSGXI6D>; Wed, 24 Jul 2002 04:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSGXI6C>; Wed, 24 Jul 2002 04:58:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4756 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313628AbSGXI6B>;
	Wed, 24 Jul 2002 04:58:01 -0400
Date: Wed, 24 Jul 2002 10:59:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] irqlock patch 2.5.27-H3.
In-Reply-To: <Pine.LNX.4.44.0207231904200.6943-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207241026160.8238-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Linus Torvalds wrote:

>  you really shouldn't use a generic #define like IRQ_MASK for something as
> obscure as the mask for preemption bits (that apparently gets used
> exactly _once_ in the same header file that defines it).
> 
> That #define is already used in the kernel inside various files, and from
> the things I looked at, other users had more reason to call their stuff
> IRQ_MASK than the new code has.

(doh - and i've specifically checked the new names for namespace collision
because they looked too generic - apparently not well enough.)

> So I think you'd be better off doing
> 
> 	#define PREEMPT_BITS	8
> 	#define HARDIRQ_BITS	8
> 	#define SOFTIRQ_BITS	8
> 
> 	#define PREEMPT_SHIFT	0
> 	#define HARDIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
> 	#define SOFTIRQ_SHIFT	(HARDIRQ_SHIFT + PREEMPT_BITS)
> 
> 	#define __MASK(x)	((1UL << (x))-1)
> 
> 	#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
> 	#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
> 	#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
> 
> 	#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
> 	#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
> 	#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
> 
> which creates bitmasks from bit-operations rather than doing non-bitwise
> arithmetic to get them from magic values that have to be powers-of-2.

yeah, agreed.

i did one more modification in this area, just for educational purposes
it's a better ordering to have:

	- preempt count
	- softirq count
	- hardirq count

the higher positioned the bitmask, the 'stronger' and more atomic the
execution concept is. Latest patch (against BK-curr) is at:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-H3

Changes in -H3:

 - init thread needs to have preempt_count of 1 until sched_init(). 
   (William Lee Irwin III)

 - clean up the irq-mask macros. (Linus)

 - add barrier() to irq_enter() and irq_exit(). (based on Oleg Nesterov's
   comment.)

 - move the irqs-off check into preempt_schedule() and remove
   CONFIG_DEBUG_IRQ_SCHEDULE.

Changes in -G5:

 - remove spin_unlock_no_resched() and comment the affected places more
   agressively.

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

	Ingo


