Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267622AbUHEKRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267622AbUHEKRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHEKRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:17:43 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:20966 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267622AbUHEKM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:12:56 -0400
Date: Thu, 5 Aug 2004 03:10:23 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       Sylvain Jeaugey <sylvain.jeaugey@bull.net>, Dan Higgins <djh@sgi.com>,
       linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       lse-tech@lists.sourceforge.net, Paul Jackson <pj@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <20040805101038.3740.52850.89920@sam.engr.sgi.com>
In-Reply-To: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
Subject: [PATCH] cpusets - big numa cpu and memory placement
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I would like to propose the following patch for inclusion in your
2.6.9-*mm series, when that opens.  It provides an important facility
for high performance computing on large systems.  Simon Derr of Bull
(France) and myself are the primary authors.

I offer it to lkml now, in order to invite continued feedback.
Thank-you to several who have provided valuable feedback so far,
including Christoph and Andi (I make no claim that they endorse
this patch).

This is the third time I have posted cpusets on lkml.  The first two
times, a month or two ago, were more preliminary.  I believe that
the code is now in good enough shape to be considered for inclusion
in your kernels.

The one prerequiste patch for this cpuset patch was just posted
before this one.  That was a patch to provide a new bitmap list
format, of which cpusets is the first user.

Changes since July 2 (previous lkml posting):
  - The bitmap, cpumask and nodemask work on which the earlier
    patches depended are now included in your patches.
  - Locking around the cpuset struct simplified and rewritten.
  - Just one cpuset patch now (plus bitmap list format), not 8 of them.
  - Memory restriction in page_alloc and vmscan added (thanks, Andi).
  - Term 'strict' for cpusets that others can't use changed to the
    term 'exclusive' (to avoid collision with the use of the same
    word in Andi's numa work for the reverse meaning).
  - Superfluous 'top_cpuset' layer removed from visible mounted
    cpuset file system.
  - The /proc/<pid>/cpuset hook for displaying a tasks current
    cpuset path uses seq_file now.
  - Notify_on_release calls /sbin/cpuset_release_agent, not
    /sbin/hotplug.  [Hence no CONFIG_HOTPLUG dependency.]
  - kernel/cpuset.c cpuset_sprintf_list() code moved to lib/bitmap.c,
    and rewritten to be simpler.
  - kernel/cpuset.c cpuset_path() code simplified.

This patch has been built on top of 2.6.8-rc2-mm2, for several arch's,
with and without CONFIG_CPUSET.  No doubt you will be glad to know that
it has much fewer arch dependencies (none, that I know of) than the
dreaded cpumask patch.  It has been built, booted and tested in various
forms over the last several months by a few developers at SGI and Bull.

===

Cpusets provide a mechanism for assigning a set of CPUs and Memory
Nodes to a set of tasks.

Cpusets constrain the CPU and Memory placement of tasks to only
the processor and memory resources within a tasks current cpuset.
They form a nested hierarchy visible in a virtual file system.
These are the essential hooks, beyond what is already present,
required to manage dynamic job placement on large systems.

Cpusets require small kernel hooks in init, exit, fork, mempolicy,
sched_setaffinity, page_alloc and vmscan.  And they require a "struct
cpuset" pointer and a "mems_allowed" nodemask_t (to go along with the
"cpus_allowed" cpumask_t that's already there) in each task struct.

These hooks:
  1) establish and propagate cpusets, 
  2) enforce CPU placement in sched_setaffinity,
  3) enforce Memory placement in mbind and sys_set_mempolicy,
  4) restrict page allocation and scanning to mems_allowed, and
  5) restrict migration and set_cpus_allowed to cpus_allowed.

The other required hook, restricting task scheduling to CPUs
in a tasks cpus_allowed mask, is already present.

Cpusets extend the usefulness of, the existing placement support that
was added to Linux 2.6 kernels: sched_setaffinity() for CPU placement,
and mbind and set_mempolicy for memory placement.  On smaller or
dedicated use systems, the existing calls are often sufficient.

On larger NUMA systems, running more than one, performance critical,
job, it is necessary to be able to manage jobs in their entirety.
This includes providing a job with exclusive CPU and memory that no
other job can use, and being able to list all tasks currently in a
cpuset.

A given job running within a cpuset, would likely use the existing
placement calls to manage its CPU and memory placement in more detail.

Cpusets are named, nested sets of CPUs and Memory Nodes.  Each cpuset
is represented by a directory in the cpuset virtual file system,
normally mounted at /dev/cpuset.

Each cpuset directory provides the following files, which can be
read and written:

  cpus:
      List of CPUs allowed to tasks in that cpuset.
  
  mems:
      List of Memory Nodes allowed to tasks in that cpuset.
  
  tasks:
      List of pid's of tasks in that cpuset.
  
  cpu_exclusive:
      Flag (0 or 1) - if set, cpuset has exclusive use of
      its CPUs (no sibling or cousin cpuset may overlap CPUs).
  
  mem_exclusive:
      Flag (0 or 1) - if set, cpuset has exclusive use of
      its Memory Nodes (no sibling or cousin may overlap).
  
  notify_on_release:
      Flag (0 or 1) - if set, then /sbin/cpuset_release_agent
      will be invoked, with the name (/dev/cpuset relative path)
      of that cpuset in argv[1], when the last user of it (task
      or child cpuset) goes away.  This supports automatic
      cleanup of abandoned cpusets.

In addition one new filetype is added to the /proc file system:

  /proc/<pid>/cpuset:
      For each task (pid), list its cpuset path, relative to the
      root of the cpuset file system.  This file is read-only.

New cpusets are created using 'mkdir' (at the shell or in C).
Old ones are removed using 'rmdir'.  The above files are accessed
using read(2) and write(2) system calls, or shell commands such
as 'cat' and 'echo'.

The CPUs and Memory Nodes in a given cpuset are always a subset
of its parent.  The root cpuset has all possible CPUs and Memory
Nodes in the system.  A cpuset may be exclusive (cpu or memory)
only if its parent is similarly exclusive.

See further Documentation/cpusets.txt, at the top of the following
patch.

 Documentation/cpusets.txt |  381 +++++++++++
 fs/proc/base.c            |   19 
 include/linux/cpuset.h    |   61 +
 include/linux/sched.h     |    6 
 init/Kconfig              |   10 
 init/main.c               |    3 
 kernel/Makefile           |    1 
 kernel/cpuset.c           | 1477 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/exit.c             |    2 
 kernel/fork.c             |    3 
 kernel/sched.c            |    9 
 mm/mempolicy.c            |    9 
 mm/page_alloc.c           |   14 
 mm/vmscan.c               |   19 
 14 files changed, 2009 insertions(+), 5 deletions(-)

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.8-rc2-mm2/Documentation/cpusets.txt
===================================================================
--- 2.6.8-rc2-mm2.orig/Documentation/cpusets.txt	2003-03-14 05:07:09.000000000 -0800
+++ 2.6.8-rc2-mm2/Documentation/cpusets.txt	2004-08-05 01:44:59.000000000 -0700
@@ -0,0 +1,387 @@
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
+Cpusets provide a mechanism for assigning a set of CPUs and Memory
+Nodes to a set of tasks.
+
+Cpusets constrain the CPU and Memory placement of tasks to only
+the resources within a tasks current cpuset.  They form a nested
+hierarchy visible in a virtual file system.  These are the essential
+hooks, beyond what is already present, required to manage dynamic
+job placement on large systems.
+
+Each task has a pointer to a cpuset.  Multiple tasks may reference
+the same cpuset.  Requests by a task, using the sched_setaffinity(2)
+system call to include CPUs in its CPU affinity mask, and using the
+mbind(2) and set_mempolicy(2) system calls to include Memory Nodes
+in its memory policy, are both filtered through that tasks cpuset,
+filtering out any CPUs or Memory Nodes not in that cpuset.  The
+scheduler will not schedule a task on a CPU that is not allowed in
+its cpus_allowed vector, and the kernel page allocator will not
+allocate a page on a node that is not allowed in the requesting tasks
+mems_allowed vector.
+
+If a cpuset is cpu or mem exclusive, no other cpuset, other than a direct
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
+ - A cpuset may be marked exclusive, which ensures that no other
+   cpuset (except direct ancestors and descendents) may contain
+   any overlapping CPUs or Memory Nodes.
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
+ - in page_alloc, to restrict memory to allowed nodes.
+ - in vmscan.c, to restrict page recovery to the current cpuset.
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
+ - cpu_exclusive flag: is cpu placement exclusive?
+ - mem_exclusive flag: is memory placement exclusive?
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
+ - It can only be marked exclusive if its parent is.
+ - If its cpu or memory is exclusive, they may not overlap any sibling.
+
+These rules, and the natural hierarchy of cpusets, enable efficient
+enforcement of the exclusive guarantee, without having to scan all
+cpusets every time any of them change to ensure nothing overlaps a
+exclusive cpuset.  Also, the use of a Linux virtual file system (vfs)
+to represent the cpuset hierarchy provides for a familiar permission
+and name space for cpusets, with a minimum of additional kernel code.
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
+cpus  cpu_exclusive  mems  mem_exclusive  tasks
+
+Reading them will give you information about the state of this cpuset:
+the CPUs and Memory Nodes it can use, the processes that are using
+it, its properties.  By writing to these files you can manipulate
+the cpuset.
+
+Set some flags:
+# /bin/echo 1 > cpu_exclusive
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
+# /bin/echo 1 > cpu_exclusive 	-> set flag 'cpu_exclusive'
+# /bin/echo 0 > cpu_exclusive 	-> unset flag 'cpu_exclusive'
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
Index: 2.6.8-rc2-mm2/fs/proc/base.c
===================================================================
--- 2.6.8-rc2-mm2.orig/fs/proc/base.c	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/fs/proc/base.c	2004-08-04 21:44:49.000000000 -0700
@@ -32,6 +32,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/cpuset.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -60,6 +61,9 @@ enum pid_directory_inos {
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+#ifdef CONFIG_CPUSETS
+	PROC_TGID_CPUSET,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TGID_ATTR,
 	PROC_TGID_ATTR_CURRENT,
@@ -83,6 +87,9 @@ enum pid_directory_inos {
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+#ifdef CONFIG_CPUSETS
+	PROC_TID_CPUSET,
+#endif
 #ifdef CONFIG_SECURITY
 	PROC_TID_ATTR,
 	PROC_TID_ATTR_CURRENT,
@@ -123,6 +130,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_CPUSETS
+	E(PROC_TGID_CPUSET,    "cpuset",  S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -145,6 +155,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_CPUSETS
+	E(PROC_TID_CPUSET,     "cpuset",  S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -1376,6 +1389,12 @@ static struct dentry *proc_pident_lookup
 			ei->op.proc_read = proc_pid_wchan;
 			break;
 #endif
+#ifdef CONFIG_CPUSETS
+		case PROC_TID_CPUSET:
+		case PROC_TGID_CPUSET:
+			inode->i_fop = &proc_cpuset_operations;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: 2.6.8-rc2-mm2/include/linux/cpuset.h
===================================================================
--- 2.6.8-rc2-mm2.orig/include/linux/cpuset.h	2003-03-14 05:07:09.000000000 -0800
+++ 2.6.8-rc2-mm2/include/linux/cpuset.h	2004-08-04 21:44:49.000000000 -0700
@@ -0,0 +1,61 @@
+#ifndef _LINUX_CPUSET_H
+#define _LINUX_CPUSET_H
+/*
+ *  cpuset interface
+ *
+ *  Copyright (C) 2003 BULL SA
+ *  Copyright (C) 2004 Silicon Graphics, Inc.
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
+void cpuset_init_current_mems_allowed(void);
+void cpuset_update_current_mems_allowed(void);
+void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
+int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
+int cpuset_zone_allowed(struct zone *z);
+extern struct file_operations proc_cpuset_operations;
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
+static inline void cpuset_init_current_mems_allowed(void) {}
+static inline void cpuset_update_current_mems_allowed(void) {}
+static inline void cpuset_restrict_to_mems_allowed(unsigned long *nodes) {}
+
+static inline int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl)
+{
+	return 1;
+}
+
+static inline int cpuset_zone_allowed(struct zone *z)
+{
+	return 1;
+}
+
+#endif /* !CONFIG_CPUSETS */
+
+#endif /* _LINUX_CPUSET_H */
Index: 2.6.8-rc2-mm2/include/linux/sched.h
===================================================================
--- 2.6.8-rc2-mm2.orig/include/linux/sched.h	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/include/linux/sched.h	2004-08-04 21:44:49.000000000 -0700
@@ -13,6 +13,7 @@
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
 #include <linux/cpumask.h>
+#include <linux/nodemask.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -370,6 +371,7 @@ struct k_itimer {
 
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
+struct cpuset;
 
 #define NGROUPS_SMALL		32
 #define NGROUPS_PER_BLOCK	((int)(PAGE_SIZE / sizeof(gid_t)))
@@ -551,6 +553,10 @@ struct task_struct {
 	struct rw_semaphore pagg_sem;
 #endif
 
+#ifdef CONFIG_CPUSETS
+	struct cpuset *cpuset;
+	nodemask_t mems_allowed;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: 2.6.8-rc2-mm2/init/Kconfig
===================================================================
--- 2.6.8-rc2-mm2.orig/init/Kconfig	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/init/Kconfig	2004-08-04 21:44:49.000000000 -0700
@@ -278,6 +278,16 @@ config EPOLL
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
+config CPUSETS
+	bool "Cpuset support"
+	help
+	  This options will let you create and manage CPUSET's which
+	  allow dynamically partitioning a system into sets of CPUs and
+	  Memory Nodes and assigning tasks to run only within those sets.
+	  This is primarily useful on large SMP or NUMA systems.
+
+	  Say N if unsure.
+
 source "drivers/block/Kconfig.iosched"
 
 config CC_OPTIMIZE_FOR_SIZE
Index: 2.6.8-rc2-mm2/init/main.c
===================================================================
--- 2.6.8-rc2-mm2.orig/init/main.c	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/init/main.c	2004-08-04 21:44:49.000000000 -0700
@@ -41,6 +41,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
+#include <linux/cpuset.h>
 #include <linux/unistd.h>
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
@@ -568,6 +569,8 @@ asmlinkage void __init start_kernel(void
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
+	cpuset_init();
+
 	check_bugs();
 
 	/* Do the rest non-__init'ed, we're now alive */
Index: 2.6.8-rc2-mm2/kernel/Makefile
===================================================================
--- 2.6.8-rc2-mm2.orig/kernel/Makefile	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/kernel/Makefile	2004-08-04 21:44:49.000000000 -0700
@@ -25,6 +25,7 @@ obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_CPUSETS) += cpuset.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: 2.6.8-rc2-mm2/kernel/cpuset.c
===================================================================
--- 2.6.8-rc2-mm2.orig/kernel/cpuset.c	2003-03-14 05:07:09.000000000 -0800
+++ 2.6.8-rc2-mm2/kernel/cpuset.c	2004-08-04 21:44:49.000000000 -0700
@@ -0,0 +1,1477 @@
+/*
+ *  kernel/cpuset.c
+ *
+ *  Processor and Memory placement constraints for sets of tasks.
+ *
+ *  Copyright (C) 2003 BULL SA.
+ *  Copyright (C) 2004 Silicon Graphics, Inc.
+ *
+ *  Portions derived from Patrick Mochel's sysfs code.
+ *  sysfs is Copyright (c) 2001-3 Patrick Mochel
+ *  Portions Copyright (c) 2004 Silicon Graphics, Inc.
+ *
+ *  2003-10-10 Written by Simon Derr <simon.derr@bull.net>
+ *  2003-10-22 Updates by Stephen Hemminger.
+ *  2004 May-July Rework by Paul Jackson <pj@sgi.com>
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
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
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
+
+	atomic_t count;			/* count tasks using this cpuset */
+
+	/*
+	 * We link our 'sibling' struct into our parents 'children'.
+	 * Our children link their 'sibling' into our 'children'.
+	 */
+	struct list_head sibling;	/* my parents children */
+	struct list_head children;	/* my children */
+
+	struct cpuset *parent;		/* my parent */
+	struct dentry *dentry;		/* cpuset fs entry */
+};
+
+/* bits in struct cpuset flags field */
+typedef enum {
+	CS_CPU_EXCLUSIVE,
+	CS_MEM_EXCLUSIVE,
+	CS_REMOVED,
+	CS_NOTIFY_ON_RELEASE
+} cpuset_flagbits_t;
+
+/* convenient tests for these bits */
+static inline int is_cpu_exclusive(const struct cpuset *cs)
+{
+	return !!test_bit(CS_CPU_EXCLUSIVE, &cs->flags);
+}
+
+static inline int is_mem_exclusive(const struct cpuset *cs)
+{
+	return !!test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
+}
+
+static inline int is_removed(const struct cpuset *cs)
+{
+	return !!test_bit(CS_REMOVED, &cs->flags);
+}
+
+static inline int notify_on_release(const struct cpuset *cs)
+{
+	return !!test_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
+}
+
+static struct cpuset top_cpuset = {
+	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
+	.cpus_allowed = CPU_MASK_ALL,
+	.mems_allowed = NODE_MASK_ALL,
+	.count = ATOMIC_INIT(0),
+	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
+	.children = LIST_HEAD_INIT(top_cpuset.children),
+	.parent = NULL,
+	.dentry = NULL,
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
+ * all cpuset modifications (except for counter manipulations from
+ * fork and exit) across the system.  This presumes that cpuset
+ * modifications are rare - better kept simple and safe, even if slow.
+ *
+ * The code that reads cpusets, such as in cpuset_common_file_read()
+ * and below, only holds cpuset_sem across small pieces of code, such
+ * as when reading out possibly multi-word cpumasks and nodemasks, as
+ * the risks are less, and the desire for performance a little greater.
+ * The proc_cpuset_show() routine needs to hold cpuset_sem to insure
+ * that no cs->dentry is NULL, as it walks up the cpuset tree to root.
+ *
+ * The hooks from fork and exit, cpuset_fork() and cpuset_exit(), don't
+ * (usually) grab cpuset_sem.  These are the two most performance
+ * critical pieces of code here.  The exception occurs on exit(),
+ * if the last task using a cpuset exits, and the cpuset was marked
+ * notify_on_release.  In that case, the cpuset_sem is taken, the
+ * path to the released cpuset calculated, and a usermode call made
+ * to /sbin/cpuset_release_agent with the name of the cpuset (path
+ * relative to the root of cpuset file system) as the argument.
+ *
+ * A cpuset can only be deleted if both its 'count' of using tasks is
+ * zero, and its list of 'children' cpusets is empty.  Since all tasks
+ * in the system use _some_ cpuset, and since there is always at least
+ * one task in the system (init, pid == 1), therefore, top_cpuset
+ * always has either children cpusets and/or using tasks.  So no need
+ * for any special hack to ensure that top_cpuset cannot be deleted.
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
+
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
+ * Call with cpuset_sem held.  Writes path of cpuset into buf.
+ * Returns 0 on success, -errno on error.
+ */
+
+static int cpuset_path(const struct cpuset *cs, char *buf, int buflen)
+{
+	char *start;
+
+	start = buf + buflen;
+
+	*--start = '\0';
+	for (;;) {
+		int len = cs->dentry->d_name.len;
+		if ((start -= len) < buf)
+			return -ENAMETOOLONG;
+		memcpy(start, cs->dentry->d_name.name, len);
+		cs = cs->parent;
+		if (!cs)
+			break;
+		if (!cs->parent)
+			continue;
+		if (--start < buf)
+			return -ENAMETOOLONG;
+		*start = '/';
+	}
+	memmove(buf, start, buf + buflen - start);
+	return 0;
+}
+
+/*
+ * Notify userspace when a cpuset is released, by running
+ * /sbin/cpuset_release_agent with the name of the cpuset (path
+ * relative to the root of cpuset file system) as the argument.
+ *
+ * Most likely, this user command will try to rmdir this cpuset.
+ *
+ * This races with the possibility that some other task will be
+ * attached to this cpuset before it is removed, or that some other
+ * user task will 'mkdir' a child cpuset of this cpuset.  That's ok.
+ * The presumed 'rmdir' will fail quietly if this cpuset is no longer
+ * unused, and this cpuset will be reprieved from its death sentence,
+ * to continue to serve a useful existence.  Next time it's released,
+ * we will get notified again, if it still has 'notify_on_release' set.
+ *
+ * Note final arg to call_usermodehelper() is 0 - that means
+ * don't wait.  Since we are holding the global cpuset_sem here,
+ * and we are asking another thread (started from keventd) to rmdir a
+ * cpuset, we can't wait - or we'd deadlock with the removing thread
+ * on cpuset_sem.
+ */
+
+static int cpuset_release_agent(char *cpuset_str)
+{
+	char *argv[3], *envp[3];
+	int i;
+
+	i = 0;
+	argv[i++] = "/sbin/cpuset_release_agent";
+	argv[i++] = cpuset_str;
+	argv[i] = NULL;
+
+	i = 0;
+	/* minimal command environment */
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp[i] = NULL;
+
+	return call_usermodehelper(argv[0], argv, envp, 0);
+}
+
+/*
+ * Either cs->count of using tasks transitioned to zero, or the
+ * cs->children list of child cpusets just became empty.  If this
+ * cs is notify_on_release() and now both the user count is zero and
+ * the list of children is empty, send notice to user land.
+ */
+
+static void check_for_release(struct cpuset *cs)
+{
+	if (notify_on_release(cs) && atomic_read(&cs->count) == 0 &&
+	    list_empty(&cs->children)) {
+		char *buf;
+
+		buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!buf)
+			return;
+		if (cpuset_path(cs, buf, PAGE_SIZE) < 0)
+			goto out;
+		cpuset_release_agent(buf);
+	out:
+		kfree(buf);
+	}
+}
+
+/*
+ * is_cpuset_subset(p, q) - Is cpuset p a subset of cpuset q?
+ *
+ * One cpuset is a subset of another if all its allowed CPUs and
+ * Memory Nodes are a subset of the other, and its exclusive flags
+ * are only set if the other's are set.
+ */
+
+static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
+{
+	return	cpus_subset(p->cpus_allowed, q->cpus_allowed) &&
+		nodes_subset(p->mems_allowed, q->mems_allowed) &&
+		is_cpu_exclusive(p) <= is_cpu_exclusive(q) &&
+		is_mem_exclusive(p) <= is_mem_exclusive(q);
+}
+
+/*
+ * validate_change() - Used to validate that any proposed cpuset change
+ *		       follows the structural rules for cpusets.
+ *
+ * If we replaced the flag and mask values of the current cpuset
+ * (cur) with those values in the trial cpuset (trial), would
+ * our various subset and exclusive rules still be valid?  Presumes
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
+	/* If either I or some sibling (!= me) is exclusive, we can't overlap */
+	list_for_each_entry(c, &par->children, sibling) {
+		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
+		    c != cur &&
+		    cpus_intersects(trial->cpus_allowed, c->cpus_allowed)
+		) {
+			return -EINVAL;
+		}
+		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
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
+ * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
+ *						CS_NOTIFY_ON_RELEASE)
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
+	pid_t pid;
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
+	atomic_inc(&cs->count);
+	tsk->cpuset = cs;
+	task_unlock(tsk);
+
+	put_task_struct(tsk);
+	if (atomic_dec_and_test(&oldcs->count))
+		check_for_release(oldcs);
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
+	FILE_CPU_EXCLUSIVE,
+	FILE_MEM_EXCLUSIVE,
+	FILE_NOTIFY_ON_RELEASE,
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
+	case FILE_CPU_EXCLUSIVE:
+		retval = update_flag(CS_CPU_EXCLUSIVE, cs, buffer);
+		break;
+	case FILE_MEM_EXCLUSIVE:
+		retval = update_flag(CS_MEM_EXCLUSIVE, cs, buffer);
+		break;
+	case FILE_NOTIFY_ON_RELEASE:
+		retval = update_flag(CS_NOTIFY_ON_RELEASE, cs, buffer);
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
+/*
+ * These ascii lists should be read in a single call, by using a user
+ * buffer large enough to hold the entire map.  If read in smaller
+ * chunks, there is no guarantee of atomicity.  Since the display format
+ * used, list of ranges of sequential numbers, is variable length,
+ * and since these maps can change value dynamically, one could read
+ * gibberish by doing partial reads while a list was changing.
+ * A single large read to a buffer that crosses a page boundary is
+ * ok, because the result being copied to user land is not recomputed
+ * across a page fault.
+ */
+
+static int cpuset_sprintf_cpulist(char *page, struct cpuset *cs)
+{
+	cpumask_t mask;
+
+	down(&cpuset_sem);
+	mask = cs->cpus_allowed;
+	up(&cpuset_sem);
+
+	return cpulist_scnprintf(page, PAGE_SIZE, mask);
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
+	return nodelist_scnprintf(page, PAGE_SIZE, mask);
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
+	case FILE_CPU_EXCLUSIVE:
+		*s++ = is_cpu_exclusive(cs) ? '1' : '0';
+		break;
+	case FILE_MEM_EXCLUSIVE:
+		*s++ = is_mem_exclusive(cs) ? '1' : '0';
+		break;
+	case FILE_NOTIFY_ON_RELEASE:
+		*s++ = notify_on_release(cs) ? '1' : '0';
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
+		inode->i_size = 0;
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
+
+	parent = cs->parent->dentry;
+	dentry = cpuset_get_dentry(parent, name);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	error = cpuset_create_file(dentry, S_IFDIR | mode);
+	if (!error) {
+		dentry->d_fsdata = cs;
+		parent->d_inode->i_nlink++;
+		cs->dentry = dentry;
+	}
+	dput(dentry);
+
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
+static struct cftype cft_cpu_exclusive = {
+	.name = "cpu_exclusive",
+	.private = FILE_CPU_EXCLUSIVE,
+};
+
+static struct cftype cft_mem_exclusive = {
+	.name = "mem_exclusive",
+	.private = FILE_MEM_EXCLUSIVE,
+};
+
+static struct cftype cft_notify_on_release = {
+	.name = "notify_on_release",
+	.private = FILE_NOTIFY_ON_RELEASE,
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
+	if ((err = cpuset_add_file(cs_dentry, &cft_cpu_exclusive)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_mem_exclusive)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
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
+	cs->flags = 0;
+	if (notify_on_release(parent))
+		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
+	cs->cpus_allowed = parent->cpus_allowed;
+	cs->mems_allowed = parent->mems_allowed;
+	atomic_set(&cs->count, 0);
+	INIT_LIST_HEAD(&cs->sibling);
+	INIT_LIST_HEAD(&cs->children);
+
+	cs->parent = parent;
+
+	list_add(&cs->sibling, &cs->parent->children);
+
+	err = cpuset_create_dir(cs, name, mode);
+	if (err < 0)
+		goto err;
+	err = cpuset_populate_dir(cs->dentry);
+	/* If err < 0, we have a half-filled directory - oh well ;) */
+	up(&cpuset_sem);
+	return 0;
+err:
+	list_del(&cs->sibling);
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
+	if (!list_empty(&cs->children)) {
+		up(&cpuset_sem);
+		return -EBUSY;
+	}
+	spin_lock(&cs->dentry->d_lock);
+	parent = cs->parent;
+	set_bit(CS_REMOVED, &cs->flags);
+	list_del(&cs->sibling);	/* delete my sibling from parent->children */
+	if (list_empty(&parent->children))
+		check_for_release(parent);
+	d = dget(cs->dentry);
+	cs->dentry = NULL;
+	spin_unlock(&d->d_lock);
+	cpuset_d_remove_dir(d);
+	dput(d);
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
+	struct dentry *root;
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
+	root = cpuset_mount->mnt_sb->s_root;
+	root->d_fsdata = &top_cpuset;
+	root->d_inode->i_nlink++;
+	top_cpuset.dentry = root;
+	root->d_inode->i_op = &cpuset_dir_inode_operations;
+	err = cpuset_populate_dir(root);
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
+	atomic_inc(&tsk->cpuset->count);
+}
+
+/**
+ * cpuset_exit - detach cpuset from exiting task
+ * @tsk: pointer to task_struct of exiting process
+ *
+ * Description: Detach cpuset from @tsk and release it.
+ *
+ **/
+
+void cpuset_exit(struct task_struct *tsk)
+{
+	struct cpuset *cs;
+
+	task_lock(tsk);
+	cs = tsk->cpuset;
+	tsk->cpuset = NULL;
+	task_unlock(tsk);
+
+	if (atomic_dec_and_test(&cs->count)) {
+		down(&cpuset_sem);	
+		check_for_release(cs);
+		up(&cpuset_sem);
+	}
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
+void cpuset_init_current_mems_allowed(void)
+{
+	current->mems_allowed = NODE_MASK_ALL;
+}
+
+void cpuset_update_current_mems_allowed()
+{
+	current->mems_allowed = cpuset_mems_allowed(current);
+}
+
+void cpuset_restrict_to_mems_allowed(unsigned long *nodes)
+{
+	bitmap_and(nodes, nodes, nodes_addr(current->mems_allowed),
+							MAX_NUMNODES);
+}
+
+/*
+ * Are any of the nodes on zonelist zl allowed in current->mems_allowed?
+ */
+int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl)
+{
+	int i;
+
+	for (i = 0; zl->zones[i]; i++) {
+		int nid = zl->zones[i]->zone_pgdat->node_id;
+
+		if (node_isset(nid, current->mems_allowed))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Is 'current' valid, and is zone z allowed in current->mems_allowed?
+ */
+int cpuset_zone_allowed(struct zone *z)
+{
+	return in_interrupt() ||
+		node_isset(z->zone_pgdat->node_id, current->mems_allowed);
+}
+
+/*
+ * proc_cpuset_show()
+ *  - Print tasks cpuset path into seq_file.
+ *  - Used for /proc/<pid>/cpuset.
+ */
+
+static int proc_cpuset_show(struct seq_file *m, void *v)
+{
+	struct cpuset *cs;
+	struct task_struct *tsk;
+	char *buf;
+	int retval = 0;
+
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	tsk = m->private;
+	down(&cpuset_sem);
+	task_lock(tsk);
+	cs = tsk->cpuset;
+	task_unlock(tsk);
+	if (!cs) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = cpuset_path(cs, buf, PAGE_SIZE);
+	if (retval < 0)
+		goto out;
+	seq_puts(m, buf);
+	seq_putc(m, '\n');
+out:
+	up(&cpuset_sem);
+	kfree(buf);
+	return retval;
+}
+
+static int cpuset_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *tsk = PROC_I(inode)->task;
+	return single_open(file, proc_cpuset_show, tsk);
+}
+
+struct file_operations proc_cpuset_operations = {
+	.open		= cpuset_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+EXPORT_SYMBOL(proc_cpuset_operations);
Index: 2.6.8-rc2-mm2/kernel/exit.c
===================================================================
--- 2.6.8-rc2-mm2.orig/kernel/exit.c	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/kernel/exit.c	2004-08-04 21:44:49.000000000 -0700
@@ -29,6 +29,7 @@
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
+#include <linux/cpuset.h>
 
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
@@ -829,6 +830,7 @@ asmlinkage NORET_TYPE void do_exit(long 
 	__exit_fs(tsk);
 	exit_namespace(tsk);
 	exit_thread();
+	cpuset_exit(tsk);
 
 	if (tsk->signal->leader)
 		disassociate_ctty(1);
Index: 2.6.8-rc2-mm2/kernel/fork.c
===================================================================
--- 2.6.8-rc2-mm2.orig/kernel/fork.c	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/kernel/fork.c	2004-08-04 21:44:49.000000000 -0700
@@ -38,6 +38,7 @@
 #include <linux/audit.h>
 #include <linux/rmap.h>
 #include <linux/pagg.h>
+#include <linux/cpuset.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1106,6 +1107,8 @@ struct task_struct *copy_process(unsigne
 	if (p->ptrace & PT_PTRACED)
 		__ptrace_link(p, current->parent);
 
+	cpuset_fork(p);
+
 	attach_pid(p, PIDTYPE_PID, p->pid);
 	if (thread_group_leader(p)) {
 		attach_pid(p, PIDTYPE_TGID, p->tgid);
Index: 2.6.8-rc2-mm2/kernel/sched.c
===================================================================
--- 2.6.8-rc2-mm2.orig/kernel/sched.c	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/kernel/sched.c	2004-08-04 21:44:49.000000000 -0700
@@ -43,6 +43,7 @@
 #include <linux/percpu.h>
 #include <linux/perfctr.h>
 #include <linux/kthread.h>
+#include <linux/cpuset.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -2537,7 +2538,7 @@ out_unlock:
 asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long __user *user_mask_ptr)
 {
-	cpumask_t new_mask;
+	cpumask_t new_mask, cpus_allowed;
 	int retval;
 	task_t *p;
 
@@ -2570,6 +2571,8 @@ asmlinkage long sys_sched_setaffinity(pi
 			!capable(CAP_SYS_NICE))
 		goto out_unlock;
 
+	cpus_allowed = cpuset_cpus_allowed(p);
+	cpus_and(new_mask, new_mask, cpus_allowed);
 	retval = set_cpus_allowed(p, new_mask);
 
 out_unlock:
@@ -3138,7 +3141,9 @@ static void migrate_all_tasks(int src_cp
 		if (dest_cpu == NR_CPUS)
 			dest_cpu = any_online_cpu(tsk->cpus_allowed);
 		if (dest_cpu == NR_CPUS) {
-			cpus_setall(tsk->cpus_allowed);
+			tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+			if (!cpus_intersects(tsk->cpus_allowed, cpu_online_map))
+				cpus_setall(tsk->cpus_allowed);
 			dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 			/* Don't tell them about moving exiting tasks
Index: 2.6.8-rc2-mm2/mm/mempolicy.c
===================================================================
--- 2.6.8-rc2-mm2.orig/mm/mempolicy.c	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/mm/mempolicy.c	2004-08-04 21:44:49.000000000 -0700
@@ -67,6 +67,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/nodemask.h>
+#include <linux/cpuset.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -164,6 +165,10 @@ static int get_nodes(unsigned long *node
 	if (copy_from_user(nodes, nmask, nlongs*sizeof(unsigned long)))
 		return -EFAULT;
 	nodes[nlongs-1] &= endmask;
+	/* Update current mems_allowed */
+	cpuset_update_current_mems_allowed();
+	/* Ignore nodes not set in current->mems_allowed */
+	cpuset_restrict_to_mems_allowed(nodes);
 	return mpol_check_policy(mode, nodes);
 }
 
@@ -574,8 +579,10 @@ static struct zonelist *zonelist_policy(
 		break;
 	case MPOL_BIND:
 		/* Lower zones don't get a policy applied */
+		/* Careful: current->mems_allowed might have moved */
 		if (gfp >= policy_zone)
-			return policy->v.zonelist;
+			if (cpuset_zonelist_valid_mems_allowed(policy->v.zonelist))
+				return policy->v.zonelist;
 		/*FALL THROUGH*/
 	case MPOL_INTERLEAVE: /* should not happen */
 	case MPOL_DEFAULT:
Index: 2.6.8-rc2-mm2/mm/page_alloc.c
===================================================================
--- 2.6.8-rc2-mm2.orig/mm/page_alloc.c	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/mm/page_alloc.c	2004-08-04 21:44:49.000000000 -0700
@@ -31,6 +31,7 @@
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/nodemask.h>
 
 #include <asm/tlbflush.h>
@@ -626,6 +627,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *z = zones[i];
 
+		if (!cpuset_zone_allowed(z))
+			continue;
+
 		min = (1<<order) + z->protection[alloc_type];
 
 		/*
@@ -653,6 +657,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *z = zones[i];
 
+		if (!cpuset_zone_allowed(z))
+			continue;
+
 		min = (1<<order) + z->protection[alloc_type];
 
 		if (gfp_mask & __GFP_HIGH)
@@ -678,6 +685,9 @@ rebalance:
 		for (i = 0; zones[i] != NULL; i++) {
 			struct zone *z = zones[i];
 
+			if (!cpuset_zone_allowed(z))
+				continue;
+
 			page = buffered_rmqueue(z, order, gfp_mask);
 			if (page) {
 				zone_statistics(zonelist, z);
@@ -704,6 +714,9 @@ rebalance:
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *z = zones[i];
 
+		if (!cpuset_zone_allowed(z))
+			continue;
+
 		min = (1UL << order) + z->protection[alloc_type];
 
 		if (z->free_pages >= min ||
@@ -1315,6 +1328,7 @@ void __init build_all_zonelists(void)
 	for(i = 0 ; i < numnodes ; i++)
 		build_zonelists(NODE_DATA(i));
 	printk("Built %i zonelists\n", numnodes);
+	cpuset_init_current_mems_allowed();
 }
 
 /*
Index: 2.6.8-rc2-mm2/mm/vmscan.c
===================================================================
--- 2.6.8-rc2-mm2.orig/mm/vmscan.c	2004-08-04 21:44:05.000000000 -0700
+++ 2.6.8-rc2-mm2/mm/vmscan.c	2004-08-04 21:44:49.000000000 -0700
@@ -31,6 +31,7 @@
 #include <linux/rmap.h>
 #include <linux/topology.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 
@@ -874,6 +875,9 @@ shrink_caches(struct zone **zones, struc
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
+		if (!cpuset_zone_allowed(zone))
+			continue;
+
 		zone->temp_priority = sc->priority;
 		if (zone->prev_priority > sc->priority)
 			zone->prev_priority = sc->priority;
@@ -917,6 +921,9 @@ int try_to_free_pages(struct zone **zone
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
+		if (!cpuset_zone_allowed(zone))
+			continue;
+
 		zone->temp_priority = DEF_PRIORITY;
 		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
@@ -958,8 +965,14 @@ int try_to_free_pages(struct zone **zone
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
 		out_of_memory(gfp_mask);
 out:
-	for (i = 0; zones[i] != 0; i++)
-		zones[i]->prev_priority = zones[i]->temp_priority;
+	for (i = 0; zones[i] != 0; i++) {
+		struct zone *zone = zones[i];
+
+		if (!cpuset_zone_allowed(zone))
+			continue;
+
+		zone->prev_priority = zone->temp_priority;
+	}
 	return ret;
 }
 
@@ -1167,6 +1180,8 @@ void wakeup_kswapd(struct zone *zone)
 {
 	if (zone->free_pages > zone->pages_low)
 		return;
+	if (!cpuset_zone_allowed(zone))
+		return;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;
 	wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
