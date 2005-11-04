Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbVKDFbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbVKDFbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbVKDFbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:31:47 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:31669 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161069AbVKDFbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:31:46 -0500
Date: Thu, 3 Nov 2005 21:31:32 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051104053132.549.16062.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 3/5] cpuset: change marker for relative numbering
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a minimal mechanism to support the safe
cpuset-relative management of CPU and Memory placement from
user library code, in the face of possible external migration
to different CPU's and Memory Nodes.

The interface presented to user space for cpusets uses system wide
numbering of CPUs and Memory Nodes.   It is the responsibility of
user level code, presumably in a library, to present cpuset-relative
numbering to applications when that would be more useful to them.

However if a task is moved to a different cpuset, or if the 'cpus'
or 'mems' of a cpuset are changed, then we need a way for such
library code to detect that its cpuset-relative numbering has
changed, when expressed using system wide numbering.

The kernel cannot safely allow user code to lock kernel resources.
The kernel could deliver out-of-band notice of cpuset changes by
such mechanisms as signals or usermodehelper callbacks, however
this can't be delivered to library code linked in applications
without intruding on the IPC mechanisms available to the app.
The kernel could require user level code to do all the work,
tracking the cpuset state before and during changes, to verify no
unexpected change occurred, but this becomes an onerous task.

The "marker_pid" cpuset field provides a simple way to make this
task less onerous on user library code.  The code writes its pid
to a cpusets "marker_pid" at the start of a sequence of queries
and updates, and check as it goes that the cpsuets marker_pid
doesn't change.  The pread(2) system call does a seek and read in
a single call.  If the marker_pid changes, the library code should
retry the required sequence of operations.

Anytime that a task modifies the "cpus" or "mems" of a cpuset,
unless it's pid is in the cpusets marker_pid field, the kernel
zeros this field.

The above was inspired by the load linked and store conditional
(ll/sc) instructions in the MIPS II instruction set.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+)

--- 2.6.14-rc5-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-11-02 23:16:21.532227825 -0800
+++ 2.6.14-rc5-mm1-cpuset-patches/kernel/cpuset.c	2005-11-02 23:17:07.102068196 -0800
@@ -60,6 +60,7 @@ struct cpuset {
 	unsigned long flags;		/* "unsigned long" so bitops work */
 	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
 	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
+	pid_t marker_pid;		/* pid of task doing marked updates */
 
 	/*
 	 * Count is atomic so can incr (fork) or decr (exit) without a lock.
@@ -130,10 +131,49 @@ static inline int notify_on_release(cons
  */
 static atomic_t cpuset_mems_generation = ATOMIC_INIT(1);
 
+/*
+ * marker_pid -- managing cpuset changes safely from user space.
+ *
+ * The interface presented to user space for cpusets uses system wide
+ * numbering of CPUs and Memory Nodes.   It is the responsibility of
+ * user level code, presumably in a library, to present cpuset-relative
+ * numbering to applications when that would be more useful to them.
+ *
+ * However if a task is moved to a different cpuset, or if the 'cpus'
+ * or 'mems' of a cpuset are changed, then we need a way for such
+ * library code to detect that its cpuset-relative numbering has
+ * changed, when expressed using system wide numbering.
+ *
+ * The kernel cannot safely allow user code to lock kernel resources.
+ * The kernel could deliver out-of-band notice of cpuset changes by
+ * such mechanisms as signals or usermodehelper callbacks, however
+ * this can't be delivered to library code linked in applications
+ * without intruding on the IPC mechanisms available to the app.
+ * The kernel could require user level code to do all the work,
+ * tracking the cpuset state before and during changes, to verify no
+ * unexpected change occurred, but this becomes an onerous task.
+ *
+ * The "marker_pid" cpuset field provides a simple way to make this
+ * task less onerous on user library code.  A task writes its pid
+ * to a cpusets "marker_pid" at the start of a sequence of queries
+ * and updates, and check as it goes that the cpsuets marker_pid
+ * doesn't change.  The pread(2) system call does a seek and read in
+ * a single call.  If the marker_pid changes, the user code should
+ * retry the required sequence of operations.
+ *
+ * Anytime that a task modifies the "cpus" or "mems" of a cpuset,
+ * unless it's pid is in the cpusets marker_pid field, the kernel
+ * zeros this field.
+ *
+ * The above was inspired by the load linked and store conditional
+ * (ll/sc) instructions in the MIPS II instruction set.
+ */
+
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
 	.cpus_allowed = CPU_MASK_ALL,
 	.mems_allowed = NODE_MASK_ALL,
+	.marker_pid = 0,
 	.count = ATOMIC_INIT(0),
 	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
 	.children = LIST_HEAD_INIT(top_cpuset.children),
@@ -793,6 +833,19 @@ static int update_nodemask(struct cpuset
 }
 
 /*
+ * Call with manage_sem held.
+ */
+
+static int update_marker_pid(struct cpuset *cs, char *buf)
+{
+	if (simple_strtoul(buf, NULL, 10) != 0)
+		cs->marker_pid = current->pid;
+	else
+		cs->marker_pid = 0;
+	return 0;
+}
+
+/*
  * update_flag - read a 0 or a 1 in a file and update associated flag
  * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
  *						CS_NOTIFY_ON_RELEASE)
@@ -910,6 +963,7 @@ typedef enum {
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
 	FILE_NOTIFY_ON_RELEASE,
+	FILE_MARKER_PID,
 	FILE_TASKLIST,
 } cpuset_filetype_t;
 
@@ -922,6 +976,7 @@ static ssize_t cpuset_common_file_write(
 	char *buffer;
 	char *pathbuf = NULL;
 	int retval = 0;
+	int marked_change;
 
 	/* Crude upper limit on largest legitimate cpulist user might write. */
 	if (nbytes > 100 + 6 * NR_CPUS)
@@ -944,12 +999,15 @@ static ssize_t cpuset_common_file_write(
 		goto out2;
 	}
 
+	marked_change = 0;
 	switch (type) {
 	case FILE_CPULIST:
 		retval = update_cpumask(cs, buffer);
+		marked_change = 1;
 		break;
 	case FILE_MEMLIST:
 		retval = update_nodemask(cs, buffer);
+		marked_change = 1;
 		break;
 	case FILE_CPU_EXCLUSIVE:
 		retval = update_flag(CS_CPU_EXCLUSIVE, cs, buffer);
@@ -960,6 +1018,9 @@ static ssize_t cpuset_common_file_write(
 	case FILE_NOTIFY_ON_RELEASE:
 		retval = update_flag(CS_NOTIFY_ON_RELEASE, cs, buffer);
 		break;
+	case FILE_MARKER_PID:
+		retval = update_marker_pid(cs, buffer);
+		break;
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
@@ -968,6 +1029,9 @@ static ssize_t cpuset_common_file_write(
 		goto out2;
 	}
 
+	if (marked_change && retval == 0 && cs->marker_pid != current->pid)
+		cs->marker_pid = 0;
+
 	if (retval == 0)
 		retval = nbytes;
 out2:
@@ -1060,6 +1124,9 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_NOTIFY_ON_RELEASE:
 		*s++ = notify_on_release(cs) ? '1' : '0';
 		break;
+	case FILE_MARKER_PID:
+		s += sprintf(s, "%d", cs->marker_pid);
+		break;
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1408,6 +1475,11 @@ static struct cftype cft_notify_on_relea
 	.private = FILE_NOTIFY_ON_RELEASE,
 };
 
+static struct cftype cft_marker_pid = {
+	.name = "marker_pid",
+	.private = FILE_MARKER_PID,
+};
+
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1422,6 +1494,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_marker_pid)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
 	return 0;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
