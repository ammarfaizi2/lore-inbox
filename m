Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVDAHjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVDAHjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVDAHjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:39:47 -0500
Received: from a25.t1.student.liu.se ([130.236.221.25]:4752 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S262655AbVDAHhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:37:32 -0500
Message-ID: <424CFA19.9020803@drzeus.cx>
Date: Fri, 01 Apr 2005 09:36:57 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.1 (X11/20050323)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-14864-1112345723-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wbsd update
References: <42408E3F.5040509@drzeus.cx> <20050324155014.C4189@flint.arm.linux.org.uk>
In-Reply-To: <20050324155014.C4189@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-14864-1112345723-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Russell King wrote:

>Please use platform_device_register_simple() instead of providing a buggy
>release function.
>
>  
>
>You might like to consider using mmc->dev instead of duplicating it
>here.
>
>  
>

Sorry about the delay. It's been a rather busy week. Included is the
same patch with the two issues above fixed.

Rgds
Pierre


--=_hermes.drzeus.cx-14864-1112345723-0001-2
Content-Type: text/plain; name="wbsd-2.6.11-3.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-2.6.11-3.patch"

Index: linux/drivers/mmc/wbsd.c
===================================================================
--- linux/drivers/mmc/wbsd.c	(revision 132)
+++ linux/drivers/mmc/wbsd.c	(working copy)
@@ -28,7 +28,9 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/pnp.h>
 #include <linux/highmem.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/protocol.h>
@@ -40,7 +42,7 @@
 #include "wbsd.h"
 
 #define DRIVER_NAME "wbsd"
-#define DRIVER_VERSION "1.1"
+#define DRIVER_VERSION "1.2"
 
 #ifdef CONFIG_MMC_DEBUG
 #define DBG(x...) \
@@ -52,10 +54,6 @@
 #define DBGF(x...)	do { } while (0)
 #endif
 
-static unsigned int io = 0x248;
-static unsigned int irq = 6;
-static int dma = 2;
-
 #ifdef CONFIG_MMC_DEBUG
 void DBG_REG(int reg, u8 value)
 {
@@ -79,28 +77,61 @@
 #endif
 
 /*
+ * Device resources
+ */
+
+#ifdef CONFIG_PNP
+
+static const struct pnp_device_id pnp_dev_table[] = {
+	{ "WEC0517", 0 },
+	{ "WEC0518", 0 },
+	{ "", 0 },
+};
+
+MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
+
+#endif /* CONFIG_PNP */
+
+#ifdef CONFIG_PNP
+static unsigned int nopnp = 0;
+#else
+static const unsigned int nopnp = 1;
+#endif
+static unsigned int io = 0x248;
+static unsigned int irq = 6;
+static int dma = 2;
+
+/*
  * Basic functions
  */
 
 static inline void wbsd_unlock_config(struct wbsd_host* host)
 {
+	BUG_ON(host->config == 0);
+	
 	outb(host->unlock_code, host->config);
 	outb(host->unlock_code, host->config);
 }
 
 static inline void wbsd_lock_config(struct wbsd_host* host)
 {
+	BUG_ON(host->config == 0);
+	
 	outb(LOCK_CODE, host->config);
 }
 
 static inline void wbsd_write_config(struct wbsd_host* host, u8 reg, u8 value)
 {
+	BUG_ON(host->config == 0);
+	
 	outb(reg, host->config);
 	outb(value, host->config + 1);
 }
 
 static inline u8 wbsd_read_config(struct wbsd_host* host, u8 reg)
 {
+	BUG_ON(host->config == 0);
+	
 	outb(reg, host->config);
 	return inb(host->config + 1);
 }
@@ -133,6 +164,13 @@
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
 	
 	/*
+	 * Set DAT3 to input
+	 */
+	setup &= ~WBSD_DAT3_H;
+	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
+	host->flags &= ~WBSD_FIGNORE_DETECT;
+	
+	/*
 	 * Read back default clock.
 	 */
 	host->clk = wbsd_read_index(host, WBSD_IDX_CLK);
@@ -148,6 +186,14 @@
 	wbsd_write_index(host, WBSD_IDX_TAAC, 0x7F);
 	
 	/*
+	 * Test for card presence
+	 */
+	if (inb(host->base + WBSD_CSR) & WBSD_CARDPRESENT)
+		host->flags |= WBSD_FCARD_PRESENT;
+	else
+		host->flags &= ~WBSD_FCARD_PRESENT;
+	
+	/*
 	 * Enable interesting interrupts.
 	 */
 	ier = 0;
@@ -407,8 +453,6 @@
 	}
 }
 
-static irqreturn_t wbsd_irq(int irq, void *dev_id, struct pt_regs *regs);
-
 static void wbsd_send_command(struct wbsd_host* host, struct mmc_command* cmd)
 {
 	int i;
@@ -646,6 +690,13 @@
 	}
 	
 	wbsd_kunmap_sg(host);
+	
+	/*
+	 * The controller stops sending interrupts for
+	 * 'FIFO empty' under certain conditions. So we
+	 * need to be a bit more pro-active.
+	 */
+	tasklet_schedule(&host->fifo_tasklet);
 }
 
 static void wbsd_prepare_data(struct wbsd_host* host, struct mmc_data* data)
@@ -850,9 +901,11 @@
 	wbsd_request_end(host, host->mrq);
 }
 
-/*
- * MMC Callbacks
- */
+/*****************************************************************************\
+ *                                                                           *
+ * MMC layer callbacks                                                       *
+ *                                                                           *
+\*****************************************************************************/
 
 static void wbsd_request(struct mmc_host* mmc, struct mmc_request* mrq)
 {
@@ -874,7 +927,7 @@
 	 * If there is no card in the slot then
 	 * timeout immediatly.
 	 */
-	if (!(inb(host->base + WBSD_CSR) & WBSD_CARDPRESENT))
+	if (!(host->flags & WBSD_FCARD_PRESENT))
 	{
 		cmd->error = MMC_ERR_TIMEOUT;
 		goto done;
@@ -953,33 +1006,50 @@
 		host->clk = clk;
 	}
 
+	/*
+	 * Power up card.
+	 */
 	if (ios->power_mode != MMC_POWER_OFF)
 	{
-		/*
-		 * Power up card.
-		 */
 		pwr = inb(host->base + WBSD_CSR);
 		pwr &= ~WBSD_POWER_N;
 		outb(pwr, host->base + WBSD_CSR);
+	}
 
-		/*
-		 * This behaviour is stolen from the
-		 * Windows driver. Don't know why, but
-		 * it is needed.
-		 */
-		setup = wbsd_read_index(host, WBSD_IDX_SETUP);
-		if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
-			setup |= WBSD_DAT3_H;
-		else
-			setup &= ~WBSD_DAT3_H;
-		wbsd_write_index(host, WBSD_IDX_SETUP, setup);
-
-		mdelay(1);
+	/*
+	 * MMC cards need to have pin 1 high during init.
+	 * Init time corresponds rather nicely with the bus mode.
+	 * It wreaks havoc with the card detection though so
+	 * that needs to be disabed.
+	 */
+	setup = wbsd_read_index(host, WBSD_IDX_SETUP);
+	if ((ios->power_mode == MMC_POWER_ON) &&
+		(ios->bus_mode == MMC_BUSMODE_OPENDRAIN))
+	{
+		setup |= WBSD_DAT3_H;
+		host->flags |= WBSD_FIGNORE_DETECT;
 	}
-
+	else
+	{
+		setup &= ~WBSD_DAT3_H;
+		host->flags &= ~WBSD_FIGNORE_DETECT;
+	}
+	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
+	
 	spin_unlock_bh(&host->lock);
 }
 
+static struct mmc_host_ops wbsd_ops = {
+	.request	= wbsd_request,
+	.set_ios	= wbsd_set_ios,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Interrupt handling                                                        *
+ *                                                                           *
+\*****************************************************************************/
+
 /*
  * Tasklets
  */
@@ -1005,17 +1075,33 @@
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	u8 csr;
+	int change = 0;
 	
 	spin_lock(&host->lock);
 	
+	if (host->flags & WBSD_FIGNORE_DETECT)
+	{
+		spin_unlock(&host->lock);
+		return;
+	}
+	
 	csr = inb(host->base + WBSD_CSR);
 	WARN_ON(csr == 0xff);
 	
 	if (csr & WBSD_CARDPRESENT)
-		DBG("Card inserted\n");
-	else
 	{
+		if (!(host->flags & WBSD_FCARD_PRESENT))
+		{
+			DBG("Card inserted\n");
+			host->flags |= WBSD_FCARD_PRESENT;
+			change = 1;
+		}
+	}
+	else if (host->flags & WBSD_FCARD_PRESENT)
+	{
 		DBG("Card removed\n");
+		host->flags &= ~WBSD_FCARD_PRESENT;
+		change = 1;
 		
 		if (host->mrq)
 		{
@@ -1033,7 +1119,8 @@
 	 */
 	spin_unlock(&host->lock);
 
-	mmc_detect_change(host->mmc);
+	if (change)
+		mmc_detect_change(host->mmc);
 }
 
 static void wbsd_tasklet_fifo(unsigned long param)
@@ -1200,12 +1287,86 @@
 	return IRQ_HANDLED;
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * Device initialisation and shutdown                                        *
+ *                                                                           *
+\*****************************************************************************/
+
 /*
- * Support functions for probe
+ * Allocate/free MMC structure.
  */
 
-static int wbsd_scan(struct wbsd_host* host)
+static int __devinit wbsd_alloc_mmc(struct device* dev)
 {
+	struct mmc_host* mmc;
+	struct wbsd_host* host;
+	
+	/*
+	 * Allocate MMC structure.
+	 */
+	mmc = mmc_alloc_host(sizeof(struct wbsd_host), dev);
+	if (!mmc)
+		return -ENOMEM;
+	
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+
+	host->dma = -1;
+
+	/*
+	 * Set host parameters.
+	 */
+	mmc->ops = &wbsd_ops;
+	mmc->f_min = 375000;
+	mmc->f_max = 24000000;
+	mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
+	
+	spin_lock_init(&host->lock);
+	
+	/*
+	 * Maximum number of segments. Worst case is one sector per segment
+	 * so this will be 64kB/512.
+	 */
+	mmc->max_hw_segs = 128;
+	mmc->max_phys_segs = 128;
+	
+	/*
+	 * Maximum number of sectors in one transfer. Also limited by 64kB
+	 * buffer.
+	 */
+	mmc->max_sectors = 128;
+	
+	/*
+	 * Maximum segment size. Could be one segment with the maximum number
+	 * of segments.
+	 */
+	mmc->max_seg_size = mmc->max_sectors * 512;
+	
+	dev_set_drvdata(dev, mmc);
+	
+	return 0;
+}
+
+static void __devexit wbsd_free_mmc(struct device* dev)
+{
+	struct mmc_host* mmc;
+	
+	mmc = dev_get_drvdata(dev);
+	if (!mmc)
+		return;
+	
+	mmc_free_host(mmc);
+	
+	dev_set_drvdata(dev, NULL);
+}
+
+/*
+ * Scan for known chip id:s
+ */
+
+static int __devinit wbsd_scan(struct wbsd_host* host)
+{
 	int i, j, k;
 	int id;
 	
@@ -1258,12 +1419,16 @@
 	return -ENODEV;
 }
 
-static int wbsd_request_regions(struct wbsd_host* host)
+/*
+ * Allocate/free io port ranges
+ */
+
+static int __devinit wbsd_request_region(struct wbsd_host* host, int base)
 {
 	if (io & 0x7)
 		return -EINVAL;
 	
-	if (!request_region(io, 8, DRIVER_NAME))
+	if (!request_region(base, 8, DRIVER_NAME))
 		return -EIO;
 	
 	host->base = io;
@@ -1271,19 +1436,25 @@
 	return 0;
 }
 
-static void wbsd_release_regions(struct wbsd_host* host)
+static void __devexit wbsd_release_regions(struct wbsd_host* host)
 {
 	if (host->base)
 		release_region(host->base, 8);
+	
+	host->base = 0;
 
 	if (host->config)
 		release_region(host->config, 2);
+	
+	host->config = 0;
 }
 
-static void wbsd_init_dma(struct wbsd_host* host)
+/*
+ * Allocate/free DMA port and buffer
+ */
+
+static void __devinit wbsd_request_dma(struct wbsd_host* host, int dma)
 {
-	host->dma = -1;
-	
 	if (dma < 0)
 		return;
 	
@@ -1294,7 +1465,7 @@
 	 * We need to allocate a special buffer in
 	 * order for ISA to be able to DMA to it.
 	 */
-	host->dma_buffer = kmalloc(65536,
+	host->dma_buffer = kmalloc(WBSD_DMA_SIZE,
 		GFP_NOIO | GFP_DMA | __GFP_REPEAT | __GFP_NOWARN);
 	if (!host->dma_buffer)
 		goto free;
@@ -1302,7 +1473,8 @@
 	/*
 	 * Translate the address to a physical address.
 	 */
-	host->dma_addr = isa_virt_to_bus(host->dma_buffer);
+	host->dma_addr = dma_map_single(host->mmc->dev, host->dma_buffer,
+		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
 			
 	/*
 	 * ISA DMA must be aligned on a 64k basis.
@@ -1325,6 +1497,10 @@
 	 */
 	BUG_ON(1);
 	
+	dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
+		DMA_BIDIRECTIONAL);
+	host->dma_addr = (dma_addr_t)NULL;
+	
 	kfree(host->dma_buffer);
 	host->dma_buffer = NULL;
 
@@ -1336,62 +1512,124 @@
 		"Falling back on FIFO.\n", dma);
 }
 
-static struct mmc_host_ops wbsd_ops = {
-	.request	= wbsd_request,
-	.set_ios	= wbsd_set_ios,
-};
+static void __devexit wbsd_release_dma(struct wbsd_host* host)
+{
+	if (host->dma_addr)
+		dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
+			DMA_BIDIRECTIONAL);
+	if (host->dma_buffer)
+		kfree(host->dma_buffer);
+	if (host->dma >= 0)
+		free_dma(host->dma);
+	
+	host->dma = -1;
+	host->dma_buffer = NULL;
+	host->dma_addr = (dma_addr_t)NULL;
+}
 
 /*
- * Device probe
+ * Allocate/free IRQ.
  */
 
-static int wbsd_probe(struct device* dev)
+static int __devinit wbsd_request_irq(struct wbsd_host* host, int irq)
 {
-	struct wbsd_host* host = NULL;
-	struct mmc_host* mmc = NULL;
 	int ret;
 	
 	/*
-	 * Allocate MMC structure.
+	 * Allocate interrupt.
 	 */
-	mmc = mmc_alloc_host(sizeof(struct wbsd_host), dev);
-	if (!mmc)
-		return -ENOMEM;
+
+	ret = request_irq(irq, wbsd_irq, SA_SHIRQ, DRIVER_NAME, host);
+	if (ret)
+		return ret;
 	
-	host = mmc_priv(mmc);
-	host->mmc = mmc;
-	
+	host->irq = irq;
+
 	/*
-	 * Scan for hardware.
+	 * Set up tasklets.
 	 */
-	ret = wbsd_scan(host);
-	if (ret)
-		goto freemmc;
+	tasklet_init(&host->card_tasklet, wbsd_tasklet_card, (unsigned long)host);
+	tasklet_init(&host->fifo_tasklet, wbsd_tasklet_fifo, (unsigned long)host);
+	tasklet_init(&host->crc_tasklet, wbsd_tasklet_crc, (unsigned long)host);
+	tasklet_init(&host->timeout_tasklet, wbsd_tasklet_timeout, (unsigned long)host);
+	tasklet_init(&host->finish_tasklet, wbsd_tasklet_finish, (unsigned long)host);
+	tasklet_init(&host->block_tasklet, wbsd_tasklet_block, (unsigned long)host);
+	
+	return 0;
+}
 
-	/*
-	 * Reset the chip.
-	 */	
-	wbsd_write_config(host, WBSD_CONF_SWRST, 1);
-	wbsd_write_config(host, WBSD_CONF_SWRST, 0);
+static void __devexit wbsd_release_irq(struct wbsd_host* host)
+{
+	if (!host->irq)
+		return;
 
+	free_irq(host->irq, host);
+	
+	host->irq = 0;
+		
+	tasklet_kill(&host->card_tasklet);
+	tasklet_kill(&host->fifo_tasklet);
+	tasklet_kill(&host->crc_tasklet);
+	tasklet_kill(&host->timeout_tasklet);
+	tasklet_kill(&host->finish_tasklet);
+	tasklet_kill(&host->block_tasklet);
+}
+
+/*
+ * Allocate all resources for the host.
+ */
+
+static int __devinit wbsd_request_resources(struct wbsd_host* host,
+	int base, int irq, int dma)
+{
+	int ret;
+	
 	/*
 	 * Allocate I/O ports.
 	 */
-	ret = wbsd_request_regions(host);
+	ret = wbsd_request_region(host, base);
 	if (ret)
-		goto release;
+		return ret;
 
 	/*
-	 * Set host parameters.
+	 * Allocate interrupt.
 	 */
-	mmc->ops = &wbsd_ops;
-	mmc->f_min = 375000;
-	mmc->f_max = 24000000;
-	mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
+	ret = wbsd_request_irq(host, irq);
+	if (ret)
+		return ret;
+
+	/*
+	 * Allocate DMA.
+	 */
+	wbsd_request_dma(host, dma);
 	
-	spin_lock_init(&host->lock);
+	return 0;
+}
 
+/*
+ * Release all resources for the host.
+ */
+
+static void __devexit wbsd_release_resources(struct wbsd_host* host)
+{
+	wbsd_release_dma(host);
+	wbsd_release_irq(host);
+	wbsd_release_regions(host);
+}
+
+/*
+ * Configure the resources the chip should use.
+ */
+
+static void __devinit wbsd_chip_config(struct wbsd_host* host)
+{
 	/*
+	 * Reset the chip.
+	 */	
+	wbsd_write_config(host, WBSD_CONF_SWRST, 1);
+	wbsd_write_config(host, WBSD_CONF_SWRST, 0);
+
+	/*
 	 * Select SD/MMC function.
 	 */
 	wbsd_write_config(host, WBSD_CONF_DEVICE, DEVICE_SD);
@@ -1399,165 +1637,241 @@
 	/*
 	 * Set up card detection.
 	 */
-	wbsd_write_config(host, WBSD_CONF_PINS, 0x02);
+	wbsd_write_config(host, WBSD_CONF_PINS, WBSD_PINS_DETECT_GP11);
 	
 	/*
-	 * Configure I/O port.
+	 * Configure chip
 	 */
 	wbsd_write_config(host, WBSD_CONF_PORT_HI, host->base >> 8);
 	wbsd_write_config(host, WBSD_CONF_PORT_LO, host->base & 0xff);
-
-	/*
-	 * Allocate interrupt.
-	 */
-	ret = request_irq(irq, wbsd_irq, SA_SHIRQ, DRIVER_NAME, host);
-	if (ret)
-		goto release;
 	
-	host->irq = irq;
+	wbsd_write_config(host, WBSD_CONF_IRQ, host->irq);
 	
-	/*
-	 * Set up tasklets.
-	 */
-	tasklet_init(&host->card_tasklet, wbsd_tasklet_card, (unsigned long)host);
-	tasklet_init(&host->fifo_tasklet, wbsd_tasklet_fifo, (unsigned long)host);
-	tasklet_init(&host->crc_tasklet, wbsd_tasklet_crc, (unsigned long)host);
-	tasklet_init(&host->timeout_tasklet, wbsd_tasklet_timeout, (unsigned long)host);
-	tasklet_init(&host->finish_tasklet, wbsd_tasklet_finish, (unsigned long)host);
-	tasklet_init(&host->block_tasklet, wbsd_tasklet_block, (unsigned long)host);
+	if (host->dma >= 0)
+		wbsd_write_config(host, WBSD_CONF_DRQ, host->dma);
 	
 	/*
-	 * Configure interrupt.
+	 * Enable and power up chip.
 	 */
-	wbsd_write_config(host, WBSD_CONF_IRQ, host->irq);
+	wbsd_write_config(host, WBSD_CONF_ENABLE, 1);
+	wbsd_write_config(host, WBSD_CONF_POWER, 0x20);
+}
+
+/*
+ * Check that configured resources are correct.
+ */
+ 
+static int __devinit wbsd_chip_validate(struct wbsd_host* host)
+{
+	int base, irq, dma;
 	
 	/*
-	 * Allocate DMA.
+	 * Select SD/MMC function.
 	 */
-	wbsd_init_dma(host);
+	wbsd_write_config(host, WBSD_CONF_DEVICE, DEVICE_SD);
 	
 	/*
-	 * If all went well, then configure DMA.
+	 * Read configuration.
 	 */
-	if (host->dma >= 0)
-		wbsd_write_config(host, WBSD_CONF_DRQ, host->dma);
+	base = wbsd_read_config(host, WBSD_CONF_PORT_HI) << 8;
+	base |= wbsd_read_config(host, WBSD_CONF_PORT_LO);
 	
-	/*
-	 * Maximum number of segments. Worst case is one sector per segment
-	 * so this will be 64kB/512.
-	 */
-	mmc->max_hw_segs = 128;
-	mmc->max_phys_segs = 128;
+	irq = wbsd_read_config(host, WBSD_CONF_IRQ);
 	
+	dma = wbsd_read_config(host, WBSD_CONF_DRQ);
+	
 	/*
-	 * Maximum number of sectors in one transfer. Also limited by 64kB
-	 * buffer.
+	 * Validate against given configuration.
 	 */
-	mmc->max_sectors = 128;
+	if (base != host->base)
+		return 0;
+	if (irq != host->irq)
+		return 0;
+	if ((dma != host->dma) && (host->dma != -1))
+		return 0;
 	
+	return 1;
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Devices setup and shutdown                                                *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __devinit wbsd_init(struct device* dev, int base, int irq, int dma,
+	int pnp)
+{
+	struct wbsd_host* host = NULL;
+	struct mmc_host* mmc = NULL;
+	int ret;
+	
+	ret = wbsd_alloc_mmc(dev);
+	if (ret)
+		return ret;
+	
+	mmc = dev_get_drvdata(dev);
+	host = mmc_priv(mmc);
+	
 	/*
-	 * Maximum segment size. Could be one segment with the maximum number
-	 * of segments.
+	 * Scan for hardware.
 	 */
-	mmc->max_seg_size = mmc->max_sectors * 512;
+	ret = wbsd_scan(host);
+	if (ret)
+	{
+		if (pnp && (ret == -ENODEV))
+		{
+			printk(KERN_WARNING DRIVER_NAME
+				": Unable to confirm device presence. You may "
+				"experience lock-ups.\n");
+		}
+		else
+		{
+			wbsd_free_mmc(dev);
+			return ret;
+		}
+	}
 	
 	/*
-	 * Enable chip.
+	 * Request resources.
 	 */
-	wbsd_write_config(host, WBSD_CONF_ENABLE, 1);
+	ret = wbsd_request_resources(host, io, irq, dma);
+	if (ret)
+	{
+		wbsd_release_resources(host);
+		wbsd_free_mmc(dev);
+		return ret;
+	}
 	
 	/*
-	 * Power up chip.
+	 * See if chip needs to be configured.
 	 */
-	wbsd_write_config(host, WBSD_CONF_POWER, 0x20);
+	if (pnp && (host->config != 0))
+	{
+		if (!wbsd_chip_validate(host))
+		{
+			printk(KERN_WARNING DRIVER_NAME
+				": PnP active but chip not configured! "
+				"You probably have a buggy BIOS. "
+				"Configuring chip manually.\n");
+			wbsd_chip_config(host);
+		}
+	}
+	else
+		wbsd_chip_config(host);
 	
 	/*
 	 * Power Management stuff. No idea how this works.
 	 * Not tested.
 	 */
 #ifdef CONFIG_PM
-	wbsd_write_config(host, WBSD_CONF_PME, 0xA0);
+	if (host->config)
+		wbsd_write_config(host, WBSD_CONF_PME, 0xA0);
 #endif
+	/*
+	 * Allow device to initialise itself properly.
+	 */
+	mdelay(5);
 
 	/*
 	 * Reset the chip into a known state.
 	 */
 	wbsd_init_device(host);
 	
-	dev_set_drvdata(dev, mmc);
-	
-	/*
-	 * Add host to MMC layer.
-	 */
 	mmc_add_host(mmc);
 
-	printk(KERN_INFO "%s: W83L51xD id %x at 0x%x irq %d dma %d\n",
-		mmc->host_name, (int)host->chip_id, (int)host->base,
-		(int)host->irq, (int)host->dma);
+	printk(KERN_INFO "%s: W83L51xD", mmc->host_name);
+	if (host->chip_id != 0)
+		printk(" id %x", (int)host->chip_id);
+	printk(" at 0x%x irq %d", (int)host->base, (int)host->irq);
+	if (host->dma >= 0)
+		printk(" dma %d", (int)host->dma);
+	else
+		printk(" FIFO");
+	if (pnp)
+		printk(" PnP");
+	printk("\n");
 
 	return 0;
-
-release:
-	wbsd_release_regions(host);
-
-freemmc:
-	mmc_free_host(mmc);
-
-	return ret;
 }
 
-/*
- * Device remove
- */
-
-static int wbsd_remove(struct device* dev)
+static void __devexit wbsd_shutdown(struct device* dev, int pnp)
 {
 	struct mmc_host* mmc = dev_get_drvdata(dev);
 	struct wbsd_host* host;
 	
 	if (!mmc)
-		return 0;
+		return;
 
 	host = mmc_priv(mmc);
 	
-	/*
-	 * Unregister host with MMC layer.
-	 */
 	mmc_remove_host(mmc);
 
-	/*
-	 * Power down the SD/MMC function.
-	 */
-	wbsd_unlock_config(host);
-	wbsd_write_config(host, WBSD_CONF_DEVICE, DEVICE_SD);
-	wbsd_write_config(host, WBSD_CONF_ENABLE, 0);
-	wbsd_lock_config(host);
+	if (!pnp)
+	{
+		/*
+		 * Power down the SD/MMC function.
+		 */
+		wbsd_unlock_config(host);
+		wbsd_write_config(host, WBSD_CONF_DEVICE, DEVICE_SD);
+		wbsd_write_config(host, WBSD_CONF_ENABLE, 0);
+		wbsd_lock_config(host);
+	}
 	
-	/*
-	 * Free resources.
-	 */
-	if (host->dma_buffer)
-		kfree(host->dma_buffer);
+	wbsd_release_resources(host);
 	
-	if (host->dma >= 0)
-		free_dma(host->dma);
+	wbsd_free_mmc(dev);
+}
 
-	free_irq(host->irq, host);
+/*
+ * Non-PnP
+ */
+
+static int __devinit wbsd_probe(struct device* dev)
+{
+	return wbsd_init(dev, io, irq, dma, 0);
+}
+
+static int __devexit wbsd_remove(struct device* dev)
+{
+	wbsd_shutdown(dev, 0);
+
+	return 0;
+}
+
+/*
+ * PnP
+ */
+
+#ifdef CONFIG_PNP
+
+static int __devinit
+wbsd_pnp_probe(struct pnp_dev * pnpdev, const struct pnp_device_id *dev_id)
+{
+	int io, irq, dma;
 	
-	tasklet_kill(&host->card_tasklet);
-	tasklet_kill(&host->fifo_tasklet);
-	tasklet_kill(&host->crc_tasklet);
-	tasklet_kill(&host->timeout_tasklet);
-	tasklet_kill(&host->finish_tasklet);
-	tasklet_kill(&host->block_tasklet);
+	/*
+	 * Get resources from PnP layer.
+	 */
+	io = pnp_port_start(pnpdev, 0);
+	irq = pnp_irq(pnpdev, 0);
+	if (pnp_dma_valid(pnpdev, 0))
+		dma = pnp_dma(pnpdev, 0);
+	else
+		dma = -1;
 	
-	wbsd_release_regions(host);
+	DBGF("PnP resources: port %3x irq %d dma %d\n", io, irq, dma);
 	
-	mmc_free_host(mmc);
+	return wbsd_init(&pnpdev->dev, io, irq, dma, 1);
+}
 
-	return 0;
+static void __devexit wbsd_pnp_remove(struct pnp_dev * dev)
+{
+	wbsd_shutdown(&dev->dev, 1);
 }
 
+#endif /* CONFIG_PNP */
+
 /*
  * Power management
  */
@@ -1581,18 +1895,8 @@
 #define wbsd_resume NULL
 #endif
 
-static void wbsd_release(struct device *dev)
-{
-}
+static struct platform_device *wbsd_device;
 
-static struct platform_device wbsd_device = {
-	.name		= DRIVER_NAME,
-	.id			= -1,
-	.dev		= {
-		.release = wbsd_release,
-	},
-};
-
 static struct device_driver wbsd_driver = {
 	.name		= DRIVER_NAME,
 	.bus		= &platform_bus_type,
@@ -1603,6 +1907,17 @@
 	.resume		= wbsd_resume,
 };
 
+#ifdef CONFIG_PNP
+
+static struct pnp_driver wbsd_pnp_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= pnp_dev_table,
+	.probe		= wbsd_pnp_probe,
+	.remove		= wbsd_pnp_remove,
+};
+
+#endif /* CONFIG_PNP */
+
 /*
  * Module loading/unloading
  */
@@ -1615,29 +1930,57 @@
 		": Winbond W83L51xD SD/MMC card interface driver, "
 		DRIVER_VERSION "\n");
 	printk(KERN_INFO DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
+
+#ifdef CONFIG_PNP
+
+	if (!nopnp)
+	{
+		result = pnp_register_driver(&wbsd_pnp_driver);
+		if (result < 0)
+			return result;
+	}
+
+#endif /* CONFIG_PNP */	
 	
-	result = driver_register(&wbsd_driver);
-	if (result < 0)
-		return result;
+	if (nopnp)
+	{
+		result = driver_register(&wbsd_driver);
+		if (result < 0)
+			return result;
 
-	result = platform_device_register(&wbsd_device);
-	if (result < 0)
-		return result;
+		wbsd_device = platform_device_register_simple(DRIVER_NAME, -1,
+			NULL, 0);
+		if (IS_ERR(wbsd_device))
+			return PTR_ERR(wbsd_device);
+	}
 
 	return 0;
 }
 
 static void __exit wbsd_drv_exit(void)
 {
-	platform_device_unregister(&wbsd_device);
+#ifdef CONFIG_PNP
+
+	if (!nopnp)
+		pnp_unregister_driver(&wbsd_pnp_driver);
 	
-	driver_unregister(&wbsd_driver);
+#endif /* CONFIG_PNP */	
 
+	if (nopnp)
+	{
+		platform_device_unregister(wbsd_device);
+	
+		driver_unregister(&wbsd_driver);
+	}
+
 	DBG("unloaded\n");
 }
 
 module_init(wbsd_drv_init);
 module_exit(wbsd_drv_exit);
+#ifdef CONFIG_PNP
+module_param(nopnp, uint, 0444);
+#endif
 module_param(io, uint, 0444);
 module_param(irq, uint, 0444);
 module_param(dma, int, 0444);
@@ -1646,6 +1989,9 @@
 MODULE_DESCRIPTION("Winbond W83L51xD SD/MMC card interface driver");
 MODULE_VERSION(DRIVER_VERSION);
 
+#ifdef CONFIG_PNP
+MODULE_PARM_DESC(nopnp, "Scan for device instead of relying on PNP. (default 0)");
+#endif
 MODULE_PARM_DESC(io, "I/O base to allocate. Must be 8 byte aligned. (default 0x248)");
 MODULE_PARM_DESC(irq, "IRQ to allocate. (default 6)");
 MODULE_PARM_DESC(dma, "DMA channel to allocate. -1 for no DMA. (default 2)");
Index: linux/drivers/mmc/wbsd.h
===================================================================
--- linux/drivers/mmc/wbsd.h	(revision 132)
+++ linux/drivers/mmc/wbsd.h	(working copy)
@@ -35,6 +35,12 @@
 
 #define DEVICE_SD		0x03
 
+#define WBSD_PINS_DAT3_HI	0x20
+#define WBSD_PINS_DAT3_OUT	0x10
+#define WBSD_PINS_GP11_HI	0x04
+#define WBSD_PINS_DETECT_GP11	0x02
+#define WBSD_PINS_DETECT_DAT3	0x01
+
 #define WBSD_CMDR		0x00
 #define WBSD_DFR		0x01
 #define WBSD_EIR		0x02
@@ -133,6 +139,7 @@
 #define WBSD_CRC_OK		0x05 /* S010E (00101) */
 #define WBSD_CRC_FAIL		0x0B /* S101E (01011) */
 
+#define WBSD_DMA_SIZE		65536
 
 struct wbsd_host
 {
@@ -140,6 +147,11 @@
 	
 	spinlock_t		lock;		/* Mutex */
 
+	int			flags;		/* Driver states */
+
+#define WBSD_FCARD_PRESENT	(1<<0)		/* Card is present */
+#define WBSD_FIGNORE_DETECT	(1<<1)		/* Ignore card detection */
+	
 	struct mmc_request*	mrq;		/* Current request */
 	
 	u8			isr;		/* Accumulated ISR */
Index: linux/drivers/mmc/Kconfig
===================================================================
--- linux/drivers/mmc/Kconfig	(revision 132)
+++ linux/drivers/mmc/Kconfig	(working copy)
@@ -51,7 +77,7 @@
 
 config MMC_WBSD
 	tristate "Winbond W83L51xD SD/MMC Card Interface support"
-	depends on MMC && ISA
+	depends on MMC
 	help
 	  This selects the Winbond(R) W83L51xD Secure digital and
           Multimedia card Interface.

--=_hermes.drzeus.cx-14864-1112345723-0001-2--
