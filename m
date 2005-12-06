Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVLFFQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVLFFQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLFFQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:16:53 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:55741 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964796AbVLFFQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:16:52 -0500
Subject: [RFC][PATCH 002/002]  Add timestamp field to process events
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
In-Reply-To: <1133845225.25202.1373.camel@stark>
References: <1133845225.25202.1373.camel@stark>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 21:06:52 -0800
Message-Id: <1133845612.25202.1377.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        This patch adds a timestamp field to the events sent via the process
event connector. The timestamp allows listeners to accurately account the
duration(s) between a process' events and offers strong means with which to
determine the order of events with respect to a given task while also avoiding
the addition of per-task data.

        This alters the size and layout of the event structure and hence would
break compatibility if process events connector as it stands in 2.6.15-rc2 were
released as a mainline kernel.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.15-rc5/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/connector/cn_proc.c
+++ linux-2.6.15-rc5/drivers/connector/cn_proc.c
@@ -54,10 +54,11 @@ void proc_fork_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
+	getnstimestamp(&ev->timestamp);
 	ev->what = PROC_EVENT_FORK;
 	ev->event_data.fork.parent_pid = task->real_parent->pid;
 	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
 	ev->event_data.fork.child_pid = task->pid;
 	ev->event_data.fork.child_tgid = task->tgid;
@@ -79,10 +80,11 @@ void proc_exec_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
+	getnstimestamp(&ev->timestamp);
 	ev->what = PROC_EVENT_EXEC;
 	ev->event_data.exec.process_pid = task->pid;
 	ev->event_data.exec.process_tgid = task->tgid;
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
@@ -112,10 +114,11 @@ void proc_id_connector(struct task_struc
 	   	ev->event_data.id.r.rgid = task->gid;
 	   	ev->event_data.id.e.egid = task->egid;
 	} else
 	     	return;
 	get_seq(&msg->seq, &ev->cpu);
+	getnstimestamp(&ev->timestamp);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
@@ -131,10 +134,11 @@ void proc_exit_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
+	getnstimestamp(&ev->timestamp);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
 	ev->event_data.exit.exit_code = task->exit_code;
 	ev->event_data.exit.exit_signal = task->exit_signal;
@@ -163,10 +167,11 @@ static void cn_proc_ack(int err, int rcv
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	msg->seq = rcvd_seq;
+	getnstimestamp(&ev->timestamp);
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
 


