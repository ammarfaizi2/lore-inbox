Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTI3WuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbTI3WtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:49:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:39387 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261829AbTI3WrZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:25 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10649613502758@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <10649613503148@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:50 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347, 2003/09/29 12:23:22-07:00, lxiep@us.ibm.com

[PATCH] PCI Hotplug: export hotplug_slots subsys

This is needed for the PPC64 PCI hotplug driver.


 drivers/pci/hotplug/pci_hotplug.h      |    1 +
 drivers/pci/hotplug/pci_hotplug_core.c |   15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)


diff -Nru a/drivers/pci/hotplug/pci_hotplug.h b/drivers/pci/hotplug/pci_hotplug.h
--- a/drivers/pci/hotplug/pci_hotplug.h	Tue Sep 30 15:20:35 2003
+++ b/drivers/pci/hotplug/pci_hotplug.h	Tue Sep 30 15:20:35 2003
@@ -145,6 +145,7 @@
 extern int pci_hp_deregister		(struct hotplug_slot *slot);
 extern int pci_hp_change_slot_info	(struct hotplug_slot *slot,
 					 struct hotplug_slot_info *info);
+extern struct subsystem pci_hotplug_slots_subsys;
 
 #endif
 
diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	Tue Sep 30 15:20:35 2003
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	Tue Sep 30 15:20:35 2003
@@ -69,7 +69,7 @@
 
 static LIST_HEAD(pci_hotplug_slot_list);
 
-static struct subsystem hotplug_slots_subsys;
+struct subsystem pci_hotplug_slots_subsys;
 
 static ssize_t hotplug_slot_attr_show(struct kobject *kobj,
 		struct attribute *attr, char *buf)
@@ -104,7 +104,7 @@
 	.release = &hotplug_slot_release,
 };
 
-static decl_subsys(hotplug_slots, &hotplug_slot_ktype, NULL);
+decl_subsys(pci_hotplug_slots, &hotplug_slot_ktype, NULL);
 
 
 /* these strings match up with the values in pci_bus_speed */
@@ -534,7 +534,7 @@
 		return -EINVAL;
 
 	strlcpy(slot->kobj.name, slot->name, KOBJ_NAME_LEN);
-	kobj_set_kset_s(slot, hotplug_slots_subsys);
+	kobj_set_kset_s(slot, pci_hotplug_slots_subsys);
 
 	/* this can fail if we have already registered a slot with the same name */
 	if (kobject_register(&slot->kobj)) {
@@ -629,8 +629,8 @@
 {
 	int result;
 
-	kset_set_kset_s(&hotplug_slots_subsys, pci_bus_type.subsys);
-	result = subsystem_register(&hotplug_slots_subsys);
+	kset_set_kset_s(&pci_hotplug_slots_subsys, pci_bus_type.subsys);
+	result = subsystem_register(&pci_hotplug_slots_subsys);
 	if (result) {
 		err("Register subsys with error %d\n", result);
 		goto exit;
@@ -645,7 +645,7 @@
 	goto exit;
 	
 err_subsys:
-	subsystem_unregister(&hotplug_slots_subsys);
+	subsystem_unregister(&pci_hotplug_slots_subsys);
 exit:
 	return result;
 }
@@ -653,7 +653,7 @@
 static void __exit pci_hotplug_exit (void)
 {
 	cpci_hotplug_exit();
-	subsystem_unregister(&hotplug_slots_subsys);
+	subsystem_unregister(&pci_hotplug_slots_subsys);
 }
 
 module_init(pci_hotplug_init);
@@ -665,6 +665,7 @@
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
+EXPORT_SYMBOL_GPL(pci_hotplug_slots_subsys);
 EXPORT_SYMBOL_GPL(pci_hp_register);
 EXPORT_SYMBOL_GPL(pci_hp_deregister);
 EXPORT_SYMBOL_GPL(pci_hp_change_slot_info);

