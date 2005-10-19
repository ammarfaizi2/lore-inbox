Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVJSMvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVJSMvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbVJSMsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:48:18 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:18986 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750926AbVJSMsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:48:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=GKJTOONmGgssfqqREq71WNyoGIH+MXdf6Zu2zAwEeBScu5a95UuYxDVOyROBueRKOXuMya/3KowJ2kbHlFuZROmZ/lsHDGLin2BWTr9i6JhBpeCRZV5Wxz6CrF9TpCYawKfb4bEMnM3vLwZlsKBz9zSgZfLQz/x79avqbH+n6cc=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051019124716.EF1F6546@htj.dyndns.org>
In-Reply-To: <20051019124716.EF1F6546@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 04/10] blk: update SCSI to use new blk_ordered
Message-ID: <20051019124716.D1B807BB@htj.dyndns.org>
Date: Wed, 19 Oct 2005 21:48:01 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_blk_scsi-update-ordered.patch

	All ordered request related stuff delegated to HLD.  Midlayer
        now doens't deal with ordered setting or prepare_flush
        callback.  sd.c updated to deal with blk_queue_ordered
        setting.  Currently, ordered tag isn't used as SCSI midlayer
        cannot guarantee request ordering.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/hosts.c       |    9 ------
 drivers/scsi/scsi_lib.c    |   46 -------------------------------
 drivers/scsi/sd.c          |   66 ++++++++++++++++-----------------------------
 include/scsi/scsi_driver.h |    1 
 include/scsi/scsi_host.h   |    1 
 5 files changed, 24 insertions(+), 99 deletions(-)

Index: blk-fixes/drivers/scsi/hosts.c
===================================================================
--- blk-fixes.orig/drivers/scsi/hosts.c	2005-10-19 21:46:50.000000000 +0900
+++ blk-fixes/drivers/scsi/hosts.c	2005-10-19 21:47:13.000000000 +0900
@@ -345,17 +345,8 @@ struct Scsi_Host *scsi_host_alloc(struct
 	shost->cmd_per_lun = sht->cmd_per_lun;
 	shost->unchecked_isa_dma = sht->unchecked_isa_dma;
 	shost->use_clustering = sht->use_clustering;
-	shost->ordered_flush = sht->ordered_flush;
 	shost->ordered_tag = sht->ordered_tag;
 
-	/*
-	 * hosts/devices that do queueing must support ordered tags
-	 */
-	if (shost->can_queue > 1 && shost->ordered_flush) {
-		printk(KERN_ERR "scsi: ordered flushes don't support queueing\n");
-		shost->ordered_flush = 0;
-	}
-
 	if (sht->max_host_blocked)
 		shost->max_host_blocked = sht->max_host_blocked;
 	else
Index: blk-fixes/drivers/scsi/scsi_lib.c
===================================================================
--- blk-fixes.orig/drivers/scsi/scsi_lib.c	2005-10-19 21:47:12.000000000 +0900
+++ blk-fixes/drivers/scsi/scsi_lib.c	2005-10-19 21:47:13.000000000 +0900
@@ -808,9 +808,6 @@ void scsi_io_completion(struct scsi_cmnd
 	int sense_valid = 0;
 	int sense_deferred = 0;
 
-	if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
-		return;
-
 	/*
 	 * Free up any indirection buffers we allocated for DMA purposes. 
 	 * For the case of a READ, we need to copy the data out of the
@@ -1074,38 +1071,6 @@ static int scsi_init_io(struct scsi_cmnd
 	return BLKPREP_KILL;
 }
 
-static int scsi_prepare_flush_fn(request_queue_t *q, struct request *rq)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct scsi_driver *drv;
-
-	if (sdev->sdev_state == SDEV_RUNNING) {
-		drv = *(struct scsi_driver **) rq->rq_disk->private_data;
-
-		if (drv->prepare_flush)
-			return drv->prepare_flush(q, rq);
-	}
-
-	return 0;
-}
-
-static void scsi_end_flush_fn(request_queue_t *q, struct request *rq)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct request *flush_rq = rq->end_io_data;
-	struct scsi_driver *drv;
-
-	if (flush_rq->errors) {
-		printk("scsi: barrier error, disabling flush support\n");
-		blk_queue_ordered(q, QUEUE_ORDERED_NONE);
-	}
-
-	if (sdev->sdev_state == SDEV_RUNNING) {
-		drv = *(struct scsi_driver **) rq->rq_disk->private_data;
-		drv->end_flush(q, rq);
-	}
-}
-
 static int scsi_issue_flush_fn(request_queue_t *q, struct gendisk *disk,
 			       sector_t *error_sector)
 {
@@ -1564,17 +1529,6 @@ struct request_queue *scsi_alloc_queue(s
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	blk_queue_issue_flush_fn(q, scsi_issue_flush_fn);
 
-	/*
-	 * ordered tags are superior to flush ordering
-	 */
-	if (shost->ordered_tag)
-		blk_queue_ordered(q, QUEUE_ORDERED_TAG);
-	else if (shost->ordered_flush) {
-		blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
-		q->prepare_flush_fn = scsi_prepare_flush_fn;
-		q->end_flush_fn = scsi_end_flush_fn;
-	}
-
 	if (!shost->use_clustering)
 		clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
 	return q;
Index: blk-fixes/drivers/scsi/sd.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sd.c	2005-10-19 21:47:12.000000000 +0900
+++ blk-fixes/drivers/scsi/sd.c	2005-10-19 21:47:13.000000000 +0900
@@ -121,8 +121,7 @@ static void sd_shutdown(struct device *d
 static void sd_rescan(struct device *);
 static int sd_init_command(struct scsi_cmnd *);
 static int sd_issue_flush(struct device *, sector_t *);
-static void sd_end_flush(request_queue_t *, struct request *);
-static int sd_prepare_flush(request_queue_t *, struct request *);
+static void sd_prepare_flush(request_queue_t *, struct request *);
 static void sd_read_capacity(struct scsi_disk *sdkp, char *diskname,
 			     unsigned char *buffer);
 
@@ -137,8 +136,6 @@ static struct scsi_driver sd_template = 
 	.rescan			= sd_rescan,
 	.init_command		= sd_init_command,
 	.issue_flush		= sd_issue_flush,
-	.prepare_flush		= sd_prepare_flush,
-	.end_flush		= sd_end_flush,
 };
 
 /*
@@ -728,43 +725,12 @@ static int sd_issue_flush(struct device 
 	return sd_sync_cache(sdp);
 }
 
-static void sd_end_flush(request_queue_t *q, struct request *flush_rq)
+static void sd_prepare_flush(request_queue_t *q, struct request *rq)
 {
-	struct request *rq = flush_rq->end_io_data;
-	struct scsi_cmnd *cmd = rq->special;
-	unsigned int bytes = rq->hard_nr_sectors << 9;
-
-	if (!flush_rq->errors) {
-		spin_unlock(q->queue_lock);
-		scsi_io_completion(cmd, bytes, 0);
-		spin_lock(q->queue_lock);
-	} else if (blk_barrier_postflush(rq)) {
-		spin_unlock(q->queue_lock);
-		scsi_io_completion(cmd, 0, bytes);
-		spin_lock(q->queue_lock);
-	} else {
-		/*
-		 * force journal abort of barriers
-		 */
-		end_that_request_first(rq, -EOPNOTSUPP, rq->hard_nr_sectors);
-		end_that_request_last(rq, -EOPNOTSUPP);
-	}
-}
-
-static int sd_prepare_flush(request_queue_t *q, struct request *rq)
-{
-	struct scsi_device *sdev = q->queuedata;
-	struct scsi_disk *sdkp = dev_get_drvdata(&sdev->sdev_gendev);
-
-	if (sdkp->WCE) {
-		memset(rq->cmd, 0, sizeof(rq->cmd));
-		rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
-		rq->timeout = SD_TIMEOUT;
-		rq->cmd[0] = SYNCHRONIZE_CACHE;
-		return 1;
-	}
-
-	return 0;
+	memset(rq->cmd, 0, sizeof(rq->cmd));
+	rq->flags |= REQ_BLOCK_PC;
+	rq->timeout = SD_TIMEOUT;
+	rq->cmd[0] = SYNCHRONIZE_CACHE;
 }
 
 static void sd_rescan(struct device *dev)
@@ -1459,6 +1425,7 @@ static int sd_revalidate_disk(struct gen
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdp = sdkp->device;
 	unsigned char *buffer;
+	unsigned ordered;
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_revalidate_disk: disk=%s\n", disk->disk_name));
 
@@ -1497,7 +1464,21 @@ static int sd_revalidate_disk(struct gen
 						   buffer);
 		sd_read_cache_type(sdkp, disk->disk_name, buffer);
 	}
-		
+
+	/*
+	 * We now have all cache related info, determine how we deal
+	 * with ordered requests.  Note that as the current SCSI
+	 * dispatch function can alter request order, we cannot use
+	 * QUEUE_ORDERED_TAG_* even when ordered tag is supported.
+	 */
+	if (sdkp->WCE)
+		ordered = QUEUE_ORDERED_DRAIN_FLUSH;
+	else
+		ordered = QUEUE_ORDERED_DRAIN;
+
+	blk_queue_ordered(sdkp->disk->queue, ordered, sd_prepare_flush,
+			  GFP_KERNEL);
+
 	set_capacity(disk, sdkp->capacity);
 	kfree(buffer);
 
@@ -1596,6 +1577,7 @@ static int sd_probe(struct device *dev)
 	strcpy(gd->devfs_name, sdp->devfs_name);
 
 	gd->private_data = &sdkp->driver;
+	gd->queue = sdkp->device->request_queue;
 
 	sd_revalidate_disk(gd);
 
@@ -1603,7 +1585,6 @@ static int sd_probe(struct device *dev)
 	gd->flags = GENHD_FL_DRIVERFS;
 	if (sdp->removable)
 		gd->flags |= GENHD_FL_REMOVABLE;
-	gd->queue = sdkp->device->request_queue;
 
 	dev_set_drvdata(dev, sdkp);
 	add_disk(gd);
@@ -1638,6 +1619,7 @@ static int sd_remove(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 
+	blk_queue_ordered(sdkp->disk->queue, QUEUE_ORDERED_NONE, NULL, 0);
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
 	down(&sd_ref_sem);
Index: blk-fixes/include/scsi/scsi_driver.h
===================================================================
--- blk-fixes.orig/include/scsi/scsi_driver.h	2005-10-19 21:46:50.000000000 +0900
+++ blk-fixes/include/scsi/scsi_driver.h	2005-10-19 21:47:13.000000000 +0900
@@ -15,7 +15,6 @@ struct scsi_driver {
 	void (*rescan)(struct device *);
 	int (*issue_flush)(struct device *, sector_t *);
 	int (*prepare_flush)(struct request_queue *, struct request *);
-	void (*end_flush)(struct request_queue *, struct request *);
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)
Index: blk-fixes/include/scsi/scsi_host.h
===================================================================
--- blk-fixes.orig/include/scsi/scsi_host.h	2005-10-19 21:46:50.000000000 +0900
+++ blk-fixes/include/scsi/scsi_host.h	2005-10-19 21:47:13.000000000 +0900
@@ -391,7 +391,6 @@ struct scsi_host_template {
 	/*
 	 * ordered write support
 	 */
-	unsigned ordered_flush:1;
 	unsigned ordered_tag:1;
 
 	/*

