Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVAWXaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVAWXaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVAWXaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:30:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56982 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261384AbVAWX1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:27:51 -0500
Date: Sun, 23 Jan 2005 15:27:46 -0800
Message-Id: <200501232327.j0NNRkm5006541@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH 7/7] make RLIMIT_CPU/SIGXCPU per-process
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX requires that the RLIMIT_CPU resource limit that generates SIGXCPU be
counted on a per-process basis.  Currently, Linux implements this for
individual threads.  This patch fixes the semantics to conform with POSIX.

The essential machinery for the process CPU limit is is tied into the new
posix-timers code for process CPU clocks and timers.  This patch requires
the cputimers patch and its dependencies.  This patch is also meant to be
applied after the setitimer fixes for CPU timers.


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -768,6 +768,15 @@ static inline int copy_signal(unsigned l
 	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
 	task_unlock(current->group_leader);
 
+	if (sig->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY) {
+		/*
+		 * New sole thread in the process gets an expiry time
+		 * of the whole CPU time limit.
+		 */
+		tsk->it_prof_expires =
+			secs_to_cputime(sig->rlim[RLIMIT_CPU].rlim_cur);
+	}
+
 	return 0;
 }
 
@@ -1032,6 +1041,7 @@ static task_t *copy_process(unsigned lon
 				cputime_zero) ||
 		    !cputime_eq(current->signal->it_prof_expires,
 				cputime_zero) ||
+		    current->signal->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY ||
 		    !list_empty(&current->signal->cpu_timers[0]) ||
 		    !list_empty(&current->signal->cpu_timers[1]) ||
 		    !list_empty(&current->signal->cpu_timers[2])) {
--- linux-2.6/kernel/posix-cpu-timers.c
+++ linux-2.6/kernel/posix-cpu-timers.c
@@ -549,6 +549,7 @@ static void arm_timer(struct k_itimer *t
 	struct list_head *head, *listpos;
 	struct cpu_timer_list *const nt = &timer->it.cpu;
 	struct cpu_timer_list *next;
+	unsigned long i;
 
 	head = (CPUCLOCK_PERTHREAD(timer->it_clock) ?
 		p->cpu_timers : p->signal->cpu_timers);
@@ -619,6 +620,10 @@ static void arm_timer(struct k_itimer *t
 				    cputime_lt(p->signal->it_prof_expires,
 					       timer->it.cpu.expires.cpu))
 					break;
+				i = p->signal->rlim[RLIMIT_CPU].rlim_cur;
+				if (i != RLIM_INFINITY &&
+				    i <= cputime_to_secs(timer->it.cpu.expires.cpu))
+					break;
 				goto rebalance;
 			case CPUCLOCK_SCHED:
 			rebalance:
@@ -990,6 +995,7 @@ static void check_process_timers(struct 
 	 */
 	if (list_empty(&timers[CPUCLOCK_PROF]) &&
 	    cputime_eq(sig->it_prof_expires, cputime_zero) &&
+	    sig->rlim[RLIMIT_CPU].rlim_cur == RLIM_INFINITY &&
 	    list_empty(&timers[CPUCLOCK_VIRT]) &&
 	    cputime_eq(sig->it_virt_expires, cputime_zero) &&
 	    list_empty(&timers[CPUCLOCK_SCHED]))
@@ -1086,6 +1092,33 @@ static void check_process_timers(struct 
 			virt_expires = sig->it_virt_expires;
 		}
 	}
+	if (sig->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY) {
+		unsigned long psecs = cputime_to_secs(ptime);
+		cputime_t x;
+		if (psecs >= sig->rlim[RLIMIT_CPU].rlim_max) {
+			/*
+			 * At the hard limit, we just die.
+			 * No need to calculate anything else now.
+			 */
+			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
+			return;
+		}
+		if (psecs >= sig->rlim[RLIMIT_CPU].rlim_cur) {
+			/*
+			 * At the soft limit, send a SIGXCPU every second.
+			 */
+			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
+			if (sig->rlim[RLIMIT_CPU].rlim_cur
+			    < sig->rlim[RLIMIT_CPU].rlim_max) {
+				sig->rlim[RLIMIT_CPU].rlim_cur++;
+			}
+		}
+		x = secs_to_cputime(sig->rlim[RLIMIT_CPU].rlim_cur);
+		if (cputime_eq(prof_expires, cputime_zero) ||
+		    cputime_lt(x, prof_expires)) {
+			prof_expires = x;
+		}
+	}
 
 	if (!cputime_eq(prof_expires, cputime_zero) ||
 	    !cputime_eq(virt_expires, cputime_zero) ||
@@ -1275,6 +1308,9 @@ void run_posix_cpu_timers(struct task_st
 /*
  * Set one of the process-wide special case CPU timers.
  * The tasklist_lock and tsk->sighand->siglock must be held by the caller.
+ * The oldval argument is null for the RLIMIT_CPU timer, where *newval is
+ * absolute; non-null for ITIMER_*, where *newval is relative and we update
+ * it to be absolute, *oldval is absolute and we update it to be relative.
  */
 void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 			   cputime_t *newval, cputime_t *oldval)
@@ -1285,17 +1321,28 @@ void set_process_cpu_timer(struct task_s
 	BUG_ON(clock_idx == CPUCLOCK_SCHED);
 	cpu_clock_sample_group_locked(clock_idx, tsk, &now);
 
-	if (oldval && !cputime_eq(*oldval, cputime_zero)) {
-		if (cputime_le(*oldval, now.cpu)) { /* Just about to fire. */
-			*oldval = jiffies_to_cputime(1);
-		} else {
-			*oldval = cputime_sub(*oldval, now.cpu);
+	if (oldval) {
+		if (!cputime_eq(*oldval, cputime_zero)) {
+			if (cputime_le(*oldval, now.cpu)) {
+				/* Just about to fire. */
+				*oldval = jiffies_to_cputime(1);
+			} else {
+				*oldval = cputime_sub(*oldval, now.cpu);
+			}
 		}
-	}
 
-	if (cputime_eq(*newval, cputime_zero))
-		return;
-	*newval = cputime_add(*newval, now.cpu);
+		if (cputime_eq(*newval, cputime_zero))
+			return;
+		*newval = cputime_add(*newval, now.cpu);
+
+		/*
+		 * If the RLIMIT_CPU timer will expire before the
+		 * ITIMER_PROF timer, we have nothing else to do.
+		 */
+		if (tsk->signal->rlim[RLIMIT_CPU].rlim_cur
+		    < cputime_to_secs(*newval))
+			return;
+	}
 
 	/*
 	 * Check whether there are any process timers already set to fire
--- linux-2.6/kernel/sys.c
+++ linux-2.6/kernel/sys.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/key.h>
 #include <linux/times.h>
+#include <linux/posix-timers.h>
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
@@ -1501,6 +1502,20 @@ asmlinkage long sys_setrlimit(unsigned i
 	task_lock(current->group_leader);
 	*old_rlim = new_rlim;
 	task_unlock(current->group_leader);
+
+	if (resource == RLIMIT_CPU && new_rlim.rlim_cur != RLIM_INFINITY &&
+	    (cputime_eq(current->signal->it_prof_expires, cputime_zero) ||
+	     new_rlim.rlim_cur <= cputime_to_secs(
+		     current->signal->it_prof_expires))) {
+		cputime_t cputime = secs_to_cputime(new_rlim.rlim_cur);
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&current->sighand->siglock);
+		set_process_cpu_timer(current, CPUCLOCK_PROF,
+				      &cputime, NULL);
+		spin_unlock_irq(&current->sighand->siglock);
+		read_unlock(&tasklist_lock);
+	}
+
 	return 0;
 }
 
--- linux-2.6/security/selinux/hooks.c
+++ linux-2.6/security/selinux/hooks.c
@@ -1855,6 +1855,13 @@ static void selinux_bprm_post_apply_cred
 			initrlim = init_task.signal->rlim+i;
 			rlim->rlim_cur = min(rlim->rlim_max,initrlim->rlim_cur);
 		}
+		if (current->signal->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY) {
+			/*
+			 * This will cause RLIMIT_CPU calculations
+			 * to be refigured.
+			 */
+			current->it_prof_expires = jiffies_to_cputime(1);
+		}
 	}
 
 	/* Wake up the parent if it is waiting so that it can
--- linux-2.6/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -2277,30 +2277,6 @@ unsigned long long current_sched_time(co
 			((rq)->curr->static_prio > (rq)->best_expired_prio))
 
 /*
- * Check if the process went over its cputime resource limit after
- * some cpu time got added to utime/stime.
- * @p: the process that the cpu time gets accounted to
- * @cputime: the cpu time spent in user and kernel space since the last update
- */
-static void check_rlimit(struct task_struct *p, cputime_t cputime)
-{
-	cputime_t total, tmp;
-	unsigned long secs;
-
-	total = cputime_add(p->utime, p->stime);
-	secs = cputime_to_secs(total);
-	if (unlikely(secs >= p->signal->rlim[RLIMIT_CPU].rlim_cur)) {
-		/* Send SIGXCPU every second. */
-		tmp = cputime_sub(total, cputime);
-		if (cputime_to_secs(tmp) < secs)
-			send_sig(SIGXCPU, p, 1);
-		/* and SIGKILL when we go over max.. */
-		if (secs >= p->signal->rlim[RLIMIT_CPU].rlim_max)
-			send_sig(SIGKILL, p, 1);
-	}
-}
-
-/*
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
@@ -2313,9 +2289,6 @@ void account_user_time(struct task_struc
 
 	p->utime = cputime_add(p->utime, cputime);
 
-	/* Check for signals (SIGXCPU & SIGKILL). */
-	check_rlimit(p, cputime);
-
 	/* Add user time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
 	if (TASK_NICE(p) > 0)
@@ -2339,11 +2312,6 @@ void account_system_time(struct task_str
 
 	p->stime = cputime_add(p->stime, cputime);
 
-	/* Check for signals (SIGXCPU & SIGKILL). */
-	if (likely(p->signal && p->exit_state < EXIT_ZOMBIE)) {
-		check_rlimit(p, cputime);
-	}
-
 	/* Add system time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
 	if (hardirq_count() - hardirq_offset)
