Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSFQOuT>; Mon, 17 Jun 2002 10:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSFQOuS>; Mon, 17 Jun 2002 10:50:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38065 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S314138AbSFQOuS>;
	Mon, 17 Jun 2002 10:50:18 -0400
Date: Mon, 17 Jun 2002 16:48:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] cli() preemption fix, 2.5.22
Message-ID: <Pine.LNX.4.44.0206171643200.15396-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch should fix a bug in __global_cli(). One failure
scenario: if irqs-enabled syscall-level code calls cli() then we might get
a preemption right after the 'cpu' assignment, but before the __cli(). The
task might be moved to another CPU, and from that point on evil things
might happen, get_irqlock() will do wild things if 'cpu' is not the
current one. This is a one-instruction race but should be well possible to
trigger. Comments?

	Ingo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.509   -> 1.510  
#	arch/i386/kernel/irq.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/17	mingo@elte.hu	1.510
# - fix preemption bug in cli().
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Mon Jun 17 16:43:08 2002
+++ b/arch/i386/kernel/irq.c	Mon Jun 17 16:43:08 2002
@@ -356,8 +356,9 @@
 
 	__save_flags(flags);
 	if (flags & (1 << EFLAGS_IF_SHIFT)) {
-		int cpu = smp_processor_id();
+		int cpu;
 		__cli();
+		cpu = smp_processor_id();
 		if (!local_irq_count(cpu))
 			get_irqlock(cpu);
 	}

