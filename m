Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUCRIvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCRIvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:51:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20623 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262077AbUCRIve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:51:34 -0500
Message-ID: <40596304.9090602@pobox.com>
Date: Thu, 18 Mar 2004 03:51:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH,RFT] work on Silicon Image 3114 4-port support
Content-Type: multipart/mixed;
 boundary="------------020400070508010300070207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020400070508010300070207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The Silicon Image 3114 is the four-port counterpart to the 3112.  It has 
a magic "make all four ports work" bit that must be set, in order to 
receive interrupts from all four ports.  This bit, annoyingly, was 
placed in a register that software has traditionally chosen to 
unconditionally zero.  Doh.

The attached patch sets/clears only the bits we care about, which 
deviates from legacy software, but is arguably better behavior.

The patch shuffles, but does not add, IOs in the dma-start path.  And it 
adds one IO, a read, to the dma-stop path.  This affects everybody, so 
testing of this patch on -any- libata-supported hardware would be 
appreciated.

	Jeff




--------------020400070508010300070207
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.26 vs edited =====
--- 1.26/drivers/scsi/libata-core.c	Mon Mar 15 11:43:58 2004
+++ edited/drivers/scsi/libata-core.c	Thu Mar 18 03:36:13 2004
@@ -2263,9 +2263,12 @@
 	mb();	/* make sure PRD table writes are visible to controller */
 	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
 
-	/* specify data direction */
-	/* FIXME: redundant to later start-dma command? */
-	writeb(rw ? 0 : ATA_DMA_WR, mmio + ATA_DMA_CMD);
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	writeb(dmactl, mmio + ATA_DMA_CMD);
 
 	/* clear interrupt, error bits */
 	host_stat = readb(mmio + ATA_DMA_STATUS);
@@ -2275,7 +2278,6 @@
 	ap->ops->exec_command(ap, &qc->tf);
 
 	/* start host DMA transaction */
-	dmactl = readb(mmio + ATA_DMA_CMD);
 	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
 
 	/* Strictly, one may wish to issue a readb() here, to
@@ -2308,9 +2310,12 @@
 	/* load PRD table addr. */
 	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
 
-	/* specify data direction */
-	/* FIXME: redundant to later start-dma command? */
-	outb(rw ? 0 : ATA_DMA_WR, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* clear interrupt, error bits */
 	host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
@@ -2321,7 +2326,6 @@
 	ap->ops->exec_command(ap, &qc->tf);
 
 	/* start host DMA transaction */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	outb(dmactl | ATA_DMA_START,
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
@@ -2344,14 +2348,16 @@
 		void *mmio = (void *) ap->ioaddr.bmdma_addr;
 
 		/* clear start/stop bit */
-		writeb(0, mmio + ATA_DMA_CMD);
+		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+		       mmio + ATA_DMA_CMD);
 
 		/* ack intr, err bits */
 		writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
 		       mmio + ATA_DMA_STATUS);
 	} else {
 		/* clear start/stop bit */
-		outb(0, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+		     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 		/* ack intr, err bits */
 		outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,

--------------020400070508010300070207--

