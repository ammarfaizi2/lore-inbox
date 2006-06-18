Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWFRHcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWFRHcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWFRHbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:31:50 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:12738 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932131AbWFRHb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:31:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][9/29] sched-idleprio-1.9.patch
Date: Sun, 18 Jun 2006 17:31:24 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 7995
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181731.24396.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SCHED_IDLEPRIO scheduling policy. Tasks set to this policy are only
given cpu time if no other tasks at all wish to have cpu time thus running
effectively at idle priority. If semaphores or mutexes are held, or the
system is going into suspend, schedule them as SCHED_NORMAL nice 19.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/init_task.h |    4 +-
 include/linux/sched.h     |    9 +++--
 kernel/sched.c            |   75 +++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 72 insertions(+), 16 deletions(-)

Index: linux-ck-dev/include/linux/init_task.h
===================================================================
--- linux-ck-dev.orig/include/linux/init_task.h	2006-06-18 15:23:44.000000000 +1000
+++ linux-ck-dev/include/linux/init_task.h	2006-06-18 15:23:46.000000000 +1000
@@ -85,8 +85,8 @@ extern struct group_info init_groups;
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
-	.prio		= MAX_PRIO-20,					\
-	.static_prio	= MAX_PRIO-20,					\
+	.prio		= MAX_PRIO-21,					\
+	.static_prio	= MAX_PRIO-21,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
Index: linux-ck-dev/include/linux/sched.h
===================================================================
--- linux-ck-dev.orig/include/linux/sched.h	2006-06-18 15:23:44.000000000 +1000
+++ linux-ck-dev/include/linux/sched.h	2006-06-18 15:23:46.000000000 +1000
@@ -165,9 +165,10 @@ extern unsigned long weighted_cpuload(co
 #define SCHED_RR		2
 #define SCHED_BATCH		3
 #define SCHED_ISO		4
+#define SCHED_IDLEPRIO		5
 
 #define SCHED_MIN		0
-#define SCHED_MAX		4
+#define SCHED_MAX		5
 
 #define SCHED_RANGE(policy)	((policy) <= SCHED_MAX)
 #define SCHED_RT(policy)	((policy) == SCHED_FIFO || \
@@ -492,12 +493,14 @@ struct signal_struct {
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 #define ISO_PRIO		(MAX_RT_PRIO - 1)
 
-#define MAX_PRIO		(MAX_RT_PRIO + 40)
-#define MIN_USER_PRIO		(MAX_PRIO - 1)
+#define MAX_PRIO		(MAX_RT_PRIO + 41)
+#define MIN_USER_PRIO		(MAX_PRIO - 2)
+#define IDLEPRIO_PRIO		(MAX_PRIO - 1)
 
 #define rt_task(p)		(unlikely(SCHED_RT((p)->policy)))
 #define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
 #define iso_task(p)		(unlikely((p)->policy == SCHED_ISO))
+#define idleprio_task(p)	(unlikely((p)->policy == SCHED_IDLEPRIO))
 
 /*
  * Some day this will be a full-fledged user tracking system..
Index: linux-ck-dev/kernel/sched.c
===================================================================
--- linux-ck-dev.orig/kernel/sched.c	2006-06-18 15:23:38.000000000 +1000
+++ linux-ck-dev/kernel/sched.c	2006-06-18 15:23:46.000000000 +1000
@@ -627,6 +627,12 @@ static void set_load_weight(task_t *p)
 		else
 #endif
 			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
+	} else if (idleprio_task(p)) {
+		/*
+		 * We want idleprio_tasks to have a presence on weighting but
+		 * as small as possible
+		 */
+		p->load_weight = 1;
 	} else
 		p->load_weight = TASK_LOAD_WEIGHT(p);
 }
@@ -734,13 +740,24 @@ static inline void slice_overrun(struct 
 	} while (unlikely(p->totalrun > ns_slice));
 }
 
+static inline int idleprio_suitable(const struct task_struct *p)
+{
+	return (!p->mutexes_held &&
+		!(p->flags & (PF_FREEZE | PF_NONSLEEP)));
+}
+
+static inline int idleprio(const struct task_struct *p)
+{
+	return (p->prio == IDLEPRIO_PRIO);
+}
+
 /*
  * effective_prio - dynamic priority dependent on bonus.
  * The priority normally decreases by one each RR_INTERVAL.
  * As the bonus increases the initial priority starts at a higher "stair" or
  * priority for longer.
  */
-static int effective_prio(const task_t *p)
+static int effective_prio(task_t *p)
 {
 	int prio;
 	unsigned int full_slice, used_slice = 0;
@@ -760,6 +777,18 @@ static int effective_prio(const task_t *
 			return ISO_PRIO;
 	}
 
+	if (idleprio_task(p)) {
+		if (unlikely(!idleprio_suitable(p))) {
+			/*
+			 * If idleprio tasks are holding a semaphore, mutex,
+			 * or being frozen, schedule at a normal priority.
+			 */
+			p->time_slice = p->slice % RR_INTERVAL ? : RR_INTERVAL;
+			return MIN_USER_PRIO;
+		}
+		return IDLEPRIO_PRIO;
+	}
+
 	full_slice = slice(p);
 	if (full_slice > p->slice)
 		used_slice = full_slice - p->slice;
@@ -2582,7 +2611,7 @@ void account_user_time(struct task_struc
 
 	/* Add user time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
-	if (TASK_NICE(p) > 0)
+	if (TASK_NICE(p) > 0 || idleprio_task(p))
 		cpustat->nice = cputime64_add(cpustat->nice, tmp);
 	else
 		cpustat->user = cputime64_add(cpustat->user, tmp);
@@ -2710,11 +2739,14 @@ void scheduler_tick(void)
 			}
 		} else
 			p->flags &= ~PF_ISOREF;
-	} else
-		/* SCHED_FIFO tasks never run out of timeslice. */
-		if (unlikely(p->policy == SCHED_FIFO))
-			goto out_unlock;
-
+	} else {
+		if (idleprio_task(p) && !idleprio(p) && idleprio_suitable(p))
+			set_tsk_need_resched(p);
+		else
+			/* SCHED_FIFO tasks never run out of timeslice. */
+			if (unlikely(p->policy == SCHED_FIFO))
+				goto out_unlock;
+	}
 
 	debit = ns_diff(rq->timestamp_last_tick, p->timestamp);
 	p->ns_debit += debit;
@@ -2855,11 +2887,24 @@ static int dependent_sleeper(int this_cp
 			if ((jiffies % DEF_TIMESLICE) >
 				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
 					ret = 1;
-		} else
+			else if (idleprio(p))
+				ret = 1;
+		} else {
 			if (smt_curr->static_prio < p->static_prio &&
 				!TASK_PREEMPTS_CURR(p, smt_rq) &&
 				smt_slice(smt_curr, sd) > slice(p))
 					ret = 1;
+			else if (idleprio(p) && !idleprio_task(smt_curr) &&
+				smt_curr->slice * sd->per_cpu_gain >
+				slice(smt_curr)) {
+				/*
+				 * With idleprio tasks they run just the last
+				 * per_cpu_gain percent of the smt task's
+				 * slice.
+				 */
+				ret = 1;
+			}
+		}
 
 unlock:
 		spin_unlock(&smt_rq->lock);
@@ -3479,8 +3524,9 @@ void set_user_nice(task_t *p, long nice)
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
 		 */
-		if (delta < 0 || (delta > 0 && task_running(rq, p)))
-			resched_task(rq->curr);
+		if (delta < 0 || ((delta > 0 || idleprio_task(p)) &&
+			task_running(rq, p)))
+				resched_task(rq->curr);
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -3673,6 +3719,11 @@ recheck:
 			return -EPERM;
 	}
 
+	if (!(p->mm) && policy == SCHED_IDLEPRIO) {
+		/* Don't allow kernel threads to be SCHED_IDLEPRIO. */
+		return -EINVAL;
+	}
+
 	retval = security_task_setscheduler(p, policy, param);
 	if (retval)
 		return retval;
@@ -3971,7 +4022,7 @@ asmlinkage long sys_sched_yield(void)
 	schedstat_inc(rq, yld_cnt);
 	current->slice = slice(current);
 	current->time_slice = rr_interval(current);
-	if (likely(!rt_task(current)))
+	if (likely(!rt_task(current) && !idleprio(current)))
 		newprio = MIN_USER_PRIO;
 
 	requeue_task(current, rq, newprio);
@@ -4126,6 +4177,7 @@ asmlinkage long sys_sched_get_priority_m
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
 	case SCHED_ISO:
+	case SCHED_IDLEPRIO:
 		ret = 0;
 		break;
 	}
@@ -4151,6 +4203,7 @@ asmlinkage long sys_sched_get_priority_m
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
 	case SCHED_ISO:
+	case SCHED_IDLEPRIO:
 		ret = 0;
 	}
 	return ret;

-- 
-ck
