Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265023AbTGLP4v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbTGLP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:56:47 -0400
Received: from fmr04.intel.com ([143.183.121.6]:14814 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265023AbTGLPzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:55:05 -0400
Date: Sat, 12 Jul 2003 09:09:47 -0700
From: Dely Sy <dlsy@unix-os.sc.intel.com>
Message-Id: <200307121609.h6CG9ld28328@unix-os.sc.intel.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch] 1/4 PCI Hot-plug driver patch for 2.5.74 kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was sent out to this and pcihpd-discuss mailing lists on 7/10.  However, it didn't show up on this mailing list most probably due to the message size.  Now I make it into 4 parts and resend them.  There were already a few discussions on this patch.


----------------------------------------------------------------
Greg,

Here is the patch for the PCI hot-plug driver (for Compaq or equivalent HPC)
in 2.5.74 kernel.  This driver patch is for both IA-64 and IA-32 platforms.
It supports the use of either HRT or ACPI approach for resource information.

Thanks,
Dely
 

diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	2003-07-02 13:38:40.000000000 -0700
+++ b/drivers/pci/hotplug/cpqphp_core.c	2003-07-07 11:34:56.000000000 -0700
@@ -39,26 +39,15 @@
 #include <linux/workqueue.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
-
 #include <asm/uaccess.h>
-
 #include "cpqphp.h"
-#include "cpqphp_nvram.h"
-#include "../../../arch/i386/pci/pci.h"	/* horrible hack showing how processor dependent we are... */
-
+#include "phprm.h"
 
 /* Global variables */
 int cpqhp_debug;
 struct controller *cpqhp_ctrl_list;	/* = NULL */
 struct pci_func *cpqhp_slot_list[256];
-
-/* local variables */
-static void *smbios_table;
-static void *smbios_start;
-static void *cpqhp_rom_start;
 static u8 power_mode;
-static int debug;
 
 #define DRIVER_VERSION	"0.9.7"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>"
@@ -71,9 +60,10 @@
 MODULE_PARM(power_mode, "b");
 MODULE_PARM_DESC(power_mode, "Power mode enabled or not");
 
-MODULE_PARM(debug, "i");
-MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
+MODULE_PARM(cpqhp_debug, "i");
+MODULE_PARM_DESC(cpqhp_debug, "Debugging mode enabled or not");
 
+#define CPQHPC_MODULE_NAME "cpqphp"
 #define CPQHPC_MODULE_MINOR 208
 
 static int one_time_init (void);
@@ -102,216 +92,6 @@
   	.get_cur_bus_speed =	get_cur_bus_speed,
 };
 
-
-static inline int is_slot64bit (struct slot *slot)
-{
-	if (!slot || !slot->p_sm_slot)
-		return 0;
-
-	if (readb(slot->p_sm_slot + SMBIOS_SLOT_WIDTH) == 0x06)
-		return 1;
-
-	return 0;
-}
-
-static inline int is_slot66mhz (struct slot *slot)
-{
-	if (!slot || !slot->p_sm_slot)
-		return 0;
-
-	if (readb(slot->p_sm_slot + SMBIOS_SLOT_TYPE) == 0x0E)
-		return 1;
-
-	return 0;
-}
-
-/**
- * detect_SMBIOS_pointer - find the system Management BIOS Table in the specified region of memory.
- *
- * @begin: begin pointer for region to be scanned.
- * @end: end pointer for region to be scanned.
- *
- * Returns pointer to the head of the SMBIOS tables (or NULL)
- *
- */
-static void * detect_SMBIOS_pointer(void *begin, void *end)
-{
-	void *fp;
-	void *endp;
-	u8 temp1, temp2, temp3, temp4;
-	int status = 0;
-
-	endp = (end - sizeof(u32) + 1);
-
-	for (fp = begin; fp <= endp; fp += 16) {
-		temp1 = readb(fp);
-		temp2 = readb(fp+1);
-		temp3 = readb(fp+2);
-		temp4 = readb(fp+3);
-		if (temp1 == '_' &&
-		    temp2 == 'S' &&
-		    temp3 == 'M' &&
-		    temp4 == '_') {
-			status = 1;
-			break;
-		}
-	}
-	
-	if (!status)
-		fp = NULL;
-
-	dbg("Discovered SMBIOS Entry point at %p\n", fp);
-
-	return fp;
-}
-
-/**
- * init_SERR - Initializes the per slot SERR generation.
- *
- * For unexpected switch opens
- *
- */
-static int init_SERR(struct controller * ctrl)
-{
-	u32 tempdword;
-	u32 number_of_slots;
-	u8 physical_slot;
-
-	if (!ctrl)
-		return 1;
-
-	tempdword = ctrl->first_slot;
-
-	number_of_slots = readb(ctrl->hpc_reg + SLOT_MASK) & 0x0F;
-	// Loop through slots
-	while (number_of_slots) {
-		physical_slot = tempdword;
-		writeb(0, ctrl->hpc_reg + SLOT_SERR);
-		tempdword++;
-		number_of_slots--;
-	}
-
-	return 0;
-}
-
-
-/* nice debugging output */
-static int pci_print_IRQ_route (void)
-{
-	struct irq_routing_table *routing_table;
-	int len;
-	int loop;
-
-	u8 tbus, tdevice, tslot;
-
-	routing_table = pcibios_get_irq_routing_table();
-	if (routing_table == NULL) {
-		err("No BIOS Routing Table??? Not good\n");
-		return -ENOMEM;
-	}
-
-	len = (routing_table->size - sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
-	// Make sure I got at least one entry
-	if (len == 0) {
-		kfree(routing_table);
-		return -1;
-	}
-
-	dbg("bus dev func slot\n");
-
-	for (loop = 0; loop < len; ++loop) {
-		tbus = routing_table->slots[loop].bus;
-		tdevice = routing_table->slots[loop].devfn;
-		tslot = routing_table->slots[loop].slot;
-		dbg("%d %d %d %d\n", tbus, tdevice >> 3, tdevice & 0x7, tslot);
-
-	}
-	kfree(routing_table);
-	return 0;
-}
-
-
-/*
- * get_subsequent_smbios_entry
- *
- * Gets the first entry if previous == NULL
- * Otherwise, returns the next entry
- * Uses global SMBIOS Table pointer
- *
- * @curr: %NULL or pointer to previously returned structure
- *
- * returns a pointer to an SMBIOS structure or NULL if none found
- */
-static void * get_subsequent_smbios_entry(void *smbios_start, void *smbios_table, void *curr)
-{
-	u8 bail = 0;
-	u8 previous_byte = 1;
-	void *p_temp;
-	void *p_max;
-
-	if (!smbios_table || !curr)
-		return(NULL);
-
-	// set p_max to the end of the table
-	p_max = smbios_start + readw(smbios_table + ST_LENGTH);
-
-	p_temp = curr;
-	p_temp += readb(curr + SMBIOS_GENERIC_LENGTH);
-
-	while ((p_temp < p_max) && !bail) {
-		// Look for the double NULL terminator
-		// The first condition is the previous byte and the second is the curr
-		if (!previous_byte && !(readb(p_temp))) {
-			bail = 1;
-		}
-
-		previous_byte = readb(p_temp);
-		p_temp++;
-	}
-
-	if (p_temp < p_max) {
-		return p_temp;
-	} else {
-		return NULL;
-	}
-}
-
-
-/**
- * get_SMBIOS_entry
- *
- * @type:SMBIOS structure type to be returned
- * @previous: %NULL or pointer to previously returned structure
- *
- * Gets the first entry of the specified type if previous == NULL
- * Otherwise, returns the next entry of the given type.
- * Uses global SMBIOS Table pointer
- * Uses get_subsequent_smbios_entry
- *
- * returns a pointer to an SMBIOS structure or %NULL if none found
- */
-static void *get_SMBIOS_entry (void *smbios_start, void *smbios_table, u8 type, void * previous)
-{
-	if (!smbios_table)
-		return NULL;
-
-	if (!previous) {		  
-		previous = smbios_start;
-	} else {
-		previous = get_subsequent_smbios_entry(smbios_start, smbios_table, previous);
-	}
-
-	while (previous) {
-	       	if (readb(previous + SMBIOS_GENERIC_TYPE) != type) {
-			previous = get_subsequent_smbios_entry(smbios_start, smbios_table, previous);
-		} else {
-			break;
-		}
-	}
-
-	return previous;
-}
-
 static void release_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
@@ -327,23 +107,19 @@
 	kfree(slot);
 }
 
-static int ctrl_slot_setup (struct controller * ctrl, void *smbios_start, void *smbios_table)
+static int ctrl_slot_setup(struct controller *ctrl)
 {
 	struct slot *new_slot;
 	u8 number_of_slots;
 	u8 slot_device;
-	u8 slot_number;
-	u8 ctrl_slot;
-	u32 tempdword;
-	void *slot_entry= NULL;
+	u32 slot_number;
+	u32 sun;
 	int result;
 
-	dbg("%s\n", __FUNCTION__);
+	dbg("%s\n",__FUNCTION__);
 
-	tempdword = readl(ctrl->hpc_reg + INT_INPUT_CLEAR);
-
-	number_of_slots = readb(ctrl->hpc_reg + SLOT_MASK) & 0x0F;
-	slot_device = readb(ctrl->hpc_reg + SLOT_MASK) >> 4;
+	number_of_slots = ctrl->num_ctlr_slots;
+	slot_device = ctrl->first_device_num;
 	slot_number = ctrl->first_slot;
 
 	while (number_of_slots) {
@@ -378,73 +154,66 @@
 		new_slot->ctrl = ctrl;
 		new_slot->bus = ctrl->bus;
 		new_slot->device = slot_device;
-		new_slot->number = slot_number;
-		dbg("slot->number = %d\n",new_slot->number);
-
-		slot_entry = get_SMBIOS_entry(smbios_start, smbios_table, 9, slot_entry);
+		new_slot->hpc_ops = ctrl->hpc_ops;
 
-		while (slot_entry && (readw(slot_entry + SMBIOS_SLOT_NUMBER) != new_slot->number)) {
-			slot_entry = get_SMBIOS_entry(smbios_start, smbios_table, 9, slot_entry);
+		if (phprm_get_physical_slot_number(ctrl, &sun, new_slot->bus, new_slot->device)) {
+			kfree (new_slot->hotplug_slot->info);
+			kfree (new_slot->hotplug_slot);
+			kfree (new_slot);
+			return -1;
 		}
 
-		new_slot->p_sm_slot = slot_entry;
+		if (slot_number != sun)
+			err("ERR: slot->number=%08x, sun=%08x\n", slot_number, sun);
 
-		init_timer(&new_slot->task_event);
-		new_slot->task_event.expires = jiffies + 5 * HZ;
-		new_slot->task_event.function = cpqhp_pushbutton_thread;
-
-		//FIXME: these capabilities aren't used but if they are
-		//       they need to be correctly implemented
-		new_slot->capabilities |= PCISLOT_REPLACE_SUPPORTED;
-		new_slot->capabilities |= PCISLOT_INTERLOCK_SUPPORTED;
-
-		if (is_slot64bit(new_slot))
-			new_slot->capabilities |= PCISLOT_64_BIT_SUPPORTED;
-		if (is_slot66mhz(new_slot))
-			new_slot->capabilities |= PCISLOT_66_MHZ_SUPPORTED;
-		if (ctrl->speed == PCI_SPEED_66MHz)
-			new_slot->capabilities |= PCISLOT_66_MHZ_OPERATION;
-
-		ctrl_slot = slot_device - (readb(ctrl->hpc_reg + SLOT_MASK) >> 4);
-
-		// Check presence
-		new_slot->capabilities |= ((((~tempdword) >> 23) | ((~tempdword) >> 15)) >> ctrl_slot) & 0x02;
-		// Check the switch state
-		new_slot->capabilities |= ((~tempdword & 0xFF) >> ctrl_slot) & 0x01;
-		// Check the slot enable
-		new_slot->capabilities |= ((read_slot_enable(ctrl) << 2) >> ctrl_slot) & 0x04;
+		new_slot->number = sun;
+		new_slot->hp_slot = slot_device - ctrl->first_device_num;
 
+		phprm_get_slot_capability(ctrl, new_slot);
+
+		/*  
+		 *  Need to check if push button mode is supported before
+		 *  invoking pushbutton_thread
+		 */
+		if (PUSH_BUTTON(ctrl->ctlrcap)) {
+			init_timer(&new_slot->task_event);
+			new_slot->task_event.expires = jiffies + 5 * HZ;
+			new_slot->task_event.function = cpqhp_pushbutton_thread;
+		}
+
+		new_slot->capabilities |= new_slot->hpc_ops->get_slot_capability(new_slot);
 		/* register this slot with the hotplug pci core */
 		new_slot->hotplug_slot->release = &release_slot;
 		new_slot->hotplug_slot->private = new_slot;
 		make_slot_name (new_slot->hotplug_slot->name, SLOT_NAME_SIZE, new_slot);
 		new_slot->hotplug_slot->ops = &cpqphp_hotplug_slot_ops;
-		
-		new_slot->hotplug_slot->info->power_status = get_slot_enabled(ctrl, new_slot);
-		new_slot->hotplug_slot->info->attention_status = cpq_get_attention_status(ctrl, new_slot);
-		new_slot->hotplug_slot->info->latch_status = cpq_get_latch_status(ctrl, new_slot);
-		new_slot->hotplug_slot->info->adapter_status = get_presence_status(ctrl, new_slot);
-		
-		dbg ("registering bus %d, dev %d, number %d, ctrl->slot_device_offset %d, slot %d\n", 
-		     new_slot->bus, new_slot->device, new_slot->number, ctrl->slot_device_offset, slot_number);
+
+		new_slot->hpc_ops->get_power_status(new_slot, &(new_slot->hotplug_slot->info->power_status));
+		new_slot->hpc_ops->get_attention_status(new_slot, &(new_slot->hotplug_slot->info->attention_status));
+		new_slot->hpc_ops->get_latch_status(new_slot, &(new_slot->hotplug_slot->info->latch_status));
+		new_slot->hpc_ops->get_adapter_status(new_slot, &(new_slot->hotplug_slot->info->adapter_status));
+
+
+		dbg("Registering bus=%x dev=%x hp_slot=%x sun=%x slot_device_offset=%x\n", new_slot->bus, new_slot->device, new_slot->hp_slot, new_slot->number, ctrl->slot_device_offset);
 		result = pci_hp_register (new_slot->hotplug_slot);
 		if (result) {
 			err ("pci_hp_register failed with error %d\n", result);
 			release_slot(new_slot->hotplug_slot);
 			return result;
 		}
-		
+
 		new_slot->next = ctrl->slot;
 		ctrl->slot = new_slot;
 
 		number_of_slots--;
 		slot_device++;
-		slot_number++;
+		slot_number += ctrl->slot_num_inc;
 	}
 
 	return 0;
 }
 
+
 static int ctrl_slot_cleanup (struct controller * ctrl)
 {
 	struct slot *old_slot, *next_slot;
@@ -459,137 +228,47 @@
 		old_slot = next_slot;
 	}
 
-	//Free IRQ associated with hot plug device
-	free_irq(ctrl->interrupt, ctrl);
-	//Unmap the memory
-	iounmap(ctrl->hpc_reg);
-	//Finally reclaim PCI mem
-	release_mem_region(pci_resource_start(ctrl->pci_dev, 0),
-			   pci_resource_len(ctrl->pci_dev, 0));
 
 	return(0);
 }
 
-
-//============================================================================
-// function:	get_slot_mapping
-//
-// Description: Attempts to determine a logical slot mapping for a PCI
-//		device.  Won't work for more than one PCI-PCI bridge
-//		in a slot.
-//
-// Input:	u8 bus_num - bus number of PCI device
-//		u8 dev_num - device number of PCI device
-//		u8 *slot - Pointer to u8 where slot number will
-//			be returned
-//
-// Output:	SUCCESS or FAILURE
-//=============================================================================
-static int get_slot_mapping (struct pci_bus *bus, u8 bus_num, u8 dev_num, u8 *slot)
+static int get_ctlr_slot_config(struct controller *ctrl)
 {
-	struct irq_routing_table *PCIIRQRoutingInfoLength;
-	u32 work;
-	long len;
-	long loop;
-
-	u8 tbus, tdevice, tslot, bridgeSlot;
-
-	dbg("%s: %p, %d, %d, %p\n", __FUNCTION__, bus, bus_num, dev_num, slot);
-
-	bridgeSlot = 0xFF;
-
-	PCIIRQRoutingInfoLength = pcibios_get_irq_routing_table();
-	if (!PCIIRQRoutingInfoLength)
-		return -1;
-
-	len = (PCIIRQRoutingInfoLength->size -
-	       sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
-	// Make sure I got at least one entry
-	if (len == 0) {
-		kfree(PCIIRQRoutingInfoLength);
-		return -1;
-	}
-
-	for (loop = 0; loop < len; ++loop) {
-		tbus = PCIIRQRoutingInfoLength->slots[loop].bus;
-		tdevice = PCIIRQRoutingInfoLength->slots[loop].devfn >> 3;
-		tslot = PCIIRQRoutingInfoLength->slots[loop].slot;
-
-		if ((tbus == bus_num) && (tdevice == dev_num)) {
-			*slot = tslot;
-			kfree(PCIIRQRoutingInfoLength);
-			return 0;
-		} else {
-			// Didn't get a match on the target PCI device. Check if the
-			// current IRQ table entry is a PCI-to-PCI bridge device.  If so,
-			// and it's secondary bus matches the bus number for the target 
-			// device, I need to save the bridge's slot number.  If I can't 
-			// find an entry for the target device, I will have to assume it's 
-			// on the other side of the bridge, and assign it the bridge's slot.
-			bus->number = tbus;
-			pci_bus_read_config_dword (bus, PCI_DEVFN(tdevice, 0), PCI_REVISION_ID, &work);
-
-			if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
-				pci_bus_read_config_dword (bus, PCI_DEVFN(tdevice, 0), PCI_PRIMARY_BUS, &work);
-				// See if bridge's secondary bus matches target bus.
-				if (((work >> 8) & 0x000000FF) == (long) bus_num) {
-					bridgeSlot = tslot;
-				}
-			}
-		}
+	int num_ctlr_slots;
+	int first_device_num;
+	int physical_slot_num;
+	u32 psn;
+	int updown, flags;
+	int rc;
 
+	rc = phphpc_get_ctlr_slot_config(ctrl, &num_ctlr_slots, &first_device_num, &physical_slot_num, &updown, &flags);
+	if (rc) {
+		err("%s: get_ctlr_slot_config fail for b:d (%x:%x)\n", __FUNCTION__, ctrl->bus, ctrl->device);
+		return (-1);
 	}
 
-	// If we got here, we didn't find an entry in the IRQ mapping table 
-	// for the target PCI device.  If we did determine that the target 
-	// device is on the other side of a PCI-to-PCI bridge, return the 
-	// slot number for the bridge.
-	if (bridgeSlot != 0xFF) {
-		*slot = bridgeSlot;
-		kfree(PCIIRQRoutingInfoLength);
-		return 0;
-	}
-	kfree(PCIIRQRoutingInfoLength);
-	// Couldn't find an entry in the routing table for this PCI device
-	return -1;
-}
-
-
-/**
- * cpqhp_set_attention_status - Turns the Amber LED for a slot on or off
- *
- */
-static int cpqhp_set_attention_status (struct controller *ctrl, struct pci_func *func, u32 status)
-{
-	u8 hp_slot;
-
-	hp_slot = func->device - ctrl->slot_device_offset;
-
-	if (func == NULL)
-		return(1);
-
-	// Wait for exclusive access to hardware
-	down(&ctrl->crit_sect);
-
-	if (status == 1) {
-		amber_LED_on (ctrl, hp_slot);
-	} else if (status == 0) {
-		amber_LED_off (ctrl, hp_slot);
-	} else {
-		// Done with exclusive hardware access
-		up(&ctrl->crit_sect);
-		return(1);
+	/* 
+	 *  physical_slot_num is from controller according to SHPC.
+	 *  But legacy HPC does not have it. so we call phprm 
+	 */
+	if (flags) {
+		rc = phprm_get_slot_mapping(ctrl, ctrl->bus, first_device_num, &psn);
+		if (rc) {
+			err("%s: cannot map psn for b:d (%x:%x)\n", __FUNCTION__, ctrl->bus, ctrl->device);
+			return (-1);
+		}
+		physical_slot_num = psn;
 	}
 
-	set_SOGO(ctrl);
+	ctrl->num_ctlr_slots = num_ctlr_slots;
+	ctrl->first_device_num = first_device_num;
+	ctrl->first_slot = physical_slot_num;
+	ctrl->slot_num_inc = updown;
 
-	// Wait for SOBS to be unset
-	wait_for_ctrl_irq (ctrl);
-
-	// Done with exclusive hardware access
-	up(&ctrl->crit_sect);
+	dbg("%s: num_slot(0x%x) 1st_dev(0x%x) psn(0x%x) updown(%d) for b:d (%x:%x)\n",
+		__FUNCTION__, num_ctlr_slots, first_device_num, physical_slot_num, updown, ctrl->bus, ctrl->device);
 
-	return(0);
+	return (0);
 }
 
 
@@ -599,184 +278,110 @@
  */
 static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 status)
 {
-	struct pci_func *slot_func;
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
-	u8 bus;
-	u8 devfn;
-	u8 device;
-	u8 function;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
 	
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
-	
-	if (cpqhp_get_bus_dev(ctrl, &bus, &devfn, slot->number) == -1)
-		return -ENODEV;
+	hotplug_slot->info->power_status = status;
+	down(&slot->ctrl->crit_sect);
+	slot->hpc_ops->set_attention_status(slot, status);
+	slot->hpc_ops->update_hpc(slot);
+	up(&slot->ctrl->crit_sect);
 
-	device = devfn >> 3;
-	function = devfn & 0x7;
-	dbg("bus, dev, fn = %d, %d, %d\n", bus, device, function);
-
-	slot_func = cpqhp_slot_find(bus, device, function);
-	if (!slot_func) {
-		return -ENODEV;
-	}
-
-	return cpqhp_set_attention_status(ctrl, slot_func, status);
+	return 0;
 }
 
 
 static int process_SI (struct hotplug_slot *hotplug_slot)
 {
-	struct pci_func *slot_func;
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
-	u8 bus;
-	u8 devfn;
-	u8 device;
-	u8 function;
 	
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
-	
-	if (cpqhp_get_bus_dev(ctrl, &bus, &devfn, slot->number) == -1)
-		return -ENODEV;
-
-	device = devfn >> 3;
-	function = devfn & 0x7;
-	dbg("bus, dev, fn = %d, %d, %d\n", bus, device, function);
-
-	slot_func = cpqhp_slot_find(bus, device, function);
-	if (!slot_func) {
-		return -ENODEV;
-	}
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	slot_func->bus = bus;
-	slot_func->device = device;
-	slot_func->function = function;
-	slot_func->configured = 0;
-	dbg("board_added(%p, %p)\n", slot_func, ctrl);
-	return cpqhp_process_SI(ctrl, slot_func);
+	return cpqhp_process_SI(slot);
 }
 
 
 static int process_SS (struct hotplug_slot *hotplug_slot)
 {
-	struct pci_func *slot_func;
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
-	u8 bus;
-	u8 devfn;
-	u8 device;
-	u8 function;
 	
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
-
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
-	
-	if (cpqhp_get_bus_dev(ctrl, &bus, &devfn, slot->number) == -1)
-		return -ENODEV;
 
-	device = devfn >> 3;
-	function = devfn & 0x7;
-	dbg("bus, dev, fn = %d, %d, %d\n", bus, device, function);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	slot_func = cpqhp_slot_find(bus, device, function);
-	if (!slot_func) {
-		return -ENODEV;
-	}
-	
-	dbg("In power_down_board, slot_func = %p, ctrl = %p\n", slot_func, ctrl);
-	return cpqhp_process_SS(ctrl, slot_func);
+	return cpqhp_process_SS(slot);
 }
 
 
 static int hardware_test (struct hotplug_slot *hotplug_slot, u32 value)
 {
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
-
-	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	if (slot == NULL)
 		return -ENODEV;
 
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+	info("No hardware tests are defined for this driver");
 
-	return cpqhp_hardware_test (ctrl, value);	
+	return -ENODEV;
 }
 
 
 static int get_power_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
+	int retval;
 	
 	if (slot == NULL)
 		return -ENODEV;
 	
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
-	
-	*value = get_slot_enabled(ctrl, slot);
+	retval = slot->hpc_ops->get_power_status(slot, value);
+	if (retval < 0)
+		*value = hotplug_slot->info->power_status;
+
 	return 0;
 }
 
 static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
+	int retval;
 	
 	if (slot == NULL)
 		return -ENODEV;
 	
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
-	
-	*value = cpq_get_attention_status(ctrl, slot);
+	retval = slot->hpc_ops->get_attention_status(slot, value);
+	if (retval < 0)
+		*value = hotplug_slot->info->attention_status;
+
 	return 0;
 }
 
 static int get_latch_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
+	int retval;
 	
 	if (slot == NULL)
 		return -ENODEV;
 	
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
-	
-	*value = cpq_get_latch_status (ctrl, slot);
+	retval = slot->hpc_ops->get_latch_status(slot, value);
+	if (retval < 0)
+		*value = hotplug_slot->info->latch_status;
 
 	return 0;
 }
@@ -784,18 +389,17 @@
 static int get_adapter_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
+	int retval;
 	
 	if (slot == NULL)
 		return -ENODEV;
 
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
-	
-	*value = get_presence_status (ctrl, slot);
+	retval = slot->hpc_ops->get_adapter_status(slot, value);
+
+	if (retval < 0)
+		*value = hotplug_slot->info->adapter_status;
 
 	return 0;
 }
@@ -803,18 +407,16 @@
 static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
+	int retval;
 	
 	if (slot == NULL)
 		return -ENODEV;
 
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
-
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
 	
-	*value = ctrl->speed_capability;
+	retval = slot->hpc_ops->get_max_bus_speed(slot, value);
+	if (retval < 0)
+		*value = PCI_SPEED_UNKNOWN;
 
 	return 0;
 }
@@ -822,275 +424,53 @@
 static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
-	struct controller *ctrl;
+	int retval;
 	
 	if (slot == NULL)
 		return -ENODEV;
 
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
-
-	ctrl = slot->ctrl;
-	if (ctrl == NULL)
-		return -ENODEV;
 	
-	*value = ctrl->speed;
+	retval = slot->hpc_ops->get_cur_bus_speed(slot, value);
+	if (retval < 0)
+		*value = PCI_SPEED_UNKNOWN;
 
 	return 0;
 }
 
 static int cpqhpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	u8 num_of_slots = 0;
 	u8 hp_slot = 0;
-	u8 device;
 	u8 rev;
-	u8 bus_cap;
-	u16 temp_word;
-	u16 vendor_id;
-	u16 subsystem_vid;
-	u16 subsystem_deviceid;
-	u32 rc;
+	int rc;
 	struct controller *ctrl;
+	struct slot *t_slot;
 	struct pci_func *func;
-
-	// Need to read VID early b/c it's used to differentiate CPQ and INTC discovery
-	rc = pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor_id);
-	if (rc || ((vendor_id != PCI_VENDOR_ID_COMPAQ) && (vendor_id != PCI_VENDOR_ID_INTEL))) {
-		err(msg_HPC_non_compaq_or_intel);
-		return -ENODEV;
-	}
-	dbg("Vendor ID: %x\n", vendor_id);
-
-	rc = pci_read_config_byte(pdev, PCI_REVISION_ID, &rev);
-	dbg("revision: %d\n", rev);
-	if (rc || ((vendor_id == PCI_VENDOR_ID_COMPAQ) && (!rev))) {
-		err(msg_HPC_rev_error);
-		return -ENODEV;
-	}
-
-	/* Check for the proper subsytem ID's
-	 * Intel uses a different SSID programming model than Compaq.  
-	 * For Intel, each SSID bit identifies a PHP capability.
-	 * Also Intel HPC's may have RID=0.
-	 */
-	if ((rev > 2) || (vendor_id == PCI_VENDOR_ID_INTEL)) {
-		// TODO: This code can be made to support non-Compaq or Intel subsystem IDs
-		rc = pci_read_config_word(pdev, PCI_SUBSYSTEM_VENDOR_ID, &subsystem_vid);
-		if (rc) {
-			err("%s : pci_read_config_word failed\n", __FUNCTION__);
-			return rc;
-		}
-		dbg("Subsystem Vendor ID: %x\n", subsystem_vid);
-		if ((subsystem_vid != PCI_VENDOR_ID_COMPAQ) && (subsystem_vid != PCI_VENDOR_ID_INTEL)) {
-			err(msg_HPC_non_compaq_or_intel);
-			return -ENODEV;
-		}
-
-		ctrl = (struct controller *) kmalloc(sizeof(struct controller), GFP_KERNEL);
-		if (!ctrl) {
-			err("%s : out of memory\n", __FUNCTION__);
-			return -ENOMEM;
-		}
-		memset(ctrl, 0, sizeof(struct controller));
-
-		rc = pci_read_config_word(pdev, PCI_SUBSYSTEM_ID, &subsystem_deviceid);
-		if (rc) {
-			err("%s : pci_read_config_word failed\n", __FUNCTION__);
-			goto err_free_ctrl;
-		}
-
-		info("Hot Plug Subsystem Device ID: %x\n", subsystem_deviceid);
-
-		/* Set Vendor ID, so it can be accessed later from other functions */
-		ctrl->vendor_id = vendor_id;
-
-		switch (subsystem_vid) {
-			case PCI_VENDOR_ID_COMPAQ:
-				if (rev >= 0x13) { /* CIOBX */
-					ctrl->push_flag = 1;
-					ctrl->slot_switch_type = 1;		// Switch is present
-					ctrl->push_button = 1;			// Pushbutton is present
-					ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
-					ctrl->defeature_PHP = 1;		// PHP is supported
-					ctrl->pcix_support = 1;			// PCI-X supported
-					ctrl->pcix_speed_capability = 1;
-					pci_read_config_byte(pdev, 0x41, &bus_cap);
-					if (bus_cap & 0x80) {
-						dbg("bus max supports 133MHz PCI-X\n");
-						ctrl->speed_capability = PCI_SPEED_133MHz_PCIX;
-						break;
-					}
-					if (bus_cap & 0x40) {
-						dbg("bus max supports 100MHz PCI-X\n");
-						ctrl->speed_capability = PCI_SPEED_100MHz_PCIX;
-						break;
-					}
-					if (bus_cap & 20) {
-						dbg("bus max supports 66MHz PCI-X\n");
-						ctrl->speed_capability = PCI_SPEED_66MHz_PCIX;
-						break;
-					}
-					if (bus_cap & 10) {
-						dbg("bus max supports 66MHz PCI\n");
-						ctrl->speed_capability = PCI_SPEED_66MHz;
-						break;
-					}
-
-					break;
-				}
-
-				switch (subsystem_deviceid) {
-					case PCI_SUB_HPC_ID:
-						/* Original 6500/7000 implementation */
-						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = PCI_SPEED_33MHz;
-						ctrl->push_button = 0;			// No pushbutton
-						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
-						ctrl->defeature_PHP = 1;		// PHP is supported
-						ctrl->pcix_support = 0;			// PCI-X not supported
-						ctrl->pcix_speed_capability = 0;	// N/A since PCI-X not supported
-						break;
-					case PCI_SUB_HPC_ID2:
-						/* First Pushbutton implementation */
-						ctrl->push_flag = 1;
-						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = PCI_SPEED_33MHz;
-						ctrl->push_button = 1;			// Pushbutton is present
-						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
-						ctrl->defeature_PHP = 1;		// PHP is supported
-						ctrl->pcix_support = 0;			// PCI-X not supported
-						ctrl->pcix_speed_capability = 0;	// N/A since PCI-X not supported
-						break;
-					case PCI_SUB_HPC_ID_INTC:
-						/* Third party (6500/7000) */
-						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = PCI_SPEED_33MHz;
-						ctrl->push_button = 0;			// No pushbutton
-						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
-						ctrl->defeature_PHP = 1;			// PHP is supported
-						ctrl->pcix_support = 0;			// PCI-X not supported
-						ctrl->pcix_speed_capability = 0;		// N/A since PCI-X not supported
-						break;
-					case PCI_SUB_HPC_ID3:
-						/* First 66 Mhz implementation */
-						ctrl->push_flag = 1;
-						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = PCI_SPEED_66MHz;
-						ctrl->push_button = 1;			// Pushbutton is present
-						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
-						ctrl->defeature_PHP = 1;		// PHP is supported
-						ctrl->pcix_support = 0;			// PCI-X not supported
-						ctrl->pcix_speed_capability = 0;	// N/A since PCI-X not supported
-						break;
-					case PCI_SUB_HPC_ID4:
-						/* First PCI-X implementation, 100MHz */
-						ctrl->push_flag = 1;
-						ctrl->slot_switch_type = 1;		// Switch is present
-						ctrl->speed_capability = PCI_SPEED_100MHz_PCIX;
-						ctrl->push_button = 1;			// Pushbutton is present
-						ctrl->pci_config_space = 1;		// Index/data access to working registers 0 = not supported, 1 = supported
-						ctrl->defeature_PHP = 1;		// PHP is supported
-						ctrl->pcix_support = 1;			// PCI-X supported
-						ctrl->pcix_speed_capability = 0;	
-						break;
-					default:
-						err(msg_HPC_not_supported);
-						rc = -ENODEV;
-						goto err_free_ctrl;
-				}
-				break;
-
-			case PCI_VENDOR_ID_INTEL:
-				/* Check for speed capability (0=33, 1=66) */
-				if (subsystem_deviceid & 0x0001) {
-					ctrl->speed_capability = PCI_SPEED_66MHz;
-				} else {
-					ctrl->speed_capability = PCI_SPEED_33MHz;
-				}
-
-				/* Check for push button */
-				if (subsystem_deviceid & 0x0002) {
-					/* no push button */
-					ctrl->push_button = 0;
-				} else {
-					/* push button supported */
-					ctrl->push_button = 1;
-				}
-
-				/* Check for slot switch type (0=mechanical, 1=not mechanical) */
-				if (subsystem_deviceid & 0x0004) {
-					/* no switch */
-					ctrl->slot_switch_type = 0;
-				} else {
-					/* switch */
-					ctrl->slot_switch_type = 1;
-				}
-
-				/* PHP Status (0=De-feature PHP, 1=Normal operation) */
-				if (subsystem_deviceid & 0x0008) {
-					ctrl->defeature_PHP = 1;	// PHP supported
-				} else {
-					ctrl->defeature_PHP = 0;	// PHP not supported
-				}
-
-				/* Alternate Base Address Register Interface (0=not supported, 1=supported) */
-				if (subsystem_deviceid & 0x0010) {
-					ctrl->alternate_base_address = 1;	// supported
-				} else {
-					ctrl->alternate_base_address = 0;	// not supported
-				}
-
-				/* PCI Config Space Index (0=not supported, 1=supported) */
-				if (subsystem_deviceid & 0x0020) {
-					ctrl->pci_config_space = 1;		// supported
-				} else {
-					ctrl->pci_config_space = 0;		// not supported
-				}
-
-				/* PCI-X support */
-				if (subsystem_deviceid & 0x0080) {
-					/* PCI-X capable */
-					ctrl->pcix_support = 1;
-					/* Frequency of operation in PCI-X mode */
-					if (subsystem_deviceid & 0x0040) {
-						/* 133MHz PCI-X if bit 7 is 1 */
-						ctrl->pcix_speed_capability = 1;
-					} else {
-						/* 100MHz PCI-X if bit 7 is 1 and bit 0 is 0, */
-						/* 66MHz PCI-X if bit 7 is 1 and bit 0 is 1 */
-						ctrl->pcix_speed_capability = 0;
-					}
-				} else {
-					/* Conventional PCI */
-					ctrl->pcix_support = 0;
-					ctrl->pcix_speed_capability = 0;
-				}
-				break;
-
-			default:
-				err(msg_HPC_not_supported);
-				rc = -ENODEV;
-				goto err_free_ctrl;
-		}
-
-	} else {
-		err(msg_HPC_not_supported);
-		return -ENODEV;
+	int first_device_num;	/* first PCI device number supported by tihs HPC */
+	int num_ctlr_slots;		/* number of slots supported by tihs HPC */
+	u16 ctlr_cap = 0;
+
+	ctrl = (struct controller *) kmalloc(sizeof(struct controller), GFP_KERNEL);
+	if (!ctrl) {
+		err("%s : out of memory\n", __FUNCTION__);
+		goto err_out_none;
+	}
+	memset(ctrl, 0, sizeof(struct controller));
+
+	dbg("DRV_thread pid = %d\n", current->pid);
+
+	rc = phphpc_init(ctrl, pdev,
+				handle_switch_change,
+				handle_presence_change,
+				handle_power_fault);
+	if (rc) {
+		err("%s: controller initialization failed\n", CPQHPC_MODULE_NAME);
+		goto err_out_free_ctrl;
 	}
-
-	// Tell the user that we found one.
-	info("Initializing the PCI hot plug controller residing on PCI bus %d\n", pdev->bus->number);
-
-	dbg ("Hotplug controller capabilities:\n");
-	dbg ("    speed_capability       %d\n", ctrl->speed_capability);
-	dbg ("    slot_switch_type       %s\n", ctrl->slot_switch_type == 0 ? "no switch" : "switch present");
-	dbg ("    defeature_PHP          %s\n", ctrl->defeature_PHP == 0 ? "PHP not supported" : "PHP supported");
-	dbg ("    alternate_base_address %s\n", ctrl->alternate_base_address == 0 ? "not supported" : "supported");
-	dbg ("    pci_config_space       %s\n", ctrl->pci_config_space == 0 ? "not supported" : "supported");
-	dbg ("    pcix_speed_capability  %s\n", ctrl->pcix_speed_capability == 0 ? "not supported" : "supported");
-	dbg ("    pcix_support           %s\n", ctrl->pcix_support == 0 ? "not supported" : "supported");
+	/* now phphpc_function()s - ctrl->hpc_ops->functions - are ready.  */
 
 	ctrl->pci_dev = pdev;
+
 	pci_set_drvdata(pdev, ctrl);
 
 	/* make our own copy of the pci bus structure, as we like tweaking it a lot */
@@ -1098,129 +478,89 @@
 	if (!ctrl->pci_bus) {
 		err("out of memory\n");
 		rc = -ENOMEM;
-		goto err_free_ctrl;
+		goto err_out_unmap_mmio_region;
 	}
 	memcpy (ctrl->pci_bus, pdev->bus, sizeof (*ctrl->pci_bus));
-
 	ctrl->bus = pdev->bus->number;
-	ctrl->rev = rev;
-	dbg("bus device function rev: %d %d %d %d\n", ctrl->bus,
-	     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), ctrl->rev);
-
-	init_MUTEX(&ctrl->crit_sect);
-	init_waitqueue_head(&ctrl->queue);
-
-	/* initialize our threads if they haven't already been started up */
-	rc = one_time_init();
-	if (rc) {
-		goto err_free_bus;
-	}
-	
-	dbg("pdev = %p\n", pdev);
-	dbg("pci resource start %lx\n", pci_resource_start(pdev, 0));
-	dbg("pci resource len %lx\n", pci_resource_len(pdev, 0));
-
-	if (!request_mem_region(pci_resource_start(pdev, 0),
-				pci_resource_len(pdev, 0), MY_NAME)) {
-		err("cannot reserve MMIO region\n");
-		rc = -ENOMEM;
-		goto err_free_bus;
-	}
 
-	ctrl->hpc_reg = ioremap(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
-	if (!ctrl->hpc_reg) {
-		err("cannot remap MMIO region %lx @ %lx\n", pci_resource_len(pdev, 0), pci_resource_start(pdev, 0));
-		rc = -ENODEV;
-		goto err_free_mem_region;
+	ctrl->device = PCI_SLOT(pdev->devfn);
+	ctrl->function = PCI_FUNC(pdev->devfn);
+	dbg("ctrl bus=0x%x, device=%x, function=%x, irq=%x\n", ctrl->bus, ctrl->device, ctrl->function, pdev->irq);
+
+	if (phphpc_get_ctrl_cap(ctrl, &ctlr_cap, &rev)) {
+		err("%s: get_ctrl_cap failed\n", CPQHPC_MODULE_NAME);
+		goto err_out_free_ctrl_bus;
 	}
 
-	// Check for 66Mhz operation
-	ctrl->speed = get_controller_speed(ctrl);
-
-
-	//**************************************************
-	//
-	//              Save configuration headers for this and
-	//              subordinate PCI buses
-	//
-	//**************************************************
+	ctrl->rev = rev;
+	ctrl->ctlrcap = ctlr_cap;
+	ctrl->push_flag = PUSH_BUTTON(ctrl->ctlrcap);
 
-	// find the physical slot number of the first hot plug slot
+	/**************************************************
+	 *
+	 *        Save configuration headers for this and
+	 *        subordinate PCI buses
+	 * 
+	 **************************************************/
 
-	// Get slot won't work for devices behind bridges, but
-	// in this case it will always be called for the "base"
-	// bus/dev/func of a slot.
-	// CS: this is leveraging the PCIIRQ routing code from the kernel (pci-pc.c: get_irq_routing_table)
-	rc = get_slot_mapping(ctrl->pci_bus, pdev->bus->number, (readb(ctrl->hpc_reg + SLOT_MASK) >> 4), &(ctrl->first_slot));
-	dbg("get_slot_mapping: first_slot = %d, returned = %d\n", ctrl->first_slot, rc);
+	rc = get_ctlr_slot_config(ctrl);
 	if (rc) {
 		err(msg_initialization_err, rc);
-		goto err_iounmap;
+		goto err_out_free_ctrl_bus;
 	}
+	ctrl->slot_device_offset = first_device_num = ctrl->first_device_num;
+	num_ctlr_slots = ctrl->num_ctlr_slots;
 
-	// Store PCI Config Space for all devices on this bus
-	rc = cpqhp_save_config(ctrl, ctrl->bus, readb(ctrl->hpc_reg + SLOT_MASK));
+	/* Store PCI Config Space for all devices on this bus */
+	rc = cpqhp_save_config(ctrl, ctrl->bus, num_ctlr_slots, first_device_num);
 	if (rc) {
 		err("%s: unable to save PCI configuration data, error %d\n", __FUNCTION__, rc);
-		goto err_iounmap;
+		goto err_out_free_ctrl_bus;
 	}
 
 	/*
 	 * Get IO, memory, and IRQ resources for new devices
 	 */
-	// The next line is required for cpqhp_find_available_resources
-	ctrl->interrupt = pdev->irq;
-
-	ctrl->cfgspc_irq = 0;
-	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &ctrl->cfgspc_irq);
-
-	rc = cpqhp_find_available_resources(ctrl, cpqhp_rom_start);
+	rc = phprm_find_available_resources(ctrl);
 	ctrl->add_support = !rc;
 	if (rc) {
-		dbg("cpqhp_find_available_resources = 0x%x\n", rc);
+		dbg("phprm_find_available_resources = %#x\n", rc);
 		err("unable to locate PCI configuration resources for hot plug add.\n");
-		goto err_iounmap;
+		goto err_out_free_ctrl_bus;
 	}
 
-	/*
-	 * Finish setting up the hot plug ctrl device
-	 */
-	ctrl->slot_device_offset = readb(ctrl->hpc_reg + SLOT_MASK) >> 4;
-	dbg("NumSlots %d \n", ctrl->slot_device_offset);
-
-	ctrl->next_event = 0;
-
 	/* Setup the slot information structures */
-	rc = ctrl_slot_setup(ctrl, smbios_start, smbios_table);
+	rc = ctrl_slot_setup(ctrl);
 	if (rc) {
 		err(msg_initialization_err, 6);
-		err("%s: unable to save PCI configuration data, error %d\n", __FUNCTION__, rc);
-		goto err_iounmap;
+		goto err_out_free_ctrl_slot;
 	}
-	
-	/* Mask all general input interrupts */
-	writel(0xFFFFFFFFL, ctrl->hpc_reg + INT_MASK);
+	/*
+	 * now phphpc_function()s - slot->hpc_ops->functions - are ready.
+	 */
 
-	/* set up the interrupt */
-	dbg("HPC interrupt = %d \n", ctrl->interrupt);
-	if (request_irq(ctrl->interrupt, cpqhp_ctrl_intr,
-			SA_SHIRQ, MY_NAME, ctrl)) {
-		err("Can't get irq %d for the hotplug pci controller\n", ctrl->interrupt);
-		rc = -ENODEV;
-		goto err_iounmap;
+	t_slot = cpqhp_find_slot(ctrl, first_device_num);
+	/* Check for operation bus speed */
+	rc = t_slot->hpc_ops->get_cur_bus_speed(t_slot, &ctrl->speed);
+	if (rc || ctrl->speed == PCI_SPEED_UNKNOWN) {
+		err(CPQHPC_MODULE_NAME ": Can't get current bus speed. Set to 33MHz PCI.\n");
+		ctrl->speed = PCI_SPEED_33MHz;
+	}
+
+	rc = t_slot->hpc_ops->get_max_bus_speed(t_slot, &ctrl->speed_capability);
+	if (rc || ctrl->speed_capability == PCI_SPEED_UNKNOWN) {
+		err(CPQHPC_MODULE_NAME ": Can't get max bus speed. Set to current bus speed.\n");
+		ctrl->speed_capability = ctrl->speed;
 	}
 
-	/* Enable Shift Out interrupt and clear it, also enable SERR on power fault */
-	temp_word = readw(ctrl->hpc_reg + MISC);
-	temp_word |= 0x4006;
-	writew(temp_word, ctrl->hpc_reg + MISC);
+	dbg("ctrl->bus = %d, ctrl->rev = %d, speed = %x ctlrcap = %x\n", ctrl->bus, ctrl->rev, ctrl->speed, ctrl->ctlrcap);
+	dbg(" button mode = %x, switch present = %x, push_flag = %x\n", PUSH_BUTTON(ctrl->ctlrcap), SLOT_SWITCH(ctrl->ctlrcap), ctrl->push_flag);
 
-	// Changed 05/05/97 to clear all interrupts at start
-	writel(0xFFFFFFFFL, ctrl->hpc_reg + INT_INPUT_CLEAR);
-
-	ctrl->ctrl_int_comp = readl(ctrl->hpc_reg + INT_INPUT_CLEAR);
+	/*
+	 *  Finish setting up the hot plug ctrl device
+	 */
 
-	writel(0x0L, ctrl->hpc_reg + INT_MASK);
+	ctrl->next_event = 0;
 
 	if (!cpqhp_ctrl_list) {
 		cpqhp_ctrl_list = ctrl;
@@ -1230,77 +570,60 @@
 		cpqhp_ctrl_list = ctrl;
 	}
 
-	// turn off empty slots here unless command line option "ON" set
-	// Wait for exclusive access to hardware
+	/* 
+	 *  turn off empty slots here unless command line option "ON" set
+	 *  Wait for exclusive access to hardware
+	 */
 	down(&ctrl->crit_sect);
 
-	num_of_slots = readb(ctrl->hpc_reg + SLOT_MASK) & 0x0F;
-
-	// find first device number for the ctrl
-	device = readb(ctrl->hpc_reg + SLOT_MASK) >> 4;
+	while (num_ctlr_slots) {
+		u8 getstatus;
 
-	while (num_of_slots) {
-		dbg("num_of_slots: %d\n", num_of_slots);
-		func = cpqhp_slot_find(ctrl->bus, device, 0);
+		dbg("num_of_slots: %d\n", num_ctlr_slots);
+		func = cpqhp_slot_find(ctrl->bus, first_device_num, 0);
 		if (!func)
 			break;
 
 		hp_slot = func->device - ctrl->slot_device_offset;
+		t_slot = cpqhp_find_slot(ctrl, hp_slot + ctrl->first_device_num);
+
 		dbg("hp_slot: %d\n", hp_slot);
 
-		// We have to save the presence info for these slots
-		temp_word = ctrl->ctrl_int_comp >> 16;
-		func->presence_save = (temp_word >> hp_slot) & 0x01;
-		func->presence_save |= (temp_word >> (hp_slot + 7)) & 0x02;
-
-		if (ctrl->ctrl_int_comp & (0x1L << hp_slot)) {
-			func->switch_save = 0;
-		} else {
-			func->switch_save = 0x10;
-		}
+		/* We have to save the presence info for these slots */
+		t_slot->hpc_ops->get_adapter_status(t_slot, &(func->presence_save));
+		t_slot->hpc_ops->get_latch_status(t_slot, &getstatus);
+		func->switch_save = !getstatus? 0x10:0;
 
 		if (!power_mode) {
 			if (!func->is_a_board) {
-				green_LED_off (ctrl, hp_slot);
-				slot_disable (ctrl, hp_slot);
+				/* turn off green LEDs and slot */
+				t_slot->hpc_ops->power_off_slot(t_slot);
+				t_slot->hpc_ops->green_led_off(t_slot);
+				t_slot->hpc_ops->update_hpc(t_slot);
 			}
 		}
 
-		device++;
-		num_of_slots--;
-	}
-
-	if (!power_mode) {
-		set_SOGO(ctrl);
-		// Wait for SOBS to be unset
-		wait_for_ctrl_irq (ctrl);
-	}
-
-	rc = init_SERR(ctrl);
-	if (rc) {
-		err("init_SERR failed\n");
-		up(&ctrl->crit_sect);
-		goto err_free_irq;
+		first_device_num++;
+		num_ctlr_slots--;
 	}
 
-	// Done with exclusive hardware access
+	/* Done with exclusive hardware access */
 	up(&ctrl->crit_sect);
 
-	cpqhp_create_ctrl_files (ctrl);
+	cpqhp_create_ctrl_files( ctrl);
 
 	return 0;
 
-err_free_irq:
-	free_irq(ctrl->interrupt, ctrl);
-err_iounmap:
-	iounmap(ctrl->hpc_reg);
-err_free_mem_region:
-	release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
-err_free_bus:
+err_out_free_ctrl_slot:
+	ctrl_slot_cleanup(ctrl);
+err_out_free_ctrl_bus:
 	kfree(ctrl->pci_bus);
-err_free_ctrl:
+err_out_unmap_mmio_region:
+	ctrl->hpc_ops->release_ctlr(ctrl);
+err_out_free_ctrl:
 	kfree(ctrl);
-	return rc;
+err_out_none:
+	return -ENODEV;
 }
 
 
@@ -1308,68 +631,22 @@
 {
 	int loop;
 	int retval = 0;
-	static int initialized = 0;
-
-	if (initialized)
-		return 0;
 
 	power_mode = 0;
 
-	retval = pci_print_IRQ_route();
-	if (retval)
-		goto error;
-
 	dbg("Initialize + Start the notification mechanism \n");
 
 	retval = cpqhp_event_start_thread();
-	if (retval)
-		goto error;
+	if (retval) {
+		dbg("cpqhp_event_start_thread() failed\n");
+		return retval;
+	}
 
 	dbg("Initialize slot lists\n");
 	for (loop = 0; loop < 256; loop++) {
 		cpqhp_slot_list[loop] = NULL;
 	}
 
-	// FIXME: We also need to hook the NMI handler eventually.
-	// this also needs to be worked with Christoph
-	// register_NMI_handler();
-
-	// Map rom address
-	cpqhp_rom_start = ioremap(ROM_PHY_ADDR, ROM_PHY_LEN);
-	if (!cpqhp_rom_start) {
-		err ("Could not ioremap memory region for ROM\n");
-		retval = -EIO;;
-		goto error;
-	}
-	
-	/* Now, map the int15 entry point if we are on compaq specific hardware */
-	compaq_nvram_init(cpqhp_rom_start);
-	
-	/* Map smbios table entry point structure */
-	smbios_table = detect_SMBIOS_pointer(cpqhp_rom_start, cpqhp_rom_start + ROM_PHY_LEN);
-	if (!smbios_table) {
-		err ("Could not find the SMBIOS pointer in memory\n");
-		retval = -EIO;;
-		goto error;
-	}
-
-	smbios_start = ioremap(readl(smbios_table + ST_ADDRESS), readw(smbios_table + ST_LENGTH));
-	if (!smbios_start) {
-		err ("Could not ioremap memory region taken from SMBIOS values\n");
-		retval = -EIO;;
-		goto error;
-	}
-
-	initialized = 1;
-
-	return retval;
-
-error:
-	if (cpqhp_rom_start)
-		iounmap(cpqhp_rom_start);
-	if (smbios_start)
-		iounmap(smbios_start);
-	
 	return retval;
 }
 
@@ -1379,28 +656,17 @@
 	struct pci_func *next;
 	struct pci_func *TempSlot;
 	int loop;
-	u32 rc;
 	struct controller *ctrl;
 	struct controller *tctrl;
 	struct pci_resource *res;
 	struct pci_resource *tres;
 
-	rc = compaq_nvram_store(cpqhp_rom_start);
-
 	ctrl = cpqhp_ctrl_list;
 
 	while (ctrl) {
-		if (ctrl->hpc_reg) {
-			u16 misc;
-			rc = read_slot_enable (ctrl);
-			
-			writeb(0, ctrl->hpc_reg + SLOT_SERR);
-			writel(0xFFFFFFC0L | ~rc, ctrl->hpc_reg + INT_MASK);
-			
-			misc = readw(ctrl->hpc_reg + MISC);
-			misc &= 0xFFFD;
-			writew(misc, ctrl->hpc_reg + MISC);
-		}
+
+		if (ctrl->hpc_ctlr_handle)
+			(ctrl->slot)->hpc_ops->enable_msl_interrupt(ctrl->slot);
 
 		ctrl_slot_cleanup(ctrl);
 
@@ -1434,8 +700,11 @@
 
 		kfree (ctrl->pci_bus);
 
+		ctrl->hpc_ops->release_ctlr(ctrl);
+
 		tctrl = ctrl;
 		ctrl = ctrl->next;
+
 		kfree(tctrl);
 	}
 
@@ -1476,31 +745,38 @@
 		}
 	}
 
-	// Stop the notification mechanism
+	/* Stop the notification mechanism */
 	cpqhp_event_stop_thread();
 
-	//unmap the rom address
-	if (cpqhp_rom_start)
-		iounmap(cpqhp_rom_start);
-	if (smbios_start)
-		iounmap(smbios_start);
 }
 
 
-
 static struct pci_device_id hpcd_pci_tbl[] __devinitdata = {
 	{
-	/* handle any PCI Hotplug controller */
 	.class =        ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
-	.class_mask =   ~0,
-	
-	/* no matter who makes it */
-	.vendor =       PCI_ANY_ID,
-	.device =       PCI_ANY_ID,
+	.vendor =       PCI_VENDOR_ID_COMPAQ,
+	.device =       PCI_HPC_ID,
 	.subvendor =    PCI_ANY_ID,
 	.subdevice =    PCI_ANY_ID,
-	
-	}, { /* end: all zeroes */ }
+	},
+
+	{
+	.class =        ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
+	.vendor =       PCI_VENDOR_ID_INTEL,
+	.device =       PCI_INTC_WXB_DID,
+	.subvendor =    PCI_ANY_ID,
+	.subdevice =    PCI_ANY_ID,
+	},
+
+	{
+	.class =        ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
+	.vendor =       PCI_VENDOR_ID_INTEL,
+	.device =       PCI_INTC_P64H2_DID,
+	.subvendor =    PCI_ANY_ID,
+	.subdevice =    PCI_ANY_ID,
+	},
+
+	{ /* end: all zeroes */ }
 };
 
 MODULE_DEVICE_TABLE(pci, hpcd_pci_tbl);
@@ -1508,7 +784,7 @@
 
 
 static struct pci_driver cpqhpc_driver = {
-	.name =		"pci_hotplug",
+	.name =		CPQHPC_MODULE_NAME,
 	.id_table =	hpcd_pci_tbl,
 	.probe =	cpqhpc_probe,
 	/* remove:	cpqhpc_remove_one, */
@@ -1518,26 +794,40 @@
 
 static int __init cpqhpc_init(void)
 {
-	int result;
+	int retval = 0;
 
-	cpqhp_debug = debug;
+	retval = one_time_init();
+	if (retval)
+		goto error_hpc_init;
 
-	result = pci_module_init(&cpqhpc_driver);
-	dbg("pci_module_init = %d\n", result);
-	if (result)
-		return result;
-	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
-	return 0;
-}
+	retval = phprm_init(PCI);
+	if (!retval) {
+		retval = pci_module_init(&cpqhpc_driver);
+		dbg("pci_module_init = %d\n", retval);
+		info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+	}
 
+error_hpc_init:
+	if (retval)
+		phprm_cleanup();
+	else
+		phprm_print_pirt();
+
+	return retval;
+}
 
 static void __exit cpqhpc_cleanup(void)
 {
+
 	dbg("unload_cpqphpd()\n");
 	unload_cpqphpd();
 
+	phprm_cleanup();
+
 	dbg("pci_unregister_driver\n");
 	pci_unregister_driver(&cpqhpc_driver);
+
+	info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
 }
 
 
diff -Nru a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
--- a/drivers/pci/hotplug/cpqphp.h	2003-07-02 13:53:50.000000000 -0700
+++ b/drivers/pci/hotplug/cpqphp.h	2003-07-07 09:32:21.000000000 -0700
@@ -28,212 +28,26 @@
 #ifndef _CPQPHP_H
 #define _CPQPHP_H
 
-#include "pci_hotplug.h"
-#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/version.h>
+#include <asm/semaphore.h>
 #include <asm/io.h>		/* for read? and write? functions */
-#include <linux/delay.h>	/* for delays */
+#include "pci_hotplug.h"
 
-#if !defined(CONFIG_HOTPLUG_PCI_COMPAQ_MODULE)
+#if !defined(CONFIG_HOTPLUG_PCI_COMPAQ_INTEL_MODULE)
 	#define MY_NAME	"cpqphp.o"
 #else
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (cpqhp_debug) printk(KERN_DEBUG "%s: " fmt , MY_NAME , ## arg); } while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
-
-
-
-struct smbios_system_slot {
-	u8 type;
-	u8 length;
-	u16 handle;
-	u8 name_string_num;
-	u8 slot_type;
-	u8 slot_width;
-	u8 slot_current_usage;
-	u8 slot_length;
-	u16 slot_number;
-	u8 properties1;
-	u8 properties2;
-} __attribute__ ((packed));
-
-/* offsets to the smbios generic type based on the above structure layout */
-enum smbios_system_slot_offsets {
-	SMBIOS_SLOT_GENERIC_TYPE =	offsetof(struct smbios_system_slot, type),
-	SMBIOS_SLOT_GENERIC_LENGTH =	offsetof(struct smbios_system_slot, length),
-	SMBIOS_SLOT_GENERIC_HANDLE =	offsetof(struct smbios_system_slot, handle),
-	SMBIOS_SLOT_NAME_STRING_NUM =	offsetof(struct smbios_system_slot, name_string_num),
-	SMBIOS_SLOT_TYPE =		offsetof(struct smbios_system_slot, slot_type),
-	SMBIOS_SLOT_WIDTH =		offsetof(struct smbios_system_slot, slot_width),
-	SMBIOS_SLOT_CURRENT_USAGE =	offsetof(struct smbios_system_slot, slot_current_usage),
-	SMBIOS_SLOT_LENGTH =		offsetof(struct smbios_system_slot, slot_length),
-	SMBIOS_SLOT_NUMBER =		offsetof(struct smbios_system_slot, slot_number),
-	SMBIOS_SLOT_PROPERTIES1 =	offsetof(struct smbios_system_slot, properties1),
-	SMBIOS_SLOT_PROPERTIES2 =	offsetof(struct smbios_system_slot, properties2),
-};
-
-struct smbios_generic {
-	u8 type;
-	u8 length;
-	u16 handle;
-} __attribute__ ((packed));
-
-/* offsets to the smbios generic type based on the above structure layout */
-enum smbios_generic_offsets {
-	SMBIOS_GENERIC_TYPE =	offsetof(struct smbios_generic, type),
-	SMBIOS_GENERIC_LENGTH =	offsetof(struct smbios_generic, length),
-	SMBIOS_GENERIC_HANDLE =	offsetof(struct smbios_generic, handle),
-};
-
-struct smbios_entry_point {
-	char anchor[4];
-	u8 ep_checksum;
-	u8 ep_length;
-	u8 major_version;
-	u8 minor_version;
-	u16 max_size_entry;
-	u8 ep_rev;
-	u8 reserved[5];
-	char int_anchor[5];
-	u8 int_checksum;
-	u16 st_length;
-	u32 st_address;
-	u16 number_of_entrys;
-	u8 bcd_rev;
-} __attribute__ ((packed));
-
-/* offsets to the smbios entry point based on the above structure layout */
-enum smbios_entry_point_offsets {
-	ANCHOR =		offsetof(struct smbios_entry_point, anchor[0]),
-	EP_CHECKSUM =		offsetof(struct smbios_entry_point, ep_checksum),
-	EP_LENGTH =		offsetof(struct smbios_entry_point, ep_length),
-	MAJOR_VERSION =		offsetof(struct smbios_entry_point, major_version),
-	MINOR_VERSION =		offsetof(struct smbios_entry_point, minor_version),
-	MAX_SIZE_ENTRY =	offsetof(struct smbios_entry_point, max_size_entry),
-	EP_REV =		offsetof(struct smbios_entry_point, ep_rev),
-	INT_ANCHOR =		offsetof(struct smbios_entry_point, int_anchor[0]),
-	INT_CHECKSUM =		offsetof(struct smbios_entry_point, int_checksum),
-	ST_LENGTH =		offsetof(struct smbios_entry_point, st_length),
-	ST_ADDRESS =		offsetof(struct smbios_entry_point, st_address),
-	NUMBER_OF_ENTRYS =	offsetof(struct smbios_entry_point, number_of_entrys),
-	BCD_REV =		offsetof(struct smbios_entry_point, bcd_rev),
-};
-
-struct ctrl_reg {			/* offset */
-	u8	slot_RST;		/* 0x00 */
-	u8	slot_enable;		/* 0x01 */
-	u16	misc;			/* 0x02 */
-	u32	led_control;		/* 0x04 */
-	u32	int_input_clear;	/* 0x08 */
-	u32	int_mask;		/* 0x0a */
-	u8	reserved0;		/* 0x10 */
-	u8	reserved1;		/* 0x11 */
-	u8	reserved2;		/* 0x12 */
-	u8	gen_output_AB;		/* 0x13 */
-	u32	non_int_input;		/* 0x14 */
-	u32	reserved3;		/* 0x18 */
-	u32	reserved4;		/* 0x1a */
-	u32	reserved5;		/* 0x20 */
-	u8	reserved6;		/* 0x24 */
-	u8	reserved7;		/* 0x25 */
-	u16	reserved8;		/* 0x26 */
-	u8	slot_mask;		/* 0x28 */
-	u8	reserved9;		/* 0x29 */
-	u8	reserved10;		/* 0x2a */
-	u8	reserved11;		/* 0x2b */
-	u8	slot_SERR;		/* 0x2c */
-	u8	slot_power;		/* 0x2d */
-	u8	reserved12;		/* 0x2e */
-	u8	reserved13;		/* 0x2f */
-	u8	next_curr_freq;		/* 0x30 */
-	u8	reset_freq_mode;	/* 0x31 */
-} __attribute__ ((packed));
-
-/* offsets to the controller registers based on the above structure layout */
-enum ctrl_offsets {
-	SLOT_RST = 		offsetof(struct ctrl_reg, slot_RST),
-	SLOT_ENABLE =		offsetof(struct ctrl_reg, slot_enable),
-	MISC =			offsetof(struct ctrl_reg, misc),
-	LED_CONTROL =		offsetof(struct ctrl_reg, led_control),
-	INT_INPUT_CLEAR =	offsetof(struct ctrl_reg, int_input_clear),
-	INT_MASK = 		offsetof(struct ctrl_reg, int_mask),
-	CTRL_RESERVED0 = 	offsetof(struct ctrl_reg, reserved0),
-	CTRL_RESERVED1 =	offsetof(struct ctrl_reg, reserved1),
-	CTRL_RESERVED2 =	offsetof(struct ctrl_reg, reserved1),
-	GEN_OUTPUT_AB = 	offsetof(struct ctrl_reg, gen_output_AB),
-	NON_INT_INPUT = 	offsetof(struct ctrl_reg, non_int_input),
-	CTRL_RESERVED3 =	offsetof(struct ctrl_reg, reserved3),
-	CTRL_RESERVED4 =	offsetof(struct ctrl_reg, reserved4),
-	CTRL_RESERVED5 =	offsetof(struct ctrl_reg, reserved5),
-	CTRL_RESERVED6 =	offsetof(struct ctrl_reg, reserved6),
-	CTRL_RESERVED7 =	offsetof(struct ctrl_reg, reserved7),
-	CTRL_RESERVED8 =	offsetof(struct ctrl_reg, reserved8),
-	SLOT_MASK = 		offsetof(struct ctrl_reg, slot_mask),
-	CTRL_RESERVED9 = 	offsetof(struct ctrl_reg, reserved9),
-	CTRL_RESERVED10 =	offsetof(struct ctrl_reg, reserved10),
-	CTRL_RESERVED11 =	offsetof(struct ctrl_reg, reserved11),
-	SLOT_SERR =		offsetof(struct ctrl_reg, slot_SERR),
-	SLOT_POWER =		offsetof(struct ctrl_reg, slot_power),
-	NEXT_CURR_FREQ =	offsetof(struct ctrl_reg, next_curr_freq),
-	RESET_FREQ_MODE =	offsetof(struct ctrl_reg, reset_freq_mode),
-};
-
-struct hrt {
-	char sig0;
-	char sig1;
-	char sig2;
-	char sig3;
-	u16 unused_IRQ;
-	u16 PCIIRQ;
-	u8 number_of_entries;
-	u8 revision;
-	u16 reserved1;
-	u32 reserved2;
-} __attribute__ ((packed));
-
-/* offsets to the hotplug resource table registers based on the above structure layout */
-enum hrt_offsets {
-	SIG0 =			offsetof(struct hrt, sig0),
-	SIG1 =			offsetof(struct hrt, sig1),
-	SIG2 =			offsetof(struct hrt, sig2),
-	SIG3 =			offsetof(struct hrt, sig3),
-	UNUSED_IRQ =		offsetof(struct hrt, unused_IRQ),
-	PCIIRQ =		offsetof(struct hrt, PCIIRQ),
-	NUMBER_OF_ENTRIES =	offsetof(struct hrt, number_of_entries),
-	REVISION =		offsetof(struct hrt, revision),
-	HRT_RESERVED1 =		offsetof(struct hrt, reserved1),
-	HRT_RESERVED2 =		offsetof(struct hrt, reserved2),
-};
+extern int cpqhp_debug;
 
-struct slot_rt {
-	u8 dev_func;
-	u8 primary_bus;
-	u8 secondary_bus;
-	u8 max_bus;
-	u16 io_base;
-	u16 io_length;
-	u16 mem_base;
-	u16 mem_length;
-	u16 pre_mem_base;
-	u16 pre_mem_length;
-} __attribute__ ((packed));
-
-/* offsets to the hotplug slot resource table registers based on the above structure layout */
-enum slot_rt_offsets {
-	DEV_FUNC =		offsetof(struct slot_rt, dev_func),
-	PRIMARY_BUS = 		offsetof(struct slot_rt, primary_bus),
-	SECONDARY_BUS = 	offsetof(struct slot_rt, secondary_bus),
-	MAX_BUS = 		offsetof(struct slot_rt, max_bus),
-	IO_BASE = 		offsetof(struct slot_rt, io_base),
-	IO_LENGTH = 		offsetof(struct slot_rt, io_length),
-	MEM_BASE = 		offsetof(struct slot_rt, mem_base),
-	MEM_LENGTH = 		offsetof(struct slot_rt, mem_length),
-	PRE_MEM_BASE = 		offsetof(struct slot_rt, pre_mem_base),
-	PRE_MEM_LENGTH = 	offsetof(struct slot_rt, pre_mem_length),
-};
+/*#define dbg(format, arg...) do { if (cpqhp_debug) printk(KERN_DEBUG "%s: " format, MY_NAME , ## arg); } while (0)*/
+#define dbg(format, arg...) do { if (cpqhp_debug) printk("%s: " format, MY_NAME , ## arg); } while (0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME , ## arg)
 
 struct pci_func {
 	struct pci_func *next;
@@ -263,7 +77,7 @@
 	struct slot *next;
 	u8 bus;
 	u8 device;
-	u8 number;
+	u32 number;
 	u8 is_a_board;
 	u8 configured;
 	u8 state;
@@ -274,6 +88,7 @@
 	struct timer_list task_event;
 	u8 hp_slot;
 	struct controller *ctrl;
+	struct hpc_ops *hpc_ops;
 	void *p_sm_slot;
 	struct hotplug_slot *hotplug_slot;
 };
@@ -291,9 +106,11 @@
 
 struct controller {
 	struct controller *next;
-	u32 ctrl_int_comp;
-	struct semaphore crit_sect;	/* critical section semaphore */
-	void *hpc_reg;			/* cookie for our pci controller location */
+	struct semaphore crit_sect;		/* critical section semaphore */
+	void * hpc_ctlr_handle;			/* HPC controller handle */
+	int first_device_num;			/* 1st PCI device num on ctlr */
+	int num_ctlr_slots;				/* Number of slots on ctlr */
+	int slot_num_inc;				/* 1 or -1 */
 	struct pci_resource *mem_head;
 	struct pci_resource *p_mem_head;
 	struct pci_resource *io_head;
@@ -302,29 +119,52 @@
 	struct pci_bus *pci_bus;
 	struct event_info event_queue[10];
 	struct slot *slot;
+	struct hpc_ops *hpc_ops;
+	wait_queue_head_t queue;		/* sleep & wake process */
 	u8 next_event;
-	u8 interrupt;
-	u8 cfgspc_irq;
-	u8 bus;				/* bus number for the pci hotplug controller */
+	u8 seg;
+	u8 bus;
+	u8 device;
+	u8 function;
 	u8 rev;
 	u8 slot_device_offset;
-	u8 first_slot;
 	u8 add_support;
-	u8 push_flag;
 	enum pci_bus_speed speed;
 	enum pci_bus_speed speed_capability;
-	u8 push_button;			/* 0 = no pushbutton, 1 = pushbutton present */
-	u8 slot_switch_type;		/* 0 = no switch, 1 = switch present */
-	u8 defeature_PHP;		/* 0 = PHP not supported, 1 = PHP supported */
-	u8 alternate_base_address;	/* 0 = not supported, 1 = supported */
-	u8 pci_config_space;		/* Index/data access to working registers 0 = not supported, 1 = supported */
-	u8 pcix_speed_capability;	/* PCI-X */
-	u8 pcix_support;		/* PCI-X */
+	u32 first_slot;		/* _SUN, First physical slot number */
+	u8 push_flag;
+	u16 ctlrcap;
 	u16 vendor_id;
-	struct work_struct int_task_event;
-	wait_queue_head_t queue;	/* sleep & wake process */
 };
 
+/* #defined for cpq ctlr/platform cap */
+#define SpeedCap        0x0001	/* Bit 0 Speed_capability: 0=33MHz, 1=66MHz	*/
+#define PushButton      0x0002	/* Bit 1 Push_button : 0=present, 1=none	*/
+#define SlotSwitch      0x0004	/* Bit 2 Slot_switch_type: 0=present, 1=none	*/
+#define DeFeaturePHP    0x0008	/* Bit 3 DeFeature PHP: 0=no PHP supported, 1=PHP	*/
+#define AltBaseAddr     0x0010	/* Bit 4 Alternate_base_address: 0=none , 1=supported	*/
+#define PCICfgSpace     0x0020	/* Bit 5 PCI_config_space:	*/
+				/*  Index/data access to working registers	*/
+				/*  0 = not supported, 1 = supported	*/
+#define PCIXSpeed       0x0040	/* Bit 6 PCIX_speed: */
+				/*  0 = 100Mhz PCI-X if Bit 7 is 1 and Bit 0 is 0	*/
+				/*       66MHz PCI_X if Bit 7 is 1 and Bit 0 is 1	*/
+				/*  1 = 133MHz PCI-X if Bit 7 is 1	*/
+#define PCIXSupport     0x0080	/* Bit 7 PCIX_support: 0=conventional PCI, 1=PCI-X	*/
+				/* Bit 8-15  Reserved	*/
+
+#define	SPEED_CAP_33MHZ(cap)	!(cap & SpeedCap)
+#define	SPEED_CAP_66MHZ(cap)	(cap & SpeedCap)
+#define	PUSH_BUTTON(cap)	!(cap & PushButton)
+#define	SLOT_SWITCH(cap)	!(cap & SlotSwitch)
+#define	PHP_SUPPORTED(cap)	(cap & DeFeaturePHP)
+#define	ALT_BASE_ADDR(cap)	(cap & AltBaseAddr)
+#define	PCI_CFG_SPACE(cap)	(cap & PCICfgSpace)
+#define	PCIX_SUPPORTED(cap)	(cap & PCIXSupport)
+#define	PCIX_SPEED_133MHZ(cap)	( PCIX_SUPPORTED(cap) && (cap & PCIXSpeed) )
+#define	PCIX_SPEED_100MHZ(cap)	( PCIX_SUPPORTED(cap) && !(cap & PCIXSpeed) && SPEED_CAP_33MHZ(cap) )
+#define	PCIX_SPEED_66MHZ(cap)	( PCIX_SUPPORTED(cap) && !(cap & PCIXSpeed) && SPEED_CAP_66MHZ(cap) )
+
 struct irq_mapping {
 	u8 barber_pole;
 	u8 valid_INT;
@@ -340,7 +180,7 @@
 };
 
 #define ROM_PHY_ADDR			0x0F0000
-#define ROM_PHY_LEN			0x00ffff
+#define ROM_PHY_LEN			0x00FFFF
 
 #define PCI_HPC_ID			0xA0F7
 #define PCI_SUB_HPC_ID			0xA2F7
@@ -349,13 +189,18 @@
 #define PCI_SUB_HPC_ID_INTC		0xA2FA
 #define PCI_SUB_HPC_ID4			0xA2FD
 
+/* Define Intel IDs */
+#define PCI_INTC_WXB_DID		0x123F
+#define PCI_INTC_P64H2_DID		0x1462
+#define PCI_INTC_P64H2_HUB_PCI	0x1460
+
 #define INT_BUTTON_IGNORE		0
 #define INT_PRESENCE_ON			1
 #define INT_PRESENCE_OFF		2
 #define INT_SWITCH_CLOSE		3
 #define INT_SWITCH_OPEN			4
 #define INT_POWER_FAULT			5
-#define INT_POWER_FAULT_CLEAR		6
+#define INT_POWER_FAULT_CLEAR	6
 #define INT_BUTTON_PRESS		7
 #define INT_BUTTON_RELEASE		8
 #define INT_BUTTON_CANCEL		9
@@ -389,10 +234,12 @@
 #define NO_ADAPTER_PRESENT		0x00000009
 #define NOT_ENOUGH_RESOURCES		0x0000000B
 #define DEVICE_TYPE_NOT_SUPPORTED	0x0000000C
+#define WRONG_BUS_FREQUENCY		0x0000000D
 #define POWER_FAILURE			0x0000000E
 
 #define REMOVE_NOT_SUPPORTED		0x00000003
 
+#define DISABLE_CARD			1
 
 /*
  * error Messages
@@ -400,8 +247,8 @@
 #define msg_initialization_err	"Initialization failure, error=%d\n"
 #define msg_HPC_rev_error	"Unsupported revision of the PCI hot plug controller found.\n"
 #define msg_HPC_non_compaq_or_intel	"The PCI hot plug controller is not supported by this driver.\n"
-#define msg_HPC_not_supported	"this system is not supported by this version of cpqphpd. Upgrade to a newer version of cpqphpd\n"
-#define msg_unable_to_save	"unable to store PCI hot plug add resource information. This system must be rebooted before adding any PCI devices.\n"
+#define msg_HPC_not_supported	"This system is not supported by this version of cpqphpd. Upgrade to a newer version of cpqphpd\n"
+#define msg_unable_to_save	"Unable to store PCI hot plug add resource information. This system must be rebooted before adding any PCI devices.\n"
 #define msg_button_on		"PCI slot #%d - powering on due to button press.\n"
 #define msg_button_off		"PCI slot #%d - powering off due to button press.\n"
 #define msg_button_cancel	"PCI slot #%d - action canceled due to button press.\n"
@@ -411,49 +258,43 @@
 /* sysfs functions for the hotplug controller info */
 extern void cpqhp_create_ctrl_files		(struct controller *ctrl);
 
+
 /* controller functions */
 extern void	cpqhp_pushbutton_thread		(unsigned long event_pointer);
-extern irqreturn_t cpqhp_ctrl_intr		(int IRQ, void *data, struct pt_regs *regs);
-extern int	cpqhp_find_available_resources	(struct controller *ctrl, void *rom_start);
+extern int	phprm_find_available_resources	(struct controller *ctrl);
 extern int	cpqhp_event_start_thread	(void);
 extern void	cpqhp_event_stop_thread		(void);
 extern struct pci_func *cpqhp_slot_create	(unsigned char busnumber);
 extern struct pci_func *cpqhp_slot_find		(unsigned char bus, unsigned char device, unsigned char index);
-extern int	cpqhp_process_SI		(struct controller *ctrl, struct pci_func *func);
-extern int	cpqhp_process_SS		(struct controller *ctrl, struct pci_func *func);
-extern int	cpqhp_hardware_test		(struct controller *ctrl, int test_num);
+extern int	cpqhp_process_SI		(struct slot *slot);
+extern int	cpqhp_process_SS		(struct slot *slot);
+
+extern u8	handle_switch_change		(unsigned int change, void *inst_id);
+extern u8	handle_presence_change		(unsigned int change, void *inst_id);
+extern u8	handle_power_fault		(unsigned int change, void *inst_id);
 
 /* resource functions */
 extern int	cpqhp_resource_sort_and_combine	(struct pci_resource **head);
 
 /* pci functions */
 extern int	cpqhp_set_irq			(u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num);
-extern int	cpqhp_get_bus_dev		(struct controller *ctrl, u8 *bus_num, u8 *dev_num, u8 slot);
-extern int	cpqhp_save_config		(struct controller *ctrl, int busnumber, int is_hot_plug);
-extern int	cpqhp_save_base_addr_length	(struct controller *ctrl, struct pci_func * func);
-extern int	cpqhp_save_used_resources	(struct controller *ctrl, struct pci_func * func);
-extern int	cpqhp_configure_board		(struct controller *ctrl, struct pci_func * func);
+extern int	cpqhp_get_bus_dev		(struct controller *ctrl, u8 *bus_num, u8 *dev_num, struct slot *slot);
+extern int	cpqhp_save_config	 	(struct controller *ctrl, int busnumber, int num_ctlr_slots, int first_device_num);
+extern int	cpqhp_save_used_resources	(struct controller *ctrl, struct pci_func * func, int flag);
 extern int	cpqhp_save_slot_config		(struct controller *ctrl, struct pci_func * new_slot);
-extern int	cpqhp_valid_replace		(struct controller *ctrl, struct pci_func * func);
 extern void	cpqhp_destroy_board_resources	(struct pci_func * func);
 extern int	cpqhp_return_board_resources	(struct pci_func * func, struct resource_lists * resources);
 extern void	cpqhp_destroy_resource_list	(struct resource_lists * resources);
 extern int	cpqhp_configure_device		(struct controller* ctrl, struct pci_func* func);
 extern int	cpqhp_unconfigure_device	(struct pci_func* func);
-extern struct slot *cpqhp_find_slot		(struct controller *ctrl, u8 device);
+
 
 /* Global variables */
-extern int cpqhp_debug;
 extern struct controller *cpqhp_ctrl_list;
 extern struct pci_func *cpqhp_slot_list[256];
 
-/* these can be gotten rid of, but for debugging they are purty */
-extern u8 cpqhp_nic_irq;
-extern u8 cpqhp_disk_irq;
-
 
-
-/* inline functions */
+/* Inline functions */
 
 
 /* Inline functions to check the sanity of a pointer that is passed to us */
@@ -487,426 +328,98 @@
 	if (slot_paranoia_check (slot, function))
                 return NULL;
 	return slot;
-}               
-
-/*
- * return_resource
- *
- * Puts node back in the resource list pointed to by head
- *
- */
-static inline void return_resource (struct pci_resource **head, struct pci_resource *node)
-{
-	if (!node || !head)
-		return;
-	node->next = *head;
-	*head = node;
 }
 
-static inline void set_SOGO (struct controller *ctrl)
+static inline struct slot *cpqhp_find_slot (struct controller *ctrl, u8 device)
 {
-	u16 misc;
-	
-	misc = readw(ctrl->hpc_reg + MISC);
-	misc = (misc | 0x0001) & 0xFFFB;
-	writew(misc, ctrl->hpc_reg + MISC);
-}
-
-
-static inline void amber_LED_on (struct controller *ctrl, u8 slot)
-{
-	u32 led_control;
-	
-	led_control = readl(ctrl->hpc_reg + LED_CONTROL);
-	led_control |= (0x01010000L << slot);
-	writel(led_control, ctrl->hpc_reg + LED_CONTROL);
-}
-
-
-static inline void amber_LED_off (struct controller *ctrl, u8 slot)
-{
-	u32 led_control;
-	
-	led_control = readl(ctrl->hpc_reg + LED_CONTROL);
-	led_control &= ~(0x01010000L << slot);
-	writel(led_control, ctrl->hpc_reg + LED_CONTROL);
-}
-
-
-static inline int read_amber_LED (struct controller *ctrl, u8 slot)
-{
-	u32 led_control;
-
-	led_control = readl(ctrl->hpc_reg + LED_CONTROL);
-	led_control &= (0x01010000L << slot);
-	
-	return led_control ? 1 : 0;
-}
-
-
-static inline void green_LED_on (struct controller *ctrl, u8 slot)
-{
-	u32 led_control;
-	
-	led_control = readl(ctrl->hpc_reg + LED_CONTROL);
-	led_control |= 0x0101L << slot;
-	writel(led_control, ctrl->hpc_reg + LED_CONTROL);
-}
-
-static inline void green_LED_off (struct controller *ctrl, u8 slot)
-{
-	u32 led_control;
-	
-	led_control = readl(ctrl->hpc_reg + LED_CONTROL);
-	led_control &= ~(0x0101L << slot);
-	writel(led_control, ctrl->hpc_reg + LED_CONTROL);
-}
-
-
-static inline void green_LED_blink (struct controller *ctrl, u8 slot)
-{
-	u32 led_control;
-	
-	led_control = readl(ctrl->hpc_reg + LED_CONTROL);
-	led_control &= ~(0x0101L << slot);
-	led_control |= (0x0001L << slot);
-	writel(led_control, ctrl->hpc_reg + LED_CONTROL);
-}
-
-
-static inline void slot_disable (struct controller *ctrl, u8 slot)
-{
-	u8 slot_enable;
-
-	slot_enable = readb(ctrl->hpc_reg + SLOT_ENABLE);
-	slot_enable &= ~(0x01 << slot);
-	writeb(slot_enable, ctrl->hpc_reg + SLOT_ENABLE);
-}
-
-
-static inline void slot_enable (struct controller *ctrl, u8 slot)
-{
-	u8 slot_enable;
-
-	slot_enable = readb(ctrl->hpc_reg + SLOT_ENABLE);
-	slot_enable |= (0x01 << slot);
-	writeb(slot_enable, ctrl->hpc_reg + SLOT_ENABLE);
-}
-
-
-static inline u8 is_slot_enabled (struct controller *ctrl, u8 slot)
-{
-	u8 slot_enable;
-
-	slot_enable = readb(ctrl->hpc_reg + SLOT_ENABLE);
-	slot_enable &= (0x01 << slot);
-	return slot_enable ? 1 : 0;
-}
+	struct slot *p_slot, *tmp_slot = NULL;
 
+	if (!ctrl)
+		return NULL;
 
-static inline u8 read_slot_enable (struct controller *ctrl)
-{
-	return readb(ctrl->hpc_reg + SLOT_ENABLE);
-}
-
+	p_slot = ctrl->slot;
 
-/*
- * get_controller_speed - find the current frequency/mode of controller.
- *
- * @ctrl: controller to get frequency/mode for.
- *
- * Returns controller speed.
- *
- */
-static inline u8 get_controller_speed (struct controller *ctrl)
-{
-	u8 curr_freq;
- 	u16 misc;
- 	
-	if (ctrl->pcix_support) {
-		curr_freq = readb(ctrl->hpc_reg + NEXT_CURR_FREQ);
-		if ((curr_freq & 0xB0) == 0xB0) 
-			return PCI_SPEED_133MHz_PCIX;
-		if ((curr_freq & 0xA0) == 0xA0)
-			return PCI_SPEED_100MHz_PCIX;
-		if ((curr_freq & 0x90) == 0x90)
-			return PCI_SPEED_66MHz_PCIX;
-		if (curr_freq & 0x10)
-			return PCI_SPEED_66MHz;
+	dbg("p_slot = %p\n", p_slot);
 
-		return PCI_SPEED_33MHz;
+	while (p_slot && (p_slot->device != device)) {
+		tmp_slot = p_slot;
+		p_slot = p_slot->next;
+		dbg("In while loop, p_slot = %p\n", p_slot);
 	}
-
- 	misc = readw(ctrl->hpc_reg + MISC);
- 	return (misc & 0x0800) ? PCI_SPEED_66MHz : PCI_SPEED_33MHz;
-}
- 
-
-/*
- * get_adapter_speed - find the max supported frequency/mode of adapter.
- *
- * @ctrl: hotplug controller.
- * @hp_slot: hotplug slot where adapter is installed.
- *
- * Returns adapter speed.
- *
- */
-static inline u8 get_adapter_speed (struct controller *ctrl, u8 hp_slot)
-{
-	u32 temp_dword = readl(ctrl->hpc_reg + NON_INT_INPUT);
-	dbg("slot: %d, PCIXCAP: %8x\n", hp_slot, temp_dword);
-	if (ctrl->pcix_support) {
-		if (temp_dword & (0x10000 << hp_slot))
-			return PCI_SPEED_133MHz_PCIX;
-		if (temp_dword & (0x100 << hp_slot))
-			return PCI_SPEED_66MHz_PCIX;
+	if (p_slot == NULL) {
+		err("ERROR: cpqhp_find_slot device=0x%x\n", device);
+		p_slot = tmp_slot;
 	}
 
-	if (temp_dword & (0x01 << hp_slot))
-		return PCI_SPEED_66MHz;
-
-	return PCI_SPEED_33MHz;
-}
-
-static inline void enable_slot_power (struct controller *ctrl, u8 slot)
-{
-	u8 slot_power;
-
-	slot_power = readb(ctrl->hpc_reg + SLOT_POWER);
-	slot_power |= (0x01 << slot);
-	writeb(slot_power, ctrl->hpc_reg + SLOT_POWER);
+	return (p_slot);
 }
 
-static inline void disable_slot_power (struct controller *ctrl, u8 slot)
-{
-	u8 slot_power;
-
-	slot_power = readb(ctrl->hpc_reg + SLOT_POWER);
-	slot_power &= ~(0x01 << slot);
-	writeb(slot_power, ctrl->hpc_reg + SLOT_POWER);
-}
-
-
-static inline int cpq_get_attention_status (struct controller *ctrl, struct slot *slot)
-{
-	u8 hp_slot;
-
-	if (slot == NULL)
-		return 1;
-
-	hp_slot = slot->device - ctrl->slot_device_offset;
-
-	return read_amber_LED (ctrl, hp_slot);
-}
-
-
-static inline int get_slot_enabled (struct controller *ctrl, struct slot *slot)
-{
-	u8 hp_slot;
-
-	if (slot == NULL)
-		return 1;
-
-	hp_slot = slot->device - ctrl->slot_device_offset;
-
-	return is_slot_enabled (ctrl, hp_slot);
-}
-
-
-static inline int cpq_get_latch_status (struct controller *ctrl, struct slot *slot)
+/* Puts node back in the resource list pointed to by head */
+static inline void return_resource(struct pci_resource **head, struct pci_resource *node)
 {
-	u32 status;
-	u8 hp_slot;
-
-	if (slot == NULL)
-		return 1;
-
-	hp_slot = slot->device - ctrl->slot_device_offset;
-	dbg("%s: slot->device = %d, ctrl->slot_device_offset = %d \n",
-	    __FUNCTION__, slot->device, ctrl->slot_device_offset);
-
-	status = (readl(ctrl->hpc_reg + INT_INPUT_CLEAR) & (0x01L << hp_slot));
-
-	return(status == 0) ? 1 : 0;
-}
-
-
-static inline int get_presence_status (struct controller *ctrl, struct slot *slot)
-{
-	int presence_save = 0;
-	u8 hp_slot;
-	u32 tempdword;
-
-	if (slot == NULL)
-		return 0;
-
-	hp_slot = slot->device - ctrl->slot_device_offset;
-
-	tempdword = readl(ctrl->hpc_reg + INT_INPUT_CLEAR);
-	presence_save = (int) ((((~tempdword) >> 23) | ((~tempdword) >> 15)) >> hp_slot) & 0x02;
-
-	return presence_save;
+	if (!node || !head)
+		return;
+	node->next = *head;
+	*head = node;
 }
 
 #define SLOT_NAME_SIZE 10
 
-static inline void make_slot_name (char *buffer, int buffer_size, struct slot *slot)
-{
-	snprintf (buffer, buffer_size, "%d", slot->number);
-}
-
-
-static inline int wait_for_ctrl_irq (struct controller *ctrl)
+static inline void make_slot_name(char *buffer, int buffer_size, struct slot *slot)
 {
-        DECLARE_WAITQUEUE(wait, current);
-	int retval = 0;
-
-	dbg("%s - start\n", __FUNCTION__);
-	add_wait_queue(&ctrl->queue, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	/* Sleep for up to 1 second to wait for the LED to change. */
-	schedule_timeout(1*HZ);
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&ctrl->queue, &wait);
-	if (signal_pending(current))
-		retval =  -EINTR;
-
-	dbg("%s - end\n", __FUNCTION__);
-	return retval;
+	snprintf(buffer, buffer_size, "%d", slot->number);
 }
 
-
-/**
- * set_controller_speed - set the frequency and/or mode of a specific
- * controller segment.
- *
- * @ctrl: controller to change frequency/mode for.
- * @adapter_speed: the speed of the adapter we want to match.
- * @hp_slot: the slot number where the adapter is installed.
- *
- * Returns 0 if we successfully change frequency and/or mode to match the
- * adapter speed.
- * 
+/*
+ * phphpc
  */
-static inline u8 set_controller_speed(struct controller *ctrl, u8 adapter_speed, u8 hp_slot)
-{
-	struct slot *slot;
-	u8 reg;
-	u8 slot_power = readb(ctrl->hpc_reg + SLOT_POWER);
-	u16 reg16;
-	u32 leds = readl(ctrl->hpc_reg + LED_CONTROL);
-	
-	if (ctrl->speed == adapter_speed)
-		return 0;
-	
-	/* We don't allow freq/mode changes if we find another adapter running
-	 * in another slot on this controller */
-	for(slot = ctrl->slot; slot; slot = slot->next) {
-		if (slot->device == (hp_slot + ctrl->slot_device_offset)) 
-			continue;
-		if (!slot->hotplug_slot && !slot->hotplug_slot->info) 
-			continue;
-		if (slot->hotplug_slot->info->adapter_status == 0) 
-			continue;
-		/* If another adapter is running on the same segment but at a
-		 * lower speed/mode, we allow the new adapter to function at
-		 * this rate if supported */
-		if (ctrl->speed < adapter_speed) 
-			return 0;
 
-		return 1;
-	}
-	
-	/* If the controller doesn't support freq/mode changes and the
-	 * controller is running at a higher mode, we bail */
-	if ((ctrl->speed > adapter_speed) && (!ctrl->pcix_speed_capability))
-		return 1;
-	
-	/* But we allow the adapter to run at a lower rate if possible */
-	if ((ctrl->speed < adapter_speed) && (!ctrl->pcix_speed_capability))
-		return 0;
-
-	/* We try to set the max speed supported by both the adapter and
-	 * controller */
-	if (ctrl->speed_capability < adapter_speed) {
-		if (ctrl->speed == ctrl->speed_capability)
-			return 0;
-		adapter_speed = ctrl->speed_capability;
-	}
-
-	writel(0x0L, ctrl->hpc_reg + LED_CONTROL);
-	writeb(0x00, ctrl->hpc_reg + SLOT_ENABLE);
-	
-	set_SOGO(ctrl); 
-	wait_for_ctrl_irq(ctrl);
-	
-	if (adapter_speed != PCI_SPEED_133MHz_PCIX)
-		reg = 0xF5;
-	else
-		reg = 0xF4;	
-	pci_write_config_byte(ctrl->pci_dev, 0x41, reg);
-	
-	reg16 = readw(ctrl->hpc_reg + NEXT_CURR_FREQ);
-	reg16 &= ~0x000F;
-	switch(adapter_speed) {
-		case(PCI_SPEED_133MHz_PCIX): 
-			reg = 0x75;
-			reg16 |= 0xB; 
-			break;
-		case(PCI_SPEED_100MHz_PCIX):
-			reg = 0x74;
-			reg16 |= 0xA;
-			break;
-		case(PCI_SPEED_66MHz_PCIX):
-			reg = 0x73;
-			reg16 |= 0x9;
-			break;
-		case(PCI_SPEED_66MHz):
-			reg = 0x73;
-			reg16 |= 0x1;
-			break;
-		default: /* 33MHz PCI 2.2 */
-			reg = 0x71;
-			break;
-			
-	}
-	reg16 |= 0xB << 12;
-	writew(reg16, ctrl->hpc_reg + NEXT_CURR_FREQ);
-	
-	mdelay(5); 
-	
-	/* Reenable interrupts */
-	writel(0, ctrl->hpc_reg + INT_MASK);
-
-	pci_write_config_byte(ctrl->pci_dev, 0x41, reg); 
-	
-	/* Restart state machine */
-	reg = ~0xF;
-	pci_read_config_byte(ctrl->pci_dev, 0x43, &reg);
-	pci_write_config_byte(ctrl->pci_dev, 0x43, reg);
-	
-	/* Only if mode change...*/
-	if (((ctrl->speed == PCI_SPEED_66MHz) && (adapter_speed == PCI_SPEED_66MHz_PCIX)) ||
-		((ctrl->speed == PCI_SPEED_66MHz_PCIX) && (adapter_speed == PCI_SPEED_66MHz))) 
-			set_SOGO(ctrl);
-	
-	wait_for_ctrl_irq(ctrl);
-	mdelay(1100);
-	
-	/* Restore LED/Slot state */
-	writel(leds, ctrl->hpc_reg + LED_CONTROL);
-	writeb(slot_power, ctrl->hpc_reg + SLOT_ENABLE);
-	
-	set_SOGO(ctrl);
-	wait_for_ctrl_irq(ctrl);
-
-	ctrl->speed = adapter_speed;
-	slot = cpqhp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
-
-	info("Successfully changed frequency/mode for adapter in slot %d\n", 
-			slot->number);
-	return 0;
-}
+enum php_ctlr_type {
+	PCI,
+	ISA,
+	ACPI
+};
+
+typedef u8(*php_intr_callback_t) (unsigned int change_id, void *instance_id);
+
+int phphpc_init( struct controller *ctrl, struct pci_dev *pdev,
+		php_intr_callback_t switch_change_callback,
+		php_intr_callback_t presence_change_callback,
+		php_intr_callback_t power_fault_callback);
+
+int phphpc_get_ctlr_slot_config( struct controller *ctrl,
+		int *num_ctlr_slots,
+		int *first_device_num,
+		int *physical_slot_num,
+		int *updown,
+		int *flags);
+
+int phphpc_get_ctrl_cap(struct controller *ctrl, u16 * pctlrcap, u8 * prev);
+
+struct hpc_ops {
+	int	(*power_on_slot )	(struct slot *slot);
+	int	(*power_off_slot )	(struct slot *slot);
+	int	(*get_power_status)	(struct slot *slot, u8 *status);
+	int	(*get_attention_status)	(struct slot *slot, u8 *status);
+	void	(*set_attention_status)	(struct slot *slot, u8 status);
+	int	(*get_latch_status)	(struct slot *slot, u8 *status);
+	int	(*get_adapter_status)	(struct slot *slot, u8 *status);
+
+	int	(*get_max_bus_speed)	(struct slot *slot, enum pci_bus_speed *speed);
+	int	(*get_cur_bus_speed)	(struct slot *slot, enum pci_bus_speed *speed);
+	int	(*set_controller_speed)	(struct slot *slot, enum pci_bus_speed speed);
+	int	(*get_adapter_speed)	(struct slot *slot, enum pci_bus_speed *speed);
+
+	u32	(*get_slot_capability)	(struct slot *slot);
+	int	(*query_power_fault)	(struct slot *slot);
+	void	(*green_led_on)	(struct slot * slot);
+	void	(*green_led_off)	(struct slot * slot);
+	void	(*green_led_blink)	(struct slot * slot);
+
+	void	(*enable_msl_interrupt)	(struct slot *slot);
+	void	(*update_hpc)		(struct slot *slot);
+	void	(*release_ctlr)		(struct controller *ctrl);
+};
 
-#endif
 
+#endif				/* _CPQPHP_H */

