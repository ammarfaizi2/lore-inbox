Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWFUO0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWFUO0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWFUOZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:25:59 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751591AbWFUOZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:25:50 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 05/21] [MMC] Fix sdhci reset timeout
Date: Wed, 21 Jun 2006 16:25:51 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142550.8857.42360.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reset register is automatically cleared when the reset has completed.
Hence, we should busy wait and not have a fixed delay.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index b68ca02..d904435 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -94,12 +94,27 @@ static void sdhci_dumpregs(struct sdhci_
 
 static void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
+	unsigned long timeout;
+
 	writeb(mask, host->ioaddr + SDHCI_SOFTWARE_RESET);
 
-	if (mask & SDHCI_RESET_ALL) {
+	if (mask & SDHCI_RESET_ALL)
 		host->clock = 0;
 
-		mdelay(50);
+	/* Wait max 100 ms */
+	timeout = 100;
+
+	/* hw clears the bit when it's done */
+	while (readb(host->ioaddr + SDHCI_SOFTWARE_RESET) & mask) {
+		if (timeout == 0) {
+			printk(KERN_ERR "%s: Reset 0x%x never completed. "
+				"Please report this to " BUGMAIL ".\n",
+				mmc_hostname(host->mmc), (int)mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+		timeout--;
+		mdelay(1);
 	}
 }
 
@@ -619,9 +634,7 @@ static void sdhci_set_ios(struct mmc_hos
 	 */
 	if (ios->power_mode == MMC_POWER_OFF) {
 		writel(0, host->ioaddr + SDHCI_SIGNAL_ENABLE);
-		spin_unlock_irqrestore(&host->lock, flags);
 		sdhci_init(host);
-		spin_lock_irqsave(&host->lock, flags);
 	}
 
 	sdhci_set_clock(host, ios->clock);

