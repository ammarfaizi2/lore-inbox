Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVCFBvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVCFBvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVCFBvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:51:16 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:43172 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261277AbVCFBud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:50:33 -0500
Message-ID: <422A61C9.2020906@drzeus.cx>
Date: Sun, 06 Mar 2005 02:50:01 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-27756-1110073916-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC][4/6] Secure Digital (SD) support : SCR
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <422A5E1C.2050107@drzeus.cx>
In-Reply-To: <422A5E1C.2050107@drzeus.cx>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-27756-1110073916-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

SCR download.

This patch downloads the SCR register from the card. Unlike the other 
registers this one is transfered over the data bus. That required some 
changes to other routines to allow a card to be selected after the host 
was aquired.

This is one of the more error prone parts. The transfer is very small (8 
bytes) and might trigger corner cases in the drivers.


--=_hades.drzeus.cx-27756-1110073916-0001-2
Content-Type: text/x-patch; name="mmc-sd-scr.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sd-scr.patch"

Index: linux-sd/include/linux/mmc/card.h
===================================================================
--- linux-sd/include/linux/mmc/card.h	(revision 138)
+++ linux-sd/include/linux/mmc/card.h	(working copy)
@@ -33,6 +33,13 @@
 	unsigned int		capacity;
 };
 
+struct sd_scr {
+	unsigned char		sda_vsn;
+	unsigned char		bus_widths;
+#define SD_SCR_BUS_WIDTH_1	(1<<0)
+#define SD_SCR_BUS_WIDTH_4	(1<<2)
+};
+
 struct mmc_host;
 
 /*
@@ -51,8 +58,10 @@
 #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
+	u32			raw_scr[2];	/* raw card SCR */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
+	struct sd_scr		scr;		/* extra SD information */
 };
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
Index: linux-sd/drivers/mmc/mmc.c
===================================================================
--- linux-sd/drivers/mmc/mmc.c	(revision 138)
+++ linux-sd/drivers/mmc/mmc.c	(working copy)
@@ -16,6 +16,8 @@
 #include <linux/delay.h>
 #include <linux/pagemap.h>
 #include <linux/err.h>
+#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -246,6 +248,8 @@
 
 EXPORT_SYMBOL(mmc_wait_for_app_cmd);
 
+static int mmc_select_card(struct mmc_host *host, struct mmc_card *card);
+
 /**
  *	__mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
@@ -278,16 +282,10 @@
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
 
-	if (card != (void *)-1 && host->card_selected != card) {
-		struct mmc_command cmd;
-
-		host->card_selected = card;
-
-		cmd.opcode = MMC_SELECT_CARD;
-		cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_R1;
-
-		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+	if (card != (void *)-1) {
+		err = mmc_select_card(host, card);
+		if (err != MMC_ERR_NONE)
+			return err;
 	}
 
 	return err;
@@ -317,6 +315,29 @@
 
 EXPORT_SYMBOL(mmc_release_host);
 
+static int mmc_select_card(struct mmc_host *host, struct mmc_card *card)
+{
+	int err;
+	struct mmc_command cmd;
+
+	BUG_ON(host->card_busy == NULL);
+	
+	if (host->card_selected == card)
+		return MMC_ERR_NONE;
+
+	host->card_selected = card;
+
+	cmd.opcode = MMC_SELECT_CARD;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1;
+
+	err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+	if (err != MMC_ERR_NONE)
+		return err;
+
+	return MMC_ERR_NONE;
+}
+
 /*
  * Ensure that no card is selected.
  */
@@ -528,6 +549,32 @@
 }
 
 /*
+ * Given a 64-bit response, decode to our card SCR structure.
+ */
+static void mmc_decode_scr(struct mmc_card *card)
+{
+	struct sd_scr *scr = &card->scr;
+	unsigned int scr_struct;
+	u32 resp[4];
+
+	BUG_ON(!mmc_card_sd(card));
+	
+	resp[3] = card->raw_scr[1];
+	resp[2] = card->raw_scr[0];
+	
+	scr_struct = UNSTUFF_BITS(resp, 60, 4);
+	if (scr_struct != 0) {
+		printk("%s: unrecognised SCR structure version %d\n",
+			card->host->host_name, scr_struct);
+		mmc_card_set_bad(card);
+		return;
+	}
+	
+	scr->sda_vsn = UNSTUFF_BITS(resp, 56, 4);
+	scr->bus_widths = UNSTUFF_BITS(resp, 48, 4);
+}
+
+/*
  * Locate a MMC card on this MMC host given a raw CID.
  */
 static struct mmc_card *mmc_find_card(struct mmc_host *host, u32 *raw_cid)
@@ -781,6 +828,80 @@
 	}
 }
 
+static void mmc_read_scrs(struct mmc_host *host)
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
+	list_for_each_entry(card, &host->cards, node) {
+		if (card->state & (MMC_STATE_DEAD|MMC_STATE_PRESENT))
+			continue;
+		if (!mmc_card_sd(card))
+			continue;
+		
+		err = mmc_select_card(host, card);
+		if (err != MMC_ERR_NONE)
+		{
+			mmc_card_set_dead(card);
+			continue;
+		}
+		
+		memset(&cmd, 0, sizeof(struct mmc_command));
+		
+		cmd.opcode = MMC_APP_CMD;
+		cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_R1;
+		
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if ((err != MMC_ERR_NONE) || !(cmd.resp[0] & R1_APP_CMD)) {
+			mmc_card_set_dead(card);
+			continue;
+		}
+		
+		memset(&cmd, 0, sizeof(struct mmc_command));
+		
+		cmd.opcode = SD_APP_SEND_SCR;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1;
+		
+		memset(&data, 0, sizeof(struct mmc_data));
+		
+		data.timeout_ns = card->csd.tacc_ns * 10;
+		data.timeout_clks = card->csd.tacc_clks * 10;
+		data.blksz_bits = 3;
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
+		sg_init_one(&sg, (u8*)card->raw_scr, 64);
+		
+		err = mmc_wait_for_req(host, &mrq);
+		if (err != MMC_ERR_NONE) {
+			mmc_card_set_dead(card);
+			continue;
+		}
+		
+		card->raw_scr[0] = ntohl(card->raw_scr[0]);
+		card->raw_scr[1] = ntohl(card->raw_scr[1]);
+
+		mmc_decode_scr(card);
+	}
+	
+	mmc_deselect_cards(host);
+}
+
 static unsigned int mmc_calculate_clock(struct mmc_host *host)
 {
 	struct mmc_card *card;
@@ -905,6 +1026,9 @@
 	host->ops->set_ios(host, &host->ios);
 
 	mmc_read_csds(host);
+	
+	if (host->mode == MMC_MODE_SD)
+		mmc_read_scrs(host);
 }
 
 

--=_hades.drzeus.cx-27756-1110073916-0001-2--
