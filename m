Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVASKln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVASKln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 05:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVASKln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 05:41:43 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:41168 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261684AbVASKlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 05:41:07 -0500
Message-ID: <41EE393F.3090705@drzeus.cx>
Date: Wed, 19 Jan 2005 11:41:03 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-28369-1106131341-0001-2"
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] wbsd update
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-28369-1106131341-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch includes the latest changes to the wbsd driver.

Changelog:

* Proper usage of kunmap.
* Comment about hw bugs.
* Waits for data transfers to finish properly.
* Added module version info.
* FIFO bug fix for small reads.
* Optimised FIFO loop.
* DMA demand mode.
* IRQ race condition when sending commands fixed.

/Pierre

--=_hades.drzeus.cx-28369-1106131341-0001-2
Content-Type: text/x-patch; name="wbsd-2.6.10-5.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-2.6.10-5.patch"

Index: linux/drivers/mmc/wbsd.c
===================================================================
--- linux/drivers/mmc/wbsd.c	(revision 105)
+++ linux/drivers/mmc/wbsd.c	(working copy)
@@ -1,11 +1,24 @@
 /*
- *  linux/drivers/mmc/wbsd.c
+ *  linux/drivers/mmc/wbsd.c - Winbond W83L51xD SD/MMC driver
  *
- *  Copyright (C) 2004 Pierre Ossman, All Rights Reserved.
+ *  Copyright (C) 2004-2005 Pierre Ossman, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ *
+ * Warning!
+ *
+ * Changes to the FIFO system should be done with extreme care since
+ * the hardware is full of bugs related to the FIFO. Known issues are:
+ *
+ * - FIFO size field in FSR is always zero.
+ *
+ * - FIFO interrupts tend not to work as they should. Interrupts are
+ *   triggered only for full/empty events, not for threshold values.
+ *
+ * - On APIC systems the FIFO empty interrupt is sometimes lost.
  */
 
 #include <linux/config.h>
@@ -27,7 +40,7 @@
 #include "wbsd.h"
 
 #define DRIVER_NAME "wbsd"
-#define DRIVER_VERSION "1.0"
+#define DRIVER_VERSION "1.1"
 
 #ifdef CONFIG_MMC_DEBUG
 #define DBG(x...) \
@@ -239,13 +252,14 @@
 
 static inline char* wbsd_kmap_sg(struct wbsd_host* host)
 {
-	return kmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ) +
+	host->mapped_sg = kmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ) +
 		host->cur_sg->offset;
+	return host->mapped_sg;
 }
 
 static inline void wbsd_kunmap_sg(struct wbsd_host* host)
 {
-	kunmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ);
+	kunmap_atomic(host->mapped_sg, KM_BIO_SRC_IRQ);
 }
 
 static inline void wbsd_sg_to_dma(struct wbsd_host* host, struct mmc_data* data)
@@ -272,7 +286,7 @@
 			memcpy(dmabuf, sgbuf, size);
 		else
 			memcpy(dmabuf, sgbuf, sg[i].length);
-		kunmap_atomic(sg[i].page, KM_BIO_SRC_IRQ);
+		kunmap_atomic(sgbuf, KM_BIO_SRC_IRQ);
 		dmabuf += sg[i].length;
 		
 		if (size < sg[i].length)
@@ -318,7 +332,7 @@
 			memcpy(sgbuf, dmabuf, size);
 		else
 			memcpy(sgbuf, dmabuf, sg[i].length);
-		kunmap_atomic(sg[i].page, KM_BIO_SRC_IRQ);
+		kunmap_atomic(sgbuf, KM_BIO_SRC_IRQ);
 		dmabuf += sg[i].length;
 		
 		if (size < sg[i].length)
@@ -400,16 +414,16 @@
 static void wbsd_send_command(struct wbsd_host* host, struct mmc_command* cmd)
 {
 	int i;
-	u8 status, eir, isr;
+	u8 status, isr;
 	
 	DBGF("Sending cmd (%x)\n", cmd->opcode);
 
 	/*
-	 * Disable interrupts as the interrupt routine
-	 * will destroy the contents of ISR.
+	 * Clear accumulated ISR. The interrupt routine
+	 * will fill this one with events that occur during
+	 * transfer.
 	 */
-	eir = inb(host->base + WBSD_EIR);
-	outb(0, host->base + WBSD_EIR);
+	host->isr = 0;
 	
 	/*
 	 * Send the command (CRC calculated by host).
@@ -435,7 +449,7 @@
 		/*
 		 * Read back status.
 		 */
-		isr = inb(host->base + WBSD_ISR);
+		isr = host->isr;
 		
 		/* Card removed? */
 		if (isr & WBSD_INT_CARD)
@@ -456,17 +470,6 @@
 		}
 	}
 
-	/*
-	 * Restore interrupt mask to previous value.
-	 */
-	outb(eir, host->base + WBSD_EIR);
-	
-	/*
-	 * Call the interrupt routine to jump start
-	 * interrupts.
-	 */
-	wbsd_irq(0, host, NULL);
-
 	DBGF("Sent cmd (%x), res %d\n", cmd->opcode, cmd->error);
 }
 
@@ -478,6 +481,7 @@
 {
 	struct mmc_data* data = host->mrq->cmd->data;
 	char* buffer;
+	int i, fsr, fifo;
 	
 	/*
 	 * Handle excessive data.
@@ -491,60 +495,83 @@
 	 * Drain the fifo. This has a tendency to loop longer
 	 * than the FIFO length (usually one block).
 	 */
-	while (!(inb(host->base + WBSD_FSR) & WBSD_FIFO_EMPTY))
+	while (!((fsr = inb(host->base + WBSD_FSR)) & WBSD_FIFO_EMPTY))
 	{
-		*buffer = inb(host->base + WBSD_DFR);
-		buffer++;
-		host->offset++;
-		host->remain--;
-
-		data->bytes_xfered++;
-		
 		/*
-		 * Transfer done?
-		 */
-		if (data->bytes_xfered == host->size)
-		{
-			wbsd_kunmap_sg(host);				
-			return;
-		}
+		 * The size field in the FSR is broken so we have to
+		 * do some guessing.
+		 */		
+		if (fsr & WBSD_FIFO_FULL)
+			fifo = 16;
+		else if (fsr & WBSD_FIFO_FUTHRE)
+			fifo = 8;
+		else
+			fifo = 1;
 		
-		/*
-		 * End of scatter list entry?
-		 */
-		if (host->remain == 0)
+		for (i = 0;i < fifo;i++)
 		{
-			wbsd_kunmap_sg(host);
+			*buffer = inb(host->base + WBSD_DFR);
+			buffer++;
+			host->offset++;
+			host->remain--;
+
+			data->bytes_xfered++;
 			
 			/*
-			 * Get next entry. Check if last.
+			 * Transfer done?
 			 */
-			if (!wbsd_next_sg(host))
+			if (data->bytes_xfered == host->size)
 			{
+				wbsd_kunmap_sg(host);				
+				return;
+			}
+			
+			/*
+			 * End of scatter list entry?
+			 */
+			if (host->remain == 0)
+			{
+				wbsd_kunmap_sg(host);
+				
 				/*
-				 * We should never reach this point.
-				 * It means that we're trying to
-				 * transfer more blocks than can fit
-				 * into the scatter list.
+				 * Get next entry. Check if last.
 				 */
-				BUG_ON(1);
+				if (!wbsd_next_sg(host))
+				{
+					/*
+					 * We should never reach this point.
+					 * It means that we're trying to
+					 * transfer more blocks than can fit
+					 * into the scatter list.
+					 */
+					BUG_ON(1);
+					
+					host->size = data->bytes_xfered;
+					
+					return;
+				}
 				
-				host->size = data->bytes_xfered;
-				
-				return;
+				buffer = wbsd_kmap_sg(host);
 			}
-			
-			buffer = wbsd_kmap_sg(host);
 		}
 	}
 	
 	wbsd_kunmap_sg(host);
+
+	/*
+	 * This is a very dirty hack to solve a
+	 * hardware problem. The chip doesn't trigger
+	 * FIFO threshold interrupts properly.
+	 */
+	if ((host->size - data->bytes_xfered) < 16)
+		tasklet_schedule(&host->fifo_tasklet);
 }
 
 static void wbsd_fill_fifo(struct wbsd_host* host)
 {
 	struct mmc_data* data = host->mrq->cmd->data;
 	char* buffer;
+	int i, fsr, fifo;
 	
 	/*
 	 * Check that we aren't being called after the
@@ -559,50 +586,64 @@
 	 * Fill the fifo. This has a tendency to loop longer
 	 * than the FIFO length (usually one block).
 	 */
-	while (!(inb(host->base + WBSD_FSR) & WBSD_FIFO_FULL))
+	while (!((fsr = inb(host->base + WBSD_FSR)) & WBSD_FIFO_FULL))
 	{
-		outb(*buffer, host->base + WBSD_DFR);
-		buffer++;
-		host->offset++;
-		host->remain--;
-		
-		data->bytes_xfered++;
-		
 		/*
-		 * Transfer done?
-		 */
-		if (data->bytes_xfered == host->size)
-		{
-			wbsd_kunmap_sg(host);
-			return;
-		}
+		 * The size field in the FSR is broken so we have to
+		 * do some guessing.
+		 */		
+		if (fsr & WBSD_FIFO_EMPTY)
+			fifo = 0;
+		else if (fsr & WBSD_FIFO_EMTHRE)
+			fifo = 8;
+		else
+			fifo = 15;
 
-		/*
-		 * End of scatter list entry?
-		 */
-		if (host->remain == 0)
+		for (i = 16;i > fifo;i--)
 		{
-			wbsd_kunmap_sg(host);
+			outb(*buffer, host->base + WBSD_DFR);
+			buffer++;
+			host->offset++;
+			host->remain--;
 			
+			data->bytes_xfered++;
+			
 			/*
-			 * Get next entry. Check if last.
+			 * Transfer done?
 			 */
-			if (!wbsd_next_sg(host))
+			if (data->bytes_xfered == host->size)
 			{
+				wbsd_kunmap_sg(host);
+				return;
+			}
+
+			/*
+			 * End of scatter list entry?
+			 */
+			if (host->remain == 0)
+			{
+				wbsd_kunmap_sg(host);
+				
 				/*
-				 * We should never reach this point.
-				 * It means that we're trying to
-				 * transfer more blocks than can fit
-				 * into the scatter list.
+				 * Get next entry. Check if last.
 				 */
-				BUG_ON(1);
+				if (!wbsd_next_sg(host))
+				{
+					/*
+					 * We should never reach this point.
+					 * It means that we're trying to
+					 * transfer more blocks than can fit
+					 * into the scatter list.
+					 */
+					BUG_ON(1);
+					
+					host->size = data->bytes_xfered;
+					
+					return;
+				}
 				
-				host->size = data->bytes_xfered;
-				
-				return;
+				buffer = wbsd_kmap_sg(host);
 			}
-			
-			buffer = wbsd_kmap_sg(host);
 		}
 	}
 	
@@ -689,9 +730,9 @@
 		disable_dma(host->dma);
 		clear_dma_ff(host->dma);
 		if (data->flags & MMC_DATA_READ)
-			set_dma_mode(host->dma, DMA_MODE_READ);
+			set_dma_mode(host->dma, DMA_MODE_READ & ~0x40);
 		else
-			set_dma_mode(host->dma, DMA_MODE_WRITE);
+			set_dma_mode(host->dma, DMA_MODE_WRITE & ~0x40);
 		set_dma_addr(host->dma, host->dma_addr);
 		set_dma_count(host->dma, host->size);
 
@@ -701,8 +742,7 @@
 		/*
 		 * Enable DMA on the host.
 		 */
-		wbsd_write_index(host, WBSD_IDX_DMA,
-			WBSD_DMA_SINGLE | WBSD_DMA_ENABLE);
+		wbsd_write_index(host, WBSD_IDX_DMA, WBSD_DMA_ENABLE);
 	}
 	else
 	{
@@ -746,6 +786,7 @@
 {
 	unsigned long dmaflags;
 	int count;
+	u8 status;
 	
 	WARN_ON(host->mrq == NULL);
 
@@ -754,6 +795,15 @@
 	 */
 	if (data->stop)
 		wbsd_send_command(host, data->stop);
+
+	/*
+	 * Wait for the controller to leave data
+	 * transfer state.
+	 */
+	do
+	{
+		status = wbsd_read_index(host, WBSD_IDX_STATUS);
+	} while (status & (WBSD_BLOCK_READ | WBSD_BLOCK_WRITE));
 	
 	/*
 	 * DMA transfer?
@@ -851,7 +901,13 @@
 	 * transfered.
 	 */	
 	if (cmd->data && (cmd->error == MMC_ERR_NONE))
-	{		
+	{
+		/*
+		 * Dirty fix for hardware bug.
+		 */
+		if (host->dma == -1)
+			tasklet_schedule(&host->fifo_tasklet);
+
 		spin_unlock_bh(&host->lock);
 
 		return;
@@ -1021,7 +1077,6 @@
 	
 	spin_lock(&host->lock);
 	
-	WARN_ON(!host->mrq);
 	if (!host->mrq)
 		goto end;
 	
@@ -1046,7 +1101,6 @@
 	
 	spin_lock(&host->lock);
 	
-	WARN_ON(!host->mrq);
 	if (!host->mrq)
 		goto end;
 	
@@ -1126,6 +1180,8 @@
 	 */
 	if (isr == 0xff || isr == 0x00)
 		return IRQ_NONE;
+	
+	host->isr |= isr;
 
 	/*
 	 * Schedule tasklets as needed.
@@ -1133,7 +1189,7 @@
 	if (isr & WBSD_INT_CARD)
 		tasklet_schedule(&host->card_tasklet);
 	if (isr & WBSD_INT_FIFO_THRE)
-		tasklet_hi_schedule(&host->fifo_tasklet);
+		tasklet_schedule(&host->fifo_tasklet);
 	if (isr & WBSD_INT_CRC)
 		tasklet_hi_schedule(&host->crc_tasklet);
 	if (isr & WBSD_INT_TIMEOUT)
@@ -1392,8 +1448,8 @@
 	 * Maximum number of segments. Worst case is one sector per segment
 	 * so this will be 64kB/512.
 	 */
-	mmc->max_hw_segs = NR_SG;
-	mmc->max_phys_segs = NR_SG;
+	mmc->max_hw_segs = 128;
+	mmc->max_phys_segs = 128;
 	
 	/*
 	 * Maximum number of sectors in one transfer. Also limited by 64kB
@@ -1590,6 +1646,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Winbond W83L51xD SD/MMC card interface driver");
+MODULE_VERSION(DRIVER_VERSION);
 
 MODULE_PARM_DESC(io, "I/O base to allocate. Must be 8 byte aligned. (default 0x248)");
 MODULE_PARM_DESC(irq, "IRQ to allocate. (default 6)");
Index: linux/drivers/mmc/wbsd.h
===================================================================
--- linux/drivers/mmc/wbsd.h	(revision 105)
+++ linux/drivers/mmc/wbsd.h	(working copy)
@@ -1,7 +1,7 @@
 /*
- *  linux/drivers/mmc/wbsd.h
+ *  linux/drivers/mmc/wbsd.h - Winbond W83L51xD SD/MMC driver
  *
- *  Copyright (C) 2004 Pierre Ossman, All Rights Reserved.
+ *  Copyright (C) 2004-2005 Pierre Ossman, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -119,6 +119,8 @@
 #define WBSD_FIFOEN_FULL	0x10
 #define WBSD_FIFO_THREMASK	0x0F
 
+#define WBSD_BLOCK_READ		0x80
+#define WBSD_BLOCK_WRITE	0x40
 #define WBSD_BUSY		0x20
 #define WBSD_CARDTRAFFIC	0x04
 #define WBSD_SENDCMD		0x02
@@ -132,9 +134,6 @@
 #define WBSD_CRC_FAIL		0x0B /* S101E (01011) */
 
 
-/* 64kB / 512 */
-#define NR_SG			128
-
 struct wbsd_host
 {
 	struct mmc_host*	mmc;		/* MMC structure */
@@ -143,9 +142,11 @@
 
 	struct mmc_request*	mrq;		/* Current request */
 	
-	struct scatterlist	sg[NR_SG];	/* SG list */
+	u8			isr;		/* Accumulated ISR */
+	
 	struct scatterlist*	cur_sg;		/* Current SG entry */
 	unsigned int		num_sg;		/* Number of entries left */
+	void*			mapped_sg;	/* vaddr of mapped sg */
 	
 	unsigned int		offset;		/* Offset into current entry */
 	unsigned int		remain;		/* Data left in curren entry */

--=_hades.drzeus.cx-28369-1106131341-0001-2--
