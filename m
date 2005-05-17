Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVEQEHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVEQEHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVEQEHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:07:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:46306 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261335AbVEQEGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:06:52 -0400
Date: Tue, 17 May 2005 09:42:19 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] Dynamic sched domains (v0.6)
Message-ID: <20050517041219.GB4596@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050517041031.GA4596@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20050517041031.GA4596@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


o Patch2 has updated cpusets documentation and the core update_cpu_domains
  function
o I have also moved the dentry d_lock as discussed previously



--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyn-sd-rc4mm1-v0.6-2.patch"

diff -Naurp linux-2.6.12-rc4-mm1-1/Documentation/cpusets.txt linux-2.6.12-rc4-mm1-2/Documentation/cpusets.txt
--- linux-2.6.12-rc4-mm1-1/Documentation/cpusets.txt	2005-05-16 15:14:05.000000000 +0530
+++ linux-2.6.12-rc4-mm1-2/Documentation/cpusets.txt	2005-05-16 22:56:43.000000000 +0530
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
+    * Also cpu-exclusive cpusets are useful for servers running orthogonal 
+      workloads such as RT applications requiring low latency and HPC 
+      applications that are throughput sensitive
 
 These subsets, or "soft partitions" must be able to be dynamically
 adjusted, as the job mix changes, without impacting other concurrently
@@ -125,6 +136,8 @@ Cpusets extends these two mechanisms as 
  - A cpuset may be marked exclusive, which ensures that no other
    cpuset (except direct ancestors and descendents) may contain
    any overlapping CPUs or Memory Nodes.
+   Also a cpu-exclusive cpuset would be associated with a sched 
+   domain.
  - You can list all the tasks (by pid) attached to any cpuset.
 
 The implementation of cpusets requires a few, simple hooks
@@ -136,6 +149,9 @@ into the rest of the kernel, none in per
    allowed in that tasks cpuset.
  - in sched.c migrate_all_tasks(), to keep migrating tasks within
    the CPUs allowed by their cpuset, if possible.
+ - in sched.c, a new API partition_sched_domains for handling
+   sched domain changes associated with cpu-exclusive cpusets
+   and related changes in both sched.c and arch/ia64/kernel/domain.c
  - in the mbind and set_mempolicy system calls, to mask the requested
    Memory Nodes by what's allowed in that tasks cpuset.
  - in page_alloc, to restrict memory to allowed nodes.
diff -Naurp linux-2.6.12-rc4-mm1-1/kernel/cpuset.c linux-2.6.12-rc4-mm1-2/kernel/cpuset.c
--- linux-2.6.12-rc4-mm1-1/kernel/cpuset.c	2005-05-16 15:08:08.000000000 +0530
+++ linux-2.6.12-rc4-mm1-2/kernel/cpuset.c	2005-05-16 15:19:54.000000000 +0530
@@ -596,12 +596,62 @@ static int validate_change(const struct 
 	return 0;
 }
 
+/*
+ * For a given cpuset cur, partition the system as follows
+ * a. All cpus in the parent cpuset's cpus_allowed that are not part of any
+ *    exclusive child cpusets
+ * b. All cpus in the current cpuset's cpus_allowed that are not part of any
+ *    exclusive child cpusets
+ * Build these two partitions by calling partition_sched_domains
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
+	}
+	else {
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
-	struct cpuset trialcs;
+	struct cpuset trialcs, oldcs;
 	int retval;
 
-	trialcs = *cs;
+	trialcs = oldcs = *cs;
 	retval = cpulist_parse(buf, trialcs.cpus_allowed);
 	if (retval < 0)
 		return retval;
@@ -609,9 +659,13 @@ static int update_cpumask(struct cpuset 
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
@@ -646,25 +700,28 @@ static int update_nodemask(struct cpuset
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
@@ -1310,12 +1367,14 @@ static int cpuset_rmdir(struct inode *un
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

--IiVenqGWf+H9Y6IX--
