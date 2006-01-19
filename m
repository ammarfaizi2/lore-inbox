Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWASKv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWASKv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbWASKv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:51:28 -0500
Received: from webapps.arcom.com ([194.200.159.168]:37132 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1161225AbWASKv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:51:27 -0500
Message-ID: <43CF6F25.9070704@arcom.com>
Date: Thu, 19 Jan 2006 10:51:17 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Street <stephen@streetfiresound.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PXA2xx SPI controller updated for 2.6.16-rc1?
Content-Type: multipart/mixed;
 boundary="------------060204030205060407000908"
X-OriginalArrivalTime: 19 Jan 2006 10:55:28.0062 (UTC) FILETIME=[DBB2C5E0:01C61CE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060204030205060407000908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Stephen,

Do you have a version of the PXA2xx SPI contoller driver more recent
that the one posted at the end of October 2005?  There are some SPI (and
other) API changes required for 2.6.16-rc1.

I've attached my attempt (PIO works but DMA doesn't) if it's of any use.

The patch also:
  - includes support for the different clock on the PXA27x
  - calculates the correct clock divisor (at least on the PXA27x...)
  - allows null_cs_control for PIO transfer.

I'm currently using SSP3 on the PXA27x with the slave chip select GPIO
line configured as SSPSFRM3 instead of a GPIO.  This works fine provided
that each spi_message consists of a single spi_transfer.  With more than
 one transfer they're not back-to-back and SSPSFRM3 is deasserted
between transfers.

It looks like you're waiting for the transmit buffer in the controller
to empty before switching to the next transfer.  Is it possible to
switch to the next transfer immediatly upon exhausting the transfer's
tx_buf?  Perhaps (in the DMA case) by chaining several DMA descriptors
together?

At the higher SPI clock rates available on the PXA27x (up to 13 MHz with
the internal clock) PIO mode doesn't seem to feed the transmit buffer
fast enough resulting in gaps between each byte/word of the transfer.  I
would assume using DMA would not show this?

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------060204030205060407000908
Content-Type: text/plain;
 name="drivers-spi-pxa2xx-ssp-fixes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers-spi-pxa2xx-ssp-fixes"

Index: linux-2.6-working/drivers/spi/pxa2xx_spi_ssp.c
===================================================================
--- linux-2.6-working.orig/drivers/spi/pxa2xx_spi_ssp.c	2006-01-18 17:42:26.000000000 +0000
+++ linux-2.6-working/drivers/spi/pxa2xx_spi_ssp.c	2006-01-18 17:42:27.000000000 +0000
@@ -107,8 +107,8 @@
  
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/device.h>
-#include <linux/spi.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
 #include <linux/ioport.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
@@ -128,7 +128,11 @@
 MODULE_DESCRIPTION("PXA2xx SSP SPI Contoller");
 MODULE_LICENSE("GPL");
 
-#define MAX_SPEED_HZ 3686400
+#if defined(CONFIG_PXA25x)
+#  define MAX_SPEED_HZ  3686400
+#elif defined(CONFIG_PXA27x)
+#  define MAX_SPEED_HZ 13000000
+#endif
 #define MAX_BUSES 3
 
 #define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
@@ -140,7 +144,8 @@
 struct master_data;
 
 struct transfer_state {
-	int index;
+	enum { TRANSFER_START, TRANSFER, TRANSFER_END, TRANSFER_ABORT } state;
+	struct spi_transfer *transfer;
 	int len;
 	void *tx;
 	void *tx_end;
@@ -253,8 +258,9 @@
 
 static inline void dump_message(struct spi_message *msg)
 {
-	int i;
-	struct device *dev = &msg->dev->dev;
+	int i = 0;
+	struct device *dev = &msg->spi->dev;
+	struct spi_transfer *t;
 	
 	dev_dbg(dev, "message = %p\n", msg);
 	dev_dbg(dev, "    complete = %p\n", msg->complete);
@@ -262,23 +268,23 @@
 	dev_dbg(dev, "    actual_length = %u\n", msg->actual_length);
 	dev_dbg(dev, "    status = %d\n", msg->status);
 	dev_dbg(dev, "    state = %p\n", msg->state);
-	dev_dbg(dev, "    n_transfers = %u\n", msg->n_transfer);
-		
-	for (i = 0; i < msg->n_transfer; i++) {
+
+	list_for_each_entry (t, &msg->transfers, transfer_list) {
 		dev_dbg(dev, "        %d, tx_buf = %p\n", 
-				i, msg->transfers[i].tx_buf);
+				i, t->tx_buf);
 		dev_dbg(dev, "        %d, rx_buf = %p\n", 
-				i, msg->transfers[i].rx_buf);
+				i, t->rx_buf);
 		dev_dbg(dev, "        %d, tx_dma = %p\n", 
-				i, (void *)msg->transfers[i].tx_dma);
+				i, (void *)t->tx_dma);
 		dev_dbg(dev, "        %d, rx_dma = %p\n", 
-				i, (void *)msg->transfers[i].rx_dma);
+				i, (void *)t->rx_dma);
 		dev_dbg(dev, "        %d, len = %u\n", 
-				i, msg->transfers[i].len);
+				i, t->len);
 		dev_dbg(dev, "        %d, cs_change = %u\n", 
-				i, msg->transfers[i].cs_change);
+				i, t->cs_change);
 		dev_dbg(dev, "        %d, delay_usecs = %u\n", 
-				i, msg->transfers[i].delay_usecs);
+				i, t->delay_usecs);
+		i++;
 	}
 }
 
@@ -373,7 +379,7 @@
 					channel);
 		
 		drv_data->buserr_cnt++;
-		drv_data->cur_state.index = -2;
+		drv_data->cur_state.state = TRANSFER_ABORT;
 		tasklet_schedule(&drv_data->pump_transfers);
 	}
 	
@@ -414,7 +420,7 @@
 
 		drv_data->ror_cnt++;
 
-		state->index = -2;
+		state->state = TRANSFER_ABORT;
 		tasklet_schedule(&drv_data->pump_transfers);
 
 		return IRQ_HANDLED;
@@ -438,13 +444,13 @@
 				|| (__REG(sssr) & SSSR_BSY));
 		
 		/* Handle trailing byte, must unmap the dma buffers */		
-		dma_unmap_single(&msg->dev->dev, 
-					msg->transfers[state->index].tx_dma, 
-					msg->transfers[state->index].len, 
+		dma_unmap_single(&msg->spi->dev,
+					state->transfer->tx_dma,
+					state->transfer->len,
 					DMA_TO_DEVICE);
-		dma_unmap_single(&msg->dev->dev, 
-					msg->transfers[state->index].rx_dma, 
-					msg->transfers[state->index].len, 
+		dma_unmap_single(&msg->spi->dev,
+					state->transfer->rx_dma,
+					state->transfer->len,
 					DMA_FROM_DEVICE);
 		
 		/* Calculate number of trailing bytes */
@@ -455,12 +461,16 @@
 			state->read(sssr, ssdr, state);
 		}
 
-		if (msg->transfers[state->index].cs_change)
+		if (state->transfer->cs_change)
 			state->cs_control(PXA2XX_CS_DEASSERT);
 		
 		/* Schedule transfer tasklet */
-		msg->actual_length += msg->transfers[state->index].len;
-		++state->index;
+		msg->actual_length += state->transfer->len;
+		if (state->transfer->transfer_list.next == &msg->transfers)
+			state->state = TRANSFER_END;
+		else
+			state->transfer = list_entry(state->transfer->transfer_list.next,
+						     struct spi_transfer, transfer_list);
 		tasklet_schedule(&drv_data->pump_transfers);
 		
 		return IRQ_HANDLED;
@@ -491,13 +501,12 @@
 			flush(drv_data);
 			
 			printk(KERN_WARNING "interrupt_transfer: fifo overun, "
-					"index=%d tx_len=%d rx_len=%d\n", 
-					state->index, 
+					"tx_len=%d rx_len=%d\n", 
 					(state->tx_end - state->tx), 
 					(state->rx_end - state->rx)); 
 
 			drv_data->ror_cnt++;
-			state->index = -2;
+			state->state = TRANSFER_ABORT;
 			tasklet_schedule(&drv_data->pump_transfers);
 
 			return IRQ_HANDLED;
@@ -523,13 +532,17 @@
 			__REG(sssr) = SSSR_TINT | SSSR_ROR ;
 			__REG(sscr1) &= ~(SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE);
 			
-			msg->actual_length += msg->transfers[state->index].len;
+			msg->actual_length += state->transfer->len;
 	
-			if (msg->transfers[state->index].cs_change)
+			if (state->transfer->cs_change)
 				state->cs_control(PXA2XX_CS_DEASSERT);
 
 			/* Schedule transfer tasklet */
-			++state->index;
+			if (state->transfer->transfer_list.next == &msg->transfers)
+				state->state = TRANSFER_END;
+			else
+				state->transfer = list_entry(state->transfer->transfer_list.next,
+							     struct spi_transfer, transfer_list);
 			tasklet_schedule(&drv_data->pump_transfers);
 			
 			return IRQ_HANDLED;
@@ -587,7 +600,7 @@
 		return;
 	}
 	
-	chip = spi_get_ctldata(message->dev);
+	chip = spi_get_ctldata(message->spi);
 	if (!chip) {
 		printk(KERN_ERR "pxs2xx_spi_ssp: bad chip data\n");
 		drv_data->cur_msg = NULL;
@@ -596,7 +609,7 @@
 	}
 		
 	/* Handle for abort */
-	if (state->index == -2) {
+	if (state->state == TRANSFER_ABORT) {
 		message->status = -EIO;
 		if (message->complete) {
 			message->complete(message->context);
@@ -607,8 +620,8 @@
 	}
 
 	/* Handle end of message */
-	if (state->index == message->n_transfer) {
-		if (!message->transfers[state->index].cs_change)
+	if (state->state == TRANSFER_END) {
+		if (state->transfer->cs_change)
 			state->cs_control(PXA2XX_CS_DEASSERT);
 
 		message->status = 0;
@@ -620,15 +633,14 @@
 	}
 	
 	/* Handle start of message */
-	if (state->index == -1) {
+	if (state->state == TRANSFER_START) {
 		restore_state(drv_data, chip);
 		flush(drv_data);
-		++state->index;
-	}
-	
-	/* Delay if requested at end of transfer*/
-	if (state->index > 1) {
-		transfer = message->transfers + (state->index - 1);
+		state->transfer = list_entry(message->transfers.next, struct spi_transfer, transfer_list);
+	} else {
+		/* Delay if requested at end of transfer*/
+		transfer = list_entry(state->transfer->transfer_list.prev,
+				      struct spi_transfer, transfer_list);
 		if (transfer->delay_usecs)
 			udelay(transfer->delay_usecs);
 	}
@@ -636,7 +648,7 @@
 	/* Setup the transfer state based on the type of transfer */	
 	flush(drv_data);
 	drv_data->trans_cnt++;
-	transfer = message->transfers + state->index;
+	transfer = state->transfer;
 	state->cs_control = !chip->cs_control ? 
 				null_cs_control : chip->cs_control;
 	state->tx = (void *)transfer->tx_buf;
@@ -666,7 +678,7 @@
 		
 		/* Disable cache on rx buffer */
 		transfer->rx_dma = 
-			dma_map_single(&message->dev->dev, 
+			dma_map_single(&message->spi->dev, 
 					state->rx, 
 					rx_map_len, 
 					DMA_FROM_DEVICE);
@@ -695,7 +707,7 @@
 		
 		/* Disable cache on tx buffer */
 		transfer->tx_dma = 
-			dma_map_single(&message->dev->dev, 
+			dma_map_single(&message->spi->dev, 
 					state->tx, 
 					tx_map_len, 
 					DMA_TO_DEVICE);
@@ -791,7 +803,7 @@
 		return;
 	}
 	
-	chip = spi_get_ctldata(message->dev);
+	chip = spi_get_ctldata(message->spi);
 	if (!chip) {
 		printk(KERN_ERR "pxs2xx_spi_ssp: bad chip data\n");
 		drv_data->cur_msg = NULL;
@@ -800,7 +812,7 @@
 	}
 		
 	/* Handle for abort */
-	if (state->index == -2) {
+	if (state->state == TRANSFER_ABORT) {
 		message->status = -EIO;
 		if (message->complete) {
 			message->complete(message->context);
@@ -811,9 +823,9 @@
 	}
 
 	/* Handle end of message */
-	if (state->index == message->n_transfer) {
-		if (!message->transfers[state->index].cs_change)
-		state->cs_control(PXA2XX_CS_DEASSERT);
+	if (state->state == TRANSFER_END) {
+		if (state->transfer->cs_change)
+			state->cs_control(PXA2XX_CS_DEASSERT);
 
 		message->status = 0;
 		if (message->complete)
@@ -824,15 +836,15 @@
 	}
 	
 	/* Handle start of message */
-	if (state->index == -1) {
+	if (state->state == TRANSFER_START) {
 		restore_state(drv_data, chip);
 		flush(drv_data);
-		++state->index;
-	}
-	
-	/* Delay if requested at end of transfer*/
-	if (state->index > 1) {
-		transfer = message->transfers + (state->index - 1);
+		state->transfer = list_entry(message->transfers.next,
+					     struct spi_transfer, transfer_list);
+	} else {
+		/* Delay if requested at end of transfer*/
+		transfer = list_entry(state->transfer->transfer_list.prev,
+				      struct spi_transfer, transfer_list);
 		if (transfer->delay_usecs)
 			udelay(transfer->delay_usecs);
 	}
@@ -840,8 +852,9 @@
 	/* Setup the transfer state based on the type of transfer */	
 	flush(drv_data);
 	drv_data->trans_cnt++;
-	transfer = message->transfers + state->index;
-	state->cs_control = chip->cs_control;
+	transfer = state->transfer;
+	state->cs_control = chip->cs_control ? 
+		chip->cs_control : null_cs_control;
 	state->tx = (void *)transfer->tx_buf;
 	state->tx_end = state->tx + (transfer->len * chip->n_bytes);
 	state->rx = transfer->rx_buf;
@@ -892,7 +905,7 @@
 	
 	/* Setup message transfer and schedule transfer pump */
 	drv_data->cur_msg->state = &drv_data->cur_state;
-	drv_data->cur_state.index = -1;
+	drv_data->cur_state.state = TRANSFER_START;
 	drv_data->cur_state.len = 0;
 	tasklet_schedule(&drv_data->pump_transfers);
 			
@@ -921,7 +934,7 @@
 	struct pxa2xx_spi_chip *chip_info;
 	struct chip_data *chip;
 	
-	chip_info = (struct pxa2xx_spi_chip *)spi->platform_data;
+	chip_info = (struct pxa2xx_spi_chip *)spi->controller_data;
 	
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
@@ -935,7 +948,7 @@
 	}
 	
 	chip->cs_control = chip_info->cs_control;
-	chip->cr0 = SSCR0_SerClkDiv((MAX_SPEED_HZ / spi->max_speed_hz) + 2) 
+	chip->cr0 = SSCR0_SerClkDiv((MAX_SPEED_HZ / (spi->max_speed_hz + 1)) + 1)
 			| SSCR0_Motorola 
 			| SSCR0_DataSize(spi->bits_per_word) 
 			| SSCR0_SSE
@@ -1003,7 +1016,7 @@
 				spi->master->bus_num, spi->chip_select);
 }
 
-static ssize_t trans_cnt_show(struct device *dev, char *buf)
+static ssize_t trans_cnt_show(struct device *dev, struct device_attribute *attr, char *buf)
 {	
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct master_data *drv_data = class_get_devdata(&master->cdev);
@@ -1012,7 +1025,7 @@
 }
 DEVICE_ATTR(transfer_count, 0444, trans_cnt_show, NULL);
 
-static ssize_t dma_trans_cnt_show(struct device *dev, char *buf)
+static ssize_t dma_trans_cnt_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct master_data *drv_data = class_get_devdata(&master->cdev);
@@ -1021,7 +1034,7 @@
 }
 DEVICE_ATTR(dma_transfer_count, 0444, dma_trans_cnt_show, NULL);
 
-static ssize_t int_trans_cnt_show(struct device *dev, char *buf)
+static ssize_t int_trans_cnt_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct master_data *drv_data = class_get_devdata(&master->cdev);
@@ -1030,7 +1043,7 @@
 }
 DEVICE_ATTR(interrupt_transfer_count, 0444, int_trans_cnt_show, NULL);
 
-static ssize_t bigunalign_cnt_show(struct device *dev, char *buf)
+static ssize_t bigunalign_cnt_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct master_data *drv_data = class_get_devdata(&master->cdev);
@@ -1039,7 +1052,7 @@
 }
 DEVICE_ATTR(big_unaligned_count, 0444, bigunalign_cnt_show, NULL);
 
-static ssize_t buserr_cnt_show(struct device *dev, char *buf)
+static ssize_t buserr_cnt_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct master_data *drv_data = class_get_devdata(&master->cdev);
@@ -1048,7 +1061,7 @@
 }
 DEVICE_ATTR(bus_error_count, 0444, buserr_cnt_show, NULL);
 
-static ssize_t ror_cnt_show(struct device *dev, char *buf)
+static ssize_t ror_cnt_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct master_data *drv_data = class_get_devdata(&master->cdev);

--------------060204030205060407000908--
