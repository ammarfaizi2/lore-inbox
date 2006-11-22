Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755309AbWKVQLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbWKVQLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbWKVQLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:11:35 -0500
Received: from mgw-ext13.nokia.com ([131.228.20.172]:32946 "EHLO
	mgw-ext13.nokia.com") by vger.kernel.org with ESMTP
	id S1755310AbWKVQLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:11:32 -0500
Message-ID: <45646330.9010402@indt.org.br>
Date: Wed, 22 Nov 2006 10:48:16 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Pierre Ossman <drzeus-list@drzeus.cx>, Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: [patch 1/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_ignore_locked.diff
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2006 14:44:25.0247 (UTC) FILETIME=[B4841AF0:01C70E44]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a card is locked, only commands from the "basic" and "lock card" classes
are accepted. To be able to use the other commands, the card must be unlocked
first.

This patch prevents the device drivers from trying to run privileged class
commands on locked MMC cards, which will fail anyway.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
Signed-off-by: David Brownell <david-b <at> pacbell.net>

Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-22 07:58:20.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-22 09:19:16.000000000 -0400
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

Index: linux-omap-2.6.git/include/linux/mmc/card.h
===================================================================
--- linux-omap-2.6.git.orig/include/linux/mmc/card.h	2006-11-22 07:58:20.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/card.h	2006-11-22 09:07:23.000000000 -0400
@@ -62,6 +62,7 @@ struct mmc_card {
  #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
  #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
  #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
+#define MMC_STATE_LOCKED	(1<<5)		/* card is currently locked */
  	u32			raw_cid[4];	/* raw card CID */
  	u32			raw_csd[4];	/* raw card CSD */
  	u32			raw_scr[2];	/* raw card SCR */
@@ -75,12 +76,19 @@ struct mmc_card {
  #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
  #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
+#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
+
+#define mmc_card_lockable(c)    (((c)->csd.cmdclass & CCC_LOCK_CARD) && \
+				((c)->host->caps & MMC_CAP_BYTEBLOCK))

  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
  #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
  #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
  #define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
+#define mmc_card_set_locked(c)	((c)->state |= MMC_STATE_LOCKED)
+
+#define mmc_card_clear_locked(c)	((c)->state &= ~MMC_STATE_LOCKED)

  #define mmc_card_name(c)	((c)->cid.prod_name)
  #define mmc_card_id(c)		((c)->dev.bus_id)
Index: linux-omap-2.6.git/drivers/mmc/mmc.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.c	2006-11-22 07:58:20.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.c	2006-11-22 09:19:13.000000000 -0400
@@ -922,6 +922,11 @@ static void mmc_discover_cards(struct mm
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
