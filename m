Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266920AbUHIUIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266920AbUHIUIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUHIUD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:03:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51610 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266921AbUHIUBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:01:09 -0400
Message-Id: <200408092001.i79K1weQ045966@northrelay04.pok.ibm.com>
Subject: [PATCH 1/3] blk_queue_free_tags
To: akpm@osdl.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, brking@us.ibm.com
From: brking@us.ibm.com
Date: Mon, 09 Aug 2004 15:00:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a resend of three ll_rw_blk patches related to tagged queuing.

Currently blk_queue_free_tags cannot be called with ops outstanding. The
scsi_tcq API defined to LLD scsi drivers allows for scsi_deactivate_tcq
to be called (which calls blk_queue_free_tags) with ops outstanding. Change
blk_queue_free_tags to no longer free the tags, but rather just disable
tagged queuing and also modify blk_queue_init_tags to handle re-enabling
tagged queuing after it has been disabled.

Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.8-rc3-mm2-bjking1/drivers/block/ll_rw_blk.c |   35 ++++++++++++++----
 1 files changed, 28 insertions(+), 7 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~blk_queue_free_tags drivers/block/ll_rw_blk.c
--- linux-2.6.8-rc3-mm2/drivers/block/ll_rw_blk.c~blk_queue_free_tags	2004-08-09 14:10:50.000000000 -0500
+++ linux-2.6.8-rc3-mm2-bjking1/drivers/block/ll_rw_blk.c	2004-08-09 14:48:18.000000000 -0500
@@ -521,15 +521,14 @@ struct request *blk_queue_find_tag(reque
 EXPORT_SYMBOL(blk_queue_find_tag);
 
 /**
- * blk_queue_free_tags - release tag maintenance info
+ * __blk_queue_free_tags - release tag maintenance info
  * @q:  the request queue for the device
  *
  *  Notes:
  *    blk_cleanup_queue() will take care of calling this function, if tagging
- *    has been used. So there's usually no need to call this directly, unless
- *    tagging is just being disabled but the queue remains in function.
+ *    has been used. So there's no need to call this directly.
  **/
-void blk_queue_free_tags(request_queue_t *q)
+static void __blk_queue_free_tags(request_queue_t *q)
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
 
@@ -553,6 +552,19 @@ void blk_queue_free_tags(request_queue_t
 	q->queue_flags &= ~(1 << QUEUE_FLAG_QUEUED);
 }
 
+/**
+ * blk_queue_free_tags - release tag maintenance info
+ * @q:  the request queue for the device
+ *
+ *  Notes:
+ *	This is used to disabled tagged queuing to a device, yet leave
+ *	queue in function.
+ **/
+void blk_queue_free_tags(request_queue_t *q)
+{
+	clear_bit(QUEUE_FLAG_QUEUED, &q->queue_flags);
+}
+
 EXPORT_SYMBOL(blk_queue_free_tags);
 
 static int
@@ -603,13 +615,22 @@ fail:
 int blk_queue_init_tags(request_queue_t *q, int depth,
 			struct blk_queue_tag *tags)
 {
-	if (!tags) {
+	int rc;
+
+	BUG_ON(tags && q->queue_tags && tags != q->queue_tags);
+
+	if (!tags && !q->queue_tags) {
 		tags = kmalloc(sizeof(struct blk_queue_tag), GFP_ATOMIC);
 		if (!tags)
 			goto fail;
 
 		if (init_tag_map(q, tags, depth))
 			goto fail;
+	} else if (q->queue_tags) {
+		if ((rc = blk_queue_resize_tags(q, depth)))
+			return rc;
+		set_bit(QUEUE_FLAG_QUEUED, &q->queue_flags);
+		return 0;
 	} else
 		atomic_inc(&tags->refcnt);
 
@@ -1373,8 +1394,8 @@ void blk_cleanup_queue(request_queue_t *
 	if (rl->rq_pool)
 		mempool_destroy(rl->rq_pool);
 
-	if (blk_queue_tagged(q))
-		blk_queue_free_tags(q);
+	if (q->queue_tags)
+		__blk_queue_free_tags(q);
 
 	kmem_cache_free(requestq_cachep, q);
 }
_
