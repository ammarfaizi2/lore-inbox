Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318237AbSGWX0L>; Tue, 23 Jul 2002 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318238AbSGWX0L>; Tue, 23 Jul 2002 19:26:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46802 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318237AbSGWX0G>;
	Tue, 23 Jul 2002 19:26:06 -0400
Date: Wed, 24 Jul 2002 01:28:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: george anzinger <george@mvista.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] irqlock patch -G3. [was Re: odd memory corruption in 2.5.27?]
In-Reply-To: <3D3DBD4B.4EFD3543@mvista.com>
Message-ID: <Pine.LNX.4.44.0207240100150.2732-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, george anzinger wrote:

> I just spent a month tracking down this issue.  It comes
> down to the slab allocater using per cpu data structures and
> protecting them with a combination of interrupt disables and
> spin_locks.  Preemption is allowed (incorrectly) if
> interrupts are off and preempt_count goes to zero on the
> spin_unlock. [...]

> The proposed fix is to catch the attempted preemption in
> preempt_schedule() and just return if the interrupt system
> is off. [...]

this is most definitely not the correct fix ...

i'm quite convinced that the fix is to avoid illegal preemption, not to
work it around.

i've written debugging code that caught and reported this slab.c bug
within minutes. The code detects the irqs-off condition in schedule(). You
can find it my latest irqlock patchset, at:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-G3

it fixes this and other related bugs as well.

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

