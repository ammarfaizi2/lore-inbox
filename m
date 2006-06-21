Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWFUObE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWFUObE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWFUO0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:04 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751587AbWFUOZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:25:44 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 03/21] [MMC] Support for multiple voltages
Date: Wed, 21 Jun 2006 16:25:44 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142544.8857.29650.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sdhci controllers can support up to three voltage levels. Detect which
and report back to the MMC layer.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/sdhci.h |   10 ++++++++-
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index efbece3..a6238b2 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -530,6 +530,46 @@ out:
 	host->clock = clock;
 }
 
+static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
+{
+	u8 pwr;
+
+	if (host->power == power)
+		return;
+
+	writeb(0, host->ioaddr + SDHCI_POWER_CONTROL);
+
+	if (power == (unsigned short)-1)
+		goto out;
+
+	pwr = SDHCI_POWER_ON;
+
+	switch (power) {
+	case MMC_VDD_170:
+	case MMC_VDD_180:
+	case MMC_VDD_190:
+		pwr |= SDHCI_POWER_180;
+		break;
+	case MMC_VDD_290:
+	case MMC_VDD_300:
+	case MMC_VDD_310:
+		pwr |= SDHCI_POWER_300;
+		break;
+	case MMC_VDD_320:
+	case MMC_VDD_330:
+	case MMC_VDD_340:
+		pwr |= SDHCI_POWER_330;
+		break;
+	default:
+		BUG();
+	}
+
+	writeb(pwr, host->ioaddr + SDHCI_POWER_CONTROL);
+
+out:
+	host->power = power;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
@@ -584,9 +624,9 @@ static void sdhci_set_ios(struct mmc_hos
 	sdhci_set_clock(host, ios->clock);
 
 	if (ios->power_mode == MMC_POWER_OFF)
-		writeb(0, host->ioaddr + SDHCI_POWER_CONTROL);
+		sdhci_set_power(host, -1);
 	else
-		writeb(0xFF, host->ioaddr + SDHCI_POWER_CONTROL);
+		sdhci_set_power(host, ios->vdd);
 
 	ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
@@ -1046,9 +1086,23 @@ static int __devinit sdhci_probe_slot(st
 	mmc->ops = &sdhci_ops;
 	mmc->f_min = host->max_clk / 256;
 	mmc->f_max = host->max_clk;
-	mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_4_BIT_DATA;
 
+	mmc->ocr_avail = 0;
+	if (caps & SDHCI_CAN_VDD_330)
+		mmc->ocr_avail |= MMC_VDD_32_33|MMC_VDD_33_34;
+	else if (caps & SDHCI_CAN_VDD_300)
+		mmc->ocr_avail |= MMC_VDD_29_30|MMC_VDD_30_31;
+	else if (caps & SDHCI_CAN_VDD_180)
+		mmc->ocr_avail |= MMC_VDD_17_18|MMC_VDD_18_19;
+
+	if (mmc->ocr_avail == 0) {
+		printk(KERN_ERR "%s: Hardware doesn't report any "
+			"support voltages.\n", host->slot_descr);
+		ret = -ENODEV;
+		goto unmap;
+	}
+
 	spin_lock_init(&host->lock);
 
 	/*
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index 3b270ef..aed4abd 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -67,6 +67,10 @@ #define  SDHCI_CTRL_LED		0x01
 #define  SDHCI_CTRL_4BITBUS	0x02
 
 #define SDHCI_POWER_CONTROL	0x29
+#define  SDHCI_POWER_ON		0x01
+#define  SDHCI_POWER_180	0x0A
+#define  SDHCI_POWER_300	0x0C
+#define  SDHCI_POWER_330	0x0E
 
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
@@ -121,9 +125,12 @@ #define SDHCI_ACMD12_ERR	0x3C
 /* 3E-3F reserved */
 
 #define SDHCI_CAPABILITIES	0x40
-#define  SDHCI_CAN_DO_DMA	0x00400000
 #define  SDHCI_CLOCK_BASE_MASK	0x00003F00
 #define  SDHCI_CLOCK_BASE_SHIFT	8
+#define  SDHCI_CAN_DO_DMA	0x00400000
+#define  SDHCI_CAN_VDD_330	0x01000000
+#define  SDHCI_CAN_VDD_300	0x02000000
+#define  SDHCI_CAN_VDD_180	0x04000000
 
 /* 44-47 reserved for more caps */
 
@@ -151,6 +158,7 @@ #define SDHCI_USE_DMA		(1<<0)
 	unsigned int		max_clk;	/* Max possible freq (MHz) */
 
 	unsigned int		clock;		/* Current clock (MHz) */
+	unsigned short		power;		/* Current voltage */
 
 	struct mmc_request	*mrq;		/* Current request */
 	struct mmc_command	*cmd;		/* Current command */

