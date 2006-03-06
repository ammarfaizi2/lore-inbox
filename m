Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWCFTKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWCFTKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWCFTKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:10:54 -0500
Received: from fmr20.intel.com ([134.134.136.19]:13958 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932262AbWCFTKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:10:53 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>
Cc: <openib-general@openib.org>
Subject: [PATCH 4/6] IB: address translation to map IP to IB addresses (GIDs)
Date: Mon, 6 Mar 2006 11:10:49 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <adaslpz2l9p.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcY/FYSDoSObWDAKRKyl93Kwz34rUACO73Bw
Message-ID: <ORSMSX401FRaqbC8wSA00000007@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 06 Mar 2006 19:10:49.0694 (UTC) FILETIME=[AE2C67E0:01C64151]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an address translation service that maps IP addresses to Infiniband
GID addresses using IPoIB.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>

---

diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/addr.c 
linux-2.6.ib/drivers/infiniband/core/addr.c
--- linux-2.6.git/drivers/infiniband/core/addr.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/addr.c	2006-01-16 16:14:24.000000000 -0800
@@ -0,0 +1,356 @@
+/*
+ * Copyright (c) 2005 Voltaire Inc.  All rights reserved.
+ * Copyright (c) 2002-2005, Network Appliance, Inc. All rights reserved.
+ * Copyright (c) 1999-2005, Mellanox Technologies, Inc. All rights reserved.
+ * Copyright (c) 2005 Intel Corporation.  All rights reserved.
+ *
+ * This Software is licensed under one of the following licenses:
+ *
+ * 1) under the terms of the "Common Public License 1.0" a copy of which is
+ *    available from the Open Source Initiative, see
+ *    http://www.opensource.org/licenses/cpl.php.
+ *
+ * 2) under the terms of the "The BSD License" a copy of which is
+ *    available from the Open Source Initiative, see
+ *    http://www.opensource.org/licenses/bsd-license.php.
+ *
+ * 3) under the terms of the "GNU General Public License (GPL) Version 2" a
+ *    copy of which is available from the Open Source Initiative, see
+ *    http://www.opensource.org/licenses/gpl-license.php.
+ *
+ * Licensee has the right to choose one of the above licenses.
+ *
+ * Redistributions of source code must retain the above copyright
+ * notice and one of the license notices.
+ *
+ * Redistributions in binary form must reproduce both the above copyright
+ * notice, one of the license notices in the documentation
+ * and/or other materials provided with the distribution.
+ */
+#include <linux/inetdevice.h>
+#include <linux/workqueue.h>
+#include <net/arp.h>
+#include <net/neighbour.h>
+#include <net/route.h>
+#include <rdma/ib_addr.h>
+
+MODULE_AUTHOR("Sean Hefty");
+MODULE_DESCRIPTION("IB Address Translation");
+MODULE_LICENSE("Dual BSD/GPL");
+
+struct addr_req {
+	struct list_head list;
+	struct sockaddr src_addr;
+	struct sockaddr dst_addr;
+	struct rdma_dev_addr *addr;
+	void *context;
+	void (*callback)(int status, struct sockaddr *src_addr,
+			 struct rdma_dev_addr *addr, void *context);
+	unsigned long timeout;
+	int status;
+};
+
+static void process_req(void *data);
+
+static DECLARE_MUTEX(mutex);
+static LIST_HEAD(req_list);
+static DECLARE_WORK(work, process_req, NULL);
+struct workqueue_struct *rdma_wq;
+EXPORT_SYMBOL(rdma_wq);
+
+static int copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
+		     unsigned char *dst_dev_addr)
+{
+	switch (dev->type) {
+	case ARPHRD_INFINIBAND:
+		dev_addr->dev_type = IB_NODE_CA;
+		break;
+	default:
+		return -EADDRNOTAVAIL;
+	}
+
+	memcpy(dev_addr->src_dev_addr, dev->dev_addr, MAX_ADDR_LEN);
+	memcpy(dev_addr->broadcast, dev->broadcast, MAX_ADDR_LEN);
+	if (dst_dev_addr)
+		memcpy(dev_addr->dst_dev_addr, dst_dev_addr, MAX_ADDR_LEN);
+	return 0;
+}
+
+int rdma_translate_ip(struct sockaddr *addr, struct rdma_dev_addr *dev_addr)
+{
+	struct net_device *dev;
+	u32 ip = ((struct sockaddr_in *) addr)->sin_addr.s_addr;
+	int ret;
+
+	dev = ip_dev_find(ip);
+	if (!dev)
+		return -EADDRNOTAVAIL;
+
+	ret = copy_addr(dev_addr, dev, NULL);
+	dev_put(dev);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_translate_ip);
+
+static void set_timeout(unsigned long time)
+{
+	unsigned long delay;
+
+	cancel_delayed_work(&work);
+
+	delay = time - jiffies;
+	if ((long)delay <= 0)
+		delay = 1;
+
+	queue_delayed_work(rdma_wq, &work, delay);
+}
+
+static void queue_req(struct addr_req *req)
+{
+	struct addr_req *temp_req;
+
+	down(&mutex);
+	list_for_each_entry_reverse(temp_req, &req_list, list) {
+		if (time_after(req->timeout, temp_req->timeout))
+			break;
+	}
+
+	list_add(&req->list, &temp_req->list);
+
+	if (req_list.next == &req->list)
+		set_timeout(req->timeout);
+	up(&mutex);
+}
+
+static void addr_send_arp(struct sockaddr_in *dst_in)
+{
+	struct rtable *rt;
+	struct flowi fl;
+	u32 dst_ip = dst_in->sin_addr.s_addr;
+
+	memset(&fl, 0, sizeof fl);
+	fl.nl_u.ip4_u.daddr = dst_ip;
+	if (ip_route_output_key(&rt, &fl))
+		return;
+
+	arp_send(ARPOP_REQUEST, ETH_P_ARP, rt->rt_gateway, rt->idev->dev,
+		 rt->rt_src, NULL, rt->idev->dev->dev_addr, NULL);
+	ip_rt_put(rt);
+}
+
+static int addr_resolve_remote(struct sockaddr_in *src_in,
+			       struct sockaddr_in *dst_in,
+			       struct rdma_dev_addr *addr)
+{
+	u32 src_ip = src_in->sin_addr.s_addr;
+	u32 dst_ip = dst_in->sin_addr.s_addr;
+	struct flowi fl;
+	struct rtable *rt;
+	struct neighbour *neigh;
+	int ret;
+
+	memset(&fl, 0, sizeof fl);
+	fl.nl_u.ip4_u.daddr = dst_ip;
+	fl.nl_u.ip4_u.saddr = src_ip;
+	ret = ip_route_output_key(&rt, &fl);
+	if (ret)
+		goto out;
+
+	neigh = neigh_lookup(&arp_tbl, &rt->rt_gateway, rt->idev->dev);
+	if (!neigh) {
+		ret = -ENODATA;
+		goto err1;
+	}
+
+	if (!(neigh->nud_state & NUD_VALID)) {
+		ret = -ENODATA;
+		goto err2;
+	}
+
+	if (!src_ip) {
+		src_in->sin_family = dst_in->sin_family;
+		src_in->sin_addr.s_addr = rt->rt_src;
+	}
+
+	ret = copy_addr(addr, neigh->dev, neigh->ha);
+err2:
+	neigh_release(neigh);
+err1:
+	ip_rt_put(rt);
+out:
+	return ret;
+}
+
+static void process_req(void *data)
+{
+	struct addr_req *req, *temp_req;
+	struct sockaddr_in *src_in, *dst_in;
+	struct list_head done_list;
+
+	INIT_LIST_HEAD(&done_list);
+
+	down(&mutex);
+	list_for_each_entry_safe(req, temp_req, &req_list, list) {
+		if (req->status) {
+			src_in = (struct sockaddr_in *) &req->src_addr;
+			dst_in = (struct sockaddr_in *) &req->dst_addr;
+			req->status = addr_resolve_remote(src_in, dst_in,
+							  req->addr);
+		}
+		if (req->status && time_after(jiffies, req->timeout))
+			req->status = -ETIMEDOUT;
+		else if (req->status == -ENODATA)
+			continue;
+
+		list_del(&req->list);
+		list_add_tail(&req->list, &done_list);
+	}
+
+	if (!list_empty(&req_list)) {
+		req = list_entry(req_list.next, struct addr_req, list);
+		set_timeout(req->timeout);
+	}
+	up(&mutex);
+
+	list_for_each_entry_safe(req, temp_req, &done_list, list) {
+		list_del(&req->list);
+		req->callback(req->status, &req->src_addr, req->addr,
+			      req->context);
+		kfree(req);
+	}
+}
+
+static int addr_resolve_local(struct sockaddr_in *src_in,
+			      struct sockaddr_in *dst_in,
+			      struct rdma_dev_addr *addr)
+{
+	struct net_device *dev;
+	u32 src_ip = src_in->sin_addr.s_addr;
+	u32 dst_ip = dst_in->sin_addr.s_addr;
+	int ret;
+
+	dev = ip_dev_find(dst_ip);
+	if (!dev)
+		return -EADDRNOTAVAIL;
+
+	if (!src_ip) {
+		src_in->sin_family = dst_in->sin_family;
+		src_in->sin_addr.s_addr = dst_ip;
+		ret = copy_addr(addr, dev, dev->dev_addr);
+	} else {
+		ret = rdma_translate_ip((struct sockaddr *)src_in, addr);
+		if (!ret)
+			memcpy(addr->dst_dev_addr, dev->dev_addr, MAX_ADDR_LEN);
+	}
+
+	dev_put(dev);
+	return ret;
+}
+
+int rdma_resolve_ip(struct sockaddr *src_addr, struct sockaddr *dst_addr,
+		    struct rdma_dev_addr *addr, int timeout_ms,
+		    void (*callback)(int status, struct sockaddr *src_addr,
+				     struct rdma_dev_addr *addr, void *context),
+		    void *context)
+{
+	struct sockaddr_in *src_in, *dst_in;
+	struct addr_req *req;
+	int ret = 0;
+
+	req = kmalloc(sizeof *req, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	memset(req, 0, sizeof *req);
+
+	if (src_addr)
+		memcpy(&req->src_addr, src_addr, ip_addr_size(src_addr));
+	memcpy(&req->dst_addr, dst_addr, ip_addr_size(dst_addr));
+	req->addr = addr;
+	req->callback = callback;
+	req->context = context;
+
+	src_in = (struct sockaddr_in *) &req->src_addr;
+	dst_in = (struct sockaddr_in *) &req->dst_addr;
+
+	req->status = addr_resolve_local(src_in, dst_in, addr);
+	if (req->status == -EADDRNOTAVAIL)
+		req->status = addr_resolve_remote(src_in, dst_in, addr);
+
+	switch (req->status) {
+	case 0:
+		req->timeout = jiffies;
+		queue_req(req);
+		break;
+	case -ENODATA:
+		req->timeout = msecs_to_jiffies(timeout_ms) + jiffies;
+		queue_req(req);
+		addr_send_arp(dst_in);
+		break;
+	default:
+		ret = req->status;
+		kfree(req);
+		break;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(rdma_resolve_ip);
+
+void rdma_addr_cancel(struct rdma_dev_addr *addr)
+{
+	struct addr_req *req, *temp_req;
+
+	up(&mutex);
+	list_for_each_entry_safe(req, temp_req, &req_list, list) {
+		if (req->addr == addr) {
+			req->status = -ECANCELED;
+			req->timeout = jiffies;
+			list_del(&req->list);
+			list_add(&req->list, &req_list);
+			set_timeout(req->timeout);
+			break;
+		}
+	}
+	up(&mutex);
+}
+EXPORT_SYMBOL(rdma_addr_cancel);
+
+static int addr_arp_recv(struct sk_buff *skb, struct net_device *dev,
+			 struct packet_type *pkt, struct net_device *orig_dev)
+{
+	struct arphdr *arp_hdr;
+
+	arp_hdr = (struct arphdr *) skb->nh.raw;
+
+	if (dev->type == ARPHRD_INFINIBAND &&
+	    (arp_hdr->ar_op == __constant_htons(ARPOP_REQUEST) ||
+	     arp_hdr->ar_op == __constant_htons(ARPOP_REPLY)))
+		set_timeout(jiffies);
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static struct packet_type addr_arp = {
+	.type           = __constant_htons(ETH_P_ARP),
+	.func           = addr_arp_recv,
+	.af_packet_priv = (void*) 1,
+};
+
+static int addr_init(void)
+{
+	rdma_wq = create_singlethread_workqueue("rdma_wq");
+	if (!rdma_wq)
+		return -ENOMEM;
+
+	dev_add_pack(&addr_arp);
+	return 0;
+}
+
+static void addr_cleanup(void)
+{
+	dev_remove_pack(&addr_arp);
+	destroy_workqueue(rdma_wq);
+}
+
+module_init(addr_init);
+module_exit(addr_cleanup);
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/drivers/infiniband/core/Makefile 
linux-2.6.ib/drivers/infiniband/core/Makefile
--- linux-2.6.git/drivers/infiniband/core/Makefile	2006-01-16 16:03:08.000000000 -0800
+++ linux-2.6.ib/drivers/infiniband/core/Makefile	2006-01-16 16:14:24.000000000 -0800
@@ -1,5 +1,5 @@
 obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_sa.o \
-					ib_cm.o
+					ib_cm.o ib_addr.o
 obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
 obj-$(CONFIG_INFINIBAND_USER_ACCESS) +=	ib_uverbs.o ib_ucm.o
 
@@ -12,6 +12,8 @@ ib_sa-y :=			sa_query.o
 
 ib_cm-y :=			cm.o
 
+ib_addr-y :=			addr.o
+
 ib_umad-y :=			user_mad.o
 
 ib_ucm-y :=			ucm.o
diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/include/rdma/ib_addr.h 
linux-2.6.ib/include/rdma/ib_addr.h
--- linux-2.6.git/include/rdma/ib_addr.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.ib/include/rdma/ib_addr.h	2006-01-16 16:14:24.000000000 -0800
@@ -0,0 +1,117 @@
+/*
+ * Copyright (c) 2005 Voltaire Inc.  All rights reserved.
+ * Copyright (c) 2005 Intel Corporation.  All rights reserved.
+ *
+ * This Software is licensed under one of the following licenses:
+ *
+ * 1) under the terms of the "Common Public License 1.0" a copy of which is
+ *    available from the Open Source Initiative, see
+ *    http://www.opensource.org/licenses/cpl.php.
+ *
+ * 2) under the terms of the "The BSD License" a copy of which is
+ *    available from the Open Source Initiative, see
+ *    http://www.opensource.org/licenses/bsd-license.php.
+ *
+ * 3) under the terms of the "GNU General Public License (GPL) Version 2" a
+ *    copy of which is available from the Open Source Initiative, see
+ *    http://www.opensource.org/licenses/gpl-license.php.
+ *
+ * Licensee has the right to choose one of the above licenses.
+ *
+ * Redistributions of source code must retain the above copyright
+ * notice and one of the license notices.
+ *
+ * Redistributions in binary form must reproduce both the above copyright
+ * notice, one of the license notices in the documentation
+ * and/or other materials provided with the distribution.
+ *
+ */
+
+#if !defined(IB_ADDR_H)
+#define IB_ADDR_H
+
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/netdevice.h>
+#include <linux/socket.h>
+#include <rdma/ib_verbs.h>
+
+extern struct workqueue_struct *rdma_wq;
+
+struct rdma_dev_addr {
+	unsigned char src_dev_addr[MAX_ADDR_LEN];
+	unsigned char dst_dev_addr[MAX_ADDR_LEN];
+	unsigned char broadcast[MAX_ADDR_LEN];
+	enum ib_node_type dev_type;
+};
+
+/**
+ * rdma_translate_ip - Translate a local IP address to an RDMA hardware
+ *   address.
+ */
+int rdma_translate_ip(struct sockaddr *addr, struct rdma_dev_addr *dev_addr);
+
+/**
+ * rdma_resolve_ip - Resolve source and destination IP addresses to
+ *   RDMA hardware addresses.
+ * @src_addr: An optional source address to use in the resolution.  If a
+ *   source address is not provided, a usable address will be returned via
+ *   the callback.
+ * @dst_addr: The destination address to resolve.
+ * @addr: A reference to a data location that will receive the resolved
+ *   addresses.  The data location must remain valid until the callback has
+ *   been invoked.
+ * @timeout_ms: Amount of time to wait for the address resolution to complete.
+ * @callback: Call invoked once address resolution has completed, timed out,
+ *   or been canceled.  A status of 0 indicates success.
+ * @context: User-specified context associated with the call.
+ */
+int rdma_resolve_ip(struct sockaddr *src_addr, struct sockaddr *dst_addr,
+		    struct rdma_dev_addr *addr, int timeout_ms,
+		    void (*callback)(int status, struct sockaddr *src_addr,
+				     struct rdma_dev_addr *addr, void *context),
+		    void *context);
+
+void rdma_addr_cancel(struct rdma_dev_addr *addr);
+
+static inline int ip_addr_size(struct sockaddr *addr)
+{
+	return addr->sa_family == AF_INET6 ?
+	       sizeof(struct sockaddr_in6) : sizeof(struct sockaddr_in);
+}
+
+static inline u16 ib_addr_get_pkey(struct rdma_dev_addr *dev_addr)
+{
+	return ((u16)dev_addr->broadcast[8] << 8) | (u16)dev_addr->broadcast[9];
+}
+
+static inline void ib_addr_set_pkey(struct rdma_dev_addr *dev_addr, u16 pkey)
+{
+	dev_addr->broadcast[8] = pkey >> 8;
+	dev_addr->broadcast[9] = (unsigned char) pkey;
+}
+
+static inline union ib_gid* ib_addr_get_sgid(struct rdma_dev_addr *dev_addr)
+{
+	return 	(union ib_gid *) (dev_addr->src_dev_addr + 4);
+}
+
+static inline void ib_addr_set_sgid(struct rdma_dev_addr *dev_addr,
+				    union ib_gid *gid)
+{
+	memcpy(dev_addr->src_dev_addr + 4, gid, sizeof *gid);
+}
+
+static inline union ib_gid* ib_addr_get_dgid(struct rdma_dev_addr *dev_addr)
+{
+	return 	(union ib_gid *) (dev_addr->dst_dev_addr + 4);
+}
+
+static inline void ib_addr_set_dgid(struct rdma_dev_addr *dev_addr,
+				    union ib_gid *gid)
+{
+	memcpy(dev_addr->dst_dev_addr + 4, gid, sizeof *gid);
+}
+
+#endif /* IB_ADDR_H */
+



