Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVAJFbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVAJFbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJFbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:31:12 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:18436
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262092AbVAJFOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:11 -0500
Message-Id: <200501100735.j0A7ZMPW005765@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/28] UML - Factor out register saving and restoring
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:22 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the register shuffling code into arch/um/os-Linux/sys-$(SUBARCH),
making it purely userspace code.  It also adds an x86_64 implementation of
registers.c.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/include/registers.h
===================================================================
--- 2.6.10.orig/arch/um/include/registers.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/include/registers.h	2004-12-14 16:00:18.000000000 -0500
@@ -0,0 +1,27 @@
+/* 
+ * Copyright (C) 2004 PathScale, Inc
+ * Licensed under the GPL
+ */
+
+#ifndef __REGISTERS_H
+#define __REGISTERS_H
+
+#include "sysdep/ptrace.h"
+
+extern void init_thread_registers(union uml_pt_regs *to);
+extern void save_registers(int pid, union uml_pt_regs *regs);
+extern void restore_registers(int pid, union uml_pt_regs *regs);
+extern void init_registers(int pid);
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/kernel/process.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/process.c	2004-12-14 12:14:46.000000000 -0500
+++ 2.6.10/arch/um/kernel/process.c	2004-12-14 16:00:18.000000000 -0500
@@ -40,6 +40,7 @@
 #ifdef UML_CONFIG_MODE_SKAS
 #include "skas.h"
 #include "skas_ptrace.h"
+#include "registers.h"
 #endif
 
 void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))
Index: 2.6.10/arch/um/kernel/skas/include/skas.h
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/include/skas.h	2004-12-14 12:10:30.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/include/skas.h	2004-12-14 16:00:18.000000000 -0500
@@ -29,10 +29,7 @@
 		   int r, int w, int x, int must_succeed);
 extern void user_signal(int sig, union uml_pt_regs *regs);
 extern int new_mm(int from);
-extern void save_registers(union uml_pt_regs *regs);
-extern void restore_registers(union uml_pt_regs *regs);
 extern void start_userspace(int cpu);
-extern void init_registers(int pid);
 
 #endif
 
Index: 2.6.10/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/process.c	2004-12-14 12:14:46.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/process.c	2004-12-14 16:00:18.000000000 -0500
@@ -28,6 +28,7 @@
 #include "skas_ptrace.h"
 #include "chan_user.h"
 #include "signal_user.h"
+#include "registers.h"
 
 int is_skas_winch(int pid, int fd, void *data)
 {
@@ -38,13 +39,6 @@
 	return(1);
 }
 
-/* These are set once at boot time and not changed thereafter */
-
-unsigned long exec_regs[FRAME_SIZE];
-unsigned long exec_fp_regs[HOST_FP_SIZE];
-unsigned long exec_fpx_regs[HOST_XFP_SIZE];
-int have_fpx_regs = 1;
-
 static void handle_segv(int pid)
 {
 	struct ptrace_faultinfo fault;
@@ -143,7 +137,7 @@
 	int err, status, op, pid = userspace_pid[0];
 	int local_using_sysemu; /*To prevent races if using_sysemu changes under us.*/
 
-	restore_registers(regs);
+	restore_registers(pid, regs);
 		
 	local_using_sysemu = get_using_sysemu();
 
@@ -160,7 +154,7 @@
 			      errno);
 
 		regs->skas.is_user = 1;
-		save_registers(regs);
+		save_registers(pid, regs);
 		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
 
 		if(WIFSTOPPED(status)){
@@ -192,7 +186,7 @@
 			PT_SYSCALL_NR(regs->skas.regs) = -1;
 		}
 
-		restore_registers(regs);
+		restore_registers(pid, regs);
 
 		/*Now we ended the syscall, so re-read local_using_sysemu.*/
 		local_using_sysemu = get_using_sysemu();
@@ -243,58 +237,6 @@
 		siglongjmp(*fork_buf, 1);
 }
 
-static int move_registers(int pid, int int_op, int fp_op,
-			  union uml_pt_regs *regs, unsigned long *fp_regs)
-{
-	if(ptrace(int_op, pid, 0, regs->skas.regs) < 0)
-		return(-errno);
-	if(ptrace(fp_op, pid, 0, fp_regs) < 0)
-		return(-errno);
-	return(0);
-}
-
-void save_registers(union uml_pt_regs *regs)
-{
-	unsigned long *fp_regs;
-	int err, fp_op;
-
-	if(have_fpx_regs){
-		fp_op = PTRACE_GETFPXREGS;
-		fp_regs = regs->skas.xfp;
-	}
-	else {
-		fp_op = PTRACE_GETFPREGS;
-		fp_regs = regs->skas.fp;
-	}
-
-	err = move_registers(userspace_pid[0], PTRACE_GETREGS, fp_op, regs,
-			     fp_regs);
-	if(err)
-		panic("save_registers - saving registers failed, errno = %d\n",
-		      -err);
-}
-
-void restore_registers(union uml_pt_regs *regs)
-{
-	unsigned long *fp_regs;
-	int err, fp_op;
-
-	if(have_fpx_regs){
-		fp_op = PTRACE_SETFPXREGS;
-		fp_regs = regs->skas.xfp;
-	}
-	else {
-		fp_op = PTRACE_SETFPREGS;
-		fp_regs = regs->skas.fp;
-	}
-
-	err = move_registers(userspace_pid[0], PTRACE_SETREGS, fp_op, regs,
-			     fp_regs);
-	if(err)
-		panic("restore_registers - saving registers failed, "
-		      "errno = %d\n", -err);
-}
-
 void switch_threads(void *me, void *next)
 {
 	sigjmp_buf my_buf, **me_ptr = me, *next_buf = next;
@@ -394,29 +336,6 @@
 	os_kill_ptraced_process(userspace_pid[0], 1);
 }
 
-void init_registers(int pid)
-{
-	int err;
-
-	if(ptrace(PTRACE_GETREGS, pid, 0, exec_regs) < 0)
-		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d", 
-		      errno);
-
-	err = ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
-	if(!err)
-		return;
-
-	have_fpx_regs = 0;
-	if(errno != EIO)
-		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d", 
-		      errno);
-
-	err = ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
-	if(err)
-		panic("check_ptrace : PTRACE_GETFPREGS failed, errno = %d", 
-		      errno);
-}
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: 2.6.10/arch/um/kernel/skas/process_kern.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/process_kern.c	2004-12-14 12:14:46.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/process_kern.c	2004-12-14 16:00:18.000000000 -0500
@@ -22,6 +22,7 @@
 #include "kern.h"
 #include "mode.h"
 #include "proc_mm.h"
+#include "registers.h"
 
 void *switch_to_skas(void *prev, void *next)
 {
@@ -118,12 +119,7 @@
 		handler = fork_handler;
 	}
 	else {
-	  	memcpy(p->thread.regs.regs.skas.regs, exec_regs, 
-		       sizeof(p->thread.regs.regs.skas.regs));
-		memcpy(p->thread.regs.regs.skas.fp, exec_fp_regs, 
-		       sizeof(p->thread.regs.regs.skas.fp));
-	  	memcpy(p->thread.regs.regs.skas.xfp, exec_fpx_regs, 
-		       sizeof(p->thread.regs.regs.skas.xfp));
+		init_thread_registers(&p->thread.regs.regs);
                 p->thread.request.u.thread = current->thread.request.u.thread;
 		handler = new_thread_handler;
 	}
Index: 2.6.10/arch/um/os-Linux/Makefile
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/Makefile	2004-12-14 12:14:46.000000000 -0500
+++ 2.6.10/arch/um/os-Linux/Makefile	2004-12-14 16:00:18.000000000 -0500
@@ -3,7 +3,8 @@
 # Licensed under the GPL
 #
 
-obj-y = elf_aux.o file.o process.o time.o tty.o user_syms.o drivers/
+obj-y = elf_aux.o file.o process.o time.o tty.o user_syms.o drivers/ \
+	sys-$(SUBARCH)/
 
 USER_OBJS := elf_aux.o file.o process.o time.o tty.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
Index: 2.6.10/arch/um/os-Linux/sys-i386/Makefile
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/sys-i386/Makefile	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/os-Linux/sys-i386/Makefile	2004-12-14 16:00:18.000000000 -0500
@@ -0,0 +1,11 @@
+# 
+# Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+# Licensed under the GPL
+#
+
+obj-$(CONFIG_MODE_SKAS) = registers.o
+
+USER_OBJS := $(foreach file,$(obj-y),$(obj)/$(file))
+
+$(USER_OBJS) : %.o: %.c
+	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
Index: 2.6.10/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/sys-i386/registers.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/os-Linux/sys-i386/registers.c	2004-12-14 16:00:18.000000000 -0500
@@ -0,0 +1,115 @@
+/* 
+ * Copyright (C) 2004 PathScale, Inc
+ * Licensed under the GPL
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <sys/ptrace.h>
+#include "sysdep/ptrace.h"
+#include "uml-config.h"
+#include "skas_ptregs.h"
+#include "registers.h"
+#include "user.h"
+
+/* These are set once at boot time and not changed thereafter */
+
+static unsigned long exec_regs[HOST_FRAME_SIZE];
+static unsigned long exec_fp_regs[HOST_FP_SIZE];
+static unsigned long exec_fpx_regs[HOST_XFP_SIZE];
+static int have_fpx_regs = 1;
+
+void init_thread_registers(union uml_pt_regs *to)
+{
+	memcpy(to->skas.regs, exec_regs, sizeof(to->skas.regs));
+	memcpy(to->skas.fp, exec_fp_regs, sizeof(to->skas.fp));
+	if(have_fpx_regs)
+		memcpy(to->skas.xfp, exec_fpx_regs, sizeof(to->skas.xfp));
+}
+
+static int move_registers(int pid, int int_op, union uml_pt_regs *regs, 
+			  int fp_op, unsigned long *fp_regs)
+{
+	if(ptrace(int_op, pid, 0, regs->skas.regs) < 0)
+		return(-errno);
+
+	if(ptrace(fp_op, pid, 0, fp_regs) < 0)
+		return(-errno);
+
+	return(0);
+}
+
+void save_registers(int pid, union uml_pt_regs *regs)
+{
+	unsigned long *fp_regs;
+	int err, fp_op;
+
+	if(have_fpx_regs){
+		fp_op = PTRACE_GETFPXREGS;
+		fp_regs = regs->skas.xfp;
+	}
+	else {
+		fp_op = PTRACE_GETFPREGS;
+		fp_regs = regs->skas.fp;
+	}
+
+	err = move_registers(pid, PTRACE_GETREGS, regs, fp_op, fp_regs);
+	if(err)
+		panic("save_registers - saving registers failed, errno = %d\n",
+		      -err);
+}
+
+void restore_registers(int pid, union uml_pt_regs *regs)
+{
+	unsigned long *fp_regs;
+	int err, fp_op;
+
+	if(have_fpx_regs){
+		fp_op = PTRACE_SETFPXREGS;
+		fp_regs = regs->skas.xfp;
+	}
+	else {
+		fp_op = PTRACE_SETFPREGS;
+		fp_regs = regs->skas.fp;
+	}
+
+	err = move_registers(pid, PTRACE_SETREGS, regs, fp_op, fp_regs);
+	if(err)
+		panic("restore_registers - saving registers failed, "
+		      "errno = %d\n", -err);
+}
+
+void init_registers(int pid)
+{
+	int err;
+
+	err = ptrace(PTRACE_GETREGS, pid, 0, exec_regs);
+	if(err)
+		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d", 
+		      err);
+
+	err = ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
+	if(!err)
+		return;
+
+	have_fpx_regs = 0;
+	if(err != EIO)
+		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d", 
+		      err);
+
+	err = ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
+	if(err)
+		panic("check_ptrace : PTRACE_GETFPREGS failed, errno = %d", 
+		      err);
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/os-Linux/sys-x86_64/Makefile
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/sys-x86_64/Makefile	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/os-Linux/sys-x86_64/Makefile	2004-12-14 16:00:18.000000000 -0500
@@ -0,0 +1,11 @@
+# 
+# Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+# Licensed under the GPL
+#
+
+obj-$(CONFIG_MODE_SKAS) = registers.o
+
+USER_OBJS := $(foreach file,$(obj-y),$(obj)/$(file))
+
+$(USER_OBJS) : %.o: %.c
+	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
Index: 2.6.10/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/sys-x86_64/registers.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/os-Linux/sys-x86_64/registers.c	2004-12-14 16:00:18.000000000 -0500
@@ -0,0 +1,82 @@
+/* 
+ * Copyright (C) 2004 PathScale, Inc
+ * Licensed under the GPL
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <sys/ptrace.h>
+#include "sysdep/ptrace.h"
+#include "uml-config.h"
+#include "skas_ptregs.h"
+#include "registers.h"
+#include "user.h"
+
+/* These are set once at boot time and not changed thereafter */
+
+static unsigned long exec_regs[HOST_FRAME_SIZE];
+static unsigned long exec_fp_regs[HOST_FP_SIZE];
+
+void init_thread_registers(union uml_pt_regs *to)
+{
+	memcpy(to->skas.regs, exec_regs, sizeof(to->skas.regs));
+	memcpy(to->skas.fp, exec_fp_regs, sizeof(to->skas.fp));
+}
+
+static int move_registers(int pid, int int_op, int fp_op,
+			  union uml_pt_regs *regs)
+{
+	if(ptrace(int_op, pid, 0, regs->skas.regs) < 0)
+		return(-errno);
+
+	if(ptrace(fp_op, pid, 0, regs->skas.fp) < 0)
+		return(-errno);
+
+	return(0);
+}
+
+void save_registers(int pid, union uml_pt_regs *regs)
+{
+	int err;
+
+	err = move_registers(pid, PTRACE_GETREGS, PTRACE_GETFPREGS, regs);
+	if(err)
+		panic("save_registers - saving registers failed, errno = %d\n",
+		      -err);
+}
+
+void restore_registers(int pid, union uml_pt_regs *regs)
+{
+	int err;
+
+	err = move_registers(pid, PTRACE_SETREGS, PTRACE_SETFPREGS, regs);
+	if(err)
+		panic("restore_registers - saving registers failed, "
+		      "errno = %d\n", -err);
+}
+
+void init_registers(int pid)
+{
+	int err;
+
+	err = ptrace(PTRACE_GETREGS, pid, 0, exec_regs);
+	if(err)
+		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d", 
+		      err);
+
+	err = ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
+	if(err)
+		panic("check_ptrace : PTRACE_GETFPREGS failed, errno = %d", 
+		      err);
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */

