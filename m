Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWH0J4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWH0J4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWH0J4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:56:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31125 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932078AbWH0J4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:56:13 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nathanl@austin.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       ntl@pobox.com, y-goto@jp.fujitsu.com, Anton Blanchard <anton@samba.org>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       kamezawa.hiroyu@jp.fujitsu.com
Date: Sun, 27 Aug 2006 02:56:02 -0700
Message-Id: <20060827095602.19300.73358.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset: top_cpuset tracks hotplug changes to node_online_map
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Change the list of memory nodes allowed to tasks in the top
(root) nodeset to dynamically track what cpus are online,
using a call to a cpuset hook from the memory hotplug code.
Make this top cpus file read-only.

On systems that have cpusets configured in their kernel, but
that aren't actively using cpusets (for some distros, this covers
the majority of systems) all tasks end up in the top cpuset.

If that system does support memory hotplug, then these tasks
cannot make use of memory nodes that are added after system boot,
because the memory nodes are not allowed in the top cpuset.
This is a surprising regression over earlier kernels that didn't
have cpusets enabled.

One key motivation for this change is to remain consistent
with the behaviour for the top_cpuset's 'cpus', which is also
read-only, and which automatically tracks the cpu_online_map.

This change also has the minor benefit that it fixes
a long standing, little noticed, minor bug in cpusets.
The cpuset performance tweak to short circuit the
cpuset_zone_allowed() check on systems with just a single
cpuset (see 'number_of_cpusets', in linux/cpuset.h) meant that
simply changing the 'mems' of the top_cpuset had no affect,
even though the change (the write system call) appeared to
succeed.  With the following change, that write to the 'mems'
file fails -EACCES, and the 'mems' file stubbornly refuses
to be changed via user space writes.  Thus no one should be
mislead into thinking they've changed the top_cpusets's 'mems'
when in affect they haven't.

In order to keep the behaviour of cpusets consistent between
systems actively making use of them and systems not using them,
this patch changes the behaviour of the 'mems' file in the top
(root) cpuset, making it read only, and making it automatically
track the value of node_online_map.  Thus tasks in the top
cpuset will have automatic use of hot plugged memory nodes
allowed by their cpuset.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 Documentation/cpusets.txt |   10 +++++-----
 include/linux/cpuset.h    |    4 ++++
 kernel/cpuset.c           |   28 +++++++++++++++++++++++++---
 mm/memory_hotplug.c       |    2 ++
 4 files changed, 36 insertions(+), 8 deletions(-)

--- 2.6.18-rc4-mm3.orig/include/linux/cpuset.h	2006-08-27 00:06:10.245210786 -0700
+++ 2.6.18-rc4-mm3/include/linux/cpuset.h	2006-08-27 01:32:11.935109657 -0700
@@ -63,6 +63,8 @@ static inline int cpuset_do_slab_mem_spr
 	return current->flags & PF_SPREAD_SLAB;
 }
 
+extern void cpuset_track_online_nodes(void);
+
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
@@ -126,6 +128,8 @@ static inline int cpuset_do_slab_mem_spr
 	return 0;
 }
 
+static inline void cpuset_track_online_nodes() {}
+
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
--- 2.6.18-rc4-mm3.orig/kernel/cpuset.c	2006-08-27 01:31:44.086766196 -0700
+++ 2.6.18-rc4-mm3/kernel/cpuset.c	2006-08-27 01:56:06.432676525 -0700
@@ -912,6 +912,10 @@ static int update_nodemask(struct cpuset
 	int fudge;
 	int retval;
 
+	/* top_cpuset.mems_allowed tracks node_online_map; it's read-only */
+	if (cs == &top_cpuset)
+		return -EACCES;
+
 	trialcs = *cs;
 	retval = nodelist_parse(buf, trialcs.mems_allowed);
 	if (retval < 0)
@@ -2042,9 +2046,8 @@ out:
  * (of no affect) on systems that are actively using CPU hotplug
  * but making no active use of cpusets.
  *
- * This handles CPU hotplug (cpuhp) events.  If someday Memory
- * Nodes can be hotplugged (dynamically changing node_online_map)
- * then we should handle that too, perhaps in a similar way.
+ * This routine ensures that top_cpuset.cpus_allowed tracks
+ * cpu_online_map on each CPU hotplug (cpuhp) event.
  */
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -2063,6 +2066,25 @@ static int cpuset_handle_cpuhp(struct no
 }
 #endif
 
+/*
+ * Keep top_cpuset.mems_allowed tracking node_online_map.
+ * Call this routine anytime after you change node_online_map.
+ * See also the previous routine cpuset_handle_cpuhp().
+ */
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+void cpuset_track_online_nodes()
+{
+	mutex_lock(&manage_mutex);
+	mutex_lock(&callback_mutex);
+
+	top_cpuset.mems_allowed = node_online_map;
+
+	mutex_unlock(&callback_mutex);
+	mutex_unlock(&manage_mutex);
+}
+#endif
+
 /**
  * cpuset_init_smp - initialize cpus_allowed
  *
--- 2.6.18-rc4-mm3.orig/mm/memory_hotplug.c	2006-08-27 01:31:12.658378560 -0700
+++ 2.6.18-rc4-mm3/mm/memory_hotplug.c	2006-08-27 01:32:11.943109755 -0700
@@ -281,6 +281,8 @@ int add_memory(int nid, u64 start, u64 s
 	/* we online node here. we can't roll back from here. */
 	node_set_online(nid);
 
+	cpuset_track_online_nodes();
+
 	if (new_pgdat) {
 		ret = register_one_node(nid);
 		/*
--- 2.6.18-rc4-mm3.orig/Documentation/cpusets.txt	2006-08-27 00:06:10.249210836 -0700
+++ 2.6.18-rc4-mm3/Documentation/cpusets.txt	2006-08-27 02:50:24.768597803 -0700
@@ -217,11 +217,11 @@ exclusive cpuset.  Also, the use of a Li
 to represent the cpuset hierarchy provides for a familiar permission
 and name space for cpusets, with a minimum of additional kernel code.
 
-The cpus file in the root (top_cpuset) cpuset is read-only.
-It automatically tracks the value of cpu_online_map, using a CPU
-hotplug notifier.  If and when memory nodes can be hotplugged,
-we expect to make the mems file in the root cpuset read-only
-as well, and have it track the value of node_online_map.
+The cpus and mems files in the root (top_cpuset) cpuset are
+read-only.  The cpus file automatically tracks the value of
+cpu_online_map using a CPU hotplug notifier, and the mems file
+automatically tracks the value of node_online_map using the
+cpuset_track_online_nodes() hook.
 
 
 1.4 What are exclusive cpusets ?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
