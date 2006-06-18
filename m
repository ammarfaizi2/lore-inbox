Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWFRHjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWFRHjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWFRHer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:34:47 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:1003 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932145AbWFRHeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:34:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][21/29] mm-kswapd_inherit_prio-1.patch
Date: Sun, 18 Jun 2006 17:34:24 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4514
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181734.25067.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When kswapd is awoken due to reclaim by a running task, set the priority of
kswapd to that of the calling task thus making memory reclaim cpu activity
affected by nice level.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/mmzone.h |    2 +-
 mm/page_alloc.c        |    2 +-
 mm/vmscan.c            |   40 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 4 deletions(-)

Index: linux-ck-dev/include/linux/mmzone.h
===================================================================
--- linux-ck-dev.orig/include/linux/mmzone.h	2006-06-18 15:25:00.000000000 +1000
+++ linux-ck-dev/include/linux/mmzone.h	2006-06-18 15:25:02.000000000 +1000
@@ -330,7 +330,7 @@ void __get_zone_counts(unsigned long *ac
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free);
 void build_all_zonelists(void);
-void wakeup_kswapd(struct zone *zone, int order);
+void wakeup_kswapd(struct zone *zone, int order, struct task_struct *p);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
 		int classzone_idx, int alloc_flags);
 
Index: linux-ck-dev/mm/page_alloc.c
===================================================================
--- linux-ck-dev.orig/mm/page_alloc.c	2006-06-18 15:25:00.000000000 +1000
+++ linux-ck-dev/mm/page_alloc.c	2006-06-18 15:25:02.000000000 +1000
@@ -952,7 +952,7 @@ restart:
 
 	do {
 		if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
-			wakeup_kswapd(*z, order);
+			wakeup_kswapd(*z, order, p);
 	} while (*(++z));
 
 	/*
Index: linux-ck-dev/mm/vmscan.c
===================================================================
--- linux-ck-dev.orig/mm/vmscan.c	2006-06-18 15:25:00.000000000 +1000
+++ linux-ck-dev/mm/vmscan.c	2006-06-18 15:25:02.000000000 +1000
@@ -897,6 +897,38 @@ static unsigned long shrink_zone(int pri
 }
 
 /*
+ * Helper functions to adjust nice level of kswapd, based on the priority of
+ * the task (p) that called it. If it is already higher priority we do not
+ * demote its nice level since it is still working on behalf of a higher
+ * priority task. With kernel threads we leave it at nice 0.
+ *
+ * We don't ever run kswapd real time, so if a real time task calls kswapd we
+ * set it to highest SCHED_NORMAL priority.
+ */
+static int effective_sc_prio(struct task_struct *p)
+{
+	if (likely(p->mm)) {
+		if (rt_task(p))
+			return -20;
+		return task_nice(p);
+	}
+	return 0;
+}
+
+static void set_kswapd_nice(task_t *kswapd, task_t *p, int active)
+{
+	long nice = effective_sc_prio(p);
+
+	if (task_nice(kswapd) > nice || !active)
+		set_user_nice(kswapd, nice);
+}
+
+static int sc_priority(struct task_struct *p)
+{
+	return (DEF_PRIORITY + (DEF_PRIORITY * effective_sc_prio(p) / 40));
+}
+
+/*
  * This is the direct reclaim path, for page-allocating processes.  We only
  * try to reclaim pages from zones which will satisfy the caller's allocation
  * request.
@@ -1266,6 +1298,7 @@ static int kswapd(void *p)
 			 */
 			order = new_order;
 		} else {
+			set_user_nice(tsk, 0);
 			schedule();
 			order = pgdat->kswapd_max_order;
 		}
@@ -1279,9 +1312,10 @@ static int kswapd(void *p)
 /*
  * A zone is low on free memory, so wake its kswapd task to service it.
  */
-void wakeup_kswapd(struct zone *zone, int order)
+void wakeup_kswapd(struct zone *zone, int order, struct task_struct *p)
 {
 	pg_data_t *pgdat;
+	int active;
 
 	if (!populated_zone(zone))
 		return;
@@ -1293,7 +1327,9 @@ void wakeup_kswapd(struct zone *zone, in
 		pgdat->kswapd_max_order = order;
 	if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
 		return;
-	if (!waitqueue_active(&pgdat->kswapd_wait))
+	active = waitqueue_active(&pgdat->kswapd_wait);
+	set_kswapd_nice(pgdat->kswapd, p, active);
+	if (!active)
 		return;
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }

-- 
-ck
