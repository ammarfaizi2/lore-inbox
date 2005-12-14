Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVLNNau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVLNNau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVLNNau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:30:50 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:34437 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932515AbVLNNat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:30:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=gwEzHROut/mncxnjySKHHJF2FIkbYuhIxAQ7W3imLYlQHR9grg4wBL4SfQTqn3iNgGDNuTLyHcCirvCYeJ3/XVdPfMLEniNi952RGzXwAOF6Le5Rnjd8VYjU6H6b/9rWqCDiv5hcdsCwGCGwhKVGBWIJ1Xo/leQhBr3Aopawge4=
Message-ID: <e55525570512140530u3601e325ha63b1db10209dbcc@mail.gmail.com>
Date: Wed, 14 Dec 2005 09:30:49 -0400
From: Anderson Briglia <briglia.anderson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 1/5] [RFC] Add MMC password protection (lock/unlock) support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7207_8947452.1134567049002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7207_8947452.1134567049002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



------=_Part_7207_8947452.1134567049002
Content-Type: text/x-patch; name=mmc_ignore_locked.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mmc_ignore_locked.diff"

When a card is locked, only commands from the "basic" and "lock card" classes
are accepted. To be able to use the other commands, the card must be unlocked
first.

This patch prevents the block driver from trying to run privileged class
commands on locked MMC cards, which will fail anyway.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Brownell <david-b@pacbell.net>

Index: linux-2.6.14-omap2/drivers/mmc/mmc.c
===================================================================
--- linux-2.6.14-omap2.orig/drivers/mmc/mmc.c	2005-12-12 08:45:47.000000000 -0400
+++ linux-2.6.14-omap2/drivers/mmc/mmc.c	2005-12-12 08:47:04.000000000 -0400
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
 
Index: linux-2.6.14-omap2/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.14-omap2.orig/drivers/mmc/mmc_sysfs.c	2005-12-12 08:45:47.000000000 -0400
+++ linux-2.6.14-omap2/drivers/mmc/mmc_sysfs.c	2005-12-12 08:50:20.000000000 -0400
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
+ * make the decision whether to drive this card in their probe method. However,
+ * we force "bad" cards to fail.
+ *
+ * We also fail for all locked cards; drivers expect to be able to do block I/O
+ * still on probe(), which is not possible while the card is locked. Device
+ * probing must be triggered sometime later to make the card available to the
+ * block driver.
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
 
Index: linux-2.6.14-omap2/include/linux/mmc/card.h
===================================================================
--- linux-2.6.14-omap2.orig/include/linux/mmc/card.h	2005-12-12 08:45:47.000000000 -0400
+++ linux-2.6.14-omap2/include/linux/mmc/card.h	2005-12-12 08:47:04.000000000 -0400
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
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil



------=_Part_7207_8947452.1134567049002--
