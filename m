Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269604AbUINSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269604AbUINSnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269654AbUINSl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:41:56 -0400
Received: from [12.177.129.25] ([12.177.129.25]:29379 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269689AbUINS3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:29:43 -0400
Message-Id: <200409141933.i8EJXM4W003542@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - UML - Eliminate signal order delivery dependency
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 15:33:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.4 hosts signals are delivered in numeric order when there are multiple
pending at a given time.  UML developed a subtle dependency on this ordering,
which broke on 2.6 hosts and the separate process and thread signal queues.

This patch eliminates that dependency.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/process.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/process.c	2004-09-14 13:48:41.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/process.c	2004-09-14 13:49:43.000000000 -0400
@@ -70,7 +70,7 @@
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler, flags, 
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	set_handler(SIGUSR2, (__sighandler_t) sig_handler, 
-		    SA_NOMASK | flags, -1);
+		    flags, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	signal(SIGHUP, SIG_IGN);
 
 	init_irq_signals(altstack);
Index: 2.6.9-rc2/arch/um/kernel/tt/exec_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/tt/exec_kern.c	2004-09-14 13:48:41.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/tt/exec_kern.c	2004-09-14 13:49:43.000000000 -0400
@@ -14,6 +14,7 @@
 #include "kern_util.h"
 #include "irq_user.h"
 #include "time_user.h"
+#include "signal_user.h"
 #include "mem_user.h"
 #include "os.h"
 #include "tlb.h"
@@ -53,7 +54,9 @@
 	current->thread.request.u.exec.pid = new_pid;
 	unprotect_stack((unsigned long) current_thread);
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 
+	change_sig(SIGUSR1, 0);
 	enable_timer();
 	free_page(stack);
 	protect_memory(uml_reserved, high_physmem - uml_reserved, 1, 1, 0, 1);
Index: 2.6.9-rc2/arch/um/kernel/tt/process_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/tt/process_kern.c	2004-09-14 13:48:41.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/tt/process_kern.c	2004-09-14 13:49:43.000000000 -0400
@@ -201,6 +201,7 @@
 	local_irq_disable();
 	init_new_thread_stack(stack, new_thread_handler);
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 	return(0);
 }
 
@@ -244,6 +245,7 @@
 	init_new_thread_stack(stack, finish_fork_handler);
 
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 	return(0);
 }
 
@@ -295,19 +297,30 @@
 	current->thread.request.op = OP_FORK;
 	current->thread.request.u.fork.pid = new_pid;
 	os_usr1_process(os_getpid());
-	return(0);
+
+	/* Enable the signal and then disable it to ensure that it is handled
+	 * here, and nowhere else.
+	 */
+	change_sig(SIGUSR1, 1);
+
+	change_sig(SIGUSR1, 0);
+	err = 0;
+ out:
+	return(err);
 }
 
 void reboot_tt(void)
 {
 	current->thread.request.op = OP_REBOOT;
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 }
 
 void halt_tt(void)
 {
 	current->thread.request.op = OP_HALT;
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 }
 
 void kill_off_processes_tt(void)
@@ -334,6 +347,9 @@
 		current->thread.request.u.cb.proc = proc;
 		current->thread.request.u.cb.arg = arg;
 		os_usr1_process(os_getpid());
+		change_sig(SIGUSR1, 1);
+
+		change_sig(SIGUSR1, 0);
 	}
 }
 
Index: 2.6.9-rc2/arch/um/kernel/tt/trap_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/tt/trap_user.c	2004-09-14 13:48:41.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/tt/trap_user.c	2004-09-14 13:49:43.000000000 -0400
@@ -37,7 +37,6 @@
 	if(sig != SIGUSR2) 
 		r->syscall = -1;
 
-	change_sig(SIGUSR1, 1);
 	info = &sig_info[sig];
 	if(!info->is_irq) unblock_signals();
 
@@ -46,7 +45,6 @@
 	if(is_user){
 		interrupt_end();
 		block_signals();
-		change_sig(SIGUSR1, 0);
 		set_user_mode(NULL);
 	}
 	*r = save_regs;
Index: 2.6.9-rc2/arch/um/os-Linux/process.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/os-Linux/process.c	2004-09-14 13:48:41.000000000 -0400
+++ 2.6.9-rc2/arch/um/os-Linux/process.c	2004-09-14 13:49:43.000000000 -0400
@@ -96,11 +96,7 @@
 
 void os_usr1_process(int pid)
 {
-#ifdef __NR_tkill
-	syscall(__NR_tkill, pid, SIGUSR1);
-#else
 	kill(pid, SIGUSR1);
-#endif
 }
 
 int os_getpid(void)

