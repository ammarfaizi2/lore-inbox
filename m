Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbUDOTCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUDOR0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:26:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:16302 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263130AbUDORYE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:04 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10820498261812@kroah.com>
Date: Thu, 15 Apr 2004 10:23:46 -0700
Message-Id: <1082049826704@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.12, 2004/04/12 16:57:12-07:00, lxiep@us.ibm.com

[PATCH] PCI Hotplug: php_phy_location.patch

Adds a file to show the pci hotplug slot location for the ppc64 driver
only.


 drivers/pci/hotplug/rpadlpar_core.c |   23 +++-------
 drivers/pci/hotplug/rpaphp.h        |    2 
 drivers/pci/hotplug/rpaphp_core.c   |   23 +++-------
 drivers/pci/hotplug/rpaphp_slot.c   |   80 ++++++++++++++++++------------------
 4 files changed, 59 insertions(+), 69 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
--- a/drivers/pci/hotplug/rpadlpar_core.c	Thu Apr 15 10:03:42 2004
+++ b/drivers/pci/hotplug/rpadlpar_core.c	Thu Apr 15 10:03:42 2004
@@ -79,25 +79,18 @@
 	return np;
 }
 
-static inline struct hotplug_slot *find_php_slot(char *drc_name)
-{
-	struct kobject *k;
-
-	k = kset_find_obj(&pci_hotplug_slots_subsys.kset, drc_name);
-	if (!k)
-		return NULL;
-
-	return to_hotplug_slot(k);
-}
-
 static struct slot *find_slot(char *drc_name)
 {
-	struct hotplug_slot *php_slot = find_php_slot(drc_name);
+	struct list_head *tmp, *n;
+	struct slot *slot;
 
-	if (!php_slot)
-		return NULL;
+        list_for_each_safe(tmp, n, &rpaphp_slot_head) {
+                slot = list_entry(tmp, struct slot, rpaphp_slot_list);
+                if (strcmp(slot->location, drc_name) == 0)
+                        return slot;
+        }
 
-	return (struct slot *) php_slot->private;
+        return NULL;
 }
 
 static void rpadlpar_claim_one_bus(struct pci_bus *b)
diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	Thu Apr 15 10:03:42 2004
+++ b/drivers/pci/hotplug/rpaphp.h	Thu Apr 15 10:03:42 2004
@@ -85,6 +85,7 @@
 	u32 type;
 	u32 power_domain;
 	char *name;
+	char *location;
 	struct device_node *dn;	/* slot's device_node in OFDT */
 	/* dn has phb info */
 	struct pci_dev *bridge;	/* slot's pci_dev in pci_devices */
@@ -129,5 +130,6 @@
 extern int register_slot(struct slot *slot);
 extern int rpaphp_get_power_status(struct slot *slot, u8 * value);
 extern int rpaphp_set_attention_status(struct slot *slot, u8 status);
+extern void rpaphp_sysfs_remove_attr_location(struct hotplug_slot *slot);
 	
 #endif				/* _PPC64PHP_H */
diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	Thu Apr 15 10:03:42 2004
+++ b/drivers/pci/hotplug/rpaphp_core.c	Thu Apr 15 10:03:42 2004
@@ -246,17 +246,14 @@
 int rpaphp_remove_slot(struct slot *slot)
 {
 	int retval = 0;
-	char *rm_link;
+	struct hotplug_slot *php_slot = slot->hotplug_slot;
 
-	dbg("%s - Entry: slot[%s]\n", __FUNCTION__, slot->name);
-	if (slot->dev_type == PCI_DEV)
-		rm_link = pci_name(slot->bridge);
-	else
-		rm_link = strstr(slot->dn->full_name, "@");
-
-	sysfs_remove_link(slot->hotplug_slot->kobj.parent, rm_link);
 	list_del(&slot->rpaphp_slot_list);
-	retval = pci_hp_deregister(slot->hotplug_slot);
+	
+	/* remove "php_location" file */
+	rpaphp_sysfs_remove_attr_location(php_slot);
+
+	retval = pci_hp_deregister(php_slot);
 	if (retval)
 		err("Problem unregistering a slot %s\n", slot->name);
 
@@ -380,14 +377,7 @@
 	 */
 
 	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
-		char *rm_link;
-
 		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
-		if (slot->dev_type == PCI_DEV)
-			rm_link = pci_name(slot->bridge);
-		else
-			rm_link = strstr(slot->dn->full_name, "@");
-		sysfs_remove_link(slot->hotplug_slot->kobj.parent, rm_link);
 		list_del(&slot->rpaphp_slot_list);
 		pci_hp_deregister(slot->hotplug_slot);
 	}
@@ -478,3 +468,4 @@
 
 EXPORT_SYMBOL_GPL(rpaphp_add_slot);
 EXPORT_SYMBOL_GPL(rpaphp_remove_slot);
+EXPORT_SYMBOL_GPL(rpaphp_slot_head);
diff -Nru a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
--- a/drivers/pci/hotplug/rpaphp_slot.c	Thu Apr 15 10:03:42 2004
+++ b/drivers/pci/hotplug/rpaphp_slot.c	Thu Apr 15 10:03:42 2004
@@ -29,8 +29,36 @@
 #include <linux/pci.h>
 #include "rpaphp.h"
 
-/* free up the memory user by a slot */
+static ssize_t location_read_file (struct hotplug_slot *php_slot, char *buf)
+{
+        char *value;
+        int retval = -ENOENT;
+	struct slot *slot = (struct slot *)php_slot->private;
+
+	if (!slot)
+		return retval;
+
+        value = slot->location;
+        retval = sprintf (buf, "%s\n", value);
+        return retval;
+}
 
+static struct hotplug_slot_attribute hotplug_slot_attr_location = {
+	.attr = {.name = "phy_location", .mode = S_IFREG | S_IRUGO},
+	.show = location_read_file,
+};
+
+static void rpaphp_sysfs_add_attr_location (struct hotplug_slot *slot)
+{
+	sysfs_create_file(&slot->kobj, &hotplug_slot_attr_location.attr);
+}
+
+void rpaphp_sysfs_remove_attr_location (struct hotplug_slot *slot)
+{
+	sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_location.attr);
+}
+
+/* free up the memory user by a slot */
 static void rpaphp_release_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = hotplug_slot? (struct slot *) hotplug_slot->private:NULL;
@@ -76,17 +104,25 @@
 		return (NULL);
 	}
 	memset(slot->hotplug_slot->info, 0, sizeof (struct hotplug_slot_info));
-	slot->hotplug_slot->name = kmalloc(strlen(drc_name) + 1, GFP_KERNEL);
+	slot->hotplug_slot->name = kmalloc(BUS_ID_SIZE + 1, GFP_KERNEL);
 	if (!slot->hotplug_slot->name) {
 		kfree(slot->hotplug_slot->info);
 		kfree(slot->hotplug_slot);
 		kfree(slot);
 		return (NULL);
 	}
+	slot->location = kmalloc(strlen(drc_name) + 1, GFP_KERNEL);
+	if (!slot->location) {
+		kfree(slot->hotplug_slot->info);
+		kfree(slot->hotplug_slot->name);
+		kfree(slot->hotplug_slot);
+		kfree(slot);
+		return (NULL);
+	}
 	slot->name = slot->hotplug_slot->name;
 	slot->dn = dn;
 	slot->index = drc_index;
-	strcpy(slot->name, drc_name);
+	strcpy(slot->location, drc_name);
 	slot->power_domain = power_domain;
 	slot->magic = SLOT_MAGIC;
 	slot->hotplug_slot->private = slot;
@@ -110,41 +146,9 @@
 		rpaphp_release_slot(slot->hotplug_slot);
 		return (retval);
 	}
-	switch (slot->dev_type) {
-	case PCI_DEV:
-		/* create symlink between slot->name and it's bus_id */
-
-		dbg("%s: sysfs_create_link: %s --> %s\n", __FUNCTION__,
-		    pci_name(slot->bridge), slot->name);
-
-		retval = sysfs_create_link(slot->hotplug_slot->kobj.parent,
-					   &slot->hotplug_slot->kobj,
-					   pci_name(slot->bridge));
-		if (retval) {
-			err("sysfs_create_link failed with error %d\n", retval);
-			rpaphp_release_slot(slot->hotplug_slot);
-			return (retval);
-		}
-		break;
-	case VIO_DEV:
-		/* create symlink between slot->name and it's uni-address */
-		vio_uni_addr = strchr(slot->dn->full_name, '@');
-		if (!vio_uni_addr)
-			return (1);
-		dbg("%s: sysfs_create_link: %s --> %s\n", __FUNCTION__,
-		    vio_uni_addr, slot->name);
-		retval = sysfs_create_link(slot->hotplug_slot->kobj.parent,
-					   &slot->hotplug_slot->kobj,
-					   vio_uni_addr);
-		if (retval) {
-			err("sysfs_create_link failed with error %d\n", retval);
-			rpaphp_release_slot(slot->hotplug_slot);
-			return (retval);
-		}
-		break;
-	default:
-		return (1);
-	}
+	
+	/* create "phy_locatoin" file */
+	rpaphp_sysfs_add_attr_location(slot->hotplug_slot);	
 
 	/* add slot to our internal list */
 	dbg("%s adding slot[%s] to rpaphp_slot_list\n",

