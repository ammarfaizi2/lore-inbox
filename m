Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSFFTNU>; Thu, 6 Jun 2002 15:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSFFTNT>; Thu, 6 Jun 2002 15:13:19 -0400
Received: from air-2.osdl.org ([65.201.151.6]:29581 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317072AbSFFTNR>;
	Thu, 6 Jun 2002 15:13:17 -0400
Date: Thu, 6 Jun 2002 12:09:06 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.44.0206052019310.24284-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.33.0206061150570.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Jun 2002, Kai Germaschewski wrote:

> On Wed, 5 Jun 2002, Patrick Mochel wrote:
> 
> > Alright, I can deal. I expanded on what you had, and moved it into the 
> > core. It's not tested, but lemme know what you think. 
> 
> Looks fine to me, though I didn't test it either ;-)
> 
> However, it's possible to put the struct completion onto the stack
> as I suggested, it saves a couple of bytes in struct driver, and, more
> importantly, it'll blow up if the refcount goes to zero before 
> driver_unregister() has been called, so it provides a bug trap for
> messed-up refcounting.

Actually, I don't think the completion is needed at all. For one, it
didn't work, and I found another bug. When we find a driver to a device,
we inc the refcount. But, when we detach the driver via driver_detach(),
we weren't decrementing it. The patch below does this. When you call
driver_unregister(), it detaches the driver, then decs the refcount once,
and Lo! it works.

Second, Greg brought up an interesting point: if something is using a 
module, it should have already inc'd the refcount, and rmmod(8) won't let 
you remove it. If we can remove a module, but something is still using it, 
it's a bug. And, exposing those will get those fixed sooner...

That said, I'm an offender of that rule with driverfs. It's the topic of
another thread, and I haven't quite figured out the best solution. When we
open a file belonging to a driver, we want to inc the module refcount.
But, we don't currently have anyway to get at the module to do this. 

The f_ops of the file has an owner, but the f_ops structure is shared by 
all files. We could add an owner to struct driver_file_entry and struct 
device_driver, but that would make the former twice as large. We could add 
it only to the latter, but it would require a differnt open for each type 
of structure (device, device_driver, bus_type) to deference and access the 
owner. 

I'm leading towards the last, and will see how clean it can be..

	-pat


===== drivers/base/core.c 1.28 vs edited =====
--- 1.28/drivers/base/core.c	Thu Jun  6 09:50:30 2002
+++ edited/drivers/base/core.c	Thu Jun  6 11:23:50 2002
@@ -144,6 +144,7 @@
 			drv->remove(dev);
 	} else
 		unlock_device(dev);
+	put_driver(drv);
 	return 0;
 }
 
===== drivers/base/driver.c 1.7 vs edited =====
--- 1.7/drivers/base/driver.c	Wed Jun  5 15:59:31 2002
+++ edited/drivers/base/driver.c	Thu Jun  6 12:07:34 2002
@@ -79,23 +79,18 @@
 	return 0;
 }
 
-static void __remove_driver(struct device_driver * drv)
-{
-	pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
-	driver_detach(drv);
-	driverfs_remove_dir(&drv->dir);
-	if (drv->release)
-		drv->release(drv);
-	put_bus(drv->bus);
-}
-
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
+	/* force removal from devices */
+	driver_detach(drv);
+
+	/* dec the refcount (this should clean it up) */
+	put_driver(drv);
 }
 
 /**
@@ -111,10 +106,14 @@
 	}
 	list_del_init(&drv->bus_list);
 	write_unlock(&drv->bus->lock);
-	__remove_driver(drv);
+
+	pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
+	driverfs_remove_dir(&drv->dir);
+
+	put_bus(drv->bus);
 }
 
 EXPORT_SYMBOL(driver_for_each_dev);
 EXPORT_SYMBOL(driver_register);
+EXPORT_SYMBOL(driver_unregister);
 EXPORT_SYMBOL(put_driver);
-EXPORT_SYMBOL(remove_driver);
===== include/linux/device.h 1.20 vs edited =====
--- 1.20/include/linux/device.h	Wed Jun  5 14:43:23 2002
+++ edited/include/linux/device.h	Thu Jun  6 11:46:07 2002
@@ -102,13 +102,12 @@
 
 	int	(*suspend)	(struct device * dev, u32 state, u32 level);
 	int	(*resume)	(struct device * dev, u32 level);
-
-	void	(*release)	(struct device_driver * drv);
 };
 
 
 
 extern int driver_register(struct device_driver * drv);
+extern void driver_unregister(struct device_driver * drv);
 
 static inline struct device_driver * get_driver(struct device_driver * drv)
 {
@@ -118,7 +117,6 @@
 }
 
 extern void put_driver(struct device_driver * drv);
-extern void remove_driver(struct device_driver * drv);
 
 extern int driver_for_each_dev(struct device_driver * drv, void * data, 
 			       int (*callback)(struct device * dev, void * data));

