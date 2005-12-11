Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbVLKFko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbVLKFko (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbVLKFko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:40:44 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:65202 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161094AbVLKFkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:40:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:cc:content-type:content-transfer-encoding:message-id;
        b=Iqn91Zl222Kkmku9jB4SVtPpM3uXxWD0fsSClEGtyy3pDLW02ZVXHNGXb1LgsMSuFrK9Y5sLX1XejAlwjrhF6F7cIWO4A3pRvmQBVK7GaZ/qc3Dpyea8L95hvmIGhKA7eXdyKoftQALu8r54zRmo+aKXqBzG+DiL4JoWTJ48PAg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] reduce nr of ptr derefs in drivers/pci/hotplug/acpiphp_core.c
Date: Sun, 11 Dec 2005 06:41:08 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Disposition: inline
Cc: gregkh@us.ibm.com, t-kochi@bq.jp.nec.com, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512110641.09195.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to reduce the nr. of pointer dereferences in
drivers/pci/hotplug/acpiphp_core.c

Benefits:
 - micro speed optimization due to fewer pointer derefs
 - generated code is slightly smaller
 - better readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pci/hotplug/acpiphp_core.c |   44 ++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 20 deletions(-)

orig:
   text    data     bss     dec     hex filename
   2018      88      16    2122     84a drivers/pci/hotplug/acpiphp_core.o
patched:
   text    data     bss     dec     hex filename
   1967      88      16    2071     817 drivers/pci/hotplug/acpiphp_core.o

--- linux-2.6.15-rc5-git1-orig/drivers/pci/hotplug/acpiphp_core.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-git1/drivers/pci/hotplug/acpiphp_core.c	2005-12-11 03:35:53.000000000 +0100
@@ -348,6 +348,8 @@ static void release_slot(struct hotplug_
 static int __init init_slots(void)
 {
 	struct slot *slot;
+	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot_info *hotplug_slot_info;
 	int retval = -ENOMEM;
 	int i;
 
@@ -360,34 +362,36 @@ static int __init init_slots(void)
 		slot->hotplug_slot = kmalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
 		if (!slot->hotplug_slot)
 			goto error_slot;
-		memset(slot->hotplug_slot, 0, sizeof(struct hotplug_slot));
+		hotplug_slot = slot->hotplug_slot;
+		memset(hotplug_slot, 0, sizeof(struct hotplug_slot));
 
-		slot->hotplug_slot->info = kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
-		if (!slot->hotplug_slot->info)
+		hotplug_slot->info = kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
+		if (!hotplug_slot->info)
 			goto error_hpslot;
-		memset(slot->hotplug_slot->info, 0, sizeof(struct hotplug_slot_info));
+		hotplug_slot_info = hotplug_slot->info;
+		memset(hotplug_slot_info, 0, sizeof(struct hotplug_slot_info));
 
-		slot->hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
-		if (!slot->hotplug_slot->name)
+		hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
+		if (!hotplug_slot->name)
 			goto error_info;
 
 		slot->number = i;
 
-		slot->hotplug_slot->private = slot;
-		slot->hotplug_slot->release = &release_slot;
-		slot->hotplug_slot->ops = &acpi_hotplug_slot_ops;
+		hotplug_slot->private = slot;
+		hotplug_slot->release = &release_slot;
+		hotplug_slot->ops = &acpi_hotplug_slot_ops;
 
 		slot->acpi_slot = get_slot_from_id(i);
-		slot->hotplug_slot->info->power_status = acpiphp_get_power_status(slot->acpi_slot);
-		slot->hotplug_slot->info->attention_status = 0;
-		slot->hotplug_slot->info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
-		slot->hotplug_slot->info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
-		slot->hotplug_slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
-		slot->hotplug_slot->info->cur_bus_speed = PCI_SPEED_UNKNOWN;
+		hotplug_slot_info->power_status = acpiphp_get_power_status(slot->acpi_slot);
+		hotplug_slot_info->attention_status = 0;
+		hotplug_slot_info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
+		hotplug_slot_info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
+		hotplug_slot_info->max_bus_speed = PCI_SPEED_UNKNOWN;
+		hotplug_slot_info->cur_bus_speed = PCI_SPEED_UNKNOWN;
 
 		make_slot_name(slot);
 
-		retval = pci_hp_register(slot->hotplug_slot);
+		retval = pci_hp_register(hotplug_slot);
 		if (retval) {
 			err("pci_hp_register failed with error %d\n", retval);
 			goto error_name;
@@ -395,16 +399,16 @@ static int __init init_slots(void)
 
 		/* add slot to our internal list */
 		list_add(&slot->slot_list, &slot_list);
-		info("Slot [%s] registered\n", slot->hotplug_slot->name);
+		info("Slot [%s] registered\n", hotplug_slot->name);
 	}
 
 	return 0;
 error_name:
-	kfree(slot->hotplug_slot->name);
+	kfree(hotplug_slot->name);
 error_info:
-	kfree(slot->hotplug_slot->info);
+	kfree(hotplug_slot_info);
 error_hpslot:
-	kfree(slot->hotplug_slot);
+	kfree(hotplug_slot);
 error_slot:
 	kfree(slot);
 error:



