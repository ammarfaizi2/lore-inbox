Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWFUO1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWFUO1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWFUO1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:27:01 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751599AbWFUO0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:43 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 20/21] [MMC] Force DMA on some controllers
Date: Wed, 21 Jun 2006 16:26:44 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142643.8857.23022.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers incorrectly report that the cannot do DMA. Forcefully
enable it for those that we know it works fine on.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 617a588..60d838c 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -33,6 +33,7 @@ static unsigned int debug_forcedma = 0;
 static unsigned int debug_quirks = 0;
 
 #define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
+#define SDHCI_QUIRK_FORCE_DMA				(1<<1)
 
 static const struct pci_device_id pci_ids[] __devinitdata = {
 	{
@@ -40,7 +41,24 @@ static const struct pci_device_id pci_id
 		.device		= PCI_DEVICE_ID_RICOH_R5C822,
 		.subvendor	= PCI_VENDOR_ID_IBM,
 		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SDHCI_QUIRK_CLOCK_BEFORE_RESET,
+		.driver_data	= SDHCI_QUIRK_CLOCK_BEFORE_RESET |
+				  SDHCI_QUIRK_FORCE_DMA,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_RICOH,
+		.device		= PCI_DEVICE_ID_RICOH_R5C822,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SDHCI_QUIRK_FORCE_DMA,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_TI,
+		.device		= PCI_DEVICE_ID_TI_XX21_XX11_SD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SDHCI_QUIRK_FORCE_DMA,
 	},
 
 	{	/* Generic SD host controller */
@@ -1190,7 +1208,9 @@ static int __devinit sdhci_probe_slot(st
 	else if (debug_forcedma) {
 		DBG("DMA forced on\n");
 		host->flags |= SDHCI_USE_DMA;
-	} else if ((pdev->class & 0x0000FF) != PCI_SDHCI_IFDMA)
+	} else if (chip->quirks & SDHCI_QUIRK_FORCE_DMA)
+		host->flags |= SDHCI_USE_DMA;
+	else if ((pdev->class & 0x0000FF) != PCI_SDHCI_IFDMA)
 		DBG("Controller doesn't have DMA interface\n");
 	else if (!(caps & SDHCI_CAN_DO_DMA))
 		DBG("Controller doesn't have DMA capability\n");

