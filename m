Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTIKXBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbTIKXAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 19:00:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:51602 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261589AbTIKW6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:58:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10633211522486@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test5
In-Reply-To: <10633211522265@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 11 Sep 2003 15:59:12 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1285, 2003/09/11 14:27:15-07:00, Matt_Domsch@Dell.com

[PATCH] PCI: make new_id rely on CONFIG_HOTPLUG

> > These either need to be marked __devinit and make "new_id" dependant on
> > CONFIG_HOTPLUG

Patch below moves all the new_id code under CONFIG_HOTPLUG.  Tested
with both CONFIG_HOTPLUG enabled and disabled.  No significant code
changes, merely code moving, and in 2 cases, stub functions added.


 drivers/pci/pci-driver.c |  301 +++++++++++++++++++++++++----------------------
 1 files changed, 162 insertions(+), 139 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu Sep 11 15:54:52 2003
+++ b/drivers/pci/pci-driver.c	Thu Sep 11 15:54:52 2003
@@ -35,6 +35,166 @@
 	return NULL;
 }
 
+/*
+ * Dynamic device IDs are disabled for !CONFIG_HOTPLUG
+ */
+
+#ifdef CONFIG_HOTPLUG
+/**
+ * pci_device_probe_dynamic()
+ *
+ * Walk the dynamic ID list looking for a match.
+ * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
+ */
+static int
+pci_device_probe_dynamic(struct pci_driver *drv, struct pci_dev *pci_dev)
+{
+	int error = -ENODEV;
+	struct list_head *pos;
+	struct dynid *dynid;
+
+	spin_lock(&drv->dynids.lock);
+	list_for_each(pos, &drv->dynids.list) {
+		dynid = list_entry(pos, struct dynid, node);
+		if (pci_match_one_device(&dynid->id, pci_dev)) {
+			spin_unlock(&drv->dynids.lock);
+			error = drv->probe(pci_dev, &dynid->id);
+			if (error >= 0) {
+				pci_dev->driver = drv;
+				return 0;
+			}
+			return error;
+		}
+	}
+	spin_unlock(&drv->dynids.lock);
+	return error;
+}
+static inline void
+dynid_init(struct dynid *dynid)
+{
+	memset(dynid, 0, sizeof(*dynid));
+	INIT_LIST_HEAD(&dynid->node);
+}
+
+/**
+ * store_new_id
+ * @ pdrv
+ * @ buf
+ * @ count
+ *
+ * Adds a new dynamic pci device ID to this driver,
+ * and causes the driver to probe for all devices again.
+ */
+static inline ssize_t
+store_new_id(struct device_driver * driver, const char * buf, size_t count)
+{
+	struct dynid *dynid;
+	struct bus_type * bus;
+	struct pci_driver *pdrv = to_pci_driver(driver);
+	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
+		subdevice=PCI_ANY_ID, class=0, class_mask=0;
+	unsigned long driver_data=0;
+	int fields=0;
+
+	fields = sscanf(buf, "%x %x %x %x %x %x %lux",
+			&vendor, &device, &subvendor, &subdevice,
+			&class, &class_mask, &driver_data);
+	if (fields < 0)
+		return -EINVAL;
+
+	dynid = kmalloc(sizeof(*dynid), GFP_KERNEL);
+	if (!dynid)
+		return -ENOMEM;
+	dynid_init(dynid);
+
+	dynid->id.vendor = vendor;
+	dynid->id.device = device;
+	dynid->id.subvendor = subvendor;
+	dynid->id.subdevice = subdevice;
+	dynid->id.class = class;
+	dynid->id.class_mask = class_mask;
+	dynid->id.driver_data = pdrv->dynids.use_driver_data ?
+		driver_data : 0UL;
+
+	spin_lock(&pdrv->dynids.lock);
+	list_add_tail(&pdrv->dynids.list, &dynid->node);
+	spin_unlock(&pdrv->dynids.lock);
+
+	bus = get_bus(pdrv->driver.bus);
+	if (bus) {
+		if (get_driver(&pdrv->driver)) {
+			down_write(&bus->subsys.rwsem);
+			driver_attach(&pdrv->driver);
+			up_write(&bus->subsys.rwsem);
+			put_driver(&pdrv->driver);
+		}
+		put_bus(bus);
+	}
+
+	return count;
+}
+
+static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
+static inline void
+pci_init_dynids(struct pci_dynids *dynids)
+{
+	memset(dynids, 0, sizeof(*dynids));
+	spin_lock_init(&dynids->lock);
+	INIT_LIST_HEAD(&dynids->list);
+}
+
+static void
+pci_free_dynids(struct pci_driver *drv)
+{
+	struct list_head *pos, *n;
+	struct dynid *dynid;
+
+	spin_lock(&drv->dynids.lock);
+	list_for_each_safe(pos, n, &drv->dynids.list) {
+		dynid = list_entry(pos, struct dynid, node);
+		list_del(&dynid->node);
+		kfree(dynid);
+	}
+	spin_unlock(&drv->dynids.lock);
+}
+
+static int
+pci_create_newid_file(struct pci_driver * drv)
+{
+	int error = 0;
+	if (drv->probe != NULL)
+		error = sysfs_create_file(&drv->driver.kobj,
+					  &driver_attr_new_id.attr);
+	return error;
+}
+
+static int
+pci_bus_match_dynids(const struct pci_dev * pci_dev, const struct pci_driver * pci_drv)
+{
+	struct list_head *pos;
+	struct dynid *dynid;
+
+	spin_lock(&pci_drv->dynids.lock);
+	list_for_each(pos, &pci_drv->dynids.list) {
+		dynid = list_entry(pos, struct dynid, node);
+		if (pci_match_one_device(&dynid->id, pci_dev)) {
+			spin_unlock(&pci_drv->dynids.lock);
+			return 1;
+		}
+	}
+	spin_unlock(&pci_drv->dynids.lock);
+	return 0;
+}
+
+#else /* !CONFIG_HOTPLUG */
+#define pci_device_probe_dynamic(drv,pci_dev) (-ENODEV)
+#define dynid_init(dynid) do {} while (0)
+#define pci_init_dynids(dynids) do {} while (0)
+#define pci_free_dynids(drv) do {} while (0)
+#define pci_create_newid_file(drv) (0)
+#define pci_bus_match_dynids(pci_dev, pci_drv) (0)
+#endif
+
 /**
  * pci_match_device - Tell if a PCI device structure has a matching
  *                    PCI device id structure
@@ -80,36 +240,6 @@
 }
 
 /**
- * pci_device_probe_dynamic()
- * 
- * Walk the dynamic ID list looking for a match.
- * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
- */
-static int
-pci_device_probe_dynamic(struct pci_driver *drv, struct pci_dev *pci_dev)
-{		   
-	int error = -ENODEV;
-	struct list_head *pos;
-	struct dynid *dynid;
-
-	spin_lock(&drv->dynids.lock);
-	list_for_each(pos, &drv->dynids.list) {
-		dynid = list_entry(pos, struct dynid, node);
-		if (pci_match_one_device(&dynid->id, pci_dev)) {
-			spin_unlock(&drv->dynids.lock);
-			error = drv->probe(pci_dev, &dynid->id);
-			if (error >= 0) {
-				pci_dev->driver = drv;
-				return 0;
-			}
-			return error;
-		}
-	}
-	spin_unlock(&drv->dynids.lock);
-	return error;
-}
-
-/**
  * __pci_device_probe()
  * 
  * returns 0  on success, else error.
@@ -178,72 +308,6 @@
 	return 0;
 }
 
-static inline void
-dynid_init(struct dynid *dynid)
-{
-	memset(dynid, 0, sizeof(*dynid));
-	INIT_LIST_HEAD(&dynid->node);
-}
-
-/**
- * store_new_id
- * @ pdrv
- * @ buf
- * @ count
- *
- * Adds a new dynamic pci device ID to this driver,
- * and causes the driver to probe for all devices again.
- */
-static inline ssize_t
-store_new_id(struct device_driver * driver, const char * buf, size_t count)
-{
-	struct dynid *dynid;
-	struct bus_type * bus;
-	struct pci_driver *pdrv = to_pci_driver(driver);
-	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
-		subdevice=PCI_ANY_ID, class=0, class_mask=0;
-	unsigned long driver_data=0;
-	int fields=0;
-
-	fields = sscanf(buf, "%x %x %x %x %x %x %lux",
-			&vendor, &device, &subvendor, &subdevice,
-			&class, &class_mask, &driver_data);
-	if (fields < 0)
-		return -EINVAL;
-
-	dynid = kmalloc(sizeof(*dynid), GFP_KERNEL);
-	if (!dynid)
-		return -ENOMEM;
-	dynid_init(dynid);
-
-	dynid->id.vendor = vendor;
-	dynid->id.device = device;
-	dynid->id.subvendor = subvendor;
-	dynid->id.subdevice = subdevice;
-	dynid->id.class = class;
-	dynid->id.class_mask = class_mask;
-	dynid->id.driver_data = pdrv->dynids.use_driver_data ?
-		driver_data : 0UL;
-
-	spin_lock(&pdrv->dynids.lock);
-	list_add_tail(&pdrv->dynids.list, &dynid->node);
-	spin_unlock(&pdrv->dynids.lock);
-
-	bus = get_bus(pdrv->driver.bus);
-	if (bus) {
-		if (get_driver(&pdrv->driver)) {
-			down_write(&bus->subsys.rwsem);
-			driver_attach(&pdrv->driver);
-			up_write(&bus->subsys.rwsem);
-			put_driver(&pdrv->driver);
-		}
-		put_bus(bus);
-	}
-	
-	return count;
-}
-
-static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
 
 #define kobj_to_pci_driver(obj) container_of(obj, struct device_driver, kobj)
 #define attr_to_driver_attribute(obj) container_of(obj, struct driver_attribute, attr)
@@ -290,38 +354,9 @@
 static int
 pci_populate_driver_dir(struct pci_driver * drv)
 {
-	int error = 0;
-
-	if (drv->probe != NULL)
-		error = sysfs_create_file(&drv->driver.kobj,
-					  &driver_attr_new_id.attr);
-	return error;
+	return pci_create_newid_file(drv);
 }
 
-static inline void
-pci_init_dynids(struct pci_dynids *dynids)
-{
-	memset(dynids, 0, sizeof(*dynids));
-	spin_lock_init(&dynids->lock);
-	INIT_LIST_HEAD(&dynids->list);
-}
-
-static void
-pci_free_dynids(struct pci_driver *drv)
-{
-	struct list_head *pos, *n;
-	struct dynid *dynid;
-
-	spin_lock(&drv->dynids.lock);
-	list_for_each_safe(pos, n, &drv->dynids.list) {
-		dynid = list_entry(pos, struct dynid, node);
-		list_del(&dynid->node);
-		kfree(dynid);
-	}
-	spin_unlock(&drv->dynids.lock);
-}
-
-
 /**
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -411,8 +446,6 @@
 	struct pci_driver * pci_drv = to_pci_driver(drv);
 	const struct pci_device_id * ids = pci_drv->id_table;
 	const struct pci_device_id *found_id;
-	struct list_head *pos;
-	struct dynid *dynid;
 
 	if (!ids)
 		return 0;
@@ -421,17 +454,7 @@
 	if (found_id)
 		return 1;
 
-	spin_lock(&pci_drv->dynids.lock);
-	list_for_each(pos, &pci_drv->dynids.list) {
-		dynid = list_entry(pos, struct dynid, node);
-		if (pci_match_one_device(&dynid->id, pci_dev)) {
-			spin_unlock(&pci_drv->dynids.lock);
-			return 1;
-		}
-	}
-	spin_unlock(&pci_drv->dynids.lock);
-
-	return 0;
+	return pci_bus_match_dynids(pci_dev, pci_drv);
 }
 
 /**

