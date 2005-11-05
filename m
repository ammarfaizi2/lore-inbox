Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVKEUjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVKEUjS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 15:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVKEUjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 15:39:17 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:28870 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932200AbVKEUjR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 15:39:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ALBVhu7NTyxXRLZFNaE1aKmj9RESHbeXH8g0GfqDrDvPiaQMkVcCgC91USDSfkLmd/QxZ8LtmsHuU46jx6Pr5JKC9dk9DnqJQ7Wnf5JCbbyHiXk4fgNwPv64elI5toSAbBQyG+0XaQepiM02v1i2LoPvfBulixm6aWVR4+bxcF8=
Message-ID: <5b5833aa0511051239g316a32e1t3441d58053a24f82@mail.gmail.com>
Date: Sat, 5 Nov 2005 15:39:16 -0500
From: Anderson Lizardo <anderson.lizardo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MMC: Prevent MMC block driver from trying to access password-locked cards
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Pierre Ossman <drzeus@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are working on adding support for password-locked MMC cards on
Linux, using the Kernel Key Retention Service for password management.
This is the first patch we will be sending to add such support. Any
comments/suggestions are welcome.

The patch itself:

Prevent the MMC block driver from trying to access password-locked MMC cards.

Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Brownell <david-b@pacbell.net>
---
commit 7dd244db4842d8d8741c9a1c4a37760d16d07a80
tree 4a4b6843cc9db67454365dec420f2af46b705834
parent 06024f217d607369f0ee0071034ebb03071d5fb2
author Anderson Lizardo <anderson.lizardo@indt.org.br> Thu, 03 Nov
2005 19:48:48 -0500
committer Anderson Lizardo <anderson.lizardo@indt.org.br> Thu, 03 Nov
2005 19:48:48 -0500

 drivers/mmc/mmc.c        |    7 +++++--
 drivers/mmc/mmc_sysfs.c  |   18 +++++++++++++++---
 include/linux/mmc/card.h |    5 +++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -986,10 +986,13 @@ static void mmc_check_cards(struct mmc_h
 		cmd.flags = MMC_RSP_R1;

 		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
-		if (err == MMC_ERR_NONE)
+		if (err != MMC_ERR_NONE) {
+			mmc_card_set_dead(card);
 			continue;
+		}

-		mmc_card_set_dead(card);
+		if (cmd.resp[0] & R1_CARD_IS_LOCKED)
+			mmc_card_set_locked(card);
 	}
 }

diff --git a/drivers/mmc/mmc_sysfs.c b/drivers/mmc/mmc_sysfs.c
--- a/drivers/mmc/mmc_sysfs.c
+++ b/drivers/mmc/mmc_sysfs.c
@@ -16,6 +18,7 @@

 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/protocol.h>

 #include "mmc.h"

@@ -69,13 +72,22 @@ static void mmc_release_card(struct devi
 }

 /*
- * This currently matches any MMC driver to any MMC card - drivers
- * themselves make the decision whether to drive this card in their
- * probe method.  However, we force "bad" cards to fail.
+ * This currently matches any MMC driver to any MMC card - drivers themselves
+ * make the decision whether to drive this card in their probe method. However,
+ * we force "bad" cards to fail.
+ *
+ * We also fail for all locked cards; drivers expect to be able to do I/O still
+ * on probe(), which is not possible while the card is locked. mmc_rescan()
+ * must then be triggered sometime later to unlock the card and make it
+ * available to the block driver.
  */
 static int mmc_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct mmc_card *card = dev_to_mmc_card(dev);
+	if (mmc_card_lockable(card) && mmc_card_locked(card)) {
+		dev_dbg(&card->dev, "card is locked; binding is deferred\n");
+		return 0;
+	}
 	return !mmc_card_bad(card);
 }

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -56,6 +56,7 @@ struct mmc_card {
 #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
 #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
 #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
+#define MMC_STATE_LOCKED	(1<<5)		/* card is currently locked */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
@@ -69,12 +70,16 @@ struct mmc_card {
 #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
 #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
+#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
+
+#define mmc_card_lockable(c)	((c)->csd.cmdclass & CCC_LOCK_CARD)

 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
 #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
 #define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
+#define mmc_card_set_locked(c)	((c)->state |= MMC_STATE_LOCKED)

 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)


--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
