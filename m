Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUJWD2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUJWD2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUJVXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:16:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:19619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269091AbUJVXKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:10:17 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <1098486571899@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 22 Oct 2004 16:09:31 -0700
Message-Id: <10984865713952@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2019, 2004/10/22 14:01:16-07:00, shemminger@osdl.org

[PATCH] avoid problems with kobject_set_name and name with %

kobject_set_name takes a printf style argument list. There are many
callers that pass only one string, if this string contained a '%' character
than bad things would happen.  The fix is simple.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c                     |    4 ++--
 drivers/base/class.c                   |    4 ++--
 drivers/base/core.c                    |    2 +-
 drivers/firmware/efivars.c             |    2 +-
 drivers/pci/hotplug/pci_hotplug_core.c |    2 +-
 fs/sysfs/dir.c                         |    2 +-
 kernel/module.c                        |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-10-22 16:00:16 -07:00
+++ b/drivers/base/bus.c	2004-10-22 16:00:16 -07:00
@@ -515,7 +515,7 @@
 
 	if (bus) {
 		pr_debug("bus %s: add driver %s\n", bus->name, drv->name);
-		error = kobject_set_name(&drv->kobj, drv->name);
+		error = kobject_set_name(&drv->kobj, "%s", drv->name);
 		if (error) {
 			put_bus(bus);
 			return error;
@@ -666,7 +666,7 @@
 {
 	int retval;
 
-	retval = kobject_set_name(&bus->subsys.kset.kobj, bus->name);
+	retval = kobject_set_name(&bus->subsys.kset.kobj, "%s", bus->name);
 	if (retval)
 		goto out;
 
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2004-10-22 16:00:16 -07:00
+++ b/drivers/base/class.c	2004-10-22 16:00:16 -07:00
@@ -139,7 +139,7 @@
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
-	error = kobject_set_name(&cls->subsys.kset.kobj, cls->name);
+	error = kobject_set_name(&cls->subsys.kset.kobj, "%s", cls->name);
 	if (error)
 		return error;
 
@@ -368,7 +368,7 @@
 		 class_dev->class_id);
 
 	/* first, register with generic layer. */
-	kobject_set_name(&class_dev->kobj, class_dev->class_id);
+	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
 	if (parent)
 		class_dev->kobj.parent = &parent->subsys.kset.kobj;
 
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-10-22 16:00:16 -07:00
+++ b/drivers/base/core.c	2004-10-22 16:00:16 -07:00
@@ -221,7 +221,7 @@
 	pr_debug("DEV: registering device: ID = '%s'\n", dev->bus_id);
 
 	/* first, register with generic layer. */
-	kobject_set_name(&dev->kobj, dev->bus_id);
+	kobject_set_name(&dev->kobj, "%s", dev->bus_id);
 	if (parent)
 		dev->kobj.parent = &parent->kobj;
 
diff -Nru a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
--- a/drivers/firmware/efivars.c	2004-10-22 16:00:16 -07:00
+++ b/drivers/firmware/efivars.c	2004-10-22 16:00:16 -07:00
@@ -640,7 +640,7 @@
 	*(short_name + strlen(short_name)) = '-';
 	efi_guid_unparse(vendor_guid, short_name + strlen(short_name));
 
-	kobject_set_name(&new_efivar->kobj, short_name);
+	kobject_set_name(&new_efivar->kobj, "%s", short_name);
 	kobj_set_kset_s(new_efivar, vars_subsys);
 	kobject_register(&new_efivar->kobj);
 
diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	2004-10-22 16:00:16 -07:00
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	2004-10-22 16:00:16 -07:00
@@ -568,7 +568,7 @@
 	if ((slot->info == NULL) || (slot->ops == NULL))
 		return -EINVAL;
 
-	kobject_set_name(&slot->kobj, slot->name);
+	kobject_set_name(&slot->kobj, "%s", slot->name);
 	kobj_set_kset_s(slot, pci_hotplug_slots_subsys);
 
 	/* this can fail if we have already registered a slot with the same name */
diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-10-22 16:00:16 -07:00
+++ b/fs/sysfs/dir.c	2004-10-22 16:00:16 -07:00
@@ -181,7 +181,7 @@
 	new_dentry = sysfs_get_dentry(parent, new_name);
 	if (!IS_ERR(new_dentry)) {
   		if (!new_dentry->d_inode) {
-			error = kobject_set_name(kobj,new_name);
+			error = kobject_set_name(kobj, "%s", new_name);
 			if (!error)
 				d_move(kobj->dentry, new_dentry);
 		}
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	2004-10-22 16:00:16 -07:00
+++ b/kernel/module.c	2004-10-22 16:00:16 -07:00
@@ -1120,7 +1120,7 @@
 		return -ENOMEM;
 
 	memset(&mod->mkobj->kobj, 0, sizeof(mod->mkobj->kobj));
-	err = kobject_set_name(&mod->mkobj->kobj, mod->name);
+	err = kobject_set_name(&mod->mkobj->kobj, "%s", mod->name);
 	if (err)
 		goto out;
 	kobj_set_kset_s(mod->mkobj, module_subsys);

