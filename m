Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWIGM6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWIGM6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWIGM6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:58:46 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:10761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751771AbWIGM6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:58:45 -0400
Date: Thu, 7 Sep 2006 13:58:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [MMC] Fix SD timeout calculation
Message-ID: <20060907125840.GA6015@dyn-67.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20060618123432.15915.71389.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618123432.15915.71389.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 02:34:37PM +0200, Pierre Ossman wrote:
> Secure Digital cards use a different algorithm to calculate the timeout
> for data transfers. Using the MMC one works often, but not always.

Applied, thanks.

I'm wondering about this cleanup though - both the timeout calculations
appear to be identical, so making this a library function seems to be
the right way to go... unless you know different?

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index c0c7ef2..74eaaee 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -247,6 +247,55 @@ int mmc_wait_for_app_cmd(struct mmc_host
 
 EXPORT_SYMBOL(mmc_wait_for_app_cmd);
 
+/**
+ *	mmc_set_data_timeout - set the timeout for a data command
+ *	@data: data phase for command
+ *	@card: the MMC card associated with the data transfer
+ *	@write: flag to differentiate reads from writes
+ */
+void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card,
+			  int write)
+{
+	unsigned int mult;
+
+	/*
+	 * SD cards use a 100 multiplier rather than 10
+	 */
+	mult = mmc_card_sd(card) ? 100 : 10;
+
+	/*
+	 * Scale up the multiplier (and therefore the timeout) by
+	 * the r2w factor for writes.
+	 */
+	if (write)
+		mult <<= card->csd.r2w_factor;
+
+	data->timeout_ns = card->csd.tacc_ns * mult;
+	data->timeout_clks = card->csd.tacc_clks * mult;
+
+	/*
+	 * SD cards also have an upper limit on the timeout.
+	 */
+	if (mmc_card_sd(card)) {
+		unsigned int timeout_us, limit_us;
+
+		timeout_us = data->timeout_ns / 1000;
+		timeout_us += data->timeout_clks * 1000 /
+			(card->host->ios.clock / 1000);
+
+		if (write)
+			limit_us = 250000;
+		else
+			limit_us = 100000;
+
+		if (timeout_us > limit_us) {
+			data->timeout_ns = limit_us * 1000;
+			data->timeout_clks = 0;
+		}
+	}
+}
+EXPORT_SYMBOL(mmc_set_data_timeout);
+
 static int mmc_select_card(struct mmc_host *host, struct mmc_card *card);
 
 /**
@@ -908,12 +957,9 @@ static void mmc_read_scrs(struct mmc_hos
 {
 	int err;
 	struct mmc_card *card;
-
 	struct mmc_request mrq;
 	struct mmc_command cmd;
 	struct mmc_data data;
-	unsigned int timeout_us;
-
 	struct scatterlist sg;
 
 	list_for_each_entry(card, &host->cards, node) {
@@ -948,17 +994,7 @@ static void mmc_read_scrs(struct mmc_hos
 
 		memset(&data, 0, sizeof(struct mmc_data));
 
-		data.timeout_ns = card->csd.tacc_ns * 100;
-		data.timeout_clks = card->csd.tacc_clks * 100;
-
-		timeout_us = data.timeout_ns / 1000;
-		timeout_us += data.timeout_clks * 1000 /
-			(host->ios.clock / 1000);
-
-		if (timeout_us > 100000) {
-			data.timeout_ns = 100000000;
-			data.timeout_clks = 0;
-		}
+		mmc_set_data_timeout(&data, card, 0);
 
 		data.blksz_bits = 3;
 		data.blksz = 1 << 3;
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index 515fb22..d6fcc46 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -179,40 +179,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 		brq.stop.arg = 0;
 		brq.stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
 
-		brq.data.timeout_ns = card->csd.tacc_ns * 10;
-		brq.data.timeout_clks = card->csd.tacc_clks * 10;
-
-		/*
-		 * Scale up the timeout by the r2w factor
-		 */
-		if (rq_data_dir(req) == WRITE) {
-			brq.data.timeout_ns <<= card->csd.r2w_factor;
-			brq.data.timeout_clks <<= card->csd.r2w_factor;
-		}
-
-		/*
-		 * SD cards use a 100 multiplier and has a upper limit
-		 */
-		if (mmc_card_sd(card)) {
-			unsigned int limit_us, timeout_us;
-
-			brq.data.timeout_ns *= 10;
-			brq.data.timeout_clks *= 10;
-
-			if (rq_data_dir(req) == READ)
-				limit_us = 100000;
-			else
-				limit_us = 250000;
-
-			timeout_us = brq.data.timeout_ns / 1000;
-			timeout_us += brq.data.timeout_clks * 1000 /
-				(card->host->ios.clock / 1000);
-
-			if (timeout_us > limit_us) {
-				brq.data.timeout_ns = limit_us * 1000;
-				brq.data.timeout_clks = 0;
-			}
-		}
+		mmc_set_data_timeout(&brq.data, card, rq_data_dir(req) != READ);
 
 		if (rq_data_dir(req) == READ) {
 			brq.cmd.opcode = brq.data.blocks > 1 ? MMC_READ_MULTIPLE_BLOCK : MMC_READ_SINGLE_BLOCK;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 03a14a3..627e2c0 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -105,6 +105,8 @@ extern int mmc_wait_for_cmd(struct mmc_h
 extern int mmc_wait_for_app_cmd(struct mmc_host *, unsigned int,
 	struct mmc_command *, int);
 
+extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *, int);
+
 extern int __mmc_claim_host(struct mmc_host *host, struct mmc_card *card);
 
 static inline void mmc_claim_host(struct mmc_host *host)

