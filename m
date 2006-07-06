Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWGFXoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWGFXoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWGFXoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:44:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60288 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751071AbWGFXoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:44:08 -0400
From: hawkes@sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Jack Steiner <steiner@sgi.com>, hawkes@sgi.com, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, John Hawkes <jrhawkes@yahoo.com>
Date: Thu, 06 Jul 2006 16:43:56 -0700
Message-Id: <20060706234356.23106.60834.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] build sched domains tracking cpusets
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moderate-to-large single system image systems are often carved up into
dynamic cpusets, and applications are individually assigned to specific
cpusets.  The current CPU scheduler's find_busiest_cpu() load-balancing
doesn't work well in this environment, as the busiest CPU may be busy
with tasks that cannot migrate out of their constrained cpuset (because
of the task->cpus_allowed), and this effectively stymies any passive
load-balancing attempted by a CPU not in this busiest CPU's cpuset.
This disabling of load-balancing has been observed by several SGI
customers and can be a serious performance problem.

A lesser observed issue is inefficient load-balancing within (for
example) a cpuset that spans one of those 16-node sched domains that are
built for large NUMA systems.  The next broader sched domain is the
all-CPUs domain, which load-balances across the 16-node sched domain
boundaries relatively infrequently.

This patch introduces the notion of dynamic sched domains (and sched
groups) that track the creation and deletion of cpusets.  Up to eight of
these dynamic sched domains can exist per CPU, which seems to handle the
observed use of cpusets by one popular job manager.  Essentially, every
new cpuset causes the creation of a new sched domain for the CPUs of
that cpuset, and a deletion of the cpuset causes the destruction of that
dynamic sched domain.  New sched domains are inserted into each CPU's
list as appropriate.  The limit of 8/CPU (vs. unlimited) not only caps
the upperbound of kmalloc memory being assigned to sched domain and
sched group structs (thereby avoiding a potential denial-of-service
attack by a runaway user creating cpusets), but it also caps the number
of sched domains being searched by various algorithms in the scheduler.

A "feature" of this implementation is that these dynamic sched domains
build up until that limit of 8/CPU is reached, at which point no
additional sched domains are created; or until a cpu-exclusive cpuset
gets declared, at which point all the dynamically created sched domains
in the affected CPUs get destroyed.  A more sophisticated algorithm in
kernel/cpuset.c could redeclare the dynamic sched domains after a
cpu-exclusive cpuset gets declared, but that is outside the scope of
this simple patch's simple change to kernel/cpuset.c.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-06-17 18:49:35.000000000 -0700
+++ linux/include/linux/sched.h	2006-06-20 13:50:19.092284572 -0700
@@ -558,6 +558,7 @@ enum idle_type
 #define SD_WAKE_AFFINE		32	/* Wake task to waking CPU */
 #define SD_WAKE_BALANCE		64	/* Perform balancing at task wakeup */
 #define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
+#define SD_TRACKS_CPUSET	4096	/* Spam matches non-exclusive cpuset */
 
 struct sched_group {
 	struct sched_group *next;	/* Must be a circular list */
@@ -630,6 +631,9 @@ struct sched_domain {
 extern void partition_sched_domains(cpumask_t *partition1,
 				    cpumask_t *partition2);
 
+extern void add_sched_domain(const cpumask_t *cpu_map);
+extern void destroy_sched_domain(const cpumask_t *cpu_map);
+
 /*
  * Maximum cache size the migration-costs auto-tuning code will
  * search from:
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2006-06-20 13:43:05.962860936 -0700
+++ linux/kernel/sched.c	2006-07-06 15:32:01.330191159 -0700
@@ -4821,6 +4821,7 @@ static void sched_domain_debug(struct sc
 	do {
 		int i;
 		char str[NR_CPUS];
+		struct sched_domain *sd_prev;
 		struct sched_group *group = sd->groups;
 		cpumask_t groupmask;
 
@@ -4885,10 +4886,13 @@ static void sched_domain_debug(struct sc
 			printk(KERN_ERR "ERROR: groups don't span domain->span\n");
 
 		level++;
+		sd_prev = sd;
 		sd = sd->parent;
 
 		if (sd) {
-			if (!cpus_subset(groupmask, sd->span))
+			if (!(sd->flags & SD_TRACKS_CPUSET)		&&
+			    !(sd_prev->flags & SD_TRACKS_CPUSET)	&&
+			    !cpus_subset(groupmask, sd->span))
 				printk(KERN_ERR "ERROR: parent span is not a superset of domain->span\n");
 		}
 
@@ -5677,6 +5681,317 @@ next_sg:
 }
 #endif
 
+#if defined(CONFIG_NUMA) || defined(CONFIG_CPUSETS)
+
+static void build_node_sched_groups(
+	struct sched_group **sched_groups_by_node,
+	const cpumask_t *cpu_map,
+	struct sched_domain *(*sd_for_cpu_fn)(int cpu))
+{
+	int node;
+
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		struct sched_domain *sd;
+		struct sched_group *sg = NULL;
+		struct sched_group *prev;
+		cpumask_t nodemask = node_to_cpumask(node);
+		cpumask_t domainspan;
+		cpumask_t covered = CPU_MASK_NONE;
+		int j;
+
+		cpus_and(nodemask, nodemask, *cpu_map);
+		if (cpus_empty(nodemask)) {
+			sched_groups_by_node[node] = NULL;
+			continue;
+		}
+
+		domainspan = sched_domain_node_span(node);
+		cpus_and(domainspan, domainspan, *cpu_map);
+
+		sd = sd_for_cpu_fn(first_cpu(nodemask));
+		BUG_ON(!sd);
+		if (sd->groups)
+			continue;	/* previously built - all done */
+		sg = kmalloc_node(sizeof(struct sched_group), GFP_KERNEL, node);
+		sched_groups_by_node[node] = sg;
+
+		for_each_cpu_mask(j, nodemask) {
+			sd = sd_for_cpu_fn(j);
+			sd->groups = sg;
+			if (!sg) {
+				/* Turn off balancing if we have no groups */
+				sd->flags = 0;
+			}
+		}
+		if (!sg) {
+			printk(KERN_WARNING
+			"Can not alloc domain group for node %d\n", node);
+			continue;
+		}
+		sg->cpu_power = 0;
+		sg->cpumask = nodemask;
+		cpus_or(covered, covered, nodemask);
+		prev = sg;
+
+		for (j = 0; j < MAX_NUMNODES; j++) {
+			cpumask_t tmp, notcovered;
+			int n = (node + j) % MAX_NUMNODES;
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
+			sg = kmalloc_node(sizeof(struct sched_group),
+					GFP_KERNEL, node);
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
+		prev->next = sched_groups_by_node[node];
+	}
+}
+
+static void free_node_sched_groups(
+	struct sched_group **sched_groups_by_node,
+	const cpumask_t *cpu_map)
+{
+	int node;
+
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		cpumask_t nodemask = node_to_cpumask(node);
+		struct sched_group *oldsg, *sg = sched_groups_by_node[node];
+
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
+		if (oldsg != sched_groups_by_node[node])
+			goto next_sg;
+	}
+}
+#endif
+
+#ifdef CONFIG_CPUSETS
+
+struct sched_domain_bundle {
+	struct sched_domain sd_cpuset;
+	struct sched_group **sg_cpuset_nodes;
+	int use_count;
+};
+#define SCHED_DOMAIN_CPUSET_MAX	8	/* power of 2 */
+static DEFINE_PER_CPU(long, sd_cpusets_used) = { 1UL <<SCHED_DOMAIN_CPUSET_MAX};
+static DEFINE_PER_CPU(struct sched_domain_bundle[SCHED_DOMAIN_CPUSET_MAX],
+		      sd_cpusets_bundle);
+
+static struct sched_domain *sched_domain_per_cpu[NR_CPUS];
+
+static struct sched_domain *find_sd_for_cpu_in_array(int cpu)
+{
+	return sched_domain_per_cpu[cpu];
+}
+
+static int find_existing_sched_domain(int cpu, const cpumask_t *cpu_map)
+{
+	int sd_idx;
+
+	for (sd_idx = 0; sd_idx < SCHED_DOMAIN_CPUSET_MAX; sd_idx++) {
+		struct sched_domain_bundle *sd_cpuset_bundle;
+		struct sched_domain *sd;
+
+		if (!test_bit(sd_idx, &per_cpu(sd_cpusets_used, cpu)))
+			continue;
+		sd_cpuset_bundle = &per_cpu(sd_cpusets_bundle[sd_idx], cpu);
+		sd = &sd_cpuset_bundle->sd_cpuset;
+		if (cpus_equal(*cpu_map, sd->span))
+			return sd_idx;
+	}
+
+	return SCHED_DOMAIN_CPUSET_MAX;
+}
+
+void add_sched_domain(const cpumask_t *cpu_map)
+{
+	int cpu, node, first_cpu_in_cpumap;
+	struct sched_group **sched_groups_by_node;
+	int allocsize = MAX_NUMNODES * sizeof(struct sched_group *);
+	struct sched_domain_bundle *sd_cpuset_bundle;
+	cpumask_t new_sd_cpu_map = CPU_MASK_NONE;
+	int new_sd_span = cpus_weight(*cpu_map);
+
+	if (new_sd_span <= 1)
+		return;
+
+	memset(sched_domain_per_cpu, 0, sizeof(sched_domain_per_cpu));
+
+	first_cpu_in_cpumap = first_cpu(*cpu_map);
+	sched_groups_by_node = kmalloc_node(allocsize, GFP_KERNEL,
+					    cpu_to_node(first_cpu_in_cpumap));
+	if (!sched_groups_by_node) {
+		printk(KERN_WARNING
+		"Cannot alloc sched group array for new domain\n");
+		goto clean_exit;
+	}
+	memset(sched_groups_by_node, 0, allocsize);
+
+	for_each_cpu_mask(cpu, *cpu_map) {
+		struct sched_domain *sd;
+		int sd_idx;
+
+		/* If this is redundant, then just bump the use_count;
+		 * otherwise, use another bundle slot
+		 */
+		if ((sd_idx = find_existing_sched_domain(cpu, cpu_map))
+						< SCHED_DOMAIN_CPUSET_MAX) {
+			sd_cpuset_bundle
+				= &per_cpu(sd_cpusets_bundle[sd_idx], cpu);
+			sd_cpuset_bundle->use_count++;
+			sched_domain_per_cpu[cpu]
+				= &sd_cpuset_bundle->sd_cpuset;
+			continue;	/* move on to next cpu in cpu_map */
+		}
+
+		sd_idx = ffz(per_cpu(sd_cpusets_used, cpu));
+		if (sd_idx >= SCHED_DOMAIN_CPUSET_MAX) {
+			if (cpu == first_cpu_in_cpumap)
+				goto failure_exit;
+			new_sd_span--;
+			continue;
+		}
+		set_bit(sd_idx, &per_cpu(sd_cpusets_used, cpu));
+		sd_cpuset_bundle = &per_cpu(sd_cpusets_bundle[sd_idx], cpu);
+		sd_cpuset_bundle->sg_cpuset_nodes
+		   = (cpu == first_cpu_in_cpumap) ? sched_groups_by_node : NULL;
+		sd_cpuset_bundle->use_count = 1;
+		sd = &sd_cpuset_bundle->sd_cpuset;
+		sched_domain_per_cpu[cpu] = sd;
+
+		/* tweak sched_domain params based upon domain size */
+		*sd = SD_NODE_INIT;
+		sd->flags |= SD_TRACKS_CPUSET;
+		sd->max_interval = 8*(min(new_sd_span, 32));
+		sd->span = *cpu_map;
+		cpu_set(cpu, new_sd_cpu_map);
+	}
+	if (!new_sd_span)	/* sd_cpusets all previously allocated? */
+		goto failure_exit;
+
+	if (cpus_empty(new_sd_cpu_map)) {
+		kfree(sched_groups_by_node);
+		sched_groups_by_node = NULL;
+	} else {
+		build_node_sched_groups(sched_groups_by_node, cpu_map,
+					&find_sd_for_cpu_in_array);
+
+		for (node = 0; node < MAX_NUMNODES; node++)
+			init_numa_sched_groups_power(
+						sched_groups_by_node[node]);
+
+		/* Now carefully insert each new sched domain into the lists */
+		for_each_cpu_mask(cpu, new_sd_cpu_map) {
+			struct sched_domain *sd;
+			struct sched_domain *sd_new = sched_domain_per_cpu[cpu];
+
+			if (!sd_new)
+				continue;
+
+			for_each_domain(cpu, sd) {
+				struct sched_domain *sd_next = sd->parent;
+				if (!sd_next) {
+					sd->parent = sd_new;
+					break;
+				} else {
+					if (cpus_weight(sd_next->span)
+								> new_sd_span) {
+						sd_new->parent = sd_next;
+						wmb();
+						sd->parent = sd_new;
+						break;
+					}
+				}
+			}
+		}
+	}
+
+	goto clean_exit;
+
+failure_exit:
+	kfree(sched_groups_by_node);
+
+clean_exit:
+	return;
+}
+
+void destroy_sched_domain(const cpumask_t *cpu_map)
+{
+	int cpu, sd_idx;
+
+	if (cpus_weight(*cpu_map) <= 1)
+		return;
+
+	for_each_cpu_mask(cpu, *cpu_map) {
+		sd_idx = find_existing_sched_domain(cpu, cpu_map);
+		if (sd_idx < SCHED_DOMAIN_CPUSET_MAX) {
+			struct sched_domain *sd, *sd_list;
+			struct sched_group **sched_groups;
+			struct sched_domain_bundle *sd_bundle
+				= &per_cpu(sd_cpusets_bundle[sd_idx], cpu);
+			if (--sd_bundle->use_count)
+				continue;    /* still have another instance */
+			clear_bit(sd_idx, &per_cpu(sd_cpusets_used, cpu));
+			sd = &sd_bundle->sd_cpuset;
+
+			/* Find and detach sched domain from the list */
+			spin_lock_irq(&cpu_rq(cpu)->lock);
+			for_each_domain(cpu, sd_list) {
+				struct sched_domain *sd_next = sd_list->parent;
+				BUG_ON(!sd_next);
+				if (sd_next->flags & SD_TRACKS_CPUSET &&
+				    cpus_equal(sd_next->span,sd->span)){
+					sd_list->parent = sd_next->parent;
+					break;
+				}
+			}
+			spin_unlock_irq(&cpu_rq(cpu)->lock);
+
+			if (sd_bundle->sg_cpuset_nodes) {
+				sched_groups = sd_bundle->sg_cpuset_nodes;
+				free_node_sched_groups(sched_groups, cpu_map);
+				kfree(sched_groups);
+				sd_bundle->sg_cpuset_nodes = NULL;
+			}
+		}
+	}
+}
+#endif
+
+#ifdef CONFIG_NUMA
+static struct sched_domain *find_sd_for_cpu_in_percpu(int cpu)
+{
+	return &per_cpu(node_domains, cpu);
+}
+#endif
+
 /*
  * Build sched domains for a given set of cpus and attach the sched domains
  * to the individual cpus
@@ -5687,17 +6002,21 @@ void build_sched_domains(const cpumask_t
 #ifdef CONFIG_NUMA
 	struct sched_group **sched_group_nodes = NULL;
 	struct sched_group *sched_group_allnodes = NULL;
+	int first_cpu_in_cpumap = first_cpu(*cpu_map);
+
+	memset(sched_domain_per_cpu, 0, sizeof(sched_domain_per_cpu));
 
 	/*
 	 * Allocate the per-node list of sched groups
 	 */
-	sched_group_nodes = kmalloc(sizeof(struct sched_group*)*MAX_NUMNODES,
-					   GFP_ATOMIC);
+	sched_group_nodes = kmalloc_node(
+				sizeof(struct sched_group*)*MAX_NUMNODES,
+				GFP_ATOMIC, cpu_to_node(first_cpu_in_cpumap));
 	if (!sched_group_nodes) {
 		printk(KERN_WARNING "Can not alloc sched group node list\n");
 		return;
 	}
-	sched_group_nodes_bycpu[first_cpu(*cpu_map)] = sched_group_nodes;
+	sched_group_nodes_bycpu[first_cpu_in_cpumap] = sched_group_nodes;
 #endif
 
 	/*
@@ -5714,15 +6033,16 @@ void build_sched_domains(const cpumask_t
 		if (cpus_weight(*cpu_map)
 				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
 			if (!sched_group_allnodes) {
-				sched_group_allnodes
-					= kmalloc(sizeof(struct sched_group)
-							* MAX_NUMNODES,
-						  GFP_KERNEL);
+				sched_group_allnodes = kmalloc_node(
+				    MAX_NUMNODES*sizeof(struct sched_group),
+				    GFP_KERNEL, cpu_to_node(i));
 				if (!sched_group_allnodes) {
 					printk(KERN_WARNING
 					"Can not alloc allnodes sched group\n");
 					break;
 				}
+				memset(sched_group_allnodes, 0,
+				       MAX_NUMNODES*sizeof(struct sched_group));
 				sched_group_allnodes_bycpu[i]
 						= sched_group_allnodes;
 			}
@@ -5736,6 +6056,7 @@ void build_sched_domains(const cpumask_t
 			p = NULL;
 
 		sd = &per_cpu(node_domains, i);
+		sched_domain_per_cpu[i] = sd;
 		*sd = SD_NODE_INIT;
 		sd->span = sched_domain_node_span(cpu_to_node(i));
 		sd->parent = p;
@@ -5817,73 +6138,8 @@ void build_sched_domains(const cpumask_t
 		init_sched_build_groups(sched_group_allnodes, *cpu_map,
 					&cpu_to_allnodes_group);
 
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
+	build_node_sched_groups(sched_group_nodes, cpu_map,
+				&find_sd_for_cpu_in_percpu);
 #endif
 
 	/* Calculate CPU power for physical packages and nodes */
@@ -5926,7 +6182,9 @@ void build_sched_domains(const cpumask_t
 	for (i = 0; i < MAX_NUMNODES; i++)
 		init_numa_sched_groups_power(sched_group_nodes[i]);
 
-	init_numa_sched_groups_power(sched_group_allnodes);
+	if (sched_group_allnodes)
+		init_numa_sched_groups_power(&sched_group_allnodes[
+				cpu_to_allnodes_group(first_cpu(*cpu_map))]);
 #endif
 
 	/* Attach the domains */
@@ -5965,44 +6223,47 @@ static void arch_init_sched_domains(cons
 
 static void arch_destroy_sched_domains(const cpumask_t *cpu_map)
 {
-#ifdef CONFIG_NUMA
-	int i;
+#if defined(CONFIG_NUMA) || defined(CONFIG_CPUSETS)
 	int cpu;
 
 	for_each_cpu_mask(cpu, *cpu_map) {
+		struct sched_group **sched_group_nodes;
+#ifdef CONFIG_CPUSETS
+		int sd_idx;
+#endif
+#ifdef CONFIG_NUMA
 		struct sched_group *sched_group_allnodes
 			= sched_group_allnodes_bycpu[cpu];
-		struct sched_group **sched_group_nodes
-			= sched_group_nodes_bycpu[cpu];
 
 		if (sched_group_allnodes) {
 			kfree(sched_group_allnodes);
 			sched_group_allnodes_bycpu[cpu] = NULL;
 		}
 
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
+		sched_group_nodes = sched_group_nodes_bycpu[cpu];
+		if (sched_group_nodes) {
+			free_node_sched_groups(sched_group_nodes, cpu_map);
+			kfree(sched_group_nodes);
+			sched_group_nodes_bycpu[cpu] = NULL;
+		}
+#endif
+#ifdef CONFIG_CPUSETS
+		for (sd_idx = 0; sd_idx < SCHED_DOMAIN_CPUSET_MAX; sd_idx++) {
+			struct sched_domain_bundle *sd_bundle;
+			if (!test_bit(sd_idx, &per_cpu(sd_cpusets_used, cpu)))
 				continue;
-			sg = sg->next;
-next_sg:
-			oldsg = sg;
-			sg = sg->next;
-			kfree(oldsg);
-			if (oldsg != sched_group_nodes[i])
-				goto next_sg;
+			sd_bundle = &per_cpu(sd_cpusets_bundle[sd_idx], cpu);
+			clear_bit(sd_idx, &per_cpu(sd_cpusets_used, cpu));
+			sched_group_nodes = sd_bundle->sg_cpuset_nodes;
+			if (sched_group_nodes) {
+				free_node_sched_groups(sched_group_nodes,
+						       cpu_map);
+				kfree(sched_group_nodes);
+				sd_bundle->sg_cpuset_nodes = NULL;
+			}
+			sd_bundle->use_count = 0;
 		}
-		kfree(sched_group_nodes);
-		sched_group_nodes_bycpu[cpu] = NULL;
+#endif
 	}
 #endif
 }
Index: linux/kernel/cpuset.c
===================================================================
--- linux.orig/kernel/cpuset.c	2006-07-05 15:51:38.873939805 -0700
+++ linux/kernel/cpuset.c	2006-07-05 16:01:14.892039725 -0700
@@ -828,8 +828,12 @@ static int update_cpumask(struct cpuset 
 	mutex_lock(&callback_mutex);
 	cs->cpus_allowed = trialcs.cpus_allowed;
 	mutex_unlock(&callback_mutex);
-	if (is_cpu_exclusive(cs) && !cpus_unchanged)
-		update_cpu_domains(cs);
+	if (!cpus_unchanged) {
+		if (is_cpu_exclusive(cs))
+			update_cpu_domains(cs);
+		else
+			add_sched_domain(&cs->cpus_allowed);
+	}
 	return 0;
 }
 
@@ -1934,6 +1938,8 @@ static int cpuset_rmdir(struct inode *un
 	set_bit(CS_REMOVED, &cs->flags);
 	if (is_cpu_exclusive(cs))
 		update_cpu_domains(cs);
+	else
+		destroy_sched_domain(&cs->cpus_allowed);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
 	spin_lock(&cs->dentry->d_lock);
 	d = dget(cs->dentry);
