Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbVLOEkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbVLOEkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbVLOEkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:40:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21638 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1160998AbVLOEkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:40:00 -0500
Subject: Re: [PATCH 002/003] Switch getnstimestamp() calls to ktime_get_ts()
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       George Anzinger <george@mvista.com>
In-Reply-To: <1134620987.7372.35.camel@stark>
References: <1134620987.7372.35.camel@stark>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 20:35:04 -0800
Message-Id: <1134621304.7372.40.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use ktime_get_ts() to take the timestamp instead of getnstimestamp(). This
patch prepares to remove getnstimestamp() by switching its only user to
a different function with almost exactly the same code.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.15-rc5-mm2/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/drivers/connector/cn_proc.c
+++ linux-2.6.15-rc5-mm2/drivers/connector/cn_proc.c
@@ -22,10 +22,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/init.h>
 #include <asm/atomic.h>
 
 #include <linux/cn_proc.h>
 
@@ -54,11 +55,11 @@ void proc_fork_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
-	getnstimestamp(&ev->timestamp);
+	ktime_get_ts(&ev->timestamp); /* get high res monotonic timestamp */
 	ev->what = PROC_EVENT_FORK;
 	ev->event_data.fork.parent_pid = task->real_parent->pid;
 	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
 	ev->event_data.fork.child_pid = task->pid;
 	ev->event_data.fork.child_tgid = task->tgid;
@@ -80,11 +81,11 @@ void proc_exec_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
-	getnstimestamp(&ev->timestamp);
+	ktime_get_ts(&ev->timestamp);
 	ev->what = PROC_EVENT_EXEC;
 	ev->event_data.exec.process_pid = task->pid;
 	ev->event_data.exec.process_tgid = task->tgid;
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
@@ -114,11 +115,11 @@ void proc_id_connector(struct task_struc
 	   	ev->event_data.id.r.rgid = task->gid;
 	   	ev->event_data.id.e.egid = task->egid;
 	} else
 	     	return;
 	get_seq(&msg->seq, &ev->cpu);
-	getnstimestamp(&ev->timestamp);
+	ktime_get_ts(&ev->timestamp);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
@@ -134,11 +135,11 @@ void proc_exit_connector(struct task_str
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
-	getnstimestamp(&ev->timestamp);
+	ktime_get_ts(&ev->timestamp);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
 	ev->event_data.exit.exit_code = task->exit_code;
 	ev->event_data.exit.exit_signal = task->exit_signal;
@@ -167,11 +168,11 @@ static void cn_proc_ack(int err, int rcv
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	msg->seq = rcvd_seq;
-	getnstimestamp(&ev->timestamp);
+	ktime_get_ts(&ev->timestamp);
 	ev->cpu = -1;
 	ev->what = PROC_EVENT_NONE;
 	ev->event_data.ack.err = err;
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = rcvd_ack + 1;


