Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWFIVHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWFIVHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFIVGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:06:40 -0400
Received: from AToulouse-252-1-74-163.w81-49.abo.wanadoo.fr ([81.49.44.163]:6099
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S965301AbWFIVGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:06:34 -0400
Message-Id: <20060609210627.064168000@localhost.localdomain>
References: <20060609210202.215291000@localhost.localdomain>
Date: Fri, 09 Jun 2006 23:02:05 +0200
From: dlezcano@fr.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com, dlezcano@fr.ibm.com
Subject: [RFC] [patch 3/6] [Network namespace] Network devices isolation 
Content-Disposition: inline; filename=netdev_isolation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dev list view is filled and used from here. The dev_base_list has
been replaced to the dev list view and devices can be accessed only if
the view has the device in its list. All calls from the userspace,
ioctls, netlinks and procfs, will use the network devices view instead
of the global network device list.

Replace-Subject: [Network namespace] Network devices isolation 
Signed-off-by: Daniel Lezcano <dlezcano@fr.ibm.com> 
--
 net/core/dev.c       |  147 ++++++++++++++++++++++++++++++++++++++-------------
 net/core/rtnetlink.c |   21 +++++--
 2 files changed, 126 insertions(+), 42 deletions(-)

Index: 2.6-mm/net/core/dev.c
===================================================================
--- 2.6-mm.orig/net/core/dev.c
+++ 2.6-mm/net/core/dev.c
@@ -115,6 +115,7 @@
 #include <net/iw_handler.h>
 #include <asm/current.h>
 #include <linux/audit.h>
+#include <linux/net_ns.h>
 #include <linux/dmaengine.h>
 
 /*
@@ -474,13 +475,16 @@
 
 struct net_device *__dev_get_by_name(const char *name)
 {
-	struct hlist_node *p;
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct list_head *l, *list = &dev_list->list;
+	struct net_ns_dev *db;
+	struct net_device *dev;
 
-	hlist_for_each(p, dev_name_hash(name)) {
-		struct net_device *dev
-			= hlist_entry(p, struct net_device, name_hlist);
+	list_for_each(l, list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
 		if (!strncmp(dev->name, name, IFNAMSIZ))
-			return dev;
+ 			return dev;
 	}
 	return NULL;
 }
@@ -498,13 +502,14 @@
 
 struct net_device *dev_get_by_name(const char *name)
 {
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
 	struct net_device *dev;
 
-	read_lock(&dev_base_lock);
+	read_lock(&dev_list->lock);
 	dev = __dev_get_by_name(name);
 	if (dev)
 		dev_hold(dev);
-	read_unlock(&dev_base_lock);
+	read_unlock(&dev_list->lock);
 	return dev;
 }
 
@@ -521,11 +526,14 @@
 
 struct net_device *__dev_get_by_index(int ifindex)
 {
-	struct hlist_node *p;
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct list_head *l, *list = &dev_list->list;
+	struct net_ns_dev *db;
+	struct net_device *dev;
 
-	hlist_for_each(p, dev_index_hash(ifindex)) {
-		struct net_device *dev
-			= hlist_entry(p, struct net_device, index_hlist);
+	list_for_each(l, list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
 		if (dev->ifindex == ifindex)
 			return dev;
 	}
@@ -545,13 +553,14 @@
 
 struct net_device *dev_get_by_index(int ifindex)
 {
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
 	struct net_device *dev;
 
-	read_lock(&dev_base_lock);
+	read_lock(&dev_list->lock);
 	dev = __dev_get_by_index(ifindex);
 	if (dev)
 		dev_hold(dev);
-	read_unlock(&dev_base_lock);
+	read_unlock(&dev_list->lock);
 	return dev;
 }
 
@@ -571,14 +580,24 @@
 
 struct net_device *dev_getbyhwaddr(unsigned short type, char *ha)
 {
-	struct net_device *dev;
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct list_head *l, *list = &dev_list->list;
+	struct net_ns_dev *db;
+	struct net_device *dev = NULL;
 
 	ASSERT_RTNL();
 
-	for (dev = dev_base; dev; dev = dev->next)
+	read_lock(&dev_list->lock);
+	list_for_each(l, list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
 		if (dev->type == type &&
 		    !memcmp(dev->dev_addr, ha, dev->addr_len))
-			break;
+			goto out;
+	}
+	dev = NULL;
+out:
+	read_unlock(&dev_list->lock);
 	return dev;
 }
 
@@ -586,15 +605,25 @@
 
 struct net_device *dev_getfirstbyhwtype(unsigned short type)
 {
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct list_head *l, *list = &dev_list->list;
+	struct net_ns_dev *db;
 	struct net_device *dev;
 
 	rtnl_lock();
-	for (dev = dev_base; dev; dev = dev->next) {
+
+	read_lock(&dev_list->lock);
+	list_for_each(l, list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
 		if (dev->type == type) {
 			dev_hold(dev);
-			break;
+			goto out;
 		}
 	}
+	dev = NULL;
+out:
+	read_unlock(&dev_list->lock);
 	rtnl_unlock();
 	return dev;
 }
@@ -614,16 +643,23 @@
 
 struct net_device * dev_get_by_flags(unsigned short if_flags, unsigned short mask)
 {
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct list_head *l, *list = &dev_list->list;
+	struct net_ns_dev *db;
 	struct net_device *dev;
 
-	read_lock(&dev_base_lock);
-	for (dev = dev_base; dev != NULL; dev = dev->next) {
+	read_lock(&dev_list->lock);
+	list_for_each(l, list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
 		if (((dev->flags ^ if_flags) & mask) == 0) {
 			dev_hold(dev);
-			break;
+			goto out;
 		}
 	}
-	read_unlock(&dev_base_lock);
+	dev = NULL;
+out:
+	read_unlock(&dev_list->lock);
 	return dev;
 }
 
@@ -1942,6 +1978,9 @@
 static int dev_ifconf(char __user *arg)
 {
 	struct ifconf ifc;
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct list_head *l, *list = &dev_list->list;
+	struct net_ns_dev *db;
 	struct net_device *dev;
 	char __user *pos;
 	int len;
@@ -1963,8 +2002,14 @@
 	 */
 
 	total = 0;
-	for (dev = dev_base; dev; dev = dev->next) {
+
+	list_for_each(l, list) {
+
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
+
 		for (i = 0; i < NPROTO; i++) {
+
 			if (gifconf_list[i]) {
 				int done;
 				if (!pos)
@@ -1995,40 +2040,63 @@
  *	This is invoked by the /proc filesystem handler to display a device
  *	in detail.
  */
-static __inline__ struct net_device *dev_get_idx(loff_t pos)
+static __inline__ struct net_ns_dev *dev_get_idx(loff_t pos)
 {
-	struct net_device *dev;
-	loff_t i;
-
-	for (i = 0, dev = dev_base; dev && i < pos; ++i, dev = dev->next);
-
-	return i == pos ? dev : NULL;
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct list_head *l, *list = &dev_list->list;
+	struct net_ns_dev *db;
+
+	loff_t i = 0;
+
+	list_for_each(l, list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		if (i == pos)
+			return db;
+		i++;
+	};
+	return NULL;
 }
 
 void *dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	read_lock(&dev_base_lock);
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+
+	read_lock(&dev_list->lock);
 	return *pos ? dev_get_idx(*pos - 1) : SEQ_START_TOKEN;
 }
 
 void *dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct net_ns_dev *db = NULL;
+	struct list_head *next;
+
 	++*pos;
-	return v == SEQ_START_TOKEN ? dev_base : ((struct net_device *)v)->next;
+
+	if (v == SEQ_START_TOKEN)
+		next = dev_list->list.next;
+	else
+		next = ((struct net_ns_dev*)v)->list.next;
+	if (next && next != &dev_list->list)
+		db = list_entry(next, struct net_ns_dev, list);
+	return db;
 }
 
 void dev_seq_stop(struct seq_file *seq, void *v)
 {
-	read_unlock(&dev_base_lock);
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	read_unlock(&dev_list->lock);
 }
 
-static void dev_seq_printf_stats(struct seq_file *seq, struct net_device *dev)
+static void dev_seq_printf_stats(struct seq_file *seq, struct net_ns_dev *db)
 {
+	struct net_device *dev = db->dev;
+
 	if (dev->get_stats) {
 		struct net_device_stats *stats = dev->get_stats(dev);
 
 		seq_printf(seq, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
-				"%8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
+			        "%8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
 			   dev->name, stats->rx_bytes, stats->rx_packets,
 			   stats->rx_errors,
 			   stats->rx_dropped + stats->rx_missed_errors,
@@ -2402,7 +2470,7 @@
  */
 static int dev_ifsioc(struct ifreq *ifr, unsigned int cmd)
 {
-	int err;
+	int err = 0;
 	struct net_device *dev = __dev_get_by_name(ifr->ifr_name);
 
 	if (!dev)
@@ -2509,7 +2577,6 @@
 		/*
 		 *	Unknown or private ioctl
 		 */
-
 		default:
 			if ((cmd >= SIOCDEVPRIVATE &&
 			    cmd <= SIOCDEVPRIVATE + 15) ||
@@ -2847,6 +2914,10 @@
 		}
  	}
 
+	ret = net_ns_dev_register(dev, &(net_ns()->dev_list));
+	if (ret)
+		goto out_err;
+
 	/* Fix illegal SG+CSUM combinations. */
 	if ((dev->features & NETIF_F_SG) &&
 	    !(dev->features & (NETIF_F_IP_CSUM |
@@ -3218,6 +3289,8 @@
 		return -ENODEV;
 	}
 
+	net_ns_dev_unregister(dev, &(net_ns()->dev_list));
+
 	dev->reg_state = NETREG_UNREGISTERING;
 
 	synchronize_net();
Index: 2.6-mm/net/core/rtnetlink.c
===================================================================
--- 2.6-mm.orig/net/core/rtnetlink.c
+++ 2.6-mm/net/core/rtnetlink.c
@@ -55,6 +55,7 @@
 #include <linux/wireless.h>
 #include <net/iw_handler.h>
 #endif	/* CONFIG_NET_WIRELESS_RTNETLINK */
+#include <linux/net_ns.h>
 
 static DEFINE_MUTEX(rtnl_mutex);
 
@@ -315,21 +316,31 @@
 
 static int rtnetlink_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	int idx;
+	int idx = 0;
 	int s_idx = cb->args[0];
+
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+	struct list_head *l, *list = &dev_list->list;
+	struct net_ns_dev *db;
 	struct net_device *dev;
 
-	read_lock(&dev_base_lock);
-	for (dev=dev_base, idx=0; dev; dev = dev->next, idx++) {
-		if (idx < s_idx)
+	read_lock(&dev_list->lock);
+	list_for_each(l, list) {
+
+		if (idx++ < s_idx)
 			continue;
+
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
+
 		if (rtnetlink_fill_ifinfo(skb, dev, RTM_NEWLINK,
 					  NETLINK_CB(cb->skb).pid,
 					  cb->nlh->nlmsg_seq, 0,
 					  NLM_F_MULTI) <= 0)
 			break;
 	}
-	read_unlock(&dev_base_lock);
+	read_unlock(&dev_list->lock);
+
 	cb->args[0] = idx;
 
 	return skb->len;

--
