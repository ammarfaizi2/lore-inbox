Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUJNQTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUJNQTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 12:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUJNQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 12:19:21 -0400
Received: from palrel11.hp.com ([156.153.255.246]:41449 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266578AbUJNQSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 12:18:52 -0400
Date: Thu, 14 Oct 2004 11:17:58 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch 2/2] cciss: fixes for clustering
Message-ID: <20041014161758.GC21960@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 2
This patch changes our open specifically for clustering software. We must
allow root to access any volume or device with a LUN ID. We also modified 
our revalidate function for this reason.
If a logical is reserved, we must register it with the OS with size=0. Then
the backup system can call BLKRRPART after breaking the reservation to
set the device to the correct size.
We also must register a controller with no logical volumes for the online
utilities to function. This is the way we've done it since the 2.2 kernel.
Which doesn't neccesarily make it right, but we have legacy apps to consider.

Thanks,
mikem
Signed off by: Mike Miller

 cciss.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 69 insertions(+), 19 deletions(-)
-------------------------------------------------------------------------------
diff -urNp lx269-rc4-p001/drivers/block/cciss.c lx269-rc4/drivers/block/cciss.c
--- lx269-rc4-p001/drivers/block/cciss.c	2004-10-13 13:53:49.545284000 -0500
+++ lx269-rc4/drivers/block/cciss.c	2004-10-13 15:26:47.312335048 -0500
@@ -438,13 +438,22 @@ static int cciss_open(struct inode *inod
 
 	/*
 	 * Root is allowed to open raw volume zero even if it's not configured
-	 * so array config can still work.  I don't think I really like this,
+	 * so array config can still work. Root is also allowed to open any
+	 * volume that has a LUN ID, so it can issue IOCTL to reread the
+	 * disk information.  I don't think I really like this
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
 	if (drv->nr_blocks == 0) {
-		if (iminor(inode) != 0)
+		if (iminor(inode) != 0)	{ 	/* not node 0? */
+			/* if not node 0 make sure it is a partition = 0 */
+			if (iminor(inode) & 0x0f) {
 			return -ENXIO;
+				/* if it is, make sure we have a LUN ID */
+			} else if (drv->LunID == 0) {
+				return -ENXIO;
+			}
+		}
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 	}
@@ -1095,13 +1104,6 @@ cleanup1:
 	
 }
 
-static int cciss_revalidate(struct gendisk *disk)
-{
-	drive_info_struct *drv = disk->private_data;
-	set_capacity(disk, drv->nr_blocks);
-	return 0;
-}
-
 /*
  * revalidate_allvol is for online array config utilities.  After a
  * utility reconfigures the drives in the array, it can use this function
@@ -1153,7 +1155,9 @@ static int revalidate_allvol(ctlr_info_t
 	for (i = 0; i < NWD; i++) {
 		struct gendisk *disk = host->gendisk[i];
 		drive_info_struct *drv = &(host->drv[i]);
-		if (!drv->nr_blocks)
+		/* we must register the controller even if no disks exist */
+		/* this is for the online array utilities */
+		if (!drv->heads && i)
 			continue;
 		blk_queue_hardsect_size(host->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
@@ -1485,13 +1489,7 @@ static void cciss_geometry_inquiry(int c
 			}
 		}
 	} else { /* Get geometry failed */
-		printk(KERN_WARNING "cciss: reading geometry failed, "
-			"continuing with default geometry\n");
-		drv->block_size = block_size;
-		drv->nr_blocks = total_size;
-		drv->heads = 255;
-		drv->sectors = 32; // Sectors per track
-		drv->cylinders = total_size / 255 / 32;
+		printk(KERN_WARNING "cciss: reading geometry failed\n");
 	}
 	printk(KERN_INFO "      heads= %d, sectors= %d, cylinders= %d\n\n",
 		drv->heads, drv->sectors, drv->cylinders);
@@ -1520,6 +1518,7 @@ cciss_read_capacity(int ctlr, int logvol
 		*total_size, *block_size);
 	return;
 }
+
 static int register_new_disk(ctlr_info_t *h)
 {
         struct gendisk *disk;
@@ -1663,7 +1662,9 @@ static int register_new_disk(ctlr_info_t
 	/* setup partitions per disk */
         disk = h->gendisk[logvol];
 	set_capacity(disk, h->drv[logvol].nr_blocks);
-	add_disk(disk);
+	/* if it's the controller it's already added */
+	if(logvol)
+		add_disk(disk);
 freeret:
 	kfree(ld_buff);
 	kfree(size_buff);
@@ -1675,6 +1676,53 @@ free_err:
 	logvol = -1;
 	goto freeret;
 }
+
+static int cciss_revalidate(struct gendisk *disk)
+{
+	ctlr_info_t *h = get_host(disk);
+	drive_info_struct *drv = get_drv(disk);
+	int logvol;
+	int FOUND=0;
+	unsigned int block_size;
+	unsigned int total_size;
+	ReadCapdata_struct *size_buff = NULL;
+	InquiryData_struct *inq_buff = NULL;
+
+	for(logvol=0; logvol < CISS_MAX_LUN; logvol++)
+	{
+		if(h->drv[logvol].LunID == drv->LunID) {
+			FOUND=1;
+			break;
+		}
+	}
+
+	if (!FOUND) return 1;
+
+	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
+        if (size_buff == NULL)
+        {
+                printk(KERN_WARNING "cciss: out of memory\n");
+                return 1;
+        }
+	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);
+        if (inq_buff == NULL)
+        {
+                printk(KERN_WARNING "cciss: out of memory\n");
+		kfree(size_buff);
+                return 1;
+        }
+
+	cciss_read_capacity(h->ctlr, logvol, size_buff, 1, &total_size, &block_size);
+	cciss_geometry_inquiry(h->ctlr, logvol, 1, total_size, block_size, inq_buff, drv);
+
+	blk_queue_hardsect_size(h->queue, drv->block_size);
+	set_capacity(disk, drv->nr_blocks);
+
+	kfree(size_buff);
+	kfree(inq_buff);
+	return 0;
+}
+
 /*
  *   Wait polling for a command to complete.
  *   The memory mapped FIFO is polled for the completion.
@@ -2762,7 +2810,9 @@ static int __devinit cciss_init_one(stru
 		disk->fops = &cciss_fops;
 		disk->queue = hba[i]->queue;
 		disk->private_data = drv;
-		if( !(drv->nr_blocks))
+		/* we must register the controller even if no disks exist */
+		/* this is for the online array utilities */
+		if(!drv->heads && j)
 			continue;
 		blk_queue_hardsect_size(hba[i]->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
