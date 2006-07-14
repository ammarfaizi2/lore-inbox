Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbWGNQpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbWGNQpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWGNQpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:45:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:11201 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161259AbWGNQpS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:45:18 -0400
Subject: Process Events: Fix biarch compatibility issue. use __u64 timestamp
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Date: Fri, 14 Jul 2006 09:45:13 -0700
Message-Id: <1152895513.19016.12.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Andrew,

Events sent by Process Events Connector from a 64-bit kernel are not binary
compatible with a 32-bit userspace program because the "timestamp" field
(struct timespec) is not arch independent. This affects the fields
that follow "timestamp" as they will be be off by 8 bytes.

This is a problem for 32-bit userspace programs running with 64-bit kernels
on ppc64, s390, x86-64.. any "biarch" system.

Matt had submitted a different solution to lkml as an RFC earlier. We have since
switched to a solution recommended by Evgeniy Polyakov.

This patch fixes the problem by changing the timestamp to be a __u64, which
stores the number of nanoseconds.

Tested on a x86_64 system with both 32 bit application and 64 bit
application and on a i386 system.

Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
---
Index: linux-2.6.18-rc1/include/linux/cn_proc.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/cn_proc.h	2006-07-13 15:14:25.000000000 -0700
+++ linux-2.6.18-rc1/include/linux/cn_proc.h	2006-07-13 15:14:38.000000000 -0700
@@ -57,7 +57,8 @@ struct proc_event {
 		PROC_EVENT_EXIT = 0x80000000
 	} what;
 	__u32 cpu;
-	struct timespec timestamp;
+	__u64 __attribute__((aligned(8))) timestamp_ns;
+		/* Number of nano seconds since system boot */
 	union { /* must be last field of proc_event struct */
 		struct {
 			__u32 err;
Index: linux-2.6.18-rc1/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.18-rc1.orig/drivers/connector/cn_proc.c	2006-07-13 15:14:25.000000000 -0700
+++ linux-2.6.18-rc1/drivers/connector/cn_proc.c	2006-07-13 15:16:36.000000000 -0700
@@ -51,6 +51,7 @@ void proc_fork_connector(struct task_str
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
+	struct timespec ts;
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
 		return;
@@ -58,7 +59,8 @@ void proc_fork_connector(struct task_str
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp); /* get high res monotonic timestamp */
+	ktime_get_ts(&ts); /* get high res monotonic timestamp */
+	ev->timestamp_ns = timespec_to_ns(&ts);
 	ev->what = PROC_EVENT_FORK;
 	ev->event_data.fork.parent_pid = task->real_parent->pid;
 	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
@@ -76,6 +78,7 @@ void proc_exec_connector(struct task_str
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
+	struct timespec ts;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
@@ -84,7 +87,8 @@ void proc_exec_connector(struct task_str
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp);
+	ktime_get_ts(&ts); /* get high res monotonic timestamp */
+	ev->timestamp_ns = timespec_to_ns(&ts);
 	ev->what = PROC_EVENT_EXEC;
 	ev->event_data.exec.process_pid = task->pid;
 	ev->event_data.exec.process_tgid = task->tgid;
@@ -100,6 +104,7 @@ void proc_id_connector(struct task_struc
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
+	struct timespec ts;
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
 		return;
@@ -118,7 +123,8 @@ void proc_id_connector(struct task_struc
 	} else
 	     	return;
 	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp);
+	ktime_get_ts(&ts); /* get high res monotonic timestamp */
+	ev->timestamp_ns = timespec_to_ns(&ts);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
@@ -131,6 +137,7 @@ void proc_exit_connector(struct task_str
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
+	struct timespec ts;
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
 		return;
@@ -138,7 +145,8 @@ void proc_exit_connector(struct task_str
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp);
+	ktime_get_ts(&ts); /* get high res monotonic timestamp */
+	ev->timestamp_ns = timespec_to_ns(&ts);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
@@ -164,6 +172,7 @@ static void cn_proc_ack(int err, int rcv
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
+	struct timespec ts;
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
 		return;
@@ -171,7 +180,8 @@ static void cn_proc_ack(int err, int rcv
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	msg->seq = rcvd_seq;
-	ktime_get_ts(&ev->timestamp);
+	ktime_get_ts(&ts); /* get high res monotonic timestamp */
+	ev->timestamp_ns = timespec_to_ns(&ts);
 	ev->cpu = -1;
 	ev->what = PROC_EVENT_NONE;
 	ev->event_data.ack.err = err;

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


