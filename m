Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVCGSLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVCGSLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVCGSJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:09:34 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:64260 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261206AbVCGSIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:08:14 -0500
Message-Id: <200503072038.j27KcKbc003983@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/16] UML - Clean up the syscall path
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:38:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some useless code from the system call path, and
removes some debug code, which will reappear in a configurable form in
the syscall-debug patch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/Makefile	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/Makefile	2005-03-05 12:14:17.000000000 -0500
@@ -10,9 +10,9 @@
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
 	physmem.o process.o process_kern.o ptrace.o reboot.o resource.o \
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
-	syscall_kern.o syscall_user.o sysrq.o sys_call_table.o tempfile.o \
-	time.o time_kern.o tlb.o trap_kern.o trap_user.o uaccess_user.o \
-	um_arch.o umid.o user_util.o
+	syscall_kern.o sysrq.o sys_call_table.o tempfile.o time.o time_kern.o \
+	tlb.o trap_kern.o trap_user.o uaccess_user.o um_arch.o umid.o \
+	user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
Index: linux-2.6.11/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/include/skas.h	2005-03-05 12:07:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/include/skas.h	2005-03-05 12:14:58.000000000 -0500
@@ -30,6 +30,7 @@
 extern void user_signal(int sig, union uml_pt_regs *regs);
 extern int new_mm(int from);
 extern void start_userspace(int cpu);
+extern long execute_syscall_skas(void *r);
 
 #endif
 
Index: linux-2.6.11/arch/um/kernel/skas/syscall_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/syscall_user.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/syscall_user.c	2005-03-05 12:14:17.000000000 -0500
@@ -9,22 +9,18 @@
 #include "syscall_user.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
-
+#include "skas.h"
 
 void handle_syscall(union uml_pt_regs *regs)
 {
 	long result;
-	int index;
-
-	index = record_syscall_start(UPT_SYSCALL_NR(regs));
 
 	syscall_trace(regs, 0);
-	result = execute_syscall(regs);
+	result = execute_syscall_skas(regs);
 
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
 
 	syscall_trace(regs, 1);
-	record_syscall_end(index, result);
 }
 
 /*
Index: linux-2.6.11/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/syscall_kern.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/syscall_kern.c	2005-03-05 12:14:17.000000000 -0500
@@ -154,27 +154,6 @@
 	return error;
 }
 
-long execute_syscall(void *r)
-{
-	return(CHOOSE_MODE_PROC(execute_syscall_tt, execute_syscall_skas, r));
-}
-
-DEFINE_SPINLOCK(syscall_lock);
-
-static int syscall_index = 0;
-
-int next_syscall_index(int limit)
-{
-	int ret;
-
-	spin_lock(&syscall_lock);
-	ret = syscall_index;
-	if(++syscall_index == limit)
-		syscall_index = 0;
-	spin_unlock(&syscall_lock);
-	return(ret);
-}
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.11/arch/um/kernel/tt/include/tt.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/include/tt.h	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/include/tt.h	2005-03-05 12:14:17.000000000 -0500
@@ -30,6 +30,7 @@
 extern void do_sigtrap(void *task);
 extern int is_valid_pid(int pid);
 extern void remap_data(void *segment_start, void *segment_end, int w);
+extern long execute_syscall_tt(void *r);
 
 #endif
 
Index: linux-2.6.11/arch/um/kernel/tt/syscall_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/syscall_user.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/syscall_user.c	2005-03-05 12:14:17.000000000 -0500
@@ -22,15 +22,14 @@
 {
 	void *sc;
 	long result;
-	int index, syscall;
+	int syscall;
 
 	syscall = UPT_SYSCALL_NR(regs);
 	sc = UPT_SC(regs);
 	SC_START_SYSCALL(sc);
 
-	index = record_syscall_start(syscall);
 	syscall_trace(regs, 0);
-	result = execute_syscall(regs);
+	result = execute_syscall_tt(regs);
 
 	/* regs->sc may have changed while the system call ran (there may
 	 * have been an interrupt or segfault), so it needs to be refreshed.
@@ -40,7 +39,6 @@
 	SC_SET_SYSCALL_RETURN(sc, result);
 
 	syscall_trace(regs, 1);
-	record_syscall_end(index, result);
 }
 
 void do_sigtrap(void *task)
Index: linux-2.6.11/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/tracer.c	2005-03-05 12:07:34.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/tracer.c	2005-03-05 12:14:17.000000000 -0500
@@ -184,9 +184,8 @@
 int tracer(int (*init_proc)(void *), void *sp)
 {
 	void *task = NULL;
-	unsigned long eip = 0;
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
-	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
+	int proc_id = 0, n, err, old_tracing = 0, strace = 0;
 	int local_using_sysemu = 0;
 
 	signal(SIGPIPE, SIG_IGN);
@@ -279,22 +278,6 @@
 		else if(WIFSTOPPED(status)){
 			proc_id = pid_to_processor_id(pid);
 			sig = WSTOPSIG(status);
-			if(signal_index[proc_id] == 1024){
-				signal_index[proc_id] = 0;
-				last_index = 1023;
-			}
-			else last_index = signal_index[proc_id] - 1;
-			if(((sig == SIGPROF) || (sig == SIGVTALRM) || 
-			    (sig == SIGALRM)) &&
-			   (signal_record[proc_id][last_index].signal == sig)&&
-			   (signal_record[proc_id][last_index].pid == pid))
-				signal_index[proc_id] = last_index;
-			signal_record[proc_id][signal_index[proc_id]].pid = pid;
-			gettimeofday(&signal_record[proc_id][signal_index[proc_id]].time, NULL);
-			eip = ptrace(PTRACE_PEEKUSER, pid, PT_IP_OFFSET, 0);
-			signal_record[proc_id][signal_index[proc_id]].addr = eip;
-			signal_record[proc_id][signal_index[proc_id]++].signal = sig;
-			
 			if(proc_id == -1){
 				sleeping_process_signal(pid, sig);
 				continue;

