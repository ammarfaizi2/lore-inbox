Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWCNA4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWCNA4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWCNA4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:56:41 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:61081 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932523AbWCNA4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:56:39 -0500
Subject: [Patch 9/9] Generic netlink interface for delay accounting
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jamal <hadi@cyberus.ca>, netdev <netdev@vger.kernel.org>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142297791.5858.31.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:56:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-genetlink.patch

Create a generic netlink interface (NETLINK_GENERIC family), 
called "taskstats", for getting delay and cpu statistics of 
tasks and thread groups during their lifetime and when they exit. 

Comments addressed (all in response to Jamal)

- Eliminated TASKSTATS_CMD_LISTEN and TASKSTATS_CMD_IGNORE
- Use multicast only for events generated due to task exit, not for 
replies to commands
- Align taskstats and taskstats_reply structures to 64 bit aligned.
- Use dynamic ID generation for genetlink family

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

 include/linux/taskstats.h |  128 ++++++++++++++++++++++++
 init/Kconfig              |   16 ++-
 kernel/taskstats.c        |  244 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc5/include/linux/taskstats.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc5/include/linux/taskstats.h	2006-03-13 19:01:35.000000000 -0500
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
+ *     - a task exits
+ *     - listener requests stats for a task
+ *
+ * The struct is versioned. Newer versions should only add fields to
+ * the bottom of the struct to maintain backward compatibility.
+ *
+ * To create the next version, bump up the taskstats_version variable
+ * and delineate the start of newly added fields with a comment indicating
+ * the version number.
+ */
+
+#define TASKSTATS_VERSION      1
+
+struct taskstats {
+       /* Maintain 64-bit alignment while extending */
+
+       /* Version 1 */
+#define TASKSTATS_NOPID        -1
+       __s64   pid;
+       __s64   tgid;
+
+       /* XXX_count is number of delay values recorded.
+        * XXX_total is corresponding cumulative delay in nanoseconds
+        */
+
+#define TASKSTATS_NOCPUSTATS   1
+       __u64   cpu_count;
+       __u64   cpu_delay_total;        /* wait, while runnable, for cpu */
+       __u64   blkio_count;
+       __u64   blkio_delay_total;      /* sync,block io completion wait*/
+       __u64   swapin_count;
+       __u64   swapin_delay_total;     /* swapin page fault wait*/
+
+       __u64   cpu_run_total;          /* cpu running time
+                                        * no count available/provided */
+};
+
+
+#define TASKSTATS_LISTEN_GROUP 0x1
+
+/*
+ * Commands sent from userspace
+ * Not versioned. New commands should only be inserted at the enum's end
+ */
+
+enum {
+       TASKSTATS_CMD_UNSPEC,           /* Reserved */
+       TASKSTATS_CMD_NONE,             /* Not a valid cmd to send
+                                        * Marks data sent on task/tgid exit */
+       TASKSTATS_CMD_LISTEN,           /* Start listening */
+       TASKSTATS_CMD_IGNORE,           /* Stop listening */
+       TASKSTATS_CMD_PID,              /* Send stats for a pid */
+       TASKSTATS_CMD_TGID,             /* Send stats for a tgid */
+};
+
+/* Parameters for commands
+ * New parameters should only be inserted at the struct's end
+ */
+
+struct taskstats_cmd_param {
+       /* Maintain 64-bit alignment while extending */
+       union {
+               __s64   pid;
+               __s64   tgid;
+       } id;
+};
+
+enum outtype {
+       TASKSTATS_REPLY_NONE = 1,       /* Control cmd response */
+       TASKSTATS_REPLY_PID,            /* per-pid data cmd response*/
+       TASKSTATS_REPLY_TGID,           /* per-tgid data cmd response*/
+       TASKSTATS_REPLY_EXIT_PID,       /* Exiting task's stats */
+       TASKSTATS_REPLY_EXIT_TGID,      /* Exiting tgid's stats
+                                        * (sent on each tid's exit) */
+};
+
+/*
+ * Reply sent from kernel
+ * Version number affects size/format of struct taskstats only
+ */
+
+struct taskstats_reply {
+       /* Maintain 64-bit alignment while extending */
+       __u16 outtype;                  /* Must be one of enum outtype */
+       __u16 version;
+       __u32 err;
+       struct taskstats stats;         /* Invalid if err != 0 */
+};
+
+/* NETLINK_GENERIC related info */
+
+#define TASKSTATS_GENL_NAME    "TASKSTATS"
+#define TASKSTATS_GENL_VERSION 0x1
+
+#define TASKSTATS_HDRLEN       (NLMSG_SPACE(GENL_HDRLEN))
+#define TASKSTATS_BODYLEN      (sizeof(struct taskstats_reply))
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
Index: linux-2.6.16-rc5/kernel/taskstats.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc5/kernel/taskstats.c	2006-03-13 19:01:35.000000000 -0500
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
+       .id             = GENL_ID_GENERATE,
+       .name           = TASKSTATS_GENL_NAME,
+       .version        = TASKSTATS_GENL_VERSION,
+       .hdrsize        = 0,
+       .maxattr        = 0,
+};
+
+/* Taskstat specific functions */
+static int prepare_reply(struct genl_info *info, u8 cmd,
+                        struct sk_buff **skbp, struct taskstats_reply **replyp)
+{
+       struct sk_buff *skb;
+       struct taskstats_reply *reply;
+
+       skb = nlmsg_new(TASKSTATS_HDRLEN + TASKSTATS_BODYLEN);
+       if (!skb)
+               return -ENOMEM;
+
+       if (!info) {
+               int seq = get_cpu_var(taskstats_seqnum)++;
+               put_cpu_var(taskstats_seqnum);
+
+               reply = genlmsg_put(skb, 0, seq,
+                                   family.id, 0, NLM_F_REQUEST,
+                                   cmd, family.version);
+       } else
+               reply = genlmsg_put(skb, info->snd_pid, info->snd_seq,
+                                   family.id, 0, info->nlhdr->nlmsg_flags,
+                                   info->genlhdr->cmd, family.version);
+       if (reply == NULL) {
+               nlmsg_free(skb);
+               return -EINVAL;
+       }
+       skb_put(skb, TASKSTATS_BODYLEN);
+
+       memset(reply, 0, sizeof(*reply));
+       reply->version = taskstats_version;
+       reply->err = 0;
+
+       *skbp = skb;
+       *replyp = reply;
+       return 0;
+}
+
+static int send_reply(struct sk_buff *skb, int replytype, pid_t pid, int event)
+{
+       struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
+       struct taskstats_reply *reply;
+       int rc;
+
+       reply = (struct taskstats_reply *)genlmsg_data(genlhdr);
+       reply->outtype = replytype;
+
+       rc = genlmsg_end(skb, reply);
+       if (rc < 0) {
+               nlmsg_free(skb);
+               return rc;
+       }
+
+       if (event)
+               return genlmsg_multicast(skb, pid, TASKSTATS_LISTEN_GROUP);
+       else
+               return genlmsg_unicast(skb, pid);
+}
+
+static inline void fill_pid(struct taskstats_reply *reply, pid_t pid,
+                           struct task_struct *pidtsk)
+{
+       int rc;
+       struct task_struct *tsk = pidtsk;
+
+       if (!pidtsk) {
+               read_lock(&tasklist_lock);
+               tsk = find_task_by_pid(pid);
+               if (!tsk) {
+                       read_unlock(&tasklist_lock);
+                       reply->err = EINVAL;
+                       return;
+               }
+               get_task_struct(tsk);
+               read_unlock(&tasklist_lock);
+       } else
+               get_task_struct(tsk);
+
+       rc = delayacct_add_tsk(reply, tsk);
+       if (!rc) {
+               reply->stats.pid = (s64)tsk->pid;
+               reply->stats.tgid = (s64)tsk->tgid;
+       } else
+               reply->err = (rc < 0) ? -rc : rc ;
+
+       put_task_struct(tsk);
+}
+
+static int taskstats_send_pid(struct sk_buff *skb, struct genl_info *info)
+{
+       int rc;
+       struct sk_buff *rep_skb;
+       struct taskstats_reply *reply;
+       struct taskstats_cmd_param *param= info->userhdr;
+
+       rc = prepare_reply(info, info->genlhdr->cmd, &rep_skb, &reply);
+       if (rc)
+               return rc;
+       fill_pid(reply, param->id.pid, NULL);
+       return send_reply(rep_skb, TASKSTATS_REPLY_PID, info->snd_pid, 0);
+}
+
+static inline void fill_tgid(struct taskstats_reply *reply, pid_t tgid,
+                            struct task_struct *tgidtsk)
+{
+       int rc;
+       struct task_struct *tsk, *first;
+
+       first = tgidtsk;
+       read_lock(&tasklist_lock);
+       if (!first) {
+               first = find_task_by_pid(tgid);
+               if (!first) {
+                       read_unlock(&tasklist_lock);
+                       reply->err = EINVAL;
+                       return;
+               }
+       }
+       tsk = first;
+       do {
+               rc = delayacct_add_tsk(reply, tsk);
+               if (rc)
+                       break;
+       } while_each_thread(first, tsk);
+       read_unlock(&tasklist_lock);
+
+       if (!rc) {
+               reply->stats.pid = (s64)TASKSTATS_NOPID;
+               reply->stats.tgid = (s64)tgid;
+       } else
+               reply->err = (rc < 0) ? -rc : rc ;
+}
+
+static int taskstats_send_tgid(struct sk_buff *skb, struct genl_info *info)
+{
+       int rc;
+       struct sk_buff *rep_skb;
+       struct taskstats_reply *reply;
+       struct taskstats_cmd_param *param= info->userhdr;
+
+       rc = prepare_reply(info, info->genlhdr->cmd, &rep_skb, &reply);
+       if (rc)
+               return rc;
+       fill_tgid(reply, param->id.tgid, NULL);
+       return send_reply(rep_skb, TASKSTATS_REPLY_TGID, info->snd_pid, 0);
+}
+
+/* Send pid data out on exit */
+void taskstats_exit_pid(struct task_struct *tsk)
+{
+       int rc;
+       struct sk_buff *rep_skb;
+       struct taskstats_reply *reply;
+
+       /*
+        * tasks can start to exit very early. Ensure that the family
+        * is registered before notifications are sent out
+        */
+       if (!family_registered)
+               return;
+
+       rc = prepare_reply(NULL, TASKSTATS_CMD_NONE, &rep_skb, &reply);
+       if (rc)
+               return;
+       fill_pid(reply, tsk->pid, tsk);
+       rc = send_reply(rep_skb, TASKSTATS_REPLY_EXIT_PID, 0, 1);
+
+       if (rc || thread_group_empty(tsk))
+               return;
+
+       /* Send tgid data too */
+       rc = prepare_reply(NULL, TASKSTATS_CMD_NONE, &rep_skb, &reply);
+       if (rc)
+               return;
+       fill_tgid(reply, tsk->tgid, tsk);
+       send_reply(rep_skb, TASKSTATS_REPLY_EXIT_TGID, 0, 1);
+}
+
+static struct genl_ops pid_ops = {
+       .cmd            = TASKSTATS_CMD_PID,
+       .doit           = taskstats_send_pid,
+};
+
+static struct genl_ops tgid_ops = {
+       .cmd            = TASKSTATS_CMD_TGID,
+       .doit           = taskstats_send_tgid,
+};
+
+static int __init taskstats_init(void)
+{
+       if (genl_register_family(&family))
+               return -EFAULT;
+       family_registered = 1;
+
+       if (genl_register_ops(&family, &pid_ops))
+               goto err;
+       if (genl_register_ops(&family, &tgid_ops))
+               goto err;
+
+       return 0;
+err:
+       genl_unregister_family(&family);
+       family_registered = 0;
+       return -EFAULT;
+}
+
+late_initcall(taskstats_init);
+
Index: linux-2.6.16-rc5/init/Kconfig
===================================================================
--- linux-2.6.16-rc5.orig/init/Kconfig	2006-03-13 18:51:30.000000000 -0500
+++ linux-2.6.16-rc5/init/Kconfig	2006-03-13 19:04:52.000000000 -0500
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


