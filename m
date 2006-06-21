Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWFUO20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWFUO20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWFUO0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:37 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751602AbWFUO0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:11 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 11/21] [MMC] Test for invalid block size
Date: Wed, 21 Jun 2006 16:26:11 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142611.8857.8910.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The controller has an upper limit on the block size. Make sure we do not
cross it.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   11 +++++++++++
 drivers/mmc/sdhci.h |    3 +++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 57200e4..919d60f 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -328,6 +328,8 @@ static void sdhci_prepare_data(struct sd
 
 	/* Sanity checks */
 	BUG_ON((1 << data->blksz_bits) * data->blocks > 524288);
+	BUG_ON((1 << data->blksz_bits) > host->max_block);
+	BUG_ON(data->blocks > 65535);
 
 	/* timeout in us */
 	target_timeout = data->timeout_ns / 1000 +
@@ -1158,6 +1160,15 @@ static int __devinit sdhci_probe_slot(st
 	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
 
+	host->max_block = (caps & SDHCI_MAX_BLOCK_MASK) >> SDHCI_MAX_BLOCK_SHIFT;
+	if (host->max_block >= 3) {
+		printk(KERN_ERR "%s: Invalid maximum block size.\n",
+			host->slot_descr);
+		ret = -ENODEV;
+		goto unmap;
+	}
+	host->max_block = 512 << host->max_block;
+
 	/*
 	 * Set host parameters.
 	 */
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index 8ed2a89..b1aa3ac 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -131,6 +131,8 @@ #define  SDHCI_TIMEOUT_CLK_SHIFT 0
 #define  SDHCI_TIMEOUT_CLK_UNIT	0x00000080
 #define  SDHCI_CLOCK_BASE_MASK	0x00003F00
 #define  SDHCI_CLOCK_BASE_SHIFT	8
+#define  SDHCI_MAX_BLOCK_MASK	0x00030000
+#define  SDHCI_MAX_BLOCK_SHIFT  16
 #define  SDHCI_CAN_DO_DMA	0x00400000
 #define  SDHCI_CAN_VDD_330	0x01000000
 #define  SDHCI_CAN_VDD_300	0x02000000
@@ -161,6 +163,7 @@ #define SDHCI_USE_DMA		(1<<0)
 
 	unsigned int		max_clk;	/* Max possible freq (MHz) */
 	unsigned int		timeout_clk;	/* Timeout freq (KHz) */
+	unsigned int		max_block;	/* Max block size (bytes) */
 
 	unsigned int		clock;		/* Current clock (MHz) */
 	unsigned short		power;		/* Current voltage */

