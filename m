Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbSKQUp3>; Sun, 17 Nov 2002 15:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbSKQUp3>; Sun, 17 Nov 2002 15:45:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14046 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267594AbSKQUp0>;
	Sun, 17 Nov 2002 15:45:26 -0500
Date: Sun, 17 Nov 2002 23:08:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <Pine.LNX.4.44.0211172132070.13235-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211172308180.20659-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok, the attached patch also does the return-check of the parent-tidptr 
put_user() call:

--- linux/arch/i386/kernel/entry.S.orig	2002-11-17 20:54:55.000000000 +0100
+++ linux/arch/i386/kernel/entry.S	2002-11-17 20:57:44.000000000 +0100
@@ -193,10 +193,8 @@
 
 
 ENTRY(ret_from_fork)
-#if CONFIG_SMP || CONFIG_PREEMPT
 	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
-#endif
 	GET_THREAD_INFO(%ebx)
 	jmp syscall_exit
 
--- linux/arch/i386/kernel/smpboot.c.orig	2002-11-17 21:12:49.000000000 +0100
+++ linux/arch/i386/kernel/smpboot.c	2002-11-17 21:12:52.000000000 +0100
@@ -498,7 +498,7 @@
 	 * don't care about the eip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 }
 
 /* which physical APIC ID maps to which logical CPU number */
--- linux/arch/i386/kernel/process.c.orig	2002-11-17 21:03:01.000000000 +0100
+++ linux/arch/i386/kernel/process.c	2002-11-17 21:11:52.000000000 +0100
@@ -225,7 +225,7 @@
 	regs.eflags = 0x286;
 
 	/* Ok, create the new process.. */
-	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL);
+	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -502,7 +502,7 @@
 {
 	struct task_struct *p;
 
-	p = do_fork(SIGCHLD, regs.esp, &regs, 0, NULL);
+	p = do_fork(SIGCHLD, regs.esp, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -511,14 +511,15 @@
 	struct task_struct *p;
 	unsigned long clone_flags;
 	unsigned long newsp;
-	int *user_tid;
+	int *parent_tidptr, *child_tidptr;
 
 	clone_flags = regs.ebx;
 	newsp = regs.ecx;
-	user_tid = (int *)regs.edx;
+	parent_tidptr = (int *)regs.edx;
+	child_tidptr = (int *)regs.esi;
 	if (!newsp)
 		newsp = regs.esp;
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, user_tid);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, parent_tidptr, child_tidptr);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -536,7 +537,7 @@
 {
 	struct task_struct *p;
 
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0, NULL);
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
--- linux/include/linux/sched.h.orig	2002-11-17 20:53:52.000000000 +0100
+++ linux/include/linux/sched.h	2002-11-17 21:15:27.000000000 +0100
@@ -46,10 +46,11 @@
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
-#define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
-#define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
-#define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
-#define CLONE_UNTRACED  0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_PARENT_SETTID	0x00100000	/* set the TID in the parent */
+#define CLONE_CHILD_SETTID	0x00200000	/* set the TID in the child */
+#define CLONE_CHILD_CLEARTID	0x00400000	/* clear the TID in the child */
+#define CLONE_DETACHED	0x00800000	/* parent wants no child-exit signal */
+#define CLONE_UNTRACED  0x01000000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 
 /*
  * List of flags we want to share for kernel threads,
@@ -332,7 +333,7 @@
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
-	int *user_tid;				/* for CLONE_CLEARTID */
+	int *user_tid;				/* CLONE_CHILD_[SET|CLEAR]TID */
 
 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
@@ -615,7 +616,7 @@
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
-extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *);
+extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *, int *);
 
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
--- linux/kernel/sched.c.orig	2002-11-17 20:52:30.000000000 +0100
+++ linux/kernel/sched.c	2002-11-17 21:12:03.000000000 +0100
@@ -503,12 +503,16 @@
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
  */
-#if CONFIG_SMP || CONFIG_PREEMPT
+asmlinkage void FASTCALL(schedule_tail(task_t *prev));
 asmlinkage void schedule_tail(task_t *prev)
 {
 	finish_arch_switch(this_rq(), prev);
+	/*
+	 * Does the child thread/process want to be notified of the TID/PID?
+	 */
+	if (current->user_tid)
+		put_user(current->pid, current->user_tid);
 }
-#endif
 
 /*
  * context_switch - switch to the new MM and the new
--- linux/kernel/fork.c.orig	2002-11-17 20:54:55.000000000 +0100
+++ linux/kernel/fork.c	2002-11-17 22:52:25.000000000 +0100
@@ -695,7 +695,8 @@
 			    unsigned long stack_start,
 			    struct pt_regs *regs,
 			    unsigned long stack_size,
-			    int *user_tid)
+			    int *parent_tidptr,
+			    int *child_tidptr)
 {
 	int retval;
 	struct task_struct *p = NULL;
@@ -819,19 +820,18 @@
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
-	/*
-	 * Notify the child of the TID?
-	 */
-	retval = -EFAULT;
-	if (clone_flags & CLONE_SETTID)
-		if (put_user(p->pid, user_tid))
-			goto bad_fork_cleanup_namespace;
 
+	if (clone_flags & CLONE_PARENT_SETTID)
+		if (put_user(p->pid, parent_tidptr)) {
+			retval = -EFAULT;
+			goto bad_fork_cleanup_namespace;
+		}
 	/*
-	 * Does the userspace VM want the TID cleared on mm_release()?
+	 * Does the userspace VM want the TID set in the child's
+	 * address space and it cleared on mm_release()?
 	 */
-	if (clone_flags & CLONE_CLEARTID)
-		p->user_tid = user_tid;
+	if (clone_flags & CLONE_CHILD_SETTID)
+		p->user_tid = child_tidptr;
 
 	/*
 	 * Syscall tracing should be turned off in the child regardless
@@ -1000,7 +1000,8 @@
 			    unsigned long stack_start,
 			    struct pt_regs *regs,
 			    unsigned long stack_size,
-			    int *user_tid)
+			    int *parent_tidptr,
+			    int *child_tidptr)
 {
 	struct task_struct *p;
 	int trace = 0;
@@ -1011,7 +1012,7 @@
 			clone_flags |= CLONE_PTRACE;
 	}
 
-	p = copy_process(clone_flags, stack_start, regs, stack_size, user_tid);
+	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr);
 	if (!IS_ERR(p)) {
 		struct completion vfork;
 

