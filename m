Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUHIKok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUHIKok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUHIKok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:44:40 -0400
Received: from digitalimplant.org ([64.62.235.95]:34212 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266465AbUHIKn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:43:57 -0400
Date: Mon, 9 Aug 2004 03:43:50 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz, "" <benh@kernel.crashing.org>, "" <david-b@pacbell.net>
Subject: [RFC] Fix Device Power Management States
Message-ID: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the patch below attempts to fix up the device power management
handling, taking into account (hopefully) everything that has been said
over the last week+, and lessons learned over the years. It's only been
compile-tested, and is meant just to prove that the framework is possible.
There are likely to be some missing pieces, mainly because it's late. :)

The highlights are that it adds:

- To struct class:

	int     (*dev_start)(struct class_device * dev);
	int     (*dev_stop)(struct class_device * dev);

- ->dev_stop() and ->dev_start() to struct class
  This provides the framework to shutdown a device from a functional
  level, rather than at a hardware level, as well as the entry points
  to stop/start ALL devices in the system.

  This is implemented by iterating through the list of struct classes,
  then through each of their struct class_device's. The class_device is
  the only argument to those functions.


- To struct bus_type:
	int             (*pm_save)(struct device *, struct pm_state *);
	int             (*pm_restore)(struct device *);

  These methods provide the interface for saving and restoring low-
  level device state only. The intent is to remove the callbacks from
  struct device_driver, and unconditionally call through the bus. (That's
  what all buses with drivers that implement those functions do today.)

  The methods are called for each device in the global device list, in
  a reverse order (so children are saved before parents).

- To struct bus_type:

	int             (*pm_power)(struct device *, struct pm_state *);

  This method is used to do all power transitions, including both
  shutdown/reset and device power management states.


The 2nd argument to ->pm_save() and ->pm_power() is determined by mapping
an enumerated system power state to a static array of 'struct pm_state'
pointers, that is in dev->power.pm_system. The pointers in that array
point to entries in dev->power.pm_supports, which is an array of all the
device power states that device supports. Please see include/linux/pm.h in
the patch below. These arrays should be initialized by the bus, though
they can be fixed up by the individual drivers, should they have a
different set of states they support, or given user policy.

The actual value of the 'struct pm_state' instances is driver-specific,
though again, the bus drivers should provide the set of power states valid
for that bus. For example:


struct pm_state {
        char    * name;
        u32     state;
};

#define decl_state(n, s) \
        struct pm_state pm_state_##n = {        \
                .name   = __stringify(n),       \
                .state  = s,                    \
        }

drivers/pci/ should do:

decl_state(d0, PCI_PM_CAP_PME_D0);
EXPORT_SYMBOL(pm_state_d0);

decl_state(d1, PCI_PM_CAP_PME_D1);
EXPORT_SYMBOL(pm_state_d1);

decl_state(d2, PCI_PM_CAP_PME_D2);
EXPORT_SYMBOL(pm_state_d2);

decl_state(d3, PCI_PM_CAP_PME_D3);
EXPORT_SYMBOL(pm_state_d3);


This provides a meaningful tag to each state that is completely local to
the bus, but can be handled easily by the core.

To handle runtime power management, a set of sysfs files will be created,
inclding 'current' and 'supports'. The latter will display all the
possible states the device supports, as specified its ->power.pm_supports
array, in an attractive string format. 'current' will display the current
power state, as an ASCII string. Writing to this file will look up the
state requested in ->pm_supports, and if found, translate that into the
device-specific power state and suspend the device.

The patches to implement that, as well as initial PCI support and system
power support, will hopefuly eek out in the next week..

Thanks,


	Pat

===== drivers/base/class.c 1.51 vs edited =====
--- 1.51/drivers/base/class.c	2004-06-10 02:35:56 -07:00
+++ edited/drivers/base/class.c	2004-08-09 01:04:23 -07:00
@@ -69,7 +69,7 @@
 };

 /* Hotplug events for classes go to the class_obj subsys */
-static decl_subsys(class, &ktype_class, NULL);
+decl_subsys(class, &ktype_class, NULL);


 int class_create_file(struct class * cls, const struct class_attribute * attr)
===== drivers/base/core.c 1.86 vs edited =====
--- 1.86/drivers/base/core.c	2004-07-07 17:55:49 -07:00
+++ edited/drivers/base/core.c	2004-08-09 02:35:03 -07:00
@@ -19,7 +19,6 @@
 #include <asm/semaphore.h>

 #include "base.h"
-#include "power/power.h"

 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
@@ -227,8 +226,6 @@

 	if ((error = kobject_add(&dev->kobj)))
 		goto Error;
-	if ((error = device_pm_add(dev)))
-		goto PMError;
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	down_write(&devices_subsys.rwsem);
@@ -243,8 +240,6 @@
 	put_device(dev);
 	return error;
  BusError:
-	device_pm_remove(dev);
- PMError:
 	kobject_del(&dev->kobj);
  Error:
 	if (parent)
@@ -326,7 +321,6 @@
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
 	bus_remove_device(dev);
-	device_pm_remove(dev);
 	kobject_del(&dev->kobj);
 	if (parent)
 		put_device(parent);
===== drivers/base/power/Makefile 1.6 vs edited =====
--- 1.6/drivers/base/power/Makefile	2004-03-09 14:25:37 -08:00
+++ edited/drivers/base/power/Makefile	2004-08-09 02:33:17 -07:00
@@ -1,5 +1,5 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o
+obj-$(CONFIG_PM)	+= class.o state.o

 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
===== drivers/base/power/class.c 1.2 vs edited =====
--- 1.2/drivers/base/power/class.c	2004-08-09 01:00:35 -07:00
+++ edited/drivers/base/power/class.c	2004-08-09 01:37:10 -07:00
@@ -0,0 +1,160 @@
+/*
+ *	drivers/base/power/class.c - Class-based device power management
+ *
+ *
+ * Class power management provides the ability to stop/start a device from a
+ * functional point of view. By doing this at a high level, we can be sure that
+ * no processes are touching the hardware, so we can be free to save its state
+ * and power it down (or vice versa).
+ *
+ *
+ * Class power management relies on the class implementing two methods:
+ *
+ * int (*dev_stop)(struct class_device *);
+ *
+ *	Quiesce the device. Finish, stop and/or prevent any future transactions
+ *	from being passed to the device. Prevent it from obtaining any new
+ *	connections, etc.
+ *
+ * int (*dev_start)(struct class_device *);
+ *
+ * 	Start the device. Restart any stopped transactions. Add it back to
+ *	various queues. Make it available for future use.
+ *
+ * Both methods are called with interrupts enabled, and the class is free to
+ * sleep. It should be noted, however, that during a system suspend transition,
+ * the order in which devices are suspended is not guaranteed. So, all swap
+ * devices could be stopped before any given device is, making it impossible
+ * to allocate large amounts of memory.
+ *
+ *
+ * These methods may be called either during a suspend transition or during a
+ * runtime device power transition for a particular device. The implementation
+ * of these methods should not depend on which it is, and is not passed that
+ * information.
+ */
+
+#define PM_DEBUG
+#ifdef PM_DEBUG
+#define DEBUG
+#endif
+
+#include <linux/device.h>
+
+
+extern struct subsystem class_subsys;
+
+int class_dev_stop(struct class_device * dev)
+{
+	int error = 0;
+
+	pr_debug("\t\t%s\n",dev->class_id);
+	if (dev->running) {
+		error = dev->class->dev_stop(dev);
+		if (!error)
+			dev->running = 0;
+	}
+	return error;
+}
+
+
+int class_dev_start(struct class_device * dev)
+{
+	int error = 0;
+
+	pr_debug("\t\t%s\n",dev->class_id);
+	if (!dev->running) {
+		error = dev->class->dev_start(dev);
+		if (!error)
+			dev->running = 1;
+	}
+	return 0;
+}
+
+
+static int __class_start(struct class * cls, struct class_device * cd)
+{
+	struct list_head * head = &cls->children;
+	int error = 0;
+
+	pr_debug("\t%s\n",cls->name);
+	cd = list_prepare_entry(cd, head, kobj.entry);
+	list_for_each_entry_continue(cd, head, kobj.entry) {
+		error = class_dev_start(cd);
+		if (error)
+			break;
+	}
+	return error;
+}
+
+static int class_start(struct class * cls)
+{
+	int error;
+
+	down_read(&cls->subsys.rwsem);
+	error = __class_start(cls, NULL);
+	up_read(&cls->subsys.rwsem);
+	return error;
+}
+
+static int class_stop(struct class * cls)
+{
+	struct class_device * cd;
+	int error = 0;
+
+	pr_debug("\t%s\n",cls->name);
+
+	down_read(&cls->subsys.rwsem);
+	list_for_each_entry(cd, &cls->children, kobj.entry) {
+		error = class_dev_stop(cd);
+		if (error) {
+			__class_start(cls, cd);
+			break;
+		}
+	}
+	up_read(&cls->subsys.rwsem);
+	return error;
+}
+
+
+static int __device_start(struct class * cls)
+{
+	int error = 0;
+	struct list_head * head = &class_subsys.kset.list;
+
+	cls = list_prepare_entry(cls, head, subsys.kset.kobj.entry);
+	list_for_each_entry_continue(cls, head, subsys.kset.kobj.entry) {
+		if ((error = class_start(cls)))
+			break;
+	}
+	return error;
+}
+
+int device_start(void)
+{
+	int error;
+
+	pr_debug("Starting Classes:\n");
+	down_read(&class_subsys.rwsem);
+	error = __device_start(NULL);
+	down_write(&class_subsys.rwsem);
+	return error;
+}
+
+int device_stop(void)
+{
+	int error = 0;
+	struct class * cls;
+
+	pr_debug("Stopping Classes:\n");
+	down_read(&class_subsys.rwsem);
+	list_for_each_entry_reverse(cls, &class_subsys.kset.list, subsys.kset.kobj.entry) {
+		error = class_stop(cls);
+		if (error) {
+			__device_start(cls);
+			break;
+		}
+	}
+	up_read(&class_subsys.rwsem);
+	return error;
+}
===== drivers/base/power/power.c 1.1 vs edited =====
--- 1.1/drivers/base/power/power.c	2004-08-09 02:33:57 -07:00
+++ edited/drivers/base/power/power.c	2004-08-09 02:59:30 -07:00
@@ -0,0 +1,75 @@
+/*
+ *	drivers/base/power.c - low-level power management
+ *
+ *
+ */
+
+#include <linux/device.h>
+
+extern struct subsystem devices_subsys;
+
+
+
+int device_power_dev(struct device * dev, struct pm_state * state)
+{
+	int error;
+
+	if (!state)
+		return 0;
+	if (dev->power.pm_current == state)
+		return 0;
+	error = dev->bus->pm_power(dev, state);
+	if (!error)
+		dev->power.pm_current = state;
+	return error;
+}
+
+int device_power_default(struct device * dev)
+{
+	return device_power_dev(dev, dev->power.pm_default);
+}
+
+static int __device_power_up(struct device * dev)
+{
+	struct list_head * head = &devices_subsys.kset.list;
+	struct pm_state * state;
+	int error = 0;
+
+	dev = list_prepare_entry(dev, head, kobj.entry);
+
+	list_for_each_entry_continue(dev, head, kobj.entry) {
+		state = dev->power.pm_resume;
+		if ((error = device_power_dev(dev, state)))
+			break;
+	}
+	return error;
+}
+
+
+int device_power_up(void)
+{
+	int error;
+	down_read(&devices_subsys.rwsem);
+	error = __device_power_up(NULL);
+	up_read(&devices_subsys.rwsem);
+	return error;
+}
+
+int device_power_down(u32 sys_state)
+{
+	struct device * dev;
+	struct pm_state * state;
+	int error = 0;
+
+	down_read(&devices_subsys.rwsem);
+	list_for_each_entry_reverse(dev, &devices_subsys.kset.list, entry) {
+		state = dev->power.pm_system[sys_state];
+		error = device_power_dev(dev, state);
+		if (error) {
+			__device_power_up(dev);
+			break;
+		}
+	}
+	up_read(&devices_subsys.rwsem);
+	return error;
+}
===== drivers/base/power/power.h 1.7 vs edited =====
--- 1.7/drivers/base/power/power.h	2004-06-09 23:34:24 -07:00
+++ edited/drivers/base/power/power.h	2004-08-09 02:42:53 -07:00
@@ -34,17 +34,6 @@
 extern struct list_head dpm_off;
 extern struct list_head dpm_off_irq;

-
-static inline struct dev_pm_info * to_pm_info(struct list_head * entry)
-{
-	return container_of(entry, struct dev_pm_info, entry);
-}
-
-static inline struct device * to_device(struct list_head * entry)
-{
-	return container_of(to_pm_info(entry), struct device, power);
-}
-
 extern int device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);

@@ -99,3 +88,13 @@
 }

 #endif
+
+extern int class_dev_stop(struct class_device *);
+extern int class_dev_start(struct class_device *);
+
+extern int device_save_dev(struct device *, struct pm_state *);
+extern int device_restore_dev(struct device *, struct pm_state *);
+
+extern int device_power_dev(struct device *, struct pm_state *);
+extern int device_power_default(struct device *);
+
===== drivers/base/power/shutdown.c 1.32 vs edited =====
--- 1.32/drivers/base/power/shutdown.c	2004-06-09 23:34:24 -07:00
+++ edited/drivers/base/power/shutdown.c	2004-08-09 02:51:17 -07:00
@@ -21,15 +21,7 @@

 int device_detach_shutdown(struct device * dev)
 {
-	if (!dev->detach_state)
-		return 0;
-
-	if (dev->detach_state == DEVICE_PM_OFF) {
-		if (dev->driver && dev->driver->shutdown)
-			dev->driver->shutdown(dev);
-		return 0;
-	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	return device_power_default(dev);
 }


@@ -49,19 +41,7 @@
  */
 void device_shutdown(void)
 {
-	struct device * dev;
-
-	down_write(&devices_subsys.rwsem);
-	list_for_each_entry_reverse(dev, &devices_subsys.kset.list, kobj.entry) {
-		pr_debug("shutting down %s: ", dev->bus_id);
-		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("Ok\n");
-			dev->driver->shutdown(dev);
-		} else
-			pr_debug("Ignored.\n");
-	}
-	up_write(&devices_subsys.rwsem);
-
+	device_power_down(pm_sys_SHUTDOWN);
 	sysdev_shutdown();
 }

===== drivers/base/power/state.c 1.1 vs edited =====
--- 1.1/drivers/base/power/state.c	2004-08-09 01:38:01 -07:00
+++ edited/drivers/base/power/state.c	2004-08-09 02:55:03 -07:00
@@ -0,0 +1,100 @@
+/*
+ *	drivers/base/power/state.c - Device state management
+ *
+ *
+ * When devices are suspended, either during runtime or during a system
+ * state transition, its driver must save a certain amount of state to be
+ * restored at a later time. This file implements the top-level functions
+ * to provide that service.
+ *
+ * We rely on the buses implementing two methods to accomplish this:
+ *
+ * int (*pm_save)(struct device * dev, u32 state);
+ *
+ *	Allocate memory and copy register state to it. The second parameter
+ *	specifies what state the device is going to enter, so the drivers
+ *	know how much state to save.
+ *
+ *
+ * int (*pm_restore)(struct device * dev);
+ *
+ *	Restore the device to the state saved with ->pm_save() and free memory
+ *	previously allocated. The drivers should check dev->power.prev_state
+ *	to determine what state the device was previously in.
+ *
+ *
+ * These functions are called with interrupts enabled, and the drivers are free
+ * to allocate memory to save device state. However, it's important to note that
+ * in the case of a system power state transition, no devices will be active
+ * during these calls, meaning no swap devices will be able to reclaim memory
+ * if there is little left.
+ *
+ */
+
+#include <linux/device.h>
+
+extern struct subsystem devices_subsys;
+
+int device_save_dev(struct device * dev, struct pm_state * state)
+{
+	return dev->bus->pm_save(dev, state);
+}
+
+
+int device_restore_dev(struct device * dev)
+{
+	return dev->bus->pm_restore(dev);
+}
+
+
+
+static int __device_restore(struct device * dev, u32 sys_state)
+{
+	struct list_head * head = &devices_subsys.kset.list;
+	int error = 0;
+
+	dev = list_prepare_entry(dev, head, kobj.entry);
+
+	list_for_each_entry_continue(dev, head, kobj.entry) {
+		if ((error = device_restore_dev(dev)))
+			break;
+	}
+	return error;
+}
+
+int device_restore(u32 sys_state)
+{
+	int error;
+
+	down_read(&devices_subsys.rwsem);
+	error = __device_restore(NULL, sys_state);
+	up_read(&devices_subsys.rwsem);
+	return error;
+}
+
+
+int device_save(u32 sys_state)
+{
+	int error = 0;
+	struct device * dev;
+	struct pm_state * state;
+
+	if (sys_state >= pm_sys_NUM)
+		return -EINVAL;
+
+	down_read(&devices_subsys.rwsem);
+	list_for_each_entry_reverse(dev, &devices_subsys.kset.list, kobj.entry) {
+		state = dev->power.pm_system[sys_state];
+		if (state && state != dev->power.pm_current) {
+			error = device_save_dev(dev, state);
+			if (!error)
+				dev->power.pm_resume = dev->power.pm_current;
+			else {
+				__device_restore(dev, sys_state);
+				break;
+			}
+		}
+	}
+	up_read(&devices_subsys.rwsem);
+	return error;
+}
===== include/linux/device.h 1.128 vs edited =====
--- 1.128/include/linux/device.h	2004-07-07 17:56:21 -07:00
+++ edited/include/linux/device.h	2004-08-09 02:44:19 -07:00
@@ -64,6 +64,10 @@
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
+
+	int		(*pm_save)(struct device *, struct pm_state *);
+	int		(*pm_restore)(struct device *);
+	int		(*pm_power)(struct device *, struct pm_state *);
 };

 extern int bus_register(struct bus_type * bus);
@@ -156,6 +160,9 @@

 	void	(*release)(struct class_device *dev);
 	void	(*class_release)(struct class *class);
+
+	int	(*dev_start)(struct class_device * dev);
+	int	(*dev_stop)(struct class_device * dev);
 };

 extern int class_register(struct class *);
@@ -187,6 +194,7 @@
 	void			* class_data;	/* class-specific data */

 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
+	int	running;		/* device is active or not */
 };

 static inline void *
===== include/linux/pm.h 1.16 vs edited =====
--- 1.16/include/linux/pm.h	2004-07-01 22:23:53 -07:00
+++ edited/include/linux/pm.h	2004-08-09 02:58:59 -07:00
@@ -222,6 +222,28 @@
 extern int pm_suspend(u32 state);


+enum {
+	pm_sys_ON = 1,
+	pm_sys_SHUTDOWN,
+	pm_sys_RESET,
+	pm_sys_STANDBY,
+	pm_sys_SUSPEND,
+	pm_sys_HIBERNATE,
+	pm_sys_NUM,
+};
+
+
+struct pm_state {
+	char	* name;
+	u32	state;
+};
+
+#define decl_state(n, s) \
+	struct pm_state pm_state_##n = {	\
+		.name	= __stringify(n),	\
+		.state	= s,			\
+	}
+
 /*
  * Device power management
  */
@@ -229,22 +251,29 @@
 struct device;

 struct dev_pm_info {
-	u32			power_state;
-#ifdef	CONFIG_PM
-	u32			prev_state;
-	u8			* saved_state;
-	atomic_t		pm_users;
-	struct device		* pm_parent;
-	struct list_head	entry;
-#endif
+	struct pm_state	* pm_current;
+	struct pm_state	** pm_supports;
+	struct pm_state	* pm_default;
+	struct pm_state	* pm_resume;
+	struct pm_state	* pm_system[pm_sys_NUM];
 };

+
 extern void device_pm_set_parent(struct device * dev, struct device * parent);

 extern int device_suspend(u32 state);
-extern int device_power_down(u32 state);
-extern void device_power_up(void);
 extern void device_resume(void);
+
+
+extern int device_stop(void);
+extern int device_start(void);
+
+extern int device_save(u32 sys_state);
+extern int device_restore(u32 sys_state);
+
+extern int device_power_up(void);
+extern int device_power_down(u32 sys_state);
+


 #endif /* __KERNEL__ */
