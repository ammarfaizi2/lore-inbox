Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVHTOue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVHTOue (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 10:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVHTOue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 10:50:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56551 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751253AbVHTOud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 10:50:33 -0400
Date: Sat, 20 Aug 2005 07:50:16 -0700
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, pj@sgi.com, dino@in.ibm.com, nickpiggin@yahoo.com.au,
       akpm@osdl.org
Subject: [PATCH] ia64 cpuset + build_sched_domains() mangles structures
Message-ID: <43074328.MailOXV1UXUHF@jackhammer.engr.sgi.com>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: hawkes@jackhammer.engr.sgi.com (John Hawkes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Index: linux/arch/ia64/kernel/domain.c
===================================================================
--- linux.orig/arch/ia64/kernel/domain.c	2005-08-19 08:54:00.000000000 -0700
+++ linux/arch/ia64/kernel/domain.c	2005-08-20 07:39:32.000000000 -0700
@@ -120,10 +120,10 @@
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
@@ -138,6 +138,21 @@
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
@@ -150,8 +165,21 @@
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
@@ -214,8 +242,9 @@
 	}
 
 #ifdef CONFIG_NUMA
-	init_sched_build_groups(sched_group_allnodes, *cpu_map,
-				&cpu_to_allnodes_group);
+	if (sched_group_allnodes)
+		init_sched_build_groups(sched_group_allnodes, *cpu_map,
+					&cpu_to_allnodes_group);
 
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		/* Set up node groups */
@@ -226,8 +255,10 @@
 		int j;
 
 		cpus_and(nodemask, nodemask, *cpu_map);
-		if (cpus_empty(nodemask))
+		if (cpus_empty(nodemask)) {
+			sched_group_nodes[i] = NULL;
 			continue;
+		}
 
 		domainspan = sched_domain_node_span(i);
 		cpus_and(domainspan, domainspan, *cpu_map);
@@ -341,7 +372,7 @@
 #endif
 
 	/* Attach the domains */
-	for_each_online_cpu(i) {
+	for_each_cpu_mask(i, *cpu_map) {
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
 		sd = &per_cpu(cpu_domains, i);
@@ -372,25 +403,42 @@
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
-
