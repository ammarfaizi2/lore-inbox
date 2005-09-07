Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVIGPSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVIGPSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVIGPSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:18:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63702 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932167AbVIGPSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:18:00 -0400
Date: Wed, 7 Sep 2005 08:17:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][MM] cleanup rionet and use updated rio message interface
Message-ID: <20050907081751.C1925@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the rionet cleanup patch previously posted in reply to Jeff's
concerns with this driver. It depends on the rapidio messaging interface
updates patch. 

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -25,7 +25,7 @@
 #include <linux/ethtool.h>
 
 #define DRV_NAME        "rionet"
-#define DRV_VERSION     "0.1"
+#define DRV_VERSION     "0.2"
 #define DRV_AUTHOR      "Matt Porter <mporter@kernel.crashing.org>"
 #define DRV_DESC        "Ethernet over RapidIO"
 
@@ -33,7 +33,12 @@ MODULE_AUTHOR(DRV_AUTHOR);
 MODULE_DESCRIPTION(DRV_DESC);
 MODULE_LICENSE("GPL");
 
-#define RIONET_DEFAULT_MSGLEVEL	0
+#define RIONET_DEFAULT_MSGLEVEL \
+			(NETIF_MSG_DRV          | \
+			 NETIF_MSG_LINK         | \
+			 NETIF_MSG_RX_ERR       | \
+			 NETIF_MSG_TX_ERR)
+
 #define RIONET_DOORBELL_JOIN	0x1000
 #define RIONET_DOORBELL_LEAVE	0x1001
 
@@ -66,7 +71,6 @@ struct rionet_peer {
 
 static int rionet_check = 0;
 static int rionet_capable = 1;
-static struct net_device *sndev = NULL;
 
 /*
  * This is a fast lookup table for for translating TX
@@ -103,10 +107,8 @@ static int rionet_rx_clean(struct net_de
 	i = rnet->rx_slot;
 
 	do {
-		if (!rnet->rx_skb[i]) {
-			rnet->stats.rx_dropped++;
+		if (!rnet->rx_skb[i])
 			continue;
-		}
 
 		if (!(data = rio_get_inb_message(rnet->mport, RIONET_MAILBOX)))
 			break;
@@ -168,8 +170,8 @@ static int rionet_queue_tx_msg(struct sk
 	if (++rnet->tx_cnt == RIONET_TX_RING_SIZE)
 		netif_stop_queue(ndev);
 
-	if (++rnet->tx_slot == RIONET_TX_RING_SIZE)
-		rnet->tx_slot = 0;
+	++rnet->tx_slot;
+	rnet->tx_slot &= (RIONET_TX_RING_SIZE - 1);
 
 	if (netif_msg_tx_queued(rnet))
 		printk(KERN_INFO "%s: queued skb %8.8x len %8.8x\n", DRV_NAME,
@@ -201,14 +203,6 @@ static int rionet_start_xmit(struct sk_b
 	}
 
 	if (eth->h_dest[0] & 0x01) {
-		/*
-		 * XXX Need to delay queuing if ring max is reached,
-		 * flush additional packets in tx_event() before
-		 * awakening the queue. We can easily exceed ring
-		 * size with a large number of nodes or even a
-		 * small number where the ring is relatively full
-		 * on entrance to hard_start_xmit.
-		 */
 		for (i = 0; i < RIO_MAX_ROUTE_ENTRIES; i++)
 			if (rionet_active[i])
 				rionet_queue_tx_msg(skb, ndev,
@@ -224,22 +218,10 @@ static int rionet_start_xmit(struct sk_b
 	return 0;
 }
 
-static int rionet_set_mac_address(struct net_device *ndev, void *p)
-{
-	struct sockaddr *addr = p;
-
-	if (!is_valid_ether_addr(addr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	memcpy(ndev->dev_addr, addr->sa_data, ndev->addr_len);
-
-	return 0;
-}
-
-static void rionet_dbell_event(struct rio_mport *mport, u16 sid, u16 tid,
+static void rionet_dbell_event(struct rio_mport *mport, void *dev_id, u16 sid, u16 tid,
 			       u16 info)
 {
-	struct net_device *ndev = sndev;
+	struct net_device *ndev = dev_id;
 	struct rionet_private *rnet = ndev->priv;
 	struct rionet_peer *peer;
 
@@ -264,10 +246,10 @@ static void rionet_dbell_event(struct ri
 	}
 }
 
-static void rionet_inb_msg_event(struct rio_mport *mport, int mbox, int slot)
+static void rionet_inb_msg_event(struct rio_mport *mport, void *dev_id, int mbox, int slot)
 {
 	int n;
-	struct net_device *ndev = sndev;
+	struct net_device *ndev = dev_id;
 	struct rionet_private *rnet = (struct rionet_private *)ndev->priv;
 
 	if (netif_msg_intr(rnet))
@@ -280,9 +262,9 @@ static void rionet_inb_msg_event(struct 
 	spin_unlock(&rnet->lock);
 }
 
-static void rionet_outb_msg_event(struct rio_mport *mport, int mbox, int slot)
+static void rionet_outb_msg_event(struct rio_mport *mport, void *dev_id, int mbox, int slot)
 {
-	struct net_device *ndev = sndev;
+	struct net_device *ndev = dev_id;
 	struct rionet_private *rnet = ndev->priv;
 
 	spin_lock(&rnet->lock);
@@ -296,8 +278,8 @@ static void rionet_outb_msg_event(struct
 		/* dma unmap single */
 		dev_kfree_skb_irq(rnet->tx_skb[rnet->ack_slot]);
 		rnet->tx_skb[rnet->ack_slot] = NULL;
-		if (++rnet->ack_slot == RIONET_TX_RING_SIZE)
-			rnet->ack_slot = 0;
+		++rnet->ack_slot;
+		rnet->ack_slot &= (RIONET_TX_RING_SIZE - 1);
 		rnet->tx_cnt--;
 	}
 
@@ -318,18 +300,21 @@ static int rionet_open(struct net_device
 		printk(KERN_INFO "%s: open\n", DRV_NAME);
 
 	if ((rc = rio_request_inb_dbell(rnet->mport,
+					(void *)ndev,
 					RIONET_DOORBELL_JOIN,
 					RIONET_DOORBELL_LEAVE,
 					rionet_dbell_event)) < 0)
 		goto out;
 
 	if ((rc = rio_request_inb_mbox(rnet->mport,
+				       (void *)ndev,
 				       RIONET_MAILBOX,
 				       RIONET_RX_RING_SIZE,
 				       rionet_inb_msg_event)) < 0)
 		goto out;
 
 	if ((rc = rio_request_outb_mbox(rnet->mport,
+					(void *)ndev,
 					RIONET_MAILBOX,
 					RIONET_TX_RING_SIZE,
 					rionet_outb_msg_event)) < 0)
@@ -425,7 +410,7 @@ static void rionet_get_drvinfo(struct ne
 	strcpy(info->driver, DRV_NAME);
 	strcpy(info->version, DRV_VERSION);
 	strcpy(info->fw_version, "n/a");
-	sprintf(info->bus_info, "RIO master port %d", rnet->mport->id);
+	strcpy(info->bus_info, rnet->mport->name);
 }
 
 static u32 rionet_get_msglevel(struct net_device *ndev)
@@ -465,13 +450,6 @@ static int rionet_setup_netdev(struct ri
 		goto out;
 	}
 
-	/*
-	 * XXX hack, store point a static at ndev so we can get it...
-	 * Perhaps need an array of these that the handler can
-	 * index via the mbox number.
-	 */
-	sndev = ndev;
-
 	/* Set up private area */
 	rnet = (struct rionet_private *)ndev->priv;
 	rnet->mport = mport;
@@ -490,7 +468,6 @@ static int rionet_setup_netdev(struct ri
 	ndev->hard_start_xmit = &rionet_start_xmit;
 	ndev->stop = &rionet_close;
 	ndev->get_stats = &rionet_stats;
-	ndev->set_mac_address = &rionet_set_mac_address;
 	ndev->mtu = RIO_MAX_MSG_SIZE - 14;
 	ndev->features = NETIF_F_LLTX;
 	SET_ETHTOOL_OPS(ndev, &rionet_ethtool_ops);
