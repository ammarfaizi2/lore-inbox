Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269283AbUJGAxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269283AbUJGAxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269314AbUJGAxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:53:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45705 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269283AbUJGAwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:52:15 -0400
Subject: [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097110266.4907.187.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 06 Oct 2004 17:51:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code is in no way complete.  But since I brought it up in the
"cpusets - big numa cpu and memory placement" thread, I figure the code
needs to be posted.

The basic idea is as follows:

1) Rip out sched_groups and move them into the sched_domains.
2) Add some reference counting, and eventually locking, to
sched_domains.
3) Rewrite & simplify the way sched_domains are built and linked into a
cohesive tree.

This should allow us to support hotplug more easily, simply removing the
domain belonging to the going-away CPU, rather than throwing away the
whole domain tree and rebuilding from scratch.  This should also allow
us to support multiple, independent (ie: no shared root) domain trees
which will facilitate isolated CPU groups and exclusive domains.  I also
hope this will allow us to leverage the existing topology infrastructure
to build domains that closely resemble the physical structure of the
machine automagically, thus making supporting interesting NUMA machines
and SMT machines easier.

This patch is just a snapshot in the middle of development, so there are
certainly some uglies & bugs that will get fixed.  That said, any
comments about the general design are strongly encouraged.  Heck, any
feedback at all is welcome! :) 

Patch against 2.6.9-rc3-mm2.

[mcd@arrakis mcd]$ diffstat ~/linux/patches/sched_domains/mcd-sched_domains-changes.patch
 include/asm-i386/topology.h   |    5
 include/asm-ia64/topology.h   |    5
 include/asm-ppc64/topology.h  |    5
 include/asm-x86_64/topology.h |    5
 include/linux/sched.h         |   21 -
 include/linux/topology.h      |   10
 kernel/sched.c                |  710 +++++++++++++++++++-----------------------
 7 files changed, 360 insertions(+), 401 deletions(-)

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-i386/topology.h linux-2.6.9-rc3-mm2+mcd_sd/include/asm-i386/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-i386/topology.h	2004-10-04 14:38:56.000000000 -0700
+++ linux-2.6.9-rc3-mm2+mcd_sd/include/asm-i386/topology.h	2004-10-05 16:34:35.000000000 -0700
@@ -74,9 +74,10 @@ static inline cpumask_t pcibus_to_cpumas
 
 /* sched_domains SD_NODE_INIT for NUMAQ machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
-	.groups			= NULL,			\
+	.span			= CPU_MASK_NONE,	\
+	.refcnt			= ATOMIC_INIT(0),	\
+	.cpu_power		= 0,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-ia64/topology.h linux-2.6.9-rc3-mm2+mcd_sd/include/asm-ia64/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-ia64/topology.h	2004-10-04 14:38:56.000000000 -0700
+++ linux-2.6.9-rc3-mm2+mcd_sd/include/asm-ia64/topology.h	2004-10-05 16:36:57.000000000 -0700
@@ -47,9 +47,10 @@ void build_cpu_to_node_map(void);
 
 /* sched_domains SD_NODE_INIT for IA64 NUMA machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
-	.groups			= NULL,			\
+	.span			= CPU_MASK_NONE,	\
+	.refcnt			= ATOMIC_INIT(0),	\
+	.cpu_power		= 0,			\
 	.min_interval		= 80,			\
 	.max_interval		= 320,			\
 	.busy_factor		= 320,			\
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-ppc64/topology.h linux-2.6.9-rc3-mm2+mcd_sd/include/asm-ppc64/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-ppc64/topology.h	2004-10-04 14:38:56.000000000 -0700
+++ linux-2.6.9-rc3-mm2+mcd_sd/include/asm-ppc64/topology.h	2004-10-05 16:35:55.000000000 -0700
@@ -42,9 +42,10 @@ static inline int node_to_first_cpu(int 
 
 /* sched_domains SD_NODE_INIT for PPC64 machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
-	.groups			= NULL,			\
+	.span			= CPU_MASK_NONE,	\
+	.refcnt			= ATOMIC_INIT(0),	\
+	.cpu_power		= 0,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-x86_64/topology.h linux-2.6.9-rc3-mm2+mcd_sd/include/asm-x86_64/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-x86_64/topology.h	2004-10-04 14:38:57.000000000 -0700
+++ linux-2.6.9-rc3-mm2+mcd_sd/include/asm-x86_64/topology.h	2004-10-05 16:35:48.000000000 -0700
@@ -37,9 +37,10 @@ static inline cpumask_t __pcibus_to_cpum
 #ifdef CONFIG_NUMA
 /* sched_domains SD_NODE_INIT for x86_64 machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
-	.groups			= NULL,			\
+	.span			= CPU_MASK_NONE,	\
+	.refcnt			= ATOMIC_INIT(0),	\
+	.cpu_power		= 0,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/linux/sched.h linux-2.6.9-rc3-mm2+mcd_sd/include/linux/sched.h
--- linux-2.6.9-rc3-mm2/include/linux/sched.h	2004-10-04 14:38:59.000000000 -0700
+++ linux-2.6.9-rc3-mm2+mcd_sd/include/linux/sched.h	2004-10-05 16:33:08.000000000 -0700
@@ -414,22 +414,17 @@ enum idle_type
 #define SD_WAKE_BALANCE		32	/* Perform balancing at task wakeup */
 #define SD_SHARE_CPUPOWER	64	/* Domain members share cpu power */
 
-struct sched_group {
-	struct sched_group *next;	/* Must be a circular list */
-	cpumask_t cpumask;
-
-	/*
-	 * CPU power of this group, SCHED_LOAD_SCALE being max power for a
-	 * single CPU. This is read only (except for setup, hotplug CPU).
-	 */
-	unsigned long cpu_power;
-};
-
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain *parent;	/* top domain must be null terminated */
-	struct sched_group *groups;	/* the balancing groups of the domain */
+	struct list_head children;	/* link to this domain's children */
+	struct list_head peers;		/* peer balancing domains of this domain */
 	cpumask_t span;			/* span of all CPUs in this domain */
+	atomic_t refcnt;		/* number of references to this domain */
+	unsigned long cpu_power;	/* CPU power of this domain, 
+					 * SCHED_LOAD_SCALE being max power for 
+					 * a single CPU. This is read only (except 
+					 * for setup, hotplug CPU). */
 	unsigned long min_interval;	/* Minimum balance interval ms */
 	unsigned long max_interval;	/* Maximum balance interval ms */
 	unsigned int busy_factor;	/* less balancing by factor if busy */
@@ -465,8 +460,6 @@ struct sched_domain {
 #ifdef ARCH_HAS_SCHED_DOMAIN
 /* Useful helpers that arch setup code may use. Defined in kernel/sched.c */
 extern cpumask_t cpu_isolated_map;
-extern void init_sched_build_groups(struct sched_group groups[],
-	                        cpumask_t span, int (*group_fn)(int cpu));
 extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 #endif /* CONFIG_SMP */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/linux/topology.h linux-2.6.9-rc3-mm2+mcd_sd/include/linux/topology.h
--- linux-2.6.9-rc3-mm2/include/linux/topology.h	2004-10-04 14:38:59.000000000 -0700
+++ linux-2.6.9-rc3-mm2+mcd_sd/include/linux/topology.h	2004-10-05 16:34:07.000000000 -0700
@@ -80,9 +80,10 @@ static inline int __next_node_with_cpus(
 /* Common values for SMT siblings */
 #ifndef SD_SIBLING_INIT
 #define SD_SIBLING_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
-	.groups			= NULL,			\
+	.span			= CPU_MASK_NONE,	\
+	.refcnt			= ATOMIC_INIT(0),	\
+	.cpu_power		= 0,			\
 	.min_interval		= 1,			\
 	.max_interval		= 2,			\
 	.busy_factor		= 8,			\
@@ -106,9 +107,10 @@ static inline int __next_node_with_cpus(
 /* Common values for CPUs */
 #ifndef SD_CPU_INIT
 #define SD_CPU_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
-	.groups			= NULL,			\
+	.span			= CPU_MASK_NONE,	\
+	.refcnt			= ATOMIC_INIT(0),	\
+	.cpu_power		= 0,			\
 	.min_interval		= 1,			\
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/kernel/sched.c linux-2.6.9-rc3-mm2+mcd_sd/kernel/sched.c
--- linux-2.6.9-rc3-mm2/kernel/sched.c	2004-10-04 14:39:00.000000000 -0700
+++ linux-2.6.9-rc3-mm2+mcd_sd/kernel/sched.c	2004-10-05 17:19:17.000000000 -0700
@@ -2209,32 +2209,35 @@ out:
 }
 
 /*
- * find_busiest_group finds and returns the busiest CPU group within the
+ * find_busiest_child finds and returns the busiest child domain of the given
  * domain. It calculates and returns the number of tasks which should be
  * moved to restore balance via the imbalance parameter.
  */
-static struct sched_group *
-find_busiest_group(struct sched_domain *sd, int this_cpu,
+static struct sched_domain *
+find_busiest_child(struct sched_domain *sd, int cpu,
 		   unsigned long *imbalance, enum idle_type idle)
 {
-	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
-	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
+	struct sched_domain *busiest_domain, *local_domain, *domain;
+	unsigned long max_load, avg_load, total_load, local_load, total_pwr;
 
-	max_load = this_load = total_load = total_pwr = 0;
-
-	do {
+	max_load = local_load = total_load = total_pwr = 0;
+	busiest_domain = local_domain = NULL;
+	list_for_each_entry(domain, &sd->children, peers) {
 		unsigned long load;
-		int local_group;
 		int i, nr_cpus = 0;
 
-		local_group = cpu_isset(this_cpu, group->cpumask);
+		if (unlikely(cpus_empty(domain->span)))
+		    continue;
+
+		if (cpu_isset(cpu, domain->span))
+			local_domain = domain;
 
-		/* Tally up the load of all CPUs in the group */
+		/* Tally up the load of all CPUs in the domain */
 		avg_load = 0;
 
-		for_each_cpu_mask(i, group->cpumask) {
+		for_each_cpu_mask(i, domain->span) {
 			/* Bias balancing toward cpus of our domain */
-			if (local_group)
+			if (domain == local_domain)
 				load = target_load(i);
 			else
 				load = source_load(i);
@@ -2243,34 +2246,27 @@ find_busiest_group(struct sched_domain *
 			avg_load += load;
 		}
 
-		if (!nr_cpus)
-			goto nextgroup;
-
 		total_load += avg_load;
-		total_pwr += group->cpu_power;
+		total_pwr += domain->cpu_power;
 
-		/* Adjust by relative CPU power of the group */
-		avg_load = (avg_load * SCHED_LOAD_SCALE) / group->cpu_power;
+		/* Adjust by relative CPU power of the domain */
+		avg_load = (avg_load * SCHED_LOAD_SCALE) / domain->cpu_power;
 
-		if (local_group) {
-			this_load = avg_load;
-			this = group;
-			goto nextgroup;
+		if (domain == local_domain) {
+			local_load = avg_load;
 		} else if (avg_load > max_load) {
 			max_load = avg_load;
-			busiest = group;
+			busiest_domain = domain;
 		}
-nextgroup:
-		group = group->next;
-	} while (group != sd->groups);
+	}
 
-	if (!busiest || this_load >= max_load)
+	if (!busiest_domain || local_load >= max_load)
 		goto out_balanced;
 
 	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
 
-	if (this_load >= avg_load ||
-			100*max_load <= sd->imbalance_pct*this_load)
+	if (local_load >= avg_load ||
+			100*max_load <= sd->imbalance_pct*local_load)
 		goto out_balanced;
 
 	/*
@@ -2284,19 +2280,19 @@ nextgroup:
 	 * by pulling tasks to us.  Be careful of negative numbers as they'll
 	 * appear as very large values with unsigned longs.
 	 */
-	*imbalance = min(max_load - avg_load, avg_load - this_load);
+	*imbalance = min(max_load - avg_load, avg_load - local_load);
 
 	/* How much load to actually move to equalise the imbalance */
-	*imbalance = (*imbalance * min(busiest->cpu_power, this->cpu_power))
+	*imbalance = (*imbalance * min(busiest_domain->cpu_power, local_domain->cpu_power))
 				/ SCHED_LOAD_SCALE;
 
 	if (*imbalance < SCHED_LOAD_SCALE - 1) {
 		unsigned long pwr_now = 0, pwr_move = 0;
 		unsigned long tmp;
 
-		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
+		if (max_load - local_load >= SCHED_LOAD_SCALE*2) {
 			*imbalance = 1;
-			return busiest;
+			return busiest_domain;
 		}
 
 		/*
@@ -2305,21 +2301,21 @@ nextgroup:
 		 * moving them.
 		 */
 
-		pwr_now += busiest->cpu_power*min(SCHED_LOAD_SCALE, max_load);
-		pwr_now += this->cpu_power*min(SCHED_LOAD_SCALE, this_load);
+		pwr_now += busiest_domain->cpu_power*min(SCHED_LOAD_SCALE, max_load);
+		pwr_now += local_domain->cpu_power*min(SCHED_LOAD_SCALE, local_load);
 		pwr_now /= SCHED_LOAD_SCALE;
 
 		/* Amount of load we'd subtract */
-		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/busiest->cpu_power;
+		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/busiest_domain->cpu_power;
 		if (max_load > tmp)
-			pwr_move += busiest->cpu_power*min(SCHED_LOAD_SCALE,
+			pwr_move += busiest_domain->cpu_power*min(SCHED_LOAD_SCALE,
 							max_load - tmp);
 
 		/* Amount of load we'd add */
-		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/this->cpu_power;
+		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/local_domain->cpu_power;
 		if (max_load < tmp)
 			tmp = max_load;
-		pwr_move += this->cpu_power*min(SCHED_LOAD_SCALE, this_load + tmp);
+		pwr_move += local_domain->cpu_power*min(SCHED_LOAD_SCALE, local_load + tmp);
 		pwr_move /= SCHED_LOAD_SCALE;
 
 		/* Move if we gain another 8th of a CPU worth of throughput */
@@ -2327,19 +2323,19 @@ nextgroup:
 			goto out_balanced;
 
 		*imbalance = 1;
-		return busiest;
+		return busiest_domain;
 	}
 
 	/* Get rid of the scaling factor, rounding down as we divide */
 	*imbalance = (*imbalance + 1) / SCHED_LOAD_SCALE;
 
-	return busiest;
+	return busiest_domain;
 
 out_balanced:
-	if (busiest && (idle == NEWLY_IDLE ||
+	if (busiest_domain && (idle == NEWLY_IDLE ||
 			(idle == SCHED_IDLE && max_load > SCHED_LOAD_SCALE)) ) {
 		*imbalance = 1;
-		return busiest;
+		return busiest_domain;
 	}
 
 	*imbalance = 0;
@@ -2347,15 +2343,15 @@ out_balanced:
 }
 
 /*
- * find_busiest_queue - find the busiest runqueue among the cpus in group.
+ * find_busiest_queue - find the busiest runqueue among the cpus in @domain
  */
-static runqueue_t *find_busiest_queue(const struct sched_group *group)
+static runqueue_t *find_busiest_queue(const struct sched_domain *domain)
 {
 	unsigned long load, max_load = 0;
 	runqueue_t *busiest = NULL;
 	int i;
 
-	for_each_cpu_mask(i, group->cpumask) {
+	for_each_cpu_mask(i, domain->span) {
 		load = source_load(i);
 
 		if (load > max_load) {
@@ -2368,30 +2364,30 @@ static runqueue_t *find_busiest_queue(co
 }
 
 /*
- * Check this_cpu to ensure it is balanced within domain. Attempt to move
+ * Check @cpu to ensure it is balanced within @sd. Attempt to move
  * tasks if there is an imbalance.
  *
- * Called with this_rq unlocked.
+ * Called with @rq unlocked.
  */
-static int load_balance(int this_cpu, runqueue_t *this_rq,
-			struct sched_domain *sd, enum idle_type idle)
+static int load_balance(int cpu, runqueue_t *rq, struct sched_domain *sd, 
+			enum idle_type idle)
 {
-	struct sched_group *group;
-	runqueue_t *busiest;
+	struct sched_domain *domain;
+	runqueue_t *busiest_rq;
 	unsigned long imbalance;
 	int nr_moved;
 
-	spin_lock(&this_rq->lock);
+	spin_lock(&rq->lock);
 	schedstat_inc(sd, lb_cnt[idle]);
 
-	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
-	if (!group) {
+	domain = find_busiest_child(sd, cpu, &imbalance, idle);
+	if (!domain) {
 		schedstat_inc(sd, lb_nobusyg[idle]);
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group);
-	if (!busiest) {
+	busiest_rq = find_busiest_queue(domain);
+	if (!busiest_rq) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
 	}
@@ -2401,7 +2397,7 @@ static int load_balance(int this_cpu, ru
 	 * balancing is inherently racy and statistical,
 	 * it could happen in theory.
 	 */
-	if (unlikely(busiest == this_rq)) {
+	if (unlikely(busiest_rq == rq)) {
 		WARN_ON(1);
 		goto out_balanced;
 	}
@@ -2409,19 +2405,18 @@ static int load_balance(int this_cpu, ru
 	schedstat_add(sd, lb_imbalance[idle], imbalance);
 
 	nr_moved = 0;
-	if (busiest->nr_running > 1) {
+	if (busiest_rq->nr_running > 1) {
 		/*
-		 * Attempt to move tasks. If find_busiest_group has found
-		 * an imbalance but busiest->nr_running <= 1, the group is
+		 * Attempt to move tasks. If find_busiest_child has found
+		 * an imbalance but busiest_rq->nr_running <= 1, the domain is
 		 * still unbalanced. nr_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		double_lock_balance(this_rq, busiest);
-		nr_moved = move_tasks(this_rq, this_cpu, busiest,
-						imbalance, sd, idle);
-		spin_unlock(&busiest->lock);
+		double_lock_balance(rq, busiest_rq);
+		nr_moved = move_tasks(rq, cpu, busiest_rq, imbalance, sd, idle);
+		spin_unlock(&busiest_rq->lock);
 	}
-	spin_unlock(&this_rq->lock);
+	spin_unlock(&rq->lock);
 
 	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[idle]);
@@ -2430,15 +2425,15 @@ static int load_balance(int this_cpu, ru
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
 			int wake = 0;
 
-			spin_lock(&busiest->lock);
-			if (!busiest->active_balance) {
-				busiest->active_balance = 1;
-				busiest->push_cpu = this_cpu;
+			spin_lock(&busiest_rq->lock);
+			if (!busiest_rq->active_balance) {
+				busiest_rq->active_balance = 1;
+				busiest_rq->push_cpu = cpu;
 				wake = 1;
 			}
-			spin_unlock(&busiest->lock);
+			spin_unlock(&busiest_rq->lock);
 			if (wake)
-				wake_up_process(busiest->migration_thread);
+				wake_up_process(busiest_rq->migration_thread);
 
 			/*
 			 * We've kicked active balancing, reset the failure
@@ -2455,7 +2450,7 @@ static int load_balance(int this_cpu, ru
 	return nr_moved;
 
 out_balanced:
-	spin_unlock(&this_rq->lock);
+	spin_unlock(&rq->lock);
 
 	/* tune up the balancing interval */
 	if (sd->balance_interval < sd->max_interval)
@@ -2465,59 +2460,57 @@ out_balanced:
 }
 
 /*
- * Check this_cpu to ensure it is balanced within domain. Attempt to move
+ * Check @cpu to ensure it is balanced within @sd. Attempt to move
  * tasks if there is an imbalance.
  *
- * Called from schedule when this_rq is about to become idle (NEWLY_IDLE).
- * this_rq is locked.
+ * Called from schedule() when @rq is about to become idle (NEWLY_IDLE).
+ * @rq is locked.
  */
-static int load_balance_newidle(int this_cpu, runqueue_t *this_rq,
-				struct sched_domain *sd)
+static int load_balance_newidle(int cpu, runqueue_t *rq, struct sched_domain *sd)
 {
-	struct sched_group *group;
-	runqueue_t *busiest = NULL;
+	struct sched_domain *domain;
+	runqueue_t *busiest_rq = NULL;
 	unsigned long imbalance;
 	int nr_moved = 0;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
-	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
-	if (!group) {
+	domain = find_busiest_child(sd, cpu, &imbalance, NEWLY_IDLE);
+	if (!domain) {
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out;
 	}
 
-	busiest = find_busiest_queue(group);
-	if (!busiest || busiest == this_rq) {
+	busiest_rq = find_busiest_queue(domain);
+	if (!busiest_rq || busiest_rq == rq) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out;
 	}
 
 	/* Attempt to move tasks */
-	double_lock_balance(this_rq, busiest);
+	double_lock_balance(rq, busiest_rq);
 
 	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
-	nr_moved = move_tasks(this_rq, this_cpu, busiest,
-					imbalance, sd, NEWLY_IDLE);
+	nr_moved = move_tasks(rq, cpu, busiest_rq, imbalance, sd, NEWLY_IDLE);
 	if (!nr_moved)
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
 
-	spin_unlock(&busiest->lock);
+	spin_unlock(&busiest_rq->lock);
 
 out:
 	return nr_moved;
 }
 
 /*
- * idle_balance is called by schedule() if this_cpu is about to become
+ * idle_balance is called by schedule() if @cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  */
-static inline void idle_balance(int this_cpu, runqueue_t *this_rq)
+static inline void idle_balance(int cpu, runqueue_t *rq)
 {
 	struct sched_domain *sd;
 
-	for_each_domain(this_cpu, sd) {
+	for_each_domain(cpu, sd) {
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
-			if (load_balance_newidle(this_cpu, this_rq, sd)) {
+			if (load_balance_newidle(cpu, rq, sd)) {
 				/* We've pulled tasks over so stop searching */
 				break;
 			}
@@ -2531,40 +2524,37 @@ static inline void idle_balance(int this
  * running on each physical CPU where possible, and not have a physical /
  * logical imbalance.
  *
- * Called with busiest locked.
+ * Called with busiest_rq locked.
  */
-static void active_load_balance(runqueue_t *busiest, int busiest_cpu)
+static void active_load_balance(runqueue_t *busiest_rq, int busiest_cpu)
 {
-	struct sched_domain *sd;
-	struct sched_group *group, *busy_group;
+	struct sched_domain *balance_domain, *domain, *busiest_domain;
 	int i;
 
-	schedstat_inc(busiest, alb_cnt);
-	if (busiest->nr_running <= 1)
+	schedstat_inc(busiest_rq, alb_cnt);
+	if (busiest_rq->nr_running <= 1)
 		return;
 
-	for_each_domain(busiest_cpu, sd)
-		if (cpu_isset(busiest->push_cpu, sd->span))
+	for_each_domain(busiest_cpu, balance_domain)
+		if (cpu_isset(busiest_rq->push_cpu, balance_domain->span))
 			break;
-	if (!sd)
+	if (!balance_domain)
 		return;
 
-	group = sd->groups;
-	while (!cpu_isset(busiest_cpu, group->cpumask))
-		group = group->next;
-	busy_group = group;
-
-	group = sd->groups;
-	do {
+	list_for_each_entry(busiest_domain, &balance_domain->children, peers) {
+		if (cpu_isset(busiest_cpu, busiest_domain->span))
+		    break;
+	}
+	list_for_each_entry(domain, &balance_domain->children, peers) {
 		runqueue_t *rq;
 		int push_cpu = 0;
 
-		if (group == busy_group)
-			goto next_group;
+		if (domain == busiest_domain)
+			continue;
 
-		for_each_cpu_mask(i, group->cpumask) {
+		for_each_cpu_mask(i, domain->span) {
 			if (!idle_cpu(i))
-				goto next_group;
+				continue;
 			push_cpu = i;
 		}
 
@@ -2576,19 +2566,17 @@ static void active_load_balance(runqueue
 		 * it can trigger.. Reported by Bjorn Helgaas on a
 		 * 128-cpu setup.
 		 */
-		if (unlikely(busiest == rq))
-			goto next_group;
-		double_lock_balance(busiest, rq);
-		if (move_tasks(rq, push_cpu, busiest, 1, sd, SCHED_IDLE)) {
-			schedstat_inc(busiest, alb_lost);
+		if (unlikely(busiest_rq == rq))
+			continue;
+		double_lock_balance(busiest_rq, rq);
+		if (move_tasks(rq, push_cpu, busiest_rq, 1, balance_domain, SCHED_IDLE)) {
+			schedstat_inc(busiest_rq, alb_lost);
 			schedstat_inc(rq, alb_gained);
 		} else {
-			schedstat_inc(busiest, alb_failed);
+			schedstat_inc(busiest_rq, alb_failed);
 		}
 		spin_unlock(&rq->lock);
-next_group:
-		group = group->next;
-	} while (group != sd->groups);
+	}
 }
 
 /*
@@ -5024,7 +5012,7 @@ static int migration_call(struct notifie
 		}
 		spin_unlock_irq(&rq->lock);
 		break;
-#endif
+#endif /* CONFIG_HOTPLUG_CPU */
 	}
 	return NOTIFY_OK;
 }
@@ -5049,37 +5037,6 @@ int __init migration_init(void)
 #endif
 
 #ifdef CONFIG_SMP
-/*
- * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
- * hold the hotplug lock.
- */
-void __devinit cpu_attach_domain(struct sched_domain *sd, int cpu)
-{
-	migration_req_t req;
-	unsigned long flags;
-	runqueue_t *rq = cpu_rq(cpu);
-	int local = 1;
-
-	spin_lock_irqsave(&rq->lock, flags);
-
-	if (cpu == smp_processor_id() || !cpu_online(cpu)) {
-		rq->sd = sd;
-	} else {
-		init_completion(&req.done);
-		req.type = REQ_SET_DOMAIN;
-		req.sd = sd;
-		list_add(&req.list, &rq->migration_queue);
-		local = 0;
-	}
-
-	spin_unlock_irqrestore(&rq->lock, flags);
-
-	if (!local) {
-		wake_up_process(rq->migration_thread);
-		wait_for_completion(&req.done);
-	}
-}
-
 /* cpus with isolated domains */
 cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
 
@@ -5094,245 +5051,257 @@ static int __init isolated_cpu_setup(cha
 		cpu_set(ints[i], cpu_isolated_map);
 	return 1;
 }
+__setup("isolcpus=", isolated_cpu_setup);
 
-__setup ("isolcpus=", isolated_cpu_setup);
 
 /*
- * init_sched_build_groups takes an array of groups, the cpumask we wish
- * to span, and a pointer to a function which identifies what group a CPU
- * belongs to. The return value of group_fn must be a valid index into the
- * groups[] array, and must be >= 0 and < NR_CPUS (due to the fact that we
- * keep track of groups covered with a cpumask_t).
- *
- * init_sched_build_groups will build a circular linked list of the groups
- * covered by the given span, and will set each group's ->cpumask correctly,
- * and ->cpu_power to 0.
+ * Calculate and set the cpu_power field of sched_domain @sd
  */
-void __devinit init_sched_build_groups(struct sched_group groups[],
-			cpumask_t span, int (*group_fn)(int cpu))
+static void __devinit set_cpu_power(struct sched_domain *sd)
 {
-	struct sched_group *first = NULL, *last = NULL;
-	cpumask_t covered = CPU_MASK_NONE;
-	int i;
-
-	for_each_cpu_mask(i, span) {
-		int group = group_fn(i);
-		struct sched_group *sg = &groups[group];
-		int j;
-
-		if (cpu_isset(i, covered))
-			continue;
-
-		sg->cpumask = CPU_MASK_NONE;
-		sg->cpu_power = 0;
-
-		for_each_cpu_mask(j, span) {
-			if (group_fn(j) != group)
-				continue;
-
-			cpu_set(j, covered);
-			cpu_set(j, sg->cpumask);
-		}
-		if (!first)
-			first = sg;
-		if (last)
-			last->next = sg;
-		last = sg;
+	if (list_empty(&sd->children)) {
+		/* Leaf domain.  Power = 1 + ((#cpus-1) * per_cpu_gain) */
+		sd->cpu_power = 1 + 
+			((cpus_weight(sd->span) - 1) * sd->per_cpu_gain);
+	} else {
+		/* Interior domain.  Power = sum of childrens' power. */
+		struct sched_domain *child_domain;
+		sd->cpu_power = 0;
+		list_for_each_entry(child_domain, &sd->children, peers)
+			sd->cpu_power += child_domain->cpu_power;
 	}
-	last->next = first;
 }
 
+/* What type of sched_domain are we creating? */
+enum sd_type {
+	SD_SYSTEM  = 0,
+	SD_NODE    = 1,
+	SD_SIBLING = 2,
+};
 
-#ifdef ARCH_HAS_SCHED_DOMAIN
-extern void __devinit arch_init_sched_domains(void);
-extern void __devinit arch_destroy_sched_domains(void);
+/*
+ * Allocates a sched_domain, initializes it as @type, parents it to @parent,
+ * and links it into the list of its peers (if any).
+ *
+ * All the ugly ifdef'ing in this function is because I didn't want to rename 
+ * an modify the SD_*_INIT functions in this patch.  It makes it bigger and more 
+ * confusing.  Arch-specific initializers are what is necessary to fix this mess, 
+ * but I'm not including that in this patch.  Another reason for this confusion 
+ * is that the domain initializers are named for what the domains are _composed of_
+ * rather than what type of domains they are.  Ex. SD_NODE_INIT is the initializer
+ * for a domain composed of NUMA nodes, rather than a domain that _is_ a NUMA node.
+ */
+struct sched_domain * __devinit create_domain(struct sched_domain *parent, 
+					      enum sd_type type)
+{
+	struct sched_domain *domain;
+
+	domain = (struct sched_domain *)kmalloc(sizeof(struct sched_domain), GFP_KERNEL);
+	if (!domain) {
+		printk("Couldn't kmalloc sched_domain!\n");
+		return NULL;
+	}
+	switch (type) {
+	case SD_SYSTEM:
+#ifdef CONFIG_NUMA
+/* Initializing system domain for NUMA machine: contains nodes */
+		*domain = SD_NODE_INIT;
 #else
 #ifdef CONFIG_SCHED_SMT
-static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-static struct sched_group sched_group_cpus[NR_CPUS];
-static int __devinit cpu_to_cpu_group(int cpu)
-{
-	return cpu;
-}
+/* Initializing system domain for SMP + SMT machine: contains SMT siblings */
+		*domain = SD_SIBLING_INIT;
+#else
+/* Initializing system domain for Flat SMP machine: contains CPUs */
+		*domain = SD_CPU_INIT;
 #endif
-
-static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-static struct sched_group sched_group_phys[NR_CPUS];
-static int __devinit cpu_to_phys_group(int cpu)
-{
+#endif
+		break;
+#ifdef CONFIG_NUMA
+	case SD_NODE:
 #ifdef CONFIG_SCHED_SMT
-	return first_cpu(cpu_sibling_map[cpu]);
+/* Initializing node domain for NUMA + SMT machine: contains SMT siblings */
+		*domain = SD_SIBLING_INIT;
 #else
-	return cpu;
+/* Initializing node domain for Flat NUMA machine: contains CPUs */
+		*domain = SD_CPU_INIT;
+#endif
+		break;
 #endif
+#ifdef CONFIG_SCHED_SMT
+	case SD_SIBLING:
+/* Initializing sibling domain: contains CPUs */
+		*domain = SD_CPU_INIT;
+		break;
+#endif
+	default:
+		printk("Invalid sd_type!\n");
+		kfree(domain);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&domain->children);
+	INIT_LIST_HEAD(&domain->peers);
+	/* MCD - Need locking here? */
+	if (parent) {
+		domain->parent = parent;
+		atomic_inc(&domain->parent->refcnt);
+		list_add_tail(&domain->peers, &domain->parent->children);
+	}
+	return domain;
 }
 
-#ifdef CONFIG_NUMA
-
-static DEFINE_PER_CPU(struct sched_domain, node_domains);
-static struct sched_group sched_group_nodes[MAX_NUMNODES];
-static int __devinit cpu_to_node_group(int cpu)
+/*
+ * Unlinks and destroys sched_domain @sd
+ */
+void __devinit destroy_domain(struct sched_domain *sd)
 {
-	return cpu_to_node(cpu);
+	if (!sd || !atomic_dec_and_test(&sd->refcnt))
+		return;
+	kfree(sd);
 }
-#endif
 
 /*
- * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
+ * Attach the domain @sd to @cpu as its base domain.
+ * Callers must hold the hotplug lock.
  */
-static void __devinit arch_init_sched_domains(void)
+void __devinit cpu_attach_domain(struct sched_domain *sd, int cpu)
 {
-	int i;
-	cpumask_t cpu_default_map;
-
-	/*
-	 * Setup mask for cpus without special case scheduling requirements.
-	 * For now this just excludes isolated cpus, but could be used to
-	 * exclude other special cases in the future.
-	 */
-	cpus_complement(cpu_default_map, cpu_isolated_map);
-	cpus_and(cpu_default_map, cpu_default_map, cpu_online_map);
-
-	/*
-	 * Set up domains. Isolated domains just stay on the dummy domain.
-	 */
-	for_each_cpu_mask(i, cpu_default_map) {
-		int group;
-		struct sched_domain *sd = NULL, *p;
-		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
+	struct sched_domain *old_sd, *domain;
+	migration_req_t req;
+	unsigned long flags;
+	runqueue_t *rq = cpu_rq(cpu);
+	int local = 1;
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+	/* Add @cpu to domain's span & compute its cpu_power */
+	for (domain = sd; domain; domain = domain->parent) {
+		/* MCD - Should add locking here.  Lock each domain while modifying */
+		if (cpu_isset(cpu, domain->span))
+			continue;
+		cpu_set(cpu, domain->span);
+		set_cpu_power(domain);
+		/* MCD - Unlock here */
+	}
 
-#ifdef CONFIG_NUMA
-		sd = &per_cpu(node_domains, i);
-		group = cpu_to_node_group(i);
-		*sd = SD_NODE_INIT;
-		sd->span = cpu_default_map;
-		sd->groups = &sched_group_nodes[group];
-#endif
+	spin_lock_irqsave(&rq->lock, flags);
 
-		p = sd;
-		sd = &per_cpu(phys_domains, i);
-		group = cpu_to_phys_group(i);
-		*sd = SD_CPU_INIT;
-		sd->span = nodemask;
-		sd->parent = p;
-		sd->groups = &sched_group_phys[group];
+	old_sd = rq->sd;
 
-#ifdef CONFIG_SCHED_SMT
-		p = sd;
-		sd = &per_cpu(cpu_domains, i);
-		group = cpu_to_cpu_group(i);
-		*sd = SD_SIBLING_INIT;
-		sd->span = cpu_sibling_map[i];
-		cpus_and(sd->span, sd->span, cpu_default_map);
-		sd->parent = p;
-		sd->groups = &sched_group_cpus[group];
-#endif
+	if (cpu == smp_processor_id() || !cpu_online(cpu)) {
+		rq->sd = sd;
+	} else {
+		init_completion(&req.done);
+		req.type = REQ_SET_DOMAIN;
+		req.sd = sd;
+		list_add(&req.list, &rq->migration_queue);
+		local = 0;
 	}
 
-#ifdef CONFIG_SCHED_SMT
-	/* Set up CPU (sibling) groups */
-	for_each_online_cpu(i) {
-		cpumask_t this_sibling_map = cpu_sibling_map[i];
-		cpus_and(this_sibling_map, this_sibling_map, cpu_default_map);
-		if (i != first_cpu(this_sibling_map))
-			continue;
+	spin_unlock_irqrestore(&rq->lock, flags);
 
-		init_sched_build_groups(sched_group_cpus, this_sibling_map,
-						&cpu_to_cpu_group);
+	if (!local) {
+		wake_up_process(rq->migration_thread);
+		wait_for_completion(&req.done);
 	}
-#endif
 
-	/* Set up physical groups */
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		cpumask_t nodemask = node_to_cpumask(i);
+	destroy_domain(old_sd);
+}
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
-		if (cpus_empty(nodemask))
-			continue;
+#ifndef ARCH_HAS_SCHED_DOMAIN
+/*
+ * Set up scheduler domains.  Callers must hold the hotplug lock.
+ */
+static void __devinit arch_init_sched_domains(void)
+{
+	struct sched_domain *sys_domain;
+	struct sched_domain *node_domains[MAX_NUMNODES];
+	cpumask_t cpu_usable_map;
+	int i;
 
-		init_sched_build_groups(sched_group_phys, nodemask,
-						&cpu_to_phys_group);
-	}
+	/*
+	 * Setup mask for cpus without special case scheduling requirements.
+	 * For now this just excludes isolated cpus, but could be used to
+	 * exclude other special cases in the future.
+	 */
+	cpus_complement(cpu_usable_map, cpu_isolated_map);
+	cpus_and(cpu_usable_map, cpu_usable_map, cpu_online_map);
 
+	sys_domain = create_domain(NULL, SD_SYSTEM);
+	BUG_ON(!sys_domain);
+
+/* MCD - Replace these #ifdef's with runtime variables? ie: numa_enabled, smt_enabled... */
 #ifdef CONFIG_NUMA
-	/* Set up node groups */
-	init_sched_build_groups(sched_group_nodes, cpu_default_map,
-					&cpu_to_node_group);
-#endif
+	for_each_node(i) {
+		cpumask_t nodemask;
+		nodemask = node_to_cpumask(i);
+		if (!cpus_empty(nodemask))
+			node_domains[i] = create_domain(sys_domain, SD_NODE);
+	}
+#else /* !CONFIG_NUMA */
+	node_domains[0] = sys_domain;
+#endif /* CONFIG_NUMA */
 
-	/* Calculate CPU power for physical packages and nodes */
-	for_each_cpu_mask(i, cpu_default_map) {
-		int power;
-		struct sched_domain *sd;
+	for_each_cpu_mask(i, cpu_usable_map) {
 #ifdef CONFIG_SCHED_SMT
-		sd = &per_cpu(cpu_domains, i);
-		power = SCHED_LOAD_SCALE;
-		sd->groups->cpu_power = power;
-#endif
-
-		sd = &per_cpu(phys_domains, i);
-		power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
-				(cpus_weight(sd->groups->cpumask)-1) / 10;
-		sd->groups->cpu_power = power;
+		struct sched_domain *sibling_domain;
+		cpumask_t sibling_map = cpu_sibling_map[i];
+		int j;
 
-#ifdef CONFIG_NUMA
-		if (i == first_cpu(sd->groups->cpumask)) {
-			/* Only add "power" once for each physical package. */
-			sd = &per_cpu(node_domains, i);
-			sd->groups->cpu_power += power;
-		}
-#endif
-	}
+		cpus_and(sibling_map, sibling_map, cpu_usable_map);
+		if (i != first_cpu(sibling_map))
+			continue;
 
-	/* Attach the domains */
-	for_each_online_cpu(i) {
-		struct sched_domain *sd;
-#ifdef CONFIG_SCHED_SMT
-		sd = &per_cpu(cpu_domains, i);
-#else
-		sd = &per_cpu(phys_domains, i);
-#endif
-		cpu_attach_domain(sd, i);
+		sibling_domain = create_domain(node_domains[cpu_to_node(i)], SD_SIBLING);
+		for_each_cpu_mask(j, sibling_map)
+			cpu_attach_domain(sibling_domain, j);
+#else /* !CONFIG_SCHED_SMT */
+		cpu_attach_domain(node_domains[cpu_to_node(i)], i);
+#endif /* CONFIG_SCHED_SMT */
 	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void __devinit arch_destroy_sched_domains(void)
 {
-	/* Do nothing: everything is statically allocated. */
+	/* MCD - Write this function */
 }
 #endif
 
-#endif /* ARCH_HAS_SCHED_DOMAIN */
+#else /* ARCH_HAS_SCHED_DOMAIN */
+extern void __devinit arch_init_sched_domains(void);
+#ifdef CONFIG_HOTPLUG_CPU
+extern void __devinit arch_destroy_sched_domains(void);
+#endif
+#endif /* !ARCH_HAS_SCHED_DOMAIN */
 
-#undef SCHED_DOMAIN_DEBUG
+#define SCHED_DOMAIN_DEBUG
 #ifdef SCHED_DOMAIN_DEBUG
-static void sched_domain_debug(void)
+#define SD_DEBUG KERN_ALERT
+static void __devinit sched_domain_debug(void)
 {
-	int i;
+	int cpu;
 
-	for_each_online_cpu(i) {
-		runqueue_t *rq = cpu_rq(i);
-		struct sched_domain *sd;
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		runqueue_t *rq = cpu_rq(cpu);
+		struct sched_domain *sd = NULL;
 		int level = 0;
-
-		sd = rq->sd;
-
-		printk(KERN_DEBUG "CPU%d:\n", i);
+		
+		if (rq)
+			sd = rq->sd;
+
+		printk(SD_DEBUG "CPU%d:", cpu);
+		if (!sd) {
+			printk(" not online.\n");
+			continue;
+		}
+		printk("\n");
 
 		do {
-			int j;
-			char str[NR_CPUS];
-			struct sched_group *group = sd->groups;
+			struct sched_domain *child;
 			cpumask_t groupmask;
+			char str[NR_CPUS];
+			int i;
 
-			cpumask_scnprintf(str, NR_CPUS, sd->span);
-			cpus_clear(groupmask);
-
-			printk(KERN_DEBUG);
-			for (j = 0; j < level + 1; j++)
+			printk(SD_DEBUG);
+			for (i = 0; i < level + 1; i++)
 				printk(" ");
 			printk("domain %d: ", level);
 
@@ -5344,71 +5313,62 @@ static void sched_domain_debug(void)
 				break;
 			}
 
-			printk("span %s\n", str);
+			cpumask_scnprintf(str, NR_CPUS, sd->span);
+			printk("span %s, cpu_power %ld\n", str, sd->cpu_power);
 
-			if (!cpu_isset(i, sd->span))
-				printk(KERN_DEBUG "ERROR domain->span does not contain CPU%d\n", i);
-			if (!cpu_isset(i, group->cpumask))
-				printk(KERN_DEBUG "ERROR domain->groups does not contain CPU%d\n", i);
-			if (!group->cpu_power)
-				printk(KERN_DEBUG "ERROR domain->cpu_power not set\n");
+			if (!cpu_isset(cpu, sd->span))
+				printk(SD_DEBUG "ERROR domain->span does not contain CPU%d\n", cpu);
 
-			printk(KERN_DEBUG);
-			for (j = 0; j < level + 2; j++)
+			cpus_clear(groupmask);
+			printk(SD_DEBUG);
+			for (i = 0; i < level + 1; i++)
 				printk(" ");
-			printk("groups:");
-			do {
-				if (!group) {
-					printk(" ERROR: NULL");
-					break;
+			if (list_empty(&sd->children)) {
+				printk("Leaf domain, no children\n");
+			} else {
+				printk("Interior domain, childrens' spans:");
+				list_for_each_entry(child, &sd->children, peers) {
+					if (cpus_empty(child->span))
+						printk(" ERROR child has empty span:");
+
+					if (cpus_intersects(groupmask, child->span))
+						printk(" ERROR repeated CPUs:");
+
+					cpumask_scnprintf(str, NR_CPUS, child->span);
+					printk(" %s", str);
+					cpus_or(groupmask, groupmask, child->span);
 				}
+				printk("\n");
 
-				if (!cpus_weight(group->cpumask))
-					printk(" ERROR empty group:");
-
-				if (cpus_intersects(groupmask, group->cpumask))
-					printk(" ERROR repeated CPUs:");
-
-				cpus_or(groupmask, groupmask, group->cpumask);
-
-				cpumask_scnprintf(str, NR_CPUS, group->cpumask);
-				printk(" %s", str);
-
-				group = group->next;
-			} while (group != sd->groups);
-			printk("\n");
-
-			if (!cpus_equal(sd->span, groupmask))
-				printk(KERN_DEBUG "ERROR groups don't span domain->span\n");
+				if (!cpus_equal(sd->span, groupmask))
+					printk(SD_DEBUG "ERROR children don't span domain->span\n");
+			}
 
 			level++;
 			sd = sd->parent;
 
 			if (sd) {
 				if (!cpus_subset(groupmask, sd->span))
-					printk(KERN_DEBUG "ERROR parent span is not a superset of domain->span\n");
+					printk(SD_DEBUG "ERROR parent span is not a superset of domain->span\n");
 			}
-
 		} while (sd);
 	}
 }
-#else
+#else /* !SCHED_DOMAIN_DEBUG */
 #define sched_domain_debug() {}
-#endif
+#endif /* SCHED_DOMAIN_DEBUG */
 
-#ifdef CONFIG_SMP
 /*
  * Initial dummy domain for early boot and for hotplug cpu. Being static,
  * it is initialized to zero, so all balancing flags are cleared which is
  * what we want.
  */
 static struct sched_domain sched_domain_dummy;
-#endif
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * Force a reinitialization of the sched domains hierarchy.  The domains
- * and groups cannot be updated in place without racing with the balancing
+ * cannot be updated in place without racing with the balancing
  * code, so we temporarily attach all running cpus to a "dummy" domain
  * which will prevent rebalancing while the sched domains are recalculated.
  */
@@ -5444,7 +5404,7 @@ static int update_sched_domains(struct n
 
 	return NOTIFY_OK;
 }
-#endif
+#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init sched_init_smp(void)
 {
@@ -5455,7 +5415,7 @@ void __init sched_init_smp(void)
 	/* XXX: Theoretical race here - CPU may be hotplugged now */
 	hotcpu_notifier(update_sched_domains, 0);
 }
-#else
+#else /* !CONFIG_SMP */
 void __init sched_init_smp(void)
 {
 }


