Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTBFEE3>; Wed, 5 Feb 2003 23:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTBFEEH>; Wed, 5 Feb 2003 23:04:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47888 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265369AbTBFECz>;
	Wed, 5 Feb 2003 23:02:55 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044851308@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044862346@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.5, 2003/02/05 17:17:39+11:00, greg@kroah.com

[PATCH] PCI Hotplug: change pci_hp_change_slot_info() to take a hotplug_slot and not a string.


diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
--- a/drivers/hotplug/cpci_hotplug_core.c	Thu Feb  6 14:52:08 2003
+++ b/drivers/hotplug/cpci_hotplug_core.c	Thu Feb  6 14:52:08 2003
@@ -130,7 +130,7 @@
 		return -EINVAL;
 	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
 	info.latch_status = value;
-	return pci_hp_change_slot_info(hotplug_slot->name, &info);
+	return pci_hp_change_slot_info(hotplug_slot, &info);
 }
 
 static int
@@ -142,7 +142,7 @@
 		return -EINVAL;
 	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
 	info.adapter_status = value;
-	return pci_hp_change_slot_info(hotplug_slot->name, &info);
+	return pci_hp_change_slot_info(hotplug_slot, &info);
 }
 
 static int
diff -Nru a/drivers/hotplug/cpqphp_ctrl.c b/drivers/hotplug/cpqphp_ctrl.c
--- a/drivers/hotplug/cpqphp_ctrl.c	Thu Feb  6 14:52:08 2003
+++ b/drivers/hotplug/cpqphp_ctrl.c	Thu Feb  6 14:52:08 2003
@@ -1767,19 +1767,17 @@
 static int update_slot_info (struct controller *ctrl, struct slot *slot)
 {
 	struct hotplug_slot_info *info;
-	char buffer[SLOT_NAME_SIZE];
 	int result;
 
 	info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	make_slot_name (&buffer[0], SLOT_NAME_SIZE, slot);
 	info->power_status = get_slot_enabled(ctrl, slot);
 	info->attention_status = cpq_get_attention_status(ctrl, slot);
 	info->latch_status = cpq_get_latch_status(ctrl, slot);
 	info->adapter_status = get_presence_status(ctrl, slot);
-	result = pci_hp_change_slot_info(buffer, info);
+	result = pci_hp_change_slot_info(slot->hotplug_slot, info);
 	kfree (info);
 	return result;
 }
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Thu Feb  6 14:52:08 2003
+++ b/drivers/hotplug/ibmphp_core.c	Thu Feb  6 14:52:08 2003
@@ -686,7 +686,6 @@
 int ibmphp_update_slot_info (struct slot *slot_cur)
 {
 	struct hotplug_slot_info *info;
-	char buffer[30];
 	int rc;
 	u8 bus_speed;
 	u8 mode;
@@ -697,7 +696,6 @@
 		return -ENOMEM;
 	}
         
-	strncpy (buffer, slot_cur->hotplug_slot->name, 30);
 	info->power_status = SLOT_PWRGD (slot_cur->status);
 	info->attention_status = SLOT_ATTN (slot_cur->status, slot_cur->ext_status);
 	info->latch_status = SLOT_LATCH (slot_cur->status);
@@ -735,7 +733,7 @@
 	info->max_bus_speed = slot_cur->hotplug_slot->info->max_bus_speed;
 	// To do: bus_names 
 	
-	rc = pci_hp_change_slot_info (buffer, info);
+	rc = pci_hp_change_slot_info (slot_cur->hotplug_slot, info);
 	kfree (info);
 	return rc;
 }
diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Thu Feb  6 14:52:08 2003
+++ b/drivers/hotplug/pci_hotplug.h	Thu Feb  6 14:52:08 2003
@@ -139,7 +139,7 @@
 
 extern int pci_hp_register		(struct hotplug_slot *slot);
 extern int pci_hp_deregister		(struct hotplug_slot *slot);
-extern int pci_hp_change_slot_info	(const char *name,
+extern int pci_hp_change_slot_info	(struct hotplug_slot *slot,
 					 struct hotplug_slot_info *info);
 
 struct pci_dev_wrapped {
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Feb  6 14:52:08 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Feb  6 14:52:08 2003
@@ -529,16 +529,16 @@
 
 /**
  * pci_hp_change_slot_info - changes the slot's information structure in the core
- * @name: the name of the slot whose info has changed
+ * @slot: pointer to the slot whose info has changed
  * @info: pointer to the info copy into the slot's info structure
  *
- * A slot with @name must have been registered with the pci 
+ * @slot must have been registered with the pci 
  * hotplug subsystem previously with a call to pci_hp_register().
  *
  * Returns 0 if successful, anything else for an error.
  * Not supported by sysfs now.
  */
-int pci_hp_change_slot_info (const char *name, struct hotplug_slot_info *info)
+int pci_hp_change_slot_info (struct hotplug_slot *slot, struct hotplug_slot_info *info)
 {
 	return 0;
 }

