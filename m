Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbULWFix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbULWFix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 00:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbULWFix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 00:38:53 -0500
Received: from siaag2ag.compuserve.com ([149.174.40.140]:44470 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S261163AbULWFit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 00:38:49 -0500
Date: Thu, 23 Dec 2004 00:36:51 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH 2.6.x] Faster i386 SMP timer interrupts
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Message-ID: <200412230038_MC3-1-918E-5196@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using this one for a while now.  It fixes the slow user_mode()
macro in ptrace.h, adds likely/unlikely to the timer interrupt code and
reorders two lines of code to take advantage of recently-used values.

Saves about 20-30 CPU clocks per interrupt and uses less stack space.

# i386_smp_timer_speedup_2.patch
#       include/asm-i386/ptrace.h -1 +1
#       arch/i386/kernel/apic.c -5 +5
#
#       Speed up i386 SMP timer interrupt.
#
#       Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
#
--- 2.6.9.1/include/asm-i386/ptrace.h
+++ 2.6.9.2/include/asm-i386/ptrace.h
@@ -55,7 +55,7 @@ struct pt_regs {
 #define PTRACE_SET_THREAD_AREA    26
 
 #ifdef __KERNEL__
-#define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
+#define user_mode(regs) !!((VM_MASK & (regs)->eflags) | (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
--- 2.6.9.1/arch/i386/kernel/apic.c
+++ 2.6.9.2/arch/i386/kernel/apic.c
@@ -1082,7 +1082,7 @@ inline void smp_local_timer_interrupt(st
        int cpu = smp_processor_id();
 
        profile_tick(CPU_PROFILING, regs);
-       if (--per_cpu(prof_counter, cpu) <= 0) {
+       if (likely(--per_cpu(prof_counter, cpu) <= 0)) {
                /*
                 * The multiplier may have changed since the last time we got
                 * to this point as a result of the user writing to
@@ -1092,13 +1092,13 @@ inline void smp_local_timer_interrupt(st
                 * Interrupts are already masked off at this point.
                 */
                per_cpu(prof_counter, cpu) = per_cpu(prof_multiplier, cpu);
-               if (per_cpu(prof_counter, cpu) !=
-                                       per_cpu(prof_old_multiplier, cpu)) {
+               if (unlikely(per_cpu(prof_counter, cpu) !=
+                                       per_cpu(prof_old_multiplier, cpu))) {
+                       per_cpu(prof_old_multiplier, cpu) =
+                                               per_cpu(prof_counter, cpu);
                        __setup_APIC_LVTT(
                                        calibration_result/
                                        per_cpu(prof_counter, cpu));
-                       per_cpu(prof_old_multiplier, cpu) =
-                                               per_cpu(prof_counter, cpu);
                }
 
 #ifdef CONFIG_SMP
--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
