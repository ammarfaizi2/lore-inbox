Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWADSwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWADSwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbWADSwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:52:31 -0500
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:17824 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965267AbWADSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:52:30 -0500
Date: Wed, 4 Jan 2006 13:48:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.15] i386: Optimize local APIC timer interrupt code
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200601041352_MC3-1-B550-4606@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Local APIC timer interrupt happens HZ times per second on each CPU.

Optimize it for the case where profile multiplier equals one and does
not change (99+% of cases); this saves about 20 CPU cycles on Pentium II.

Also update the old multiplier immediately after noticing it changed,
while values are register-hot, saving eight bytes of stack depth.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

diff -up 2.6.15a.orig/arch/i386/kernel/apic.c 2.6.15a/arch/i386/kernel/apic.c
--- 2.6.15a.orig/arch/i386/kernel/apic.c
+++ 2.6.15a/arch/i386/kernel/apic.c
@@ -1137,7 +1137,7 @@ inline void smp_local_timer_interrupt(st
 	int cpu = smp_processor_id();
 
 	profile_tick(CPU_PROFILING, regs);
-	if (--per_cpu(prof_counter, cpu) <= 0) {
+	if (likely(--per_cpu(prof_counter, cpu)) <= 0) {
 		/*
 		 * The multiplier may have changed since the last time we got
 		 * to this point as a result of the user writing to
@@ -1147,13 +1147,13 @@ inline void smp_local_timer_interrupt(st
 		 * Interrupts are already masked off at this point.
 		 */
 		per_cpu(prof_counter, cpu) = per_cpu(prof_multiplier, cpu);
-		if (per_cpu(prof_counter, cpu) !=
-					per_cpu(prof_old_multiplier, cpu)) {
+		if (unlikely(per_cpu(prof_counter, cpu) !=
+					per_cpu(prof_old_multiplier, cpu))) {
+			per_cpu(prof_old_multiplier, cpu) =
+						per_cpu(prof_counter, cpu);
 			__setup_APIC_LVTT(
 					calibration_result/
 					per_cpu(prof_counter, cpu));
-			per_cpu(prof_old_multiplier, cpu) =
-						per_cpu(prof_counter, cpu);
 		}
 
 #ifdef CONFIG_SMP
-- 
Chuck
