Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbULNEL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbULNEL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbULNEL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:11:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12745 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261394AbULND63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:58:29 -0500
Date: Mon, 13 Dec 2004 19:58:24 -0800
Message-Id: <200412140358.iBE3wOV7008065@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] make ITIMER_PROF, ITIMER_VIRTUAL per-process
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


POSIX requires that setitimer, getitimer, and alarm work on a per-process
basis.  Currently, Linux implements these for individual threads.  This
patch fixes these semantics for the ITIMER_PROF timer (which generates
SIGPROF) and the ITIMER_VIRTUAL timer (which generates SIGVTALRM), making
them shared by all threads in a process (thread group).
This patch should be applied after the one that fixes ITIMER_REAL.

The essential machinery for these timers is tied into the new posix-timers
code for process CPU clocks and timers.  This patch requires the cputimers
patch and its dependencies.


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/include/linux/posix-timers.h
+++ linux-2.6/include/linux/posix-timers.h
@@ -127,4 +127,7 @@ void run_posix_cpu_timers(struct task_st
 void posix_cpu_timers_exit(struct task_struct *);
 void posix_cpu_timers_exit_group(struct task_struct *);
 
+void set_process_cpu_timer(struct task_struct *, unsigned int,
+			   unsigned long *, unsigned long *);
+
 #endif
--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -297,6 +297,10 @@ struct signal_struct {
 	struct timer_list real_timer;
 	unsigned long it_real_value, it_real_incr;
 
+	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
+	unsigned long it_prof_expires, it_virt_expires;
+	unsigned long it_prof_incr, it_virt_incr;
+
 	/* job control IDs */
 	pid_t pgrp;
 	pid_t tty_old_pgrp;
@@ -602,8 +606,6 @@ struct task_struct {
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
 	unsigned long rt_priority;
-	unsigned long it_prof_value, it_virt_value;
-	unsigned long it_prof_incr, it_virt_incr;
 	unsigned long utime, stime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	struct timespec start_time;
--- linux-2.6/include/linux/signal.h
+++ linux-2.6/include/linux/signal.h
@@ -212,6 +212,7 @@ static inline void init_sigpending(struc
 }
 
 extern int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
+extern int __group_send_sig_info(int, struct siginfo *, struct task_struct *);
 extern long do_sigpending(void __user *, unsigned long);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 
--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -759,8 +759,6 @@ static void exit_notify(struct task_stru
 	 * Clear these here so that update_process_times() won't try to deliver
 	 * itimer, profile or rlimit signals to this task while it is in late exit.
 	 */
-	tsk->it_virt_value = 0;
-	tsk->it_prof_value = 0;
 	tsk->it_virt_expires = 0;
 	tsk->it_prof_expires = 0;
 	tsk->it_sched_expires = 0;
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -743,6 +743,9 @@ static inline int copy_signal(unsigned l
 	sig->real_timer.data = (unsigned long) tsk;
 	init_timer(&sig->real_timer);
 
+	sig->it_virt_expires = sig->it_prof_expires = 0;
+	sig->it_virt_incr = sig->it_prof_incr = 0;
+
 	sig->tty = current->signal->tty;
 	sig->pgrp = process_group(current);
 	sig->session = current->signal->session;
@@ -874,9 +877,6 @@ static task_t *copy_process(unsigned lon
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
 
-	p->it_virt_value = p->it_prof_value = 0;
-	p->it_virt_incr = p->it_prof_incr = 0;
-
 	p->utime = p->stime = 0;
 	p->sched_time = 0;
 	p->it_virt_expires = p->it_prof_expires = 0;
@@ -1017,7 +1017,9 @@ static task_t *copy_process(unsigned lon
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
-		if (!list_empty(&current->signal->cpu_timers[0]) ||
+		if (current->signal->it_virt_expires != 0 ||
+		    current->signal->it_prof_expires != 0 ||
+		    !list_empty(&current->signal->cpu_timers[0]) ||
 		    !list_empty(&current->signal->cpu_timers[1]) ||
 		    !list_empty(&current->signal->cpu_timers[2])) {
 			/*
--- linux-2.6/kernel/itimer.c
+++ linux-2.6/kernel/itimer.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/syscalls.h>
 #include <linux/time.h>
+#include <linux/posix-timers.h>
 
 #include <asm/uaccess.h>
 
@@ -29,22 +30,58 @@ static unsigned long it_real_value(struc
 
 int do_getitimer(int which, struct itimerval *value)
 {
+	struct task_struct *tsk = current;
 	register unsigned long val, interval;
 
 	switch (which) {
 	case ITIMER_REAL:
-		spin_lock_irq(&current->sighand->siglock);
-		interval = current->signal->it_real_incr;
-		val = it_real_value(current->signal);
-		spin_unlock_irq(&current->sighand->siglock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		interval = tsk->signal->it_real_incr;
+		val = it_real_value(tsk->signal);
+		spin_unlock_irq(&tsk->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:
-		val = current->it_virt_value;
-		interval = current->it_virt_incr;
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		val = tsk->signal->it_virt_expires;
+		interval = tsk->signal->it_virt_incr;
+		if (val) {
+			struct task_struct *t = tsk;
+			unsigned long utime = tsk->signal->utime;
+			do {
+				utime += t->utime;
+				t = next_thread(t);
+			} while (t != tsk);
+			if (val <= utime) { /* Just about to fire.  */
+				val = 1;
+			} else {
+				val -= utime;
+			}
+		}
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
 		break;
 	case ITIMER_PROF:
-		val = current->it_prof_value;
-		interval = current->it_prof_incr;
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		val = tsk->signal->it_prof_expires;
+		interval = tsk->signal->it_prof_incr;
+		if (val) {
+			struct task_struct *t = tsk;
+			unsigned long ptime =
+				tsk->signal->utime + tsk->signal->stime;
+			do {
+				ptime += t->utime + t->stime;
+				t = next_thread(t);
+			} while (t != tsk);
+			if (val <= ptime) { /* Just about to fire.  */
+				val = 1;
+			} else {
+				val -= ptime;
+			}
+		}
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
 		break;
 	default:
 		return(-EINVAL);
@@ -100,40 +137,55 @@ void it_real_fn(unsigned long __data)
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
-	unsigned long val, interval;
-	register unsigned long i, j;
+	unsigned long val, interval, i, j;
 
 	i = timeval_to_jiffies(&value->it_interval);
 	j = timeval_to_jiffies(&value->it_value);
 	switch (which) {
-		case ITIMER_REAL:
-			spin_lock_irq(&tsk->sighand->siglock);
-			interval = tsk->signal->it_real_incr;
-			val = it_real_value(tsk->signal);
-			if (val)
-				del_timer_sync(&tsk->signal->real_timer);
-			tsk->signal->it_real_incr = i;
-			it_real_arm(tsk, j);
-			spin_unlock_irq(&tsk->sighand->siglock);
-			break;
-		case ITIMER_VIRTUAL:
-			interval = tsk->it_virt_incr;
-			val = tsk->it_virt_value;
+	case ITIMER_REAL:
+		spin_lock_irq(&tsk->sighand->siglock);
+		interval = tsk->signal->it_real_incr;
+		val = it_real_value(tsk->signal);
+		if (val)
+			del_timer_sync(&tsk->signal->real_timer);
+		tsk->signal->it_real_incr = i;
+		it_real_arm(tsk, j);
+		spin_unlock_irq(&tsk->sighand->siglock);
+		break;
+	case ITIMER_VIRTUAL:
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		val = tsk->signal->it_virt_expires;
+		interval = tsk->signal->it_virt_incr;
+		if (val || j) {
 			if (j)
 				j++;
-			current->it_virt_value = j;
-			current->it_virt_incr = i;
-			break;
-		case ITIMER_PROF:
-			interval = tsk->it_prof_incr;
-			val = tsk->it_prof_value;
+			set_process_cpu_timer(tsk, CPUCLOCK_VIRT,
+					      &j, &val);
+		}
+		tsk->signal->it_virt_expires = j;
+		tsk->signal->it_virt_incr = i;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
+		break;
+	case ITIMER_PROF:
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		val = tsk->signal->it_prof_expires;
+		interval = tsk->signal->it_prof_incr;
+		if (val || j) {
 			if (j)
 				j++;
-			current->it_prof_value = j;
-			current->it_prof_incr = i;
-			break;
-		default:
-			return -EINVAL;
+			set_process_cpu_timer(tsk, CPUCLOCK_PROF,
+					      &j, &val);
+		}
+		tsk->signal->it_prof_expires = j;
+		tsk->signal->it_prof_incr = i;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
+		break;
+	default:
+		return -EINVAL;
 	}
 	if (ovalue) {
 		jiffies_to_timeval(val, &ovalue->it_value);
--- linux-2.6/kernel/posix-cpu-timers.c
+++ linux-2.6/kernel/posix-cpu-timers.c
@@ -202,37 +202,31 @@ static int cpu_clock_sample(clockid_t wh
 
 /*
  * Sample a process (thread group) clock for the given group_leader task.
- * Must be called with tasklist_lock held for reading.
+ * Must be called with tasklist_lock held for reading, and p->sighand->siglock.
  */
-static int cpu_clock_sample_group(clockid_t which_clock,
-				  struct task_struct *p,
-				  union cpu_time_count *cpu)
+static int cpu_clock_sample_group_locked(unsigned int clock_idx,
+					 struct task_struct *p,
+					 union cpu_time_count *cpu)
 {
 	struct task_struct *t = p;
-	unsigned long flags;
-	switch (CPUCLOCK_WHICH(which_clock)) {
+	switch (clock_idx) {
 	default:
 		return -EINVAL;
 	case CPUCLOCK_PROF:
-		spin_lock_irqsave(&p->sighand->siglock, flags);
 		cpu->cpu = p->signal->utime + p->signal->stime;
 		do {
 			cpu->cpu += prof_ticks(t);
 			t = next_thread(t);
 		} while (t != p);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 		break;
 	case CPUCLOCK_VIRT:
-		spin_lock_irqsave(&p->sighand->siglock, flags);
 		cpu->cpu = p->signal->utime;
 		do {
 			cpu->cpu += virt_ticks(t);
 			t = next_thread(t);
 		} while (t != p);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 		break;
 	case CPUCLOCK_SCHED:
-		spin_lock_irqsave(&p->sighand->siglock, flags);
 		cpu->sched = p->signal->sched_time;
 		/* Add in each other live thread.  */
 		while ((t = next_thread(t)) != p) {
@@ -250,12 +244,28 @@ static int cpu_clock_sample_group(clocki
 		} else {
 			cpu->sched += p->sched_time;
 		}
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 		break;
 	}
 	return 0;
 }
 
+/*
+ * Sample a process (thread group) clock for the given group_leader task.
+ * Must be called with tasklist_lock held for reading.
+ */
+static int cpu_clock_sample_group(clockid_t which_clock,
+				  struct task_struct *p,
+				  union cpu_time_count *cpu)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	ret = cpu_clock_sample_group_locked(CPUCLOCK_WHICH(which_clock), p,
+					    cpu);
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	return ret;
+}
+
 
 int posix_cpu_clock_gettime(clockid_t which_clock, struct timespec __user *tp)
 {
@@ -463,19 +473,22 @@ void posix_cpu_timers_exit_group(struct 
  * will go off before the process cumulative expiry total is reached.
  */
 static void
-process_timer_rebalance(struct k_itimer *timer, union cpu_time_count val)
+process_timer_rebalance(struct task_struct *p,
+			unsigned int clock_idx,
+			union cpu_time_count expires,
+			union cpu_time_count val)
 {
 	unsigned long ticks, left;
 	unsigned long long ns, nsleft;
-	struct task_struct *const p = timer->it.cpu.task, *t = p;
+	struct task_struct *t = p;
 	unsigned int nthreads = atomic_read(&p->signal->live);
 
-	switch (CPUCLOCK_WHICH(timer->it_clock)) {
+	switch (clock_idx) {
 	default:
 		BUG();
 		break;
 	case CPUCLOCK_PROF:
-		left = (timer->it.cpu.expires.cpu - val.cpu) / nthreads;
+		left = (expires.cpu - val.cpu) / nthreads;
 		do {
 			if (!unlikely(t->exit_state)) {
 				ticks = prof_ticks(t) + left;
@@ -483,12 +496,11 @@ process_timer_rebalance(struct k_itimer 
 				    time_after(t->it_prof_expires, ticks)) {
 					t->it_prof_expires = ticks;
 				}
-			}
-			t = next_thread(t);
+			}			t = next_thread(t);
 		} while (t != p);
 		break;
 	case CPUCLOCK_VIRT:
-		left = (timer->it.cpu.expires.cpu - val.cpu) / nthreads;
+		left = (expires.cpu - val.cpu) / nthreads;
 		do {
 			if (!unlikely(t->exit_state)) {
 				ticks = virt_ticks(t) + left;
@@ -496,12 +508,11 @@ process_timer_rebalance(struct k_itimer 
 				    time_after(t->it_virt_expires, ticks)) {
 					t->it_virt_expires = ticks;
 				}
-			}
-			t = next_thread(t);
+			}			t = next_thread(t);
 		} while (t != p);
 		break;
 	case CPUCLOCK_SCHED:
-		nsleft = timer->it.cpu.expires.sched - val.sched;
+		nsleft = expires.sched - val.sched;
 		do_div(nsleft, nthreads);
 		do {
 			if (!unlikely(t->exit_state)) {
@@ -595,7 +606,29 @@ static void arm_timer(struct k_itimer *t
 			 * For a process timer, we must balance
 			 * all the live threads' expirations.
 			 */
-			process_timer_rebalance(timer, now);
+			switch (CPUCLOCK_WHICH(timer->it_clock)) {
+			default:
+				BUG();
+			case CPUCLOCK_VIRT:
+				if (p->signal->it_virt_expires != 0 &&
+				    time_before(p->signal->it_virt_expires,
+						timer->it.cpu.expires.cpu))
+					break;
+				goto rebalance;
+			case CPUCLOCK_PROF:
+				if (p->signal->it_prof_expires != 0 &&
+				    time_before(p->signal->it_prof_expires,
+						timer->it.cpu.expires.cpu))
+					break;
+				goto rebalance;
+			case CPUCLOCK_SCHED:
+			rebalance:
+				process_timer_rebalance(
+					timer->it.cpu.task,
+					CPUCLOCK_WHICH(timer->it_clock),
+					timer->it.cpu.expires, now);
+				break;
+			}
 		}
 	}
 
@@ -956,8 +989,8 @@ static void check_process_timers(struct 
 	/*
 	 * Don't sample the current process CPU clocks if there are no timers.
 	 */
-	if (list_empty(&timers[CPUCLOCK_PROF]) &&
-	    list_empty(&timers[CPUCLOCK_VIRT]) &&
+	if (list_empty(&timers[CPUCLOCK_PROF]) && sig->it_prof_expires == 0 &&
+	    list_empty(&timers[CPUCLOCK_VIRT]) && sig->it_virt_expires == 0 &&
 	    list_empty(&timers[CPUCLOCK_SCHED]))
 		return;
 
@@ -990,7 +1023,7 @@ static void check_process_timers(struct 
 
 	++timers;
 	virt_expires = 0;
-	while (!list_empty(timers)) {
+	while(!list_empty(timers)) {
 		struct cpu_timer_list *t = list_entry(timers->next,
 						      struct cpu_timer_list,
 						      entry);
@@ -1016,6 +1049,38 @@ static void check_process_timers(struct 
 		list_move_tail(&t->entry, firing);
 	}
 
+	/*
+	 * Check for the special case process timers.
+	 */
+	if (sig->it_prof_expires != 0) {
+		if (!time_before(utime + stime, sig->it_prof_expires)) {
+			/* ITIMER_PROF fires and reloads.  */
+			sig->it_prof_expires = sig->it_prof_incr;
+			if (sig->it_prof_expires != 0)
+				sig->it_prof_expires += utime + stime;
+			__group_send_sig_info(SIGPROF, SEND_SIG_PRIV, tsk);
+		}
+		if (sig->it_prof_expires != 0 &&
+		    (prof_expires == 0 ||
+		     time_before(sig->it_prof_expires, prof_expires))) {
+			prof_expires = sig->it_prof_expires;
+		}
+	}
+	if (sig->it_virt_expires != 0) {
+		if (!time_before(utime, sig->it_virt_expires)) {
+			/* ITIMER_VIRTUAL fires and reloads.  */
+			sig->it_virt_expires = sig->it_virt_incr;
+			if (sig->it_virt_expires != 0)
+				sig->it_virt_expires += utime;
+			__group_send_sig_info(SIGVTALRM, SEND_SIG_PRIV, tsk);
+		}
+		if (sig->it_virt_expires != 0 &&
+		    (virt_expires == 0 ||
+		     time_before(sig->it_virt_expires, virt_expires))) {
+			virt_expires = sig->it_virt_expires;
+		}
+	}
+
 	if (prof_expires | virt_expires | sched_expires) {
 		/*
 		 * Rebalance the threads' expiry times for the remaining
@@ -1320,3 +1385,47 @@ posix_cpu_clock_nanosleep_restart(struct
 		return -EFAULT;
 	return ret;
 }
+
+/*
+ * Set one of the process-wide special case CPU timers.
+ * The tasklist_lock and tsk->sighand->siglock must be held by the caller.
+ */
+void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
+			   unsigned long *newval, unsigned long *oldval)
+{
+	union cpu_time_count now;
+	struct list_head *head;
+
+	BUG_ON(clock_idx == CPUCLOCK_SCHED);
+	cpu_clock_sample_group_locked(clock_idx, tsk, &now);
+
+	if (oldval && *oldval) {
+		if (*oldval <= now.cpu) { /* Just about to fire. */
+			*oldval = 1;
+		} else {
+			*oldval -= now.cpu;
+		}
+	}
+
+	if (*newval == 0)
+		return;
+	*newval += now.cpu;
+
+	/*
+	 * Check whether there are any process timers already set to fire
+	 * before this one.  If so, we don't have anything more to do.
+	 */
+	head = &tsk->signal->cpu_timers[clock_idx];
+	if (list_empty(head) ||
+	    !time_before(list_entry(head->next,
+				    struct cpu_timer_list, entry)->expires.cpu,
+			 *newval)) {
+		/*
+		 * Rejigger each thread's expiry time so that one will
+		 * notice before we hit the process-cumulative expiry time.
+		 */
+		union cpu_time_count expires = { .sched = 0 };
+		expires.cpu = *newval;
+		process_timer_rebalance(tsk, clock_idx, expires, now);
+	}
+}
--- linux-2.6/kernel/posix-timers.c
+++ linux-2.6/kernel/posix-timers.c
@@ -1271,7 +1271,7 @@ sys_clock_gettime(clockid_t which_clock,
 		return posix_cpu_clock_gettime(which_clock, tp);
 
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
-	    !posix_clocks[which_clock].res)
+					!posix_clocks[which_clock].res)
 		return -EINVAL;
 
 	error = do_posix_gettime(&posix_clocks[which_clock], &kernel_tp);
@@ -1398,7 +1398,7 @@ void clock_was_set(void)
 			break;
 		}
 		timr = list_entry(cws_list.next, struct k_itimer,
-				  it.real.abs_timer_entry);
+				   it.real.abs_timer_entry);
 
 		list_del_init(&timr->it.real.abs_timer_entry);
 		if (add_clockset_delta(timr, &new_wall_to) &&
--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -550,21 +550,21 @@ int dequeue_signal(struct task_struct *t
 	if (!signr)
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info);
- 	if (signr && unlikely(sig_kernel_stop(signr))) {
- 		/*
- 		 * Set a marker that we have dequeued a stop signal.  Our
- 		 * caller might release the siglock and then the pending
- 		 * stop signal it is about to process is no longer in the
- 		 * pending bitmasks, but must still be cleared by a SIGCONT
- 		 * (and overruled by a SIGKILL).  So those cases clear this
- 		 * shared flag after we've set it.  Note that this flag may
- 		 * remain set after the signal we return is ignored or
- 		 * handled.  That doesn't matter because its only purpose
- 		 * is to alert stop-signal processing code when another
- 		 * processor has come along and cleared the flag.
- 		 */
- 		tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
- 	}
+	if (signr && unlikely(sig_kernel_stop(signr))) {
+		/*
+		 * Set a marker that we have dequeued a stop signal.  Our
+		 * caller might release the siglock and then the pending
+		 * stop signal it is about to process is no longer in the
+		 * pending bitmasks, but must still be cleared by a SIGCONT
+		 * (and overruled by a SIGKILL).  So those cases clear this
+		 * shared flag after we've set it.  Note that this flag may
+		 * remain set after the signal we return is ignored or
+		 * handled.  That doesn't matter because its only purpose
+		 * is to alert stop-signal processing code when another
+		 * processor has come along and cleared the flag.
+		 */
+		tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
+	}
 	if ( signr &&
 	     ((info->si_code & __SI_MASK) == __SI_TIMER) &&
 	     info->si_sys_private){
@@ -1046,7 +1046,7 @@ __group_complete_signal(int sig, struct 
 	return;
 }
 
-static int
+int
 __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	int ret = 0;
--- linux-2.6/kernel/timer.c
+++ linux-2.6/kernel/timer.c
@@ -818,39 +818,10 @@ static inline void do_process_times(stru
 	}
 }
 
-static inline void do_it_virt(struct task_struct * p, unsigned long ticks)
-{
-	unsigned long it_virt = p->it_virt_value;
-
-	if (it_virt) {
-		it_virt -= ticks;
-		if (!it_virt) {
-			it_virt = p->it_virt_incr;
-			send_sig(SIGVTALRM, p, 1);
-		}
-		p->it_virt_value = it_virt;
-	}
-}
-
-static inline void do_it_prof(struct task_struct *p)
-{
-	unsigned long it_prof = p->it_prof_value;
-
-	if (it_prof) {
-		if (--it_prof == 0) {
-			it_prof = p->it_prof_incr;
-			send_sig(SIGPROF, p, 1);
-		}
-		p->it_prof_value = it_prof;
-	}
-}
-
 static void update_one_process(struct task_struct *p, unsigned long user,
 			unsigned long system, int cpu)
 {
 	do_process_times(p, user, system);
-	do_it_virt(p, user);
-	do_it_prof(p);
 }	
 
 /*
