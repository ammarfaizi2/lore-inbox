Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTKAXuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 18:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTKAXuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 18:50:25 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40111 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261240AbTKAXtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 18:49:55 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Di-30 non working [bug 967]
Date: Sun, 2 Nov 2003 00:54:49 +0100
User-Agent: KMail/1.5.4
Cc: svdmade@planet.nl, linux-kernel@vger.kernel.org
References: <3FA41703.1030408@planet.nl> <200311012228.29085.bzolnier@elka.pw.edu.pl> <20031101152453.42346338.akpm@osdl.org>
In-Reply-To: <20031101152453.42346338.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311020054.49869.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 of November 2003 00:24, Andrew Morton wrote:
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > Noticed by Stuart_Hayes@Dell.com:
> >
> > I've noticed that, in the 2.6 (test 9) kernel, the "cmd" field (of type
> > int) in struct request has been removed, and it looks like all of the
> > code in ide-tape has just had a find & replace run on it to replace any
> > instance of rq.cmd or rq->cmd with rq.flags or rq->flags.
>
> Nasty.
>
> > @@ -193,6 +193,11 @@ enum rq_flag_bits {
> >  	__REQ_PM_SUSPEND,	/* suspend request */
> >  	__REQ_PM_RESUME,	/* resume request */
> >  	__REQ_PM_SHUTDOWN,	/* shutdown request */
> > +	__REQ_IDETAPE_PC1,	/* packet command (first stage) */
> > +	__REQ_IDETAPE_PC2,	/* packet command (second stage) */
> > +	__REQ_IDETAPE_READ,
> > +	__REQ_IDETAPE_WRITE,
> > +	__REQ_IDETAPE_READ_BUFFER,
> >  	__REQ_NR_BITS,		/* stops here */
> >  };
>
> This takes us up to about 28 flags; we'll run out soon.
>
> Probably it is time to split this into generic and private flags, as we did
> with bh_state_bits.  The scope of the "private" section needs to be
> defined: maybe "whoever created the queue"?

This issue was already discussed and is planned for 2.7. :-)

> blk_dump_rq_flags() will need updating.  Probably change it to only decode
> the "generic" flags, and print "bit XX" for the remainders.
>
> Your patch forgot to update rq_flags[] btw.

Thanks, fixed.

I overlooked fact that ide-tape is calling ide_init_drive_cmd() just to zero
rq and then overwrites rq->flags, fixed.  Stef, please try corrected patch.


[IDE] fix rq->flags use in ide-tape.c

Noticed by Stuart_Hayes@Dell.com:

I've noticed that, in the 2.6 (test 9) kernel, the "cmd" field (of type int)
in struct request has been removed, and it looks like all of the code in
ide-tape has just had a find & replace run on it to replace any instance of
rq.cmd or rq->cmd with rq.flags or rq->flags.

The values being put into "cmd" in 2.4 (now "flags", in 2.6) by ide-tape are
8-bit numbers, like 90, 91, etc... and the actual flags that are being used
in "flags" cover the low 23 bits.  So, not only do the flags get wiped out
when, say, ide-tape assigns, say, 90 to "flags", but also the 90 gets wiped
out when one of the flags is modified.

I noticed this, because ide-tape checks this value, and spews error codes
when it isn't correct--continuously--as soon as you load the module, because
ide-tape is calling ide_do_drive_cmd with an action of ide_preempt, which
causes ide_do_drive_cmd to set the REQ_PREEMPT flag, so "flags" isn't the
same when it gets back to idetape_do_request.

 drivers/block/ll_rw_blk.c |    5 +
 drivers/ide/ide-tape.c    |  205 +++++++++++++++++++---------------------------
 include/linux/blkdev.h    |   10 ++
 3 files changed, 101 insertions(+), 119 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~ide-tape-rq_flags-fix drivers/block/ll_rw_blk.c
--- linux-2.6.0-test9/drivers/block/ll_rw_blk.c~ide-tape-rq_flags-fix	2003-11-02 00:39:26.855825904 +0100
+++ linux-2.6.0-test9-root/drivers/block/ll_rw_blk.c	2003-11-02 00:40:50.709078272 +0100
@@ -780,6 +780,11 @@ static char *rq_flags[] = {
 	"REQ_PM_SUSPEND",
 	"REQ_PM_RESUME",
 	"REQ_PM_SHUTDOWN",
+	"REQ_IDETAPE_PC1",
+	"REQ_IDETAPE_PC2",
+	"REQ_IDETAPE_READ",
+	"REQ_IDETAPE_WRITE",
+	"REQ_IDETAPE_READ_BUFFER",
 };
 
 void blk_dump_rq_flags(struct request *rq, char *msg)
diff -puN drivers/ide/ide-tape.c~ide-tape-rq_flags-fix drivers/ide/ide-tape.c
--- linux-2.6.0-test9/drivers/ide/ide-tape.c~ide-tape-rq_flags-fix	2003-11-01 22:18:18.715178960 +0100
+++ linux-2.6.0-test9-root/drivers/ide/ide-tape.c	2003-11-02 00:33:43.632003856 +0100
@@ -1210,34 +1210,11 @@ typedef struct {
  *	In order to service a character device command, we add special
  *	requests to the tail of our block device request queue and wait
  *	for their completion.
- *
- */
-#define IDETAPE_FIRST_RQ		90
-
-/*
- * 	IDETAPE_PC_RQ is used to queue a packet command in the request queue.
- */
-#define IDETAPE_PC_RQ1			90
-#define IDETAPE_PC_RQ2			91
-
-/*
- *	IDETAPE_READ_RQ and IDETAPE_WRITE_RQ are used by our
- *	character device interface to request read/write operations from
- *	our block device interface.
  */
-#define IDETAPE_READ_RQ			92
-#define IDETAPE_WRITE_RQ		93
-#define IDETAPE_ABORTED_WRITE_RQ	94
-#define IDETAPE_ABORTED_READ_RQ		95
-#define IDETAPE_READ_BUFFER_RQ		96
-
-#define IDETAPE_LAST_RQ			96
-
-/*
- *	A macro which can be used to check if a we support a given
- *	request command.
- */
-#define IDETAPE_RQ_CMD(cmd) 		((cmd >= IDETAPE_FIRST_RQ) && (cmd <= IDETAPE_LAST_RQ))
+#define idetape_request(rq) \
+	((rq)->flags & (REQ_IDETAPE_PC1 | REQ_IDETAPE_PC2 | \
+			REQ_IDETAPE_READ | REQ_IDETAPE_WRITE | \
+			REQ_IDETAPE_READ_BUFFER))
 
 /*
  *	Error codes which are returned in rq->errors to the higher part
@@ -1891,7 +1868,7 @@ static int idetape_end_request(ide_drive
 		tape->active_stage = NULL;
 		tape->active_data_request = NULL;
 		tape->nr_pending_stages--;
-		if (rq->flags == IDETAPE_WRITE_RQ) {
+		if (rq->flags & REQ_IDETAPE_WRITE) {
 #if ONSTREAM_DEBUG
 			if (tape->debug_level >= 2) {
 				if (tape->onstream) {
@@ -1937,7 +1914,7 @@ static int idetape_end_request(ide_drive
 					}
 				}
 			}
-		} else if (rq->flags == IDETAPE_READ_RQ) {
+		} else if (rq->flags & REQ_IDETAPE_READ) {
 			if (error == IDETAPE_ERROR_EOD) {
 				set_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 				idetape_abort_pipeline(drive, active_stage);
@@ -2016,9 +1993,9 @@ static void idetape_create_request_sense
  */
 static void idetape_queue_pc_head (ide_drive_t *drive, idetape_pc_t *pc,struct request *rq)
 {
-	ide_init_drive_cmd(rq);
+	memset(rq, 0, sizeof(*rq));
+	rq->flags = REQ_IDETAPE_PC1;
 	rq->buffer = (char *) pc;
-	rq->flags = IDETAPE_PC_RQ1;
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
@@ -2711,7 +2688,7 @@ static ide_startstop_t idetape_do_reques
 					  struct request *rq, sector_t block)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	idetape_pc_t *pc;
+	idetape_pc_t *pc = NULL;
 	struct request *postponed_rq = tape->postponed_rq;
 	atapi_status_t status;
 
@@ -2728,7 +2705,7 @@ static ide_startstop_t idetape_do_reques
 			rq->sector, rq->nr_sectors, rq->current_nr_sectors);
 #endif /* IDETAPE_DEBUG_LOG */
 
-	if (!IDETAPE_RQ_CMD(rq->flags)) {
+	if (!idetape_request(rq)) {
 		/*
 		 * We do not support buffer cache originated requests.
 		 */
@@ -2769,7 +2746,7 @@ static ide_startstop_t idetape_do_reques
 	 */
 	if (tape->onstream)
 		status.b.dsc = 1;
-	if (!drive->dsc_overlap && rq->flags != IDETAPE_PC_RQ2)
+	if (!drive->dsc_overlap && !(rq->flags & REQ_IDETAPE_PC2))
 		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
 
 	/*
@@ -2783,7 +2760,7 @@ static ide_startstop_t idetape_do_reques
 	if (tape->tape_still_time > 100 && tape->tape_still_time < 200)
 		tape->measure_insert_time = 1;
 	if (tape->req_buffer_fill &&
-	    (rq->flags == IDETAPE_WRITE_RQ || rq->flags == IDETAPE_READ_RQ)) {
+	    (rq->flags & (REQ_IDETAPE_WRITE | REQ_IDETAPE_READ))) {
 		tape->req_buffer_fill = 0;
 		tape->writes_since_buffer_fill = 0;
 		tape->reads_since_buffer_fill = 0;
@@ -2797,12 +2774,12 @@ static ide_startstop_t idetape_do_reques
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	calculate_speeds(drive);
 	if (tape->onstream && tape->max_frames &&
-	    ((rq->flags == IDETAPE_WRITE_RQ &&
+	    (((rq->flags & REQ_IDETAPE_WRITE) &&
               ( tape->cur_frames == tape->max_frames ||
                 ( tape->speed_control && tape->cur_frames > 5 &&
                        (tape->insert_speed > tape->max_insert_speed ||
                         (0 /* tape->cur_frames > 30 && tape->tape_still_time > 200 */) ) ) ) ) ||
-	     (rq->flags == IDETAPE_READ_RQ &&
+	     ((rq->flags & REQ_IDETAPE_READ) &&
 	      ( tape->cur_frames == 0 ||
 		( tape->speed_control && (tape->cur_frames < tape->max_frames - 5) &&
 			tape->insert_speed > tape->max_insert_speed ) ) && rq->nr_sectors) ) ) {
@@ -2831,7 +2808,7 @@ static ide_startstop_t idetape_do_reques
 		} else if ((signed long) (jiffies - tape->dsc_timeout) > 0) {
 			printk(KERN_ERR "ide-tape: %s: DSC timeout\n",
 				tape->name);
-			if (rq->flags == IDETAPE_PC_RQ2) {
+			if (rq->flags & REQ_IDETAPE_PC2) {
 				idetape_media_access_finished(drive);
 				return ide_stopped;
 			} else {
@@ -2842,69 +2819,59 @@ static ide_startstop_t idetape_do_reques
 		idetape_postpone_request(drive);
 		return ide_stopped;
 	}
-	switch (rq->flags) {
-		case IDETAPE_READ_RQ:
-			tape->buffer_head++;
+	if (rq->flags & REQ_IDETAPE_READ) {
+		tape->buffer_head++;
 #if USE_IOTRACE
-			IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
+		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
 #endif
-			tape->postpone_cnt = 0;
-			tape->reads_since_buffer_fill++;
-			if (tape->onstream) {
-				if (tape->cur_frames - tape->reads_since_buffer_fill <= 0)
-					tape->req_buffer_fill = 1;
-				if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
-					tape->req_buffer_fill = 1;
-			}
-			pc = idetape_next_pc_storage(drive);
-			idetape_create_read_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
-			break;
-		case IDETAPE_WRITE_RQ:
-			tape->buffer_head++;
+		tape->postpone_cnt = 0;
+		tape->reads_since_buffer_fill++;
+		if (tape->onstream) {
+			if (tape->cur_frames - tape->reads_since_buffer_fill <= 0)
+				tape->req_buffer_fill = 1;
+			if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
+				tape->req_buffer_fill = 1;
+		}
+		pc = idetape_next_pc_storage(drive);
+		idetape_create_read_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
+		goto out;
+	}
+	if (rq->flags & REQ_IDETAPE_WRITE) {
+		tape->buffer_head++;
 #if USE_IOTRACE
-			IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
-#endif
-			tape->postpone_cnt = 0;
-			tape->writes_since_buffer_fill++;
-			if (tape->onstream) {
-				if (tape->cur_frames + tape->writes_since_buffer_fill >= tape->max_frames)
-					tape->req_buffer_fill = 1;
-				if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
-					tape->req_buffer_fill = 1;
-				calculate_speeds(drive);
-			}
-			pc = idetape_next_pc_storage(drive);
-			idetape_create_write_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
-			break;
-		case IDETAPE_READ_BUFFER_RQ:
-			tape->postpone_cnt = 0;
-			pc = idetape_next_pc_storage(drive);
-			idetape_create_read_buffer_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
-			break;
-		case IDETAPE_ABORTED_WRITE_RQ:
-			rq->flags = IDETAPE_WRITE_RQ;
-			idetape_end_request(drive, IDETAPE_ERROR_EOD, 0);
-			return ide_stopped;
-		case IDETAPE_ABORTED_READ_RQ:
-#if IDETAPE_DEBUG_LOG
-			if (tape->debug_level >= 2)
-				printk(KERN_INFO "ide-tape: %s: detected aborted read rq\n", tape->name);
+		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
 #endif
-			rq->flags = IDETAPE_READ_RQ;
-			idetape_end_request(drive, IDETAPE_ERROR_EOD, 0);
-			return ide_stopped;
-		case IDETAPE_PC_RQ1:
-			pc = (idetape_pc_t *) rq->buffer;
-			rq->flags = IDETAPE_PC_RQ2;
-			break;
-		case IDETAPE_PC_RQ2:
-			idetape_media_access_finished(drive);
-			return ide_stopped;
-		default:
-			printk(KERN_ERR "ide-tape: bug in IDETAPE_RQ_CMD macro\n");
-			idetape_end_request(drive, 0, 0);
-			return ide_stopped;
+		tape->postpone_cnt = 0;
+		tape->writes_since_buffer_fill++;
+		if (tape->onstream) {
+			if (tape->cur_frames + tape->writes_since_buffer_fill >= tape->max_frames)
+				tape->req_buffer_fill = 1;
+			if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
+				tape->req_buffer_fill = 1;
+			calculate_speeds(drive);
+		}
+		pc = idetape_next_pc_storage(drive);
+		idetape_create_write_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
+		goto out;
+	}
+	if (rq->flags & REQ_IDETAPE_READ_BUFFER) {
+		tape->postpone_cnt = 0;
+		pc = idetape_next_pc_storage(drive);
+		idetape_create_read_buffer_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
+		goto out;
+	}
+	if (rq->flags & REQ_IDETAPE_PC1) {
+		pc = (idetape_pc_t *) rq->buffer;
+		rq->flags &= ~(REQ_IDETAPE_PC1);
+		rq->flags |= REQ_IDETAPE_PC2;
+		goto out;
 	}
+	if (rq->flags & REQ_IDETAPE_PC2) {
+		idetape_media_access_finished(drive);
+		return ide_stopped;
+	}
+	BUG();
+out:
 	return idetape_issue_packet_command(drive, pc);
 }
 
@@ -3196,7 +3163,7 @@ static void idetape_wait_for_request (id
 	idetape_tape_t *tape = drive->driver_data;
 
 #if IDETAPE_DEBUG_BUGS
-	if (rq == NULL || !IDETAPE_RQ_CMD(rq->flags)) {
+	if (rq == NULL || !idetape_request(rq)) {
 		printk (KERN_ERR "ide-tape: bug: Trying to sleep on non-valid request\n");
 		return;
 	}
@@ -3302,9 +3269,9 @@ static int __idetape_queue_pc_tail (ide_
 {
 	struct request rq;
 
-	ide_init_drive_cmd(&rq);
+	memset(&rq, 0, sizeof(rq));
+	rq.flags = REQ_IDETAPE_PC1;
 	rq.buffer = (char *) pc;
-	rq.flags = IDETAPE_PC_RQ1;
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
@@ -3579,16 +3546,16 @@ static int idetape_queue_rw_tail(ide_dri
 	}
 #endif /* IDETAPE_DEBUG_BUGS */	
 
-	ide_init_drive_cmd(&rq);
-	rq.special = (void *)bh;
+	memset(&rq, 0, sizeof(rq));
 	rq.flags = cmd;
+	rq.special = (void *)bh;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
 	if (tape->onstream)
 		tape->postpone_cnt = 600;
 	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
 
-	if (cmd != IDETAPE_READ_RQ && cmd != IDETAPE_WRITE_RQ)
+	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
 		return 0;
 
 	if (tape->merge_stage)
@@ -3623,14 +3590,14 @@ static void idetape_onstream_read_back_b
 			first = stage;
 		aux = stage->aux;
 		p = stage->bh->b_data;
-		idetape_queue_rw_tail(drive, IDETAPE_READ_BUFFER_RQ, tape->capabilities.ctl, stage->bh);
+		idetape_queue_rw_tail(drive, REQ_IDETAPE_READ_BUFFER, tape->capabilities.ctl, stage->bh);
 #if ONSTREAM_DEBUG
 		if (tape->debug_level >= 2)
 			printk(KERN_INFO "ide-tape: %s: read back logical block %d, data %x %x %x %x\n", tape->name, logical_blk_num, *p++, *p++, *p++, *p++);
 #endif
 		rq = &stage->rq;
-		ide_init_drive_cmd(rq);
-		rq->flags = IDETAPE_WRITE_RQ;
+		memset(rq, 0, sizeof(*rq));
+		rq->flags = REQ_IDETAPE_WRITE;
 		rq->sector = tape->first_frame_position;
 		rq->nr_sectors = rq->current_nr_sectors = tape->capabilities.ctl;
 		idetape_init_stage(drive, stage, OS_FRAME_TYPE_DATA, logical_blk_num++);
@@ -3900,12 +3867,12 @@ static int idetape_add_chrdev_write_requ
 			 *	Linux is short on memory. Fallback to
 			 *	non-pipelined operation mode for this request.
 			 */
-			return idetape_queue_rw_tail(drive, IDETAPE_WRITE_RQ, blocks, tape->merge_stage->bh);
+			return idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, blocks, tape->merge_stage->bh);
 		}
 	}
 	rq = &new_stage->rq;
-	ide_init_drive_cmd(rq);
-	rq->flags = IDETAPE_WRITE_RQ;
+	memset(rq, 0, sizeof(*rq));
+	rq->flags = REQ_IDETAPE_WRITE;
 	/* Doesn't actually matter - We always assume sequential access */
 	rq->sector = tape->first_frame_position;
 	rq->nr_sectors = rq->current_nr_sectors = blocks;
@@ -4093,7 +4060,7 @@ static int idetape_initiate_read (ide_dr
 		 *	is switched from completion mode to buffer available
 		 *	mode.
 		 */
-		bytes_read = idetape_queue_rw_tail(drive, IDETAPE_READ_RQ, 0, tape->merge_stage->bh);
+		bytes_read = idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 0, tape->merge_stage->bh);
 		if (bytes_read < 0) {
 			__idetape_kfree_stage(tape->merge_stage);
 			tape->merge_stage = NULL;
@@ -4103,8 +4070,8 @@ static int idetape_initiate_read (ide_dr
 	}
 	if (tape->restart_speed_control_req)
 		idetape_restart_speed_control(drive);
-	ide_init_drive_cmd(&rq);
-	rq.flags = IDETAPE_READ_RQ;
+	memset(&rq, 0, sizeof(rq));
+	rq.flags = REQ_IDETAPE_READ;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
 	if (!test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags) &&
@@ -4242,7 +4209,7 @@ static int idetape_add_chrdev_read_reque
 		}
 		if (test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags))
 		 	return 0;
-		return idetape_queue_rw_tail(drive, IDETAPE_READ_RQ, blocks, tape->merge_stage->bh);
+		return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks, tape->merge_stage->bh);
 	}
 	rq_ptr = &tape->first_stage->rq;
 	bytes_read = tape->tape_block_size * (rq_ptr->nr_sectors - rq_ptr->current_nr_sectors);
@@ -4308,7 +4275,7 @@ static void idetape_pad_zeros (ide_drive
 			count -= atomic_read(&bh->b_count);
 			bh = bh->b_reqnext;
 		}
-		idetape_queue_rw_tail(drive, IDETAPE_WRITE_RQ, blocks, tape->merge_stage->bh);
+		idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, blocks, tape->merge_stage->bh);
 	}
 }
 
@@ -4788,7 +4755,7 @@ static void idetape_update_last_marker (
 			"tape block %d\n", tape->last_frame_position);
 #endif
 	idetape_position_tape(drive, last_mark_addr, 0, 0);
-	if (!idetape_queue_rw_tail(drive, IDETAPE_READ_RQ, 1, stage->bh)) {
+	if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 1, stage->bh)) {
 		printk(KERN_INFO "ide-tape: %s: couldn't read last marker\n",
 			tape->name);
 		__idetape_kfree_stage(stage);
@@ -4809,7 +4776,7 @@ static void idetape_update_last_marker (
 #endif
 	aux->next_mark_addr = htonl(next_mark_addr);
 	idetape_position_tape(drive, last_mark_addr, 0, 0);
-	if (!idetape_queue_rw_tail(drive, IDETAPE_WRITE_RQ, 1, stage->bh)) {
+	if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 1, stage->bh)) {
 		printk(KERN_INFO "ide-tape: %s: couldn't write back marker "
 			"frame at %d\n", tape->name, last_mark_addr);
 		__idetape_kfree_stage(stage);
@@ -4845,7 +4812,7 @@ static void idetape_write_filler (ide_dr
 
 	strcpy(stage->bh->b_data, "Filler");
 	while (cnt--) {
-		if (!idetape_queue_rw_tail(drive, IDETAPE_WRITE_RQ, 1, stage->bh)) {
+		if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 1, stage->bh)) {
 			printk(KERN_INFO "ide-tape: %s: write_filler: "
 				"couldn't write header frame\n", tape->name);
 			__idetape_kfree_stage(stage);
@@ -4880,7 +4847,7 @@ static void __idetape_write_header (ide_
 	header.partition.eod_frame_addr = htonl(tape->eod_frame_addr);
 	memcpy(stage->bh->b_data, &header, sizeof(header));
 	while (cnt--) {
-		if (!idetape_queue_rw_tail(drive, IDETAPE_WRITE_RQ, 1, stage->bh)) {
+		if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 1, stage->bh)) {
 			printk(KERN_INFO "ide-tape: %s: couldn't write "
 				"header frame\n", tape->name);
 			__idetape_kfree_stage(stage);
@@ -5013,7 +4980,7 @@ static ssize_t idetape_chrdev_write (str
 		 *	is switched from completion mode to buffer available
 		 *	mode.
 		 */
-		retval = idetape_queue_rw_tail(drive, IDETAPE_WRITE_RQ, 0, tape->merge_stage->bh);
+		retval = idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 0, tape->merge_stage->bh);
 		if (retval < 0) {
 			__idetape_kfree_stage(tape->merge_stage);
 			tape->merge_stage = NULL;
@@ -5487,7 +5454,7 @@ static int __idetape_analyze_headers (id
 		printk(KERN_INFO "ide-tape: %s: reading header\n", tape->name);
 #endif
 	idetape_position_tape(drive, block, 0, 0);
-	if (!idetape_queue_rw_tail(drive, IDETAPE_READ_RQ, 1, stage->bh)) {
+	if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 1, stage->bh)) {
 		printk(KERN_INFO "ide-tape: %s: couldn't read header frame\n",
 			tape->name);
 		__idetape_kfree_stage(stage);
diff -puN include/linux/blkdev.h~ide-tape-rq_flags-fix include/linux/blkdev.h
--- linux-2.6.0-test9/include/linux/blkdev.h~ide-tape-rq_flags-fix	2003-11-01 22:18:18.718178504 +0100
+++ linux-2.6.0-test9-root/include/linux/blkdev.h	2003-11-01 22:18:18.732176376 +0100
@@ -193,6 +193,11 @@ enum rq_flag_bits {
 	__REQ_PM_SUSPEND,	/* suspend request */
 	__REQ_PM_RESUME,	/* resume request */
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
+	__REQ_IDETAPE_PC1,	/* packet command (first stage) */
+	__REQ_IDETAPE_PC2,	/* packet command (second stage) */
+	__REQ_IDETAPE_READ,
+	__REQ_IDETAPE_WRITE,
+	__REQ_IDETAPE_READ_BUFFER,
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -218,6 +223,11 @@ enum rq_flag_bits {
 #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
 #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
+#define REQ_IDETAPE_PC1 (1 << __REQ_IDETAPE_PC1)
+#define REQ_IDETAPE_PC2 (1 << __REQ_IDETAPE_PC2)
+#define REQ_IDETAPE_READ	(1 << __REQ_IDETAPE_READ)
+#define REQ_IDETAPE_WRITE	(1 << __REQ_IDETAPE_WRITE)
+#define REQ_IDETAPE_READ_BUFFER	(1 << __REQ_IDETAPE_READ_BUFFER)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME

_

