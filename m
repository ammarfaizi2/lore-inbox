Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVKODbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVKODbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVKODbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:31:15 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:41184 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932354AbVKODbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:31:08 -0500
Message-ID: <437965AC.5010509@watson.ibm.com>
Date: Mon, 14 Nov 2005 23:35:56 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 4/4] Delay accounting: Connector interface
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-connector.patch

Creates a connector interface for getting delay and cpu statistics of tasks
during their lifetime and when they exit. The cpu stats are available only if
CONFIG_SCHEDSTATS is enabled.

Userspace can send commands containing a pid and receive the corresponding
task's statistics during its lifetime. After a task exits, its final stats
are sent to userspace. This last feature is the primary motivation,
besides efficiency, for the connector interface being preferred over
a /proc interface.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 drivers/connector/Kconfig    |    9 +
 drivers/connector/Makefile   |    1
 drivers/connector/cn_stats.c |  199 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/cn_stats.h     |  105 ++++++++++++++++++++++
 include/linux/connector.h    |    4
 kernel/exit.c                |    2
 6 files changed, 320 insertions(+)

Index: linux-2.6.14/drivers/connector/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/connector/Kconfig
+++ linux-2.6.14/drivers/connector/Kconfig
@@ -10,4 +10,13 @@ config CONNECTOR
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.

+config STATS_CONNECTOR
+	bool "Report per-task delay statistics to userspace"
+	depends on CONNECTOR=y && DELAY_ACCT
+	---help---
+	  Provide a connector interface that reports per-task statistics to
+	  userspace. While a task is running, userspace can get the stats by
+	  sending a command to the connector. At task exit, the final value of
+	  the stats is sent automatically.
+
 endmenu
Index: linux-2.6.14/drivers/connector/Makefile
===================================================================
--- linux-2.6.14.orig/drivers/connector/Makefile
+++ linux-2.6.14/drivers/connector/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
+obj-$(CONFIG_STATS_CONNECTOR)	+= cn_stats.o

 cn-y				+= cn_queue.o connector.o
Index: linux-2.6.14/include/linux/cn_stats.h
===================================================================
--- /dev/null
+++ linux-2.6.14/include/linux/cn_stats.h
@@ -0,0 +1,105 @@
+/*
+ * cn_stats.h - Task statistics connector
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
+ * Based on work by Matt Helsley, Nguyen Anh Quynh and Guillaume Thouvenin
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
+ */
+
+#ifndef CN_STATS_H
+#define CN_STATS_H
+
+#include <linux/types.h>
+#include <linux/connector.h>
+
+/*
+ * Commands sent from userspace
+ */
+
+struct cnstats_cmd {
+	/* In future, userspace could supply a tgid instead */
+	enum intype {
+		CNSTATS_CMD_LISTEN = 1,	/* Start listening on connector */
+		CNSTATS_CMD_IGNORE,	/* Stop listening */
+		CNSTATS_CMD_DELAY_V1,	/* Get delay stats for a pid */
+	} intype;
+
+	union {
+		pid_t	pid;
+	} param;
+};
+
+/*
+ * Response or data sent from kernel
+ * Versioned for backward compatibility
+ */
+
+struct cnstats {
+	enum what {
+		CNSTATS_DATA_NONE = 1,		/* Response to control cmd */
+		CNSTATS_DATA_DELAY_V1		/* Delay stats version 1 */
+	} what;
+	__u32 cpu;	/* Helps in sequencing */
+	union {
+		struct cnstats_ack {
+			__u32 err;
+		} ack;
+
+		struct cnstats_delay_v1 {
+			pid_t	pid;
+			pid_t	tgid;
+
+			/* *_delay_total is cumulative delay (in nanosecs) of a
+			 * task waiting for cpu to be available, block io
+			 * completion, page fault to be serviced etc.
+			 * *_count is number of delay intervals recorded.
+			 * cpu_running is an exact measure of cpu run time.
+			 * *_delay, cpu_running are in nanosecs.
+			 */
+
+			__u32	cpu_count;
+			__u64	cpu_run_total;
+#define CNSTATS_NOCPUDELAY	0xffffffff
+			__u64	cpu_delay_total;
+
+			__u32	blkio_count;
+			__u64	blkio_delay_total;
+			__u32	pgflt_count;
+			__u64	pgflt_delay_total;
+		} delay_v1;
+
+	} data;
+};
+
+#ifdef __KERNEL__
+#ifdef CONFIG_STATS_CONNECTOR
+void cnstats_exit_connector(struct task_struct *tsk);
+
+static inline void cnstats_get_cpu_delays(struct task_struct *tsk, struct cnstats_delay_v1 *d)
+{
+	d->cpu_run_total = current_sched_time(tsk);
+#ifdef CONFIG_SCHEDSTATS
+	d->cpu_count = tsk->sched_info.pcnt;
+	d->cpu_delay_total = jiffies_to_usecs(tsk->sched_info.run_delay)*1000;
+#else
+	/* Non-zero total, zero count implies cpu delay data not collected */
+	d->cpu_delay_total = CNSTATS_NOCPUDELAY;
+#endif
+}
+#else
+static inline void cnstats_exit_connector(struct task_struct *tsk)
+{}
+static inline void cnstats_get_cpu_delays(struct task_struct *tsk, struct cnstats_delay_v1 *d)
+{}
+#endif	/* CONFIG_STATS_CONNECTOR */
+#endif	/* __KERNEL__ */
+#endif	/* CN_PROC_H */
Index: linux-2.6.14/include/linux/connector.h
===================================================================
--- linux-2.6.14.orig/include/linux/connector.h
+++ linux-2.6.14/include/linux/connector.h
@@ -27,6 +27,10 @@
 #define CN_IDX_CONNECTOR		0xffffffff
 #define CN_VAL_CONNECTOR		0xffffffff

+/* Statistics connector ids */
+#define CN_IDX_STATS			0x2
+#define CN_VAL_STATS			0x2
+
 #define CN_NETLINK_USERS		1

 /*
Index: linux-2.6.14/drivers/connector/cn_stats.c
===================================================================
--- /dev/null
+++ linux-2.6.14/drivers/connector/cn_stats.c
@@ -0,0 +1,199 @@
+/*
+ * cn_stats.c - Task statistics connector
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
+ * Based on work by Matt Helsley, Nguyen Anh Quynh and Guillaume Thouvenin
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/atomic.h>
+
+#include <linux/cn_stats.h>
+
+#define CN_STATS_NOCPU	(-1)
+#define CN_STATS_NOACK	0
+#define CN_STATS_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct cnstats))
+
+static atomic_t cnstats_num_listeners = ATOMIC_INIT(0);
+static struct cb_id cnstats_id = { CN_IDX_STATS, CN_VAL_STATS };
+
+/* cnstats_counts is used as the sequence number of the netlink message */
+static DEFINE_PER_CPU(__u32, cnstats_counts) = { 0 };
+
+
+/*
+ * Send an acknowledgement message to userspace
+ */
+static void cnstats_ack(int err, int rcvd_seq, int rcvd_ack)
+{
+	struct cn_msg *msg;
+	struct cnstats *c;
+	__u8 buffer[CN_STATS_MSG_SIZE];
+
+	if (atomic_read(&cnstats_num_listeners) < 1)
+		return;
+
+	msg = (struct cn_msg *)buffer;
+	c = (struct cnstats *)msg->data;
+	msg->seq = rcvd_seq;
+	c->cpu = CN_STATS_NOCPU;
+	c->what = CNSTATS_DATA_NONE;
+	/* Following allows other functions to continue returning -ve errors */
+	c->data.ack.err = abs(err);
+	memcpy(&msg->id, &cnstats_id, sizeof(msg->id));
+	msg->ack = rcvd_ack + 1;
+	msg->len = sizeof(*c);
+	cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
+}
+
+/***
+ * cnstats_delay_v1 - return a task's delay statistics to userspace
+ *
+ * Function called either in response to a command or when a task is exiting
+ */
+
+static int __cnstats_delay_v1(struct task_struct *tsk, int seq, int ack, int cpu)
+{
+	struct cn_msg *msg;
+	struct cnstats *c;
+	struct cnstats_delay_v1 *d;
+	__u8 buffer[CN_STATS_MSG_SIZE];
+
+	if (atomic_read(&cnstats_num_listeners) < 1)
+		return -EAGAIN;
+
+	msg = (struct cn_msg *)buffer;
+	memset(msg, 0, sizeof(msg));
+	msg->seq = seq;
+	msg->ack = ack;
+
+	c = (struct cnstats *)msg->data;
+	c->cpu = cpu;
+	c->what = CNSTATS_DATA_DELAY_V1;
+
+	d = (struct cnstats_delay_v1 *)&c->data.delay_v1;
+	d->pid = tsk->pid;
+	d->tgid = tsk->tgid;
+
+	cnstats_get_cpu_delays(tsk, d);
+
+	spin_lock(&tsk->delays.lock);
+	d->blkio_count = tsk->delays.blkio_count;
+	d->blkio_delay_total = tsk->delays.blkio_delay;
+	d->pgflt_count = tsk->delays.pgflt_count;
+	d->pgflt_delay_total = tsk->delays.pgflt_delay;
+	spin_unlock(&tsk->delays.lock);
+
+	memcpy(&msg->id, &cnstats_id, sizeof(msg->id));
+	msg->len = sizeof(*c);
+
+	return cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
+}
+
+
+/***
+ * cnstats_delay_v1 - return delay statistics for given pid to userspace
+ *
+ */
+static int cnstats_delay_v1(pid_t pid, int seq, int ack, int cpu)
+{
+	struct task_struct *tsk;
+	int err;
+
+	read_lock(&tasklist_lock);
+	tsk = find_task_by_pid(pid);
+	if (!tsk) {
+		read_unlock(&tasklist_lock);
+		return -ESRCH;
+	}
+	get_task_struct(tsk);
+	read_unlock(&tasklist_lock);
+
+	err = __cnstats_delay_v1(tsk, seq, ack, cpu);
+
+	put_task_struct(tsk);
+	return err;
+}
+
+/***
+ * cnstats_ctl - handle command sent via CN_IDX_STATS connector
+ * @data: command
+ */
+static void cnstats_ctl(void *data)
+{
+	struct cn_msg *msg = data;
+	struct cnstats_cmd *cmd;
+	int err = 0;
+
+	if (msg->len != sizeof(*cmd))
+		return;
+
+	cmd = (struct cnstats_cmd *)msg->data;
+	switch (cmd->intype) {
+	case CNSTATS_CMD_LISTEN:
+		atomic_inc(&cnstats_num_listeners);
+		break;
+
+	case CNSTATS_CMD_IGNORE:
+		atomic_dec(&cnstats_num_listeners);
+		break;
+
+	case CNSTATS_CMD_DELAY_V1:
+		err = cnstats_delay_v1(cmd->param.pid, msg->seq, msg->ack+1,
+					CN_STATS_NOCPU);
+		if (!err)
+			return;		/* No ack needed */
+		break;
+
+	default:
+		err = -EINVAL;
+		break;
+	}
+	cnstats_ack(err, msg->seq, msg->ack);
+}
+
+/***
+ * cnstats_exit_connector - send task statistics to userspace on exit
+ * @tsk: exiting task
+ */
+void cnstats_exit_connector(struct task_struct *tsk)
+{
+	int ts, cpu;
+
+	ts = get_cpu_var(cnstats_counts)++;
+	cpu = smp_processor_id();
+	put_cpu_var(cnstats_counts);
+
+	__cnstats_delay_v1(tsk, ts, CN_STATS_NOACK, cpu);
+}
+
+/*
+ * cnstats_init - initialization entry point
+ *
+ * Adds the connector callback to the connector driver.
+ */
+static int __init cnstats_init(void)
+{
+	int err;
+
+	if ((err = cn_add_callback(&cnstats_id, "cn_stats", &cnstats_ctl))) {
+		printk(KERN_WARNING "cn_stats failed to register\n");
+		return err;
+	}
+	return 0;
+}
+
+module_init(cnstats_init);
Index: linux-2.6.14/kernel/exit.c
===================================================================
--- linux-2.6.14.orig/kernel/exit.c
+++ linux-2.6.14/kernel/exit.c
@@ -28,6 +28,7 @@
 #include <linux/cpuset.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/cn_stats.h>

 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -864,6 +865,7 @@ fastcall NORET_TYPE void do_exit(long co
 		module_put(tsk->binfmt->module);

 	tsk->exit_code = code;
+	cnstats_exit_connector(tsk);
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
 	mpol_free(tsk->mempolicy);
