Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUFVQ0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUFVQ0C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUFVP2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:28:44 -0400
Received: from holomorphy.com ([207.189.100.168]:40579 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264914AbUFVPRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:37 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [14/23] parisc profiling cleanups
Message-ID: <0406220817.Mb0a3aLbXa2a3a5a4aLbXa1a0aMbZaYaXaYaHb5aIbJbZaXaZaXa1a4aLb3aMb3a15250@holomorphy.com>
In-Reply-To: <0406220817.YaIb4aKb1aMbLbMbKbZaWa1aHbHbIbXaWa1aKbWaJbMbKbLbZa3aXa5a1aHbZaLb15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert PA-RISC to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/parisc/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/parisc/kernel/time.c	2004-06-15 22:20:27.000000000 -0700
+++ prof-2.6.7/arch/parisc/kernel/time.c	2004-06-22 07:25:54.908815760 -0700
@@ -54,16 +54,7 @@
 #if 0
 	extern unsigned long prof_cpu_mask;
 #endif
-	extern char _stext;
-
 	profile_hook(regs);
-
-	if (user_mode(regs))
-		return;
-
-	if (!prof_buffer)
-		return;
-
 #if 0
 	/* FIXME: when we have irq affinity to cpu, we need to
 	 * only look at the cpus specified in this mask 
@@ -72,17 +63,8 @@
 	if (!((1 << smp_processor_id()) & prof_cpu_mask))
 		return;
 #endif
-
-	pc -= (unsigned long) &_stext;
-	pc >>= prof_shift;
-	/*
-	 * Don't ignore out-of-bounds PC values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (pc > prof_len - 1)
-		pc = prof_len - 1;
-	atomic_inc((atomic_t *)&prof_buffer[pc]);
+	if (!user_mode(regs))
+		profile_tick(pc);
 }
 
 irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
