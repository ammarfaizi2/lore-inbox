Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVEAS72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVEAS72 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVEAS72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 14:59:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51655 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262645AbVEAS6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 14:58:51 -0400
Date: Mon, 2 May 2005 00:39:47 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [RFC PATCH] Dynamic sched domains (v0.5)
Message-ID: <20050501190947.GA5204@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Ok, Here is the minimal patchset that I had promised after the
last discussion.

What it does have
o  The current patch enhances the meaning of exclusive cpusets by
   attaching them (exclusive cpusets) to sched domains
o  It does _not_ require any additional cpumask_t variable. It
   just parses the cpus_allowed of the parent/sibling/children
   cpusets for manipulating sched domains
o  All existing operations on non-/exclusive cpusets are preserved as-is.
o  The sched code has been modified to bring it upto 2.6.12-rc2-mm3

Usage
o  On setting the cpu_exclusive flag of a cpuset X, it creates two
   sched domains
   a. One, All cpus from X's parent cpuset that dont belong to any
      exclusive sibling cpuset of X
   b. Two, All cpus in X's cpus_allowed
o  On adding/deleting cpus to/from a exclusive cpuset X that has exclusive
   children, it creates two sched domains
   a. One, All cpus from X's parent cpuset that dont belong to any
      exclusive sibling cpuset of X
   b. Two, All cpus in X's cpus_allowed, after taking away any cpus that
      belong to exclusive child cpusets of X
o  On unsetting the cpu_exclusive flag of cpuset X or rmdir X, it creates a
   single sched domain, containing all cpus from X' parent cpuset that
   dont belong to any exclusive sibling of X and the cpus of X
o  It does _not_ modify the cpus_allowed variable of the parent as in the
   previous version. It relies on user space to move tasks to proper
   cpusets for complete isolation/exclusion
o  See function update_cpu_domains for more details

What it does not have
o  It is still short on documentation
o  Does not have hotplug support as yet
o  Supports only x86 as of now
o  No thoughts on "memory domains" (Though I am not sure, who
   would use such a thing and what exactly are the requirements)


Here is the increase in binary sizes for different values of CONFIG_NR_CPUS
(32 and 255)

kernel/cpuset.o.orig-32         16728
kernel/cpuset.o-v0.5-32         17176 (~2.7% increase)

kernel/cpuset.o.orig-255        17916
kernel/cpuset.o-v0.5-255        19120 (~6.7% increase)

The code changes are also minimal

 include/linux/init.h  |    2
 include/linux/sched.h |    1
 kernel/cpuset.c       |   73 +++++++++++++++++++++++++++------
 kernel/sched.c        |  109 +++++++++++++++++++++++++++++++++-----------------
 4 files changed, 134 insertions(+), 51 deletions(-)


        -Dinakar



--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd-v0.5-1.patch"

diff -Naurp linux-2.6.12-rc2.orig/include/linux/init.h linux-2.6.12-rc2/include/linux/init.h
--- linux-2.6.12-rc2.orig/include/linux/init.h	2005-04-04 22:07:52.000000000 +0530
+++ linux-2.6.12-rc2/include/linux/init.h	2005-05-01 22:07:56.000000000 +0530
@@ -217,7 +217,7 @@ void __init parse_early_param(void);
 #define __initdata_or_module __initdata
 #endif /*CONFIG_MODULES*/
 
-#ifdef CONFIG_HOTPLUG
+#if defined(CONFIG_HOTPLUG) || defined(CONFIG_CPUSETS)
 #define __devinit
 #define __devinitdata
 #define __devexit
diff -Naurp linux-2.6.12-rc2.orig/include/linux/sched.h linux-2.6.12-rc2/include/linux/sched.h
--- linux-2.6.12-rc2.orig/include/linux/sched.h	2005-04-28 18:24:11.000000000 +0530
+++ linux-2.6.12-rc2/include/linux/sched.h	2005-05-01 22:07:35.000000000 +0530
@@ -155,6 +155,7 @@ typedef struct task_struct task_t;
 extern void sched_init(void);
 extern void sched_init_smp(void);
 extern void init_idle(task_t *idle, int cpu);
+extern void rebuild_sched_domains(cpumask_t span1, cpumask_t span2);
 
 extern cpumask_t nohz_cpu_mask;
 
diff -Naurp linux-2.6.12-rc2.orig/kernel/sched.c linux-2.6.12-rc2/kernel/sched.c
--- linux-2.6.12-rc2.orig/kernel/sched.c	2005-04-28 18:24:11.000000000 +0530
+++ linux-2.6.12-rc2/kernel/sched.c	2005-05-01 22:06:55.000000000 +0530
@@ -4526,7 +4526,7 @@ int __init migration_init(void)
 #endif
 
 #ifdef CONFIG_SMP
-#define SCHED_DOMAIN_DEBUG
+#undef SCHED_DOMAIN_DEBUG
 #ifdef SCHED_DOMAIN_DEBUG
 static void sched_domain_debug(struct sched_domain *sd, int cpu)
 {
@@ -4934,40 +4934,50 @@ static void check_sibling_maps(void)
 }
 #endif
 
-/*
- * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
- */
-static void __devinit arch_init_sched_domains(void)
+static inline void detach_domains(cpumask_t cpu_map)
 {
 	int i;
-	cpumask_t cpu_default_map;
 
-#if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
-	check_sibling_maps();
+	for_each_cpu_mask(i, cpu_map)
+		cpu_attach_domain(NULL, i);
+	synchronize_kernel();
+}
+
+static inline void attach_domains(cpumask_t cpu_map)
+{
+	int i;
+
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
-	 * Set up domains. Isolated domains just stay on the NULL domain.
+	 * Set up domains as specified by the cpu_map.
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
 
@@ -4985,7 +4995,7 @@ static void __devinit arch_init_sched_do
 		group = cpu_to_cpu_group(i);
 		*sd = SD_SIBLING_INIT;
 		sd->span = cpu_sibling_map[i];
-		cpus_and(sd->span, sd->span, cpu_default_map);
+		cpus_and(sd->span, sd->span, cpu_map);
 		sd->parent = p;
 		sd->groups = &sched_group_cpus[group];
 #endif
@@ -4995,7 +5005,7 @@ static void __devinit arch_init_sched_do
 	/* Set up CPU (sibling) groups */
 	for_each_online_cpu(i) {
 		cpumask_t this_sibling_map = cpu_sibling_map[i];
-		cpus_and(this_sibling_map, this_sibling_map, cpu_default_map);
+		cpus_and(this_sibling_map, this_sibling_map, cpu_map);
 		if (i != first_cpu(this_sibling_map))
 			continue;
 
@@ -5008,7 +5018,7 @@ static void __devinit arch_init_sched_do
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
 
-		cpus_and(nodemask, nodemask, cpu_default_map);
+		cpus_and(nodemask, nodemask, cpu_map);
 		if (cpus_empty(nodemask))
 			continue;
 
@@ -5018,12 +5028,12 @@ static void __devinit arch_init_sched_do
 
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
@@ -5045,17 +5055,46 @@ static void __devinit arch_init_sched_do
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
+	cpumask_t change_map;
+
+	cpus_or(change_map, span1, span2);
+
+	preempt_disable();
+	detach_domains(change_map);
+
+	if (!cpus_empty(span1))
+		build_sched_domains(span1);
+	if (!cpus_empty(span2))
+		build_sched_domains(span2);
+
+	attach_domains(change_map);
+	preempt_enable();
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
@@ -5082,9 +5121,7 @@ static int update_sched_domains(struct n
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_DOWN_PREPARE:
-		for_each_online_cpu(i)
-			cpu_attach_domain(NULL, i);
-		synchronize_kernel();
+		detach_domains(cpu_online_map);
 		arch_destroy_sched_domains();
 		return NOTIFY_OK;
 

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd-v0.5-2.patch"

diff -Naurp linux-2.6.12-rc2.orig/kernel/cpuset.c linux-2.6.12-rc2/kernel/cpuset.c
--- linux-2.6.12-rc2.orig/kernel/cpuset.c	2005-04-28 18:24:11.000000000 +0530
+++ linux-2.6.12-rc2/kernel/cpuset.c	2005-05-01 22:15:06.000000000 +0530
@@ -602,12 +602,48 @@ static int validate_change(const struct 
 	return 0;
 }
 
+static void update_cpu_domains(struct cpuset *cur)
+{
+	struct cpuset *c, *par = cur->parent;
+	cpumask_t span1, span2;
+
+	if (par == NULL || cpus_empty(cur->cpus_allowed))
+		return;
+
+	/* Get all non-exclusive cpus from parent domain */
+	span1 = par->cpus_allowed;
+	list_for_each_entry(c, &par->children, sibling) {
+		if (is_cpu_exclusive(c))
+			cpus_andnot(span1, span1, c->cpus_allowed);
+	}
+	if (is_removed(cur) || !is_cpu_exclusive(cur)) {
+		cpus_or(span1, span1, cur->cpus_allowed);
+		if (cpus_equal(span1, cur->cpus_allowed))
+			return;
+		span2 = CPU_MASK_NONE;
+	}
+	else {
+		if (cpus_empty(span1))
+			return;
+		span2 = cur->cpus_allowed;
+		/* If current cpuset has exclusive children, exclude from domain */
+		list_for_each_entry(c, &cur->children, sibling) {
+			if (is_cpu_exclusive(c))
+				cpus_andnot(span2, span2, c->cpus_allowed);
+		}
+	}
+
+	lock_cpu_hotplug();
+	rebuild_sched_domains(span1, span2);
+	unlock_cpu_hotplug();
+}
+
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
-	struct cpuset trialcs;
+	struct cpuset trialcs, oldcs;
 	int retval;
 
-	trialcs = *cs;
+	trialcs = oldcs = *cs;
 	retval = cpulist_parse(buf, trialcs.cpus_allowed);
 	if (retval < 0)
 		return retval;
@@ -615,9 +651,13 @@ static int update_cpumask(struct cpuset 
 	if (cpus_empty(trialcs.cpus_allowed))
 		return -ENOSPC;
 	retval = validate_change(cs, &trialcs);
-	if (retval == 0)
-		cs->cpus_allowed = trialcs.cpus_allowed;
-	return retval;
+	if (retval < 0)
+		return retval;
+	cs->cpus_allowed = trialcs.cpus_allowed;
+	if (is_cpu_exclusive(cs) && 
+	    (!cpus_equal(cs->cpus_allowed, oldcs.cpus_allowed)))
+		update_cpu_domains(cs);
+	return 0;
 }
 
 static int update_nodemask(struct cpuset *cs, char *buf)
@@ -652,25 +692,28 @@ static int update_nodemask(struct cpuset
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
+	if (is_cpu_exclusive(cs) != is_cpu_exclusive(&oldcs))
+                update_cpu_domains(cs);
+	return 0;
 }
 
 static int attach_task(struct cpuset *cs, char *buf)
@@ -1319,6 +1362,8 @@ static int cpuset_rmdir(struct inode *un
 	spin_lock(&cs->dentry->d_lock);
 	parent = cs->parent;
 	set_bit(CS_REMOVED, &cs->flags);
+	if (is_cpu_exclusive(cs))
+		update_cpu_domains(cs);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
 	if (list_empty(&parent->children))
 		check_for_release(parent);

--azLHFNyN32YCQGCU--
