Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWAIWOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWAIWOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWAIWOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:14:37 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:16209 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP
	id S1751176AbWAIWOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:14:36 -0500
Message-ID: <43C2E087.1090608@indt.org.br>
Date: Mon, 09 Jan 2006 18:15:35 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 2/5] Add MMC password protection (lock/unlock) support V3
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040206070405070008060508"
X-OriginalArrivalTime: 09 Jan 2006 22:13:55.0929 (UTC) FILETIME=[FB58D490:01C61569]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040206070405070008060508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit




--------------040206070405070008060508
Content-Type: text/x-patch;
 name="mmc_lock_unlock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_lock_unlock.diff"

Implement card lock/unlock card operation, using the MMC_LOCK_UNLOCK command.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.15-rc4/drivers/mmc/mmc.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/mmc.c	2006-01-04 17:34:53.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/mmc.c	2006-01-08 07:46:29.703803776 -0400
@@ -4,6 +4,8 @@
  *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
  *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
  *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
+ *  MMC password protection (C) 2005 Instituto Nokia de Tecnologia (INdT),
+ *     All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -20,6 +22,7 @@
 #include <linux/err.h>
 #include <asm/scatterlist.h>
 #include <linux/scatterlist.h>
+#include <linux/key.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -1088,6 +1091,134 @@
 		mmc_read_scrs(host);
 }
 
+/* Calculate the minimal blksz_bits to hold x bytes. */
+static inline int blksz_bits(unsigned x)
+{
+	return fls(x-1);
+}
+
+/**
+ *	mmc_lock_unlock - send LOCK_UNLOCK command to a specific card.
+ *	@card: card to which the LOCK_UNLOCK command should be sent
+ *	@key: key containing the MMC password
+ *	@mode: LOCK_UNLOCK mode
+ *
+ */
+int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode)
+{
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+	struct scatterlist sg;
+	struct mmc_key_payload *mpayload;
+	unsigned long erase_timeout;
+	int err, data_size;
+	u8 *data_buf;
+
+	mpayload = NULL;
+	data_size = 1;
+	if (mode != MMC_LOCK_MODE_ERASE) {
+		mpayload = rcu_dereference(key->payload.data);
+		data_size = 2 + mpayload->datalen;
+	}
+
+	data_buf = kmalloc(data_size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+	memset(data_buf, 0, data_size);
+
+	data_buf[0] = mode;
+	if (mode != MMC_LOCK_MODE_ERASE) {
+		data_buf[1] = mpayload->datalen;
+		memcpy(data_buf + 2, mpayload->data, mpayload->datalen);
+	}
+
+	err = mmc_card_claim_host(card);
+	if (err != MMC_ERR_NONE) {
+		mmc_card_set_dead(card);
+		goto out;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SET_BLOCKLEN;
+	cmd.arg = data_size;
+	cmd.flags = MMC_RSP_R1;
+	err = mmc_wait_for_cmd(card->host, &cmd, CMD_RETRIES);
+	if (err != MMC_ERR_NONE) {
+		mmc_card_set_dead(card);
+		goto error;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_LOCK_UNLOCK;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1B;
+
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	data.timeout_ns = card->csd.tacc_ns * 10;
+	data.timeout_clks = card->csd.tacc_clks * 10;
+	data.blksz_bits = blksz_bits(data_size);
+	data.blocks = 1;
+	data.flags = MMC_DATA_WRITE;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	sg_init_one(&sg, data_buf, data_size);
+	err = mmc_wait_for_req(card->host, &mrq);
+	if (err != MMC_ERR_NONE) {
+		mmc_card_set_dead(card);
+		goto error;
+	}
+
+        memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SEND_STATUS;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1;
+
+	/* set timeout for forced erase operation to 3 min. (see MMC spec) */
+	erase_timeout = jiffies + 180 * HZ;
+	do {
+		/* we cannot use "retries" here because the
+		 * R1_LOCK_UNLOCK_FAILED bit is cleared by subsequent reads to
+		 * the status register, hiding the error condition */
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (err != MMC_ERR_NONE)
+			break;
+		/* the other modes don't need timeout checking */
+		if (mode != MMC_LOCK_MODE_ERASE)
+			continue;
+		if (time_after(jiffies, erase_timeout)) {
+			dev_dbg(&card->dev, "forced erase timed out\n");
+			err = MMC_ERR_TIMEOUT;
+			break;
+		}
+	} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
+	if (cmd.resp[0] & R1_LOCK_UNLOCK_FAILED) {
+		dev_dbg(&card->dev, "LOCK_UNLOCK operation failed\n");
+		err = MMC_ERR_FAILED;
+	}
+
+error:
+	mmc_check_cards(card->host);
+	mmc_deselect_cards(card->host);
+	mmc_card_release_host(card);
+out:
+	kfree(data_buf);
+
+	return err;
+}
+
+EXPORT_SYMBOL(mmc_lock_unlock);
+
 
 /**
  *	mmc_detect_change - process change of state on a MMC socket
Index: linux-2.6.15-rc4/include/linux/mmc/card.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/mmc/card.h	2006-01-04 17:34:53.000000000 -0400
+++ linux-2.6.15-rc4/include/linux/mmc/card.h	2006-01-08 07:50:19.204914304 -0400
@@ -72,7 +72,7 @@
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
 
-#define mmc_card_lockable(c)	((c)->csd.cmdclass & CCC_LOCK_CARD)
+#define mmc_card_lockable(c)   (((c)->csd.cmdclass & CCC_LOCK_CARD) && (c)->host->pwd_support)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
@@ -109,4 +109,8 @@
 
 #define mmc_card_release_host(c)	mmc_release_host((c)->host)
 
+struct key;
+
+extern int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
+
 #endif
Index: linux-2.6.15-rc4/include/linux/mmc/protocol.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/mmc/protocol.h	2006-01-04 17:34:47.000000000 -0400
+++ linux-2.6.15-rc4/include/linux/mmc/protocol.h	2006-01-04 17:34:53.000000000 -0400
@@ -243,5 +243,13 @@
 #define SD_BUS_WIDTH_1      0
 #define SD_BUS_WIDTH_4      2
 
+/*
+ * MMC_LOCK_UNLOCK modes
+ */
+#define MMC_LOCK_MODE_ERASE	(1<<3)
+#define MMC_LOCK_MODE_UNLOCK	(0<<2)
+#define MMC_LOCK_MODE_CLR_PWD	(1<<1)
+#define MMC_LOCK_MODE_SET_PWD	(1<<0)
+
 #endif  /* MMC_MMC_PROTOCOL_H */
 
Index: linux-2.6.15-rc4/include/linux/mmc/host.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/mmc/host.h	2006-01-08 07:35:39.069715192 -0400
+++ linux-2.6.15-rc4/include/linux/mmc/host.h	2006-01-08 07:49:40.763758248 -0400
@@ -83,6 +83,7 @@
 	u32			ocr_avail;
 
 	unsigned long		caps;		/* Host capabilities */
+	int                     pwd_support;    /* MMC password support */
 
 #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
 

--------------040206070405070008060508--
