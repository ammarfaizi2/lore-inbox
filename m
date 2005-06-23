Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVFWG1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVFWG1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVFWG1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:27:21 -0400
Received: from [24.22.56.4] ([24.22.56.4]:25830 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262308AbVFWGS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:59 -0400
Message-Id: <20050623061758.134299000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:11 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@us.ibm.com>, Vivek Kashyap <vivk@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 19/38] CKRM e18: Rule Based Classification Engine, more advanced classification engine
Content-Disposition: inline; filename=09-05-rbce_core-crbce
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 5 of 5 patches to support Rule Based Classification Engine for CKRM.
This patch provides the enhanced RBCE, CRBCE. CRBCE allows the per-process
delay data and additioanl user level monmitoring support.

Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

 include/linux/crbce.h            |  164 +++++++++++
 include/linux/netlink.h          |    1 
 include/linux/rbce.h             |   50 +++
 init/Kconfig                     |   12 
 kernel/ckrm/rbce/Makefile        |    6 
 kernel/ckrm/rbce/crbce_ext.c     |  580 +++++++++++++++++++++++++++++++++++++++
 kernel/ckrm/rbce/crbce_main.c    |    2 
 kernel/ckrm/rbce/rbce_core.c     |   45 ++-
 kernel/ckrm/rbce/rbce_internal.h |   10 
 kernel/ckrm/rbce/rbce_main.c     |   24 +
 10 files changed, 886 insertions(+), 8 deletions(-)

Index: linux-2.6.12-ckrm1/include/linux/crbce.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/include/linux/crbce.h	2005-06-20 13:08:48.000000000 -0700
@@ -0,0 +1,164 @@
+/*
+ * crbce.h
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ * Copyright (C) Chandra Seetharaman, IBM Corp. 2004
+ *
+ * This files contains the type definition of the record
+ * created by the CRBCE CKRM classification engine
+ *
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ *
+ */
+
+#ifndef _LINUX_CRBCE_H
+#define _LINUX_CRBCE_H
+
+#ifdef __KERNEL__
+#include <linux/autoconf.h>
+#else
+#define  CONFIG_CKRM
+#define  CONFIG_CRBCE
+#define  CONFIG_DELAY_ACCT
+#endif
+
+#include <linux/types.h>
+#include <linux/ckrm_events.h>
+#include <linux/ckrm_ce.h>
+
+#define CRBCE_MAX_CLASS_NAME_LEN  256
+
+/****************************************************************
+ *
+ *  CRBCE EVENT SET is an extension to the standard CKRM_EVENTS
+ *
+ ****************************************************************/
+
+typedef int __bitwise crbce_event_t;
+enum crbce_event {
+
+	/* we use the standard CKRM_EVENT_<..>
+	 * to identify reclassification cause actions
+	 * and extend by additional ones we need
+	 */
+
+	/* up event flow */
+
+	CRBCE_REC_EXIT = (__force crbce_event_t) (CKRM_NUM_EVENTS+1),
+	CRBCE_REC_DATA_DELIMITER = (__force crbce_event_t) (CRBCE_REC_EXIT+2),
+	CRBCE_REC_SAMPLE = (__force crbce_event_t) (CRBCE_REC_EXIT+3),
+	CRBCE_REC_TASKINFO = (__force crbce_event_t) (CRBCE_REC_EXIT+4),
+	CRBCE_REC_SYS_INFO = (__force crbce_event_t) (CRBCE_REC_EXIT+5),
+	CRBCE_REC_CLASS_INFO = (__force crbce_event_t) (CRBCE_REC_EXIT+6),
+	CRBCE_REC_KERNEL_CMD_DONE = (__force crbce_event_t) (CRBCE_REC_EXIT+7),
+	CRBCE_REC_UKCC_FULL = (__force crbce_event_t) (CRBCE_REC_EXIT+8),
+
+	/* down command issueance */
+	CRBCE_REC_KERNEL_CMD = (__force crbce_event_t) (CRBCE_REC_EXIT+9),
+
+	CRBCE_NUM_EVENTS = (__force crbce_event_t) (CRBCE_REC_EXIT+10)
+};
+
+struct task_sample_info {
+	uint32_t cpu_running;
+	uint32_t cpu_waiting;
+	uint32_t io_delayed;
+	uint32_t memio_delayed;
+};
+
+/*********************************************
+ *          KERNEL -> USER  records          *
+ *********************************************/
+
+/* we have records with either a time stamp or not */
+struct crbce_hdr {
+	int type;
+	pid_t pid;
+};
+
+struct crbce_hdr_ts {
+	int type;
+	pid_t pid;
+	uint32_t jiffies;
+	uint64_t cls;
+};
+
+/* individual records */
+
+struct crbce_rec_fork {
+	struct crbce_hdr_ts hdr;
+	pid_t ppid;
+};
+
+struct crbce_rec_data_delim {
+	struct crbce_hdr_ts hdr;
+	int is_stop;		/* 0 start, 1 stop */
+};
+
+struct crbce_rec_task_data {
+	struct crbce_hdr_ts hdr;
+	struct task_sample_info sample;
+	struct task_delay_info delay;
+};
+
+struct crbce_ukcc_full {
+	struct crbce_hdr_ts hdr;
+};
+
+struct crbce_class_info {
+	struct crbce_hdr_ts hdr;
+	int action;
+	int namelen;
+	char name[CRBCE_MAX_CLASS_NAME_LEN];
+};
+
+/*********************************************
+ *           USER -> KERNEL records          *
+ *********************************************/
+
+typedef int __bitwise crbce_kernel_cmd_t;
+enum crbce_kernel_cmd {
+	CRBCE_CMD_START = (__force crbce_kernel_cmd_t) 1,
+	CRBCE_CMD_STOP = (__force crbce_kernel_cmd_t) 2,
+	CRBCE_CMD_SET_TIMER = (__force crbce_kernel_cmd_t) 3,
+	CRBCE_CMD_SEND_DATA = (__force crbce_kernel_cmd_t) 4,
+};
+
+struct crbce_command {
+	int type;		/* we need this for the K->U reflection */
+	int cmd;
+	uint32_t len;	/* added in the kernel for reflection */
+};
+
+#define set_cmd_hdr(rec,tok) \
+	((rec).hdr.type=CRBCE_REC_KERNEL_CMD,(rec).hdr.cmd=(tok))
+
+struct crbce_cmd_done {
+	struct crbce_command hdr;
+	int rc;
+};
+
+struct crbce_cmd {
+	struct crbce_command hdr;
+};
+
+struct crbce_cmd_send_data {
+	struct crbce_command hdr;
+	int delta_mode;
+};
+
+struct crbce_cmd_settimer {
+	struct crbce_command hdr;
+	uint32_t interval;	/* in msec .. 0 means stop */
+};
+#endif
Index: linux-2.6.12-ckrm1/include/linux/netlink.h
===================================================================
--- linux-2.6.12-ckrm1.orig/include/linux/netlink.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-ckrm1/include/linux/netlink.h	2005-06-20 13:08:48.000000000 -0700
@@ -14,6 +14,7 @@
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
 #define NETLINK_ARPD		8
 #define NETLINK_AUDIT		9	/* auditing */
+#define NETLINK_CKRM		10	/* CKRM */
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
Index: linux-2.6.12-ckrm1/init/Kconfig
===================================================================
--- linux-2.6.12-ckrm1.orig/init/Kconfig	2005-06-20 13:08:42.000000000 -0700
+++ linux-2.6.12-ckrm1/init/Kconfig	2005-06-20 13:08:48.000000000 -0700
@@ -215,6 +215,18 @@ config CKRM_RBCE
 
 	  If unsure, say N.
 
+config CKRM_CRBCE
+	tristate "Enhanced Rule-based Classification Engine (RBCE)"
+	depends on CKRM && RCFS_FS && DELAY_ACCT
+	default m
+	help
+	  Provides an optional module to support creation of rules for automatic
+	  classification of kernel objects, just like RBCE above. In addition,
+	  CRBCE provides per-process delay data (requires DELAY_ACCT configured)
+	  enabled) and makes information on significant kernel events available
+	  to userspace tools through relayfs (requires RELAYFS_FS configured).
+
+	  If unsure, say N.
 endmenu
 
 config SYSCTL
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/Makefile
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/Makefile	2005-06-20 13:08:46.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/Makefile	2005-06-20 13:08:48.000000000 -0700
@@ -4,3 +4,9 @@
 
 obj-$(CONFIG_CKRM_RBCE)	+= rbce.o
 rbce-objs := rbce_fs.o rbce_main.o rbce_token.o rbce_core.o
+
+obj-$(CONFIG_CKRM_CRBCE)	+= crbce.o
+crbce-objs := rbce_fs.o crbce_main.o rbce_token.o rbce_core.o crbce_ext.o
+
+CFLAGS_crbce_main.o += -DCRBCE_EXTENSION
+CFLAGS_crbce_ext.o += -DCRBCE_EXTENSION
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/crbce_ext.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/crbce_ext.c	2005-06-20 13:08:48.000000000 -0700
@@ -0,0 +1,580 @@
+/* Data Collection Extension to Rule-based Classification Engine (RBCE) module
+ *
+ * Copyright (C) Hubertus Franke, IBM Corp. 2003
+ *
+ * Extension to be included into RBCE to collect delay and sample information
+ * Requires user daemon e.g. crbcedmn to activate.
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+/*
+ *   User-Kernel Communication Channel (UKCC)
+ *   Protocol and communication handling based on netlink
+ */
+
+#include <net/sock.h>
+#include <linux/netlink.h>
+#include "rbce_internal.h"
+
+#define PSAMPLE(pdata)    (&((pdata)->ext_data.sample))
+#define NETLINK_GFP_MASK	GFP_ATOMIC
+
+typedef int __bitwise ukcc_state_t;
+enum ukcc_state {
+	UKCC_OK = (__force ukcc_state_t) 0,
+	UKCC_STANDBY = (__force ukcc_state_t) 1,
+	UKCC_FULL =  (__force ukcc_state_t) 2
+};
+
+int ukcc_channel = -1;
+static enum ukcc_state chan_state = UKCC_STANDBY;
+static void ukcc_cmd_deliver(int rchan_id, char *from, u32 len);
+static struct sock *ukcc_sock = NULL;
+
+static inline int ukcc_ok(void)
+{
+	return (chan_state == UKCC_OK);
+}
+
+static inline int ukcc_send(void *data, int len)
+{
+	int rc;
+	char *saddr;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh = NULL;
+	int nlmessage_len = NLMSG_LENGTH(sizeof(struct nlmsghdr) + len);
+
+	skb = alloc_skb(nlmessage_len, NETLINK_GFP_MASK);
+	if (!skb)
+		return -ENOMEM;
+	nlh = NLMSG_PUT(skb, 0, 0, NETLINK_CKRM, len); /* pid, type, event */
+	saddr = NLMSG_DATA(nlh);
+	memcpy(saddr, data, len);
+
+	rc = netlink_broadcast(ukcc_sock, skb, 0, 1, NETLINK_GFP_MASK);
+	return (rc < 0) ? rc : 1;
+
+nlmsg_failure:
+	return -1;
+}
+
+static void ukcc_netlink_recv(struct sock *sk, int len)
+{
+	int skblen;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+		skblen = skb->len;
+		nlh = (struct nlmsghdr *)skb->data;
+		if (!NLMSG_OK(nlh, skblen))
+			return;
+		if (nlh->nlmsg_type == NLMSG_NOOP)
+			return;
+		if (nlh->nlmsg_flags & MSG_TRUNC) {
+			netlink_ack(skb, nlh, -ECOMM);
+			return;
+		}
+		if (nlh->nlmsg_flags & NLM_F_ACK)
+			netlink_ack(skb, nlh, 0);
+
+		/* write the command back to the sender
+		 * this can be probably done better through setup in
+		 * userspace, but we have no guarantee of ordering then..
+		 */
+		(void) ukcc_send(NLMSG_DATA(nlh), skblen - NLMSG_LENGTH(0));
+		ukcc_cmd_deliver(0, NLMSG_DATA(nlh), skblen - NLMSG_LENGTH(0));
+		kfree_skb(skb);
+	}
+}
+
+static int create_ukcc_channel(void)
+{
+	ukcc_sock = netlink_kernel_create(NETLINK_CKRM, ukcc_netlink_recv);
+
+	if (!ukcc_sock) {
+		printk(KERN_ERR "kevent: "
+			"unable to create netlink socket; aborting\n");
+		return -ENODEV;
+	}
+	ukcc_channel = 0;
+	return ukcc_channel;
+}
+
+static inline void close_ukcc_channel(void)
+{
+	if (ukcc_channel >= 0) {
+		sock_release(ukcc_sock->sk_socket);
+		ukcc_channel = -1;
+		chan_state = UKCC_STANDBY;
+	}
+}
+
+#define rec_set_hdr(r,t,p)      ((r)->hdr.type = (t), (r)->hdr.pid = (p))
+#define rec_set_timehdr(r,t,p,c)  (rec_set_hdr(r,t,p), \
+	(r)->hdr.jiffies = jiffies, (r)->hdr.cls=(unsigned long)(c) )
+
+#if CHANNEL_AUTO_CONT
+
+/* we only provide this for debugging.. it allows us to send records
+ * based on availability in the channel when the UKCC stalles rather
+ * going through the UKCC recovery protocol
+ */
+static inline void rec_send_len(void *r, size_t l)
+{
+	int chan_wasok = (chan_state == UKCC_OK);
+	int chan_isok = (ukcc_send(r, l) > 0);
+
+	chan_state = chan_isok ? UKCC_OK : UKCC_STANDBY;
+	if (chan_wasok && !chan_isok)
+		printk(KERN_WARN "Channel stalled\n");
+	else if (!chan_wasok && chan_isok)
+		printk(KERN_INFO "Channel continues\n");
+}
+
+#else
+
+/* Default UKCC channel protocol.
+ * Though a UKCC buffer overflow should not happen ever, it is possible iff
+ * the user daemon stops reading for some reason. Hence we provide a simple
+ * protocol based on 3 states
+ *     UKCC_OK      :=	channel is active and properly working. When a
+ *			channel write fails we move to state CHAN_FULL.
+ *     UKCC_FULL    :=	channel is active, but the last send_rec has failed.
+ *			As a result we will try to send an indication to
+ *			the daemon that this has happened. When that
+ *			succeeds, we move to state UKCC_STANDBY.
+ *     UKCC_STANDBY := 	we are waiting to be restarted by the user daemon
+ *
+ */
+
+static void ukcc_full(void)
+{
+	static spinlock_t ukcc_state_lock = SPIN_LOCK_UNLOCKED;
+	/*
+	 * protect transition from OK -> FULL to ensure only one record
+	 * is sent, rest we do not need to protect, protocol implies
+	 * that.
+	*/
+	int send = 0;
+	spin_lock(&ukcc_state_lock);
+	if ((send = (chan_state != UKCC_STANDBY)))
+		chan_state = UKCC_STANDBY;	/* assume we can send */
+	spin_unlock(&ukcc_state_lock);
+
+	if (send) {
+		struct crbce_ukcc_full rec;
+		rec_set_timehdr(&rec, CRBCE_REC_UKCC_FULL, 0, 0);
+		if (ukcc_send(&rec, sizeof(rec)) < 0)
+			/* channel is remains full .. try with next one */
+			chan_state = UKCC_FULL;
+	}
+}
+
+static inline void rec_send_len(void *r, size_t l)
+{
+	switch (chan_state) {
+	case UKCC_OK:
+		if (ukcc_send(r, l) > 0)
+			break;
+		/*FALLTHRU*/
+	case UKCC_FULL:
+		ukcc_full();
+		break;
+	default:
+		break;
+	}
+}
+
+#endif
+
+#define rec_send(r)	rec_send_len(r, sizeof(*(r)))
+
+/****************************************************************************
+ *
+ *  Callbacks for the CKRM engine.
+ *    In each we do the necessary classification and event record generation
+ *    We generate 3 kind of records in the callback
+ *    (a) FORK              	send the pid, the class and the ppid
+ *    (b) RECLASSIFICATION  	send the pid, the class and < sample data +
+ *				delay data >
+ *    (b) EXIT              	send the pid
+ *
+*****************************************************************************/
+
+int delta_mode = 0;
+
+static inline void copy_delay(struct task_delay_info *delay,
+			      struct task_struct *tsk)
+{
+	*delay = tsk->delays;
+}
+
+static inline void zero_delay(struct task_delay_info *delay)
+{
+	memset(delay, 0, sizeof(struct task_delay_info));
+	/* we need to think about doing this 64-bit atomic */
+}
+
+static inline void zero_sample(struct task_sample_info *sample)
+{
+	memset(sample, 0, sizeof(struct task_sample_info));
+	/* we need to think about doing this 64-bit atomic */
+}
+
+static inline int check_zero(void *ptr, int len)
+{
+	int iszero = 1;
+	int i;
+	unsigned long *uptr = (unsigned long *)ptr;
+
+	for (i = len / sizeof(unsigned long); i-- && iszero; uptr++)
+		/* assume its rounded */
+		iszero &= (*uptr == 0);
+	return iszero;
+}
+
+static inline int check_not_zero(void *ptr, int len)
+{
+	int i;
+	unsigned long *uptr = (unsigned long *)ptr;
+
+	for (i = len / sizeof(unsigned long); i--; uptr++)
+		/* assume its rounded */
+		if (*uptr)
+			return 1;
+	return 0;
+}
+
+static inline int sample_changed(struct task_sample_info *s)
+{
+	return check_not_zero(s, sizeof(*s));
+}
+static inline int delay_changed(struct task_delay_info *d)
+{
+	return check_not_zero(d, sizeof(*d));
+}
+
+static inline int
+send_task_record(struct task_struct *tsk, int event,
+		 struct ckrm_core_class *core, int send_forced)
+{
+	struct crbce_rec_task_data rec;
+	struct rbce_private_data *pdata;
+	int send = 0;
+
+	if (!ukcc_ok())
+		return 0;
+	pdata = RBCE_DATA(tsk);
+	if (pdata == NULL)
+		return 0;
+	if (send_forced || (delta_mode == 0)
+	    || sample_changed(PSAMPLE(RBCE_DATA(tsk)))
+	    || delay_changed(&tsk->delays)) {
+		rec_set_timehdr(&rec, event, tsk->pid,
+				core ? core : (struct ckrm_core_class *)tsk->
+				taskclass);
+		rec.sample = *PSAMPLE(RBCE_DATA(tsk));
+		copy_delay(&rec.delay, tsk);
+		rec_send(&rec);
+		if (delta_mode || send_forced) {
+			/* on reclassify or delta mode reset the counters */
+			zero_sample(PSAMPLE(RBCE_DATA(tsk)));
+			zero_delay(&tsk->delays);
+		}
+		send = 1;
+	}
+	return send;
+}
+
+void send_exit_notification(struct task_struct *tsk)
+{
+	send_task_record(tsk, CRBCE_REC_EXIT, NULL, 1);
+}
+
+void
+rbce_tc_ext_notify(int event, void *core, struct task_struct *tsk)
+{
+	struct crbce_rec_fork rec;
+
+	switch (event) {
+	case CKRM_EVENT_FORK:
+		if (ukcc_ok()) {
+			rec.ppid = tsk->parent->pid;
+			rec_set_timehdr(&rec, CKRM_EVENT_FORK, tsk->pid, core);
+			rec_send(&rec);
+		}
+		break;
+	case CKRM_EVENT_MANUAL:
+		rbce_tc_manual(tsk);
+
+	default:
+		send_task_record(tsk, event, (struct ckrm_core_class *)core, 1);
+		break;
+	}
+}
+
+/*====================== end classification engine =======================*/
+
+static void sample_task_data(unsigned long unused);
+
+struct timer_list sample_timer = {.expires = 0,.function = sample_task_data };
+unsigned long timer_interval_length = (250 * HZ) / 1000;
+
+inline void stop_sample_timer(void)
+{
+	if (sample_timer.expires > 0) {
+		del_timer_sync(&sample_timer);
+		sample_timer.expires = 0;
+	}
+}
+
+inline void start_sample_timer(void)
+{
+	if (timer_interval_length > 0) {
+		sample_timer.expires =
+		    jiffies + (timer_interval_length * HZ) / 1000;
+		add_timer(&sample_timer);
+	}
+}
+
+static void send_task_data(void)
+{
+	struct crbce_rec_data_delim limrec;
+	struct task_struct *proc, *thread;
+	int sendcnt = 0;
+	int taskcnt = 0;
+	limrec.is_stop = 0;
+	rec_set_timehdr(&limrec, CRBCE_REC_DATA_DELIMITER, 0, 0);
+	rec_send(&limrec);
+
+	read_lock(&tasklist_lock);
+	do_each_thread(proc, thread) {
+		taskcnt++;
+		task_lock(thread);
+		sendcnt += send_task_record(thread, CRBCE_REC_SAMPLE, NULL, 0);
+		task_unlock(thread);
+	} while_each_thread(proc, thread);
+	read_unlock(&tasklist_lock);
+
+	limrec.is_stop = 1;
+	rec_set_timehdr(&limrec, CRBCE_REC_DATA_DELIMITER, 0, 0);
+	rec_send(&limrec);
+
+}
+
+void notify_class_action(struct rbce_class *cls, int action)
+{
+	struct crbce_class_info cinfo;
+	int len;
+
+	rec_set_timehdr(&cinfo, CRBCE_REC_CLASS_INFO, 0, cls->classobj);
+	cinfo.action = action;
+	len = strnlen(cls->obj.name, CRBCE_MAX_CLASS_NAME_LEN - 1);
+	memcpy(&cinfo.name, cls->obj.name, len);
+	cinfo.name[len] = '\0';
+	len++;
+	cinfo.namelen = len;
+
+	len += sizeof(cinfo) - CRBCE_MAX_CLASS_NAME_LEN;
+	rec_send_len(&cinfo, len);
+}
+
+static void send_classlist(void)
+{
+	struct rbce_class *cls;
+
+	read_lock(&rbce_rwlock);
+	list_for_each_entry(cls, &class_list, obj.link)
+		notify_class_action(cls, 1);
+	read_unlock(&rbce_rwlock);
+}
+
+/*
+ *  resend_task_info
+ *
+ *  This function resends all essential task information to the client.
+ */
+static void resend_task_info(void)
+{
+	struct crbce_rec_data_delim limrec;
+	struct crbce_rec_fork rec;
+	struct task_struct *proc, *thread;
+
+	send_classlist();	/* first send available class information */
+
+	limrec.is_stop = 2;
+	rec_set_timehdr(&limrec, CRBCE_REC_DATA_DELIMITER, 0, 0);
+	rec_send(&limrec);
+
+	write_lock(&tasklist_lock);	/* avoid any mods during this phase */
+	do_each_thread(proc, thread)
+		if (ukcc_ok()) {
+			rec.ppid = thread->parent->pid;
+			rec_set_timehdr(&rec, CRBCE_REC_TASKINFO, thread->pid,
+					thread->taskclass);
+			rec_send(&rec);
+		}
+	while_each_thread(proc, thread);
+	write_unlock(&tasklist_lock);
+
+	limrec.is_stop = 3;
+	rec_set_timehdr(&limrec, CRBCE_REC_DATA_DELIMITER, 0, 0);
+	rec_send(&limrec);
+}
+
+extern int task_running_sys(struct task_struct *);
+
+static void add_all_private_data(void)
+{
+	struct task_struct *proc, *thread;
+
+	write_lock(&tasklist_lock);
+	do_each_thread(proc, thread)
+		if (RBCE_DATA(thread) == NULL)
+			RBCE_DATAP(thread) = create_private_data(NULL, 0);
+	while_each_thread(proc, thread);
+	write_unlock(&tasklist_lock);
+}
+
+static void sample_task_data(unsigned long unused)
+{
+	struct task_struct *proc, *thread;
+
+	int run = 0;
+	int wait = 0;
+	read_lock(&tasklist_lock);
+	do_each_thread(proc, thread) {
+		struct rbce_private_data *pdata = RBCE_DATA(thread);
+
+		if (pdata == NULL)
+			/* some wierdo race condition .. simply ignore */
+			continue;
+		if (thread->state == TASK_RUNNING) {
+			if (task_running_sys(thread)) {
+				atomic_inc((atomic_t *) &
+					   (PSAMPLE(pdata)->cpu_running));
+				run++;
+			} else {
+				atomic_inc((atomic_t *) &
+					   (PSAMPLE(pdata)->cpu_waiting));
+				wait++;
+			}
+		}
+		/* update IO state */
+		if (thread->flags & PF_IOWAIT) {
+			if (thread->flags & PF_MEMIO)
+				atomic_inc((atomic_t *) &
+					   (PSAMPLE(pdata)->memio_delayed));
+			else
+				atomic_inc((atomic_t *) &
+					   (PSAMPLE(pdata)->io_delayed));
+		}
+	}
+	while_each_thread(proc, thread);
+	read_unlock(&tasklist_lock);
+	start_sample_timer();
+}
+
+static void ukcc_cmd_deliver(int rchan_id, char *from, u32 len)
+{
+	struct crbce_command *cmdrec = (struct crbce_command *)from;
+	struct crbce_cmd_done cmdret;
+	int rc = 0;
+
+	cmdrec->len = len;	/*
+				 * add this to reflection so the user doesn't
+				 * accidently write the wrong length and the
+				 * protocol is getting screwed up
+				 */
+
+	if (cmdrec->type != CRBCE_REC_KERNEL_CMD) {
+		rc = EINVAL;
+		goto out;
+	}
+
+	switch (cmdrec->cmd) {
+	case CRBCE_CMD_SET_TIMER:
+		{
+			struct crbce_cmd_settimer *cptr =
+			    (struct crbce_cmd_settimer *)cmdrec;
+			if (len != sizeof(*cptr)) {
+				rc = EINVAL;
+				break;
+			}
+			stop_sample_timer();
+			timer_interval_length = cptr->interval;
+			if ((timer_interval_length > 0)
+			    && (timer_interval_length < 10))
+				timer_interval_length = 10;
+				/* anything finer can create problems */
+			printk(KERN_INFO "CRBCE set sample collect timer %lu\n",
+			       timer_interval_length);
+			start_sample_timer();
+			break;
+		}
+	case CRBCE_CMD_SEND_DATA:
+		{
+			struct crbce_cmd_send_data *cptr =
+			    (struct crbce_cmd_send_data *)cmdrec;
+			if (len != sizeof(*cptr)) {
+				rc = EINVAL;
+				break;
+			}
+			delta_mode = cptr->delta_mode;
+			send_task_data();
+			break;
+		}
+	case CRBCE_CMD_START:
+		add_all_private_data();
+		chan_state = UKCC_OK;
+		resend_task_info();
+		break;
+
+	case CRBCE_CMD_STOP:
+		chan_state = UKCC_STANDBY;
+		free_all_private_data();
+		break;
+
+	default:
+		rc = EINVAL;
+		break;
+	}
+
+out:
+	cmdret.hdr.type = CRBCE_REC_KERNEL_CMD_DONE;
+	cmdret.hdr.cmd = cmdrec->cmd;
+	cmdret.rc = rc;
+	rec_send(&cmdret);
+}
+
+int init_rbce_ext_pre(void)
+{
+	int rc;
+
+	rc = create_ukcc_channel();
+	return ((rc < 0) ? rc : 0);
+}
+
+int init_rbce_ext_post(void)
+{
+	init_timer(&sample_timer);
+	return 0;
+}
+
+void exit_rbce_ext(void)
+{
+	stop_sample_timer();
+	close_ukcc_channel();
+}
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/crbce_main.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/crbce_main.c	2005-06-20 13:08:48.000000000 -0700
@@ -0,0 +1,2 @@
+/* Easiest way to transmit a symbolic link as a patch */
+#include "rbce_main.c"
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_core.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_core.c	2005-06-20 13:08:46.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_core.c	2005-06-20 13:08:48.000000000 -0700
@@ -23,6 +23,23 @@
 
 #include "rbce_internal.h"
 
+/* Callback from core when a class is created */
+static void rbce_class_addcb(const char *classname, void *clsobj, int classtype)
+{
+	struct rbce_class *cls;
+
+	write_lock(&rbce_rwlock);
+	cls = find_class_name((char *)classname);
+	if (cls)
+		cls->classobj = clsobj;
+	else
+		cls = create_rbce_class(classname, classtype, clsobj);
+	if (cls)
+		notify_class_action(cls, 1);
+	write_unlock(&rbce_rwlock);
+	return;
+}
+
 /*
  * Callback from core when a class is deleted.
  */
@@ -40,6 +57,7 @@ rbce_class_deletecb(const char *classnam
 			printk(KERN_ERR "rbce: class %s changed identity\n",
 			       classname);
 		}
+		notify_class_action(cls, 0);
 		cls->classobj = NULL;
 		list_for_each_entry(pos, &rules_list[cls->classtype], link) {
 			rule = (struct rbce_rule *)pos;
@@ -53,9 +71,7 @@ rbce_class_deletecb(const char *classnam
 			}
 		}
 		if ((cls = find_class_name(classname)) != NULL) {
-			printk(KERN_ERR
-			       "rbce ERROR: class %s exists in rbce after "
-			       "removal in core\n", classname);
+			put_class(cls); /* propably created thru addcb */
 		}
 	}
 	write_unlock(&rbce_rwlock);
@@ -446,6 +462,16 @@ __evaluate_rule(struct task_struct *tsk,
 #define store_pdata(pdata)
 #define unstore_pdata(pdata)
 
+static inline void
+copy_ext_private_data(struct rbce_private_data *src,
+		      struct rbce_private_data *dst)
+{
+	if (src)
+		dst->ext_data = src->ext_data;
+	else
+		memset(&dst->ext_data, 0, sizeof(dst->ext_data));
+}
+
 struct rbce_private_data *create_private_data(struct rbce_private_data
 						     *src, int copy_sample)
 {
@@ -473,6 +499,7 @@ struct rbce_private_data *create_private
 				bitvector_init(pdata->true, vsize);
 			}
 		}
+		copy_ext_private_data(src, pdata);
 		pdata->evaluate = 1;
 		pdata->rules_version = src ? src->rules_version : 0;
 		pdata->app_tag = NULL;
@@ -655,7 +682,7 @@ static struct ckrm_core_class *rbce_clas
 
 /* helper functions that are required in the extended version */
 
-static inline void rbce_tc_manual(struct task_struct *tsk)
+void rbce_tc_manual(struct task_struct *tsk)
 {
 	read_lock(&rbce_rwlock);
 
@@ -716,6 +743,7 @@ static void rbce_tc_exitcb(struct task_s
 {
 	struct rbce_private_data *pdata;
 
+	send_exit_notification(tsk);
 	pdata = RBCE_DATA(tsk);
 	RBCE_DATAP(tsk) = NULL;
 	if (pdata) {
@@ -790,20 +818,29 @@ static void *rbce_tc_classify(enum ckrm_
 	return cls;
 }
 
+#ifndef CRBCE_EXTENSION
 static void rbce_tc_notify(int event, void *core, struct task_struct *tsk)
 {
 	if (event != CKRM_EVENT_MANUAL)
 		return;
 	rbce_tc_manual(tsk);
 }
+#endif
 
 static struct ckrm_eng_callback rbce_taskclass_ecbs = {
 	.c_interest = (unsigned long)(-1),	/* set whole bitmap */
 	.classify = (ce_classify_fct) rbce_tc_classify,
 	.class_delete = rbce_class_deletecb,
+	.class_add = rbce_class_addcb,
+#ifndef CRBCE_EXTENSION
 	.n_interest = (1 << CKRM_EVENT_MANUAL),
 	.notify = (ce_notify_fct) rbce_tc_notify,
 	.always_callback = 0,
+#else
+	.n_interest = (unsigned long)(-1),      /* set whole bitmap */
+	.notify = (ce_notify_fct) rbce_tc_ext_notify,
+	.always_callback = 1,
+#endif
 };
 
 /*============================================================================
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:46.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_internal.h	2005-06-20 13:08:48.000000000 -0700
@@ -202,6 +202,7 @@ enum op_token {
  *
  */
 struct rbce_private_data {
+	struct rbce_ext_private_data ext_data;
   	int evaluate;		/* whether to evaluate rules or not ? */
   	int rules_version;	/* rules_version at last evaluation */
 	bitvector_t *eval;
@@ -219,6 +220,7 @@ struct rbce_private_data {
 extern struct rbce_eng_callback rbce_rcfs_ecbs;
 extern int rbce_enabled;
 extern struct list_head rules_list[];
+extern struct list_head class_list;
 extern const int use_persistent_state;
 extern int gl_num_rules;
 extern int gl_bitmap_version;
@@ -251,4 +253,12 @@ extern void free_all_private_data(void);
 extern void unregister_classtype_engines(void);
 extern int register_classtype_engines(void);
 
+extern struct rbce_class *create_rbce_class(const char *, int, void *);
+extern void rbce_tc_manual(struct task_struct *);
+extern void notify_class_action(struct rbce_class *, int);
+extern void send_exit_notification(struct task_struct *);
+extern void rbce_tc_ext_notify(int, void *, struct task_struct *);
+extern int init_rbce_ext_pre(void);
+extern int init_rbce_ext_post(void);
+extern void exit_rbce_ext(void);
 #endif /* _RBCE_INTERNAL_H */
Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:46.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_main.c	2005-06-20 13:08:48.000000000 -0700
@@ -56,7 +56,7 @@ int termop_2_vecidx[RBCE_RULE_INVALID] =
 
 extern int errno;
 
-static LIST_HEAD(class_list);
+LIST_HEAD(class_list);
 struct list_head rules_list[CKRM_MAX_CLASSTYPES];
 static int gl_action, gl_num_terms;
 static int gl_released;
@@ -1205,11 +1205,16 @@ int init_rbce(void)
 		INIT_LIST_HEAD(&rules_list[i]);
 	}
 
-	rc = register_classtype_engines();
+	rc = init_rbce_ext_pre();
 	line = __LINE__;
 	if (rc)
 		goto out;
 
+	rc = register_classtype_engines();
+	line = __LINE__;
+	if (rc)
+		goto out_unreg_ckrm;
+
 	/* register any other class type engine here */
   	rc = rcfs_register_engine(&rbce_rcfs_ecbs);
   	line = __LINE__;
@@ -1219,13 +1224,22 @@ int init_rbce(void)
 	if (rcfs_mounted) {
 		rc = rbce_create_config();
 		line = __LINE__;
-		if (!rc)
-			goto out;
+		if (rc)
+			goto out_unreg_rcfs;
 	}
 
+	rc = init_rbce_ext_post();
+	line = __LINE__;
+	if (rc)
+		goto out_unreg_rcfs;
+	return 0;
+
+out_unreg_rcfs:
 	rcfs_unregister_engine(&rbce_rcfs_ecbs);
 out_unreg_classtype:
  	unregister_classtype_engines();
+out_unreg_ckrm:
+	exit_rbce_ext();
 out:
 	printk(KERN_ERR "%s: error installing rc=%d line=%d\n",
 		__FUNCTION__, rc, line);
@@ -1237,6 +1251,8 @@ void exit_rbce(void)
 	int i;
 	printk(KERN_INFO "Removing \'%s\' module\n", modname);
 
+	exit_rbce_ext();
+
 	/* Print warnings if lists are not empty, which is a bug */
 	if (!list_empty(&class_list)) {
 		printk(KERN_WARNING "exit_rbce: Class list is not empty\n");
Index: linux-2.6.12-ckrm1/include/linux/rbce.h
===================================================================
--- linux-2.6.12-ckrm1.orig/include/linux/rbce.h	2005-06-20 13:08:42.000000000 -0700
+++ linux-2.6.12-ckrm1/include/linux/rbce.h	2005-06-20 13:08:48.000000000 -0700
@@ -22,7 +22,57 @@
 #ifndef _LINUX_RBCE_H
 #define _LINUX_RBCE_H
 
+struct rbce_class;
+#ifndef CRBCE_EXTENSION
+
+/****************************************************************************
+ *
+ *   RBCE STANDALONE VERSION, NO CHOICE FOR DATA COLLECTION
+ *
+ ****************************************************************************/
+
 #define RBCE_MOD_DESCR "Rule Based Classification Engine Module for CKRM"
 #define RBCE_MOD_NAME  "rbce"
 
+struct rbce_ext_private_data {
+	/* no data */
+};
+static inline void send_exit_notification(struct task_struct *tsk)
+{
+}
+static inline void notify_class_action(struct rbce_class *cls, int action)
+{
+}
+/* extension initialization and destruction at module init and exit */
+static inline int init_rbce_ext_pre(void)
+{
+	return 0;
+}
+static inline int init_rbce_ext_post(void)
+{
+	return 0;
+}
+static inline void exit_rbce_ext(void)
+{
+}
+#else /* CRBCE_EXTENSION */
+
+/***************************************************************************
+ *
+ *   RBCE with User Level Notification
+ *
+ ***************************************************************************/
+
+#define RBCE_MOD_DESCR 	"Rule Based Classification Engine Module" \
+			"with Data Sampling/Delivery for CKRM"
+#define RBCE_MOD_NAME 	"crbce"
+
+#include <linux/crbce.h>
+
+struct rbce_ext_private_data {
+	struct task_sample_info sample;
+};
+
+#endif	/* CRBCE_EXTENSION */
+
 #endif	/* _LINUX_RBCE_H */

--
