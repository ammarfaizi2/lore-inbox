Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVARALM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVARALM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVARAKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:10:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54146 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261522AbVARAIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:08:15 -0500
Date: Mon, 17 Jan 2005 16:07:29 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Message-ID: <20050118000729.GA30597@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject [RFC] sysdev: change locking to use a class based spinlock
Reply-To: 

Here's another patch in my steps of removing the use of the subsystem
rwsem lock.  I've converted the sysdev subsystem here to use a spinlock
(instead of a semaphore, like my previous class patch did, I'll go
change that later too.)

The patch is against 2.6.11-rc1.  Any comments would be appreciated.

thanks,

greg k-h

-------
sysdev: change locking to use a class based spinlock

Use the new lock, and not the global subsystem lock.  This is a step in
removing the rwsem from subsystems, and should allow sysdevs to now be
able to add and remove themselves from within their function callbacks.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


--- 1.28/drivers/base/sys.c	2004-10-20 09:47:44 -07:00
+++ edited/drivers/base/sys.c	2005-01-17 15:37:06 -08:00
@@ -79,13 +79,14 @@ EXPORT_SYMBOL_GPL(sysdev_remove_file);
 /*
  * declare system_subsys
  */
-decl_subsys(system, &ktype_sysdev, NULL);
+static decl_subsys(system, &ktype_sysdev, NULL);
 
 int sysdev_class_register(struct sysdev_class * cls)
 {
 	pr_debug("Registering sysdev class '%s'\n",
 		 kobject_name(&cls->kset.kobj));
 	INIT_LIST_HEAD(&cls->drivers);
+	spin_lock_init(&cls->lock);
 	cls->kset.subsys = &system_subsys;
 	kset_set_kset_s(cls, system_subsys);
 	return kset_register(&cls->kset);
@@ -103,6 +104,7 @@ EXPORT_SYMBOL_GPL(sysdev_class_unregiste
 
 
 static LIST_HEAD(global_drivers);
+static DEFINE_SPINLOCK(global_drivers_lock);
 
 /**
  *	sysdev_driver_register - Register auxillary driver
@@ -119,19 +121,22 @@ static LIST_HEAD(global_drivers);
 int sysdev_driver_register(struct sysdev_class * cls,
 			   struct sysdev_driver * drv)
 {
-	down_write(&system_subsys.rwsem);
 	if (cls && kset_get(&cls->kset)) {
+		spin_lock(&cls->lock);
 		list_add_tail(&drv->entry, &cls->drivers);
+		spin_unlock(&cls->lock);
 
 		/* If devices of this class already exist, tell the driver */
 		if (drv->add) {
-			struct sys_device *dev;
-			list_for_each_entry(dev, &cls->kset.list, kobj.entry)
+			struct sys_device *dev, *temp;
+			list_for_each_entry_safe(dev, temp, &cls->kset.list, kobj.entry)
 				drv->add(dev);
 		}
-	} else
+	} else {
+		spin_lock(&global_drivers_lock);
 		list_add_tail(&drv->entry, &global_drivers);
-	up_write(&system_subsys.rwsem);
+		spin_unlock(&global_drivers_lock);
+	}
 	return 0;
 }
 
@@ -144,17 +149,21 @@ int sysdev_driver_register(struct sysdev
 void sysdev_driver_unregister(struct sysdev_class * cls,
 			      struct sysdev_driver * drv)
 {
-	down_write(&system_subsys.rwsem);
+	/* we don't know which list the drv is on, so lock both of them */
+	spin_lock(&cls->lock);
+	spin_lock(&global_drivers_lock);
 	list_del_init(&drv->entry);
+	spin_unlock(&global_drivers_lock);
+	spin_unlock(&cls->lock);
+
 	if (cls) {
 		if (drv->remove) {
-			struct sys_device *dev;
-			list_for_each_entry(dev, &cls->kset.list, kobj.entry)
+			struct sys_device *dev, *temp;
+			list_for_each_entry_safe(dev, temp, &cls->kset.list, kobj.entry)
 				drv->remove(dev);
 		}
 		kset_put(&cls->kset);
 	}
-	up_write(&system_subsys.rwsem);
 }
 
 EXPORT_SYMBOL_GPL(sysdev_driver_register);
@@ -191,44 +200,40 @@ int sysdev_register(struct sys_device * 
 	error = kobject_register(&sysdev->kobj);
 
 	if (!error) {
-		struct sysdev_driver * drv;
+		struct sysdev_driver *drv, *temp;
 
-		down_write(&system_subsys.rwsem);
 		/* Generic notification is implicit, because it's that
 		 * code that should have called us.
 		 */
 
 		/* Notify global drivers */
-		list_for_each_entry(drv, &global_drivers, entry) {
+		list_for_each_entry_safe(drv, temp, &global_drivers, entry) {
 			if (drv->add)
 				drv->add(sysdev);
 		}
 
 		/* Notify class auxillary drivers */
-		list_for_each_entry(drv, &cls->drivers, entry) {
+		list_for_each_entry_safe(drv, temp, &cls->drivers, entry) {
 			if (drv->add)
 				drv->add(sysdev);
 		}
-		up_write(&system_subsys.rwsem);
 	}
 	return error;
 }
 
 void sysdev_unregister(struct sys_device * sysdev)
 {
-	struct sysdev_driver * drv;
+	struct sysdev_driver *drv, *temp;
 
-	down_write(&system_subsys.rwsem);
-	list_for_each_entry(drv, &global_drivers, entry) {
+	list_for_each_entry_safe(drv, temp, &global_drivers, entry) {
 		if (drv->remove)
 			drv->remove(sysdev);
 	}
 
-	list_for_each_entry(drv, &sysdev->cls->drivers, entry) {
+	list_for_each_entry_safe(drv, temp, &sysdev->cls->drivers, entry) {
 		if (drv->remove)
 			drv->remove(sysdev);
 	}
-	up_write(&system_subsys.rwsem);
 
 	kobject_unregister(&sysdev->kobj);
 }
@@ -251,30 +256,29 @@ void sysdev_unregister(struct sys_device
 
 void sysdev_shutdown(void)
 {
-	struct sysdev_class * cls;
+	struct sysdev_class *cls;
 
 	pr_debug("Shutting Down System Devices\n");
 
-	down_write(&system_subsys.rwsem);
 	list_for_each_entry_reverse(cls, &system_subsys.kset.list,
 				    kset.kobj.entry) {
-		struct sys_device * sysdev;
+		struct sys_device *sysdev, *temp_dev;
 
 		pr_debug("Shutting down type '%s':\n",
 			 kobject_name(&cls->kset.kobj));
 
-		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
-			struct sysdev_driver * drv;
+		list_for_each_entry_safe(sysdev, temp_dev, &cls->kset.list, kobj.entry) {
+			struct sysdev_driver *drv, *temp_drv;
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
-			list_for_each_entry(drv, &global_drivers, entry) {
+			list_for_each_entry_safe(drv, temp_drv, &global_drivers, entry) {
 				if (drv->shutdown)
 					drv->shutdown(sysdev);
 			}
 
 			/* Call auxillary drivers next. */
-			list_for_each_entry(drv, &cls->drivers, entry) {
+			list_for_each_entry_safe(drv, temp_drv, &cls->drivers, entry) {
 				if (drv->shutdown)
 					drv->shutdown(sysdev);
 			}
@@ -284,7 +288,6 @@ void sysdev_shutdown(void)
 				cls->shutdown(sysdev);
 		}
 	}
-	up_write(&system_subsys.rwsem);
 }
 
 
@@ -309,23 +312,23 @@ int sysdev_suspend(u32 state)
 
 	list_for_each_entry_reverse(cls, &system_subsys.kset.list,
 				    kset.kobj.entry) {
-		struct sys_device * sysdev;
+		struct sys_device *sysdev, *temp_dev;
 
 		pr_debug("Suspending type '%s':\n",
 			 kobject_name(&cls->kset.kobj));
 
-		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
-			struct sysdev_driver * drv;
+		list_for_each_entry_safe(sysdev, temp_dev, &cls->kset.list, kobj.entry) {
+			struct sysdev_driver *drv, *temp_drv;
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
-			list_for_each_entry(drv, &global_drivers, entry) {
+			list_for_each_entry_safe(drv, temp_drv, &global_drivers, entry) {
 				if (drv->suspend)
 					drv->suspend(sysdev, state);
 			}
 
 			/* Call auxillary drivers next. */
-			list_for_each_entry(drv, &cls->drivers, entry) {
+			list_for_each_entry_safe(drv, temp_drv, &cls->drivers, entry) {
 				if (drv->suspend)
 					drv->suspend(sysdev, state);
 			}
@@ -355,13 +358,13 @@ int sysdev_resume(void)
 	pr_debug("Resuming System Devices\n");
 
 	list_for_each_entry(cls, &system_subsys.kset.list, kset.kobj.entry) {
-		struct sys_device * sysdev;
+		struct sys_device *sysdev, *temp_dev;
 
 		pr_debug("Resuming type '%s':\n",
 			 kobject_name(&cls->kset.kobj));
 
-		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
-			struct sysdev_driver * drv;
+		list_for_each_entry_safe(sysdev, temp_dev, &cls->kset.list, kobj.entry) {
+			struct sysdev_driver *drv, *temp_drv;
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* First, call the class-specific one */
@@ -369,13 +372,13 @@ int sysdev_resume(void)
 				cls->resume(sysdev);
 
 			/* Call auxillary drivers next. */
-			list_for_each_entry(drv, &cls->drivers, entry) {
+			list_for_each_entry_safe(drv, temp_drv, &cls->drivers, entry) {
 				if (drv->resume)
 					drv->resume(sysdev);
 			}
 
 			/* Call global drivers. */
-			list_for_each_entry(drv, &global_drivers, entry) {
+			list_for_each_entry_safe(drv, temp_drv, &global_drivers, entry) {
 				if (drv->resume)
 					drv->resume(sysdev);
 			}
===== include/linux/sysdev.h 1.6 vs edited =====
--- 1.6/include/linux/sysdev.h	2004-03-04 08:57:52 -08:00
+++ edited/include/linux/sysdev.h	2005-01-17 14:46:50 -08:00
@@ -22,12 +22,14 @@
 #define _SYSDEV_H_
 
 #include <linux/kobject.h>
+#include <linux/spinlock.h>
 
 
 struct sys_device;
 
 struct sysdev_class {
 	struct list_head	drivers;
+	spinlock_t	lock;	/* locks the list for this class */
 
 	/* Default operations for these types of devices */
 	int	(*shutdown)(struct sys_device *);
