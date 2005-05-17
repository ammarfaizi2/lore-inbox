Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVEQEKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVEQEKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVEQEJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:09:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17102 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261200AbVEQEGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:06:53 -0400
Date: Tue, 17 May 2005 09:40:31 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [RFT PATCH] Dynamic sched domains (v0.6)
Message-ID: <20050517041031.GA4596@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Ok, here is hopefully the last iteration of the dynamic sched domain
patches before I can send it off to Andrew.
I would have posted it earlier, except I got sidetracked with all
the hotplug+preempt issues. cpusets+hotplug+preempt requires more
testing and I'll post those patches sometime later in the week

patch1 - sched.c+sched.h changes
patch2 - cpuset.c+Documentation changes
patch3 - ia64 changes

All patches are against 2.6.12-rc4-mm1 and have been tested
(except for the ia64 changes)

 linux-2.6.12-rc4-mm1-1/include/linux/sched.h     |    2
 linux-2.6.12-rc4-mm1-1/kernel/sched.c            |  131 +++++++++++++++--------
 linux-2.6.12-rc4-mm1-2/Documentation/cpusets.txt |   16 ++
 linux-2.6.12-rc4-mm1-2/kernel/cpuset.c           |   89 ++++++++++++---
 linux-2.6.12-rc4-mm1-3/arch/ia64/kernel/domain.c |   77 ++++++++-----
 5 files changed, 225 insertions(+), 90 deletions(-)

o Patch1 adds the new API partition_sched_domains.
  I have incorporated all of the feedback from before.
o I didnt think it necessary to add another semaphore to protect the sched domain
  changes as suggested by Nick. As it was clear last week, hotplug+cpusets
  causes enough issues with nested sems, so I didnt want to add yet another in
  the mix
o I have removed the __devinit qualifier from some functions which will
  now get called anytime changes are made to exclusive cpusets instead of
  only during boot
o arch_init_sched_domains/arch_destroy_sched_domains now take a pointer
  to a const cpumask_t * type.

	-Dinakar

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd-rc4mm1-v0.6-1.patch"

diff -Naurp linux-2.6.12-rc4-mm1-0/include/linux/sched.h linux-2.6.12-rc4-mm1-1/include/linux/sched.h
--- linux-2.6.12-rc4-mm1-0/include/linux/sched.h	2005-05-16 14:55:43.000000000 +0530
+++ linux-2.6.12-rc4-mm1-1/include/linux/sched.h	2005-05-16 15:13:22.000000000 +0530
@@ -561,6 +561,8 @@ struct sched_domain {
 #endif
 };
 
+extern void partition_sched_domains(cpumask_t *partition1, 
+				    cpumask_t *partition2);
 #ifdef ARCH_HAS_SCHED_DOMAIN
 /* Useful helpers that arch setup code may use. Defined in kernel/sched.c */
 extern cpumask_t cpu_isolated_map;
diff -Naurp linux-2.6.12-rc4-mm1-0/kernel/sched.c linux-2.6.12-rc4-mm1-1/kernel/sched.c
--- linux-2.6.12-rc4-mm1-0/kernel/sched.c	2005-05-16 14:58:01.000000000 +0530
+++ linux-2.6.12-rc4-mm1-1/kernel/sched.c	2005-05-16 19:21:27.000000000 +0530
@@ -264,7 +264,7 @@ static DEFINE_PER_CPU(struct runqueue, r
 
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
- * See update_sched_domains: synchronize_kernel for details.
+ * See detach_destroy_domains: synchronize_sched for details.
  *
  * The domain tree of any CPU may only be accessed from within
  * preempt-disabled sections.
@@ -4615,7 +4615,7 @@ int __init migration_init(void)
 #endif
 
 #ifdef CONFIG_SMP
-#define SCHED_DOMAIN_DEBUG
+#undef SCHED_DOMAIN_DEBUG
 #ifdef SCHED_DOMAIN_DEBUG
 static void sched_domain_debug(struct sched_domain *sd, int cpu)
 {
@@ -4831,7 +4831,7 @@ static void init_sched_domain_sysctl(voi
 }
 #endif
 
-static int __devinit sd_degenerate(struct sched_domain *sd)
+static int sd_degenerate(struct sched_domain *sd)
 {
 	if (cpus_weight(sd->span) == 1)
 		return 1;
@@ -4854,7 +4854,7 @@ static int __devinit sd_degenerate(struc
 	return 1;
 }
 
-static int __devinit sd_parent_degenerate(struct sched_domain *sd,
+static int sd_parent_degenerate(struct sched_domain *sd,
 						struct sched_domain *parent)
 {
 	unsigned long cflags = sd->flags, pflags = parent->flags;
@@ -4886,7 +4886,7 @@ static int __devinit sd_parent_degenerat
  * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
  * hold the hotplug lock.
  */
-void __devinit cpu_attach_domain(struct sched_domain *sd, int cpu)
+void cpu_attach_domain(struct sched_domain *sd, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
@@ -4937,7 +4937,7 @@ __setup ("isolcpus=", isolated_cpu_setup
  * covered by the given span, and will set each group's ->cpumask correctly,
  * and ->cpu_power to 0.
  */
-void __devinit init_sched_build_groups(struct sched_group groups[],
+void init_sched_build_groups(struct sched_group groups[],
 			cpumask_t span, int (*group_fn)(int cpu))
 {
 	struct sched_group *first = NULL, *last = NULL;
@@ -4973,13 +4973,14 @@ void __devinit init_sched_build_groups(s
 
 
 #ifdef ARCH_HAS_SCHED_DOMAIN
-extern void __devinit arch_init_sched_domains(void);
-extern void __devinit arch_destroy_sched_domains(void);
+extern void build_sched_domains(const cpumask_t *cpu_map);
+extern void arch_init_sched_domains(const cpumask_t *cpu_map);
+extern void arch_destroy_sched_domains(const cpumask_t *cpu_map);
 #else
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
 static struct sched_group sched_group_cpus[NR_CPUS];
-static int __devinit cpu_to_cpu_group(int cpu)
+static int cpu_to_cpu_group(int cpu)
 {
 	return cpu;
 }
@@ -4987,7 +4988,7 @@ static int __devinit cpu_to_cpu_group(in
 
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
 static struct sched_group sched_group_phys[NR_CPUS];
-static int __devinit cpu_to_phys_group(int cpu)
+static int cpu_to_phys_group(int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
 	return first_cpu(cpu_sibling_map[cpu]);
@@ -5000,7 +5001,7 @@ static int __devinit cpu_to_phys_group(i
 
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
 static struct sched_group sched_group_nodes[MAX_NUMNODES];
-static int __devinit cpu_to_node_group(int cpu)
+static int cpu_to_node_group(int cpu)
 {
 	return cpu_to_node(cpu);
 }
@@ -5031,39 +5032,28 @@ static void check_sibling_maps(void)
 #endif
 
 /*
- * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
+ * Build sched domains for a given set of cpus and attach the sched domains
+ * to the individual cpus
  */
-static void __devinit arch_init_sched_domains(void)
+static void build_sched_domains(const cpumask_t *cpu_map)
 {
 	int i;
-	cpumask_t cpu_default_map;
 
-#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
-	check_sibling_maps();
-#endif
 	/*
-	 * Setup mask for cpus without special case scheduling requirements.
-	 * For now this just excludes isolated cpus, but could be used to
-	 * exclude other special cases in the future.
+	 * Set up domains for cpus specified by the cpu_map.
 	 */
-	cpus_complement(cpu_default_map, cpu_isolated_map);
-	cpus_and(cpu_default_map, cpu_default_map, cpu_online_map);
-
-	/*
-	 * Set up domains. Isolated domains just stay on the NULL domain.
-	 */
-	for_each_cpu_mask(i, cpu_default_map) {
+	for_each_cpu_mask(i, *cpu_map) {
 		int group;
 		struct sched_domain *sd = NULL, *p;
 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+		cpus_and(nodemask, nodemask, *cpu_map);
 
 #ifdef CONFIG_NUMA
 		sd = &per_cpu(node_domains, i);
 		group = cpu_to_node_group(i);
 		*sd = SD_NODE_INIT;
-		sd->span = cpu_default_map;
+		sd->span = *cpu_map;
 		sd->groups = &sched_group_nodes[group];
 #endif
 
@@ -5081,7 +5071,7 @@ static void __devinit arch_init_sched_do
 		group = cpu_to_cpu_group(i);
 		*sd = SD_SIBLING_INIT;
 		sd->span = cpu_sibling_map[i];
-		cpus_and(sd->span, sd->span, cpu_default_map);
+		cpus_and(sd->span, sd->span, *cpu_map);
 		sd->parent = p;
 		sd->groups = &sched_group_cpus[group];
 #endif
@@ -5091,7 +5081,7 @@ static void __devinit arch_init_sched_do
 	/* Set up CPU (sibling) groups */
 	for_each_online_cpu(i) {
 		cpumask_t this_sibling_map = cpu_sibling_map[i];
-		cpus_and(this_sibling_map, this_sibling_map, cpu_default_map);
+		cpus_and(this_sibling_map, this_sibling_map, *cpu_map);
 		if (i != first_cpu(this_sibling_map))
 			continue;
 
@@ -5104,7 +5094,7 @@ static void __devinit arch_init_sched_do
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+		cpus_and(nodemask, nodemask, *cpu_map);
 		if (cpus_empty(nodemask))
 			continue;
 
@@ -5114,12 +5104,12 @@ static void __devinit arch_init_sched_do
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
-	init_sched_build_groups(sched_group_nodes, cpu_default_map,
+	init_sched_build_groups(sched_group_nodes, *cpu_map,
 					&cpu_to_node_group);
 #endif
 
 	/* Calculate CPU power for physical packages and nodes */
-	for_each_cpu_mask(i, cpu_default_map) {
+	for_each_cpu_mask(i, *cpu_map) {
 		int power;
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
@@ -5143,7 +5133,7 @@ static void __devinit arch_init_sched_do
 	}
 
 	/* Attach the domains */
-	for_each_online_cpu(i) {
+	for_each_cpu_mask(i, *cpu_map) {
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
 		sd = &per_cpu(cpu_domains, i);
@@ -5153,16 +5143,72 @@ static void __devinit arch_init_sched_do
 		cpu_attach_domain(sd, i);
 	}
 }
+/*
+ * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
+ */
+static void arch_init_sched_domains(cpumask_t *cpu_map)
+{
+	cpumask_t cpu_default_map;
 
-#ifdef CONFIG_HOTPLUG_CPU
-static void __devinit arch_destroy_sched_domains(void)
+#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
+	check_sibling_maps();
+#endif
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
+
+static void arch_destroy_sched_domains(const cpumask_t *cpu_map)
 {
 	/* Do nothing: everything is statically allocated. */
 }
-#endif
 
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 
+/*
+ * Detach sched domains from a group of cpus specified in cpu_map
+ * These cpus will now be attached to the NULL domain
+ */
+static inline void detach_destroy_domains(const cpumask_t *cpu_map)
+{
+	int i;
+
+	for_each_cpu_mask(i, *cpu_map)
+		cpu_attach_domain(NULL, i);
+	synchronize_sched();
+	arch_destroy_sched_domains(cpu_map);
+}
+
+/*
+ * Partition sched domains as specified by the cpumasks below.
+ * This attaches all cpus from the cpumasks to the NULL domain,
+ * waits for a RCU quiescent period, recalculates sched
+ * domain information and then attaches them back to the
+ * correct sched domains
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(cpumask_t *partition1, cpumask_t *partition2)
+{
+	cpumask_t change_map;
+
+	cpus_and(*partition1, *partition1, cpu_online_map);
+	cpus_and(*partition2, *partition2, cpu_online_map);
+	cpus_or(change_map, *partition1, *partition2);
+
+	/* Detach sched domains from all of the affected cpus */
+	detach_destroy_domains(&change_map);
+	if (!cpus_empty(*partition1))
+		build_sched_domains(partition1);
+	if (!cpus_empty(*partition2))
+		build_sched_domains(partition2);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * Force a reinitialization of the sched domains hierarchy.  The domains
@@ -5178,10 +5224,7 @@ static int update_sched_domains(struct n
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_DOWN_PREPARE:
-		for_each_online_cpu(i)
-			cpu_attach_domain(NULL, i);
-		synchronize_kernel();
-		arch_destroy_sched_domains();
+		detach_destroy_domains(&cpu_online_map);
 		return NOTIFY_OK;
 
 	case CPU_UP_CANCELED:
@@ -5197,7 +5240,7 @@ static int update_sched_domains(struct n
 	}
 
 	/* The hotplug lock is already held by cpu_up/cpu_down */
-	arch_init_sched_domains();
+	arch_init_sched_domains(&cpu_online_map);
 
 	return NOTIFY_OK;
 }
@@ -5206,7 +5249,7 @@ static int update_sched_domains(struct n
 void __init sched_init_smp(void)
 {
 	lock_cpu_hotplug();
-	arch_init_sched_domains();
+	arch_init_sched_domains(&cpu_online_map);
 	unlock_cpu_hotplug();
 	/* XXX: Theoretical race here - CPU may be hotplugged now */
 	hotcpu_notifier(update_sched_domains, 0);

--zhXaljGHf11kAtnf--
