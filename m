Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVLFCaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVLFCaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVLFCaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:30:06 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59520 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964938AbVLFCaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:30:04 -0500
Subject: [RFC][PATCH]  Add timestamp to process event connector message
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       ay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 18:21:57 -0800
Message-Id: <1133835717.25202.1317.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        This patch adds a timestamp field to the events sent via the process
event connector. The timestamp allows listeners to accurately account the
duration(s) between a process' events and offers strong means with which to
determine the order of events while also avoiding the addition of per-task data.

        This alters the size and layout of the event structure and hence would
break compatibility if process events connector as it stands in 2.6.15-rc5 were
released as a mainline kernel.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.15-rc5/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/connector/cn_proc.c
+++ linux-2.6.15-rc5/drivers/connector/cn_proc.c
@@ -42,10 +42,31 @@ static inline void get_seq(__u32 *ts, in
 	*ts = get_cpu_var(proc_event_counts)++;
 	*cpu = smp_processor_id();
 	put_cpu_var(proc_event_counts);
 }
 
+static inline void get_timestamp(struct timespec *ts)
+{
+	unsigned int seq;
+	struct timespec wall2mono;
+
+	/* synchronize with settimeofday() changes */
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		getnstimeofday(ts);
+		wall2mono = wall_to_monotonic;
+	} while(read_seqretry(&xtime_lock, seq));
+
+	/* adjust to monotonicaly-increasing values */
+	ts += wall2mono.tv_sec;
+	ts += wall2mono.tv_nsec;
+	while ((ts->tv_nsec - NSEC_PER_SEC) >= 0) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+}
+
 void proc_fork_connector(struct task_struct *task)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
@@ -54,10 +75,11 @@ void proc_fork_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
+	get_timestamp(&ev->timestamp);
 	ev->what = PROC_EVENT_FORK;
 	ev->event_data.fork.parent_pid = task->real_parent->pid;
 	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
 	ev->event_data.fork.child_pid = task->pid;
 	ev->event_data.fork.child_tgid = task->tgid;
@@ -79,10 +101,11 @@ void proc_exec_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
+	get_timestamp(&ev->timestamp);
 	ev->what = PROC_EVENT_EXEC;
 	ev->event_data.exec.process_pid = task->pid;
 	ev->event_data.exec.process_tgid = task->tgid;
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
@@ -112,10 +135,11 @@ void proc_id_connector(struct task_struc
 	   	ev->event_data.id.r.rgid = task->gid;
 	   	ev->event_data.id.e.egid = task->egid;
 	} else
 	     	return;
 	get_seq(&msg->seq, &ev->cpu);
+	get_timestamp(&ev->timestamp);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
@@ -131,10 +155,11 @@ void proc_exit_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
+	get_timestamp(&ev->timestamp);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
 	ev->event_data.exit.exit_code = task->exit_code;
 	ev->event_data.exit.exit_signal = task->exit_signal;
@@ -163,10 +188,11 @@ static void cn_proc_ack(int err, int rcv
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	msg->seq = rcvd_seq;
+	get_timestamp(&ev->timestamp);
 	ev->cpu = -1;
 	ev->what = PROC_EVENT_NONE;
 	ev->event_data.ack.err = err;
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = rcvd_ack + 1;
Index: linux-2.6.15-rc5/include/linux/cn_proc.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/cn_proc.h
+++ linux-2.6.15-rc5/include/linux/cn_proc.h
@@ -24,10 +24,11 @@
 
 #ifndef CN_PROC_H
 #define CN_PROC_H
 
 #include <linux/types.h>
+#include <linux/time.h>
 #include <linux/connector.h>
 
 /*
  * Userspace sends this enum to register with the kernel that it is listening
  * for events on the connector.
@@ -63,10 +64,11 @@ struct proc_event {
 		/* "next" should be 0x00000400 */
 		/* "last" is the last process event: exit */
 		PROC_EVENT_EXIT = 0x80000000
 	} what;
 	__u32 cpu;
+	struct timespec timestamp;
 	union { /* must be last field of proc_event struct */
 		struct {
 			__u32 err;
 		} ack;
 


