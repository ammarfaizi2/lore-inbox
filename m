Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVILOVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVILOVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVILOVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:21:30 -0400
Received: from [85.8.12.41] ([85.8.12.41]:26754 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750995AbVILOVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:21:30 -0400
Message-ID: <43258EDF.8070605@drzeus.cx>
Date: Mon, 12 Sep 2005 16:21:19 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-10729-1126534889-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up wbsd detection handling
References: <43249574.8000807@drzeus.cx> <432533A6.7010506@drzeus.cx>
In-Reply-To: <432533A6.7010506@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-10729-1126534889-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Pierre Ossman wrote:
> The wbsd driver's card detection routing is a bit of a mess. This
> patch cleans up the routine and makes it a bit more comprihensible.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> ---
> 

Resend as attachment.

--=_hermes.drzeus.cx-10729-1126534889-0001-2
Content-Type: text/x-patch; name="wbsd-detect-cleanup.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-detect-cleanup.patch"

Clean up wbsd detection handling

The wbsd driver's card detection routing is a bit of a mess. This
patch cleans up the routine and makes it a bit more comprihensible.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

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

--=_hermes.drzeus.cx-10729-1126534889-0001-2--
