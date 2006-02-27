Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWB0IbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWB0IbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWB0IbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:31:06 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11947 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932303AbWB0IbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:31:03 -0500
Subject: [Patch 7/7] Generic netlink interface (delay accounting)
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>, netdev <netdev@vger.kernel.org>
In-Reply-To: <1141026996.5785.38.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1141029060.5785.77.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Feb 2006 03:31:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-genetlink.patch

Create a generic netlink interface (NETLINK_GENERIC family), 
called "taskstats", for getting delay and cpu statistics of 
tasks and thread groups during their lifetime and when they exit. 

The cpu stats are available only if CONFIG_SCHEDSTATS is enabled.

When a task is alive, userspace can get its stats by sending a 
command containing its pid. Sending a tgid returns the sum of stats 
of the tasks belonging to that tgid (where such a sum makes sense). 
Together, the command interface allows stats for a large number of 
tasks to be collected more efficiently than would be possible 
through /proc or any per-pid interface. 

The netlink interface also sends the stats for each task to userspace 
when the task is exiting. This permits fine-grain accounting for 
short-lived tasks, which is important if userspace is doing its own 
aggregation of statistics based on some grouping of tasks 
(e.g. CSA jobs, ELSA banks or CKRM classes).

If the exiting task belongs to a thread group (with more members than itself)
, the latters delay stats are also sent out on the task's exit. This allows
userspace to get accurate data at a per-tgid level while the tid's of a tgid
are exiting one by one.

The interface has been deliberately kept distinct from the delay 
accounting code since it is potentially usable by other kernel components
that need to export per-pid/tgid data. The format of data returned to 
userspace is versioned and the command interface easily extensible to 
facilitate reuse.

If reuse is not deemed useful enough, the naming, placement of functions
and config options will be modified to make this an interface for delay 
accounting alone.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>

 include/linux/delayacct.h |    2 
 include/linux/taskstats.h |  125 +++++++++++++++++++++
 init/Kconfig              |   16 ++
 kernel/Makefile           |    1 
 kernel/delayacct.c        |   49 ++++++++
 kernel/taskstats.c        |  266 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 456 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc4/include/linux/delayacct.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/delayacct.h	2006-02-27 01:53:01.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/delayacct.h	2006-02-27 01:53:03.000000000 -0500
@@ -16,6 +16,7 @@
 
 #include <linux/sched.h>
 #include <linux/sysctl.h>
+#include <linux/taskstats.h>
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 extern int delayacct_on;	/* Delay accounting turned on/off */
@@ -27,6 +28,7 @@ extern void __delayacct_tsk_init(struct 
 extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio(void);
 extern void __delayacct_swapin(void);
+extern int delayacct_add_tsk(struct taskstats_reply *, struct task_struct *);
 
 static inline void delayacct_tsk_early_init(struct task_struct *tsk)
 {
Index: linux-2.6.16-rc4/include/linux/taskstats.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc4/include/linux/taskstats.h	2006-02-27 01:53:03.000000000 -0500
@@ -0,0 +1,125 @@
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
+ * To create the next version, bump up the taskstats_version variable
+ * and delineate the start of newly added fields with a comment indicating
+ * the version number.
+ */
+
+#define TASKSTATS_VERSION	1
+
+struct taskstats {
+
+	/* Version 1 */
+#define TASKSTATS_NOPID	-1
+	pid_t	pid;
+	pid_t	tgid;
+
+	/* XXX_count is number of delay values recorded.
+	 * XXX_total is corresponding cumulative delay in nanoseconds
+	 */
+
+#define TASKSTATS_NOCPUSTATS	1
+	__u64	cpu_count;
+	__u64	cpu_delay_total;	/* wait, while runnable, for cpu */
+	__u64	blkio_count;
+	__u64	blkio_delay_total;	/* sync,block io completion wait*/
+	__u64	swapin_count;
+	__u64	swapin_delay_total;	/* swapin page fault wait*/
+
+	__u64	cpu_run_total;		/* cpu running time
+					 * no count available/provided */
+};
+
+
+#define TASKSTATS_LISTEN_GROUP	0x1
+
+/*
+ * Commands sent from userspace
+ * Not versioned. New commands should only be inserted at the enum's end
+ */
+
+enum {
+	TASKSTATS_CMD_UNSPEC,		/* Reserved */
+	TASKSTATS_CMD_NONE,		/* Not a valid cmd to send
+					 * Marks data sent on task/tgid exit */
+	TASKSTATS_CMD_LISTEN,		/* Start listening */
+	TASKSTATS_CMD_IGNORE,		/* Stop listening */
+	TASKSTATS_CMD_PID,		/* Send stats for a pid */
+	TASKSTATS_CMD_TGID,		/* Send stats for a tgid */
+};
+
+/* Parameters for commands
+ * New parameters should only be inserted at the struct's end
+ */
+
+struct taskstats_cmd_param {
+	union {
+		pid_t	pid;
+		pid_t	tgid;
+	} id;
+};
+
+/*
+ * Reply sent from kernel
+ * Version number affects size/format of struct taskstats only
+ */
+
+struct taskstats_reply {
+	enum outtype {
+		TASKSTATS_REPLY_NONE = 1,	/* Control cmd response */
+		TASKSTATS_REPLY_PID,		/* per-pid data cmd response*/
+		TASKSTATS_REPLY_TGID,		/* per-tgid data cmd response*/
+		TASKSTATS_REPLY_EXIT_PID,	/* Exiting task's stats */
+		TASKSTATS_REPLY_EXIT_TGID,	/* Exiting tgid's stats
+						 * (sent on each tid's exit) */
+	} outtype;
+	__u32 version;
+	__u32 err;
+	struct taskstats stats;			/* Invalid if err != 0 */
+};
+
+/* NETLINK_GENERIC related info */
+
+#define TASKSTATS_GENL_NAME	"TASKSTATS"
+#define TASKSTATS_GENL_VERSION	0x1
+/* Following must be > NLMSG_MIN_TYPE */
+#define TASKSTATS_GENL_ID	0x123
+
+#define TASKSTATS_HDRLEN	(NLMSG_SPACE(GENL_HDRLEN))
+#define TASKSTATS_BODYLEN	(sizeof(struct taskstats_reply))
+
+#ifdef __KERNEL__
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_TASKSTATS
+extern void taskstats_exit_pid(struct task_struct *);
+#else
+static inline void taskstats_exit_pid(struct task_struct *tsk)
+{}
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_TASKSTATS_H */
Index: linux-2.6.16-rc4/kernel/Makefile
===================================================================
--- linux-2.6.16-rc4.orig/kernel/Makefile	2006-02-27 01:52:54.000000000 -0500
+++ linux-2.6.16-rc4/kernel/Makefile	2006-02-27 01:53:03.000000000 -0500
@@ -35,6 +35,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
+obj-$(CONFIG_TASKSTATS) += taskstats.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.16-rc4/kernel/taskstats.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc4/kernel/taskstats.c	2006-02-27 01:53:03.000000000 -0500
@@ -0,0 +1,266 @@
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
+#include <linux/taskstats.h>
+#include <linux/delayacct.h>
+#include <net/genetlink.h>
+#include <asm/atomic.h>
+
+const int taskstats_version = TASKSTATS_VERSION;
+static atomic_t taskstats_group_listeners = ATOMIC_INIT(0);
+static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
+
+static struct genl_family family = {
+//	.id             = GENL_ID_GENERATE,
+	.id             = TASKSTATS_GENL_ID,
+	.name           = TASKSTATS_GENL_NAME,
+	.version        = TASKSTATS_GENL_VERSION,
+	.hdrsize        = 0,
+	.maxattr        = 0,
+};
+
+#define genlmsg_data(genlhdr)	((char *)genlhdr + GENL_HDRLEN)
+
+/* Taskstat specific functions */
+
+static int taskstats_listen(struct sk_buff *skb, struct genl_info *info)
+{
+	atomic_inc(&taskstats_group_listeners);
+	return 0;
+}
+
+static int taskstats_ignore(struct sk_buff *skb, struct genl_info *info)
+{
+	atomic_dec(&taskstats_group_listeners);
+	return 0;
+}
+
+static int prepare_reply(struct genl_info *info, u8 cmd,
+			 struct sk_buff **skbp, struct taskstats_reply **replyp)
+{
+	struct sk_buff *skb;
+	struct taskstats_reply *reply;
+
+	skb = nlmsg_new(TASKSTATS_HDRLEN + TASKSTATS_BODYLEN);
+	if (!skb)
+		return -ENOMEM;
+
+	if (!info) {
+		int seq = get_cpu_var(taskstats_seqnum)++;
+		put_cpu_var(taskstats_seqnum);
+
+		reply = genlmsg_put(skb, 0, seq,
+				    family.id, 0, NLM_F_REQUEST,
+				    cmd, family.version);
+	} else
+		reply = genlmsg_put(skb, info->snd_pid, info->snd_seq,
+				    family.id, 0, info->nlhdr->nlmsg_flags,
+				    info->genlhdr->cmd, family.version);
+	if (reply == NULL) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+	skb_put(skb, TASKSTATS_BODYLEN);
+
+	memset(reply, 0, sizeof(*reply));
+	reply->version = taskstats_version;
+	reply->err = 0;
+
+	*skbp = skb;
+	*replyp = reply;
+	return 0;
+}
+
+static int send_reply(struct sk_buff *skb, int replytype)
+{
+	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
+	struct taskstats_reply *reply;
+
+	reply = (struct taskstats_reply *)genlmsg_data(genlhdr);
+	reply->outtype = replytype;
+
+	genlmsg_end(skb, genlhdr);
+	return genlmsg_multicast(skb, 0, TASKSTATS_LISTEN_GROUP);
+}
+
+static inline void fill_pid(struct taskstats_reply *reply, pid_t pid, struct task_struct *pidtsk)
+{
+	int rc;
+	struct task_struct *tsk = pidtsk;
+
+	if (!pidtsk) {
+		read_lock(&tasklist_lock);
+		tsk = find_task_by_pid(pid);
+		if (!tsk) {
+			read_unlock(&tasklist_lock);
+			reply->err = EINVAL;
+			return;
+		}
+		get_task_struct(tsk);
+		read_unlock(&tasklist_lock);
+	} else
+		get_task_struct(tsk);
+
+	rc = delayacct_add_tsk(reply, tsk);
+	if (!rc) {
+		reply->stats.pid = tsk->pid;
+		reply->stats.tgid = tsk->tgid;
+	} else
+		reply->err = (rc < 0) ? -rc : rc ;
+
+	put_task_struct(tsk);
+}
+
+static int taskstats_send_pid(struct sk_buff *skb, struct genl_info *info)
+{
+	int rc;
+	struct sk_buff *rep_skb;
+	struct taskstats_reply *reply;
+	struct taskstats_cmd_param *param= info->userhdr;
+
+	if (atomic_read(&taskstats_group_listeners) < 1)
+		return -EINVAL;
+
+	rc = prepare_reply(info, info->genlhdr->cmd, &rep_skb, &reply);
+	if (rc)
+		return rc;
+	fill_pid(reply, param->id.pid, NULL);
+	return send_reply(rep_skb, TASKSTATS_REPLY_PID);
+}
+
+static inline void fill_tgid(struct taskstats_reply *reply, pid_t tgid, struct task_struct *tgidtsk)
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
+			reply->err = EINVAL;
+			return;
+		}
+	}
+	tsk = first;
+	do {
+		rc = delayacct_add_tsk(reply, tsk);
+		if (rc)
+			break;
+	} while_each_thread(first, tsk);
+	read_unlock(&tasklist_lock);
+
+	if (!rc) {
+		reply->stats.pid = TASKSTATS_NOPID;
+		reply->stats.tgid = tgid;
+	} else
+		reply->err = (rc < 0) ? -rc : rc ;
+}
+
+static int taskstats_send_tgid(struct sk_buff *skb, struct genl_info *info)
+{
+	int rc;
+	struct sk_buff *rep_skb;
+	struct taskstats_reply *reply;
+	struct taskstats_cmd_param *param= info->userhdr;
+
+	if (atomic_read(&taskstats_group_listeners) < 1)
+		return -EINVAL;
+
+	rc = prepare_reply(info, info->genlhdr->cmd, &rep_skb, &reply);
+	if (rc)
+		return rc;
+	fill_tgid(reply, param->id.tgid, NULL);
+	return send_reply(rep_skb, TASKSTATS_REPLY_TGID);
+}
+
+/* Send pid data out on exit */
+void taskstats_exit_pid(struct task_struct *tsk)
+{
+	int rc;
+	struct sk_buff *rep_skb;
+	struct taskstats_reply *reply;
+
+	if (atomic_read(&taskstats_group_listeners) < 1)
+		return;
+
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NONE, &rep_skb, &reply);
+	if (rc)
+		return;
+	fill_pid(reply, tsk->pid, tsk);
+	rc = send_reply(rep_skb, TASKSTATS_REPLY_EXIT_PID);
+
+	if (rc || thread_group_empty(tsk))
+		return;
+
+	/* Send tgid data too */
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NONE, &rep_skb, &reply);
+	if (rc)
+		return;
+	fill_tgid(reply, tsk->tgid, tsk);
+	send_reply(rep_skb, TASKSTATS_REPLY_EXIT_TGID);
+}
+
+static struct genl_ops listen_ops = {
+	.cmd            = TASKSTATS_CMD_LISTEN,
+	.doit           = taskstats_listen,
+};
+
+static struct genl_ops ignore_ops = {
+	.cmd            = TASKSTATS_CMD_IGNORE,
+	.doit           = taskstats_ignore,
+};
+
+static struct genl_ops pid_ops = {
+	.cmd            = TASKSTATS_CMD_PID,
+	.doit           = taskstats_send_pid,
+};
+
+static struct genl_ops tgid_ops = {
+	.cmd            = TASKSTATS_CMD_TGID,
+	.doit           = taskstats_send_tgid,
+};
+
+static int family_registered = 0;
+
+static int __init taskstats_init(void)
+{
+        if (genl_register_family(&family))
+                return -EFAULT;
+        family_registered = 1;
+
+        if (genl_register_ops(&family, &listen_ops))
+               goto err;
+        if (genl_register_ops(&family, &ignore_ops))
+                goto err;
+        if (genl_register_ops(&family, &pid_ops))
+		goto err;
+        if (genl_register_ops(&family, &tgid_ops))
+                goto err;
+
+        return 0;
+err:
+        genl_unregister_family(&family);
+        family_registered = 0;
+        return -EFAULT;
+}
+
+late_initcall(taskstats_init);
+
Index: linux-2.6.16-rc4/init/Kconfig
===================================================================
--- linux-2.6.16-rc4.orig/init/Kconfig	2006-02-27 01:52:54.000000000 -0500
+++ linux-2.6.16-rc4/init/Kconfig	2006-02-27 01:53:03.000000000 -0500
@@ -158,11 +158,21 @@ config TASK_DELAY_ACCT
 	  in pages. Such statistics can help in setting a task's priorities
 	  relative to other tasks for cpu, io, rss limits etc.
 
-	  Unlike BSD process accounting, this information is available
-	  continuously during the lifetime of a task.
-
 	  Say N if unsure.
 
+config TASKSTATS
+	bool "Export task/process statistics through netlink (EXPERIMENTAL)"
+	depends on TASK_DELAY_ACCT
+	default y
+	help
+	  Export selected statistics for tasks/processes through the
+	  generic netlink interface. Unlike BSD process accounting, the
+	  statistics are available during the lifetime of tasks/processes as
+	  responses to commands. Like BSD accounting, they are sent to user
+	  space on task exit.
+
+	  Say Y if unsure.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux-2.6.16-rc4/kernel/delayacct.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/delayacct.c	2006-02-27 01:53:01.000000000 -0500
+++ linux-2.6.16-rc4/kernel/delayacct.c	2006-02-27 01:53:03.000000000 -0500
@@ -17,6 +17,7 @@
 #include <linux/time.h>
 #include <linux/sysctl.h>
 #include <linux/delayacct.h>
+#include <linux/taskstats.h>
 
 int delayacct_on = 0;		/* Delay accounting turned on/off */
 kmem_cache_t *delayacct_cache;
@@ -61,6 +62,7 @@ void __delayacct_tsk_init(struct task_st
 
 void __delayacct_tsk_exit(struct task_struct *tsk)
 {
+ 	taskstats_exit_pid(tsk);
 	task_lock(tsk);
 	if (tsk->delays) {
 		kmem_cache_free(delayacct_cache, tsk->delays);
@@ -209,3 +211,50 @@ int delayacct_sysctl_handler(ctl_table *
 		delayacct_on = prev;
 	return ret;
 }
+
+#ifdef CONFIG_TASKSTATS
+
+int delayacct_add_tsk(struct taskstats_reply *reply, struct task_struct *tsk)
+{
+	struct taskstats *d = &reply->stats;
+	nsec_t tmp;
+	struct timespec ts;
+	unsigned long t1,t2;
+
+	if (!tsk->delays || !delayacct_on)
+		return -EINVAL;
+
+	/* zero XXX_total,non-zero XXX_count implies XXX stat overflowed */
+#ifdef CONFIG_SCHEDSTATS
+
+	tmp = (nsec_t)d->cpu_run_total ;
+	tmp += (u64)(tsk->utime+tsk->stime)*TICK_NSEC;
+	d->cpu_run_total = (tmp < (nsec_t)d->cpu_run_total)? 0:tmp;
+
+	/* No locking available for sched_info. Take snapshot first. */
+	t1 = tsk->sched_info.pcnt;
+	t2 = tsk->sched_info.run_delay;
+
+	d->cpu_count += t1;
+
+	jiffies_to_timespec(t2, &ts);
+	tmp = (nsec_t)d->cpu_delay_total + timespec_to_ns(&ts);
+	d->cpu_delay_total = (tmp < (nsec_t)d->cpu_delay_total)? 0:tmp;
+#else
+	/* Non-zero XXX_total,zero XXX_count implies XXX stat unavailable */
+	d->cpu_count = 0;
+	d->cpu_run_total = d->cpu_delay_total = TASKSTATS_NOCPUSTATS;
+#endif
+	spin_lock(&tsk->delays->lock);
+	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
+	d->blkio_delay_total = (tmp < d->blkio_delay_total)? 0:tmp;
+	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
+	d->swapin_delay_total = (tmp < d->swapin_delay_total)? 0:tmp;
+	d->blkio_count += tsk->delays->blkio_count;
+	d->swapin_count += tsk->delays->swapin_count;
+	spin_unlock(&tsk->delays->lock);
+
+	return 0;
+}
+
+#endif /* CONFIG_TASKSTATS */


