Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUA2IRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 03:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUA2IRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 03:17:55 -0500
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:58046 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261950AbUA2IRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 03:17:48 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.1 Hyperthread smart "nice"
Date: Thu, 29 Jan 2004 19:17:42 +1100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mGMGADs42Dsp5cZ"
Message-Id: <200401291917.42087.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_mGMGADs42Dsp5cZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all

Not pushing this for mainline because this is not the "right way" to do it, 
but it works here and now for those who have P4HT processors. 

A while back we had an lkml thread about the problem of running low priority 
tasks on hyperthread enabled cpus in SMP mode. Brief summary: If you run a 
P4HT in uniprocessor mode and run a cpu intensive task at nice +20 (like 
setiathome), the most cpu it will get during periods of heavy usage is about 
8%. If you boot a P4HT in SMP mode and run a cpu intensive task at nice +20 
then if you run a task even at nice -20 concurrently, the nice +20 task will 
get 50% of the cpu time even though you have a very high priority task. So 
ironically booting in SMP mode makes your machine slower for running 
background tasks.

This patch (together with the ht base patch) will not allow a priority >10 
difference to run concurrently on both siblings, instead putting the low 
priority one to sleep. Overall if you run concurrent nice 0 and nice 20 tasks 
with this patch your cpu throughput will drop during heavy periods by up to 
10% (the hyperthread benefit), but your nice 0 task will run about 90% 
faster. It has no effect if you don't run any tasks at different "nice" 
levels. It does not modify real time tasks or kernel threads, and will allow 
niced tasks to run while a high priority kernel thread is running on the 
sibling cpu.

http://ck.kolivas.org/patches/2.6/2.6.1/experimental/
There are other patches that go with it which is why these have slight offsets 
but should work ok.

Con

--Boundary-00=_mGMGADs42Dsp5cZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.6.1.O21-htbase1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.1.O21-htbase1"

--- linux-2.6.1/kernel/sched.c	2004-01-27 16:28:49.295067104 +1100
+++ linux-2.6.1-ck1/kernel/sched.c	2004-01-27 16:29:12.683511520 +1100
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
@@ -2814,6 +2819,7 @@ void __init sched_init(void)
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
+		rq->cpu = (unsigned long)(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		rq->best_expired_prio = MAX_PRIO;

--Boundary-00=_mGMGADs42Dsp5cZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.6.1.httweak1-htnice1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.1.httweak1-htnice1"

--- linux-2.6.1/kernel/sched.c	2004-01-27 16:34:48.582447120 +1100
+++ linux-2.6.1-ck1/kernel/sched.c	2004-01-27 16:35:02.671305288 +1100
@@ -1561,6 +1561,20 @@ need_resched:
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
@@ -1581,6 +1595,47 @@ need_resched:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
+#ifdef CONFIG_SMP
+	if (ht_active && next->mm && !rt_task(next)) {
+		runqueue_t *htrq;
+		htrq = cpu_rq(cpu_sibling_map[(rq->cpu)]);
+		task_t *htcurr;
+		htcurr = htrq->curr;
+
+		if (likely(htcurr->mm && !rt_task(htcurr))){
+			/*
+			 * If a user task with >10 dynamic +
+			 * static priority difference from another
+			 * running user task on the hyperthread sibling
+			 * is trying to schedule, delay it to prevent a
+			 * lower priority task from using an unfair
+			 * proportion of the physical cpu resources.
+			 */
+			if (next->prio + next->static_prio >
+				htcurr->prio + htcurr->static_prio + 10) {
+					next = rq->idle;
+					goto switch_tasks;
+			}
+
+			/*
+			 * Reschedule a lower priority task
+			 * on the HT sibling if present.
+			 */
+			if (htcurr->prio + htcurr->static_prio >
+				next->prio + next->static_prio + 10)
+					resched_task(htcurr);
+			else
+				/*
+				 * If a HT sibling task has been put to sleep
+				 * previously for priority reasons wake it up
+				 * now.
+				 */
+				if (htcurr == htrq->idle && htrq->nr_running)
+					resched_task(htcurr);
+		}
+	}
+#endif
+
 	if (next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
 

--Boundary-00=_mGMGADs42Dsp5cZ--

