Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSFAIg3>; Sat, 1 Jun 2002 04:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSFAIg2>; Sat, 1 Jun 2002 04:36:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41482 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315412AbSFAIg1>;
	Sat, 1 Jun 2002 04:36:27 -0400
Message-ID: <3CF88852.BCFBF774@zip.com.au>
Date: Sat, 01 Jun 2002 01:39:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [patch 1/16] unplugging fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There's a plugging bug in 2.5.19.  Once you start pushing several disks
hard, the new unplug code gets confused and queues are left in plugged
state, but not on the plug list.  They never get unplugged and the
machine dies mysteriously.

I exchanged a stream of emails and patches with Jens Thursday/Friday,
but none of it worked.

This patch makes all the locking and initialisation paths much more
defensive.  It does fix the bug, but I'm not actually sure where the
bug is.  This is an "unofficial" patch - Jens is offline for a few
days.  But if you plan to release a kernel soon I'd suggest that it
include this patch.



=====================================

--- 2.5.19/drivers/block/ll_rw_blk.c~blk-plug	Sat Jun  1 01:18:04 2002
+++ 2.5.19-akpm/drivers/block/ll_rw_blk.c	Sat Jun  1 01:18:04 2002
@@ -49,7 +49,7 @@ extern int mac_floppy_init(void);
  */
 static kmem_cache_t *request_cachep;
 
-static struct list_head blk_plug_list;
+static LIST_HEAD(blk_plug_list);
 static spinlock_t blk_plug_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* blk_dev_struct is:
@@ -156,6 +156,7 @@ void blk_queue_make_request(request_queu
 	 */
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 
+	INIT_LIST_HEAD(&q->plug_list);
 	init_waitqueue_head(&q->queue_wait);
 }
 
@@ -782,17 +783,18 @@ static int ll_merge_requests_fn(request_
  */
 void blk_plug_device(request_queue_t *q)
 {
+	unsigned long flags;
+
 	/*
 	 * common case
 	 */
 	if (!elv_queue_empty(q))
 		return;
 
-	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags)) {
-		spin_lock(&blk_plug_lock);
+	spin_lock_irqsave(&blk_plug_lock, flags);
+	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
 		list_add_tail(&q->plug_list, &blk_plug_list);
-		spin_unlock(&blk_plug_lock);
-	}
+	spin_unlock_irqrestore(&blk_plug_lock, flags);
 }
 
 /*
@@ -803,7 +805,7 @@ static inline void __generic_unplug_devi
 	/*
 	 * not plugged
 	 */
-	if (!__test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+	if (!test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
 		return;
 
 	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
@@ -866,44 +868,36 @@ void blk_stop_queue(request_queue_t *q)
  */
 void blk_run_queues(void)
 {
-	struct list_head *n, *tmp, local_plug_list;
+	LIST_HEAD(local_plug_list);
 	unsigned long flags;
 
-	INIT_LIST_HEAD(&local_plug_list);
-
 	/*
 	 * this will happen fairly often
 	 */
 	spin_lock_irqsave(&blk_plug_lock, flags);
-	if (list_empty(&blk_plug_list)) {
-		spin_unlock_irqrestore(&blk_plug_lock, flags);
-		return;
-	}
+	if (list_empty(&blk_plug_list))
+		goto out;
 
 	list_splice(&blk_plug_list, &local_plug_list);
 	INIT_LIST_HEAD(&blk_plug_list);
-	spin_unlock_irqrestore(&blk_plug_lock, flags);
 
-	/*
-	 * local_plug_list is now a private copy we can traverse lockless
-	 */
-	list_for_each_safe(n, tmp, &local_plug_list) {
-		request_queue_t *q = list_entry(n, request_queue_t, plug_list);
+	while (!list_empty(&local_plug_list)) {
+		request_queue_t *q;
 
-		if (!test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
-			list_del(&q->plug_list);
+		q = list_entry(local_plug_list.next,
+				request_queue_t, plug_list);
+
+		list_del(&q->plug_list);
+		if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
+			list_add_tail(&q->plug_list, &blk_plug_list);
+		} else {
+			spin_unlock_irqrestore(&blk_plug_lock, flags);
 			generic_unplug_device(q);
+			spin_lock_irqsave(&blk_plug_lock, flags);
 		}
 	}
-
-	/*
-	 * add any remaining queue back to plug list
-	 */
-	if (!list_empty(&local_plug_list)) {
-		spin_lock_irqsave(&blk_plug_lock, flags);
-		list_splice(&local_plug_list, &blk_plug_list);
-		spin_unlock_irqrestore(&blk_plug_lock, flags);
-	}
+out:
+	spin_unlock_irqrestore(&blk_plug_lock, flags);
 }
 
 static int __blk_cleanup_queue(struct request_list *list)
@@ -1056,8 +1050,6 @@ int blk_init_queue(request_queue_t *q, r
 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
 
-	INIT_LIST_HEAD(&q->plug_list);
-
 	return 0;
 }
 
@@ -1938,8 +1930,6 @@ int __init blk_dev_init(void)
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
 
-	INIT_LIST_HEAD(&blk_plug_list);
-
 #if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_HD)
 	hd_init();
 #endif

-
