Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSGXLpe>; Wed, 24 Jul 2002 07:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSGXLpe>; Wed, 24 Jul 2002 07:45:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3973 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316961AbSGXLpd>;
	Wed, 24 Jul 2002 07:45:33 -0400
Date: Wed, 24 Jul 2002 13:47:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] irqlock patch 2.5.27-H4
Message-ID: <Pine.LNX.4.44.0207241344160.14551-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the latest irqlock patch can be found at:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-H4

Changes in -H4:

 - fix the cli()/sti() hack in ide/main.c, per Marcin Dalecki's
   suggestion. [this leaves the tty layer as the only remaining subsystem
   that still has cli()/sti() related hacks.]

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

