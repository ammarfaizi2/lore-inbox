Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSHVUrX>; Thu, 22 Aug 2002 16:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSHVUrX>; Thu, 22 Aug 2002 16:47:23 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:50183 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316957AbSHVUqd>;
	Thu, 22 Aug 2002 16:46:33 -0400
Date: Thu, 22 Aug 2002 13:44:57 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>
Subject: [RFC] USB driver conversion to "struct device_driver" for 2.5.31
Message-ID: <20020822204457.GA7532@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 25 Jul 2002 19:37:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's another patch against 2.5.31 + all of the previous USB patches,
that is the next snapshot for converting the USB code to using the core
"struct device_driver" logic.  The patch also includes lots of
drivers/base patches from Pat Mochel that are already in Linus's latest
BK tree, which are necessary for this patch.

Improvements over the last patch is:
	- usb-serial core is converted, now all usb-serial drivers
	  register with the USB core and the usb-serial core.
	- usb-storage driver is converted.  This was easier than I
	  expected, once I added a helper function to the usb core for
	  drivers that care about the interface number they are dealing
	  with.  Note, this is a BIG improvement over the current ifnum
	  code in probe() as now you can get the _correct_ ifnum of an
	  interface (previously the core just incremented the number,
	  which could be incorrect, as some recent audio devices have
	  proven.)
	- other USB core cleanups, removing lots of unused code, and
	  fixing the device tree representation, along with a number of
	  oopses.

Comments are appreciated.

thanks,

greg k-h


diff -Nru a/Documentation/filesystems/driverfs.txt b/Documentation/filesystems/driverfs.txt
--- a/Documentation/filesystems/driverfs.txt	Thu Aug 22 13:39:15 2002
+++ b/Documentation/filesystems/driverfs.txt	Thu Aug 22 13:39:15 2002
@@ -165,9 +165,9 @@
 order to relieve pain in declaring attributes, the subsystem should
 also define a macro, like:
 
-#define DEVICE_ATTR(_name,_str,_mode,_show,_store)      \
+#define DEVICE_ATTR(_name,_mode,_show,_store)      \
 struct device_attribute dev_attr_##_name = {            \
-        .attr = {.name  = _str, .mode   = _mode },      \
+        .attr = {.name  = __stringify(_name) , .mode   = _mode },      \
         .show   = _show,                                \
         .store  = _store,                               \
 };
@@ -252,7 +252,7 @@
 
 Declaring:
 
-BUS_ATTR(_name,_str,_mode,_show,_store)
+BUS_ATTR(_name,_mode,_show,_store)
 
 Creation/Removal:
 
@@ -273,7 +273,7 @@
 
 Declaring:
 
-DRIVER_ATTR(_name,_str,_mode,_show,_store)
+DRIVER_ATTR(_name,_mode,_show,_store)
 
 Creation/Removal:
 
diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	Thu Aug 22 13:39:15 2002
+++ b/drivers/base/base.h	Thu Aug 22 13:39:15 2002
@@ -9,6 +9,8 @@
 extern struct device device_root;
 extern spinlock_t device_lock;
 
+extern struct device * get_device_locked(struct device *);
+
 extern int bus_add_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/base/bus.c	Thu Aug 22 13:39:15 2002
@@ -16,6 +16,9 @@
 
 static LIST_HEAD(bus_driver_list);
 
+#define to_dev(node) container_of(node,struct device,bus_list)
+#define to_drv(node) container_of(node,struct device_driver,bus_list)
+
 /**
  * bus_for_each_dev - walk list of devices and do something to each
  * @bus:	bus in question
@@ -26,42 +29,41 @@
  * counting on devices as we touch each one.
  *
  * Algorithm:
- * Take the bus lock and get the first node in the list. We increment
- * the reference count and unlock the bus. If we have a device from a 
- * previous iteration, we decrement the reference count. 
- * After we call the callback, we get the next node in the list and loop.
- * At the end, if @dev is not null, we still have it pinned, so we need
- * to let it go.
+ * Take device_lock and get the first node in the list. 
+ * Try and increment the reference count on it. If we can't, it's in the
+ * process of being removed, but that process hasn't acquired device_lock.
+ * It's still in the list, so we grab the next node and try that one. 
+ * We drop the lock to call the callback.
+ * We can't decrement the reference count yet, because we need the next
+ * node in the list. So, we set @prev to point to the current device.
+ * On the next go-round, we decrement the reference count on @prev, so if 
+ * it's being removed, it won't affect us.
  */
 int bus_for_each_dev(struct bus_type * bus, void * data, 
 		     int (*callback)(struct device * dev, void * data))
 {
-	struct device * next;
-	struct device * dev = NULL;
 	struct list_head * node;
+	struct device * prev = NULL;
 	int error = 0;
 
 	get_bus(bus);
-	read_lock(&bus->lock);
-	node = bus->devices.next;
-	while (node != &bus->devices) {
-		next = list_entry(node,struct device,bus_list);
-		get_device(next);
-		read_unlock(&bus->lock);
-
-		if (dev)
-			put_device(dev);
-		dev = next;
-		if ((error = callback(dev,data))) {
-			put_device(dev);
-			break;
+	spin_lock(&device_lock);
+	list_for_each(node,&bus->devices) {
+		struct device * dev = get_device_locked(to_dev(node));
+		if (dev) {
+			spin_unlock(&device_lock);
+			error = callback(dev,data);
+			if (prev)
+				put_device(prev);
+			prev = dev;
+			spin_lock(&device_lock);
+			if (error)
+				break;
 		}
-		read_lock(&bus->lock);
-		node = dev->bus_list.next;
 	}
-	read_unlock(&bus->lock);
-	if (dev)
-		put_device(dev);
+	spin_unlock(&device_lock);
+	if (prev)
+		put_device(prev);
 	put_bus(bus);
 	return error;
 }
@@ -69,34 +71,30 @@
 int bus_for_each_drv(struct bus_type * bus, void * data,
 		     int (*callback)(struct device_driver * drv, void * data))
 {
-	struct device_driver * next;
-	struct device_driver * drv = NULL;
 	struct list_head * node;
+	struct device_driver * prev = NULL;
 	int error = 0;
 
 	/* pin bus in memory */
 	get_bus(bus);
 
-	read_lock(&bus->lock);
-	node = bus->drivers.next;
-	while (node != &bus->drivers) {
-		next = list_entry(node,struct device_driver,bus_list);
-		get_driver(next);
-		read_unlock(&bus->lock);
-
-		if (drv)
-			put_driver(drv);
-		drv = next;
-		if ((error = callback(drv,data))) {
-			put_driver(drv);
-			break;
+	spin_lock(&device_lock);
+	list_for_each(node,&bus->drivers) {
+		struct device_driver * drv = get_driver(to_drv(node));
+		if (drv) {
+			spin_unlock(&device_lock);
+			error = callback(drv,data);
+			if (prev)
+				put_driver(prev);
+			prev = drv;
+			spin_lock(&device_lock);
+			if (error)
+				break;
 		}
-		read_lock(&bus->lock);
-		node = drv->bus_list.next;
 	}
-	read_unlock(&bus->lock);
-	if (drv)
-		put_driver(drv);
+	spin_unlock(&device_lock);
+	if (prev)
+		put_driver(prev);
 	put_bus(bus);
 	return error;
 }
@@ -115,9 +113,9 @@
 	if (dev->bus) {
 		pr_debug("registering %s with bus '%s'\n",dev->bus_id,dev->bus->name);
 		get_bus(dev->bus);
-		write_lock(&dev->bus->lock);
+		spin_lock(&device_lock);
 		list_add_tail(&dev->bus_list,&dev->bus->devices);
-		write_unlock(&dev->bus->lock);
+		spin_unlock(&device_lock);
 		device_bus_link(dev);
 	}
 	return 0;
@@ -134,9 +132,6 @@
 {
 	if (dev->bus) {
 		device_remove_symlink(&dev->bus->device_dir,dev->bus_id);
-		write_lock(&dev->bus->lock);
-		list_del_init(&dev->bus_list);
-		write_unlock(&dev->bus->lock);
 		put_bus(dev->bus);
 	}
 }
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/base/core.c	Thu Aug 22 13:39:15 2002
@@ -25,6 +25,8 @@
 
 spinlock_t device_lock = SPIN_LOCK_UNLOCKED;
 
+#define to_dev(node) container_of(node,struct device,driver_list)
+
 
 /**
  * found_match - do actual binding of device to driver
@@ -53,9 +55,9 @@
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id,drv->name);
 
-	write_lock(&drv->lock);
+	spin_lock(&device_lock);
 	list_add_tail(&dev->driver_list,&drv->devices);
-	write_unlock(&drv->lock);
+	spin_unlock(&device_lock);
 	
 	goto Done;
 
@@ -101,19 +103,14 @@
 	struct device_driver * drv; 
 
 	if (dev->driver) {
-		lock_device(dev);
+		spin_lock(&device_lock);
 		drv = dev->driver;
 		dev->driver = NULL;
-		unlock_device(dev);
-
-		write_lock(&drv->lock);
-		list_del_init(&dev->driver_list);
-		write_unlock(&drv->lock);
+		spin_unlock(&device_lock);
 
 		/* detach from driver */
-		if (drv->remove)
+		if (drv && drv->remove)
 			drv->remove(dev);
-		put_driver(drv);
 	}
 }
 
@@ -134,47 +131,26 @@
 	return bus_for_each_dev(drv->bus,drv,do_driver_attach);
 }
 
-static int do_driver_detach(struct device * dev, struct device_driver * drv)
-{
-	lock_device(dev);
-	if (dev->driver == drv) {
-		dev->driver = NULL;
-		unlock_device(dev);
-		if (drv->remove)
-			drv->remove(dev);
-	} else
-		unlock_device(dev);
-	return 0;
-}
-
 void driver_detach(struct device_driver * drv)
 {
-	struct device * next;
-	struct device * dev = NULL;
 	struct list_head * node;
-	int error = 0;
+	struct device * prev = NULL;
 
-	write_lock(&drv->lock);
-	node = drv->devices.next;
-	while (node != &drv->devices) {
-		next = list_entry(node,struct device,driver_list);
-		get_device(next);
-		list_del_init(&next->driver_list);
-		write_unlock(&drv->lock);
-
-		if (dev)
-			put_device(dev);
-		dev = next;
-		if ((error = do_driver_detach(dev,drv))) {
-			put_device(dev);
-			break;
+	spin_lock(&device_lock);
+	list_for_each(node,&drv->devices) {
+		struct device * dev = get_device_locked(to_dev(node));
+		if (dev) {
+			if (prev)
+				list_del_init(&prev->driver_list);
+			spin_unlock(&device_lock);
+			device_detach(dev);
+			if (prev)
+				put_device(prev);
+			prev = dev;
+			spin_lock(&device_lock);
 		}
-		write_lock(&drv->lock);
-		node = drv->devices.next;
 	}
-	write_unlock(&drv->lock);
-	if (dev)
-		put_device(dev);
+	spin_unlock(&device_lock);
 }
 
 /**
@@ -191,7 +167,6 @@
 int device_register(struct device *dev)
 {
 	int error;
-	struct device *prev_dev;
 
 	if (!dev || !strlen(dev->bus_id))
 		return -EINVAL;
@@ -199,24 +174,21 @@
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
 	INIT_LIST_HEAD(&dev->g_list);
+	INIT_LIST_HEAD(&dev->driver_list);
+	INIT_LIST_HEAD(&dev->bus_list);
 	spin_lock_init(&dev->lock);
 	atomic_set(&dev->refcount,2);
 
-	spin_lock(&device_lock);
 	if (dev != &device_root) {
 		if (!dev->parent)
 			dev->parent = &device_root;
 		get_device(dev->parent);
 
-		if (list_empty(&dev->parent->children))
-			prev_dev = dev->parent;
-		else
-			prev_dev = list_entry(dev->parent->children.prev, struct device, node);
-		list_add(&dev->g_list, &prev_dev->g_list);
-
+		spin_lock(&device_lock);
+		list_add_tail(&dev->g_list,&dev->parent->g_list);
 		list_add_tail(&dev->node,&dev->parent->children);
+		spin_unlock(&device_lock);
 	}
-	spin_unlock(&device_lock);
 
 	pr_debug("DEV: registering device: ID = '%s', name = %s\n",
 		 dev->bus_id, dev->name);
@@ -234,12 +206,37 @@
 		platform_notify(dev);
 
  register_done:
+	if (error) {
+		spin_lock(&device_lock);
+		list_del_init(&dev->g_list);
+		list_del_init(&dev->node);
+		spin_unlock(&device_lock);
+		if (dev->parent)
+			put_device(dev->parent);
+	}
 	put_device(dev);
-	if (error && dev->parent)
-		put_device(dev->parent);
 	return error;
 }
 
+struct device * get_device_locked(struct device * dev)
+{
+	struct device * ret = dev;
+	if (dev && atomic_read(&dev->refcount) > 0)
+		atomic_inc(&dev->refcount);
+	else
+		ret = NULL;
+	return ret;
+}
+
+struct device * get_device(struct device * dev)
+{
+	struct device * ret;
+	spin_lock(&device_lock);
+	ret = get_device_locked(dev);
+	spin_unlock(&device_lock);
+	return ret;
+}
+
 /**
  * put_device - decrement reference count, and clean up when it hits 0
  * @dev:	device in question
@@ -250,6 +247,8 @@
 		return;
 	list_del_init(&dev->node);
 	list_del_init(&dev->g_list);
+	list_del_init(&dev->bus_list);
+	list_del_init(&dev->driver_list);
 	spin_unlock(&device_lock);
 
 	pr_debug("DEV: Unregistering device. ID = '%s', name = '%s'\n",
@@ -296,4 +295,5 @@
 core_initcall(device_init);
 
 EXPORT_SYMBOL(device_register);
+EXPORT_SYMBOL(get_device);
 EXPORT_SYMBOL(put_device);
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/base/driver.c	Thu Aug 22 13:39:15 2002
@@ -10,35 +10,31 @@
 #include <linux/errno.h>
 #include "base.h"
 
+#define to_dev(node) container_of(node,struct device,driver_list)
 
-int driver_for_each_dev(struct device_driver * drv, void * data, int (*callback)(struct device *, void * ))
+int driver_for_each_dev(struct device_driver * drv, void * data, 
+			int (*callback)(struct device *, void * ))
 {
-	struct device * next;
-	struct device * dev = NULL;
 	struct list_head * node;
+	struct device * prev = NULL;
 	int error = 0;
 
 	get_driver(drv);
-	read_lock(&drv->lock);
-	node = drv->devices.next;
-	while (node != &drv->devices) {
-		next = list_entry(node,struct device,driver_list);
-		get_device(next);
-		read_unlock(&drv->lock);
-
-		if (dev)
-			put_device(dev);
-		dev = next;
-		if ((error = callback(dev,data))) {
-			put_device(dev);
-			break;
+	spin_lock(&device_lock);
+	list_for_each(node,&drv->devices) {
+		struct device * dev = get_device_locked(to_dev(node));
+		if (dev) {
+			spin_unlock(&device_lock);
+			error = callback(dev,data);
+			if (prev)
+				put_device(prev);
+			prev = dev;
+			spin_lock(&device_lock);
+			if (error)
+				break;
 		}
-		read_lock(&drv->lock);
-		node = dev->driver_list.next;
 	}
-	read_unlock(&drv->lock);
-	if (dev)
-		put_device(dev);
+	spin_unlock(&device_lock);
 	put_driver(drv);
 	return error;
 }
@@ -60,9 +56,9 @@
 	atomic_set(&drv->refcount,2);
 	rwlock_init(&drv->lock);
 	INIT_LIST_HEAD(&drv->devices);
-	write_lock(&drv->bus->lock);
+	spin_lock(&device_lock);
 	list_add(&drv->bus_list,&drv->bus->drivers);
-	write_unlock(&drv->bus->lock);
+	spin_unlock(&device_lock);
 	driver_make_dir(drv);
 	driver_attach(drv);
 	put_driver(drv);
@@ -81,10 +77,10 @@
 
 void remove_driver(struct device_driver * drv)
 {
-	write_lock(&drv->bus->lock);
+	spin_lock(&device_lock);
 	atomic_set(&drv->refcount,0);
 	list_del_init(&drv->bus_list);
-	write_unlock(&drv->bus->lock);
+	spin_unlock(&device_lock);
 	__remove_driver(drv);
 }
 
@@ -94,13 +90,10 @@
  */
 void put_driver(struct device_driver * drv)
 {
-	write_lock(&drv->bus->lock);
-	if (!atomic_dec_and_test(&drv->refcount)) {
-		write_unlock(&drv->bus->lock);
+	if (!atomic_dec_and_lock(&drv->refcount,&device_lock))
 		return;
-	}
 	list_del_init(&drv->bus_list);
-	write_unlock(&drv->bus->lock);
+	spin_unlock(&device_lock);
 	__remove_driver(drv);
 }
 
diff -Nru a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/base/interface.c	Thu Aug 22 13:39:15 2002
@@ -14,7 +14,7 @@
 	return off ? 0 : sprintf(buf,"%s\n",dev->name);
 }
 
-static DEVICE_ATTR(name,"name",S_IRUGO,device_read_name,NULL);
+static DEVICE_ATTR(name,S_IRUGO,device_read_name,NULL);
 
 static ssize_t
 device_read_power(struct device * dev, char * page, size_t count, loff_t off)
@@ -85,7 +85,7 @@
 	return error < 0 ? error : count;
 }
 
-static DEVICE_ATTR(power,"power",S_IWUSR | S_IRUGO,
+static DEVICE_ATTR(power,S_IWUSR | S_IRUGO,
 		   device_read_power,device_write_power);
 
 struct device_attribute * device_default_files[] = {
diff -Nru a/drivers/base/power.c b/drivers/base/power.c
--- a/drivers/base/power.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/base/power.c	Thu Aug 22 13:39:15 2002
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include "base.h"
 
+#define to_dev(node) container_of(node,struct device,g_list)
+
 /**
  * device_suspend - suspend all devices on the device tree
  * @state:	state we're entering
@@ -25,30 +27,26 @@
  */
 int device_suspend(u32 state, u32 level)
 {
-	struct device * dev;
-	struct device * prev = &device_root;
+	struct list_head * node;
+	struct device * prev = NULL;
 	int error = 0;
 
 	printk(KERN_EMERG "Suspending Devices\n");
 
-	get_device(prev);
-
 	spin_lock(&device_lock);
-	dev = g_list_to_dev(prev->g_list.next);
-	while(dev != &device_root && !error) {
-		get_device(dev);
-		spin_unlock(&device_lock);
-		put_device(prev);
-
-		if (dev->driver && dev->driver->suspend)
-			error = dev->driver->suspend(dev,state,level);
-
-		spin_lock(&device_lock);
-		prev = dev;
-		dev = g_list_to_dev(prev->g_list.next);
+	list_for_each(node,&device_root.g_list) {
+		struct device * dev = get_device_locked(dev);
+		if (dev) {
+			spin_unlock(&device_lock);
+			if (dev->driver && dev->driver->suspend)
+				error = dev->driver->suspend(dev,state,level);
+			if (prev)
+				put_device(prev);
+			prev = dev;
+			spin_lock(&device_lock);
+		}
 	}
 	spin_unlock(&device_lock);
-	put_device(prev);
 
 	return error;
 }
@@ -63,27 +61,23 @@
  */
 void device_resume(u32 level)
 {
-	struct device * dev;
-	struct device * prev = &device_root;
-
-	get_device(prev);
+	struct list_head * node;
+	struct device * prev = NULL;
 
 	spin_lock(&device_lock);
-	dev = g_list_to_dev(prev->g_list.prev);
-	while(dev != &device_root) {
-		get_device(dev);
-		spin_unlock(&device_lock);
-		put_device(prev);
-
-		if (dev->driver && dev->driver->resume)
-			dev->driver->resume(dev,level);
-
-		spin_lock(&device_lock);
-		prev = dev;
-		dev = g_list_to_dev(prev->g_list.prev);
+	list_for_each_prev(node,&device_root.g_list) {
+		struct device * dev = get_device_locked(to_dev(node));
+		if (dev) {
+			spin_unlock(&device_lock);
+			if (dev->driver && dev->driver->resume)
+				dev->driver->resume(dev,level);
+			if (prev)
+				put_device(prev);
+			prev = dev;
+			spin_lock(&device_lock);
+		}
 	}
 	spin_unlock(&device_lock);
-	put_device(prev);
 
 	printk(KERN_EMERG "Devices Resumed\n");
 }
@@ -98,29 +92,25 @@
  */
 void device_shutdown(void)
 {
-	struct device * dev;
-	struct device * prev = &device_root;
+	struct list_head * node;
+	struct device * prev = NULL;
 
 	printk(KERN_EMERG "Shutting down devices\n");
 
-	get_device(prev);
-
 	spin_lock(&device_lock);
-	dev = g_list_to_dev(prev->g_list.next);
-	while(dev != &device_root) {
-		get_device(dev);
-		spin_unlock(&device_lock);
-		put_device(prev);
-
-		if (dev->driver && dev->driver->remove)
-			dev->driver->remove(dev);
-
-		spin_lock(&device_lock);
-		prev = dev;
-		dev = g_list_to_dev(prev->g_list.next);
+	list_for_each(node,&device_root.g_list) {
+		struct device * dev = get_device_locked(to_dev(node));
+		if (dev) {
+			spin_unlock(&device_lock);
+			if (dev->driver && dev->driver->remove)
+				dev->driver->remove(dev);
+			if (prev)
+				put_device(prev);
+			prev = dev;
+			spin_lock(&device_lock);
+		}
 	}
 	spin_unlock(&device_lock);
-	put_device(prev);
 }
 
 EXPORT_SYMBOL(device_suspend);
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/pci/proc.c	Thu Aug 22 13:39:15 2002
@@ -378,7 +378,7 @@
 	return off ? 0 : sprintf(buf,"%u\n",pci_dev->irq);
 }
 
-static DEVICE_ATTR(irq,"irq",S_IRUGO,pci_show_irq,NULL);
+static DEVICE_ATTR(irq,S_IRUGO,pci_show_irq,NULL);
 
 static ssize_t pci_show_resources(struct device * dev, char * buf, size_t count, loff_t off)
 {
@@ -402,7 +402,7 @@
 	return (str - buf);
 }
 
-static DEVICE_ATTR(resource,"resource",S_IRUGO,pci_show_resources,NULL);
+static DEVICE_ATTR(resource,S_IRUGO,pci_show_resources,NULL);
 
 int pci_proc_attach_device(struct pci_dev *dev)
 {
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/scsi/scsi_scan.c	Thu Aug 22 13:39:15 2002
@@ -305,7 +305,7 @@
 
 	return 0;
 }
-static DEVICE_ATTR(type,"type",S_IRUGO,scsi_device_type_read,NULL);
+static DEVICE_ATTR(type,S_IRUGO,scsi_device_type_read,NULL);
 
 /* end content handlers */
 
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/scsi/sg.c	Thu Aug 22 13:39:15 2002
@@ -1401,14 +1401,14 @@
 	Sg_device * sdp=list_entry(driverfs_dev, Sg_device, sg_driverfs_dev);
 	return off ? 0 : sprintf(page, "%x\n",sdp->i_rdev.value);
 }
-static DEVICE_ATTR(kdev,"kdev",S_IRUGO,sg_device_kdev_read,NULL);
+static DEVICE_ATTR(kdev,S_IRUGO,sg_device_kdev_read,NULL);
 
 static ssize_t sg_device_type_read(struct device *driverfs_dev, char *page, 
 		size_t count, loff_t off) 
 {
 	return off ? 0 : sprintf (page, "CHR\n");
 }
-static DEVICE_ATTR(type,"type",S_IRUGO,sg_device_type_read,NULL);
+static DEVICE_ATTR(type,S_IRUGO,sg_device_type_read,NULL);
 
 static int sg_attach(Scsi_Device * scsidp)
 {
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/scsi/sr.c	Thu Aug 22 13:39:15 2002
@@ -737,14 +737,14 @@
 	kdev.value=(int)driverfs_dev->driver_data;
 	return off ? 0 : sprintf(page, "%x\n",kdev.value);
 }
-static DEVICE_ATTR(kdev,"kdev",S_IRUGO,sr_device_kdev_read,NULL);
+static DEVICE_ATTR(kdev,S_IRUGO,sr_device_kdev_read,NULL);
 
 static ssize_t sr_device_type_read(struct device *driverfs_dev, 
 				   char *page, size_t count, loff_t off) 
 {
 	return off ? 0 : sprintf (page, "CHR\n");
 }
-static DEVICE_ATTR(type,"type",S_IRUGO,sr_device_type_read,NULL);
+static DEVICE_ATTR(type,S_IRUGO,sr_device_type_read,NULL);
 
 
 void sr_finish()
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/scsi/st.c	Thu Aug 22 13:39:15 2002
@@ -3533,14 +3533,14 @@
 	kdev.value=(int)driverfs_dev->driver_data;
 	return off ? 0 : sprintf(page, "%x\n",kdev.value);
 }
-static DEVICE_ATTR(kdev,"kdev",S_IRUGO,st_device_kdev_read,NULL);
+static DEVICE_ATTR(kdev,S_IRUGO,st_device_kdev_read,NULL);
 
 static ssize_t st_device_type_read(struct device *driverfs_dev, 
 				   char *page, size_t count, loff_t off) 
 {
 	return off ? 0 : sprintf (page, "CHR\n");
 }
-static DEVICE_ATTR(type,"type",S_IRUGO,st_device_type_read,NULL);
+static DEVICE_ATTR(type,S_IRUGO,st_device_type_read,NULL);
 
 
 static struct file_operations st_fops =
diff -Nru a/drivers/usb/class/audio.c b/drivers/usb/class/audio.c
--- a/drivers/usb/class/audio.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/class/audio.c	Thu Aug 22 13:39:15 2002
@@ -2756,7 +2756,6 @@
 	.name =		"audio",
 	.probe =	usb_audio_probe,
 	.disconnect =	usb_audio_disconnect,
-	.driver_list =	LIST_HEAD_INIT(usb_audio_driver.driver_list), 
 	.id_table =	usb_audio_ids,
 };
 
diff -Nru a/drivers/usb/class/usb-midi.c b/drivers/usb/class/usb-midi.c
--- a/drivers/usb/class/usb-midi.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/class/usb-midi.c	Thu Aug 22 13:39:15 2002
@@ -2099,7 +2099,6 @@
 	.probe = usb_midi_probe,
 	.disconnect = usb_midi_disconnect,
 	.id_table =	NULL, 			/* check all devices */
-	.driver_list = LIST_HEAD_INIT(usb_midi_driver.driver_list)
 };
 
 /* ------------------------------------------------------------------------- */
diff -Nru a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
--- a/drivers/usb/core/devices.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/core/devices.c	Thu Aug 22 13:39:15 2002
@@ -111,7 +111,6 @@
 
 /*
  * Need access to the driver and USB bus lists.
- * extern struct list_head usb_driver_list;
  * extern struct list_head usb_bus_list;
  * However, these will come from functions that return ptrs to each of them.
  */
diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/core/devio.c	Thu Aug 22 13:39:15 2002
@@ -427,30 +427,6 @@
 	return -ENOENT; 
 }
 
-extern struct list_head usb_driver_list;
-
-#if 0
-static int finddriver(struct usb_driver **driver, char *name)
-{
-	struct list_head *tmp;
-
-	tmp = usb_driver_list.next;
-	while (tmp != &usb_driver_list) {
-		struct usb_driver *d = list_entry(tmp, struct usb_driver,
-							driver_list);
-
-		if (!strcmp(d->name, name)) {
-			*driver = d;
-			return 0;
-		}
-
-		tmp = tmp->next;
-	}
-
-	return -EINVAL;
-}
-#endif
-
 static int check_ctrlrecip(struct dev_state *ps, unsigned int requesttype, unsigned int index)
 {
 	int ret;
@@ -1105,7 +1081,9 @@
 
 	/* let kernel drivers try to (re)bind to the interface */
 	case USBDEVFS_CONNECT:
-		usb_find_interface_driver (ps->dev, ifp);
+		//usb_find_interface_driver (ps->dev, ifp);
+		err ("USBDEVFS_CONNECT is no longer supported.");
+		retval = -EINVAL;
 		break;
 
        /* talk directly to the interface's driver */
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/core/hcd.c	Thu Aug 22 13:39:15 2002
@@ -722,13 +722,15 @@
 {
 	int retval;
 
-	usb_dev->dev.parent = parent_dev;
-	strcpy (&usb_dev->dev.name[0], "usb_name");
-	strcpy (&usb_dev->dev.bus_id[0], "usb_bus");
-	retval = usb_new_device (usb_dev);
+//	usb_dev->dev.parent = parent_dev;
+//	strcpy (&usb_dev->dev.name[0], "usb_name");
+//	strcpy (&usb_dev->dev.bus_id[0], "usb_bus");
+	retval = usb_new_device (usb_dev, parent_dev);
 	if (retval)
-		put_device (&usb_dev->dev);
+		err("%s - usb_new_device failed with value %d", __FUNCTION__, retval);
+//		put_device (&usb_dev->dev);
 	return retval;
+//	return usb_new_device (usb_dev, parent_dev);
 }
 EXPORT_SYMBOL (usb_register_root_hub);
 
diff -Nru a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
--- a/drivers/usb/core/hcd.h	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/core/hcd.h	Thu Aug 22 13:39:15 2002
@@ -255,7 +255,7 @@
 /* -------------------------------------------------------------------------- */
 
 /* Enumeration is only for the hub driver, or HCD virtual root hubs */
-extern int usb_new_device(struct usb_device *dev);
+extern int usb_new_device(struct usb_device *dev, struct device *parent);
 extern void usb_connect(struct usb_device *dev);
 extern void usb_disconnect(struct usb_device **);
 
@@ -384,8 +384,6 @@
 /* for probe/disconnect with correct module usage counting */
 void *usb_bind_driver(struct usb_driver *driver, struct usb_interface *intf);
 void usb_unbind_driver(struct usb_device *device, struct usb_interface *intf);
-
-extern struct list_head usb_driver_list;
 
 /*
  * USB device fs stuff
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/core/hub.c	Thu Aug 22 13:39:15 2002
@@ -175,6 +175,7 @@
 	while (!list_empty (&hub->tt.clear_list)) {
 		struct list_head	*temp;
 		struct usb_tt_clear	*clear;
+		struct usb_device	*dev;
 		int			status;
 
 		temp = hub->tt.clear_list.next;
@@ -183,13 +184,13 @@
 
 		/* drop lock so HCD can concurrently report other TT errors */
 		spin_unlock_irqrestore (&hub->tt.lock, flags);
-		status = hub_clear_tt_buffer (hub->dev,
-				clear->devinfo, clear->tt);
+		dev = interface_to_usbdev (hub->intf);
+		status = hub_clear_tt_buffer (dev, clear->devinfo, clear->tt);
 		spin_lock_irqsave (&hub->tt.lock, flags);
 
 		if (status)
 			err ("usb-%s-%s clear tt %d (%04x) error %d",
-				hub->dev->bus->bus_name, hub->dev->devpath,
+				dev->bus->bus_name, dev->devpath,
 				clear->tt, clear->devinfo, status);
 		kfree (clear);
 	}
@@ -245,12 +246,14 @@
 
 static void usb_hub_power_on(struct usb_hub *hub)
 {
+	struct usb_device *dev;
 	int i;
 
 	/* Enable power to the ports */
 	dbg("enabling power on all ports");
+	dev = interface_to_usbdev(hub->intf);
 	for (i = 0; i < hub->descriptor->bNbrPorts; i++)
-		usb_set_port_feature(hub->dev, i + 1, USB_PORT_FEAT_POWER);
+		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
 
 	/* Wait for power to be enabled */
 	wait_ms(hub->descriptor->bPwrOn2PwrGood * 2);
@@ -259,7 +262,7 @@
 static int usb_hub_configure(struct usb_hub *hub,
 	struct usb_endpoint_descriptor *endpoint)
 {
-	struct usb_device *dev = hub->dev;
+	struct usb_device *dev = interface_to_usbdev (hub->intf);
 	struct usb_hub_status hubstatus;
 	unsigned int pipe;
 	int maxp, ret;
@@ -425,39 +428,78 @@
 	return 0;
 }
 
-static void *hub_probe(struct usb_device *dev, unsigned int i,
-		       const struct usb_device_id *id)
+static void hub_disconnect(struct usb_interface *intf)
 {
-	struct usb_interface_descriptor *interface;
+	struct usb_hub *hub = (struct usb_hub *)intf->dev.driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hub_event_lock, flags);
+
+	/* Delete it and then reset it */
+	list_del(&hub->event_list);
+	INIT_LIST_HEAD(&hub->event_list);
+	list_del(&hub->hub_list);
+	INIT_LIST_HEAD(&hub->hub_list);
+
+	spin_unlock_irqrestore(&hub_event_lock, flags);
+
+	down(&hub->khubd_sem); /* Wait for khubd to leave this hub alone. */
+	up(&hub->khubd_sem);
+
+	/* assuming we used keventd, it must quiesce too */
+	if (hub->tt.hub)
+		flush_scheduled_tasks ();
+
+	if (hub->urb) {
+		usb_unlink_urb(hub->urb);
+		usb_free_urb(hub->urb);
+		hub->urb = NULL;
+	}
+
+	if (hub->descriptor) {
+		kfree(hub->descriptor);
+		hub->descriptor = NULL;
+	}
+
+	/* Free the memory */
+	kfree(hub);
+	intf->dev.driver_data = NULL;
+}
+
+static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	struct usb_interface_descriptor *desc;
 	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device *dev;
 	struct usb_hub *hub;
 	unsigned long flags;
 
-	interface = &dev->actconfig->interface[i].altsetting[0];
+	desc = intf->altsetting + intf->act_altsetting;
+	dev = interface_to_usbdev(intf);
 
 	/* Some hubs have a subclass of 1, which AFAICT according to the */
 	/*  specs is not defined, but it works */
-	if ((interface->bInterfaceSubClass != 0) &&
-	    (interface->bInterfaceSubClass != 1)) {
+	if ((desc->bInterfaceSubClass != 0) &&
+	    (desc->bInterfaceSubClass != 1)) {
 		err("invalid subclass (%d) for USB hub device #%d",
-			interface->bInterfaceSubClass, dev->devnum);
-		return NULL;
+			desc->bInterfaceSubClass, dev->devnum);
+		return -EIO;
 	}
 
 	/* Multiple endpoints? What kind of mutant ninja-hub is this? */
-	if (interface->bNumEndpoints != 1) {
+	if (desc->bNumEndpoints != 1) {
 		err("invalid bNumEndpoints (%d) for USB hub device #%d",
-			interface->bNumEndpoints, dev->devnum);
-		return NULL;
+			desc->bNumEndpoints, dev->devnum);
+		return -EIO;
 	}
 
-	endpoint = &interface->endpoint[0];
+	endpoint = &desc->endpoint[0];
 
 	/* Output endpoint? Curiousier and curiousier.. */
 	if (!(endpoint->bEndpointAddress & USB_DIR_IN)) {
 		err("Device #%d is hub class, but has output endpoint?",
 			dev->devnum);
-		return NULL;
+		return -EIO;
 	}
 
 	/* If it's not an interrupt endpoint, we'd better punt! */
@@ -465,7 +507,7 @@
 			!= USB_ENDPOINT_XFER_INT) {
 		err("Device #%d is hub class, but endpoint is not interrupt?",
 			dev->devnum);
-		return NULL;
+		return -EIO;
 	}
 
 	/* We found a hub */
@@ -474,13 +516,13 @@
 	hub = kmalloc(sizeof(*hub), GFP_KERNEL);
 	if (!hub) {
 		err("couldn't kmalloc hub struct");
-		return NULL;
+		return -ENOMEM;
 	}
 
 	memset(hub, 0, sizeof(*hub));
 
 	INIT_LIST_HEAD(&hub->event_list);
-	hub->dev = dev;
+	hub->intf = intf;
 	init_MUTEX(&hub->khubd_sem);
 
 	/* Record the new hub's existence */
@@ -489,14 +531,18 @@
 	list_add(&hub->hub_list, &hub_list);
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
+	intf->dev.driver_data = hub;
+
 	if (usb_hub_configure(hub, endpoint) >= 0) {
-		strcpy (dev->actconfig->interface[i].dev.name,
-			"Hub/Port Status Changes");
-		return hub;
+		strcpy (intf->dev.name, "Hub/Port Status Changes");
+		return 0;
 	}
 
 	err("hub configuration failed for device at %s", dev->devpath);
 
+	hub_disconnect (intf);
+	return -ENODEV;
+#if 0
 	/* free hub, but first clean up its list. */
 	spin_lock_irqsave(&hub_event_lock, flags);
 
@@ -511,43 +557,7 @@
 	kfree(hub);
 
 	return NULL;
-}
-
-static void hub_disconnect(struct usb_device *dev, void *ptr)
-{
-	struct usb_hub *hub = (struct usb_hub *)ptr;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hub_event_lock, flags);
-
-	/* Delete it and then reset it */
-	list_del(&hub->event_list);
-	INIT_LIST_HEAD(&hub->event_list);
-	list_del(&hub->hub_list);
-	INIT_LIST_HEAD(&hub->hub_list);
-
-	spin_unlock_irqrestore(&hub_event_lock, flags);
-
-	down(&hub->khubd_sem); /* Wait for khubd to leave this hub alone. */
-	up(&hub->khubd_sem);
-
-	/* assuming we used keventd, it must quiesce too */
-	if (hub->tt.hub)
-		flush_scheduled_tasks ();
-
-	if (hub->urb) {
-		usb_unlink_urb(hub->urb);
-		usb_free_urb(hub->urb);
-		hub->urb = NULL;
-	}
-
-	if (hub->descriptor) {
-		kfree(hub->descriptor);
-		hub->descriptor = NULL;
-	}
-
-	/* Free the memory */
-	kfree(hub);
+#endif
 }
 
 static int hub_ioctl(struct usb_device *hub, unsigned int code, void *user_data)
@@ -584,7 +594,7 @@
 
 static int usb_hub_reset(struct usb_hub *hub)
 {
-	struct usb_device *dev = hub->dev;
+	struct usb_device *dev = interface_to_usbdev(hub->intf);
 	int i;
 
 	/* Disconnect any attached devices */
@@ -796,7 +806,7 @@
 static void usb_hub_port_connect_change(struct usb_hub *hubstate, int port,
 					u16 portstatus, u16 portchange)
 {
-	struct usb_device *hub = hubstate->dev;
+	struct usb_device *hub = interface_to_usbdev(hubstate->intf);
 	struct usb_device *dev;
 	unsigned int delay = HUB_SHORT_RESET_TIME;
 	int i;
@@ -891,11 +901,15 @@
 		/* put the device in the global device tree. the hub port
 		 * is the "bus_id"; hubs show in hierarchy like bridges
 		 */
-		dev->dev.parent = &dev->parent->dev;
+//		dev->dev.parent = &dev->parent->dev;
+//		if (dev->parent->dev.parent)
+			dev->dev.parent = dev->parent->dev.parent->parent;
+//		else
+//			dev->dev.parent = &dev->parent->dev;
 		sprintf (&dev->dev.bus_id[0], "%d", port + 1);
 
 		/* Run it through the hoops (find a driver, etc) */
-		if (!usb_new_device(dev))
+		if (!usb_new_device(dev, &hubstate->intf->dev))
 			goto done;
 
 		/* Free the configuration if there was an error */
@@ -940,7 +954,7 @@
 		tmp = hub_event_list.next;
 
 		hub = list_entry(tmp, struct usb_hub, event_list);
-		dev = hub->dev;
+		dev = interface_to_usbdev(hub->intf);
 
 		list_del(tmp);
 		INIT_LIST_HEAD(tmp);
@@ -1080,9 +1094,9 @@
 
 static struct usb_driver hub_driver = {
 	.name =		"hub",
-	.probe =	hub_probe,
+	.new_probe =	hub_probe,
 	.ioctl =	hub_ioctl,
-	.disconnect =	hub_disconnect,
+	.new_disco =	hub_disconnect,
 	.id_table =	hub_id_table,
 };
 
diff -Nru a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
--- a/drivers/usb/core/hub.h	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/core/hub.h	Thu Aug 22 13:39:15 2002
@@ -170,7 +170,8 @@
 extern void usb_hub_tt_clear_buffer (struct usb_device *dev, int pipe);
 
 struct usb_hub {
-	struct usb_device	*dev;		/* the "real" device */
+//	struct usb_device	*dev;		/* the "real" device */
+	struct usb_interface	*intf;		/* the "real" device */
 	struct urb		*urb;		/* for interrupt polling pipe */
 
 	/* buffer for urb ... 1 bit each for hub and children, rounded up */
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/core/usb.c	Thu Aug 22 13:39:15 2002
@@ -48,17 +48,60 @@
 extern int usb_major_init(void);
 extern void usb_major_cleanup(void);
 
-/*
- * Prototypes for the device driver probing/loading functions
- */
-static void usb_find_drivers(struct usb_device *);
-static void usb_check_support(struct usb_device *);
 
-/*
- * We have a per-interface "registered driver" list.
- */
-LIST_HEAD(usb_driver_list);
 
+static int generic_probe (struct device *dev)
+{
+	return 0;
+}
+static int generic_remove (struct device *dev)
+{
+	return 0;
+}
+static void generic_release (struct device_driver * drv)
+{
+}
+
+static struct device_driver usb_generic_driver = {
+	.name =	"generic usb driver",
+	.probe = generic_probe,
+	.remove = generic_remove,
+	.release = generic_release,
+};
+	
+
+static int usb_device_probe(struct device * dev)
+{
+	struct usb_interface * intf = to_usb_interface(dev);
+	struct usb_driver * driver = to_usb_driver(dev->driver);
+	const struct usb_device_id *id;
+	int error = -ENODEV;
+
+	dbg("%s", __FUNCTION__);
+
+	if (!driver->new_probe)
+		return error;
+
+	id = usb_match_id (intf, driver->id_table);
+	if (id) {
+		dbg ("%s - got id", __FUNCTION__);
+		down (&driver->serialize);
+		error = driver->new_probe (intf, id);
+		up (&driver->serialize);
+	}
+	if (!error)
+		intf->driver = driver;
+	return error;
+}
+
+static int usb_device_remove(struct device * dev)
+{
+	struct usb_interface * intf = list_entry(dev,struct usb_interface,dev);
+
+	if (intf->driver && intf->driver->new_disco)
+		intf->driver->new_disco(intf);
+	return 0;
+}
 
 /**
  * usb_register - register a USB driver
@@ -77,46 +120,26 @@
 {
 	int retval = 0;
 
-	info("registered new driver %s", new_driver->name);
+	new_driver->driver.name = (char *)new_driver->name;
+	new_driver->driver.bus = &usb_bus_type;
+	new_driver->driver.probe = usb_device_probe;
+	new_driver->driver.remove = usb_device_remove;
 
 	init_MUTEX(&new_driver->serialize);
 
-	/* Add it to the list of known drivers */
-	list_add_tail(&new_driver->driver_list, &usb_driver_list);
-
-	usb_scan_devices();
+	retval = driver_register(&new_driver->driver);
 
-	usbfs_update_special();
+	if (!retval) {
+		info("registered new driver %s", new_driver->name);
+		usbfs_update_special();
+	} else {
+		err("problem %d when registering driver %s",
+			retval, new_driver->name);
+	}
 
 	return retval;
 }
 
-
-/**
- *	usb_scan_devices - scans all unclaimed USB interfaces
- *	Context: !in_interrupt ()
- *
- *	Goes through all unclaimed USB interfaces, and offers them to all
- *	registered USB drivers through the 'probe' function.
- *	This will automatically be called after usb_register is called.
- *	It is called by some of the subsystems layered over USB
- *	after one of their subdrivers are registered.
- */
-void usb_scan_devices(void)
-{
-	struct list_head *tmp;
-
-	down (&usb_bus_list_lock);
-	tmp = usb_bus_list.next;
-	while (tmp != &usb_bus_list) {
-		struct usb_bus *bus = list_entry(tmp,struct usb_bus, bus_list);
-
-		tmp = tmp->next;
-		usb_check_support(bus->root_hub);
-	}
-	up (&usb_bus_list_lock);
-}
-
 /**
  *	usb_unbind_driver - disconnects a driver from a device (usbcore-internal)
  *	@device: usb device to be disconnected
@@ -232,43 +255,6 @@
 	return private;
 }
 
-/*
- * This function is part of a depth-first search down the device tree,
- * removing any instances of a device driver.
- */
-static void usb_drivers_purge(struct usb_driver *driver,struct usb_device *dev)
-{
-	int i;
-
-	if (!dev) {
-		err("null device being purged!!!");
-		return;
-	}
-
-	for (i=0; i<USB_MAXCHILDREN; i++)
-		if (dev->children[i])
-			usb_drivers_purge(driver, dev->children[i]);
-
-	if (!dev->actconfig)
-		return;
-
-	for (i = 0; i < dev->actconfig->bNumInterfaces; i++) {
-		struct usb_interface *interface = &dev->actconfig->interface[i];
-
-		if (interface->driver == driver) {
-			usb_unbind_driver(dev, interface);
-			/* if driver->disconnect didn't release the interface */
-			if (interface->driver)
-				usb_driver_release_interface(driver, interface);
-			/*
-			 * This will go through the list looking for another
-			 * driver that can handle the device
-			 */
-			usb_find_interface_driver(dev, interface);
-		}
-	}
-}
-
 /**
  * usb_deregister - unregister a USB driver
  * @driver: USB operations of the driver to unregister
@@ -282,25 +268,9 @@
  */
 void usb_deregister(struct usb_driver *driver)
 {
-	struct list_head *tmp;
-
 	info("deregistering driver %s", driver->name);
 
-	/*
-	 * first we remove the driver, to be sure it doesn't get used by
-	 * another thread while we are stepping through removing entries
-	 */
-	list_del(&driver->driver_list);
-
-	down (&usb_bus_list_lock);
-	tmp = usb_bus_list.next;
-	while (tmp != &usb_bus_list) {
-		struct usb_bus *bus = list_entry(tmp,struct usb_bus,bus_list);
-
-		tmp = tmp->next;
-		usb_drivers_purge(driver, bus->root_hub);
-	}
-	up (&usb_bus_list_lock);
+	remove_driver (&driver->driver);
 
 	usbfs_update_special();
 }
@@ -333,6 +303,32 @@
 }
 
 /**
+ * usb_if_to_ifnum - get the interface number for a given interface
+ * @iface: the interface to determine the ifnum of
+ *
+ * This walks the device descriptor for the currently active configuration
+ * and returns the interface number of this specific interface, or -ENODEV.
+ *
+ * Note that configuration descriptors are not required to assign interface
+ * numbers sequentially, so that it would be incorrect to assume that
+ * the first interface in that descriptor corresponds to interface zero.
+ * This routine helps device drivers avoid such mistakes.
+ * However, you should make sure that you do the right thing with any
+ * alternate settings available for this interfaces.
+ */
+int usb_if_to_ifnum(struct usb_interface *iface)
+{
+	struct usb_device *dev = interface_to_usbdev(iface);
+	int i;
+
+	for (i = 0; i < dev->actconfig->bNumInterfaces; i++)
+		if (iface == &dev->actconfig->interface[i])
+			return dev->actconfig->interface[i].altsetting[0].bInterfaceNumber;
+
+	return -ENODEV;
+}
+
+/**
  * usb_epnum_to_ep_desc - get the endpoint object with a given endpoint number
  * @dev: the device whose current configuration is considered
  * @epnum: the desired endpoint
@@ -359,34 +355,6 @@
 	return NULL;
 }
 
-/*
- * This function is for doing a depth-first search for devices which
- * have support, for dynamic loading of driver modules.
- */
-static void usb_check_support(struct usb_device *dev)
-{
-	int i;
-
-	if (!dev) {
-		err("null device being checked!!!");
-		return;
-	}
-
-	for (i=0; i<USB_MAXCHILDREN; i++)
-		if (dev->children[i])
-			usb_check_support(dev->children[i]);
-
-	if (!dev->actconfig)
-		return;
-
-	/* now we check this device */
-	if (dev->devnum > 0)
-		for (i = 0; i < dev->actconfig->bNumInterfaces; i++)
-			usb_find_interface_driver (dev,
-				dev->actconfig->interface + i);
-}
-
-
 /**
  * usb_driver_claim_interface - bind a driver to an interface
  * @driver: the driver to be bound
@@ -595,72 +563,25 @@
 	return NULL;
 }
 
-/*
- * This entrypoint gets called for unclaimed interfaces.
- *
- * We now walk the list of registered USB drivers,
- * looking for one that will accept this interface.
- *
- * "New Style" drivers use a table describing the devices and interfaces
- * they handle.  Those tables are available to user mode tools deciding
- * whether to load driver modules for a new device.
- *
- * The probe return value is changed to be a private pointer.  This way
- * the drivers don't have to dig around in our structures to set the
- * private pointer if they only need one interface. 
- *
- * Returns: 0 if a driver accepted the interface, -1 otherwise
- */
-int usb_find_interface_driver (
-	struct usb_device *dev,
-	struct usb_interface *interface
-)
+static int usb_device_match (struct device *dev, struct device_driver *drv)
 {
-	struct list_head *tmp;
-	void *private;
-	struct usb_driver *driver;
-	int ifnum;
-	
-	down(&dev->serialize);
-
-	/* FIXME It's just luck that for some devices with drivers that set
-	 * configuration in probe(), the interface numbers still make sense.
-	 * That's one of several unsafe assumptions involved in configuring
-	 * devices, and in binding drivers to their interfaces.
-	 */
-	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++)
-		if (&dev->actconfig->interface [ifnum] == interface)
-			break;
-	BUG_ON (ifnum == dev->actconfig->bNumInterfaces);
+	struct usb_interface *intf;
+	struct usb_driver *usb_drv;
+	const struct usb_device_id *id;
 
-	if (usb_interface_claimed(interface))
-		goto out_err;
+	intf = to_usb_interface(dev);
 
-	private = NULL;
-	lock_kernel();
-	for (tmp = usb_driver_list.next; tmp != &usb_driver_list;) {
-		driver = list_entry(tmp, struct usb_driver, driver_list);
-		tmp = tmp->next;
-
-		private = usb_bind_driver(driver, interface);
-
-		/* probe() may have changed the config on us */
-		interface = dev->actconfig->interface + ifnum;
-
-		if (private) {
-			usb_driver_claim_interface(driver, interface, private);
-			up(&dev->serialize);
-			unlock_kernel();
-			return 0;
-		}
-	}
-	unlock_kernel();
+	usb_drv = to_usb_driver(drv);
+	id = usb_drv->id_table;
+	
+	id = usb_match_id (intf, usb_drv->id_table);
+	if (id)
+		return 1;
 
-out_err:
-	up(&dev->serialize);
-	return -1;
+	return 0;
 }
 
+
 #ifdef	CONFIG_HOTPLUG
 
 /*
@@ -814,7 +735,7 @@
 	return sprintf (buf, "%u\n", udev->actconfig->bConfigurationValue);
 }
 
-static DEVICE_ATTR(config,"configuration",S_IRUGO,show_config,NULL);
+static DEVICE_ATTR(configuration,S_IRUGO,show_config,NULL);
 
 /* interfaces have one current setting; alternates
  * can have different endpoints and class info.
@@ -829,7 +750,7 @@
 	interface = to_usb_interface (dev);
 	return sprintf (buf, "%u\n", interface->altsetting->bAlternateSetting);
 }
-static DEVICE_ATTR(altsetting,"altsetting",S_IRUGO,show_altsetting,NULL);
+static DEVICE_ATTR(altsetting,S_IRUGO,show_altsetting,NULL);
 
 /* product driverfs file */
 static ssize_t show_product (struct device *dev, char *buf, size_t count, loff_t off)
@@ -848,7 +769,7 @@
 	buf[len+1] = 0;
 	return len+1;
 }
-static DEVICE_ATTR(product,"product",S_IRUGO,show_product,NULL);
+static DEVICE_ATTR(product,S_IRUGO,show_product,NULL);
 
 /* manufacturer driverfs file */
 static ssize_t
@@ -868,7 +789,7 @@
 	buf[len+1] = 0;
 	return len+1;
 }
-static DEVICE_ATTR(manufacturer,"manufacturer",S_IRUGO,show_manufacturer,NULL);
+static DEVICE_ATTR(manufacturer,S_IRUGO,show_manufacturer,NULL);
 
 /* serial number driverfs file */
 static ssize_t
@@ -888,72 +809,7 @@
 	buf[len+1] = 0;
 	return len+1;
 }
-static DEVICE_ATTR(serial,"serial",S_IRUGO,show_serial,NULL);
-
-/*
- * This entrypoint gets called for each new device.
- *
- * All interfaces are scanned for matching drivers.
- */
-static void usb_find_drivers(struct usb_device *dev)
-{
-	unsigned ifnum;
-	unsigned rejected = 0;
-	unsigned claimed = 0;
-
-	/* FIXME should get called for each new configuration not just the
-	 * first one for a device. switching configs (or altsettings) should
-	 * undo driverfs and HCD state for the previous interfaces.
-	 */
-	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++) {
-		struct usb_interface *interface = &dev->actconfig->interface[ifnum];
-		struct usb_interface_descriptor *desc = interface->altsetting;
-
-		/* register this interface with driverfs */
-		interface->dev.parent = &dev->dev;
-		interface->dev.bus = &usb_bus_type;
-		sprintf (&interface->dev.bus_id[0], "%s-%s:%d",
-			 dev->bus->bus_name, dev->devpath,
-			 interface->altsetting->bInterfaceNumber);
-		if (!desc->iInterface
-				|| usb_string (dev, desc->iInterface,
-					interface->dev.name,
-					sizeof interface->dev.name) <= 0) {
-			/* typically devices won't bother with interface
-			 * descriptions; this is the normal case.  an
-			 * interface's driver might describe it better.
-			 * (also: iInterface is per-altsetting ...)
-			 */
-			sprintf (&interface->dev.name[0],
-				"usb-%s-%s interface %d",
-				dev->bus->bus_name, dev->devpath,
-				interface->altsetting->bInterfaceNumber);
-		}
-		device_register (&interface->dev);
-		device_create_file (&interface->dev, &dev_attr_altsetting);
-
-		/* if this interface hasn't already been claimed */
-		if (!usb_interface_claimed(interface)) {
-			if (usb_find_interface_driver(dev, interface))
-				rejected++;
-			else
-				claimed++;
-		}
-	}
- 
-	if (rejected)
-		dbg("unhandled interfaces on device");
-
-	if (!claimed) {
-		warn("USB device %d (vend/prod 0x%x/0x%x) is not claimed by any active driver.",
-			dev->devnum,
-			dev->descriptor.idVendor,
-			dev->descriptor.idProduct);
-#ifdef DEBUG
-		usb_show_device(dev);
-#endif
-	}
-}
+static DEVICE_ATTR(serial,S_IRUGO,show_serial,NULL);
 
 /**
  * usb_alloc_dev - allocate a usb device structure (usbcore-internal)
@@ -1271,11 +1127,12 @@
  */
 #define NEW_DEVICE_RETRYS	2
 #define SET_ADDRESS_RETRYS	2
-int usb_new_device(struct usb_device *dev)
+int usb_new_device(struct usb_device *dev, struct device *parent)
 {
 	int err = 0;
 	int i;
 	int j;
+	int ifnum;
 
 	/* USB v1.1 5.5.3 */
 	/* We read the first 8 bytes from the device descriptor to get to */
@@ -1361,11 +1218,23 @@
 		usb_show_string(dev, "SerialNumber", dev->descriptor.iSerialNumber);
 #endif
 
-	/* register this device in the driverfs tree */
+	/*
+	 * Set the driver for the usb device to point to the "generic" driver.
+	 * This prevents the main usb device from being sent to the usb bus
+	 * probe function.  Yes, it's a hack, but a nice one :)
+	 */
+	usb_generic_driver.bus = &usb_bus_type;
+	dev->dev.parent = parent;
+	dev->dev.driver = &usb_generic_driver;
+	dev->dev.bus = &usb_bus_type;
+	sprintf (&dev->dev.bus_id[0], "%s-%s",
+		 dev->bus->bus_name, dev->devpath);
 	err = device_register (&dev->dev);
 	if (err)
 		return err;
-	device_create_file (&dev->dev, &dev_attr_config);
+
+	/* add the USB device specific driverfs files */
+	device_create_file (&dev->dev, &dev_attr_configuration);
 	if (dev->descriptor.iManufacturer)
 		device_create_file (&dev->dev, &dev_attr_manufacturer);
 	if (dev->descriptor.iProduct)
@@ -1373,11 +1242,38 @@
 	if (dev->descriptor.iSerialNumber)
 		device_create_file (&dev->dev, &dev_attr_serial);
 
-	/* now that the basic setup is over, add a /proc/bus/usb entry */
-	usbfs_add_device(dev);
+	/* Register all of the interfaces for this device with the driver core.
+	 * Remember, interfaces get bound to drivers, not devices. */
+	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++) {
+		struct usb_interface *interface = &dev->actconfig->interface[ifnum];
+		struct usb_interface_descriptor *desc = interface->altsetting;
 
-	/* find drivers willing to handle this device */
-	usb_find_drivers(dev);
+		interface->dev.parent = &dev->dev;
+		interface->dev.bus = &usb_bus_type;
+		sprintf (&interface->dev.bus_id[0], "%s-%s:%d",
+			 dev->bus->bus_name, dev->devpath,
+			 interface->altsetting->bInterfaceNumber);
+		if (!desc->iInterface
+				|| usb_string (dev, desc->iInterface,
+					interface->dev.name,
+					sizeof interface->dev.name) <= 0) {
+			/* typically devices won't bother with interface
+			 * descriptions; this is the normal case.  an
+			 * interface's driver might describe it better.
+			 * (also: iInterface is per-altsetting ...)
+			 */
+			sprintf (&interface->dev.name[0],
+				"usb-%s-%s interface %d",
+				dev->bus->bus_name, dev->devpath,
+				interface->altsetting->bInterfaceNumber);
+		}
+		dbg ("%s - registering %s", __FUNCTION__, interface->dev.bus_id);
+		device_register (&interface->dev);
+		device_create_file (&interface->dev, &dev_attr_altsetting);
+	}
+
+	/* add a /proc/bus/usb entry */
+	usbfs_add_device(dev);
 
 	/* userspace may load modules and/or configure further */
 	call_policy ("add", dev);
@@ -1385,7 +1281,6 @@
 	return 0;
 }
 
-
 /**
  * usb_buffer_alloc - allocate dma-consistent buffer for URB_NO_DMA_MAP
  * @dev: device the buffer will be used with
@@ -1532,20 +1427,9 @@
 				: USB_DIR_OUT);
 }
 
-#ifdef CONFIG_PROC_FS
-struct list_head *usb_driver_get_list(void)
-{
-	return &usb_driver_list;
-}
-
-struct list_head *usb_bus_get_list(void)
-{
-	return &usb_bus_list;
-}
-#endif
-
 struct bus_type usb_bus_type = {
-	.name =	"usb",
+	.name =		"usb",
+	.match =	usb_device_match,
 };
 
 /*
@@ -1584,7 +1468,9 @@
 
 EXPORT_SYMBOL(usb_register);
 EXPORT_SYMBOL(usb_deregister);
-EXPORT_SYMBOL(usb_scan_devices);
+//EXPORT_SYMBOL(usb_scan_devices);
+
+EXPORT_SYMBOL(usb_if_to_ifnum);
 
 EXPORT_SYMBOL(usb_alloc_dev);
 EXPORT_SYMBOL(usb_free_dev);
diff -Nru a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
--- a/drivers/usb/host/ehci-dbg.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/host/ehci-dbg.c	Thu Aug 22 13:39:15 2002
@@ -252,7 +252,7 @@
 
 	return count - size;
 }
-static DEVICE_ATTR (async, "sched-async", S_IRUSR, show_async, NULL);
+static DEVICE_ATTR (async, S_IRUSR, show_async, NULL);
 
 #define DBG_SCHED_LIMIT 64
 
@@ -360,7 +360,7 @@
 
 	return count - size;
 }
-static DEVICE_ATTR (periodic, "sched-periodic", S_IRUSR, show_periodic, NULL);
+static DEVICE_ATTR (periodic, S_IRUSR, show_periodic, NULL);
 
 #undef DBG_SCHED_LIMIT
 
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/input/hid-core.c	Thu Aug 22 13:39:15 2002
@@ -1338,9 +1338,10 @@
 	{ 0, 0 }
 };
 
-static struct hid_device *usb_hid_configure(struct usb_device *dev, int ifnum)
+static struct hid_device *usb_hid_configure(struct usb_interface *intf)
 {
-	struct usb_interface_descriptor *interface = dev->actconfig->interface[ifnum].altsetting + 0;
+	struct usb_interface_descriptor *interface = intf->altsetting + intf->act_altsetting;
+	struct usb_device *dev = interface_to_usbdev (intf);
 	struct hid_descriptor *hdesc;
 	struct hid_device *hid;
 	unsigned quirks = 0, rsize = 0;
@@ -1450,7 +1451,7 @@
 		snprintf(hid->name, 128, "%04x:%04x", dev->descriptor.idVendor, dev->descriptor.idProduct);
 
 	usb_make_path(dev, buf, 64);
-	snprintf(hid->phys, 64, "%s/input%d", buf, ifnum);
+	snprintf(hid->phys, 64, "%s/input%d", buf, intf->altsetting[0].bInterfaceNumber);
 
 	if (usb_string(dev, dev->descriptor.iSerialNumber, hid->uniq, 64) <= 0)
 		hid->uniq[0] = 0;
@@ -1472,9 +1473,9 @@
 	return NULL;
 }
 
-static void hid_disconnect(struct usb_device *dev, void *ptr)
+static void hid_disconnect(struct usb_interface *intf)
 {
-	struct hid_device *hid = ptr;
+	struct hid_device *hid = intf->dev.driver_data;
 
 	usb_unlink_urb(hid->urbin);
 	usb_unlink_urb(hid->urbout);
@@ -1491,20 +1492,20 @@
 		usb_free_urb(hid->urbout);
 
 	hid_free_device(hid);
+	intf->dev.driver_data = NULL;
 }
 
-static void* hid_probe(struct usb_device *dev, unsigned int ifnum,
-		       const struct usb_device_id *id)
+static int hid_probe (struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct hid_device *hid;
 	char path[64];
 	int i;
 	char *c;
 
-	dbg("HID probe called for ifnum %d", ifnum);
+	dbg("HID probe called for ifnum %d", intf->ifnum);
 
-	if (!(hid = usb_hid_configure(dev, ifnum)))
-		return NULL;
+	if (!(hid = usb_hid_configure(intf)))
+		return -EIO;
 
 	hid_init_reports(hid);
 	hid_dump_device(hid);
@@ -1516,9 +1517,11 @@
 	if (!hiddev_connect(hid))
 		hid->claimed |= HID_CLAIMED_HIDDEV;
 
+	intf->dev.driver_data = hid;
+
 	if (!hid->claimed) {
-		hid_disconnect(dev, hid);
-		return NULL;
+		hid_disconnect(intf);
+		return -EIO;
 	}
 
 	printk(KERN_INFO);
@@ -1540,12 +1543,12 @@
 		}
 	}
 
-	usb_make_path(dev, path, 63);
+	usb_make_path(interface_to_usbdev(intf), path, 63);
 
 	printk(": USB HID v%x.%02x %s [%s] on %s\n",
 		hid->version >> 8, hid->version & 0xff, c, hid->name, path);
 
-	return hid;
+	return 0;
 }
 
 static struct usb_device_id hid_usb_ids [] = {
@@ -1558,8 +1561,8 @@
 
 static struct usb_driver hid_driver = {
 	.name =		"hid",
-	.probe =	hid_probe,
-	.disconnect =	hid_disconnect,
+	.new_probe =	hid_probe,
+	.new_disco =	hid_disconnect,
 	.id_table =	hid_usb_ids,
 };
 
diff -Nru a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
--- a/drivers/usb/serial/belkin_sa.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/belkin_sa.c	Thu Aug 22 13:39:15 2002
@@ -114,6 +114,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver belkin_driver = {
+	.name =		"belkin",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 /* All of the device info needed for the serial converters */
 static struct usb_serial_device_type belkin_device = {
 	.owner =		THIS_MODULE,
@@ -526,6 +533,7 @@
 static int __init belkin_sa_init (void)
 {
 	usb_serial_register (&belkin_device);
+	usb_register (&belkin_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -533,6 +541,7 @@
 
 static void __exit belkin_sa_exit (void)
 {
+	usb_deregister (&belkin_driver);
 	usb_serial_deregister (&belkin_device);
 }
 
diff -Nru a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
--- a/drivers/usb/serial/cyberjack.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/cyberjack.c	Thu Aug 22 13:39:15 2002
@@ -73,6 +73,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver cyberjack_driver = {
+	.name =		"cyberjack",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 static struct usb_serial_device_type cyberjack_device = {
 	.owner =		THIS_MODULE,
 	.name =			"Reiner SCT Cyberjack USB card reader",
@@ -461,6 +468,7 @@
 static int __init cyberjack_init (void)
 {
 	usb_serial_register (&cyberjack_device);
+	usb_register (&cyberjack_driver);
 
 	info(DRIVER_VERSION " " DRIVER_AUTHOR);
 	info(DRIVER_DESC);
@@ -470,6 +478,7 @@
 
 static void __exit cyberjack_exit (void)
 {
+	usb_deregister (&cyberjack_driver);
 	usb_serial_deregister (&cyberjack_device);
 }
 
diff -Nru a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
--- a/drivers/usb/serial/digi_acceleport.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/digi_acceleport.c	Thu Aug 22 13:39:15 2002
@@ -477,7 +477,7 @@
 
 /* Statics */
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(DIGI_VENDOR_ID, DIGI_2_ID) },
 	{ USB_DEVICE(DIGI_VENDOR_ID, DIGI_4_ID) },
 	{ }						/* Terminating entry */
@@ -495,6 +495,14 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver digi_driver = {
+	.name =		"digi_acceleport",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
+
 /* device info needed for the Digi serial converter */
 
 static struct usb_serial_device_type digi_acceleport_2_device = {
@@ -2026,6 +2034,7 @@
 {
 	usb_serial_register (&digi_acceleport_2_device);
 	usb_serial_register (&digi_acceleport_4_device);
+	usb_register (&digi_driver);
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 	return 0;
 }
@@ -2033,6 +2042,7 @@
 
 static void __exit digi_exit (void)
 {
+	usb_deregister (&digi_driver);
 	usb_serial_deregister (&digi_acceleport_2_device);
 	usb_serial_deregister (&digi_acceleport_4_device);
 }
diff -Nru a/drivers/usb/serial/empeg.c b/drivers/usb/serial/empeg.c
--- a/drivers/usb/serial/empeg.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/empeg.c	Thu Aug 22 13:39:15 2002
@@ -110,6 +110,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver empeg_driver = {
+	.name =		"empeg",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 static struct usb_serial_device_type empeg_device = {
 	.owner =		THIS_MODULE,
 	.name =			"Empeg",
@@ -550,8 +557,6 @@
 	struct urb *urb;
 	int i;
 
-	usb_serial_register (&empeg_device);
-
 	/* create our write urb pool and transfer buffers */ 
 	spin_lock_init (&write_urb_pool_lock);
 	for (i = 0; i < NUM_URBS; ++i) {
@@ -570,10 +575,12 @@
 		}
 	}
 
+	usb_serial_register (&empeg_device);
+	usb_register (&empeg_driver);
+
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 
 	return 0;
-
 }
 
 
@@ -582,6 +589,7 @@
 	int i;
 	unsigned long flags;
 
+	usb_register (&empeg_driver);
 	usb_serial_deregister (&empeg_device);
 
 	spin_lock_irqsave (&write_urb_pool_lock, flags);
@@ -599,7 +607,6 @@
 	}
 
 	spin_unlock_irqrestore (&write_urb_pool_lock, flags);
-
 }
 
 
diff -Nru a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/ftdi_sio.c	Thu Aug 22 13:39:15 2002
@@ -140,7 +140,7 @@
 };
 
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
 	{ USB_DEVICE(FTDI_NF_RIC_VID, FTDI_NF_RIC_PID) },
@@ -149,6 +149,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver ftdi_driver = {
+	.name =		"ftdi_sio",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 
 struct ftdi_private {
 	enum ftdi_type ftdi_type;
@@ -944,6 +951,7 @@
 	dbg(__FUNCTION__);
 	usb_serial_register (&ftdi_sio_device);
 	usb_serial_register (&ftdi_8U232AM_device);
+	usb_register (&ftdi_driver);
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 	return 0;
 }
@@ -952,6 +960,7 @@
 static void __exit ftdi_sio_exit (void)
 {
 	dbg(__FUNCTION__);
+	usb_deregister (&ftdi_driver);
 	usb_serial_deregister (&ftdi_sio_device);
 	usb_serial_deregister (&ftdi_8U232AM_device);
 }
diff -Nru a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
--- a/drivers/usb/serial/io_edgeport.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/io_edgeport.c	Thu Aug 22 13:39:15 2002
@@ -457,6 +457,12 @@
 
 #include "io_tables.h"	/* all of the devices that this driver supports */
 
+static struct usb_driver io_driver = {
+	.name =		"io_edgeport",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
 
 /* function prototypes for all of our local functions */
 static int  process_rcvd_data		(struct edgeport_serial *edge_serial, unsigned char *buffer, __u16 bufferLength);
@@ -3049,6 +3055,7 @@
 	usb_serial_register (&edgeport_2port_device);
 	usb_serial_register (&edgeport_4port_device);
 	usb_serial_register (&edgeport_8port_device);
+	usb_register (&io_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -3061,6 +3068,7 @@
  ****************************************************************************/
 void __exit edgeport_exit (void)
 {
+	usb_deregister (&io_driver);
 	usb_serial_deregister (&edgeport_1port_device);
 	usb_serial_deregister (&edgeport_2port_device);
 	usb_serial_deregister (&edgeport_4port_device);
diff -Nru a/drivers/usb/serial/io_tables.h b/drivers/usb/serial/io_tables.h
--- a/drivers/usb/serial/io_tables.h	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/io_tables.h	Thu Aug 22 13:39:15 2002
@@ -61,7 +61,7 @@
 };
 
 /* Devices that this driver supports */
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ION,	ION_DEVICE_ID_EDGEPORT_4) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION,	ION_DEVICE_ID_RAPIDPORT_4) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION,	ION_DEVICE_ID_EDGEPORT_4T) },
diff -Nru a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
--- a/drivers/usb/serial/io_ti.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/io_ti.c	Thu Aug 22 13:39:15 2002
@@ -142,7 +142,7 @@
 };
 
 /* Devices that this driver supports */
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_1) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_2) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_2I) },
@@ -161,6 +161,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver io_driver = {
+	.name =		"io_ti",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 
 static struct EDGE_FIRMWARE_VERSION_INFO OperationalCodeImageVersion;
 
@@ -2658,12 +2665,14 @@
 {
 	usb_serial_register (&edgeport_1port_device);
 	usb_serial_register (&edgeport_2port_device);
+	usb_register (&io_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
 
 static void __exit edgeport_exit (void)
 {
+	usb_deregister (&io_driver);
 	usb_serial_deregister (&edgeport_1port_device);
 	usb_serial_deregister (&edgeport_2port_device);
 }
diff -Nru a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
--- a/drivers/usb/serial/ipaq.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/ipaq.c	Thu Aug 22 13:39:15 2002
@@ -94,6 +94,14 @@
 
 MODULE_DEVICE_TABLE (usb, ipaq_id_table);
 
+static struct usb_driver ipaq_driver = {
+	.name =		"ipaq",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	ipaq_id_table,
+};
+
+
 /* All of the device info needed for the Compaq iPAQ */
 struct usb_serial_device_type ipaq_device = {
 	.owner =		THIS_MODULE,
@@ -516,6 +524,7 @@
 static int __init ipaq_init(void)
 {
 	usb_serial_register(&ipaq_device);
+	usb_register(&ipaq_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 
 	return 0;
@@ -524,6 +533,7 @@
 
 static void __exit ipaq_exit(void)
 {
+	usb_deregister(&ipaq_driver);
 	usb_serial_deregister(&ipaq_device);
 }
 
diff -Nru a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
--- a/drivers/usb/serial/ir-usb.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/ir-usb.c	Thu Aug 22 13:39:15 2002
@@ -129,6 +129,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver ir_driver = {
+	.name =		"ir-usb",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 
 struct usb_serial_device_type ir_device = {
 	.owner =		THIS_MODULE,
@@ -606,6 +613,7 @@
 static int __init ir_init (void)
 {
 	usb_serial_register (&ir_device);
+	usb_register (&ir_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -613,6 +621,7 @@
 
 static void __exit ir_exit (void)
 {
+	usb_deregister (&ir_driver);
 	usb_serial_deregister (&ir_device);
 }
 
diff -Nru a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
--- a/drivers/usb/serial/keyspan.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/keyspan.c	Thu Aug 22 13:39:15 2002
@@ -183,6 +183,7 @@
 	usb_serial_register (&keyspan_1port_device);
 	usb_serial_register (&keyspan_2port_device);
 	usb_serial_register (&keyspan_4port_device);
+	usb_register (&keyspan_driver);
 
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 
@@ -191,6 +192,7 @@
 
 static void __exit keyspan_exit (void)
 {
+	usb_deregister (&keyspan_driver);
 	usb_serial_deregister (&keyspan_pre_device);
 	usb_serial_deregister (&keyspan_1port_device);
 	usb_serial_deregister (&keyspan_2port_device);
diff -Nru a/drivers/usb/serial/keyspan.h b/drivers/usb/serial/keyspan.h
--- a/drivers/usb/serial/keyspan.h	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/keyspan.h	Thu Aug 22 13:39:15 2002
@@ -408,7 +408,7 @@
 	NULL,
 };
 
-static __devinitdata struct usb_device_id keyspan_ids_combined[] = {
+static struct usb_device_id keyspan_ids_combined[] = {
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa18x_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19_pre_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19w_pre_product_id) },
@@ -433,6 +433,13 @@
 };
 
 MODULE_DEVICE_TABLE(usb, keyspan_ids_combined);
+
+static struct usb_driver keyspan_driver = {
+	.name =		"keyspan",                
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	keyspan_ids_combined,
+};
 
 /* usb_device_id table for the pre-firmware download keyspan devices */
 static struct usb_device_id keyspan_pre_ids[] = {
diff -Nru a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
--- a/drivers/usb/serial/keyspan_pda.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/keyspan_pda.c	Thu Aug 22 13:39:15 2002
@@ -140,7 +140,7 @@
 #define ENTREGRA_VENDOR_ID		0x1645
 #define ENTREGRA_FAKE_ID		0x8093
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 #ifdef KEYSPAN
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, KEYSPAN_PDA_FAKE_ID) },
 #endif
@@ -154,6 +154,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver keyspan_pda_driver = {
+	.name =		"keyspan_pda",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 static struct usb_device_id id_table_std [] = {
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, KEYSPAN_PDA_ID) },
 	{ }						/* Terminating entry */
@@ -862,6 +869,7 @@
 #ifdef XIRCOM
 	usb_serial_register (&xircom_pgs_fake_device);
 #endif
+	usb_register (&keyspan_pda_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -869,6 +877,7 @@
 
 static void __exit keyspan_pda_exit (void)
 {
+	usb_deregister (&keyspan_pda_driver);
 	usb_serial_deregister (&keyspan_pda_device);
 #ifdef KEYSPAN
 	usb_serial_deregister (&keyspan_pda_fake_device);
diff -Nru a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
--- a/drivers/usb/serial/kl5kusb105.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/kl5kusb105.c	Thu Aug 22 13:39:15 2002
@@ -117,6 +117,12 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver kl5kusb105d_driver = {
+	.name =		"kl5kusb105d",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
 
 static struct usb_serial_device_type kl5kusb105d_device = {
 	.owner =             THIS_MODULE,
@@ -1013,6 +1019,7 @@
 static int __init klsi_105_init (void)
 {
 	usb_serial_register (&kl5kusb105d_device);
+	usb_register (&kl5kusb105d_driver);
 
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
@@ -1021,6 +1028,7 @@
 
 static void __exit klsi_105_exit (void)
 {
+	usb_deregister (&kl5kusb105d_driver);
 	usb_serial_deregister (&kl5kusb105d_device);
 }
 
diff -Nru a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
--- a/drivers/usb/serial/mct_u232.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/mct_u232.c	Thu Aug 22 13:39:15 2002
@@ -139,6 +139,12 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver mct_u232_driver = {
+	.name =		"mct_u232",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
 
 static struct usb_serial_device_type mct_u232_device = {
 	.owner =	     THIS_MODULE,
@@ -783,6 +789,7 @@
 static int __init mct_u232_init (void)
 {
 	usb_serial_register (&mct_u232_device);
+	usb_register (&mct_u232_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -790,6 +797,7 @@
 
 static void __exit mct_u232_exit (void)
 {
+	usb_deregister (&mct_u232_driver);
 	usb_serial_deregister (&mct_u232_device);
 }
 
diff -Nru a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
--- a/drivers/usb/serial/omninet.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/omninet.c	Thu Aug 22 13:39:15 2002
@@ -83,6 +83,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver omninet_driver = {
+	.name =		"omninet",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 
 static struct usb_serial_device_type zyxel_omninet_device = {
 	.owner =		THIS_MODULE,
@@ -370,6 +377,7 @@
 static int __init omninet_init (void)
 {
 	usb_serial_register (&zyxel_omninet_device);
+	usb_register (&omninet_driver);
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 	return 0;
 }
@@ -377,6 +385,7 @@
 
 static void __exit omninet_exit (void)
 {
+	usb_deregister (&omninet_driver);
 	usb_serial_deregister (&zyxel_omninet_device);
 }
 
diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/pl2303.c	Thu Aug 22 13:39:15 2002
@@ -77,6 +77,12 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver pl2303_driver = {
+	.name =		"pl2303",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
 
 #define SET_LINE_REQUEST_TYPE		0x21
 #define SET_LINE_REQUEST		0x20
@@ -708,6 +714,7 @@
 static int __init pl2303_init (void)
 {
 	usb_serial_register (&pl2303_device);
+	usb_register (&pl2303_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -715,6 +722,7 @@
 
 static void __exit pl2303_exit (void)
 {
+	usb_deregister (&pl2303_driver);
 	usb_serial_deregister (&pl2303_device);
 }
 
diff -Nru a/drivers/usb/serial/safe_serial.c b/drivers/usb/serial/safe_serial.c
--- a/drivers/usb/serial/safe_serial.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/safe_serial.c	Thu Aug 22 13:39:15 2002
@@ -161,6 +161,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table);
 
+static struct usb_driver safe_driver = {
+	.name =		"safe_serial",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table,
+};
+
 static __u16 crc10_table[256] = {
 	0x000, 0x233, 0x255, 0x066, 0x299, 0x0aa, 0x0cc, 0x2ff, 0x301, 0x132, 0x154, 0x367, 0x198, 0x3ab, 0x3cd, 0x1fe,
 	0x031, 0x202, 0x264, 0x057, 0x2a8, 0x09b, 0x0fd, 0x2ce, 0x330, 0x103, 0x165, 0x356, 0x1a9, 0x39a, 0x3fc, 0x1cf,
@@ -434,12 +441,14 @@
 	}
 
 	usb_serial_register (&safe_device);
+	usb_register (&safe_driver);
 
 	return 0;
 }
 
 static void __exit safe_exit (void)
 {
+	usb_deregister (&safe_driver);
 	usb_serial_deregister (&safe_device);
 }
 
diff -Nru a/drivers/usb/serial/usb-serial.h b/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/usb-serial.h	Thu Aug 22 13:39:15 2002
@@ -233,6 +233,9 @@
 extern int  usb_serial_register(struct usb_serial_device_type *new_device);
 extern void usb_serial_deregister(struct usb_serial_device_type *device);
 
+extern int usb_serial_probe(struct usb_interface *iface, const struct usb_device_id *id);
+extern void usb_serial_disconnect(struct usb_interface *iface);
+
 /* determine if we should include the EzUSB loader functions */
 #undef USES_EZUSB_FUNCTIONS
 #if defined(CONFIG_USB_SERIAL_KEYSPAN_PDA) || defined(CONFIG_USB_SERIAL_KEYSPAN_PDA_MODULE)
diff -Nru a/drivers/usb/serial/usbserial.c b/drivers/usb/serial/usbserial.c
--- a/drivers/usb/serial/usbserial.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/usbserial.c	Thu Aug 22 13:39:15 2002
@@ -380,30 +380,23 @@
 	.num_ports =		1,
 	.shutdown =		generic_shutdown,
 };
-#endif
-
 
-/* local function prototypes */
-static int  serial_open (struct tty_struct *tty, struct file * filp);
-static void serial_close (struct tty_struct *tty, struct file * filp);
-static int  serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count);
-static int  serial_write_room (struct tty_struct *tty);
-static int  serial_chars_in_buffer (struct tty_struct *tty);
-static void serial_throttle (struct tty_struct * tty);
-static void serial_unthrottle (struct tty_struct * tty);
-static int  serial_ioctl (struct tty_struct *tty, struct file * file, unsigned int cmd, unsigned long arg);
-static void serial_set_termios (struct tty_struct *tty, struct termios * old);
-static void serial_shutdown (struct usb_serial *serial);
-
-static void * usb_serial_probe(struct usb_device *dev, unsigned int ifnum,
-			       const struct usb_device_id *id);
-static void usb_serial_disconnect(struct usb_device *dev, void *ptr);
+/* we want to look at all devices, as the vendor/product id can change
+ * depending on the command line argument */
+static struct usb_device_id generic_serial_ids[] = {
+	{.driver_info = 42},
+	{}
+};
+#endif
 
+/* Driver structure we register with the USB core */
 static struct usb_driver usb_serial_driver = {
 	.name =		"serial",
-	.probe =	usb_serial_probe,
-	.disconnect =	usb_serial_disconnect,
-	.id_table =	NULL, 			/* check all devices */
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+#ifdef CONFIG_USB_SERIAL_GENERIC
+	.id_table =	generic_serial_ids,
+#endif
 };
 
 /* There is no MODULE_DEVICE_TABLE for usbserial.c.  Instead
@@ -413,7 +406,6 @@
    drivers depend on it.
 */
 
-
 static int			serial_refcount;
 static struct tty_driver	serial_tty_driver;
 static struct tty_struct *	serial_tty[SERIAL_TTY_MINORS];
@@ -1162,12 +1154,12 @@
 	return serial;
 }
 
-static void * usb_serial_probe(struct usb_device *dev, unsigned int ifnum,
+int usb_serial_probe(struct usb_interface *interface,
 			       const struct usb_device_id *id)
 {
+	struct usb_device *dev = interface_to_usbdev (interface);
 	struct usb_serial *serial = NULL;
 	struct usb_serial_port *port;
-	struct usb_interface *interface;
 	struct usb_interface_descriptor *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_endpoint_descriptor *interrupt_in_endpoint[MAX_NUM_PORTS];
@@ -1190,7 +1182,6 @@
 	/* loop through our list of known serial converters, and see if this
 	   device matches. */
 	found = 0;
-	interface = &dev->actconfig->interface[ifnum];
 	list_for_each (tmp, &usb_serial_driver_list) {
 		type = list_entry(tmp, struct usb_serial_device_type, driver_list);
 		id_pattern = usb_match_id(interface, type->id_table);
@@ -1203,13 +1194,13 @@
 	if (!found) {
 		/* no match */
 		dbg("none matched");
-		return(NULL);
+		return -ENODEV;
 	}
 
 	serial = create_serial (dev, interface, type);
 	if (!serial) {
 		err ("%s - out of memory", __FUNCTION__);
-		return NULL;
+		return -ENODEV;
 	}
 
 	/* if this device type has a probe function, call it */
@@ -1223,7 +1214,7 @@
 		if (retval < 0) {
 			dbg ("sub driver rejected device");
 			kfree (serial);
-			return NULL;
+			return -ENODEV;
 		}
 	}
 
@@ -1259,6 +1250,7 @@
 	}
 
 #if defined(CONFIG_USB_SERIAL_PL2303) || defined(CONFIG_USB_SERIAL_PL2303_MODULE)
+#if 0
 	/* BEGIN HORRIBLE HACK FOR PL2303 */ 
 	/* this is needed due to the looney way its endpoints are set up */
 	if (ifnum == 1) {
@@ -1283,6 +1275,7 @@
 	}
 	/* END HORRIBLE HACK FOR PL2303 */
 #endif
+#endif
 
 	/* found all that we need */
 	info("%s converter detected", type->name);
@@ -1293,7 +1286,7 @@
 		if (num_ports == 0) {
 			err("Generic device with no bulk out, not allowed.");
 			kfree (serial);
-			return NULL;
+			return -EIO;
 		}
 	}
 #endif
@@ -1313,7 +1306,7 @@
 	if (get_free_serial (serial, num_ports, &minor) == NULL) {
 		err("No more free serial devices");
 		kfree (serial);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	serial->minor = minor;
@@ -1425,7 +1418,8 @@
 		if (retval > 0) {
 			/* quietly accept this device, but don't bind to a serial port
 			 * as it's about to disappear */
-			return serial;
+			interface->dev.driver_data = serial;
+			return 0;
 		}
 	}
 
@@ -1456,7 +1450,9 @@
 	}
 #endif
 
-	return serial; /* success */
+	/* success */
+	interface->dev.driver_data = serial;
+	return 0;
 
 
 probe_error:
@@ -1487,12 +1483,12 @@
 
 	/* free up any memory that we allocated */
 	kfree (serial);
-	return NULL;
+	return -EIO;
 }
 
-static void usb_serial_disconnect(struct usb_device *dev, void *ptr)
+void usb_serial_disconnect(struct usb_interface *interface)
 {
-	struct usb_serial *serial = (struct usb_serial *) ptr;
+	struct usb_serial *serial = (struct usb_serial *)interface->dev.driver_data;
 	struct usb_serial_port *port;
 	int i;
 
@@ -1660,8 +1656,6 @@
 
 	info ("USB Serial support registered for %s", new_device->name);
 
-	usb_scan_devices();
-
 	return 0;
 }
 
@@ -1678,7 +1672,7 @@
 		serial = serial_table[i];
 		if ((serial != NULL) && (serial->type == device)) {
 			usb_driver_release_interface (&usb_serial_driver, serial->interface);
-			usb_serial_disconnect (NULL, serial);
+			usb_serial_disconnect (serial->interface);
 		}
 	}
 
@@ -1691,6 +1685,8 @@
    need these symbols to load properly as modules. */
 EXPORT_SYMBOL(usb_serial_register);
 EXPORT_SYMBOL(usb_serial_deregister);
+EXPORT_SYMBOL(usb_serial_probe);
+EXPORT_SYMBOL(usb_serial_disconnect);
 #ifdef USES_EZUSB_FUNCTIONS
 	EXPORT_SYMBOL(ezusb_writememory);
 	EXPORT_SYMBOL(ezusb_set_reset);
diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/visor.c	Thu Aug 22 13:39:15 2002
@@ -197,7 +197,7 @@
 	{ }					/* Terminating entry */
 };
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_VISOR_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M500_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M505_ID) },
@@ -214,7 +214,12 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
-
+static struct usb_driver visor_driver = {
+	.name =		"visor",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
 
 /* All of the device info needed for the Handspring Visor, and Palm 4.0 devices */
 static struct usb_serial_device_type handspring_device = {
@@ -761,6 +766,7 @@
 {
 	usb_serial_register (&handspring_device);
 	usb_serial_register (&clie_3_5_device);
+	usb_register (&visor_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 
 	return 0;
@@ -769,6 +775,7 @@
 
 static void __exit visor_exit (void)
 {
+	usb_deregister (&visor_driver);
 	usb_serial_deregister (&handspring_device);
 	usb_serial_deregister (&clie_3_5_device);
 }
diff -Nru a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
--- a/drivers/usb/serial/whiteheat.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/serial/whiteheat.c	Thu Aug 22 13:39:15 2002
@@ -110,7 +110,7 @@
 	{ }						/* Terminating entry */
 };
 
-static __devinitdata struct usb_device_id id_table_combined [] = {
+static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(CONNECT_TECH_VENDOR_ID, CONNECT_TECH_WHITE_HEAT_ID) },
 	{ USB_DEVICE(CONNECT_TECH_VENDOR_ID, CONNECT_TECH_FAKE_WHITE_HEAT_ID) },
 	{ }						/* Terminating entry */
@@ -118,6 +118,13 @@
 
 MODULE_DEVICE_TABLE (usb, id_table_combined);
 
+static struct usb_driver whiteheat_driver = {
+	.name =		"whiteheat",
+	.new_probe =	usb_serial_probe,
+	.new_disco =	usb_serial_disconnect,
+	.id_table =	id_table_combined,
+};
+
 /* function prototypes for the Connect Tech WhiteHEAT serial converter */
 static int  whiteheat_open		(struct usb_serial_port *port, struct file *filp);
 static void whiteheat_close		(struct usb_serial_port *port, struct file *filp);
@@ -676,6 +683,7 @@
 {
 	usb_serial_register (&whiteheat_fake_device);
 	usb_serial_register (&whiteheat_device);
+	usb_register (&whiteheat_driver);
 	info(DRIVER_DESC " " DRIVER_VERSION);
 	return 0;
 }
@@ -683,6 +691,7 @@
 
 static void __exit whiteheat_exit (void)
 {
+	usb_deregister (&whiteheat_driver);
 	usb_serial_deregister (&whiteheat_fake_device);
 	usb_serial_deregister (&whiteheat_device);
 }
diff -Nru a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
--- a/drivers/usb/storage/usb.c	Thu Aug 22 13:39:15 2002
+++ b/drivers/usb/storage/usb.c	Thu Aug 22 13:39:15 2002
@@ -103,10 +103,10 @@
 struct us_data *us_list;
 struct semaphore us_list_semaphore;
 
-static void * storage_probe(struct usb_device *dev, unsigned int ifnum,
-			    const struct usb_device_id *id);
+static int storage_probe(struct usb_interface *iface,
+			 const struct usb_device_id *id);
 
-static void storage_disconnect(struct usb_device *dev, void *ptr);
+static void storage_disconnect(struct usb_interface *iface);
 
 /* The entries in this table, except for final ones here
  * (USB_MASS_STORAGE_CLASS and the empty entry), correspond,
@@ -229,8 +229,8 @@
 
 struct usb_driver usb_storage_driver = {
 	.name =		"usb-storage",
-	.probe =	storage_probe,
-	.disconnect =	storage_disconnect,
+	.new_probe =	storage_probe,
+	.new_disco =	storage_disconnect,
 	.id_table =	storage_usb_ids,
 };
 
@@ -618,9 +618,11 @@
 }
 
 /* Probe to see if a new device is actually a SCSI device */
-static void * storage_probe(struct usb_device *dev, unsigned int ifnum,
-			    const struct usb_device_id *id)
+static int storage_probe(struct usb_interface *intf,
+			 const struct usb_device_id *id)
 {
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int ifnum = usb_if_to_ifnum(intf);
 	int i;
 	const int id_index = id - storage_usb_ids; 
 	char mf[USB_STOR_STRING_LEN];		     /* manufacturer */
@@ -645,7 +647,6 @@
 	/* the altsetting on the interface we're probing that matched our
 	 * usb_match_id table
 	 */
-	struct usb_interface *intf = dev->actconfig->interface;
 	struct usb_interface_descriptor *altsetting =
 		intf[ifnum].altsetting + intf[ifnum].act_altsetting;
 	US_DEBUGP("act_altsetting is %d\n", intf[ifnum].act_altsetting);
@@ -675,7 +676,7 @@
 			US_DEBUGP("Product: %s\n", unusual_dev->productName);
 	} else
 		/* no, we can't support it */
-		return NULL;
+		return -EIO;
 
 	/* At this point, we know we've got a live one */
 	US_DEBUGP("USB Mass Storage device detected\n");
@@ -724,7 +725,7 @@
 		} else if (result != 0) {
 			/* it's not a stall, but another error -- time to bail */
 			US_DEBUGP("-- Unknown error.  Rejecting device\n");
-			return NULL;
+			return -EIO;
 		}
 	}
 #endif
@@ -732,7 +733,7 @@
 	/* Do some basic sanity checks, and bail if we find a problem */
 	if (!ep_in || !ep_out || (protocol == US_PR_CBI && !ep_int)) {
 		US_DEBUGP("Endpoint sanity check failed! Rejecting dev.\n");
-		return NULL;
+		return -EIO;
 	}
 
 	/* At this point, we've decided to try to use the device */
@@ -811,7 +812,7 @@
 						    GFP_KERNEL)) == NULL) {
 			printk(KERN_WARNING USB_STORAGE "Out of memory\n");
 			usb_put_dev(dev);
-			return NULL;
+			return -ENOMEM;
 		}
 		memset(ss, 0, sizeof(struct us_data));
 		new_device = 1;
@@ -1088,8 +1089,9 @@
 	printk(KERN_DEBUG 
 	       "USB Mass Storage device found at %d\n", dev->devnum);
 
-	/* return a pointer for the disconnect function */
-	return ss;
+	/* save a pointer to our structure */
+	intf->dev.driver_data = ss;
+	return 0;
 
 	/* we come here if there are any problems */
 	/* ss->dev_semaphore must be locked */
@@ -1099,13 +1101,13 @@
 	up(&ss->dev_semaphore);
 	if (new_device)
 		kfree(ss);
-	return NULL;
+	return -EIO;
 }
 
 /* Handle a disconnect event from the USB core */
-static void storage_disconnect(struct usb_device *dev, void *ptr)
+static void storage_disconnect(struct usb_interface *intf)
 {
-	struct us_data *ss = ptr;
+	struct us_data *ss = intf->dev.driver_data;
 
 	US_DEBUGP("storage_disconnect() called\n");
 
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Thu Aug 22 13:39:15 2002
+++ b/fs/partitions/check.c	Thu Aug 22 13:39:15 2002
@@ -175,14 +175,14 @@
 	kdev.value=(int)(long)driverfs_dev->driver_data;
 	return off ? 0 : sprintf (page, "%x\n",kdev.value);
 }
-static DEVICE_ATTR(kdev,"kdev",S_IRUGO,partition_device_kdev_read,NULL);
+static DEVICE_ATTR(kdev,S_IRUGO,partition_device_kdev_read,NULL);
 
 static ssize_t partition_device_type_read(struct device *driverfs_dev, 
 			char *page, size_t count, loff_t off) 
 {
 	return off ? 0 : sprintf (page, "BLK\n");
 }
-static DEVICE_ATTR(type,"type",S_IRUGO,partition_device_type_read,NULL);
+static DEVICE_ATTR(type,S_IRUGO,partition_device_type_read,NULL);
 
 void driverfs_create_partitions(struct gendisk *hd, int minor)
 {
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu Aug 22 13:39:15 2002
+++ b/include/linux/device.h	Thu Aug 22 13:39:15 2002
@@ -93,9 +93,9 @@
 	ssize_t (*store)(struct bus_type *, const char * buf, size_t count, loff_t off);
 };
 
-#define BUS_ATTR(_name,_str,_mode,_show,_store)	\
+#define BUS_ATTR(_name,_mode,_show,_store)	\
 struct bus_attribute bus_attr_##_name = { 		\
-	.attr = {.name	= _str,	.mode	= _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
@@ -150,9 +150,9 @@
 	ssize_t (*store)(struct device_driver *, const char * buf, size_t count, loff_t off);
 };
 
-#define DRIVER_ATTR(_name,_str,_mode,_show,_store)	\
+#define DRIVER_ATTR(_name,_mode,_show,_store)	\
 struct driver_attribute driver_attr_##_name = { 		\
-	.attr = {.name	= _str,	.mode	= _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
@@ -222,13 +222,14 @@
 	ssize_t (*store)(struct device * dev, const char * buf, size_t count, loff_t off);
 };
 
-#define DEVICE_ATTR(_name,_str,_mode,_show,_store)	\
+#define DEVICE_ATTR(_name,_mode,_show,_store) \
 struct device_attribute dev_attr_##_name = { 		\
-	.attr = {.name	= _str,	.mode	= _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
 
+
 extern int device_create_file(struct device *device, struct device_attribute * entry);
 extern void device_remove_file(struct device * dev, struct device_attribute * attr);
 
@@ -260,12 +261,7 @@
  * get_device - atomically increment the reference count for the device.
  *
  */
-static inline void get_device(struct device * dev)
-{
-	BUG_ON(!atomic_read(&dev->refcount));
-	atomic_inc(&dev->refcount);
-}
-
+extern struct device * get_device(struct device * dev);
 extern void put_device(struct device * dev);
 
 /* drivers/base/sys.c */
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	Thu Aug 22 13:39:15 2002
+++ b/include/linux/usb.h	Thu Aug 22 13:39:15 2002
@@ -227,7 +227,7 @@
 	int act_altsetting;		/* active alternate setting */
 	int num_altsetting;		/* number of alternate settings */
 	int max_altsetting;		/* total memory allocated */
- 
+
 	struct usb_driver *driver;	/* driver */
 	struct device dev;		/* interface specific device info */
 	void *private_data;
@@ -291,6 +291,8 @@
 	__usb_get_extra_descriptor((ifpoint)->extra,(ifpoint)->extralen,\
 		type,(void**)ptr)
 
+extern int usb_if_to_ifnum(struct usb_interface *iface);
+	
 /* -------------------------------------------------------------------------- */
 
 /* Host Controller Driver (HCD) support */
@@ -399,9 +401,6 @@
 extern void usb_free_dev(struct usb_device *);
 #define usb_put_dev usb_free_dev
 
-/* for when layers above USB add new non-USB drivers */
-extern void usb_scan_devices(void);
-
 /* mostly for devices emulating SCSI over USB */
 extern int usb_reset_device(struct usb_device *dev);
 
@@ -645,6 +644,11 @@
 	struct module *owner;
 	const char *name;
 
+	int	(*new_probe)	(struct usb_interface *intf, const struct usb_device_id *id);
+	void	(*new_disco)	(struct usb_interface *intf);
+
+	struct device_driver driver;
+
 	void *(*probe)(
 	    struct usb_device *dev,		/* the device */
 	    unsigned intf,			/* what interface */
@@ -655,7 +659,6 @@
 	    void *handle			/* as returned by probe() */
 	    );
 
-	struct list_head driver_list;
 	struct semaphore serialize;
 
 	/* ioctl -- userspace apps can talk to drivers through usbfs */
@@ -669,6 +672,7 @@
 	/* void (*suspend)(struct usb_device *dev); */
 	/* void (*resume)(struct usb_device *dev); */
 };
+#define	to_usb_driver(d) container_of(d, struct usb_driver, driver)
 
 extern struct bus_type usb_bus_type;
 
