Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVITWI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVITWI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbVITWI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:08:26 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:48177 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965028AbVITWIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:25 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 01/10] IPoIB: fix module removal race
In-Reply-To: <2005920158.2ndgBgW8RwzzVaAk@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:10 -0700
Message-Id: <2005920158.6GA97hjj1WYfaq3W@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:11.0855 (UTC) FILETIME=[CA690DF0:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Since ipoib uses queue_delayed_work to run flush task on port state events,
it must flush scheduled work after unregistering the event handler.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

b21607256f3370b9eba48cd0b67e8686c6b51a64
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1005,6 +1005,7 @@ debug_failed:
 
 register_failed:
 	ib_unregister_event_handler(&priv->event_handler);
+	flush_scheduled_work();
 
 event_failed:
 	ipoib_dev_cleanup(priv->dev);
@@ -1057,6 +1058,7 @@ static void ipoib_remove_one(struct ib_d
 
 	list_for_each_entry_safe(priv, tmp, dev_list, list) {
 		ib_unregister_event_handler(&priv->event_handler);
+		flush_scheduled_work();
 
 		unregister_netdev(priv->dev);
 		ipoib_dev_cleanup(priv->dev);
