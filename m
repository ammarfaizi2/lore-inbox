Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUCIQxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUCIQxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:53:50 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:34830 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261959AbUCIQxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:53:42 -0500
Date: Tue, 9 Mar 2004 11:03:20 -0600
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: per device queues for cciss 2.6.0
Message-ID: <20040309170320.GA20073@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is resubmission of yesterdays patch. It adds support for per logical device queues in the cciss driver. I have clarified that we only use one lock for all queues and it is held as specified in ll_rw_block.c. The locking needs to be redone for maximum efficiency but schedules don't permit that work at this time. This was done to fix an Oops with multiple logical volumes on a controller.
Please consider this patch for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------

diff -burN lx264.orig/drivers/block/cciss.c lx264/drivers/block/cciss.c
--- lx264.orig/drivers/block/cciss.c	2004-02-17 21:59:44.000000000 -0600
+++ lx264/drivers/block/cciss.c	2004-03-09 08:43:27.000000000 -0600
@@ -210,7 +210,7 @@
 
         pos += size; len += size;
 	cciss_proc_tape_report(ctlr, buffer, &pos, &len);
-	for(i=0; i<h->highest_lun; i++) {
+	for(i=0; i<=h->highest_lun; i++) {
 		sector_t tmp;
 
                 drv = &h->drv[i];
@@ -991,7 +991,7 @@
 		drive_info_struct *drv = &(host->drv[i]);
 		if (!drv->nr_blocks)
 			continue;
-		blk_queue_hardsect_size(host->queue, drv->block_size);
+		blk_queue_hardsect_size(drv->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
@@ -2016,7 +2016,7 @@
 	CommandList_struct *c;
 	unsigned long flags;
 	__u32 a, a1;
-
+	int j;
 
 	/* Is this interrupt for us? */
 	if (( h->access.intr_pending(h) == 0) || (h->interrupts_enabled == 0))
@@ -2062,11 +2062,23 @@
 			}
 		}
 	}
-
 	/*
 	 * See if we can queue up some more IO
+	 * check every disk that exists on this controller 
+	 * and start it's IO
+	 * At this time we use only one lock for all queues, probably
+	 * not an ideal implemetation but it was required to fix
+	 * an Oops. We will have to implement per queue locks when
+	 * time permits.
+	 * 
 	 */
-	blk_start_queue(h->queue);
+	for(j=0;j < NWD; j++) {
+		/* make sure the disk has been added and the drive is real */
+		/* because this can be called from the middle of init_one */
+		if(!(h->gendisk[j]->queue) || !(h->drv[j].nr_blocks) )
+			continue;
+		blk_start_queue(h->gendisk[j]->queue);
+	}
 	spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
 	return IRQ_HANDLED;
 }
@@ -2513,7 +2525,6 @@
 static int __devinit cciss_init_one(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
-	request_queue_t *q;
 	int i;
 	int j;
 
@@ -2571,13 +2582,6 @@
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
@@ -2599,6 +2603,19 @@
 
 	cciss_procinit(i);
 
+	for(j=0; j<NWD; j++) {
+		drive_info_struct *drv = &(hba[i]->drv[j]);
+		struct gendisk *disk = hba[i]->gendisk[j];
+		request_queue_t *q;
+
+	        q = blk_init_queue(do_cciss_request, &hba[i]->lock);
+		if (!q) {
+			printk(KERN_ERR 
+			   "cciss:  unable to allocate queue for disk %d\n",
+			   j);
+			break;
+		}
+		drv->queue = q;
 	blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
 
 	/* This is a hardware imposed limit. */
@@ -2609,21 +2626,17 @@
 
 	blk_queue_max_sectors(q, 512);
 
-
-	for(j=0; j<NWD; j++) {
-		drive_info_struct *drv = &(hba[i]->drv[j]);
-		struct gendisk *disk = hba[i]->gendisk[j];
-
+		q->queuedata = hba[i];
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
 		sprintf(disk->devfs_name, "cciss/host%d/target%d", i, j);
 		disk->major = COMPAQ_CISS_MAJOR + i;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->fops = &cciss_fops;
-		disk->queue = hba[i]->queue;
+		disk->queue = q;
 		disk->private_data = drv;
 		if( !(drv->nr_blocks))
 			continue;
-		blk_queue_hardsect_size(hba[i]->queue, drv->block_size);
+		blk_queue_hardsect_size(q, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
@@ -2693,9 +2706,9 @@
 		struct gendisk *disk = hba[i]->gendisk[j];
 		if (disk->flags & GENHD_FL_UP)
 			del_gendisk(disk);
+			blk_cleanup_queue(disk->queue);
 	}
 
-	blk_cleanup_queue(hba[i]->queue);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
 			    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof( ErrorInfo_struct),
diff -burN lx264.orig/drivers/block/cciss.h lx264/drivers/block/cciss.h
--- lx264.orig/drivers/block/cciss.h	2004-02-17 21:57:11.000000000 -0600
+++ lx264/drivers/block/cciss.h	2004-03-04 15:38:50.000000000 -0600
@@ -27,6 +27,7 @@
 {
  	__u32   LunID;	
 	int 	usage_count;
+	struct request_queue *queue;
 	sector_t nr_blocks;
 	int	block_size;
 	int 	heads;
@@ -69,7 +70,6 @@
 	unsigned int maxQsinceinit;
 	unsigned int maxSG;
 	spinlock_t lock;
-	struct request_queue *queue;
 
 	//* pointers to command and error info pool */ 
 	CommandList_struct 	*cmd_pool;
@@ -252,7 +252,7 @@
 	struct access_method *access;
 };
 
-#define CCISS_LOCK(i)	(hba[i]->queue->queue_lock)
+#define CCISS_LOCK(i)	(&(hba[i]->lock))
 
 #endif /* CCISS_H */
 
