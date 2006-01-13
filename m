Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161589AbWAMAOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161589AbWAMAOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161596AbWAMAN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:13:56 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:64036 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1161597AbWAMAN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:13:29 -0500
X-IronPort-AV: i="3.99,361,1131350400"; 
   d="scan'208"; a="391186707:sNHT3493684054"
Subject: [git patch review 1/6] IPoIB: Take dev->xmit_lock around mc_list
	accesses
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 13 Jan 2006 00:13:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137111197380-341f286bd5273779@cisco.com>
X-OriginalArrivalTime: 13 Jan 2006 00:13:21.0174 (UTC) FILETIME=[2967B360:01C617D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dev->mc_list accesses must be protected by dev->xmit_lock.
Found by Eli Cohen <eli@mellanox.co.il>.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

78bfe0b5b67fe126ed98608e42e42fb6ed9aabd4
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 03b2ca6..bf1c08c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -827,7 +827,8 @@ void ipoib_mcast_restart_task(void *dev_
 
 	ipoib_mcast_stop_thread(dev, 0);
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&dev->xmit_lock, flags);
+	spin_lock(&priv->lock);
 
 	/*
 	 * Unfortunately, the networking core only gives us a list of all of
@@ -899,7 +900,9 @@ void ipoib_mcast_restart_task(void *dev_
 			list_add_tail(&mcast->list, &remove_list);
 		}
 	}
-	spin_unlock_irqrestore(&priv->lock, flags);
+
+	spin_unlock(&priv->lock);
+	spin_unlock_irqrestore(&dev->xmit_lock, flags);
 
 	/* We have to cancel outside of the spinlock */
 	list_for_each_entry_safe(mcast, tmcast, &remove_list, list) {
-- 
1.0.7
