Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVK3A5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVK3A5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVK3A5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:57:31 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37405 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750743AbVK3A5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:57:31 -0500
Subject: [git patch review 1/8] IPoIB: reinitialize path struct's completion
	for every query
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 00:57:25 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133312245796-394e1098d722d830@cisco.com>
X-OriginalArrivalTime: 30 Nov 2005 00:57:26.0924 (UTC) FILETIME=[08381CC0:01C5F549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that IPoIB will issue multiple SA queries for the same
path struct.  Therefore the struct's completion needs to be
initialized for each query rather than only once when the struct is
allocated, or else we might not wait long enough for later queries to
finish and free the path struct too soon.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

applies-to: 9fd732ebc6b85090b64862c4ee3af7078ba1f822
65c7eddaba33995e013ef3c04718f6dc8fdf2335
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 2fa3075..cd58b3d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -428,7 +428,6 @@ static struct ipoib_path *path_rec_creat
 	skb_queue_head_init(&path->queue);
 
 	INIT_LIST_HEAD(&path->neigh_list);
-	init_completion(&path->done);
 
 	memcpy(path->pathrec.dgid.raw, gid->raw, sizeof (union ib_gid));
 	path->pathrec.sgid      = priv->local_gid;
@@ -446,6 +445,8 @@ static int path_rec_start(struct net_dev
 	ipoib_dbg(priv, "Start path record lookup for " IPOIB_GID_FMT "\n",
 		  IPOIB_GID_ARG(path->pathrec.dgid));
 
+	init_completion(&path->done);
+
 	path->query_id =
 		ib_sa_path_rec_get(priv->ca, priv->port,
 				   &path->pathrec,
---
0.99.9k
