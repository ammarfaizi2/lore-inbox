Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268689AbTGTVsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbTGTVsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:48:39 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:45812 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S268689AbTGTVsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:48:30 -0400
Date: Mon, 21 Jul 2003 00:03:32 +0200 (CEST)
From: Philippe Biondi <biondi@cartel-securite.fr>
X-X-Sender: pbi@deneb.intranet.cartel-securite.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH] linux 2.6.0-test1: do_fork() return value for ARCH=um,m68k,s390,h8300
Message-ID: <Pine.LNX.4.44.0307210003170.8505-100000@deneb.intranet.cartel-securite.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I tried to compile linux-2.6.0-test1 with ARCH=um.

First, I noticed that some functions expected do_fork() to return a
task_struct *. I don't know why. I find this really strange, did I miss
something ?

Here is the patch :

diff -Nrup linux-2.6.0-test1-ori/arch/h8300/kernel/process.c linux-2.6.0-test1/arch/h8300/kernel/process.c
--- linux-2.6.0-test1-ori/arch/h8300/kernel/process.c	2003-07-14 05:28:54.000000000 +0200
+++ linux-2.6.0-test1/arch/h8300/kernel/process.c	2003-07-20 17:58:56.000000000 +0200
@@ -172,25 +172,20 @@ asmlinkage int h8300_fork(struct pt_regs

 asmlinkage int h8300_vfork(struct pt_regs *regs)
 {
-	struct task_struct *p;
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0, NULL, NULL);
 }

 asmlinkage int h8300_clone(struct pt_regs *regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
-	struct task_struct *p;

 	/* syscall2 puts clone_flags in er1 and usp in er2 */
 	clone_flags = regs->er1;
 	newsp = regs->er2;
 	if (!newsp)
 		newsp  = rdusp();
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
-
+	return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0, NULL, NULL);
 }

 int copy_thread(int nr, unsigned long clone_flags,
diff -Nrup linux-2.6.0-test1-ori/arch/m68k/kernel/process.c linux-2.6.0-test1/arch/m68k/kernel/process.c
--- linux-2.6.0-test1-ori/arch/m68k/kernel/process.c	2003-07-14 05:39:32.000000000 +0200
+++ linux-2.6.0-test1/arch/m68k/kernel/process.c	2003-07-20 17:55:34.000000000 +0200
@@ -202,24 +202,19 @@ void flush_thread(void)

 asmlinkage int m68k_fork(struct pt_regs *regs)
 {
-	struct task_struct *p;
-	p = do_fork(SIGCHLD, rdusp(), regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(SIGCHLD, rdusp(), regs, 0, NULL, NULL);
 }

 asmlinkage int m68k_vfork(struct pt_regs *regs)
 {
-	struct task_struct *p;
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0, NULL,
+	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(), regs, 0, NULL,
 		    NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }

 asmlinkage int m68k_clone(struct pt_regs *regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
-	struct task_struct *p;
 	int *parent_tidptr, *child_tidptr;

 	/* syscall2 puts clone_flags in d1 and usp in d2 */
@@ -229,9 +224,8 @@ asmlinkage int m68k_clone(struct pt_regs
 	child_tidptr = (int *)regs->d4;
 	if (!newsp)
 		newsp = rdusp();
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0,
+	return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, regs, 0,
 		    parent_tidptr, child_tidptr);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }

 int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
diff -Nrup linux-2.6.0-test1-ori/arch/s390/kernel/compat_linux.c linux-2.6.0-test1/arch/s390/kernel/compat_linux.c
--- linux-2.6.0-test1-ori/arch/s390/kernel/compat_linux.c	2003-07-14 05:37:14.000000000 +0200
+++ linux-2.6.0-test1/arch/s390/kernel/compat_linux.c	2003-07-20 17:59:34.000000000 +0200
@@ -2809,7 +2809,6 @@ asmlinkage int sys32_clone(struct pt_reg
 {
         unsigned long clone_flags;
         unsigned long newsp;
-	struct task_struct *p;
 	int *parent_tidptr, *child_tidptr;

         clone_flags = regs.gprs[3] & 0xffffffffUL;
@@ -2818,7 +2817,6 @@ asmlinkage int sys32_clone(struct pt_reg
 	child_tidptr = (int *) (regs.gprs[5] & 0x7fffffffUL);
         if (!newsp)
                 newsp = regs.gprs[15];
-        p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
-		    parent_tidptr, child_tidptr);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+       return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0,
+		       parent_tidptr, child_tidptr);
 }
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/process_kern.c linux-2.6.0-test1/arch/um/kernel/process_kern.c
--- linux-2.6.0-test1-ori/arch/um/kernel/process_kern.c	2003-07-14 05:34:33.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/process_kern.c	2003-07-20 18:00:42.000000000 +0200
@@ -103,13 +103,13 @@ unsigned long alloc_stack(int order, int

 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-	struct task_struct *p;
-
+	long pid;
+
 	current->thread.request.u.thread.proc = fn;
 	current->thread.request.u.thread.arg = arg;
-	p = do_fork(CLONE_VM | flags, 0, NULL, 0, NULL, NULL);
-	if(IS_ERR(p)) panic("do_fork failed in kernel_thread");
-	return(p->pid);
+	pid = do_fork(CLONE_VM | flags, 0, NULL, 0, NULL, NULL);
+	if (pid < 0) panic("do_fork failed in kernel_thread");
+	return (pid);
 }

 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/smp.c linux-2.6.0-test1/arch/um/kernel/smp.c
--- linux-2.6.0-test1-ori/arch/um/kernel/smp.c	2003-07-14 05:31:57.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/smp.c	2003-07-20 17:58:20.000000000 +0200
@@ -135,13 +135,15 @@ static int idle_proc(void *cpup)

 static struct task_struct *idle_thread(int cpu)
 {
-	struct task_struct *new_task;
 	unsigned char c;
+	long new_pid;
+	struct task_struct *new_task;

         current->thread.request.u.thread.proc = idle_proc;
         current->thread.request.u.thread.arg = (void *) cpu;
-	new_task = do_fork(CLONE_VM | CLONE_IDLETASK, 0, NULL, 0, NULL, NULL);
-	if(IS_ERR(new_task)) panic("do_fork failed in idle_thread");
+	new_pid = do_fork(CLONE_VM | CLONE_IDLETASK, 0, NULL, 0, NULL, NULL);
+	if (new_pid < 0) panic("do_fork failed in idle_thread");
+	new_task = find_task_by_pid(new_pid);

 	cpu_tasks[cpu] = ((struct cpu_task)
 		          { .pid = 	new_task->thread.mode.tt.extern_pid,
diff -Nrup linux-2.6.0-test1-ori/arch/um/kernel/syscall_kern.c linux-2.6.0-test1/arch/um/kernel/syscall_kern.c
--- linux-2.6.0-test1-ori/arch/um/kernel/syscall_kern.c	2003-07-14 05:36:35.000000000 +0200
+++ linux-2.6.0-test1/arch/um/kernel/syscall_kern.c	2003-07-20 17:53:54.000000000 +0200
@@ -35,32 +35,32 @@ long um_mount(char * dev_name, char * di

 long sys_fork(void)
 {
-	struct task_struct *p;
+	long pid;

 	current->thread.forking = 1;
-        p = do_fork(SIGCHLD, 0, NULL, 0, NULL, NULL);
+        pid = do_fork(SIGCHLD, 0, NULL, 0, NULL, NULL);
 	current->thread.forking = 0;
-	return(IS_ERR(p) ? PTR_ERR(p) : p->pid);
+	return pid;
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
+	return pid;
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
+	return pid;
 }

 /* common code for old and new mmaps */







-- 
Philippe Biondi <biondi@ cartel-securite.fr> Cartel Sécurité
Security Consultant/R&D                      http://www.cartel-securite.fr
PGP KeyID:3D9A43E2  FingerPrint:C40A772533730E39330DC0985EE8FF5F3D9A43E2




