Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVDBADw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVDBADw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVDBADu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:03:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:30428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262815AbVDAXsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:13 -0500
Cc: johnrose@austin.ibm.com
Subject: [PATCH] [PATCH] remove redundant devices list
In-Reply-To: <11123992711877@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:51 -0800
Message-Id: <11123992711084@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.12, 2005/03/17 14:31:26-08:00, johnrose@austin.ibm.com

[PATCH] [PATCH] remove redundant devices list

The RPA PCI Hotplug module creates and maintains a list of devices for
each slot.  This is redundant, because the PCI structures already
maintain such a list.  This patch changes the module to use the list
provided in the pci_bus structure.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/hotplug/rpaphp.h      |    2 
 drivers/pci/hotplug/rpaphp_pci.c  |  105 +++++++-------------------------------
 drivers/pci/hotplug/rpaphp_slot.c |   11 ---
 3 files changed, 22 insertions(+), 96 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	2005-04-01 15:36:22 -08:00
+++ b/drivers/pci/hotplug/rpaphp.h	2005-04-01 15:36:22 -08:00
@@ -94,7 +94,7 @@
 				/* dn has phb info */
 	struct pci_dev *bridge;	/* slot's pci_dev in pci_devices */
 	union {
-		struct list_head pci_funcs; /* pci_devs in PCI slot */ 
+		struct list_head *pci_devs; /* pci_devs in PCI slot */
 		struct vio_dev *vio_dev; /* vio_dev in VIO slot */
 	} dev;
 	struct hotplug_slot *hotplug_slot;
diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	2005-04-01 15:36:22 -08:00
+++ b/drivers/pci/hotplug/rpaphp_pci.c	2005-04-01 15:36:22 -08:00
@@ -130,11 +130,11 @@
  		*value = EMPTY;
  	}
  	else if (state == PRESENT) {
-		if (!is_init)
+		if (!is_init) {
 			/* at run-time slot->state can be changed by */
 			/* config/unconfig adapter */
 			*value = slot->state;
-		else {
+		} else {
  			child_dn = slot->dn->child;
  			if (child_dn)
  				child_dev = rpaphp_find_pci_dev(child_dn);
@@ -263,56 +263,17 @@
 	
 }
 
-#ifdef DEBUG
 static void print_slot_pci_funcs(struct slot *slot)
 {
-	struct list_head *l;
+	struct pci_dev *dev;
 
 	if (slot->dev_type == PCI_DEV) {
-		printk("pci_funcs of slot[%s]\n", slot->name);
-		if (list_empty(&slot->dev.pci_funcs))
-			printk("	pci_funcs is EMPTY\n");
-
-		list_for_each (l, &slot->dev.pci_funcs) {
-			struct rpaphp_pci_func *func =
-				list_entry(l, struct rpaphp_pci_func, sibling);
-			printk("	FOUND dev=%s\n", pci_name(func->pci_dev));
-		}
+		dbg("%s: pci_devs of slot[%s]\n", __FUNCTION__, slot->name);
+		list_for_each_entry (dev, slot->dev.pci_devs, bus_list)
+			dbg("\t%s\n", pci_name(dev));
 	}
 	return;
 }
-#else
-static void print_slot_pci_funcs(struct slot *slot)
-{
-	return;
-}
-#endif
-
-static int init_slot_pci_funcs(struct slot *slot)
-{
-	struct device_node *child;
-
-	for (child = slot->dn->child; child != NULL; child = child->sibling) {
-		struct pci_dev *pdev = rpaphp_find_pci_dev(child);
-
-		if (pdev) {
-			struct rpaphp_pci_func *func;
-			func = kmalloc(sizeof(struct rpaphp_pci_func), GFP_KERNEL);
-			if (!func) 
-				return -ENOMEM;
-			memset(func, 0, sizeof(struct rpaphp_pci_func));
-			INIT_LIST_HEAD(&func->sibling);
-			func->pci_dev = pdev;
-			list_add_tail(&func->sibling, &slot->dev.pci_funcs);
-			print_slot_pci_funcs(slot);
-		} else {
-			err("%s: dn=%s has no pci_dev\n", 
-				__FUNCTION__, child->full_name);
-			return -EIO;
-		}
-	}
-	return 0;
-}
 
 static int rpaphp_config_pci_adapter(struct slot *slot)
 {
@@ -335,13 +296,8 @@
 			err("%s: can't find any devices.\n", __FUNCTION__);
 			goto exit;
 		}
-		/* associate corresponding pci_dev */	
-		rc = init_slot_pci_funcs(slot);
-		if (rc)
-			goto exit;
 		print_slot_pci_funcs(slot);
-		if (!list_empty(&slot->dev.pci_funcs)) 
-			rc = 0;
+		rc = 0;
 	} else {
 		/* slot is not enabled */
 		err("slot doesn't have pci_dev structure\n");
@@ -371,34 +327,16 @@
 
 int rpaphp_unconfig_pci_adapter(struct slot *slot)
 {
+	struct pci_dev *dev;
 	int retval = 0;
-	struct list_head *ln, *tmp;
 
-	dbg("Entry %s: slot[%s]\n", __FUNCTION__, slot->name);
-	if (list_empty(&slot->dev.pci_funcs)) {
-		err("%s: slot[%s] doesn't have any devices.\n", __FUNCTION__, 
-			slot->name);
-
-		retval = -EINVAL;
-		goto exit;
-	}
-	/* remove the devices from the pci core */
-	list_for_each_safe (ln, tmp, &slot->dev.pci_funcs) {
-		struct rpaphp_pci_func *func;
-	
-		func = list_entry(ln, struct rpaphp_pci_func, sibling);
-		if (func->pci_dev) {
-			pci_remove_bus_device(func->pci_dev); 
-			rpaphp_eeh_remove_bus_device(func->pci_dev);
-		}
-		kfree(func);
-	}
-	INIT_LIST_HEAD(&slot->dev.pci_funcs);
+	list_for_each_entry(dev, slot->dev.pci_devs, bus_list)
+		rpaphp_eeh_remove_bus_device(dev);
+
+	pci_remove_behind_bridge(slot->bridge);
 	slot->state = NOT_CONFIGURED;
 	info("%s: devices in slot[%s] unconfigured.\n", __FUNCTION__,
 	     slot->name);
-exit:
-	dbg("Exit %s, rc=0x%x\n", __FUNCTION__, retval);
 	return retval;
 }
 
@@ -444,6 +382,7 @@
 
 static int setup_pci_slot(struct slot *slot)
 {
+	struct pci_bus *bus;
 	int rc;
 
 	if (slot->type == PHB) {
@@ -460,6 +399,12 @@
 					__FUNCTION__, slot->name);
 			goto exit_rc;
 		}
+
+		bus = slot->bridge->subordinate;
+		if (!bus)
+			goto exit_rc;
+		slot->dev.pci_devs = &bus->devices;
+
 		dbg("%s set slot->name to %s\n",  __FUNCTION__,
 				pci_name(slot->bridge));
 		strcpy(slot->name, pci_name(slot->bridge));
@@ -484,22 +429,15 @@
 				err("%s: CONFIG pci adapter failed\n", __FUNCTION__);
 				goto exit_rc;		
 			}
-		} else if (slot->hotplug_slot->info->adapter_status == CONFIGURED) {
-			if (init_slot_pci_funcs(slot)) {
-				err("%s: init_slot_pci_funcs failed\n", __FUNCTION__);
-				goto exit_rc;
-			}
 
-		} else {
+		} else if (slot->hotplug_slot->info->adapter_status != CONFIGURED) {
 			err("%s: slot[%s]'s adapter_status is NOT_VALID.\n",
 				__FUNCTION__, slot->name);
 			goto exit_rc;
 		}
-		
 		print_slot_pci_funcs(slot);
-		if (!list_empty(&slot->dev.pci_funcs)) {
+		if (!list_empty(slot->dev.pci_devs)) {
 			slot->state = CONFIGURED;
-	
 		} else {
 			/* DLPAR add as opposed to 
 		 	 * boot time */
@@ -521,7 +459,6 @@
 		slot->removable = 0;
 	else
 		slot->removable = 1;
-	INIT_LIST_HEAD(&slot->dev.pci_funcs);
 	if (setup_pci_hotplug_slot_info(slot))
 		goto exit_rc;
 	if (setup_pci_slot(slot))
diff -Nru a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
--- a/drivers/pci/hotplug/rpaphp_slot.c	2005-04-01 15:36:22 -08:00
+++ b/drivers/pci/hotplug/rpaphp_slot.c	2005-04-01 15:36:22 -08:00
@@ -98,17 +98,6 @@
 
 void dealloc_slot_struct(struct slot *slot)
 {
-	struct list_head *ln, *n;
-
-	if (slot->dev_type == PCI_DEV) {
-		list_for_each_safe (ln, n, &slot->dev.pci_funcs) {
-			struct rpaphp_pci_func *func;
-
-			func = list_entry(ln, struct rpaphp_pci_func, sibling);
-			kfree(func);
-		}
-	}
-
 	kfree(slot->hotplug_slot->info);
 	kfree(slot->hotplug_slot->name);
 	kfree(slot->hotplug_slot);

