Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423442AbWBBKkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423442AbWBBKkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423097AbWBBKkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:40:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40971 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423442AbWBBKkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:40:40 -0500
Date: Thu, 2 Feb 2006 10:40:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>, Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Anderson Briglia <anderson.briglia@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] MMC OMAP driver
Message-ID: <20060202104022.GF5034@flint.arm.linux.org.uk>
Mail-Followup-To: Tony Lindgren <tony@atomide.com>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Anderson Briglia <anderson.briglia@indt.org.br>,
	linux-kernel@vger.kernel.org
References: <43DF6750.1060505@indt.org.br> <20060201124434.GC3072@flint.arm.linux.org.uk> <20060201194724.GD15939@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201194724.GD15939@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 11:47:25AM -0800, Tony Lindgren wrote:
> * Russell King <rmk+lkml@arm.linux.org.uk> [060201 04:44]:
> > I'm thinking we want a couple of helper functions:
> > 
> > 	mmc_resp_type(cmd)
> > 	mmc_cmd_type(cmd)
> > 
> > which would allow the flags value to be tested for response and command
> > types - in which case we'd need to also have MMC_CMD_DATA as well.  For
> > an example of what I'm proposing, see the end of this message.
> 
> That sounds like a good solution.

Here's a revised patch.  Pierre - could you look at the missing command
types marked with /* ? */ in this patch please?

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -194,7 +194,7 @@ static int au1xmmc_send_command(struct a
 
 	u32 mmccmd = (cmd->opcode << SD_CMD_CI_SHIFT);
 
-	switch(cmd->flags) {
+	switch (mmc_rsp_type(cmd->flags)) {
 	case MMC_RSP_R1:
 		mmccmd |= SD_CMD_RT_1;
 		break;
@@ -483,34 +483,35 @@ static void au1xmmc_cmd_complete(struct 
 	cmd = mrq->cmd;
 	cmd->error = MMC_ERR_NONE;
 
-	if ((cmd->flags & MMC_RSP_MASK) == MMC_RSP_SHORT) {
-
-		/* Techincally, we should be getting all 48 bits of the response
-		 * (SD_RESP1 + SD_RESP2), but because our response omits the CRC,
-		 * our data ends up being shifted 8 bits to the right.  In this case,
-		 * that means that the OSR data starts at bit 31, so we can just
-		 * read RESP0 and return that
-		 */
-
-		cmd->resp[0] = au_readl(host->iobase + SD_RESP0);
-	}
-	else if ((cmd->flags & MMC_RSP_MASK) == MMC_RSP_LONG) {
-		u32 r[4];
-		int i;
-
-		r[0] = au_readl(host->iobase + SD_RESP3);
-		r[1] = au_readl(host->iobase + SD_RESP2);
-		r[2] = au_readl(host->iobase + SD_RESP1);
-		r[3] = au_readl(host->iobase + SD_RESP0);
-
-		/* The CRC is omitted from the response, so really we only got
-		 * 120 bytes, but the engine expects 128 bits, so we have to shift
-		 * things up
-		 */
-
-		for(i = 0; i < 4; i++) {
-			cmd->resp[i] = (r[i] & 0x00FFFFFF) << 8;
-			if (i != 3) cmd->resp[i] |= (r[i + 1] & 0xFF000000) >> 24;
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136) {
+			u32 r[4];
+			int i;
+
+			r[0] = au_readl(host->iobase + SD_RESP3);
+			r[1] = au_readl(host->iobase + SD_RESP2);
+			r[2] = au_readl(host->iobase + SD_RESP1);
+			r[3] = au_readl(host->iobase + SD_RESP0);
+
+			/* The CRC is omitted from the response, so really
+			 * we only got 120 bytes, but the engine expects
+			 * 128 bits, so we have to shift things up
+			 */
+
+			for(i = 0; i < 4; i++) {
+				cmd->resp[i] = (r[i] & 0x00FFFFFF) << 8;
+				if (i != 3)
+					cmd->resp[i] |= (r[i + 1] & 0xFF000000) >> 24;
+			}
+		} else {
+			/* Techincally, we should be getting all 48 bits of
+			 * the response (SD_RESP1 + SD_RESP2), but because
+			 * our response omits the CRC, our data ends up
+			 * being shifted 8 bits to the right.  In this case,
+			 * that means that the OSR data starts at bit 31,
+			 * so we can just read RESP0 and return that
+			 */
+			cmd->resp[0] = au_readl(host->iobase + SD_RESP0);
 		}
 	}
 
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -211,7 +211,7 @@ int mmc_wait_for_app_cmd(struct mmc_host
 
 		appcmd.opcode = MMC_APP_CMD;
 		appcmd.arg = rca << 16;
-		appcmd.flags = MMC_RSP_R1;
+		appcmd.flags = MMC_RSP_R1 | MMC_CMD_AC; /* ? */
 		appcmd.retries = 0;
 		memset(appcmd.resp, 0, sizeof(appcmd.resp));
 		appcmd.data = NULL;
@@ -331,7 +331,7 @@ static int mmc_select_card(struct mmc_ho
 
 	cmd.opcode = MMC_SELECT_CARD;
 	cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_R1;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
 	err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
 	if (err != MMC_ERR_NONE)
@@ -358,7 +358,7 @@ static int mmc_select_card(struct mmc_ho
 			struct mmc_command cmd;
 			cmd.opcode = SD_APP_SET_BUS_WIDTH;
 			cmd.arg = SD_BUS_WIDTH_4;
-			cmd.flags = MMC_RSP_R1;
+			cmd.flags = MMC_RSP_R1; /* ? */
 
 			err = mmc_wait_for_app_cmd(host, card->rca, &cmd,
 				CMD_RETRIES);
@@ -386,7 +386,7 @@ static void mmc_deselect_cards(struct mm
 
 		cmd.opcode = MMC_SELECT_CARD;
 		cmd.arg = 0;
-		cmd.flags = MMC_RSP_NONE;
+		cmd.flags = MMC_RSP_NONE | MMC_CMD_AC;
 
 		mmc_wait_for_cmd(host, &cmd, 0);
 	}
@@ -677,7 +677,7 @@ static void mmc_idle_cards(struct mmc_ho
 
 	cmd.opcode = MMC_GO_IDLE_STATE;
 	cmd.arg = 0;
-	cmd.flags = MMC_RSP_NONE;
+	cmd.flags = MMC_RSP_NONE | MMC_CMD_BC;
 
 	mmc_wait_for_cmd(host, &cmd, 0);
 
@@ -738,7 +738,7 @@ static int mmc_send_op_cond(struct mmc_h
 
 	cmd.opcode = MMC_SEND_OP_COND;
 	cmd.arg = ocr;
-	cmd.flags = MMC_RSP_R3;
+	cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
 
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_cmd(host, &cmd, 0);
@@ -766,7 +766,7 @@ static int mmc_send_app_op_cond(struct m
 
 	cmd.opcode = SD_APP_OP_COND;
 	cmd.arg = ocr;
-	cmd.flags = MMC_RSP_R3;
+	cmd.flags = MMC_RSP_R3; /* ? */
 
 	for (i = 100; i; i--) {
 		err = mmc_wait_for_app_cmd(host, 0, &cmd, CMD_RETRIES);
@@ -805,7 +805,7 @@ static void mmc_discover_cards(struct mm
 
 		cmd.opcode = MMC_ALL_SEND_CID;
 		cmd.arg = 0;
-		cmd.flags = MMC_RSP_R2;
+		cmd.flags = MMC_RSP_R2 | MMC_CMD_BCR;
 
 		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
 		if (err == MMC_ERR_TIMEOUT) {
@@ -835,7 +835,7 @@ static void mmc_discover_cards(struct mm
 
 			cmd.opcode = SD_SEND_RELATIVE_ADDR;
 			cmd.arg = 0;
-			cmd.flags = MMC_RSP_R6;
+			cmd.flags = MMC_RSP_R6; /* ? */
 
 			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
 			if (err != MMC_ERR_NONE)
@@ -856,7 +856,7 @@ static void mmc_discover_cards(struct mm
 		} else {
 			cmd.opcode = MMC_SET_RELATIVE_ADDR;
 			cmd.arg = card->rca << 16;
-			cmd.flags = MMC_RSP_R1;
+			cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
 			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
 			if (err != MMC_ERR_NONE)
@@ -878,7 +878,7 @@ static void mmc_read_csds(struct mmc_hos
 
 		cmd.opcode = MMC_SEND_CSD;
 		cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_R2;
+		cmd.flags = MMC_RSP_R2 | MMC_CMD_AC;
 
 		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
 		if (err != MMC_ERR_NONE) {
@@ -920,7 +920,7 @@ static void mmc_read_scrs(struct mmc_hos
 
 		cmd.opcode = MMC_APP_CMD;
 		cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_R1;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC; /* ? */
 
 		err = mmc_wait_for_cmd(host, &cmd, 0);
 		if ((err != MMC_ERR_NONE) || !(cmd.resp[0] & R1_APP_CMD)) {
@@ -932,7 +932,7 @@ static void mmc_read_scrs(struct mmc_hos
 
 		cmd.opcode = SD_APP_SEND_SCR;
 		cmd.arg = 0;
-		cmd.flags = MMC_RSP_R1;
+		cmd.flags = MMC_RSP_R1; /* ? */
 
 		memset(&data, 0, sizeof(struct mmc_data));
 
@@ -1003,7 +1003,7 @@ static void mmc_check_cards(struct mmc_h
 
 		cmd.opcode = MMC_SEND_STATUS;
 		cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_R1;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
 		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
 		if (err == MMC_ERR_NONE)
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -171,14 +171,14 @@ static int mmc_blk_issue_rq(struct mmc_q
 		brq.mrq.data = &brq.data;
 
 		brq.cmd.arg = req->sector << 9;
-		brq.cmd.flags = MMC_RSP_R1;
+		brq.cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 		brq.data.timeout_ns = card->csd.tacc_ns * 10;
 		brq.data.timeout_clks = card->csd.tacc_clks * 10;
 		brq.data.blksz_bits = md->block_bits;
 		brq.data.blocks = req->nr_sectors >> (md->block_bits - 9);
 		brq.stop.opcode = MMC_STOP_TRANSMISSION;
 		brq.stop.arg = 0;
-		brq.stop.flags = MMC_RSP_R1B;
+		brq.stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
 
 		if (rq_data_dir(req) == READ) {
 			brq.cmd.opcode = brq.data.blocks > 1 ? MMC_READ_MULTIPLE_BLOCK : MMC_READ_SINGLE_BLOCK;
@@ -223,7 +223,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 
 			cmd.opcode = MMC_SEND_STATUS;
 			cmd.arg = card->rca << 16;
-			cmd.flags = MMC_RSP_R1;
+			cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 			err = mmc_wait_for_cmd(card->host, &cmd, 5);
 			if (err) {
 				printk(KERN_ERR "%s: error %d requesting status\n",
@@ -430,7 +430,7 @@ mmc_blk_set_blksize(struct mmc_blk_data 
 	mmc_card_claim_host(card);
 	cmd.opcode = MMC_SET_BLOCKLEN;
 	cmd.arg = 1 << md->block_bits;
-	cmd.flags = MMC_RSP_R1;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 	err = mmc_wait_for_cmd(card->host, &cmd, 5);
 	mmc_card_release_host(card);
 
diff --git a/drivers/mmc/mmci.c b/drivers/mmc/mmci.c
--- a/drivers/mmc/mmci.c
+++ b/drivers/mmc/mmci.c
@@ -124,15 +124,10 @@ mmci_start_command(struct mmci_host *hos
 	}
 
 	c |= cmd->opcode | MCI_CPSM_ENABLE;
-	switch (cmd->flags & MMC_RSP_MASK) {
-	case MMC_RSP_NONE:
-	default:
-		break;
-	case MMC_RSP_LONG:
-		c |= MCI_CPSM_LONGRSP;
-	case MMC_RSP_SHORT:
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136)
+			c |= MCI_CPSM_LONGRSP;
 		c |= MCI_CPSM_RESPONSE;
-		break;
 	}
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
diff --git a/drivers/mmc/pxamci.c b/drivers/mmc/pxamci.c
--- a/drivers/mmc/pxamci.c
+++ b/drivers/mmc/pxamci.c
@@ -178,14 +178,15 @@ static void pxamci_start_cmd(struct pxam
 	if (cmd->flags & MMC_RSP_BUSY)
 		cmdat |= CMDAT_BUSY;
 
-	switch (cmd->flags & (MMC_RSP_MASK | MMC_RSP_CRC)) {
-	case MMC_RSP_SHORT | MMC_RSP_CRC:
+#define RSP_TYPE(x)	((x) & ~(MMC_RSP_BUSY|MMC_RSP_OPCODE))
+	switch (RSP_TYPE(mmc_resp_type(cmd))) {
+	case RSP_TYPE(MMC_RSP_R1): /* r1, r1b, r6 */
 		cmdat |= CMDAT_RESP_SHORT;
 		break;
-	case MMC_RSP_SHORT:
+	case RSP_TYPE(MMC_RSP_R3):
 		cmdat |= CMDAT_RESP_R3;
 		break;
-	case MMC_RSP_LONG | MMC_RSP_CRC:
+	case RSP_TYPE(MMC_RSP_R2):
 		cmdat |= CMDAT_RESP_R2;
 		break;
 	default:
diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -459,7 +459,7 @@ static void wbsd_send_command(struct wbs
 	/*
 	 * Do we expect a reply?
 	 */
-	if ((cmd->flags & MMC_RSP_MASK) != MMC_RSP_NONE) {
+	if (cmd->flags & MMC_RSP_PRESENT) {
 		/*
 		 * Read back status.
 		 */
@@ -476,10 +476,10 @@ static void wbsd_send_command(struct wbs
 			cmd->error = MMC_ERR_BADCRC;
 		/* All ok */
 		else {
-			if ((cmd->flags & MMC_RSP_MASK) == MMC_RSP_SHORT)
-				wbsd_get_short_reply(host, cmd);
-			else
+			if (cmd->flags & MMC_RSP_136)
 				wbsd_get_long_reply(host, cmd);
+			else
+				wbsd_get_short_reply(host, cmd);
 		}
 	}
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -21,24 +21,35 @@ struct mmc_command {
 	u32			arg;
 	u32			resp[4];
 	unsigned int		flags;		/* expected response type */
-#define MMC_RSP_NONE	(0 << 0)
-#define MMC_RSP_SHORT	(1 << 0)
-#define MMC_RSP_LONG	(2 << 0)
-#define MMC_RSP_MASK	(3 << 0)
-#define MMC_RSP_CRC	(1 << 3)		/* expect valid crc */
-#define MMC_RSP_BUSY	(1 << 4)		/* card may send busy */
-#define MMC_RSP_OPCODE	(1 << 5)		/* response contains opcode */
+#define MMC_RSP_PRESENT	(1 << 0)
+#define MMC_RSP_136	(1 << 1)		/* 136 bit response */
+#define MMC_RSP_CRC	(1 << 2)		/* expect valid crc */
+#define MMC_RSP_BUSY	(1 << 3)		/* card may send busy */
+#define MMC_RSP_OPCODE	(1 << 4)		/* response contains opcode */
+#define MMC_CMD_MASK	(3 << 5)		/* command type */
+#define MMC_CMD_AC	(0 << 5)
+#define MMC_CMD_ADTC	(1 << 5)
+#define MMC_CMD_BC	(2 << 5)
+#define MMC_CMD_BCR	(3 << 5)
 
 /*
  * These are the response types, and correspond to valid bit
  * patterns of the above flags.  One additional valid pattern
  * is all zeros, which means we don't expect a response.
  */
-#define MMC_RSP_R1	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_OPCODE)
-#define MMC_RSP_R1B	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
-#define MMC_RSP_R2	(MMC_RSP_LONG|MMC_RSP_CRC)
-#define MMC_RSP_R3	(MMC_RSP_SHORT)
-#define MMC_RSP_R6	(MMC_RSP_SHORT|MMC_RSP_CRC)
+#define MMC_RSP_NONE	(0)
+#define MMC_RSP_R1	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
+#define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
+#define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
+#define MMC_RSP_R3	(MMC_RSP_PRESENT)
+#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
+
+#define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
+
+/*
+ * These are the command types.
+ */
+#define mmc_cmd_type(cmd)	((cmd)->flags & MMC_CMD_TYPE)
 
 	unsigned int		retries;	/* max number of retries */
 	unsigned int		error;		/* command error */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
