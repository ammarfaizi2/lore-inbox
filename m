Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUG2PG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUG2PG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267980AbUG2PDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:03:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21756 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263980AbUG2OMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:12:38 -0400
Date: Thu, 29 Jul 2004 16:12:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jes Sorensen <jes@wildopensource.com>, Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/rrunner.c: fix inline compile error (fwd)
Message-ID: <20040729141231.GW2349@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm1.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Thu, 15 Jul 2004 22:55:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jes Sorensen <jes@wildopensource.com>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/rrunner.c: fix inline compile error

Trying to compile drivers/net/rrunner.c in 2.6.8-rc1-mm1 using gcc 3.4 
results in the following compile error:

<--  snip  -->

...
  CC      drivers/net/rrunner.o
drivers/net/rrunner.c: In function `rr_timer':
drivers/net/rrunner.h:846: sorry, unimplemented: inlining failed in call 
to 'rr_raz_tx': function body not available
drivers/net/rrunner.c:1155: sorry, unimplemented: called from here
drivers/net/rrunner.h:847: sorry, unimplemented: inlining failed in call 
to 'rr_raz_rx': function body not available
drivers/net/rrunner.c:1156: sorry, unimplemented: called from here
make[2]: *** [drivers/net/rrunner.o] Error 1

<--  snip  -->


The patch below moves some inlined functions above the place where they
are called the first time.

An alternative approach would be to remove the inlines.


diffstat output:
 drivers/net/rrunner.c |   86 +++++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 43 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/drivers/net/rrunner.c.old	2004-07-09 01:05:03.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/net/rrunner.c	2004-07-09 01:05:46.000000000 +0200
@@ -1138,6 +1138,49 @@
 	return IRQ_HANDLED;
 }
 
+static inline void rr_raz_tx(struct rr_private *rrpriv, 
+			     struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < TX_RING_ENTRIES; i++) {
+		struct sk_buff *skb = rrpriv->tx_skbuff[i];
+
+		if (skb) {
+			struct tx_desc *desc = &(rrpriv->tx_ring[i]);
+
+	        	pci_unmap_single(rrpriv->pci_dev, desc->addr.addrlo, 
+				skb->len, PCI_DMA_TODEVICE);
+			desc->size = 0;
+			set_rraddr(&desc->addr, 0);
+			dev_kfree_skb(skb);
+			rrpriv->tx_skbuff[i] = NULL;
+		}
+	}
+}
+
+
+static inline void rr_raz_rx(struct rr_private *rrpriv, 
+			     struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < RX_RING_ENTRIES; i++) {
+		struct sk_buff *skb = rrpriv->rx_skbuff[i];
+
+		if (skb) {
+			struct rx_desc *desc = &(rrpriv->rx_ring[i]);
+
+	        	pci_unmap_single(rrpriv->pci_dev, desc->addr.addrlo, 
+				dev->mtu + HIPPI_HLEN, PCI_DMA_FROMDEVICE);
+			desc->size = 0;
+			set_rraddr(&desc->addr, 0);
+			dev_kfree_skb(skb);
+			rrpriv->rx_skbuff[i] = NULL;
+		}
+	}
+}
+
 static void rr_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
@@ -1253,49 +1296,6 @@
 }
 
 
-static inline void rr_raz_tx(struct rr_private *rrpriv, 
-			     struct net_device *dev)
-{
-	int i;
-
-	for (i = 0; i < TX_RING_ENTRIES; i++) {
-		struct sk_buff *skb = rrpriv->tx_skbuff[i];
-
-		if (skb) {
-			struct tx_desc *desc = &(rrpriv->tx_ring[i]);
-
-	        	pci_unmap_single(rrpriv->pci_dev, desc->addr.addrlo, 
-				skb->len, PCI_DMA_TODEVICE);
-			desc->size = 0;
-			set_rraddr(&desc->addr, 0);
-			dev_kfree_skb(skb);
-			rrpriv->tx_skbuff[i] = NULL;
-		}
-	}
-}
-
-
-static inline void rr_raz_rx(struct rr_private *rrpriv, 
-			     struct net_device *dev)
-{
-	int i;
-
-	for (i = 0; i < RX_RING_ENTRIES; i++) {
-		struct sk_buff *skb = rrpriv->rx_skbuff[i];
-
-		if (skb) {
-			struct rx_desc *desc = &(rrpriv->rx_ring[i]);
-
-	        	pci_unmap_single(rrpriv->pci_dev, desc->addr.addrlo, 
-				dev->mtu + HIPPI_HLEN, PCI_DMA_FROMDEVICE);
-			desc->size = 0;
-			set_rraddr(&desc->addr, 0);
-			dev_kfree_skb(skb);
-			rrpriv->rx_skbuff[i] = NULL;
-		}
-	}
-}
-
 static void rr_dump(struct net_device *dev)
 {
 	struct rr_private *rrpriv;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


