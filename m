Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317716AbSGPAzg>; Mon, 15 Jul 2002 20:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317717AbSGPAzg>; Mon, 15 Jul 2002 20:55:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61069 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317716AbSGPAz3>;
	Mon, 15 Jul 2002 20:55:29 -0400
Date: Mon, 15 Jul 2002 17:56:35 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Driver reference counting and locking, again
Message-ID: <Pine.LNX.4.33.0207151743100.14360-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here is another stab at trying to get reference counting and locking 
right for drivers. 

The short of it is that struct device_driver gets an owner field, which 
should be initialized to THIS_MODULE in the driver. 

get_device and put_device increment and decrement the reference count of 
the module, via the pointer to the driver. 

However, since the driver structure could live in a module, which could 
have been unloaded by the time it can be dereferenced, it is inserted to a 
global list of drivers during registration. This list is searched for the 
driver (by comparing the pointer value) when get_driver is called. If it 
is still in the list, get_driver returns a pointer to the structure; 
otherwise NULL. 

Yes, this means that get_driver iterates over every driver on each 
get_driver() call. It's not the most efficient solution, but it is simple, 
and it should work (and it does, at least here). 

There are some nifty solutions, but I would rather go for correctness 
first, and then worry about speed. 

Pull from bk://ldm.bkbits.net/linux-2.5 

Note that that repository also contains Docuementation changes (and is 
sync'ed to your kernel.org repo).

diffstat and patch appended...

	-pat

ChangeSet@1.639.2.1, 2002-07-15 16:32:01-07:00, mochel@osdl.org
  driver locking:
  Create a global driver list.
  Protect it with a semaphore. 
  Change refcounting to use the driver's owner field, instead of its own refcount.
  Before dereferencing driver, search the global driver list to make sure that it's still around (the module it lives in hasn't been removed).
  Change put_driver to just dereference module refcount

diffstat results: 
 drivers/base/driver.c  |   52 ++++++++++++++++++++++++++++++++-----------------
 include/linux/device.h |   13 +++---------
 2 files changed, 39 insertions, 26 deletions

diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Mon Jul 15 17:40:36 2002
+++ b/drivers/base/driver.c	Mon Jul 15 17:40:36 2002
@@ -10,6 +10,8 @@
 #include <linux/errno.h>
 #include "base.h"
 
+static LIST_HEAD(driver_list);
+static DECLARE_MUTEX(driver_sem);
 
 int driver_for_each_dev(struct device_driver * drv, void * data, int (*callback)(struct device *, void * ))
 {
@@ -67,35 +69,57 @@
 	pr_debug("Registering driver '%s' with bus '%s'\n",drv->name,drv->bus->name);
 
 	get_bus(drv->bus);
-	atomic_set(&drv->refcount,2);
 	rwlock_init(&drv->lock);
 	INIT_LIST_HEAD(&drv->devices);
 	write_lock(&drv->bus->lock);
 	list_add(&drv->bus_list,&drv->bus->drivers);
 	write_unlock(&drv->bus->lock);
+
+	down(&driver_sem);
+	list_add_tail(&drv->g_list,&driver_list);
+	up(&driver_sem);
+
 	driver_make_dir(drv);
 	driver_attach(drv);
-	put_driver(drv);
 	return 0;
 }
 
-static void __remove_driver(struct device_driver * drv)
+void remove_driver(struct device_driver * drv)
 {
+	write_lock(&drv->bus->lock);
+	list_del_init(&drv->bus_list);
+	write_unlock(&drv->bus->lock);
+
 	pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
 	driver_detach(drv);
 	driverfs_remove_dir(&drv->dir);
+
+	down(&driver_sem);
+	list_del_init(&drv->g_list);
+	up(&driver_sem);
+
 	if (drv->release)
 		drv->release(drv);
 	put_bus(drv->bus);
 }
 
-void remove_driver(struct device_driver * drv)
+struct device_driver * get_driver(struct device_driver * drv)
 {
-	write_lock(&drv->bus->lock);
-	atomic_set(&drv->refcount,0);
-	list_del_init(&drv->bus_list);
-	write_unlock(&drv->bus->lock);
-	__remove_driver(drv);
+	struct device_driver * d;
+	struct list_head * node;
+
+	down(&driver_sem);
+	list_for_each(node,&driver_list) {
+		d = list_entry(node,struct device_driver,g_list);
+		if (d == drv)
+			goto GoAhead;
+	}
+	d = NULL;
+ GoAhead:
+	if (d && !try_inc_mod_count(d->owner))
+		d = NULL;
+	up(&driver_sem);
+	return d;
 }
 
 /**
@@ -104,14 +128,8 @@
  */
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
+	if (drv && drv->owner)
+		__MOD_DEC_USE_COUNT(drv->owner);
 }
 
 EXPORT_SYMBOL(driver_for_each_dev);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Jul 15 17:40:36 2002
+++ b/include/linux/device.h	Mon Jul 15 17:40:36 2002
@@ -90,8 +90,9 @@
 	struct bus_type		* bus;
 
 	rwlock_t		lock;
-	atomic_t		refcount;
+	struct module		* owner;
 
+	list_t			g_list;
 	list_t			bus_list;
 	list_t			devices;
 
@@ -109,16 +110,10 @@
 
 
 extern int driver_register(struct device_driver * drv);
+extern void remove_driver(struct device_driver * drv);
 
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


