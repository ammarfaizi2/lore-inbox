Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVIKUhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVIKUhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVIKUhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 16:37:09 -0400
Received: from [85.8.12.41] ([85.8.12.41]:4482 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750852AbVIKUhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 16:37:08 -0400
Message-ID: <43249572.7030407@drzeus.cx>
Date: Sun, 11 Sep 2005 22:37:06 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove wbsd delayed detection.
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the card detection delay framework since it can be done
natively in the MMC layer.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |   28 +++++-----------------------
 drivers/mmc/wbsd.h |    1 -
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1112,20 +1112,6 @@ static void wbsd_reset_ignore(unsigned l
 }

 /*
- * Helper function for card detection
- */
-static void wbsd_detect_card(unsigned long data)
-{
-	struct wbsd_host *host = (struct wbsd_host*)data;
-
-	BUG_ON(host == NULL);
-
-	DBG("Executing card detection\n");
-
-	mmc_detect_change(host->mmc, 0);
-}
-
-/*
  * Tasklets
  */

@@ -1169,14 +1155,15 @@ static void wbsd_tasklet_card(unsigned l
 			DBG("Card inserted\n");
 			host->flags |= WBSD_FCARD_PRESENT;

+			spin_unlock(&host->lock);
 			/*
 			 * Delay card detection to allow electrical connections
 			 * to stabilise.
 			 */
-			mod_timer(&host->detect_timer, jiffies + HZ/2);
+			mmc_detect_change(host->mmc, msecs_to_jiffies(500));
 		}
-
-		spin_unlock(&host->lock);
+		else
+			spin_unlock(&host->lock);
 	}
 	else if (host->flags & WBSD_FCARD_PRESENT)
 	{
@@ -1407,12 +1394,8 @@ static int __devinit wbsd_alloc_mmc(stru
 	spin_lock_init(&host->lock);

 	/*
-	 * Set up timers
+	 * Set up timer
 	 */
-	init_timer(&host->detect_timer);
-	host->detect_timer.data = (unsigned long)host;
-	host->detect_timer.function = wbsd_detect_card;
-
 	init_timer(&host->ignore_timer);
 	host->ignore_timer.data = (unsigned long)host;
 	host->ignore_timer.function = wbsd_reset_ignore;
@@ -1454,7 +1437,6 @@ static void __devexit wbsd_free_mmc(stru
 	BUG_ON(host == NULL);

 	del_timer_sync(&host->ignore_timer);
-	del_timer_sync(&host->detect_timer);

 	mmc_free_host(mmc);

diff --git a/drivers/mmc/wbsd.h b/drivers/mmc/wbsd.h
--- a/drivers/mmc/wbsd.h
+++ b/drivers/mmc/wbsd.h
@@ -184,6 +184,5 @@ struct wbsd_host
 	struct tasklet_struct	finish_tasklet;
 	struct tasklet_struct	block_tasklet;

-	struct timer_list	detect_timer;	/* Card detection timer */
 	struct timer_list	ignore_timer;	/* Ignore detection timer */
 };
