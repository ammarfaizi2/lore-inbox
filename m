Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUFVQcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUFVQcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUFVP2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:28:35 -0400
Received: from holomorphy.com ([207.189.100.168]:42627 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264058AbUFVPRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:55 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [17/23] x86-64 profiling cleanups
Message-ID: <0406220817.3a4aYaIbIb2aZa4a2aMbZaKbKbJbXa4aMb5a0aXa2aXaYa2a4aLbLbYaYaYa2aIb15250@holomorphy.com>
In-Reply-To: <0406220817.KbYaMbLb4a2aJb3a0aMb0a0aLbLbMbZaYaKbHb0aMbIb1a2a4aIb3aXaKb1a5aLb15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert x86-64 to use profiling_on() and profile_tick().

Index: prof-2.6.7/include/asm-x86_64/hw_irq.h
===================================================================
--- prof-2.6.7.orig/include/asm-x86_64/hw_irq.h	2004-06-15 22:20:04.000000000 -0700
+++ prof-2.6.7/include/asm-x86_64/hw_irq.h	2004-06-22 07:25:57.557413112 -0700
@@ -130,36 +130,15 @@
 
 static inline void x86_do_profile (struct pt_regs *regs) 
 {
-	unsigned long rip;
 	extern unsigned long prof_cpu_mask;
-	extern char _stext[];
  
-	profile_hook(regs);
-
-	if (user_mode(regs))
-		return;
-	if (!prof_buffer)
-		return;
-
-	rip = regs->rip;
-
 	/*
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
 	 */
-	if (!((1<<smp_processor_id()) & prof_cpu_mask))
-		return;
-
-	rip -= (unsigned long) &_stext;
-	rip >>= prof_shift;
-	/*
-	 * Don't ignore out-of-bounds EIP values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (rip > prof_len-1)
-		rip = prof_len-1;
-	atomic_inc((atomic_t *)&prof_buffer[rip]);
+	profile_hook(regs);
+	if (!user_mode(regs) && ((1<<smp_processor_id()) & prof_cpu_mask))
+		profile_tick(regs->rip);
 }
 
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
