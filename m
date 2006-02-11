Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWBKUWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWBKUWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBKUW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:22:28 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:18612 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932355AbWBKUW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:22:26 -0500
X-IronPort-AV: i="4.02,105,1139212800"; 
   d="scan'208"; a="403834578:sNHT30067932"
Subject: [git patch review 4/4] IPoIB: Yet another fix for send-only joins
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 11 Feb 2006 20:22:21 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1139689341371-7b843cf913438d83@cisco.com>
In-Reply-To: <1139689341370-48a55ba994088cbc@cisco.com>
X-OriginalArrivalTime: 11 Feb 2006 20:22:24.0513 (UTC) FILETIME=[DE958710:01C62F48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even after the last fix, it's still possible for a send-only join to
start before the join for the broadcast group has finished.  This
could cause us to create a multicast group using attributes from the
broadcast group that haven't been initialized yet, so we would use
garbage for the Q_Key, etc.  Fix this by waiting until the broadcast
group's attached flag is set before starting send-only joins.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

20b83382d1c5d4d1a73fc5671261db5239d1dbb3
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 932bf13..a2408d7 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -533,8 +533,10 @@ void ipoib_mcast_join_task(void *dev_ptr
 	}
 
 	if (!priv->broadcast) {
-		priv->broadcast = ipoib_mcast_alloc(dev, 1);
-		if (!priv->broadcast) {
+		struct ipoib_mcast *broadcast;
+
+		broadcast = ipoib_mcast_alloc(dev, 1);
+		if (!broadcast) {
 			ipoib_warn(priv, "failed to allocate broadcast group\n");
 			mutex_lock(&mcast_mutex);
 			if (test_bit(IPOIB_MCAST_RUN, &priv->flags))
@@ -544,10 +546,11 @@ void ipoib_mcast_join_task(void *dev_ptr
 			return;
 		}
 
-		memcpy(priv->broadcast->mcmember.mgid.raw, priv->dev->broadcast + 4,
+		spin_lock_irq(&priv->lock);
+		memcpy(broadcast->mcmember.mgid.raw, priv->dev->broadcast + 4,
 		       sizeof (union ib_gid));
+		priv->broadcast = broadcast;
 
-		spin_lock_irq(&priv->lock);
 		__ipoib_mcast_add(dev, priv->broadcast);
 		spin_unlock_irq(&priv->lock);
 	}
@@ -701,7 +704,9 @@ void ipoib_mcast_send(struct net_device 
 	 */
 	spin_lock(&priv->lock);
 
-	if (!test_bit(IPOIB_MCAST_STARTED, &priv->flags) || !priv->broadcast) {
+	if (!test_bit(IPOIB_MCAST_STARTED, &priv->flags)	||
+	    !priv->broadcast					||
+	    !test_bit(IPOIB_MCAST_FLAG_ATTACHED, &priv->broadcast->flags)) {
 		++priv->stats.tx_dropped;
 		dev_kfree_skb_any(skb);
 		goto unlock;
-- 
1.1.3
