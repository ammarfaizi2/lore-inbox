Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270773AbTGNUAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270754AbTGNT74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:59:56 -0400
Received: from evil.netppl.fi ([195.242.209.201]:4250 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id S270773AbTGNT50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:57:26 -0400
Date: Mon, 14 Jul 2003 23:12:09 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: REQ: BCM4400 network driver for 2.4.22
Message-ID: <20030714201209.GA12841@netppl.fi>
References: <200307092333.36917.bas@basmevissen.nl> <3F0C9194.5060206@pobox.com> <20030711163345.GA23076@netppl.fi> <20030711202426.5b0e475b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030711202426.5b0e475b.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 08:24:26PM -0700, David S. Miller wrote:
> Please be kind to us underprivileged big-endian users
> out here :-)
Whoops :-)
> You can't modify skb->data without doing something sane
> with skb->len and friends too, this is why we have skb_*()
> interfaces to do these kinds of operations which do all
> the necessary book-keeping :-)
Indeed, it did seem a bit suspicious when I did it ;) 

I've attached my current version, which fixes all the bugs I've noticed
in the previous one (including "it doesn't work unless I run tcpdump" and
"it crashes randomly"), tested with rawhide-2.4 and 2.6.0-test1. I adjusted
the b44_poll locking a bit in this version and have a almost-as-bad-a-feeling
about it as I did with the skb handling. However, it works my uniprocessor
box and doesn't spew out a screenful of backtraces for every 
packet on 2.6.0-test1 so for some definition of "improvement" it
is one... Might easily blow up on SMP, but I have no way 
of testing that ;) 

--- /stuff/src/linux-2.6.0-test1/drivers/net/b44.c.orig	2003-07-14 06:33:45.000000000 +0300
+++ /stuff/src/linux-2.6.0-test1/drivers/net/b44.c	2003-07-14 22:45:18.146899367 +0300
@@ -1,6 +1,7 @@
 /* b44.c: Broadcom 4400 device driver.
  *
  * Copyright (C) 2002 David S. Miller (davem@redhat.com)
+ * Fixed by Pekka Pietikainen (pp@ee.oulu.fi)
  */
 
 #include <linux/kernel.h>
@@ -14,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/version.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -23,8 +25,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.6"
-#define DRV_MODULE_RELDATE	"Nov 11, 2002"
+#define DRV_MODULE_VERSION	"0.6-pp2"
+#define DRV_MODULE_RELDATE	"Jul 14, 2003"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -78,6 +80,15 @@
 
 static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
 
+#ifndef PCI_DEVICE_ID_BCM4401
+#define PCI_DEVICE_ID_BCM4401      0x4401
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#define IRQ_RETVAL(x) 
+#define irqreturn_t void
+#endif
+
 static struct pci_device_id b44_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
@@ -259,7 +270,7 @@
 		== SBTMSLOW_CLOCK);
 }
 
-static void __b44_cam_write(struct b44 *bp, char *data, int index)
+static void __b44_cam_write(struct b44 *bp, unsigned char *data, int index)
 {
 	u32 val;
 
@@ -521,7 +532,7 @@
 			/* Link now up */
 			netif_carrier_on(bp->dev);
 			b44_link_report(bp);
-		} else if (netif_carrier_ok(bp->dev)) {
+		} else if (netif_carrier_ok(bp->dev) && !(bmsr & BMSR_LSTATUS)) {
 			/* Link now down */
 			netif_carrier_off(bp->dev);
 			b44_link_report(bp);
@@ -650,8 +661,7 @@
 	src_map = &bp->rx_buffers[src_idx];
 
 	dest_map->skb = src_map->skb;
-	rh = (struct rx_header *)
-		(src_map->skb->data - bp->rx_offset);
+	rh = (struct rx_header *) src_map->skb->data;
 	rh->len = 0;
 	rh->flags = 0;
 	pci_unmap_addr_set(dest_map, mapping,
@@ -660,9 +670,12 @@
 	ctrl = src_desc->ctrl;
 	if (dest_idx == (B44_RX_RING_SIZE - 1))
 		ctrl |= cpu_to_le32(DESC_CTRL_EOT);
+	else
+		ctrl &= cpu_to_le32(~DESC_CTRL_EOT);
 
 	dest_desc->ctrl = ctrl;
 	dest_desc->addr = src_desc->addr;
+	src_map->skb = NULL;
 }
 
 static int b44_rx(struct b44 *bp, int budget)
@@ -685,7 +698,7 @@
 		pci_dma_sync_single(bp->pdev, map,
 				    RX_PKT_BUF_SZ,
 				    PCI_DMA_FROMDEVICE);
-		rh = (struct rx_header *) (skb->data - bp->rx_offset);
+		rh = (struct rx_header *) skb->data;
 		len = cpu_to_le16(rh->len);
 		if ((len > (RX_PKT_BUF_SZ - bp->rx_offset)) ||
 		    (rh->flags & cpu_to_le16(RX_FLAG_ERRORS))) {
@@ -718,7 +731,9 @@
 				goto drop_it;
 			pci_unmap_single(bp->pdev, map,
 					 skb_size, PCI_DMA_FROMDEVICE);
-			skb_put(skb, len);
+			/* Leave out rx_header */
+                	skb_put(skb, len+bp->rx_offset);
+            	        skb_pull(skb,bp->rx_offset);
 		} else {
 			struct sk_buff *copy_skb;
 
@@ -730,8 +745,8 @@
 			copy_skb->dev = bp->dev;
 			skb_reserve(copy_skb, 2);
 			skb_put(copy_skb, len);
-			/* DMA sync done above */
-			memcpy(copy_skb->data, skb->data, len);
+			/* DMA sync done above, copy just the actual packet */
+			memcpy(copy_skb->data, skb->data+bp->rx_offset, len);
 
 			skb = copy_skb;
 		}
@@ -748,6 +763,7 @@
 	}
 
 	bp->rx_cons = cons;
+	bw32(B44_DMARX_PTR, cons * sizeof(struct dma_desc));
 
 	return received;
 }
@@ -764,6 +780,7 @@
 		b44_tx(bp);
 		/* spin_unlock(&bp->tx_lock); */
 	}
+	spin_unlock_irq(&bp->lock);
 
 	done = 1;
 	if (bp->istat & ISTAT_RX) {
@@ -783,10 +800,12 @@
 	}
 
 	if (bp->istat & ISTAT_ERRORS) {
+		spin_lock_irq(&bp->lock);
 		b44_halt(bp);
 		b44_init_rings(bp);
 		b44_init_hw(bp);
 		netif_wake_queue(bp->dev);
+		spin_unlock_irq(&bp->lock);
 		done = 1;
 	}
 
@@ -794,7 +813,6 @@
 		netif_rx_complete(netdev);
 		b44_enable_ints(bp);
 	}
-	spin_unlock_irq(&bp->lock);
 
 	return (done ? 0 : 1);
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
+        	val = br32(B44_CAM_CTRL);
+	        bw32(B44_CAM_CTRL, val | CAM_CTRL_ENABLE);
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
--- /stuff/src/linux-2.6.0-test1/drivers/net/b44.h~	2003-07-09 18:28:09.000000000 +0300
+++ /stuff/src/linux-2.6.0-test1/drivers/net/b44.h	2003-07-09 18:28:15.000000000 +0300
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
