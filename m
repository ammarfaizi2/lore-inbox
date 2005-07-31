Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVGaFjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVGaFjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVGaFjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:39:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4065 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261728AbVGaFij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:38:39 -0400
Date: Sat, 30 Jul 2005 22:38:30 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: 2.6.13 ub 1/3: Axboe's quasi-S/G
Message-Id: <20050730223830.7513a5f1.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This the quasi-S/G patch for ub as suggested by Jens Axboe at OLS and
implemented that night before 4 a.m. Surprisingly, it worked right away...
Alas, I had to skip some OLS partying, but it was for the good cause.
Now the speed of ub is quite acceptable even on partitions with small
block size.

The ub does not really support S/G. Instead, it just tells the block
layer that it does. Then, most of the time, the block layer merges
requests and passes single-segmnent requests down to ub; everything
works as before. Very rarely ub gets an unmerged S/G request. In such
case, it issues several commands to the device.

I added a small array of counters to monitor the merging (sg_stat).
This may be dropped later.

This patch is intended to be merged with 2.6.13 when that is available.

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>

diff -urp -X dontdiff linux-2.6.13-rc4/drivers/block/ub.c linux-2.6.13-rc4-4seg/drivers/block/ub.c
--- linux-2.6.13-rc4/drivers/block/ub.c	2005-07-29 19:51:00.000000000 -0700
+++ linux-2.6.13-rc4-4seg/drivers/block/ub.c	2005-07-30 22:19:55.000000000 -0700
@@ -16,9 +16,10 @@
  *  -- verify the 13 conditions and do bulk resets
  *  -- kill last_pipe and simply do two-state clearing on both pipes
  *  -- verify protocol (bulk) from USB descriptors (maybe...)
- *  -- highmem and sg
+ *  -- highmem
  *  -- move top_sense and work_bcs into separate allocations (if they survive)
  *     for cache purists and esoteric architectures.
+ *  -- Allocate structure for LUN 0 before the first ub_sync_tur, avoid NULL. ?
  *  -- prune comments, they are too volumnous
  *  -- Exterminate P3 printks
  *  -- Resove XXX's
@@ -171,7 +172,7 @@ struct bulk_cs_wrap {
  */
 struct ub_dev;
 
-#define UB_MAX_REQ_SG	1
+#define UB_MAX_REQ_SG	4
 #define UB_MAX_SECTORS 64
 
 /*
@@ -240,13 +241,21 @@ struct ub_scsi_cmd {
 	 */
 	char *data;			/* Requested buffer */
 	unsigned int len;		/* Requested length */
-	// struct scatterlist sgv[UB_MAX_REQ_SG];
 
 	struct ub_lun *lun;
 	void (*done)(struct ub_dev *, struct ub_scsi_cmd *);
 	void *back;
 };
 
+struct ub_request {
+	struct request *rq;
+	unsigned char dir;
+	unsigned int current_block;
+	unsigned int current_sg;
+	unsigned int nsg;		/* sgv[nsg] */
+	struct scatterlist sgv[UB_MAX_REQ_SG];
+};
+
 /*
  */
 struct ub_capacity {
@@ -342,6 +351,8 @@ struct ub_lun {
 	int readonly;
 	int first_open;			/* Kludge. See ub_bd_open. */
 
+	struct ub_request urq;
+
 	/* Use Ingo's mempool if or when we have more than one command. */
 	/*
 	 * Currently we never need more than one command for the whole device.
@@ -389,6 +400,7 @@ struct ub_dev {
 	struct bulk_cs_wrap work_bcs;
 	struct usb_ctrlrequest work_cr;
 
+	int sg_stat[UB_MAX_REQ_SG+1];
 	struct ub_scsi_trace tr;
 };
 
@@ -398,10 +410,14 @@ static void ub_cleanup(struct ub_dev *sc
 static int ub_bd_rq_fn_1(struct ub_lun *lun, struct request *rq);
 static int ub_cmd_build_block(struct ub_dev *sc, struct ub_lun *lun,
     struct ub_scsi_cmd *cmd, struct request *rq);
-static int ub_cmd_build_packet(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
-    struct request *rq);
+static void ub_scsi_build_block(struct ub_lun *lun,
+    struct ub_scsi_cmd *cmd, struct ub_request *urq);
+static int ub_cmd_build_packet(struct ub_dev *sc, struct ub_lun *lun,
+    struct ub_scsi_cmd *cmd, struct request *rq);
 static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_end_rq(struct request *rq, int uptodate);
+static int ub_request_advance(struct ub_dev *sc, struct ub_lun *lun,
+    struct ub_request *urq, struct ub_scsi_cmd *cmd);
 static int ub_submit_scsi(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_urb_complete(struct urb *urb, struct pt_regs *pt);
 static void ub_scsi_action(unsigned long _dev);
@@ -523,6 +539,13 @@ static ssize_t ub_diag_show(struct devic
 	cnt += sprintf(page + cnt,
 	    "qlen %d qmax %d\n",
 	    sc->cmd_queue.qlen, sc->cmd_queue.qmax);
+	cnt += sprintf(page + cnt,
+	    "sg %d %d %d %d %d\n",
+	    sc->sg_stat[0],
+	    sc->sg_stat[1],
+	    sc->sg_stat[2],
+	    sc->sg_stat[3],
+	    sc->sg_stat[4]);
 
 	list_for_each (p, &sc->luns) {
 		lun = list_entry(p, struct ub_lun, link);
@@ -769,14 +792,15 @@ static int ub_bd_rq_fn_1(struct ub_lun *
 		return 0;
 	}
 
+	if (lun->urq.rq != NULL)
+		return -1;
 	if ((cmd = ub_get_cmd(lun)) == NULL)
 		return -1;
 	memset(cmd, 0, sizeof(struct ub_scsi_cmd));
 
 	blkdev_dequeue_request(rq);
-
 	if (blk_pc_request(rq)) {
-		rc = ub_cmd_build_packet(sc, cmd, rq);
+		rc = ub_cmd_build_packet(sc, lun, cmd, rq);
 	} else {
 		rc = ub_cmd_build_block(sc, lun, cmd, rq);
 	}
@@ -788,10 +812,10 @@ static int ub_bd_rq_fn_1(struct ub_lun *
 	cmd->state = UB_CMDST_INIT;
 	cmd->lun = lun;
 	cmd->done = ub_rw_cmd_done;
-	cmd->back = rq;
+	cmd->back = &lun->urq;
 
 	cmd->tag = sc->tagcnt++;
-	if ((rc = ub_submit_scsi(sc, cmd)) != 0) {
+	if (ub_submit_scsi(sc, cmd) != 0) {
 		ub_put_cmd(lun, cmd);
 		ub_end_rq(rq, 0);
 		return 0;
@@ -803,12 +827,12 @@ static int ub_bd_rq_fn_1(struct ub_lun *
 static int ub_cmd_build_block(struct ub_dev *sc, struct ub_lun *lun,
     struct ub_scsi_cmd *cmd, struct request *rq)
 {
+	struct ub_request *urq;
 	int ub_dir;
-#if 0 /* We use rq->buffer for now */
-	struct scatterlist *sg;
 	int n_elem;
-#endif
-	unsigned int block, nblks;
+
+	urq = &lun->urq;
+	memset(urq, 0, sizeof(struct ub_request));
 
 	if (rq_data_dir(rq) == WRITE)
 		ub_dir = UB_DIR_WRITE;
@@ -818,44 +842,19 @@ static int ub_cmd_build_block(struct ub_
 	/*
 	 * get scatterlist from block layer
 	 */
-#if 0 /* We use rq->buffer for now */
-	sg = &cmd->sgv[0];
-	n_elem = blk_rq_map_sg(q, rq, sg);
+	n_elem = blk_rq_map_sg(lun->disk->queue, rq, &urq->sgv[0]);
 	if (n_elem <= 0) {
-		ub_put_cmd(lun, cmd);
-		ub_end_rq(rq, 0);
-		blk_start_queue(q);
-		return 0;		/* request with no s/g entries? */
+		printk(KERN_INFO "%s: failed request map (%d)\n",
+		    sc->name, n_elem); /* P3 */
+		return -1;		/* request with no s/g entries? */
 	}
-
-	if (n_elem != 1) {		/* Paranoia */
+	if (n_elem > UB_MAX_REQ_SG) {	/* Paranoia */
 		printk(KERN_WARNING "%s: request with %d segments\n",
 		    sc->name, n_elem);
-		ub_put_cmd(lun, cmd);
-		ub_end_rq(rq, 0);
-		blk_start_queue(q);
-		return 0;
-	}
-#endif
-
-	/*
-	 * XXX Unfortunately, this check does not work. It is quite possible
-	 * to get bogus non-null rq->buffer if you allow sg by mistake.
-	 */
-	if (rq->buffer == NULL) {
-		/*
-		 * This must not happen if we set the queue right.
-		 * The block level must create bounce buffers for us.
-		 */
-		static int do_print = 1;
-		if (do_print) {
-			printk(KERN_WARNING "%s: unmapped block request"
-			    " flags 0x%lx sectors %lu\n",
-			    sc->name, rq->flags, rq->nr_sectors);
-			do_print = 0;
-		}
 		return -1;
 	}
+	urq->nsg = n_elem;
+	sc->sg_stat[n_elem]++;
 
 	/*
 	 * build the command
@@ -863,10 +862,29 @@ static int ub_cmd_build_block(struct ub_
 	 * The call to blk_queue_hardsect_size() guarantees that request
 	 * is aligned, but it is given in terms of 512 byte units, always.
 	 */
-	block = rq->sector >> lun->capacity.bshift;
-	nblks = rq->nr_sectors >> lun->capacity.bshift;
+	urq->current_block = rq->sector >> lun->capacity.bshift;
+	// nblks = rq->nr_sectors >> lun->capacity.bshift;
+
+	urq->rq = rq;
+	urq->current_sg = 0;
+	urq->dir = ub_dir;
+
+	ub_scsi_build_block(lun, cmd, urq);
+	return 0;
+}
+
+static void ub_scsi_build_block(struct ub_lun *lun,
+    struct ub_scsi_cmd *cmd, struct ub_request *urq)
+{
+	struct scatterlist *sg;
+	unsigned int block, nblks;
+
+	sg = &urq->sgv[urq->current_sg];
+
+	block = urq->current_block;
+	nblks = sg->length >> (lun->capacity.bshift + 9);
 
-	cmd->cdb[0] = (ub_dir == UB_DIR_READ)? READ_10: WRITE_10;
+	cmd->cdb[0] = (urq->dir == UB_DIR_READ)? READ_10: WRITE_10;
 	/* 10-byte uses 4 bytes of LBA: 2147483648KB, 2097152MB, 2048GB */
 	cmd->cdb[2] = block >> 24;
 	cmd->cdb[3] = block >> 16;
@@ -876,16 +894,20 @@ static int ub_cmd_build_block(struct ub_
 	cmd->cdb[8] = nblks;
 	cmd->cdb_len = 10;
 
-	cmd->dir = ub_dir;
-	cmd->data = rq->buffer;
-	cmd->len = rq->nr_sectors * 512;
-
-	return 0;
+	cmd->dir = urq->dir;
+	cmd->data = page_address(sg->page) + sg->offset;
+	cmd->len = sg->length;
 }
 
-static int ub_cmd_build_packet(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
-    struct request *rq)
+static int ub_cmd_build_packet(struct ub_dev *sc, struct ub_lun *lun,
+    struct ub_scsi_cmd *cmd, struct request *rq)
 {
+	struct ub_request *urq;
+
+	urq = &lun->urq;
+	memset(urq, 0, sizeof(struct ub_request));
+	urq->rq = rq;
+	sc->sg_stat[0]++;
 
 	if (rq->data_len != 0 && rq->data == NULL) {
 		static int do_print = 1;
@@ -917,12 +939,13 @@ static int ub_cmd_build_packet(struct ub
 
 static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
 {
-	struct request *rq = cmd->back;
 	struct ub_lun *lun = cmd->lun;
-	struct gendisk *disk = lun->disk;
-	request_queue_t *q = disk->queue;
+	struct ub_request *urq = cmd->back;
+	struct request *rq;
 	int uptodate;
 
+	rq = urq->rq;
+
 	if (blk_pc_request(rq)) {
 		/* UB_SENSE_SIZE is smaller than SCSI_SENSE_BUFFERSIZE */
 		memcpy(rq->sense, sc->top_sense, UB_SENSE_SIZE);
@@ -934,9 +957,19 @@ static void ub_rw_cmd_done(struct ub_dev
 	else
 		uptodate = 0;
 
+	if (cmd->error == 0 && urq->current_sg+1 < urq->nsg) {
+		if (ub_request_advance(sc, lun, urq, cmd) == 0) {
+			/* Stay on target... */
+			return;
+		}
+		uptodate = 0;
+	}
+
+	urq->rq = NULL;
+
 	ub_put_cmd(lun, cmd);
 	ub_end_rq(rq, uptodate);
-	blk_start_queue(q);
+	blk_start_queue(lun->disk->queue);
 }
 
 static void ub_end_rq(struct request *rq, int uptodate)
@@ -948,6 +981,40 @@ static void ub_end_rq(struct request *rq
 	end_that_request_last(rq);
 }
 
+static int ub_request_advance(struct ub_dev *sc, struct ub_lun *lun,
+    struct ub_request *urq, struct ub_scsi_cmd *cmd)
+{
+	struct scatterlist *sg;
+	unsigned int nblks;
+
+	/* XXX This is temporary, until we sort out S/G in packet requests. */
+	if (blk_pc_request(urq->rq)) {
+		printk(KERN_WARNING
+		    "2-segment packet request completed\n"); /* P3 */
+		return -1;
+	}
+
+	sg = &urq->sgv[urq->current_sg];
+	nblks = sg->length >> (lun->capacity.bshift + 9);
+	urq->current_block += nblks;
+	urq->current_sg++;
+	sg++;
+
+	memset(cmd, 0, sizeof(struct ub_scsi_cmd));
+	ub_scsi_build_block(lun, cmd, urq);
+	cmd->state = UB_CMDST_INIT;
+	cmd->lun = lun;
+	cmd->done = ub_rw_cmd_done;
+	cmd->back = &lun->urq;
+
+	cmd->tag = sc->tagcnt++;
+	if (ub_submit_scsi(sc, cmd) != 0) {
+		return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Submit a regular SCSI operation (not an auto-sense).
  *

-- Pete
