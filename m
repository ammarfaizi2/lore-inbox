Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVEQEIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVEQEIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVEQEIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:08:16 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46734 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261684AbVEQEGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:06:53 -0400
Date: Tue, 17 May 2005 09:44:21 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] Dynamic sched domains (v0.6)
Message-ID: <20050517041421.GC4596@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050517041031.GA4596@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20050517041031.GA4596@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


o Patch3 has the ia64 changes similar to kernel/sched.c
o This patch compiles ok, but has not been tested


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd-rc4mm1-v0.6-3.patch"

diff -Naurp linux-2.6.12-rc4-mm1-2/arch/ia64/kernel/domain.c linux-2.6.12-rc4-mm1-3/arch/ia64/kernel/domain.c
--- linux-2.6.12-rc4-mm1-2/arch/ia64/kernel/domain.c	2005-05-16 15:06:51.000000000 +0530
+++ linux-2.6.12-rc4-mm1-3/arch/ia64/kernel/domain.c	2005-05-16 17:21:56.000000000 +0530
@@ -27,7 +27,7 @@
  *
  * Should use nodemask_t.
  */
-static int __devinit find_next_best_node(int node, unsigned long *used_nodes)
+static int find_next_best_node(int node, unsigned long *used_nodes)
 {
 	int i, n, val, min_val, best_node = 0;
 
@@ -66,7 +66,7 @@ static int __devinit find_next_best_node
  * should be one that prevents unnecessary balancing, but also spreads tasks
  * out optimally.
  */
-static cpumask_t __devinit sched_domain_node_span(int node)
+static cpumask_t sched_domain_node_span(int node)
 {
 	int i;
 	cpumask_t span, nodemask;
@@ -96,7 +96,7 @@ static cpumask_t __devinit sched_domain_
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
 static struct sched_group sched_group_cpus[NR_CPUS];
-static int __devinit cpu_to_cpu_group(int cpu)
+static int cpu_to_cpu_group(int cpu)
 {
 	return cpu;
 }
@@ -104,7 +104,7 @@ static int __devinit cpu_to_cpu_group(in
 
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
 static struct sched_group sched_group_phys[NR_CPUS];
-static int __devinit cpu_to_phys_group(int cpu)
+static int cpu_to_phys_group(int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
 	return first_cpu(cpu_sibling_map[cpu]);
@@ -125,44 +125,36 @@ static struct sched_group *sched_group_n
 static DEFINE_PER_CPU(struct sched_domain, allnodes_domains);
 static struct sched_group sched_group_allnodes[MAX_NUMNODES];
 
-static int __devinit cpu_to_allnodes_group(int cpu)
+static int cpu_to_allnodes_group(int cpu)
 {
 	return cpu_to_node(cpu);
 }
 #endif
 
 /*
- * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
+ * Build sched domains for a given set of cpus and attach the sched domains
+ * to the individual cpus
  */
-void __devinit arch_init_sched_domains(void)
+void build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
-	cpumask_t cpu_default_map;
-
-	/*
-	 * Setup mask for cpus without special case scheduling requirements.
-	 * For now this just excludes isolated cpus, but could be used to
-	 * exclude other special cases in the future.
-	 */
-	cpus_complement(cpu_default_map, cpu_isolated_map);
-	cpus_and(cpu_default_map, cpu_default_map, cpu_online_map);
 
 	/*
-	 * Set up domains. Isolated domains just stay on the dummy domain.
+	 * Set up domains for cpus specified by the cpu_map.
 	 */
-	for_each_cpu_mask(i, cpu_default_map) {
+	for_each_cpu_mask(i, *cpu_map) {
 		int group;
 		struct sched_domain *sd = NULL, *p;
 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+		cpus_and(nodemask, nodemask, *cpu_map);
 
 #ifdef CONFIG_NUMA
 		if (num_online_cpus()
 				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
 			sd = &per_cpu(allnodes_domains, i);
 			*sd = SD_ALLNODES_INIT;
-			sd->span = cpu_default_map;
+			sd->span = *cpu_map;
 			group = cpu_to_allnodes_group(i);
 			sd->groups = &sched_group_allnodes[group];
 			p = sd;
@@ -173,7 +165,7 @@ void __devinit arch_init_sched_domains(v
 		*sd = SD_NODE_INIT;
 		sd->span = sched_domain_node_span(cpu_to_node(i));
 		sd->parent = p;
-		cpus_and(sd->span, sd->span, cpu_default_map);
+		cpus_and(sd->span, sd->span, *cpu_map);
 #endif
 
 		p = sd;
@@ -190,7 +182,7 @@ void __devinit arch_init_sched_domains(v
 		group = cpu_to_cpu_group(i);
 		*sd = SD_SIBLING_INIT;
 		sd->span = cpu_sibling_map[i];
-		cpus_and(sd->span, sd->span, cpu_default_map);
+		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
 		sd->groups = &sched_group_cpus[group];
 #endif
@@ -198,9 +190,9 @@ void __devinit arch_init_sched_domains(v
 
 #ifdef CONFIG_SCHED_SMT
 	/* Set up CPU (sibling) groups */
-	for_each_cpu_mask(i, cpu_default_map) {
+	for_each_cpu_mask(i, *cpu_map) {
 		cpumask_t this_sibling_map = cpu_sibling_map[i];
-		cpus_and(this_sibling_map, this_sibling_map, cpu_default_map);
+		cpus_and(this_sibling_map, this_sibling_map, *cpu_map);
 		if (i != first_cpu(this_sibling_map))
 			continue;
 
@@ -213,7 +205,7 @@ void __devinit arch_init_sched_domains(v
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+		cpus_and(nodemask, nodemask, *cpu_map);
 		if (cpus_empty(nodemask))
 			continue;
 
@@ -222,7 +214,7 @@ void __devinit arch_init_sched_domains(v
 	}
 
 #ifdef CONFIG_NUMA
-	init_sched_build_groups(sched_group_allnodes, cpu_default_map,
+	init_sched_build_groups(sched_group_allnodes, *cpu_map,
 				&cpu_to_allnodes_group);
 
 	for (i = 0; i < MAX_NUMNODES; i++) {
@@ -233,12 +225,12 @@ void __devinit arch_init_sched_domains(v
 		cpumask_t covered = CPU_MASK_NONE;
 		int j;
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+		cpus_and(nodemask, nodemask, *cpu_map);
 		if (cpus_empty(nodemask))
 			continue;
 
 		domainspan = sched_domain_node_span(i);
-		cpus_and(domainspan, domainspan, cpu_default_map);
+		cpus_and(domainspan, domainspan, *cpu_map);
 
 		sg = kmalloc(sizeof(struct sched_group), GFP_KERNEL);
 		sched_group_nodes[i] = sg;
@@ -266,7 +258,7 @@ void __devinit arch_init_sched_domains(v
 			int n = (i + j) % MAX_NUMNODES;
 
 			cpus_complement(notcovered, covered);
-			cpus_and(tmp, notcovered, cpu_default_map);
+			cpus_and(tmp, notcovered, *cpu_map);
 			cpus_and(tmp, tmp, domainspan);
 			if (cpus_empty(tmp))
 				break;
@@ -293,7 +285,7 @@ void __devinit arch_init_sched_domains(v
 #endif
 
 	/* Calculate CPU power for physical packages and nodes */
-	for_each_cpu_mask(i, cpu_default_map) {
+	for_each_cpu_mask(i, *cpu_map) {
 		int power;
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
@@ -359,13 +351,36 @@ next_sg:
 		cpu_attach_domain(sd, i);
 	}
 }
+/*
+ * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
+ */
+void arch_init_sched_domains(const cpumask_t *cpu_map)
+{
+	cpumask_t cpu_default_map;
+
+	/*
+	 * Setup mask for cpus without special case scheduling requirements.
+	 * For now this just excludes isolated cpus, but could be used to
+	 * exclude other special cases in the future.
+	 */
+	cpus_complement(cpu_default_map, cpu_isolated_map);
+	cpus_and(cpu_default_map, cpu_default_map, *cpu_map);
+
+	build_sched_domains(&cpu_default_map);
+}
 
-void __devinit arch_destroy_sched_domains(void)
+void arch_destroy_sched_domains(const cpumask_t *cpu_map)
 {
 #ifdef CONFIG_NUMA
 	int i;
 	for (i = 0; i < MAX_NUMNODES; i++) {
+		cpumask_t nodemask = node_to_cpumask(i);
 		struct sched_group *oldsg, *sg = sched_group_nodes[i];
+
+		cpus_and(nodemask, nodemask, *cpu_map);
+		if (cpus_empty(nodemask))
+			continue;
+
 		if (sg == NULL)
 			continue;
 		sg = sg->next;

--ABTtc+pdwF7KHXCz--
