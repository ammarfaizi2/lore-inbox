Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSKTI3B>; Wed, 20 Nov 2002 03:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSKTI3B>; Wed, 20 Nov 2002 03:29:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:61335 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265886AbSKTI26>;
	Wed, 20 Nov 2002 03:28:58 -0500
Date: Wed, 20 Nov 2002 10:51:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] threading enhancements, tid-2.5.48-A1
In-Reply-To: <Pine.LNX.4.44.0211200939590.29658-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211201050310.30357-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


here's an update to the patch, Ulrich noticed that the x86 register
parameters were incorrect, the correct use is %edx for the parent pointer,
%edi for the child pointer.

	Ingo

--- linux/arch/i386/kernel/smpboot.c.orig	2002-11-20 09:19:38.000000000 +0100
+++ linux/arch/i386/kernel/smpboot.c	2002-11-20 09:19:59.000000000 +0100
@@ -499,7 +499,7 @@
 	 * don't care about the eip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 }
 
 /* which physical APIC ID maps to which logical CPU number */
--- linux/arch/i386/kernel/process.c.orig	2002-11-20 09:19:38.000000000 +0100
+++ linux/arch/i386/kernel/process.c	2002-11-20 10:33:43.000000000 +0100
@@ -226,7 +226,7 @@
 	regs.eflags = 0x286;
 
 	/* Ok, create the new process.. */
-	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL);
+	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -288,7 +288,7 @@
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
-	p->user_tid = NULL;
+	p->set_child_tid = p->clear_child_tid = NULL;
 
 	p->thread.esp = (unsigned long) childregs;
 	p->thread.esp0 = (unsigned long) (childregs+1);
@@ -503,7 +503,7 @@
 {
 	struct task_struct *p;
 
-	p = do_fork(SIGCHLD, regs.esp, &regs, 0, NULL);
+	p = do_fork(SIGCHLD, regs.esp, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -512,14 +512,15 @@
 	struct task_struct *p;
 	unsigned long clone_flags;
 	unsigned long newsp;
-	int *user_tid;
+	int *parent_tidptr, *child_tidptr;
 
 	clone_flags = regs.ebx;
 	newsp = regs.ecx;
-	user_tid = (int *)regs.edx;
+	parent_tidptr = (int *)regs.edx;
+	child_tidptr = (int *)regs.edi;
 	if (!newsp)
 		newsp = regs.esp;
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, user_tid);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, parent_tidptr, child_tidptr);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -537,7 +538,7 @@
 {
 	struct task_struct *p;
 
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0, NULL);
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
--- linux/arch/i386/kernel/entry.S.orig	2002-11-20 09:25:32.000000000 +0100
+++ linux/arch/i386/kernel/entry.S	2002-11-20 09:25:37.000000000 +0100
@@ -193,10 +193,8 @@
 
 
 ENTRY(ret_from_fork)
-#if CONFIG_SMP || CONFIG_PREEMPT
 	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
-#endif
 	GET_THREAD_INFO(%ebx)
 	jmp syscall_exit
 
--- linux/include/linux/sched.h.orig	2002-11-20 09:18:47.000000000 +0100
+++ linux/include/linux/sched.h	2002-11-20 09:25:19.000000000 +0100
@@ -46,10 +46,11 @@
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
-#define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
-#define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
-#define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
-#define CLONE_UNTRACED  0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_PARENT_SETTID	0x00100000	/* set the TID in the parent */
+#define CLONE_CHILD_CLEARTID	0x00200000	/* clear the TID in the child */
+#define CLONE_DETACHED		0x00400000	/* parent wants no child-exit signal */
+#define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
 
 /*
  * List of flags we want to share for kernel threads,
@@ -332,7 +333,8 @@
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
-	int *user_tid;				/* for CLONE_CLEARTID */
+	int *set_child_tid;			/* CLONE_CHILD_SETTID */
+	int *clear_child_tid;			/* CLONE_CHILD_CLEARTID */
 
 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
@@ -615,7 +617,7 @@
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
-extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *);
+extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *, int *);
 
 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
--- linux/kernel/fork.c.orig	2002-11-20 09:19:38.000000000 +0100
+++ linux/kernel/fork.c	2002-11-20 09:27:12.000000000 +0100
@@ -408,16 +408,16 @@
 		tsk->vfork_done = NULL;
 		complete(vfork_done);
 	}
-	if (tsk->user_tid) {
-		int * user_tid = tsk->user_tid;
-		tsk->user_tid = NULL;
+	if (tsk->clear_child_tid) {
+		int * tidptr = tsk->clear_child_tid;
+		tsk->clear_child_tid = NULL;
 
 		/*
 		 * We dont check the error code - if userspace has
 		 * not set up a proper pointer then tough luck.
 		 */
-		put_user(0, user_tid);
-		sys_futex((unsigned long)user_tid, FUTEX_WAKE, 1, NULL);
+		put_user(0, tidptr);
+		sys_futex((unsigned long)tidptr, FUTEX_WAKE, 1, NULL);
 	}
 }
 
@@ -680,9 +680,9 @@
 	p->flags = new_flags;
 }
 
-asmlinkage int sys_set_tid_address(int *user_tid)
+asmlinkage int sys_set_tid_address(int *tidptr)
 {
-	current->user_tid = user_tid;
+	current->clear_child_tid = tidptr;
 
 	return current->pid;
 }
@@ -699,7 +699,8 @@
 			    unsigned long stack_start,
 			    struct pt_regs *regs,
 			    unsigned long stack_size,
-			    int *user_tid)
+			    int *parent_tidptr,
+			    int *child_tidptr)
 {
 	int retval;
 	struct task_struct *p = NULL;
@@ -823,19 +824,18 @@
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
-	/*
-	 * Notify the child of the TID?
-	 */
+
 	retval = -EFAULT;
-	if (clone_flags & CLONE_SETTID)
-		if (put_user(p->pid, user_tid))
+	if (clone_flags & CLONE_PARENT_SETTID)
+		if (put_user(p->pid, parent_tidptr))
 			goto bad_fork_cleanup_namespace;
-
+	if (clone_flags & CLONE_CHILD_SETTID)
+		p->set_child_tid = child_tidptr;
 	/*
-	 * Does the userspace VM want the TID cleared on mm_release()?
+	 * Clear TID on mm_release()?
 	 */
-	if (clone_flags & CLONE_CLEARTID)
-		p->user_tid = user_tid;
+	if (clone_flags & CLONE_CHILD_CLEARTID)
+		p->clear_child_tid = child_tidptr;
 
 	/*
 	 * Syscall tracing should be turned off in the child regardless
@@ -1004,7 +1004,8 @@
 			    unsigned long stack_start,
 			    struct pt_regs *regs,
 			    unsigned long stack_size,
-			    int *user_tid)
+			    int *parent_tidptr,
+			    int *child_tidptr)
 {
 	struct task_struct *p;
 	int trace = 0;
@@ -1015,7 +1016,7 @@
 			clone_flags |= CLONE_PTRACE;
 	}
 
-	p = copy_process(clone_flags, stack_start, regs, stack_size, user_tid);
+	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr);
 	if (!IS_ERR(p)) {
 		struct completion vfork;
 
--- linux/kernel/sched.c.orig	2002-11-20 09:25:45.000000000 +0100
+++ linux/kernel/sched.c	2002-11-20 09:26:49.000000000 +0100
@@ -503,12 +503,12 @@
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
  */
-#if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
 	finish_arch_switch(this_rq(), prev);
+	if (current->set_child_tid)
+		put_user(current->pid, current->set_child_tid);
 }
-#endif
 
 /*
  * context_switch - switch to the new MM and the new

