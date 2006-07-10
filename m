Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWGJSSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWGJSSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWGJSSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:18:46 -0400
Received: from mxl145v66.mxlogic.net ([208.65.145.66]:4044 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S1422734AbWGJSSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:18:45 -0400
Date: Mon, 10 Jul 2006 21:15:47 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Sean Hefty <sean.hefty@intel.com>, Roland Dreier <rolandd@cisco.com>,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH] IB/addr: gid structure alignment fix
Message-ID: <20060710181547.GD29641@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 18:20:24.0515 (UTC) FILETIME=[83133930:01C6A44D]
X-Spam: [F=0.1365585120; S=0.136(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew!
Could you please drop the following in -mm and on to Linus?

---

The device address contains unsigned character arrays, which contain raw GID
addresses.  The GIDs may not be naturally aligned, so do not cast them to
structures or unions.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>


Index: gitcma/include/rdma/ib_addr.h
===================================================================
--- gitcma.orig/include/rdma/ib_addr.h	2006-07-09 23:41:27.000000000 +0300
+++ gitcma/include/rdma/ib_addr.h	2006-07-09 23:51:23.000000000 +0300
@@ -89,9 +89,10 @@ static inline void ib_addr_set_pkey(stru
 	dev_addr->broadcast[9] = (unsigned char) pkey;
 }
 
-static inline union ib_gid *ib_addr_get_sgid(struct rdma_dev_addr *dev_addr)
+static inline void ib_addr_get_sgid(struct rdma_dev_addr *dev_addr,
+				    union ib_gid *gid)
 {
-	return 	(union ib_gid *) (dev_addr->src_dev_addr + 4);
+	memcpy(gid, dev_addr->src_dev_addr + 4, sizeof *gid);
 }
 
 static inline void ib_addr_set_sgid(struct rdma_dev_addr *dev_addr,
@@ -100,9 +101,10 @@ static inline void ib_addr_set_sgid(stru
 	memcpy(dev_addr->src_dev_addr + 4, gid, sizeof *gid);
 }
 
-static inline union ib_gid *ib_addr_get_dgid(struct rdma_dev_addr *dev_addr)
+static inline void ib_addr_get_dgid(struct rdma_dev_addr *dev_addr,
+				    union ib_gid *gid)
 {
-	return 	(union ib_gid *) (dev_addr->dst_dev_addr + 4);
+	memcpy(gid, dev_addr->dst_dev_addr + 4, sizeof *gid);
 }
 
 static inline void ib_addr_set_dgid(struct rdma_dev_addr *dev_addr,
Index: gitcma/drivers/infiniband/core/cma.c
===================================================================
--- gitcma.orig/drivers/infiniband/core/cma.c	2006-07-09 23:41:26.000000000 +0300
+++ gitcma/drivers/infiniband/core/cma.c	2006-07-09 23:51:23.000000000 +0300
@@ -262,14 +262,14 @@ static void cma_detach_from_dev(struct r
 static int cma_acquire_ib_dev(struct rdma_id_private *id_priv)
 {
 	struct cma_device *cma_dev;
-	union ib_gid *gid;
+	union ib_gid gid;
 	int ret = -ENODEV;
 
-	gid = ib_addr_get_sgid(&id_priv->id.route.addr.dev_addr);
+	ib_addr_get_sgid(&id_priv->id.route.addr.dev_addr, &gid),
 
 	mutex_lock(&lock);
 	list_for_each_entry(cma_dev, &dev_list, list) {
-		ret = ib_find_cached_gid(cma_dev->device, gid,
+		ret = ib_find_cached_gid(cma_dev->device, &gid,
 					 &id_priv->id.port_num, NULL);
 		if (!ret) {
 			cma_attach_to_dev(id_priv, cma_dev);
@@ -1134,8 +1134,8 @@ static int cma_query_ib_route(struct rdm
 	struct ib_sa_path_rec path_rec;
 
 	memset(&path_rec, 0, sizeof path_rec);
-	path_rec.sgid = *ib_addr_get_sgid(addr);
-	path_rec.dgid = *ib_addr_get_dgid(addr);
+	ib_addr_get_sgid(addr, &path_rec.sgid);
+	ib_addr_get_dgid(addr, &path_rec.dgid);
 	path_rec.pkey = cpu_to_be16(ib_addr_get_pkey(addr));
 	path_rec.numb_path = 1;
 
@@ -1263,7 +1263,7 @@ static int cma_bind_loopback(struct rdma
 {
 	struct cma_device *cma_dev;
 	struct ib_port_attr port_attr;
-	union ib_gid *gid;
+	union ib_gid gid;
 	u16 pkey;
 	int ret;
 	u8 p;
@@ -1284,8 +1284,7 @@ static int cma_bind_loopback(struct rdma
 	}
 
 port_found:
-	gid = ib_addr_get_sgid(&id_priv->id.route.addr.dev_addr);
-	ret = ib_get_cached_gid(cma_dev->device, p, 0, gid);
+	ret = ib_get_cached_gid(cma_dev->device, p, 0, &gid);
 	if (ret)
 		goto out;
 
@@ -1293,6 +1292,7 @@ port_found:
 	if (ret)
 		goto out;
 
+	ib_addr_set_sgid(&id_priv->id.route.addr.dev_addr, &gid);
 	ib_addr_set_pkey(&id_priv->id.route.addr.dev_addr, pkey);
 	id_priv->id.port_num = p;
 	cma_attach_to_dev(id_priv, cma_dev);
@@ -1339,6 +1339,7 @@ static int cma_resolve_loopback(struct r
 {
 	struct cma_work *work;
 	struct sockaddr_in *src_in, *dst_in;
+	union ib_gid gid;
 	int ret;
 
 	work = kzalloc(sizeof *work, GFP_KERNEL);
@@ -1351,8 +1352,8 @@ static int cma_resolve_loopback(struct r
 			goto err;
 	}
 
-	ib_addr_set_dgid(&id_priv->id.route.addr.dev_addr,
-			 ib_addr_get_sgid(&id_priv->id.route.addr.dev_addr));
+	ib_addr_get_sgid(&id_priv->id.route.addr.dev_addr, &gid);
+	ib_addr_set_dgid(&id_priv->id.route.addr.dev_addr, &gid);
 
 	if (cma_zero_addr(&id_priv->id.route.addr.src_addr)) {
 		src_in = (struct sockaddr_in *)&id_priv->id.route.addr.src_addr;

-- 
MST

_______________________________________________
openib-general mailing list
openib-general@openib.org
http://openib.org/mailman/listinfo/openib-general

To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general

----- End forwarded message -----

-- 
MST
