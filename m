Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUIHOeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUIHOeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269149AbUIHOGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:06:46 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:25266 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267793AbUIHN6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:58:05 -0400
Message-ID: <413F01C7.3060008@yahoo.com.au>
Date: Wed, 08 Sep 2004 22:57:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Lynch <nathanl@austin.ibm.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] sched: cpu hotplug notifier for updating sched domains
References: <413EFFFB.5050902@yahoo.com.au> <413F0070.2020104@yahoo.com.au>
In-Reply-To: <413F0070.2020104@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020304020405010400020605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020304020405010400020605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/3

This builds on (and is mostly) Nathan's work. I have messed with a few
things though. It survives some cpu hotplugging on i386. Nathan, can you
give this a look? Do you agree with the general direction?

Thanks

--------------020304020405010400020605
Content-Type: text/x-patch;
 name="sched-domains-cpu-hotplug-notifier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-domains-cpu-hotplug-notifier.patch"



Register a cpu hotplug notifier which reinitializes the scheduler
domains hierarchy.  The notifier temporarily attaches all running cpus
to a "dummy" domain (like we currently do during boot) to avoid
balancing.  It then calls arch_init_sched_domains which rebuilds the
"real" domains and reattaches the cpus to them.

Also change __init attributes to __devinit where necessary.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


Alterations from Nick Piggin:
* Detach all domains in CPU_UP|DOWN_PREPARE notifiers. Reinitialise and
  reattach in CPU_ONLINE|DEAD|UP_CANCELED. This ensures the domains as
  seen from the scheduler won't become out of synch with the cpu_online_map.

* This allows us to remove runtime cpu_online verifications. Do that.

* Dummy domains are __devinitdata.

* Remove the hackery in arch_init_sched_domains to work around the fact that
  the domains used to work with cpu_possible maps, but node_to_cpumask returned
  a cpu_online map.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/kernel/sched.c |  167 ++++++++++++++++++++++-----------------
 1 files changed, 97 insertions(+), 70 deletions(-)

diff -puN kernel/sched.c~sched-domains-cpu-hotplug-notifier kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-domains-cpu-hotplug-notifier	2004-09-08 22:39:30.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-09-08 22:39:35.000000000 +1000
@@ -1015,8 +1015,7 @@ static int wake_idle(int cpu, task_t *p)
 	if (!(sd->flags & SD_WAKE_IDLE))
 		return cpu;
 
-	cpus_and(tmp, sd->span, cpu_online_map);
-	cpus_and(tmp, tmp, p->cpus_allowed);
+	cpus_and(tmp, sd->span, p->cpus_allowed);
 
 	for_each_cpu_mask(i, tmp) {
 		if (idle_cpu(i))
@@ -1530,8 +1529,7 @@ static int find_idlest_cpu(struct task_s
 	min_cpu = UINT_MAX;
 	min_load = ULONG_MAX;
 
-	cpus_and(mask, sd->span, cpu_online_map);
-	cpus_and(mask, mask, p->cpus_allowed);
+	cpus_and(mask, sd->span, p->cpus_allowed);
 
 	for_each_cpu_mask(i, mask) {
 		load = target_load(i);
@@ -1787,7 +1785,6 @@ find_busiest_group(struct sched_domain *
 	max_load = this_load = total_load = total_pwr = 0;
 
 	do {
-		cpumask_t tmp;
 		unsigned long load;
 		int local_group;
 		int i, nr_cpus = 0;
@@ -1796,11 +1793,8 @@ find_busiest_group(struct sched_domain *
 
 		/* Tally up the load of all CPUs in the group */
 		avg_load = 0;
-		cpus_and(tmp, group->cpumask, cpu_online_map);
-		if (unlikely(cpus_empty(tmp)))
-			goto nextgroup;
 
-		for_each_cpu_mask(i, tmp) {
+		for_each_cpu_mask(i, group->cpumask) {
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
 				load = target_load(i);
@@ -1919,13 +1913,11 @@ out_balanced:
  */
 static runqueue_t *find_busiest_queue(struct sched_group *group)
 {
-	cpumask_t tmp;
 	unsigned long load, max_load = 0;
 	runqueue_t *busiest = NULL;
 	int i;
 
-	cpus_and(tmp, group->cpumask, cpu_online_map);
-	for_each_cpu_mask(i, tmp) {
+	for_each_cpu_mask(i, group->cpumask) {
 		load = source_load(i);
 
 		if (load > max_load) {
@@ -2122,18 +2114,13 @@ static void active_load_balance(runqueue
 
 	group = sd->groups;
 	do {
-		cpumask_t tmp;
 		runqueue_t *rq;
 		int push_cpu = 0;
 
 		if (group == busy_group)
 			goto next_group;
 
-		cpus_and(tmp, group->cpumask, cpu_online_map);
-		if (!cpus_weight(tmp))
-			goto next_group;
-
-		for_each_cpu_mask(i, tmp) {
+		for_each_cpu_mask(i, group->cpumask) {
 			if (!idle_cpu(i))
 				goto next_group;
 			push_cpu = i;
@@ -2332,7 +2319,7 @@ static inline void wake_sleeping_depende
 	 */
 	spin_unlock(&this_rq->lock);
 
-	cpus_and(sibling_map, sd->span, cpu_online_map);
+	sibling_map = sd->span;
 
 	for_each_cpu_mask(i, sibling_map)
 		spin_lock(&cpu_rq(i)->lock);
@@ -2377,7 +2364,7 @@ static inline int dependent_sleeper(int 
 	 * wake_sleeping_dependent():
 	 */
 	spin_unlock(&this_rq->lock);
-	cpus_and(sibling_map, sd->span, cpu_online_map);
+	sibling_map = sd->span;
 	for_each_cpu_mask(i, sibling_map)
 		spin_lock(&cpu_rq(i)->lock);
 	cpu_clear(this_cpu, sibling_map);
@@ -4014,7 +4001,10 @@ spinlock_t kernel_flag __cacheline_align
 EXPORT_SYMBOL(kernel_flag);
 
 #ifdef CONFIG_SMP
-/* Attach the domain 'sd' to 'cpu' as its base domain */
+/*
+ * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
+ * hold the hotplug lock.
+ */
 static void cpu_attach_domain(struct sched_domain *sd, int cpu)
 {
 	migration_req_t req;
@@ -4022,8 +4012,6 @@ static void cpu_attach_domain(struct sch
 	runqueue_t *rq = cpu_rq(cpu);
 	int local = 1;
 
-	lock_cpu_hotplug();
-
 	spin_lock_irqsave(&rq->lock, flags);
 
 	if (cpu == smp_processor_id() || !cpu_online(cpu)) {
@@ -4042,8 +4030,6 @@ static void cpu_attach_domain(struct sch
 		wake_up_process(rq->migration_thread);
 		wait_for_completion(&req.done);
 	}
-
-	unlock_cpu_hotplug();
 }
 
 /*
@@ -4063,7 +4049,7 @@ static void cpu_attach_domain(struct sch
  *
  * Should use nodemask_t.
  */
-static int __init find_next_best_node(int node, unsigned long *used_nodes)
+static int __devinit find_next_best_node(int node, unsigned long *used_nodes)
 {
 	int i, n, val, min_val, best_node = 0;
 
@@ -4099,7 +4085,7 @@ static int __init find_next_best_node(in
  * should be one that prevents unnecessary balancing, but also spreads tasks
  * out optimally.
  */
-static cpumask_t __init sched_domain_node_span(int node)
+static cpumask_t __devinit sched_domain_node_span(int node)
 {
 	int i;
 	cpumask_t span;
@@ -4119,7 +4105,7 @@ static cpumask_t __init sched_domain_nod
 	return span;
 }
 #else /* SD_NODES_PER_DOMAIN */
-static cpumask_t __init sched_domain_node_span(int node)
+static cpumask_t __devinit sched_domain_node_span(int node)
 {
 	return cpu_possible_map;
 }
@@ -4129,7 +4115,7 @@ static cpumask_t __init sched_domain_nod
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
 static struct sched_group sched_group_cpus[NR_CPUS];
-__init static int cpu_to_cpu_group(int cpu)
+static int __devinit cpu_to_cpu_group(int cpu)
 {
 	return cpu;
 }
@@ -4137,7 +4123,7 @@ __init static int cpu_to_cpu_group(int c
 
 static DEFINE_PER_CPU(struct sched_domain, phys_domains);
 static struct sched_group sched_group_phys[NR_CPUS];
-__init static int cpu_to_phys_group(int cpu)
+static int __devinit cpu_to_phys_group(int cpu)
 {
 #ifdef CONFIG_SCHED_SMT
 	return first_cpu(cpu_sibling_map[cpu]);
@@ -4150,7 +4136,7 @@ __init static int cpu_to_phys_group(int 
 
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
 static struct sched_group sched_group_nodes[MAX_NUMNODES];
-__init static int cpu_to_node_group(int cpu)
+static int __devinit cpu_to_node_group(int cpu)
 {
 	return cpu_to_node(cpu);
 }
@@ -4160,9 +4146,9 @@ __init static int cpu_to_node_group(int 
 static struct sched_group sched_group_isolated[NR_CPUS];
 
 /* cpus with isolated domains */
-cpumask_t __initdata cpu_isolated_map = CPU_MASK_NONE;
+cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
 
-__init static int cpu_to_isolated_group(int cpu)
+static int __devinit cpu_to_isolated_group(int cpu)
 {
 	return cpu;
 }
@@ -4192,7 +4178,7 @@ __setup ("isolcpus=", isolated_cpu_setup
  * covered by the given span, and will set each group's ->cpumask correctly,
  * and ->cpu_power to 0.
  */
-__init static void init_sched_build_groups(struct sched_group groups[],
+static void __devinit init_sched_build_groups(struct sched_group groups[],
 			cpumask_t span, int (*group_fn)(int cpu))
 {
 	struct sched_group *first = NULL, *last = NULL;
@@ -4226,10 +4212,16 @@ __init static void init_sched_build_grou
 	last->next = first;
 }
 
-__init static void arch_init_sched_domains(void)
+/*
+ * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
+ */
+static void __devinit arch_init_sched_domains(void)
 {
 	int i;
 	cpumask_t cpu_default_map;
+	cpumask_t cpu_isolated_online_map;
+
+	cpus_and(cpu_isolated_online_map, cpu_isolated_map, cpu_online_map);
 
 	/*
 	 * Setup mask for cpus without special case scheduling requirements.
@@ -4237,10 +4229,10 @@ __init static void arch_init_sched_domai
 	 * exclude other special cases in the future.
 	 */
 	cpus_complement(cpu_default_map, cpu_isolated_map);
-	cpus_and(cpu_default_map, cpu_default_map, cpu_possible_map);
+	cpus_and(cpu_default_map, cpu_default_map, cpu_online_map);
 
 	/* Set up domains */
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		int group;
 		struct sched_domain *sd = NULL, *p;
 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
@@ -4252,7 +4244,7 @@ __init static void arch_init_sched_domai
 		 * Unlike those of other cpus, the domains and groups are
 		 * single level, and span a single cpu.
 		 */
-		if (cpu_isset(i, cpu_isolated_map)) {
+		if (cpu_isset(i, cpu_isolated_online_map)) {
 #ifdef CONFIG_SCHED_SMT
 			sd = &per_cpu(cpu_domains, i);
 #else
@@ -4283,11 +4275,7 @@ __init static void arch_init_sched_domai
 		sd = &per_cpu(phys_domains, i);
 		group = cpu_to_phys_group(i);
 		*sd = SD_CPU_INIT;
-#ifdef CONFIG_NUMA
 		sd->span = nodemask;
-#else
-		sd->span = cpu_possible_map;
-#endif
 		sd->parent = p;
 		sd->groups = &sched_group_phys[group];
 
@@ -4305,7 +4293,7 @@ __init static void arch_init_sched_domai
 
 #ifdef CONFIG_SCHED_SMT
 	/* Set up CPU (sibling) groups */
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		cpumask_t this_sibling_map = cpu_sibling_map[i];
 		cpus_and(this_sibling_map, this_sibling_map, cpu_default_map);
 		if (i != first_cpu(this_sibling_map))
@@ -4317,15 +4305,12 @@ __init static void arch_init_sched_domai
 #endif
 
 	/* Set up isolated groups */
-	for_each_cpu_mask(i, cpu_isolated_map) {
-		cpumask_t mask;
-		cpus_clear(mask);
-		cpu_set(i, mask);
+	for_each_cpu_mask(i, cpu_isolated_online_map) {
+		cpumask_t mask = cpumask_of_cpu(i);
 		init_sched_build_groups(sched_group_isolated, mask,
 						&cpu_to_isolated_group);
 	}
 
-#ifdef CONFIG_NUMA
 	/* Set up physical groups */
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
@@ -4337,10 +4322,6 @@ __init static void arch_init_sched_domai
 		init_sched_build_groups(sched_group_phys, nodemask,
 						&cpu_to_phys_group);
 	}
-#else
-	init_sched_build_groups(sched_group_phys, cpu_possible_map,
-							&cpu_to_phys_group);
-#endif
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
@@ -4373,7 +4354,7 @@ __init static void arch_init_sched_domai
 	}
 
 	/* Attach the domains */
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
 		sd = &per_cpu(cpu_domains, i);
@@ -4390,15 +4371,14 @@ void sched_domain_debug(void)
 {
 	int i;
 
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		runqueue_t *rq = cpu_rq(i);
 		struct sched_domain *sd;
 		int level = 0;
 
 		sd = rq->sd;
 
-		printk(KERN_DEBUG "CPU%d: %s\n",
-				i, (cpu_online(i) ? " online" : "offline"));
+		printk(KERN_DEBUG "CPU%d:\n", i);
 
 		do {
 			int j;
@@ -4464,10 +4444,59 @@ void sched_domain_debug(void)
 #define sched_domain_debug() {}
 #endif
 
+#ifdef CONFIG_SMP
+/* Initial dummy domain for early boot and for hotplug cpu */
+static __devinitdata struct sched_domain sched_domain_dummy;
+static __devinitdata struct sched_group sched_group_dummy;
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
+	int i;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+	case CPU_DOWN_PREPARE:
+		for_each_online_cpu(i)
+			cpu_attach_domain(&sched_domain_dummy, i);
+		return NOTIFY_OK;
+
+	case CPU_UP_CANCELED:
+	case CPU_ONLINE:
+	case CPU_DEAD:
+		/*
+		 * Fall through and re-initialise the domains.
+		 */
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	/* The hotplug lock is already held by cpu_up/cpu_down */
+	arch_init_sched_domains();
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
 	arch_init_sched_domains();
 	sched_domain_debug();
+	unlock_cpu_hotplug();
+	/* XXX: Theoretical race here - CPU may be hotplugged now */
+	hotcpu_notifier(update_sched_domains, 0);
 }
 #else
 void __init sched_init_smp(void)
@@ -4490,20 +4519,18 @@ void __init sched_init(void)
 
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
@@ -4515,7 +4542,7 @@ void __init sched_init(void)
 		rq->expired = rq->arrays + 1;
 
 #ifdef CONFIG_SMP
-		rq->sd = &sched_domain_init;
+		rq->sd = &sched_domain_dummy;
 		rq->cpu_load = 0;
 		rq->active_balance = 0;
 		rq->push_cpu = 0;

_

--------------020304020405010400020605--
