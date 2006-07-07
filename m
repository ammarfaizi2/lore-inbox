Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWGGAhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWGGAhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWGGAhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:37:12 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:58307 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751120AbWGGAeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:34:18 -0400
Message-Id: <200607070033.k670XbOC008682@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/19] UML - signal initialization cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that init_new_thread_signals is always called with
altstack == 1, so we can eliminate the parameter.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/os.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/os.h	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/include/os.h	2006-07-06 13:25:20.000000000 -0400
@@ -199,7 +199,7 @@ extern int os_getpid(void);
 extern int os_getpgrp(void);
 
 extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
-extern void init_new_thread_signals(int altstack);
+extern void init_new_thread_signals(void);
 extern int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr);
 
 extern int os_map_memory(void *virt, int fd, unsigned long long off,
Index: linux-2.6.17/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/skas/process_kern.c	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/skas/process_kern.c	2006-07-06 13:25:20.000000000 -0400
@@ -177,7 +177,7 @@ int start_uml_skas(void)
 	if(proc_mm)
 		userspace_pid[0] = start_userspace(0);
 
-	init_new_thread_signals(1);
+	init_new_thread_signals();
 
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;
Index: linux-2.6.17/arch/um/kernel/tt/exec_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/tt/exec_kern.c	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.17/arch/um/kernel/tt/exec_kern.c	2006-07-06 13:25:20.000000000 -0400
@@ -21,7 +21,7 @@
 static int exec_tramp(void *sig_stack)
 {
 	init_new_thread_stack(sig_stack, NULL);
-	init_new_thread_signals(1);
+	init_new_thread_signals();
 	os_stop_process(os_getpid());
 	return(0);
 }
Index: linux-2.6.17/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/tt/process_kern.c	2006-07-06 13:22:13.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/tt/process_kern.c	2006-07-06 13:25:20.000000000 -0400
@@ -142,7 +142,7 @@ static void new_thread_handler(int sig)
 		schedule_tail(current->thread.prev_sched);
 	current->thread.prev_sched = NULL;
 
-	init_new_thread_signals(1);
+	init_new_thread_signals();
 	enable_timer();
 	free_page(current->thread.temp_stack);
 	set_cmdline("(kernel thread)");
Index: linux-2.6.17/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/process.c	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/process.c	2006-07-06 13:26:38.000000000 -0400
@@ -250,25 +250,24 @@ void init_new_thread_stack(void *sig_sta
 	if(usr1_handler) set_handler(SIGUSR1, usr1_handler, flags, -1);
 }
 
-void init_new_thread_signals(int altstack)
+void init_new_thread_signals(void)
 {
-	int flags = altstack ? SA_ONSTACK : 0;
-
-	set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags,
+	set_handler(SIGSEGV, (__sighandler_t) sig_handler, SA_ONSTACK,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGTRAP, (__sighandler_t) sig_handler, flags,
+	set_handler(SIGTRAP, (__sighandler_t) sig_handler, SA_ONSTACK,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGFPE, (__sighandler_t) sig_handler, flags,
+	set_handler(SIGFPE, (__sighandler_t) sig_handler, SA_ONSTACK,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGILL, (__sighandler_t) sig_handler, flags,
+	set_handler(SIGILL, (__sighandler_t) sig_handler, SA_ONSTACK,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGBUS, (__sighandler_t) sig_handler, flags,
+	set_handler(SIGBUS, (__sighandler_t) sig_handler, SA_ONSTACK,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	set_handler(SIGUSR2, (__sighandler_t) sig_handler,
-		    flags, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+		    SA_ONSTACK, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM,
+		    -1);
 	signal(SIGHUP, SIG_IGN);
 
-	init_irq_signals(altstack);
+	init_irq_signals(1);
 }
 
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
Index: linux-2.6.17/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/skas/process.c	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/skas/process.c	2006-07-06 13:25:20.000000000 -0400
@@ -159,7 +159,7 @@ static int userspace_tramp(void *stack)
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
-	init_new_thread_signals(1);
+	init_new_thread_signals();
 	enable_timer();
 
 	if(!proc_mm){

