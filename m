Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUCHTkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUCHTkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:40:23 -0500
Received: from mailout.zma.compaq.com ([161.114.64.105]:21260 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261158AbUCHTkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:40:07 -0500
Date: Mon, 8 Mar 2004 13:49:57 -0600
From: mikem@beardog.cca.cpqcorp.net
To: apkm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: cciss per device queue patch for 2.6.4
Message-ID: <20040308194957.GA18954@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for per logical device queues for the HP cciss driver. It fixes an Oops when multiple logical drives are configured on the same controller. It may also help performance but has not been benchmarked as yet. Please consider this for inclusion. It has built & tested against 2.6.3 & 2.6.4-rc2.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burN lx264.test/drivers/block/cciss.c lx264/drivers/block/cciss.c
--- lx264.test/drivers/block/cciss.c	2004-03-04 13:38:49.000000000 -0600
+++ lx264/drivers/block/cciss.c	2004-03-04 11:45:56.000000000 -0600
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
@@ -2062,11 +2062,18 @@
 			}
 		}
 	}
-
 	/*
 	 * See if we can queue up some more IO
+	 * check every disk that exists on this controller 
+	 * and start it's IO
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
@@ -2513,7 +2520,6 @@
 static int __devinit cciss_init_one(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
-	request_queue_t *q;
 	int i;
 	int j;
 
@@ -2571,13 +2577,6 @@
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
@@ -2599,6 +2598,19 @@
 
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
@@ -2609,21 +2621,17 @@
 
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
@@ -2693,9 +2701,9 @@
 		struct gendisk *disk = hba[i]->gendisk[j];
 		if (disk->flags & GENHD_FL_UP)
 			del_gendisk(disk);
+			blk_cleanup_queue(disk->queue);
 	}
 
-	blk_cleanup_queue(hba[i]->queue);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
 			    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof( ErrorInfo_struct),
diff -burN lx264.test/drivers/block/cciss.h lx264/drivers/block/cciss.h
--- lx264.test/drivers/block/cciss.h	2004-02-17 21:57:11.000000000 -0600
+++ lx264/drivers/block/cciss.h	2004-03-04 11:45:56.000000000 -0600
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
------------------------------------------------------------------------------ 
