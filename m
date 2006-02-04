Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946325AbWBDHT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946325AbWBDHT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946326AbWBDHT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:19:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14218 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946325AbWBDHT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:19:26 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Fri, 03 Feb 2006 23:19:10 -0800
Message-Id: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 1/5] cpuset memory spread basic implementation
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

A new per-cpuset file, "memory_spread", is defined.  This is
a boolean flag file, containing a "0" (off) or "1" (on).
By default it is off, and the kernel allocation placement
is unchanged.  If it is turned on for a given cpuset (write a
"1" to that cpusets memory_spread file) then the alternative
policy applies to all tasks in that cpuset.

The implementation is simple.  Setting the cpuset flag
"memory_spread" turns on a per-process flag PF_MEM_SPREAD for
each task that is in that cpuset or subsequently joins that
cpuset.  In subsequent patches, the page allocation calls for
the affected page cache and slab caches are modified to perform
an inline check for this PF_MEM_SPREAD task flag, and if set,
a call to a new routine cpuset_mem_spread_node() returns the
node to prefer for the allocation.

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

 Documentation/cpusets.txt |   64 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/cpuset.h    |   18 ++++++++++++
 include/linux/sched.h     |    2 +
 kernel/cpuset.c           |   63 ++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 138 insertions(+), 9 deletions(-)

--- 2.6.16-rc1-mm5.orig/Documentation/cpusets.txt	2006-02-03 16:38:09.613742481 -0800
+++ 2.6.16-rc1-mm5/Documentation/cpusets.txt	2006-02-03 21:28:32.568213724 -0800
@@ -17,7 +17,8 @@ CONTENTS:
   1.4 What are exclusive cpusets ?
   1.5 What does notify_on_release do ?
   1.6 What is memory_pressure ?
-  1.7 How do I use cpusets ?
+  1.7 What is memory_spread ?
+  1.8 How do I use cpusets ?
 2. Usage Examples and Syntax
   2.1 Basic Usage
   2.2 Adding/removing cpus
@@ -315,7 +316,66 @@ the tasks in the cpuset, in units of rec
 times 1000.
 
 
-1.7 How do I use cpusets ?
+1.7 What is memory_spread ?
+---------------------------
+If the per-cpuset boolean flag file 'memory_spread' is set,
+then the kernel will spread the file system buffers (page cache)
+evenly over all the nodes that the faulting task is allowed to
+use, instead of preferring to put those pages on the node where
+the task is running.  Some file system related slab caches,
+such as for inodes and dentries are also affected.  A tasks
+private (anonymous) data and stack regions are not affected.
+
+By default, memory_spread is off, and memory pages are allocated
+on the node local to where the task is running, except perhaps
+as modified by the tasks NUMA mempolicy or cpuset configuration,
+so long as sufficient free memory pages are available.
+
+When new cpusets are created, they inherit the memory_spread
+setting of their parent.
+
+Setting memory_spread causes allocations of the affected page
+and slab caches to ignore the tasks NUMA mempolicy and be spread
+instead.    Tasks using mbind() or set_mempolicy() calls to set
+NUMA mempolicies will not notice any change in these calls as a
+result of their containing tasks memory_spread setting.  If
+memory spreading is turned off, then the currently specified
+NUMA mempolicy once again applies to memory page allocations.
+
+A new per-cpuset file, 'memory_spread', is defined.  This is
+a boolean flag file, containing a "0" (off) or "1" (on).
+By default it is off, and the kernel allocation placement
+is unchanged.  If it is turned on for a given cpuset (write a
+"1" to that cpusets memory_spread file) then the alternative
+policy applies to all tasks in that cpuset.
+
+The implementation is simple.  Setting the cpuset flag
+'memory_spread' turns on a per-process flag PF_MEM_SPREAD
+for each task that is in that cpuset or subsequently joins
+that cpuset.  The page allocation calls for the affected page
+cache and slab caches are modified to perform an inline check
+for this PF_MEM_SPREAD task flag, and if set, a call to a new
+routine cpuset_mem_spread_node() returns the node to prefer
+for the allocation.
+
+The cpuset_mem_spread_node() routine is also simple.  It uses
+the value of a per-task rotor cpuset_mem_spread_rotor to select
+the next node in the current tasks mems_allowed to prefer for
+the allocation.
+
+This memory placement policy is also known (in other contexts)
+as round-robin or interleave.
+
+This policy can provide substantial improvements for jobs that
+need to place thread local data on the corresponding node, but
+that need to access large file system data sets that need to
+be spread across the several nodes in the jobs cpuset in order
+to fit.  Without this policy, especially for jobs that might
+have one thread reading in the data set, the memory allocation
+across the nodes in the jobs cpuset can become very uneven.
+
+
+1.8 How do I use cpusets ?
 --------------------------
 
 In order to minimize the impact of cpusets on critical kernel
--- 2.6.16-rc1-mm5.orig/include/linux/cpuset.h	2006-02-03 16:44:23.433333121 -0800
+++ 2.6.16-rc1-mm5/include/linux/cpuset.h	2006-02-03 21:34:56.388980845 -0800
@@ -4,7 +4,7 @@
  *  cpuset interface
  *
  *  Copyright (C) 2003 BULL SA
- *  Copyright (C) 2004 Silicon Graphics, Inc.
+ *  Copyright (C) 2004-2006 Silicon Graphics, Inc.
  *
  */
 
@@ -51,6 +51,12 @@ extern char *cpuset_task_status_allowed(
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 
+extern int cpuset_mem_spread_node(void);
+static inline int cpuset_mem_spread_check(void)
+{
+	return current->flags & PF_MEM_SPREAD;
+}
+
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
@@ -99,6 +105,16 @@ static inline char *cpuset_task_status_a
 static inline void cpuset_lock(void) {}
 static inline void cpuset_unlock(void) {}
 
+static inline int cpuset_mem_spread_node(void)
+{
+	return 0;
+}
+
+static inline int cpuset_mem_spread_check(void)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
--- 2.6.16-rc1-mm5.orig/kernel/cpuset.c	2006-02-03 20:14:30.533135654 -0800
+++ 2.6.16-rc1-mm5/kernel/cpuset.c	2006-02-03 21:38:56.833115432 -0800
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
@@ -108,7 +107,8 @@ typedef enum {
 	CS_MEM_EXCLUSIVE,
 	CS_MEMORY_MIGRATE,
 	CS_REMOVED,
-	CS_NOTIFY_ON_RELEASE
+	CS_NOTIFY_ON_RELEASE,
+	CS_MEM_SPREAD,
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -137,6 +137,11 @@ static inline int is_memory_migrate(cons
 	return !!test_bit(CS_MEMORY_MIGRATE, &cs->flags);
 }
 
+static inline int is_mem_spread(const struct cpuset *cs)
+{
+	return !!test_bit(CS_MEM_SPREAD, &cs->flags);
+}
+
 /*
  * Increment this atomic integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
@@ -657,6 +662,10 @@ void cpuset_update_task_memory_state(voi
 		cs = tsk->cpuset;	/* Maybe changed when task not locked */
 		guarantee_online_mems(cs, &tsk->mems_allowed);
 		tsk->cpuset_mems_generation = cs->mems_generation;
+		if (is_mem_spread(cs))
+			tsk->flags |= PF_MEM_SPREAD;
+		else
+			tsk->flags &= ~PF_MEM_SPREAD;
 		task_unlock(tsk);
 		mutex_unlock(&callback_mutex);
 		mpol_rebind_task(tsk, &tsk->mems_allowed);
@@ -957,7 +966,8 @@ static int update_memory_pressure_enable
 /*
  * update_flag - read a 0 or a 1 in a file and update associated flag
  * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
- *				CS_NOTIFY_ON_RELEASE, CS_MEMORY_MIGRATE)
+ *				CS_NOTIFY_ON_RELEASE, CS_MEMORY_MIGRATE,
+ *				CS_MEM_SPREAD)
  * cs:	the cpuset to update
  * buf:	the buffer where we read the 0 or 1
  *
@@ -1188,6 +1198,7 @@ typedef enum {
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_MEMORY_PRESSURE_ENABLED,
 	FILE_MEMORY_PRESSURE,
+	FILE_MEM_SPREAD,
 	FILE_TASKLIST,
 } cpuset_filetype_t;
 
@@ -1247,6 +1258,11 @@ static ssize_t cpuset_common_file_write(
 	case FILE_MEMORY_PRESSURE:
 		retval = -EACCES;
 		break;
+	case FILE_MEM_SPREAD:
+		retval = update_flag(CS_MEM_SPREAD, cs, buffer);
+		atomic_inc(&cpuset_mems_generation);
+		cs->mems_generation = atomic_read(&cpuset_mems_generation);
+		break;
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
@@ -1356,6 +1372,9 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_MEMORY_PRESSURE:
 		s += sprintf(s, "%d", fmeter_getrate(&cs->fmeter));
 		break;
+	case FILE_MEM_SPREAD:
+		*s++ = is_mem_spread(cs) ? '1' : '0';
+		break;
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1719,6 +1738,11 @@ static struct cftype cft_memory_pressure
 	.private = FILE_MEMORY_PRESSURE,
 };
 
+static struct cftype cft_mem_spread = {
+	.name = "memory_spread",
+	.private = FILE_MEM_SPREAD,
+};
+
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1737,6 +1761,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_memory_pressure)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_mem_spread)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
 	return 0;
@@ -1765,6 +1791,8 @@ static long cpuset_create(struct cpuset 
 	cs->flags = 0;
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
+	if (is_mem_spread(parent))
+		set_bit(CS_MEM_SPREAD, &cs->flags);
 	cs->cpus_allowed = CPU_MASK_NONE;
 	cs->mems_allowed = NODE_MASK_NONE;
 	atomic_set(&cs->count, 0);
@@ -2171,6 +2199,29 @@ void cpuset_unlock(void)
 }
 
 /**
+ * cpuset_mem_spread_node() - Decide which cpuset node gets this allocation.
+ *
+ * If a task is marked PF_MEM_SPREAD (which it will be if the task is
+ * in a cpuset for which is_mem_spread() is true), and if the memory
+ * allocation used cpuset_mem_spread_node() to determine on which node
+ * to start looking, as it will for certain page cache or slab cache
+ * pages such as used for file system buffers and inode caches, then
+ * instead of starting on the local node to look for a free page,
+ * rather spread the starting node around the tasks mems_allowed nodes.
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
+
+/**
  * cpuset_excl_nodes_overlap - Do we overlap @p's mem_exclusive ancestors?
  * @p: pointer to task_struct of some other task.
  *
--- 2.6.16-rc1-mm5.orig/include/linux/sched.h	2006-02-03 20:14:45.524512883 -0800
+++ 2.6.16-rc1-mm5/include/linux/sched.h	2006-02-03 20:35:14.431690522 -0800
@@ -886,6 +886,7 @@ struct task_struct {
 	struct cpuset *cpuset;
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
+	int cpuset_mem_spread_rotor;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
@@ -947,6 +948,7 @@ static inline void put_task_struct(struc
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
+#define PF_MEM_SPREAD	0x04000000	/* Spread some memory over cpuset */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
