Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVDGGus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVDGGus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 02:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVDGGue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 02:50:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5250 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261604AbVDGGtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 02:49:42 -0400
Date: Thu, 7 Apr 2005 08:49:35 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050407064934.GJ15165@suse.de>
References: <20050329115405.97559.qmail@web52909.mail.yahoo.com> <20050329120311.GO16636@suse.de> <1112804840.5476.16.camel@mulgrave> <20050406175838.GC15165@suse.de> <1112811607.5555.15.camel@mulgrave> <20050406190838.GE15165@suse.de> <1112821799.5850.19.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112821799.5850.19.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06 2005, James Bottomley wrote:
> On Wed, 2005-04-06 at 21:08 +0200, Jens Axboe wrote:
> > > I think the correct model for all of this is that the block driver
> > > shouldn't care (or be tied to) the scsi one.  Thus, as long as SCSI can
> > > reject requests from a queue whose device has been released (without
> > > checking the device) then everything is fine as long as we sort out the
> > > lock lifetime problem.
> > 
> > But you are tying it completely to the SCSI problem, since we have no
> > locking problems of this sort elsewhere. At least the notified could
> > potentially be used for something else. The lock is just hack number two
> > to work around the problem.
> 
> Then help me understand the problem as you see it.
> 
> My current understanding is that these problems occur because we've
> mixed data in two objects of different lifetimes.  So far, this is stack
> independent.

Correct.

> My proposal is to correct this by moving the data back to the correct
> object, and make any object using it hold a reference, so this would
> make the provider of the block request_fn hold a reference to the queue
> and initialise the queue lock pointer with the lock currently in the
> queue.  Drivers that still use a global lock would be unaffected.  This

But this is the current requirement, as long as you use the queue you
must hold a reference to it.

> also means that any provider of a request_fn may expect to process (and
> reject) requests for a period of time after blk_cleanup_queue().
> Really, this refcounting is inherent in blk_init_queue(),
> blk_cleanup_queue() so the only additional requirement is sanely
> processing queue requests after you think it's been cleaned up.  This is
> request_fn() provider independent, I think (providers who currently
> don't violate the lifetime rules don't need fixing).
> 
> I claim that this proposal solves the current problem, and any other
> ones we run across that occur because of data mixing.

The lock is just one piece, but I guess it is the only remaining after
the ->request_fn switchover killing requests. So perhaps it is just
easier to embed the lock to kill off that problem.

What do you think of the attached, then? Allow NULL lock to be passed
in, in which case we use the queue private lock (that no one should ever
ever touch). It looks a little confusing that
sdev->request_queue->queue_lock now protects some sdev structures, if
you want we can retain ->sdev_lock but as a pointer to the queue lock
instead.

> Your current patch tries to solve the problem by tying the two objects
> together; unifying the lifetimes.  I agree this can be done (it was how
> the sd/sr close race was fixed). But the current way the freeing
> functions thread across the subsystems doesn't look nice and I don't
> currently see a way to get the queue freed:  We free the queue on scsi
> device release; if the queue holds a reference to the scsi_device, the
> release function will never be called.  Our only other choice is to try
> to free the queue on device_del instead, but that's too early, I think.

Hmm yes, it probably doesn't work. Unless we properly embed the affected
structures, I don't think it can work.


===== drivers/block/ll_rw_blk.c 1.288 vs edited =====
--- 1.288/drivers/block/ll_rw_blk.c	2005-03-31 12:47:54 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2005-04-07 08:38:01 +02:00
@@ -1714,6 +1711,15 @@ request_queue_t *blk_init_queue(request_
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
===== drivers/scsi/scsi_lib.c 1.153 vs edited =====
--- 1.153/drivers/scsi/scsi_lib.c	2005-03-30 21:49:45 +02:00
+++ edited/drivers/scsi/scsi_lib.c	2005-04-07 08:42:30 +02:00
@@ -360,9 +360,9 @@ void scsi_device_unbusy(struct scsi_devi
 		     shost->host_failed))
 		scsi_eh_wakeup(shost);
 	spin_unlock(shost->host_lock);
-	spin_lock(&sdev->sdev_lock);
+	spin_lock(sdev->request_queue->queue_lock);
 	sdev->device_busy--;
-	spin_unlock_irqrestore(&sdev->sdev_lock, flags);
+	spin_unlock_irqrestore(sdev->request_queue->queue_lock, flags);
 }
 
 /*
@@ -1425,7 +1425,7 @@ struct request_queue *scsi_alloc_queue(s
 	struct Scsi_Host *shost = sdev->host;
 	struct request_queue *q;
 
-	q = blk_init_queue(scsi_request_fn, &sdev->sdev_lock);
+	q = blk_init_queue(scsi_request_fn, NULL);
 	if (!q)
 		return NULL;
 
===== drivers/scsi/scsi_scan.c 1.143 vs edited =====
--- 1.143/drivers/scsi/scsi_scan.c	2005-03-23 22:58:13 +01:00
+++ edited/drivers/scsi/scsi_scan.c	2005-04-07 08:40:53 +02:00
@@ -249,7 +249,6 @@ static struct scsi_device *scsi_alloc_sd
 	 */
 	sdev->borken = 1;
 
-	spin_lock_init(&sdev->sdev_lock);
 	sdev->request_queue = scsi_alloc_queue(sdev);
 	if (!sdev->request_queue) {
 		/* release fn is set up in scsi_sysfs_device_initialise, so
===== include/linux/blkdev.h 1.162 vs edited =====
--- 1.162/include/linux/blkdev.h	2005-03-29 03:42:37 +02:00
+++ edited/include/linux/blkdev.h	2005-04-07 08:36:06 +02:00
@@ -355,8 +364,11 @@ struct request_queue
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
===== include/scsi/scsi_device.h 1.33 vs edited =====
--- 1.33/include/scsi/scsi_device.h	2005-03-23 22:58:05 +01:00
+++ edited/include/scsi/scsi_device.h	2005-04-07 08:41:09 +02:00
@@ -44,7 +44,6 @@ struct scsi_device {
 	struct list_head    same_target_siblings; /* just the devices sharing same target id */
 
 	volatile unsigned short device_busy;	/* commands actually active on low-level */
-	spinlock_t sdev_lock;           /* also the request queue_lock */
 	spinlock_t list_lock;
 	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
 	struct list_head starved_entry;


-- 
Jens Axboe

