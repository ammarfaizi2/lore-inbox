Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSFDDSk>; Mon, 3 Jun 2002 23:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFDDSj>; Mon, 3 Jun 2002 23:18:39 -0400
Received: from air-2.osdl.org ([65.201.151.6]:53637 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316127AbSFDDSf>;
	Mon, 3 Jun 2002 23:18:35 -0400
Date: Mon, 3 Jun 2002 20:14:25 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kees Bakker <kees.bakker@xs4all.nl>,
        Anton Altaparmakov <aia21@cantab.net>,
        Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <3CFC0CC2.D69F2C57@zip.com.au>
Message-ID: <Pine.LNX.4.33.0206031954180.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Jun 2002, Andrew Morton wrote:

> The new pci_device_probe() is always passing the zeroeth
> entry in the id_table to the device's probe method.  It
> needs to scan that table for the correct ID first.

Arg. Ok. I've applied the patch, though I wonder if there's a better way. 
The proper ID is already determined, though it happens when dealing with 
generic struct devices and not PCI devices:

driver_register calls driver_bind, which calls the bus's bind() callback. 
That compares the bus-specific IDs that the driver supports to the 
device's ID. The format and semantics for comparing IDs is inherently 
bus-specific, so I made sure to keep them in the bus-specific structs. So, 
which ID the device really is, is lost when we return back to the core. 

We could keep it as a void *, or a char *, but I'd rather not lose the 
type information. Or, a union, but those get ugly and difficult to manage. 
Does anyone have any other preference? 

Along with your patch and the other fixes below (in which yours is
included), all the oddities should be resolved, including the OOPSes on
module unload. A patch is appended, after the changelog. You can also soon
pull from

	bk://ldm.bkbits.net/linux-2.5

Could people could please test it, and let me know if anything is still 
broken?

	-pat

ChangeSet@1.416, 2002-06-03 19:53:50-07:00, mochel@osdl.org
  PCI driver mgmt:
  - Make sure proper pci id is passed to probe()
  - make sure pci_dev->driver is set and reset on driver registration/unregistration
  - call remove_driver to force unload of driver on unregistration

 drivers/pci/pci-driver.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions, 8 deletions


ChangeSet@1.415, 2002-06-03 19:51:12-07:00, mochel@osdl.org
  Do manual traversing of drivers' devices list when unbinding the driver.
  
  driver_unbind was called when drv->refcount == 0.
  It would call driver_for_each_dev to do the unbinding
  The first thing that would do was get_device, which...
  BUG()'d if drv->refcount == 0. 
  Duh. 

 drivers/base/core.c |   39 ++++++++++++++++++++++++++++++++-------
 1 files changed, 32 insertions, 7 deletions


ChangeSet@1.414, 2002-06-03 19:48:44-07:00, mochel@osdl.org
  device model udpate:
  - make sure drv->devices is initialized on registration (from Peter Osterlund)
  - add remove_driver for forcing removal of driver
  
  There was a potential race with the module unload code. When a pci driver was unloaded, it would call pci_unregister_driver, which would simply call put_driver.
  If the driver's refcount wasn't 0, it wouldn't unbind it from devices, but the module unload would still continue. 
  If something tried to access the driver later (since everyone thinks its still there), Bad Things would happen. 
  This fixes it until there can be tighter integration between the device model and module unload code.

 drivers/base/driver.c  |   35 ++++++++++++++++++++++++++---------
 include/linux/device.h |    1 +
 2 files changed, 27 insertions, 9 deletions


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Mon Jun  3 20:11:55 2002
+++ b/drivers/base/core.c	Mon Jun  3 20:11:55 2002
@@ -5,6 +5,8 @@
  *		 2002 Open Source Development Lab
  */
 
+#define DEBUG 0
+
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -118,9 +120,8 @@
 	return bus_for_each_dev(drv->bus,drv,do_driver_bind);
 }
 
-static int do_driver_unbind(struct device * dev, void * data)
+static int do_driver_unbind(struct device * dev, struct device_driver * drv)
 {
-	struct device_driver * drv = (struct device_driver *)data;
 	lock_device(dev);
 	if (dev->driver == drv) {
 		dev->driver = NULL;
@@ -134,7 +135,31 @@
 
 void driver_unbind(struct device_driver * drv)
 {
-	driver_for_each_dev(drv,drv,do_driver_unbind);
+	struct device * next;
+	struct device * dev = NULL;
+	struct list_head * node;
+	int error = 0;
+
+	read_lock(&drv->lock);
+	node = drv->devices.next;
+	while (node != &drv->devices) {
+		next = list_entry(node,struct device,driver_list);
+		get_device(next);
+		read_unlock(&drv->lock);
+
+		if (dev)
+			put_device(dev);
+		dev = next;
+		if ((error = do_driver_unbind(dev,drv))) {
+			put_device(dev);
+			break;
+		}
+		read_lock(&drv->lock);
+		node = dev->driver_list.next;
+	}
+	read_unlock(&drv->lock);
+	if (dev)
+		put_device(dev);
 }
 
 /**
@@ -178,8 +203,8 @@
 	}
 	spin_unlock(&device_lock);
 
-	DBG("DEV: registering device: ID = '%s', name = %s\n",
-	    dev->bus_id, dev->name);
+	pr_debug("DEV: registering device: ID = '%s', name = %s\n",
+		 dev->bus_id, dev->name);
 
 	if ((error = device_make_dir(dev)))
 		goto register_done;
@@ -212,8 +237,8 @@
 	list_del_init(&dev->g_list);
 	spin_unlock(&device_lock);
 
-	DBG("DEV: Unregistering device. ID = '%s', name = '%s'\n",
-	    dev->bus_id,dev->name);
+	pr_debug("DEV: Unregistering device. ID = '%s', name = '%s'\n",
+		 dev->bus_id,dev->name);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Mon Jun  3 20:11:55 2002
+++ b/drivers/pci/pci-driver.c	Mon Jun  3 20:11:55 2002
@@ -38,23 +38,35 @@
 static int pci_device_probe(struct device * dev)
 {
 	int error = 0;
+	struct pci_driver *drv;
+	struct pci_dev *pci_dev;
 
-	struct pci_driver * drv = list_entry(dev->driver,struct pci_driver,driver);
-	struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
+	drv = list_entry(dev->driver, struct pci_driver, driver);
+	pci_dev = list_entry(dev, struct pci_dev, dev);
+
+	if (drv->probe) {
+		const struct pci_device_id *id;
 
-	if (drv->probe)
-		error = drv->probe(pci_dev,drv->id_table);
-	return error > 0 ? 0 : -ENODEV;
+		id = pci_match_device(drv->id_table, pci_dev);
+		if (id)
+			error = drv->probe(pci_dev, id);
+		if (error >= 0) {
+			pci_dev->driver = drv;
+			error = 0;
+		}
+	}
+	return error;
 }
 
 static int pci_device_remove(struct device * dev)
 {
 	struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
+	struct pci_driver * drv = pci_dev->driver;
 
-	if (dev->driver) {
-		struct pci_driver * drv = list_entry(dev->driver,struct pci_driver,driver);
+	if (drv) {
 		if (drv->remove)
 			drv->remove(pci_dev);
+		pci_dev->driver = NULL;
 	}
 	return 0;
 }
@@ -124,7 +136,7 @@
 void
 pci_unregister_driver(struct pci_driver *drv)
 {
-	put_driver(&drv->driver);
+	remove_driver(&drv->driver);
 }
 
 static struct pci_driver pci_compat_driver = {

