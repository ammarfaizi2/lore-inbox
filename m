Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbTEVVw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbTEVVwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:52:30 -0400
Received: from granite.he.net ([216.218.226.66]:43787 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263332AbTEVVvD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:51:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10536411604060@kroah.com>
Subject: Re: [PATCH] PCI changes for 2.5.69
In-Reply-To: <10536411603009@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 22 May 2003 15:06:00 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1063.1.4, 2003/05/06 11:15:45-05:00, Matt_Domsch@dell.com

dynids: call driver_attach() when new IDs are added

This causes the driver to create proper device symlinks in sysfs when
new IDs are added and thus new devices found by the driver.

drivers/base/bus.c
    make driver_attach non-static
drivers/pci/pci-driver.c
    delete probe_each_pci_dev, call driver_attach instead.
    Whitespace cleanups.
include/linux/device.h
    add declaration of driver_attach.


 drivers/base/bus.c       |    2 -
 drivers/pci/pci-driver.c |   82 ++++++++++++++++++-----------------------------
 include/linux/device.h   |    1 
 3 files changed, 35 insertions(+), 50 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Thu May 22 14:51:15 2003
+++ b/drivers/base/bus.c	Thu May 22 14:51:15 2003
@@ -316,7 +316,7 @@
  *	Note that we ignore the error from bus_match(), since it's perfectly
  *	valid for a driver not to bind to any devices.
  */
-static void driver_attach(struct device_driver * drv)
+void driver_attach(struct device_driver * drv)
 {
 	struct bus_type * bus = drv->bus;
 	struct list_head * entry;
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu May 22 14:51:15 2003
+++ b/drivers/pci/pci-driver.c	Thu May 22 14:51:15 2003
@@ -15,7 +15,8 @@
  */
 
 /**
- * pci_match_one_device - Tell if a PCI device structure has a matching PCI device id structure
+ * pci_match_one_device - Tell if a PCI device structure has a matching
+ *                        PCI device id structure
  * @id: single PCI device id structure to match
  * @dev: the PCI device structure to match against
  * 
@@ -35,7 +36,8 @@
 }
 
 /**
- * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
+ * pci_match_device - Tell if a PCI device structure has a matching
+ *                    PCI device id structure
  * @ids: array of PCI device id structures to search in
  * @dev: the PCI device structure to match against
  * 
@@ -48,7 +50,7 @@
 {
 	while (ids->vendor || ids->subvendor || ids->class_mask) {
 		if (pci_match_one_device(ids, dev))
-		    return ids;
+			return ids;
 		ids++;
 	}
 	return NULL;
@@ -60,8 +62,7 @@
  * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
  */
 static int
-pci_device_probe_static(struct pci_driver *drv,
-			  struct pci_dev *pci_dev)
+pci_device_probe_static(struct pci_driver *drv, struct pci_dev *pci_dev)
 {		   
 	int error = -ENODEV;
 	const struct pci_device_id *id;
@@ -85,13 +86,12 @@
  * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
  */
 static int
-pci_device_probe_dynamic(struct pci_driver *drv,
-			   struct pci_dev *pci_dev)
+pci_device_probe_dynamic(struct pci_driver *drv, struct pci_dev *pci_dev)
 {		   
 	int error = -ENODEV;
 	struct list_head *pos;
 	struct dynid *dynid;
-	
+
 	spin_lock(&drv->dynids.lock);
 	list_for_each(pos, &drv->dynids.list) {
 		dynid = list_entry(pos, struct dynid, node);
@@ -116,8 +116,7 @@
  * side-effect: pci_dev->driver is set to drv when drv claims pci_dev.
  */
 static int
-__pci_device_probe(struct pci_driver *drv,
-		   struct pci_dev *pci_dev)
+__pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 {		   
 	int error = 0;
 
@@ -188,28 +187,6 @@
 	return 0;
 }
 
-/*
- * If __pci_device_probe() returns 0, it matched at least one previously
- * unclaimed device.  If it returns -ENODEV, it didn't match.  Both are
- * alright in this case, just keep searching for new devices.
- */
-
-static int
-probe_each_pci_dev(struct pci_driver *drv)
-{
-	struct pci_dev *pci_dev=NULL;
-	int error = 0;
-	pci_for_each_dev(pci_dev) {
-		if (get_device(&pci_dev->dev)) {
-			error = __pci_device_probe(drv, pci_dev);
-			put_device(&pci_dev->dev);
-			if (error && error != -ENODEV)
-				return error;
-		}
-	}
-	return error;
-}
-
 static inline void
 dynid_init(struct dynid *dynid)
 {
@@ -230,19 +207,22 @@
 store_new_id(struct device_driver * driver, const char * buf, size_t count)
 {
 	struct dynid *dynid;
+	struct bus_type * bus;
 	struct pci_driver *pdrv = to_pci_driver(driver);
 	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
 		subdevice=PCI_ANY_ID, class=0, class_mask=0;
 	unsigned long driver_data=0;
-	int fields=0, error=0;
+	int fields=0;
 
 	fields = sscanf(buf, "%x %x %x %x %x %x %lux",
 			&vendor, &device, &subvendor, &subdevice,
 			&class, &class_mask, &driver_data);
-	if (fields < 0) return -EINVAL;
+	if (fields < 0)
+		return -EINVAL;
 
 	dynid = kmalloc(sizeof(*dynid), GFP_KERNEL);
-	if (!dynid) return -ENOMEM;
+	if (!dynid)
+		return -ENOMEM;
 	dynid_init(dynid);
 
 	dynid->id.vendor = vendor;
@@ -251,21 +231,24 @@
 	dynid->id.subdevice = subdevice;
 	dynid->id.class = class;
 	dynid->id.class_mask = class_mask;
-	dynid->id.driver_data = pdrv->dynids.use_driver_data ? driver_data : 0UL;
+	dynid->id.driver_data = pdrv->dynids.use_driver_data ?
+		driver_data : 0UL;
 
 	spin_lock(&pdrv->dynids.lock);
 	list_add(&pdrv->dynids.list, &dynid->node);
 	spin_unlock(&pdrv->dynids.lock);
 
-        if (get_driver(&pdrv->driver)) {
-                error = probe_each_pci_dev(pdrv);
-                put_driver(&pdrv->driver);
-        }
-        if (error < 0)
-                return error;
-        return count;
-
-
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
 	return count;
 }
 
@@ -310,7 +293,7 @@
 	.store = pci_driver_attr_store,
 };
 static struct kobj_type pci_driver_kobj_type = {
-	.sysfs_ops     = &pci_driver_sysfs_ops,
+	.sysfs_ops = &pci_driver_sysfs_ops,
 };
 
 static int
@@ -319,7 +302,8 @@
 	int error = 0;
 
 	if (drv->probe != NULL)
-		error = sysfs_create_file(&drv->driver.kobj,&driver_attr_new_id.attr);
+		error = sysfs_create_file(&drv->driver.kobj,
+					  &driver_attr_new_id.attr);
 	return error;
 }
 
@@ -361,7 +345,7 @@
 	if (count >= 0) {
 		pci_populate_driver_dir(drv);
 	}
-		
+
 	return count ? count : 1;
 }
 
@@ -428,7 +412,7 @@
 		return 0;
 
 	found_id = pci_match_device(ids, pci_dev);
-	if (found_id) 
+	if (found_id)
 		return 1;
 
 	spin_lock(&pci_drv->dynids.lock);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu May 22 14:51:15 2003
+++ b/include/linux/device.h	Thu May 22 14:51:15 2003
@@ -318,6 +318,7 @@
  */
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
+extern void driver_attach(struct device_driver * drv);
 
 
 /* driverfs interface for exporting device attributes */

