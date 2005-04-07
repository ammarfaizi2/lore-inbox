Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVDGNTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVDGNTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVDGNTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:19:30 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:43429 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262460AbVDGNSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:18:45 -0400
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050407064934.GJ15165@suse.de>
References: <20050329115405.97559.qmail@web52909.mail.yahoo.com>
	 <20050329120311.GO16636@suse.de> <1112804840.5476.16.camel@mulgrave>
	 <20050406175838.GC15165@suse.de> <1112811607.5555.15.camel@mulgrave>
	 <20050406190838.GE15165@suse.de> <1112821799.5850.19.camel@mulgrave>
	 <20050407064934.GJ15165@suse.de>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:18:38 -0400
Message-Id: <1112879919.5842.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 08:49 +0200, Jens Axboe wrote:
> On Wed, Apr 06 2005, James Bottomley wrote:
> > My proposal is to correct this by moving the data back to the correct
> > object, and make any object using it hold a reference, so this would
> > make the provider of the block request_fn hold a reference to the queue
> > and initialise the queue lock pointer with the lock currently in the
> > queue.  Drivers that still use a global lock would be unaffected.  This
> 
> But this is the current requirement, as long as you use the queue you
> must hold a reference to it.

Exactly! that's why I think this solution must work independently of
subsystem.

> What do you think of the attached, then? Allow NULL lock to be passed
> in, in which case we use the queue private lock (that no one should ever
> ever touch). It looks a little confusing that
> sdev->request_queue->queue_lock now protects some sdev structures, if
> you want we can retain ->sdev_lock but as a pointer to the queue lock
> instead.

Looks good.  How about the attached modification?  It makes sdev_lock a
pointer that uses the queue lock which we null out when we release it
(not that I don't trust SCSI or anything ;-)

James

===== drivers/block/ll_rw_blk.c 1.287 vs edited =====
--- 1.287/drivers/block/ll_rw_blk.c	2005-03-11 15:32:27 -05:00
+++ edited/drivers/block/ll_rw_blk.c	2005-04-07 09:05:19 -04:00
@@ -1714,6 +1714,15 @@
 	if (blk_init_free_list(q))
 		goto out_init;
 
+	/*
+	 * if caller didn't supply a lock, they get per-queue locking with
+	 * our embedded lock
+	 */
+	if (!lock) {
+		spin_lock_init(&q->__queue_lock);
+		lock = &q->__queue_lock;
+	}
+
 	q->request_fn		= rfn;
 	q->back_merge_fn       	= ll_back_merge_fn;
 	q->front_merge_fn      	= ll_front_merge_fn;
===== drivers/scsi/scsi_lib.c 1.151 vs edited =====
--- 1.151/drivers/scsi/scsi_lib.c	2005-02-17 14:17:22 -05:00
+++ edited/drivers/scsi/scsi_lib.c	2005-04-07 09:10:31 -04:00
@@ -349,9 +349,9 @@
 		     shost->host_failed))
 		scsi_eh_wakeup(shost);
 	spin_unlock(shost->host_lock);
-	spin_lock(&sdev->sdev_lock);
+	spin_lock(sdev->sdev_lock);
 	sdev->device_busy--;
-	spin_unlock_irqrestore(&sdev->sdev_lock, flags);
+	spin_unlock_irqrestore(sdev->sdev_lock, flags);
 }
 
 /*
@@ -1391,7 +1391,7 @@
 	struct Scsi_Host *shost = sdev->host;
 	struct request_queue *q;
 
-	q = blk_init_queue(scsi_request_fn, &sdev->sdev_lock);
+	q = blk_init_queue(scsi_request_fn, NULL);
 	if (!q)
 		return NULL;
 
===== drivers/scsi/scsi_scan.c 1.142 vs edited =====
--- 1.142/drivers/scsi/scsi_scan.c	2005-02-16 13:21:35 -05:00
+++ edited/drivers/scsi/scsi_scan.c	2005-04-07 09:10:01 -04:00
@@ -249,7 +249,6 @@
 	 */
 	sdev->borken = 1;
 
-	spin_lock_init(&sdev->sdev_lock);
 	sdev->request_queue = scsi_alloc_queue(sdev);
 	if (!sdev->request_queue) {
 		/* release fn is set up in scsi_sysfs_device_initialise, so
@@ -257,7 +256,8 @@
 		put_device(&starget->dev);
 		goto out;
 	}
-
+	/* Now make the sdev_lock point to the request queue lock */
+	sdev->sdev_lock = q->queue_lock;
 	sdev->request_queue->queuedata = sdev;
 	scsi_adjust_queue_depth(sdev, 0, sdev->host->cmd_per_lun);
 
===== drivers/scsi/scsi_sysfs.c 1.69 vs edited =====
--- 1.69/drivers/scsi/scsi_sysfs.c	2005-02-16 20:05:37 -05:00
+++ edited/drivers/scsi/scsi_sysfs.c	2005-04-07 09:12:17 -04:00
@@ -168,6 +168,9 @@
 	list_del(&sdev->starved_entry);
 	spin_unlock_irqrestore(sdev->host->host_lock, flags);
 
+	/* After releasing the queue we may no longer access its lock */
+	BUG_ON(spin_is_locked(sdev->sdev_lock));
+	sdev->sdev_lock = NULL;
 	if (sdev->request_queue)
 		scsi_free_queue(sdev->request_queue);
 
===== include/linux/blkdev.h 1.161 vs edited =====
--- 1.161/include/linux/blkdev.h	2005-03-09 03:03:24 -05:00
+++ edited/include/linux/blkdev.h	2005-04-07 09:05:21 -04:00
@@ -355,8 +355,11 @@
 	unsigned long		queue_flags;
 
 	/*
-	 * protects queue structures from reentrancy
+	 * protects queue structures from reentrancy. ->__queue_lock should
+	 * _never_ be used directly, it is queue private. always use
+	 * ->queue_lock.
 	 */
+	spinlock_t		__queue_lock;
 	spinlock_t		*queue_lock;
 
 	/*
===== include/scsi/scsi_device.h 1.32 vs edited =====
--- 1.32/include/scsi/scsi_device.h	2005-02-17 14:15:51 -05:00
+++ edited/include/scsi/scsi_device.h	2005-04-07 09:08:25 -04:00
@@ -44,7 +44,7 @@
 	struct list_head    same_target_siblings; /* just the devices sharing same target id */
 
 	volatile unsigned short device_busy;	/* commands actually active on low-level */
-	spinlock_t sdev_lock;           /* also the request queue_lock */
+	spinlock_t *sdev_lock;           /* pointer to the request queue_lock */
 	spinlock_t list_lock;
 	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
 	struct list_head starved_entry;


