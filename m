Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWJJVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWJJVJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWJJVJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:09:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50919 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030403AbWJJVJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:09:45 -0400
Date: Tue, 10 Oct 2006 16:09:40 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 12/21]: powerpc/cell spidernet incorrect offset
Message-ID: <20061010210940.GI4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bugfix -- the rx chain is in memory after the tx chain -- 
the offset being used was wrong, resulting in memory corruption
when the size of the rx and tx rings weren't exactly the same.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----

 drivers/net/spider_net.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:01:06.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:03:11.000000000 -0500
@@ -1628,8 +1628,10 @@ spider_net_open(struct net_device *netde
 	if (spider_net_init_chain(card, &card->tx_chain, card->descr,
 			PCI_DMA_TODEVICE, card->tx_desc))
 		goto alloc_tx_failed;
+
+	/* rx_chain is after tx_chain, so offset is descr + tx_count */
 	if (spider_net_init_chain(card, &card->rx_chain,
-			card->descr + card->rx_desc,
+			card->descr + card->tx_desc,
 			PCI_DMA_FROMDEVICE, card->rx_desc))
 		goto alloc_rx_failed;
 
