Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUGBLDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUGBLDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 07:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUGBLDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 07:03:43 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5587 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262380AbUGBKyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:54:36 -0400
Date: Fri, 2 Jul 2004 03:53:15 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Paul Jackson <pj@sgi.com>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Sylvain <sylvain.jeaugey@bull.net>,
       Simon <Simon.Derr@bull.net>, Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <20040702105318.15684.77951.19061@sam.engr.sgi.com>
In-Reply-To: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
References: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
Subject: [patch 6/8] cpusets v4 - The main new files: cpuset.c, cpuset.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main cpuset patch - including Documentation, kernel/cpuset.c,
cpuset.h, and the kernel/Makefile hook.

The main cpuset code establishes a hierarchy of cpusets, visible
in a pseudo filesystem.  Each task links to the cpuset that controls
its CPU and Memory placement.  The CPUs and Memory Nodes allowed
to any particular cpuset are always a subset of that cpusets
parent, with the top cpuset containing all CPUs and Memory Nodes
in the system.

This hierarchy is required in order to efficiently provide for strictly
exclusive cpusets - the CPUs and Memory Nodes of a strictly exclusive
cpuset are guaranteed by the kernel to not be part of any other cpuset
that is not a direct ancestor or descendent.

Follow on patches will add the necessary kernel hooks to connect
cpusets with the rest of the kernel.


Index: 2.6.7-mm5/Documentation/cpusets.txt
===================================================================
--- 2.6.7-mm5.orig/Documentation/cpusets.txt	2003-03-14 05:07:09.000000000 -0800
+++ 2.6.7-mm5/Documentation/cpusets.txt	2004-07-02 00:06:40.000000000 -0700
@@ -0,0 +1,381 @@
+				CPUSETS
+				-------
+
+Copyright (C) 2004 BULL SA.
+Written by Simon.Derr@bull.net
+
+Portions Copyright (c) 2004 Silicon Graphics, Inc.
+Modified by Paul Jackson <pj@sgi.com>
+
+CONTENTS:
+=========
+
+1. Cpusets
+  1.1 What are cpusets ?
+  1.2 Why are cpusets needed ?
+  1.3 How are cpusets implemented ?
+  1.4 How do I use cpusets ?
+2. Usage Examples and Syntax
+  2.1 Basic Usage
+  2.2 Adding/removing cpus
+  2.3 Setting flags
+  2.4 Attaching processes
+3. Questions
+4. Contact
+
+1. Cpusets
+==========
+
+1.1 What are cpusets ?
+----------------------
+
+Cpusets provide a simple mechanism for assigning a set of CPUs and
+Memory Nodes to a set of tasks.
+
+Cpusets constrains the existing CPU and Memory placement calls to
+only request resources within a tasks current cpuset, and they form a
+nested hierarchy visible in a virtual file system.  These are the
+essential hooks, beyond what is already present, required to manage
+dynamic job placement on large systems.
+
+Each task has a pointer to a cpuset.  Multiple tasks may reference
+the same cpuset.  Requests by a task, using the sched_setaffinity(2)
+system call to include CPUs in its CPU affinity mask, and using the
+mbind(2) and set_mempolicy(2) system calls to include Memory Nodes
+in its memory policy, are both filtered through that tasks cpuset,
+filtering out any CPUs or Memory Nodes not in that cpuset.
+
+If a cpuset is strictly exclusive, no other cpuset, other than a direct
+ancestor or descendent, may share any of the same CPUs or Memory Nodes.
+
+User level code may create and destroy cpusets by name in the cpuset
+virtual file system, manage the attributes and permissions of these
+cpusets and which CPUs and Memory Nodes are assigned to each cpuset,
+specify and query to which cpuset a task is assigned, and list the
+task pids assigned to a cpuset.
+
+
+1.2 Why are cpusets needed ?
+----------------------------
+
+The management of large computer systems, with many processors (CPUs),
+complex memory cache hierarchies and multiple Memory Nodes having
+non-uniform access times (NUMA) presents additional challenges for
+the efficient scheduling and memory placement of processes.
+
+Frequently more modest sized systems can be operated with adequate
+efficiency just by letting the operating system automatically share
+the available CPU and Memory resources amongst the requesting tasks.
+
+But larger systems, which benefit more from careful processor and
+memory placement to reduce memory access times and contention,
+and which typically represent a larger investment for the customer,
+can benefit from explictly placing jobs on properly sized subsets of
+the system.
+
+This can be especially valuable on:
+
+    * Web Servers running multiple instances of the same web application,
+    * Servers running different applications (for instance, a web server
+      and a database), or
+    * NUMA systems running large HPC applications with demanding
+      performance characteristics.
+
+These subsets, or "soft partitions" must be able to be dynamically
+adjusted, as the job mix changes, without impacting other concurrently
+executing jobs.
+
+The kernel cpuset patch provides the minimum essential kernel
+mechanisms required to efficiently implement such subsets.  It
+leverages existing CPU and Memory Placement facilities in the Linux
+kernel to avoid any additional impact on the critical scheduler or
+memory allocator code.
+
+
+1.3 How are cpusets implemented ?
+---------------------------------
+
+Cpusets provide a Linux kernel (2.6.7 and above) mechanism to constrain
+which CPUs and Memory Nodes are used by a process or set of processes.
+
+The Linux kernel already has a pair of mechanisms to specify on which
+CPUs a task may be scheduled (sched_setaffinity) and on which Memory
+Nodes it may obtain memory (mbind, set_mempolicy).
+
+Cpusets extends these two mechanisms as follows:
+
+ - Cpusets are sets of allowed CPUs and Memory Nodes, known to the
+   kernel.
+ - Each task in the system is attached to a cpuset, via a pointer
+   in the task structure to a reference counted cpuset structure.
+ - Calls to sched_setaffinity are filtered to just those CPUs
+   allowed in that tasks cpuset.
+ - Calls to mbind and set_mempolicy are filtered to just
+   those Memory Nodes allowed in that tasks cpuset.
+ - The "top_cpuset" contains all the systems CPUs and Memory
+   Nodes.
+ - For any cpuset, one can define child cpusets containing a subset
+   of the parents CPU and Memory Node resources.
+ - The hierarchy of cpusets can be mounted at /dev/cpuset, for
+   browsing and manipulation from user space.
+ - A cpuset may be marked strictly exclusive, which ensures that
+   no other cpuset (except direct ancestors and descendents) may
+   contain any overlapping CPUs or Memory Nodes.
+ - You can list all the tasks (by pid) attached to any cpuset.
+
+The implementation of cpusets requires a few, simple hooks
+into the rest of the kernel, none in performance critical paths:
+
+ - in main/init.c, to initialize the top_cpuset at system boot.
+ - in fork and exit, to attach and detach a task from its cpuset.
+ - in sched_setaffinity, to mask the requested CPUs by what's
+   allowed in that tasks cpuset.
+ - in sched.c migrate_all_tasks(), to keep migrating tasks within
+   the CPUs allowed by their cpuset, if possible.
+ - in the mbind and set_mempolicy system calls, to mask the requested
+   Memory Nodes by what's allowed in that tasks cpuset.
+
+In addition a new file system, of type "cpuset" may be mounted,
+typically at /dev/cpuset, to enable browsing and modifying the cpusets
+presently known to the kernel.  No new system calls are added for
+cpusets - all support for querying and modifying cpusets is via
+this cpuset file system.
+
+Each task under /proc has an added file named 'cpuset', displaying
+the cpuset name, as the path relative to the root of the cpuset file
+system.
+
+Each cpuset is represented by a directory in the cpuset file system
+containing the following files describing that cpuset:
+
+ - cpus: list of CPUs in that cpuset
+ - mems: list of Memory Nodes in that cpuset
+ - cpustrict flag: is cpuset strictly exclusive?
+ - memstrict flag: is cpuset strictly exclusive?
+ - tasks: list of tasks (by pid) attached to that cpuset
+
+New cpusets are created using the mkdir system call or shell
+command.  The properties of a cpuset, such as its flags, allowed
+CPUs and Memory Nodes, and attached tasks, are modified by writing
+to the appropriate file in that cpusets directory, as listed above.
+
+The named hierarchical structure of nested cpusets allows partitioning
+a large system into nested, dynamically changeable, "soft-partitions".
+
+The attachment of each task, automatically inherited at fork by any
+children of that task, to a cpuset allows organizing the work load
+on a system into related sets of tasks such that each set is constrained
+to using the CPUs and Memory Nodes of a particular cpuset.  A task
+may be re-attached to any other cpuset, if allowed by the permissions
+on the necessary cpuset file system directories.
+
+Such management of a system "in the large" integrates smoothly with
+the detailed placement done on individual tasks and memory regions
+using the sched_setaffinity, mbind and set_mempolicy system calls.
+
+The following rules apply to each cpuset:
+
+ - Its CPUs and Memory Nodes must be a subset of its parents.
+ - It can only be marked strictly exclusive (strict) if its parent is.
+
+These rules, and the natural hierarchy of cpusets, enable efficient
+enforcement of the strictly exclusive guarantee, without having to scan
+all cpusets every time any of them change to ensure nothing overlaps
+a strictly exclusive cpuset. Also, the use of a Linux virtual file
+system (vfs) to represent the cpuset hierarchy provides for a familiar
+permission and name space for cpusets, with a minimum of additional
+kernel code.
+
+
+1.4 How do I use cpusets ?
+--------------------------
+
+Be warned that cpusets work differently than you might expect.
+
+In order to avoid _any_ impact on existing critical scheduler and
+memory allocator code in the kernel, and to leverage the existing
+CPU and Memory placement facilities, putting a task in a particular
+cpuset does _not_ immediately affect its placement.
+
+It would have been possible (and initially cpusets were coded this
+way) to immediately change a tasks cpus_allowed affinity mask based
+on what cpuset it was placed in.  The sched_setaffinity call can be
+applied to any requested task.
+
+But the way numa placement support (added to 2.6 kernels in April
+2004 by Andi Kleen) works, it is not possible for one task to change
+another tasks Memory placement.  The mbind and set_mempolicy system
+calls only affect the current task.  There really wasn't a choice
+in this matter -- the mm's, vma's and zonelists that encode a tasks
+Memory placement are complicated, and cannot be safely changed from
+outside the current tasks context.
+
+So, cpuset placement only affects the future sched_setaffinity,
+mbind, and set_mempolicy system calls, by filtering out any CPUs
+and Memory Nodes that are not allowed in the specified tasks cpuset.
+Well, almost all.  See also the migrate_all_tasks() hook, listed above.
+
+To start a new job that is to be contained within a cpuset, this means
+the steps are:
+
+ 1) mkdir /dev/cpuset
+ 2) mount -t cpuset none /dev/cpuset
+ 3) Create the new cpuset by doing mkdir's and write's (or echo's) in
+    the /dev/cpuset virtual file system.
+ 4) Start a task that will be the "founding father" of the new job.
+ 5) Attach that task to the new cpuset by writing its pid to the
+    /dev/cpuset tasks file for that cpuset.
+ 6) Have that task issue sched_setaffinity, mbind and set_mempolicy
+    system calls, specifying CPUs and Memory Nodes within its cpuset.
+    Anything it specifies outside will be ignored without complaint,
+    so if you request all CPUs and Memory Nodes in the system, you will
+    successfully get all that are available in your current cpuset.
+ 7) fork, exec or clone the job tasks from this founding father task.
+
+For example, the following sequence of commands will setup a cpuset
+named "Charlie", containing just CPUs 2 and 3, and Memory Node 1,
+and then start a subshell 'sh' in that cpuset:
+
+  mount -t cpuset none /dev/cpuset
+  cd /dev/cpuset/top_cpuset
+  mkdir Charlie
+  cd Charlie
+  /bin/echo 2-3 > cpus
+  /bin/echo 1 > mems
+  /bin/echo $$ > tasks
+  # 0xC is bitmask for CPUs 2-3
+  taskset 0xC numactl -m 1 sh
+  # The subshell 'sh' is now running in cpuset Charlie
+  # The next line should display 'top_cpuset/Charlie'
+  cat /proc/self/cpuset
+
+In the case that we want to force an existing job into a particular
+cpuset, or that we want to move the cpuset that a job is using,
+we will need some additional library code, not yet available as of
+this writing (July 2004), that will receive a particular signal,
+and reissue the necessary sched_setaffinity, mbind and set_mempolicy
+system calls from with the tasks current context.
+
+In the case that a change of cpuset includes wanting to move already
+allocated memory pages, consider further the work of IWAMOTO
+Toshihiro <iwamoto@valinux.co.jp> for page remapping and memory
+hotremoval, which can be found at:
+
+  http://people.valinux.co.jp/~iwamoto/mh.html
+
+The integration of cpusets with such memory migration is not yet
+available.
+
+In the future, a C library interface to cpusets will likely be
+available.  For now, the only way to query or modify cpusets is
+via the cpuset file system, using the various cd, mkdir, echo, cat,
+rmdir commands from the shell, or their equivalent from C.
+
+The sched_setaffinity calls can also be done at the shell prompt using
+SGI's runon or Robert Love's taskset.  The mbind and set_mempolicy
+calls can be done at the shell prompt using the numactl command
+(part of Andi's numa package).
+
+2. Usage Examples and Syntax
+============================
+
+2.1 Basic Usage
+---------------
+
+Creating, modifying, using the cpusets can be done through the cpuset
+virtual filesystem.
+
+To mount it, type:
+# mount -t cpuset none /dev/cpuset
+
+Then under /dev/cpuset you can find a tree that corresponds to the
+tree of the cpusets in the system. For instance, /dev/cpuset/top_cpuset
+is the cpuset that holds the whole system.
+
+If you want to create a new cpuset under top_cpuset:
+# cd /dev/cpuset/top_cpuset
+# mkdir my_cpuset
+
+Now you want to do something with this cpuset.
+# cd my_cpuset
+
+In this directory you can find several files:
+# ls
+cpus  cpustrict  mems  memstrict  tasks
+
+Reading them will give you information about the state of this cpuset:
+the CPUs and Memory Nodes it can use, the processes that are using
+it, its properties.  By writing to these files you can manipulate
+the cpuset.
+
+Set some flags:
+# /bin/echo 1 > cpustrict
+
+Add some cpus:
+# /bin/echo 0-7 > cpus
+
+Now attach your shell to this cpuset:
+# /bin/echo $$ > tasks
+
+You can also create cpusets inside your cpuset by using mkdir in this
+directory.
+# mkdir my_sub_cs
+
+To remove a cpuset, just use rmdir:
+# rmdir my_sub_cs
+This will fail if the cpuset is in use (has cpusets inside, or has
+processes attached).
+
+2.2 Adding/removing cpus
+------------------------
+
+This is the syntax to use when writing in the cpus or mems files
+in cpuset directories:
+
+# /bin/echo 1-4 > cpus		-> set cpus list to cpus 1,2,3,4
+# /bin/echo 1,2,3,4 > cpus	-> set cpus list to cpus 1,2,3,4
+# /bin/echo +1 > cpus		-> add cpu 1 to the cpus list
+# /bin/echo -1-4 > cpus		-> remove cpus 1,2,3,4 from the cpus list
+# /bin/echo -1,2,3,4 > cpus	-> remove cpus 1,2,3,4 from the cpus list
+
+All these can be mixed together:
+# /bin/echo 1-7 -6 +9,10	-> set cpus list to 1,2,3,4,5,7,9,10
+
+2.3 Setting flags
+-----------------
+
+The syntax is very simple:
+
+# /bin/echo 1 > cpustrict 	-> set flag 'cpustrict'
+# /bin/echo 0 > cpustrict 	-> unset flag 'cpustrict'
+
+2.4 Attaching processes
+-----------------------
+
+# /bin/echo PID > tasks
+
+Note that it is PID, not PIDs. You can only attach ONE task at a time.
+If you have several tasks to attach, you have to do it one after another:
+
+# /bin/echo PID1 > tasks
+# /bin/echo PID2 > tasks
+	...
+# /bin/echo PIDn > tasks
+
+
+3. Questions
+============
+
+Q: what's up with this '/bin/echo' ?
+A: bash's builtin 'echo' command does not check calls to write() against
+   errors. If you use it in the cpuset file system, you won't be
+   able to tell whether a command succeeded or failed.
+
+Q: When I attach processes, only the first of the line gets really attached !
+A: We can only return one error code per call to write(). So you should also
+   put only ONE pid.
+
+4. Contact
+==========
+
+Web: http://www.bullopensource.org/cpuset
Index: 2.6.7-mm5/include/linux/cpuset.h
===================================================================
--- 2.6.7-mm5.orig/include/linux/cpuset.h	2003-03-14 05:07:09.000000000 -0800
+++ 2.6.7-mm5/include/linux/cpuset.h	2004-07-01 19:30:21.000000000 -0700
@@ -0,0 +1,41 @@
+#ifndef _LINUX_CPUSET_H
+#define _LINUX_CPUSET_H
+/*
+ *  cpuset interface
+ *
+ *  Copyright (C) 2003 BULL SA
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/nodemask.h>
+
+#ifdef CONFIG_CPUSETS
+
+extern int cpuset_init(void);
+extern void cpuset_fork(struct task_struct *p);
+extern void cpuset_exit(struct task_struct *p);
+extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
+extern const nodemask_t cpuset_mems_allowed(const struct task_struct *p);
+extern int proc_pid_cspath(struct task_struct *p, char *buf, int len);
+
+#else /* !CONFIG_CPUSETS */
+
+static inline int cpuset_init(void) { return 0; }
+static inline void cpuset_fork(struct task_struct *p) {}
+static inline void cpuset_exit(struct task_struct *p) {}
+
+static inline const cpumask_t cpuset_cpus_allowed(struct task_struct *p)
+{
+	return cpu_possible_map;
+}
+
+static inline const nodemask_t cpuset_mems_allowed(struct task_struct *p)
+{
+	return node_possible_map;
+}
+
+#endif /* !CONFIG_CPUSETS */
+
+#endif /* _LINUX_CPUSET_H */
Index: 2.6.7-mm5/kernel/Makefile
===================================================================
--- 2.6.7-mm5.orig/kernel/Makefile	2004-07-01 19:30:10.000000000 -0700
+++ 2.6.7-mm5/kernel/Makefile	2004-07-01 19:30:21.000000000 -0700
@@ -24,6 +24,7 @@ obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_CPUSETS) += cpuset.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: 2.6.7-mm5/kernel/cpuset.c
===================================================================
--- 2.6.7-mm5.orig/kernel/cpuset.c	2003-03-14 05:07:09.000000000 -0800
+++ 2.6.7-mm5/kernel/cpuset.c	2004-07-02 03:14:59.000000000 -0700
@@ -0,0 +1,1313 @@
+/*
+ *  kernel/cpuset.c
+ *
+ *  Processor and Memory placement constraints for sets of tasks.
+ *
+ *  Copyright (C) 2003 BULL SA.
+ *
+ *  Portions derived from Patrick Mochel's sysfs code.
+ *  sysfs is Copyright (c) 2001-3 Patrick Mochel
+ *
+ *  2003-10-10 Written by Simon Derr <simon.derr@bull.net>
+ *  2003-10-22 Updates by Stephen Hemminger.
+ *  2004 May-June Some rework by Paul Jackson <pj@sgi.com>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/cpuset.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/pagemap.h>
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/backing-dev.h>
+
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+
+#define CPUSET_SUPER_MAGIC 		0x27e0eb
+
+struct cpuset {
+	unsigned long flags;		/* "unsigned long" so bitops work */
+	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
+	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
+	struct cpuset *parent;		/* my parent */
+	/*
+	 * We link our 'sibling' struct into our parents 'children'.
+	 * Our children link their 'sibling' into our 'children'.
+	 */
+	struct list_head sibling;	/* my parents children */
+	struct list_head children;	/* my children */
+	atomic_t count;			/* count all users (tasks + children) */
+	struct dentry *dentry;		/* cpuset fs entry */
+};
+
+/* bits in struct cpuset flags field */
+typedef enum {
+	CS_CPUSTRICT,
+	CS_MEMSTRICT,
+	CS_REMOVED,
+} cpuset_flagbits_t;
+
+/* convenient tests for these bits */
+static inline int is_cpustrict(const struct cpuset *cs)
+{
+	return !!test_bit(CS_CPUSTRICT, &cs->flags);
+}
+
+static inline int is_memstrict(const struct cpuset *cs)
+{
+	return !!test_bit(CS_MEMSTRICT, &cs->flags);
+}
+
+static inline int is_removed(const struct cpuset *cs)
+{
+	return !!test_bit(CS_REMOVED, &cs->flags);
+}
+
+static struct cpuset top_cpuset = {
+	.flags = ((1 << CS_CPUSTRICT) | (1 << CS_MEMSTRICT)),
+	.parent = NULL,
+	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
+	.children = LIST_HEAD_INIT(top_cpuset.children),
+	.count = ATOMIC_INIT(1),	/* top_cpuset can't be deleted */
+	.cpus_allowed = CPU_MASK_ALL,
+	.mems_allowed = NODE_MASK_ALL,
+};
+
+static struct vfsmount *cpuset_mount;
+static struct super_block *cpuset_sb = NULL;
+
+/*
+ * cpuset_sem should be held by anyone who is depending on the children
+ * or sibling lists of any cpuset, or performing non-atomic operations
+ * on the flags or *_allowed values of a cpuset, such as raising the
+ * CS_REMOVED flag bit iff it is not already raised, or reading and
+ * conditionally modifying the *_allowed values.  One kernel global
+ * cpuset semaphore should be sufficient - these things don't change
+ * that much.
+ *
+ * The code that modifies cpusets holds cpuset_sem across the entire
+ * operation, from cpuset_common_file_write() down, single threading
+ * all cpuset modifications (except for reference count manipulations
+ * from fork and exit) across the system.  This presumes that cpuset
+ * modifications are rare - better kept simple and safe, even if slow.
+ *
+ * The code that reads cpusets, such as in cpuset_common_file_read()
+ * and below, only holds cpuset_sem across small pieces of code, such
+ * as when reading out possibly multi-word cpumasks and nodemasks, as
+ * the risks are less, and the desire for performance a little greater.
+ * The proc_pid_cspath() routine needs to hold cpuset_sem to insure
+ * that no cs->dentry is NULL, as it walks up the cpuset tree to root.
+ *
+ * The hooks from fork and exit, cpuset_fork() and cpuset_exit(),
+ * don't grab cpuset_sem.  These are the two most performance critical
+ * pieces of code here.
+ */
+
+static DECLARE_MUTEX(cpuset_sem);
+
+/*
+ * A couple of forward declarations required, due to cyclic reference loop:
+ *  cpuset_mkdir -> cpuset_create -> cpuset_populate_dir -> cpuset_add_file
+ *  -> cpuset_create_file -> cpuset_dir_inode_operations -> cpuset_mkdir.
+ */
+
+static int cpuset_mkdir(struct inode *dir, struct dentry *dentry, int mode);
+static int cpuset_rmdir(struct inode *unused_dir, struct dentry *dentry);
+
+static struct backing_dev_info cpuset_backing_dev_info = {
+	.ra_pages = 0,		/* No readahead */
+	.memory_backed = 1,	/* Does not contribute to dirty memory */
+};
+
+static struct inode *cpuset_new_inode(mode_t mode)
+{
+	struct inode *inode = new_inode(cpuset_sb);
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_mapping->backing_dev_info = &cpuset_backing_dev_info;
+	}
+	return inode;
+}
+
+static void cpuset_diput(struct dentry *dentry, struct inode *inode)
+{
+	/* is dentry a directory ? if so, kfree() associated cpuset */
+	if (S_ISDIR(inode->i_mode)) {
+		struct cpuset *cs = (struct cpuset *)dentry->d_fsdata;
+		BUG_ON(!(is_removed(cs)));
+		kfree(cs);
+	}
+	iput(inode);
+}
+
+static struct dentry_operations cpuset_dops = {
+	.d_iput = cpuset_diput,
+};
+
+static struct dentry *cpuset_get_dentry(struct dentry *parent, const char *name)
+{
+	struct qstr qstr;
+	struct dentry *d;
+
+	qstr.name = name;
+	qstr.len = strlen(name);
+	qstr.hash = full_name_hash(name, qstr.len);
+	d = lookup_hash(&qstr, parent);
+	if (d)
+		d->d_op = &cpuset_dops;
+	return d;
+}
+
+static inline void use_cpuset(struct cpuset *cs)
+{
+	atomic_inc(&cs->count);
+}
+
+static inline void release_cpuset(struct cpuset *cs)
+{
+	atomic_dec(&cs->count);
+}
+
+static void remove_dir(struct dentry *d)
+{
+	struct dentry *parent = dget(d->d_parent);
+
+	d_delete(d);
+	simple_rmdir(parent->d_inode, d);
+	dput(parent);
+}
+
+/*
+ * NOTE : the dentry must have been dget()'ed
+ */
+static void cpuset_d_remove_dir(struct dentry *dentry)
+{
+	struct list_head *node;
+
+	spin_lock(&dcache_lock);
+	node = dentry->d_subdirs.next;
+	while (node != &dentry->d_subdirs) {
+		struct dentry *d = list_entry(node, struct dentry, d_child);
+		list_del_init(node);
+		if (d->d_inode) {
+			d = dget_locked(d);
+			spin_unlock(&dcache_lock);
+			d_delete(d);
+			simple_unlink(dentry->d_inode, d);
+			dput(d);
+			spin_lock(&dcache_lock);
+		}
+		node = dentry->d_subdirs.next;
+	}
+	list_del_init(&dentry->d_child);
+	spin_unlock(&dcache_lock);
+	remove_dir(dentry);
+}
+
+static struct super_operations cpuset_ops = {
+	.statfs = simple_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+static int cpuset_fill_super(struct super_block *sb, void *unused_data,
+							int unused_silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = CPUSET_SUPER_MAGIC;
+	sb->s_op = &cpuset_ops;
+	cpuset_sb = sb;
+
+	inode = cpuset_new_inode(S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR);
+	if (inode) {
+		inode->i_op = &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		/* directories start off with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+	} else {
+		return -ENOMEM;
+	}
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	sb->s_root = root;
+	return 0;
+}
+
+static struct super_block *cpuset_get_sb(struct file_system_type *fs_type,
+					int flags, const char *unused_dev_name,
+					void *data)
+{
+	return get_sb_single(fs_type, flags, data, cpuset_fill_super);
+}
+
+static struct file_system_type cpuset_fs_type = {
+	.name = "cpuset",
+	.get_sb = cpuset_get_sb,
+	.kill_sb = kill_litter_super,
+};
+
+/* struct cftype:
+ *
+ * The files in the cpuset filesystem mostly have a very simple read/write
+ * handling, some common function will take care of it. Nevertheless some cases
+ * (read tasks) are special and therefore I define this structure for every
+ * kind of file.
+ *
+ *
+ * When reading/writing to a file:
+ *	- the cpuset to use in file->f_dentry->d_parent->d_fsdata
+ *	- the 'cftype' of the file is file->f_dentry->d_fsdata
+ */
+
+struct cftype {
+	char *name;
+	int private;
+	int (*open) (struct inode *inode, struct file *file);
+	ssize_t (*read) (struct file *file, char __user *buf, size_t nbytes,
+							loff_t *ppos);
+	int (*write) (struct file *file, const char *buf, size_t nbytes,
+							loff_t *ppos);
+	int (*release) (struct inode *inode, struct file *file);
+};
+
+static inline struct cpuset *__d_cs(struct dentry *dentry)
+{
+	return (struct cpuset *)dentry->d_fsdata;
+}
+
+static inline struct cftype *__d_cft(struct dentry *dentry)
+{
+	return (struct cftype *)dentry->d_fsdata;
+}
+
+/*
+ * is_cpuset_subset(p, q) - Is cpuset p a subset of cpuset q?
+ *
+ * One cpuset is a subset of another if all its allowed CPUs and
+ * Memory Nodes are a subset of the other, and its strict flags are
+ * only set if the other's are set.
+ */
+
+static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
+{
+	return	cpus_subset(p->cpus_allowed, q->cpus_allowed) &&
+		nodes_subset(p->mems_allowed, q->mems_allowed) &&
+		is_cpustrict(p) <= is_cpustrict(q) &&
+		is_memstrict(p) <= is_memstrict(q);
+}
+
+/*
+ * validate_change() - Used to validate that any proposed cpuset change
+ *		       follows the structural rules for cpusets.
+ *
+ * If we replaced the flag and mask values of the current cpuset
+ * (cur) with those values in the trial cpuset (trial), would
+ * our various subset and strict rules still be valid?  Presumes
+ * cpuset_sem held.
+ *
+ * 'cur' is the address of an actual, in-use cpuset.  Operations
+ * such as list traversal that depend on the actual address of the
+ * cpuset in the list must use cur below, not trial.
+ *
+ * 'trial' is the address of bulk structure copy of cur, with
+ * perhaps one or more of the fields cpus_allowed, mems_allowed,
+ * or flags changed to new, trial values.
+ *
+ * Return 0 if valid, -errno if not.
+ */
+
+static int validate_change(const struct cpuset *cur, const struct cpuset *trial)
+{
+	struct cpuset *c, *par = cur->parent;
+
+	/*
+	 * Don't mess with Big Daddy - top_cpuset must remain maximal.
+	 * And besides, the rest of this routine blows chunks if par == 0.
+	 */
+	if (cur == &top_cpuset)
+		return -EPERM;
+
+	/* Any in-use cpuset must have at least ONE cpu and mem */
+	if (atomic_read(&trial->count) > 1) {
+		if (cpus_empty(trial->cpus_allowed))
+			return -ENOSPC;
+		if (nodes_empty(trial->mems_allowed))
+			return -ENOSPC;
+	}
+
+	/* We must be a subset of our parent cpuset */
+	if (!is_cpuset_subset(trial, par))
+		return -EACCES;
+
+	/* Each of our child cpusets must be a subset of us */
+	list_for_each_entry(c, &cur->children, sibling) {
+		if (!is_cpuset_subset(c, trial))
+			return -EBUSY;
+	}
+
+	/* If either I or some sibling (!= me) is strict, we can't overlap */
+	list_for_each_entry(c, &par->children, sibling) {
+		if ((is_cpustrict(trial) || is_cpustrict(c)) &&
+		    c != cur &&
+		    cpus_intersects(trial->cpus_allowed, c->cpus_allowed)
+		) {
+			return -EINVAL;
+		}
+		if ((is_memstrict(trial) || is_memstrict(c)) &&
+		    c != cur &&
+		    nodes_intersects(trial->mems_allowed, c->mems_allowed)
+		) {
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int update_cpumask(struct cpuset *cs, char *buf)
+{
+	struct cpuset trialcs;
+	int retval;
+
+	trialcs = *cs;
+	retval = cpulist_parse(buf, trialcs.cpus_allowed);
+	if (retval < 0)
+		return retval;
+	retval = validate_change(cs, &trialcs);
+	if (retval == 0)
+		cs->cpus_allowed = trialcs.cpus_allowed;
+	return retval;
+}
+
+static int update_nodemask(struct cpuset *cs, char *buf)
+{
+	struct cpuset trialcs;
+	int retval;
+
+	trialcs = *cs;
+	retval = nodelist_parse(buf, trialcs.mems_allowed);
+	if (retval < 0)
+		return retval;
+	retval = validate_change(cs, &trialcs);
+	if (retval == 0)
+		cs->mems_allowed = trialcs.mems_allowed;
+	return retval;
+}
+
+/*
+ * update_flag - read a 0 or a 1 in a file and update associated flag
+ * bit:	the bit to update (CS_CPUSTRICT, CS_MEMSTRICT)
+ * cs:	the cpuset to update
+ * buf:	the buffer where we read the 0 or 1
+ */
+
+static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, char *buf)
+{
+	int turning_on;
+	struct cpuset trialcs;
+	int err;
+
+	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
+
+	trialcs = *cs;
+	if (turning_on)
+		set_bit(bit, &trialcs.flags);
+	else
+		clear_bit(bit, &trialcs.flags);
+
+	err = validate_change(cs, &trialcs);
+	if (err == 0) {
+		if (turning_on)
+			set_bit(bit, &cs->flags);
+		else
+			clear_bit(bit, &cs->flags);
+	}
+	return err;
+}
+
+static int attach_task(struct cpuset *cs, char *buf)
+{
+	int pid;
+	struct task_struct *tsk;
+	struct cpuset *oldcs;
+
+	if (sscanf(buf, "%d", &pid) != 1)
+		return -EIO;
+	if (cpus_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed))
+		return -ENOSPC;
+
+	if (pid) {
+		read_lock(&tasklist_lock);
+
+		tsk = find_task_by_pid(pid);
+		if (!tsk) {
+			read_unlock(&tasklist_lock);
+			return -ESRCH;
+		}
+
+		get_task_struct(tsk);
+		read_unlock(&tasklist_lock);
+
+		if ((current->euid) && (current->euid != tsk->uid)
+		    && (current->euid != tsk->suid)) {
+			put_task_struct(tsk);
+			return -EACCES;
+		}
+	} else {
+		tsk = current;
+		get_task_struct(tsk);
+	}
+
+	task_lock(tsk);
+	oldcs = tsk->cpuset;
+	if (!oldcs) {
+		task_unlock(tsk);
+		put_task_struct(tsk);
+		return -ESRCH;
+	}
+	use_cpuset(cs);
+	tsk->cpuset = cs;
+	task_unlock(tsk);
+
+	put_task_struct(tsk);
+	release_cpuset(oldcs);
+	return 0;
+}
+
+/* The various types of files and directories in a cpuset file system */
+
+typedef enum {
+	FILE_ROOT,
+	FILE_DIR,
+	FILE_CPULIST,
+	FILE_MEMLIST,
+	FILE_CPUSTRICT,
+	FILE_MEMSTRICT,
+	FILE_TASKLIST,
+} cpuset_filetype_t;
+
+static ssize_t cpuset_common_file_write(struct file *file, const char *userbuf,
+					size_t nbytes, loff_t *unused_ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cftype *cft = __d_cft(file->f_dentry);
+	cpuset_filetype_t type = cft->private;
+	char *buffer;
+	int retval = 0;
+
+	/* Crude upper limit on largest legitimate cpulist user might write. */
+	if (nbytes > 100 + 6 * NR_CPUS)
+		return -E2BIG;
+
+	/* +1 for nul-terminator */
+	if ((buffer = kmalloc(nbytes + 1, GFP_KERNEL)) == 0)
+		return -ENOMEM;
+
+	if (copy_from_user(buffer, userbuf, nbytes)) {
+		retval = -EFAULT;
+		goto out1;
+	}
+	buffer[nbytes] = 0;	/* nul-terminate */
+
+	down(&cpuset_sem);
+
+	if (is_removed(cs)) {
+		retval = -ENODEV;
+		goto out2;
+	}
+
+	switch (type) {
+	case FILE_CPULIST:
+		retval = update_cpumask(cs, buffer);
+		break;
+	case FILE_MEMLIST:
+		retval = update_nodemask(cs, buffer);
+		break;
+	case FILE_CPUSTRICT:
+		retval = update_flag(CS_CPUSTRICT, cs, buffer);
+		break;
+	case FILE_MEMSTRICT:
+		retval = update_flag(CS_MEMSTRICT, cs, buffer);
+		break;
+	case FILE_TASKLIST:
+		retval = attach_task(cs, buffer);
+		break;
+	default:
+		retval = -EINVAL;
+		goto out2;
+	}
+
+	if (retval == 0)
+		retval = nbytes;
+out2:
+	up(&cpuset_sem);
+out1:
+	kfree(buffer);
+	return retval;
+}
+
+static ssize_t cpuset_file_write(struct file *file, const char *buf,
+						size_t nbytes, loff_t *ppos)
+{
+	ssize_t retval = 0;
+	struct cftype *cft = __d_cft(file->f_dentry);
+	if (!cft)
+		return -ENODEV;
+
+	/* special function ? */
+	if (cft->write)
+		retval = cft->write(file, buf, nbytes, ppos);
+	else
+		retval = cpuset_common_file_write(file, buf, nbytes, ppos);
+
+	return retval;
+}
+
+static int cpuset_sprintf_list(char *page, unsigned long *mask, int max)
+{
+	char *s = page;
+	int i;
+	int p = 0;		/* n -> n previous cpus were present   */
+	int f = 0;		/* 1 -> at least one cpu was found */
+	/* loop one time more in the case where last cpu is part of a range */
+	for (i = 0; i < max + 1; i++) {
+		if ((i < max) && (test_bit(i, mask))) {
+			if (!p) {
+				if (f)
+					*(s++) = ',';
+				s += sprintf(s, "%d", i);
+			}
+			f = 1;
+			p++;
+		} else {
+			if (f && (p > 1))
+				s += sprintf(s, "-%d", i - 1);
+			p = 0;
+		}
+	}
+	return s - page;
+}
+
+static int cpuset_sprintf_cpulist(char *page, struct cpuset *cs)
+{
+	cpumask_t mask;
+
+	down(&cpuset_sem);
+	mask = cs->cpus_allowed;
+	up(&cpuset_sem);
+
+	return cpuset_sprintf_list(page, cpus_addr(mask), NR_CPUS);
+}
+
+static int cpuset_sprintf_memlist(char *page, struct cpuset *cs)
+{
+	nodemask_t mask;
+
+	down(&cpuset_sem);
+	mask = cs->mems_allowed;
+	up(&cpuset_sem);
+
+	return cpuset_sprintf_list(page, nodes_addr(mask), MAX_NUMNODES);
+}
+
+static ssize_t cpuset_common_file_read(struct file *file, char __user *buf,
+				size_t nbytes, loff_t *ppos)
+{
+	struct cftype *cft = __d_cft(file->f_dentry);
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	cpuset_filetype_t type = cft->private;
+	char *page;
+	ssize_t retval = 0;
+	char *s;
+	char *start;
+	size_t n;
+
+	if (!(page = (char *)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+
+	s = page;
+
+	switch (type) {
+	case FILE_CPULIST:
+		s += cpuset_sprintf_cpulist(s, cs);
+		break;
+	case FILE_MEMLIST:
+		s += cpuset_sprintf_memlist(s, cs);
+		break;
+	case FILE_CPUSTRICT:
+		*s++ = is_cpustrict(cs) ? '1' : '0';
+		break;
+	case FILE_MEMSTRICT:
+		*s++ = is_memstrict(cs) ? '1' : '0';
+		break;
+	default:
+		retval = -EINVAL;
+		goto out;
+	}
+	*s++ = '\n';
+	*s = '\0';
+
+	start = page + *ppos;
+	n = s - start;
+	retval = n - copy_to_user(buf, start, min(n, nbytes));
+	*ppos += retval;
+out:
+	free_page((unsigned long)page);
+	return retval;
+}
+
+static ssize_t cpuset_file_read(struct file *file, char *buf, size_t nbytes,
+								loff_t *ppos)
+{
+	ssize_t retval = 0;
+	struct cftype *cft = __d_cft(file->f_dentry);
+	if (!cft)
+		return -ENODEV;
+
+	/* special function ? */
+	if (cft->read)
+		retval = cft->read(file, buf, nbytes, ppos);
+	else
+		retval = cpuset_common_file_read(file, buf, nbytes, ppos);
+
+	return retval;
+}
+
+static int cpuset_file_open(struct inode *inode, struct file *file)
+{
+	int err;
+	struct cftype *cft;
+
+	err = generic_file_open(inode, file);
+	if (err)
+		return err;
+
+	cft = __d_cft(file->f_dentry);
+	if (!cft)
+		return -ENODEV;
+	if (cft->open)
+		err = cft->open(inode, file);
+	else
+		err = 0;
+
+	return err;
+}
+
+static int cpuset_file_release(struct inode *inode, struct file *file)
+{
+	struct cftype *cft = __d_cft(file->f_dentry);
+	if (cft->release)
+		return cft->release(inode, file);
+	return 0;
+}
+
+static struct file_operations cpuset_file_operations = {
+	.read = cpuset_file_read,
+	.write = cpuset_file_write,
+	.llseek = generic_file_llseek,
+	.open = cpuset_file_open,
+	.release = cpuset_file_release,
+};
+
+static struct inode_operations cpuset_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.mkdir = cpuset_mkdir,
+	.rmdir = cpuset_rmdir,
+};
+
+static int cpuset_create_file(struct dentry *dentry, int mode)
+{
+	struct inode *inode;
+
+	if (!dentry)
+		return -ENOENT;
+	if (dentry->d_inode)
+		return -EEXIST;
+	
+	inode = cpuset_new_inode(mode);
+	if (!inode)
+		return -ENOMEM;
+
+	if (S_ISDIR(mode)) {
+		inode->i_op = &cpuset_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+	
+		/* start off with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+	} else if (S_ISREG(mode)) {
+		inode->i_size = PAGE_SIZE;
+		inode->i_fop = &cpuset_file_operations;
+	}
+
+	d_instantiate(dentry, inode);
+	dget(dentry);	/* Extra count - pin the dentry in core */
+	return 0;
+}
+
+/*
+ *	cpuset_create_dir - create a directory for an object.
+ *	cs: 	the cpuset we create the directory for.
+ *		It must have a valid ->parent field
+ *		And we are going to fill its ->dentry field.
+ *	name:	The name to give to the cpuset directory. Will be copied.
+ *	mode:	mode to set on new directory.
+ */
+
+static int cpuset_create_dir(struct cpuset *cs, const char *name, int mode)
+{
+	struct dentry *dentry = NULL;
+	struct dentry *parent;
+	int error = 0;
+	struct cpuset *csp;
+
+	if (!cs)
+		return -EINVAL;
+
+	csp = cs->parent;
+
+	/* find parent dentry : parent cpuset or fs root ? */
+	if (csp)
+		parent = csp->dentry;
+	else if (cpuset_mount && cpuset_mount->mnt_sb)
+		parent = cpuset_mount->mnt_sb->s_root;
+	else
+		return -EFAULT;
+	dentry = cpuset_get_dentry(parent, name);
+	if (!IS_ERR(dentry)) {
+		error = cpuset_create_file(dentry, S_IFDIR | mode);
+		if (!error) {
+			(dentry)->d_fsdata = cs;
+			parent->d_inode->i_nlink++;
+		}
+		dput(dentry);
+	} else
+		error = PTR_ERR(dentry);
+
+	if (!error)
+		cs->dentry = dentry;
+	return error;
+}
+
+/* MUST be called with dir->d_inode->i_sem held */
+
+static int cpuset_add_file(struct dentry *dir, const struct cftype *cft)
+{
+	struct dentry *dentry;
+	int error;
+
+	dentry = cpuset_get_dentry(dir, cft->name);
+	if (!IS_ERR(dentry)) {
+		error = cpuset_create_file(dentry, 0644 | S_IFREG);
+		if (!error)
+			dentry->d_fsdata = (void *)cft;
+		dput(dentry);
+	} else
+		error = PTR_ERR(dentry);
+	return error;
+}
+
+/*
+ * Stuff for reading the 'tasks' file.
+ *
+ * Reading this file can return large amounts of data if a cpuset has
+ * *lots* of attached tasks. So it may need several calls to read(),
+ * but we cannot guarantee that the information we produce is correct
+ * unless we produce it entirely atomically.
+ *
+ * Upon first file read(), a struct ctr_struct is allocated, that
+ * will have a pointer to an array (also allocated here).  The struct
+ * ctr_struct * is stored in file->private_data.  Its resources will
+ * be freed by release() when the file is closed.  The array is used
+ * to sprintf the PIDs and then used by read().
+ */
+
+/* cpusets_tasks_read array */
+
+struct ctr_struct {
+	int *array;
+	int count;
+};
+
+static struct ctr_struct *cpuset_tasks_mkctr(struct file *file)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct ctr_struct *ctr;
+	pid_t *array;
+	int n, max;
+	pid_t i, j, last;
+	struct task_struct *g, *p;
+
+	ctr = kmalloc(sizeof(*ctr), GFP_KERNEL);
+	if (!ctr)
+		return NULL;
+
+	/*
+	 * If cpuset gets more users after we read count, we won't have
+	 * enough space - tough.  This race is indistinguishable to the
+	 * caller from the case that the additional cpuset users didn't
+	 * show up until sometime later on.  Grabbing cpuset_sem would
+	 * not help, because cpuset_fork() doesn't grab cpuset_sem.
+	 */
+
+	max = atomic_read(&cs->count);
+	array = kmalloc(max * sizeof(pid_t), GFP_KERNEL);
+	if (!array) {
+		kfree(ctr);
+		return NULL;
+	}
+
+	n = 0;
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (p->cpuset == cs) {
+			array[n++] = p->pid;
+			if (unlikely(n == max))
+				goto array_full;
+		}
+	}
+	while_each_thread(g, p);
+array_full:
+	read_unlock(&tasklist_lock);
+
+	/* stupid bubble sort */
+	for (i = 0; i < n - 1; i++) {
+		for (j = 0; j < n - 1 - i; j++)
+			if (array[j + 1] < array[j]) {
+				pid_t tmp = array[j];
+				array[j] = array[j + 1];
+				array[j + 1] = tmp;
+			}
+	}
+
+	/*
+	 * Collapse sorted array by grouping consecutive pids.
+	 * Code range of pids with a negative pid on the second.
+	 * Read from array[i]; write to array]j]; j <= i always.
+	 */
+	last = array[0];  /* any value != array[0] - 1 */
+	j = -1;
+	for (i = 0; i < n; i++) {
+		pid_t curr = array[i];
+		/* consecutive pids ? */
+		if (curr - last == 1) {
+			/* move destination index if it has not been done */
+			if (array[j] > 0)
+				j++;
+			array[j] = -curr;
+		} else
+			array[++j] = curr;
+		last = curr;
+	}
+
+	ctr->array = array;
+	ctr->count = j + 1;
+	file->private_data = (void *)ctr;
+	return ctr;
+}
+
+/* printf one pid from an array
+ * different formatting depending on whether it is positive or negative,
+ * or whether it is or not the first pid or the last
+ */
+static int array_pid_sprintf(char *buf, pid_t *array, int idx, int last)
+{
+	pid_t v = array[idx];
+	int l = 0;
+
+	if (v < 0) {		/* second pid of a range of pids */
+		v = -v;
+		buf[l++] = '-';
+	} else {		/* first pid of a range, or not a range */
+		if (idx)	/* comma only if it's not the first */
+			buf[l++] = ',';
+	}
+	l += sprintf(buf + l, "%d", v);
+	/* newline after last record */
+	if (idx == last)
+		l += sprintf(buf + l, "\n");
+	return l;
+}
+
+static ssize_t cpuset_tasks_read(struct file *file, char __user *buf,
+						size_t nbytes, loff_t *ppos)
+{
+	struct ctr_struct *ctr = (struct ctr_struct *)file->private_data;
+	int *array, nr_pids, i;
+	size_t len, lastlen = 0;
+	char *page;
+
+	/* allocate buffer and fill it on first call to read() */
+	if (!ctr) {
+		ctr = cpuset_tasks_mkctr(file);
+		if (!ctr)
+			return -ENOMEM;
+	}
+
+	array = ctr->array;
+	nr_pids = ctr->count;
+
+	if (!(page = (char *)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+
+	i = *ppos;		/* index of pid being printed */
+	len = 0;		/* length of data sprintf'ed in the page */
+
+	while ((len < PAGE_SIZE - 10) && (i < nr_pids) && (len < nbytes)) {
+		lastlen = array_pid_sprintf(page + len, array, i++, nr_pids - 1);
+		len += lastlen;
+	}
+
+	/* if we wrote too much, remove last record */
+	if (len > nbytes) {
+		len -= lastlen;
+		i--;
+	}
+
+	*ppos = i;
+
+	if (copy_to_user(buf, page, len))
+		len = -EFAULT;
+	free_page((unsigned long)page);
+	return len;
+}
+
+static int cpuset_tasks_release(struct inode *unused_inode, struct file *file)
+{
+	struct ctr_struct *ctr;
+
+	/* we have nothing to do if no read-access is needed */
+	if (!(file->f_mode & FMODE_READ))
+		return 0;
+
+	ctr = (struct ctr_struct *)file->private_data;
+	kfree(ctr->array);
+	kfree(ctr);
+	return 0;
+}
+
+/*
+ * for the common functions, 'private' gives the type of file
+ */
+
+static struct cftype cft_tasks = {
+	.name = "tasks",
+	.read = cpuset_tasks_read,
+	.release = cpuset_tasks_release,
+	.private = FILE_TASKLIST,
+};
+
+static struct cftype cft_cpus = {
+	.name = "cpus",
+	.private = FILE_CPULIST,
+};
+
+static struct cftype cft_mems = {
+	.name = "mems",
+	.private = FILE_MEMLIST,
+};
+
+static struct cftype cft_cpustrict = {
+	.name = "cpustrict",
+	.private = FILE_CPUSTRICT,
+};
+
+static struct cftype cft_memstrict = {
+	.name = "memstrict",
+	.private = FILE_MEMSTRICT,
+};
+
+/* MUST be called with ->d_inode->i_sem held */
+static int cpuset_populate_dir(struct dentry *cs_dentry)
+{
+	int err;
+
+	if ((err = cpuset_add_file(cs_dentry, &cft_cpus)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_mems)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_cpustrict)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_memstrict)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
+		return err;
+	return 0;
+}
+
+/*
+ *	cpuset_create - create a cpuset
+ *	parent:	cpuset that will be parent of the new cpuset.
+ *	name:		name of the new cpuset. Will be strcpy'ed.
+ *	mode:		mode to set on new inode
+ *
+ *	Must be called with the semaphore on the parent inode held
+ */
+
+static long cpuset_create(struct cpuset *parent, const char *name, int mode)
+{
+	struct cpuset *cs;
+	int err;
+
+	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
+	if (!cs)
+		return -ENOMEM;
+
+	down(&cpuset_sem);
+	use_cpuset(parent);	/* child needs parent to live */
+	cs->flags = 0;
+	cs->cpus_allowed = parent->cpus_allowed;
+	cs->mems_allowed = parent->mems_allowed;
+	atomic_set(&cs->count, 0);
+	INIT_LIST_HEAD(&cs->sibling);
+	INIT_LIST_HEAD(&cs->children);
+
+
+	cs->parent = parent;
+
+	list_add(&cs->sibling, &cs->parent->children);
+
+	err = cpuset_create_dir(cs, name, mode);
+	if (err < 0)
+		goto err;
+	err = cpuset_populate_dir(cs->dentry);
+	up(&cpuset_sem);
+	return err;
+err:
+	list_del(&cs->sibling);
+	release_cpuset(parent);
+	up(&cpuset_sem);
+	kfree(cs);
+	return err;
+}
+
+static int cpuset_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	struct dentry *d_parent = dentry->d_parent;
+	struct cpuset *c_parent = (struct cpuset *)d_parent->d_fsdata;
+
+	/* the vfs holds inode->i_sem already */
+	return cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
+}
+
+static int cpuset_rmdir(struct inode *unused_dir, struct dentry *dentry)
+{
+	struct cpuset *cs = (struct cpuset *)dentry->d_fsdata;
+	struct dentry *d;
+	struct cpuset *parent;
+
+	/* the vfs holds both inode->i_sem already */
+
+	down(&cpuset_sem);
+	if (atomic_read(&cs->count) > 0) {
+		up(&cpuset_sem);
+		return -EBUSY;
+	}
+	spin_lock(&cs->dentry->d_lock);
+	parent = cs->parent;
+	set_bit(CS_REMOVED, &cs->flags);
+	list_del(&cs->sibling);
+	d = dget(cs->dentry);
+	cs->dentry = NULL;
+	spin_unlock(&d->d_lock);
+	cpuset_d_remove_dir(d);
+	dput(d);
+	release_cpuset(parent);
+	up(&cpuset_sem);
+	return 0;
+}
+
+/**
+ * cpuset_init - initialize cpusets at system boot
+ *
+ * Description: Initialize top_cpuset and the cpuset internal file system,
+ **/
+
+int __init cpuset_init(void)
+{
+	int err;
+
+	top_cpuset.cpus_allowed = cpu_possible_map;
+	top_cpuset.mems_allowed = node_possible_map;
+
+	init_task.cpuset = &top_cpuset;
+
+	err = register_filesystem(&cpuset_fs_type);
+	if (err < 0)
+		goto out;
+	cpuset_mount = kern_mount(&cpuset_fs_type);
+	if (IS_ERR(cpuset_mount)) {
+		printk(KERN_ERR "cpuset: could not mount!\n");
+		err = PTR_ERR(cpuset_mount);
+		cpuset_mount = NULL;
+		goto out;
+	}
+	err = cpuset_create_dir(&top_cpuset, "top_cpuset", 0644);
+	if (err < 0)
+		goto out;
+	err = cpuset_populate_dir(top_cpuset.dentry);
+out:
+	return err;
+}
+
+/**
+ * cpuset_fork - attach newly forked task to its parents cpuset.
+ * @p: pointer to task_struct of forking parent process.
+ *
+ * Description: By default, on fork, a task inherits its
+ * parents cpuset.  The pointer to the shared cpuset is
+ * automatically copied in fork.c by dup_task_struct().
+ * This cpuset_fork() routine need only increment the usage
+ * counter in that cpuset.
+ **/
+
+void cpuset_fork(struct task_struct *tsk)
+{
+	use_cpuset(tsk->cpuset);
+}
+
+/**
+ * cpuset_exit - detach exiting task from cpuset
+ * @tsk: pointer to task_struct of exiting process
+ *
+ * Description: Detach @tsk from its cpuset and release
+ * that cpuset (which will decrement its usage and perhaps
+ * remove it.)
+ **/
+
+void cpuset_exit(struct task_struct *tsk)
+{
+	task_lock(tsk);
+	release_cpuset(tsk->cpuset);
+	tsk->cpuset = NULL;
+	task_unlock(tsk);
+}
+
+/**
+ * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
+ *
+ * Description: Returns the cpumask_t cpus_allowed of the cpuset
+ * attached to the specified @tsk.
+ **/
+
+const cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
+{
+	cpumask_t mask;
+
+	down(&cpuset_sem);
+	task_lock((struct task_struct *)tsk);
+	if (tsk->cpuset)
+		mask = tsk->cpuset->cpus_allowed;
+	else
+		mask = CPU_MASK_ALL;
+	task_unlock((struct task_struct *)tsk);
+	up(&cpuset_sem);
+
+	return mask;
+}
+
+/**
+ * cpuset_mems_allowed - return mems_allowed mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->mems_allowed.
+ *
+ * Description: Returns the nodemask_t mems_allowed of the cpuset
+ * attached to the specified @tsk.
+ **/
+
+const nodemask_t cpuset_mems_allowed(const struct task_struct *tsk)
+{
+	nodemask_t mask;
+
+	down(&cpuset_sem);
+	task_lock((struct task_struct *)tsk);
+	if (tsk->cpuset)
+		mask = tsk->cpuset->mems_allowed;
+	else
+		mask = NODE_MASK_ALL;
+	task_unlock((struct task_struct *)tsk);
+	up(&cpuset_sem);
+
+	return mask;
+}
+
+/**
+ * proc_pid_cspath - print tasks cpuset path into buffer
+ * @tsk: pointer to task_struct of task whose cpuset's path to print
+ * @buf: pointer to buffer into which to print path
+ * @buflen: length of @buf
+ *
+ * Description: Print task's cpuset path (without mountpoint)
+ * in the given buffer. Used for /proc/<pid>/cpuset.
+ */
+
+int proc_pid_cspath(struct task_struct *tsk, char *buf, int buflen)
+{
+	char *endbuf = buf + buflen;
+	char *start = endbuf;
+	struct cpuset *cs;
+	int count;
+
+	down(&cpuset_sem);
+	task_lock(tsk);
+	cs = tsk->cpuset;
+	task_unlock(tsk);
+	if (!cs)
+		return -EINVAL;
+	*--start = '\n';
+	for (;;) {
+		int l = cs->dentry->d_name.len;
+		start -= l;
+		if (start < buf)
+			goto toolong;
+		memcpy(start, cs->dentry->d_name.name, l);
+		cs = cs->parent;
+		if (!cs)
+			break;
+		if (--start < buf)
+			goto toolong;
+		*start = '/';
+	}
+	count = endbuf - start;
+	memmove(buf, start, count);
+	up(&cpuset_sem);
+	return count;
+toolong:
+	up(&cpuset_sem);
+	return -ENAMETOOLONG;
+}

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
