Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTBFEEb>; Wed, 5 Feb 2003 23:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTBFEEX>; Wed, 5 Feb 2003 23:04:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50192 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265378AbTBFEC4>;
	Wed, 5 Feb 2003 23:02:56 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044863071@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <1044504487837@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.7, 2003/02/05 17:19:09+11:00, greg@kroah.com

[PATCH] PCI Hotplug: Make pci_hp_change_slot_info() work again

Relies on sysfs_update_file() to be present in the kernel.


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Feb  6 14:51:57 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Feb  6 14:51:57 2003
@@ -39,7 +39,6 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/pci.h>
-#include <linux/dnotify.h>
 #include <asm/uaccess.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
@@ -385,58 +384,119 @@
 	.store = test_write_file
 };
 
-static int fs_add_slot (struct hotplug_slot *slot)
+static int has_power_file (struct hotplug_slot *slot)
 {
+	if ((!slot) || (!slot->ops))
+		return -ENODEV;
 	if ((slot->ops->enable_slot) ||
 	    (slot->ops->disable_slot) ||
 	    (slot->ops->get_power_status))
-		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+		return 0;
+	return -ENOENT;
+}
 
+static int has_attention_file (struct hotplug_slot *slot)
+{
+	if ((!slot) || (!slot->ops))
+		return -ENODEV;
 	if ((slot->ops->set_attention_status) ||
 	    (slot->ops->get_attention_status))
-		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_attention.attr);
+		return 0;
+	return -ENOENT;
+}
 
+static int has_latch_file (struct hotplug_slot *slot)
+{
+	if ((!slot) || (!slot->ops))
+		return -ENODEV;
 	if (slot->ops->get_latch_status)
-		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
+		return 0;
+	return -ENOENT;
+}
 
+static int has_adapter_file (struct hotplug_slot *slot)
+{
+	if ((!slot) || (!slot->ops))
+		return -ENODEV;
 	if (slot->ops->get_adapter_status)
-		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
+		return 0;
+	return -ENOENT;
+}
 
+static int has_max_bus_speed_file (struct hotplug_slot *slot)
+{
+	if ((!slot) || (!slot->ops))
+		return -ENODEV;
 	if (slot->ops->get_max_bus_speed)
-		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
+		return 0;
+	return -ENOENT;
+}
 
+static int has_cur_bus_speed_file (struct hotplug_slot *slot)
+{
+	if ((!slot) || (!slot->ops))
+		return -ENODEV;
 	if (slot->ops->get_cur_bus_speed)
-		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_cur_bus_speed.attr);
+		return 0;
+	return -ENOENT;
+}
 
+static int has_test_file (struct hotplug_slot *slot)
+{
+	if ((!slot) || (!slot->ops))
+		return -ENODEV;
 	if (slot->ops->hardware_test)
+		return 0;
+	return -ENOENT;
+}
+
+static int fs_add_slot (struct hotplug_slot *slot)
+{
+	if (has_power_file(slot) == 0)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+
+	if (has_attention_file(slot) == 0)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_attention.attr);
+
+	if (has_latch_file(slot) == 0)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
+
+	if (has_adapter_file(slot) == 0)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
+
+	if (has_max_bus_speed_file(slot) == 0)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
+
+	if (has_cur_bus_speed_file(slot) == 0)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_cur_bus_speed.attr);
+
+	if (has_test_file(slot) == 0)
 		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_test.attr);
+
 	return 0;
 }
 
 static void fs_remove_slot (struct hotplug_slot *slot)
 {
-	if ((slot->ops->enable_slot) ||
-	    (slot->ops->disable_slot) ||
-	    (slot->ops->get_power_status))
+	if (has_power_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_power.attr);
 
-	if ((slot->ops->set_attention_status) ||
-	    (slot->ops->get_attention_status))
+	if (has_attention_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_attention.attr);
 
-	if (slot->ops->get_latch_status)
+	if (has_latch_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
 
-	if (slot->ops->get_adapter_status)
+	if (has_adapter_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
 
-	if (slot->ops->get_max_bus_speed)
+	if (has_max_bus_speed_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
 
-	if (slot->ops->get_cur_bus_speed)
+	if (has_cur_bus_speed_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_cur_bus_speed.attr);
 
-	if (slot->ops->hardware_test)
+	if (has_test_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_test.attr);
 }
 
@@ -536,10 +596,42 @@
  * hotplug subsystem previously with a call to pci_hp_register().
  *
  * Returns 0 if successful, anything else for an error.
- * Not supported by sysfs now.
  */
 int pci_hp_change_slot_info (struct hotplug_slot *slot, struct hotplug_slot_info *info)
 {
+	if ((slot == NULL) || (info == NULL))
+		return -ENODEV;
+
+	/*
+	* check all fields in the info structure, and update timestamps
+	* for the files referring to the fields that have now changed.
+	*/
+	if ((has_power_file(slot) == 0) &&
+	    (slot->info->power_status != info->power_status))
+		sysfs_update_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+
+	if ((has_attention_file(slot) == 0) &&
+	    (slot->info->attention_status != info->attention_status))
+		sysfs_update_file(&slot->kobj, &hotplug_slot_attr_attention.attr);
+
+	if ((has_latch_file(slot) == 0) &&
+	    (slot->info->latch_status != info->latch_status))
+		sysfs_update_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
+
+	if ((has_adapter_file(slot) == 0) &&
+	    (slot->info->adapter_status != info->adapter_status))
+		sysfs_update_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
+
+	if ((has_max_bus_speed_file(slot) == 0) &&
+	    (slot->info->max_bus_speed != info->max_bus_speed))
+		sysfs_update_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
+
+	if ((has_cur_bus_speed_file(slot) == 0) &&
+	    (slot->info->cur_bus_speed != info->cur_bus_speed))
+		sysfs_update_file(&slot->kobj, &hotplug_slot_attr_cur_bus_speed.attr);
+
+	memcpy (slot->info, info, sizeof (struct hotplug_slot_info));
+
 	return 0;
 }
 

