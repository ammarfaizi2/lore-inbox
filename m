Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbSAPSp4>; Wed, 16 Jan 2002 13:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286262AbSAPSph>; Wed, 16 Jan 2002 13:45:37 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:45329 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287112AbSAPSpY>;
	Wed, 16 Jan 2002 13:45:24 -0500
Date: Wed, 16 Jan 2002 10:41:46 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Compaq PCI Hotplug driver bugfix
Message-ID: <20020116184146.GA1658@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.5.3-pre1 for the Compaq PCI Hotplug driver that
fixes two memory leaks in the driver (one if registering a slot fails,
and the other when the driver is unloaded from the kernel.)

thanks,

greg k-h


diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Wed Jan 16 09:57:45 2002
+++ b/drivers/hotplug/cpqphp_core.c	Wed Jan 16 09:57:45 2002
@@ -404,6 +404,10 @@
 		result = pci_hp_register (new_slot->hotplug_slot);
 		if (result) {
 			err ("pci_hp_register failed with error %d\n", result);
+			kfree (new_slot->hotplug_slot->info);
+			kfree (new_slot->hotplug_slot->name);
+			kfree (new_slot->hotplug_slot);
+			kfree (new_slot);
 			return result;
 		}
 		
@@ -429,6 +433,8 @@
 	while (old_slot) {
 		next_slot = old_slot->next;
 		pci_hp_deregister (old_slot->hotplug_slot);
+		kfree(old_slot->hotplug_slot->info);
+		kfree(old_slot->hotplug_slot->name);
 		kfree(old_slot->hotplug_slot);
 		kfree(old_slot);
 		old_slot = next_slot;

