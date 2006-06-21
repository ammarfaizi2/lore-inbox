Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWFUOcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWFUOcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWFUOcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:32:12 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751588AbWFUO0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:01 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 08/21] [MMC] Fix interrupt handling
Date: Wed, 21 Jun 2006 16:26:01 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142601.8857.23044.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The specification says that interrupts should be cleared before the source
is removed. We should also not set unknown bits.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   80 +++++++++++++++------------------------------------
 1 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 52e4c6e..b7a9ac2 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -124,7 +124,12 @@ static void sdhci_init(struct sdhci_host
 
 	sdhci_reset(host, SDHCI_RESET_ALL);
 
-	intmask = ~(SDHCI_INT_CARD_INT | SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL);
+	intmask = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
+		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
+		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
+		SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT |
+		SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL |
+		SDHCI_INT_DMA_END | SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE;
 
 	writel(intmask, host->ioaddr + SDHCI_INT_ENABLE);
 	writel(intmask, host->ioaddr + SDHCI_SIGNAL_ENABLE);
@@ -360,7 +365,6 @@ static void sdhci_set_transfer_mode(stru
 static void sdhci_finish_data(struct sdhci_host *host)
 {
 	struct mmc_data *data;
-	u32 intmask;
 	u16 blocks;
 
 	BUG_ON(!host->data);
@@ -371,14 +375,6 @@ static void sdhci_finish_data(struct sdh
 	if (host->flags & SDHCI_USE_DMA) {
 		pci_unmap_sg(host->chip->pdev, data->sg, data->sg_len,
 			(data->flags & MMC_DATA_READ)?PCI_DMA_FROMDEVICE:PCI_DMA_TODEVICE);
-	} else {
-		intmask = readl(host->ioaddr + SDHCI_SIGNAL_ENABLE);
-		intmask &= ~(SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL);
-		writel(intmask, host->ioaddr + SDHCI_SIGNAL_ENABLE);
-
-		intmask = readl(host->ioaddr + SDHCI_INT_ENABLE);
-		intmask &= ~(SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL);
-		writel(intmask, host->ioaddr + SDHCI_INT_ENABLE);
 	}
 
 	/*
@@ -512,31 +508,9 @@ static void sdhci_finish_command(struct 
 
 	DBG("Ending cmd (%x)\n", host->cmd->opcode);
 
-	if (host->cmd->data) {
-		u32 intmask;
-
+	if (host->cmd->data)
 		host->data = host->cmd->data;
-
-		if (!(host->flags & SDHCI_USE_DMA)) {
-			/*
-			 * Don't enable the interrupts until now to make sure we
-			 * get stable handling of the FIFO.
-			 */
-			intmask = readl(host->ioaddr + SDHCI_INT_ENABLE);
-			intmask |= SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL;
-			writel(intmask, host->ioaddr + SDHCI_INT_ENABLE);
-
-			intmask = readl(host->ioaddr + SDHCI_SIGNAL_ENABLE);
-			intmask |= SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL;
-			writel(intmask, host->ioaddr + SDHCI_SIGNAL_ENABLE);
-
-			/*
-			 * The buffer interrupts are to unreliable so we
-			 * start the transfer immediatly.
-			 */
-			sdhci_transfer_pio(host);
-		}
-	} else
+	else
 		tasklet_schedule(&host->finish_tasklet);
 
 	host->cmd = NULL;
@@ -914,50 +888,44 @@ static irqreturn_t sdhci_irq(int irq, vo
 
 	DBG("*** %s got interrupt: 0x%08x\n", host->slot_descr, intmask);
 
-	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE))
+	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		writel(intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE),
+			host->ioaddr + SDHCI_INT_STATUS);
 		tasklet_schedule(&host->card_tasklet);
+	}
 
-	if (intmask & SDHCI_INT_CMD_MASK) {
-		sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
+	intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
 
+	if (intmask & SDHCI_INT_CMD_MASK) {
 		writel(intmask & SDHCI_INT_CMD_MASK,
 			host->ioaddr + SDHCI_INT_STATUS);
+		sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
 	}
 
 	if (intmask & SDHCI_INT_DATA_MASK) {
-		sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
-
 		writel(intmask & SDHCI_INT_DATA_MASK,
 			host->ioaddr + SDHCI_INT_STATUS);
+		sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
 	}
 
 	intmask &= ~(SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK);
 
-	if (intmask & SDHCI_INT_CARD_INT) {
-		printk(KERN_ERR "%s: Unexpected card interrupt. Please "
-			"report this to " BUGMAIL ".\n",
-			mmc_hostname(host->mmc));
-		sdhci_dumpregs(host);
-	}
-
 	if (intmask & SDHCI_INT_BUS_POWER) {
-		printk(KERN_ERR "%s: Unexpected bus power interrupt. Please "
-			"report this to " BUGMAIL ".\n",
+		printk(KERN_ERR "%s: Card is consuming too much power!\n",
 			mmc_hostname(host->mmc));
-		sdhci_dumpregs(host);
+		writel(SDHCI_INT_BUS_POWER, host->ioaddr + SDHCI_INT_STATUS);
 	}
 
-	if (intmask & SDHCI_INT_ACMD12ERR) {
-		printk(KERN_ERR "%s: Unexpected auto CMD12 error. Please "
+	intmask &= SDHCI_INT_BUS_POWER;
+
+	if (intmask) {
+		printk(KERN_ERR "%s: Unexpected interrupt 0x%08x. Please "
 			"report this to " BUGMAIL ".\n",
-			mmc_hostname(host->mmc));
+			mmc_hostname(host->mmc), intmask);
 		sdhci_dumpregs(host);
 
-		writew(~0, host->ioaddr + SDHCI_ACMD12_ERR);
-	}
-
-	if (intmask)
 		writel(intmask, host->ioaddr + SDHCI_INT_STATUS);
+	}
 
 	result = IRQ_HANDLED;
 

