Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWARVUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWARVUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWARVUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:20:06 -0500
Received: from [194.90.237.34] ([194.90.237.34]:61336 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1161002AbWARVUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:20:02 -0500
Date: Wed, 18 Jan 2006 23:20:18 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Cc: openib-general@openib.org, Roland Dreier <rolandd@cisco.com>
Subject: Repost [PATCH 3 of 3] ipoib: fix error handling
Message-ID: <20060118212018.GG31280@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about reposting: the message didnt seem to make it to netdev.

---

The following patch is not directly related to the destructor issue,
but I'm posting it here fore completeness since it needs to be applied on top of
the previous pair of patches in the destructor series.

---

Fix error handling in neigh_add_path.
Reduce code duplication by implementing alloc/free functions for ipoib_neigh.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.15/drivers/infiniband/ulp/ipoib/ipoib_main.c
===================================================================
--- linux-2.6.15.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2006-01-12 20:48:06.000000000 +0200
+++ linux-2.6.15/drivers/infiniband/ulp/ipoib/ipoib_main.c	2006-01-12 20:48:43.000000000 +0200
@@ -246,8 +246,7 @@ static void path_free(struct net_device 
 		 */
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
-		*to_ipoib_neigh(neigh->neighbour) = NULL;
-		kfree(neigh);
+		ipoib_neigh_free(neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -475,7 +474,7 @@ static void neigh_add_path(struct sk_buf
 	struct ipoib_path *path;
 	struct ipoib_neigh *neigh;
 
-	neigh = kmalloc(sizeof *neigh, GFP_ATOMIC);
+	neigh = ipoib_neigh_alloc(skb->dst->neighbour);
 	if (!neigh) {
 		++priv->stats.tx_dropped;
 		dev_kfree_skb_any(skb);
@@ -483,8 +482,6 @@ static void neigh_add_path(struct sk_buf
 	}
 
 	skb_queue_head_init(&neigh->queue);
-	neigh->neighbour = skb->dst->neighbour;
-	*to_ipoib_neigh(skb->dst->neighbour) = neigh;
 
 	/*
 	 * We can only be called from ipoib_start_xmit, so we're
@@ -497,7 +494,7 @@ static void neigh_add_path(struct sk_buf
 		path = path_rec_create(dev,
 				       (union ib_gid *) (skb->dst->neighbour->ha + 4));
 		if (!path)
-			goto err;
+			goto err_path;
 
 		__path_add(dev, path);
 	}
@@ -527,10 +524,9 @@ static void neigh_add_path(struct sk_buf
 	return;
 
 err:
-	*to_ipoib_neigh(skb->dst->neighbour) = NULL;
 	list_del(&neigh->list);
-	kfree(neigh);
-
+err_path:
+	ipoib_neigh_free(neigh);
 	++priv->stats.tx_dropped;
 	dev_kfree_skb_any(skb);
 
@@ -757,8 +753,7 @@ static void ipoib_neigh_destructor(struc
 		if (neigh->ah)
 			ah = neigh->ah;
 		list_del(&neigh->list);
-		*to_ipoib_neigh(n) = NULL;
-		kfree(neigh);
+		ipoib_neigh_free(neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -766,6 +761,26 @@ static void ipoib_neigh_destructor(struc
 	if (ah)
 		ipoib_put_ah(ah);
 }
+ 
+struct ipoib_neigh *ipoib_neigh_alloc(struct neighbour *neighbour)
+{
+	struct ipoib_neigh *neigh;
+
+	neigh = kmalloc(sizeof *neigh, GFP_ATOMIC);
+	if (!neigh)
+		return NULL;
+
+	neigh->neighbour = neighbour;
+	*to_ipoib_neigh(neighbour) = neigh;
+
+	return neigh;
+}
+
+void ipoib_neigh_free(struct ipoib_neigh *neigh)
+{
+	*to_ipoib_neigh(neigh->neighbour) = NULL;
+	kfree(neigh);
+}
 
 static int ipoib_neigh_setup_dev(struct net_device *dev, struct neigh_parms *parms)
 {
Index: linux-2.6.15/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
===================================================================
--- linux-2.6.15.orig/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2006-01-12 20:32:08.000000000 +0200
+++ linux-2.6.15/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2006-01-12 20:48:43.000000000 +0200
@@ -113,8 +113,7 @@ static void ipoib_mcast_free(struct ipoi
 		 */
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
-		*to_ipoib_neigh(neigh->neighbour) = NULL;
-		kfree(neigh);
+		ipoib_neigh_free(neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -720,13 +719,11 @@ out:
 		if (skb->dst            &&
 		    skb->dst->neighbour &&
 		    !*to_ipoib_neigh(skb->dst->neighbour)) {
-			struct ipoib_neigh *neigh = kmalloc(sizeof *neigh, GFP_ATOMIC);
+			struct ipoib_neigh *neigh = ipoib_neigh_alloc(skb->dst->neighbour);
 
 			if (neigh) {
 				kref_get(&mcast->ah->ref);
 				neigh->ah  	= mcast->ah;
-				neigh->neighbour = skb->dst->neighbour;
-				*to_ipoib_neigh(skb->dst->neighbour) = neigh;
 				list_add_tail(&neigh->list, &mcast->neigh_list);
 			}
 		}
Index: linux-2.6.15/drivers/infiniband/ulp/ipoib/ipoib.h
===================================================================
--- linux-2.6.15.orig/drivers/infiniband/ulp/ipoib/ipoib.h	2006-01-12 20:27:47.000000000 +0200
+++ linux-2.6.15/drivers/infiniband/ulp/ipoib/ipoib.h	2006-01-12 20:48:43.000000000 +0200
@@ -222,6 +222,9 @@ static inline struct ipoib_neigh **to_ip
 					(offsetof(struct neighbour, ha) & 4));
 }
 
+struct ipoib_neigh *ipoib_neigh_alloc(struct neighbour *neigh);
+void ipoib_neigh_free(struct ipoib_neigh *neigh);
+
 extern struct workqueue_struct *ipoib_workqueue;
 
 /* functions */

-- 
MST
