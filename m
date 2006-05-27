Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWE0Buu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWE0Buu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 21:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWE0Buu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 21:50:50 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:17595 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751756AbWE0But (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 21:50:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>
Subject: [patch] cfq: ioprio inherit rt class
Date: Sat, 27 May 2006 11:50:41 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200605271150.41924.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, ml

I was wondering if cfq io priorities should be explicitly set to the realtime 
class when no io priority is specified from realtime tasks as in the 
following patch? (rt_task() will need to be modified to suit the PI changes in
-mm)

---
Set cfq io priority class to realtime and scale the priority according to the
rt priority when no io priority is explicitly set in realtime tasks.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 block/cfq-iosched.c    |    4 ++--
 include/linux/ioprio.h |   12 +++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc5-ck2/block/cfq-iosched.c
===================================================================
--- linux-2.6.17-rc5-ck2.orig/block/cfq-iosched.c	2006-05-25 21:32:45.000000000 +1000
+++ linux-2.6.17-rc5-ck2/block/cfq-iosched.c	2006-05-25 23:55:22.000000000 +1000
@@ -1334,10 +1334,10 @@ static void cfq_init_prio_data(struct cf
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
Index: linux-2.6.17-rc5-ck2/include/linux/ioprio.h
===================================================================
--- linux-2.6.17-rc5-ck2.orig/include/linux/ioprio.h	2006-05-25 23:02:06.000000000 +1000
+++ linux-2.6.17-rc5-ck2/include/linux/ioprio.h	2006-05-25 23:55:22.000000000 +1000
@@ -22,7 +22,7 @@
  * class, the default for any process. IDLE is the idle scheduling class, it
  * is only served when no one else is using the disk.
  */
-enum {
+enum ioprio_class {
 	IOPRIO_CLASS_NONE,
 	IOPRIO_CLASS_RT,
 	IOPRIO_CLASS_BE,
@@ -51,8 +51,18 @@ static inline int task_ioprio(struct tas
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
+		return (task->rt_priority * IOPRIO_BE_NR / MAX_RT_PRIO);
 	return (task_nice(task) + 20) / 5;
 }
 

-- 
-ck
