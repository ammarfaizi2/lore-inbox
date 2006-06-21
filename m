Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWFUO0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWFUO0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWFUOZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:25:59 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751588AbWFUOZr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:25:47 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 04/21] [MMC] Fix timeout loops in sdhci
Date: Wed, 21 Jun 2006 16:25:48 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142547.8857.44115.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current timeout loop assume that jiffies are updated. This might not be
the case depending on locks and if the kernel is compiled without
preemption. Change the system to use a counter and fixed delays.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index a6238b2..b68ca02 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -371,17 +371,17 @@ static void sdhci_finish_data(struct sdh
 static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
-	u32 present;
-	unsigned long max_jiffies;
+	unsigned long timeout;
 
 	WARN_ON(host->cmd);
 
 	DBG("Sending cmd (%x)\n", cmd->opcode);
 
 	/* Wait max 10 ms */
-	max_jiffies = jiffies + (HZ + 99)/100;
-	do {
-		if (time_after(jiffies, max_jiffies)) {
+	timeout = 10;
+	while (readl(host->ioaddr + SDHCI_PRESENT_STATE) &
+		(SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) {
+		if (timeout == 0) {
 			printk(KERN_ERR "%s: Controller never released "
 				"inhibit bits. Please report this to "
 				BUGMAIL ".\n", mmc_hostname(host->mmc));
@@ -390,8 +390,9 @@ static void sdhci_send_command(struct sd
 			tasklet_schedule(&host->finish_tasklet);
 			return;
 		}
-		present = readl(host->ioaddr + SDHCI_PRESENT_STATE);
-	} while (present & (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT));
+		timeout--;
+		mdelay(1);
+	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
 
@@ -490,7 +491,7 @@ static void sdhci_set_clock(struct sdhci
 {
 	int div;
 	u16 clk;
-	unsigned long max_jiffies;
+	unsigned long timeout;
 
 	if (clock == host->clock)
 		return;
@@ -511,17 +512,19 @@ static void sdhci_set_clock(struct sdhci
 	writew(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 10 ms */
-	max_jiffies = jiffies + (HZ + 99)/100;
-	do {
-		if (time_after(jiffies, max_jiffies)) {
+	timeout = 10;
+	while (!((clk = readw(host->ioaddr + SDHCI_CLOCK_CONTROL))
+		& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
 			printk(KERN_ERR "%s: Internal clock never stabilised. "
 				"Please report this to " BUGMAIL ".\n",
 				mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			return;
 		}
-		clk = readw(host->ioaddr + SDHCI_CLOCK_CONTROL);
-	} while (!(clk & SDHCI_CLOCK_INT_STABLE));
+		timeout--;
+		mdelay(1);
+	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
 	writew(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);

