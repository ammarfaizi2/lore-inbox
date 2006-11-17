Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933600AbWKQNSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933600AbWKQNSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933603AbWKQNSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:18:20 -0500
Received: from mgw-ext13.nokia.com ([131.228.20.172]:12154 "EHLO
	mgw-ext13.nokia.com") by vger.kernel.org with ESMTP id S933600AbWKQNST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:18:19 -0500
Message-ID: <455DB297.1040009@indt.org.br>
Date: Fri, 17 Nov 2006 09:01:11 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: [patch 1/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Content-Type: multipart/mixed;
 boundary="------------030707080506050802070005"
X-OriginalArrivalTime: 17 Nov 2006 12:57:23.0861 (UTC) FILETIME=[ED019C50:01C70A47]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030707080506050802070005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

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
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-14 08:46:54.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-14 09:06:39.000000000 -0400
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
--- linux-omap-2.6.git.orig/include/linux/mmc/card.h	2006-11-14 08:46:54.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/card.h	2006-11-14 09:06:39.000000000 -0400
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
+#define mmc_card_clear_locked(c)	((c)->state &= ~MMC_STATE_LOCKED)
+
+#define mmc_card_lockable(c)    (((c)->csd.cmdclass & CCC_LOCK_CARD) && \
+				((c)->host->caps & MMC_CAP_LOCK_UNLOCK) && \
+				((c)->host->caps & MMC_CAP_BYTEBLOCK))

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
--- linux-omap-2.6.git.orig/include/linux/mmc/host.h	2006-11-14 08:46:54.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/host.h	2006-11-14 09:06:39.000000000 -0400
@@ -87,6 +87,7 @@ struct mmc_host {
  #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
  #define MMC_CAP_MULTIWRITE	(1 << 1)	/* Can accurately report bytes sent to card on error */
  #define MMC_CAP_BYTEBLOCK	(1 << 2)	/* Can do non-log2 block sizes */
+#define MMC_CAP_LOCK_UNLOCK	(1 << 3)	/* Host password support capability */

  	/* host specific block data */
  	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
Index: linux-omap-2.6.git/drivers/mmc/mmc.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.c	2006-11-14 08:46:54.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.c	2006-11-14 09:06:39.000000000 -0400
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

--------------030707080506050802070005
Content-Type: text/x-patch;
 name="mmc_ignore_locked.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_ignore_locked.diff"

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
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-14 08:46:54.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-14 09:06:39.000000000 -0400
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
--- linux-omap-2.6.git.orig/include/linux/mmc/card.h	2006-11-14 08:46:54.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/card.h	2006-11-14 09:06:39.000000000 -0400
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
+#define mmc_card_clear_locked(c)	((c)->state &= ~MMC_STATE_LOCKED)
+
+#define mmc_card_lockable(c)    (((c)->csd.cmdclass & CCC_LOCK_CARD) && \
+				((c)->host->caps & MMC_CAP_LOCK_UNLOCK) && \
+				((c)->host->caps & MMC_CAP_BYTEBLOCK))
 
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
--- linux-omap-2.6.git.orig/include/linux/mmc/host.h	2006-11-14 08:46:54.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/host.h	2006-11-14 09:06:39.000000000 -0400
@@ -87,6 +87,7 @@ struct mmc_host {
 #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
 #define MMC_CAP_MULTIWRITE	(1 << 1)	/* Can accurately report bytes sent to card on error */
 #define MMC_CAP_BYTEBLOCK	(1 << 2)	/* Can do non-log2 block sizes */
+#define MMC_CAP_LOCK_UNLOCK	(1 << 3)	/* Host password support capability */
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
Index: linux-omap-2.6.git/drivers/mmc/mmc.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.c	2006-11-14 08:46:54.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.c	2006-11-14 09:06:39.000000000 -0400
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
 

--------------030707080506050802070005--
