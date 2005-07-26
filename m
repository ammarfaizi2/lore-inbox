Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVGZPt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVGZPt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVGZPrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:47:52 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:11031 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261865AbVGZPqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:46:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=is0D0XsV8ISANAVlDRWgMdttijYWYwmZzb8fJxCufitQnK0jkuoyPUrMGSJhphLAsL22scQKxQq3JN4pLkB3MulipzJQkJyrgyWtzI1z0NATL1tJ/A/BSo3UghW5yLWJdkk86nvHY5ZE8sKcvyh3btTB6yEcil4E6O/aEAL5C18=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726154457.38D60C67@htj.dyndns.org>
In-Reply-To: <20050726154457.38D60C67@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 01/10] blk: add @uptodate to end_that_request_last() and @error to rq_end_io_fn()
Message-ID: <20050726154457.1ECAA5B0@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:45:56 +0900 (KST)
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

 drivers/block/DAC960.c          |    2 +-
 drivers/block/cciss.c           |    2 +-
 drivers/block/cpqarray.c        |    2 +-
 drivers/block/elevator.c        |    2 +-
 drivers/block/floppy.c          |    2 +-
 drivers/block/ll_rw_blk.c       |   20 ++++++++++++++------
 drivers/block/nbd.c             |    2 +-
 drivers/block/sx8.c             |    2 +-
 drivers/block/ub.c              |    2 +-
 drivers/block/viodasd.c         |    2 +-
 drivers/cdrom/cdu31a.c          |    2 +-
 drivers/ide/ide-cd.c            |    4 ++--
 drivers/ide/ide-io.c            |    6 +++---
 drivers/message/i2o/i2o_block.c |    6 +++---
 drivers/mmc/mmc_block.c         |    4 ++--
 drivers/s390/block/dasd.c       |    2 +-
 drivers/s390/char/tape_block.c  |    2 +-
 drivers/scsi/ide-scsi.c         |    4 ++--
 drivers/scsi/scsi_lib.c         |    8 ++++----
 drivers/scsi/sd.c               |    2 +-
 include/linux/blkdev.h          |    6 +++---
 21 files changed, 46 insertions(+), 38 deletions(-)

Index: blk-fixes/drivers/block/DAC960.c
===================================================================
--- blk-fixes.orig/drivers/block/DAC960.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/block/DAC960.c	2005-07-27 00:44:50.000000000 +0900
@@ -3480,7 +3480,7 @@ static inline boolean DAC960_ProcessComp
 
 	 if (!end_that_request_first(Request, UpToDate, Command->BlockCount)) {
 
- 	 	end_that_request_last(Request);
+ 	 	end_that_request_last(Request, UpToDate);
 
 		if (Command->Completion) {
 			complete(Command->Completion);
Index: blk-fixes/drivers/block/cciss.c
===================================================================
--- blk-fixes.orig/drivers/block/cciss.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/block/cciss.c	2005-07-27 00:44:50.000000000 +0900
@@ -2071,7 +2071,7 @@ static inline void complete_command( ctl
 	printk("Done with %p\n", cmd->rq);
 #endif /* CCISS_DEBUG */ 
 
-	end_that_request_last(cmd->rq);
+	end_that_request_last(cmd->rq, status ? 1 : -EIO);
 	cmd_free(h,cmd,1);
 }
 
Index: blk-fixes/drivers/block/cpqarray.c
===================================================================
--- blk-fixes.orig/drivers/block/cpqarray.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/block/cpqarray.c	2005-07-27 00:44:50.000000000 +0900
@@ -1036,7 +1036,7 @@ static inline void complete_command(cmdl
 	complete_buffers(cmd->rq->bio, ok);
 
         DBGPX(printk("Done with %p\n", cmd->rq););
-	end_that_request_last(cmd->rq);
+	end_that_request_last(cmd->rq, ok ? 1 : -EIO);
 }
 
 /*
Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-07-27 00:44:49.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-07-27 00:44:50.000000000 +0900
@@ -502,7 +502,7 @@ struct request *elv_next_request(request
 			blkdev_dequeue_request(rq);
 			rq->flags |= REQ_QUIET;
 			end_that_request_chunk(rq, 0, nr_bytes);
-			end_that_request_last(rq);
+			end_that_request_last(rq, 0);
 		} else {
 			printk(KERN_ERR "%s: bad return=%d\n", __FUNCTION__,
 								ret);
Index: blk-fixes/drivers/block/floppy.c
===================================================================
--- blk-fixes.orig/drivers/block/floppy.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/block/floppy.c	2005-07-27 00:44:50.000000000 +0900
@@ -2299,7 +2299,7 @@ static void floppy_end_request(struct re
 	add_disk_randomness(req->rq_disk);
 	floppy_off((long)req->rq_disk->private_data);
 	blkdev_dequeue_request(req);
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 
 	/* We're done with the request */
 	current_req = NULL;
Index: blk-fixes/drivers/block/ll_rw_blk.c
===================================================================
--- blk-fixes.orig/drivers/block/ll_rw_blk.c	2005-07-27 00:44:49.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-07-27 00:44:50.000000000 +0900
@@ -342,7 +342,7 @@ EXPORT_SYMBOL(blk_queue_issue_flush_fn);
 /*
  * Cache flushing for ordered writes handling
  */
-static void blk_pre_flush_end_io(struct request *flush_rq)
+static void blk_pre_flush_end_io(struct request *flush_rq, int error)
 {
 	struct request *rq = flush_rq->end_io_data;
 	request_queue_t *q = rq->q;
@@ -360,7 +360,7 @@ static void blk_pre_flush_end_io(struct 
 	}
 }
 
-static void blk_post_flush_end_io(struct request *flush_rq)
+static void blk_post_flush_end_io(struct request *flush_rq, int error)
 {
 	struct request *rq = flush_rq->end_io_data;
 	request_queue_t *q = rq->q;
@@ -2419,7 +2419,7 @@ EXPORT_SYMBOL(blk_put_request);
  * blk_end_sync_rq - executes a completion event on a request
  * @rq: request to complete
  */
-void blk_end_sync_rq(struct request *rq)
+void blk_end_sync_rq(struct request *rq, int error)
 {
 	struct completion *waiting = rq->waiting;
 
@@ -3104,9 +3104,17 @@ EXPORT_SYMBOL(end_that_request_chunk);
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
@@ -3127,7 +3135,7 @@ void end_that_request_last(struct reques
 		disk->in_flight--;
 	}
 	if (req->end_io)
-		req->end_io(req);
+		req->end_io(req, error);
 	else
 		__blk_put_request(req->q, req);
 }
@@ -3139,7 +3147,7 @@ void end_request(struct request *req, in
 	if (!end_that_request_first(req, uptodate, req->hard_cur_sectors)) {
 		add_disk_randomness(req->rq_disk);
 		blkdev_dequeue_request(req);
-		end_that_request_last(req);
+		end_that_request_last(req, uptodate);
 	}
 }
 
Index: blk-fixes/drivers/block/nbd.c
===================================================================
--- blk-fixes.orig/drivers/block/nbd.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/block/nbd.c	2005-07-27 00:44:50.000000000 +0900
@@ -136,7 +136,7 @@ static void nbd_end_request(struct reque
 
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
-		end_that_request_last(req);
+		end_that_request_last(req, uptodate);
 	}
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
Index: blk-fixes/drivers/block/sx8.c
===================================================================
--- blk-fixes.orig/drivers/block/sx8.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/block/sx8.c	2005-07-27 00:44:50.000000000 +0900
@@ -746,7 +746,7 @@ static inline void carm_end_request_queu
 	rc = end_that_request_first(req, uptodate, req->hard_nr_sectors);
 	assert(rc == 0);
 
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 
 	rc = carm_put_request(host, crq);
 	assert(rc == 0);
Index: blk-fixes/drivers/block/ub.c
===================================================================
--- blk-fixes.orig/drivers/block/ub.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/block/ub.c	2005-07-27 00:44:50.000000000 +0900
@@ -875,7 +875,7 @@ static void ub_end_rq(struct request *rq
 
 	rc = end_that_request_first(rq, uptodate, rq->hard_nr_sectors);
 	// assert(rc == 0);
-	end_that_request_last(rq);
+	end_that_request_last(rq, uptodate);
 }
 
 /*
Index: blk-fixes/drivers/block/viodasd.c
===================================================================
--- blk-fixes.orig/drivers/block/viodasd.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/block/viodasd.c	2005-07-27 00:44:50.000000000 +0900
@@ -305,7 +305,7 @@ static void viodasd_end_request(struct r
 	if (end_that_request_first(req, uptodate, num_sectors))
 		return;
 	add_disk_randomness(req->rq_disk);
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 }
 
 /*
Index: blk-fixes/drivers/cdrom/cdu31a.c
===================================================================
--- blk-fixes.orig/drivers/cdrom/cdu31a.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/cdrom/cdu31a.c	2005-07-27 00:44:50.000000000 +0900
@@ -1402,7 +1402,7 @@ static void do_cdu31a_request(request_qu
 			if (!end_that_request_first(req, 1, nblock)) {
 				spin_lock_irq(q->queue_lock);
 				blkdev_dequeue_request(req);
-				end_that_request_last(req);
+				end_that_request_last(req, 1);
 				spin_unlock_irq(q->queue_lock);
 			}
 			continue;
Index: blk-fixes/drivers/ide/ide-cd.c
===================================================================
--- blk-fixes.orig/drivers/ide/ide-cd.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/ide/ide-cd.c	2005-07-27 00:44:50.000000000 +0900
@@ -616,7 +616,7 @@ static void cdrom_end_request (ide_drive
 			 */
 			spin_lock_irqsave(&ide_lock, flags);
 			end_that_request_chunk(failed, 0, failed->data_len);
-			end_that_request_last(failed);
+			end_that_request_last(failed, 0);
 			spin_unlock_irqrestore(&ide_lock, flags);
 		}
 
@@ -1741,7 +1741,7 @@ end_request:
 
 	spin_lock_irqsave(&ide_lock, flags);
 	blkdev_dequeue_request(rq);
-	end_that_request_last(rq);
+	end_that_request_last(rq, 1);
 	HWGROUP(drive)->rq = NULL;
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ide_stopped;
Index: blk-fixes/drivers/ide/ide-io.c
===================================================================
--- blk-fixes.orig/drivers/ide/ide-io.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/ide/ide-io.c	2005-07-27 00:44:50.000000000 +0900
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
 
Index: blk-fixes/drivers/message/i2o/i2o_block.c
===================================================================
--- blk-fixes.orig/drivers/message/i2o/i2o_block.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/message/i2o/i2o_block.c	2005-07-27 00:44:50.000000000 +0900
@@ -452,7 +452,7 @@ static int i2o_block_reply(struct i2o_co
 
 		while (end_that_request_chunk(req, !req->errors,
 					      le32_to_cpu(pmsg->body[1]))) ;
-		end_that_request_last(req);
+		end_that_request_last(req, !req->errors);
 
 		dev->open_queue_depth--;
 		list_del(&ireq->queue);
@@ -489,7 +489,7 @@ static int i2o_block_reply(struct i2o_co
 		spin_lock_irqsave(q->queue_lock, flags);
 		while (end_that_request_chunk
 		       (req, !req->errors, le32_to_cpu(msg->body[1]))) ;
-		end_that_request_last(req);
+		end_that_request_last(req, !req->errors);
 
 		dev->open_queue_depth--;
 		list_del(&ireq->queue);
@@ -554,7 +554,7 @@ static int i2o_block_reply(struct i2o_co
 		add_disk_randomness(req->rq_disk);
 		spin_lock_irqsave(q->queue_lock, flags);
 
-		end_that_request_last(req);
+		end_that_request_last(req, !req->errors);
 
 		dev->open_queue_depth--;
 		list_del(&ireq->queue);
Index: blk-fixes/drivers/mmc/mmc_block.c
===================================================================
--- blk-fixes.orig/drivers/mmc/mmc_block.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/mmc/mmc_block.c	2005-07-27 00:44:50.000000000 +0900
@@ -254,7 +254,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 			 */
 			add_disk_randomness(req->rq_disk);
 			blkdev_dequeue_request(req);
-			end_that_request_last(req);
+			end_that_request_last(req, 1);
 		}
 		spin_unlock_irq(&md->lock);
 	} while (ret);
@@ -280,7 +280,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 	add_disk_randomness(req->rq_disk);
 	blkdev_dequeue_request(req);
-	end_that_request_last(req);
+	end_that_request_last(req, 0);
 	spin_unlock_irq(&md->lock);
 
 	return 0;
Index: blk-fixes/drivers/s390/block/dasd.c
===================================================================
--- blk-fixes.orig/drivers/s390/block/dasd.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/s390/block/dasd.c	2005-07-27 00:44:50.000000000 +0900
@@ -1039,7 +1039,7 @@ dasd_end_request(struct request *req, in
 	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
 	add_disk_randomness(req->rq_disk);
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 }
 
 /*
Index: blk-fixes/drivers/s390/char/tape_block.c
===================================================================
--- blk-fixes.orig/drivers/s390/char/tape_block.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/s390/char/tape_block.c	2005-07-27 00:44:50.000000000 +0900
@@ -78,7 +78,7 @@ tapeblock_end_request(struct request *re
 {
 	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 }
 
 static void
Index: blk-fixes/drivers/scsi/ide-scsi.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ide-scsi.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/ide-scsi.c	2005-07-27 00:44:50.000000000 +0900
@@ -1039,7 +1039,7 @@ static int idescsi_eh_reset (struct scsi
 
 	/* kill current request */
 	blkdev_dequeue_request(req);
-	end_that_request_last(req);
+	end_that_request_last(req, 0);
 	if (req->flags & REQ_SENSE)
 		kfree(scsi->pc->buffer);
 	kfree(scsi->pc);
@@ -1049,7 +1049,7 @@ static int idescsi_eh_reset (struct scsi
 	/* now nuke the drive queue */
 	while ((req = elv_next_request(drive->queue))) {
 		blkdev_dequeue_request(req);
-		end_that_request_last(req);
+		end_that_request_last(req, 0);
 	}
 
 	HWGROUP(drive)->rq = NULL;
Index: blk-fixes/drivers/scsi/scsi_lib.c
===================================================================
--- blk-fixes.orig/drivers/scsi/scsi_lib.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/scsi_lib.c	2005-07-27 00:44:50.000000000 +0900
@@ -258,7 +258,7 @@ static void scsi_wait_done(struct scsi_c
 /* This is the end routine we get to if a command was never attached
  * to the request.  Simply complete the request without changing
  * rq_status; this will cause a DRIVER_ERROR. */
-static void scsi_wait_req_end_io(struct request *req)
+static void scsi_wait_req_end_io(struct request *req, int error)
 {
 	BUG_ON(!req->waiting);
 
@@ -574,7 +574,7 @@ static struct scsi_cmnd *scsi_end_reques
 	spin_lock_irqsave(q->queue_lock, flags);
 	if (blk_rq_tagged(req))
 		blk_queue_end_tag(q, req);
-	end_that_request_last(req);
+	end_that_request_last(req, uptodate);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	/*
@@ -1259,7 +1259,7 @@ static void scsi_kill_requests(request_q
 		req->flags |= REQ_QUIET;
 		while (end_that_request_first(req, 0, req->nr_sectors))
 			;
-		end_that_request_last(req);
+		end_that_request_last(req, 0);
 	}
 }
 
@@ -1314,7 +1314,7 @@ static void scsi_request_fn(struct reque
 			req->flags |= REQ_QUIET;
 			while (end_that_request_first(req, 0, req->nr_sectors))
 				;
-			end_that_request_last(req);
+			end_that_request_last(req, 0);
 			continue;
 		}
 
Index: blk-fixes/drivers/scsi/sd.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sd.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sd.c	2005-07-27 00:44:50.000000000 +0900
@@ -758,7 +758,7 @@ static void sd_end_flush(request_queue_t
 		 * force journal abort of barriers
 		 */
 		end_that_request_first(rq, -EOPNOTSUPP, rq->hard_nr_sectors);
-		end_that_request_last(rq);
+		end_that_request_last(rq, -EOPNOTSUPP);
 	}
 }
 
Index: blk-fixes/include/linux/blkdev.h
===================================================================
--- blk-fixes.orig/include/linux/blkdev.h	2005-07-27 00:44:49.000000000 +0900
+++ blk-fixes/include/linux/blkdev.h	2005-07-27 00:44:50.000000000 +0900
@@ -94,7 +94,7 @@ void copy_io_context(struct io_context *
 void swap_io_context(struct io_context **ioc1, struct io_context **ioc2);
 
 struct request;
-typedef void (rq_end_io_fn)(struct request *);
+typedef void (rq_end_io_fn)(struct request *, int);
 
 struct request_list {
 	int count[2];
@@ -550,7 +550,7 @@ extern void blk_unregister_queue(struct 
 extern void register_disk(struct gendisk *dev);
 extern void generic_make_request(struct bio *bio);
 extern void blk_put_request(struct request *);
-extern void blk_end_sync_rq(struct request *rq);
+extern void blk_end_sync_rq(struct request *rq, int error);
 extern void blk_attempt_remerge(request_queue_t *, struct request *);
 extern void __blk_attempt_remerge(request_queue_t *, struct request *);
 extern struct request *blk_get_request(request_queue_t *, int, int);
@@ -601,7 +601,7 @@ static inline void blk_run_address_space
  */
 extern int end_that_request_first(struct request *, int, int);
 extern int end_that_request_chunk(struct request *, int, int);
-extern void end_that_request_last(struct request *);
+extern void end_that_request_last(struct request *, int);
 extern void end_request(struct request *req, int uptodate);
 
 /*

