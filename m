Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266381AbUHMSL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUHMSL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUHMSK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:10:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14012 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266380AbUHMSJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:09:00 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH] add scheduler domains for ia64
Date: Fri, 13 Aug 2004 11:08:40 -0700
User-Agent: KMail/1.6.2
Cc: John Hawkes <hawkes@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oOQHBrWSHZUr5Zz"
Message-Id: <200408131108.40502.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_oOQHBrWSHZUr5Zz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Nick, how does this look?  It adds scheduler domain code for ia64 and replaces 
the patch in Andrew's tree.  It also adds SD_NODE_INIT macros to each arch 
that has ARCH_HAS_SCHED_DOMAIN so that the balance values are more easily 
tweaked.  Since the cpu span of the nodes on ia64 is smaller than the whole 
system, I also removed a WARN_ON in active_load_balance, but I'm not sure if 
that's correct.

Thanks,
Jesse

--Boundary-00=_oOQHBrWSHZUr5Zz
Content-Type: text/plain;
  charset="us-ascii";
  name="sched-domains-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched-domains-ia64.patch"

===== arch/ia64/kernel/smpboot.c 1.56 vs edited =====
--- 1.56/arch/ia64/kernel/smpboot.c	2004-08-04 10:50:16 -07:00
+++ edited/arch/ia64/kernel/smpboot.c	2004-08-13 11:03:29 -07:00
@@ -719,3 +719,182 @@
 		printk(KERN_ERR "SMP: Can't set SAL AP Boot Rendezvous: %s\n",
 		       ia64_sal_strerror(sal_ret));
 }
+
+#ifdef CONFIG_NUMA
+
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
+static int __init find_next_best_node(int node, unsigned long *used_nodes)
+{
+	int i, n, val, min_val, best_node = 0;
+
+	min_val = INT_MAX;
+
+	for (i = 0; i < numnodes; i++) {
+		/* Start at @node */
+		n = (node + i) % numnodes;
+
+		/* Skip already used nodes */
+		if (test_bit(n, used_nodes))
+			continue;
+
+		/* Simple min distance search */
+		val = node_distance(node, i);
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
+cpumask_t __init sched_domain_node_span(int node, int size)
+{
+	int i;
+	cpumask_t span;
+	DECLARE_BITMAP(used_nodes, MAX_NUMNODES);
+
+	cpus_clear(span);
+	bitmap_zero(used_nodes, MAX_NUMNODES);
+
+	for (i = 0; i < size; i++) {
+		int next_node = find_next_best_node(node, used_nodes);
+		cpus_or(span, span, node_to_cpumask(next_node));
+	}
+
+	return span;
+}
+
+static struct sched_group sched_group_cpus[NR_CPUS];
+static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
+
+/* Number of nearby nodes in a node's scheduling domain */
+#define SD_NODES_PER_DOMAIN 4
+
+static struct sched_group sched_group_nodes[MAX_NUMNODES];
+static DEFINE_PER_CPU(struct sched_domain, node_domains);
+void __init arch_init_sched_domains(void)
+{
+	int i;
+	struct sched_group *first_node = NULL, *last_node = NULL;
+
+	/* Set up domains */
+	for_each_cpu(i) {
+		int node = cpu_to_node(i);
+		cpumask_t nodemask = node_to_cpumask(node);
+		struct sched_domain *node_sd = &per_cpu(node_domains, i);
+		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
+
+		*node_sd = SD_NODE_INIT;
+		node_sd->span = sched_domain_node_span(i, SD_NODES_PER_DOMAIN);
+		node_sd->groups = &sched_group_nodes[cpu_to_node(i)];
+
+		*cpu_sd = SD_CPU_INIT;
+		cpus_and(cpu_sd->span, nodemask, cpu_possible_map);
+		cpu_sd->groups = &sched_group_cpus[i];
+		cpu_sd->parent = node_sd;
+	}
+
+	/* Set up groups */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		cpumask_t tmp = node_to_cpumask(i);
+		cpumask_t nodemask;
+		struct sched_group *first_cpu = NULL, *last_cpu = NULL;
+		struct sched_group *node = &sched_group_nodes[i];
+		int j;
+
+		cpus_and(nodemask, tmp, cpu_possible_map);
+
+		if (cpus_empty(nodemask))
+			continue;
+
+		node->cpumask = nodemask;
+		node->cpu_power = SCHED_LOAD_SCALE * cpus_weight(node->cpumask);
+
+		for_each_cpu_mask(j, node->cpumask) {
+			struct sched_group *cpu = &sched_group_cpus[j];
+
+			cpus_clear(cpu->cpumask);
+			cpu_set(j, cpu->cpumask);
+			cpu->cpu_power = SCHED_LOAD_SCALE;
+
+			if (!first_cpu)
+				first_cpu = cpu;
+			if (last_cpu)
+				last_cpu->next = cpu;
+			last_cpu = cpu;
+		}
+		last_cpu->next = first_cpu;
+
+		if (!first_node)
+			first_node = node;
+		if (last_node)
+			last_node->next = node;
+		last_node = node;
+	}
+	last_node->next = first_node;
+
+	mb();
+	for_each_cpu(i) {
+		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
+		cpu_attach_domain(cpu_sd, i);
+	}
+}
+#else /* !CONFIG_NUMA */
+static void __init arch_init_sched_domains(void)
+{
+	int i;
+	struct sched_group *first_cpu = NULL, *last_cpu = NULL;
+
+	/* Set up domains */
+	for_each_cpu(i) {
+		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
+
+		*cpu_sd = SD_CPU_INIT;
+		cpu_sd->span = cpu_possible_map;
+		cpu_sd->groups = &sched_group_cpus[i];
+	}
+
+	/* Set up CPU groups */
+	for_each_cpu_mask(i, cpu_possible_map) {
+		struct sched_group *cpu = &sched_group_cpus[i];
+
+		cpus_clear(cpu->cpumask);
+		cpu_set(i, cpu->cpumask);
+		cpu->cpu_power = SCHED_LOAD_SCALE;
+
+		if (!first_cpu)
+			first_cpu = cpu;
+		if (last_cpu)
+			last_cpu->next = cpu;
+		last_cpu = cpu;
+	}
+	last_cpu->next = first_cpu;
+
+	mb(); /* domains were modified outside the lock */
+	for_each_cpu(i) {
+		struct sched_domain *cpu_sd = &per_cpu(cpu_domains, i);
+		cpu_attach_domain(cpu_sd, i);
+	}
+}
+#endif /* CONFIG_NUMA */
===== include/asm-i386/processor.h 1.67 vs edited =====
--- 1.67/include/asm-i386/processor.h	2004-06-27 00:19:26 -07:00
+++ edited/include/asm-i386/processor.h	2004-08-13 10:37:06 -07:00
@@ -647,6 +647,24 @@
 
 #ifdef CONFIG_SCHED_SMT
 #define ARCH_HAS_SCHED_DOMAIN
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_BALANCE_EXEC	\
+				| SD_BALANCE_CLONE	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
 #define ARCH_HAS_SCHED_WAKE_IDLE
 #endif
 
===== include/asm-ia64/processor.h 1.61 vs edited =====
--- 1.61/include/asm-ia64/processor.h	2004-07-26 22:26:50 -07:00
+++ edited/include/asm-ia64/processor.h	2004-08-13 10:08:03 -07:00
@@ -334,6 +334,29 @@
 /* Prepare to copy thread state - unlazy all lazy status */
 #define prepare_to_copy(tsk)	do { } while (0)
 
+#ifdef CONFIG_NUMA
+/* smpboot.c defines a numa specific scheduler domain routine */
+#define ARCH_HAS_SCHED_DOMAIN
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 80,			\
+	.max_interval		= 320,			\
+	.busy_factor		= 320,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_BALANCE_EXEC	\
+				| SD_BALANCE_CLONE	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 10,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif
+
 /*
  * This is the mechanism for creating a new kernel thread.
  *
===== include/asm-ppc64/processor.h 1.48 vs edited =====
--- 1.48/include/asm-ppc64/processor.h	2004-07-26 15:13:12 -07:00
+++ edited/include/asm-ppc64/processor.h	2004-08-13 10:37:19 -07:00
@@ -628,6 +628,24 @@
 
 #ifdef CONFIG_SCHED_SMT
 #define ARCH_HAS_SCHED_DOMAIN
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_BALANCE_EXEC	\
+				| SD_BALANCE_CLONE	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
 #define ARCH_HAS_SCHED_WAKE_IDLE
 #endif
 
===== include/asm-x86_64/processor.h 1.36 vs edited =====
--- 1.36/include/asm-x86_64/processor.h	2004-06-27 00:19:26 -07:00
+++ edited/include/asm-x86_64/processor.h	2004-08-13 10:37:36 -07:00
@@ -458,6 +458,24 @@
 
 #ifdef CONFIG_SCHED_SMT
 #define ARCH_HAS_SCHED_DOMAIN
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_BALANCE_EXEC	\
+				| SD_BALANCE_CLONE	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
 #define ARCH_HAS_SCHED_WAKE_IDLE
 #endif
 
===== include/linux/sched.h 1.228 vs edited =====
--- 1.228/include/linux/sched.h	2004-07-28 21:58:54 -07:00
+++ edited/include/linux/sched.h	2004-08-13 10:06:05 -07:00
@@ -17,6 +17,7 @@
 #include <asm/system.h>
 #include <asm/semaphore.h>
 #include <asm/page.h>
+#include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
 
@@ -654,6 +655,7 @@
 }
 
 #ifdef CONFIG_NUMA
+#ifndef ARCH_HAS_SCHED_DOMAIN
 /* Common values for NUMA nodes */
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
@@ -673,6 +675,7 @@
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
+#endif
 #endif
 
 extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
===== kernel/sched.c 1.319 vs edited =====
--- 1.319/kernel/sched.c	2004-08-02 01:00:40 -07:00
+++ edited/kernel/sched.c	2004-08-13 10:59:53 -07:00
@@ -1826,10 +1826,8 @@
 	for_each_domain(busiest_cpu, sd)
 		if (cpu_isset(busiest->push_cpu, sd->span))
 			break;
-	if (!sd) {
-		WARN_ON(1);
+	if (!sd)
 		return;
-	}
 
  	group = sd->groups;
 	while (!cpu_isset(busiest_cpu, group->cpumask))

--Boundary-00=_oOQHBrWSHZUr5Zz--
