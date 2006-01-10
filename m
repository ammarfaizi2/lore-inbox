Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWAJTb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWAJTb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWAJTbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:31:32 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:49805 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932411AbWAJTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:31:28 -0500
Subject: [git patch review 7/7] IPoIB: Fix address handle refcounting for
	multicast groups
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 10 Jan 2006 19:31:23 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136921483291-0b87fc4bec2544c5@cisco.com>
In-Reply-To: <1136921483291-3de733b4b68e8e4a@cisco.com>
X-OriginalArrivalTime: 10 Jan 2006 19:31:25.0254 (UTC) FILETIME=[71E7A660:01C6161C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple ipoib_neigh structures on mcast->neigh_list may point to the
same ah.  This means that ipoib_mcast_free() can't just make a list of
ah structs to free, since this might end up trying to add the same ah
to the list more than once.  Handle this in ipoib_multicast.c in the
same way as it is handled in ipoib_main.c for struct ipoib_path.

Signed-off-by: Eli Cohen <eli@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

97460df37ea3335ca11562568932c9f9facfecdb
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 6c6db75..03b2ca6 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -97,8 +97,6 @@ static void ipoib_mcast_free(struct ipoi
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_neigh *neigh, *tmp;
 	unsigned long flags;
-	LIST_HEAD(ah_list);
-	struct ipoib_ah *ah, *tah;
 
 	ipoib_dbg_mcast(netdev_priv(dev),
 			"deleting multicast group " IPOIB_GID_FMT "\n",
@@ -107,8 +105,14 @@ static void ipoib_mcast_free(struct ipoi
 	spin_lock_irqsave(&priv->lock, flags);
 
 	list_for_each_entry_safe(neigh, tmp, &mcast->neigh_list, list) {
+		/*
+		 * It's safe to call ipoib_put_ah() inside priv->lock
+		 * here, because we know that mcast->ah will always
+		 * hold one more reference, so ipoib_put_ah() will
+		 * never do more than decrement the ref count.
+		 */
 		if (neigh->ah)
-			list_add_tail(&neigh->ah->list, &ah_list);
+			ipoib_put_ah(neigh->ah);
 		*to_ipoib_neigh(neigh->neighbour) = NULL;
 		neigh->neighbour->ops->destructor = NULL;
 		kfree(neigh);
@@ -116,9 +120,6 @@ static void ipoib_mcast_free(struct ipoi
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	list_for_each_entry_safe(ah, tah, &ah_list, list)
-		ipoib_put_ah(ah);
-
 	if (mcast->ah)
 		ipoib_put_ah(mcast->ah);
 
-- 
1.0.7
