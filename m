Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265725AbUF2LdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbUF2LdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUF2LdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:33:21 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:43975 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265725AbUF2LXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:23:44 -0400
Date: Tue, 29 Jun 2004 04:22:01 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Paul Jackson <pj@sgi.com>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Sylvain <sylvain.jeaugey@bull.net>,
       Simon <Simon.Derr@bull.net>
Message-Id: <20040629112201.24730.3832.92082@sam.engr.sgi.com>
In-Reply-To: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
References: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
Subject: [patch 2/8] cpusets v3 - Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
the system, especially when running large applications with demanding
performance characteristics.

These subsets, or "soft partitions" must be able to be dynamically
adjusted, as the job mix changes, without impacting other concurrently
executing jobs.

                              Cpusets

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

In addition a new filesystem, of type "cpuset" may be mounted,
typically at /dev/cpuset, to enable browsing and modifying the cpusets
presently known to the kernel.  No new system calls are added for
cpusets - all support for querying and modifying cpusets is via
this cpuset file system.

Each task under /proc has an added file, displaying the cpuset
name, as the path relative to the root of the cpuset filesystem.

Each cpuset is represented by a directory in the cpuset file system
containing the following files describing that cpuset:

 - cpus: list of CPUs in that cpuset
 - mems: list of Memory Nodes in that cpuset
 - cpustrict flag: is cpuset strictly exclusive?
 - memstrict flag: is cpuset strictly exclusive?
 - autoclean flag: is cpuset to be automatically deleted when not used
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
may be reattached to any other cpuset, if allowed by the permissions
on the necessary cpuset file system directories.

Such management of a system "in the large" integrates smoothly with
the detailed placement done on individual tasks and memory regions
using the sched_setaffinity, mbind and set_mempolicy system calls.

The following rules apply to each cpuset:

 - Its CPUs and Memory Nodes must be a subset of its parents.
 - It can only be marked strictly exclusive (strict) if its parent is.

These rules, and the natural hierarchy of cpusets, enable efficient
enforcement of the strictly exclusive guarantee, without having to scan
all cpusets everytime any of them change to ensure nothing overlaps a
structly exclusive cpuset.

The use of a Linux virtual file system (vfs) to represent the cpuset
hierarchy provides for a familiar permission and name space for cpusets,
with a minimum of additional kernel code.

If a cpuset is marked autoclean, then when the last task attached to it
is detached or exits, that cpuset is automatically removed.

For example, the following sequence of commands will setup a cpuset
named "Charlie", containing just CPUs 2 and 3, and Memory Node 1,
and then move the current shell to that cpuset:

  mount -t cpuset none /dev/cpuset
  cd /dev/cpuset/top_cpuset
  mkdir Charlie
  cd Charlie
  /bin/echo 2-3 > cpus
  /bin/echo 1 > mems
  /bin/echo $$ > tasks

That's pretty much it - cpusets constrains the existing CPU and
Memory placement calls to only request resources within a tasks
current cpuset, and they form a nestable hierarchy visible in
a virtual file system.  These are the essential hooks, beyond
what is already present, required to manage dynamic job placement
on large systems.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
