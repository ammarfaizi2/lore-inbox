Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUD2MxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUD2MxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUD2MxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:53:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40708 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264367AbUD2Mup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:50:45 -0400
Date: Thu, 29 Apr 2004 13:50:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 3/4 MMC layer: ARM MMCI driver
Message-ID: <20040429135041.E16407@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040429134824.C16407@flint.arm.linux.org.uk> <20040429134925.D16407@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040429134925.D16407@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Apr 29, 2004 at 01:49:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds initial support for the ARM MMCI Primecell - one of
the drivers for a MMC interface.

diff -urpN orig/drivers/mmc/Kconfig linux/drivers/mmc/Kconfig
--- orig/drivers/mmc/Kconfig	Fri Oct 17 17:41:27 2003
+++ linux/drivers/mmc/Kconfig	Fri Oct 17 17:41:28 2003
@@ -29,4 +29,14 @@
 	  mount the filesystem. Almost everyone wishing MMC support
 	  should say Y or M here.
 
+config MMC_ARMMMCI
+	tristate "ARM AMBA Multimedia Card Interface support"
+	depends on ARM_AMBA && MMC
+	help
+	  This selects the ARM(R) AMBA(R) PrimeCell Multimedia Card
+	  Interface (PL180 and PL181) support.  If you have an ARM(R)
+	  platform with a Multimedia Card slot, say Y or M here.
+
+	  If unsure, say N.
+
 endmenu
diff -urpN orig/drivers/mmc/Makefile linux/drivers/mmc/Makefile
--- orig/drivers/mmc/Makefile	Mon Jul  7 21:52:01 2003
+++ linux/drivers/mmc/Makefile	Mon Jul  7 21:52:02 2003
@@ -15,5 +15,6 @@
 #
 # Host drivers
 #
+obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o
 
 mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o
diff -urpN orig/drivers/mmc/mmci.c linux/drivers/mmc/mmci.c
--- orig/drivers/mmc/mmci.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/mmci.c	Thu Mar  4 23:38:29 2004
@@ -0,0 +1,523 @@
+/*
+ *  linux/drivers/mmc/mmci.c - ARM PrimeCell MMCI PL180/1 driver
+ *
+ *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/protocol.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/hardware/amba.h>
+#include <asm/mach/mmc.h>
+
+#include "mmci.h"
+
+#define DRIVER_NAME "mmci-pl18x"
+
+#ifdef CONFIG_MMC_DEBUG
+#define DBG(x...)	pr_debug(x)
+#else
+#define DBG(x...)	do { } while (0)
+#endif
+
+static unsigned int fmax = 515633;
+
+static void
+mmci_request_end(struct mmci_host *host, struct mmc_request *req)
+{
+	writel(0, host->base + MMCICOMMAND);
+	host->req = NULL;
+	host->cmd = NULL;
+	host->data = NULL;
+	host->buffer = NULL;
+
+	if (req->data)
+		req->data->bytes_xfered = host->data_xfered;
+
+	/*
+	 * Need to drop the host lock here; mmc_request_done may call
+	 * back into the driver...
+	 */
+	spin_unlock(&host->lock);
+	mmc_request_done(host->mmc, req);
+	spin_lock(&host->lock);
+}
+
+static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
+{
+	unsigned int datactrl;
+
+	DBG("%s: data: blksz %04x blks %04x flags %08x\n",
+	    host->mmc->host_name, 1 << data->blksz_bits, data->blocks,
+	    data->flags);
+
+	datactrl = MCI_DPSM_ENABLE | data->blksz_bits << 4;
+
+	if (data->flags & MMC_DATA_READ)
+		datactrl |= MCI_DPSM_DIRECTION;
+
+	host->data = data;
+	host->buffer = data->rq->buffer;
+	host->size = data->blocks << data->blksz_bits;
+	host->data_xfered = 0;
+
+	writel(0x800000, host->base + MMCIDATATIMER);
+	writel(host->size, host->base + MMCIDATALENGTH);
+	writel(datactrl, host->base + MMCIDATACTRL);
+}
+
+static void
+mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
+{
+	DBG("%s: cmd: op %02x arg %08x flags %08x\n",
+	    host->mmc->host_name, cmd->opcode, cmd->arg, cmd->flags);
+
+	if (readl(host->base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
+		writel(0, host->base + MMCICOMMAND);
+		udelay(1);
+	}
+
+	c |= cmd->opcode | MCI_CPSM_ENABLE;
+	switch (cmd->flags & MMC_RSP_MASK) {
+	case MMC_RSP_NONE:
+	default:
+		break;
+	case MMC_RSP_LONG:
+		c |= MCI_CPSM_LONGRSP;
+	case MMC_RSP_SHORT:
+		c |= MCI_CPSM_RESPONSE;
+		break;
+	}
+	if (/*interrupt*/0)
+		c |= MCI_CPSM_INTERRUPT;
+
+	host->cmd = cmd;
+
+	writel(cmd->arg, host->base + MMCIARGUMENT);
+	writel(c, host->base + MMCICOMMAND);
+}
+
+static void
+mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
+	      unsigned int status)
+{
+	if (status & MCI_DATABLOCKEND) {
+		host->data_xfered += 1 << data->blksz_bits;
+	}
+	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+		if (status & MCI_DATACRCFAIL)
+			data->error = MMC_ERR_BADCRC;
+		else if (status & MCI_DATATIMEOUT)
+			data->error = MMC_ERR_TIMEOUT;
+		else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN))
+			data->error = MMC_ERR_FIFO;
+		status |= MCI_DATAEND;
+	}
+	if (status & MCI_DATAEND) {
+		host->data = NULL;
+		if (!data->stop) {
+			mmci_request_end(host, data->req);
+		} else /*if (readl(host->base + MMCIDATACNT) > 6)*/ {
+			mmci_start_command(host, data->stop, 0);
+		}
+	}
+}
+
+static void
+mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
+	     unsigned int status)
+{
+	host->cmd = NULL;
+
+	cmd->resp[0] = readl(host->base + MMCIRESPONSE0);
+	cmd->resp[1] = readl(host->base + MMCIRESPONSE1);
+	cmd->resp[2] = readl(host->base + MMCIRESPONSE2);
+	cmd->resp[3] = readl(host->base + MMCIRESPONSE3);
+
+	if (status & MCI_CMDTIMEOUT) {
+		cmd->error = MMC_ERR_TIMEOUT;
+	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
+		cmd->error = MMC_ERR_BADCRC;
+	}
+
+	if (!cmd->data || cmd->error != MMC_ERR_NONE) {
+		mmci_request_end(host, cmd->req);
+	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
+		mmci_start_data(host, cmd->data);
+	}
+}
+
+static irqreturn_t mmci_pio_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct mmci_host *host = dev_id;
+	u32 status;
+	int ret = 0;
+
+	do {
+		status = readl(host->base + MMCISTATUS);
+
+		if (!(status & (MCI_RXDATAAVLBL|MCI_RXFIFOHALFFULL|
+				MCI_TXFIFOEMPTY|MCI_TXFIFOHALFEMPTY)))
+			break;
+
+		DBG("%s: irq1 %08x\n", host->mmc->host_name, status);
+
+		if (status & (MCI_RXDATAAVLBL|MCI_RXFIFOHALFFULL)) {
+			int count = host->size - (readl(host->base + MMCIFIFOCNT) << 2);
+			if (count < 0)
+				count = 0;
+			if (count && host->buffer) {
+				readsl(host->base + MMCIFIFO, host->buffer, count >> 2);
+				host->buffer += count;
+				host->size -= count;
+				if (host->size == 0)
+					host->buffer = NULL;
+			} else {
+				static int first = 1;
+				if (first) {
+					first = 0;
+					printk(KERN_ERR "MMCI: sinking excessive data\n");
+				}
+				readl(host->base + MMCIFIFO);
+			}
+		}
+		if (status & (MCI_TXFIFOEMPTY|MCI_TXFIFOHALFEMPTY)) {
+			int count = host->size;
+			if (count > MCI_FIFOHALFSIZE)
+				count = MCI_FIFOHALFSIZE;
+			if (count && host->buffer) {
+				writesl(host->base + MMCIFIFO, host->buffer, count >> 2);
+				host->buffer += count;
+				host->size -= count;
+				if (host->size == 0)
+					host->buffer = NULL;
+			} else {
+				static int first = 1;
+				if (first) {
+					first = 0;
+					printk(KERN_ERR "MMCI: ran out of source data\n");
+				}
+			}
+		}
+		ret = 1;
+	} while (status);
+
+	return IRQ_RETVAL(ret);
+}
+
+static irqreturn_t mmci_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct mmci_host *host = dev_id;
+	u32 status;
+	int ret = 0;
+
+	spin_lock(&host->lock);
+
+	do {
+		struct mmc_command *cmd;
+		struct mmc_data *data;
+
+		status = readl(host->base + MMCISTATUS);
+		writel(status, host->base + MMCICLEAR);
+
+		if (!(status & MCI_IRQMASK))
+			break;
+
+		DBG("%s: irq0 %08x\n", host->mmc->host_name, status);
+
+		data = host->data;
+		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|
+			      MCI_RXOVERRUN|MCI_DATAEND|MCI_DATABLOCKEND))
+			mmci_data_irq(host, data, status);
+
+		cmd = host->cmd;
+		if (status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND) && cmd)
+			mmci_cmd_irq(host, cmd, status);
+
+		ret = 1;
+	} while (status);
+
+	spin_unlock(&host->lock);
+
+	return IRQ_RETVAL(ret);
+}
+
+static void mmci_request(struct mmc_host *mmc, struct mmc_request *req)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+
+	WARN_ON(host->req != NULL);
+
+	spin_lock_irq(&host->lock);
+
+	host->req = req;
+
+	if (req->data && req->data->flags & MMC_DATA_READ)
+		mmci_start_data(host, req->data);
+
+	mmci_start_command(host, req->cmd, 0);
+
+	spin_unlock_irq(&host->lock);
+}
+
+static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	u32 clk = 0, pwr = 0;
+
+	DBG("%s: set_ios: clock %dHz busmode %d powermode %d Vdd %d.%02d\n",
+	    mmc->host_name, ios->clock, ios->bus_mode, ios->power_mode,
+	    ios->vdd / 100, ios->vdd % 100);
+
+	if (ios->clock) {
+		clk = host->mclk / (2 * ios->clock) - 1;
+		if (clk > 256)
+			clk = 255;
+		clk |= MCI_CLK_ENABLE;
+	}
+
+	if (host->plat->translate_vdd)
+		pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd);
+
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		break;
+	case MMC_POWER_UP:
+		pwr |= MCI_PWR_UP;
+		break;
+	case MMC_POWER_ON:
+		pwr |= MCI_PWR_ON;
+		break;
+	}
+
+	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
+		pwr |= MCI_ROD;
+
+	writel(clk, host->base + MMCICLOCK);
+
+	if (host->pwr != pwr) {
+		host->pwr = pwr;
+		writel(pwr, host->base + MMCIPOWER);
+	}
+}
+
+static struct mmc_host_ops mmci_ops = {
+	.request	= mmci_request,
+	.set_ios	= mmci_set_ios,
+};
+
+static void mmci_check_status(unsigned long data)
+{
+	struct mmci_host *host = (struct mmci_host *)data;
+	unsigned int status;
+
+	status = host->plat->status(mmc_dev(host->mmc));
+	if (status ^ host->oldstat)
+		mmc_detect_change(host->mmc);
+
+	host->oldstat = status;
+	mod_timer(&host->timer, jiffies + HZ);
+}
+
+static int mmci_probe(struct amba_device *dev, void *id)
+{
+	struct mmc_platform_data *plat = dev->dev.platform_data;
+	struct mmci_host *host = NULL;
+	struct mmc_host *mmc;
+	int ret;
+
+	/* must have platform data */
+	if (!plat)
+		return -EINVAL;
+
+	ret = amba_request_regions(dev, DRIVER_NAME);
+	if (ret)
+		return ret;
+
+	mmc = mmc_alloc_host(sizeof(struct mmci_host), &dev->dev);
+	if (!mmc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mmc->ops = &mmci_ops;
+	mmc->f_min = (plat->mclk + 511) / 512;
+	mmc->f_max = max(plat->mclk / 2, fmax);
+	mmc->ocr_avail = plat->ocr_mask;
+
+	host = mmc_priv(mmc);
+	host->plat = plat;
+	host->mclk = plat->mclk;
+	host->mmc = mmc;
+	host->base = ioremap(dev->res.start, SZ_4K);
+	if (!host->base) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	spin_lock_init(&host->lock);
+
+	writel(0, host->base + MMCIMASK0);
+	writel(0, host->base + MMCIMASK1);
+	writel(0xfff, host->base + MMCICLEAR);
+
+	ret = request_irq(dev->irq[0], mmci_irq, SA_SHIRQ, DRIVER_NAME " (cmd)", host);
+	if (ret)
+		goto out;
+
+	ret = request_irq(dev->irq[1], mmci_pio_irq, SA_SHIRQ, DRIVER_NAME " (pio)", host);
+	if (ret) {
+		free_irq(dev->irq[0], host);
+		goto out;
+	}
+
+	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	writel(MCI_TXFIFOHALFEMPTYMASK|MCI_RXFIFOHALFFULLMASK, host->base + MMCIMASK1);
+
+	amba_set_drvdata(dev, mmc);
+
+	mmc_add_host(mmc);
+
+	printk(KERN_INFO "%s: MMCI rev %x cfg %02x at 0x%08lx irq %d,%d\n",
+		mmc->host_name, amba_rev(dev), amba_config(dev),
+		dev->res.start, dev->irq[0], dev->irq[1]);
+
+	init_timer(&host->timer);
+	host->timer.data = (unsigned long)host;
+	host->timer.function = mmci_check_status;
+	host->timer.expires = jiffies + HZ;
+	add_timer(&host->timer);
+
+	return 0;
+
+ out:
+	if (host && host->base)
+		iounmap(host->base);
+	if (mmc)
+		mmc_free_host(mmc);
+	amba_release_regions(dev);
+	return ret;
+}
+
+static int mmci_remove(struct amba_device *dev)
+{
+	struct mmc_host *mmc = amba_get_drvdata(dev);
+
+	amba_set_drvdata(dev, NULL);
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+
+		del_timer_sync(&host->timer);
+
+		mmc_remove_host(mmc);
+
+		writel(0, host->base + MMCIMASK0);
+		writel(0, host->base + MMCIMASK1);
+
+		writel(0, host->base + MMCICOMMAND);
+		writel(0, host->base + MMCIDATACTRL);
+
+		free_irq(dev->irq[0], host);
+		free_irq(dev->irq[1], host);
+
+		iounmap(host->base);
+
+		mmc_free_host(mmc);
+
+		amba_release_regions(dev);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mmci_suspend(struct amba_device *dev, u32 state)
+{
+	struct mmc_host *mmc = amba_get_drvdata(dev);
+	int ret = 0;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+
+		ret = mmc_suspend_host(mmc, state);
+		if (ret == 0)
+			writel(0, host->base + MMCIMASK0);
+	}
+
+	return ret;
+}
+
+static int mmci_resume(struct amba_device *dev)
+{
+	struct mmc_host *mmc = amba_get_drvdata(dev);
+	int ret = 0;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+
+		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+
+		ret = mmc_resume_host(mmc);
+	}
+
+	return ret;
+}
+#else
+#define mmci_suspend	NULL
+#define mmci_resume	NULL
+#endif
+
+static struct amba_id mmci_ids[] = {
+	{
+		.id	= 0x00041180,
+		.mask	= 0x000fffff,
+	},
+	{
+		.id	= 0x00041181,
+		.mask	= 0x000fffff,
+	},
+	{ 0, 0 },
+};
+
+static struct amba_driver mmci_driver = {
+	.drv		= {
+		.name	= DRIVER_NAME,
+	},
+	.probe		= mmci_probe,
+	.remove		= mmci_remove,
+	.suspend	= mmci_suspend,
+	.resume		= mmci_resume,
+	.id_table	= mmci_ids,
+};
+
+static int __init mmci_init(void)
+{
+	return amba_driver_register(&mmci_driver);
+}
+
+static void __exit mmci_exit(void)
+{
+	amba_driver_unregister(&mmci_driver);
+}
+
+module_init(mmci_init);
+module_exit(mmci_exit);
+module_param(fmax, uint, 0444);
+
+MODULE_DESCRIPTION("ARM PrimeCell PL180/181 Multimedia Card Interface driver");
+MODULE_LICENSE("GPL");
diff -urpN orig/drivers/mmc/mmci.h linux/drivers/mmc/mmci.h
--- orig/drivers/mmc/mmci.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/mmc/mmci.h	Wed Dec 31 22:58:09 2003
@@ -0,0 +1,149 @@
+/*
+ *  linux/drivers/mmc/mmci.h - ARM PrimeCell MMCI PL180/1 driver
+ *
+ *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#define MMCIPOWER		0x000
+#define MCI_PWR_OFF		0x00
+#define MCI_PWR_UP		0x02
+#define MCI_PWR_ON		0x03
+#define MCI_OD			(1 << 6)
+#define MCI_ROD			(1 << 7)
+
+#define MMCICLOCK		0x004
+#define MCI_CLK_ENABLE		(1 << 8)
+#define MCI_PWRSAVE		(1 << 9)
+#define MCI_BYPASS		(1 << 10)
+
+#define MMCIARGUMENT		0x008
+#define MMCICOMMAND		0x00c
+#define MCI_CPSM_RESPONSE	(1 << 6)
+#define MCI_CPSM_LONGRSP	(1 << 7)
+#define MCI_CPSM_INTERRUPT	(1 << 8)
+#define MCI_CPSM_PENDING	(1 << 9)
+#define MCI_CPSM_ENABLE		(1 << 10)
+
+#define MMCIRESPCMD		0x010
+#define MMCIRESPONSE0		0x014
+#define MMCIRESPONSE1		0x018
+#define MMCIRESPONSE2		0x01c
+#define MMCIRESPONSE3		0x020
+#define MMCIDATATIMER		0x024
+#define MMCIDATALENGTH		0x028
+#define MMCIDATACTRL		0x02c
+#define MCI_DPSM_ENABLE		(1 << 0)
+#define MCI_DPSM_DIRECTION	(1 << 1)
+#define MCI_DPSM_MODE		(1 << 2)
+#define MCI_DPSM_DMAENABLE	(1 << 3)
+
+#define MMCIDATACNT		0x030
+#define MMCISTATUS		0x034
+#define MCI_CMDCRCFAIL		(1 << 0)
+#define MCI_DATACRCFAIL		(1 << 1)
+#define MCI_CMDTIMEOUT		(1 << 2)
+#define MCI_DATATIMEOUT		(1 << 3)
+#define MCI_TXUNDERRUN		(1 << 4)
+#define MCI_RXOVERRUN		(1 << 5)
+#define MCI_CMDRESPEND		(1 << 6)
+#define MCI_CMDSENT		(1 << 7)
+#define MCI_DATAEND		(1 << 8)
+#define MCI_DATABLOCKEND	(1 << 10)
+#define MCI_CMDACTIVE		(1 << 11)
+#define MCI_TXACTIVE		(1 << 12)
+#define MCI_RXACTIVE		(1 << 13)
+#define MCI_TXFIFOHALFEMPTY	(1 << 14)
+#define MCI_RXFIFOHALFFULL	(1 << 15)
+#define MCI_TXFIFOFULL		(1 << 16)
+#define MCI_RXFIFOFULL		(1 << 17)
+#define MCI_TXFIFOEMPTY		(1 << 18)
+#define MCI_RXFIFOEMPTY		(1 << 19)
+#define MCI_TXDATAAVLBL		(1 << 20)
+#define MCI_RXDATAAVLBL		(1 << 21)
+
+#define MMCICLEAR		0x038
+#define MCI_CMDCRCFAILCLR	(1 << 0)
+#define MCI_DATACRCFAILCLR	(1 << 1)
+#define MCI_CMDTIMEOUTCLR	(1 << 2)
+#define MCI_DATATIMEOUTCLR	(1 << 3)
+#define MCI_TXUNDERRUNCLR	(1 << 4)
+#define MCI_RXOVERRUNCLR	(1 << 5)
+#define MCI_CMDRESPENDCLR	(1 << 6)
+#define MCI_CMDSENTCLR		(1 << 7)
+#define MCI_DATAENDCLR		(1 << 8)
+#define MCI_DATABLOCKENDCLR	(1 << 10)
+
+#define MMCIMASK0		0x03c
+#define MCI_CMDCRCFAILMASK	(1 << 0)
+#define MCI_DATACRCFAILMASK	(1 << 1)
+#define MCI_CMDTIMEOUTMASK	(1 << 2)
+#define MCI_DATATIMEOUTMASK	(1 << 3)
+#define MCI_TXUNDERRUNMASK	(1 << 4)
+#define MCI_RXOVERRUNMASK	(1 << 5)
+#define MCI_CMDRESPENDMASK	(1 << 6)
+#define MCI_CMDSENTMASK		(1 << 7)
+#define MCI_DATAENDMASK		(1 << 8)
+#define MCI_DATABLOCKENDMASK	(1 << 10)
+#define MCI_CMDACTIVEMASK	(1 << 11)
+#define MCI_TXACTIVEMASK	(1 << 12)
+#define MCI_RXACTIVEMASK	(1 << 13)
+#define MCI_TXFIFOHALFEMPTYMASK	(1 << 14)
+#define MCI_RXFIFOHALFFULLMASK	(1 << 15)
+#define MCI_TXFIFOFULLMASK	(1 << 16)
+#define MCI_RXFIFOFULLMASK	(1 << 17)
+#define MCI_TXFIFOEMPTYMASK	(1 << 18)
+#define MCI_RXFIFOEMPTYMASK	(1 << 19)
+#define MCI_TXDATAAVLBLMASK	(1 << 20)
+#define MCI_RXDATAAVLBLMASK	(1 << 21)
+
+#define MMCIMASK1		0x040
+#define MMCIFIFOCNT		0x048
+#define MMCIFIFO		0x080 /* to 0x0bc */
+
+#define MCI_IRQMASK	\
+	(MCI_CMDCRCFAIL|MCI_DATACRCFAIL|MCI_CMDTIMEOUT|MCI_DATATIMEOUT|	\
+	MCI_TXUNDERRUN|MCI_RXOVERRUN|MCI_CMDRESPEND|MCI_CMDSENT|	\
+	MCI_DATAEND|MCI_DATABLOCKEND)
+
+#define MCI_IRQENABLE	\
+	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
+	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
+	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK|		\
+	MCI_DATABLOCKENDMASK)
+
+#define MCI_FIFOSIZE	16
+	
+#define MCI_FIFOHALFSIZE (MCI_FIFOSIZE / 2)
+
+struct mmci_host {
+	void			*base;
+	struct mmc_request	*req;
+	struct mmc_command	*cmd;
+	struct mmc_data		*data;
+	struct mmc_host		*mmc;
+
+	unsigned int		data_xfered;
+
+	spinlock_t		lock;
+
+	unsigned int		mclk;
+	u32			pwr;
+	struct mmc_platform_data *plat;
+
+	struct timer_list	timer;
+	unsigned int		oldstat;
+
+	/* pio stuff */
+	void			*buffer;
+	unsigned int		size;
+
+	/* dma stuff */
+//	struct scatterlist	*sg_list;
+//	int			sg_len;
+//	int			sg_dir;
+};
+
+#define to_mmci_host(mmc)	container_of(mmc, struct mmci_host, mmc)

--- orig/include/asm-arm/mach/mmc.h	Sat Apr 26 08:56:46 1997
+++ linux/include/asm-arm/mach/mmc.h	Mon Dec 29 17:19:00 2003
@@ -0,0 +1,16 @@
+/*
+ *  linux/include/asm-arm/mach/mmc.h
+ */
+#ifndef ASMARM_MACH_MMC_H
+#define ASMARM_MACH_MMC_H
+
+#include <linux/mmc/protocol.h>
+
+struct mmc_platform_data {
+	unsigned int mclk;			/* mmc base clock rate */
+	unsigned int ocr_mask;			/* available voltages */
+	u32 (*translate_vdd)(struct device *, unsigned int);
+	unsigned int (*status)(struct device *);
+};
+
+#endif

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
