Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSILIPp>; Thu, 12 Sep 2002 04:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSILIPp>; Thu, 12 Sep 2002 04:15:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62379 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S311025AbSILIPi>;
	Thu, 12 Sep 2002 04:15:38 -0400
Date: Thu, 12 Sep 2002 10:26:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sys_exit() fix, 2.5.34-D5
Message-ID: <Pine.LNX.4.44.0209121011290.5719-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes some problems introduced by detached threads and
the wait-on-group-exit concept.

it was possible for threads to schedule away as zombies and be freed by
wait4 - while they still had some work to do.

the main problem was the ability of wait4 to release tasks. The patch
removes the release_task() from the wait4 path and makes it a
wake_up_process() instead. TASK_ZOMBIE is thus not a condition mandatorily
preceding task exit, it's rather a task flag that is used by wait4 to find
exiting threads. I've added free_task() that does the real freeing work -
it's always called by the thread that exits.

what impact does this solution have?

 - non-detached tasks will perform one more context switch, from the 
   parent to the exiting thread.

 - on SMP there's no wait_task_inactive() looping done by the parent
   anymore.

 - the exit codepath became much more robust, eg. the procfs dput() 
   potential scheduling causes no problems. We can actually perform some 
   final cleanups after the parent thread has been notified.

i think the additional context switch in the non-detached case is
acceptable, it's detached threads that care most about exit() performance
anyway.

the patch also adds some temporary debugging code that makes sure freed
tasks are not woken up by wait4.

i've moved the 'wait for all other threads to exit' logic to before parent
notification. Once current->thread_group becomes empty there's no way the
thread can get new thread group children - so there are no races to worry
about.

i've tested the patch with normal process load, old-style and new-style
threading workloads, and some ptrace load.

	Ingo

--- linux/include/linux/sched.h.orig	Thu Sep 12 09:45:17 2002
+++ linux/include/linux/sched.h	Thu Sep 12 09:45:40 2002
@@ -97,6 +97,7 @@
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_ZOMBIE		4
 #define TASK_STOPPED		8
+#define TASK_INVALID		16
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
--- linux/kernel/sched.c.orig	Thu Sep 12 09:46:16 2002
+++ linux/kernel/sched.c	Thu Sep 12 09:46:36 2002
@@ -404,6 +404,8 @@
 	long old_state;
 	runqueue_t *rq;
 
+	if (p->state == TASK_INVALID)
+		BUG();
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
--- linux/kernel/exit.c.orig	Thu Sep 12 08:38:56 2002
+++ linux/kernel/exit.c	Thu Sep 12 10:19:43 2002
@@ -51,40 +51,40 @@
 
 static void release_task(struct task_struct * p)
 {
-	struct dentry *proc_dentry;
-
 	if (p->state != TASK_ZOMBIE)
 		BUG();
-#ifdef CONFIG_SMP
-	if (p != current)
-		wait_task_inactive(p);
-#endif
+	current->cmin_flt += p->min_flt + p->cmin_flt;
+	current->cmaj_flt += p->maj_flt + p->cmaj_flt;
+	current->cnswap += p->nswap + p->cnswap;
+	sched_exit(p);
+	wake_up_process(p);
+}
+
+static inline void free_task(void)
+{
+	struct task_struct *p = current;
+	struct dentry *proc_dentry;
+
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
-	if (unlikely(p->ptrace)) {
-		write_lock_irq(&tasklist_lock);
-		__ptrace_unlink(p);
-		write_unlock_irq(&tasklist_lock);
-	}
-	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	write_lock_irq(&tasklist_lock);
+	if (unlikely(current->ptrace))
+		__ptrace_unlink(current);
 	__exit_sighand(p);
 	proc_dentry = __unhash_process(p);
 	write_unlock_irq(&tasklist_lock);
+
 	if (unlikely(proc_dentry != NULL)) {
 		shrink_dcache_parent(proc_dentry);
 		dput(proc_dentry);
 	}
-
+	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children) || !list_empty(&p->thread_group) || !list_empty(&p->tasks));
 	release_thread(p);
-	if (p != current) {
-		current->cmin_flt += p->min_flt + p->cmin_flt;
-		current->cmaj_flt += p->maj_flt + p->cmaj_flt;
-		current->cnswap += p->nswap + p->cnswap;
-		sched_exit(p);
-	}
+
+	p->state = TASK_INVALID;
 	put_task_struct(p);
+	schedule();
 }
 
 /* we are using it only for SMP init */
@@ -521,7 +521,6 @@
 	struct task_struct *t;
 
 	write_lock_irq(&tasklist_lock);
-
 	forget_original_parent(current);
 	/*
 	 * Check to see if any process groups have become orphaned
@@ -565,6 +564,9 @@
 	    && !capable(CAP_KILL))
 		current->exit_signal = SIGCHLD;
 
+	current->state = TASK_ZOMBIE;
+	if (current->exit_signal != -1)
+		do_notify_parent(current, current->exit_signal);
 
 	/*
 	 * This loop does two things:
@@ -575,23 +577,38 @@
 	 *	jobs, send them a SIGHUP and then a SIGCONT.  (POSIX 3.2.2.2)
 	 */
 
-	current->state = TASK_ZOMBIE;
-	if (current->exit_signal != -1)
-		do_notify_parent(current, current->exit_signal);
-
 	while (!list_empty(&current->children))
 		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
 	while (!list_empty(&current->ptrace_children))
 		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,sibling), current, 1);
 	BUG_ON(!list_empty(&current->children));
+	write_unlock_irq(&tasklist_lock);
+}
+
+static inline void wait_threads(void)
+{
+	struct signal_struct *sig = current->sig;
+
+	write_lock_irq(&tasklist_lock);
+	spin_lock(&sig->siglock);
 	/*
-	 * No need to unlock IRQs, we'll schedule() immediately
-	 * anyway. In the preemption case this also makes it
-	 * impossible for the task to get runnable again (thus
-	 * the "_raw_" unlock - to make sure we don't try to
-	 * preempt here).
+	 * Do not let the thread group leader exit until all other
+	 * threads are done:
 	 */
-	_raw_write_unlock(&tasklist_lock);
+	while (!list_empty(&current->thread_group) &&
+			current->tgid == current->pid &&
+			atomic_read(&sig->count) > 1) {
+
+		spin_unlock(&sig->siglock);
+		write_unlock_irq(&tasklist_lock);
+
+		wait_for_completion(&sig->group_exit_done);
+
+		write_lock_irq(&tasklist_lock);
+		spin_lock(&sig->siglock);
+	}
+	spin_unlock(&sig->siglock);
+	write_unlock_irq(&tasklist_lock);
 }
 
 NORET_TYPE void do_exit(long code)
@@ -630,11 +647,14 @@
 		__MOD_DEC_USE_COUNT(tsk->binfmt->module);
 
 	tsk->exit_code = code;
+
+	if (!list_empty(&current->thread_group))
+		wait_threads();
 	exit_notify();
+	if (current->exit_signal != -1)
+		schedule();
 	preempt_disable();
-	if (current->exit_signal == -1)
-		release_task(current);
-	schedule();
+	free_task();
 	BUG();
 /*
  * In order to get rid of the "volatile function does return" message
--- linux/kernel/signal.c.orig	Thu Sep 12 09:56:54 2002
+++ linux/kernel/signal.c	Thu Sep 12 09:58:53 2002
@@ -250,24 +250,8 @@
 		BUG();
 	if (!atomic_read(&sig->count))
 		BUG();
-	spin_lock(&sig->siglock);
-	/*
-	 * Do not let the thread group leader exit until all other
-	 * threads are done:
-	 */
-	while (!list_empty(&current->thread_group) &&
-			current->tgid == current->pid &&
-			atomic_read(&sig->count) > 1) {
-
-		spin_unlock(&sig->siglock);
-		write_unlock_irq(&tasklist_lock);
-
-		wait_for_completion(&sig->group_exit_done);
-
-		write_lock_irq(&tasklist_lock);
-		spin_lock(&sig->siglock);
-	}
 
+	spin_lock(&sig->siglock);
 	spin_lock(&tsk->sigmask_lock);
 	tsk->sig = NULL;
 	if (atomic_dec_and_test(&sig->count)) {

