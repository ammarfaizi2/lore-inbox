Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSFQPKd>; Mon, 17 Jun 2002 11:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSFQPKc>; Mon, 17 Jun 2002 11:10:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8627 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S314433AbSFQPKb>;
	Mon, 17 Jun 2002 11:10:31 -0400
Date: Mon, 17 Jun 2002 17:01:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] sti() preemption fix, 2.5.22
Message-ID: <Pine.LNX.4.44.0206171651480.15554-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__global_sti() appears to have a similar bug as __global_cli(), but it's a
bit more complex to trigger:

if a syscall-level, irqs-enabled process does a sti() but it does not hold
the IRQ spinlock, and the process gets preempted after the 'cpu'
assignment and gets run on another CPU, and the original CPU runs another
process that does a cli() which holds the global IRQ lock, then the rest
of __global_sti() will incorrectly release the IRQ lock - possibly causing
an oops in the other process.

this too is a few instructions race but looks quite serious at first
sight.

(the fix is to disable preemption around the critical section.)

	Ingo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.510   -> 1.511  
#	arch/i386/kernel/irq.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/17	mingo@elte.hu	1.511
# - sti() preemption bugfix.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Mon Jun 17 17:00:30 2002
+++ b/arch/i386/kernel/irq.c	Mon Jun 17 17:00:30 2002
@@ -368,9 +368,11 @@
 {
 	int cpu = smp_processor_id();
 
+	preempt_disable();
 	if (!local_irq_count(cpu))
 		release_irqlock(cpu);
 	__sti();
+	preempt_enable();
 }
 
 /*

