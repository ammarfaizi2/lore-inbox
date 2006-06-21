Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWFUOZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWFUOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWFUOZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:25:57 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751594AbWFUOZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:25:53 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 06/21] [MMC] Proper timeout handling
Date: Wed, 21 Jun 2006 16:25:54 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142553.8857.36157.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the give timeout clock and calculate a proper timeout instead of using
the maximum at all times.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   47 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/sdhci.h |    4 ++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index d904435..feadc2d 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -128,9 +128,6 @@ static void sdhci_init(struct sdhci_host
 
 	writel(intmask, host->ioaddr + SDHCI_INT_ENABLE);
 	writel(intmask, host->ioaddr + SDHCI_SIGNAL_ENABLE);
-
-	/* This is unknown magic. */
-	writeb(0xE, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
 }
 
 static void sdhci_activate_led(struct sdhci_host *host)
@@ -274,6 +271,8 @@ static void sdhci_transfer_pio(struct sd
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 {
 	u16 mode;
+	u8 count;
+	unsigned target_timeout, current_timeout;
 
 	WARN_ON(host->data);
 
@@ -287,6 +286,37 @@ static void sdhci_prepare_data(struct sd
 	DBG("tsac %d ms nsac %d clk\n",
 		data->timeout_ns / 1000000, data->timeout_clks);
 
+	/* timeout in us */
+	target_timeout = data->timeout_ns / 1000 +
+		data->timeout_clks / host->clock;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < target_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		printk(KERN_WARNING "%s: Too large timeout requested!\n",
+			mmc_hostname(host->mmc));
+		count = 0xE;
+	}
+
+	writeb(count, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
+
 	mode = SDHCI_TRNS_BLK_CNT_EN;
 	if (data->blocks > 1)
 		mode |= SDHCI_TRNS_MULTI;
@@ -1096,6 +1126,17 @@ static int __devinit sdhci_probe_slot(st
 	}
 	host->max_clk *= 1000000;
 
+	host->timeout_clk =
+		(caps & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
+	if (host->timeout_clk == 0) {
+		printk(KERN_ERR "%s: Hardware doesn't specify timeout clock "
+			"frequency.\n", host->slot_descr);
+		ret = -ENODEV;
+		goto unmap;
+	}
+	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
+		host->timeout_clk *= 1000;
+
 	/*
 	 * Set host parameters.
 	 */
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index aed4abd..a8f4521 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -125,6 +125,9 @@ #define SDHCI_ACMD12_ERR	0x3C
 /* 3E-3F reserved */
 
 #define SDHCI_CAPABILITIES	0x40
+#define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
+#define  SDHCI_TIMEOUT_CLK_SHIFT 0
+#define  SDHCI_TIMEOUT_CLK_UNIT	0x00000080
 #define  SDHCI_CLOCK_BASE_MASK	0x00003F00
 #define  SDHCI_CLOCK_BASE_SHIFT	8
 #define  SDHCI_CAN_DO_DMA	0x00400000
@@ -156,6 +159,7 @@ struct sdhci_host {
 #define SDHCI_USE_DMA		(1<<0)
 
 	unsigned int		max_clk;	/* Max possible freq (MHz) */
+	unsigned int		timeout_clk;	/* Timeout freq (KHz) */
 
 	unsigned int		clock;		/* Current clock (MHz) */
 	unsigned short		power;		/* Current voltage */

