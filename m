Return-Path: <linux-kernel-owner+w=401wt.eu-S1750744AbXAEUpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbXAEUpZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbXAEUpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:45:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:56156 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbXAEUpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:45:24 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/1] [PATCH] Driver core: Fix prefix driver links in /sys/module by bus-name
Date: Fri,  5 Jan 2007 12:44:55 -0800
Message-Id: <11680298951311-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <20070105204158.GC7222@kroah.com>
References: <20070105204158.GC7222@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Modules may have drivers with the same name on different buses.
This patch fixes this problem.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/module.c |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index dbce132..d0f2260 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1148,10 +1148,10 @@ static int mod_sysfs_setup(struct module *mod,
 	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
 	return 0;
 
-out_unreg_drivers:
-	kobject_unregister(mod->drivers_dir);
 out_unreg_param:
 	module_param_sysfs_remove(mod);
+out_unreg_drivers:
+	kobject_unregister(mod->drivers_dir);
 out_unreg:
 	kobject_del(&mod->mkobj.kobj);
 	kobject_put(&mod->mkobj.kobj);
@@ -2327,8 +2327,22 @@ void print_modules(void)
 	printk("\n");
 }
 
+static char *make_driver_name(struct device_driver *drv)
+{
+	char *driver_name;
+
+	driver_name = kmalloc(strlen(drv->name) + strlen(drv->bus->name) + 2,
+			      GFP_KERNEL);
+	if (!driver_name)
+		return NULL;
+
+	sprintf(driver_name, "%s:%s", drv->bus->name, drv->name);
+	return driver_name;
+}
+
 void module_add_driver(struct module *mod, struct device_driver *drv)
 {
+	char *driver_name;
 	int no_warn;
 
 	if (!mod || !drv)
@@ -2336,17 +2350,31 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
 
 	/* Don't check return codes; these calls are idempotent */
 	no_warn = sysfs_create_link(&drv->kobj, &mod->mkobj.kobj, "module");
-	no_warn = sysfs_create_link(mod->drivers_dir, &drv->kobj, drv->name);
+	driver_name = make_driver_name(drv);
+	if (driver_name) {
+		no_warn = sysfs_create_link(mod->drivers_dir, &drv->kobj,
+					    driver_name);
+		kfree(driver_name);
+	}
 }
 EXPORT_SYMBOL(module_add_driver);
 
 void module_remove_driver(struct device_driver *drv)
 {
+	char *driver_name;
+
 	if (!drv)
 		return;
+
 	sysfs_remove_link(&drv->kobj, "module");
-	if (drv->owner && drv->owner->drivers_dir)
-		sysfs_remove_link(drv->owner->drivers_dir, drv->name);
+	if (drv->owner && drv->owner->drivers_dir) {
+		driver_name = make_driver_name(drv);
+		if (driver_name) {
+			sysfs_remove_link(drv->owner->drivers_dir,
+					  driver_name);
+			kfree(driver_name);
+		}
+	}
 }
 EXPORT_SYMBOL(module_remove_driver);
 
-- 
1.4.4.3

