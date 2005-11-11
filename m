Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVKKEkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVKKEkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 23:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVKKEkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 23:40:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:12507 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932341AbVKKEko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 23:40:44 -0500
Date: Thu, 10 Nov 2005 20:40:30 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Simon Derr <Simon.Derr@bull.net>, Magnus Damm <magnus@valinux.co.jp>,
       Paul Jackson <pj@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051111044030.6597.3550.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset document additional features
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document the additional cpuset features:
	notify_on_release
	marker_pid
	memory_pressure
	memory_pressure_enabled

Rearrange and improve formatting of existing documentation
for cpu_exclusive and mem_exclusive features.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 Documentation/cpusets.txt |  178 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 153 insertions(+), 25 deletions(-)

--- 2.6.14-mm1.orig/Documentation/cpusets.txt	2005-11-08 17:14:58.319147165 -0800
+++ 2.6.14-mm1/Documentation/cpusets.txt	2005-11-10 20:39:03.558409741 -0800
@@ -14,7 +14,11 @@ CONTENTS:
   1.1 What are cpusets ?
   1.2 Why are cpusets needed ?
   1.3 How are cpusets implemented ?
-  1.4 How do I use cpusets ?
+  1.4 What are exclusive cpusets ?
+  1.5 What does notify_on_release do ?
+  1.6 What is a marker_pid ?
+  1.7 What is memory_pressure ?
+  1.8 How do I use cpusets ?
 2. Usage Examples and Syntax
   2.1 Basic Usage
   2.2 Adding/removing cpus
@@ -49,29 +53,6 @@ its cpus_allowed vector, and the kernel 
 allocate a page on a node that is not allowed in the requesting tasks
 mems_allowed vector.
 
-If a cpuset is cpu or mem exclusive, no other cpuset, other than a direct
-ancestor or descendent, may share any of the same CPUs or Memory Nodes.
-A cpuset that is cpu exclusive has a sched domain associated with it.
-The sched domain consists of all cpus in the current cpuset that are not
-part of any exclusive child cpusets.
-This ensures that the scheduler load balacing code only balances
-against the cpus that are in the sched domain as defined above and not
-all of the cpus in the system. This removes any overhead due to
-load balancing code trying to pull tasks outside of the cpu exclusive
-cpuset only to be prevented by the tasks' cpus_allowed mask.
-
-A cpuset that is mem_exclusive restricts kernel allocations for
-page, buffer and other data commonly shared by the kernel across
-multiple users.  All cpusets, whether mem_exclusive or not, restrict
-allocations of memory for user space.  This enables configuring a
-system so that several independent jobs can share common kernel
-data, such as file system pages, while isolating each jobs user
-allocation in its own cpuset.  To do this, construct a large
-mem_exclusive cpuset to hold all the jobs, and construct child,
-non-mem_exclusive cpusets for each individual job.  Only a small
-amount of typical kernel memory, such as requests from interrupt
-handlers, is allowed to be taken outside even a mem_exclusive cpuset.
-
 User level code may create and destroy cpusets by name in the cpuset
 virtual file system, manage the attributes and permissions of these
 cpusets and which CPUs and Memory Nodes are assigned to each cpuset,
@@ -196,6 +177,12 @@ containing the following files describin
  - cpu_exclusive flag: is cpu placement exclusive?
  - mem_exclusive flag: is memory placement exclusive?
  - tasks: list of tasks (by pid) attached to that cpuset
+ - notify_on_release flag: run /sbin/cpuset_release_agent on exit?
+ - marker_pid: pid of user task in co-ordinated operation sequence
+ - memory_pressure: measure of how much paging pressure in cpuset
+
+In addition, the root cpuset only has the following file:
+ - memory_pressure_enabled flag: compute memory_pressure?
 
 New cpusets are created using the mkdir system call or shell
 command.  The properties of a cpuset, such as its flags, allowed
@@ -229,7 +216,148 @@ exclusive cpuset.  Also, the use of a Li
 to represent the cpuset hierarchy provides for a familiar permission
 and name space for cpusets, with a minimum of additional kernel code.
 
-1.4 How do I use cpusets ?
+
+1.4 What are exclusive cpusets ?
+--------------------------------
+
+If a cpuset is cpu or mem exclusive, no other cpuset, other than
+a direct ancestor or descendent, may share any of the same CPUs or
+Memory Nodes.
+
+A cpuset that is cpu_exclusive has a scheduler (sched) domain
+associated with it.  The sched domain consists of all CPUs in the
+current cpuset that are not part of any exclusive child cpusets.
+This ensures that the scheduler load balancing code only balances
+against the CPUs that are in the sched domain as defined above and
+not all of the CPUs in the system. This removes any overhead due to
+load balancing code trying to pull tasks outside of the cpu_exclusive
+cpuset only to be prevented by the tasks' cpus_allowed mask.
+
+A cpuset that is mem_exclusive restricts kernel allocations for
+page, buffer and other data commonly shared by the kernel across
+multiple users.  All cpusets, whether mem_exclusive or not, restrict
+allocations of memory for user space.  This enables configuring a
+system so that several independent jobs can share common kernel data,
+such as file system pages, while isolating each jobs user allocation in
+its own cpuset.  To do this, construct a large mem_exclusive cpuset to
+hold all the jobs, and construct child, non-mem_exclusive cpusets for
+each individual job.  Only a small amount of typical kernel memory,
+such as requests from interrupt handlers, is allowed to be taken
+outside even a mem_exclusive cpuset.
+
+
+1.5 What does notify_on_release do ?
+------------------------------------
+
+If the notify_on_release flag is enabled (1) in a cpuset, then whenever
+the last task in the cpuset leaves (exits or attaches to some other
+cpuset) and the last child cpuset of that cpuset is removed, then
+the kernel runs the command /sbin/cpuset_release_agent, supplying the
+pathname (relative to the mount point of the cpuset file system) of the
+abandoned cpuset.  This enables automatic removal of abandoned cpusets.
+The default value of notify_on_release in the root cpuset at system
+boot is disabled (0).  The default value of other cpusets at creation
+is the current value of their parents notify_on_release setting.
+
+
+1.6 What is a marker_pid ?
+--------------------------
+
+The marker_pid helps manage cpuset changes safely from user space.
+
+The interface presented to user space for cpusets uses system wide
+numbering of CPUs and Memory Nodes.   It is the responsibility of
+user level code, presumably in a library, to present cpuset-relative
+numbering to applications when that would be more useful to them.
+
+However if a task is moved to a different cpuset, or if the 'cpus' or
+'mems' of a cpuset are changed, then we need a way for such library
+code to detect that its cpuset-relative numbering has changed, when
+expressed using system wide numbering.
+
+The kernel cannot safely allow user code to lock kernel resources.
+The kernel could deliver out-of-band notice of cpuset changes by
+such mechanisms as signals or usermodehelper callbacks, however
+this can't be synchronously delivered to library code linked in
+applications without intruding on the IPC mechanisms available to
+the app.  The kernel could require user level code to do all the work,
+tracking the cpuset state before and during changes, to verify no
+unexpected change occurred, but this becomes an onerous task.
+
+The "marker_pid" cpuset field provides a simple way to make this task
+less onerous on user library code.  A task writes its pid to a cpusets
+"marker_pid" at the start of a sequence of queries and updates,
+and check as it goes that the cpusets marker_pid doesn't change.
+The pread(2) system call does a seek and read in a single call.
+If the marker_pid changes, the user code should retry the required
+sequence of operations.
+
+Anytime that a task modifies the "cpus" or "mems" of a cpuset,
+unless it's pid is in the cpusets marker_pid field, the kernel zeros
+this field.
+
+The above was inspired by the load linked and store conditional
+(ll/sc) instructions in the MIPS II instruction set.
+
+
+1.7 What is memory_pressure ?
+-----------------------------
+The memory_pressure of a cpuset provides a simple per-cpuset metric
+of the rate that the tasks in a cpuset are attempting to free up in
+use memory on the nodes of the cpuset to satisfy additional memory
+requests.
+
+This enables batch managers monitoring jobs running in dedicated
+cpusets to efficiently detect what level of memory pressure that job
+is causing.
+
+This is useful both on tightly managed systems running a wide mix of
+submitted jobs, which may choose to terminate or re-prioritize jobs that
+are trying to use more memory than allowed on the nodes assigned them,
+and with tightly coupled, long running, massively parallel scientific
+computing jobs that will dramatically fail to meet required performance
+goals if they start to use more memory than allowed to them.
+
+This mechanism provides a very economical way for the batch manager
+to monitor a cpuset for signs of memory pressure.  It's up to the
+batch manager or other user code to decide what to do about it and
+take action.
+
+==> Unless this feature is enabled by writing "1" to the special file
+    /dev/cpuset/memory_pressure_enabled, the hook in the rebalance
+    code of __alloc_pages() for this metric reduces to simply noticing
+    that the cpuset_memory_pressure_enabled flag is zero.  So only
+    systems that enable this feature will compute the metric.
+
+Why a per-cpuset, running average:
+
+    Because this meter is per-cpuset, rather than per-task or mm,
+    the system load imposed by a batch scheduler monitoring this
+    metric is sharply reduced on large systems, because a scan of
+    the tasklist can be avoided on each set of queries.
+
+    Because this meter is a running average, instead of an accumulating
+    counter, a batch scheduler can detect memory pressure with a
+    single read, instead of having to read and accumulate results
+    for a period of time.
+
+    Because this meter is per-cpuset rather than per-task or mm,
+    the batch scheduler can obtain the key information, memory
+    pressure in a cpuset, with a single read, rather than having to
+    query and accumulate results over all the (dynamically changing)
+    set of tasks in the cpuset.
+
+A per-cpuset simple digital filter (requires a spinlock and 3 words
+of data per-cpuset) is kept, and updated by any task attached to that
+cpuset, if it enters the synchronous (direct) page reclaim code.
+
+A per-cpuset file provides an integer number representing the recent
+(half-life of 10 seconds) rate of direct page reclaims caused by
+the tasks in the cpuset, in units of reclaims attempted per second,
+times 1000.
+
+
+1.8 How do I use cpusets ?
 --------------------------
 
 In order to minimize the impact of cpusets on critical kernel

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
