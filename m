Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUFVQcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUFVQcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUFVP2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:28:24 -0400
Received: from holomorphy.com ([207.189.100.168]:42883 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264492AbUFVPRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:55 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [18/23] i386 profiling cleanups
Message-ID: <0406220817.XaMb3a0aXaZa4a1a1aXaMbZaZaMbWaLbJbMbXaYaXaKbXaKb4a3a3a4a1aIbKb1a15250@holomorphy.com>
In-Reply-To: <0406220817.3a4aYaIbIb2aZa4a2aMbZaKbKbJbXa4aMb5a0aXa2aXaYa2a4aLbLbYaYaYa2aIb15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert i386 to use profiling_on() and profile_tick().

Index: prof-2.6.7/include/asm-i386/hw_irq.h
===================================================================
--- prof-2.6.7.orig/include/asm-i386/hw_irq.h	2004-06-15 22:20:25.000000000 -0700
+++ prof-2.6.7/include/asm-i386/hw_irq.h	2004-06-22 07:25:58.418282240 -0700
@@ -16,7 +16,6 @@
 #include <linux/profile.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
-#include <asm/sections.h>
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
@@ -76,36 +75,15 @@
  */
 static inline void x86_do_profile(struct pt_regs * regs)
 {
-	unsigned long eip;
 	extern unsigned long prof_cpu_mask;
  
-	profile_hook(regs);
- 
-	if (user_mode(regs))
-		return;
- 
-	if (!prof_buffer)
-		return;
-
-	eip = regs->eip;
- 
 	/*
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
 	 */
-	if (!((1<<smp_processor_id()) & prof_cpu_mask))
-		return;
-
-	eip -= (unsigned long)_stext;
-	eip >>= prof_shift;
-	/*
-	 * Don't ignore out-of-bounds EIP values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (eip > prof_len-1)
-		eip = prof_len-1;
-	atomic_inc((atomic_t *)&prof_buffer[eip]);
+	profile_hook(regs);
+	if (!user_mode(regs) && ((1<<smp_processor_id()) & prof_cpu_mask))
+		profile_tick(regs->eip);
 }
  
 #if defined(CONFIG_X86_IO_APIC)
