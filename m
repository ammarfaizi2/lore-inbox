Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbUKDHpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbUKDHpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbUKDHpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:45:18 -0500
Received: from [211.58.254.17] ([211.58.254.17]:8616 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262119AbUKDHoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:44:37 -0500
Date: Thu, 4 Nov 2004 16:44:35 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 1/4] driver-model: sysctl node dev.autoattach
Message-ID: <20041104074435.GH25567@home-tj.org>
References: <20041104074330.GG25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104074330.GG25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ma_01_sysctl_dev_autoattach.patch

 This patch implements sysctl node dev.autoattach.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/bus.c
===================================================================
--- linux-export.orig/drivers/base/bus.c	2004-11-04 11:04:13.000000000 +0900
+++ linux-export/drivers/base/bus.c	2004-11-04 11:04:14.000000000 +0900
@@ -17,6 +17,12 @@
 #include "base.h"
 #include "power/power.h"
 
+int dev_autoattach = 1, dev_autoattach_min = 0, dev_autoattach_max = 2;
+
+static LIST_HEAD(all_buses);
+static spinlock_t all_buses_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_MUTEX(all_buses_traverse_mutex);
+
 #define to_dev(node) container_of(node, struct device, bus_list)
 #define to_drv(node) container_of(node, struct device_driver, kobj.entry)
 
@@ -329,7 +335,7 @@ int device_attach(struct device * dev)
 		return 1;
 	}
 
-	if (bus->match) {
+	if (dev_autoattach && bus->match) {
 		list_for_each(entry, &bus->drivers.list) {
 			struct device_driver * drv = to_drv(entry);
 			error = driver_probe_device(drv, dev);
@@ -366,7 +372,7 @@ void driver_attach(struct device_driver 
 	struct list_head * entry;
 	int error;
 
-	if (!bus->match)
+	if (!dev_autoattach || !bus->match)
 		return;
 
 	list_for_each(entry, &bus->devices.list) {
@@ -723,6 +729,10 @@ int bus_register(struct bus_type * bus)
 		goto bus_drivers_fail;
 	bus_add_attrs(bus);
 
+	spin_lock(&all_buses_lock);
+	list_add_tail(&bus->node, &all_buses);
+	spin_unlock(&all_buses_lock);
+
 	pr_debug("bus type '%s' registered\n", bus->name);
 	return 0;
 
@@ -745,12 +755,61 @@ out:
 void bus_unregister(struct bus_type * bus)
 {
 	pr_debug("bus %s: unregistering\n", bus->name);
+
+	spin_lock(&all_buses_lock);
+	list_del(&bus->node);
+	spin_unlock(&all_buses_lock);
+
 	bus_remove_attrs(bus);
 	kset_unregister(&bus->drivers);
 	kset_unregister(&bus->devices);
 	subsystem_unregister(&bus->subsys);
 }
 
+
+/**
+ *	dev_autoattach_handler - proc_handler for sysctl node dev.autoattach
+ */
+int dev_autoattach_handler(ctl_table *table, int write, struct file *filp,
+			   void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, filp, buffer, lenp, ppos);
+
+	down(&all_buses_traverse_mutex);
+
+	if (dev_autoattach == 2) {
+		struct list_head marker;
+
+		spin_lock(&all_buses_lock);
+		list_add(&marker, &all_buses);
+		while (marker.next != &all_buses) {
+			struct bus_type *bus;
+			bus = container_of(marker.next, struct bus_type, node);
+			if (!(bus = get_bus(bus)))
+				continue;
+			/* Okay, we have the next bus, move it ahead
+			   of the marker and perform rescan. */
+			list_del(&bus->node);
+			list_add_tail(&bus->node, &marker);
+			spin_unlock(&all_buses_lock);
+
+			bus_rescan_devices(bus);
+
+			put_bus(bus);
+			spin_lock(&all_buses_lock);
+		}
+		list_del(&marker);
+		spin_unlock(&all_buses_lock);
+		dev_autoattach = 1;
+	}
+
+	up(&all_buses_traverse_mutex);
+
+	return ret;
+}
+
 int __init buses_init(void)
 {
 	return subsystem_register(&bus_subsys);
Index: linux-export/include/linux/device.h
===================================================================
--- linux-export.orig/include/linux/device.h	2004-11-04 11:04:12.000000000 +0900
+++ linux-export/include/linux/device.h	2004-11-04 11:04:14.000000000 +0900
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/deviceparam.h>
+#include <linux/sysctl.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -54,6 +55,7 @@ struct bus_type {
 	struct subsystem	subsys;
 	struct kset		drivers;
 	struct kset		devices;
+	struct list_head	node;
 
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
@@ -414,6 +416,12 @@ extern void device_shutdown(void);
 extern int firmware_register(struct subsystem *);
 extern void firmware_unregister(struct subsystem *);
 
+/* dev.autoattach sysctl node */
+extern int dev_autoattach, dev_autoattach_min, dev_autoattach_max;
+extern int dev_autoattach_handler(ctl_table *table, int write,
+				  struct file *filp, void __user *buffer,
+				  size_t *lenp, loff_t *ppos);
+
 /* debugging and troubleshooting/diagnostic helpers. */
 #define dev_printk(level, dev, format, arg...)	\
 	printk(level "%s %s: " format , (dev)->driver ? (dev)->driver->name : "" , (dev)->bus_id , ## arg)
Index: linux-export/include/linux/sysctl.h
===================================================================
--- linux-export.orig/include/linux/sysctl.h	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/include/linux/sysctl.h	2004-11-04 11:04:14.000000000 +0900
@@ -691,6 +691,7 @@ enum {
 	DEV_RAID=4,
 	DEV_MAC_HID=5,
 	DEV_SCSI=6,
+	DEV_AUTOATTACH=7,
 };
 
 /* /proc/sys/dev/cdrom */
Index: linux-export/kernel/sysctl.c
===================================================================
--- linux-export.orig/kernel/sysctl.c	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/kernel/sysctl.c	2004-11-04 11:04:14.000000000 +0900
@@ -41,6 +41,7 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -936,6 +937,16 @@ static ctl_table debug_table[] = {
 };
 
 static ctl_table dev_table[] = {
+	{
+		.ctl_name	= DEV_AUTOATTACH,
+		.procname	= "autoattach",
+		.data		= &dev_autoattach,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &dev_autoattach_handler,
+		.extra1		= &dev_autoattach_min,
+		.extra2		= &dev_autoattach_max,
+	},
 	{ .ctl_name = 0 }
 };  
 
