Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423048AbWJQLFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423048AbWJQLFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 07:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWJQLFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 07:05:46 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:17911 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423041AbWJQLFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 07:05:25 -0400
Date: Tue, 17 Oct 2006 13:05:59 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Duncan Sands <duncan.sands@math.u-psud.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 3/4] Driver core: Per-subsystem multithreaded probing.
Message-ID: <20061017130559.23f49b29@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Make multithreaded probing work per subsystem instead of per driver.

It doesn't make much sense to probe the same device for multiple drivers in
parallel (after all, only one driver can bind to the device). Instead, create
a probing thread for each device that probes the drivers one after another.
Also make the decision to use multi-threaded probe per bus instead of per
device and adapt the pci code.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/dd.c        |   62 +++++++++++++++++++++++------------------------
 drivers/pci/pci-driver.c |    6 ----
 include/linux/device.h   |    4 +--
 include/linux/pci.h      |    2 -
 4 files changed, 34 insertions(+), 40 deletions(-)

--- linux-2.6.orig/drivers/base/dd.c
+++ linux-2.6/drivers/base/dd.c
@@ -88,17 +88,9 @@ int device_bind_driver(struct device *de
 	return ret;
 }
 
-struct stupid_thread_structure {
-	struct device_driver *drv;
-	struct device *dev;
-};
-
 static atomic_t probe_count = ATOMIC_INIT(0);
-static int really_probe(void *void_data)
+static int really_probe(struct device *dev, struct device_driver *drv)
 {
-	struct stupid_thread_structure *data = void_data;
-	struct device_driver *drv = data->drv;
-	struct device *dev = data->dev;
 	int ret = 0;
 
 	atomic_inc(&probe_count);
@@ -144,7 +136,6 @@ probe_failed:
 	 */
 	ret = 0;
 done:
-	kfree(data);
 	atomic_dec(&probe_count);
 	return ret;
 }
@@ -175,16 +166,14 @@ int driver_probe_done(void)
  * format of the ID structures, nor what is to be considered a match and
  * what is not.
  *
- * This function returns 1 if a match is found, an error if one occurs
- * (that is not -ENODEV or -ENXIO), and 0 otherwise.
+ * This function returns 1 if a match is found, -ENODEV if the device is
+ * not registered, and 0 otherwise.
  *
  * This function must be called with @dev->sem held.  When called for a
  * USB interface, @dev->parent->sem must be held as well.
  */
 int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
-	struct stupid_thread_structure *data;
-	struct task_struct *probe_task;
 	int ret = 0;
 
 	if (!device_is_registered(dev))
@@ -195,19 +184,7 @@ int driver_probe_device(struct device_dr
 	pr_debug("%s: Matched Device %s with Driver %s\n",
 		 drv->bus->name, dev->bus_id, drv->name);
 
-	data = kmalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-	data->drv = drv;
-	data->dev = dev;
-
-	if (drv->multithread_probe) {
-		probe_task = kthread_run(really_probe, data,
-					 "probe-%s", dev->bus_id);
-		if (IS_ERR(probe_task))
-			ret = really_probe(data);
-	} else
-		ret = really_probe(data);
+	ret = really_probe(dev, drv);
 
 done:
 	return ret;
@@ -219,30 +196,53 @@ static int __device_attach(struct device
 	return driver_probe_device(drv, dev);
 }
 
+static int device_probe_drivers(void *data)
+{
+	struct device *dev = data;
+	int ret = 0;
+
+	if (dev->bus) {
+		down(&dev->sem);
+		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
+		up(&dev->sem);
+	}
+	return ret;
+}
+
 /**
  *	device_attach - try to attach device to a driver.
  *	@dev:	device.
  *
  *	Walk the list of drivers that the bus has and call
  *	driver_probe_device() for each pair. If a compatible
- *	pair is found, break out and return.
+ *	pair is found, break out and return. If the bus specifies
+ *	multithreaded probing, walking the list of drivers is done
+ *	on a probing thread.
  *
  *	Returns 1 if the device was bound to a driver;
- *	0 if no matching device was found; error code otherwise.
+ *	0 if no matching device was found or multithreaded probing is done;
+ *	error code otherwise.
  *
  *	When called for a USB interface, @dev->parent->sem must be held.
  */
 int device_attach(struct device * dev)
 {
 	int ret = 0;
+	struct task_struct *probe_task = ERR_PTR(-ENOMEM);
 
 	down(&dev->sem);
 	if (dev->driver) {
 		ret = device_bind_driver(dev);
 		if (ret == 0)
 			ret = 1;
-	} else
-		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
+	} else {
+		if (dev->bus->multithread_probe)
+			probe_task = kthread_run(device_probe_drivers, dev,
+						 "probe-%s", dev->bus_id);
+		if(IS_ERR(probe_task))
+			ret = bus_for_each_drv(dev->bus, NULL, dev,
+					       __device_attach);
+	}
 	up(&dev->sem);
 	return ret;
 }
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -422,11 +422,6 @@ int __pci_register_driver(struct pci_dri
 	drv->driver.owner = owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 
-	if (pci_multithread_probe)
-		drv->driver.multithread_probe = pci_multithread_probe;
-	else
-		drv->driver.multithread_probe = drv->multithread_probe;
-
 	spin_lock_init(&drv->dynids.lock);
 	INIT_LIST_HEAD(&drv->dynids.list);
 
@@ -559,6 +554,7 @@ struct bus_type pci_bus_type = {
 
 static int __init pci_driver_init(void)
 {
+	pci_bus_type.multithread_probe = pci_multithread_probe;
 	return bus_register(&pci_bus_type);
 }
 
--- linux-2.6.orig/include/linux/device.h
+++ linux-2.6/include/linux/device.h
@@ -57,6 +57,8 @@ struct bus_type {
 	int (*suspend_late)(struct device * dev, pm_message_t state);
 	int (*resume_early)(struct device * dev);
 	int (*resume)(struct device * dev);
+
+	unsigned int multithread_probe:1;
 };
 
 extern int __must_check bus_register(struct bus_type * bus);
@@ -106,8 +108,6 @@ struct device_driver {
 	void	(*shutdown)	(struct device * dev);
 	int	(*suspend)	(struct device * dev, pm_message_t state);
 	int	(*resume)	(struct device * dev);
-
-	unsigned int multithread_probe:1;
 };
 
 
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -356,8 +356,6 @@ struct pci_driver {
 	struct pci_error_handlers *err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
-
-	int multithread_probe;
 };
 
 #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
