Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTDNJWu (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbTDNJWt (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:22:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61115 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262914AbTDNJWm (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 05:22:42 -0400
Date: Mon, 14 Apr 2003 11:34:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Marcelo <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.21-pre7 ide request races
Message-ID: <20030414093418.GQ9776@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've had some problems with request corruption on IDE in the past, IBM
traced these to stack corruption. In various places, the IDE code does
something ala:

submission:
	struct request rq;

	...
	ide_do_drive_cmd(drive, &rq, ide_wait);

ide_end_request:
	...
	blkdev_release_request()

which works fine, as long as the stack persists for the
blkdev_release_request() call, but it may not if the task has already
exited (CPU0 may be waiting in ide_do_drive_cmd(), CPU1 gets the
completion interrupt, task is woken, and exits, CPU0 now calls
blkdev_release_request()). The result is random stack corruption (or
request list corruption, rq->q may have been scrippled!), not good.

The solution is to allocate the requests from the ordinary block pool,
which not alone fixes the problem but also is a lot cleaner IMHO. I've
added blk_get_request() which is identical to what I added in 2.5, so we
can easily carry this fix forward to the 2.5 IDE base as well.

diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.21-pre7/drivers/block/ll_rw_blk.c linux-2.4.21-pre7/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.4.21-pre7/drivers/block/ll_rw_blk.c	2003-04-14 10:48:21.000000000 +0200
+++ linux-2.4.21-pre7/drivers/block/ll_rw_blk.c	2003-04-14 11:28:51.000000000 +0200
@@ -427,7 +427,9 @@
 	INIT_LIST_HEAD(&q->rq[READ].free);
 	INIT_LIST_HEAD(&q->rq[WRITE].free);
 	q->rq[READ].count = 0;
+	q->rq[READ].wait = &q->wait_for_requests[READ];
 	q->rq[WRITE].count = 0;
+	q->rq[WRITE].wait = &q->wait_for_requests[WRITE];
 	q->nr_requests = 0;
 
 	si_meminfo(&si);
@@ -521,6 +523,7 @@
 		rq->cmd = rw;
 		rq->special = NULL;
 		rq->q = q;
+		rq->rl = rl;
 	}
 
 	return rq;
@@ -605,6 +608,30 @@
 	return rq;
 }
 
+struct request *blk_get_request(request_queue_t *q, int rw, int gfp_mask)
+{
+	struct request *rq;
+	unsigned long flags;
+
+	BUG_ON(rw != READ && rw != WRITE);
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	rq = get_request(q, rw);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+
+	if (!rq && (gfp_mask & __GFP_WAIT))
+		rq = __get_request_wait(q, rw);
+
+	if (rq) {
+		rq->buffer = NULL;
+		rq->bh = rq->bhtail = NULL;
+		rq->waiting = NULL;
+		rq->special = NULL;
+	}
+
+	return rq;
+}
+
 /* RO fail safe mechanism */
 
 static long ro_bits[MAX_BLKDEV][8];
@@ -818,20 +845,21 @@
 void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
-	int rw = req->cmd;
+	struct request_list *rl = req->rl;
 
 	req->rq_status = RQ_INACTIVE;
 	req->q = NULL;
+	req->rl = NULL;
 
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
 	 * assume it has free buffers and check waiters
 	 */
-	if (q) {
-		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests &&
-				waitqueue_active(&q->wait_for_requests[rw]))
-			wake_up(&q->wait_for_requests[rw]);
+	if (rl) {
+		list_add(&req->queue, &rl->free);
+		if (++rl->count >= q->batch_requests &&
+		    waitqueue_active(rl->wait))
+			wake_up(rl->wait);
 	}
 }
 
@@ -1518,3 +1546,4 @@
 EXPORT_SYMBOL(blk_max_pfn);
 EXPORT_SYMBOL(blk_seg_merge_ok);
 EXPORT_SYMBOL(blk_nohighio);
+EXPORT_SYMBOL(blk_get_request);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide-cd.c linux-2.4.21-pre7/drivers/ide/ide-cd.c
--- /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide-cd.c	2003-04-14 10:48:22.000000000 +0200
+++ linux-2.4.21-pre7/drivers/ide/ide-cd.c	2003-04-14 11:13:38.000000000 +0200
@@ -1601,7 +1601,7 @@
 int cdrom_queue_packet_command(ide_drive_t *drive, struct packet_command *pc)
 {
 	struct request_sense sense;
-	struct request req;
+	struct request *req;
 	int retries = 10;
 
 	if (pc->sense == NULL)
@@ -1609,10 +1609,11 @@
 
 	/* Start of retry loop. */
 	do {
-		ide_init_drive_cmd (&req);
-		req.cmd = PACKET_COMMAND;
-		req.buffer = (char *)pc;
-		ide_do_drive_cmd(drive, &req, ide_wait);
+		req = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
+		ide_init_drive_cmd (req);
+		req->cmd = PACKET_COMMAND;
+		req->buffer = (char *)pc;
+		ide_do_drive_cmd(drive, req, ide_wait);
 		/* FIXME: we should probably abort/retry or something 
 		 * in case of failure */
 		if (pc->stat != 0) {
@@ -2487,12 +2488,12 @@
 {
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 	struct request_sense sense;
-	struct request req;
+	struct request *req = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
 	int ret;
 
-	ide_init_drive_cmd (&req);
-	req.cmd = RESET_DRIVE_COMMAND;
-	ret = ide_do_drive_cmd(drive, &req, ide_wait);
+	ide_init_drive_cmd (req);
+	req->cmd = RESET_DRIVE_COMMAND;
+	ret = ide_do_drive_cmd(drive, req, ide_wait);
 
 	/*
 	 * A reset will unlock the door. If it was previously locked,
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide-disk.c linux-2.4.21-pre7/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide-disk.c	2003-04-14 10:48:22.000000000 +0200
+++ linux-2.4.21-pre7/drivers/ide/ide-disk.c	2003-04-14 11:07:24.000000000 +0200
@@ -1414,15 +1414,16 @@
  */
 static int set_multcount(ide_drive_t *drive, int arg)
 {
-	struct request rq;
+	struct request *rq;
 
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
-	ide_init_drive_cmd (&rq);
-	rq.cmd = IDE_DRIVE_CMD;
+	rq = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
+	ide_init_drive_cmd (rq);
+	rq->cmd = IDE_DRIVE_CMD;
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
-	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
+	(void) ide_do_drive_cmd (drive, rq, ide_wait);
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide-io.c linux-2.4.21-pre7/drivers/ide/ide-io.c
--- /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide-io.c	2003-04-14 10:48:22.000000000 +0200
+++ linux-2.4.21-pre7/drivers/ide/ide-io.c	2003-04-14 10:53:01.000000000 +0200
@@ -1281,8 +1281,10 @@
 
 void ide_init_drive_cmd (struct request *rq)
 {
-	memset(rq, 0, sizeof(*rq));
+	INIT_LIST_HEAD(&rq->queue);
 	rq->cmd = IDE_DRIVE_CMD;
+	rq->special = rq->buffer = NULL;
+	rq->bh = rq->bhtail = NULL;
 }
 
 EXPORT_SYMBOL(ide_init_drive_cmd);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide-taskfile.c linux-2.4.21-pre7/drivers/ide/ide-taskfile.c
--- /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide-taskfile.c	2003-04-14 10:48:22.000000000 +0200
+++ linux-2.4.21-pre7/drivers/ide/ide-taskfile.c	2003-04-14 11:16:15.000000000 +0200
@@ -1306,7 +1306,7 @@
  */
 void ide_init_drive_taskfile (struct request *rq)
 {
-	memset(rq, 0, sizeof(*rq));
+	ide_init_drive_cmd(rq);
 	rq->cmd = IDE_DRIVE_TASK_NO_DATA;
 }
 
@@ -1316,11 +1316,11 @@
 
 int ide_diag_taskfile (ide_drive_t *drive, ide_task_t *args, unsigned long data_size, u8 *buf)
 {
-	struct request rq;
+	struct request *rq = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
 
-	ide_init_drive_taskfile(&rq);
-	rq.cmd = IDE_DRIVE_TASKFILE;
-	rq.buffer = buf;
+	ide_init_drive_taskfile(rq);
+	rq->cmd = IDE_DRIVE_TASKFILE;
+	rq->buffer = buf;
 
 	/*
 	 * (ks) We transfer currently only whole sectors.
@@ -1330,11 +1330,11 @@
 	 */
 	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
 		if (data_size == 0)
-			rq.current_nr_sectors = rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
-		/*	rq.hard_cur_sectors	*/
+			rq->current_nr_sectors = rq->nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET_HOB] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
+		/*	rq->hard_cur_sectors	*/
 		else
-			rq.current_nr_sectors = rq.nr_sectors = data_size / SECTOR_SIZE;
-		/*	rq.hard_cur_sectors	*/
+			rq->current_nr_sectors = rq->nr_sectors = data_size / SECTOR_SIZE;
+		/*	rq->hard_cur_sectors	*/
 	}
 
 	if (args->tf_out_flags.all == 0) {
@@ -1347,8 +1347,8 @@
 				(struct hd_drive_hob_hdr *) args->hobRegister);
 
 	}
-	rq.special = args;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	rq->special = args;
+	return ide_do_drive_cmd(drive, rq, ide_wait);
 }
 
 #else
@@ -1649,19 +1649,19 @@
 
 int ide_wait_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature, u8 sectors, u8 *buf)
 {
-	struct request rq;
+	struct request *rq = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
 	u8 buffer[4];
 
 	if (!buf)
 		buf = buffer;
 	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
-	ide_init_drive_cmd(&rq);
-	rq.buffer = buf;
+	ide_init_drive_cmd(rq);
+	rq->buffer = buf;
 	*buf++ = cmd;
 	*buf++ = nsect;
 	*buf++ = feature;
 	*buf++ = sectors;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	return ide_do_drive_cmd(drive, rq, ide_wait);
 }
 
 EXPORT_SYMBOL(ide_wait_cmd);
@@ -1679,9 +1679,9 @@
 	ide_task_t tfargs;
 
 	if (NULL == (void *) arg) {
-		struct request rq;
-		ide_init_drive_cmd(&rq);
-		return ide_do_drive_cmd(drive, &rq, ide_wait);
+		struct request *rq = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
+		ide_init_drive_cmd(rq);
+		return ide_do_drive_cmd(drive, rq, ide_wait);
 	}
 
 	if (copy_from_user(args, (void *)arg, 4))
@@ -1732,9 +1732,9 @@
 	ide_task_t tfargs;
 
 	if (NULL == (void *) arg) {
-		struct request rq;
-		ide_init_drive_cmd(&rq);
-		return ide_do_drive_cmd(drive, &rq, ide_wait);
+		struct request *rq = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
+		ide_init_drive_cmd(rq);
+		return ide_do_drive_cmd(drive, rq, ide_wait);
 	}
 
 	if (copy_from_user(args, (void *)arg, 4))
@@ -1792,12 +1792,12 @@
 
 int ide_wait_cmd_task (ide_drive_t *drive, u8 *buf)
 {
-	struct request rq;
+	struct request *rq = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
 
-	ide_init_drive_cmd(&rq);
-	rq.cmd = IDE_DRIVE_TASK;
-	rq.buffer = buf;
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	ide_init_drive_cmd(rq);
+	rq->cmd = IDE_DRIVE_TASK;
+	rq->buffer = buf;
+	return ide_do_drive_cmd(drive, rq, ide_wait);
 }
 
 EXPORT_SYMBOL(ide_wait_cmd_task);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide.c linux-2.4.21-pre7/drivers/ide/ide.c
--- /opt/kernel/linux-2.4.21-pre7/drivers/ide/ide.c	2003-04-14 10:48:22.000000000 +0200
+++ linux-2.4.21-pre7/drivers/ide/ide.c	2003-04-14 11:08:25.000000000 +0200
@@ -1359,16 +1359,17 @@
 
 static int set_pio_mode (ide_drive_t *drive, int arg)
 {
-	struct request rq;
+	struct request *rq;
 
 	if (!HWIF(drive)->tuneproc)
 		return -ENOSYS;
 	if (drive->special.b.set_tune)
 		return -EBUSY;
-	ide_init_drive_cmd(&rq);
+	rq = blk_get_request(&drive->queue, WRITE, GFP_KERNEL);
+	ide_init_drive_cmd(rq);
 	drive->tune_req = (u8) arg;
 	drive->special.b.set_tune = 1;
-	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
+	(void) ide_do_drive_cmd(drive, rq, ide_wait);
 	return 0;
 }
 
@@ -1533,7 +1534,6 @@
 {
 	int err = 0, major, minor;
 	ide_drive_t *drive;
-	struct request rq;
 	kdev_t dev;
 	ide_settings_t *setting;
 
@@ -1560,7 +1560,6 @@
 	}
 	up(&ide_setting_sem);
 
-	ide_init_drive_cmd (&rq);
 	switch (cmd) {
 		case HDIO_GETGEO:
 		{
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.21-pre7/include/linux/blkdev.h linux-2.4.21-pre7/include/linux/blkdev.h
--- /opt/kernel/linux-2.4.21-pre7/include/linux/blkdev.h	2003-04-14 10:48:24.000000000 +0200
+++ linux-2.4.21-pre7/include/linux/blkdev.h	2003-04-14 11:26:31.000000000 +0200
@@ -15,6 +15,12 @@
 struct elevator_s;
 typedef struct elevator_s elevator_t;
 
+struct request_list {
+	unsigned int count;
+	wait_queue_head_t *wait;
+	struct list_head free;
+};
+
 /*
  * Ok, this is an expanded form so that we can use the same
  * request for paging requests.
@@ -46,6 +52,7 @@
 	struct buffer_head * bh;
 	struct buffer_head * bhtail;
 	request_queue_t *q;
+	struct request_list *rl;
 };
 
 #include <linux/elevator.h>
@@ -70,11 +77,6 @@
  */
 #define QUEUE_NR_REQUESTS	8192
 
-struct request_list {
-	unsigned int count;
-	struct list_head free;
-};
-
 struct request_queue
 {
 	/*
@@ -217,6 +219,7 @@
 extern void generic_make_request(int rw, struct buffer_head * bh);
 extern inline request_queue_t *blk_get_queue(kdev_t dev);
 extern void blkdev_release_request(struct request *);
+extern struct request *blk_get_request(request_queue_t *, int, int);
 
 /*
  * Access functions for manipulating queue properties

-- 
Jens Axboe

