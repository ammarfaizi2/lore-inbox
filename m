Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVDFMz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVDFMz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVDFMz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:55:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63105 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262174AbVDFMzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:55:38 -0400
Date: Wed, 6 Apr 2005 14:55:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050406125536.GG9417@suse.de>
References: <20050329122226.94666.qmail@web52902.mail.yahoo.com> <20050329122635.GP16636@suse.de> <20050406123147.GD9417@suse.de> <1112791930.6275.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112791930.6275.69.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06 2005, Arjan van de Ven wrote:
> > @@ -324,6 +334,7 @@
> >  	issue_flush_fn		*issue_flush_fn;
> >  	prepare_flush_fn	*prepare_flush_fn;
> >  	end_flush_fn		*end_flush_fn;
> > +	release_queue_data_fn	*release_queue_data_fn;
> >  
> >  	/*
> >  	 * Auto-unplugging state
> 
> where does this function method actually get called?

I missed the hunk in ll_rw_blk.c, rmk pointed the same thing out not 5
minutes ago :-)

The patch would not work anyways, as scsi_sysfs.c clears queuedata
unconditionally. This is a better work-around, it just makes the queue
hold a reference to the device as well only killing it when the queue is
torn down.

Still not super happy with it, but I don't see how to solve the circular
dependency problem otherwise.


===== drivers/scsi/scsi_lib.c 1.153 vs edited =====
--- 1.153/drivers/scsi/scsi_lib.c	2005-03-30 21:49:45 +02:00
+++ edited/drivers/scsi/scsi_lib.c	2005-04-06 14:41:15 +02:00
@@ -1420,6 +1420,13 @@
 }
 EXPORT_SYMBOL(scsi_calculate_bounce_limit);
 
+static void scsi_release_queue_data(request_queue_t *q)
+{
+	struct scsi_device *sdev = q->queuedata;
+
+	put_device(&sdev->sdev_gendev);
+}
+
 struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
 {
 	struct Scsi_Host *shost = sdev->host;
@@ -1437,6 +1444,12 @@
 	blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	blk_queue_issue_flush_fn(q, scsi_issue_flush_fn);
+
+	/*
+	 * let the queue drop a reference, when it is killed
+	 */
+	get_device(&sdev->sdev_gendev);
+	q->release_queue_data_fn = scsi_release_queue_data;
 
 	/*
 	 * ordered tags are superior to flush ordering
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
===== drivers/block/ll_rw_blk.c 1.288 vs edited =====
--- 1.288/drivers/block/ll_rw_blk.c	2005-03-31 12:47:54 +02:00
+++ edited/drivers/block/ll_rw_blk.c	2005-04-06 11:24:51 +02:00
@@ -1621,6 +1623,9 @@
 
 	blk_sync_queue(q);
 
+	if (q->release_queue_data_fn)
+		q->release_queue_data_fn(q);
+
 	if (rl->rq_pool)
 		mempool_destroy(rl->rq_pool);
 

-- 
Jens Axboe

