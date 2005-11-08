Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965271AbVKHGay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbVKHGay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbVKHGaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:30:30 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:27941 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965271AbVKHGa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:30:28 -0500
Subject: [git patch review 2/6] [IB] umad: two small fixes
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 08 Nov 2005 06:30:19 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131431419060-1bf7238b3fe2f830@cisco.com>
In-Reply-To: <1131431419060-378986988cf168d2@cisco.com>
X-OriginalArrivalTime: 08 Nov 2005 06:30:20.0065 (UTC) FILETIME=[E40D1110:01C5E42D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two small fixes for the umad module:
 - set kobject name for issm device properly
 - in ib_umad_add_one(), s is subtracted from the index i when
   initializing ports, so s should be subtracted from the index when
   freeing ports in the error path as well.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/user_mad.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: ea857a2670e77bd8e8e8538f42504bcaa1a515d5
8b37b94721533f2729c79bcb6fa0bb3e2bc2f400
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index aed5ca2..6aefeed 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -801,7 +801,7 @@ static int ib_umad_init_port(struct ib_d
 		goto err_class;
 	port->sm_dev->owner = THIS_MODULE;
 	port->sm_dev->ops   = &umad_sm_fops;
-	kobject_set_name(&port->dev->kobj, "issm%d", port->dev_num);
+	kobject_set_name(&port->sm_dev->kobj, "issm%d", port->dev_num);
 	if (cdev_add(port->sm_dev, base_dev + port->dev_num + IB_UMAD_MAX_PORTS, 1))
 		goto err_sm_cdev;
 
@@ -913,7 +913,7 @@ static void ib_umad_add_one(struct ib_de
 
 err:
 	while (--i >= s)
-		ib_umad_kill_port(&umad_dev->port[i]);
+		ib_umad_kill_port(&umad_dev->port[i - s]);
 
 	kref_put(&umad_dev->ref, ib_umad_release_dev);
 }
---
0.99.9e
