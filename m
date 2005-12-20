Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVLTExL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLTExL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 23:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVLTExL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 23:53:11 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:20730 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750795AbVLTExK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 23:53:10 -0500
Message-ID: <43A78E33.7040307@bigpond.net.au>
Date: Tue, 20 Dec 2005 15:53:07 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpu scheduler: unsquish dynamic priorities
Content-Type: multipart/mixed;
 boundary="------------000007090202000409020409"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 20 Dec 2005 04:53:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000007090202000409020409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The problem:

The current scheduler implementation maps 40 nice values and 10 bonus 
values into only 40 priority slots on the run queues.  This results in 
the dynamic priorities of tasks at either end of the nice scale being 
squished up.  E.g. all tasks with nice in the range -20 to -16 and the 
maximum of 10 bonus points will end up with a dynamic priority of 
MAX_RT_PRIO and all tasks with nice in the range 15 to 19 and no bonus 
points will end up with a dynamic priority of MAX_PRIO - 1.

Although the fact that niceness is primarily implemented by time slice 
size means that this will have little or no adverse effect on the long 
term allocation of CPU resources due to niceness, it could adversely 
effect latency as it will interfere with preemption.

The solution:

Increase the number of priority slots in the run queues to allow a 
linear mapping and eliminate the squish.

The implementation:

As the only place MAX_PRIO is used outside of sched.c is to initialize 
the init task in init_task.h, it is possible to implement the solution 
entirely within sched.c by defining a new macro IDLE_PRIO (which is 
equal to the sum of MAX_PRIO and MAX_BONUS) and then replacing MAX_PRIO 
by IDLE_PRIO where appropriate.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------000007090202000409020409
Content-Type: text/plain;
 name="unsquish-cpu-scheduler-dynamic-priorities"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unsquish-cpu-scheduler-dynamic-priorities"

Index: GIT-warnings/kernel/sched.c
===================================================================
--- GIT-warnings.orig/kernel/sched.c	2005-12-20 13:02:45.000000000 +1100
+++ GIT-warnings/kernel/sched.c	2005-12-20 13:04:02.000000000 +1100
@@ -180,14 +180,15 @@ static unsigned int task_timeslice(task_
  * These are the runqueue data structures:
  */
 
-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+#define IDLE_PRIO (MAX_PRIO + MAX_BONUS)
+#define BITMAP_SIZE ((((IDLE_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
 
 typedef struct runqueue runqueue_t;
 
 struct prio_array {
 	unsigned int nr_active;
 	unsigned long bitmap[BITMAP_SIZE];
-	struct list_head queue[MAX_PRIO];
+	struct list_head queue[IDLE_PRIO];
 };
 
 /*
@@ -645,18 +646,15 @@ static inline void enqueue_task_head(str
  */
 static int effective_prio(task_t *p)
 {
-	int bonus, prio;
+	int prio;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
+	prio = p->static_prio + MAX_BONUS - CURRENT_BONUS(p);
+	BUG_ON(prio < MAX_RT_PRIO);
+	BUG_ON(prio > IDLE_PRIO - 1);
 
-	prio = p->static_prio - bonus;
-	if (prio < MAX_RT_PRIO)
-		prio = MAX_RT_PRIO;
-	if (prio > MAX_PRIO-1)
-		prio = MAX_PRIO-1;
 	return prio;
 }
 
@@ -1861,7 +1859,7 @@ void pull_task(runqueue_t *src_rq, prio_
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
 	/*
-	 * Note that idle threads have a prio of MAX_PRIO, for this test
+	 * Note that idle threads have a prio of IDLE_PRIO, for this test
 	 * to be always true for them.
 	 */
 	if (TASK_PREEMPTS_CURR(p, this_rq))
@@ -1945,8 +1943,8 @@ skip_bitmap:
 	if (!idx)
 		idx = sched_find_first_bit(array->bitmap);
 	else
-		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
-	if (idx >= MAX_PRIO) {
+		idx = find_next_bit(array->bitmap, IDLE_PRIO, idx);
+	if (idx >= IDLE_PRIO) {
 		if (array == busiest->expired && busiest->active->nr_active) {
 			array = busiest->active;
 			dst_array = this_rq->active;
@@ -3056,7 +3054,7 @@ go_idle:
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
-		rq->best_expired_prio = MAX_PRIO;
+		rq->best_expired_prio = IDLE_PRIO;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -4396,7 +4394,7 @@ void __devinit init_idle(task_t *idle, i
 
 	idle->sleep_avg = 0;
 	idle->array = NULL;
-	idle->prio = MAX_PRIO;
+	idle->prio = IDLE_PRIO;
 	idle->state = TASK_RUNNING;
 	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
@@ -4737,7 +4735,7 @@ static void migrate_dead_tasks(unsigned 
 	struct runqueue *rq = cpu_rq(dead_cpu);
 
 	for (arr = 0; arr < 2; arr++) {
-		for (i = 0; i < MAX_PRIO; i++) {
+		for (i = 0; i < IDLE_PRIO; i++) {
 			struct list_head *list = &rq->arrays[arr].queue[i];
 			while (!list_empty(list))
 				migrate_dead(dead_cpu,
@@ -4793,7 +4791,7 @@ static int migration_call(struct notifie
 		/* Idle task back to normal (off runqueue, low prio) */
 		rq = task_rq_lock(rq->idle, &flags);
 		deactivate_task(rq->idle, rq);
-		rq->idle->static_prio = MAX_PRIO;
+		rq->idle->static_prio = IDLE_PRIO;
 		__setscheduler(rq->idle, SCHED_NORMAL, 0);
 		migrate_dead_tasks(cpu);
 		task_rq_unlock(rq, &flags);
@@ -5610,7 +5608,7 @@ void __init sched_init(void)
 		rq->nr_running = 0;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
-		rq->best_expired_prio = MAX_PRIO;
+		rq->best_expired_prio = IDLE_PRIO;
 
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
@@ -5625,12 +5623,12 @@ void __init sched_init(void)
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
-			for (k = 0; k < MAX_PRIO; k++) {
+			for (k = 0; k < IDLE_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
 				__clear_bit(k, array->bitmap);
 			}
 			// delimiter for bitsearch
-			__set_bit(MAX_PRIO, array->bitmap);
+			__set_bit(IDLE_PRIO, array->bitmap);
 		}
 	}
 

--------------000007090202000409020409--
