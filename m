Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWGGVoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWGGVoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWGGVoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:44:24 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3796 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751258AbWGGVoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:44:23 -0400
Subject: Process events: Fix biarch compatibility
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 14:38:52 -0700
Message-Id: <1152308332.21787.2178.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Argh! I neglected to put linux-kernel on the cc list. Patch is
unchanged.

Andrew, I'd like to revise my request and shoot for eventual inclusion
in 2.6.18 if it's not too much to ask. What do you think?

Cheers,
	-Matt Helsley

From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Guillaume Thouvenin
<guillaume.thouvenin@bull.net>, Albert Cahalan <acahalan@gmail.com>,
Chandra S. Seetharaman <sekharan@us.ibm.com>
Date: Thu, 06 Jul 2006 23:05:16 -0700
Subject: Process events: Fix biarch compatibility

Switch timestamp to two 32-bit scalars instead of two long fields of
a timespec struct. This fixes an issue with biarch systems where the kernel was
sending two 64-bit fields and a naive 32-bit userspace program was expecting
two 32-bit fields. Naive userspace applications that used the timespec directly
are broken. This allows more of the naieve apps to work correctly and all apps 
that are correct to continue to work.

I submitted a different solution as an RFC earlier and have since switched to
the solution recommended by Evgeniy Polyakov.

Compiles with linux-2.6.17-mm6, boots, and tested with and without -m32 on x86-64.

Andrew, please consider this patch for inclusion in -mm.

Thanks,
	-Matt Helsley

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
---
 drivers/connector/cn_proc.c |   10 ++++++++--
 include/linux/cn_proc.h     |    3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-2.6.17/include/linux/cn_proc.h
===================================================================
--- linux-2.6.17.orig/include/linux/cn_proc.h
+++ linux-2.6.17/include/linux/cn_proc.h
@@ -55,11 +55,12 @@ struct proc_event {
 		/* "next" should be 0x00000400 */
 		/* "last" is the last process event: exit */
 		PROC_EVENT_EXIT = 0x80000000
 	} what;
 	__u32 cpu;
-	struct timespec timestamp;
+	__u32 timestamp_sec;
+	__u32 timestamp_nsec;
 	union { /* must be last field of proc_event struct */
 		struct {
 			__u32 err;
 		} ack;
 
Index: linux-2.6.17/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.17.orig/drivers/connector/cn_proc.c
+++ linux-2.6.17/drivers/connector/cn_proc.c
@@ -102,18 +102,21 @@ static inline void proc_exit_connector(s
 static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
+	struct timespec ts;
 
 	if (atomic_read(&proc_event_num_listeners) < 1)
 		return;
 
 	msg = (struct cn_msg*)buffer;
 	ev = (struct proc_event*)msg->data;
 	msg->seq = rcvd_seq;
-	ktime_get_ts(&ev->timestamp);
+	ktime_get_ts(&ts);
+	ev->timestamp_sec = ts.tv_sec;
+	ev->timestamp_nsec = ts.tv_nsec;
 	ev->cpu = -1;
 	ev->what = PROC_EVENT_NONE;
 	ev->event_data.ack.err = err;
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = rcvd_ack + 1;
@@ -155,10 +158,11 @@ static void cn_proc_mcast_ctl(void *data
  * generation function.
  */
 static int cn_proc_watch_task(struct notifier_block *nb, unsigned long val,
 			      void *t)
 {
+	struct timespec ts;
 	struct task_struct *task = t;
 	struct cn_msg *msg;
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE];
 	int rc = NOTIFY_OK;
@@ -189,11 +193,13 @@ static int cn_proc_watch_task(struct not
 		break;
 	}
 	if (rc != NOTIFY_OK)
 		return rc;
 	get_seq(&msg->seq, &ev->cpu);
-	ktime_get_ts(&ev->timestamp); /* get high res monotonic timestamp */
+	ktime_get_ts(&ts); /* get high res monotonic timestamp */
+	ev->timestamp_sec = ts.tv_sec;
+	ev->timestamp_nsec = ts.tv_nsec;
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
 	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
 	/* If cn_netlink_send() fails, drop data */


