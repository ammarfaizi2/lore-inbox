Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbWFVNKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbWFVNKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWFVNKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:10:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24233 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030630AbWFVNKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:10:47 -0400
Subject: Re: Memory corruption in 8390.c ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, snakebyte@gmx.de, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
In-Reply-To: <E1FtNNQ-0001QW-00@gondolin.me.apana.org.au>
References: <E1FtNNQ-0001QW-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jun 2006 14:25:34 +0100
Message-Id: <1150982734.15275.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-22 am 21:29 +1000, ysgrifennodd Herbert Xu:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > 
> > The 8390 change (corrected version) also makes 8390.c faster so should
> > be applied anyway, and the orinoco one fixes some code that isn't even
> > needed and someone forgot to remove long ago. Otherwise the skb_padto
> 
> Yeah I agree totally.  However, I haven't actually seen the fixed 8390
> version being posted yet or at least not to netdev :)

Ah the resounding clang of a subtle hint ;)

Signed-off-by: Alan Cox <alan@redhat.com>

- Return 8390.c to the old way of handling short packets (which is also
faster)

- Remove the skb_padto from orinoco. This got left in when the padding bad 
write patch was added and is actually not needed. This is fixing a merge
error way back when.

- Wavelan can also use the stack based buffer trick if you want



diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/8390.c linux-2.6.17/drivers/net/8390.c
--- linux.vanilla-2.6.17/drivers/net/8390.c	2006-06-19 17:17:32.000000000 +0100
+++ linux-2.6.17/drivers/net/8390.c	2006-06-21 21:23:12.000000000 +0100
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
+		memcpy(buf, data, skb->len);
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/net/wireless/orinoco.c linux-2.6.17/drivers/net/wireless/orinoco.c
--- linux.vanilla-2.6.17/drivers/net/wireless/orinoco.c	2006-06-19 17:29:48.000000000 +0100
+++ linux-2.6.17/drivers/net/wireless/orinoco.c	2006-06-21 18:19:02.000000000 +0100
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
+++ linux-2.6.17/drivers/net/wireless/wavelan.c	2006-06-21 18:32:47.000000000 +0100
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

