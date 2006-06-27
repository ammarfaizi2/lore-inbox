Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWF0Lyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWF0Lyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWF0Lyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:54:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:19683 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932466AbWF0Lyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:54:38 -0400
Subject: [RFC][PATCH 3/3] Process events biarch bug: New process events
	connector value
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060627112644.804066367@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 04:49:35 -0700
Message-Id: <1151408975.21787.1815.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Deprecate" existing Process Events connector interface and add a new one
that works cleanly on biarch platforms.

Any expansion of the previous event structure would break userspace's ability
to workaround the biarch incompatibility problem. Hence this patch creates a
new interface and generates events (for both when necessary).

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 drivers/connector/cn_proc.c |   65 +++++++++++++++++++++++++++++---------------
 include/linux/cn_proc.h     |   23 ++++++++++-----
 include/linux/connector.h   |    3 +-
 3 files changed, 61 insertions(+), 30 deletions(-)

Index: linux-2.6.17-mm3-biarch/include/linux/connector.h
===================================================================
--- linux-2.6.17-mm3-biarch.orig/include/linux/connector.h
+++ linux-2.6.17-mm3-biarch/include/linux/connector.h
@@ -29,11 +29,12 @@
 
 /*
  * Process Events connector unique ids -- used for message routing
  */
 #define CN_IDX_PROC			0x1
-#define CN_VAL_PROC			0x1
+#define CN_VAL_PROC_DEPRECATED		0x1 /* deprecated */
+#define CN_VAL_PROC			0x2
 #define CN_IDX_CIFS			0x2
 #define CN_VAL_CIFS                     0x1
 #define CN_W1_IDX			0x3	/* w1 communication */
 #define CN_W1_VAL			0x1
 
Index: linux-2.6.17-mm3-biarch/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.17-mm3-biarch.orig/drivers/connector/cn_proc.c
+++ linux-2.6.17-mm3-biarch/drivers/connector/cn_proc.c
@@ -30,13 +30,19 @@
 #include <linux/notifier.h>
 #include <asm/atomic.h>
 
 #include <linux/cn_proc.h>
 
-#define CN_PROC_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct proc_event))
-
-static atomic_t proc_event_num_listeners = ATOMIC_INIT(0);
+#define CN_PROC_MSG_SIZE (sizeof(struct cn_msg) + \
+			  max(sizeof(struct proc_event), \
+			      sizeof(struct proc_event_deprecated)))
+
+static atomic_t proc_event_num_old_listeners = ATOMIC_INIT(0);
+static struct cb_id cn_proc_event_deprecated_id = {
+	CN_IDX_PROC,
+	CN_VAL_PROC_DEPRECATED
+};
 static struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
 
 /* proc_event_counts is used as the sequence number of the netlink message */
 static DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };
 
@@ -100,18 +106,18 @@ static inline void proc_exit_connector(s
  * mechanisms.
  */
 static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
 {
 	struct cn_msg *msg;
-	struct proc_event *ev;
+	struct proc_event_deprecated *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (atomic_read(&proc_event_num_old_listeners) < 1)
 		return;
 
 	msg = (struct cn_msg*)buffer;
-	ev = (struct proc_event*)msg->data;
+	ev = (struct proc_event_deprecated*)msg->data;
 	msg->seq = rcvd_seq;
 	ktime_get_ts(&ev->timestamp);
 	ev->cpu = -1;
 	ev->what = PROC_EVENT_NONE;
 	ev->event_data.ack.err = err;
@@ -123,11 +129,11 @@ static void cn_proc_ack(int err, int rcv
 
 /**
  * cn_proc_mcast_ctl
  * @data: message sent from userspace via the connector
  */
-static void cn_proc_mcast_ctl(void *data)
+static void cn_proc_mcast_old_ctl(void *data)
 {
 	struct cn_msg *msg = data;
 	enum proc_cn_mcast_op *mc_op = NULL;
 	int err = 0;
 
@@ -135,14 +141,14 @@ static void cn_proc_mcast_ctl(void *data
 		return;
 
 	mc_op = (enum proc_cn_mcast_op*)msg->data;
 	switch (*mc_op) {
 	case PROC_CN_MCAST_LISTEN:
-		atomic_inc(&proc_event_num_listeners);
+		atomic_inc(&proc_event_num_old_listeners);
 		break;
 	case PROC_CN_MCAST_IGNORE:
-		atomic_dec(&proc_event_num_listeners);
+		atomic_dec(&proc_event_num_old_listeners);
 		break;
 	default:
 		err = EINVAL;
 		break;
 	}
@@ -158,16 +164,15 @@ static int cn_proc_watch_task(struct not
 			      void *t)
 {
 	struct task_struct *task = t;
 	struct cn_msg *msg;
 	struct proc_event *ev;
+	struct proc_event_deprecated *ev_old;
+	struct timespec timestamp;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 	int rc = NOTIFY_OK;
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
-		return rc;
-
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	switch (get_watch_event(val)) {
 	case WATCH_TASK_CLONE:
 		proc_fork_connector(task, ev);
@@ -189,16 +194,26 @@ static int cn_proc_watch_task(struct not
 		break;
 	}
 	if (rc != NOTIFY_OK)
 		return rc;
 	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp); /* get high res monotonic timestamp */
+	ktime_get_ts(&timestamp); /* get high res monotonic timestamp */
+	ev->timestamp_ns = ((__u64)timestamp.tv_sec*(__u64)NSEC_PER_SEC) + (__u64)timestamp.tv_nsec;
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
 	/* If cn_netlink_send() fails, drop data */
+
+	if (atomic_read(&proc_event_num_old_listeners) < 1)
+		return rc;
+	ev_old = (struct proc_event_deprecated*)msg->data;
+	msg->len = sizeof(*ev_old);
+	memmove(&ev_old->event_data, &ev->event_data, sizeof(ev->event_data));
+	memcpy(&ev_old->timestamp, &timestamp, sizeof(timestamp));
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
+	/* If cn_netlink_send() fails, drop data */
 	return rc;
 }
 
 static struct notifier_block __read_mostly cn_proc_nb = {
 	.notifier_call = cn_proc_watch_task,
@@ -211,20 +226,27 @@ static struct notifier_block __read_most
  */
 static int __init cn_proc_init(void)
 {
 	int err;
 
-	if ((err = cn_add_callback(&cn_proc_event_id, "cn_proc",
-	 			   &cn_proc_mcast_ctl))) {
-		printk(KERN_WARNING "cn_proc failed to register\n");
-		goto out;
-	}
+	err = cn_add_callback(&cn_proc_event_deprecated_id, "cn_proc_old",
+			      &cn_proc_mcast_old_ctl);
+	if (err)
+		goto error_old;
+	err = cn_add_callback(&cn_proc_event_id, "cn_proc", NULL);
+	if (err)
+		goto error;
 
 	err = register_task_watcher(&cn_proc_nb);
-	if (err != 0)
-		cn_del_callback(&cn_proc_event_id);
-out:
+	if (err)
+		goto error;
+	return err;
+error:
+	cn_del_callback(&cn_proc_event_id);
+error_old:
+	cn_del_callback(&cn_proc_event_deprecated_id);
+	printk(KERN_WARNING "cn_proc failed to register\n");
 	return err;
 }
 
 static void cn_proc_fini(void)
 {
@@ -234,10 +256,11 @@ static void cn_proc_fini(void)
 	if (err != 0)
 		printk(KERN_WARNING
 		       "cn_proc failed to unregister its task notify block\n");
 
 	cn_del_callback(&cn_proc_event_id);
+	cn_del_callback(&cn_proc_event_deprecated_id);
 }
 
 module_init(cn_proc_init);
 module_exit(cn_proc_fini);
 
Index: linux-2.6.17-mm3-biarch/include/linux/cn_proc.h
===================================================================
--- linux-2.6.17-mm3-biarch.orig/include/linux/cn_proc.h
+++ linux-2.6.17-mm3-biarch/include/linux/cn_proc.h
@@ -55,18 +55,11 @@ struct proc_event {
 		/* "next" should be 0x00000400 */
 		/* "last" is the last process event: exit */
 		PROC_EVENT_EXIT = 0x80000000
 	} what;
 	__u32 cpu;
-
- 	/*
- 	 * UGH! timespec is biarch incompatible. See
- 	 * Documentation/connector/process_events.txt if you're going to listen
- 	 * for process events in userspace.
- 	 */
-	struct timespec timestamp;
-
+	__u64 timestamp_ns;
 	union process_event_data { /* must be last field of proc_event struct */
 		struct {
 			__u32 err;
 		} ack;
 
@@ -100,6 +93,20 @@ struct proc_event {
 			pid_t process_tgid;
 			__u32 exit_code, exit_signal;
 		} exit;
 	} event_data;
 };
+
+struct proc_event_deprecated {
+	enum what what;
+	__u32 cpu;
+
+	/*
+	 * UGH! timespec is biarch incompatible. See
+	 * Documentation/connector/process_events.txt if you're going to listen
+	 * for process events in userspace.
+	 */
+	struct timespec timestamp;
+	union process_event_data event_data;
+};
+
 #endif	/* CN_PROC_H */

--

