Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVBXHaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVBXHaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVBXH3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:29:50 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:50342 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261893AbVBXHYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:24:38 -0500
Subject: [PATCH 8/13] generalised CPU load averaging
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229760.5177.81.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
	 <1109229542.5177.73.camel@npiggin-nld.site>
	 <1109229650.5177.78.camel@npiggin-nld.site>
	 <1109229700.5177.79.camel@npiggin-nld.site>
	 <1109229760.5177.81.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-o9taG/8gqzOyZjLWe8Y4"
Date: Thu, 24 Feb 2005 18:24:27 +1100
Message-Id: <1109229867.5177.84.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o9taG/8gqzOyZjLWe8Y4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

8/13


--=-o9taG/8gqzOyZjLWe8Y4
Content-Disposition: attachment; filename=sched-balance-timers.patch
Content-Type: text/x-patch; name=sched-balance-timers.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Do CPU load averaging over a number of different intervals. Allow
each interval to be chosen by sending a parameter to source_load
and target_load. 0 is instantaneous, idx > 0 returns a decaying average
with the most recent sample weighted at 2^(idx-1). To a maximum of 3
(could be easily increased).

So generally a higher number will result in more conservative balancing.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/include/asm-i386/topology.h
===================================================================
--- linux-2.6.orig/include/asm-i386/topology.h	2005-02-24 17:31:22.664322588 +1100
+++ linux-2.6/include/asm-i386/topology.h	2005-02-24 17:43:37.733579601 +1100
@@ -77,6 +77,10 @@
 	.imbalance_pct		= 125,			\
 	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
+	.busy_idx		= 3,			\
+	.idle_idx		= 1,			\
+	.newidle_idx		= 2,			\
+	.wake_idx		= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
Index: linux-2.6/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/topology.h	2005-02-24 17:31:22.664322588 +1100
+++ linux-2.6/include/asm-x86_64/topology.h	2005-02-24 17:43:37.733579601 +1100
@@ -49,7 +49,11 @@
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
 	.cache_hot_time		= (10*1000000),		\
-	.cache_nice_tries	= 1,			\
+	.cache_nice_tries	= 2,			\
+	.busy_idx		= 3,			\
+	.idle_idx		= 2,			\
+	.newidle_idx		= 1, 			\
+	.wake_idx		= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-02-24 17:31:28.428610071 +1100
+++ linux-2.6/include/linux/sched.h	2005-02-24 17:43:37.503607973 +1100
@@ -451,6 +451,10 @@
 	unsigned long long cache_hot_time; /* Task considered cache hot (ns) */
 	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
 	unsigned int per_cpu_gain;	/* CPU % gained by adding domain cpus */
+	unsigned int busy_idx;
+	unsigned int idle_idx;
+	unsigned int newidle_idx;
+	unsigned int wake_idx;
 	int flags;			/* See SD_* */
 
 	/* Runtime fields. */
Index: linux-2.6/include/linux/topology.h
===================================================================
--- linux-2.6.orig/include/linux/topology.h	2005-02-24 17:31:22.665322464 +1100
+++ linux-2.6/include/linux/topology.h	2005-02-24 17:43:37.733579601 +1100
@@ -86,6 +86,10 @@
 	.cache_hot_time		= 0,			\
 	.cache_nice_tries	= 0,			\
 	.per_cpu_gain		= 25,			\
+	.busy_idx		= 0,			\
+	.idle_idx		= 0,			\
+	.newidle_idx		= 0,			\
+	.wake_idx		= 0,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
@@ -112,6 +116,10 @@
 	.cache_hot_time		= (5*1000000/2),	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
+	.busy_idx		= 2,			\
+	.idle_idx		= 0,			\
+	.newidle_idx		= 1,			\
+	.wake_idx		= 1,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:39:06.530045151 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:37.913557397 +1100
@@ -204,7 +204,7 @@
 	 */
 	unsigned long nr_running;
 #ifdef CONFIG_SMP
-	unsigned long cpu_load;
+	unsigned long cpu_load[3];
 #endif
 	unsigned long long nr_switches;
 
@@ -884,23 +884,27 @@
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
-static inline unsigned long source_load(int cpu)
+static inline unsigned long source_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+	if (type == 0)
+		return load_now;
 
-	return min(rq->cpu_load, load_now);
+	return min(rq->cpu_load[type-1], load_now);
 }
 
 /*
  * Return a high guess at the load of a migration-target cpu
  */
-static inline unsigned long target_load(int cpu)
+static inline unsigned long target_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+	if (type == 0)
+		return load_now;
 
-	return max(rq->cpu_load, load_now);
+	return max(rq->cpu_load[type-1], load_now);
 }
 
 #endif
@@ -965,7 +969,7 @@
 	runqueue_t *rq;
 #ifdef CONFIG_SMP
 	unsigned long load, this_load;
-	struct sched_domain *sd;
+	struct sched_domain *sd, *this_sd = NULL;
 	int new_cpu;
 #endif
 
@@ -984,72 +988,64 @@
 	if (unlikely(task_running(rq, p)))
 		goto out_activate;
 
-#ifdef CONFIG_SCHEDSTATS
+	new_cpu = cpu;
+
 	schedstat_inc(rq, ttwu_cnt);
 	if (cpu == this_cpu) {
 		schedstat_inc(rq, ttwu_local);
-	} else {
-		for_each_domain(this_cpu, sd) {
-			if (cpu_isset(cpu, sd->span)) {
-				schedstat_inc(sd, ttwu_wake_remote);
-				break;
-			}
+		goto out_set_cpu;
+	}
+
+	for_each_domain(this_cpu, sd) {
+		if (cpu_isset(cpu, sd->span)) {
+			schedstat_inc(sd, ttwu_wake_remote);
+			this_sd = sd;
+			break;
 		}
 	}
-#endif
 
-	new_cpu = cpu;
-	if (cpu == this_cpu || unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
+	if (unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
 		goto out_set_cpu;
 
-	load = source_load(cpu);
-	this_load = target_load(this_cpu);
-
 	/*
-	 * If sync wakeup then subtract the (maximum possible) effect of
-	 * the currently running task from the load of the current CPU:
+	 * Check for affine wakeup and passive balancing possibilities.
 	 */
-	if (sync)
-		this_load -= SCHED_LOAD_SCALE;
-
-	/* Don't pull the task off an idle CPU to a busy one */
-	if (load < SCHED_LOAD_SCALE/2 && this_load > SCHED_LOAD_SCALE/2)
-		goto out_set_cpu;
+	if (this_sd) {
+		int idx = this_sd->wake_idx;
+		unsigned int imbalance;
 
-	new_cpu = this_cpu; /* Wake to this CPU if we can */
+		load = source_load(cpu, idx);
+		this_load = target_load(this_cpu, idx);
 
-	/*
-	 * Scan domains for affine wakeup and passive balancing
-	 * possibilities.
-	 */
-	for_each_domain(this_cpu, sd) {
-		unsigned int imbalance;
 		/*
-		 * Start passive balancing when half the imbalance_pct
-		 * limit is reached.
+		 * If sync wakeup then subtract the (maximum possible) effect of
+		 * the currently running task from the load of the current CPU:
 		 */
-		imbalance = sd->imbalance_pct + (sd->imbalance_pct - 100) / 2;
+		if (sync)
+			this_load -= SCHED_LOAD_SCALE;
 
-		if ((sd->flags & SD_WAKE_AFFINE) &&
-				!task_hot(p, rq->timestamp_last_tick, sd)) {
+		 /* Don't pull the task off an idle CPU to a busy one */
+		if (load < SCHED_LOAD_SCALE/2 && this_load > SCHED_LOAD_SCALE/2)
+			goto out_set_cpu;
+
+		new_cpu = this_cpu; /* Wake to this CPU if we can */
+
+		if ((this_sd->flags & SD_WAKE_AFFINE) &&
+			!task_hot(p, rq->timestamp_last_tick, this_sd)) {
 			/*
 			 * This domain has SD_WAKE_AFFINE and p is cache cold
 			 * in this domain.
 			 */
-			if (cpu_isset(cpu, sd->span)) {
-				schedstat_inc(sd, ttwu_move_affine);
-				goto out_set_cpu;
-			}
-		} else if ((sd->flags & SD_WAKE_BALANCE) &&
+			schedstat_inc(this_sd, ttwu_move_affine);
+			goto out_set_cpu;
+		} else if ((this_sd->flags & SD_WAKE_BALANCE) &&
 				imbalance*this_load <= 100*load) {
 			/*
 			 * This domain has SD_WAKE_BALANCE and there is
 			 * an imbalance.
 			 */
-			if (cpu_isset(cpu, sd->span)) {
-				schedstat_inc(sd, ttwu_move_balance);
-				goto out_set_cpu;
-			}
+			schedstat_inc(this_sd, ttwu_move_balance);
+			goto out_set_cpu;
 		}
 	}
 
@@ -1507,7 +1503,7 @@
 	cpus_and(mask, sd->span, p->cpus_allowed);
 
 	for_each_cpu_mask(i, mask) {
-		load = target_load(i);
+		load = target_load(i, sd->wake_idx);
 
 		if (load < min_load) {
 			min_cpu = i;
@@ -1520,7 +1516,7 @@
 	}
 
 	/* add +1 to account for the new task */
-	this_load = source_load(this_cpu) + SCHED_LOAD_SCALE;
+	this_load = source_load(this_cpu, sd->wake_idx) + SCHED_LOAD_SCALE;
 
 	/*
 	 * Would with the addition of the new task to the
@@ -1765,8 +1761,15 @@
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
+	int load_idx;
 
 	max_load = this_load = total_load = total_pwr = 0;
+	if (idle == NOT_IDLE)
+		load_idx = sd->busy_idx;
+	else if (idle == NEWLY_IDLE)
+		load_idx = sd->newidle_idx;
+	else
+		load_idx = sd->idle_idx;
 
 	do {
 		unsigned long load;
@@ -1781,9 +1784,9 @@
 		for_each_cpu_mask(i, group->cpumask) {
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
-				load = target_load(i);
+				load = target_load(i, load_idx);
 			else
-				load = source_load(i);
+				load = source_load(i, load_idx);
 
 			avg_load += load;
 		}
@@ -1893,7 +1896,7 @@
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = source_load(i);
+		load = source_load(i, 0);
 
 		if (load > max_load) {
 			max_load = load;
@@ -2165,18 +2168,23 @@
 	unsigned long old_load, this_load;
 	unsigned long j = jiffies + CPU_OFFSET(this_cpu);
 	struct sched_domain *sd;
+	int i;
 
-	/* Update our load */
-	old_load = this_rq->cpu_load;
 	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
-	/*
-	 * Round up the averaging division if load is increasing. This
-	 * prevents us from getting stuck on 9 if the load is 10, for
-	 * example.
-	 */
-	if (this_load > old_load)
-		old_load++;
-	this_rq->cpu_load = (old_load + this_load) / 2;
+	/* Update our load */
+	for (i = 0; i < 3; i++) {
+		unsigned long new_load = this_load;
+		int scale = 1 << i;
+		old_load = this_rq->cpu_load[i];
+		/*
+		 * Round up the averaging division if load is increasing. This
+		 * prevents us from getting stuck on 9 if the load is 10, for
+		 * example.
+		 */
+		if (new_load > old_load)
+			new_load += scale-1;
+		this_rq->cpu_load[i] = (old_load*(scale-1) + new_load) / scale;
+	}
 
 	for_each_domain(this_cpu, sd) {
 		unsigned long interval;
@@ -4958,13 +4966,15 @@
 
 		rq = cpu_rq(i);
 		spin_lock_init(&rq->lock);
+		rq->nr_running = 0;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		rq->best_expired_prio = MAX_PRIO;
 
 #ifdef CONFIG_SMP
 		rq->sd = &sched_domain_dummy;
-		rq->cpu_load = 0;
+		for (j = 1; j < 3; j++)
+			rq->cpu_load[j] = 0;
 		rq->active_balance = 0;
 		rq->push_cpu = 0;
 		rq->migration_thread = NULL;

--=-o9taG/8gqzOyZjLWe8Y4--

http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
