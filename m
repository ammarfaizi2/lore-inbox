Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266076AbUFELFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUFELFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 07:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUFELFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 07:05:41 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:5273 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266076AbUFELFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 07:05:36 -0400
Date: Sat, 5 Jun 2004 13:05:26 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: webvenza@libero.it, linux-kernel@vger.kernel.org
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Message-ID: <20040605130526.A31872@electric-eye.fr.zoreil.com>
References: <40C0E37C.4030905@lbsd.net> <20040604214721.GC22679@picchio.gall.it> <20040605005033.A26051@electric-eye.fr.zoreil.com> <20040605070239.GM14247@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040605070239.GM14247@lbsd.net>; from nkukard@lbsd.net on Sat, Jun 05, 2004 at 09:02:39AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Kukard <nkukard@lbsd.net> :
[...]
> Any quick fix i can hack?

Instant hack below. I do not expect it to make a difference but it _could_
make one.

You probably want to increase NUM_RX_DESC in sis900.h as well and see if
it changes things: at 7.5Mb/s, it takes 3ms of interrupt processing latency
before the network adapter exhaust the Rx ring (this should appear on the
output of 'ifconfig' btw). So if anything keeps the irq masked for that long,
you experience the usually very well tested error/uncommon paths of the
drivers :o)

NUM_RX_DESC at 64 or 256 should not hurt but I do not know if the datasheet
limits the number of Rx descriptors. Fiddling with NUM_RX_DESC could change
the behavior from "computer hangs" to "computer takes noticeably more time
to hang".

--- sis900.c.orig	2004-06-05 11:47:27.000000000 +0200
+++ sis900.c	2004-06-05 12:43:48.000000000 +0200
@@ -1626,7 +1626,7 @@ static int sis900_rx(struct net_device *
 		       "status:0x%8.8x\n",
 		       sis_priv->cur_rx, sis_priv->dirty_rx, rx_status);
 
-	while (rx_status & OWN) {
+	while (rx_status & OWN & sis_priv->rx_skbuff[entry]) {
 		unsigned int rx_size;
 
 		rx_size = (rx_status & DSIZE) - CRC_SIZE;
@@ -1651,16 +1651,6 @@ static int sis900_rx(struct net_device *
 		} else {
 			struct sk_buff * skb;
 
-			/* This situation should never happen, but due to
-			   some unknow bugs, it is possible that
-			   we are working on NULL sk_buff :-( */
-			if (sis_priv->rx_skbuff[entry] == NULL) {
-				printk(KERN_INFO "%s: NULL pointer " 
-				       "encountered in Rx ring, skipping\n",
-				       net_dev->name);
-				break;
-			}
-
 			pci_unmap_single(sis_priv->pci_dev, 
 				sis_priv->rx_ring[entry].bufptr, RX_BUF_SIZE, 
 				PCI_DMA_FROMDEVICE);
@@ -1688,18 +1678,21 @@ static int sis900_rx(struct net_device *
 				       "deferring packet.\n",
 				       net_dev->name);
 				sis_priv->rx_skbuff[entry] = NULL;
-				/* reset buffer descriptor state */
-				sis_priv->rx_ring[entry].cmdsts = 0;
+				/*
+				 * reset buffer descriptor state and keep it
+				 * under host control
+				 */
+				sis_priv->rx_ring[entry].cmdsts = OWN;
 				sis_priv->rx_ring[entry].bufptr = 0;
-				sis_priv->stats.rx_dropped++;
-				break;
+				continue;
 			}
 			skb->dev = net_dev;
 			sis_priv->rx_skbuff[entry] = skb;
-			sis_priv->rx_ring[entry].cmdsts = RX_BUF_SIZE;
                 	sis_priv->rx_ring[entry].bufptr = 
 				pci_map_single(sis_priv->pci_dev, skb->tail, 
 					RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
+			wmb();
+			sis_priv->rx_ring[entry].cmdsts = RX_BUF_SIZE;
 			sis_priv->dirty_rx++;
 		}
 		sis_priv->cur_rx++;
@@ -1728,10 +1721,11 @@ static int sis900_rx(struct net_device *
 			}
 			skb->dev = net_dev;
 			sis_priv->rx_skbuff[entry] = skb;
-			sis_priv->rx_ring[entry].cmdsts = RX_BUF_SIZE;
                 	sis_priv->rx_ring[entry].bufptr =
 				pci_map_single(sis_priv->pci_dev, skb->tail,
 					RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
+			wmb();
+			sis_priv->rx_ring[entry].cmdsts = RX_BUF_SIZE;
 		}
 	}
 	/* re-enable the potentially idle receive state matchine */

