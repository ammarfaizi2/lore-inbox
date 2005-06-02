Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVFBQ7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVFBQ7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFBQ7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:59:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261200AbVFBQ4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:56:55 -0400
Date: Thu, 2 Jun 2005 09:56:51 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Support multiply-LUN devices in ub
Message-Id: <20050602095651.351eca48.zaitcev@redhat.com>
In-Reply-To: <20050502230452.GA5186@kroah.com>
References: <20050501160540.5b2f4e61.zaitcev@redhat.com>
	<20050502230452.GA5186@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005 16:04:52 -0700, Greg KH <greg@kroah.com> wrote:
> On Sun, May 01, 2005 at 04:05:40PM -0700, Pete Zaitcev wrote:
> > Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
> 
> Applied, thanks.

This is not present in 2.6.12-rc5-git7, but other USB fixes are.
Did you drop it?

-- Pete

--- linux-2.6.12-rc5-git7/drivers/block/ub.c	2005-06-02 09:22:39.000000000 -0700
+++ linux-2.6.12-rc4-lem/drivers/block/ub.c	2005-06-02 09:30:04.000000000 -0700
@@ -8,13 +8,12 @@
  * and is not licensed separately. See file COPYING for details.
  *
  * TODO (sorted by decreasing priority)
+ *  -- Kill first_open (Al Viro fixed the block layer now)
  *  -- Do resets with usb_device_reset (needs a thread context, use khubd)
  *  -- set readonly flag for CDs, set removable flag for CF readers
  *  -- do inquiry and verify we got a disk and not a tape (for LUN mismatch)
- *  -- support pphaneuf's SDDR-75 with two LUNs (also broken capacity...)
  *  -- special case some senses, e.g. 3a/0 -> no media present, reduce retries
  *  -- verify the 13 conditions and do bulk resets
- *  -- normal pool of commands instead of cmdv[]?
  *  -- kill last_pipe and simply do two-state clearing on both pipes
  *  -- verify protocol (bulk) from USB descriptors (maybe...)
  *  -- highmem and sg
@@ -49,7 +48,14 @@
 #define US_SC_SCSI	0x06		/* Transparent */
 
 /*
+ * This many LUNs per USB device.
+ * Every one of them takes a host, see UB_MAX_HOSTS.
  */
+#define UB_MAX_LUNS   9
+
+/*
+ */
+
 #define UB_MINORS_PER_MAJOR	8
 
 #define UB_MAX_CDB_SIZE      16		/* Corresponds to Bulk */
@@ -65,7 +71,7 @@ struct bulk_cb_wrap {
 	u32	Tag;			/* unique per command id */
 	__le32	DataTransferLength;	/* size of data */
 	u8	Flags;			/* direction in bit 0 */
-	u8	Lun;			/* LUN normally 0 */
+	u8	Lun;			/* LUN */
 	u8	Length;			/* of of the CDB */
 	u8	CDB[UB_MAX_CDB_SIZE];	/* max command */
 };
@@ -168,6 +174,7 @@ struct ub_scsi_cmd {
 	unsigned int len;		/* Requested length */
 	// struct scatterlist sgv[UB_MAX_REQ_SG];
 
+	struct ub_lun *lun;
 	void (*done)(struct ub_dev *, struct ub_scsi_cmd *);
 	void *back;
 };
@@ -252,25 +259,47 @@ struct ub_scsi_cmd_queue {
 };
 
 /*
- * The UB device instance.
+ * The block device instance (one per LUN).
+ */
+struct ub_lun {
+	struct ub_dev *udev;
+	struct list_head link;
+	struct gendisk *disk;
+	int id;				/* Host index */
+	int num;			/* LUN number */
+	char name[16];
+
+	int changed;			/* Media was changed */
+	int removable;
+	int readonly;
+	int first_open;			/* Kludge. See ub_bd_open. */
+
+	/* Use Ingo's mempool if or when we have more than one command. */
+	/*
+	 * Currently we never need more than one command for the whole device.
+	 * However, giving every LUN a command is a cheap and automatic way
+	 * to enforce fairness between them.
+	 */
+	int cmda[1];
+	struct ub_scsi_cmd cmdv[1];
+
+	struct ub_capacity capacity; 
+};
+
+/*
+ * The USB device instance.
  */
 struct ub_dev {
 	spinlock_t lock;
-	int id;				/* Number among ub's */
 	atomic_t poison;		/* The USB device is disconnected */
 	int openc;			/* protected by ub_lock! */
 					/* kref is too implicit for our taste */
 	unsigned int tagcnt;
-	int changed;			/* Media was changed */
-	int removable;
-	int readonly;
-	int first_open;			/* Kludge. See ub_bd_open. */
-	char name[8];
+	char name[12];
 	struct usb_device *dev;
 	struct usb_interface *intf;
 
-	struct ub_capacity capacity; 
-	struct gendisk *disk;
+	struct list_head luns;
 
 	unsigned int send_bulk_pipe;	/* cached pipe values */
 	unsigned int recv_bulk_pipe;
@@ -279,10 +308,6 @@ struct ub_dev {
 
 	struct tasklet_struct tasklet;
 
-	/* XXX Use Ingo's mempool (once we have more than one) */
-	int cmda[1];
-	struct ub_scsi_cmd cmdv[1];
-
 	struct ub_scsi_cmd_queue cmd_queue;
 	struct ub_scsi_cmd top_rqs_cmd;	/* REQUEST SENSE */
 	unsigned char top_sense[UB_SENSE_SIZE];
@@ -301,9 +326,9 @@ struct ub_dev {
 /*
  */
 static void ub_cleanup(struct ub_dev *sc);
-static int ub_bd_rq_fn_1(struct ub_dev *sc, struct request *rq);
-static int ub_cmd_build_block(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
-    struct request *rq);
+static int ub_bd_rq_fn_1(struct ub_lun *lun, struct request *rq);
+static int ub_cmd_build_block(struct ub_dev *sc, struct ub_lun *lun,
+    struct ub_scsi_cmd *cmd, struct request *rq);
 static int ub_cmd_build_packet(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
     struct request *rq);
 static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
@@ -320,8 +345,10 @@ static void ub_state_sense(struct ub_dev
 static int ub_submit_clear_stall(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
     int stalled_pipe);
 static void ub_top_sense_done(struct ub_dev *sc, struct ub_scsi_cmd *scmd);
-static int ub_sync_tur(struct ub_dev *sc);
-static int ub_sync_read_cap(struct ub_dev *sc, struct ub_capacity *ret);
+static int ub_sync_tur(struct ub_dev *sc, struct ub_lun *lun);
+static int ub_sync_read_cap(struct ub_dev *sc, struct ub_lun *lun,
+    struct ub_capacity *ret);
+static int ub_probe_lun(struct ub_dev *sc, int lnum);
 
 /*
  */
@@ -342,6 +369,7 @@ MODULE_DEVICE_TABLE(usb, ub_usb_ids);
  */
 #define UB_MAX_HOSTS  26
 static char ub_hostv[UB_MAX_HOSTS];
+
 static DEFINE_SPINLOCK(ub_lock);	/* Locks globals and ->openc */
 
 /*
@@ -406,6 +434,8 @@ static ssize_t ub_diag_show(struct devic
 {
 	struct usb_interface *intf;
 	struct ub_dev *sc;
+	struct list_head *p;
+	struct ub_lun *lun;
 	int cnt;
 	unsigned long flags;
 	int nc, nh;
@@ -421,9 +451,15 @@ static ssize_t ub_diag_show(struct devic
 	spin_lock_irqsave(&sc->lock, flags);
 
 	cnt += sprintf(page + cnt,
-	    "qlen %d qmax %d changed %d removable %d readonly %d\n",
-	    sc->cmd_queue.qlen, sc->cmd_queue.qmax,
-	    sc->changed, sc->removable, sc->readonly);
+	    "qlen %d qmax %d\n",
+	    sc->cmd_queue.qlen, sc->cmd_queue.qmax);
+
+	list_for_each (p, &sc->luns) {
+		lun = list_entry(p, struct ub_lun, link);
+		cnt += sprintf(page + cnt,
+		    "lun %u changed %d removable %d readonly %d\n",
+		    lun->num, lun->changed, lun->removable, lun->readonly);
+	}
 
 	if ((nc = sc->tr.cur + 1) == SCMD_TRACE_SZ) nc = 0;
 	for (j = 0; j < SCMD_TRACE_SZ; j++) {
@@ -523,53 +559,63 @@ static void ub_put(struct ub_dev *sc)
  */
 static void ub_cleanup(struct ub_dev *sc)
 {
+	struct list_head *p;
+	struct ub_lun *lun;
 	request_queue_t *q;
 
-	/* I don't think queue can be NULL. But... Stolen from sx8.c */
-	if ((q = sc->disk->queue) != NULL)
-		blk_cleanup_queue(q);
-
-	/*
-	 * If we zero disk->private_data BEFORE put_disk, we have to check
-	 * for NULL all over the place in open, release, check_media and
-	 * revalidate, because the block level semaphore is well inside the
-	 * put_disk. But we cannot zero after the call, because *disk is gone.
-	 * The sd.c is blatantly racy in this area.
-	 */
-	/* disk->private_data = NULL; */
-	put_disk(sc->disk);
-	sc->disk = NULL;
+	while (!list_empty(&sc->luns)) {
+		p = sc->luns.next;
+		lun = list_entry(p, struct ub_lun, link);
+		list_del(p);
+
+		/* I don't think queue can be NULL. But... Stolen from sx8.c */
+		if ((q = lun->disk->queue) != NULL)
+			blk_cleanup_queue(q);
+		/*
+		 * If we zero disk->private_data BEFORE put_disk, we have
+		 * to check for NULL all over the place in open, release,
+		 * check_media and revalidate, because the block level
+		 * semaphore is well inside the put_disk.
+		 * But we cannot zero after the call, because *disk is gone.
+		 * The sd.c is blatantly racy in this area.
+		 */
+		/* disk->private_data = NULL; */
+		put_disk(lun->disk);
+		lun->disk = NULL;
+
+		ub_id_put(lun->id);
+		kfree(lun);
+	}
 
-	ub_id_put(sc->id);
 	kfree(sc);
 }
 
 /*
  * The "command allocator".
  */
-static struct ub_scsi_cmd *ub_get_cmd(struct ub_dev *sc)
+static struct ub_scsi_cmd *ub_get_cmd(struct ub_lun *lun)
 {
 	struct ub_scsi_cmd *ret;
 
-	if (sc->cmda[0])
+	if (lun->cmda[0])
 		return NULL;
-	ret = &sc->cmdv[0];
-	sc->cmda[0] = 1;
+	ret = &lun->cmdv[0];
+	lun->cmda[0] = 1;
 	return ret;
 }
 
-static void ub_put_cmd(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
+static void ub_put_cmd(struct ub_lun *lun, struct ub_scsi_cmd *cmd)
 {
-	if (cmd != &sc->cmdv[0]) {
+	if (cmd != &lun->cmdv[0]) {
 		printk(KERN_WARNING "%s: releasing a foreign cmd %p\n",
-		    sc->name, cmd);
+		    lun->name, cmd);
 		return;
 	}
-	if (!sc->cmda[0]) {
-		printk(KERN_WARNING "%s: releasing a free cmd\n", sc->name);
+	if (!lun->cmda[0]) {
+		printk(KERN_WARNING "%s: releasing a free cmd\n", lun->name);
 		return;
 	}
-	sc->cmda[0] = 0;
+	lun->cmda[0] = 0;
 }
 
 /*
@@ -630,29 +676,30 @@ static struct ub_scsi_cmd *ub_cmdq_pop(s
 
 static void ub_bd_rq_fn(request_queue_t *q)
 {
-	struct ub_dev *sc = q->queuedata;
+	struct ub_lun *lun = q->queuedata;
 	struct request *rq;
 
 	while ((rq = elv_next_request(q)) != NULL) {
-		if (ub_bd_rq_fn_1(sc, rq) != 0) {
+		if (ub_bd_rq_fn_1(lun, rq) != 0) {
 			blk_stop_queue(q);
 			break;
 		}
 	}
 }
 
-static int ub_bd_rq_fn_1(struct ub_dev *sc, struct request *rq)
+static int ub_bd_rq_fn_1(struct ub_lun *lun, struct request *rq)
 {
+	struct ub_dev *sc = lun->udev;
 	struct ub_scsi_cmd *cmd;
 	int rc;
 
-	if (atomic_read(&sc->poison) || sc->changed) {
+	if (atomic_read(&sc->poison) || lun->changed) {
 		blkdev_dequeue_request(rq);
 		ub_end_rq(rq, 0);
 		return 0;
 	}
 
-	if ((cmd = ub_get_cmd(sc)) == NULL)
+	if ((cmd = ub_get_cmd(lun)) == NULL)
 		return -1;
 	memset(cmd, 0, sizeof(struct ub_scsi_cmd));
 
@@ -661,32 +708,30 @@ static int ub_bd_rq_fn_1(struct ub_dev *
 	if (blk_pc_request(rq)) {
 		rc = ub_cmd_build_packet(sc, cmd, rq);
 	} else {
-		rc = ub_cmd_build_block(sc, cmd, rq);
+		rc = ub_cmd_build_block(sc, lun, cmd, rq);
 	}
 	if (rc != 0) {
-		ub_put_cmd(sc, cmd);
+		ub_put_cmd(lun, cmd);
 		ub_end_rq(rq, 0);
-		blk_start_queue(sc->disk->queue);
 		return 0;
 	}
-
 	cmd->state = UB_CMDST_INIT;
+	cmd->lun = lun;
 	cmd->done = ub_rw_cmd_done;
 	cmd->back = rq;
 
 	cmd->tag = sc->tagcnt++;
 	if ((rc = ub_submit_scsi(sc, cmd)) != 0) {
-		ub_put_cmd(sc, cmd);
+		ub_put_cmd(lun, cmd);
 		ub_end_rq(rq, 0);
-		blk_start_queue(sc->disk->queue);
 		return 0;
 	}
 
 	return 0;
 }
 
-static int ub_cmd_build_block(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
-    struct request *rq)
+static int ub_cmd_build_block(struct ub_dev *sc, struct ub_lun *lun,
+    struct ub_scsi_cmd *cmd, struct request *rq)
 {
 	int ub_dir;
 #if 0 /* We use rq->buffer for now */
@@ -707,7 +752,7 @@ static int ub_cmd_build_block(struct ub_
 	sg = &cmd->sgv[0];
 	n_elem = blk_rq_map_sg(q, rq, sg);
 	if (n_elem <= 0) {
-		ub_put_cmd(sc, cmd);
+		ub_put_cmd(lun, cmd);
 		ub_end_rq(rq, 0);
 		blk_start_queue(q);
 		return 0;		/* request with no s/g entries? */
@@ -716,7 +761,7 @@ static int ub_cmd_build_block(struct ub_
 	if (n_elem != 1) {		/* Paranoia */
 		printk(KERN_WARNING "%s: request with %d segments\n",
 		    sc->name, n_elem);
-		ub_put_cmd(sc, cmd);
+		ub_put_cmd(lun, cmd);
 		ub_end_rq(rq, 0);
 		blk_start_queue(q);
 		return 0;
@@ -748,8 +793,8 @@ static int ub_cmd_build_block(struct ub_
 	 * The call to blk_queue_hardsect_size() guarantees that request
 	 * is aligned, but it is given in terms of 512 byte units, always.
 	 */
-	block = rq->sector >> sc->capacity.bshift;
-	nblks = rq->nr_sectors >> sc->capacity.bshift;
+	block = rq->sector >> lun->capacity.bshift;
+	nblks = rq->nr_sectors >> lun->capacity.bshift;
 
 	cmd->cdb[0] = (ub_dir == UB_DIR_READ)? READ_10: WRITE_10;
 	/* 10-byte uses 4 bytes of LBA: 2147483648KB, 2097152MB, 2048GB */
@@ -803,7 +848,8 @@ static int ub_cmd_build_packet(struct ub
 static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
 {
 	struct request *rq = cmd->back;
-	struct gendisk *disk = sc->disk;
+	struct ub_lun *lun = cmd->lun;
+	struct gendisk *disk = lun->disk;
 	request_queue_t *q = disk->queue;
 	int uptodate;
 
@@ -818,7 +864,7 @@ static void ub_rw_cmd_done(struct ub_dev
 	else
 		uptodate = 0;
 
-	ub_put_cmd(sc, cmd);
+	ub_put_cmd(lun, cmd);
 	ub_end_rq(rq, uptodate);
 	blk_start_queue(q);
 }
@@ -887,7 +933,7 @@ static int ub_scsi_cmd_start(struct ub_d
 	bcb->Tag = cmd->tag;		/* Endianness is not important */
 	bcb->DataTransferLength = cpu_to_le32(cmd->len);
 	bcb->Flags = (cmd->dir == UB_DIR_READ) ? 0x80 : 0;
-	bcb->Lun = 0;			/* No multi-LUN yet */
+	bcb->Lun = (cmd->lun != NULL) ? cmd->lun->num : 0;
 	bcb->Length = cmd->cdb_len;
 
 	/* copy the command payload */
@@ -1002,9 +1048,8 @@ static void ub_scsi_urb_compl(struct ub_
 			 * The control pipe clears itself - nothing to do.
 			 * XXX Might try to reset the device here and retry.
 			 */
-			printk(KERN_NOTICE "%s: "
-			    "stall on control pipe for device %u\n",
-			    sc->name, sc->dev->devnum);
+			printk(KERN_NOTICE "%s: stall on control pipe\n",
+			    sc->name);
 			goto Bad_End;
 		}
 
@@ -1025,9 +1070,8 @@ static void ub_scsi_urb_compl(struct ub_
 			 * The control pipe clears itself - nothing to do.
 			 * XXX Might try to reset the device here and retry.
 			 */
-			printk(KERN_NOTICE "%s: "
-			    "stall on control pipe for device %u\n",
-			    sc->name, sc->dev->devnum);
+			printk(KERN_NOTICE "%s: stall on control pipe\n",
+			    sc->name);
 			goto Bad_End;
 		}
 
@@ -1046,9 +1090,8 @@ static void ub_scsi_urb_compl(struct ub_
 			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
 			if (rc != 0) {
 				printk(KERN_NOTICE "%s: "
-				    "unable to submit clear for device %u"
-				    " (code %d)\n",
-				    sc->name, sc->dev->devnum, rc);
+				    "unable to submit clear (%d)\n",
+				    sc->name, rc);
 				/*
 				 * This is typically ENOMEM or some other such shit.
 				 * Retrying is pointless. Just do Bad End on it...
@@ -1107,9 +1150,8 @@ static void ub_scsi_urb_compl(struct ub_
 			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
 			if (rc != 0) {
 				printk(KERN_NOTICE "%s: "
-				    "unable to submit clear for device %u"
-				    " (code %d)\n",
-				    sc->name, sc->dev->devnum, rc);
+				    "unable to submit clear (%d)\n",
+				    sc->name, rc);
 				/*
 				 * This is typically ENOMEM or some other such shit.
 				 * Retrying is pointless. Just do Bad End on it...
@@ -1140,9 +1182,8 @@ static void ub_scsi_urb_compl(struct ub_
 			rc = ub_submit_clear_stall(sc, cmd, sc->last_pipe);
 			if (rc != 0) {
 				printk(KERN_NOTICE "%s: "
-				    "unable to submit clear for device %u"
-				    " (code %d)\n",
-				    sc->name, sc->dev->devnum, rc);
+				    "unable to submit clear (%d)\n",
+				    sc->name, rc);
 				/*
 				 * This is typically ENOMEM or some other such shit.
 				 * Retrying is pointless. Just do Bad End on it...
@@ -1164,9 +1205,8 @@ static void ub_scsi_urb_compl(struct ub_
 			 * encounter such a thing, try to read the CSW again.
 			 */
 			if (++cmd->stat_count >= 4) {
-				printk(KERN_NOTICE "%s: "
-				    "unable to get CSW on device %u\n",
-				    sc->name, sc->dev->devnum);
+				printk(KERN_NOTICE "%s: unable to get CSW\n",
+				    sc->name);
 				goto Bad_End;
 			}
 			__ub_state_stat(sc, cmd);
@@ -1207,10 +1247,8 @@ static void ub_scsi_urb_compl(struct ub_
 			 */
 			if (++cmd->stat_count >= 4) {
 				printk(KERN_NOTICE "%s: "
-				    "tag mismatch orig 0x%x reply 0x%x "
-				    "on device %u\n",
-				    sc->name, cmd->tag, bcs->Tag,
-				    sc->dev->devnum);
+				    "tag mismatch orig 0x%x reply 0x%x\n",
+				    sc->name, cmd->tag, bcs->Tag);
 				goto Bad_End;
 			}
 			__ub_state_stat(sc, cmd);
@@ -1244,8 +1282,8 @@ static void ub_scsi_urb_compl(struct ub_
 
 	} else {
 		printk(KERN_WARNING "%s: "
-		    "wrong command state %d on device %u\n",
-		    sc->name, cmd->state, sc->dev->devnum);
+		    "wrong command state %d\n",
+		    sc->name, cmd->state);
 		goto Bad_End;
 	}
 	return;
@@ -1288,7 +1326,6 @@ static void __ub_state_stat(struct ub_de
 
 	if ((rc = usb_submit_urb(&sc->work_urb, GFP_ATOMIC)) != 0) {
 		/* XXX Clear stalls */
-		printk("%s: CSW #%d submit failed (%d)\n", sc->name, cmd->tag, rc); /* P3 */
 		ub_complete(&sc->work_done);
 		ub_state_done(sc, cmd, rc);
 		return;
@@ -1333,6 +1370,7 @@ static void ub_state_sense(struct ub_dev
 	scmd->state = UB_CMDST_INIT;
 	scmd->data = sc->top_sense;
 	scmd->len = UB_SENSE_SIZE;
+	scmd->lun = cmd->lun;
 	scmd->done = ub_top_sense_done;
 	scmd->back = cmd;
 
@@ -1411,14 +1449,14 @@ static void ub_top_sense_done(struct ub_
 	}
 	if (cmd != scmd->back) {
 		printk(KERN_WARNING "%s: "
-		    "sense done for wrong command 0x%x on device %u\n",
-		    sc->name, cmd->tag, sc->dev->devnum);
+		    "sense done for wrong command 0x%x\n",
+		    sc->name, cmd->tag);
 		return;
 	}
 	if (cmd->state != UB_CMDST_SENSE) {
 		printk(KERN_WARNING "%s: "
-		    "sense done with bad cmd state %d on device %u\n",
-		    sc->name, cmd->state, sc->dev->devnum);
+		    "sense done with bad cmd state %d\n",
+		    sc->name, cmd->state);
 		return;
 	}
 
@@ -1429,68 +1467,32 @@ static void ub_top_sense_done(struct ub_
 	ub_scsi_urb_compl(sc, cmd);
 }
 
-#if 0
-/* Determine what the maximum LUN supported is */
-int usb_stor_Bulk_max_lun(struct us_data *us)
-{
-	int result;
-
-	/* issue the command */
-	result = usb_stor_control_msg(us, us->recv_ctrl_pipe,
-				 US_BULK_GET_MAX_LUN, 
-				 USB_DIR_IN | USB_TYPE_CLASS | 
-				 USB_RECIP_INTERFACE,
-				 0, us->ifnum, us->iobuf, 1, HZ);
-
-	/* 
-	 * Some devices (i.e. Iomega Zip100) need this -- apparently
-	 * the bulk pipes get STALLed when the GetMaxLUN request is
-	 * processed.   This is, in theory, harmless to all other devices
-	 * (regardless of if they stall or not).
-	 */
-	if (result < 0) {
-		usb_stor_clear_halt(us, us->recv_bulk_pipe);
-		usb_stor_clear_halt(us, us->send_bulk_pipe);
-	}
-
-	US_DEBUGP("GetMaxLUN command result is %d, data is %d\n", 
-		  result, us->iobuf[0]);
-
-	/* if we have a successful request, return the result */
-	if (result == 1)
-		return us->iobuf[0];
-
-	/* return the default -- no LUNs */
-	return 0;
-}
-#endif
-
 /*
  * This is called from a process context.
  */
-static void ub_revalidate(struct ub_dev *sc)
+static void ub_revalidate(struct ub_dev *sc, struct ub_lun *lun)
 {
 
-	sc->readonly = 0;	/* XXX Query this from the device */
+	lun->readonly = 0;	/* XXX Query this from the device */
 
-	sc->capacity.nsec = 0;
-	sc->capacity.bsize = 512;
-	sc->capacity.bshift = 0;
+	lun->capacity.nsec = 0;
+	lun->capacity.bsize = 512;
+	lun->capacity.bshift = 0;
 
-	if (ub_sync_tur(sc) != 0)
+	if (ub_sync_tur(sc, lun) != 0)
 		return;			/* Not ready */
-	sc->changed = 0;
+	lun->changed = 0;
 
-	if (ub_sync_read_cap(sc, &sc->capacity) != 0) {
+	if (ub_sync_read_cap(sc, lun, &lun->capacity) != 0) {
 		/*
 		 * The retry here means something is wrong, either with the
 		 * device, with the transport, or with our code.
 		 * We keep this because sd.c has retries for capacity.
 		 */
-		if (ub_sync_read_cap(sc, &sc->capacity) != 0) {
-			sc->capacity.nsec = 0;
-			sc->capacity.bsize = 512;
-			sc->capacity.bshift = 0;
+		if (ub_sync_read_cap(sc, lun, &lun->capacity) != 0) {
+			lun->capacity.nsec = 0;
+			lun->capacity.bsize = 512;
+			lun->capacity.bshift = 0;
 		}
 	}
 }
@@ -1503,12 +1505,15 @@ static void ub_revalidate(struct ub_dev 
 static int ub_bd_open(struct inode *inode, struct file *filp)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ub_lun *lun;
 	struct ub_dev *sc;
 	unsigned long flags;
 	int rc;
 
-	if ((sc = disk->private_data) == NULL)
+	if ((lun = disk->private_data) == NULL)
 		return -ENXIO;
+	sc = lun->udev;
+
 	spin_lock_irqsave(&ub_lock, flags);
 	if (atomic_read(&sc->poison)) {
 		spin_unlock_irqrestore(&ub_lock, flags);
@@ -1529,15 +1534,15 @@ static int ub_bd_open(struct inode *inod
 	 * The bottom line is, Al Viro says that we should not allow
 	 * bdev->bd_invalidated to be set when doing add_disk no matter what.
 	 */
-	if (sc->first_open) {
-		if (sc->changed) {
-			sc->first_open = 0;
+	if (lun->first_open) {
+		lun->first_open = 0;
+		if (lun->changed) {
 			rc = -ENOMEDIUM;
 			goto err_open;
 		}
 	}
 
-	if (sc->removable || sc->readonly)
+	if (lun->removable || lun->readonly)
 		check_disk_change(inode->i_bdev);
 
 	/*
@@ -1545,12 +1550,12 @@ static int ub_bd_open(struct inode *inod
 	 * under some pretty murky conditions (a failure of READ CAPACITY).
 	 * We may need it one day.
 	 */
-	if (sc->removable && sc->changed && !(filp->f_flags & O_NDELAY)) {
+	if (lun->removable && lun->changed && !(filp->f_flags & O_NDELAY)) {
 		rc = -ENOMEDIUM;
 		goto err_open;
 	}
 
-	if (sc->readonly && (filp->f_mode & FMODE_WRITE)) {
+	if (lun->readonly && (filp->f_mode & FMODE_WRITE)) {
 		rc = -EROFS;
 		goto err_open;
 	}
@@ -1567,7 +1572,8 @@ err_open:
 static int ub_bd_release(struct inode *inode, struct file *filp)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
-	struct ub_dev *sc = disk->private_data;
+	struct ub_lun *lun = disk->private_data;
+	struct ub_dev *sc = lun->udev;
 
 	ub_put(sc);
 	return 0;
@@ -1597,20 +1603,14 @@ static int ub_bd_ioctl(struct inode *ino
  */
 static int ub_bd_revalidate(struct gendisk *disk)
 {
-	struct ub_dev *sc = disk->private_data;
+	struct ub_lun *lun = disk->private_data;
 
-	ub_revalidate(sc);
-	/* This is pretty much a long term P3 */
-	if (!atomic_read(&sc->poison)) {		/* Cover sc->dev */
-		printk(KERN_INFO "%s: device %u capacity nsec %ld bsize %u\n",
-		    sc->name, sc->dev->devnum,
-		    sc->capacity.nsec, sc->capacity.bsize);
-	}
+	ub_revalidate(lun->udev, lun);
 
 	/* XXX Support sector size switching like in sr.c */
-	blk_queue_hardsect_size(disk->queue, sc->capacity.bsize);
-	set_capacity(disk, sc->capacity.nsec);
-	// set_disk_ro(sdkp->disk, sc->readonly);
+	blk_queue_hardsect_size(disk->queue, lun->capacity.bsize);
+	set_capacity(disk, lun->capacity.nsec);
+	// set_disk_ro(sdkp->disk, lun->readonly);
 
 	return 0;
 }
@@ -1626,9 +1626,9 @@ static int ub_bd_revalidate(struct gendi
  */
 static int ub_bd_media_changed(struct gendisk *disk)
 {
-	struct ub_dev *sc = disk->private_data;
+	struct ub_lun *lun = disk->private_data;
 
-	if (!sc->removable)
+	if (!lun->removable)
 		return 0;
 
 	/*
@@ -1640,12 +1640,12 @@ static int ub_bd_media_changed(struct ge
 	 * will fail, then block layer discards the data. Since we never
 	 * spin drives up, such devices simply cannot be used with ub anyway.
 	 */
-	if (ub_sync_tur(sc) != 0) {
-		sc->changed = 1;
+	if (ub_sync_tur(lun->udev, lun) != 0) {
+		lun->changed = 1;
 		return 1;
 	}
 
-	return sc->changed;
+	return lun->changed;
 }
 
 static struct block_device_operations ub_bd_fops = {
@@ -1669,7 +1669,7 @@ static void ub_probe_done(struct ub_dev 
 /*
  * Test if the device has a check condition on it, synchronously.
  */
-static int ub_sync_tur(struct ub_dev *sc)
+static int ub_sync_tur(struct ub_dev *sc, struct ub_lun *lun)
 {
 	struct ub_scsi_cmd *cmd;
 	enum { ALLOC_SIZE = sizeof(struct ub_scsi_cmd) };
@@ -1688,6 +1688,7 @@ static int ub_sync_tur(struct ub_dev *sc
 	cmd->cdb_len = 6;
 	cmd->dir = UB_DIR_NONE;
 	cmd->state = UB_CMDST_INIT;
+	cmd->lun = lun;			/* This may be NULL, but that's ok */
 	cmd->done = ub_probe_done;
 	cmd->back = &compl;
 
@@ -1718,7 +1719,8 @@ err_alloc:
 /*
  * Read the SCSI capacity synchronously (for probing).
  */
-static int ub_sync_read_cap(struct ub_dev *sc, struct ub_capacity *ret)
+static int ub_sync_read_cap(struct ub_dev *sc, struct ub_lun *lun,
+    struct ub_capacity *ret)
 {
 	struct ub_scsi_cmd *cmd;
 	char *p;
@@ -1743,6 +1745,7 @@ static int ub_sync_read_cap(struct ub_de
 	cmd->state = UB_CMDST_INIT;
 	cmd->data = p;
 	cmd->len = 8;
+	cmd->lun = lun;
 	cmd->done = ub_probe_done;
 	cmd->back = &compl;
 
@@ -1812,6 +1815,90 @@ static void ub_probe_timeout(unsigned lo
 }
 
 /*
+ * Get number of LUNs by the way of Bulk GetMaxLUN command.
+ */
+static int ub_sync_getmaxlun(struct ub_dev *sc)
+{
+	int ifnum = sc->intf->cur_altsetting->desc.bInterfaceNumber;
+	unsigned char *p;
+	enum { ALLOC_SIZE = 1 };
+	struct usb_ctrlrequest *cr;
+	struct completion compl;
+	struct timer_list timer;
+	int nluns;
+	int rc;
+
+	init_completion(&compl);
+
+	rc = -ENOMEM;
+	if ((p = kmalloc(ALLOC_SIZE, GFP_KERNEL)) == NULL)
+		goto err_alloc;
+	*p = 55;
+
+	cr = &sc->work_cr;
+	cr->bRequestType = USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE;
+	cr->bRequest = US_BULK_GET_MAX_LUN;
+	cr->wValue = cpu_to_le16(0);
+	cr->wIndex = cpu_to_le16(ifnum);
+	cr->wLength = cpu_to_le16(1);
+
+	usb_fill_control_urb(&sc->work_urb, sc->dev, sc->recv_ctrl_pipe,
+	    (unsigned char*) cr, p, 1, ub_probe_urb_complete, &compl);
+	sc->work_urb.transfer_flags = 0;
+	sc->work_urb.actual_length = 0;
+	sc->work_urb.error_count = 0;
+	sc->work_urb.status = 0;
+
+	if ((rc = usb_submit_urb(&sc->work_urb, GFP_KERNEL)) != 0) {
+		if (rc == -EPIPE) {
+			printk("%s: Stall at GetMaxLUN, using 1 LUN\n",
+			     sc->name); /* P3 */
+		} else {
+			printk(KERN_WARNING
+			     "%s: Unable to submit GetMaxLUN (%d)\n",
+			     sc->name, rc);
+		}
+		goto err_submit;
+	}
+
+	init_timer(&timer);
+	timer.function = ub_probe_timeout;
+	timer.data = (unsigned long) &compl;
+	timer.expires = jiffies + UB_CTRL_TIMEOUT;
+	add_timer(&timer);
+
+	wait_for_completion(&compl);
+
+	del_timer_sync(&timer);
+	usb_kill_urb(&sc->work_urb);
+
+	if (sc->work_urb.actual_length != 1) {
+		printk("%s: GetMaxLUN returned %d bytes\n", sc->name,
+		    sc->work_urb.actual_length); /* P3 */
+		nluns = 0;
+	} else {
+		if ((nluns = *p) == 55) {
+			nluns = 0;
+		} else {
+  			/* GetMaxLUN returns the maximum LUN number */
+			nluns += 1;
+			if (nluns > UB_MAX_LUNS)
+				nluns = UB_MAX_LUNS;
+		}
+		printk("%s: GetMaxLUN returned %d, using %d LUNs\n", sc->name,
+		    *p, nluns); /* P3 */
+	}
+
+	kfree(p);
+	return nluns;
+
+err_submit:
+	kfree(p);
+err_alloc:
+	return rc;
+}
+
+/*
  * Clear initial stalls.
  */
 static int ub_probe_clear_stall(struct ub_dev *sc, int stalled_pipe)
@@ -1897,8 +1984,8 @@ static int ub_get_pipes(struct ub_dev *s
 	}
 
 	if (ep_in == NULL || ep_out == NULL) {
-		printk(KERN_NOTICE "%s: device %u failed endpoint check\n",
-		    sc->name, sc->dev->devnum);
+		printk(KERN_NOTICE "%s: failed endpoint check\n",
+		    sc->name);
 		return -EIO;
 	}
 
@@ -1921,8 +2008,7 @@ static int ub_probe(struct usb_interface
     const struct usb_device_id *dev_id)
 {
 	struct ub_dev *sc;
-	request_queue_t *q;
-	struct gendisk *disk;
+	int nluns;
 	int rc;
 	int i;
 
@@ -1931,6 +2017,7 @@ static int ub_probe(struct usb_interface
 		goto err_core;
 	memset(sc, 0, sizeof(struct ub_dev));
 	spin_lock_init(&sc->lock);
+	INIT_LIST_HEAD(&sc->luns);
 	usb_init_urb(&sc->work_urb);
 	tasklet_init(&sc->tasklet, ub_scsi_action, (unsigned long)sc);
 	atomic_set(&sc->poison, 0);
@@ -1942,19 +2029,16 @@ static int ub_probe(struct usb_interface
 	ub_init_completion(&sc->work_done);
 	sc->work_done.done = 1;		/* A little yuk, but oh well... */
 
-	rc = -ENOSR;
-	if ((sc->id = ub_id_get()) == -1)
-		goto err_id;
-	snprintf(sc->name, 8, DRV_NAME "%c", sc->id + 'a');
-
 	sc->dev = interface_to_usbdev(intf);
 	sc->intf = intf;
 	// sc->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
-
 	usb_set_intfdata(intf, sc);
 	usb_get_dev(sc->dev);
 	// usb_get_intf(sc->intf);	/* Do we need this? */
 
+	snprintf(sc->name, 12, DRV_NAME "(%d.%d)",
+	    sc->dev->bus->busnum, sc->dev->devnum);
+
 	/* XXX Verify that we can handle the device (from descriptors) */
 
 	ub_get_pipes(sc, sc->dev, intf);
@@ -1992,35 +2076,88 @@ static int ub_probe(struct usb_interface
 	 * In any case it's not our business how revaliadation is implemented.
 	 */
 	for (i = 0; i < 3; i++) {	/* Retries for benh's key */
-		if ((rc = ub_sync_tur(sc)) <= 0) break;
+		if ((rc = ub_sync_tur(sc, NULL)) <= 0) break;
 		if (rc != 0x6) break;
 		msleep(10);
 	}
 
-	sc->removable = 1;		/* XXX Query this from the device */
-	sc->changed = 1;		/* ub_revalidate clears only */
-	sc->first_open = 1;
+	nluns = 1;
+	for (i = 0; i < 3; i++) {
+		if ((rc = ub_sync_getmaxlun(sc)) < 0) {
+			/* 
+			 * Some devices (i.e. Iomega Zip100) need this --
+			 * apparently the bulk pipes get STALLed when the
+			 * GetMaxLUN request is processed.
+			 * XXX I have a ZIP-100, verify it does this.
+			 */
+			if (rc == -EPIPE) {
+				ub_probe_clear_stall(sc, sc->recv_bulk_pipe);
+				ub_probe_clear_stall(sc, sc->send_bulk_pipe);
+			}
+			break;
+		}
+		if (rc != 0) {
+			nluns = rc;
+			break;
+		}
+		msleep(100);
+	}
 
-	ub_revalidate(sc);
-	/* This is pretty much a long term P3 */
-	printk(KERN_INFO "%s: device %u capacity nsec %ld bsize %u\n",
-	    sc->name, sc->dev->devnum, sc->capacity.nsec, sc->capacity.bsize);
+	for (i = 0; i < nluns; i++) {
+		ub_probe_lun(sc, i);
+	}
+	return 0;
+
+	/* device_remove_file(&sc->intf->dev, &dev_attr_diag); */
+err_diag:
+	usb_set_intfdata(intf, NULL);
+	// usb_put_intf(sc->intf);
+	usb_put_dev(sc->dev);
+	kfree(sc);
+err_core:
+	return rc;
+}
+
+static int ub_probe_lun(struct ub_dev *sc, int lnum)
+{
+	struct ub_lun *lun;
+	request_queue_t *q;
+	struct gendisk *disk;
+	int rc;
+
+	rc = -ENOMEM;
+	if ((lun = kmalloc(sizeof(struct ub_lun), GFP_KERNEL)) == NULL)
+		goto err_alloc;
+	memset(lun, 0, sizeof(struct ub_lun));
+	lun->num = lnum;
+
+	rc = -ENOSR;
+	if ((lun->id = ub_id_get()) == -1)
+		goto err_id;
+
+	lun->udev = sc;
+	list_add(&lun->link, &sc->luns);
+
+	snprintf(lun->name, 16, DRV_NAME "%c(%d.%d.%d)",
+	    lun->id + 'a', sc->dev->bus->busnum, sc->dev->devnum, lun->num);
+
+	lun->removable = 1;		/* XXX Query this from the device */
+	lun->changed = 1;		/* ub_revalidate clears only */
+	lun->first_open = 1;
+	ub_revalidate(sc, lun);
 
-	/*
-	 * Just one disk per sc currently, but maybe more.
-	 */
 	rc = -ENOMEM;
 	if ((disk = alloc_disk(UB_MINORS_PER_MAJOR)) == NULL)
 		goto err_diskalloc;
 
-	sc->disk = disk;
-	sprintf(disk->disk_name, DRV_NAME "%c", sc->id + 'a');
-	sprintf(disk->devfs_name, DEVFS_NAME "/%c", sc->id + 'a');
+	lun->disk = disk;
+	sprintf(disk->disk_name, DRV_NAME "%c", lun->id + 'a');
+	sprintf(disk->devfs_name, DEVFS_NAME "/%c", lun->id + 'a');
 	disk->major = UB_MAJOR;
-	disk->first_minor = sc->id * UB_MINORS_PER_MAJOR;
+	disk->first_minor = lun->id * UB_MINORS_PER_MAJOR;
 	disk->fops = &ub_bd_fops;
-	disk->private_data = sc;
-	disk->driverfs_dev = &intf->dev;
+	disk->private_data = lun;
+	disk->driverfs_dev = &sc->intf->dev;	/* XXX Many to one ok? */
 
 	rc = -ENOMEM;
 	if ((q = blk_init_queue(ub_bd_rq_fn, &sc->lock)) == NULL)
@@ -2028,28 +2165,17 @@ static int ub_probe(struct usb_interface
 
 	disk->queue = q;
 
-        // blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
+	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 	blk_queue_max_hw_segments(q, UB_MAX_REQ_SG);
 	blk_queue_max_phys_segments(q, UB_MAX_REQ_SG);
-	// blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
+	blk_queue_segment_boundary(q, 0xffffffff);	/* Dubious. */
 	blk_queue_max_sectors(q, UB_MAX_SECTORS);
-	blk_queue_hardsect_size(q, sc->capacity.bsize);
-
-	/*
-	 * This is a serious infraction, caused by a deficiency in the
-	 * USB sg interface (usb_sg_wait()). We plan to remove this once
-	 * we get mileage on the driver and can justify a change to USB API.
-	 * See blk_queue_bounce_limit() to understand this part.
-	 *
-	 * XXX And I still need to be aware of the DMA mask in the HC.
-	 */
-	q->bounce_pfn = blk_max_low_pfn;
-	q->bounce_gfp = GFP_NOIO;
+	blk_queue_hardsect_size(q, lun->capacity.bsize);
 
-	q->queuedata = sc;
+	q->queuedata = lun;
 
-	set_capacity(disk, sc->capacity.nsec);
-	if (sc->removable)
+	set_capacity(disk, lun->capacity.nsec);
+	if (lun->removable)
 		disk->flags |= GENHD_FL_REMOVABLE;
 
 	add_disk(disk);
@@ -2059,22 +2185,20 @@ static int ub_probe(struct usb_interface
 err_blkqinit:
 	put_disk(disk);
 err_diskalloc:
-	device_remove_file(&sc->intf->dev, &dev_attr_diag);
-err_diag:
-	usb_set_intfdata(intf, NULL);
-	// usb_put_intf(sc->intf);
-	usb_put_dev(sc->dev);
-	ub_id_put(sc->id);
+	list_del(&lun->link);
+	ub_id_put(lun->id);
 err_id:
-	kfree(sc);
-err_core:
+	kfree(lun);
+err_alloc:
 	return rc;
 }
 
 static void ub_disconnect(struct usb_interface *intf)
 {
 	struct ub_dev *sc = usb_get_intfdata(intf);
-	struct gendisk *disk = sc->disk;
+	struct list_head *p;
+	struct ub_lun *lun;
+	struct gendisk *disk;
 	unsigned long flags;
 
 	/*
@@ -2124,14 +2248,18 @@ static void ub_disconnect(struct usb_int
 	/*
 	 * Unregister the upper layer.
 	 */
-	if (disk->flags & GENHD_FL_UP)
-		del_gendisk(disk);
-	/*
-	 * I wish I could do:
-	 *    set_bit(QUEUE_FLAG_DEAD, &q->queue_flags);
-	 * As it is, we rely on our internal poisoning and let
-	 * the upper levels to spin furiously failing all the I/O.
-	 */
+	list_for_each (p, &sc->luns) {
+		lun = list_entry(p, struct ub_lun, link);
+		disk = lun->disk;
+		if (disk->flags & GENHD_FL_UP)
+			del_gendisk(disk);
+		/*
+		 * I wish I could do:
+		 *    set_bit(QUEUE_FLAG_DEAD, &q->queue_flags);
+		 * As it is, we rely on our internal poisoning and let
+		 * the upper levels to spin furiously failing all the I/O.
+		 */
+	}
 
 	/*
 	 * Taking a lock on a structure which is about to be freed
@@ -2182,8 +2310,8 @@ static int __init ub_init(void)
 {
 	int rc;
 
-	/* P3 */ printk("ub: sizeof ub_scsi_cmd %zu ub_dev %zu\n",
-			sizeof(struct ub_scsi_cmd), sizeof(struct ub_dev));
+	/* P3 */ printk("ub: sizeof ub_scsi_cmd %zu ub_dev %zu ub_lun %zu\n",
+			sizeof(struct ub_scsi_cmd), sizeof(struct ub_dev), sizeof(struct ub_lun));
 
 	if ((rc = register_blkdev(UB_MAJOR, DRV_NAME)) != 0)
 		goto err_regblkdev;
