Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266766AbUHCRrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266766AbUHCRrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUHCRrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:47:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:36581 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266766AbUHCRra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:47:30 -0400
Message-ID: <410FCFAF.3090207@us.ibm.com>
Date: Tue, 03 Aug 2004 12:47:27 -0500
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] blk_queue_free_tags
Content-Type: multipart/mixed;
 boundary="------------040305000104070609050800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040305000104070609050800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------040305000104070609050800
Content-Type: text/plain;
 name="blk_queue_free_tags.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk_queue_free_tags.patch"


Currently blk_queue_free_tags cannot be called with ops outstanding. The
scsi_tcq API defined to LLD scsi drivers allows for scsi_deactivate_tcq
to be called (which calls blk_queue_free_tags) with ops outstanding. Change
blk_queue_free_tags to no longer free the tags, but rather just disable
tagged queuing and also modify blk_queue_init_tags to handle re-enabling
tagged queuing after it has been disabled.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.8-rc2-bjking1/drivers/block/ll_rw_blk.c |   35 +++++++++++++++++-----
 1 files changed, 28 insertions(+), 7 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~blk_queue_free_tags drivers/block/ll_rw_blk.c
--- linux-2.6.8-rc2/drivers/block/ll_rw_blk.c~blk_queue_free_tags	2004-08-03 10:53:50.000000000 -0500
+++ linux-2.6.8-rc2-bjking1/drivers/block/ll_rw_blk.c	2004-08-03 11:05:06.000000000 -0500
@@ -482,15 +482,14 @@ struct request *blk_queue_find_tag(reque
 EXPORT_SYMBOL(blk_queue_find_tag);
 
 /**
- * blk_queue_free_tags - release tag maintenance info
+ * _blk_queue_free_tags - release tag maintenance info
  * @q:  the request queue for the device
  *
  *  Notes:
  *    blk_cleanup_queue() will take care of calling this function, if tagging
- *    has been used. So there's usually no need to call this directly, unless
- *    tagging is just being disabled but the queue remains in function.
+ *    has been used. So there's no need to call this directly.
  **/
-void blk_queue_free_tags(request_queue_t *q)
+static void _blk_queue_free_tags(request_queue_t *q)
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
 
@@ -514,6 +513,19 @@ void blk_queue_free_tags(request_queue_t
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
@@ -564,13 +576,22 @@ fail:
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
 
@@ -1333,8 +1354,8 @@ void blk_cleanup_queue(request_queue_t *
 	if (rl->rq_pool)
 		mempool_destroy(rl->rq_pool);
 
-	if (blk_queue_tagged(q))
-		blk_queue_free_tags(q);
+	if (q->queue_tags)
+		_blk_queue_free_tags(q);
 
 	kmem_cache_free(requestq_cachep, q);
 }
_

--------------040305000104070609050800--

