Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVAWXco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVAWXco (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVAWXcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:32:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261383AbVAWX1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:27:10 -0500
Date: Sun, 23 Jan 2005 15:27:05 -0800
Message-Id: <200501232327.j0NNR5q0006535@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH 6/7] make ITIMER_PROF, ITIMER_VIRTUAL per-process
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
@@ -127,5 +127,7 @@ void run_posix_cpu_timers(struct task_st
 void posix_cpu_timers_exit(struct task_struct *);
 void posix_cpu_timers_exit_group(struct task_struct *);
 
+void set_process_cpu_timer(struct task_struct *, unsigned int,
+			   cputime_t *, cputime_t *);
 
 #endif
--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -304,6 +304,10 @@ struct signal_struct {
 	struct timer_list real_timer;
 	unsigned long it_real_value, it_real_incr;
 
+	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
+	cputime_t it_prof_expires, it_virt_expires;
+	cputime_t it_prof_incr, it_virt_incr;
+
 	/* job control IDs */
 	pid_t pgrp;
 	pid_t tty_old_pgrp;
@@ -608,8 +612,6 @@ struct task_struct {
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
 	unsigned long rt_priority;
-	cputime_t it_virt_value, it_virt_incr;
-	cputime_t it_prof_value, it_prof_incr;
 	cputime_t utime, stime;
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
@@ -757,8 +757,6 @@ static void exit_notify(struct task_stru
 	 * Clear these here so that update_process_times() won't try to deliver
 	 * itimer, profile or rlimit signals to this task while it is in late exit.
 	 */
-	tsk->it_virt_value = cputime_zero;
-	tsk->it_prof_value = cputime_zero;
  	tsk->it_virt_expires = cputime_zero;
  	tsk->it_prof_expires = cputime_zero;
 	tsk->it_sched_expires = 0;
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -748,6 +748,11 @@ static inline int copy_signal(unsigned l
 	sig->real_timer.data = (unsigned long) tsk;
 	init_timer(&sig->real_timer);
 
+	sig->it_virt_expires = cputime_zero;
+	sig->it_virt_incr = cputime_zero;
+	sig->it_prof_expires = cputime_zero;
+	sig->it_prof_incr = cputime_zero;
+
 	sig->tty = current->signal->tty;
 	sig->pgrp = process_group(current);
 	sig->session = current->signal->session;
@@ -878,11 +883,6 @@ static task_t *copy_process(unsigned lon
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
 
-	p->it_virt_value = cputime_zero;
-	p->it_virt_incr = cputime_zero;
-	p->it_prof_value = cputime_zero;
-	p->it_prof_incr = cputime_zero;
-
 	p->utime = cputime_zero;
 	p->stime = cputime_zero;
  	p->sched_time = 0;
@@ -1031,7 +1031,11 @@ static task_t *copy_process(unsigned lon
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
-		if (!list_empty(&current->signal->cpu_timers[0]) ||
+		if (!cputime_eq(current->signal->it_virt_expires,
+				cputime_zero) ||
+		    !cputime_eq(current->signal->it_prof_expires,
+				cputime_zero) ||
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
 
@@ -29,24 +30,67 @@ static unsigned long it_real_value(struc
 
 int do_getitimer(int which, struct itimerval *value)
 {
+	struct task_struct *tsk = current;
 	unsigned long interval, val;
+	cputime_t cinterval, cval;
 
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
 		jiffies_to_timeval(val, &value->it_value);
 		jiffies_to_timeval(interval, &value->it_interval);
 		break;
 	case ITIMER_VIRTUAL:
-		cputime_to_timeval(current->it_virt_value, &value->it_value);
-		cputime_to_timeval(current->it_virt_incr, &value->it_interval);
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		cval = tsk->signal->it_virt_expires;
+		cinterval = tsk->signal->it_virt_incr;
+		if (!cputime_eq(cval, cputime_zero)) {
+			struct task_struct *t = tsk;
+			cputime_t utime = tsk->signal->utime;
+			do {
+				utime = cputime_add(utime, t->utime);
+				t = next_thread(t);
+			} while (t != tsk);
+			if (cputime_le(cval, utime)) { /* about to fire */
+				val = jiffies_to_cputime(1);
+			} else {
+				val = cputime_sub(val, utime);
+			}
+		}
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
+		cputime_to_timeval(cval, &value->it_value);
+		cputime_to_timeval(cinterval, &value->it_interval);
 		break;
 	case ITIMER_PROF:
-		cputime_to_timeval(current->it_prof_value, &value->it_value);
-		cputime_to_timeval(current->it_prof_incr, &value->it_interval);
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		cval = tsk->signal->it_prof_expires;
+		cinterval = tsk->signal->it_prof_incr;
+		if (!cputime_eq(cval, cputime_zero)) {
+			struct task_struct *t = tsk;
+			cputime_t ptime = cputime_add(tsk->signal->utime,
+						      tsk->signal->stime);
+			do {
+				ptime = cputime_add(ptime,
+						    cputime_add(t->utime,
+								t->stime));
+				t = next_thread(t);
+			} while (t != tsk);
+			if (cputime_le(cval, ptime)) { /* about to fire */
+				val = jiffies_to_cputime(1);
+			} else {
+				val = cputime_sub(val, ptime);
+			}
+		}
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
+		cputime_to_timeval(cval, &value->it_value);
+		cputime_to_timeval(cinterval, &value->it_interval);
 		break;
 	default:
 		return(-EINVAL);
@@ -101,58 +145,76 @@ int do_setitimer(int which, struct itime
 {
 	struct task_struct *tsk = current;
  	unsigned long val, interval;
-	cputime_t cputime;
+	cputime_t cval, cinterval, nval, ninterval;
 
 	switch (which) {
-		case ITIMER_REAL:
- 			spin_lock_irq(&tsk->sighand->siglock);
- 			interval = tsk->signal->it_real_incr;
- 			val = it_real_value(tsk->signal);
- 			if (val) {
- 				del_timer_sync(&tsk->signal->real_timer);
-			}
- 			tsk->signal->it_real_incr =
-				timeval_to_jiffies(&value->it_interval);
- 			it_real_arm(tsk, timeval_to_jiffies(&value->it_value));
- 			spin_unlock_irq(&tsk->sighand->siglock);
-			if (ovalue) {
-				jiffies_to_timeval(val, &ovalue->it_value);
-				jiffies_to_timeval(interval,
-						   &ovalue->it_interval);
-			}
-			break;
-		case ITIMER_VIRTUAL:
-			if (ovalue) {
-				cputime_to_timeval(tsk->it_virt_value,
-						   &ovalue->it_value);
-				cputime_to_timeval(tsk->it_virt_incr,
-						   &ovalue->it_interval);
-			}
-			cputime = timeval_to_cputime(&value->it_value);
-			if (cputime_gt(cputime, cputime_zero))
-				cputime = cputime_add(cputime,
-						      jiffies_to_cputime(1));
-			tsk->it_virt_value = cputime;
-			cputime = timeval_to_cputime(&value->it_interval);
-			tsk->it_virt_incr = cputime;
-			break;
-		case ITIMER_PROF:
-			if (ovalue) {
-				cputime_to_timeval(tsk->it_prof_value,
-						   &ovalue->it_value);
-				cputime_to_timeval(tsk->it_prof_incr,
-						   &ovalue->it_interval);
-			}
-			cputime = timeval_to_cputime(&value->it_value);
-			if (cputime_gt(cputime, cputime_zero))
-				cputime = cputime_add(cputime,
-						      jiffies_to_cputime(1));
-			tsk->it_prof_value = cputime;
-			cputime = timeval_to_cputime(&value->it_interval);
-			tsk->it_prof_incr = cputime;
-			break;
-		default:
-			return -EINVAL;
+	case ITIMER_REAL:
+		spin_lock_irq(&tsk->sighand->siglock);
+		interval = tsk->signal->it_real_incr;
+		val = it_real_value(tsk->signal);
+		if (val) {
+			del_timer_sync(&tsk->signal->real_timer);
+		}
+		tsk->signal->it_real_incr =
+			timeval_to_jiffies(&value->it_interval);
+		it_real_arm(tsk, timeval_to_jiffies(&value->it_value));
+		spin_unlock_irq(&tsk->sighand->siglock);
+		if (ovalue) {
+			jiffies_to_timeval(val, &ovalue->it_value);
+			jiffies_to_timeval(interval,
+					   &ovalue->it_interval);
+		}
+		break;
+	case ITIMER_VIRTUAL:
+		nval = timeval_to_cputime(&value->it_value);
+		ninterval = timeval_to_cputime(&value->it_interval);
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		cval = tsk->signal->it_virt_expires;
+		cinterval = tsk->signal->it_virt_incr;
+		if (!cputime_eq(cval, cputime_zero) ||
+		    !cputime_eq(nval, cputime_zero)) {
+			if (cputime_gt(nval, cputime_zero))
+				nval = cputime_add(nval,
+						   jiffies_to_cputime(1));
+			set_process_cpu_timer(tsk, CPUCLOCK_VIRT,
+					      &nval, &cval);
+		}
+		tsk->signal->it_virt_expires = nval;
+		tsk->signal->it_virt_incr = ninterval;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
+		if (ovalue) {
+			cputime_to_timeval(cval, &ovalue->it_value);
+			cputime_to_timeval(cinterval, &ovalue->it_interval);
+		}
+		break;
+	case ITIMER_PROF:
+		nval = timeval_to_cputime(&value->it_value);
+		ninterval = timeval_to_cputime(&value->it_interval);
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		cval = tsk->signal->it_prof_expires;
+		cinterval = tsk->signal->it_prof_incr;
+		if (!cputime_eq(cval, cputime_zero) ||
+		    !cputime_eq(nval, cputime_zero)) {
+			if (cputime_gt(nval, cputime_zero))
+				nval = cputime_add(nval,
+						   jiffies_to_cputime(1));
+			set_process_cpu_timer(tsk, CPUCLOCK_PROF,
+					      &nval, &cval);
+		}
+		tsk->signal->it_prof_expires = nval;
+		tsk->signal->it_prof_incr = ninterval;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		read_unlock(&tasklist_lock);
+		if (ovalue) {
+			cputime_to_timeval(cval, &ovalue->it_value);
+			cputime_to_timeval(cinterval, &ovalue->it_interval);
+		}
+		break;
+	default:
+		return -EINVAL;
 	}
 	return 0;
 }
--- linux-2.6/kernel/posix-cpu-timers.c
+++ linux-2.6/kernel/posix-cpu-timers.c
@@ -190,36 +190,31 @@ static int cpu_clock_sample(clockid_t wh
 /*
  * Sample a process (thread group) clock for the given group_leader task.
  * Must be called with tasklist_lock held for reading.
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
+ 	switch (clock_idx) {
 	default:
 		return -EINVAL;
 	case CPUCLOCK_PROF:
-		spin_lock_irqsave(&p->sighand->siglock, flags);
 		cpu->cpu = cputime_add(p->signal->utime, p->signal->stime);
 		do {
 			cpu->cpu = cputime_add(cpu->cpu, prof_ticks(t));
 			t = next_thread(t);
 		} while (t != p);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 		break;
 	case CPUCLOCK_VIRT:
-		spin_lock_irqsave(&p->sighand->siglock, flags);
 		cpu->cpu = p->signal->utime;
 		do {
 			cpu->cpu = cputime_add(cpu->cpu, virt_ticks(t));
 			t = next_thread(t);
 		} while (t != p);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
 		break;
 	case CPUCLOCK_SCHED:
-		spin_lock_irqsave(&p->sighand->siglock, flags);
 		cpu->sched = p->signal->sched_time;
 		/* Add in each other live thread.  */
 		while ((t = next_thread(t)) != p) {
@@ -237,12 +232,28 @@ static int cpu_clock_sample_group(clocki
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
 
 int posix_cpu_clock_get(clockid_t which_clock, struct timespec *tp)
 {
@@ -453,20 +464,22 @@ void posix_cpu_timers_exit_group(struct 
  * Set the expiry times of all the threads in the process so one of them
  * will go off before the process cumulative expiry total is reached.
  */
-static void
-process_timer_rebalance(struct k_itimer *timer, union cpu_time_count val)
+static void process_timer_rebalance(struct task_struct *p,
+				    unsigned int clock_idx,
+				    union cpu_time_count expires,
+				    union cpu_time_count val)
 {
 	cputime_t ticks, left;
 	unsigned long long ns, nsleft;
-	struct task_struct *const p = timer->it.cpu.task, *t = p;
+ 	struct task_struct *t = p;
 	unsigned int nthreads = atomic_read(&p->signal->live);
 
-	switch (CPUCLOCK_WHICH(timer->it_clock)) {
+	switch (clock_idx) {
 	default:
 		BUG();
 		break;
 	case CPUCLOCK_PROF:
-		left = cputime_sub(timer->it.cpu.expires.cpu, val.cpu)
+		left = cputime_sub(expires.cpu, val.cpu)
 			/ nthreads;
 		do {
 			if (!unlikely(t->exit_state)) {
@@ -481,7 +494,7 @@ process_timer_rebalance(struct k_itimer 
 		} while (t != p);
 		break;
 	case CPUCLOCK_VIRT:
-		left = cputime_sub(timer->it.cpu.expires.cpu, val.cpu)
+		left = cputime_sub(expires.cpu, val.cpu)
 			/ nthreads;
 		do {
 			if (!unlikely(t->exit_state)) {
@@ -496,7 +509,7 @@ process_timer_rebalance(struct k_itimer 
 		} while (t != p);
 		break;
 	case CPUCLOCK_SCHED:
-		nsleft = timer->it.cpu.expires.sched - val.sched;
+		nsleft = expires.sched - val.sched;
 		do_div(nsleft, nthreads);
 		do {
 			if (!unlikely(t->exit_state)) {
@@ -590,7 +603,31 @@ static void arm_timer(struct k_itimer *t
 			 * For a process timer, we must balance
 			 * all the live threads' expirations.
 			 */
-			process_timer_rebalance(timer, now);
+			switch (CPUCLOCK_WHICH(timer->it_clock)) {
+			default:
+				BUG();
+			case CPUCLOCK_VIRT:
+				if (!cputime_eq(p->signal->it_virt_expires,
+						cputime_zero) &&
+				    cputime_lt(p->signal->it_virt_expires,
+					       timer->it.cpu.expires.cpu))
+					break;
+				goto rebalance;
+			case CPUCLOCK_PROF:
+				if (!cputime_eq(p->signal->it_prof_expires,
+						cputime_zero) &&
+				    cputime_lt(p->signal->it_prof_expires,
+					       timer->it.cpu.expires.cpu))
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
 
@@ -952,7 +989,9 @@ static void check_process_timers(struct 
 	 * Don't sample the current process CPU clocks if there are no timers.
 	 */
 	if (list_empty(&timers[CPUCLOCK_PROF]) &&
+	    cputime_eq(sig->it_prof_expires, cputime_zero) &&
 	    list_empty(&timers[CPUCLOCK_VIRT]) &&
+	    cputime_eq(sig->it_virt_expires, cputime_zero) &&
 	    list_empty(&timers[CPUCLOCK_SCHED]))
 		return;
 
@@ -1012,6 +1051,42 @@ static void check_process_timers(struct 
 		list_move_tail(&t->entry, firing);
 	}
 
+	/*
+	 * Check for the special case process timers.
+	 */
+	if (!cputime_eq(sig->it_prof_expires, cputime_zero)) {
+		if (cputime_ge(ptime, sig->it_prof_expires)) {
+			/* ITIMER_PROF fires and reloads.  */
+			sig->it_prof_expires = sig->it_prof_incr;
+			if (!cputime_eq(sig->it_prof_expires, cputime_zero)) {
+				sig->it_prof_expires = cputime_add(
+					sig->it_prof_expires, ptime);
+			}
+			__group_send_sig_info(SIGPROF, SEND_SIG_PRIV, tsk);
+		}
+		if (!cputime_eq(sig->it_prof_expires, cputime_zero) &&
+		    (cputime_eq(prof_expires, cputime_zero) ||
+		     cputime_lt(sig->it_prof_expires, prof_expires))) {
+			prof_expires = sig->it_prof_expires;
+		}
+	}
+	if (!cputime_eq(sig->it_virt_expires, cputime_zero)) {
+		if (cputime_ge(utime, sig->it_virt_expires)) {
+			/* ITIMER_VIRTUAL fires and reloads.  */
+			sig->it_virt_expires = sig->it_virt_incr;
+			if (!cputime_eq(sig->it_virt_expires, cputime_zero)) {
+				sig->it_virt_expires = cputime_add(
+					sig->it_virt_expires, utime);
+			}
+			__group_send_sig_info(SIGVTALRM, SEND_SIG_PRIV, tsk);
+		}
+		if (!cputime_eq(sig->it_virt_expires, cputime_zero) &&
+		    (cputime_eq(virt_expires, cputime_zero) ||
+		     cputime_lt(sig->it_virt_expires, virt_expires))) {
+			virt_expires = sig->it_virt_expires;
+		}
+	}
+
 	if (!cputime_eq(prof_expires, cputime_zero) ||
 	    !cputime_eq(virt_expires, cputime_zero) ||
 	    sched_expires != 0) {
@@ -1197,6 +1272,50 @@ void run_posix_cpu_timers(struct task_st
 	}
 }
 
+/*
+ * Set one of the process-wide special case CPU timers.
+ * The tasklist_lock and tsk->sighand->siglock must be held by the caller.
+ */
+void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
+			   cputime_t *newval, cputime_t *oldval)
+{
+	union cpu_time_count now;
+	struct list_head *head;
+
+	BUG_ON(clock_idx == CPUCLOCK_SCHED);
+	cpu_clock_sample_group_locked(clock_idx, tsk, &now);
+
+	if (oldval && !cputime_eq(*oldval, cputime_zero)) {
+		if (cputime_le(*oldval, now.cpu)) { /* Just about to fire. */
+			*oldval = jiffies_to_cputime(1);
+		} else {
+			*oldval = cputime_sub(*oldval, now.cpu);
+		}
+	}
+
+	if (cputime_eq(*newval, cputime_zero))
+		return;
+	*newval = cputime_add(*newval, now.cpu);
+
+	/*
+	 * Check whether there are any process timers already set to fire
+	 * before this one.  If so, we don't have anything more to do.
+	 */
+	head = &tsk->signal->cpu_timers[clock_idx];
+	if (list_empty(head) ||
+	    cputime_ge(list_entry(head->next,
+				  struct cpu_timer_list, entry)->expires.cpu,
+		       *newval)) {
+		/*
+		 * Rejigger each thread's expiry time so that one will
+		 * notice before we hit the process-cumulative expiry time.
+		 */
+		union cpu_time_count expires = { .sched = 0 };
+		expires.cpu = *newval;
+		process_timer_rebalance(tsk, clock_idx, expires, now);
+	}
+}
+
 static long posix_cpu_clock_nanosleep_restart(struct restart_block *);
 
 int posix_cpu_nsleep(clockid_t which_clock, int flags,
--- linux-2.6/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -2277,46 +2277,6 @@ unsigned long long current_sched_time(co
 			((rq)->curr->static_prio > (rq)->best_expired_prio))
 
 /*
- * Do the virtual cpu time signal calculations.
- * @p: the process that the cpu time gets accounted to
- * @cputime: the cpu time spent in user space since the last update
- */
-static inline void account_it_virt(struct task_struct * p, cputime_t cputime)
-{
-	cputime_t it_virt = p->it_virt_value;
-
-	if (cputime_gt(it_virt, cputime_zero) &&
-	    cputime_gt(cputime, cputime_zero)) {
-		if (cputime_ge(cputime, it_virt)) {
-			it_virt = cputime_add(it_virt, p->it_virt_incr);
-			send_sig(SIGVTALRM, p, 1);
-		}
-		it_virt = cputime_sub(it_virt, cputime);
-		p->it_virt_value = it_virt;
-	}
-}
-
-/*
- * Do the virtual profiling signal calculations.
- * @p: the process that the cpu time gets accounted to
- * @cputime: the cpu time spent in user and kernel space since the last update
- */
-static void account_it_prof(struct task_struct *p, cputime_t cputime)
-{
-	cputime_t it_prof = p->it_prof_value;
-
-	if (cputime_gt(it_prof, cputime_zero) &&
-	    cputime_gt(cputime, cputime_zero)) {
-		if (cputime_ge(cputime, it_prof)) {
-			it_prof = cputime_add(it_prof, p->it_prof_incr);
-			send_sig(SIGPROF, p, 1);
-		}
-		it_prof = cputime_sub(it_prof, cputime);
-		p->it_prof_value = it_prof;
-	}
-}
-
-/*
  * Check if the process went over its cputime resource limit after
  * some cpu time got added to utime/stime.
  * @p: the process that the cpu time gets accounted to
@@ -2353,10 +2313,8 @@ void account_user_time(struct task_struc
 
 	p->utime = cputime_add(p->utime, cputime);
 
-	/* Check for signals (SIGVTALRM, SIGPROF, SIGXCPU & SIGKILL). */
+	/* Check for signals (SIGXCPU & SIGKILL). */
 	check_rlimit(p, cputime);
-	account_it_virt(p, cputime);
-	account_it_prof(p, cputime);
 
 	/* Add user time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
@@ -2381,10 +2339,9 @@ void account_system_time(struct task_str
 
 	p->stime = cputime_add(p->stime, cputime);
 
-	/* Check for signals (SIGPROF, SIGXCPU & SIGKILL). */
+	/* Check for signals (SIGXCPU & SIGKILL). */
 	if (likely(p->signal && p->exit_state < EXIT_ZOMBIE)) {
 		check_rlimit(p, cputime);
-		account_it_prof(p, cputime);
 	}
 
 	/* Add system time to cpustat. */
--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -1051,7 +1051,7 @@ __group_complete_signal(int sig, struct 
 	return;
 }
 
-static int
+int
 __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	int ret = 0;
