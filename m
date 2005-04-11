Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVDKVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVDKVNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVDKVNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:13:39 -0400
Received: from mail.dif.dk ([193.138.115.101]:42442 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261938AbVDKVND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:13:03 -0400
Date: Mon, 11 Apr 2005 23:15:40 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Laurence Culhane <loz@holmes.demon.co.uk>,
       "Fred N. van Kempen" <waltje@uwalt.nl.mugnet.org>, netdev@oss.sgi.com
Subject: [PATCH] net: remove redundant NULL pointer checks prior to kfree in
 drivers/net/slip.c
Message-ID: <Pine.LNX.4.62.0504112311130.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() checks for NULL. Checking prior to calling it is redundant.
This patch removes these redundant checks from drivers/net/slip.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 slip.c |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/drivers/net/slip.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/net/slip.c	2005-04-11 23:10:06.000000000 +0200
@@ -185,15 +185,12 @@ sl_alloc_bufs(struct slip *sl, int mtu)
 	/* Cleanup */
 err_exit:
 #ifdef SL_INCLUDE_CSLIP
-	if (cbuff)
-		kfree(cbuff);
+	kfree(cbuff);
 	if (slcomp)
 		slhc_free(slcomp);
 #endif
-	if (xbuff)
-		kfree(xbuff);
-	if (rbuff)
-		kfree(rbuff);
+	kfree(xbuff);
+	kfree(rbuff);
 	return err;
 }
 
@@ -204,13 +201,13 @@ sl_free_bufs(struct slip *sl)
 	void * tmp;
 
 	/* Free all SLIP frame buffers. */
-	if ((tmp = xchg(&sl->rbuff, NULL)) != NULL)
-		kfree(tmp);
-	if ((tmp = xchg(&sl->xbuff, NULL)) != NULL)
-		kfree(tmp);
+	tmp = xchg(&sl->rbuff, NULL);
+	kfree(tmp);
+	tmp = xchg(&sl->xbuff, NULL);
+	kfree(tmp);
 #ifdef SL_INCLUDE_CSLIP
-	if ((tmp = xchg(&sl->cbuff, NULL)) != NULL)
-		kfree(tmp);
+	tmp = xchg(&sl->cbuff, NULL);
+	kfree(tmp);
 	if ((tmp = xchg(&sl->slcomp, NULL)) != NULL)
 		slhc_free(tmp);
 #endif
@@ -297,13 +294,10 @@ done_on_bh:
 	spin_unlock_bh(&sl->lock);
 
 done:
-	if (xbuff)
-		kfree(xbuff);
-	if (rbuff)
-		kfree(rbuff);
+	kfree(xbuff);
+	kfree(rbuff);
 #ifdef SL_INCLUDE_CSLIP
-	if (cbuff)
-		kfree(cbuff);
+	kfree(cbuff);
 #endif
 	return err;
 }


