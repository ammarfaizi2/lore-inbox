Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVDURPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVDURPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVDURPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:15:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13204 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261550AbVDUROP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:14:15 -0400
Date: Thu, 21 Apr 2005 23:01:35 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lsetech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: [RFC PATCH] Dynamic sched domains aka Isolated cpusets (v0.2)
Message-ID: <20050421173135.GB4200@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20050418202644.GA5772@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Based on the Paul's feedback, I have simplified and cleaned up the
code quite a bit. 

o  I have taken care of most of the nits, except for the output
   format change for cpusets with isolated children. 
o  Also most of my documentation has been part of my earlier mails 
   and I have not yet added them to cpusets.txt. 
o  I still havent looked at the memory side of things. 
o  Most of the changes are in the cpusets code and almost none 
   in the sched code. (I'll do that next week)
o  Hopefully my earlier mails regarding the design have clarified
   many of the questions that were raised

So here goes version 0.2

-rw-r--r--    1 root     root        16548 Apr 21 20:54 cpuset.o.orig
-rw-r--r--    1 root     root        17548 Apr 21 22:09 cpuset.o.sd-v0.2

  Around ~6% increase in kernel text size of cpuset.o

 include/linux/init.h  |    2
 include/linux/sched.h |    1
 kernel/cpuset.c       |  153 +++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched.c        |  111 ++++++++++++++++++++++++------------
 4 files changed, 216 insertions(+), 51 deletions(-)



--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd-v0.2.patch"

diff -Naurp linux-2.6.12-rc1-mm1.orig/include/linux/init.h linux-2.6.12-rc1-mm1/include/linux/init.h
--- linux-2.6.12-rc1-mm1.orig/include/linux/init.h	2005-03-18 07:03:49.000000000 +0530
+++ linux-2.6.12-rc1-mm1/include/linux/init.h	2005-04-21 21:54:06.000000000 +0530
@@ -217,7 +217,7 @@ void __init parse_early_param(void);
 #define __initdata_or_module __initdata
 #endif /*CONFIG_MODULES*/
 
-#ifdef CONFIG_HOTPLUG
+#if defined(CONFIG_HOTPLUG) || defined(CONFIG_CPUSETS)
 #define __devinit
 #define __devinitdata
 #define __devexit
diff -Naurp linux-2.6.12-rc1-mm1.orig/include/linux/sched.h linux-2.6.12-rc1-mm1/include/linux/sched.h
--- linux-2.6.12-rc1-mm1.orig/include/linux/sched.h	2005-04-21 21:50:26.000000000 +0530
+++ linux-2.6.12-rc1-mm1/include/linux/sched.h	2005-04-21 21:53:57.000000000 +0530
@@ -155,6 +155,7 @@ typedef struct task_struct task_t;
 extern void sched_init(void);
 extern void sched_init_smp(void);
 extern void init_idle(task_t *idle, int cpu);
+extern void rebuild_sched_domains(cpumask_t span1, cpumask_t span2);
 
 extern cpumask_t nohz_cpu_mask;
 
diff -Naurp linux-2.6.12-rc1-mm1.orig/kernel/cpuset.c linux-2.6.12-rc1-mm1/kernel/cpuset.c
--- linux-2.6.12-rc1-mm1.orig/kernel/cpuset.c	2005-04-21 21:50:26.000000000 +0530
+++ linux-2.6.12-rc1-mm1/kernel/cpuset.c	2005-04-21 22:00:36.000000000 +0530
@@ -57,7 +57,13 @@
 
 struct cpuset {
 	unsigned long flags;		/* "unsigned long" so bitops work */
-	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
+	/* 
+	 * CPUs allowed to tasks in cpuset and 
+	 * not part of any isolated children
+	 */
+	cpumask_t cpus_allowed;		
+
+	cpumask_t isolated_map;		/* CPUs associated with isolated children */
 	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
 
 	atomic_t count;			/* count tasks using this cpuset */
@@ -82,6 +88,7 @@ struct cpuset {
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_CPU_EXCLUSIVE,
+	CS_CPU_ISOLATED,
 	CS_MEM_EXCLUSIVE,
 	CS_REMOVED,
 	CS_NOTIFY_ON_RELEASE
@@ -93,6 +100,11 @@ static inline int is_cpu_exclusive(const
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
@@ -127,8 +139,10 @@ static inline int notify_on_release(cons
 static atomic_t cpuset_mems_generation = ATOMIC_INIT(1);
 
 static struct cpuset top_cpuset = {
-	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
+	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_CPU_ISOLATED) | 
+		  (1 << CS_MEM_EXCLUSIVE)),
 	.cpus_allowed = CPU_MASK_ALL,
+	.isolated_map = CPU_MASK_NONE,
 	.mems_allowed = NODE_MASK_ALL,
 	.count = ATOMIC_INIT(0),
 	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
@@ -543,9 +557,14 @@ static void refresh_mems(void)
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
 {
-	return	cpus_subset(p->cpus_allowed, q->cpus_allowed) &&
+	cpumask_t all_map;
+
+	cpus_or(all_map, q->cpus_allowed, q->isolated_map);
+
+	return	cpus_subset(p->cpus_allowed, all_map) &&
 		nodes_subset(p->mems_allowed, q->mems_allowed) &&
 		is_cpu_exclusive(p) <= is_cpu_exclusive(q) &&
+		is_cpu_isolated(p) <= is_cpu_isolated(q) &&
 		is_mem_exclusive(p) <= is_mem_exclusive(q);
 }
 
@@ -587,6 +606,11 @@ static int validate_change(const struct 
 	if (!is_cpuset_subset(trial, par))
 		return -EACCES;
 
+	/* An isolated cpuset has to be exclusive */
+	if ((is_cpu_isolated(trial) && !is_cpu_exclusive(cur)) 
+	   || (!is_cpu_exclusive(trial) && is_cpu_isolated(cur)))
+		return -EINVAL;
+
 	/* If either I or some sibling (!= me) is exclusive, we can't overlap */
 	list_for_each_entry(c, &par->children, sibling) {
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
@@ -602,9 +626,56 @@ static int validate_change(const struct 
 	return 0;
 }
 
+static void update_cpu_domains(struct cpuset *cs, cpumask_t old_map)
+{
+	struct cpuset *par = cs->parent, t, old_parent;
+	cpumask_t all_map, span;
+
+	t = old_parent = *par;
+	cpus_or(all_map, cs->cpus_allowed, cs->isolated_map);
+
+	/* If cpuset empty or top_cpuset, return */
+        if (cpus_empty(all_map) || par == NULL)
+                return;
+
+	/* If cpuset no longer isolated, return cpus back to parent */
+	if (is_removed(cs) || (!is_cpu_isolated(cs))) {
+		cpus_or(t.cpus_allowed, t.cpus_allowed, cs->cpus_allowed);
+		cpus_andnot(t.isolated_map, t.isolated_map, cs->cpus_allowed);
+		span = CPU_MASK_NONE;
+	} else {
+		/* Are we removing CPUs from an isolated cpuset? */
+		if (cpus_subset(cs->cpus_allowed, old_map)) {
+			cpus_or(t.cpus_allowed, par->cpus_allowed, old_map);
+			cpus_andnot(t.isolated_map, par->isolated_map, old_map);
+		}
+		cpus_andnot(t.cpus_allowed, t.cpus_allowed, cs->cpus_allowed);
+		cpus_or(t.isolated_map, t.isolated_map, cs->cpus_allowed);
+		span = cs->cpus_allowed;
+	}
+
+	/* If no change in both cpus_allowed and isolated_map, just return */
+	if ((cpus_equal(t.cpus_allowed, old_parent.cpus_allowed)
+	     && cpus_equal(t.isolated_map, old_parent.isolated_map)))
+		return;
+
+	/* Make the change */
+	par->cpus_allowed = t.cpus_allowed;
+	par->isolated_map = t.isolated_map;
+
+	/* If sched domain same as before, we are done */
+	if (cpus_equal(cs->cpus_allowed, old_parent.cpus_allowed))
+		return;
+
+	lock_cpu_hotplug();
+	rebuild_sched_domains(par->cpus_allowed, span);
+	unlock_cpu_hotplug();
+}
+
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
+	cpumask_t old_map = cs->cpus_allowed;
 	int retval;
 
 	trialcs = *cs;
@@ -615,9 +686,21 @@ static int update_cpumask(struct cpuset 
 	if (cpus_empty(trialcs.cpus_allowed))
 		return -ENOSPC;
 	retval = validate_change(cs, &trialcs);
-	if (retval == 0)
+	if (retval < 0)
+		return retval;
+	if (!is_cpu_isolated(cs)) {
 		cs->cpus_allowed = trialcs.cpus_allowed;
-	return retval;
+		return 0;
+	}
+	/* 
+         * If current isolated cpuset has isolated children 
+         * disallow changes to cpu mask
+	 */
+	if (!cpus_empty(cs->isolated_map))
+		return -EBUSY;
+	cs->cpus_allowed = trialcs.cpus_allowed;
+	update_cpu_domains(cs, old_map);
+	return 0;
 }
 
 static int update_nodemask(struct cpuset *cs, char *buf)
@@ -652,25 +735,28 @@ static int update_nodemask(struct cpuset
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, char *buf)
 {
 	int turning_on;
-	struct cpuset trialcs;
+	struct cpuset trialcs, oldcs;
 	int err;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
-	trialcs = *cs;
+	trialcs = oldcs = *cs;
 	if (turning_on)
 		set_bit(bit, &trialcs.flags);
 	else
 		clear_bit(bit, &trialcs.flags);
 
 	err = validate_change(cs, &trialcs);
-	if (err == 0) {
-		if (turning_on)
-			set_bit(bit, &cs->flags);
-		else
-			clear_bit(bit, &cs->flags);
-	}
-	return err;
+	if (err < 0)
+		return err;
+	if (turning_on)
+		set_bit(bit, &cs->flags);
+	else
+		clear_bit(bit, &cs->flags);
+
+	if (is_cpu_isolated(cs) != is_cpu_isolated(&oldcs))
+		update_cpu_domains(cs, cs->cpus_allowed);
+	return 0;
 }
 
 static int attach_task(struct cpuset *cs, char *buf)
@@ -735,6 +821,7 @@ typedef enum {
 	FILE_CPULIST,
 	FILE_MEMLIST,
 	FILE_CPU_EXCLUSIVE,
+	FILE_CPU_ISOLATED,
 	FILE_MEM_EXCLUSIVE,
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_TASKLIST,
@@ -780,6 +867,9 @@ static ssize_t cpuset_common_file_write(
 	case FILE_CPU_EXCLUSIVE:
 		retval = update_flag(CS_CPU_EXCLUSIVE, cs, buffer);
 		break;
+	case FILE_CPU_ISOLATED:
+		retval = update_flag(CS_CPU_ISOLATED, cs, buffer);
+		break;
 	case FILE_MEM_EXCLUSIVE:
 		retval = update_flag(CS_MEM_EXCLUSIVE, cs, buffer);
 		break;
@@ -843,6 +933,26 @@ static int cpuset_sprintf_cpulist(char *
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
@@ -874,6 +984,7 @@ static ssize_t cpuset_common_file_read(s
 	switch (type) {
 	case FILE_CPULIST:
 		s += cpuset_sprintf_cpulist(s, cs);
+		s += cpuset_sprintf_isolist(s, cs);
 		break;
 	case FILE_MEMLIST:
 		s += cpuset_sprintf_memlist(s, cs);
@@ -881,6 +992,9 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_CPU_EXCLUSIVE:
 		*s++ = is_cpu_exclusive(cs) ? '1' : '0';
 		break;
+	case FILE_CPU_ISOLATED:
+		*s++ = is_cpu_isolated(cs) ? '1' : '0';
+		break;
 	case FILE_MEM_EXCLUSIVE:
 		*s++ = is_mem_exclusive(cs) ? '1' : '0';
 		break;
@@ -1205,6 +1319,11 @@ static struct cftype cft_cpu_exclusive =
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
@@ -1225,6 +1344,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_cpu_exclusive)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_cpu_isolated)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_mem_exclusive)) < 0)
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
@@ -1258,6 +1379,7 @@ static long cpuset_create(struct cpuset 
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
 	cs->cpus_allowed = CPU_MASK_NONE;
+	cs->isolated_map = CPU_MASK_NONE;
 	cs->mems_allowed = NODE_MASK_NONE;
 	atomic_set(&cs->count, 0);
 	INIT_LIST_HEAD(&cs->sibling);
@@ -1319,6 +1441,8 @@ static int cpuset_rmdir(struct inode *un
 	spin_lock(&cs->dentry->d_lock);
 	parent = cs->parent;
 	set_bit(CS_REMOVED, &cs->flags);
+	if (is_cpu_isolated(cs))
+		update_cpu_domains(cs, cs->cpus_allowed);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
 	if (list_empty(&parent->children))
 		check_for_release(parent);
@@ -1343,6 +1467,7 @@ int __init cpuset_init(void)
 	int err;
 
 	top_cpuset.cpus_allowed = CPU_MASK_ALL;
+	top_cpuset.isolated_map = CPU_MASK_NONE;
 	top_cpuset.mems_allowed = NODE_MASK_ALL;
 
 	atomic_inc(&cpuset_mems_generation);
diff -Naurp linux-2.6.12-rc1-mm1.orig/kernel/sched.c linux-2.6.12-rc1-mm1/kernel/sched.c
--- linux-2.6.12-rc1-mm1.orig/kernel/sched.c	2005-04-21 21:50:26.000000000 +0530
+++ linux-2.6.12-rc1-mm1/kernel/sched.c	2005-04-21 21:53:24.000000000 +0530
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
@@ -5006,17 +5007,54 @@ static void __devinit arch_init_sched_do
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
+void rebuild_sched_domains(cpumask_t span1, cpumask_t span2)
+{
+	unsigned long flags;
+	cpumask_t change_map;
+	int i;
+
+	cpus_or(change_map, span1, span2);
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
@@ -5046,13 +5084,13 @@ static int update_sched_domains(struct n
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
@@ -5068,7 +5106,8 @@ static int update_sched_domains(struct n
 	}
 
 	/* The hotplug lock is already held by cpu_up/cpu_down */
-	arch_init_sched_domains();
+	cpus_or(temp_map, cpu_online_map, hotcpu);
+	rebuild_sched_domains(cpu_online_map, cpu_online_map, CPU_MASK_NONE);
 
 	return NOTIFY_OK;
 }

--gBBFr7Ir9EOA20Yy--
