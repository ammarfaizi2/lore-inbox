Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWBISzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWBISzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWBISyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:54:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24969 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750705AbWBISyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:54:39 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Thu, 09 Feb 2006 10:54:29 -0800
Message-Id: <20060209185429.8596.58223.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
References: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH v2 03/07] cpuset memory spread basic implementation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

This patch provides the implementation and cpuset interface for
an alternative memory allocation policy that can be applied to
certain kinds of memory allocations, such as the page cache (file
system buffers) and some slab caches (such as inode caches).

The policy is called "memory spreading."  If enabled, it
spreads out these kinds of memory allocations over all the
nodes allowed to a task, instead of preferring to place them
on the node where the task is executing.

All other kinds of allocations, including anonymous pages for
a tasks stack and data regions, are not affected by this policy
choice, and continue to be allocated preferring the node local
to execution, as modified by the NUMA mempolicy.

There are two boolean flag files per cpuset that control
where the kernel allocates pages for the file system buffers
and related in kernel data structures.  They are called
'memory_spread_page' and 'memory_spread_slab'.

If the per-cpuset boolean flag file 'memory_spread_page' is set,
then the kernel will spread the file system buffers (page cache)
evenly over all the nodes that the faulting task is allowed
to use, instead of preferring to put those pages on the node
where the task is running.

If the per-cpuset boolean flag file 'memory_spread_slab' is set,
then the kernel will spread some file system related slab caches,
such as for inodes and dentries evenly over all the nodes that
the faulting task is allowed to use, instead of preferring to
put those pages on the node where the task is running.

The implementation is simple.  Setting the cpuset flags
'memory_spread_page' or 'memory_spread_cache' turns on the
per-process flags PF_SPREAD_PAGE or PF_SPREAD_SLAB, respectively,
for each task that is in the cpuset or subsequently joins that
cpuset.  In subsequent patches, the page allocation calls for
the affected page cache and slab caches are modified to perform
an inline check for these flags, and if set, a call to a new
routine cpuset_mem_spread_node() returns the node to prefer
for the allocation.

The cpuset_mem_spread_node() routine is also simple.  It uses
the value of a per-task rotor cpuset_mem_spread_rotor to select
the next node in the current tasks mems_allowed to prefer for
the allocation.

This policy can provide substantial improvements for jobs that
need to place thread local data on the corresponding node, but
that need to access large file system data sets that need to
be spread across the several nodes in the jobs cpuset in order
to fit.  Without this patch, especially for jobs that might
have one thread reading in the data set, the memory allocation
across the nodes in the jobs cpuset can become very uneven.

A couple of Copyright year ranges are updated as well.  And a
couple of email addresses that can be found in the MAINTAINERS
file are removed.

Signed-off-by: Paul Jackson <pj@sgi.com>


---

 Documentation/cpusets.txt |   76 ++++++++++++++++++++++++++++++++-
 include/linux/cpuset.h    |   29 ++++++++++++
 include/linux/sched.h     |    3 +
 kernel/cpuset.c           |  104 +++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 203 insertions(+), 9 deletions(-)

--- v2.6.16-rc2.orig/Documentation/cpusets.txt	2006-02-08 22:46:56.000000000 -0800
+++ v2.6.16-rc2/Documentation/cpusets.txt	2006-02-08 22:47:01.000000000 -0800
@@ -17,7 +17,8 @@ CONTENTS:
   1.4 What are exclusive cpusets ?
   1.5 What does notify_on_release do ?
   1.6 What is memory_pressure ?
-  1.7 How do I use cpusets ?
+  1.7 What is memory spread ?
+  1.8 How do I use cpusets ?
 2. Usage Examples and Syntax
   2.1 Basic Usage
   2.2 Adding/removing cpus
@@ -315,7 +316,78 @@ the tasks in the cpuset, in units of rec
 times 1000.
 
 
-1.7 How do I use cpusets ?
+1.7 What is memory spread ?
+---------------------------
+There are two boolean flag files per cpuset that control where the
+kernel allocates pages for the file system buffers and related in
+kernel data structures.  They are called 'memory_spread_page' and
+'memory_spread_slab'.
+
+If the per-cpuset boolean flag file 'memory_spread_page' is set, then
+the kernel will spread the file system buffers (page cache) evenly
+over all the nodes that the faulting task is allowed to use, instead
+of preferring to put those pages on the node where the task is running.
+
+If the per-cpuset boolean flag file 'memory_spread_slab' is set,
+then the kernel will spread some file system related slab caches,
+such as for inodes and dentries evenly over all the nodes that the
+faulting task is allowed to use, instead of preferring to put those
+pages on the node where the task is running.
+
+The setting of these flags does not affect anonymous data segment or
+stack segment pages of a task.
+
+By default, both kinds of memory spreading are off, and memory
+pages are allocated on the node local to where the task is running,
+except perhaps as modified by the tasks NUMA mempolicy or cpuset
+configuration, so long as sufficient free memory pages are available.
+
+When new cpusets are created, they inherit the memory spread settings
+of their parent.
+
+Setting memory spreading causes allocations for the affected page
+or slab caches to ignore the tasks NUMA mempolicy and be spread
+instead.    Tasks using mbind() or set_mempolicy() calls to set NUMA
+mempolicies will not notice any change in these calls as a result of
+their containing tasks memory spread settings.  If memory spreading
+is turned off, then the currently specified NUMA mempolicy once again
+applies to memory page allocations.
+
+Both 'memory_spread_page' and 'memory_spread_slab' are boolean flag
+files.  By default they contain "0", meaning that the feature is off
+for that cpuset.  If a "1" is written to that file, then that turns
+the named feature on.
+
+The implementation is simple.
+
+Setting the flag 'memory_spread_page' turns on a per-process flag
+PF_SPREAD_PAGE for each task that is in that cpuset or subsequently
+joins that cpuset.  The page allocation calls for the page cache
+is modified to perform an inline check for this PF_SPREAD_PAGE task
+flag, and if set, a call to a new routine cpuset_mem_spread_node()
+returns the node to prefer for the allocation.
+
+Similarly, setting 'memory_spread_cache' turns on the flag
+PF_SPREAD_SLAB, and appropriately marked slab caches will allocate
+pages from the node returned by cpuset_mem_spread_node().
+
+The cpuset_mem_spread_node() routine is also simple.  It uses the
+value of a per-task rotor cpuset_mem_spread_rotor to select the next
+node in the current tasks mems_allowed to prefer for the allocation.
+
+This memory placement policy is also known (in other contexts) as
+round-robin or interleave.
+
+This policy can provide substantial improvements for jobs that need
+to place thread local data on the corresponding node, but that need
+to access large file system data sets that need to be spread across
+the several nodes in the jobs cpuset in order to fit.  Without this
+policy, especially for jobs that might have one thread reading in the
+data set, the memory allocation across the nodes in the jobs cpuset
+can become very uneven.
+
+
+1.8 How do I use cpusets ?
 --------------------------
 
 In order to minimize the impact of cpusets on critical kernel
--- v2.6.16-rc2.orig/include/linux/cpuset.h	2006-02-08 22:46:56.000000000 -0800
+++ v2.6.16-rc2/include/linux/cpuset.h	2006-02-08 22:47:01.000000000 -0800
@@ -4,7 +4,7 @@
  *  cpuset interface
  *
  *  Copyright (C) 2003 BULL SA
- *  Copyright (C) 2004 Silicon Graphics, Inc.
+ *  Copyright (C) 2004-2006 Silicon Graphics, Inc.
  *
  */
 
@@ -51,6 +51,18 @@ extern char *cpuset_task_status_allowed(
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 
+extern int cpuset_mem_spread_node(void);
+
+static inline int cpuset_do_page_mem_spread(void)
+{
+	return current->flags & PF_SPREAD_PAGE;
+}
+
+static inline int cpuset_do_slab_mem_spread(void)
+{
+	return current->flags & PF_SPREAD_SLAB;
+}
+
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
@@ -99,6 +111,21 @@ static inline char *cpuset_task_status_a
 static inline void cpuset_lock(void) {}
 static inline void cpuset_unlock(void) {}
 
+static inline int cpuset_mem_spread_node(void)
+{
+	return 0;
+}
+
+static inline int cpuset_do_page_mem_spread(void)
+{
+	return 0;
+}
+
+static inline int cpuset_do_slab_mem_spread(void)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
--- v2.6.16-rc2.orig/include/linux/sched.h	2006-02-08 22:46:56.000000000 -0800
+++ v2.6.16-rc2/include/linux/sched.h	2006-02-08 22:47:01.000000000 -0800
@@ -874,6 +874,7 @@ struct task_struct {
 	struct cpuset *cpuset;
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
+	int cpuset_mem_spread_rotor;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
@@ -935,6 +936,8 @@ static inline void put_task_struct(struc
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
+#define PF_SPREAD_PAGE	0x04000000	/* Spread page cache over cpuset */
+#define PF_SPREAD_SLAB	0x08000000	/* Spread some slab caches over cpuset */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
--- v2.6.16-rc2.orig/kernel/cpuset.c	2006-02-08 22:47:00.000000000 -0800
+++ v2.6.16-rc2/kernel/cpuset.c	2006-02-08 22:47:01.000000000 -0800
@@ -4,15 +4,14 @@
  *  Processor and Memory placement constraints for sets of tasks.
  *
  *  Copyright (C) 2003 BULL SA.
- *  Copyright (C) 2004 Silicon Graphics, Inc.
+ *  Copyright (C) 2004-2006 Silicon Graphics, Inc.
  *
  *  Portions derived from Patrick Mochel's sysfs code.
  *  sysfs is Copyright (c) 2001-3 Patrick Mochel
- *  Portions Copyright (c) 2004 Silicon Graphics, Inc.
  *
- *  2003-10-10 Written by Simon Derr <simon.derr@bull.net>
+ *  2003-10-10 Written by Simon Derr.
  *  2003-10-22 Updates by Stephen Hemminger.
- *  2004 May-July Rework by Paul Jackson <pj@sgi.com>
+ *  2004 May-July Rework by Paul Jackson.
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of the Linux
@@ -108,7 +107,9 @@ typedef enum {
 	CS_MEM_EXCLUSIVE,
 	CS_MEMORY_MIGRATE,
 	CS_REMOVED,
-	CS_NOTIFY_ON_RELEASE
+	CS_NOTIFY_ON_RELEASE,
+	CS_SPREAD_PAGE,
+	CS_SPREAD_SLAB,
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -137,6 +138,16 @@ static inline int is_memory_migrate(cons
 	return test_bit(CS_MEMORY_MIGRATE, &cs->flags);
 }
 
+static inline int is_spread_page(const struct cpuset *cs)
+{
+	return test_bit(CS_SPREAD_PAGE, &cs->flags);
+}
+
+static inline int is_spread_slab(const struct cpuset *cs)
+{
+	return test_bit(CS_SPREAD_SLAB, &cs->flags);
+}
+
 /*
  * Increment this atomic integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
@@ -657,6 +668,14 @@ void cpuset_update_task_memory_state(voi
 		cs = tsk->cpuset;	/* Maybe changed when task not locked */
 		guarantee_online_mems(cs, &tsk->mems_allowed);
 		tsk->cpuset_mems_generation = cs->mems_generation;
+		if (is_spread_page(cs))
+			tsk->flags |= PF_SPREAD_PAGE;
+		else
+			tsk->flags &= ~PF_SPREAD_PAGE;
+		if (is_spread_slab(cs))
+			tsk->flags |= PF_SPREAD_SLAB;
+		else
+			tsk->flags &= ~PF_SPREAD_SLAB;
 		task_unlock(tsk);
 		mutex_unlock(&callback_mutex);
 		mpol_rebind_task(tsk, &tsk->mems_allowed);
@@ -956,7 +975,8 @@ static int update_memory_pressure_enable
 /*
  * update_flag - read a 0 or a 1 in a file and update associated flag
  * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
- *				CS_NOTIFY_ON_RELEASE, CS_MEMORY_MIGRATE)
+ *				CS_NOTIFY_ON_RELEASE, CS_MEMORY_MIGRATE,
+ *				CS_SPREAD_PAGE, CS_SPREAD_SLAB)
  * cs:	the cpuset to update
  * buf:	the buffer where we read the 0 or 1
  *
@@ -1187,6 +1207,8 @@ typedef enum {
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_MEMORY_PRESSURE_ENABLED,
 	FILE_MEMORY_PRESSURE,
+	FILE_SPREAD_PAGE,
+	FILE_SPREAD_SLAB,
 	FILE_TASKLIST,
 } cpuset_filetype_t;
 
@@ -1246,6 +1268,14 @@ static ssize_t cpuset_common_file_write(
 	case FILE_MEMORY_PRESSURE:
 		retval = -EACCES;
 		break;
+	case FILE_SPREAD_PAGE:
+		retval = update_flag(CS_SPREAD_PAGE, cs, buffer);
+		cs->mems_generation = atomic_inc_return(&cpuset_mems_generation);
+		break;
+	case FILE_SPREAD_SLAB:
+		retval = update_flag(CS_SPREAD_SLAB, cs, buffer);
+		cs->mems_generation = atomic_inc_return(&cpuset_mems_generation);
+		break;
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
@@ -1355,6 +1385,12 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_MEMORY_PRESSURE:
 		s += sprintf(s, "%d", fmeter_getrate(&cs->fmeter));
 		break;
+	case FILE_SPREAD_PAGE:
+		*s++ = is_spread_page(cs) ? '1' : '0';
+		break;
+	case FILE_SPREAD_SLAB:
+		*s++ = is_spread_slab(cs) ? '1' : '0';
+		break;
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1718,6 +1754,16 @@ static struct cftype cft_memory_pressure
 	.private = FILE_MEMORY_PRESSURE,
 };
 
+static struct cftype cft_spread_page = {
+	.name = "memory_spread_page",
+	.private = FILE_SPREAD_PAGE,
+};
+
+static struct cftype cft_spread_slab = {
+	.name = "memory_spread_slab",
+	.private = FILE_SPREAD_SLAB,
+};
+
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1736,6 +1782,10 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_memory_pressure)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_spread_page)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_spread_slab)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
 	return 0;
@@ -1764,6 +1814,10 @@ static long cpuset_create(struct cpuset 
 	cs->flags = 0;
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
+	if (is_spread_page(parent))
+		set_bit(CS_SPREAD_PAGE, &cs->flags);
+	if (is_spread_slab(parent))
+		set_bit(CS_SPREAD_SLAB, &cs->flags);
 	cs->cpus_allowed = CPU_MASK_NONE;
 	cs->mems_allowed = NODE_MASK_NONE;
 	atomic_set(&cs->count, 0);
@@ -2168,6 +2222,44 @@ void cpuset_unlock(void)
 }
 
 /**
+ * cpuset_mem_spread_node() - On which node to begin search for a page
+ *
+ * If a task is marked PF_SPREAD_PAGE or PF_SPREAD_SLAB (as for
+ * tasks in a cpuset with is_spread_page or is_spread_slab set),
+ * and if the memory allocation used cpuset_mem_spread_node()
+ * to determine on which node to start looking, as it will for
+ * certain page cache or slab cache pages such as used for file
+ * system buffers and inode caches, then instead of starting on the
+ * local node to look for a free page, rather spread the starting
+ * node around the tasks mems_allowed nodes.
+ *
+ * We don't have to worry about the returned node being offline
+ * because "it can't happen", and even if it did, it would be ok.
+ *
+ * The routines calling guarantee_online_mems() are careful to
+ * only set nodes in task->mems_allowed that are online.  So it
+ * should not be possible for the following code to return an
+ * offline node.  But if it did, that would be ok, as this routine
+ * is not returning the node where the allocation must be, only
+ * the node where the search should start.  The zonelist passed to
+ * __alloc_pages() will include all nodes.  If the slab allocator
+ * is passed an offline node, it will fall back to the local node.
+ * See kmem_cache_alloc_node().
+ */
+
+int cpuset_mem_spread_node(void)
+{
+	int node;
+
+	node = next_node(current->cpuset_mem_spread_rotor, current->mems_allowed);
+	if (node == MAX_NUMNODES)
+		node = first_node(current->mems_allowed);
+	current->cpuset_mem_spread_rotor = node;
+	return node;
+}
+EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
+
+/**
  * cpuset_excl_nodes_overlap - Do we overlap @p's mem_exclusive ancestors?
  * @p: pointer to task_struct of some other task.
  *

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
