Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266225AbUFUNGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266225AbUFUNGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUFUNGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:06:08 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:22546 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266225AbUFUNDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:03:38 -0400
Date: Mon, 21 Jun 2004 23:03:16 +1000
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, benh@kernel.crashing.org,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: sungem - ifconfig eth0 mtu 1300 -> oops
Message-ID: <20040621130316.GA2661@gondor.apana.org.au>
References: <1087568322.4455.22.camel@localhost> <E1BcNzi-0000eh-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <E1BcNzi-0000eh-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2004 at 10:33:50PM +1000, Herbert Xu wrote:
> 
> Does this patch fix your problems?

Oops, I had a thinko about min vs. max.  I've also decided to make the
bigger MTU useful by adjusting the arguments to skb_put() as well.
Please try this one instead.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== drivers/net/sungem.c 1.56 vs edited =====
--- 1.56/drivers/net/sungem.c	2004-06-19 17:16:13 +10:00
+++ edited/drivers/net/sungem.c	2004-06-21 22:57:09 +10:00
@@ -33,6 +33,7 @@
 #include <linux/crc32.h>
 #include <linux/random.h>
 #include <linux/workqueue.h>
+#include <linux/if_vlan.h>
 
 #include <asm/system.h>
 #include <asm/bitops.h>
@@ -742,7 +743,7 @@
 				       PCI_DMA_FROMDEVICE);
 			gp->rx_skbs[entry] = new_skb;
 			new_skb->dev = gp->dev;
-			skb_put(new_skb, (ETH_FRAME_LEN + RX_OFFSET));
+			skb_put(new_skb, (gp->rx_buf_sz + RX_OFFSET));
 			rxd->buffer = cpu_to_le64(pci_map_page(gp->pdev,
 							       virt_to_page(new_skb->data),
 							       offset_in_page(new_skb->data),
@@ -1482,6 +1483,9 @@
 
 	gem_clean_rings(gp);
 
+	gp->rx_buf_sz = max(dev->mtu + ETH_HLEN + VLAN_HLEN,
+			    (unsigned)VLAN_ETH_FRAME_LEN);
+
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		struct sk_buff *skb;
 		struct gem_rxd *rxd = &gb->rxd[i];
@@ -1495,7 +1499,7 @@
 
 		gp->rx_skbs[i] = skb;
 		skb->dev = dev;
-		skb_put(skb, (ETH_FRAME_LEN + RX_OFFSET));
+		skb_put(skb, (gp->rx_buf_sz + RX_OFFSET));
 		dma_addr = pci_map_page(gp->pdev,
 					virt_to_page(skb->data),
 					offset_in_page(skb->data),
@@ -1750,7 +1754,7 @@
 	writel(0x40, gp->regs + MAC_MINFSZ);
 
 	/* Ethernet payload + header + FCS + optional VLAN tag. */
-	writel(0x20000000 | (gp->dev->mtu + ETH_HLEN + 4 + 4), gp->regs + MAC_MAXFSZ);
+	writel(0x20000000 | (gp->rx_buf_sz + 4), gp->regs + MAC_MAXFSZ);
 
 	writel(0x07, gp->regs + MAC_PASIZE);
 	writel(0x04, gp->regs + MAC_JAMSIZE);
@@ -1827,7 +1831,7 @@
 	if (gp->rx_fifo_sz <= (2 * 1024)) {
 		gp->rx_pause_off = gp->rx_pause_on = gp->rx_fifo_sz;
 	} else {
-		int max_frame = (gp->dev->mtu + ETH_HLEN + 4 + 4 + 64) & ~63;
+		int max_frame = (gp->rx_buf_sz + 4 + 64) & ~63;
 		int off = (gp->rx_fifo_sz - (max_frame * 2));
 		int on = off - max_frame;
 
===== drivers/net/sungem.h 1.14 vs edited =====
--- 1.14/drivers/net/sungem.h	2004-01-26 18:03:59 +11:00
+++ edited/drivers/net/sungem.h	2004-06-21 22:59:38 +10:00
@@ -911,7 +911,7 @@
 	  (GP)->tx_old - (GP)->tx_new - 1)
 
 #define RX_OFFSET          2
-#define RX_BUF_ALLOC_SIZE(gp)	((gp)->dev->mtu + 46 + RX_OFFSET + 64)
+#define RX_BUF_ALLOC_SIZE(gp)	((gp)->rx_buf_sz + 28 + RX_OFFSET + 64)
 
 #define RX_COPY_THRESHOLD  256
 
@@ -979,6 +979,7 @@
 	int			rx_fifo_sz;
 	int			rx_pause_off;
 	int			rx_pause_on;
+	int			rx_buf_sz;
 	int			mii_phy_addr;
 
 	u32			mac_rx_cfg;

--2fHTh5uZTiUOsy+g--
