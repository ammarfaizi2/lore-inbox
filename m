Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbULIE7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbULIE7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 23:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbULIE7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 23:59:00 -0500
Received: from ftpbox.mot.com ([129.188.136.101]:42634 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S261455AbULIE4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 23:56:12 -0500
Date: Wed, 8 Dec 2004 22:56:03 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: linux-kernel@vger.kernel.org
cc: linuxppc-embedded@ozlabs.org
Subject: [RFC][PPC32] platform device / driver model usage
Message-ID: <Pine.LNX.4.61.0412082233440.14848@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moves the MPC85xx to using the driver model instead of OCP for 
driver/device binding.  Transitioned the gianfar ethernet driver over as 
an example, this currently only works on the MPC8540ADS with TSEC1.  The 
patch is a work in progress to get feedback on.

This is based on patches from Jason McMullan at TimeSys.

I wanted to get feedback on the addition of a flags field to struct 
platform_device.  Also, if there was any issue with the addition of 
include/linux/fsl_devices.h.  Other comments are welcome.

thanks

- kumar

diff -Nru a/arch/ppc/platforms/85xx/Makefile b/arch/ppc/platforms/85xx/Makefile
--- a/arch/ppc/platforms/85xx/Makefile	2004-12-08 22:22:37 -06:00
+++ b/arch/ppc/platforms/85xx/Makefile	2004-12-08 22:22:37 -06:00
@@ -1,6 +1,7 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
+obj-$(CONFIG_85xx)		+= mpc85xx.o
 
 obj-$(CONFIG_MPC8540_ADS)	+= mpc85xx_ads_common.o mpc8540_ads.o
 obj-$(CONFIG_MPC8555_CDS)	+= mpc85xx_cds_common.o
diff -Nru a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c	2004-12-08 22:22:37 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c	2004-12-08 22:22:37 -06:00
@@ -32,6 +32,7 @@
 #include <linux/serial_core.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -54,6 +55,14 @@
 #include <syslib/ppc85xx_common.h>
 #include <syslib/ppc85xx_setup.h>
 
+struct gianfar_platform_data mpc85xx_gianfar1_def = {
+	.flags = GFAR_HAS_PHY_INTR,
+	.interruptPHY = MPC85xx_IRQ_EXT5,
+	.phyid = 0,
+	.phydevice = "fsl-gianfar1",
+	.phyregidx = 1,
+};
+
 struct ocp_gfar_data mpc85xx_tsec1_def = {
 	.interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
 	.interruptError = MPC85xx_IRQ_TSEC1_ERROR,
@@ -147,6 +156,8 @@
 		einfo = (struct ocp_gfar_data *) def->additions;
 		memcpy(einfo->mac_addr, binfo->bi_enet2addr, 6);
 	}
+
+	memcpy(mpc85xx_gianfar1_def.mac_addr, binfo->bi_enetaddr, 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx.c b/arch/ppc/platforms/85xx/mpc85xx.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc85xx.c	2004-12-08 22:22:37 -06:00
@@ -0,0 +1,243 @@
+/*
+ * arch/ppc/platforms/85xx/mpc85xx.c
+ *
+ * MPC85xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2004 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/fsl_devices.h>
+#include <asm/mpc85xx.h>
+
+/* These should be defined in platform code */
+extern struct gianfar_platform_data mpc85xx_gianfar1_def;
+
+/* We use offsets for IORESOURCE_MEM since we do not know at compile time
+ * what CCSRBAR is, platform code should fix this up in
+ * setup_arch
+ *
+ */
+
+static struct platform_device m_dev[] = {
+	[MPC85xx_TSEC1] = {
+		.name = "fsl-gianfar",
+		.id	= 1,
+		.flags	= GIANFAR_HAS_GIGABIT | GIANFAR_HAS_MULTI_INTR | GIANFAR_HAS_RMON | GIANFAR_HAS_COALESCE,
+		.num_resources	 = 4,
+		.dev.platform_data = &mpc85xx_gianfar1_def, 
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET1_OFFSET,
+				.end	= MPC85xx_ENET1_OFFSET + MPC85xx_ENET1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC1_TX,
+				.end	= MPC85xx_IRQ_TSEC1_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC1_RX,
+				.end	= MPC85xx_IRQ_TSEC1_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC1_ERROR,
+				.end	= MPC85xx_IRQ_TSEC1_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_TSEC2] = {
+		.name = "fsl-gianfar",
+		.id	= 2,
+		.flags	= GIANFAR_HAS_GIGABIT | GIANFAR_HAS_MULTI_INTR | GIANFAR_HAS_RMON | GIANFAR_HAS_COALESCE,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET2_OFFSET,
+				.end	= MPC85xx_ENET2_OFFSET + MPC85xx_ENET2_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC2_TX,
+				.end	= MPC85xx_IRQ_TSEC2_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC2_RX,
+				.end	= MPC85xx_IRQ_TSEC2_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC2_ERROR,
+				.end	= MPC85xx_IRQ_TSEC2_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_FEC] =	{
+		.name = "fsl-gianfar",
+		.id	= 3,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET3_OFFSET,
+				.end	= MPC85xx_ENET3_OFFSET + MPC85xx_ENET3_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+
+			},
+			{
+				.start	= MPC85xx_IRQ_TSEC1_TX,
+				.end	= MPC85xx_IRQ_TSEC1_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_IIC1] = {
+		.name = "fsl-i2c",
+		.id	= 1,
+		.flags	= FSL_I2C_SEPARATE_DFSRR,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_IIC1_OFFSET,
+				.end	= MPC85xx_IIC1_OFFSET + MPC85xx_IIC1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+
+			},
+			{
+				.start	= MPC85xx_IRQ_IIC1,
+				.end	= MPC85xx_IRQ_IIC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA0] = {
+		.name = "fsl-dma",
+		.id	= 0,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA0_OFFSET,
+				.end	= MPC85xx_DMA0_OFFSET + MPC85xx_DMA0_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA0,
+				.end	= MPC85xx_IRQ_DMA0,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA1] = {
+		.name = "fsl-dma",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA1_OFFSET,
+				.end	= MPC85xx_DMA1_OFFSET + MPC85xx_DMA1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA1,
+				.end	= MPC85xx_IRQ_DMA1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA2] = {
+		.name = "fsl-dma",
+		.id	= 2,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA2_OFFSET,
+				.end	= MPC85xx_DMA2_OFFSET + MPC85xx_DMA2_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA2,
+				.end	= MPC85xx_IRQ_DMA2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA3] = {
+		.name = "fsl-dma",
+		.id	= 3,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA3_OFFSET,
+				.end	= MPC85xx_DMA3_OFFSET + MPC85xx_DMA3_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA3,
+				.end	= MPC85xx_IRQ_DMA3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+
+};
+
+static int
+mpc85xx_update_paddr(struct device *dev, void *arg)
+{
+	phys_addr_t ccsrbar;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource * r;
+
+	/* xxx - this only gets ioresource_mem 0 */
+	if (arg) {
+		ccsrbar = *(phys_addr_t *)arg;
+		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		r->start += ccsrbar;
+		r->end += ccsrbar;
+	}
+	return 0;
+}
+
+static int __init mach_mpc85xx_init(void)
+{
+	phys_addr_t ccsr = CCSRBAR;
+	platform_device_register(&m_dev[MPC85xx_TSEC1]);
+#if 0
+	platform_device_register(&m_dev[MPC85xx_TSEC2]);
+	platform_device_register(&m_dev[MPC85xx_FEC]);
+#endif
+	platform_device_register(&m_dev[MPC85xx_IIC1]);
+	platform_device_register(&m_dev[MPC85xx_DMA0]);
+	platform_device_register(&m_dev[MPC85xx_DMA1]);
+	platform_device_register(&m_dev[MPC85xx_DMA2]);
+	platform_device_register(&m_dev[MPC85xx_DMA3]);
+
+	bus_for_each_dev(&platform_bus_type, NULL, &ccsr, mpc85xx_update_paddr);
+	return 0;
+}
+
+subsys_initcall(mach_mpc85xx_init);
+
diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-12-08 22:22:37 -06:00
+++ b/drivers/base/platform.c	2004-12-08 22:22:37 -06:00
@@ -58,6 +58,42 @@
 }
 
 /**
+ *	platform_get_resource_byname - get a resource for a device by name
+ *	@dev: platform device
+ *	@type: resource type
+ *	@name: resource name
+ */
+struct resource *
+platform_get_resource_byname(struct platform_device *dev, unsigned int type,
+		      char * name)
+{
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if ((r->flags & (IORESOURCE_IO|IORESOURCE_MEM|
+				 IORESOURCE_IRQ|IORESOURCE_DMA))
+		    == type)
+			if (!strcmp(r->name, name))
+				return r;
+	}
+	return NULL;
+}
+
+/**
+ *	platform_get_irq - get an IRQ for a device
+ *	@dev: platform device
+ *	@name: IRQ name
+ */
+int platform_get_irq_byname(struct platform_device *dev, char * name)
+{
+	struct resource *r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
+
+	return r ? r->start : 0;
+}
+
+/**
  *	platform_add_devices - add a numbers of platform devices
  *	@devs: array of platform devices to add
  *	@num: number of platform devices in array
@@ -103,7 +139,8 @@
 	for (i = 0; i < pdev->num_resources; i++) {
 		struct resource *p, *r = &pdev->resource[i];
 
-		r->name = pdev->dev.bus_id;
+		if (r->name == NULL)
+			r->name = pdev->dev.bus_id;
 
 		p = NULL;
 		if (r->flags & IORESOURCE_MEM)
@@ -308,3 +345,5 @@
 EXPORT_SYMBOL_GPL(platform_device_unregister);
 EXPORT_SYMBOL_GPL(platform_get_irq);
 EXPORT_SYMBOL_GPL(platform_get_resource);
+EXPORT_SYMBOL_GPL(platform_get_irq_byname);
+EXPORT_SYMBOL_GPL(platform_get_resource_byname);
diff -Nru a/drivers/net/gianfar.c b/drivers/net/gianfar.c
--- a/drivers/net/gianfar.c	2004-12-08 22:22:37 -06:00
+++ b/drivers/net/gianfar.c	2004-12-08 22:22:37 -06:00
@@ -85,6 +85,7 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -93,6 +94,7 @@
 #include <linux/version.h>
 #include <linux/dma-mapping.h>
 #include <linux/crc32.h>
+#include <linux/fsl_devices.h>
 
 #include "gianfar.h"
 #include "gianfar_phy.h"
@@ -130,8 +132,12 @@
 static void adjust_link(struct net_device *dev);
 static void init_registers(struct net_device *dev);
 static int init_phy(struct net_device *dev);
+#if 0
 static int gfar_probe(struct ocp_device *ocpdev);
 static void gfar_remove(struct ocp_device *ocpdev);
+#endif
+static int gfar_probe(struct device *device);
+static int gfar_remove(struct device *device);
 void free_skb_resources(struct gfar_private *priv);
 static void gfar_set_multi(struct net_device *dev);
 static void gfar_set_hash_for_addr(struct net_device *dev, u8 *addr);
@@ -148,6 +154,7 @@
 MODULE_DESCRIPTION("Gianfar Ethernet Driver");
 MODULE_LICENSE("GPL");
 
+#if 0
 /* Called by the ocp code to initialize device data structures
  * required for bringing up the device
  * returns 0 on success */
@@ -196,7 +203,7 @@
 	priv = netdev_priv(dev);
 
 	/* Set the info in the priv to the current info */
-	priv->einfo = einfo;
+	priv->einfo = pdev;
 
 	/* get a pointer to the register memory */
 	priv->regs = (struct gfar *)
@@ -343,6 +350,223 @@
 	iounmap((void *) priv->phyregs);
 	free_netdev(dev);
 }
+#endif
+
+static int gfar_probe(struct device *device)
+{
+	u32 tempval;
+	struct platform_device *mdiodev;
+	struct net_device *dev = NULL;
+	struct gfar_private *priv = NULL;
+	struct platform_device *pdev = to_platform_device(device);
+	struct gianfar_platform_data *pdinfo;
+	struct resource *r;
+	int idx;
+	int err = 0;
+	int dev_ethtool_ops = 0;
+
+	pdinfo = (struct gianfar_platform_data *) pdev->dev.platform_data;
+
+	if (pdinfo == NULL) {
+		printk(KERN_ERR "gfar %d: Missing additional data!\n",
+		       pdev->id);
+
+		return -ENODEV;
+	}
+	
+	/* get a pointer to the register memory which can
+	 * configure the PHYs.  If it's different from this set,
+	 * get the device which has those regs */
+	if ((pdinfo->phyregidx >= 0) && 
+			(pdinfo->phyregidx != pdev->id)) {
+
+		/* xxx - broken, gregkh tells me device_find has locking issues */
+		/* only enable the 1st TSEC for now */
+		struct device *d = device_find(pdinfo->phydevice, &platform_bus_type);
+
+		mdiodev = to_platform_device(d);
+
+		/* If the device which holds the MDIO regs isn't
+		 * up, wait for it to come up */
+		if (mdiodev == NULL)
+			return -EAGAIN;
+	} else {
+		mdiodev = pdev;
+	}
+
+	/* Create an ethernet device instance */
+	dev = alloc_etherdev(sizeof (*priv));
+
+	if (dev == NULL)
+		return -ENOMEM;
+
+	priv = netdev_priv(dev);
+
+	/* fill out IRQ fields */
+
+	if (pdev->flags & GFAR_HAS_MULTI_INTR) {
+		priv->interruptTransmit = platform_get_irq_byname(pdev, "tx");
+		priv->interruptReceive = platform_get_irq_byname(pdev, "rx");
+		priv->interruptError = platform_get_irq_byname(pdev, "error");
+	} else {
+		priv->interruptTransmit = platform_get_irq(pdev, 0);
+	}
+
+	/* Set the info in the priv to the current info */
+	priv->einfo = pdev;
+	priv->pdinfo = pdinfo;
+
+	/* get a pointer to the register memory */
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs = (struct gfar *)
+		ioremap(r->start, sizeof (struct gfar));
+
+	if (priv->regs == NULL) {
+		err = -ENOMEM;
+		goto regs_fail;
+	}
+
+	/* Set the PHY base address */
+	r = platform_get_resource(mdiodev, IORESOURCE_MEM, 0);
+	priv->phyregs = (struct gfar *)
+	    ioremap(r->start, sizeof (struct gfar));
+
+	if (priv->phyregs == NULL) {
+		err = -ENOMEM;
+		goto phy_regs_fail;
+	}
+
+	spin_lock_init(&priv->lock);
+
+	dev_set_drvdata(device, dev);
+
+	/* Stop the DMA engine now, in case it was running before */
+	/* (The firmware could have used it, and left it running). */
+	/* To do this, we write Graceful Receive Stop and Graceful */
+	/* Transmit Stop, and then wait until the corresponding bits */
+	/* in IEVENT indicate the stops have completed. */
+	tempval = gfar_read(&priv->regs->dmactrl);
+	tempval &= ~(DMACTRL_GRS | DMACTRL_GTS);
+	gfar_write(&priv->regs->dmactrl, tempval);
+
+	tempval = gfar_read(&priv->regs->dmactrl);
+	tempval |= (DMACTRL_GRS | DMACTRL_GTS);
+	gfar_write(&priv->regs->dmactrl, tempval);
+
+	while (!(gfar_read(&priv->regs->ievent) & (IEVENT_GRSC | IEVENT_GTSC)))
+		cpu_relax();
+
+	/* Reset MAC layer */
+	gfar_write(&priv->regs->maccfg1, MACCFG1_SOFT_RESET);
+
+	tempval = (MACCFG1_TX_FLOW | MACCFG1_RX_FLOW);
+	gfar_write(&priv->regs->maccfg1, tempval);
+
+	/* Initialize MACCFG2. */
+	gfar_write(&priv->regs->maccfg2, MACCFG2_INIT_SETTINGS);
+
+	/* Initialize ECNTRL */
+	gfar_write(&priv->regs->ecntrl, ECNTRL_INIT_SETTINGS);
+
+	/* Copy the station address into the dev structure, */
+	memcpy(dev->dev_addr, pdinfo->mac_addr, MAC_ADDR_LEN);
+
+	/* Set the dev->base_addr to the gfar reg region */
+	dev->base_addr = (unsigned long) (priv->regs);
+
+	SET_MODULE_OWNER(dev);
+	SET_NETDEV_DEV(dev, device);
+
+	/* Fill in the dev structure */
+	dev->open = gfar_enet_open;
+	dev->hard_start_xmit = gfar_start_xmit;
+	dev->tx_timeout = gfar_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
+#ifdef CONFIG_GFAR_NAPI
+	dev->poll = gfar_poll;
+	dev->weight = GFAR_DEV_WEIGHT;
+#endif
+	dev->stop = gfar_close;
+	dev->get_stats = gfar_get_stats;
+	dev->change_mtu = gfar_change_mtu;
+	dev->mtu = 1500;
+	dev->set_multicast_list = gfar_set_multi;
+
+	/* Index into the array of possible ethtool
+	 * ops to catch all 4 possibilities */
+	if((priv->einfo->flags & GFAR_HAS_RMON) == 0)
+		dev_ethtool_ops += 1;
+
+	if((priv->einfo->flags & GFAR_HAS_COALESCE) == 0)
+		dev_ethtool_ops += 2;
+
+	dev->ethtool_ops = gfar_op_array[dev_ethtool_ops];
+
+	priv->rx_buffer_size = DEFAULT_RX_BUFFER_SIZE;
+#ifdef CONFIG_GFAR_BUFSTASH
+	priv->rx_stash_size = STASH_LENGTH;
+#endif
+	priv->tx_ring_size = DEFAULT_TX_RING_SIZE;
+	priv->rx_ring_size = DEFAULT_RX_RING_SIZE;
+
+	priv->txcoalescing = DEFAULT_TX_COALESCE;
+	priv->txcount = DEFAULT_TXCOUNT;
+	priv->txtime = DEFAULT_TXTIME;
+	priv->rxcoalescing = DEFAULT_RX_COALESCE;
+	priv->rxcount = DEFAULT_RXCOUNT;
+	priv->rxtime = DEFAULT_RXTIME;
+
+	err = register_netdev(dev);
+
+	if (err) {
+		printk(KERN_ERR "%s: Cannot register net device, aborting.\n",
+				dev->name);
+		goto register_fail;
+	}
+
+	/* Print out the device info */
+	printk(KERN_INFO DEVICE_NAME, dev->name);
+	for (idx = 0; idx < 6; idx++)
+		printk("%2.2x%c", dev->dev_addr[idx], idx == 5 ? ' ' : ':');
+	printk("\n");
+
+	/* Even more device info helps when determining which kernel */
+	/* provided which set of benchmarks.  Since this is global for all */
+	/* devices, we only print it once */
+#ifdef CONFIG_GFAR_NAPI
+	printk(KERN_INFO "%s: Running with NAPI enabled\n", dev->name);
+#else
+	printk(KERN_INFO "%s: Running with NAPI disabled\n", dev->name);
+#endif
+	printk(KERN_INFO "%s: %d/%d RX/TX BD ring size\n",
+	       dev->name, priv->rx_ring_size, priv->tx_ring_size);
+
+	return 0;
+
+register_fail:
+	iounmap((void *) priv->phyregs);
+phy_regs_fail:
+	iounmap((void *) priv->regs);
+regs_fail:
+	free_netdev(dev);
+	return -ENOMEM;
+	return 0;
+}
+
+static int gfar_remove(struct device *device)
+{
+	struct net_device *dev = dev_get_drvdata(device);
+	struct gfar_private *priv = netdev_priv(dev);
+
+	dev_set_drvdata(device, NULL);
+
+	iounmap((void *) priv->regs);
+	iounmap((void *) priv->phyregs);
+	free_netdev(dev);
+
+	return 0;
+}
+
 
 /* Configure the PHY for dev.
  * returns 0 if success.  -1 if failure
@@ -381,7 +605,7 @@
 			ADVERTISED_1000baseT_Full);
 	mii_info->autoneg = 1;
 
-	mii_info->mii_id = priv->einfo->phyid;
+	mii_info->mii_id = priv->pdinfo->phyid;
 
 	mii_info->dev = dev;
 
@@ -549,15 +773,15 @@
 
 	/* Free the IRQs */
 	if (priv->einfo->flags & GFAR_HAS_MULTI_INTR) {
-		free_irq(priv->einfo->interruptError, dev);
-		free_irq(priv->einfo->interruptTransmit, dev);
-		free_irq(priv->einfo->interruptReceive, dev);
+		free_irq(priv->interruptError, dev);
+		free_irq(priv->interruptTransmit, dev);
+		free_irq(priv->interruptReceive, dev);
 	} else {
-		free_irq(priv->einfo->interruptTransmit, dev);
+		free_irq(priv->interruptTransmit, dev);
 	}
 
 	if (priv->einfo->flags & GFAR_HAS_PHY_INTR) {
-		free_irq(priv->einfo->interruptPHY, dev);
+		free_irq(priv->pdinfo->interruptPHY, dev);
 	} else {
 		del_timer_sync(&priv->phy_info_timer);
 	}
@@ -730,38 +954,38 @@
 	if (priv->einfo->flags & GFAR_HAS_MULTI_INTR) {
 		/* Install our interrupt handlers for Error, 
 		 * Transmit, and Receive */
-		if (request_irq(priv->einfo->interruptError, gfar_error,
+		if (request_irq(priv->interruptError, gfar_error,
 				0, "enet_error", dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d\n",
-			       dev->name, priv->einfo->interruptError);
+			       dev->name, priv->interruptError);
 
 			err = -1;
 			goto err_irq_fail;
 		}
 
-		if (request_irq(priv->einfo->interruptTransmit, gfar_transmit,
+		if (request_irq(priv->interruptTransmit, gfar_transmit,
 				0, "enet_tx", dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d\n",
-			       dev->name, priv->einfo->interruptTransmit);
+			       dev->name, priv->interruptTransmit);
 
 			err = -1;
 
 			goto tx_irq_fail;
 		}
 
-		if (request_irq(priv->einfo->interruptReceive, gfar_receive,
+		if (request_irq(priv->interruptReceive, gfar_receive,
 				0, "enet_rx", dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d (receive0)\n",
-			       dev->name, priv->einfo->interruptReceive);
+			       dev->name, priv->interruptReceive);
 
 			err = -1;
 			goto rx_irq_fail;
 		}
 	} else {
-		if (request_irq(priv->einfo->interruptTransmit, gfar_interrupt,
+		if (request_irq(priv->interruptTransmit, gfar_interrupt,
 				0, "gfar_interrupt", dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d\n",
-			       dev->name, priv->einfo->interruptError);
+			       dev->name, priv->interruptError);
 
 			err = -1;
 			goto err_irq_fail;
@@ -815,9 +1039,9 @@
 	return 0;
 
 rx_irq_fail:
-	free_irq(priv->einfo->interruptTransmit, dev);
+	free_irq(priv->interruptTransmit, dev);
 tx_irq_fail:
-	free_irq(priv->einfo->interruptError, dev);
+	free_irq(priv->interruptError, dev);
 err_irq_fail:
 rx_skb_fail:
 	free_skb_resources(priv);
@@ -1548,14 +1772,14 @@
 
 	/* Grab the PHY interrupt, if necessary/possible */
 	if (priv->einfo->flags & GFAR_HAS_PHY_INTR) {
-		if (request_irq(priv->einfo->interruptPHY, 
+		if (request_irq(priv->pdinfo->interruptPHY, 
 					phy_interrupt,
 					SA_SHIRQ, 
 					"phy_interrupt", 
 					mii_info->dev) < 0) {
 			printk(KERN_ERR "%s: Can't get IRQ %d (PHY)\n",
 					mii_info->dev->name,
-					priv->einfo->interruptPHY);
+					priv->pdinfo->interruptPHY);
 		} else {
 			mii_configure_phy_interrupt(priv->mii_info, 
 					MII_INTERRUPT_ENABLED);
@@ -1828,6 +2052,7 @@
 	return IRQ_HANDLED;
 }
 
+#if 0
 /* Structure for a device driver */
 static struct ocp_device_id gfar_ids[] = {
 	{.vendor = OCP_ANY_ID,.function = OCP_FUNC_GFAR},
@@ -1862,3 +2087,26 @@
 
 module_init(gfar_init);
 module_exit(gfar_exit);
+#endif 
+
+/* Structure for a device driver */
+static struct device_driver gfar_driver = {
+	.name = "fsl-gianfar",
+	.bus = &platform_bus_type,
+	.probe = gfar_probe,
+	.remove = gfar_remove,
+};
+
+static int __init gfar_init(void)
+{
+	return driver_register(&gfar_driver);
+}
+
+static void __exit gfar_exit(void)
+{
+	driver_unregister(&gfar_driver);
+}
+
+module_init(gfar_init);
+module_exit(gfar_exit);
+
diff -Nru a/drivers/net/gianfar.h b/drivers/net/gianfar.h
--- a/drivers/net/gianfar.h	2004-12-08 22:22:37 -06:00
+++ b/drivers/net/gianfar.h	2004-12-08 22:22:37 -06:00
@@ -510,7 +510,11 @@
 	unsigned int rxclean;
 
 	/* Info structure initialized by board setup code */
-	struct ocp_gfar_data *einfo;
+	unsigned int interruptTransmit;
+	unsigned int interruptReceive;
+	unsigned int interruptError;
+	struct platform_device *einfo;
+	struct gianfar_platform_data *pdinfo;
 
 	struct gfar_mii_info *mii_info;
 	int oldspeed;
diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h	2004-12-08 22:22:37 -06:00
+++ b/include/asm-ppc/mpc85xx.h	2004-12-08 22:22:37 -06:00
@@ -103,6 +103,14 @@
 #define MPC85xx_CPM_SIZE	(0x40000)
 #define MPC85xx_DMA_OFFSET	(0x21000)
 #define MPC85xx_DMA_SIZE	(0x01000)
+#define MPC85xx_DMA0_OFFSET	(0x21100)
+#define MPC85xx_DMA0_SIZE	(0x00080)
+#define MPC85xx_DMA1_OFFSET	(0x21180)
+#define MPC85xx_DMA1_SIZE	(0x00080)
+#define MPC85xx_DMA2_OFFSET	(0x21200)
+#define MPC85xx_DMA2_SIZE	(0x00080)
+#define MPC85xx_DMA3_OFFSET	(0x21280)
+#define MPC85xx_DMA3_SIZE	(0x00080)
 #define MPC85xx_ENET1_OFFSET	(0x24000)
 #define MPC85xx_ENET1_SIZE	(0x01000)
 #define MPC85xx_ENET2_OFFSET	(0x25000)
@@ -138,6 +146,17 @@
 #else
 #define CCSRBAR BOARD_CCSRBAR
 #endif
+
+enum mpc85xx_devices {
+	MPC85xx_TSEC1,
+	MPC85xx_TSEC2,
+	MPC85xx_FEC,
+	MPC85xx_IIC1,
+	MPC85xx_DMA0,
+	MPC85xx_DMA1,
+	MPC85xx_DMA2,
+	MPC85xx_DMA3,
+};
 
 #endif /* CONFIG_85xx */
 #endif /* __ASM_MPC85xx_H__ */
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-12-08 22:22:37 -06:00
+++ b/include/linux/device.h	2004-12-08 22:22:37 -06:00
@@ -370,6 +370,7 @@
 	struct device	dev;
 	u32		num_resources;
 	struct resource	* resource;
+	u32		flags;
 };
 
 #define to_platform_device(x) container_of((x), struct platform_device, dev)
@@ -382,6 +383,8 @@
 
 extern struct resource *platform_get_resource(struct platform_device *, unsigned int, unsigned int);
 extern int platform_get_irq(struct platform_device *, unsigned int);
+extern struct resource *platform_get_resource_byname(struct platform_device *, unsigned int, char *);
+extern int platform_get_irq_byname(struct platform_device *, char *);
 extern int platform_add_devices(struct platform_device **, int);
 
 extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);
diff -Nru a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/fsl_devices.h	2004-12-08 22:22:37 -06:00
@@ -0,0 +1,48 @@
+/*
+ * include/linux/fsl_devices.h
+ *
+ * Definitions for any platform device related flags or structures for 
+ * Freescale processor devices
+ *
+ * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _FSL_DEVICE_H_
+#define _FSL_DEVICE_H_
+
+/* A table of information for supporting the Gianfar Ethernet Controller
+ * This helps identify which enet controller we are dealing with,
+ * and what type of enet controller it is
+ */
+struct gianfar_platform_data {
+	u32 flags;
+	u32 phyid;
+	uint interruptPHY;
+	uint phyregidx;
+	char * phydevice;
+	unsigned char mac_addr[6];
+};
+
+/* Flags related to gianfar device features */
+#define GIANFAR_HAS_GIGABIT		0x00000001
+#define GIANFAR_HAS_COALESCE		0x00000002
+#define GIANFAR_HAS_RMON		0x00000004
+#define GIANFAR_HAS_MULTI_INTR		0x00000008
+
+/* Flags in gianfar_platform_data */
+#define GIANFAR_PDATA_HAS_PHY_INTR	0x00000001	/* if not set use a timer */
+
+/* Flags related to I2C device features */
+#define FSL_I2C_SEPARATE_DFSRR		0x00000001
+#define FSL_I2C_CLOCK_5200		0x00000002
+
+#endif	/* _FSL_DEVICE_H_ */
+#endif	/* __KERNEL__ */
