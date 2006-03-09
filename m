Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWCIOiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWCIOiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWCIOiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:38:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:3732 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751990AbWCIOiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:38:15 -0500
Date: Thu, 9 Mar 2006 20:07:59 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: hadi@cyberus.ca, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: [UPDATED PATCH] Re: [Lse-tech] Re: [Patch 7/7] Generic netlink interface (delay	accounting)
Message-ID: <20060309143759.GA4653@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141029060.5785.77.camel@elinux04.optonline.net> <1141045194.5363.12.camel@localhost.localdomain> <4403608E.1050304@watson.ibm.com> <1141652556.5185.64.camel@localhost.localdomain> <440C6AAA.9030301@watson.ibm.com> <1141742282.5171.55.camel@localhost.localdomain> <440F52FF.30908@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440F52FF.30908@watson.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the clarification of the usage model. While our needs are 
> certainly much less complex,
> it is useful to know the range of options.
> 
> >There are no hard rules on what you need to be multicasting and as an
> >example you could send periodic(aka time based) samples from the kernel
> >on a multicast channel and that would be received by all. It did seem
> >odd that you want to have a semi-promiscous mode where a response to a
> >GET is multicast. If that is still what you want to achieve, then you
> >should.
> > 
> >>>Also if you can provide feedback whether the doc i sent was any use
> >>>and what wasnt clear etc.
> >also take a look at the excellent documentation Thomas Graf has put in
> >the kernel for all the utilities for manipulating netlink messages and
> >tell me if that should also be put in this doc (It is listed as a TODO).

Hello, Jamal,

Please find the latest version of the patch for review. The genetlink
code has been updated as per your review comments. The changelog is provided
below

1. Eliminated TASKSTATS_CMD_LISTEN and TASKSTATS_CMD_IGNORE
2. Provide generic functions called genlmsg_data() and genlmsg_len()
   in linux/net/genetlink.h
3. Do not multicast all replies, multicast only events generated due
   to task exit.
4. The taskstats and taskstats_reply structures are now 64 bit aligned.
5. Family id is dynamically generated.

Please let us know if we missed something out.

Thanks,
Balbir


Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>

---

 include/linux/delayacct.h |    2 
 include/linux/taskstats.h |  128 ++++++++++++++++++++++++
 include/net/genetlink.h   |   20 +++
 init/Kconfig              |   16 ++-
 kernel/Makefile           |    1 
 kernel/delayacct.c        |   56 ++++++++++
 kernel/taskstats.c        |  244 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 464 insertions(+), 3 deletions(-)

diff -puN include/linux/delayacct.h~delayacct-genetlink include/linux/delayacct.h
--- linux-2.6.16-rc5/include/linux/delayacct.h~delayacct-genetlink	2006-03-09 17:15:31.000000000 +0530
+++ linux-2.6.16-rc5-balbir/include/linux/delayacct.h	2006-03-09 17:15:31.000000000 +0530
@@ -15,6 +15,7 @@
 #define _LINUX_TASKDELAYS_H
 
 #include <linux/sched.h>
+#include <linux/taskstats.h>
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 extern int delayacct_on;	/* Delay accounting turned on/off */
@@ -24,6 +25,7 @@ extern void __delayacct_tsk_init(struct 
 extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio(void);
 extern void __delayacct_swapin(void);
+extern int delayacct_add_tsk(struct taskstats_reply *, struct task_struct *);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
diff -puN /dev/null include/linux/taskstats.h
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.16-rc5-balbir/include/linux/taskstats.h	2006-03-09 19:28:54.000000000 +0530
@@ -0,0 +1,128 @@
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
+	/* Maintain 64-bit alignment while extending */
+
+	/* Version 1 */
+#define TASKSTATS_NOPID	-1
+	__s64	pid;
+	__s64	tgid;
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
+	/* Maintain 64-bit alignment while extending */
+	union {
+		__s64	pid;
+		__s64	tgid;
+	} id;
+};
+
+enum outtype {
+	TASKSTATS_REPLY_NONE = 1,	/* Control cmd response */
+	TASKSTATS_REPLY_PID,		/* per-pid data cmd response*/
+	TASKSTATS_REPLY_TGID,		/* per-tgid data cmd response*/
+	TASKSTATS_REPLY_EXIT_PID,	/* Exiting task's stats */
+	TASKSTATS_REPLY_EXIT_TGID,	/* Exiting tgid's stats
+					 * (sent on each tid's exit) */
+};
+
+/*
+ * Reply sent from kernel
+ * Version number affects size/format of struct taskstats only
+ */
+
+struct taskstats_reply {
+	/* Maintain 64-bit alignment while extending */
+	__u16 outtype;			/* Must be one of enum outtype */
+	__u16 version;
+	__u32 err;
+	struct taskstats stats;		/* Invalid if err != 0 */
+};
+
+/* NETLINK_GENERIC related info */
+
+#define TASKSTATS_GENL_NAME	"TASKSTATS"
+#define TASKSTATS_GENL_VERSION	0x1
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
diff -puN init/Kconfig~delayacct-genetlink init/Kconfig
--- linux-2.6.16-rc5/init/Kconfig~delayacct-genetlink	2006-03-09 17:15:31.000000000 +0530
+++ linux-2.6.16-rc5-balbir/init/Kconfig	2006-03-09 17:15:31.000000000 +0530
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
--- linux-2.6.16-rc5/kernel/delayacct.c~delayacct-genetlink	2006-03-09 17:15:31.000000000 +0530
+++ linux-2.6.16-rc5-balbir/kernel/delayacct.c	2006-03-09 17:15:31.000000000 +0530
@@ -16,9 +16,12 @@
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
@@ -51,8 +54,14 @@ void __delayacct_tsk_init(struct task_st
 
 void __delayacct_tsk_exit(struct task_struct *tsk)
 {
+	/*
+	 * Protect against racing thread group exits
+	 */
+	mutex_lock(&delayacct_exit_mutex);
+	taskstats_exit_pid(tsk);
 	kmem_cache_free(delayacct_cache, tsk->delays);
 	tsk->delays = NULL;
+	mutex_unlock(&delayacct_exit_mutex);
 }
 
 static inline nsec_t delayacct_measure(void)
@@ -97,3 +106,50 @@ void __delayacct_swapin(void)
 	current->delays->swapin_count++;
 	spin_unlock(&current->delays->lock);
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
diff -puN kernel/Makefile~delayacct-genetlink kernel/Makefile
--- linux-2.6.16-rc5/kernel/Makefile~delayacct-genetlink	2006-03-09 17:15:31.000000000 +0530
+++ linux-2.6.16-rc5-balbir/kernel/Makefile	2006-03-09 17:15:31.000000000 +0530
@@ -35,6 +35,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
+obj-$(CONFIG_TASKSTATS) += taskstats.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -puN /dev/null kernel/taskstats.c
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.16-rc5-balbir/kernel/taskstats.c	2006-03-09 18:52:47.000000000 +0530
@@ -0,0 +1,244 @@
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
+
+static struct genl_family family = {
+	.id             = GENL_ID_GENERATE,
+	.name           = TASKSTATS_GENL_NAME,
+	.version        = TASKSTATS_GENL_VERSION,
+	.hdrsize        = 0,
+	.maxattr        = 0,
+};
+
+/* Taskstat specific functions */
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
+static int send_reply(struct sk_buff *skb, int replytype, pid_t pid, int event)
+{
+	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
+	struct taskstats_reply *reply;
+	int rc;
+
+	reply = (struct taskstats_reply *)genlmsg_data(genlhdr);
+	reply->outtype = replytype;
+
+	rc = genlmsg_end(skb, reply);
+	if (rc < 0) {
+		nlmsg_free(skb);
+		return rc;
+	}
+
+	if (event)
+		return genlmsg_multicast(skb, pid, TASKSTATS_LISTEN_GROUP);
+	else
+		return genlmsg_unicast(skb, pid);
+}
+
+static inline void fill_pid(struct taskstats_reply *reply, pid_t pid,
+			    struct task_struct *pidtsk)
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
+		reply->stats.pid = (s64)tsk->pid;
+		reply->stats.tgid = (s64)tsk->tgid;
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
+	rc = prepare_reply(info, info->genlhdr->cmd, &rep_skb, &reply);
+	if (rc)
+		return rc;
+	fill_pid(reply, param->id.pid, NULL);
+	return send_reply(rep_skb, TASKSTATS_REPLY_PID, info->snd_pid, 0);
+}
+
+static inline void fill_tgid(struct taskstats_reply *reply, pid_t tgid,
+			     struct task_struct *tgidtsk)
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
+		reply->stats.pid = (s64)TASKSTATS_NOPID;
+		reply->stats.tgid = (s64)tgid;
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
+	rc = prepare_reply(info, info->genlhdr->cmd, &rep_skb, &reply);
+	if (rc)
+		return rc;
+	fill_tgid(reply, param->id.tgid, NULL);
+	return send_reply(rep_skb, TASKSTATS_REPLY_TGID, info->snd_pid, 0);
+}
+
+/* Send pid data out on exit */
+void taskstats_exit_pid(struct task_struct *tsk)
+{
+	int rc;
+	struct sk_buff *rep_skb;
+	struct taskstats_reply *reply;
+
+	/*
+	 * tasks can start to exit very early. Ensure that the family
+	 * is registered before notifications are sent out
+	 */
+	if (!family_registered)
+		return;
+
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NONE, &rep_skb, &reply);
+	if (rc)
+		return;
+	fill_pid(reply, tsk->pid, tsk);
+	rc = send_reply(rep_skb, TASKSTATS_REPLY_EXIT_PID, 0, 1);
+
+	if (rc || thread_group_empty(tsk))
+		return;
+
+	/* Send tgid data too */
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NONE, &rep_skb, &reply);
+	if (rc)
+		return;
+	fill_tgid(reply, tsk->tgid, tsk);
+	send_reply(rep_skb, TASKSTATS_REPLY_EXIT_TGID, 0, 1);
+}
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
+static int __init taskstats_init(void)
+{
+	if (genl_register_family(&family))
+		return -EFAULT;
+	family_registered = 1;
+
+	if (genl_register_ops(&family, &pid_ops))
+		goto err;
+	if (genl_register_ops(&family, &tgid_ops))
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
+
diff -puN include/net/genetlink.h~delayacct-genetlink include/net/genetlink.h
--- linux-2.6.16-rc5/include/net/genetlink.h~delayacct-genetlink	2006-03-09 17:15:31.000000000 +0530
+++ linux-2.6.16-rc5-balbir/include/net/genetlink.h	2006-03-09 17:48:39.000000000 +0530
@@ -150,4 +150,24 @@ static inline int genlmsg_unicast(struct
 	return nlmsg_unicast(genl_sock, skb, pid);
 }
 
+/**
+ * gennlmsg_data - head of message payload
+ * @gnlh: genetlink messsage header
+ */
+static inline void *genlmsg_data(const struct genlmsghdr *gnlh)
+{
+	return ((unsigned char *) gnlh + GENL_HDRLEN);
+}
+
+/**
+ * genlmsg_len - length of message payload
+ * @gnlh: genetlink message header
+ */
+static inline int genlmsg_len(const struct genlmsghdr *gnlh)
+{
+	struct nlmsghdr *nlh = (struct nlmsghdr *)((unsigned char *)gnlh -
+						    NLMSG_HDRLEN);
+	return (nlh->nlmsg_len - GENL_HDRLEN - NLMSG_HDRLEN);
+}
+
 #endif	/* __NET_GENERIC_NETLINK_H */
_
