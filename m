Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWFRHdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWFRHdR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFRHcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:32:31 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:2531 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932131AbWFRHb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:31:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][12/29] cfq-ioprio_inherit_rt_class.patch
Date: Sun, 18 Jun 2006 17:31:54 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2735
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181731.54904.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a realtime task does not explicitly set an ioprio make it inherit the
realtime class and a priority dependant on its realtime priority.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 block/cfq-iosched.c    |    4 ++--
 include/linux/ioprio.h |   13 ++++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

Index: linux-ck-dev/block/cfq-iosched.c
===================================================================
--- linux-ck-dev.orig/block/cfq-iosched.c	2006-06-18 15:20:13.000000000 +1000
+++ linux-ck-dev/block/cfq-iosched.c	2006-06-18 15:23:53.000000000 +1000
@@ -1354,10 +1354,10 @@ static void cfq_init_prio_data(struct cf
 			printk(KERN_ERR "cfq: bad prio %x\n", ioprio_class);
 		case IOPRIO_CLASS_NONE:
 			/*
-			 * no prio set, place us in the middle of the BE classes
+			 * Select class and ioprio according to policy and nice
 			 */
+			cfqq->ioprio_class = task_policy_ioprio_class(tsk);
 			cfqq->ioprio = task_nice_ioprio(tsk);
-			cfqq->ioprio_class = IOPRIO_CLASS_BE;
 			break;
 		case IOPRIO_CLASS_RT:
 			cfqq->ioprio = task_ioprio(tsk);
Index: linux-ck-dev/include/linux/ioprio.h
===================================================================
--- linux-ck-dev.orig/include/linux/ioprio.h	2006-06-18 15:20:13.000000000 +1000
+++ linux-ck-dev/include/linux/ioprio.h	2006-06-18 15:23:53.000000000 +1000
@@ -22,7 +22,7 @@
  * class, the default for any process. IDLE is the idle scheduling class, it
  * is only served when no one else is using the disk.
  */
-enum {
+enum ioprio_class {
 	IOPRIO_CLASS_NONE,
 	IOPRIO_CLASS_RT,
 	IOPRIO_CLASS_BE,
@@ -51,8 +51,19 @@ static inline int task_ioprio(struct tas
 	return IOPRIO_PRIO_DATA(task->ioprio);
 }
 
+static inline enum ioprio_class
+	task_policy_ioprio_class(struct task_struct *task)
+{
+	if (rt_task(task))
+		return IOPRIO_CLASS_RT;
+	return IOPRIO_CLASS_BE;
+}
+
 static inline int task_nice_ioprio(struct task_struct *task)
 {
+	if (rt_task(task))
+		return (MAX_RT_PRIO - task->rt_priority) * IOPRIO_BE_NR /
+			MAX_RT_PRIO;
 	return (task_nice(task) + 20) / 5;
 }
 

-- 
-ck
