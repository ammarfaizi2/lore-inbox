Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSFFX2C>; Thu, 6 Jun 2002 19:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSFFX2B>; Thu, 6 Jun 2002 19:28:01 -0400
Received: from air-2.osdl.org ([65.201.151.6]:11663 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S313070AbSFFX17>;
	Thu, 6 Jun 2002 19:27:59 -0400
Date: Thu, 6 Jun 2002 16:23:49 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.33.0206061551170.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0206061620490.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That seems a lot cleaner than anything so far; we leverage the existing
> module infrastructure as much as possible. I'll see about codifying the
> concept in the next day or so and sending it out..

Actually, it appears to be as easy as the patch below. Or, I just could 
just not know what the hell I'm talking about. 

Things appear to be working (with the eepro100 as a module)....

	-pat

===== drivers/base/driver.c 1.7 vs edited =====
--- 1.7/drivers/base/driver.c	Wed Jun  5 15:59:31 2002
+++ edited/drivers/base/driver.c	Thu Jun  6 16:13:35 2002
@@ -67,9 +67,9 @@
 	pr_debug("Registering driver '%s' with bus '%s'\n",drv->name,drv->bus->name);
 
 	get_bus(drv->bus);
-	atomic_set(&drv->refcount,2);
 	rwlock_init(&drv->lock);
 	INIT_LIST_HEAD(&drv->devices);
+	SET_MODULE_OWNER(drv);
 	write_lock(&drv->bus->lock);
 	list_add(&drv->bus_list,&drv->bus->drivers);
 	write_unlock(&drv->bus->lock);
@@ -79,42 +79,41 @@
 	return 0;
 }
 
-static void __remove_driver(struct device_driver * drv)
+void driver_unregister(struct device_driver * drv)
 {
-	pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
+	struct bus_type * bus;
+
+	write_lock(&drv->lock);
+	bus = drv->bus;
+	drv->bus = NULL;
+	write_unlock(&drv->lock);
+
+	/* make sure no one can get to it via the bus any more */
+	write_lock(&bus->lock);
+	list_del_init(&drv->bus_list);
+	write_unlock(&bus->lock);
+
+	/* force removal from devices */
 	driver_detach(drv);
+
+	pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
 	driverfs_remove_dir(&drv->dir);
-	if (drv->release)
-		drv->release(drv);
-	put_bus(drv->bus);
+
+	put_bus(bus);
 }
 
-void remove_driver(struct device_driver * drv)
+struct device_driver * get_driver(struct device_driver * drv)
 {
-	write_lock(&drv->bus->lock);
-	atomic_set(&drv->refcount,0);
-	list_del_init(&drv->bus_list);
-	write_unlock(&drv->bus->lock);
-	__remove_driver(drv);
+	__MOD_INC_USE_COUNT(drv->owner);
+	return drv;
 }
 
-/**
- * put_driver - decrement driver's refcount and clean up if necessary
- * @drv:	driver in question
- */
 void put_driver(struct device_driver * drv)
 {
-	write_lock(&drv->bus->lock);
-	if (!atomic_dec_and_test(&drv->refcount)) {
-		write_unlock(&drv->bus->lock);
-		return;
-	}
-	list_del_init(&drv->bus_list);
-	write_unlock(&drv->bus->lock);
-	__remove_driver(drv);
+	__MOD_DEC_USE_COUNT(drv->owner);
 }
 
 EXPORT_SYMBOL(driver_for_each_dev);
 EXPORT_SYMBOL(driver_register);
+EXPORT_SYMBOL(driver_unregister);
 EXPORT_SYMBOL(put_driver);
-EXPORT_SYMBOL(remove_driver);
===== include/linux/device.h 1.20 vs edited =====
--- 1.20/include/linux/device.h	Wed Jun  5 14:43:23 2002
+++ edited/include/linux/device.h	Thu Jun  6 16:13:19 2002
@@ -90,7 +90,7 @@
 	struct bus_type		* bus;
 
 	rwlock_t		lock;
-	atomic_t		refcount;
+	struct module		* owner;
 
 	list_t			bus_list;
 	list_t			devices;
@@ -102,23 +102,15 @@
 
 	int	(*suspend)	(struct device * dev, u32 state, u32 level);
 	int	(*resume)	(struct device * dev, u32 level);
-
-	void	(*release)	(struct device_driver * drv);
 };
 
 
 
 extern int driver_register(struct device_driver * drv);
+extern void driver_unregister(struct device_driver * drv);
 
-static inline struct device_driver * get_driver(struct device_driver * drv)
-{
-	BUG_ON(!atomic_read(&drv->refcount));
-	atomic_inc(&drv->refcount);
-	return drv;
-}
-
+extern struct device_driver * get_driver(struct device_driver * drv);
 extern void put_driver(struct device_driver * drv);
-extern void remove_driver(struct device_driver * drv);
 
 extern int driver_for_each_dev(struct device_driver * drv, void * data, 
 			       int (*callback)(struct device * dev, void * data));

