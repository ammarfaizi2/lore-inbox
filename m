Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVDRUNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVDRUNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVDRUNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:13:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45224 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262197AbVDRUI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:08:27 -0400
Date: Tue, 19 Apr 2005 01:56:44 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lsetech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050418202644.GA5772@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1097110266.4907.187.camel@arrakis>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Here's an attempt at dynamic sched domains aka isolated cpusets

o  This functionality is on top of CPUSETs and provides a way to
   completely isolate any set of CPUs dynamically.
o  There is a new cpu_isolated flag that allows users to convert
   an exclusive cpuset to an isolated one
o  The isolated CPUs are part of their own sched domain.
   This ensures that the rebalance code works within the domain,
   prevents overhead due to a cpu trying to pull tasks only to find
   that its cpus_allowed mask does not allow it to be pulled.
   However it does not kick existing processes off the isolated domain
o  There is very little code change in the scheduler sched domain
   code. Most of it is just splitting up of the arch_init_sched_domains
   code to be called dynamically instead of only at boot time.
   It has only one API which takes in the map of all cpus affected
   and the two new domains to be built

   rebuild_sched_domains(cpumask_t change_map, cpumask_t span1, cpumask_t span2)


There are some things that may/will change

o  This has been tested only on x86 [8 way -> 4 way with HT]. Still
   needs work on other arch's
o  I didn't get a chance to see Nick Piggin's RCU sched domains code
   as yet, but I know there would be changes here because of that...
o  This does not support CPU hotplug as yet
o  Making a cpuset isolated manipulates its parent cpus_allowed
   mask. When viewed from userspace this is represented as follows

   [root@llm11 cpusets] cat cpus
   0-3[4-7]

   This indicates that CPUs 4-7 are isolated and is/are part of some
   child cpuset/s

Appreciate any feedback.

Patch against linux-2.6.12-rc1-mm1.

 include/linux/init.h  |    2
 include/linux/sched.h |    1
 kernel/cpuset.c       |  141 ++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched.c        |  109 +++++++++++++++++++++++++-------------
 4 files changed, 213 insertions(+), 40 deletions(-)


        -Dinakar


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd.patch"

diff -Naurp linux-2.6.12-rc1-mm1.orig/include/linux/init.h linux-2.6.12-rc1-mm1/include/linux/init.h
--- linux-2.6.12-rc1-mm1.orig/include/linux/init.h	2005-03-18 07:03:49.000000000 +0530
+++ linux-2.6.12-rc1-mm1/include/linux/init.h	2005-04-18 00:48:26.000000000 +0530
@@ -217,7 +217,7 @@ void __init parse_early_param(void);
 #define __initdata_or_module __initdata
 #endif /*CONFIG_MODULES*/
 
-#ifdef CONFIG_HOTPLUG
+#if defined(CONFIG_HOTPLUG) || defined(CONFIG_CPUSETS)
 #define __devinit
 #define __devinitdata
 #define __devexit
diff -Naurp linux-2.6.12-rc1-mm1.orig/include/linux/sched.h linux-2.6.12-rc1-mm1/include/linux/sched.h
--- linux-2.6.12-rc1-mm1.orig/include/linux/sched.h	2005-04-18 00:46:40.000000000 +0530
+++ linux-2.6.12-rc1-mm1/include/linux/sched.h	2005-04-18 00:48:19.000000000 +0530
@@ -155,6 +155,7 @@ typedef struct task_struct task_t;
 extern void sched_init(void);
 extern void sched_init_smp(void);
 extern void init_idle(task_t *idle, int cpu);
+extern void rebuild_sched_domains(cpumask_t change_map, cpumask_t span1, cpumask_t span2);
 
 extern cpumask_t nohz_cpu_mask;
 
diff -Naurp linux-2.6.12-rc1-mm1.orig/kernel/cpuset.c linux-2.6.12-rc1-mm1/kernel/cpuset.c
--- linux-2.6.12-rc1-mm1.orig/kernel/cpuset.c	2005-04-18 00:46:40.000000000 +0530
+++ linux-2.6.12-rc1-mm1/kernel/cpuset.c	2005-04-18 00:51:48.000000000 +0530
@@ -55,9 +55,17 @@
 
 #define CPUSET_SUPER_MAGIC 		0x27e0eb
 
+#define all_cpus(cs)							\
+({									\
+	cpumask_t __tmp_map;						\
+	cpus_or(__tmp_map, cs->cpus_allowed, cs->isolated_map);		\
+	__tmp_map;							\
+})
+
 struct cpuset {
 	unsigned long flags;		/* "unsigned long" so bitops work */
 	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
+	cpumask_t isolated_map;		/* CPUs associated with a sched domain */
 	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
 
 	atomic_t count;			/* count tasks using this cpuset */
@@ -82,6 +90,7 @@ struct cpuset {
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_CPU_EXCLUSIVE,
+	CS_CPU_ISOLATED,
 	CS_MEM_EXCLUSIVE,
 	CS_REMOVED,
 	CS_NOTIFY_ON_RELEASE
@@ -93,6 +102,11 @@ static inline int is_cpu_exclusive(const
 	return !!test_bit(CS_CPU_EXCLUSIVE, &cs->flags);
 }
 
+static inline int is_cpu_isolated(const struct cpuset *cs)
+{
+	return !!test_bit(CS_CPU_ISOLATED, &cs->flags);
+}
+
 static inline int is_mem_exclusive(const struct cpuset *cs)
 {
 	return !!test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
@@ -127,8 +141,9 @@ static inline int notify_on_release(cons
 static atomic_t cpuset_mems_generation = ATOMIC_INIT(1);
 
 static struct cpuset top_cpuset = {
-	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
+	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_CPU_ISOLATED) | (1 << CS_MEM_EXCLUSIVE)),
 	.cpus_allowed = CPU_MASK_ALL,
+	.isolated_map = CPU_MASK_NONE,
 	.mems_allowed = NODE_MASK_ALL,
 	.count = ATOMIC_INIT(0),
 	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
@@ -543,9 +558,12 @@ static void refresh_mems(void)
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
 {
-	return	cpus_subset(p->cpus_allowed, q->cpus_allowed) &&
+	cpumask_t all_map = all_cpus(q);
+
+	return	cpus_subset(p->cpus_allowed, all_map) &&
 		nodes_subset(p->mems_allowed, q->mems_allowed) &&
 		is_cpu_exclusive(p) <= is_cpu_exclusive(q) &&
+		is_cpu_isolated(p) <= is_cpu_isolated(q) &&
 		is_mem_exclusive(p) <= is_mem_exclusive(q);
 }
 
@@ -587,6 +605,14 @@ static int validate_change(const struct 
 	if (!is_cpuset_subset(trial, par))
 		return -EACCES;
 
+	/* 
+	 * Set isolated ON on a non exclusive cpuset
+	 * Set exclusive off on a isolated cpuset
+	 */
+	if ((is_cpu_isolated(trial) && !is_cpu_exclusive(cur)) 
+	   || (!is_cpu_exclusive(trial) && is_cpu_isolated(cur)))
+		return -EINVAL;
+
 	/* If either I or some sibling (!= me) is exclusive, we can't overlap */
 	list_for_each_entry(c, &par->children, sibling) {
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
@@ -602,9 +628,74 @@ static int validate_change(const struct 
 	return 0;
 }
 
+static void update_sched_domains(struct cpuset *cs, cpumask_t old_map)
+{
+	struct cpuset *parent = cs->parent;
+	cpumask_t change_map, all_map = all_cpus(cs);
+	cpumask_t span1, span2, temp_map;
+	cpumask_t p_old_ca = parent->cpus_allowed, p_old_im = parent->isolated_map;
+
+	if (is_removed(cs) || (!is_cpu_isolated(cs))) {
+		/* Set isolated OFF on a empty cpuset */
+		if (cpus_empty(all_map))
+			return;
+
+		/* Set isolated OFF on a non isolated cpuset */
+		if (!cpus_subset(all_map, parent->isolated_map))
+			return;
+
+		/* Set isolated OFF on a cpuset with some cpus OR rmdir cpuset */
+		cpus_or(parent->cpus_allowed, parent->cpus_allowed, cs->cpus_allowed);
+		cpus_andnot(parent->isolated_map, parent->isolated_map, cs->cpus_allowed);
+		span1 = parent->cpus_allowed;
+		span2 = CPU_MASK_NONE;
+	}
+	else if (is_cpu_isolated(cs)) {
+		/* Set isolated ON on a empty cpuset */
+		if (cpus_empty(all_map))
+			return;
+
+		if (cpus_subset(cs->cpus_allowed, parent->cpus_allowed)) {
+			/* Set isolated ON on a cpuset with some CPUs */
+			cpus_andnot(parent->cpus_allowed, parent->cpus_allowed, cs->cpus_allowed);
+			cpus_or(parent->isolated_map, parent->isolated_map, cs->cpus_allowed);
+		}
+		else if (cpus_subset(cs->cpus_allowed, old_map)) {
+			/* Remove CPUs from an isolated cpuset */
+			cpus_andnot(temp_map, old_map, cs->cpus_allowed);
+			cpus_or(parent->cpus_allowed, parent->cpus_allowed, temp_map);
+			cpus_andnot(parent->isolated_map, parent->isolated_map, temp_map);
+		}
+		else if (cpus_subset(old_map, cs->cpus_allowed)) {
+			 /* Add CPUs to an isolated cpuset */
+			cpus_andnot(temp_map, cs->cpus_allowed, old_map);
+			cpus_andnot(parent->cpus_allowed, parent->cpus_allowed, temp_map);
+			cpus_or(parent->isolated_map, parent->isolated_map, temp_map); 
+		}
+		span1 = parent->cpus_allowed; 
+		span2 = cs->cpus_allowed;
+	}
+	cpus_or(change_map, parent->cpus_allowed, cs->cpus_allowed);
+
+	/*
+	 * Set isolated ON on an already isolated cpuset
+	 * Add the same set of CPUs as existing ones
+	 * Sched domain same as what was before
+	 */
+	if ((cpus_equal(parent->cpus_allowed, p_old_ca)
+	     && cpus_equal(parent->isolated_map, p_old_im))
+	     || cpus_equal(cs->cpus_allowed, p_old_ca))
+		return;
+
+	lock_cpu_hotplug();
+	rebuild_sched_domains(change_map, span1, span2);
+	unlock_cpu_hotplug();
+}
+
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
+	cpumask_t tmp_map;
 	int retval;
 
 	trialcs = *cs;
@@ -615,8 +706,12 @@ static int update_cpumask(struct cpuset 
 	if (cpus_empty(trialcs.cpus_allowed))
 		return -ENOSPC;
 	retval = validate_change(cs, &trialcs);
-	if (retval == 0)
+	if (retval == 0) {
+		tmp_map = cs->cpus_allowed;
 		cs->cpus_allowed = trialcs.cpus_allowed;
+		if (is_cpu_isolated(cs))
+			update_sched_domains(cs, tmp_map);
+	}
 	return retval;
 }
 
@@ -735,6 +830,7 @@ typedef enum {
 	FILE_CPULIST,
 	FILE_MEMLIST,
 	FILE_CPU_EXCLUSIVE,
+	FILE_CPU_ISOLATED,
 	FILE_MEM_EXCLUSIVE,
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_TASKLIST,
@@ -780,6 +876,10 @@ static ssize_t cpuset_common_file_write(
 	case FILE_CPU_EXCLUSIVE:
 		retval = update_flag(CS_CPU_EXCLUSIVE, cs, buffer);
 		break;
+	case FILE_CPU_ISOLATED:
+		retval = update_flag(CS_CPU_ISOLATED, cs, buffer);
+		if (!retval) { update_sched_domains(cs, cs->cpus_allowed); }
+		break;
 	case FILE_MEM_EXCLUSIVE:
 		retval = update_flag(CS_MEM_EXCLUSIVE, cs, buffer);
 		break;
@@ -843,6 +943,26 @@ static int cpuset_sprintf_cpulist(char *
 	return cpulist_scnprintf(page, PAGE_SIZE, mask);
 }
 
+static int cpuset_sprintf_isolist(char *page, struct cpuset *cs)
+{
+	cpumask_t mask = CPU_MASK_NONE;
+	char *tmp = page;
+
+	down(&cpuset_sem);
+	if (!cpus_empty(cs->isolated_map))
+		mask = cs->isolated_map;
+	up(&cpuset_sem);
+
+	if (cpus_empty(mask))
+		return 0;
+	
+	*tmp++ = '[';	
+	tmp += cpulist_scnprintf(tmp, PAGE_SIZE, mask);
+	*tmp++ = ']';
+
+	return (tmp-page);
+}
+
 static int cpuset_sprintf_memlist(char *page, struct cpuset *cs)
 {
 	nodemask_t mask;
@@ -874,6 +994,7 @@ static ssize_t cpuset_common_file_read(s
 	switch (type) {
 	case FILE_CPULIST:
 		s += cpuset_sprintf_cpulist(s, cs);
+		s += cpuset_sprintf_isolist(s, cs);
 		break;
 	case FILE_MEMLIST:
 		s += cpuset_sprintf_memlist(s, cs);
@@ -881,6 +1002,9 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_CPU_EXCLUSIVE:
 		*s++ = is_cpu_exclusive(cs) ? '1' : '0';
 		break;
+	case FILE_CPU_ISOLATED:
+		*s++ = is_cpu_isolated(cs) ? '1' : '0';
+		break;
 	case FILE_MEM_EXCLUSIVE:
 		*s++ = is_mem_exclusive(cs) ? '1' : '0';
 		break;
@@ -1205,6 +1329,11 @@ static struct cftype cft_cpu_exclusive =
 	.private = FILE_CPU_EXCLUSIVE,
 };
 
+static struct cftype cft_cpu_isolated = {
+	.name = "cpu_isolated",
+	.private = FILE_CPU_ISOLATED,
+};
+
 static struct cftype cft_mem_exclusive = {
 	.name = "mem_exclusive",
 	.private = FILE_MEM_EXCLUSIVE,
@@ -1225,6 +1354,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_cpu_exclusive)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_cpu_isolated)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_mem_exclusive)) < 0)
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
@@ -1258,6 +1389,7 @@ static long cpuset_create(struct cpuset 
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
 	cs->cpus_allowed = CPU_MASK_NONE;
+	cs->isolated_map = CPU_MASK_NONE;
 	cs->mems_allowed = NODE_MASK_NONE;
 	atomic_set(&cs->count, 0);
 	INIT_LIST_HEAD(&cs->sibling);
@@ -1319,6 +1451,8 @@ static int cpuset_rmdir(struct inode *un
 	spin_lock(&cs->dentry->d_lock);
 	parent = cs->parent;
 	set_bit(CS_REMOVED, &cs->flags);
+	if (is_cpu_isolated(cs))
+		update_sched_domains(cs, cs->cpus_allowed);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
 	if (list_empty(&parent->children))
 		check_for_release(parent);
@@ -1343,6 +1477,7 @@ int __init cpuset_init(void)
 	int err;
 
 	top_cpuset.cpus_allowed = CPU_MASK_ALL;
+	top_cpuset.isolated_map = CPU_MASK_NONE;
 	top_cpuset.mems_allowed = NODE_MASK_ALL;
 
 	atomic_inc(&cpuset_mems_generation);
diff -Naurp linux-2.6.12-rc1-mm1.orig/kernel/sched.c linux-2.6.12-rc1-mm1/kernel/sched.c
--- linux-2.6.12-rc1-mm1.orig/kernel/sched.c	2005-04-18 00:46:40.000000000 +0530
+++ linux-2.6.12-rc1-mm1/kernel/sched.c	2005-04-18 00:47:55.000000000 +0530
@@ -4895,40 +4895,41 @@ static void check_sibling_maps(void)
 }
 #endif
 
-/*
- * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
- */
-static void __devinit arch_init_sched_domains(void)
+static void attach_domains(cpumask_t cpu_map)
 {
 	int i;
-	cpumask_t cpu_default_map;
 
-#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
-	check_sibling_maps();
+	/* Attach the domains */
+	for_each_cpu_mask(i, cpu_map) {
+		struct sched_domain *sd;
+#ifdef CONFIG_SCHED_SMT
+		sd = &per_cpu(cpu_domains, i);
+#else
+		sd = &per_cpu(phys_domains, i);
 #endif
-	/*
-	 * Setup mask for cpus without special case scheduling requirements.
-	 * For now this just excludes isolated cpus, but could be used to
-	 * exclude other special cases in the future.
-	 */
-	cpus_complement(cpu_default_map, cpu_isolated_map);
-	cpus_and(cpu_default_map, cpu_default_map, cpu_online_map);
+		cpu_attach_domain(sd, i);
+	}
+}
+
+static void build_sched_domains(cpumask_t cpu_map)
+{
+	int i;
 
 	/*
-	 * Set up domains. Isolated domains just stay on the dummy domain.
+	 * Set up domains.
 	 */
-	for_each_cpu_mask(i, cpu_default_map) {
+	for_each_cpu_mask(i, cpu_map) {
 		int group;
 		struct sched_domain *sd = NULL, *p;
 		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+		cpus_and(nodemask, nodemask, cpu_map);
 
 #ifdef CONFIG_NUMA
 		sd = &per_cpu(node_domains, i);
 		group = cpu_to_node_group(i);
 		*sd = SD_NODE_INIT;
-		sd->span = cpu_default_map;
+		sd->span = cpu_map;
 		sd->groups = &sched_group_nodes[group];
 #endif
 
@@ -4946,7 +4947,7 @@ static void __devinit arch_init_sched_do
 		group = cpu_to_cpu_group(i);
 		*sd = SD_SIBLING_INIT;
 		sd->span = cpu_sibling_map[i];
-		cpus_and(sd->span, sd->span, cpu_default_map);
+		cpus_and(sd->span, sd->span, cpu_map);
 		sd->parent = p;
 		sd->groups = &sched_group_cpus[group];
 #endif
@@ -4956,7 +4957,7 @@ static void __devinit arch_init_sched_do
 	/* Set up CPU (sibling) groups */
 	for_each_online_cpu(i) {
 		cpumask_t this_sibling_map = cpu_sibling_map[i];
-		cpus_and(this_sibling_map, this_sibling_map, cpu_default_map);
+		cpus_and(this_sibling_map, this_sibling_map, cpu_map);
 		if (i != first_cpu(this_sibling_map))
 			continue;
 
@@ -4969,7 +4970,7 @@ static void __devinit arch_init_sched_do
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+		cpus_and(nodemask, nodemask, cpu_map);
 		if (cpus_empty(nodemask))
 			continue;
 
@@ -4979,12 +4980,12 @@ static void __devinit arch_init_sched_do
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
-	init_sched_build_groups(sched_group_nodes, cpu_default_map,
+	init_sched_build_groups(sched_group_nodes, cpu_map,
 					&cpu_to_node_group);
 #endif
 
 	/* Calculate CPU power for physical packages and nodes */
-	for_each_cpu_mask(i, cpu_default_map) {
+	for_each_cpu_mask(i, cpu_map) {
 		int power;
 		struct sched_domain *sd;
 #ifdef CONFIG_SCHED_SMT
@@ -5006,17 +5007,52 @@ static void __devinit arch_init_sched_do
 		}
 #endif
 	}
+}
 
-	/* Attach the domains */
-	for_each_online_cpu(i) {
-		struct sched_domain *sd;
-#ifdef CONFIG_SCHED_SMT
-		sd = &per_cpu(cpu_domains, i);
-#else
-		sd = &per_cpu(phys_domains, i);
+void rebuild_sched_domains(cpumask_t change_map, cpumask_t span1, cpumask_t span2)
+{
+	unsigned long flags;
+	int i;
+
+	local_irq_save(flags);
+
+	for_each_cpu_mask(i, change_map)
+		spin_lock(&cpu_rq(i)->lock);
+
+	if (!cpus_empty(span1))
+		build_sched_domains(span1);
+	if (!cpus_empty(span2))
+		build_sched_domains(span2);
+
+	for_each_cpu_mask(i, change_map)
+		spin_unlock(&cpu_rq(i)->lock);
+
+	/* Race here ??? */
+	attach_domains(change_map);
+
+	local_irq_restore(flags);
+}
+
+/*
+ * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
+ */
+static void __devinit arch_init_sched_domains(void)
+{
+	cpumask_t cpu_default_map;
+
+#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
+	check_sibling_maps();
 #endif
-		cpu_attach_domain(sd, i);
-	}
+	/*
+	 * Setup mask for cpus without special case scheduling requirements.
+	 * For now this just excludes isolated cpus, but could be used to
+	 * exclude other special cases in the future.
+	 */
+	cpus_complement(cpu_default_map, cpu_isolated_map);
+	cpus_and(cpu_default_map, cpu_default_map, cpu_online_map);
+
+	build_sched_domains(cpu_default_map);
+	attach_domains(cpu_default_map);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -5046,13 +5082,13 @@ static int update_sched_domains(struct n
 				unsigned long action, void *hcpu)
 {
 	int i;
+	cpumask_t temp_map, hotcpu = cpumask_of_cpu((long)hcpu);
 
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_DOWN_PREPARE:
-		for_each_online_cpu(i)
-			cpu_attach_domain(&sched_domain_dummy, i);
-		arch_destroy_sched_domains();
+		cpus_andnot(temp_map, cpu_online_map, hotcpu);
+		rebuild_sched_domains(cpu_online_map, temp_map, CPU_MASK_NONE);
 		return NOTIFY_OK;
 
 	case CPU_UP_CANCELED:
@@ -5068,7 +5104,8 @@ static int update_sched_domains(struct n
 	}
 
 	/* The hotplug lock is already held by cpu_up/cpu_down */
-	arch_init_sched_domains();
+	cpus_or(temp_map, cpu_online_map, hotcpu);
+	rebuild_sched_domains(cpu_online_map, cpu_online_map, CPU_MASK_NONE);
 
 	return NOTIFY_OK;
 }

--UugvWAfsgieZRqgk--
