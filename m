Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWDUXpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWDUXpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWDUXpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:45:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:28296 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750770AbWDUXpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:45:53 -0400
Date: Fri, 21 Apr 2006 18:45:51 -0500
To: utz.bacher@de.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Maxim Shchetynin <maxim@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2]: Spider ethernet driver -- protect chain head
Message-ID: <20060421234551.GI7242@austin.ibm.com>
References: <20060421232942.GG7242@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421232942.GG7242@austin.ibm.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please review/apply/ack/forward upstream.

--linas


Prevent a potential race. If two threads are both calling
the transmit routine, both can potentially try to grab the
same dma descriptor. Serialize access to the head of the
tx ring with spinlocks.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc1/drivers/net/spider_net.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/net/spider_net.c	2006-04-21 18:32:46.000000000 -0500
+++ linux-2.6.17-rc1/drivers/net/spider_net.c	2006-04-21 18:39:12.000000000 -0500
@@ -806,13 +806,19 @@ spider_net_stop(struct net_device *netde
 static struct spider_net_descr *
 spider_net_get_next_tx_descr(struct spider_net_card *card)
 {
+	struct spider_net_descr *descr;
+	spin_lock(&card->tx_chain_lock);
+
+	descr = card->tx_chain.head;
 	/* check, if head points to not-in-use descr */
 	if ( spider_net_get_descr_status(card->tx_chain.head) ==
 	     SPIDER_NET_DESCR_NOT_IN_USE ) {
-		return card->tx_chain.head;
+		card->tx_chain.head = descr->next;
 	} else {
-		return NULL;
+		descr = NULL;
 	}
+	spin_unlock(&card->tx_chain_lock);
+	return descr;
 }
 
 /**
@@ -932,8 +938,6 @@ spider_net_xmit(struct sk_buff *skb, str
 	if (result)
 		goto error;
 
-	card->tx_chain.head = card->tx_chain.head->next;
-
 	if (spider_net_get_descr_status(descr->prev) !=
 	    SPIDER_NET_DESCR_CARDOWNED) {
 		/* make sure the current descriptor is in memory. Then
