Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbVJ0Wj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbVJ0Wj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbVJ0Wj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:39:27 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:32384 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751613AbVJ0Wj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:39:26 -0400
X-Mailbox-Line: From laurent@antares.localdomain jeu oct 27 23:13:31 2005
Message-Id: <20051027211253.457180000@antares.localdomain>
Date: Thu, 27 Oct 2005 23:12:54 +0200
From: Laurent riffard <laurent.riffard@free.fr>
To: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       Greg KH <greg@kroah.com>
Subject: [patch 1/1] PCI: automatically set device_driver.owner
Content-Disposition: inline; filename=pci_driver_auto_set_owner.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A nice feature of sysfs is that it can create the symlink from the
driver to the module that is contained in it.

It requires that the device_driver.owner is set, what is not the
case for many PCI drivers.

This patch allows pci_register_driver to set automatically the
device_driver.owner for any PCI driver.

Credits to Al Viro who suggested the method.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/ide/setup-pci.c  |   12 +++++++-----
 drivers/pci/pci-driver.c |    9 +++++----
 include/linux/ide.h      |    3 ++-
 include/linux/pci.h      |    5 +++--
 4 files changed, 17 insertions(+), 12 deletions(-)

Index: linux-2.6-stable/include/linux/pci.h
===================================================================
--- linux-2.6-stable.orig/include/linux/pci.h
+++ linux-2.6-stable/include/linux/pci.h
@@ -857,7 +857,8 @@
 void pci_enable_bridges(struct pci_bus *bus);
 
 /* New-style probing supporting hot-pluggable devices */
-int pci_register_driver(struct pci_driver *);
+int __pci_register_driver(struct pci_driver *, struct module *);
+#define pci_register_driver(d) __pci_register_driver(d, THIS_MODULE)
 void pci_unregister_driver(struct pci_driver *);
 void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
@@ -957,7 +958,7 @@
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
-static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
+static inline int __pci_register_driver(struct pci_driver *drv, struct module *owner) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
Index: linux-2.6-stable/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6-stable.orig/drivers/pci/pci-driver.c
+++ linux-2.6-stable/drivers/pci/pci-driver.c
@@ -325,15 +325,16 @@
 };
 
 /**
- * pci_register_driver - register a new pci driver
+ * __pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
+ * @owner: owner module of drv
  * 
  * Adds the driver structure to the list of registered drivers.
  * Returns a negative value on error, otherwise 0. 
  * If no error occurred, the driver remains registered even if 
  * no device was claimed during registration.
  */
-int pci_register_driver(struct pci_driver *drv)
+int __pci_register_driver(struct pci_driver *drv, struct module *owner)
 {
 	int error;
 
@@ -346,7 +347,7 @@
 	 * the pci shutdown function, this test can go away. */
 	if (!drv->driver.shutdown)
 		drv->driver.shutdown = pci_device_shutdown;
-	drv->driver.owner = drv->owner;
+	drv->driver.owner = owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 
 	spin_lock_init(&drv->dynids.lock);
@@ -483,7 +484,7 @@
 
 EXPORT_SYMBOL(pci_match_id);
 EXPORT_SYMBOL(pci_match_device);
-EXPORT_SYMBOL(pci_register_driver);
+EXPORT_SYMBOL(__pci_register_driver);
 EXPORT_SYMBOL(pci_unregister_driver);
 EXPORT_SYMBOL(pci_dev_driver);
 EXPORT_SYMBOL(pci_bus_type);
Index: linux-2.6-stable/drivers/ide/setup-pci.c
===================================================================
--- linux-2.6-stable.orig/drivers/ide/setup-pci.c
+++ linux-2.6-stable/drivers/ide/setup-pci.c
@@ -787,8 +787,9 @@
 static LIST_HEAD(ide_pci_drivers);
 
 /*
- *	ide_register_pci_driver		-	attach IDE driver
+ *	__ide_register_pci_driver	-	attach IDE driver
  *	@driver: pci driver
+ *	@module: owner module of the driver
  *
  *	Registers a driver with the IDE layer. The IDE layer arranges that
  *	boot time setup is done in the expected device order and then 
@@ -801,15 +802,16 @@
  *	Returns are the same as for pci_register_driver
  */
 
-int ide_pci_register_driver(struct pci_driver *driver)
+int __ide_pci_register_driver(struct pci_driver *driver, struct module *module)
 {
 	if(!pre_init)
-		return pci_module_init(driver);
+		return __pci_register_driver(driver, module);
+	driver->driver.owner = module;
 	list_add_tail(&driver->node, &ide_pci_drivers);
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ide_pci_register_driver);
+EXPORT_SYMBOL_GPL(__ide_pci_register_driver);
 
 /**
  *	ide_unregister_pci_driver	-	unregister an IDE driver
@@ -897,6 +899,6 @@
 	{
 		list_del(l);
 		d = list_entry(l, struct pci_driver, node);
-		pci_register_driver(d);
+		__pci_register_driver(d, d->driver.owner);
 	}
 }
Index: linux-2.6-stable/include/linux/ide.h
===================================================================
--- linux-2.6-stable.orig/include/linux/ide.h
+++ linux-2.6-stable/include/linux/ide.h
@@ -1324,7 +1324,8 @@
 extern int ideprobe_init(void);
 
 extern void ide_scan_pcibus(int scan_direction) __init;
-extern int ide_pci_register_driver(struct pci_driver *driver);
+extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *owner);
+#define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_MODULE)
 extern void ide_pci_unregister_driver(struct pci_driver *driver);
 void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, ata_index_t *);
 extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);

--

