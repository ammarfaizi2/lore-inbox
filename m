Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWFRMek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWFRMek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWFRMek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:34:40 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:11993 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S932193AbWFRMek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:34:40 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Fix SD timeout calculation
Date: Sun, 18 Jun 2006 14:34:37 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060618123432.15915.71389.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Secure Digital cards use a different algorithm to calculate the timeout
for data transfers. Using the MMC one works often, but not always.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc.c       |   15 +++++++++++++--
 drivers/mmc/mmc_block.c |   44 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 6201f30..bd15f99 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -913,6 +913,7 @@ static void mmc_read_scrs(struct mmc_hos
 	struct mmc_request mrq;
 	struct mmc_command cmd;
 	struct mmc_data data;
+	unsigned int timeout_us;
 
 	struct scatterlist sg;
 
@@ -948,8 +949,18 @@ static void mmc_read_scrs(struct mmc_hos
 
 		memset(&data, 0, sizeof(struct mmc_data));
 
-		data.timeout_ns = card->csd.tacc_ns * 10;
-		data.timeout_clks = card->csd.tacc_clks * 10;
+		data.timeout_ns = card->csd.tacc_ns * 100;
+		data.timeout_clks = card->csd.tacc_clks * 100;
+
+		timeout_us = data.timeout_ns / 1000;
+		timeout_us += data.timeout_clks * 1000 /
+			(host->ios.clock / 1000);
+
+		if (timeout_us > 100000) {
+			data.timeout_ns = 100000000;
+			data.timeout_clks = 0;
+		}
+
 		data.blksz_bits = 3;
 		data.blksz = 1 << 3;
 		data.blocks = 1;
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index 96049e2..69fa6bc 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -31,6 +31,7 @@ #include <linux/devfs_fs_kernel.h>
 #include <linux/mutex.h>
 
 #include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
 #include <linux/mmc/protocol.h>
 
 #include <asm/system.h>
@@ -172,8 +173,6 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 		brq.cmd.arg = req->sector << 9;
 		brq.cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
-		brq.data.timeout_ns = card->csd.tacc_ns * 10;
-		brq.data.timeout_clks = card->csd.tacc_clks * 10;
 		brq.data.blksz_bits = md->block_bits;
 		brq.data.blksz = 1 << md->block_bits;
 		brq.data.blocks = req->nr_sectors >> (md->block_bits - 9);
@@ -181,6 +180,41 @@ static int mmc_blk_issue_rq(struct mmc_q
 		brq.stop.arg = 0;
 		brq.stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
 
+		brq.data.timeout_ns = card->csd.tacc_ns * 10;
+		brq.data.timeout_clks = card->csd.tacc_clks * 10;
+
+		/*
+		 * Scale up the timeout by the r2w factor
+		 */
+		if (rq_data_dir(req) == WRITE) {
+			brq.data.timeout_ns <<= card->csd.r2w_factor;
+			brq.data.timeout_clks <<= card->csd.r2w_factor;
+		}
+
+		/*
+		 * SD cards use a 100 multiplier and has a upper limit
+		 */
+		if (mmc_card_sd(card)) {
+			unsigned int limit_us, timeout_us;
+
+			brq.data.timeout_ns *= 10;
+			brq.data.timeout_clks *= 10;
+
+			if (rq_data_dir(req) == READ)
+				limit_us = 100000;
+			else
+				limit_us = 250000;
+
+			timeout_us = brq.data.timeout_ns / 1000;
+			timeout_us += brq.data.timeout_clks * 1000 /
+				(card->host->ios.clock / 1000);
+
+			if (timeout_us > limit_us) {
+				brq.data.timeout_ns = limit_us * 1000;
+				brq.data.timeout_clks = 0;
+			}
+		}
+
 		if (rq_data_dir(req) == READ) {
 			brq.cmd.opcode = brq.data.blocks > 1 ? MMC_READ_MULTIPLE_BLOCK : MMC_READ_SINGLE_BLOCK;
 			brq.data.flags |= MMC_DATA_READ;
@@ -188,12 +222,6 @@ static int mmc_blk_issue_rq(struct mmc_q
 			brq.cmd.opcode = MMC_WRITE_BLOCK;
 			brq.data.flags |= MMC_DATA_WRITE;
 			brq.data.blocks = 1;
-
-			/*
-			 * Scale up the timeout by the r2w factor
-			 */
-			brq.data.timeout_ns <<= card->csd.r2w_factor;
-			brq.data.timeout_clks <<= card->csd.r2w_factor;
 		}
 
 		if (brq.data.blocks > 1) {

