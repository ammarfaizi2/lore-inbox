Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWFUObA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWFUObA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWFUO0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:33 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751604AbWFUO0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:17 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 13/21] [MMC] Check controller version
Date: Wed, 21 Jun 2006 16:26:18 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142618.8857.8630.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check the interface version of the controller and bail out if it's an
unknown version.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   11 +++++++++++
 drivers/mmc/sdhci.h |    4 ++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 41addde..0c19e27 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -1073,6 +1073,7 @@ #endif /* CONFIG_PM */
 static int __devinit sdhci_probe_slot(struct pci_dev *pdev, int slot)
 {
 	int ret;
+	unsigned int version;
 	struct sdhci_chip *chip;
 	struct mmc_host *mmc;
 	struct sdhci_host *host;
@@ -1131,6 +1132,16 @@ static int __devinit sdhci_probe_slot(st
 		goto release;
 	}
 
+	version = readw(host->ioaddr + SDHCI_HOST_VERSION);
+	version = (version & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
+	if (version != 0) {
+		printk(KERN_ERR "%s: Unknown controller version (%d). "
+			"Cowardly refusing to continue.\n", host->slot_descr,
+			version);
+		ret = -ENODEV;
+		goto unmap;
+	}
+
 	caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
 
 	if ((caps & SDHCI_CAN_DO_DMA) && ((pdev->class & 0x0000FF) == 0x01))
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index b1aa3ac..758cf1c 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -149,6 +149,10 @@ #define SDHCI_MAX_CURRENT	0x48
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
+#define  SDHCI_VENDOR_VER_MASK	0xFF00
+#define  SDHCI_VENDOR_VER_SHIFT	8
+#define  SDHCI_SPEC_VER_MASK	0x00FF
+#define  SDHCI_SPEC_VER_SHIFT	0
 
 struct sdhci_chip;
 

