Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWFUOZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWFUOZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWFUOZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:25:38 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751585AbWFUOZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:25:38 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 01/21] [MMC] Check SDHCI base clock
Date: Wed, 21 Jun 2006 16:25:38 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142538.8857.77959.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A base clock value of 0 means that the driver must get the base clock
through some other means. As we have no other way of getting it, we must
abort.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 6bfcdbc..681cbb8 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -1030,7 +1030,14 @@ static int __devinit sdhci_probe_slot(st
 	else /* XXX: Hack to get MMC layer to avoid highmem */
 		pdev->dma_mask = 0;
 
-	host->max_clk = (caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
+	host->max_clk =
+		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
+	if (host->max_clk == 0) {
+		printk(KERN_ERR "%s: Hardware doesn't specify base clock "
+			"frequency.\n", host->slot_descr);
+		ret = -ENODEV;
+		goto unmap;
+	}
 	host->max_clk *= 1000000;
 
 	/*
@@ -1078,7 +1085,7 @@ static int __devinit sdhci_probe_slot(st
 	ret = request_irq(host->irq, sdhci_irq, SA_SHIRQ,
 		host->slot_descr, host);
 	if (ret)
-		goto unmap;
+		goto untasklet;
 
 	sdhci_init(host);
 
@@ -1097,10 +1104,10 @@ #endif
 
 	return 0;
 
-unmap:
+untasklet:
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
-
+unmap:
 	iounmap(host->ioaddr);
 release:
 	pci_release_region(pdev, host->bar);

