Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWJDFwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWJDFwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 01:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWJDFwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 01:52:08 -0400
Received: from usul.saidi.cx ([204.11.33.34]:61160 "EHLO usul.overt.org")
	by vger.kernel.org with ESMTP id S1161087AbWJDFwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 01:52:04 -0400
Message-ID: <21173.67.169.45.37.1159940502.squirrel@overt.org>
Date: Wed, 4 Oct 2006 01:41:42 -0400 (EDT)
Subject: [PATCH 2.6.18 1/1] mmc: Add support for mmc v4 high speed mode
From: philipl@overt.org
To: drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.8
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.53
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

I couldn't wait to do this, so here's the updated diff :-)

I've taken your previous comments to heart and I believe that
this can probably just be a single diff, but if you want me to
split it out, just ask.

This adds support for the high-speed modes defined by mmc v4
(assuming the host controller is up to it). On a TI sdhci controller,
it improves read speed from 1.3MBps to 2.3MBps. The TI controller can
only go up to 24MHz, but everything helps. Another person has taken
this basic patch and used it on a Nokia 770 to get a bigger boost
because that controller can run at 48MHZ.

Thanks,

--phil

Signed-off-by: Philip Langdale <philipl@overt.org>
---

 drivers/mmc/mmc.c            |  110 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h     |    8 +++
 include/linux/mmc/protocol.h |   16 +++++-
 3 files changed, 129 insertions(+), 5 deletions(-)

diff -urN /usr/src/linux-2.6.18/drivers/mmc/mmc.c linux-2.6.18-mmc4/drivers/mmc/mmc.c
--- /usr/src/linux-2.6.18/drivers/mmc/mmc.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18-mmc4/drivers/mmc/mmc.c	2006-10-03 22:14:05.000000000 -0700
@@ -4,6 +4,7 @@
  *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
  *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
  *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
+ *  MMCv4 support Copyright (C) 2006 Philip Langdale, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -427,6 +428,30 @@
 		}
 	}

+	/* Activate highspeed MMC v4 support. */
+	if (card->csd.mmca_vsn == CSD_SPEC_VER_4) {
+		struct mmc_command cmd;
+
+                /*
+                 * Arg breakdown:
+                 * [31:26] Set to 0
+                 * [25:24] Access: Write Byte (0x03)
+                 * [23:16] Index: HS_TIMING (0xB9)
+                 * [15:08] Value: True (0x01)
+                 * [07:03] Set to 0
+                 * [02:00] Cmd Set: Standard (0x00)
+                 */
+		cmd.opcode = MMC_SWITCH;
+	 	cmd.arg = 0x03B90100;
+		cmd.flags = MMC_RSP_R1B;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+		if (err != MMC_ERR_NONE)
+			return err;
+
+		mmc_card_set_highspeed(card);
+	}
+
 	mmc_set_ios(host);

 	return MMC_ERR_NONE;
@@ -953,6 +978,74 @@
 	}
 }

+static void mmc_read_ext_csds(struct mmc_host *host)
+{
+	int err;
+	struct mmc_card *card;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+
+	struct scatterlist sg;
+
+	/*
+	 * As the ext_csd is so large and mostly unused, we don't store the
+	 * raw block in mmc_card.
+	 */
+	u8 ext_csd[512];
+
+	list_for_each_entry(card, &host->cards, node) {
+		if (card->state & (MMC_STATE_DEAD|MMC_STATE_PRESENT))
+			continue;
+		if (mmc_card_sd(card))
+			continue;
+		if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
+			continue;
+
+		err = mmc_select_card(host, card);
+		if (err != MMC_ERR_NONE) {
+			mmc_card_set_dead(card);
+			continue;
+		}
+
+		memset(&cmd, 0, sizeof(struct mmc_command));
+
+		cmd.opcode = MMC_SEND_EXT_CSD;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1;
+
+		memset(&data, 0, sizeof(struct mmc_data));
+
+		mmc_set_data_timeout(&data, card, 0);
+
+		data.blksz_bits = 9;
+		data.blksz = 1 << 9;
+		data.blocks = 1;
+		data.flags = MMC_DATA_READ;
+		data.sg = &sg;
+		data.sg_len = 1;
+
+		memset(&mrq, 0, sizeof(struct mmc_request));
+
+		mrq.cmd = &cmd;
+		mrq.data = &data;
+
+		sg_init_one(&sg, &ext_csd, 512);
+
+		mmc_wait_for_req(host, &mrq);
+
+		if (cmd.error != MMC_ERR_NONE || data.error != MMC_ERR_NONE) {
+			mmc_card_set_dead(card);
+			continue;
+		}
+
+		card->ext_csd.card_type = ext_csd[196];
+	}
+
+	mmc_deselect_cards(host);
+}
+
 static void mmc_read_scrs(struct mmc_host *host)
 {
 	int err;
@@ -1032,8 +1125,19 @@
 	unsigned int max_dtr = host->f_max;

 	list_for_each_entry(card, &host->cards, node)
-		if (!mmc_card_dead(card) && max_dtr > card->csd.max_dtr)
-			max_dtr = card->csd.max_dtr;
+		if (!mmc_card_dead(card)) {
+			if (mmc_card_highspeed(card))
+				if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_52) &&
+				    max_dtr > 52000000)
+					max_dtr = 52000000;
+				else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_26) &&
+					 max_dtr > 26000000)
+					max_dtr = 26000000;
+				else /* mmc v4 spec says this cannot happen */
+					BUG_ON(card->ext_csd.card_type == 0);
+			else if (max_dtr > card->csd.max_dtr)
+				max_dtr = card->csd.max_dtr;
+		}

 	pr_debug("%s: selected %d.%03dMHz transfer rate\n",
 		 mmc_hostname(host),
@@ -1153,6 +1257,8 @@

 	if (host->mode == MMC_MODE_SD)
 		mmc_read_scrs(host);
+	else
+		mmc_read_ext_csds(host);
 }


diff -urN /usr/src/linux-2.6.18/include/linux/mmc/card.h linux-2.6.18-mmc4/include/linux/mmc/card.h
--- /usr/src/linux-2.6.18/include/linux/mmc/card.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18-mmc4/include/linux/mmc/card.h	2006-10-03 22:13:58.000000000 -0700
@@ -39,6 +39,10 @@
 				write_misalign:1;
 };

+struct mmc_ext_csd {
+	unsigned char		card_type;
+};
+
 struct sd_scr {
 	unsigned char		sda_vsn;
 	unsigned char		bus_widths;
@@ -62,11 +66,13 @@
 #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
 #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
 #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
+#define MMC_STATE_HIGHSPEED	(1<<5)		/* card is in mmc4 highspeed mode */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
+	struct mmc_ext_csd	ext_csd;	/* mmc v4 extended card specific */
 	struct sd_scr		scr;		/* extra SD information */
 };

@@ -75,12 +81,14 @@
 #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
 #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
+#define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)

 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
 #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
 #define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
+#define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)

 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)
diff -urN /usr/src/linux-2.6.18/include/linux/mmc/protocol.h linux-2.6.18-mmc4/include/linux/mmc/protocol.h
--- /usr/src/linux-2.6.18/include/linux/mmc/protocol.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18-mmc4/include/linux/mmc/protocol.h	2006-10-03 22:14:08.000000000 -0700
@@ -25,14 +25,16 @@
 #ifndef MMC_MMC_PROTOCOL_H
 #define MMC_MMC_PROTOCOL_H

-/* Standard MMC commands (3.1)           type  argument     response */
+/* Standard MMC commands (4.1)           type  argument     response */
    /* class 1 */
 #define	MMC_GO_IDLE_STATE         0   /* bc                          */
 #define MMC_SEND_OP_COND          1   /* bcr  [31:0] OCR         R3  */
 #define MMC_ALL_SEND_CID          2   /* bcr                     R2  */
 #define MMC_SET_RELATIVE_ADDR     3   /* ac   [31:16] RCA        R1  */
 #define MMC_SET_DSR               4   /* bc   [31:16] RCA            */
+#define MMC_SWITCH                6   /* ac   [31:0] Complex     R1b */
 #define MMC_SELECT_CARD           7   /* ac   [31:16] RCA        R1  */
+#define MMC_SEND_EXT_CSD          8   /* adtc                    R1  */
 #define MMC_SEND_CSD              9   /* ac   [31:16] RCA        R2  */
 #define MMC_SEND_CID             10   /* ac   [31:16] RCA        R2  */
 #define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  */
@@ -229,13 +231,21 @@

 #define CSD_STRUCT_VER_1_0  0           /* Valid for system specification 1.0 - 1.2 */
 #define CSD_STRUCT_VER_1_1  1           /* Valid for system specification 1.4 - 2.2 */
-#define CSD_STRUCT_VER_1_2  2           /* Valid for system specification 3.1       */
+#define CSD_STRUCT_VER_1_2  2           /* Valid for system specification 3.1 - 3.2 - 3.31 - 4.0 - 4.1 */
+#define CSD_STRUCT_EXT_CSD  3           /* Version is coded in CSD_STRUCTURE in EXT_CSD */

 #define CSD_SPEC_VER_0      0           /* Implements system specification 1.0 - 1.2 */
 #define CSD_SPEC_VER_1      1           /* Implements system specification 1.4 */
 #define CSD_SPEC_VER_2      2           /* Implements system specification 2.0 - 2.2 */
-#define CSD_SPEC_VER_3      3           /* Implements system specification 3.1 */
+#define CSD_SPEC_VER_3      3           /* Implements system specification 3.1 - 3.2 - 3.31 */
+#define CSD_SPEC_VER_4      4           /* Implements system specification 4.0 - 4.1 */

+/*
+ * EXT_CSD field definitions
+ */
+
+#define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
+#define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */

 /*
  * SD bus widths


