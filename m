Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVEKDDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVEKDDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 23:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVEKDDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 23:03:07 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:51620 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261889AbVEKDCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 23:02:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: AndrewMorton <akpm@osdl.org>
Subject: [SMP NICE] [PATCH 1/2] SCHED: Implement nice support across physical cpus on SMP
Date: Wed, 11 May 2005 13:04:06 +1000
User-Agent: KMail/1.8
Cc: Carlos Carvalho <carlos@fisica.ufpr.br>, ck@vds.kolivas.org,
       Ingo Molnar <mingo@elte.hu>,
       Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org
References: <20050509112446.GZ1399@nysv.org> <200505092147.06384.kernel@kolivas.org> <17023.63512.319555.552924@fisica.ufpr.br>
In-Reply-To: <17023.63512.319555.552924@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mYXgCaik19k9gtz"
Message-Id: <200505111304.06853.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_mYXgCaik19k9gtz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andrew please consider for inclusion in -mm

--Boundary-00=_mYXgCaik19k9gtz
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="implement_smp_nice_balancing.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="implement_smp_nice_balancing.diff"

This patch implements 'nice' support across physical cpus on SMP.

It introduces an extra runqueue variable prio_bias which is the sum of the
(inverted) static priorities of all the tasks on the runqueue. This is then used
to bias busy rebalancing between runqueues to obtain good distribution of tasks
of different nice values. By biasing the balancing only during busy rebalancing
we can avoid having any significant loss of throughput by not affecting the
carefully tuned idle balancing already in place. If all tasks are running at the
same nice level this code should also have minimal effect. The code is optimised
out in the !CONFIG_SMP case.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.12-rc4-smpnice/kernel/sched.c
===================================================================
--- linux-2.6.12-rc4-smpnice.orig/kernel/sched.c	2005-05-08 20:18:01.000000000 +1000
+++ linux-2.6.12-rc4-smpnice/kernel/sched.c	2005-05-10 20:28:34.000000000 +1000
@@ -206,6 +206,7 @@ struct runqueue {
 	 */
 	unsigned long nr_running;
 #ifdef CONFIG_SMP
+	unsigned long prio_bias;
 	unsigned long cpu_load;
 #endif
 	unsigned long long nr_switches;
@@ -604,13 +605,45 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
+#ifdef CONFIG_SMP
+static inline void inc_prio_bias(runqueue_t *rq, int static_prio)
+{
+	rq->prio_bias += MAX_PRIO - static_prio;
+}
+
+static inline void dec_prio_bias(runqueue_t *rq, int static_prio)
+{
+	rq->prio_bias -= MAX_PRIO - static_prio;
+}
+#else
+static inline void inc_prio_bias(runqueue_t *rq, int static_prio)
+{
+}
+
+static inline void dec_prio_bias(runqueue_t *rq, int static_prio)
+{
+}
+#endif
+
+static inline void inc_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running++;
+	inc_prio_bias(rq, p->static_prio);
+}
+
+static inline void dec_nr_running(task_t *p, runqueue_t *rq)
+{
+	rq->nr_running--;
+	dec_prio_bias(rq, p->static_prio);
+}
+
 /*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
 
 /*
@@ -619,7 +652,7 @@ static inline void __activate_task(task_
 static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task_head(p, rq->active);
-	rq->nr_running++;
+	inc_nr_running(p, rq);
 }
 
 static void recalc_task_prio(task_t *p, unsigned long long now)
@@ -738,7 +771,7 @@ static void activate_task(task_t *p, run
  */
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	dec_nr_running(p, rq);
 	dequeue_task(p, p->array);
 	p->array = NULL;
 }
@@ -886,23 +919,37 @@ void kick_process(task_t *p)
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
-static inline unsigned long source_load(int cpu)
+static inline unsigned long source_load(int cpu, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long cpu_load = rq->cpu_load,
+		load_now = rq->nr_running * SCHED_LOAD_SCALE;
 
-	return min(rq->cpu_load, load_now);
+	if (idle == NOT_IDLE) {
+		/*
+		 * If we are balancing busy runqueues the load is biased by
+		 * priority to create 'nice' support across cpus.
+		 */
+		cpu_load *= rq->prio_bias;
+		load_now *= rq->prio_bias;
+	}
+	return min(cpu_load, load_now);
 }
 
 /*
  * Return a high guess at the load of a migration-target cpu
  */
-static inline unsigned long target_load(int cpu)
+static inline unsigned long target_load(int cpu, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long cpu_load = rq->cpu_load,
+		load_now = rq->nr_running * SCHED_LOAD_SCALE;
 
-	return max(rq->cpu_load, load_now);
+	if (idle == NOT_IDLE) {
+		cpu_load *= rq->prio_bias;
+		load_now *= rq->prio_bias;
+	}
+	return max(cpu_load, load_now);
 }
 
 #endif
@@ -1004,8 +1051,8 @@ static int try_to_wake_up(task_t * p, un
 	if (cpu == this_cpu || unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
 		goto out_set_cpu;
 
-	load = source_load(cpu);
-	this_load = target_load(this_cpu);
+	load = source_load(cpu, SCHED_IDLE);
+	this_load = target_load(this_cpu, SCHED_IDLE);
 
 	/*
 	 * If sync wakeup then subtract the (maximum possible) effect of
@@ -1226,7 +1273,7 @@ void fastcall wake_up_new_task(task_t * 
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array = current->array;
 				p->array->nr_active++;
-				rq->nr_running++;
+				inc_nr_running(p, rq);
 			}
 			set_need_resched();
 		} else
@@ -1509,7 +1556,7 @@ static int find_idlest_cpu(struct task_s
 	cpus_and(mask, sd->span, p->cpus_allowed);
 
 	for_each_cpu_mask(i, mask) {
-		load = target_load(i);
+		load = target_load(i, SCHED_IDLE);
 
 		if (load < min_load) {
 			min_cpu = i;
@@ -1522,7 +1569,7 @@ static int find_idlest_cpu(struct task_s
 	}
 
 	/* add +1 to account for the new task */
-	this_load = source_load(this_cpu) + SCHED_LOAD_SCALE;
+	this_load = source_load(this_cpu, SCHED_IDLE) + SCHED_LOAD_SCALE;
 
 	/*
 	 * Would with the addition of the new task to the
@@ -1613,9 +1660,9 @@ void pull_task(runqueue_t *src_rq, prio_
 	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	src_rq->nr_running--;
+	dec_nr_running(p, src_rq);
 	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
+	inc_nr_running(p, this_rq);
 	enqueue_task(p, this_array);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
@@ -1776,9 +1823,9 @@ find_busiest_group(struct sched_domain *
 		for_each_cpu_mask(i, group->cpumask) {
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
-				load = target_load(i);
+				load = target_load(i, idle);
 			else
-				load = source_load(i);
+				load = source_load(i, idle);
 
 			avg_load += load;
 		}
@@ -1887,14 +1934,14 @@ out_balanced:
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
-static runqueue_t *find_busiest_queue(struct sched_group *group)
+static runqueue_t *find_busiest_queue(struct sched_group *group, enum idle_type idle)
 {
 	unsigned long load, max_load = 0;
 	runqueue_t *busiest = NULL;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = source_load(i);
+		load = source_load(i, idle);
 
 		if (load > max_load) {
 			max_load = load;
@@ -1928,7 +1975,7 @@ static int load_balance(int this_cpu, ru
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group);
+	busiest = find_busiest_queue(group, idle);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2035,7 +2082,7 @@ static int load_balance_newidle(int this
 		goto out;
 	}
 
-	busiest = find_busiest_queue(group);
+	busiest = find_busiest_queue(group, NEWLY_IDLE);
 	if (!busiest || busiest == this_rq) {
 		schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
@@ -3196,7 +3243,9 @@ void set_user_nice(task_t *p, long nice)
 	 * not SCHED_NORMAL:
 	 */
 	if (rt_task(p)) {
+		dec_prio_bias(rq, p->static_prio);
 		p->static_prio = NICE_TO_PRIO(nice);
+		inc_prio_bias(rq, p->static_prio);
 		goto out_unlock;
 	}
 	array = p->array;
@@ -3206,7 +3255,9 @@ void set_user_nice(task_t *p, long nice)
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
+	dec_prio_bias(rq, p->static_prio);
 	p->static_prio = NICE_TO_PRIO(nice);
+	inc_prio_bias(rq, p->static_prio);
 	p->prio += delta;
 
 	if (array) {

--Boundary-00=_mYXgCaik19k9gtz--
