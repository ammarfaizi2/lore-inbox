Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVK3A54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVK3A54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVK3A5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:57:33 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37405 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750745AbVK3A5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:57:32 -0500
Subject: [git patch review 3/8] IPoIB: reinitialize mcast structs' completions
	for every query
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 00:57:25 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133312245796-cb4f80534d10c1b9@cisco.com>
In-Reply-To: <1133312245796-b000d53a5b61afe0@cisco.com>
X-OriginalArrivalTime: 30 Nov 2005 00:57:27.0003 (UTC) FILETIME=[08442AB0:01C5F549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure mcast->done is initialized to uncompleted value before we
submit a new query, so that it's safe to wait on.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

applies-to: 993e77f7c00b7bc296e96f0cec1c98ea28a0436a
de922487890936470660e89f9095aee980637989
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index c33ed87..10404e0 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -135,8 +135,6 @@ static struct ipoib_mcast *ipoib_mcast_a
 	if (!mcast)
 		return NULL;
 
-	init_completion(&mcast->done);
-
 	mcast->dev = dev;
 	mcast->created = jiffies;
 	mcast->backoff = 1;
@@ -350,6 +348,8 @@ static int ipoib_mcast_sendonly_join(str
 	rec.port_gid = priv->local_gid;
 	rec.pkey     = cpu_to_be16(priv->pkey);
 
+	init_completion(&mcast->done);
+
 	ret = ib_sa_mcmember_rec_set(priv->ca, priv->port, &rec,
 				     IB_SA_MCMEMBER_REC_MGID		|
 				     IB_SA_MCMEMBER_REC_PORT_GID	|
@@ -469,6 +469,8 @@ static void ipoib_mcast_join(struct net_
 		rec.traffic_class = priv->broadcast->mcmember.traffic_class;
 	}
 
+	init_completion(&mcast->done);
+
 	ret = ib_sa_mcmember_rec_set(priv->ca, priv->port, &rec, comp_mask,
 				     mcast->backoff * 1000, GFP_ATOMIC,
 				     ipoib_mcast_join_complete,
---
0.99.9k
