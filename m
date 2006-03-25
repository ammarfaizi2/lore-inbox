Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWCYPg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWCYPg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 10:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWCYPg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 10:36:56 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:60318 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751431AbWCYPgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 10:36:55 -0500
Date: Sat, 25 Mar 2006 21:06:32 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: jamal <hadi@cyberus.ca>
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink interface for delay accounting
Message-ID: <20060325153632.GA25431@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2> <20060322074922.GA1164@in.ibm.com> <1143122686.5186.27.camel@jzny2> <20060323154106.GA13159@in.ibm.com> <1143209061.5076.14.camel@jzny2> <20060324145459.GA7495@in.ibm.com> <1143249565.5184.6.camel@jzny2> <20060325094126.GA9376@in.ibm.com> <1143291133.5184.32.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143291133.5184.32.camel@jzny2>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 07:52:13AM -0500, jamal wrote:
> On Sat, 2006-25-03 at 15:11 +0530, Balbir Singh wrote:
> 
> > 
> > Thanks for the advice, I will dive into nesting. I could not find any 
> > in tree users who use nesting, so I have a few questions
> > 
> 
> Hrm - I have to say i am suprised theres nothing; i could have sworn
> Thomas had done some conversions already.

I used cscope to check for global references and callers of nla_nest_.*.
I could not find anything.

> 
> > nla_nest_start() accepts two parameters an skb and an attribute type.
> > Do I have to create a new attribute type like TASKSTATS_TYPE_AGGR to
> > contain the nested attributes 
> > 
> > TASKSTATS_TYPE_AGGR
> >    TASKSTATS_TYPE_PID/TGID
> >    TASKSTATS_TYPE_STATS
> > 
> >
> > but this will lead to
> > 
> > TASKSTATS_TYPE_AGGR
> >    TASKSTATS_TYPE_PID
> >    TASKSTATS_TYPE_STATS
> > TASKSTATS_TYPE_AGGR
> >    TASKSTATS_TYPE_TGID
> >    TASKSTATS_TYPE_STATS
> > 
> > being returned from taskstats_exit_pid().
> > 
> 
> no this is wrong by virtue of having TASKSTATS_TYPE_AGGR twice.
> Again invoke the rule i cited earlier.

Yes, thats why I wanted to point it out to you. Thanks for explaining the
rule.

> What you could do instead is a second AGGR; and your nesting would be:
> 
> TASKSTATS_TYPE_AGGR1 <--- nest start with this type
>    TASKSTATS_TYPE_PID <-- NLA_U32_PUT
>    TASKSTATS_TYPE_STATS <-- NAL_PUT_TYPE
>                      <-- nest end of TASKSTATS_TYPE_AGGR1
> TASKSTATS_TYPE_AGGR2 <--- nest start with this type
>    TASKSTATS_TYPE_TGID <-- NLA_U32_PUT
>    TASKSTATS_TYPE_STATS <-- NAL_PUT_TYPE
>                        <-- nest end of TASKSTATS_TYPE_AGGR2
> 
> > The other option is to nest
> > 
> > TASKSTATS_TYPE_PID/TGID
> >    TASKSTATS_TYPE_STATS
> > 
> 
> The advantage being you dont introduce another T.
> 
> > but the problem with this approach is, nla_len contains the length of
> > all attributes including the nested attribute. So it is hard to find
> > the offset of TASKSTATS_TYPE_STATS in the buffer.
> > 
> 
> So you would distinguish the two as have something like:
> 
> TASKSTATS_TYPE_PID
>    u32 pid
>    TASKSTATS_TYPE_STATS
> TASKSTATS_TYPE_TGID
>    u32 tgid
>    TASKSTATS_TYPE_STATS
> or
> TASKSTATS_TYPE_PID
>    u32 pid
> TASKSTATS_TYPE_TGID
>    u32 tgid
> 
> both should be fine. The difference between the two is the length in the
> second case will be 4 and in the other case will be larger. 
> 
> But come to think of it, this will introduce unneeded semantics; you
> have very few items to do, so forget it. Go with scheme #1 but change
> the names to TASKSTATS_TYPE_AGGR_PID and TASKSTATS_TYPE_AGGR_TGID.
>

I prefer #1 as well. The overloaded use of the same type with different lengths
can be confusing.
 
> cheers,
> jamal
> 

Here is another attempt (one more iteration) at trying to get it right.
Thank you for your patience and help in getting it right.

Changelog
---------

As discussed in our email.

Thanks,
Balbir

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>

---

 include/linux/delayacct.h |   11 +
 include/linux/taskstats.h |  113 +++++++++++++++++
 init/Kconfig              |   16 ++
 kernel/Makefile           |    1 
 kernel/delayacct.c        |   44 ++++++
 kernel/taskstats.c        |  291 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 473 insertions(+), 3 deletions(-)

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
+++ linux-2.6.16-balbir/include/linux/taskstats.h	2006-03-25 20:56:55.000000000 +0530
@@ -0,0 +1,113 @@
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
+#ifdef __KERNEL__
+
+#include <linux/sched.h>
+
+enum {
+	TASKSTATS_MSG_UNICAST,		/* send data only to requester */
+	TASKSTATS_MSG_MULTICAST,	/* send data to a group */
+};
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
+++ linux-2.6.16-balbir/kernel/delayacct.c	2006-03-25 20:56:55.000000000 +0530
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
+++ linux-2.6.16-balbir/kernel/taskstats.c	2006-03-25 20:57:19.000000000 +0530
@@ -0,0 +1,291 @@
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
+			 void **replyp, size_t size)
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
+				    family.id, 0, 0,
+				    cmd, family.version);
+	} else
+		reply = genlmsg_put(skb, info->snd_pid, info->snd_seq,
+				    family.id, 0, 0,
+				    cmd, family.version);
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
+	int rc = 0;
+	struct sk_buff *rep_skb;
+	struct taskstats stats;
+	void *reply;
+	size_t size;
+	struct nlattr *na;
+
+	/*
+	 * Size includes space for nested attribute as well
+	 * The returned data is of the format
+	 * TASKSTATS_TYPE_AGGR_PID/TGID
+	 * --> TASKSTATS_TYPE_PID/TGID
+	 * --> TASKSTATS_TYPE_STATS
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
+		rc = fill_pid((pid_t)pid, NULL, &stats);
+		if (rc < 0)
+			goto err;
+
+		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
+		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, pid);
+	} else if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
+		u32 tgid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_TGID]);
+		rc = fill_tgid((pid_t)tgid, NULL, &stats);
+		if (rc < 0)
+			goto err;
+
+		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
+		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, tgid);
+	} else {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
+	nla_nest_end(rep_skb, na);
+
+	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST);
+
+nla_put_failure:
+	return  genlmsg_cancel(rep_skb, reply);
+err:
+	nlmsg_free(rep_skb);
+	return rc;
+}
+
+
+/* Send pid data out on exit */
+void taskstats_exit_pid(struct task_struct *tsk)
+{
+	int rc = 0;
+	struct sk_buff *rep_skb;
+	void *reply;
+	struct taskstats stats;
+	size_t size;
+	int is_thread_group = !thread_group_empty(tsk);
+	struct nlattr *na;
+
+	/*
+	 * tasks can start to exit very early. Ensure that the family
+	 * is registered before notifications are sent out
+	 */
+	if (!family_registered)
+		return;
+
+	/*
+	 * Size includes space for nested attributes
+	 */
+	size = nla_total_size(sizeof(u32)) +
+		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
+
+	if (is_thread_group)
+		size = 2 * size;	// PID + STATS + TGID + STATS
+
+	memset(&stats, 0, sizeof(stats));
+	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
+	if (rc < 0)
+		return;
+
+	rc = fill_pid(tsk->pid, tsk, &stats);
+	if (rc < 0)
+		goto err;
+
+	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
+	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, (u32)tsk->pid);
+	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
+	nla_nest_end(rep_skb, na);
+
+	if (!is_thread_group) {
+		send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+		return;
+	}
+
+	memset(&stats, 0, sizeof(stats));
+	rc = fill_tgid(tsk->tgid, tsk, &stats);
+	if (rc < 0)
+		goto err;
+
+	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
+	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, (u32)tsk->tgid);
+	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
+	nla_nest_end(rep_skb, na);
+
+	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+
+nla_put_failure:
+	genlmsg_cancel(rep_skb, reply);
+	return;
+err:
+	nlmsg_free(rep_skb);
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
