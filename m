Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWKNB37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWKNB37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755377AbWKNB37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:29:59 -0500
Received: from mga07.intel.com ([143.182.124.22]:29097 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751907AbWKNB35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:29:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,419,1157353200"; 
   d="scan'208"; a="145695905:sNHT92046822"
Date: Mon, 13 Nov 2006 17:06:48 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: clameter@sgi.com
Cc: kenneth.w.chen@intel.com, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: [patch] sched domain: move sched group allocations to percpu area
Message-ID: <20061113170648.F17720@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0611122137190.2708@schroedinger.engr.sgi.com> <000201c706ee$a9992e80$a081030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000201c706ee$a9992e80$a081030a@amr.corp.intel.com>; from kenneth.w.chen@intel.com on Sun, Nov 12, 2006 at 10:40:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph, Can you please test this on your big systems and ACK it? Thanks.
---

Move the sched group allocations to percpu area. This will minimize cross
node memory references and also cleans up the sched groups allocation for
allnodes sched domain.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/kernel/sched.c b/kernel/sched.c
index 3399701..088a63f 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5511,28 +5511,27 @@ static int __init isolated_cpu_setup(cha
 __setup ("isolcpus=", isolated_cpu_setup);
 
 /*
- * init_sched_build_groups takes an array of groups, the cpumask we wish
- * to span, and a pointer to a function which identifies what group a CPU
- * belongs to. The return value of group_fn must be a valid index into the
- * groups[] array, and must be >= 0 and < NR_CPUS (due to the fact that we
- * keep track of groups covered with a cpumask_t).
+ * init_sched_build_groups takes the cpumask we wish to span, and a pointer
+ * to a function which identifies what group(along with sched group) a CPU
+ * belongs to. The return value of group_fn must be a >= 0 and < NR_CPUS
+ * (due to the fact that we keep track of groups covered with a cpumask_t).
  *
  * init_sched_build_groups will build a circular linked list of the groups
  * covered by the given span, and will set each group's ->cpumask correctly,
  * and ->cpu_power to 0.
  */
 static void
-init_sched_build_groups(struct sched_group groups[], cpumask_t span,
-			const cpumask_t *cpu_map,
-			int (*group_fn)(int cpu, const cpumask_t *cpu_map))
+init_sched_build_groups(cpumask_t span, const cpumask_t *cpu_map,
+			int (*group_fn)(int cpu, const cpumask_t *cpu_map,
+					struct sched_group **sg))
 {
 	struct sched_group *first = NULL, *last = NULL;
 	cpumask_t covered = CPU_MASK_NONE;
 	int i;
 
 	for_each_cpu_mask(i, span) {
-		int group = group_fn(i, cpu_map);
-		struct sched_group *sg = &groups[group];
+		struct sched_group *sg;
+		int group = group_fn(i, cpu_map, &sg);
 		int j;
 
 		if (cpu_isset(i, covered))
@@ -5542,7 +5541,7 @@ init_sched_build_groups(struct sched_gro
 		sg->cpu_power = 0;
 
 		for_each_cpu_mask(j, span) {
-			if (group_fn(j, cpu_map) != group)
+			if (group_fn(j, cpu_map, NULL) != group)
 				continue;
 
 			cpu_set(j, covered);
@@ -6118,10 +6117,13 @@ int sched_smt_power_savings = 0, sched_m
  */
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-static struct sched_group sched_group_cpus[NR_CPUS];
+static DEFINE_PER_CPU(struct sched_group, sched_group_cpus);
 
-static int cpu_to_cpu_group(int cpu, const cpumask_t *cpu_map)
+static int cpu_to_cpu_group(int cpu, const cpumask_t *cpu_map,
+			    struct sched_group **sg)
 {
+	if (sg)
+		*sg = &per_cpu(sched_group_cpus, cpu);
 	return cpu;
 }
 #endif
@@ -6131,39 +6133,52 @@ #endif
  */
 #ifdef CONFIG_SCHED_MC
 static DEFINE_PER_CPU(struct sched_domain, core_domains);
-static struct sched_group sched_group_core[NR_CPUS];
+static DEFINE_PER_CPU(struct sched_group, sched_group_core);
 #endif
 
 #if defined(CONFIG_SCHED_MC) && defined(CONFIG_SCHED_SMT)
-static int cpu_to_core_group(int cpu, const cpumask_t *cpu_map)
+static int cpu_to_core_group(int cpu, const cpumask_t *cpu_map,
+			     struct sched_group **sg)
 {
+	int group;
 	cpumask_t mask = cpu_sibling_map[cpu];
 	cpus_and(mask, mask, *cpu_map);
-	return first_cpu(mask);
+	group = first_cpu(mask);
+	if (sg)
+		*sg = &per_cpu(sched_group_core, group);
+	return group;
 }
 #elif defined(CONFIG_SCHED_MC)
-static int cpu_to_core_group(int cpu, const cpumask_t *cpu_map)
+static int cpu_to_core_group(int cpu, const cpumask_t *cpu_map,
+			     struct sched_group **sg)
 {
+	if (sg)
+		*sg = &per_cpu(sched_group_core, cpu);
 	return cpu;
 }
 #endif
 
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-static struct sched_group sched_group_phys[NR_CPUS];
+static DEFINE_PER_CPU(struct sched_group, sched_group_phys);
 
-static int cpu_to_phys_group(int cpu, const cpumask_t *cpu_map)
+static int cpu_to_phys_group(int cpu, const cpumask_t *cpu_map,
+			     struct sched_group **sg)
 {
+	int group;
 #ifdef CONFIG_SCHED_MC
 	cpumask_t mask = cpu_coregroup_map(cpu);
 	cpus_and(mask, mask, *cpu_map);
-	return first_cpu(mask);
+	group = first_cpu(mask);
 #elif defined(CONFIG_SCHED_SMT)
 	cpumask_t mask = cpu_sibling_map[cpu];
 	cpus_and(mask, mask, *cpu_map);
-	return first_cpu(mask);
+	group = first_cpu(mask);
 #else
-	return cpu;
+	group = cpu;
 #endif
+	if (sg)
+		*sg = &per_cpu(sched_group_phys, group);
+	return group;
 }
 
 #ifdef CONFIG_NUMA
@@ -6176,12 +6191,22 @@ static DEFINE_PER_CPU(struct sched_domai
 static struct sched_group **sched_group_nodes_bycpu[NR_CPUS];
 
 static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
-static struct sched_group *sched_group_allnodes_bycpu[NR_CPUS];
+static DEFINE_PER_CPU(struct sched_group, sched_group_allnodes);
 
-static int cpu_to_allnodes_group(int cpu, const cpumask_t *cpu_map)
+static int cpu_to_allnodes_group(int cpu, const cpumask_t *cpu_map,
+				 struct sched_group **sg)
 {
-	return cpu_to_node(cpu);
+	cpumask_t nodemask = node_to_cpumask(cpu_to_node(cpu));
+	int group;
+
+	cpus_and(nodemask, nodemask, *cpu_map);
+	group = first_cpu(nodemask);
+
+	if (sg)
+		*sg = &per_cpu(sched_group_allnodes, group);
+	return group;
 }
+
 static void init_numa_sched_groups_power(struct sched_group *group_head)
 {
 	struct sched_group *sg = group_head;
@@ -6217,16 +6242,9 @@ static void free_sched_groups(const cpum
 	int cpu, i;
 
 	for_each_cpu_mask(cpu, *cpu_map) {
-		struct sched_group *sched_group_allnodes
-			= sched_group_allnodes_bycpu[cpu];
 		struct sched_group **sched_group_nodes
 			= sched_group_nodes_bycpu[cpu];
 
-		if (sched_group_allnodes) {
-			kfree(sched_group_allnodes);
-			sched_group_allnodes_bycpu[cpu] = NULL;
-		}
-
 		if (!sched_group_nodes)
 			continue;
 
@@ -6320,7 +6338,7 @@ static int build_sched_domains(const cpu
 	struct sched_domain *sd;
 #ifdef CONFIG_NUMA
 	struct sched_group **sched_group_nodes = NULL;
-	struct sched_group *sched_group_allnodes = NULL;
+	int sd_allnodes = 0;
 
 	/*
 	 * Allocate the per-node list of sched groups
@@ -6338,7 +6356,6 @@ #endif
 	 * Set up domains for cpus specified by the cpu_map.
 	 */
 	for_each_cpu_mask(i, *cpu_map) {
-		int group;
 		struct sched_domain *sd = NULL, *p;
 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
 
@@ -6347,26 +6364,12 @@ #endif
 #ifdef CONFIG_NUMA
 		if (cpus_weight(*cpu_map)
 				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
-			if (!sched_group_allnodes) {
-				sched_group_allnodes
-					= kmalloc_node(sizeof(struct sched_group)
-						  	* MAX_NUMNODES,
-						  GFP_KERNEL,
-						  cpu_to_node(i));
-				if (!sched_group_allnodes) {
-					printk(KERN_WARNING
-					"Can not alloc allnodes sched group\n");
-					goto error;
-				}
-				sched_group_allnodes_bycpu[i]
-						= sched_group_allnodes;
-			}
 			sd = &per_cpu(allnodes_domains, i);
 			*sd = SD_ALLNODES_INIT;
 			sd->span = *cpu_map;
-			group = cpu_to_allnodes_group(i, cpu_map);
-			sd->groups = &sched_group_allnodes[group];
+			cpu_to_allnodes_group(i, cpu_map, &sd->groups);
 			p = sd;
+			sd_allnodes = 1;
 		} else
 			p = NULL;
 
@@ -6381,36 +6384,33 @@ #endif
 
 		p = sd;
 		sd = &per_cpu(phys_domains, i);
-		group = cpu_to_phys_group(i, cpu_map);
 		*sd = SD_CPU_INIT;
 		sd->span = nodemask;
 		sd->parent = p;
 		if (p)
 			p->child = sd;
-		sd->groups = &sched_group_phys[group];
+		cpu_to_phys_group(i, cpu_map, &sd->groups);
 
 #ifdef CONFIG_SCHED_MC
 		p = sd;
 		sd = &per_cpu(core_domains, i);
-		group = cpu_to_core_group(i, cpu_map);
 		*sd = SD_MC_INIT;
 		sd->span = cpu_coregroup_map(i);
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
 		p->child = sd;
-		sd->groups = &sched_group_core[group];
+		cpu_to_core_group(i, cpu_map, &sd->groups);
 #endif
 
 #ifdef CONFIG_SCHED_SMT
 		p = sd;
 		sd = &per_cpu(cpu_domains, i);
-		group = cpu_to_cpu_group(i, cpu_map);
 		*sd = SD_SIBLING_INIT;
 		sd->span = cpu_sibling_map[i];
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
 		p->child = sd;
-		sd->groups = &sched_group_cpus[group];
+		cpu_to_cpu_group(i, cpu_map, &sd->groups);
 #endif
 	}
 
@@ -6422,8 +6422,7 @@ #ifdef CONFIG_SCHED_SMT
 		if (i != first_cpu(this_sibling_map))
 			continue;
 
-		init_sched_build_groups(sched_group_cpus, this_sibling_map,
-					cpu_map, &cpu_to_cpu_group);
+		init_sched_build_groups(this_sibling_map, cpu_map, &cpu_to_cpu_group);
 	}
 #endif
 
@@ -6434,8 +6433,7 @@ #ifdef CONFIG_SCHED_MC
 		cpus_and(this_core_map, this_core_map, *cpu_map);
 		if (i != first_cpu(this_core_map))
 			continue;
-		init_sched_build_groups(sched_group_core, this_core_map,
-					cpu_map, &cpu_to_core_group);
+		init_sched_build_groups(this_core_map, cpu_map, &cpu_to_core_group);
 	}
 #endif
 
@@ -6448,15 +6446,13 @@ #endif
 		if (cpus_empty(nodemask))
 			continue;
 
-		init_sched_build_groups(sched_group_phys, nodemask,
-					cpu_map, &cpu_to_phys_group);
+		init_sched_build_groups(nodemask, cpu_map, &cpu_to_phys_group);
 	}
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
-	if (sched_group_allnodes)
-		init_sched_build_groups(sched_group_allnodes, *cpu_map,
-					cpu_map, &cpu_to_allnodes_group);
+	if (sd_allnodes)
+		init_sched_build_groups(*cpu_map, cpu_map, &cpu_to_allnodes_group);
 
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		/* Set up node groups */
@@ -6548,10 +6544,10 @@ #ifdef CONFIG_NUMA
 	for (i = 0; i < MAX_NUMNODES; i++)
 		init_numa_sched_groups_power(sched_group_nodes[i]);
 
-	if (sched_group_allnodes) {
-		int group = cpu_to_allnodes_group(first_cpu(*cpu_map), cpu_map);
-		struct sched_group *sg = &sched_group_allnodes[group];
+	if (sd_allnodes) {
+		struct sched_group *sg;
 
+		cpu_to_allnodes_group(first_cpu(*cpu_map), cpu_map, &sg);
 		init_numa_sched_groups_power(sg);
 	}
 #endif
