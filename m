Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVJZWx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVJZWx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 18:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVJZWx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 18:53:27 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:8367 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751501AbVJZWx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 18:53:27 -0400
Message-ID: <436008E4.2010204@free.fr>
Date: Thu, 27 Oct 2005 00:53:24 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.11) Gecko/20050729
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 1/3] remove pci_driver.owner and .name fields
References: <20051026204802.123045000@antares.localdomain> <20051026204909.179264000@antares.localdomain> <20051026212017.GT7992@ftp.linux.org.uk>
In-Reply-To: <20051026212017.GT7992@ftp.linux.org.uk>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------020608060301050209010304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608060301050209010304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit



Le 26.10.2005 23:20, Al Viro a écrit :
> On Wed, Oct 26, 2005 at 10:48:03PM +0200, Laurent riffard wrote:
> 
>>--- linux-2.6-stable.orig/drivers/ide/setup-pci.c
>>+++ linux-2.6-stable/drivers/ide/setup-pci.c
>>@@ -787,8 +787,9 @@
>> static LIST_HEAD(ide_pci_drivers);
>> 
>> /*
>>- *	ide_register_pci_driver		-	attach IDE driver
>>+ *	__ide_register_pci_driver	-	attach IDE driver
>>  *	@driver: pci driver
>>+ *	@module: owner module of the driver
>>  *
>>  *	Registers a driver with the IDE layer. The IDE layer arranges that
>>  *	boot time setup is done in the expected device order and then 
>>@@ -801,15 +802,16 @@
>>  *	Returns are the same as for pci_register_driver
>>  */
>> 
>>-int ide_pci_register_driver(struct pci_driver *driver)
>>+int __ide_pci_register_driver(struct pci_driver *driver, struct module *module)
>> {
>> 	if(!pre_init)
>>-		return pci_module_init(driver);
>>+		return __pci_register_driver(driver, module);
>>+	driver->driver.owner = module;
>> 	list_add_tail(&driver->node, &ide_pci_drivers);
>> 	return 0;
>> }
>> 
>>-EXPORT_SYMBOL_GPL(ide_pci_register_driver);
>>+EXPORT_SYMBOL_GPL(__ide_pci_register_driver);
> 
> 
> Not enough - you have to deal with pci_register_driver() call later in
> the same file.  Replace with __pci_register_driver(d, d->driver.owner)...

My bad, I should have have tried to check that...

Here is an updated patch, it includes your above remark and some
fixes related to .name deletion.

thanks
-- 
laurent

--------------020608060301050209010304
Content-Type: text/x-patch;
 name="remove_pci_driver_owner_name-pci_core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_pci_driver_owner_name-pci_core.patch"

pci_driver.name and .owner are duplicates of pci_driver.driver.name
and .owner.

This patch prepares the core pci code for future removal of the 2
pci_driver's fields, but actually do not remove them. 

Driver developpers should set pci_driver.driver.name, while
pci_driver.driver.owner will be set by pci_register_driver.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/ide/setup-pci.c  |   12 +++++++-----
 drivers/pci/pci-driver.c |   19 +++++++++++++------
 drivers/pci/proc.c       |    2 +-
 include/linux/ide.h      |    3 ++-
 include/linux/pci.h      |   11 +++++++++--
 5 files changed, 32 insertions(+), 15 deletions(-)

Index: linux-2.6-stable/include/linux/pci.h
===================================================================
--- linux-2.6-stable.orig/include/linux/pci.h
+++ linux-2.6-stable/include/linux/pci.h
@@ -664,6 +664,12 @@
 struct module;
 struct pci_driver {
 	struct list_head node;
+	/*
+	 * Please do not use the 2 following fields, they are planned for
+	 * deletion.
+	 * Use driver.name instead of .name.
+	 * The field driver.owner will be set by pci_register_driver.
+	 */
 	char *name;
 	struct module *owner;
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
@@ -857,7 +863,8 @@
 void pci_enable_bridges(struct pci_bus *bus);
 
 /* New-style probing supporting hot-pluggable devices */
-int pci_register_driver(struct pci_driver *);
+int __pci_register_driver(struct pci_driver *, struct module *);
+#define pci_register_driver(d) __pci_register_driver(d, THIS_MODULE)
 void pci_unregister_driver(struct pci_driver *);
 void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
@@ -957,7 +964,7 @@
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
@@ -325,20 +325,25 @@
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
 
 	/* initialize common driver fields */
-	drv->driver.name = drv->name;
+	if (drv->name) {
+		/* backward compatibility until all pci_driver are converted to
+		 * use pci_driver.driver.name instead of pci_driver.name */
+		drv->driver.name = drv->name;
+	}
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.probe = pci_device_probe;
 	drv->driver.remove = pci_device_remove;
@@ -346,7 +351,7 @@
 	 * the pci shutdown function, this test can go away. */
 	if (!drv->driver.shutdown)
 		drv->driver.shutdown = pci_device_shutdown;
-	drv->driver.owner = drv->owner;
+	drv->driver.owner = owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 
 	spin_lock_init(&drv->dynids.lock);
@@ -379,7 +384,9 @@
 }
 
 static struct pci_driver pci_compat_driver = {
-	.name = "compat"
+	.driver = {
+		.name = "compat"
+	}
 };
 
 /**
@@ -483,7 +490,7 @@
 
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
Index: linux-2.6-stable/drivers/pci/proc.c
===================================================================
--- linux-2.6-stable.orig/drivers/pci/proc.c
+++ linux-2.6-stable/drivers/pci/proc.c
@@ -371,7 +371,7 @@
 	}
 	seq_putc(m, '\t');
 	if (drv)
-		seq_printf(m, "%s", drv->name);
+		seq_printf(m, "%s", drv->driver.name);
 	seq_putc(m, '\n');
 	return 0;
 }

--------------020608060301050209010304--
