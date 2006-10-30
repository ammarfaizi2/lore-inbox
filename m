Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161505AbWJ3V0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161505AbWJ3V0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161504AbWJ3V0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:26:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:35975 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161507AbWJ3V0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:26:19 -0500
Date: Tue, 31 Oct 2006 02:56:15 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: [RFC] cpuset:  Remove sched domain hooks from cpusets
Message-ID: <20061030212615.GA10567@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Remove the cpuset hooks that defined sched domains depending on the
setting of the 'cpu_exclusive' flag.

This patch is similar to what Paul Jackson had sent earlier, except that
since I am also attaching the alternative implementation in my next mail,
I didnt see the need to remove the API from sched.c

The existing cpuset code that partitioned sched domains at the
back of a exclusive cpuset has one major problem. Administrators
will find that tasks assigned to top level cpusets, that contain
child cpusets that are exclusive, can no longer be rebalanced across
the entire cpus_allowed mask. It was felt that instead of overloading
the cpu_exclusive flag to also create sched domains, it would be
better to have a separate flag that denotes a sched domain. That
way the admins have the flexibility to create exclusive cpusets
that do not necessarily define sched domains.

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pj-rem.patch"

Index: latest/kernel/cpuset.c
===================================================================
--- latest.orig/kernel/cpuset.c	2006-10-29 16:46:07.000000000 +0530
+++ latest/kernel/cpuset.c	2006-10-29 16:46:30.000000000 +0530
@@ -754,68 +754,13 @@
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
@@ -831,12 +776,9 @@
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
 
@@ -1046,7 +988,7 @@
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err, cpu_exclusive_changed;
+	int err;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -1059,14 +1001,10 @@
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
 
@@ -1930,17 +1868,6 @@
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
@@ -1960,13 +1887,6 @@
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

--bp/iNruPH9dso1Pn--
