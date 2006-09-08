Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWIHVzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWIHVzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWIHVzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:55:51 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:7532 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751150AbWIHVzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:55:45 -0400
Cc: tom@opengridcomputing.com, swise@opengridcomputing.com
Subject: [PATCH 2/2] RDMA: iWARP changes to IB core
In-Reply-To: <2006981455.AsEvtu6ZdAKrdkcn@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 8 Sep 2006 14:55:41 -0700
Message-Id: <2006981455.5zPhTm8jRQnxTde2@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 08 Sep 2006 21:55:42.0057 (UTC) FILETIME=[8750B590:01C6D391]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rolandd@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Tucker <tom@opengridcomputing.com>

Modifications to the existing rdma header files, core files, drivers,
and ulp files to support iWARP, including:
 - Hook iWARP CM into the build system and use it in rdma_cm.
 - Convert enum ib_node_type to enum rdma_node_type, which includes
   the possibility of RDMA_NODE_RNIC, and update everything for this.

Signed-off-by: Tom Tucker <tom@opengridcomputing.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
 drivers/infiniband/core/Makefile             |    4 
 drivers/infiniband/core/addr.c               |   18 +
 drivers/infiniband/core/cache.c              |    5 
 drivers/infiniband/core/cm.c                 |    3 
 drivers/infiniband/core/cma.c                |  355 +++++++++++++++++++++++---
 drivers/infiniband/core/device.c             |    4 
 drivers/infiniband/core/mad.c                |    7 -
 drivers/infiniband/core/sa_query.c           |    5 
 drivers/infiniband/core/smi.c                |   16 +
 drivers/infiniband/core/sysfs.c              |   11 -
 drivers/infiniband/core/ucm.c                |    3 
 drivers/infiniband/core/user_mad.c           |    5 
 drivers/infiniband/core/verbs.c              |   17 +
 drivers/infiniband/hw/ehca/ehca_main.c       |    2 
 drivers/infiniband/hw/ipath/ipath_verbs.c    |    2 
 drivers/infiniband/hw/mthca/mthca_provider.c |    2 
 drivers/infiniband/ulp/ipoib/ipoib_main.c    |    8 +
 drivers/infiniband/ulp/srp/ib_srp.c          |    2 
 include/rdma/ib_addr.h                       |   17 +
 include/rdma/ib_verbs.h                      |   25 ++
 20 files changed, 430 insertions(+), 81 deletions(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 68e73ec..163d991 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -1,7 +1,7 @@
 infiniband-$(CONFIG_INFINIBAND_ADDR_TRANS)	:= ib_addr.o rdma_cm.o
 
 obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_sa.o \
-					ib_cm.o $(infiniband-y)
+					ib_cm.o iw_cm.o $(infiniband-y)
 obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
 obj-$(CONFIG_INFINIBAND_USER_ACCESS) +=	ib_uverbs.o ib_ucm.o
 
@@ -14,6 +14,8 @@ ib_sa-y :=			sa_query.o
 
 ib_cm-y :=			cm.o
 
+iw_cm-y :=			iwcm.o
+
 rdma_cm-y :=			cma.o
 
 ib_addr-y :=			addr.o
diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index d8e54e0..9cbf09e 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -61,12 +61,15 @@ static LIST_HEAD(req_list);
 static DECLARE_WORK(work, process_req, NULL);
 static struct workqueue_struct *addr_wq;
 
-static int copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
-		     unsigned char *dst_dev_addr)
+int rdma_copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
+		     const unsigned char *dst_dev_addr)
 {
 	switch (dev->type) {
 	case ARPHRD_INFINIBAND:
-		dev_addr->dev_type = IB_NODE_CA;
+		dev_addr->dev_type = RDMA_NODE_IB_CA;
+		break;
+	case ARPHRD_ETHER:
+		dev_addr->dev_type = RDMA_NODE_RNIC;
 		break;
 	default:
 		return -EADDRNOTAVAIL;
@@ -78,6 +81,7 @@ static int copy_addr(struct rdma_dev_add
 		memcpy(dev_addr->dst_dev_addr, dst_dev_addr, MAX_ADDR_LEN);
 	return 0;
 }
+EXPORT_SYMBOL(rdma_copy_addr);
 
 int rdma_translate_ip(struct sockaddr *addr, struct rdma_dev_addr *dev_addr)
 {
@@ -89,7 +93,7 @@ int rdma_translate_ip(struct sockaddr *a
 	if (!dev)
 		return -EADDRNOTAVAIL;
 
-	ret = copy_addr(dev_addr, dev, NULL);
+	ret = rdma_copy_addr(dev_addr, dev, NULL);
 	dev_put(dev);
 	return ret;
 }
@@ -161,7 +165,7 @@ static int addr_resolve_remote(struct so
 
 	/* If the device does ARP internally, return 'done' */
 	if (rt->idev->dev->flags & IFF_NOARP) {
-		copy_addr(addr, rt->idev->dev, NULL);
+		rdma_copy_addr(addr, rt->idev->dev, NULL);
 		goto put;
 	}
 
@@ -181,7 +185,7 @@ static int addr_resolve_remote(struct so
 		src_in->sin_addr.s_addr = rt->rt_src;
 	}
 
-	ret = copy_addr(addr, neigh->dev, neigh->ha);
+	ret = rdma_copy_addr(addr, neigh->dev, neigh->ha);
 release:
 	neigh_release(neigh);
 put:
@@ -245,7 +249,7 @@ static int addr_resolve_local(struct soc
 	if (ZERONET(src_ip)) {
 		src_in->sin_family = dst_in->sin_family;
 		src_in->sin_addr.s_addr = dst_ip;
-		ret = copy_addr(addr, dev, dev->dev_addr);
+		ret = rdma_copy_addr(addr, dev, dev->dev_addr);
 	} else if (LOOPBACK(src_ip)) {
 		ret = rdma_translate_ip((struct sockaddr *)dst_in, addr);
 		if (!ret)
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 75313ad..20e9f64 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -62,12 +62,13 @@ struct ib_update_work {
 
 static inline int start_port(struct ib_device *device)
 {
-	return device->node_type == IB_NODE_SWITCH ? 0 : 1;
+	return (device->node_type == RDMA_NODE_IB_SWITCH) ? 0 : 1;
 }
 
 static inline int end_port(struct ib_device *device)
 {
-	return device->node_type == IB_NODE_SWITCH ? 0 : device->phys_port_cnt;
+	return (device->node_type == RDMA_NODE_IB_SWITCH) ?
+		0 : device->phys_port_cnt;
 }
 
 int ib_get_cached_gid(struct ib_device *device,
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1c145fe..e130d2e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3280,6 +3280,9 @@ static void cm_add_one(struct ib_device 
 	int ret;
 	u8 i;
 
+	if (rdma_node_get_transport(device->node_type) != RDMA_TRANSPORT_IB)
+		return;
+
 	cm_dev = kmalloc(sizeof(*cm_dev) + sizeof(*port) *
 			 device->phys_port_cnt, GFP_KERNEL);
 	if (!cm_dev)
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index f7be5e7..c54c55a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -35,6 +35,7 @@ #include <linux/in6.h>
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/idr.h>
+#include <linux/inetdevice.h>
 
 #include <net/tcp.h>
 
@@ -43,6 +44,7 @@ #include <rdma/rdma_cm_ib.h>
 #include <rdma/ib_cache.h>
 #include <rdma/ib_cm.h>
 #include <rdma/ib_sa.h>
+#include <rdma/iw_cm.h>
 
 MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("Generic RDMA CM Agent");
@@ -124,6 +126,7 @@ struct rdma_id_private {
 	int			query_id;
 	union {
 		struct ib_cm_id	*ib;
+		struct iw_cm_id	*iw;
 	} cm_id;
 
 	u32			seq_num;
@@ -259,14 +262,23 @@ static void cma_detach_from_dev(struct r
 	id_priv->cma_dev = NULL;
 }
 
-static int cma_acquire_ib_dev(struct rdma_id_private *id_priv)
+static int cma_acquire_dev(struct rdma_id_private *id_priv)
 {
+	enum rdma_node_type dev_type = id_priv->id.route.addr.dev_addr.dev_type;
 	struct cma_device *cma_dev;
 	union ib_gid gid;
 	int ret = -ENODEV;
 
-	ib_addr_get_sgid(&id_priv->id.route.addr.dev_addr, &gid),
-
+	switch (rdma_node_get_transport(dev_type)) {
+	case RDMA_TRANSPORT_IB:
+		ib_addr_get_sgid(&id_priv->id.route.addr.dev_addr, &gid);
+		break;
+	case RDMA_TRANSPORT_IWARP:
+		iw_addr_get_sgid(&id_priv->id.route.addr.dev_addr, &gid);
+		break;
+	default:
+		return -ENODEV;
+	}
 	mutex_lock(&lock);
 	list_for_each_entry(cma_dev, &dev_list, list) {
 		ret = ib_find_cached_gid(cma_dev->device, &gid,
@@ -280,16 +292,6 @@ static int cma_acquire_ib_dev(struct rdm
 	return ret;
 }
 
-static int cma_acquire_dev(struct rdma_id_private *id_priv)
-{
-	switch (id_priv->id.route.addr.dev_addr.dev_type) {
-	case IB_NODE_CA:
-		return cma_acquire_ib_dev(id_priv);
-	default:
-		return -ENODEV;
-	}
-}
-
 static void cma_deref_id(struct rdma_id_private *id_priv)
 {
 	if (atomic_dec_and_test(&id_priv->refcount))
@@ -347,6 +349,16 @@ static int cma_init_ib_qp(struct rdma_id
 					  IB_QP_PKEY_INDEX | IB_QP_PORT);
 }
 
+static int cma_init_iw_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
+{
+	struct ib_qp_attr qp_attr;
+
+	qp_attr.qp_state = IB_QPS_INIT;
+	qp_attr.qp_access_flags = IB_ACCESS_LOCAL_WRITE;
+
+	return ib_modify_qp(qp, &qp_attr, IB_QP_STATE | IB_QP_ACCESS_FLAGS);
+}
+
 int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
 		   struct ib_qp_init_attr *qp_init_attr)
 {
@@ -362,10 +374,13 @@ int rdma_create_qp(struct rdma_cm_id *id
 	if (IS_ERR(qp))
 		return PTR_ERR(qp);
 
-	switch (id->device->node_type) {
-	case IB_NODE_CA:
+	switch (rdma_node_get_transport(id->device->node_type)) {
+	case RDMA_TRANSPORT_IB:
 		ret = cma_init_ib_qp(id_priv, qp);
 		break;
+	case RDMA_TRANSPORT_IWARP:
+		ret = cma_init_iw_qp(id_priv, qp);
+		break;
 	default:
 		ret = -ENOSYS;
 		break;
@@ -451,13 +466,17 @@ int rdma_init_qp_attr(struct rdma_cm_id 
 	int ret;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
-	switch (id_priv->id.device->node_type) {
-	case IB_NODE_CA:
+	switch (rdma_node_get_transport(id_priv->id.device->node_type)) {
+	case RDMA_TRANSPORT_IB:
 		ret = ib_cm_init_qp_attr(id_priv->cm_id.ib, qp_attr,
 					 qp_attr_mask);
 		if (qp_attr->qp_state == IB_QPS_RTR)
 			qp_attr->rq_psn = id_priv->seq_num;
 		break;
+	case RDMA_TRANSPORT_IWARP:
+		ret = iw_cm_init_qp_attr(id_priv->cm_id.iw, qp_attr,
+					qp_attr_mask);
+		break;
 	default:
 		ret = -ENOSYS;
 		break;
@@ -590,8 +609,8 @@ static int cma_notify_user(struct rdma_i
 
 static void cma_cancel_route(struct rdma_id_private *id_priv)
 {
-	switch (id_priv->id.device->node_type) {
-	case IB_NODE_CA:
+	switch (rdma_node_get_transport(id_priv->id.device->node_type)) {
+	case RDMA_TRANSPORT_IB:
 		if (id_priv->query)
 			ib_sa_cancel_query(id_priv->query_id, id_priv->query);
 		break;
@@ -611,11 +630,15 @@ static void cma_destroy_listen(struct rd
 	cma_exch(id_priv, CMA_DESTROYING);
 
 	if (id_priv->cma_dev) {
-		switch (id_priv->id.device->node_type) {
-		case IB_NODE_CA:
+		switch (rdma_node_get_transport(id_priv->id.device->node_type)) {
+		case RDMA_TRANSPORT_IB:
 			if (id_priv->cm_id.ib && !IS_ERR(id_priv->cm_id.ib))
 				ib_destroy_cm_id(id_priv->cm_id.ib);
 			break;
+		case RDMA_TRANSPORT_IWARP:
+			if (id_priv->cm_id.iw && !IS_ERR(id_priv->cm_id.iw))
+				iw_destroy_cm_id(id_priv->cm_id.iw);
+			break;
 		default:
 			break;
 		}
@@ -690,11 +713,15 @@ void rdma_destroy_id(struct rdma_cm_id *
 	cma_cancel_operation(id_priv, state);
 
 	if (id_priv->cma_dev) {
-		switch (id->device->node_type) {
-		case IB_NODE_CA:
+		switch (rdma_node_get_transport(id->device->node_type)) {
+		case RDMA_TRANSPORT_IB:
 			if (id_priv->cm_id.ib && !IS_ERR(id_priv->cm_id.ib))
 				ib_destroy_cm_id(id_priv->cm_id.ib);
 			break;
+		case RDMA_TRANSPORT_IWARP:
+			if (id_priv->cm_id.iw && !IS_ERR(id_priv->cm_id.iw))
+				iw_destroy_cm_id(id_priv->cm_id.iw);
+			break;
 		default:
 			break;
 		}
@@ -869,7 +896,7 @@ static struct rdma_id_private *cma_new_i
 	ib_addr_set_sgid(&rt->addr.dev_addr, &rt->path_rec[0].sgid);
 	ib_addr_set_dgid(&rt->addr.dev_addr, &rt->path_rec[0].dgid);
 	ib_addr_set_pkey(&rt->addr.dev_addr, be16_to_cpu(rt->path_rec[0].pkey));
-	rt->addr.dev_addr.dev_type = IB_NODE_CA;
+	rt->addr.dev_addr.dev_type = RDMA_NODE_IB_CA;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->state = CMA_CONNECT;
@@ -898,7 +925,7 @@ static int cma_req_handler(struct ib_cm_
 	}
 
 	atomic_inc(&conn_id->dev_remove);
-	ret = cma_acquire_ib_dev(conn_id);
+	ret = cma_acquire_dev(conn_id);
 	if (ret) {
 		ret = -ENODEV;
 		cma_release_remove(conn_id);
@@ -982,6 +1009,128 @@ static void cma_set_compare_data(enum rd
 	}
 }
 
+static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
+{
+	struct rdma_id_private *id_priv = iw_id->context;
+	enum rdma_cm_event_type event = 0;
+	struct sockaddr_in *sin;
+	int ret = 0;
+
+	atomic_inc(&id_priv->dev_remove);
+
+	switch (iw_event->event) {
+	case IW_CM_EVENT_CLOSE:
+		event = RDMA_CM_EVENT_DISCONNECTED;
+		break;
+	case IW_CM_EVENT_CONNECT_REPLY:
+		sin = (struct sockaddr_in *) &id_priv->id.route.addr.src_addr;
+		*sin = iw_event->local_addr;
+		sin = (struct sockaddr_in *) &id_priv->id.route.addr.dst_addr;
+		*sin = iw_event->remote_addr;
+		if (iw_event->status)
+			event = RDMA_CM_EVENT_REJECTED;
+		else
+			event = RDMA_CM_EVENT_ESTABLISHED;
+		break;
+	case IW_CM_EVENT_ESTABLISHED:
+		event = RDMA_CM_EVENT_ESTABLISHED;
+		break;
+	default:
+		BUG_ON(1);
+	}
+
+	ret = cma_notify_user(id_priv, event, iw_event->status,
+			      iw_event->private_data,
+			      iw_event->private_data_len);
+	if (ret) {
+		/* Destroy the CM ID by returning a non-zero value. */
+		id_priv->cm_id.iw = NULL;
+		cma_exch(id_priv, CMA_DESTROYING);
+		cma_release_remove(id_priv);
+		rdma_destroy_id(&id_priv->id);
+		return ret;
+	}
+
+	cma_release_remove(id_priv);
+	return ret;
+}
+
+static int iw_conn_req_handler(struct iw_cm_id *cm_id,
+			       struct iw_cm_event *iw_event)
+{
+	struct rdma_cm_id *new_cm_id;
+	struct rdma_id_private *listen_id, *conn_id;
+	struct sockaddr_in *sin;
+	struct net_device *dev = NULL;
+	int ret;
+
+	listen_id = cm_id->context;
+	atomic_inc(&listen_id->dev_remove);
+	if (!cma_comp(listen_id, CMA_LISTEN)) {
+		ret = -ECONNABORTED;
+		goto out;
+	}
+
+	/* Create a new RDMA id for the new IW CM ID */
+	new_cm_id = rdma_create_id(listen_id->id.event_handler,
+				   listen_id->id.context,
+				   RDMA_PS_TCP);
+	if (!new_cm_id) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	conn_id = container_of(new_cm_id, struct rdma_id_private, id);
+	atomic_inc(&conn_id->dev_remove);
+	conn_id->state = CMA_CONNECT;
+
+	dev = ip_dev_find(iw_event->local_addr.sin_addr.s_addr);
+	if (!dev) {
+		ret = -EADDRNOTAVAIL;
+		cma_release_remove(conn_id);
+		rdma_destroy_id(new_cm_id);
+		goto out;
+	}
+	ret = rdma_copy_addr(&conn_id->id.route.addr.dev_addr, dev, NULL);
+	if (ret) {
+		cma_release_remove(conn_id);
+		rdma_destroy_id(new_cm_id);
+		goto out;
+	}
+
+	ret = cma_acquire_dev(conn_id);
+	if (ret) {
+		cma_release_remove(conn_id);
+		rdma_destroy_id(new_cm_id);
+		goto out;
+	}
+
+	conn_id->cm_id.iw = cm_id;
+	cm_id->context = conn_id;
+	cm_id->cm_handler = cma_iw_handler;
+
+	sin = (struct sockaddr_in *) &new_cm_id->route.addr.src_addr;
+	*sin = iw_event->local_addr;
+	sin = (struct sockaddr_in *) &new_cm_id->route.addr.dst_addr;
+	*sin = iw_event->remote_addr;
+
+	ret = cma_notify_user(conn_id, RDMA_CM_EVENT_CONNECT_REQUEST, 0,
+			      iw_event->private_data,
+			      iw_event->private_data_len);
+	if (ret) {
+		/* User wants to destroy the CM ID */
+		conn_id->cm_id.iw = NULL;
+		cma_exch(conn_id, CMA_DESTROYING);
+		cma_release_remove(conn_id);
+		rdma_destroy_id(&conn_id->id);
+	}
+
+out:
+	if (dev)
+		dev_put(dev);
+	cma_release_remove(listen_id);
+	return ret;
+}
+
 static int cma_ib_listen(struct rdma_id_private *id_priv)
 {
 	struct ib_cm_compare_data compare_data;
@@ -1011,6 +1160,30 @@ static int cma_ib_listen(struct rdma_id_
 	return ret;
 }
 
+static int cma_iw_listen(struct rdma_id_private *id_priv, int backlog)
+{
+	int ret;
+	struct sockaddr_in *sin;
+
+	id_priv->cm_id.iw = iw_create_cm_id(id_priv->id.device,
+					    iw_conn_req_handler,
+					    id_priv);
+	if (IS_ERR(id_priv->cm_id.iw))
+		return PTR_ERR(id_priv->cm_id.iw);
+
+	sin = (struct sockaddr_in *) &id_priv->id.route.addr.src_addr;
+	id_priv->cm_id.iw->local_addr = *sin;
+
+	ret = iw_cm_listen(id_priv->cm_id.iw, backlog);
+
+	if (ret) {
+		iw_destroy_cm_id(id_priv->cm_id.iw);
+		id_priv->cm_id.iw = NULL;
+	}
+
+	return ret;
+}
+
 static int cma_listen_handler(struct rdma_cm_id *id,
 			      struct rdma_cm_event *event)
 {
@@ -1087,12 +1260,17 @@ int rdma_listen(struct rdma_cm_id *id, i
 
 	id_priv->backlog = backlog;
 	if (id->device) {
-		switch (id->device->node_type) {
-		case IB_NODE_CA:
+		switch (rdma_node_get_transport(id->device->node_type)) {
+		case RDMA_TRANSPORT_IB:
 			ret = cma_ib_listen(id_priv);
 			if (ret)
 				goto err;
 			break;
+		case RDMA_TRANSPORT_IWARP:
+			ret = cma_iw_listen(id_priv, backlog);
+			if (ret)
+				goto err;
+			break;
 		default:
 			ret = -ENOSYS;
 			goto err;
@@ -1231,6 +1409,23 @@ err:
 }
 EXPORT_SYMBOL(rdma_set_ib_paths);
 
+static int cma_resolve_iw_route(struct rdma_id_private *id_priv, int timeout_ms)
+{
+	struct cma_work *work;
+
+	work = kzalloc(sizeof *work, GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	work->id = id_priv;
+	INIT_WORK(&work->work, cma_work_handler, work);
+	work->old_state = CMA_ROUTE_QUERY;
+	work->new_state = CMA_ROUTE_RESOLVED;
+	work->event.event = RDMA_CM_EVENT_ROUTE_RESOLVED;
+	queue_work(cma_wq, &work->work);
+	return 0;
+}
+
 int rdma_resolve_route(struct rdma_cm_id *id, int timeout_ms)
 {
 	struct rdma_id_private *id_priv;
@@ -1241,10 +1436,13 @@ int rdma_resolve_route(struct rdma_cm_id
 		return -EINVAL;
 
 	atomic_inc(&id_priv->refcount);
-	switch (id->device->node_type) {
-	case IB_NODE_CA:
+	switch (rdma_node_get_transport(id->device->node_type)) {
+	case RDMA_TRANSPORT_IB:
 		ret = cma_resolve_ib_route(id_priv, timeout_ms);
 		break;
+	case RDMA_TRANSPORT_IWARP:
+		ret = cma_resolve_iw_route(id_priv, timeout_ms);
+		break;
 	default:
 		ret = -ENOSYS;
 		break;
@@ -1649,6 +1847,47 @@ out:
 	return ret;
 }
 
+static int cma_connect_iw(struct rdma_id_private *id_priv,
+			  struct rdma_conn_param *conn_param)
+{
+	struct iw_cm_id *cm_id;
+	struct sockaddr_in* sin;
+	int ret;
+	struct iw_cm_conn_param iw_param;
+
+	cm_id = iw_create_cm_id(id_priv->id.device, cma_iw_handler, id_priv);
+	if (IS_ERR(cm_id)) {
+		ret = PTR_ERR(cm_id);
+		goto out;
+	}
+
+	id_priv->cm_id.iw = cm_id;
+
+	sin = (struct sockaddr_in*) &id_priv->id.route.addr.src_addr;
+	cm_id->local_addr = *sin;
+
+	sin = (struct sockaddr_in*) &id_priv->id.route.addr.dst_addr;
+	cm_id->remote_addr = *sin;
+
+	ret = cma_modify_qp_rtr(&id_priv->id);
+	if (ret) {
+		iw_destroy_cm_id(cm_id);
+		return ret;
+	}
+
+	iw_param.ord = conn_param->initiator_depth;
+	iw_param.ird = conn_param->responder_resources;
+	iw_param.private_data = conn_param->private_data;
+	iw_param.private_data_len = conn_param->private_data_len;
+	if (id_priv->id.qp)
+		iw_param.qpn = id_priv->qp_num;
+	else
+		iw_param.qpn = conn_param->qp_num;
+	ret = iw_cm_connect(cm_id, &iw_param);
+out:
+	return ret;
+}
+
 int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 {
 	struct rdma_id_private *id_priv;
@@ -1664,10 +1903,13 @@ int rdma_connect(struct rdma_cm_id *id, 
 		id_priv->srq = conn_param->srq;
 	}
 
-	switch (id->device->node_type) {
-	case IB_NODE_CA:
+	switch (rdma_node_get_transport(id->device->node_type)) {
+	case RDMA_TRANSPORT_IB:
 		ret = cma_connect_ib(id_priv, conn_param);
 		break;
+	case RDMA_TRANSPORT_IWARP:
+		ret = cma_connect_iw(id_priv, conn_param);
+		break;
 	default:
 		ret = -ENOSYS;
 		break;
@@ -1708,6 +1950,28 @@ static int cma_accept_ib(struct rdma_id_
 	return ib_send_cm_rep(id_priv->cm_id.ib, &rep);
 }
 
+static int cma_accept_iw(struct rdma_id_private *id_priv,
+		  struct rdma_conn_param *conn_param)
+{
+	struct iw_cm_conn_param iw_param;
+	int ret;
+
+	ret = cma_modify_qp_rtr(&id_priv->id);
+	if (ret)
+		return ret;
+
+	iw_param.ord = conn_param->initiator_depth;
+	iw_param.ird = conn_param->responder_resources;
+	iw_param.private_data = conn_param->private_data;
+	iw_param.private_data_len = conn_param->private_data_len;
+	if (id_priv->id.qp) {
+		iw_param.qpn = id_priv->qp_num;
+	} else
+		iw_param.qpn = conn_param->qp_num;
+
+	return iw_cm_accept(id_priv->cm_id.iw, &iw_param);
+}
+
 int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 {
 	struct rdma_id_private *id_priv;
@@ -1723,13 +1987,16 @@ int rdma_accept(struct rdma_cm_id *id, s
 		id_priv->srq = conn_param->srq;
 	}
 
-	switch (id->device->node_type) {
-	case IB_NODE_CA:
+	switch (rdma_node_get_transport(id->device->node_type)) {
+	case RDMA_TRANSPORT_IB:
 		if (conn_param)
 			ret = cma_accept_ib(id_priv, conn_param);
 		else
 			ret = cma_rep_recv(id_priv);
 		break;
+	case RDMA_TRANSPORT_IWARP:
+		ret = cma_accept_iw(id_priv, conn_param);
+		break;
 	default:
 		ret = -ENOSYS;
 		break;
@@ -1756,12 +2023,16 @@ int rdma_reject(struct rdma_cm_id *id, c
 	if (!cma_comp(id_priv, CMA_CONNECT))
 		return -EINVAL;
 
-	switch (id->device->node_type) {
-	case IB_NODE_CA:
+	switch (rdma_node_get_transport(id->device->node_type)) {
+	case RDMA_TRANSPORT_IB:
 		ret = ib_send_cm_rej(id_priv->cm_id.ib,
 				     IB_CM_REJ_CONSUMER_DEFINED, NULL, 0,
 				     private_data, private_data_len);
 		break;
+	case RDMA_TRANSPORT_IWARP:
+		ret = iw_cm_reject(id_priv->cm_id.iw,
+				   private_data, private_data_len);
+		break;
 	default:
 		ret = -ENOSYS;
 		break;
@@ -1780,16 +2051,18 @@ int rdma_disconnect(struct rdma_cm_id *i
 	    !cma_comp(id_priv, CMA_DISCONNECT))
 		return -EINVAL;
 
-	ret = cma_modify_qp_err(id);
-	if (ret)
-		goto out;
-
-	switch (id->device->node_type) {
-	case IB_NODE_CA:
+	switch (rdma_node_get_transport(id->device->node_type)) {
+	case RDMA_TRANSPORT_IB:
+		ret = cma_modify_qp_err(id);
+		if (ret)
+			goto out;
 		/* Initiate or respond to a disconnect. */
 		if (ib_send_cm_dreq(id_priv->cm_id.ib, NULL, 0))
 			ib_send_cm_drep(id_priv->cm_id.ib, NULL, 0);
 		break;
+	case RDMA_TRANSPORT_IWARP:
+		ret = iw_cm_disconnect(id_priv->cm_id.iw, 0);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b2f3cb9..d978fbe 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -505,7 +505,7 @@ int ib_query_port(struct ib_device *devi
 		  u8 port_num,
 		  struct ib_port_attr *port_attr)
 {
-	if (device->node_type == IB_NODE_SWITCH) {
+	if (device->node_type == RDMA_NODE_IB_SWITCH) {
 		if (port_num)
 			return -EINVAL;
 	} else if (port_num < 1 || port_num > device->phys_port_cnt)
@@ -580,7 +580,7 @@ int ib_modify_port(struct ib_device *dev
 		   u8 port_num, int port_modify_mask,
 		   struct ib_port_modify *port_modify)
 {
-	if (device->node_type == IB_NODE_SWITCH) {
+	if (device->node_type == RDMA_NODE_IB_SWITCH) {
 		if (port_num)
 			return -EINVAL;
 	} else if (port_num < 1 || port_num > device->phys_port_cnt)
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 32d3028..082f03c 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2876,7 +2876,10 @@ static void ib_mad_init_device(struct ib
 {
 	int start, end, i;
 
-	if (device->node_type == IB_NODE_SWITCH) {
+	if (rdma_node_get_transport(device->node_type) != RDMA_TRANSPORT_IB)
+		return;
+
+	if (device->node_type == RDMA_NODE_IB_SWITCH) {
 		start = 0;
 		end   = 0;
 	} else {
@@ -2923,7 +2926,7 @@ static void ib_mad_remove_device(struct 
 {
 	int i, num_ports, cur_port;
 
-	if (device->node_type == IB_NODE_SWITCH) {
+	if (device->node_type == RDMA_NODE_IB_SWITCH) {
 		num_ports = 1;
 		cur_port = 0;
 	} else {
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index df762ba..ca8760a 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -919,7 +919,10 @@ static void ib_sa_add_one(struct ib_devi
 	struct ib_sa_device *sa_dev;
 	int s, e, i;
 
-	if (device->node_type == IB_NODE_SWITCH)
+	if (rdma_node_get_transport(device->node_type) != RDMA_TRANSPORT_IB)
+		return;
+
+	if (device->node_type == RDMA_NODE_IB_SWITCH)
 		s = e = 0;
 	else {
 		s = 1;
diff --git a/drivers/infiniband/core/smi.c b/drivers/infiniband/core/smi.c
index 35852e7..54b81e1 100644
--- a/drivers/infiniband/core/smi.c
+++ b/drivers/infiniband/core/smi.c
@@ -64,7 +64,7 @@ int smi_handle_dr_smp_send(struct ib_smp
 
 		/* C14-9:2 */
 		if (hop_ptr && hop_ptr < hop_cnt) {
-			if (node_type != IB_NODE_SWITCH)
+			if (node_type != RDMA_NODE_IB_SWITCH)
 				return 0;
 
 			/* smp->return_path set when received */
@@ -77,7 +77,7 @@ int smi_handle_dr_smp_send(struct ib_smp
 		if (hop_ptr == hop_cnt) {
 			/* smp->return_path set when received */
 			smp->hop_ptr++;
-			return (node_type == IB_NODE_SWITCH ||
+			return (node_type == RDMA_NODE_IB_SWITCH ||
 				smp->dr_dlid == IB_LID_PERMISSIVE);
 		}
 
@@ -95,7 +95,7 @@ int smi_handle_dr_smp_send(struct ib_smp
 
 		/* C14-13:2 */
 		if (2 <= hop_ptr && hop_ptr <= hop_cnt) {
-			if (node_type != IB_NODE_SWITCH)
+			if (node_type != RDMA_NODE_IB_SWITCH)
 				return 0;
 
 			smp->hop_ptr--;
@@ -107,7 +107,7 @@ int smi_handle_dr_smp_send(struct ib_smp
 		if (hop_ptr == 1) {
 			smp->hop_ptr--;
 			/* C14-13:3 -- SMPs destined for SM shouldn't be here */
-			return (node_type == IB_NODE_SWITCH ||
+			return (node_type == RDMA_NODE_IB_SWITCH ||
 				smp->dr_slid == IB_LID_PERMISSIVE);
 		}
 
@@ -142,7 +142,7 @@ int smi_handle_dr_smp_recv(struct ib_smp
 
 		/* C14-9:2 -- intermediate hop */
 		if (hop_ptr && hop_ptr < hop_cnt) {
-			if (node_type != IB_NODE_SWITCH)
+			if (node_type != RDMA_NODE_IB_SWITCH)
 				return 0;
 
 			smp->return_path[hop_ptr] = port_num;
@@ -156,7 +156,7 @@ int smi_handle_dr_smp_recv(struct ib_smp
 				smp->return_path[hop_ptr] = port_num;
 			/* smp->hop_ptr updated when sending */
 
-			return (node_type == IB_NODE_SWITCH ||
+			return (node_type == RDMA_NODE_IB_SWITCH ||
 				smp->dr_dlid == IB_LID_PERMISSIVE);
 		}
 
@@ -175,7 +175,7 @@ int smi_handle_dr_smp_recv(struct ib_smp
 
 		/* C14-13:2 */
 		if (2 <= hop_ptr && hop_ptr <= hop_cnt) {
-			if (node_type != IB_NODE_SWITCH)
+			if (node_type != RDMA_NODE_IB_SWITCH)
 				return 0;
 
 			/* smp->hop_ptr updated when sending */
@@ -190,7 +190,7 @@ int smi_handle_dr_smp_recv(struct ib_smp
 				return 1;
 			}
 			/* smp->hop_ptr updated when sending */
-			return (node_type == IB_NODE_SWITCH);
+			return (node_type == RDMA_NODE_IB_SWITCH);
 		}
 
 		/* C14-13:4 -- hop_ptr = 0 -> give to SM */
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index fb66605..709323c 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -589,10 +589,11 @@ static ssize_t show_node_type(struct cla
 		return -ENODEV;
 
 	switch (dev->node_type) {
-	case IB_NODE_CA:     return sprintf(buf, "%d: CA\n", dev->node_type);
-	case IB_NODE_SWITCH: return sprintf(buf, "%d: switch\n", dev->node_type);
-	case IB_NODE_ROUTER: return sprintf(buf, "%d: router\n", dev->node_type);
-	default:             return sprintf(buf, "%d: <unknown>\n", dev->node_type);
+	case RDMA_NODE_IB_CA:	  return sprintf(buf, "%d: CA\n", dev->node_type);
+	case RDMA_NODE_RNIC:	  return sprintf(buf, "%d: RNIC\n", dev->node_type);
+	case RDMA_NODE_IB_SWITCH: return sprintf(buf, "%d: switch\n", dev->node_type);
+	case RDMA_NODE_IB_ROUTER: return sprintf(buf, "%d: router\n", dev->node_type);
+	default:		  return sprintf(buf, "%d: <unknown>\n", dev->node_type);
 	}
 }
 
@@ -708,7 +709,7 @@ int ib_device_register_sysfs(struct ib_d
 	if (ret)
 		goto err_put;
 
-	if (device->node_type == IB_NODE_SWITCH) {
+	if (device->node_type == RDMA_NODE_IB_SWITCH) {
 		ret = add_port(device, 0);
 		if (ret)
 			goto err_put;
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index e74c964..ad4f4d5 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -1247,7 +1247,8 @@ static void ib_ucm_add_one(struct ib_dev
 {
 	struct ib_ucm_device *ucm_dev;
 
-	if (!device->alloc_ucontext)
+	if (!device->alloc_ucontext ||
+	    rdma_node_get_transport(device->node_type) != RDMA_TRANSPORT_IB)
 		return;
 
 	ucm_dev = kzalloc(sizeof *ucm_dev, GFP_KERNEL);
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 8a455ae..807fbd6 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1032,7 +1032,10 @@ static void ib_umad_add_one(struct ib_de
 	struct ib_umad_device *umad_dev;
 	int s, e, i;
 
-	if (device->node_type == IB_NODE_SWITCH)
+	if (rdma_node_get_transport(device->node_type) != RDMA_TRANSPORT_IB)
+		return;
+
+	if (device->node_type == RDMA_NODE_IB_SWITCH)
 		s = e = 0;
 	else {
 		s = 1;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 06f98e9..8b5dd36 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -79,6 +79,23 @@ enum ib_rate mult_to_ib_rate(int mult)
 }
 EXPORT_SYMBOL(mult_to_ib_rate);
 
+enum rdma_transport_type
+rdma_node_get_transport(enum rdma_node_type node_type)
+{
+	switch (node_type) {
+	case RDMA_NODE_IB_CA:
+	case RDMA_NODE_IB_SWITCH:
+	case RDMA_NODE_IB_ROUTER:
+		return RDMA_TRANSPORT_IB;
+	case RDMA_NODE_RNIC:
+		return RDMA_TRANSPORT_IWARP;
+	default:
+		BUG();
+		return 0;
+	}
+}
+EXPORT_SYMBOL(rdma_node_get_transport);
+
 /* Protection domains */
 
 struct ib_pd *ib_alloc_pd(struct ib_device *device)
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index a2a76c3..159b0be 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -268,7 +268,7 @@ int ehca_register_device(struct ehca_shc
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
 		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST);
 
-	shca->ib_device.node_type           = IB_NODE_CA;
+	shca->ib_device.node_type           = RDMA_NODE_IB_CA;
 	shca->ib_device.phys_port_cnt       = shca->num_ports;
 	shca->ib_device.dma_device          = &shca->ibmebus_dev->ofdev.dev;
 	shca->ib_device.query_device        = ehca_query_device;
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
index fbda773..b8381c5 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c
@@ -1538,7 +1538,7 @@ int ipath_register_ib_device(struct ipat
 		(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
 		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ)		|
 		(1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);
-	dev->node_type = IB_NODE_CA;
+	dev->node_type = RDMA_NODE_IB_CA;
 	dev->phys_port_cnt = 1;
 	dev->dma_device = &dd->pcidev->dev;
 	dev->class_dev.dev = dev->dma_device;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 265b1d1..981fe2e 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1288,7 +1288,7 @@ int mthca_register_device(struct mthca_d
 		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
 		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST);
-	dev->ib_dev.node_type            = IB_NODE_CA;
+	dev->ib_dev.node_type            = RDMA_NODE_IB_CA;
 	dev->ib_dev.phys_port_cnt        = dev->limits.num_ports;
 	dev->ib_dev.dma_device           = &dev->pdev->dev;
 	dev->ib_dev.class_dev.dev        = &dev->pdev->dev;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 36d7698..e9a7659 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1111,13 +1111,16 @@ static void ipoib_add_one(struct ib_devi
 	struct ipoib_dev_priv *priv;
 	int s, e, p;
 
+	if (rdma_node_get_transport(device->node_type) != RDMA_TRANSPORT_IB)
+		return;
+
 	dev_list = kmalloc(sizeof *dev_list, GFP_KERNEL);
 	if (!dev_list)
 		return;
 
 	INIT_LIST_HEAD(dev_list);
 
-	if (device->node_type == IB_NODE_SWITCH) {
+	if (device->node_type == RDMA_NODE_IB_SWITCH) {
 		s = 0;
 		e = 0;
 	} else {
@@ -1141,6 +1144,9 @@ static void ipoib_remove_one(struct ib_d
 	struct ipoib_dev_priv *priv, *tmp;
 	struct list_head *dev_list;
 
+	if (rdma_node_get_transport(device->node_type) != RDMA_TRANSPORT_IB)
+		return;
+
 	dev_list = ib_get_client_data(device, &ipoib_client);
 
 	list_for_each_entry_safe(priv, tmp, dev_list, list) {
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 4f1775d..297c9ff 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1913,7 +1913,7 @@ static void srp_add_one(struct ib_device
 	if (IS_ERR(srp_dev->fmr_pool))
 		srp_dev->fmr_pool = NULL;
 
-	if (device->node_type == IB_NODE_SWITCH) {
+	if (device->node_type == RDMA_NODE_IB_SWITCH) {
 		s = 0;
 		e = 0;
 	} else {
diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index 0ff6739..81b6230 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -40,7 +40,7 @@ struct rdma_dev_addr {
 	unsigned char src_dev_addr[MAX_ADDR_LEN];
 	unsigned char dst_dev_addr[MAX_ADDR_LEN];
 	unsigned char broadcast[MAX_ADDR_LEN];
-	enum ib_node_type dev_type;
+	enum rdma_node_type dev_type;
 };
 
 /**
@@ -72,6 +72,9 @@ int rdma_resolve_ip(struct sockaddr *src
 
 void rdma_addr_cancel(struct rdma_dev_addr *addr);
 
+int rdma_copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
+	      const unsigned char *dst_dev_addr);
+
 static inline int ip_addr_size(struct sockaddr *addr)
 {
 	return addr->sa_family == AF_INET6 ?
@@ -113,4 +116,16 @@ static inline void ib_addr_set_dgid(stru
 	memcpy(dev_addr->dst_dev_addr + 4, gid, sizeof *gid);
 }
 
+static inline void iw_addr_get_sgid(struct rdma_dev_addr *dev_addr,
+				    union ib_gid *gid)
+{
+	memcpy(gid, dev_addr->src_dev_addr, sizeof *gid);
+}
+
+static inline void iw_addr_get_dgid(struct rdma_dev_addr *dev_addr,
+				    union ib_gid *gid)
+{
+	memcpy(gid, dev_addr->dst_dev_addr, sizeof *gid);
+}
+
 #endif /* IB_ADDR_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 61eed39..8eacc35 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -56,12 +56,22 @@ union ib_gid {
 	} global;
 };
 
-enum ib_node_type {
-	IB_NODE_CA 	= 1,
-	IB_NODE_SWITCH,
-	IB_NODE_ROUTER
+enum rdma_node_type {
+	/* IB values map to NodeInfo:NodeType. */
+	RDMA_NODE_IB_CA 	= 1,
+	RDMA_NODE_IB_SWITCH,
+	RDMA_NODE_IB_ROUTER,
+	RDMA_NODE_RNIC
 };
 
+enum rdma_transport_type {
+	RDMA_TRANSPORT_IB,
+	RDMA_TRANSPORT_IWARP
+};
+
+enum rdma_transport_type
+rdma_node_get_transport(enum rdma_node_type node_type) __attribute_const__;
+
 enum ib_device_cap_flags {
 	IB_DEVICE_RESIZE_MAX_WR		= 1,
 	IB_DEVICE_BAD_PKEY_CNTR		= (1<<1),
@@ -78,6 +88,9 @@ enum ib_device_cap_flags {
 	IB_DEVICE_RC_RNR_NAK_GEN	= (1<<12),
 	IB_DEVICE_SRQ_RESIZE		= (1<<13),
 	IB_DEVICE_N_NOTIFY_CQ		= (1<<14),
+	IB_DEVICE_ZERO_STAG		= (1<<15),
+	IB_DEVICE_SEND_W_INV		= (1<<16),
+	IB_DEVICE_MEM_WINDOW		= (1<<17)
 };
 
 enum ib_atomic_cap {
@@ -835,6 +848,8 @@ struct ib_cache {
 	u8                     *lmc_cache;
 };
 
+struct iw_cm_verbs;
+
 struct ib_device {
 	struct device                *dma_device;
 
@@ -851,6 +866,8 @@ struct ib_device {
 
 	u32                           flags;
 
+	struct iw_cm_verbs	     *iwcm;
+
 	int		           (*query_device)(struct ib_device *device,
 						   struct ib_device_attr *device_attr);
 	int		           (*query_port)(struct ib_device *device,
-- 
1.4.1

