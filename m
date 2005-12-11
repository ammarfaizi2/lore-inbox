Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbVLKFlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbVLKFlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbVLKFlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:41:10 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:20666 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161095AbVLKFlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:41:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Cq0QpWOpCaigAMUqwmMnA0Y3v4BghYmmoi/yFEA2rkNqfs4PHxzwY0OIpcTHckGNZkZQ4RSLgs1QPKZWD6yol2Bk6Ko59l3O14NtnlzrMxydQtDUKY7U0xub+3dlMa4f0FkBasr6H7B47x2gEgacUuXw1isHOmNMQEZ6D33Xxf4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Reduce nr of ptr derefs in drivers/pci/hotplug/pciehp_core.c
Date: Sun, 11 Dec 2005 06:41:42 +0100
User-Agent: KMail/1.9
Cc: greg@kroah.com, kristen.c.accardi@intel.com, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512110641.42992.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to reduce the nr. of pointer dereferences in
drivers/pci/hotplug/pciehp_core.c

Benefits:
 - micro speed optimization due to fewer pointer derefs
 - generated code is slightly smaller
 - small line length cleanup
 - better readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pci/hotplug/pciehp_core.c |   90 +++++++++++++++++++++-----------------
 1 files changed, 50 insertions(+), 40 deletions(-)

orig:
   text    data     bss     dec     hex filename
   4910     436      24    5370    14fa drivers/pci/hotplug/pciehp_core.o
patched:
   text    data     bss     dec     hex filename
   4889     436      24    5349    14e5 drivers/pci/hotplug/pciehp_core.o

--- linux-2.6.15-rc5-git1-orig/drivers/pci/hotplug/pciehp_core.c	2005-12-04 18:48:04.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/pci/hotplug/pciehp_core.c	2005-12-11 05:46:58.000000000 +0100
@@ -103,7 +103,10 @@ static void release_slot(struct hotplug_
 
 static int init_slots(struct controller *ctrl)
 {
-	struct slot *new_slot;
+	struct slot *slot;
+	struct hpc_ops *hpc_ops;
+	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot_info *hotplug_slot_info;
 	u8 number_of_slots;
 	u8 slot_device;
 	u32 slot_number;
@@ -114,59 +117,66 @@ static int init_slots(struct controller 
 	slot_number = ctrl->first_slot;
 
 	while (number_of_slots) {
-		new_slot = kmalloc(sizeof(*new_slot), GFP_KERNEL);
-		if (!new_slot)
+		slot = kmalloc(sizeof(*slot), GFP_KERNEL);
+		if (!slot)
 			goto error;
 
-		memset(new_slot, 0, sizeof(struct slot));
-		new_slot->hotplug_slot =
-				kmalloc(sizeof(*(new_slot->hotplug_slot)),
+		memset(slot, 0, sizeof(struct slot));
+		slot->hotplug_slot =
+				kmalloc(sizeof(*(slot->hotplug_slot)),
 						GFP_KERNEL);
-		if (!new_slot->hotplug_slot)
+		if (!slot->hotplug_slot)
 			goto error_slot;
-		memset(new_slot->hotplug_slot, 0, sizeof(struct hotplug_slot));
+		hotplug_slot = slot->hotplug_slot;
+		memset(hotplug_slot, 0, sizeof(struct hotplug_slot));
 
-		new_slot->hotplug_slot->info =
-			kmalloc(sizeof(*(new_slot->hotplug_slot->info)),
+		hotplug_slot->info =
+			kmalloc(sizeof(*(hotplug_slot->info)),
 						GFP_KERNEL);
-		if (!new_slot->hotplug_slot->info)
+		if (!hotplug_slot->info)
 			goto error_hpslot;
-		memset(new_slot->hotplug_slot->info, 0,
+		hotplug_slot_info = hotplug_slot->info;
+		memset(hotplug_slot_info, 0,
 					sizeof(struct hotplug_slot_info));
-		new_slot->hotplug_slot->name = kmalloc(SLOT_NAME_SIZE,
-						GFP_KERNEL);
-		if (!new_slot->hotplug_slot->name)
+		hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
+		if (!hotplug_slot->name)
 			goto error_info;
 
-		new_slot->ctrl = ctrl;
-		new_slot->bus = ctrl->slot_bus;
-		new_slot->device = slot_device;
-		new_slot->hpc_ops = ctrl->hpc_ops;
+		slot->ctrl = ctrl;
+		slot->bus = ctrl->slot_bus;
+		slot->device = slot_device;
+		slot->hpc_ops = hpc_ops = ctrl->hpc_ops;
 
-		new_slot->number = ctrl->first_slot;
-		new_slot->hp_slot = slot_device - ctrl->slot_device_offset;
+		slot->number = ctrl->first_slot;
+		slot->hp_slot = slot_device - ctrl->slot_device_offset;
 
 		/* register this slot with the hotplug pci core */
-		new_slot->hotplug_slot->private = new_slot;
-		new_slot->hotplug_slot->release = &release_slot;
-		make_slot_name(new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
-		new_slot->hotplug_slot->ops = &pciehp_hotplug_slot_ops;
-
-		new_slot->hpc_ops->get_power_status(new_slot, &(new_slot->hotplug_slot->info->power_status));
-		new_slot->hpc_ops->get_attention_status(new_slot, &(new_slot->hotplug_slot->info->attention_status));
-		new_slot->hpc_ops->get_latch_status(new_slot, &(new_slot->hotplug_slot->info->latch_status));
-		new_slot->hpc_ops->get_adapter_status(new_slot, &(new_slot->hotplug_slot->info->adapter_status));
-
-		dbg("Registering bus=%x dev=%x hp_slot=%x sun=%x slot_device_offset=%x\n", 
-			new_slot->bus, new_slot->device, new_slot->hp_slot, new_slot->number, ctrl->slot_device_offset);
-		result = pci_hp_register (new_slot->hotplug_slot);
+		hotplug_slot->private = slot;
+		hotplug_slot->release = &release_slot;
+		make_slot_name(hotplug_slot->name, SLOT_NAME_SIZE, slot);
+		hotplug_slot->ops = &pciehp_hotplug_slot_ops;
+
+		hpc_ops->get_power_status(slot,
+			&(hotplug_slot_info->power_status));
+		hpc_ops->get_attention_status(slot,
+			&(hotplug_slot_info->attention_status));
+		hpc_ops->get_latch_status(slot,
+			&(hotplug_slot_info->latch_status));
+		hpc_ops->get_adapter_status(slot,
+			&(hotplug_slot_info->adapter_status));
+
+		dbg("Registering bus=%x dev=%x hp_slot=%x sun=%x "
+			"slot_device_offset=%x\n", 
+			slot->bus, slot->device, slot->hp_slot, slot->number,
+			ctrl->slot_device_offset);
+		result = pci_hp_register(hotplug_slot);
 		if (result) {
 			err ("pci_hp_register failed with error %d\n", result);
 			goto error_name;
 		}
 
-		new_slot->next = ctrl->slot;
-		ctrl->slot = new_slot;
+		slot->next = ctrl->slot;
+		ctrl->slot = slot;
 
 		number_of_slots--;
 		slot_device++;
@@ -176,13 +186,13 @@ static int init_slots(struct controller 
 	return 0;
 
 error_name:
-	kfree(new_slot->hotplug_slot->name);
+	kfree(hotplug_slot->name);
 error_info:
-	kfree(new_slot->hotplug_slot->info);
+	kfree(hotplug_slot_info);
 error_hpslot:
-	kfree(new_slot->hotplug_slot);
+	kfree(hotplug_slot);
 error_slot:
-	kfree(new_slot);
+	kfree(slot);
 error:
 	return result;
 }



