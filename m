Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWAJTb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWAJTb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWAJTbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:31:31 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:44614 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932368AbWAJTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:31:28 -0500
X-IronPort-AV: i="3.99,351,1131350400"; 
   d="scan'208"; a="389971620:sNHT29530614"
Subject: [git patch review 6/7] IPoIB: Fix error path in
	ipoib_mcast_dev_flush()
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 10 Jan 2006 19:31:23 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136921483291-3de733b4b68e8e4a@cisco.com>
In-Reply-To: <1136921483291-1d87adb85e116682@cisco.com>
X-OriginalArrivalTime: 10 Jan 2006 19:31:25.0167 (UTC) FILETIME=[71DA5FF0:01C6161C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't leak memory on allocation failure for broadcast mcast group.
Also, print a warning to match handling for other mcast groups.

Signed-off-by: Eli Cohen <eli@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

70b4c8cdc168bb5d18e23fd205c4ede1b756a8b2
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index ed0c2ea..6c6db75 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -780,9 +780,11 @@ void ipoib_mcast_dev_flush(struct net_de
 					&priv->multicast_tree);
 
 			list_add_tail(&priv->broadcast->list, &remove_list);
-		}
-
-		priv->broadcast = nmcast;
+			priv->broadcast = nmcast;
+		} else
+			ipoib_warn(priv, "could not reallocate broadcast group "
+                        	          IPOIB_GID_FMT "\n",
+                                	  IPOIB_GID_ARG(priv->broadcast->mcmember.mgid));
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
1.0.7
