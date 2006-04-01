Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWDASwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWDASwf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 13:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWDASwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 13:52:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:909 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751596AbWDASwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 13:52:34 -0500
Date: Sun, 2 Apr 2006 00:22:22 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16-mm2 1/4] sched_domain - handle kmalloc failure
Message-ID: <20060401185222.GA10591@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew/Nick/Ingo,
	Here's a different version of the patch that tries to handle mem
allocation failures in build_sched_domains by bailing out and cleaning up 
thus-far allocated memory. The patch has a direct consequence that we disable 
load balancing completely (even at sibling level) upon *any* memory allocation 
failure. Is that acceptable?



Patch (against 2.6.16-mm2) to handle memory allocation failure in 
build_sched_domains.


Signed-off-by: Srivatsa Vaddagir <vatsa@in.ibm.com>



diff -puN kernel/sched.c~sd_handle_error kernel/sched.c
--- linux-2.6.16-mm2/kernel/sched.c~sd_handle_error	2006-04-01 23:36:43.000000000 +0530
+++ linux-2.6.16-mm2-root/kernel/sched.c	2006-04-01 23:37:35.000000000 +0530
@@ -6061,11 +6061,56 @@ next_sg:
 }
 #endif
 
+/* Free memory allocated for various sched_group structures */
+static void free_sched_groups(const cpumask_t *cpu_map)
+{
+#ifdef CONFIG_NUMA
+	int i;
+	int cpu;
+
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
+
+		if (!sched_group_nodes)
+			continue;
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
+next_sg:
+			oldsg = sg;
+			sg = sg->next;
+			kfree(oldsg);
+			if (oldsg != sched_group_nodes[i])
+				goto next_sg;
+		}
+		kfree(sched_group_nodes);
+		sched_group_nodes_bycpu[cpu] = NULL;
+	}
+#endif
+}
+
 /*
  * Build sched domains for a given set of cpus and attach the sched domains
  * to the individual cpus
  */
-void build_sched_domains(const cpumask_t *cpu_map)
+static int build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
 #ifdef CONFIG_NUMA
@@ -6075,11 +6120,11 @@ void build_sched_domains(const cpumask_t
 	/*
 	 * Allocate the per-node list of sched groups
 	 */
-	sched_group_nodes = kmalloc(sizeof(struct sched_group*)*MAX_NUMNODES,
+	sched_group_nodes = kzalloc(sizeof(struct sched_group*)*MAX_NUMNODES,
 					   GFP_ATOMIC);
 	if (!sched_group_nodes) {
 		printk(KERN_WARNING "Can not alloc sched group node list\n");
-		return;
+		return -ENOMEM;
 	}
 	sched_group_nodes_bycpu[first_cpu(*cpu_map)] = sched_group_nodes;
 #endif
@@ -6105,7 +6150,7 @@ void build_sched_domains(const cpumask_t
 				if (!sched_group_allnodes) {
 					printk(KERN_WARNING
 					"Can not alloc allnodes sched group\n");
-					break;
+					goto error;
 				}
 				sched_group_allnodes_bycpu[i]
 						= sched_group_allnodes;
@@ -6219,23 +6264,20 @@ void build_sched_domains(const cpumask_t
 		cpus_and(domainspan, domainspan, *cpu_map);
 
 		sg = kmalloc(sizeof(struct sched_group), GFP_KERNEL);
+		if (!sg) {
+			printk(KERN_WARNING
+			"Can not alloc domain group for node %d\n", i);
+			goto error;
+		}
 		sched_group_nodes[i] = sg;
 		for_each_cpu_mask(j, nodemask) {
 			struct sched_domain *sd;
 			sd = &per_cpu(node_domains, j);
 			sd->groups = sg;
-			if (sd->groups == NULL) {
-				/* Turn off balancing if we have no groups */
-				sd->flags = 0;
-			}
-		}
-		if (!sg) {
-			printk(KERN_WARNING
-			"Can not alloc domain group for node %d\n", i);
-			continue;
 		}
 		sg->cpu_power = 0;
 		sg->cpumask = nodemask;
+		sg->next = sg;
 		cpus_or(covered, covered, nodemask);
 		prev = sg;
 
@@ -6258,15 +6300,15 @@ void build_sched_domains(const cpumask_t
 			if (!sg) {
 				printk(KERN_WARNING
 				"Can not alloc domain group for node %d\n", j);
-				break;
+				goto error;
 			}
 			sg->cpu_power = 0;
 			sg->cpumask = tmp;
+			sg->next = prev;
 			cpus_or(covered, covered, tmp);
 			prev->next = sg;
 			prev = sg;
 		}
-		prev->next = sched_group_nodes[i];
 	}
 #endif
 
@@ -6329,13 +6371,22 @@ void build_sched_domains(const cpumask_t
 	 * Tune cache-hot values:
 	 */
 	calibrate_migration_costs(cpu_map);
+
+	return 0;
+
+#ifdef CONFIG_NUMA
+error:
+	free_sched_groups(cpu_map);
+	return -ENOMEM;
+#endif
 }
 /*
  * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
  */
-static void arch_init_sched_domains(const cpumask_t *cpu_map)
+static int arch_init_sched_domains(const cpumask_t *cpu_map)
 {
 	cpumask_t cpu_default_map;
+	int err;
 
 	/*
 	 * Setup mask for cpus without special case scheduling requirements.
@@ -6344,51 +6395,14 @@ static void arch_init_sched_domains(cons
 	 */
 	cpus_andnot(cpu_default_map, *cpu_map, cpu_isolated_map);
 
-	build_sched_domains(&cpu_default_map);
+	err = build_sched_domains(&cpu_default_map);
+
+	return err;
 }
 
 static void arch_destroy_sched_domains(const cpumask_t *cpu_map)
 {
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
+	free_sched_groups(cpu_map);
 }
 
 /*
@@ -6413,9 +6427,10 @@ static void detach_destroy_domains(const
  * correct sched domains
  * Call with hotplug lock held
  */
-void partition_sched_domains(cpumask_t *partition1, cpumask_t *partition2)
+int partition_sched_domains(cpumask_t *partition1, cpumask_t *partition2)
 {
 	cpumask_t change_map;
+	int err = 0;
 
 	cpus_and(*partition1, *partition1, cpu_online_map);
 	cpus_and(*partition2, *partition2, cpu_online_map);
@@ -6424,9 +6439,11 @@ void partition_sched_domains(cpumask_t *
 	/* Detach sched domains from all of the affected cpus */
 	detach_destroy_domains(&change_map);
 	if (!cpus_empty(*partition1))
-		build_sched_domains(partition1);
-	if (!cpus_empty(*partition2))
-		build_sched_domains(partition2);
+		err = build_sched_domains(partition1);
+	if (!err && !cpus_empty(*partition2))
+		err = build_sched_domains(partition2);
+
+	return err;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff -puN include/linux/sched.h~sd_handle_error include/linux/sched.h
--- linux-2.6.16-mm2/include/linux/sched.h~sd_handle_error	2006-04-01 23:36:43.000000000 +0530
+++ linux-2.6.16-mm2-root/include/linux/sched.h	2006-04-01 23:36:43.000000000 +0530
@@ -632,7 +632,7 @@ struct sched_domain {
 #endif
 };
 
-extern void partition_sched_domains(cpumask_t *partition1,
+extern int partition_sched_domains(cpumask_t *partition1,
 				    cpumask_t *partition2);
 
 /*

_

-- 
Regards,
vatsa
