Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWH2GIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWH2GIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 02:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWH2GIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 02:08:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18600 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751258AbWH2GIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 02:08:42 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nathanl@austin.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       ntl@pobox.com, y-goto@jp.fujitsu.com, Anton Blanchard <anton@samba.org>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       kamezawa.hiroyu@jp.fujitsu.com
Date: Mon, 28 Aug 2006 23:08:24 -0700
Message-Id: <20060829060824.6621.28300.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset: hotunplug cpus and mems in all cpusets
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The cpuset code handling hot unplug of CPUs or Memory Nodes
was incorrect - it could remove a CPU or Node from the top
cpuset, while leaving it still in some child cpusets.

One basic rule of cpusets is that each cpusets cpus and mems
are subsets of its parents.  The cpuset hot unplug code
violated this rule.

So the cpuset hotunplug handler must walk down the tree,
removing any removed CPU or Node from all cpusets.

However, it is not allowed to make a cpusets cpus or mems
become empty.  They can only transition from empty to non-empty,
not back.

So if the last CPU or Node would be removed from a cpuset by
the above walk, we scan back up the cpuset hierarchy, finding
the nearest ancestor that still has something online, and copy
its CPU or Memory placement.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

Anton or Nathan - can you test this again?  I still lack any
hotplug enabled test rig.  It builds, boots and still does
the usual cpuset unit tests just fine on ia64.

Andrew - I see you've sent one of these patches onto Linus:
    cpuset: top_cpuset tracks hotplug changes to cpu_online_map
but you are still holding in *-mm this patch:
    cpuset: top_cpuset tracks hotplug changes to node_online_map
So far as I can see - ** good **.  I am not aware of any reason
to hurry sending along the second patch above, or this new patch
here.  Whether they end up in 2.6.18 o 2.6.19 doesn't matter
so far as I know.

I think I am done with this patch series now -- but I thought
that the last two times as well, so that apparently means
little.


 kernel/cpuset.c |   87 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 17 deletions(-)

--- 2.6.18-rc4-mm3.orig/kernel/cpuset.c	2006-08-28 19:18:39.384949360 -0700
+++ 2.6.18-rc4-mm3/kernel/cpuset.c	2006-08-28 22:29:38.668178349 -0700
@@ -2040,48 +2040,101 @@ out:
 	return err;
 }
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
 /*
- * The top_cpuset tracks what CPUs and Memory Nodes are online,
- * period.  This is necessary in order to make cpusets transparent
- * (of no affect) on systems that are actively using CPU hotplug
- * but making no active use of cpusets.
+ * If common_cpu_mem_hotplug_unplug(), below, unplugs any CPUs
+ * or memory nodes, we need to walk over the cpuset hierarchy,
+ * removing that CPU or node from all cpusets.  If this removes the
+ * last CPU or node from a cpuset, then the guarantee_online_cpus()
+ * or guarantee_online_mems() code will use that emptied cpusets
+ * parent online CPUs or nodes.  Cpusets that were already empty of
+ * CPUs or nodes are left empty.
+ *
+ * This routine is intentionally inefficient in a couple of regards.
+ * It will check all cpusets in a subtree even if the top cpuset of
+ * the subtree has no offline CPUs or nodes.  It checks both CPUs and
+ * nodes, even though the caller could have been coded to know that
+ * only one of CPUs or nodes needed to be checked on a given call.
+ * This was done to minimize text size rather than cpu cycles.
  *
- * This routine ensures that top_cpuset.cpus_allowed tracks
- * cpu_online_map on each CPU hotplug (cpuhp) event.
+ * Call with both manage_mutex and callback_mutex held.
+ *
+ * Recursive, on depth of cpuset subtree.
  */
 
-#ifdef CONFIG_HOTPLUG_CPU
-static int cpuset_handle_cpuhp(struct notifier_block *nb,
-				unsigned long phase, void *cpu)
+static void guarantee_online_cpus_mems_in_subtree(const struct cpuset *cur)
+{
+	struct cpuset *c;
+
+	/* Each of our child cpusets mems must be online */
+	list_for_each_entry(c, &cur->children, sibling) {
+		guarantee_online_cpus_mems_in_subtree(c);
+		if (!cpus_empty(c->cpus_allowed))
+			guarantee_online_cpus(c, &c->cpus_allowed);
+		if (!nodes_empty(c->mems_allowed))
+			guarantee_online_mems(c, &c->mems_allowed);
+	}
+}
+
+/*
+ * The cpus_allowed and mems_allowed nodemasks in the top_cpuset track
+ * cpu_online_map and node_online_map.  Force the top cpuset to track
+ * whats online after any CPU or memory node hotplug or unplug event.
+ *
+ * To ensure that we don't remove a CPU or node from the top cpuset
+ * that is currently in use by a child cpuset (which would violate
+ * the rule that cpusets must be subsets of their parent), we first
+ * call the recursive routine guarantee_online_cpus_mems_in_subtree().
+ *
+ * Since there are two callers of this routine, one for CPU hotplug
+ * events and one for memory node hotplug events, we could have coded
+ * two separate routines here.  We code it as a single common routine
+ * in order to minimize text size.
+ */
+
+static void common_cpu_mem_hotplug_unplug(void)
 {
 	mutex_lock(&manage_mutex);
 	mutex_lock(&callback_mutex);
 
+	guarantee_online_cpus_mems_in_subtree(&top_cpuset);
 	top_cpuset.cpus_allowed = cpu_online_map;
+	top_cpuset.mems_allowed = node_online_map;
 
 	mutex_unlock(&callback_mutex);
 	mutex_unlock(&manage_mutex);
+}
+#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * The top_cpuset tracks what CPUs and Memory Nodes are online,
+ * period.  This is necessary in order to make cpusets transparent
+ * (of no affect) on systems that are actively using CPU hotplug
+ * but making no active use of cpusets.
+ *
+ * This routine ensures that top_cpuset.cpus_allowed tracks
+ * cpu_online_map on each CPU hotplug (cpuhp) event.
+ */
 
+static int cpuset_handle_cpuhp(struct notifier_block *nb,
+				unsigned long phase, void *cpu)
+{
+	common_cpu_mem_hotplug_unplug();
 	return 0;
 }
 #endif
 
+#ifdef CONFIG_MEMORY_HOTPLUG
 /*
  * Keep top_cpuset.mems_allowed tracking node_online_map.
  * Call this routine anytime after you change node_online_map.
  * See also the previous routine cpuset_handle_cpuhp().
  */
 
-#ifdef CONFIG_MEMORY_HOTPLUG
 void cpuset_track_online_nodes()
 {
-	mutex_lock(&manage_mutex);
-	mutex_lock(&callback_mutex);
-
-	top_cpuset.mems_allowed = node_online_map;
-
-	mutex_unlock(&callback_mutex);
-	mutex_unlock(&manage_mutex);
+	common_cpu_mem_hotplug_unplug();
 }
 #endif
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
