Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbUBOWM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUBOWM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:12:29 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:43660 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264451AbUBOWLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:11:13 -0500
Date: Sun, 15 Feb 2004 17:11:08 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove obsolete onstream support from ide-tape in 2.6.3-rc3
Message-ID: <20040215221108.GA4957@serve.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject says it all. Willem Riede.

--- p1/drivers/ide/ide-tape.c	2004-02-15 16:36:58.000000000 -0500
+++ p3/drivers/ide/ide-tape.c	2004-02-15 16:53:56.000000000 -0500
@@ -451,18 +451,6 @@
 #include <asm/bitops.h>
 
 /*
- *	OnStream support
- */
-#define ONSTREAM_DEBUG		(0)
-#define OS_CONFIG_PARTITION	(0xff)
-#define OS_DATA_PARTITION	(0)
-#define OS_PARTITION_VERSION	(1)
-#define OS_EW			300
-#define OS_ADR_MINREV		2
-
-#define OS_DATA_STARTFRAME1	20
-#define OS_DATA_ENDFRAME1	2980
-/*
  * partition
  */
 typedef struct os_partition_s {
@@ -498,87 +486,6 @@
 	os_dat_entry_t	dat_list[16];
 } os_dat_t;
 
-/*
- * Frame types
- */
-#define OS_FRAME_TYPE_FILL	(0)
-#define OS_FRAME_TYPE_EOD	(1 << 0)
-#define OS_FRAME_TYPE_MARKER	(1 << 1)
-#define OS_FRAME_TYPE_HEADER	(1 << 3)
-#define OS_FRAME_TYPE_DATA	(1 << 7)
-
-/*
- * AUX
- */
-typedef struct os_aux_s {
-	__u32		format_id;		/* hardware compatibility AUX is based on */
-	char		application_sig[4];	/* driver used to write this media */
-	__u32		hdwr;			/* reserved */
-	__u32		update_frame_cntr;	/* for configuration frame */
-	__u8		frame_type;
-	__u8		frame_type_reserved;
-	__u8		reserved_18_19[2];
-	os_partition_t	partition;
-	__u8		reserved_36_43[8];
-	__u32		frame_seq_num;
-	__u32		logical_blk_num_high;
-	__u32		logical_blk_num;
-	os_dat_t	dat;
-	__u8		reserved188_191[4];
-	__u32		filemark_cnt;
-	__u32		phys_fm;
-	__u32		last_mark_addr;
-	__u8		reserved204_223[20];
-
-	/*
-	 * __u8		app_specific[32];
-	 *
-	 * Linux specific fields:
-	 */
-	 __u32		next_mark_addr;		/* when known, points to next marker */
-	 __u8		linux_specific[28];
-
-	__u8		reserved_256_511[256];
-} os_aux_t;
-
-typedef struct os_header_s {
-	char		ident_str[8];
-	__u8		major_rev;
-	__u8		minor_rev;
-	__u8		reserved10_15[6];
-	__u8		par_num;
-	__u8		reserved1_3[3];
-	os_partition_t	partition;
-} os_header_t;
-
-/*
- *	OnStream Tape Parameters Page
- */
-typedef struct {
-	unsigned	page_code	:6;	/* Page code - Should be 0x2b */
-	unsigned	reserved1_6	:1;
-	unsigned	ps		:1;
-	__u8		reserved2;
-	__u8		density;		/* kbpi */
-	__u8		reserved3,reserved4;
-	__u16		segtrk;                 /* segment of per track */
-	__u16		trks;                   /* tracks per tape */
-	__u8		reserved5,reserved6,reserved7,reserved8,reserved9,reserved10;
-} onstream_tape_paramtr_page_t;
-
-/*
- * OnStream ADRL frame
- */
-#define OS_FRAME_SIZE	(32 * 1024 + 512)
-#define OS_DATA_SIZE	(32 * 1024)
-#define OS_AUX_SIZE	(512)
-
-/*
- * internal error codes for onstream
- */
-#define OS_PART_ERROR    2
-#define OS_WRITE_ERROR   1
-
 #include <linux/mtio.h>
 
 /**************************** Tunable parameters *****************************/
@@ -842,7 +749,6 @@
 	struct request rq;			/* The corresponding request */
 	struct idetape_bh *bh;			/* The data buffers */
 	struct idetape_stage_s *next;		/* Pointer to the next stage */
-	os_aux_t *aux;				/* OnStream aux ptr */
 } idetape_stage_t;
 
 /*
@@ -1037,52 +943,6 @@
 	char write_prot;
 
 	/*
-	 * OnStream flags
-	 */
-	/* the tape is an OnStream tape */
-	int onstream;
-	/* OnStream raw access (32.5KB block size) */
-	int raw;
-	/* current number of frames in internal buffer */
-	int cur_frames;
-	/* max number of frames in internal buffer */
-	int max_frames;
-	/* logical block number */
-	int logical_blk_num;
-	/* write pass counter */
-	__u16 wrt_pass_cntr;
-	/* update frame counter */
-	__u32 update_frame_cntr;
-	struct completion *waiting;
-	/* write error recovery active */
-	int onstream_write_error;
-	/* header frame verified ok */
-	int header_ok;
-	/* reading linux-specific media */
-	int linux_media;
-	int linux_media_version;
-	/* application signature */
-	char application_sig[5];
-	int filemark_cnt;
-	int first_mark_addr;
-	int last_mark_addr;
-	int eod_frame_addr;
-	unsigned long cmd_start_time;
-	unsigned long max_cmd_time;
-	unsigned capacity;
-
-	/*
-	 * Optimize the number of "buffer filling"
-	 * mode sense commands.
-	 */
-	/* last time in which we issued fill cmd */
-	unsigned long last_buffer_fill;
-	/* buffer fill command requested */
-	int req_buffer_fill;
-	int writes_since_buffer_fill;
-	int reads_since_buffer_fill;
-
-	/*
 	 * Limit the number of times a request can
 	 * be postponed, to avoid an infinite postpone
 	 * deadlock.
@@ -1468,7 +1328,6 @@
  *      Function declarations
  *
  */
-static void idetape_onstream_mode_sense_tape_parameter_page(ide_drive_t *drive, int debug);
 static int idetape_chrdev_release (struct inode *inode, struct file *filp);
 static void idetape_write_release (ide_drive_t *drive, unsigned int minor);
 
@@ -1659,13 +1518,6 @@
 #endif /* IDETAPE_DEBUG_LOG_VERBOSE */
 #endif /* IDETAPE_DEBUG_LOG */
 
-	if (tape->onstream && result->sense_key == 2 &&
-	    result->asc == 0x53 && result->ascq == 2) {
-		clear_bit(PC_DMA_ERROR, &pc->flags);
-		ide_stall_queue(drive, HZ / 2);
-		return;
-	}
-
 	/*
 	 *	Correct pc->actually_transferred by asking the tape.
 	 */
@@ -1706,7 +1558,7 @@
 			set_bit(PC_ABORT, &pc->flags);
 		}
 		if (!test_bit(PC_ABORT, &pc->flags) &&
-		    (tape->onstream || pc->actually_transferred))
+		    pc->actually_transferred)
 			pc->retries = IDETAPE_MAX_PC_RETRIES + 1;
 	}
 }
@@ -1868,11 +1720,6 @@
 	int error;
 	int remove_stage = 0;
 	idetape_stage_t *active_stage;
-#if ONSTREAM_DEBUG
-	idetape_stage_t *stage;
-	os_aux_t *aux;
-	unsigned char *p;
-#endif
 
 #if IDETAPE_DEBUG_LOG
         if (tape->debug_level >= 4)
@@ -1897,50 +1744,11 @@
 		tape->active_data_request = NULL;
 		tape->nr_pending_stages--;
 		if (rq->cmd[0] & REQ_IDETAPE_WRITE) {
-#if ONSTREAM_DEBUG
-			if (tape->debug_level >= 2) {
-				if (tape->onstream) {
-					stage = tape->first_stage;
-					aux = stage->aux;
-					p = stage->bh->b_data;
-					if (ntohl(aux->logical_blk_num) < 11300 && ntohl(aux->logical_blk_num) > 11100)
-						printk(KERN_INFO "ide-tape: finished writing logical blk %u (data %x %x %x %x)\n", ntohl(aux->logical_blk_num), *p++, *p++, *p++, *p++);
-				}
-			}
-#endif
-			if (tape->onstream && !tape->raw) {
-				if (tape->first_frame_position == OS_DATA_ENDFRAME1) { 
-#if ONSTREAM_DEBUG
-					if (tape->debug_level >= 2)
-						printk("ide-tape: %s: skipping over config partition.\n", tape->name);
-#endif
-					tape->onstream_write_error = OS_PART_ERROR;
-					if (tape->waiting) {
-						rq->waiting = NULL;
-						complete(tape->waiting);
-					}
-				}
-			}
 			remove_stage = 1;
 			if (error) {
 				set_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 				if (error == IDETAPE_ERROR_EOD)
 					idetape_abort_pipeline(drive, active_stage);
-				if (tape->onstream && !tape->raw &&
-				    error == IDETAPE_ERROR_GENERAL &&
-				    tape->sense.sense_key == 3) {
-					clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
-					printk(KERN_ERR "ide-tape: %s: write error, enabling error recovery\n", tape->name);
-					tape->onstream_write_error = OS_WRITE_ERROR;
-					remove_stage = 0;
-					tape->nr_pending_stages++;
-					tape->next_stage = tape->first_stage;
-					rq->current_nr_sectors = rq->nr_sectors;
-					if (tape->waiting) {
-						rq->waiting = NULL;
-						complete(tape->waiting);
-					}
-				}
 			}
 		} else if (rq->cmd[0] & REQ_IDETAPE_READ) {
 			if (error == IDETAPE_ERROR_EOD) {
@@ -1948,7 +1756,7 @@
 				idetape_abort_pipeline(drive, active_stage);
 			}
 		}
-		if (tape->next_stage != NULL && !tape->onstream_write_error) {
+		if (tape->next_stage != NULL) {
 			idetape_active_next_stage(drive);
 
 			/*
@@ -1956,7 +1764,6 @@
 			 */
 			(void) ide_do_drive_cmd(drive, tape->active_data_request, ide_end);
 		} else if (!error) {
-			if (!tape->onstream)
 				idetape_increase_max_pipeline_stages(drive);
 		}
 	}
@@ -2139,8 +1946,6 @@
 
 	/* No more interrupts */
 	if (!status.b.drq) {
-		cmd_time = (jiffies - tape->cmd_start_time) * 1000 / HZ;
-		tape->max_cmd_time = max(cmd_time, tape->max_cmd_time);
 #if IDETAPE_DEBUG_LOG
 		if (tape->debug_level >= 2)
 			printk(KERN_INFO "ide-tape: Packet command completed, %d bytes transferred\n", pc->actually_transferred);
@@ -2178,8 +1983,7 @@
 			return idetape_retry_pc(drive);
 		}
 		pc->error = 0;
-		if (!tape->onstream &&
-		    test_bit(PC_WAIT_FOR_DSC, &pc->flags) &&
+		if (test_bit(PC_WAIT_FOR_DSC, &pc->flags) &&
 		    !status.b.dsc) {
 			/* Media access command */
 			tape->dsc_polling_start = jiffies;
@@ -2333,7 +2137,6 @@
 				"a packet command\n");
 		return ide_do_reset(drive);
 	}
-	tape->cmd_start_time = jiffies;
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -2383,12 +2186,6 @@
 						tape->name, pc->c[0],
 						tape->sense_key, tape->asc,
 						tape->ascq);
-				if (tape->onstream &&
-				    pc->c[0] == IDETAPE_READ_CMD &&
-				    tape->sense_key == 3 &&
-				    tape->asc == 0x11)
-					/* AJN-1: 11 should be 0x11 */
-					printk(KERN_ERR "ide-tape: %s: enabling read error recovery\n", tape->name);
 			}
 			/* Giving up */
 			pc->error = IDETAPE_ERROR_GENERAL;
@@ -2482,48 +2279,6 @@
 	pc->callback = &idetape_pc_callback;
 }
 
-static ide_startstop_t idetape_onstream_buffer_fill_callback (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-
-	tape->max_frames = tape->pc->buffer[4 + 2];
-	tape->cur_frames = tape->pc->buffer[4 + 3];
-	if (tape->chrdev_direction == idetape_direction_write)
-		tape->tape_head = tape->buffer_head - tape->cur_frames;
-	else
-		tape->tape_head = tape->buffer_head + tape->cur_frames;
-	if (tape->tape_head != tape->last_tape_head) {
-		tape->last_tape_head = tape->tape_head;
-		tape->tape_still_time_begin = jiffies;
-		if (tape->tape_still_time > 200)
-			tape->measure_insert_time = 1;
-	}
-	tape->tape_still_time = (jiffies - tape->tape_still_time_begin) * 1000 / HZ;
-#if USE_IOTRACE
-	IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head,
-			tape->tape_head, tape->minor);
-#endif
-#if IDETAPE_DEBUG_LOG
-	if (tape->debug_level >= 1)
-		printk(KERN_INFO "ide-tape: buffer fill callback, %d/%d\n",
-			tape->cur_frames, tape->max_frames);
-#endif
-	idetape_end_request(drive, tape->pc->error ? 0 : 1, 0);
-	return ide_stopped;
-}
-
-static void idetape_queue_onstream_buffer_fill (ide_drive_t *drive)
-{
-	idetape_pc_t *pc;
-	struct request *rq;
-
-	pc = idetape_next_pc_storage(drive);
-	rq = idetape_next_rq_storage(drive);
-	idetape_create_mode_sense_cmd(pc, IDETAPE_BUFFER_FILLING_PAGE);
-	pc->callback = idetape_onstream_buffer_fill_callback;
-	idetape_queue_pc_head(drive, pc, rq);
-}
-
 static void calculate_speeds(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
@@ -2579,8 +2334,6 @@
 	idetape_pc_t *pc = tape->pc;
 	atapi_status_t status;
 
-	if (tape->onstream)
-		printk(KERN_INFO "ide-tape: bug: onstream, media_access_finished\n");
 	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (status.b.dsc) {
 		if (status.b.check) {
@@ -2650,23 +2403,9 @@
 	pc->bh = bh;
 	atomic_set(&bh->b_count, 0);
 	pc->buffer = NULL;
-	if (tape->onstream) {
-		while (p) {
-			atomic_set(&p->b_count, 0);
-			p = p->b_reqnext;
-		}
-	}
-	if (!tape->onstream) {
-		pc->request_transfer = pc->buffer_size = length * tape->tape_block_size;
-		if (pc->request_transfer == tape->stage_size)
-			set_bit(PC_DMA_RECOMMENDED, &pc->flags);
-	} else  {
-		if (length) {
-			pc->request_transfer = pc->buffer_size = 32768 + 512;
-			set_bit(PC_DMA_RECOMMENDED, &pc->flags);
-		} else
-			pc->request_transfer = 0;
-	}
+	pc->request_transfer = pc->buffer_size = length * tape->tape_block_size;
+	if (pc->request_transfer == tape->stage_size)
+		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
 }
 
 static void idetape_create_read_buffer_cmd(idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct idetape_bh *bh)
@@ -2700,27 +2439,13 @@
 	pc->c[1] = 1;
 	pc->callback = &idetape_rw_callback;
 	set_bit(PC_WRITING, &pc->flags);
-	if (tape->onstream) {
-		while (p) {
-			atomic_set(&p->b_count, p->b_size);
-			p = p->b_reqnext;
-		}
-	}
 	pc->bh = bh;
 	pc->b_data = bh->b_data;
 	pc->b_count = atomic_read(&bh->b_count);
 	pc->buffer = NULL;
-	if (!tape->onstream) {
-		pc->request_transfer = pc->buffer_size = length * tape->tape_block_size;
-		if (pc->request_transfer == tape->stage_size)
-			set_bit(PC_DMA_RECOMMENDED, &pc->flags);
-	} else  {
-		if (length) {
-			pc->request_transfer = pc->buffer_size = 32768 + 512;
-			set_bit(PC_DMA_RECOMMENDED, &pc->flags);
-		} else
-			pc->request_transfer = 0;
-	}
+	pc->request_transfer = pc->buffer_size = length * tape->tape_block_size;
+	if (pc->request_transfer == tape->stage_size)
+		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
 }
 
 /*
@@ -2782,65 +2507,14 @@
 	 */
 	status.all = HWIF(drive)->INB(IDE_STATUS_REG);
 
-	/*
-	 * The OnStream tape drive doesn't support DSC. Assume
-	 * that DSC is always set.
-	 */
-	if (tape->onstream)
-		status.b.dsc = 1;
 	if (!drive->dsc_overlap && !(rq->cmd[0] & REQ_IDETAPE_PC2))
 		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
 
-	/*
-	 * For the OnStream tape, check the current status of the tape
-	 * internal buffer using data gathered from the buffer fill
-	 * mode page, and postpone our request, effectively "disconnecting"
-	 * from the IDE bus, in case the buffer is full (writing) or
-	 * empty (reading), and there is a danger that our request will
-	 * hold the IDE bus during actual media access.
-	 */
 	if (tape->tape_still_time > 100 && tape->tape_still_time < 200)
 		tape->measure_insert_time = 1;
-	if (tape->req_buffer_fill &&
-	    (rq->cmd[0] & (REQ_IDETAPE_WRITE | REQ_IDETAPE_READ))) {
-		tape->req_buffer_fill = 0;
-		tape->writes_since_buffer_fill = 0;
-		tape->reads_since_buffer_fill = 0;
-		tape->last_buffer_fill = jiffies;
-		idetape_queue_onstream_buffer_fill(drive);
-		if (time_after(jiffies, tape->insert_time))
-			tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
-		return ide_stopped;
-	}
 	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	calculate_speeds(drive);
-	if (tape->onstream && tape->max_frames &&
-	    (((rq->cmd[0] & REQ_IDETAPE_WRITE) &&
-              ( tape->cur_frames == tape->max_frames ||
-                ( tape->speed_control && tape->cur_frames > 5 &&
-                       (tape->insert_speed > tape->max_insert_speed ||
-                        (0 /* tape->cur_frames > 30 && tape->tape_still_time > 200 */) ) ) ) ) ||
-	     ((rq->cmd[0] & REQ_IDETAPE_READ) &&
-	      ( tape->cur_frames == 0 ||
-		( tape->speed_control && (tape->cur_frames < tape->max_frames - 5) &&
-			tape->insert_speed > tape->max_insert_speed ) ) && rq->nr_sectors) ) ) {
-#if IDETAPE_DEBUG_LOG
-		if (tape->debug_level >= 4)
-			printk(KERN_INFO "ide-tape: postponing request, "
-					"cmd %ld, cur %d, max %d\n",
-				rq->cmd[0], tape->cur_frames, tape->max_frames);
-#endif
-		if (tape->postpone_cnt++ < 500) {
-			status.b.dsc = 0;
-			tape->req_buffer_fill = 1;
-		}
-#if ONSTREAM_DEBUG
-		else if (tape->debug_level >= 4) 
-			printk(KERN_INFO "ide-tape: %s: postpone_cnt %d\n",
-				tape->name, tape->postpone_cnt);
-#endif
-	}
 	if (!test_and_clear_bit(IDETAPE_IGNORE_DSC, &tape->flags) &&
 	    !status.b.dsc) {
 		if (postponed_rq == NULL) {
@@ -2867,13 +2541,6 @@
 		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
 #endif
 		tape->postpone_cnt = 0;
-		tape->reads_since_buffer_fill++;
-		if (tape->onstream) {
-			if (tape->cur_frames - tape->reads_since_buffer_fill <= 0)
-				tape->req_buffer_fill = 1;
-			if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
-				tape->req_buffer_fill = 1;
-		}
 		pc = idetape_next_pc_storage(drive);
 		idetape_create_read_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
 		goto out;
@@ -2884,14 +2551,6 @@
 		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
 #endif
 		tape->postpone_cnt = 0;
-		tape->writes_since_buffer_fill++;
-		if (tape->onstream) {
-			if (tape->cur_frames + tape->writes_since_buffer_fill >= tape->max_frames)
-				tape->req_buffer_fill = 1;
-			if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
-				tape->req_buffer_fill = 1;
-			calculate_speeds(drive);
-		}
 		pc = idetape_next_pc_storage(drive);
 		idetape_create_write_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
 		goto out;
@@ -2995,8 +2654,6 @@
 	bh->b_size -= tape->excess_bh_size;
 	if (full)
 		atomic_sub(tape->excess_bh_size, &bh->b_count);
-	if (tape->onstream)
-		stage->aux = (os_aux_t *) (bh->b_data + bh->b_size - OS_AUX_SIZE);
 	return stage;
 abort:
 	__idetape_kfree_stage(stage);
@@ -3093,14 +2750,10 @@
 static void idetape_switch_buffers (idetape_tape_t *tape, idetape_stage_t *stage)
 {
 	struct idetape_bh *tmp;
-	os_aux_t *tmp_aux;
 
 	tmp = stage->bh;
-	tmp_aux = stage->aux;
 	stage->bh = tape->merge_stage->bh;
-	stage->aux = tape->merge_stage->aux;
 	tape->merge_stage->bh = tmp;
-	tape->merge_stage->aux = tmp_aux;
 	idetape_init_merge_stage(tape);
 }
 
@@ -3131,68 +2784,6 @@
 }
 
 /*
- * Initialize the OnStream AUX
- */
-static void idetape_init_stage (ide_drive_t *drive, idetape_stage_t *stage, int frame_type, int logical_blk_num)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	os_aux_t *aux = stage->aux;
-	os_partition_t *par = &aux->partition;
-	os_dat_t *dat = &aux->dat;
-
-	if (!tape->onstream || tape->raw)
-		return;
-	memset(aux, 0, sizeof(*aux));
-	aux->format_id = htonl(0);
-	memcpy(aux->application_sig, "LIN3", 4);
-	aux->hdwr = htonl(0);
-	aux->frame_type = frame_type;
-
-	if (frame_type == OS_FRAME_TYPE_HEADER) {
-		aux->update_frame_cntr = htonl(tape->update_frame_cntr);
-		par->partition_num = OS_CONFIG_PARTITION;
-		par->par_desc_ver = OS_PARTITION_VERSION;
-		par->wrt_pass_cntr = htons(0xffff);
-		par->first_frame_addr = htonl(0);
-		par->last_frame_addr = htonl(0xbb7); /* 2999 */
-		aux->frame_seq_num = htonl(0);
-		aux->logical_blk_num_high = htonl(0);
-		aux->logical_blk_num = htonl(0);
-		aux->next_mark_addr = htonl(tape->first_mark_addr);
-	} else {
-		aux->update_frame_cntr = htonl(0);
-		par->partition_num = OS_DATA_PARTITION;
-		par->par_desc_ver = OS_PARTITION_VERSION;
-		par->wrt_pass_cntr = htons(tape->wrt_pass_cntr);
-		par->first_frame_addr = htonl(OS_DATA_STARTFRAME1);
-		par->last_frame_addr = htonl(tape->capacity);
-		aux->frame_seq_num = htonl(logical_blk_num);
-		aux->logical_blk_num_high = htonl(0);
-		aux->logical_blk_num = htonl(logical_blk_num);
-		dat->dat_sz = 8;
-		dat->reserved1 = 0;
-		dat->entry_cnt = 1;
-		dat->reserved3 = 0;
-		if (frame_type == OS_FRAME_TYPE_DATA)
-			dat->dat_list[0].blk_sz = htonl(32 * 1024);
-		else
-			dat->dat_list[0].blk_sz = 0;
-		dat->dat_list[0].blk_cnt = htons(1);
-		if (frame_type == OS_FRAME_TYPE_MARKER)
-			dat->dat_list[0].flags = OS_DAT_FLAGS_MARK;
-		else
-			dat->dat_list[0].flags = OS_DAT_FLAGS_DATA;
-		dat->dat_list[0].reserved = 0;
-	}
-	/* shouldn't this be htonl ?? */
-	aux->filemark_cnt = ntohl(tape->filemark_cnt);
-	/* shouldn't this be htonl ?? */
-	aux->phys_fm = ntohl(0xffffffff);
-	/* shouldn't this be htonl ?? */
-	aux->last_mark_addr = ntohl(tape->last_mark_addr);
-}
-
-/*
  *	idetape_wait_for_request installs a completion in a pending request
  *	and sleeps until it is serviced.
  *
@@ -3211,11 +2802,9 @@
 	}
 #endif /* IDETAPE_DEBUG_BUGS */
 	rq->waiting = &wait;
-	tape->waiting = &wait;
 	spin_unlock_irq(&tape->spinlock);
 	wait_for_completion(&wait);
 	/* The stage and its struct request have been deallocated */
-	tape->waiting = NULL;
 	spin_lock_irq(&tape->spinlock);
 }
 
@@ -3273,9 +2862,7 @@
 
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_WRITE_FILEMARK_CMD;
-	if (tape->onstream)
-		pc->c[1] = 1; /* Immed bit */
-	pc->c[4] = write_filemark;  /* not used for OnStream ?? */
+	pc->c[4] = write_filemark;
 	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
 	pc->callback = &idetape_pc_callback;
 }
@@ -3323,11 +2910,6 @@
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_LOAD_UNLOAD_CMD;
 	pc->c[4] = cmd;
-	if (tape->onstream) {
-		pc->c[1] = 1;
-		if (cmd == !IDETAPE_LU_LOAD_MASK)
-			pc->c[4] = 4;
-	}
 	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
 	pc->callback = &idetape_pc_callback;
 }
@@ -3370,15 +2952,6 @@
 	int rc;
 
 	rc = __idetape_queue_pc_tail(drive, pc);
-	if (rc)
-		return rc;
-	if (tape->onstream && test_bit(PC_WAIT_FOR_DSC, &pc->flags)) {
-		/* AJN-4: Changed from 5 to 10 minutes;
-		 * because retension takes approx.
-		 * 8:20 with Onstream 30GB tape
-		 */
-		rc = idetape_wait_ready(drive, 60 * 10 * HZ);
-	}
 	return rc;
 }
 
@@ -3426,19 +2999,9 @@
 
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_LOCATE_CMD;
-	if (tape->onstream)
-		pc->c[1] = 1; /* Immediate bit */
-	else
-		pc->c[1] = 2;
+	pc->c[1] = 2;
 	put_unaligned(htonl(block), (unsigned int *) &pc->c[3]);
 	pc->c[8] = partition;
-	if (tape->onstream)
-                /*
-                 * Set SKIP bit.
-                 * In case of write error this will write buffered
-                 * data in the drive to this new position!
-                 */
-		pc->c[9] = skip << 7;
 	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
 	pc->callback = &idetape_pc_callback;
 }
@@ -3539,10 +3102,6 @@
 	cnt = __idetape_discard_read_pipeline(drive);
 	if (restore_position) {
 		position = idetape_read_position(drive);
-#if ONSTREAM_DEBUG
-		if (tape->debug_level >= 2)
-			printk(KERN_INFO "ide-tape: address %u, nr_stages %d\n", position, cnt);
-#endif
 		seek = position > cnt ? position - cnt : 0;
 		if (idetape_position_tape(drive, seek, 0, 0)) {
 			printk(KERN_INFO "ide-tape: %s: position_tape failed in discard_pipeline()\n", tape->name);
@@ -3551,15 +3110,6 @@
 	}
 }
 
-static void idetape_update_stats (ide_drive_t *drive)
-{
-	idetape_pc_t pc;
-
-	idetape_create_mode_sense_cmd(&pc, IDETAPE_BUFFER_FILLING_PAGE);
-	pc.callback = idetape_onstream_buffer_fill_callback;
-	(void) idetape_queue_pc_tail(drive, &pc);
-}
-
 /*
  * idetape_queue_rw_tail generates a read/write request for the block
  * device interface and wait for it to be serviced.
@@ -3584,8 +3134,6 @@
 	rq.special = (void *)bh;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
-	if (tape->onstream)
-		tape->postpone_cnt = 600;
 	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
 
 	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
@@ -3599,108 +3147,6 @@
 }
 
 /*
- * Read back the drive's internal buffer contents, as a part
- * of the write error recovery mechanism for old OnStream
- * firmware revisions.
- */
-static void idetape_onstream_read_back_buffer (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	int frames, i, logical_blk_num;
-	idetape_stage_t *stage, *first = NULL, *last = NULL;
-	os_aux_t *aux;
-	struct request *rq;
-	unsigned char *p;
-	unsigned long flags;
-
-	idetape_update_stats(drive);
-	frames = tape->cur_frames;
-	logical_blk_num = ntohl(tape->first_stage->aux->logical_blk_num) - frames;
-	printk(KERN_INFO "ide-tape: %s: reading back %d frames from the drive's internal buffer\n", tape->name, frames);
-	for (i = 0; i < frames; i++) {
-		stage = __idetape_kmalloc_stage(tape, 0, 0);
-		if (!first)
-			first = stage;
-		aux = stage->aux;
-		p = stage->bh->b_data;
-		idetape_queue_rw_tail(drive, REQ_IDETAPE_READ_BUFFER, tape->capabilities.ctl, stage->bh);
-#if ONSTREAM_DEBUG
-		if (tape->debug_level >= 2)
-			printk(KERN_INFO "ide-tape: %s: read back logical block %d, data %x %x %x %x\n", tape->name, logical_blk_num, *p++, *p++, *p++, *p++);
-#endif
-		rq = &stage->rq;
-		idetape_init_rq(rq, REQ_IDETAPE_WRITE);
-		rq->sector = tape->first_frame_position;
-		rq->nr_sectors = rq->current_nr_sectors = tape->capabilities.ctl;
-		idetape_init_stage(drive, stage, OS_FRAME_TYPE_DATA, logical_blk_num++);
-		stage->next = NULL;
-		if (last)
-			last->next = stage;
-		last = stage;
-	}
-	if (frames) {
-		spin_lock_irqsave(&tape->spinlock, flags);
-		last->next = tape->first_stage;
-		tape->next_stage = tape->first_stage = first;
-		tape->nr_stages += frames;
-		tape->nr_pending_stages += frames;
-		spin_unlock_irqrestore(&tape->spinlock, flags);
-	}
-	idetape_update_stats(drive);
-#if ONSTREAM_DEBUG
-	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: %s: frames left in buffer: %d\n", tape->name, tape->cur_frames);
-#endif
-}
-
-/*
- * Error recovery algorithm for the OnStream tape.
- */
-static void idetape_onstream_write_error_recovery (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	unsigned int block;
-
-	if (tape->onstream_write_error == OS_WRITE_ERROR) {
-		printk(KERN_ERR "ide-tape: %s: onstream_write_error_recovery: detected physical bad block at %u, logical %u first frame %u last_frame %u bufblocks %u stages %u skipping %u frames\n",
-			tape->name, ntohl(tape->sense.information), tape->logical_blk_num,
-			tape->first_frame_position, tape->last_frame_position,
-			tape->blocks_in_buffer, tape->nr_stages,
- 			(ntohl(tape->sense.command_specific) >> 16) & 0xff );
-		block = ntohl(tape->sense.information) + ((ntohl(tape->sense.command_specific) >> 16) & 0xff);
-		idetape_update_stats(drive);
-		printk(KERN_ERR "ide-tape: %s: relocating %d buffered logical blocks to physical block %u\n", tape->name, tape->cur_frames, block);
-#if 0  /* isn't once enough ??? MM */
-		idetape_update_stats(drive);
-#endif
-		if (tape->firmware_revision_num >= 106)
-			idetape_position_tape(drive, block, 0, 1);
-		else {
-			idetape_onstream_read_back_buffer(drive);
-			idetape_position_tape(drive, block, 0, 0);
-		}
-#if 0     /* already done in idetape_position_tape MM */
-		idetape_read_position(drive);
-#endif
-#if ONSTREAM_DEBUG
-		if (tape->debug_level >= 1)
-			printk(KERN_ERR "ide-tape: %s: positioning complete, cur_frames %d, pos %d, tape pos %d\n", tape->name, tape->cur_frames, tape->first_frame_position, tape->last_frame_position);
-#endif
-	} else if (tape->onstream_write_error == OS_PART_ERROR) {
-#if ONSTREAM_DEBUG
-		if (tape->debug_level >= 1)
-			printk(KERN_INFO "ide-tape: %s: skipping over config partition\n", tape->name);
-#endif
-		idetape_flush_tape_buffers(drive);
-		block = idetape_read_position(drive);
-		if (block != OS_DATA_ENDFRAME1)  
-			printk(KERN_ERR "ide-tape: warning, current position %d, expected %d\n", block, OS_DATA_ENDFRAME1);
-		idetape_position_tape(drive, 0xbb8, 0, 0); /* 3000 */
-	}
-	tape->onstream_write_error = 0;
-}
-
-/*
  *	idetape_insert_pipeline_into_queue is used to start servicing the
  *	pipeline stages, starting from tape->next_stage.
  */
@@ -3711,8 +3157,6 @@
 	if (tape->next_stage == NULL)
 		return;
 	if (!idetape_pipeline_active(tape)) {
-		if (tape->onstream_write_error)
-			idetape_onstream_write_error_recovery(drive);
 		set_bit(IDETAPE_PIPELINE_ACTIVE, &tape->flags);
 		idetape_active_next_stage(drive);
 		(void) ide_do_drive_cmd(drive, tape->active_data_request, ide_end);
@@ -3733,8 +3177,6 @@
 
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_REWIND_CMD;
-	if (tape->onstream)
-		pc->c[1] = 1;
 	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
 	pc->callback = &idetape_pc_callback;
 }
@@ -3769,82 +3211,6 @@
 	pc->callback = &idetape_pc_callback;
 }
 
-/*
- * Verify that we have the correct tape frame
- */
-static int idetape_verify_stage (ide_drive_t *drive, idetape_stage_t *stage, int logical_blk_num, int quiet)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	os_aux_t *aux = stage->aux;
-	os_partition_t *par = &aux->partition;
-	struct request *rq = &stage->rq;
-	struct idetape_bh *bh;
-
-	if (!tape->onstream)
-		return 1;
-	if (tape->raw) {
-		if (rq->errors) {
-			bh = stage->bh;
-			while (bh) {
-				memset(bh->b_data, 0, bh->b_size);
-				bh = bh->b_reqnext;
-			}
-			strcpy(stage->bh->b_data, "READ ERROR ON FRAME");
-		}
-		return 1;
-	}
-	if (rq->errors == IDETAPE_ERROR_GENERAL) {
-		printk(KERN_INFO "ide-tape: %s: skipping frame %d, read error\n", tape->name, tape->first_frame_position);
-		return 0;
-	}
-	if (rq->errors == IDETAPE_ERROR_EOD) {
-		printk(KERN_INFO "ide-tape: %s: skipping frame %d, eod\n", tape->name, tape->first_frame_position);
-		return 0;
-	}
-	if (ntohl(aux->format_id) != 0) {
-		printk(KERN_INFO "ide-tape: %s: skipping frame %d, format_id %u\n", tape->name, tape->first_frame_position, ntohl(aux->format_id));
-		return 0;
-	}
-	if (memcmp(aux->application_sig, tape->application_sig, 4) != 0) {
-		printk(KERN_INFO "ide-tape: %s: skipping frame %d, incorrect application signature\n", tape->name, tape->first_frame_position);
-		return 0;
-	}
-	if (aux->frame_type != OS_FRAME_TYPE_DATA &&
-	    aux->frame_type != OS_FRAME_TYPE_EOD &&
-	    aux->frame_type != OS_FRAME_TYPE_MARKER) {
-		printk(KERN_INFO "ide-tape: %s: skipping frame %d, frame type %x\n", tape->name, tape->first_frame_position, aux->frame_type);
-		return 0;
-	}
-	if (par->partition_num != OS_DATA_PARTITION) {
-		if (!tape->linux_media || tape->linux_media_version != 2) {
-			printk(KERN_INFO "ide-tape: %s: skipping frame %d, partition num %d\n", tape->name, tape->first_frame_position, par->partition_num);
-			return 0;
-		}
-	}
-	if (par->par_desc_ver != OS_PARTITION_VERSION) {
-		printk(KERN_INFO "ide-tape: %s: skipping frame %d, partition version %d\n", tape->name, tape->first_frame_position, par->par_desc_ver);
-		return 0;
-	}
-	if (ntohs(par->wrt_pass_cntr) != tape->wrt_pass_cntr) {
-		printk(KERN_INFO "ide-tape: %s: skipping frame %d, wrt_pass_cntr %d (expected %d)(logical_blk_num %u)\n", tape->name, tape->first_frame_position, ntohs(par->wrt_pass_cntr), tape->wrt_pass_cntr, ntohl(aux->logical_blk_num));
-		return 0;
-	}
-	if (aux->frame_seq_num != aux->logical_blk_num) {
-		printk(KERN_INFO "ide-tape: %s: skipping frame %d, seq != logical\n", tape->name, tape->first_frame_position);
-		return 0;
-	}
-	if (logical_blk_num != -1 && ntohl(aux->logical_blk_num) != logical_blk_num) {
-		if (!quiet)
-			printk(KERN_INFO "ide-tape: %s: skipping frame %d, logical_blk_num %u (expected %d)\n", tape->name, tape->first_frame_position, ntohl(aux->logical_blk_num), logical_blk_num);
-		return 0;
-	}
-	if (aux->frame_type == OS_FRAME_TYPE_MARKER) {
-		rq->errors = IDETAPE_ERROR_FILEMARK;
-		rq->current_nr_sectors = rq->nr_sectors;
-	}
-	return 1;
-}
-
 static void idetape_wait_first_stage (ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
@@ -3909,8 +3275,6 @@
 	rq->nr_sectors = rq->current_nr_sectors = blocks;
 
 	idetape_switch_buffers(tape, new_stage);
-	idetape_init_stage(drive, new_stage, OS_FRAME_TYPE_DATA, tape->logical_blk_num);
-	tape->logical_blk_num++;
 	idetape_add_stage_tail(drive, new_stage);
 	tape->pipeline_head++;
 #if USE_IOTRACE
@@ -3924,15 +3288,6 @@
 	 *	writing anymore, wait for the pipeline to be full enough
 	 *	(90%) before starting to service requests, so that we will
 	 *	be able to keep up with the higher speeds of the tape.
-	 *
-	 *	For the OnStream drive, we can query the number of pending
-	 *	frames in the drive's internal buffer. As long as the tape
-	 *	is still writing, it is better to write frames immediately
-	 *	rather than gather them in the pipeline. This will give the
-	 *	tape's firmware the ability to sense the current incoming
-	 *	data rate more accurately, and since the OnStream tape
-	 *	supports variable speeds, it can try to adjust itself to the
-	 *	incoming data rate.
 	 */
 	if (!idetape_pipeline_active(tape)) {
 		if (tape->nr_stages >= tape->max_stages * 9 / 10 ||
@@ -3942,10 +3297,6 @@
 			tape->insert_size = 0;
 			tape->insert_speed = 0;
 			idetape_insert_pipeline_into_queue(drive);
-		} else if (tape->onstream) {
-			idetape_update_stats(drive);
-			if (tape->cur_frames > 5)
-				idetape_insert_pipeline_into_queue(drive);
 		}
 	}
 	if (test_and_clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags))
@@ -4052,7 +3403,6 @@
 
 	tape->restart_speed_control_req = 0;
 	tape->pipeline_head = 0;
-	tape->buffer_head = tape->tape_head = tape->cur_frames;
 	tape->controlled_last_pipeline_head = tape->uncontrolled_last_pipeline_head = 0;
 	tape->controlled_previous_pipeline_head = tape->uncontrolled_previous_pipeline_head = 0;
 	tape->pipeline_head_speed = tape->controlled_pipeline_head_speed = 5000;
@@ -4084,7 +3434,6 @@
 		if ((tape->merge_stage = __idetape_kmalloc_stage(tape, 0, 0)) == NULL)
 			return -ENOMEM;
 		tape->chrdev_direction = idetape_direction_read;
-		tape->logical_blk_num = 0;
 
 		/*
 		 *	Issue a read 0 command to ensure that DSC handshake
@@ -4126,89 +3475,11 @@
 			tape->insert_size = 0;
 			tape->insert_speed = 0;
 			idetape_insert_pipeline_into_queue(drive);
-		} else if (tape->onstream) {
-			idetape_update_stats(drive);
-			if (tape->cur_frames < tape->max_frames - 5)
-				idetape_insert_pipeline_into_queue(drive);
 		}
 	}
 	return 0;
 }
 
-static int idetape_get_logical_blk (ide_drive_t *drive, int logical_blk_num, int max_stages, int quiet)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	unsigned long flags;
-	int cnt = 0, x, position;
-
-	/*
-	 * Search and wait for the next logical tape block
-	 */
-	while (1) {
-		if (cnt++ > 1000) {   /* AJN: was 100 */
-			printk(KERN_INFO "ide-tape: %s: couldn't find logical block %d, aborting\n", tape->name, logical_blk_num);
-			return 0;
-		}
-		idetape_initiate_read(drive, max_stages);
-		if (tape->first_stage == NULL) {
-			if (tape->onstream) {
-#if ONSTREAM_DEBUG
-				if (tape->debug_level >= 1)
-					printk(KERN_INFO "ide-tape: %s: first_stage == NULL, pipeline error %ld\n", tape->name, (long)test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags));
-#endif
-				clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
-				position = idetape_read_position(drive);
-				printk(KERN_INFO "ide-tape: %s: blank block detected at %d\n", tape->name, position);
-				if (position >= 3000 && position < 3080)
-					/* Why is this check and number ??? MM */
-					position += 32;
-				if (position >= OS_DATA_ENDFRAME1 &&
-				    position < 3000)
-					position = 3000;
-				else
-					/*
-					 * compensate for write errors that
-					 * generally skip 80 frames, expect
-					 * around 20 read errors in a row...
-					 */
-					position += 60;
-				if (position >= OS_DATA_ENDFRAME1 &&
-				    position < 3000)
-					position = 3000;
-				printk(KERN_INFO "ide-tape: %s: positioning tape to block %d\n", tape->name, position);
-
-				/* seems to be needed to correctly position
-				 * at block 3000 MM
-				 */
-				if (position == 3000)
-					idetape_position_tape(drive, 0, 0, 0);
-				idetape_position_tape(drive, position, 0, 0);
-				cnt += 40;
-				continue;
-			} else
-				return 0;
-		}
-		idetape_wait_first_stage(drive);
-		if (idetape_verify_stage(drive, tape->first_stage, logical_blk_num, quiet))
-			break;
-		if (tape->first_stage->rq.errors == IDETAPE_ERROR_EOD)
-			cnt--;
-		if (idetape_verify_stage(drive, tape->first_stage, -1, quiet)) {
-			x = ntohl(tape->first_stage->aux->logical_blk_num);
-			if (x > logical_blk_num) {
-				printk(KERN_ERR "ide-tape: %s: couldn't find logical block %d, aborting (block %d found)\n", tape->name, logical_blk_num, x);
-				return 0;
-			}
-		}
-		spin_lock_irqsave(&tape->spinlock, flags);
-		idetape_remove_stage_head(drive);
-		spin_unlock_irqrestore(&tape->spinlock, flags);
-	}
-	if (tape->onstream)
-		tape->logical_blk_num = ntohl(tape->first_stage->aux->logical_blk_num);
-	return 1;
-}
-
 /*
  *	idetape_add_chrdev_read_request is called from idetape_chrdev_read
  *	to service a character device read request and add read-ahead
@@ -4233,48 +3504,30 @@
 		return 0;
 
 	/*
-	 * Wait for the next logical block to be available at the head
+	 * Wait for the next block to be available at the head
 	 * of the pipeline
 	 */
-	if (!idetape_get_logical_blk(drive, tape->logical_blk_num, tape->max_stages, 0)) {
-		if (tape->onstream) {
-			set_bit(IDETAPE_READ_ERROR, &tape->flags);
-			return 0;
-		}
+	idetape_initiate_read(drive, tape->max_stages);
+	if (tape->first_stage == NULL) {
 		if (test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags))
-		 	return 0;
+			return 0;
 		return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks, tape->merge_stage->bh);
 	}
+	idetape_wait_first_stage(drive);
 	rq_ptr = &tape->first_stage->rq;
 	bytes_read = tape->tape_block_size * (rq_ptr->nr_sectors - rq_ptr->current_nr_sectors);
 	rq_ptr->nr_sectors = rq_ptr->current_nr_sectors = 0;
 
 
-	if (tape->onstream && !tape->raw &&
-	    tape->first_stage->aux->frame_type == OS_FRAME_TYPE_EOD) {
-#if ONSTREAM_DEBUG
-		if (tape->debug_level >= 2)
-			printk(KERN_INFO "ide-tape: %s: EOD reached\n",
-				tape->name);
-#endif
-		return 0;
-	}
 	if (rq_ptr->errors == IDETAPE_ERROR_EOD)
 		return 0;
 	else {
 		idetape_switch_buffers(tape, tape->first_stage);
-		if (rq_ptr->errors == IDETAPE_ERROR_GENERAL) {
-#if ONSTREAM_DEBUG
-			if (tape->debug_level >= 1)
-				printk(KERN_INFO "ide-tape: error detected, bytes_read %d\n", bytes_read);
-#endif
-		}
 		if (rq_ptr->errors == IDETAPE_ERROR_FILEMARK)
 			set_bit(IDETAPE_FILEMARK, &tape->flags);
 		spin_lock_irqsave(&tape->spinlock, flags);
 		idetape_remove_stage_head(drive);
 		spin_unlock_irqrestore(&tape->spinlock, flags);
-		tape->logical_blk_num++;
 		tape->pipeline_head++;
 #if USE_IOTRACE
 		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
@@ -4357,7 +3610,6 @@
 	retval = idetape_queue_pc_tail(drive, &pc);
 	if (retval)
 		return retval;
-	tape->logical_blk_num = 0;
 	return 0;
 }
 
@@ -4406,202 +3658,23 @@
 		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
 }
 
-static int idetape_onstream_space_over_filemarks_backward (ide_drive_t *drive,short mt_op,int mt_count)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	int cnt = 0;
-	int last_mark_addr;
-	unsigned long flags;
-
-	if (!idetape_get_logical_blk(drive, -1, 10, 0)) {
-		printk(KERN_INFO "ide-tape: %s: couldn't get logical blk num in space_filemarks_bwd\n", tape->name);
-		return -EIO;
-	}
-	while (cnt != mt_count) {
-		last_mark_addr = ntohl(tape->first_stage->aux->last_mark_addr);
-		if (last_mark_addr == -1)
-			return -EIO;
-#if ONSTREAM_DEBUG
-		if (tape->debug_level >= 2)
-			printk(KERN_INFO "ide-tape: positioning to last mark at %d\n", last_mark_addr);
-#endif
-		idetape_position_tape(drive, last_mark_addr, 0, 0);
-		cnt++;
-		if (!idetape_get_logical_blk(drive, -1, 10, 0)) {
-			printk(KERN_INFO "ide-tape: %s: couldn't get logical blk num in space_filemarks\n", tape->name);
-			return -EIO;
-		}
-		if (tape->first_stage->aux->frame_type != OS_FRAME_TYPE_MARKER) {
-			printk(KERN_INFO "ide-tape: %s: expected to find marker at block %d, not found\n", tape->name, last_mark_addr);
-			return -EIO;
-		}
-	}
-	if (mt_op == MTBSFM) {
-		spin_lock_irqsave(&tape->spinlock, flags);
-		idetape_remove_stage_head(drive);
-		tape->logical_blk_num++;
-		spin_unlock_irqrestore(&tape->spinlock, flags);
-	}
-	return 0;
-}
-
 /*
- * ADRL 1.1 compatible "slow" space filemarks fwd version
+ *	idetape_space_over_filemarks is now a bit more complicated than just
+ *	passing the command to the tape since we may have crossed some
+ *	filemarks during our pipelined read-ahead mode.
  *
- * Just scans for the filemark sequentially.
+ *	As a minor side effect, the pipeline enables us to support MTFSFM when
+ *	the filemark is in our internal pipeline even if the tape doesn't
+ *	support spacing over filemarks in the reverse direction.
  */
-static int idetape_onstream_space_over_filemarks_forward_slow (ide_drive_t *drive,short mt_op,int mt_count)
+static int idetape_space_over_filemarks (ide_drive_t *drive,short mt_op,int mt_count)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	int cnt = 0;
+	idetape_pc_t pc;
 	unsigned long flags;
+	int retval,count=0;
+	int speed_control;
 
-	if (!idetape_get_logical_blk(drive, -1, 10, 0)) {
-		printk(KERN_INFO "ide-tape: %s: couldn't get logical blk num in space_filemarks_fwd\n", tape->name);
-		return -EIO;
-	}
-	while (1) {
-		if (!idetape_get_logical_blk(drive, -1, 10, 0)) {
-			printk(KERN_INFO "ide-tape: %s: couldn't get logical blk num in space_filemarks\n", tape->name);
-			return -EIO;
-		}
-		if (tape->first_stage->aux->frame_type == OS_FRAME_TYPE_MARKER)
-			cnt++;
-		if (tape->first_stage->aux->frame_type == OS_FRAME_TYPE_EOD) {
-#if ONSTREAM_DEBUG
-			if (tape->debug_level >= 2)
-				printk(KERN_INFO "ide-tape: %s: space_fwd: EOD reached\n", tape->name);
-#endif
-			return -EIO;
-		}
-		if (cnt == mt_count)
-			break;
-		spin_lock_irqsave(&tape->spinlock, flags);
-		idetape_remove_stage_head(drive);
-		spin_unlock_irqrestore(&tape->spinlock, flags);
-	}
-	if (mt_op == MTFSF) {
-		spin_lock_irqsave(&tape->spinlock, flags);
-		idetape_remove_stage_head(drive);
-		tape->logical_blk_num++;
-		spin_unlock_irqrestore(&tape->spinlock, flags);
-	}
-	return 0;
-}
-
-
-/*
- * Fast linux specific version of OnStream FSF
- */
-static int idetape_onstream_space_over_filemarks_forward_fast (ide_drive_t *drive,short mt_op,int mt_count)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	int cnt = 0, next_mark_addr;
-	unsigned long flags;
-
-	if (!idetape_get_logical_blk(drive, -1, 10, 0)) {
-		printk(KERN_INFO "ide-tape: %s: couldn't get logical blk num in space_filemarks_fwd\n", tape->name);
-		return -EIO;
-	}
-
-	/*
-	 * Find nearest (usually previous) marker
-	 */
-	while (1) {
-		if (tape->first_stage->aux->frame_type == OS_FRAME_TYPE_MARKER)
-			break;
-		if (tape->first_stage->aux->frame_type == OS_FRAME_TYPE_EOD) {
-#if ONSTREAM_DEBUG
-			if (tape->debug_level >= 2)
-				printk(KERN_INFO "ide-tape: %s: space_fwd: EOD reached\n", tape->name);
-#endif
-			return -EIO;
-		}
-		if (ntohl(tape->first_stage->aux->filemark_cnt) == 0) {
-			if (tape->first_mark_addr == -1) {
-				printk(KERN_INFO "ide-tape: %s: reverting to slow filemark space\n", tape->name);
-				return idetape_onstream_space_over_filemarks_forward_slow(drive, mt_op, mt_count);
-			}
-			idetape_position_tape(drive, tape->first_mark_addr, 0, 0);
-			if (!idetape_get_logical_blk(drive, -1, 10, 0)) {
-				printk(KERN_INFO "ide-tape: %s: couldn't get logical blk num in space_filemarks_fwd_fast\n", tape->name);
-				return -EIO;
-			}
-			if (tape->first_stage->aux->frame_type != OS_FRAME_TYPE_MARKER) {
-				printk(KERN_INFO "ide-tape: %s: expected to find filemark at %d\n", tape->name, tape->first_mark_addr);
-				return -EIO;
-			}
-		} else {
-			if (idetape_onstream_space_over_filemarks_backward(drive, MTBSF, 1) < 0)
-				return -EIO;
-			mt_count++;
-		}
-	}
-	cnt++;
-	while (cnt != mt_count) {
-		next_mark_addr = ntohl(tape->first_stage->aux->next_mark_addr);
-		if (!next_mark_addr || next_mark_addr > tape->eod_frame_addr) {
-			printk(KERN_INFO "ide-tape: %s: reverting to slow filemark space\n", tape->name);
-			return idetape_onstream_space_over_filemarks_forward_slow(drive, mt_op, mt_count - cnt);
-#if ONSTREAM_DEBUG
-		} else if (tape->debug_level >= 2) {
-		     printk(KERN_INFO "ide-tape: positioning to next mark at %d\n", next_mark_addr);
-#endif
-		}
-		idetape_position_tape(drive, next_mark_addr, 0, 0);
-		cnt++;
-		if (!idetape_get_logical_blk(drive, -1, 10, 0)) {
-			printk(KERN_INFO "ide-tape: %s: couldn't get logical blk num in space_filemarks\n", tape->name);
-			return -EIO;
-		}
-		if (tape->first_stage->aux->frame_type != OS_FRAME_TYPE_MARKER) {
-			printk(KERN_INFO "ide-tape: %s: expected to find marker at block %d, not found\n", tape->name, next_mark_addr);
-			return -EIO;
-		}
-	}
-	if (mt_op == MTFSF) {
-		spin_lock_irqsave(&tape->spinlock, flags);
-		idetape_remove_stage_head(drive);
-		tape->logical_blk_num++;
-		spin_unlock_irqrestore(&tape->spinlock, flags);
-	}
-	return 0;
-}
-
-/*
- *	idetape_space_over_filemarks is now a bit more complicated than just
- *	passing the command to the tape since we may have crossed some
- *	filemarks during our pipelined read-ahead mode.
- *
- *	As a minor side effect, the pipeline enables us to support MTFSFM when
- *	the filemark is in our internal pipeline even if the tape doesn't
- *	support spacing over filemarks in the reverse direction.
- */
-static int idetape_space_over_filemarks (ide_drive_t *drive,short mt_op,int mt_count)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	idetape_pc_t pc;
-	unsigned long flags;
-	int retval,count=0;
-	int speed_control;
-
-	if (tape->onstream) {
-		if (tape->raw)
-			return -EIO;
-		speed_control = tape->speed_control;
-		tape->speed_control = 0;
-		if (mt_op == MTFSF || mt_op == MTFSFM) {
-			if (tape->linux_media)
-				retval = idetape_onstream_space_over_filemarks_forward_fast(drive, mt_op, mt_count);
-			else
-				retval = idetape_onstream_space_over_filemarks_forward_slow(drive, mt_op, mt_count);
-		} else
-			retval = idetape_onstream_space_over_filemarks_backward(drive, mt_op, mt_count);
-		tape->speed_control = speed_control;
-		tape->restart_speed_control_req = 1;
-		return retval;
-	}
- 
 	if (mt_count == 0)
 		return 0;
 	if (MTBSF == mt_op || MTBSFM == mt_op) {
@@ -4700,10 +3773,6 @@
 		/* "A request was outside the capabilities of the device." */
 		return -ENXIO;
 	}
-	if (tape->onstream && (count != tape->tape_block_size)) {
-		printk(KERN_ERR "ide-tape: %s: use %d bytes as block size (%Zd used)\n", tape->name, tape->tape_block_size, count);
-		return -EINVAL;
-	}
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 3)
 		printk(KERN_INFO "ide-tape: Reached idetape_chrdev_read, count %Zd\n", count);
@@ -4753,170 +3822,9 @@
 		idetape_space_over_filemarks(drive, MTFSF, 1);
 		return 0;
 	}
-	if (tape->onstream && !actually_read &&
-	    test_and_clear_bit(IDETAPE_READ_ERROR, &tape->flags)) {
-		printk(KERN_ERR "ide-tape: %s: unrecovered read error on "
-			"logical block number %d, skipping\n",
-			tape->name, tape->logical_blk_num);
-		tape->logical_blk_num++;
-		return -EIO;
-	}
 	return actually_read;
 }
 
-static void idetape_update_last_marker (ide_drive_t *drive, int last_mark_addr, int next_mark_addr)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage;
-	os_aux_t *aux;
-	int position;
-
-	if (!tape->onstream || tape->raw)
-		return;
-	if (last_mark_addr == -1)
-		return;
-	stage = __idetape_kmalloc_stage(tape, 0, 0);
-	if (stage == NULL)
-		return;
-	idetape_flush_tape_buffers(drive);
-	position = idetape_read_position(drive);
-#if ONSTREAM_DEBUG
-	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: current position (2) %d, "
-			"lblk %d\n", position, tape->logical_blk_num);
-	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: current position (2) "
-			"tape block %d\n", tape->last_frame_position);
-#endif
-	idetape_position_tape(drive, last_mark_addr, 0, 0);
-	if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 1, stage->bh)) {
-		printk(KERN_INFO "ide-tape: %s: couldn't read last marker\n",
-			tape->name);
-		__idetape_kfree_stage(stage);
-		idetape_position_tape(drive, position, 0, 0);
-		return;
-	}
-	aux = stage->aux;
-	if (aux->frame_type != OS_FRAME_TYPE_MARKER) {
-		printk(KERN_INFO "ide-tape: %s: expected to find marker "
-			"at addr %d\n", tape->name, last_mark_addr);
-		__idetape_kfree_stage(stage);
-		idetape_position_tape(drive, position, 0, 0);
-		return;
-	}
-#if ONSTREAM_DEBUG
-	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: writing back marker\n");
-#endif
-	aux->next_mark_addr = htonl(next_mark_addr);
-	idetape_position_tape(drive, last_mark_addr, 0, 0);
-	if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 1, stage->bh)) {
-		printk(KERN_INFO "ide-tape: %s: couldn't write back marker "
-			"frame at %d\n", tape->name, last_mark_addr);
-		__idetape_kfree_stage(stage);
-		idetape_position_tape(drive, position, 0, 0);
-		return;
-	}
-	__idetape_kfree_stage(stage);
-	idetape_flush_tape_buffers(drive);
-	idetape_position_tape(drive, position, 0, 0);
-	return;
-}
-
-static void idetape_write_filler (ide_drive_t *drive, int block, int cnt)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage;
-	int rc;
-
-	if (!tape->onstream || tape->raw)
-		return;
-	stage = __idetape_kmalloc_stage(tape, 1, 1);
-	if (stage == NULL)
-		return;
-	idetape_init_stage(drive, stage, OS_FRAME_TYPE_FILL, 0);
-	idetape_wait_ready(drive, 60 * 5 * HZ);
-	rc = idetape_position_tape(drive, block, 0, 0);
-#if ONSTREAM_DEBUG
-	printk(KERN_INFO "write_filler: positioning failed it returned %d\n", rc);
-#endif
-	if (rc != 0)
-		/* don't write fillers if we cannot position the tape. */
-		return;
-
-	strcpy(stage->bh->b_data, "Filler");
-	while (cnt--) {
-		if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 1, stage->bh)) {
-			printk(KERN_INFO "ide-tape: %s: write_filler: "
-				"couldn't write header frame\n", tape->name);
-			__idetape_kfree_stage(stage);
-			return;
-		}
-	}
-	__idetape_kfree_stage(stage);
-}
-
-static void __idetape_write_header (ide_drive_t *drive, int block, int cnt)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage;
-	os_header_t header;
-
-	stage = __idetape_kmalloc_stage(tape, 1, 1);
-	if (stage == NULL)
-		return;
-	idetape_init_stage(drive, stage, OS_FRAME_TYPE_HEADER, tape->logical_blk_num);
-	idetape_wait_ready(drive, 60 * 5 * HZ);
-	idetape_position_tape(drive, block, 0, 0);
-	memset(&header, 0, sizeof(header));
-	strcpy(header.ident_str, "ADR_SEQ");
-	header.major_rev = 1;
-	header.minor_rev = OS_ADR_MINREV;
-	header.par_num = 1;
-	header.partition.partition_num = OS_DATA_PARTITION;
-	header.partition.par_desc_ver = OS_PARTITION_VERSION;
-	header.partition.first_frame_addr = htonl(OS_DATA_STARTFRAME1);
-	header.partition.last_frame_addr = htonl(tape->capacity);
-	header.partition.wrt_pass_cntr = htons(tape->wrt_pass_cntr);
-	header.partition.eod_frame_addr = htonl(tape->eod_frame_addr);
-	memcpy(stage->bh->b_data, &header, sizeof(header));
-	while (cnt--) {
-		if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE, 1, stage->bh)) {
-			printk(KERN_INFO "ide-tape: %s: couldn't write "
-				"header frame\n", tape->name);
-			__idetape_kfree_stage(stage);
-			return;
-		}
-	}
-	__idetape_kfree_stage(stage);
-	idetape_flush_tape_buffers(drive);
-}
-
-static void idetape_write_header (ide_drive_t *drive, int locate_eod)
-{
-	idetape_tape_t *tape = drive->driver_data;
-
-#if ONSTREAM_DEBUG
-	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: %s: writing tape header\n",
-			tape->name);
-#endif
-	if (!tape->onstream || tape->raw)
-		return;
-	tape->update_frame_cntr++;
-	__idetape_write_header(drive, 5, 5);
-	__idetape_write_header(drive, 0xbae, 5); /* 2990 */
-	if (locate_eod) {
-#if ONSTREAM_DEBUG
-		if (tape->debug_level >= 2)
-			printk(KERN_INFO "ide-tape: %s: locating back to eod "
-				"frame addr %d\n", tape->name,
-				tape->eod_frame_addr);
-#endif
-		idetape_position_tape(drive, tape->eod_frame_addr, 0, 0);
-	}
-}
-
 static ssize_t idetape_chrdev_write (struct file *file, const char *buf,
 				     size_t count, loff_t *ppos)
 {
@@ -4942,28 +3850,6 @@
 			"count %Zd\n", count);
 #endif /* IDETAPE_DEBUG_LOG */
 
-	if (tape->onstream) {
-		if (count != tape->tape_block_size) {
-			printk(KERN_ERR "ide-tape: %s: chrdev_write: use %d "
-				"bytes as block size (%Zd used)\n",
-				tape->name, tape->tape_block_size, count);
-			return -EINVAL;
-		}
-		/*
-		 * Check if we reach the end of the tape. Just assume the whole
-		 * pipeline is filled with write requests!
-		 */
-		if (tape->first_frame_position + tape->nr_stages >= tape->capacity - OS_EW)  {
-#if ONSTREAM_DEBUG
-			printk(KERN_INFO, "chrdev_write: Write truncated at "
-				"EOM early warning");
-#endif
-			if (tape->chrdev_direction == idetape_direction_write)
-				idetape_write_release(drive, minor);
-			return -ENOSPC;
-		}
-	}
-
 	/* Initialize write operation */
 	if (tape->chrdev_direction != idetape_direction_write) {
 		if (tape->chrdev_direction == idetape_direction_read)
@@ -4980,39 +3866,6 @@
 		tape->chrdev_direction = idetape_direction_write;
 		idetape_init_merge_stage(tape);
 
-		if (tape->onstream) {
-			position = idetape_read_position(drive);
-			if (position <= OS_DATA_STARTFRAME1) {
-				tape->logical_blk_num = 0;
-				tape->wrt_pass_cntr++;
-#if ONSTREAM_DEBUG
-				if (tape->debug_level >= 2)
-					printk(KERN_INFO "ide-tape: %s: logical block num 0, setting eod to %d\n", tape->name, OS_DATA_STARTFRAME1);
-				if (tape->debug_level >= 2)
-					printk(KERN_INFO "ide-tape: %s: allocating new write pass counter %d\n", tape->name, tape->wrt_pass_cntr);
-#endif
-				tape->filemark_cnt = 0;
-				tape->eod_frame_addr = OS_DATA_STARTFRAME1;
-				tape->first_mark_addr = tape->last_mark_addr = -1;
-				idetape_write_header(drive, 1);
-			}
-#if ONSTREAM_DEBUG
-			if (tape->debug_level >= 2)
-				printk(KERN_INFO "ide-tape: %s: positioning "
-					"tape to eod at %d\n",
-					tape->name, tape->eod_frame_addr);
-#endif
-			position = idetape_read_position(drive);
-			if (position != tape->eod_frame_addr)
-				idetape_position_tape(drive, tape->eod_frame_addr, 0, 0);
-#if ONSTREAM_DEBUG
-			if (tape->debug_level >= 2)
-				printk(KERN_INFO "ide-tape: %s: "
-					"first_frame_position %d\n",
-					tape->name, tape->first_frame_position);
-#endif
-		}
-
 		/*
 		 *	Issue a write 0 command to ensure that DSC handshake
 		 *	is switched from completion mode to buffer available
@@ -5029,11 +3882,6 @@
 				return retval;
 			}
 		}
-#if ONSTREAM_DEBUG
-		if (tape->debug_level >= 2)
-			printk("ide-tape: first_frame_position %d\n",
-				tape->first_frame_position);
-#endif
 	}
 	if (count == 0)
 		return (0);
@@ -5082,84 +3930,12 @@
 	int last_mark_addr;
 	idetape_pc_t pc;
 
-	if (!tape->onstream) {
-		/* Write a filemark */
-		idetape_create_write_filemark_cmd(drive, &pc, 1);
-		if (idetape_queue_pc_tail(drive, &pc)) {
-			printk(KERN_ERR "ide-tape: Couldn't write a filemark\n");
-			return -EIO;
-		}
-	} else if (!tape->raw) {
-		last_mark_addr = idetape_read_position(drive);
-		tape->merge_stage = __idetape_kmalloc_stage(tape, 1, 0);
-		if (tape->merge_stage != NULL) {
-			idetape_init_stage(drive, tape->merge_stage, OS_FRAME_TYPE_MARKER, tape->logical_blk_num);
-			idetape_pad_zeros(drive, tape->stage_size);
-			tape->logical_blk_num++;
-			__idetape_kfree_stage(tape->merge_stage);
-			tape->merge_stage = NULL;
-		}
-		if (tape->filemark_cnt)
-			idetape_update_last_marker(drive, tape->last_mark_addr, last_mark_addr);
-		tape->last_mark_addr = last_mark_addr;
-		if (tape->filemark_cnt++ == 0)
-			tape->first_mark_addr = last_mark_addr;
-	}
-	return 0;
-}
-
-static void idetape_write_eod (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-
-	if (!tape->onstream || tape->raw)
-		return;
-	tape->merge_stage = __idetape_kmalloc_stage(tape, 1, 0);
-	if (tape->merge_stage != NULL) {
-		tape->eod_frame_addr = idetape_read_position(drive);
-		idetape_init_stage(drive, tape->merge_stage, OS_FRAME_TYPE_EOD, tape->logical_blk_num);
-		idetape_pad_zeros(drive, tape->stage_size);
-		__idetape_kfree_stage(tape->merge_stage);
-		tape->merge_stage = NULL;
-	}
-	return;
-}
-
-int idetape_seek_logical_blk (ide_drive_t *drive, int logical_blk_num)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	int estimated_address = logical_blk_num + 20;
-	int retries = 0;
-	int speed_control;
-
-	speed_control = tape->speed_control;
-	tape->speed_control = 0;
-	if (logical_blk_num < 0)
-		logical_blk_num = 0;
-	if (idetape_get_logical_blk(drive, logical_blk_num, 10, 1))
-		goto ok;
-	while (++retries < 10) {
-		idetape_discard_read_pipeline(drive, 0);
-		idetape_position_tape(drive, estimated_address, 0, 0);
-		if (idetape_get_logical_blk(drive, logical_blk_num, 10, 1))
-			goto ok;
-		if (!idetape_get_logical_blk(drive, -1, 10, 1))
-			goto error;
-		if (tape->logical_blk_num < logical_blk_num)
-			estimated_address += logical_blk_num - tape->logical_blk_num;
-		else
-			break;
+	/* Write a filemark */
+	idetape_create_write_filemark_cmd(drive, &pc, 1);
+	if (idetape_queue_pc_tail(drive, &pc)) {
+		printk(KERN_ERR "ide-tape: Couldn't write a filemark\n");
+		return -EIO;
 	}
-error:
-	tape->speed_control = speed_control;
-	tape->restart_speed_control_req = 1;
-	printk(KERN_INFO "ide-tape: %s: couldn't seek to logical block %d "
-		"(at %d), %d retries\n", tape->name, logical_blk_num,
-		tape->logical_blk_num, retries);
-	return -EIO;
-ok:
-	tape->speed_control = speed_control;
-	tape->restart_speed_control_req = 1;
 	return 0;
 }
 
@@ -5266,8 +4042,6 @@
 			idetape_discard_read_pipeline(drive, 0);
 			if (idetape_rewind_tape(drive))
 				return -EIO;
-			if (tape->onstream && !tape->raw)
-				return idetape_position_tape(drive, OS_DATA_STARTFRAME1, 0, 0);
 			return 0;
 		case MTLOAD:
 			idetape_discard_read_pipeline(drive, 0);
@@ -5298,50 +4072,13 @@
 			idetape_create_load_unload_cmd(drive, &pc,IDETAPE_LU_RETENSION_MASK | IDETAPE_LU_LOAD_MASK);
 			return (idetape_queue_pc_tail(drive, &pc));
 		case MTEOM:
-			if (tape->onstream) {
-#if ONSTREAM_DEBUG
-				if (tape->debug_level >= 2)
-					printk(KERN_INFO "ide-tape: %s: positioning tape to eod at %d\n", tape->name, tape->eod_frame_addr);
-#endif
-				idetape_position_tape(drive, tape->eod_frame_addr, 0, 0);
-				if (!idetape_get_logical_blk(drive, -1, 10, 0))
-					return -EIO;
-				if (tape->first_stage->aux->frame_type != OS_FRAME_TYPE_EOD)
-					return -EIO;
-				return 0;
-			}
 			idetape_create_space_cmd(&pc, 0, IDETAPE_SPACE_TO_EOD);
 			return (idetape_queue_pc_tail(drive, &pc));
 		case MTERASE:
-			if (tape->onstream) {
-				tape->eod_frame_addr = OS_DATA_STARTFRAME1;
-				tape->logical_blk_num = 0;
-				tape->first_mark_addr = tape->last_mark_addr = -1;
-				idetape_position_tape(drive, tape->eod_frame_addr, 0, 0);
-				idetape_write_eod(drive);
-				idetape_flush_tape_buffers(drive);
-				idetape_write_header(drive, 0);
-				/*
-				 * write filler frames to the unused frames...
-				 * REMOVE WHEN going to LIN4 application type...
-				 */
-				idetape_write_filler(drive, OS_DATA_STARTFRAME1 - 10, 10);
-				idetape_write_filler(drive, OS_DATA_ENDFRAME1, 10);
-				idetape_flush_tape_buffers(drive);
-				(void) idetape_rewind_tape(drive);
-				return 0;
-			}
 			(void) idetape_rewind_tape(drive);
 			idetape_create_erase_cmd(&pc);
 			return (idetape_queue_pc_tail(drive, &pc));
 		case MTSETBLK:
-			if (tape->onstream) {
-				if (mt_count != tape->tape_block_size) {
-					printk(KERN_INFO "ide-tape: %s: MTSETBLK %d -- only %d bytes block size supported\n", tape->name, mt_count, tape->tape_block_size);
-					return -EINVAL;
-				}
-				return 0;
-			}
 			if (mt_count) {
 				if (mt_count < tape->tape_block_size || mt_count % tape->tape_block_size)
 					return -EIO;
@@ -5351,28 +4088,13 @@
 				set_bit(IDETAPE_DETECT_BS, &tape->flags);
 			return 0;
 		case MTSEEK:
-			if (!tape->onstream || tape->raw) {
-				idetape_discard_read_pipeline(drive, 0);
-				return idetape_position_tape(drive, mt_count * tape->user_bs_factor, tape->partition, 0);
-			}
-			return idetape_seek_logical_blk(drive, mt_count);
+			idetape_discard_read_pipeline(drive, 0);
+			return idetape_position_tape(drive, mt_count * tape->user_bs_factor, tape->partition, 0);
 		case MTSETPART:
 			idetape_discard_read_pipeline(drive, 0);
-			if (tape->onstream)
-				return -EIO;
 			return (idetape_position_tape(drive, 0, mt_count, 0));
 		case MTFSR:
 		case MTBSR:
-			if (tape->onstream) {
-				if (!idetape_get_logical_blk(drive, -1, 10, 0))
-					return -EIO;
-				if (mt_op == MTFSR)
-					return idetape_seek_logical_blk(drive, tape->logical_blk_num + mt_count);
-				else {
-					idetape_discard_read_pipeline(drive, 0);
-					return idetape_seek_logical_blk(drive, tape->logical_blk_num - mt_count);
-				}
-			}
 		case MTLOCK:
 			if (!idetape_create_prevent_cmd(drive, &pc, 1))
 				return 0;
@@ -5450,34 +4172,16 @@
 		case MTIOCGET:
 			memset(&mtget, 0, sizeof (struct mtget));
 			mtget.mt_type = MT_ISSCSI2;
-			if (!tape->onstream || tape->raw)
-				mtget.mt_blkno = position / tape->user_bs_factor - block_offset;
-			else {
-				if (!idetape_get_logical_blk(drive, -1, 10, 0))
-					mtget.mt_blkno = -1;
-				else
-					mtget.mt_blkno = tape->logical_blk_num;
-			}
+			mtget.mt_blkno = position / tape->user_bs_factor - block_offset;
 			mtget.mt_dsreg = ((tape->tape_block_size * tape->user_bs_factor) << MT_ST_BLKSIZE_SHIFT) & MT_ST_BLKSIZE_MASK;
-			if (tape->onstream) {
-				mtget.mt_gstat |= GMT_ONLINE(0xffffffff);
-				if (tape->first_stage && tape->first_stage->aux->frame_type == OS_FRAME_TYPE_EOD)
-					mtget.mt_gstat |= GMT_EOD(0xffffffff);
-				if (position <= OS_DATA_STARTFRAME1)
-					mtget.mt_gstat |= GMT_BOT(0xffffffff);
-			} else if (tape->drv_write_prot) {
+			if (tape->drv_write_prot) {
 				mtget.mt_gstat |= GMT_WR_PROT(0xffffffff);
 			}
 			if (copy_to_user((char *) arg,(char *) &mtget, sizeof(struct mtget)))
 				return -EFAULT;
 			return 0;
 		case MTIOCPOS:
-			if (tape->onstream && !tape->raw) {
-				if (!idetape_get_logical_blk(drive, -1, 10, 0))
-					return -EIO;
-				mtpos.mt_blkno = tape->logical_blk_num;
-			} else
-				mtpos.mt_blkno = position / tape->user_bs_factor - block_offset;
+			mtpos.mt_blkno = position / tape->user_bs_factor - block_offset;
 			if (copy_to_user((char *) arg,(char *) &mtpos, sizeof(struct mtpos)))
 				return -EFAULT;
 			return 0;
@@ -5488,106 +4192,6 @@
 	}
 }
 
-static int __idetape_analyze_headers (ide_drive_t *drive, int block)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage;
-	os_header_t *header;
-	os_aux_t *aux;
-
-	if (!tape->onstream || tape->raw) {
-		tape->header_ok = tape->linux_media = 1;
-		return 1;
-	}
-	tape->header_ok = tape->linux_media = 0;
-	tape->update_frame_cntr = 0;
-	tape->wrt_pass_cntr = 0;
-	tape->eod_frame_addr = OS_DATA_STARTFRAME1;
-	tape->first_mark_addr = tape->last_mark_addr = -1;
-	stage = __idetape_kmalloc_stage(tape, 0, 0);
-	if (stage == NULL)
-		return 0;
-#if ONSTREAM_DEBUG
-	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: %s: reading header\n", tape->name);
-#endif
-	idetape_position_tape(drive, block, 0, 0);
-	if (!idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, 1, stage->bh)) {
-		printk(KERN_INFO "ide-tape: %s: couldn't read header frame\n",
-			tape->name);
-		__idetape_kfree_stage(stage);
-		return 0;
-	}
-	header = (os_header_t *) stage->bh->b_data;
-	aux = stage->aux;
-	if (strncmp(header->ident_str, "ADR_SEQ", 7) != 0) {
-		printk(KERN_INFO "ide-tape: %s: invalid header identification string\n", tape->name);
-		__idetape_kfree_stage(stage);
-		return 0;
-	}
-	if (header->major_rev != 1 || (header->minor_rev > OS_ADR_MINREV))
-		printk(KERN_INFO "ide-tape: warning: revision %d.%d "
-			"detected (up to 1.%d supported)\n",
-			header->major_rev, header->minor_rev, OS_ADR_MINREV);
-	if (header->par_num != 1)
-		printk(KERN_INFO "ide-tape: warning: %d partitions defined, only one supported\n", header->par_num);
-	tape->wrt_pass_cntr = ntohs(header->partition.wrt_pass_cntr);
-	tape->eod_frame_addr = ntohl(header->partition.eod_frame_addr);
-	tape->filemark_cnt = ntohl(aux->filemark_cnt);
-	tape->first_mark_addr = ntohl(aux->next_mark_addr);
-	tape->last_mark_addr = ntohl(aux->last_mark_addr);
-	tape->update_frame_cntr = ntohl(aux->update_frame_cntr);
-	memcpy(tape->application_sig, aux->application_sig, 4);
-	tape->application_sig[4] = 0;
-	if (memcmp(tape->application_sig, "LIN", 3) == 0) {
-		tape->linux_media = 1;
-		tape->linux_media_version = tape->application_sig[3] - '0';
-		if (tape->linux_media_version != 3)
-			printk(KERN_INFO "ide-tape: %s: Linux media version "
-				"%d detected (current 3)\n",
-				 tape->name, tape->linux_media_version);
-	} else {
-		printk(KERN_INFO "ide-tape: %s: non Linux media detected "
-			"(%s)\n", tape->name, tape->application_sig);
-		tape->linux_media = 0;
-	}
-#if ONSTREAM_DEBUG
-	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: %s: detected write pass counter "
-			"%d, eod frame addr %d\n", tape->name,
-			tape->wrt_pass_cntr, tape->eod_frame_addr);
-#endif
-	__idetape_kfree_stage(stage);
-	return 1;
-}
-
-static int idetape_analyze_headers (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	int position, block;
-
-	if (!tape->onstream || tape->raw) {
-		tape->header_ok = tape->linux_media = 1;
-		return 1;
-	}
-	tape->header_ok = tape->linux_media = 0;
-	position = idetape_read_position(drive);
-	for (block = 5; block < 10; block++)
-		if (__idetape_analyze_headers(drive, block))
-			goto ok;
-	for (block = 0xbae; block < 0xbb3; block++) /* 2990 - 2994 */
-		if (__idetape_analyze_headers(drive, block))
-			goto ok;
-	printk(KERN_ERR "ide-tape: %s: failed to find valid ADRL header\n", tape->name);
-	return 0;
-ok:
-	if (position < OS_DATA_STARTFRAME1)
-		position = OS_DATA_STARTFRAME1;
-	idetape_position_tape(drive, position, 0, 0);
-	tape->header_ok = 1;
-	return 1;
-}
-
 static void idetape_get_blocksize_from_block_descriptor(ide_drive_t *drive);
 
 /*
@@ -5613,16 +4217,6 @@
 
 	if (test_and_set_bit(IDETAPE_BUSY, &tape->flags))
 		return -EBUSY;
-	if (tape->onstream) {
-		if (minor & 64) {
-			tape->tape_block_size = tape->stage_size = 32768 + 512;
-			tape->raw = 1;
-		} else {
-			tape->tape_block_size = tape->stage_size = 32768;
-			tape->raw = 0;
-		}
-                idetape_onstream_mode_sense_tape_parameter_page(drive, tape->debug_level);
-	}
 	retval = idetape_wait_ready(drive, 60 * HZ);
 	if (retval) {
 		clear_bit(IDETAPE_BUSY, &tape->flags);
@@ -5657,7 +4251,6 @@
 
 	/*
 	 * Lock the tape drive door so user can't eject.
-	 * Analyze headers for OnStream drives.
 	 */
 	if (tape->chrdev_direction == idetape_direction_none) {
 		if (idetape_create_prevent_cmd(drive, &pc, 1)) {
@@ -5666,9 +4259,7 @@
 					tape->door_locked = DOOR_LOCKED;
 			}
 		}
-		idetape_analyze_headers(drive);
 	}
-	tape->max_frames = tape->cur_frames = tape->req_buffer_fill = 0;
 	idetape_restart_speed_control(drive);
 	tape->restart_speed_control_req = 0;
 	return 0;
@@ -5686,9 +4277,7 @@
 		tape->merge_stage = NULL;
 	}
 	idetape_write_filemark(drive);
-	idetape_write_eod(drive);
 	idetape_flush_tape_buffers(drive);
-	idetape_write_header(drive, minor >= 128);
 	idetape_flush_tape_buffers(drive);
 }
 
@@ -5861,106 +4450,14 @@
 		printk(KERN_ERR "ide-tape: Packet size is not 12 bytes long\n");
 		if (gcw.packet_size == 1)
 			printk(KERN_ERR "ide-tape: Sorry, padding to 16 bytes is still not supported\n");
-	} else
+	} else if (strstr(drive->id->model, "OnStream DI-"))
+		printk("ide-tape: Use drive %s with ide-scsi emulation and osst.\n", drive->name);
+	else 
 		return 1;
 	return 0;
 }
 
 /*
- * Notify vendor ID to the OnStream tape drive
- */
-static void idetape_onstream_set_vendor (ide_drive_t *drive, char *vendor)
-{
-	idetape_pc_t pc;
-	idetape_mode_parameter_header_t *header;
-
-	idetape_create_mode_select_cmd(&pc, sizeof(*header) + 8);
-	pc.buffer[0] = 3 + 8;	/* Mode Data Length */
-	pc.buffer[1] = 0;	/* Medium Type - ignoring */
-	pc.buffer[2] = 0;	/* Reserved */
-	pc.buffer[3] = 0;	/* Block Descriptor Length */
-	pc.buffer[4 + 0] = 0x36 | (1 << 7);
-	pc.buffer[4 + 1] = 6;
-	pc.buffer[4 + 2] = vendor[0];
-	pc.buffer[4 + 3] = vendor[1];
-	pc.buffer[4 + 4] = vendor[2];
-	pc.buffer[4 + 5] = vendor[3];
-	pc.buffer[4 + 6] = 0;
-	pc.buffer[4 + 7] = 0;
-	if (idetape_queue_pc_tail(drive, &pc))
-		printk(KERN_ERR "ide-tape: Couldn't set vendor name to %s\n", vendor);
-
-}
-
-/*
- * Various unused OnStream commands
- */
-#if ONSTREAM_DEBUG
-static void idetape_onstream_set_retries (ide_drive_t *drive, int retries)
-{
-	idetape_pc_t pc;
-
-	idetape_create_mode_select_cmd(&pc, sizeof(idetape_mode_parameter_header_t) + 4);
-	pc.buffer[0] = 3 + 4;
-	pc.buffer[1] = 0;	/* Medium Type - ignoring */
-	pc.buffer[2] = 0;	/* Reserved */
-	pc.buffer[3] = 0;	/* Block Descriptor Length */
-	pc.buffer[4 + 0] = 0x2f | (1 << 7);
-	pc.buffer[4 + 1] = 2;
-	pc.buffer[4 + 2] = 4;
-	pc.buffer[4 + 3] = retries;
-	if (idetape_queue_pc_tail(drive, &pc))
-		printk(KERN_ERR "ide-tape: Couldn't set retries to %d\n", retries);
-}
-#endif
-
-/*
- * Configure 32.5KB block size.
- */
-static void idetape_onstream_configure_block_size (ide_drive_t *drive)
-{
-	idetape_pc_t pc;
-	idetape_mode_parameter_header_t *header;
-	idetape_block_size_page_t *bs;
-
-	/*
-	 * Get the current block size from the block size mode page
-	 */
-	idetape_create_mode_sense_cmd(&pc, IDETAPE_BLOCK_SIZE_PAGE);
-	if (idetape_queue_pc_tail(drive, &pc))
-		printk(KERN_ERR "ide-tape: can't get tape block size mode page\n");
-	header = (idetape_mode_parameter_header_t *) pc.buffer;
-	bs = (idetape_block_size_page_t *) (pc.buffer + sizeof(idetape_mode_parameter_header_t) + header->bdl);
-
-#if IDETAPE_DEBUG_INFO
-	printk(KERN_INFO "ide-tape: 32KB play back: %s\n", bs->play32 ? "Yes" : "No");
-	printk(KERN_INFO "ide-tape: 32.5KB play back: %s\n", bs->play32_5 ? "Yes" : "No");
-	printk(KERN_INFO "ide-tape: 32KB record: %s\n", bs->record32 ? "Yes" : "No");
-	printk(KERN_INFO "ide-tape: 32.5KB record: %s\n", bs->record32_5 ? "Yes" : "No");
-#endif /* IDETAPE_DEBUG_INFO */
-
-	/*
-	 * Configure default auto columns mode, 32.5KB block size
-	 */ 
-	bs->one = 1;
-	bs->play32 = 0;
-	bs->play32_5 = 1;
-	bs->record32 = 0;
-	bs->record32_5 = 1;
-	idetape_create_mode_select_cmd(&pc, sizeof(*header) + sizeof(*bs));
-	if (idetape_queue_pc_tail(drive, &pc))
-		printk(KERN_ERR "ide-tape: Couldn't set tape block size mode page\n");
-
-#if ONSTREAM_DEBUG
-	/*
-	 * In debug mode, we want to see as many errors as possible
-	 * to test the error recovery mechanism.
-	 */
-	idetape_onstream_set_retries(drive, 0);
-#endif
-}
-
-/*
  * Use INQUIRY to get the firmware revision
  */
 static void idetape_get_inquiry_results (ide_drive_t *drive)
@@ -5985,63 +4482,10 @@
 	r = tape->firmware_revision;
 	if (*(r + 1) == '.')
 		tape->firmware_revision_num = (*r - '0') * 100 + (*(r + 2) - '0') * 10 + *(r + 3) - '0';
-	else if (tape->onstream)
-		tape->firmware_revision_num = (*r - '0') * 100 + (*(r + 1) - '0') * 10 + *(r + 2) - '0';
 	printk(KERN_INFO "ide-tape: %s <-> %s: %s %s rev %s\n", drive->name, tape->name, tape->vendor_id, tape->product_id, tape->firmware_revision);
 }
 
 /*
- * Configure the OnStream ATAPI tape drive for default operation
- */
-static void idetape_configure_onstream (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-
-	if (tape->firmware_revision_num < 105) {
-		printk(KERN_INFO "ide-tape: %s: Old OnStream firmware revision detected (%s)\n", tape->name, tape->firmware_revision);
-		printk(KERN_INFO "ide-tape: %s: An upgrade to version 1.05 or above is recommended\n", tape->name);
-	}
-
-	/*
-	 * Configure 32.5KB (data+aux) block size.
-	 */
-	idetape_onstream_configure_block_size(drive);
-
-	/*
-	 * Set vendor name to 'LIN3' for "Linux support version 3".
-	 */
-	idetape_onstream_set_vendor(drive, "LIN3");
-}
-
-/*
- *	idetape_get_mode_sense_parameters asks the tape about its various
- *	parameters. This may work for other drives to???
- */
-static void idetape_onstream_mode_sense_tape_parameter_page(ide_drive_t *drive, int debug)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	idetape_pc_t pc;
-	idetape_mode_parameter_header_t *header;
-	onstream_tape_paramtr_page_t *prm;
-	
-	idetape_create_mode_sense_cmd(&pc, IDETAPE_PARAMTR_PAGE);
-	if (idetape_queue_pc_tail(drive, &pc)) {
-		printk(KERN_ERR "ide-tape: Can't get tape parameters page - probably no tape inserted in onstream drive\n");
-		return;
-	}
-	header = (idetape_mode_parameter_header_t *) pc.buffer;
-	prm = (onstream_tape_paramtr_page_t *) (pc.buffer + sizeof(idetape_mode_parameter_header_t) + header->bdl);
-
-        tape->capacity = ntohs(prm->segtrk) * ntohs(prm->trks);
-        if (debug) {
-	    printk(KERN_INFO "ide-tape: %s <-> %s: Tape length %dMB (%d frames/track, %d tracks = %d blocks, density: %dKbpi)\n",
-               drive->name, tape->name, tape->capacity/32, ntohs(prm->segtrk), ntohs(prm->trks), tape->capacity, prm->density);
-        }
-
-        return;
-}
-
-/*
  *	idetape_get_mode_sense_results asks the tape about its various
  *	parameters. In particular, we will adjust our data transfer buffer
  *	size to the recommended value as returned by the tape.
@@ -6084,8 +4528,6 @@
 		tape->tape_block_size = 512;
 	else if (capabilities->blk1024)
 		tape->tape_block_size = 1024;
-	else if (tape->onstream && capabilities->blk32768)
-		tape->tape_block_size = 32768;
 
 #if IDETAPE_DEBUG_INFO
 	printk(KERN_INFO "ide-tape: Dumping the results of the MODE SENSE packet command\n");
@@ -6169,18 +4611,6 @@
 	ide_add_setting(drive,	"pipeline_head_speed_u",SETTING_READ,	-1,	-1,	TYPE_INT,	0,			0xffff,			1,				1,				&tape->uncontrolled_pipeline_head_speed,	NULL);
 	ide_add_setting(drive,	"avg_speed",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->avg_speed,		NULL);
 	ide_add_setting(drive,	"debug_level",SETTING_RW,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->debug_level,		NULL);
-	if (tape->onstream) {
-		ide_add_setting(drive,	"cur_frames",	SETTING_READ,	-1,	-1,		TYPE_SHORT,	0,			0xffff,			1,				1,				&tape->cur_frames,		NULL);
-		ide_add_setting(drive,	"max_frames",	SETTING_READ,	-1,	-1,		TYPE_SHORT,	0,			0xffff,			1,				1,				&tape->max_frames,		NULL);
-		ide_add_setting(drive,	"insert_speed",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->insert_speed,		NULL);
-		ide_add_setting(drive,	"speed_control",SETTING_RW,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->speed_control,		NULL);
-		ide_add_setting(drive,	"tape_still_time",SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->tape_still_time,		NULL);
-		ide_add_setting(drive,	"max_insert_speed",SETTING_RW,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->max_insert_speed,	NULL);
-		ide_add_setting(drive,	"insert_size",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->insert_size,		NULL);
-		ide_add_setting(drive,	"capacity",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->capacity,		NULL);
-		ide_add_setting(drive,	"first_frame",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->first_frame_position,		NULL);
-		ide_add_setting(drive,	"logical_blk",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->logical_blk_num,		NULL);
-	}
 }
 
 /*
@@ -6208,11 +4638,9 @@
 	drive->driver_data = tape;
 	/* An ATAPI device ignores DRDY */
 	drive->ready_stat = 0;
-	if (strstr(drive->id->model, "OnStream DI-"))
-		tape->onstream = 1;
 	drive->dsc_overlap = 1;
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	if (!tape->onstream && HWIF(drive)->pci_dev != NULL) {
+	if (HWIF(drive)->pci_dev != NULL) {
 		/*
 		 * These two ide-pci host adapters appear to need DSC overlap disabled.
 		 * This probably needs further analysis.
@@ -6245,10 +4673,6 @@
 	idetape_get_inquiry_results(drive);
 	idetape_get_mode_sense_results(drive);
 	idetape_get_blocksize_from_block_descriptor(drive);
-	if (tape->onstream) {
-		idetape_onstream_mode_sense_tape_parameter_page(drive, 1);
-		idetape_configure_onstream(drive);
-	}
 	tape->user_bs_factor = 1;
 	tape->stage_size = tape->capabilities.ctl * tape->tape_block_size;
 	while (tape->stage_size > 0xffff) {
@@ -6257,8 +4681,6 @@
 		tape->stage_size = tape->capabilities.ctl * tape->tape_block_size;
 	}
 	stage_size = tape->stage_size;
-	if (tape->onstream)
-		stage_size = 32768 + 512;
 	tape->pages_per_stage = stage_size / PAGE_SIZE;
 	if (stage_size % PAGE_SIZE) {
 		tape->pages_per_stage++;
@@ -6442,12 +4864,8 @@
 		goto failed;
 	}
 	if (drive->scsi) {
-		if (strstr(drive->id->model, "OnStream DI-")) {
-			printk("ide-tape: ide-scsi emulation is not supported for %s.\n", drive->id->model);
-		} else {
-			printk("ide-tape: passing drive %s to ide-scsi emulation.\n", drive->name);
-			goto failed;
-		}
+		printk("ide-tape: passing drive %s to ide-scsi emulation.\n", drive->name);
+		goto failed;
 	}
 	tape = (idetape_tape_t *) kmalloc (sizeof (idetape_tape_t), GFP_KERNEL);
 	if (tape == NULL) {
