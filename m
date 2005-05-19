Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVESPAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVESPAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVESPAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:00:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21991 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262543AbVESO4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:56:38 -0400
Date: Thu, 19 May 2005 20:36:07 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH 2/3] Dynamic sched domains: cpuset changes
Message-ID: <20050519150607.GB6073@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050519150435.GA6073@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20050519150435.GA6073@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


 Adds the core update_cpu_domains code and updated cpusets documentation

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
Acked-by: Paul Jackson <pj@sgi.com>
Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>




--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd-rc4mm1-v0.6-2.patch"

diff -Naurp linux-2.6.12-rc4-mm1-1/Documentation/cpusets.txt linux-2.6.12-rc4-mm1-2/Documentation/cpusets.txt
--- linux-2.6.12-rc4-mm1-1/Documentation/cpusets.txt	2005-05-16 15:14:05.000000000 +0530
+++ linux-2.6.12-rc4-mm1-2/Documentation/cpusets.txt	2005-05-18 12:40:59.000000000 +0530
@@ -51,6 +51,14 @@ mems_allowed vector.
 
 If a cpuset is cpu or mem exclusive, no other cpuset, other than a direct
 ancestor or descendent, may share any of the same CPUs or Memory Nodes.
+A cpuset that is cpu exclusive has a sched domain associated with it.
+The sched domain consists of all cpus in the current cpuset that are not 
+part of any exclusive child cpusets.
+This ensures that the scheduler load balacing code only balances
+against the cpus that are in the sched domain as defined above and not
+all of the cpus in the system. This removes any overhead due to 
+load balancing code trying to pull tasks outside of the cpu exclusive
+cpuset only to be prevented by the tasks' cpus_allowed mask.
 
 User level code may create and destroy cpusets by name in the cpuset
 virtual file system, manage the attributes and permissions of these
@@ -84,6 +92,9 @@ This can be especially valuable on:
       and a database), or
     * NUMA systems running large HPC applications with demanding
       performance characteristics.
+    * Also cpu_exclusive cpusets are useful for servers running orthogonal 
+      workloads such as RT applications requiring low latency and HPC 
+      applications that are throughput sensitive
 
 These subsets, or "soft partitions" must be able to be dynamically
 adjusted, as the job mix changes, without impacting other concurrently
@@ -125,6 +136,8 @@ Cpusets extends these two mechanisms as 
  - A cpuset may be marked exclusive, which ensures that no other
    cpuset (except direct ancestors and descendents) may contain
    any overlapping CPUs or Memory Nodes.
+   Also a cpu_exclusive cpuset would be associated with a sched 
+   domain.
  - You can list all the tasks (by pid) attached to any cpuset.
 
 The implementation of cpusets requires a few, simple hooks
@@ -136,6 +149,9 @@ into the rest of the kernel, none in per
    allowed in that tasks cpuset.
  - in sched.c migrate_all_tasks(), to keep migrating tasks within
    the CPUs allowed by their cpuset, if possible.
+ - in sched.c, a new API partition_sched_domains for handling
+   sched domain changes associated with cpu_exclusive cpusets
+   and related changes in both sched.c and arch/ia64/kernel/domain.c
  - in the mbind and set_mempolicy system calls, to mask the requested
    Memory Nodes by what's allowed in that tasks cpuset.
  - in page_alloc, to restrict memory to allowed nodes.
diff -Naurp linux-2.6.12-rc4-mm1-1/kernel/cpuset.c linux-2.6.12-rc4-mm1-2/kernel/cpuset.c
--- linux-2.6.12-rc4-mm1-1/kernel/cpuset.c	2005-05-16 15:08:08.000000000 +0530
+++ linux-2.6.12-rc4-mm1-2/kernel/cpuset.c	2005-05-19 12:53:17.000000000 +0530
@@ -596,10 +596,62 @@ static int validate_change(const struct 
 	return 0;
 }
 
+/*
+ * For a given cpuset cur, partition the system as follows
+ * a. All cpus in the parent cpuset's cpus_allowed that are not part of any
+ *    exclusive child cpusets
+ * b. All cpus in the current cpuset's cpus_allowed that are not part of any
+ *    exclusive child cpusets
+ * Build these two partitions by calling partition_sched_domains
+ *
+ * Call with cpuset_sem held.  May nest a call to the
+ * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
+ */
+static void update_cpu_domains(struct cpuset *cur)
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
+		if (is_cpu_exclusive(c))
+			cpus_andnot(pspan, pspan, c->cpus_allowed);
+	}
+	if (is_removed(cur) || !is_cpu_exclusive(cur)) {
+		cpus_or(pspan, pspan, cur->cpus_allowed);
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
+			if (is_cpu_exclusive(c))
+				cpus_andnot(cspan, cspan, c->cpus_allowed);
+		}
+	}
+
+	lock_cpu_hotplug();
+	partition_sched_domains(&pspan, &cspan);
+	unlock_cpu_hotplug();
+}
+
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
-	int retval;
+	int retval, cpus_unchanged;
 
 	trialcs = *cs;
 	retval = cpulist_parse(buf, trialcs.cpus_allowed);
@@ -609,9 +661,13 @@ static int update_cpumask(struct cpuset 
 	if (cpus_empty(trialcs.cpus_allowed))
 		return -ENOSPC;
 	retval = validate_change(cs, &trialcs);
-	if (retval == 0)
-		cs->cpus_allowed = trialcs.cpus_allowed;
-	return retval;
+	if (retval < 0)
+		return retval;
+	cpus_unchanged = cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
+	cs->cpus_allowed = trialcs.cpus_allowed;
+	if (is_cpu_exclusive(cs) && !cpus_unchanged)
+		update_cpu_domains(cs);
+	return 0;
 }
 
 static int update_nodemask(struct cpuset *cs, char *buf)
@@ -647,7 +703,7 @@ static int update_flag(cpuset_flagbits_t
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err;
+	int err, cpu_exclusive_changed;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -658,13 +714,18 @@ static int update_flag(cpuset_flagbits_t
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
+	cpu_exclusive_changed = 
+		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
+	if (turning_on)
+		set_bit(bit, &cs->flags);
+	else
+		clear_bit(bit, &cs->flags);
+
+	if (cpu_exclusive_changed)
+                update_cpu_domains(cs);
+	return 0;
 }
 
 static int attach_task(struct cpuset *cs, char *buf)
@@ -1310,12 +1371,14 @@ static int cpuset_rmdir(struct inode *un
 		up(&cpuset_sem);
 		return -EBUSY;
 	}
-	spin_lock(&cs->dentry->d_lock);
 	parent = cs->parent;
 	set_bit(CS_REMOVED, &cs->flags);
+	if (is_cpu_exclusive(cs))
+		update_cpu_domains(cs);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
 	if (list_empty(&parent->children))
 		check_for_release(parent);
+	spin_lock(&cs->dentry->d_lock);
 	d = dget(cs->dentry);
 	cs->dentry = NULL;
 	spin_unlock(&d->d_lock);

--s2ZSL+KKDSLx8OML--
