Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWBKUW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWBKUW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBKUW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:22:26 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:14709 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932348AbWBKUWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:22:25 -0500
X-IronPort-AV: i="4.02,105,1139212800"; 
   d="scan'208"; a="403834565:sNHT30373384"
Subject: [git patch review 1/4] IPoIB: Don't start send-only joins while
	multicast thread is stopped
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 11 Feb 2006 20:22:21 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1139689341370-68b63fa9b8e76d91@cisco.com>
X-OriginalArrivalTime: 11 Feb 2006 20:22:23.0091 (UTC) FILETIME=[DDBC8C30:01C62F48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following race scenario:
  - Device is up.
  - Port event or set mcast list triggers ipoib_mcast_stop_thread,
    this cancels the query and waits on mcast "done" completion.
  - Completion is called and "done" is set.
  - Meanwhile, ipoib_mcast_send arrives and starts a new query,
    re-initializing "done".

Fix this by adding a "multicast started" bit and checking it before
starting a send-only join.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib.h           |    1 +
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

479a079663bd4c5f3d2714643b1b8c406aaba3e0
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index e0a5412..2f85a9a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -78,6 +78,7 @@ enum {
 	IPOIB_FLAG_SUBINTERFACE   = 4,
 	IPOIB_MCAST_RUN 	  = 5,
 	IPOIB_STOP_REAPER         = 6,
+	IPOIB_MCAST_STARTED       = 7,
 
 	IPOIB_MAX_BACKOFF_SECONDS = 16,
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index ccaa0c3..1c71482 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -601,6 +601,10 @@ int ipoib_mcast_start_thread(struct net_
 		queue_work(ipoib_workqueue, &priv->mcast_task);
 	mutex_unlock(&mcast_mutex);
 
+	spin_lock_irq(&priv->lock);
+	set_bit(IPOIB_MCAST_STARTED, &priv->flags);
+	spin_unlock_irq(&priv->lock);
+
 	return 0;
 }
 
@@ -611,6 +615,10 @@ int ipoib_mcast_stop_thread(struct net_d
 
 	ipoib_dbg_mcast(priv, "stopping multicast thread\n");
 
+	spin_lock_irq(&priv->lock);
+	clear_bit(IPOIB_MCAST_STARTED, &priv->flags);
+	spin_unlock_irq(&priv->lock);
+
 	mutex_lock(&mcast_mutex);
 	clear_bit(IPOIB_MCAST_RUN, &priv->flags);
 	cancel_delayed_work(&priv->mcast_task);
@@ -693,6 +701,12 @@ void ipoib_mcast_send(struct net_device 
 	 */
 	spin_lock(&priv->lock);
 
+	if (!test_bit(IPOIB_MCAST_STARTED, &priv->flags)) {
+		++priv->stats.tx_dropped;
+		dev_kfree_skb_any(skb);
+		goto unlock;
+	}
+
 	mcast = __ipoib_mcast_find(dev, mgid);
 	if (!mcast) {
 		/* Let's create a new send only group now */
@@ -754,6 +768,7 @@ out:
 		ipoib_send(dev, skb, mcast->ah, IB_MULTICAST_QPN);
 	}
 
+unlock:
 	spin_unlock(&priv->lock);
 }
 
-- 
1.1.3
