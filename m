Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVHOEQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVHOEQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 00:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHOEQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 00:16:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55193 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750788AbVHOEQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 00:16:06 -0400
Date: Sun, 14 Aug 2005 21:16:03 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: 2.6.13 ub 4: Zaitcev's quasi-S/G
Message-Id: <20050814211603.1985bae9.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back out Axboe-style quasi-S/G and replace it with one command and
repeated URBs. This is similar to what usb-storage does, only instead
of a few URBs allocated together, one URB is reused.

Jens's idea was very nice, but it collapsed when I had to support
packet commads for CD burning. I cannot issue two or more packet
commands where application expected only one.

However, burning does not work completely yet. The cdrecord starts,
recognizes the device, then aborts without writing a TOC.

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>

--- linux-2.6.13-rc6-gregkh/drivers/block/ub.c	2005-08-14 21:02:39.000000000 -0700
+++ linux-2.6.13-rc4-lem/drivers/block/ub.c	2005-08-14 20:45:52.000000000 -0700
@@ -235,27 +235,16 @@ struct ub_scsi_cmd {
 
 	int stat_count;			/* Retries getting status. */
 
-	/*
-	 * We do not support transfers from highmem pages
-	 * because the underlying USB framework does not do what we need.
-	 */
-	char *data;			/* Requested buffer */
 	unsigned int len;		/* Requested length */
+	unsigned int current_sg;
+	unsigned int nsg;		/* sgv[nsg] */
+	struct scatterlist sgv[UB_MAX_REQ_SG];
 
 	struct ub_lun *lun;
 	void (*done)(struct ub_dev *, struct ub_scsi_cmd *);
 	void *back;
 };
 
-struct ub_request {
-	struct request *rq;
-	unsigned char dir;
-	unsigned int current_block;
-	unsigned int current_sg;
-	unsigned int nsg;		/* sgv[nsg] */
-	struct scatterlist sgv[UB_MAX_REQ_SG];
-};
-
 /*
  */
 struct ub_capacity {
@@ -351,8 +340,6 @@ struct ub_lun {
 	int readonly;
 	int first_open;			/* Kludge. See ub_bd_open. */
 
-	struct ub_request urq;
-
 	/* Use Ingo's mempool if or when we have more than one command. */
 	/*
 	 * Currently we never need more than one command for the whole device.
@@ -410,19 +397,16 @@ static void ub_cleanup(struct ub_dev *sc
 static int ub_request_fn_1(struct ub_lun *lun, struct request *rq);
 static int ub_cmd_build_block(struct ub_dev *sc, struct ub_lun *lun,
     struct ub_scsi_cmd *cmd, struct request *rq);
-static void ub_scsi_build_block(struct ub_lun *lun,
-    struct ub_scsi_cmd *cmd, struct ub_request *urq);
 static int ub_cmd_build_packet(struct ub_dev *sc, struct ub_lun *lun,
     struct ub_scsi_cmd *cmd, struct request *rq);
 static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_end_rq(struct request *rq, int uptodate);
-static int ub_request_advance(struct ub_dev *sc, struct ub_lun *lun,
-    struct ub_request *urq, struct ub_scsi_cmd *cmd);
 static int ub_submit_scsi(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_urb_complete(struct urb *urb, struct pt_regs *pt);
 static void ub_scsi_action(unsigned long _dev);
 static void ub_scsi_dispatch(struct ub_dev *sc);
 static void ub_scsi_urb_compl(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
+static void ub_data_start(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_state_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd, int rc);
 static int __ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
 static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
@@ -793,8 +777,6 @@ static int ub_request_fn_1(struct ub_lun
 		return 0;
 	}
 
-	if (lun->urq.rq != NULL)
-		return -1;
 	if ((cmd = ub_get_cmd(lun)) == NULL)
 		return -1;
 	memset(cmd, 0, sizeof(struct ub_scsi_cmd));
@@ -813,7 +795,7 @@ static int ub_request_fn_1(struct ub_lun
 	cmd->state = UB_CMDST_INIT;
 	cmd->lun = lun;
 	cmd->done = ub_rw_cmd_done;
-	cmd->back = &lun->urq;
+	cmd->back = rq;
 
 	cmd->tag = sc->tagcnt++;
 	if (ub_submit_scsi(sc, cmd) != 0) {
@@ -828,22 +810,20 @@ static int ub_request_fn_1(struct ub_lun
 static int ub_cmd_build_block(struct ub_dev *sc, struct ub_lun *lun,
     struct ub_scsi_cmd *cmd, struct request *rq)
 {
-	struct ub_request *urq;
 	int ub_dir;
 	int n_elem;
-
-	urq = &lun->urq;
-	memset(urq, 0, sizeof(struct ub_request));
+	unsigned int block, nblks;
 
 	if (rq_data_dir(rq) == WRITE)
 		ub_dir = UB_DIR_WRITE;
 	else
 		ub_dir = UB_DIR_READ;
+	cmd->dir = ub_dir;
 
 	/*
 	 * get scatterlist from block layer
 	 */
-	n_elem = blk_rq_map_sg(lun->disk->queue, rq, &urq->sgv[0]);
+	n_elem = blk_rq_map_sg(lun->disk->queue, rq, &cmd->sgv[0]);
 	if (n_elem <= 0) {
 		printk(KERN_INFO "%s: failed request map (%d)\n",
 		    sc->name, n_elem); /* P3 */
@@ -854,7 +834,7 @@ static int ub_cmd_build_block(struct ub_
 		    sc->name, n_elem);
 		return -1;
 	}
-	urq->nsg = n_elem;
+	cmd->nsg = n_elem;
 	sc->sg_stat[n_elem]++;
 
 	/*
@@ -863,29 +843,10 @@ static int ub_cmd_build_block(struct ub_
 	 * The call to blk_queue_hardsect_size() guarantees that request
 	 * is aligned, but it is given in terms of 512 byte units, always.
 	 */
-	urq->current_block = rq->sector >> lun->capacity.bshift;
-	// nblks = rq->nr_sectors >> lun->capacity.bshift;
-
-	urq->rq = rq;
-	urq->current_sg = 0;
-	urq->dir = ub_dir;
+	block = rq->sector >> lun->capacity.bshift;
+	nblks = rq->nr_sectors >> lun->capacity.bshift;
 
-	ub_scsi_build_block(lun, cmd, urq);
-	return 0;
-}
-
-static void ub_scsi_build_block(struct ub_lun *lun,
-    struct ub_scsi_cmd *cmd, struct ub_request *urq)
-{
-	struct scatterlist *sg;
-	unsigned int block, nblks;
-
-	sg = &urq->sgv[urq->current_sg];
-
-	block = urq->current_block;
-	nblks = sg->length >> (lun->capacity.bshift + 9);
-
-	cmd->cdb[0] = (urq->dir == UB_DIR_READ)? READ_10: WRITE_10;
+	cmd->cdb[0] = (ub_dir == UB_DIR_READ)? READ_10: WRITE_10;
 	/* 10-byte uses 4 bytes of LBA: 2147483648KB, 2097152MB, 2048GB */
 	cmd->cdb[2] = block >> 24;
 	cmd->cdb[3] = block >> 16;
@@ -895,34 +856,15 @@ static void ub_scsi_build_block(struct u
 	cmd->cdb[8] = nblks;
 	cmd->cdb_len = 10;
 
-	cmd->dir = urq->dir;
-	cmd->data = page_address(sg->page) + sg->offset;
-	cmd->len = sg->length;
+	cmd->len = rq->nr_sectors * 512;
+
+	return 0;
 }
 
 static int ub_cmd_build_packet(struct ub_dev *sc, struct ub_lun *lun,
     struct ub_scsi_cmd *cmd, struct request *rq)
 {
-	struct ub_request *urq;
-
-	urq = &lun->urq;
-	memset(urq, 0, sizeof(struct ub_request));
-	urq->rq = rq;
-	sc->sg_stat[0]++;
-
-	if (rq->data_len != 0 && rq->data == NULL) {
-		static int do_print = 1;
-		if (do_print) {
-			printk(KERN_WARNING "%s: unmapped packet request"
-			    " flags 0x%lx length %d\n",
-			    sc->name, rq->flags, rq->data_len);
-			do_print = 0;
-		}
-		return -1;
-	}
-
-	memcpy(&cmd->cdb, rq->cmd, rq->cmd_len);
-	cmd->cdb_len = rq->cmd_len;
+	int n_elem;
 
 	if (rq->data_len == 0) {
 		cmd->dir = UB_DIR_NONE;
@@ -931,8 +873,29 @@ static int ub_cmd_build_packet(struct ub
 			cmd->dir = UB_DIR_WRITE;
 		else
 			cmd->dir = UB_DIR_READ;
+
 	}
-	cmd->data = rq->data;
+
+	/*
+	 * get scatterlist from block layer
+	 */
+	n_elem = blk_rq_map_sg(lun->disk->queue, rq, &cmd->sgv[0]);
+	if (n_elem < 0) {
+		printk(KERN_INFO "%s: failed request map (%d)\n",
+		    sc->name, n_elem); /* P3 */
+		return -1;
+	}
+	if (n_elem > UB_MAX_REQ_SG) {	/* Paranoia */
+		printk(KERN_WARNING "%s: request with %d segments\n",
+		    sc->name, n_elem);
+		return -1;
+	}
+	cmd->nsg = n_elem;
+	sc->sg_stat[n_elem]++;
+
+	memcpy(&cmd->cdb, rq->cmd, rq->cmd_len);
+	cmd->cdb_len = rq->cmd_len;
+
 	cmd->len = rq->data_len;
 
 	return 0;
@@ -940,33 +903,32 @@ static int ub_cmd_build_packet(struct ub
 
 static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
 {
+	struct request *rq = cmd->back;
 	struct ub_lun *lun = cmd->lun;
-	struct ub_request *urq = cmd->back;
-	struct request *rq;
 	int uptodate;
 
-	rq = urq->rq;
-
-	if (blk_pc_request(rq)) {
-		/* UB_SENSE_SIZE is smaller than SCSI_SENSE_BUFFERSIZE */
-		memcpy(rq->sense, sc->top_sense, UB_SENSE_SIZE);
-		rq->sense_len = UB_SENSE_SIZE;
-	}
-
-	if (cmd->error == 0)
+	if (cmd->error == 0) {
 		uptodate = 1;
-	else
-		uptodate = 0;
 
-	if (cmd->error == 0 && urq->current_sg+1 < urq->nsg) {
-		if (ub_request_advance(sc, lun, urq, cmd) == 0) {
-			/* Stay on target... */
-			return;
+		if (blk_pc_request(rq)) {
+			if (cmd->act_len >= rq->data_len)
+				rq->data_len = 0;
+			else
+				rq->data_len -= cmd->act_len;
 		}
+	} else {
 		uptodate = 0;
-	}
 
-	urq->rq = NULL;
+		if (blk_pc_request(rq)) {
+			/* UB_SENSE_SIZE is smaller than SCSI_SENSE_BUFFERSIZE */
+			memcpy(rq->sense, sc->top_sense, UB_SENSE_SIZE);
+			rq->sense_len = UB_SENSE_SIZE;
+			if (sc->top_sense[0] != 0)
+				rq->errors = SAM_STAT_CHECK_CONDITION;
+			else
+				rq->errors = DID_ERROR << 16;
+		}
+	}
 
 	ub_put_cmd(lun, cmd);
 	ub_end_rq(rq, uptodate);
@@ -982,40 +944,6 @@ static void ub_end_rq(struct request *rq
 	end_that_request_last(rq);
 }
 
-static int ub_request_advance(struct ub_dev *sc, struct ub_lun *lun,
-    struct ub_request *urq, struct ub_scsi_cmd *cmd)
-{
-	struct scatterlist *sg;
-	unsigned int nblks;
-
-	/* XXX This is temporary, until we sort out S/G in packet requests. */
-	if (blk_pc_request(urq->rq)) {
-		printk(KERN_WARNING
-		    "2-segment packet request completed\n"); /* P3 */
-		return -1;
-	}
-
-	sg = &urq->sgv[urq->current_sg];
-	nblks = sg->length >> (lun->capacity.bshift + 9);
-	urq->current_block += nblks;
-	urq->current_sg++;
-	sg++;
-
-	memset(cmd, 0, sizeof(struct ub_scsi_cmd));
-	ub_scsi_build_block(lun, cmd, urq);
-	cmd->state = UB_CMDST_INIT;
-	cmd->lun = lun;
-	cmd->done = ub_rw_cmd_done;
-	cmd->back = &lun->urq;
-
-	cmd->tag = sc->tagcnt++;
-	if (ub_submit_scsi(sc, cmd) != 0) {
-		return -1;
-	}
-
-	return 0;
-}
-
 /*
  * Submit a regular SCSI operation (not an auto-sense).
  *
@@ -1171,7 +1099,6 @@ static void ub_scsi_urb_compl(struct ub_
 {
 	struct urb *urb = &sc->work_urb;
 	struct bulk_cs_wrap *bcs;
-	int pipe;
 	int rc;
 
 	if (atomic_read(&sc->poison)) {
@@ -1272,38 +1199,13 @@ static void ub_scsi_urb_compl(struct ub_
 			goto Bad_End;
 		}
 
-		if (cmd->dir == UB_DIR_NONE) {
+		if (cmd->dir == UB_DIR_NONE || cmd->nsg < 1) {
 			ub_state_stat(sc, cmd);
 			return;
 		}
 
-		UB_INIT_COMPLETION(sc->work_done);
-
-		if (cmd->dir == UB_DIR_READ)
-			pipe = sc->recv_bulk_pipe;
-		else
-			pipe = sc->send_bulk_pipe;
-		sc->last_pipe = pipe;
-		usb_fill_bulk_urb(&sc->work_urb, sc->dev, pipe,
-		    cmd->data, cmd->len, ub_urb_complete, sc);
-		sc->work_urb.transfer_flags = URB_ASYNC_UNLINK;
-		sc->work_urb.actual_length = 0;
-		sc->work_urb.error_count = 0;
-		sc->work_urb.status = 0;
-
-		if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
-			/* XXX Clear stalls */
-			printk("ub: data #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
-			ub_complete(&sc->work_done);
-			ub_state_done(sc, cmd, rc);
-			return;
-		}
-
-		sc->work_timer.expires = jiffies + UB_DATA_TIMEOUT;
-		add_timer(&sc->work_timer);
-
-		cmd->state = UB_CMDST_DATA;
-		ub_cmdtr_state(sc, cmd);
+		// udelay(125);		// usb-storage has this
+		ub_data_start(sc, cmd);
 
 	} else if (cmd->state == UB_CMDST_DATA) {
 		if (urb->status == -EPIPE) {
@@ -1325,16 +1227,22 @@ static void ub_scsi_urb_compl(struct ub_
 		if (urb->status == -EOVERFLOW) {
 			/*
 			 * A babble? Failure, but we must transfer CSW now.
+			 * XXX This is going to end in perpetual babble. Reset.
 			 */
 			cmd->error = -EOVERFLOW;	/* A cheap trick... */
-		} else {
-			if (urb->status != 0)
-				goto Bad_End;
+			ub_state_stat(sc, cmd);
+			return;
 		}
+		if (urb->status != 0)
+			goto Bad_End;
 
-		cmd->act_len = urb->actual_length;
+		cmd->act_len += urb->actual_length;
 		ub_cmdtr_act_len(sc, cmd);
 
+		if (++cmd->current_sg < cmd->nsg) {
+			ub_data_start(sc, cmd);
+			return;
+		}
 		ub_state_stat(sc, cmd);
 
 	} else if (cmd->state == UB_CMDST_STAT) {
@@ -1469,6 +1377,46 @@ Bad_End: /* Little Excel is dead */
 
 /*
  * Factorization helper for the command state machine:
+ * Initiate a data segment transfer.
+ */
+static void ub_data_start(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+{
+	struct scatterlist *sg = &cmd->sgv[cmd->current_sg];
+	int pipe;
+	int rc;
+
+	UB_INIT_COMPLETION(sc->work_done);
+
+	if (cmd->dir == UB_DIR_READ)
+		pipe = sc->recv_bulk_pipe;
+	else
+		pipe = sc->send_bulk_pipe;
+	sc->last_pipe = pipe;
+	usb_fill_bulk_urb(&sc->work_urb, sc->dev, pipe,
+	    page_address(sg->page) + sg->offset, sg->length,
+	    ub_urb_complete, sc);
+	sc->work_urb.transfer_flags = URB_ASYNC_UNLINK;
+	sc->work_urb.actual_length = 0;
+	sc->work_urb.error_count = 0;
+	sc->work_urb.status = 0;
+
+	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
+		/* XXX Clear stalls */
+		printk("ub: data #%d submit failed (%d)\n", cmd->tag, rc); /* P3 */
+		ub_complete(&sc->work_done);
+		ub_state_done(sc, cmd, rc);
+		return;
+	}
+
+	sc->work_timer.expires = jiffies + UB_DATA_TIMEOUT;
+	add_timer(&sc->work_timer);
+
+	cmd->state = UB_CMDST_DATA;
+	ub_cmdtr_state(sc, cmd);
+}
+
+/*
+ * Factorization helper for the command state machine:
  * Finish the command.
  */
 static void ub_state_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd, int rc)
@@ -1552,6 +1500,7 @@ static void ub_state_stat_counted(struct
 static void ub_state_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
 {
 	struct ub_scsi_cmd *scmd;
+	struct scatterlist *sg;
 	int rc;
 
 	if (cmd->cdb[0] == REQUEST_SENSE) {
@@ -1560,12 +1509,17 @@ static void ub_state_sense(struct ub_dev
 	}
 
 	scmd = &sc->top_rqs_cmd;
+	memset(scmd, 0, sizeof(struct ub_scsi_cmd));
 	scmd->cdb[0] = REQUEST_SENSE;
 	scmd->cdb[4] = UB_SENSE_SIZE;
 	scmd->cdb_len = 6;
 	scmd->dir = UB_DIR_READ;
 	scmd->state = UB_CMDST_INIT;
-	scmd->data = sc->top_sense;
+	scmd->nsg = 1;
+	sg = &scmd->sgv[0];
+	sg->page = virt_to_page(sc->top_sense);
+	sg->offset = (unsigned int)sc->top_sense & (PAGE_SIZE-1);
+	sg->length = UB_SENSE_SIZE;
 	scmd->len = UB_SENSE_SIZE;
 	scmd->lun = cmd->lun;
 	scmd->done = ub_top_sense_done;
@@ -1628,7 +1582,7 @@ static int ub_submit_clear_stall(struct 
  */
 static void ub_top_sense_done(struct ub_dev *sc, struct ub_scsi_cmd *scmd)
 {
-	unsigned char *sense = scmd->data;
+	unsigned char *sense = sc->top_sense;
 	struct ub_scsi_cmd *cmd;
 
 	/*
@@ -1920,6 +1874,7 @@ static int ub_sync_read_cap(struct ub_de
     struct ub_capacity *ret)
 {
 	struct ub_scsi_cmd *cmd;
+	struct scatterlist *sg;
 	char *p;
 	enum { ALLOC_SIZE = sizeof(struct ub_scsi_cmd) + 8 };
 	unsigned long flags;
@@ -1940,7 +1895,11 @@ static int ub_sync_read_cap(struct ub_de
 	cmd->cdb_len = 10;
 	cmd->dir = UB_DIR_READ;
 	cmd->state = UB_CMDST_INIT;
-	cmd->data = p;
+	cmd->nsg = 1;
+	sg = &cmd->sgv[0];
+	sg->page = virt_to_page(p);
+	sg->offset = (unsigned int)p & (PAGE_SIZE-1);
+	sg->length = 8;
 	cmd->len = 8;
 	cmd->lun = lun;
 	cmd->done = ub_probe_done;
