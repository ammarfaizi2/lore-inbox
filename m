Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030550AbWJCVDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWJCVDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbWJCVDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:03:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2204 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030459AbWJCVDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:03:06 -0400
Date: Tue, 3 Oct 2006 16:03:04 -0500
To: akpm@osdl.org, jeff@garzik.org
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4]: Spidernet transmit interupt mitigation
Message-ID: <20061003210304.GH4381@austin.ibm.com>
References: <20061003205240.GE4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003205240.GE4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



For small packets, the transmit interrupt settings were 
accidentally generating too many interrupts. This patch
turns off all transmit-related interrupts when the tx
queue is mostly empty.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    8 +++++---
 drivers/net/spider_net.h |    7 +++----
 2 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-02 19:06:55.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-02 19:09:38.000000000 -0500
@@ -707,7 +707,9 @@ spider_net_set_low_watermark(struct spid
 		descr = descr->next;
 		cnt++;
 	}
-	if (cnt == 0)
+
+	/* If TX queue is short, don't even bother with interrupts */
+	if (cnt < tx_descriptors/4)
 		return;
 
 	/* Set low-watermark 3/4th's of the way into the queue. */
@@ -716,7 +718,7 @@ spider_net_set_low_watermark(struct spid
 	for (i=0;i<cnt; i++)
 		descr = descr->next;
 
-	/* Set the new watermark, clear the old wtermark */
+	/* Set the new watermark, clear the old watermark */
 	spin_lock_irqsave(&card->tx_chain.lock, flags);
 	descr->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
 	if (card->low_watermark && card->low_watermark != descr)
@@ -1639,7 +1641,7 @@ spider_net_enable_card(struct spider_net
 			     SPIDER_NET_INT2_MASK_VALUE);
 
 	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_GDTBSTA);
+			     SPIDER_NET_GDTBSTA | SPIDER_NET_GDTDCEIDIS);
 }
 
 /**
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-02 19:06:55.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-02 19:09:38.000000000 -0500
@@ -217,7 +217,8 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_GDTBSTA             0x00000300
 #define SPIDER_NET_GDTDCEIDIS          0x00000002
 #define SPIDER_NET_DMA_TX_VALUE        SPIDER_NET_TX_DMA_EN | \
-                                       SPIDER_NET_GDTBSTA
+                                       SPIDER_NET_GDTBSTA   | \
+                                       SPIDER_NET_GDTDCEIDIS
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
 
 /* SPIDER_NET_UA_DESCR_VALUE is OR'ed with the unicast address */
@@ -326,9 +327,7 @@ enum spider_net_int2_status {
 	SPIDER_NET_GRISPDNGINT
 };
 
-#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GTTEDINT) | \
-				  (1 << SPIDER_NET_GDTDCEINT) | \
-				  (1 << SPIDER_NET_GDTFDCINT) )
+#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) )
 
 /* we rely on flagged descriptor interrupts*/
 #define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) | \
