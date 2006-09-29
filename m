Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWI2XRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWI2XRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbWI2XRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:17:36 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30413 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422643AbWI2XRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:17:33 -0400
Date: Fri, 29 Sep 2006 18:17:30 -0500
To: jeff@garzik.org, akpm@osdl.org
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060929231730.GJ6433@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929230552.GG6433@austin.ibm.com>
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

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   56 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/net/spider_net.h |    6 +++--
 2 files changed, 55 insertions(+), 7 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-09-29 14:11:20.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-09-29 16:33:46.000000000 -0500
@@ -703,6 +703,39 @@ spider_net_release_tx_descr(struct spide
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
@@ -720,6 +753,7 @@ spider_net_release_tx_chain(struct spide
 {
 	struct spider_net_descr_chain *chain = &card->tx_chain;
 	int status;
+	int rc=0;
 
 	spider_net_read_reg(card, SPIDER_NET_GDTDMACCNTR);
 
@@ -732,8 +766,10 @@ spider_net_release_tx_chain(struct spide
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
@@ -750,12 +786,15 @@ spider_net_release_tx_chain(struct spide
 
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
@@ -1460,6 +1499,10 @@ spider_net_interrupt(int irq, void *ptr,
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(netdev);
 	}
+	if (status_reg & SPIDER_NET_TXINT ) {
+		spider_net_cleanup_tx_ring(card);
+		netif_wake_queue(netdev);
+	}
 
 	if (status_reg & SPIDER_NET_ERRINT )
 		spider_net_handle_error_irq(card, status_reg);
@@ -1621,6 +1664,9 @@ spider_net_open(struct net_device *netde
 	if (spider_net_init_chain(card, &card->tx_chain, card->descr,
 			PCI_DMA_TODEVICE, card->tx_desc))
 		goto alloc_tx_failed;
+
+	card->low_watermark = NULL;
+
 	if (spider_net_init_chain(card, &card->rx_chain,
 			card->descr + card->rx_desc,
 			PCI_DMA_FROMDEVICE, card->rx_desc))
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-09-29 14:47:50.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-09-29 16:33:43.000000000 -0500
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
@@ -433,6 +434,7 @@ struct spider_net_card {
 
 	struct spider_net_descr_chain tx_chain;
 	struct spider_net_descr_chain rx_chain;
+	struct spider_net_descr *low_watermark;
 
 	struct net_device_stats netdev_stats;
 
