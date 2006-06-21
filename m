Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWFUO0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWFUO0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWFUO0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:30 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751607AbWFUO00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:26 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 15/21] [MMC] More DMA capabilities tests
Date: Wed, 21 Jun 2006 16:26:25 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142625.8857.71901.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Properly test for controller interface to see if it's DMA capable. As many
controllers are misconfigured in this regard, also add debug parameters to
force DMA support either way.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   30 +++++++++++++++++++++++++++++-
 drivers/mmc/sdhci.h |    4 ++++
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 7b55691..04d79a2 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -28,6 +28,9 @@ #define BUGMAIL "<sdhci-devel@list.drzeu
 #define DBG(f, x...) \
 	pr_debug(DRIVER_NAME " [%s()]: " f, __func__,## x)
 
+static unsigned int debug_nodma = 0;
+static unsigned int debug_forcedma = 0;
+
 static const struct pci_device_id pci_ids[] __devinitdata = {
 	/* handle any SD host controller */
 	{PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)},
@@ -1105,6 +1108,16 @@ static int __devinit sdhci_probe_slot(st
 		return -ENODEV;
 	}
 
+	if ((pdev->class & 0x0000FF) == PCI_SDHCI_IFVENDOR) {
+		printk(KERN_ERR DRIVER_NAME ": Vendor specific interface. Aborting.\n");
+		return -ENODEV;
+	}
+
+	if ((pdev->class & 0x0000FF) > PCI_SDHCI_IFVENDOR) {
+		printk(KERN_ERR DRIVER_NAME ": Unknown interface. Aborting.\n");
+		return -ENODEV;
+	}
+
 	mmc = mmc_alloc_host(sizeof(struct sdhci_host), &pdev->dev);
 	if (!mmc)
 		return -ENOMEM;
@@ -1146,7 +1159,16 @@ static int __devinit sdhci_probe_slot(st
 
 	caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
 
-	if ((caps & SDHCI_CAN_DO_DMA) && ((pdev->class & 0x0000FF) == 0x01))
+	if (debug_nodma)
+		DBG("DMA forced off\n");
+	else if (debug_forcedma) {
+		DBG("DMA forced on\n");
+		host->flags |= SDHCI_USE_DMA;
+	} else if ((pdev->class & 0x0000FF) != PCI_SDHCI_IFDMA)
+		DBG("Controller doesn't have DMA interface\n");
+	else if (!(caps & SDHCI_CAN_DO_DMA))
+		DBG("Controller doesn't have DMA capability\n");
+	else
 		host->flags |= SDHCI_USE_DMA;
 
 	if (host->flags & SDHCI_USE_DMA) {
@@ -1429,7 +1451,13 @@ static void __exit sdhci_drv_exit(void)
 module_init(sdhci_drv_init);
 module_exit(sdhci_drv_exit);
 
+module_param(debug_nodma, uint, 0444);
+module_param(debug_forcedma, uint, 0444);
+
 MODULE_AUTHOR("Pierre Ossman <drzeus@drzeus.cx>");
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface driver");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL");
+
+MODULE_PARM_DESC(debug_nodma, "Forcefully disable DMA transfers. (default 0)");
+MODULE_PARM_DESC(debug_forcedma, "Forcefully enable DMA transfers. (default 0)");
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index 758cf1c..8111fa3 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -12,6 +12,10 @@
  * PCI registers
  */
 
+#define PCI_SDHCI_IFPIO			0x00
+#define PCI_SDHCI_IFDMA			0x01
+#define PCI_SDHCI_IFVENDOR		0x02
+
 #define PCI_SLOT_INFO			0x40	/* 8 bits */
 #define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
 #define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07

