Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUFVQMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUFVQMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUFVP3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:29:13 -0400
Received: from holomorphy.com ([207.189.100.168]:40067 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264896AbUFVPRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:35 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [12/23] ppc64 profiling cleanups
Message-ID: <0406220817.YaIbJb2a2aYaIbZaJbKb3a1a0aZaXa0aIb0aLbIbLbKbZa4aYa5aYaWaXa4a4aHb15250@holomorphy.com>
In-Reply-To: <0406220817.3a5aKbLb3aXa0aYa0aKb4aMbYaIbKbIb3aMb0aLbLbJbKb1aYaJbKbXa5a3a0a5a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ppc64 to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/ppc64/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/ppc64/kernel/time.c	2004-06-15 22:20:03.000000000 -0700
+++ prof-2.6.7/arch/ppc64/kernel/time.c	2004-06-22 07:25:53.213073552 -0700
@@ -112,36 +112,16 @@
  */
 static inline void ppc64_do_profile(struct pt_regs *regs)
 {
-	unsigned long nip;
 	extern unsigned long prof_cpu_mask;
 
 	profile_hook(regs);
 
-	if (user_mode(regs))
-		return;
-
-	if (!prof_buffer)
-		return;
-
-	nip = instruction_pointer(regs);
-
 	/*
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
 	 */
-	if (!((1<<smp_processor_id()) & prof_cpu_mask))
-		return;
-
-	nip -= (unsigned long)_stext;
-	nip >>= prof_shift;
-	/*
-	 * Don't ignore out-of-bounds EIP values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (nip > prof_len-1)
-		nip = prof_len-1;
-	atomic_inc((atomic_t *)&prof_buffer[nip]);
+	if (!user_mode(regs) && ((1<<smp_processor_id()) & prof_cpu_mask))
+		profile_tick(instruction_pointer(regs));
 }
 
 static __inline__ void timer_check_rtc(void)
