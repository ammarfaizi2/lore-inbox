Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965274AbVKHGax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbVKHGax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbVKHGab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:30:31 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22383 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965274AbVKHGa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:30:28 -0500
Subject: [git patch review 5/6] [IPoIB] no need to set skb->dev right before
	freeing skb
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 08 Nov 2005 06:30:19 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131431419061-26662c4d4f27ac0a@cisco.com>
In-Reply-To: <1131431419060-bf0b43a20ac24b6a@cisco.com>
X-OriginalArrivalTime: 08 Nov 2005 06:30:20.0303 (UTC) FILETIME=[E43161F0:01C5E42D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For cut-and-paste reasons, the IPoIB driver was setting skb->dev right
before calling dev_kfree_skb_any().  Get rid of this.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

applies-to: 8b16a6a547ff0459044c3698ff9ac1d33c84eaf4
6277da1d7c70d2fcaeeb74c3b20fc1645da0f1fe
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 8709693..c33ed87 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -120,12 +120,8 @@ static void ipoib_mcast_free(struct ipoi
 	if (mcast->ah)
 		ipoib_put_ah(mcast->ah);
 
-	while (!skb_queue_empty(&mcast->pkt_queue)) {
-		struct sk_buff *skb = skb_dequeue(&mcast->pkt_queue);
-
-		skb->dev = dev;
-		dev_kfree_skb_any(skb);
-	}
+	while (!skb_queue_empty(&mcast->pkt_queue))
+		dev_kfree_skb_any(skb_dequeue(&mcast->pkt_queue));
 
 	kfree(mcast);
 }
@@ -317,13 +313,8 @@ ipoib_mcast_sendonly_join_complete(int s
 					IPOIB_GID_ARG(mcast->mcmember.mgid), status);
 
 		/* Flush out any queued packets */
-		while (!skb_queue_empty(&mcast->pkt_queue)) {
-			struct sk_buff *skb = skb_dequeue(&mcast->pkt_queue);
-
-			skb->dev = dev;
-
-			dev_kfree_skb_any(skb);
-		}
+		while (!skb_queue_empty(&mcast->pkt_queue))
+			dev_kfree_skb_any(skb_dequeue(&mcast->pkt_queue));
 
 		/* Clear the busy flag so we try again */
 		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
---
0.99.9e
