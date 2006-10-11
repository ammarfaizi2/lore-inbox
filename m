Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWJKFja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWJKFja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWJKFj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:39:29 -0400
Received: from usul.saidi.cx ([204.11.33.34]:55687 "EHLO usul.overt.org")
	by vger.kernel.org with ESMTP id S932441AbWJKFj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:39:28 -0400
Message-ID: <11208.67.169.45.37.1160545100.squirrel@overt.org>
In-Reply-To: <452B3B00.5080209@drzeus.cx>
References: <21173.67.169.45.37.1159940502.squirrel@overt.org>
    <452B3B00.5080209@drzeus.cx>
Date: Wed, 11 Oct 2006 01:38:20 -0400 (EDT)
Subject: Re: [PATCH 2.6.18 1/1] mmc: Add support for mmc v4 high speed mode
From: philipl@overt.org
To: "Pierre Ossman" <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.8
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Importance: Normal
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.53
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pierre Ossman wrote:
>> +	 	cmd.arg = 0x03B90100;
>>
>
> I'd prefer some defines and shifts here. Also, this should be done at
> init, not at select. The reason SD does it is that the spec says it
> drops out of wide mode when it gets unselected.

I have done this, but your suggestion somewhat contradicts your original
suggestion to remove the defines. Essentially, my updated change restores
the relevant definitions from my very first diff. I hope this is what you
wanted. I prefer to have the #defines, so I'm not complaining.

I also moved the explaination of the MMC_SWITCH argument to protocol.h I
think it's worth documenting somewhere.

I have moved this work into the read_ext_csd function and renamed it
process_ext_csd.

> A "max_dtr" int the mmc_ext_csd structure would be nicer here. And you
> cannot do a kernel BUG because the card is broken. You should mark it as
> dead.

I have replaced storing the CARD_TYPE value with storing a dtr based on
the CARD_TYPE which should achieve what you wanted. I've replaced the
BUG with marking the card as bad.

Finally, as pointed out by Jarkko, I added the missing MMC_CMD flags to
the calls to MMC_SWITCH and MMC_SEND_EXT_CSD;

Thanks,

--phil

Signed-off-by: Philip Langdale <philipl@overt.org>
---

 drivers/mmc/mmc.c            |  114 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h     |    8 +++
 include/linux/mmc/protocol.h |   47 ++++++++++++++++-
 3 files changed, 164 insertions(+), 5 deletions(-)

diff -urN /usr/src/linux-2.6.18/drivers/mmc/mmc.c linux-2.6.18-mmc4/drivers/mmc/mmc.c
--- /usr/src/linux-2.6.18/drivers/mmc/mmc.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18-mmc4/drivers/mmc/mmc.c	2006-10-10 22:31:15.000000000 -0700
@@ -4,6 +4,7 @@
  *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
  *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
  *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
+ *  MMCv4 support Copyright (C) 2006 Philip Langdale, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -953,6 +954,107 @@
 	}
 }

+static void mmc_process_ext_csds(struct mmc_host *host)
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
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
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
+		switch (ext_csd[EXT_CSD_CARD_TYPE]) {
+		case EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+			card->ext_csd.hs_max_dtr = 52000000;
+			break;
+		case EXT_CSD_CARD_TYPE_26:
+			card->ext_csd.hs_max_dtr = 26000000;
+			break;
+		default:
+			/* MMC v4 spec says this cannot happen */
+			printk("%s: card is mmc v4 but doesn't support "
+			       "any high-speed modes.\n",
+				mmc_hostname(card->host));
+			mmc_card_set_bad(card);
+			/* printk a warning */
+			continue;
+		}
+
+		/* Activate highspeed support. */
+		cmd.opcode = MMC_SWITCH;
+		cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			  (EXT_CSD_HS_TIMING << 16) |
+			  (1 << 8) |
+			  EXT_CSD_CMD_SET_NORMAL;
+		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
+		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+		if (err != MMC_ERR_NONE) {
+			printk("%s: failed to switch card to mmc v4 "
+			       "high-speed mode.\n",
+			       mmc_hostname(card->host));
+			continue;
+		}
+
+		mmc_card_set_highspeed(card);
+	}
+
+	mmc_deselect_cards(host);
+}
+
 static void mmc_read_scrs(struct mmc_host *host)
 {
 	int err;
@@ -1032,8 +1134,14 @@
 	unsigned int max_dtr = host->f_max;

 	list_for_each_entry(card, &host->cards, node)
-		if (!mmc_card_dead(card) && max_dtr > card->csd.max_dtr)
-			max_dtr = card->csd.max_dtr;
+		if (!mmc_card_dead(card)) {
+			if (mmc_card_highspeed(card)) {
+				if (max_dtr > card->ext_csd.hs_max_dtr)
+			    		max_dtr = card->ext_csd.hs_max_dtr;
+			} else if (max_dtr > card->csd.max_dtr) {
+				max_dtr = card->csd.max_dtr;
+			}
+		}

 	pr_debug("%s: selected %d.%03dMHz transfer rate\n",
 		 mmc_hostname(host),
@@ -1153,6 +1261,8 @@

 	if (host->mode == MMC_MODE_SD)
 		mmc_read_scrs(host);
+	else
+		mmc_process_ext_csds(host);
 }


diff -urN /usr/src/linux-2.6.18/include/linux/mmc/card.h linux-2.6.18-mmc4/include/linux/mmc/card.h
--- /usr/src/linux-2.6.18/include/linux/mmc/card.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18-mmc4/include/linux/mmc/card.h	2006-10-10 21:47:52.000000000 -0700
@@ -39,6 +39,10 @@
 				write_misalign:1;
 };

+struct mmc_ext_csd {
+	unsigned int		hs_max_dtr;
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
+++ linux-2.6.18-mmc4/include/linux/mmc/protocol.h	2006-10-10 21:48:52.000000000 -0700
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
+#define MMC_SWITCH                6   /* ac   [31:0] See below   R1b */
 #define MMC_SELECT_CARD           7   /* ac   [31:16] RCA        R1  */
+#define MMC_SEND_EXT_CSD          8   /* adtc                    R1  */
 #define MMC_SEND_CSD              9   /* ac   [31:16] RCA        R2  */
 #define MMC_SEND_CID             10   /* ac   [31:16] RCA        R2  */
 #define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  */
@@ -87,6 +89,17 @@
 #define SD_APP_SEND_SCR          51   /* adtc                    R1  */

 /*
+ * MMC_SWITCH argument format:
+ *
+ *	[31:26] Always 0
+ *	[25:24] Access Mode
+ *	[23:16] Location of target Byte in EXT_CSD
+ *	[15:08] Value Byte
+ *	[07:03] Always 0
+ *	[02:00] Command Set
+ */
+
+/*
   MMC status in R1
   Type
   	e : error bit
@@ -229,13 +242,41 @@

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
+
+/*
+ * EXT_CSD fields
+ */
+
+#define EXT_CSD_HS_TIMING	185	/* R/W */
+#define EXT_CSD_CARD_TYPE	196	/* RO */
+
+/*
+ * EXT_CSD field definitions
+ */
+
+#define EXT_CSD_CMD_SET_NORMAL		(1<<0)
+#define EXT_CSD_CMD_SET_SECURE		(1<<1)
+#define EXT_CSD_CMD_SET_CPSECURE	(1<<2)
+
+#define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
+#define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */
+
+/*
+ * MMC_SWITCH access modes
+ */

+#define MMC_SWITCH_MODE_CMD_SET		0x00	/* Change the command set */
+#define MMC_SWITCH_MODE_SET_BITS	0x01	/* Set bits which are 1 in value */
+#define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
+#define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */

 /*
  * SD bus widths


