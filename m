Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSJIWiD>; Wed, 9 Oct 2002 18:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbSJIWiD>; Wed, 9 Oct 2002 18:38:03 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:64267 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262415AbSJIWh7>;
	Wed, 9 Oct 2002 18:37:59 -0400
Date: Wed, 9 Oct 2002 15:39:46 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI hotplug changes for 2.5.41
Message-ID: <20021009223945.GC18646@kroah.com>
References: <20021009223848.GB18646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009223848.GB18646@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.740   -> 1.741  
#	drivers/hotplug/ibmphp_core.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/09	zubarev@us.ibm.com	1.741
# [PATCH] IBM PCI Hotplug: small patch
# 
# This is a small patch on top of what you sent out to the kernel
# already.  I basically uncommented out another place, where we call
# pci_hp_change_info and changed to the new method.  And also, when I sent
# you those (polling, isa, pci...) patches sometime back, I made a mistake
# when I was translating the code from the way RPM is to the way we want in
# the kernel (since in RPM we cannot have option to compile kernel).
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Wed Oct  9 15:37:50 2002
+++ b/drivers/hotplug/ibmphp_core.c	Wed Oct  9 15:37:50 2002
@@ -686,9 +686,10 @@
 int ibmphp_update_slot_info (struct slot *slot_cur)
 {
 	struct hotplug_slot_info *info;
-	char buffer[10];
+	char buffer[30];
 	int rc;
-//	u8 bus_speed;
+	u8 bus_speed;
+	u8 mode;
 
 	info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
 	if (!info) {
@@ -696,7 +697,7 @@
 		return -ENOMEM;
 	}
         
-	snprintf (buffer, 10, "%d", slot_cur->number);
+	strncpy (buffer, slot_cur->hotplug_slot->name, 30);
 	info->power_status = SLOT_PWRGD (slot_cur->status);
 	info->attention_status = SLOT_ATTN (slot_cur->status, slot_cur->ext_status);
 	info->latch_status = SLOT_LATCH (slot_cur->status);
@@ -707,21 +708,33 @@
                 info->adapter_status = 1;
 //		get_max_adapter_speed_1 (slot_cur->hotplug_slot, &info->max_adapter_speed_status, 0);
 	}
-	/* !!!!!!!!!TO DO: THIS NEEDS TO CHANGE!!!!!!!!!!!!! */
-/*	bus_speed = slot_cur->bus_on->current_speed;
-	bus_speed &= 0x0f;
-                        
-	if (slot_cur->bus_on->current_bus_mode == BUS_MODE_PCIX)
-		bus_speed |= 0x80;
-	else if (slot_cur->bus_on->current_bus_mode == BUS_MODE_PCI)
-		bus_speed |= 0x40;
-	else
-		bus_speed |= 0x20;
+
+	bus_speed = slot_cur->bus_on->current_speed;
+	mode = slot_cur->bus_on->current_bus_mode;
+
+	switch (bus_speed) {
+	case BUS_SPEED_33:
+		break;
+	case BUS_SPEED_66:
+		if (mode == BUS_MODE_PCIX) 
+			bus_speed += 0x01;
+		else if (mode == BUS_MODE_PCI)
+			;
+		else
+			bus_speed = PCI_SPEED_UNKNOWN;
+		break;
+	case BUS_SPEED_100:
+	case BUS_SPEED_133:
+		bus_speed += 0x01;
+		break;
+	default:
+		bus_speed = PCI_SPEED_UNKNOWN;
+	}
 
 	info->cur_bus_speed_status = bus_speed;
 	info->max_bus_speed_status = slot_cur->hotplug_slot->info->max_bus_speed_status;
 	// To do: bus_names 
-*/	
+	
 	rc = pci_hp_change_slot_info (buffer, info);
 	kfree (info);
 	return rc;
@@ -989,7 +1002,7 @@
 	struct pci_dev *dev;
 	u16 l;
 
-	if (!find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
+	if (find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
 		return 1;
 
 	bus = kmalloc (sizeof (*bus), GFP_KERNEL);
