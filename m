Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbTCJVok>; Mon, 10 Mar 2003 16:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbTCJVok>; Mon, 10 Mar 2003 16:44:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34323 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261501AbTCJVof>;
	Mon, 10 Mar 2003 16:44:35 -0500
Date: Mon, 10 Mar 2003 13:44:43 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030310214443.GA13145@kroah.com>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308191237.GA26374@kroah.com> <20030308200943.F1896@flint.arm.linux.org.uk> <20030308202101.GA26831@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308202101.GA26831@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 12:21:01PM -0800, Greg KH wrote:
> On Sat, Mar 08, 2003 at 08:09:43PM +0000, Russell King wrote:
> > On Sat, Mar 08, 2003 at 11:12:37AM -0800, Greg KH wrote:
> > > On Sat, Mar 08, 2003 at 10:47:49AM +0000, Russell King wrote:
> > > > Hi,
> > > > 
> > > > What prevents the following scenario from happening?  It's purely
> > > > theoretical - I haven't seen this occuring.
> > > > 
> > > > - Load PCI driver.
> > > > 
> > > > - PCI driver registers using pci_module_init(), and adds itself to sysfs.
> > > > 
> > > > - Hot-plugin a PCI device which uses this driver.  sysfs matches the PCI
> > > >   driver, and calls the PCI drivers probe function.
> > > 
> > > Ugh, yes you are correct, I can't believe I missed this before.
> > > 
> > > How does this patch look?
> > 
> > Hrm, I'm wondering whether this should be part of the device model
> > infrastructure.  After all, surely every subsystems device driver
> > which could be a module would need this to prevent unload races?
> 
> Very good point, I can see myself duplicating this logic for every
> subsystem :)
> 
> I'll look into moving this into the driver core later today.

Ok, how about this patch?  It boots for me :)

If no one has any complaints, I'll work on moving the USB core to using
this pointer instead of its own in struct usb_driver.

thanks,

greg k-h


# Driver core: add module owner to struct device_driver

diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Mon Mar 10 13:52:15 2003
+++ b/drivers/base/bus.c	Mon Mar 10 13:52:15 2003
@@ -263,14 +263,25 @@
 	if (dev->bus->match(dev,drv)) {
 		dev->driver = drv;
 		if (drv->probe) {
-			if ((error = drv->probe(dev))) {
-				dev->driver = NULL;
-				return error;
+			if (!try_module_get(drv->owner)) {
+				dev_err(dev,
+					"Can't get a module reference for %s\n",
+					drv->name);
+				goto exit;
 			}
+
+			if ((error = drv->probe(dev)))
+				dev->driver = NULL;
+
+			module_put(drv->owner);
+
+			if (error)
+				goto exit;
 		}
 		device_bind_driver(dev);
 		error = 0;
 	}
+exit:
 	return error;
 }
 
@@ -350,8 +361,16 @@
 		sysfs_remove_link(&drv->kobj,dev->kobj.name);
 		list_del_init(&dev->driver_list);
 		devclass_remove_device(dev);
-		if (drv->remove)
-			drv->remove(dev);
+		if (drv->remove) {
+			if (!try_module_get(drv->owner)) {
+				dev_err(dev,
+					"Can't get a module reference for %s\n",
+					drv->name);
+			} else {
+				drv->remove(dev);
+				module_put(drv->owner);
+			}
+		}
 		dev->driver = NULL;
 	}
 }
diff -Nru a/drivers/base/power.c b/drivers/base/power.c
--- a/drivers/base/power.c	Mon Mar 10 13:52:15 2003
+++ b/drivers/base/power.c	Mon Mar 10 13:52:15 2003
@@ -41,10 +41,17 @@
 	list_for_each(node,&devices_subsys.kset.list) {
 		struct device * dev = to_dev(node);
 		if (dev->driver && dev->driver->suspend) {
-			pr_debug("suspending device %s\n",dev->name);
-			error = dev->driver->suspend(dev,state,level);
-			if (error)
-				printk(KERN_ERR "%s: suspend returned %d\n",dev->name,error);
+			if (!try_module_get(dev->driver->owner)) {
+				dev_err(dev,
+					"Can't get a module reference for %s\n",
+					dev->driver->name);
+			} else {
+				pr_debug("suspending device %s\n",dev->name);
+				error = dev->driver->suspend(dev,state,level);
+				if (error)
+					printk(KERN_ERR "%s: suspend returned %d\n",dev->name,error);
+				module_put(dev->driver->owner);
+			}
 		}
 	}
 	up_write(&devices_subsys.rwsem);
@@ -67,8 +74,15 @@
 	list_for_each_prev(node,&devices_subsys.kset.list) {
 		struct device * dev = to_dev(node);
 		if (dev->driver && dev->driver->resume) {
-			pr_debug("resuming device %s\n",dev->name);
-			dev->driver->resume(dev,level);
+			if (!try_module_get(dev->driver->owner)) {
+				dev_err(dev,
+					"Can't get a module reference for %s\n",
+					dev->driver->name);
+			} else {
+				pr_debug("resuming device %s\n",dev->name);
+				dev->driver->resume(dev,level);
+				module_put(dev->driver->owner);
+			}
 		}
 	}
 	up_write(&devices_subsys.rwsem);
@@ -89,8 +103,15 @@
 	list_for_each(entry,&devices_subsys.kset.list) {
 		struct device * dev = to_dev(entry);
 		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("shutting down %s\n",dev->name);
-			dev->driver->shutdown(dev);
+			if (!try_module_get(dev->driver->owner)) {
+				dev_err(dev,
+					"Can't get a module reference for %s\n",
+					dev->driver->name);
+			} else {
+				pr_debug("shutting down %s\n",dev->name);
+				dev->driver->shutdown(dev);
+				module_put(dev->driver->owner);
+			}
 		}
 	}
 	up_write(&devices_subsys.rwsem);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Mar 10 13:52:15 2003
+++ b/include/linux/device.h	Mon Mar 10 13:52:15 2003
@@ -112,6 +112,7 @@
 extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
 
 struct device_driver {
+	struct module		* owner;
 	char			* name;
 	struct bus_type		* bus;
 	struct device_class	* devclass;
