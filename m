Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbUCRJw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUCRJw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:52:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43435 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262497AbUCRJvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:51:48 -0500
Message-ID: <40597123.8020903@pobox.com>
Date: Thu, 18 Mar 2004 04:51:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@user.it.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: tulip (pnic) errors in 2.6.5-rc1
References: <16473.28514.341276.209224@alkaid.it.uu.se>
In-Reply-To: <16473.28514.341276.209224@alkaid.it.uu.se>
Content-Type: multipart/mixed;
 boundary="------------000604010002020205090204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000604010002020205090204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mikael Pettersson wrote:
> 2.6.5-rc1 causes my Netgear FA310TX to
> fill the kernel log with messages like:

There doesn't seem to be anything interesting in the tulip driver 
changes, but who knows.  Does reverting the attached patch help?

Note the pci_dma_sync_xxx changes in the patch may be required to build, 
I'm not sure.

	Jeff



--------------000604010002020205090204
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

--------------000604010002020205090204--

