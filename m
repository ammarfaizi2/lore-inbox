Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWBKAPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWBKAPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWBKAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:15:38 -0500
Received: from [85.8.13.51] ([85.8.13.51]:36742 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932265AbWBKAPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:15:36 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 2/2] [MMC] Secure Digital Host Controller Interface driver
Date: Sat, 11 Feb 2006 01:15:26 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Message-Id: <20060211001525.10315.30769.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>
References: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for the Secure Digital Host Controller Interface specification.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 MAINTAINERS          |    7 
 drivers/mmc/Kconfig  |   11 
 drivers/mmc/Makefile |    1 
 drivers/mmc/sdhci.c  | 1243 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/sdhci.h  |  179 +++++++
 5 files changed, 1441 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b22db52..8cceada 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2474,6 +2474,13 @@ M:	kristen.c.accardi@intel.com
 L:	pcihpd-discuss@lists.sourceforge.net
 S:	Maintained
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE DRIVER
+P:	Pierre Ossman
+M:	drzeus-sdhci@drzeus.cx
+L:	sdhci-devel@list.drzeus.cx
+W:	http://mmc.drzeus.cx/wiki/Linux/Drivers/sdhci
+S:	Maintained
+
 SKGE, SKY2 10/100/1000 GIGABIT ETHERNET DRIVERS
 P:	Stephen Hemminger
 M:	shemminger@osdl.org
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index fa01b76..446b019 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -58,6 +58,17 @@ config MMC_PXA
 
 	  If unsure, say N.
 
+config MMC_SDHCI
+	tristate "Secure Digital Host Controller Interface support  (EXPERIMENTAL)"
+	depends on PCI && MMC && EXPERIMENTAL
+	help
+	  This select the generic Secure Digital Host Controller Interface.
+	  It is used by manufacturers such as Texas Instruments(R), Ricoh(R)
+	  and Toshiba(R). Most controllers found in laptops are of this type.
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_WBSD
 	tristate "Winbond W83L51xD SD/MMC Card Interface support"
 	depends on MMC && ISA_DMA_API
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index e351e71..769d545 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 #
 obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o
 obj-$(CONFIG_MMC_PXA)		+= pxamci.o
+obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
new file mode 100644
index 0000000..4e12fe0
--- /dev/null
+++ b/drivers/mmc/sdhci.c
@@ -0,0 +1,1243 @@
+/*
+ *  linux/drivers/mmc/sdhci.c - Secure Digital Host Controller Interface driver
+ *
+ *  Copyright (C) 2005-2006 Pierre Ossman, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+ /*
+  * Note that PIO transfer is rather crappy atm. The buffer full/empty
+  * interrupts aren't reliable so we currently transfer the entire buffer
+  * directly. Patches to solve the problem are welcome.
+  */
+
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/pci.h>
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/protocol.h>
+
+#include <asm/scatterlist.h>
+
+#include "sdhci.h"
+
+#define DRIVER_NAME "sdhci"
+#define DRIVER_VERSION "0.11"
+
+#define BUGMAIL "<sdhci-devel@list.drzeus.cx>"
+
+#ifdef CONFIG_MMC_DEBUG
+#define DBG(f, x...) \
+	printk(KERN_DEBUG DRIVER_NAME " [%s()]: " f, __func__,## x)
+#else
+#define DBG(f, x...) do { } while (0)
+#endif
+
+static const struct pci_device_id pci_ids[] __devinitdata = {
+	/* handle any SD host controller */
+	{PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)},
+	{ /* end: all zeroes */ },
+};
+
+MODULE_DEVICE_TABLE(pci, pci_ids);
+
+static void sdhci_prepare_data(struct sdhci_host *, struct mmc_data *);
+static void sdhci_finish_data(struct sdhci_host *);
+
+static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
+static void sdhci_finish_command(struct sdhci_host *);
+
+static void sdhci_dumpregs(struct sdhci_host *host)
+{
+	printk(KERN_DEBUG DRIVER_NAME ": ============== REGISTER DUMP ==============\n");
+
+	printk(KERN_DEBUG DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
+		readl(host->ioaddr + SDHCI_DMA_ADDRESS),
+		readw(host->ioaddr + SDHCI_HOST_VERSION));
+	printk(KERN_DEBUG DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
+		readw(host->ioaddr + SDHCI_BLOCK_SIZE),
+		readw(host->ioaddr + SDHCI_BLOCK_COUNT));
+	printk(KERN_DEBUG DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
+		readl(host->ioaddr + SDHCI_ARGUMENT),
+		readw(host->ioaddr + SDHCI_TRANSFER_MODE));
+	printk(KERN_DEBUG DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
+		readl(host->ioaddr + SDHCI_PRESENT_STATE),
+		readb(host->ioaddr + SDHCI_HOST_CONTROL));
+	printk(KERN_DEBUG DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
+		readb(host->ioaddr + SDHCI_POWER_CONTROL),
+		readb(host->ioaddr + SDHCI_BLOCK_GAP_CONTROL));
+	printk(KERN_DEBUG DRIVER_NAME ": Wake-up:  0x%08x | Clock:    0x%08x\n",
+		readb(host->ioaddr + SDHCI_WALK_UP_CONTROL),
+		readw(host->ioaddr + SDHCI_CLOCK_CONTROL));
+	printk(KERN_DEBUG DRIVER_NAME ": Timeout:  0x%08x | Int stat: 0x%08x\n",
+		readb(host->ioaddr + SDHCI_TIMEOUT_CONTROL),
+		readl(host->ioaddr + SDHCI_INT_STATUS));
+	printk(KERN_DEBUG DRIVER_NAME ": Int enab: 0x%08x | Sig enab: 0x%08x\n",
+		readl(host->ioaddr + SDHCI_INT_ENABLE),
+		readl(host->ioaddr + SDHCI_SIGNAL_ENABLE));
+	printk(KERN_DEBUG DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
+		readw(host->ioaddr + SDHCI_ACMD12_ERR),
+		readw(host->ioaddr + SDHCI_SLOT_INT_STATUS));
+	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Max curr: 0x%08x\n",
+		readl(host->ioaddr + SDHCI_CAPABILITIES),
+		readl(host->ioaddr + SDHCI_MAX_CURRENT));
+
+	printk(KERN_DEBUG DRIVER_NAME ": ===========================================\n");
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	writeb(mask, host->ioaddr + SDHCI_SOFTWARE_RESET);
+
+	if (mask & SDHCI_RESET_ALL) {
+		host->clock = 0;
+
+		mdelay(50);
+	}
+}
+
+static void sdhci_init(struct sdhci_host *host)
+{
+	u32 intmask;
+
+	sdhci_reset(host, SDHCI_RESET_ALL);
+
+	intmask = ~(SDHCI_INT_CARD_INT | SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL);
+
+	writel(intmask, host->ioaddr + SDHCI_INT_ENABLE);
+	writel(intmask, host->ioaddr + SDHCI_SIGNAL_ENABLE);
+
+	/* This is unknown magic. */
+	writeb(0xE, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
+}
+
+static void sdhci_activate_led(struct sdhci_host *host)
+{
+	u8 ctrl;
+
+	ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
+	ctrl |= SDHCI_CTRL_LED;
+	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
+}
+
+static void sdhci_deactivate_led(struct sdhci_host *host)
+{
+	u8 ctrl;
+
+	ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
+	ctrl &= ~SDHCI_CTRL_LED;
+	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Core functions                                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static inline char* sdhci_kmap_sg(struct sdhci_host* host)
+{
+	host->mapped_sg = kmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ);
+	return host->mapped_sg + host->cur_sg->offset;
+}
+
+static inline void sdhci_kunmap_sg(struct sdhci_host* host)
+{
+	kunmap_atomic(host->mapped_sg, KM_BIO_SRC_IRQ);
+}
+
+static inline int sdhci_next_sg(struct sdhci_host* host)
+{
+	/*
+	 * Skip to next SG entry.
+	 */
+	host->cur_sg++;
+	host->num_sg--;
+
+	/*
+	 * Any entries left?
+	 */
+	if (host->num_sg > 0) {
+		host->offset = 0;
+		host->remain = host->cur_sg->length;
+	}
+
+	return host->num_sg;
+}
+
+static void sdhci_transfer_pio(struct sdhci_host *host)
+{
+	char *buffer;
+	u32 mask;
+	int bytes, size;
+	unsigned long max_jiffies;
+
+	BUG_ON(!host->data);
+
+	if (host->num_sg == 0)
+		return;
+
+	bytes = 0;
+	if (host->data->flags & MMC_DATA_READ)
+		mask = SDHCI_DATA_AVAILABLE;
+	else
+		mask = SDHCI_SPACE_AVAILABLE;
+
+	buffer = sdhci_kmap_sg(host) + host->offset;
+
+	/* Transfer shouldn't take more than 5 s */
+	max_jiffies = jiffies + HZ * 5;
+
+	while (host->size > 0) {
+		if (time_after(jiffies, max_jiffies)) {
+			printk(KERN_ERR "%s: PIO transfer stalled. "
+				"Please report this to "
+				BUGMAIL ".\n", mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			host->data->error = MMC_ERR_FAILED;
+			sdhci_finish_data(host);
+			return;
+		}
+
+		if (!(readl(host->ioaddr + SDHCI_PRESENT_STATE) & mask))
+			continue;
+
+		size = min(host->size, host->remain);
+
+		if (size >= 4) {
+			if (host->data->flags & MMC_DATA_READ)
+				*(u32*)buffer = readl(host->ioaddr + SDHCI_BUFFER);
+			else
+				writel(*(u32*)buffer, host->ioaddr + SDHCI_BUFFER);
+			size = 4;
+		} else if (size >= 2) {
+			if (host->data->flags & MMC_DATA_READ)
+				*(u16*)buffer = readw(host->ioaddr + SDHCI_BUFFER);
+			else
+				writew(*(u16*)buffer, host->ioaddr + SDHCI_BUFFER);
+			size = 2;
+		} else {
+			if (host->data->flags & MMC_DATA_READ)
+				*(u8*)buffer = readb(host->ioaddr + SDHCI_BUFFER);
+			else
+				writeb(*(u8*)buffer, host->ioaddr + SDHCI_BUFFER);
+			size = 1;
+		}
+
+		buffer += size;
+		host->offset += size;
+		host->remain -= size;
+
+		bytes += size;
+		host->size -= size;
+
+		if (host->remain == 0) {
+			sdhci_kunmap_sg(host);
+			if (sdhci_next_sg(host) == 0) {
+				DBG("PIO transfer: %d bytes\n", bytes);
+				return;
+			}
+			buffer = sdhci_kmap_sg(host);
+		}
+	}
+
+	sdhci_kunmap_sg(host);
+
+	DBG("PIO transfer: %d bytes\n", bytes);
+}
+
+static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
+{
+	u16 mode;
+
+	WARN_ON(host->data);
+
+	if (data == NULL) {
+		writew(0, host->ioaddr + SDHCI_TRANSFER_MODE);
+		return;
+	}
+
+	DBG("blksz %04x blks %04x flags %08x\n",
+		1 << data->blksz_bits, data->blocks, data->flags);
+	DBG("tsac %d ms nsac %d clk\n",
+		data->timeout_ns / 1000000, data->timeout_clks);
+
+	mode = SDHCI_TRNS_BLK_CNT_EN;
+	if (data->blocks > 1)
+		mode |= SDHCI_TRNS_MULTI;
+	if (data->flags & MMC_DATA_READ)
+		mode |= SDHCI_TRNS_READ;
+	if (host->flags & SDHCI_USE_DMA)
+		mode |= SDHCI_TRNS_DMA;
+
+	writew(mode, host->ioaddr + SDHCI_TRANSFER_MODE);
+
+	writew(1 << data->blksz_bits, host->ioaddr + SDHCI_BLOCK_SIZE);
+	writew(data->blocks, host->ioaddr + SDHCI_BLOCK_COUNT);
+
+	if (host->flags & SDHCI_USE_DMA) {
+		int count;
+
+		count = pci_map_sg(host->chip->pdev, data->sg, data->sg_len,
+			(data->flags & MMC_DATA_READ)?PCI_DMA_FROMDEVICE:PCI_DMA_TODEVICE);
+		BUG_ON(count != 1);
+
+		writel(sg_dma_address(data->sg), host->ioaddr + SDHCI_DMA_ADDRESS);
+	} else {
+		host->size = (1 << data->blksz_bits) * data->blocks;
+
+		host->cur_sg = data->sg;
+		host->num_sg = data->sg_len;
+
+		host->offset = 0;
+		host->remain = host->cur_sg->length;
+	}
+}
+
+static void sdhci_finish_data(struct sdhci_host *host)
+{
+	struct mmc_data *data;
+	u32 intmask;
+	u16 blocks;
+
+	BUG_ON(!host->data);
+
+	data = host->data;
+	host->data = NULL;
+
+	if (host->flags & SDHCI_USE_DMA) {
+		pci_unmap_sg(host->chip->pdev, data->sg, data->sg_len,
+			(data->flags & MMC_DATA_READ)?PCI_DMA_FROMDEVICE:PCI_DMA_TODEVICE);
+	} else {
+		intmask = readl(host->ioaddr + SDHCI_SIGNAL_ENABLE);
+		intmask &= ~(SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL);
+		writel(intmask, host->ioaddr + SDHCI_SIGNAL_ENABLE);
+
+		intmask = readl(host->ioaddr + SDHCI_INT_ENABLE);
+		intmask &= ~(SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL);
+		writel(intmask, host->ioaddr + SDHCI_INT_ENABLE);
+	}
+
+	/*
+	 * Controller doesn't count down when in single block mode.
+	 */
+	if ((data->blocks == 1) && (data->error == MMC_ERR_NONE))
+		blocks = 0;
+	else
+		blocks = readw(host->ioaddr + SDHCI_BLOCK_COUNT);
+	data->bytes_xfered = (1 << data->blksz_bits) * (data->blocks - blocks);
+
+	if ((data->error == MMC_ERR_NONE) && blocks) {
+		printk(KERN_ERR "%s: Controller signalled completion even "
+			"though there were blocks left. Please report this "
+			"to " BUGMAIL ".\n", mmc_hostname(host->mmc));
+		data->error = MMC_ERR_FAILED;
+	}
+
+	if (host->size != 0) {
+		printk(KERN_ERR "%s: %d bytes were left untransferred. "
+			"Please report this to " BUGMAIL ".\n",
+			mmc_hostname(host->mmc), host->size);
+		data->error = MMC_ERR_FAILED;
+	}
+
+	DBG("Ending data transfer (%d bytes)\n", data->bytes_xfered);
+
+	if (data->stop) {
+		/*
+		 * The controller needs a reset of internal state machines
+		 * upon error conditions.
+		 */
+		if (data->error != MMC_ERR_NONE) {
+			sdhci_reset(host, SDHCI_RESET_CMD);
+			sdhci_reset(host, SDHCI_RESET_DATA);
+		}
+
+		sdhci_send_command(host, data->stop);
+	} else
+		tasklet_schedule(&host->finish_tasklet);
+}
+
+static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int flags;
+	u32 present;
+	unsigned long max_jiffies;
+
+	WARN_ON(host->cmd);
+
+	DBG("Sending cmd (%x)\n", cmd->opcode);
+
+	/* Wait max 10 ms */
+	max_jiffies = jiffies + (HZ + 99)/100;
+	do {
+		if (time_after(jiffies, max_jiffies)) {
+			printk(KERN_ERR "%s: Controller never released "
+				"inhibit bits. Please report this to "
+				BUGMAIL ".\n", mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			cmd->error = MMC_ERR_FAILED;
+			tasklet_schedule(&host->finish_tasklet);
+			return;
+		}
+		present = readl(host->ioaddr + SDHCI_PRESENT_STATE);
+	} while (present & (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT));
+
+	mod_timer(&host->timer, jiffies + 10 * HZ);
+
+	host->cmd = cmd;
+
+	sdhci_prepare_data(host, cmd->data);
+
+	writel(cmd->arg, host->ioaddr + SDHCI_ARGUMENT);
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		printk(KERN_ERR "%s: Unsupported response type! "
+			"Please report this to " BUGMAIL ".\n",
+			mmc_hostname(host->mmc));
+		cmd->error = MMC_ERR_INVALID;
+		tasklet_schedule(&host->finish_tasklet);
+		return;
+	}
+
+	if (!(cmd->flags & MMC_RSP_PRESENT))
+		flags = SDHCI_CMD_RESP_NONE;
+	else if (cmd->flags & MMC_RSP_136)
+		flags = SDHCI_CMD_RESP_LONG;
+	else if (cmd->flags & MMC_RSP_BUSY)
+		flags = SDHCI_CMD_RESP_SHORT_BUSY;
+	else
+		flags = SDHCI_CMD_RESP_SHORT;
+
+	if (cmd->flags & MMC_RSP_CRC)
+		flags |= SDHCI_CMD_CRC;
+	if (cmd->flags & MMC_RSP_OPCODE)
+		flags |= SDHCI_CMD_INDEX;
+	if (cmd->data)
+		flags |= SDHCI_CMD_DATA;
+
+	writel(SDHCI_MAKE_CMD(cmd->opcode, flags),
+		host->ioaddr + SDHCI_COMMAND);
+}
+
+static void sdhci_finish_command(struct sdhci_host *host)
+{
+	int i;
+
+	BUG_ON(host->cmd == NULL);
+
+	if (host->cmd->flags & MMC_RSP_PRESENT) {
+		if (host->cmd->flags & MMC_RSP_136) {
+			/* CRC is stripped so we need to do some shifting. */
+			for (i = 0;i < 4;i++) {
+				host->cmd->resp[i] = readl(host->ioaddr +
+					SDHCI_RESPONSE + (3-i)*4) << 8;
+				if (i != 3)
+					host->cmd->resp[i] |=
+						readb(host->ioaddr +
+						SDHCI_RESPONSE + (3-i)*4-1);
+			}
+		} else {
+			host->cmd->resp[0] = readl(host->ioaddr + SDHCI_RESPONSE);
+		}
+	}
+
+	host->cmd->error = MMC_ERR_NONE;
+
+	DBG("Ending cmd (%x)\n", host->cmd->opcode);
+
+	if (host->cmd->data) {
+		u32 intmask;
+
+		host->data = host->cmd->data;
+
+		if (!(host->flags & SDHCI_USE_DMA)) {
+			/*
+			 * Don't enable the interrupts until now to make sure we
+			 * get stable handling of the FIFO.
+			 */
+			intmask = readl(host->ioaddr + SDHCI_INT_ENABLE);
+			intmask |= SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL;
+			writel(intmask, host->ioaddr + SDHCI_INT_ENABLE);
+
+			intmask = readl(host->ioaddr + SDHCI_SIGNAL_ENABLE);
+			intmask |= SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL;
+			writel(intmask, host->ioaddr + SDHCI_SIGNAL_ENABLE);
+
+			/*
+			 * The buffer interrupts are to unreliable so we
+			 * start the transfer immediatly.
+			 */
+			sdhci_transfer_pio(host);
+		}
+	} else
+		tasklet_schedule(&host->finish_tasklet);
+
+	host->cmd = NULL;
+}
+
+static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	int div;
+	u16 clk;
+	unsigned long max_jiffies;
+
+	if (clock == host->clock)
+		return;
+
+	writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
+
+	if (clock == 0)
+		goto out;
+
+	for (div = 1;div < 256;div *= 2) {
+		if ((host->max_clk / div) <= clock)
+			break;
+	}
+	div >>= 1;
+
+	clk = div << SDHCI_DIVIDER_SHIFT;
+	clk |= SDHCI_CLOCK_INT_EN;
+	writew(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 10 ms */
+	max_jiffies = jiffies + (HZ + 99)/100;
+	do {
+		if (time_after(jiffies, max_jiffies)) {
+			printk(KERN_ERR "%s: Internal clock never stabilised. "
+				"Please report this to " BUGMAIL ".\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		clk = readw(host->ioaddr + SDHCI_CLOCK_CONTROL);
+	} while (!(clk & SDHCI_CLOCK_INT_STABLE));
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	writew(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
+
+out:
+	host->clock = clock;
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	WARN_ON(host->mrq != NULL);
+
+	sdhci_activate_led(host);
+
+	host->mrq = mrq;
+
+	if (!(readl(host->ioaddr + SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
+		host->mrq->cmd->error = MMC_ERR_TIMEOUT;
+		tasklet_schedule(&host->finish_tasklet);
+	} else
+		sdhci_send_command(host, mrq->cmd);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+	u8 ctrl;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	DBG("clock %uHz busmode %u powermode %u cs %u Vdd %u width %u\n",
+	     ios->clock, ios->bus_mode, ios->power_mode, ios->chip_select,
+	     ios->vdd, ios->bus_width);
+
+	/*
+	 * Reset the chip on each power off.
+	 * Should clear out any weird states.
+	 */
+	if (ios->power_mode == MMC_POWER_OFF)
+		sdhci_init(host);
+
+	sdhci_set_clock(host, ios->clock);
+
+	if (ios->power_mode == MMC_POWER_OFF)
+		writeb(0, host->ioaddr + SDHCI_POWER_CONTROL);
+	else
+		writeb(0xFF, host->ioaddr + SDHCI_POWER_CONTROL);
+
+	ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
+	if (ios->bus_width == MMC_BUS_WIDTH_4)
+		ctrl |= SDHCI_CTRL_4BITBUS;
+	else
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static int sdhci_get_ro(struct mmc_host *mmc)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+	int present;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	present = readl(host->ioaddr + SDHCI_PRESENT_STATE);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return !(present & SDHCI_WRITE_PROTECT);
+}
+
+static struct mmc_host_ops sdhci_ops = {
+	.request	= sdhci_request,
+	.set_ios	= sdhci_set_ios,
+	.get_ro		= sdhci_get_ro,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Tasklets                                                                  *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_tasklet_card(unsigned long param)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+
+	host = (struct sdhci_host*)param;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (!(readl(host->ioaddr + SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
+		if (host->mrq) {
+			printk(KERN_ERR "%s: Card removed during transfer!\n",
+				mmc_hostname(host->mmc));
+			printk(KERN_ERR "%s: Resetting controller.\n",
+				mmc_hostname(host->mmc));
+
+			sdhci_reset(host, SDHCI_RESET_CMD);
+			sdhci_reset(host, SDHCI_RESET_DATA);
+
+			host->mrq->cmd->error = MMC_ERR_FAILED;
+			tasklet_schedule(&host->finish_tasklet);
+		}
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	mmc_detect_change(host->mmc, msecs_to_jiffies(500));
+}
+
+static void sdhci_tasklet_finish(unsigned long param)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+	struct mmc_request *mrq;
+
+	host = (struct sdhci_host*)param;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	del_timer(&host->timer);
+
+	mrq = host->mrq;
+
+	DBG("Ending request, cmd (%x)\n", mrq->cmd->opcode);
+
+	/*
+	 * The controller needs a reset of internal state machines
+	 * upon error conditions.
+	 */
+	if ((mrq->cmd->error != MMC_ERR_NONE) ||
+		(mrq->data && ((mrq->data->error != MMC_ERR_NONE) ||
+		(mrq->data->stop && (mrq->data->stop->error != MMC_ERR_NONE))))) {
+		sdhci_reset(host, SDHCI_RESET_CMD);
+		sdhci_reset(host, SDHCI_RESET_DATA);
+	}
+
+	host->mrq = NULL;
+	host->cmd = NULL;
+	host->data = NULL;
+
+	sdhci_deactivate_led(host);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	mmc_request_done(host->mmc, mrq);
+}
+
+static void sdhci_timeout_timer(unsigned long data)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+
+	host = (struct sdhci_host*)data;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->mrq) {
+		printk(KERN_ERR "%s: Timeout waiting for hardware interrupt. "
+			"Please report this to " BUGMAIL ".\n",
+			mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+
+		if (host->data) {
+			host->data->error = MMC_ERR_TIMEOUT;
+			sdhci_finish_data(host);
+		} else {
+			if (host->cmd)
+				host->cmd->error = MMC_ERR_TIMEOUT;
+			else
+				host->mrq->cmd->error = MMC_ERR_TIMEOUT;
+
+			tasklet_schedule(&host->finish_tasklet);
+		}
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Interrupt handling                                                        *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
+{
+	BUG_ON(intmask == 0);
+
+	if (!host->cmd) {
+		printk(KERN_ERR "%s: Got command interrupt even though no "
+			"command operation was in progress.\n",
+			mmc_hostname(host->mmc));
+		printk(KERN_ERR "%s: Please report this to " BUGMAIL ".\n",
+			mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return;
+	}
+
+	if (intmask & SDHCI_INT_RESPONSE)
+		sdhci_finish_command(host);
+	else {
+		if (intmask & SDHCI_INT_TIMEOUT)
+			host->cmd->error = MMC_ERR_TIMEOUT;
+		else if (intmask & SDHCI_INT_CRC)
+			host->cmd->error = MMC_ERR_BADCRC;
+		else if (intmask & (SDHCI_INT_END_BIT | SDHCI_INT_INDEX))
+			host->cmd->error = MMC_ERR_FAILED;
+		else
+			host->cmd->error = MMC_ERR_INVALID;
+
+		tasklet_schedule(&host->finish_tasklet);
+	}
+}
+
+static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
+{
+	BUG_ON(intmask == 0);
+
+	if (!host->data) {
+		/*
+		 * A data end interrupt is sent together with the response
+		 * for the stop command.
+		 */
+		if (intmask & SDHCI_INT_DATA_END)
+			return;
+
+		printk(KERN_ERR "%s: Got data interrupt even though no "
+			"data operation was in progress.\n",
+			mmc_hostname(host->mmc));
+		printk(KERN_ERR "%s: Please report this to " BUGMAIL ".\n",
+			mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+
+		return;
+	}
+
+	if (intmask & SDHCI_INT_DATA_TIMEOUT)
+		host->data->error = MMC_ERR_TIMEOUT;
+	else if (intmask & SDHCI_INT_DATA_CRC)
+		host->data->error = MMC_ERR_BADCRC;
+	else if (intmask & SDHCI_INT_DATA_END_BIT)
+		host->data->error = MMC_ERR_FAILED;
+
+	if (host->data->error != MMC_ERR_NONE)
+		sdhci_finish_data(host);
+	else {
+		if (intmask & (SDHCI_INT_BUF_FULL | SDHCI_INT_BUF_EMPTY))
+			sdhci_transfer_pio(host);
+
+		if (intmask & SDHCI_INT_DATA_END)
+			sdhci_finish_data(host);
+	}
+}
+
+static irqreturn_t sdhci_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	irqreturn_t result;
+	struct sdhci_host* host = dev_id;
+	u32 intmask;
+
+	spin_lock(&host->lock);
+
+	intmask = readl(host->ioaddr + SDHCI_INT_STATUS);
+
+	if (!intmask) {
+		result = IRQ_NONE;
+		goto out;
+	}
+
+	DBG("*** %s got interrupt: 0x%08x\n", host->slot_descr, intmask);
+
+	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE))
+		tasklet_schedule(&host->card_tasklet);
+
+	if (intmask & SDHCI_INT_CMD_MASK) {
+		sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
+
+		writel(intmask & SDHCI_INT_CMD_MASK,
+			host->ioaddr + SDHCI_INT_STATUS);
+	}
+
+	if (intmask & SDHCI_INT_DATA_MASK) {
+		sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
+
+		writel(intmask & SDHCI_INT_DATA_MASK,
+			host->ioaddr + SDHCI_INT_STATUS);
+	}
+
+	intmask &= ~(SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK);
+
+	if (intmask & SDHCI_INT_CARD_INT) {
+		printk(KERN_ERR "%s: Unexpected card interrupt. Please "
+			"report this to " BUGMAIL ".\n",
+			mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+	}
+
+	if (intmask & SDHCI_INT_BUS_POWER) {
+		printk(KERN_ERR "%s: Unexpected bus power interrupt. Please "
+			"report this to " BUGMAIL ".\n",
+			mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+	}
+
+	if (intmask & SDHCI_INT_ACMD12ERR) {
+		printk(KERN_ERR "%s: Unexpected auto CMD12 error. Please "
+			"report this to " BUGMAIL ".\n",
+			mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+
+		writew(~0, host->ioaddr + SDHCI_ACMD12_ERR);
+	}
+
+	if (intmask)
+		writel(intmask, host->ioaddr + SDHCI_INT_STATUS);
+
+	result = IRQ_HANDLED;
+
+out:
+	spin_unlock(&host->lock);
+
+	return result;
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Suspend/resume                                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+#ifdef CONFIG_PM
+
+static int sdhci_suspend (struct pci_dev *pdev, pm_message_t state)
+{
+	struct sdhci_chip *chip;
+	int i, ret;
+
+	chip = pci_get_drvdata(pdev);
+	if (!chip)
+		return 0;
+
+	DBG("Suspending...\n");
+
+	for (i = 0;i < chip->num_slots;i++) {
+		if (!chip->hosts[i])
+			continue;
+		ret = mmc_suspend_host(chip->hosts[i]->mmc, state);
+		if (ret) {
+			for (i--;i >= 0;i--)
+				mmc_resume_host(chip->hosts[i]->mmc);
+			return ret;
+		}
+	}
+
+	pci_save_state(pdev);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+
+	return 0;
+}
+
+static int sdhci_resume (struct pci_dev *pdev)
+{
+	struct sdhci_chip *chip;
+	int i, ret;
+
+	chip = pci_get_drvdata(pdev);
+	if (!chip)
+		return 0;
+
+	DBG("Resuming...\n");
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+
+	for (i = 0;i < chip->num_slots;i++) {
+		if (!chip->hosts[i])
+			continue;
+		if (chip->hosts[i]->flags & SDHCI_USE_DMA)
+			pci_set_master(pdev);
+		sdhci_init(chip->hosts[i]);
+		ret = mmc_resume_host(chip->hosts[i]->mmc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+#else /* CONFIG_PM */
+
+#define sdhci_suspend NULL
+#define sdhci_resume NULL
+
+#endif /* CONFIG_PM */
+
+/*****************************************************************************\
+ *                                                                           *
+ * Device probing/removal                                                    *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __devinit sdhci_probe_slot(struct pci_dev *pdev, int slot)
+{
+	int ret;
+	struct sdhci_chip *chip;
+	struct mmc_host *mmc;
+	struct sdhci_host *host;
+
+	u8 first_bar;
+	unsigned int caps;
+
+	chip = pci_get_drvdata(pdev);
+	BUG_ON(!chip);
+
+	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
+	if (ret)
+		return ret;
+
+	first_bar &= PCI_SLOT_INFO_FIRST_BAR_MASK;
+
+	mmc = mmc_alloc_host(sizeof(struct sdhci_host), &pdev->dev);
+	if (!mmc)
+		return -ENOMEM;
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+
+	host->bar = first_bar + slot;
+
+	host->addr = pci_resource_start(pdev, host->bar);
+	host->irq = pdev->irq;
+
+	DBG("slot %d at 0x%08lx, irq %d\n", slot, host->addr, host->irq);
+
+	BUG_ON(!(pci_resource_flags(pdev, first_bar + slot) & IORESOURCE_MEM));
+
+	snprintf(host->slot_descr, 20, "sdhci:slot%d", slot);
+
+	ret = pci_request_region(pdev, host->bar, host->slot_descr);
+	if (ret)
+		goto free;
+
+	host->ioaddr = ioremap_nocache(host->addr,
+		pci_resource_len(pdev, host->bar));
+	if (!host->ioaddr) {
+		ret = -ENOMEM;
+		goto release;
+	}
+
+	ret = request_irq(host->irq, sdhci_irq, SA_SHIRQ,
+		host->slot_descr, host);
+	if (ret)
+		goto unmap;
+
+	caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
+
+	if ((caps & SDHCI_CAN_DO_DMA) && ((pdev->class & 0x0000FF) == 0x01))
+		host->flags |= SDHCI_USE_DMA;
+
+	if (host->flags & SDHCI_USE_DMA) {
+		if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
+			printk(KERN_WARNING "%s: No suitable DMA available. "
+				"Falling back to PIO.\n", host->slot_descr);
+			host->flags &= ~SDHCI_USE_DMA;
+		}
+	}
+
+	if (host->flags & SDHCI_USE_DMA)
+		pci_set_master(pdev);
+	else /* XXX: Hack to get MMC layer to avoid highmem */
+		pdev->dma_mask = 0;
+
+	host->max_clk = (caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
+	host->max_clk *= 1000000;
+
+	/*
+	 * Set host parameters.
+	 */
+	mmc->ops = &sdhci_ops;
+	mmc->f_min = host->max_clk / 256;
+	mmc->f_max = host->max_clk;
+	mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
+	mmc->caps = MMC_CAP_4_BIT_DATA;
+
+	spin_lock_init(&host->lock);
+
+	/*
+	 * Maximum number of segments. Hardware cannot do scatter lists.
+	 */
+	if (host->flags & SDHCI_USE_DMA)
+		mmc->max_hw_segs = 1;
+	else
+		mmc->max_hw_segs = 16;
+	mmc->max_phys_segs = 16;
+
+	/*
+	 * Maximum number of sectors in one transfer. Limited by sector
+	 * count register.
+	 */
+	mmc->max_sectors = 0x3FFF;
+
+	/*
+	 * Maximum segment size. Could be one segment with the maximum number
+	 * of sectors.
+	 */
+	mmc->max_seg_size = mmc->max_sectors * 512;
+
+	/*
+	 * Init tasklets.
+	 */
+	tasklet_init(&host->card_tasklet,
+		sdhci_tasklet_card, (unsigned long)host);
+	tasklet_init(&host->finish_tasklet,
+		sdhci_tasklet_finish, (unsigned long)host);
+
+	init_timer(&host->timer);
+	host->timer.data = (unsigned long)host;
+	host->timer.function = sdhci_timeout_timer;
+
+	sdhci_init(host);
+
+#ifdef CONFIG_MMC_DEBUG
+	sdhci_dumpregs(host);
+#endif
+
+	host->chip = chip;
+	chip->hosts[slot] = host;
+
+	mmc_add_host(mmc);
+
+	printk(KERN_INFO "%s: SDHCI at 0x%08lx irq %d %s\n", mmc_hostname(mmc),
+		host->addr, host->irq,
+		(host->flags & SDHCI_USE_DMA)?"DMA":"PIO");
+
+	return 0;
+
+unmap:
+	iounmap(host->ioaddr);
+release:
+	pci_release_region(pdev, host->bar);
+free:
+	mmc_free_host(mmc);
+
+	return ret;
+}
+
+static void sdhci_remove_slot(struct pci_dev *pdev, int slot)
+{
+	struct sdhci_chip *chip;
+	struct mmc_host *mmc;
+	struct sdhci_host *host;
+
+	chip = pci_get_drvdata(pdev);
+	host = chip->hosts[slot];
+	mmc = host->mmc;
+
+	chip->hosts[slot] = NULL;
+
+	mmc_remove_host(mmc);
+
+	del_timer_sync(&host->timer);
+
+	sdhci_reset(host, SDHCI_RESET_ALL);
+
+	tasklet_kill(&host->card_tasklet);
+	tasklet_kill(&host->finish_tasklet);
+
+	iounmap(host->ioaddr);
+
+	pci_release_region(pdev, host->bar);
+
+	free_irq(host->irq, host);
+
+	mmc_free_host(mmc);
+}
+
+static int __devinit sdhci_probe(struct pci_dev *pdev,
+	const struct pci_device_id *ent)
+{
+	int ret, i;
+	u8 slots;
+	struct sdhci_chip *chip;
+
+	BUG_ON(pdev == NULL);
+	BUG_ON(ent == NULL);
+
+	DBG("found at %s\n", pci_name(pdev));
+
+	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
+	if (ret)
+		return ret;
+
+	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
+	DBG("found %d slot(s)\n", slots);
+	if (slots == 0)
+		return -ENODEV;
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	chip = kzalloc(sizeof(struct sdhci_chip) +
+		sizeof(sdhci_host_p) * slots, GFP_KERNEL);
+	if (!chip) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	chip->pdev = pdev;
+
+	chip->num_slots = slots;
+	pci_set_drvdata(pdev, chip);
+
+	for (i = 0;i < slots;i++) {
+		ret = sdhci_probe_slot(pdev, i);
+		if (ret) {
+			for (i--;i >= 0;i--)
+				sdhci_remove_slot(pdev, i);
+			goto free;
+		}
+	}
+
+	return 0;
+
+free:
+	pci_set_drvdata(pdev, NULL);
+	kfree(chip);
+
+err:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static void __devexit sdhci_remove(struct pci_dev *pdev)
+{
+	int i;
+	struct sdhci_chip *chip;
+
+	chip = pci_get_drvdata(pdev);
+
+	if (chip) {
+		for (i = 0;i < chip->num_slots;i++)
+			sdhci_remove_slot(pdev, i);
+
+		pci_set_drvdata(pdev, NULL);
+
+		kfree(chip);
+	}
+
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver sdhci_driver = {
+	.name = 	DRIVER_NAME,
+	.id_table =	pci_ids,
+	.probe = 	sdhci_probe,
+	.remove =	__devexit_p(sdhci_remove),
+	.suspend =	sdhci_suspend,
+	.resume	=	sdhci_resume,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Driver init/exit                                                          *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __init sdhci_drv_init(void)
+{
+	printk(KERN_INFO DRIVER_NAME
+		": Secure Digital Host Controller Interface driver, "
+		DRIVER_VERSION "\n");
+	printk(KERN_INFO DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
+
+	return pci_register_driver(&sdhci_driver);
+}
+
+static void __exit sdhci_drv_exit(void)
+{
+	DBG("Exiting\n");
+
+	pci_unregister_driver(&sdhci_driver);
+}
+
+module_init(sdhci_drv_init);
+module_exit(sdhci_drv_exit);
+
+MODULE_AUTHOR("Pierre Ossman <drzeus@drzeus.cx>");
+MODULE_DESCRIPTION("Secure Digital Host Controller Interface driver");
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
new file mode 100644
index 0000000..286d4d1
--- /dev/null
+++ b/drivers/mmc/sdhci.h
@@ -0,0 +1,179 @@
+/*
+ *  linux/drivers/mmc/sdhci.h - Secure Digital Host Controller Interface driver
+ *
+ *  Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Controller registers
+ */
+
+#define SDHCI_DMA_ADDRESS	0x00
+
+#define SDHCI_BLOCK_SIZE	0x04
+
+#define SDHCI_BLOCK_COUNT	0x06
+
+#define SDHCI_ARGUMENT		0x08
+
+#define SDHCI_TRANSFER_MODE	0x0C
+#define  SDHCI_TRNS_DMA		0x01
+#define  SDHCI_TRNS_BLK_CNT_EN	0x02
+#define  SDHCI_TRNS_ACMD12	0x04
+#define  SDHCI_TRNS_READ	0x10
+#define  SDHCI_TRNS_MULTI	0x20
+
+#define SDHCI_COMMAND		0x0E
+#define  SDHCI_CMD_RESP_MASK	0x03
+#define  SDHCI_CMD_CRC		0x08
+#define  SDHCI_CMD_INDEX	0x10
+#define  SDHCI_CMD_DATA		0x20
+
+#define  SDHCI_CMD_RESP_NONE	0x00
+#define  SDHCI_CMD_RESP_LONG	0x01
+#define  SDHCI_CMD_RESP_SHORT	0x02
+#define  SDHCI_CMD_RESP_SHORT_BUSY 0x03
+
+#define SDHCI_MAKE_CMD(c, f) (((c & 0xff) << 8) | (f & 0xff))
+
+#define SDHCI_RESPONSE		0x10
+
+#define SDHCI_BUFFER		0x20
+
+#define SDHCI_PRESENT_STATE	0x24
+#define  SDHCI_CMD_INHIBIT	0x00000001
+#define  SDHCI_DATA_INHIBIT	0x00000002
+#define  SDHCI_DOING_WRITE	0x00000100
+#define  SDHCI_DOING_READ	0x00000200
+#define  SDHCI_SPACE_AVAILABLE	0x00000400
+#define  SDHCI_DATA_AVAILABLE	0x00000800
+#define  SDHCI_CARD_PRESENT	0x00010000
+#define  SDHCI_WRITE_PROTECT	0x00080000
+
+#define SDHCI_HOST_CONTROL 	0x28
+#define  SDHCI_CTRL_LED		0x01
+#define  SDHCI_CTRL_4BITBUS	0x02
+
+#define SDHCI_POWER_CONTROL	0x29
+
+#define SDHCI_BLOCK_GAP_CONTROL	0x2A
+
+#define SDHCI_WALK_UP_CONTROL	0x2B
+
+#define SDHCI_CLOCK_CONTROL	0x2C
+#define  SDHCI_DIVIDER_SHIFT	8
+#define  SDHCI_CLOCK_CARD_EN	0x0004
+#define  SDHCI_CLOCK_INT_STABLE	0x0002
+#define  SDHCI_CLOCK_INT_EN	0x0001
+
+#define SDHCI_TIMEOUT_CONTROL	0x2E
+
+#define SDHCI_SOFTWARE_RESET	0x2F
+#define  SDHCI_RESET_ALL	0x01
+#define  SDHCI_RESET_CMD	0x02
+#define  SDHCI_RESET_DATA	0x04
+
+#define SDHCI_INT_STATUS	0x30
+#define SDHCI_INT_ENABLE	0x34
+#define SDHCI_SIGNAL_ENABLE	0x38
+#define  SDHCI_INT_RESPONSE	0x00000001
+#define  SDHCI_INT_DATA_END	0x00000002
+#define  SDHCI_INT_DMA_END	0x00000008
+#define  SDHCI_INT_BUF_EMPTY	0x00000010
+#define  SDHCI_INT_BUF_FULL	0x00000020
+#define  SDHCI_INT_CARD_INSERT	0x00000040
+#define  SDHCI_INT_CARD_REMOVE	0x00000080
+#define  SDHCI_INT_CARD_INT	0x00000100
+#define  SDHCI_INT_TIMEOUT	0x00010000
+#define  SDHCI_INT_CRC		0x00020000
+#define  SDHCI_INT_END_BIT	0x00040000
+#define  SDHCI_INT_INDEX	0x00080000
+#define  SDHCI_INT_DATA_TIMEOUT	0x00100000
+#define  SDHCI_INT_DATA_CRC	0x00200000
+#define  SDHCI_INT_DATA_END_BIT	0x00400000
+#define  SDHCI_INT_BUS_POWER	0x00800000
+#define  SDHCI_INT_ACMD12ERR	0x01000000
+
+#define  SDHCI_INT_NORMAL_MASK	0x00007FFF
+#define  SDHCI_INT_ERROR_MASK	0xFFFF8000
+
+#define  SDHCI_INT_CMD_MASK	(SDHCI_INT_RESPONSE | SDHCI_INT_TIMEOUT | \
+		SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX)
+#define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
+		SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL | \
+		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
+		SDHCI_INT_DATA_END_BIT)
+
+#define SDHCI_ACMD12_ERR	0x3C
+
+/* 3E-3F reserved */
+
+#define SDHCI_CAPABILITIES	0x40
+#define  SDHCI_CAN_DO_DMA	0x00400000
+#define  SDHCI_CLOCK_BASE_MASK	0x00003F00
+#define  SDHCI_CLOCK_BASE_SHIFT	8
+
+/* 44-47 reserved for more caps */
+
+#define SDHCI_MAX_CURRENT	0x48
+
+/* 4C-4F reserved for more max current */
+
+/* 50-FB reserved */
+
+#define SDHCI_SLOT_INT_STATUS	0xFC
+
+#define SDHCI_HOST_VERSION	0xFE
+
+struct sdhci_chip;
+
+struct sdhci_host {
+	struct sdhci_chip	*chip;
+	struct mmc_host		*mmc;		/* MMC structure */
+
+	spinlock_t		lock;		/* Mutex */
+
+	int			flags;		/* Host attributes */
+#define SDHCI_USE_DMA		(1<<0)
+
+	unsigned int		max_clk;	/* Max possible freq (MHz) */
+
+	unsigned int		clock;		/* Current clock (MHz) */
+
+	struct mmc_request	*mrq;		/* Current request */
+	struct mmc_command	*cmd;		/* Current command */
+	struct mmc_data		*data;		/* Current data request */
+
+	struct scatterlist	*cur_sg;	/* We're working on this */
+	char			*mapped_sg;	/* This is where it's mapped */
+	int			num_sg;		/* Entries left */
+	int			offset;		/* Offset into current sg */
+	int			remain;		/* Bytes left in current */
+
+	int			size;		/* Remaining bytes in transfer */
+
+	char			slot_descr[20];	/* Name for reservations */
+
+	int			irq;		/* Device IRQ */
+	int			bar;		/* PCI BAR index */
+	unsigned long		addr;		/* Bus address */
+	void __iomem *		ioaddr;		/* Mapped address */
+
+	struct tasklet_struct	card_tasklet;	/* Tasklet structures */
+	struct tasklet_struct	finish_tasklet;
+
+	struct timer_list	timer;		/* Timer for timeouts */
+};
+
+typedef struct sdhci_host *sdhci_host_p;
+
+struct sdhci_chip {
+	struct pci_dev		*pdev;
+
+	int			num_slots;	/* Slots on controller */
+	sdhci_host_p		hosts[0];	/* Pointers to hosts */
+};

