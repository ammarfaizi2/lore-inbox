Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbVLKFlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbVLKFlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbVLKFlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:41:47 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:17041 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161095AbVLKFlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:41:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:date:user-agent:cc:mime-version:content-disposition:to:content-type:content-transfer-encoding:message-id;
        b=h71pRd2j/B1NJykhNIS9XaYMBjBzOdOBobS3+dT2jdwM2mXb4hVI3CP5TEGNKnxm+AfvEsMBWIVd4h7ZLlhs+M+yEx7h5SpNVsRvGUii6NN76jlEG+m5ARCngctk0lGbiJAepus+DktVnp1h7WxmDolwF8TNwpaxZxFH5TY0kSI=
From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH] Reduce nr of ptr derefs in drivers/pci/hotplug/cpqphp_core.c
Date: Sun, 11 Dec 2005 06:42:18 +0100
User-Agent: KMail/1.9
Cc: Torben Mathiasen <torben.mathiasen@hp.com>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512110642.18473.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to reduce the nr of pointer dereferences in
drivers/pci/hotplug/cpqphp_core.c

Benefits of this patch:
 - micro speed optimization due to fewer pointer derefs
 - generated code is slightly smaller
 - tiny line length and whitespace cleanup
 - better readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pci/hotplug/cpqphp_core.c |  121 +++++++++++++++++++++-----------------
 1 files changed, 67 insertions(+), 54 deletions(-)

orig:
   text    data     bss     dec     hex filename
  12813     416    1080   14309    37e5 drivers/pci/hotplug/cpqphp_core.o
patched:
   text    data     bss     dec     hex filename
  12799     416    1080   14295    37d7 drivers/pci/hotplug/cpqphp_core.o

--- linux-2.6.15-rc5-git1-orig/drivers/pci/hotplug/cpqphp_core.c	2005-12-04 18:48:04.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/pci/hotplug/cpqphp_core.c	2005-12-11 04:33:05.000000000 +0100
@@ -327,7 +327,9 @@ static int ctrl_slot_setup(struct contro
 			void __iomem *smbios_start,
 			void __iomem *smbios_table)
 {
-	struct slot *new_slot;
+	struct slot *slot;
+	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot_info *hotplug_slot_info;
 	u8 number_of_slots;
 	u8 slot_device;
 	u8 slot_number;
@@ -345,93 +347,105 @@ static int ctrl_slot_setup(struct contro
 	slot_number = ctrl->first_slot;
 
 	while (number_of_slots) {
-		new_slot = kmalloc(sizeof(*new_slot), GFP_KERNEL);
-		if (!new_slot)
+		slot = kmalloc(sizeof(*slot), GFP_KERNEL);
+		if (!slot)
 			goto error;
 
-		memset(new_slot, 0, sizeof(struct slot));
-		new_slot->hotplug_slot = kmalloc(sizeof(*(new_slot->hotplug_slot)),
+		memset(slot, 0, sizeof(struct slot));
+		slot->hotplug_slot = kmalloc(sizeof(*(slot->hotplug_slot)),
 						GFP_KERNEL);
-		if (!new_slot->hotplug_slot)
+		if (!slot->hotplug_slot)
 			goto error_slot;
-		memset(new_slot->hotplug_slot, 0, sizeof(struct hotplug_slot));
+		hotplug_slot = slot->hotplug_slot;
+		memset(hotplug_slot, 0, sizeof(struct hotplug_slot));
 
-		new_slot->hotplug_slot->info =
-				kmalloc(sizeof(*(new_slot->hotplug_slot->info)),
+		hotplug_slot->info =
+				kmalloc(sizeof(*(hotplug_slot->info)),
 							GFP_KERNEL);
-		if (!new_slot->hotplug_slot->info)
+		if (!hotplug_slot->info)
 			goto error_hpslot;
-		memset(new_slot->hotplug_slot->info, 0,
+		hotplug_slot_info = hotplug_slot->info;
+		memset(hotplug_slot_info, 0,
 				sizeof(struct hotplug_slot_info));
-		new_slot->hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
-		if (!new_slot->hotplug_slot->name)
+		hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
+
+		if (!hotplug_slot->name)
 			goto error_info;
 
-		new_slot->ctrl = ctrl;
-		new_slot->bus = ctrl->bus;
-		new_slot->device = slot_device;
-		new_slot->number = slot_number;
-		dbg("slot->number = %d\n",new_slot->number);
+		slot->ctrl = ctrl;
+		slot->bus = ctrl->bus;
+		slot->device = slot_device;
+		slot->number = slot_number;
+		dbg("slot->number = %d\n", slot->number);
 
 		slot_entry = get_SMBIOS_entry(smbios_start, smbios_table, 9,
 					slot_entry);
 
-		while (slot_entry && (readw(slot_entry + SMBIOS_SLOT_NUMBER) != new_slot->number)) {
+		while (slot_entry && (readw(slot_entry + SMBIOS_SLOT_NUMBER) !=
+				slot->number)) {
 			slot_entry = get_SMBIOS_entry(smbios_start,
 						smbios_table, 9, slot_entry);
 		}
 
-		new_slot->p_sm_slot = slot_entry;
+		slot->p_sm_slot = slot_entry;
 
-		init_timer(&new_slot->task_event);
-		new_slot->task_event.expires = jiffies + 5 * HZ;
-		new_slot->task_event.function = cpqhp_pushbutton_thread;
+		init_timer(&slot->task_event);
+		slot->task_event.expires = jiffies + 5 * HZ;
+		slot->task_event.function = cpqhp_pushbutton_thread;
 
 		//FIXME: these capabilities aren't used but if they are
 		//       they need to be correctly implemented
-		new_slot->capabilities |= PCISLOT_REPLACE_SUPPORTED;
-		new_slot->capabilities |= PCISLOT_INTERLOCK_SUPPORTED;
+		slot->capabilities |= PCISLOT_REPLACE_SUPPORTED;
+		slot->capabilities |= PCISLOT_INTERLOCK_SUPPORTED;
 
-		if (is_slot64bit(new_slot))
-			new_slot->capabilities |= PCISLOT_64_BIT_SUPPORTED;
-		if (is_slot66mhz(new_slot))
-			new_slot->capabilities |= PCISLOT_66_MHZ_SUPPORTED;
+		if (is_slot64bit(slot))
+			slot->capabilities |= PCISLOT_64_BIT_SUPPORTED;
+		if (is_slot66mhz(slot))
+			slot->capabilities |= PCISLOT_66_MHZ_SUPPORTED;
 		if (ctrl->speed == PCI_SPEED_66MHz)
-			new_slot->capabilities |= PCISLOT_66_MHZ_OPERATION;
+			slot->capabilities |= PCISLOT_66_MHZ_OPERATION;
 
-		ctrl_slot = slot_device - (readb(ctrl->hpc_reg + SLOT_MASK) >> 4);
+		ctrl_slot =
+			slot_device - (readb(ctrl->hpc_reg + SLOT_MASK) >> 4);
 
 		// Check presence
-		new_slot->capabilities |= ((((~tempdword) >> 23) | ((~tempdword) >> 15)) >> ctrl_slot) & 0x02;
+		slot->capabilities |=
+			((((~tempdword) >> 23) |
+			 ((~tempdword) >> 15)) >> ctrl_slot) & 0x02;
 		// Check the switch state
-		new_slot->capabilities |= ((~tempdword & 0xFF) >> ctrl_slot) & 0x01;
+		slot->capabilities |=
+			((~tempdword & 0xFF) >> ctrl_slot) & 0x01;
 		// Check the slot enable
-		new_slot->capabilities |= ((read_slot_enable(ctrl) << 2) >> ctrl_slot) & 0x04;
+		slot->capabilities |=
+			((read_slot_enable(ctrl) << 2) >> ctrl_slot) & 0x04;
 
 		/* register this slot with the hotplug pci core */
-		new_slot->hotplug_slot->release = &release_slot;
-		new_slot->hotplug_slot->private = new_slot;
-		make_slot_name(new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
-		new_slot->hotplug_slot->ops = &cpqphp_hotplug_slot_ops;
+		hotplug_slot->release = &release_slot;
+		hotplug_slot->private = slot;
+		make_slot_name(hotplug_slot->name, SLOT_NAME_SIZE, slot);
+		hotplug_slot->ops = &cpqphp_hotplug_slot_ops;
 		
-		new_slot->hotplug_slot->info->power_status = get_slot_enabled(ctrl, new_slot);
-		new_slot->hotplug_slot->info->attention_status = cpq_get_attention_status(ctrl, new_slot);
-		new_slot->hotplug_slot->info->latch_status = cpq_get_latch_status(ctrl, new_slot);
-		new_slot->hotplug_slot->info->adapter_status = get_presence_status(ctrl, new_slot);
+		hotplug_slot_info->power_status = get_slot_enabled(ctrl, slot);
+		hotplug_slot_info->attention_status =
+			cpq_get_attention_status(ctrl, slot);
+		hotplug_slot_info->latch_status =
+			cpq_get_latch_status(ctrl, slot);
+		hotplug_slot_info->adapter_status =
+			get_presence_status(ctrl, slot);
 		
-		dbg ("registering bus %d, dev %d, number %d, "
+		dbg("registering bus %d, dev %d, number %d, "
 				"ctrl->slot_device_offset %d, slot %d\n",
-				new_slot->bus, new_slot->device,
-				new_slot->number, ctrl->slot_device_offset,
+				slot->bus, slot->device,
+				slot->number, ctrl->slot_device_offset,
 				slot_number);
-		result = pci_hp_register (new_slot->hotplug_slot);
+		result = pci_hp_register(hotplug_slot);
 		if (result) {
-			err ("pci_hp_register failed with error %d\n", result);
+			err("pci_hp_register failed with error %d\n", result);
 			goto error_name;
 		}
 		
-		new_slot->next = ctrl->slot;
-		ctrl->slot = new_slot;
+		slot->next = ctrl->slot;
+		ctrl->slot = slot;
 
 		number_of_slots--;
 		slot_device++;
@@ -439,15 +453,14 @@ static int ctrl_slot_setup(struct contro
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



