Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVKQPg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVKQPg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVKQPg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:36:29 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:18550 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750867AbVKQPgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:36:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=JWKubrbErYqtraZMPgNo0rTFle0xGoBSkU6wJCht+AsJDf7vQf1M8j/QQ6MBzez/rJIkjRfwOXRr58qWdz3ZUJPcsPI6+3AaxZ19MIuN+/dtqaQZieZWKaadOEteErN6cPTfP8c4dcc8hS9ASiTxMudfZJd5FJOMEVi58L0w+ts=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051117153509.B89B4777@htj.dyndns.org>
In-Reply-To: <20051117153509.B89B4777@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 01/10] blk: add @uptodate to end_that_request_last() and @error to rq_end_io_fn()
Message-ID: <20051117153509.EA8211EC@htj.dyndns.org>
Date: Fri, 18 Nov 2005 00:36:16 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_blk_add-uptodate-to-end_that_request_last.patch

	Add @uptodate argument to end_that_request_last() and @error
        to rq_end_io_fn().  There's no generic way to pass error code
        to request completion function, making generic error handling
        of non-fs request difficult (rq->errors is driver-specific and
        each driver uses it differently).  This patch adds @uptodate
        to end_that_request_last() and @error to rq_end_io_fn().

        For fs requests, this doesn't really matter, so just using the
        same uptodate argument used in the last call to
        end_that_request_first() should suffice.  IMHO, this can also
        help the generic command-carrying request Jens is working on.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 block/elevator.c                |    2 +-
 block/ll_rw_blk.c               |   22 +++++++++++++++-------
 drivers/block/DAC960.c          |    2 +-
 drivers/block/cciss.c           |    2 +-
 drivers/block/cpqarray.c        |    2 +-
 drivers/block/floppy.c          |    2 +-
 drivers/block/nbd.c             |    2 +-
 drivers/block/sx8.c             |    2 +-
 drivers/block/ub.c              |    2 +-
 drivers/block/viodasd.c         |    2 +-
 drivers/cdrom/cdu31a.c          |    2 +-
 drivers/ide/ide-cd.c            |    4 ++--
 drivers/ide/ide-io.c            |    6 +++---
 drivers/message/i2o/i2o_block.c |    2 +-
 drivers/mmc/mmc_block.c         |    4 ++--
 drivers/s390/block/dasd.c       |    2 +-
 drivers/s390/char/tape_block.c  |    2 +-
 drivers/scsi/ide-scsi.c         |    4 ++--
 drivers/scsi/scsi_lib.c         |    2 +-
 drivers/scsi/sd.c               |    2 +-
 include/linux/blkdev.h          |    6 +++---
 21 files changed, 42 insertions(+), 34 deletions(-)

Index: work/drivers/block/DAC960.c
===================================================================
--- work.orig/drivers/block/DAC960.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/block/DAC960.c	2005-11-18 00:35:04.000000000 +0900
@@ -3471,7 +3471,7 @@ static inline boolean DAC960_ProcessComp
 
 	 if (!end_that_request_first(Request, UpToDate, Command->BlockCount)) {
 
- 	 	end_that_request_last(Request);
+ 	 	end_that_request_last(Request, UpToDate);
 
 		if (Command->Completion) {
 			complete(Command->Completion);
Index: work/drivers/block/cciss.c
===================================================================
--- work.orig/drivers/block/cciss.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/block/cciss.c	2005-11-18 00:35:04.000000000 +0900
@@ -2299,7 +2299,7 @@ static inline void complete_command( ctl
 	printk("Done with %p\n", cmd->rq);
 #endif /* CCISS_DEBUG */ 
 
-	end_that_request_last(cmd->rq);
+	end_that_request_last(cmd->rq, status ? 1 : -EIO);
 	cmd_free(h,cmd,1);
 }
 
Index: work/drivers/block/cpqarray.c
===================================================================
--- work.orig/drivers/block/cpqarray.c	2005-11-18 00:06:46.000000000 +0900
+++ work/drivers/block/cpqarray.c	2005-11-18 00:35:04.000000000 +0900
@@ -1036,7 +1036,7 @@ static inline void complete_command(cmdl
 	complete_buffers(cmd->rq->bio, ok);
 
         DBGPX(printk("Done with %p\n", cmd->rq););
-	end_that_request_last(cmd->rq);
+	end_that_request_last(cmd->rq, ok ? 1 : -EIO);
 }
 
 /*
Index: work/drivers/block/floppy.c
===================================================================
--- work.orig/drivers/block/floppy.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/block/floppy.c	2005-11-18 00:35:04.000000000 +0900
@@ -2301,7 +2301,7 @@ static void floppy_end_request(struct re
 	add_disk_randomness(req->rq_disk);
 	floppy_off((long)req->rq_disk->private_data);
 	blkdev_dequeue_request(req);
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 
 	/* We're done with the request */
 	current_req = NULL;
Index: work/drivers/block/nbd.c
===================================================================
--- work.orig/drivers/block/nbd.c	2005-11-18 00:06:46.000000000 +0900
+++ work/drivers/block/nbd.c	2005-11-18 00:35:04.000000000 +0900
@@ -136,7 +136,7 @@ static void nbd_end_request(struct reque
 
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
-		end_that_request_last(req);
+		end_that_request_last(req, uptodate);
 	}
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
Index: work/drivers/block/sx8.c
===================================================================
--- work.orig/drivers/block/sx8.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/block/sx8.c	2005-11-18 00:35:04.000000000 +0900
@@ -770,7 +770,7 @@ static inline void carm_end_request_queu
 	rc = end_that_request_first(req, uptodate, req->hard_nr_sectors);
 	assert(rc == 0);
 
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 
 	rc = carm_put_request(host, crq);
 	assert(rc == 0);
Index: work/drivers/block/ub.c
===================================================================
--- work.orig/drivers/block/ub.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/block/ub.c	2005-11-18 00:35:04.000000000 +0900
@@ -942,7 +942,7 @@ static void ub_end_rq(struct request *rq
 
 	rc = end_that_request_first(rq, uptodate, rq->hard_nr_sectors);
 	// assert(rc == 0);
-	end_that_request_last(rq);
+	end_that_request_last(rq, uptodate);
 }
 
 /*
Index: work/drivers/block/viodasd.c
===================================================================
--- work.orig/drivers/block/viodasd.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/block/viodasd.c	2005-11-18 00:35:04.000000000 +0900
@@ -305,7 +305,7 @@ static void viodasd_end_request(struct r
 	if (end_that_request_first(req, uptodate, num_sectors))
 		return;
 	add_disk_randomness(req->rq_disk);
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 }
 
 /*
Index: work/drivers/cdrom/cdu31a.c
===================================================================
--- work.orig/drivers/cdrom/cdu31a.c	2005-11-18 00:06:46.000000000 +0900
+++ work/drivers/cdrom/cdu31a.c	2005-11-18 00:35:04.000000000 +0900
@@ -1402,7 +1402,7 @@ static void do_cdu31a_request(request_qu
 			if (!end_that_request_first(req, 1, nblock)) {
 				spin_lock_irq(q->queue_lock);
 				blkdev_dequeue_request(req);
-				end_that_request_last(req);
+				end_that_request_last(req, 1);
 				spin_unlock_irq(q->queue_lock);
 			}
 			continue;
Index: work/drivers/ide/ide-cd.c
===================================================================
--- work.orig/drivers/ide/ide-cd.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/ide/ide-cd.c	2005-11-18 00:35:04.000000000 +0900
@@ -614,7 +614,7 @@ static void cdrom_end_request (ide_drive
 			 */
 			spin_lock_irqsave(&ide_lock, flags);
 			end_that_request_chunk(failed, 0, failed->data_len);
-			end_that_request_last(failed);
+			end_that_request_last(failed, 0);
 			spin_unlock_irqrestore(&ide_lock, flags);
 		}
 
@@ -1739,7 +1739,7 @@ end_request:
 
 	spin_lock_irqsave(&ide_lock, flags);
 	blkdev_dequeue_request(rq);
-	end_that_request_last(rq);
+	end_that_request_last(rq, 1);
 	HWGROUP(drive)->rq = NULL;
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ide_stopped;
Index: work/drivers/ide/ide-io.c
===================================================================
--- work.orig/drivers/ide/ide-io.c	2005-11-18 00:06:46.000000000 +0900
+++ work/drivers/ide/ide-io.c	2005-11-18 00:35:04.000000000 +0900
@@ -89,7 +89,7 @@ int __ide_end_request(ide_drive_t *drive
 
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
-		end_that_request_last(rq);
+		end_that_request_last(rq, uptodate);
 		ret = 0;
 	}
 	return ret;
@@ -247,7 +247,7 @@ static void ide_complete_pm_request (ide
 	}
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
-	end_that_request_last(rq);
+	end_that_request_last(rq, 1);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
@@ -379,7 +379,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
 	rq->errors = err;
-	end_that_request_last(rq);
+	end_that_request_last(rq, !rq->errors);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
Index: work/drivers/message/i2o/i2o_block.c
===================================================================
--- work.orig/drivers/message/i2o/i2o_block.c	2005-11-18 00:06:46.000000000 +0900
+++ work/drivers/message/i2o/i2o_block.c	2005-11-18 00:35:04.000000000 +0900
@@ -466,7 +466,7 @@ static void i2o_block_end_request(struct
 
 	spin_lock_irqsave(q->queue_lock, flags);
 
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 
 	if (likely(dev)) {
 		dev->open_queue_depth--;
Index: work/drivers/mmc/mmc_block.c
===================================================================
--- work.orig/drivers/mmc/mmc_block.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/mmc/mmc_block.c	2005-11-18 00:35:04.000000000 +0900
@@ -263,7 +263,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 			 */
 			add_disk_randomness(req->rq_disk);
 			blkdev_dequeue_request(req);
-			end_that_request_last(req);
+			end_that_request_last(req, 1);
 		}
 		spin_unlock_irq(&md->lock);
 	} while (ret);
@@ -289,7 +289,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 	add_disk_randomness(req->rq_disk);
 	blkdev_dequeue_request(req);
-	end_that_request_last(req);
+	end_that_request_last(req, 0);
 	spin_unlock_irq(&md->lock);
 
 	return 0;
Index: work/drivers/s390/block/dasd.c
===================================================================
--- work.orig/drivers/s390/block/dasd.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/s390/block/dasd.c	2005-11-18 00:35:04.000000000 +0900
@@ -1035,7 +1035,7 @@ dasd_end_request(struct request *req, in
 	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
 	add_disk_randomness(req->rq_disk);
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 }
 
 /*
Index: work/drivers/s390/char/tape_block.c
===================================================================
--- work.orig/drivers/s390/char/tape_block.c	2005-11-18 00:06:46.000000000 +0900
+++ work/drivers/s390/char/tape_block.c	2005-11-18 00:35:04.000000000 +0900
@@ -78,7 +78,7 @@ tapeblock_end_request(struct request *re
 {
 	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 }
 
 static void
Index: work/drivers/scsi/ide-scsi.c
===================================================================
--- work.orig/drivers/scsi/ide-scsi.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/scsi/ide-scsi.c	2005-11-18 00:35:04.000000000 +0900
@@ -1046,7 +1046,7 @@ static int idescsi_eh_reset (struct scsi
 
 	/* kill current request */
 	blkdev_dequeue_request(req);
-	end_that_request_last(req);
+	end_that_request_last(req, 0);
 	if (req->flags & REQ_SENSE)
 		kfree(scsi->pc->buffer);
 	kfree(scsi->pc);
@@ -1056,7 +1056,7 @@ static int idescsi_eh_reset (struct scsi
 	/* now nuke the drive queue */
 	while ((req = elv_next_request(drive->queue))) {
 		blkdev_dequeue_request(req);
-		end_that_request_last(req);
+		end_that_request_last(req, 0);
 	}
 
 	HWGROUP(drive)->rq = NULL;
Index: work/drivers/scsi/scsi_lib.c
===================================================================
--- work.orig/drivers/scsi/scsi_lib.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/scsi_lib.c	2005-11-18 00:35:04.000000000 +0900
@@ -624,7 +624,7 @@ static struct scsi_cmnd *scsi_end_reques
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (blk_rq_tagged(req))
 		blk_queue_end_tag(q, req);
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	/*
Index: work/drivers/scsi/sd.c
===================================================================
--- work.orig/drivers/scsi/sd.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sd.c	2005-11-18 00:35:04.000000000 +0900
@@ -762,7 +762,7 @@ static void sd_end_flush(request_queue_t
 		 * force journal abort of barriers
 		 */
 		end_that_request_first(rq, -EOPNOTSUPP, rq->hard_nr_sectors);
-		end_that_request_last(rq);
+		end_that_request_last(rq, -EOPNOTSUPP);
 	}
 }
 
Index: work/include/linux/blkdev.h
===================================================================
--- work.orig/include/linux/blkdev.h	2005-11-18 00:14:29.000000000 +0900
+++ work/include/linux/blkdev.h	2005-11-18 00:35:04.000000000 +0900
@@ -102,7 +102,7 @@ void copy_io_context(struct io_context *
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
 
 struct request;
-typedef void (rq_end_io_fn)(struct request *);
+typedef void (rq_end_io_fn)(struct request *, int);
 
 struct request_list {
 	int count[2];
@@ -557,7 +557,7 @@ extern void blk_unregister_queue(struct 
 extern void register_disk(struct gendisk *dev);
 extern void generic_make_request(struct bio *bio);
 extern void blk_put_request(struct request *);
-extern void blk_end_sync_rq(struct request *rq);
+extern void blk_end_sync_rq(struct request *rq, int error);
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, gfp_t);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
@@ -607,7 +607,7 @@ static inline void blk_run_address_space
  */
 extern int end_that_request_first(struct request *, int, int);
 extern int end_that_request_chunk(struct request *, int, int);
-extern void end_that_request_last(struct request *);
+extern void end_that_request_last(struct request *, int);
 extern void end_request(struct request *req, int uptodate);
 
 /*
Index: work/block/elevator.c
===================================================================
--- work.orig/block/elevator.c	2005-11-18 00:14:21.000000000 +0900
+++ work/block/elevator.c	2005-11-18 00:35:04.000000000 +0900
@@ -484,7 +484,7 @@ struct request *elv_next_request(request
 			blkdev_dequeue_request(rq);
 			rq->flags |= REQ_QUIET;
 			end_that_request_chunk(rq, 0, nr_bytes);
-			end_that_request_last(rq);
+			end_that_request_last(rq, 0);
 		} else {
 			printk(KERN_ERR "%s: bad return=%d\n", __FUNCTION__,
 								ret);
Index: work/block/ll_rw_blk.c
===================================================================
--- work.orig/block/ll_rw_blk.c	2005-11-18 00:14:21.000000000 +0900
+++ work/block/ll_rw_blk.c	2005-11-18 00:35:04.000000000 +0900
@@ -346,7 +346,7 @@ EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 /*
  * Cache flushing for ordered writes handling
  */
-static void blk_pre_flush_end_io(struct request *flush_rq)
+static void blk_pre_flush_end_io(struct request *flush_rq, int error)
 {
 	struct request *rq = flush_rq->end_io_data;
 	request_queue_t *q = rq->q;
@@ -364,7 +364,7 @@ static void blk_pre_flush_end_io(struct 
 	}
 }
 
-static void blk_post_flush_end_io(struct request *flush_rq)
+static void blk_post_flush_end_io(struct request *flush_rq, int error)
 {
 	struct request *rq = flush_rq->end_io_data;
 	request_queue_t *q = rq->q;
@@ -2301,7 +2301,7 @@ EXPORT_SYMBOL(blk_rq_map_kern);
  */
 void blk_execute_rq_nowait(request_queue_t *q, struct gendisk *bd_disk,
 			   struct request *rq, int at_head,
-			   void (*done)(struct request *))
+			   rq_end_io_fn *done)
 {
 	int where = at_head ? ELEVATOR_INSERT_FRONT : ELEVATOR_INSERT_BACK;
 
@@ -2501,7 +2501,7 @@ EXPORT_SYMBOL(blk_put_request);
  * blk_end_sync_rq - executes a completion event on a request
  * @rq: request to complete
  */
-void blk_end_sync_rq(struct request *rq)
+void blk_end_sync_rq(struct request *rq, int error)
 {
 	struct completion *waiting = rq->waiting;
 
@@ -3163,9 +3163,17 @@ EXPORT_SYMBOL(end_that_request_chunk);
 /*
  * queue lock must be held
  */
-void end_that_request_last(struct request *req)
+void end_that_request_last(struct request *req, int uptodate)
 {
 	struct gendisk *disk = req->rq_disk;
+	int error;
+
+	/*
+	 * extend uptodate bool to allow < 0 value to be direct io error
+	 */
+	error = 0;
+	if (end_io_error(uptodate))
+		error = !uptodate ? -EIO : uptodate;
 
 	if (unlikely(laptop_mode) && blk_fs_request(req))
 		laptop_io_completion();
@@ -3180,7 +3188,7 @@ void end_that_request_last(struct reques
 		disk->in_flight--;
 	}
 	if (req->end_io)
-		req->end_io(req);
+		req->end_io(req, error);
 	else
 		__blk_put_request(req->q, req);
 }
@@ -3192,7 +3200,7 @@ void end_request(struct request *req, in
 	if (!end_that_request_first(req, uptodate, req->hard_cur_sectors)) {
 		add_disk_randomness(req->rq_disk);
 		blkdev_dequeue_request(req);
-		end_that_request_last(req);
+		end_that_request_last(req, uptodate);
 	}
 }
 

