Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWJPXEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWJPXEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWJPXEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:04:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62355 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161158AbWJPXEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:04:04 -0400
From: Paul Jackson <pj@sgi.com>
To: Dinakar Guniguntala <dino@in.ibm.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Paul Menage <menage@google.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Rohit Seth <rohitseth@google.com>, dipankar@in.ibm.com,
       Paul Jackson <pj@sgi.com>
Date: Mon, 16 Oct 2006 16:03:51 -0700
Message-Id: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
Subject: [RFC] Cpuset: explicit dynamic sched domain control flags
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

I should get agreement from the other folks who care about the
interaction of cpusets and sched domains before submitting this
to Andrew for staging in *-mm.

In particular, I remain unsure of myself around the sched domain
code, and could use some feedback from someone with more of a
clue on whether I broke something here.

=======

I have long regretted hanging the ability to use cpusets to
define dynamic scheduler domains off the 'cpu_exclusive' flag
of cpusets.

It sort of made sense, in that one wants to avoid overlapping
sched domains to some extent.  However it conflicts with other
uses and meanings of the cpu_exclusive flag.  In particular,
a job manager cannot have an inactive job in a cpuset that
overlaps an active job, and mark the active job as defining a
sched domain.

In the interests of maintaining compatibility with the
existing interface, we should not remove this overloading of
the cpu_exclusive flag.  But we can add a new flag to define
sched domains, and a second flag to activate this first flag.

We add two per-cpuset flags (boolean flag files):

 1) sched_domain_enabled - if set, enables the following flag
    in each of the current cpusets immediate children, and
 2) sched_domain - if set and enabled (by the sched_domain_enabled
    flag in its parent cpuset) then defines a sched domain.

If 'sched_domain_enabled' is set in a cpuset, then the
'cpu_exclusive' flag in that cpusets children no longer affects
the dynamic scheduler domain configuration.

I have the enabler flag control the children cpusets, not the
current cpuset, so that any set of sibling cpusets is playing
by the same rules - either all using the cpu_exclusive flag or
all using the sched_domain flag.  Sibling cpusets both marked
as sched_domain's cannot overlap with each other, though they
are allowed to overlap with other cpusets that do not define
sched domains.

See the Documentation/cpusets.txt changes for more details.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

So far this patch has been built, booted and unit tested
for functionality on a single arch - ia64 SN2.  -pj

 Documentation/cpusets.txt |   91 +++++++++++++++++++++++++++--
 kernel/cpuset.c           |  143 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 196 insertions(+), 38 deletions(-)

--- 2.6.19-rc1-mm1.orig/kernel/cpuset.c	2006-10-15 23:02:39.000000000 -0700
+++ 2.6.19-rc1-mm1/kernel/cpuset.c	2006-10-16 15:23:49.000000000 -0700
@@ -110,6 +110,8 @@ typedef enum {
 	CS_NOTIFY_ON_RELEASE,
 	CS_SPREAD_PAGE,
 	CS_SPREAD_SLAB,
+	CS_SCHED_DOMAIN_ENABLED,
+	CS_SCHED_DOMAIN,
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -149,6 +151,41 @@ static inline int is_spread_slab(const s
 }
 
 /*
+ * Why two sched domain flags, and why does the cpu_exclusive
+ * flag affect whether a cpuset defines a sched domain?  See the
+ * "Dynamic Scheduler Domain" section of Documentation/cpusets.txt
+ * for the reasons and history behind this and other details of the
+ * sched_domain and sched_domain_enabled flags.
+ */
+
+/*
+ * is_sched_domain_enabled() is often called with a cpusets parent
+ * pointer, which is NULL for top_cpuset.  Let such a call be ok and
+ * check for the NULL here.  The 'sched_domain' flag in the top_cpuset
+ * has no affect, so it doesn't matter whether we pretend here that
+ * its non-existent parent enabled it or not.  The scheduler always
+ * provides a dynamic scheduler domain for the entire set of CPUs in
+ * the system in any case.
+ */
+static inline int is_sched_domain_enabled(const struct cpuset *cs)
+{
+	return cs && test_bit(CS_SCHED_DOMAIN_ENABLED, &cs->flags);
+}
+
+static inline int is_sched_domain(const struct cpuset *cs)
+{
+	return test_bit(CS_SCHED_DOMAIN, &cs->flags);
+}
+
+static int defines_sched_domain(const struct cpuset *cs)
+{
+	if (is_sched_domain_enabled(cs->parent))
+		return is_sched_domain(cs);
+	else
+		return is_cpu_exclusive(cs);
+}
+
+/*
  * Increment this integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
  * number, and avoid having to lock and reload mems_allowed unless
@@ -729,9 +766,11 @@ static int validate_change(const struct 
 	}
 
 	/* Remaining checks don't apply to root cpuset */
-	if ((par = cur->parent) == NULL)
+	if (cur == &top_cpuset)
 		return 0;
 
+	par = cur->parent;
+
 	/* We must be a subset of our parent cpuset */
 	if (!is_cpuset_subset(trial, par))
 		return -EACCES;
@@ -746,6 +785,11 @@ static int validate_change(const struct 
 		    c != cur &&
 		    nodes_intersects(trial->mems_allowed, c->mems_allowed))
 			return -EINVAL;
+		/* Two sibling sched domains cannot overlap either */
+		if ((defines_sched_domain(trial) && defines_sched_domain(c)) &&
+		    c != cur &&
+		    cpus_intersects(trial->cpus_allowed, c->cpus_allowed))
+			return -EINVAL;
 	}
 
 	return 0;
@@ -754,9 +798,9 @@ static int validate_change(const struct 
 /*
  * For a given cpuset cur, partition the system as follows
  * a. All cpus in the parent cpuset's cpus_allowed that are not part of any
- *    exclusive child cpusets
+ *    sched domain defining siblings of 'cur'.
  * b. All cpus in the current cpuset's cpus_allowed that are not part of any
- *    exclusive child cpusets
+ *    sched domain defining children of 'cur'.
  * Build these two partitions by calling partition_sched_domains
  *
  * Call with manage_mutex held.  May nest a call to the
@@ -765,7 +809,7 @@ static int validate_change(const struct 
  * not call lock_cpu_hotplug() while holding callback_mutex.
  */
 
-static void update_cpu_domains(struct cpuset *cur)
+static void update_sched_domains(struct cpuset *cur)
 {
 	struct cpuset *c, *par = cur->parent;
 	cpumask_t pspan, cspan;
@@ -774,15 +818,15 @@ static void update_cpu_domains(struct cp
 		return;
 
 	/*
-	 * Get all cpus from parent's cpus_allowed not part of exclusive
-	 * children
+	 * Get all cpus from parent's cpus_allowed not part of sched
+	 * domain defining siblings
 	 */
 	pspan = par->cpus_allowed;
 	list_for_each_entry(c, &par->children, sibling) {
-		if (is_cpu_exclusive(c))
+		if (defines_sched_domain(c))
 			cpus_andnot(pspan, pspan, c->cpus_allowed);
 	}
-	if (!is_cpu_exclusive(cur)) {
+	if (!defines_sched_domain(cur)) {
 		if (cpus_equal(pspan, cur->cpus_allowed))
 			return;
 		cspan = CPU_MASK_NONE;
@@ -792,10 +836,10 @@ static void update_cpu_domains(struct cp
 		cspan = cur->cpus_allowed;
 		/*
 		 * Get all cpus from current cpuset's cpus_allowed not part
-		 * of exclusive children
+		 * of sched domain defining children
 		 */
 		list_for_each_entry(c, &cur->children, sibling) {
-			if (is_cpu_exclusive(c))
+			if (defines_sched_domain(c))
 				cpus_andnot(cspan, cspan, c->cpus_allowed);
 		}
 	}
@@ -812,7 +856,7 @@ static void update_cpu_domains(struct cp
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
-	int retval, cpus_unchanged;
+	int retval, cpus_changed;
 
 	/* top_cpuset.cpus_allowed tracks cpu_online_map; it's read-only */
 	if (cs == &top_cpuset)
@@ -828,12 +872,12 @@ static int update_cpumask(struct cpuset 
 	retval = validate_change(cs, &trialcs);
 	if (retval < 0)
 		return retval;
-	cpus_unchanged = cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
+	cpus_changed = !cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
 	mutex_lock(&callback_mutex);
 	cs->cpus_allowed = trialcs.cpus_allowed;
 	mutex_unlock(&callback_mutex);
-	if (is_cpu_exclusive(cs) && !cpus_unchanged)
-		update_cpu_domains(cs);
+	if (cpus_changed && defines_sched_domain(cs))
+		update_sched_domains(cs);
 	return 0;
 }
 
@@ -1032,7 +1076,8 @@ static int update_memory_pressure_enable
  * update_flag - read a 0 or a 1 in a file and update associated flag
  * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
  *				CS_NOTIFY_ON_RELEASE, CS_MEMORY_MIGRATE,
- *				CS_SPREAD_PAGE, CS_SPREAD_SLAB)
+ *				CS_SPREAD_PAGE, CS_SPREAD_SLAB,
+ *				CS_SCHED_DOMAIN_ENABLED, CS_SCHED_DOMAIN)
  * cs:	the cpuset to update
  * buf:	the buffer where we read the 0 or 1
  *
@@ -1043,7 +1088,7 @@ static int update_flag(cpuset_flagbits_t
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err, cpu_exclusive_changed;
+	int err, defines_sched_domain_changed;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -1056,17 +1101,15 @@ static int update_flag(cpuset_flagbits_t
 	err = validate_change(cs, &trialcs);
 	if (err < 0)
 		return err;
-	cpu_exclusive_changed =
-		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
+	defines_sched_domain_changed =
+		(defines_sched_domain(cs) != defines_sched_domain(&trialcs));
+
 	mutex_lock(&callback_mutex);
-	if (turning_on)
-		set_bit(bit, &cs->flags);
-	else
-		clear_bit(bit, &cs->flags);
+	cs->flags = trialcs.flags;
 	mutex_unlock(&callback_mutex);
 
-	if (cpu_exclusive_changed)
-                update_cpu_domains(cs);
+	if (defines_sched_domain_changed)
+                update_sched_domains(cs);
 	return 0;
 }
 
@@ -1277,6 +1320,8 @@ typedef enum {
 	FILE_MEMORY_PRESSURE,
 	FILE_SPREAD_PAGE,
 	FILE_SPREAD_SLAB,
+	FILE_SCHED_DOMAIN_ENABLED,
+	FILE_SCHED_DOMAIN,
 	FILE_TASKLIST,
 } cpuset_filetype_t;
 
@@ -1344,6 +1389,12 @@ static ssize_t cpuset_common_file_write(
 		retval = update_flag(CS_SPREAD_SLAB, cs, buffer);
 		cs->mems_generation = cpuset_mems_generation++;
 		break;
+	case FILE_SCHED_DOMAIN_ENABLED:
+		retval = update_flag(CS_SCHED_DOMAIN_ENABLED, cs, buffer);
+		break;
+	case FILE_SCHED_DOMAIN:
+		retval = update_flag(CS_SCHED_DOMAIN, cs, buffer);
+		break;
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
@@ -1459,6 +1510,12 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_SPREAD_SLAB:
 		*s++ = is_spread_slab(cs) ? '1' : '0';
 		break;
+	case FILE_SCHED_DOMAIN_ENABLED:
+		*s++ = is_sched_domain_enabled(cs) ? '1' : '0';
+		break;
+	case FILE_SCHED_DOMAIN:
+		*s++ = is_sched_domain(cs) ? '1' : '0';
+		break;
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1832,6 +1889,16 @@ static struct cftype cft_spread_slab = {
 	.private = FILE_SPREAD_SLAB,
 };
 
+static struct cftype cft_sched_domain_enabled = {
+	.name = "sched_domain_enabled",
+	.private = FILE_SCHED_DOMAIN_ENABLED,
+};
+
+static struct cftype cft_sched_domain = {
+	.name = "sched_domain",
+	.private = FILE_SCHED_DOMAIN,
+};
+
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1856,6 +1923,10 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_sched_domain_enabled)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_sched_domain)) < 0)
+		return err;
 	return 0;
 }
 
@@ -1886,6 +1957,8 @@ static long cpuset_create(struct cpuset 
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
 	if (is_spread_slab(parent))
 		set_bit(CS_SPREAD_SLAB, &cs->flags);
+	if (is_sched_domain_enabled(parent))
+		set_bit(CS_SCHED_DOMAIN_ENABLED, &cs->flags);
 	cs->cpus_allowed = CPU_MASK_NONE;
 	cs->mems_allowed = NODE_MASK_NONE;
 	atomic_set(&cs->count, 0);
@@ -1931,11 +2004,14 @@ static int cpuset_mkdir(struct inode *di
 }
 
 /*
- * Locking note on the strange update_flag() call below:
+ * Locking note on the strange update_flag() calls below:
+ *
+ * If the cpuset being removed defines a sched domain, then simulate
+ * turning cpu_exclusive or sched_domain off (depending on whether
+ * the parent cpusets sched_domain_enabled flag is set), which will
+ * call update_sched_domains().
  *
- * If the cpuset being removed is marked cpu_exclusive, then simulate
- * turning cpu_exclusive off, which will call update_cpu_domains().
- * The lock_cpu_hotplug() call in update_cpu_domains() must not be
+ * The lock_cpu_hotplug() call in update_sched_domains() must not be
  * made while holding callback_mutex.  Elsewhere the kernel nests
  * callback_mutex inside lock_cpu_hotplug() calls.  So the reverse
  * nesting would risk an ABBA deadlock.
@@ -1960,14 +2036,19 @@ static int cpuset_rmdir(struct inode *un
 		mutex_unlock(&manage_mutex);
 		return -EBUSY;
 	}
-	if (is_cpu_exclusive(cs)) {
-		int retval = update_flag(CS_CPU_EXCLUSIVE, cs, "0");
+	parent = cs->parent;
+	if (defines_sched_domain(cs)) {
+		int retval;
+
+		if (is_sched_domain_enabled(parent))
+			retval = update_flag(CS_SCHED_DOMAIN, cs, "0");
+		else
+			retval = update_flag(CS_CPU_EXCLUSIVE, cs, "0");
 		if (retval < 0) {
 			mutex_unlock(&manage_mutex);
 			return retval;
 		}
 	}
-	parent = cs->parent;
 	mutex_lock(&callback_mutex);
 	set_bit(CS_REMOVED, &cs->flags);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
--- 2.6.19-rc1-mm1.orig/Documentation/cpusets.txt	2006-10-15 23:02:39.000000000 -0700
+++ 2.6.19-rc1-mm1/Documentation/cpusets.txt	2006-10-16 14:53:19.000000000 -0700
@@ -19,7 +19,8 @@ CONTENTS:
   1.5 What does notify_on_release do ?
   1.6 What is memory_pressure ?
   1.7 What is memory spread ?
-  1.8 How do I use cpusets ?
+  1.8 Dynamic Scheduler Domains
+  1.9 How do I use cpusets ?
 2. Usage Examples and Syntax
   2.1 Basic Usage
   2.2 Adding/removing cpus
@@ -131,8 +132,9 @@ Cpusets extends these two mechanisms as 
  - A cpuset may be marked exclusive, which ensures that no other
    cpuset (except direct ancestors and descendents) may contain
    any overlapping CPUs or Memory Nodes.
-   Also a cpu_exclusive cpuset would be associated with a sched
-   domain.
+   Also a cpu_exclusive cpuset will be associated with a sched
+   domain, unless the cpuset's parent 'sched_domain_flag' is
+   enabled.
  - You can list all the tasks (by pid) attached to any cpuset.
 
 The implementation of cpusets requires a few, simple hooks
@@ -177,6 +179,8 @@ containing the following files describin
  - mems: list of Memory Nodes in that cpuset
  - memory_migrate flag: if set, move pages to cpusets nodes
  - cpu_exclusive flag: is cpu placement exclusive?
+ - sched_domain_enabled: if set, activates childrens 'sched_domain' flag
+ - sched_domain: if activated and set, cpusets 'cpus' define a sched domain
  - mem_exclusive flag: is memory placement exclusive?
  - tasks: list of tasks (by pid) attached to that cpuset
  - notify_on_release flag: run /sbin/cpuset_release_agent on exit?
@@ -231,9 +235,21 @@ If a cpuset is cpu or mem exclusive, no 
 a direct ancestor or descendent, may share any of the same CPUs or
 Memory Nodes.
 
-A cpuset that is cpu_exclusive has a scheduler (sched) domain
-associated with it.  The sched domain consists of all CPUs in the
-current cpuset that are not part of any exclusive child cpusets.
+Cpusets can be used to define scheduler (sched) domains, in one
+of two ways:
+
+    If the 'sched_domain_enabled' flag in a cpusets parent is -not-
+    set, then that cpuset defines a sched domain if its 'cpu_exclusive'
+    flag is set.
+
+    If the 'sched_domain_enabled' flag in a cpusets parent -is- set,
+    then that cpuset defines a sched domain if its 'sched_domain'
+    flag is set.
+
+The sched domain defined by such a cpuset consists of all CPUs in
+the current cpuset that are not part of any child cpusets that define
+sched domains of their own.
+
 This ensures that the scheduler load balancing code only balances
 against the CPUs that are in the sched domain as defined above and
 not all of the CPUs in the system. This removes any overhead due to
@@ -394,8 +410,69 @@ policy, especially for jobs that might h
 data set, the memory allocation across the nodes in the jobs cpuset
 can become very uneven.
 
+1.8 Dynamic Scheduler Domains
+
+As described in Documentation/sched-domains.txt, the scheduler
+hierarchically divides the system into scheduling domains, more
+aggressively load balancing within the smaller domains, such as between
+hyperthreads on a core, or cores in a package, and less often load
+balancing across the system.
+
+By default, these scheduling domains are chosen along simple machine
+topology lines, such as cores, packages and nodes.
+
+One can use cpusets to directly define scheduling domains, in order
+to increase dynamic scheduler load balancing within a job, and
+minimize useless efforts to load balance between jobs with disjoint
+cpus_allowed settings.
+
+There are two cpuset settings that affect dynamic sched domain
+placement - the cpu_exclusive flag and the two sched_domain flags:
+
+    Ideally perhaps the cpu_exclusive flag would not matter here.
+
+    But in an effort to save adding another per-cpuset flag to
+    control which cpusets defined sched domains, we initially
+    overloaded the cpu_exclusive flag to define sched domains.
+
+    Later it became clear we needed a separate flag for this.
+    For example we might have an active job on a cpuset that should
+    be a sched domain, with overlapping inactive cpusets, so we could
+    not mark the active jobs cpuset as cpu_exclusive.
+
+    At that time, we had to add not one but two flags, one to enable
+    the other, so that we could maintain backward compatibility with
+    code that only relied on the cpu_exclusive flag for this.
+
+    The sched_domain_enabled flag in a cpuset enables the sched_domain
+    flags in the children of that cpuset.
+
+On creation, a cpuset inherits the sched_domain_enabled flag setting
+of its parent, but its sched_domain flag defaults to off (0).
+
+Two sibling cpusets that are both marked as sched_domains, under a
+parent cpuset whose sched_domain_enabled flag is turned on, cannot
+overlap CPUs with each other.  But they are allowed to overlap
+with any other siblings that are not marked as sched_domains.
+
+Unlike the cpu_exclusive property, there is no requirement that
+a cpuset can only set sched_domain_enabled if its parent does.
+This could result in non-sibling cpusets (cousins) that define
+sched domains and that overlap.  If you do that, then the actual
+resulting sched domain configuration is undetermined, and probably
+depends on what order these cpusets were marked as sched domains.
+
+The top cpuset has no parent.  So settings its sched_domain flag
+does not cause a dynamic scheduler domain to be created.  That's ok,
+as there already is a dynamic scheduler domain for all the CPUs in
+the system anyway.  The sched_domain flag in the top_cpuset has no
+affect.  The sched_domain_enabled flag in the top_cpuset enables the
+sched_domain flags in immediate child cpusets of the top_cpuset, and
+determines the default setting on creation of the sched_domain_enabled
+flag in any additional such cpusets
+
 
-1.8 How do I use cpusets ?
+1.9 How do I use cpusets ?
 --------------------------
 
 In order to minimize the impact of cpusets on critical kernel

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
