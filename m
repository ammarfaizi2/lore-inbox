Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSHSBYK>; Sun, 18 Aug 2002 21:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSHSBYK>; Sun, 18 Aug 2002 21:24:10 -0400
Received: from dp.samba.org ([66.70.73.150]:49556 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316601AbSHSBYI>;
	Sun, 18 Aug 2002 21:24:08 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15712.18690.602717.216938@argo.ozlabs.ibm.com>
Date: Mon, 19 Aug 2002 11:25:22 +1000 (EST)
To: torvalds@transmeta.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] update 2.5 ide-pmac.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates drivers/ide/ide-pmac.c to use the 2.5 block device
interface rather than the 2.4 interface.  I have heard that Andre's
new code is going in, which will be good, but until then those of us
with powermacs will need this patch, so Linus, please apply this to
your tree.

Paul.

diff -urN linux-2.5/drivers/ide/ide-pmac.c pmac-2.5/drivers/ide/ide-pmac.c
--- linux-2.5/drivers/ide/ide-pmac.c	Fri Aug 16 22:07:14 2002
+++ pmac-2.5/drivers/ide/ide-pmac.c	Sat Aug 17 21:32:02 2002
@@ -46,7 +46,7 @@
 
 extern void ide_do_request(ide_hwgroup_t *hwgroup, int masked_irq);
 
-#define IDE_PMAC_DEBUG
+#undef IDE_PMAC_DEBUG
 
 #define DMA_WAIT_TIMEOUT	500
 
@@ -746,11 +746,11 @@
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
@@ -925,7 +925,7 @@
 #endif /* CONFIG_PMAC_PBOOK */
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
-		if (np->n_addrs >= 2) {
+		if (pdev && np->n_addrs >= 2) {
 			/* has a DBDMA controller channel */
 			pmac_ide_setup_dma(np, i);
 		}
@@ -993,35 +993,19 @@
 {
 	ide_hwif_t *hwif = &ide_hwifs[ix];
 	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
-	struct buffer_head *bh;
+	request_queue_t *q = &hwif->drives[DEVICE_NR(rq->rq_dev) & 1].queue;
 	struct scatterlist *sg = pmif->sg_table;
-	int nents = 0;
+	int nents;
 
-	if (hwif->sg_dma_active)
-		BUG();
-		
-	if (rq->cmd == READ)
+	nents = blk_rq_map_sg(q, rq, pmif->sg_table);
+
+	if (rq->q && nents > rq->nr_phys_segments)
+		printk("ide-pmac: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
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
@@ -1041,20 +1025,22 @@
 		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
 	else
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
-	
+
 	if (sector_count > 128) {
 		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 		sg[nents].length = 128  * SECTOR_SIZE;
 		nents++;
 		virt_addr = virt_addr + (128 * SECTOR_SIZE);
 		sector_count -= 128;
 	}
 	memset(&sg[nents], 0, sizeof(*sg));
-	sg[nents].address = virt_addr;
+	sg[nents].page = virt_to_page(virt_addr);
+	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
 	sg[nents].length =  sector_count  * SECTOR_SIZE;
 	nents++;
-   
+
 	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
 }
 
@@ -1080,7 +1066,7 @@
 		udelay(1);
 
 	/* Build sglist */
-	if (HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASKFILE)
+	if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE)
 		pmac_ide[ix].sg_nents = i = pmac_ide_raw_build_sglist(ix, rq);
 	else
 		pmac_ide[ix].sg_nents = i = pmac_ide_build_sglist(ix, rq);
@@ -1346,7 +1332,7 @@
 		OUT_BYTE(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
 	}
 #else
-		if (HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASKFILE) {
+		if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
 			ide_task_t *args = HWGROUP(drive)->rq->special;
 			OUT_BYTE(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
 		} else if (drive->addressing == 1)
