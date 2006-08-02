Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWHBXga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWHBXga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWHBXga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:36:30 -0400
Received: from mga05.intel.com ([192.55.52.89]:3174 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932162AbWHBXg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:36:29 -0400
X-IronPort-AV: i="4.07,206,1151910000"; 
   d="scan'208"; a="109473889:sNHT11651029425"
Date: Wed, 2 Aug 2006 16:25:39 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: nickpiggin@yahoo.com.au, mingo@elte.hu, vatsa@in.ibm.com, pj@sgi.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [Patch] sched: remove unnecessary sched group allocations
Message-ID: <20060802162539.B19038@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul, Vatsa:

I have tested the appended patch and it works fine on creating excl cpuset with
only one CPU on a dual core system.

Please test your configurations and post your results.

thanks,
suresh
--

Remove dynamic sched group allocations for MC and SMP domains.
These allocations can easily fail on big systems(1024 or so CPUs) and
we can live with out these dynamic allocations.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.18-rc3/kernel/sched.c~	2006-08-02 12:19:54.623210776 -0700
+++ linux-2.6.18-rc3/kernel/sched.c	2006-08-02 13:59:55.562929272 -0700
@@ -5447,15 +5447,17 @@ __setup ("isolcpus=", isolated_cpu_setup
  * covered by the given span, and will set each group's ->cpumask correctly,
  * and ->cpu_power to 0.
  */
-static void init_sched_build_groups(struct sched_group groups[], cpumask_t span,
-				    int (*group_fn)(int cpu))
+static void
+init_sched_build_groups(struct sched_group groups[], cpumask_t span,
+			const cpumask_t *cpu_map,
+			int (*group_fn)(int cpu, const cpumask_t *cpu_map))
 {
 	struct sched_group *first = NULL, *last = NULL;
 	cpumask_t covered = CPU_MASK_NONE;
 	int i;
 
 	for_each_cpu_mask(i, span) {
-		int group = group_fn(i);
+		int group = group_fn(i, cpu_map);
 		struct sched_group *sg = &groups[group];
 		int j;
 
@@ -5466,7 +5468,7 @@ static void init_sched_build_groups(stru
 		sg->cpu_power = 0;
 
 		for_each_cpu_mask(j, span) {
-			if (group_fn(j) != group)
+			if (group_fn(j, cpu_map) != group)
 				continue;
 
 			cpu_set(j, covered);
@@ -6042,7 +6044,7 @@ int sched_smt_power_savings = 0, sched_m
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
 static struct sched_group sched_group_cpus[NR_CPUS];
 
-static int cpu_to_cpu_group(int cpu)
+static int cpu_to_cpu_group(int cpu, const cpumask_t *cpu_map)
 {
 	return cpu;
 }
@@ -6053,31 +6055,36 @@ static int cpu_to_cpu_group(int cpu)
  */
 #ifdef CONFIG_SCHED_MC
 static DEFINE_PER_CPU(struct sched_domain, core_domains);
-static struct sched_group *sched_group_core_bycpu[NR_CPUS];
+static struct sched_group sched_group_core[NR_CPUS];
 #endif
 
 #if defined(CONFIG_SCHED_MC) && defined(CONFIG_SCHED_SMT)
-static int cpu_to_core_group(int cpu)
+static int cpu_to_core_group(int cpu, const cpumask_t *cpu_map)
 {
-	return first_cpu(cpu_sibling_map[cpu]);
+	cpumask_t mask = cpu_sibling_map[cpu];
+	cpus_and(mask, mask, *cpu_map);
+	return first_cpu(mask);
 }
 #elif defined(CONFIG_SCHED_MC)
-static int cpu_to_core_group(int cpu)
+static int cpu_to_core_group(int cpu, const cpumask_t *cpu_map)
 {
 	return cpu;
 }
 #endif
 
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-static struct sched_group *sched_group_phys_bycpu[NR_CPUS];
+static struct sched_group sched_group_phys[NR_CPUS];
 
-static int cpu_to_phys_group(int cpu)
+static int cpu_to_phys_group(int cpu, const cpumask_t *cpu_map)
 {
 #ifdef CONFIG_SCHED_MC
 	cpumask_t mask = cpu_coregroup_map(cpu);
+	cpus_and(mask, mask, *cpu_map);
 	return first_cpu(mask);
 #elif defined(CONFIG_SCHED_SMT)
-	return first_cpu(cpu_sibling_map[cpu]);
+	cpumask_t mask = cpu_sibling_map[cpu];
+	cpus_and(mask, mask, *cpu_map);
+	return first_cpu(mask);
 #else
 	return cpu;
 #endif
@@ -6095,7 +6102,7 @@ static struct sched_group **sched_group_
 static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
 static struct sched_group *sched_group_allnodes_bycpu[NR_CPUS];
 
-static int cpu_to_allnodes_group(int cpu)
+static int cpu_to_allnodes_group(int cpu, const cpumask_t *cpu_map)
 {
 	return cpu_to_node(cpu);
 }
@@ -6127,12 +6134,11 @@ next_sg:
 }
 #endif
 
+#ifdef CONFIG_NUMA
 /* Free memory allocated for various sched_group structures */
 static void free_sched_groups(const cpumask_t *cpu_map)
 {
-	int cpu;
-#ifdef CONFIG_NUMA
-	int i;
+	int cpu, i;
 
 	for_each_cpu_mask(cpu, *cpu_map) {
 		struct sched_group *sched_group_allnodes
@@ -6169,20 +6175,12 @@ next_sg:
 		kfree(sched_group_nodes);
 		sched_group_nodes_bycpu[cpu] = NULL;
 	}
-#endif
-	for_each_cpu_mask(cpu, *cpu_map) {
-		if (sched_group_phys_bycpu[cpu]) {
-			kfree(sched_group_phys_bycpu[cpu]);
-			sched_group_phys_bycpu[cpu] = NULL;
-		}
-#ifdef CONFIG_SCHED_MC
-		if (sched_group_core_bycpu[cpu]) {
-			kfree(sched_group_core_bycpu[cpu]);
-			sched_group_core_bycpu[cpu] = NULL;
-		}
-#endif
-	}
 }
+#else
+static void free_sched_groups(const cpumask_t *cpu_map)
+{
+}
+#endif
 
 /*
  * Build sched domains for a given set of cpus and attach the sched domains
@@ -6191,10 +6189,6 @@ next_sg:
 static int build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
-	struct sched_group *sched_group_phys = NULL;
-#ifdef CONFIG_SCHED_MC
-	struct sched_group *sched_group_core = NULL;
-#endif
 #ifdef CONFIG_NUMA
 	struct sched_group **sched_group_nodes = NULL;
 	struct sched_group *sched_group_allnodes = NULL;
@@ -6240,7 +6234,7 @@ static int build_sched_domains(const cpu
 			sd = &per_cpu(allnodes_domains, i);
 			*sd = SD_ALLNODES_INIT;
 			sd->span = *cpu_map;
-			group = cpu_to_allnodes_group(i);
+			group = cpu_to_allnodes_group(i, cpu_map);
 			sd->groups = &sched_group_allnodes[group];
 			p = sd;
 		} else
@@ -6253,42 +6247,18 @@ static int build_sched_domains(const cpu
 		cpus_and(sd->span, sd->span, *cpu_map);
 #endif
 
-		if (!sched_group_phys) {
-			sched_group_phys
-				= kmalloc(sizeof(struct sched_group) * NR_CPUS,
-					  GFP_KERNEL);
-			if (!sched_group_phys) {
-				printk (KERN_WARNING "Can not alloc phys sched"
-						     "group\n");
-				goto error;
-			}
-			sched_group_phys_bycpu[i] = sched_group_phys;
-		}
-
 		p = sd;
 		sd = &per_cpu(phys_domains, i);
-		group = cpu_to_phys_group(i);
+		group = cpu_to_phys_group(i, cpu_map);
 		*sd = SD_CPU_INIT;
 		sd->span = nodemask;
 		sd->parent = p;
 		sd->groups = &sched_group_phys[group];
 
 #ifdef CONFIG_SCHED_MC
-		if (!sched_group_core) {
-			sched_group_core
-				= kmalloc(sizeof(struct sched_group) * NR_CPUS,
-					  GFP_KERNEL);
-			if (!sched_group_core) {
-				printk (KERN_WARNING "Can not alloc core sched"
-						     "group\n");
-				goto error;
-			}
-			sched_group_core_bycpu[i] = sched_group_core;
-		}
-
 		p = sd;
 		sd = &per_cpu(core_domains, i);
-		group = cpu_to_core_group(i);
+		group = cpu_to_core_group(i, cpu_map);
 		*sd = SD_MC_INIT;
 		sd->span = cpu_coregroup_map(i);
 		cpus_and(sd->span, sd->span, *cpu_map);
@@ -6299,7 +6269,7 @@ static int build_sched_domains(const cpu
 #ifdef CONFIG_SCHED_SMT
 		p = sd;
 		sd = &per_cpu(cpu_domains, i);
-		group = cpu_to_cpu_group(i);
+		group = cpu_to_cpu_group(i, cpu_map);
 		*sd = SD_SIBLING_INIT;
 		sd->span = cpu_sibling_map[i];
 		cpus_and(sd->span, sd->span, *cpu_map);
@@ -6317,7 +6287,7 @@ static int build_sched_domains(const cpu
 			continue;
 
 		init_sched_build_groups(sched_group_cpus, this_sibling_map,
-						&cpu_to_cpu_group);
+					cpu_map, &cpu_to_cpu_group);
 	}
 #endif
 
@@ -6329,7 +6299,7 @@ static int build_sched_domains(const cpu
 		if (i != first_cpu(this_core_map))
 			continue;
 		init_sched_build_groups(sched_group_core, this_core_map,
-					&cpu_to_core_group);
+					cpu_map, &cpu_to_core_group);
 	}
 #endif
 
@@ -6343,14 +6313,14 @@ static int build_sched_domains(const cpu
 			continue;
 
 		init_sched_build_groups(sched_group_phys, nodemask,
-						&cpu_to_phys_group);
+					cpu_map, &cpu_to_phys_group);
 	}
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
 	if (sched_group_allnodes)
 		init_sched_build_groups(sched_group_allnodes, *cpu_map,
-					&cpu_to_allnodes_group);
+					cpu_map, &cpu_to_allnodes_group);
 
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		/* Set up node groups */
@@ -6516,9 +6486,11 @@ static int build_sched_domains(const cpu
 
 	return 0;
 
+#ifdef CONFIG_NUMA
 error:
 	free_sched_groups(cpu_map);
 	return -ENOMEM;
+#endif
 }
 /*
  * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
