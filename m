Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbUKLX4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbUKLX4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUKLXx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:53:58 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:25092
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262724AbUKLXsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:48:24 -0500
Message-Id: <200411130200.iAD20ppT005864@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/11] - UML - redundant code removal from signal delivery
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:00:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - Change the do_signal interface to eliminate its
argument.  Also, remove the calls from the system call handlers since
they are redundant.  In all cases, pending signals are checked for in
the interrupt handler.
Temporarily, do_signal passes the current error to kern_do_signal.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/include/kern_util.h
===================================================================
--- 2.6.9.orig/arch/um/include/kern_util.h	2004-11-12 13:33:26.000000000 -0500
+++ 2.6.9/arch/um/include/kern_util.h	2004-11-12 13:41:43.000000000 -0500
@@ -29,7 +29,7 @@
 extern void syscall_segv(int sig);
 extern int current_pid(void);
 extern unsigned long alloc_stack(int order, int atomic);
-extern int do_signal(int error);
+extern int do_signal(void);
 extern int is_stack_fault(unsigned long sp);
 extern unsigned long segv(unsigned long address, unsigned long ip, 
 			  int is_write, int is_user, void *sc);
Index: 2.6.9/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/process_kern.c	2004-11-12 13:33:26.000000000 -0500
+++ 2.6.9/arch/um/kernel/process_kern.c	2004-11-12 13:41:43.000000000 -0500
@@ -141,7 +141,7 @@
 void interrupt_end(void)
 {
 	if(need_resched()) schedule();
-	if(test_tsk_thread_flag(current, TIF_SIGPENDING)) do_signal(0);
+	if(test_tsk_thread_flag(current, TIF_SIGPENDING)) do_signal();
 }
 
 void release_thread(struct task_struct *task)
Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 13:31:46.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 18:05:29.000000000 -0500
@@ -159,9 +159,10 @@
 	return(0);
 }
 
-int do_signal(int error)
+int do_signal(void)
 {
-	return(kern_do_signal(&current->thread.regs, NULL, error));
+	return(kern_do_signal(&current->thread.regs, NULL, 
+			      PT_REGS_SYSCALL_RET(&current->thread.regs)));
 }
 
 /*
Index: 2.6.9/arch/um/kernel/skas/syscall_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/syscall_user.c	2004-11-12 13:24:54.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/syscall_user.c	2004-11-12 13:41:43.000000000 -0500
@@ -10,10 +10,6 @@
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
 
-/* XXX Bogus */
-#define ERESTARTSYS	512
-#define ERESTARTNOINTR	513
-#define ERESTARTNOHAND	514
 
 void handle_syscall(union uml_pt_regs *regs)
 {
@@ -26,9 +22,6 @@
 	result = execute_syscall(regs);
 
 	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);
-	if((result == -ERESTARTNOHAND) || (result == -ERESTARTSYS) || 
-	   (result == -ERESTARTNOINTR))
-		do_signal(result);
 
 	syscall_trace(regs, 1);
 	record_syscall_end(index, result);
Index: 2.6.9/arch/um/kernel/tt/syscall_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/syscall_user.c	2004-11-12 13:34:34.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/syscall_user.c	2004-11-12 13:41:43.000000000 -0500
@@ -17,10 +17,6 @@
 #include "syscall_user.h"
 #include "tt.h"
 
-/* XXX Bogus */
-#define ERESTARTSYS	512
-#define ERESTARTNOINTR	513
-#define ERESTARTNOHAND	514
 
 void syscall_handler_tt(int sig, union uml_pt_regs *regs)
 {
@@ -42,9 +38,6 @@
 	UPT_SC(regs) = sc;
 
 	SC_SET_SYSCALL_RETURN(sc, result);
-	if((result == -ERESTARTNOHAND) || (result == -ERESTARTSYS) || 
-	   (result == -ERESTARTNOINTR))
-		do_signal(result);
 
 	syscall_trace(regs, 1);
 	record_syscall_end(index, result);

