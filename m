Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWCVGFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWCVGFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWCVGFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:05:06 -0500
Received: from ns1.siteground.net ([207.218.208.2]:31191 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750795AbWCVGFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:05:03 -0500
Date: Tue, 21 Mar 2006 22:05:40 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: [patch 1/2] net: Node aware multipath device round robin
Message-ID: <20060322060540.GA3603@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch adds in node aware, device round robin ip multipathing.  
It is based on multipath_drr.c, the multipath device round robin algorithm, and
is derived from it.  This implementation maintians per node state table, and 
round robins between interfaces on the same node.  The implementation needs to 
be aware of the NIC proximity to a node.  Hence we have added a nodeid field to 
struct netdevice.  NIC device drivers can initialize this with the node id 
the NIC belongs to.  This patch uses IP_MP_ALG_DRR slot like the regular 
multipath_drr too.  So either SMP multipath_drr or node aware 
multipath_node_drr should be used for device round robin, based on system having
proximity information for the NICs.

Performance results:
1. Single NIC test -- 1 client targets 1 nic on the server with 300 concurrent 
requests.
2. 4 NIC test -- 1 client targets 4 nics, all on different nodes on the server with 300 concurrent requests.

We see about 135% improvement on AB requests per second with this patch and 
the device_locality_check patch on single NIC test, on the Rackable c5100 
machine (server).  We see about 64% improvement  when all 4 NICS are targeted.

Credits:  This work was originally done by Justin Forbes 

Comments?

Signed-off by: Pravin B. Shelar <pravin.shelar@calsoftinc.com>
Signed-off by: Shobhit Dayal <shobhit.dayal@calsoftinc.com>
Signed-off by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.16.orig/drivers/net/e1000/e1000_main.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/drivers/net/e1000/e1000_main.c	2006-03-20 14:52:23.000000000 -0800
@@ -692,6 +692,7 @@ e1000_probe(struct pci_dev *pdev,
 
 	SET_MODULE_OWNER(netdev);
 	SET_NETDEV_DEV(netdev, &pdev->dev);
+	SET_NETDEV_NODE(netdev, pcibus_to_node(pdev->bus));
 
 	pci_set_drvdata(pdev, netdev);
 	adapter = netdev_priv(netdev);
Index: linux-2.6.16/drivers/net/tg3.c
===================================================================
--- linux-2.6.16.orig/drivers/net/tg3.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/drivers/net/tg3.c	2006-03-20 14:52:23.000000000 -0800
@@ -10705,6 +10705,7 @@ static int __devinit tg3_init_one(struct
 
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
+	SET_NETDEV_NODE(dev, pcibus_to_node(pdev->bus));
 
 	dev->features |= NETIF_F_LLTX;
 #if TG3_VLAN_TAG_USED
Index: linux-2.6.16/include/linux/netdevice.h
===================================================================
--- linux-2.6.16.orig/include/linux/netdevice.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/include/linux/netdevice.h	2006-03-20 14:52:23.000000000 -0800
@@ -315,7 +315,9 @@ struct net_device
 	/* Interface index. Unique device identifier	*/
 	int			ifindex;
 	int			iflink;
-
+#ifdef CONFIG_NUMA
+	int			node;	/* NUMA node this IF is close to */
+#endif
 
 	struct net_device_stats* (*get_stats)(struct net_device *dev);
 	struct iw_statistics*	(*get_wireless_stats)(struct net_device *dev);
@@ -520,6 +522,14 @@ static inline void *netdev_priv(struct n
  */
 #define SET_NETDEV_DEV(net, pdev)	((net)->class_dev.dev = (pdev))
 
+#ifdef CONFIG_NUMA
+#define SET_NETDEV_NODE(dev, nodeid)	((dev)->node = (nodeid))
+#define netdev_node(dev)		((dev)->node)
+#else
+#define SET_NETDEV_NODE(dev, nodeid)	do {} while (0)
+#define netdev_node(dev)		(-1)
+#endif
+
 struct packet_type {
 	__be16			type;	/* This is really htons(ether_type). */
 	struct net_device	*dev;	/* NULL is wildcarded here	     */
Index: linux-2.6.16/net/core/dev.c
===================================================================
--- linux-2.6.16.orig/net/core/dev.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/net/core/dev.c	2006-03-20 14:52:23.000000000 -0800
@@ -3003,7 +3003,8 @@ struct net_device *alloc_netdev(int size
 
 	if (sizeof_priv)
 		dev->priv = netdev_priv(dev);
-
+	
+	SET_NETDEV_NODE(dev, -1);
 	setup(dev);
 	strcpy(dev->name, name);
 	return dev;
Index: linux-2.6.16/net/ipv4/Kconfig
===================================================================
--- linux-2.6.16.orig/net/ipv4/Kconfig	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/net/ipv4/Kconfig	2006-03-20 14:52:23.000000000 -0800
@@ -164,6 +164,15 @@ config IP_ROUTE_MULTIPATH_DRR
 	  available interfaces. This policy makes sense if the connections 
 	  should be primarily distributed on interfaces and not on routes. 
 
+config IP_ROUTE_MULTIPATH_NODE
+	tristate "MULTIPATH: interface RR algorithm with node affinity"
+	depends on IP_ROUTE_MULTIPATH_CACHED && NUMA && !IP_ROUTE_MULTIPATH_DRR
+	help
+	  This allows equal cost multipath device round robin alogorithm  to
+	  use node affinity when choosing the device for outbound traffic. This
+	  is similar to CONFIG_IP_ROUTE_MULTIPATH_DRR. Choose this if you
+	  have a NUMA system, and the NICs have node proximity.
+
 config IP_ROUTE_VERBOSE
 	bool "IP: verbose route monitoring"
 	depends on IP_ADVANCED_ROUTER
Index: linux-2.6.16/net/ipv4/Makefile
===================================================================
--- linux-2.6.16.orig/net/ipv4/Makefile	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/net/ipv4/Makefile	2006-03-20 14:52:23.000000000 -0800
@@ -28,6 +28,7 @@ obj-$(CONFIG_IP_ROUTE_MULTIPATH_RR) += m
 obj-$(CONFIG_IP_ROUTE_MULTIPATH_RANDOM) += multipath_random.o
 obj-$(CONFIG_IP_ROUTE_MULTIPATH_WRANDOM) += multipath_wrandom.o
 obj-$(CONFIG_IP_ROUTE_MULTIPATH_DRR) += multipath_drr.o
+obj-$(CONFIG_IP_ROUTE_MULTIPATH_NODE) += multipath_node_drr.o
 obj-$(CONFIG_NETFILTER)	+= netfilter.o netfilter/
 obj-$(CONFIG_IP_VS) += ipvs/
 obj-$(CONFIG_INET_DIAG) += inet_diag.o 
Index: linux-2.6.16/net/ipv4/multipath_node_drr.c
===================================================================
--- linux-2.6.16.orig/net/ipv4/multipath_node_drr.c	2006-02-28 01:25:15.174738088 -0800
+++ linux-2.6.16/net/ipv4/multipath_node_drr.c	2006-03-20 14:52:23.000000000 -0800
@@ -0,0 +1,264 @@
+/*
+ *  Node aware device round robin policy for multipath.
+ *  Extension of multipath device round robin for NUMA node based multipathing.
+ *  Derived from net/ipv4/multipath_drr.c
+ */
+
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <net/ip_mp_alg.h>
+
+struct multipath_device {
+	int		ifi; /* interface index of device */
+	atomic_t	usecount;
+	int 		allocated;
+	int 		node; /* node id of device */
+};
+
+#define MULTIPATH_MAX_DEVICECANDIDATES 16
+
+static struct multipath_device *local_state[MAX_NUMNODES] __read_mostly;
+static DEFINE_SPINLOCK(state_lock);
+
+static int inline __multipath_findslot(int ifindex, int nid)
+{
+	int i, idx, mx;
+	struct multipath_device *state = local_state[nid];
+
+	i = ifindex % MULTIPATH_MAX_DEVICECANDIDATES;
+	if (likely(state[i].allocated == 0))
+		return i;
+
+	mx = i + MULTIPATH_MAX_DEVICECANDIDATES;
+
+	for (; i < mx; i++) {
+		idx = i % MULTIPATH_MAX_DEVICECANDIDATES;
+		if (state[idx].allocated == 0)
+			return idx;
+	}
+	return -1;
+}
+
+static int inline __multipath_finddev(int ifindex, int nid)
+{
+	int i, mx, idx;
+	struct multipath_device *state = local_state[nid];
+
+	i = ifindex % MULTIPATH_MAX_DEVICECANDIDATES;
+	if (likely(state[i].ifi == ifindex))
+		return i;
+
+	mx = i + MULTIPATH_MAX_DEVICECANDIDATES;
+
+	for (; i < mx; i++) {
+		idx = i % MULTIPATH_MAX_DEVICECANDIDATES;
+
+		if (state[idx].ifi == ifindex)
+			return idx;
+	}
+	return -1;
+}
+
+static int drr_dev_event(struct notifier_block *this,
+			 unsigned long event, void *ptr)
+{
+	struct net_device *dev = ptr;
+	int devidx, nid;
+
+	switch (event) {
+	case NETDEV_UNREGISTER:
+	case NETDEV_DOWN:
+		spin_lock_bh(&state_lock);
+		for_each_node(nid) {
+			devidx = __multipath_finddev(dev->ifindex, nid);
+			if (devidx != -1) {
+				local_state[nid][devidx].ifi = 0;
+				local_state[nid][devidx].allocated = 0;
+			}
+		}
+
+		spin_unlock_bh(&state_lock);
+		break;
+	};
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block drr_dev_notifier = {
+	.notifier_call	= drr_dev_event,
+};
+
+static void inline drr_safe_inc(atomic_t *usecount)
+{
+	int n;
+
+	atomic_inc(usecount);
+	n = atomic_read(usecount);
+	if (unlikely(n <= 0)) {
+		int i;
+		struct multipath_device *state = local_state[numa_node_id()];
+
+		for (i = 0; i < MULTIPATH_MAX_DEVICECANDIDATES; i++)
+			atomic_set(&state[i].usecount, 0);
+
+	}
+}
+
+static int update_state_table(struct rtable *nh, int node)
+{
+	int devidx = -1;
+	struct multipath_device *state;
+	int nh_ifidx = nh->u.dst.dev->ifindex;
+	/* add the interface to the array
+	 * SMP safe
+	 */
+	spin_lock_bh(&state_lock);
+
+	/* due to SMP: search again */
+	devidx = __multipath_finddev(nh_ifidx, node);
+	if (devidx == -1) {
+		/* add entry for device */
+		state = local_state[node];
+		/* find free slot in state table */
+		devidx = __multipath_findslot(nh_ifidx, node);
+		if (devidx == -1) {
+			/* unlikely but possible */
+			goto out;
+		} else {
+			state[devidx].allocated = 1;
+			state[devidx].ifi = nh_ifidx;
+			atomic_set(&state[devidx].usecount, 0);
+			state[devidx].node = netdev_node(nh->u.dst.dev);
+		}
+	}
+out:
+	spin_unlock_bh(&state_lock);
+	return devidx;
+}
+
+static void drr_select_route(const struct flowi *flp,
+			     struct rtable *first, struct rtable **rp)
+{
+	struct rtable *nh, *cur_min = NULL, *cur_min_nrr = NULL;
+	int devidx = -1;
+	int cur_min_devidx = -1, cur_min_devidx_nrr = -1;
+	int min_usecount = INT_MAX, min_usecount_nrr = INT_MAX;
+	int node = numa_node_id();
+	struct multipath_device *state;
+
+	/* 1. make sure all alt. nexthops have the same GC related data */
+	/* 2. determine the new candidate to be returned */
+	state = local_state[node];
+	for (nh = rcu_dereference(first); nh;
+	     nh = rcu_dereference(nh->u.rt_next)) {
+		if ((nh->u.dst.flags & DST_BALANCED) != 0 &&
+		    multipath_comparekeys(&nh->fl, flp)) {
+			int count;
+			int nh_ifidx = nh->u.dst.dev->ifindex;
+
+			nh->u.dst.lastuse = jiffies;
+			nh->u.dst.__use++;
+
+			/* search for the output interface */
+
+			/* this is not SMP safe, only add/remove are
+			 * SMP safe as wrong usecount updates have no big
+			 * impact
+			 */
+			devidx = __multipath_finddev(nh_ifidx, node);
+			if (devidx == -1) {
+				devidx = update_state_table(nh, node);
+				if (devidx == -1)
+					continue;
+			}
+			count = atomic_read(&state[devidx].usecount);
+
+			/* RR on node local interfaces if available */
+			if (state[devidx].node == node) {
+				if (count < min_usecount_nrr) {
+					cur_min_nrr = nh;
+					cur_min_devidx_nrr = devidx;
+					min_usecount_nrr = count;
+					/* lowest used.  So use this IF */
+					if (min_usecount_nrr == 0)
+						break;
+				}
+			} else {
+				if (count < min_usecount) {
+					cur_min = nh;
+					cur_min_devidx = devidx;
+					min_usecount = count;
+				}
+			}
+		}
+	}
+
+	/* If node local route is present, choose it.  Else choose SMP RR */
+	if (cur_min_devidx_nrr != -1) {
+		drr_safe_inc(&state[cur_min_devidx_nrr].usecount);
+		*rp = cur_min_nrr;
+		return ;
+	}
+	
+	if (cur_min_devidx != -1) {
+		drr_safe_inc(&state[cur_min_devidx].usecount);
+		*rp = cur_min;
+	} else
+		*rp = first;
+}
+
+static struct ip_mp_alg_ops drr_ops = {
+	.mp_alg_select_route	=	drr_select_route,
+};
+
+static int __init drr_init(void)
+{
+	int err, nid;
+	int size = MULTIPATH_MAX_DEVICECANDIDATES * 
+			sizeof(struct multipath_device);
+	for_each_node(nid) {
+		int i;
+		local_state[nid] = kmalloc_node(size, GFP_KERNEL, nid);
+		if (local_state[nid] == NULL) {
+			int i;
+			for_each_node(i){
+				if (i < nid)
+					kfree(local_state[i]);
+			}
+			printk(KERN_CRIT"drr_init: Cannot allocate state table\n");
+			return -ENOMEM;
+		}
+		for (i = 0; i < MULTIPATH_MAX_DEVICECANDIDATES; i++) {
+			local_state[nid][i].allocated = 0;
+			local_state[nid][i].ifi = 0;
+		}
+	}
+	err = register_netdevice_notifier(&drr_dev_notifier);
+
+	if (err)
+		return err;
+
+	err = multipath_alg_register(&drr_ops, IP_MP_ALG_DRR);
+	if (err)
+		goto fail;
+
+	return 0;
+
+fail:
+	unregister_netdevice_notifier(&drr_dev_notifier);
+	return err;
+}
+
+static void __exit drr_exit(void)
+{
+	int nid;
+	unregister_netdevice_notifier(&drr_dev_notifier);
+	multipath_alg_unregister(&drr_ops, IP_MP_ALG_DRR);
+	for_each_node(nid){
+		kfree(local_state[nid]);
+	}
+}
+
+module_init(drr_init);
+module_exit(drr_exit);
+MODULE_LICENSE("GPL");
