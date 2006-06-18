Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWFRHiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWFRHiO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWFRHfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:35:06 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:26552 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932141AbWFRHe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:34:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][23/29] mm-background_scan-1.patch
Date: Sun, 18 Jun 2006 17:34:49 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4364
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181734.49367.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a background scanning timer to restore the watermarks to the pages_lots
level and only call on it if kswapd has not been called upon for the last 5
seconds. This allows us to balance all zones to the more generous pages_lots
watermark at a time unrelated to page allocation thus leading to lighter
levels of vm load when called upon under page allocation.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/mmzone.h |    2 ++
 mm/vmscan.c            |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

Index: linux-ck-dev/include/linux/mmzone.h
===================================================================
--- linux-ck-dev.orig/include/linux/mmzone.h	2006-06-18 15:25:02.000000000 +1000
+++ linux-ck-dev/include/linux/mmzone.h	2006-06-18 15:25:07.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/seqlock.h>
 #include <linux/nodemask.h>
+#include <linux/timer.h>
 #include <asm/atomic.h>
 #include <asm/page.h>
 
@@ -312,6 +313,7 @@ typedef struct pglist_data {
 	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
 	int kswapd_max_order;
+	struct timer_list watermark_timer;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
Index: linux-ck-dev/mm/vmscan.c
===================================================================
--- linux-ck-dev.orig/mm/vmscan.c	2006-06-18 15:25:05.000000000 +1000
+++ linux-ck-dev/mm/vmscan.c	2006-06-18 15:25:07.000000000 +1000
@@ -35,6 +35,7 @@
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 #include <linux/delay.h>
+#include <linux/timer.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1244,6 +1245,8 @@ out:
 	return nr_reclaimed;
 }
 
+#define WT_EXPIRY	(HZ * 5)	/* Time to wakeup watermark_timer */
+
 /*
  * The background pageout daemon, started as a kernel thread
  * from the init process. 
@@ -1294,6 +1297,8 @@ static int kswapd(void *p)
 
 		try_to_freeze();
 
+		/* kswapd has been busy so delay watermark_timer */
+		mod_timer(&pgdat->watermark_timer, jiffies + WT_EXPIRY);
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		new_order = pgdat->kswapd_max_order;
 		pgdat->kswapd_max_order = 0;
@@ -1517,12 +1522,41 @@ static int cpu_callback(struct notifier_
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+/*
+ * We wake up kswapd every WT_EXPIRY till free ram is above pages_lots
+ */
+static void watermark_wakeup(unsigned long data)
+{
+	pg_data_t *pgdat = (pg_data_t *)data;
+	struct timer_list *wt = &pgdat->watermark_timer;
+	int i;
+
+	if (!waitqueue_active(&pgdat->kswapd_wait) || above_background_load())
+		goto out;
+	for (i = pgdat->nr_zones - 1; i >= 0; i--) {
+		struct zone *z = pgdat->node_zones + i;
+
+		if (!populated_zone(z) || is_highmem(z)) {
+			/* We are better off leaving highmem full */
+			continue;
+		}
+		if (!zone_watermark_ok(z, 0, z->pages_lots, 0, 0)) {
+			wake_up_interruptible(&pgdat->kswapd_wait);
+			goto out;
+		}
+	}
+out:
+	mod_timer(wt, jiffies + WT_EXPIRY);
+	return;
+}
+
 static int __init kswapd_init(void)
 {
 	pg_data_t *pgdat;
 
 	swap_setup();
 	for_each_online_pgdat(pgdat) {
+		struct timer_list *wt = &pgdat->watermark_timer;
 		pid_t pid;
 
 		pid = kernel_thread(kswapd, pgdat, CLONE_KERNEL);
@@ -1530,6 +1564,11 @@ static int __init kswapd_init(void)
 		read_lock(&tasklist_lock);
 		pgdat->kswapd = find_task_by_pid(pid);
 		read_unlock(&tasklist_lock);
+		init_timer(wt);
+		wt->data = (unsigned long)pgdat;
+		wt->function = watermark_wakeup;
+		wt->expires = jiffies + WT_EXPIRY;
+		add_timer(wt);
 	}
 	total_memory = nr_free_pagecache_pages();
 	hotcpu_notifier(cpu_callback, 0);

-- 
-ck
