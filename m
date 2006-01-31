Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWAaNjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWAaNjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWAaNjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:39:41 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:38075 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP
	id S1750819AbWAaNjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:39:40 -0500
Message-ID: <43DF683C.4080301@indt.org.br>
Date: Tue, 31 Jan 2006 09:38:04 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: [patch 4/5] MMC OMAP driver
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2006 13:36:21.0812 (UTC) FILETIME=[52BD1F40:01C6266B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some MMC cards don't set the R1_READY_FOR_DATA bit if EOFB
interrupt comes first. In this case we need to mask R1_READY_FOR_DATA
to avoid polling card status forever.
This patch needs to be discussed as it requires interface change.
This interface change is done here only for omap for now.

Signed-off-by: Tony Lindgren <tony@atomide.com>

Index: linux-2.6.15-mmc_omap/drivers/mmc/mmc_block.c
===================================================================
--- linux-2.6.15-mmc_omap.orig/drivers/mmc/mmc_block.c	2006-01-26 16:57:08.000000000 -0400
+++ linux-2.6.15-mmc_omap/drivers/mmc/mmc_block.c	2006-01-26 17:04:52.000000000 -0400
@@ -218,6 +218,10 @@ static int mmc_blk_issue_rq(struct mmc_q
 			goto cmd_err;
 		}

+		/* No need to check card status after a read */
+		if (rq_data_dir(req) == READ)
+			goto card_ready;
+
 		do {
 			int err;

@@ -239,6 +243,8 @@ static int mmc_blk_issue_rq(struct mmc_q
 		if (mmc_decode_status(cmd.resp))
 			goto cmd_err;
 #endif
+
+card_ready:
 		/*
 		 * A block was successfully transferred.
 		 */
@@ -336,6 +342,7 @@ static struct mmc_blk_data *mmc_blk_allo

 	card_ready:

+card_ready:
 		/*
 		 * As discussed on lkml, GENHD_FL_REMOVABLE should:
 		 *
Index: linux-2.6.15-mmc_omap/drivers/mmc/omap.c
===================================================================
--- linux-2.6.15-mmc_omap.orig/drivers/mmc/omap.c	2006-01-26 16:57:11.000000000 -0400
+++ linux-2.6.15-mmc_omap/drivers/mmc/omap.c	2006-01-26 16:57:11.000000000 -0400
@@ -319,7 +319,7 @@ mmc_omap_dma_done(struct mmc_omap_host *
 }

 static void
-mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
+mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd, int card_ready)
 {
 	host->cmd = NULL;

@@ -332,6 +332,9 @@ mmc_omap_cmd_done(struct mmc_omap_host *
 		cmd->resp[0] =
 			OMAP_MMC_READ(host->base, RSP6) |
 			(OMAP_MMC_READ(host->base, RSP7) << 16);
+		if (card_ready) {
+			cmd->resp[0] |= R1_READY_FOR_DATA;
+		}
 		break;
 	case MMC_RSP_LONG:
 		/* response type 2 */
@@ -428,6 +431,7 @@ static irqreturn_t mmc_omap_irq(int irq,
 	u16 status;
 	int end_command;
 	int end_transfer;
+	int card_ready;
 	int transfer_error;

 	if (host->cmd == NULL && host->data == NULL) {
@@ -442,6 +446,7 @@ static irqreturn_t mmc_omap_irq(int irq,

 	end_command = 0;
 	end_transfer = 0;
+	card_ready = 0;
 	transfer_error = 0;

 	while ((status = OMAP_MMC_READ(host->base, STAT)) != 0) {
@@ -542,10 +547,19 @@ static irqreturn_t mmc_omap_irq(int irq,
 		    (!(status & OMAP_MMC_STAT_A_EMPTY))) {
 			end_command = 1;
 		}
+		/* Some cards produce EOFB interrupt and never
+		 * raise R1_READY_FOR_DATA bit after that.
+		 * To avoid infinite card status polling loop,
+		 * we must fake that bit to MMC layer.
+		 */
+		if ((status & OMAP_MMC_STAT_END_OF_CMD) &&
+				(status & OMAP_MMC_STAT_END_BUSY)) {
+			card_ready = 1;
+		}
 	}

 	if (end_command) {
-		mmc_omap_cmd_done(host, host->cmd);
+		mmc_omap_cmd_done(host, host->cmd, card_ready);
 	}
 	if (transfer_error)
 		mmc_omap_xfer_done(host, host->data);
