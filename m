Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWFRHj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWFRHj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWFRHc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:32:26 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:2030 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932139AbWFRHcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:32:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][13/29] cfq-iso_idleprio_ionice.patch
Date: Sun, 18 Jun 2006 17:32:04 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2332
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181732.04800.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For SCHED_ISO and SCHED_IDLEPRIO tasks where no ioprio is explicitly set:

Set ioprio to best priority normal class for SCHED_ISO tasks.

Set ioprio to idle class for SCHED_IDLEPRIO tasks.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 block/cfq-iosched.c    |    2 ++
 include/linux/ioprio.h |    6 ++++++
 2 files changed, 8 insertions(+)

Index: linux-ck-dev/include/linux/ioprio.h
===================================================================
--- linux-ck-dev.orig/include/linux/ioprio.h	2006-06-18 15:23:53.000000000 +1000
+++ linux-ck-dev/include/linux/ioprio.h	2006-06-18 15:23:56.000000000 +1000
@@ -56,6 +56,8 @@ static inline enum ioprio_class
 {
 	if (rt_task(task))
 		return IOPRIO_CLASS_RT;
+	if (idleprio_task(task))
+		return IOPRIO_CLASS_IDLE;
 	return IOPRIO_CLASS_BE;
 }
 
@@ -64,6 +66,10 @@ static inline int task_nice_ioprio(struc
 	if (rt_task(task))
 		return (MAX_RT_PRIO - task->rt_priority) * IOPRIO_BE_NR /
 			MAX_RT_PRIO;
+	if (iso_task(task))
+		return 0;
+	if (idleprio_task(task))
+		return IOPRIO_BE_NR - 1;
 	return (task_nice(task) + 20) / 5;
 }
 
Index: linux-ck-dev/block/cfq-iosched.c
===================================================================
--- linux-ck-dev.orig/block/cfq-iosched.c	2006-06-18 15:23:53.000000000 +1000
+++ linux-ck-dev/block/cfq-iosched.c	2006-06-18 15:23:56.000000000 +1000
@@ -1358,6 +1358,8 @@ static void cfq_init_prio_data(struct cf
 			 */
 			cfqq->ioprio_class = task_policy_ioprio_class(tsk);
 			cfqq->ioprio = task_nice_ioprio(tsk);
+			if (cfqq->ioprio_class == IOPRIO_CLASS_IDLE)
+				cfq_clear_cfqq_idle_window(cfqq);
 			break;
 		case IOPRIO_CLASS_RT:
 			cfqq->ioprio = task_ioprio(tsk);

-- 
-ck
