Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWCYI2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWCYI2c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 03:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWCYI2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 03:28:32 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:55946 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750986AbWCYI2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 03:28:30 -0500
Date: Sat, 25 Mar 2006 13:58:04 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       pj@sgi.com
Cc: hawkes@sgi.com, Dinakar Guniguntala <dino@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: [PATCH 2.6.16-mm1 2/2] sched_domains: Allocate sched_groups dynamically
Message-ID: <20060325082804.GB17011@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hit a kernel lockup problem while making a CPUset exclusive. This was
also reported before:

	http://lkml.org/lkml/2006/3/16/128  (Ref 1)

Dinakar (CCed here) said that it may be similar to the problem reported
here:
	
	http://lkml.org/lkml/2005/8/20/40   (Ref 2)

Upon code inspection, I found that it is indeed a similar problem for
SCHED_SMT case. The problem is recreated if SCHED_SMT is enabled in the
kernel, and one tries to make a exclusive CPUset with just one thread in
it. This cause the two threads of the same CPU to be in in different
dynamic sched domains, although they share the same sched_group
structure at 'phys_domains' level. This will lead to the same kind of
corruption described in Ref 2 above.

Patch below, against 2.6.16-mm1, fixes the problem for both SCHED_SMT and 
SCHED_MC cases.

I have tested the patch on a 8-way (with HT) Intel Xeon machine and
found that the lockups I was facing earlier went away with the patch.

I couldn't test this on a multi-core machine, since I don't think we
have one in our lab.

Suresh, would you mind testing the patch on a multi-core machine, in case you 
have access to one?

Basically you would need to do create a exclusive CPUset with one CPU in it 
(ensure that its sibling in the same core is not part of the same
CPUset). As soon as you make the CPUset exclusive, you would hit some
kind of hang. With this patch, the hang should go away.



Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>



 kernel/sched.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 58 insertions(+), 9 deletions(-)

diff -puN kernel/sched.c~sd_dynschedgroups kernel/sched.c
--- linux-2.6.16-mm1/kernel/sched.c~sd_dynschedgroups	2006-03-25 11:45:05.000000000 +0530
+++ linux-2.6.16-mm1-root/kernel/sched.c	2006-03-25 13:30:01.000000000 +0530
@@ -5884,7 +5884,7 @@ static int cpu_to_cpu_group(int cpu)
 
 #ifdef CONFIG_SCHED_MC
 static DEFINE_PER_CPU(struct sched_domain, core_domains);
-static struct sched_group sched_group_core[NR_CPUS];
+static struct sched_group *sched_group_core_bycpu[NR_CPUS];
 #endif
 
 #if defined(CONFIG_SCHED_MC) && defined(CONFIG_SCHED_SMT)
@@ -5900,7 +5900,7 @@ static int cpu_to_core_group(int cpu)
 #endif
 
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
-static struct sched_group sched_group_phys[NR_CPUS];
+static struct sched_group *sched_group_phys_bycpu[NR_CPUS];
 static int cpu_to_phys_group(int cpu)
 {
 #if defined(CONFIG_SCHED_MC)
@@ -5963,7 +5963,12 @@ next_sg:
  */
 void build_sched_domains(const cpumask_t *cpu_map)
 {
-	int i;
+	int i, alloc_phys_failed = 0;
+	struct sched_group *sched_group_phys = NULL;
+#ifdef CONFIG_SCHED_MC
+	int alloc_core_failed = 0;
+	struct sched_group *sched_group_core = NULL;
+#endif
 #ifdef CONFIG_NUMA
 	int alloc_failed = 0;
 	struct sched_group **sched_group_nodes = NULL;
@@ -6026,15 +6031,41 @@ void build_sched_domains(const cpumask_t
 		cpus_and(sd->span, sd->span, *cpu_map);
 #endif
 
+		if (!sched_group_phys && !alloc_phys_failed) {
+			sched_group_phys
+				= kmalloc(sizeof(struct sched_group) * NR_CPUS,
+					  GFP_KERNEL);
+			if (!sched_group_phys) {
+				printk (KERN_WARNING
+				"Can not alloc phys sched group\n");
+				alloc_phys_failed = 1;
+			}
+			sched_group_phys_bycpu[i] = sched_group_phys;
+		}
+
 		p = sd;
 		sd = &per_cpu(phys_domains, i);
 		group = cpu_to_phys_group(i);
 		*sd = SD_CPU_INIT;
 		sd->span = nodemask;
 		sd->parent = p;
-		sd->groups = &sched_group_phys[group];
+		sd->groups = sched_group_phys ? &sched_group_phys[group] : NULL;
+		if (!sd->groups)
+			sd->flags = 0;		/* No load balancing */
 
 #ifdef CONFIG_SCHED_MC
+		if (!sched_group_core && !alloc_core_failed) {
+			sched_group_core
+				 = kmalloc(sizeof(struct sched_group) * NR_CPUS,
+					   GFP_KERNEL);
+			if (!sched_group_core) {
+				printk (KERN_WARNING
+				"Can not alloc core sched group\n");
+				alloc_core_failed = 1;
+			}
+			sched_group_core_bycpu[i] = sched_group_core;
+		}
+
 		p = sd;
 		sd = &per_cpu(core_domains, i);
 		group = cpu_to_core_group(i);
@@ -6042,7 +6073,9 @@ void build_sched_domains(const cpumask_t
 		sd->span = cpu_coregroup_map(i);
 		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
-		sd->groups = &sched_group_core[group];
+		sd->groups = sched_group_core ? &sched_group_core[group] : NULL;
+		if (!sd->groups)
+			sd->flags = 0; 		/* No load balancing */
 #endif
 
 #ifdef CONFIG_SCHED_SMT
@@ -6077,8 +6110,9 @@ void build_sched_domains(const cpumask_t
 		cpus_and(this_core_map, this_core_map, *cpu_map);
 		if (i != first_cpu(this_core_map))
 			continue;
-		init_sched_build_groups(sched_group_core, this_core_map,
-					&cpu_to_core_group);
+		if (sched_group_core)
+			init_sched_build_groups(sched_group_core, this_core_map,
+						&cpu_to_core_group);
 	}
 #endif
 
@@ -6091,7 +6125,8 @@ void build_sched_domains(const cpumask_t
 		if (cpus_empty(nodemask))
 			continue;
 
-		init_sched_build_groups(sched_group_phys, nodemask,
+		if (sched_group_phys)
+			init_sched_build_groups(sched_group_phys, nodemask,
 						&cpu_to_phys_group);
 	}
 
@@ -6249,9 +6284,9 @@ static void arch_init_sched_domains(cons
 
 static void arch_destroy_sched_domains(const cpumask_t *cpu_map)
 {
+	int cpu;
 #ifdef CONFIG_NUMA
 	int i;
-	int cpu;
 
 	for_each_cpu_mask(cpu, *cpu_map) {
 		struct sched_group *sched_group_allnodes
@@ -6289,6 +6324,20 @@ next_sg:
 		sched_group_nodes_bycpu[cpu] = NULL;
 	}
 #endif
+	for_each_cpu_mask(cpu, *cpu_map) {
+		if (sched_group_phys_bycpu[cpu]) {
+			kfree(sched_group_phys_bycpu[cpu]);
+			sched_group_phys_bycpu[cpu] = NULL;
+		}
+	}
+#ifdef CONFIG_SCHED_MC
+	for_each_cpu_mask(cpu, *cpu_map) {
+		if (sched_group_core_bycpu[cpu]) {
+			kfree(sched_group_core_bycpu[cpu]);
+			sched_group_core_bycpu[cpu] = NULL;
+		}
+	}
+#endif
 }
 
 /*

_
_




	


-- 
Regards,
vatsa
