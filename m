Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWFNACd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWFNACd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWFNACb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:02:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:25823 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964819AbWFNACI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:02:08 -0400
Subject: [PATCH 03/11] Task watchers:  Refactor process events
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:54:39 -0700
Message-Id: <1150242879.21787.143.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the process events code by factoring many of the common
pieces into the task watcher notifier function. This factoring was enabled
by switching to task watchers instead of calling process events functions
directly.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
--

 drivers/connector/cn_proc.c |  113 +++++++++++++-------------------------------
 1 files changed, 34 insertions(+), 79 deletions(-)

Index: linux-2.6.17-rc6-mm2/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/connector/cn_proc.c
+++ linux-2.6.17-rc6-mm2/drivers/connector/cn_proc.c
@@ -45,113 +45,52 @@ static inline void get_seq(__u32 *ts, in
 	*ts = get_cpu_var(proc_event_counts)++;
 	*cpu = smp_processor_id();
 	put_cpu_var(proc_event_counts);
 }
 
-static void proc_fork_connector(struct task_struct *task)
+static inline void proc_fork_connector(struct task_struct *task,
+				       struct proc_event *ev)
 {
-	struct cn_msg *msg;
-	struct proc_event *ev;
-	__u8 buffer[CN_PROC_MSG_SIZE];
-
-	if (atomic_read(&proc_event_num_listeners) < 1)
-		return;
-
-	msg = (struct cn_msg*)buffer;
-	ev = (struct proc_event*)msg->data;
-	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp); /* get high res monotonic timestamp */
 	ev->what = PROC_EVENT_FORK;
 	ev->event_data.fork.parent_pid = task->real_parent->pid;
 	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
 	ev->event_data.fork.child_pid = task->pid;
 	ev->event_data.fork.child_tgid = task->tgid;
-
-	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
-	msg->ack = 0; /* not used */
-	msg->len = sizeof(*ev);
-	/*  If cn_netlink_send() failed, the data is not sent */
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
 }
 
-static void proc_exec_connector(struct task_struct *task)
+static inline void proc_exec_connector(struct task_struct *task,
+				       struct proc_event *ev)
 {
-	struct cn_msg *msg;
-	struct proc_event *ev;
-	__u8 buffer[CN_PROC_MSG_SIZE];
-
-	if (atomic_read(&proc_event_num_listeners) < 1)
-		return;
-
-	msg = (struct cn_msg*)buffer;
-	ev = (struct proc_event*)msg->data;
-	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp);
 	ev->what = PROC_EVENT_EXEC;
 	ev->event_data.exec.process_pid = task->pid;
 	ev->event_data.exec.process_tgid = task->tgid;
-
-	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
-	msg->ack = 0; /* not used */
-	msg->len = sizeof(*ev);
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
 }
 
-static void proc_id_connector(struct task_struct *task, int which_id)
+static inline void proc_id_connector(struct task_struct *task, int which_id,
+		       		     struct proc_event *ev)
 {
-	struct cn_msg *msg;
-	struct proc_event *ev;
-	__u8 buffer[CN_PROC_MSG_SIZE];
-
-	if (atomic_read(&proc_event_num_listeners) < 1)
-		return;
-
-	msg = (struct cn_msg*)buffer;
-	ev = (struct proc_event*)msg->data;
 	ev->what = which_id;
 	ev->event_data.id.process_pid = task->pid;
 	ev->event_data.id.process_tgid = task->tgid;
 	if (which_id == PROC_EVENT_UID) {
 	 	ev->event_data.id.r.ruid = task->uid;
 	 	ev->event_data.id.e.euid = task->euid;
 	} else if (which_id == PROC_EVENT_GID) {
 	   	ev->event_data.id.r.rgid = task->gid;
 	   	ev->event_data.id.e.egid = task->egid;
-	} else
-	     	return;
-	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp);
-
-	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
-	msg->ack = 0; /* not used */
-	msg->len = sizeof(*ev);
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
+	}
+	WARN_ON((which_id != PROC_EVENT_UID) && (which_id != PROC_EVENT_GID));
 }
 
-static void proc_exit_connector(struct task_struct *task)
+static inline void proc_exit_connector(struct task_struct *task,
+				       struct proc_event *ev)
 {
-	struct cn_msg *msg;
-	struct proc_event *ev;
-	__u8 buffer[CN_PROC_MSG_SIZE];
-
-	if (atomic_read(&proc_event_num_listeners) < 1)
-		return;
-
-	msg = (struct cn_msg*)buffer;
-	ev = (struct proc_event*)msg->data;
-	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
 	ev->event_data.exit.exit_code = task->exit_code;
 	ev->event_data.exit.exit_signal = task->exit_signal;
-
-	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
-	msg->ack = 0; /* not used */
-	msg->len = sizeof(*ev);
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
 }
 
 /*
  * Send an acknowledgement message to userspace
  *
@@ -217,33 +156,49 @@ static void cn_proc_mcast_ctl(void *data
  */
 static int cn_proc_watch_task(struct notifier_block *nb, unsigned long val,
 			      void *t)
 {
 	struct task_struct *task = t;
+	struct cn_msg *msg;
+	struct proc_event *ev;
+	__u8 buffer[CN_PROC_MSG_SIZE];
 	int rc = NOTIFY_OK;
 
+	if (atomic_read(&proc_event_num_listeners) < 1)
+		return rc;
+
+	msg = (struct cn_msg*)buffer;
+	ev = (struct proc_event*)msg->data;
 	switch (get_watch_event(val)) {
 	case WATCH_TASK_CLONE:
-		proc_fork_connector(task);
+		proc_fork_connector(task, ev);
 		break;
 	case WATCH_TASK_EXEC:
-		proc_exec_connector(task);
+		proc_exec_connector(task, ev);
 		break;
 	case WATCH_TASK_UID:
-		proc_id_connector(task, PROC_EVENT_UID);
+		proc_id_connector(task, PROC_EVENT_UID, ev);
 		break;
 	case WATCH_TASK_GID:
-		proc_id_connector(task, PROC_EVENT_GID);
+		proc_id_connector(task, PROC_EVENT_GID, ev);
 		break;
 	case WATCH_TASK_EXIT:
-		proc_exit_connector(task);
+		proc_exit_connector(task, ev);
 		break;
-	default: /* we don't care about WATCH_TASK_INIT|FREE because we
-		    don't keep per-task info */
-		rc = NOTIFY_DONE; /* ignore all other notifications */
+	default: /* ignore WATCH_TASK_INIT|FREE - we don't keep per-task info */
+		rc = NOTIFY_DONE;
 		break;
 	}
+	if (rc != NOTIFY_OK)
+		return rc;
+	get_seq(&msg->seq, &ev->cpu);
+	ktime_get_ts(&ev->timestamp); /* get high res monotonic timestamp */
+	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
+	msg->ack = 0; /* not used */
+	msg->len = sizeof(*ev);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
+	/* If cn_netlink_send() fails, drop data */
 	return rc;
 }
 
 static struct notifier_block __read_mostly cn_proc_nb = {
 	.notifier_call = cn_proc_watch_task,

--

