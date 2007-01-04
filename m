Return-Path: <linux-kernel-owner+w=401wt.eu-S964874AbXADO6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbXADO6Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 09:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbXADO6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 09:58:25 -0500
Received: from usul.saidi.cx ([204.11.33.34]:52282 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964874AbXADO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 09:58:24 -0500
Message-ID: <459D15DC.1090303@overt.org>
Date: Thu, 04 Jan 2007 06:57:32 -0800
From: Philip Langdale <philipl@overt.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>
CC: Andrew Morton <akpm@osdl.org>, John Gilmore <gnu@toad.com>
Subject: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 5)
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the generous donation of an SDHC card by John Gilmore, and the
surprisingly enlightened decision by the SD Card Association to publish
useful specs, I've been able to bash out support for SDHC. The changes
are not too profound:

i) Add a card flag indicating the card uses block level addressing and check
it in the block driver. As we never took advantage of byte-level addressing,
this simply involves skipping the block -> byte translation when sending commands.

ii) The layout of the CSD is changed - a set of fields are discarded to make space
for a larger C_SIZE. We did not reference any of the discarded fields except those
related to the C_SIZE.

iii) Read and write timeouts are fixed values and not calculated from CSD values.

iv) Before invoking SEND_APP_OP_COND, we must invoke the new SEND_IF_COND to inform
the card we support SDHC.

I've done some basic read and write tests and everything seems to work fine but one
should obviously use caution in case it eats your data.

Signed-off-by: Philipl Langdale <philipl@overt.org>
---
 drivers/mmc/mmc.c            |  138 ++++++++++++++++++++++++++++++++++---------
 drivers/mmc/mmc_block.c      |    8 ++
 include/linux/mmc/card.h     |    3
 include/linux/mmc/mmc.h      |    1
 include/linux/mmc/protocol.h |   13 +++-
 5 files changed, 134 insertions(+), 29 deletions(-)

--- /usr/src/linux/drivers/mmc/mmc.c	2007-01-04 06:51:58.000000000 -0800
+++ linux-2.6.19-sdhc/drivers/mmc/mmc.c	2007-01-03 22:16:24.000000000 -0800
@@ -289,7 +289,10 @@
 		else
 			limit_us = 100000;

-		if (timeout_us > limit_us) {
+		/*
+		 * SDHC cards always use these fixed values.
+		 */
+		if (timeout_us > limit_us || mmc_card_blockaddr(card)) {
 			data->timeout_ns = limit_us * 1000;
 			data->timeout_clks = 0;
 		}
@@ -588,34 +591,65 @@

 	if (mmc_card_sd(card)) {
 		csd_struct = UNSTUFF_BITS(resp, 126, 2);
-		if (csd_struct != 0) {
+
+		switch (csd_struct) {
+		case 0:
+			m = UNSTUFF_BITS(resp, 115, 4);
+			e = UNSTUFF_BITS(resp, 112, 3);
+			csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
+			csd->tacc_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
+	
+			m = UNSTUFF_BITS(resp, 99, 4);
+			e = UNSTUFF_BITS(resp, 96, 3);
+			csd->max_dtr	  = tran_exp[e] * tran_mant[m];
+			csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+	
+			e = UNSTUFF_BITS(resp, 47, 3);
+			m = UNSTUFF_BITS(resp, 62, 12);
+			csd->capacity	  = (1 + m) << (e + 2);
+	
+			csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
+			csd->read_partial = UNSTUFF_BITS(resp, 79, 1);
+			csd->write_misalign = UNSTUFF_BITS(resp, 78, 1);
+			csd->read_misalign = UNSTUFF_BITS(resp, 77, 1);
+			csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
+			csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
+			csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
+			break;
+		case 1:
+			/*
+			 * This is a block-addressed SDHC card. Most
+			 * interesting fields are unused and have fixed
+			 * values. To avoid getting tripped by buggy cards,
+			 * we assume those fixed values ourselves.
+			 */
+			mmc_card_set_blockaddr(card);
+
+			csd->tacc_ns	 = 0; /* Unused */
+			csd->tacc_clks	 = 0; /* Unused */
+	
+			m = UNSTUFF_BITS(resp, 99, 4);
+			e = UNSTUFF_BITS(resp, 96, 3);
+			csd->max_dtr	  = tran_exp[e] * tran_mant[m];
+			csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+	
+			m = UNSTUFF_BITS(resp, 48, 22);
+			csd->capacity     = (1 + m) << 10;
+	
+			csd->read_blkbits = 9;
+			csd->read_partial = 0;
+			csd->write_misalign = 0;
+			csd->read_misalign = 0;
+			csd->r2w_factor = 4; /* Unused */
+			csd->write_blkbits = 9;
+			csd->write_partial = 0;
+			break;
+		default:
 			printk("%s: unrecognised CSD structure version %d\n",
 				mmc_hostname(card->host), csd_struct);
 			mmc_card_set_bad(card);
 			return;
 		}
-
-		m = UNSTUFF_BITS(resp, 115, 4);
-		e = UNSTUFF_BITS(resp, 112, 3);
-		csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
-		csd->tacc_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
-
-		m = UNSTUFF_BITS(resp, 99, 4);
-		e = UNSTUFF_BITS(resp, 96, 3);
-		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
-		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
-
-		e = UNSTUFF_BITS(resp, 47, 3);
-		m = UNSTUFF_BITS(resp, 62, 12);
-		csd->capacity	  = (1 + m) << (e + 2);
-
-		csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
-		csd->read_partial = UNSTUFF_BITS(resp, 79, 1);
-		csd->write_misalign = UNSTUFF_BITS(resp, 78, 1);
-		csd->read_misalign = UNSTUFF_BITS(resp, 77, 1);
-		csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
-		csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
-		csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
 	} else {
 		/*
 		 * We only understand CSD structure v1.1 and v1.2.
@@ -848,6 +882,41 @@
 	return err;
 }

+static int mmc_send_if_cond(struct mmc_host *host, u32 ocr, int *rsd2)
+{
+	struct mmc_command cmd;
+	int err, sd2;
+	static const u8 test_pattern = 0xAA;
+
+	/*
+	* To support SD 2.0 cards, we must always invoke SD_SEND_IF_COND
+	* before SD_APP_OP_COND. This command will harmlessly fail for
+	* SD 1.0 cards.
+	*/
+	cmd.opcode = SD_SEND_IF_COND;
+	cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
+	cmd.flags = MMC_RSP_R7 | MMC_CMD_BCR;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err == MMC_ERR_NONE) {
+		if ((cmd.resp[0] & 0xFF) == test_pattern) {
+			sd2 = 1;
+		} else {
+			sd2 = 0;
+			err = MMC_ERR_FAILED;
+		}
+	} else {
+		/*
+		 * Treat errors as SD 1.0 card.
+		 */
+		sd2 = 0;
+		err = MMC_ERR_NONE;
+	}
+	if (rsd2)
+		*rsd2 = sd2;
+	return err;
+}
+
 /*
  * Discover cards by requesting their CID.  If this command
  * times out, it is not an error; there are no further cards
@@ -1334,6 +1403,10 @@
 		mmc_power_up(host);
 		mmc_idle_cards(host);

+		err = mmc_send_if_cond(host, host->ocr_avail, NULL);
+		if (err != MMC_ERR_NONE) {
+			return;
+		}
 		err = mmc_send_app_op_cond(host, 0, &ocr);

 		/*
@@ -1386,10 +1459,21 @@
 	 * all get the idea that they should be ready for CMD2.
 	 * (My SanDisk card seems to need this.)
 	 */
-	if (host->mode == MMC_MODE_SD)
-		mmc_send_app_op_cond(host, host->ocr, NULL);
-	else
+	if (host->mode == MMC_MODE_SD) {
+		int err, sd2;
+		err = mmc_send_if_cond(host, host->ocr, &sd2);
+		if (err == MMC_ERR_NONE) {
+			/*
+			* If SD_SEND_IF_COND indicates an SD 2.0
+			* compliant card and we should set bit 30
+			* of the ocr to indicate that we can handle
+			* block-addressed SDHC cards.
+			*/
+			mmc_send_app_op_cond(host, host->ocr | (sd2 << 30), NULL);
+		}
+	} else {
 		mmc_send_op_cond(host, host->ocr, NULL);
+	}

 	mmc_discover_cards(host);

--- /usr/src/linux/drivers/mmc/mmc_block.c	2007-01-04 06:51:58.000000000 -0800
+++ linux-2.6.19-sdhc/drivers/mmc/mmc_block.c	2007-01-01 06:42:37.000000000 -0800
@@ -237,7 +237,9 @@
 		brq.mrq.cmd = &brq.cmd;
 		brq.mrq.data = &brq.data;

-		brq.cmd.arg = req->sector << 9;
+		brq.cmd.arg = req->sector;
+		if (!mmc_card_blockaddr(card))
+			brq.cmd.arg <<= 9;
 		brq.cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 		brq.data.blksz = 1 << md->block_bits;
 		brq.data.blocks = req->nr_sectors >> (md->block_bits - 9);
@@ -494,6 +496,10 @@
 	struct mmc_command cmd;
 	int err;

+	/* Block-addressed cards ignore MMC_SET_BLOCKLEN. */
+	if (mmc_card_blockaddr(card))
+		return 0;
+
 	mmc_card_claim_host(card);
 	cmd.opcode = MMC_SET_BLOCKLEN;
 	cmd.arg = 1 << md->block_bits;
--- /usr/src/linux/include/linux/mmc/card.h	2007-01-04 06:51:58.000000000 -0800
+++ linux-2.6.19-sdhc/include/linux/mmc/card.h	2006-12-31 19:00:43.000000000 -0800
@@ -71,6 +71,7 @@
 #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
 #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
 #define MMC_STATE_HIGHSPEED	(1<<5)		/* card is in high speed mode */
+#define MMC_STATE_BLOCKADDR	(1<<6)		/* card uses block-addressing */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
@@ -87,6 +88,7 @@
 #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
+#define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)

 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
@@ -94,6 +96,7 @@
 #define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
+#define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)

 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)
--- /usr/src/linux/include/linux/mmc/mmc.h	2007-01-04 06:51:58.000000000 -0800
+++ linux-2.6.19-sdhc/include/linux/mmc/mmc.h	2007-01-04 06:51:09.000000000 -0800
@@ -43,6 +43,7 @@
 #define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
 #define MMC_RSP_R3	(MMC_RSP_PRESENT)
 #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
+#define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)

 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))

--- /usr/src/linux/include/linux/mmc/protocol.h	2007-01-04 06:51:58.000000000 -0800
+++ linux-2.6.19-sdhc/include/linux/mmc/protocol.h	2006-12-31 19:00:43.000000000 -0800
@@ -79,9 +79,12 @@
 #define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1  */

 /* SD commands                           type  argument     response */
-  /* class 8 */
+  /* class 0 */
 /* This is basically the same command as for MMC with some quirks. */
 #define SD_SEND_RELATIVE_ADDR     3   /* bcr                     R6  */
+#define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7  */
+
+  /* class 10 */
 #define SD_SWITCH                 6   /* adtc [31:0] See below   R1  */

   /* Application commands */
@@ -115,6 +118,14 @@
  */

 /*
+ * SD_SEND_IF_COND argument format:
+ *
+ *	[31:12] Reserved (0)
+ *	[11:8] Host Voltage Supply Flags
+ *	[7:0] Check Pattern (0xAA)
+ */
+
+/*
   MMC status in R1
   Type
   	e : error bit

