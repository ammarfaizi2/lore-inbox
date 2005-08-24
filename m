Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVHXDeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVHXDeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 23:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVHXDeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 23:34:09 -0400
Received: from accolon.hansenpartnership.com ([64.109.89.108]:14059 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S932088AbVHXDeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 23:34:08 -0400
Subject: [PATCH] fix klist semantics for lists which have elements removed
	on traversal
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 22:33:51 -0500
Message-Id: <1124854432.5108.30.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that klists claim to provide semantics for safe traversal
of lists which are being modified.  The failure case is when traversal
of a list causes element removal (a fairly common case).  The issue is
that although the list node is refcounted, if it is embedded in an
object (which is universally the case), then the object will be freed
regardless of the klist refcount leading to slab corruption because the
klist iterator refers to the prior element to get the next.

The solution is to make the klist take and release references to the
embedding object meaning that the embedding object won't be released
until the list relinquishes the reference to it.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

Andrew,

Could we look at trying to get this in -mm and possibly into 2.6.13?
There's an existing bug introduced by this problem in module removal of
both of our transport class based fibre drivers which was reported in
July:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112061059829811

Unfortunately, Greg's off for the week, so he might not be able to ack
this.

James


diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -566,6 +566,36 @@ static void bus_remove_attrs(struct bus_
 	}
 }
 
+static void klist_devices_get(struct klist_node *n)
+{
+	struct device *dev = container_of(n, struct device, knode_bus);
+
+	get_device(dev);
+}
+
+static void klist_devices_put(struct klist_node *n)
+{
+	struct device *dev = container_of(n, struct device, knode_bus);
+
+	put_device(dev);
+}
+
+static void klist_drivers_get(struct klist_node *n)
+{
+	struct device_driver *drv = container_of(n, struct device_driver,
+						 knode_bus);
+
+	get_driver(drv);
+}
+
+static void klist_drivers_put(struct klist_node *n)
+{
+	struct device_driver *drv = container_of(n, struct device_driver,
+						 knode_bus);
+
+	put_driver(drv);
+}
+
 /**
  *	bus_register - register a bus with the system.
  *	@bus:	bus.
@@ -600,8 +630,8 @@ int bus_register(struct bus_type * bus)
 	if (retval)
 		goto bus_drivers_fail;
 
-	klist_init(&bus->klist_devices);
-	klist_init(&bus->klist_drivers);
+	klist_init(&bus->klist_devices, klist_devices_get, klist_devices_put);
+	klist_init(&bus->klist_drivers, klist_drivers_get, klist_drivers_put);
 	bus_add_attrs(bus);
 
 	pr_debug("bus type '%s' registered\n", bus->name);
diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -191,6 +191,20 @@ void device_remove_file(struct device * 
 	}
 }
 
+static void klist_children_get(struct klist_node *n)
+{
+	struct device *dev = container_of(n, struct device, knode_parent);
+
+	get_device(dev);
+}
+
+static void klist_children_put(struct klist_node *n)
+{
+	struct device *dev = container_of(n, struct device, knode_parent);
+
+	put_device(dev);
+}
+
 
 /**
  *	device_initialize - init device structure.
@@ -207,7 +221,8 @@ void device_initialize(struct device *de
 {
 	kobj_set_kset_s(dev, devices_subsys);
 	kobject_init(&dev->kobj);
-	klist_init(&dev->klist_children);
+	klist_init(&dev->klist_children, klist_children_get,
+		   klist_children_put);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
 }
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -142,6 +142,19 @@ void put_driver(struct device_driver * d
 	kobject_put(&drv->kobj);
 }
 
+static void klist_devices_get(struct klist_node *n)
+{
+	struct device *dev = container_of(n, struct device, knode_driver);
+
+	get_device(dev);
+}
+
+static void klist_devices_put(struct klist_node *n)
+{
+	struct device *dev = container_of(n, struct device, knode_driver);
+
+	put_device(dev);
+}
 
 /**
  *	driver_register - register driver with bus
@@ -157,7 +170,7 @@ void put_driver(struct device_driver * d
  */
 int driver_register(struct device_driver * drv)
 {
-	klist_init(&drv->klist_devices);
+	klist_init(&drv->klist_devices, klist_devices_get, klist_devices_put);
 	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }
diff --git a/include/linux/klist.h b/include/linux/klist.h
--- a/include/linux/klist.h
+++ b/include/linux/klist.h
@@ -17,15 +17,17 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 
-
+struct klist_node;
 struct klist {
 	spinlock_t		k_lock;
 	struct list_head	k_list;
+	void			(*get)(struct klist_node *);
+	void			(*put)(struct klist_node *);
 };
 
 
-extern void klist_init(struct klist * k);
-
+extern void klist_init(struct klist * k, void (*get)(struct klist_node *),
+		       void (*put)(struct klist_node *));
 
 struct klist_node {
 	struct klist		* n_klist;
diff --git a/lib/klist.c b/lib/klist.c
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -42,12 +42,23 @@
 /**
  *	klist_init - Initialize a klist structure. 
  *	@k:	The klist we're initializing.
+ *	@get:	The get function for the embedding object (NULL if none)
+ *	@put:	The put function for the embedding object (NULL if none)
+ *
+ * Initialises the klist structure.  If the klist_node structures are
+ * going to be embedded in refcounted objects (necessary for safe
+ * deletion) then the get/put arguments are used to initialise
+ * functions that take and release references on the embedding
+ * objects.
  */
 
-void klist_init(struct klist * k)
+void klist_init(struct klist * k, void (*get)(struct klist_node *),
+		void (*put)(struct klist_node *))
 {
 	INIT_LIST_HEAD(&k->k_list);
 	spin_lock_init(&k->k_lock);
+	k->get = get;
+	k->put = put;
 }
 
 EXPORT_SYMBOL_GPL(klist_init);
@@ -74,6 +85,8 @@ static void klist_node_init(struct klist
 	init_completion(&n->n_removed);
 	kref_init(&n->n_ref);
 	n->n_klist = k;
+	if (k->get)
+		k->get(n);
 }
 
 
@@ -110,9 +123,12 @@ EXPORT_SYMBOL_GPL(klist_add_tail);
 static void klist_release(struct kref * kref)
 {
 	struct klist_node * n = container_of(kref, struct klist_node, n_ref);
+	void (*put)(struct klist_node *) = n->n_klist->put;
 	list_del(&n->n_node);
 	complete(&n->n_removed);
 	n->n_klist = NULL;
+	if (put)
+		put(n);
 }
 
 static int klist_dec_and_del(struct klist_node * n)


