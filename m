Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753569AbWKFUXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbWKFUXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbWKFUXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:23:54 -0500
Received: from palrel12.hp.com ([156.153.255.237]:20948 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1753566AbWKFUXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:23:53 -0500
Date: Mon, 6 Nov 2006 14:23:52 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 8/12] repost: cciss: remove unused revalidate_allvol function
Message-ID: <20061106202352.GH17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 8/12

This patch removes the no longer used revalidate_allvol function. It was
replaced by rebuild_lun_table.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

------------------------------------------------------------------------------------------
---

 drivers/block/cciss.c |   74 --------------------------------------------------
 1 files changed, 1 insertion(+), 73 deletions(-)

diff -puN drivers/block/cciss.c~cciss_rm_revalidate_allvol_for_lx2619-rc4 drivers/block/cciss.c
--- linux-2.6/drivers/block/cciss.c~cciss_rm_revalidate_allvol_for_lx2619-rc4	2006-11-06 13:27:51.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:27:51.000000000 -0600
@@ -141,7 +141,6 @@ static int cciss_ioctl(struct inode *ino
 		       unsigned int cmd, unsigned long arg);
 static int cciss_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
-static int revalidate_allvol(ctlr_info_t *host);
 static int cciss_revalidate(struct gendisk *disk);
 static int rebuild_lun_table(ctlr_info_t *h, struct gendisk *del_disk);
 static int deregister_disk(struct gendisk *disk, drive_info_struct *drv,
@@ -857,9 +856,7 @@ static int cciss_ioctl(struct inode *ino
 		}
 
 	case CCISS_REVALIDVOLS:
-		if (bdev != bdev->bd_contains || drv != host->drv)
-			return -ENXIO;
-		return revalidate_allvol(host);
+		return rebuild_lun_table(host, NULL);
 
 	case CCISS_GETLUNINFO:{
 			LogvolInfo_struct luninfo;
@@ -1159,75 +1156,6 @@ static int cciss_ioctl(struct inode *ino
 	}
 }
 
-/*
- * revalidate_allvol is for online array config utilities.  After a
- * utility reconfigures the drives in the array, it can use this function
- * (through an ioctl) to make the driver zap any previous disk structs for
- * that controller and get new ones.
- *
- * Right now I'm using the getgeometry() function to do this, but this
- * function should probably be finer grained and allow you to revalidate one
- * particular logical volume (instead of all of them on a particular
- * controller).
- */
-static int revalidate_allvol(ctlr_info_t *host)
-{
-	int ctlr = host->ctlr, i;
-	unsigned long flags;
-
-	spin_lock_irqsave(CCISS_LOCK(ctlr), flags);
-	if (host->usage_count > 1) {
-		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
-		printk(KERN_WARNING "cciss: Device busy for volume"
-		       " revalidation (usage=%d)\n", host->usage_count);
-		return -EBUSY;
-	}
-	host->usage_count++;
-	spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
-
-	for (i = 0; i < NWD; i++) {
-		struct gendisk *disk = host->gendisk[i];
-		if (disk) {
-			request_queue_t *q = disk->queue;
-
-			if (disk->flags & GENHD_FL_UP)
-				del_gendisk(disk);
-			if (q)
-				blk_cleanup_queue(q);
-		}
-	}
-
-	/*
-	 * Set the partition and block size structures for all volumes
-	 * on this controller to zero.  We will reread all of this data
-	 */
-	memset(host->drv, 0, sizeof(drive_info_struct)
-	       * CISS_MAX_LUN);
-	/*
-	 * Tell the array controller not to give us any interrupts while
-	 * we check the new geometry.  Then turn interrupts back on when
-	 * we're done.
-	 */
-	host->access.set_intr_mask(host, CCISS_INTR_OFF);
-	cciss_getgeometry(ctlr);
-	host->access.set_intr_mask(host, CCISS_INTR_ON);
-
-	/* Loop through each real device */
-	for (i = 0; i < NWD; i++) {
-		struct gendisk *disk = host->gendisk[i];
-		drive_info_struct *drv = &(host->drv[i]);
-		/* we must register the controller even if no disks exist */
-		/* this is for the online array utilities */
-		if (!drv->heads && i)
-			continue;
-		blk_queue_hardsect_size(drv->queue, drv->block_size);
-		set_capacity(disk, drv->nr_blocks);
-		add_disk(disk);
-	}
-	host->usage_count--;
-	return 0;
-}
-
 static inline void complete_buffers(struct bio *bio, int status)
 {
 	while (bio) {
_
