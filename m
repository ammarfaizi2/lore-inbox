Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWGNJjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWGNJjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWGNJjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:39:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59197 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964811AbWGNJjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:39:09 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH 1/3] Remove ->waiting member from struct request
Date: Fri, 14 Jul 2006 11:41:54 +0200
Message-Id: <11528701163959-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11528701161633-git-send-email-axboe@suse.de>
References: <11528701161633-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the comments indicates in blkdev.h, we can fold it into ->end_io_data
usage as that is really what ->waiting is. Fixup the users of
blk_end_sync_rq().

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/elevator.c          |    3 +--
 block/ll_rw_blk.c         |   11 ++++-------
 drivers/block/DAC960.c    |    2 +-
 drivers/block/paride/pd.c |    3 +--
 drivers/block/pktcdvd.c   |    2 +-
 drivers/ide/ide-io.c      |    3 +--
 drivers/ide/ide-tape.c    |    2 +-
 include/linux/blkdev.h    |    3 +--
 8 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 9cd2805..69215a6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -67,8 +67,7 @@ inline int elv_rq_merge_ok(struct reques
 	/*
 	 * same device and no special stuff set, merge is ok
 	 */
-	if (rq->rq_disk == bio->bi_bdev->bd_disk &&
-	    !rq->waiting && !rq->special)
+	if (rq->rq_disk == bio->bi_bdev->bd_disk && !rq->special)
 		return 1;
 
 	return 0;
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 4018254..0ed0e83 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -291,7 +291,6 @@ static inline void rq_init(request_queue
 	rq->buffer = NULL;
 	rq->ref_count = 1;
 	rq->q = q;
-	rq->waiting = NULL;
 	rq->special = NULL;
 	rq->data_len = 0;
 	rq->data = NULL;
@@ -2536,10 +2535,9 @@ int blk_execute_rq(request_queue_t *q, s
 		rq->sense_len = 0;
 	}
 
-	rq->waiting = &wait;
+	rq->end_io_data = &wait;
 	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
 	wait_for_completion(&wait);
-	rq->waiting = NULL;
 
 	if (rq->errors)
 		err = -EIO;
@@ -2703,9 +2701,9 @@ EXPORT_SYMBOL(blk_put_request);
  */
 void blk_end_sync_rq(struct request *rq, int error)
 {
-	struct completion *waiting = rq->waiting;
+	struct completion *waiting = rq->end_io_data;
 
-	rq->waiting = NULL;
+	rq->end_io_data = NULL;
 	__blk_put_request(rq->q, rq);
 
 	/*
@@ -2756,7 +2754,7 @@ static int attempt_merge(request_queue_t
 
 	if (rq_data_dir(req) != rq_data_dir(next)
 	    || req->rq_disk != next->rq_disk
-	    || next->waiting || next->special)
+	    || next->special)
 		return 0;
 
 	/*
@@ -2841,7 +2839,6 @@ static void init_request_from_bio(struct
 	req->nr_phys_segments = bio_phys_segments(req->q, bio);
 	req->nr_hw_segments = bio_hw_segments(req->q, bio);
 	req->buffer = bio_data(bio);	/* see ->buffer comment above */
-	req->waiting = NULL;
 	req->bio = req->biotail = bio;
 	req->ioprio = bio_prio(bio);
 	req->rq_disk = bio->bi_bdev->bd_disk;
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 4cd23c3..62cc2b2 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -3331,7 +3331,7 @@ static int DAC960_process_queue(DAC960_C
 		Command->DmaDirection = PCI_DMA_TODEVICE;
 		Command->CommandType = DAC960_WriteCommand;
 	}
-	Command->Completion = Request->waiting;
+	Command->Completion = Request->end_io_data;
 	Command->LogicalDriveNumber = (long)Request->rq_disk->private_data;
 	Command->BlockNumber = Request->sector;
 	Command->BlockCount = Request->nr_sectors;
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 2403721..87f6828 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -722,11 +722,10 @@ static int pd_special_command(struct pd_
 	rq.rq_status = RQ_ACTIVE;
 	rq.rq_disk = disk->gd;
 	rq.ref_count = 1;
-	rq.waiting = &wait;
+	rq.end_io_data = &wait;
 	rq.end_io = blk_end_sync_rq;
 	blk_insert_request(disk->gd->queue, &rq, 0, func);
 	wait_for_completion(&wait);
-	rq.waiting = NULL;
 	if (rq.errors)
 		err = -EIO;
 	blk_put_request(&rq);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index bde2c64..d79dcd0 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -375,7 +375,7 @@ static int pkt_generic_packet(struct pkt
 
 	rq->ref_count++;
 	rq->flags |= REQ_NOMERGE;
-	rq->waiting = &wait;
+	rq->end_io_data = &wait;
 	rq->end_io = blk_end_sync_rq;
 	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
 	generic_unplug_device(q);
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index fb67952..8753a50 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1718,7 +1718,7 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	 */
 	if (must_wait) {
 		rq->ref_count++;
-		rq->waiting = &wait;
+		rq->end_io_data = &wait;
 		rq->end_io = blk_end_sync_rq;
 	}
 
@@ -1736,7 +1736,6 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	err = 0;
 	if (must_wait) {
 		wait_for_completion(&wait);
-		rq->waiting = NULL;
 		if (rq->errors)
 			err = -EIO;
 
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 7067ab9..acf2e4f 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2773,7 +2773,7 @@ #if IDETAPE_DEBUG_BUGS
 		return;
 	}
 #endif /* IDETAPE_DEBUG_BUGS */
-	rq->waiting = &wait;
+	rq->end_io_data = &wait;
 	rq->end_io = blk_end_sync_rq;
 	spin_unlock_irq(&tape->spinlock);
 	wait_for_completion(&wait);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ba4378f..575d3e8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -185,7 +185,6 @@ struct request {
 	request_queue_t *q;
 	struct request_list *rl;
 
-	struct completion *waiting;
 	void *special;
 	char *buffer;
 
@@ -204,7 +203,7 @@ struct request {
 	int retries;
 
 	/*
-	 * completion callback. end_io_data should be folded in with waiting
+	 * completion callback.
 	 */
 	rq_end_io_fn *end_io;
 	void *end_io_data;
-- 
1.4.1.ged0e0

