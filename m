Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318938AbSIIWUw>; Mon, 9 Sep 2002 18:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318955AbSIIWUv>; Mon, 9 Sep 2002 18:20:51 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:14347 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318938AbSIIWSx>;
	Mon, 9 Sep 2002 18:18:53 -0400
Date: Mon, 9 Sep 2002 15:20:37 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.34
Message-ID: <20020909222037.GI7433@kroah.com>
References: <20020909221627.GE7433@kroah.com> <20020909221955.GG7433@kroah.com> <20020909222016.GH7433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909222016.GH7433@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.626   -> 1.627  
#	drivers/hotplug/ibmphp_pci.c	1.1     -> 1.2    
#	drivers/hotplug/ibmphp.h	1.2     -> 1.3    
#	drivers/hotplug/ibmphp_ebda.c	1.3     -> 1.4    
#	drivers/hotplug/ibmphp_hpc.c	1.5     -> 1.6    
#	drivers/hotplug/ibmphp_core.c	1.8     -> 1.9    
#	drivers/hotplug/ibmphp_res.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	zubarev@us.ibm.com	1.627
# [PATCH] IBM PCI Hotplug driver update
# 
# - fix polling logic
# - add ability to write [chassis/rxe]#slot# instead of just slot#
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp.h b/drivers/hotplug/ibmphp.h
--- a/drivers/hotplug/ibmphp.h	Mon Sep  9 15:09:46 2002
+++ b/drivers/hotplug/ibmphp.h	Mon Sep  9 15:09:46 2002
@@ -39,7 +39,8 @@
 #else
 	#define MY_NAME THIS_MODULE->name
 #endif
-#define debug(fmt, arg...) do { if (ibmphp_debug) printk(KERN_DEBUG "%s: " fmt , MY_NAME , ## arg); } while (0)
+#define debug(fmt, arg...) do { if (ibmphp_debug == 1) printk(KERN_DEBUG "%s: " fmt , MY_NAME , ## arg); } while (0)
+#define debug_pci(fmt, arg...) do { if (ibmphp_debug) printk(KERN_DEBUG "%s: " fmt , MY_NAME , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
@@ -121,6 +122,7 @@
 	u8 port1_port_connect;
 	u8 port2_node_connect;
 	u8 port2_port_connect;
+	u8 chassis_num;
 //	struct list_head scal_detail_list;
 };
 
@@ -139,9 +141,27 @@
 	u8 port1_port_connect;
 	u8 first_slot_num;
 	u8 status;
-//	struct list_head rio_detail_list;
+	u8 wpindex;
+	u8 chassis_num;
+	struct list_head rio_detail_list;
 };
 
+struct opt_rio {
+	u8 rio_type;
+	u8 chassis_num;
+	u8 first_slot_num;
+	u8 middle_num;
+	struct list_head opt_rio_list;
+};	
+
+struct opt_rio_lo {
+	u8 rio_type;
+	u8 chassis_num;
+	u8 first_slot_num;
+	u8 middle_num;
+	u8 pack_count;
+	struct list_head opt_rio_lo_list;
+};	
 
 /****************************************************************
 *  HPC DESCRIPTOR NODE                                          *
@@ -153,7 +173,6 @@
 	short phys_addr;
 //      struct list_head ebda_hpc_list;
 };
-
 /*****************************************************************
 *   IN HPC DATA STRUCTURE, THE ASSOCIATED SLOT AND BUS           *
 *   STRUCTURE                                                    *
@@ -195,6 +214,9 @@
 	u8 i2c_addr;
 };
 
+#define HPC_DEVICE_ID		0x0246
+#define HPC_SUBSYSTEM_ID	0x0247
+#define HPC_PCI_OFFSET		0x40
 /*************************************************************************
 *   RSTC DESCRIPTOR NODE                                                 *
 *************************************************************************/
@@ -215,8 +237,9 @@
 	u8 rsrc_type;
 	u8 bus_num;
 	u8 dev_fun;
-	ulong start_addr;
-	ulong end_addr;
+	u32 start_addr;
+	u32 end_addr;
+	u8 marked;	/* for NVRAM */
 	struct list_head ebda_pci_rsrc_list;
 };
 
@@ -248,7 +271,7 @@
 ***********************************************************/
 extern struct list_head ibmphp_ebda_pci_rsrc_head;
 extern struct list_head ibmphp_slot_head;
-
+extern struct list_head ibmphp_res_head;
 /***********************************************************
 * FUNCTION PROTOTYPES                                      *
 ***********************************************************/
@@ -263,6 +286,7 @@
 extern struct bus_info *ibmphp_find_same_bus_num (u32);
 extern int ibmphp_get_bus_index (u8);
 extern u16 ibmphp_get_total_controllers (void);
+extern int ibmphp_register_pci (void);
 
 /* passed parameters */
 #define MEM		0
@@ -739,6 +763,7 @@
 extern int ibmphp_update_slot_info (struct slot *);	/* This function is called from HPC, so we need it to not be be static */
 extern int ibmphp_configure_card (struct pci_func *, u8);
 extern int ibmphp_unconfigure_card (struct slot **, int);
+extern void ibmphp_increase_count (void);
 extern struct hotplug_slot_ops ibmphp_hotplug_slot_ops;
 
 static inline void long_delay (int delay)
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Mon Sep  9 15:09:46 2002
+++ b/drivers/hotplug/ibmphp_core.c	Mon Sep  9 15:09:46 2002
@@ -44,7 +44,7 @@
 #define get_ctrl_revision(sl, rev) ibmphp_hpc_readslot (sl, READ_REVLEVEL, rev)
 #define get_hpc_options(sl, opt) ibmphp_hpc_readslot (sl, READ_HPCOPTIONS, opt)
 
-#define DRIVER_VERSION	"0.3"
+#define DRIVER_VERSION	"0.6"
 #define DRIVER_DESC	"IBM Hot Plug PCI Controller Driver"
 
 int ibmphp_debug;
@@ -88,6 +88,8 @@
 	slot_cur->bus_on->current_speed = CURRENT_BUS_SPEED (slot_cur->busstatus);
 	if (READ_BUS_MODE (slot_cur->ctrl))
 		slot_cur->bus_on->current_bus_mode = CURRENT_BUS_MODE (slot_cur->busstatus);
+	else
+		slot_cur->bus_on->current_bus_mode = 0xFF;
 
 	debug ("busstatus = %x, bus_speed = %x, bus_mode = %x\n", slot_cur->busstatus, slot_cur->bus_on->current_speed, slot_cur->bus_on->current_bus_mode);
 	
@@ -108,11 +110,15 @@
 
 static int __init get_max_slots (void)
 {
+	struct slot * slot_cur;
 	struct list_head * tmp;
-	int slot_count = 0;
+	u8 slot_count = 0;
 
-	list_for_each (tmp, &ibmphp_slot_head) 
-		++slot_count;
+	list_for_each (tmp, &ibmphp_slot_head) {
+		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
+		/* sometimes the hot-pluggable slots start with 4 (not always from 1 */
+		slot_count = max (slot_count, slot_cur->number);
+	}
 	return slot_count;
 }
 
@@ -330,7 +336,7 @@
 			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
 			hpcrc = ibmphp_hpc_readslot (pslot, READ_SLOTSTATUS, &(myslot.status));
 			if (!hpcrc) {
-				*value = SLOT_POWER (myslot.status);
+				*value = SLOT_PWRGD (myslot.status);
 				rc = 0;
 			}
 		}
@@ -394,15 +400,22 @@
 		if (pslot) {
 			rc = 0;
 			mode = pslot->supported_bus_mode;
-			*value = pslot->supported_speed;
-			*value &= 0x0f;
-
-			if (mode == BUS_MODE_PCIX)
-				*value |= 0x80;
-			else if (mode == BUS_MODE_PCI)
-				*value |= 0x40;
-			else
-				*value |= 0x20;
+			*value = pslot->supported_speed; 
+			switch (*value) {
+			case BUS_SPEED_33:
+				break;
+			case BUS_SPEED_66:
+				if (mode == BUS_MODE_PCIX) 
+					*value += 0x01;
+				break;
+			case BUS_SPEED_100:
+			case BUS_SPEED_133:
+				*value = pslot->supported_speed + 0x01;
+				break;
+			default:
+*/				/* Note (will need to change): there would be soon 256, 512 also */
+/*				rc = -ENODEV;
+			}
 		}
 	} else
 		rc = -ENODEV;
@@ -429,14 +442,25 @@
 			if (!rc) {
 				mode = pslot->bus_on->current_bus_mode;
 				*value = pslot->bus_on->current_speed;
-				*value &= 0x0f;
-				
-				if (mode == BUS_MODE_PCIX)
-					*value |= 0x80;
-				else if (mode == BUS_MODE_PCI)
-					*value |= 0x40;
-				else
-					*value |= 0x20;	
+				switch (*value) {
+				case BUS_SPEED_33:
+					break;
+				case BUS_SPEED_66:
+					if (mode == BUS_MODE_PCIX) 
+						*value += 0x01;
+					else if (mode == BUS_MODE_PCI)
+						;
+					else
+						*value = PCI_SPEED_UNKNOWN;
+					break;
+				case BUS_SPEED_100:
+				case BUS_SPEED_133:
+					*value += 0x01;
+					break;
+				default:
+*/					/* Note of change: there would also be 256, 512 soon */
+/*					rc = -ENODEV;
+				}
 			}
 		}
 	} else
@@ -454,7 +478,7 @@
 	int hpcrc = 0;
 	struct slot myslot;
 
-	debug ("get_max_adapter_speed - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong)hotplug_slot, (ulong) value);
+	debug ("get_max_adapter_speed_1 - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong)hotplug_slot, (ulong) value);
 
 	if (flag)
 		ibmphp_lock_operations ();
@@ -485,17 +509,16 @@
 	if (flag)
 		ibmphp_unlock_operations ();
 
-	debug ("get_adapter_present - Exit rc[%d] hpcrc[%x] value[%x]\n", rc, hpcrc, *value);
+	debug ("get_max_adapter_speed_1 - Exit rc[%d] hpcrc[%x] value[%x]\n", rc, hpcrc, *value);
 	return rc;
 }
 
-static int get_card_bus_names (struct hotplug_slot *hotplug_slot, char * value)
+static int get_bus_name (struct hotplug_slot *hotplug_slot, char * value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot = NULL;
-	struct pci_dev * dev = NULL;
 
-	debug ("get_card_bus_names - Entry hotplug_slot[%lx] \n", (ulong)hotplug_slot);
+	debug ("get_bus_name - Entry hotplug_slot[%lx] \n", (ulong)hotplug_slot);
 
 	ibmphp_lock_operations ();
 
@@ -503,26 +526,17 @@
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
 			rc = 0;
-			if (pslot->func)
-				dev = pslot->func->dev;
-			else
-                		dev = pci_find_slot (pslot->bus, (pslot->device << 3) | (0x00 & 0x7));
-			if (dev) 
-				snprintf (value, 100, "Bus %d : %s", pslot->bus,dev->name);
-			else
-				snprintf (value, 100, "Bus %d", pslot->bus);
-			
-				
+			snprintf (value, 100, "Bus %x", pslot->bus);
 		}
 	} else
 		rc = -ENODEV;
 
 	ibmphp_unlock_operations ();
-	debug ("get_card_bus_names - Exit rc[%d] value[%x]\n", rc, *value);
+	debug ("get_bus_name - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
-
 */
+
 /*******************************************************************************
  * This routine will initialize the ops data structure used in the validate
  * function. It will also power off empty slots that are powered on since BIOS
@@ -531,12 +545,14 @@
 static int __init init_ops (void)
 {
 	struct slot *slot_cur;
+	struct list_head *tmp;
 	int retval;
-	int j;
 	int rc;
+	int j;
 
 	for (j = 0; j < MAX_OPS; j++) {
 		ops[j] = (int *) kmalloc ((max_slots + 1) * sizeof (int), GFP_KERNEL);
+		memset (ops[j], 0, (max_slots + 1) * sizeof (int));
 		if (!ops[j]) {
 			err ("out of system memory \n");
 			return -ENOMEM;
@@ -547,12 +563,13 @@
 	ops[REMOVE][0] = 0;
 	ops[DETAIL][0] = 0;
 
-	for (j = 1; j <= max_slots; j++) {
+	list_for_each (tmp, &ibmphp_slot_head) {
+		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
 
-		slot_cur = ibmphp_get_slot_from_physical_num (j);
+		if (!slot_cur)
+			return -ENODEV;
 
 		debug ("BEFORE GETTING SLOT STATUS, slot # %x\n", slot_cur->number);
-
 		if (slot_cur->ctrl->revision == 0xFF) 
 			if (get_ctrl_revision (slot_cur, &slot_cur->ctrl->revision))
 				return -1;
@@ -572,21 +589,21 @@
 		debug ("status = %x, ext_status = %x\n", slot_cur->status, slot_cur->ext_status);
 		debug ("SLOT_POWER = %x, SLOT_PRESENT = %x, SLOT_LATCH = %x\n", SLOT_POWER (slot_cur->status), SLOT_PRESENT (slot_cur->status), SLOT_LATCH (slot_cur->status));
 
-		if (!(SLOT_POWER (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status)))
+		if (!(SLOT_PWRGD (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status)))
 			/* No power, adapter, and latch closed */
-			ops[ADD][j] = 1;
+			ops[ADD][slot_cur->number] = 1;
 		else
-			ops[ADD][j] = 0;
+			ops[ADD][slot_cur->number] = 0;
 
-		ops[DETAIL][j] = 1;
+		ops[DETAIL][slot_cur->number] = 1;
 
-		if ((SLOT_POWER (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status)))
+		if ((SLOT_PWRGD (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status)))
 			/*Power,adapter,latch closed */
-			ops[REMOVE][j] = 1;
+			ops[REMOVE][slot_cur->number] = 1;
 		else
-			ops[REMOVE][j] = 0;
+			ops[REMOVE][slot_cur->number] = 0;
 
-		if ((SLOT_POWER (slot_cur->status)) && !(SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status))) {
+		if ((SLOT_PWRGD (slot_cur->status)) && !(SLOT_PRESENT (slot_cur->status)) && !(SLOT_LATCH (slot_cur->status))) {
 			debug ("BEFORE POWER OFF COMMAND\n");
 				rc = power_off (slot_cur);
 				if (rc)
@@ -624,7 +641,7 @@
 	if (retval)
 		return retval;
 
-	if (!(SLOT_POWER (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status))
+	if (!(SLOT_PWRGD (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status))
 	    && !(SLOT_LATCH (slot_cur->status)))
 		ops[ADD][number] = 1;
 	else
@@ -632,7 +649,7 @@
 
 	ops[DETAIL][number] = 1;
 
-	if ((SLOT_POWER (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status))
+	if ((SLOT_PWRGD (slot_cur->status)) && (SLOT_PRESENT (slot_cur->status))
 	    && !(SLOT_LATCH (slot_cur->status)))
 		ops[REMOVE][number] = 1;
 	else
@@ -678,7 +695,7 @@
 	}
         
 	snprintf (buffer, 10, "%d", slot_cur->number);
-	info->power_status = SLOT_POWER (slot_cur->status);
+	info->power_status = SLOT_PWRGD (slot_cur->status);
 	info->attention_status = SLOT_ATTN (slot_cur->status, slot_cur->ext_status);
 	info->latch_status = SLOT_LATCH (slot_cur->status);
         if (!SLOT_PRESENT (slot_cur->status)) {
@@ -688,8 +705,8 @@
                 info->adapter_status = 1;
 //		get_max_adapter_speed_1 (slot_cur->hotplug_slot, &info->max_adapter_speed_status, 0);
 	}
-/*
-	bus_speed = slot_cur->bus_on->current_speed;
+	/* !!!!!!!!!TO DO: THIS NEEDS TO CHANGE!!!!!!!!!!!!! */
+/*	bus_speed = slot_cur->bus_on->current_speed;
 	bus_speed &= 0x0f;
                         
 	if (slot_cur->bus_on->current_bus_mode == BUS_MODE_PCIX)
@@ -701,7 +718,7 @@
 
 	info->cur_bus_speed_status = bus_speed;
 	info->max_bus_speed_status = slot_cur->hotplug_slot->info->max_bus_speed_status;
-	// To do: card_bus_names 
+	// To do: bus_names 
 */	
 	rc = pci_hp_change_slot_info (buffer, info);
 	kfree (info);
@@ -775,8 +792,10 @@
 	struct list_head * tmp;
 	struct list_head * next;
 
-	list_for_each_safe (tmp, next, &ibmphp_slot_head) {
+	debug ("%s -- enter\n", __FUNCTION__);
 
+	list_for_each_safe (tmp, next, &ibmphp_slot_head) {
+	
 		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
 
 		pci_hp_deregister (slot_cur->hotplug_slot);
@@ -795,7 +814,9 @@
 		ibmphp_unconfigure_card (&slot_cur, -1);  /* we don't want to actually remove the resources, since free_resources will do just that */
 
 		kfree (slot_cur);
+		slot_cur = NULL;
 	}
+	debug ("%s -- exit\n", __FUNCTION__);
 }
 
 static int ibm_is_pci_dev_in_use (struct pci_dev *dev)
@@ -851,7 +872,7 @@
 	if (temp_func)
 		temp_func->dev = NULL;
 	else
-		err ("No pci_func representation for bus, devfn = %d, %x\n", dev->bus->number, dev->devfn);
+		debug ("No pci_func representation for bus, devfn = %d, %x\n", dev->bus->number, dev->devfn);
 
 	return 0;
 }
@@ -965,6 +986,34 @@
 	.visit_pci_dev =configure_visit_pci_dev,
 };
 
+
+/*
+ * The following function is to fix kernel bug regarding 
+ * getting bus entries, here we manually add those primary 
+ * bus entries to kernel bus structure whenever apply
+ */
+
+static u8 bus_structure_fixup (u8 busno)
+{
+	struct pci_bus bus_t;
+	struct pci_dev dev_t;
+	u16 l;
+
+	if (!find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
+		return 1;
+	bus_t.number = busno;
+	bus_t.ops = ibmphp_pci_root_ops;
+	dev_t.bus = &bus_t;
+	for (dev_t.devfn=0; dev_t.devfn<256; dev_t.devfn += 8) {
+		if (!pci_read_config_word (&dev_t, PCI_VENDOR_ID, &l) &&  l != 0x0000 && l != 0xffff) {
+			debug ("%s - Inside bus_struture_fixup() \n", __FUNCTION__);
+			pci_scan_bus (busno, ibmphp_pci_root_ops, NULL);
+			break;
+		}
+	}
+	return 0;
+}
+
 static int ibm_configure_device (struct pci_func *func)
 {
 	unsigned char bus;
@@ -972,6 +1021,7 @@
 	struct pci_bus *child;
 	struct pci_dev *temp;
 	int rc = 0;
+	int flag = 0;	/* this is to make sure we don't double scan the bus, for bridged devices primarily */
 
 	struct pci_dev_wrapped wrapped_dev;
 	struct pci_bus_wrapped wrapped_bus;
@@ -980,6 +1030,8 @@
 	memset (&wrapped_bus, 0, sizeof (struct pci_bus_wrapped));
 	memset (&dev0, 0, sizeof (struct pci_dev));
 
+	if (!(bus_structure_fixup (func->busno)))
+		flag = 1;
 	if (func->dev == NULL)
 		func->dev = pci_find_slot (func->busno, (func->device << 3) | (func->function & 0x7));
 
@@ -995,7 +1047,7 @@
 			return 0;
 		}
 	}
-	if (func->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+	if (!(flag) && (func->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
 		pci_read_config_byte (func->dev, PCI_SECONDARY_BUS, &bus);
 		child = (struct pci_bus *) pci_add_new_bus (func->dev->bus, (func->dev), bus);
 		pci_do_scan_bus (child);
@@ -1028,7 +1080,7 @@
 		rc = slot_update (&tmp_slot);
 		if (rc)
 			return 0;
-		if (SLOT_PRESENT (tmp_slot->status) && SLOT_POWER (tmp_slot->status))
+		if (SLOT_PRESENT (tmp_slot->status) && SLOT_PWRGD (tmp_slot->status))
 			return 0;
 		i++;
 	}
@@ -1046,6 +1098,9 @@
 	int rc;
 	u8 speed;
 	u8 cmd = 0x0;
+	const struct list_head *tmp;
+	struct pci_dev * dev;
+	int retval;
 
 	debug ("%s - entry slot # %d \n", __FUNCTION__, slot_cur->number);
 	if (SET_BUS_STATUS (slot_cur->ctrl) && is_bus_empty (slot_cur)) {
@@ -1091,6 +1146,14 @@
 				cmd = HPC_BUS_100PCIXMODE;
 				break;
 			case BUS_SPEED_133:
+				/* This is to take care of the bug in CIOBX chip*/
+				list_for_each (tmp, &pci_devices) {
+					dev = (struct pci_dev *) pci_dev_g (tmp);
+					if (dev) {
+						if ((dev->vendor == 0x1166) && (dev->device == 0x0101))
+							ibmphp_hpc_writeslot (slot_cur, HPC_BUS_100PCIXMODE);
+					}
+				}
 				cmd = HPC_BUS_133PCIXMODE;
 				break;
 			default:
@@ -1103,9 +1166,17 @@
 			return -ENODEV;
 		}
 		debug ("setting bus speed for slot %d, cmd %x\n", slot_cur->number, cmd);
-		ibmphp_hpc_writeslot (slot_cur, cmd);
+		retval = ibmphp_hpc_writeslot (slot_cur, cmd);
+		if (retval) {
+			err ("setting bus speed failed\n");
+			return retval;
+		}
+		if (CTLR_RESULT (slot_cur->ctrl->status)) {
+			err ("command not completed successfully in set_bus \n");
+			return -EIO;
+		}
 	}
-	/* This is for x400, once Brandon fixes the firmware, 
+	/* This is for x440, once Brandon fixes the firmware, 
 	will not need this delay */
 	long_delay (1 * HZ);
 	debug ("%s -Exit \n", __FUNCTION__);
@@ -1128,7 +1199,7 @@
 
 	for (i = slot_cur->bus_on->slot_min; i <= slot_cur->bus_on->slot_max; i++) {
 		tmp_slot = ibmphp_get_slot_from_physical_num (i);
-		if ((SLOT_POWER (tmp_slot->status)) && !(SLOT_CONNECT (tmp_slot->status))) 
+		if ((SLOT_PWRGD (tmp_slot->status)) && !(SLOT_CONNECT (tmp_slot->status))) 
 			count++;
 	}
 	get_cur_bus_info (&slot_cur);
@@ -1384,11 +1455,15 @@
 
 	debug ("DISABLING SLOT... \n"); 
 		
-	if (slot_cur == NULL) 
+	if (slot_cur == NULL) {
+		ibmphp_unlock_operations (); 
 		return -ENODEV;
+	}
 	
-	if (slot_cur->ctrl == NULL) 
+	if (slot_cur->ctrl == NULL) {
+		ibmphp_unlock_operations ();
 		return -ENODEV;
+	}
 	
 	flag = slot_cur->flag;	/* to see if got here from polling */
 	
@@ -1463,7 +1538,8 @@
 			return -EFAULT;
 		}
 
-		ibmphp_update_slot_info (slot_cur);
+		if (flag)
+			ibmphp_update_slot_info (slot_cur);
 		ibmphp_unlock_operations ();
 		return -EFAULT;
 	}
@@ -1503,10 +1579,10 @@
 	.get_attention_status =		get_attention_status,
 	.get_latch_status =		get_latch_status,
 	.get_adapter_status =		get_adapter_present,
-/*	get_max_bus_speed_status:	get_max_bus_speed,
+/*	.get_max_bus_speed_status =	get_max_bus_speed,
 	.get_max_adapter_speed_status =	get_max_adapter_speed,
 	.get_cur_bus_speed_status =	get_cur_bus_speed,
-	.get_card_bus_names_status =	get_card_bus_names,
+	.get_bus_name_status =		get_bus_name,
 */
 };
 
@@ -1559,7 +1635,7 @@
 	debug ("AFTER Resource & EBDA INITIALIZATIONS\n");
 
 	max_slots = get_max_slots ();
-
+	
 	if (init_ops ()) {
 		ibmphp_unload ();
 		return -ENODEV;
@@ -1570,11 +1646,9 @@
 		return -ENODEV;
 	}
 
-	/* lock ourselves into memory with a module count of -1 
-	 * so that no one can unload us. */
+	/* if no NVRAM module selected, lock ourselves into memory with a 
+	 * module count of -1 so that no one can unload us. */
 	MOD_DEC_USE_COUNT;
-
-
 	return 0;
 }
 
diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Mon Sep  9 15:09:46 2002
+++ b/drivers/hotplug/ibmphp_ebda.c	Mon Sep  9 15:09:46 2002
@@ -56,11 +56,17 @@
 /* Local variables */
 static struct ebda_hpc_list *hpc_list_ptr;
 static struct ebda_rsrc_list *rsrc_list_ptr;
-static struct rio_table_hdr *rio_table_ptr;
+static struct rio_table_hdr *rio_table_ptr = NULL;
 static LIST_HEAD (ebda_hpc_head);
 static LIST_HEAD (bus_info_head);
+static LIST_HEAD (rio_vg_head);
+static LIST_HEAD (rio_lo_head);
+static LIST_HEAD (opt_vg_head);
+static LIST_HEAD (opt_lo_head);
 static void *io_mem;
 
+char *chassis_str, *rxe_str, *str;
+
 /* Local functions */
 static int ebda_rsrc_controller (void);
 static int ebda_rsrc_rsrc (void);
@@ -173,18 +179,77 @@
 	}
 }
 
-static void print_ebda_pci_rsrc (void)
+static void print_lo_info (void)
+{
+	struct rio_detail *ptr;
+	struct list_head *ptr1;
+	debug ("print_lo_info ---- \n");	
+	list_for_each (ptr1, &rio_lo_head) {
+		ptr = list_entry (ptr1, struct rio_detail, rio_detail_list);
+		debug ("%s - rio_node_id = %x\n", __FUNCTION__, ptr->rio_node_id);
+		debug ("%s - rio_type = %x\n", __FUNCTION__, ptr->rio_type);
+		debug ("%s - owner_id = %x\n", __FUNCTION__, ptr->owner_id);
+		debug ("%s - first_slot_num = %x\n", __FUNCTION__, ptr->first_slot_num);
+		debug ("%s - wpindex = %x\n", __FUNCTION__, ptr->wpindex);
+		debug ("%s - chassis_num = %x\n", __FUNCTION__, ptr->chassis_num);
+
+	}
+}
+
+static void print_vg_info (void)
+{
+	struct rio_detail *ptr;
+	struct list_head *ptr1;
+	debug ("%s --- \n", __FUNCTION__);
+	list_for_each (ptr1, &rio_vg_head) {
+		ptr = list_entry (ptr1, struct rio_detail, rio_detail_list);
+		debug ("%s - rio_node_id = %x\n", __FUNCTION__, ptr->rio_node_id);
+		debug ("%s - rio_type = %x\n", __FUNCTION__, ptr->rio_type);
+		debug ("%s - owner_id = %x\n", __FUNCTION__, ptr->owner_id);
+		debug ("%s - first_slot_num = %x\n", __FUNCTION__, ptr->first_slot_num);
+		debug ("%s - wpindex = %x\n", __FUNCTION__, ptr->wpindex);
+		debug ("%s - chassis_num = %x\n", __FUNCTION__, ptr->chassis_num);
+
+	}
+}
+
+static void __init print_ebda_pci_rsrc (void)
 {
 	struct ebda_pci_rsrc *ptr;
 	struct list_head *ptr1;
 
 	list_for_each (ptr1, &ibmphp_ebda_pci_rsrc_head) {
 		ptr = list_entry (ptr1, struct ebda_pci_rsrc, ebda_pci_rsrc_list);
-		debug ("%s - rsrc type: %x bus#: %x dev_func: %x start addr: %lx end addr: %lx\n", 
+		debug ("%s - rsrc type: %x bus#: %x dev_func: %x start addr: %x end addr: %x\n", 
 			__FUNCTION__, ptr->rsrc_type ,ptr->bus_num, ptr->dev_fun,ptr->start_addr, ptr->end_addr);
 	}
 }
 
+static void __init print_ibm_slot (void)
+{
+	struct slot *ptr;
+	struct list_head *ptr1;
+
+	list_for_each (ptr1, &ibmphp_slot_head) {
+		ptr = list_entry (ptr1, struct slot, ibm_slot_list);
+		debug ("%s - slot_number: %x \n", __FUNCTION__, ptr->number); 
+	}
+}
+
+static void __init print_opt_vg (void)
+{
+	struct opt_rio *ptr;
+	struct list_head *ptr1;
+	debug ("%s --- \n", __FUNCTION__);
+	list_for_each (ptr1, &opt_vg_head) {
+		ptr = list_entry (ptr1, struct opt_rio, opt_rio_list);
+		debug ("%s - rio_type %x \n", __FUNCTION__, ptr->rio_type); 
+		debug ("%s - chassis_num: %x \n", __FUNCTION__, ptr->chassis_num); 
+		debug ("%s - first_slot_num: %x \n", __FUNCTION__, ptr->first_slot_num); 
+		debug ("%s - middle_num: %x \n", __FUNCTION__, ptr->middle_num); 
+	}
+}
+
 static void __init print_ebda_hpc (void)
 {
 	struct controller *hpc_ptr;
@@ -221,6 +286,7 @@
 			break;
 
 		case 2:
+		case 4:
 			debug ("%s - wpegbbar: %lx\n", __FUNCTION__, hpc_ptr->u.wpeg_ctlr.wpegbbar);
 			debug ("%s - i2c_addr: %x\n", __FUNCTION__, hpc_ptr->u.wpeg_ctlr.i2c_addr);
 			debug ("%s - irq: %x\n", __FUNCTION__, hpc_ptr->irq);
@@ -357,31 +423,380 @@
 
 			rio_complete = 1;
 		}
+	}
 
-		if (hs_complete && rio_complete) {
-			rc = ebda_rsrc_controller ();
-			if (rc) {
-				iounmap(io_mem);
-				return rc;
-			}
-			rc = ebda_rsrc_rsrc ();
-			if (rc) {
-				iounmap(io_mem);
-				return rc;
-			}
+	if (!hs_complete && !rio_complete) {
+		iounmap (io_mem);
+		return -ENODEV;
+	}
+
+	if (rio_table_ptr) {
+		if (rio_complete == 1 && rio_table_ptr->ver_num == 3) {
 			rc = ebda_rio_table ();
 			if (rc) {
-				iounmap(io_mem);
+				iounmap (io_mem);
 				return rc;
-			}	
-			iounmap (io_mem);
-			return 0;
+			}
 		}
 	}
+	rc = ebda_rsrc_controller ();
+	if (rc) {
+		iounmap (io_mem);
+		return rc;
+	}
+
+	rc = ebda_rsrc_rsrc ();
+	if (rc) {
+		iounmap (io_mem);
+		return rc;
+	}
+
 	iounmap (io_mem);
-	return -ENODEV;
+	return 0;
+}
+
+/*
+ * map info of scalability details and rio details from physical address
+ */
+static int __init ebda_rio_table (void)
+{
+	u16 offset;
+	u8 i;
+	struct rio_detail *rio_detail_ptr;
+
+	offset = rio_table_ptr->offset;
+	offset += 12 * rio_table_ptr->scal_count;
+
+	// we do concern about rio details
+	for (i = 0; i < rio_table_ptr->riodev_count; i++) {
+		rio_detail_ptr = kmalloc (sizeof (struct rio_detail), GFP_KERNEL);
+		if (!rio_detail_ptr)
+			return -ENOMEM;
+		memset (rio_detail_ptr, 0, sizeof (struct rio_detail));
+		rio_detail_ptr->rio_node_id = readb (io_mem + offset);
+		rio_detail_ptr->bbar = readl (io_mem + offset + 1);
+		rio_detail_ptr->rio_type = readb (io_mem + offset + 5);
+		rio_detail_ptr->owner_id = readb (io_mem + offset + 6);
+		rio_detail_ptr->port0_node_connect = readb (io_mem + offset + 7);
+		rio_detail_ptr->port0_port_connect = readb (io_mem + offset + 8);
+		rio_detail_ptr->port1_node_connect = readb (io_mem + offset + 9);
+		rio_detail_ptr->port1_port_connect = readb (io_mem + offset + 10);
+		rio_detail_ptr->first_slot_num = readb (io_mem + offset + 11);
+		rio_detail_ptr->status = readb (io_mem + offset + 12);
+		rio_detail_ptr->wpindex = readb (io_mem + offset + 13);
+		rio_detail_ptr->chassis_num = readb (io_mem + offset + 14);
+//		debug ("rio_node_id: %x\nbbar: %x\nrio_type: %x\nowner_id: %x\nport0_node: %x\nport0_port: %x\nport1_node: %x\nport1_port: %x\nfirst_slot_num: %x\nstatus: %x\n", rio_detail_ptr->rio_node_id, rio_detail_ptr->bbar, rio_detail_ptr->rio_type, rio_detail_ptr->owner_id, rio_detail_ptr->port0_node_connect, rio_detail_ptr->port0_port_connect, rio_detail_ptr->port1_node_connect, rio_detail_ptr->port1_port_connect, rio_detail_ptr->first_slot_num, rio_detail_ptr->status);
+		//create linked list of chassis
+		if (rio_detail_ptr->rio_type == 4 || rio_detail_ptr->rio_type == 5) 
+			list_add (&rio_detail_ptr->rio_detail_list, &rio_vg_head);
+		//create linked list of expansion box				
+		else if (rio_detail_ptr->rio_type == 6 || rio_detail_ptr->rio_type == 7) 
+			list_add (&rio_detail_ptr->rio_detail_list, &rio_lo_head);
+		else 
+			// not in my concern
+			kfree (rio_detail_ptr);
+		offset += 15;
+	}
+	print_lo_info ();
+	print_vg_info ();
+	return 0;
+}
+
+/*
+ * reorganizing linked list of chassis	 
+ */
+static struct opt_rio *search_opt_vg (u8 chassis_num)
+{
+	struct opt_rio *ptr;
+	struct list_head *ptr1;
+	list_for_each (ptr1, &opt_vg_head) {
+		ptr = list_entry (ptr1, struct opt_rio, opt_rio_list);
+		if (ptr->chassis_num == chassis_num)
+			return ptr;
+	}		
+	return NULL;
+}
+
+static int __init combine_wpg_for_chassis (void)
+{
+	struct opt_rio *opt_rio_ptr = NULL;
+	struct rio_detail *rio_detail_ptr = NULL;
+	struct list_head *list_head_ptr = NULL;
+	
+	list_for_each (list_head_ptr, &rio_vg_head) {
+		rio_detail_ptr = list_entry (list_head_ptr, struct rio_detail, rio_detail_list);
+		opt_rio_ptr = search_opt_vg (rio_detail_ptr->chassis_num);
+		if (!opt_rio_ptr) {
+			opt_rio_ptr = (struct opt_rio *) kmalloc (sizeof (struct opt_rio), GFP_KERNEL);
+			if (!opt_rio_ptr)
+				return -ENOMEM;
+			memset (opt_rio_ptr, 0, sizeof (struct opt_rio));
+			opt_rio_ptr->rio_type = rio_detail_ptr->rio_type;
+			opt_rio_ptr->chassis_num = rio_detail_ptr->chassis_num;
+			opt_rio_ptr->first_slot_num = rio_detail_ptr->first_slot_num;
+			opt_rio_ptr->middle_num = rio_detail_ptr->first_slot_num;
+			list_add (&opt_rio_ptr->opt_rio_list, &opt_vg_head);
+		} else {	
+			opt_rio_ptr->first_slot_num = min (opt_rio_ptr->first_slot_num, rio_detail_ptr->first_slot_num);
+			opt_rio_ptr->middle_num = max (opt_rio_ptr->middle_num, rio_detail_ptr->first_slot_num);
+		}	
+	}
+	print_opt_vg ();
+	return 0;	
+}	
+
+/*
+ * reorgnizing linked list of expansion box	 
+ */
+static struct opt_rio_lo *search_opt_lo (u8 chassis_num)
+{
+	struct opt_rio_lo *ptr;
+	struct list_head *ptr1;
+	list_for_each (ptr1, &opt_lo_head) {
+		ptr = list_entry (ptr1, struct opt_rio_lo, opt_rio_lo_list);
+		if (ptr->chassis_num == chassis_num)
+			return ptr;
+	}		
+	return NULL;
+}
+
+static int combine_wpg_for_expansion (void)
+{
+	struct opt_rio_lo *opt_rio_lo_ptr = NULL;
+	struct rio_detail *rio_detail_ptr = NULL;
+	struct list_head *list_head_ptr = NULL;
+	
+	list_for_each (list_head_ptr, &rio_lo_head) {
+		rio_detail_ptr = list_entry (list_head_ptr, struct rio_detail, rio_detail_list);
+		opt_rio_lo_ptr = search_opt_lo (rio_detail_ptr->chassis_num);
+		if (!opt_rio_lo_ptr) {
+			opt_rio_lo_ptr = (struct opt_rio_lo *) kmalloc (sizeof (struct opt_rio_lo), GFP_KERNEL);
+			if (!opt_rio_lo_ptr)
+				return -ENOMEM;
+			memset (opt_rio_lo_ptr, 0, sizeof (struct opt_rio_lo));
+			opt_rio_lo_ptr->rio_type = rio_detail_ptr->rio_type;
+			opt_rio_lo_ptr->chassis_num = rio_detail_ptr->chassis_num;
+			opt_rio_lo_ptr->first_slot_num = rio_detail_ptr->first_slot_num;
+			opt_rio_lo_ptr->middle_num = rio_detail_ptr->first_slot_num;
+			opt_rio_lo_ptr->pack_count = 1;
+			
+			list_add (&opt_rio_lo_ptr->opt_rio_lo_list, &opt_lo_head);
+		} else {	
+			opt_rio_lo_ptr->first_slot_num = min (opt_rio_lo_ptr->first_slot_num, rio_detail_ptr->first_slot_num);
+			opt_rio_lo_ptr->middle_num = max (opt_rio_lo_ptr->middle_num, rio_detail_ptr->first_slot_num);
+			opt_rio_lo_ptr->pack_count = 2;
+		}	
+	}
+	return 0;	
+}
+	
+static char *convert_2digits_to_char (int var)
+{
+	int bit;	
+	char *str1;
+
+	str = (char *) kmalloc (3, GFP_KERNEL);
+	memset (str, 0, 3);
+	str1 = (char *) kmalloc (2, GFP_KERNEL);
+	memset (str, 0, 3);
+	bit = (int)(var / 10);
+	switch (bit) {
+	case 0:
+		//one digit number
+		*str = (char)(var + 48);
+		return str;
+	default: 	
+		//2 digits number
+		*str1 = (char)(bit + 48);
+		strncpy (str, str1, 1);
+		memset (str1, 0, 3);
+		*str1 = (char)((var % 10) + 48);
+		strcat (str, str1);
+		return str;
+	}	
+	return NULL;	
+}
+
+/* Since we don't know the max slot number per each chassis, hence go
+ * through the list of all chassis to find out the range
+ * Arguments: slot_num, 1st slot number of the chassis we think we are on, 
+ * var (0 = chassis, 1 = expansion box) 
+ */
+static int first_slot_num (u8 slot_num, u8 first_slot, u8 var)
+{
+	struct opt_rio *opt_vg_ptr = NULL;
+	struct opt_rio_lo *opt_lo_ptr = NULL;
+	struct list_head *ptr = NULL;
+	int rc = 0;
+
+	if (!var) {
+		list_for_each (ptr, &opt_vg_head) {
+			opt_vg_ptr = list_entry (ptr, struct opt_rio, opt_rio_list);
+			if ((first_slot < opt_vg_ptr->first_slot_num) && (slot_num >= opt_vg_ptr->first_slot_num)) { 
+				rc = -ENODEV;
+				break;
+			}
+		}
+	} else {
+		list_for_each (ptr, &opt_lo_head) {
+			opt_lo_ptr = list_entry (ptr, struct opt_rio_lo, opt_rio_lo_list);
+			if ((first_slot < opt_lo_ptr->first_slot_num) && (slot_num >= opt_lo_ptr->first_slot_num)) {
+				rc = -ENODEV;
+				break;
+			}
+		}
+	}
+	return rc;
 }
 
+static struct opt_rio_lo * find_rxe_num (u8 slot_num)
+{
+	struct opt_rio_lo *opt_lo_ptr;
+	struct list_head *ptr;
+
+	list_for_each (ptr, &opt_lo_head) {
+		opt_lo_ptr = list_entry (ptr, struct opt_rio_lo, opt_rio_lo_list);
+		//check to see if this slot_num belongs to expansion box
+		if ((slot_num >= opt_lo_ptr->first_slot_num) && (!first_slot_num (slot_num, opt_lo_ptr->first_slot_num, 1))) 
+			return opt_lo_ptr;
+	}
+	return NULL;
+}
+
+static struct opt_rio * find_chassis_num (u8 slot_num)
+{
+	struct opt_rio *opt_vg_ptr;
+	struct list_head *ptr;
+
+	list_for_each (ptr, &opt_vg_head) {
+		opt_vg_ptr = list_entry (ptr, struct opt_rio, opt_rio_list);
+		//check to see if this slot_num belongs to chassis 
+		if ((slot_num >= opt_vg_ptr->first_slot_num) && (!first_slot_num (slot_num, opt_vg_ptr->first_slot_num, 0))) 
+			return opt_vg_ptr;
+	}
+	return NULL;
+}
+
+/* This routine will find out how many slots are in the chassis, so that
+ * the slot numbers for rxe100 would start from 1, and not from 7, or 6 etc
+ */
+static u8 calculate_first_slot (u8 slot_num)
+{
+	u8 first_slot = 1;
+	struct list_head * list;
+	struct slot * slot_cur;
+	
+	list_for_each (list, &ibmphp_slot_head) {
+		slot_cur = list_entry (list, struct slot, ibm_slot_list);
+		if (slot_cur->ctrl) {
+			if ((slot_cur->ctrl->ctlr_type != 4) && (slot_cur->ctrl->ending_slot_num > first_slot) && (slot_num > slot_cur->ctrl->ending_slot_num)) 
+				first_slot = slot_cur->ctrl->ending_slot_num;
+		}
+	}			
+	return first_slot + 1;
+
+}
+static char *create_file_name (struct slot * slot_cur)
+{
+	struct opt_rio *opt_vg_ptr = NULL;
+	struct opt_rio_lo *opt_lo_ptr = NULL;
+	char *ptr_chassis_num, *ptr_rxe_num, *ptr_slot_num;
+	int which = 0; /* rxe = 1, chassis = 0 */
+	u8 number = 1; /* either chassis or rxe # */
+	u8 first_slot = 1;
+	u8 slot_num;
+	u8 flag = 0;
+
+	if (!slot_cur) {
+		err ("Structure passed is empty \n");
+		return NULL;
+	}
+	
+	slot_num = slot_cur->number;
+
+	chassis_str = (char *) kmalloc (30, GFP_KERNEL);
+	memset (chassis_str, 0, 30);
+	rxe_str = (char *) kmalloc (30, GFP_KERNEL);
+	memset (rxe_str, 0, 30);
+	ptr_chassis_num = (char *) kmalloc (3, GFP_KERNEL);
+	memset (ptr_chassis_num, 0, 3);
+	ptr_rxe_num = (char *) kmalloc (3, GFP_KERNEL);
+	memset (ptr_rxe_num, 0, 3);
+	ptr_slot_num = (char *) kmalloc (3, GFP_KERNEL);
+	memset (ptr_slot_num, 0, 3);
+	
+	strcpy (chassis_str, "chassis");
+	strcpy (rxe_str, "rxe");
+	
+	if (rio_table_ptr) {
+		if (rio_table_ptr->ver_num == 3) {
+			opt_vg_ptr = find_chassis_num (slot_num);
+			opt_lo_ptr = find_rxe_num (slot_num);
+		}
+	}
+	if (opt_vg_ptr) {
+		if (opt_lo_ptr) {
+			if ((slot_num - opt_vg_ptr->first_slot_num) > (slot_num - opt_lo_ptr->first_slot_num)) {
+				number = opt_lo_ptr->chassis_num;
+				first_slot = opt_lo_ptr->first_slot_num;
+				which = 1; /* it is RXE */
+			} else {
+				first_slot = opt_vg_ptr->first_slot_num;
+				number = opt_vg_ptr->chassis_num;
+				which = 0;
+			}
+		} else {
+			first_slot = opt_vg_ptr->first_slot_num;
+			number = opt_vg_ptr->chassis_num;
+			which = 0;
+		}
+		++flag;
+	} else if (opt_lo_ptr) {
+		number = opt_lo_ptr->chassis_num;
+		first_slot = opt_lo_ptr->first_slot_num;
+		which = 1;
+		++flag;
+	} else if (rio_table_ptr) {
+		if (rio_table_ptr->ver_num == 3) {
+			/* if both NULL and we DO have correct RIO table in BIOS */
+			return NULL;
+		}
+	} 
+	if (!flag) {
+		if (slot_cur->ctrl->ctlr_type == 4) {
+			first_slot = calculate_first_slot (slot_num);
+			which = 1;
+		} else {
+			which = 0;
+		}
+	}
+
+	switch (which) {
+	case 0:
+		/* Chassis */
+		*ptr_chassis_num = (char)(number + 48);
+		strcat (chassis_str, ptr_chassis_num);
+		kfree (ptr_chassis_num);
+		strcat (chassis_str, "slot");
+		ptr_slot_num = convert_2digits_to_char (slot_num - first_slot + 1);
+		strcat (chassis_str, ptr_slot_num);
+		kfree (ptr_slot_num);
+		return chassis_str;
+		break;
+	case 1:
+		/* RXE */
+		*ptr_rxe_num = (char)(number + 48);
+		strcat (rxe_str, ptr_rxe_num);
+		kfree (ptr_rxe_num);
+		strcat (rxe_str, "slot");
+		ptr_slot_num = convert_2digits_to_char (slot_num - first_slot + 1);
+		strcat (rxe_str, ptr_slot_num);
+		kfree (ptr_slot_num);
+		return rxe_str;
+		break;
+	}	
+	return NULL;
+}
 
 /*
  * map info (ctlr-id, slot count, slot#.. bus count, bus#, ctlr type...) of
@@ -400,6 +815,8 @@
 	struct ebda_hpc_slot *slot_ptr;
 	struct bus_info *bus_info_ptr1, *bus_info_ptr2;
 	int rc;
+	struct slot *slot_cur;
+	struct list_head *list;
 
 	addr = hpc_list_ptr->phys_addr;
 	for (ctlr = 0; ctlr < hpc_list_ptr->num_ctlrs; ctlr++) {
@@ -510,7 +927,7 @@
 				hpc_ptr->u.pci_ctlr.bus = readb (io_mem + addr);
 				hpc_ptr->u.pci_ctlr.dev_fun = readb (io_mem + addr + 1);
 				hpc_ptr->irq = readb (io_mem + addr + 2);
-				addr += 3; 
+				addr += 3;
 				break;
 
 			case 0:
@@ -521,12 +938,6 @@
 				break;
 
 			case 2:
-				hpc_ptr->u.wpeg_ctlr.wpegbbar = readl (io_mem + addr);
-				hpc_ptr->u.wpeg_ctlr.i2c_addr = readb (io_mem + addr + 4);
-
-				hpc_ptr->irq = readb (io_mem + addr + 5);
-				addr += 6;
-				break;
 			case 4:
 				hpc_ptr->u.wpeg_ctlr.wpegbbar = readl (io_mem + addr);
 				hpc_ptr->u.wpeg_ctlr.i2c_addr = readb (io_mem + addr + 4);
@@ -537,12 +948,16 @@
 				iounmap (io_mem);
 				return -ENODEV;
 		}
+
 		/* following 3 line: Now our driver only supports I2c ctlrType */
 		if ((hpc_ptr->ctlr_type != 2) && (hpc_ptr->ctlr_type != 4)) {
 			err ("Please run this driver on ibm xseries440\n ");
 			return -ENODEV;
 		}
 
+		//reorganize chassis' linked list
+		combine_wpg_for_chassis ();
+		combine_wpg_for_expansion ();
 		hpc_ptr->revision = 0xff;
 		hpc_ptr->options = 0xff;
 		hpc_ptr->starting_slot_num = hpc_ptr->slots[0].slot_num;
@@ -566,7 +981,7 @@
 			}
 			memset (hp_slot_ptr->info, 0, sizeof (struct hotplug_slot_info));
 
-			hp_slot_ptr->name = (char *) kmalloc (10, GFP_KERNEL);
+			hp_slot_ptr->name = (char *) kmalloc (30, GFP_KERNEL);
 			if (!hp_slot_ptr->name) {
 				iounmap (io_mem);
 				kfree (hp_slot_ptr->info);
@@ -583,9 +998,7 @@
 				return -ENOMEM;
 			}
 
-
 			((struct slot *)hp_slot_ptr->private)->flag = TRUE;
-			snprintf (hp_slot_ptr->name, 10, "%d", hpc_ptr->slots[index].slot_num);
 
 			((struct slot *) hp_slot_ptr->private)->capabilities = hpc_ptr->slots[index].slot_cap;
 			if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_133_MAX) == EBDA_SLOT_133_MAX)
@@ -617,7 +1030,6 @@
 			((struct slot *) hp_slot_ptr->private)->number = hpc_ptr->slots[index].slot_num;
 			
 			((struct slot *) hp_slot_ptr->private)->hotplug_slot = hp_slot_ptr;
-
 			rc = ibmphp_hpc_fillhpslotinfo (hp_slot_ptr);
 			if (rc) {
 				iounmap (io_mem);
@@ -631,8 +1043,6 @@
 			}
 			hp_slot_ptr->ops = &ibmphp_hotplug_slot_ops;
 
-			pci_hp_register (hp_slot_ptr);
-
 			// end of registering ibm slot with hotplug core
 
 			list_add (& ((struct slot *)(hp_slot_ptr->private))->ibm_slot_list, &ibmphp_slot_head);
@@ -642,7 +1052,20 @@
 		list_add (&hpc_ptr->ebda_hpc_list, &ebda_hpc_head );
 
 	}			/* each hpc  */
+
+	list_for_each (list, &ibmphp_slot_head) {
+		slot_cur = list_entry (list, struct slot, ibm_slot_list);
+
+		snprintf (slot_cur->hotplug_slot->name, 30, "%s", create_file_name (slot_cur));
+		if (chassis_str) 
+			kfree (chassis_str);
+		if (rxe_str)
+			kfree (rxe_str);
+		pci_hp_register (slot_cur->hotplug_slot);
+	}
+
 	print_ebda_hpc ();
+	print_ibm_slot ();
 	return 0;
 }
 
@@ -682,7 +1105,7 @@
 			addr += 6;
 
 			debug ("rsrc from io type ----\n");
-			debug ("rsrc type: %x bus#: %x dev_func: %x start addr: %lx end addr: %lx\n",
+			debug ("rsrc type: %x bus#: %x dev_func: %x start addr: %x end addr: %x\n",
 				rsrc_ptr->rsrc_type, rsrc_ptr->bus_num, rsrc_ptr->dev_fun, rsrc_ptr->start_addr, rsrc_ptr->end_addr);
 
 			list_add (&rsrc_ptr->ebda_pci_rsrc_list, &ibmphp_ebda_pci_rsrc_head);
@@ -703,7 +1126,7 @@
 			addr += 10;
 
 			debug ("rsrc from mem or pfm ---\n");
-			debug ("rsrc type: %x bus#: %x dev_func: %x start addr: %lx end addr: %lx\n", 
+			debug ("rsrc type: %x bus#: %x dev_func: %x start addr: %x end addr: %x\n", 
 				rsrc_ptr->rsrc_type, rsrc_ptr->bus_num, rsrc_ptr->dev_fun, rsrc_ptr->start_addr, rsrc_ptr->end_addr);
 
 			list_add (&rsrc_ptr->ebda_pci_rsrc_list, &ibmphp_ebda_pci_rsrc_head);
@@ -715,56 +1138,6 @@
 	return 0;
 }
 
-/*
- * map info of scalability details and rio details from physical address
- */
-static int __init ebda_rio_table(void)
-{
-	u16 offset;
-	u8 i;
-	struct scal_detail *scal_detail_ptr;
-	struct rio_detail *rio_detail_ptr;
-
-	offset = rio_table_ptr->offset;
-	for (i = 0; i < rio_table_ptr->scal_count; i++) {
-		
-		scal_detail_ptr = kmalloc (sizeof (struct scal_detail), GFP_KERNEL );
-		if (!scal_detail_ptr )
-			return -ENOMEM;
-		memset (scal_detail_ptr, 0, sizeof (struct scal_detail) );
-		scal_detail_ptr->node_id = readb (io_mem + offset);
-		scal_detail_ptr->cbar = readl (io_mem+ offset + 1);
-		scal_detail_ptr->port0_node_connect = readb (io_mem + 5);
-		scal_detail_ptr->port0_port_connect = readb (io_mem + 6);
-		scal_detail_ptr->port1_node_connect = readb (io_mem + 7);
-		scal_detail_ptr->port1_port_connect = readb (io_mem + 8);
-		scal_detail_ptr->port2_node_connect = readb (io_mem + 9);
-		scal_detail_ptr->port2_port_connect = readb (io_mem + 10);
-		debug ("node_id: %x\ncbar: %x\nport0_node: %x\nport0_port: %x\nport1_node: %x\nport1_port: %x\nport2_node: %x\nport2_port: %x\n", scal_detail_ptr->node_id, scal_detail_ptr->cbar, scal_detail_ptr->port0_node_connect, scal_detail_ptr->port0_port_connect, scal_detail_ptr->port1_node_connect, scal_detail_ptr->port1_port_connect, scal_detail_ptr->port2_node_connect, scal_detail_ptr->port2_port_connect);
-//		list_add (&scal_detail_ptr->scal_detail_list, &scal_detail_head);
-		offset += 11;
-	}
-	for (i=0; i < rio_table_ptr->riodev_count; i++) {
-		rio_detail_ptr = kmalloc (sizeof (struct rio_detail), GFP_KERNEL );
-		if (!rio_detail_ptr )
-			return -ENOMEM;
-		memset (rio_detail_ptr, 0, sizeof (struct rio_detail) );
-		rio_detail_ptr->rio_node_id = readb (io_mem + offset );
-		rio_detail_ptr->bbar = readl (io_mem + offset + 1);
-		rio_detail_ptr->rio_type = readb (io_mem + offset + 5);
-		rio_detail_ptr->owner_id = readb (io_mem + offset + 6);
-		rio_detail_ptr->port0_node_connect = readb (io_mem + offset + 7);
-		rio_detail_ptr->port0_port_connect = readb (io_mem + offset + 8);
-		rio_detail_ptr->port1_node_connect = readb (io_mem + offset + 9);
-		rio_detail_ptr->port1_port_connect = readb (io_mem + offset + 10);
-		rio_detail_ptr->first_slot_num = readb (io_mem + offset + 11);
-		rio_detail_ptr->status = readb (io_mem + offset + 12);
-		debug ("rio_node_id: %x\nbbar: %x\nrio_type: %x\nowner_id: %x\nport0_node: %x\nport0_port: %x\nport1_node: %x\nport1_port: %x\nfirst_slot_num: %x\nstatus: %x\n", rio_detail_ptr->rio_node_id, rio_detail_ptr->bbar, rio_detail_ptr->rio_type, rio_detail_ptr->owner_id, rio_detail_ptr->port0_node_connect, rio_detail_ptr->port0_port_connect, rio_detail_ptr->port1_node_connect, rio_detail_ptr->port1_port_connect, rio_detail_ptr->first_slot_num, rio_detail_ptr->status);
-		offset += 13;
-	}
-	return 0;
-}
-
 u16 ibmphp_get_total_controllers (void)
 {
 	return hpc_list_ptr->num_ctlrs;
@@ -830,27 +1203,9 @@
 	}
 }
 
-/*
- * Calculate the total hot pluggable slots controlled by total hpcs
- */
-/*
-int ibmphp_get_total_hp_slots (void)
-{
-	struct ebda_hpc *ptr;
-	int slot_num = 0;
-
-	ptr = ebda_hpc_head;
-	while (ptr != NULL) {
-		slot_num += ptr->slot_count;
-		ptr = ptr->next;
-	}
-	return slot_num;
-}
-*/
-
 void ibmphp_free_ebda_hpc_queue (void)
 {
-	struct controller *controller;
+	struct controller *controller = NULL;
 	struct list_head *list;
 	struct list_head *next;
 
@@ -872,4 +1227,3 @@
 		resource = NULL;
 	}
 }
-
diff -Nru a/drivers/hotplug/ibmphp_hpc.c b/drivers/hotplug/ibmphp_hpc.c
--- a/drivers/hotplug/ibmphp_hpc.c	Mon Sep  9 15:09:46 2002
+++ b/drivers/hotplug/ibmphp_hpc.c	Mon Sep  9 15:09:46 2002
@@ -107,8 +107,8 @@
 //----------------------------------------------------------------------------
 // local function prototypes
 //----------------------------------------------------------------------------
-static u8 ctrl_read (struct controller *, void *, u8);
-static u8 ctrl_write (struct controller *, void *, u8, u8);
+static u8 i2c_ctrl_read (struct controller *, void *, u8);
+static u8 i2c_ctrl_write (struct controller *, void *, u8, u8);
 static u8 hpc_writecmdtoindex (u8, u8);
 static u8 hpc_readcmdtoindex (u8, u8);
 static void get_hpc_access (void);
@@ -142,12 +142,12 @@
 }
 
 /*----------------------------------------------------------------------
-* Name:    ctrl_read
+* Name:    i2c_ctrl_read
 *
 * Action:  read from HPC over I2C
 *
 *---------------------------------------------------------------------*/
-static u8 ctrl_read (struct controller *ctlr_ptr, void *WPGBbar, u8 index)
+static u8 i2c_ctrl_read (struct controller *ctlr_ptr, void *WPGBbar, u8 index)
 {
 	u8 status;
 	int i;
@@ -249,13 +249,13 @@
 }
 
 /*----------------------------------------------------------------------
-* Name:    ctrl_write
+* Name:    i2c_ctrl_write
 *
 * Action:  write to HPC over I2C
 *
 * Return   0 or error codes
 *---------------------------------------------------------------------*/
-static u8 ctrl_write (struct controller *ctlr_ptr, void *WPGBbar, u8 index, u8 cmd)
+static u8 i2c_ctrl_write (struct controller *ctlr_ptr, void *WPGBbar, u8 index, u8 cmd)
 {
 	u8 rc;
 	void *wpg_addr;		// base addr + offset
@@ -351,6 +351,33 @@
 	return (rc);
 }
 
+static u8 ctrl_read (struct controller *ctlr, void *base, u8 offset)
+{
+	u8 rc;
+	switch (ctlr->ctlr_type) {
+	case 2:
+	case 4:
+		rc = i2c_ctrl_read (ctlr, base, offset);
+		break;
+	default:
+		return -ENODEV;
+	}
+	return rc;
+}
+
+static u8 ctrl_write (struct controller *ctlr, void *base, u8 offset, u8 data)
+{
+	u8 rc = 0;
+	switch (ctlr->ctlr_type) {
+	case 2:
+	case 4:
+		rc = i2c_ctrl_write(ctlr, base, offset, data);
+		break;
+	default:
+		return -ENODEV;
+	}
+	return rc;
+}
 /*----------------------------------------------------------------------
 * Name:    hpc_writecmdtoindex()
 *
@@ -449,7 +476,7 @@
 *---------------------------------------------------------------------*/
 int ibmphp_hpc_readslot (struct slot * pslot, u8 cmd, u8 * pstatus)
 {
-	void *wpg_bbar;
+	void *wpg_bbar = NULL;
 	struct controller *ctlr_ptr;
 	struct list_head *pslotlist;
 	u8 index, status;
@@ -491,7 +518,8 @@
 	//--------------------------------------------------------------------
 	// map physical address to logical address
 	//--------------------------------------------------------------------
-	wpg_bbar = ioremap (ctlr_ptr->u.wpeg_ctlr.wpegbbar, WPG_I2C_IOREMAP_SIZE);
+	if ((ctlr_ptr->ctlr_type == 2) || (ctlr_ptr->ctlr_type == 4))
+		wpg_bbar = ioremap (ctlr_ptr->u.wpeg_ctlr.wpegbbar, WPG_I2C_IOREMAP_SIZE);
 
 	//--------------------------------------------------------------------
 	// check controller status before reading
@@ -569,7 +597,11 @@
 	//--------------------------------------------------------------------
 	// cleanup
 	//--------------------------------------------------------------------
-	iounmap (wpg_bbar);	// remove physical to logical address mapping
+	
+	// remove physical to logical address mapping
+	if ((ctlr_ptr->ctlr_type == 2) || (ctlr_ptr->ctlr_type == 4))
+		iounmap (wpg_bbar);	
+	
 	free_hpc_access ();
 
 	debug_polling ("%s - Exit rc[%d]\n", __FUNCTION__, rc);
@@ -583,7 +615,7 @@
 *---------------------------------------------------------------------*/
 int ibmphp_hpc_writeslot (struct slot * pslot, u8 cmd)
 {
-	void *wpg_bbar;
+	void *wpg_bbar = NULL;
 	struct controller *ctlr_ptr;
 	u8 index, status;
 	int busindex;
@@ -626,12 +658,13 @@
 	//--------------------------------------------------------------------
 	// map physical address to logical address
 	//--------------------------------------------------------------------
-	wpg_bbar = ioremap (ctlr_ptr->u.wpeg_ctlr.wpegbbar, WPG_I2C_IOREMAP_SIZE);
+	if ((ctlr_ptr->ctlr_type == 2) || (ctlr_ptr->ctlr_type == 4)) {
+		wpg_bbar = ioremap (ctlr_ptr->u.wpeg_ctlr.wpegbbar, WPG_I2C_IOREMAP_SIZE);
 
-	debug ("%s - ctlr id[%x] physical[%lx] logical[%lx] i2c[%x]\n", __FUNCTION__,
+		debug ("%s - ctlr id[%x] physical[%lx] logical[%lx] i2c[%x]\n", __FUNCTION__,
 		ctlr_ptr->ctlr_id, (ulong) (ctlr_ptr->u.wpeg_ctlr.wpegbbar), (ulong) wpg_bbar,
 		ctlr_ptr->u.wpeg_ctlr.i2c_addr);
-
+	}
 	//--------------------------------------------------------------------
 	// check controller status before writing
 	//--------------------------------------------------------------------
@@ -668,7 +701,10 @@
 		ctlr_ptr->status = status;
 	}
 	// cleanup
-	iounmap (wpg_bbar);	// remove physical to logical address mapping
+
+	// remove physical to logical address mapping
+	if ((ctlr_ptr->ctlr_type == 2) || (ctlr_ptr->ctlr_type == 4))
+		iounmap (wpg_bbar);	
 	free_hpc_access ();
 
 	debug_polling ("%s - Exit rc[%d]\n", __FUNCTION__, rc);
@@ -701,6 +737,7 @@
 void ibmphp_lock_operations (void)
 {
 	down (&semOperations);
+	to_debug = TRUE;
 }
 
 /*----------------------------------------------------------------------
@@ -710,6 +747,7 @@
 {
 	debug ("%s - Entry\n", __FUNCTION__);
 	up (&semOperations);
+	to_debug = FALSE;
 	debug ("%s - Exit\n", __FUNCTION__);
 }
 
@@ -734,82 +772,86 @@
 	debug ("%s - Entry\n", __FUNCTION__);
 
 	while (!ibmphp_shutdown) {
+		if (ibmphp_shutdown) 
+			break;
+		
 		/* try to get the lock to do some kind of harware access */
 		down (&semOperations);
 
 		switch (poll_state) {
-			case POLL_LATCH_REGISTER:
-				oldlatchlow = curlatchlow;
-				ctrl_count = 0x00;
-				list_for_each (pslotlist, &ibmphp_slot_head) {
-					if (ctrl_count >= ibmphp_get_total_controllers())
-						break;
-					pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
-					if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
-						ctrl_count++;
-						if (READ_SLOT_LATCH (pslot->ctrl)) {
-							rc = ibmphp_hpc_readslot (pslot,
-										  READ_SLOTLATCHLOWREG,
-										  &curlatchlow);
-							if (oldlatchlow != curlatchlow)
-								process_changeinlatch (oldlatchlow,
-										       curlatchlow,
-										       pslot->ctrl);
-						}
+		case POLL_LATCH_REGISTER: 
+			oldlatchlow = curlatchlow;
+			ctrl_count = 0x00;
+			list_for_each (pslotlist, &ibmphp_slot_head) {
+				if (ctrl_count >= ibmphp_get_total_controllers())
+					break;
+				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
+				if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
+					ctrl_count++;
+					if (READ_SLOT_LATCH (pslot->ctrl)) {
+						rc = ibmphp_hpc_readslot (pslot,
+									  READ_SLOTLATCHLOWREG,
+									  &curlatchlow);
+						if (oldlatchlow != curlatchlow)
+							process_changeinlatch (oldlatchlow,
+									       curlatchlow,
+									       pslot->ctrl);
 					}
 				}
-				poll_state = POLL_SLOTS;
-				break;
-
-			case POLL_SLOTS:
-				list_for_each (pslotlist, &ibmphp_slot_head) {
-					pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
-					// make a copy of the old status
-					memcpy ((void *) &myslot, (void *) pslot,
-						sizeof (struct slot));
-					rc = ibmphp_hpc_readslot (pslot, READ_ALLSTAT, NULL);
-					if ((myslot.status != pslot->status)
-					    || (myslot.ext_status != pslot->ext_status))
-						process_changeinstatus (pslot, &myslot);
+			}
+			++poll_count;
+			poll_state = POLL_SLEEP;
+			break;
+		case POLL_SLOTS:
+			list_for_each (pslotlist, &ibmphp_slot_head) {
+				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
+				// make a copy of the old status
+				memcpy ((void *) &myslot, (void *) pslot,
+					sizeof (struct slot));
+				rc = ibmphp_hpc_readslot (pslot, READ_ALLSTAT, NULL);
+				if ((myslot.status != pslot->status)
+				    || (myslot.ext_status != pslot->ext_status))
+					process_changeinstatus (pslot, &myslot);
+			}
+			ctrl_count = 0x00;
+			list_for_each (pslotlist, &ibmphp_slot_head) {
+				if (ctrl_count >= ibmphp_get_total_controllers())
+					break;
+				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
+				if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
+					ctrl_count++;
+					if (READ_SLOT_LATCH (pslot->ctrl))
+						rc = ibmphp_hpc_readslot (pslot,
+									  READ_SLOTLATCHLOWREG,
+									  &curlatchlow);
 				}
+			}
+			++poll_count;
+			poll_state = POLL_SLEEP;
+			break;
+		case POLL_SLEEP:
+			/* don't sleep with a lock on the hardware */
+			up (&semOperations);
+			long_delay (POLL_INTERVAL_SEC * HZ);
 
-				ctrl_count = 0x00;
-				list_for_each (pslotlist, &ibmphp_slot_head) {
-					if (ctrl_count >= ibmphp_get_total_controllers())
-						break;
-					pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
-					if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
-						ctrl_count++;
-						if (READ_SLOT_LATCH (pslot->ctrl))
-							rc = ibmphp_hpc_readslot (pslot,
-										  READ_SLOTLATCHLOWREG,
-										  &curlatchlow);
-					}
-				}
-				++poll_count;
-				if (poll_count >= POLL_LATCH_CNT) {
-					poll_count = 0;
-					poll_state = POLL_SLEEP;
-				}
+			if (ibmphp_shutdown) 
 				break;
-
-			case POLL_SLEEP:
-				/* don't sleep with a lock on the hardware */
-				up (&semOperations);
-				long_delay (POLL_INTERVAL_SEC * HZ);
-				down (&semOperations);
+			
+			down (&semOperations);
+			
+			if (poll_count >= POLL_LATCH_CNT) {
+				poll_count = 0;
+				poll_state = POLL_SLOTS;
+			} else
 				poll_state = POLL_LATCH_REGISTER;
-				break;
-		}
-
+			break;
+		}	
 		/* give up the harware semaphore */
 		up (&semOperations);
-
 		/* sleep for a short time just for good measure */
 		set_current_state (TASK_INTERRUPTIBLE);
 		schedule_timeout (HZ/10);
 	}
-
 	up (&sem_exit);
 	debug ("%s - Exit\n", __FUNCTION__);
 }
@@ -1070,15 +1112,23 @@
 	debug ("%s - Entry\n", __FUNCTION__);
 
 	ibmphp_shutdown = TRUE;
+	debug ("before locking operations \n");
 	ibmphp_lock_operations ();
-
+	debug ("after locking operations \n");
+	
 	// wait for poll thread to exit
+	debug ("before sem_exit down \n");
 	down (&sem_exit);
+	debug ("after sem_exit down \n");
 
 	// cleanup
+	debug ("before free_hpc_access \n");
 	free_hpc_access ();
+	debug ("after free_hpc_access \n");
 	ibmphp_unlock_operations ();
+	debug ("after unlock operations \n");
 	up (&sem_exit);
+	debug ("after sem exit up\n");
 
 	debug ("%s - Exit\n", __FUNCTION__);
 }
diff -Nru a/drivers/hotplug/ibmphp_pci.c b/drivers/hotplug/ibmphp_pci.c
--- a/drivers/hotplug/ibmphp_pci.c	Mon Sep  9 15:09:46 2002
+++ b/drivers/hotplug/ibmphp_pci.c	Mon Sep  9 15:09:46 2002
@@ -920,16 +920,30 @@
 	debug ("flag_io = %x, flag_mem = %x, flag_pfmem = %x\n", flag_io, flag_mem, flag_pfmem);
 
 	if (flag_io && flag_mem && flag_pfmem) {
-		bus = kmalloc (sizeof (struct bus_node), GFP_KERNEL);
+		/* If on bootup, there was a bridged card in this slot,
+		 * then card was removed and ibmphp got unloaded and loaded
+		 * back again, there's no way for us to remove the bus
+		 * struct, so no need to kmalloc, can use existing node
+		 */
+		bus = ibmphp_find_res_bus (sec_number);
 		if (!bus) {
-			err ("out of system memory \n");
-			retval = -ENOMEM;
+			bus = kmalloc (sizeof (struct bus_node), GFP_KERNEL);
+			if (!bus) {
+				err ("out of system memory \n");
+				retval = -ENOMEM;
+				goto error;
+			}
+			memset (bus, 0, sizeof (struct bus_node));
+			bus->busno = sec_number;
+			debug ("b4 adding new bus\n");
+			rc = add_new_bus (bus, io, mem, pfmem, func->busno);
+		} else if (!(bus->rangeIO) && !(bus->rangeMem) && !(bus->rangePFMem))
+			rc = add_new_bus (bus, io, mem, pfmem, 0xFF);
+		else {
+			err ("expected bus structure not empty? \n");
+			retval = -EIO;
 			goto error;
 		}
-		memset (bus, 0, sizeof (struct bus_node));
-		bus->busno = sec_number;
-		debug ("b4 adding new bus\n");
-		rc = add_new_bus (bus, io, mem, pfmem, func->busno);
 		if (rc) {
 			if (rc == -ENOMEM) {
 				ibmphp_remove_bus (bus, func->busno);
@@ -1579,7 +1593,6 @@
 	}
 
 	if (sl->func) {
-		debug ("do we come in here? \n");
 		cur_func = sl->func;
 		while (cur_func) {
 			/* TO DO: WILL MOST LIKELY NEED TO GET RID OF THE BUS STRUCTURE FROM RESOURCES AS WELL */
@@ -1619,6 +1632,7 @@
 
 	sl->func = NULL;
 	*slot_cur = sl;
+	debug ("%s - exit\n", __FUNCTION__);
 	return 0;
 }
 
@@ -1638,14 +1652,15 @@
 	struct bus_node *cur_bus = NULL;
 
 	/* Trying to find the parent bus number */
-	cur_bus	= ibmphp_find_res_bus (parent_busno);
-	if (!cur_bus) {
-		err ("strange, cannot find bus which is supposed to be at the system... something is terribly wrong...\n");
-		return -ENODEV;
+	if (parent_busno != 0xFF) {
+		cur_bus	= ibmphp_find_res_bus (parent_busno);
+		if (!cur_bus) {
+			err ("strange, cannot find bus which is supposed to be at the system... something is terribly wrong...\n");
+			return -ENODEV;
+		}
+	
+		list_add (&bus->bus_list, &cur_bus->bus_list);
 	}
-
-	list_add (&bus->bus_list, &cur_bus->bus_list);
-
 	if (io) {
 		io_range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
 		if (!io_range) {
@@ -1698,6 +1713,7 @@
 	int min, max;
 	u8 busno;
 	struct bus_info *bus;
+	struct bus_node *bus_cur;
 
 	bus = ibmphp_find_same_bus_num (primary_busno);
 	if (!bus) {
@@ -1712,7 +1728,12 @@
 	}
 	busno = (u8) (slotno - (u8) min);
 	busno += primary_busno + 0x01;
-	if (!ibmphp_find_res_bus (busno))
+	bus_cur = ibmphp_find_res_bus (busno);
+	/* either there is no such bus number, or there are no ranges, which
+	 * can only happen if we removed the bridged device in previous load
+	 * of the driver, and now only have the skeleton bus struct
+	 */
+	if ((!bus_cur) || (!(bus_cur->rangeIO) && !(bus_cur->rangeMem) && !(bus_cur->rangePFMem)))
 		return busno;
 	return 0xff;
 }
diff -Nru a/drivers/hotplug/ibmphp_res.c b/drivers/hotplug/ibmphp_res.c
--- a/drivers/hotplug/ibmphp_res.c	Mon Sep  9 15:09:46 2002
+++ b/drivers/hotplug/ibmphp_res.c	Mon Sep  9 15:09:46 2002
@@ -45,11 +45,17 @@
 static inline struct bus_node *find_bus_wprev (u8, struct bus_node **, u8);
 
 static LIST_HEAD(gbuses);
+LIST_HEAD(ibmphp_res_head);
 
-static struct bus_node * __init alloc_error_bus (struct ebda_pci_rsrc * curr)
+static struct bus_node * __init alloc_error_bus (struct ebda_pci_rsrc * curr, u8 busno, int flag)
 {
 	struct bus_node * newbus;
 
+	if (!(curr) && !(flag)) {
+		err ("NULL pointer passed \n");
+		return NULL;
+	}
+
 	newbus = kmalloc (sizeof (struct bus_node), GFP_KERNEL);
 	if (!newbus) {
 		err ("out of system memory \n");
@@ -57,14 +63,24 @@
 	}
 
 	memset (newbus, 0, sizeof (struct bus_node));
-	newbus->busno = curr->bus_num;
+	if (flag)
+		newbus->busno = busno;
+	else
+		newbus->busno = curr->bus_num;
 	list_add_tail (&newbus->bus_list, &gbuses);
 	return newbus;
 }
 
 static struct resource_node * __init alloc_resources (struct ebda_pci_rsrc * curr)
 {
-	struct resource_node *rs = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+	struct resource_node *rs;
+	
+	if (!curr) {
+		err ("NULL passed to allocate \n");
+		return NULL;
+	}
+
+	rs = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 	if (!rs) {
 		err ("out of system memory \n");
 		return NULL;
@@ -299,7 +315,7 @@
 				 * actually appears...
 				 */
 				if (ibmphp_add_resource (new_mem) < 0) {
-					newbus = alloc_error_bus (curr);
+					newbus = alloc_error_bus (curr, 0, 0);
 					if (!newbus)
 						return -ENOMEM;
 					newbus->firstMem = new_mem;
@@ -316,7 +332,7 @@
 				new_pfmem->type = PFMEM;
 				new_pfmem->fromMem = FALSE;
 				if (ibmphp_add_resource (new_pfmem) < 0) {
-					newbus = alloc_error_bus (curr);
+					newbus = alloc_error_bus (curr, 0, 0);
 					if (!newbus)
 						return -ENOMEM;
 					newbus->firstPFMem = new_pfmem;
@@ -340,7 +356,7 @@
 				 * range actually appears...
 				 */
 				if (ibmphp_add_resource (new_io) < 0) {
-					newbus = alloc_error_bus (curr);
+					newbus = alloc_error_bus (curr, 0, 0);
 					if (!newbus)
 						return -ENOMEM;
 					newbus->firstIO = new_io;
@@ -352,8 +368,6 @@
 		}
 	}
 
-	debug ("after the while loop in rsrc_init \n");
-
 	list_for_each (tmp, &gbuses) {
 		bus_cur = list_entry (tmp, struct bus_node, bus_list);
 		/* This is to get info about PPB resources, since EBDA doesn't put this info into the primary bus info */
@@ -361,11 +375,9 @@
 		if (rc)
 			return rc;
 	}
-	debug ("b4 once_over in rsrc_init \n");
 	rc = once_over ();  /* This is to align ranges (so no -1) */
 	if (rc)
 		return rc;
-	debug ("after once_over in rsrc_init \n");
 	return 0;
 }
 
@@ -580,7 +592,7 @@
  * based on their resource type and sorted by their starting addresses.  It assigns
  * the ptrs to next and nextRange if needed.
  *
- * Input: 3 diff. resources (nulled out if not needed)
+ * Input: resource ptr
  * Output: ptrs assigned (to the node)
  * 0 or -1
  *******************************************************************************/
@@ -593,12 +605,17 @@
 	struct resource_node *res_start = NULL;
 
 	debug ("%s - enter\n", __FUNCTION__);
+
+	if (!res) {
+		err ("NULL passed to add \n");
+		return -ENODEV;
+	}
 	
 	bus_cur = find_bus_wprev (res->busno, NULL, 0);
 	
 	if (!bus_cur) {
 		/* didn't find a bus, smth's wrong!!! */
-		err ("no bus in the system, either pci_dev's wrong or allocation failed\n");
+		debug ("no bus in the system, either pci_dev's wrong or allocation failed\n");
 		return -ENODEV;
 	}
 
@@ -769,6 +786,11 @@
 	struct resource_node *mem_cur;
 	char * type = "";
 
+	if (!res)  {
+		err ("resource to remove is NULL \n");
+		return -ENODEV;
+	}
+
 	bus_cur = find_bus_wprev (res->busno, NULL, 0);
 
 	if (!bus_cur) {
@@ -797,7 +819,6 @@
 	res_prev = NULL;
 
 	while (res_cur) {
-		/* ???????????DO WE _NEED_ TO BE CHECKING FOR END AS WELL?????????? */
 		if ((res_cur->start == res->start) && (res_cur->end == res->end))
 			break;
 		res_prev = res_cur;
@@ -981,7 +1002,7 @@
 
 	if (!bus_cur) {
 		/* didn't find a bus, smth's wrong!!! */
-		err ("no bus in the system, either pci_dev's wrong or allocation failed \n");
+		debug ("no bus in the system, either pci_dev's wrong or allocation failed \n");
 		return -EINVAL;
 	}
 
@@ -1340,7 +1361,7 @@
 	prev_bus = find_bus_wprev (parent_busno, NULL, 0);	
 
 	if (!prev_bus) {
-		err ("something terribly wrong. Cannot find parent bus to the one to remove\n");
+		debug ("something terribly wrong. Cannot find parent bus to the one to remove\n");
 		return -ENODEV;
 	}
 
@@ -1467,13 +1488,18 @@
 
 /*
  * find the resource node in the bus 
- * Input: Resource needed, start address of the resource, type or resource
+ * Input: Resource needed, start address of the resource, type of resource
  */
 int ibmphp_find_resource (struct bus_node *bus, u32 start_address, struct resource_node **res, int flag)
 {
 	struct resource_node *res_cur = NULL;
 	char * type = "";
 
+	if (!bus) {
+		err ("The bus passed in NULL to find resource \n");
+		return -ENODEV;
+	}
+
 	switch (flag) {
 		case IO:
 			res_cur = bus->firstIO;
@@ -1514,11 +1540,11 @@
 				res_cur = res_cur->next;
 			}
 			if (!res_cur) {
-				err ("SOS...cannot find %s resource in the bus. \n", type);
+				debug ("SOS...cannot find %s resource in the bus. \n", type);
 				return -EINVAL;
 			}
 		} else {
-			err ("SOS... cannot find %s resource in the bus. \n", type);
+			debug ("SOS... cannot find %s resource in the bus. \n", type);
 			return -EINVAL;
 		}
 	}
@@ -1756,6 +1782,8 @@
 	struct range_node *range;
 	struct resource_node *res;
 	struct list_head *tmp;
+	
+	debug_pci ("*****************START**********************\n");
 
 	if ((!list_empty(&gbuses)) && flags) {
 		err ("The GBUSES is not NULL?!?!?!?!?\n");
@@ -1764,50 +1792,50 @@
 
 	list_for_each (tmp, &gbuses) {
 		bus_cur = list_entry (tmp, struct bus_node, bus_list);
-		debug ("This is bus # %d.  There are \n", bus_cur->busno);
-		debug ("IORanges = %d\t", bus_cur->noIORanges);
-		debug ("MemRanges = %d\t", bus_cur->noMemRanges);
-		debug ("PFMemRanges = %d\n", bus_cur->noPFMemRanges);
-		debug ("The IO Ranges are as follows:\n");
+		debug_pci ("This is bus # %d.  There are \n", bus_cur->busno);
+		debug_pci ("IORanges = %d\t", bus_cur->noIORanges);
+		debug_pci ("MemRanges = %d\t", bus_cur->noMemRanges);
+		debug_pci ("PFMemRanges = %d\n", bus_cur->noPFMemRanges);
+		debug_pci ("The IO Ranges are as follows:\n");
 		if (bus_cur->rangeIO) {
 			range = bus_cur->rangeIO;
 			for (i = 0; i < bus_cur->noIORanges; i++) {
-				debug ("rangeno is %d\n", range->rangeno);
-				debug ("[%x - %x]\n", range->start, range->end);
+				debug_pci ("rangeno is %d\n", range->rangeno);
+				debug_pci ("[%x - %x]\n", range->start, range->end);
 				range = range->next;
 			}
 		}
 
-		debug ("The Mem Ranges are as follows:\n");
+		debug_pci ("The Mem Ranges are as follows:\n");
 		if (bus_cur->rangeMem) {
 			range = bus_cur->rangeMem;
 			for (i = 0; i < bus_cur->noMemRanges; i++) {
-				debug ("rangeno is %d\n", range->rangeno);
-				debug ("[%x - %x]\n", range->start, range->end);
+				debug_pci ("rangeno is %d\n", range->rangeno);
+				debug_pci ("[%x - %x]\n", range->start, range->end);
 				range = range->next;
 			}
 		}
 
-		debug ("The PFMem Ranges are as follows:\n");
+		debug_pci ("The PFMem Ranges are as follows:\n");
 
 		if (bus_cur->rangePFMem) {
 			range = bus_cur->rangePFMem;
 			for (i = 0; i < bus_cur->noPFMemRanges; i++) {
-				debug ("rangeno is %d\n", range->rangeno);
-				debug ("[%x - %x]\n", range->start, range->end);
+				debug_pci ("rangeno is %d\n", range->rangeno);
+				debug_pci ("[%x - %x]\n", range->start, range->end);
 				range = range->next;
 			}
 		}
 
-		debug ("The resources on this bus are as follows\n");
+		debug_pci ("The resources on this bus are as follows\n");
 
-		debug ("IO...\n");
+		debug_pci ("IO...\n");
 		if (bus_cur->firstIO) {
 			res = bus_cur->firstIO;
 			while (res) {
-				debug ("The range # is %d\n", res->rangeno);
-				debug ("The bus, devfnc is %d, %x\n", res->busno, res->devfunc);
-				debug ("[%x - %x], len=%x\n", res->start, res->end, res->len);
+				debug_pci ("The range # is %d\n", res->rangeno);
+				debug_pci ("The bus, devfnc is %d, %x\n", res->busno, res->devfunc);
+				debug_pci ("[%x - %x], len=%x\n", res->start, res->end, res->len);
 				if (res->next)
 					res = res->next;
 				else if (res->nextRange)
@@ -1816,13 +1844,13 @@
 					break;
 			}
 		}
-		debug ("Mem...\n");
+		debug_pci ("Mem...\n");
 		if (bus_cur->firstMem) {
 			res = bus_cur->firstMem;
 			while (res) {
-				debug ("The range # is %d\n", res->rangeno);
-				debug ("The bus, devfnc is %d, %x\n", res->busno, res->devfunc);
-				debug ("[%x - %x], len=%x\n", res->start, res->end, res->len);
+				debug_pci ("The range # is %d\n", res->rangeno);
+				debug_pci ("The bus, devfnc is %d, %x\n", res->busno, res->devfunc);
+				debug_pci ("[%x - %x], len=%x\n", res->start, res->end, res->len);
 				if (res->next)
 					res = res->next;
 				else if (res->nextRange)
@@ -1831,13 +1859,13 @@
 					break;
 			}
 		}
-		debug ("PFMem...\n");
+		debug_pci ("PFMem...\n");
 		if (bus_cur->firstPFMem) {
 			res = bus_cur->firstPFMem;
 			while (res) {
-				debug ("The range # is %d\n", res->rangeno);
-				debug ("The bus, devfnc is %d, %x\n", res->busno, res->devfunc);
-				debug ("[%x - %x], len=%x\n", res->start, res->end, res->len);
+				debug_pci ("The range # is %d\n", res->rangeno);
+				debug_pci ("The bus, devfnc is %d, %x\n", res->busno, res->devfunc);
+				debug_pci ("[%x - %x], len=%x\n", res->start, res->end, res->len);
 				if (res->next)
 					res = res->next;
 				else if (res->nextRange)
@@ -1847,23 +1875,53 @@
 			}
 		}
 
-		debug ("PFMemFromMem...\n");
+		debug_pci ("PFMemFromMem...\n");
 		if (bus_cur->firstPFMemFromMem) {
 			res = bus_cur->firstPFMemFromMem;
 			while (res) {
-				debug ("The range # is %d\n", res->rangeno);
-				debug ("The bus, devfnc is %d, %x\n", res->busno, res->devfunc);
-				debug ("[%x - %x], len=%x\n", res->start, res->end, res->len);
+				debug_pci ("The range # is %d\n", res->rangeno);
+				debug_pci ("The bus, devfnc is %d, %x\n", res->busno, res->devfunc);
+				debug_pci ("[%x - %x], len=%x\n", res->start, res->end, res->len);
 				res = res->next;
 			}
 		}
 	}
+	debug_pci ("***********************END***********************\n");
+}
+
+int static range_exists_already (struct range_node * range, struct bus_node * bus_cur, u8 type)
+{
+	struct range_node * range_cur = NULL;
+	switch (type) {
+		case IO:
+			range_cur = bus_cur->rangeIO;
+			break;
+		case MEM:
+			range_cur = bus_cur->rangeMem;
+			break;
+		case PFMEM:
+			range_cur = bus_cur->rangePFMem;
+			break;
+		default:
+			err ("wrong type passed to find out if range already exists \n");
+			return -ENODEV;
+	}
+
+	while (range_cur) {
+		if ((range_cur->start == range->start) && (range_cur->end == range->end))
+			return 1;
+		range_cur = range_cur->next;
+	}
+	
+	return 0;
 }
 
 /* This routine will read the windows for any PPB we have and update the
  * range info for the secondary bus, and will also input this info into
  * primary bus, since BIOS doesn't. This is for PPB that are in the system
- * on bootup
+ * on bootup.  For bridged cards that were added during previous load of the
+ * driver, only the ranges and the bus structure are added, the devices are
+ * added from NVRAM
  * Input: primary busno
  * Returns: none
  * Note: this function doesn't take into account IO restrictions etc,
@@ -1884,6 +1942,8 @@
 	struct resource_node *pfmem;
 	struct range_node *range;
 	bus_cur = *bus;
+	if (!bus_cur)
+		return -ENODEV;
 	busno = bus_cur->busno;
 
 	debug ("inside %s \n", __FUNCTION__);
@@ -1916,6 +1976,12 @@
 						 */
 						pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_SECONDARY_BUS, &sec_busno);
 						bus_sec = find_bus_wprev (sec_busno, NULL, 0); 
+						/* this bus structure doesn't exist yet, PPB was configured during previous loading of ibmphp */
+						if (!bus_sec) {
+							bus_sec = alloc_error_bus (NULL, sec_busno, 1);
+							/* the rest will be populated during NVRAM call */
+							return 0;
+						}
 						pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_IO_BASE, &start_io_address);
 						pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_IO_LIMIT, &end_io_address);
 						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_IO_BASE_UPPER16, &upper_io_start);
@@ -1926,9 +1992,7 @@
 						end_address |= (upper_io_end << 16);
 
 						if ((start_address) && (start_address <= end_address)) {
-
 							range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
-
 							if (!range) {
 								err ("out of system memory \n");
 								return -ENOMEM;
@@ -1937,33 +2001,39 @@
 							range->start = start_address;
 							range->end = end_address + 0xfff;
 
-							if (bus_sec->noIORanges > 0) 
-								add_range (IO, range, bus_sec);
-							else {
+							if (bus_sec->noIORanges > 0) {
+								if (!range_exists_already (range, bus_sec, IO)) {
+									add_range (IO, range, bus_sec);
+									++bus_sec->noIORanges;
+								} else {
+									kfree (range);
+									range = NULL;
+								}
+							} else {
 								/* 1st IO Range on the bus */
 								range->rangeno = 1;
 								bus_sec->rangeIO = range;
+								++bus_sec->noIORanges;
 							}
-
-							++bus_sec->noIORanges;
 							fix_resources (bus_sec);
-						
-							io = kmalloc (sizeof (struct resource_node), GFP_KERNEL);							
-							if (!io) {
-								kfree (range);
-								err ("out of system memory \n");
-								return -ENOMEM;
-							}
-							memset (io, 0, sizeof (struct resource_node));
-							io->type = IO;
-							io->busno = bus_cur->busno;
-							io->devfunc = ((device << 3) | (function & 0x7));
-							io->start = start_address;
-							io->end = end_address + 0xfff;
-							io->len = io->end - io->start + 1;
 
-							ibmphp_add_resource (io);
-						}
+							if (ibmphp_find_resource (bus_cur, start_address, &io, IO)) {
+								io = kmalloc (sizeof (struct resource_node), GFP_KERNEL);							
+								if (!io) {
+									kfree (range);
+									err ("out of system memory \n");
+									return -ENOMEM;
+								}
+								memset (io, 0, sizeof (struct resource_node));
+								io->type = IO;
+								io->busno = bus_cur->busno;
+								io->devfunc = ((device << 3) | (function & 0x7));
+								io->start = start_address;
+								io->end = end_address + 0xfff;
+								io->len = io->end - io->start + 1;
+								ibmphp_add_resource (io);
+							}
+						}	
 
 						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_MEMORY_BASE, &start_mem_address);
 						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_MEMORY_LIMIT, &end_mem_address);
@@ -1982,31 +2052,39 @@
 							range->start = start_address;
 							range->end = end_address + 0xfffff;
 
-							if (bus_sec->noMemRanges > 0) 
-								add_range (MEM, range, bus_sec);
-							else {
+							if (bus_sec->noMemRanges > 0) {
+								if (!range_exists_already (range, bus_sec, MEM)) {
+									add_range (MEM, range, bus_sec);
+									++bus_sec->noMemRanges;
+								} else {
+									kfree (range);
+									range = NULL;
+								}
+							} else {
 								/* 1st Mem Range on the bus */
 								range->rangeno = 1;
 								bus_sec->rangeMem = range;
+								++bus_sec->noMemRanges;
 							}
 
-							++bus_sec->noMemRanges;
 							fix_resources (bus_sec);
 
-							mem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
-							if (!mem) {
-								kfree (range);
-								err ("out of system memory \n");
-								return -ENOMEM;
+							if (ibmphp_find_resource (bus_cur, start_address, &mem, MEM)) {
+								mem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+								if (!mem) {
+									kfree (range);
+									err ("out of system memory \n");
+									return -ENOMEM;
+								}
+								memset (mem, 0, sizeof (struct resource_node));
+								mem->type = MEM;
+								mem->busno = bus_cur->busno;
+								mem->devfunc = ((device << 3) | (function & 0x7));
+								mem->start = start_address;
+								mem->end = end_address + 0xfffff;
+								mem->len = mem->end - mem->start + 1;
+								ibmphp_add_resource (mem);
 							}
-							memset (mem, 0, sizeof (struct resource_node));
-							mem->type = MEM;
-							mem->busno = bus_cur->busno;
-							mem->devfunc = ((device << 3) | (function & 0x7));
-							mem->start = start_address;
-							mem->end = end_address + 0xfffff;
-							mem->len = mem->end - mem->start + 1;
-							ibmphp_add_resource (mem);
 						}
 						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_PREF_MEMORY_BASE, &start_mem_address);
 						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_PREF_MEMORY_LIMIT, &end_mem_address);
@@ -2030,32 +2108,40 @@
 							range->start = start_address;
 							range->end = end_address + 0xfffff;
 
-							if (bus_sec->noPFMemRanges > 0)
-								add_range (PFMEM, range, bus_sec);
-							else {
+							if (bus_sec->noPFMemRanges > 0) {
+								if (!range_exists_already (range, bus_sec, PFMEM)) {
+									add_range (PFMEM, range, bus_sec);
+									++bus_sec->noPFMemRanges;
+								} else {
+									kfree (range);
+									range = NULL;
+								}
+							} else {
 								/* 1st PFMem Range on the bus */
 								range->rangeno = 1;
 								bus_sec->rangePFMem = range;
+								++bus_sec->noPFMemRanges;
 							}
 
-							++bus_sec->noPFMemRanges;
 							fix_resources (bus_sec);
+							if (ibmphp_find_resource (bus_cur, start_address, &pfmem, PFMEM)) {
+								pfmem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
+								if (!pfmem) {
+									kfree (range);
+									err ("out of system memory \n");
+									return -ENOMEM;
+								}
+								memset (pfmem, 0, sizeof (struct resource_node));
+								pfmem->type = PFMEM;
+								pfmem->busno = bus_cur->busno;
+								pfmem->devfunc = ((device << 3) | (function & 0x7));
+								pfmem->start = start_address;
+								pfmem->end = end_address + 0xfffff;
+								pfmem->len = pfmem->end - pfmem->start + 1;
+								pfmem->fromMem = FALSE;
 
-							pfmem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
-							if (!pfmem) {
-								kfree (range);
-								err ("out of system memory \n");
-								return -ENOMEM;
+								ibmphp_add_resource (pfmem);
 							}
-							memset (pfmem, 0, sizeof (struct resource_node));
-							pfmem->type = PFMEM;
-							pfmem->busno = bus_cur->busno;
-							pfmem->devfunc = ((device << 3) | (function & 0x7));
-							pfmem->start = start_address;
-							pfmem->end = end_address + 0xfffff;
-							pfmem->len = pfmem->end - pfmem->start + 1;
-							pfmem->fromMem = FALSE;
-							ibmphp_add_resource (pfmem);
 						}
 						break;
 				}	/* end of switch */
