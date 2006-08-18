Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWHRWV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWHRWV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWHRWV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:21:56 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:30442 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751527AbWHRWVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:21:55 -0400
Date: Fri, 18 Aug 2006 17:21:46 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
Subject: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060818222146.GI26889@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818220700.GG26889@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Implement basic low-watermark support for the transmit queue.
Hardware low-watermarks allow a properly configured kernel
to continously stream data to a device and not have to handle 
any interrupts at all in doing so. Correct zero-interrupt
operation can be actually observed for this driver, when the 
socket buffer is made large enough.

The basic idea of a low-watermark interrupt is as follows.
The device driver queues up a bunch of packets for the hardware
to transmit, and then kicks the hardware to get it started.
As the hardware drains the queue of pending, untransmitted 
packets, the device driver will want to know when the queue
is almost empty, so that it can queue some more packets.

If the queue drains down to the low waterark, then an interrupt
will be generated. However, if the kernel/driver continues 
to add enough packets to keep the queue partially filled,
no interrupt will actually be generated, and the hardware 
can continue streaming packets indefinitely in this mode.

The impelmentation is done by setting the DESCR_TXDESFLG flag 
in one of the packets. When the hardware sees this flag, it will 
interrupt the device driver. Because this flag is on a fixed
packet, rather than at  fixed location in the queue, the
code below needs to move the flag as more packets are
queued up. This implementation attempts to keep the flag 
at about 1/4 from "empty".

This patch boosts driver performance from about 
300-400Mbps for 1500 byte packets, to about 710-740Mbps.


Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   56 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/net/spider_net.h |    6 +++--
 2 files changed, 55 insertions(+), 7 deletions(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.c	2006-08-07 14:39:38.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.c	2006-08-11 11:23:24.000000000 -0500
@@ -700,6 +700,39 @@ spider_net_release_tx_descr(struct spide
 	dev_kfree_skb_any(skb);
 }
 
+static void
+spider_net_set_low_watermark(struct spider_net_card *card)
+{
+	int status;
+	int cnt=0;
+	int i;
+	struct spider_net_descr *descr = card->tx_chain.tail;
+
+	/* Measure the length of the queue. */
+	while (descr != card->tx_chain.head) {
+		status = descr->dmac_cmd_status & SPIDER_NET_DESCR_NOT_IN_USE;
+		if (status == SPIDER_NET_DESCR_NOT_IN_USE)
+			break;
+		descr = descr->next;
+		cnt++;
+	}
+	if (cnt == 0)
+		return;
+
+	/* Set low-watermark 3/4th's of the way into the queue. */
+	descr = card->tx_chain.tail;
+	cnt = (cnt*3)/4;
+	for (i=0;i<cnt; i++)
+		descr = descr->next;
+
+	/* Set the new watermark, clear the old wtermark */
+	descr->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
+	if (card->low_watermark && card->low_watermark != descr)
+		card->low_watermark->dmac_cmd_status =
+		     card->low_watermark->dmac_cmd_status & ~SPIDER_NET_DESCR_TXDESFLG;
+	card->low_watermark = descr;
+}
+
 /**
  * spider_net_release_tx_chain - processes sent tx descriptors
  * @card: adapter structure
@@ -717,6 +750,7 @@ spider_net_release_tx_chain(struct spide
 {
 	struct spider_net_descr_chain *chain = &card->tx_chain;
 	int status;
+	int rc=0;
 
 	spider_net_read_reg(card, SPIDER_NET_GDTDMACCNTR);
 
@@ -729,8 +763,10 @@ spider_net_release_tx_chain(struct spide
 			break;
 
 		case SPIDER_NET_DESCR_CARDOWNED:
-			if (!brutal)
-				return 1;
+			if (!brutal) {
+				rc = 1;
+				goto done;
+			}
 			/* fallthrough, if we release the descriptors
 			 * brutally (then we don't care about
 			 * SPIDER_NET_DESCR_CARDOWNED) */
@@ -747,12 +783,15 @@ spider_net_release_tx_chain(struct spide
 
 		default:
 			card->netdev_stats.tx_dropped++;
-			return 1;
+			rc = 1;
+			goto done;
 		}
 		spider_net_release_tx_descr(card);
 	}
-
-	return 0;
+done:
+	if (rc == 1)
+		spider_net_set_low_watermark(card);
+	return rc;
 }
 
 /**
@@ -1453,6 +1492,10 @@ spider_net_interrupt(int irq, void *ptr,
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(netdev);
 	}
+	if (status_reg & SPIDER_NET_TXINT ) {
+		spider_net_cleanup_tx_ring(card);
+		netif_wake_queue(netdev);
+	}
 
 	if (status_reg & SPIDER_NET_ERRINT )
 		spider_net_handle_error_irq(card, status_reg);
@@ -1615,6 +1658,9 @@ spider_net_open(struct net_device *netde
 			card->descr,
 			PCI_DMA_TODEVICE, tx_descriptors))
 		goto alloc_tx_failed;
+
+	card->low_watermark = NULL;
+
 	if (spider_net_init_chain(card, &card->rx_chain,
 			card->descr + tx_descriptors,
 			PCI_DMA_FROMDEVICE, rx_descriptors))
Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.h	2006-08-11 11:09:57.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.h	2006-08-11 11:19:47.000000000 -0500
@@ -47,7 +47,7 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_TX_DESCRIPTORS_MIN		16
 #define SPIDER_NET_TX_DESCRIPTORS_MAX		512
 
-#define SPIDER_NET_TX_TIMER			20
+#define SPIDER_NET_TX_TIMER			(HZ/5)
 
 #define SPIDER_NET_RX_CSUM_DEFAULT		1
 
@@ -209,7 +209,7 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_DMA_RX_FEND_VALUE	0x00030003
 /* to set TX_DMA_EN */
 #define SPIDER_NET_TX_DMA_EN		0x80000000
-#define SPIDER_NET_GDTDCEIDIS		0x00000302
+#define SPIDER_NET_GDTDCEIDIS		0x00000300
 #define SPIDER_NET_DMA_TX_VALUE		SPIDER_NET_TX_DMA_EN | \
 					SPIDER_NET_GDTDCEIDIS
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
@@ -349,6 +349,7 @@ enum spider_net_int2_status {
 #define SPIDER_NET_DESCR_FORCE_END		0x50000000 /* used in rx and tx */
 #define SPIDER_NET_DESCR_CARDOWNED		0xA0000000 /* used in rx and tx */
 #define SPIDER_NET_DESCR_NOT_IN_USE		0xF0000000
+#define SPIDER_NET_DESCR_TXDESFLG		0x00800000
 
 struct spider_net_descr {
 	/* as defined by the hardware */
@@ -424,6 +425,7 @@ struct spider_net_card {
 
 	struct spider_net_descr_chain tx_chain;
 	struct spider_net_descr_chain rx_chain;
+	struct spider_net_descr *low_watermark;
 
 	struct net_device_stats netdev_stats;
 
