Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSKRNtb>; Mon, 18 Nov 2002 08:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSKRNtb>; Mon, 18 Nov 2002 08:49:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15255 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262472AbSKRNt1>;
	Mon, 18 Nov 2002 08:49:27 -0500
Date: Mon, 18 Nov 2002 14:56:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: scsi in 2.5.48
Message-ID: <20021118135614.GA834@suse.de>
References: <3DD8AF65.BF2EF851@digeo.com> <3DD8B6B9.E9EAD230@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD8B6B9.E9EAD230@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18 2002, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > Appears to be DOA.  Just a simple mke2fs hangs in get_request_wait().
> 
> This makes it work again.
> 
> 
> --- 25/drivers/scsi/scsi_lib.c~scsi-plug	Mon Nov 18 01:42:40 2002
> +++ 25-akpm/drivers/scsi/scsi_lib.c	Mon Nov 18 01:42:44 2002
> @@ -1024,7 +1024,6 @@ void scsi_request_fn(request_queue_t * q
>  			/* can happen if the prep fails 
>  			 * FIXME: elv_next_request() should be plugging the
>  			 * queue */
> -			blk_plug_device(q);
>  			break;
>  		}

Right fix would be something ala:

===== drivers/block/ll_rw_blk.c 1.143 vs edited =====
--- 1.143/drivers/block/ll_rw_blk.c	Mon Nov 18 08:28:08 2002
+++ edited/drivers/block/ll_rw_blk.c	Mon Nov 18 14:45:55 2002
@@ -1038,6 +1038,16 @@
 }
 
 /**
+ * blk_run_queue - run a single device queue
+ * @q	The queue to run
+ */
+void __blk_run_queue(request_queue_t *q)
+{
+	blk_remove_plug(q);
+	q->request_fn(q);
+}
+
+/**
  * blk_run_queues - fire all plugged queues
  *
  * Description:
@@ -2198,4 +2211,5 @@
 EXPORT_SYMBOL(blk_start_queue);
 EXPORT_SYMBOL(blk_stop_queue);
 EXPORT_SYMBOL(__blk_stop_queue);
+EXPORT_SYMBOL(__blk_run_queue);
 EXPORT_SYMBOL(blk_run_queues);
===== drivers/scsi/scsi_lib.c 1.46 vs edited =====
--- 1.46/drivers/scsi/scsi_lib.c	Mon Nov 18 08:28:09 2002
+++ edited/drivers/scsi/scsi_lib.c	Mon Nov 18 14:49:15 2002
@@ -259,7 +259,7 @@
 	/*
 	 * Just hit the requeue function for the queue.
 	 */
-	q->request_fn(q);
+	__blk_run_queue(q);
 
 	SDpnt = (Scsi_Device *) q->queuedata;
 	SHpnt = SDpnt->host;
@@ -272,8 +272,6 @@
 	 * use function pointers to pick the right one.
 	 */
 	if (SDpnt->single_lun && blk_queue_empty(q) && SDpnt->device_busy ==0) {
-		request_queue_t *q;
-
 		for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			if (((SHpnt->can_queue > 0)
 			     && (SHpnt->host_busy >= SHpnt->can_queue))
@@ -283,8 +281,7 @@
 				break;
 			}
 
-			q = &SDpnt->request_queue;
-			q->request_fn(q);
+			__blk_run_queue(&SDpnt->request_queue);
 		}
 	}
 
@@ -299,7 +296,6 @@
 	all_clear = 1;
 	if (SHpnt->some_device_starved) {
 		for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
-			request_queue_t *q;
 			if ((SHpnt->can_queue > 0 && (SHpnt->host_busy >= SHpnt->can_queue))
 			    || (SHpnt->host_blocked) 
 			    || (SHpnt->host_self_blocked)) {
@@ -308,8 +304,7 @@
 			if (SDpnt->device_blocked || !SDpnt->starved) {
 				continue;
 			}
-			q = &SDpnt->request_queue;
-			q->request_fn(q);
+			__blk_run_queue(&SDpnt->request_queue);
 			all_clear = 0;
 		}
 		if (SDpnt == NULL && all_clear) {
===== drivers/scsi/scsi_error.c 1.21 vs edited =====
--- 1.21/drivers/scsi/scsi_error.c	Sat Nov 16 20:54:08 2002
+++ edited/drivers/scsi/scsi_error.c	Mon Nov 18 14:47:49 2002
@@ -1479,8 +1479,6 @@
 	 */
 	spin_lock_irqsave(shost->host_lock, flags);
 	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
-		request_queue_t *q = &sdev->request_queue;
-
 		if ((shost->can_queue > 0 &&
 		     (shost->host_busy >= shost->can_queue))
 		    || (shost->host_blocked)
@@ -1488,7 +1486,7 @@
 			break;
 		}
 
-		q->request_fn(q);
+		__blk_run_queue(&sdev->request_queue);
 	}
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
===== include/linux/blkdev.h 1.93 vs edited =====
--- 1.93/include/linux/blkdev.h	Mon Nov 18 08:28:09 2002
+++ edited/include/linux/blkdev.h	Mon Nov 18 14:46:29 2002
@@ -321,6 +321,7 @@
 extern void blk_start_queue(request_queue_t *q);
 extern void blk_stop_queue(request_queue_t *q);
 extern void __blk_stop_queue(request_queue_t *q);
+extern void __blk_run_queue(request_queue_t *q);
 
 static inline request_queue_t *bdev_get_queue(struct block_device *bdev)
 {


-- 
Jens Axboe

