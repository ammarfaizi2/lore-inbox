Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVFGAOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVFGAOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVFFXyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:54:33 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:49696 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261775AbVFFXwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:52:36 -0400
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: rionet updates
In-Reply-To: <11181019442621@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Jun 2005 16:52:24 -0700
Message-Id: <11181019443007@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Matt Porter <mporter@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanups, eliminate unused paths, and add LLTX support.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

commit d651f0979ebfb203624159507a2b04ac896844ab
tree c9dffe54b25b6992025f074de1fe9901adc8d6ef
parent 7cfb63a2fce0dbb82507bb6035352df1718624f2
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 13:57:52 -0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 13:57:52 -0700

 drivers/net/rionet.c |   73 ++++++++++++++++----------------------------------
 1 files changed, 24 insertions(+), 49 deletions(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -42,7 +42,7 @@ MODULE_LICENSE("GPL");
 #define RIONET_TX_RING_SIZE	CONFIG_RIONET_TX_SIZE
 #define RIONET_RX_RING_SIZE	CONFIG_RIONET_RX_SIZE
 
-LIST_HEAD(rionet_peers);
+static LIST_HEAD(rionet_peers);
 
 struct rionet_private {
 	struct rio_mport *mport;
@@ -54,6 +54,7 @@ struct rionet_private {
 	int tx_cnt;
 	int ack_slot;
 	spinlock_t lock;
+	spinlock_t tx_lock;
 	u32 msg_enable;
 };
 
@@ -112,9 +113,9 @@ static int rionet_rx_clean(struct net_de
 
 		rnet->rx_skb[i]->data = data;
 		skb_put(rnet->rx_skb[i], RIO_MAX_MSG_SIZE);
-		rnet->rx_skb[i]->dev = sndev;
+		rnet->rx_skb[i]->dev = ndev;
 		rnet->rx_skb[i]->protocol =
-		    eth_type_trans(rnet->rx_skb[i], sndev);
+		    eth_type_trans(rnet->rx_skb[i], ndev);
 		error = netif_rx(rnet->rx_skb[i]);
 
 		if (error == NET_RX_DROP) {
@@ -183,13 +184,20 @@ static int rionet_start_xmit(struct sk_b
 	struct rionet_private *rnet = ndev->priv;
 	struct ethhdr *eth = (struct ethhdr *)skb->data;
 	u16 destid;
+	unsigned long flags;
 
-	spin_lock_irq(&rnet->lock);
-
+	local_irq_save(flags);
+	if (!spin_trylock(&rnet->tx_lock)) {
+		local_irq_restore(flags);
+		return NETDEV_TX_LOCKED;
+	}
+	
 	if ((rnet->tx_cnt + 1) > RIONET_TX_RING_SIZE) {
 		netif_stop_queue(ndev);
-		spin_unlock_irq(&rnet->lock);
-		return -EBUSY;
+		spin_unlock_irqrestore(&rnet->tx_lock, flags);
+		printk(KERN_ERR "%s: BUG! Tx Ring full when queue awake!\n",
+		       ndev->name);
+		return NETDEV_TX_BUSY;
 	}
 
 	if (eth->h_dest[0] & 0x01) {
@@ -211,7 +219,7 @@ static int rionet_start_xmit(struct sk_b
 			rionet_queue_tx_msg(skb, ndev, rionet_active[destid]);
 	}
 
-	spin_unlock_irq(&rnet->lock);
+	spin_unlock_irqrestore(&rnet->tx_lock, flags);
 
 	return 0;
 }
@@ -228,27 +236,6 @@ static int rionet_set_mac_address(struct
 	return 0;
 }
 
-static int rionet_change_mtu(struct net_device *ndev, int new_mtu)
-{
-	struct rionet_private *rnet = ndev->priv;
-
-	if (netif_msg_drv(rnet))
-		printk(KERN_WARNING
-		       "%s: rionet_change_mtu(): not implemented\n", DRV_NAME);
-
-	return 0;
-}
-
-static void rionet_set_multicast_list(struct net_device *ndev)
-{
-	struct rionet_private *rnet = ndev->priv;
-
-	if (netif_msg_drv(rnet))
-		printk(KERN_WARNING
-		       "%s: rionet_set_multicast_list(): not implemented\n",
-		       DRV_NAME);
-}
-
 static void rionet_dbell_event(struct rio_mport *mport, u16 sid, u16 tid,
 			       u16 info)
 {
@@ -358,10 +345,6 @@ static int rionet_open(struct net_device
 	rnet->tx_cnt = 0;
 	rnet->ack_slot = 0;
 
-	spin_lock_init(&rnet->lock);
-
-	rnet->msg_enable = RIONET_DEFAULT_MSGLEVEL;
-
 	netif_carrier_on(ndev);
 	netif_start_queue(ndev);
 
@@ -434,11 +417,6 @@ static void rionet_remove(struct rio_dev
 	}
 }
 
-static int rionet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
-{
-	return -EOPNOTSUPP;
-}
-
 static void rionet_get_drvinfo(struct net_device *ndev,
 			       struct ethtool_drvinfo *info)
 {
@@ -464,16 +442,11 @@ static void rionet_set_msglevel(struct n
 	rnet->msg_enable = value;
 }
 
-static u32 rionet_get_link(struct net_device *ndev)
-{
-	return netif_carrier_ok(ndev);
-}
-
 static struct ethtool_ops rionet_ethtool_ops = {
 	.get_drvinfo = rionet_get_drvinfo,
 	.get_msglevel = rionet_get_msglevel,
 	.set_msglevel = rionet_set_msglevel,
-	.get_link = rionet_get_link,
+	.get_link = ethtool_op_get_link,
 };
 
 static int rionet_setup_netdev(struct rio_mport *mport)
@@ -517,16 +490,18 @@ static int rionet_setup_netdev(struct ri
 	ndev->hard_start_xmit = &rionet_start_xmit;
 	ndev->stop = &rionet_close;
 	ndev->get_stats = &rionet_stats;
-	ndev->change_mtu = &rionet_change_mtu;
 	ndev->set_mac_address = &rionet_set_mac_address;
-	ndev->set_multicast_list = &rionet_set_multicast_list;
-	ndev->do_ioctl = &rionet_ioctl;
-	SET_ETHTOOL_OPS(ndev, &rionet_ethtool_ops);
-
 	ndev->mtu = RIO_MAX_MSG_SIZE - 14;
+	ndev->features = NETIF_F_LLTX;
+	SET_ETHTOOL_OPS(ndev, &rionet_ethtool_ops);
 
 	SET_MODULE_OWNER(ndev);
 
+	spin_lock_init(&rnet->lock);
+	spin_lock_init(&rnet->tx_lock);
+
+	rnet->msg_enable = RIONET_DEFAULT_MSGLEVEL;
+
 	rc = register_netdev(ndev);
 	if (rc != 0)
 		goto out;


