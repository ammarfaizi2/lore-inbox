Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTGKQZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTGKQZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:25:04 -0400
Received: from evil.netppl.fi ([195.242.209.201]:32191 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id S264152AbTGKQY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:24:56 -0400
Date: Fri, 11 Jul 2003 19:33:45 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bas Mevissen <bas@basmevissen.nl>, torvalds@transmeta.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: REQ: BCM4400 network driver for 2.4.22
Message-ID: <20030711163345.GA23076@netppl.fi>
References: <200307092333.36917.bas@basmevissen.nl> <3F0C9194.5060206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3F0C9194.5060206@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 06:05:08PM -0400, Jeff Garzik wrote:
> b44 in 2.5 supports this, and it will be backported to 2.4.
> 
> Pekka Pietikainen just identified several bugs, so those will get fixed 
> in the next day or so, then b44 will be sent to Marcelo.
Hi

Here's a patch against the driver version in 2.5.73 for testing/comments,
which fixes all the issues I know of in the driver. I'm writing this mail
through the driver running on 2.4.x, so obviously at least basic 
functionality is working.

I'm not too sure about the pointer tricks I do with skb->data
in b44_rx(), but they seem to do the trick just fine ;)

--- /stuff/src/linux-2.5.73/drivers/net/b44.c	2003-06-22 21:32:43.000000000 +0300
+++ b44.c	2003-07-11 19:17:06.000000000 +0300
@@ -1,6 +1,7 @@
 /* b44.c: Broadcom 4400 device driver.
  *
  * Copyright (C) 2002 David S. Miller (davem@redhat.com)
+ * Fixed by Pekka Pietikainen (pp@netppl.fi)
  */
 
 #include <linux/kernel.h>
@@ -23,8 +24,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.6"
-#define DRV_MODULE_RELDATE	"Nov 11, 2002"
+#define DRV_MODULE_VERSION	"0.6-pp"
+#define DRV_MODULE_RELDATE	"Jul 11, 2003"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -78,6 +79,16 @@
 
 static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
 
+#ifndef PCI_DEVICE_ID_BCM4401
+#define PCI_DEVICE_ID_BCM4401      0x4401
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#ifndef IRQ_RETVAL
+#define IRQ_RETVAL(x) 
+#define irqreturn_t void
+#endif
+
 static struct pci_device_id b44_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
@@ -521,7 +532,7 @@
 			/* Link now up */
 			netif_carrier_on(bp->dev);
 			b44_link_report(bp);
-		} else if (netif_carrier_ok(bp->dev)) {
+		} else if (netif_carrier_ok(bp->dev) && !(bmsr & BMSR_LSTATUS)) {
 			/* Link now down */
 			netif_carrier_off(bp->dev);
 			b44_link_report(bp);
@@ -660,9 +671,12 @@
 	ctrl = src_desc->ctrl;
 	if (dest_idx == (B44_RX_RING_SIZE - 1))
 		ctrl |= cpu_to_le32(DESC_CTRL_EOT);
+	else
+		ctrl &= ~DESC_CTRL_EOT;
 
 	dest_desc->ctrl = ctrl;
 	dest_desc->addr = src_desc->addr;
+	src_map->skb = NULL;
 }
 
 static int b44_rx(struct b44 *bp, int budget)
@@ -685,8 +699,10 @@
 		pci_dma_sync_single(bp->pdev, map,
 				    RX_PKT_BUF_SZ,
 				    PCI_DMA_FROMDEVICE);
-		rh = (struct rx_header *) (skb->data - bp->rx_offset);
+		rh = (struct rx_header *) (skb->data);
 		len = cpu_to_le16(rh->len);
+		skb->data+=bp->rx_offset;
+
 		if ((len > (RX_PKT_BUF_SZ - bp->rx_offset)) ||
 		    (rh->flags & cpu_to_le16(RX_FLAG_ERRORS))) {
 		drop_it:
@@ -733,6 +749,7 @@
 			/* DMA sync done above */
 			memcpy(copy_skb->data, skb->data, len);
 
+			skb->data-=bp->rx_offset;
 			skb = copy_skb;
 		}
 		skb->ip_summed = CHECKSUM_NONE;
@@ -748,6 +765,7 @@
 	}
 
 	bp->rx_cons = cons;
+	bw32(B44_DMARX_PTR, cons * sizeof(struct dma_desc));
 
 	return received;
 }
@@ -885,7 +903,7 @@
 		ctrl |= DESC_CTRL_EOT;
 
 	bp->tx_ring[entry].ctrl = cpu_to_le32(ctrl);
-	bp->tx_ring[entry].addr = cpu_to_le32((u32) mapping);
+	bp->tx_ring[entry].addr = cpu_to_le32((u32) mapping+bp->dma_offset);
 
 	entry = NEXT_TX(entry);
 
@@ -1173,8 +1191,8 @@
 	__b44_set_rx_mode(bp->dev);
 
 	/* MTU + eth header + possible VLAN tag + struct rx_header */
-	bw32(B44_RXMAXLEN, bp->dev->mtu + ETH_HLEN + 8 + 24);
-	bw32(B44_TXMAXLEN, bp->dev->mtu + ETH_HLEN + 8 + 24);
+	bw32(B44_RXMAXLEN, bp->dev->mtu + ETH_HLEN + 8 + RX_HEADER_LEN);
+	bw32(B44_TXMAXLEN, bp->dev->mtu + ETH_HLEN + 8 + RX_HEADER_LEN);
 
 	bw32(B44_TX_WMARK, 56); /* XXX magic */
 	bw32(B44_DMATX_CTRL, DMATX_CTRL_ENABLE);
@@ -1184,6 +1202,7 @@
 	bw32(B44_DMARX_ADDR, bp->rx_ring_dma + bp->dma_offset);
 
 	bw32(B44_DMARX_PTR, bp->rx_pending);
+	bp->rx_prod = bp->rx_pending;	
 
 	bw32(B44_MIB_CTRL, MIB_CTRL_CLR_ON_READ);
 
@@ -1345,6 +1364,8 @@
 			__b44_load_mcast(bp, dev);
 
 		bw32(B44_RXCONFIG, val);
+		val = br32(B44_CAM_CTRL);
+		bw32(B44_CAM_CTRL, val | CAM_CTRL_ENABLE);
 	}
 }
 
@@ -1678,8 +1699,9 @@
 	bp->core_unit = ssb_core_unit(bp);
 	bp->dma_offset = ssb_get_addr(bp, SBID_PCI_DMA, 0);
 
-	bp->flags |= B44_FLAG_BUGGY_TXPTR;
-
+	/* XXX - really required? 
+	   bp->flags |= B44_FLAG_BUGGY_TXPTR;
+         */
 out:
 	return err;
 }
--- /stuff/src/linux-2.5.73/drivers/net/b44.h	2003-06-22 21:32:57.000000000 +0300
+++ b44.h	2003-07-09 18:28:15.000000000 +0300
@@ -142,7 +142,7 @@
 #define  MDIO_OP_READ		2
 #define  MDIO_DATA_SB_MASK	0xc0000000 /* Start Bits */
 #define  MDIO_DATA_SB_SHIFT	30
-#define  MDIO_DATA_SB_START	0x10000000 /* Start Of Frame */
+#define  MDIO_DATA_SB_START	0x40000000 /* Start Of Frame */
 #define B44_EMAC_IMASK	0x0418UL /* EMAC Interrupt Mask */
 #define B44_EMAC_ISTAT	0x041CUL /* EMAC Interrupt Status */
 #define  EMAC_INT_MII		0x00000001 /* MII MDIO Interrupt */


-- 
Pekka Pietikainen




