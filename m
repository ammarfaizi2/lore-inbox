Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUIVXIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUIVXIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUIVXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:08:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:28595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268094AbUIVXH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:07:28 -0400
Date: Wed, 22 Sep 2004 16:04:23 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC] put symbolic links between drivers and modules in the sysfs tree
Message-ID: <20040922230423.GA14279@kroah.com>
References: <1095701390.2016.34.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095701390.2016.34.camel@mulgrave>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 01:29:44PM -0400, James Bottomley wrote:
> This functionality is essential for us to work out which drivers are
> supplied by which modules.  We use this in turn to work out which
> modules are necessary to find the root device (and hence what
> initrd/initramfs needs to insert).
> 
> If you look at debian at the moment, it uses a huge mapping table on
> /proc/scsi/* to do this.  If we implement the sysfs feature, we can
> simply go from /sys/block/<device> to the actual device to the driver
> and then to the module with no need of any fixed tables.
> 
> The code is a first cut and introduces two new module APIs:
> module_add_driver() and module_remove_driver().  We need this because
> the generic device model driver has no current knowledge of modules.  We
> could enhance it to have a struct module * in struct device_driver, but
> once we have the sysfs links which this patch provides, there didn't
> seem to be a compelling reason to add it to struct device_driver.
> 
> Comments?

I like it.  But I do think that this should be moved into the driver
core, so I added a "struct module *" to "struct device_driver".  Here's
the patch that I just applied to my trees, based on yours.  It is only
the core changes (and yes, I did fix up the location of the functions in
the module.h file and fixed the bug when modules were not configured
in.)  I'll post my usb core change after this, to show you how USB can
be hooked up to it.  I'll let you figure out what the best way to handle
the scsi code would be.

thanks again for the patch.

greg k-h

---------


Put symbolic links between drivers and modules in the sysfs tree

This functionality is essential for us to work out which drivers are
supplied by which modules.  We use this in turn to work out which
modules are necessary to find the root device (and hence what
initrd/initramfs needs to insert).

If you look at debian at the moment, it uses a huge mapping table on
/proc/scsi/* to do this.  If we implement the sysfs feature, we can
simply go from /sys/block/<device> to the actual device to the driver
and then to the module with no need of any fixed tables.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-09-22 15:56:32 -07:00
+++ b/drivers/base/bus.c	2004-09-22 15:56:32 -07:00
@@ -529,6 +529,7 @@
 		down_write(&bus->subsys.rwsem);
 		driver_attach(drv);
 		up_write(&bus->subsys.rwsem);
+		module_add_driver(drv->owner, drv);
 
 		driver_add_attrs(bus, drv);
 	}
@@ -553,6 +554,7 @@
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
 		up_write(&drv->bus->subsys.rwsem);
+		module_remove_driver(drv);
 		kobject_unregister(&drv->kobj);
 		put_bus(drv->bus);
 	}
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-09-22 15:56:32 -07:00
+++ b/include/linux/device.h	2004-09-22 15:56:32 -07:00
@@ -106,6 +106,8 @@
 	struct kobject		kobj;
 	struct list_head	devices;
 
+	struct module 		* owner;
+
 	int	(*probe)	(struct device * dev);
 	int 	(*remove)	(struct device * dev);
 	void	(*shutdown)	(struct device * dev);
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	2004-09-22 15:56:32 -07:00
+++ b/include/linux/module.h	2004-09-22 15:56:32 -07:00
@@ -451,6 +451,11 @@
 int unregister_module_notifier(struct notifier_block * nb);
 
 extern void print_modules(void);
+
+struct device_driver;
+void module_add_driver(struct module *, struct device_driver *);
+void module_remove_driver(struct device_driver *);
+
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
@@ -540,6 +545,15 @@
 static inline void print_modules(void)
 {
 }
+
+static inline void module_add_driver(struct module *, struct device_driver *)
+{
+}
+
+static inline void module_remove_driver(struct device_driver *)
+{
+}
+
 #endif /* CONFIG_MODULES */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	2004-09-22 15:56:32 -07:00
+++ b/kernel/module.c	2004-09-22 15:56:32 -07:00
@@ -34,6 +34,7 @@
 #include <linux/vermagic.h>
 #include <linux/notifier.h>
 #include <linux/stop_machine.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
@@ -2187,6 +2188,26 @@
 		printk(" %s", mod->name);
 	printk("\n");
 }
+
+void module_add_driver(struct module *mod, struct device_driver *drv)
+{
+	if (!mod || !drv)
+		return;
+	if (!mod->mkobj)
+		return;
+
+	/* Don't check return code; this call is idempotent */
+	sysfs_create_link(&drv->kobj, &mod->mkobj->kobj, "module");
+}
+EXPORT_SYMBOL(module_add_driver);
+
+void module_remove_driver(struct device_driver *drv)
+{
+	if (!drv)
+		return;
+	sysfs_remove_link(&drv->kobj, "module");
+}
+EXPORT_SYMBOL(module_remove_driver);
 
 #ifdef CONFIG_MODVERSIONS
 /* Generate the signature for struct module here, too, for modversions. */
