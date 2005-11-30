Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVK3A6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVK3A6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVK3A6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:58:08 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37405 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750749AbVK3A5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:57:34 -0500
Subject: [git patch review 5/8] IPoIB: protect child list in ipoib_ib_dev_flush
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 00:57:25 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133312245797-01403858bd5f112a@cisco.com>
In-Reply-To: <1133312245797-2006ed5b68ef5482@cisco.com>
X-OriginalArrivalTime: 30 Nov 2005 00:57:27.0081 (UTC) FILETIME=[08501190:01C5F549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

race condition: ipoib_ib_dev_flush is accessing child list without locks.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_ib.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

applies-to: e58f418dd8e64675b1dbaa6db92d7c1e606d1506
4f71055a45a503273c039d80db8ba9b13cb17549
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 54ef2fe..2388580 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -608,9 +608,13 @@ void ipoib_ib_dev_flush(void *_dev)
 	if (test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
 		ipoib_ib_dev_up(dev);
 
+	down(&priv->vlan_mutex);
+
 	/* Flush any child interfaces too */
 	list_for_each_entry(cpriv, &priv->child_intfs, list)
 		ipoib_ib_dev_flush(&cpriv->dev);
+
+	up(&priv->vlan_mutex);
 }
 
 void ipoib_ib_dev_cleanup(struct net_device *dev)
---
0.99.9k
