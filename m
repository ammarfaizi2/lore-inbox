Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUHDAtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUHDAtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUHDAtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:49:20 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:16518 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267165AbUHDAqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:46:50 -0400
Message-ID: <cone.1091580402.649106.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2/3] Sched batch for staircase
Date: Wed, 04 Aug 2004 10:46:42 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1091580402-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1091580402-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This implements idle scheduling for the staircase scheduler. 

SCHED_BATCH tasks are scheduled only when idle time is available, or 
transiently elevated to normal scheduling while in kernel mode.
Batch tasks have 10 times larger timeslices than normal policy tasks, so in 
compute mode (which already enlarges them 10 times) a nice 0 batch task has 
a 20 second long timeslice.
Nice is supported between batch tasks.
Batch tasks are hyperthread aware and will not schedule if an SMT sibling is 
not idle or not running a batch tasks.

Schedtools and the heirloom toolchest currently have userspace support 
for the setting of sched_batch policy.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


--=_pc.kolivas.org-1091580402-0000
Content-Description: schedbatch
Content-Disposition: inline;
  FILENAME="schedbatch2.4.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.8-rc2-mm2/include/linux/init_task.h
===================================================================
--- linux-2.6.8-rc2-mm2.orig/include/linux/init_task.h	2004-08-03 01:52:34.388711380 +1000
+++ linux-2.6.8-rc2-mm2/include/linux/init_task.h	2004-08-03 01:54:34.136953777 +1000
@@ -72,8 +72,8 @@
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
Index: linux-2.6.8-rc2-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.8-rc2-mm2.orig/include/linux/sched.h	2004-08-03 01:54:32.489156849 +1000
+++ linux-2.6.8-rc2-mm2/include/linux/sched.h	2004-08-03 01:54:34.156951313 +1000
@@ -126,9 +126,10 @@
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_BATCH		3
 
 #define SCHED_MIN		0
-#define SCHED_MAX		2
+#define SCHED_MAX		3
 
 #define SCHED_RANGE(policy)	((policy) >= SCHED_MIN && \
 					(policy) <= SCHED_MAX)
@@ -327,9 +328,10 @@
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
-#define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define MAX_PRIO		(MAX_RT_PRIO + 41)
 
-#define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
+#define rt_task(p)		((p)->prio < MAX_RT_PRIO)
+#define batch_task(p)		((p)->policy == SCHED_BATCH)
 
 /*
  * Some day this will be a full-fledged user tracking system..
Index: linux-2.6.8-rc2-mm2/init/main.c
===================================================================
--- linux-2.6.8-rc2-mm2.orig/init/main.c	2004-08-03 01:29:29.000000000 +1000
+++ linux-2.6.8-rc2-mm2/init/main.c	2004-08-03 01:54:50.729908885 +1000
@@ -685,7 +685,7 @@
 static int init(void * unused)
 {
 	lock_kernel();
-	current->prio = MAX_PRIO - 1;
+	current->prio = MAX_PRIO - 2;
 	/*
 	 * Tell the world that we're going to be the grim
 	 * reaper of innocent orphaned children.
Index: linux-2.6.8-rc2-mm2/kernel/sched.c
===================================================================
--- linux-2.6.8-rc2-mm2.orig/kernel/sched.c	2004-08-03 01:54:32.490156726 +1000
+++ linux-2.6.8-rc2-mm2/kernel/sched.c	2004-08-03 01:54:34.158951066 +1000
@@ -49,7 +49,7 @@
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
- * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
+ * to static priority [ MAX_RT_PRIO..MAX_PRIO-2 ],
  * and back.
  */
 #define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
@@ -59,7 +59,7 @@
 /*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
- * it's a [ 0 ... 39 ] range.
+ * it's a [ 0 ... 40 ] range.
  */
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
@@ -274,8 +274,10 @@
 static unsigned int slice(task_t *p)
 {
 	unsigned int slice = RR_INTERVAL();
-	if (likely(!rt_task(p)))
+	if (likely(!rt_task(p) && !batch_task(p)))
 		slice += burst(p) * RR_INTERVAL();
+	else if (batch_task(p))
+		slice *= 40 - TASK_USER_PRIO(p);
 	return slice;
 }
 
@@ -297,6 +299,17 @@
 	unsigned int best_burst;
 	if (rt_task(p))
 		return p->prio;
+	if (batch_task(p)) {
+		if (unlikely(p->flags & PF_UISLEEP)) {
+			/*
+			 * If batch is waking up from uninterruptible sleep
+			 * reschedule at a normal priority to begin with.
+			 */
+			p->flags |= PF_YIELDED;
+			return MAX_PRIO - 2;
+		}
+		return MAX_PRIO - 1;
+	}
 
 	best_burst = burst(p);
 	full_slice = slice(p);
@@ -306,13 +319,13 @@
 	first_slice = RR_INTERVAL();
 	if (sched_interactive && !sched_compute)
 		first_slice *= (p->burst + 1);
-	prio = MAX_PRIO - 1 - best_burst;
+	prio = MAX_PRIO - 2 - best_burst;
 
 	if (used_slice < first_slice)
 		return prio;
 	prio += 1 + (used_slice - first_slice) / RR_INTERVAL();
-	if (prio > MAX_PRIO - 1)
-		prio = MAX_PRIO - 1;
+	if (prio > MAX_PRIO - 2)
+		prio = MAX_PRIO - 2;
 	return prio;
 }
 
@@ -361,9 +374,11 @@
 #endif
 	p->slice = slice(p);
 	recalc_task_prio(p, now);
-	p->flags &= ~PF_UISLEEP;
 	p->prio = effective_prio(p);
+	p->flags &= ~PF_UISLEEP;
 	p->time_slice = RR_INTERVAL();
+	if (batch_task(p))
+		p->time_slice = p->slice;
 	p->timestamp = now;
 	__activate_task(p, rq);
 }
@@ -1717,7 +1732,7 @@
 		rebalance_tick(cpu, rq, IDLE);
 		return;
 	}
-	if (TASK_NICE(p) > 0)
+	if (TASK_NICE(p) > 0 || batch_task(p))
 		cpustat->nice += user_ticks;
 	else
 		cpustat->user += user_ticks;
@@ -1820,8 +1835,9 @@
 		 * physical cpu's resources. -ck
 		 */
 		if (((smt_curr->slice * (100 - sd->per_cpu_gain) / 100) >
-			slice(p) || rt_task(smt_curr)) &&
-			p->mm && smt_curr->mm && !rt_task(p))
+			slice(p) || rt_task(smt_curr) || batch_task(p)) &&
+			p->mm && smt_curr->mm && !rt_task(p) &&
+			!batch_task(smt_curr))
 				ret = 1;
 
 		/*
@@ -1830,8 +1846,9 @@
 		 * reasons.
 		 */
 		if ((((p->slice * (100 - sd->per_cpu_gain) / 100) >
-			slice(smt_curr) || rt_task(p)) &&
-			smt_curr->mm && p->mm && !rt_task(smt_curr)) ||
+			slice(smt_curr) || rt_task(p) || batch_task(smt_curr)) && 
+			smt_curr->mm && p->mm && !rt_task(smt_curr) &&
+			!batch_task(p)) ||
 			(smt_curr == smt_rq->idle && smt_rq->nr_running))
 				resched_task(smt_curr);
 	}
@@ -2229,8 +2246,9 @@
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
 		 */
-		if (delta < 0 || (delta > 0 && task_running(rq, p)))
-			resched_task(rq->curr);
+		if (delta < 0 || ((delta > 0 || batch_task(p)) &&
+			task_running(rq, p)))
+				resched_task(rq->curr);
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -2406,6 +2424,12 @@
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 
+	if (!(p->mm) && policy == SCHED_BATCH)
+		/*
+		 * Don't allow kernel threads to be SCHED_BATCH.
+		 */
+		goto out_unlock;
+
 	retval = security_task_setscheduler(p, policy, &lp);
 	if (retval)
 		goto out_unlock;
@@ -2640,9 +2664,9 @@
 	dequeue_task(current, rq);
 	current->slice = slice(current);
 	current->time_slice = RR_INTERVAL();
-	if (likely(!rt_task(current))) {
+	if (likely(!rt_task(current) && !batch_task(current))) {
 		current->flags |= PF_YIELDED;
-		current->prio = MAX_PRIO - 1;
+		current->prio = MAX_PRIO - 2;
 	}
 	current->burst = 0;
 	enqueue_task(current, rq);
@@ -2727,6 +2751,7 @@
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 		break;
 	}
@@ -2750,6 +2775,7 @@
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 	}
 	return ret;

--=_pc.kolivas.org-1091580402-0000--
