Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUITRaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUITRaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUITRaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:30:19 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:19865 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266820AbUITR36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:29:58 -0400
Subject: [RFC] put symbolic links between drivers and modules in the sysfs
	tree
From: James Bottomley <James.Bottomley@SteelEye.com>
To: greg@kroah.com, Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Sep 2004 13:29:44 -0400
Message-Id: <1095701390.2016.34.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This functionality is essential for us to work out which drivers are
supplied by which modules.  We use this in turn to work out which
modules are necessary to find the root device (and hence what
initrd/initramfs needs to insert).

If you look at debian at the moment, it uses a huge mapping table on
/proc/scsi/* to do this.  If we implement the sysfs feature, we can
simply go from /sys/block/<device> to the actual device to the driver
and then to the module with no need of any fixed tables.

The code is a first cut and introduces two new module APIs:
module_add_driver() and module_remove_driver().  We need this because
the generic device model driver has no current knowledge of modules.  We
could enhance it to have a struct module * in struct device_driver, but
once we have the sysfs links which this patch provides, there didn't
seem to be a compelling reason to add it to struct device_driver.

Comments?

James

===== drivers/base/bus.c 1.62 vs edited =====
--- 1.62/drivers/base/bus.c	2004-07-07 19:55:49 -05:00
+++ edited/drivers/base/bus.c	2004-09-20 11:09:52 -05:00
@@ -553,6 +553,7 @@
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
 		up_write(&drv->bus->subsys.rwsem);
+		module_remove_driver(drv);
 		kobject_unregister(&drv->kobj);
 		put_bus(drv->bus);
 	}
===== drivers/scsi/hosts.c 1.101 vs edited =====
--- 1.101/drivers/scsi/hosts.c	2004-09-09 16:16:26 -05:00
+++ edited/drivers/scsi/hosts.c	2004-09-20 10:49:08 -05:00
@@ -130,6 +130,11 @@
 		goto out_del_classdev;
 
 	scsi_proc_host_add(shost);
+	if (shost->hostt->module && shost->shost_gendev.parent &&
+	    shost->shost_gendev.parent->driver)
+		module_add_driver(shost->hostt->module, 
+				  shost->shost_gendev.parent->driver);
+		
 	return error;
 
  out_del_classdev:
===== include/linux/module.h 1.79 vs edited =====
--- 1.79/include/linux/module.h	2004-06-27 02:19:28 -05:00
+++ edited/include/linux/module.h	2004-09-20 11:06:13 -05:00
@@ -578,6 +578,9 @@
 
 #define __MODULE_STRING(x) __stringify(x)
 
+/* forward reference for the module_add/remove_driver API */
+struct device_driver;
+
 /* Use symbol_get and symbol_put instead.  You'll thank me. */
 #define HAVE_INTER_MODULE
 extern void inter_module_register(const char *, struct module *, const void *);
@@ -585,5 +588,7 @@
 extern const void *inter_module_get(const char *);
 extern const void *inter_module_get_request(const char *, const char *);
 extern void inter_module_put(const char *);
+extern void module_add_driver(struct module *, struct device_driver *);
+extern void module_remove_driver(struct device_driver *);
 
 #endif /* _LINUX_MODULE_H */
===== kernel/module.c 1.120 vs edited =====
--- 1.120/kernel/module.c	2004-09-08 01:33:04 -05:00
+++ edited/kernel/module.c	2004-09-20 11:10:47 -05:00
@@ -34,6 +34,7 @@
 #include <linux/vermagic.h>
 #include <linux/notifier.h>
 #include <linux/stop_machine.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
@@ -2139,6 +2140,30 @@
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
+	/* Note: Perhaps we should store this link in the
+	 * device_driver structure as well (i.e. have a struct module *
+	 * element). */
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



