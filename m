Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVLNNbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVLNNbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVLNNbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:31:36 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:1171 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932510AbVLNNbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:31:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=IMQYtPoE/iHGkOlY0dSHozSYniNaIpuF+XAwBMgLNjEkppz7z+FG0j6XVmYsbTzx0GM8U0mPx0T5y1W/c3QQflFzCfTTKMB0oeucwA0Y8JUzfWDN0zYikF/hLlFBDr0Of+p5yujXe7KibpEx04oxbL6MCS0GmXKaUy2xhjFAmjA=
Message-ID: <e55525570512140531k110169fal9b8b6423b022aafc@mail.gmail.com>
Date: Wed, 14 Dec 2005 09:31:33 -0400
From: Anderson Briglia <briglia.anderson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 2/5] [RFC] Add MMC password protection (lock/unlock) support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7223_1815860.1134567093232"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7223_1815860.1134567093232
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



------=_Part_7223_1815860.1134567093232
Content-Type: text/x-patch; name=mmc_lock_unlock.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mmc_lock_unlock.diff"

Implement card lock/unlock card operation, using the MMC_LOCK_UNLOCK command.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.14-omap2/drivers/mmc/mmc.c
===================================================================
--- linux-2.6.14-omap2.orig/drivers/mmc/mmc.c	2005-12-13 11:41:08.000000000 -0400
+++ linux-2.6.14-omap2/drivers/mmc/mmc.c	2005-12-13 14:49:12.000000000 -0400
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
@@ -1088,6 +1091,159 @@ static void mmc_setup(struct mmc_host *h
 		mmc_read_scrs(host);
 }
 
+static int pop(unsigned x)
+{
+	x = x - ((x >> 1) & 0x55555555);
+	x = (x & 0x33333333) + ((x >> 2) & 0x33333333);
+	x = (x + (x >> 4)) & 0x0F0F0F0F;
+	x = x + (x >> 8);
+	x = x + (x >> 16);
+
+	return x & 0x0000003F;
+}
+
+static int ilog2(unsigned x)
+{
+	x = x | (x >> 1);
+	x = x | (x >> 2);
+	x = x | (x >> 4);
+	x = x | (x >> 8);
+	x = x | (x >> 16);
+
+	return pop(x) - 1;
+}
+
+/* Calculate the minimal blksz_bits to hold x bytes. The two math functions
+ * above are used to do the calculation.
+ *
+ * XXX There must be a simpler way to do this... */
+static inline int blksz_bits(unsigned x)
+{
+	return 1 + ilog2(x - 1);
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
Index: linux-2.6.14-omap2/include/linux/mmc/card.h
===================================================================
--- linux-2.6.14-omap2.orig/include/linux/mmc/card.h	2005-12-13 11:41:08.000000000 -0400
+++ linux-2.6.14-omap2/include/linux/mmc/card.h	2005-12-13 11:42:06.000000000 -0400
@@ -10,6 +10,7 @@
 #ifndef LINUX_MMC_CARD_H
 #define LINUX_MMC_CARD_H
 
+#include <linux/key.h>
 #include <linux/mmc/mmc.h>
 
 struct mmc_cid {
@@ -109,4 +110,6 @@ static inline int mmc_card_claim_host(st
 
 #define mmc_card_release_host(c)	mmc_release_host((c)->host)
 
+extern int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
+
 #endif
Index: linux-2.6.14-omap2/include/linux/mmc/protocol.h
===================================================================
--- linux-2.6.14-omap2.orig/include/linux/mmc/protocol.h	2005-12-13 11:41:01.000000000 -0400
+++ linux-2.6.14-omap2/include/linux/mmc/protocol.h	2005-12-13 11:42:21.000000000 -0400
@@ -243,5 +243,13 @@ struct _mmc_csd {
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
 

--
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil



------=_Part_7223_1815860.1134567093232--
