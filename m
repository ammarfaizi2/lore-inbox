Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSIKMwF>; Wed, 11 Sep 2002 08:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318762AbSIKMwF>; Wed, 11 Sep 2002 08:52:05 -0400
Received: from dp.samba.org ([66.70.73.150]:39141 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318752AbSIKMwA>;
	Wed, 11 Sep 2002 08:52:00 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15743.15275.412038.388540@argo.ozlabs.ibm.com>
Date: Wed, 11 Sep 2002 22:48:43 +1000 (EST)
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] highmem I/O for ide-pmac.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch fixes drivers/ide/ide-pmac.c to handle I/O to highmem
pages.  Please apply it to your tree.

Thanks,
Paul.

diff -urN linux-2.4/drivers/ide/ide-pmac.c linuxppc_2_4/drivers/ide/ide-pmac.c
--- linux-2.4/drivers/ide/ide-pmac.c	Wed Aug  7 18:09:29 2002
+++ linuxppc_2_4/drivers/ide/ide-pmac.c	Sun Aug 18 22:12:10 2002
@@ -1032,33 +1032,48 @@
 	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
 	struct buffer_head *bh;
 	struct scatterlist *sg = pmif->sg_table;
+	unsigned long lastdataend = ~0UL;
 	int nents = 0;
 
 	if (hwif->sg_dma_active)
 		BUG();
-		
+
 	if (rq->cmd == READ)
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	else
 		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
+
 	bh = rq->bh;
 	do {
-		unsigned char *virt_addr = bh->b_data;
+		struct scatterlist *sge;
 		unsigned int size = bh->b_size;
 
+		/* continue segment from before? */
+		if (bh_phys(bh) == lastdataend) {
+			sg[nents-1].length += size;
+			lastdataend += size;
+			continue;
+		}
+
+		/* start new segment */
 		if (nents >= MAX_DCMDS)
 			return 0;
 
-		while ((bh = bh->b_reqnext) != NULL) {
-			if ((virt_addr + size) != (unsigned char *) bh->b_data)
-				break;
-			size += bh->b_size;
+		sge = &sg[nents];
+		memset(sge, 0, sizeof(*sge));
+
+		if (bh->b_page) {
+			sge->page = bh->b_page;
+			sge->offset = bh_offset(bh);
+		} else {
+			if ((unsigned long)bh->b_data < PAGE_SIZE)
+				BUG();
+			sge->address = bh->b_data;
 		}
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
-		sg[nents].length = size;
+		sge->length = size;
+		lastdataend = bh_phys(bh) + size;
 		nents++;
-	} while (bh != NULL);
+	} while ((bh = bh->b_reqnext) != NULL);
 
 	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
 }
@@ -1330,6 +1345,23 @@
 	return 0;
 }
 
+static inline void pmac_ide_toggle_bounce(ide_drive_t *drive, int on)
+{
+	dma64_addr_t addr = BLK_BOUNCE_HIGH;
+
+	if (HWIF(drive)->no_highio || HWIF(drive)->pci_dev == NULL)
+		return;
+
+	if (on && drive->media == ide_disk) {
+		if (!PCI_DMA_BUS_IS_PHYS)
+			addr = BLK_BOUNCE_ANY;
+		else
+			addr = HWIF(drive)->pci_dev->dma_mask;
+	}
+
+	blk_queue_bounce_limit(&drive->queue, addr);
+}
+
 static int __pmac
 pmac_ide_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
 {
@@ -1354,6 +1386,7 @@
 		printk(KERN_INFO "%s: DMA disabled\n", drive->name);
 	case ide_dma_off_quietly:
 		drive->using_dma = 0;
+		pmac_ide_toggle_bounce(drive, 0);
 		break;
 	case ide_dma_on:
 	case ide_dma_check:
