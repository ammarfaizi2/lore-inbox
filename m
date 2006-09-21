Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWIUWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWIUWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWIUWC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:02:28 -0400
Received: from mga05.intel.com ([192.55.52.89]:376 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751655AbWIUWC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:02:27 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,196,1157353200"; 
   d="scan'208"; a="134655566:sNHT537998888"
Date: Thu, 21 Sep 2006 14:44:26 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: akpm@osdl.org
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, pj@sgi.com,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com
Subject: [patch 2/2] sched: cleanup sched_group cpu_power setup
Message-ID: <20060921144426.B25601@unix-os.sc.intel.com>
References: <20060921143924.A25601@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060921143924.A25601@unix-os.sc.intel.com>; from suresh.b.siddha@intel.com on Thu, Sep 21, 2006 at 02:39:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>

Up to now sched group's cpu_power for each sched domain is initialized
independently.  This made the setup code ugly as the new sched domains are
getting added.

Make the sched group cpu_power setup code generic, by using domain
child field and new domain flag in sched_domain.  For most of the sched
domains(except NUMA), sched group's cpu_power is now computed generically
using the domain properties of itself and of the child domain.

sched groups in NUMA domains are setup little differently and hence they
don't use this generic mechanism.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>
---

diff -pNru linux-child/include/linux/sched.h linux-cleanup/include/linux/sched.h
--- linux-child/include/linux/sched.h	2006-09-21 12:10:05.000000000 -0700
+++ linux-cleanup/include/linux/sched.h	2006-09-21 12:09:35.000000000 -0700
@@ -623,9 +623,17 @@ enum idle_type
 #define SD_WAKE_BALANCE		64	/* Perform balancing at task wakeup */
 #define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
 #define SD_POWERSAVINGS_BALANCE	256	/* Balance for power savings */
+#define SD_SHARE_PKG_RESOURCES	512	/* Domain members share cpu pkg resources */
 
-#define BALANCE_FOR_POWER	((sched_mc_power_savings || sched_smt_power_savings) \
-				 ? SD_POWERSAVINGS_BALANCE : 0)
+#define BALANCE_FOR_MC_POWER	\
+	(sched_smt_power_savings ? SD_POWERSAVINGS_BALANCE : 0)
+
+#define BALANCE_FOR_PKG_POWER	\
+	((sched_mc_power_savings || sched_smt_power_savings) ?	\
+	 SD_POWERSAVINGS_BALANCE : 0)
+
+#define test_sd_parent(sd, flag)	((sd->parent &&		\
+					 (sd->parent->flags & flag)) ? 1 : 0)
 
 
 struct sched_group {
diff -pNru linux-child/include/linux/topology.h linux-cleanup/include/linux/topology.h
--- linux-child/include/linux/topology.h	2006-09-21 12:10:05.000000000 -0700
+++ linux-cleanup/include/linux/topology.h	2006-09-21 12:09:35.000000000 -0700
@@ -115,6 +115,38 @@
 #endif
 #endif /* CONFIG_SCHED_SMT */
 
+#ifdef CONFIG_SCHED_MC
+/* Common values for MC siblings. for now mostly derived from SD_CPU_INIT */
+#ifndef SD_MC_INIT
+#define SD_MC_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.child			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 1,			\
+	.max_interval		= 4,			\
+	.busy_factor		= 64,			\
+	.imbalance_pct		= 125,			\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.busy_idx		= 2,			\
+	.idle_idx		= 1,			\
+	.newidle_idx		= 2,			\
+	.wake_idx		= 1,			\
+	.forkexec_idx		= 1,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_NEWIDLE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_AFFINE	\
+				| SD_SHARE_PKG_RESOURCES\
+				| BALANCE_FOR_MC_POWER,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif
+#endif /* CONFIG_SCHED_MC */
+
 /* Common values for CPUs */
 #ifndef SD_CPU_INIT
 #define SD_CPU_INIT (struct sched_domain) {		\
@@ -137,7 +169,7 @@
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_AFFINE	\
-				| BALANCE_FOR_POWER,	\
+				| BALANCE_FOR_PKG_POWER,\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
@@ -168,15 +200,6 @@
 	.nr_balance_failed	= 0,			\
 }
 
-#ifdef CONFIG_SCHED_MC
-#ifndef SD_MC_INIT
-/* for now its same as SD_CPU_INIT.
- * TBD: Tune Domain parameters!
- */
-#define SD_MC_INIT   SD_CPU_INIT
-#endif
-#endif
-
 #ifdef CONFIG_NUMA
 #ifndef SD_NODE_INIT
 #error Please define an appropriate SD_NODE_INIT in include/asm/topology.h!!!
diff -pNru linux-child/kernel/sched.c linux-cleanup/kernel/sched.c
--- linux-child/kernel/sched.c	2006-09-21 12:10:05.000000000 -0700
+++ linux-cleanup/kernel/sched.c	2006-09-21 12:09:35.000000000 -0700
@@ -2520,8 +2520,14 @@ static int load_balance(int this_cpu, st
 	unsigned long imbalance;
 	struct rq *busiest;
 
+	/*
+	 * When power savings policy is enabled for the parent domain, idle
+	 * sibling can pick up load irrespective of busy siblings. In this case,
+	 * let the state of idle sibling percolate up as IDLE, instead of
+	 * portraying it as NOT_IDLE.
+	 */
 	if (idle != NOT_IDLE && sd->flags & SD_SHARE_CPUPOWER &&
-	    !sched_smt_power_savings)
+	    !test_sd_parent(sd, SD_POWERSAVINGS_BALANCE))
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[idle]);
@@ -2611,7 +2617,7 @@ static int load_balance(int this_cpu, st
 	}
 
 	if (!nr_moved && !sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
-	    !sched_smt_power_savings)
+	    !test_sd_parent(sd, SD_POWERSAVINGS_BALANCE))
 		return -1;
 	return nr_moved;
 
@@ -2627,7 +2633,7 @@ out_one_pinned:
 		sd->balance_interval *= 2;
 
 	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
-			!sched_smt_power_savings)
+	    !test_sd_parent(sd, SD_POWERSAVINGS_BALANCE))
 		return -1;
 	return 0;
 }
@@ -2648,7 +2654,14 @@ load_balance_newidle(int this_cpu, struc
 	int nr_moved = 0;
 	int sd_idle = 0;
 
-	if (sd->flags & SD_SHARE_CPUPOWER && !sched_smt_power_savings)
+	/*
+	 * When power savings policy is enabled for the parent domain, idle
+	 * sibling can pick up load irrespective of busy siblings. In this case,
+	 * let the state of idle sibling percolate up as IDLE, instead of
+	 * portraying it as NOT_IDLE.
+	 */
+	if (sd->flags & SD_SHARE_CPUPOWER &&
+	    !test_sd_parent(sd, SD_POWERSAVINGS_BALANCE))
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
@@ -2680,7 +2693,8 @@ load_balance_newidle(int this_cpu, struc
 
 	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
-		if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+		if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
+		    !test_sd_parent(sd, SD_POWERSAVINGS_BALANCE))
 			return -1;
 	} else
 		sd->nr_balance_failed = 0;
@@ -2690,7 +2704,7 @@ load_balance_newidle(int this_cpu, struc
 out_balanced:
 	schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
 	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
-					!sched_smt_power_savings)
+	    !test_sd_parent(sd, SD_POWERSAVINGS_BALANCE))
 		return -1;
 	sd->nr_balance_failed = 0;
 
@@ -5356,7 +5370,9 @@ static int sd_degenerate(struct sched_do
 	if (sd->flags & (SD_LOAD_BALANCE |
 			 SD_BALANCE_NEWIDLE |
 			 SD_BALANCE_FORK |
-			 SD_BALANCE_EXEC)) {
+			 SD_BALANCE_EXEC |
+			 SD_SHARE_CPUPOWER |
+			 SD_SHARE_PKG_RESOURCES)) {
 		if (sd->groups != sd->groups->next)
 			return 0;
 	}
@@ -5390,7 +5406,9 @@ sd_parent_degenerate(struct sched_domain
 		pflags &= ~(SD_LOAD_BALANCE |
 				SD_BALANCE_NEWIDLE |
 				SD_BALANCE_FORK |
-				SD_BALANCE_EXEC);
+				SD_BALANCE_EXEC |
+				SD_SHARE_CPUPOWER |
+				SD_SHARE_PKG_RESOURCES);
 	}
 	if (~cflags & pflags)
 		return 0;
@@ -6196,13 +6214,68 @@ next_sg:
 	}
 }
 
+
+/*
+ * Initialize sched groups cpu_power.
+ *
+ * cpu_power indicates the capacity of sched group, which is used while
+ * distributing the load between different sched groups in a sched domain.
+ * Typically cpu_power for all the groups in a sched domain will be same unless
+ * there are asymmetries in the topology. If there are asymmetries, group
+ * having more cpu_power will pickup more load compared to the group having
+ * less cpu_power.
+ *
+ * cpu_power will be a multiple of SCHED_LOAD_SCALE. This multiple represents
+ * the maximum number of tasks a group can handle in the presence of other idle
+ * or lightly loaded groups in the same sched domain.
+ */
+static void init_sched_groups_power(int cpu, struct sched_domain *sd)
+{
+	struct sched_domain *child;
+	struct sched_group *group;
+
+	WARN_ON(!sd || !sd->groups);
+
+	if (cpu != first_cpu(sd->groups->cpumask))
+		return;
+
+	child = sd->child;
+
+	/*
+	 * For perf policy, if the groups in child domain share resources
+	 * (for example cores sharing some portions of the cache hierarchy
+	 * or SMT), then set this domain groups cpu_power such that each group
+	 * can handle only one task, when there are other idle groups in the
+	 * same sched domain.
+	 */
+	if (!child || (!(sd->flags & SD_POWERSAVINGS_BALANCE) &&
+		       (child->flags &
+			(SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES)))) {
+		sd->groups->cpu_power = SCHED_LOAD_SCALE;
+		return;
+	}
+
+	sd->groups->cpu_power = 0;
+
+	/*
+	 * add cpu_power of each child group to this groups cpu_power
+	 */
+	group = child->groups;
+	do {
+		sd->groups->cpu_power += group->cpu_power;
+		group = group->next;
+	} while (group != child->groups);
+}
+
 /*
+ *
  * Build sched domains for a given set of cpus and attach the sched domains
  * to the individual cpus
  */
 static int build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
+	struct sched_domain *sd;
 	struct sched_group *sched_group_phys = NULL;
 #ifdef CONFIG_SCHED_MC
 	struct sched_group *sched_group_core = NULL;
@@ -6440,72 +6513,20 @@ static int build_sched_domains(const cpu
 	/* Calculate CPU power for physical packages and nodes */
 #ifdef CONFIG_SCHED_SMT
 	for_each_cpu_mask(i, *cpu_map) {
-		struct sched_domain *sd;
 		sd = &per_cpu(cpu_domains, i);
-		sd->groups->cpu_power = SCHED_LOAD_SCALE;
+		init_sched_groups_power(i, sd);
 	}
 #endif
 #ifdef CONFIG_SCHED_MC
 	for_each_cpu_mask(i, *cpu_map) {
-		int power;
-		struct sched_domain *sd;
 		sd = &per_cpu(core_domains, i);
-		if (sched_smt_power_savings)
-			power = SCHED_LOAD_SCALE * cpus_weight(sd->groups->cpumask);
-		else
-			power = SCHED_LOAD_SCALE + (cpus_weight(sd->groups->cpumask)-1)
-					    * SCHED_LOAD_SCALE / 10;
-		sd->groups->cpu_power = power;
+		init_sched_groups_power(i, sd);
 	}
 #endif
 
 	for_each_cpu_mask(i, *cpu_map) {
-		struct sched_domain *sd;
-#ifdef CONFIG_SCHED_MC
-		sd = &per_cpu(phys_domains, i);
-		if (i != first_cpu(sd->groups->cpumask))
-			continue;
-
-		sd->groups->cpu_power = 0;
-		if (sched_mc_power_savings || sched_smt_power_savings) {
-			int j;
-
- 			for_each_cpu_mask(j, sd->groups->cpumask) {
-				struct sched_domain *sd1;
- 				sd1 = &per_cpu(core_domains, j);
- 				/*
- 			 	 * for each core we will add once
- 				 * to the group in physical domain
- 			 	 */
-  	 			if (j != first_cpu(sd1->groups->cpumask))
- 					continue;
-
- 				if (sched_smt_power_savings)
-   					sd->groups->cpu_power += sd1->groups->cpu_power;
- 				else
-   					sd->groups->cpu_power += SCHED_LOAD_SCALE;
-   			}
- 		} else
- 			/*
- 			 * This has to be < 2 * SCHED_LOAD_SCALE
- 			 * Lets keep it SCHED_LOAD_SCALE, so that
- 			 * while calculating NUMA group's cpu_power
- 			 * we can simply do
- 			 *  numa_group->cpu_power += phys_group->cpu_power;
- 			 *
- 			 * See "only add power once for each physical pkg"
- 			 * comment below
- 			 */
- 			sd->groups->cpu_power = SCHED_LOAD_SCALE;
-#else
-		int power;
 		sd = &per_cpu(phys_domains, i);
-		if (sched_smt_power_savings)
-			power = SCHED_LOAD_SCALE * cpus_weight(sd->groups->cpumask);
-		else
-			power = SCHED_LOAD_SCALE;
-		sd->groups->cpu_power = power;
-#endif
+		init_sched_groups_power(i, sd);
 	}
 
 #ifdef CONFIG_NUMA
