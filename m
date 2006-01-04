Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWADTEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWADTEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWADTEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:04:47 -0500
Received: from c-67-180-166-85.hsd1.ca.comcast.net ([67.180.166.85]:8896 "EHLO
	mtv-vpn-hw-jlan-2.corp.sgi.com") by vger.kernel.org with ESMTP
	id S1750877AbWADTEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:04:46 -0500
Message-ID: <43BC1C43.9020101@engr.sgi.com>
Date: Wed, 04 Jan 2006 11:04:35 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Patch 6/6] Delay accounting: Connector interface
References: <43BB05D8.6070101@watson.ibm.com> <43BB09D4.2060209@watson.ibm.com>
In-Reply-To: <43BB09D4.2060209@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
>Changes since 11/14/05:
>
>- explicit versioning of statistics data returned
>- new command type for returning per-tgid stats
>- for cpu running time, use tsk->sched_info.cpu_time (collected by schedstats)
>
>First post 11/14/05
>
>delayacct-connector.patch
>
>Creates a connector interface for getting delay and cpu statistics of tasks
>during their lifetime and when they exit. The cpu stats are available only if
>CONFIG_SCHEDSTATS is enabled.
>
>When a task is alive, userspace can get its stats by sending a command
>containing its pid. Sending a tgid returns the sum of stats of the tasks
>belonging to that tgid (where such a sum makes sense). Together, the command
>interface allows stats for a large number of tasks to be collected more
>efficiently than would be possible through /proc or any per-pid interface.
>
>The connector interface also sends the stats for each task to userspace when
>the task is exiting. This permits fine-grain accounting for short-lived tasks,
>which is important if userspace is doing its own aggregation of statistics
>based on some grouping of tasks (e.g. CSA jobs, ELSA banks or CKRM classes).
>
>While this patch is included as part of the delay stats collection patches,
>it is intended for general use by any kernel component that needs per-pid/tgid
>stats sent at task exit. This limits the increase in connectors called on task
>exit, atleast for stats collection purposes.
>
>Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
>
> drivers/connector/Kconfig    |    9 +
> drivers/connector/Makefile   |    1
> drivers/connector/cn_stats.c |  243 +++++++++++++++++++++++++++++++++++++++++++
> include/linux/cn_stats.h     |  115 ++++++++++++++++++++
> include/linux/connector.h    |    4
> kernel/exit.c                |    2
> 6 files changed, 374 insertions(+)
>
>Index: linux-2.6.15-rc7/drivers/connector/Kconfig
>===================================================================
>--- linux-2.6.15-rc7.orig/drivers/connector/Kconfig
>+++ linux-2.6.15-rc7/drivers/connector/Kconfig
>@@ -18,4 +18,13 @@ config PROC_EVENTS
> 	  Provide a connector that reports process events to userspace. Send
> 	  events such as fork, exec, id change (uid, gid, suid, etc), and exit.
>
>+config STATS_CONNECTOR
>+	bool "Report per-task statistics to userspace"
>+	depends on CONNECTOR=y && TASK_DELAY_ACCT
>+	---help---
>+	  Provide a connector interface that reports per-task statistics to
>+	  userspace. While a task is running, userspace can get the stats by
>+	  sending a command to the connector. At task exit, the final value of
>+	  the stats is sent automatically.
>+
> endmenu
>Index: linux-2.6.15-rc7/drivers/connector/Makefile
>===================================================================
>--- linux-2.6.15-rc7.orig/drivers/connector/Makefile
>+++ linux-2.6.15-rc7/drivers/connector/Makefile
>@@ -1,4 +1,5 @@
> obj-$(CONFIG_CONNECTOR)		+= cn.o
>+obj-$(CONFIG_STATS_CONNECTOR)	+= cn_stats.o
> obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
>
> cn-y				+= cn_queue.o connector.o
>Index: linux-2.6.15-rc7/include/linux/cn_stats.h
>===================================================================
>--- /dev/null
>+++ linux-2.6.15-rc7/include/linux/cn_stats.h
>@@ -0,0 +1,115 @@
>+/*
>+ * cn_stats.h - Task statistics connector
>+ *
>+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
>+ * Based on work by Matt Helsley, Nguyen Anh Quynh and Guillaume Thouvenin
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License as published by
>+ * the Free Software Foundation; either version 2 of the License, or
>+ * (at your option) any later version.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ */
>+
>+#ifndef CN_STATS_H
>+#define CN_STATS_H
>+
>+#include <linux/types.h>
>+#include <linux/connector.h>
>+
>+
>+/* Format for per-task data returned to userland when
>+ *	- a task exits
>+ *	- listener requests stats for all tasks
>+ *
>+ * The struct is versioned. Newer versions should only add fields to
>+ * the bottom of the struct to maintain backward compatibility.
>+ *
>+ * To create the next version, bump up the version count macro
>+ * and delineate the start of newly added fields with a comment indicating the
>+ * version number.
>+ */
>+#define CNSTATS_DATA_VERSION	1
>+
>+struct cnstats_data {
>+
>+	/* Version 1 */
>+	pid_t	pid;
>+	pid_t	tgid;
>+
>+	/* *_delay_total is cumulative delay (in nanosecs) of a
>+	 * task waiting for cpu to be available, block io
>+	 * completion, page fault to be serviced etc.
>+	 * *_count is number of delay intervals recorded.
>+	 * cpu_run_total is cumulative cpu run time, measured by timestamp
>+	 * intervals and hence more accurate than sampling-based cpu times.
>+	 * All *_total values are in nanoseconds though cpu data may not be
>+	 * collected at that granularity.
>+	 */
>+
>+	__u64	cpu_count;
>+#define CNSTATS_NOCPUSTATS	1
>+	__u64	cpu_run_total;
>+	__u64	cpu_delay_total;
>+
>+	__u64	blkio_count;
>+	__u64	blkio_delay_total;
>+	__u64	swapin_count;
>+	__u64	swapin_delay_total;
>+
>+};
>+
>+
>+/*
>+ * Commands sent from userspace
>+ */
>+
>+struct cnstats_cmd {
>+	enum intype {
>+		CNSTATS_CMD_LISTEN = 1,	/* Start listening on connector */
>+		CNSTATS_CMD_IGNORE,	/* Stop listening */
>+		CNSTATS_CMD_STATS_PID,	/* Stats for a pid */
>+		CNSTATS_CMD_STATS_TGID,	/* Stats for a tgid */
>+	} intype;
>+
>+	union {
>+		pid_t	pid;
>+		pid_t	tgid;
>+	} param;
>+};
>+
>+/*
>+ * Response or data sent from kernel
>+ * Versioned for backward compatibility
>+ */
>+
>+struct cnstats {
>+	__u32 version;
>+	enum outtype {
>+		CNSTATS_DATA_NONE = 1,		/* Control cmd response */
>+		CNSTATS_DATA_EXIT,		/* Exiting task's stats */
>+		CNSTATS_DATA_PID,		/* per-pid data cmd response*/
>+		CNSTATS_DATA_TGID,		/* per-tgid data cmd response*/
>+	} outtype;
>+	union {
>+		struct cnstats_ack {
>+			__u32 err;
>+		} ack;
>+
>+		struct cnstats_data stats;
>+	} data;
>+};
>+
>+#ifdef __KERNEL__
>+#ifdef CONFIG_STATS_CONNECTOR
>+void cnstats_exit_connector(struct task_struct *tsk);
>+#else
>+static inline void cnstats_exit_connector(struct task_struct *tsk)
>+{}
>+#endif	/* CONFIG_STATS_CONNECTOR */
>+#endif	/* __KERNEL__ */
>+#endif	/* CN_PROC_H */
>Index: linux-2.6.15-rc7/include/linux/connector.h
>===================================================================
>--- linux-2.6.15-rc7.orig/include/linux/connector.h
>+++ linux-2.6.15-rc7/include/linux/connector.h
>@@ -35,6 +35,10 @@
> #define CN_IDX_CIFS			0x2
> #define CN_VAL_CIFS                     0x1
>
>+/* Statistics connector ids */
>+#define CN_IDX_STATS			0x2
>+#define CN_VAL_STATS			0x2
>+
> #define CN_NETLINK_USERS		1
>
> /*
>Index: linux-2.6.15-rc7/drivers/connector/cn_stats.c
>===================================================================
>--- /dev/null
>+++ linux-2.6.15-rc7/drivers/connector/cn_stats.c
>@@ -0,0 +1,243 @@
>+/*
>+ * cn_stats.c - Task statistics connector
>  

It looks like you create this file to report task stats through connector
and you include stats for delay accounting you need as a starter.

This sounds like a good approach to me. However, we need to move
where cnstats_exit_connector(tsk) is invoked. See below.
>+ *
>+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
>+ * Based on work by Matt Helsley, Nguyen Anh Quynh and Guillaume Thouvenin
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License as published by
>+ * the Free Software Foundation; either version 2 of the License, or
>+ * (at your option) any later version.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ *
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/kernel.h>
>+#include <linux/init.h>
>+#include <linux/cn_stats.h>
>+#include <asm/atomic.h>
>+
>+#define CN_STATS_NOCPU	(-1)
>+#define CN_STATS_NOACK	0
>+#define CN_STATS_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct cnstats))
>+
>+static atomic_t cnstats_num_listeners = ATOMIC_INIT(0);
>+static struct cb_id cnstats_id = { CN_IDX_STATS, CN_VAL_STATS };
>+/* cnstats_counts is used as the sequence number of the netlink message */
>+static DEFINE_PER_CPU(__u32, cnstats_counts) = { 0 };
>+
>+void cnstats_init_msg(struct cn_msg *msg, int seq, int ack)
>+{
>+	memset(msg, 0, CN_STATS_MSG_SIZE);
>+	msg->seq = seq;
>+	msg->ack = ack;
>+	memcpy(&msg->id, &cnstats_id, sizeof(msg->id));
>+	msg->len = sizeof(struct cnstats);
>+}
>+
>+/*
>+ * Accumalate one task's statistics
>+ *
>+ */
>+static inline void cnstats_add_tsk_data(struct cnstats_data *d, struct task_struct *tsk)
>+{
>+	uint64_t tmp;
>+
>+	d->pid = tsk->pid;
>+	d->tgid = tsk->tgid;
>+
>+	/* zero XXX_total,non-zero XXX_count implies XXX stat overflowed */
>+#ifdef CONFIG_SCHEDSTATS
>+	d->cpu_count += tsk->sched_info.pcnt;
>+	tmp = d->cpu_run_total + jiffies_to_usecs(tsk->sched_info.cpu_time)*1000;
>+	d->cpu_run_total = (tmp < d->cpu_run_total)? 0:tmp;
>+	tmp = d->cpu_delay_total + jiffies_to_usecs(tsk->sched_info.run_delay)*1000;
>+	d->cpu_delay_total = (tmp < d->cpu_delay_total)? 0:tmp;
>+#else
>+	/* Non-zero XXX_total,zero XXX_count implies XXX stat unavailable */
>+	d->cpu_count = 0;
>+	d->cpu_run_total = d->cpu_delay_total = CNSTATS_NOCPUSTATS;
>+#endif
>+	spin_lock(&tsk->delays.lock);
>+	tmp = d->blkio_delay_total + tsk->delays.blkio_delay;
>+	d->blkio_delay_total = (tmp < d->blkio_delay_total)? 0:tmp;
>+	tmp = d->swapin_delay_total + tsk->delays.swapin_delay;
>+	d->swapin_delay_total = (tmp < d->swapin_delay_total)? 0:tmp;
>+	d->blkio_count += tsk->delays.blkio_count;
>+	d->swapin_count += tsk->delays.swapin_count;
>+	spin_unlock(&tsk->delays.lock);
>+}
>+
>+/*
>+ * Send acknowledgement (error)
>+ *
>+ */
>+static void cnstats_send_ack(int err, int rcvd_seq, int rcvd_ack)
>+{
>+	__u8 buffer[CN_STATS_MSG_SIZE];
>+	struct cn_msg *msg = (struct cn_msg *)buffer;
>+	struct cnstats *c = (struct cnstats *)msg->data;
>+
>+	cnstats_init_msg(msg, rcvd_seq, rcvd_ack+1);
>+	c->version = CNSTATS_DATA_VERSION;
>+	c->outtype = CNSTATS_DATA_NONE;
>+
>+	/* Following allows other functions to continue returning -ve errors */
>+	c->data.ack.err = abs(err);
>+
>+	cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
>+}
>+
>+/*
>+ * Send one pid's stats
>+ *
>+ */
>+static int cnstats_send_pid(pid_t pid, int seq, int ack)
>+{
>+	__u8 buffer[CN_STATS_MSG_SIZE];
>+	struct cn_msg *msg = (struct cn_msg *)buffer;
>+	struct cnstats *c = (struct cnstats *)msg->data;
>+	struct cnstats_data *d = (struct cnstats_data *)&c->data.stats;
>+	struct task_struct *tsk;
>+
>+	cnstats_init_msg(msg, seq, ack);
>+	c->version = CNSTATS_DATA_VERSION;
>+	c->outtype = CNSTATS_DATA_PID;
>+
>+	read_lock(&tasklist_lock);
>+	tsk = find_task_by_pid(pid);
>+	if (!tsk) {
>+		read_unlock(&tasklist_lock);
>+		return -ESRCH;
>+	}
>+	get_task_struct(tsk);
>+	read_unlock(&tasklist_lock);
>+
>+	cnstats_add_tsk_data(d, tsk);
>+	put_task_struct(tsk);
>+
>+	return cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
>+}
>+
>+/*
>+ * Send one tgid's stats (sum of appropriate per-pid stats)
>+ *
>+ */
>+static int cnstats_send_tgid(pid_t tgid, int seq, int ack)
>+{
>+	__u8 buffer[CN_STATS_MSG_SIZE];
>+	struct cn_msg *msg = (struct cn_msg *)buffer;;
>+	struct cnstats *c = (struct cnstats *)msg->data;
>+	struct cnstats_data *d = (struct cnstats_data *)&c->data.stats;
>+	struct task_struct *first, *tsk;
>+
>+	cnstats_init_msg(msg, seq, ack);
>+	c->version = CNSTATS_DATA_VERSION;
>+	c->outtype = CNSTATS_DATA_TGID;
>+
>+	read_lock(&tasklist_lock);
>+	first = tsk = find_task_by_pid(tgid);
>+	if (!first) {
>+		read_unlock(&tasklist_lock);
>+		return -ESRCH;
>+	}
>+	do
>+		cnstats_add_tsk_data(d, tsk);
>+	while_each_thread(first, tsk);
>+	read_unlock(&tasklist_lock);
>+
>+	d->pid = -1;
>+	d->tgid = tgid;
>+
>+	return cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
>+}
>+
>+/***
>+ * cnstats_ctl - handle command sent via CN_IDX_STATS connector
>+ * @data: command
>+ */
>+static void cnstats_ctl(void *data)
>+{
>+	struct cn_msg *msg = data;
>+	struct cnstats_cmd *cmd;
>+	int err = 0;
>+
>+	if (msg->len != sizeof(*cmd))
>+		return;
>+
>+	cmd = (struct cnstats_cmd *)msg->data;
>+	switch (cmd->intype) {
>+	case CNSTATS_CMD_LISTEN:
>+		atomic_inc(&cnstats_num_listeners);
>+		break;
>+
>+	case CNSTATS_CMD_IGNORE:
>+		atomic_dec(&cnstats_num_listeners);
>+		break;
>+
>+	case CNSTATS_CMD_STATS_PID:
>+		if (atomic_read(&cnstats_num_listeners) < 1)
>+			return;
>+		err = cnstats_send_pid(cmd->param.pid, msg->seq, msg->ack+1);
>+		if (!err)
>+			return;
>+		break;
>+
>+	case CNSTATS_CMD_STATS_TGID:
>+		if (atomic_read(&cnstats_num_listeners) < 1)
>+			return;
>+		err = cnstats_send_tgid(cmd->param.pid, msg->seq, msg->ack+1);
>+		if (!err)
>+			return;
>+		break;
>+
>+	default:
>+		err = -EINVAL;
>+		break;
>+	}
>+	cnstats_send_ack(err, msg->seq, msg->ack);
>+}
>+
>+/***
>+ * cnstats_exit_connector - send task's statistics to userspace when it exits
>+ * @tsk: exiting task
>+ */
>+void cnstats_exit_connector(struct task_struct *tsk)
>+{
>+	int seq;
>+	__u8 buffer[CN_STATS_MSG_SIZE];
>+	struct cn_msg *msg = (struct cn_msg *)buffer;
>+	struct cnstats *c = (struct cnstats *)msg->data;
>+	struct cnstats_data *d = (struct cnstats_data *)&c->data.stats;
>+
>+	if (atomic_read(&cnstats_num_listeners) < 1)
>+		return;
>+
>+	seq = get_cpu_var(cnstats_counts)++;
>+	put_cpu_var(cnstats_counts);
>+
>+	cnstats_init_msg(msg, seq, CN_STATS_NOACK);
>+	c->version = CNSTATS_DATA_VERSION;
>+	c->outtype = CNSTATS_DATA_EXIT;
>+	cnstats_add_tsk_data(d, tsk);
>+
>+	cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
>+}
>+
>+static int __init cnstats_init(void)
>+{
>+	int err;
>+
>+	if ((err = cn_add_callback(&cnstats_id, "cn_stats", &cnstats_ctl))) {
>+		printk(KERN_WARNING "cn_stats failed to register\n");
>+		return err;
>+	}
>+	return 0;
>+}
>+
>+module_init(cnstats_init);
>Index: linux-2.6.15-rc7/kernel/exit.c
>===================================================================
>--- linux-2.6.15-rc7.orig/kernel/exit.c
>+++ linux-2.6.15-rc7/kernel/exit.c
>@@ -29,6 +29,7 @@
> #include <linux/syscalls.h>
> #include <linux/signal.h>
> #include <linux/cn_proc.h>
>+#include <linux/cn_stats.h>
>
> #include <asm/uaccess.h>
> #include <asm/unistd.h>
>@@ -865,6 +866,7 @@ fastcall NORET_TYPE void do_exit(long co
>
> 	tsk->exit_code = code;
> 	proc_exit_connector(tsk);
>+	cnstats_exit_connector(tsk);
>  

We need to move both proc_exit_connector(tsk) and
cnstats_exit_connector(tsk) up to before exit_mm(tsk) statement.
There are task statistics collected in task->mm and those stats
will be lost after exit_mm(tsk).

Thanks,
 - jay

> 	exit_notify(tsk);
> #ifdef CONFIG_NUMA
> 	mpol_free(tsk->mempolicy);
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  

