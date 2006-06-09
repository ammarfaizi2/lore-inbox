Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWFIHlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWFIHlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 03:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWFIHlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 03:41:08 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:46504 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751398AbWFIHlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 03:41:06 -0400
Date: Fri, 09 Jun 2006 03:41:04 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
To: Jay Lan <jlan@sgi.com>, csturtiv@sgi.com, Balbir Singh <balbir@in.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44892610.6040001@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay, Chris, 
Could you check if this patch does the needful ? 

Its tested and runs fine for me. A quick response would 
be appreciated so that it can be included in -mm before 
the 2.6.18 merge window begins.

I decided against adding the configuration to the taskstats 
interface directly (as another command) since the sysfs solution
is much simpler and the configuration operation is infrequent.

Balbir, all, comments welcome.

--Shailabh


Selective sending of per-tgid statistics in taskstats interface

The taskstats interface currently sends both per-pid and per-tgid stats
whenever a thread exits and its thread group is non-empty. Some potential
users of taskstats, currently SGI's CSA, do not need the per-tgid stats.

Hence, this patch introduces a configuration parameter
	/sys/kernel/taskstats_tgid_exit
through which a privileged user can turn on/off sending of per-tgid stats on
task exit. The default is on. Regardless of the parameter, explicit commands
requesting per-tgid stats are always satisfied.

--

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>


 Documentation/accounting/taskstats.txt |   42 ++++++++++++++++++++++++---------
 include/linux/taskstats_kern.h         |   14 +++--------
 kernel/ksysfs.c                        |    9 +++++++
 kernel/taskstats.c                     |   26 ++++++++++++++++++++
 4 files changed, 70 insertions(+), 21 deletions(-)

Index: linux-2.6.17-rc5-mm3/include/linux/taskstats_kern.h
===================================================================
--- linux-2.6.17-rc5-mm3.orig/include/linux/taskstats_kern.h	2006-06-09 02:02:31.000000000 -0400
+++ linux-2.6.17-rc5-mm3/include/linux/taskstats_kern.h	2006-06-09 02:04:42.000000000 -0400
@@ -18,13 +18,6 @@ enum {
 #ifdef CONFIG_TASKSTATS
 extern kmem_cache_t *taskstats_cache;

-static inline void taskstats_exit_alloc(struct taskstats **ptidstats,
-					struct taskstats **ptgidstats)
-{
-	*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
-	*ptgidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
-}
-
 static inline void taskstats_exit_free(struct taskstats *tidstats,
 					struct taskstats *tgidstats)
 {
@@ -34,17 +27,18 @@ static inline void taskstats_exit_free(s
 		kmem_cache_free(taskstats_cache, tgidstats);
 }

+extern void taskstats_exit_alloc(struct taskstats **, struct taskstats **);
 extern void taskstats_exit_send(struct task_struct *, struct taskstats *,
 				struct taskstats *);
 extern void taskstats_init_early(void);

 #else
-static inline void taskstats_exit_alloc(struct taskstats **ptidstats,
-					struct taskstats **ptgidstats)
-{}
 static inline void taskstats_exit_free(struct taskstats *ptidstats,
 					struct taskstats *ptgidstats)
 {}
+static inline void taskstats_exit_alloc(struct taskstats **ptidstats,
+					struct taskstats **ptgidstats)
+{}
 static inline void taskstats_exit_send(struct task_struct *tsk,
 					struct taskstats *tidstats,
 					struct taskstats *tgidstats)
Index: linux-2.6.17-rc5-mm3/kernel/ksysfs.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/kernel/ksysfs.c	2006-06-09 02:02:31.000000000 -0400
+++ linux-2.6.17-rc5-mm3/kernel/ksysfs.c	2006-06-09 02:04:42.000000000 -0400
@@ -63,6 +63,12 @@ static ssize_t kexec_crash_loaded_show(s
 KERNEL_ATTR_RO(kexec_crash_loaded);
 #endif /* CONFIG_KEXEC */

+#ifdef CONFIG_TASKSTATS
+extern ssize_t taskstats_tgid_exit_show(struct subsystem *subsys, char *page);
+extern ssize_t taskstats_tgid_exit_store(struct subsystem *subsys, const char *page, size_t count);
+KERNEL_ATTR_RW(taskstats_tgid_exit);
+#endif
+
 decl_subsys(kernel, NULL, NULL);
 EXPORT_SYMBOL_GPL(kernel_subsys);

@@ -75,6 +81,9 @@ static struct attribute * kernel_attrs[]
 	&kexec_loaded_attr.attr,
 	&kexec_crash_loaded_attr.attr,
 #endif
+#ifdef CONFIG_TASKSTATS
+	&taskstats_tgid_exit_attr.attr,
+#endif
 	NULL
 };

Index: linux-2.6.17-rc5-mm3/kernel/taskstats.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/kernel/taskstats.c	2006-06-09 02:02:31.000000000 -0400
+++ linux-2.6.17-rc5-mm3/kernel/taskstats.c	2006-06-09 02:04:42.000000000 -0400
@@ -24,6 +24,7 @@

 static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
 static int family_registered = 0;
+static int tgid_exit_send = 1;   /* Should tgid stats be sent on exit */
 kmem_cache_t *taskstats_cache;
 static DEFINE_MUTEX(taskstats_exit_mutex);

@@ -229,6 +230,15 @@ err:
 	return rc;
 }

+void taskstats_exit_alloc(struct taskstats **ptidstats,
+					struct taskstats **ptgidstats)
+{
+	*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+	*ptgidstats = NULL;
+	if (tgid_exit_send)
+		*ptgidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+}
+
 /* Send pid data out on exit */
 void taskstats_exit_send(struct task_struct *tsk, struct taskstats *tidstats,
 			struct taskstats *tgidstats)
@@ -254,6 +264,7 @@ void taskstats_exit_send(struct task_str
 	size = nla_total_size(sizeof(u32)) +
 		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);

+	/* Allocation should not depend on tgid_exit_send value */
 	if (is_thread_group)
 		size = 2 * size;	/* PID + STATS + TGID + STATS */

@@ -271,6 +282,9 @@ void taskstats_exit_send(struct task_str
 			*tidstats);
 	nla_nest_end(rep_skb, na);

+	/* Do not check tgid_exit_send value here. If it was unset during
+	 * taskstats_exit_alloc(), tgidstats will be NULL
+	 */
 	if (!is_thread_group || !tgidstats) {
 		send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
 		goto ret;
@@ -345,3 +359,15 @@ err:
  * mechanisms precedes initialization of the taskstats interface
  */
 late_initcall(taskstats_init);
+
+/* configuration through sysfs */
+ssize_t taskstats_tgid_exit_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%d\n", tgid_exit_send);
+}
+ssize_t taskstats_tgid_exit_store(struct subsystem *subsys, const char *page, size_t count)
+{
+	char *p = (char *)page;
+	tgid_exit_send = simple_strtoul(p, &p, 10);
+	return count;
+}
Index: linux-2.6.17-rc5-mm3/Documentation/accounting/taskstats.txt
===================================================================
--- linux-2.6.17-rc5-mm3.orig/Documentation/accounting/taskstats.txt	2006-06-07 12:03:14.000000000 -0400
+++ linux-2.6.17-rc5-mm3/Documentation/accounting/taskstats.txt	2006-06-09 02:35:07.000000000 -0400
@@ -32,13 +32,28 @@ The response contains statistics for a t
 statistics for all tasks of the process (if tgid is specified).

 To obtain statistics for tasks which are exiting, userspace opens a multicast
-netlink socket. Each time a task exits, two records are sent by the kernel to
-each listener on the multicast socket. The first the per-pid task's statistics
-and the second is the sum for all tasks of the process to which the task
-belongs (the task does not need to be the thread group leader). The need for
-per-tgid stats to be sent for each exiting task is explained in the per-tgid
-stats section below.
+netlink socket. Each time a task exits, its per-pid statistics are sent by
+the kernel to each listener on the multicast socket.

+If
+a) the value of /sys/kernel/taskstats_tgid_exit is non-zero and
+b) the task's thread_group has other members
+then a second record is also sent, consisting of the sum for all tasks of the
+thread group to which the task belongs. The task does not need to be the thread
+group leader. The utility for per-tgid stats to be sent for each exiting task
+is explained in the per-tgid stats section below.
+
+# echo 0 > /sys/kernel/taskstats_tgid_exit
+turns off sending of per-tgid stats on task exit
+
+# echo 1 > /sys/kernel/taskstats_tgid_exit
+turns it back on (which is the default)
+
+Commands requesting per-tgid stats are not affected by this configuration
+parameter and are always satisified by the kernel. Also, when the last thread
+of a thread group, or a solitary thread exits, only the per-pid stats are sent
+since they are identical to the per-tgid stats at that point in time.
+
 getdelays.c is a simple utility demonstrating usage of the taskstats interface
 for reporting delay accounting statistics.

@@ -100,8 +115,8 @@ per-tgid stats

 Taskstats provides per-process stats, in addition to per-task stats, since
 resource management is often done at a process granularity and aggregating task
-stats in userspace alone is inefficient and potentially inaccurate (due to lack
-of atomicity).
+stats in userspace alone is inefficient and potentially inaccurate due to lack
+of atomicity.

 However, maintaining per-process, in addition to per-task stats, within the
 kernel has space and time overheads. Hence the taskstats implementation
@@ -115,9 +130,14 @@ statistic from the kernel.

 The approach taken by taskstats is to return the per-tgid stats *each* time
 a task exits, in addition to the per-pid stats for that task. Userspace can
-maintain task<->process mappings and use them to maintain the per-process stats
-in userspace, updating the aggregate appropriately as the tasks of a process
-exit.
+maintain task<->process mappings and use them to maintain the per-process
+stats, updating the aggregate appropriately as the tasks of a process
+exit. Userspace must also expect only per-pid stats to be sent when the last
+thread of a thread group exits (also when that is the only thread in the thread
+group, which is a common case).
+
+Installations that don't need per-tgid stats can disable their collection and
+sending on task exit as described in the Usage section.

 Extending taskstats
 -------------------

