Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWJAMnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWJAMnY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWJAMnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:43:01 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:9871 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932137AbWJAMmz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:42:55 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Multi sector write transfers
Date: Sun, 01 Oct 2006 14:42:57 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20061001124257.17012.78166.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SD cards extend the protocol by allowing the host to query a card how many
blocks were successfully stored on the medium. This allows us to safely write
chunks of blocks at once.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc_block.c      |  104 ++++++++++++++++++++++++++++++++++++++----
 include/linux/mmc/protocol.h |    1 
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index c1293f1..f9027c8 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -28,6 +28,7 @@ #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
 #include <linux/blkdev.h>
 #include <linux/mutex.h>
+#include <linux/scatterlist.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -154,6 +155,71 @@ static int mmc_blk_prep_rq(struct mmc_qu
 	return stat;
 }
 
+static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
+{
+	int err;
+	u32 blocks;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+	unsigned int timeout_us;
+
+	struct scatterlist sg;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_APP_CMD;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if ((err != MMC_ERR_NONE) || !(cmd.resp[0] & R1_APP_CMD))
+		return (u32)-1;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = SD_APP_SEND_NUM_WR_BLKS;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	data.timeout_ns = card->csd.tacc_ns * 100;
+	data.timeout_clks = card->csd.tacc_clks * 100;
+
+	timeout_us = data.timeout_ns / 1000;
+	timeout_us += data.timeout_clks * 1000 /
+		(card->host->ios.clock / 1000);
+
+	if (timeout_us > 100000) {
+		data.timeout_ns = 100000000;
+		data.timeout_clks = 0;
+	}
+
+	data.blksz = 4;
+	data.blocks = 1;
+	data.flags = MMC_DATA_READ;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	sg_init_one(&sg, &blocks, 4);
+
+	mmc_wait_for_req(card->host, &mrq);
+
+	if (cmd.error != MMC_ERR_NONE || data.error != MMC_ERR_NONE)
+		return (u32)-1;
+
+	blocks = ntohl(blocks);
+
+	return blocks;
+}
+
 static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -184,10 +250,13 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 		/*
 		 * If the host doesn't support multiple block writes, force
-		 * block writes to single block.
+		 * block writes to single block. SD cards are excepted from
+		 * this rule as they support querying the number of
+		 * successfully written sectors.
 		 */
 		if (rq_data_dir(req) != READ &&
-		    !(card->host->caps & MMC_CAP_MULTIWRITE))
+		    !(card->host->caps & MMC_CAP_MULTIWRITE) &&
+		    !mmc_card_sd(card))
 			brq.data.blocks = 1;
 
 		if (brq.data.blocks > 1) {
@@ -276,24 +345,41 @@ #endif
 	return 1;
 
  cmd_err:
-	mmc_card_release_host(card);
-
 	ret = 1;
 
-	/*
-	 * For writes and where the host claims to support proper
-	 * error reporting, we first ok the successful blocks.
+ 	/*
+ 	 * If this is an SD card and we're writing, we can first
+ 	 * mark the known good sectors as ok.
+ 	 *
+	 * If the card is not SD, we can still ok written sectors
+	 * if the controller can do proper error reporting.
 	 *
 	 * For reads we just fail the entire chunk as that should
 	 * be safe in all cases.
 	 */
-	if (rq_data_dir(req) != READ &&
-	    (card->host->caps & MMC_CAP_MULTIWRITE)) {
+ 	if (rq_data_dir(req) != READ && mmc_card_sd(card)) {
+		u32 blocks;
+		unsigned int bytes;
+
+		blocks = mmc_sd_num_wr_blocks(card);
+		if (blocks != (u32)-1) {
+			if (card->csd.write_partial)
+				bytes = blocks << md->block_bits;
+			else
+				bytes = blocks << 9;
+			spin_lock_irq(&md->lock);
+			ret = end_that_request_chunk(req, 1, bytes);
+			spin_unlock_irq(&md->lock);
+		}
+	} else if (rq_data_dir(req) != READ &&
+		   (card->host->caps & MMC_CAP_MULTIWRITE)) {
 		spin_lock_irq(&md->lock);
 		ret = end_that_request_chunk(req, 1, brq.data.bytes_xfered);
 		spin_unlock_irq(&md->lock);
 	}
 
+	mmc_card_release_host(card);
+
 	spin_lock_irq(&md->lock);
 	while (ret) {
 		ret = end_that_request_chunk(req, 0,
diff --git a/include/linux/mmc/protocol.h b/include/linux/mmc/protocol.h
index 81c3f77..08dec8d 100644
--- a/include/linux/mmc/protocol.h
+++ b/include/linux/mmc/protocol.h
@@ -83,6 +83,7 @@ #define SD_SEND_RELATIVE_ADDR     3   /*
 
   /* Application commands */
 #define SD_APP_SET_BUS_WIDTH      6   /* ac   [1:0] bus width    R1  */
+#define SD_APP_SEND_NUM_WR_BLKS  22   /* adtc                    R1  */
 #define SD_APP_OP_COND           41   /* bcr  [31:0] OCR         R3  */
 #define SD_APP_SEND_SCR          51   /* adtc                    R1  */
 

