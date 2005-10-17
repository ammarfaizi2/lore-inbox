Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVJQSVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVJQSVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVJQSVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:21:54 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:25417 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932139AbVJQSVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:21:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=daisJWXZ9styxXkOlEFMwT2fAUD1JKSMiw0d8SHzb9UBZmk3JwJUdddpdwPhwYZDScRxMh64INZNufXYcfCzQmTK6y8XSEMAdYFW8FGoNiDC1OyZeBD/kjUNWZzZGAYW/VhjQdCR5u4jvfqGUEOrKH2QUi+8ezzNaXAjQbq5vuQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Sun <asun@darksunrising.com>
Subject: [PATCH] fix warning and small bug in cassini driver
Date: Mon, 17 Oct 2005 20:24:52 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172024.53106.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
  A small patch for you :)

This patch fixes the following compile warning:
  drivers/net/cassini.c:1930: warning: long unsigned int format, different type arg (arg 4)

While fixing the warning I noticed that if USE_TX_COMPWB is not defined, then
the printk will be in sore trouble since compwb won't be around. Fixed that as
well.  Perhaps a little ugly, but better than a bug IMHO.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/net/cassini.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc4-mm1-orig/drivers/net/cassini.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4-mm1/drivers/net/cassini.c	2005-10-17 20:16:51.000000000 +0200
@@ -1925,9 +1925,14 @@ static void cas_tx(struct net_device *de
 #ifdef USE_TX_COMPWB
 	u64 compwb = le64_to_cpu(cp->init_block->tx_compwb);
 #endif
-	if (netif_msg_intr(cp))
-		printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x, %lx\n",
-			cp->dev->name, status, compwb);
+	if (netif_msg_intr(cp)) {
+		printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x",
+			cp->dev->name, status);
+#ifdef USE_TX_COMPWB
+		printk(", %llx", compwb);
+#endif
+		printk("\n");
+	}
 	/* process all the rings */
 	for (ring = 0; ring < N_TX_RINGS; ring++) {
 #ifdef USE_TX_COMPWB



