Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWDAS4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWDAS4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 13:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWDAS4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 13:56:48 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:19122 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932164AbWDAS4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 13:56:47 -0500
Date: Sun, 2 Apr 2006 00:26:44 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16-mm2 4/4] sched_domain: Allocate sched_group structures dynamically
Message-ID: <20060401185644.GC25971@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As explained here:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=114327539012323&w=2

there is a problem with sharing sched_group structures between two
different sched_domains.  This patch overcomes the problem by allocating 
separate sched_group structures for different sched_domains.

The patch has been tested and found to avoid the kernel lockup problem described
in above URL.


Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>


diff -puN kernel/sched.c~sd_dynschedgroup kernel/sched.c
--- linux-2.6.16-mm2/kernel/sched.c~sd_dynschedgroup	2006-04-01 23:40:56.000000000 +0530
+++ linux-2.6.16-mm2-root/kernel/sched.c	2006-04-01 23:40:56.000000000 +0530
@@ -5988,7 +5988,7 @@ static int cpu_to_cpu_group(int cpu)
 
 #ifdef CONFIG_SCHED_MC
 static DEFINE_PER_CPU(struct sched_domain, core_domains);
-static struct sched_group sched_group_core[NR_CPUS];
+static struct sched_group *sched_group_core_bycpu[NR_CPUS];
 #endif
 
 #if defined(CONFIG_SCHED_MC) && defined(CONFIG_SCHED_SMT)
@@ -6004,7 +6004,7 @@ static int cpu_to_core_group(int cpu)
 #endif
 
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-static struct sched_group sched_group_phys[NR_CPUS];
+static struct sched_group *sched_group_phys_bycpu[NR_CPUS];
 static int cpu_to_phys_group(int cpu)
 {
 #if defined(CONFIG_SCHED_MC)
@@ -6064,9 +6064,9 @@ next_sg:
 /* Free memory allocated for various sched_group structures */
 static void free_sched_groups(const cpumask_t *cpu_map)
 {
+	int cpu;
 #ifdef CONFIG_NUMA
 	int i;
-	int cpu;
 
 	for_each_cpu_mask(cpu, *cpu_map) {
 		struct sched_group *sched_group_allnodes
@@ -6104,6 +6104,18 @@ next_sg:
 		sched_group_nodes_bycpu[cpu] = NULL;
 	}
 #endif
+	for_each_cpu_mask(cpu, *cpu_map) {
+		if (sched_group_phys_bycpu[cpu]) {
+			kfree(sched_group_phys_bycpu[cpu]);
+			sched_group_phys_bycpu[cpu] = NULL;
+		}
+#ifdef CONFIG_SCHED_MC
+		if (sched_group_core_bycpu[cpu]) {
+			kfree(sched_group_core_bycpu[cpu]);
+			sched_group_core_bycpu[cpu] = NULL;
+		}
+#endif
+	}
 }
 
 /*
@@ -6113,6 +6125,10 @@ next_sg:
 static int build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
+	struct sched_group *sched_group_phys = NULL;
+#ifdef CONFIG_SCHED_MC
+	struct sched_group *sched_group_core = NULL;
+#endif
 #ifdef CONFIG_NUMA
 	struct sched_group **sched_group_nodes = NULL;
 	struct sched_group *sched_group_allnodes = NULL;
@@ -6171,6 +6187,18 @@ static int build_sched_domains(const cpu
 		cpus_and(sd->span, sd->span, *cpu_map);
 #endif
 
+		if (!sched_group_phys) {
+			sched_group_phys
+				= kmalloc(sizeof(struct sched_group) * NR_CPUS,
+					  GFP_KERNEL);
+			if (!sched_group_phys) {
+				printk (KERN_WARNING "Can not alloc phys sched"
+						     "group\n");
+				goto error;
+			}
+			sched_group_phys_bycpu[i] = sched_group_phys;
+		}
+
 		p = sd;
 		sd = &per_cpu(phys_domains, i);
 		group = cpu_to_phys_group(i);
@@ -6180,6 +6208,18 @@ static int build_sched_domains(const cpu
 		sd->groups = &sched_group_phys[group];
 
 #ifdef CONFIG_SCHED_MC
+		if (!sched_group_core) {
+			sched_group_core
+				= kmalloc(sizeof(struct sched_group) * NR_CPUS,
+					  GFP_KERNEL);
+			if (!sched_group_core) {
+				printk (KERN_WARNING "Can not alloc core sched"
+						     "group\n");
+				goto error;
+			}
+			sched_group_core_bycpu[i] = sched_group_core;
+		}
+		
 		p = sd;
 		sd = &per_cpu(core_domains, i);
 		group = cpu_to_core_group(i);
@@ -6375,11 +6415,9 @@ static int build_sched_domains(const cpu
 
 	return 0;
 
-#ifdef CONFIG_NUMA
 error:
 	free_sched_groups(cpu_map);
 	return -ENOMEM;
-#endif
 }
 /*
  * Set up scheduler domains and groups.  Callers must hold the hotplug lock.

_
-- 
Regards,
vatsa
