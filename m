Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319110AbSHMTvi>; Tue, 13 Aug 2002 15:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319112AbSHMTvi>; Tue, 13 Aug 2002 15:51:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33446 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319110AbSHMTv2>;
	Tue, 13 Aug 2002 15:51:28 -0400
Date: Tue, 13 Aug 2002 21:55:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131241550.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132153180.9495-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> > it - this is not really a clone() property but an exit-signalling
> > property.
> 
> Right. I think that it makes more sense to do it that way. Clearly the
> parent doesn't care about the exit if the signal is zero.

the attached patch implements this (it's ontop of the SETTLS/SETTID patch
for sched.h conflict reasons), i've tested it with signal 0 threads and it
appears to work fine. (I have not tested kmod yet - that comes next.)

and looks pretty straightforward - !current->exit_signal is a good and
natural test.

	Ingo

--- linux/kernel/exit.c.orig	Tue Aug 13 21:01:50 2002
+++ linux/kernel/exit.c	Tue Aug 13 21:49:35 2002
@@ -56,10 +56,13 @@
 
 static void release_task(struct task_struct * p)
 {
-	if (p == current)
+	if (p == current && p->exit_signal)
+		BUG();
+	if (p->state != TASK_ZOMBIE)
 		BUG();
 #ifdef CONFIG_SMP
-	wait_task_inactive(p);
+	if (p != current)
+		wait_task_inactive(p);
 #endif
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
@@ -67,10 +70,12 @@
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
 
@@ -479,14 +484,15 @@
 
 	write_lock_irq(&tasklist_lock);
 	current->state = TASK_ZOMBIE;
-	do_notify_parent(current, current->exit_signal);
+	if (current->exit_signal)
+		do_notify_parent(current, current->exit_signal);
 	while ((p = eldest_child(current))) {
 		list_del_init(&p->sibling);
 		p->ptrace = 0;
 
 		p->parent = p->real_parent;
 		list_add_tail(&p->sibling,&p->parent->children);
-		if (p->state == TASK_ZOMBIE)
+		if (p->state == TASK_ZOMBIE && p->exit_signal)
 			do_notify_parent(p, p->exit_signal);
 		/*
 		 * process group orphan check
@@ -555,6 +561,9 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+	preempt_disable();
+	if (!current->exit_signal)
+		release_task(current);
 	schedule();
 	BUG();
 /*
--- linux/kernel/signal.c.orig	Tue Aug 13 21:02:04 2002
+++ linux/kernel/signal.c	Tue Aug 13 21:48:01 2002
@@ -768,12 +768,14 @@
 /*
  * Let a parent know about a status change of a child.
  */
-
 void do_notify_parent(struct task_struct *tsk, int sig)
 {
 	struct siginfo info;
 	int why, status;
 
+	if (!sig || !tsk->exit_signal)
+		BUG();
+
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_pid = tsk->pid;
@@ -823,9 +825,11 @@
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
--- linux/kernel/fork.c.orig	Tue Aug 13 21:02:04 2002
+++ linux/kernel/fork.c	Tue Aug 13 21:45:14 2002
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

