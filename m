Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbULHXQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbULHXQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbULHXQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:16:37 -0500
Received: from motgate8.mot.com ([129.188.136.8]:45726 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261402AbULHXQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:16:24 -0500
Date: Wed, 8 Dec 2004 17:16:16 -0600 (CST)
From: Kumar Gala <galak@linen.sps.mot.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rmk@arm.linux.org.uk, greg@kroah.com
Subject: [RFC][PATCH] Add platform_get_resource_byname & platform_get_resource_byirq
Message-ID: <Pine.LNX.4.61.0412081703030.4040@linen.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the ability to find a resource or irq on a platform device by its 
resource name.  This patch also tweaks how resource names get set.  
Before, resources names were set to pdev->dev.bus_id, now that only 
happens if the resource name has not been previous set.

All of this allows us to find a resource without assuming what order the 
resources are in.

Signed-off-by; Kumar Gala <kumar.gala@freescale.com>

-- 

diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-12-08 16:59:52 -06:00
+++ b/drivers/base/platform.c	2004-12-08 16:59:52 -06:00
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
diff -Nru a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/fsl_devices.h	2004-12-08 16:59:52 -06:00
@@ -0,0 +1,49 @@
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
+#define GIANFAR_PDATA_FIRM_SET_MACADDR	0x00000001
+#define GIANFAR_PDATA_HAS_PHY_INTR	0x00000002	/* if not set use a timer */
+
+/* Flags related to I2C device features */
+#define FSL_I2C_SEPARATE_DFSRR		0x00000001
+#define FSL_I2C_CLOCK_5200		0x00000002
+
+#endif	/* _FSL_DEVICE_H_ */
+#endif	/* __KERNEL__ */
