Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVCYGAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVCYGAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVCYF7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:59:04 -0500
Received: from digitalimplant.org ([64.62.235.95]:9427 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261426AbVCYFy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:58 -0500
Date: Thu, 24 Mar 2005 21:54:51 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [11/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242153040.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2249, 2005-03-24 19:08:30-08:00, mochel@digitalimplant.org
  [driver core] Use a klist for device child lists.

  - Use klist iterator in device_for_each_child(), making it safe to use for
    removing devices.
  - Remove unused list_to_dev() function.
  - Kills all usage of devices_subsys.rwsem.


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2005-03-24 20:32:46 -08:00
+++ b/drivers/base/core.c	2005-03-24 20:32:46 -08:00
@@ -210,8 +210,7 @@
 {
 	kobj_set_kset_s(dev, devices_subsys);
 	kobject_init(&dev->kobj);
-	INIT_LIST_HEAD(&dev->node);
-	INIT_LIST_HEAD(&dev->children);
+	klist_init(&dev->klist_children);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
 }
@@ -251,10 +250,8 @@
 		goto PMError;
 	if ((error = bus_add_device(dev)))
 		goto BusError;
-	down_write(&devices_subsys.rwsem);
 	if (parent)
-		list_add_tail(&dev->node, &parent->children);
-	up_write(&devices_subsys.rwsem);
+		klist_add_tail(&parent->klist_children, &dev->knode_parent);

 	/* notify platform of device entry */
 	if (platform_notify)
@@ -336,10 +333,8 @@
 {
 	struct device * parent = dev->parent;

-	down_write(&devices_subsys.rwsem);
 	if (parent)
-		list_del_init(&dev->node);
-	up_write(&devices_subsys.rwsem);
+		klist_remove(&dev->knode_parent);

 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
@@ -372,6 +367,12 @@
 }


+static struct device * next_device(struct klist_iter * i)
+{
+	struct klist_node * n = klist_next(i);
+	return n ? container_of(n, struct device, knode_parent) : NULL;
+}
+
 /**
  *	device_for_each_child - device child iterator.
  *	@dev:	parent struct device.
@@ -384,18 +385,17 @@
  *	We check the return of @fn each time. If it returns anything
  *	other than 0, we break out and return that value.
  */
-int device_for_each_child(struct device * dev, void * data,
+int device_for_each_child(struct device * parent, void * data,
 		     int (*fn)(struct device *, void *))
 {
+	struct klist_iter i;
 	struct device * child;
 	int error = 0;

-	down_read(&devices_subsys.rwsem);
-	list_for_each_entry(child, &dev->children, node) {
-		if((error = fn(child, data)))
-			break;
-	}
-	up_read(&devices_subsys.rwsem);
+	klist_iter_init(&parent->klist_children, &i);
+	while ((child = next_device(&i)) && !error)
+		error = fn(child, data);
+	klist_iter_exit(&i);
 	return error;
 }

diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-24 20:32:46 -08:00
+++ b/include/linux/device.h	2005-03-24 20:32:46 -08:00
@@ -263,8 +263,8 @@


 struct device {
-	struct list_head node;		/* node in sibling list */
-	struct list_head children;
+	struct klist		klist_children;
+	struct klist_node	knode_parent;		/* node in sibling list */
 	struct klist_node	knode_driver;
 	struct klist_node	knode_bus;
 	struct device 	* parent;
@@ -301,12 +301,6 @@

 	void	(*release)(struct device * dev);
 };
-
-static inline struct device *
-list_to_dev(struct list_head *node)
-{
-	return list_entry(node, struct device, node);
-}

 static inline void *
 dev_get_drvdata (struct device *dev)
