Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUFVPjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUFVPjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUFVPcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:32:47 -0400
Received: from holomorphy.com ([207.189.100.168]:34691 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264656AbUFVPQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:16:45 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [3/23] mips profiling cleanups
Message-ID: <0406220816.5aMbHbKb0a3a3a1aMbLbIb2a3a0a4aKb3a5aLb2aWaMbZa3aZaLb0a3aXa1aYa2a15250@holomorphy.com>
In-Reply-To: <0406220816.LbZaYa4aYaZaYa0a5aHb4a0a3aHb4aYaIbJb5aMbXa3a5a1aZaKbZa3aIb4aHb0a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:16:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MIPS to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/mips/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/mips/kernel/time.c	2004-06-15 22:19:22.000000000 -0700
+++ prof-2.6.7/arch/mips/kernel/time.c	2004-06-22 07:25:45.377264776 -0700
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/profile.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -417,22 +418,8 @@
  */
 void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	if (!user_mode(regs)) {
-		if (prof_buffer && current->pid) {
-			unsigned long pc = regs->cp0_epc;
-
-			pc -= (unsigned long) _stext;
-			pc >>= prof_shift;
-			/*
-			 * Dont ignore out-of-bounds pc values silently,
-			 * put them into the last histogram slot, so if
-			 * present, they will show up as a sharp peak.
-			 */
-			if (pc > prof_len - 1)
-				pc = prof_len - 1;
-			atomic_inc((atomic_t *)&prof_buffer[pc]);
-		}
-	}
+	if (!user_mode(regs) && profiling_on() && current->pid)
+		profile_tick(regs->cp0_epc);
 
 #ifdef CONFIG_SMP
 	/* in UP mode, update_process_times() is invoked by do_timer() */
