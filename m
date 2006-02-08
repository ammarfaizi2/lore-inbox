Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbWBHI5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbWBHI5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbWBHI5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:57:35 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:47327 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030580AbWBHI5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:57:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=WH8X1Qf8s1XJY/XaSLGR3HfLDp/VxlUi2EPxjDKGcmMFiQqCtfjK7I+5xNre4Gb4qKjzR8EMzNO2mkQnBU4Bjc/esFgsFGRGACOqYoK98DiPwr0lmizcctKFF03Mm37p1K5X6pFf+y+a1QOYLE1Rn91rzhzyEqaVftLjqI9sYfM=
Date: Wed, 8 Feb 2006 17:57:28 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] block: kill not-so-popular simple flag testing macros
Message-ID: <20060208085728.GA21065@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills the following request flag testing macros.

blk_noretry_request()
blk_rq_started()
blk_pm_suspend_request()
blk_pm_resume_request()
blk_sorted_rq()
blk_barrier_rq()
blk_fua_rq()

All above macros test for single request flag and not used widely and
seem to contribute more to obscurity than readability.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jens, patch is against ac171c46667c1cb2ee9e22312291df6ed78e1b6e (the
current -linus) but it also applies with offsets to -linus +
elv_insert patch.

 block/elevator.c          |    8 ++++----
 block/ll_rw_blk.c         |    2 +-
 drivers/ide/ide-cd.c      |    2 +-
 drivers/ide/ide-io.c      |   12 ++++++------
 drivers/scsi/scsi_error.c |    4 ++--
 drivers/scsi/scsi_lib.c   |    2 +-
 drivers/scsi/sd.c         |    6 +++---
 include/linux/blkdev.h    |   11 ++---------
 8 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 2fc269f..371d2db 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -287,7 +287,7 @@ void elv_requeue_request(request_queue_t
 	 */
 	if (blk_account_rq(rq)) {
 		q->in_flight--;
-		if (blk_sorted_rq(rq) && e->ops->elevator_deactivate_req_fn)
+		if (rq->flags & REQ_SORTED && e->ops->elevator_deactivate_req_fn)
 			e->ops->elevator_deactivate_req_fn(q, rq);
 	}
 
@@ -323,7 +323,7 @@ void __elv_add_request(request_queue_t *
 		/*
 		 * toggle ordered color
 		 */
-		if (blk_barrier_rq(rq))
+		if (rq->flags & REQ_HARDBARRIER)
 			q->ordcolor ^= 1;
 
 		/*
@@ -465,7 +465,7 @@ struct request *elv_next_request(request
 			 * sees this request (possibly after
 			 * requeueing).  Notify IO scheduler.
 			 */
-			if (blk_sorted_rq(rq) &&
+			if (rq->flags & REQ_SORTED &&
 			    e->ops->elevator_activate_req_fn)
 				e->ops->elevator_activate_req_fn(q, rq);
 
@@ -602,7 +602,7 @@ void elv_completed_request(request_queue
 	 */
 	if (blk_account_rq(rq)) {
 		q->in_flight--;
-		if (blk_sorted_rq(rq) && e->ops->elevator_completed_req_fn)
+		if (rq->flags & REQ_SORTED && e->ops->elevator_completed_req_fn)
 			e->ops->elevator_completed_req_fn(q, rq);
 	}
 
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index ee5ed98..91da489 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -509,7 +509,7 @@ static inline struct request *start_orde
 int blk_do_ordered(request_queue_t *q, struct request **rqp)
 {
 	struct request *rq = *rqp;
-	int is_barrier = blk_fs_request(rq) && blk_barrier_rq(rq);
+	int is_barrier = blk_fs_request(rq) && rq->flags & REQ_HARDBARRIER;
 
 	if (!q->ordseq) {
 		if (!is_barrier)
diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
diff --git a/drivers/cdrom/sonycd535.c b/drivers/cdrom/sonycd535.c
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 3325660..0e6a70b 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -712,7 +712,7 @@ static int cdrom_decode_status(ide_drive
 
 		/* Handle errors from READ and WRITE requests. */
 
-		if (blk_noretry_request(rq))
+		if (rq->flags & REQ_FAILFAST)
 			do_end_request = 1;
 
 		if (sense_key == NOT_READY) {
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index c01615d..859ecde 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -66,7 +66,7 @@ static int __ide_end_request(ide_drive_t
 	 * if failfast is set on a request, override number of sectors and
 	 * complete the whole request right now
 	 */
-	if (blk_noretry_request(rq) && end_io_error(uptodate))
+	if (rq->flags & REQ_FAILFAST && end_io_error(uptodate))
 		nr_sectors = rq->hard_nr_sectors;
 
 	if (!blk_fs_request(rq) && end_io_error(uptodate) && !rq->errors)
@@ -233,10 +233,10 @@ static void ide_complete_pm_request (ide
 
 #ifdef DEBUG_PM
 	printk("%s: completing PM request, %s\n", drive->name,
-	       blk_pm_suspend_request(rq) ? "suspend" : "resume");
+	       rq->flags & REQ_PM_SUSPEND ? "suspend" : "resume");
 #endif
 	spin_lock_irqsave(&ide_lock, flags);
-	if (blk_pm_suspend_request(rq)) {
+	if (rq->flags & REQ_PM_SUSPEND) {
 		blk_stop_queue(drive->queue);
 	} else {
 		drive->blocked = 0;
@@ -451,7 +451,7 @@ static ide_startstop_t ide_ata_error(ide
 		/* force an abort */
 		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
 
-	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq))
+	if (rq->errors >= ERROR_MAX || rq->flags & REQ_FAILFAST)
 		ide_kill_rq(drive, rq);
 	else {
 		if ((rq->errors & ERROR_RESET) == ERROR_RESET) {
@@ -909,11 +909,11 @@ static ide_startstop_t start_request (id
 	if (block == 0 && drive->remap_0_to_1 == 1)
 		block = 1;  /* redirect MBR access to EZ-Drive partn table */
 
-	if (blk_pm_suspend_request(rq) &&
+	if (rq->flags & REQ_PM_SUSPEND &&
 	    rq->pm->pm_step == ide_pm_state_start_suspend)
 		/* Mark drive blocked when starting the suspend sequence. */
 		drive->blocked = 1;
-	else if (blk_pm_resume_request(rq) &&
+	else if (rq->flags & REQ_PM_RESUME &&
 		 rq->pm->pm_step == ide_pm_state_start_resume) {
 		/* 
 		 * The first thing we do on wakeup is to wait for BSY bit to
diff --git a/drivers/message/i2o/i2o_block.c b/drivers/message/i2o/i2o_block.c
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 5cc97b7..965ba28 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1309,7 +1309,7 @@ int scsi_decide_disposition(struct scsi_
 	 * even if the request is marked fast fail, we still requeue
 	 * for queue congestion conditions (QUEUE_FULL or BUSY) */
 	if ((++scmd->retries) < scmd->allowed 
-	    && !blk_noretry_request(scmd->request)) {
+	    && !(scmd->request->flags & REQ_FAILFAST)) {
 		return NEEDS_RETRY;
 	} else {
 		/*
@@ -1432,7 +1432,7 @@ static void scsi_eh_flush_done_q(struct 
 	list_for_each_entry_safe(scmd, next, done_q, eh_entry) {
 		list_del_init(&scmd->eh_entry);
 		if (scsi_device_online(scmd->device) &&
-		    !blk_noretry_request(scmd->request) &&
+		    !(scmd->request->flags & REQ_FAILFAST) &&
 		    (++scmd->retries < scmd->allowed)) {
 			SCSI_LOG_ERROR_RECOVERY(3, printk("%s: flush"
 							  " retry cmd: %p\n",
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4a60285..0a9da5c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -771,7 +771,7 @@ static struct scsi_cmnd *scsi_end_reques
 			leftover = req->data_len;
 
 		/* kill remainder if no retrys */
-		if (!uptodate && blk_noretry_request(req))
+		if (!uptodate && req->flags & REQ_FAILFAST)
 			end_that_request_chunk(req, 0, leftover);
 		else {
 			if (requeue) {
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 930db39..3bb1d33 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -323,7 +323,7 @@ static int sd_init_command(struct scsi_c
 	
 	if (block > 0xffffffff) {
 		SCpnt->cmnd[0] += READ_16 - READ_6;
-		SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
+		SCpnt->cmnd[1] |= rq->flags & REQ_FUA ? 0x8 : 0;
 		SCpnt->cmnd[2] = sizeof(block) > 4 ? (unsigned char) (block >> 56) & 0xff : 0;
 		SCpnt->cmnd[3] = sizeof(block) > 4 ? (unsigned char) (block >> 48) & 0xff : 0;
 		SCpnt->cmnd[4] = sizeof(block) > 4 ? (unsigned char) (block >> 40) & 0xff : 0;
@@ -343,7 +343,7 @@ static int sd_init_command(struct scsi_c
 			this_count = 0xffff;
 
 		SCpnt->cmnd[0] += READ_10 - READ_6;
-		SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
+		SCpnt->cmnd[1] |= rq->flags & REQ_FUA ? 0x8 : 0;
 		SCpnt->cmnd[2] = (unsigned char) (block >> 24) & 0xff;
 		SCpnt->cmnd[3] = (unsigned char) (block >> 16) & 0xff;
 		SCpnt->cmnd[4] = (unsigned char) (block >> 8) & 0xff;
@@ -352,7 +352,7 @@ static int sd_init_command(struct scsi_c
 		SCpnt->cmnd[7] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[8] = (unsigned char) this_count & 0xff;
 	} else {
-		if (unlikely(blk_fua_rq(rq))) {
+		if (unlikely(rq->flags & REQ_FUA)) {
 			/*
 			 * This happens only if this drive failed
 			 * 10byte rw command with ILLEGAL_REQUEST
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 860e7a4..06cd868 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -489,20 +489,13 @@ enum {
 
 #define blk_fs_request(rq)	((rq)->flags & REQ_CMD)
 #define blk_pc_request(rq)	((rq)->flags & REQ_BLOCK_PC)
-#define blk_noretry_request(rq)	((rq)->flags & REQ_FAILFAST)
-#define blk_rq_started(rq)	((rq)->flags & REQ_STARTED)
 
-#define blk_account_rq(rq)	(blk_rq_started(rq) && blk_fs_request(rq))
+#define blk_account_rq(rq)	\
+	((rq)->flags & (REQ_CMD | REQ_STARTED) == REQ_CMD | REQ_STARTED)
 
-#define blk_pm_suspend_request(rq)	((rq)->flags & REQ_PM_SUSPEND)
-#define blk_pm_resume_request(rq)	((rq)->flags & REQ_PM_RESUME)
 #define blk_pm_request(rq)	\
 	((rq)->flags & (REQ_PM_SUSPEND | REQ_PM_RESUME))
 
-#define blk_sorted_rq(rq)	((rq)->flags & REQ_SORTED)
-#define blk_barrier_rq(rq)	((rq)->flags & REQ_HARDBARRIER)
-#define blk_fua_rq(rq)		((rq)->flags & REQ_FUA)
-
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		((rq)->flags & 1)
