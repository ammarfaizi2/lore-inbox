Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVKDWMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVKDWMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVKDWMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:12:35 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:13204 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751034AbVKDWMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:12:34 -0500
Message-ID: <436BDCCE.2070906@free.fr>
Date: Fri, 04 Nov 2005 23:12:30 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.11) Gecko/20050729
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] PCI: automatically set device_driver.owner
References: <20051027211253.457180000@antares.localdomain> <20051027161744.623e1ada@dxpl.pdx.osdl.net>
In-Reply-To: <20051027161744.623e1ada@dxpl.pdx.osdl.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------020200040503020008000406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200040503020008000406
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit


Le 28.10.2005 01:17, Stephen Hemminger a écrit :
> On Thu, 27 Oct 2005 23:12:54 +0200
> Laurent riffard <laurent.riffard@free.fr> wrote:
> 
> 
>>A nice feature of sysfs is that it can create the symlink from the
>>driver to the module that is contained in it.
>>
>>It requires that the device_driver.owner is set, what is not the
>>case for many PCI drivers.
>>
>>This patch allows pci_register_driver to set automatically the
>>device_driver.owner for any PCI driver.
>>
>>Credits to Al Viro who suggested the method.
>>
>>Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
>>--
> 
> 
> Okay, but a little too much macro trickery for my taste.

It was not clear to me what happened to this patch. Is it rejected?
Or is it accepted as is? Or is a better version waited?

So here is a new version using inline functions instead of macros.
-- 
laurent

--------------020200040503020008000406
Content-Type: text/x-patch;
 name="pci_driver_auto_set_owner-inline_version.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_driver_auto_set_owner-inline_version.patch"

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
 include/linux/ide.h      |    6 +++++-
 include/linux/pci.h      |    8 ++++++--
 4 files changed, 23 insertions(+), 12 deletions(-)

Index: linux-2.6-stable/include/linux/pci.h
===================================================================
--- linux-2.6-stable.orig/include/linux/pci.h
+++ linux-2.6-stable/include/linux/pci.h
@@ -433,7 +433,11 @@
 void pci_enable_bridges(struct pci_bus *bus);
 
 /* New-style probing supporting hot-pluggable devices */
-int pci_register_driver(struct pci_driver *);
+int __pci_register_driver(struct pci_driver *, struct module *);
+static inline int pci_register_driver(struct pci_driver *d)
+{
+	return __pci_register_driver(d, THIS_MODULE);
+}
 void pci_unregister_driver(struct pci_driver *);
 void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
@@ -547,7 +551,7 @@
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
@@ -361,15 +361,16 @@
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
 
@@ -386,7 +387,7 @@
 		printk(KERN_WARNING "Warning: PCI driver %s has a struct "
 			"device_driver shutdown method, please update!\n",
 			drv->name);
-	drv->driver.owner = drv->owner;
+	drv->driver.owner = owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 
 	spin_lock_init(&drv->dynids.lock);
@@ -523,7 +524,7 @@
 
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
@@ -1324,7 +1324,11 @@
 extern int ideprobe_init(void);
 
 extern void ide_scan_pcibus(int scan_direction) __init;
-extern int ide_pci_register_driver(struct pci_driver *driver);
+extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *owner);
+static inline int ide_pci_register_driver(struct pci_driver *d)
+{
+	return __ide_pci_register_driver(d, THIS_MODULE);
+}
 extern void ide_pci_unregister_driver(struct pci_driver *driver);
 void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, ata_index_t *);
 extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);

--------------020200040503020008000406--
