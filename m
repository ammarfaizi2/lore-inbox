Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSFJOVk>; Mon, 10 Jun 2002 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSFJOVj>; Mon, 10 Jun 2002 10:21:39 -0400
Received: from air-2.osdl.org ([65.201.151.6]:30354 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315427AbSFJOUs>;
	Mon, 10 Jun 2002 10:20:48 -0400
Date: Mon, 10 Jun 2002 07:16:12 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.44.0206061851360.31896-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.33.0206100623230.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi. Sorry about the long delay in replying, I've been out of town, and am 
actually about to leave again for a week+ in a few hours...

> So the __MOD_{INC,DEC}_USE_COUNT() should oops right here.
> If you tested it and it doesn't oops, I don't understand why.
> 
> So, for one, if you want to go that road, you should use fops_get()/put()
> (you can use just these, or rename them appropriately), they'll do the
> right thing if a thing is modular as opposed to built-in (owner == NULL).

Ah yes; patch appended which does just that. 

> And, you need to set the owner from the module which you want to protect.
> 
> So in the your driver:
> 
> struct pci_driver my_drv {
> 	probe: ...
> 	driver : {
> 		owner: THIS_MODULE,
> 	}
> }

This is certainly not the prettiest, and I've run into it when setting 
other generic driver fields. Is there a cleaner way to do this?

> which certainly is ugly since owner is in a sub-struct. But it's not
> really a possibility anyway, since in this case pci_register_driver will 
> do a MOD_INC_USE_COUNT and you never have a chance to call 
> pci_unregister_driver() to decrement it again, since you need to have it
> decremented before you can call pci_unregister_driver() (because
> that's called from your module_exit() function).

pci_register_driver() doesn't inc the refcount. The refcount is held at 1 
by the module loading code, IIUC, until module_init() is done. After that, 
the refcount stays at 0 until someone uses it.

	-pat

===== drivers/base/driver.c 1.7 vs edited =====
--- 1.7/drivers/base/driver.c	Wed Jun  5 15:59:31 2002
+++ edited/drivers/base/driver.c	Mon Jun 10 06:54:00 2002
@@ -67,54 +67,55 @@
 	pr_debug("Registering driver '%s' with bus '%s'\n",drv->name,drv->bus->name);
 
 	get_bus(drv->bus);
-	atomic_set(&drv->refcount,2);
 	rwlock_init(&drv->lock);
 	INIT_LIST_HEAD(&drv->devices);
+	SET_MODULE_OWNER(drv);
 	write_lock(&drv->bus->lock);
 	list_add(&drv->bus_list,&drv->bus->drivers);
 	write_unlock(&drv->bus->lock);
 	driver_make_dir(drv);
 	driver_attach(drv);
-	put_driver(drv);
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
+	if (drv && drv->owner)
+		if (!try_inc_mod_count(drv->owner))
+			return NULL;
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
+	if (drv && drv->owner)
+		__MOD_DEC_USE_COUNT(drv->owner);
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

