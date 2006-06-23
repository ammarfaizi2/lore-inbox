Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751713AbWFWQCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWFWQCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbWFWQCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:02:51 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:62608 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751702AbWFWQCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:02:50 -0400
Message-ID: <449C10AF.60105@drzeus.cx>
Date: Fri, 23 Jun 2006 18:02:55 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hera.drzeus.cx-31644-1151078569-0001-2"
To: rmk+lkml@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/21] [MMC] Correct register order
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx> <20060621142557.8857.26186.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142557.8857.26186.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-31644-1151078569-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

New version to fix conflicts by recent merge.


--=_hera.drzeus.cx-31644-1151078569-0001-2
Content-Type: text/x-patch; name="sdhci-reg-order.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdhci-reg-order.patch"

[MMC] Correct register order

The sdhci specification states that some registers must be written to in a
specific order.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   44 +++++++++++++++++++++++++++-----------------
 1 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 877226e..4457881 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -270,16 +270,13 @@ static void sdhci_transfer_pio(struct sd
 
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 {
-	u16 mode;
 	u8 count;
 	unsigned target_timeout, current_timeout;
 
 	WARN_ON(host->data);
 
-	if (data == NULL) {
-		writew(0, host->ioaddr + SDHCI_TRANSFER_MODE);
+	if (data == NULL)
 		return;
-	}
 
 	DBG("blksz %04x blks %04x flags %08x\n",
 		data->blksz, data->blocks, data->flags);
@@ -317,19 +314,6 @@ static void sdhci_prepare_data(struct sd
 
 	writeb(count, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
 
-	mode = SDHCI_TRNS_BLK_CNT_EN;
-	if (data->blocks > 1)
-		mode |= SDHCI_TRNS_MULTI;
-	if (data->flags & MMC_DATA_READ)
-		mode |= SDHCI_TRNS_READ;
-	if (host->flags & SDHCI_USE_DMA)
-		mode |= SDHCI_TRNS_DMA;
-
-	writew(mode, host->ioaddr + SDHCI_TRANSFER_MODE);
-
-	writew(data->blksz, host->ioaddr + SDHCI_BLOCK_SIZE);
-	writew(data->blocks, host->ioaddr + SDHCI_BLOCK_COUNT);
-
 	if (host->flags & SDHCI_USE_DMA) {
 		int count;
 
@@ -347,6 +331,30 @@ static void sdhci_prepare_data(struct sd
 		host->offset = 0;
 		host->remain = host->cur_sg->length;
 	}
+
+	writew(data->blksz, host->ioaddr + SDHCI_BLOCK_SIZE);
+	writew(data->blocks, host->ioaddr + SDHCI_BLOCK_COUNT);
+}
+
+static void sdhci_set_transfer_mode(struct sdhci_host *host,
+	struct mmc_data *data)
+{
+	u16 mode;
+
+	WARN_ON(host->data);
+
+	if (data == NULL)
+		return;
+
+	mode = SDHCI_TRNS_BLK_CNT_EN;
+	if (data->blocks > 1)
+		mode |= SDHCI_TRNS_MULTI;
+	if (data->flags & MMC_DATA_READ)
+		mode |= SDHCI_TRNS_READ;
+	if (host->flags & SDHCI_USE_DMA)
+		mode |= SDHCI_TRNS_DMA;
+
+	writew(mode, host->ioaddr + SDHCI_TRANSFER_MODE);
 }
 
 static void sdhci_finish_data(struct sdhci_host *host)
@@ -447,6 +455,8 @@ static void sdhci_send_command(struct sd
 
 	writel(cmd->arg, host->ioaddr + SDHCI_ARGUMENT);
 
+	sdhci_set_transfer_mode(host, cmd->data);
+
 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
 		printk(KERN_ERR "%s: Unsupported response type! "
 			"Please report this to " BUGMAIL ".\n",

--=_hera.drzeus.cx-31644-1151078569-0001-2--
