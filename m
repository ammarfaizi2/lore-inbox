Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWFUO3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWFUO3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWFUO0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:35 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751600AbWFUO0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:15 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 12/21] [MMC] Check only relevant inhibit bits
Date: Wed, 21 Jun 2006 16:26:15 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142615.8857.43426.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conform to the sdhci specification as to which inhibit bits should be
checked at different times.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 919d60f..41addde 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -465,6 +465,7 @@ static void sdhci_finish_data(struct sdh
 static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
+	u32 mask;
 	unsigned long timeout;
 
 	WARN_ON(host->cmd);
@@ -473,11 +474,20 @@ static void sdhci_send_command(struct sd
 
 	/* Wait max 10 ms */
 	timeout = 10;
-	while (readl(host->ioaddr + SDHCI_PRESENT_STATE) &
-		(SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) {
+
+	mask = SDHCI_CMD_INHIBIT;
+	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
+		mask |= SDHCI_DATA_INHIBIT;
+
+	/* We shouldn't wait for data inihibit for stop commands, even
+	   though they might use busy signaling */
+	if (host->mrq->data && (cmd == host->mrq->data->stop))
+		mask &= ~SDHCI_DATA_INHIBIT;
+
+	while (readl(host->ioaddr + SDHCI_PRESENT_STATE) & mask) {
 		if (timeout == 0) {
 			printk(KERN_ERR "%s: Controller never released "
-				"inhibit bits. Please report this to "
+				"inhibit bit(s). Please report this to "
 				BUGMAIL ".\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			cmd->error = MMC_ERR_FAILED;

