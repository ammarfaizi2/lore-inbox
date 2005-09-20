Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVITWI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVITWI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVITWIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:08:51 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:52121 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965167AbVITWI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:28 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 09/10] IPoIB: Don't flush workqueue from within workqueue
In-Reply-To: <2005920158.z5ALwijFYEKC7SAF@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:11 -0700
Message-Id: <2005920158.3byIBzMT2aE3fDZQ@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:12.0980 (UTC) FILETIME=[CB14B740:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] IPoIB: Don't flush workqueue from within workqueue

ipoib_mcast_restart_task() is always called from within the
single-threaded IPoIB workqueue, so flushing the workqueue from within
the function can lead to a recursion overflow.  But since we're
running in a single-threaded workqueue, we're already synchronized
against other items in the workqueue, so just get rid of the flush in
ipoib_mcast_restart_task().

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib.h           |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    4 ++--
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

8d2cae0651502028bf64844508ab18528bbd65c2
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -257,7 +257,7 @@ void ipoib_mcast_send(struct net_device 
 
 void ipoib_mcast_restart_task(void *dev_ptr);
 int ipoib_mcast_start_thread(struct net_device *dev);
-int ipoib_mcast_stop_thread(struct net_device *dev);
+int ipoib_mcast_stop_thread(struct net_device *dev, int flush);
 
 void ipoib_mcast_dev_down(struct net_device *dev);
 void ipoib_mcast_dev_flush(struct net_device *dev);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -432,7 +432,7 @@ int ipoib_ib_dev_down(struct net_device 
 		flush_workqueue(ipoib_workqueue);
 	}
 
-	ipoib_mcast_stop_thread(dev);
+	ipoib_mcast_stop_thread(dev, 1);
 
 	/*
 	 * Flush the multicast groups first so we stop any multicast joins. The
@@ -599,7 +599,7 @@ void ipoib_ib_dev_cleanup(struct net_dev
 
 	ipoib_dbg(priv, "cleaning up ib_dev\n");
 
-	ipoib_mcast_stop_thread(dev);
+	ipoib_mcast_stop_thread(dev, 1);
 
 	/* Delete the broadcast address and the local address */
 	ipoib_mcast_dev_down(dev);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -598,7 +598,7 @@ int ipoib_mcast_start_thread(struct net_
 	return 0;
 }
 
-int ipoib_mcast_stop_thread(struct net_device *dev)
+int ipoib_mcast_stop_thread(struct net_device *dev, int flush)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_mcast *mcast;
@@ -610,7 +610,8 @@ int ipoib_mcast_stop_thread(struct net_d
 	cancel_delayed_work(&priv->mcast_task);
 	up(&mcast_mutex);
 
-	flush_workqueue(ipoib_workqueue);
+	if (flush)
+		flush_workqueue(ipoib_workqueue);
 
 	if (priv->broadcast && priv->broadcast->query) {
 		ib_sa_cancel_query(priv->broadcast->query_id, priv->broadcast->query);
@@ -832,7 +833,7 @@ void ipoib_mcast_restart_task(void *dev_
 
 	ipoib_dbg_mcast(priv, "restarting multicast task\n");
 
-	ipoib_mcast_stop_thread(dev);
+	ipoib_mcast_stop_thread(dev, 0);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
