Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWFURow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWFURow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWFURov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:44:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43688 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932294AbWFURov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:44:51 -0400
Subject: PATCH: Re: Memory corruption in 8390.c ? (and hp100 xirc2ps
	smc9194 ....)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, netdev@oss.sgi.com
In-Reply-To: <87mzc65soy.fsf@benpfaff.org>
References: <1150907317.8320.0.camel@alice>
	 <1150909982.15275.100.camel@localhost.localdomain>
	 <87mzc65soy.fsf@benpfaff.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 18:59:40 +0100
Message-Id: <1150912780.15275.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok this is my first pass at fixing all the reported cases.

8390 reverts to the faster pre 2.6.9 solution
HP100 moves the padto to a point after the fail cases
Ditto xirc2ps
Ditto smc9194
Orinoco was a mess, someone long ago managed to merge both the skb_padto
fix and the proper faster fix. The result worked (minus this newly
noticed problem) but was not neccessary. Removed the padto stuff
Wavelan uses the ETH_ZLEN sized buffer trick

The trickiest one is skge. For that I've grabbed an extra reference to
the original buffer and used that to keep the right things alive. Not
sure if it is the best way or the right way to play with refcounts.
Could do with more review.

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/8390.c linux-2.6.17/drivers/net/8390.c
--- linux.vanilla-2.6.17/drivers/net/8390.c	2006-06-19 17:17:32.000000000 +0100
+++ linux-2.6.17/drivers/net/8390.c	2006-06-21 17:41:12.007145384 +0100
@@ -275,12 +275,14 @@
 	struct ei_device *ei_local = (struct ei_device *) netdev_priv(dev);
 	int send_length = skb->len, output_page;
 	unsigned long flags;
+	char buf[ETH_ZLEN];
+	char *data = skb->data;
 
 	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
+		memset(buf, 0, ETH_ZLEN);	/* more efficient than doing just the needed bits */
+		memcpy(buf, data, ETH_ZLEN);
 		send_length = ETH_ZLEN;
+		data = buf;
 	}
 
 	/* Mask interrupts from the ethercard. 
@@ -347,7 +349,7 @@
 	 * trigger the send later, upon receiving a Tx done interrupt.
 	 */
 	 
-	ei_block_output(dev, send_length, skb->data, output_page);
+	ei_block_output(dev, send_length, data, output_page);
 		
 	if (! ei_local->txing) 
 	{
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/hp100.c linux-2.6.17/drivers/net/hp100.c
--- linux.vanilla-2.6.17/drivers/net/hp100.c	2006-06-19 17:29:46.000000000 +0100
+++ linux-2.6.17/drivers/net/hp100.c	2006-06-21 17:52:01.211451328 +0100
@@ -1484,14 +1484,6 @@
 		return 0;
 	}
 
-	if (skb->len <= 0)
-		return 0;
-		
-	if (skb->len < ETH_ZLEN && lp->chip == HP100_CHIPID_SHASTA) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
-	}
 
 	/* Get Tx ring tail pointer */
 	if (lp->txrtail->next == lp->txrhead) {
@@ -1557,6 +1549,11 @@
 	ringptr->pdl[0] = ((1 << 16) | i);	/* PDH: 1 Fragment & length */
 	if (lp->chip == HP100_CHIPID_SHASTA) {
 		/* TODO:Could someone who has the EISA card please check if this works? */
+		if (skb->len < ETH_ZLEN) {
+			skb = skb_padto(skb, ETH_ZLEN);
+                	if (skb == NULL)
+				return 0;
+		}
 		ringptr->pdl[2] = i;
 	} else {		/* Lassen */
 		/* In the PDL, don't use the padded size but the real packet size: */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/pcmcia/xirc2ps_cs.c linux-2.6.17/drivers/net/pcmcia/xirc2ps_cs.c
--- linux.vanilla-2.6.17/drivers/net/pcmcia/xirc2ps_cs.c	2006-06-19 17:29:46.000000000 +0100
+++ linux-2.6.17/drivers/net/pcmcia/xirc2ps_cs.c	2006-06-21 18:12:50.291562288 +0100
@@ -1359,27 +1359,11 @@
     kio_addr_t ioaddr = dev->base_addr;
     int okay;
     unsigned freespace;
-    unsigned pktlen = skb? skb->len : 0;
+    unsigned pktlen = max_t(unsigned, skb->len, ETH_ZLEN);
 
     DEBUG(1, "do_start_xmit(skb=%p, dev=%p) len=%u\n",
 	  skb, dev, pktlen);
 
-
-    /* adjust the packet length to min. required
-     * and hope that the buffer is large enough
-     * to provide some random data.
-     * fixme: For Mohawk we can change this by sending
-     * a larger packetlen than we actually have; the chip will
-     * pad this in his buffer with random bytes
-     */
-    if (pktlen < ETH_ZLEN)
-    {
-        skb = skb_padto(skb, ETH_ZLEN);
-        if (skb == NULL)
-        	return 0;
-	pktlen = ETH_ZLEN;
-    }
-
     netif_stop_queue(dev);
     SelectPage(0);
     PutWord(XIRCREG0_TRS, (u_short)pktlen+2);
@@ -1393,6 +1377,19 @@
     if (!okay) { /* not enough space */
 	return 1;  /* upper layer may decide to requeue this packet */
     }
+    /* adjust the packet length to min. required
+     * and hope that the buffer is large enough
+     * to provide some random data.
+     * fixme: For Mohawk we can change this by sending
+     * a larger packetlen than we actually have; the chip will
+     * pad this in his buffer with random bytes
+     */
+    if (skb->len < ETH_ZLEN)
+    {
+        skb = skb_padto(skb, ETH_ZLEN);
+        if (skb == NULL)
+        	return 0;
+    }
     /* send the packet */
     PutWord(XIRCREG_EDP, (u_short)pktlen);
     outsw(ioaddr+XIRCREG_EDP, skb->data, pktlen>>1);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/sis190.c linux-2.6.17/drivers/net/sis190.c
--- linux.vanilla-2.6.17/drivers/net/sis190.c	2006-06-19 17:29:46.000000000 +0100
+++ linux-2.6.17/drivers/net/sis190.c	2006-06-21 17:46:47.975070496 +0100
@@ -1155,17 +1155,6 @@
 	struct TxDesc *desc;
 	dma_addr_t mapping;
 
-	if (unlikely(skb->len < ETH_ZLEN)) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (!skb) {
-			tp->stats.tx_dropped++;
-			goto out;
-		}
-		len = ETH_ZLEN;
-	} else {
-		len = skb->len;
-	}
-
 	entry = tp->cur_tx % NUM_TX_DESC;
 	desc = tp->TxDescRing + entry;
 
@@ -1177,6 +1166,17 @@
 		return NETDEV_TX_BUSY;
 	}
 
+	if (unlikely(skb->len < ETH_ZLEN)) {
+		skb = skb_padto(skb, ETH_ZLEN);
+		if (!skb) {
+			tp->stats.tx_dropped++;
+			goto out;
+		}
+		len = ETH_ZLEN;
+	} else {
+		len = skb->len;
+	}
+
 	mapping = pci_map_single(tp->pci_dev, skb->data, len, PCI_DMA_TODEVICE);
 
 	tp->Tx_skbuff[entry] = skb;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/skge.c linux-2.6.17/drivers/net/skge.c
--- linux.vanilla-2.6.17/drivers/net/skge.c	2006-06-19 17:29:47.000000000 +0100
+++ linux-2.6.17/drivers/net/skge.c	2006-06-21 18:20:10.785597016 +0100
@@ -2298,23 +2298,28 @@
 		+ (ring->to_clean - ring->to_use) - 1;
 }
 
-static int skge_xmit_frame(struct sk_buff *skb, struct net_device *dev)
+static int skge_xmit_frame(struct sk_buff *tx_skb, struct net_device *dev)
 {
 	struct skge_port *skge = netdev_priv(dev);
 	struct skge_hw *hw = skge->hw;
 	struct skge_ring *ring = &skge->tx_ring;
 	struct skge_element *e;
 	struct skge_tx_desc *td;
+	struct sk_buff *skb;
 	int i;
 	u32 control, len;
 	u64 map;
 
-	skb = skb_padto(skb, ETH_ZLEN);
-	if (!skb)
+	skb_get(tx_skb);
+	skb = skb_padto(tx_skb, ETH_ZLEN);
+	if (!skb) {
+		dev_kfree_skb(tx_skb);
 		return NETDEV_TX_OK;
+	}
 
 	if (!spin_trylock(&skge->tx_lock)) {
 		/* Collision - tell upper layer to requeue */
+		kfree(skb);
 		return NETDEV_TX_LOCKED;
 	}
 
@@ -2326,6 +2331,7 @@
 			       dev->name);
 		}
 		spin_unlock(&skge->tx_lock);
+		kfree(skb);
 		return NETDEV_TX_BUSY;
 	}
 
@@ -2403,6 +2409,8 @@
 	spin_unlock(&skge->tx_lock);
 
 	dev->trans_start = jiffies;
+	/* Drop the reference, the completion handler will drop the final one */
+	kfree_skb(tx_skb);
 
 	return NETDEV_TX_OK;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/smc9194.c linux-2.6.17/drivers/net/smc9194.c
--- linux.vanilla-2.6.17/drivers/net/smc9194.c	2006-06-19 17:17:33.000000000 +0100
+++ linux-2.6.17/drivers/net/smc9194.c	2006-06-21 17:57:57.604271384 +0100
@@ -520,17 +520,8 @@
 	}
 	lp->saved_skb = skb;
 
-	length = skb->len;
+	length = max(skb->len, ETH_ZLEN);
 
-	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL) {
-			netif_wake_queue(dev);
-			return 0;
-		}
-		length = ETH_ZLEN;
-	}
-		
 	/*
 	** The MMU wants the number of pages to be the number of 256 bytes
 	** 'pages', minus 1 ( since a packet can't ever have 0 pages :) )
@@ -616,7 +607,7 @@
 	struct smc_local *lp = netdev_priv(dev);
 	byte	 		packet_no;
 	struct sk_buff * 	skb = lp->saved_skb;
-	word			length;
+	word			length, data_length;
 	unsigned int		ioaddr;
 	byte			* buf;
 
@@ -626,7 +617,16 @@
 		PRINTK((CARDNAME": In XMIT with no packet to send \n"));
 		return;
 	}
-	length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
+
+	if (length < ETH_ZLEN) {
+		skb = skb_padto(skb, ETH_ZLEN);
+		if (skb == NULL) {
+			lp->saved_skb = NULL;
+			netif_wake_queue(dev);
+			return;
+		}
+		length = ETH_ZLEN;
+	}
 	buf = skb->data;
 
 	/* If I get here, I _know_ there is a packet slot waiting for me */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/wireless/orinoco.c linux-2.6.17/drivers/net/wireless/orinoco.c
--- linux.vanilla-2.6.17/drivers/net/wireless/orinoco.c	2006-06-19 17:29:48.000000000 +0100
+++ linux-2.6.17/drivers/net/wireless/orinoco.c	2006-06-21 18:19:02.849924808 +0100
@@ -491,11 +491,8 @@
 	}
 
 	/* Length of the packet body */
-	/* FIXME: what if the skb is smaller than this? */
+	/* A shorter data_len will be padded by hermes_bap_pwrite_pad */
 	len = max_t(int, ALIGN(skb->len, 2), ETH_ZLEN);
-	skb = skb_padto(skb, len);
-	if (skb == NULL)
-		goto fail;
 	len -= ETH_HLEN;
 
 	eh = (struct ethhdr *)skb->data;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/wireless/wavelan.c linux-2.6.17/drivers/net/wireless/wavelan.c
--- linux.vanilla-2.6.17/drivers/net/wireless/wavelan.c	2006-06-19 17:29:48.000000000 +0100
+++ linux-2.6.17/drivers/net/wireless/wavelan.c	2006-06-21 18:16:01.599479064 +0100
@@ -2903,6 +2903,7 @@
 {
 	net_local *lp = (net_local *) dev->priv;
 	unsigned long flags;
+	char data[ETH_ZLEN];
 
 #ifdef DEBUG_TX_TRACE
 	printk(KERN_DEBUG "%s: ->wavelan_packet_xmit(0x%X)\n", dev->name,
@@ -2937,15 +2938,16 @@
 	 * able to detect collisions, therefore in theory we don't really
 	 * need to pad. Jean II */
 	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
+		memset(data, 0, ETH_ZLEN);
+		memcpy(data, skb->data, skb->len);
+		/* Write packet on the card */
+		if(wv_packet_write(dev, data, ETH_ZLEN))
+			return 1;	/* We failed */
 	}
-
-	/* Write packet on the card */
-	if(wv_packet_write(dev, skb->data, skb->len))
+	else if(wv_packet_write(dev, skb->data, skb->len))
 		return 1;	/* We failed */
 
+
 	dev_kfree_skb(skb);
 
 #ifdef DEBUG_TX_TRACE

