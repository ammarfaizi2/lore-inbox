Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289335AbSAOA7m>; Mon, 14 Jan 2002 19:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289338AbSAOA7g>; Mon, 14 Jan 2002 19:59:36 -0500
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:43535 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S289335AbSAOA65>;
	Mon, 14 Jan 2002 19:58:57 -0500
Date: Mon, 14 Jan 2002 19:47:11 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: [PATCH] 2.5.2-pre11: drivers/ide/ide-tape.c 
Message-ID: <Pine.LNX.4.33.0201141941320.909-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
    I have attached a patch for drivers/ide/ide-tape.c against 
2.5.2-pre10/11 . It includes the following:
dev_t --> kdev_t changes
buffer_head --> bio updates.

Please review. Thanks.

Regards,
Frank

--- drivers/ide/ide-tape.c.old	Tue Jan  8 21:15:54 2002
+++ drivers/ide/ide-tape.c	Tue Jan  8 21:15:45 2002
@@ -721,7 +721,7 @@
 	int request_transfer;			/* Bytes to transfer */
 	int actually_transferred;		/* Bytes actually transferred */
 	int buffer_size;			/* Size of our data buffer */
-	struct buffer_head *bh;
+	struct bio *bio;
 	char *b_data;
 	int b_count;
 	byte *buffer;				/* Data buffer */
@@ -805,7 +805,7 @@
  */
 typedef struct idetape_stage_s {
 	struct request rq;			/* The corresponding request */
-	struct buffer_head *bh;			/* The data buffers */
+	struct bio *bio;			/* The data buffers */
 	struct idetape_stage_s *next;		/* Pointer to the next stage */
 	os_aux_t *aux;				/* OnStream aux ptr */
 } idetape_stage_t;
@@ -929,7 +929,7 @@
 	int stage_size;				/* Data buffer size (chosen based on the tape's recommendation */
 	idetape_stage_t *merge_stage;
 	int merge_stage_size;
-	struct buffer_head *bh;
+	struct bio *bio;
 	char *b_data;
 	int b_count;
 	
@@ -1013,7 +1013,7 @@
 	 * Measures number of frames:
 	 *
 	 * 1. written/read to/from the driver pipeline (pipeline_head).
-	 * 2. written/read to/from the tape buffers (buffer_head).
+	 * 2. written/read to/from the tape buffers (bio).
 	 * 3. written/read by the tape to/from the media (tape_head).
 	 */
 	int pipeline_head;
@@ -1493,52 +1493,52 @@
 
 static void idetape_input_buffers (ide_drive_t *drive, idetape_pc_t *pc, unsigned int bcount)
 {
-	struct buffer_head *bh = pc->bh;
+	struct bio *bio = pc->bio;
 	int count;
 
 	while (bcount) {
 #if IDETAPE_DEBUG_BUGS
-		if (bh == NULL) {
-			printk (KERN_ERR "ide-tape: bh == NULL in idetape_input_buffers\n");
+		if (bio == NULL) {
+			printk (KERN_ERR "ide-tape: bio == NULL in idetape_input_buffers\n");
 			idetape_discard_data (drive, bcount);
 			return;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
-		count = IDE_MIN (bh->b_size - atomic_read(&bh->b_count), bcount);
-		atapi_input_bytes (drive, bh->b_data + atomic_read(&bh->b_count), count);
+		count = IDE_MIN (bio->bi_size - pc->b_count, bcount);
+		atapi_input_bytes (drive, bio_data(bio) + pc->b_count, count);
 		bcount -= count;
-		atomic_add(count, &bh->b_count);
-		if (atomic_read(&bh->b_count) == bh->b_size) {
-			bh = bh->b_reqnext;
-			if (bh)
-				atomic_set(&bh->b_count, 0);
+		pc->b_count += bio->bi_size;
+		if (pc->b_count == bio->bi_size) {
+			bio = bio->bi_next;
+			if (bio)
+				pc->b_count = 0;
 		}
 	}
-	pc->bh = bh;
+	pc->bio = bio;
 }
 
 static void idetape_output_buffers (ide_drive_t *drive, idetape_pc_t *pc, unsigned int bcount)
 {
-	struct buffer_head *bh = pc->bh;
+	struct bio *bio = pc->bio;
 	int count;
 
 	while (bcount) {
 #if IDETAPE_DEBUG_BUGS
-		if (bh == NULL) {
-			printk (KERN_ERR "ide-tape: bh == NULL in idetape_output_buffers\n");
+		if (bio == NULL) {
+			printk (KERN_ERR "ide-tape: bio == NULL in idetape_output_buffers\n");
 			return;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = IDE_MIN (pc->b_count, bcount);
-		atapi_output_bytes (drive, pc->b_data, count);
+		atapi_output_bytes (drive, bio_data(bio), count);
 		bcount -= count;
 		pc->b_data += count;
 		pc->b_count -= count;
 		if (!pc->b_count) {
-			pc->bh = bh = bh->b_reqnext;
-			if (bh) {
-				pc->b_data = bh->b_data;
-				pc->b_count = atomic_read(&bh->b_count);
+			pc->bio = bio = bio->bi_next;
+			if (bio) {
+				pc->b_data = bio_data(bio);
+				pc->b_count = bio->bi_size;
 			}
 		}
 	}
@@ -1547,25 +1547,25 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 static void idetape_update_buffers (idetape_pc_t *pc)
 {
-	struct buffer_head *bh = pc->bh;
+	struct bio *bio = pc->bio;
 	int count, bcount = pc->actually_transferred;
 
 	if (test_bit (PC_WRITING, &pc->flags))
 		return;
 	while (bcount) {
 #if IDETAPE_DEBUG_BUGS
-		if (bh == NULL) {
-			printk (KERN_ERR "ide-tape: bh == NULL in idetape_update_buffers\n");
+		if (bio == NULL) {
+			printk (KERN_ERR "ide-tape: bio == NULL in idetape_update_buffers\n");
 			return;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
-		count = IDE_MIN (bh->b_size, bcount);
-		atomic_set(&bh->b_count, count);
-		if (atomic_read(&bh->b_count) == bh->b_size)
-			bh = bh->b_reqnext;
+		count = IDE_MIN (bio->bi_size, bcount);
+		pc->b_count = count;
+		if (pc->b_count == bio->bi_size)
+			bio = bio->bi_next;
 		bcount -= count;
 	}
-	pc->bh = bh;
+	pc->bio = bio;
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
@@ -1625,7 +1625,7 @@
 	pc->request_transfer = 0;
 	pc->buffer = pc->pc_buffer;
 	pc->buffer_size = IDETAPE_PC_BUFFER_SIZE;
-	pc->bh = NULL;
+	pc->bio = NULL;
 	pc->b_data = NULL;
 }
 
@@ -1706,10 +1706,10 @@
 		printk(KERN_INFO "ide-tape: %s: idetape_abort_pipeline called\n", tape->name);
 #endif
 	while (stage) {
-		if (stage->rq.cmd == IDETAPE_WRITE_RQ)
-			stage->rq.cmd = IDETAPE_ABORTED_WRITE_RQ;
-		else if (stage->rq.cmd == IDETAPE_READ_RQ)
-			stage->rq.cmd = IDETAPE_ABORTED_READ_RQ;
+		if (stage->rq.flags == IDETAPE_WRITE_RQ)
+			stage->rq.flags = IDETAPE_ABORTED_WRITE_RQ;
+		else if (stage->rq.flags == IDETAPE_READ_RQ)
+			stage->rq.flags = IDETAPE_ABORTED_READ_RQ;
 		stage = stage->next;
 	}
 }
@@ -1735,7 +1735,7 @@
 #endif /* IDETAPE_DEBUG_BUGS */	
 
 	rq->buffer = NULL;
-	rq->bh = stage->bh;
+	rq->bio = stage->bio;
 	tape->active_data_request = rq;
 	tape->active_stage = stage;
 	tape->next_stage = stage->next;
@@ -1769,21 +1769,21 @@
  */
 static void __idetape_kfree_stage (idetape_stage_t *stage)
 {
-	struct buffer_head *prev_bh, *bh = stage->bh;
+	struct bio *prev_bio, *bio = stage->bio;
 	int size;
 
-	while (bh != NULL) {
-		if (bh->b_data != NULL) {
-			size = (int) bh->b_size;
+	while (bio != NULL) {
+		if (bio_data(bio) != NULL) {
+			size = (int) bio->bi_size;
 			while (size > 0) {
-				free_page ((unsigned long) bh->b_data);
+				free_page ((unsigned long) bio_data(bio));
 				size -= PAGE_SIZE;
-				bh->b_data += PAGE_SIZE;
+				bio->bi_size += PAGE_SIZE;
 			}
 		}
-		prev_bh = bh;
-		bh = bh->b_reqnext;
-		kfree (prev_bh);
+		prev_bio = bio;
+		bio = bio->bi_next;
+		kfree (prev_bio);
 	}
 	kfree (stage);
 }
@@ -1868,13 +1868,13 @@
 		tape->active_stage = NULL;
 		tape->active_data_request = NULL;
 		tape->nr_pending_stages--;
-		if (rq->cmd == IDETAPE_WRITE_RQ) {
+		if (rq->flags == IDETAPE_WRITE_RQ) {
 #if ONSTREAM_DEBUG
 			if (tape->debug_level >= 2) {
 				if (tape->onstream) {
 					stage = tape->first_stage;
 					aux = stage->aux;
-					p = stage->bh->b_data;
+					p = bio_data(stage->bio);
 					if (ntohl(aux->logical_blk_num) < 11300 && ntohl(aux->logical_blk_num) > 11100)
 						printk(KERN_INFO "ide-tape: finished writing logical blk %u (data %x %x %x %x)\n", ntohl(aux->logical_blk_num), *p++, *p++, *p++, *p++);
 				}
@@ -1908,7 +1908,7 @@
 						complete(tape->waiting);
 				}
 			}
-		} else if (rq->cmd == IDETAPE_READ_RQ) {
+		} else if (rq->flags == IDETAPE_READ_RQ) {
 			if (error == IDETAPE_ERROR_EOD) {
 				set_bit (IDETAPE_PIPELINE_ERROR, &tape->flags);
 				idetape_abort_pipeline(drive);
@@ -1984,7 +1984,7 @@
 {
 	ide_init_drive_cmd (rq);
 	rq->buffer = (char *) pc;
-	rq->cmd = IDETAPE_PC_RQ1;
+	rq->flags = IDETAPE_PC_RQ1;
 	(void) ide_do_drive_cmd (drive, rq, ide_preempt);
 }
 
@@ -2164,12 +2164,12 @@
 		}
 	}
 	if (test_bit (PC_WRITING, &pc->flags)) {
-		if (pc->bh != NULL)
+		if (pc->bio != NULL)
 			idetape_output_buffers (drive, pc, bcount.all);
 		else
 			atapi_output_bytes (drive,pc->current_position,bcount.all);	/* Write the current buffer */
 	} else {
-		if (pc->bh != NULL)
+		if (pc->bio != NULL)
 			idetape_input_buffers (drive, pc, bcount.all);
 		else
 			atapi_input_bytes (drive,pc->current_position,bcount.all);	/* Read the current buffer */
@@ -2523,21 +2523,22 @@
 	return ide_stopped;
 }
 
-static void idetape_create_read_cmd (idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct buffer_head *bh)
+static void idetape_create_read_cmd (idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct bio *bio)
 {
-	struct buffer_head *p = bh;
+	struct bio *p = bio;
+	struct bio_vec *bv = bio_iovec(p);
 	idetape_init_pc (pc);
 	pc->c[0] = IDETAPE_READ_CMD;
 	put_unaligned (htonl (length), (unsigned int *) &pc->c[1]);
 	pc->c[1] = 1;
 	pc->callback = &idetape_rw_callback;
-	pc->bh = bh;
-	atomic_set(&bh->b_count, 0);
+	pc->bio = bio;
+	bv->bv_len = 0;
 	pc->buffer = NULL;
 	if (tape->onstream) {
 		while (p) {
-			atomic_set(&p->b_count, 0);
-			p = p->b_reqnext;
+			bv->bv_len = 0;
+			p = p->bi_next;
 		}
 	}
 	if (!tape->onstream) {
@@ -2553,30 +2554,31 @@
 	}
 }
 
-static void idetape_create_read_buffer_cmd(idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct buffer_head *bh)
+static void idetape_create_read_buffer_cmd(idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct bio *bio)
 {
 	int size = 32768;
 
-	struct buffer_head *p = bh;
+	struct bio *p = bio;
 	idetape_init_pc (pc);
 	pc->c[0] = IDETAPE_READ_BUFFER_CMD;
 	pc->c[1] = IDETAPE_RETRIEVE_FAULTY_BLOCK;
 	pc->c[7] = size >> 8;
 	pc->c[8] = size & 0xff;
 	pc->callback = &idetape_pc_callback;
-	pc->bh = bh;
-	atomic_set(&bh->b_count, 0);
+	pc->bio = bio;
+	atomic_set(&bio->bi_cnt, 0);
 	pc->buffer = NULL;
 	while (p) {
-		atomic_set(&p->b_count, 0);
-		p = p->b_reqnext;
+		p->bi_size = 0;
+		p = p->bi_next;
 	}
 	pc->request_transfer = pc->buffer_size = size;
 }
 
-static void idetape_create_write_cmd (idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct buffer_head *bh)
+static void idetape_create_write_cmd (idetape_tape_t *tape, idetape_pc_t *pc, unsigned int length, struct bio *bio)
 {
-	struct buffer_head *p = bh;
+	struct bio *p = bio;
+	struct bio_vec *bv= bio_iovec(p);
 	idetape_init_pc (pc);
 	pc->c[0] = IDETAPE_WRITE_CMD;
 	put_unaligned (htonl (length), (unsigned int *) &pc->c[1]);
@@ -2585,13 +2587,13 @@
 	set_bit (PC_WRITING, &pc->flags);
 	if (tape->onstream) {
 		while (p) {
-			atomic_set(&p->b_count, p->b_size);
-			p = p->b_reqnext;
+			bv->bv_len = p->bi_size;
+			p = p->bi_next;
 		}
 	}
-	pc->bh = bh;
-	pc->b_data = bh->b_data;
-	pc->b_count = atomic_read(&bh->b_count);
+	pc->bio = bio;
+	pc->b_data = bio_data(bio);
+	pc->b_count = bio->bi_size;
 	pc->buffer = NULL;
 	if (!tape->onstream) {
 		pc->request_transfer = pc->buffer_size = length * tape->tape_block_size;
@@ -2618,16 +2620,16 @@
 
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 5)
-		printk (KERN_INFO "ide-tape: rq_status: %d, rq_dev: %u, cmd: %d, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
+/*		printk (KERN_INFO "ide-tape: rq_status: %d, rq_dev: %u, cmd: %ld, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->flags,rq->errors); */
 	if (tape->debug_level >= 2)
-		printk (KERN_INFO "ide-tape: sector: %ld, nr_sectors: %ld, current_nr_sectors: %ld\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
+		printk (KERN_INFO "ide-tape: sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
 #endif /* IDETAPE_DEBUG_LOG */
 
-	if (!IDETAPE_RQ_CMD (rq->cmd)) {
+	if (!IDETAPE_RQ_CMD (rq->flags)) {
 		/*
 		 *	We do not support buffer cache originated requests.
 		 */
-		printk (KERN_NOTICE "ide-tape: %s: Unsupported command in request queue (%d)\n", drive->name, rq->cmd);
+		printk (KERN_NOTICE "ide-tape: %s: Unsupported command in request queue (%ld)\n", drive->name, rq->flags);
 		ide_end_request (0, HWGROUP (drive));			/* Let the common code handle it */
 		return ide_stopped;
 	}
@@ -2661,7 +2663,7 @@
 	 */
 	if (tape->onstream)
 		status.b.dsc = 1;
-	if (!drive->dsc_overlap && rq->cmd != IDETAPE_PC_RQ2)
+	if (!drive->dsc_overlap && rq->flags != IDETAPE_PC_RQ2)
 		set_bit (IDETAPE_IGNORE_DSC, &tape->flags);
 
 	/*
@@ -2674,7 +2676,7 @@
 	 */
 	if (tape->tape_still_time > 100 && tape->tape_still_time < 200)
 		tape->measure_insert_time = 1;
-	if (tape->req_buffer_fill && (rq->cmd == IDETAPE_WRITE_RQ || rq->cmd == IDETAPE_READ_RQ)) {
+	if (tape->req_buffer_fill && (rq->flags == IDETAPE_WRITE_RQ || rq->flags == IDETAPE_READ_RQ)) {
 		tape->req_buffer_fill = 0;
 		tape->writes_since_buffer_fill = 0;
 		tape->reads_since_buffer_fill = 0;
@@ -2688,19 +2690,19 @@
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	calculate_speeds(drive);
 	if (tape->onstream && tape->max_frames &&
-	    ((rq->cmd == IDETAPE_WRITE_RQ &&
+	    ((rq->flags == IDETAPE_WRITE_RQ &&
               ( tape->cur_frames == tape->max_frames ||
                 ( tape->speed_control && tape->cur_frames > 5 &&
                        (tape->insert_speed > tape->max_insert_speed ||
                         (0 /* tape->cur_frames > 30 && tape->tape_still_time > 200 */) ) ) ) ) ||
-	     (rq->cmd == IDETAPE_READ_RQ &&
+	     (rq->flags == IDETAPE_READ_RQ &&
 	      ( tape->cur_frames == 0 ||
 		( tape->speed_control && (tape->cur_frames < tape->max_frames - 5) &&
 			tape->insert_speed > tape->max_insert_speed ) ) && rq->nr_sectors) ) ) {
 #if IDETAPE_DEBUG_LOG
 		if (tape->debug_level >= 4)
-			printk(KERN_INFO "ide-tape: postponing request, cmd %d, cur %d, max %d\n",
-				rq->cmd, tape->cur_frames, tape->max_frames);
+			printk(KERN_INFO "ide-tape: postponing request, cmd %ld, cur %d, max %d\n",
+				rq->flags, tape->cur_frames, tape->max_frames);
 #endif
 		if (tape->postpone_cnt++ < 500) {
 			status.b.dsc = 0;
@@ -2718,7 +2720,7 @@
 			tape->dsc_timeout = jiffies + IDETAPE_DSC_RW_TIMEOUT;
 		} else if ((signed long) (jiffies - tape->dsc_timeout) > 0) {
 			printk (KERN_ERR "ide-tape: %s: DSC timeout\n", tape->name);
-			if (rq->cmd == IDETAPE_PC_RQ2) {
+			if (rq->flags == IDETAPE_PC_RQ2) {
 				idetape_media_access_finished (drive);
 				return ide_stopped;
 			} else {
@@ -2729,7 +2731,7 @@
 		idetape_postpone_request (drive);
 		return ide_stopped;
 	}
-	switch (rq->cmd) {
+	switch (rq->flags) {
 		case IDETAPE_READ_RQ:
 			tape->buffer_head++;
 #if USE_IOTRACE
@@ -2744,7 +2746,7 @@
 					tape->req_buffer_fill = 1;
 			}
 			pc = idetape_next_pc_storage (drive);
-			idetape_create_read_cmd (tape, pc, rq->current_nr_sectors, rq->bh);
+			idetape_create_read_cmd (tape, pc, rq->current_nr_sectors, rq->bio);
 			break;
 		case IDETAPE_WRITE_RQ:
 			tape->buffer_head++;
@@ -2761,15 +2763,15 @@
 				calculate_speeds(drive);
 			}
 			pc = idetape_next_pc_storage (drive);
-			idetape_create_write_cmd (tape, pc, rq->current_nr_sectors, rq->bh);
+			idetape_create_write_cmd (tape, pc, rq->current_nr_sectors, rq->bio);
 			break;
 		case IDETAPE_READ_BUFFER_RQ:
 			tape->postpone_cnt = 0;
 			pc = idetape_next_pc_storage (drive);
-			idetape_create_read_buffer_cmd (tape, pc, rq->current_nr_sectors, rq->bh);
+			idetape_create_read_buffer_cmd (tape, pc, rq->current_nr_sectors, rq->bio);
 			break;
 		case IDETAPE_ABORTED_WRITE_RQ:
-			rq->cmd = IDETAPE_WRITE_RQ;
+			rq->flags = IDETAPE_WRITE_RQ;
 			idetape_end_request (IDETAPE_ERROR_EOD, HWGROUP(drive));
 			return ide_stopped;
 		case IDETAPE_ABORTED_READ_RQ:
@@ -2777,12 +2779,12 @@
 			if (tape->debug_level >= 2)
 				printk(KERN_INFO "ide-tape: %s: detected aborted read rq\n", tape->name);
 #endif
-			rq->cmd = IDETAPE_READ_RQ;
+			rq->flags = IDETAPE_READ_RQ;
 			idetape_end_request (IDETAPE_ERROR_EOD, HWGROUP(drive));
 			return ide_stopped;
 		case IDETAPE_PC_RQ1:
 			pc = (idetape_pc_t *) rq->buffer;
-			rq->cmd = IDETAPE_PC_RQ2;
+			rq->flags = IDETAPE_PC_RQ2;
 			break;
 		case IDETAPE_PC_RQ2:
 			idetape_media_access_finished (drive);
@@ -2822,61 +2824,65 @@
 static idetape_stage_t *__idetape_kmalloc_stage (idetape_tape_t *tape, int full, int clear)
 {
 	idetape_stage_t *stage;
-	struct buffer_head *prev_bh, *bh;
+	struct bio *prev_bio, *bio;
 	int pages = tape->pages_per_stage;
-	char *b_data;
+	char *b_data = NULL;
+	struct bio_vec *bv; 
 
 	if ((stage = (idetape_stage_t *) kmalloc (sizeof (idetape_stage_t),GFP_KERNEL)) == NULL)
 		return NULL;
 	stage->next = NULL;
 
-	bh = stage->bh = (struct buffer_head *) kmalloc (sizeof (struct buffer_head), GFP_KERNEL);
-	if (bh == NULL)
+	bio = stage->bio = bio_alloc(GFP_KERNEL,1);
+	bv = bio_iovec(bio);	
+	bv->bv_len = 0;
+	if (bio == NULL)
 		goto abort;
-	bh->b_reqnext = NULL;
-	if ((bh->b_data = (char *) __get_free_page (GFP_KERNEL)) == NULL)
+	bio->bi_next = NULL;
+	if ((bio->bi_io_vec[0].bv_page = alloc_page(GFP_KERNEL)) == NULL)
 		goto abort;
 	if (clear)
-		memset(bh->b_data, 0, PAGE_SIZE);
-	bh->b_size = PAGE_SIZE;
-	atomic_set(&bh->b_count, full ? bh->b_size : 0);
-	set_bit (BH_Lock, &bh->b_state);
+		memset(bio_data(bio), 0, PAGE_SIZE);
+	bio->bi_size = PAGE_SIZE;
+	if(bv->bv_len == full) bv->bv_len = bio->bi_size;
+	set_bit (BH_Lock, &bio->bi_flags);
 
 	while (--pages) {
-		if ((b_data = (char *) __get_free_page (GFP_KERNEL)) == NULL)
+		if ((bio->bi_io_vec[pages].bv_page = alloc_page(GFP_KERNEL)) == NULL)
 			goto abort;
 		if (clear)
-			memset(b_data, 0, PAGE_SIZE);
-		if (bh->b_data == b_data + PAGE_SIZE) {
-			bh->b_size += PAGE_SIZE;
-			bh->b_data -= PAGE_SIZE;
+			memset(bio_data(bio), 0, PAGE_SIZE);
+		if (bio->bi_size == bv->bv_len + PAGE_SIZE) {
+			bio->bi_size += PAGE_SIZE;
+			bv->bv_len += PAGE_SIZE;
+			bv->bv_offset -= PAGE_SIZE;
 			if (full)
-				atomic_add(PAGE_SIZE, &bh->b_count);
+				bio->bi_size += PAGE_SIZE;
 			continue;
 		}
-		if (b_data == bh->b_data + bh->b_size) {
-			bh->b_size += PAGE_SIZE;
+		if (b_data == bio_data(bio) + bio->bi_size) {
+			bio->bi_size += PAGE_SIZE;
 			if (full)
-				atomic_add(PAGE_SIZE, &bh->b_count);
+				bio->bi_size += PAGE_SIZE;
 			continue;
 		}
-		prev_bh = bh;
-		if ((bh = (struct buffer_head *) kmalloc (sizeof (struct buffer_head), GFP_KERNEL)) == NULL) {
-			free_page ((unsigned long) b_data);
+		prev_bio = bio;
+		if ((bio = bio_alloc(GFP_KERNEL,1)) == NULL) {
+			free_page ((unsigned long) bio_data(bio));
 			goto abort;
 		}
-		bh->b_reqnext = NULL;
-		bh->b_data = b_data;
-		bh->b_size = PAGE_SIZE;
-		atomic_set(&bh->b_count, full ? bh->b_size : 0);
-		set_bit (BH_Lock, &bh->b_state);
-		prev_bh->b_reqnext = bh;
+		bio->bi_next = NULL;
+		//bio->bi_io_vec[0].bv_offset = b_data;
+		bio->bi_size = PAGE_SIZE;
+		atomic_set(&bio->bi_cnt, full ? bio->bi_size : 0);
+		set_bit (BH_Lock, &bio->bi_flags);
+		prev_bio->bi_next = bio;
 	}
-	bh->b_size -= tape->excess_bh_size;
+	bio->bi_size -= tape->excess_bh_size;
 	if (full)
-		atomic_sub(tape->excess_bh_size, &bh->b_count);
+		atomic_sub(tape->excess_bh_size, &bio->bi_cnt);
 	if (tape->onstream)
-		stage->aux = (os_aux_t *) (bh->b_data + bh->b_size - OS_AUX_SIZE);
+		stage->aux = (os_aux_t *) (bio_data(bio) + bio->bi_size - OS_AUX_SIZE);
 	return stage;
 abort:
 	__idetape_kfree_stage (stage);
@@ -2903,39 +2909,39 @@
 
 static void idetape_copy_stage_from_user (idetape_tape_t *tape, idetape_stage_t *stage, const char *buf, int n)
 {
-	struct buffer_head *bh = tape->bh;
+	struct bio *bio = tape->bio;
 	int count;
 
 	while (n) {
 #if IDETAPE_DEBUG_BUGS
-		if (bh == NULL) {
-			printk (KERN_ERR "ide-tape: bh == NULL in idetape_copy_stage_from_user\n");
+		if (bio == NULL) {
+			printk (KERN_ERR "ide-tape: bio == NULL in idetape_copy_stage_from_user\n");
 			return;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
-		count = IDE_MIN (bh->b_size - atomic_read(&bh->b_count), n);
-		copy_from_user (bh->b_data + atomic_read(&bh->b_count), buf, count);
+		count = IDE_MIN (bio->bi_size - tape->b_count, n);
+		copy_from_user (bio_data(bio) + tape->b_count, buf, count);
 		n -= count;
-		atomic_add(count, &bh->b_count);
+		bio->bi_size += count;
 		buf += count;
-		if (atomic_read(&bh->b_count) == bh->b_size) {
-			bh = bh->b_reqnext;
-			if (bh)
-				atomic_set(&bh->b_count, 0);
+		if (tape->b_count == bio->bi_size) {
+			bio = bio->bi_next;
+			if (bio)
+				tape->b_count = 0;
 		}
 	}
-	tape->bh = bh;
+	tape->bio = bio;
 }
 
 static void idetape_copy_stage_to_user (idetape_tape_t *tape, char *buf, idetape_stage_t *stage, int n)
 {
-	struct buffer_head *bh = tape->bh;
+	struct bio *bio = tape->bio;
 	int count;
 
 	while (n) {
 #if IDETAPE_DEBUG_BUGS
-		if (bh == NULL) {
-			printk (KERN_ERR "ide-tape: bh == NULL in idetape_copy_stage_to_user\n");
+		if (bio == NULL) {
+			printk (KERN_ERR "ide-tape: bio == NULL in idetape_copy_stage_to_user\n");
 			return;
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
@@ -2946,10 +2952,10 @@
 		tape->b_count -= count;
 		buf += count;
 		if (!tape->b_count) {
-			tape->bh = bh = bh->b_reqnext;
-			if (bh) {
-				tape->b_data = bh->b_data;
-				tape->b_count = atomic_read(&bh->b_count);
+			tape->bio = bio = bio->bi_next;
+			if (bio) {
+				tape->b_data = bio_data(bio);
+				tape->b_count = bio->bi_size;
 			}
 		}
 	}
@@ -2957,25 +2963,25 @@
 
 static void idetape_init_merge_stage (idetape_tape_t *tape)
 {
-	struct buffer_head *bh = tape->merge_stage->bh;
+	struct bio *bio = tape->merge_stage->bio;
 	
-	tape->bh = bh;
+	tape->bio = bio;
 	if (tape->chrdev_direction == idetape_direction_write)
-		atomic_set(&bh->b_count, 0);
+		atomic_set(&bio->bi_cnt, 0);
 	else {
-		tape->b_data = bh->b_data;
-		tape->b_count = atomic_read(&bh->b_count);
+		tape->b_data = bio_data(bio);
+		tape->b_count = atomic_read(&bio->bi_cnt);
 	}
 }
 
 static void idetape_switch_buffers (idetape_tape_t *tape, idetape_stage_t *stage)
 {
-	struct buffer_head *tmp;
+	struct bio *tmp;
 	os_aux_t *tmp_aux;
 
-	tmp = stage->bh; tmp_aux = stage->aux;
-	stage->bh = tape->merge_stage->bh; stage->aux = tape->merge_stage->aux;
-	tape->merge_stage->bh = tmp; tape->merge_stage->aux = tmp_aux;
+	tmp = stage->bio; tmp_aux = stage->aux;
+	stage->bio = tape->merge_stage->bio; stage->aux = tape->merge_stage->aux;
+	tape->merge_stage->bio = tmp; tape->merge_stage->aux = tmp_aux;
 	idetape_init_merge_stage (tape);
 }
 
@@ -3077,7 +3083,7 @@
 	idetape_tape_t *tape = drive->driver_data;
 
 #if IDETAPE_DEBUG_BUGS
-	if (rq == NULL || !IDETAPE_RQ_CMD (rq->cmd)) {
+	if (rq == NULL || !IDETAPE_RQ_CMD (rq->flags)) {
 		printk (KERN_ERR "ide-tape: bug: Trying to sleep on non-valid request\n");
 		return;
 	}
@@ -3185,7 +3191,7 @@
 
 	ide_init_drive_cmd (&rq);
 	rq.buffer = (char *) pc;
-	rq.cmd = IDETAPE_PC_RQ1;
+	rq.flags = IDETAPE_PC_RQ1;
 	return ide_do_drive_cmd (drive, &rq, ide_wait);
 }
 
@@ -3430,7 +3436,7 @@
  *	idetape_queue_rw_tail generates a read/write request for the block
  *	device interface and wait for it to be serviced.
  */
-static int idetape_queue_rw_tail (ide_drive_t *drive, int cmd, int blocks, struct buffer_head *bh)
+static int idetape_queue_rw_tail (ide_drive_t *drive, int cmd, int blocks, struct bio *bio)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct request rq;
@@ -3447,8 +3453,8 @@
 #endif /* IDETAPE_DEBUG_BUGS */	
 
 	ide_init_drive_cmd (&rq);
-	rq.bh = bh;
-	rq.cmd = cmd;
+	rq.bio = bio;
+	rq.flags = cmd;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
 	if (tape->onstream)
@@ -3489,15 +3495,15 @@
 		if (!first)
 			first = stage;
 		aux = stage->aux;
-		p = stage->bh->b_data;
-		idetape_queue_rw_tail(drive, IDETAPE_READ_BUFFER_RQ, tape->capabilities.ctl, stage->bh);
+		p = bio_data(stage->bio);
+		idetape_queue_rw_tail(drive, IDETAPE_READ_BUFFER_RQ, tape->capabilities.ctl, stage->bio);
 #if ONSTREAM_DEBUG
 		if (tape->debug_level >= 2)
 			printk(KERN_INFO "ide-tape: %s: read back logical block %d, data %x %x %x %x\n", tape->name, logical_blk_num, *p++, *p++, *p++, *p++);
 #endif
 		rq = &stage->rq;
 		ide_init_drive_cmd (rq);
-		rq->cmd = IDETAPE_WRITE_RQ;
+		rq->flags = IDETAPE_WRITE_RQ;
 		rq->sector = tape->first_frame_position;
 		rq->nr_sectors = rq->current_nr_sectors = tape->capabilities.ctl;
 		idetape_init_stage(drive, stage, OS_FRAME_TYPE_DATA, logical_blk_num++);
@@ -3646,18 +3652,18 @@
 	os_aux_t *aux = stage->aux;
 	os_partition_t *par = &aux->partition;
 	struct request *rq = &stage->rq;
-	struct buffer_head *bh;
+	struct bio *bio;
 
 	if (!tape->onstream)
 		return 1;
 	if (tape->raw) {
 		if (rq->errors) {
-			bh = stage->bh;
-			while (bh) {
-				memset(bh->b_data, 0, bh->b_size);
-				bh = bh->b_reqnext;
+			bio = stage->bio;
+			while (bio) {
+				memset(bio_data(bio), 0, bio->bi_size);
+				bio = bio->bi_next;
 			}
-			strcpy(stage->bh->b_data, "READ ERROR ON FRAME");
+			strcpy(bio_data(stage->bio), "READ ERROR ON FRAME");
 		}
 		return 1;
 	}
@@ -3767,12 +3773,12 @@
 			 *	Linux is short on memory. Fallback to
 			 *	non-pipelined operation mode for this request.
 			 */
-			return idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, blocks, tape->merge_stage->bh);
+			return idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, blocks, tape->merge_stage->bio);
 		}
 	}
 	rq = &new_stage->rq;
 	ide_init_drive_cmd (rq);
-	rq->cmd = IDETAPE_WRITE_RQ;
+	rq->flags = IDETAPE_WRITE_RQ;
 	rq->sector = tape->first_frame_position;	/* Doesn't actually matter - We always assume sequential access */
 	rq->nr_sectors = rq->current_nr_sectors = blocks;
 
@@ -3843,7 +3849,7 @@
 {
 	idetape_tape_t *tape = drive->driver_data;
 	int blocks, i, min;
-	struct buffer_head *bh;
+	struct bio *bio;
 	
 #if IDETAPE_DEBUG_BUGS
 	if (tape->chrdev_direction != idetape_direction_write) {
@@ -3860,22 +3866,22 @@
 		if (tape->merge_stage_size % tape->tape_block_size) {
 			blocks++;
 			i = tape->tape_block_size - tape->merge_stage_size % tape->tape_block_size;
-			bh = tape->bh->b_reqnext;
-			while (bh) {
-				atomic_set(&bh->b_count, 0);
-				bh = bh->b_reqnext;
+			bio = tape->bio->bi_next;
+			while (bio) {
+				atomic_set(&bio->bi_cnt, 0);
+				bio = bio->bi_next;
 			}
-			bh = tape->bh;
+			bio = tape->bio;
 			while (i) {
-				if (bh == NULL) {
-					printk(KERN_INFO "ide-tape: bug, bh NULL\n");
+				if (bio == NULL) {
+					printk(KERN_INFO "ide-tape: bug, bio NULL\n");
 					break;
 				}
-				min = IDE_MIN(i, bh->b_size - atomic_read(&bh->b_count));
-				memset(bh->b_data + atomic_read(&bh->b_count), 0, min);
-				atomic_add(min, &bh->b_count);
+				min = IDE_MIN(i, bio->bi_size - atomic_read(&bio->bi_cnt));
+				memset(bio_data(bio) + bio->bi_size, 0, min);
+				atomic_add(min, &bio->bi_cnt);
 				i -= min;
-				bh = bh->b_reqnext;
+				bio = bio->bi_next;
 			}
 		}
 		(void) idetape_add_chrdev_write_request (drive, blocks);
@@ -3949,7 +3955,7 @@
 		 *	is switched from completion mode to buffer available
 		 *	mode.
 		 */
-		bytes_read = idetape_queue_rw_tail (drive, IDETAPE_READ_RQ, 0, tape->merge_stage->bh);
+		bytes_read = idetape_queue_rw_tail (drive, IDETAPE_READ_RQ, 0, tape->merge_stage->bio);
 		if (bytes_read < 0) {
 			kfree (tape->merge_stage);
 			tape->merge_stage = NULL;
@@ -3960,7 +3966,7 @@
 	if (tape->restart_speed_control_req)
 		idetape_restart_speed_control(drive);
 	ide_init_drive_cmd (&rq);
-	rq.cmd = IDETAPE_READ_RQ;
+	rq.flags = IDETAPE_READ_RQ;
 	rq.sector = tape->first_frame_position;
 	rq.nr_sectors = rq.current_nr_sectors = blocks;
 	if (!test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags) && tape->nr_stages <= max_stages) {
@@ -4083,7 +4089,7 @@
 		}
 		if (test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags))
 		 	return 0;
-		return idetape_queue_rw_tail (drive, IDETAPE_READ_RQ, blocks, tape->merge_stage->bh);
+		return idetape_queue_rw_tail (drive, IDETAPE_READ_RQ, blocks, tape->merge_stage->bio);
 	}
 	rq_ptr = &tape->first_stage->rq;
 	bytes_read = tape->tape_block_size * (rq_ptr->nr_sectors - rq_ptr->current_nr_sectors);
@@ -4137,21 +4143,21 @@
 static void idetape_pad_zeros (ide_drive_t *drive, int bcount)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	struct buffer_head *bh;
+	struct bio *bio;
 	int count, blocks;
 	
 	while (bcount) {
-		bh = tape->merge_stage->bh;
+		bio = tape->merge_stage->bio;
 		count = IDE_MIN (tape->stage_size, bcount);
 		bcount -= count;
 		blocks = count / tape->tape_block_size;
 		while (count) {
-			atomic_set(&bh->b_count, IDE_MIN (count, bh->b_size));
-			memset (bh->b_data, 0, atomic_read(&bh->b_count));
-			count -= atomic_read(&bh->b_count);
-			bh = bh->b_reqnext;
+			atomic_set(&bio->bi_cnt, IDE_MIN (count, bio->bi_size));
+			memset (bio_data(bio), 0, bio->bi_size);
+			count -= atomic_read(&bio->bi_cnt);
+			bio = bio->bi_next;
 		}
-		idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, blocks, tape->merge_stage->bh);
+		idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, blocks, tape->merge_stage->bio);
 	}
 }
 
@@ -4276,7 +4282,7 @@
  */
 static ide_drive_t *get_drive_ptr (kdev_t i_rdev)
 {
-	unsigned int i = MINOR(i_rdev) & ~0xc0;
+	unsigned int i = minor(i_rdev) & ~0xc0;
 
 	if (i >= MAX_HWIFS * MAX_DRIVES)
 		return NULL;
@@ -4654,7 +4660,7 @@
 		printk(KERN_INFO "ide-tape: current position (2) tape block %d\n", tape->last_frame_position);
 #endif
 	idetape_position_tape(drive, last_mark_addr, 0, 0);
-	if (!idetape_queue_rw_tail (drive, IDETAPE_READ_RQ, 1, stage->bh)) {
+	if (!idetape_queue_rw_tail (drive, IDETAPE_READ_RQ, 1, stage->bio)) {
 		printk(KERN_INFO "ide-tape: %s: couldn't read last marker\n", tape->name);
 		__idetape_kfree_stage (stage);
 		idetape_position_tape(drive, position, 0, 0);
@@ -4673,7 +4679,7 @@
 #endif
 	aux->next_mark_addr = htonl(next_mark_addr);
 	idetape_position_tape(drive, last_mark_addr, 0, 0);
-	if (!idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, 1, stage->bh)) {
+	if (!idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, 1, stage->bio)) {
 		printk(KERN_INFO "ide-tape: %s: couldn't write back marker frame at %d\n", tape->name, last_mark_addr);
 		__idetape_kfree_stage (stage);
 		idetape_position_tape(drive, position, 0, 0);
@@ -4705,9 +4711,9 @@
 	if (rc != 0) 
 		return;	/* don't write fillers if we cannot position the tape. */
 
-	strcpy(stage->bh->b_data, "Filler");
+	strcpy(bio_data(stage->bio), "Filler");
 	while (cnt--) {
-		if (!idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, 1, stage->bh)) {
+		if (!idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, 1, stage->bio)) {
 			printk(KERN_INFO "ide-tape: %s: write_filler: couldn't write header frame\n", tape->name);
 			__idetape_kfree_stage (stage);
 			return;
@@ -4739,9 +4745,9 @@
 	header.partition.last_frame_addr = htonl(tape->capacity);
 	header.partition.wrt_pass_cntr = htons(tape->wrt_pass_cntr);
 	header.partition.eod_frame_addr = htonl(tape->eod_frame_addr);
-	memcpy(stage->bh->b_data, &header, sizeof(header));
+	memcpy(bio_data(stage->bio), &header, sizeof(header));
 	while (cnt--) {
-		if (!idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, 1, stage->bh)) {
+		if (!idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, 1, stage->bio)) {
 			printk(KERN_INFO "ide-tape: %s: couldn't write header frame\n", tape->name);
 			__idetape_kfree_stage (stage);
 			return;
@@ -4860,7 +4866,7 @@
 		 *	is switched from completion mode to buffer available
 		 *	mode.
 		 */
-		retval = idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, 0, tape->merge_stage->bh);
+		retval = idetape_queue_rw_tail (drive, IDETAPE_WRITE_RQ, 0, tape->merge_stage->bio);
 		if (retval < 0) {
 			kfree (tape->merge_stage);
 			tape->merge_stage = NULL;
@@ -5326,12 +5332,12 @@
 		printk(KERN_INFO "ide-tape: %s: reading header\n", tape->name);
 #endif
 	idetape_position_tape(drive, block, 0, 0);
-	if (!idetape_queue_rw_tail (drive, IDETAPE_READ_RQ, 1, stage->bh)) {
+	if (!idetape_queue_rw_tail (drive, IDETAPE_READ_RQ, 1, stage->bio)) {
 		printk(KERN_INFO "ide-tape: %s: couldn't read header frame\n", tape->name);
 		__idetape_kfree_stage (stage);
 		return 0;
 	}
-	header = (os_header_t *) stage->bh->b_data;
+	header = (os_header_t *) bio_data(stage->bio);
 	aux = stage->aux;
 	if (strncmp(header->ident_str, "ADR_SEQ", 7) != 0) {
 		printk(KERN_INFO "ide-tape: %s: invalid header identification string\n", tape->name);
@@ -5403,7 +5409,7 @@
 	ide_drive_t *drive;
 	idetape_tape_t *tape;
 	idetape_pc_t pc;
-	unsigned int minor=MINOR (inode->i_rdev);
+	unsigned int minor=minor(inode->i_rdev);
 			
 #if IDETAPE_DEBUG_LOG
 	printk (KERN_INFO "ide-tape: Reached idetape_chrdev_open\n");
@@ -5460,7 +5466,7 @@
 {
 	ide_drive_t *drive = get_drive_ptr (inode->i_rdev);
 	idetape_tape_t *tape = drive->driver_data;
-	unsigned int minor=MINOR (inode->i_rdev);
+	unsigned int minor=minor(inode->i_rdev);
 
 	idetape_empty_write_pipeline (drive);
 	tape->merge_stage = __idetape_kmalloc_stage (tape, 1, 0);
@@ -5486,7 +5492,7 @@
 	ide_drive_t *drive = get_drive_ptr (inode->i_rdev);
 	idetape_tape_t *tape;
 	idetape_pc_t pc;
-	unsigned int minor=MINOR (inode->i_rdev);
+	unsigned int minor=minor(inode->i_rdev);
 
 	tape = drive->driver_data;
 #if IDETAPE_DEBUG_LOG

