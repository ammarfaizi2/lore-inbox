Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161508AbWJ3V3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161508AbWJ3V3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161512AbWJ3V3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:29:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:28559 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161508AbWJ3V3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:29:22 -0500
Date: Tue, 31 Oct 2006 02:59:22 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: [RFC] cpuset:  Explicit dynamic sched domain cpuset flag
Message-ID: <20061030212922.GA20369@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061030212615.GA10567@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20061030212615.GA10567@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The existing cpuset code that partitioned sched domains at the
back of a exclusive cpuset has one major problem. Administrators
will find that tasks assigned to top level cpusets, that contain
child cpusets that are exclusive, can no longer be rebalanced across
the entire cpus_allowed mask. It was felt that instead of overloading
the cpu_exclusive flag to also create sched domains, it would be
better to have a separate flag that denotes a sched domain. That
way the admins have the flexibility to create exclusive cpusets
that do not necessarily define sched domains.

This patch adds a new flag sched_domain. This can only be set on a
cpu_exclusive cpuset. If set then, the sched domain consists of all
CPUs in the current cpuset that are not part of any exclusive child
cpusets that also define sched domains.

However there are 2 additional extensions that may need to be
looked into
1. There is still no way to find the current sched domain
   configuration of the system on demand from userspace.
   (Apart from turning SCHED_DOMAIN_DEBUG on and checking dmesg)
2. A way to specify a NULL sched domain, ie mark an exclusive
   cpuset that defines a sched domain as one with no load balancing.
   This can be accomplished by adding yet another flag that says
   dont load balance (say no_load_balance)

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="add_sd.patch"

Index: linux-2.6.19-rc2/kernel/cpuset.c
===================================================================
--- linux-2.6.19-rc2.orig/kernel/cpuset.c	2006-10-31 00:56:04.000000000 +0530
+++ linux-2.6.19-rc2/kernel/cpuset.c	2006-10-31 01:12:52.000000000 +0530
@@ -104,6 +104,7 @@
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_CPU_EXCLUSIVE,
+	CS_SCHED_DOMAIN,
 	CS_MEM_EXCLUSIVE,
 	CS_MEMORY_MIGRATE,
 	CS_REMOVED,
@@ -118,6 +119,11 @@
 	return test_bit(CS_CPU_EXCLUSIVE, &cs->flags);
 }
 
+static inline int is_sched_domain(const struct cpuset *cs)
+{
+	return test_bit(CS_SCHED_DOMAIN, &cs->flags);
+}
+
 static inline int is_mem_exclusive(const struct cpuset *cs)
 {
 	return test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
@@ -170,7 +176,7 @@
 static int cpuset_mems_generation;
 
 static struct cpuset top_cpuset = {
-	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
+	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_SCHED_DOMAIN) | (1 << CS_MEM_EXCLUSIVE)),
 	.cpus_allowed = CPU_MASK_ALL,
 	.mems_allowed = NODE_MASK_ALL,
 	.count = ATOMIC_INIT(0),
@@ -695,6 +701,7 @@
 	return	cpus_subset(p->cpus_allowed, q->cpus_allowed) &&
 		nodes_subset(p->mems_allowed, q->mems_allowed) &&
 		is_cpu_exclusive(p) <= is_cpu_exclusive(q) &&
+		is_sched_domain(p) <= is_sched_domain(q) &&
 		is_mem_exclusive(p) <= is_mem_exclusive(q);
 }
 
@@ -738,6 +745,10 @@
 	if (!is_cpuset_subset(trial, par))
 		return -EACCES;
 
+	/* We cannot define a sched domain if we are not also exclusive */
+	if (is_sched_domain(trial) && !is_cpu_exclusive(trial))
+		return -EINVAL;
+
 	/* If either I or some sibling (!= me) is exclusive, we can't overlap */
 	list_for_each_entry(c, &par->children, sibling) {
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
@@ -754,13 +765,67 @@
 }
 
 /*
+ * For a given cpuset cur, partition the system as follows
+ * a. All cpus in the parent cpuset's cpus_allowed that are not part of any
+ *    child cpusets defining sched domain
+ * b. All cpus in the current cpuset's cpus_allowed that are not part of any
+ *    child cpusets defining sched domain
+ * Build these two partitions by calling partition_sched_domains
+ *
+ * Call with manage_mutex held.  May nest a call to the
+ * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
+ * Must not be called holding callback_mutex, because we must
+ * not call lock_cpu_hotplug() while holding callback_mutex.
+ */
+
+static void update_sched_domains(struct cpuset *cur)
+{
+	struct cpuset *c, *par = cur->parent;
+	cpumask_t pspan, cspan;
+
+	if (par == NULL || cpus_empty(cur->cpus_allowed))
+		return;
+
+	/*
+	 * Get all cpus from parent's cpus_allowed not part of exclusive
+	 * children
+	 */
+	pspan = par->cpus_allowed;
+	list_for_each_entry(c, &par->children, sibling) {
+		if (is_sched_domain(c))
+			cpus_andnot(pspan, pspan, c->cpus_allowed);
+	}
+	if (!is_sched_domain(cur)) {
+		if (cpus_equal(pspan, cur->cpus_allowed))
+			return;
+		cspan = CPU_MASK_NONE;
+	} else {
+		if (cpus_empty(pspan))
+			return;
+		cspan = cur->cpus_allowed;
+		/*
+		 * Get all cpus from current cpuset's cpus_allowed not part
+		 * of exclusive children
+		 */
+		list_for_each_entry(c, &cur->children, sibling) {
+			if (is_sched_domain(c))
+				cpus_andnot(cspan, cspan, c->cpus_allowed);
+		}
+	}
+
+	lock_cpu_hotplug();
+	partition_sched_domains(&pspan, &cspan);
+	unlock_cpu_hotplug();
+}
+
+/*
  * Call with manage_mutex held.  May take callback_mutex during call.
  */
 
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
-	int retval;
+	int retval, cpus_unchanged;
 
 	/* top_cpuset.cpus_allowed tracks cpu_online_map; it's read-only */
 	if (cs == &top_cpuset)
@@ -776,9 +841,13 @@
 	retval = validate_change(cs, &trialcs);
 	if (retval < 0)
 		return retval;
+	cpus_unchanged = cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
 	mutex_lock(&callback_mutex);
 	cs->cpus_allowed = trialcs.cpus_allowed;
 	mutex_unlock(&callback_mutex);
+	if (is_sched_domain(cs) && !cpus_unchanged)
+		update_sched_domains(cs);
+
 	return 0;
 }
 
@@ -988,7 +1057,7 @@
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err;
+	int err, sched_domain_changed;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -1005,6 +1074,11 @@
 	cs->flags = trialcs.flags;
 	mutex_unlock(&callback_mutex);
 
+	sched_domain_changed =
+		(is_sched_domain(cs) != is_sched_domain(&trialcs));
+	if (sched_domain_changed)
+		update_sched_domains(cs);
+
 	return 0;
 }
 
@@ -1209,6 +1283,7 @@
 	FILE_CPULIST,
 	FILE_MEMLIST,
 	FILE_CPU_EXCLUSIVE,
+	FILE_SCHED_DOMAIN,
 	FILE_MEM_EXCLUSIVE,
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_MEMORY_PRESSURE_ENABLED,
@@ -1259,6 +1334,9 @@
 	case FILE_CPU_EXCLUSIVE:
 		retval = update_flag(CS_CPU_EXCLUSIVE, cs, buffer);
 		break;
+	case FILE_SCHED_DOMAIN:
+		retval = update_flag(CS_SCHED_DOMAIN, cs, buffer);
+		break;
 	case FILE_MEM_EXCLUSIVE:
 		retval = update_flag(CS_MEM_EXCLUSIVE, cs, buffer);
 		break;
@@ -1376,6 +1454,9 @@
 	case FILE_CPU_EXCLUSIVE:
 		*s++ = is_cpu_exclusive(cs) ? '1' : '0';
 		break;
+	case FILE_SCHED_DOMAIN:
+		*s++ = is_sched_domain(cs) ? '1' : '0';
+		break;
 	case FILE_MEM_EXCLUSIVE:
 		*s++ = is_mem_exclusive(cs) ? '1' : '0';
 		break;
@@ -1735,6 +1816,11 @@
 	.private = FILE_CPU_EXCLUSIVE,
 };
 
+static struct cftype cft_sched_domain = {
+	.name = "sched_domain",
+	.private = FILE_SCHED_DOMAIN,
+};
+
 static struct cftype cft_mem_exclusive = {
 	.name = "mem_exclusive",
 	.private = FILE_MEM_EXCLUSIVE,
@@ -1780,6 +1866,8 @@
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_cpu_exclusive)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_sched_domain)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_mem_exclusive)) < 0)
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
@@ -1868,6 +1956,17 @@
 	return cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
 }
 
+/*
+ * Locking note on the strange update_flag() call below:
+ *
+ * If the cpuset being removed is marked cpu_exclusive, then simulate
+ * turning cpu_exclusive off, which will call update_cpu_domains().
+ * The lock_cpu_hotplug() call in update_cpu_domains() must not be
+ * made while holding callback_mutex.  Elsewhere the kernel nests
+ * callback_mutex inside lock_cpu_hotplug() calls.  So the reverse
+ * nesting would risk an ABBA deadlock.
+ */
+
 static int cpuset_rmdir(struct inode *unused_dir, struct dentry *dentry)
 {
 	struct cpuset *cs = dentry->d_fsdata;
@@ -1887,6 +1986,13 @@
 		mutex_unlock(&manage_mutex);
 		return -EBUSY;
 	}
+	if (is_sched_domain(cs)) {
+		int retval = update_flag(CS_SCHED_DOMAIN, cs, "0");
+		if (retval < 0) {
+			mutex_unlock(&manage_mutex);
+			return retval;
+		}
+	}
 	parent = cs->parent;
 	mutex_lock(&callback_mutex);
 	set_bit(CS_REMOVED, &cs->flags);
Index: linux-2.6.19-rc2/Documentation/cpusets.txt
===================================================================
--- linux-2.6.19-rc2.orig/Documentation/cpusets.txt	2006-10-31 00:55:02.000000000 +0530
+++ linux-2.6.19-rc2/Documentation/cpusets.txt	2006-10-31 02:23:23.000000000 +0530
@@ -86,7 +86,7 @@
       and a database), or
     * NUMA systems running large HPC applications with demanding
       performance characteristics.
-    * Also cpu_exclusive cpusets are useful for servers running orthogonal
+    * Also sched_domain cpusets are useful for servers running orthogonal
       workloads such as RT applications requiring low latency and HPC
       applications that are throughput sensitive
 
@@ -131,8 +131,8 @@
  - A cpuset may be marked exclusive, which ensures that no other
    cpuset (except direct ancestors and descendents) may contain
    any overlapping CPUs or Memory Nodes.
-   Also a cpu_exclusive cpuset would be associated with a sched
-   domain.
+ - Also a cpu_exclusive cpuset would be associated with a sched
+   domain, if the sched_domain flag is turned on.
  - You can list all the tasks (by pid) attached to any cpuset.
 
 The implementation of cpusets requires a few, simple hooks
@@ -177,6 +177,7 @@
  - mems: list of Memory Nodes in that cpuset
  - memory_migrate flag: if set, move pages to cpusets nodes
  - cpu_exclusive flag: is cpu placement exclusive?
+ - sched_domain flag: if turned on, cpusets 'cpus' define a sched domain
  - mem_exclusive flag: is memory placement exclusive?
  - tasks: list of tasks (by pid) attached to that cpuset
  - notify_on_release flag: run /sbin/cpuset_release_agent on exit?
@@ -231,9 +232,10 @@
 a direct ancestor or descendent, may share any of the same CPUs or
 Memory Nodes.
 
-A cpuset that is cpu_exclusive has a scheduler (sched) domain
-associated with it.  The sched domain consists of all CPUs in the
-current cpuset that are not part of any exclusive child cpusets.
+A cpuset that is cpu_exclusive can be used to define a scheduler
+(sched) domain if the sched_domain flag is turned on. The sched domain
+consists of all CPUs in the current cpuset that are not part of any
+exclusive child cpusets that also define sched domains.
 This ensures that the scheduler load balancing code only balances
 against the CPUs that are in the sched domain as defined above and
 not all of the CPUs in the system. This removes any overhead due to

--huq684BweRXVnRxX--
