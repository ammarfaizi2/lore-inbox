Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWIFFUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWIFFUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 01:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWIFFUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 01:20:51 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:56203 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932161AbWIFFUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 01:20:49 -0400
Message-ID: <44FE5AAC.6030607@drzeus.cx>
Date: Wed, 06 Sep 2006 07:20:44 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hera.drzeus.cx-17479-1157520044-0001-2"
To: madhu chikkature <crmadhu210@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SDIO card support in Linux
References: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com>	 <44F73E37.6030602@drzeus.cx> <f71aedf40609051651k5d36d4fdkb6020685fc366983@mail.gmail.com>
In-Reply-To: <f71aedf40609051651k5d36d4fdkb6020685fc366983@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-17479-1157520044-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

madhu chikkature wrote:
> Hi Pierre,
>
> Here is some piece of code that i wrote for SDIO. I use 2.6.10 kernel
> and hence i can not really take a diff between the latest kernel
> version. But this is not really a patch. So, You can just comment on
> my code. I might later on work on the latest kernel versions based on
> your comment.I see that there are more discussions happening. Please
> pont to me if you have some code already written.
>
> After your previous mail, i see that i can remove the support for CMD3
> seperately for SDIO and do it the SD way. But i am not sure how to
> maintain the list of SDIO cards seperately.Also some hardware as our
> omap does, can support multiple MMC slots, in such cases one slot can
> have SDIO and the other MMC. The core needs to cliam the cards from
> different lists. So you may see some not so correct parts in my code.
>

Your design is a bit lacking yes as it doesn't properly reuse the
structures in place. Have a look at the version I'm working on instead.

Rgds
Pierre



--=_hera.drzeus.cx-17479-1157520044-0001-2
Content-Type: text/x-patch; name="sdio-init.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdio-init.patch"

[MMC] SDIO init support

Modify the MMC detection routine to identify and initialise SDIO cards.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/Makefile            |    2 
 drivers/mmc/mmc.c               |  304 +++++++++++++++++++++++++++++++--------
 drivers/mmc/mmc.h               |    4 +
 drivers/mmc/mmc_block.c         |    6 -
 drivers/mmc/mmc_sysfs.c         |   18 ++
 drivers/mmc/sdio.c              |   90 ++++++++++++
 include/linux/mmc/card.h        |   26 +++
 include/linux/mmc/host.h        |    4 -
 include/linux/mmc/ids.h         |   14 ++
 include/linux/mmc/mmc.h         |    2 
 include/linux/mmc/protocol.h    |   19 ++
 include/linux/mmc/sdio.h        |   11 +
 include/linux/mod_devicetable.h |    9 +
 13 files changed, 433 insertions(+), 76 deletions(-)

diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index d2957e3..4847ebe 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_AT91RM9200)	+= at91_mci.o
 
-mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o
+mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o sdio.o
 
 ifeq ($(CONFIG_MMC_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index df47d00..4680459 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
  *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
- *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
+ *  SD/SDIO support Copyright (C) 2005-2006 Pierre Ossman, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -23,6 +23,7 @@ #include <linux/scatterlist.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/protocol.h>
+#include <linux/mmc/ids.h>
 
 #include "mmc.h"
 
@@ -367,7 +368,7 @@ static int mmc_select_card(struct mmc_ho
 		 * we only need to change if it supports the
 		 * wider version.
 		 */
-		if (mmc_card_sd(card) &&
+		if (mmc_card_sdmem(card) &&
 			(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
 			struct mmc_command cmd;
 			cmd.opcode = SD_APP_SET_BUS_WIDTH;
@@ -466,6 +467,7 @@ static void mmc_decode_cid(struct mmc_ca
 	memset(&card->cid, 0, sizeof(struct mmc_cid));
 
 	if (mmc_card_sd(card)) {
+		BUG_ON(!mmc_card_sdmem(card));
 		/*
 		 * SD doesn't currently have a version field so we will
 		 * have to assume we can parse this.
@@ -542,6 +544,8 @@ static void mmc_decode_csd(struct mmc_ca
 	u32 *resp = card->raw_csd;
 
 	if (mmc_card_sd(card)) {
+		BUG_ON(!mmc_card_sdmem(card));
+
 		csd_struct = UNSTUFF_BITS(resp, 126, 2);
 		if (csd_struct != 0) {
 			printk("%s: unrecognised CSD structure version %d\n",
@@ -618,7 +622,7 @@ static void mmc_decode_scr(struct mmc_ca
 	unsigned int scr_struct;
 	u32 resp[4];
 
-	BUG_ON(!mmc_card_sd(card));
+	BUG_ON(!mmc_card_sdmem(card));
 
 	resp[3] = card->raw_scr[1];
 	resp[2] = card->raw_scr[0];
@@ -653,28 +657,46 @@ static struct mmc_card *mmc_find_card(st
  * Allocate a new MMC card, and assign a unique RCA.
  */
 static struct mmc_card *
-mmc_alloc_card(struct mmc_host *host, u32 *raw_cid, unsigned int *frca)
+mmc_alloc_card(struct mmc_host *host, u32 *raw_cid, unsigned int *frca,
+	unsigned int funcs)
 {
 	struct mmc_card *card, *c;
-	unsigned int rca = *frca;
+	unsigned int rca, i;
 
 	card = kmalloc(sizeof(struct mmc_card), GFP_KERNEL);
 	if (!card)
 		return ERR_PTR(-ENOMEM);
 
 	mmc_init_card(card, host);
-	memcpy(card->raw_cid, raw_cid, sizeof(card->raw_cid));
+
+	card->functions = kmalloc(sizeof(struct mmc_function) * funcs, GFP_KERNEL);
+	if (!card->functions) {
+		mmc_remove_card(card);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	card->n_functions = funcs;
+
+	for (i = 0;i < card->n_functions;i++)
+		mmc_init_function(&card->functions[i], card);
+
+	if (raw_cid)
+		memcpy(card->raw_cid, raw_cid, sizeof(card->raw_cid));
+
+	if (frca) {
+		rca = *frca;
 
  again:
-	list_for_each_entry(c, &host->cards, node)
-		if (c->rca == rca) {
-			rca++;
-			goto again;
-		}
+		list_for_each_entry(c, &host->cards, node)
+			if (c->rca == rca) {
+				rca++;
+				goto again;
+			}
 
-	card->rca = rca;
+		card->rca = rca;
 
-	*frca = rca;
+		*frca = rca;
+	}
 
 	return card;
 }
@@ -803,6 +825,50 @@ static int mmc_send_app_op_cond(struct m
 	return err;
 }
 
+static int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
+{
+	struct mmc_command cmd;
+	int i, err = 0;
+
+	cmd.opcode = SD_IO_SEND_OP_COND;
+	cmd.arg = ocr & 0x00FFFF00;
+	cmd.flags = MMC_RSP_R4 | MMC_CMD_BCR;
+
+	for (i = 100; i; i--) {
+		err = mmc_wait_for_cmd(host, &cmd, 0);
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
+static void mmc_send_rca(struct mmc_card *card)
+{
+	struct mmc_command cmd;
+	unsigned int err;
+
+	cmd.opcode = SD_SEND_RELATIVE_ADDR;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R6 | MMC_CMD_BCR;
+
+	err = mmc_wait_for_cmd(card->host, &cmd, CMD_RETRIES);
+	if (err != MMC_ERR_NONE)
+		mmc_card_set_dead(card);
+
+	card->rca = cmd.resp[0] >> 16;
+}
+
 /*
  * Discover cards by requesting their CID.  If this command
  * times out, it is not an error; there are no further cards
@@ -834,31 +900,13 @@ static void mmc_discover_cards(struct mm
 			break;
 		}
 
-		card = mmc_find_card(host, cmd.resp);
-		if (!card) {
-			card = mmc_alloc_card(host, cmd.resp, &first_rca);
-			if (IS_ERR(card)) {
-				err = PTR_ERR(card);
-				break;
-			}
-			list_add(&card->node, &host->cards);
-		}
-
-		card->state &= ~MMC_STATE_DEAD;
-
 		if (host->mode == MMC_MODE_SD) {
-			mmc_card_set_sd(card);
+			BUG_ON(list_empty(&host->cards));
+			card = mmc_list_to_card(host->cards.next);
 
-			cmd.opcode = SD_SEND_RELATIVE_ADDR;
-			cmd.arg = 0;
-			cmd.flags = MMC_RSP_R6 | MMC_CMD_BCR;
-
-			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
-			if (err != MMC_ERR_NONE)
-				mmc_card_set_dead(card);
-			else {
-				card->rca = cmd.resp[0] >> 16;
+			mmc_send_rca(card);
 
+			if (!mmc_card_dead(card)) {
 				if (!host->ops->get_ro) {
 					printk(KERN_WARNING "%s: host does not "
 						"support reading read-only "
@@ -870,6 +918,21 @@ static void mmc_discover_cards(struct mm
 				}
 			}
 		} else {
+			card = mmc_find_card(host, cmd.resp);
+			if (!card) {
+				card = mmc_alloc_card(host, cmd.resp,
+					&first_rca, 1);
+				if (IS_ERR(card)) {
+					err = PTR_ERR(card);
+					break;
+				}
+				list_add(&card->node, &host->cards);
+				card->functions[0].vendor = MMC_VENDOR_STORAGE;
+				card->functions[0].device = MMC_DEVICE_MMC_STORAGE;
+			}
+
+			card->state &= ~MMC_STATE_DEAD;
+
 			cmd.opcode = MMC_SET_RELATIVE_ADDR;
 			cmd.arg = card->rca << 16;
 			cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -879,6 +942,13 @@ static void mmc_discover_cards(struct mm
 				mmc_card_set_dead(card);
 		}
 	}
+
+	if (host->mode == MMC_MODE_SD) {
+		BUG_ON(list_empty(&host->cards));
+		card = mmc_list_to_card(&host->cards);
+		if (!card->rca)
+			mmc_card_set_dead(card);
+	}
 }
 
 static void mmc_read_csds(struct mmc_host *host)
@@ -924,7 +994,7 @@ static void mmc_read_scrs(struct mmc_hos
 	list_for_each_entry(card, &host->cards, node) {
 		if (card->state & (MMC_STATE_DEAD|MMC_STATE_PRESENT))
 			continue;
-		if (!mmc_card_sd(card))
+		if (!mmc_card_sdmem(card))
 			continue;
 
 		err = mmc_select_card(host, card);
@@ -1004,6 +1074,9 @@ static unsigned int mmc_calculate_clock(
 		if (!mmc_card_dead(card) && max_dtr > card->csd.max_dtr)
 			max_dtr = card->csd.max_dtr;
 
+	if (max_dtr < 400000)
+		max_dtr = 400000;
+
 	pr_debug("%s: selected %d.%03dMHz transfer rate\n",
 		 mmc_hostname(host),
 		 max_dtr / 1000000, (max_dtr / 1000) % 1000);
@@ -1042,41 +1115,150 @@ static void mmc_check_cards(struct mmc_h
 	}
 }
 
-static void mmc_setup(struct mmc_host *host)
+static int mmc_initial_detect(struct mmc_host *host)
 {
-	if (host->ios.power_mode != MMC_POWER_ON) {
-		int err;
-		u32 ocr;
+	int err;
+	u32 ocr;
+	int is_sdio;
+
+	host->mode = MMC_MODE_SD;
+	is_sdio = 0;
+
+	mmc_power_up(host);
+	mmc_idle_cards(host);
+
+	err = mmc_send_io_op_cond(host, 0, &ocr);
+
+	if (err == MMC_ERR_NONE) {
+		u32 memocr;
 
-		host->mode = MMC_MODE_SD;
+		is_sdio = 1;
 
-		mmc_power_up(host);
-		mmc_idle_cards(host);
+		memocr = ~0;
 
+		/* Combo card */
+		if (ocr & SDIO_MEM_PRES) {
+			err = mmc_send_app_op_cond(host, 0, &memocr);
+			if (err != MMC_ERR_NONE) {
+				printk(KERN_ERR "%s: error requesting "
+					"memory OCR: %d\n",
+					mmc_hostname(host), err);
+				return -EIO;
+			}
+		}
+
+		if (memocr & ocr)
+			ocr = (ocr & 0xFF000000) | (memocr & ocr);
+		else {
+			printk(KERN_WARNING "%s: memory and IO OCR do "
+				"not overlap. choosing IO.\n",
+				mmc_hostname(host));
+			ocr &= ~SDIO_MEM_PRES;
+		}
+	} else
 		err = mmc_send_app_op_cond(host, 0, &ocr);
 
+	/*
+	 * If we fail to detect any SD cards then try
+	 * searching for MMC cards.
+	 */
+	if (err != MMC_ERR_NONE) {
+		host->mode = MMC_MODE_MMC;
+
+		err = mmc_send_op_cond(host, 0, &ocr);
+		if (err != MMC_ERR_NONE)
+			return -ENODEV;
+	}
+
+	host->ocr = mmc_select_voltage(host, ocr);
+	if (host->ocr == 0)
+		return -ENODEV;
+
+	/*
+	 * Since we're changing the OCR value, we seem to
+	 * need to tell some cards to go back to the idle
+	 * state.  We wait 1ms to give cards time to
+	 * respond.
+	 */
+	mmc_idle_cards(host);
+
+	/*
+	 * SD (star) topology assumes that exactly one card is always
+	 * present, so do the setup here.
+	 */
+	if (host->mode == MMC_MODE_SD) {
+		struct mmc_card *card;
+		unsigned int funcs;
+
+		if (is_sdio) {
+			funcs = (ocr >> 28) & 0x7;
+			if (ocr & SDIO_MEM_PRES)
+				funcs++;
+		} else
+			funcs = 1;
+
+		card = mmc_alloc_card(host, NULL, NULL, funcs);
+		if (IS_ERR(card))
+			return -ENOMEM;
+
+		if (is_sdio)
+			mmc_card_set_sdio(card);
+		if (!is_sdio || (ocr & SDIO_MEM_PRES))
+			mmc_card_set_sdmem(card);
+
+		BUG_ON(!list_empty(&host->cards));
+		list_add(&card->node, &host->cards);
+
+		if (mmc_card_sdmem(card)) {
+			card->functions[0].vendor = MMC_VENDOR_STORAGE;
+			card->functions[0].device = MMC_DEVICE_SD_STORAGE;
+		}
+
 		/*
-		 * If we fail to detect any SD cards then try
-		 * searching for MMC cards.
+		 * For combo cards, voltage and RCA cover both parts.
 		 */
-		if (err != MMC_ERR_NONE) {
-			host->mode = MMC_MODE_MMC;
+		if (mmc_card_sdmem(card)) {
+			mmc_send_app_op_cond(host, host->ocr, NULL);
 
-			err = mmc_send_op_cond(host, 0, &ocr);
-			if (err != MMC_ERR_NONE)
-				return;
+			mmc_discover_cards(host);
+		} else {
+			mmc_send_io_op_cond(host, host->ocr, NULL);
+
+			mmc_send_rca(card);
+		}
+
+		/*
+		 * Ok, now switch to push-pull mode.
+		 */
+		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
+		mmc_set_ios(host);
+
+		if (mmc_card_sdmem(card)) {
+			mmc_read_csds(host);
+			mmc_read_scrs(host);
 		}
 
-		host->ocr = mmc_select_voltage(host, ocr);
+		if (mmc_card_sdio(card) && !mmc_card_dead(card)) {
+			mmc_select_card(host, card);
+			sdio_discover_functions(card);
+		}
+	}
 
+	return 0;
+}
+
+static void mmc_setup(struct mmc_host *host)
+{
+	if (host->ios.power_mode != MMC_POWER_ON) {
+		if (mmc_initial_detect(host))
+			return;
+		if (host->mode == MMC_MODE_SD)
+			return;
+	} else if (host->mode == MMC_MODE_SD) {
 		/*
-		 * Since we're changing the OCR value, we seem to
-		 * need to tell some cards to go back to the idle
-		 * state.  We wait 1ms to give cards time to
-		 * respond.
+		 * In star mode there will be no additions to a running bus.
 		 */
-		if (host->ocr)
-			mmc_idle_cards(host);
+		return;
 	} else {
 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 		host->ios.clock = host->f_min;
@@ -1105,10 +1287,7 @@ static void mmc_setup(struct mmc_host *h
 	 * all get the idea that they should be ready for CMD2.
 	 * (My SanDisk card seems to need this.)
 	 */
-	if (host->mode == MMC_MODE_SD)
-		mmc_send_app_op_cond(host, host->ocr, NULL);
-	else
-		mmc_send_op_cond(host, host->ocr, NULL);
+	mmc_send_op_cond(host, host->ocr, NULL);
 
 	mmc_discover_cards(host);
 
@@ -1119,9 +1298,6 @@ static void mmc_setup(struct mmc_host *h
 	mmc_set_ios(host);
 
 	mmc_read_csds(host);
-
-	if (host->mode == MMC_MODE_SD)
-		mmc_read_scrs(host);
 }
 
 
diff --git a/drivers/mmc/mmc.h b/drivers/mmc/mmc.h
index 97bae00..abcf631 100644
--- a/drivers/mmc/mmc.h
+++ b/drivers/mmc/mmc.h
@@ -14,8 +14,12 @@ void mmc_init_card(struct mmc_card *card
 int mmc_register_card(struct mmc_card *card);
 void mmc_remove_card(struct mmc_card *card);
 
+void mmc_init_function(struct mmc_function *func, struct mmc_card *card);
+
 struct mmc_host *mmc_alloc_host_sysfs(int extra, struct device *dev);
 int mmc_add_host_sysfs(struct mmc_host *host);
 void mmc_remove_host_sysfs(struct mmc_host *host);
 void mmc_free_host_sysfs(struct mmc_host *host);
+
+void sdio_discover_functions(struct mmc_card *card);
 #endif
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index fedd375..419c1a3 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -263,7 +263,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 		/*
 		 * SD cards use a 100 multiplier and has a upper limit
 		 */
-		if (mmc_card_sd(card)) {
+		if (mmc_card_sdmem(card)) {
 			unsigned int limit_us, timeout_us;
 
 			brq.data.timeout_ns *= 10;
@@ -288,7 +288,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 		 * Only SD cards support querying the number of successfully
 		 * written sectors.
 		 */
-		if ((rq_data_dir(req) == WRITE) && !mmc_card_sd(card))
+		if ((rq_data_dir(req) == WRITE) && !mmc_card_sdmem(card))
 			brq.data.blocks = 1;
 
 		if (rq_data_dir(req) == READ) {
@@ -376,7 +376,7 @@ #endif
  	 * If this is an SD card and we're writing, we can first mark the
  	 * known good sectors as ok.
  	 */
- 	if ((rq_data_dir(req) == WRITE) && mmc_card_sd(card)) {
+ 	if ((rq_data_dir(req) == WRITE) && mmc_card_sdmem(card)) {
 		u32 blocks;
 		unsigned int bytes;
 
diff --git a/drivers/mmc/mmc_sysfs.c b/drivers/mmc/mmc_sysfs.c
index a2a35fd..e35b316 100644
--- a/drivers/mmc/mmc_sysfs.c
+++ b/drivers/mmc/mmc_sysfs.c
@@ -65,6 +65,9 @@ static void mmc_release_card(struct devi
 {
 	struct mmc_card *card = dev_to_mmc_card(dev);
 
+	if (card->functions)
+		kfree(card->functions);
+
 	kfree(card);
 }
 
@@ -215,7 +218,7 @@ int mmc_register_card(struct mmc_card *c
 
 	ret = device_add(&card->dev);
 	if (ret == 0) {
-		if (mmc_card_sd(card)) {
+		if (mmc_card_sdmem(card)) {
 			ret = device_create_file(&card->dev, &mmc_dev_attr_scr);
 			if (ret)
 				device_del(&card->dev);
@@ -231,7 +234,7 @@ int mmc_register_card(struct mmc_card *c
 void mmc_remove_card(struct mmc_card *card)
 {
 	if (mmc_card_present(card)) {
-		if (mmc_card_sd(card))
+		if (mmc_card_sdmem(card))
 			device_remove_file(&card->dev, &mmc_dev_attr_scr);
 
 		device_del(&card->dev);
@@ -241,6 +244,17 @@ void mmc_remove_card(struct mmc_card *ca
 }
 
 
+/*
+ * Internal function.  Initialise a MMC card function structure.
+ */
+void mmc_init_function(struct mmc_function *func, struct mmc_card *card)
+{
+	memset(func, 0, sizeof(struct mmc_function));
+	func->card = card;
+	func->number = (unsigned int)-1;
+}
+
+
 static void mmc_host_classdev_release(struct class_device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
diff --git a/drivers/mmc/sdio.c b/drivers/mmc/sdio.c
new file mode 100644
index 0000000..8f73378
--- /dev/null
+++ b/drivers/mmc/sdio.c
@@ -0,0 +1,90 @@
+/*
+ *  linux/drivers/mmc/sdio.c
+ *
+ *  Copyright (C) 2006 Pierre Ossman, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/protocol.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/ids.h>
+
+#define SDIO_ADDR_MASK	0x1FFFF
+
+static unsigned char __sdio_readb(const struct mmc_card *card,
+	unsigned int func, unsigned int addr)
+{
+	struct mmc_command cmd;
+	int err;
+
+	BUG_ON(addr & ~SDIO_ADDR_MASK);
+	BUG_ON(func > 7);
+
+	cmd.opcode = SD_IO_RW_DIRECT;
+	cmd.arg = (func << 28) || (addr << 9);
+	cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
+
+	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if (err != MMC_ERR_NONE)
+		return 0xFF;
+
+	if (cmd.resp[0] & (R5_ERROR | R5_FUNCTION_NUMBER | R5_OUT_OF_RANGE))
+		return 0xFF;
+
+	return cmd.resp[0] & 0xFF;
+}
+
+static void __sdio_writeb(const struct mmc_card *card, unsigned int func,
+	unsigned int addr, unsigned char data)
+{
+	struct mmc_command cmd;
+
+	BUG_ON(addr & ~SDIO_ADDR_MASK);
+	BUG_ON(func > 7);
+
+	cmd.opcode = SD_IO_RW_DIRECT;
+	cmd.arg = (1<<31) || (func << 28) || (addr << 9) || data;
+	cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
+
+	mmc_wait_for_cmd(card->host, &cmd, 0);
+}
+
+unsigned char sdio_readb(const struct mmc_function *func, unsigned int addr)
+{
+	return __sdio_readb(func->card, func->number, addr);
+}
+
+void sdio_writeb(const struct mmc_function *func,
+	unsigned int addr, unsigned char data)
+{
+	return __sdio_writeb(func->card, func->number, addr, data);
+}
+
+EXPORT_SYMBOL_GPL(sdio_readb);
+EXPORT_SYMBOL_GPL(sdio_writeb);
+
+void sdio_discover_functions(struct mmc_card *card)
+{
+	int i;
+	struct mmc_function *func;
+	unsigned int cur_func, last_func;
+
+	func = card->functions;
+	cur_func = 1;
+	last_func = card->n_functions;
+
+	/* Memory card function isn't a real SDIO function */
+	if (func->vendor == MMC_VENDOR_STORAGE) {
+		func++;
+		last_func--; 
+	}
+
+	printk(KERN_INFO "SDIO: First byte: 0x%02x\n",
+		(int)__sdio_readb(card, 0, 0));
+/*	while (cur_func <= last_func) {
+	}*/
+}
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 991a373..948c39d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -46,6 +46,15 @@ #define SD_SCR_BUS_WIDTH_1	(1<<0)
 #define SD_SCR_BUS_WIDTH_4	(1<<2)
 };
 
+struct mmc_card;
+
+struct mmc_function {
+	struct mmc_card		*card;		/* the card this func belongs to */
+	unsigned int		number;		/* function number in card */
+	unsigned int		vendor;		/* vendor id */
+	unsigned int		device;		/* device id */
+};
+
 struct mmc_host;
 
 /*
@@ -60,27 +69,36 @@ struct mmc_card {
 #define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
 #define MMC_STATE_DEAD		(1<<1)		/* device no longer in stack */
 #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
-#define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
-#define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
+#define MMC_STATE_READONLY	(1<<3)		/* card is read-only */
+#define MMC_STATE_SDMEM		(1<<4)		/* is an SD memory card */
+#define MMC_STATE_SDIO		(1<<5)		/* is an SDIO card */
+	unsigned int		type;		/* type of card */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
 	struct sd_scr		scr;		/* extra SD information */
+	unsigned int		n_functions;	/* number of card subfunctions */
+	struct mmc_function	*functions;	/* function data */
 };
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_dead(c)	((c)->state & MMC_STATE_DEAD)
 #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
-#define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
+#define mmc_card_sdmem(c)	((c)->state & MMC_STATE_SDMEM)
+#define mmc_card_sdio(c)	((c)->state & MMC_STATE_SDIO)
+
+#define mmc_card_sd(c)		(mmc_card_sdmem(c) || mmc_card_sdio(c))
+#define mmc_card_mmc(c)		(!mmc_card_sd(c))
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
 #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
-#define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
+#define mmc_card_set_sdmem(c)	((c)->state |= MMC_STATE_SDMEM)
+#define mmc_card_set_sdio(c)	((c)->state |= MMC_STATE_SDIO)
 
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f383b24..5608f22 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -100,8 +100,8 @@ #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* C
 	u32			ocr;		/* the current OCR setting */
 
 	unsigned int		mode;		/* current card mode of host */
-#define MMC_MODE_MMC		0
-#define MMC_MODE_SD		1
+#define MMC_MODE_MMC		0		/* bus topology */
+#define MMC_MODE_SD		1		/* star topology */
 
 	struct list_head	cards;		/* devices attached to this host */
 
diff --git a/include/linux/mmc/ids.h b/include/linux/mmc/ids.h
new file mode 100644
index 0000000..71268c0
--- /dev/null
+++ b/include/linux/mmc/ids.h
@@ -0,0 +1,14 @@
+/*
+ *  linux/include/linux/mmc/card.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Vendor and device ids
+ */
+
+/* Fake ids for storage cards */
+#define MMC_VENDOR_STORAGE	0xFFFFFFFE
+#define MMC_DEVICE_MMC_STORAGE	0x00000000
+#define MMC_DEVICE_SD_STORAGE	0x00000001
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 03a14a3..2d7f554 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -42,6 +42,8 @@ #define MMC_RSP_R1	(MMC_RSP_PRESENT|MMC_
 #define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
 #define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
 #define MMC_RSP_R3	(MMC_RSP_PRESENT)
+#define MMC_RSP_R4	(MMC_RSP_PRESENT)
+#define MMC_RSP_R5	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
 #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
 
 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
diff --git a/include/linux/mmc/protocol.h b/include/linux/mmc/protocol.h
index 08dec8d..c596ba6 100644
--- a/include/linux/mmc/protocol.h
+++ b/include/linux/mmc/protocol.h
@@ -81,6 +81,12 @@ #define MMC_GEN_CMD              56   /*
 /* This is basically the same command as for MMC with some quirks. */
 #define SD_SEND_RELATIVE_ADDR     3   /* bcr                     R6  */
 
+  /* class ? */
+#define SD_IO_SEND_OP_COND        5   /* bcr  [23:0] OCR         R4  */
+
+  /* class 9 */
+#define SD_IO_RW_DIRECT          52   /* ac   <Complex>          R5  */
+
   /* Application commands */
 #define SD_APP_SET_BUS_WIDTH      6   /* ac   [1:0] bus width    R1  */
 #define SD_APP_SEND_NUM_WR_BLKS  22   /* adtc                    R1  */
@@ -126,6 +132,17 @@ #define R1_CURRENT_STATE(x)    	((x & 0x
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
+/*
+  SDIO status in R5
+ */
+
+#define R5_COM_CRC_ERROR	(1 << 15)	/* er, b */
+#define R5_ILLEGAL_COMMAND	(1 << 15)	/* er, b */
+#define R5_IO_CURRENT_STATE(x)	((x & 0x00003000) >> 12) /* s, b (2 bits) */
+#define R5_ERROR		(1 << 11)	/* erx, c */
+#define R5_FUNCTION_NUMBER	(1 << 9)	/* er, c */
+#define R5_OUT_OF_RANGE		(1 << 8)	/* er, c */
+
 /* These are unpacked versions of the actual responses */
 
 struct _mmc_csd {
@@ -196,6 +213,8 @@ #define MMC_VDD_34_35	0x00400000	/* VDD 
 #define MMC_VDD_35_36	0x00800000	/* VDD voltage 3.5 ~ 3.6 */
 #define MMC_CARD_BUSY	0x80000000	/* Card Power up status bit */
 
+#define SDIO_MEM_PRES	0x08000000	/* SDIO/Mem combo card */
+
 /*
  * Card Command Classes (CCC)
  */
diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
new file mode 100644
index 0000000..9d1d561
--- /dev/null
+++ b/include/linux/mmc/sdio.h
@@ -0,0 +1,11 @@
+/*
+ *  linux/include/linux/mmc/sdio.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+unsigned char sdio_readb(const struct mmc_function *func, unsigned int addr);
+void sdio_writeb(const struct mmc_function *func,
+	unsigned int addr, unsigned char data);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index f697770..f16fbb6 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -297,4 +297,13 @@ struct input_device_id {
 	kernel_ulong_t driver_info;
 };
 
+/* MMC */
+#define MMC_ANY_ID (~0)
+
+struct mmc_device_id {
+	__u32 vendor, device;		/* Vendor and device ID or MMC_ANY_ID*/
+	__u32 class;			/* SDIO class id */
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */

--=_hera.drzeus.cx-17479-1157520044-0001-2--
