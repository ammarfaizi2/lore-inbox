Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbVF3WDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbVF3WDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbVF3WDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:03:39 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:45267 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S263063AbVF3WDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:03:05 -0400
Date: Thu, 30 Jun 2005 16:03:42 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/1] cciss per disk queue for 2.6
Message-ID: <20050630210342.GA28770@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds per disk queue functionality to cciss. Sometime back I submitted a patch but it looks like only part of what I needed. In the 2.6 kernel if we have more than one logical volume the driver will Oops during rmmod. It seems all of the queues actually point back to the same queue. So after deleting the first volume you hit a null pointer on the second one.

This has been tested in our labs. There is no difference in performance, it just fixes the Oops. Please consider this patch for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |   49 ++++++++++++++++++++++++++-----------------------
 cciss.h |    4 ++--
 2 files changed, 28 insertions(+), 25 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2612-rc6.orig/drivers/block/cciss.c lx2612-rc6-tmp/drivers/block/cciss.c
--- lx2612-rc6.orig/drivers/block/cciss.c	2005-06-13 14:51:02.000000000 -0500
+++ lx2612-rc6-tmp/drivers/block/cciss.c	2005-06-30 16:54:56.000000000 -0500
@@ -1140,7 +1140,7 @@ static int revalidate_allvol(ctlr_info_t
 		/* this is for the online array utilities */
 		if (!drv->heads && i)
 			continue;
-		blk_queue_hardsect_size(host->queue, drv->block_size);
+		blk_queue_hardsect_size(drv->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
@@ -1696,7 +1696,7 @@ static int cciss_revalidate(struct gendi
 	cciss_read_capacity(h->ctlr, logvol, size_buff, 1, &total_size, &block_size);
 	cciss_geometry_inquiry(h->ctlr, logvol, 1, total_size, block_size, inq_buff, drv);
 
-	blk_queue_hardsect_size(h->queue, drv->block_size);
+	blk_queue_hardsect_size(drv->queue, drv->block_size);
 	set_capacity(disk, drv->nr_blocks);
 
 	kfree(size_buff);
@@ -2253,12 +2253,12 @@ static irqreturn_t do_cciss_intr(int irq
  	 * them up.  We will also keep track of the next queue to run so
  	 * that every queue gets a chance to be started first.
  	*/
- 	for (j=0; j < NWD; j++){
- 		int curr_queue = (start_queue + j) % NWD;
+	for (j=0; j < h->highest_lun + 1; j++){
+		int curr_queue = (start_queue + j) % (h->highest_lun + 1);
  		/* make sure the disk has been added and the drive is real
  		 * because this can be called from the middle of init_one.
  		*/
- 		if(!(h->gendisk[curr_queue]->queue) ||
+		if(!(h->drv[curr_queue].queue) || 
 		 		   !(h->drv[curr_queue].heads))
  			continue;
  		blk_start_queue(h->gendisk[curr_queue]->queue);
@@ -2269,14 +2269,14 @@ static irqreturn_t do_cciss_intr(int irq
  		if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS)
  		{
  			if (curr_queue == start_queue){
- 				h->next_to_run = (start_queue + 1) % NWD;
+				h->next_to_run = (start_queue + 1) % (h->highest_lun + 1);
  				goto cleanup;
  			} else {
  				h->next_to_run = curr_queue;
  				goto cleanup;
  	}
  		} else {
- 			curr_queue = (curr_queue + 1) % NWD;
+			curr_queue = (curr_queue + 1) % (h->highest_lun + 1);
  		}
  	}
 
@@ -2284,7 +2284,6 @@ cleanup:
 	spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
 	return IRQ_HANDLED;
 }
-
 /* 
  *  We cannot read the structure directly, for portablity we must use 
  *   the io functions.
@@ -2799,13 +2798,6 @@ static int __devinit cciss_init_one(stru
 	}
 
 	spin_lock_init(&hba[i]->lock);
-	q = blk_init_queue(do_cciss_request, &hba[i]->lock);
-	if (!q)
-		goto clean4;
-
-	q->backing_dev_info.ra_pages = READ_AHEAD;
-	hba[i]->queue = q;
-	q->queuedata = hba[i];
 
 	/* Initialize the pdev driver private data. 
 		have it point to hba[i].  */
@@ -2827,6 +2819,20 @@ static int __devinit cciss_init_one(stru
 
 	cciss_procinit(i);
 
+	for(j=0; j < NWD; j++) { /* mfm */
+		drive_info_struct *drv = &(hba[i]->drv[j]);
+		struct gendisk *disk = hba[i]->gendisk[j];
+
+		q = blk_init_queue(do_cciss_request, &hba[i]->lock);
+		if (!q) {
+			printk(KERN_ERR
+			   "cciss:  unable to allocate queue for disk %d\n",
+			   j);
+			break;
+		}
+		drv->queue = q;
+
+		q->backing_dev_info.ra_pages = READ_AHEAD;
 	blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
 
 	/* This is a hardware imposed limit. */
@@ -2837,26 +2843,23 @@ static int __devinit cciss_init_one(stru
 
 	blk_queue_max_sectors(q, 512);
 
-
-	for(j=0; j<NWD; j++) {
-		drive_info_struct *drv = &(hba[i]->drv[j]);
-		struct gendisk *disk = hba[i]->gendisk[j];
-
+		q->queuedata = hba[i];
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
 		sprintf(disk->devfs_name, "cciss/host%d/target%d", i, j);
 		disk->major = hba[i]->major;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->fops = &cciss_fops;
-		disk->queue = hba[i]->queue;
+		disk->queue = q;
 		disk->private_data = drv;
 		/* we must register the controller even if no disks exist */
 		/* this is for the online array utilities */
 		if(!drv->heads && j)
 			continue;
-		blk_queue_hardsect_size(hba[i]->queue, drv->block_size);
+		blk_queue_hardsect_size(q, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
+
 	return(1);
 
 clean4:
@@ -2922,10 +2925,10 @@ static void __devexit cciss_remove_one (
 	for (j = 0; j < NWD; j++) {
 		struct gendisk *disk = hba[i]->gendisk[j];
 		if (disk->flags & GENHD_FL_UP)
+			blk_cleanup_queue(disk->queue);
 			del_gendisk(disk);
 	}
 
-	blk_cleanup_queue(hba[i]->queue);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
 			    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof( ErrorInfo_struct),
diff -burNp lx2612-rc6.orig/drivers/block/cciss.h lx2612-rc6-tmp/drivers/block/cciss.h
--- lx2612-rc6.orig/drivers/block/cciss.h	2005-06-13 14:51:02.000000000 -0500
+++ lx2612-rc6-tmp/drivers/block/cciss.h	2005-06-30 16:46:10.000000000 -0500
@@ -29,6 +29,7 @@ typedef struct _drive_info_struct
 {
  	__u32   LunID;	
 	int 	usage_count;
+	struct request_queue *queue;
 	sector_t nr_blocks;
 	int	block_size;
 	int 	heads;
@@ -72,7 +73,6 @@ struct ctlr_info 
 	unsigned int maxQsinceinit;
 	unsigned int maxSG;
 	spinlock_t lock;
-	struct request_queue *queue;
 
 	//* pointers to command and error info pool */ 
 	CommandList_struct 	*cmd_pool;
@@ -260,7 +260,7 @@ struct board_type {
 	struct access_method *access;
 };
 
-#define CCISS_LOCK(i)	(hba[i]->queue->queue_lock)
+#define CCISS_LOCK(i)	(&hba[i]->lock)
 
 #endif /* CCISS_H */
 
