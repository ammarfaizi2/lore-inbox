Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUGBKxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUGBKxr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 06:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUGBKxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 06:53:47 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:54477 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261951AbUGBKxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:53:07 -0400
Date: Fri, 2 Jul 2004 03:52:05 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Paul Jackson <pj@sgi.com>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Sylvain <sylvain.jeaugey@bull.net>,
       Simon <Simon.Derr@bull.net>, Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <20040702105208.15684.58986.94710@sam.engr.sgi.com>
In-Reply-To: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
References: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
Subject: [patch 2/8] cpusets v4 - Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

				CPUSETS
				-------

Copyright (C) 2004 BULL SA.
Written by Simon.Derr@bull.net

Portions Copyright (c) 2004 Silicon Graphics, Inc.
Modified by Paul Jackson <pj@sgi.com>

CONTENTS:
=========

1. Cpusets
  1.1 What are cpusets ?
  1.2 Why are cpusets needed ?
  1.3 How are cpusets implemented ?
  1.4 How do I use cpusets ?
2. Usage Examples and Syntax
  2.1 Basic Usage
  2.2 Adding/removing cpus
  2.3 Setting flags
  2.4 Attaching processes
3. Questions
4. Contact

1. Cpusets
==========

1.1 What are cpusets ?
----------------------

Cpusets provide a simple mechanism for assigning a set of CPUs and
Memory Nodes to a set of tasks.

Cpusets constrains the existing CPU and Memory placement calls to
only request resources within a tasks current cpuset, and they form a
nested hierarchy visible in a virtual file system.  These are the
essential hooks, beyond what is already present, required to manage
dynamic job placement on large systems.

Each task has a pointer to a cpuset.  Multiple tasks may reference
the same cpuset.  Requests by a task, using the sched_setaffinity(2)
system call to include CPUs in its CPU affinity mask, and using the
mbind(2) and set_mempolicy(2) system calls to include Memory Nodes
in its memory policy, are both filtered through that tasks cpuset,
filtering out any CPUs or Memory Nodes not in that cpuset.

If a cpuset is strictly exclusive, no other cpuset, other than a direct
ancestor or descendent, may share any of the same CPUs or Memory Nodes.

User level code may create and destroy cpusets by name in the cpuset
virtual file system, manage the attributes and permissions of these
cpusets and which CPUs and Memory Nodes are assigned to each cpuset,
specify and query to which cpuset a task is assigned, and list the
task pids assigned to a cpuset.


1.2 Why are cpusets needed ?
----------------------------

The management of large computer systems, with many processors (CPUs),
complex memory cache hierarchies and multiple Memory Nodes having
non-uniform access times (NUMA) presents additional challenges for
the efficient scheduling and memory placement of processes.

Frequently more modest sized systems can be operated with adequate
efficiency just by letting the operating system automatically share
the available CPU and Memory resources amongst the requesting tasks.

But larger systems, which benefit more from careful processor and
memory placement to reduce memory access times and contention,
and which typically represent a larger investment for the customer,
can benefit from explictly placing jobs on properly sized subsets of
the system.

This can be especially valuable on:

    * Web Servers running multiple instances of the same web application,
    * Servers running different applications (for instance, a web server
      and a database), or
    * NUMA systems running large HPC applications with demanding
      performance characteristics.

These subsets, or "soft partitions" must be able to be dynamically
adjusted, as the job mix changes, without impacting other concurrently
executing jobs.

The kernel cpuset patch provides the minimum essential kernel
mechanisms required to efficiently implement such subsets.  It
leverages existing CPU and Memory Placement facilities in the Linux
kernel to avoid any additional impact on the critical scheduler or
memory allocator code.


1.3 How are cpusets implemented ?
---------------------------------

Cpusets provide a Linux kernel (2.6.7 and above) mechanism to constrain
which CPUs and Memory Nodes are used by a process or set of processes.

The Linux kernel already has a pair of mechanisms to specify on which
CPUs a task may be scheduled (sched_setaffinity) and on which Memory
Nodes it may obtain memory (mbind, set_mempolicy).

Cpusets extends these two mechanisms as follows:

 - Cpusets are sets of allowed CPUs and Memory Nodes, known to the
   kernel.
 - Each task in the system is attached to a cpuset, via a pointer
   in the task structure to a reference counted cpuset structure.
 - Calls to sched_setaffinity are filtered to just those CPUs
   allowed in that tasks cpuset.
 - Calls to mbind and set_mempolicy are filtered to just
   those Memory Nodes allowed in that tasks cpuset.
 - The "top_cpuset" contains all the systems CPUs and Memory
   Nodes.
 - For any cpuset, one can define child cpusets containing a subset
   of the parents CPU and Memory Node resources.
 - The hierarchy of cpusets can be mounted at /dev/cpuset, for
   browsing and manipulation from user space.
 - A cpuset may be marked strictly exclusive, which ensures that
   no other cpuset (except direct ancestors and descendents) may
   contain any overlapping CPUs or Memory Nodes.
 - You can list all the tasks (by pid) attached to any cpuset.

The implementation of cpusets requires a few, simple hooks
into the rest of the kernel, none in performance critical paths:

 - in main/init.c, to initialize the top_cpuset at system boot.
 - in fork and exit, to attach and detach a task from its cpuset.
 - in sched_setaffinity, to mask the requested CPUs by what's
   allowed in that tasks cpuset.
 - in sched.c migrate_all_tasks(), to keep migrating tasks within
   the CPUs allowed by their cpuset, if possible.
 - in the mbind and set_mempolicy system calls, to mask the requested
   Memory Nodes by what's allowed in that tasks cpuset.

In addition a new file system, of type "cpuset" may be mounted,
typically at /dev/cpuset, to enable browsing and modifying the cpusets
presently known to the kernel.  No new system calls are added for
cpusets - all support for querying and modifying cpusets is via
this cpuset file system.

Each task under /proc has an added file named 'cpuset', displaying
the cpuset name, as the path relative to the root of the cpuset file
system.

Each cpuset is represented by a directory in the cpuset file system
containing the following files describing that cpuset:

 - cpus: list of CPUs in that cpuset
 - mems: list of Memory Nodes in that cpuset
 - cpustrict flag: is cpuset strictly exclusive?
 - memstrict flag: is cpuset strictly exclusive?
 - tasks: list of tasks (by pid) attached to that cpuset

New cpusets are created using the mkdir system call or shell
command.  The properties of a cpuset, such as its flags, allowed
CPUs and Memory Nodes, and attached tasks, are modified by writing
to the appropriate file in that cpusets directory, as listed above.

The named hierarchical structure of nested cpusets allows partitioning
a large system into nested, dynamically changeable, "soft-partitions".

The attachment of each task, automatically inherited at fork by any
children of that task, to a cpuset allows organizing the work load
on a system into related sets of tasks such that each set is constrained
to using the CPUs and Memory Nodes of a particular cpuset.  A task
may be re-attached to any other cpuset, if allowed by the permissions
on the necessary cpuset file system directories.

Such management of a system "in the large" integrates smoothly with
the detailed placement done on individual tasks and memory regions
using the sched_setaffinity, mbind and set_mempolicy system calls.

The following rules apply to each cpuset:

 - Its CPUs and Memory Nodes must be a subset of its parents.
 - It can only be marked strictly exclusive (strict) if its parent is.

These rules, and the natural hierarchy of cpusets, enable efficient
enforcement of the strictly exclusive guarantee, without having to scan
all cpusets every time any of them change to ensure nothing overlaps
a strictly exclusive cpuset. Also, the use of a Linux virtual file
system (vfs) to represent the cpuset hierarchy provides for a familiar
permission and name space for cpusets, with a minimum of additional
kernel code.


1.4 How do I use cpusets ?
--------------------------

Be warned that cpusets work differently than you might expect.

In order to avoid _any_ impact on existing critical scheduler and
memory allocator code in the kernel, and to leverage the existing
CPU and Memory placement facilities, putting a task in a particular
cpuset does _not_ immediately affect its placement.

It would have been possible (and initially cpusets were coded this
way) to immediately change a tasks cpus_allowed affinity mask based
on what cpuset it was placed in.  The sched_setaffinity call can be
applied to any requested task.

But the way numa placement support (added to 2.6 kernels in April
2004 by Andi Kleen) works, it is not possible for one task to change
another tasks Memory placement.  The mbind and set_mempolicy system
calls only affect the current task.  There really wasn't a choice
in this matter -- the mm's, vma's and zonelists that encode a tasks
Memory placement are complicated, and cannot be safely changed from
outside the current tasks context.

So, cpuset placement only affects the future sched_setaffinity,
mbind, and set_mempolicy system calls, by filtering out any CPUs
and Memory Nodes that are not allowed in the specified tasks cpuset.
Well, almost all.  See also the migrate_all_tasks() hook, listed above.

To start a new job that is to be contained within a cpuset, this means
the steps are:

 1) mkdir /dev/cpuset
 2) mount -t cpuset none /dev/cpuset
 3) Create the new cpuset by doing mkdir's and write's (or echo's) in
    the /dev/cpuset virtual file system.
 4) Start a task that will be the "founding father" of the new job.
 5) Attach that task to the new cpuset by writing its pid to the
    /dev/cpuset tasks file for that cpuset.
 6) Have that task issue sched_setaffinity, mbind and set_mempolicy
    system calls, specifying CPUs and Memory Nodes within its cpuset.
    Anything it specifies outside will be ignored without complaint,
    so if you request all CPUs and Memory Nodes in the system, you will
    successfully get all that are available in your current cpuset.
 7) fork, exec or clone the job tasks from this founding father task.

For example, the following sequence of commands will setup a cpuset
named "Charlie", containing just CPUs 2 and 3, and Memory Node 1,
and then start a subshell 'sh' in that cpuset:

  mount -t cpuset none /dev/cpuset
  cd /dev/cpuset/top_cpuset
  mkdir Charlie
  cd Charlie
  /bin/echo 2-3 > cpus
  /bin/echo 1 > mems
  /bin/echo $$ > tasks
  # 0xC is bitmask for CPUs 2-3
  taskset 0xC numactl -m 1 sh
  # The subshell 'sh' is now running in cpuset Charlie
  # The next line should display 'top_cpuset/Charlie'
  cat /proc/self/cpuset

In the case that we want to force an existing job into a particular
cpuset, or that we want to move the cpuset that a job is using,
we will need some additional library code, not yet available as of
this writing (July 2004), that will receive a particular signal,
and reissue the necessary sched_setaffinity, mbind and set_mempolicy
system calls from with the tasks current context.

In the case that a change of cpuset includes wanting to move already
allocated memory pages, consider further the work of IWAMOTO
Toshihiro <iwamoto@valinux.co.jp> for page remapping and memory
hotremoval, which can be found at:

  http://people.valinux.co.jp/~iwamoto/mh.html

The integration of cpusets with such memory migration is not yet
available.

In the future, a C library interface to cpusets will likely be
available.  For now, the only way to query or modify cpusets is
via the cpuset file system, using the various cd, mkdir, echo, cat,
rmdir commands from the shell, or their equivalent from C.

The sched_setaffinity calls can also be done at the shell prompt using
SGI's runon or Robert Love's taskset.  The mbind and set_mempolicy
calls can be done at the shell prompt using the numactl command
(part of Andi's numa package).

2. Usage Examples and Syntax
============================

2.1 Basic Usage
---------------

Creating, modifying, using the cpusets can be done through the cpuset
virtual filesystem.

To mount it, type:
# mount -t cpuset none /dev/cpuset

Then under /dev/cpuset you can find a tree that corresponds to the
tree of the cpusets in the system. For instance, /dev/cpuset/top_cpuset
is the cpuset that holds the whole system.

If you want to create a new cpuset under top_cpuset:
# cd /dev/cpuset/top_cpuset
# mkdir my_cpuset

Now you want to do something with this cpuset.
# cd my_cpuset

In this directory you can find several files:
# ls
cpus  cpustrict  mems  memstrict  tasks

Reading them will give you information about the state of this cpuset:
the CPUs and Memory Nodes it can use, the processes that are using
it, its properties.  By writing to these files you can manipulate
the cpuset.

Set some flags:
# /bin/echo 1 > cpustrict

Add some cpus:
# /bin/echo 0-7 > cpus

Now attach your shell to this cpuset:
# /bin/echo $$ > tasks

You can also create cpusets inside your cpuset by using mkdir in this
directory.
# mkdir my_sub_cs

To remove a cpuset, just use rmdir:
# rmdir my_sub_cs
This will fail if the cpuset is in use (has cpusets inside, or has
processes attached).

2.2 Adding/removing cpus
------------------------

This is the syntax to use when writing in the cpus or mems files
in cpuset directories:

# /bin/echo 1-4 > cpus		-> set cpus list to cpus 1,2,3,4
# /bin/echo 1,2,3,4 > cpus	-> set cpus list to cpus 1,2,3,4
# /bin/echo +1 > cpus		-> add cpu 1 to the cpus list
# /bin/echo -1-4 > cpus		-> remove cpus 1,2,3,4 from the cpus list
# /bin/echo -1,2,3,4 > cpus	-> remove cpus 1,2,3,4 from the cpus list

All these can be mixed together:
# /bin/echo 1-7 -6 +9,10	-> set cpus list to 1,2,3,4,5,7,9,10

2.3 Setting flags
-----------------

The syntax is very simple:

# /bin/echo 1 > cpustrict 	-> set flag 'cpustrict'
# /bin/echo 0 > cpustrict 	-> unset flag 'cpustrict'

2.4 Attaching processes
-----------------------

# /bin/echo PID > tasks

Note that it is PID, not PIDs. You can only attach ONE task at a time.
If you have several tasks to attach, you have to do it one after another:

# /bin/echo PID1 > tasks
# /bin/echo PID2 > tasks
	...
# /bin/echo PIDn > tasks


3. Questions
============

Q: what's up with this '/bin/echo' ?
A: bash's builtin 'echo' command does not check calls to write() against
   errors. If you use it in the cpuset file system, you won't be
   able to tell whether a command succeeded or failed.

Q: When I attach processes, only the first of the line gets really attached !
A: We can only return one error code per call to write(). So you should also
   put only ONE pid.

4. Contact
==========

Web: http://www.bullopensource.org/cpuset

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
