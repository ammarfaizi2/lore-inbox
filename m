Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTF0Cog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTF0CnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:43:25 -0400
Received: from granite.he.net ([216.218.226.66]:38415 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263380AbTF0Cm5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:42:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10566751041502@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.73
In-Reply-To: <10566751033776@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jun 2003 17:51:44 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1499, 2003/06/26 16:04:19-07:00, greg@kroah.com

[PATCH] PCI Hotplug: acpiphp: add release() callback


 drivers/pci/hotplug/acpiphp_core.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
--- a/drivers/pci/hotplug/acpiphp_core.c	Thu Jun 26 17:39:18 2003
+++ b/drivers/pci/hotplug/acpiphp_core.c	Thu Jun 26 17:39:18 2003
@@ -380,6 +380,25 @@
 }
 
 /**
+ * release_slot - free up the memory used by a slot
+ * @hotplug_slot: slot to free
+ */
+static void release_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
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
+
+/**
  * init_slots - initialize 'struct slot' structures for each slot
  *
  */
@@ -422,6 +441,7 @@
 		slot->number = i;
 
 		slot->hotplug_slot->private = slot;
+		slot->hotplug_slot->release = &release_slots;
 		slot->hotplug_slot->ops = &acpi_hotplug_slot_ops;
 
 		slot->acpi_slot = get_slot_from_id(i);
@@ -435,10 +455,7 @@
 		retval = pci_hp_register(slot->hotplug_slot);
 		if (retval) {
 			err("pci_hp_register failed with error %d\n", retval);
-			kfree(slot->hotplug_slot->info);
-			kfree(slot->hotplug_slot->name);
-			kfree(slot->hotplug_slot);
-			kfree(slot);
+			release_slot();
 			return retval;
 		}
 
@@ -457,13 +474,10 @@
 	struct slot *slot;
 
 	list_for_each_safe (tmp, n, &slot_list) {
+		/* memory will be freed in release_slot callback */
 		slot = list_entry(tmp, struct slot, slot_list);
 		list_del(&slot->slot_list);
 		pci_hp_deregister(slot->hotplug_slot);
-		kfree(slot->hotplug_slot->info);
-		kfree(slot->hotplug_slot->name);
-		kfree(slot->hotplug_slot);
-		kfree(slot);
 	}
 
 	return;

