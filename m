Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbULNEIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbULNEIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbULNEH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:07:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62920 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261396AbULND5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:57:53 -0500
Date: Mon, 13 Dec 2004 19:57:42 -0800
Message-Id: <200412140357.iBE3vg0k008058@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] make ITIMER_REAL per-process
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


POSIX requires that setitimer, getitimer, and alarm work on a per-process
basis.  Currently, Linux implements these for individual threads.  This
patch fixes these semantics for the ITIMER_REAL timer (which generates
SIGALRM), making it shared by all threads in a process (thread group).


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/fs/proc/array.c
+++ linux-2.6/fs/proc/array.c
@@ -315,6 +315,7 @@ static int do_task_stat(struct task_stru
 	unsigned long cmin_flt = 0, cmaj_flt = 0, cutime = 0, cstime = 0;
 	unsigned long  min_flt = 0,  maj_flt = 0,  utime = 0,  stime = 0;
 	unsigned long rsslim = 0;
+	unsigned long it_real_value = 0;
 	struct task_struct *t;
 	char tcomm[sizeof(task->comm)];
 
@@ -369,6 +370,7 @@ static int do_task_stat(struct task_stru
 			utime += task->signal->utime;
 			stime += task->signal->stime;
 		}
+		it_real_value = task->signal->it_real_value;
 	}
 	ppid = task->pid ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
@@ -417,7 +419,7 @@ static int do_task_stat(struct task_stru
 		priority,
 		nice,
 		num_threads,
-		jiffies_to_clock_t(task->it_real_value),
+		jiffies_to_clock_t(it_real_value),
 		start_time,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
--- linux-2.6/include/linux/init_task.h
+++ linux-2.6/include/linux/init_task.h
@@ -90,9 +90,6 @@ extern struct group_info init_groups;
 	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
 	.group_leader	= &tsk,						\
 	.wait_chldexit	= __WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
-	.real_timer	= {						\
-		.function	= it_real_fn				\
-	},								\
 	.group_info	= &init_groups,					\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -293,6 +293,10 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	struct list_head posix_timers;
 
+	/* ITIMER_REAL timer for the process */
+	struct timer_list real_timer;
+	unsigned long it_real_value, it_real_incr;
+
 	/* job control IDs */
 	pid_t pgrp;
 	pid_t tty_old_pgrp;
@@ -598,9 +602,8 @@ struct task_struct {
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
 	unsigned long rt_priority;
-	unsigned long it_real_value, it_prof_value, it_virt_value;
-	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
-	struct timer_list real_timer;
+	unsigned long it_prof_value, it_virt_value;
+	unsigned long it_prof_incr, it_virt_incr;
 	unsigned long utime, stime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	struct timespec start_time;
--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -798,7 +798,6 @@ fastcall NORET_TYPE void do_exit(long co
 	if (tsk->io_context)
 		exit_io_context();
 	tsk->flags |= PF_EXITING;
-	del_timer_sync(&tsk->real_timer);
 
 	if (unlikely(in_atomic()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
@@ -811,8 +810,10 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
-	if (group_dead)
+	if (group_dead) {
+		del_timer_sync(&tsk->signal->real_timer);
 		acct_process(code);
+	}
 	__exit_mm(tsk);
 
 	exit_sem(tsk);
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -738,6 +738,11 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
+	sig->it_real_value = sig->it_real_incr = 0;
+	sig->real_timer.function = it_real_fn;
+	sig->real_timer.data = (unsigned long) tsk;
+	init_timer(&sig->real_timer);
+
 	sig->tty = current->signal->tty;
 	sig->pgrp = process_group(current);
 	sig->session = current->signal->session;
@@ -869,10 +874,8 @@ static task_t *copy_process(unsigned lon
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
 
-	p->it_real_value = p->it_virt_value = p->it_prof_value = 0;
-	p->it_real_incr = p->it_virt_incr = p->it_prof_incr = 0;
-	init_timer(&p->real_timer);
-	p->real_timer.data = (unsigned long) p;
+	p->it_virt_value = p->it_prof_value = 0;
+	p->it_virt_incr = p->it_prof_incr = 0;
 
 	p->utime = p->stime = 0;
 	p->sched_time = 0;
--- linux-2.6/kernel/itimer.c
+++ linux-2.6/kernel/itimer.c
@@ -14,24 +14,29 @@
 
 #include <asm/uaccess.h>
 
+static unsigned long it_real_value(struct signal_struct *sig)
+{
+	unsigned long val = 0;
+	if (timer_pending(&sig->real_timer)) {
+		val = sig->real_timer.expires - jiffies;
+
+		/* look out for negative/zero itimer.. */
+		if ((long) val <= 0)
+			val = 1;
+	}
+	return val;
+}
+
 int do_getitimer(int which, struct itimerval *value)
 {
 	register unsigned long val, interval;
 
 	switch (which) {
 	case ITIMER_REAL:
-		interval = current->it_real_incr;
-		val = 0;
-		/* 
-		 * FIXME! This needs to be atomic, in case the kernel timer happens!
-		 */
-		if (timer_pending(&current->real_timer)) {
-			val = current->real_timer.expires - jiffies;
-
-			/* look out for negative/zero itimer.. */
-			if ((long) val <= 0)
-				val = 1;
-		}
+		spin_lock_irq(&current->sighand->siglock);
+		interval = current->signal->it_real_incr;
+		val = it_real_value(current->signal);
+		spin_unlock_irq(&current->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:
 		val = current->it_virt_value;
@@ -49,7 +54,6 @@ int do_getitimer(int which, struct itime
 	return 0;
 }
 
-/* SMP: Only we modify our itimer values. */
 asmlinkage long sys_getitimer(int which, struct itimerval __user *value)
 {
 	int error = -EFAULT;
@@ -64,50 +68,65 @@ asmlinkage long sys_getitimer(int which,
 	return error;
 }
 
+/*
+ * Called with P->sighand->siglock held and P->signal->real_timer inactive.
+ * If interval is nonzero, arm the timer for interval ticks from now.
+ */
+static void it_real_arm(struct task_struct *p, unsigned long interval)
+{
+	p->signal->it_real_value = interval; /* XXX unnecessary field?? */
+	if (interval == 0)
+		return;
+	if (interval > (unsigned long) LONG_MAX)
+		interval = LONG_MAX;
+	p->signal->real_timer.expires = jiffies + interval;
+	add_timer(&p->signal->real_timer);
+}
+
 void it_real_fn(unsigned long __data)
 {
 	struct task_struct * p = (struct task_struct *) __data;
-	unsigned long interval;
 
 	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, p);
-	interval = p->it_real_incr;
-	if (interval) {
-		if (interval > (unsigned long) LONG_MAX)
-			interval = LONG_MAX;
-		p->real_timer.expires = jiffies + interval;
-		add_timer(&p->real_timer);
-	}
+
+	/*
+	 * Now restart the timer if necessary.  We don't need any locking
+	 * here because do_setitimer makes sure we have finished running
+	 * before it touches anything.
+	 */
+	it_real_arm(p, p->signal->it_real_incr);
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
+	struct task_struct *tsk = current;
+	unsigned long val, interval;
 	register unsigned long i, j;
-	int k;
 
 	i = timeval_to_jiffies(&value->it_interval);
 	j = timeval_to_jiffies(&value->it_value);
-	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)
-		return k;
 	switch (which) {
 		case ITIMER_REAL:
-			del_timer_sync(&current->real_timer);
-			current->it_real_value = j;
-			current->it_real_incr = i;
-			if (!j)
-				break;
-			if (j > (unsigned long) LONG_MAX)
-				j = LONG_MAX;
-			i = j + jiffies;
-			current->real_timer.expires = i;
-			add_timer(&current->real_timer);
+			spin_lock_irq(&tsk->sighand->siglock);
+			interval = tsk->signal->it_real_incr;
+			val = it_real_value(tsk->signal);
+			if (val)
+				del_timer_sync(&tsk->signal->real_timer);
+			tsk->signal->it_real_incr = i;
+			it_real_arm(tsk, j);
+			spin_unlock_irq(&tsk->sighand->siglock);
 			break;
 		case ITIMER_VIRTUAL:
+			interval = tsk->it_virt_incr;
+			val = tsk->it_virt_value;
 			if (j)
 				j++;
 			current->it_virt_value = j;
 			current->it_virt_incr = i;
 			break;
 		case ITIMER_PROF:
+			interval = tsk->it_prof_incr;
+			val = tsk->it_prof_value;
 			if (j)
 				j++;
 			current->it_prof_value = j;
@@ -116,12 +135,13 @@ int do_setitimer(int which, struct itime
 		default:
 			return -EINVAL;
 	}
+	if (ovalue) {
+		jiffies_to_timeval(val, &ovalue->it_value);
+		jiffies_to_timeval(interval, &ovalue->it_interval);
+	}
 	return 0;
 }
 
-/* SMP: Again, only we play with our itimers, and signals are SMP safe
- *      now so that is not an issue at all anymore.
- */
 asmlinkage long sys_setitimer(int which,
 			      struct itimerval __user *value,
 			      struct itimerval __user *ovalue)
