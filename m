Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWBGCp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWBGCp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBGCp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:45:29 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:10914 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S964901AbWBGCp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:45:28 -0500
Date: Mon, 06 Feb 2006 18:45:13 -0800
From: stephen@streetfiresound.com
To: linux-kernel@vger.kernel.org
Cc: stephen@redrocketcomputing.com
Subject: stephen@streetfiresound.com,stephen@redrocketcomp.com
Message-ID: <43e809b9.O9DU/zgTeDgC0DCQ%stephen@streetfiresound.com>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

From: Stephen Street <stephen@streetfiresound.com>

The driver turns a PXA2xx synchronous serial port (SSP) into a SPI master 
controller (see Documentation/spi/spi_summary). The driver has the following
features:

- Support for any PXA2xx SSP
- SSP PIO and SSP DMA data transfers.
- External and Internal (SSPFRM) chip selects.
- Per slave device (chip) configuration.
- Full suspend, freeze, resume support.

Signed-off-by: Stephen Street <stephen@streetfiresound.com>
---

 Documentation/spi/pxa2xx              |  234 +++++
 drivers/spi/Kconfig                   |    8 
 drivers/spi/Makefile                  |    1 
 drivers/spi/pxa2xx_spi.c              | 1512 ++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-pxa/pxa2xx_spi.h |   75 +
 5 files changed, 1830 insertions(+)

--- linux-2.6.16-rc2/drivers/spi/Kconfig	2006-02-06 18:39:31.745537273 -0800
+++ linux-spi/drivers/spi/Kconfig	2006-02-06 18:39:45.322334884 -0800
@@ -85,6 +85,14 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
+config SPI_PXA2XX
+	tristate "PXA2xx SSP SPI master"
+	depends on SPI_MASTER && ARCH_PXA && EXPERIMENTAL
+	help
+	  This enables using a PXA2xx SSP port as a SPI master controller.
+	  The driver can be configured to use any SSP port and additional
+	  documentation can be found a Documentation/spi/pxa2xx.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
--- linux-2.6.16-rc2/drivers/spi/Makefile	2006-02-06 18:39:31.745537273 -0800
+++ linux-spi/drivers/spi/Makefile	2006-02-06 18:39:45.329334779 -0800
@@ -13,6 +13,7 @@ obj-$(CONFIG_SPI_MASTER)		+= spi.o
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
+obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
--- linux-2.6.16-rc2/drivers/spi/pxa2xx_spi.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-spi/drivers/spi/pxa2xx_spi.c	2006-02-06 18:39:45.339334630 -0800
@@ -0,0 +1,1512 @@
+/*
+ * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/spi/spi.h>
+#include <linux/workqueue.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/hardware.h>
+#include <asm/delay.h>
+#include <asm/dma.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/pxa2xx_spi.h>
+
+MODULE_AUTHOR("Stephen Street");
+MODULE_DESCRIPTION("PXA2xx SSP SPI Contoller");
+MODULE_LICENSE("GPL");
+
+#define CLOCK_SPEED_HZ 3686400
+#define MAX_BUSES 3
+
+#define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
+#define RESET_DMA_CHANNEL (DCSR_NODESC | DMA_INT_MASK)
+#define IS_DMA_ALIGNED(x) (((u32)(x)&0x07)==0)
+
+#define SSP_REG(x) (*((volatile unsigned long *)x))
+
+#define START_STATE ((void*)0)
+#define RUNNING_STATE ((void*)1)
+#define DONE_STATE ((void*)2)
+#define ERROR_STATE ((void*)-1)
+
+#define QUEUE_RUNNING 0
+#define QUEUE_STALLED 1
+#define QUEUE_STOPPED 2
+
+static u32 bit_bucket;
+
+struct driver_data {
+	/* Driver model hookup */
+	struct platform_device *pdev;
+
+	/* SPI framework hookup */
+	enum pxa_ssp_type ssp_type;
+	struct spi_master *master;
+
+	/* PXA hookup */
+	struct pxa2xx_spi_master *master_info;
+
+	/* DMA setup stuff */
+	int rx_channel;
+	int tx_channel;
+	void *null_dma_buf;
+
+	/* SSP register addresses */
+	u32 sscr0;
+	u32 sscr1;
+	u32 sssr;
+	u32 ssitr;
+	u32 ssdr;
+	u32 ssdr_physical;
+	u32 ssto;
+	u32 sspsp;
+
+	/* SSP masks*/
+	u32 dma_cr1;
+	u32 int_cr1;
+	u32 clear_sr;
+	u32 mask_sr;
+
+	/* Driver message queue */
+	struct workqueue_struct	*workqueue;
+	struct work_struct pump_messages;
+	spinlock_t lock;
+	struct list_head queue;
+	int busy;
+	int run;
+
+	/* Message Transfer pump */
+	struct tasklet_struct pump_transfers;
+
+	/* Current message transfer state info */
+	struct spi_message* cur_msg;
+	struct spi_transfer* cur_transfer;
+	struct chip_data *cur_chip;
+	size_t len;
+	void *tx;
+	void *tx_end;
+	void *rx;
+	void *rx_end;
+	int dma_mapped;
+	dma_addr_t rx_dma;
+	dma_addr_t tx_dma;
+	size_t rx_map_len;
+	size_t tx_map_len;
+	int cs_change;
+	void (*write)(struct driver_data *drv_data);
+	void (*read)(struct driver_data *drv_data);
+	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
+	void (*cs_control)(u32 command);
+};
+
+struct chip_data {
+	u32 cr0;
+	u32 cr1;
+	u32 to;
+	u32 psp;
+	u32 timeout;
+	u8 n_bytes;
+	u32 dma_width;
+	u32 dma_burst_size;
+	u32 threshold;
+	u32 dma_threshold;
+	u8 enable_dma;
+	void (*write)(struct driver_data *drv_data);
+	void (*read)(struct driver_data *drv_data);
+	void (*cs_control)(u32 command);
+};
+
+static void pump_messages(void *data);
+
+static inline void flush(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+
+	do {
+		while (SSP_REG(sssr) & SSSR_RNE) {
+			(void)SSP_REG(ssdr);
+		}
+	} while (SSP_REG(sssr) & SSSR_BSY);
+	SSP_REG(sssr) = SSSR_ROR ;
+}
+
+static inline void save_state(struct driver_data *drv_data)
+{
+	/* Save critical register */
+	drv_data->cur_chip->cr0 = SSP_REG(drv_data->sscr0);
+	drv_data->cur_chip->cr1 = SSP_REG(drv_data->sscr1);
+	drv_data->cur_chip->to = SSP_REG(drv_data->ssto);
+	drv_data->cur_chip->psp = SSP_REG(drv_data->sspsp);
+
+	/* Disable clock */
+	SSP_REG(drv_data->sscr0) &= ~SSCR0_SSE;
+}
+
+static inline void restore_state(struct driver_data *drv_data)
+{
+	/* Clear status and disable clock */
+	SSP_REG(drv_data->sssr) = drv_data->clear_sr;
+	SSP_REG(drv_data->sscr0) = drv_data->cur_chip->cr0 & ~SSCR0_SSE;
+
+	/* Load the registers */
+	SSP_REG(drv_data->sscr1) = drv_data->cur_chip->cr1;
+	SSP_REG(drv_data->ssto) = drv_data->cur_chip->to;
+	SSP_REG(drv_data->sspsp) = drv_data->cur_chip->psp;
+	SSP_REG(drv_data->sscr0) = drv_data->cur_chip->cr0;
+}
+
+static inline void dump_dma_state(struct driver_data *drv_data)
+{
+	dev_dbg(&drv_data->pdev->dev,
+		"rx_channel=0x%08x, "
+		"dcsr=0x%08x, "
+		"dsadr=0x%08x, "
+		"dtadr=0x%08x, "
+		"dcmd=0x%08x\n",
+		drv_data->rx_channel,
+		DCSR(drv_data->rx_channel),
+		DSADR(drv_data->rx_channel),
+		DTADR(drv_data->rx_channel),
+		DCMD(drv_data->rx_channel));
+	dev_dbg(&drv_data->pdev->dev,
+		"tx_channel=0x%08x, "
+		"dcsr=0x%08x, "
+		"dsadr=0x%08x, "
+		"dtadr=0x%08x, "
+		"dcmd=0x%08x\n",
+		drv_data->tx_channel,
+		DCSR(drv_data->tx_channel),
+		DSADR(drv_data->tx_channel),
+		DTADR(drv_data->tx_channel),
+		DCMD(drv_data->tx_channel));
+}
+
+static inline void dump_ssp_state(struct driver_data *drv_data)
+{
+	if (drv_data->ssp_type != PXA25x_SSP)
+		dev_dbg(&drv_data->pdev->dev,
+			"NSSP dump: sscr0=0x%08lx, sscr1=0x%08lx, "
+			"ssto=0x%08lx, sspsp=0x%08lx, sssr=0x%08lx\n",
+			SSP_REG(drv_data->sscr0), SSP_REG(drv_data->sscr1),
+			SSP_REG(drv_data->ssto), SSP_REG(drv_data->sspsp),
+			SSP_REG(drv_data->sssr));
+	else
+		dev_dbg(&drv_data->pdev->dev,
+			"SSP dump: sscr0=0x%08lx, sscr1=0x%08lx, "
+			"sssr=0x%04lx\n",
+			SSP_REG(drv_data->sscr0), SSP_REG(drv_data->sscr1),
+			SSP_REG(drv_data->sssr));
+}
+
+static inline void dump_message(char *header, struct spi_message *msg)
+{
+	int i = 0;
+	struct device *dev = &msg->spi->dev;
+	struct spi_transfer *transfer;
+
+	dev_dbg(dev, "%s\n", header);
+	dev_dbg(dev, "    address = %p\n", msg);
+	dev_dbg(dev, "    spi = %p\n", msg->spi);
+	dev_dbg(dev, "    complete = %p\n", msg->complete);
+	dev_dbg(dev, "    context = %p\n", msg->context);
+	dev_dbg(dev, "    actual_length = %u\n", msg->actual_length);
+	dev_dbg(dev, "    status = %d\n", msg->status);
+	dev_dbg(dev, "    state = %p\n", msg->state);
+
+	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
+		dev_dbg(dev, "    %d, tx_buf = %p (%08x)\n",
+			i, transfer->tx_buf, transfer->tx_dma);
+		dev_dbg(dev, "    %d, rx_buf = %p (%08x)\n",
+			i, transfer->rx_buf, transfer->rx_dma);
+		dev_dbg(dev, "    %d, len = %u\n",
+			i, transfer->len);
+		dev_dbg(dev, "    %d, cs_change = %u\n",
+			i, transfer->cs_change);
+		dev_dbg(dev, "    %d, delay_usecs = %u\n",
+			i, transfer->delay_usecs);
+		i++;
+	}
+}
+
+static inline void dump_transfer_state(char* header, struct driver_data *drv_data)
+{
+	struct device *dev;
+
+	if (drv_data->cur_msg == NULL) {
+		printk(KERN_DEBUG "cur_msg is null\n");
+		return;
+	}
+
+	dev = &drv_data->pdev->dev;
+
+	dev_dbg(dev, "%s\n", header);
+	dev_dbg(dev, "    transfer = %p\n", drv_data->cur_transfer);
+	dev_dbg(dev, "    len = %d\n", drv_data->len);
+	dev_dbg(dev, "    tx = %p\n", drv_data->tx);
+	dev_dbg(dev, "    tx_end = %p\n", drv_data->tx_end);
+	dev_dbg(dev, "    rx = %p\n", drv_data->rx);
+	dev_dbg(dev, "    rx_end = %p\n", drv_data->rx_end);
+}
+
+static inline void dump_chip_state(struct device *dev,
+				char * header,
+				struct chip_data *chip)
+{
+	dev_dbg(dev, "%s\n", header);
+	dev_dbg(dev, "    cr0 = 0x%08x\n", chip->cr0);
+	dev_dbg(dev, "    cr1 = 0x%08x\n", chip->cr1);
+	dev_dbg(dev, "    to = 0x%08x\n", chip->to);
+	dev_dbg(dev, "    psp = 0x%08x\n", chip->psp);
+	dev_dbg(dev, "    timeout = 0x%08x\n", chip->timeout);
+	dev_dbg(dev, "    n_bytes = 0x%02x\n", chip->n_bytes);
+	dev_dbg(dev, "    dma_width = 0x%08x\n", chip->dma_width);
+	dev_dbg(dev, "    dma_burst_size = 0x%08x\n", chip->dma_burst_size);
+	dev_dbg(dev, "    threshold = 0x%08x\n", chip->threshold);
+	dev_dbg(dev, "    dma_threshold = 0x%08x\n", chip->dma_threshold);
+	dev_dbg(dev, "    enable_dma = 0x%02x\n", chip->enable_dma);
+	dev_dbg(dev, "    write = %p\n", chip->write);
+	dev_dbg(dev, "    read = %p\n", chip->read);
+	dev_dbg(dev, "    cs_control = %p\n", chip->cs_control);
+}
+
+static void null_cs_control(u32 command)
+{
+}
+
+static void null_writer(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+	u8 n_bytes = drv_data->cur_chip->n_bytes;
+
+	while ((SSP_REG(sssr) & SSSR_TNF)
+			&& (drv_data->tx < drv_data->tx_end)) {
+		SSP_REG(ssdr) = 0;
+		drv_data->tx += n_bytes;
+	}
+}
+
+static void null_reader(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+	u8 n_bytes = drv_data->cur_chip->n_bytes;
+
+	while ((SSP_REG(sssr) & SSSR_RNE)
+			&& (drv_data->rx < drv_data->rx_end)) {
+		(void)(SSP_REG(ssdr));
+		drv_data->rx += n_bytes;
+	}
+}
+
+static void u8_writer(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+
+	while ((SSP_REG(sssr) & SSSR_TNF)
+			&& (drv_data->tx < drv_data->tx_end)) {
+		SSP_REG(ssdr) = *(u8 *)(drv_data->tx);
+		++drv_data->tx;
+	}
+}
+
+static void u8_reader(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+
+	while ((SSP_REG(sssr) & SSSR_RNE)
+			&& (drv_data->rx < drv_data->rx_end)) {
+		*(u8 *)(drv_data->rx) = SSP_REG(ssdr);
+		++drv_data->rx;
+	}
+}
+
+static void u16_writer(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+
+	while ((SSP_REG(sssr) & SSSR_TNF)
+				&& (drv_data->tx < drv_data->tx_end)) {
+		SSP_REG(ssdr) = *(u16 *)(drv_data->tx);
+		drv_data->tx += 2;
+	}
+}
+
+static void u16_reader(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+
+	while ((SSP_REG(sssr) & SSSR_RNE)
+			&& (drv_data->rx < drv_data->rx_end)) {
+		*(u16 *)(drv_data->rx) = SSP_REG(ssdr);
+		drv_data->rx += 2;
+	}
+}
+static void u32_writer(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+
+	while ((SSP_REG(sssr) & SSSR_TNF)
+			&& (drv_data->tx < drv_data->tx_end)) {
+		SSP_REG(ssdr) = *(u32 *)(drv_data->tx);
+		drv_data->tx += 4;
+	}
+}
+
+static void u32_reader(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 ssdr = drv_data->ssdr;
+
+	while ((SSP_REG(sssr) & SSSR_RNE)
+			&& (drv_data->rx < drv_data->rx_end)) {
+		*(u32 *)(drv_data->rx) = SSP_REG(ssdr);
+		drv_data->rx += 4;
+	}
+}
+
+static inline void* next_transfer(struct driver_data *drv_data)
+{
+	struct spi_message *msg = drv_data->cur_msg;
+	struct spi_transfer *trans = drv_data->cur_transfer;
+
+	/* Move to next transfer */
+	if (trans->transfer_list.next != &msg->transfers) {
+		drv_data->cur_transfer =
+			list_entry(trans->transfer_list.next,
+					struct spi_transfer,
+					transfer_list);
+		return RUNNING_STATE;
+	} else
+		return DONE_STATE;
+}
+
+static int map_dma_buffers(struct driver_data *drv_data)
+{
+	struct spi_message *msg = drv_data->cur_msg;
+	struct device *dev = &msg->spi->dev;
+
+	if (!drv_data->cur_chip->enable_dma)
+		return 0;
+
+	if (msg->is_dma_mapped)
+		return  drv_data->rx_dma && drv_data->tx_dma;
+
+	if (!IS_DMA_ALIGNED(drv_data->rx) || !IS_DMA_ALIGNED(drv_data->tx))
+		return 0;
+
+	if (drv_data->len < drv_data->cur_chip->dma_burst_size)
+		return 0;
+
+	/* Modify setup if rx buffer is null */
+	if (drv_data->rx == NULL) {
+		*(u32 *)(drv_data->null_dma_buf) = 0;
+		drv_data->rx = drv_data->null_dma_buf;
+		drv_data->rx_map_len = 4;
+	} else
+		drv_data->rx_map_len = drv_data->len;
+
+
+	/* Modify setup if tx buffer is null */
+	if (drv_data->tx == NULL) {
+		*(u32 *)(drv_data->null_dma_buf) = 0;
+		drv_data->tx = drv_data->null_dma_buf;
+		drv_data->tx_map_len = 4;
+	} else
+		drv_data->tx_map_len = drv_data->len;
+
+	/* Stream map the rx buffer */
+	drv_data->rx_dma = dma_map_single(dev, drv_data->rx,
+						drv_data->rx_map_len,
+						DMA_FROM_DEVICE);
+	if (dma_mapping_error(drv_data->rx_dma))
+		return 0;
+
+	/* Stream map the tx buffer */
+	drv_data->tx_dma = dma_map_single(dev, drv_data->tx,
+						drv_data->tx_map_len,
+						DMA_TO_DEVICE);
+
+	if (dma_mapping_error(drv_data->tx_dma)) {
+		dma_unmap_single(dev, drv_data->rx_dma,
+					drv_data->rx_map_len, DMA_FROM_DEVICE);
+		return 0;
+	}
+
+	return 1;
+}
+
+static void unmap_dma_buffers(struct driver_data *drv_data)
+{
+	struct device *dev;
+
+	if (!drv_data->dma_mapped)
+		return;
+
+	if (!drv_data->cur_msg->is_dma_mapped) {
+		dev = &drv_data->cur_msg->spi->dev;
+		dma_unmap_single(dev, drv_data->rx_dma,
+					drv_data->rx_map_len, DMA_FROM_DEVICE);
+		dma_unmap_single(dev, drv_data->tx_dma,
+					drv_data->tx_map_len, DMA_FROM_DEVICE);
+	}
+
+	drv_data->dma_mapped = 0;
+}
+
+/* caller already set message->status; dma and pio irqs are blocked */
+static void giveback(struct spi_message *message, struct driver_data *drv_data)
+{
+	struct spi_transfer* last_transfer;
+
+	last_transfer = list_entry(message->transfers.prev,
+					struct spi_transfer,
+					transfer_list);
+
+	if (!last_transfer->cs_change)
+		drv_data->cs_control(PXA2XX_CS_DEASSERT);
+
+	message->state = NULL;
+	if (message->complete) {
+		message->complete(message->context);
+	}
+
+	drv_data->cur_msg = NULL;
+	drv_data->cur_transfer = NULL;
+	drv_data->cur_chip = NULL;
+	queue_work(drv_data->workqueue, &drv_data->pump_messages);
+}
+
+static void dma_handler(int channel, void *data, struct pt_regs *regs)
+{
+	struct driver_data *drv_data = (struct driver_data *)data;
+	struct spi_message *msg = drv_data->cur_msg;
+	u32 sssr = drv_data->sssr;
+	u32 sscr1 = drv_data->sscr1;
+	u32 ssto = drv_data->sscr1;
+	u32 irq_status = DCSR(channel) & DMA_INT_MASK;
+	u32 trailing_sssr = 0;
+
+	if (irq_status & DCSR_BUSERR) {
+
+		/* Disable interrupts, clear status and reset DMA */
+		SSP_REG(ssto) = 0;
+		SSP_REG(sssr) = drv_data->clear_sr;
+		SSP_REG(sscr1) &= ~(drv_data->dma_cr1);
+		DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
+		DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
+
+		flush(drv_data);
+
+		unmap_dma_buffers(drv_data);
+
+		if (channel == drv_data->tx_channel)
+			dev_err(&drv_data->pdev->dev,
+				"dma_handler: bad bus address on "
+				"tx channel %d, source %x target = %x\n",
+				channel, DSADR(channel), DTADR(channel));
+		else
+			dev_err(&drv_data->pdev->dev,
+				"dma_handler: bad bus address on "
+				"rx channel %d, source %x target = %x\n",
+				channel, DSADR(channel), DTADR(channel));
+
+		msg->state = ERROR_STATE;
+		tasklet_schedule(&drv_data->pump_transfers);
+	}
+
+	/* PXA255x_SSP has no timeout interrupt, wait for tailing bytes */
+	if ((drv_data->ssp_type == PXA25x_SSP)
+		&& (channel == drv_data->tx_channel)
+		&& (irq_status & DCSR_ENDINTR)) {
+
+		/* Wait for rx to stall */
+		while (SSP_REG(sssr) & SSSR_BSY)
+			cpu_relax();
+
+		/* Clear and disable interrupts on SSP and DMA channels*/
+		SSP_REG(sssr) = drv_data->clear_sr;
+		SSP_REG(sscr1) &= ~(drv_data->dma_cr1);
+		DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
+		DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
+		while (!(DCSR(drv_data->rx_channel) & DCSR_STOPSTATE))
+			cpu_relax();
+
+		unmap_dma_buffers(drv_data);
+
+		/* Read trailing bytes */
+		/* Calculate number of trailing bytes, read them */
+		trailing_sssr = SSP_REG(sssr);
+		if ((trailing_sssr & 0xf008) != 0xf000) {
+			drv_data->rx = drv_data->rx_end -
+					(((trailing_sssr >> 12) & 0x0f) + 1);
+			drv_data->read(drv_data);
+		}
+		msg->actual_length += drv_data->len;
+
+		/* Release chip select if requested, transfer delays are
+		 * handled in pump_transfers */
+		if (drv_data->cs_change)
+			drv_data->cs_control(PXA2XX_CS_DEASSERT);
+
+		/* Move to next transfer */
+		msg->state = next_transfer(drv_data);
+
+		/* Schedule transfer tasklet */
+		tasklet_schedule(&drv_data->pump_transfers);
+	}
+}
+
+static irqreturn_t dma_transfer(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 sscr1 = drv_data->sscr1;
+	u32 ssto = drv_data->ssto;
+	u32 irq_status = SSP_REG(sssr) & drv_data->mask_sr;
+	u32 trailing_sssr = 0;
+	struct spi_message *msg = drv_data->cur_msg;
+
+	if (irq_status & SSSR_ROR) {
+		/* Clear and disable interrupts on SSP and DMA channels*/
+		SSP_REG(ssto) = 0;
+		SSP_REG(sssr) = drv_data->clear_sr;
+		SSP_REG(sscr1) &= ~(drv_data->dma_cr1);
+		DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
+		DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
+		unmap_dma_buffers(drv_data);
+		flush(drv_data);
+
+		dev_warn(&drv_data->pdev->dev, "dma_transfer: fifo overun\n");
+
+		drv_data->cur_msg->state = ERROR_STATE;
+		tasklet_schedule(&drv_data->pump_transfers);
+
+		return IRQ_HANDLED;
+	}
+
+	/* Check for false positive timeout */
+	if ((irq_status & SSSR_TINT) && DCSR(drv_data->tx_channel) & DCSR_RUN) {
+		SSP_REG(sssr) = SSSR_TINT;
+		return IRQ_HANDLED;
+	}
+
+	if (irq_status & SSSR_TINT || drv_data->rx == drv_data->rx_end) {
+
+		/* Clear and disable interrupts on SSP and DMA channels*/
+		SSP_REG(ssto) = 0;
+		SSP_REG(sssr) = drv_data->clear_sr;
+		SSP_REG(sscr1) &= ~(drv_data->dma_cr1);
+		DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
+		DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
+		while (!(DCSR(drv_data->rx_channel) & DCSR_STOPSTATE)
+				|| (SSP_REG(sssr) & SSSR_BSY))
+			cpu_relax();
+
+		unmap_dma_buffers(drv_data);
+
+		/* Calculate number of trailing bytes, read them */
+		trailing_sssr = SSP_REG(sssr);
+		if ((trailing_sssr & 0xf008) != 0xf000) {
+			drv_data->rx = drv_data->rx_end -
+					(((trailing_sssr >> 12) & 0x0f) + 1);
+			drv_data->read(drv_data);
+		}
+		msg->actual_length += drv_data->len;
+
+		/* Release chip select if requested, transfer delays are
+		 * handled in pump_transfers */
+		if (drv_data->cs_change)
+			drv_data->cs_control(PXA2XX_CS_DEASSERT);
+
+		/* Move to next transfer */
+		msg->state = next_transfer(drv_data);
+
+		/* Schedule transfer tasklet */
+		tasklet_schedule(&drv_data->pump_transfers);
+
+		return IRQ_HANDLED;
+	}
+
+	/* Never Fail */
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
+{
+	u32 sssr = drv_data->sssr;
+	u32 sscr1 = drv_data->sscr1;
+	u32 ssto = drv_data->ssto;
+	u32 irq_status;
+	struct spi_message *msg = drv_data->cur_msg;
+
+	while ((irq_status = (SSP_REG(sssr) & drv_data->mask_sr))) {
+
+		if (irq_status & SSSR_ROR) {
+
+			/* Clear and disable interrupts */
+			SSP_REG(ssto) = 0;
+			SSP_REG(sssr) = drv_data->clear_sr;
+			SSP_REG(sscr1) &= ~(drv_data->int_cr1);
+			flush(drv_data);
+
+			dev_warn(&drv_data->pdev->dev,
+					"interrupt_transfer: fifo overun\n");
+
+			msg->state = ERROR_STATE;
+			tasklet_schedule(&drv_data->pump_transfers);
+
+			return IRQ_HANDLED;
+		}
+
+		/* Look for false positive timeout */
+		if ((irq_status & SSSR_TINT)
+				&& (drv_data->rx < drv_data->rx_end))
+			SSP_REG(sssr) = SSSR_TINT;
+
+		/* Pump data */
+		drv_data->read(drv_data);
+		drv_data->write(drv_data);
+
+		if (drv_data->tx == drv_data->tx_end) {
+			/* Disable tx interrupt */
+			SSP_REG(sscr1) &= ~SSCR1_TIE;
+
+			/* PXA25x_SSP has no timeout, read trailing bytes */
+			if (drv_data->ssp_type == PXA25x_SSP) {
+				while (SSP_REG(sssr) & SSSR_BSY)
+					drv_data->read(drv_data);
+			}
+		}
+
+		if ((irq_status & SSSR_TINT)
+				|| (drv_data->rx == drv_data->rx_end)) {
+
+			/* Clear timeout */
+			SSP_REG(ssto) = 0;
+			SSP_REG(sssr) = drv_data->clear_sr;
+			SSP_REG(sscr1) &= ~(drv_data->int_cr1);
+
+			/* Update total byte transfered */
+			msg->actual_length += drv_data->len;
+
+			/* Release chip select if requested, transfer delays are
+			 * handled in pump_transfers */
+			if (drv_data->cs_change)
+				drv_data->cs_control(PXA2XX_CS_DEASSERT);
+
+			/* Move to next transfer */
+			msg->state = next_transfer(drv_data);
+
+			/* Schedule transfer tasklet */
+			tasklet_schedule(&drv_data->pump_transfers);
+
+			return IRQ_HANDLED;
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ssp_int(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct driver_data *drv_data = (struct driver_data *)dev_id;
+
+	if (!drv_data->cur_msg) {
+		dev_err(&drv_data->pdev->dev, "bad message state "
+				"in interrupt handler\n");
+		/* Never fail */
+		return IRQ_HANDLED;
+	}
+
+	return drv_data->transfer_handler(drv_data);
+}
+
+static void pump_transfers(unsigned long data)
+{
+	struct driver_data *drv_data = (struct driver_data *)data;
+	struct spi_message *message = NULL;
+	struct spi_transfer *transfer = NULL;
+	struct spi_transfer *previous = NULL;
+	struct chip_data *chip = NULL;
+	u32 sssr = drv_data->sssr;
+	u32 sscr1 = drv_data->sscr1;
+	u32 ssto = drv_data->ssto;
+
+	/* Get current state information */
+	message = drv_data->cur_msg;
+	transfer = drv_data->cur_transfer;
+	chip = drv_data->cur_chip;
+
+	/* Handle for abort */
+	if (message->state == ERROR_STATE) {
+		message->status = -EIO;
+		giveback(message, drv_data);
+		return;
+	}
+
+	/* Handle end of message */
+	if (message->state == DONE_STATE) {
+		message->status = 0;
+		giveback(message, drv_data);
+		return;
+	}
+
+	/* Delay if requested at end of transfer*/
+	if (message->state == RUNNING_STATE) {
+		previous = list_entry(transfer->transfer_list.prev,
+					struct spi_transfer,
+					transfer_list);
+		if (previous->delay_usecs)
+			udelay(previous->delay_usecs);
+	}
+
+	/* Setup the transfer state based on the type of transfer */
+	flush(drv_data);
+	drv_data->cs_control = chip->cs_control;
+	drv_data->tx = (void *)transfer->tx_buf;
+	drv_data->tx_end = drv_data->tx + transfer->len;
+	drv_data->rx = transfer->rx_buf;
+	drv_data->rx_end = drv_data->rx + transfer->len;
+	drv_data->rx_dma = transfer->rx_dma;
+	drv_data->tx_dma = transfer->tx_dma;
+	drv_data->len = transfer->len;
+	drv_data->write = drv_data->tx ? chip->write : null_writer;
+	drv_data->read = drv_data->rx ? chip->read : null_reader;
+	drv_data->cs_change = transfer->cs_change;
+	message->state = RUNNING_STATE;
+
+	/* Try to map dma buffer and do a dma transfer if successful */
+	if ((drv_data->dma_mapped = map_dma_buffers(drv_data))) {
+
+		/* Ensure we have the correct interrupt handler */
+		drv_data->transfer_handler = dma_transfer;
+
+		/* Setup rx DMA Channel */
+		DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
+		DSADR(drv_data->rx_channel) = drv_data->ssdr_physical;
+		DTADR(drv_data->rx_channel) = drv_data->rx_dma;
+		if (drv_data->rx == drv_data->null_dma_buf)
+			/* No target address increment */
+			DCMD(drv_data->rx_channel) = DCMD_FLOWSRC
+							| chip->dma_width
+							| chip->dma_burst_size
+							| drv_data->len;
+		else
+			DCMD(drv_data->rx_channel) = DCMD_INCTRGADDR
+							| DCMD_FLOWSRC
+							| chip->dma_width
+							| chip->dma_burst_size
+							| drv_data->len;
+
+		/* Setup tx DMA Channel */
+		DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
+		DSADR(drv_data->tx_channel) = drv_data->tx_dma;
+		DTADR(drv_data->tx_channel) = drv_data->ssdr_physical;
+		if (drv_data->tx == drv_data->null_dma_buf)
+			/* No source address increment */
+			DCMD(drv_data->tx_channel) = DCMD_FLOWTRG
+							| chip->dma_width
+							| chip->dma_burst_size
+							| drv_data->len;
+		else
+			DCMD(drv_data->tx_channel) = DCMD_INCSRCADDR
+							| DCMD_FLOWTRG
+							| chip->dma_width
+							| chip->dma_burst_size
+							| drv_data->len;
+
+		/* Enable dma end irqs on SSP to detect end of transfer */
+		if (drv_data->ssp_type == PXA25x_SSP) {
+			DCMD(drv_data->tx_channel) |= DCMD_ENDIRQEN;
+		}
+
+		/* Fix me, need to handle cs polarity */
+		drv_data->cs_control(PXA2XX_CS_ASSERT);
+
+		/* Go baby, go */
+		SSP_REG(sssr) = drv_data->clear_sr;
+		DCSR(drv_data->rx_channel) |= DCSR_RUN;
+		DCSR(drv_data->tx_channel) |= DCSR_RUN;
+		SSP_REG(ssto) = chip->timeout;
+		SSP_REG(sscr1) = chip->cr1
+					| chip->dma_threshold
+					| drv_data->dma_cr1;
+	} else {
+		/* Ensure we have the correct interrupt handler	*/
+		drv_data->transfer_handler = interrupt_transfer;
+
+		/* Fix me, need to handle cs polarity */
+		drv_data->cs_control(PXA2XX_CS_ASSERT);
+
+		/* Go baby, go */
+		SSP_REG(sssr) = drv_data->clear_sr;
+		SSP_REG(ssto) = chip->timeout;
+		SSP_REG(sscr1) = chip->cr1
+					| chip->threshold
+					| drv_data->int_cr1;
+	}
+}
+
+static void pump_messages(void *data)
+{
+	struct driver_data *drv_data = data;
+	unsigned long flags;
+
+	/* Lock queue and check for queue work */
+	spin_lock_irqsave(&drv_data->lock, flags);
+	if (list_empty(&drv_data->queue) || drv_data->run == QUEUE_STALLED) {
+		drv_data->busy = 0;
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return;
+	}
+
+	/* Make sure we are not already running a message */
+	if (drv_data->cur_msg) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return;
+	}
+
+	/* Extract head of queue */
+	drv_data->cur_msg = list_entry(drv_data->queue.next,
+					struct spi_message, queue);
+	list_del_init(&drv_data->cur_msg->queue);
+	drv_data->busy = 1;
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	/* Initial message state*/
+	drv_data->cur_msg->state = START_STATE;
+	drv_data->cur_transfer = list_entry(drv_data->cur_msg->transfers.next,
+						struct spi_transfer,
+						transfer_list);
+
+	/* Setup the SSP using the per chip configuration */
+	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
+	restore_state(drv_data);
+
+	/* Mark as busy and launch transfers */
+	tasklet_schedule(&drv_data->pump_transfers);
+}
+
+static int transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+
+	if (drv_data->run == QUEUE_STOPPED) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return -ESHUTDOWN;
+	}
+
+	msg->actual_length = 0;
+	msg->status = -EINPROGRESS;
+	msg->state = START_STATE;
+
+	list_add_tail(&msg->queue, &drv_data->queue);
+
+	if (drv_data->run == QUEUE_RUNNING && !drv_data->busy)
+		queue_work(drv_data->workqueue, &drv_data->pump_messages);
+
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	return 0;
+}
+
+static int setup(struct spi_device *spi)
+{
+	struct pxa2xx_spi_chip *chip_info = NULL;
+	struct chip_data *chip;
+	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (drv_data->ssp_type != PXA25x_SSP
+			&& (spi->bits_per_word < 4 || spi->bits_per_word > 32))
+		return -EINVAL;
+	else if (spi->bits_per_word < 4 || spi->bits_per_word > 16)
+		return -EINVAL;
+
+	/* Only alloc (or use chip_info) on first setup */
+	chip = spi_get_ctldata(spi);
+	if (chip == NULL) {
+		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
+		if (!chip)
+			return -ENOMEM;
+
+		chip->cs_control = null_cs_control;
+		chip->enable_dma = 0;
+		chip->timeout = 5;
+		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
+		chip->dma_burst_size = drv_data->master_info->enable_dma ?
+					DCMD_BURST8 : 0;
+
+		chip_info = (struct pxa2xx_spi_chip *)spi->controller_data;
+	}
+
+	/* chip_info isn't always needed */
+	if (chip_info) {
+		if (chip_info->cs_control)
+			chip->cs_control = chip_info->cs_control;
+
+		chip->timeout = (chip_info->timeout_microsecs * 10000) / 2712;
+
+		chip->threshold = SSCR1_RxTresh(chip_info->rx_threshold)
+					| SSCR1_TxTresh(chip_info->tx_threshold);
+
+		chip->enable_dma = chip_info->dma_burst_size != 0
+					&& drv_data->master_info->enable_dma;
+		chip->dma_threshold = 0;
+
+		if (chip->enable_dma) {
+			if (chip_info->dma_burst_size <= 8) {
+				chip->dma_threshold = SSCR1_RxTresh(8)
+							| SSCR1_TxTresh(8);
+				chip->dma_burst_size = DCMD_BURST8;
+			} else if (chip_info->dma_burst_size <= 16) {
+				chip->dma_threshold = SSCR1_RxTresh(16)
+							| SSCR1_TxTresh(16);
+				chip->dma_burst_size = DCMD_BURST16;
+			} else {
+				chip->dma_threshold = SSCR1_RxTresh(32)
+							| SSCR1_TxTresh(32);
+				chip->dma_burst_size = DCMD_BURST32;
+			}
+		}
+
+
+		if (chip_info->enable_loopback)
+			chip->cr1 = SSCR1_LBM;
+	}
+
+	chip->cr0 = SSCR0_SerClkDiv((CLOCK_SPEED_HZ / spi->max_speed_hz) + 2)
+			| SSCR0_Motorola
+			| SSCR0_DataSize(spi->bits_per_word & 0x0f)
+			| SSCR0_SSE
+			| (spi->bits_per_word > 16 ? SSCR0_EDSS : 0);
+	chip->cr1 |= (((spi->mode & SPI_CPHA) != 0) << 4)
+			| (((spi->mode & SPI_CPOL) != 0) << 3);
+
+	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
+	if (drv_data->ssp_type != PXA25x_SSP)
+		dev_dbg(&spi->dev, "%d bits/word, %d Hz, mode %d\n",
+				spi->bits_per_word,
+				(CLOCK_SPEED_HZ)
+					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
+				spi->mode & 0x3);
+	else
+		dev_dbg(&spi->dev, "%d bits/word, %d Hz, mode %d\n",
+				spi->bits_per_word,
+				(CLOCK_SPEED_HZ/2)
+					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
+				spi->mode & 0x3);
+
+	if (spi->bits_per_word <= 8) {
+		chip->n_bytes = 1;
+		chip->dma_width = DCMD_WIDTH1;
+		chip->read = u8_reader;
+		chip->write = u8_writer;
+	} else if (spi->bits_per_word <= 16) {
+		chip->n_bytes = 2;
+		chip->dma_width = DCMD_WIDTH2;
+		chip->read = u16_reader;
+		chip->write = u16_writer;
+	} else if (spi->bits_per_word <= 32) {
+		chip->cr0 |= SSCR0_EDSS;
+		chip->n_bytes = 4;
+		chip->dma_width = DCMD_WIDTH4;
+		chip->read = u32_reader;
+		chip->write = u32_writer;
+	} else {
+		dev_err(&spi->dev, "invalid wordsize\n");
+		kfree(chip);
+		return -ENODEV;
+	}
+
+	spi_set_ctldata(spi, chip);
+
+	return 0;
+}
+
+static void cleanup(const struct spi_device *spi)
+{
+	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
+	if (chip)
+		kfree(chip);
+}
+
+static int init_queue(struct driver_data *drv_data)
+{
+	INIT_LIST_HEAD(&drv_data->queue);
+	spin_lock_init(&drv_data->lock);
+
+	drv_data->run = QUEUE_STOPPED;
+	drv_data->busy = 0;
+
+	tasklet_init(&drv_data->pump_transfers,
+			pump_transfers,	(unsigned long)drv_data);
+
+	INIT_WORK(&drv_data->pump_messages, pump_messages, drv_data);
+	drv_data->workqueue = create_singlethread_workqueue(
+					drv_data->master->cdev.dev->bus_id);
+	if (drv_data->workqueue == NULL)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int start_queue(struct driver_data *drv_data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+
+	if (drv_data->run == QUEUE_RUNNING || drv_data->busy) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		return -EBUSY;
+	}
+
+	drv_data->run = QUEUE_RUNNING;
+	drv_data->cur_msg = NULL;
+	drv_data->cur_transfer = NULL;
+	drv_data->cur_chip = NULL;
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	queue_work(drv_data->workqueue, &drv_data->pump_messages);
+
+	return 0;
+}
+
+static int stop_queue(struct driver_data *drv_data)
+{
+	unsigned long flags;
+	unsigned limit = 500;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+
+	drv_data->run = QUEUE_STOPPED;
+
+	while (!list_empty(&drv_data->queue) && drv_data->busy && limit--) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		msleep(10);
+		spin_lock_irqsave(&drv_data->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	if (!list_empty(&drv_data->queue) || drv_data->busy)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int destroy_queue(struct driver_data *drv_data)
+{
+	int status;
+
+	status = stop_queue(drv_data);
+	if (status != 0)
+		return status;
+
+	destroy_workqueue(drv_data->workqueue);
+
+	return 0;
+}
+
+static int pxa2xx_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pxa2xx_spi_master *platform_info;
+	struct spi_master *master;
+	struct driver_data *drv_data = 0;
+	struct resource *memory_resource;
+	int irq;
+	int status = 0;
+
+	platform_info = (struct pxa2xx_spi_master *)dev->platform_data;
+
+	if (platform_info->ssp_type == SSP_UNDEFINED) {
+		dev_err(&pdev->dev, "undefined SSP\n");
+		return -ENODEV;
+	}
+
+	/* Allocate master with space for drv_data and null dma buffer */
+	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
+	if (!master) {
+		dev_err(&pdev->dev, "can not alloc spi_master\n");
+		return -ENOMEM;
+	}
+	drv_data = spi_master_get_devdata(master);
+	drv_data->master = master;
+	drv_data->master_info = platform_info;
+	drv_data->pdev = pdev;
+
+	master->bus_num = pdev->id;
+	master->num_chipselect = platform_info->num_chipselect;
+	master->cleanup = cleanup;
+	master->setup = setup;
+	master->transfer = transfer;
+
+	drv_data->ssp_type = platform_info->ssp_type;
+	drv_data->null_dma_buf = drv_data + sizeof(struct driver_data);
+	drv_data->null_dma_buf = (void *)(((u32)(drv_data->null_dma_buf)
+					 & 0xfffffff8) | 8);
+	/* Setup register addresses */
+	memory_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!memory_resource) {
+		dev_err(&pdev->dev, "memory resources not defined\n");
+		status = -ENODEV;
+		goto out_error_master_alloc;
+	}
+
+	drv_data->sscr0 = io_p2v(memory_resource->start + 0x00000000);
+	drv_data->sscr1 = io_p2v(memory_resource->start + 0x00000004);
+	drv_data->sssr = io_p2v(memory_resource->start + 0x00000008);
+	drv_data->ssitr = io_p2v(memory_resource->start + 0x0000000c);
+	drv_data->ssdr = io_p2v(memory_resource->start + 0x00000010);
+	drv_data->ssdr_physical = memory_resource->start + 0x00000010;
+	if (platform_info->ssp_type == PXA25x_SSP) {
+		drv_data->ssto = (u32)&bit_bucket;
+		drv_data->sspsp = (u32)&bit_bucket;
+		drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE;
+		drv_data->dma_cr1 = 0;
+		drv_data->clear_sr = SSSR_ROR;
+		drv_data->mask_sr = SSSR_RFS | SSSR_TFS | SSSR_ROR;
+	} else {
+		drv_data->ssto = io_p2v(memory_resource->start + 0x00000028);
+		drv_data->sspsp = io_p2v(memory_resource->start + 0x0000002c);
+		drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
+		drv_data->dma_cr1 = SSCR1_TSRE | SSCR1_RSRE | SSCR1_TINTE;
+		drv_data->clear_sr = SSSR_ROR | SSSR_TINT;
+		drv_data->mask_sr = SSSR_TINT | SSSR_RFS | SSSR_TFS | SSSR_ROR;
+	}
+
+	/* Attach to IRQ */
+	irq = platform_get_irq(pdev, 0);
+	if (irq == 0) {
+		dev_err(&pdev->dev, "irq resource not defined\n");
+		status = -ENODEV;
+		goto out_error_master_alloc;
+	}
+
+	status = request_irq(irq, ssp_int, SA_INTERRUPT, dev->bus_id, drv_data);
+	if (status < 0) {
+		dev_err(&pdev->dev, "can not get IRQ\n");
+		goto out_error_master_alloc;
+	}
+
+	/* Setup DMA if requested */
+	drv_data->tx_channel = -1;
+	drv_data->rx_channel = -1;
+	if (platform_info->enable_dma) {
+
+		/* Get two DMA channels	(rx and tx) */
+		drv_data->rx_channel = pxa_request_dma("pxa2xx_spi_ssp_rx",
+							DMA_PRIO_HIGH,
+							dma_handler,
+							drv_data);
+		if (drv_data->rx_channel < 0) {
+			dev_err(dev, "problem (%d) requesting rx channel\n",
+				drv_data->rx_channel);
+			status = -ENODEV;
+			goto out_error_irq_alloc;
+		}
+		drv_data->tx_channel = pxa_request_dma("pxa2xx_spi_ssp_tx",
+							DMA_PRIO_MEDIUM,
+							dma_handler,
+							drv_data);
+		if (drv_data->tx_channel < 0) {
+			dev_err(dev, "problem (%d) requesting tx channel\n",
+				drv_data->tx_channel);
+			status = -ENODEV;
+			goto out_error_dma_alloc;
+		}
+
+		switch (platform_info->ssp_type) {
+			case PXA25x_SSP:
+				DRCMRRXSSDR = DRCMR_MAPVLD
+						| drv_data->rx_channel;
+				DRCMRTXSSDR = DRCMR_MAPVLD
+						| drv_data->tx_channel;
+				break;
+			case PXA25x_NSSP:
+				DRCMRRXSS2DR = DRCMR_MAPVLD
+						| drv_data->rx_channel;
+				DRCMRTXSS2DR = DRCMR_MAPVLD
+						| drv_data->tx_channel;
+				break;
+			case PXA27x_SSP:
+				DRCMRRXSS3DR = DRCMR_MAPVLD
+						| drv_data->rx_channel;
+				DRCMRTXSS3DR = DRCMR_MAPVLD
+						| drv_data->tx_channel;
+				break;
+			default:
+				dev_err(dev, "bad SSP type\n");
+				goto out_error_dma_alloc;
+		}
+	}
+
+	/* Enable SOC clock */
+	pxa_set_cken(platform_info->clock_enable, 1);
+
+	/* Load default SSP configuration */
+	SSP_REG(drv_data->sscr0) = 0;
+	SSP_REG(drv_data->sscr1) = SSCR1_RxTresh(4) | SSCR1_TxTresh(12);
+	SSP_REG(drv_data->sscr0) = SSCR0_SerClkDiv(2)
+					| SSCR0_Motorola
+					| SSCR0_DataSize(8);
+	SSP_REG(drv_data->ssto) = 0;
+	SSP_REG(drv_data->sspsp) = 0;
+
+	/* Initial and start queue */
+	status = init_queue(drv_data);
+	if (status != 0) {
+		dev_err(&pdev->dev, "problem initializing queue\n");
+		goto out_error_clock_enabled;
+	}
+	status = start_queue(drv_data);
+	if (status != 0) {
+		dev_err(&pdev->dev, "problem starting queue\n");
+		goto out_error_clock_enabled;
+	}
+
+	/* Register with the SPI framework */
+	platform_set_drvdata(pdev, drv_data);
+	status = spi_register_master(master);
+	if (status != 0) {
+		dev_err(&pdev->dev, "problem registering spi master\n");
+		goto out_error_queue_alloc;
+	}
+
+	return status;
+
+out_error_queue_alloc:
+	destroy_queue(drv_data);
+
+out_error_clock_enabled:
+	pxa_set_cken(platform_info->clock_enable, 0);
+
+out_error_dma_alloc:
+	if (drv_data->tx_channel != -1)
+		pxa_free_dma(drv_data->tx_channel);
+	if (drv_data->rx_channel != -1)
+		pxa_free_dma(drv_data->rx_channel);
+
+out_error_irq_alloc:
+	free_irq(irq, drv_data);
+
+out_error_master_alloc:
+	(void)spi_master_put(master);
+	return status;
+}
+
+static int pxa2xx_spi_remove(struct platform_device *pdev)
+{
+	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	int irq;
+	int status = 0;
+
+	if (!drv_data)
+		return 0;
+
+	/* Remove the queue */
+	status = destroy_queue(drv_data);
+	if (status != 0)
+		return status;
+
+	/* Disable the SSP at the peripheral and SOC level */
+	SSP_REG(drv_data->sscr0) = 0;
+	pxa_set_cken(drv_data->master_info->clock_enable, 0);
+
+	/* Release DMA */
+	if (drv_data->master_info->enable_dma) {
+		switch (drv_data->ssp_type) {
+			case PXA25x_SSP:
+				DRCMRRXSSDR = 0;
+				DRCMRTXSSDR = 0;
+				break;
+			case PXA25x_NSSP:
+				DRCMRRXSS2DR = 0;
+				DRCMRTXSS2DR = 0;
+				break;
+			case PXA27x_SSP:
+				DRCMRRXSS3DR = 0;
+				DRCMRTXSS3DR = 0;
+				break;
+			default:
+				break;
+		}
+		pxa_free_dma(drv_data->tx_channel);
+		pxa_free_dma(drv_data->rx_channel);
+	}
+
+	/* Release IRQ */
+	irq = platform_get_irq(pdev, 0);
+	if (irq != 0)
+		free_irq(irq, drv_data);
+
+	/* Disconnect from the SPI framework */
+	spi_unregister_master(drv_data->master);
+
+	/* Prevent double remove */
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static void pxa2xx_spi_shutdown(struct platform_device *pdev)
+{
+	int status = 0;
+
+	if ((status = pxa2xx_spi_remove(pdev)) != 0) {
+		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
+	}
+}
+
+#ifdef CONFIG_PM
+static int stall_queue(struct driver_data *drv_data)
+{
+	unsigned long flags;
+	unsigned limit = 500;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+
+	drv_data->run = QUEUE_STALLED;
+
+	while (drv_data->busy && limit--) {
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+		msleep(10);
+		spin_lock_irqsave(&drv_data->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	if (!list_empty(&drv_data->queue) || drv_data->busy)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int suspend_devices(struct device *dev, void *pm_message)
+{
+	pm_message_t *state = pm_message;
+
+	if (dev->power.power_state.event != state->event) {
+		dev_warn(dev, "pm state does not match request\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int pxa2xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	int status = 0;
+
+	/* First forward to childern */
+	if (device_for_each_child(&pdev->dev, &state, suspend_devices) != 0) {
+		dev_warn(&pdev->dev, "suspend aborted\n");
+		return -1;
+	}
+
+	if (state.event == PM_EVENT_FREEZE) {
+		status = stall_queue(drv_data);
+		if (status != 0)
+			return status;
+	} else {
+		status = stop_queue(drv_data);
+		if (status != 0)
+			return status;
+
+		SSP_REG(drv_data->sscr0) = 0;
+		pxa_set_cken(drv_data->master_info->clock_enable, 0);
+	}
+
+	return 0;
+}
+
+static int pxa2xx_spi_resume(struct platform_device *pdev)
+{
+	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	int status = 0;
+
+	/* Enable the SSP clock */
+	pxa_set_cken(drv_data->master_info->clock_enable, 1);
+
+	/* Start the queue running */
+	status = start_queue(drv_data);
+	if (status != 0) {
+		dev_err(&pdev->dev, "problem starting queue (%d)\n", status);
+		return status;
+	}
+
+	return 0;
+}
+#else
+#define pxa2xx_spi_suspend NULL
+#define pxa2xx_spi_resume NULL
+#endif /* CONFIG_PM */
+
+static struct platform_driver driver = {
+	.driver = {
+		.name = "pxa2xx-spi",
+		.bus = &platform_bus_type,
+		.owner = THIS_MODULE,
+	},
+	.probe = pxa2xx_spi_probe,
+	.remove = __devexit_p(pxa2xx_spi_remove),
+	.shutdown = pxa2xx_spi_shutdown,
+	.suspend = pxa2xx_spi_suspend,
+	.resume = pxa2xx_spi_resume,
+};
+
+static int __init pxa2xx_spi_init(void)
+{
+	platform_driver_register(&driver);
+
+	return 0;
+}
+module_init(pxa2xx_spi_init);
+
+static void __exit pxa2xx_spi_exit(void)
+{
+	platform_driver_unregister(&driver);
+}
+module_exit(pxa2xx_spi_exit);
--- linux-2.6.16-rc2/include/asm-arm/arch-pxa/pxa2xx_spi.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-spi/include/asm-arm/arch-pxa/pxa2xx_spi.h	2006-02-06 18:39:45.345334541 -0800
@@ -0,0 +1,75 @@
+/* Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef PXA2XX_SPI_H_
+#define PXA2XX_SPI_H_
+
+#define PXA2XX_CS_ASSERT (0x01)
+#define PXA2XX_CS_DEASSERT (0x02)
+
+enum pxa_ssp_type {
+	SSP_UNDEFINED = 0,
+	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
+	PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
+	PXA27x_SSP,
+};
+
+/* device.platform_data for SSP controller devices */
+struct pxa2xx_spi_master {
+	enum pxa_ssp_type ssp_type;
+	u32 clock_enable;
+	u16 num_chipselect;
+	u8 enable_dma;
+};
+
+/* spi_board_info.controller_data for SPI slave devices,
+ * copied to spi_device.platform_data ... mostly for dma tuning
+ */
+struct pxa2xx_spi_chip {
+	u8 tx_threshold;
+	u8 rx_threshold;
+	u8 dma_burst_size;
+	u32 timeout_microsecs;
+	u8 enable_loopback;
+	void (*cs_control)(u32 command);
+};
+
+static inline void pxa2xx_dump_spi_master(struct device *dev, char *header,
+						struct pxa2xx_spi_master *info)
+{
+	dev_dbg(dev, "%s\n", header);
+	dev_dbg(dev, "    address = %p\n", info);
+	dev_dbg(dev, "    ssp_type = %d\n", info->ssp_type);
+	dev_dbg(dev, "    clock_enable = 0x%08x\n", info->clock_enable);
+	dev_dbg(dev, "    num_chipselect = 0x%04x\n", info->num_chipselect);
+	dev_dbg(dev, "    enable_dma = 0x%02x\n", info->enable_dma);
+}
+
+static inline void pxa2xx_dump_spi_chip(struct device *dev, char *header,
+						struct pxa2xx_spi_chip *info)
+{
+	dev_dbg(dev, "%s\n", header);
+	dev_dbg(dev, "    address = %p\n", info);
+	dev_dbg(dev, "    tx_threshold = 0x%02x\n", info->tx_threshold);
+	dev_dbg(dev, "    rx_threshold = 0x%02x\n", info->rx_threshold);
+	dev_dbg(dev, "    dma_bust_size = 0x%02x\n", info->dma_burst_size);
+	dev_dbg(dev, "    timeout_microsecs = 0x%08x\n", info->timeout_microsecs);
+	dev_dbg(dev, "    enable_loopback = 0x%02x\n", info->enable_loopback);
+	dev_dbg(dev, "    cs_control = %p\n", info->cs_control);
+}
+
+#endif /*PXA2XX_SPI_H_*/
--- linux-2.6.16-rc2/Documentation/spi/pxa2xx	1969-12-31 16:00:00.000000000 -0800
+++ linux-spi/Documentation/spi/pxa2xx	2006-02-06 18:39:45.360334317 -0800
@@ -0,0 +1,234 @@
+﻿PXA2xx SPI on SSP driver HOWTO
+===================================================
+This a mini howto on the pxa2xx_spi driver.  The driver turns a PXA2xx
+synchronous serial port into a SPI master controller
+(see Documentation/spi/spi_summary). The driver has the following features
+
+- Support for any PXA2xx SSP
+- SSP PIO and SSP DMA data transfers.
+- External and Internal (SSPFRM) chip selects.
+- Per slave device (chip) configuration.
+- Full suspend, freeze, resume support.
+
+The driver is built around a "spi_message" fifo serviced by workqueue and a
+tasklet. The workqueue, "pump_messages", drives message fifo and the tasklet
+(pump_transfer) is responsible for queuing SPI transactions and setting up and
+launching the dma/interrupt driven transfers.
+
+Declaring PXA2xx Master Controllers
+-----------------------------------
+Typically a SPI master is defined in the arch/.../mach-*/board-*.c as a
+"platform device".  The master configuration is passed to the driver via a table
+found in include/asm-arm/arch-pxa/pxa2xx_spi.h:
+
+struct pxa2xx_spi_master {
+	enum pxa_ssp_type ssp_type;
+	u32 clock_enable;
+	u16 num_chipselect;
+	u8 enable_dma;
+};
+
+The "pxa2xx_spi_master.ssp_type" field must have a value between 1 and 3 and
+informs the driver which features a particular SSP supports.
+
+The "pxa2xx_spi_master.clock_enable" field is used to enable/disable the
+corresponding SSP peripheral block in the "Clock Enable Register (CKEN"). See
+the "PXA2xx Developer Manual" section "Clocks and Power Management".
+
+The "pxa2xx_spi_master.num_chipselect" field is used to determine the number of
+slave device (chips) attached to this SPI master.
+
+The "pxa2xx_spi_master.enable_dma" field informs the driver that SSP DMA should
+be used.  This caused the driver to acquire two DMA channels: rx_channel and
+tx_channel.  The rx_channel has a higher DMA service priority the tx_channel.
+See the "PXA2xx Developer Manual" section "DMA Controller".
+
+NSSP MASTER SAMPLE
+------------------
+Below is a sample configuration using the PXA255 NSSP.
+
+static struct resource pxa_spi_nssp_resources[] = {
+	[0] = {
+		.start	= __PREG(SSCR0_P(2)), /* Start address of NSSP */
+		.end	= __PREG(SSCR0_P(2)) + 0x2c, /* Range of registers */
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_NSSP, /* NSSP IRQ */
+		.end	= IRQ_NSSP,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct pxa2xx_spi_master pxa_nssp_master_info = {
+	.ssp_type = PXA25x_NSSP, /* Type of SSP */
+	.clock_enable = CKEN9_NSSP, /* NSSP Peripheral clock */
+	.num_chipselect = 1, /* Matches the number of chips attached to NSSP */
+	.enable_dma = 1, /* Enables NSSP DMA */
+};
+
+static struct platform_device pxa_spi_nssp = {
+	.name = "pxa2xx-spi", /* MUST BE THIS VALUE, so device match driver */
+	.id = 2, /* Bus number, SHOULD MATCH SSP number 1..n */
+	.resource = pxa_spi_nssp_resources,
+	.num_resources = ARRAY_SIZE(pxa_spi_nssp_resources),
+	.dev = {
+		.platform_data = &pxa_nssp_master_info, /* Passed to driver */
+	},
+};
+
+static struct platform_device *devices[] __initdata = {
+	&pxa_spi_nssp,
+};
+
+static void __init board_init(void)
+{
+	(void)platform_add_device(devices, ARRAY_SIZE(devices));
+}
+
+Declaring Slave Devices
+-----------------------
+Typically each SPI slave (chip) is defined in the arch/.../mach-*/board-*.c
+using the "spi_board_info" structure found in "linux/spi/spi.h". See
+"Documentation/spi/spi_summary" for additional information.
+
+Each slave device attached to the PXA must provide slave specific configuration
+information via the structure "pxa2xx_spi_chip" found in
+"include/asm-arm/arch-pxa/pxa2xx_spi.h".  The pxa2xx_spi master controller driver
+will uses the configuration whenever the driver communicates with the slave
+device.
+
+struct pxa2xx_spi_chip {
+	u8 tx_threshold;
+	u8 rx_threshold;
+	u8 dma_burst_size;
+	u32 timeout_microsecs;
+	u8 enable_loopback;
+	void (*cs_control)(u32 command);
+};
+
+The "pxa2xx_spi_chip.tx_threshold" and "pxa2xx_spi_chip.rx_threshold" fields are
+used to configure the SSP hardware fifo.  These fields are critical to the
+performance of pxa2xx_spi driver and misconfiguration will result in rx
+fifo overruns (especially in PIO mode transfers). Good default values are
+
+	.tx_threshold = 12,
+	.rx_threshold = 4,
+
+The "pxa2xx_spi_chip.dma_burst_size" field is used to configure PXA2xx DMA
+engine and is related the "spi_device.bits_per_word" field.  Read and understand
+the PXA2xx "Developer Manual" sections on the DMA controller and SSP Controllers
+to determine the correct value. An SSP configured for byte-wide transfers would
+use a value of 8.
+
+The "pxa2xx_spi_chip.timeout_microsecs" fields is used to efficiently handle
+trailing bytes in the SSP receiver fifo.  The correct value for this field is
+dependent on the SPI bus speed ("spi_board_info.max_speed_hz") and the specific
+slave device.  Please note the the PXA2xx SSP 1 does not support trailing byte
+timeouts and must busy-wait any trailing bytes.
+
+The "pxa2xx_spi_chip.enable_loopback" field is used to place the SSP porting
+into internal loopback mode.  In this mode the SSP controller internally
+connects the SSPTX pin the the SSPRX pin.  This is useful for initial setup
+testing.
+
+The "pxa2xx_spi_chip.cs_control" field is used to point to a board specific
+function for asserting/deasserting a slave device chip select.  If the field is
+NULL, the pxa2xx_spi master controller driver assumes that the SSP port is
+configured to use SSPFRM instead.
+
+NSSP SALVE SAMPLE
+-----------------
+The pxa2xx_spi_chip structure is passed to the pxa2xx_spi driver in the
+"spi_board_info.controller_data" field. Below is a sample configuration using
+the PXA255 NSSP.
+
+/* Chip Select control for the CS8415A SPI slave device */
+static void cs8415a_cs_control(u32 command)
+{
+	if (command & PXA2XX_CS_ASSERT)
+		GPCR(2) = GPIO_bit(2);
+	else
+		GPSR(2) = GPIO_bit(2);
+}
+
+/* Chip Select control for the CS8405A SPI slave device */
+static void cs8405a_cs_control(u32 command)
+{
+	if (command & PXA2XX_CS_ASSERT)
+		GPCR(3) = GPIO_bit(3);
+	else
+		GPSR(3) = GPIO_bit(3);
+}
+
+static struct pxa2xx_spi_chip cs8415a_chip_info = {
+	.tx_threshold = 12, /* SSP hardward FIFO threshold */
+	.rx_threshold = 4, /* SSP hardward FIFO threshold */
+	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
+	.timeout_microsecs = 64, /* Wait at least 64usec to handle trailing */
+	.cs_control = cs8415a_cs_control, /* Use external chip select */
+};
+
+static struct pxa2xx_spi_chip cs8405a_chip_info = {
+	.tx_threshold = 12, /* SSP hardward FIFO threshold */
+	.rx_threshold = 4, /* SSP hardward FIFO threshold */
+	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
+	.timeout_microsecs = 64, /* Wait at least 64usec to handle trailing */
+	.cs_control = cs8405a_cs_control, /* Use external chip select */
+};
+
+static struct spi_board_info streetracer_spi_board_info[] __initdata = {
+	{
+		.modalias = "cs8415a", /* Name of spi_driver for this device */
+		.max_speed_hz = 3686400, /* Run SSP as fast a possbile */
+		.bus_num = 2, /* Framework bus number */
+		.chip_select = 0, /* Framework chip select */
+		.platform_data = NULL; /* No spi_driver specific config */
+		.controller_data = &cs8415a_chip_info, /* Master chip config */
+		.irq = STREETRACER_APCI_IRQ, /* Slave device interrupt */
+	},
+	{
+		.modalias = "cs8405a", /* Name of spi_driver for this device */
+		.max_speed_hz = 3686400, /* Run SSP as fast a possbile */
+		.bus_num = 2, /* Framework bus number */
+		.chip_select = 1, /* Framework chip select */
+		.controller_data = &cs8405a_chip_info, /* Master chip config */
+		.irq = STREETRACER_APCI_IRQ, /* Slave device interrupt */
+	},
+};
+
+static void __init streetracer_init(void)
+{
+	spi_register_board_info(streetracer_spi_board_info,
+				ARRAY_SIZE(streetracer_spi_board_info));
+}
+
+
+DMA and PIO I/O Support
+-----------------------
+The pxa2xx_spi driver support both DMA and interrupt driven PIO message
+transfers.  The driver defaults to PIO mode and DMA transfers must enabled by
+setting the "enable_dma" flag in the "pxa2xx_spi_master" structure and and
+ensuring that the "pxa2xx_spi_chip.dma_burst_size" field is non-zero.  The DMA
+mode support both coherent and stream based DMA mappings.
+
+The following logic is used to determine the type of I/O to be used on
+a per "spi_transfer" basis:
+
+if !enable_dma or dma_burst_size == 0 then
+	always use PIO transfers
+
+if spi_message.is_dma_mapped and rx_dma_buf != 0 and tx_dma_buf != 0 then
+	use coherent DMA mode
+
+if rx_buf and tx_buf are aligned on 8 byte boundary then
+	use streaming DMA mode
+
+otherwise
+	use PIO transfer
+
+THANKS TO
+---------
+
+David Brownell and others for mentoring the development of this driver.
+
