Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSGWMTb>; Tue, 23 Jul 2002 08:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSGWMTb>; Tue, 23 Jul 2002 08:19:31 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22491 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318040AbSGWMTa>;
	Tue, 23 Jul 2002 08:19:30 -0400
Date: Tue, 23 Jul 2002 14:21:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] big IRQ lock removal, 2.5.27-F8
Message-ID: <Pine.LNX.4.44.0207231410530.8668-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the latest irqlock patch, against 2.5.27-BK-current can be found at:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-F8

the big change since -F3 is the introduction of a separate preemption,
hardirq and softirq bitrange within preempt_count:

 * PREEMPT_MASK: 0x000000ff
 * HARDIRQ_MASK: 0x0000ff00
 * SOFTIRQ_MASK: 0x00ff0000
 * IRQ_MASK:     0x00ffff00

with this it was possible to have a functional in_irq() again, so the
skbuff.c hack could be reverted.

The definition of the bitrange depends on the following base defines:

 #define NR_PREEMPT      256
 #define NR_HARDIRQ      256
 #define NR_SOFTIRQ      256

NOTE: other, non-x86 architectures might want to define a tighter
bitrange, to make the preempt-only check cheaper. On x86 the above
bitrange is the most optimal.

compiles, boots, works just fine.

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

