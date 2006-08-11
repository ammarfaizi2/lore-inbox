Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWHKRKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWHKRKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWHKRKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:10:48 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:36070 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750955AbWHKRKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:10:47 -0400
Date: Fri, 11 Aug 2006 12:09:44 -0500
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Cc: James K Lewis <jklewis@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Subject: [PATCH 3/4]: powerpc/cell spidernet stop error printing patch.
Message-ID: <20060811170944.GK10638@austin.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811170337.GH10638@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Turn off mis-interpretation of the queue-empty interrupt
status bit as an error. This bit is set as a part of 
the previous low-watermark patch.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.c	2006-08-11 11:23:24.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.c	2006-08-11 11:34:16.000000000 -0500
@@ -1275,12 +1275,15 @@ spider_net_handle_error_irq(struct spide
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
@@ -1339,9 +1342,10 @@ spider_net_handle_error_irq(struct spide
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
@@ -1455,8 +1459,9 @@ spider_net_handle_error_irq(struct spide
 	}
 
 	if ((show_error) && (netif_msg_intr(card)))
-		pr_err("Got error interrupt, GHIINT0STS = 0x%08x, "
+		pr_err("Got error interrupt on %s, GHIINT0STS = 0x%08x, "
 		       "GHIINT1STS = 0x%08x, GHIINT2STS = 0x%08x\n",
+		       card->netdev->name,
 		       status_reg, error_reg1, error_reg2);
 
 	/* clear interrupt sources */
