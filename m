Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUFVQ0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUFVQ0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264914AbUFVP2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:28:55 -0400
Received: from holomorphy.com ([207.189.100.168]:41091 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264913AbUFVPRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:36 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [16/23] s390 profiling cleanups
Message-ID: <0406220817.KbYaMbLb4a2aJb3a0aMb0a0aLbLbMbZaYaKbHb0aMbIb1a2a4aIb3aXaKb1a5aLb15250@holomorphy.com>
In-Reply-To: <0406220817.4aZa4aMbJbZaLbHbJbIbKb5aYa1aHbZa2a1a1aHb4a2aWaJb2aKb4aKbIbXa4a2a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert S/390 to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/s390/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/s390/kernel/time.c	2004-06-15 22:18:38.000000000 -0700
+++ prof-2.6.7/arch/s390/kernel/time.c	2004-06-22 07:25:56.691544744 -0700
@@ -190,36 +190,16 @@
  */
 static inline void s390_do_profile(struct pt_regs * regs)
 {
-	unsigned long eip;
 	extern cpumask_t prof_cpu_mask;
 
 	profile_hook(regs);
 
-	if (user_mode(regs))
-		return;
-
-	if (!prof_buffer)
-		return;
-
-	eip = instruction_pointer(regs);
-
 	/*
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
 	 */
-	if (!cpu_isset(smp_processor_id(), prof_cpu_mask))
-		return;
-
-	eip -= (unsigned long) &_stext;
-	eip >>= prof_shift;
-	/*
-	 * Don't ignore out-of-bounds EIP values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (eip > prof_len-1)
-		eip = prof_len-1;
-	atomic_inc((atomic_t *)&prof_buffer[eip]);
+	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
+		profile_tick(instruction_pointer(regs));
 }
 #else
 #define s390_do_profile(regs)  do { ; } while(0)
