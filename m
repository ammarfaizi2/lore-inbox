Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVCCGIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVCCGIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVCCFdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:33:00 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261489AbVCCFbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:52 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][11/11] IB/ipoib: fix locking on path deletion
In-Reply-To: <2005322131.HYDDjSPPN3QdHwmF@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.6juV8g9K5T9OJ7gu@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:23.0085 (UTC) FILETIME=[3C933FD0:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up locking for IPoIB path table.  Make sure that destruction of
address handles, neighbour info and path structs is locked properly to
avoid races and deadlocks.  (Problem originally diagnosed by Shirley Ma)

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-02 20:26:13.977454122 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-02 20:26:14.301383808 -0800
@@ -215,16 +215,25 @@
 	return 0;
 }
 
-static void __path_free(struct net_device *dev, struct ipoib_path *path)
+static void path_free(struct net_device *dev, struct ipoib_path *path)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_neigh *neigh, *tn;
 	struct sk_buff *skb;
+	unsigned long flags;
 
 	while ((skb = __skb_dequeue(&path->queue)))
 		dev_kfree_skb_irq(skb);
 
+	spin_lock_irqsave(&priv->lock, flags);
+
 	list_for_each_entry_safe(neigh, tn, &path->neigh_list, list) {
+		/*
+		 * It's safe to call ipoib_put_ah() inside priv->lock
+		 * here, because we know that path->ah will always
+		 * hold one more reference, so ipoib_put_ah() will
+		 * never do more than decrement the ref count.
+		 */
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
 		*to_ipoib_neigh(neigh->neighbour) = NULL;
@@ -232,11 +241,11 @@
 		kfree(neigh);
 	}
 
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	if (path->ah)
 		ipoib_put_ah(path->ah);
 
-	rb_erase(&path->rb_node, &priv->path_tree);
-	list_del(&path->list);
 	kfree(path);
 }
 
@@ -248,15 +257,20 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
 	list_splice(&priv->path_list, &remove_list);
 	INIT_LIST_HEAD(&priv->path_list);
+
+	list_for_each_entry(path, &remove_list, list)
+		rb_erase(&path->rb_node, &priv->path_tree);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	list_for_each_entry_safe(path, tp, &remove_list, list) {
 		if (path->query)
 			ib_sa_cancel_query(path->query_id, path->query);
 		wait_for_completion(&path->done);
-		__path_free(dev, path);
+		path_free(dev, path);
 	}
 }
 
@@ -361,8 +375,6 @@
 	path->pathrec.pkey      = cpu_to_be16(priv->pkey);
 	path->pathrec.numb_path = 1;
 
-	__path_add(dev, path);
-
 	return path;
 }
 
@@ -422,6 +434,8 @@
 				       (union ib_gid *) (skb->dst->neighbour->ha + 4));
 		if (!path)
 			goto err;
+
+		__path_add(dev, path);
 	}
 
 	list_add_tail(&neigh->list, &path->neigh_list);
@@ -497,8 +511,12 @@
 			skb_push(skb, sizeof *phdr);
 			__skb_queue_tail(&path->queue, skb);
 
-			if (path_rec_start(dev, path))
-				__path_free(dev, path);
+			if (path_rec_start(dev, path)) {
+				spin_unlock(&priv->lock);
+				path_free(dev, path);
+				return;
+			} else
+				__path_add(dev, path);
 		} else {
 			++priv->stats.tx_dropped;
 			dev_kfree_skb_any(skb);
@@ -658,7 +676,7 @@
 
 static void ipoib_neigh_destructor(struct neighbour *n)
 {
-	struct ipoib_neigh *neigh = *to_ipoib_neigh(n);
+	struct ipoib_neigh *neigh;
 	struct ipoib_dev_priv *priv = netdev_priv(n->dev);
 	unsigned long flags;
 	struct ipoib_ah *ah = NULL;
@@ -670,6 +688,7 @@
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	neigh = *to_ipoib_neigh(n);
 	if (neigh) {
 		if (neigh->ah)
 			ah = neigh->ah;

