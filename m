Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271930AbRH2I1G>; Wed, 29 Aug 2001 04:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271932AbRH2I04>; Wed, 29 Aug 2001 04:26:56 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:36363 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S271930AbRH2I0j>; Wed, 29 Aug 2001 04:26:39 -0400
Date: Wed, 29 Aug 2001 10:25:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kevin.vanmaren@unisys.com, linux-kernel@vger.kernel.org
Subject: Re: The cause of the "VM" performance problem with 2.4.X
Message-ID: <20010829102510.I640@suse.de>
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F5F@us-slc-exch-3.slc.unisys.com> <200108281852.f7SIqos15325@penguin.transmeta.com> <20010829102216.H640@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20010829102216.H640@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 29 2001, Jens Axboe wrote:
> > >  4.51    432.97    25.70 13445261     0.00     0.00  blk_get_queue
> > 
> > Now, while I don't worry about "getblk()" itself, the request stuff and
> > blk_get_queue() _can_ be quite an issue even under non-mkfs load, so
> 
> blk_get_queue() is easy to 'fix', it grabs io_request_lock for no good
> reason at all. I think this must have been a failed attempt to protect
> switching of queues, however it's obviously very broken in this regard.
> So in fact no skin is off our nose for just removing the io_request_lock
> in that path. 2.5 will have it properly reference counted...

Linus, will you take this patch to remove io_request_lock in this path?

-- 
Jens Axboe


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=blk-get-queue-lock-1

--- drivers/block/ll_rw_blk.c~	Wed Aug 29 10:22:50 2001
+++ drivers/block/ll_rw_blk.c	Wed Aug 29 10:23:12 2001
@@ -131,7 +131,7 @@
 	return max_sectors[MAJOR(dev)][MINOR(dev)];
 }
 
-inline request_queue_t *__blk_get_queue(kdev_t dev)
+inline request_queue_t *blk_get_queue(kdev_t dev)
 {
 	struct blk_dev_struct *bdev = blk_dev + MAJOR(dev);
 
@@ -141,22 +141,6 @@
 		return &blk_dev[MAJOR(dev)].request_queue;
 }
 
-/*
- * NOTE: the device-specific queue() functions
- * have to be atomic!
- */
-request_queue_t *blk_get_queue(kdev_t dev)
-{
-	request_queue_t *ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&io_request_lock,flags);
-	ret = __blk_get_queue(dev);
-	spin_unlock_irqrestore(&io_request_lock,flags);
-
-	return ret;
-}
-
 static int __blk_cleanup_queue(struct list_head *head)
 {
 	struct request *rq;
@@ -1272,7 +1256,6 @@
 EXPORT_SYMBOL(end_that_request_last);
 EXPORT_SYMBOL(blk_init_queue);
 EXPORT_SYMBOL(blk_get_queue);
-EXPORT_SYMBOL(__blk_get_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);
 EXPORT_SYMBOL(blk_queue_headactive);
 EXPORT_SYMBOL(blk_queue_make_request);
--- include/linux/blkdev.h~	Wed Aug 29 10:23:19 2001
+++ include/linux/blkdev.h	Wed Aug 29 10:23:29 2001
@@ -149,8 +149,7 @@
 extern void grok_partitions(struct gendisk *dev, int drive, unsigned minors, long size);
 extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
 extern void generic_make_request(int rw, struct buffer_head * bh);
-extern request_queue_t *blk_get_queue(kdev_t dev);
-extern inline request_queue_t *__blk_get_queue(kdev_t dev);
+extern inline request_queue_t *blk_get_queue(kdev_t dev);
 extern void blkdev_release_request(struct request *);
 
 /*

--mYCpIKhGyMATD0i+--
