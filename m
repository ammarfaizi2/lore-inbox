Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319141AbSHMSye>; Tue, 13 Aug 2002 14:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319142AbSHMSye>; Tue, 13 Aug 2002 14:54:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19677 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319141AbSHMSyc>;
	Tue, 13 Aug 2002 14:54:32 -0400
Date: Tue, 13 Aug 2002 20:58:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: [patch] clone-detached-2.5.31-A1
In-Reply-To: <3D594A68.88807CEE@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208132052230.7425-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch implements the per-CPU thread-structure cache to do
detached exit, if the parent does not want to be notified of child exit
via a signal. It works wondefully. (tested patch against BK-current.)

i'm worried about one codepath though, in sys_wait4() we have this:

                                        p->parent = p->real_parent;
                                        add_parent(p, p->parent);
                                        do_notify_parent(p, SIGCHLD);

can this actually trigger for a detached process as well? In any case i've
put an assert in to make sure.

	Ingo

--- linux/include/linux/sched.h.orig	Tue Aug 13 20:27:23 2002
+++ linux/include/linux/sched.h	Tue Aug 13 20:50:18 2002
@@ -47,6 +47,7 @@
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
 #define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
+#define CLONE_DETACHED	0x00200000	/* parent wants no child-exit signal */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 
--- linux/kernel/exit.c.orig	Tue Aug 13 19:55:04 2002
+++ linux/kernel/exit.c	Tue Aug 13 20:52:46 2002
@@ -56,10 +56,11 @@
 
 static void release_task(struct task_struct * p)
 {
-	if (p == current)
+	if (p->state != TASK_ZOMBIE)
 		BUG();
 #ifdef CONFIG_SMP
-	wait_task_inactive(p);
+	if (p != current)
+		wait_task_inactive(p);
 #endif
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
@@ -67,10 +68,12 @@
 	unhash_process(p);
 
 	release_thread(p);
-	current->cmin_flt += p->min_flt + p->cmin_flt;
-	current->cmaj_flt += p->maj_flt + p->cmaj_flt;
-	current->cnswap += p->nswap + p->cnswap;
-	sched_exit(p);
+	if (p != current) {
+		current->cmin_flt += p->min_flt + p->cmin_flt;
+		current->cmaj_flt += p->maj_flt + p->cmaj_flt;
+		current->cnswap += p->nswap + p->cnswap;
+		sched_exit(p);
+	}
 	put_task_struct(p);
 }
 
@@ -479,14 +482,15 @@
 
 	write_lock_irq(&tasklist_lock);
 	current->state = TASK_ZOMBIE;
-	do_notify_parent(current, current->exit_signal);
+	if (current->exit_signal != -1)
+		do_notify_parent(current, current->exit_signal);
 	while ((p = eldest_child(current))) {
 		list_del_init(&p->sibling);
 		p->ptrace = 0;
 
 		p->parent = p->real_parent;
 		list_add_tail(&p->sibling,&p->parent->children);
-		if (p->state == TASK_ZOMBIE)
+		if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
 			do_notify_parent(p, p->exit_signal);
 		/*
 		 * process group orphan check
@@ -555,6 +559,9 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+	preempt_disable();
+	if (current->exit_signal == -1)
+		release_task(current);
 	schedule();
 	BUG();
 /*
--- linux/kernel/signal.c.orig	Tue Aug 13 19:55:07 2002
+++ linux/kernel/signal.c	Tue Aug 13 20:53:43 2002
@@ -768,12 +768,15 @@
 /*
  * Let a parent know about a status change of a child.
  */
-
 void do_notify_parent(struct task_struct *tsk, int sig)
 {
 	struct siginfo info;
 	int why, status;
 
+	/* is the thread detached? */
+	if (sig == -1 || tsk->exit_signal == -1)
+		BUG();
+
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_pid = tsk->pid;
@@ -823,9 +826,11 @@
 void
 notify_parent(struct task_struct *tsk, int sig)
 {
-	read_lock(&tasklist_lock);
-	do_notify_parent(tsk, sig);
-	read_unlock(&tasklist_lock);
+	if (sig != -1) {
+		read_lock(&tasklist_lock);
+		do_notify_parent(tsk, sig);
+		read_unlock(&tasklist_lock);
+	}
 }
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
--- linux/kernel/fork.c.orig	Tue Aug 13 19:55:07 2002
+++ linux/kernel/fork.c	Tue Aug 13 20:47:03 2002
@@ -50,6 +50,31 @@
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
+/*
+ * A per-CPU task cache - this relies on the fact that
+ * the very last portion of sys_exit() is executed with
+ * preemption turned off.
+ */
+static task_t *task_cache[NR_CPUS] __cacheline_aligned;
+
+void __put_task_struct(struct task_struct *tsk)
+{
+	if (tsk != current) {
+		free_thread_info(tsk->thread_info);
+		kmem_cache_free(task_struct_cachep,tsk);
+	} else {
+		int cpu = smp_processor_id();
+
+		tsk = task_cache[cpu];
+		if (tsk) {
+			free_thread_info(tsk->thread_info);
+			kmem_cache_free(task_struct_cachep,tsk);
+		}
+		task_cache[cpu] = current;
+	}
+}
+
+/* Protects next_safe and last_pid. */
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -123,13 +148,6 @@
 	return tsk;
 }
 
-void __put_task_struct(struct task_struct *tsk)
-{
-	free_thread_info(tsk->thread_info);
-	kmem_cache_free(task_struct_cachep,tsk);
-}
-
-/* Protects next_safe and last_pid. */
 spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
 
 static int get_pid(unsigned long flags)
@@ -737,7 +755,10 @@
 
 	/* ok, now we should be set up.. */
 	p->swappable = 1;
-	p->exit_signal = clone_flags & CSIGNAL;
+	if (clone_flags & CLONE_DETACHED)
+		p->exit_signal = -1;
+	else
+		p->exit_signal = clone_flags & CSIGNAL;
 	p->pdeath_signal = 0;
 
 	/*

