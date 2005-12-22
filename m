Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVLVAlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVLVAlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 19:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVLVAlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 19:41:19 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:56486 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965033AbVLVAlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 19:41:18 -0500
Message-ID: <43A9F62B.5030608@bigpond.net.au>
Date: Thu, 22 Dec 2005 11:41:15 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] cpu scheduler: unsquish dynamic priorities
References: <43A78E33.7040307@bigpond.net.au> <20051221093629.GA19867@elte.hu>
In-Reply-To: <20051221093629.GA19867@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------020203030800050106060305"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 22 Dec 2005 00:41:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020203030800050106060305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>The problem:
>>
>>The current scheduler implementation maps 40 nice values and 10 bonus 
>>values into only 40 priority slots on the run queues.  This results in 
>>the dynamic priorities of tasks at either end of the nice scale being 
>>squished up.  E.g. all tasks with nice in the range -20 to -16 and the 
>>maximum of 10 bonus points will end up with a dynamic priority of 
>>MAX_RT_PRIO and all tasks with nice in the range 15 to 19 and no bonus 
>>points will end up with a dynamic priority of MAX_PRIO - 1.
>>
>>Although the fact that niceness is primarily implemented by time slice 
>>size means that this will have little or no adverse effect on the long 
>>term allocation of CPU resources due to niceness, it could adversely 
>>effect latency as it will interfere with preemption.
> 
> 
> this property of the priority distribution was intentional from me, i 
> wanted to have an easy way to test 'no priority boosting downwards' 
> (nice +19) and 'no priority boosting upwards' (nice -20) conditions.  But
> i like your patch, because it simplifies effective_prio() a bit,

Yes and after some testing we should be able to drop the two BUG_ON() 
statements and simplify it even further.  I only put them in because the 
original code meant that the implicit assertion:

0 <= CURRENT_BONUS(p) <= MAX_BONUS

hasn't really been tested.  As a result of code review, I'm pretty sure 
that it holds but it doesn't hurt to be careful.

> and 
> with SCHED_BATCH we'll have the 'no boosting' property anyway. Could you 
> redo the patch against the current scheduler queue in -mm, so that we 
> can try it out in -mm?

Attached is a patch against 2.6.15-rc5-mm3.

> 
> Btw., another user-visible effect is that task_prio() will return the 
> new range, which will be visible in e.g. 'top'. I dont think it will be 
> confusing though.

No, people will get used to it.  Interactive tasks (with nice 0) now 
tend to get a dynamic priority of 20 instead of 15 which looks more 
natural (to me).  But I guess it makes the interactive adjustment look 
more like a penalty imposed on non interactive tasks rather than a bonus 
given to interactive tasks.  But this is simpler than the original 
version where it looks like a combination of a bonus to interactive 
tasks and a penalty for non interactive tasks.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------020203030800050106060305
Content-Type: text/plain;
 name="unsquish-cpu-scheduler-dynamic-priorities-2.6.15-rc5-mm3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unsquish-cpu-scheduler-dynamic-priorities-2.6.15-rc5-mm3"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2005-12-22 10:12:13.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2005-12-22 10:13:07.000000000 +1100
@@ -157,7 +157,7 @@
 	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
 
 #define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+	((p)->prio <= (p)->static_prio - DELTA(p) + MAX_BONUS / 2)
 
 #define INTERACTIVE_SLEEP(p) \
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
@@ -199,14 +199,15 @@ EXPORT_SYMBOL_GPL(__put_task_struct_cb);
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
@@ -664,18 +665,15 @@ static inline void enqueue_task_head(str
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
 
@@ -1867,7 +1865,7 @@ void pull_task(runqueue_t *src_rq, prio_
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
 	/*
-	 * Note that idle threads have a prio of MAX_PRIO, for this test
+	 * Note that idle threads have a prio of IDLE_PRIO, for this test
 	 * to be always true for them.
 	 */
 	if (TASK_PREEMPTS_CURR(p, this_rq))
@@ -1952,8 +1950,8 @@ skip_bitmap:
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
@@ -3071,7 +3069,7 @@ go_idle:
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
-		rq->best_expired_prio = MAX_PRIO;
+		rq->best_expired_prio = IDLE_PRIO;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -4434,7 +4432,7 @@ void __devinit init_idle(task_t *idle, i
 
 	idle->sleep_avg = 0;
 	idle->array = NULL;
-	idle->prio = MAX_PRIO;
+	idle->prio = IDLE_PRIO;
 	idle->state = TASK_RUNNING;
 	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
@@ -4775,7 +4773,7 @@ static void migrate_dead_tasks(unsigned 
 	struct runqueue *rq = cpu_rq(dead_cpu);
 
 	for (arr = 0; arr < 2; arr++) {
-		for (i = 0; i < MAX_PRIO; i++) {
+		for (i = 0; i < IDLE_PRIO; i++) {
 			struct list_head *list = &rq->arrays[arr].queue[i];
 			while (!list_empty(list))
 				migrate_dead(dead_cpu,
@@ -4954,7 +4952,7 @@ static int migration_call(struct notifie
 		/* Idle task back to normal (off runqueue, low prio) */
 		rq = task_rq_lock(rq->idle, &flags);
 		deactivate_task(rq->idle, rq);
-		rq->idle->static_prio = MAX_PRIO;
+		rq->idle->static_prio = IDLE_PRIO;
 		__setscheduler(rq->idle, SCHED_NORMAL, 0);
 		migrate_dead_tasks(cpu);
 		task_rq_unlock(rq, &flags);
@@ -6239,7 +6237,7 @@ void __init sched_init(void)
 		rq->nr_running = 0;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
-		rq->best_expired_prio = MAX_PRIO;
+		rq->best_expired_prio = IDLE_PRIO;
 
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
@@ -6254,12 +6252,12 @@ void __init sched_init(void)
 
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
 

--------------020203030800050106060305--
