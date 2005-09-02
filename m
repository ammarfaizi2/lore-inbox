Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVIBULN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVIBULN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVIBULM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:11:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47498 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751049AbVIBULK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:11:10 -0400
Date: Fri, 2 Sep 2005 13:10:43 -0700 (PDT)
From: hawkes@sgi.com
To: Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org,
       hawkes@sgi.com, Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050902201043.15701.92254.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 2/3] 2.6.13-mm1: cpuset + build_sched_domains() fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, Dino, and Andrew,

Here is the "cpuset + build_sched_domains() mangles structures" set of
patches against 2.6.13-mm1.

Patch #2:  Fix the "dynamic sched domains" bug:
  * For a NUMA system with multiple CPUs per node, declaring a
    cpu-exclusive cpuset that includes only some, but not all, of the
    CPUs in a node will mangle the sched domain structures.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2005-09-02 10:46:27.000000000 -0700
+++ linux/kernel/sched.c	2005-09-02 11:17:46.000000000 -0700
@@ -5305,10 +5305,10 @@
  * gets dynamically allocated.
  */
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
-static struct sched_group *sched_group_nodes[MAX_NUMNODES];
+static struct sched_group **sched_group_nodes_bycpu[NR_CPUS];
 
 static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
-static struct sched_group sched_group_allnodes[MAX_NUMNODES];
+static struct sched_group *sched_group_allnodes_bycpu[NR_CPUS];
 
 static int cpu_to_allnodes_group(int cpu)
 {
@@ -5323,6 +5323,21 @@
 void build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
+#ifdef CONFIG_NUMA
+	struct sched_group **sched_group_nodes = NULL;
+	struct sched_group *sched_group_allnodes = NULL;
+
+	/*
+	 * Allocate the per-node list of sched groups
+	 */
+	sched_group_nodes = kmalloc(sizeof(struct sched_group*)*MAX_NUMNODES,
+					   GFP_ATOMIC);
+	if (!sched_group_nodes) {
+		printk(KERN_WARNING "Can not alloc sched group node list\n");
+		return;
+	}
+	sched_group_nodes_bycpu[first_cpu(*cpu_map)] = sched_group_nodes;
+#endif
 
 	/*
 	 * Set up domains for cpus specified by the cpu_map.
@@ -5335,8 +5350,21 @@
 		cpus_and(nodemask, nodemask, *cpu_map);
 
 #ifdef CONFIG_NUMA
-		if (num_online_cpus()
+		if (cpus_weight(*cpu_map)
 				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
+			if (!sched_group_allnodes) {
+				sched_group_allnodes
+					= kmalloc(sizeof(struct sched_group)
+							* MAX_NUMNODES,
+						  GFP_KERNEL);
+				if (!sched_group_allnodes) {
+					printk(KERN_WARNING
+					"Can not alloc allnodes sched group\n");
+					break;
+				}
+				sched_group_allnodes_bycpu[i]
+						= sched_group_allnodes;
+			}
 			sd = &per_cpu(allnodes_domains, i);
 			*sd = SD_ALLNODES_INIT;
 			sd->span = *cpu_map;
@@ -5400,8 +5428,9 @@
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
-	init_sched_build_groups(sched_group_allnodes, *cpu_map,
-				&cpu_to_allnodes_group);
+	if (sched_group_allnodes)
+		init_sched_build_groups(sched_group_allnodes, *cpu_map,
+					&cpu_to_allnodes_group);
 
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		/* Set up node groups */
@@ -5412,8 +5441,10 @@
 		int j;
 
 		cpus_and(nodemask, nodemask, *cpu_map);
-		if (cpus_empty(nodemask))
+		if (cpus_empty(nodemask)) {
+			sched_group_nodes[i] = NULL;
 			continue;
+		}
 
 		domainspan = sched_domain_node_span(i);
 		cpus_and(domainspan, domainspan, *cpu_map);
@@ -5558,24 +5589,42 @@
 {
 #ifdef CONFIG_NUMA
 	int i;
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		cpumask_t nodemask = node_to_cpumask(i);
-		struct sched_group *oldsg, *sg = sched_group_nodes[i];
+	int cpu;
 
-		cpus_and(nodemask, nodemask, *cpu_map);
-		if (cpus_empty(nodemask))
-			continue;
+	for_each_cpu_mask(cpu, *cpu_map) {
+		struct sched_group *sched_group_allnodes
+			= sched_group_allnodes_bycpu[cpu];
+		struct sched_group **sched_group_nodes
+			= sched_group_nodes_bycpu[cpu];
+
+		if (sched_group_allnodes) {
+			kfree(sched_group_allnodes);
+			sched_group_allnodes_bycpu[cpu] = NULL;
+		}
 
-		if (sg == NULL)
+		if (!sched_group_nodes)
 			continue;
-		sg = sg->next;
+
+		for (i = 0; i < MAX_NUMNODES; i++) {
+			cpumask_t nodemask = node_to_cpumask(i);
+			struct sched_group *oldsg, *sg = sched_group_nodes[i];
+
+			cpus_and(nodemask, nodemask, *cpu_map);
+			if (cpus_empty(nodemask))
+				continue;
+
+			if (sg == NULL)
+				continue;
+			sg = sg->next;
 next_sg:
-		oldsg = sg;
-		sg = sg->next;
-		kfree(oldsg);
-		if (oldsg != sched_group_nodes[i])
-			goto next_sg;
-		sched_group_nodes[i] = NULL;
+			oldsg = sg;
+			sg = sg->next;
+			kfree(oldsg);
+			if (oldsg != sched_group_nodes[i])
+				goto next_sg;
+		}
+		kfree(sched_group_nodes);
+		sched_group_nodes_bycpu[cpu] = NULL;
 	}
 #endif
 }
