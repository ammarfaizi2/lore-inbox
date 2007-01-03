Return-Path: <linux-kernel-owner+w=401wt.eu-S1750727AbXACMDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbXACMDW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 07:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXACMDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 07:03:22 -0500
Received: from smtp.nokia.com ([131.228.20.170]:51812 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbXACMDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 07:03:21 -0500
Message-ID: <459B9C7E.30405@indt.org.br>
Date: Wed, 03 Jan 2007 08:07:26 -0400
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
Subject: Re: [PATCH 1/4] Add MMC Password Protection (lock/unlock) support
 V9: mmc_ignore_locked.diff
References: <4582EF99.4070902@indt.org.br>
In-Reply-To: <4582EF99.4070902@indt.org.br>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/mixed;
 boundary="------------090305080100010300070006"
X-OriginalArrivalTime: 03 Jan 2007 12:02:19.0482 (UTC) FILETIME=[04DBA3A0:01C72F2F]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090305080100010300070006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



--------------090305080100010300070006
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

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: David Brownell <david-b@pacbell.net>

Index: linux-linus-2.6/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-linus-2.6.orig/drivers/mmc/mmc_sysfs.c	2007-01-03 07:39:53.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/mmc_sysfs.c	2007-01-03 07:57:37.000000000 -0400
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
--- linux-linus-2.6.orig/drivers/mmc/mmc.c	2007-01-03 07:39:53.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/mmc.c	2007-01-03 07:57:37.000000000 -0400
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
--- linux-linus-2.6.orig/include/linux/mmc/card.h	2007-01-03 07:39:53.000000000 -0400
+++ linux-linus-2.6/include/linux/mmc/card.h	2007-01-03 07:57:37.000000000 -0400
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

--------------090305080100010300070006--
