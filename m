Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVDFMbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVDFMbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVDFMbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:31:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54500 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262188AbVDFMbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:31:42 -0400
Date: Wed, 6 Apr 2005 14:31:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050406123147.GD9417@suse.de>
References: <20050329122226.94666.qmail@web52902.mail.yahoo.com> <20050329122635.GP16636@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329122635.GP16636@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2005, Jens Axboe wrote:
> On Tue, Mar 29 2005, Chris Rankin wrote:
> > >> > I have one IDE hard disc, but I was using a USB memory stick at one
> > > > point. (Notice the usb-storage and vfat modules in my list.) Could
> > > > that be the troublesome SCSI device?
> > 
> > --- Jens Axboe <axboe@suse.de> wrote:
> > > Yes, it probably is. What happens is that you insert the stick and do io
> > > against it, which sets up a process io context for that device. That
> > > context persists until the process exits (or later, if someone still
> > > holds a reference to it), but the queue_lock will be dead when you yank
> > > the usb device.
> > > 
> > > It is quite a serious problem, not just for CFQ. SCSI referencing is
> > > badly broken there.
> > 
> > That would explain why it was nautilus which caused the oops then.
> > Does this mean that the major distros aren't using the CFQ then?
> > Because how else can they be avoiding this oops with USB storage
> > devices?
> 
> CFQ with io contexts is relatively new, only there since 2.6.10 or so.
> On UP, we don't grab the queue lock effetively so the problem isn't seen
> there.
> 
> You can work around this issue by using a different default io scheduler
> at boot time, and then select cfq for your ide hard drive when the
> system has booted with:
> 
> # echo cfq > /sys/block/hda/queue/scheduler
> 
> (substitute hda for any other solid storage device).

Can you check if this work-around solves the problem for you? Thanks!

===== include/linux/blkdev.h 1.162 vs edited =====
--- 1.162/include/linux/blkdev.h	2005-03-29 03:42:37 +02:00
+++ edited/include/linux/blkdev.h	2005-04-06 11:22:44 +02:00
@@ -279,6 +288,7 @@
 typedef int (issue_flush_fn) (request_queue_t *, struct gendisk *, sector_t *);
 typedef int (prepare_flush_fn) (request_queue_t *, struct request *);
 typedef void (end_flush_fn) (request_queue_t *, struct request *);
+typedef void (release_queue_data_fn) (request_queue_t *);
 
 enum blk_queue_state {
 	Queue_down,
@@ -324,6 +334,7 @@
 	issue_flush_fn		*issue_flush_fn;
 	prepare_flush_fn	*prepare_flush_fn;
 	end_flush_fn		*end_flush_fn;
+	release_queue_data_fn	*release_queue_data_fn;
 
 	/*
 	 * Auto-unplugging state
===== drivers/scsi/scsi_sysfs.c 1.72 vs edited =====
--- 1.72/drivers/scsi/scsi_sysfs.c	2005-03-28 07:03:53 +02:00
+++ edited/drivers/scsi/scsi_sysfs.c	2005-04-06 11:24:27 +02:00
@@ -175,9 +175,6 @@
 
 	scsi_target_reap(scsi_target(sdev));
 
-	kfree(sdev->inquiry);
-	kfree(sdev);
-
 	if (parent)
 		put_device(parent);
 }
===== drivers/scsi/scsi_lib.c 1.153 vs edited =====
--- 1.153/drivers/scsi/scsi_lib.c	2005-03-30 21:49:45 +02:00
+++ edited/drivers/scsi/scsi_lib.c	2005-04-06 11:24:32 +02:00
@@ -1420,6 +1420,18 @@
 }
 EXPORT_SYMBOL(scsi_calculate_bounce_limit);
 
+static void scsi_release_queue_data(request_queue_t *q)
+{
+	struct scsi_device *sdev = q->queuedata;
+
+	if (sdev) {
+		kfree(sdev->inquiry);
+		kfree(sdev);
+	}
+
+	q->queuedata = NULL;
+}
+
 struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
 {
 	struct Scsi_Host *shost = sdev->host;
@@ -1437,6 +1449,8 @@
 	blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	blk_queue_issue_flush_fn(q, scsi_issue_flush_fn);
+
+	q->release_queue_data_fn = scsi_release_queue_data;
 
 	/*
 	 * ordered tags are superior to flush ordering

-- 
Jens Axboe

