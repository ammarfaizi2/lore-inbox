Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161587AbWAMAN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161587AbWAMAN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161588AbWAMAN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:13:26 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:14129 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1161587AbWAMANZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:13:25 -0500
Subject: [git patch review 2/6] IPoIB: Fix memory leak of multicast group
	structures
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 13 Jan 2006 00:13:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137111197380-f482e88c451680c0@cisco.com>
In-Reply-To: <1137111197380-341f286bd5273779@cisco.com>
X-OriginalArrivalTime: 13 Jan 2006 00:13:22.0565 (UTC) FILETIME=[2A3BF350:01C617D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current handling of multicast groups in IPoIB ends up never
freeing send-only multicast groups.  It turns out the logic was much
more complicated than it needed to be; we can fix this bug and
completely kill ipoib_mcast_dev_down() at the same time.

Signed-off-by: Eli Cohen <eli@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |   13 -----
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   61 +++---------------------
 2 files changed, 9 insertions(+), 65 deletions(-)

988bd50300ef2e2d5cb8563e2ac99453dd9acd86
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 2388580..f7e8489 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -453,17 +453,8 @@ int ipoib_ib_dev_down(struct net_device 
 	}
 
 	ipoib_mcast_stop_thread(dev, 1);
-
-	/*
-	 * Flush the multicast groups first so we stop any multicast joins. The
-	 * completion thread may have already died and we may deadlock waiting
-	 * for the completion thread to finish some multicast joins.
-	 */
 	ipoib_mcast_dev_flush(dev);
 
-	/* Delete broadcast and local addresses since they will be recreated */
-	ipoib_mcast_dev_down(dev);
-
 	ipoib_flush_paths(dev);
 
 	return 0;
@@ -624,9 +615,7 @@ void ipoib_ib_dev_cleanup(struct net_dev
 	ipoib_dbg(priv, "cleaning up ib_dev\n");
 
 	ipoib_mcast_stop_thread(dev, 1);
-
-	/* Delete the broadcast address and the local address */
-	ipoib_mcast_dev_down(dev);
+	ipoib_mcast_dev_flush(dev);
 
 	ipoib_transport_dev_cleanup(dev);
 }
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index bf1c08c..7403bac 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -742,50 +742,23 @@ void ipoib_mcast_dev_flush(struct net_de
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	LIST_HEAD(remove_list);
-	struct ipoib_mcast *mcast, *tmcast, *nmcast;
+	struct ipoib_mcast *mcast, *tmcast;
 	unsigned long flags;
 
 	ipoib_dbg_mcast(priv, "flushing multicast list\n");
 
 	spin_lock_irqsave(&priv->lock, flags);
-	list_for_each_entry_safe(mcast, tmcast, &priv->multicast_list, list) {
-		nmcast = ipoib_mcast_alloc(dev, 0);
-		if (nmcast) {
-			nmcast->flags =
-				mcast->flags & (1 << IPOIB_MCAST_FLAG_SENDONLY);
-
-			nmcast->mcmember.mgid = mcast->mcmember.mgid;
-
-			/* Add the new group in before the to-be-destroyed group */
-			list_add_tail(&nmcast->list, &mcast->list);
-			list_del_init(&mcast->list);
-
-			rb_replace_node(&mcast->rb_node, &nmcast->rb_node,
-					&priv->multicast_tree);
 
-			list_add_tail(&mcast->list, &remove_list);
-		} else {
-			ipoib_warn(priv, "could not reallocate multicast group "
-				   IPOIB_GID_FMT "\n",
-				   IPOIB_GID_ARG(mcast->mcmember.mgid));
-		}
+	list_for_each_entry_safe(mcast, tmcast, &priv->multicast_list, list) {
+		list_del(&mcast->list);
+		rb_erase(&mcast->rb_node, &priv->multicast_tree);
+		list_add_tail(&mcast->list, &remove_list);
 	}
 
 	if (priv->broadcast) {
-		nmcast = ipoib_mcast_alloc(dev, 0);
-		if (nmcast) {
-			nmcast->mcmember.mgid = priv->broadcast->mcmember.mgid;
-
-			rb_replace_node(&priv->broadcast->rb_node,
-					&nmcast->rb_node,
-					&priv->multicast_tree);
-
-			list_add_tail(&priv->broadcast->list, &remove_list);
-			priv->broadcast = nmcast;
-		} else
-			ipoib_warn(priv, "could not reallocate broadcast group "
-                        	          IPOIB_GID_FMT "\n",
-                                	  IPOIB_GID_ARG(priv->broadcast->mcmember.mgid));
+ 		rb_erase(&priv->broadcast->rb_node, &priv->multicast_tree);
+		list_add_tail(&priv->broadcast->list, &remove_list);
+		priv->broadcast = NULL;
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -796,24 +769,6 @@ void ipoib_mcast_dev_flush(struct net_de
 	}
 }
 
-void ipoib_mcast_dev_down(struct net_device *dev)
-{
-	struct ipoib_dev_priv *priv = netdev_priv(dev);
-	unsigned long flags;
-
-	/* Delete broadcast since it will be recreated */
-	if (priv->broadcast) {
-		ipoib_dbg_mcast(priv, "deleting broadcast group\n");
-
-		spin_lock_irqsave(&priv->lock, flags);
-		rb_erase(&priv->broadcast->rb_node, &priv->multicast_tree);
-		spin_unlock_irqrestore(&priv->lock, flags);
-		ipoib_mcast_leave(dev, priv->broadcast);
-		ipoib_mcast_free(priv->broadcast);
-		priv->broadcast = NULL;
-	}
-}
-
 void ipoib_mcast_restart_task(void *dev_ptr)
 {
 	struct net_device *dev = dev_ptr;
-- 
1.0.7
