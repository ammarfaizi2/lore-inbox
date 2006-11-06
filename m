Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753730AbWKFU20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbWKFU20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbWKFU2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:28:25 -0500
Received: from palrel13.hp.com ([156.153.255.238]:45253 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1753723AbWKFU2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:28:24 -0500
Date: Mon, 6 Nov 2006 14:28:22 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 10/12] repost: cciss: add support for 1024 logical volumes
Message-ID: <20061106202822.GJ17847@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 10 of 12

This patch adds the support for a large number of logical volumes. We will
soon have hardware that support up to 1024 logical volumes.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 drivers/block/cciss_cmd.h   |    2
 include/linux/cciss_ioctl.h |    2
--------------------------------------------------------------------------------
---

 drivers/block/cciss.c       |  114 +++++++++++++++++++++++++++++---------------
 drivers/block/cciss.h       |    3 -
 drivers/block/cciss_cmd.h   |    2 
 include/linux/cciss_ioctl.h |    2 
 4 files changed, 80 insertions(+), 41 deletions(-)

diff -puN drivers/block/cciss.c~cciss_gt_16_ld_for_lx2619-rc4 drivers/block/cciss.c
--- linux-2.6/drivers/block/cciss.c~cciss_gt_16_ld_for_lx2619-rc4	2006-11-06 13:28:01.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.c	2006-11-06 13:28:34.000000000 -0600
@@ -1312,6 +1312,11 @@ static void cciss_update_drive_info(int 
 	/* if it's the controller it's already added */
 	if (drv_index) {
 		disk->queue = blk_init_queue(do_cciss_request, &h->lock);
+		sprintf(disk->disk_name, "cciss/c%dd%d", ctlr, drv_index);
+		disk->major = h->major;
+		disk->first_minor = drv_index << NWD_SHIFT;
+		disk->fops = &cciss_fops;
+		disk->private_data = &h->drv[drv_index];
 
 		/* Set up queue information */
 		disk->queue->backing_dev_info.ra_pages = READ_AHEAD;
@@ -1390,11 +1395,6 @@ static int rebuild_lun_table(ctlr_info_t
 
 	/* Set busy_configuring flag for this operation */
 	spin_lock_irqsave(CCISS_LOCK(h->ctlr), flags);
-	if (h->num_luns >= CISS_MAX_LUN) {
-		spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
-		return -EINVAL;
-	}
-
 	if (h->busy_configuring) {
 		spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
 		return -EBUSY;
@@ -1427,17 +1427,8 @@ static int rebuild_lun_table(ctlr_info_t
 					      0, 0, TYPE_CMD);
 
 		if (return_code == IO_OK) {
-			listlength |=
-			    (0xff & (unsigned int)(ld_buff->LUNListLength[0]))
-			    << 24;
-			listlength |=
-			    (0xff & (unsigned int)(ld_buff->LUNListLength[1]))
-			    << 16;
-			listlength |=
-			    (0xff & (unsigned int)(ld_buff->LUNListLength[2]))
-			    << 8;
-			listlength |=
-			    0xff & (unsigned int)(ld_buff->LUNListLength[3]);
+			listlength =
+				be32_to_cpu(*(__u32 *) ld_buff->LUNListLength);
 		} else {	/* reading number of logical volumes failed */
 			printk(KERN_WARNING "cciss: report logical volume"
 			       " command failed\n");
@@ -1488,6 +1479,14 @@ static int rebuild_lun_table(ctlr_info_t
 				if (drv_index == -1)
 					goto freeret;
 
+				/*Check if the gendisk needs to be allocated */
+				if (!h->gendisk[drv_index]){
+					h->gendisk[drv_index] = alloc_disk(1 << NWD_SHIFT);
+					if (!h->gendisk[drv_index]){
+						printk(KERN_ERR "cciss: could not allocate new disk %d\n", drv_index);
+						goto mem_msg;
+					}
+				}
 			}
 			h->drv[drv_index].LunID = lunid;
 			cciss_update_drive_info(ctlr, drv_index);
@@ -1525,6 +1524,7 @@ static int rebuild_lun_table(ctlr_info_t
 static int deregister_disk(struct gendisk *disk, drive_info_struct *drv,
 			   int clear_all)
 {
+	int i;
 	ctlr_info_t *h = get_host(disk);
 
 	if (!capable(CAP_SYS_RAWIO))
@@ -1548,9 +1548,35 @@ static int deregister_disk(struct gendis
 				del_gendisk(disk);
 			if (q) {
 				blk_cleanup_queue(q);
+				/* Set drv->queue to NULL so that we do not try
+				 * to call blk_start_queue on this queue in the
+				 * interrupt handler
+				 */
 				drv->queue = NULL;
 			}
+			/* If clear_all is set then we are deleting the logical
+			 * drive, not just refreshing its info.  For drives
+			 * other than disk 0 we will call put_disk.  We do not
+			 * do this for disk 0 as we need it to be able to
+			 * configure the controller.
+			*/
+			if (clear_all){
+				/* This isn't pretty, but we need to find the
+				 * disk in our array and NULL our the pointer.
+				 * This is so that we will call alloc_disk if
+				 * this index is used again later.
+				*/
+				for (i=0; i < CISS_MAX_LUN; i++){
+					if(h->gendisk[i] == disk){
+						h->gendisk[i] = NULL;
+						break;
+					}
+				}
+				put_disk(disk);
+			}
 		}
+	} else {
+		set_capacity(disk, 0);
 	}
 
 	--h->num_luns;
@@ -3116,13 +3142,7 @@ geo_inq:
 /* Returns -1 if no free entries are left.  */
 static int alloc_cciss_hba(void)
 {
-	struct gendisk *disk[NWD];
-	int i, n;
-	for (n = 0; n < NWD; n++) {
-		disk[n] = alloc_disk(1 << NWD_SHIFT);
-		if (!disk[n])
-			goto out;
-	}
+	int i;
 
 	for (i = 0; i < MAX_CTLR; i++) {
 		if (!hba[i]) {
@@ -3130,20 +3150,18 @@ static int alloc_cciss_hba(void)
 			p = kzalloc(sizeof(ctlr_info_t), GFP_KERNEL);
 			if (!p)
 				goto Enomem;
-			for (n = 0; n < NWD; n++)
-				p->gendisk[n] = disk[n];
+			p->gendisk[0] = alloc_disk(1 << NWD_SHIFT);
+			if (!p->gendisk[0])
+				goto Enomem;
 			hba[i] = p;
 			return i;
 		}
 	}
 	printk(KERN_WARNING "cciss: This driver supports a maximum"
 	       " of %d controllers.\n", MAX_CTLR);
-	goto out;
-      Enomem:
+	return -1;
+Enomem:
 	printk(KERN_ERR "cciss: out of memory.\n");
-      out:
-	while (n--)
-		put_disk(disk[n]);
 	return -1;
 }
 
@@ -3153,7 +3171,7 @@ static void free_hba(int i)
 	int n;
 
 	hba[i] = NULL;
-	for (n = 0; n < NWD; n++)
+	for (n = 0; n < CISS_MAX_LUN; n++)
 		put_disk(p->gendisk[n]);
 	kfree(p);
 }
@@ -3166,9 +3184,8 @@ static void free_hba(int i)
 static int __devinit cciss_init_one(struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
-	request_queue_t *q;
 	int i;
-	int j;
+	int j = 0;
 	int rc;
 	int dac;
 
@@ -3280,16 +3297,29 @@ static int __devinit cciss_init_one(stru
 
 	hba[i]->busy_initializing = 0;
 
-	for (j = 0; j < NWD; j++) {	/* mfm */
+	do {
 		drive_info_struct *drv = &(hba[i]->drv[j]);
 		struct gendisk *disk = hba[i]->gendisk[j];
+		request_queue_t *q;
+
+		/* Check if the disk was allocated already */
+		if (!disk){
+			hba[i]->gendisk[j] = alloc_disk(1 << NWD_SHIFT);
+			disk = hba[i]->gendisk[j];
+		}
+
+		/* Check that the disk was able to be allocated */
+		if (!disk) {
+			printk(KERN_ERR "cciss: unable to allocate memory for disk %d\n", j);
+			goto clean4;
+		}
 
 		q = blk_init_queue(do_cciss_request, &hba[i]->lock);
 		if (!q) {
 			printk(KERN_ERR
 			       "cciss:  unable to allocate queue for disk %d\n",
 			       j);
-			break;
+			goto clean4;
 		}
 		drv->queue = q;
 
@@ -3321,7 +3351,8 @@ static int __devinit cciss_init_one(stru
 		blk_queue_hardsect_size(q, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
-	}
+		j++;
+	} while (j <= hba[i]->highest_lun);
 
 	return 1;
 
@@ -3344,6 +3375,15 @@ static int __devinit cciss_init_one(stru
 	unregister_blkdev(hba[i]->major, hba[i]->devname);
       clean1:
 	hba[i]->busy_initializing = 0;
+	/* cleanup any queues that may have been initialized */
+	for (j=0; j <= hba[i]->highest_lun; j++){
+		drive_info_struct *drv = &(hba[i]->drv[j]);
+		if (drv->queue)
+			blk_cleanup_queue(drv->queue);
+	}
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
 	free_hba(i);
 	return -1;
 }
@@ -3391,7 +3431,7 @@ static void __devexit cciss_remove_one(s
 	remove_proc_entry(hba[i]->devname, proc_cciss);
 
 	/* remove it from the disk list */
-	for (j = 0; j < NWD; j++) {
+	for (j = 0; j < CISS_MAX_LUN; j++) {
 		struct gendisk *disk = hba[i]->gendisk[j];
 		if (disk) {
 			request_queue_t *q = disk->queue;
diff -puN drivers/block/cciss_cmd.h~cciss_gt_16_ld_for_lx2619-rc4 drivers/block/cciss_cmd.h
--- linux-2.6/drivers/block/cciss_cmd.h~cciss_gt_16_ld_for_lx2619-rc4	2006-11-06 13:28:01.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss_cmd.h	2006-11-06 13:28:01.000000000 -0600
@@ -89,7 +89,7 @@ typedef union _u64bit
 //###########################################################################
 //STRUCTURES
 //###########################################################################
-#define CISS_MAX_LUN	16	
+#define CISS_MAX_LUN	1024
 #define CISS_MAX_PHYS_LUN	1024
 // SCSI-3 Cmmands 
 
diff -puN drivers/block/cciss.h~cciss_gt_16_ld_for_lx2619-rc4 drivers/block/cciss.h
--- linux-2.6/drivers/block/cciss.h~cciss_gt_16_ld_for_lx2619-rc4	2006-11-06 13:28:01.000000000 -0600
+++ linux-2.6-root/drivers/block/cciss.h	2006-11-06 13:28:01.000000000 -0600
@@ -6,7 +6,6 @@
 #include "cciss_cmd.h"
 
 
-#define NWD		16
 #define NWD_SHIFT	4
 #define MAX_PART	(1 << NWD_SHIFT)
 
@@ -112,7 +111,7 @@ struct ctlr_info 
 	int			next_to_run;
 
 	// Disk structures we need to pass back
-	struct gendisk   *gendisk[NWD];
+	struct gendisk   *gendisk[CISS_MAX_LUN];
 #ifdef CONFIG_CISS_SCSI_TAPE
 	void *scsi_ctlr; /* ptr to structure containing scsi related stuff */
 	/* list of block side commands the scsi error handling sucked up */
diff -puN include/linux/cciss_ioctl.h~cciss_gt_16_ld_for_lx2619-rc4 include/linux/cciss_ioctl.h
--- linux-2.6/include/linux/cciss_ioctl.h~cciss_gt_16_ld_for_lx2619-rc4	2006-11-06 13:28:01.000000000 -0600
+++ linux-2.6-root/include/linux/cciss_ioctl.h	2006-11-06 13:28:01.000000000 -0600
@@ -80,7 +80,7 @@ typedef __u32 DriverVer_type;
 #define HWORD __u16
 #define DWORD __u32
 
-#define CISS_MAX_LUN	16	
+#define CISS_MAX_LUN	1024
 
 #define LEVEL2LUN   1   // index into Target(x) structure, due to byte swapping
 #define LEVEL3LUN   0
_
