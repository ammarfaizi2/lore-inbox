Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSFFAjy>; Wed, 5 Jun 2002 20:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSFFAjx>; Wed, 5 Jun 2002 20:39:53 -0400
Received: from air-2.osdl.org ([65.201.151.6]:35979 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316582AbSFFAjv>;
	Wed, 5 Jun 2002 20:39:51 -0400
Date: Wed, 5 Jun 2002 17:35:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.44.0206051845310.8309-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.33.0206051726400.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Jun 2002, Kai Germaschewski wrote:

> On Wed, 5 Jun 2002, Patrick Mochel wrote:
> 
> > No, I haven't given up on it, and I admit it's fishy. However, I did it
> > to ensure that no one can access the driver since it is going away as
> > soon as we return to pci_unregister_driver. Though, I'll also admit that
> > making the next potential user hit the BUG() in get_driver() is not the
> > nicest thing to do...
> 
> There's two phases:
> o remove_driver():
>   Make sure that now one else can find (and inc the refcount) your struct
>   anymore. That can and should be done immediately. Drop your reference.
> o At some point later, everybody else will have dropped their references
>   and the destructor can be called.
> 
> Alternatively:
> o remove_driver():
>   Make sure that now one else can find (and inc the refcount) your struct
>   anymore. That can and should be done immediately. Drop your reference.
>   Wait for everybody else to drop their reference. Then return to the 
>   caller
> o At some point later, everybody else will have dropped their references
>   and the remove_driver() should be woken up and you get to the return.

Alright, I can deal. I expanded on what you had, and moved it into the 
core. It's not tested, but lemme know what you think. 

	-pat

===== drivers/base/driver.c 1.7 vs edited =====
--- 1.7/drivers/base/driver.c	Wed Jun  5 15:59:31 2002
+++ edited/drivers/base/driver.c	Wed Jun  5 17:29:55 2002
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/completion.h>
 #include "base.h"
 
 
@@ -70,6 +71,8 @@
 	atomic_set(&drv->refcount,2);
 	rwlock_init(&drv->lock);
 	INIT_LIST_HEAD(&drv->devices);
+	init_completion(&drv->complete);
+
 	write_lock(&drv->bus->lock);
 	list_add(&drv->bus_list,&drv->bus->drivers);
 	write_unlock(&drv->bus->lock);
@@ -84,18 +87,21 @@
 	pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
 	driver_detach(drv);
 	driverfs_remove_dir(&drv->dir);
-	if (drv->release)
-		drv->release(drv);
 	put_bus(drv->bus);
 }
 
-void remove_driver(struct device_driver * drv)
+void driver_unregister(struct device_driver * drv)
 {
+	/* make sure no one can get to it via the bus any more */
 	write_lock(&drv->bus->lock);
-	atomic_set(&drv->refcount,0);
 	list_del_init(&drv->bus_list);
 	write_unlock(&drv->bus->lock);
-	__remove_driver(drv);
+
+	/* dec the refcount */
+	put_driver(drv);
+
+	/* if we didn't get rid of the driver, wait for it to be done */
+	wait_for_completion(&drv->complete);
 }
 
 /**
@@ -112,9 +118,10 @@
 	list_del_init(&drv->bus_list);
 	write_unlock(&drv->bus->lock);
 	__remove_driver(drv);
+	complete(&drv->complete);
 }
 
 EXPORT_SYMBOL(driver_for_each_dev);
 EXPORT_SYMBOL(driver_register);
+EXPORT_SYMBOL(driver_unregister);
 EXPORT_SYMBOL(put_driver);
-EXPORT_SYMBOL(remove_driver);
===== include/linux/device.h 1.20 vs edited =====
--- 1.20/include/linux/device.h	Wed Jun  5 14:43:23 2002
+++ edited/include/linux/device.h	Wed Jun  5 17:33:21 2002
@@ -28,6 +28,7 @@
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/completion.h>
 #include <linux/driverfs_fs.h>
 
 #define DEVICE_NAME_SIZE	80
@@ -91,6 +92,7 @@
 
 	rwlock_t		lock;
 	atomic_t		refcount;
+	struct completion	complete;
 
 	list_t			bus_list;
 	list_t			devices;
@@ -102,13 +104,12 @@
 
 	int	(*suspend)	(struct device * dev, u32 state, u32 level);
 	int	(*resume)	(struct device * dev, u32 level);
-
-	void	(*release)	(struct device_driver * drv);
 };
 
 
 
 extern int driver_register(struct device_driver * drv);
+extern void driver_unregister(struct device_driver * drv);
 
 static inline struct device_driver * get_driver(struct device_driver * drv)
 {
@@ -118,7 +119,6 @@
 }
 
 extern void put_driver(struct device_driver * drv);
-extern void remove_driver(struct device_driver * drv);
 
 extern int driver_for_each_dev(struct device_driver * drv, void * data, 
 			       int (*callback)(struct device * dev, void * data));

