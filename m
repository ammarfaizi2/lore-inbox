Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbVKCXLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbVKCXLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbVKCXLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:11:05 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22347 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030499AbVKCXLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:11:04 -0500
Subject: [git patch review 4/7] [IPoIB] don't compile debug code if debugging
	isn't enabled
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 03 Nov 2005 23:10:59 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131059459423-c39565dcb8db8aaa@cisco.com>
In-Reply-To: <1131059459423-3dc7f03665037bf0@cisco.com>
X-OriginalArrivalTime: 03 Nov 2005 23:11:00.0495 (UTC) FILETIME=[DADEE1F0:01C5E0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't build ipoib_mcast_iter_ functions if CONFIG_INFINIBAND_IPOIB_DEBUG
is not enabled -- their only callers will not be built either.

Also move the prototype for ipoib_open() to ipoib.h to fix a sparse warning.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib.h           |    3 +++
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    1 -
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    4 ++++
 3 files changed, 7 insertions(+), 1 deletions(-)

applies-to: 3179960b8e0f3ccb4feff19eb5582298d48324a0
8ae5a8a24f7fe797027d481f88c1464b0e47eede
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index c994a91..0095acc 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -235,6 +235,7 @@ static inline void ipoib_put_ah(struct i
 	kref_put(&ah->ref, ipoib_free_ah);
 }
 
+int ipoib_open(struct net_device *dev);
 int ipoib_add_pkey_attr(struct net_device *dev);
 
 void ipoib_send(struct net_device *dev, struct sk_buff *skb,
@@ -267,6 +268,7 @@ int ipoib_mcast_stop_thread(struct net_d
 void ipoib_mcast_dev_down(struct net_device *dev);
 void ipoib_mcast_dev_flush(struct net_device *dev);
 
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
 struct ipoib_mcast_iter *ipoib_mcast_iter_init(struct net_device *dev);
 void ipoib_mcast_iter_free(struct ipoib_mcast_iter *iter);
 int ipoib_mcast_iter_next(struct ipoib_mcast_iter *iter);
@@ -276,6 +278,7 @@ void ipoib_mcast_iter_read(struct ipoib_
 				  unsigned int *queuelen,
 				  unsigned int *complete,
 				  unsigned int *send_only);
+#endif
 
 int ipoib_mcast_attach(struct net_device *dev, u16 mlid,
 		       union ib_gid *mgid);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 0a6f578..54ef2fe 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -636,7 +636,6 @@ void ipoib_ib_dev_cleanup(struct net_dev
  * Bug #2507. This implementation will probably be removed when the P_Key
  * change async notification is available.
  */
-int ipoib_open(struct net_device *dev);
 
 static void ipoib_pkey_dev_check_presence(struct net_device *dev)
 {
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 022eec7..3ecf78a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -917,6 +917,8 @@ void ipoib_mcast_restart_task(void *dev_
 		ipoib_mcast_start_thread(dev);
 }
 
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
+
 struct ipoib_mcast_iter *ipoib_mcast_iter_init(struct net_device *dev)
 {
 	struct ipoib_mcast_iter *iter;
@@ -989,3 +991,5 @@ void ipoib_mcast_iter_read(struct ipoib_
 	*complete  = iter->complete;
 	*send_only = iter->send_only;
 }
+
+#endif /* CONFIG_INFINIBAND_IPOIB_DEBUG */
---
0.99.9
