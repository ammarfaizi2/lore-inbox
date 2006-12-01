Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162257AbWLAXZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162257AbWLAXZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162247AbWLAXYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:24:24 -0500
Received: from mx1.suse.de ([195.135.220.2]:65165 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162248AbWLAXYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:24:17 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 36/36] Driver core: show drivers in /sys/module/
Date: Fri,  1 Dec 2006 15:22:06 -0800
Message-Id: <1165015446780-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154423690-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com> <11650154181661-git-send-email-greg@kroah.com> <11650154221716-git-send-email-greg@kroah.com> <11650154251022-git-send-email-greg@kroah.com> <11650154282911-git-send-email-greg@kroah.com> <11650154311175-git-send-email-greg@kroah.com> <11650154353407-git-send-email-greg@kroah.com> <1165015439206-git-send-email-greg@kroah.com> <11650154423690-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Show the drivers, which belong to the module:
  $ ls -l /sys/module/usbcore/drivers/
  hub -> ../../../bus/usb/drivers/hub
  usb -> ../../../bus/usb/drivers/usb
  usbfs -> ../../../bus/usb/drivers/usbfs

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/module.h |    1 +
 kernel/module.c        |   31 +++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index d1d00ce..9258ffd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -264,6 +264,7 @@ struct module
 	struct module_attribute *modinfo_attrs;
 	const char *version;
 	const char *srcversion;
+	struct kobject *drivers_dir;
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
diff --git a/kernel/module.c b/kernel/module.c
index f016656..45e01cb 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1086,22 +1086,35 @@ static int mod_sysfs_setup(struct module
 		goto out;
 	kobj_set_kset_s(&mod->mkobj, module_subsys);
 	mod->mkobj.mod = mod;
-	err = kobject_register(&mod->mkobj.kobj);
+
+	/* delay uevent until full sysfs population */
+	kobject_init(&mod->mkobj.kobj);
+	err = kobject_add(&mod->mkobj.kobj);
 	if (err)
 		goto out;
 
+	mod->drivers_dir = kobject_add_dir(&mod->mkobj.kobj, "drivers");
+	if (!mod->drivers_dir)
+		goto out_unreg;
+
 	err = module_param_sysfs_setup(mod, kparam, num_params);
 	if (err)
-		goto out_unreg;
+		goto out_unreg_drivers;
 
 	err = module_add_modinfo_attrs(mod);
 	if (err)
-		goto out_unreg;
+		goto out_unreg_param;
 
+	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
 	return 0;
 
+out_unreg_drivers:
+	kobject_unregister(mod->drivers_dir);
+out_unreg_param:
+	module_param_sysfs_remove(mod);
 out_unreg:
-	kobject_unregister(&mod->mkobj.kobj);
+	kobject_del(&mod->mkobj.kobj);
+	kobject_put(&mod->mkobj.kobj);
 out:
 	return err;
 }
@@ -1110,6 +1123,7 @@ static void mod_kobject_remove(struct mo
 {
 	module_remove_modinfo_attrs(mod);
 	module_param_sysfs_remove(mod);
+	kobject_unregister(mod->drivers_dir);
 
 	kobject_unregister(&mod->mkobj.kobj);
 }
@@ -2275,11 +2289,14 @@ void print_modules(void)
 
 void module_add_driver(struct module *mod, struct device_driver *drv)
 {
+	int no_warn;
+
 	if (!mod || !drv)
 		return;
 
-	/* Don't check return code; this call is idempotent */
-	sysfs_create_link(&drv->kobj, &mod->mkobj.kobj, "module");
+	/* Don't check return codes; these calls are idempotent */
+	no_warn = sysfs_create_link(&drv->kobj, &mod->mkobj.kobj, "module");
+	no_warn = sysfs_create_link(mod->drivers_dir, &drv->kobj, drv->name);
 }
 EXPORT_SYMBOL(module_add_driver);
 
@@ -2288,6 +2305,8 @@ void module_remove_driver(struct device_
 	if (!drv)
 		return;
 	sysfs_remove_link(&drv->kobj, "module");
+	if (drv->owner && drv->owner->drivers_dir)
+		sysfs_remove_link(drv->owner->drivers_dir, drv->name);
 }
 EXPORT_SYMBOL(module_remove_driver);
 
-- 
1.4.4.1

