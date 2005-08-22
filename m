Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbVHVWh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbVHVWh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVHVWh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:37:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:30091 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751428AbVHVWhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:37:54 -0400
Date: Mon, 22 Aug 2005 09:08:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Hawkes <hawkes@jackhammer.engr.sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, pj@sgi.com,
       dino@in.ibm.com, nickpiggin@yahoo.com.au, akpm@osdl.org
Subject: Re: [PATCH] ia64 cpuset + build_sched_domains() mangles structures
Message-ID: <20050822070834.GA16722@elte.hu>
References: <43074328.MailOXV1UXUHF@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43074328.MailOXV1UXUHF@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Hawkes <hawkes@jackhammer.engr.sgi.com> wrote:

> The "dynamic sched domains" functionality has recently been merged 
> into 2.6.13-rcN that sees the dynamic declaration of a cpu-exclusive 
> (a.k.a. "isolated") cpuset and rebuilds the CPU Scheduler sched 
> domains and sched groups to separate away the CPUs in this 
> cpu-exclusive cpuset from the remainder of the non-isolated CPUs.  
> This allows the non-isolated CPUs to completely ignore the isolated 
> CPUs when doing load-balancing.
> 
> Unfortunately, build_sched_domains() expects that a sched domain will 
> include all the CPUs of each node in the domain, i.e., that no node 
> will belong in both an isolated cpuset and a non-isolated cpuset.  
> Declaring a cpuset that violates this presumption will produce flawed 
> data structures and will oops the kernel.

ouch.

looks good to me, but in terms of impact we can only do it in 2.6.14. Is 
there something simpler for 2.6.13, to make sure the kernel doesnt oops?

in terms of 2.6.14, the replacement patch below also does what i always 
wanted to do: to merge the ia64-specific build_sched_domains() code back 
into kernel/sched.c. I've done this by taking your improved dynamic 
build-domains code and putting it into kernel/sched.c.

it builds/boots fine on x86 up to 8-way non-NUMA, but the question is 
ppc64 NUMA. It should mostly work though. (Patch is against the tail of 
the scheduler queue in -mm.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo

-----
I've already sent this to the maintainers, and this is now being sent to a
larger community audience.  I have fixed a problem with the ia64 version of
build_sched_domains(), but a similar fix still needs to be made to the
generic build_sched_domains() in kernel/sched.c.

The "dynamic sched domains" functionality has recently been merged into
2.6.13-rcN that sees the dynamic declaration of a cpu-exclusive (a.k.a.
"isolated") cpuset and rebuilds the CPU Scheduler sched domains and sched
groups to separate away the CPUs in this cpu-exclusive cpuset from the
remainder of the non-isolated CPUs.  This allows the non-isolated CPUs to
completely ignore the isolated CPUs when doing load-balancing.

Unfortunately, build_sched_domains() expects that a sched domain will
include all the CPUs of each node in the domain, i.e., that no node will
belong in both an isolated cpuset and a non-isolated cpuset.  Declaring
a cpuset that violates this presumption will produce flawed data
structures and will oops the kernel.

To trigger the problem (on a NUMA system with >1 CPUs per node):
   cd /dev/cpuset
   mkdir newcpuset
   cd newcpuset
   echo 0 >cpus
   echo 0 >mems
   echo 1 >cpu_exclusive

I have fixed this shortcoming for ia64 NUMA (with multiple CPUs per node).
A similar shortcoming exists in the generic build_sched_domains() (in
kernel/sched.c) for NUMA, and that needs to be fixed also.  The fix involves
dynamically allocating sched_group_nodes[] and sched_group_allnodes[] for
each invocation of build_sched_domains(), rather than using global arrays
for these structures.  Care must be taken to remember kmalloc() addresses
so that arch_destroy_sched_domains() can properly kfree() the new dynamic
structures.

This is a patch against 2.6.13-rc6.

Signed-off-by: John Hawkes <hawkes@sgi.com>

reworked the patch to also move the ia64 domain setup code to the generic
code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/ia64/kernel/domain.c    |  400 -------------------------------------------
 arch/ia64/kernel/Makefile    |    2 
 include/asm-ia64/processor.h |    3 
 include/asm-ia64/topology.h  |   22 --
 include/linux/sched.h        |    9 
 include/linux/topology.h     |   22 ++
 kernel/sched.c               |  292 +++++++++++++++++++++++++------
 7 files changed, 260 insertions(+), 490 deletions(-)

Index: linux-sched-curr/arch/ia64/kernel/Makefile
===================================================================
--- linux-sched-curr.orig/arch/ia64/kernel/Makefile
+++ linux-sched-curr/arch/ia64/kernel/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_IA64_HP_ZX1_SWIOTLB) += acp
 obj-$(CONFIG_IA64_PALINFO)	+= palinfo.o
 obj-$(CONFIG_IOSAPIC)		+= iosapic.o
 obj-$(CONFIG_MODULES)		+= module.o
-obj-$(CONFIG_SMP)		+= smp.o smpboot.o domain.o
+obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_PERFMON)		+= perfmon_default_smpl.o
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
Index: linux-sched-curr/arch/ia64/kernel/domain.c
===================================================================
--- linux-sched-curr.orig/arch/ia64/kernel/domain.c
+++ /dev/null
@@ -1,400 +0,0 @@
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
-static struct sched_group *sched_group_nodes[MAX_NUMNODES];
-
-static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
-static struct sched_group sched_group_allnodes[MAX_NUMNODES];
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
-		if (num_online_cpus()
-				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
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
-	init_sched_build_groups(sched_group_allnodes, *cpu_map,
-				&cpu_to_allnodes_group);
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
-		if (cpus_empty(nodemask))
-			continue;
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
-	for_each_online_cpu(i) {
-		struct sched_domain *sd;
-#ifdef CONFIG_SCHED_SMT
-		sd = &per_cpu(cpu_domains, i);
-#else
-		sd = &per_cpu(phys_domains, i);
-#endif
-		cpu_attach_domain(sd, i);
-	}
-	/*
-	 * Tune cache-hot values:
-	 */
-	calibrate_migration_costs();
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
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		cpumask_t nodemask = node_to_cpumask(i);
-		struct sched_group *oldsg, *sg = sched_group_nodes[i];
-
-		cpus_and(nodemask, nodemask, *cpu_map);
-		if (cpus_empty(nodemask))
-			continue;
-
-		if (sg == NULL)
-			continue;
-		sg = sg->next;
-next_sg:
-		oldsg = sg;
-		sg = sg->next;
-		kfree(oldsg);
-		if (oldsg != sched_group_nodes[i])
-			goto next_sg;
-		sched_group_nodes[i] = NULL;
-	}
-#endif
-}
-
Index: linux-sched-curr/include/asm-ia64/processor.h
===================================================================
--- linux-sched-curr.orig/include/asm-ia64/processor.h
+++ linux-sched-curr/include/asm-ia64/processor.h
@@ -20,9 +20,6 @@
 #include <asm/ptrace.h>
 #include <asm/ustack.h>
 
-/* Our arch specific arch_init_sched_domain is in arch/ia64/kernel/domain.c */
-#define ARCH_HAS_SCHED_DOMAIN
-
 #define IA64_NUM_DBG_REGS	8
 /*
  * Limits for PMC and PMD are set to less than maximum architected values
Index: linux-sched-curr/include/asm-ia64/topology.h
===================================================================
--- linux-sched-curr.orig/include/asm-ia64/topology.h
+++ linux-sched-curr/include/asm-ia64/topology.h
@@ -96,28 +96,6 @@ void build_cpu_to_node_map(void);
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
Index: linux-sched-curr/include/linux/sched.h
===================================================================
--- linux-sched-curr.orig/include/linux/sched.h
+++ linux-sched-curr/include/linux/sched.h
@@ -546,15 +546,6 @@ struct sched_domain {
 
 extern void partition_sched_domains(cpumask_t *partition1,
 				    cpumask_t *partition2);
-#ifdef ARCH_HAS_SCHED_DOMAIN
-/* Useful helpers that arch setup code may use. Defined in kernel/sched.c */
-extern cpumask_t cpu_isolated_map;
-extern void init_sched_build_groups(struct sched_group groups[],
-	                        cpumask_t span, int (*group_fn)(int cpu));
-extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
-
-#endif /* ARCH_HAS_SCHED_DOMAIN */
-
 /*
  * Maximum cache size the migration-costs auto-tuning code will
  * search from:
Index: linux-sched-curr/include/linux/topology.h
===================================================================
--- linux-sched-curr.orig/include/linux/topology.h
+++ linux-sched-curr/include/linux/topology.h
@@ -133,6 +133,28 @@
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
Index: linux-sched-curr/kernel/sched.c
===================================================================
--- linux-sched-curr.orig/kernel/sched.c
+++ linux-sched-curr/kernel/sched.c
@@ -4947,7 +4947,7 @@ static int sd_parent_degenerate(struct s
  * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
  * hold the hotplug lock.
  */
-void cpu_attach_domain(struct sched_domain *sd, int cpu)
+static void cpu_attach_domain(struct sched_domain *sd, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
@@ -4970,7 +4970,7 @@ void cpu_attach_domain(struct sched_doma
 }
 
 /* cpus with isolated domains */
-cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
+static cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
 
 /* Setup the mask of cpus configured for isolated domains */
 static int __init isolated_cpu_setup(char *str)
@@ -4998,8 +4998,8 @@ __setup ("isolcpus=", isolated_cpu_setup
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
@@ -5513,12 +5513,85 @@ void __devinit calibrate_migration_costs
 	local_irq_restore(flags);
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
@@ -5540,36 +5613,20 @@ static int cpu_to_phys_group(int cpu)
 }
 
 #ifdef CONFIG_NUMA
-
-static DEFINE_PER_CPU(struct sched_domain, node_domains);
-static struct sched_group sched_group_nodes[MAX_NUMNODES];
-static int cpu_to_node_group(int cpu)
-{
-	return cpu_to_node(cpu);
-}
-#endif
-
-#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
 /*
- * The domains setup code relies on siblings not spanning
- * multiple nodes. Make sure the architecture has a proper
- * siblings map:
+ * The init_sched_build_groups can't handle what we want to do with node
+ * groups, so roll our own. Now each node has its own list of groups which
+ * gets dynamically allocated.
  */
-static void check_sibling_maps(void)
-{
-	int i, j;
+static DEFINE_PER_CPU(struct sched_domain, node_domains);
+static struct sched_group *sched_group_nodes[MAX_NUMNODES];
 
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
+static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
+static struct sched_group sched_group_allnodes[MAX_NUMNODES];
+
+static int cpu_to_allnodes_group(int cpu)
+{
+	return cpu_to_node(cpu);
 }
 #endif
 
@@ -5577,7 +5634,7 @@ static void check_sibling_maps(void)
  * Build sched domains for a given set of cpus and attach the sched domains
  * to the individual cpus
  */
-static void build_sched_domains(const cpumask_t *cpu_map)
+void build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
 
@@ -5592,11 +5649,22 @@ static void build_sched_domains(const cp
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
@@ -5621,7 +5689,7 @@ static void build_sched_domains(const cp
 
 #ifdef CONFIG_SCHED_SMT
 	/* Set up CPU (sibling) groups */
-	for_each_online_cpu(i) {
+	for_each_cpu_mask(i, *cpu_map) {
 		cpumask_t this_sibling_map = cpu_sibling_map[i];
 		cpus_and(this_sibling_map, this_sibling_map, *cpu_map);
 		if (i != first_cpu(this_sibling_map))
@@ -5646,8 +5714,74 @@ static void build_sched_domains(const cp
 
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
@@ -5666,16 +5800,48 @@ static void build_sched_domains(const cp
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
-	for_each_cpu_mask(i, *cpu_map) {
+	for_each_online_cpu(i) {
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
 		sd = &per_cpu(cpu_domains, i);
@@ -5692,13 +5858,10 @@ static void build_sched_domains(const cp
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
@@ -5711,10 +5874,29 @@ static void arch_init_sched_domains(cpum
 
 static void arch_destroy_sched_domains(const cpumask_t *cpu_map)
 {
-	/* Do nothing: everything is statically allocated. */
-}
+#ifdef CONFIG_NUMA
+	int i;
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		cpumask_t nodemask = node_to_cpumask(i);
+		struct sched_group *oldsg, *sg = sched_group_nodes[i];
 
-#endif /* ARCH_HAS_SCHED_DOMAIN */
+		cpus_and(nodemask, nodemask, *cpu_map);
+		if (cpus_empty(nodemask))
+			continue;
+
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
