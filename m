Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287598AbSAPVEt>; Wed, 16 Jan 2002 16:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287880AbSAPVEo>; Wed, 16 Jan 2002 16:04:44 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:10770 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287545AbSAPVDQ>;
	Wed, 16 Jan 2002 16:03:16 -0500
Date: Wed, 16 Jan 2002 12:59:38 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Compaq PCI Hotplug driver bugfix
Message-ID: <20020116205938.GA2604@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.4.18-pre4 for the Compaq PCI Hotplug driver
that fixes two memory leaks in the driver (one if registering a slot
fails, and the other when the driver is unloaded from the kernel.)

thanks,

greg k-h


diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Wed Jan 16 12:10:57 2002
+++ b/drivers/hotplug/cpqphp_core.c	Wed Jan 16 12:10:57 2002
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
