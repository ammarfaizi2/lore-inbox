Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266282AbSKGChJ>; Wed, 6 Nov 2002 21:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSKGChJ>; Wed, 6 Nov 2002 21:37:09 -0500
Received: from dp.samba.org ([66.70.73.150]:57261 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266282AbSKGChG>;
	Wed, 6 Nov 2002 21:37:06 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.54051.309679.395892@argo.ozlabs.ibm.com>
Date: Thu, 7 Nov 2002 13:42:43 +1100
To: Jens Axboe <axboe@suse.de>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] Update powermac IDE driver
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the powermac IDE driver in 2.5 so it uses the 2.5
kernel interfaces and types rather than the 2.4 ones.  It also makes
it use blk_rq_map_sg rather than its own code to set up scatter/gather
lists in pmac_ide_build_sglist, and makes it use ide_lock instead of
io_request_lock.

Jens/Linus, please apply.

Paul.

diff -urN linux-2.5/drivers/ide/ppc/pmac.c pmac-2.5/drivers/ide/ppc/pmac.c
--- linux-2.5/drivers/ide/ppc/pmac.c	2002-10-30 01:37:31.000000000 +1100
+++ pmac-2.5/drivers/ide/ppc/pmac.c	2002-11-02 07:27:28.000000000 +1100
@@ -717,11 +717,11 @@
 		name = pmac_ide[i].node->full_name;
 		if (memcmp(name, bootdevice, n) == 0 && name[n] == 0) {
 			/* XXX should cope with the 2nd drive as well... */
-			return MKDEV(ide_majors[i], 0);
+			return mk_kdev(ide_majors[i], 0);
 		}
 	}
 
-	return 0;
+	return NODEV;
 }
 
 void __init
@@ -932,47 +932,32 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
 static int
-pmac_ide_build_sglist(ide_hwif_t *hwif, struct request *rq)
+pmac_ide_build_sglist(ide_drive_t *drive, struct request *rq)
 {
+	ide_hwif_t *hwif = HWIF(drive);
 	pmac_ide_hwif_t *pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
-	struct buffer_head *bh;
 	struct scatterlist *sg = pmif->sg_table;
-	int nents = 0;
+	int nents;
 
 	if (hwif->sg_dma_active)
 		BUG();
 		
-	if (rq->cmd == READ)
+	nents = blk_rq_map_sg(&drive->queue, rq, sg);
+		
+	if (rq_data_dir(rq) == READ)
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	else
 		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
-	bh = rq->bh;
-	do {
-		unsigned char *virt_addr = bh->b_data;
-		unsigned int size = bh->b_size;
-
-		if (nents >= MAX_DCMDS)
-			return 0;
-
-		while ((bh = bh->b_reqnext) != NULL) {
-			if ((virt_addr + size) != (unsigned char *) bh->b_data)
-				break;
-			size += bh->b_size;
-		}
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
-		sg[nents].length = size;
-		nents++;
-	} while (bh != NULL);
 
 	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
 }
 
 static int
-pmac_ide_raw_build_sglist(ide_hwif_t *hwif, struct request *rq)
+pmac_ide_raw_build_sglist(ide_drive_t *drive, struct request *rq)
 {
+	ide_hwif_t *hwif = HWIF(drive);
 	pmac_ide_hwif_t *pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
-	struct scatterlist *sg = hwif->sg_table;
+	struct scatterlist *sg = pmif->sg_table;
 	int nents = 0;
 	ide_task_t *args = rq->special;
 	unsigned char *virt_addr = rq->buffer;
@@ -983,16 +968,18 @@
 	else
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	
-	if (sector_count > 128) {
+	if (sector_count > 127) {
 		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
-		sg[nents].length = 128  * SECTOR_SIZE;
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+		sg[nents].length = 127  * SECTOR_SIZE;
 		nents++;
-		virt_addr = virt_addr + (128 * SECTOR_SIZE);
-		sector_count -= 128;
+		virt_addr = virt_addr + (127 * SECTOR_SIZE);
+		sector_count -= 127;
 	}
 	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].address = virt_addr;
+	sg[nents].page = virt_to_page(virt_addr);
+	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
    
@@ -1023,10 +1010,10 @@
 		udelay(1);
 
 	/* Build sglist */
-	if (rq->cmd == IDE_DRIVE_TASKFILE)
-		pmif->sg_nents = i = pmac_ide_raw_build_sglist(hwif, rq);
+	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
+		pmif->sg_nents = i = pmac_ide_raw_build_sglist(drive, rq);
 	else
-		pmif->sg_nents = i = pmac_ide_build_sglist(hwif, rq);
+		pmif->sg_nents = i = pmac_ide_build_sglist(drive, rq);
 	if (!i)
 		return 0;
 
@@ -1045,7 +1032,7 @@
 			if (++count >= MAX_DCMDS) {
 				printk(KERN_WARNING "%s: DMA table too small\n",
 				       drive->name);
-				return 0; /* revert to PIO for this request */
+				goto use_pio_instead;
 			}
 			st_le16(&table->command, wr? OUTPUT_MORE: INPUT_MORE);
 			st_le16(&table->req_count, tc);
@@ -1062,17 +1049,24 @@
 	}
 
 	/* convert the last command to an input/output last command */
-	if (count)
+	if (count) {
 		st_le16(&table[-1].command, wr? OUTPUT_LAST: INPUT_LAST);
-	else
-		printk(KERN_DEBUG "%s: empty DMA table?\n", drive->name);
+		/* add the stop command to the end of the list */
+		memset(table, 0, sizeof(struct dbdma_cmd));
+		st_le16(&table->command, DBDMA_STOP);
+		mb();
+		writel(pmif->dma_table_dma, &dma->cmdptr);
+		return 1;
+	}
 
-	/* add the stop command to the end of the list */
-	memset(table, 0, sizeof(struct dbdma_cmd));
-	st_le16(&table->command, DBDMA_STOP);
-	mb();
-	writel(pmif->dma_table_dma, &dma->cmdptr);
-	return 1;
+	printk(KERN_DEBUG "%s: empty DMA table?\n", drive->name);
+ use_pio_instead:
+	pci_unmap_sg(hwif->pci_dev,
+		     pmif->sg_table,
+		     pmif->sg_nents,
+		     pmif->sg_dma_direction);
+	hwif->sg_dma_active = 0;
+	return 0; /* revert to PIO for this request */
 }
 
 /* Teardown mappings after DMA has completed.  */
@@ -1279,7 +1273,7 @@
 	}
 #else
 	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
-	if (rq->cmd == IDE_DRIVE_TASKFILE) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
 	}
@@ -1332,7 +1326,7 @@
 	}
 #else
 	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-	if (rq->cmd == IDE_DRIVE_TASKFILE) {
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
 	}
@@ -1579,8 +1573,8 @@
 	 * Problem: This can schedule. I moved the block device
 	 * wakeup almost late by priority because of that.
 	 */
-	if (DRIVER(drive))
-		check_disk_change(MKDEV(drive->disk->major, drive->disk->first_minor));
+	//if (DRIVER(drive))
+	//	check_disk_change(MKDEV(drive->disk->major, drive->disk->first_minor));
 	
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	/* We re-enable DMA on the drive if it was active. */
@@ -1595,7 +1589,7 @@
 		HWGROUP(drive)->busy = 0;
 		if (!list_empty(&drive->queue.queue_head))
 			ide_do_request(HWGROUP(drive), 0);
-		spin_unlock_irq(&io_request_lock);
+		spin_unlock_irq(&ide_lock);
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 }
@@ -1648,7 +1642,7 @@
 		idepmac_sleep_device(drive, base);
 	}
 	if (unlock)
-		spin_unlock_irq(&io_request_lock);
+		spin_unlock_irq(&ide_lock);
 }
 
 static void
@@ -1675,11 +1669,11 @@
 	}
 
 	/* We resume processing on the HW group */
-	spin_lock_irqsave(&io_request_lock, flags);
+	spin_lock_irqsave(&ide_lock, flags);
 	HWGROUP(drive)->busy = 0;
 	if (!list_empty(&drive->queue.queue_head))
 		ide_do_request(HWGROUP(drive), 0);
-	spin_unlock_irqrestore(&io_request_lock, flags);			
+	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 /* Note: We support only master drives for now. This will have to be
