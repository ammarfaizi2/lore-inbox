Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVARNDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVARNDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVARNDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:03:07 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:41452 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261288AbVARNCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:02:08 -0500
Message-ID: <41ED08AB.5060308@kolivas.org>
Date: Wed, 19 Jan 2005 00:01:31 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, joq@io.com, CK Kernel <ck@vds.kolivas.org>
Subject: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt scheduling
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig464E92CCF88CD094C6A08887"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig464E92CCF88CD094C6A08887
Content-Type: multipart/mixed;
 boundary="------------080109070002030205090200"

This is a multi-part message in MIME format.
--------------080109070002030205090200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch for 2.6.11-rc1 provides a method of providing real time
scheduling to unprivileged users which increasingly is desired for
multimedia workloads.

It does this by adding a new scheduling class called SCHED_ISO or
Isochronous scheduling which means "same time" scheduling. This class
does not require superuser privileges and is starvation free. The
scheduling class no. 4 was chosen since there are quite a few userspace
applications already supporting 3 and 4 for SCHED_BATCH and SCHED_ISO
respectively on non-mainline kernels. As a way of immediately providing
support for current userspace apps, any unprivileged user starting an
application requesting SCHED_RR or SCHED_FIFO will be demoted to
SCHED_ISO. This may or may not be worth removing later.

The SCHED_ISO class runs as SCHED_RR effectively at a priority just
above all SCHED_NORMAL tasks and below all true real time tasks. Once a
cpu usage limit is exceeded by tasks of this class (per cpu), SCHED_ISO
tasks will then run as SCHED_NORMAL until the cpu usage drops to 90% of
the cpu limit.

By default the cpu limit is set to 70% which literature suggests should
provide good real time behaviour for most applications without gross
unfairness. This cpu limit is calculated as a decaying average over 5
seconds. These limits are configurable with the tunables
/proc/sys/kernel/iso_cpu
/proc/sys/kernel/iso_period

iso_cpu can be set to 100 which would allow all unprivileged users
access to unrestricted SCHED_RR behaviour. OSX provides a similar class
to SCHED_ISO and uses 90% as its cpu limit.

The sysrq-n combination which converts all user real-time tasks to
SCHED_NORMAL also will affect SCHED_ISO tasks.

Currently the round robin interval is set to 10ms which is a cache
friendly timeslice. It may be worth making this configurable or smaller,
and it would also be possible to implement SCHED_ISO of a FIFO nature as
well.

For testing, the userspace tool schedtool available here:
http://freequaos.host.sk/schedtool/
can be used as a wrapper to start SCHED_ISO tasks
schedtool -I -e xmms
for example

Patch also available here:
http://ck.kolivas.org/patches/SCHED_ISO/

Comments and testing welcome.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


--------------080109070002030205090200
Content-Type: text/x-diff;
 name="2.6.11-rc1-iso-0501182249.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.11-rc1-iso-0501182249.diff"

Index: linux-2.6.11-rc1/include/linux/init_task.h
===================================================================
--- linux-2.6.11-rc1.orig/include/linux/init_task.h	2005-01-16 22:43:47.000000000 +1100
+++ linux-2.6.11-rc1/include/linux/init_task.h	2005-01-16 22:45:23.000000000 +1100
@@ -80,6 +80,7 @@
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
+	.iso_list	= LIST_HEAD_INIT(tsk.iso_list),			\
 	.time_slice	= HZ,						\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
Index: linux-2.6.11-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.11-rc1.orig/include/linux/sched.h	2005-01-16 22:43:47.000000000 +1100
+++ linux-2.6.11-rc1/include/linux/sched.h	2005-01-18 22:48:05.000000000 +1100
@@ -130,6 +130,18 @@
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+/* policy 3 reserved for SCHED_BATCH */
+#define SCHED_ISO		4
+
+extern int iso_cpu, iso_period;
+
+#define SCHED_RANGE(policy)	((policy) == SCHED_NORMAL || \
+				(policy) == SCHED_FIFO || \
+				(policy) == SCHED_RR || \
+				(policy) == SCHED_ISO)
+
+#define SCHED_RT(policy)	((policy) == SCHED_FIFO || \
+				(policy) == SCHED_RR)
 
 struct sched_param {
 	int sched_priority;
@@ -359,6 +371,7 @@
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
+#define iso_task(p)		(unlikely((p)->policy == SCHED_ISO))
 
 /*
  * Some day this will be a full-fledged user tracking system..
@@ -536,6 +549,7 @@
 
 	int prio, static_prio;
 	struct list_head run_list;
+	struct list_head iso_list;
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
Index: linux-2.6.11-rc1/include/linux/sysctl.h
===================================================================
--- linux-2.6.11-rc1.orig/include/linux/sysctl.h	2005-01-16 22:43:47.000000000 +1100
+++ linux-2.6.11-rc1/include/linux/sysctl.h	2005-01-16 22:45:23.000000000 +1100
@@ -135,6 +135,8 @@
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
+	KERN_ISO_CPU=68,	/* int: cpu% allowed by SCHED_ISO class */
+	KERN_ISO_PERIOD=69,	/* int: seconds over which SCHED_ISO cpu is decayed */
 };
 
 
Index: linux-2.6.11-rc1/kernel/sched.c
===================================================================
--- linux-2.6.11-rc1.orig/kernel/sched.c	2005-01-16 22:43:47.000000000 +1100
+++ linux-2.6.11-rc1/kernel/sched.c	2005-01-18 22:48:47.000000000 +1100
@@ -149,9 +149,6 @@
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
-
 /*
  * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
  * to time slice values: [800ms ... 100ms ... 5ms]
@@ -171,6 +168,10 @@
 	else
 		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
 }
+
+int iso_cpu = 70;	/* The soft %cpu limit on SCHED_ISO tasks */
+int iso_period = 5;	/* The time over which SCHED_ISO cpu decays */
+
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
@@ -206,6 +207,16 @@
 #ifdef CONFIG_SMP
 	unsigned long cpu_load;
 #endif
+	unsigned long iso_ticks;
+	struct list_head iso_queue;
+	int iso_refractory;
+	/* 
+	 * Refractory is the flag that we've hit the maximum iso cpu and are
+	 * in the refractory period where SCHED_ISO tasks can only run as
+	 * SCHED_NORMAL until their cpu usage drops to 90% of their iso_cpu
+	 * limit.
+	 */
+
 	unsigned long long nr_switches;
 
 	/*
@@ -297,6 +308,19 @@
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
+static inline int task_preempts_curr(task_t *p, runqueue_t *rq)
+{
+	if ((!iso_task(p) && !iso_task(rq->curr)) || rq->iso_refractory ||
+		rt_task(p) || rt_task(rq->curr)) {
+			if (p->prio < rq->curr->prio)
+				return 1;
+			return 0;
+	}
+	if (iso_task(p) && !iso_task(rq->curr))
+		return 1;
+	return 0;
+}
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -560,17 +584,40 @@
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS */
 
+static inline int iso_queued(runqueue_t *rq)
+{
+	return !list_empty(&rq->iso_queue);
+}
+
+static inline void dequeue_iso_task(struct task_struct *p)
+{
+	list_del_init(&p->iso_list);
+}
+
 /*
  * Adding/removing a task to/from a priority array:
  */
 static void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
 	array->nr_active--;
+	if (iso_task(p))
+		dequeue_iso_task(p);
 	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
 }
 
+/*
+ * SCHED_ISO tasks are queued at both runqueues. Their actual priority is
+ * either better than SCHED_NORMAL if below starvation limits, or
+ * the underlying SCHED_NORMAL dynamic priority.
+ */
+static void enqueue_iso_task(struct task_struct *p)
+{
+	runqueue_t *rq = task_rq(p);
+	list_add_tail(&p->iso_list, &rq->iso_queue);
+}
+
 static void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
 	sched_info_queued(p);
@@ -578,6 +625,14 @@
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
+	if (iso_task(p))
+		enqueue_iso_task(p);
+}
+
+static void requeue_iso_task(struct task_struct *p)
+{
+	runqueue_t *rq = task_rq(p);
+	list_move_tail(&p->iso_list, &rq->iso_queue);
 }
 
 /*
@@ -587,6 +642,8 @@
 static void requeue_task(struct task_struct *p, prio_array_t *array)
 {
 	list_move_tail(&p->run_list, array->queue + p->prio);
+	if (iso_task(p))
+		requeue_iso_task(p);
 }
 
 static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
@@ -1101,7 +1158,7 @@
 	 */
 	activate_task(p, rq, cpu == this_cpu);
 	if (!sync || cpu != this_cpu) {
-		if (TASK_PREEMPTS_CURR(p, rq))
+		if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 	success = 1;
@@ -1146,6 +1203,7 @@
 	 */
 	p->state = TASK_RUNNING;
 	INIT_LIST_HEAD(&p->run_list);
+	INIT_LIST_HEAD(&p->iso_list);
 	p->array = NULL;
 	spin_lock_init(&p->switch_lock);
 #ifdef CONFIG_SCHEDSTATS
@@ -1235,6 +1293,8 @@
 				p->array = current->array;
 				p->array->nr_active++;
 				rq->nr_running++;
+				if (iso_task(p))
+					enqueue_iso_task(p);
 			}
 			set_need_resched();
 		} else
@@ -1257,7 +1317,7 @@
 		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
 		__activate_task(p, rq);
-		if (TASK_PREEMPTS_CURR(p, rq))
+		if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 
 		schedstat_inc(rq, wunt_moved);
@@ -1634,7 +1694,7 @@
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (TASK_PREEMPTS_CURR(p, this_rq))
+	if (task_preempts_curr(p, this_rq))
 		resched_task(this_rq->curr);
 }
 
@@ -2392,6 +2452,39 @@
 		cpustat->steal = cputime64_add(cpustat->steal, steal64);
 }
 
+static inline int inc_iso_ticks(runqueue_t *rq, task_t *p)
+{
+	int ret = 0;
+	if (rq->iso_ticks < (iso_period * HZ * 100 - 99))
+		rq->iso_ticks += 100;
+	spin_lock(&rq->lock);
+	if (!rq->iso_refractory && (rq->iso_ticks /
+		((iso_period * HZ) + 1) > iso_cpu)) {
+			rq->iso_refractory = 1;
+			if (iso_queued(rq))
+				ret = 1;
+		}
+	spin_unlock(&rq->lock);
+	return ret;
+}
+
+static inline int dec_iso_ticks(runqueue_t *rq, task_t *p)
+{
+	int ret = 0;
+	if (rq->iso_ticks) 
+		rq->iso_ticks = rq->iso_ticks * (iso_period * HZ - 1) /
+			(iso_period * HZ);
+	spin_lock(&rq->lock);
+	if (rq->iso_refractory && (rq->iso_ticks /
+		((iso_period * HZ) + 1) < (iso_cpu * 9 / 10))) {
+			rq->iso_refractory = 0;
+			if (iso_queued(rq)) 
+				ret = 1;
+	}
+	spin_unlock(&rq->lock);
+	return ret;
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -2404,8 +2497,13 @@
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	int iso_change;
 
 	rq->timestamp_last_tick = sched_clock();
+	if (iso_task(p) && !rq->iso_refractory)
+		iso_change = inc_iso_ticks(rq, p);
+	else 
+		iso_change = dec_iso_ticks(rq, p);
 
 	if (p == rq->idle) {
 		if (wake_priority_sleeper(rq))
@@ -2420,6 +2518,7 @@
 		goto out;
 	}
 	spin_lock(&rq->lock);
+
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter. Note: we do not update a thread's
@@ -2442,6 +2541,39 @@
 		}
 		goto out_unlock;
 	}
+
+	if (unlikely(iso_change)) {
+		/*
+		 * A SCHED_ISO task was running and the soft cpu limit
+		 * was hit, or SCHED_ISO task(s) are waiting and the 
+		 * refractory period has ended. Reschedule to start ISO
+		 * tasks as SCHED_NORMAL in the former case and to allow
+		 * SCHED_ISO tasks to preempt in the latter.
+		 */
+		set_tsk_need_resched(p);
+		dequeue_task(p, rq->active);
+		p->prio = effective_prio(p);
+		p->time_slice = task_timeslice(p);
+		p->first_time_slice = 0;
+		enqueue_task(p, rq->active);
+		goto out_unlock;
+	}
+
+	if (iso_task(p) && !rq->iso_refractory) {
+		if (!--p->time_slice) {
+			p->time_slice = task_timeslice(p);
+			p->first_time_slice = 0;
+			set_tsk_need_resched(p);
+
+			/* put it at the end of the queue: */
+			requeue_task(p, rq->active);
+		} else if (!(p->time_slice % GRANULARITY)) {
+			requeue_task(p, rq->active);
+			set_tsk_need_resched(p);
+		}
+		goto out_unlock;
+	}
+
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
@@ -2489,6 +2621,30 @@
 	rebalance_tick(cpu, rq, NOT_IDLE);
 }
 
+static inline int iso_ready(runqueue_t *rq)
+{
+	if (iso_queued(rq) && !rq->iso_refractory)
+		return 1;
+	return 0;
+}
+
+/*
+ * When a SCHED_ISO task is ready to be scheduled, we re-queue it with an
+ * effective prio of MAX_RT_PRIO for userspace to know its relative prio.
+ */
+static task_t* queue_iso(runqueue_t *rq, prio_array_t *array)
+{
+	task_t *p = list_entry(rq->iso_queue.next, task_t, iso_list);
+	prio_array_t *old_array = p->array;
+	list_del(&p->run_list);
+	if (list_empty(old_array->queue + p->prio))
+		__clear_bit(p->prio, old_array->bitmap);
+	p->prio = MAX_RT_PRIO;
+	list_add_tail(&p->run_list, array->queue + p->prio);
+	__set_bit(p->prio, array->bitmap);
+	return p;
+}
+
 #ifdef CONFIG_SCHED_SMT
 static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
@@ -2540,7 +2696,7 @@
 	struct sched_domain *sd = this_rq->sd;
 	cpumask_t sibling_map;
 	prio_array_t *array;
-	int ret = 0, i;
+	int ret = 0, i, idx;
 	task_t *p;
 
 	if (!(sd->flags & SD_SHARE_CPUPOWER))
@@ -2567,8 +2723,11 @@
 		array = this_rq->expired;
 	BUG_ON(!array->nr_active);
 
-	p = list_entry(array->queue[sched_find_first_bit(array->bitmap)].next,
-		task_t, run_list);
+	idx = sched_find_first_bit(array->bitmap);
+	if (unlikely(iso_ready(this_rq) && idx >= MAX_RT_PRIO))
+		p = queue_iso(this_rq, array);
+	else
+		p = list_entry(array->queue[idx].next, task_t, run_list);
 
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
@@ -2584,7 +2743,7 @@
 		 */
 		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
 			task_timeslice(p) || rt_task(smt_curr)) &&
-			p->mm && smt_curr->mm && !rt_task(p))
+			p->mm && smt_curr->mm && !rt_task(p) && !iso_task(p))
 				ret = 1;
 
 		/*
@@ -2594,8 +2753,9 @@
 		 */
 		if ((((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
 			task_timeslice(smt_curr) || rt_task(p)) &&
-			smt_curr->mm && p->mm && !rt_task(smt_curr)) ||
-			(smt_curr == smt_rq->idle && smt_rq->nr_running))
+			smt_curr->mm && p->mm && !rt_task(smt_curr) &&
+			!iso_task(smt_curr)) || (smt_curr == smt_rq->idle &&
+			smt_rq->nr_running))
 				resched_task(smt_curr);
 	}
 out_unlock:
@@ -2767,8 +2927,12 @@
 		schedstat_inc(rq, sched_noswitch);
 
 	idx = sched_find_first_bit(array->bitmap);
-	queue = array->queue + idx;
-	next = list_entry(queue->next, task_t, run_list);
+	if (unlikely(iso_ready(rq) && idx >= MAX_RT_PRIO))
+		next = queue_iso(rq, array);
+	else {
+		queue = array->queue + idx;
+		next = list_entry(queue->next, task_t, run_list);
+	}
 
 	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
@@ -3213,7 +3377,7 @@
 	BUG_ON(p->array);
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL)
+	if (SCHED_RT(policy))
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -3238,9 +3402,8 @@
 	/* double check policy once rq lock held */
 	if (policy < 0)
 		policy = oldpolicy = p->policy;
-	else if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
-			return -EINVAL;
+	else if (!SCHED_RANGE(policy))
+		return -EINVAL;
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
@@ -3248,12 +3411,16 @@
 	if (param->sched_priority < 0 ||
 	    param->sched_priority > MAX_USER_RT_PRIO-1)
 		return -EINVAL;
-	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
+	if ((!SCHED_RT(policy)) != (param->sched_priority == 0))
 		return -EINVAL;
 
-	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
-	    !capable(CAP_SYS_NICE))
-		return -EPERM;
+	if (SCHED_RT(policy) && !capable(CAP_SYS_NICE))
+		/*
+		 * If the caller requested an RT policy without having the
+		 * necessary rights, we downgrade the policy to SCHED_ISO.
+		 * Temporary hack for testing.
+		 */
+		policy = SCHED_ISO;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
 	    !capable(CAP_SYS_NICE))
 		return -EPERM;
@@ -3287,7 +3454,7 @@
 		if (task_running(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
-		} else if (TASK_PREEMPTS_CURR(p, rq))
+		} else if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 	task_rq_unlock(rq, &flags);
@@ -3714,6 +3881,7 @@
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_ISO:
 		ret = 0;
 		break;
 	}
@@ -3737,6 +3905,7 @@
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_ISO:
 		ret = 0;
 	}
 	return ret;
@@ -4010,7 +4179,7 @@
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest, 0);
-		if (TASK_PREEMPTS_CURR(p, rq_dest))
+		if (task_preempts_curr(p, rq_dest))
 			resched_task(rq_dest->curr);
 	}
 
@@ -4792,6 +4961,7 @@
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		rq->best_expired_prio = MAX_PRIO;
+		rq->iso_refractory = rq->iso_ticks = 0;
 
 #ifdef CONFIG_SMP
 		rq->sd = &sched_domain_dummy;
@@ -4812,6 +4982,7 @@
 			// delimiter for bitsearch
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
+		INIT_LIST_HEAD(&rq->iso_queue);
 	}
 
 	/*
@@ -4861,7 +5032,7 @@
 
 	read_lock_irq(&tasklist_lock);
 	for_each_process (p) {
-		if (!rt_task(p))
+		if (!rt_task(p) && !iso_task(p))
 			continue;
 
 		rq = task_rq_lock(p, &flags);
Index: linux-2.6.11-rc1/kernel/sysctl.c
===================================================================
--- linux-2.6.11-rc1.orig/kernel/sysctl.c	2005-01-16 22:43:47.000000000 +1100
+++ linux-2.6.11-rc1/kernel/sysctl.c	2005-01-16 22:45:23.000000000 +1100
@@ -219,6 +219,11 @@
 	{ .ctl_name = 0 }
 };
 
+/* Constants for minimum and maximum testing in vm_table.
+   We use these as one-element integer vectors. */
+static int zero;
+static int one_hundred = 100;
+
 static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSTYPE,
@@ -633,15 +638,28 @@
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_ISO_CPU,
+		.procname	= "iso_cpu",
+		.data		= &iso_cpu,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
+	{
+		.ctl_name	= KERN_ISO_PERIOD,
+		.procname	= "iso_period",
+		.data		= &iso_period,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
-/* Constants for minimum and maximum testing in vm_table.
-   We use these as one-element integer vectors. */
-static int zero;
-static int one_hundred = 100;
-
-
 static ctl_table vm_table[] = {
 	{
 		.ctl_name	= VM_OVERCOMMIT_MEMORY,





--------------080109070002030205090200--

--------------enig464E92CCF88CD094C6A08887
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7QirZUg7+tp6mRURApHcAJ9akAimCEWE35xo2JOfDsIMrUYIbgCfep2U
P9zuNMQwSwG8Pmn6FbiO4Kw=
=Dyng
-----END PGP SIGNATURE-----

--------------enig464E92CCF88CD094C6A08887--
