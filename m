Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTBYBPh>; Mon, 24 Feb 2003 20:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTBYBOY>; Mon, 24 Feb 2003 20:14:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:55567 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264654AbTBYBNo>;
	Mon, 24 Feb 2003 20:13:44 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <1046135760965@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <1046135762798@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.4, 2003/02/24 16:26:14-08:00, greg@kroah.com

[PATCH] PCI Hotplug: remove the list_lock, as we rely on sysfs to detect any duplicate slot names.


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Mon Feb 24 17:15:50 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Mon Feb 24 17:15:50 2003
@@ -67,8 +67,6 @@
 
 //////////////////////////////////////////////////////////////////
 
-static spinlock_t list_lock;
-
 static LIST_HEAD(pci_hotplug_slot_list);
 
 static struct subsystem hotplug_slots_subsys;
@@ -531,23 +529,16 @@
 	if ((slot->info == NULL) || (slot->ops == NULL))
 		return -EINVAL;
 
-	/* make sure we have not already registered this slot */
-	spin_lock (&list_lock);
-	if (get_slot_from_name (slot->name) != NULL) {
-		spin_unlock (&list_lock);
-		return -EINVAL;
-	}
-
 	strncpy(slot->kobj.name, slot->name, KOBJ_NAME_LEN);
 	kobj_set_kset_s(slot, hotplug_slots_subsys);
 
+	/* this can fail if we have already registered a slot with the same name */
 	if (kobject_register(&slot->kobj)) {
 		err("Unable to register kobject");
 		return -EINVAL;
 	}
 		
 	list_add (&slot->slot_list, &pci_hotplug_slot_list);
-	spin_unlock (&list_lock);
 
 	result = fs_add_slot (slot);
 	dbg ("Added slot %s to the list\n", slot->name);
@@ -570,16 +561,11 @@
 	if (slot == NULL)
 		return -ENODEV;
 
-	/* make sure we have this slot in our list before trying to delete it */
-	spin_lock (&list_lock);
 	temp = get_slot_from_name (slot->name);
 	if (temp != slot) {
-		spin_unlock (&list_lock);
 		return -ENODEV;
 	}
-
 	list_del (&slot->slot_list);
-	spin_unlock (&list_lock);
 
 	fs_remove_slot (slot);
 	dbg ("Removed slot %s from the list\n", slot->name);
@@ -638,8 +624,6 @@
 static int __init pci_hotplug_init (void)
 {
 	int result;
-
-	spin_lock_init(&list_lock);
 
 	kset_set_kset_s(&hotplug_slots_subsys, pci_bus_type.subsys);
 	result = subsystem_register(&hotplug_slots_subsys);

