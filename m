Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWBKUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWBKUWs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWBKUWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:22:30 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:50497 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932354AbWBKUW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:22:27 -0500
Subject: [git patch review 2/4] IPoIB: Fix another send-only join race
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 11 Feb 2006 20:22:21 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1139689341370-af4160238007a6e3@cisco.com>
In-Reply-To: <1139689341370-68b63fa9b8e76d91@cisco.com>
X-OriginalArrivalTime: 11 Feb 2006 20:22:24.0263 (UTC) FILETIME=[DE6F6170:01C62F48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further, there's an additional issue that I saw in testing:
ipoib_mcast_send may get called when priv->broadcast is NULL (e.g. if
the device was downed and then upped internally because of a port
event).

If this happends and the send-only join request gets completed before
priv->broadcast is set, we get an oops.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7bcb974ef6a0ae903888272c92c66ea779388c01
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 1c71482..932bf13 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -701,7 +701,7 @@ void ipoib_mcast_send(struct net_device 
 	 */
 	spin_lock(&priv->lock);
 
-	if (!test_bit(IPOIB_MCAST_STARTED, &priv->flags)) {
+	if (!test_bit(IPOIB_MCAST_STARTED, &priv->flags) || !priv->broadcast) {
 		++priv->stats.tx_dropped;
 		dev_kfree_skb_any(skb);
 		goto unlock;
-- 
1.1.3
