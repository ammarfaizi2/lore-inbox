Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUGKL1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUGKL1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 07:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUGKL1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 07:27:50 -0400
Received: from dsl-prvgw1cc4.dial.inet.fi ([80.223.50.196]:40321 "EHLO
	dsl-prvgw1cc4.dial.inet.fi") by vger.kernel.org with ESMTP
	id S266568AbUGKL1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 07:27:43 -0400
Date: Sun, 11 Jul 2004 14:27:42 +0300 (EEST)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: "David S. Miller" <davem@redhat.com>, vortex@scyld.com, becker@scyld.com
Cc: trivial@rustcorp.com.au, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix 3c59x.c uses of plain integer as NULL pointer
Message-ID: <Pine.LNX.4.58.0407111417340.1846@dsl-prvgw1cc4.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch will fix 3Com "Vortex" and "Boomerang" ethernet driver sparse
warnings about using plain integer as NULL pointer.

Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>

--- linux-2.6/drivers/net/3c59x.c.orig	2004-07-11 14:10:58.000000000 +0300
+++ linux-2.6/drivers/net/3c59x.c	2004-07-11 14:14:44.000000000 +0300
@@ -568,7 +568,7 @@ static struct vortex_chip_info {
 	{"3c920B-EMB-WNM Tornado",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_NWAY|HAS_HWCKSM, 128, },

-	{0,}, /* 0 terminated list. */
+	{NULL,}, /* NULL terminated list. */
 };


@@ -1695,7 +1695,7 @@ vortex_up(struct net_device *dev)
 		for (i = 0; i < RX_RING_SIZE; i++)	/* AKPM: this is done in vortex_open, too */
 			vp->rx_ring[i].status = 0;
 		for (i = 0; i < TX_RING_SIZE; i++)
-			vp->tx_skbuff[i] = 0;
+			vp->tx_skbuff[i] = NULL;
 		outl(0, ioaddr + DownListPtr);
 	}
 	/* Set receiver mode: presumably accept b-case and phys addr only. */
@@ -1760,7 +1760,7 @@ vortex_open(struct net_device *dev)
 			for (j = 0; j < i; j++) {
 				if (vp->rx_skbuff[j]) {
 					dev_kfree_skb(vp->rx_skbuff[j]);
-					vp->rx_skbuff[j] = 0;
+					vp->rx_skbuff[j] = NULL;
 				}
 			}
 			retval = -ENOMEM;
@@ -1938,9 +1938,9 @@ static void vortex_tx_timeout(struct net
 			unsigned long flags;
 			local_irq_save(flags);
 			if (vp->full_bus_master_tx)
-				boomerang_interrupt(dev->irq, dev, 0);
+				boomerang_interrupt(dev->irq, dev, NULL);
 			else
-				vortex_interrupt(dev->irq, dev, 0);
+				vortex_interrupt(dev->irq, dev, NULL);
 			local_irq_restore(flags);
 		}
 	}
@@ -2419,7 +2419,7 @@ boomerang_interrupt(int irq, void *dev_i
 						le32_to_cpu(vp->tx_ring[entry].addr), skb->len, PCI_DMA_TODEVICE);
 #endif
 					dev_kfree_skb_irq(skb);
-					vp->tx_skbuff[entry] = 0;
+					vp->tx_skbuff[entry] = NULL;
 				} else {
 					printk(KERN_DEBUG "boomerang_interrupt: no skb!\n");
 				}
@@ -2724,7 +2724,7 @@ vortex_close(struct net_device *dev)
 				pci_unmap_single(	VORTEX_PCI(vp), le32_to_cpu(vp->rx_ring[i].addr),
 									PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 				dev_kfree_skb(vp->rx_skbuff[i]);
-				vp->rx_skbuff[i] = 0;
+				vp->rx_skbuff[i] = NULL;
 			}
 	}
 	if (vp->full_bus_master_tx) { /* Free Boomerang bus master Tx buffers. */
@@ -2743,7 +2743,7 @@ vortex_close(struct net_device *dev)
 				pci_unmap_single(VORTEX_PCI(vp), le32_to_cpu(vp->tx_ring[i].addr), skb->len, PCI_DMA_TODEVICE);
 #endif
 				dev_kfree_skb(skb);
-				vp->tx_skbuff[i] = 0;
+				vp->tx_skbuff[i] = NULL;
 			}
 		}
 	}
