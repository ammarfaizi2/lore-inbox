Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWAIWOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWAIWOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWAIWOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:14:07 -0500
Received: from mgw-ext01.nokia.com ([131.228.20.93]:53124 "EHLO
	mgw-ext01.nokia.com") by vger.kernel.org with ESMTP
	id S1751470AbWAIWOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:14:04 -0500
Message-ID: <43C2E064.90500@indt.org.br>
Date: Mon, 09 Jan 2006 18:15:00 -0400
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
Subject: [patch 1/5] Add MMC password protection (lock/unlock) support V3
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000306090100090603080502"
X-OriginalArrivalTime: 09 Jan 2006 22:13:21.0024 (UTC) FILETIME=[E68AC000:01C61569]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000306090100090603080502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------000306090100090603080502
Content-Type: text/x-patch;
 name="mmc_ignore_locked.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_ignore_locked.diff"

When a card is locked, only commands from the "basic" and "lock card" classes
are accepted. To be able to use the other commands, the card must be unlocked
first.

This patch prevents the block driver from trying to run privileged class
commands on locked MMC cards, which will fail anyway.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Brownell <david-b@pacbell.net>

Index: linux-2.6.15-rc4/drivers/mmc/mmc.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/mmc.c	2005-12-15 14:06:52.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/mmc.c	2005-12-15 17:00:37.000000000 -0400
@@ -986,10 +986,15 @@ static void mmc_check_cards(struct mmc_h
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
+		else
+			card->state &= ~MMC_STATE_LOCKED;
 	}
 }
 
Index: linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/mmc_sysfs.c	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c	2005-12-15 17:00:29.000000000 -0400
@@ -16,6 +16,7 @@
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/protocol.h>
 
 #include "mmc.h"
 
@@ -69,13 +70,22 @@ static void mmc_release_card(struct devi
 }
 
 /*
- * This currently matches any MMC driver to any MMC card - drivers
- * themselves make the decision whether to drive this card in their
- * probe method.  However, we force "bad" cards to fail.
+ * This currently matches any MMC driver to any MMC card - drivers themselves
+ * make the decision whether to drive this card in their probe method.
+ * However, we force "bad" cards to fail.
+ *
+ * We also fail for all locked cards; drivers expect to be able to do block
+ * I/O still on probe(), which is not possible while the card is locked.
+ * Device probing must be triggered sometime later to make the card available
+ * to the block driver.
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
 
Index: linux-2.6.15-rc4/include/linux/mmc/card.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/mmc/card.h	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.15-rc4/include/linux/mmc/card.h	2005-12-15 17:00:37.000000000 -0400
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

--------------000306090100090603080502--
