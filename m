Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWFIVG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWFIVG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWFIVGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:06:42 -0400
Received: from AToulouse-252-1-74-163.w81-49.abo.wanadoo.fr ([81.49.44.163]:6355
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S965302AbWFIVGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:06:34 -0400
Message-Id: <20060609210625.144158000@localhost.localdomain>
References: <20060609210202.215291000@localhost.localdomain>
Date: Fri, 09 Jun 2006 23:02:04 +0200
From: dlezcano@fr.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com, dlezcano@fr.ibm.com
Subject: [RFC] [patch 2/6] [Network namespace] Network device sharing by view
Content-Disposition: inline; filename=net_ns_dev.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds to the network namespace a device list view. This view is emptied
when the unshare is done. The view is filled/emptied by a set of
function which can be called by an external module.

Replace-Subject: [Network namespace] Network device sharing by view
Signed-off-by: Daniel Lezcano <dlezcano@fr.ibm.com> 
--
 include/linux/net_ns.h     |    2 
 include/linux/net_ns_dev.h |   32 +++++++
 init/version.c             |    4 
 net/core/Makefile          |    2 
 net/core/net_ns_dev.c      |  205 +++++++++++++++++++++++++++++++++++++++++++++
 net/net_ns.c               |    6 +
 6 files changed, 250 insertions(+), 1 deletion(-)

Index: 2.6-mm/include/linux/net_ns_dev.h
===================================================================
--- /dev/null
+++ 2.6-mm/include/linux/net_ns_dev.h
@@ -0,0 +1,32 @@
+#ifndef _LINUX_NET_NS_DEV_H
+#define _LINUX_NET_NS_DEV_H
+
+struct net_device;
+
+struct net_ns_dev {
+	struct list_head list;
+	struct net_device *dev;
+};
+
+struct net_ns_dev_list {
+	struct list_head list;
+	rwlock_t lock;
+};
+
+extern int net_ns_dev_unregister(struct net_device *dev,
+				 struct net_ns_dev_list *devlist);
+
+extern int net_ns_dev_register(struct net_device *dev,
+			       struct net_ns_dev_list *devlist);
+
+extern struct net_device *net_ns_dev_find_by_name(const char *devname,
+						  struct net_ns_dev_list *devlist);
+extern int net_ns_dev_remove(const char *devname,
+			     struct net_ns_dev_list *devlist);
+
+extern int net_ns_dev_add(const char *devname,
+			  struct net_ns_dev_list *devlist);
+
+extern int free_net_ns_dev(struct net_ns_dev_list *devlist);
+
+#endif
Index: 2.6-mm/include/linux/net_ns.h
===================================================================
--- 2.6-mm.orig/include/linux/net_ns.h
+++ 2.6-mm/include/linux/net_ns.h
@@ -4,9 +4,11 @@
 #include <linux/kref.h>
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
+#include <linux/net_ns_dev.h>
 
 struct net_namespace {
 	struct kref kref;
+	struct net_ns_dev_list dev_list;
 };
 
 extern struct net_namespace init_net_ns;
Index: 2.6-mm/net/core/net_ns_dev.c
===================================================================
--- /dev/null
+++ 2.6-mm/net/core/net_ns_dev.c
@@ -0,0 +1,205 @@
+/*
+ *  net_ns_dev.c - adds namespace netwok device view
+ *
+ *  Copyright (C) 2006 IBM
+ *
+ *  Author: Daniel Lezcano <dlezcano@fr.ibm.com>
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation, version 2 of the
+ *     License.
+ */
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/netdevice.h>
+#include <linux/net_ns_dev.h>
+
+int free_net_ns_dev(struct net_ns_dev_list *devlist)
+{
+	struct list_head *l, *next;
+	struct net_ns_dev *db;
+	struct net_device *dev;
+
+	write_lock(&devlist->lock);
+	list_for_each_safe(l, next, &devlist->list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
+		list_del(&db->list);
+		dev_put(dev);
+		kfree(db);
+	}
+	write_unlock(&devlist->lock);
+
+	return 0;
+}
+
+/*
+ * Remove a device to the namespace network devices list
+ * when registered from a namespace
+ * @dev : network device
+ * @dev_list: network namespace devices
+ * Return ENODEV if the device does not exist,
+ */
+int net_ns_dev_unregister(struct net_device *dev,
+			  struct net_ns_dev_list *devlist)
+{
+	struct net_ns_dev *db;
+	struct list_head *l;
+	int ret = -ENODEV;
+
+	write_lock(&devlist->lock);
+	list_for_each(l, &devlist->list) {
+		db = list_entry(l, struct net_ns_dev, list);
+ 		if (dev != db->dev)
+ 			continue;
+
+ 		list_del(&db->list);
+ 		dev_put(dev);
+ 		kfree(db);
+ 		ret = 0;
+ 		break;
+	}
+	write_unlock(&devlist->lock);
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(net_ns_dev_unregister);
+
+/*
+ * Add a device to the namespace network devices list
+ * when registered from a namespace
+ * @dev : network device
+ * @dev_list: network namespace devices
+ * Return ENOMEM if allocation fails, 0 on success
+ */
+int net_ns_dev_register(struct net_device *dev,
+			struct net_ns_dev_list *devlist)
+{
+	struct net_ns_dev *db;
+
+	db = kmalloc(sizeof(*db), GFP_KERNEL);
+	if (!db)
+		return -ENOMEM;
+
+	write_lock(&devlist->lock);
+	dev_hold(dev);
+	db->dev = dev;
+	list_add_tail(&db->list, &devlist->list);
+	write_unlock(&devlist->lock);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(net_ns_dev_register);
+
+/*
+ * Add a device to the namespace network devices list
+ * @devname : network device name
+ * @dev_list: network namespace devices
+ * Return ENODEV if the device does not exist,
+ * ENOMEM if allocation fails, 0 on success
+ */
+int net_ns_dev_add(const char *devname,
+		   struct net_ns_dev_list *devlist)
+{
+	struct net_ns_dev *db;
+	struct net_device *dev;
+	int ret = 0;
+
+	read_lock(&dev_base_lock);
+
+	for (dev = dev_base; dev; dev = dev->next)
+		if (!strncmp(dev->name, devname, IFNAMSIZ))
+			break;
+
+	if (!dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	db = kmalloc(sizeof(*db), GFP_KERNEL);
+	if (!db) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	write_lock(&devlist->lock);
+	db->dev = dev;
+	dev_hold(dev);
+	list_add_tail(&db->list, &devlist->list);
+	write_unlock(&devlist->lock);
+
+out:
+	read_unlock(&dev_base_lock);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(net_ns_dev_add);
+
+/*
+ * Remove a device from the namespace network devices list
+ * @devname : network device name
+ * @dev_list: network namespace devices
+ * Return ENODEV if the device does not exist, 0 on success
+ */
+int net_ns_dev_remove(const char *devname,
+		      struct net_ns_dev_list *devlist)
+{
+	struct net_ns_dev *db;
+	struct net_device *dev;
+	struct list_head *l;
+	int ret = 0;
+
+	write_lock(&devlist->lock);
+	list_for_each(l, &devlist->list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
+
+		if (!strncmp(dev->name, devname, IFNAMSIZ)) {
+			list_del(&db->list);
+			dev_put(dev);
+			kfree(db);
+			goto out;
+		}
+	}
+	ret = -ENODEV;
+out:
+	write_unlock(&devlist->lock);
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(net_ns_dev_remove);
+
+/*
+ * Find a namespace network device
+ * @devname : network device name
+ * @dev_list: network namespace devices
+ * Return ENODEV if the device does not exist, 0 on success
+ */
+struct net_device *net_ns_dev_find_by_name(const char *devname,
+					   struct net_ns_dev_list *devlist)
+{
+	struct net_ns_dev *db;
+	struct net_device *dev;
+	struct list_head *l;
+
+	read_lock(&devlist->lock);
+
+	list_for_each(l, &devlist->list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
+
+		if (!strncmp(dev->name, devname, IFNAMSIZ)) {
+			dev_hold(dev);
+			goto out;
+		}
+	}
+	dev = NULL;
+out:
+	read_unlock(&devlist->lock);
+	return dev;
+}
+
+EXPORT_SYMBOL_GPL(net_ns_dev_find_by_name);
Index: 2.6-mm/net/net_ns.c
===================================================================
--- 2.6-mm.orig/net/net_ns.c
+++ 2.6-mm/net/net_ns.c
@@ -23,11 +23,16 @@
 struct net_namespace *clone_net_ns(struct net_namespace *old_ns)
 {
 	struct net_namespace *new_ns;
+	struct net_ns_dev_list *new_dev_list;
 
 	new_ns = kmalloc(sizeof(*new_ns), GFP_KERNEL);
  	if (!new_ns)
  		return NULL;
+
  	kref_init(&new_ns->kref);
+ 	new_dev_list = &new_ns->dev_list;
+ 	INIT_LIST_HEAD(&new_dev_list->list);
+	new_dev_list->lock = RW_LOCK_UNLOCKED;
 	return new_ns;
 }
 
@@ -92,5 +97,6 @@ void free_net_ns(struct kref *kref)
 	struct net_namespace *ns;
 
 	ns = container_of(kref, struct net_namespace, kref);
+	free_net_ns_dev(&ns->dev_list);
 	kfree(ns);
 }
Index: 2.6-mm/net/core/Makefile
===================================================================
--- 2.6-mm.orig/net/core/Makefile
+++ 2.6-mm/net/core/Makefile
@@ -7,7 +7,7 @@ obj-y := sock.o request_sock.o skbuff.o 
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
-obj-y		     += dev.o ethtool.o dev_mcast.o dst.o \
+obj-y		     += dev.o net_ns_dev.o ethtool.o dev_mcast.o dst.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o
 
 obj-$(CONFIG_XFRM) += flow.o
Index: 2.6-mm/init/version.c
===================================================================
--- 2.6-mm.orig/init/version.c
+++ 2.6-mm/init/version.c
@@ -38,6 +38,10 @@ struct net_namespace init_net_ns = {
 	.kref = {
 		.refcount	= ATOMIC_INIT(2),
 	},
+	.dev_list = {
+		 .lock = RW_LOCK_UNLOCKED,
+		 .list = LIST_HEAD_INIT(init_net_ns.dev_list.list),
+	 },
 };
 EXPORT_SYMBOL_GPL(init_net_ns);
 

--
