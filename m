Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSFAVT7>; Sat, 1 Jun 2002 17:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317071AbSFAVT6>; Sat, 1 Jun 2002 17:19:58 -0400
Received: from mailb.telia.com ([194.22.194.6]:46345 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S317068AbSFAVT5>;
	Sat, 1 Jun 2002 17:19:57 -0400
To: linux-kernel@vger.kernel.org
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.5.19 OOPS in pcmcia setup code
In-Reply-To: <3CF6843C.6090101@oracle.com> <m2bsavpe0p.fsf@ppro.localdomain>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Jun 2002 23:19:55 +0200
Message-ID: <m2g006n1c4.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> My laptop also oopses on boot, but this patch makes things work again:

I get an oops also in pci_unregister_driver, which happens because
driver_list in the device structure is never initialized. I'm now
running with this patch which seems to work:

diff -u -r linux.orig/drivers/base/driver.c linux/drivers/base/driver.c
--- linux.orig/drivers/base/driver.c	Sat Jun  1 19:48:49 2002
+++ linux/drivers/base/driver.c	Sat Jun  1 13:28:41 2002
@@ -37,6 +37,7 @@
 	write_lock(&drv->bus->lock);
 	list_add(&drv->bus_list,&drv->bus->drivers);
 	write_unlock(&drv->bus->lock);
+	INIT_LIST_HEAD(&drv->devices);
 	driver_make_dir(drv);
 	put_driver(drv);
 	return 0;
diff -u -r linux.orig/drivers/pci/hotplug.c linux/drivers/pci/hotplug.c
--- linux.orig/drivers/pci/hotplug.c	Sat Jun  1 19:48:49 2002
+++ linux/drivers/pci/hotplug.c	Sat Jun  1 10:52:05 2002
@@ -61,7 +61,7 @@
 	struct list_head *ln;
 
 	for(ln=pci_bus_type.drivers.next; ln != &pci_bus_type.drivers; ln=ln->next) {
-		struct pci_driver *drv = list_entry(ln, struct pci_driver, node);
+		struct pci_driver *drv = list_entry(ln, struct pci_driver, driver.bus_list);
 		if (drv->remove && pci_announce_device(drv, dev))
 			break;
 	}
diff -u -r linux.orig/drivers/pci/pci-driver.c linux/drivers/pci/pci-driver.c
--- linux.orig/drivers/pci/pci-driver.c	Sat Jun  1 19:48:49 2002
+++ linux/drivers/pci/pci-driver.c	Sat Jun  1 19:41:58 2002
@@ -52,6 +52,7 @@
 	dev_probe_lock();
 	if (drv->probe(dev, id) >= 0) {
 		dev->driver = drv;
+		list_add_tail(&dev->dev.driver_list, &drv->driver.devices);
 		ret = 1;
 	}
 	dev_probe_unlock();
@@ -169,6 +170,7 @@
 		pci_dev->driver = NULL;
 		dev->driver = NULL;
 		list_del_init(&dev->driver_list);
+		node = drv->driver.devices.next;
 	}
 	put_driver(&drv->driver);
 }
diff -u -r linux.orig/include/linux/device.h linux/include/linux/device.h
--- linux.orig/include/linux/device.h	Sat Jun  1 19:48:50 2002
+++ linux/include/linux/device.h	Sat Jun  1 13:24:52 2002
@@ -125,7 +125,7 @@
 	struct list_head g_list;        /* node in depth-first order list */
 	struct list_head node;		/* node in sibling list */
 	struct list_head bus_list;	/* node in bus's list */
-	struct list_head driver_list;
+	struct list_head driver_list;	/* node in device_driver's list */
 	struct list_head children;
 	struct device 	* parent;
 

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
