Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTF0Coj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTF0Cn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:43:56 -0400
Received: from granite.he.net ([216.218.226.66]:41743 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263462AbTF0CnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:43:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10566751043125@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.73
In-Reply-To: <1056675104264@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jun 2003 17:51:44 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1501, 2003/06/26 16:05:11-07:00, greg@kroah.com

[PATCH] PCI Hotplug: cpqphp: add release() callback and other minor cleanups.


 drivers/pci/hotplug/cpqphp_core.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	Thu Jun 26 17:39:08 2003
+++ b/drivers/pci/hotplug/cpqphp_core.c	Thu Jun 26 17:39:08 2003
@@ -312,6 +312,20 @@
 	return previous;
 }
 
+static void release_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	
+	if (slot == NULL)
+		return;
+	
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	kfree(slot->hotplug_slot->info);
+	kfree(slot->hotplug_slot->name);
+	kfree(slot->hotplug_slot);
+	kfree(slot);
+}
 
 static int ctrl_slot_setup (struct controller * ctrl, void *smbios_start, void *smbios_table)
 {
@@ -401,6 +415,7 @@
 		new_slot->capabilities |= ((read_slot_enable(ctrl) << 2) >> ctrl_slot) & 0x04;
 
 		/* register this slot with the hotplug pci core */
+		new_slot->hotplug_slot->release = &release_slot;
 		new_slot->hotplug_slot->private = new_slot;
 		make_slot_name (new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
 		new_slot->hotplug_slot->ops = &cpqphp_hotplug_slot_ops;
@@ -415,10 +430,7 @@
 		result = pci_hp_register (new_slot->hotplug_slot);
 		if (result) {
 			err ("pci_hp_register failed with error %d\n", result);
-			kfree (new_slot->hotplug_slot->info);
-			kfree (new_slot->hotplug_slot->name);
-			kfree (new_slot->hotplug_slot);
-			kfree (new_slot);
+			release_slot(new_slot->hotplug_slot);
 			return result;
 		}
 		
@@ -430,10 +442,9 @@
 		slot_number++;
 	}
 
-	return(0);
+	return 0;
 }
 
-
 static int ctrl_slot_cleanup (struct controller * ctrl)
 {
 	struct slot *old_slot, *next_slot;
@@ -442,12 +453,9 @@
 	ctrl->slot = NULL;
 
 	while (old_slot) {
+		/* memory will be freed by the release_slot callback */
 		next_slot = old_slot->next;
 		pci_hp_deregister (old_slot->hotplug_slot);
-		kfree(old_slot->hotplug_slot->info);
-		kfree(old_slot->hotplug_slot->name);
-		kfree(old_slot->hotplug_slot);
-		kfree(old_slot);
 		old_slot = next_slot;
 	}
 
@@ -498,7 +506,7 @@
 	       sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
 	// Make sure I got at least one entry
 	if (len == 0) {
-		if (PCIIRQRoutingInfoLength != NULL) kfree(PCIIRQRoutingInfoLength );
+		kfree(PCIIRQRoutingInfoLength);
 		return -1;
 	}
 
@@ -509,9 +517,7 @@
 
 		if ((tbus == bus_num) && (tdevice == dev_num)) {
 			*slot = tslot;
-
-			if (PCIIRQRoutingInfoLength != NULL)
-				kfree(PCIIRQRoutingInfoLength);
+			kfree(PCIIRQRoutingInfoLength);
 			return 0;
 		} else {
 			// Didn't get a match on the target PCI device. Check if the
@@ -540,10 +546,10 @@
 	// slot number for the bridge.
 	if (bridgeSlot != 0xFF) {
 		*slot = bridgeSlot;
-		if (PCIIRQRoutingInfoLength != NULL) kfree(PCIIRQRoutingInfoLength );
+		kfree(PCIIRQRoutingInfoLength);
 		return 0;
 	}
-	if (PCIIRQRoutingInfoLength != NULL) kfree(PCIIRQRoutingInfoLength );
+	kfree(PCIIRQRoutingInfoLength);
 	// Couldn't find an entry in the routing table for this PCI device
 	return -1;
 }

