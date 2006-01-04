Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWADVbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWADVbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWADVbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:31:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:27827 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751799AbWADVbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:31:42 -0500
Message-ID: <43BC3EAA.4010801@watson.ibm.com>
Date: Wed, 04 Jan 2006 16:31:22 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Patch 6/6] Delay accounting: Connector interface
References: <43BB05D8.6070101@watson.ibm.com> <43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>
In-Reply-To: <43BC1C43.9020101@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Shailabh Nagar wrote:
>  
>
>>Changes since 11/14/05:
>>
>>- explicit versioning of statistics data returned
>>- new command type for returning per-tgid stats
>>- for cpu running time, use tsk->sched_info.cpu_time (collected by schedstats)
>>
>>First post 11/14/05
>>
>>delayacct-connector.patch
>>    
>>
<snip>

>>Index: linux-2.6.15-rc7/include/linux/connector.h
>>===================================================================
>>--- linux-2.6.15-rc7.orig/include/linux/connector.h
>>+++ linux-2.6.15-rc7/include/linux/connector.h
>>@@ -35,6 +35,10 @@
>>#define CN_IDX_CIFS			0x2
>>#define CN_VAL_CIFS                     0x1
>>
>>+/* Statistics connector ids */
>>+#define CN_IDX_STATS			0x2
>>+#define CN_VAL_STATS			0x2
>>+
>>#define CN_NETLINK_USERS		1
>>
>>/*
>>Index: linux-2.6.15-rc7/drivers/connector/cn_stats.c
>>===================================================================
>>--- /dev/null
>>+++ linux-2.6.15-rc7/drivers/connector/cn_stats.c
>>@@ -0,0 +1,243 @@
>>+/*
>>+ * cn_stats.c - Task statistics connector
>> 
>>    
>>
>
>It looks like you create this file to report task stats through connector
>and you include stats for delay accounting you need as a starter.
>  
>

Yes. The idea is that the connector interface will be used by everyone 
interested in exporting per-task/process
stats. The stats that I care about right now are delay stats and those 
are being exported now. Adding to the
exported set (by extending struct cnstats_data and possibly, struct 
cnstats_cmd) can happen in future.

>This sounds like a good approach to me. However, we need to move
>where cnstats_exit_connector(tsk) is invoked. See below.
>  
>

>>+ *
>>+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
>>+ * Based on work by Matt Helsley, Nguyen Anh Quynh and Guillaume Thouvenin
>>+ *
>>+ * This program is free software; you can redistribute it and/or modify
>>+ * it under the terms of the GNU General Public License as published by
>>+ * the Free Software Foundation; either version 2 of the License, or
>>+ * (at your option) any later version.
>>+ *
>>+ * This program is distributed in the hope that it will be useful,
>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>+ * GNU General Public License for more details.
>>+ *
>>+ */
>>+
>>+#include <linux/module.h>
>>+#include <linux/kernel.h>
>>+#include <linux/init.h>
>>+#include <linux/cn_stats.h>
>>+#include <asm/atomic.h>
>>+
>>+#define CN_STATS_NOCPU	(-1)
>>+#define CN_STATS_NOACK	0
>>+#define CN_STATS_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct cnstats))
>>+
>>+static atomic_t cnstats_num_listeners = ATOMIC_INIT(0);
>>+static struct cb_id cnstats_id = { CN_IDX_STATS, CN_VAL_STATS };
>>+/* cnstats_counts is used as the sequence number of the netlink message */
>>+static DEFINE_PER_CPU(__u32, cnstats_counts) = { 0 };
>>+
>>+void cnstats_init_msg(struct cn_msg *msg, int seq, int ack)
>>+{
>>+	memset(msg, 0, CN_STATS_MSG_SIZE);
>>+	msg->seq = seq;
>>+	msg->ack = ack;
>>+	memcpy(&msg->id, &cnstats_id, sizeof(msg->id));
>>+	msg->len = sizeof(struct cnstats);
>>+}
>>+
>>+/*
>>+ * Accumalate one task's statistics
>>+ *
>>+ */
>>+static inline void cnstats_add_tsk_data(struct cnstats_data *d, struct task_struct *tsk)
>>+{
>>+	uint64_t tmp;
>>+
>>+	d->pid = tsk->pid;
>>+	d->tgid = tsk->tgid;
>>+
>>+	/* zero XXX_total,non-zero XXX_count implies XXX stat overflowed */
>>+#ifdef CONFIG_SCHEDSTATS
>>+	d->cpu_count += tsk->sched_info.pcnt;
>>+	tmp = d->cpu_run_total + jiffies_to_usecs(tsk->sched_info.cpu_time)*1000;
>>+	d->cpu_run_total = (tmp < d->cpu_run_total)? 0:tmp;
>>+	tmp = d->cpu_delay_total + jiffies_to_usecs(tsk->sched_info.run_delay)*1000;
>>+	d->cpu_delay_total = (tmp < d->cpu_delay_total)? 0:tmp;
>>+#else
>>+	/* Non-zero XXX_total,zero XXX_count implies XXX stat unavailable */
>>+	d->cpu_count = 0;
>>+	d->cpu_run_total = d->cpu_delay_total = CNSTATS_NOCPUSTATS;
>>+#endif
>>+	spin_lock(&tsk->delays.lock);
>>+	tmp = d->blkio_delay_total + tsk->delays.blkio_delay;
>>+	d->blkio_delay_total = (tmp < d->blkio_delay_total)? 0:tmp;
>>+	tmp = d->swapin_delay_total + tsk->delays.swapin_delay;
>>+	d->swapin_delay_total = (tmp < d->swapin_delay_total)? 0:tmp;
>>+	d->blkio_count += tsk->delays.blkio_count;
>>+	d->swapin_count += tsk->delays.swapin_count;
>>+	spin_unlock(&tsk->delays.lock);
>>+}
>>+
>>+/*
>>+ * Send acknowledgement (error)
>>+ *
>>+ */
>>+static void cnstats_send_ack(int err, int rcvd_seq, int rcvd_ack)
>>+{
>>+	__u8 buffer[CN_STATS_MSG_SIZE];
>>+	struct cn_msg *msg = (struct cn_msg *)buffer;
>>+	struct cnstats *c = (struct cnstats *)msg->data;
>>+
>>+	cnstats_init_msg(msg, rcvd_seq, rcvd_ack+1);
>>+	c->version = CNSTATS_DATA_VERSION;
>>+	c->outtype = CNSTATS_DATA_NONE;
>>+
>>+	/* Following allows other functions to continue returning -ve errors */
>>+	c->data.ack.err = abs(err);
>>+
>>+	cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
>>+}
>>+
>>+/*
>>+ * Send one pid's stats
>>+ *
>>+ */
>>+static int cnstats_send_pid(pid_t pid, int seq, int ack)
>>+{
>>+	__u8 buffer[CN_STATS_MSG_SIZE];
>>+	struct cn_msg *msg = (struct cn_msg *)buffer;
>>+	struct cnstats *c = (struct cnstats *)msg->data;
>>+	struct cnstats_data *d = (struct cnstats_data *)&c->data.stats;
>>+	struct task_struct *tsk;
>>+
>>+	cnstats_init_msg(msg, seq, ack);
>>+	c->version = CNSTATS_DATA_VERSION;
>>+	c->outtype = CNSTATS_DATA_PID;
>>+
>>+	read_lock(&tasklist_lock);
>>+	tsk = find_task_by_pid(pid);
>>+	if (!tsk) {
>>+		read_unlock(&tasklist_lock);
>>+		return -ESRCH;
>>+	}
>>+	get_task_struct(tsk);
>>+	read_unlock(&tasklist_lock);
>>+
>>+	cnstats_add_tsk_data(d, tsk);
>>+	put_task_struct(tsk);
>>+
>>+	return cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
>>+}
>>+
>>+/*
>>+ * Send one tgid's stats (sum of appropriate per-pid stats)
>>+ *
>>+ */
>>+static int cnstats_send_tgid(pid_t tgid, int seq, int ack)
>>+{
>>+	__u8 buffer[CN_STATS_MSG_SIZE];
>>+	struct cn_msg *msg = (struct cn_msg *)buffer;;
>>+	struct cnstats *c = (struct cnstats *)msg->data;
>>+	struct cnstats_data *d = (struct cnstats_data *)&c->data.stats;
>>+	struct task_struct *first, *tsk;
>>+
>>+	cnstats_init_msg(msg, seq, ack);
>>+	c->version = CNSTATS_DATA_VERSION;
>>+	c->outtype = CNSTATS_DATA_TGID;
>>+
>>+	read_lock(&tasklist_lock);
>>+	first = tsk = find_task_by_pid(tgid);
>>+	if (!first) {
>>+		read_unlock(&tasklist_lock);
>>+		return -ESRCH;
>>+	}
>>+	do
>>+		cnstats_add_tsk_data(d, tsk);
>>+	while_each_thread(first, tsk);
>>+	read_unlock(&tasklist_lock);
>>+
>>+	d->pid = -1;
>>+	d->tgid = tgid;
>>+
>>+	return cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
>>+}
>>+
>>+/***
>>+ * cnstats_ctl - handle command sent via CN_IDX_STATS connector
>>+ * @data: command
>>+ */
>>+static void cnstats_ctl(void *data)
>>+{
>>+	struct cn_msg *msg = data;
>>+	struct cnstats_cmd *cmd;
>>+	int err = 0;
>>+
>>+	if (msg->len != sizeof(*cmd))
>>+		return;
>>+
>>+	cmd = (struct cnstats_cmd *)msg->data;
>>+	switch (cmd->intype) {
>>+	case CNSTATS_CMD_LISTEN:
>>+		atomic_inc(&cnstats_num_listeners);
>>+		break;
>>+
>>+	case CNSTATS_CMD_IGNORE:
>>+		atomic_dec(&cnstats_num_listeners);
>>+		break;
>>+
>>+	case CNSTATS_CMD_STATS_PID:
>>+		if (atomic_read(&cnstats_num_listeners) < 1)
>>+			return;
>>+		err = cnstats_send_pid(cmd->param.pid, msg->seq, msg->ack+1);
>>+		if (!err)
>>+			return;
>>+		break;
>>+
>>+	case CNSTATS_CMD_STATS_TGID:
>>+		if (atomic_read(&cnstats_num_listeners) < 1)
>>+			return;
>>+		err = cnstats_send_tgid(cmd->param.pid, msg->seq, msg->ack+1);
>>+		if (!err)
>>+			return;
>>+		break;
>>+
>>+	default:
>>+		err = -EINVAL;
>>+		break;
>>+	}
>>+	cnstats_send_ack(err, msg->seq, msg->ack);
>>+}
>>+
>>+/***
>>+ * cnstats_exit_connector - send task's statistics to userspace when it exits
>>+ * @tsk: exiting task
>>+ */
>>+void cnstats_exit_connector(struct task_struct *tsk)
>>+{
>>+	int seq;
>>+	__u8 buffer[CN_STATS_MSG_SIZE];
>>+	struct cn_msg *msg = (struct cn_msg *)buffer;
>>+	struct cnstats *c = (struct cnstats *)msg->data;
>>+	struct cnstats_data *d = (struct cnstats_data *)&c->data.stats;
>>+
>>+	if (atomic_read(&cnstats_num_listeners) < 1)
>>+		return;
>>+
>>+	seq = get_cpu_var(cnstats_counts)++;
>>+	put_cpu_var(cnstats_counts);
>>+
>>+	cnstats_init_msg(msg, seq, CN_STATS_NOACK);
>>+	c->version = CNSTATS_DATA_VERSION;
>>+	c->outtype = CNSTATS_DATA_EXIT;
>>+	cnstats_add_tsk_data(d, tsk);
>>+
>>+	cn_netlink_send(msg, CN_IDX_STATS, GFP_KERNEL);
>>+}
>>+
>>+static int __init cnstats_init(void)
>>+{
>>+	int err;
>>+
>>+	if ((err = cn_add_callback(&cnstats_id, "cn_stats", &cnstats_ctl))) {
>>+		printk(KERN_WARNING "cn_stats failed to register\n");
>>+		return err;
>>+	}
>>+	return 0;
>>+}
>>+
>>+module_init(cnstats_init);
>>Index: linux-2.6.15-rc7/kernel/exit.c
>>===================================================================
>>--- linux-2.6.15-rc7.orig/kernel/exit.c
>>+++ linux-2.6.15-rc7/kernel/exit.c
>>@@ -29,6 +29,7 @@
>>#include <linux/syscalls.h>
>>#include <linux/signal.h>
>>#include <linux/cn_proc.h>
>>+#include <linux/cn_stats.h>
>>
>>#include <asm/uaccess.h>
>>#include <asm/unistd.h>
>>@@ -865,6 +866,7 @@ fastcall NORET_TYPE void do_exit(long co
>>
>>	tsk->exit_code = code;
>>	proc_exit_connector(tsk);
>>+	cnstats_exit_connector(tsk);
>> 
>>    
>>
>
>We need to move both proc_exit_connector(tsk) and
>cnstats_exit_connector(tsk) up to before exit_mm(tsk) statement.
>There are task statistics collected in task->mm and those stats
>will be lost after exit_mm(tsk).
>  
>
Good point. The cnstats connector can be moved.
I'm not sure if proc_exit_connector needs to move as well..but Matt can 
comment on that.

Do let me know if you think this interface would be good enough for 
CSA's needs or what changes would
be needed.

--Shailabh

>Thanks,
> - jay
>
>  
>
>>	exit_notify(tsk);
>>#ifdef CONFIG_NUMA
>>	mpol_free(tsk->mempolicy);
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>> 
>>    
>>
>
>
>  
>


