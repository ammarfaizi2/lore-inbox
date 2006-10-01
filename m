Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWJAMm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWJAMm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWJAMm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:42:26 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:9871 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932112AbWJAMmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:42:25 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Fix MMIO vs memory races in sdhci
Date: Sun, 01 Oct 2006 14:42:25 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20061001124225.16980.64962.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sprinkle some mmiowb() where needed (writeX() before unlock()).

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 4dab5ec..9ff9231 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -717,6 +717,7 @@ static void sdhci_request(struct mmc_hos
 	} else
 		sdhci_send_command(host, mrq->cmd);
 
+	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -753,6 +754,7 @@ static void sdhci_set_ios(struct mmc_hos
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
 
+	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -860,6 +862,7 @@ static void sdhci_tasklet_finish(unsigne
 
 	sdhci_deactivate_led(host);
 
+	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	mmc_request_done(host->mmc, mrq);
@@ -893,6 +896,7 @@ static void sdhci_timeout_timer(unsigned
 		}
 	}
 
+	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -1030,6 +1034,7 @@ static irqreturn_t sdhci_irq(int irq, vo
 
 	result = IRQ_HANDLED;
 
+	mmiowb();
 out:
 	spin_unlock(&host->lock);
 
@@ -1095,6 +1100,7 @@ static int sdhci_resume (struct pci_dev 
 		if (chip->hosts[i]->flags & SDHCI_USE_DMA)
 			pci_set_master(pdev);
 		sdhci_init(chip->hosts[i]);
+		mmiowb();
 		ret = mmc_resume_host(chip->hosts[i]->mmc);
 		if (ret)
 			return ret;
@@ -1327,6 +1333,8 @@ #endif
 	host->chip = chip;
 	chip->hosts[slot] = host;
 
+	mmiowb();
+
 	mmc_add_host(mmc);
 
 	printk(KERN_INFO "%s: SDHCI at 0x%08lx irq %d %s\n", mmc_hostname(mmc),

