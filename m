Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVIBUKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVIBUKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVIBUKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:10:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2957 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750785AbVIBUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:10:30 -0400
Date: Fri, 2 Sep 2005 13:10:14 -0700 (PDT)
From: hawkes@sgi.com
To: Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org,
       hawkes@sgi.com, Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050902201014.9693.98774.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 1/3] 2.6.13-mm1: cpuset + build_sched_domains() fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, Dino, and Andrew,

Here is the "cpuset + build_sched_domains() mangles structures" set of
patches against 2.6.13-mm1.

Patch #1:  Move the ia64 domain setup code to the generic code

Signed-off-by: John Hawkes <hawkes@sgi.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/arch/ia64/kernel/Makefile
===================================================================
--- linux.orig/arch/ia64/kernel/Makefile	2005-09-02 08:56:02.000000000 -0700
+++ linux/arch/ia64/kernel/Makefile	2005-09-02 10:46:27.000000000 -0700
@@ -16,7 +16,7 @@
 obj-$(CONFIG_IA64_PALINFO)	+= palinfo.o
 obj-$(CONFIG_IOSAPIC)		+= iosapic.o
 obj-$(CONFIG_MODULES)		+= module.o
-obj-$(CONFIG_SMP)		+= smp.o smpboot.o domain.o
+obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_PERFMON)		+= perfmon_default_smpl.o
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
Index: linux/include/asm-ia64/processor.h
===================================================================
--- linux.orig/include/asm-ia64/processor.h	2005-08-28 16:41:01.000000000 -0700
+++ linux/include/asm-ia64/processor.h	2005-09-02 10:46:27.000000000 -0700
@@ -20,9 +20,6 @@
 #include <asm/ptrace.h>
 #include <asm/ustack.h>
 
-/* Our arch specific arch_init_sched_domain is in arch/ia64/kernel/domain.c */
-#define ARCH_HAS_SCHED_DOMAIN
-
 #define IA64_NUM_DBG_REGS	8
 /*
  * Limits for PMC and PMD are set to less than maximum architected values
Index: linux/include/linux/topology.h
===================================================================
--- linux.orig/include/linux/topology.h	2005-08-28 16:41:01.000000000 -0700
+++ linux/include/linux/topology.h	2005-09-02 10:53:17.000000000 -0700
@@ -135,6 +135,29 @@
 }
 #endif
 
+/* sched_domains SD_ALLNODES_INIT for NUMA machines */
+#define SD_ALLNODES_INIT (struct sched_domain) {	\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 64,			\
+	.max_interval		= 64*num_online_cpus(),	\
+	.busy_factor		= 128,			\
+	.imbalance_pct		= 133,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.busy_idx		= 3,			\
+	.idle_idx		= 3,			\
+	.newidle_idx		= 0, /* unused */	\
+	.wake_idx		= 0, /* unused */	\
+	.forkexec_idx		= 0, /* unused */	\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_LOAD_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 64,			\
+	.nr_balance_failed	= 0,			\
+}
+
 #ifdef CONFIG_NUMA
 #ifndef SD_NODE_INIT
 #error Please define an appropriate SD_NODE_INIT in include/asm/topology.h!!!
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2005-09-02 08:56:51.000000000 -0700
+++ linux/kernel/sched.c	2005-09-02 10:46:27.000000000 -0700
@@ -5114,7 +5114,7 @@
  * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
  * hold the hotplug lock.
  */
-void cpu_attach_domain(struct sched_domain *sd, int cpu)
+static void cpu_attach_domain(struct sched_domain *sd, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
@@ -5137,7 +5137,7 @@
 }
 
 /* cpus with isolated domains */
-cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
+static cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
 
 /* Setup the mask of cpus configured for isolated domains */
 static int __init isolated_cpu_setup(char *str)
@@ -5165,8 +5165,8 @@
  * covered by the given span, and will set each group's ->cpumask correctly,
  * and ->cpu_power to 0.
  */
-void init_sched_build_groups(struct sched_group groups[],
-			cpumask_t span, int (*group_fn)(int cpu))
+static void init_sched_build_groups(struct sched_group groups[], cpumask_t span,
+				    int (*group_fn)(int cpu))
 {
 	struct sched_group *first = NULL, *last = NULL;
 	cpumask_t covered = CPU_MASK_NONE;
@@ -5199,12 +5199,85 @@
 	last->next = first;
 }
 
+#define SD_NODES_PER_DOMAIN 16
 
-#ifdef ARCH_HAS_SCHED_DOMAIN
-extern void build_sched_domains(const cpumask_t *cpu_map);
-extern void arch_init_sched_domains(const cpumask_t *cpu_map);
-extern void arch_destroy_sched_domains(const cpumask_t *cpu_map);
-#else
+#ifdef CONFIG_NUMA
+/**
+ * find_next_best_node - find the next node to include in a sched_domain
+ * @node: node whose sched_domain we're building
+ * @used_nodes: nodes already in the sched_domain
+ *
+ * Find the next node to include in a given scheduling domain.  Simply
+ * finds the closest node not already in the @used_nodes map.
+ *
+ * Should use nodemask_t.
+ */
+static int find_next_best_node(int node, unsigned long *used_nodes)
+{
+	int i, n, val, min_val, best_node = 0;
+
+	min_val = INT_MAX;
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		/* Start at @node */
+		n = (node + i) % MAX_NUMNODES;
+
+		if (!nr_cpus_node(n))
+			continue;
+
+		/* Skip already used nodes */
+		if (test_bit(n, used_nodes))
+			continue;
+
+		/* Simple min distance search */
+		val = node_distance(node, n);
+
+		if (val < min_val) {
+			min_val = val;
+			best_node = n;
+		}
+	}
+
+	set_bit(best_node, used_nodes);
+	return best_node;
+}
+
+/**
+ * sched_domain_node_span - get a cpumask for a node's sched_domain
+ * @node: node whose cpumask we're constructing
+ * @size: number of nodes to include in this span
+ *
+ * Given a node, construct a good cpumask for its sched_domain to span.  It
+ * should be one that prevents unnecessary balancing, but also spreads tasks
+ * out optimally.
+ */
+static cpumask_t sched_domain_node_span(int node)
+{
+	int i;
+	cpumask_t span, nodemask;
+	DECLARE_BITMAP(used_nodes, MAX_NUMNODES);
+
+	cpus_clear(span);
+	bitmap_zero(used_nodes, MAX_NUMNODES);
+
+	nodemask = node_to_cpumask(node);
+	cpus_or(span, span, nodemask);
+	set_bit(node, used_nodes);
+
+	for (i = 1; i < SD_NODES_PER_DOMAIN; i++) {
+		int next_node = find_next_best_node(node, used_nodes);
+		nodemask = node_to_cpumask(next_node);
+		cpus_or(span, span, nodemask);
+	}
+
+	return span;
+}
+#endif
+
+/*
+ * At the moment, CONFIG_SCHED_SMT is never defined, but leave it in so we
+ * can switch it on easily if needed.
+ */
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
 static struct sched_group sched_group_cpus[NR_CPUS];
@@ -5226,44 +5299,28 @@
 }
 
 #ifdef CONFIG_NUMA
-
+/*
+ * The init_sched_build_groups can't handle what we want to do with node
+ * groups, so roll our own. Now each node has its own list of groups which
+ * gets dynamically allocated.
+ */
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
-static struct sched_group sched_group_nodes[MAX_NUMNODES];
-static int cpu_to_node_group(int cpu)
+static struct sched_group *sched_group_nodes[MAX_NUMNODES];
+
+static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
+static struct sched_group sched_group_allnodes[MAX_NUMNODES];
+
+static int cpu_to_allnodes_group(int cpu)
 {
 	return cpu_to_node(cpu);
 }
 #endif
 
-#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
-/*
- * The domains setup code relies on siblings not spanning
- * multiple nodes. Make sure the architecture has a proper
- * siblings map:
- */
-static void check_sibling_maps(void)
-{
-	int i, j;
-
-	for_each_online_cpu(i) {
-		for_each_cpu_mask(j, cpu_sibling_map[i]) {
-			if (cpu_to_node(i) != cpu_to_node(j)) {
-				printk(KERN_INFO "warning: CPU %d siblings map "
-					"to different node - isolating "
-					"them.\n", i);
-				cpu_sibling_map[i] = cpumask_of_cpu(i);
-				break;
-			}
-		}
-	}
-}
-#endif
-
 /*
  * Build sched domains for a given set of cpus and attach the sched domains
  * to the individual cpus
  */
-static void build_sched_domains(const cpumask_t *cpu_map)
+void build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
 
@@ -5278,11 +5335,22 @@
 		cpus_and(nodemask, nodemask, *cpu_map);
 
 #ifdef CONFIG_NUMA
+		if (num_online_cpus()
+				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
+			sd = &per_cpu(allnodes_domains, i);
+			*sd = SD_ALLNODES_INIT;
+			sd->span = *cpu_map;
+			group = cpu_to_allnodes_group(i);
+			sd->groups = &sched_group_allnodes[group];
+			p = sd;
+		} else
+			p = NULL;
+
 		sd = &per_cpu(node_domains, i);
-		group = cpu_to_node_group(i);
 		*sd = SD_NODE_INIT;
-		sd->span = *cpu_map;
-		sd->groups = &sched_group_nodes[group];
+		sd->span = sched_domain_node_span(cpu_to_node(i));
+		sd->parent = p;
+		cpus_and(sd->span, sd->span, *cpu_map);
 #endif
 
 		p = sd;
@@ -5307,7 +5375,7 @@
 
 #ifdef CONFIG_SCHED_SMT
 	/* Set up CPU (sibling) groups */
-	for_each_online_cpu(i) {
+	for_each_cpu_mask(i, *cpu_map) {
 		cpumask_t this_sibling_map = cpu_sibling_map[i];
 		cpus_and(this_sibling_map, this_sibling_map, *cpu_map);
 		if (i != first_cpu(this_sibling_map))
@@ -5332,8 +5400,74 @@
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
-	init_sched_build_groups(sched_group_nodes, *cpu_map,
-					&cpu_to_node_group);
+	init_sched_build_groups(sched_group_allnodes, *cpu_map,
+				&cpu_to_allnodes_group);
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		/* Set up node groups */
+		struct sched_group *sg, *prev;
+		cpumask_t nodemask = node_to_cpumask(i);
+		cpumask_t domainspan;
+		cpumask_t covered = CPU_MASK_NONE;
+		int j;
+
+		cpus_and(nodemask, nodemask, *cpu_map);
+		if (cpus_empty(nodemask))
+			continue;
+
+		domainspan = sched_domain_node_span(i);
+		cpus_and(domainspan, domainspan, *cpu_map);
+
+		sg = kmalloc(sizeof(struct sched_group), GFP_KERNEL);
+		sched_group_nodes[i] = sg;
+		for_each_cpu_mask(j, nodemask) {
+			struct sched_domain *sd;
+			sd = &per_cpu(node_domains, j);
+			sd->groups = sg;
+			if (sd->groups == NULL) {
+				/* Turn off balancing if we have no groups */
+				sd->flags = 0;
+			}
+		}
+		if (!sg) {
+			printk(KERN_WARNING
+			"Can not alloc domain group for node %d\n", i);
+			continue;
+		}
+		sg->cpu_power = 0;
+		sg->cpumask = nodemask;
+		cpus_or(covered, covered, nodemask);
+		prev = sg;
+
+		for (j = 0; j < MAX_NUMNODES; j++) {
+			cpumask_t tmp, notcovered;
+			int n = (i + j) % MAX_NUMNODES;
+
+			cpus_complement(notcovered, covered);
+			cpus_and(tmp, notcovered, *cpu_map);
+			cpus_and(tmp, tmp, domainspan);
+			if (cpus_empty(tmp))
+				break;
+
+			nodemask = node_to_cpumask(n);
+			cpus_and(tmp, tmp, nodemask);
+			if (cpus_empty(tmp))
+				continue;
+
+			sg = kmalloc(sizeof(struct sched_group), GFP_KERNEL);
+			if (!sg) {
+				printk(KERN_WARNING
+				"Can not alloc domain group for node %d\n", j);
+				break;
+			}
+			sg->cpu_power = 0;
+			sg->cpumask = tmp;
+			cpus_or(covered, covered, tmp);
+			prev->next = sg;
+			prev = sg;
+		}
+		prev->next = sched_group_nodes[i];
+	}
 #endif
 
 	/* Calculate CPU power for physical packages and nodes */
@@ -5352,14 +5486,46 @@
 		sd->groups->cpu_power = power;
 
 #ifdef CONFIG_NUMA
-		if (i == first_cpu(sd->groups->cpumask)) {
-			/* Only add "power" once for each physical package. */
-			sd = &per_cpu(node_domains, i);
-			sd->groups->cpu_power += power;
+		sd = &per_cpu(allnodes_domains, i);
+		if (sd->groups) {
+			power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
+				(cpus_weight(sd->groups->cpumask)-1) / 10;
+			sd->groups->cpu_power = power;
 		}
 #endif
 	}
 
+#ifdef CONFIG_NUMA
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		struct sched_group *sg = sched_group_nodes[i];
+		int j;
+
+		if (sg == NULL)
+			continue;
+next_sg:
+		for_each_cpu_mask(j, sg->cpumask) {
+			struct sched_domain *sd;
+			int power;
+
+			sd = &per_cpu(phys_domains, j);
+			if (j != first_cpu(sd->groups->cpumask)) {
+				/*
+				 * Only add "power" once for each
+				 * physical package.
+				 */
+				continue;
+			}
+			power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
+				(cpus_weight(sd->groups->cpumask)-1) / 10;
+
+			sg->cpu_power += power;
+		}
+		sg = sg->next;
+		if (sg != sched_group_nodes[i])
+			goto next_sg;
+	}
+#endif
+
 	/* Attach the domains */
 	for_each_cpu_mask(i, *cpu_map) {
 		struct sched_domain *sd;
@@ -5374,13 +5540,10 @@
 /*
  * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
  */
-static void arch_init_sched_domains(cpumask_t *cpu_map)
+static void arch_init_sched_domains(const cpumask_t *cpu_map)
 {
 	cpumask_t cpu_default_map;
 
-#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
-	check_sibling_maps();
-#endif
 	/*
 	 * Setup mask for cpus without special case scheduling requirements.
 	 * For now this just excludes isolated cpus, but could be used to
@@ -5393,10 +5556,29 @@
 
 static void arch_destroy_sched_domains(const cpumask_t *cpu_map)
 {
-	/* Do nothing: everything is statically allocated. */
-}
+#ifdef CONFIG_NUMA
+	int i;
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		cpumask_t nodemask = node_to_cpumask(i);
+		struct sched_group *oldsg, *sg = sched_group_nodes[i];
+
+		cpus_and(nodemask, nodemask, *cpu_map);
+		if (cpus_empty(nodemask))
+			continue;
 
-#endif /* ARCH_HAS_SCHED_DOMAIN */
+		if (sg == NULL)
+			continue;
+		sg = sg->next;
+next_sg:
+		oldsg = sg;
+		sg = sg->next;
+		kfree(oldsg);
+		if (oldsg != sched_group_nodes[i])
+			goto next_sg;
+		sched_group_nodes[i] = NULL;
+	}
+#endif
+}
 
 /*
  * Detach sched domains from a group of cpus specified in cpu_map
Index: linux/arch/ia64/kernel/domain.c
===================================================================
--- linux.orig/arch/ia64/kernel/domain.c	2005-09-02 10:45:06.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,444 +0,0 @@
-/*
- * arch/ia64/kernel/domain.c
- * Architecture specific sched-domains builder.
- *
- * Copyright (C) 2004 Jesse Barnes
- * Copyright (C) 2004 Silicon Graphics, Inc.
- */
-
-#include <linux/sched.h>
-#include <linux/percpu.h>
-#include <linux/slab.h>
-#include <linux/cpumask.h>
-#include <linux/init.h>
-#include <linux/topology.h>
-#include <linux/nodemask.h>
-
-#define SD_NODES_PER_DOMAIN 16
-
-#ifdef CONFIG_NUMA
-/**
- * find_next_best_node - find the next node to include in a sched_domain
- * @node: node whose sched_domain we're building
- * @used_nodes: nodes already in the sched_domain
- *
- * Find the next node to include in a given scheduling domain.  Simply
- * finds the closest node not already in the @used_nodes map.
- *
- * Should use nodemask_t.
- */
-static int find_next_best_node(int node, unsigned long *used_nodes)
-{
-	int i, n, val, min_val, best_node = 0;
-
-	min_val = INT_MAX;
-
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		/* Start at @node */
-		n = (node + i) % MAX_NUMNODES;
-
-		if (!nr_cpus_node(n))
-			continue;
-
-		/* Skip already used nodes */
-		if (test_bit(n, used_nodes))
-			continue;
-
-		/* Simple min distance search */
-		val = node_distance(node, n);
-
-		if (val < min_val) {
-			min_val = val;
-			best_node = n;
-		}
-	}
-
-	set_bit(best_node, used_nodes);
-	return best_node;
-}
-
-/**
- * sched_domain_node_span - get a cpumask for a node's sched_domain
- * @node: node whose cpumask we're constructing
- * @size: number of nodes to include in this span
- *
- * Given a node, construct a good cpumask for its sched_domain to span.  It
- * should be one that prevents unnecessary balancing, but also spreads tasks
- * out optimally.
- */
-static cpumask_t sched_domain_node_span(int node)
-{
-	int i;
-	cpumask_t span, nodemask;
-	DECLARE_BITMAP(used_nodes, MAX_NUMNODES);
-
-	cpus_clear(span);
-	bitmap_zero(used_nodes, MAX_NUMNODES);
-
-	nodemask = node_to_cpumask(node);
-	cpus_or(span, span, nodemask);
-	set_bit(node, used_nodes);
-
-	for (i = 1; i < SD_NODES_PER_DOMAIN; i++) {
-		int next_node = find_next_best_node(node, used_nodes);
-		nodemask = node_to_cpumask(next_node);
-		cpus_or(span, span, nodemask);
-	}
-
-	return span;
-}
-#endif
-
-/*
- * At the moment, CONFIG_SCHED_SMT is never defined, but leave it in so we
- * can switch it on easily if needed.
- */
-#ifdef CONFIG_SCHED_SMT
-static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-static struct sched_group sched_group_cpus[NR_CPUS];
-static int cpu_to_cpu_group(int cpu)
-{
-	return cpu;
-}
-#endif
-
-static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-static struct sched_group sched_group_phys[NR_CPUS];
-static int cpu_to_phys_group(int cpu)
-{
-#ifdef CONFIG_SCHED_SMT
-	return first_cpu(cpu_sibling_map[cpu]);
-#else
-	return cpu;
-#endif
-}
-
-#ifdef CONFIG_NUMA
-/*
- * The init_sched_build_groups can't handle what we want to do with node
- * groups, so roll our own. Now each node has its own list of groups which
- * gets dynamically allocated.
- */
-static DEFINE_PER_CPU(struct sched_domain, node_domains);
-static struct sched_group **sched_group_nodes_bycpu[NR_CPUS];
-
-static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
-static struct sched_group *sched_group_allnodes_bycpu[NR_CPUS];
-
-static int cpu_to_allnodes_group(int cpu)
-{
-	return cpu_to_node(cpu);
-}
-#endif
-
-/*
- * Build sched domains for a given set of cpus and attach the sched domains
- * to the individual cpus
- */
-void build_sched_domains(const cpumask_t *cpu_map)
-{
-	int i;
-#ifdef CONFIG_NUMA
-	struct sched_group **sched_group_nodes = NULL;
-	struct sched_group *sched_group_allnodes = NULL;
-
-	/*
-	 * Allocate the per-node list of sched groups
-	 */
-	sched_group_nodes = kmalloc(sizeof(struct sched_group*)*MAX_NUMNODES,
-					   GFP_ATOMIC);
-	if (!sched_group_nodes) {
-		printk(KERN_WARNING "Can not alloc sched group node list\n");
-		return;
-	}
-	sched_group_nodes_bycpu[first_cpu(*cpu_map)] = sched_group_nodes;
-#endif
-
-	/*
-	 * Set up domains for cpus specified by the cpu_map.
-	 */
-	for_each_cpu_mask(i, *cpu_map) {
-		int group;
-		struct sched_domain *sd = NULL, *p;
-		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
-
-		cpus_and(nodemask, nodemask, *cpu_map);
-
-#ifdef CONFIG_NUMA
-		if (cpus_weight(*cpu_map)
-				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
-			if (!sched_group_allnodes) {
-				sched_group_allnodes
-					= kmalloc(sizeof(struct sched_group)
-							* MAX_NUMNODES,
-						  GFP_KERNEL);
-				if (!sched_group_allnodes) {
-					printk(KERN_WARNING
-					"Can not alloc allnodes sched group\n");
-					break;
-				}
-				sched_group_allnodes_bycpu[i]
-						= sched_group_allnodes;
-			}
-			sd = &per_cpu(allnodes_domains, i);
-			*sd = SD_ALLNODES_INIT;
-			sd->span = *cpu_map;
-			group = cpu_to_allnodes_group(i);
-			sd->groups = &sched_group_allnodes[group];
-			p = sd;
-		} else
-			p = NULL;
-
-		sd = &per_cpu(node_domains, i);
-		*sd = SD_NODE_INIT;
-		sd->span = sched_domain_node_span(cpu_to_node(i));
-		sd->parent = p;
-		cpus_and(sd->span, sd->span, *cpu_map);
-#endif
-
-		p = sd;
-		sd = &per_cpu(phys_domains, i);
-		group = cpu_to_phys_group(i);
-		*sd = SD_CPU_INIT;
-		sd->span = nodemask;
-		sd->parent = p;
-		sd->groups = &sched_group_phys[group];
-
-#ifdef CONFIG_SCHED_SMT
-		p = sd;
-		sd = &per_cpu(cpu_domains, i);
-		group = cpu_to_cpu_group(i);
-		*sd = SD_SIBLING_INIT;
-		sd->span = cpu_sibling_map[i];
-		cpus_and(sd->span, sd->span, *cpu_map);
-		sd->parent = p;
-		sd->groups = &sched_group_cpus[group];
-#endif
-	}
-
-#ifdef CONFIG_SCHED_SMT
-	/* Set up CPU (sibling) groups */
-	for_each_cpu_mask(i, *cpu_map) {
-		cpumask_t this_sibling_map = cpu_sibling_map[i];
-		cpus_and(this_sibling_map, this_sibling_map, *cpu_map);
-		if (i != first_cpu(this_sibling_map))
-			continue;
-
-		init_sched_build_groups(sched_group_cpus, this_sibling_map,
-						&cpu_to_cpu_group);
-	}
-#endif
-
-	/* Set up physical groups */
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		cpumask_t nodemask = node_to_cpumask(i);
-
-		cpus_and(nodemask, nodemask, *cpu_map);
-		if (cpus_empty(nodemask))
-			continue;
-
-		init_sched_build_groups(sched_group_phys, nodemask,
-						&cpu_to_phys_group);
-	}
-
-#ifdef CONFIG_NUMA
-	if (sched_group_allnodes)
-		init_sched_build_groups(sched_group_allnodes, *cpu_map,
-					&cpu_to_allnodes_group);
-
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		/* Set up node groups */
-		struct sched_group *sg, *prev;
-		cpumask_t nodemask = node_to_cpumask(i);
-		cpumask_t domainspan;
-		cpumask_t covered = CPU_MASK_NONE;
-		int j;
-
-		cpus_and(nodemask, nodemask, *cpu_map);
-		if (cpus_empty(nodemask)) {
-			sched_group_nodes[i] = NULL;
-			continue;
-		}
-
-		domainspan = sched_domain_node_span(i);
-		cpus_and(domainspan, domainspan, *cpu_map);
-
-		sg = kmalloc(sizeof(struct sched_group), GFP_KERNEL);
-		sched_group_nodes[i] = sg;
-		for_each_cpu_mask(j, nodemask) {
-			struct sched_domain *sd;
-			sd = &per_cpu(node_domains, j);
-			sd->groups = sg;
-			if (sd->groups == NULL) {
-				/* Turn off balancing if we have no groups */
-				sd->flags = 0;
-			}
-		}
-		if (!sg) {
-			printk(KERN_WARNING
-			"Can not alloc domain group for node %d\n", i);
-			continue;
-		}
-		sg->cpu_power = 0;
-		sg->cpumask = nodemask;
-		cpus_or(covered, covered, nodemask);
-		prev = sg;
-
-		for (j = 0; j < MAX_NUMNODES; j++) {
-			cpumask_t tmp, notcovered;
-			int n = (i + j) % MAX_NUMNODES;
-
-			cpus_complement(notcovered, covered);
-			cpus_and(tmp, notcovered, *cpu_map);
-			cpus_and(tmp, tmp, domainspan);
-			if (cpus_empty(tmp))
-				break;
-
-			nodemask = node_to_cpumask(n);
-			cpus_and(tmp, tmp, nodemask);
-			if (cpus_empty(tmp))
-				continue;
-
-			sg = kmalloc(sizeof(struct sched_group), GFP_KERNEL);
-			if (!sg) {
-				printk(KERN_WARNING
-				"Can not alloc domain group for node %d\n", j);
-				break;
-			}
-			sg->cpu_power = 0;
-			sg->cpumask = tmp;
-			cpus_or(covered, covered, tmp);
-			prev->next = sg;
-			prev = sg;
-		}
-		prev->next = sched_group_nodes[i];
-	}
-#endif
-
-	/* Calculate CPU power for physical packages and nodes */
-	for_each_cpu_mask(i, *cpu_map) {
-		int power;
-		struct sched_domain *sd;
-#ifdef CONFIG_SCHED_SMT
-		sd = &per_cpu(cpu_domains, i);
-		power = SCHED_LOAD_SCALE;
-		sd->groups->cpu_power = power;
-#endif
-
-		sd = &per_cpu(phys_domains, i);
-		power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
-				(cpus_weight(sd->groups->cpumask)-1) / 10;
-		sd->groups->cpu_power = power;
-
-#ifdef CONFIG_NUMA
-		sd = &per_cpu(allnodes_domains, i);
-		if (sd->groups) {
-			power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
-				(cpus_weight(sd->groups->cpumask)-1) / 10;
-			sd->groups->cpu_power = power;
-		}
-#endif
-	}
-
-#ifdef CONFIG_NUMA
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		struct sched_group *sg = sched_group_nodes[i];
-		int j;
-
-		if (sg == NULL)
-			continue;
-next_sg:
-		for_each_cpu_mask(j, sg->cpumask) {
-			struct sched_domain *sd;
-			int power;
-
-			sd = &per_cpu(phys_domains, j);
-			if (j != first_cpu(sd->groups->cpumask)) {
-				/*
-				 * Only add "power" once for each
-				 * physical package.
-				 */
-				continue;
-			}
-			power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
-				(cpus_weight(sd->groups->cpumask)-1) / 10;
-
-			sg->cpu_power += power;
-		}
-		sg = sg->next;
-		if (sg != sched_group_nodes[i])
-			goto next_sg;
-	}
-#endif
-
-	/* Attach the domains */
-	for_each_cpu_mask(i, *cpu_map) {
-		struct sched_domain *sd;
-#ifdef CONFIG_SCHED_SMT
-		sd = &per_cpu(cpu_domains, i);
-#else
-		sd = &per_cpu(phys_domains, i);
-#endif
-		cpu_attach_domain(sd, i);
-	}
-}
-/*
- * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
- */
-void arch_init_sched_domains(const cpumask_t *cpu_map)
-{
-	cpumask_t cpu_default_map;
-
-	/*
-	 * Setup mask for cpus without special case scheduling requirements.
-	 * For now this just excludes isolated cpus, but could be used to
-	 * exclude other special cases in the future.
-	 */
-	cpus_andnot(cpu_default_map, *cpu_map, cpu_isolated_map);
-
-	build_sched_domains(&cpu_default_map);
-}
-
-void arch_destroy_sched_domains(const cpumask_t *cpu_map)
-{
-#ifdef CONFIG_NUMA
-	int i;
-	int cpu;
-
-	for_each_cpu_mask(cpu, *cpu_map) {
-		struct sched_group *sched_group_allnodes
-			= sched_group_allnodes_bycpu[cpu];
-		struct sched_group **sched_group_nodes
-			= sched_group_nodes_bycpu[cpu];
-
-		if (sched_group_allnodes) {
-			kfree(sched_group_allnodes);
-			sched_group_allnodes_bycpu[cpu] = NULL;
-		}
-
-		if (!sched_group_nodes)
-			continue;
-
-		for (i = 0; i < MAX_NUMNODES; i++) {
-			cpumask_t nodemask = node_to_cpumask(i);
-			struct sched_group *oldsg, *sg = sched_group_nodes[i];
-
-			cpus_and(nodemask, nodemask, *cpu_map);
-			if (cpus_empty(nodemask))
-				continue;
-
-			if (sg == NULL)
-				continue;
-			sg = sg->next;
-next_sg:
-			oldsg = sg;
-			sg = sg->next;
-			kfree(oldsg);
-			if (oldsg != sched_group_nodes[i])
-				goto next_sg;
-		}
-		kfree(sched_group_nodes);
-		sched_group_nodes_bycpu[cpu] = NULL;
-	}
-#endif
-}
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2005-09-02 08:56:45.000000000 -0700
+++ linux/include/linux/sched.h	2005-09-02 10:47:08.000000000 -0700
@@ -600,13 +600,6 @@
 
 extern void partition_sched_domains(cpumask_t *partition1,
 				    cpumask_t *partition2);
-#ifdef ARCH_HAS_SCHED_DOMAIN
-/* Useful helpers that arch setup code may use. Defined in kernel/sched.c */
-extern cpumask_t cpu_isolated_map;
-extern void init_sched_build_groups(struct sched_group groups[],
-	                        cpumask_t span, int (*group_fn)(int cpu));
-extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
-#endif /* ARCH_HAS_SCHED_DOMAIN */
 #endif /* CONFIG_SMP */
 
 
Index: linux/include/asm-ia64/topology.h
===================================================================
--- linux.orig/include/asm-ia64/topology.h	2005-08-28 16:41:01.000000000 -0700
+++ linux/include/asm-ia64/topology.h	2005-09-02 10:48:01.000000000 -0700
@@ -98,29 +98,6 @@
 	.nr_balance_failed	= 0,			\
 }
 
-/* sched_domains SD_ALLNODES_INIT for IA64 NUMA machines */
-#define SD_ALLNODES_INIT (struct sched_domain) {	\
-	.span			= CPU_MASK_NONE,	\
-	.parent			= NULL,			\
-	.groups			= NULL,			\
-	.min_interval		= 64,			\
-	.max_interval		= 64*num_online_cpus(),	\
-	.busy_factor		= 128,			\
-	.imbalance_pct		= 133,			\
-	.cache_hot_time		= (10*1000000),		\
-	.cache_nice_tries	= 1,			\
-	.busy_idx		= 3,			\
-	.idle_idx		= 3,			\
-	.newidle_idx		= 0, /* unused */	\
-	.wake_idx		= 0, /* unused */	\
-	.forkexec_idx		= 0, /* unused */	\
-	.per_cpu_gain		= 100,			\
-	.flags			= SD_LOAD_BALANCE,	\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 64,			\
-	.nr_balance_failed	= 0,			\
-}
-
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
