Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265836AbTIJWSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbTIJWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:18:44 -0400
Received: from smtp9.us.dell.com ([143.166.148.136]:42171 "EHLO
	smtp9.us.dell.com") by vger.kernel.org with ESMTP id S265836AbTIJWSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:18:02 -0400
Date: Wed, 10 Sep 2003 12:17:34 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: rmk@arm.linux.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable
 data
In-Reply-To: <Pine.LNX.4.44.0309100427490.17820-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309101212510.2440-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > These either need to be marked __devinit and make "new_id" dependant on
> > CONFIG_HOTPLUG

Patch below moves all the new_id code under CONFIG_HOTPLUG.  Tested
with both CONFIG_HOTPLUG enabled and disabled.  No significant code
changes, merely code moving, and in 2 cases, stub functions added.

Please review and apply.

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--- linux-2.5/drivers/pci/pci-driver.c	Thu Sep  4 16:36:45 2003
+++ linux-2.5-devinit/drivers/pci/pci-driver.c	Wed Sep 10 10:18:55 2003
@@ -19,7 +19,7 @@
  *                        PCI device id structure
  * @id: single PCI device id structure to match
  * @dev: the PCI device structure to match against
- * 
+ *
  * Returns the matching pci_device_id structure or %NULL if there is no match.
  */
 
@@ -35,6 +35,166 @@ pci_match_one_device(const struct pci_de
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
@@ -80,36 +240,6 @@ pci_device_probe_static(struct pci_drive
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
@@ -178,72 +308,6 @@ static int pci_device_resume(struct devi
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
@@ -290,38 +354,9 @@ static struct kobj_type pci_driver_kobj_
 static int
 pci_populate_driver_dir(struct pci_driver * drv)
 {
-	int error = 0;
-
-	if (drv->probe != NULL)
-		error = sysfs_create_file(&drv->driver.kobj,
-					  &driver_attr_new_id.attr);
-	return error;
-}
-
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
+	return pci_create_newid_file(drv);
 }
 
-
 /**
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -411,8 +446,6 @@ static int pci_bus_match(struct device *
 	struct pci_driver * pci_drv = to_pci_driver(drv);
 	const struct pci_device_id * ids = pci_drv->id_table;
 	const struct pci_device_id *found_id;
-	struct list_head *pos;
-	struct dynid *dynid;
 
 	if (!ids)
 		return 0;
@@ -421,17 +454,7 @@ static int pci_bus_match(struct device *
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

