Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTF0Coj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTF0Cnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:43:32 -0400
Received: from granite.he.net ([216.218.226.66]:38927 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263418AbTF0Cm5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:42:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1056675104264@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.73
In-Reply-To: <10566751041502@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jun 2003 17:51:44 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500, 2003/06/26 16:04:35-07:00, greg@kroah.com

[PATCH] PCI Hotplug: cpci: fix delete bug and add release() callback


 drivers/pci/hotplug/cpci_hotplug_core.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
--- a/drivers/pci/hotplug/cpci_hotplug_core.c	Thu Jun 26 17:39:13 2003
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c	Thu Jun 26 17:39:13 2003
@@ -278,6 +278,19 @@
 	return 0;
 }
 
+static void release_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if(slot == NULL)
+		return;
+
+	kfree(slot->hotplug_slot->info);
+	kfree(slot->hotplug_slot->name);
+	kfree(slot->hotplug_slot);
+	kfree(slot);
+}
+
 #define SLOT_NAME_SIZE	6
 static void
 make_slot_name(struct slot *slot)
@@ -346,6 +359,7 @@
 		slot->devfn = PCI_DEVFN(i, 0);
 
 		hotplug_slot->private = slot;
+		hotplug_slot->release = &release_slot;
 		make_slot_name(slot);
 		hotplug_slot->ops = &cpci_hotplug_slot_ops;
 
@@ -382,6 +396,7 @@
 {
 	struct slot *slot;
 	struct list_head *tmp;
+	struct list_head *next;
 	int status;
 
 	if(!bus) {
@@ -393,7 +408,7 @@
 		spin_unlock(&list_lock);
 		return -1;
 	}
-	list_for_each(tmp, &slot_list) {
+	list_for_each_safe(tmp, next, &slot_list) {
 		slot = list_entry(tmp, struct slot, slot_list);
 		if(slot->bus == bus) {
 			dbg("deregistering slot %s", slot->hotplug_slot->name);
@@ -405,11 +420,6 @@
 			}
 
 			list_del(&slot->slot_list);
-			kfree(slot->hotplug_slot->info);
-			kfree(slot->hotplug_slot->name);
-			kfree(slot->hotplug_slot);
-			kfree(slot);
-
 			slots--;
 		}
 	}

