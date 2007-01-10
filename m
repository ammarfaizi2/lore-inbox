Return-Path: <linux-kernel-owner+w=401wt.eu-S965222AbXAJWvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbXAJWvv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbXAJWvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:51:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965222AbXAJWvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:51:48 -0500
Date: Wed, 10 Jan 2007 18:08:59 -0500 (EST)
Message-Id: <20070110.180859.78702215.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Cc: dm-devel@redhat.com, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 3/3] blk_end_request: caller change
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces caller's end_that_request_* to blk_end_request.

Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
---
 block/elevator.c                |    3 -
 block/ll_rw_blk.c               |   26 +++++++-----
 drivers/block/DAC960.c          |   15 +++++--
 drivers/block/cciss.c           |    3 -
 drivers/block/cpqarray.c        |    3 -
 drivers/block/floppy.c          |   18 ++++++--
 drivers/block/nbd.c             |    4 -
 drivers/block/sx8.c             |    5 --
 drivers/block/ub.c              |    3 -
 drivers/block/viodasd.c         |   15 +++++--
 drivers/cdrom/cdu31a.c          |   20 ++++++---
 drivers/ide/ide-cd.c            |   81 +++++++++++++++++++++++++++++-----------
 drivers/ide/ide-io.c            |   52 ++++++++++++++++++-------
 drivers/message/i2o/i2o_block.c |   19 ++++++---
 drivers/mmc/mmc_block.c         |   36 +++++++++--------
 drivers/s390/block/dasd.c       |   14 +++++-
 drivers/s390/char/tape_block.c  |    3 -
 drivers/scsi/ide-scsi.c         |    5 +-
 drivers/scsi/scsi_lib.c         |   32 ++++++++++-----
 19 files changed, 239 insertions(+), 118 deletions(-)

diff -rupN 2-helper-implementation/block/elevator.c 3-caller-change/block/elevator.c
--- 2-helper-implementation/block/elevator.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/block/elevator.c	2007-01-10 11:22:59.000000000 -0500
@@ -729,8 +729,7 @@ struct request *elv_next_request(request
 
 			blkdev_dequeue_request(rq);
 			rq->cmd_flags |= REQ_QUIET;
-			end_that_request_chunk(rq, 0, nr_bytes);
-			end_that_request_last(rq, 0);
+			blk_end_request(rq, 0, nr_bytes, 1, NULL, NULL);
 		} else {
 			printk(KERN_ERR "%s: bad return=%d\n", __FUNCTION__,
 								ret);
diff -rupN 2-helper-implementation/block/ll_rw_blk.c 3-caller-change/block/ll_rw_blk.c
--- 2-helper-implementation/block/ll_rw_blk.c	2007-01-10 11:17:08.000000000 -0500
+++ 3-caller-change/block/ll_rw_blk.c	2007-01-10 11:25:57.000000000 -0500
@@ -376,8 +376,7 @@ void blk_ordered_complete_seq(request_qu
 
 	q->ordseq = 0;
 
-	end_that_request_first(rq, uptodate, rq->hard_nr_sectors);
-	end_that_request_last(rq, uptodate);
+	blk_end_request(rq, uptodate, rq->hard_nr_sectors << 9, 1, NULL, NULL);
 }
 
 static int blk_uptodate_to_error(int uptodate)
@@ -534,9 +533,9 @@ int blk_do_ordered(request_queue_t *q, s
 			 * ORDERED_NONE while this request is on it.
 			 */
 			blkdev_dequeue_request(rq);
-			end_that_request_first(rq, -EOPNOTSUPP,
-					       rq->hard_nr_sectors);
-			end_that_request_last(rq, -EOPNOTSUPP);
+			blk_end_request(rq, -EOPNOTSUPP,
+					rq->hard_nr_sectors << 9, 1, NULL,
+					NULL);
 			*rqp = NULL;
 			return 0;
 		}
@@ -3524,13 +3523,20 @@ void end_that_request_last(struct reques
 
 EXPORT_SYMBOL(end_that_request_last);
 
+static int end_request_callback(void *arg)
+{
+	struct request *req = (struct request *)arg;
+
+	add_disk_randomness(req->rq_disk);
+	blkdev_dequeue_request(req);
+
+	return 0;
+}
+
 void end_request(struct request *req, int uptodate)
 {
-	if (!end_that_request_first(req, uptodate, req->hard_cur_sectors)) {
-		add_disk_randomness(req->rq_disk);
-		blkdev_dequeue_request(req);
-		end_that_request_last(req, uptodate);
-	}
+	blk_end_request(req, uptodate, req->hard_cur_sectors << 9, 1,
+			end_request_callback, (void *)req);
 }
 
 EXPORT_SYMBOL(end_request);
diff -rupN 2-helper-implementation/drivers/block/cciss.c 3-caller-change/drivers/block/cciss.c
--- 2-helper-implementation/drivers/block/cciss.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/block/cciss.c	2007-01-10 11:43:56.000000000 -0500
@@ -1312,7 +1312,8 @@ static void cciss_softirq_done(struct re
 
 	add_disk_randomness(rq->rq_disk);
 	spin_lock_irqsave(&h->lock, flags);
-	end_that_request_last(rq, rq->errors);
+	blk_end_request(rq, rq->errors, rq->hard_cur_sectors << 9, 1, NULL,
+			NULL);
 	cmd_free(h, cmd, 1);
 	cciss_check_queues(h);
 	spin_unlock_irqrestore(&h->lock, flags);
diff -rupN 2-helper-implementation/drivers/block/cpqarray.c 3-caller-change/drivers/block/cpqarray.c
--- 2-helper-implementation/drivers/block/cpqarray.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/block/cpqarray.c	2007-01-10 11:26:37.000000000 -0500
@@ -1041,7 +1041,8 @@ static inline void complete_command(cmdl
 	add_disk_randomness(rq->rq_disk);
 
 	DBGPX(printk("Done with %p\n", rq););
-	end_that_request_last(rq, ok ? 1 : -EIO);
+	blk_end_request(rq, ok ? 1 : -EIO, rq->hard_cur_sectors << 9, 1, NULL,
+			NULL);
 }
 
 /*
diff -rupN 2-helper-implementation/drivers/block/DAC960.c 3-caller-change/drivers/block/DAC960.c
--- 2-helper-implementation/drivers/block/DAC960.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/block/DAC960.c	2007-01-10 11:26:50.000000000 -0500
@@ -3440,6 +3440,15 @@ static void DAC960_RequestFunction(struc
 	DAC960_ProcessRequest(RequestQueue->queuedata);
 }
 
+static int DAC960_cr_callback(void *arg)
+{
+	struct request *Request = (struct request *)arg;
+
+	add_disk_randomness(Request->rq_disk);
+
+	return 0;
+}
+
 /*
   DAC960_ProcessCompletedBuffer performs completion processing for an
   individual Buffer.
@@ -3458,10 +3467,8 @@ static inline boolean DAC960_ProcessComp
 	pci_unmap_sg(Command->Controller->PCIDevice, Command->cmd_sglist,
 		Command->SegmentCount, Command->DmaDirection);
 
-	 if (!end_that_request_first(Request, UpToDate, Command->BlockCount)) {
-		add_disk_randomness(Request->rq_disk);
- 	 	end_that_request_last(Request, UpToDate);
-
+	 if (!blk_end_request(Request, UpToDate, Command->BlockCount << 9, 1,
+			      DAC960_cr_callback, (void *)Request)) {
 		if (Command->Completion) {
 			complete(Command->Completion);
 			Command->Completion = NULL;
diff -rupN 2-helper-implementation/drivers/block/floppy.c 3-caller-change/drivers/block/floppy.c
--- 2-helper-implementation/drivers/block/floppy.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/block/floppy.c	2007-01-10 11:27:06.000000000 -0500
@@ -2277,6 +2277,17 @@ static int do_format(int drive, struct f
  * =============================
  */
 
+static int floppy_er_callback(void *arg)
+{
+	struct request *req = (struct request *)arg;
+
+	add_disk_randomness(req->rq_disk);
+	floppy_off((long)req->rq_disk->private_data);
+	blkdev_dequeue_request(req);
+
+	return 0;
+}
+
 static void floppy_end_request(struct request *req, int uptodate)
 {
 	unsigned int nr_sectors = current_count_sectors;
@@ -2284,12 +2295,9 @@ static void floppy_end_request(struct re
 	/* current_count_sectors can be zero if transfer failed */
 	if (!uptodate)
 		nr_sectors = req->current_nr_sectors;
-	if (end_that_request_first(req, uptodate, nr_sectors))
+	if (blk_end_request(req, uptodate, nr_sectors << 9, 1,
+			    floppy_er_callback, (void *)req))
 		return;
-	add_disk_randomness(req->rq_disk);
-	floppy_off((long)req->rq_disk->private_data);
-	blkdev_dequeue_request(req);
-	end_that_request_last(req, uptodate);
 
 	/* We're done with the request */
 	current_req = NULL;
diff -rupN 2-helper-implementation/drivers/block/nbd.c 3-caller-change/drivers/block/nbd.c
--- 2-helper-implementation/drivers/block/nbd.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/block/nbd.c	2007-01-10 11:27:16.000000000 -0500
@@ -107,9 +107,7 @@ static void nbd_end_request(struct reque
 			req, uptodate? "done": "failed");
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
-		end_that_request_last(req, uptodate);
-	}
+	blk_end_request(req, uptodate, req->nr_sectors << 9, 1, NULL, NULL);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
diff -rupN 2-helper-implementation/drivers/block/sx8.c 3-caller-change/drivers/block/sx8.c
--- 2-helper-implementation/drivers/block/sx8.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/block/sx8.c	2007-01-10 11:27:25.000000000 -0500
@@ -747,11 +747,10 @@ static inline void carm_end_request_queu
 	struct request *req = crq->rq;
 	int rc;
 
-	rc = end_that_request_first(req, uptodate, req->hard_nr_sectors);
+	rc = blk_end_request(req, uptodate, req->hard_nr_sectors << 9, 1, NULL,
+			     NULL);
 	assert(rc == 0);
 
-	end_that_request_last(req, uptodate);
-
 	rc = carm_put_request(host, crq);
 	assert(rc == 0);
 }
diff -rupN 2-helper-implementation/drivers/block/ub.c 3-caller-change/drivers/block/ub.c
--- 2-helper-implementation/drivers/block/ub.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/block/ub.c	2007-01-10 11:27:34.000000000 -0500
@@ -814,8 +814,7 @@ static void ub_end_rq(struct request *rq
 		uptodate = 0;
 		rq->errors = scsi_status;
 	}
-	end_that_request_first(rq, uptodate, rq->hard_nr_sectors);
-	end_that_request_last(rq, uptodate);
+	blk_end_request(rq, uptodate, rq->hard_nr_sectors << 9, 1, NULL, NULL);
 }
 
 static int ub_rw_cmd_retry(struct ub_dev *sc, struct ub_lun *lun,
diff -rupN 2-helper-implementation/drivers/block/viodasd.c 3-caller-change/drivers/block/viodasd.c
--- 2-helper-implementation/drivers/block/viodasd.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/block/viodasd.c	2007-01-10 11:27:44.000000000 -0500
@@ -269,16 +269,23 @@ static struct block_device_operations vi
 	.getgeo = viodasd_getgeo,
 };
 
+static int viodasd_er_callback(void *arg)
+{
+	struct request *req = (struct request *)arg;
+
+	add_disk_randomness(req->rq_disk);
+
+	return 0;
+}
+
 /*
  * End a request
  */
 static void viodasd_end_request(struct request *req, int uptodate,
 		int num_sectors)
 {
-	if (end_that_request_first(req, uptodate, num_sectors))
-		return;
-	add_disk_randomness(req->rq_disk);
-	end_that_request_last(req, uptodate);
+	blk_end_request(req, uptodate, num_sectors << 9, 1,
+			viodasd_er_callback, (void *)req);
 }
 
 /*
diff -rupN 2-helper-implementation/drivers/cdrom/cdu31a.c 3-caller-change/drivers/cdrom/cdu31a.c
--- 2-helper-implementation/drivers/cdrom/cdu31a.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/cdrom/cdu31a.c	2007-01-10 11:28:02.000000000 -0500
@@ -1283,6 +1283,18 @@ read_data_block(char *buffer,
 }
 
 
+static int do_cdu31a_rq_callback(void *arg)
+{
+	struct request *req = (struct request *)arg;
+	request_queue_t *q = req->q;
+
+	spin_lock_irq(q->queue_lock);
+	blkdev_dequeue_request(req);
+	spin_unlock_irq(q->queue_lock);
+
+	return 0;
+}
+
 /*
  * The OS calls this to perform a read or write operation to the drive.
  * Write obviously fail.  Reads to a read ahead of sony_buffer_size
@@ -1400,12 +1412,8 @@ static void do_cdu31a_request(request_qu
 		read_data_block(req->buffer, block, nblock, res_reg, &res_size);
 
 		if (res_reg[0] != 0x20) {
-			if (!end_that_request_first(req, 1, nblock)) {
-				spin_lock_irq(q->queue_lock);
-				blkdev_dequeue_request(req);
-				end_that_request_last(req, 1);
-				spin_unlock_irq(q->queue_lock);
-			}
+			blk_end_request(req, 1, nblock << 9, 0,
+					do_cdu31a_rq_callback, (void *)req);
 			continue;
 		}
 
diff -rupN 2-helper-implementation/drivers/ide/ide-cd.c 3-caller-change/drivers/ide/ide-cd.c
--- 2-helper-implementation/drivers/ide/ide-cd.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/ide/ide-cd.c	2007-01-10 11:28:19.000000000 -0500
@@ -655,9 +655,8 @@ static void cdrom_end_request (ide_drive
 					BUG();
 			} else {
 				spin_lock_irqsave(&ide_lock, flags);
-				end_that_request_chunk(failed, 0,
-							failed->data_len);
-				end_that_request_last(failed, 0);
+				blk_end_request(failed, 0, failed->data_len, 1,
+						NULL, NULL);
 				spin_unlock_irqrestore(&ide_lock, flags);
 			}
 		} else
@@ -1658,6 +1657,52 @@ static void post_transform_command(struc
 	}
 }
 
+static void cdrom_newpc_intr_callback_common(struct request *rq,
+					     ide_drive_t *drive,
+					     spinlock_t *ide_lock)
+{
+	unsigned long flags = 0UL;
+
+	if (!rq->data_len)
+		post_transform_command(rq);
+
+	spin_lock_irqsave(ide_lock, flags);
+	blkdev_dequeue_request(rq);
+	HWGROUP(drive)->rq = NULL;
+	spin_unlock_irqrestore(ide_lock, flags);
+}
+
+static int cdrom_newpc_intr_dma_callback(void *arg)
+{
+	void **argv = (void **)arg;
+	struct request *rq = (struct request *)*argv++;
+	ide_drive_t *drive = (ide_drive_t *)argv++;
+	spinlock_t *ide_lock = (spinlock_t *)argv;
+
+	rq->data_len = 0;
+
+	cdrom_newpc_intr_callback_common(rq, drive, ide_lock);
+
+	return 0;
+}
+
+static int cdrom_newpc_intr_pio_callback(void *arg)
+{
+	void **argv = (void **)arg;
+	struct request *rq = (struct request *)*argv++;
+	ide_drive_t *drive = (ide_drive_t *)argv++;
+	spinlock_t *ide_lock = (spinlock_t *)argv;
+
+	cdrom_newpc_intr_callback_common(rq, drive, ide_lock);
+
+	return 0;
+}
+
+static int cdrom_newpc_intr_dummy_callback(void *arg)
+{
+	return 1;
+}
+
 typedef void (xfer_func_t)(ide_drive_t *, void *, u32);
 
 /*
@@ -1673,7 +1718,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	int dma_error, dma, stat, ireason, len, thislen;
 	u8 lowcyl, highcyl;
 	xfer_func_t *xferfunc;
-	unsigned long flags;
+	void *arg[] = {(void *)rq, (void *)drive, (void *)&ide_lock};
 
 	/* Check for errors. */
 	dma_error = 0;
@@ -1696,9 +1741,9 @@ static ide_startstop_t cdrom_newpc_intr(
 			return ide_error(drive, "dma error", stat);
 		}
 
-		end_that_request_chunk(rq, 1, rq->data_len);
-		rq->data_len = 0;
-		goto end_request;
+		blk_end_request(rq, 1, rq->data_len, 0,
+				cdrom_newpc_intr_dma_callback, arg);
+		return ide_stopped;
 	}
 
 	/*
@@ -1716,8 +1761,12 @@ static ide_startstop_t cdrom_newpc_intr(
 	/*
 	 * If DRQ is clear, the command has completed.
 	 */
-	if ((stat & DRQ_STAT) == 0)
-		goto end_request;
+	if ((stat & DRQ_STAT) == 0) {
+		blk_end_request(rq, 1, rq->hard_cur_sectors << 9, 0,
+				cdrom_newpc_intr_pio_callback, arg);
+
+		return ide_stopped;
+	}
 
 	/*
 	 * check which way to transfer data
@@ -1770,7 +1819,8 @@ static ide_startstop_t cdrom_newpc_intr(
 		rq->data_len -= blen;
 
 		if (rq->bio)
-			end_that_request_chunk(rq, 1, blen);
+			blk_end_request(rq, 1, blen, 1,
+					cdrom_newpc_intr_dummy_callback, NULL);
 		else
 			rq->data += blen;
 	}
@@ -1791,17 +1841,6 @@ static ide_startstop_t cdrom_newpc_intr(
 
 	ide_set_handler(drive, cdrom_newpc_intr, rq->timeout, NULL);
 	return ide_started;
-
-end_request:
-	if (!rq->data_len)
-		post_transform_command(rq);
-
-	spin_lock_irqsave(&ide_lock, flags);
-	blkdev_dequeue_request(rq);
-	end_that_request_last(rq, 1);
-	HWGROUP(drive)->rq = NULL;
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return ide_stopped;
 }
 
 static ide_startstop_t cdrom_write_intr(ide_drive_t *drive)
diff -rupN 2-helper-implementation/drivers/ide/ide-io.c 3-caller-change/drivers/ide/ide-io.c
--- 2-helper-implementation/drivers/ide/ide-io.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/ide/ide-io.c	2007-01-10 11:28:35.000000000 -0500
@@ -54,10 +54,25 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
+static int __ide_er_callback(void *arg)
+{
+	void **argv = (void **)arg;
+	ide_drive_t *drive = (ide_drive_t *)*argv++;
+	struct request *rq = (struct request *)*argv;
+
+	add_disk_randomness(rq->rq_disk);
+	if (!list_empty(&rq->queuelist))
+		blkdev_dequeue_request(rq);
+	HWGROUP(drive)->rq = NULL;
+
+	return 0;
+}
+
 static int __ide_end_request(ide_drive_t *drive, struct request *rq,
 			     int uptodate, int nr_sectors)
 {
 	int ret = 1;
+	void *arg[] = {(void *)rq, (void *)drive};
 
 	/*
 	 * if failfast is set on a request, override number of sectors and
@@ -78,14 +93,9 @@ static int __ide_end_request(ide_drive_t
 		HWGROUP(drive)->hwif->ide_dma_on(drive);
 	}
 
-	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
-		add_disk_randomness(rq->rq_disk);
-		if (!list_empty(&rq->queuelist))
-			blkdev_dequeue_request(rq);
-		HWGROUP(drive)->rq = NULL;
-		end_that_request_last(rq, uptodate);
+	if (!blk_end_request(rq, uptodate, nr_sectors << 9, 1,
+			     __ide_er_callback, arg))
 		ret = 0;
-	}
 
 	return ret;
 }
@@ -233,6 +243,19 @@ static ide_startstop_t ide_start_power_s
 	return ide_stopped;
 }
 
+static int ide_edr_callback(void *arg)
+{
+	void **argv = (void **)arg;
+	ide_drive_t *drive = (ide_drive_t *)*argv++;
+	struct request *rq = (struct request *)*argv;
+
+	add_disk_randomness(rq->rq_disk);
+	if (blk_rq_tagged(rq))
+		blk_queue_end_tag(drive->queue, rq);
+
+	return 0;
+}
+
 /**
  *	ide_end_dequeued_request	-	complete an IDE I/O
  *	@drive: IDE device for the I/O
@@ -251,6 +274,7 @@ static ide_startstop_t ide_start_power_s
 int ide_end_dequeued_request(ide_drive_t *drive, struct request *rq,
 			     int uptodate, int nr_sectors)
 {
+	void *arg[] = {(void *)drive, (void *)rq};
 	unsigned long flags;
 	int ret = 1;
 
@@ -277,13 +301,10 @@ int ide_end_dequeued_request(ide_drive_t
 		HWGROUP(drive)->hwif->ide_dma_on(drive);
 	}
 
-	if (!end_that_request_first(rq, uptodate, nr_sectors)) {
-		add_disk_randomness(rq->rq_disk);
-		if (blk_rq_tagged(rq))
-			blk_queue_end_tag(drive->queue, rq);
-		end_that_request_last(rq, uptodate);
+	if (!blk_end_request(rq, uptodate, nr_sectors << 9, 1,
+			     ide_edr_callback, arg))
 		ret = 0;
-	}
+
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ret;
 }
@@ -315,7 +336,7 @@ static void ide_complete_pm_request (ide
 	}
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
-	end_that_request_last(rq, 1);
+	blk_end_request(rq, 1, rq->hard_cur_sectors << 9, 1, NULL, NULL);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
@@ -448,7 +469,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
 	rq->errors = err;
-	end_that_request_last(rq, !rq->errors);
+	blk_end_request(rq, !rq->errors, rq->hard_cur_sectors << 9, 1, NULL,
+			NULL);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
diff -rupN 2-helper-implementation/drivers/message/i2o/i2o_block.c 3-caller-change/drivers/message/i2o/i2o_block.c
--- 2-helper-implementation/drivers/message/i2o/i2o_block.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/message/i2o/i2o_block.c	2007-01-10 11:29:08.000000000 -0500
@@ -438,6 +438,15 @@ static void i2o_block_delayed_request_fn
 	kfree(dreq);
 };
 
+static int i2o_block_er_callback(void *arg)
+{
+	struct request *req = (struct request *)arg;
+
+	add_disk_randomness(req->rq_disk);
+
+	return 0;
+}
+
 /**
  *	i2o_block_end_request - Post-processing of completed commands
  *	@req: request which should be completed
@@ -455,22 +464,20 @@ static void i2o_block_end_request(struct
 	request_queue_t *q = req->q;
 	unsigned long flags;
 
-	if (end_that_request_chunk(req, uptodate, nr_bytes)) {
+	if (blk_end_request(req, uptodate, nr_bytes, 0, i2o_block_er_callback,
+			    (void *)req)) {
 		int leftover = (req->hard_nr_sectors << KERNEL_SECTOR_SHIFT);
 
 		if (blk_pc_request(req))
 			leftover = req->data_len;
 
 		if (end_io_error(uptodate))
-			end_that_request_chunk(req, 0, leftover);
+			blk_end_request(req, 0, leftover, 0,
+					i2o_block_er_callback, (void *)req);
 	}
 
-	add_disk_randomness(req->rq_disk);
-
 	spin_lock_irqsave(q->queue_lock, flags);
 
-	end_that_request_last(req, uptodate);
-
 	if (likely(dev)) {
 		dev->open_queue_depth--;
 		list_del(&ireq->queue);
diff -rupN 2-helper-implementation/drivers/mmc/mmc_block.c 3-caller-change/drivers/mmc/mmc_block.c
--- 2-helper-implementation/drivers/mmc/mmc_block.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/mmc/mmc_block.c	2007-01-10 11:29:24.000000000 -0500
@@ -220,6 +220,16 @@ static u32 mmc_sd_num_wr_blocks(struct m
 	return blocks;
 }
 
+static int mmc_blk_issue_rq_callback(void *arg)
+{
+	struct request *req = (struct request *)arg;
+
+	add_disk_randomness(req->rq_disk);
+	blkdev_dequeue_request(req);
+
+	return 0;
+}
+
 static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -328,15 +338,8 @@ static int mmc_blk_issue_rq(struct mmc_q
 		 * A block was successfully transferred.
 		 */
 		spin_lock_irq(&md->lock);
-		ret = end_that_request_chunk(req, 1, brq.data.bytes_xfered);
-		if (!ret) {
-			/*
-			 * The whole request completed successfully.
-			 */
-			add_disk_randomness(req->rq_disk);
-			blkdev_dequeue_request(req);
-			end_that_request_last(req, 1);
-		}
+		blk_end_request(req, 1, brq.data.bytes_xfered, 1,
+				mmc_blk_issue_rq_callback, (void *)req);
 		spin_unlock_irq(&md->lock);
 	} while (ret);
 
@@ -368,13 +371,16 @@ static int mmc_blk_issue_rq(struct mmc_q
 			else
 				bytes = blocks << 9;
 			spin_lock_irq(&md->lock);
-			ret = end_that_request_chunk(req, 1, bytes);
+			ret = blk_end_request(req, 1, bytes, 1,
+					      mmc_blk_issue_rq_callback,
+					      (void *)req);
 			spin_unlock_irq(&md->lock);
 		}
 	} else if (rq_data_dir(req) != READ &&
 		   (card->host->caps & MMC_CAP_MULTIWRITE)) {
 		spin_lock_irq(&md->lock);
-		ret = end_that_request_chunk(req, 1, brq.data.bytes_xfered);
+		ret = blk_end_request(req, 1, brq.data.bytes_xfered, 1,
+				      mmc_blk_issue_rq_callback, (void *)req);
 		spin_unlock_irq(&md->lock);
 	}
 
@@ -382,13 +388,9 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 	spin_lock_irq(&md->lock);
 	while (ret) {
-		ret = end_that_request_chunk(req, 0,
-				req->current_nr_sectors << 9);
+		ret = blk_end_request(req, 0, req->current_nr_sectors << 9, 1,
+				      mmc_blk_issue_rq_callback, (void *)req);
 	}
-
-	add_disk_randomness(req->rq_disk);
-	blkdev_dequeue_request(req);
-	end_that_request_last(req, 0);
 	spin_unlock_irq(&md->lock);
 
 	return 0;
diff -rupN 2-helper-implementation/drivers/s390/block/dasd.c 3-caller-change/drivers/s390/block/dasd.c
--- 2-helper-implementation/drivers/s390/block/dasd.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/s390/block/dasd.c	2007-01-10 11:29:45.000000000 -0500
@@ -1075,16 +1075,24 @@ dasd_int_handler(struct ccw_device *cdev
 	dasd_schedule_bh(device);
 }
 
+static int dasd_er_callback(void *arg)
+{
+	struct request *req = (struct request *)arg;
+
+	add_disk_randomness(req->rq_disk);
+
+	return 0;
+}
+
 /*
  * posts the buffer_cache about a finalized request
  */
 static inline void
 dasd_end_request(struct request *req, int uptodate)
 {
-	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
+	if (blk_end_request(req, uptodate, req->hard_nr_sectors << 9, 1,
+			    dasd_er_callback, (void *)req))
 		BUG();
-	add_disk_randomness(req->rq_disk);
-	end_that_request_last(req, uptodate);
 }
 
 /*
diff -rupN 2-helper-implementation/drivers/s390/char/tape_block.c 3-caller-change/drivers/s390/char/tape_block.c
--- 2-helper-implementation/drivers/s390/char/tape_block.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/s390/char/tape_block.c	2007-01-10 11:30:03.000000000 -0500
@@ -75,9 +75,8 @@ tapeblock_trigger_requeue(struct tape_de
 static inline void
 tapeblock_end_request(struct request *req, int uptodate)
 {
-	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
+	if (blk_end_request(req, uptodate, req->hard_nr_sectors, 1, NULL, NULL))
 		BUG();
-	end_that_request_last(req, uptodate);
 }
 
 static void
diff -rupN 2-helper-implementation/drivers/scsi/ide-scsi.c 3-caller-change/drivers/scsi/ide-scsi.c
--- 2-helper-implementation/drivers/scsi/ide-scsi.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-caller-change/drivers/scsi/ide-scsi.c	2007-01-10 11:30:19.000000000 -0500
@@ -1041,7 +1041,7 @@ static int idescsi_eh_reset (struct scsi
 
 	/* kill current request */
 	blkdev_dequeue_request(req);
-	end_that_request_last(req, 0);
+	blk_end_request(req, 0, req->hard_cur_sectors << 9, 1, NULL, NULL);
 	if (blk_sense_request(req))
 		kfree(scsi->pc->buffer);
 	kfree(scsi->pc);
@@ -1051,7 +1051,8 @@ static int idescsi_eh_reset (struct scsi
 	/* now nuke the drive queue */
 	while ((req = elv_next_request(drive->queue))) {
 		blkdev_dequeue_request(req);
-		end_that_request_last(req, 0);
+		blk_end_request(req, 0, req->hard_cur_sectors << 9, 1, NULL,
+				NULL);
 	}
 
 	HWGROUP(drive)->rq = NULL;
diff -rupN 2-helper-implementation/drivers/scsi/scsi_lib.c 3-caller-change/drivers/scsi/scsi_lib.c
--- 2-helper-implementation/drivers/scsi/scsi_lib.c	2007-01-10 11:19:00.000000000 -0500
+++ 3-caller-change/drivers/scsi/scsi_lib.c	2007-01-10 11:30:32.000000000 -0500
@@ -639,6 +639,23 @@ void scsi_run_host_queues(struct Scsi_Ho
 		scsi_run_queue(sdev->request_queue);
 }
 
+static int scsi_er_callback(void *arg)
+{
+	void **argv = (void **)arg;
+	request_queue_t *q = (request_queue_t *)*argv++;
+	struct request *req = (struct request *)*argv;
+	unsigned long flags;
+
+	add_disk_randomness(req->rq_disk);
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	if (blk_rq_tagged(req))
+		blk_queue_end_tag(q, req);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	return 0;
+}
+
 /*
  * Function:    scsi_end_request()
  *
@@ -666,13 +683,13 @@ static struct scsi_cmnd *scsi_end_reques
 {
 	request_queue_t *q = cmd->device->request_queue;
 	struct request *req = cmd->request;
-	unsigned long flags;
+	void *arg[] = {(void *)q, (void *)req};
 
 	/*
 	 * If there are blocks left over at the end, set up the command
 	 * to queue the remainder of them.
 	 */
-	if (end_that_request_chunk(req, uptodate, bytes)) {
+	if (blk_end_request(req, uptodate, bytes, 0, scsi_er_callback, arg)) {
 		int leftover = (req->hard_nr_sectors << 9);
 
 		if (blk_pc_request(req))
@@ -680,7 +697,8 @@ static struct scsi_cmnd *scsi_end_reques
 
 		/* kill remainder if no retrys */
 		if (!uptodate && blk_noretry_request(req))
-			end_that_request_chunk(req, 0, leftover);
+			blk_end_request(req, 0, leftover, 0, scsi_er_callback,
+					arg);
 		else {
 			if (requeue) {
 				/*
@@ -695,14 +713,6 @@ static struct scsi_cmnd *scsi_end_reques
 		}
 	}
 
-	add_disk_randomness(req->rq_disk);
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	if (blk_rq_tagged(req))
-		blk_queue_end_tag(q, req);
-	end_that_request_last(req, uptodate);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
 	/*
 	 * This will goose the queue request function at the end, so we don't
 	 * need to worry about launching another command.

