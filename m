Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269329AbUJWE4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269329AbUJWE4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUJWEuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:50:32 -0400
Received: from [211.58.254.17] ([211.58.254.17]:40593 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S269329AbUJWEcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:32:04 -0400
Date: Sat, 23 Oct 2004 13:31:57 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (14/16)
Message-ID: <20041023043157.GO3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_14_devparam_apply.diff

 This is the 14th patch of 16 patches for devparam.

 This patch hooks devparam into the driver-model.  Devparam is
complete now.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/drivers/base/bus.c
===================================================================
--- linux-devparam-export.orig/drivers/base/bus.c	2004-10-22 17:12:56.000000000 +0900
+++ linux-devparam-export/drivers/base/bus.c	2004-10-23 11:09:33.000000000 +0900
@@ -265,18 +265,27 @@ void device_bind_driver(struct device * 
  */
 static int bus_match(struct device * dev, struct device_driver * drv)
 {
-	int error = -ENODEV;
-	if (dev->bus->match(dev, drv)) {
-		dev->driver = drv;
-		if (drv->probe) {
-			if ((error = drv->probe(dev))) {
-				dev->driver = NULL;
-				return error;
-			}
-		}
-		device_bind_driver(dev);
-		error = 0;
-	}
+	int error;
+
+	if (dev->bus->match(dev, drv) == 0)
+		return -ENODEV;
+
+	dev->driver = drv;
+
+	if ((error = devparam_set_params(dev, NULL)))
+		goto devparam_fail;
+
+	if (drv->probe && (error = drv->probe(dev)) != 0)
+		goto probe_fail;
+
+	device_bind_driver(dev);
+
+	return 0;
+
+ probe_fail:
+	devparam_release_params(dev);
+ devparam_fail:
+	dev->driver = NULL;
 	return error;
 }
 
@@ -372,6 +381,7 @@ void device_release_driver(struct device
 		device_detach_shutdown(dev);
 		if (drv->remove)
 			drv->remove(dev);
+		devparam_release_params(dev);
 		dev->driver = NULL;
 	}
 }
@@ -670,10 +680,14 @@ int bus_register(struct bus_type * bus)
 	if (retval)
 		goto out;
 
+	retval = devparam_bus_init(bus);
+	if (retval)
+		goto out;
+
 	subsys_set_kset(bus, bus_subsys);
 	retval = subsystem_register(&bus->subsys);
 	if (retval)
-		goto out;
+		goto bus_subsys_fail;
 
 	kobject_set_name(&bus->devices.kobj, "devices");
 	bus->devices.subsys = &bus->subsys;
@@ -696,6 +710,8 @@ bus_drivers_fail:
 	kset_unregister(&bus->devices);
 bus_devices_fail:
 	subsystem_unregister(&bus->subsys);
+bus_subsys_fail:
+	devparam_bus_release(bus);
 out:
 	return retval;
 }
Index: linux-devparam-export/drivers/base/core.c
===================================================================
--- linux-devparam-export.orig/drivers/base/core.c	2004-10-22 17:12:56.000000000 +0900
+++ linux-devparam-export/drivers/base/core.c	2004-10-23 11:09:33.000000000 +0900
@@ -194,6 +194,7 @@ void device_initialize(struct device *de
 	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->bus_list);
 	INIT_LIST_HEAD(&dev->dma_pools);
+	devparam_params_init(&dev->params);
 }
 
 /**
Index: linux-devparam-export/drivers/base/driver.c
===================================================================
--- linux-devparam-export.orig/drivers/base/driver.c	2004-10-22 17:12:56.000000000 +0900
+++ linux-devparam-export/drivers/base/driver.c	2004-10-23 11:09:33.000000000 +0900
@@ -85,9 +85,14 @@ void put_driver(struct device_driver * d
  */
 int driver_register(struct device_driver * drv)
 {
+	int ret;
 	INIT_LIST_HEAD(&drv->devices);
 	init_MUTEX_LOCKED(&drv->unload_sem);
-	return bus_add_driver(drv);
+	if ((ret = devparam_driver_init(drv)) < 0)
+		return ret;
+	if ((ret = bus_add_driver(drv)) < 0)
+		devparam_driver_release(drv);
+	return ret;
 }
 
 
@@ -109,6 +114,7 @@ void driver_unregister(struct device_dri
 	bus_remove_driver(drv);
 	down(&drv->unload_sem);
 	up(&drv->unload_sem);
+	devparam_driver_release(drv);
 }
 
 /**
Index: linux-devparam-export/init/main.c
===================================================================
--- linux-devparam-export.orig/init/main.c	2004-10-23 11:09:30.000000000 +0900
+++ linux-devparam-export/init/main.c	2004-10-23 11:09:33.000000000 +0900
@@ -38,6 +38,7 @@
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
+#include <linux/deviceparam.h>
 #include <linux/kallsyms.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
@@ -285,22 +286,24 @@ __setup("quiet", quiet_kernel);
  */
 static int __init unknown_bootoption(char *param, char *val, void *arg)
 {
+	char *cp = NULL;
+
 	/* Change NUL term back to "=", to make "param" the whole string. */
 	if (val) {
-		if (val[-1] == '"') val[-2] = '=';
-		else val[-1] = '=';
+		cp = val[-1] == '"' ? val - 2 : val - 1;
+		*cp = '=';
 	}
 
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))
 		return 0;
 
-	/*
-	 * Preemptive maintenance for "why didn't my mispelled command
-	 * line work?"
-	 */
+	/* It might be a device parameter, pass it to deviceparam facility. */
 	if (strchr(param, '.') && (!val || strchr(param, '.') < val)) {
-		printk(KERN_ERR "Unknown boot option `%s': ignoring\n", param);
+		/* Restore NUL term. */
+		if (cp)
+			*cp = '\0';
+		devparam_maybe_bootopt(param, val);
 		return 0;
 	}
 
@@ -643,6 +646,8 @@ static void __init do_basic_setup(void)
 	sock_init();
 
 	do_initcalls();
+
+	devparam_finish_bootopts();
 }
 
 static void do_pre_smp_initcalls(void)
Index: linux-devparam-export/kernel/module.c
===================================================================
--- linux-devparam-export.orig/kernel/module.c	2004-10-23 11:09:30.000000000 +0900
+++ linux-devparam-export/kernel/module.c	2004-10-23 11:09:33.000000000 +0900
@@ -29,6 +29,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <linux/deviceparam.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/vermagic.h>
@@ -1760,6 +1761,10 @@ static struct module *load_module(void _
 	if (err < 0)
 		goto cleanup;
 
+	/* Set up device args vector */
+	if (devparam_module_init(mod) < 0)
+		goto arch_cleanup;
+
 	mod->args = args;
 	if (obsparmindex) {
 		err = obsolete_params(mod->name, mod->args,
@@ -1780,7 +1785,7 @@ static struct module *load_module(void _
 				 sechdrs[setupindex].sh_addr,
 				 sechdrs[setupindex].sh_size
 				 / sizeof(struct kernel_param),
-				 NULL, NULL);
+				 devparam_unknown_modparam, mod);
 	}
 	err = mod_sysfs_setup(mod, 
 			      (struct kernel_param *)
@@ -1788,7 +1793,7 @@ static struct module *load_module(void _
 			      sechdrs[setupindex].sh_size
 			      / sizeof(struct kernel_param));
 	if (err < 0)
-		goto arch_cleanup;
+		goto devparam_done;
 	add_sect_attrs(mod, hdr->e_shnum, secstrings, sechdrs);
 
 	/* Get rid of temporary copy */
@@ -1797,6 +1802,8 @@ static struct module *load_module(void _
 	/* Done! */
 	return mod;
 
+ devparam_done:
+	devparam_module_done(mod);
  arch_cleanup:
 	module_arch_cleanup(mod);
  cleanup:
@@ -1868,6 +1875,10 @@ sys_init_module(void __user *umod,
 	/* Start the module */
 	if (mod->init != NULL)
 		ret = mod->init();
+
+	/* We're done with device params */
+	devparam_module_done(mod);
+
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
