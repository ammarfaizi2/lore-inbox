Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTF0Coj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTF0Cnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:43:39 -0400
Received: from granite.he.net ([216.218.226.66]:39951 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263458AbTF0Cm6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:42:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10566751033776@kroah.com>
Subject: [PATCH] Yet more PCI fixes for 2.5.73
In-Reply-To: <20030627005007.GA6173@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jun 2003 17:51:43 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1498, 2003/06/26 16:04:05-07:00, greg@kroah.com

[PATCH] PCI Hotplug: pcihp_skeleton: fix delete bug and add release() callback


 drivers/pci/hotplug/pcihp_skeleton.c |   42 ++++++++++++++++++++++-------------
 1 files changed, 27 insertions(+), 15 deletions(-)


diff -Nru a/drivers/pci/hotplug/pcihp_skeleton.c b/drivers/pci/hotplug/pcihp_skeleton.c
--- a/drivers/pci/hotplug/pcihp_skeleton.c	Thu Jun 26 17:39:24 2003
+++ b/drivers/pci/hotplug/pcihp_skeleton.c	Thu Jun 26 17:39:24 2003
@@ -1,8 +1,8 @@
 /*
- * PCI Hot Plug Controller Skeleton Driver - 0.1
+ * PCI Hot Plug Controller Skeleton Driver - 0.2
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (c) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001,2003 IBM Corp.
  *
  * All rights reserved.
  *
@@ -69,7 +69,7 @@
 static int debug;
 static int num_slots;
 
-#define DRIVER_VERSION	"0.1"
+#define DRIVER_VERSION	"0.2"
 #define DRIVER_AUTHOR	"Greg Kroah-Hartman <greg@kroah.com>"
 #define DRIVER_DESC	"Hot Plug PCI Controller Skeleton Driver"
 
@@ -288,6 +288,21 @@
 	return retval;
 }
 
+static void release_slots(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+	int retval = 0;
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	dbg(__FUNCTION__" - physical_slot = %s\n", hotplug_slot->name);
+	kfree(slot->hotplug_slot->info);
+	kfree(slot->hotplug_slot->name);
+	kfree(slot->hotplug_slot);
+	kfree(slot);
+}
+
 #define SLOT_NAME_SIZE	10
 static void make_slot_name (struct slot *slot)
 {
@@ -347,6 +362,7 @@
 		slot->number = i;
 
 		hotplug_slot->private = slot;
+		hotplug_slot->release = &release_slot;
 		make_slot_name (slot);
 		hotplug_slot->ops = &skel_hotplug_slot_ops;
 		
@@ -376,27 +392,23 @@
 
 	return retval;
 }
-		
-static void cleanup_slots (void)
+
+static void cleanup_slots(void)
 {
 	struct list_head *tmp;
+	struct list_head *next;
 	struct slot *slot;
 
 	/*
-	 * Unregister all of our slots with the pci_hotplug subsystem,
-	 * and free up all memory that we had allocated.
+	 * Unregister all of our slots with the pci_hotplug subsystem.
+	 * Memory will be freed in release_slot() callback after slot's
+	 * lifespan is finished.
 	 */
-	list_for_each (tmp, &slot_list) {
+	list_for_each_safe (tmp, next, &slot_list) {
 		slot = list_entry (tmp, struct slot, slot_list);
 		list_del (&slot->slot_list);
 		pci_hp_deregister (slot->hotplug_slot);
-		kfree (slot->hotplug_slot->info);
-		kfree (slot->hotplug_slot->name);
-		kfree (slot->hotplug_slot);
-		kfree (slot);
 	}
-
-	return;
 }
 		
 static int __init pcihp_skel_init(void)

