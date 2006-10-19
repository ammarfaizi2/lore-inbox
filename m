Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWJSJYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWJSJYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWJSJYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:24:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44938 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030363AbWJSJYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:24:03 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@google.com>, Paul Menage <menage@google.com>,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Rohit Seth <rohitseth@google.com>, Robin Holt <holt@sgi.com>,
       dipankar@in.ibm.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Jackson <pj@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Date: Thu, 19 Oct 2006 02:23:58 -0700
Message-Id: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
Subject: [RFC] cpuset: remove sched domain hooks from cpusets
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Remove the cpuset hooks that defined sched domains depending on the
setting of the 'cpu_exclusive' flag.

The cpu_exclusive flag can only be set on a child if it is set on
the parent.

This made that flag painfully unsuitable for use as a flag defining
a partitioning of a system.

It was entirely unobvious to a cpuset user what partitioning of sched
domains they would be causing when they set that one cpu_exclusive bit
on one cpuset, because it depended on what CPUs were in the remainder
of that cpusets siblings and child cpusets, after subtracting out
other cpu_exclusive cpusets.

Furthermore, there was no way on production systems to query the
result.

Using the cpu_exclusive flag for this was simply wrong from the get go.

Fortunately, it was sufficiently borked that so far as I know, no
one has made much use of this feature, past the simplest case of
isolating some CPUs from scheduler balancing.  A future patch will
propose a simple mechanism for this simple case.

Furthermore, since there was no way on a running system to see what
one was doing with sched domains, this change will be invisible to
any using code.  Unless they have deep insight to the scheduler load
balancing choices, they will be unable to detect that this change
has been made in the kernel's behaviour.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 Documentation/cpusets.txt |   17 ---------
 include/linux/sched.h     |    3 -
 kernel/cpuset.c           |   84 +---------------------------------------------
 kernel/sched.c            |   27 --------------
 4 files changed, 2 insertions(+), 129 deletions(-)

--- 2.6.19-rc1-mm1.orig/kernel/cpuset.c	2006-10-19 01:47:50.000000000 -0700
+++ 2.6.19-rc1-mm1/kernel/cpuset.c	2006-10-19 01:48:10.000000000 -0700
@@ -754,68 +754,13 @@ static int validate_change(const struct 
 }
 
 /*
- * For a given cpuset cur, partition the system as follows
- * a. All cpus in the parent cpuset's cpus_allowed that are not part of any
- *    exclusive child cpusets
- * b. All cpus in the current cpuset's cpus_allowed that are not part of any
- *    exclusive child cpusets
- * Build these two partitions by calling partition_sched_domains
- *
- * Call with manage_mutex held.  May nest a call to the
- * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
- * Must not be called holding callback_mutex, because we must
- * not call lock_cpu_hotplug() while holding callback_mutex.
- */
-
-static void update_cpu_domains(struct cpuset *cur)
-{
-	struct cpuset *c, *par = cur->parent;
-	cpumask_t pspan, cspan;
-
-	if (par == NULL || cpus_empty(cur->cpus_allowed))
-		return;
-
-	/*
-	 * Get all cpus from parent's cpus_allowed not part of exclusive
-	 * children
-	 */
-	pspan = par->cpus_allowed;
-	list_for_each_entry(c, &par->children, sibling) {
-		if (is_cpu_exclusive(c))
-			cpus_andnot(pspan, pspan, c->cpus_allowed);
-	}
-	if (!is_cpu_exclusive(cur)) {
-		cpus_or(pspan, pspan, cur->cpus_allowed);
-		if (cpus_equal(pspan, cur->cpus_allowed))
-			return;
-		cspan = CPU_MASK_NONE;
-	} else {
-		if (cpus_empty(pspan))
-			return;
-		cspan = cur->cpus_allowed;
-		/*
-		 * Get all cpus from current cpuset's cpus_allowed not part
-		 * of exclusive children
-		 */
-		list_for_each_entry(c, &cur->children, sibling) {
-			if (is_cpu_exclusive(c))
-				cpus_andnot(cspan, cspan, c->cpus_allowed);
-		}
-	}
-
-	lock_cpu_hotplug();
-	partition_sched_domains(&pspan, &cspan);
-	unlock_cpu_hotplug();
-}
-
-/*
  * Call with manage_mutex held.  May take callback_mutex during call.
  */
 
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
-	int retval, cpus_unchanged;
+	int retval;
 
 	/* top_cpuset.cpus_allowed tracks cpu_online_map; it's read-only */
 	if (cs == &top_cpuset)
@@ -831,12 +776,9 @@ static int update_cpumask(struct cpuset 
 	retval = validate_change(cs, &trialcs);
 	if (retval < 0)
 		return retval;
-	cpus_unchanged = cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
 	mutex_lock(&callback_mutex);
 	cs->cpus_allowed = trialcs.cpus_allowed;
 	mutex_unlock(&callback_mutex);
-	if (is_cpu_exclusive(cs) && !cpus_unchanged)
-		update_cpu_domains(cs);
 	return 0;
 }
 
@@ -1046,7 +988,7 @@ static int update_flag(cpuset_flagbits_t
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err, cpu_exclusive_changed;
+	int err;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -1059,14 +1001,10 @@ static int update_flag(cpuset_flagbits_t
 	err = validate_change(cs, &trialcs);
 	if (err < 0)
 		return err;
-	cpu_exclusive_changed =
-		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
 	mutex_lock(&callback_mutex);
 	cs->flags = trialcs.flags;
 	mutex_unlock(&callback_mutex);
 
-	if (cpu_exclusive_changed)
-                update_cpu_domains(cs);
 	return 0;
 }
 
@@ -1930,17 +1868,6 @@ static int cpuset_mkdir(struct inode *di
 	return cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
 }
 
-/*
- * Locking note on the strange update_flag() call below:
- *
- * If the cpuset being removed is marked cpu_exclusive, then simulate
- * turning cpu_exclusive off, which will call update_cpu_domains().
- * The lock_cpu_hotplug() call in update_cpu_domains() must not be
- * made while holding callback_mutex.  Elsewhere the kernel nests
- * callback_mutex inside lock_cpu_hotplug() calls.  So the reverse
- * nesting would risk an ABBA deadlock.
- */
-
 static int cpuset_rmdir(struct inode *unused_dir, struct dentry *dentry)
 {
 	struct cpuset *cs = dentry->d_fsdata;
@@ -1960,13 +1887,6 @@ static int cpuset_rmdir(struct inode *un
 		mutex_unlock(&manage_mutex);
 		return -EBUSY;
 	}
-	if (is_cpu_exclusive(cs)) {
-		int retval = update_flag(CS_CPU_EXCLUSIVE, cs, "0");
-		if (retval < 0) {
-			mutex_unlock(&manage_mutex);
-			return retval;
-		}
-	}
 	parent = cs->parent;
 	mutex_lock(&callback_mutex);
 	set_bit(CS_REMOVED, &cs->flags);
--- 2.6.19-rc1-mm1.orig/Documentation/cpusets.txt	2006-10-19 01:47:09.000000000 -0700
+++ 2.6.19-rc1-mm1/Documentation/cpusets.txt	2006-10-19 01:48:10.000000000 -0700
@@ -86,9 +86,6 @@ This can be especially valuable on:
       and a database), or
     * NUMA systems running large HPC applications with demanding
       performance characteristics.
-    * Also cpu_exclusive cpusets are useful for servers running orthogonal
-      workloads such as RT applications requiring low latency and HPC
-      applications that are throughput sensitive
 
 These subsets, or "soft partitions" must be able to be dynamically
 adjusted, as the job mix changes, without impacting other concurrently
@@ -131,8 +128,6 @@ Cpusets extends these two mechanisms as 
  - A cpuset may be marked exclusive, which ensures that no other
    cpuset (except direct ancestors and descendents) may contain
    any overlapping CPUs or Memory Nodes.
-   Also a cpu_exclusive cpuset would be associated with a sched
-   domain.
  - You can list all the tasks (by pid) attached to any cpuset.
 
 The implementation of cpusets requires a few, simple hooks
@@ -144,9 +139,6 @@ into the rest of the kernel, none in per
    allowed in that tasks cpuset.
  - in sched.c migrate_all_tasks(), to keep migrating tasks within
    the CPUs allowed by their cpuset, if possible.
- - in sched.c, a new API partition_sched_domains for handling
-   sched domain changes associated with cpu_exclusive cpusets
-   and related changes in both sched.c and arch/ia64/kernel/domain.c
  - in the mbind and set_mempolicy system calls, to mask the requested
    Memory Nodes by what's allowed in that tasks cpuset.
  - in page_alloc.c, to restrict memory to allowed nodes.
@@ -231,15 +223,6 @@ If a cpuset is cpu or mem exclusive, no 
 a direct ancestor or descendent, may share any of the same CPUs or
 Memory Nodes.
 
-A cpuset that is cpu_exclusive has a scheduler (sched) domain
-associated with it.  The sched domain consists of all CPUs in the
-current cpuset that are not part of any exclusive child cpusets.
-This ensures that the scheduler load balancing code only balances
-against the CPUs that are in the sched domain as defined above and
-not all of the CPUs in the system. This removes any overhead due to
-load balancing code trying to pull tasks outside of the cpu_exclusive
-cpuset only to be prevented by the tasks' cpus_allowed mask.
-
 A cpuset that is mem_exclusive restricts kernel allocations for
 page, buffer and other data commonly shared by the kernel across
 multiple users.  All cpusets, whether mem_exclusive or not, restrict
--- 2.6.19-rc1-mm1.orig/include/linux/sched.h	2006-10-19 01:47:09.000000000 -0700
+++ 2.6.19-rc1-mm1/include/linux/sched.h	2006-10-19 01:48:10.000000000 -0700
@@ -715,9 +715,6 @@ struct sched_domain {
 #endif
 };
 
-extern int partition_sched_domains(cpumask_t *partition1,
-				    cpumask_t *partition2);
-
 /*
  * Maximum cache size the migration-costs auto-tuning code will
  * search from:
--- 2.6.19-rc1-mm1.orig/kernel/sched.c	2006-10-19 01:47:09.000000000 -0700
+++ 2.6.19-rc1-mm1/kernel/sched.c	2006-10-19 01:48:10.000000000 -0700
@@ -6735,33 +6735,6 @@ static void detach_destroy_domains(const
 	arch_destroy_sched_domains(cpu_map);
 }
 
-/*
- * Partition sched domains as specified by the cpumasks below.
- * This attaches all cpus from the cpumasks to the NULL domain,
- * waits for a RCU quiescent period, recalculates sched
- * domain information and then attaches them back to the
- * correct sched domains
- * Call with hotplug lock held
- */
-int partition_sched_domains(cpumask_t *partition1, cpumask_t *partition2)
-{
-	cpumask_t change_map;
-	int err = 0;
-
-	cpus_and(*partition1, *partition1, cpu_online_map);
-	cpus_and(*partition2, *partition2, cpu_online_map);
-	cpus_or(change_map, *partition1, *partition2);
-
-	/* Detach sched domains from all of the affected cpus */
-	detach_destroy_domains(&change_map);
-	if (!cpus_empty(*partition1))
-		err = build_sched_domains(partition1);
-	if (!err && !cpus_empty(*partition2))
-		err = build_sched_domains(partition2);
-
-	return err;
-}
-
 #if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
 int arch_reinit_sched_domains(void)
 {

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
