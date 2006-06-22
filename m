Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbWFVCa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbWFVCa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 22:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbWFVCa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 22:30:57 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:3598 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030533AbWFVCaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 22:30:55 -0400
Date: Thu, 22 Jun 2006 12:30:29 +1000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: snakebyte@gmx.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: Memory corruption in 8390.c ? (was Re: Possible leaks in network	drivers)
Message-ID: <20060622023029.GA6156@gondor.apana.org.au>
References: <1150909982.15275.100.camel@localhost.localdomain> <E1FtDU0-0005nd-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FtDU0-0005nd-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 10:55:44AM +1000, Herbert Xu wrote:
> 
> I think skb_padto simply shouldn't allocate a new skb.  It only needs
> to extend the data area.

OK, here is a patch to make it do that.

[NET]: Avoid allocating skb in skb_pad

First of all it is unnecessary to allocate a new skb in skb_pad since
the existing one is not shared.  More importantly, our hard_start_xmit
interface does not allow a new skb to be allocated since that breaks
requeueing.

This patch uses pskb_expand_head to expand the existing skb and linearize
it if needed.  Actually, someone should sift through every instance of
skb_pad on a non-linear skb as they do not fit the reasons why this was
originally created.

Incidentally, this fixes a minor bug when the skb is cloned (tcpdump,
TCP, etc.).  As it is skb_pad will simply write over a cloned skb.  Because
of the position of the write it is unlikely to cause problems but still
it's best if we don't do it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/drivers/net/3c527.c b/drivers/net/3c527.c
index 1b1cb00..157eda5 100644
--- a/drivers/net/3c527.c
+++ b/drivers/net/3c527.c
@@ -1031,8 +1031,7 @@ static int mc32_send_packet(struct sk_bu
 		return 1;
 	}
 
-	skb = skb_padto(skb, ETH_ZLEN);
-	if (skb == NULL) {
+	if (skb_padto(skb, ETH_ZLEN)) {
 		netif_wake_queue(dev);
 		return 0;
 	}
diff --git a/drivers/net/82596.c b/drivers/net/82596.c
index da0c878..8a9f7d6 100644
--- a/drivers/net/82596.c
+++ b/drivers/net/82596.c
@@ -1070,8 +1070,7 @@ static int i596_start_xmit(struct sk_buf
 				skb->len, (unsigned int)skb->data));
 
 	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/drivers/net/8390.c b/drivers/net/8390.c
index f870274..00abe83 100644
--- a/drivers/net/8390.c
+++ b/drivers/net/8390.c
@@ -277,8 +277,7 @@ static int ei_start_xmit(struct sk_buff 
 	unsigned long flags;
 
 	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		send_length = ETH_ZLEN;
 	}
diff --git a/drivers/net/a2065.c b/drivers/net/a2065.c
index 79bb56b..71165ac 100644
--- a/drivers/net/a2065.c
+++ b/drivers/net/a2065.c
@@ -573,8 +573,7 @@ static int lance_start_xmit (struct sk_b
 	
 	if (len < ETH_ZLEN) {
 		len = ETH_ZLEN;
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 	}
 
diff --git a/drivers/net/ariadne.c b/drivers/net/ariadne.c
index d1b6b1f..a9bb7a4 100644
--- a/drivers/net/ariadne.c
+++ b/drivers/net/ariadne.c
@@ -607,8 +607,7 @@ #endif
     /* FIXME: is the 79C960 new enough to do its own padding right ? */
     if (skb->len < ETH_ZLEN)
     {
-    	skb = skb_padto(skb, ETH_ZLEN);
-    	if (skb == NULL)
+    	if (skb_padto(skb, ETH_ZLEN))
     	    return 0;
     	len = ETH_ZLEN;
     }
diff --git a/drivers/net/arm/ether1.c b/drivers/net/arm/ether1.c
index 36475eb..312955d 100644
--- a/drivers/net/arm/ether1.c
+++ b/drivers/net/arm/ether1.c
@@ -700,8 +700,7 @@ ether1_sendpacket (struct sk_buff *skb, 
 	}
 
 	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			goto out;
 	}
 
diff --git a/drivers/net/arm/ether3.c b/drivers/net/arm/ether3.c
index f1d5b10..0810741 100644
--- a/drivers/net/arm/ether3.c
+++ b/drivers/net/arm/ether3.c
@@ -518,8 +518,7 @@ ether3_sendpacket(struct sk_buff *skb, s
 
 	length = (length + 1) & ~1;
 	if (length != skb->len) {
-		skb = skb_padto(skb, length);
-		if (skb == NULL)
+		if (skb_padto(skb, length))
 			goto out;
 	}
 
diff --git a/drivers/net/atarilance.c b/drivers/net/atarilance.c
index 442b2cb..91783a8 100644
--- a/drivers/net/atarilance.c
+++ b/drivers/net/atarilance.c
@@ -804,8 +804,7 @@ static int lance_start_xmit( struct sk_b
 		++len;
 		
 	if (len > skb->len) {
-		skb = skb_padto(skb, len);
-		if (skb == NULL)
+		if (skb_padto(skb, len))
 			return 0;
 	}
 		
diff --git a/drivers/net/cassini.c b/drivers/net/cassini.c
index 39f36aa..565a54f 100644
--- a/drivers/net/cassini.c
+++ b/drivers/net/cassini.c
@@ -2915,8 +2915,7 @@ static int cas_start_xmit(struct sk_buff
 	 */
 	static int ring; 
 
-	skb = skb_padto(skb, cp->min_frame_size);
-	if (!skb)
+	if (skb_padto(skb, cp->min_frame_size))
 		return 0;
 
 	/* XXX: we need some higher-level QoS hooks to steer packets to
diff --git a/drivers/net/declance.c b/drivers/net/declance.c
index f130bda..d3d958e 100644
--- a/drivers/net/declance.c
+++ b/drivers/net/declance.c
@@ -885,8 +885,7 @@ static int lance_start_xmit(struct sk_bu
 	len = skblen;
 	
 	if (len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		len = ETH_ZLEN;
 	}
diff --git a/drivers/net/depca.c b/drivers/net/depca.c
index 0941d40..e946c43 100644
--- a/drivers/net/depca.c
+++ b/drivers/net/depca.c
@@ -938,11 +938,8 @@ static int depca_start_xmit(struct sk_bu
 	if (skb->len < 1)
 		goto out;
 
-	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			goto out;
-	}
+	if (skb_padto(skb, ETH_ZLEN))
+		goto out;
 	
 	netif_stop_queue(dev);
 
diff --git a/drivers/net/eepro.c b/drivers/net/eepro.c
index a806dfe..e70f172 100644
--- a/drivers/net/eepro.c
+++ b/drivers/net/eepro.c
@@ -1154,8 +1154,7 @@ static int eepro_send_packet(struct sk_b
 		printk(KERN_DEBUG  "%s: entering eepro_send_packet routine.\n", dev->name);
 
 	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/drivers/net/eexpress.c b/drivers/net/eexpress.c
index 82bd356..a74b207 100644
--- a/drivers/net/eexpress.c
+++ b/drivers/net/eexpress.c
@@ -677,8 +677,7 @@ #if NET_DEBUG > 6
 #endif
 
 	if (buf->len < ETH_ZLEN) {
-		buf = skb_padto(buf, ETH_ZLEN);
-		if (buf == NULL)
+		if (skb_padto(buf, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/drivers/net/epic100.c b/drivers/net/epic100.c
index 8d680ce..724d7dc 100644
--- a/drivers/net/epic100.c
+++ b/drivers/net/epic100.c
@@ -1027,11 +1027,8 @@ static int epic_start_xmit(struct sk_buf
 	u32 ctrl_word;
 	unsigned long flags;
 
-	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
-	}
+	if (skb_padto(skb, ETH_ZLEN))
+		return 0;
 
 	/* Caution: the write order is important here, set the field with the
 	   "ownership" bit last. */
diff --git a/drivers/net/eth16i.c b/drivers/net/eth16i.c
index b67545b..4bf76f8 100644
--- a/drivers/net/eth16i.c
+++ b/drivers/net/eth16i.c
@@ -1064,8 +1064,7 @@ static int eth16i_tx(struct sk_buff *skb
 	unsigned long flags;
 
 	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/drivers/net/hp100.c b/drivers/net/hp100.c
index 247c8ca..dd1dc32 100644
--- a/drivers/net/hp100.c
+++ b/drivers/net/hp100.c
@@ -1487,11 +1487,8 @@ #endif
 	if (skb->len <= 0)
 		return 0;
 		
-	if (skb->len < ETH_ZLEN && lp->chip == HP100_CHIPID_SHASTA) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
-	}
+	if (lp->chip == HP100_CHIPID_SHASTA && skb_padto(skb, ETH_ZLEN))
+		return 0;
 
 	/* Get Tx ring tail pointer */
 	if (lp->txrtail->next == lp->txrhead) {
diff --git a/drivers/net/lance.c b/drivers/net/lance.c
index bb5ad47..c1c3452 100644
--- a/drivers/net/lance.c
+++ b/drivers/net/lance.c
@@ -968,8 +968,7 @@ static int lance_start_xmit(struct sk_bu
 	/* The old LANCE chips doesn't automatically pad buffers to min. size. */
 	if (chip_table[lp->chip_version].flags & LANCE_MUST_PAD) {
 		if (skb->len < ETH_ZLEN) {
-			skb = skb_padto(skb, ETH_ZLEN);
-			if (skb == NULL)
+			if (skb_padto(skb, ETH_ZLEN))
 				goto out;
 			lp->tx_ring[entry].length = -ETH_ZLEN;
 		}
diff --git a/drivers/net/lasi_82596.c b/drivers/net/lasi_82596.c
index 957888d..1ab0944 100644
--- a/drivers/net/lasi_82596.c
+++ b/drivers/net/lasi_82596.c
@@ -1083,8 +1083,7 @@ static int i596_start_xmit(struct sk_buf
 				skb->len, skb->data));
 
 	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/drivers/net/lp486e.c b/drivers/net/lp486e.c
index 94d5ea1..bf3f343 100644
--- a/drivers/net/lp486e.c
+++ b/drivers/net/lp486e.c
@@ -877,8 +877,7 @@ static int i596_start_xmit (struct sk_bu
 	length = skb->len;
 	
 	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/drivers/net/myri10ge/myri10ge.c b/drivers/net/myri10ge/myri10ge.c
index e1feb58..b245476 100644
--- a/drivers/net/myri10ge/myri10ge.c
+++ b/drivers/net/myri10ge/myri10ge.c
@@ -1939,8 +1939,7 @@ #endif				/*NETIF_F_TSO */
 
 		/* pad frames to at least ETH_ZLEN bytes */
 		if (unlikely(skb->len < ETH_ZLEN)) {
-			skb = skb_padto(skb, ETH_ZLEN);
-			if (skb == NULL) {
+			if (skb_padto(skb, ETH_ZLEN)) {
 				/* The packet is gone, so we must
 				 * return 0 */
 				mgp->stats.tx_dropped += 1;
diff --git a/drivers/net/pcmcia/fmvj18x_cs.c b/drivers/net/pcmcia/fmvj18x_cs.c
index 09b1176..ea93b8f 100644
--- a/drivers/net/pcmcia/fmvj18x_cs.c
+++ b/drivers/net/pcmcia/fmvj18x_cs.c
@@ -831,8 +831,7 @@ static int fjn_start_xmit(struct sk_buff
     
     if (length < ETH_ZLEN)
     {
-    	skb = skb_padto(skb, ETH_ZLEN);
-    	if (skb == NULL)
+    	if (skb_padto(skb, ETH_ZLEN))
     		return 0;
     	length = ETH_ZLEN;
     }
diff --git a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
index 71f4505..54bbfda 100644
--- a/drivers/net/pcmcia/xirc2ps_cs.c
+++ b/drivers/net/pcmcia/xirc2ps_cs.c
@@ -1374,8 +1374,7 @@ do_start_xmit(struct sk_buff *skb, struc
      */
     if (pktlen < ETH_ZLEN)
     {
-        skb = skb_padto(skb, ETH_ZLEN);
-        if (skb == NULL)
+        if (skb_padto(skb, ETH_ZLEN))
         	return 0;
 	pktlen = ETH_ZLEN;
     }
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 9945cc6..985afe0 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -2222,8 +2222,7 @@ static int rtl8169_start_xmit(struct sk_
 		len = skb->len;
 
 		if (unlikely(len < ETH_ZLEN)) {
-			skb = skb_padto(skb, ETH_ZLEN);
-			if (!skb)
+			if (skb_padto(skb, ETH_ZLEN))
 				goto err_update_stats;
 			len = ETH_ZLEN;
 		}
diff --git a/drivers/net/seeq8005.c b/drivers/net/seeq8005.c
index bcef03f..efd0f23 100644
--- a/drivers/net/seeq8005.c
+++ b/drivers/net/seeq8005.c
@@ -396,8 +396,7 @@ static int seeq8005_send_packet(struct s
 	unsigned char *buf;
 
 	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/drivers/net/sis190.c b/drivers/net/sis190.c
index 31dd3f0..df39f34 100644
--- a/drivers/net/sis190.c
+++ b/drivers/net/sis190.c
@@ -1156,8 +1156,7 @@ static int sis190_start_xmit(struct sk_b
 	dma_addr_t mapping;
 
 	if (unlikely(skb->len < ETH_ZLEN)) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (!skb) {
+		if (skb_padto(skb, ETH_ZLEN)) {
 			tp->stats.tx_dropped++;
 			goto out;
 		}
diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index 38a26df..f3efbd1 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -1525,7 +1525,7 @@ #endif
 	** This is to resolve faulty padding by the HW with 0xaa bytes.
 	*/
 	if (BytesSend < C_LEN_ETHERNET_MINSIZE) {
-		if ((pMessage = skb_padto(pMessage, C_LEN_ETHERNET_MINSIZE)) == NULL) {
+		if (skb_padto(pMessage, C_LEN_ETHERNET_MINSIZE)) {
 			spin_unlock_irqrestore(&pTxPort->TxDesRingLock, Flags);
 			return 0;
 		}
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 536dd1c..19a4a16 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -2310,8 +2310,7 @@ static int skge_xmit_frame(struct sk_buf
 	u64 map;
 	unsigned long flags;
 
-	skb = skb_padto(skb, ETH_ZLEN);
-	if (!skb)
+	if (skb_padto(skb, ETH_ZLEN))
 		return NETDEV_TX_OK;
 
 	if (!spin_trylock_irqsave(&skge->tx_lock, flags))
diff --git a/drivers/net/smc9194.c b/drivers/net/smc9194.c
index 6cf16f3..8b0321f 100644
--- a/drivers/net/smc9194.c
+++ b/drivers/net/smc9194.c
@@ -523,8 +523,7 @@ static int smc_wait_to_send_packet( stru
 	length = skb->len;
 
 	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL) {
+		if (skb_padto(skb, ETH_ZLEN)) {
 			netif_wake_queue(dev);
 			return 0;
 		}
diff --git a/drivers/net/sonic.c b/drivers/net/sonic.c
index 90b818a..cab0dd9 100644
--- a/drivers/net/sonic.c
+++ b/drivers/net/sonic.c
@@ -231,8 +231,7 @@ static int sonic_send_packet(struct sk_b
 
 	length = skb->len;
 	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
index 9b7805b..c158eed 100644
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -1349,8 +1349,7 @@ static int start_tx(struct sk_buff *skb,
 
 #if defined(ZEROCOPY) && defined(HAS_BROKEN_FIRMWARE)
 	if (skb->ip_summed == CHECKSUM_HW) {
-		skb = skb_padto(skb, (skb->len + PADDING_MASK) & ~PADDING_MASK);
-		if (skb == NULL)
+		if (skb_padto(skb, (skb->len + PADDING_MASK) & ~PADDING_MASK))
 			return NETDEV_TX_OK;
 	}
 #endif /* ZEROCOPY && HAS_BROKEN_FIRMWARE */
diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
index fdc2103..c80a4f1 100644
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -1284,11 +1284,8 @@ static int rhine_start_tx(struct sk_buff
 	/* Calculate the next Tx descriptor entry. */
 	entry = rp->cur_tx % TX_RING_SIZE;
 
-	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
-	}
+	if (skb_padto(skb, ETH_ZLEN))
+		return 0;
 
 	rp->tx_skbuff[entry] = skb;
 
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index 879eb42..a915fe6 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -924,8 +924,7 @@ static int ray_dev_start_xmit(struct sk_
 
     if (length < ETH_ZLEN)
     {
-    	skb = skb_padto(skb, ETH_ZLEN);
-    	if (skb == NULL)
+    	if (skb_padto(skb, ETH_ZLEN))
     		return 0;
     	length = ETH_ZLEN;
     }
diff --git a/drivers/net/wireless/wavelan.c b/drivers/net/wireless/wavelan.c
index dade4b9..aba56af 100644
--- a/drivers/net/wireless/wavelan.c
+++ b/drivers/net/wireless/wavelan.c
@@ -2936,11 +2936,8 @@ #endif
 	 * and we don't have the Ethernet specific requirement of beeing
 	 * able to detect collisions, therefore in theory we don't really
 	 * need to pad. Jean II */
-	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
-	}
+	if (skb_padto(skb, ETH_ZLEN))
+		return 0;
 
 	/* Write packet on the card */
 	if(wv_packet_write(dev, skb->data, skb->len))
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index f7724eb..561250f 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -3194,11 +3194,8 @@ #endif
 	 * and we don't have the Ethernet specific requirement of beeing
 	 * able to detect collisions, therefore in theory we don't really
 	 * need to pad. Jean II */
-	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
-	}
+	if (skb_padto(skb, ETH_ZLEN))
+		return 0;
 
   wv_packet_write(dev, skb->data, skb->len);
 
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index fd0f43b..ecec8e5 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -862,13 +862,11 @@ static int yellowfin_start_xmit(struct s
 		/* Fix GX chipset errata. */
 		if (cacheline_end > 24  || cacheline_end == 0) {
 			len = skb->len + 32 - cacheline_end + 1;
-			if (len != skb->len)
-				skb = skb_padto(skb, len);
-		}
-		if (skb == NULL) {
-			yp->tx_skbuff[entry] = NULL;
-			netif_wake_queue(dev);
-			return 0;
+			if (skb_padto(skb, len)) {
+				yp->tx_skbuff[entry] = NULL;
+				netif_wake_queue(dev);
+				return 0;
+			}
 		}
 	}
 	yp->tx_skbuff[entry] = skb;
diff --git a/drivers/net/znet.c b/drivers/net/znet.c
index 3ac047b..a7c089d 100644
--- a/drivers/net/znet.c
+++ b/drivers/net/znet.c
@@ -544,8 +544,7 @@ static int znet_send_packet(struct sk_bu
 		printk(KERN_DEBUG "%s: ZNet_send_packet.\n", dev->name);
 
 	if (length < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
+		if (skb_padto(skb, ETH_ZLEN))
 			return 0;
 		length = ETH_ZLEN;
 	}
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 66f8819..f8c7eb7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -345,7 +345,7 @@ extern struct sk_buff *skb_realloc_headr
 extern struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 				       int newheadroom, int newtailroom,
 				       gfp_t priority);
-extern struct sk_buff *		skb_pad(struct sk_buff *skb, int pad);
+extern int	       skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	kfree_skb(a)
 extern void	      skb_over_panic(struct sk_buff *skb, int len,
 				     void *here);
@@ -1122,16 +1122,15 @@ static inline int skb_cow(struct sk_buff
  *
  *	Pads up a buffer to ensure the trailing bytes exist and are
  *	blanked. If the buffer already contains sufficient data it
- *	is untouched. Returns the buffer, which may be a replacement
- *	for the original, or NULL for out of memory - in which case
- *	the original buffer is still freed.
+ *	is untouched. Otherwise it is extended. Returns zero on
+ *	success. The skb is freed on error.
  */
  
-static inline struct sk_buff *skb_padto(struct sk_buff *skb, unsigned int len)
+static inline int skb_padto(struct sk_buff *skb, unsigned int len)
 {
 	unsigned int size = skb->len;
 	if (likely(size >= len))
-		return skb;
+		return 0;
 	return skb_pad(skb, len-size);
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bb7210f..fe63d4e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -781,24 +781,40 @@ struct sk_buff *skb_copy_expand(const st
  *	filled. Used by network drivers which may DMA or transfer data
  *	beyond the buffer end onto the wire.
  *
- *	May return NULL in out of memory cases.
+ *	May return error in out of memory cases. The skb is freed on error.
  */
  
-struct sk_buff *skb_pad(struct sk_buff *skb, int pad)
+int skb_pad(struct sk_buff *skb, int pad)
 {
-	struct sk_buff *nskb;
+	int err;
+	int ntail;
 	
 	/* If the skbuff is non linear tailroom is always zero.. */
-	if (skb_tailroom(skb) >= pad) {
+	if (!skb_cloned(skb) && skb_tailroom(skb) >= pad) {
 		memset(skb->data+skb->len, 0, pad);
-		return skb;
+		return 0;
 	}
-	
-	nskb = skb_copy_expand(skb, skb_headroom(skb), skb_tailroom(skb) + pad, GFP_ATOMIC);
+
+	ntail = skb->data_len + pad - (skb->end - skb->tail);
+	if (likely(skb_cloned(skb) || ntail > 0)) {
+		err = pskb_expand_head(skb, 0, ntail, GFP_ATOMIC);
+		if (unlikely(err))
+			goto free_skb;
+	}
+
+	/* FIXME: The use of this function with non-linear skb's really needs
+	 * to be audited.
+	 */
+	err = skb_linearize(skb);
+	if (unlikely(err))
+		goto free_skb;
+
+	memset(skb->data + skb->len, 0, pad);
+	return 0;
+
+free_skb:
 	kfree_skb(skb);
-	if (nskb)
-		memset(nskb->data+nskb->len, 0, pad);
-	return nskb;
+	return err;
 }	
  
 /* Trims skb to length len. It can change skb pointers.
