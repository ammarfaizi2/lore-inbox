Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268538AbUIGS4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268538AbUIGS4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268401AbUIGSyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:54:11 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23234 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268532AbUIGSuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:50:00 -0400
Message-Id: <200409071849.i87Inw3f143238@austin.ibm.com>
Subject: [patch 2/2] cpu hotplug notifier for updating sched domains
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rusty@rustcorp.com.au, piggin@cyberone.com.au,
       nathanl@austin.ibm.com
From: nathanl@austin.ibm.com
Date: Tue,  7 Sep 2004 13:50:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Register a cpu hotplug notifier which reinitializes the scheduler
domains hierarchy.  The notifier temporarily attaches all running cpus
to a "dummy" domain (like we currently do during boot) to avoid
balancing.  It then calls arch_init_sched_domains which rebuilds the
"real" domains and reattaches the cpus to them.

Also change __init attributes to __devinit where necessary.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN kernel/sched.c~sched-domains-cpu-hotplug-notifier kernel/sched.c
--- 2.6.9-rc1-bk14/kernel/sched.c~sched-domains-cpu-hotplug-notifier	2004-09-07 13:32:50.000000000 -0500
+++ 2.6.9-rc1-bk14-nathanl/kernel/sched.c	2004-09-07 13:34:38.000000000 -0500
@@ -4191,7 +4191,10 @@ spinlock_t kernel_flag __cacheline_align
 EXPORT_SYMBOL(kernel_flag);
 
 #ifdef CONFIG_SMP
-/* Attach the domain 'sd' to 'cpu' as its base domain */
+/*
+ * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
+ * hold the cpu_control_semaphore.
+ */
 static void cpu_attach_domain(struct sched_domain *sd, int cpu)
 {
 	migration_req_t req;
@@ -4199,8 +4202,6 @@ static void cpu_attach_domain(struct sch
 	runqueue_t *rq = cpu_rq(cpu);
 	int local = 1;
 
-	lock_cpu_hotplug();
-
 	spin_lock_irqsave(&rq->lock, flags);
 
 	if (cpu == smp_processor_id() || !cpu_online(cpu)) {
@@ -4219,8 +4220,6 @@ static void cpu_attach_domain(struct sch
 		wake_up_process(rq->migration_thread);
 		wait_for_completion(&req.done);
 	}
-
-	unlock_cpu_hotplug();
 }
 
 #ifdef CONFIG_NUMA
@@ -4234,7 +4233,7 @@ static void cpu_attach_domain(struct sch
  *
  * Should use nodemask_t.
  */
-static int __init find_next_best_node(int node, unsigned long *used_nodes)
+static int __devinit find_next_best_node(int node, unsigned long *used_nodes)
 {
 	int i, n, val, min_val, best_node = 0;
 
@@ -4270,7 +4269,7 @@ static int __init find_next_best_node(in
  * should be one that prevents unnecessary balancing, but also spreads tasks
  * out optimally.
  */
-cpumask_t __init sched_domain_node_span(int node, int size)
+cpumask_t __devinit sched_domain_node_span(int node, int size)
 {
 	int i;
 	cpumask_t span;
@@ -4294,7 +4293,7 @@ cpumask_t __init sched_domain_node_span(
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
 static struct sched_group sched_group_cpus[NR_CPUS];
-__init static int cpu_to_cpu_group(int cpu)
+static int __devinit cpu_to_cpu_group(int cpu)
 {
 	return cpu;
 }
@@ -4302,7 +4301,7 @@ __init static int cpu_to_cpu_group(int c
 
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
 static struct sched_group sched_group_phys[NR_CPUS];
-__init static int cpu_to_phys_group(int cpu)
+static int __devinit cpu_to_phys_group(int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
 	return first_cpu(cpu_sibling_map[cpu]);
@@ -4318,7 +4317,7 @@ __init static int cpu_to_phys_group(int 
 
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
 static struct sched_group sched_group_nodes[MAX_NUMNODES];
-__init static int cpu_to_node_group(int cpu)
+static int __devinit cpu_to_node_group(int cpu)
 {
 	return cpu_to_node(cpu);
 }
@@ -4328,9 +4327,9 @@ __init static int cpu_to_node_group(int 
 static struct sched_group sched_group_isolated[NR_CPUS];
 
 /* cpus with isolated domains */
-cpumask_t __initdata cpu_isolated_map = CPU_MASK_NONE;
+cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
 
-__init static int cpu_to_isolated_group(int cpu)
+static int __devinit cpu_to_isolated_group(int cpu)
 {
 	return cpu;
 }
@@ -4360,7 +4359,7 @@ __setup ("isolcpus=", isolated_cpu_setup
  * covered by the given span, and will set each group's ->cpumask correctly,
  * and ->cpu_power to 0.
  */
-__init static void init_sched_build_groups(struct sched_group groups[],
+static void __devinit init_sched_build_groups(struct sched_group groups[],
 			cpumask_t span, int (*group_fn)(int cpu))
 {
 	struct sched_group *first = NULL, *last = NULL;
@@ -4394,7 +4393,11 @@ __init static void init_sched_build_grou
 	last->next = first;
 }
 
-__init static void arch_init_sched_domains(cpumask_t cpu_default_map)
+/*
+ * Set up scheduler domains and groups.  Callers must hold the cpucontrol
+ * semaphore.
+ */
+static void __devinit arch_init_sched_domains(cpumask_t cpu_default_map)
 {
 	int i;
 	/*
@@ -4630,10 +4633,61 @@ void sched_domain_debug(void)
 #define sched_domain_debug() {}
 #endif
 
+#ifdef CONFIG_SMP
+/* Initial dummy domain for early boot and for hotplug cpu */
+static struct sched_domain sched_domain_dummy;
+static struct sched_group sched_group_dummy;
+#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * Force a reinitialization of the sched domains hierarchy.  The domains
+ * and groups cannot be updated in place without racing with the balancing
+ * code, so we temporarily attach all running cpus to a "dummy" domain
+ * which will prevent rebalancing while the sched domains are recalculated.
+ */
+static int update_sched_domains(struct notifier_block *nfb,
+				unsigned long action, void *hcpu)
+{
+	cpumask_t new_cpu_map = cpu_online_map;
+	int i, cpu = (long)hcpu;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		cpu_set(cpu, new_cpu_map);
+		break;
+	case CPU_UP_CANCELED: /* fall through */
+	case CPU_DEAD:
+		/*
+		 * No need to clear the dead cpu's bit, it has
+		 * already been marked offline.
+		 */
+		cpu_attach_domain(&sched_domain_dummy, cpu);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	for_each_online_cpu(i)
+		cpu_attach_domain(&sched_domain_dummy, i);
+
+	/* The cpucontrol semaphore is already held by cpu_up/cpu_down */
+	arch_init_sched_domains(new_cpu_map);
+
+	sched_domain_debug();
+
+	return NOTIFY_OK;
+}
+#endif
+
 void __init sched_init_smp(void)
 {
+	lock_cpu_hotplug();
 	arch_init_sched_domains(cpu_online_map);
 	sched_domain_debug();
+	unlock_cpu_hotplug();
+
+	hotcpu_notifier(update_sched_domains, 0);
 }
 #else
 void __init sched_init_smp(void)
@@ -4656,20 +4710,18 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	/* Set up an initial dummy domain for early boot */
-	static struct sched_domain sched_domain_init;
-	static struct sched_group sched_group_init;
 
-	memset(&sched_domain_init, 0, sizeof(struct sched_domain));
-	sched_domain_init.span = CPU_MASK_ALL;
-	sched_domain_init.groups = &sched_group_init;
-	sched_domain_init.last_balance = jiffies;
-	sched_domain_init.balance_interval = INT_MAX; /* Don't balance */
-	sched_domain_init.busy_factor = 1;
-
-	memset(&sched_group_init, 0, sizeof(struct sched_group));
-	sched_group_init.cpumask = CPU_MASK_ALL;
-	sched_group_init.next = &sched_group_init;
-	sched_group_init.cpu_power = SCHED_LOAD_SCALE;
+	memset(&sched_domain_dummy, 0, sizeof(struct sched_domain));
+	sched_domain_dummy.span = CPU_MASK_ALL;
+	sched_domain_dummy.groups = &sched_group_dummy;
+	sched_domain_dummy.last_balance = jiffies;
+	sched_domain_dummy.balance_interval = INT_MAX; /* Don't balance */
+	sched_domain_dummy.busy_factor = 1;
+
+	memset(&sched_group_dummy, 0, sizeof(struct sched_group));
+	sched_group_dummy.cpumask = CPU_MASK_ALL;
+	sched_group_dummy.next = &sched_group_dummy;
+	sched_group_dummy.cpu_power = SCHED_LOAD_SCALE;
 #endif
 
 	for (i = 0; i < NR_CPUS; i++) {
@@ -4682,7 +4734,7 @@ void __init sched_init(void)
 		rq->best_expired_prio = MAX_PRIO;
 
 #ifdef CONFIG_SMP
-		rq->sd = &sched_domain_init;
+		rq->sd = &sched_domain_dummy;
 		rq->cpu_load = 0;
 		rq->active_balance = 0;
 		rq->push_cpu = 0;

_
