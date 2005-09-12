Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVILHwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVILHwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVILHwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:52:13 -0400
Received: from [85.8.12.41] ([85.8.12.41]:8834 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751213AbVILHwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:52:11 -0400
Message-ID: <432533A6.7010506@drzeus.cx>
Date: Mon, 12 Sep 2005 09:52:06 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up wbsd detection handling
References: <43249574.8000807@drzeus.cx>
In-Reply-To: <43249574.8000807@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The wbsd driver's card detection routing is a bit of a mess. This
patch cleans up the routine and makes it a bit more comprihensible.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

(updated to current tree)

 drivers/mmc/wbsd.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1136,6 +1136,7 @@ static void wbsd_tasklet_card(unsigned l
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	u8 csr;
+	int delay = -1;

 	spin_lock(&host->lock);

@@ -1155,16 +1156,8 @@ static void wbsd_tasklet_card(unsigned l
 			DBG("Card inserted\n");
 			host->flags |= WBSD_FCARD_PRESENT;

-			spin_unlock(&host->lock);
-
-			/*
-			 * Delay card detection to allow electrical connections
-			 * to stabilise.
-			 */
-			mmc_detect_change(host->mmc, msecs_to_jiffies(500));
+			delay = 500;
 		}
-		else
-			spin_unlock(&host->lock);
 	}
 	else if (host->flags & WBSD_FCARD_PRESENT)
 	{
@@ -1181,15 +1174,17 @@ static void wbsd_tasklet_card(unsigned l
 			tasklet_schedule(&host->finish_tasklet);
 		}

-		/*
-		 * Unlock first since we might get a call back.
-		 */
-		spin_unlock(&host->lock);
-
-		mmc_detect_change(host->mmc, 0);
+		delay = 0;
 	}
-	else
-		spin_unlock(&host->lock);
+
+	/*
+	 * Unlock first since we might get a call back.
+	 */
+
+	spin_unlock(&host->lock);
+
+	if (delay != -1)
+		mmc_detect_change(host->mmc, msecs_to_jiffies(delay));
 }

 static void wbsd_tasklet_fifo(unsigned long param)

