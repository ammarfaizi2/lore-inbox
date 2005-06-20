Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVFUCac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVFUCac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFUC12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:27:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:28644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261700AbVFTW7q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:46 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Use a klist for device child lists.
In-Reply-To: <11193083662460@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <11193083662698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Use a klist for device child lists.

- Use klist iterator in device_for_each_child(), making it safe to use for
  removing devices.
- Remove unused list_to_dev() function.
- Kills all usage of devices_subsys.rwsem.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 36239577cfb6b9a7c111209536b54200b0252ebf
tree f8fa5034fbb31d273d0889119cbc20e4c4b0c983
parent 9a881f166f473373589ce6f3fdc47b44a1450e2d
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 19:08:30 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:23 -0700

 drivers/base/core.c    |   30 +++++++++++++++---------------
 include/linux/device.h |   10 ++--------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -207,8 +207,7 @@ void device_initialize(struct device *de
 {
 	kobj_set_kset_s(dev, devices_subsys);
 	kobject_init(&dev->kobj);
-	INIT_LIST_HEAD(&dev->node);
-	INIT_LIST_HEAD(&dev->children);
+	klist_init(&dev->klist_children);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
 }
@@ -249,10 +248,8 @@ int device_add(struct device *dev)
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
@@ -335,10 +332,8 @@ void device_del(struct device * dev)
 {
 	struct device * parent = dev->parent;
 
-	down_write(&devices_subsys.rwsem);
 	if (parent)
-		list_del_init(&dev->node);
-	up_write(&devices_subsys.rwsem);
+		klist_remove(&dev->knode_parent);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
@@ -372,6 +367,12 @@ void device_unregister(struct device * d
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
@@ -384,18 +385,17 @@ void device_unregister(struct device * d
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
 
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -262,8 +262,8 @@ extern void class_device_destroy(struct 
 
 
 struct device {
-	struct list_head node;		/* node in sibling list */
-	struct list_head children;
+	struct klist		klist_children;
+	struct klist_node	knode_parent;		/* node in sibling list */
 	struct klist_node	knode_driver;
 	struct klist_node	knode_bus;
 	struct device 	* parent;
@@ -298,12 +298,6 @@ struct device {
 	void	(*release)(struct device * dev);
 };
 
-static inline struct device *
-list_to_dev(struct list_head *node)
-{
-	return list_entry(node, struct device, node);
-}
-
 static inline void *
 dev_get_drvdata (struct device *dev)
 {

