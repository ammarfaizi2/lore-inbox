Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWAWQDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWAWQDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWAWQDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:03:09 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:8462 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932303AbWAWQDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:03:08 -0500
X-IronPort-AV: i="4.01,212,1136188800"; 
   d="scan'208"; a="1769163136:sNHT34096916"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand fixes for 2.6.16
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 23 Jan 2006 08:03:03 -0800
Message-ID: <adar76zort4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 23 Jan 2006 16:03:05.0229 (UTC) FILETIME=[7EADF3D0:01C62036]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Michael S. Tsirkin:
      IPoIB: Make sure path is fully initialized before using it
      IB/uverbs: Flush scheduled work before unloading module
      IB/sa_query: Flush scheduled work before unloading module
      IPoIB: Lock accesses to multicast packet queues
      IB/mthca: Use correct GID in MADs sent on port 2

 drivers/infiniband/core/sa_query.c             |    2 ++
 drivers/infiniband/core/uverbs_main.c          |    1 +
 drivers/infiniband/hw/mthca/mthca_av.c         |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |    4 ++--
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   25 +++++++++++++++++++++---
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index acda7d6..501cc05 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -956,6 +956,8 @@ static void ib_sa_remove_one(struct ib_d
 
 	ib_unregister_event_handler(&sa_dev->event_handler);
 
+	flush_scheduled_work();
+
 	for (i = 0; i <= sa_dev->end_port - sa_dev->start_port; ++i) {
 		ib_unregister_mad_agent(sa_dev->port[i].agent);
 		kref_put(&sa_dev->port[i].sm_ah->ref, free_sm_ah);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 96ea79b..903f85a 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -902,6 +902,7 @@ static void __exit ib_uverbs_cleanup(voi
 	unregister_filesystem(&uverbs_event_fs);
 	class_destroy(uverbs_class);
 	unregister_chrdev_region(IB_UVERBS_BASE_DEV, IB_UVERBS_MAX_DEVICES);
+	flush_scheduled_work();
 	idr_destroy(&ib_uverbs_pd_idr);
 	idr_destroy(&ib_uverbs_mr_idr);
 	idr_destroy(&ib_uverbs_mw_idr);
diff --git a/drivers/infiniband/hw/mthca/mthca_av.c b/drivers/infiniband/hw/mthca/mthca_av.c
index a14eed0..a19e0ed 100644
--- a/drivers/infiniband/hw/mthca/mthca_av.c
+++ b/drivers/infiniband/hw/mthca/mthca_av.c
@@ -184,7 +184,7 @@ int mthca_read_ah(struct mthca_dev *dev,
 			ah->av->sl_tclass_flowlabel & cpu_to_be32(0xfffff);
 		ib_get_cached_gid(&dev->ib_dev,
 				  be32_to_cpu(ah->av->port_pd) >> 24,
-				  ah->av->gid_index,
+				  ah->av->gid_index % dev->limits.gid_table_len,
 				  &header->grh.source_gid);
 		memcpy(header->grh.destination_gid.raw,
 		       ah->av->dgid, 16);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index fd3f5c8..c3b5f79 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -505,7 +505,7 @@ static void neigh_add_path(struct sk_buf
 
 	list_add_tail(&neigh->list, &path->neigh_list);
 
-	if (path->pathrec.dlid) {
+	if (path->ah) {
 		kref_get(&path->ah->ref);
 		neigh->ah = path->ah;
 
@@ -591,7 +591,7 @@ static void unicast_arp_send(struct sk_b
 		return;
 	}
 
-	if (path->pathrec.dlid) {
+	if (path->ah) {
 		ipoib_dbg(priv, "Send unicast ARP to %04x\n",
 			  be16_to_cpu(path->pathrec.dlid));
 
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
