Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVKQPjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVKQPjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVKQPjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:39:10 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:37790 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751335AbVKQPhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:37:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=ivwd6ReE+o5nXmvg5B5shBbcrApudH4JPU0yyv2njnprSMvtZHzq5gRpfQnQYSVSRbOjqKtfPqpiTIv7nPx/fxxAQJlXRQiaUFaB6hF71vh4bHZ0QzZyhUpYN1QUjSlW8HB1W/DgqIuY/8EslIM0wdqmsrQ+5sAefmGODeiHhOQ=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051117153509.B89B4777@htj.dyndns.org>
In-Reply-To: <20051117153509.B89B4777@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/10] blk: update IDE to use new blk_ordered
Message-ID: <20051117153509.061D8991@htj.dyndns.org>
Date: Fri, 18 Nov 2005 00:36:51 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08_blk_ide-update-ordered.patch

	Update IDE to use new blk_ordered.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-disk.c |   57 +++++++++------------------------------------------------
 ide-io.c   |    5 +----
 2 files changed, 10 insertions(+), 52 deletions(-)

Index: work/drivers/ide/ide-disk.c
===================================================================
--- work.orig/drivers/ide/ide-disk.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/ide/ide-disk.c	2005-11-18 00:35:06.000000000 +0900
@@ -681,50 +681,9 @@ static ide_proc_entry_t idedisk_proc[] =
 
 #endif	/* CONFIG_PROC_FS */
 
-static void idedisk_end_flush(request_queue_t *q, struct request *flush_rq)
+static void idedisk_prepare_flush(request_queue_t *q, struct request *rq)
 {
 	ide_drive_t *drive = q->queuedata;
-	struct request *rq = flush_rq->end_io_data;
-	int good_sectors = rq->hard_nr_sectors;
-	int bad_sectors;
-	sector_t sector;
-
-	if (flush_rq->errors & ABRT_ERR) {
-		printk(KERN_ERR "%s: barrier support doesn't work\n", drive->name);
-		blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE);
-		blk_queue_issue_flush_fn(drive->queue, NULL);
-		good_sectors = 0;
-	} else if (flush_rq->errors) {
-		good_sectors = 0;
-		if (blk_barrier_preflush(rq)) {
-			sector = ide_get_error_location(drive,flush_rq->buffer);
-			if ((sector >= rq->hard_sector) &&
-			    (sector < rq->hard_sector + rq->hard_nr_sectors))
-				good_sectors = sector - rq->hard_sector;
-		}
-	}
-
-	if (flush_rq->errors)
-		printk(KERN_ERR "%s: failed barrier write: "
-				"sector=%Lx(good=%d/bad=%d)\n",
-				drive->name, (unsigned long long)rq->sector,
-				good_sectors,
-				(int) (rq->hard_nr_sectors-good_sectors));
-
-	bad_sectors = rq->hard_nr_sectors - good_sectors;
-
-	if (good_sectors)
-		__ide_end_request(drive, rq, 1, good_sectors);
-	if (bad_sectors)
-		__ide_end_request(drive, rq, 0, bad_sectors);
-}
-
-static int idedisk_prepare_flush(request_queue_t *q, struct request *rq)
-{
-	ide_drive_t *drive = q->queuedata;
-
-	if (!drive->wcache)
-		return 0;
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 
@@ -735,9 +694,8 @@ static int idedisk_prepare_flush(request
 		rq->cmd[0] = WIN_FLUSH_CACHE;
 
 
-	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
+	rq->flags |= REQ_DRIVE_TASK;
 	rq->buffer = rq->cmd;
-	return 1;
 }
 
 static int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
@@ -1012,11 +970,12 @@ static void idedisk_setup (ide_drive_t *
 	printk(KERN_INFO "%s: cache flushes %ssupported\n",
 		drive->name, barrier ? "" : "not ");
 	if (barrier) {
-		blk_queue_ordered(drive->queue, QUEUE_ORDERED_FLUSH);
-		drive->queue->prepare_flush_fn = idedisk_prepare_flush;
-		drive->queue->end_flush_fn = idedisk_end_flush;
+		blk_queue_ordered(drive->queue, QUEUE_ORDERED_DRAIN_FLUSH,
+				  idedisk_prepare_flush, GFP_KERNEL);
 		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
-	}
+	} else if (!drive->wcache)
+		blk_queue_ordered(drive->queue, QUEUE_ORDERED_DRAIN,
+				  NULL, GFP_KERNEL);
 }
 
 static void ide_cacheflush_p(ide_drive_t *drive)
@@ -1034,6 +993,8 @@ static int ide_disk_remove(struct device
 	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = idkp->disk;
 
+	blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE, NULL, 0);
+
 	ide_cacheflush_p(drive);
 
 	ide_unregister_subdriver(drive, idkp->driver);
Index: work/drivers/ide/ide-io.c
===================================================================
--- work.orig/drivers/ide/ide-io.c	2005-11-18 00:35:04.000000000 +0900
+++ work/drivers/ide/ide-io.c	2005-11-18 00:35:06.000000000 +0900
@@ -119,10 +119,7 @@ int ide_end_request (ide_drive_t *drive,
 	if (!nr_sectors)
 		nr_sectors = rq->hard_cur_sectors;
 
-	if (blk_complete_barrier_rq_locked(drive->queue, rq, nr_sectors))
-		ret = rq->nr_sectors != 0;
-	else
-		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
+	ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ret;

