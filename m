Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265662AbUBBJ1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbUBBJ1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:27:35 -0500
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:30605 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265662AbUBBJ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:27:20 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Date: Mon, 2 Feb 2004 20:27:10 +1100
User-Agent: KMail/1.6
Cc: Jos Hulzink <josh@stack.nl>
References: <200401291917.42087.kernel@kolivas.org> <200401291039.22561.josh@stack.nl>
In-Reply-To: <200401291039.22561.josh@stack.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ufhHA038QM+2itJ"
Message-Id: <200402022027.10151.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ufhHA038QM+2itJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Following on from the previous hyperthread smart nice patch;

>A while back we had an lkml thread about the problem of running low priority 
>tasks on hyperthread enabled cpus in SMP mode. Brief summary: If you run a 
>P4HT in uniprocessor mode and run a cpu intensive task at nice +20 (like 
>setiathome), the most cpu it will get during periods of heavy usage is about 
>8%. If you boot a P4HT in SMP mode and run a cpu intensive task at nice +20 
>then if you run a task even at nice -20 concurrently, the nice +20 task will 
>get 50% of the cpu time even though you have a very high priority task. So 
>ironically booting in SMP mode makes your machine slower for running 
>background tasks.

Criticism was laid at the previous patch for the way a more "nice" task might 
never run on the sibling cpu if a high priority task was running. This patch 
is a much better solution.

What this one does is the following; If there is a "nice" difference between 
tasks running on logical cores of the same cpu, the more "nice" one will run 
a proportion of time equal to the timeslice it would have been given relative 
to the less "nice" task. 
ie a nice 19 task running on one core and the nice 0 task running on the other 
core will let the nice 0 task run continuously (102ms is normal timeslice) 
and the nice 19 task will only run for the last 10ms of time the nice 0 task 
is running. This makes for a much more balanced resource distribution, gives 
significant preference to the higher priority task, but allows them to 
benefit from running on both logical cores.

This seems to me a satisfactory solution to the hyperthread vs nice problem. 
Once again this is too arch. specific a change to sched.c for mainline, but 
as proof of concept I believe it works well for those who need something that 
works that they can use now.

http://ck.kolivas.org/patches/2.6/2.6.1/experimental/

The stuff on my website is incremental with my other experiments, but the 
attached patch applies cleanly to 2.6.1

Con

--Boundary-00=_ufhHA038QM+2itJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.6.1-htn2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.1-htn2"

--- linux-2.6.1-base/kernel/sched.c	2004-01-09 22:57:04.000000000 +1100
+++ linux-2.6.1-htn2/kernel/sched.c	2004-02-02 20:01:17.042394133 +1100
@@ -208,6 +208,7 @@ struct runqueue {
 	atomic_t *node_nr_running;
 	int prev_node_load[MAX_NUMNODES];
 #endif
+	unsigned long cpu;
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
@@ -221,6 +222,10 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+#define ht_active		(cpu_has_ht && smp_num_siblings > 1)
+#define ht_siblings(cpu1, cpu2)	(ht_active && \
+	cpu_sibling_map[(cpu1)] == (cpu2))
+
 /*
  * Default context-switch locking:
  */
@@ -1380,6 +1385,10 @@ void scheduler_tick(int user_ticks, int 
 			cpustat->iowait += sys_ticks;
 		else
 			cpustat->idle += sys_ticks;
+		if (rq->nr_running) {
+			resched_task(p);
+			goto out;
+		}
 		rebalance_tick(rq, 1);
 		return;
 	}
@@ -1536,6 +1545,20 @@ need_resched:
 		if (!rq->nr_running) {
 			next = rq->idle;
 			rq->expired_timestamp = 0;
+#ifdef CONFIG_SMP
+			if (ht_active) {
+				/*
+				 * If a HT sibling task is sleeping due to
+				 * priority reasons wake it up now
+				 */
+				runqueue_t *htrq;
+				htrq = cpu_rq(cpu_sibling_map[(rq->cpu)]);
+
+				if (htrq->curr == htrq->idle &&
+					htrq->nr_running)
+						resched_task(htrq->idle);
+			}
+#endif
 			goto switch_tasks;
 		}
 	}
@@ -1555,6 +1578,42 @@ need_resched:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
+#ifdef CONFIG_SMP
+	if (ht_active) {
+		runqueue_t *htrq;
+		htrq = cpu_rq(cpu_sibling_map[(rq->cpu)]);
+		task_t *htcurr;
+		htcurr = htrq->curr;
+
+		/*
+		 * If a user task with lower static priority than the
+		 * running task on the hyperthread sibling is trying
+		 * to schedule, delay it till there is equal timeslice
+		 * left of the hyperthread task to prevent a lower priority
+		 * task from using an unfair proportion of the physical
+		 * cpu's resources.
+		 */
+		if (next->mm && htcurr->mm && !rt_task(next) && 
+			((next->static_prio > 
+			htcurr->static_prio && htcurr->time_slice > 
+			task_timeslice(next)) || rt_task(htcurr))) {
+				next = rq->idle;
+				goto switch_tasks;
+		}
+		
+		/*
+		 * Reschedule a lower priority task
+		 * on the HT sibling, or wake it up if it has been
+		 * put to sleep for priority reasons.
+		 */
+		if ((htcurr != htrq->idle && 
+			htcurr->static_prio > next->static_prio) ||
+			(rt_task(next) && !rt_task(htcurr)) ||
+			(htcurr == htrq->idle && htrq->nr_running))
+				resched_task(htcurr);
+	}
+#endif
+
 	if (next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
 
@@ -2809,6 +2868,7 @@ void __init sched_init(void)
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
+		rq->cpu = (unsigned long)(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);

--Boundary-00=_ufhHA038QM+2itJ--
