Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbSKQMN1>; Sun, 17 Nov 2002 07:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbSKQMN1>; Sun, 17 Nov 2002 07:13:27 -0500
Received: from mx1.elte.hu ([157.181.1.137]:58005 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267490AbSKQMNX>;
	Sun, 17 Nov 2002 07:13:23 -0500
Date: Sun, 17 Nov 2002 14:36:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <1037534273.1597.26.camel@ldb>
Message-ID: <Pine.LNX.4.44.0211171436200.7839-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Nov 2002, Luca Barbieri wrote:

> > the attached patch
> -> The patch that was meant to be attached :)

yeah ...

--- linux/arch/i386/kernel/entry.S.orig	2002-11-17 11:22:18.000000000 +0100
+++ linux/arch/i386/kernel/entry.S	2002-11-17 11:31:32.000000000 +0100
@@ -193,10 +193,8 @@
 
 
 ENTRY(ret_from_fork)
-#if CONFIG_SMP || CONFIG_PREEMPT
 	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
-#endif
 	GET_THREAD_INFO(%ebx)
 	jmp syscall_exit
 
@@ -767,6 +765,7 @@
 	.long sys_epoll_ctl	/* 255 */
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
+ 	.long sys_set_tid_address
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
--- linux/include/linux/sched.h.orig	2002-11-17 11:26:53.000000000 +0100
+++ linux/include/linux/sched.h	2002-11-17 12:58:20.000000000 +0100
@@ -46,10 +46,9 @@
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
-#define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
-#define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
-#define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
-#define CLONE_UNTRACED  0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_SETTID	0x00100000	/* set/clear the TID */
+#define CLONE_DETACHED	0x00200000	/* parent wants no child-exit signal */
+#define CLONE_UNTRACED  0x00400000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 
 /*
  * List of flags we want to share for kernel threads,
@@ -332,7 +331,7 @@
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
-	int *user_tid;				/* for CLONE_CLEARTID */
+	int *user_tid;				/* for CLONE_SETTID */
 
 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
--- linux/kernel/sched.c.orig	2002-11-17 11:22:48.000000000 +0100
+++ linux/kernel/sched.c	2002-11-17 11:30:58.000000000 +0100
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
--- linux/kernel/fork.c.orig	2002-11-17 11:25:35.000000000 +0100
+++ linux/kernel/fork.c	2002-11-17 12:40:44.000000000 +0100
@@ -676,6 +676,13 @@
 	p->flags = new_flags;
 }
 
+asmlinkage int sys_set_tid_address(int *user_tid)
+{
+	current->user_tid = user_tid;
+
+	return current->pid;
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -813,18 +820,14 @@
 	if (retval)
 		goto bad_fork_cleanup_namespace;
 	/*
-	 * Notify the child of the TID?
+	 * Does the userspace VM want the TID set in the child's
+	 * address space and it cleared on mm_release()?
 	 */
-	retval = -EFAULT;
-	if (clone_flags & CLONE_SETTID)
-		if (put_user(p->pid, user_tid))
-			goto bad_fork_cleanup_namespace;
-
-	/*
-	 * Does the userspace VM want the TID cleared on mm_release()?
-	 */
-	if (clone_flags & CLONE_CLEARTID)
+	if (clone_flags & CLONE_SETTID) {
 		p->user_tid = user_tid;
+		if (clone_flags & CLONE_VM)
+			put_user(p->pid, user_tid);
+	}
 
 	/*
 	 * Syscall tracing should be turned off in the child regardless

