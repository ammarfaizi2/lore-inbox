Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWFUO3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWFUO3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWFUO0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:36 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751611AbWFUO03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:29 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 16/21] [MMC] Support controller specific quirks
Date: Wed, 21 Jun 2006 16:26:30 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142630.8857.75597.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As some specific controllers will have bugs, we need a way to map special
behaviour to certain hardware.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |    7 +++++++
 drivers/mmc/sdhci.h |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 04d79a2..1e08acc 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -30,6 +30,7 @@ #define DBG(f, x...) \
 
 static unsigned int debug_nodma = 0;
 static unsigned int debug_forcedma = 0;
+static unsigned int debug_quirks = 0;
 
 static const struct pci_device_id pci_ids[] __devinitdata = {
 	/* handle any SD host controller */
@@ -1373,6 +1374,10 @@ static int __devinit sdhci_probe(struct 
 	}
 
 	chip->pdev = pdev;
+	chip->quirks = ent->driver_data;
+
+	if (debug_quirks)
+		chip->quirks = debug_quirks;
 
 	chip->num_slots = slots;
 	pci_set_drvdata(pdev, chip);
@@ -1453,6 +1458,7 @@ module_exit(sdhci_drv_exit);
 
 module_param(debug_nodma, uint, 0444);
 module_param(debug_forcedma, uint, 0444);
+module_param(debug_quirks, uint, 0444);
 
 MODULE_AUTHOR("Pierre Ossman <drzeus@drzeus.cx>");
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface driver");
@@ -1461,3 +1467,4 @@ MODULE_LICENSE("GPL");
 
 MODULE_PARM_DESC(debug_nodma, "Forcefully disable DMA transfers. (default 0)");
 MODULE_PARM_DESC(debug_forcedma, "Forcefully enable DMA transfers. (default 0)");
+MODULE_PARM_DESC(debug_quirks, "Force certain quirks.");
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index 8111fa3..f245334 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -204,6 +204,8 @@ #define SDHCI_USE_DMA		(1<<0)
 struct sdhci_chip {
 	struct pci_dev		*pdev;
 
+	unsigned long		quirks;
+
 	int			num_slots;	/* Slots on controller */
 	struct sdhci_host	*hosts[0];	/* Pointers to hosts */
 };

