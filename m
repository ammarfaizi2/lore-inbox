Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263982AbUDFUAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUDFUAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:00:49 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:19210 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263982AbUDFUAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:00:39 -0400
Date: Tue, 6 Apr 2004 15:10:30 -0500
From: mikem@beardog.cca.cpqcorp.net
To: alpm@odsl.org, asboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6.6xxx [1/2]
Message-ID: <20040406201030.GB2554@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds per logical device queues to the HP cciss driver. It currently only implements a single lock but when time permits I will provide that funtionality. Thanks to Jeff Garzik for providing some sample code.
This patch built against 2.6.5. Please consider this for inclusion.

mikem
-------------------------------------------------------------------------------

diff -burpN lx265.orig/drivers/block/cciss.c lx265.save/drivers/block/cciss.c
--- lx265.orig/drivers/block/cciss.c	2004-04-03 21:38:20.000000000 -0600
+++ lx265.save/drivers/block/cciss.c	2004-04-06 10:22:08.000000000 -0500
@@ -988,7 +988,7 @@ static int revalidate_allvol(ctlr_info_t
 		drive_info_struct *drv = &(host->drv[i]);
 		if (!drv->nr_blocks)
 			continue;
-		blk_queue_hardsect_size(host->queue, drv->block_size);
+		blk_queue_hardsect_size(drv->queue, drv->block_size);
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
@@ -2013,7 +2013,7 @@ static irqreturn_t do_cciss_intr(int irq
 	CommandList_struct *c;
 	unsigned long flags;
 	__u32 a, a1;
-
+	int j;
 
 	/* Is this interrupt for us? */
 	if (( h->access.intr_pending(h) == 0) || (h->interrupts_enabled == 0))
@@ -2059,11 +2059,18 @@ static irqreturn_t do_cciss_intr(int irq
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
@@ -2510,7 +2517,6 @@ static void free_hba(int i)
 static int __devinit cciss_init_one(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
-	request_queue_t *q;
 	int i;
 	int j;
 
@@ -2568,13 +2574,6 @@ static int __devinit cciss_init_one(stru
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
@@ -2596,6 +2595,19 @@ static int __devinit cciss_init_one(stru
 
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
@@ -2606,21 +2618,17 @@ static int __devinit cciss_init_one(stru
 
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
@@ -2690,9 +2698,9 @@ static void __devexit cciss_remove_one (
 		struct gendisk *disk = hba[i]->gendisk[j];
 		if (disk->flags & GENHD_FL_UP)
 			del_gendisk(disk);
+			blk_cleanup_queue(disk->queue);
 	}
 
-	blk_cleanup_queue(hba[i]->queue);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
 			    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof( ErrorInfo_struct),
diff -burpN lx265.orig/drivers/block/cciss.h lx265.save/drivers/block/cciss.h
--- lx265.orig/drivers/block/cciss.h	2004-04-03 21:36:13.000000000 -0600
+++ lx265.save/drivers/block/cciss.h	2004-04-06 10:22:08.000000000 -0500
@@ -27,6 +27,7 @@ typedef struct _drive_info_struct
 {
  	__u32   LunID;	
 	int 	usage_count;
+	struct request_queue *queue;
 	sector_t nr_blocks;
 	int	block_size;
 	int 	heads;
@@ -69,7 +70,6 @@ struct ctlr_info 
 	unsigned int maxQsinceinit;
 	unsigned int maxSG;
 	spinlock_t lock;
-	struct request_queue *queue;
 
 	//* pointers to command and error info pool */ 
 	CommandList_struct 	*cmd_pool;
@@ -252,7 +252,7 @@ struct board_type {
 	struct access_method *access;
 };
 
-#define CCISS_LOCK(i)	(hba[i]->queue->queue_lock)
+#define CCISS_LOCK(i)	(&(hba[i]->lock))
 
 #endif /* CCISS_H */
 
