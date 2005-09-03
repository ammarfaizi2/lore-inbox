Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVICQWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVICQWf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVICQWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:22:35 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:65237 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751093AbVICQWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:22:33 -0400
Date: Sat, 3 Sep 2005 09:22:22 -0700 (PDT)
From: hawkes@sgi.com
To: Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org,
       hawkes@sgi.com, Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050903162222.22566.31038.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH 2/3] 2.6.13: cpuset + build_sched_domains() fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix part 2:
My fix to the 2.6.13 problem:  dynamically allocate sched_group_nodes[]
and sched_group_allnodes[] for each invocation of build_sched_domains(),
rather than use global arrays for these structures, taking care to
remember kmalloc() addresses so that arch_destroy_sched_domains() can
properly kfree() them.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2005-09-02 08:44:24.000000000 -0700
+++ linux/kernel/sched.c	2005-09-02 08:44:53.000000000 -0700
@@ -4970,10 +4970,10 @@
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
@@ -4988,6 +4988,21 @@
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
@@ -5000,8 +5015,21 @@
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
@@ -5065,7 +5093,8 @@
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
-	init_sched_build_groups(sched_group_allnodes, *cpu_map,
+	if (sched_group_allnodes)
+		init_sched_build_groups(sched_group_allnodes, *cpu_map,
 					&cpu_to_allnodes_group);
 
 	for (i = 0; i < MAX_NUMNODES; i++) {
@@ -5077,8 +5106,10 @@
 		int j;
 
 		cpus_and(nodemask, nodemask, *cpu_map);
-		if (cpus_empty(nodemask))
+		if (cpus_empty(nodemask)) {
+			sched_group_nodes[i] = NULL;
 			continue;
+		}
 
 		domainspan = sched_domain_node_span(i);
 		cpus_and(domainspan, domainspan, *cpu_map);
@@ -5223,24 +5254,42 @@
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
