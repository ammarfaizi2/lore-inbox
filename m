Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266280AbSKGB4n>; Wed, 6 Nov 2002 20:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266282AbSKGB4n>; Wed, 6 Nov 2002 20:56:43 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:39044 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266280AbSKGB4k>;
	Wed, 6 Nov 2002 20:56:40 -0500
Date: Wed, 6 Nov 2002 21:06:39 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] pnp.h changes - 2.5.46 (4/6)
Message-ID: <20021106210639.GO316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up pnp.h.  It adds new resource macros.  Also it uses 
driver_data from the driver model instead of a local one.  Please everyone use 
the new macros instead of directly reading the structure.

Thanks,
Adam



--- a/include/linux/pnp.h	Wed Oct 30 22:43:17 2002
+++ b/include/linux/pnp.h	Sun Nov  3 10:39:16 2002
@@ -1,3 +1,9 @@
+/*
+ * Linux Plug and Play Support
+ * Copyright by Adam Belay <ambx1@neo.rr.com>
+ *
+ */
+
 #ifndef _LINUX_PNP_H
 #define _LINUX_PNP_H
 
@@ -7,7 +13,9 @@
 #include <linux/list.h>
 
 
-/* Device Managemnt */
+/*
+ * Device Managemnt 
+ */
 
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2
@@ -51,7 +59,6 @@
 
 	struct pnp_driver * driver;	/* which driver has allocated this device */
 	struct	device	    dev;	/* Driver Model device interface */
-	void  		  * driver_data;/* data private to the driver */
 	void		  * protocol_data;
 	int		    flags;	/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
@@ -66,18 +73,35 @@
 	dev != global_to_pnp_dev(&pnp_global); \
 	dev = global_to_pnp_dev(dev->global_list.next))
 
+static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
+{
+	return pdev->dev.driver_data;
+}
+
+static inline void pnp_set_drvdata (struct pnp_dev *pdev, void *data)
+{
+	pdev->dev.driver_data = data;
+}
+
+static inline void *pnp_get_protodata (struct pnp_dev *pdev)
+{
+	return pdev->protocol_data;
+}
+
+static inline void pnp_set_protodata (struct pnp_dev *pdev, void *data)
+{
+	pdev->protocol_data = data;
+}
+
 struct pnp_fixup {
 	char id[7];
 	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
 };
 
-/*
- * Linux Plug and Play Support
- * Copyright by Adam Belay <ambx1@neo.rr.com>
- *
- */
 
-/* Driver Management */
+/* 
+ * Driver Management
+ */
 
 #define pnpc_device_id pnp_id		/* for module.h */
 #define pnp_device_id pnp_id		/* for module.h */
@@ -104,12 +128,38 @@
 #define	to_pnp_driver(drv) container_of(drv,struct pnp_driver, driver)
 
 
-/* Resource Management */
+/*
+ * Resource Management
+ */
+
+/* Use these instead of directly reading pnp_dev to get resource information */
+#define pnp_port_start(dev,bar)   ((dev)->resource[(bar)].start)
+#define pnp_port_end(dev,bar)     ((dev)->resource[(bar)].end)
+#define pnp_port_flags(dev,bar)   ((dev)->resource[(bar)].flags)
+#define pnp_port_len(dev,bar) \
+	((pnp_port_start((dev),(bar)) == 0 &&	\
+	  pnp_port_end((dev),(bar)) ==		\
+	  pnp_port_start((dev),(bar))) ? 0 :	\
+	  					\
+	 (pnp_port_end((dev),(bar)) -		\
+	  pnp_port_start((dev),(bar)) + 1))
+
+#define pnp_mem_start(dev,bar)   ((dev)->resource[(bar+8)].start)
+#define pnp_mem_end(dev,bar)     ((dev)->resource[(bar+8)].end)
+#define pnp_mem_flags(dev,bar)   ((dev)->resource[(bar+8)].flags)
+#define pnp_mem_len(dev,bar) \
+	((pnp_mem_start((dev),(bar)) == 0 &&	\
+	  pnp_mem_end((dev),(bar)) ==		\
+	  pnp_mem_start((dev),(bar))) ? 0 :	\
+	  					\
+	 (pnp_mem_end((dev),(bar)) -		\
+	  pnp_mem_start((dev),(bar)) + 1))
+
+#define pnp_irq(dev,bar)	 ((dev)->irq_resource[(bar)].start)
+#define pnp_irq_flags(dev,bar)	 ((dev)->irq_resource[(bar)].flags)
 
-#define DEV_IO(dev, index) (dev->resource[index].start)
-#define DEV_MEM(dev, index) (dev->resource[index+8].start)
-#define DEV_IRQ(dev, index) (dev->irq_resource[index].start)
-#define DEV_DMA(dev, index) (dev->dma_resource[index].start)
+#define pnp_dma(dev,bar)	 ((dev)->dma_resource[(bar)].start)
+#define pnp_dma_flags(dev,bar)	 ((dev)->dma_resource[(bar)].flags)
 
 #define PNP_PORT_FLAG_16BITADDR	(1<<0)
 #define PNP_PORT_FLAG_FIXED	(1<<1)
@@ -186,7 +236,9 @@
 };
 
 
-/* Protocol Management */
+/* 
+ * Protocol Management
+ */
 
 struct pnp_protocol {
 	struct list_head	protocol_list;
@@ -262,6 +314,7 @@
 #endif /* CONFIG_PNP */
 
 #if defined(CONFIG_ISAPNP)
+
 /* compat */
 struct pnp_card *pnp_find_card(unsigned short vendor,
 				 unsigned short device,
