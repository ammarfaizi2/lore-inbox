Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWIEFfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWIEFfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 01:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWIEFfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 01:35:45 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:49291 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S965160AbWIEFfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 01:35:44 -0400
Message-ID: <44FD0CAA.6020706@drzeus.cx>
Date: Tue, 05 Sep 2006 07:35:38 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hera.drzeus.cx-26827-1157434539-0001-2"
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060905021828.13099.qmail@web36706.mail.mud.yahoo.com>
In-Reply-To: <20060905021828.13099.qmail@web36706.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-26827-1157434539-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Alex Dubov wrote:
> I also got a bug report from one of my users. Formerly, I used fixed timeout for data transfer,
> but now I'm setting a timeout from data->timeout_clks. This causes recurrent timeouts with some
> cards. Have you encountered this problem before? If yes, what will be the preferred solution?
>
>   

Yup. The timeout calculation we currently have is broken with regard to
SD cards. Only some cards are affected though. Patch included.

Rgds
Pierre


--=_hera.drzeus.cx-26827-1157434539-0001-2
Content-Type: text/x-patch; name="sd-timeout.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sd-timeout.patch"

[MMC] Fix SD timeout calculation

Secure Digital cards use a different algorithm to calculate the timeout
for data transfers. Using the MMC one works often, but not always.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc.c       |   15 +++++++++++++--
 drivers/mmc/mmc_block.c |   44 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 33525bd..c0c7ef2 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -912,6 +912,7 @@ static void mmc_read_scrs(struct mmc_hos
 	struct mmc_request mrq;
 	struct mmc_command cmd;
 	struct mmc_data data;
+	unsigned int timeout_us;
 
 	struct scatterlist sg;
 
@@ -947,8 +948,18 @@ static void mmc_read_scrs(struct mmc_hos
 
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
index e033424..cb7fc8d 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -30,6 +30,7 @@ #include <linux/blkdev.h>
 #include <linux/mutex.h>
 
 #include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
 #include <linux/mmc/protocol.h>
 
 #include <asm/system.h>
@@ -171,8 +172,6 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 		brq.cmd.arg = req->sector << 9;
 		brq.cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
-		brq.data.timeout_ns = card->csd.tacc_ns * 10;
-		brq.data.timeout_clks = card->csd.tacc_clks * 10;
 		brq.data.blksz_bits = md->block_bits;
 		brq.data.blksz = 1 << md->block_bits;
 		brq.data.blocks = req->nr_sectors >> (md->block_bits - 9);
@@ -180,6 +179,41 @@ static int mmc_blk_issue_rq(struct mmc_q
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
@@ -187,12 +221,6 @@ static int mmc_blk_issue_rq(struct mmc_q
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

--=_hera.drzeus.cx-26827-1157434539-0001-2--
