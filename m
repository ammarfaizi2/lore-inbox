Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315646AbSEIIVG>; Thu, 9 May 2002 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315653AbSEIIVF>; Thu, 9 May 2002 04:21:05 -0400
Received: from [202.135.142.196] ([202.135.142.196]:38669 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315646AbSEIIVE>; Thu, 9 May 2002 04:21:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug CPU prep I: do_fork()
Date: Thu, 09 May 2002 18:24:12 +1000
Message-Id: <E175jDg-000722-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This changes do_fork() to return the task struct, rather than the PID.
x86 and PPC fixed up.

This is needed for creating idle tasks after boot (we can't assume
it'll be on the tail of the task list).

================
Name: do_fork cleanup
Author: Rusty Russell

D: This patch modifies do_fork() to return a process struct.  It only
D: updates x86 and PPC, other archs are broken by this patch.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14/include/linux/sched.h working-2.5.14-init-task/include/linux/sched.h
--- linux-2.5.14/include/linux/sched.h	Mon May  6 16:00:11 2002
+++ working-2.5.14-init-task/include/linux/sched.h	Thu May  9 17:35:11 2002
@@ -654,7 +654,7 @@
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
-extern int do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);
+extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);
 
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14/arch/i386/kernel/process.c working-2.5.14-init-task/arch/i386/kernel/process.c
--- linux-2.5.14/arch/i386/kernel/process.c	Mon Apr 29 16:00:17 2002
+++ working-2.5.14-init-task/arch/i386/kernel/process.c	Thu May  9 17:28:55 2002
@@ -711,11 +711,15 @@
 
 asmlinkage int sys_fork(struct pt_regs regs)
 {
-	return do_fork(SIGCHLD, regs.esp, &regs, 0);
+	struct task_struct *p;
+
+	p = do_fork(SIGCHLD, regs.esp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 asmlinkage int sys_clone(struct pt_regs regs)
 {
+	struct task_struct *p;
 	unsigned long clone_flags;
 	unsigned long newsp;
 
@@ -723,7 +727,8 @@
 	newsp = regs.ecx;
 	if (!newsp)
 		newsp = regs.esp;
-	return do_fork(clone_flags, newsp, &regs, 0);
+	p = do_fork(clone_flags, newsp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
@@ -738,7 +743,10 @@
  */
 asmlinkage int sys_vfork(struct pt_regs regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0);
+	struct task_struct *p;
+
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14/arch/i386/kernel/smpboot.c working-2.5.14-init-task/arch/i386/kernel/smpboot.c
--- linux-2.5.14/arch/i386/kernel/smpboot.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.14-init-task/arch/i386/kernel/smpboot.c	Thu May  9 17:26:49 2002
@@ -529,7 +529,7 @@
 	unsigned short ss;
 } stack_start;
 
-static int __init fork_by_hand(void)
+static struct task_struct * __init fork_by_hand(void)
 {
 	struct pt_regs regs;
 	/*
@@ -822,17 +822,14 @@
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	if (fork_by_hand() < 0)
+	idle = fork_by_hand();
+	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
-	idle = prev_task(&init_task);
-	if (!idle)
-		panic("No idle process for CPU %d", cpu);
-
 	init_idle(idle, cpu);
 
 	map_cpu_to_boot_apicid(cpu, apicid);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14/arch/ppc/kernel/process.c working-2.5.14-init-task/arch/ppc/kernel/process.c
--- linux-2.5.14/arch/ppc/kernel/process.c	Wed Feb 20 17:57:04 2002
+++ working-2.5.14-init-task/arch/ppc/kernel/process.c	Thu May  9 17:29:20 2002
@@ -441,19 +441,25 @@
 int sys_clone(int p1, int p2, int p3, int p4, int p5, int p6,
 	      struct pt_regs *regs)
 {
-	return do_fork(p1, regs->gpr[1], regs, 0);
+	struct task_struct *p;
+	p = do_fork(p1, regs->gpr[1], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_fork(int p1, int p2, int p3, int p4, int p5, int p6,
 	     struct pt_regs *regs)
 {
-	return do_fork(SIGCHLD, regs->gpr[1], regs, 0);
+	struct task_struct *p;
+	p = do_fork(SIGCHLD, regs->gpr[1], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_vfork(int p1, int p2, int p3, int p4, int p5, int p6,
 	      struct pt_regs *regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gpr[1], regs, 0);
+	struct task_struct *p;
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gpr[1], regs, 0);
+	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
 int sys_execve(unsigned long a0, unsigned long a1, unsigned long a2,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14/arch/ppc/kernel/smp.c working-2.5.14-init-task/arch/ppc/kernel/smp.c
--- linux-2.5.14/arch/ppc/kernel/smp.c	Mon Apr 15 11:47:12 2002
+++ working-2.5.14-init-task/arch/ppc/kernel/smp.c	Thu May  9 17:29:58 2002
@@ -343,11 +343,9 @@
 		/* create a process for the processor */
 		/* only regs.msr is actually used, and 0 is OK for it */
 		memset(&regs, 0, sizeof(struct pt_regs));
-		if (do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0) < 0)
+		p = do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
+		if (IS_ERR(p))
 			panic("failed fork for CPU %d", i);
-		p = prev_task(&init_task);
-		if (!p)
-			panic("No idle task for CPU %d", i);
 		init_idle(p, i);
 		unhash_process(p);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.14/kernel/fork.c working-2.5.14-init-task/kernel/fork.c
--- linux-2.5.14/kernel/fork.c	Mon Apr 29 16:00:29 2002
+++ working-2.5.14-init-task/kernel/fork.c	Thu May  9 17:26:13 2002
@@ -608,16 +608,18 @@
  * For an example that's using stack_top, see
  * arch/ia64/kernel/process.c.
  */
-int do_fork(unsigned long clone_flags, unsigned long stack_start,
-	    struct pt_regs *regs, unsigned long stack_size)
+struct task_struct *do_fork(unsigned long clone_flags,
+			    unsigned long stack_start,
+			    struct pt_regs *regs,
+			    unsigned long stack_size)
 {
 	int retval;
 	unsigned long flags;
-	struct task_struct *p;
+	struct task_struct *p = NULL;
 	struct completion vfork;
 
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	retval = -EPERM;
 
@@ -768,8 +769,7 @@
 	 *
 	 * Let it rip!
 	 */
-	retval = p->pid;
-	p->tgid = retval;
+	p->tgid = p->pid;
 	INIT_LIST_HEAD(&p->thread_group);
 
 	/* Need tasklist lock for parent etc handling! */
@@ -807,9 +807,12 @@
 		 * COW overhead when the child exec()s afterwards.
 		 */
 		set_need_resched();
+	retval = 0;
 
 fork_out:
-	return retval;
+	if (retval)
+		return ERR_PTR(retval);
+	return p;
 
 bad_fork_cleanup_namespace:
 	exit_namespace(p);


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
