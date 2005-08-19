Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbVHSNOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbVHSNOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVHSNOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:14:07 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:60305 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932649AbVHSNOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:14:06 -0400
Subject: [PATCH] fix klist to have the same klist_add semantics as list_head
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 09:14:01 -0400
Message-Id: <1124457241.5130.10.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

at the moment, the list_head semantics are

list_add(node, head)

whereas current klist semantics are

klist_add(head, node)

This is bound to cause confusion, and since klist is the newcomer, it
should follow the list_head semantics.

I also added missing include guards to klist.h

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -356,7 +356,7 @@ int bus_add_device(struct device * dev)
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
 		device_attach(dev);
-		klist_add_tail(&bus->klist_devices, &dev->knode_bus);
+		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 		error = device_add_attrs(bus, dev);
 		if (!error) {
 			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
@@ -444,7 +444,7 @@ int bus_add_driver(struct device_driver 
 		}
 
 		driver_attach(drv);
-		klist_add_tail(&bus->klist_drivers, &drv->knode_bus);
+		klist_add_tail(&drv->knode_bus, &bus->klist_drivers);
 		module_add_driver(drv->owner, drv);
 
 		driver_add_attrs(bus, drv);
diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -249,7 +249,7 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	if (parent)
-		klist_add_tail(&parent->klist_children, &dev->knode_parent);
+		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
 	/* notify platform of device entry */
 	if (platform_notify)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -42,7 +42,7 @@ void device_bind_driver(struct device * 
 {
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
-	klist_add_tail(&dev->driver->klist_devices, &dev->knode_driver);
+	klist_add_tail(&dev->knode_driver, &dev->driver->klist_devices);
 	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
diff --git a/include/linux/klist.h b/include/linux/klist.h
--- a/include/linux/klist.h
+++ b/include/linux/klist.h
@@ -9,6 +9,9 @@
  *	This file is rleased under the GPL v2.
  */
 
+#ifndef _LINUX_KLIST_H
+#define _LINUX_KLIST_H
+
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/kref.h>
@@ -31,8 +34,8 @@ struct klist_node {
 	struct completion	n_removed;
 };
 
-extern void klist_add_tail(struct klist * k, struct klist_node * n);
-extern void klist_add_head(struct klist * k, struct klist_node * n);
+extern void klist_add_tail(struct klist_node * n, struct klist * k);
+extern void klist_add_head(struct klist_node * n, struct klist * k);
 
 extern void klist_del(struct klist_node * n);
 extern void klist_remove(struct klist_node * n);
@@ -53,3 +56,4 @@ extern void klist_iter_init_node(struct 
 extern void klist_iter_exit(struct klist_iter * i);
 extern struct klist_node * klist_next(struct klist_iter * i);
 
+#endif
diff --git a/lib/klist.c b/lib/klist.c
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -79,11 +79,11 @@ static void klist_node_init(struct klist
 
 /**
  *	klist_add_head - Initialize a klist_node and add it to front.
- *	@k:	klist it's going on.
  *	@n:	node we're adding.
+ *	@k:	klist it's going on.
  */
 
-void klist_add_head(struct klist * k, struct klist_node * n)
+void klist_add_head(struct klist_node * n, struct klist * k)
 {
 	klist_node_init(k, n);
 	add_head(k, n);
@@ -94,11 +94,11 @@ EXPORT_SYMBOL_GPL(klist_add_head);
 
 /**
  *	klist_add_tail - Initialize a klist_node and add it to back.
- *	@k:	klist it's going on.
  *	@n:	node we're adding.
+ *	@k:	klist it's going on.
  */
 
-void klist_add_tail(struct klist * k, struct klist_node * n)
+void klist_add_tail(struct klist_node * n, struct klist * k)
 {
 	klist_node_init(k, n);
 	add_tail(k, n);


