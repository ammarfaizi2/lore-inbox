Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVEDHCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVEDHCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVEDHCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:02:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:57828 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261605AbVEDHCT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:19 -0400
Cc: dlsy@snoqualmie.dp.intel.com
Subject: [PATCH] PCI Hotplug: fix pciehp regression
In-Reply-To: <1115190138979@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:18 -0700
Message-Id: <11151901381752@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: fix pciehp regression

I fogot to remove the code that freed the memory in cleanup_slots().
Here is the new patch, which I have also taken care of the comment
by Eike to remove the cast in hotplug_slot->private.

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b308240b49ff5a1bddc6e10513c2c83f37a0bc78
tree 7fda5a4f25632d19ae03589bee0d920efe8026c3
parent eaae4b3a84a3781543a32bcaf0a33306ae915574
author Dely Sy <dlsy@snoqualmie.dp.intel.com> 1114736933 -0700
committer Greg KH <gregkh@suse.de> 1115189116 -0700

Index: drivers/pci/hotplug/pciehp_core.c
===================================================================
--- 2d3db5e9713dd0baeba0be2577731233780f072f/drivers/pci/hotplug/pciehp_core.c  (mode:100644 sha1:72baf749e65ef812d8e7f6ed69fba0b44cfc7d58)
+++ 7fda5a4f25632d19ae03589bee0d920efe8026c3/drivers/pci/hotplug/pciehp_core.c  (mode:100644 sha1:ed1fd8d6178d7f7418d840f93db0ef6e04142c67)
@@ -90,6 +90,22 @@
   	.get_cur_bus_speed =	get_cur_bus_speed,
 };
 
+/**
+ * release_slot - free up the memory used by a slot
+ * @hotplug_slot: slot to free
+ */
+static void release_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = hotplug_slot->private;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	kfree(slot->hotplug_slot->info);
+	kfree(slot->hotplug_slot->name);
+	kfree(slot->hotplug_slot);
+	kfree(slot);
+}
+
 static int init_slots(struct controller *ctrl)
 {
 	struct slot *new_slot;
@@ -139,7 +155,8 @@
 
 		/* register this slot with the hotplug pci core */
 		new_slot->hotplug_slot->private = new_slot;
-		make_slot_name (new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
+		new_slot->hotplug_slot->release = &release_slot;
+		make_slot_name(new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
 		new_slot->hotplug_slot->ops = &pciehp_hotplug_slot_ops;
 
 		new_slot->hpc_ops->get_power_status(new_slot, &(new_slot->hotplug_slot->info->power_status));
@@ -188,10 +205,6 @@
 	while (old_slot) {
 		next_slot = old_slot->next;
 		pci_hp_deregister (old_slot->hotplug_slot);
-		kfree(old_slot->hotplug_slot->info);
-		kfree(old_slot->hotplug_slot->name);
-		kfree(old_slot->hotplug_slot);
-		kfree(old_slot);
 		old_slot = next_slot;
 	}
 

