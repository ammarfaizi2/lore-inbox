Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUH3WbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUH3WbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUH3WbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:31:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4361 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264919AbUH3W2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:28:10 -0400
Date: Mon, 30 Aug 2004 23:28:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] MMC updates
Message-ID: <20040830232801.G22480@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For anyone who's interested, here's an update to the MMC code Linus
recently merged.  Essentially, I've added SG support to the MMCI
primecell driver.

For specific changes, see the BK comments at the end of the patch.

diff -Nru a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
--- a/drivers/mmc/mmc.c	2004-08-30 17:49:30 +01:00
+++ b/drivers/mmc/mmc.c	2004-08-30 17:49:30 +01:00
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/mmc/mmc.c
  *
- *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,6 +14,7 @@
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/pagemap.h>
 #include <linux/err.h>
 
 #include <linux/mmc/card.h>
@@ -715,14 +716,21 @@
 	if (host) {
 		memset(host, 0, sizeof(struct mmc_host) + extra);
 
-		host->priv = host + 1;
-
 		spin_lock_init(&host->lock);
 		init_waitqueue_head(&host->wq);
 		INIT_LIST_HEAD(&host->cards);
 		INIT_WORK(&host->detect, mmc_rescan, host);
 
 		host->dev = dev;
+
+		/*
+		 * By default, hosts do not support SGIO or large requests.
+		 * They have to set these according to their abilities.
+		 */
+		host->max_hw_segs = 1;
+		host->max_phys_segs = 1;
+		host->max_sectors = 1 << (PAGE_CACHE_SHIFT - 9);
+		host->max_seg_size = PAGE_CACHE_SIZE;
 	}
 
 	return host;
diff -Nru a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c	2004-08-30 17:49:30 +01:00
+++ b/drivers/mmc/mmc_block.c	2004-08-30 17:49:30 +01:00
@@ -43,7 +43,6 @@
 #define MMC_SHIFT	3
 
 static int mmc_major;
-static int maxsectors = 8;
 
 /*
  * There is one mmc_blk_data per slot.
@@ -185,7 +184,7 @@
 		brq.data.timeout_ns = card->csd.tacc_ns * 10;
 		brq.data.timeout_clks = card->csd.tacc_clks * 10;
 		brq.data.blksz_bits = md->block_bits;
-		brq.data.blocks = req->current_nr_sectors >> (md->block_bits - 9);
+		brq.data.blocks = req->nr_sectors >> (md->block_bits - 9);
 		brq.stop.opcode = MMC_STOP_TRANSMISSION;
 		brq.stop.arg = 0;
 		brq.stop.flags = MMC_RSP_SHORT | MMC_RSP_CRC | MMC_RSP_BUSY;
@@ -334,11 +333,10 @@
 		sprintf(md->disk->disk_name, "mmcblk%d", devidx);
 		sprintf(md->disk->devfs_name, "mmc/blk%d", devidx);
 
-		md->block_bits = md->queue.card->csd.read_blkbits;
+		md->block_bits = card->csd.read_blkbits;
 
-		blk_queue_max_sectors(md->queue.queue, maxsectors);
 		blk_queue_hardsect_size(md->queue.queue, 1 << md->block_bits);
-		set_capacity(md->disk, md->queue.card->csd.capacity);
+		set_capacity(md->disk, card->csd.capacity);
 	}
  out:
 	return md;
@@ -440,7 +438,7 @@
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
-		mmc_blk_set_blksize(md, md->queue.card);
+		mmc_blk_set_blksize(md, card);
 		blk_start_queue(md->queue.queue);
 	}
 	return 0;
@@ -489,9 +487,6 @@
 
 module_init(mmc_blk_init);
 module_exit(mmc_blk_exit);
-module_param(maxsectors, int, 0444);
-
-MODULE_PARM_DESC(maxsectors, "Maximum number of sectors for a single request");
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
diff -Nru a/drivers/mmc/mmc_queue.c b/drivers/mmc/mmc_queue.c
--- a/drivers/mmc/mmc_queue.c	2004-08-30 17:49:30 +01:00
+++ b/drivers/mmc/mmc_queue.c	2004-08-30 17:49:30 +01:00
@@ -124,11 +124,12 @@
  */
 int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock)
 {
+	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
 	int ret;
 
-	if (card->host->dev->dma_mask && *card->host->dev->dma_mask)
-		limit = *card->host->dev->dma_mask;
+	if (host->dev->dma_mask && *host->dev->dma_mask)
+		limit = *host->dev->dma_mask;
 
 	mq->card = card;
 	mq->queue = blk_init_queue(mmc_request, lock);
@@ -137,6 +138,10 @@
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
 	blk_queue_bounce_limit(mq->queue, limit);
+	blk_queue_max_sectors(mq->queue, host->max_sectors);
+	blk_queue_max_phys_segments(mq->queue, host->max_phys_segs);
+	blk_queue_max_hw_segments(mq->queue, host->max_hw_segs);
+	blk_queue_max_segment_size(mq->queue, host->max_seg_size);
 
 	mq->queue->queuedata = mq;
 	mq->req = NULL;
diff -Nru a/drivers/mmc/mmci.c b/drivers/mmc/mmci.c
--- a/drivers/mmc/mmci.c	2004-08-30 17:49:30 +01:00
+++ b/drivers/mmc/mmci.c	2004-08-30 17:49:30 +01:00
@@ -43,10 +43,9 @@
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
 	writel(0, host->base + MMCICOMMAND);
+
 	host->mrq = NULL;
 	host->cmd = NULL;
-	host->data = NULL;
-	host->buffer = NULL;
 
 	if (mrq->data)
 		mrq->data->bytes_xfered = host->data_xfered;
@@ -60,6 +59,13 @@
 	spin_lock(&host->lock);
 }
 
+static void mmci_stop_data(struct mmci_host *host)
+{
+	writel(0, host->base + MMCIDATACTRL);
+	writel(0, host->base + MMCIMASK1);
+	host->data = NULL;
+}
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	unsigned int datactrl, timeout, irqmask;
@@ -69,7 +75,7 @@
 	    1 << data->blksz_bits, data->blocks, data->flags);
 
 	host->data = data;
-	host->buffer = data->req->buffer;
+	host->offset = 0;
 	host->size = data->blocks << data->blksz_bits;
 	host->data_xfered = 0;
 
@@ -94,6 +100,7 @@
 	}
 
 	writel(datactrl, base + MMCIDATACTRL);
+	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
 	writel(irqmask, base + MMCIMASK1);
 }
 
@@ -147,7 +154,8 @@
 		status |= MCI_DATAEND;
 	}
 	if (status & MCI_DATAEND) {
-		host->data = NULL;
+		mmci_stop_data(host);
+
 		if (!data->stop) {
 			mmci_request_end(host, data->mrq);
 		} else {
@@ -182,72 +190,171 @@
 	}
 }
 
-/*
- * PIO data transfer IRQ handler.
- */
-static irqreturn_t mmci_pio_irq(int irq, void *dev_id, struct pt_regs *regs)
+static int mmci_pio_read(struct mmci_host *host, struct request *req, u32 status)
 {
-	struct mmci_host *host = dev_id;
 	void *base = host->base;
-	u32 status;
 	int ret = 0;
 
 	do {
-		status = readl(base + MMCISTATUS);
+		unsigned long flags;
+		unsigned int bio_remain;
+		char *buffer;
 
-		if (!(status & (MCI_RXDATAAVLBL|MCI_RXFIFOHALFFULL|
-				MCI_TXFIFOHALFEMPTY)))
+		/*
+		 * Check for data available.
+		 */
+		if (!(status & MCI_RXDATAAVLBL))
 			break;
 
-		DBG(host, "irq1 %08x\n", status);
+		/*
+		 * Map the BIO buffer.
+		 */
+		buffer = bio_kmap_irq(req->cbio, &flags);
+		bio_remain = (req->current_nr_sectors << 9) - host->offset;
 
-		if (status & (MCI_RXDATAAVLBL|MCI_RXFIFOHALFFULL)) {
-			unsigned int count = host->size - (readl(base + MMCIFIFOCNT) << 2);
-			if (count < 0)
-				count = 0;
-			if (count && host->buffer) {
-				readsl(base + MMCIFIFO, host->buffer, count >> 2);
-				host->buffer += count;
+		do {
+			int count = host->size - (readl(base + MMCIFIFOCNT) << 2);
+
+			if (count > bio_remain)
+				count = bio_remain;
+
+			if (count > 0) {
+				ret = 1;
+				readsl(base + MMCIFIFO, buffer + host->offset, count >> 2);
+				host->offset += count;
 				host->size -= count;
-				if (host->size == 0)
-					host->buffer = NULL;
-			} else {
-				static int first = 1;
-				if (first) {
-					first = 0;
-					printk(KERN_ERR "MMCI: sinking excessive data\n");
-				}
-				readl(base + MMCIFIFO);
+				bio_remain -= count;
+				if (bio_remain == 0)
+					goto next_bio;
 			}
-		}
+
+			status = readl(base + MMCISTATUS);
+		} while (status & MCI_RXDATAAVLBL);
+
+		bio_kunmap_irq(buffer, &flags);
+		break;
+
+	 next_bio:
+		bio_kunmap_irq(buffer, &flags);
+
+		/*
+		 * Ok, we've completed that BIO, move on to next
+		 * BIO in the chain.  Note: this doesn't actually
+		 * complete the BIO!
+		 */
+		if (!process_that_request_first(req, req->current_nr_sectors))
+			break;
+
+		host->offset = 0;
+		status = readl(base + MMCISTATUS);
+	} while (1);
+
+	/*
+	 * If we're nearing the end of the read, switch to
+	 * "any data available" mode.
+	 */
+	if (host->size < MCI_FIFOSIZE)
+		writel(MCI_RXDATAAVLBLMASK, base + MMCIMASK1);
+
+	return ret;
+}
+
+static int mmci_pio_write(struct mmci_host *host, struct request *req, u32 status)
+{
+	void *base = host->base;
+	int ret = 0;
+
+	do {
+		unsigned long flags;
+		unsigned int bio_remain;
+		char *buffer;
 
 		/*
 		 * We only need to test the half-empty flag here - if
 		 * the FIFO is completely empty, then by definition
 		 * it is more than half empty.
 		 */
-		if (status & MCI_TXFIFOHALFEMPTY) {
-			unsigned int maxcnt = status & MCI_TXFIFOEMPTY ?
-					      MCI_FIFOSIZE : MCI_FIFOHALFSIZE;
-			unsigned int count = min(host->size, maxcnt);
+		if (!(status & MCI_TXFIFOHALFEMPTY))
+			break;
+
+		/*
+		 * Map the BIO buffer.
+		 */
+		buffer = bio_kmap_irq(req->cbio, &flags);
+		bio_remain = (req->current_nr_sectors << 9) - host->offset;
+
+		do {
+			unsigned int count, maxcnt;
 
-			writesl(base + MMCIFIFO, host->buffer, count >> 2);
+			maxcnt = status & MCI_TXFIFOEMPTY ?
+				 MCI_FIFOSIZE : MCI_FIFOHALFSIZE;
+			count = min(bio_remain, maxcnt);
 
-			host->buffer += count;
+			writesl(base + MMCIFIFO, buffer + host->offset, count >> 2);
+			host->offset += count;
 			host->size -= count;
+			bio_remain -= count;
 
-			/*
-			 * If we run out of data, disable the data IRQs;
-			 * this prevents a race where the FIFO becomes
-			 * empty before the chip itself has disabled the
-			 * data path.
-			 */
-			if (host->size == 0)
-				writel(0, base + MMCIMASK1);
-		}
+			ret = 1;
 
-		ret = 1;
-	} while (status);
+			if (bio_remain == 0)
+				goto next_bio;
+
+			status = readl(base + MMCISTATUS);
+		} while (status & MCI_TXFIFOHALFEMPTY);
+
+		bio_kunmap_irq(buffer, &flags);
+		break;
+
+	 next_bio:
+		bio_kunmap_irq(buffer, &flags);
+
+		/*
+		 * Ok, we've completed that BIO, move on to next
+		 * BIO in the chain.  Note: this doesn't actually
+		 * complete the BIO!
+		 */
+		if (!process_that_request_first(req, req->current_nr_sectors))
+			break;
+
+		host->offset = 0;
+		status = readl(base + MMCISTATUS);
+	} while (1);
+
+	return ret;
+}
+
+/*
+ * PIO data transfer IRQ handler.
+ */
+static irqreturn_t mmci_pio_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct mmci_host *host = dev_id;
+	struct request *req;
+	void *base = host->base;
+	u32 status;
+	int ret = 0;
+
+	status = readl(base + MMCISTATUS);
+
+	DBG(host, "irq1 %08x\n", status);
+
+	req = host->data->req;
+	if (status & MCI_RXACTIVE)
+		ret = mmci_pio_read(host, req, status);
+	else if (status & MCI_TXACTIVE)
+		ret = mmci_pio_write(host, req, status);
+
+	/*
+	 * If we run out of data, disable the data IRQs; this
+	 * prevents a race where the FIFO becomes empty before
+	 * the chip itself has disabled the data path, and
+	 * stops us racing with our data end IRQ.
+	 */
+	if (host->size == 0) {
+		writel(0, base + MMCIMASK1);
+		writel(readl(base + MMCIMASK0) | MCI_DATAENDMASK, base + MMCIMASK0);
+	}
 
 	return IRQ_RETVAL(ret);
 }
@@ -268,11 +375,9 @@
 		struct mmc_data *data;
 
 		status = readl(host->base + MMCISTATUS);
+		status &= readl(host->base + MMCIMASK0);
 		writel(status, host->base + MMCICLEAR);
 
-		if (!(status & MCI_IRQMASK))
-			break;
-
 		DBG(host, "irq0 %08x\n", status);
 
 		data = host->data;
@@ -426,6 +531,25 @@
 	mmc->f_min = (host->mclk + 511) / 512;
 	mmc->f_max = min(host->mclk, fmax);
 	mmc->ocr_avail = plat->ocr_mask;
+
+	/*
+	 * We can do SGIO
+	 */
+	mmc->max_hw_segs = 16;
+	mmc->max_phys_segs = 16;
+
+	/*
+	 * Since we only have a 16-bit data length register, we must
+	 * ensure that we don't exceed 2^16-1 bytes in a single request.
+	 * Choose 64 (512-byte) sectors as the limit.
+	 */
+	mmc->max_sectors = 64;
+
+	/*
+	 * Set the maximum segment size.  Since we aren't doing DMA
+	 * (yet) we are only limited by the data length register.
+	 */
+	mmc->max_seg_size = mmc->max_sectors << 9;
 
 	spin_lock_init(&host->lock);
 
diff -Nru a/drivers/mmc/mmci.h b/drivers/mmc/mmci.h
--- a/drivers/mmc/mmci.h	2004-08-30 17:49:30 +01:00
+++ b/drivers/mmc/mmci.h	2004-08-30 17:49:30 +01:00
@@ -103,18 +103,15 @@
 #define MMCIFIFOCNT		0x048
 #define MMCIFIFO		0x080 /* to 0x0bc */
 
-#define MCI_IRQMASK	\
-	(MCI_CMDCRCFAIL|MCI_DATACRCFAIL|MCI_CMDTIMEOUT|MCI_DATATIMEOUT|	\
-	MCI_TXUNDERRUN|MCI_RXOVERRUN|MCI_CMDRESPEND|MCI_CMDSENT|	\
-	MCI_DATAEND|MCI_DATABLOCKEND)
-
 #define MCI_IRQENABLE	\
 	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
-	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK|		\
-	MCI_DATABLOCKENDMASK)
+	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATABLOCKENDMASK)
 
-#define MCI_FIFOSIZE	16
+/*
+ * The size of the FIFO in bytes.
+ */
+#define MCI_FIFOSIZE	(16*4)
 	
 #define MCI_FIFOHALFSIZE (MCI_FIFOSIZE / 2)
 
@@ -141,8 +138,6 @@
 	unsigned int		oldstat;
 
 	/* pio stuff */
-	void			*buffer;
+	unsigned int		offset;
 	unsigned int		size;
 };
-
-#define to_mmci_host(mmc)	container_of(mmc, struct mmci_host, mmc)
diff -Nru a/drivers/mmc/pxamci.c b/drivers/mmc/pxamci.c
--- a/drivers/mmc/pxamci.c	2004-08-30 17:49:30 +01:00
+++ b/drivers/mmc/pxamci.c	2004-08-30 17:49:30 +01:00
@@ -530,6 +530,7 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int pxamci_suspend(struct device *dev, u32 state, u32 level)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
@@ -551,6 +552,10 @@
 
 	return ret;
 }
+#else
+#define pxamci_suspend	NULL
+#define pxamci_resume	NULL
+#endif
 
 static struct device_driver pxamci_driver = {
 	.name		= "pxa2xx-mci",
diff -Nru a/include/linux/mmc/host.h b/include/linux/mmc/host.h
--- a/include/linux/mmc/host.h	2004-08-30 17:49:30 +01:00
+++ b/include/linux/mmc/host.h	2004-08-30 17:49:30 +01:00
@@ -64,11 +64,17 @@
 struct mmc_host {
 	struct device		*dev;
 	struct mmc_host_ops	*ops;
-	void			*priv;
 	unsigned int		f_min;
 	unsigned int		f_max;
 	u32			ocr_avail;
 	char			host_name[8];
+
+	/* host specific block data */
+	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
+	unsigned short		max_hw_segs;	/* see blk_queue_max_hw_segments */
+	unsigned short		max_phys_segs;	/* see blk_queue_max_phys_segments */
+	unsigned short		max_sectors;	/* see blk_queue_max_sectors */
+	unsigned short		unused;
 
 	/* private data */
 	struct mmc_ios		ios;		/* current io bus settings */

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/30 17:43:10+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] PXAMCI: Bracket power management calls with CONFIG_PM.
# 
# drivers/mmc/pxamci.c
#   2004/08/30 17:40:45+01:00 rmk@flint.arm.linux.org.uk +5 -0
#   Bracket power management calls with CONFIG_PM.
# 
# ChangeSet
#   2004/08/30 17:33:23+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] MMCI: Ensure that we read all data from FIFO.
#   
#   When we are nearing the end of a transfer from the card, we may not
#   have sufficient data in the FIFO to trigger a "half FIFO full" IRQ.
#   Therefore, when we have less than MCI_FIFOSIZE bytes left, switch to
#   "FIFO contains data" IRQ mode instead.
# 
# drivers/mmc/mmci.c
#   2004/08/30 17:31:00+01:00 rmk@flint.arm.linux.org.uk +7 -0
#   Enable the rx data available irq mask towards then end of a receive
#   data transfer.
# 
# ChangeSet
#   2004/08/30 17:17:25+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] MMCI: Add SG support to PIO data transfers
#   
#   This allows us to transfer a whole request for multiple pages in one
#   transaction with the MMC card, resulting in higher overall throughput.
# 
# drivers/mmc/mmci.c
#   2004/08/30 17:14:26+01:00 rmk@flint.arm.linux.org.uk +66 -5
#   Add scatter-gather support to PIO data transfers, and enable the
#   feature.
# 
# ChangeSet
#   2004/08/30 17:03:48+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] MMCI: use bio_kmap_irq() rather than req->buffer
#   
#   This is in preparation for SG data IO.
# 
# drivers/mmc/mmci.c
#   2004/08/30 17:01:15+01:00 rmk@flint.arm.linux.org.uk +41 -22
#   Map BIO buffer with bio_kmap_irq() rather than using req->buffer
#   directly.
# 
# ChangeSet
#   2004/08/30 16:23:08+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] MMCI: Maintain offset rather than buffer pointer for PIO
# 
# drivers/mmc/mmci.h
#   2004/08/30 16:20:21+01:00 rmk@flint.arm.linux.org.uk +1 -1
#   *buffer becomes offset
# 
# drivers/mmc/mmci.c
#   2004/08/30 16:20:20+01:00 rmk@flint.arm.linux.org.uk +11 -9
#   Maintain a buffer offset rather than the buffer pointer for PIO
#   data transfers.
# 
# ChangeSet
#   2004/08/30 16:13:28+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] MMCI: split the PIO data read and write paths.
# 
# drivers/mmc/mmci.c
#   2004/08/30 16:11:08+01:00 rmk@flint.arm.linux.org.uk +64 -29
#   Separate the PIO data read and write paths.  We select read or write
#   depending on whether the TX or RX active status flags are set.
# 
# ChangeSet
#   2004/08/30 15:38:01+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] MMCI: Manipulate IRQ masks according to the data FSM state.
#   
#   Prevent IRQ race conditions between the two handlers and within the
#   primecell itself.  Unfortunately, the primecell does not always mask
#   the FIFO empty interrupt we reach the end of a transfer to the card.
#   Also, we may receive the "data end" interrupt prior to finishing a
#   transfer from the card, so mask this off until we've read the last
#   bytes from the FIFO.
# 
# drivers/mmc/mmci.h
#   2004/08/30 15:35:25+01:00 rmk@flint.arm.linux.org.uk +1 -2
#   Disable data end IRQ mask
# 
# drivers/mmc/mmci.c
#   2004/08/30 15:35:25+01:00 rmk@flint.arm.linux.org.uk +13 -18
#   Manipulate IRQ masks according to the data FSM state.
# 
# ChangeSet
#   2004/08/30 12:46:45+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] MMCI: data FSM handling updates
#   
#   - Use mmci_stop_host() to ensure that the data FSM is shut down and
#     any driver held data is properly released.
#   - FIFO size is 64 bytes not 16.
# 
# drivers/mmc/mmci.h
#   2004/08/30 12:44:09+01:00 rmk@flint.arm.linux.org.uk +4 -3
#   Correct MMCI fifo size.
#   Remove unused to_mmci_host macro.
# 
# drivers/mmc/mmci.c
#   2004/08/30 12:44:08+01:00 rmk@flint.arm.linux.org.uk +10 -3
#   Add mmci_stop_host() to disable MMCI data FSM.
# 
# ChangeSet
#   2004/08/30 11:12:18+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] MMCI: Remove hardcoded MCI_IRQMASK definition
# 
# drivers/mmc/mmci.h
#   2004/08/30 11:09:10+01:00 rmk@flint.arm.linux.org.uk +0 -5
#   Remove hardcoded MCI_IRQMASK definition.
# 
# drivers/mmc/mmci.c
#   2004/08/30 11:08:33+01:00 rmk@flint.arm.linux.org.uk +1 -3
#   Mask chip irq status with irq mask 0 to mask out unwanted IRQs
# 
# ChangeSet
#   2004/08/30 10:58:22+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] Give the MMC host the full-sized request.
#   
#   Pass the total number of MMC data blocks in the request to the
#   host driver.  Since existing MMC host drivers do not support
#   scatter-gather at present, the block queue defaults have been
#   chosen to prevent scatter-gather block requests for MMC.  A
#   host can alter these parameters when it wishes to take advantage
#   of SG capabilities.
# 
# drivers/mmc/mmc_block.c
#   2004/08/30 10:52:59+01:00 rmk@flint.arm.linux.org.uk +1 -1
#   Pass the total number of MMC data blocks in the request to the
#   host driver.
# 
# ChangeSet
#   2004/08/30 10:49:37+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] Add host specific block queue parameters
#   
#   Allow MMC host drivers to specify their data phase capabilities
#   to the block queue.  This will eventually allow us to perform
#   SG data phase operations, thereby processing a single request
#   in one go.
# 
# drivers/mmc/mmc_block.c
#   2004/08/30 10:43:31+01:00 rmk@flint.arm.linux.org.uk +0 -5
#   Remove 'maxsectors' parameter and associated queue setting.
#   This is a host specific parameter now.
# 
# drivers/mmc/mmc_queue.c
#   2004/08/30 10:41:24+01:00 rmk@flint.arm.linux.org.uk +7 -2
#   When creating a new block queue, set the queue parameters
#   from the host specific data.
# 
# drivers/mmc/mmc.c
#   2004/08/30 10:40:28+01:00 rmk@flint.arm.linux.org.uk +11 -1
#   Add host specific block queue default settings
# 
# include/linux/mmc/host.h
#   2004/08/30 10:40:06+01:00 rmk@flint.arm.linux.org.uk +7 -0
#   Add host specific block queue data
# 
# ChangeSet
#   2004/08/30 10:30:55+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] Remove unused host->priv
# 
# include/linux/mmc/host.h
#   2004/08/30 10:22:39+01:00 rmk@flint.arm.linux.org.uk +0 -1
#   Remove unused host->priv
# 
# drivers/mmc/mmc.c
#   2004/08/30 10:22:22+01:00 rmk@flint.arm.linux.org.uk +0 -2
#   Remove unused host->priv
# 
# ChangeSet
#   2004/08/30 10:20:35+01:00 rmk@flint.arm.linux.org.uk 
#   [MMC] Use local card pointer rather than md->queue.card
# 
# drivers/mmc/mmc_block.c
#   2004/08/30 10:16:45+01:00 rmk@flint.arm.linux.org.uk +3 -3
#   No point using md->queue.card when we already have a
#   pointer to the card itself.
# 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
