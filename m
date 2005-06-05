Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVFEGKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVFEGKY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 02:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVFEGKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 02:10:24 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:55287 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261468AbVFEF5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:57:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=HKkA7U5yijziwIujB4tUL55ZOO+VHNEygaqAcD4gkUcFUMq8l5pBpyeMNiUdGjoywGB27JlE/eRHIGVrDEpYXBfm2K5AdS4TvEJvk2s2I4/CsIklOpC9znnKcWtdOt4uZ7gVhBhCD7agLgsgHjwzi7B7x0GBa1S7ibDreHjnAQ8=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050605055337.6301E65A@htj.dyndns.org>
In-Reply-To: <20050605055337.6301E65A@htj.dyndns.org>
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 06/09] blk: update SCSI to use the new blk_ordered
Message-ID: <20050605055337.3CC8625A@htj.dyndns.org>
Date: Sun,  5 Jun 2005 14:57:35 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06_blk_update_scsi_to_use_new_ordered.patch

	All ordered request related stuff delegated to HLD.  Midlayer
	now doens't deal with ordered setting or prepare_flush
	callback.  sd.c updated to deal with blk_queue_ordered
	setting.  Currently, ordered tag isn't used as SCSI midlayer
	cannot guarantee request ordering.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/hosts.c       |    9 -----
 drivers/scsi/scsi_lib.c    |   46 --------------------------
 drivers/scsi/sd.c          |   79 +++++++++++++++++++--------------------------
 include/scsi/scsi_driver.h |    1 
 include/scsi/scsi_host.h   |    1 
 5 files changed, 34 insertions(+), 102 deletions(-)

Index: blk-fixes/drivers/scsi/sd.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sd.c	2005-06-05 14:53:32.000000000 +0900
+++ blk-fixes/drivers/scsi/sd.c	2005-06-05 14:53:35.000000000 +0900
@@ -103,6 +103,7 @@ struct scsi_disk {
 	u8		write_prot;
 	unsigned	WCE : 1;	/* state of disk WCE bit */
 	unsigned	RCD : 1;	/* state of disk RCD bit, unused */
+	unsigned	DPOFUA : 1;	/* state of disk DPOFUA bit */
 };
 
 static DEFINE_IDR(sd_index_idr);
@@ -122,8 +123,7 @@ static void sd_shutdown(struct device *d
 static void sd_rescan(struct device *);
 static int sd_init_command(struct scsi_cmnd *);
 static int sd_issue_flush(struct device *, sector_t *);
-static void sd_end_flush(request_queue_t *, struct request *);
-static int sd_prepare_flush(request_queue_t *, struct request *);
+static void sd_prepare_flush(request_queue_t *, struct request *);
 static void sd_read_capacity(struct scsi_disk *sdkp, char *diskname,
 		 struct scsi_request *SRpnt, unsigned char *buffer);
 
@@ -138,8 +138,6 @@ static struct scsi_driver sd_template = 
 	.rescan			= sd_rescan,
 	.init_command		= sd_init_command,
 	.issue_flush		= sd_issue_flush,
-	.prepare_flush		= sd_prepare_flush,
-	.end_flush		= sd_end_flush,
 };
 
 /*
@@ -346,6 +344,7 @@ static int sd_init_command(struct scsi_c
 	
 	if (block > 0xffffffff) {
 		SCpnt->cmnd[0] += READ_16 - READ_6;
+		SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
 		SCpnt->cmnd[2] = sizeof(block) > 4 ? (unsigned char) (block >> 56) & 0xff : 0;
 		SCpnt->cmnd[3] = sizeof(block) > 4 ? (unsigned char) (block >> 48) & 0xff : 0;
 		SCpnt->cmnd[4] = sizeof(block) > 4 ? (unsigned char) (block >> 40) & 0xff : 0;
@@ -360,11 +359,12 @@ static int sd_init_command(struct scsi_c
 		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
 		SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
 	} else if ((this_count > 0xff) || (block > 0x1fffff) ||
-		   SCpnt->device->use_10_for_rw) {
+		   SCpnt->device->use_10_for_rw || blk_fua_rq(rq)) {
 		if (this_count > 0xffff)
 			this_count = 0xffff;
 
 		SCpnt->cmnd[0] += READ_10 - READ_6;
+		SCpnt->cmnd[1] |= blk_fua_rq(rq) ? 0x8 : 0;
 		SCpnt->cmnd[2] = (unsigned char) (block >> 24) & 0xff;
 		SCpnt->cmnd[3] = (unsigned char) (block >> 16) & 0xff;
 		SCpnt->cmnd[4] = (unsigned char) (block >> 8) & 0xff;
@@ -739,43 +739,12 @@ static int sd_issue_flush(struct device 
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
+	rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
+	rq->timeout = SD_TIMEOUT;
+	rq->cmd[0] = SYNCHRONIZE_CACHE;
 }
 
 static void sd_rescan(struct device *dev)
@@ -1433,10 +1402,13 @@ sd_read_cache_type(struct scsi_disk *sdk
 			sdkp->RCD = 0;
 		}
 
+		sdkp->DPOFUA = (data.device_specific & 0x10) != 0;
+
 		ct =  sdkp->RCD + 2*sdkp->WCE;
 
-		printk(KERN_NOTICE "SCSI device %s: drive cache: %s\n",
-		       diskname, types[ct]);
+		printk(KERN_NOTICE "SCSI device %s: drive cache: %s%s\n",
+		       diskname, types[ct],
+		       sdkp->DPOFUA ? " with forced unit access" : "");
 
 		return;
 	}
@@ -1469,6 +1441,7 @@ static int sd_revalidate_disk(struct gen
 	struct scsi_device *sdp = sdkp->device;
 	struct scsi_request *sreq;
 	unsigned char *buffer;
+	unsigned ordered;
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_revalidate_disk: disk=%s\n", disk->disk_name));
 
@@ -1514,7 +1487,22 @@ static int sd_revalidate_disk(struct gen
 					sreq, buffer);
 		sd_read_cache_type(sdkp, disk->disk_name, sreq, buffer);
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
+		ordered = sdkp->DPOFUA
+			? QUEUE_ORDERED_DRAIN_FUA : QUEUE_ORDERED_DRAIN_FLUSH;
+	else
+		ordered = QUEUE_ORDERED_DRAIN;
+
+	blk_queue_ordered(sdkp->disk->queue, ordered, sd_prepare_flush,
+			  GFP_KERNEL);
+
 	set_capacity(disk, sdkp->capacity);
 	kfree(buffer);
 
@@ -1615,6 +1603,7 @@ static int sd_probe(struct device *dev)
 	strcpy(gd->devfs_name, sdp->devfs_name);
 
 	gd->private_data = &sdkp->driver;
+	gd->queue = sdkp->device->request_queue;
 
 	sd_revalidate_disk(gd);
 
@@ -1622,7 +1611,6 @@ static int sd_probe(struct device *dev)
 	gd->flags = GENHD_FL_DRIVERFS;
 	if (sdp->removable)
 		gd->flags |= GENHD_FL_REMOVABLE;
-	gd->queue = sdkp->device->request_queue;
 
 	dev_set_drvdata(dev, sdkp);
 	add_disk(gd);
@@ -1657,6 +1645,7 @@ static int sd_remove(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 
+	blk_queue_ordered(sdkp->disk->queue, QUEUE_ORDERED_NONE, NULL, 0);
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
 	down(&sd_ref_sem);
Index: blk-fixes/drivers/scsi/scsi_lib.c
===================================================================
--- blk-fixes.orig/drivers/scsi/scsi_lib.c	2005-06-05 14:53:33.000000000 +0900
+++ blk-fixes/drivers/scsi/scsi_lib.c	2005-06-05 14:53:35.000000000 +0900
@@ -717,9 +717,6 @@ void scsi_io_completion(struct scsi_cmnd
 	int sense_valid = 0;
 	int sense_deferred = 0;
 
-	if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
-		return;
-
 	/*
 	 * Free up any indirection buffers we allocated for DMA purposes. 
 	 * For the case of a READ, we need to copy the data out of the
@@ -984,38 +981,6 @@ static int scsi_init_io(struct scsi_cmnd
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
@@ -1443,17 +1408,6 @@ struct request_queue *scsi_alloc_queue(s
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
Index: blk-fixes/drivers/scsi/hosts.c
===================================================================
--- blk-fixes.orig/drivers/scsi/hosts.c	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/drivers/scsi/hosts.c	2005-06-05 14:53:35.000000000 +0900
@@ -264,17 +264,8 @@ struct Scsi_Host *scsi_host_alloc(struct
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
Index: blk-fixes/include/scsi/scsi_host.h
===================================================================
--- blk-fixes.orig/include/scsi/scsi_host.h	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/include/scsi/scsi_host.h	2005-06-05 14:53:35.000000000 +0900
@@ -391,7 +391,6 @@ struct scsi_host_template {
 	/*
 	 * ordered write support
 	 */
-	unsigned ordered_flush:1;
 	unsigned ordered_tag:1;
 
 	/*
Index: blk-fixes/include/scsi/scsi_driver.h
===================================================================
--- blk-fixes.orig/include/scsi/scsi_driver.h	2005-06-05 14:50:11.000000000 +0900
+++ blk-fixes/include/scsi/scsi_driver.h	2005-06-05 14:53:35.000000000 +0900
@@ -15,7 +15,6 @@ struct scsi_driver {
 	void (*rescan)(struct device *);
 	int (*issue_flush)(struct device *, sector_t *);
 	int (*prepare_flush)(struct request_queue *, struct request *);
-	void (*end_flush)(struct request_queue *, struct request *);
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)

