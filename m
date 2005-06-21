Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVFUIWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVFUIWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVFUIUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:20:43 -0400
Received: from [85.8.12.41] ([85.8.12.41]:1720 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261765AbVFUHqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:46:34 -0400
Message-ID: <42B7C5BA.8000108@drzeus.cx>
Date: Tue, 21 Jun 2005 09:46:02 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-17218-1119339993-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] wbsd delayed insertion
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-17218-1119339993-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Wait 0.5 seconds before scanning for cards after an insertion interrupt.
The electrical connection needs this time to stabilise for some cards.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>


--=_hermes.drzeus.cx-17218-1119339993-0001-2
Content-Type: text/x-patch; name="wbsd-delay.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-delay.patch"

Index: linux-wbsd/drivers/mmc/wbsd.c
===================================================================
--- linux-wbsd/drivers/mmc/wbsd.c	(revision 147)
+++ linux-wbsd/drivers/mmc/wbsd.c	(working copy)
@@ -1099,6 +1099,20 @@
 \*****************************************************************************/
 
 /*
+ * Helper function for card detection
+ */
+static void wbsd_detect_card(unsigned long data)
+{
+	struct wbsd_host *host = (struct wbsd_host*)data;
+	
+	BUG_ON(host == NULL);
+	
+	DBG("Executing card detection\n");
+	
+	mmc_detect_change(host->mmc);	
+}
+
+/*
  * Tasklets
  */
 
@@ -1123,7 +1137,6 @@
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	u8 csr;
-	int change = 0;
 	
 	spin_lock(&host->lock);
 	
@@ -1142,14 +1155,20 @@
 		{
 			DBG("Card inserted\n");
 			host->flags |= WBSD_FCARD_PRESENT;
-			change = 1;
+			
+			/*
+			 * Delay card detection to allow electrical connections
+			 * to stabilise.
+			 */
+			mod_timer(&host->timer, jiffies + HZ/2);
 		}
+		
+		spin_unlock(&host->lock);
 	}
 	else if (host->flags & WBSD_FCARD_PRESENT)
 	{
 		DBG("Card removed\n");
 		host->flags &= ~WBSD_FCARD_PRESENT;
-		change = 1;
 		
 		if (host->mrq)
 		{
@@ -1160,15 +1179,14 @@
 			host->mrq->cmd->error = MMC_ERR_FAILED;
 			tasklet_schedule(&host->finish_tasklet);
 		}
-	}
-	
-	/*
-	 * Unlock first since we might get a call back.
-	 */
-	spin_unlock(&host->lock);
+		
+		/*
+		 * Unlock first since we might get a call back.
+		 */
+		spin_unlock(&host->lock);
 
-	if (change)
 		mmc_detect_change(host->mmc);
+	}
 }
 
 static void wbsd_tasklet_fifo(unsigned long param)
@@ -1374,6 +1392,13 @@
 	spin_lock_init(&host->lock);
 	
 	/*
+	 * Set up detection timer
+	 */
+	init_timer(&host->timer);
+	host->timer.data = (unsigned long)host;
+	host->timer.function = wbsd_detect_card;
+	
+	/*
 	 * Maximum number of segments. Worst case is one sector per segment
 	 * so this will be 64kB/512.
 	 */
@@ -1400,11 +1425,17 @@
 static void __devexit wbsd_free_mmc(struct device* dev)
 {
 	struct mmc_host* mmc;
+	struct wbsd_host* host;
 	
 	mmc = dev_get_drvdata(dev);
 	if (!mmc)
 		return;
 	
+	host = mmc_priv(mmc);
+	BUG_ON(host == NULL);
+	
+	del_timer_sync(&host->timer);
+	
 	mmc_free_host(mmc);
 	
 	dev_set_drvdata(dev, NULL);
Index: linux-wbsd/drivers/mmc/wbsd.h
===================================================================
--- linux-wbsd/drivers/mmc/wbsd.h	(revision 147)
+++ linux-wbsd/drivers/mmc/wbsd.h	(working copy)
@@ -190,4 +190,6 @@
 	struct tasklet_struct	timeout_tasklet;
 	struct tasklet_struct	finish_tasklet;
 	struct tasklet_struct	block_tasklet;
+	
+	struct timer_list	timer;		/* Card detection timer */
 };

--=_hermes.drzeus.cx-17218-1119339993-0001-2--
