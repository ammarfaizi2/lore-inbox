Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVAYRC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVAYRC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVAYRC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:02:59 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:1003 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262016AbVAYRAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:00:15 -0500
Date: Wed, 26 Jan 2005 02:00:05 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc2-mm1] mips: fix LTT for MIPS
Message-Id: <20050126020005.7a1f3673.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed LTT for MIPS.
This patch is only for 2.6.11-rc2-mm1.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/kernel/traps.c a/arch/mips/kernel/traps.c
--- a-orig/arch/mips/kernel/traps.c	Tue Jan 25 09:23:41 2005
+++ a/arch/mips/kernel/traps.c	Wed Jan 26 01:32:27 2005
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
+#include <linux/unistd.h>
 #include <linux/kallsyms.h>
 
 #include <asm/bootinfo.h>
@@ -226,7 +227,7 @@
 
 	printk("Cause : %08x\n", cause);
 
-	cause = (cause & CAUSEF_EXCCODE) >> CAUSEB_EXCCODE;
+	cause = CAUSE_EXCCODE(cause);
 	if (1 <= cause && cause <= 5)
 		printk("BadVA : %0*lx\n", field, regs->cp0_badvaddr);
 
@@ -502,7 +503,7 @@
  */
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
-	ltt_ev_trap_entry(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+	ltt_ev_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), regs->cp0_epc);
 	if (fcr31 & FPU_CSR_UNI_X) {
 		int sig;
 
@@ -642,7 +643,7 @@
 
 	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
-	ltt_ev_trap_entry(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+	ltt_ev_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), regs->cp0_epc);
 
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 
@@ -1091,8 +1092,8 @@
 	if (!user_mode(regs))
 		goto trace_syscall_end;
 
-	if (trace_get_config(&use_depth, &use_bounds, &seek_depth,
-			(void*)&lower_bound, (void*)&upper_bound) < 0)
+	if (ltt_get_trace_config(&use_depth, &use_bounds, &seek_depth,
+				 (void*)&lower_bound, (void*)&upper_bound) < 0)
 		goto trace_syscall_end;
 
 	/* Heuristic that might work:
@@ -1124,12 +1125,12 @@
 	}
 
 trace_syscall_end:
-	trace_event(LTT_EV_SYSCALL_ENTRY, &trace_syscall_event);
+	ltt_log_event(LTT_EV_SYSCALL_ENTRY, &trace_syscall_event);
 }
 
 asmlinkage void trace_real_syscall_exit(void)
 {
-        trace_event(LTT_EV_SYSCALL_EXIT, NULL);
+        ltt_log_event(LTT_EV_SYSCALL_EXIT, NULL);
 }
 
 #endif /* (CONFIG_LTT) */
diff -urN -X dontdiff a-orig/arch/mips/kernel/unaligned.c a/arch/mips/kernel/unaligned.c
--- a-orig/arch/mips/kernel/unaligned.c	Tue Jan 25 09:23:41 2005
+++ a/arch/mips/kernel/unaligned.c	Wed Jan 26 01:33:12 2005
@@ -498,7 +498,7 @@
 	mm_segment_t seg;
 	unsigned long pc;
 
-	ltt_ev_trap_entry(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+	ltt_ev_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), regs->cp0_epc);
 
 	/*
 	 * Address errors may be deliberately induced by the FPU emulator to
diff -urN -X dontdiff a-orig/arch/mips/mm/fault.c a/arch/mips/mm/fault.c
--- a-orig/arch/mips/mm/fault.c	Tue Jan 25 09:23:41 2005
+++ a/arch/mips/mm/fault.c	Wed Jan 26 01:33:48 2005
@@ -61,7 +61,7 @@
 	if (unlikely(address >= VMALLOC_START))
 		goto vmalloc_fault;
 
-	ltt_ev_trap_entry(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+	ltt_ev_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), regs->cp0_epc);
 
 	/*
 	 * If we're in an interrupt or have no user
diff -urN -X dontdiff a-orig/include/asm-mips/mipsregs.h a/include/asm-mips/mipsregs.h
--- a-orig/include/asm-mips/mipsregs.h	Sat Jan 22 10:48:03 2005
+++ a/include/asm-mips/mipsregs.h	Wed Jan 26 01:35:27 2005
@@ -369,6 +369,7 @@
  */
 #define  CAUSEB_EXCCODE		2
 #define  CAUSEF_EXCCODE		(_ULCAST_(31)  <<  2)
+#define  CAUSE_EXCCODE(cause)	(((cause) & CAUSEF_EXCCODE) >> CAUSEB_EXCCODE)
 #define  CAUSEB_IP		8
 #define  CAUSEF_IP		(_ULCAST_(255) <<  8)
 #define  CAUSEB_IP0		8
