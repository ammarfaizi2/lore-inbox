Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWAUWES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWAUWES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWAUWDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:03:37 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:42845 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932404AbWAUWDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:03:17 -0500
Subject: [git patch review 4/5] IPoIB: Lock accesses to multicast packet queues
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 21 Jan 2006 22:03:10 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137880990999-7f911bca79a83d08@cisco.com>
In-Reply-To: <1137880990999-449ff8b55b88bcaa@cisco.com>
X-OriginalArrivalTime: 21 Jan 2006 22:03:14.0883 (UTC) FILETIME=[7A35F930:01C61ED6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid corrupting mcast->pkt_queue by serializing access with
priv->tx_lock.  Also, update dropped packet statistics to count
multicast packets removed from pkt_queue as dropped.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   25 +++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

b36f170b617a7cd147b694dabf504e856a50ee9d
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 98039da..ccaa0c3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -97,6 +97,7 @@ static void ipoib_mcast_free(struct ipoi
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_neigh *neigh, *tmp;
 	unsigned long flags;
+	int tx_dropped = 0;
 
 	ipoib_dbg_mcast(netdev_priv(dev),
 			"deleting multicast group " IPOIB_GID_FMT "\n",
@@ -123,8 +124,14 @@ static void ipoib_mcast_free(struct ipoi
 	if (mcast->ah)
 		ipoib_put_ah(mcast->ah);
 
-	while (!skb_queue_empty(&mcast->pkt_queue))
+	while (!skb_queue_empty(&mcast->pkt_queue)) {
+		++tx_dropped;
 		dev_kfree_skb_any(skb_dequeue(&mcast->pkt_queue));
+	}
+
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	priv->stats.tx_dropped += tx_dropped;
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
 	kfree(mcast);
 }
@@ -276,8 +283,10 @@ static int ipoib_mcast_join_finish(struc
 	}
 
 	/* actually send any queued packets */
+	spin_lock_irq(&priv->tx_lock);
 	while (!skb_queue_empty(&mcast->pkt_queue)) {
 		struct sk_buff *skb = skb_dequeue(&mcast->pkt_queue);
+		spin_unlock_irq(&priv->tx_lock);
 
 		skb->dev = dev;
 
@@ -288,7 +297,9 @@ static int ipoib_mcast_join_finish(struc
 
 		if (dev_queue_xmit(skb))
 			ipoib_warn(priv, "dev_queue_xmit failed to requeue packet\n");
+		spin_lock_irq(&priv->tx_lock);
 	}
+	spin_unlock_irq(&priv->tx_lock);
 
 	return 0;
 }
@@ -300,6 +311,7 @@ ipoib_mcast_sendonly_join_complete(int s
 {
 	struct ipoib_mcast *mcast = mcast_ptr;
 	struct net_device *dev = mcast->dev;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
 	if (!status)
 		ipoib_mcast_join_finish(mcast, mcmember);
@@ -310,8 +322,12 @@ ipoib_mcast_sendonly_join_complete(int s
 					IPOIB_GID_ARG(mcast->mcmember.mgid), status);
 
 		/* Flush out any queued packets */
-		while (!skb_queue_empty(&mcast->pkt_queue))
+		spin_lock_irq(&priv->tx_lock);
+		while (!skb_queue_empty(&mcast->pkt_queue)) {
+			++priv->stats.tx_dropped;
 			dev_kfree_skb_any(skb_dequeue(&mcast->pkt_queue));
+		}
+		spin_unlock_irq(&priv->tx_lock);
 
 		/* Clear the busy flag so we try again */
 		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
@@ -687,6 +703,7 @@ void ipoib_mcast_send(struct net_device 
 		if (!mcast) {
 			ipoib_warn(priv, "unable to allocate memory for "
 				   "multicast structure\n");
+			++priv->stats.tx_dropped;
 			dev_kfree_skb_any(skb);
 			goto out;
 		}
@@ -700,8 +717,10 @@ void ipoib_mcast_send(struct net_device 
 	if (!mcast->ah) {
 		if (skb_queue_len(&mcast->pkt_queue) < IPOIB_MAX_MCAST_QUEUE)
 			skb_queue_tail(&mcast->pkt_queue, skb);
-		else
+		else {
+			++priv->stats.tx_dropped;
 			dev_kfree_skb_any(skb);
+		}
 
 		if (mcast->query)
 			ipoib_dbg_mcast(priv, "no address vector, "
-- 
1.1.3
