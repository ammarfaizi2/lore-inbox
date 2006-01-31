Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWAaUdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWAaUdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWAaUdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:33:43 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:28787 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751465AbWAaUdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:33:42 -0500
Message-Id: <20060131202540.491518000@localhost.localdomain>
References: <20060131201636.264543000@localhost.localdomain>
Date: Tue, 31 Jan 2006 16:16:37 -0400
From: Carlos Aguiar <carlos.aguiar@indt.org.br>
To: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
Cc: linux@arm.linux.org.uk, David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 1/6] Add MMC password protection (lock/unlock) support V4
Content-Disposition: inline; filename=mmc_ignore_locked.diff
X-OriginalArrivalTime: 31 Jan 2006 20:25:43.0318 (UTC) FILETIME=[82898360:01C626A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a card is locked, only commands from the "basic" and "lock card" classes
are accepted. To be able to use the other commands, the card must be unlocked
first.

This patch prevents the block driver from trying to run privileged class
commands on locked MMC cards, which will fail anyway.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Brownell <david-b@pacbell.net>

Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-01-31 15:17:45.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-01-31 15:22:07.000000000 -0400
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
 
Index: linux-omap-2.6.git/include/linux/mmc/card.h
===================================================================
--- linux-omap-2.6.git.orig/include/linux/mmc/card.h	2006-01-31 15:17:45.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/card.h	2006-01-31 15:22:07.000000000 -0400
@@ -61,6 +61,7 @@ struct mmc_card {
 #define MMC_STATE_BAD		(1<<2)		/* unrecognised device */
 #define MMC_STATE_SDCARD	(1<<3)		/* is an SD card */
 #define MMC_STATE_READONLY	(1<<4)		/* card is read-only */
+#define MMC_STATE_LOCKED	(1<<5)		/* card is currently locked */
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
@@ -74,12 +75,18 @@ struct mmc_card {
 #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
 #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
+#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
+#define mmc_card_clear_locked(c)	((c)->state &= ~MMC_STATE_LOCKED)
+
+#define mmc_card_lockable(c)    (((c)->csd.cmdclass & CCC_LOCK_CARD) && \
+				((c)->host->caps & MMC_CAP_LOCK_UNLOCK))
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_dead(c)	((c)->state |= MMC_STATE_DEAD)
 #define mmc_card_set_bad(c)	((c)->state |= MMC_STATE_BAD)
 #define mmc_card_set_sd(c)	((c)->state |= MMC_STATE_SDCARD)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
+#define mmc_card_set_locked(c)	((c)->state |= MMC_STATE_LOCKED)
 
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		((c)->dev.bus_id)
Index: linux-omap-2.6.git/include/linux/mmc/host.h
===================================================================
--- linux-omap-2.6.git.orig/include/linux/mmc/host.h	2006-01-31 15:17:45.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/host.h	2006-01-31 15:22:07.000000000 -0400
@@ -85,6 +85,8 @@ struct mmc_host {
 	unsigned long		caps;		/* Host capabilities */
 
 #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
+#define MMC_CAP_LOCK_UNLOCK	(1 << 1)	/* Host password support capability */
+
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
Index: linux-omap-2.6.git/drivers/mmc/mmc.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.c	2006-01-31 15:17:45.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.c	2006-01-31 15:22:07.000000000 -0400
@@ -828,6 +828,11 @@ static void mmc_discover_cards(struct mm
 			list_add(&card->node, &host->cards);
 		}
 
+		if (cmd.resp[0] & R1_CARD_IS_LOCKED)
+			mmc_card_set_locked(card);
+		else
+			mmc_card_clear_locked(card);
+
 		card->state &= ~MMC_STATE_DEAD;
 
 		if (host->mode == MMC_MODE_SD) {

--
