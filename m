Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272540AbRIWS2k>; Sun, 23 Sep 2001 14:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272619AbRIWS20>; Sun, 23 Sep 2001 14:28:26 -0400
Received: from mailf.telia.com ([194.22.194.25]:63468 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S272540AbRIWS2T>;
	Sun, 23 Sep 2001 14:28:19 -0400
Date: Sun, 23 Sep 2001 20:28:43 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: <petero@ppro.localdomain>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: PATCH: Small cleanup in ll_rw_block.c
Message-ID: <Pine.LNX.4.33.0109232021520.3686-100000@ppro.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch is extracted from the cd packet writing patch, but since it
seems to be a generic cleanup patch, not directly related to the packet
patch, maybe this should be included in the standard kernel.

The patch is for kernel 2.4.10-pre15.


--- linux/drivers/block/ll_rw_blk.c.orig	Sun Sep 23 20:11:14 2001
+++ linux/drivers/block/ll_rw_blk.c	Sun Sep 23 20:09:36 2001
@@ -415,7 +415,7 @@
 	q->head_active    	= 1;
 }

-#define blkdev_free_rq(list) list_entry((list)->next, struct request, table);
+#define blkdev_get_rq(list) list_entry((list)->next, struct request, table)
 /*
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.
@@ -425,7 +425,7 @@
 	struct request *rq = NULL;

 	if (!list_empty(&q->request_freelist[rw])) {
-		rq = blkdev_free_rq(&q->request_freelist[rw]);
+		rq = blkdev_get_rq(&q->request_freelist[rw]);
 		list_del(&rq->table);
 		rq->rq_status = RQ_ACTIVE;
 		rq->special = NULL;
@@ -459,18 +459,6 @@
 	return rq;
 }

-static inline struct request *get_request_wait(request_queue_t *q, int rw)
-{
-	register struct request *rq;
-
-	spin_lock_irq(&io_request_lock);
-	rq = get_request(q, rw);
-	spin_unlock_irq(&io_request_lock);
-	if (rq)
-		return rq;
-	return __get_request_wait(q, rw);
-}
-
 /* RO fail safe mechanism */

 static long ro_bits[MAX_BLKDEV][8];
@@ -978,7 +966,7 @@
 	/* Verify requested block sizes. */
 	for (i = 0; i < nr; i++) {
 		struct buffer_head *bh = bhs[i];
-		if (bh->b_size % correct_size) {
+		if (bh->b_size & (correct_size - 1)) {
 			printk(KERN_NOTICE "ll_rw_block: device %s: "
 			       "only %d-char blocks implemented (%u)\n",
 			       kdevname(bhs[0]->b_dev),
@@ -1039,7 +1027,6 @@
 extern int stram_device_init (void);
 #endif

-
 /**
  * end_that_request_first - end I/O on one buffer.
  * @req:      the request being processed
@@ -1066,8 +1053,8 @@

 	req->errors = 0;
 	if (!uptodate)
-		printk("end_request: I/O error, dev %s (%s), sector %lu\n",
-			kdevname(req->rq_dev), name, req->sector);
+		printk("end_request: I/O error, cmd %d dev %s (%s), sector %lu\n",
+			req->cmd, kdevname(req->rq_dev), name, req->sector);

 	if ((bh = req->bh) != NULL) {
 		nsect = bh->b_size >> 9;

-- 
Peter Österlund             petero2@telia.com
Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
S-128 66 Sköndal            +46 8 942647
Sweden

