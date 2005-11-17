Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVKQPhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVKQPhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVKQPg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:36:58 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:56450 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751016AbVKQPgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:36:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=gNcvotKNcJnBGH6WTQ1b17LeCrjDm3+bzzvm+XWU9NWeGionHuOzopeGcZa8OP3gjeU8KUV7eLsPNyDJwknyZqdT7aKumcvRKdezCABLFJk6YkRscWFpUyICxLUWF/2RBNtv9Enp39jG/zoeV5yD49lOhEl+jN0dJPsoLX6k/Hg=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051117153509.B89B4777@htj.dyndns.org>
In-Reply-To: <20051117153509.B89B4777@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 04/10] blk: update SCSI to use new blk_ordered
Message-ID: <20051117153509.D34E3BFC@htj.dyndns.org>
Date: Fri, 18 Nov 2005 00:36:31 +0900 (KST)
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
 drivers/scsi/scsi_lib.c    |   46 ----------------------------------
 drivers/scsi/sd.c          |   60 ++++++++++++++++-----------------------------
 include/scsi/scsi_driver.h |    1 
 include/scsi/scsi_host.h   |    1 
 5 files changed, 22 insertions(+), 95 deletions(-)

Index: work/drivers/scsi/hosts.c
===================================================================
--- work.orig/drivers/scsi/hosts.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/scsi/hosts.c	2005-11-18 00:35:05.000000000 +0900
@@ -347,17 +347,8 @@ struct Scsi_Host *scsi_host_alloc(struct
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
Index: work/drivers/scsi/scsi_lib.c
===================================================================
--- work.orig/drivers/scsi/scsi_lib.c	2005-11-18 00:35:04.000000000 +0900
+++ work/drivers/scsi/scsi_lib.c	2005-11-18 00:35:05.000000000 +0900
@@ -765,9 +765,6 @@ void scsi_io_completion(struct scsi_cmnd
 	int sense_valid = 0;
 	int sense_deferred = 0;
 
-	if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
-		return;
-
 	/*
 	 * Free up any indirection buffers we allocated for DMA purposes. 
 	 * For the case of a READ, we need to copy the data out of the
@@ -1031,38 +1028,6 @@ static int scsi_init_io(struct scsi_cmnd
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
@@ -1520,17 +1485,6 @@ struct request_queue *scsi_alloc_queue(s
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
Index: work/drivers/scsi/sd.c
===================================================================
--- work.orig/drivers/scsi/sd.c	2005-11-18 00:35:04.000000000 +0900
+++ work/drivers/scsi/sd.c	2005-11-18 00:35:05.000000000 +0900
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
@@ -743,42 +740,13 @@ static int sd_issue_flush(struct device 
 	return ret;
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
-	if (!sdkp || !sdkp->WCE)
-		return 0;
-
 	memset(rq->cmd, 0, sizeof(rq->cmd));
-	rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
+	rq->flags |= REQ_BLOCK_PC;
 	rq->timeout = SD_TIMEOUT;
 	rq->cmd[0] = SYNCHRONIZE_CACHE;
-	return 1;
+	rq->cmd_len = 10;
 }
 
 static void sd_rescan(struct device *dev)
@@ -1476,6 +1444,7 @@ static int sd_revalidate_disk(struct gen
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdp = sdkp->device;
 	unsigned char *buffer;
+	unsigned ordered;
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_revalidate_disk: disk=%s\n", disk->disk_name));
 
@@ -1514,7 +1483,21 @@ static int sd_revalidate_disk(struct gen
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
 
@@ -1614,6 +1597,7 @@ static int sd_probe(struct device *dev)
 	strcpy(gd->devfs_name, sdp->devfs_name);
 
 	gd->private_data = &sdkp->driver;
+	gd->queue = sdkp->device->request_queue;
 
 	sd_revalidate_disk(gd);
 
@@ -1621,7 +1605,6 @@ static int sd_probe(struct device *dev)
 	gd->flags = GENHD_FL_DRIVERFS;
 	if (sdp->removable)
 		gd->flags |= GENHD_FL_REMOVABLE;
-	gd->queue = sdkp->device->request_queue;
 
 	dev_set_drvdata(dev, sdkp);
 	add_disk(gd);
@@ -1654,6 +1637,7 @@ static int sd_remove(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 
+	blk_queue_ordered(sdkp->disk->queue, QUEUE_ORDERED_NONE, NULL, 0);
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
 
Index: work/include/scsi/scsi_driver.h
===================================================================
--- work.orig/include/scsi/scsi_driver.h	2005-11-18 00:06:46.000000000 +0900
+++ work/include/scsi/scsi_driver.h	2005-11-18 00:35:05.000000000 +0900
@@ -15,7 +15,6 @@ struct scsi_driver {
 	void (*rescan)(struct device *);
 	int (*issue_flush)(struct device *, sector_t *);
 	int (*prepare_flush)(struct request_queue *, struct request *);
-	void (*end_flush)(struct request_queue *, struct request *);
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)
Index: work/include/scsi/scsi_host.h
===================================================================
--- work.orig/include/scsi/scsi_host.h	2005-11-18 00:14:29.000000000 +0900
+++ work/include/scsi/scsi_host.h	2005-11-18 00:35:05.000000000 +0900
@@ -392,7 +392,6 @@ struct scsi_host_template {
 	/*
 	 * ordered write support
 	 */
-	unsigned ordered_flush:1;
 	unsigned ordered_tag:1;
 
 	/*

