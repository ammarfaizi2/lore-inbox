Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVEAVMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVEAVMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVEAVMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:12:43 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:17171 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262674AbVEAVMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:12:35 -0400
Message-Id: <200505012107.j41L7ClW016334@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - compile fix for -mm
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:07:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for -mm only.  It should probably be included in git-audit, and
should be forwarded to Linus iff git-audit is.

It updates the audit-syscall-{entry,exit} calls to current -mm.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/ptrace.c	2005-05-01 15:09:36.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/ptrace.c	2005-05-01 15:30:41.000000000 -0400
@@ -337,15 +337,18 @@
 
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
-			audit_syscall_entry(current, 
-					    UPT_SYSCALL_NR(&regs->regs),
-					    UPT_SYSCALL_ARG1(&regs->regs),
-					    UPT_SYSCALL_ARG2(&regs->regs),
-					    UPT_SYSCALL_ARG3(&regs->regs),
-					    UPT_SYSCALL_ARG4(&regs->regs));
-		else
-			audit_syscall_exit(current, 
-					   UPT_SYSCALL_RET(&regs->regs));
+			audit_syscall_entry(current,
+                                            HOST_AUDIT_ARCH,
+					    UPT_SYSCALL_NR(regs),
+					    UPT_SYSCALL_ARG1(regs),
+					    UPT_SYSCALL_ARG2(regs),
+					    UPT_SYSCALL_ARG3(regs),
+					    UPT_SYSCALL_ARG4(regs));
+		else {
+                        int res = UPT_SYSCALL_RET(regs);
+			audit_syscall_exit(current, AUDITSC_RESULT(res), 
+                                           res);
+                }
 	}
 
 	/* Fake a debug trap */
Index: linux-2.6.11-mm/include/asm-um/ptrace-i386.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/ptrace-i386.h	2005-03-02 02:38:12.000000000 -0500
+++ linux-2.6.11-mm/include/asm-um/ptrace-i386.h	2005-05-01 15:27:23.000000000 -0400
@@ -6,6 +6,8 @@
 #ifndef __UM_PTRACE_I386_H
 #define __UM_PTRACE_I386_H
 
+#define HOST_AUDIT_ARCH AUDIT_ARCH_I386
+
 #include "sysdep/ptrace.h"
 #include "asm/ptrace-generic.h"
 
Index: linux-2.6.11-mm/include/asm-um/ptrace-x86_64.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/ptrace-x86_64.h	2005-03-02 02:38:26.000000000 -0500
+++ linux-2.6.11-mm/include/asm-um/ptrace-x86_64.h	2005-05-01 15:29:35.000000000 -0400
@@ -14,6 +14,8 @@
 #include "asm/ptrace-generic.h"
 #undef signal_fault
 
+#define HOST_AUDIT_ARCH AUDIT_ARCH_X86_64
+
 void signal_fault(struct pt_regs_subarch *regs, void *frame, char *where);
 
 #define FS_BASE (21 * sizeof(unsigned long))
Index: linux-2.6.11-mm/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.11-mm.orig/include/asm-um/thread_info.h	2005-05-01 11:37:41.000000000 -0400
+++ linux-2.6.11-mm/include/asm-um/thread_info.h	2005-05-01 15:38:49.000000000 -0400
@@ -72,12 +72,14 @@
 					 */
 #define TIF_RESTART_BLOCK 	4
 #define TIF_MEMDIE	 	5
+#define TIF_SYSCALL_AUDIT	6
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG     (1 << TIF_POLLING_NRFLAG)
-#define _TIF_RESTART_BLOCK	(1 << TIF_RESTART_BLOCK)
+#define _TIF_MEMDIE		(1 << TIF_MEMDIE)
+#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 
 #endif
 
Index: linux-2.6.11-mm/init/Kconfig
===================================================================
--- linux-2.6.11-mm.orig/init/Kconfig	2005-05-01 11:37:42.000000000 -0400
+++ linux-2.6.11-mm/init/Kconfig	2005-05-01 15:18:39.000000000 -0400
@@ -191,7 +191,7 @@
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC64 || ARCH_S390 || IA64)
+	depends on AUDIT && (X86 || PPC64 || ARCH_S390 || IA64 || UML)
 	default y if SECURITY_SELINUX
 	help
 	  Enable low-overhead system-call auditing infrastructure that

