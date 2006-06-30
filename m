Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWF3AiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWF3AiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWF3AiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:38:10 -0400
Received: from mga05.intel.com ([192.55.52.89]:32626 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751341AbWF3AiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:38:08 -0400
X-IronPort-AV: i="4.06,193,1149490800"; 
   d="scan'208"; a="91390188:sNHT18926208"
Date: Thu, 29 Jun 2006 17:31:35 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@kolivas.org, nickpiggin@yahoo.com.au, mingo@elte.hu,
       pwil3058@bigpond.net.au, akpm@osdl.org
Subject: [Patch] sched: group CPU power setup cleanup
Message-ID: <20060629173135.A21415@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will be away for few days. Will respond on 5th to any comments.

thanks,
suresh
--

Cleanup the sched group cpu_power setup code, by introducing
child field and new domain flag in sched_domain.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -pNru linux-2.6.17-git13/include/asm-i386/topology.h linux/include/asm-i386/topology.h
--- linux-2.6.17-git13/include/asm-i386/topology.h	2006-06-29 09:44:54.056192504 -0700
+++ linux/include/asm-i386/topology.h	2006-06-29 10:01:46.075342208 -0700
@@ -74,6 +74,7 @@ static inline int node_to_first_cpu(int 
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
diff -pNru linux-2.6.17-git13/include/asm-ia64/topology.h linux/include/asm-ia64/topology.h
--- linux-2.6.17-git13/include/asm-ia64/topology.h	2006-06-29 09:44:54.073189920 -0700
+++ linux/include/asm-ia64/topology.h	2006-06-29 10:01:27.340190384 -0700
@@ -59,6 +59,7 @@ void build_cpu_to_node_map(void);
 #define SD_CPU_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 1,			\
 	.max_interval		= 4,			\
@@ -84,6 +85,7 @@ void build_cpu_to_node_map(void);
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 8*(min(num_online_cpus(), 32)), \
diff -pNru linux-2.6.17-git13/include/asm-mips/mach-ip27/topology.h linux/include/asm-mips/mach-ip27/topology.h
--- linux-2.6.17-git13/include/asm-mips/mach-ip27/topology.h	2006-06-17 18:49:35.000000000 -0700
+++ linux/include/asm-mips/mach-ip27/topology.h	2006-06-29 10:00:26.818391096 -0700
@@ -22,6 +22,7 @@ extern unsigned char __node_distances[MA
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
diff -pNru linux-2.6.17-git13/include/asm-powerpc/topology.h linux/include/asm-powerpc/topology.h
--- linux-2.6.17-git13/include/asm-powerpc/topology.h	2006-06-29 09:44:54.199170768 -0700
+++ linux/include/asm-powerpc/topology.h	2006-06-29 10:00:44.402717872 -0700
@@ -43,6 +43,7 @@ extern int pcibus_to_node(struct pci_bus
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
diff -pNru linux-2.6.17-git13/include/asm-x86_64/topology.h linux/include/asm-x86_64/topology.h
--- linux-2.6.17-git13/include/asm-x86_64/topology.h	2006-06-29 09:44:54.283158000 -0700
+++ linux/include/asm-x86_64/topology.h	2006-06-28 15:33:29.250396176 -0700
@@ -31,6 +31,7 @@ extern int __node_distance(int, int);
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 8,			\
 	.max_interval		= 32,			\
diff -pNru linux-2.6.17-git13/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.6.17-git13/include/linux/sched.h	2006-06-29 09:44:54.384142648 -0700
+++ linux/include/linux/sched.h	2006-06-29 14:47:49.528100784 -0700
@@ -576,9 +576,16 @@ enum idle_type
 #define SD_WAKE_BALANCE		64	/* Perform balancing at task wakeup */
 #define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
 #define SD_POWERSAVINGS_BALANCE	256	/* Balance for power savings */
+#define SD_SHARE_PKG_RESOURCES	512	/* Domain members share cpu pkg resources */
 
-#define BALANCE_FOR_POWER	((sched_mc_power_savings || sched_smt_power_savings) \
-				 ? SD_POWERSAVINGS_BALANCE : 0)
+#define BALANCE_FOR_MC_POWER	(sched_smt_power_savings ?	\
+					SD_POWERSAVINGS_BALANCE : 0)
+
+#define BALANCE_FOR_PKG_POWER	\
+	((sched_mc_power_savings || sched_smt_power_savings) ?	\
+					SD_POWERSAVINGS_BALANCE : 0)
+
+#define test_sd_flag(sd, flag)	((sd && sd->flags & flag) ? 1 : 0)
 
 
 struct sched_group {
@@ -595,6 +602,7 @@ struct sched_group {
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain *parent;	/* top domain must be null terminated */
+	struct sched_domain *child;	/* bottom domain must be null terminated */
 	struct sched_group *groups;	/* the balancing groups of the domain */
 	cpumask_t span;			/* span of all CPUs in this domain */
 	unsigned long min_interval;	/* Minimum balance interval ms */
diff -pNru linux-2.6.17-git13/include/linux/topology.h linux/include/linux/topology.h
--- linux-2.6.17-git13/include/linux/topology.h	2006-06-29 09:44:54.400140216 -0700
+++ linux/include/linux/topology.h	2006-06-29 14:52:10.295458120 -0700
@@ -89,6 +89,7 @@
 #define SD_SIBLING_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 1,			\
 	.max_interval		= 2,			\
@@ -114,11 +115,44 @@
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
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 1,			\
 	.max_interval		= 4,			\
@@ -135,7 +169,7 @@
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_AFFINE	\
-				| BALANCE_FOR_POWER,	\
+				| BALANCE_FOR_PKG_POWER,\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
@@ -146,6 +180,7 @@
 #define SD_ALLNODES_INIT (struct sched_domain) {	\
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
+	.child			= NULL,			\
 	.groups			= NULL,			\
 	.min_interval		= 64,			\
 	.max_interval		= 64*num_online_cpus(),	\
@@ -165,15 +200,6 @@
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
diff -pNru linux-2.6.17-git13/kernel/sched.c linux/kernel/sched.c
--- linux-2.6.17-git13/kernel/sched.c	2006-06-29 09:44:54.494125928 -0700
+++ linux/kernel/sched.c	2006-06-29 15:01:22.660485872 -0700
@@ -1240,7 +1240,6 @@ static int sched_balance_self(int cpu, i
 		cpumask_t span;
 		struct sched_group *group;
 		int new_cpu;
-		int weight;
 
 		span = sd->span;
 		group = find_idlest_group(sd, t, cpu);
@@ -1254,14 +1253,9 @@ static int sched_balance_self(int cpu, i
 		/* Now try balancing at a lower domain level */
 		cpu = new_cpu;
 nextlevel:
-		sd = NULL;
-		weight = cpus_weight(span);
-		for_each_domain(cpu, tmp) {
-			if (weight <= cpus_weight(tmp->span))
-				break;
-			if (tmp->flags & flag)
-				sd = tmp;
-		}
+		sd = sd->child;
+		if (sd && sd->flags & flag)
+			goto nextlevel;
 		/* while loop will break here if sd == NULL */
 	}
 
@@ -2450,8 +2444,14 @@ static int load_balance(int this_cpu, ru
 	int active_balance = 0;
 	int sd_idle = 0;
 
+	/*
+	 * When power savings policy is enabled for the parent domain, idle
+	 * sibling can pick up load irrespective of busy siblings. In this case,
+	 * let the state of idle sibling percolate up as IDLE, instead of
+	 * portraying it as NOT_IDLE.
+	 */
 	if (idle != NOT_IDLE && sd->flags & SD_SHARE_CPUPOWER &&
-	    !sched_smt_power_savings)
+	    !test_sd_flag(sd->parent, SD_POWERSAVINGS_BALANCE))
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[idle]);
@@ -2541,7 +2541,7 @@ static int load_balance(int this_cpu, ru
 	}
 
 	if (!nr_moved && !sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
-	    !sched_smt_power_savings)
+	    !test_sd_flag(sd->parent, SD_POWERSAVINGS_BALANCE))
 		return -1;
 	return nr_moved;
 
@@ -2556,7 +2556,8 @@ out_one_pinned:
 			(sd->balance_interval < sd->max_interval))
 		sd->balance_interval *= 2;
 
-	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER && !sched_smt_power_savings)
+	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
+	    !test_sd_flag(sd->parent, SD_POWERSAVINGS_BALANCE))
 		return -1;
 	return 0;
 }
@@ -2577,7 +2578,14 @@ static int load_balance_newidle(int this
 	int nr_moved = 0;
 	int sd_idle = 0;
 
-	if (sd->flags & SD_SHARE_CPUPOWER && !sched_smt_power_savings)
+	/*
+	 * When power savings policy is enabled for the parent domain, idle
+	 * sibling can pick up load irrespective of busy siblings. In this case,
+	 * let the state of idle sibling percolate up as IDLE, instead of
+	 * portraying it as NOT_IDLE.
+	 */
+	if (sd->flags & SD_SHARE_CPUPOWER && sd->parent &&
+	    !(sd->parent->flags & SD_POWERSAVINGS_BALANCE))
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
@@ -2609,7 +2617,8 @@ static int load_balance_newidle(int this
 
 	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
-		if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+		if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
+		    !test_sd_flag(sd->parent, SD_POWERSAVINGS_BALANCE))
 			return -1;
 	} else
 		sd->nr_balance_failed = 0;
@@ -2618,7 +2627,8 @@ static int load_balance_newidle(int this
 
 out_balanced:
 	schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
-	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER && !sched_smt_power_savings)
+	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
+	    !test_sd_flag(sd->parent, SD_POWERSAVINGS_BALANCE))
 		return -1;
 	sd->nr_balance_failed = 0;
 	return 0;
@@ -5265,7 +5275,9 @@ static int sd_degenerate(struct sched_do
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
@@ -5299,7 +5311,9 @@ static int sd_parent_degenerate(struct s
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
@@ -5321,12 +5335,18 @@ static void cpu_attach_domain(struct sch
 		struct sched_domain *parent = tmp->parent;
 		if (!parent)
 			break;
-		if (sd_parent_degenerate(tmp, parent))
+		if (sd_parent_degenerate(tmp, parent)) {
 			tmp->parent = parent->parent;
+			if (parent->parent)
+				parent->parent->child = tmp;
+		}
 	}
 
-	if (sd && sd_degenerate(sd))
+	if (sd && sd_degenerate(sd)) {
 		sd = sd->parent;
+		if(sd)
+			sd->child = NULL;
+	}
 
 	sched_domain_debug(sd, cpu);
 
@@ -6093,6 +6113,31 @@ next_sg:
 	}
 }
 
+static void init_sched_groups_power(int cpu, struct sched_domain *sd)
+{
+	struct sched_domain *child;
+	struct sched_group *group;
+
+	if (!sd || !sd->groups || (cpu != first_cpu(sd->groups->cpumask)))
+		return;
+
+	child = sd->child;
+
+	if (!child || (!(sd->flags & SD_POWERSAVINGS_BALANCE) &&
+		       (child->flags & SD_SHARE_CPUPOWER ||
+			child->flags & SD_SHARE_PKG_RESOURCES))) {
+		sd->groups->cpu_power = SCHED_LOAD_SCALE;
+		return;
+	}
+
+	sd->groups->cpu_power = 0;
+	group = child->groups;
+	do {
+		sd->groups->cpu_power += group->cpu_power;
+		group = group->next;
+	} while (group != child->groups);
+}
+
 /*
  * Build sched domains for a given set of cpus and attach the sched domains
  * to the individual cpus
@@ -6101,6 +6146,7 @@ static int build_sched_domains(const cpu
 {
 	int i;
 	struct sched_group *sched_group_phys = NULL;
+	struct sched_domain *sd;
 #ifdef CONFIG_SCHED_MC
 	struct sched_group *sched_group_core = NULL;
 #endif
@@ -6159,6 +6205,8 @@ static int build_sched_domains(const cpu
 		*sd = SD_NODE_INIT;
 		sd->span = sched_domain_node_span(cpu_to_node(i));
 		sd->parent = p;
+		if (p)
+			p->child = sd;
 		cpus_and(sd->span, sd->span, *cpu_map);
 #endif
 
@@ -6180,6 +6228,8 @@ static int build_sched_domains(const cpu
 		*sd = SD_CPU_INIT;
 		sd->span = nodemask;
 		sd->parent = p;
+		if (p)
+			p->child = sd;
 		sd->groups = &sched_group_phys[group];
 
 #ifdef CONFIG_SCHED_MC
@@ -6202,6 +6252,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_coregroup_map(i);
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		p->child = sd;
 		sd->groups = &sched_group_core[group];
 #endif
 
@@ -6213,6 +6264,7 @@ static int build_sched_domains(const cpu
 		sd->span = cpu_sibling_map[i];
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
+		p->child = sd;
 		sd->groups = &sched_group_cpus[group];
 #endif
 	}
@@ -6331,77 +6383,27 @@ static int build_sched_domains(const cpu
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
 		sd = &per_cpu(phys_domains, i);
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
-		sd = &per_cpu(phys_domains, i);
-		if (sched_smt_power_savings)
-			power = SCHED_LOAD_SCALE * cpus_weight(sd->groups->cpumask);
-		else
-			power = SCHED_LOAD_SCALE;
-		sd->groups->cpu_power = power;
-#endif
+		init_sched_groups_power(i, sd);
 	}
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < MAX_NUMNODES; i++)
-		init_numa_sched_groups_power(sched_group_nodes[i]);
+	for_each_cpu_mask(i, *cpu_map) {
+		sd = &per_cpu(node_domains, i);
+		init_sched_groups_power(i, sd);
+	}
 
 	init_numa_sched_groups_power(sched_group_allnodes);
 #endif
