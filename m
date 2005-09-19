Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVISPHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVISPHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 11:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVISPHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 11:07:17 -0400
Received: from verein.lst.de ([213.95.11.210]:6575 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932454AbVISPHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 11:07:16 -0400
Date: Mon, 19 Sep 2005 17:07:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remov blkdev_scsi_issue_flush_fn again
Message-ID: <20050919150709.GA13478@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This function was removed a while ago, but crept in again via a recent
scsi merge.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-09-18 13:47:02.000000000 +0200
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-09-19 15:11:23.000000000 +0200
@@ -2373,44 +2373,6 @@
 
 EXPORT_SYMBOL(blkdev_issue_flush);
 
-/**
- * blkdev_scsi_issue_flush_fn - issue flush for SCSI devices
- * @q:		device queue
- * @disk:	gendisk
- * @error_sector:	error offset
- *
- * Description:
- *    Devices understanding the SCSI command set, can use this function as
- *    a helper for issuing a cache flush. Note: driver is required to store
- *    the error offset (in case of error flushing) in ->sector of struct
- *    request.
- */
-int blkdev_scsi_issue_flush_fn(request_queue_t *q, struct gendisk *disk,
-			       sector_t *error_sector)
-{
-	struct request *rq = blk_get_request(q, WRITE, __GFP_WAIT);
-	int ret;
-
-	rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
-	rq->sector = 0;
-	memset(rq->cmd, 0, sizeof(rq->cmd));
-	rq->cmd[0] = 0x35;
-	rq->cmd_len = 12;
-	rq->data = NULL;
-	rq->data_len = 0;
-	rq->timeout = 60 * HZ;
-
-	ret = blk_execute_rq(q, disk, rq, 0);
-
-	if (ret && error_sector)
-		*error_sector = rq->sector;
-
-	blk_put_request(rq);
-	return ret;
-}
-
-EXPORT_SYMBOL(blkdev_scsi_issue_flush_fn);
-
 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io)
 {
 	int rw = rq_data_dir(rq);
