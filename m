Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVAJFpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVAJFpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVAJFoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:44:25 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:26628
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262104AbVAJFOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:30 -0500
Message-Id: <200501100735.j0A7ZtPW005820@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 18/28] UML - 2.6.10 ptrace updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:55 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some of the 2.6.10 ptrace updates.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/ptrace.c	2005-01-09 22:38:24.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/ptrace.c	2005-01-09 22:38:28.000000000 -0500
@@ -307,6 +307,25 @@
 	return ret;
 }
 
+void send_sigtrap(struct task_struct *tsk, union uml_pt_regs *regs, 
+		  int error_code)
+{
+	struct siginfo info;
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = SIGTRAP;
+	info.si_code = TRAP_BRKPT;
+
+	/* User-mode eip? */
+	info.si_addr = UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL;
+
+	/* Send us the fakey SIGTRAP */
+	force_sig_info(SIGTRAP, &info, tsk);
+}
+
+/* XXX Check PT_DTRACE vs TIF_SINGLESTEP for singlestepping check and
+ * PT_PTRACED vs TIF_SYSCALL_TRACE for syscall tracing check
+ */
 void syscall_trace(union uml_pt_regs *regs, int entryexit)
 {
 	int is_singlestep = (current->ptrace & PT_DTRACE) && entryexit;
@@ -321,14 +340,19 @@
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_singlestep)
+	/* Fake a debug trap */
+	if (is_singlestep)
+		send_sigtrap(current, regs, 0);
+
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
+
 	if (!(current->ptrace & PT_PTRACED))
 		return;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	tracesysgood = (current->ptrace & PT_TRACESYSGOOD) && !is_singlestep;
+	tracesysgood = (current->ptrace & PT_TRACESYSGOOD);
 	ptrace_notify(SIGTRAP | (tracesysgood ? 0x80 : 0));
 
 	if (entryexit) /* force do_signal() --> is_syscall() */
Index: linux-2.6.10/include/asm-um/ptrace-generic.h
===================================================================
--- linux-2.6.10.orig/include/asm-um/ptrace-generic.h	2005-01-09 22:38:24.000000000 -0500
+++ linux-2.6.10/include/asm-um/ptrace-generic.h	2005-01-09 22:38:28.000000000 -0500
@@ -12,11 +12,13 @@
 
 #define pt_regs pt_regs_subarch
 #define show_regs show_regs_subarch
+#define send_sigtrap send_sigtrap_subarch
 
 #include "asm/arch/ptrace.h"
 
 #undef pt_regs
 #undef show_regs
+#undef send_sigtrap
 #undef user_mode
 #undef instruction_pointer
 
@@ -55,6 +57,9 @@
 
 extern void show_regs(struct pt_regs *regs);
 
+extern void send_sigtrap(struct task_struct *tsk, union uml_pt_regs *regs, 
+			 int error_code);
+
 #endif
 
 #endif

