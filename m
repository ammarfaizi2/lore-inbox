Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbUKDHFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUKDHFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUKDHFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:05:45 -0500
Received: from [211.58.254.17] ([211.58.254.17]:39840 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262110AbUKDGyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:54:01 -0500
Date: Thu, 4 Nov 2004 15:53:58 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 13/15] driver-model: devparam applied
Message-ID: <20041104065358.GM24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_13_devparam_apply.patch

 This is the 13th patch of 15 patches for devparam.

 This patch hooks devparam into the driver-model.  Devparam is
complete now.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/bus.c
===================================================================
--- linux-export.orig/drivers/base/bus.c	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/drivers/base/bus.c	2004-11-04 14:26:03.000000000 +0900
@@ -266,20 +266,30 @@ void device_bind_driver(struct device * 
  */
 int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
+	int error;
+
 	if (drv->bus->match && !drv->bus->match(dev, drv))
 		return -ENODEV;
 
 	dev->driver = drv;
+
+	if ((error = devparam_set_params(dev)) != 0)
+		goto devparam_fail;
+
 	if (drv->probe) {
-		int error = drv->probe(dev);
-		if (error) {
-			dev->driver = NULL;
-			return error;
-		}
+		error = drv->probe(dev);
+		if (error)
+			goto probe_fail;
 	}
 
 	device_bind_driver(dev);
 	return 0;
+
+ probe_fail:
+	devparam_release_params(dev);
+ devparam_fail:
+	dev->driver = NULL;
+	return error;
 }
 
 
@@ -376,6 +386,7 @@ void device_release_driver(struct device
 		device_detach_shutdown(dev);
 		if (drv->remove)
 			drv->remove(dev);
+		devparam_release_params(dev);
 		dev->driver = NULL;
 	}
 }
Index: linux-export/drivers/base/driver.c
===================================================================
--- linux-export.orig/drivers/base/driver.c	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/drivers/base/driver.c	2004-11-04 14:26:03.000000000 +0900
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
Index: linux-export/init/main.c
===================================================================
--- linux-export.orig/init/main.c	2004-11-04 14:25:59.000000000 +0900
+++ linux-export/init/main.c	2004-11-04 14:26:03.000000000 +0900
@@ -38,6 +38,7 @@
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
+#include <linux/deviceparam.h>
 #include <linux/kallsyms.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
@@ -286,29 +287,32 @@ __setup("quiet", quiet_kernel);
  */
 static int __init unknown_bootoption(char *param, char *val, void *arg)
 {
+	char *cp = NULL;
+
 	/* Change NUL term back to "=", to make "param" the whole string. */
 	if (val) {
 		/* param=val or param="val"? */
 		if (val == param+strlen(param)+1)
-			val[-1] = '=';
+			cp = val - 1;
 		else if (val == param+strlen(param)+2) {
-			val[-2] = '=';
+			cp = val - 2;
 			memmove(val-1, val, strlen(val)+1);
 			val--;
 		} else
 			BUG();
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
 
@@ -652,6 +656,8 @@ static void __init do_basic_setup(void)
 	sock_init();
 
 	do_initcalls();
+
+	devparam_finish_bootopts();
 }
 
 static void do_pre_smp_initcalls(void)
Index: linux-export/kernel/module.c
===================================================================
--- linux-export.orig/kernel/module.c	2004-11-04 14:25:59.000000000 +0900
+++ linux-export/kernel/module.c	2004-11-04 14:26:03.000000000 +0900
@@ -29,6 +29,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <linux/deviceparam.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/vermagic.h>
@@ -1696,6 +1697,10 @@ static struct module *load_module(void _
 	if (err < 0)
 		goto cleanup;
 
+	/* Set up device args vector */
+	if (devparam_module_init(mod) < 0)
+		goto arch_cleanup;
+
 	mod->args = args;
 	if (obsparmindex) {
 		err = obsolete_params(mod->name, mod->args,
@@ -1716,7 +1721,7 @@ static struct module *load_module(void _
 				 sechdrs[setupindex].sh_addr,
 				 sechdrs[setupindex].sh_size
 				 / sizeof(struct kernel_param),
-				 NULL, NULL);
+				 devparam_unknown_modparam, mod);
 	}
 	err = mod_sysfs_setup(mod, 
 			      (struct kernel_param *)
@@ -1724,7 +1729,7 @@ static struct module *load_module(void _
 			      sechdrs[setupindex].sh_size
 			      / sizeof(struct kernel_param));
 	if (err < 0)
-		goto arch_cleanup;
+		goto devparam_done;
 	add_sect_attrs(mod, hdr->e_shnum, secstrings, sechdrs);
 
 	/* Get rid of temporary copy */
@@ -1733,6 +1738,8 @@ static struct module *load_module(void _
 	/* Done! */
 	return mod;
 
+ devparam_done:
+	devparam_module_done(mod);
  arch_cleanup:
 	module_arch_cleanup(mod);
  cleanup:
@@ -1804,6 +1811,10 @@ sys_init_module(void __user *umod,
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
