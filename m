Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVCFBo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVCFBo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVCFBoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:44:55 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:35748 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261276AbVCFBoQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:44:16 -0500
Message-ID: <422A606C.6050701@drzeus.cx>
Date: Sun, 06 Mar 2005 02:44:12 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-27666-1110073539-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC][2/6] Secure Digital (SD) support : init
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <422A5E1C.2050107@drzeus.cx>
In-Reply-To: <422A5E1C.2050107@drzeus.cx>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-27666-1110073539-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

SD card initialisation.

This patch contains the central parts of the SD support.

The system first tries to detect MMC cards, and if none are found then 
it procedes to look for an SD card. This is incorrect acording to SD 
specifications but I find it odd that MMC is supposed to cope with SD 
commands and not the other way around (since MMC is the older of the 
two). This behaviour is the one Windows uses and has posed no problems 
with any cards tested so far.

It provides flags for the card and host to mark them as SD. The host 
needs to be marked because the MMC layer needs to determine if it should 
send MMC or SD commands at points where no specific card is involved.

A new helper function called mmc_wait_for_app_cmd() is added to handle 
the APP commands which are used frequently with SD.

CID and CSD parsing are extended to handle SD formats.


--=_hades.drzeus.cx-27666-1110073539-0001-2
Content-Type: text/x-patch; name="mmc-sd-init.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sd-init.patch"

Index: linux-sd/include/linux/mmc/card.h
===================================================================
--- linux-sd/include/linux/mmc/card.h	(revision 135)
+++ linux-sd/include/linux/mmc/card.h	(working copy)
@@ -47,6 +47,7 @@
 #define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
 #define MMC_STATE_DEAD		(1<<1)		/* device no longer in stack */
 #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
+#define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	struct mmc_cid		cid;		/* card identification */
@@ -56,10 +57,12 @@
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_dead(c)	((c)->state & MMC_STATE_DEAD)
 #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
+#define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
 #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
+#define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
 
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)
Index: linux-sd/include/linux/mmc/mmc.h
===================================================================
--- linux-sd/include/linux/mmc/mmc.h	(revision 136)
+++ linux-sd/include/linux/mmc/mmc.h	(working copy)
@@ -88,6 +88,8 @@
 
 extern int mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
+extern int mmc_wait_for_app_cmd(struct mmc_host *, unsigned int,
+	struct mmc_command *, int);
 
 extern int __mmc_claim_host(struct mmc_host *host, struct mmc_card *card);
 
Index: linux-sd/include/linux/mmc/host.h
===================================================================
--- linux-sd/include/linux/mmc/host.h	(revision 135)
+++ linux-sd/include/linux/mmc/host.h	(working copy)
@@ -79,6 +79,10 @@
 	/* private data */
 	struct mmc_ios		ios;		/* current io bus settings */
 	u32			ocr;		/* the current OCR setting */
+	
+	unsigned int		mode;		/* current card mode of host */
+#define MMC_MODE_MMC		0
+#define MMC_MODE_SD		1
 
 	struct list_head	cards;		/* devices attached to this host */
 
Index: linux-sd/drivers/mmc/mmc.c
===================================================================
--- linux-sd/drivers/mmc/mmc.c	(revision 135)
+++ linux-sd/drivers/mmc/mmc.c	(working copy)
@@ -172,8 +172,80 @@
 
 EXPORT_SYMBOL(mmc_wait_for_cmd);
 
+/**
+ *	mmc_wait_for_app_cmd - start an application command and wait for
+ 			       completion
+ *	@host: MMC host to start command
+ *	@rca: RCA to send MMC_APP_CMD to
+ *	@cmd: MMC command to start
+ *	@retries: maximum number of retries
+ *
+ *	Sends a MMC_APP_CMD, checks the card response, sends the command
+ *	in the parameter and waits for it to complete. Return any error
+ *	that occurred while the command was executing.  Do not attempt to
+ *	parse the response.
+ */
+int mmc_wait_for_app_cmd(struct mmc_host *host, unsigned int rca,
+	struct mmc_command *cmd, int retries)
+{
+	struct mmc_request mrq;
+	struct mmc_command appcmd;
+	
+	int i, err;
 
+	BUG_ON(host->card_busy == NULL);
+	BUG_ON(retries < 0);
+	
+	err = MMC_ERR_INVALID;
+	
+	/*
+	 * We have to resend MMC_APP_CMD for each attempt so
+	 * we cannot use the retries field in mmc_command.
+	 */
+	for (i = 0;i <= retries;i++) {
+		memset(&mrq, 0, sizeof(struct mmc_request));
 
+		appcmd.opcode = MMC_APP_CMD;
+		appcmd.arg = rca << 16;
+		appcmd.flags = MMC_RSP_R1;
+		appcmd.retries = 0;
+		memset(appcmd.resp, 0, sizeof(appcmd.resp));
+		appcmd.data = NULL;
+		
+		mrq.cmd = &appcmd;
+		appcmd.data = NULL;
+		
+		mmc_wait_for_req(host, &mrq);
+		
+		if (appcmd.error) {
+			err = appcmd.error;
+			continue;
+		}
+		
+		/* Check that card supported application commands */
+		if (!(appcmd.resp[0] & R1_APP_CMD))
+			return MMC_ERR_FAILED;
+
+		memset(&mrq, 0, sizeof(struct mmc_request));
+
+		memset(cmd->resp, 0, sizeof(cmd->resp));
+		cmd->retries = 0;
+
+		mrq.cmd = cmd;
+		cmd->data = NULL;
+
+		mmc_wait_for_req(host, &mrq);
+		
+		err = cmd->error;
+		if (cmd->error == MMC_ERR_NONE)
+			break;
+	}
+
+	return err;
+}
+
+EXPORT_SYMBOL(mmc_wait_for_app_cmd);
+
 /**
  *	__mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
@@ -322,48 +394,70 @@
 
 	memset(&card->cid, 0, sizeof(struct mmc_cid));
 
-	/*
-	 * The selection of the format here is guesswork based upon
-	 * information people have sent to date.
-	 */
-	switch (card->csd.mmca_vsn) {
-	case 0: /* MMC v1.? */
-	case 1: /* MMC v1.4 */
-		card->cid.manfid	= UNSTUFF_BITS(resp, 104, 24);
-		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
-		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
-		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
-		card->cid.prod_name[3]	= UNSTUFF_BITS(resp, 72, 8);
-		card->cid.prod_name[4]	= UNSTUFF_BITS(resp, 64, 8);
-		card->cid.prod_name[5]	= UNSTUFF_BITS(resp, 56, 8);
-		card->cid.prod_name[6]	= UNSTUFF_BITS(resp, 48, 8);
-		card->cid.hwrev		= UNSTUFF_BITS(resp, 44, 4);
-		card->cid.fwrev		= UNSTUFF_BITS(resp, 40, 4);
-		card->cid.serial	= UNSTUFF_BITS(resp, 16, 24);
-		card->cid.month		= UNSTUFF_BITS(resp, 12, 4);
-		card->cid.year		= UNSTUFF_BITS(resp, 8, 4) + 1997;
-		break;
+	if (mmc_card_sd(card)) {
+		/*
+		 * SD doesn't currently have a version field so we will
+		 * have to assume we can parse this.
+		 */
+		card->cid.manfid		= UNSTUFF_BITS(resp, 120, 8);
+		card->cid.oemid			= UNSTUFF_BITS(resp, 104, 16);
+		card->cid.prod_name[0]		= UNSTUFF_BITS(resp, 96, 8);
+		card->cid.prod_name[1]		= UNSTUFF_BITS(resp, 88, 8);
+		card->cid.prod_name[2]		= UNSTUFF_BITS(resp, 80, 8);
+		card->cid.prod_name[3]		= UNSTUFF_BITS(resp, 72, 8);
+		card->cid.prod_name[4]		= UNSTUFF_BITS(resp, 64, 8);
+		card->cid.hwrev			= UNSTUFF_BITS(resp, 60, 4);
+		card->cid.fwrev			= UNSTUFF_BITS(resp, 56, 4);
+		card->cid.serial		= UNSTUFF_BITS(resp, 24, 32);
+		card->cid.year			= UNSTUFF_BITS(resp, 12, 8);
+		card->cid.month			= UNSTUFF_BITS(resp, 8, 4);
 
-	case 2: /* MMC v2.x ? */
-	case 3: /* MMC v3.x ? */
-		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
-		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
-		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
-		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
-		card->cid.prod_name[3]	= UNSTUFF_BITS(resp, 72, 8);
-		card->cid.prod_name[4]	= UNSTUFF_BITS(resp, 64, 8);
-		card->cid.prod_name[5]	= UNSTUFF_BITS(resp, 56, 8);
-		card->cid.serial	= UNSTUFF_BITS(resp, 16, 32);
-		card->cid.month		= UNSTUFF_BITS(resp, 12, 4);
-		card->cid.year		= UNSTUFF_BITS(resp, 8, 4) + 1997;
-		break;
+		card->cid.year += 2000; /* SD cards year offset */
+	}
+	else {
+		/*
+		 * The selection of the format here is based upon published
+		 * specs from sandisk and from what people have reported.
+		 */
+		switch (card->csd.mmca_vsn) {
+		case 0: /* MMC v1.0 - v1.2 */
+		case 1: /* MMC v1.4 */
+			card->cid.manfid	= UNSTUFF_BITS(resp, 104, 24);
+			card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
+			card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
+			card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
+			card->cid.prod_name[3]	= UNSTUFF_BITS(resp, 72, 8);
+			card->cid.prod_name[4]	= UNSTUFF_BITS(resp, 64, 8);
+			card->cid.prod_name[5]	= UNSTUFF_BITS(resp, 56, 8);
+			card->cid.prod_name[6]	= UNSTUFF_BITS(resp, 48, 8);
+			card->cid.hwrev		= UNSTUFF_BITS(resp, 44, 4);
+			card->cid.fwrev		= UNSTUFF_BITS(resp, 40, 4);
+			card->cid.serial	= UNSTUFF_BITS(resp, 16, 24);
+			card->cid.month		= UNSTUFF_BITS(resp, 12, 4);
+			card->cid.year		= UNSTUFF_BITS(resp, 8, 4) + 1997;
+			break;
 
-	default:
-		printk("%s: card has unknown MMCA version %d\n",
-			card->host->host_name, card->csd.mmca_vsn);
-		mmc_card_set_bad(card);
-		break;
+		case 2: /* MMC v2.0 - v2.2 */
+		case 3: /* MMC v3.1 - v3.3 */
+			card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
+			card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
+			card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
+			card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
+			card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
+			card->cid.prod_name[3]	= UNSTUFF_BITS(resp, 72, 8);
+			card->cid.prod_name[4]	= UNSTUFF_BITS(resp, 64, 8);
+			card->cid.prod_name[5]	= UNSTUFF_BITS(resp, 56, 8);
+			card->cid.serial	= UNSTUFF_BITS(resp, 16, 32);
+			card->cid.month		= UNSTUFF_BITS(resp, 12, 4);
+			card->cid.year		= UNSTUFF_BITS(resp, 8, 4) + 1997;
+			break;
+
+		default:
+			printk("%s: card has unknown MMCA version %d\n",
+				card->host->host_name, card->csd.mmca_vsn);
+			mmc_card_set_bad(card);
+			break;
+		}
 	}
 }
 
@@ -375,35 +469,62 @@
 	struct mmc_csd *csd = &card->csd;
 	unsigned int e, m, csd_struct;
 	u32 *resp = card->raw_csd;
+	
+	if (mmc_card_sd(card)) {
+		csd_struct = UNSTUFF_BITS(resp, 126, 2);
+		if (csd_struct != 0) {
+			printk("%s: unrecognised CSD structure version %d\n",
+				card->host->host_name, csd_struct);
+			mmc_card_set_bad(card);
+			return;
+		}
+		
+		m = UNSTUFF_BITS(resp, 115, 4);
+		e = UNSTUFF_BITS(resp, 112, 3);
+		csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
+		csd->tacc_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
 
-	/*
-	 * We only understand CSD structure v1.1 and v2.
-	 * v2 has extra information in bits 15, 11 and 10.
-	 */
-	csd_struct = UNSTUFF_BITS(resp, 126, 2);
-	if (csd_struct != 1 && csd_struct != 2) {
-		printk("%s: unrecognised CSD structure version %d\n",
-			card->host->host_name, csd_struct);
-		mmc_card_set_bad(card);
-		return;
+		m = UNSTUFF_BITS(resp, 99, 4);
+		e = UNSTUFF_BITS(resp, 96, 3);
+		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
+		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+
+		e = UNSTUFF_BITS(resp, 47, 3);
+		m = UNSTUFF_BITS(resp, 62, 12);
+		csd->capacity	  = (1 + m) << (e + 2);
+
+		csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
 	}
+	else {
+		/*
+		 * We only understand CSD structure v1.1 and v1.2.
+		 * v1.2 has extra information in bits 15, 11 and 10.
+		 */
+		csd_struct = UNSTUFF_BITS(resp, 126, 2);
+		if (csd_struct != 1 && csd_struct != 2) {
+			printk("%s: unrecognised CSD structure version %d\n",
+				card->host->host_name, csd_struct);
+			mmc_card_set_bad(card);
+			return;
+		}
 
-	csd->mmca_vsn	 = UNSTUFF_BITS(resp, 122, 4);
-	m = UNSTUFF_BITS(resp, 115, 4);
-	e = UNSTUFF_BITS(resp, 112, 3);
-	csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
-	csd->tacc_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
+		csd->mmca_vsn	 = UNSTUFF_BITS(resp, 122, 4);
+		m = UNSTUFF_BITS(resp, 115, 4);
+		e = UNSTUFF_BITS(resp, 112, 3);
+		csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
+		csd->tacc_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
 
-	m = UNSTUFF_BITS(resp, 99, 4);
-	e = UNSTUFF_BITS(resp, 96, 3);
-	csd->max_dtr	  = tran_exp[e] * tran_mant[m];
-	csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+		m = UNSTUFF_BITS(resp, 99, 4);
+		e = UNSTUFF_BITS(resp, 96, 3);
+		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
+		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
 
-	e = UNSTUFF_BITS(resp, 47, 3);
-	m = UNSTUFF_BITS(resp, 62, 12);
-	csd->capacity	  = (1 + m) << (e + 2);
+		e = UNSTUFF_BITS(resp, 47, 3);
+		m = UNSTUFF_BITS(resp, 62, 12);
+		csd->capacity	  = (1 + m) << (e + 2);
 
-	csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
+		csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
+	}
 }
 
 /*
@@ -524,6 +645,34 @@
 	return err;
 }
 
+static int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
+{
+	struct mmc_command cmd;
+	int i, err = 0;
+
+	cmd.opcode = SD_APP_OP_COND;
+	cmd.arg = ocr;
+	cmd.flags = MMC_RSP_R3;
+
+	for (i = 100; i; i--) {
+		err = mmc_wait_for_app_cmd(host, 0, &cmd, CMD_RETRIES);
+		if (err != MMC_ERR_NONE)
+			break;
+
+		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
+			break;
+
+		err = MMC_ERR_TIMEOUT;
+
+		mmc_delay(10);
+	}
+
+	if (rocr)
+		*rocr = cmd.resp[0];
+
+	return err;
+}
+
 /*
  * Discover cards by requesting their CID.  If this command
  * times out, it is not an error; there are no further cards
@@ -566,14 +715,29 @@
 		}
 
 		card->state &= ~MMC_STATE_DEAD;
+		
+		if (host->mode == MMC_MODE_SD) {
+			mmc_card_set_sd(card);
 
-		cmd.opcode = MMC_SET_RELATIVE_ADDR;
-		cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_R1;
+			cmd.opcode = SD_SEND_RELATIVE_ADDR;
+			cmd.arg = 0;
+			cmd.flags = MMC_RSP_R1;
 
-		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
-		if (err != MMC_ERR_NONE)
-			mmc_card_set_dead(card);
+			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+			if (err != MMC_ERR_NONE)
+				mmc_card_set_dead(card);
+			else
+				card->rca = cmd.resp[0] >> 16;
+		}
+		else {
+			cmd.opcode = MMC_SET_RELATIVE_ADDR;
+			cmd.arg = card->rca << 16;
+			cmd.flags = MMC_RSP_R1;
+
+			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+			if (err != MMC_ERR_NONE)
+				mmc_card_set_dead(card);
+		}
 	}
 }
 
@@ -656,13 +820,26 @@
 	if (host->ios.power_mode != MMC_POWER_ON) {
 		int err;
 		u32 ocr;
+		
+		host->mode = MMC_MODE_MMC;
 
 		mmc_power_up(host);
 		mmc_idle_cards(host);
 
 		err = mmc_send_op_cond(host, 0, &ocr);
+		
+		/*
+		 * If we fail to detect any cards then try
+		 * searching for SD cards.
+		 */
 		if (err != MMC_ERR_NONE)
-			return;
+		{
+			err = mmc_send_app_op_cond(host, 0, &ocr);
+			if (err != MMC_ERR_NONE)
+				return;
+			
+			host->mode = MMC_MODE_SD;
+		}
 
 		host->ocr = mmc_select_voltage(host, ocr);
 
@@ -702,7 +879,10 @@
 	 * all get the idea that they should be ready for CMD2.
 	 * (My SanDisk card seems to need this.)
 	 */
-	mmc_send_op_cond(host, host->ocr, NULL);
+	if (host->mode == MMC_MODE_SD)
+		mmc_send_app_op_cond(host, host->ocr, NULL);
+	else
+		mmc_send_op_cond(host, host->ocr, NULL);
 
 	mmc_discover_cards(host);
 

--=_hades.drzeus.cx-27666-1110073539-0001-2--
