Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262431AbSJJVp5>; Thu, 10 Oct 2002 17:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSJJVpn>; Thu, 10 Oct 2002 17:45:43 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:32526 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262431AbSJJVoy>;
	Thu, 10 Oct 2002 17:44:54 -0400
Date: Thu, 10 Oct 2002 14:46:25 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug fixes for 2.4.20-pre10
Message-ID: <20021010214625.GD27523@kroah.com>
References: <20021010214455.GA27523@kroah.com> <20021010214527.GB27523@kroah.com> <20021010214549.GC27523@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010214549.GC27523@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.739   -> 1.740  
#	drivers/hotplug/ibmphp_core.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	zubarev@us.ibm.com	1.740
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
--- a/drivers/hotplug/ibmphp_core.c	Thu Oct 10 14:44:40 2002
+++ b/drivers/hotplug/ibmphp_core.c	Thu Oct 10 14:44:40 2002
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
@@ -1001,7 +1014,7 @@
 	struct pci_dev dev_t;
 	u16 l;
 
-	if (!find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
+	if (find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
 		return 1;
 	bus_t.number = busno;
 	bus_t.ops = ibmphp_pci_root_ops;
