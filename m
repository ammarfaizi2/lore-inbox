Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269855AbUJSQzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269855AbUJSQzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269786AbUJSQx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:53:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:52932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269785AbUJSQip convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:45 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <1098203779656@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:21 -0700
Message-Id: <10982037811163@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.1.47, 2004/09/22 16:09:41-07:00, greg@kroah.com

[PATCH] Put symbolic links between drivers and modules in the sysfs tree

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


 drivers/base/bus.c     |    2 ++
 include/linux/device.h |    2 ++
 include/linux/module.h |   14 ++++++++++++++
 kernel/module.c        |   21 +++++++++++++++++++++
 4 files changed, 39 insertions(+)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-10-19 09:22:29 -07:00
+++ b/drivers/base/bus.c	2004-10-19 09:22:29 -07:00
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
--- a/include/linux/device.h	2004-10-19 09:22:29 -07:00
+++ b/include/linux/device.h	2004-10-19 09:22:29 -07:00
@@ -106,6 +106,8 @@
 	struct kobject		kobj;
 	struct list_head	devices;
 
+	struct module 		* owner;
+
 	int	(*probe)	(struct device * dev);
 	int 	(*remove)	(struct device * dev);
 	void	(*shutdown)	(struct device * dev);
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	2004-10-19 09:22:29 -07:00
+++ b/include/linux/module.h	2004-10-19 09:22:29 -07:00
@@ -445,6 +445,11 @@
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
@@ -534,6 +539,15 @@
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
--- a/kernel/module.c	2004-10-19 09:22:29 -07:00
+++ b/kernel/module.c	2004-10-19 09:22:29 -07:00
@@ -34,6 +34,7 @@
 #include <linux/vermagic.h>
 #include <linux/notifier.h>
 #include <linux/stop_machine.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
@@ -2139,6 +2140,26 @@
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

