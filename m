Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUIJRZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUIJRZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUIJRZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:25:29 -0400
Received: from [12.177.129.25] ([12.177.129.25]:24003 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267556AbUIJRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:24:50 -0400
Message-Id: <200409101828.i8AISA0O003423@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - eliminate useless thread field
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Sep 2004 14:28:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch eliminates use of task.thread.kernel_stack.  It was unnecessary,
confusing, and was masking some kernel stack size assumptions.

				Jeff

Index: 2.6.9-rc1/arch/um/kernel/process.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/process.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/process.c	2004-09-10 12:52:44.000000000 -0400
@@ -46,7 +46,7 @@
 	int flags = 0, pages;
 
 	if(sig_stack != NULL){
-		pages = (1 << UML_CONFIG_KERNEL_STACK_ORDER) - 2;
+		pages = (1 << UML_CONFIG_KERNEL_STACK_ORDER);
 		set_sigstack(sig_stack, pages * page_size());
 		flags = SA_ONSTACK;
 	}
Index: 2.6.9-rc1/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/process_kern.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/process_kern.c	2004-09-10 12:55:43.000000000 -0400
@@ -166,8 +166,6 @@
 		struct pt_regs *regs)
 {
 	p->thread = (struct thread_struct) INIT_THREAD;
-	p->thread.kernel_stack = 
-		(unsigned long) p->thread_info + 2 * PAGE_SIZE;
 	return(CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr, 
 				clone_flags, sp, stack_top, p, regs));
 }
@@ -327,8 +325,7 @@
 	unsigned long stack;
 
 	stack = sp & (PAGE_MASK << CONFIG_KERNEL_STACK_ORDER);
-	stack += 2 * PAGE_SIZE;
-	return(stack != current->thread.kernel_stack);
+	return(stack != (unsigned long) current_thread);
 }
 
 extern void remove_umid_dir(void);
Index: 2.6.9-rc1/arch/um/kernel/skas/process_kern.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/skas/process_kern.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/skas/process_kern.c	2004-09-10 12:52:44.000000000 -0400
@@ -191,8 +191,7 @@
 		handler = new_thread_handler;
 	}
 
-	new_thread((void *) p->thread.kernel_stack, 
-		   &p->thread.mode.skas.switch_buf, 
+	new_thread(p->thread_info, &p->thread.mode.skas.switch_buf, 
 		   &p->thread.mode.skas.fork_buf, handler);
 	return(0);
 }
@@ -231,7 +230,7 @@
 
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;
-	return(start_idle_thread((void *) init_task.thread.kernel_stack,
+	return(start_idle_thread(init_task.thread_info,
 				 &init_task.thread.mode.skas.switch_buf,
 				 &init_task.thread.mode.skas.fork_buf));
 }
Index: 2.6.9-rc1/arch/um/kernel/tt/exec_kern.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/tt/exec_kern.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/tt/exec_kern.c	2004-09-10 12:52:44.000000000 -0400
@@ -39,8 +39,7 @@
 		do_exit(SIGKILL);
 	}
 		
-	new_pid = start_fork_tramp((void *) current->thread.kernel_stack,
-				   stack, 0, exec_tramp);
+	new_pid = start_fork_tramp(current->thread_info, stack, 0, exec_tramp);
 	if(new_pid < 0){
 		printk(KERN_ERR 
 		       "flush_thread : new thread failed, errno = %d\n",
Index: 2.6.9-rc1/arch/um/kernel/tt/process_kern.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/tt/process_kern.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/tt/process_kern.c	2004-09-10 12:52:44.000000000 -0400
@@ -248,8 +248,7 @@
 
 	clone_flags &= CLONE_VM;
 	p->thread.temp_stack = stack;
-	new_pid = start_fork_tramp((void *) p->thread.kernel_stack, stack,
-				   clone_flags, tramp);
+	new_pid = start_fork_tramp(p->thread_info, stack, clone_flags, tramp);
 	if(new_pid < 0){
 		printk(KERN_ERR "copy_thread : clone failed - errno = %d\n", 
 		       -new_pid);
@@ -501,9 +500,9 @@
 	void *sp;
 	int pages;
 
-	pages = (1 << CONFIG_KERNEL_STACK_ORDER) - 2;
-	sp = (void *) init_task.thread.kernel_stack + pages * PAGE_SIZE - 
-		sizeof(unsigned long);
+	pages = (1 << CONFIG_KERNEL_STACK_ORDER);
+	sp = (void *) ((unsigned long) init_task.thread_info) + 
+		pages * PAGE_SIZE - sizeof(unsigned long);
 	return(tracer(start_kernel_proc, sp));
 }
 
Index: 2.6.9-rc1/arch/um/kernel/um_arch.c
===================================================================
--- 2.6.9-rc1.orig/arch/um/kernel/um_arch.c	2004-09-09 19:46:14.000000000 -0400
+++ 2.6.9-rc1/arch/um/kernel/um_arch.c	2004-09-10 12:52:44.000000000 -0400
@@ -380,9 +380,6 @@
 
   	uml_postsetup();
 
-	init_task.thread.kernel_stack = (unsigned long) &init_thread_info + 
-		2 * PAGE_SIZE;
-
 	task_protections((unsigned long) &init_thread_info);
 	os_flush_stdout();
 
Index: 2.6.9-rc1/include/asm-um/processor-generic.h
===================================================================
--- 2.6.9-rc1.orig/include/asm-um/processor-generic.h	2004-09-09 19:46:16.000000000 -0400
+++ 2.6.9-rc1/include/asm-um/processor-generic.h	2004-09-10 12:52:44.000000000 -0400
@@ -22,7 +22,6 @@
 
 struct thread_struct {
 	int forking;
-	unsigned long kernel_stack;
 	int nsyscalls;
 	struct pt_regs regs;
 	unsigned long cr2;
@@ -73,7 +72,6 @@
 #define INIT_THREAD \
 { \
 	.forking		= 0, \
-	.kernel_stack		= 0, \
 	.nsyscalls		= 0, \
         .regs		   	= EMPTY_REGS, \
 	.cr2			= 0, \

