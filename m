Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWCHXhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWCHXhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWCHXhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:37:00 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:13479 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1751511AbWCHXg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:36:59 -0500
Date: Wed, 08 Mar 2006 15:36:49 -0800
From: stephen@streetfiresound.com
To: linux-kernel@vger.kernel.org
Cc: HBE@delta.dk, akpm@osdl.org, david-b@pacbell.net,
       spi-devel-general@lists.sourceforge.net, stephen@streetfiresound.com
Subject: [PATCH] spi: Update to PXA2xx SPI Driver
Message-ID: <440f6a91.21zyCJD6GXGnPC2e%stephen@streetfiresound.com>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two outstanding issues with the pxa2xx_spi driver:

1) Bad cast in the function u32_writer. Thanks to Henrik Bechmann
2) Adds support for per transfer changes to speed and bits per word
 
Signed-off-by: Stephen Street <stephen@streetfiresound.com>
---
 pxa2xx_spi.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 75 insertions(+), 7 deletions(-)

--- linux-2.6.16-rc5-mm3/drivers/spi/pxa2xx_spi.c	2006-03-08 15:12:19.470303626 -0800
+++ linux-spi/drivers/spi/pxa2xx_spi.c	2006-03-08 15:12:25.732211119 -0800
@@ -120,6 +120,8 @@ struct driver_data {
 	dma_addr_t tx_dma;
 	size_t rx_map_len;
 	size_t tx_map_len;
+	u8 n_bytes;
+	u32 dma_width;
 	int cs_change;
 	void (*write)(struct driver_data *drv_data);
 	void (*read)(struct driver_data *drv_data);
@@ -139,6 +141,8 @@ struct chip_data {
 	u32 threshold;
 	u32 dma_threshold;
 	u8 enable_dma;
+	u8 bits_per_word;
+	u32 speed_hz;
 	void (*write)(struct driver_data *drv_data);
 	void (*read)(struct driver_data *drv_data);
 	void (*cs_control)(u32 command);
@@ -186,7 +190,7 @@ static void null_cs_control(u32 command)
 static void null_writer(struct driver_data *drv_data)
 {
 	void *reg = drv_data->ioaddr;
-	u8 n_bytes = drv_data->cur_chip->n_bytes;
+	u8 n_bytes = drv_data->n_bytes;
 
 	while ((read_SSSR(reg) & SSSR_TNF)
 			&& (drv_data->tx < drv_data->tx_end)) {
@@ -198,7 +202,7 @@ static void null_writer(struct driver_da
 static void null_reader(struct driver_data *drv_data)
 {
 	void *reg = drv_data->ioaddr;
-	u8 n_bytes = drv_data->cur_chip->n_bytes;
+	u8 n_bytes = drv_data->n_bytes;
 
 	while ((read_SSSR(reg) & SSSR_RNE)
 			&& (drv_data->rx < drv_data->rx_end)) {
@@ -256,7 +260,7 @@ static void u32_writer(struct driver_dat
 
 	while ((read_SSSR(reg) & SSSR_TNF)
 			&& (drv_data->tx < drv_data->tx_end)) {
-		write_SSDR(*(u16 *)(drv_data->tx), reg);
+		write_SSDR(*(u32 *)(drv_data->tx), reg);
 		drv_data->tx += 4;
 	}
 }
@@ -677,6 +681,10 @@ static void pump_transfers(unsigned long
 	struct spi_transfer *previous = NULL;
 	struct chip_data *chip = NULL;
 	void *reg = drv_data->ioaddr;
+	u32 clk_div = 0;
+	u8 bits = 0;
+	u32 speed = 0;
+	u32 cr0;
 
 	/* Get current state information */
 	message = drv_data->cur_msg;
@@ -713,6 +721,8 @@ static void pump_transfers(unsigned long
 		giveback(message, drv_data);
 		return;
 	}
+	drv_data->n_bytes = chip->n_bytes;
+	drv_data->dma_width = chip->dma_width;
 	drv_data->cs_control = chip->cs_control;
 	drv_data->tx = (void *)transfer->tx_buf;
 	drv_data->tx_end = drv_data->tx + transfer->len;
@@ -724,6 +734,62 @@ static void pump_transfers(unsigned long
 	drv_data->write = drv_data->tx ? chip->write : null_writer;
 	drv_data->read = drv_data->rx ? chip->read : null_reader;
 	drv_data->cs_change = transfer->cs_change;
+
+	/* Change speed and bit per word on a per transfer */
+	if (transfer->speed_hz || transfer->bits_per_word) {
+
+		/* Disable clock */
+		write_SSCR0(chip->cr0 & ~SSCR0_SSE, reg);
+		cr0 = chip->cr0;
+		bits = chip->bits_per_word;
+		speed = chip->speed_hz;
+
+		if (transfer->speed_hz)
+			speed = transfer->speed_hz;
+
+		if (transfer->bits_per_word)
+			bits = transfer->bits_per_word;
+
+		if (reg == SSP1_VIRT)
+			clk_div = SSP1_SerClkDiv(speed);
+		else if (reg == SSP2_VIRT)
+			clk_div = SSP2_SerClkDiv(speed);
+		else if (reg == SSP3_VIRT)
+			clk_div = SSP3_SerClkDiv(speed);
+
+		if (bits <= 8) {
+			drv_data->n_bytes = 1;
+			drv_data->dma_width = DCMD_WIDTH1;
+			drv_data->read = drv_data->read != null_reader ?
+						u8_reader : null_reader;
+			drv_data->write = drv_data->write != null_writer ?
+						u8_writer : null_writer;
+		} else if (bits <= 16) {
+			drv_data->n_bytes = 2;
+			drv_data->dma_width = DCMD_WIDTH2;
+			drv_data->read = drv_data->read != null_reader ?
+						u16_reader : null_reader;
+			drv_data->write = drv_data->write != null_writer ?
+						u16_writer : null_writer;
+		} else if (bits <= 32) {
+			drv_data->n_bytes = 4;
+			drv_data->dma_width = DCMD_WIDTH4;
+			drv_data->read = drv_data->read != null_reader ?
+						u32_reader : null_reader;
+			drv_data->write = drv_data->write != null_writer ?
+						u32_writer : null_writer;
+		}
+
+		cr0 = clk_div
+			| SSCR0_Motorola
+			| SSCR0_DataSize(bits & 0x0f)
+			| SSCR0_SSE
+			| (bits > 16 ? SSCR0_EDSS : 0);
+
+		/* Start it back up */
+		write_SSCR0(cr0, reg);
+	}
+
 	message->state = RUNNING_STATE;
 
 	/* Try to map dma buffer and do a dma transfer if successful */
@@ -739,13 +805,13 @@ static void pump_transfers(unsigned long
 		if (drv_data->rx == drv_data->null_dma_buf)
 			/* No target address increment */
 			DCMD(drv_data->rx_channel) = DCMD_FLOWSRC
-							| chip->dma_width
+							| drv_data->dma_width
 							| chip->dma_burst_size
 							| drv_data->len;
 		else
 			DCMD(drv_data->rx_channel) = DCMD_INCTRGADDR
 							| DCMD_FLOWSRC
-							| chip->dma_width
+							| drv_data->dma_width
 							| chip->dma_burst_size
 							| drv_data->len;
 
@@ -756,13 +822,13 @@ static void pump_transfers(unsigned long
 		if (drv_data->tx == drv_data->null_dma_buf)
 			/* No source address increment */
 			DCMD(drv_data->tx_channel) = DCMD_FLOWTRG
-							| chip->dma_width
+							| drv_data->dma_width
 							| chip->dma_burst_size
 							| drv_data->len;
 		else
 			DCMD(drv_data->tx_channel) = DCMD_INCSRCADDR
 							| DCMD_FLOWTRG
-							| chip->dma_width
+							| drv_data->dma_width
 							| chip->dma_burst_size
 							| drv_data->len;
 
@@ -943,6 +1009,7 @@ static int setup(struct spi_device *spi)
 		clk_div = SSP3_SerClkDiv(spi->max_speed_hz);
 	else
 		return -ENODEV;
+	chip->speed_hz = spi->max_speed_hz;
 
 	chip->cr0 = clk_div
 			| SSCR0_Motorola
@@ -987,6 +1054,7 @@ static int setup(struct spi_device *spi)
 		kfree(chip);
 		return -ENODEV;
 	}
+	chip->bits_per_word = spi->bits_per_word;
 
 	spi_set_ctldata(spi, chip);
 
