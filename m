Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVKXQ1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVKXQ1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVKXQ1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:27:22 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:53347 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932255AbVKXQ02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:26:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=T+k4kpYpHvDmmEh68xpdAtG0zw710Db+V3lyflKb+MdCCopwOUSg5/dWD1Vv2jwSFV1MOjlHSqRoFNJpXdhSObmDW6xk6VfZdNROSfmUgLWK3Ayd9xIwu+WAXH/Kej0VYI1k1kTyWGqQXjWASfB45rQXKzSbpwf2T0EdCKr0PRs=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051124162449.209CADD5@htj.dyndns.org>
In-Reply-To: <20051124162449.209CADD5@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/11] blk: update IDE to use new blk_ordered
Message-ID: <20051124162449.DB507E8E@htj.dyndns.org>
Date: Fri, 25 Nov 2005 01:26:21 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08_blk_ide-update-ordered.patch

	Update IDE to use new blk_ordered.  This change makes the
	following behavior changes.

	* Partial completion of the barrier request is handled as
          failure of the whole ordered sequence.  No more partial
          completion for barrier requests.

	* Any failure of pre or post flush request results in failure
	  of the whole ordered sequence.

	So, successfully completed ordered sequence guarantees that
	all requests prior to the barrier made to physical medium and,
	then, the while barrier request made to the physical medium.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-disk.c |  137 +++++++++++++++++++++++--------------------------------------
 ide-io.c   |    5 --
 2 files changed, 54 insertions(+), 88 deletions(-)

Index: work/drivers/ide/ide-disk.c
===================================================================
--- work.orig/drivers/ide/ide-disk.c	2005-11-25 00:51:37.000000000 +0900
+++ work/drivers/ide/ide-disk.c	2005-11-25 00:52:03.000000000 +0900
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
@@ -794,27 +752,64 @@ static int set_nowerr(ide_drive_t *drive
 	return 0;
 }
 
+static void update_ordered(ide_drive_t *drive)
+{
+	struct hd_driveid *id = drive->id;
+	unsigned ordered = QUEUE_ORDERED_NONE;
+	prepare_flush_fn *prep_fn = NULL;
+	issue_flush_fn *issue_fn = NULL;
+
+	if (drive->wcache) {
+		unsigned long long capacity;
+		int barrier;
+		/*
+		 * We must avoid issuing commands a drive does not
+		 * understand or we may crash it. We check flush cache
+		 * is supported. We also check we have the LBA48 flush
+		 * cache if the drive capacity is too large. By this
+		 * time we have trimmed the drive capacity if LBA48 is
+		 * not available so we don't need to recheck that.
+		 */
+		capacity = idedisk_capacity(drive);
+		barrier = ide_id_has_flush_cache(id) &&
+			(drive->addressing == 0 || capacity <= (1ULL << 28) ||
+			 ide_id_has_flush_cache_ext(id));
+
+		printk(KERN_INFO "%s: cache flushes %ssupported\n",
+		       drive->name, barrier ? "" : "not");
+
+		if (barrier) {
+			ordered = QUEUE_ORDERED_DRAIN_FLUSH;
+			prep_fn = idedisk_prepare_flush;
+			issue_fn = idedisk_issue_flush;
+		}
+	} else
+		ordered = QUEUE_ORDERED_DRAIN;
+
+	blk_queue_ordered(drive->queue, ordered, prep_fn);
+	blk_queue_issue_flush_fn(drive->queue, issue_fn);
+}
+
 static int write_cache(ide_drive_t *drive, int arg)
 {
 	ide_task_t args;
-	int err;
-
-	if (!ide_id_has_flush_cache(drive->id))
-		return 1;
+	int err = 1;
 
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
+	if (ide_id_has_flush_cache(drive->id)) {
+		memset(&args, 0, sizeof(ide_task_t));
+		args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
+		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+		args.command_type		= IDE_DRIVE_TASK_NO_DATA;
+		args.handler			= &task_no_data_intr;
+		err = ide_raw_taskfile(drive, &args, NULL);
+		if (err == 0)
+			drive->wcache = arg;
+	}
 
-	err = ide_raw_taskfile(drive, &args, NULL);
-	if (err)
-		return err;
+	update_ordered(drive);
 
-	drive->wcache = arg;
-	return 0;
+	return err;
 }
 
 static int do_idedisk_flushcache (ide_drive_t *drive)
@@ -888,7 +883,6 @@ static void idedisk_setup (ide_drive_t *
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long long capacity;
-	int barrier;
 
 	idedisk_add_settings(drive);
 
@@ -992,31 +986,6 @@ static void idedisk_setup (ide_drive_t *
 		drive->wcache = 1;
 
 	write_cache(drive, 1);
-
-	/*
-	 * We must avoid issuing commands a drive does not understand
-	 * or we may crash it. We check flush cache is supported. We also
-	 * check we have the LBA48 flush cache if the drive capacity is
-	 * too large. By this time we have trimmed the drive capacity if
-	 * LBA48 is not available so we don't need to recheck that.
-	 */
-	barrier = 0;
-	if (ide_id_has_flush_cache(id))
-		barrier = 1;
-	if (drive->addressing == 1) {
-		/* Can't issue the correct flush ? */
-		if (capacity > (1ULL << 28) && !ide_id_has_flush_cache_ext(id))
-			barrier = 0;
-	}
-
-	printk(KERN_INFO "%s: cache flushes %ssupported\n",
-		drive->name, barrier ? "" : "not ");
-	if (barrier) {
-		blk_queue_ordered(drive->queue, QUEUE_ORDERED_FLUSH);
-		drive->queue->prepare_flush_fn = idedisk_prepare_flush;
-		drive->queue->end_flush_fn = idedisk_end_flush;
-		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
-	}
 }
 
 static void ide_cacheflush_p(ide_drive_t *drive)
Index: work/drivers/ide/ide-io.c
===================================================================
--- work.orig/drivers/ide/ide-io.c	2005-11-25 00:52:01.000000000 +0900
+++ work/drivers/ide/ide-io.c	2005-11-25 00:52:03.000000000 +0900
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

