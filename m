Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVFUAq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVFUAq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVFUApt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:45:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:43236 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261761AbVFTW7x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:53 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Add a klist to struct bus_type for its drivers.
In-Reply-To: <11193083643493@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <11193083642073@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add a klist to struct bus_type for its drivers.

- Use it in bus_for_each_drv().
- Use the klist spinlock instead of the bus rwsem.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 38fdac3cdce276554b4484a41f8ec2daf81cb2ff
tree 1bdd0b8b69bd8e13de53036c8ef8b968a0dacc1d
parent 465c7a3a3a5aabcedd2e43612cac5a12f23da19a
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 12:00:18 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:14 -0700

 drivers/base/bus.c     |   52 +++++++++++++++++++++---------------------------
 include/linux/device.h |    2 ++
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -135,30 +135,6 @@ static struct kobj_type ktype_bus = {
 decl_subsys(bus, &ktype_bus, NULL);
 
 
-static int __bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-			      void * data, int (*fn)(struct device_driver *, void *))
-{
-	struct list_head *head;
-	struct device_driver *drv;
-	int error = 0;
-
-	if (!(bus = get_bus(bus)))
-		return -EINVAL;
-
-	head = &bus->drivers.list;
-	drv = list_prepare_entry(start, head, kobj.entry);
-	list_for_each_entry_continue(drv, head, kobj.entry) {
-		get_driver(drv);
-		error = fn(drv, data);
-		put_driver(drv);
-		if (error)
-			break;
-	}
-	put_bus(bus);
-	return error;
-}
-
-
 static struct device * next_device(struct klist_iter * i)
 {
 	struct klist_node * n = klist_next(i);
@@ -203,6 +179,14 @@ int bus_for_each_dev(struct bus_type * b
 	return error;
 }
 
+
+
+static struct device_driver * next_driver(struct klist_iter * i)
+{
+	struct klist_node * n = klist_next(i);
+	return n ? container_of(n, struct device_driver, knode_bus) : NULL;
+}
+
 /**
  *	bus_for_each_drv - driver iterator
  *	@bus:	bus we're dealing with.
@@ -226,12 +210,19 @@ int bus_for_each_dev(struct bus_type * b
 int bus_for_each_drv(struct bus_type * bus, struct device_driver * start,
 		     void * data, int (*fn)(struct device_driver *, void *))
 {
-	int ret;
+	struct klist_iter i;
+	struct device_driver * drv;
+	int error = 0;
 
-	down_read(&bus->subsys.rwsem);
-	ret = __bus_for_each_drv(bus, start, data, fn);
-	up_read(&bus->subsys.rwsem);
-	return ret;
+	if (!bus)
+		return -EINVAL;
+
+	klist_iter_init_node(&bus->klist_drivers, &i,
+			     start ? &start->knode_bus : NULL);
+	while ((drv = next_driver(&i)) && !error)
+		error = fn(drv, data);
+	klist_iter_exit(&i);
+	return error;
 }
 
 static int device_add_attrs(struct bus_type * bus, struct device * dev)
@@ -376,6 +367,7 @@ int bus_add_driver(struct device_driver 
 		down_write(&bus->subsys.rwsem);
 		driver_attach(drv);
 		up_write(&bus->subsys.rwsem);
+		klist_add_tail(&bus->klist_drivers, &drv->knode_bus);
 		module_add_driver(drv->owner, drv);
 
 		driver_add_attrs(bus, drv);
@@ -397,6 +389,7 @@ void bus_remove_driver(struct device_dri
 {
 	if (drv->bus) {
 		driver_remove_attrs(drv->bus, drv);
+		klist_remove(&drv->knode_bus);
 		down_write(&drv->bus->subsys.rwsem);
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
@@ -536,6 +529,7 @@ int bus_register(struct bus_type * bus)
 		goto bus_drivers_fail;
 
 	klist_init(&bus->klist_devices);
+	klist_init(&bus->klist_drivers);
 	bus_add_attrs(bus);
 
 	pr_debug("bus type '%s' registered\n", bus->name);
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -53,6 +53,7 @@ struct bus_type {
 	struct kset		drivers;
 	struct kset		devices;
 	struct klist		klist_devices;
+	struct klist		klist_drivers;
 
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
@@ -105,6 +106,7 @@ struct device_driver {
 	struct completion	unloaded;
 	struct kobject		kobj;
 	struct list_head	devices;
+	struct klist_node	knode_bus;
 
 	struct module		* owner;
 

