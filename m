Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423264AbWJSKZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423264AbWJSKZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161380AbWJSKZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:25:10 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:46940 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161384AbWJSKZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:25:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=ymlLrvyNGTwJagzfmEDvLkF1f9bGWvS+tnvMeHwymyUJERB5w9/Z+4FHm+D6QTT70tkrTV1P4AN/gZ7zjWqOg+Z/KDep2kR+HFOS63a01R3vpbbAZA4gOgLlKbpLdkKc0ysZhKXrndNtxjFU0alb/vgjiq8MRTVVjnfydZkGa6E=  ;
Message-ID: <4537527B.5050401@yahoo.com.au>
Date: Thu, 19 Oct 2006 20:24:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       Paul Menage <menage@google.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Dinakar Guniguntala <dino@in.ibm.com>,
       Rohit Seth <rohitseth@google.com>, Robin Holt <holt@sgi.com>,
       dipankar@in.ibm.com, "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
In-Reply-To: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------000800040204020706000403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000800040204020706000403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paul Jackson wrote:
> From: Paul Jackson <pj@sgi.com>
> 
> Remove the cpuset hooks that defined sched domains depending on the
> setting of the 'cpu_exclusive' flag.

Before we chuck the baby out...

> The cpu_exclusive flag can only be set on a child if it is set on
> the parent.
> 
> This made that flag painfully unsuitable for use as a flag defining
> a partitioning of a system.

Sigh, it isn't. That's simply how cpusets tried to use it.

> It was entirely unobvious to a cpuset user what partitioning of sched
> domains they would be causing when they set that one cpu_exclusive bit
> on one cpuset, because it depended on what CPUs were in the remainder
> of that cpusets siblings and child cpusets, after subtracting out
> other cpu_exclusive cpusets.

As far as a user is concerned, the cpusets is the interface. domain
partitioning is an implementation detail that just happens to make
it work better in some cases.

> Furthermore, there was no way on production systems to query the
> result.

You shouldn't need to, assuming cpusets doesn't mess it up.

Here is an untested patch. Apparently takes care of CPU hotplug too.

-- 
SUSE Labs, Novell Inc.

--------------000800040204020706000403
Content-Type: text/plain;
 name="sched-domains-cpusets-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-domains-cpusets-fixes.patch"

Fix sched-domains partitioning by cpusets. Walk the whole cpusets tree after
something interesting changes, and recreate all partitions.

Index: linux-2.6/kernel/cpuset.c
===================================================================
--- linux-2.6.orig/kernel/cpuset.c	2006-10-19 19:26:54.000000000 +1000
+++ linux-2.6/kernel/cpuset.c	2006-10-19 20:21:29.000000000 +1000
@@ -751,6 +751,24 @@ static int validate_change(const struct 
 	return 0;
 }
 
+static void update_cpu_domains_children(struct cpuset *par,
+					cpumask_t *non_partitioned)
+{
+	struct cpuset *c;
+
+	list_for_each_entry(c, &par->children, sibling) {
+		if (cpus_empty(c->cpus_allowed))
+			continue;
+		if (is_cpu_exclusive(c)) {
+			if (!partition_sched_domains(&c->cpus_allowed)) {
+				cpus_andnot(*non_partitioned,
+					*non_partitioned, c->cpus_allowed);
+			}
+		} else
+			update_cpu_domains_children(c, non_partitioned);
+	}
+}
+
 /*
  * For a given cpuset cur, partition the system as follows
  * a. All cpus in the parent cpuset's cpus_allowed that are not part of any
@@ -760,53 +778,38 @@ static int validate_change(const struct 
  * Build these two partitions by calling partition_sched_domains
  *
  * Call with manage_mutex held.  May nest a call to the
- * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
- * Must not be called holding callback_mutex, because we must
- * not call lock_cpu_hotplug() while holding callback_mutex.
+ * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.  Must not be called holding
+ * callback_mutex, because we must not call lock_cpu_hotplug() while holding
+ * callback_mutex.
  */
 
-static void update_cpu_domains(struct cpuset *cur)
+static void update_cpu_domains(void)
 {
-	struct cpuset *c, *par = cur->parent;
-	cpumask_t pspan, cspan;
+	cpumask_t non_partitioned;
 
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
+	BUG_ON(!mutex_is_locked(&manage_mutex));
 
 	lock_cpu_hotplug();
-	partition_sched_domains(&pspan, &cspan);
+	non_partitioned = top_cpuset.cpus_allowed;
+	update_cpu_domains_children(&top_cpuset, &non_partitioned);
+	partition_sched_domains(&non_partitioned);
 	unlock_cpu_hotplug();
 }
 
 /*
+ * Same as above except called with lock_cpu_hotplug and without manage_mutex.
+ */
+
+int cpuset_hotplug_update_sched_domains(void)
+{
+	cpumask_t non_partitioned;
+
+	non_partitioned = top_cpuset.cpus_allowed;
+	update_cpu_domains_children(&top_cpuset, &non_partitioned);
+	return partition_sched_domains(&non_partitioned);
+}
+
+/*
  * Call with manage_mutex held.  May take callback_mutex during call.
  */
 
@@ -833,8 +836,8 @@ static int update_cpumask(struct cpuset 
 	mutex_lock(&callback_mutex);
 	cs->cpus_allowed = trialcs.cpus_allowed;
 	mutex_unlock(&callback_mutex);
-	if (is_cpu_exclusive(cs) && !cpus_unchanged)
-		update_cpu_domains(cs);
+	if (!cpus_unchanged)
+		update_cpu_domains();
 	return 0;
 }
 
@@ -1067,7 +1070,7 @@ static int update_flag(cpuset_flagbits_t
 	mutex_unlock(&callback_mutex);
 
 	if (cpu_exclusive_changed)
-                update_cpu_domains(cs);
+                update_cpu_domains();
 	return 0;
 }
 
@@ -1931,19 +1934,9 @@ static int cpuset_mkdir(struct inode *di
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
+	int is_exclusive;
 	struct cpuset *cs = dentry->d_fsdata;
 	struct dentry *d;
 	struct cpuset *parent;
@@ -1961,13 +1954,8 @@ static int cpuset_rmdir(struct inode *un
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
+	is_exclusive = is_cpu_exclusive(cs);
+
 	parent = cs->parent;
 	mutex_lock(&callback_mutex);
 	set_bit(CS_REMOVED, &cs->flags);
@@ -1982,8 +1970,13 @@ static int cpuset_rmdir(struct inode *un
 	mutex_unlock(&callback_mutex);
 	if (list_empty(&parent->children))
 		check_for_release(parent, &pathbuf);
+
+	if (is_exclusive)
+		update_cpu_domains();
+
 	mutex_unlock(&manage_mutex);
 	cpuset_release_agent(pathbuf);
+
 	return 0;
 }
 
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2006-10-19 19:24:48.000000000 +1000
+++ linux-2.6/kernel/sched.c	2006-10-19 20:21:50.000000000 +1000
@@ -6586,6 +6586,9 @@ error:
  */
 static int arch_init_sched_domains(const cpumask_t *cpu_map)
 {
+#ifdef CONFIG_CPUSETS
+	return cpuset_hotplug_update_sched_domains();
+#else
 	cpumask_t cpu_default_map;
 	int err;
 
@@ -6599,6 +6602,7 @@ static int arch_init_sched_domains(const
 	err = build_sched_domains(&cpu_default_map);
 
 	return err;
+#endif
 }
 
 static void arch_destroy_sched_domains(const cpumask_t *cpu_map)
@@ -6622,29 +6626,26 @@ static void detach_destroy_domains(const
 
 /*
  * Partition sched domains as specified by the cpumasks below.
- * This attaches all cpus from the cpumasks to the NULL domain,
+ * This attaches all cpus from the partition to the NULL domain,
  * waits for a RCU quiescent period, recalculates sched
- * domain information and then attaches them back to the
- * correct sched domains
- * Call with hotplug lock held
+ * domain information and then attaches them back to their own
+ * isolated partition.
+ *
+ * Called with hotplug lock held
+ *
+ * Returns 0 on success.
  */
-int partition_sched_domains(cpumask_t *partition1, cpumask_t *partition2)
+int partition_sched_domains(cpumask_t *partition)
 {
+	cpumask_t non_isolated_cpus;
 	cpumask_t change_map;
-	int err = 0;
 
-	cpus_and(*partition1, *partition1, cpu_online_map);
-	cpus_and(*partition2, *partition2, cpu_online_map);
-	cpus_or(change_map, *partition1, *partition2);
+	cpus_andnot(non_isolated_cpus, cpu_online_map, cpu_isolated_map);
+	cpus_and(change_map, *partition, non_isolated_cpus);
 
 	/* Detach sched domains from all of the affected cpus */
 	detach_destroy_domains(&change_map);
-	if (!cpus_empty(*partition1))
-		err = build_sched_domains(partition1);
-	if (!err && !cpus_empty(*partition2))
-		err = build_sched_domains(partition2);
-
-	return err;
+	return build_sched_domains(&change_map);
 }
 
 #if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2006-10-19 20:02:24.000000000 +1000
+++ linux-2.6/include/linux/sched.h	2006-10-19 20:02:30.000000000 +1000
@@ -707,8 +707,7 @@ struct sched_domain {
 #endif
 };
 
-extern int partition_sched_domains(cpumask_t *partition1,
-				    cpumask_t *partition2);
+extern int partition_sched_domains(cpumask_t *partition);
 
 /*
  * Maximum cache size the migration-costs auto-tuning code will
Index: linux-2.6/include/linux/cpuset.h
===================================================================
--- linux-2.6.orig/include/linux/cpuset.h	2006-10-19 20:07:24.000000000 +1000
+++ linux-2.6/include/linux/cpuset.h	2006-10-19 20:21:08.000000000 +1000
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_CPUSETS
 
+extern int cpuset_hotplug_update_sched_domains(void);
+
 extern int number_of_cpusets;	/* How many cpusets are defined in system? */
 
 extern int cpuset_init_early(void);

--------------000800040204020706000403--
Send instant messages to your online friends http://au.messenger.yahoo.com 
