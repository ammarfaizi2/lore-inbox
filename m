Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWFUO1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWFUO1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWFUO1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:27:03 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751612AbWFUO0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:40 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 19/21] [MMC] Quirk for broken reset
Date: Wed, 21 Jun 2006 16:26:41 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142641.8857.47604.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers fail to complete a reset unless you touch the clock
register first.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 1a12427..617a588 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -32,9 +32,21 @@ static unsigned int debug_nodma = 0;
 static unsigned int debug_forcedma = 0;
 static unsigned int debug_quirks = 0;
 
+#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
+
 static const struct pci_device_id pci_ids[] __devinitdata = {
-	/* handle any SD host controller */
-	{PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)},
+	{
+		.vendor		= PCI_VENDOR_ID_RICOH,
+		.device		= PCI_DEVICE_ID_RICOH_R5C822,
+		.subvendor	= PCI_VENDOR_ID_IBM,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SDHCI_QUIRK_CLOCK_BEFORE_RESET,
+	},
+
+	{	/* Generic SD host controller */
+		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
+	},
+
 	{ /* end: all zeroes */ },
 };
 
@@ -808,6 +820,19 @@ static void sdhci_tasklet_finish(unsigne
 	if ((mrq->cmd->error != MMC_ERR_NONE) ||
 		(mrq->data && ((mrq->data->error != MMC_ERR_NONE) ||
 		(mrq->data->stop && (mrq->data->stop->error != MMC_ERR_NONE))))) {
+
+		/* Some controllers need this kick or reset won't work here */
+		if (host->chip->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET) {
+			unsigned int clock;
+
+			/* This is to force an update */
+			clock = host->clock;
+			host->clock = 0;
+			sdhci_set_clock(host, clock);
+		}
+
+		/* Spec says we should do both at the same time, but Ricoh
+		   controllers do not like that. */
 		sdhci_reset(host, SDHCI_RESET_CMD);
 		sdhci_reset(host, SDHCI_RESET_DATA);
 	}

