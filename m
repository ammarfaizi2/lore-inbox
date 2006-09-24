Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWIXWzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWIXWzO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWIXWzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:55:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:33691 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932105AbWIXWzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:55:12 -0400
X-Authenticated: #704063
Subject: [Patch] Remove unnecessary check in drivers/net/depca.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: davies@maniac.ultranet.com
Content-Type: text/plain
Date: Mon, 25 Sep 2006 00:55:08 +0200
Message-Id: <1159138508.9062.14.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity (cid #793). All callers dereference dev before
calling this functions, and we dereference it earlier in the function,
when initializing lp.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git3/drivers/net/depca.c.orig	2006-09-24 22:13:07.000000000 +0200
+++ linux-2.6.18-git3/drivers/net/depca.c	2006-09-24 22:17:40.000000000 +0200
@@ -1252,24 +1252,22 @@ static void set_multicast_list(struct ne
 	struct depca_private *lp = (struct depca_private *) dev->priv;
 	u_long ioaddr = dev->base_addr;
 
-	if (dev) {
-		netif_stop_queue(dev);
-		while (lp->tx_old != lp->tx_new);	/* Wait for the ring to empty */
+	netif_stop_queue(dev);
+	while (lp->tx_old != lp->tx_new);	/* Wait for the ring to empty */
 
-		STOP_DEPCA;	/* Temporarily stop the depca.  */
-		depca_init_ring(dev);	/* Initialize the descriptor rings */
-
-		if (dev->flags & IFF_PROMISC) {	/* Set promiscuous mode */
-			lp->init_block.mode |= PROM;
-		} else {
-			SetMulticastFilter(dev);
-			lp->init_block.mode &= ~PROM;	/* Unset promiscuous mode */
-		}
+	STOP_DEPCA;	/* Temporarily stop the depca.  */
+	depca_init_ring(dev);	/* Initialize the descriptor rings */
 
-		LoadCSRs(dev);	/* Reload CSR3 */
-		InitRestartDepca(dev);	/* Resume normal operation. */
-		netif_start_queue(dev);	/* Unlock the TX ring */
+	if (dev->flags & IFF_PROMISC) {	/* Set promiscuous mode */
+		lp->init_block.mode |= PROM;
+	} else {
+		SetMulticastFilter(dev);
+		lp->init_block.mode &= ~PROM;	/* Unset promiscuous mode */
 	}
+
+	LoadCSRs(dev);	/* Reload CSR3 */
+	InitRestartDepca(dev);	/* Resume normal operation. */
+	netif_start_queue(dev);	/* Unlock the TX ring */
 }
 
 /*


