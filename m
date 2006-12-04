Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966444AbWLDUIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966444AbWLDUIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966439AbWLDUIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:08:38 -0500
Received: from smtp.nokia.com ([131.228.20.171]:20494 "EHLO
	mgw-ext12.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966444AbWLDUIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:08:37 -0500
Message-ID: <457480F5.2040300@indt.org.br>
Date: Mon, 04 Dec 2006 16:11:33 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: [PATCH 1/4] Add MMC Password Protection (lock/unlock) support V8:
 mmc_ignore_locked.diff
Content-Type: multipart/mixed;
 boundary="------------080802000007030604090305"
X-OriginalArrivalTime: 04 Dec 2006 20:07:17.0903 (UTC) FILETIME=[CC79D1F0:01C717DF]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080802000007030604090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080802000007030604090305
Content-Type: text/plain;
 name="mmc_ignore_locked.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_ignore_locked.diff"

When a card is locked, only commands from the "basic" and "lock card" classes
are accepted. To be able to use the other commands, the card must be unlocked
first.

This patch prevents the device drivers from probing the locked cards. Device
probing must be triggered sometime later to make the card available to the
block driver.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
Signed-off-by: David Brownell <david-b <at> pacbell.net>

Index: linux-linus-2.6/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-linus-2.6.orig/drivers/mmc/mmc_sysfs.c	2006-12-04 14:57:42.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/mmc_sysfs.c	2006-12-04 15:34:11.000000000 -0400
@@ -17,6 +17,7 @@
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/protocol.h>
 
 #include "mmc.h"
 
@@ -73,10 +74,19 @@ static void mmc_release_card(struct devi
  * This currently matches any MMC driver to any MMC card - drivers
  * themselves make the decision whether to drive this card in their
  * probe method.  However, we force "bad" cards to fail.
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
 
Index: linux-linus-2.6/drivers/mmc/mmc.c
===================================================================
--- linux-linus-2.6.orig/drivers/mmc/mmc.c	2006-12-04 14:57:42.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/mmc.c	2006-12-04 15:34:07.000000000 -0400
@@ -923,6 +923,11 @@ static void mmc_discover_cards(struct mm
 			if (err != MMC_ERR_NONE)
 				mmc_card_set_dead(card);
 		}
+
+		if (cmd.resp[0] & R1_CARD_IS_LOCKED)
+			mmc_card_set_locked(card);
+		else
+			mmc_card_clear_locked(card);
 	}
 }
 
Index: linux-linus-2.6/include/linux/mmc/card.h
===================================================================
--- linux-linus-2.6.orig/include/linux/mmc/card.h	2006-12-04 14:57:43.000000000 -0400
+++ linux-linus-2.6/include/linux/mmc/card.h	2006-12-04 15:21:05.000000000 -0400
@@ -71,6 +71,7 @@ struct mmc_card {
 #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
 #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
 #define MMC_STATE_HIGHSPEED	(1<<5)		/* card is in high speed mode */
+#define MMC_STATE_LOCKED	(1<<6)		/* card is currently locked */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
@@ -87,6 +88,10 @@ struct mmc_card {
 #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
+#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
+
+#define mmc_card_lockable(c)	(((c)->csd.cmdclass & CCC_LOCK_CARD) && \
+				((c)->host->caps & MMC_CAP_BYTEBLOCK))
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
@@ -94,6 +99,9 @@ struct mmc_card {
 #define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
+#define mmc_card_set_locked(c)	((c)->state |= MMC_STATE_LOCKED)
+
+#define mmc_card_clear_locked(c)	((c)->state &= ~MMC_STATE_LOCKED)
 
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)

--------------080802000007030604090305--
