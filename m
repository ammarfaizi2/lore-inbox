Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRLQKgX>; Mon, 17 Dec 2001 05:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285091AbRLQKgO>; Mon, 17 Dec 2001 05:36:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9732 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S274752AbRLQKf7>;
	Mon, 17 Dec 2001 05:35:59 -0500
Date: Mon, 17 Dec 2001 11:35:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj1
Message-ID: <20011217103553.GF4587@suse.de>
In-Reply-To: <20011217015845.A10313@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011217015845.A10313@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17 2001, Dave Jones wrote:
> o   bio changes for ide floppy					(Me)
>     | handle with care, compiles, but is unfinished.

This is still badly broken -- I've attached my version I did for
somebody friday.

--- /opt/kernel/linux-2.5.1/drivers/ide/ide-floppy.c	Mon Dec 17 03:57:34 2001
+++ linux/drivers/ide/ide-floppy.c	Mon Dec 17 05:31:39 2001
@@ -336,23 +336,7 @@
 #define	IDEFLOPPY_IOCTL_FORMAT_START		0x4602
 #define IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS	0x4603
 
-/*
- *	Special requests for our block device strategy routine.
- */
-#define	IDEFLOPPY_FIRST_RQ		90
-
-/*
- * 	IDEFLOPPY_PC_RQ is used to queue a packet command in the request queue.
- */
-#define	IDEFLOPPY_PC_RQ			90
-
-#define IDEFLOPPY_LAST_RQ		90
-
-/*
- *	A macro which can be used to check if a given request command
- *	originated in the driver or in the buffer cache layer.
- */
-#define IDEFLOPPY_RQ_CMD(cmd) 		((cmd >= IDEFLOPPY_FIRST_RQ) && (cmd <= IDEFLOPPY_LAST_RQ))
+#define IDEFLOPPY_RQ			(REQ_SPECIAL)
 
 /*
  *	Error codes which are returned in rq->errors to the higher part
@@ -696,7 +680,7 @@
 	/* Why does this happen? */
 	if (!rq)
 		return;
-	if (!IDEFLOPPY_RQ_CMD (rq->cmd)) {
+	if (rq->flags & IDEFLOPPY_RQ) {
 		ide_end_request (uptodate, hwgroup);
 		return;
 	}
@@ -776,7 +760,7 @@
 {
 	ide_init_drive_cmd (rq);
 	rq->buffer = (char *) pc;
-	rq->cmd = IDEFLOPPY_PC_RQ;
+	rq->flags = IDEFLOPPY_RQ;
 	(void) ide_do_drive_cmd (drive, rq, ide_preempt);
 }
 
@@ -1192,6 +1176,7 @@
 {
 	int block = sector / floppy->bs_factor;
 	int blocks = rq->nr_sectors / floppy->bs_factor;
+	int cmd = rq_data_dir(rq);
 	
 #if IDEFLOPPY_DEBUG_LOG
 	printk ("create_rw1%d_cmd: block == %d, blocks == %d\n",
@@ -1200,18 +1185,18 @@
 
 	idefloppy_init_pc (pc);
 	if (test_bit (IDEFLOPPY_USE_READ12, &floppy->flags)) {
-		pc->c[0] = rq->cmd == READ ? IDEFLOPPY_READ12_CMD : IDEFLOPPY_WRITE12_CMD;
+		pc->c[0] = cmd == READ ? IDEFLOPPY_READ12_CMD : IDEFLOPPY_WRITE12_CMD;
 		put_unaligned (htonl (blocks), (unsigned int *) &pc->c[6]);
 	} else {
-		pc->c[0] = rq->cmd == READ ? IDEFLOPPY_READ10_CMD : IDEFLOPPY_WRITE10_CMD;
+		pc->c[0] = cmd == READ ? IDEFLOPPY_READ10_CMD : IDEFLOPPY_WRITE10_CMD;
 		put_unaligned (htons (blocks), (unsigned short *) &pc->c[7]);
 	}
 	put_unaligned (htonl (block), (unsigned int *) &pc->c[2]);
 	pc->callback = &idefloppy_rw_callback;
 	pc->rq = rq;
 	pc->b_data = rq->buffer;
-	pc->b_count = rq->cmd == READ ? 0 : rq->bio->bi_size;
-	if (rq->cmd == WRITE)
+	pc->b_count = cmd == READ ? 0 : rq->bio->bi_size;
+	if (rq->flags & REQ_RW)
 		set_bit (PC_WRITING, &pc->flags);
 	pc->buffer = NULL;
 	pc->request_transfer = pc->buffer_size = blocks * floppy->block_size;
@@ -1227,8 +1212,8 @@
 	idefloppy_pc_t *pc;
 
 #if IDEFLOPPY_DEBUG_LOG
-	printk (KERN_INFO "rq_status: %d, rq_dev: %u, cmd: %d, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
-	printk (KERN_INFO "sector: %ld, nr_sectors: %ld, current_nr_sectors: %ld\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
+	printk (KERN_INFO "rq_status: %d, rq_dev: %u, flags: %lx, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->flags,rq->errors);
+	printk (KERN_INFO "sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
 #endif /* IDEFLOPPY_DEBUG_LOG */
 
 	if (rq->errors >= ERROR_MAX) {
@@ -1240,24 +1225,20 @@
 		idefloppy_end_request (0, HWGROUP(drive));
 		return ide_stopped;
 	}
-	switch (rq->cmd) {
-		case READ:
-		case WRITE:
-			if (rq->sector % floppy->bs_factor || rq->nr_sectors % floppy->bs_factor) {
-				printk ("%s: unsupported r/w request size\n", drive->name);
-				idefloppy_end_request (0, HWGROUP(drive));
-				return ide_stopped;
-			}
-			pc = idefloppy_next_pc_storage (drive);
-			idefloppy_create_rw_cmd (floppy, pc, rq, block);
-			break;
-		case IDEFLOPPY_PC_RQ:
-			pc = (idefloppy_pc_t *) rq->buffer;
-			break;
-		default:
-			printk (KERN_ERR "ide-floppy: unsupported command %x in request queue\n", rq->cmd);
-			idefloppy_end_request (0,HWGROUP (drive));
+	if (rq->flags & REQ_CMD) {
+		if (rq->sector % floppy->bs_factor || rq->nr_sectors % floppy->bs_factor) {
+			printk ("%s: unsupported r/w request size\n", drive->name);
+			idefloppy_end_request (0, HWGROUP(drive));
 			return ide_stopped;
+		}
+		pc = idefloppy_next_pc_storage (drive);
+		idefloppy_create_rw_cmd (floppy, pc, rq, block);
+	} else if (rq->flags & IDEFLOPPY_RQ) {
+		pc = (idefloppy_pc_t *) rq->buffer;
+	} else {
+		blk_dump_rq_flags(rq, "ide-floppy: unsupported command in queue");
+		idefloppy_end_request (0,HWGROUP (drive));
+		return ide_stopped;
 	}
 	pc->rq = rq;
 	return idefloppy_issue_pc (drive, pc);
@@ -1273,7 +1254,7 @@
 
 	ide_init_drive_cmd (&rq);
 	rq.buffer = (char *) pc;
-	rq.cmd = IDEFLOPPY_PC_RQ;
+	rq.flags = IDEFLOPPY_RQ;
 	return ide_do_drive_cmd (drive, &rq, ide_wait);
 }
 

-- 
Jens Axboe

