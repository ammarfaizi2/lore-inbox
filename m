Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274559AbSITAzx>; Thu, 19 Sep 2002 20:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274474AbSITAzP>; Thu, 19 Sep 2002 20:55:15 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:47882 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274462AbSITAyF>;
	Thu, 19 Sep 2002 20:54:05 -0400
Date: Thu, 19 Sep 2002 17:58:57 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] More PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020920005857.GM18583@kroah.com>
References: <20020920005749.GI18583@kroah.com> <20020920005806.GJ18583@kroah.com> <20020920005823.GK18583@kroah.com> <20020920005840.GL18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005840.GL18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.686   -> 1.687  
#	drivers/hotplug/cpqphp_core.c	1.2     -> 1.3    
#	drivers/hotplug/cpqphp.h	1.1     -> 1.2    
#	drivers/hotplug/cpqphp_ctrl.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/18	greg@kroah.com	1.687
# PCI Hotplug: added speed status to the Compaq driver.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpqphp.h b/drivers/hotplug/cpqphp.h
--- a/drivers/hotplug/cpqphp.h	Thu Sep 19 17:18:59 2002
+++ b/drivers/hotplug/cpqphp.h	Thu Sep 19 17:18:59 2002
@@ -307,8 +307,8 @@
 	u8 first_slot;
 	u8 add_support;
 	u8 push_flag;
-	u8 speed;			/* 0 = 33MHz, 1 = 66MHz */
-	u8 speed_capability;		/* 0 = 33MHz, 1 = 66MHz */
+	enum pci_bus_speed speed;
+	enum pci_bus_speed speed_capability;
 	u8 push_button;			/* 0 = no pushbutton, 1 = pushbutton present */
 	u8 slot_switch_type;		/* 0 = no switch, 1 = switch present */
 	u8 defeature_PHP;		/* 0 = PHP not supported, 1 = PHP supported */
@@ -323,9 +323,6 @@
 	wait_queue_head_t queue;	/* sleep & wake process */
 };
 
-#define CTRL_SPEED_33MHz	0
-#define CTRL_SPEED_66MHz	1
-
 struct irq_mapping {
 	u8 barber_pole;
 	u8 valid_INT;
@@ -637,7 +634,7 @@
 	u16 misc;
 	
 	misc = readw(ctrl->hpc_reg + MISC);
-	return (misc & 0x0800) ? 1 : 0;
+	return (misc & 0x0800) ? PCI_SPEED_66MHz : PCI_SPEED_33MHz;
 }
 
 
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Thu Sep 19 17:18:59 2002
+++ b/drivers/hotplug/cpqphp_core.c	Thu Sep 19 17:18:59 2002
@@ -78,17 +78,21 @@
 static int get_attention_status	(struct hotplug_slot *slot, u8 *value);
 static int get_latch_status	(struct hotplug_slot *slot, u8 *value);
 static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
+static int get_max_bus_speed	(struct hotplug_slot *slot, enum pci_bus_speed *value);
+static int get_cur_bus_speed	(struct hotplug_slot *slot, enum pci_bus_speed *value);
 
 static struct hotplug_slot_ops cpqphp_hotplug_slot_ops = {
-	owner:			THIS_MODULE,
-	set_attention_status:	set_attention_status,
-	enable_slot:		process_SI,
-	disable_slot:		process_SS,
-	hardware_test:		hardware_test,
-	get_power_status:	get_power_status,
-	get_attention_status:	get_attention_status,
-	get_latch_status:	get_latch_status,
-	get_adapter_status:	get_adapter_status,
+	.owner =		THIS_MODULE,
+	.set_attention_status =	set_attention_status,
+	.enable_slot =		process_SI,
+	.disable_slot =		process_SS,
+	.hardware_test =	hardware_test,
+	.get_power_status =	get_power_status,
+	.get_attention_status =	get_attention_status,
+	.get_latch_status =	get_latch_status,
+	.get_adapter_status =	get_adapter_status,
+ 	.get_max_bus_speed =	get_max_bus_speed,
+ 	.get_cur_bus_speed =	get_cur_bus_speed,
 };
 
 
@@ -377,7 +381,7 @@
 			new_slot->capabilities |= PCISLOT_64_BIT_SUPPORTED;
 		if (is_slot66mhz(new_slot))
 			new_slot->capabilities |= PCISLOT_66_MHZ_SUPPORTED;
-		if (ctrl->speed == 1)
+		if (ctrl->speed == PCI_SPEED_66MHz)
 			new_slot->capabilities |= PCISLOT_66_MHZ_OPERATION;
 
 		ctrl_slot = slot_device - (readb(ctrl->hpc_reg + SLOT_MASK) >> 4);
@@ -781,6 +785,44 @@
 	return 0;
 }
 
+static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct controller *ctrl;
+	
+	if (slot == NULL)
+		return -ENODEV;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	ctrl = slot->ctrl;
+	if (ctrl == NULL)
+		return -ENODEV;
+	
+	*value = ctrl->speed_capability;
+
+	return 0;
+}
+
+static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct controller *ctrl;
+	
+	if (slot == NULL)
+		return -ENODEV;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	ctrl = slot->ctrl;
+	if (ctrl == NULL)
+		return -ENODEV;
+	
+	*value = ctrl->speed;
+
+	return 0;
+}
+
 static int cpqhpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	u8 num_of_slots = 0;
@@ -852,28 +894,28 @@
 					case PCI_SUB_HPC_ID:
 						/* Original 6500/7000 implementation */
 						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = CTRL_SPEED_33MHz;
+						ctrl->speed_capability = PCI_SPEED_33MHz;
 						ctrl->push_button = 0;			// No pushbutton
 						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
-						ctrl->defeature_PHP = 1;			// PHP is supported
+						ctrl->defeature_PHP = 1;		// PHP is supported
 						ctrl->pcix_support = 0;			// PCI-X not supported
-						ctrl->pcix_speed_capability = 0;		// N/A since PCI-X not supported
+						ctrl->pcix_speed_capability = 0;	// N/A since PCI-X not supported
 						break;
 					case PCI_SUB_HPC_ID2:
 						/* First Pushbutton implementation */
 						ctrl->push_flag = 1;
 						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = CTRL_SPEED_33MHz;
+						ctrl->speed_capability = PCI_SPEED_33MHz;
 						ctrl->push_button = 1;			// Pushbutton is present
 						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
-						ctrl->defeature_PHP = 1;			// PHP is supported
+						ctrl->defeature_PHP = 1;		// PHP is supported
 						ctrl->pcix_support = 0;			// PCI-X not supported
-						ctrl->pcix_speed_capability = 0;		// N/A since PCI-X not supported
+						ctrl->pcix_speed_capability = 0;	// N/A since PCI-X not supported
 						break;
 					case PCI_SUB_HPC_ID_INTC:
 						/* Third party (6500/7000) */
 						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = CTRL_SPEED_33MHz;
+						ctrl->speed_capability = PCI_SPEED_33MHz;
 						ctrl->push_button = 0;			// No pushbutton
 						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
 						ctrl->defeature_PHP = 1;			// PHP is supported
@@ -884,7 +926,7 @@
 						/* First 66 Mhz implementation */
 						ctrl->push_flag = 1;
 						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = CTRL_SPEED_66MHz;
+						ctrl->speed_capability = PCI_SPEED_66MHz;
 						ctrl->push_button = 1;			// Pushbutton is present
 						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
 						ctrl->defeature_PHP = 1;		// PHP is supported
@@ -902,9 +944,9 @@
 			case PCI_VENDOR_ID_INTEL:
 				/* Check for speed capability (0=33, 1=66) */
 				if (subsystem_deviceid & 0x0001) {
-					ctrl->speed_capability = CTRL_SPEED_66MHz;
+					ctrl->speed_capability = PCI_SPEED_66MHz;
 				} else {
-					ctrl->speed_capability = CTRL_SPEED_33MHz;
+					ctrl->speed_capability = PCI_SPEED_33MHz;
 				}
 
 				/* Check for push button */
@@ -981,7 +1023,7 @@
 	info("Initializing the PCI hot plug controller residing on PCI bus %d\n", pdev->bus->number);
 
 	dbg ("Hotplug controller capabilities:\n");
-	dbg ("    speed_capability       %s\n", ctrl->speed_capability == CTRL_SPEED_33MHz ? "33MHz" : "66Mhz");
+	dbg ("    speed_capability       %s\n", ctrl->speed_capability == PCI_SPEED_33MHz ? "33MHz" : "66Mhz");
 	dbg ("    slot_switch_type       %s\n", ctrl->slot_switch_type == 0 ? "no switch" : "switch present");
 	dbg ("    defeature_PHP          %s\n", ctrl->defeature_PHP == 0 ? "PHP not supported" : "PHP supported");
 	dbg ("    alternate_base_address %s\n", ctrl->alternate_base_address == 0 ? "not supported" : "supported");
diff -Nru a/drivers/hotplug/cpqphp_ctrl.c b/drivers/hotplug/cpqphp_ctrl.c
--- a/drivers/hotplug/cpqphp_ctrl.c	Thu Sep 19 17:18:59 2002
+++ b/drivers/hotplug/cpqphp_ctrl.c	Thu Sep 19 17:18:59 2002
@@ -1186,7 +1186,7 @@
 		//*********************************
 		rc = CARD_FUNCTIONING;
 	} else {
-		if (ctrl->speed == 1) {
+		if (ctrl->speed == PCI_SPEED_66MHz) {
 			// Wait for exclusive access to hardware
 			down(&ctrl->crit_sect);
 
@@ -1384,7 +1384,7 @@
 	dbg(__FUNCTION__": func->device, slot_offset, hp_slot = %d, %d ,%d\n",
 	    func->device, ctrl->slot_device_offset, hp_slot);
 
-	if (ctrl->speed == 1) {
+	if (ctrl->speed == PCI_SPEED_66MHz) {
 		// Wait for exclusive access to hardware
 		down(&ctrl->crit_sect);
 
