Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTJMHNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 03:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbTJMHNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 03:13:35 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:48348
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261503AbTJMHN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 03:13:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Batch scheduling for 2.6.0-test7
Date: Mon, 13 Oct 2003 17:18:38 +1000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OHli/O9fzO17/4y"
Message-Id: <200310131718.38215.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_OHli/O9fzO17/4y
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

T o allow a simple upgrade path for people moving from 2.4 -ck to 2.6 I have 
implemented a very basic batch scheduling for 2.6. 

Batch tasks are designed to run with minimal impact on system load (ie long 
calculation tasks such as setiathome, mprime, dnetc).

This design uses an extra array (batch) for each runqueue. Batch tasks are 
activated onto the batch array and only run when there are no normal or real 
time tasks that need running. Batch tasks have much longer timeslices (still 
dependent on "nice") but yield immediately when cpu is required. They do not 
preempt each other (one batch task will wait for another batch task to 
complete it's timeslice before running regardless of nice value). 

An example of how effective batch scheduling is as follows:

kernel compile with the same load
no_load		87.32user 10.74system 1:45.06elapsed 93%CPU
normal_load	87.03user 10.62system 3:32.58elapsed 45%CPU
niced_load	87.07user 10.72system 1:54.52elapsed 85%CPU 
batchload	87.00user 10.65system 1:44.75elapsed 93%CPU 

In this example, a kernel is compiled at idle, and with a simple but difficult 
to control load (while true ; do a=1 ; done). The run time for the kernel 
compile is almost twice as long when the load is not reniced, and ten seconds 
longer when it is reniced to 19. When the load is batch scheduled it takes no 
extra time (smaller number is within deviation between runs I suspect).

Note that no effort is made to tame batch tasks' effect on other resources 
(disk i/o, vm pressure etc) so they cannot be truly weightless.

kernel compiled as batch task
batchrun	88.33user 10.82system 1:45.60elapsed 93%CPU 

Here it is compiled as a batch task itself, and you can see it takes more user 
time, but equivalent overall time. The machine was running X at the time so 
presumably this is causing some more overhead.

Schedtools to modify scheduler policy can be found here:
http://freshmeat.net/projects/schedtool/?topic_id=136

and the patch can be found here (latest is batch2):
http://ck.kolivas.org/patches/2.6/2.6.0-test7/

This has only been tested on uniprocessor systems and I am not pushing for 
inclusion in mainline. This is not meant to be a comprehensive batch 
scheduling implementation but a simple upgrade path for 2.4 -ck users as I am 
retiring from all kernel development work for personal reasons of time. 
Please consider this if you wish to email me.

Regards,
Con Kolivas

--Boundary-00=_OHli/O9fzO17/4y
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-test7-batch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-test7-batch2"

--- linux-2.6.0-test7-base/include/linux/sched.h	2003-10-12 22:34:09.000000000 +1000
+++ linux-2.6.0-test7/include/linux/sched.h	2003-10-12 20:46:55.000000000 +1000
@@ -126,6 +126,7 @@ extern unsigned long nr_iowait(void);
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_BATCH		3
 
 struct sched_param {
 	int sched_priority;
@@ -294,6 +295,7 @@ struct signal_struct {
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
+#define batch_task(p)		((p)->policy == SCHED_BATCH)
 
 /*
  * Some day this will be a full-fledged user tracking system..
--- linux-2.6.0-test7-base/kernel/sched.c	2003-10-12 22:34:09.000000000 +1000
+++ linux-2.6.0-test7/kernel/sched.c	2003-10-13 16:24:33.000000000 +1000
@@ -153,8 +153,13 @@
 #define LOW_CREDIT(p) \
 	((p)->interactive_credit < -CREDIT_LIMIT)
 
+/*
+ * Batch tasks are preempted by any priority normal tasks and never
+ * preempt other tasks.
+ */
 #define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
+	((((p)->prio < (rq)->curr->prio) && (!batch_task(p))) || \
+		(!batch_task(p) && batch_task((rq)->curr)))
 
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
@@ -172,6 +177,13 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
+	/*
+	 * Batch tasks get much longer timeslices to optimise cpu throughput.
+	 * Since they yield to any other tasks this is not a problem.
+	 */
+	if (unlikely(batch_task(p)))
+		return BASE_TIMESLICE(p) * 10;
+
 	return BASE_TIMESLICE(p);
 }
 
@@ -202,7 +214,7 @@ struct runqueue {
 			nr_uninterruptible;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
-	prio_array_t *active, *expired, arrays[2];
+	prio_array_t *active, *expired, *batch, arrays[3];
 	int prev_cpu_load[NR_CPUS];
 #ifdef CONFIG_NUMA
 	atomic_t *node_nr_running;
@@ -364,7 +376,7 @@ static int effective_prio(task_t *p)
 	prio = p->static_prio - bonus;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
-	if (prio > MAX_PRIO-1)
+	if (prio > MAX_PRIO-1 || batch_task(p))
 		prio = MAX_PRIO-1;
 	return prio;
 }
@@ -374,7 +386,11 @@ static int effective_prio(task_t *p)
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	if (unlikely(batch_task(p)))
+		enqueue_task(p, rq->batch);
+	else
+		enqueue_task(p, rq->active);
+
 	nr_running_inc(rq);
 }
 
@@ -692,6 +708,10 @@ void wake_up_forked_process(task_t * p)
 		p->array->nr_active++;
 		nr_running_inc(rq);
 	}
+
+	if (unlikely(batch_task(current) && !batch_task(p)))
+		resched_task(current);
+
 	task_rq_unlock(rq, &flags);
 }
 
@@ -1408,12 +1428,17 @@ void scheduler_tick(int user_ticks, int 
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!rq->expired_timestamp)
+		if (!rq->expired_timestamp && !batch_task(p))
 			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			enqueue_task(p, rq->expired);
-		} else
-			enqueue_task(p, rq->active);
+
+		if (unlikely(batch_task(p)))
+			enqueue_task(p, rq->batch);
+		else {
+			if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq))
+				enqueue_task(p, rq->expired);
+			else
+				enqueue_task(p, rq->active);
+		}
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
@@ -1534,16 +1559,33 @@ pick_next_task:
 		/*
 		 * Switch the active and expired arrays.
 		 */
-		rq->active = rq->expired;
-		rq->expired = array;
+		if (likely(rq->expired->nr_active)){
+			rq->active = rq->expired;
+			rq->expired = array;
+			rq->expired_timestamp = 0;
+		} else {
+			rq->active = rq->batch;
+			rq->batch = array;
+		}
+
 		array = rq->active;
-		rq->expired_timestamp = 0;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
+	/*
+	 * If a batch process is on the active array and normal processes
+	 * exist on the expired array move the batch process to the batch
+	 * array.
+	 */
+	if (unlikely(batch_task(next) && rq->expired->nr_active)){
+		dequeue_task(next, array);
+		enqueue_task(next, rq->batch);
+		goto pick_next_task;
+	}
+
 	if (next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
 
@@ -1865,10 +1907,11 @@ void set_user_nice(task_t *p, long nice)
 		enqueue_task(p, array);
 		/*
 		 * If the task increased its priority or is running and
-		 * lowered its priority, then reschedule its CPU:
+		 * lowered its priority or is batch, then reschedule its CPU:
 		 */
-		if (delta < 0 || (delta > 0 && task_running(rq, p)))
-			resched_task(rq->curr);
+		if (delta < 0 || ((delta > 0 || batch_task(p)) &&
+			task_running(rq, p)))
+				resched_task(rq->curr);
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -2015,8 +2058,8 @@ static int setscheduler(pid_t pid, int p
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
-			goto out_unlock;
+			policy != SCHED_NORMAL && policy !=SCHED_BATCH)
+				goto out_unlock;
 	}
 
 	/*
@@ -2026,8 +2069,9 @@ static int setscheduler(pid_t pid, int p
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
-		goto out_unlock;
+	if ((policy == SCHED_NORMAL || policy == SCHED_BATCH) !=
+		(lp.sched_priority == 0))
+			goto out_unlock;
 
 	retval = -EPERM;
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
@@ -2048,7 +2092,7 @@ static int setscheduler(pid_t pid, int p
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	oldprio = p->prio;
-	if (policy != SCHED_NORMAL)
+	if (policy != SCHED_NORMAL && policy != SCHED_BATCH)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -2060,9 +2104,9 @@ static int setscheduler(pid_t pid, int p
 		 * this runqueue and our priority is higher than the current's
 		 */
 		if (rq->curr == p) {
-			if (p->prio > oldprio)
+			if (p->prio > oldprio || batch_task(p))
 				resched_task(rq->curr);
-		} else if (p->prio < rq->curr->prio)
+		} else if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 	}
 
@@ -2268,7 +2312,10 @@ asmlinkage long sys_sched_yield(void)
 	 */
 	if (likely(!rt_task(current))) {
 		dequeue_task(current, array);
-		enqueue_task(current, rq->expired);
+		if (unlikely(batch_task(current)))
+			enqueue_task(current, rq->batch);
+		else
+			enqueue_task(current, rq->expired);
 	} else {
 		list_del(&current->run_list);
 		list_add_tail(&current->run_list, array->queue + current->prio);
@@ -2353,6 +2400,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 		break;
 	}
@@ -2376,6 +2424,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 	}
 	return ret;
@@ -2808,12 +2857,13 @@ void __init sched_init(void)
 		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
+		rq->batch = rq->arrays + 2;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
 		nr_running_init(rq);
 
-		for (j = 0; j < 2; j++) {
+		for (j = 0; j < 3; j++) {
 			array = rq->arrays + j;
 			for (k = 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);

--Boundary-00=_OHli/O9fzO17/4y--

