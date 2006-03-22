Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWCVHvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWCVHvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWCVHvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:51:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:17592 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751080AbWCVHvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:51:40 -0500
Date: Wed, 22 Mar 2006 13:19:22 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: jamal <hadi@cyberus.ca>
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Subject: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink interface for delay accounting
Message-ID: <20060322074922.GA1164@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1142296834.5858.3.camel@elinux04.optonline.net> <1142297791.5858.31.camel@elinux04.optonline.net> <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142304506.5219.34.camel@jzny2>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 09:48:26PM -0500, jamal wrote:
> On Mon, 2006-13-03 at 18:33 -0800, Matt Helsley wrote:
> > On Mon, 2006-03-13 at 19:56 -0500, Shailabh Nagar wrote:
> 
> 
> I had a long description in an earlier email feedback; but the summary
> of it is the GET command is generic like TASKSTATS_CMD_GET; the message
> itself carries TLVs of what needs to be gotten which are 
> either PID and/or TGID etc. Anyways, theres a long spill of what i am
> saying in that earlier email. Perhaps the current patch is a transition
> towards that?
> 

Hi, Jamal,

Please find the updated version of delayacct-genetlink.patch. We hope
this iteration is closer to your expectation. I have copied the enums
you suggested in your previous review comments and used them.

Comments addressed (in this patch)

- Changed the code to use TLV's for data exchange between kernel and
  user space

Thanks,
Balbir


Documentation for the patch

Create a generic netlink interface (NETLINK_GENERIC family),
called "taskstats", for getting delay and cpu statistics of
tasks and thread groups during their lifetime and when they exit.

More changes expected. Following comments will go into a
Documentation file:

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

---

 include/linux/delayacct.h |   11 ++
 include/linux/taskstats.h |  112 ++++++++++++++++++++
 init/Kconfig              |   16 ++
 kernel/Makefile           |    1 
 kernel/delayacct.c        |   44 ++++++++
 kernel/taskstats.c        |  251 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 432 insertions(+), 3 deletions(-)

diff -puN include/linux/delayacct.h~delayacct-genetlink include/linux/delayacct.h
--- linux-2.6.16/include/linux/delayacct.h~delayacct-genetlink	2006-03-22 11:56:03.000000000 +0530
+++ linux-2.6.16-balbir/include/linux/delayacct.h	2006-03-22 11:56:03.000000000 +0530
@@ -15,6 +15,7 @@
 #define _LINUX_TASKDELAYS_H
 
 #include <linux/sched.h>
+#include <linux/taskstats.h>
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 extern int delayacct_on;	/* Delay accounting turned on/off */
@@ -25,6 +26,7 @@ extern void __delayacct_tsk_exit(struct 
 extern void __delayacct_blkio_start(void);
 extern void __delayacct_blkio_end(void);
 extern unsigned long long __delayacct_blkio_ticks(struct task_struct *);
+extern int __delayacct_add_tsk(struct taskstats *, struct task_struct *);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -72,4 +74,13 @@ static inline unsigned long long delayac
 	return 0;
 }
 #endif /* CONFIG_TASK_DELAY_ACCT */
+#ifdef CONFIG_TASKSTATS
+static inline int delayacct_add_tsk(struct taskstats *d,
+				    struct task_struct *tsk)
+{
+	if (!tsk->delays)
+		return -EINVAL;
+	return __delayacct_add_tsk(d, tsk);
+}
+#endif
 #endif /* _LINUX_TASKDELAYS_H */
diff -puN /dev/null include/linux/taskstats.h
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.16-balbir/include/linux/taskstats.h	2006-03-22 13:12:01.000000000 +0530
@@ -0,0 +1,112 @@
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
+#define TASKSTATS_NOPID	-1
+
+struct taskstats {
+	/* Maintain 64-bit alignment while extending */
+	/* Version 1 */
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
+	TASKSTATS_CMD_UNSPEC = 0,	/* Reserved */
+	TASKSTATS_CMD_GET,		/* user->kernel request */
+	TASKSTATS_CMD_NEW,		/* kernel->user event */
+	__TASKSTATS_CMD_MAX,
+};
+
+#define TASKSTATS_CMD_MAX (__TASKSTATS_CMD_MAX - 1)
+
+enum {
+	TASKSTATS_TYPE_UNSPEC = 0,	/* Reserved */
+	TASKSTATS_TYPE_TGID,		/* Thread group id */
+	TASKSTATS_TYPE_PID,		/* Process id */
+	TASKSTATS_TYPE_STATS,		/* taskstats structure */
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
+enum {
+	TASKSTATS_MSG_UNICAST,		/* send data only to requester */
+	TASKSTATS_MSG_MULTICAST,	/* send data to a group */
+};
+
+
+/* NETLINK_GENERIC related info */
+
+#define TASKSTATS_GENL_NAME	"TASKSTATS"
+#define TASKSTATS_GENL_VERSION	0x1
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
diff -puN init/Kconfig~delayacct-genetlink init/Kconfig
--- linux-2.6.16/init/Kconfig~delayacct-genetlink	2006-03-22 11:56:03.000000000 +0530
+++ linux-2.6.16-balbir/init/Kconfig	2006-03-22 11:56:03.000000000 +0530
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
diff -puN kernel/delayacct.c~delayacct-genetlink kernel/delayacct.c
--- linux-2.6.16/kernel/delayacct.c~delayacct-genetlink	2006-03-22 11:56:03.000000000 +0530
+++ linux-2.6.16-balbir/kernel/delayacct.c	2006-03-22 13:12:01.000000000 +0530
@@ -1,6 +1,7 @@
 /* delayacct.c - per-task delay accounting
  *
  * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ * Copyright (C) Balbir Singh, IBM Corp. 2006
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2.1 of the GNU Lesser General Public License
@@ -16,9 +17,12 @@
 #include <linux/time.h>
 #include <linux/sysctl.h>
 #include <linux/delayacct.h>
+#include <linux/taskstats.h>
+#include <linux/mutex.h>
 
 int delayacct_on = 0;		/* Delay accounting turned on/off */
 kmem_cache_t *delayacct_cache;
+static DEFINE_MUTEX(delayacct_exit_mutex);
 
 static int __init delayacct_setup_enable(char *str)
 {
@@ -51,10 +55,16 @@ void __delayacct_tsk_init(struct task_st
 
 void __delayacct_tsk_exit(struct task_struct *tsk)
 {
+	/*
+	 * Protect against racing thread group exits
+	 */
+	mutex_lock(&delayacct_exit_mutex);
+	taskstats_exit_pid(tsk);
 	if (tsk->delays) {
 		kmem_cache_free(delayacct_cache, tsk->delays);
 		tsk->delays = NULL;
 	}
+	mutex_unlock(&delayacct_exit_mutex);
 }
 
 /*
@@ -124,3 +134,37 @@ unsigned long long __delayacct_blkio_tic
 	spin_unlock(&tsk->delays->lock);
 	return ret;
 }
+#ifdef CONFIG_TASKSTATS
+int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
+{
+	nsec_t tmp;
+	struct timespec ts;
+	unsigned long t1,t2;
+
+	/* zero XXX_total,non-zero XXX_count implies XXX stat overflowed */
+
+	tmp = (nsec_t)d->cpu_run_total ;
+	tmp += (u64)(tsk->utime+tsk->stime)*TICK_NSEC;
+	d->cpu_run_total = (tmp < (nsec_t)d->cpu_run_total)? 0: tmp;
+
+	/* No locking available for sched_info. Take snapshot first. */
+	t1 = tsk->sched_info.pcnt;
+	t2 = tsk->sched_info.run_delay;
+
+	d->cpu_count += t1;
+
+	jiffies_to_timespec(t2, &ts);
+	tmp = (nsec_t)d->cpu_delay_total + timespec_to_ns(&ts);
+	d->cpu_delay_total = (tmp < (nsec_t)d->cpu_delay_total)? 0: tmp;
+
+	spin_lock(&tsk->delays->lock);
+	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
+	d->blkio_delay_total = (tmp < d->blkio_delay_total)? 0: tmp;
+	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
+	d->swapin_delay_total = (tmp < d->swapin_delay_total)? 0: tmp;
+	d->blkio_count += tsk->delays->blkio_count;
+	d->swapin_count += tsk->delays->swapin_count;
+	spin_unlock(&tsk->delays->lock);
+	return 0;
+}
+#endif /* CONFIG_TASKSTATS */
diff -puN kernel/Makefile~delayacct-genetlink kernel/Makefile
--- linux-2.6.16/kernel/Makefile~delayacct-genetlink	2006-03-22 11:56:03.000000000 +0530
+++ linux-2.6.16-balbir/kernel/Makefile	2006-03-22 11:56:03.000000000 +0530
@@ -35,6 +35,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
+obj-$(CONFIG_TASKSTATS) += taskstats.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -puN /dev/null kernel/taskstats.c
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.16-balbir/kernel/taskstats.c	2006-03-22 13:12:07.000000000 +0530
@@ -0,0 +1,251 @@
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
+static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
+static int family_registered = 0;
+
+static struct genl_family family = {
+	.id             = GENL_ID_GENERATE,
+	.name           = TASKSTATS_GENL_NAME,
+	.version        = TASKSTATS_GENL_VERSION,
+	.hdrsize        = 0,
+	.maxattr        = TASKSTATS_CMD_ATTR_MAX,
+};
+
+static struct nla_policy taskstats_cmd_get_policy[TASKSTATS_CMD_ATTR_MAX+1] __read_mostly = {
+	[TASKSTATS_CMD_ATTR_PID]  = { .type = NLA_U32 },
+	[TASKSTATS_CMD_ATTR_TGID] = { .type = NLA_U32 },
+};
+
+
+static int prepare_reply(struct genl_info *info, u8 cmd, struct sk_buff **skbp,
+			 void **replyp)
+{
+	struct sk_buff *skb;
+	void *reply;
+
+	skb = nlmsg_new(NLMSG_GOODSIZE);
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
+static inline int fill_pid(pid_t pid, struct task_struct *pidtsk,
+			   struct taskstats *stats)
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
+	rc = delayacct_add_tsk(stats, tsk);
+	put_task_struct(tsk);
+
+	return rc;
+
+}
+
+static inline int fill_tgid(pid_t tgid, struct task_struct *tgidtsk,
+			    struct taskstats *stats)
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
+		rc = delayacct_add_tsk(stats, tsk);
+		if (rc)
+			break;
+	} while_each_thread(first, tsk);
+	read_unlock(&tasklist_lock);
+
+	return rc;
+}
+
+static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
+{
+	int rc;
+	struct sk_buff *rep_skb;
+	struct taskstats stats;
+	void *reply;
+
+	memset(&stats, 0, sizeof(stats));
+	rc = prepare_reply(info, info->genlhdr->cmd, &rep_skb, &reply);
+	if (rc < 0)
+		return rc;
+
+	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
+		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
+		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, pid);
+		rc = fill_pid((pid_t)pid, NULL, &stats);
+		if (rc < 0)
+			return rc;
+	}
+
+	if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
+		u32 tgid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_TGID]);
+		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, tgid);
+		rc = fill_tgid((pid_t)tgid, NULL, &stats);
+		if (rc < 0)
+			return rc;
+	}
+
+	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
+	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST);
+
+nla_put_failure:
+	return genlmsg_cancel(rep_skb, reply);
+
+}
+
+
+/* Send pid data out on exit */
+void taskstats_exit_pid(struct task_struct *tsk)
+{
+	int rc;
+	struct sk_buff *rep_skb;
+	void *reply;
+	struct taskstats stats;
+
+	/*
+	 * tasks can start to exit very early. Ensure that the family
+	 * is registered before notifications are sent out
+	 */
+	if (!family_registered)
+		return;
+
+	memset(&stats, 0, sizeof(stats));
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply);
+	if (rc < 0)
+		return;
+
+	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, (u32)tsk->pid);
+	rc = fill_pid(tsk->pid, tsk, &stats);
+	if (rc < 0)
+		return;
+
+	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
+	rc = send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+
+	if (rc || thread_group_empty(tsk))
+		return;
+
+	/* Send tgid data too */
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply);
+	if (rc < 0)
+		return;
+
+	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, (u32)tsk->tgid);
+	rc = fill_tgid(tsk->tgid, tsk, &stats);
+	if (rc < 0)
+		return;
+
+	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
+	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+
+nla_put_failure:
+	genlmsg_cancel(rep_skb, reply);
+}
+
+static struct genl_ops taskstats_ops = {
+	.cmd            = TASKSTATS_CMD_GET,
+	.doit           = taskstats_send_stats,
+	.policy		= taskstats_cmd_get_policy,
+};
+
+static int __init taskstats_init(void)
+{
+	if (genl_register_family(&family))
+		return -EFAULT;
+        family_registered = 1;
+
+	if (genl_register_ops(&family, &taskstats_ops))
+		goto err;
+
+	return 0;
+err:
+	genl_unregister_family(&family);
+	family_registered = 0;
+	return -EFAULT;
+}
+
+late_initcall(taskstats_init);
_
