Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbVIAWxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbVIAWxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbVIAWxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:53:30 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:36624 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030496AbVIAWxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:53:23 -0400
Message-Id: <200509012216.j81MGxtG011530@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/12] UML - System call path cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:16:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This merges two sets of files which had no business being split apart in the
first place.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13/arch/um/include/syscall.h
===================================================================
--- linux-2.6.13.orig/arch/um/include/syscall.h	2005-08-31 04:29:26.191951656 -0400
+++ linux-2.6.13/arch/um/include/syscall.h	2005-08-30 19:36:48.000000000 -0400
@@ -0,0 +1,12 @@
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSCALL_USER_H
+#define __SYSCALL_USER_H
+
+extern int record_syscall_start(int syscall);
+extern void record_syscall_end(int index, long result);
+
+#endif
Index: linux-2.6.13/arch/um/include/syscall_user.h
===================================================================
--- linux-2.6.13.orig/arch/um/include/syscall_user.h	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/include/syscall_user.h	2005-08-31 04:29:26.191951656 -0400
@@ -1,23 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSCALL_USER_H
-#define __SYSCALL_USER_H
-
-extern int record_syscall_start(int syscall);
-extern void record_syscall_end(int index, long result);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.13/arch/um/include/sysdep-i386/syscalls.h
===================================================================
--- linux-2.6.13.orig/arch/um/include/sysdep-i386/syscalls.h	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/include/sysdep-i386/syscalls.h	2005-08-30 19:36:27.000000000 -0400
@@ -16,6 +16,8 @@
 
 extern syscall_handler_t old_mmap_i386;
 
+extern syscall_handler_t *sys_call_table[];
+
 #define EXECUTE_SYSCALL(syscall, regs) \
 	((long (*)(struct syscall_args)) (*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
 
Index: linux-2.6.13/arch/um/include/sysdep-x86_64/syscalls.h
===================================================================
--- linux-2.6.13.orig/arch/um/include/sysdep-x86_64/syscalls.h	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/include/sysdep-x86_64/syscalls.h	2005-08-30 19:36:27.000000000 -0400
@@ -14,6 +14,8 @@
 
 extern syscall_handler_t *ia32_sys_call_table[];
 
+extern syscall_handler_t *sys_call_table[];
+
 #define EXECUTE_SYSCALL(syscall, regs) \
 	(((long (*)(long, long, long, long, long, long)) \
 	  (*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
Index: linux-2.6.13/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/Makefile	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/Makefile	2005-08-30 20:08:47.000000000 -0400
@@ -18,7 +18,7 @@
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_TTY_LOG)	+= tty_log.o
-obj-$(CONFIG_SYSCALL_DEBUG) += syscall_user.o
+obj-$(CONFIG_SYSCALL_DEBUG) += syscall.o
 
 obj-$(CONFIG_MODE_TT) += tt/
 obj-$(CONFIG_MODE_SKAS) += skas/
Index: linux-2.6.13/arch/um/kernel/skas/Makefile
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/skas/Makefile	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/skas/Makefile	2005-08-30 20:39:46.000000000 -0400
@@ -4,7 +4,7 @@
 #
 
 obj-y := clone.o exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
-	syscall_kern.o syscall_user.o tlb.o trap_user.o uaccess.o \
+	syscall.o tlb.o trap_user.o uaccess.o
 
 subdir- := util
 
Index: linux-2.6.13/arch/um/kernel/skas/syscall.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/skas/syscall.c	2005-08-31 04:29:26.191951656 -0400
+++ linux-2.6.13/arch/um/kernel/skas/syscall.c	2005-08-31 15:33:26.000000000 -0400
@@ -0,0 +1,50 @@
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/sys.h"
+#include "linux/ptrace.h"
+#include "asm/errno.h"
+#include "asm/unistd.h"
+#include "asm/ptrace.h"
+#include "asm/current.h"
+#include "sysdep/syscalls.h"
+#include "kern_util.h"
+#include "syscall.h"
+
+void handle_syscall(union uml_pt_regs *r)
+{
+	struct pt_regs *regs = container_of(r, struct pt_regs, regs);
+	long result;
+	int syscall;
+#ifdef UML_CONFIG_SYSCALL_DEBUG
+  	int index;
+
+  	index = record_syscall_start(UPT_SYSCALL_NR(r));
+#endif
+	syscall_trace(r, 0);
+
+	current->thread.nsyscalls++;
+	nsyscalls++;
+
+	/* This should go in the declaration of syscall, but when I do that,
+	 * strace -f -c bash -c 'ls ; ls' breaks, sometimes not tracing 
+	 * children at all, sometimes hanging when bash doesn't see the first
+	 * ls exit.
+	 * The assembly looks functionally the same to me.  This is 
+	 *     gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)
+	 * in case it's a compiler bug.
+	 */
+	syscall = UPT_SYSCALL_NR(r);
+	if((syscall >= NR_syscalls) || (syscall < 0))
+		result = -ENOSYS;
+	else result = EXECUTE_SYSCALL(syscall, regs);
+
+	REGS_SET_SYSCALL_RETURN(r->skas.regs, result);
+
+	syscall_trace(r, 1);
+#ifdef UML_CONFIG_SYSCALL_DEBUG
+  	record_syscall_end(index, result);
+#endif
+}
Index: linux-2.6.13/arch/um/kernel/skas/syscall_kern.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/skas/syscall_kern.c	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/skas/syscall_kern.c	2005-08-31 04:29:26.191951656 -0400
@@ -1,43 +0,0 @@
-/* 
- * Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
- * Licensed under the GPL
- */
-
-#include "linux/sys.h"
-#include "linux/ptrace.h"
-#include "asm/errno.h"
-#include "asm/unistd.h"
-#include "asm/ptrace.h"
-#include "asm/current.h"
-#include "sysdep/syscalls.h"
-#include "kern_util.h"
-
-extern syscall_handler_t *sys_call_table[];
-
-long execute_syscall_skas(void *r)
-{
-	struct pt_regs *regs = r;
-	long res;
-	int syscall;
-
-	current->thread.nsyscalls++;
-	nsyscalls++;
-	syscall = UPT_SYSCALL_NR(&regs->regs);
-
-	if((syscall >= NR_syscalls) || (syscall < 0))
-		res = -ENOSYS;
-	else res = EXECUTE_SYSCALL(syscall, regs);
-
-	return(res);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.13/arch/um/kernel/skas/syscall_user.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/skas/syscall_user.c	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/skas/syscall_user.c	2005-08-31 04:29:26.191951656 -0400
@@ -1,44 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdlib.h>
-#include <signal.h>
-#include "kern_util.h"
-#include "uml-config.h"
-#include "syscall_user.h"
-#include "sysdep/ptrace.h"
-#include "sysdep/sigcontext.h"
-#include "skas.h"
-
-void handle_syscall(union uml_pt_regs *regs)
-{
-	long result;
-#ifdef UML_CONFIG_SYSCALL_DEBUG
-  	int index;
-
-  	index = record_syscall_start(UPT_SYSCALL_NR(regs));
-#endif
-
-	syscall_trace(regs, 0);
-	result = execute_syscall_skas(regs);
-
-	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
-
-	syscall_trace(regs, 1);
-#ifdef UML_CONFIG_SYSCALL_DEBUG
-  	record_syscall_end(index, result);
-#endif
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.13/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/syscall.c	2005-08-31 04:29:26.191951656 -0400
+++ linux-2.6.13/arch/um/kernel/syscall.c	2005-08-30 20:10:07.000000000 -0400
@@ -0,0 +1,36 @@
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "kern_util.h"
+#include "syscall.h"
+#include "os.h"
+
+struct {
+	int syscall;
+	int pid;
+	long result;
+	unsigned long long start;
+	unsigned long long end;
+} syscall_record[1024];
+
+int record_syscall_start(int syscall)
+{
+	int max, index;
+
+	max = sizeof(syscall_record)/sizeof(syscall_record[0]);
+	index = next_syscall_index(max);
+
+	syscall_record[index].syscall = syscall;
+	syscall_record[index].pid = current_pid();
+	syscall_record[index].result = 0xdeadbeef;
+	syscall_record[index].start = os_usecs();
+	return(index);
+}
+
+void record_syscall_end(int index, long result)
+{
+	syscall_record[index].result = result;
+	syscall_record[index].end = os_usecs();
+}
Index: linux-2.6.13/arch/um/kernel/syscall_user.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/syscall_user.c	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/syscall_user.c	2005-08-31 04:29:26.191951656 -0400
@@ -1,48 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdlib.h>
-#include <sys/time.h>
-#include "kern_util.h"
-#include "syscall_user.h"
-
-struct {
-	int syscall;
-	int pid;
-	long result;
-	struct timeval start;
-	struct timeval end;
-} syscall_record[1024];
-
-int record_syscall_start(int syscall)
-{
-	int max, index;
-
-	max = sizeof(syscall_record)/sizeof(syscall_record[0]);
-	index = next_syscall_index(max);
-
-	syscall_record[index].syscall = syscall;
-	syscall_record[index].pid = current_pid();
-	syscall_record[index].result = 0xdeadbeef;
-	gettimeofday(&syscall_record[index].start, NULL);
-	return(index);
-}
-
-void record_syscall_end(int index, long result)
-{
-	syscall_record[index].result = result;
-	gettimeofday(&syscall_record[index].end, NULL);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.13/arch/um/kernel/tt/syscall_kern.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/tt/syscall_kern.c	2005-08-31 15:49:21.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/tt/syscall_kern.c	2005-08-31 15:50:01.000000000 -0400
@@ -12,36 +12,41 @@
 #include "asm/uaccess.h"
 #include "asm/stat.h"
 #include "sysdep/syscalls.h"
+#include "sysdep/sigcontext.h"
 #include "kern_util.h"
+#include "syscall.h"
 
-extern syscall_handler_t *sys_call_table[];
-
-long execute_syscall_tt(void *r)
+void syscall_handler_tt(int sig, struct pt_regs *regs)
 {
-	struct pt_regs *regs = r;
-	long res;
+	void *sc;
+	long result;
 	int syscall;
-
 #ifdef CONFIG_SYSCALL_DEBUG
+	int index;
+  	index = record_syscall_start(syscall);
+#endif
+	sc = UPT_SC(&regs->regs);
+	SC_START_SYSCALL(sc);
+
+	syscall_trace(&regs->regs, 0);
+
 	current->thread.nsyscalls++;
 	nsyscalls++;
-#endif
 	syscall = UPT_SYSCALL_NR(&regs->regs);
 
 	if((syscall >= NR_syscalls) || (syscall < 0))
-		res = -ENOSYS;
-	else res = EXECUTE_SYSCALL(syscall, regs);
+		result = -ENOSYS;
+	else result = EXECUTE_SYSCALL(syscall, regs);
 
-	return(res);
-}
+	/* regs->sc may have changed while the system call ran (there may
+	 * have been an interrupt or segfault), so it needs to be refreshed.
+	 */
+	UPT_SC(&regs->regs) = sc;
+
+	SC_SET_SYSCALL_RETURN(sc, result);
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+	syscall_trace(&regs->regs, 1);
+#ifdef CONFIG_SYSCALL_DEBUG
+  	record_syscall_end(index, result);
+#endif
+}
Index: linux-2.6.13/arch/um/kernel/tt/syscall_user.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/tt/syscall_user.c	2005-08-30 19:35:44.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/tt/syscall_user.c	2005-08-31 15:50:33.000000000 -0400
@@ -13,42 +13,9 @@
 #include "task.h"
 #include "user_util.h"
 #include "kern_util.h"
-#include "syscall_user.h"
+#include "syscall.h"
 #include "tt.h"
 
-
-void syscall_handler_tt(int sig, union uml_pt_regs *regs)
-{
-	void *sc;
-	long result;
-	int syscall;
-#ifdef UML_CONFIG_DEBUG_SYSCALL
-	int index;
-#endif
-
-	syscall = UPT_SYSCALL_NR(regs);
-	sc = UPT_SC(regs);
-	SC_START_SYSCALL(sc);
-
-#ifdef UML_CONFIG_DEBUG_SYSCALL
-  	index = record_syscall_start(syscall);
-#endif
-	syscall_trace(regs, 0);
-	result = execute_syscall_tt(regs);
-
-	/* regs->sc may have changed while the system call ran (there may
-	 * have been an interrupt or segfault), so it needs to be refreshed.
-	 */
-	UPT_SC(regs) = sc;
-
-	SC_SET_SYSCALL_RETURN(sc, result);
-
-	syscall_trace(regs, 1);
-#ifdef UML_CONFIG_DEBUG_SYSCALL
-  	record_syscall_end(index, result);
-#endif
-}
-
 void do_sigtrap(void *task)
 {
 	UPT_SYSCALL_NR(TASK_REGS(task)) = -1;

