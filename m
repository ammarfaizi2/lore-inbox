Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVCCMlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVCCMlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVCCMkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:40:35 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:3559 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261776AbVCCMXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:23:07 -0500
Message-ID: <422701A0.8030408@drzeus.cx>
Date: Thu, 03 Mar 2005 13:22:56 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-12869-1109852667-0001-2"
To: LKML <linux-kernel@vger.kernel.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH][MMC] Secure Digital (SD) support
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-12869-1109852667-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here are the patches for Secure Digital support that I've been sitting 
on for a while. I tried to get some feedback on inclusion of this 
previously but since I didn't get any I'll just submit the thing.
It was originally diffed against 2.6.10 but it applies to 2.6.11 just 
fine (only minor fuzz).

Change summary:

* Detects if connected card is SD or MMC. Marks host as in SD mode if SD 
is detected (since SD isn't a bus system).
* Reads extra registers from SD cards (SCR) and parses CSD differently 
depending on SD/MMC mode.
* Support for 4-bit mode. This has been design to be fairly isolated 
from the SD bit so that it can (hopefully) be reused with MMC.
* New callback added for reading the read-only switch on SD cards.

Changed files:

mmc.c : SD detection and register parsing.
mmc_block.c : Checks read-only flag for cards (not SD-specific).
mmc_sysfs.c : Exposes SCR register.
card.h : Added flags to determine card type, RO and new register.
host.h : Added flags for bus width, RO test and mode (SD/MMC).
mmc.h : Added R6 define and new defines.
protocol.h : Added needed SD commands.

This patch is backwards compatible and only needs updated drivers to 
take advantage of 4-bit bus and reading the RO switch (unmodified 
drivers will default to 1-bit bus and write enable).

There might be new bugs that surface with this though. With my own 
drivers I discovered that very small transfers (< 16 bytes) always 
failed. Testing is needed but I do not have access to do it myself. MMC 
should not break with this since MMC is detected before SD.

Rgds
Pierre

--=_hades.drzeus.cx-12869-1109852667-0001-2
Content-Type: text/x-patch; name="mmc-sd-2.6.10.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sd-2.6.10.patch"

diff -uNp linux/include/linux/mmc/card.h linux-wbsd/include/linux/mmc/card.h
--- linux/include/linux/mmc/card.h	2004-10-18 23:54:55.000000000 +0200
+++ linux-wbsd/include/linux/mmc/card.h	2004-12-25 23:42:13.974522806 +0100
@@ -33,6 +33,13 @@ struct mmc_csd {
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
@@ -47,19 +54,27 @@ struct mmc_card {
 #define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
 #define MMC_STATE_DEAD		(1<<1)		/* device no longer in stack */
 #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
+#define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
+#define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
+	u32			raw_scr[2];	/* raw card SCR */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
+	struct sd_scr		scr;		/* extra SD information */
 };
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_dead(c)	((c)->state & MMC_STATE_DEAD)
 #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
+#define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
+#define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
 #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
+#define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
+#define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)
diff -uNp linux/include/linux/mmc/host.h linux-wbsd/include/linux/mmc/host.h
--- linux/include/linux/mmc/host.h	2004-10-18 23:54:32.000000000 +0200
+++ linux-wbsd/include/linux/mmc/host.h	2004-12-25 22:36:16.260639695 +0100
@@ -51,11 +51,17 @@ struct mmc_ios {
 #define MMC_POWER_OFF		0
 #define MMC_POWER_UP		1
 #define MMC_POWER_ON		2
+
+	unsigned char	bus_width;		/* data bus width */
+
+#define MMC_BUS_WIDTH_1		0
+#define MMC_BUS_WIDTH_4		2
 };
 
 struct mmc_host_ops {
 	void	(*request)(struct mmc_host *host, struct mmc_request *req);
 	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
+	int	(*get_ro)(struct mmc_host *host);
 };
 
 struct mmc_card;
@@ -68,6 +74,10 @@ struct mmc_host {
 	unsigned int		f_max;
 	u32			ocr_avail;
 	char			host_name[8];
+	
+	unsigned long		caps;		/* Host capabilities */
+	
+#define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
@@ -79,6 +89,10 @@ struct mmc_host {
 	/* private data */
 	struct mmc_ios		ios;		/* current io bus settings */
 	u32			ocr;		/* the current OCR setting */
+	
+	unsigned int		mode;		/* current card mode of host */
+#define MMC_MODE_MMC		0
+#define MMC_MODE_SD		1
 
 	struct list_head	cards;		/* devices attached to this host */
 
diff -uNp linux/include/linux/mmc/mmc.h linux-wbsd/include/linux/mmc/mmc.h
--- linux/include/linux/mmc/mmc.h	2004-12-26 00:17:12.338128877 +0100
+++ linux-wbsd/include/linux/mmc/mmc.h	2005-01-01 23:11:51.478637901 +0100
@@ -37,6 +37,7 @@ struct mmc_command {
 #define MMC_RSP_R1B	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_BUSY)
 #define MMC_RSP_R2	(MMC_RSP_LONG|MMC_RSP_CRC)
 #define MMC_RSP_R3	(MMC_RSP_SHORT)
+#define MMC_RSP_R6	(MMC_RSP_SHORT|MMC_RSP_CRC)
 
 	unsigned int		retries;	/* max number of retries */
 	unsigned int		error;		/* command error */
@@ -88,6 +89,8 @@ struct mmc_card;
 
 extern int mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
+extern int mmc_wait_for_app_cmd(struct mmc_host *, unsigned int,
+	struct mmc_command *, int);
 
 extern int __mmc_claim_host(struct mmc_host *host, struct mmc_card *card);
 
diff -uNp linux/include/linux/mmc/protocol.h linux-wbsd/include/linux/mmc/protocol.h
--- linux/include/linux/mmc/protocol.h	2004-10-18 23:55:36.000000000 +0200
+++ linux-wbsd/include/linux/mmc/protocol.h	2004-12-24 02:43:55.880637702 +0100
@@ -76,6 +76,16 @@
 #define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
 #define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1b */
 
+/* SD commands                           type  argument     response */
+  /* class 8 */
+/* This is basically the same command as for MMC with some quirks. */
+#define SD_SEND_RELATIVE_ADDR     3   /* ac                      R6  */
+
+  /* Application commands */
+#define SD_APP_SET_BUS_WIDTH      6   /* ac   [1:0] bus width    R1  */
+#define SD_APP_OP_COND           41   /* bcr  [31:0] OCR         R3  */
+#define SD_APP_SEND_SCR          51   /* adtc                    R1  */
+
 /*
   MMC status in R1
   Type
@@ -113,7 +123,7 @@
 #define R1_STATUS(x)            (x & 0xFFFFE000)
 #define R1_CURRENT_STATE(x)    	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
-#define R1_APP_CMD		(1 << 7)	/* sr, c */
+#define R1_APP_CMD		(1 << 5)	/* sr, c */
 
 /* These are unpacked versions of the actual responses */
 
@@ -199,5 +209,12 @@ struct _mmc_csd {
 #define CSD_SPEC_VER_2      2           /* Implements system specification 2.0 - 2.2 */
 #define CSD_SPEC_VER_3      3           /* Implements system specification 3.1 */
 
+
+/*
+ * SD bus widths
+ */
+#define SD_BUS_WIDTH_1      0
+#define SD_BUS_WIDTH_4      2
+
 #endif  /* MMC_MMC_PROTOCOL_H */
 
Common subdirectories: linux/include/linux/mmc/.svn and linux-wbsd/include/linux/mmc/.svn
--- linux/drivers/mmc/mmc.c	2005-01-02 01:05:32.976696144 +0100
+++ linux-wbsd/drivers/mmc/mmc.c	2005-01-02 23:50:27.982629278 +0100
@@ -16,6 +16,8 @@
 #include <linux/delay.h>
 #include <linux/pagemap.h>
 #include <linux/err.h>
+#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -172,7 +174,81 @@ int mmc_wait_for_cmd(struct mmc_host *ho
 
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
+
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
+
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
 
+EXPORT_SYMBOL(mmc_wait_for_app_cmd);
+
+static int mmc_select_card(struct mmc_host *host, struct mmc_card *card);
 
 /**
  *	__mmc_claim_host - exclusively claim a host
@@ -206,16 +282,10 @@ int __mmc_claim_host(struct mmc_host *ho
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
@@ -245,6 +315,63 @@ void mmc_release_host(struct mmc_host *h
 
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
+	/*
+	 * Default bus width is 1 bit.
+	 */
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
+	
+	/*
+	 * We can only change the bus width of the selected
+	 * card so therefore we have to put the handling
+	 * here.
+	 */
+	if (host->caps & MMC_CAP_4_BIT_DATA) {
+		/*
+		 * The card is in 1 bit mode by default so
+		 * we only need to change if it supports the
+		 * wider version.
+		 */
+		if (mmc_card_sd(card) &&
+			(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+			struct mmc_command cmd;
+			cmd.opcode = SD_APP_SET_BUS_WIDTH;
+			cmd.arg = SD_BUS_WIDTH_4;
+			cmd.flags = MMC_RSP_R1;
+			
+			err = mmc_wait_for_app_cmd(host, card->rca, &cmd,
+				CMD_RETRIES);
+			if (err != MMC_ERR_NONE)
+				return err;
+			
+			host->ios.bus_width = MMC_BUS_WIDTH_4;
+		}
+	}
+
+	host->ops->set_ios(host, &host->ios);
+
+	return MMC_ERR_NONE;
+}
+
 /*
  * Ensure that no card is selected.
  */
@@ -321,48 +448,70 @@ static void mmc_decode_cid(struct mmc_ca
 
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
-
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
-
-	default:
-		printk("%s: card has unknown MMCA version %d\n",
-			card->host->host_name, card->csd.mmca_vsn);
-		mmc_card_set_bad(card);
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
+
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
+
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
 
@@ -374,35 +523,88 @@ static void mmc_decode_csd(struct mmc_ca
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
+
+		m = UNSTUFF_BITS(resp, 99, 4);
+		e = UNSTUFF_BITS(resp, 96, 3);
+		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
+		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+
+		e = UNSTUFF_BITS(resp, 47, 3);
+		m = UNSTUFF_BITS(resp, 62, 12);
+		csd->capacity	  = (1 + m) << (e + 2);
 
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
-
-	m = UNSTUFF_BITS(resp, 99, 4);
-	e = UNSTUFF_BITS(resp, 96, 3);
-	csd->max_dtr	  = tran_exp[e] * tran_mant[m];
-	csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
-
-	e = UNSTUFF_BITS(resp, 47, 3);
-	m = UNSTUFF_BITS(resp, 62, 12);
-	csd->capacity	  = (1 + m) << (e + 2);
+		csd->mmca_vsn	 = UNSTUFF_BITS(resp, 122, 4);
+		m = UNSTUFF_BITS(resp, 115, 4);
+		e = UNSTUFF_BITS(resp, 112, 3);
+		csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
+		csd->tacc_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
+
+		m = UNSTUFF_BITS(resp, 99, 4);
+		e = UNSTUFF_BITS(resp, 96, 3);
+		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
+		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+
+		e = UNSTUFF_BITS(resp, 47, 3);
+		m = UNSTUFF_BITS(resp, 62, 12);
+		csd->capacity	  = (1 + m) << (e + 2);
 
-	csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
+		csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
+	}
+}
+
+/*
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
 }
 
 /*
@@ -475,6 +677,7 @@ static void mmc_power_up(struct mmc_host
 	host->ios.vdd = bit;
 	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 	host->ios.power_mode = MMC_POWER_UP;
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
 	host->ops->set_ios(host, &host->ios);
 
 	mmc_delay(1);
@@ -492,6 +695,7 @@ static void mmc_power_off(struct mmc_hos
 	host->ios.vdd = 0;
 	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 	host->ios.power_mode = MMC_POWER_OFF;
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
 	host->ops->set_ios(host, &host->ios);
 }
 
@@ -523,6 +727,34 @@ static int mmc_send_op_cond(struct mmc_h
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
@@ -565,14 +797,39 @@ static void mmc_discover_cards(struct mm
 		}
 
 		card->state &= ~MMC_STATE_DEAD;
+		
+		if (host->mode == MMC_MODE_SD) {
+			mmc_card_set_sd(card);
+
+			cmd.opcode = SD_SEND_RELATIVE_ADDR;
+			cmd.arg = 0;
+			cmd.flags = MMC_RSP_R1;
 
-		cmd.opcode = MMC_SET_RELATIVE_ADDR;
-		cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_R1;
+			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+			if (err != MMC_ERR_NONE)
+				mmc_card_set_dead(card);
+			
+			card->rca = cmd.resp[0] >> 16;
+			
+			if (!host->ops->get_ro) {
+				printk(KERN_WARNING "%s: host does not support "
+					"reading read-only switch. assuming "
+					"write-enable.\n", host->host_name);
+			}
+			else {
+				if (host->ops->get_ro(host))
+					mmc_card_set_readonly(card);
+			}
+		}
+		else {
+			cmd.opcode = MMC_SET_RELATIVE_ADDR;
+			cmd.arg = card->rca << 16;
+			cmd.flags = MMC_RSP_R1;
 
-		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
-		if (err != MMC_ERR_NONE)
-			mmc_card_set_dead(card);
+			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+			if (err != MMC_ERR_NONE)
+				mmc_card_set_dead(card);
+		}
 	}
 }
 
@@ -604,6 +861,80 @@ static void mmc_read_csds(struct mmc_hos
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
@@ -655,13 +986,26 @@ static void mmc_setup(struct mmc_host *h
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
 
@@ -714,7 +1058,10 @@ static void mmc_setup(struct mmc_host *h
 	 * all get the idea that they should be ready for CMD2.
 	 * (My SanDisk card seems to need this.)
 	 */
-	mmc_send_op_cond(host, host->ocr, NULL);
+	if (host->mode == MMC_MODE_SD)
+		mmc_send_app_op_cond(host, host->ocr, NULL);
+	else
+		mmc_send_op_cond(host, host->ocr, NULL);
 
 	mmc_discover_cards(host);
 
@@ -725,6 +1072,9 @@ static void mmc_setup(struct mmc_host *h
 	host->ops->set_ios(host, &host->ios);
 
 	mmc_read_csds(host);
+	
+	if (host->mode == MMC_MODE_SD)
+		mmc_read_scrs(host);
 }
 
 
--- linux/drivers/mmc/mmc_block.c	2005-01-01 23:46:36.990024519 +0100
+++ linux-wbsd/drivers/mmc/mmc_block.c	2004-12-26 01:16:32.778971274 +0100
@@ -95,6 +95,10 @@ static int mmc_blk_open(struct inode *in
 		if (md->usage == 2)
 			check_disk_change(inode->i_bdev);
 		ret = 0;
+		
+		if ((filp->f_mode & FMODE_WRITE) &&
+			mmc_card_readonly(md->queue.card))
+			ret = -EROFS;
 	}
 
 	return ret;
@@ -387,6 +391,7 @@ static struct mmc_blk_data *mmc_blk_allo
 		md->disk->private_data = md;
 		md->disk->queue = md->queue.queue;
 		md->disk->driverfs_dev = &card->dev;
+		md->disk->flags |= GENHD_FL_REMOVABLE;
 
 		sprintf(md->disk->disk_name, "mmcblk%d", devidx);
 		sprintf(md->disk->devfs_name, "mmc/blk%d", devidx);
@@ -444,9 +449,10 @@ static int mmc_blk_probe(struct mmc_card
 	if (err)
 		goto out;
 
-	printk(KERN_INFO "%s: %s %s %dKiB\n",
+	printk(KERN_INFO "%s: %s %s %dKiB %s\n",
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
-		(card->csd.capacity << card->csd.read_blkbits) / 1024);
+		(card->csd.capacity << card->csd.read_blkbits) / 1024,
+		mmc_card_readonly(card)?"(ro)":"");
 
 	mmc_set_drvdata(card, md);
 	add_disk(md->disk);
--- linux/drivers/mmc/mmc_sysfs.c	2004-10-18 23:54:37.000000000 +0200
+++ linux-wbsd/drivers/mmc/mmc_sysfs.c	2004-12-24 02:21:29.839785413 +0100
@@ -163,6 +163,7 @@ MMC_ATTR(cid, "%08x%08x%08x%08x\n", card
 	card->raw_cid[2], card->raw_cid[3]);
 MMC_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
 	card->raw_csd[2], card->raw_csd[3]);
+MMC_ATTR(scr, "%08x%08x\n", card->raw_scr[0], card->raw_scr[1]);
 MMC_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
 MMC_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
 MMC_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
@@ -174,6 +175,7 @@ MMC_ATTR(serial, "0x%08x\n", card->cid.s
 static struct device_attribute *mmc_dev_attributes[] = {
 	&dev_attr_cid,
 	&dev_attr_csd,
+	&dev_attr_scr,
 	&dev_attr_date,
 	&dev_attr_fwrev,
 	&dev_attr_hwrev,

--=_hades.drzeus.cx-12869-1109852667-0001-2--
