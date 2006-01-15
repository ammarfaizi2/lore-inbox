Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWAOEiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWAOEiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 23:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWAOEiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 23:38:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55723 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751097AbWAOEiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 23:38:14 -0500
Date: Sun, 15 Jan 2006 05:38:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: 2.6.15-mm4: sem2mutex problem in USB OHCI
Message-ID: <20060115043826.GB23968@elte.hu>
References: <200601150058.58518.rjw@sisk.pl> <20060114160526.228da734.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114160526.228da734.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  Badness in __mutex_trylock_slowpath at kernel/mutex.c:281
> > 
> >  Call Trace: <IRQ> <ffffffff80148d8d>{mutex_trylock+141}
> >         <ffffffff880abaf0>{:ohci_hcd:ohci_hub_status_data+480}
> >         <ffffffff802d25d0>{rh_timer_func+0} <ffffffff802d24c3>{usb_hcd_poll_rh_status+67}

> err, taking a mutex from softirq context.

hm. For now, the patch below undoes the struct device ->mutex 
conversion.

	Ingo

--

undo struct device ->mutex conversion, the USB code uses it from softirq 
context.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/base/bus.c           |   16 ++++++++--------
 drivers/base/core.c          |    2 +-
 drivers/base/dd.c            |   36 ++++++++++++++++++------------------
 drivers/base/power/resume.c  |    4 ++--
 drivers/base/power/suspend.c |    4 ++--
 drivers/usb/core/hub.c       |    8 ++++----
 include/linux/device.h       |    2 +-
 include/linux/usb.h          |    6 +++---
 8 files changed, 39 insertions(+), 39 deletions(-)

Index: linux-2.6.15-mm4.q/drivers/base/bus.c
===================================================================
--- linux-2.6.15-mm4.q.orig/drivers/base/bus.c
+++ linux-2.6.15-mm4.q/drivers/base/bus.c
@@ -153,10 +153,10 @@ static ssize_t driver_unbind(struct devi
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
 	if (dev && dev->driver == drv) {
 		if (dev->parent)	/* Needed for USB */
-			mutex_lock(&dev->parent->mutex);
+			down(&dev->parent->sem);
 		device_release_driver(dev);
 		if (dev->parent)
-			mutex_unlock(&dev->parent->mutex);
+			up(&dev->parent->sem);
 		err = count;
 	}
 	put_device(dev);
@@ -180,12 +180,12 @@ static ssize_t driver_bind(struct device
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
 	if (dev && dev->driver == NULL) {
 		if (dev->parent)	/* Needed for USB */
-			mutex_lock(&dev->parent->mutex);
-		mutex_lock(&dev->mutex);
+			down(&dev->parent->sem);
+		down(&dev->sem);
 		err = driver_probe_device(drv, dev);
-		mutex_unlock(&dev->mutex);
+		up(&dev->sem);
 		if (dev->parent)
-			mutex_unlock(&dev->parent->mutex);
+			up(&dev->parent->sem);
 	}
 	put_device(dev);
 	put_bus(bus);
@@ -512,10 +512,10 @@ static int bus_rescan_devices_helper(str
 {
 	if (!dev->driver) {
 		if (dev->parent)	/* Needed for USB */
-			mutex_lock(&dev->parent->mutex);
+			down(&dev->parent->sem);
 		device_attach(dev);
 		if (dev->parent)
-			mutex_unlock(&dev->parent->mutex);
+			up(&dev->parent->sem);
 	}
 	return 0;
 }
Index: linux-2.6.15-mm4.q/drivers/base/core.c
===================================================================
--- linux-2.6.15-mm4.q.orig/drivers/base/core.c
+++ linux-2.6.15-mm4.q/drivers/base/core.c
@@ -231,7 +231,7 @@ void device_initialize(struct device *de
 	klist_init(&dev->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->dma_pools);
-	mutex_init(&dev->mutex);
+	init_MUTEX(&dev->sem);
 	device_init_wakeup(dev, 0);
 }
 
Index: linux-2.6.15-mm4.q/drivers/base/dd.c
===================================================================
--- linux-2.6.15-mm4.q.orig/drivers/base/dd.c
+++ linux-2.6.15-mm4.q/drivers/base/dd.c
@@ -36,7 +36,7 @@
  *	for before calling this. (It is ok to call with no other effort
  *	from a driver's probe() method.)
  *
- *	This function must be called with @dev->mutex held.
+ *	This function must be called with @dev->sem held.
  */
 void device_bind_driver(struct device * dev)
 {
@@ -65,8 +65,8 @@ void device_bind_driver(struct device * 
  *	This function returns 1 if a match is found, an error if one
  *	occurs (that is not -ENODEV or -ENXIO), and 0 otherwise.
  *
- *	This function must be called with @dev->mutex held.  When called
- *	for a USB interface, @dev->parent->mutex must be held as well.
+ *	This function must be called with @dev->sem held.  When called
+ *	for a USB interface, @dev->parent->sem must be held as well.
  */
 int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
@@ -131,19 +131,19 @@ static int __device_attach(struct device
  *	Returns 1 if the device was bound to a driver;
  *	0 if no matching device was found; error code otherwise.
  *
- *	When called for a USB interface, @dev->parent->mutex must be held.
+ *	When called for a USB interface, @dev->parent->sem must be held.
  */
 int device_attach(struct device * dev)
 {
 	int ret = 0;
 
-	mutex_lock(&dev->mutex);
+	down(&dev->sem);
 	if (dev->driver) {
 		device_bind_driver(dev);
 		ret = 1;
 	} else
 		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
-	mutex_unlock(&dev->mutex);
+	up(&dev->sem);
 	return ret;
 }
 
@@ -162,13 +162,13 @@ static int __driver_attach(struct device
 	 */
 
 	if (dev->parent)	/* Needed for USB */
-		mutex_lock(&dev->parent->mutex);
-	mutex_lock(&dev->mutex);
+		down(&dev->parent->sem);
+	down(&dev->sem);
 	if (!dev->driver)
 		driver_probe_device(drv, dev);
-	mutex_unlock(&dev->mutex);
+	up(&dev->sem);
 	if (dev->parent)
-		mutex_unlock(&dev->parent->mutex);
+		up(&dev->parent->sem);
 
 	return 0;
 }
@@ -193,8 +193,8 @@ void driver_attach(struct device_driver 
  *
  *	Manually detach device from driver.
  *
- *	__device_release_driver() must be called with @dev->mutex held.
- *	When called for a USB interface, @dev->parent->mutex must be held
+ *	__device_release_driver() must be called with @dev->sem held.
+ *	When called for a USB interface, @dev->parent->sem must be held
  *	as well.
  */
 
@@ -225,9 +225,9 @@ void device_release_driver(struct device
 	 * within their ->remove callback for the same device, they
 	 * will deadlock right here.
 	 */
-	mutex_lock(&dev->mutex);
+	down(&dev->sem);
 	__device_release_driver(dev);
-	mutex_unlock(&dev->mutex);
+	up(&dev->sem);
 }
 
 
@@ -251,13 +251,13 @@ void driver_detach(struct device_driver 
 		spin_unlock(&drv->klist_devices.k_lock);
 
 		if (dev->parent)	/* Needed for USB */
-			mutex_lock(&dev->parent->mutex);
-		mutex_lock(&dev->mutex);
+			down(&dev->parent->sem);
+		down(&dev->sem);
 		if (dev->driver == drv)
 			__device_release_driver(dev);
-		mutex_unlock(&dev->mutex);
+		up(&dev->sem);
 		if (dev->parent)
-			mutex_unlock(&dev->parent->mutex);
+			up(&dev->parent->sem);
 		put_device(dev);
 	}
 }
Index: linux-2.6.15-mm4.q/drivers/base/power/resume.c
===================================================================
--- linux-2.6.15-mm4.q.orig/drivers/base/power/resume.c
+++ linux-2.6.15-mm4.q/drivers/base/power/resume.c
@@ -24,7 +24,7 @@ int resume_device(struct device * dev)
 {
 	int error = 0;
 
-	mutex_lock(&dev->mutex);
+	down(&dev->sem);
 	if (dev->power.pm_parent
 			&& dev->power.pm_parent->power.power_state.event) {
 		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
@@ -36,7 +36,7 @@ int resume_device(struct device * dev)
 		dev_dbg(dev,"resuming\n");
 		error = dev->bus->resume(dev);
 	}
-	mutex_unlock(&dev->mutex);
+	up(&dev->sem);
 	return error;
 }
 
Index: linux-2.6.15-mm4.q/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.15-mm4.q.orig/drivers/base/power/suspend.c
+++ linux-2.6.15-mm4.q/drivers/base/power/suspend.c
@@ -39,7 +39,7 @@ int suspend_device(struct device * dev, 
 {
 	int error = 0;
 
-	mutex_lock(&dev->mutex);
+	down(&dev->sem);
 	if (dev->power.power_state.event) {
 		dev_dbg(dev, "PM: suspend %d-->%d\n",
 			dev->power.power_state.event, state.event);
@@ -59,7 +59,7 @@ int suspend_device(struct device * dev, 
 		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
 	}
-	mutex_unlock(&dev->mutex);
+	up(&dev->sem);
 	return error;
 }
 
Index: linux-2.6.15-mm4.q/drivers/usb/core/hub.c
===================================================================
--- linux-2.6.15-mm4.q.orig/drivers/usb/core/hub.c
+++ linux-2.6.15-mm4.q/drivers/usb/core/hub.c
@@ -33,8 +33,8 @@
 #include "hub.h"
 
 /* Protect struct usb_device->state and ->children members
- * Note: Both are also protected by ->dev.mutex, except that ->state can
- * change to USB_STATE_NOTATTACHED even when the mutex isn't held. */
+ * Note: Both are also protected by ->dev.sem, except that ->state can
+ * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
 static DEFINE_SPINLOCK(device_state_lock);
 
 /* khubd's worklist and its lock */
@@ -1786,9 +1786,9 @@ static int finish_device_resume(struct u
 			struct device *dev =
 					&udev->actconfig->interface[i]->dev;
 
-			mutex_lock(&dev->mutex);
+			down(&dev->sem);
 			(void) resume(dev);
-			mutex_unlock(&dev->mutex);
+			up(&dev->sem);
 		}
 		status = 0;
 
Index: linux-2.6.15-mm4.q/include/linux/device.h
===================================================================
--- linux-2.6.15-mm4.q.orig/include/linux/device.h
+++ linux-2.6.15-mm4.q/include/linux/device.h
@@ -314,7 +314,7 @@ struct device {
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 	struct device_attribute uevent_attr;
 
-	struct mutex		mutex;	/* semaphore to synchronize calls to
+	struct semaphore	sem;	/* semaphore to synchronize calls to
 					 * its driver.
 					 */
 
Index: linux-2.6.15-mm4.q/include/linux/usb.h
===================================================================
--- linux-2.6.15-mm4.q.orig/include/linux/usb.h
+++ linux-2.6.15-mm4.q/include/linux/usb.h
@@ -379,9 +379,9 @@ extern struct usb_device *usb_get_dev(st
 extern void usb_put_dev(struct usb_device *dev);
 
 /* USB device locking */
-#define usb_lock_device(udev)		mutex_lock(&(udev)->dev.mutex)
-#define usb_unlock_device(udev)		mutex_unlock(&(udev)->dev.mutex)
-#define usb_trylock_device(udev)	mutex_trylock(&(udev)->dev.mutex)
+#define usb_lock_device(udev)		down(&(udev)->dev.sem)
+#define usb_unlock_device(udev)		up(&(udev)->dev.sem)
+#define usb_trylock_device(udev)	down_trylock(&(udev)->dev.sem)
 extern int usb_lock_device_for_reset(struct usb_device *udev,
 		struct usb_interface *iface);
 
