Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbULNENj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbULNENj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbULNENj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:13:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261399AbULND7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:59:25 -0500
Date: Mon, 13 Dec 2004 19:59:21 -0800
Message-Id: <200412140359.iBE3xLdi008072@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] make RLIMIT_CPU/SIGXCPU per-process
X-Fcc: ~/Mail/linus
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
@@ -764,6 +764,14 @@ static inline int copy_signal(unsigned l
 	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
 	task_unlock(current->group_leader);
 
+	if (sig->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY) {
+		/*
+		 * New sole thread in the process gets an expiry time
+		 * of the whole CPU time limit.
+		 */
+		tsk->it_prof_expires = sig->rlim[RLIMIT_CPU].rlim_cur * HZ;
+	}
+
 	return 0;
 }
 
@@ -1019,6 +1027,7 @@ static task_t *copy_process(unsigned lon
 
 		if (current->signal->it_virt_expires != 0 ||
 		    current->signal->it_prof_expires != 0 ||
+		    current->signal->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY ||
 		    !list_empty(&current->signal->cpu_timers[0]) ||
 		    !list_empty(&current->signal->cpu_timers[1]) ||
 		    !list_empty(&current->signal->cpu_timers[2])) {
--- linux-2.6/kernel/posix-cpu-timers.c
+++ linux-2.6/kernel/posix-cpu-timers.c
@@ -496,7 +496,8 @@ process_timer_rebalance(struct task_stru
 				    time_after(t->it_prof_expires, ticks)) {
 					t->it_prof_expires = ticks;
 				}
-			}			t = next_thread(t);
+			}
+			t = next_thread(t);
 		} while (t != p);
 		break;
 	case CPUCLOCK_VIRT:
@@ -508,7 +509,8 @@ process_timer_rebalance(struct task_stru
 				    time_after(t->it_virt_expires, ticks)) {
 					t->it_virt_expires = ticks;
 				}
-			}			t = next_thread(t);
+			}
+			t = next_thread(t);
 		} while (t != p);
 		break;
 	case CPUCLOCK_SCHED:
@@ -606,6 +608,7 @@ static void arm_timer(struct k_itimer *t
 			 * For a process timer, we must balance
 			 * all the live threads' expirations.
 			 */
+			unsigned long i;
 			switch (CPUCLOCK_WHICH(timer->it_clock)) {
 			default:
 				BUG();
@@ -620,6 +623,11 @@ static void arm_timer(struct k_itimer *t
 				    time_before(p->signal->it_prof_expires,
 						timer->it.cpu.expires.cpu))
 					break;
+				i = p->signal->rlim[RLIMIT_CPU].rlim_cur;
+				if (i != RLIM_INFINITY &&
+				    time_before(i * HZ,
+						timer->it.cpu.expires.cpu))
+					break;
 				goto rebalance;
 			case CPUCLOCK_SCHED:
 			rebalance:
@@ -990,6 +998,7 @@ static void check_process_timers(struct 
 	 * Don't sample the current process CPU clocks if there are no timers.
 	 */
 	if (list_empty(&timers[CPUCLOCK_PROF]) && sig->it_prof_expires == 0 &&
+	    sig->rlim[RLIMIT_CPU].rlim_cur == RLIM_INFINITY &&
 	    list_empty(&timers[CPUCLOCK_VIRT]) && sig->it_virt_expires == 0 &&
 	    list_empty(&timers[CPUCLOCK_SCHED]))
 		return;
@@ -1080,6 +1089,34 @@ static void check_process_timers(struct 
 			virt_expires = sig->it_virt_expires;
 		}
 	}
+	if (sig->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY) {
+		unsigned long psecs = (utime + stime) / HZ;
+		if (psecs >= sig->rlim[RLIMIT_CPU].rlim_max) {
+			/*
+			 * At the hard limit, we just die.
+			 * No need to calculate anything else now.
+			 */
+			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
+			return;
+		}
+		if (psecs < sig->rlim[RLIMIT_CPU].rlim_cur) {
+			psecs = sig->rlim[RLIMIT_CPU].rlim_cur * HZ;
+		} else if ((utime + stime) % HZ == 0) {
+			/*
+			 * At the soft limit, send a SIGXCPU every second.
+			 */
+			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
+			psecs = utime + stime + HZ;
+		} else {
+			/*
+			 * Set the expiry at the next even second.
+			 */
+			psecs = utime + stime - ((utime + stime) % HZ) + HZ;
+		}
+		if (prof_expires == 0 || time_before(psecs, prof_expires)) {
+			prof_expires = psecs;
+		}
+	}
 
 	if (prof_expires | virt_expires | sched_expires) {
 		/*
@@ -1389,6 +1426,9 @@ posix_cpu_clock_nanosleep_restart(struct
 /*
  * Set one of the process-wide special case CPU timers.
  * The tasklist_lock and tsk->sighand->siglock must be held by the caller.
+ * The oldval argument is null for the RLIMIT_CPU timer, where *newval is
+ * absolute; non-null for ITIMER_*, where *newval is relative and we update
+ * it to be absolute, *oldval is absolute and we update it to be relative.
  */
 void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 			   unsigned long *newval, unsigned long *oldval)
@@ -1399,17 +1439,27 @@ void set_process_cpu_timer(struct task_s
 	BUG_ON(clock_idx == CPUCLOCK_SCHED);
 	cpu_clock_sample_group_locked(clock_idx, tsk, &now);
 
-	if (oldval && *oldval) {
-		if (*oldval <= now.cpu) { /* Just about to fire. */
-			*oldval = 1;
-		} else {
-			*oldval -= now.cpu;
+	if (oldval) {
+		if (*oldval) {
+			if (*oldval <= now.cpu) { /* Just about to fire. */
+				*oldval = 1;
+			} else {
+				*oldval -= now.cpu;
+			}
 		}
-	}
 
-	if (*newval == 0)
-		return;
-	*newval += now.cpu;
+		if (*newval == 0)
+			return;
+		*newval += now.cpu;
+
+		/*
+		 * If the RLIMIT_CPU timer will expire before the
+		 * ITIMER_PROF timer, we have nothing else to do.
+		 */
+		if (time_before(tsk->signal->rlim[RLIMIT_CPU].rlim_cur * HZ,
+				*newval))
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
@@ -1498,6 +1499,20 @@ asmlinkage long sys_setrlimit(unsigned i
 	task_lock(current->group_leader);
 	*old_rlim = new_rlim;
 	task_unlock(current->group_leader);
+
+	if (resource == RLIMIT_CPU && new_rlim.rlim_cur != RLIM_INFINITY &&
+	    (current->signal->it_prof_expires == 0 ||
+	     time_before(new_rlim.rlim_cur * HZ,
+			 current->signal->it_prof_expires))) {
+		new_rlim.rlim_cur *= HZ;
+		read_lock(&tasklist_lock);
+		spin_lock_irq(&current->sighand->siglock);
+		set_process_cpu_timer(current, CPUCLOCK_PROF,
+				      &new_rlim.rlim_cur, NULL);
+		spin_unlock_irq(&current->sighand->siglock);
+		read_unlock(&tasklist_lock);
+	}
+
 	return 0;
 }
 
--- linux-2.6/kernel/timer.c
+++ linux-2.6/kernel/timer.c
@@ -807,15 +807,6 @@ static inline void do_process_times(stru
 
 	psecs = (p->utime += user);
 	psecs += (p->stime += system);
-	if (p->signal && !unlikely(p->state & (EXIT_DEAD|EXIT_ZOMBIE)) &&
-	    psecs / HZ >= p->signal->rlim[RLIMIT_CPU].rlim_cur) {
-		/* Send SIGXCPU every second.. */
-		if (!(psecs % HZ))
-			send_sig(SIGXCPU, p, 1);
-		/* and SIGKILL when we go over max.. */
-		if (psecs / HZ >= p->signal->rlim[RLIMIT_CPU].rlim_max)
-			send_sig(SIGKILL, p, 1);
-	}
 }
 
 static void update_one_process(struct task_struct *p, unsigned long user,
--- linux-2.6/security/selinux/hooks.c
+++ linux-2.6/security/selinux/hooks.c
@@ -1910,6 +1910,13 @@ static void selinux_bprm_apply_creds(str
 				initrlim = init_task.signal->rlim+i;
 				rlim->rlim_cur = min(rlim->rlim_max,initrlim->rlim_cur);
 			}
+			if (current->signal->rlim[RLIMIT_CPU].rlim_cur != RLIM_INFINITY) {
+				/*
+				 * This will cause RLIMIT_CPU calculations
+				 * to be refigured.
+				 */
+				current->it_prof_expires = 1;
+			}
 		}
 
 		/* Wake up the parent if it is waiting so that it can
