Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVITWJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVITWJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVITWJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:09:11 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:48177 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965028AbVITWI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:26 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 04/10] IPoIB: Fix SA client retransmission strategy
In-Reply-To: <2005920158.ofLOVgpQOqw9UR3J@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:11 -0700
Message-Id: <2005920158.QCEMsU9kiixrkQEA@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:12.0259 (UTC) FILETIME=[CAA6B330:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hal Rosenstock <halr@voltaire.com>

We got a little mixed up with what the backoff member holds in the
IPoIB multicast group structure: sometimes it was used as a number of
seconds, and sometimes it was used as a number of jiffies.  Fix the
code so that backoff is always in seconds.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>


---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

d24ef0519e081774db6a1515ad8dadefd3fcd508
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -145,7 +145,7 @@ static struct ipoib_mcast *ipoib_mcast_a
 
 	mcast->dev = dev;
 	mcast->created = jiffies;
-	mcast->backoff = HZ;
+	mcast->backoff = 1;
 	mcast->logcount = 0;
 
 	INIT_LIST_HEAD(&mcast->list);
@@ -396,7 +396,7 @@ static void ipoib_mcast_join_complete(in
 			IPOIB_GID_ARG(mcast->mcmember.mgid), status);
 
 	if (!status && !ipoib_mcast_join_finish(mcast, mcmember)) {
-		mcast->backoff = HZ;
+		mcast->backoff = 1;
 		down(&mcast_mutex);
 		if (test_bit(IPOIB_MCAST_RUN, &priv->flags))
 			queue_work(ipoib_workqueue, &priv->mcast_task);
@@ -496,7 +496,7 @@ static void ipoib_mcast_join(struct net_
 		if (test_bit(IPOIB_MCAST_RUN, &priv->flags))
 			queue_delayed_work(ipoib_workqueue,
 					   &priv->mcast_task,
-					   mcast->backoff);
+					   mcast->backoff * HZ);
 		up(&mcast_mutex);
 	} else
 		mcast->query_id = ret;
