Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbVLKFl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbVLKFl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbVLKFl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:41:28 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:20666 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161099AbVLKFl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:41:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=QqxoaycXTiiGS8OC3JlcBBHg4mqE5kRwKXZw27g/Q9oacKDm/k2JZ3DZ4Wc/aHkdw7AjNo4Z4Q9egdBSinbJxLjC6pN9+AxhF9bi88BzAynQ737FUewfZE23M87v3cD+RujKVNFKyoqMP3+jKZtd4yPr/I8emul2yiC3x8id5bI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] reduce nr of ptr derefs in drivers/pci/hotplug/shpchp_core.c
Date: Sun, 11 Dec 2005 06:42:02 +0100
User-Agent: KMail/1.9
Cc: drivers/pci/hotplug/shpchp_core.c@dragon.mynet.local,
       kristen.c.accardi@intel.com, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512110642.02868.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to reduce the nr. of pointer dereferences in
drivers/pci/hotplug/shpchp_core.c

Benefits:
 - micro speed optimization due to fewer pointer derefs
 - get rid of a pointless cast of kmalloc() return value
 - generated code is slightly smaller
 - better readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pci/hotplug/shpchp_core.c |   92 +++++++++++++++++++++-----------------
 1 files changed, 52 insertions(+), 40 deletions(-)

orig:
   text    data     bss     dec     hex filename
   5917     448      16    6381    18ed drivers/pci/hotplug/shpchp_core.o
patched:
   text    data     bss     dec     hex filename
   5896     448      16    6360    18d8 drivers/pci/hotplug/shpchp_core.o

--- linux-2.6.15-rc5-git1-orig/drivers/pci/hotplug/shpchp_core.c	2005-12-04 18:48:04.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/pci/hotplug/shpchp_core.c	2005-12-11 05:12:04.000000000 +0100
@@ -99,7 +99,10 @@ static void release_slot(struct hotplug_
 
 static int init_slots(struct controller *ctrl)
 {
-	struct slot *new_slot;
+	struct slot *slot;
+	struct hpc_ops *hpc_ops;
+	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot_info *hotplug_slot_info;
 	u8 number_of_slots;
 	u8 slot_device;
 	u32 slot_number, sun;
@@ -110,58 +113,68 @@ static int init_slots(struct controller 
 	slot_number = ctrl->first_slot;
 
 	while (number_of_slots) {
-		new_slot = (struct slot *) kmalloc(sizeof(struct slot), GFP_KERNEL);
-		if (!new_slot)
+		slot = kmalloc(sizeof(struct slot), GFP_KERNEL);
+		if (!slot)
 			goto error;
 
-		memset(new_slot, 0, sizeof(struct slot));
-		new_slot->hotplug_slot = kmalloc (sizeof (struct hotplug_slot), GFP_KERNEL);
-		if (!new_slot->hotplug_slot)
+		memset(slot, 0, sizeof(struct slot));
+		slot->hotplug_slot =
+			kmalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
+		if (!slot->hotplug_slot)
 			goto error_slot;
-		memset(new_slot->hotplug_slot, 0, sizeof (struct hotplug_slot));
+		hotplug_slot = slot->hotplug_slot;
+		memset(hotplug_slot, 0, sizeof(struct hotplug_slot));
 
-		new_slot->hotplug_slot->info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
-		if (!new_slot->hotplug_slot->info)
+		hotplug_slot->info =
+			kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
+		if (!hotplug_slot->info)
 			goto error_hpslot;
-		memset(new_slot->hotplug_slot->info, 0, sizeof (struct hotplug_slot_info));
-		new_slot->hotplug_slot->name = kmalloc (SLOT_NAME_SIZE, GFP_KERNEL);
-		if (!new_slot->hotplug_slot->name)
+		hotplug_slot_info = hotplug_slot->info;
+		memset(hotplug_slot_info, 0, sizeof(struct hotplug_slot_info));
+		hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
+		if (!hotplug_slot->name)
 			goto error_info;
 
-		new_slot->magic = SLOT_MAGIC;
-		new_slot->ctrl = ctrl;
-		new_slot->bus = ctrl->slot_bus;
-		new_slot->device = slot_device;
-		new_slot->hpc_ops = ctrl->hpc_ops;
+		slot->magic = SLOT_MAGIC;
+		slot->ctrl = ctrl;
+		slot->bus = ctrl->slot_bus;
+		slot->device = slot_device;
+		slot->hpc_ops = hpc_ops = ctrl->hpc_ops;
 
 		if (shpchprm_get_physical_slot_number(ctrl, &sun,
-					new_slot->bus, new_slot->device))
+					slot->bus, slot->device))
 			goto error_name;
 
-		new_slot->number = sun;
-		new_slot->hp_slot = slot_device - ctrl->slot_device_offset;
+		slot->number = sun;
+		slot->hp_slot = slot_device - ctrl->slot_device_offset;
 
 		/* register this slot with the hotplug pci core */
-		new_slot->hotplug_slot->private = new_slot;
-		new_slot->hotplug_slot->release = &release_slot;
-		make_slot_name(new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
-		new_slot->hotplug_slot->ops = &shpchp_hotplug_slot_ops;
-
-		new_slot->hpc_ops->get_power_status(new_slot, &(new_slot->hotplug_slot->info->power_status));
-		new_slot->hpc_ops->get_attention_status(new_slot, &(new_slot->hotplug_slot->info->attention_status));
-		new_slot->hpc_ops->get_latch_status(new_slot, &(new_slot->hotplug_slot->info->latch_status));
-		new_slot->hpc_ops->get_adapter_status(new_slot, &(new_slot->hotplug_slot->info->adapter_status));
-
-		dbg("Registering bus=%x dev=%x hp_slot=%x sun=%x slot_device_offset=%x\n", new_slot->bus, 
-			new_slot->device, new_slot->hp_slot, new_slot->number, ctrl->slot_device_offset);
-		result = pci_hp_register (new_slot->hotplug_slot);
+		hotplug_slot->private = slot;
+		hotplug_slot->release = &release_slot;
+		make_slot_name(hotplug_slot->name, SLOT_NAME_SIZE, slot);
+		hotplug_slot->ops = &shpchp_hotplug_slot_ops;
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
@@ -169,15 +182,14 @@ static int init_slots(struct controller 
 	}
 
 	return 0;
-
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



