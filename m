Return-Path: <linux-kernel-owner+w=401wt.eu-S1753187AbWLOSxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbWLOSxu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbWLOSxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:53:50 -0500
Received: from smtp.nokia.com ([131.228.20.172]:53260 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbWLOSxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:53:48 -0500
Message-ID: <4582EFE7.4020001@indt.org.br>
Date: Fri, 15 Dec 2006 14:56:39 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: [PATCH 3/4] Add MMC Password Protection (lock/unlock) support V9:
 mmc_lock_unlock.diff
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/mixed;
 boundary="------------010504040704020203070204"
X-OriginalArrivalTime: 15 Dec 2006 18:51:52.0931 (UTC) FILETIME=[15ED2330:01C7207A]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061215205304-0FC92BB0-00C26EF4/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010504040704020203070204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit






--------------010504040704020203070204
Content-Type: text/plain;
 name="mmc_lock_unlock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_lock_unlock.diff"

Implement card lock/unlock operation, using the MMC_LOCK_UNLOCK command.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-linus-2.6/drivers/mmc/mmc.h
===================================================================
--- linux-linus-2.6.orig/drivers/mmc/mmc.h	2006-12-15 14:35:14.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/mmc.h	2006-12-15 14:35:22.000000000 -0400
@@ -27,6 +27,10 @@ struct mmc_key_payload {
 	char		data[0];	/* actual data */
 };
 
+struct key;
+
+extern int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
+
 int mmc_schedule_work(struct work_struct *work);
 int mmc_schedule_delayed_work(struct delayed_work *work, unsigned long delay);
 void mmc_flush_scheduled_work(void);
Index: linux-linus-2.6/include/linux/mmc/protocol.h
===================================================================
--- linux-linus-2.6.orig/include/linux/mmc/protocol.h	2006-12-15 14:31:16.000000000 -0400
+++ linux-linus-2.6/include/linux/mmc/protocol.h	2006-12-15 14:35:22.000000000 -0400
@@ -312,5 +312,13 @@ struct _mmc_csd {
 #define SD_BUS_WIDTH_1      0
 #define SD_BUS_WIDTH_4      2
 
+/*
+ * MMC_LOCK_UNLOCK modes
+ */
+#define MMC_LOCK_MODE_ERASE	(1<<3)
+#define MMC_LOCK_MODE_UNLOCK	(1<<2)
+#define MMC_LOCK_MODE_CLR_PWD	(1<<1)
+#define MMC_LOCK_MODE_SET_PWD	(1<<0)
+
 #endif  /* MMC_MMC_PROTOCOL_H */
 
Index: linux-linus-2.6/drivers/mmc/mmc.c
===================================================================
--- linux-linus-2.6.orig/drivers/mmc/mmc.c	2006-12-15 14:35:10.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/mmc.c	2006-12-15 14:35:22.000000000 -0400
@@ -5,6 +5,8 @@
  *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
  *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
  *  MMCv4 support Copyright (C) 2006 Philip Langdale, All Rights Reserved.
+ *  MMC password protection (C) 2006 Instituto Nokia de Tecnologia (INdT),
+ *	All Rights Reserved.
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
@@ -1413,6 +1416,119 @@ static void mmc_setup(struct mmc_host *h
 		mmc_process_ext_csds(host);
 }
 
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
+	if (!(mode & MMC_LOCK_MODE_ERASE)) {
+		mpayload = rcu_dereference(key->payload.data);
+		data_size = 2 + mpayload->datalen;
+	}
+
+	data_buf = kmalloc(data_size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+	memset(data_buf, 0, data_size);
+
+	data_buf[0] |= mode;
+	if (mode & MMC_LOCK_MODE_UNLOCK)
+		data_buf[0] &= ~MMC_LOCK_MODE_UNLOCK;
+
+	if (!(mode & MMC_LOCK_MODE_ERASE)) {
+		data_buf[1] = mpayload->datalen;
+		memcpy(data_buf + 2, mpayload->data, mpayload->datalen);
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SET_BLOCKLEN;
+	cmd.arg = data_size;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, CMD_RETRIES);
+	if (err != MMC_ERR_NONE)
+		goto out;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_LOCK_UNLOCK;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1B | MMC_CMD_ADTC;
+
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	mmc_set_data_timeout(&data, card, 1);
+
+	data.blksz = data_size;
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
+	if (err != MMC_ERR_NONE)
+		goto out;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SEND_STATUS;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
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
+		if (!(mode & MMC_LOCK_MODE_ERASE))
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
+	if (cmd.resp[0] & R1_CARD_IS_LOCKED)
+		mmc_card_set_locked(card);
+	else
+		mmc_card_clear_locked(card);
+
+out:
+	kfree(data_buf);
+
+	return err;
+}
 
 /**
  *	mmc_detect_change - process change of state on a MMC socket

--------------010504040704020203070204--
