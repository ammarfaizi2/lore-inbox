Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWJJVIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWJJVIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWJJVIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:08:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:36038 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030397AbWJJVIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:08:49 -0400
Date: Tue, 10 Oct 2006 16:08:42 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 11/21]: powerpc/cell spidernet stop error printing patch.
Message-ID: <20061010210842.GH4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Turn off mis-interpretation of the queue-empty interrupt
status bit as an error. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:58:08.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:01:06.000000000 -0500
@@ -1245,12 +1245,15 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_PHYINT:
 	case SPIDER_NET_GMAC2INT:
 	case SPIDER_NET_GMAC1INT:
-	case SPIDER_NET_GIPSINT:
 	case SPIDER_NET_GFIFOINT:
 	case SPIDER_NET_DMACINT:
 	case SPIDER_NET_GSYSINT:
 		break; */
 
+	case SPIDER_NET_GIPSINT:
+		show_error = 0;
+		break;
+
 	case SPIDER_NET_GPWOPCMPINT:
 		/* PHY write operation completed */
 		show_error = 0;
@@ -1309,9 +1312,10 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GDTDCEINT:
 		/* chain end. If a descriptor should be sent, kick off
 		 * tx dma
-		if (card->tx_chain.tail == card->tx_chain.head)
+		if (card->tx_chain.tail != card->tx_chain.head)
 			spider_net_kick_tx_dma(card);
-		show_error = 0; */
+		*/
+		show_error = 0;
 		break;
 
 	/* case SPIDER_NET_G1TMCNTINT: not used. print a message */
@@ -1425,8 +1429,9 @@ spider_net_handle_error_irq(struct spide
 	}
 
 	if ((show_error) && (netif_msg_intr(card)))
-		pr_err("Got error interrupt, GHIINT0STS = 0x%08x, "
+		pr_err("Got error interrupt on %s, GHIINT0STS = 0x%08x, "
 		       "GHIINT1STS = 0x%08x, GHIINT2STS = 0x%08x\n",
+		       card->netdev->name,
 		       status_reg, error_reg1, error_reg2);
 
 	/* clear interrupt sources */
