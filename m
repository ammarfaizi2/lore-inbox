Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTETL1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 07:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbTETL1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 07:27:53 -0400
Received: from angband.namesys.com ([212.16.7.85]:28544 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263705AbTETL1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 07:27:46 -0400
Date: Tue, 20 May 2003 13:32:58 +0400
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, jdike@karaya.com
Subject: [2.5] [PATCH] convert UML to new do_fork() API
Message-ID: <20030520093258.GA12880@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   The patch below converts UML to use do_fork() according to new API
   and it also now uses copy_process/wake_up_forked_process to create
   idle threads in SMP mode.
   I verified that it boots and works fine in UP (tt and skas mode) and in SMP
   with more than one virtual CPU.

   Please apply.

Bye,
    Oleg

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1106  -> 1.1107 
#	arch/um/kernel/smp.c	1.14    -> 1.15   
#	arch/um/kernel/process_kern.c	1.18    -> 1.19   
#	arch/um/kernel/syscall_kern.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/20	green@angband.namesys.com	1.1107
# UML: adopt to new do_fork() API
# --------------------------------------------
#
diff -Nru a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
--- a/arch/um/kernel/process_kern.c	Tue May 20 13:22:37 2003
+++ b/arch/um/kernel/process_kern.c	Tue May 20 13:22:37 2003
@@ -104,13 +104,12 @@
 
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-	struct task_struct *p;
-
+	long err;
 	current->thread.request.u.thread.proc = fn;
 	current->thread.request.u.thread.arg = arg;
-	p = do_fork(CLONE_VM | flags, 0, NULL, 0, NULL, NULL);
-	if(IS_ERR(p)) panic("do_fork failed in kernel_thread");
-	return(p->pid);
+	err = do_fork(CLONE_VM | flags, 0, NULL, 0, NULL, NULL);
+	if(err < 0) panic("do_fork failed in kernel_thread, errno %d", errno);
+	return(err);
 }
 
 void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
diff -Nru a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
--- a/arch/um/kernel/smp.c	Tue May 20 13:22:37 2003
+++ b/arch/um/kernel/smp.c	Tue May 20 13:22:37 2003
@@ -140,8 +140,8 @@
 
         current->thread.request.u.thread.proc = idle_proc;
         current->thread.request.u.thread.arg = (void *) cpu;
-	new_task = do_fork(CLONE_VM | CLONE_IDLETASK, 0, NULL, 0, NULL, NULL);
-	if(IS_ERR(new_task)) panic("do_fork failed in idle_thread");
+	new_task = copy_process(CLONE_VM | CLONE_IDLETASK, 0, NULL, 0, NULL, NULL);
+	if(IS_ERR(new_task)) panic("copy_process failed in idle_thread");
 
 	cpu_tasks[cpu] = ((struct cpu_task) 
 		          { .pid = 	new_task->thread.mode.tt.extern_pid,
@@ -150,6 +150,7 @@
 	CHOOSE_MODE(write(new_task->thread.mode.tt.switch_pipe[1], &c, 
 			  sizeof(c)),
 		    ({ panic("skas mode doesn't support SMP"); }));
+	wake_up_forked_process(new_task);
 	return(new_task);
 }
 
diff -Nru a/arch/um/kernel/syscall_kern.c b/arch/um/kernel/syscall_kern.c
--- a/arch/um/kernel/syscall_kern.c	Tue May 20 13:22:37 2003
+++ b/arch/um/kernel/syscall_kern.c	Tue May 20 13:22:37 2003
@@ -35,32 +35,32 @@
 
 long sys_fork(void)
 {
-	struct task_struct *p;
+	long pid;
 
 	current->thread.forking = 1;
-        p = do_fork(SIGCHLD, 0, NULL, 0, NULL, NULL);
+        pid = do_fork(SIGCHLD, 0, NULL, 0, NULL, NULL);
 	current->thread.forking = 0;
-	return(IS_ERR(p) ? PTR_ERR(p) : p->pid);
+	return(pid);
 }
 
 long sys_clone(unsigned long clone_flags, unsigned long newsp)
 {
-	struct task_struct *p;
+	long pid;
 
 	current->thread.forking = 1;
-	p = do_fork(clone_flags, newsp, NULL, 0, NULL, NULL);
+	pid = do_fork(clone_flags, newsp, NULL, 0, NULL, NULL);
 	current->thread.forking = 0;
-	return(IS_ERR(p) ? PTR_ERR(p) : p->pid);
+	return(pid);
 }
 
 long sys_vfork(void)
 {
-	struct task_struct *p;
+	long pid;
 
 	current->thread.forking = 1;
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0, NULL, 0, NULL, NULL);
+	pid = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0, NULL, 0, NULL, NULL);
 	current->thread.forking = 0;
-	return(IS_ERR(p) ? PTR_ERR(p) : p->pid);
+	return(pid);
 }
 
 /* common code for old and new mmaps */
