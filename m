Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVCCGIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVCCGIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVCCFd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:33:58 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261488AbVCCFbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:50 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][10/11] IB/ipoib: don't call ipoib_put_ah with lock held
In-Reply-To: <2005322131.kDy0lnKe0rjDV0tv@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.HYDDjSPPN3QdHwmF@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:23.0023 (UTC) FILETIME=[3C89C9F0:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shirley Ma <xma@us.ibm.com>

ipoib_put_ah() may call ipoib_free_ah(), which might take the device's
lock.  Therefore we need to make sure we don't call ipoib_put_ah()
when holding the lock already.

Signed-off-by: Shirley Ma <xma@us.ibm.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-02 20:26:13.653524436 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-02 20:26:13.977454122 -0800
@@ -661,6 +661,7 @@
 	struct ipoib_neigh *neigh = *to_ipoib_neigh(n);
 	struct ipoib_dev_priv *priv = netdev_priv(n->dev);
 	unsigned long flags;
+	struct ipoib_ah *ah = NULL;
 
 	ipoib_dbg(priv,
 		  "neigh_destructor for %06x " IPOIB_GID_FMT "\n",
@@ -671,13 +672,16 @@
 
 	if (neigh) {
 		if (neigh->ah)
-			ipoib_put_ah(neigh->ah);
+			ah = neigh->ah;
 		list_del(&neigh->list);
 		*to_ipoib_neigh(n) = NULL;
 		kfree(neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
+	
+	if (ah)
+		ipoib_put_ah(ah);
 }
 
 static int ipoib_neigh_setup(struct neighbour *neigh)
--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-03-02 20:26:12.799709771 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-03-02 20:26:13.977454122 -0800
@@ -93,6 +93,8 @@
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_neigh *neigh, *tmp;
 	unsigned long flags;
+	LIST_HEAD(ah_list);
+	struct ipoib_ah *ah, *tah;
 
 	ipoib_dbg_mcast(netdev_priv(dev),
 			"deleting multicast group " IPOIB_GID_FMT "\n",
@@ -101,7 +103,8 @@
 	spin_lock_irqsave(&priv->lock, flags);
 
 	list_for_each_entry_safe(neigh, tmp, &mcast->neigh_list, list) {
-		ipoib_put_ah(neigh->ah);
+		if (neigh->ah)
+			list_add_tail(&neigh->ah->list, &ah_list);
 		*to_ipoib_neigh(neigh->neighbour) = NULL;
 		neigh->neighbour->ops->destructor = NULL;
 		kfree(neigh);
@@ -109,6 +112,9 @@
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	list_for_each_entry_safe(ah, tah, &ah_list, list)
+		ipoib_put_ah(ah);
+
 	if (mcast->ah)
 		ipoib_put_ah(mcast->ah);
 

