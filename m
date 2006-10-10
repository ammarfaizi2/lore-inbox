Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWJJVLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWJJVLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWJJVLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:11:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:2252 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030395AbWJJVLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:11:35 -0400
Date: Tue, 10 Oct 2006 16:11:33 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 13/21]: powerpc/cell spidernet low watermark patch.
Message-ID: <20061010211133.GJ4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/spider_net.h |    8 ++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:03:11.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:09:27.000000000 -0500
@@ -684,6 +684,7 @@ spider_net_prepare_tx_descr(struct spide
 			break;
 		}
 
+	/* Chain the bus address, so that the DMA engine finds this descr. */
 	descr->prev->next_descr_addr = descr->bus_addr;
 
 	card->netdev->trans_start = jiffies; /* set netdev watchdog timer */
@@ -717,6 +718,41 @@ spider_net_release_tx_descr(struct spide
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
+
+	/* If TX queue is short, don't even bother with interrupts */
+	if (cnt < card->tx_desc/4)
+		return;
+
+	/* Set low-watermark 3/4th's of the way into the queue. */
+	descr = card->tx_chain.tail;
+	cnt = (cnt*3)/4;
+	for (i=0;i<cnt; i++)
+		descr = descr->next;
+
+	/* Set the new watermark, clear the old watermark */
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
@@ -838,6 +874,7 @@ spider_net_xmit(struct sk_buff *skb, str
 		return NETDEV_TX_BUSY;
 	}
 
+	spider_net_set_low_watermark(card);
 	spider_net_kick_tx_dma(card);
 	card->tx_chain.head = card->tx_chain.head->next;
 	spin_unlock_irqrestore(&chain->lock, flags);
@@ -1467,6 +1504,10 @@ spider_net_interrupt(int irq, void *ptr,
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(netdev);
 	}
+	if (status_reg & SPIDER_NET_TXINT ) {
+		spider_net_cleanup_tx_ring(card);
+		netif_wake_queue(netdev);
+	}
 
 	if (status_reg & SPIDER_NET_ERRINT )
 		spider_net_handle_error_irq(card, status_reg);
@@ -1629,6 +1670,8 @@ spider_net_open(struct net_device *netde
 			PCI_DMA_TODEVICE, card->tx_desc))
 		goto alloc_tx_failed;
 
+	card->low_watermark = NULL;
+
 	/* rx_chain is after tx_chain, so offset is descr + tx_count */
 	if (spider_net_init_chain(card, &card->rx_chain,
 			card->descr + card->tx_desc,
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-10 12:54:06.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-10 13:09:27.000000000 -0500
@@ -49,7 +49,7 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_TX_DESCRIPTORS_MIN		16
 #define SPIDER_NET_TX_DESCRIPTORS_MAX		512
 
-#define SPIDER_NET_TX_TIMER			20
+#define SPIDER_NET_TX_TIMER			(HZ/5)
 
 #define SPIDER_NET_RX_CSUM_DEFAULT		1
 
@@ -328,9 +328,7 @@ enum spider_net_int2_status {
 	SPIDER_NET_GRISPDNGINT
 };
 
-#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GTTEDINT) | \
-				  (1 << SPIDER_NET_GDTDCEINT) | \
-				  (1 << SPIDER_NET_GDTFDCINT) )
+#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) )
 
 /* We rely on flagged descriptor interrupts */
 #define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) )
@@ -356,6 +354,7 @@ enum spider_net_int2_status {
 #define SPIDER_NET_DESCR_FORCE_END		0x50000000 /* used in rx and tx */
 #define SPIDER_NET_DESCR_CARDOWNED		0xA0000000 /* used in rx and tx */
 #define SPIDER_NET_DESCR_NOT_IN_USE		0xF0000000
+#define SPIDER_NET_DESCR_TXDESFLG		0x00800000
 
 struct spider_net_descr {
 	/* as defined by the hardware */
@@ -440,6 +439,7 @@ struct spider_net_card {
 
 	struct spider_net_descr_chain tx_chain;
 	struct spider_net_descr_chain rx_chain;
+	struct spider_net_descr *low_watermark;
 
 	struct net_device_stats netdev_stats;
 
