Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWJAMmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWJAMmb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWJAMmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:42:31 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:9871 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932129AbWJAMma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:42:30 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Avoid some resets without card
Date: Sun, 01 Oct 2006 14:42:32 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20061001124232.16988.16701.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some Ricoh controllers only respect a full reset when there is no
card in the slot. As we wait for the reset to complete, we must
avoid even requesting those resets on the buggy controllers.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 9ff9231..20711ac 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -35,6 +35,8 @@ static unsigned int debug_quirks = 0;
 
 #define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
 #define SDHCI_QUIRK_FORCE_DMA				(1<<1)
+/* Controller doesn't like some resets when there is no card inserted. */
+#define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
 
 static const struct pci_device_id pci_ids[] __devinitdata = {
 	{
@@ -51,7 +53,8 @@ static const struct pci_device_id pci_id
 		.device		= PCI_DEVICE_ID_RICOH_R5C822,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.driver_data	= SDHCI_QUIRK_FORCE_DMA,
+		.driver_data	= SDHCI_QUIRK_FORCE_DMA |
+				  SDHCI_QUIRK_NO_CARD_NO_RESET,
 	},
 
 	{
@@ -125,6 +128,12 @@ static void sdhci_reset(struct sdhci_hos
 {
 	unsigned long timeout;
 
+	if (host->chip->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
+		if (!(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
+			SDHCI_CARD_PRESENT))
+			return;
+	}
+
 	writeb(mask, host->ioaddr + SDHCI_SOFTWARE_RESET);
 
 	if (mask & SDHCI_RESET_ALL)
@@ -1174,6 +1183,9 @@ static int __devinit sdhci_probe_slot(st
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
+	host->chip = chip;
+	chip->hosts[slot] = host;
+
 	host->bar = first_bar + slot;
 
 	host->addr = pci_resource_start(pdev, host->bar);
@@ -1330,9 +1342,6 @@ #ifdef CONFIG_MMC_DEBUG
 	sdhci_dumpregs(host);
 #endif
 
-	host->chip = chip;
-	chip->hosts[slot] = host;
-
 	mmiowb();
 
 	mmc_add_host(mmc);

