Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTK1OG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTK1OG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:06:58 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55793 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262291AbTK1OGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:06:24 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH[RFT] ide-tape.c: stop abusing rq->flags
Date: Fri, 28 Nov 2003 15:07:41 +0100
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311281507.41547.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Per Jens' request. ]

Patch looks trivial but theory != practice, so if you happen to have
IDE tape drive working fine with 2.6.0-test11 please test it.  Thanks!

--bart

[IDE] ide-tape.c: stop abusing rq->flags

Use rq->cmd[0] instead of rq->flags for storing special request flags.

 drivers/block/ll_rw_blk.c |    5 ---
 drivers/ide/ide-tape.c    |   75 ++++++++++++++++++++++++----------------------
 include/linux/blkdev.h    |   10 ------
 3 files changed, 40 insertions(+), 50 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~ide-tape-rq-special drivers/block/ll_rw_blk.c
--- linux-2.6.0-test11/drivers/block/ll_rw_blk.c~ide-tape-rq-special	2003-11-28 14:18:58.416350536 +0100
+++ linux-2.6.0-test11-root/drivers/block/ll_rw_blk.c	2003-11-28 14:19:18.265333032 +0100
@@ -780,11 +780,6 @@ static char *rq_flags[] = {
 	"REQ_PM_SUSPEND",
 	"REQ_PM_RESUME",
 	"REQ_PM_SHUTDOWN",
-	"REQ_IDETAPE_PC1",
-	"REQ_IDETAPE_PC2",
-	"REQ_IDETAPE_READ",
-	"REQ_IDETAPE_WRITE",
-	"REQ_IDETAPE_READ_BUFFER",
 };
 
 void blk_dump_rq_flags(struct request *rq, char *msg)
diff -puN drivers/ide/ide-tape.c~ide-tape-rq-special drivers/ide/ide-tape.c
--- linux-2.6.0-test11/drivers/ide/ide-tape.c~ide-tape-rq-special	2003-11-28 14:04:48.166608144 +0100
+++ linux-2.6.0-test11-root/drivers/ide/ide-tape.c	2003-11-28 14:34:54.725969376 +0100
@@ -1211,10 +1211,14 @@ typedef struct {
  *	requests to the tail of our block device request queue and wait
  *	for their completion.
  */
-#define idetape_request(rq) \
-	((rq)->flags & (REQ_IDETAPE_PC1 | REQ_IDETAPE_PC2 | \
-			REQ_IDETAPE_READ | REQ_IDETAPE_WRITE | \
-			REQ_IDETAPE_READ_BUFFER))
+
+enum {
+	REQ_IDETAPE_PC1		= (1 << 0), /* packet command (first stage) */
+	REQ_IDETAPE_PC2		= (1 << 1), /* packet command (second stage) */
+	REQ_IDETAPE_READ	= (1 << 2),
+	REQ_IDETAPE_WRITE	= (1 << 3),
+	REQ_IDETAPE_READ_BUFFER	= (1 << 4),
+};
 
 /*
  *	Error codes which are returned in rq->errors to the higher part
@@ -1868,7 +1872,7 @@ static int idetape_end_request(ide_drive
 		tape->active_stage = NULL;
 		tape->active_data_request = NULL;
 		tape->nr_pending_stages--;
-		if (rq->flags & REQ_IDETAPE_WRITE) {
+		if (rq->cmd[0] & REQ_IDETAPE_WRITE) {
 #if ONSTREAM_DEBUG
 			if (tape->debug_level >= 2) {
 				if (tape->onstream) {
@@ -1914,7 +1918,7 @@ static int idetape_end_request(ide_drive
 					}
 				}
 			}
-		} else if (rq->flags & REQ_IDETAPE_READ) {
+		} else if (rq->cmd[0] & REQ_IDETAPE_READ) {
 			if (error == IDETAPE_ERROR_EOD) {
 				set_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 				idetape_abort_pipeline(drive, active_stage);
@@ -1972,6 +1976,13 @@ static void idetape_create_request_sense
 	pc->callback = &idetape_request_sense_callback;
 }
 
+static void idetape_init_rq(struct request *rq, u8 cmd)
+{
+	memset(rq, 0, sizeof(*rq));
+	rq->flags = REQ_SPECIAL;
+	rq->cmd[0] = cmd;
+}
+
 /*
  *	idetape_queue_pc_head generates a new packet command request in front
  *	of the request queue, before the current request, so that it will be
@@ -1993,8 +2004,7 @@ static void idetape_create_request_sense
  */
 static void idetape_queue_pc_head (ide_drive_t *drive, idetape_pc_t *pc,struct request *rq)
 {
-	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_IDETAPE_PC1;
+	idetape_init_rq(rq, REQ_IDETAPE_PC1);
 	rq->buffer = (char *) pc;
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }
@@ -2697,7 +2707,7 @@ static ide_startstop_t idetape_do_reques
 	if (tape->debug_level >= 5)
 		printk(KERN_INFO "ide-tape: rq_status: %d, "
 			"dev: %s, cmd: %ld, errors: %d\n", rq->rq_status,
-			 rq->rq_disk->disk_name, rq->flags, rq->errors);
+			 rq->rq_disk->disk_name, rq->cmd[0], rq->errors);
 #endif
 	if (tape->debug_level >= 2)
 		printk(KERN_INFO "ide-tape: sector: %ld, "
@@ -2705,11 +2715,11 @@ static ide_startstop_t idetape_do_reques
 			rq->sector, rq->nr_sectors, rq->current_nr_sectors);
 #endif /* IDETAPE_DEBUG_LOG */
 
-	if (!idetape_request(rq)) {
+	if ((rq->flags & REQ_SPECIAL) == 0) {
 		/*
 		 * We do not support buffer cache originated requests.
 		 */
-		printk(KERN_NOTICE "ide-tape: %s: Unsupported command in "
+		printk(KERN_NOTICE "ide-tape: %s: Unsupported request in "
 			"request queue (%ld)\n", drive->name, rq->flags);
 		ide_end_request(drive, 0, 0);
 		return ide_stopped;
@@ -2746,7 +2756,7 @@ static ide_startstop_t idetape_do_reques
 	 */
 	if (tape->onstream)
 		status.b.dsc = 1;
-	if (!drive->dsc_overlap && !(rq->flags & REQ_IDETAPE_PC2))
+	if (!drive->dsc_overlap && !(rq->cmd[0] & REQ_IDETAPE_PC2))
 		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
 
 	/*
@@ -2760,7 +2770,7 @@ static ide_startstop_t idetape_do_reques
 	if (tape->tape_still_time > 100 && tape->tape_still_time < 200)
 		tape->measure_insert_time = 1;
 	if (tape->req_buffer_fill &&
-	    (rq->flags & (REQ_IDETAPE_WRITE | REQ_IDETAPE_READ))) {
+	    (rq->cmd[0] & (REQ_IDETAPE_WRITE | REQ_IDETAPE_READ))) {
 		tape->req_buffer_fill = 0;
 		tape->writes_since_buffer_fill = 0;
 		tape->reads_since_buffer_fill = 0;
@@ -2774,12 +2784,12 @@ static ide_startstop_t idetape_do_reques
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	calculate_speeds(drive);
 	if (tape->onstream && tape->max_frames &&
-	    (((rq->flags & REQ_IDETAPE_WRITE) &&
+	    (((rq->cmd[0] & REQ_IDETAPE_WRITE) &&
               ( tape->cur_frames == tape->max_frames ||
                 ( tape->speed_control && tape->cur_frames > 5 &&
                        (tape->insert_speed > tape->max_insert_speed ||
                         (0 /* tape->cur_frames > 30 && tape->tape_still_time > 200 */) ) ) ) ) ||
-	     ((rq->flags & REQ_IDETAPE_READ) &&
+	     ((rq->cmd[0] & REQ_IDETAPE_READ) &&
 	      ( tape->cur_frames == 0 ||
 		( tape->speed_control && (tape->cur_frames < tape->max_frames - 5) &&
 			tape->insert_speed > tape->max_insert_speed ) ) && rq->nr_sectors) ) ) {
@@ -2787,7 +2797,7 @@ static ide_startstop_t idetape_do_reques
 		if (tape->debug_level >= 4)
 			printk(KERN_INFO "ide-tape: postponing request, "
 					"cmd %ld, cur %d, max %d\n",
-				rq->flags, tape->cur_frames, tape->max_frames);
+				rq->cmd[0], tape->cur_frames, tape->max_frames);
 #endif
 		if (tape->postpone_cnt++ < 500) {
 			status.b.dsc = 0;
@@ -2808,7 +2818,7 @@ static ide_startstop_t idetape_do_reques
 		} else if ((signed long) (jiffies - tape->dsc_timeout) > 0) {
 			printk(KERN_ERR "ide-tape: %s: DSC timeout\n",
 				tape->name);
-			if (rq->flags & REQ_IDETAPE_PC2) {
+			if (rq->cmd[0] & REQ_IDETAPE_PC2) {
 				idetape_media_access_finished(drive);
 				return ide_stopped;
 			} else {
@@ -2819,7 +2829,7 @@ static ide_startstop_t idetape_do_reques
 		idetape_postpone_request(drive);
 		return ide_stopped;
 	}
-	if (rq->flags & REQ_IDETAPE_READ) {
+	if (rq->cmd[0] & REQ_IDETAPE_READ) {
 		tape->buffer_head++;
 #if USE_IOTRACE
 		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
@@ -2836,7 +2846,7 @@ static ide_startstop_t idetape_do_reques
 		idetape_create_read_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
 		goto out;
 	}
-	if (rq->flags & REQ_IDETAPE_WRITE) {
+	if (rq->cmd[0] & REQ_IDETAPE_WRITE) {
 		tape->buffer_head++;
 #if USE_IOTRACE
 		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
@@ -2854,19 +2864,19 @@ static ide_startstop_t idetape_do_reques
 		idetape_create_write_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
 		goto out;
 	}
-	if (rq->flags & REQ_IDETAPE_READ_BUFFER) {
+	if (rq->cmd[0] & REQ_IDETAPE_READ_BUFFER) {
 		tape->postpone_cnt = 0;
 		pc = idetape_next_pc_storage(drive);
 		idetape_create_read_buffer_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
 		goto out;
 	}
-	if (rq->flags & REQ_IDETAPE_PC1) {
+	if (rq->cmd[0] & REQ_IDETAPE_PC1) {
 		pc = (idetape_pc_t *) rq->buffer;
-		rq->flags &= ~(REQ_IDETAPE_PC1);
-		rq->flags |= REQ_IDETAPE_PC2;
+		rq->cmd[0] &= ~(REQ_IDETAPE_PC1);
+		rq->cmd[0] |= REQ_IDETAPE_PC2;
 		goto out;
 	}
-	if (rq->flags & REQ_IDETAPE_PC2) {
+	if (rq->cmd[0] & REQ_IDETAPE_PC2) {
 		idetape_media_access_finished(drive);
 		return ide_stopped;
 	}
@@ -3163,7 +3173,7 @@ static void idetape_wait_for_request (id
 	idetape_tape_t *tape = drive->driver_data;
 
 #if IDETAPE_DEBUG_BUGS
-	if (rq == NULL || !idetape_request(rq)) {
+	if (rq == NULL || (rq->flags & REQ_SPECIAL) == 0) {
 		printk (KERN_ERR "ide-tape: bug: Trying to sleep on non-valid request\n");
 		return;
 	}
@@ -3269,8 +3279,7 @@ static int __idetape_queue_pc_tail (ide_
 {
 	struct request rq;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_IDETAPE_PC1;
+	idetape_init_rq(&rq, REQ_IDETAPE_PC1);
 	rq.buffer = (char *) pc;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -3546,8 +3555,7 @@ static int idetape_queue_rw_tail(ide_dri
 	}
 #endif /* IDETAPE_DEBUG_BUGS */	
 
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = cmd;
+	idetape_init_rq(&rq, cmd);
 	rq.special = (void *)bh;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
@@ -3596,8 +3604,7 @@ static void idetape_onstream_read_back_b
 			printk(KERN_INFO "ide-tape: %s: read back logical block %d, data %x %x %x %x\n", tape->name, logical_blk_num, *p++, *p++, *p++, *p++);
 #endif
 		rq = &stage->rq;
-		memset(rq, 0, sizeof(*rq));
-		rq->flags = REQ_IDETAPE_WRITE;
+		idetape_init_rq(rq, REQ_IDETAPE_WRITE);
 		rq->sector = tape->first_frame_position;
 		rq->nr_sectors = rq->current_nr_sectors = tape->capabilities.ctl;
 		idetape_init_stage(drive, stage, OS_FRAME_TYPE_DATA, logical_blk_num++);
@@ -3871,8 +3878,7 @@ static int idetape_add_chrdev_write_requ
 		}
 	}
 	rq = &new_stage->rq;
-	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_IDETAPE_WRITE;
+	idetape_init_rq(rq, REQ_IDETAPE_WRITE);
 	/* Doesn't actually matter - We always assume sequential access */
 	rq->sector = tape->first_frame_position;
 	rq->nr_sectors = rq->current_nr_sectors = blocks;
@@ -4070,8 +4076,7 @@ static int idetape_initiate_read (ide_dr
 	}
 	if (tape->restart_speed_control_req)
 		idetape_restart_speed_control(drive);
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_IDETAPE_READ;
+	idetape_init_rq(&rq, REQ_IDETAPE_READ);
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
 	if (!test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags) &&
diff -puN include/linux/blkdev.h~ide-tape-rq-special include/linux/blkdev.h
--- linux-2.6.0-test11/include/linux/blkdev.h~ide-tape-rq-special	2003-11-28 14:19:04.737389592 +0100
+++ linux-2.6.0-test11-root/include/linux/blkdev.h	2003-11-28 14:20:43.930309976 +0100
@@ -193,11 +193,6 @@ enum rq_flag_bits {
 	__REQ_PM_SUSPEND,	/* suspend request */
 	__REQ_PM_RESUME,	/* resume request */
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
-	__REQ_IDETAPE_PC1,	/* packet command (first stage) */
-	__REQ_IDETAPE_PC2,	/* packet command (second stage) */
-	__REQ_IDETAPE_READ,
-	__REQ_IDETAPE_WRITE,
-	__REQ_IDETAPE_READ_BUFFER,
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -223,11 +218,6 @@ enum rq_flag_bits {
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
 #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
-#define REQ_IDETAPE_PC1 (1 << __REQ_IDETAPE_PC1)
-#define REQ_IDETAPE_PC2 (1 << __REQ_IDETAPE_PC2)
-#define REQ_IDETAPE_READ	(1 << __REQ_IDETAPE_READ)
-#define REQ_IDETAPE_WRITE	(1 << __REQ_IDETAPE_WRITE)
-#define REQ_IDETAPE_READ_BUFFER	(1 << __REQ_IDETAPE_READ_BUFFER)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME

_

