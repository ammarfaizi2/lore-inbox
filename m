Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVAWXfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVAWXfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVAWXe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:34:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33430 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261382AbVAWX0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:26:34 -0500
Date: Sun, 23 Jan 2005 15:26:29 -0800
Message-Id: <200501232326.j0NNQTVY006529@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH 5/7] make ITIMER_REAL per-process
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX requires that setitimer, getitimer, and alarm work on a per-process
basis.  Currently, Linux implements these for individual threads.  This
patch fixes these semantics for the ITIMER_REAL timer (which generates
SIGALRM), making it shared by all threads in a process (thread group).


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/fs/proc/array.c
+++ linux-2.6/fs/proc/array.c
@@ -317,6 +317,7 @@ static int do_task_stat(struct task_stru
 	unsigned long  min_flt = 0,  maj_flt = 0;
 	cputime_t cutime, cstime, utime, stime;
 	unsigned long rsslim = 0;
+	unsigned long it_real_value = 0;
 	struct task_struct *t;
 	char tcomm[sizeof(task->comm)];
 
@@ -372,6 +373,7 @@ static int do_task_stat(struct task_stru
 			utime = cputime_add(utime, task->signal->utime);
 			stime = cputime_add(stime, task->signal->stime);
 		}
+		it_real_value = task->signal->it_real_value;
 	}
 	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
@@ -420,7 +422,7 @@ static int do_task_stat(struct task_stru
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
 	.children	= LIST_HEAD_INIT(tsk.children),			\
 	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
 	.group_leader	= &tsk,						\
-	.real_timer	= {						\
-		.function	= it_real_fn				\
-	},								\
 	.group_info	= &init_groups,					\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -300,6 +300,10 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	struct list_head posix_timers;
 
+	/* ITIMER_REAL timer for the process */
+	struct timer_list real_timer;
+	unsigned long it_real_value, it_real_incr;
+
 	/* job control IDs */
 	pid_t pgrp;
 	pid_t tty_old_pgrp;
@@ -604,10 +608,8 @@ struct task_struct {
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
 	unsigned long rt_priority;
-	unsigned long it_real_value, it_real_incr;
 	cputime_t it_virt_value, it_virt_incr;
 	cputime_t it_prof_value, it_prof_incr;
-	struct timer_list real_timer;
 	cputime_t utime, stime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	struct timespec start_time;
--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -802,7 +802,6 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 
 	tsk->flags |= PF_EXITING;
-	del_timer_sync(&tsk->real_timer);
 
 	if (unlikely(in_atomic()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
@@ -812,8 +811,10 @@ fastcall NORET_TYPE void do_exit(long co
 	acct_update_integrals();
 	update_mem_hiwater();
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
-	if (group_dead)
+	if (group_dead) {
+ 		del_timer_sync(&tsk->signal->real_timer);
 		acct_process(code);
+	}
 	exit_mm(tsk);
 
 	exit_sem(tsk);
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -743,6 +743,11 @@ static inline int copy_signal(unsigned l
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
@@ -873,14 +878,10 @@ static task_t *copy_process(unsigned lon
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
 
-	p->it_real_value = 0;
-	p->it_real_incr = 0;
 	p->it_virt_value = cputime_zero;
 	p->it_virt_incr = cputime_zero;
 	p->it_prof_value = cputime_zero;
 	p->it_prof_incr = cputime_zero;
-	init_timer(&p->real_timer);
-	p->real_timer.data = (unsigned long) p;
 
 	p->utime = cputime_zero;
 	p->stime = cputime_zero;
--- linux-2.6/kernel/itimer.c
+++ linux-2.6/kernel/itimer.c
@@ -14,25 +14,31 @@
 
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
-	register unsigned long val;
+	unsigned long interval, val;
 
 	switch (which) {
 	case ITIMER_REAL:
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
 		jiffies_to_timeval(val, &value->it_value);
-		jiffies_to_timeval(current->it_real_incr, &value->it_interval);
+		jiffies_to_timeval(interval, &value->it_interval);
 		break;
 	case ITIMER_VIRTUAL:
 		cputime_to_timeval(current->it_virt_value, &value->it_value);
@@ -48,7 +54,6 @@ int do_getitimer(int which, struct itime
 	return 0;
 }
 
-/* SMP: Only we modify our itimer values. */
 asmlinkage long sys_getitimer(int which, struct itimerval __user *value)
 {
 	int error = -EFAULT;
@@ -63,60 +68,88 @@ asmlinkage long sys_getitimer(int which,
 	return error;
 }
 
+/*
+ * Called with P->sighand->siglock held and P->signal->real_timer inactive.
+ * If interval is nonzero, arm the timer for interval ticks from now.
+ */
+static inline void it_real_arm(struct task_struct *p, unsigned long interval)
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
-	unsigned long expire;
+	struct task_struct *tsk = current;
+ 	unsigned long val, interval;
 	cputime_t cputime;
-	int k;
 
-	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)
-		return k;
 	switch (which) {
 		case ITIMER_REAL:
-			del_timer_sync(&current->real_timer);
-			expire = timeval_to_jiffies(&value->it_value);
-			current->it_real_value = expire;
-			current->it_real_incr =
+ 			spin_lock_irq(&tsk->sighand->siglock);
+ 			interval = tsk->signal->it_real_incr;
+ 			val = it_real_value(tsk->signal);
+ 			if (val) {
+ 				del_timer_sync(&tsk->signal->real_timer);
+			}
+ 			tsk->signal->it_real_incr =
 				timeval_to_jiffies(&value->it_interval);
-			if (!expire)
-				break;
-			if (expire > (unsigned long) LONG_MAX)
-				expire = LONG_MAX;
-			current->real_timer.expires = jiffies + expire;
-			add_timer(&current->real_timer);
+ 			it_real_arm(tsk, timeval_to_jiffies(&value->it_value));
+ 			spin_unlock_irq(&tsk->sighand->siglock);
+			if (ovalue) {
+				jiffies_to_timeval(val, &ovalue->it_value);
+				jiffies_to_timeval(interval,
+						   &ovalue->it_interval);
+			}
 			break;
 		case ITIMER_VIRTUAL:
+			if (ovalue) {
+				cputime_to_timeval(tsk->it_virt_value,
+						   &ovalue->it_value);
+				cputime_to_timeval(tsk->it_virt_incr,
+						   &ovalue->it_interval);
+			}
 			cputime = timeval_to_cputime(&value->it_value);
 			if (cputime_gt(cputime, cputime_zero))
 				cputime = cputime_add(cputime,
 						      jiffies_to_cputime(1));
-			current->it_virt_value = cputime;
+			tsk->it_virt_value = cputime;
 			cputime = timeval_to_cputime(&value->it_interval);
-			current->it_virt_incr = cputime;
+			tsk->it_virt_incr = cputime;
 			break;
 		case ITIMER_PROF:
+			if (ovalue) {
+				cputime_to_timeval(tsk->it_prof_value,
+						   &ovalue->it_value);
+				cputime_to_timeval(tsk->it_prof_incr,
+						   &ovalue->it_interval);
+			}
 			cputime = timeval_to_cputime(&value->it_value);
 			if (cputime_gt(cputime, cputime_zero))
 				cputime = cputime_add(cputime,
 						      jiffies_to_cputime(1));
-			current->it_prof_value = cputime;
+			tsk->it_prof_value = cputime;
 			cputime = timeval_to_cputime(&value->it_interval);
-			current->it_prof_incr = cputime;
+			tsk->it_prof_incr = cputime;
 			break;
 		default:
 			return -EINVAL;
@@ -124,9 +157,6 @@ int do_setitimer(int which, struct itime
 	return 0;
 }
 
-/* SMP: Again, only we play with our itimers, and signals are SMP safe
- *      now so that is not an issue at all anymore.
- */
 asmlinkage long sys_setitimer(int which,
 			      struct itimerval __user *value,
 			      struct itimerval __user *ovalue)
