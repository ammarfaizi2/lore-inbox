Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWEDSnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWEDSnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 14:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWEDSnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 14:43:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1465 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751509AbWEDSns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 14:43:48 -0400
Date: Fri, 5 May 2006 00:10:11 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, jlan@engr.sgi.com, akpm@osdl.org
Subject: [updated] [Patch 5/8] taskstats interface
Message-ID: <20060504184011.GB6966@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061829.GB22607@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502061829.GB22607@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog

Fixes comments by jlan@engr.sgi.com
- separate out taskstats interface from delay accounting completely including
separate documentation
- permit different accounting subsystems to fill in parts of common
structure separately before common taskstats code sends it out on genetlink
- send common structure to userspace after update_hiwater_rss and before
exit_mm in do_exit
- move version field right upfront and avoid the filler member in taskstats

Fixes comments by akpm
- comment to indicate locking used for taskstats struct
- whitespace issues
- unnecessary use of constant taskstats_version
- uninline fill_pid(), fill_tgid()
- unnecessary cast to pid_t in taskstats_send_stats()
- too early evaluation of thread_group_empty() in taskstats_exit_pid
- returning -EFAULT on genl_register_family failure in taskstats_init
- comment for late_initcall of taskstats_init

No fix needed
- moving kmem_cache_free of tsk->delays outside the exit mutex
  (mutex shifted and tsk->delays freeing being done elsewhere now)	
- __delayacct_add_tsk returning -EINVAL if delay accounting isn't enabled
	user should know that no values can be returned
	returning zero would be misleading
- combining fill_pid(), fill_tgid() into a common function
	combined code convoluted and less readable

taskstats-setup.patch

Create a "taskstats" interface based on generic netlink
(NETLINK_GENERIC family), for getting statistics of
tasks and thread groups during their lifetime and when they exit.
The interface is intended for use by multiple accounting packages
though it is being created in the context of delay accounting.

This patch creates the interface without populating the
fields of the data that is sent to the user in response to a command
or upon the exit of a task. Each accounting package interested in using
taskstats has to provide an additional patch to add its stats to the
common structure.

Signed-off-by: Shailabh Nagar <nagar@us.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 Documentation/accounting/taskstats.txt |  146 ++++++++++++++
 include/linux/taskstats.h              |   84 ++++++++
 include/linux/taskstats_kern.h         |   57 +++++
 init/Kconfig                           |   12 +
 init/main.c                            |    2 
 kernel/Makefile                        |    1 
 kernel/exit.c                          |    7 
 kernel/taskstats.c                     |  329 +++++++++++++++++++++++++++++++++
 8 files changed, 638 insertions(+)

diff -puN /dev/null Documentation/accounting/taskstats.txt
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.17-rc3-balbir/Documentation/accounting/taskstats.txt	2006-05-04 09:30:50.000000000 +0530
@@ -0,0 +1,146 @@
+Per-task statistics interface
+-----------------------------
+
+
+Taskstats is a netlink-based interface for sending per-task and
+per-process statistics from the kernel to userspace.
+
+Taskstats was designed for the following benefits:
+
+- efficiently provide statistics during lifetime of a task and on its exit
+- unified interface for multiple accounting subsystems
+- extensibility for use by future accounting patches
+
+Terminology
+-----------
+
+"pid", "tid" and "task" are used interchangeably and refer to the standard
+Linux task defined by struct task_struct.  per-pid stats are the same as
+per-task stats.
+
+"tgid", "process" and "thread group" are used interchangeably and refer to the
+tasks that share an mm_struct i.e. the traditional Unix process. Despite the
+use of tgid, there is no special treatment for the task that is thread group
+leader - a process is deemed alive as long as it has any task belonging to it.
+
+Usage
+-----
+
+To get statistics during task's lifetime, userspace opens a unicast netlink
+socket (NETLINK_GENERIC family) and sends commands specifying a pid or a tgid.
+The response contains statistics for a task (if pid is specified) or the sum of
+statistics for all tasks of the process (if tgid is specified).
+
+To obtain statistics for tasks which are exiting, userspace opens a multicast
+netlink socket. Each time a task exits, two records are sent by the kernel to
+each listener on the multicast socket. The first the per-pid task's statistics
+and the second is the sum for all tasks of the process to which the task
+belongs (the task does not need to be the thread group leader). The need for
+per-tgid stats to be sent for each exiting task is explained in the per-tgid
+stats section below.
+
+
+Interface
+---------
+
+The user-kernel interface is encapsulated in include/linux/taskstats.h
+
+To avoid this documentation becoming obsolete as the interface evolves, only
+an outline of the current version is given. taskstats.h always overrides the
+description here.
+
+struct taskstats is the common accounting structure for both per-pid and
+per-tgid data. It is versioned and can be extended by each accounting subsystem
+that is added to the kernel. The fields and their semantics are defined in the
+taskstats.h file.
+
+The data exchanged between user and kernel space is a netlink message belonging
+to the NETLINK_GENERIC family and using the netlink attributes interface.
+The messages are in the format
+
+    +----------+- - -+-------------+-------------------+
+    | nlmsghdr | Pad |  genlmsghdr | taskstats payload |
+    +----------+- - -+-------------+-------------------+
+
+
+The taskstats payload is one of the following three kinds:
+
+1. Commands: Sent from user to kernel. The payload is one attribute, of type
+TASKSTATS_CMD_ATTR_PID/TGID, containing a u32 pid or tgid in the attribute
+payload. The pid/tgid denotes the task/process for which userspace wants
+statistics.
+
+2. Response for a command: sent from the kernel in response to a userspace
+command. The payload is a series of three attributes of type:
+
+a) TASKSTATS_TYPE_AGGR_PID/TGID : attribute containing no payload but indicates
+a pid/tgid will be followed by some stats.
+
+b) TASKSTATS_TYPE_PID/TGID: attribute whose payload is the pid/tgid whose stats
+is being returned.
+
+c) TASKSTATS_TYPE_STATS: attribute with a struct taskstsats as payload. The
+same structure is used for both per-pid and per-tgid stats.
+
+3. New message sent by kernel whenever a task exits. The payload consists of a
+   series of attributes of the following type:
+
+a) TASKSTATS_TYPE_AGGR_PID: indicates next two attributes will be pid+stats
+b) TASKSTATS_TYPE_PID: contains exiting task's pid
+c) TASKSTATS_TYPE_STATS: contains the exiting task's per-pid stats
+d) TASKSTATS_TYPE_AGGR_TGID: indicates next two attributes will be tgid+stats
+e) TASKSTATS_TYPE_TGID: contains tgid of process to which task belongs
+f) TASKSTATS_TYPE_STATS: contains the per-tgid stats for exiting task's process
+
+
+per-tgid stats
+--------------
+
+Taskstats provides per-process stats, in addition to per-task stats, since
+resource management is often done at a process granularity and aggregating task
+stats in userspace alone is inefficient and potentially inaccurate (due to lack
+of atomicity).
+
+However, maintaining per-process, in addition to per-task stats, within the
+kernel has space and time overheads. Hence the taskstats implementation
+dynamically sums up the per-task stats for each task belonging to a process
+whenever per-process stats are needed.
+
+Not maintaining per-tgid stats creates a problem when userspace is interested
+in getting these stats when the process dies i.e. the last thread of
+a process exits. It isn't possible to simply return some aggregated per-process
+statistic from the kernel.
+
+The approach taken by taskstats is to return the per-tgid stats *each* time
+a task exits, in addition to the per-pid stats for that task. Userspace can
+maintain task<->process mappings and use them to maintain the per-process stats
+in userspace, updating the aggregate appropriately as the tasks of a process
+exit.
+
+Extending taskstats
+-------------------
+
+There are two ways to extend the taskstats interface to export more
+per-task/process stats as patches to collect them get added to the kernel
+in future:
+
+1. Adding more fields to the end of the existing struct taskstats. Backward
+   compatibility is ensured by the version number within the
+   structure. Userspace will use only the fields of the struct that correspond
+   to the version its using.
+
+2. Defining separate statistic structs and using the netlink attributes
+   interface to return them. Since userspace processes each netlink attribute
+   independently, it can always ignore attributes whose type it does not
+   understand (because it is using an older version of the interface).
+
+
+Choosing between 1. and 2. is a matter of trading off flexibility and
+overhead. If only a few fields need to be added, then 1. is the preferable
+path since the kernel and userspace don't need to incur the overhead of
+processing new netlink attributes. But if the new fields expand the existing
+struct too much, requiring disparate userspace accounting utilities to
+unnecessarily receive large structures whose fields are of no interest, then
+extending the attributes structure would be worthwhile.
+
+----
diff -puN /dev/null include/linux/taskstats.h
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/taskstats.h	2006-05-04 09:31:52.000000000 +0530
@@ -0,0 +1,84 @@
+/* taskstats.h - exporting per-task statistics
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ *           (C) Balbir Singh,   IBM Corp. 2006
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef _LINUX_TASKSTATS_H
+#define _LINUX_TASKSTATS_H
+
+/* Format for per-task data returned to userland when
+ *	- a task exits
+ *	- listener requests stats for a task
+ *
+ * The struct is versioned. Newer versions should only add fields to
+ * the bottom of the struct to maintain backward compatibility.
+ *
+ *
+ * To add new fields
+ *	a) bump up TASKSTATS_VERSION
+ *	b) add comment indicating new version number at end of struct
+ *	c) add new fields after version comment; maintain 64-bit alignment
+ */
+
+#define TASKSTATS_VERSION	1
+
+struct taskstats {
+
+	/* Version 1 */
+	__u64	version;
+};
+
+
+#define TASKSTATS_LISTEN_GROUP	0x1
+
+/*
+ * Commands sent from userspace
+ * Not versioned. New commands should only be inserted at the enum's end
+ * prior to __TASKSTATS_CMD_MAX
+ */
+
+enum {
+	TASKSTATS_CMD_UNSPEC = 0,	/* Reserved */
+	TASKSTATS_CMD_GET,		/* user->kernel request/get-response */
+	TASKSTATS_CMD_NEW,		/* kernel->user event */
+	__TASKSTATS_CMD_MAX,
+};
+
+#define TASKSTATS_CMD_MAX (__TASKSTATS_CMD_MAX - 1)
+
+enum {
+	TASKSTATS_TYPE_UNSPEC = 0,	/* Reserved */
+	TASKSTATS_TYPE_PID,		/* Process id */
+	TASKSTATS_TYPE_TGID,		/* Thread group id */
+	TASKSTATS_TYPE_STATS,		/* taskstats structure */
+	TASKSTATS_TYPE_AGGR_PID,	/* contains pid + stats */
+	TASKSTATS_TYPE_AGGR_TGID,	/* contains tgid + stats */
+	__TASKSTATS_TYPE_MAX,
+};
+
+#define TASKSTATS_TYPE_MAX (__TASKSTATS_TYPE_MAX - 1)
+
+enum {
+	TASKSTATS_CMD_ATTR_UNSPEC = 0,
+	TASKSTATS_CMD_ATTR_PID,
+	TASKSTATS_CMD_ATTR_TGID,
+	__TASKSTATS_CMD_ATTR_MAX,
+};
+
+#define TASKSTATS_CMD_ATTR_MAX (__TASKSTATS_CMD_ATTR_MAX - 1)
+
+/* NETLINK_GENERIC related info */
+
+#define TASKSTATS_GENL_NAME	"TASKSTATS"
+#define TASKSTATS_GENL_VERSION	0x1
+
+#endif /* _LINUX_TASKSTATS_H */
diff -puN /dev/null include/linux/taskstats_kern.h
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/taskstats_kern.h	2006-05-02 09:47:24.000000000 +0530
@@ -0,0 +1,57 @@
+/* taskstats_kern.h - kernel header for per-task statistics interface
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ *           (C) Balbir Singh,   IBM Corp. 2006
+ */
+
+#ifndef _LINUX_TASKSTATS_KERN_H
+#define _LINUX_TASKSTATS_KERN_H
+
+#include <linux/taskstats.h>
+#include <linux/sched.h>
+
+enum {
+	TASKSTATS_MSG_UNICAST,		/* send data only to requester */
+	TASKSTATS_MSG_MULTICAST,	/* send data to a group */
+};
+
+#ifdef CONFIG_TASKSTATS
+extern kmem_cache_t *taskstats_cache;
+
+static inline void taskstats_exit_alloc(struct taskstats **ptidstats,
+					struct taskstats **ptgidstats)
+{
+	*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+	*ptgidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+}
+
+static inline void taskstats_exit_free(struct taskstats *tidstats,
+					struct taskstats *tgidstats)
+{
+	if (tidstats)
+		kmem_cache_free(taskstats_cache, tidstats);
+	if (tgidstats)
+		kmem_cache_free(taskstats_cache, tgidstats);
+}
+
+extern void taskstats_exit_send(struct task_struct *, struct taskstats *,
+				struct taskstats *);
+extern void taskstats_init_early(void);
+
+#else
+static inline void taskstats_exit_alloc(struct taskstats **ptidstats,
+					struct taskstats **ptgidstats)
+{}
+static inline void taskstats_exit_free(struct taskstats *ptidstats,
+					struct taskstats *ptgidstats)
+{}
+static inline void taskstats_exit_send(struct task_struct *tsk,
+					struct taskstats *tidstats,
+					struct taskstats *tgidstats)
+{}
+static inline void taskstats_init_early(void)
+{}
+#endif /* CONFIG_TASKSTATS */
+
+#endif
+
diff -puN init/Kconfig~taskstats-setup init/Kconfig
--- linux-2.6.17-rc3/init/Kconfig~taskstats-setup	2006-05-02 09:47:24.000000000 +0530
+++ linux-2.6.17-rc3-balbir/init/Kconfig	2006-05-04 09:31:24.000000000 +0530
@@ -150,6 +150,18 @@ config BSD_PROCESS_ACCT_V3
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
+config TASKSTATS
+	bool "Export task/process statistics through netlink (EXPERIMENTAL)"
+	default n
+	help
+	  Export selected statistics for tasks/processes through the
+	  generic netlink interface. Unlike BSD process accounting, the
+	  statistics are available during the lifetime of tasks/processes as
+	  responses to commands. Like BSD accounting, they are sent to user
+	  space on task exit.
+
+	  Say N if unsure.
+
 config TASK_DELAY_ACCT
 	bool "Enable per-task delay accounting (EXPERIMENTAL)"
 	help
diff -puN init/main.c~taskstats-setup init/main.c
--- linux-2.6.17-rc3/init/main.c~taskstats-setup	2006-05-02 09:47:24.000000000 +0530
+++ linux-2.6.17-rc3-balbir/init/main.c	2006-05-02 09:47:24.000000000 +0530
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/taskstats_kern.h>
 #include <linux/delayacct.h>
 
 #include <asm/io.h>
@@ -542,6 +543,7 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	cpuset_init();
+	taskstats_init_early();
 	delayacct_init();
 
 	check_bugs();
diff -puN kernel/exit.c~taskstats-setup kernel/exit.c
--- linux-2.6.17-rc3/kernel/exit.c~taskstats-setup	2006-05-02 09:47:24.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/exit.c	2006-05-02 09:47:24.000000000 +0530
@@ -36,6 +36,7 @@
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/delayacct.h>
+#include <linux/taskstats_kern.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -848,6 +849,7 @@ static void exit_notify(struct task_stru
 fastcall NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
+	struct taskstats *tidstats, *tgidstats;
 	int group_dead;
 
 	profile_task_exit(tsk);
@@ -894,6 +896,8 @@ fastcall NORET_TYPE void do_exit(long co
 				current->comm, current->pid,
 				preempt_count());
 
+	taskstats_exit_alloc(&tidstats, &tgidstats);
+
 	acct_update_integrals(tsk);
 	if (tsk->mm) {
 		update_hiwater_rss(tsk->mm);
@@ -911,7 +915,10 @@ fastcall NORET_TYPE void do_exit(long co
 	if (unlikely(tsk->compat_robust_list))
 		compat_exit_robust_list(tsk);
 #endif
+	taskstats_exit_send(tsk, tidstats, tgidstats);
+	taskstats_exit_free(tidstats, tgidstats);
 	delayacct_tsk_exit(tsk);
+
 	exit_mm(tsk);
 
 	exit_sem(tsk);
diff -puN kernel/Makefile~taskstats-setup kernel/Makefile
--- linux-2.6.17-rc3/kernel/Makefile~taskstats-setup	2006-05-02 09:47:24.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/Makefile	2006-05-02 09:47:24.000000000 +0530
@@ -39,6 +39,7 @@ obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
+obj-$(CONFIG_TASKSTATS) += taskstats.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -puN /dev/null kernel/taskstats.c
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/taskstats.c	2006-05-04 09:31:24.000000000 +0530
@@ -0,0 +1,329 @@
+/*
+ * taskstats.c - Export per-task statistics to userland
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ *           (C) Balbir Singh,   IBM Corp. 2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/taskstats_kern.h>
+#include <net/genetlink.h>
+#include <asm/atomic.h>
+
+static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
+static int family_registered = 0;
+kmem_cache_t *taskstats_cache;
+static DEFINE_MUTEX(taskstats_exit_mutex);
+
+static struct genl_family family = {
+	.id		= GENL_ID_GENERATE,
+	.name		= TASKSTATS_GENL_NAME,
+	.version	= TASKSTATS_GENL_VERSION,
+	.maxattr	= TASKSTATS_CMD_ATTR_MAX,
+};
+
+static struct nla_policy taskstats_cmd_get_policy[TASKSTATS_CMD_ATTR_MAX+1]
+__read_mostly = {
+	[TASKSTATS_CMD_ATTR_PID]  = { .type = NLA_U32 },
+	[TASKSTATS_CMD_ATTR_TGID] = { .type = NLA_U32 },
+};
+
+
+static int prepare_reply(struct genl_info *info, u8 cmd, struct sk_buff **skbp,
+			void **replyp, size_t size)
+{
+	struct sk_buff *skb;
+	void *reply;
+
+	/*
+	 * If new attributes are added, please revisit this allocation
+	 */
+	skb = nlmsg_new(size);
+	if (!skb)
+		return -ENOMEM;
+
+	if (!info) {
+		int seq = get_cpu_var(taskstats_seqnum)++;
+		put_cpu_var(taskstats_seqnum);
+
+		reply = genlmsg_put(skb, 0, seq,
+				family.id, 0, 0,
+				cmd, family.version);
+	} else
+		reply = genlmsg_put(skb, info->snd_pid, info->snd_seq,
+				family.id, 0, 0,
+				cmd, family.version);
+	if (reply == NULL) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	*skbp = skb;
+	*replyp = reply;
+	return 0;
+}
+
+static int send_reply(struct sk_buff *skb, pid_t pid, int event)
+{
+	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
+	void *reply;
+	int rc;
+
+	reply = genlmsg_data(genlhdr);
+
+	rc = genlmsg_end(skb, reply);
+	if (rc < 0) {
+		nlmsg_free(skb);
+		return rc;
+	}
+
+	if (event == TASKSTATS_MSG_MULTICAST)
+		return genlmsg_multicast(skb, pid, TASKSTATS_LISTEN_GROUP);
+	return genlmsg_unicast(skb, pid);
+}
+
+static int fill_pid(pid_t pid, struct task_struct *pidtsk,
+		struct taskstats *stats)
+{
+	int rc;
+	struct task_struct *tsk = pidtsk;
+
+	if (!pidtsk) {
+		read_lock(&tasklist_lock);
+		tsk = find_task_by_pid(pid);
+		if (!tsk) {
+			read_unlock(&tasklist_lock);
+			return -ESRCH;
+		}
+		get_task_struct(tsk);
+		read_unlock(&tasklist_lock);
+	} else
+		get_task_struct(tsk);
+
+	/*
+	 * Each accounting subsystem adds calls to its functions to
+	 * fill in relevant parts of struct taskstsats as follows
+	 *
+	 *	rc = per-task-foo(stats, tsk);
+	 *	if (rc)
+	 *		goto err;
+	 */
+
+err:
+	put_task_struct(tsk);
+	return rc;
+
+}
+
+static int fill_tgid(pid_t tgid, struct task_struct *tgidtsk,
+		struct taskstats *stats)
+{
+	int rc;
+	struct task_struct *tsk, *first;
+
+	first = tgidtsk;
+	read_lock(&tasklist_lock);
+	if (!first) {
+		first = find_task_by_pid(tgid);
+		if (!first) {
+			read_unlock(&tasklist_lock);
+			return -ESRCH;
+		}
+	}
+	tsk = first;
+	do {
+		/*
+		 * Each accounting subsystem adds calls its functions to
+		 * fill in relevant parts of struct taskstsats as follows
+		 *
+		 *	rc = per-task-foo(stats, tsk);
+		 *	if (rc)
+		 *		break;
+		 */
+
+	} while_each_thread(first, tsk);
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Accounting subsytems can also add calls here if they don't
+	 * wish to aggregate statistics for per-tgid stats
+	 */
+
+	return rc;
+}
+
+static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
+{
+	int rc = 0;
+	struct sk_buff *rep_skb;
+	struct taskstats stats;
+	void *reply;
+	size_t size;
+	struct nlattr *na;
+
+	/*
+	 * Size includes space for nested attributes
+	 */
+	size = nla_total_size(sizeof(u32)) +
+		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
+
+	memset(&stats, 0, sizeof(stats));
+	rc = prepare_reply(info, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
+	if (rc < 0)
+		return rc;
+
+	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
+		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
+		rc = fill_pid(pid, NULL, &stats);
+		if (rc < 0)
+			goto err;
+
+		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
+		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, pid);
+		NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
+				stats);
+	} else if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
+		u32 tgid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_TGID]);
+		rc = fill_tgid(tgid, NULL, &stats);
+		if (rc < 0)
+			goto err;
+
+		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
+		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, tgid);
+		NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
+				stats);
+	} else {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	nla_nest_end(rep_skb, na);
+
+	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST);
+
+nla_put_failure:
+	return genlmsg_cancel(rep_skb, reply);
+err:
+	nlmsg_free(rep_skb);
+	return rc;
+}
+
+/* Send pid data out on exit */
+void taskstats_exit_send(struct task_struct *tsk, struct taskstats *tidstats,
+			struct taskstats *tgidstats)
+{
+	int rc;
+	struct sk_buff *rep_skb;
+	void *reply;
+	size_t size;
+	int is_thread_group;
+	struct nlattr *na;
+
+	if (!family_registered || !tidstats)
+		return;
+
+	mutex_lock(&taskstats_exit_mutex);
+
+	is_thread_group = !thread_group_empty(tsk);
+	rc = 0;
+
+	/*
+	 * Size includes space for nested attributes
+	 */
+	size = nla_total_size(sizeof(u32)) +
+		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
+
+	if (is_thread_group)
+		size = 2 * size;	/* PID + STATS + TGID + STATS */
+
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
+	if (rc < 0)
+		goto ret;
+
+	rc = fill_pid(tsk->pid, tsk, tidstats);
+	if (rc < 0)
+		goto err_skb;
+
+	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
+	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, (u32)tsk->pid);
+	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
+			*tidstats);
+	nla_nest_end(rep_skb, na);
+
+	if (!is_thread_group || !tgidstats) {
+		send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+		goto ret;
+	}
+
+	rc = fill_tgid(tsk->pid, tsk, tgidstats);
+	if (rc < 0)
+		goto err_skb;
+
+	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
+	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, (u32)tsk->tgid);
+	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
+			*tgidstats);
+	nla_nest_end(rep_skb, na);
+
+	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+	goto ret;
+
+nla_put_failure:
+	genlmsg_cancel(rep_skb, reply);
+	goto ret;
+err_skb:
+	nlmsg_free(rep_skb);
+ret:
+	mutex_unlock(&taskstats_exit_mutex);
+	return;
+}
+
+static struct genl_ops taskstats_ops = {
+	.cmd		= TASKSTATS_CMD_GET,
+	.doit		= taskstats_send_stats,
+	.policy		= taskstats_cmd_get_policy,
+};
+
+/* Needed early in initialization */
+void __init taskstats_init_early(void)
+{
+	taskstats_cache = kmem_cache_create("taskstats_cache",
+						sizeof(struct taskstats),
+						0, SLAB_PANIC, NULL, NULL);
+}
+
+static int __init taskstats_init(void)
+{
+	int rc;
+
+	rc = genl_register_family(&family);
+	if (rc)
+		return rc;
+	family_registered = 1;
+
+	if ((rc = genl_register_ops(&family, &taskstats_ops)) < 0)
+		goto err;
+
+	return 0;
+err:
+	genl_unregister_family(&family);
+	family_registered = 0;
+	return rc;
+}
+
+/*
+ * late initcall ensures initialization of statistics collection
+ * mechanisms precedes initialization of the taskstats interface
+ */
+late_initcall(taskstats_init);
_
