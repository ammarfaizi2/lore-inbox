Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTJFTDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTJFTDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:03:45 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:23815 "EHLO
	anchor-post-37.mail.demon.net") by vger.kernel.org with ESMTP
	id S261360AbTJFTDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:03:15 -0400
Reply-To: <mail@davehatton.it>
From: "Dave Hatton" <mail@davehatton.it>
To: <linux-kernel@vger.kernel.org>
Subject: PNPBIOS patch causing problem with laptop
Date: Mon, 6 Oct 2003 20:04:56 +0100
Message-ID: <NCBBJGBIBFKKILGAFKOBKEEGECAA.mail@davehatton.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm having a problem with my laptop but I've hit a brick wall in trying to
solve it.

The problem manifests in two ways.

1)When I'm running the laptop from mains A/C and I remove the mains A/C
lead, in order to switch to battery power, the laptop locks solid.
  There are no errors or logs.
2)If I use the "reboot" command, the laptop shuts down, begins to start up,
runs its bios memory checks, and then locks solid.

(the laptop in question is a Mitac M722)

I have reproduced the problem on a number of releases up to and including
2.6.0-test6-mm2.
I can't reproduce it at 2.5.56 or below or on any 2.4 kernels.
By trial and error I have now found the problem (appears) to be caused by a
pnpbios patch introduced in 2.5.57
I need some help to understand what this patch is trying to do and how to
fix the problem.

TIA
Daveh

--------------------------------------------
cut ---------------------------------------
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Mon Jan 13 10:18:05 2003
+++ b/drivers/pnp/pnpbios/core.c	Mon Jan 13 10:18:05 2003
@@ -671,9 +671,10 @@
  static void add_irqresource(struct pnp_dev *dev, int irq)
  {
  	int i = 0;
-	while (!(dev->irq_resource[i].flags & IORESOURCE_UNSET) && i <
DEVICE_COUNT_IRQ) i++;
+	while (pnp_irq_valid(dev, i) && i < DEVICE_COUNT_IRQ) i++;
  	if (i < DEVICE_COUNT_IRQ) {
-		dev->irq_resource[i].start = (unsigned long) irq;
+		dev->irq_resource[i].start =
+		dev->irq_resource[i].end = (unsigned long) irq;
  		dev->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
  	}
  }
@@ -681,9 +682,10 @@
  static void add_dmaresource(struct pnp_dev *dev, int dma)
  {
  	int i = 0;
-	while (!(dev->dma_resource[i].flags & IORESOURCE_UNSET) && i <
DEVICE_COUNT_DMA) i++;
+	while (pnp_dma_valid(dev, i) && i < DEVICE_COUNT_DMA) i++;
  	if (i < DEVICE_COUNT_DMA) {
-		dev->dma_resource[i].start = (unsigned long) dma;
+		dev->dma_resource[i].start =
+		dev->dma_resource[i].end = (unsigned long) dma;
  		dev->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
  	}
  }
@@ -691,22 +693,22 @@
  static void add_ioresource(struct pnp_dev *dev, int io, int len)
  {
  	int i = 0;
-	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i <
DEVICE_COUNT_RESOURCE) i++;
+	while (pnp_port_valid(dev, i) && i < DEVICE_COUNT_IO) i++;
  	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->resource[i].start = (unsigned long) io;
-		dev->resource[i].end = (unsigned long)(io + len - 1);
-		dev->resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		dev->io_resource[i].start = (unsigned long) io;
+		dev->io_resource[i].end = (unsigned long)(io + len - 1);
+		dev->io_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
  	}
  }

  static void add_memresource(struct pnp_dev *dev, int mem, int len)
  {
-	int i = 8;
-	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i <
DEVICE_COUNT_RESOURCE) i++;
+	int i = 0;
+	while (pnp_mem_valid(dev, i) && i < DEVICE_COUNT_MEM) i++;
  	if (i < DEVICE_COUNT_RESOURCE) {
-		dev->resource[i].start = (unsigned long) mem;
-		dev->resource[i].end = (unsigned long)(mem + len - 1);
-		dev->resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+		dev->mem_resource[i].start = (unsigned long) mem;
+		dev->mem_resource[i].end = (unsigned long)(mem + len - 1);
+		dev->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
  	}
  }

@@ -718,17 +720,25 @@
  	/*
  	 * First, set resource info to default values
  	 */
-	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
-		dev->resource[i].start = 0;  // "disabled"
-		dev->resource[i].flags = IORESOURCE_UNSET;
+	for (i=0;i<DEVICE_COUNT_IO;i++) {
+		dev->io_resource[i].start = 0;
+		dev->io_resource[i].end = 0;
+		dev->io_resource[i].flags = IORESOURCE_IO|IORESOURCE_UNSET;
+	}
+	for (i=0;i<DEVICE_COUNT_MEM;i++) {
+		dev->mem_resource[i].start = 0;
+		dev->mem_resource[i].end = 0;
+		dev->mem_resource[i].flags = IORESOURCE_MEM|IORESOURCE_UNSET;
  	}
  	for (i=0;i<DEVICE_COUNT_IRQ;i++) {
-		dev->irq_resource[i].start = (unsigned long)-1;  // "disabled"
-		dev->irq_resource[i].flags = IORESOURCE_UNSET;
+		dev->irq_resource[i].start = (unsigned long)-1;
+		dev->irq_resource[i].end = (unsigned long)-1;
+		dev->irq_resource[i].flags = IORESOURCE_IRQ|IORESOURCE_UNSET;
  	}
  	for (i=0;i<DEVICE_COUNT_DMA;i++) {
-		dev->dma_resource[i].start = (unsigned long)-1;  // "disabled"
-		dev->dma_resource[i].flags = IORESOURCE_UNSET;
+		dev->dma_resource[i].start = (unsigned long)-1;
+		dev->dma_resource[i].end = (unsigned long)-1;
+		dev->dma_resource[i].flags = IORESOURCE_DMA|IORESOURCE_UNSET;
  	}

  	/*
@@ -815,10 +825,10 @@

          } /* while */
  	end:
-	if ((dev->resource[0].start == 0) &&
-	    (dev->resource[8].start == 0) &&
-	    (dev->irq_resource[0].start == -1) &&
-	    (dev->dma_resource[0].start == -1))
+	if (pnp_port_valid(dev, 0) == 0 &&
+	    pnp_mem_valid(dev, 0) == 0 &&
+	    pnp_irq_valid(dev, 0) == 0 &&
+	    pnp_dma_valid(dev, 0) == 0)
  		dev->active = 0;
  	else
  		dev->active = 1;
@@ -1261,9 +1271,7 @@
  	struct pnp_bios_node * node;

  	/* just in case */
-	if(pnp_dev_has_driver(dev))
-		return -EBUSY;
-	if(!pnp_is_dynamic(dev))
+	if(!pnpbios_is_dynamic(dev))
  		return -EPERM;
  	if (pnp_bios_dev_node_info(&node_info) != 0)
  		return -ENODEV;
@@ -1277,16 +1285,14 @@
  	return 0;
  }

-static int pnpbios_set_resources(struct pnp_dev *dev, struct pnp_cfg
*config, char flags)
+static int pnpbios_set_resources(struct pnp_dev *dev, struct pnp_cfg
*config)
  {
  	struct pnp_dev_node_info node_info;
  	u8 nodenum = dev->number;
  	struct pnp_bios_node * node;

  	/* just in case */
-	if(pnp_dev_has_driver(dev))
-		return -EBUSY;
-	if (flags == PNP_DYNAMIC && !pnp_is_dynamic(dev))
+	if (!pnpbios_is_dynamic(dev))
  		return -EPERM;
  	if (pnp_bios_dev_node_info(&node_info) != 0)
  		return -ENODEV;
@@ -1338,9 +1344,7 @@
  	if (!config)
  		return -1;
  	/* just in case */
-	if(pnp_dev_has_driver(dev))
-		return -EBUSY;
-	if(dev->flags & PNP_NO_DISABLE || !pnp_is_dynamic(dev))
+	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
  		return -EPERM;
  	memset(config, 0, sizeof(struct pnp_cfg));
  	if (!dev || !dev->active)
@@ -1449,6 +1453,15 @@
  		pos = node_possible_resource_data_to_dev(pos,node,dev);
  		node_id_data_to_dev(pos,node,dev);
  		dev->flags = node->flags;
+		if (!(dev->flags & PNPBIOS_NO_CONFIG))
+			dev->capabilities |= PNP_CONFIGURABLE;
+		if (!(dev->flags & PNPBIOS_NO_DISABLE))
+			dev->capabilities |= PNP_DISABLE;
+		dev->capabilities |= PNP_READ;
+		if (pnpbios_is_dynamic(dev))
+			dev->capabilities |= PNP_WRITE;
+		if (dev->flags & PNPBIOS_REMOVABLE)
+			dev->capabilities |= PNP_REMOVABLE;

  		dev->protocol = &pnpbios_protocol;

diff -Nru a/include/linux/pnpbios.h b/include/linux/pnpbios.h
--- a/include/linux/pnpbios.h	Mon Jan 13 10:18:05 2003
+++ b/include/linux/pnpbios.h	Mon Jan 13 10:18:05 2003
@@ -78,15 +78,15 @@
  /*
   * Plug and Play BIOS flags
   */
-#define PNP_NO_DISABLE		0x0001
-#define PNP_NO_CONFIG		0x0002
-#define PNP_OUTPUT		0x0004
-#define PNP_INPUT		0x0008
-#define PNP_BOOTABLE		0x0010
-#define PNP_DOCK		0x0020
-#define PNP_REMOVABLE		0x0040
-#define pnp_is_static(x) (x->flags & 0x0100) == 0x0000
-#define pnp_is_dynamic(x) x->flags & 0x0080
+#define PNPBIOS_NO_DISABLE		0x0001
+#define PNPBIOS_NO_CONFIG		0x0002
+#define PNPBIOS_OUTPUT			0x0004
+#define PNPBIOS_INPUT			0x0008
+#define PNPBIOS_BOOTABLE		0x0010
+#define PNPBIOS_DOCK			0x0020
+#define PNPBIOS_REMOVABLE		0x0040
+#define pnpbios_is_static(x) ((x)->flags & 0x0100) == 0x0000
+#define pnpbios_is_dynamic(x) (x)->flags & 0x0080

  /* 0x8000 through 0xffff are OEM defined */
----------------------------------------------------------------------------
------------


