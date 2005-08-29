Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVH2LQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVH2LQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 07:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVH2LQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 07:16:04 -0400
Received: from [85.8.12.41] ([85.8.12.41]:4760 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751081AbVH2LQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 07:16:03 -0400
Message-ID: <4312EE38.6050600@drzeus.cx>
Date: Mon, 29 Aug 2005 13:15:04 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-16825-1125314161-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] support for mmc chip select in wbsd
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-16825-1125314161-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Use the chip select ios in the wbsd driver.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-16825-1125314161-0001-2
Content-Type: text/x-patch; name="wbsd-cs.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-cs.patch"

Index: linux/drivers/mmc/wbsd.c
===================================================================
--- linux/drivers/mmc/wbsd.c	(revision 161)
+++ linux/drivers/mmc/wbsd.c	(working copy)
@@ -42,7 +42,7 @@
 #include "wbsd.h"
 
 #define DRIVER_NAME "wbsd"
-#define DRIVER_VERSION "1.3"
+#define DRIVER_VERSION "1.4"
 
 #ifdef CONFIG_MMC_DEBUG
 #define DBG(x...) \
@@ -960,8 +960,9 @@
 	struct wbsd_host* host = mmc_priv(mmc);
 	u8 clk, setup, pwr;
 	
-	DBGF("clock %uHz busmode %u powermode %u Vdd %u\n",
-		ios->clock, ios->bus_mode, ios->power_mode, ios->vdd);
+	DBGF("clock %uHz busmode %u powermode %u cs %u Vdd %u\n",
+		ios->clock, ios->bus_mode, ios->power_mode, ios->chip_select,
+		ios->vdd);
 
 	spin_lock_bh(&host->lock);
 
@@ -1003,13 +1004,11 @@
 
 	/*
 	 * MMC cards need to have pin 1 high during init.
-	 * Init time corresponds rather nicely with the bus mode.
 	 * It wreaks havoc with the card detection though so
-	 * that needs to be disabed.
+	 * that needs to be disabled.
 	 */
 	setup = wbsd_read_index(host, WBSD_IDX_SETUP);
-	if ((ios->power_mode == MMC_POWER_ON) &&
-		(ios->bus_mode == MMC_BUSMODE_OPENDRAIN))
+	if (ios->chip_select == MMC_CS_HIGH)
 	{
 		setup |= WBSD_DAT3_H;
 		host->flags |= WBSD_FIGNORE_DETECT;
@@ -1017,7 +1016,12 @@
 	else
 	{
 		setup &= ~WBSD_DAT3_H;
-		host->flags &= ~WBSD_FIGNORE_DETECT;
+
+		/*
+		 * We cannot resume card detection immediatly
+		 * because of capacitance and delays in the chip.
+		 */
+		mod_timer(&host->ignore_timer, jiffies + HZ/100);
 	}
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
 	
@@ -1036,6 +1040,31 @@
 \*****************************************************************************/
 
 /*
+ * Helper function to reset detection ignore
+ */
+
+static void wbsd_reset_ignore(unsigned long data)
+{
+	struct wbsd_host *host = (struct wbsd_host*)data;
+
+	BUG_ON(host == NULL);
+
+	DBG("Resetting card detection ignore\n");
+
+	spin_lock_bh(&host->lock);
+
+	host->flags &= ~WBSD_FIGNORE_DETECT;
+
+	/*
+	 * Card status might have changed during the
+	 * blackout.
+	 */
+	tasklet_schedule(&host->card_tasklet);
+
+	spin_unlock_bh(&host->lock);
+}
+
+/*
  * Helper function for card detection
  */
 static void wbsd_detect_card(unsigned long data)
@@ -1097,7 +1126,7 @@
 			 * Delay card detection to allow electrical connections
 			 * to stabilise.
 			 */
-			mod_timer(&host->timer, jiffies + HZ/2);
+			mod_timer(&host->detect_timer, jiffies + HZ/2);
 		}
 		
 		spin_unlock(&host->lock);
@@ -1124,6 +1153,8 @@
 
 		mmc_detect_change(host->mmc);
 	}
+	else
+		spin_unlock(&host->lock);
 }
 
 static void wbsd_tasklet_fifo(unsigned long param)
@@ -1328,11 +1359,15 @@
 	spin_lock_init(&host->lock);
 	
 	/*
-	 * Set up detection timer
+	 * Set up timers
 	 */
-	init_timer(&host->timer);
-	host->timer.data = (unsigned long)host;
-	host->timer.function = wbsd_detect_card;
+	init_timer(&host->detect_timer);
+	host->detect_timer.data = (unsigned long)host;
+	host->detect_timer.function = wbsd_detect_card;
+
+	init_timer(&host->ignore_timer);
+	host->ignore_timer.data = (unsigned long)host;
+	host->ignore_timer.function = wbsd_reset_ignore;
 	
 	/*
 	 * Maximum number of segments. Worst case is one sector per segment
@@ -1370,7 +1405,8 @@
 	host = mmc_priv(mmc);
 	BUG_ON(host == NULL);
 	
-	del_timer_sync(&host->timer);
+	del_timer_sync(&host->ignore_timer);
+	del_timer_sync(&host->detect_timer);
 	
 	mmc_free_host(mmc);
 	
Index: linux/drivers/mmc/wbsd.h
===================================================================
--- linux/drivers/mmc/wbsd.h	(revision 161)
+++ linux/drivers/mmc/wbsd.h	(working copy)
@@ -181,5 +181,6 @@
 	struct tasklet_struct	finish_tasklet;
 	struct tasklet_struct	block_tasklet;
 	
-	struct timer_list	timer;		/* Card detection timer */
+	struct timer_list	detect_timer;	/* Card detection timer */
+	struct timer_list	ignore_timer;	/* Ignore detection timer */
 };

--=_hermes.drzeus.cx-16825-1125314161-0001-2--
