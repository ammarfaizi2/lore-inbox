Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSHFUg2>; Tue, 6 Aug 2002 16:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHFUg2>; Tue, 6 Aug 2002 16:36:28 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:40721 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315709AbSHFUfX>;
	Tue, 6 Aug 2002 16:35:23 -0400
Date: Tue, 6 Aug 2002 13:36:20 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.4.20-pre1
Message-ID: <20020806203620.GC2022@kroah.com>
References: <20020806203513.GA2022@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020806203513.GA2022@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 09 Jul 2002 19:34:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.685   -> 1.686  
#	drivers/hotplug/ibmphp_hpc.c	1.1     -> 1.2    
#	drivers/hotplug/ibmphp_ebda.c	1.1     -> 1.2    
#	drivers/hotplug/ibmphp.h	1.1     -> 1.2    
#	drivers/hotplug/ibmphp_core.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/06	greg@kroah.com	1.686
# IBM PCI Hotplug driver update
# 
# This brings the driver up to the latest version, and includes the following fixes:
# 	- timeout bug fixed (now large number of slots do not cause problems.)
# 	- more different types of hardware supported.
# 	- more slot information is now tracked.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp.h b/drivers/hotplug/ibmphp.h
--- a/drivers/hotplug/ibmphp.h	Tue Aug  6 12:10:48 2002
+++ b/drivers/hotplug/ibmphp.h	Tue Aug  6 12:10:48 2002
@@ -168,13 +168,11 @@
 
 struct ebda_hpc_bus {
 	u32 bus_num;
-/*
 	u8 slots_at_33_conv;
 	u8 slots_at_66_conv;
 	u8 slots_at_66_pcix;
 	u8 slots_at_100_pcix;
 	u8 slots_at_133_pcix;
-*/
 };
 
 
@@ -232,12 +230,15 @@
 	u8 slot_max;
 	u8 slot_count;
 	u8 busno;
-	u8 current_speed;
-	u8 supported_speed;
 	u8 controller_id;
-	u8 supported_bus_mode;
+	u8 current_speed;
 	u8 current_bus_mode;
 	u8 index;
+	u8 slots_at_33_conv;
+	u8 slots_at_66_conv;
+	u8 slots_at_66_pcix;
+	u8 slots_at_100_pcix;
+	u8 slots_at_133_pcix;
 	struct list_head bus_info_list;
 };
 
@@ -690,8 +691,11 @@
 	u8 bus;
 	u8 device;
 	u8 number;
+	u8 real_physical_slot_num;
 	char name[100];
 	u32 capabilities;
+	u8 supported_speed;
+	u8 supported_bus_mode;
 	struct hotplug_slot *hotplug_slot;
 	struct controller *ctrl;
 	struct pci_func *func;
@@ -709,10 +713,12 @@
 struct controller {
 	struct ebda_hpc_slot *slots;
 	struct ebda_hpc_bus *buses;
+	u8 starting_slot_num;	/* starting and ending slot #'s this ctrl controls*/
+	u8 ending_slot_num;
 	u8 revision;
 	u8 options;		/* which options HPC supports */
 	u8 status;
-	u8 ctlr_id;		/* TONI */
+	u8 ctlr_id;
 	u8 slot_count;
 	u8 bus_count;
 	u8 ctlr_relative_id;
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Tue Aug  6 12:10:48 2002
+++ b/drivers/hotplug/ibmphp_core.c	Tue Aug  6 12:10:48 2002
@@ -44,7 +44,7 @@
 #define get_ctrl_revision(sl, rev) ibmphp_hpc_readslot (sl, READ_REVLEVEL, rev)
 #define get_hpc_options(sl, opt) ibmphp_hpc_readslot (sl, READ_HPCOPTIONS, opt)
 
-#define DRIVER_VERSION	"0.1"
+#define DRIVER_VERSION	"0.3"
 #define DRIVER_DESC	"IBM Hot Plug PCI Controller Driver"
 
 int ibmphp_debug;
@@ -393,8 +393,8 @@
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
 			rc = 0;
-			mode = pslot->bus_on->supported_bus_mode;
-			*value = pslot->bus_on->supported_speed;
+			mode = pslot->supported_bus_mode;
+			*value = pslot->supported_speed;
 			*value &= 0x0f;
 
 			if (mode == BUS_MODE_PCIX)
@@ -1009,6 +1009,7 @@
 	}
 	return rc;
 }
+
 /*******************************************************
  * Returns whether the bus is empty or not 
  *******************************************************/
@@ -1036,7 +1037,9 @@
 
 /***********************************************************
  * If the HPC permits and the bus currently empty, tries to set the 
- * bus speed and mode at the maximum card capability
+ * bus speed and mode at the maximum card and bus capability
+ * Parameters: slot
+ * Returns: bus is set (0) or error code
  ***********************************************************/
 static int set_bus (struct slot * slot_cur)
 {
@@ -1056,30 +1059,102 @@
 			cmd = HPC_BUS_33CONVMODE;
 			break;
 		case HPC_SLOT_SPEED_66:
-			if (SLOT_PCIX (slot_cur->ext_status))
-				cmd = HPC_BUS_66PCIXMODE;
-			else
-				cmd = HPC_BUS_66CONVMODE;
+			if (SLOT_PCIX (slot_cur->ext_status)) {
+				if ((slot_cur->supported_speed >= BUS_SPEED_66) && (slot_cur->supported_bus_mode == BUS_MODE_PCIX))
+					cmd = HPC_BUS_66PCIXMODE;
+				else if (!SLOT_BUS_MODE (slot_cur->ext_status))
+					/* if max slot/bus capability is 66 pci
+					and there's no bus mode mismatch, then
+					the adapter supports 66 pci */ 
+					cmd = HPC_BUS_66CONVMODE;
+				else
+					cmd = HPC_BUS_33CONVMODE;
+			} else {
+				if (slot_cur->supported_speed >= BUS_SPEED_66)
+					cmd = HPC_BUS_66CONVMODE;
+				else
+					cmd = HPC_BUS_33CONVMODE;
+			}
 			break;
 		case HPC_SLOT_SPEED_133:
-			if (slot_cur->bus_on->slot_count > 1)
+			switch (slot_cur->supported_speed) {
+			case BUS_SPEED_33:
+				cmd = HPC_BUS_33CONVMODE;
+				break;
+			case BUS_SPEED_66:
+				if (slot_cur->supported_bus_mode == BUS_MODE_PCIX)
+					cmd = HPC_BUS_66PCIXMODE;
+				else
+					cmd = HPC_BUS_66CONVMODE;
+				break;
+			case BUS_SPEED_100:
 				cmd = HPC_BUS_100PCIXMODE;
-			else
+				break;
+			case BUS_SPEED_133:
 				cmd = HPC_BUS_133PCIXMODE;
+				break;
+			default:
+				err ("Wrong bus speed \n");
+				return -ENODEV;
+			}
 			break;
 		default:
 			err ("wrong slot speed \n");
 			return -ENODEV;
 		}
 		debug ("setting bus speed for slot %d, cmd %x\n", slot_cur->number, cmd);
-		rc = ibmphp_hpc_writeslot (slot_cur, cmd);
-		if (rc)
-			return rc;
+		ibmphp_hpc_writeslot (slot_cur, cmd);
 	}
+	/* This is for x400, once Brandon fixes the firmware, 
+	will not need this delay */
+	long_delay (1 * HZ);
 	debug ("%s -Exit \n", __FUNCTION__);
 	return 0;
 }
 
+/* This routine checks the bus limitations that the slot is on from the BIOS.
+ * This is used in deciding whether or not to power up the slot.  
+ * (electrical/spec limitations. For example, >1 133 MHz or >2 66 PCI cards on
+ * same bus) 
+ * Parameters: slot
+ * Returns: 0 = no limitations, -EINVAL = exceeded limitations on the bus
+ */
+static int check_limitations (struct slot *slot_cur)
+{
+	u8 i;
+	struct slot * tmp_slot;
+	u8 count = 0;
+	u8 limitation = 0;
+
+	for (i = slot_cur->bus_on->slot_min; i <= slot_cur->bus_on->slot_max; i++) {
+		tmp_slot = ibmphp_get_slot_from_physical_num (i);
+		if ((SLOT_POWER (tmp_slot->status)) && !(SLOT_CONNECT (tmp_slot->status))) 
+			count++;
+	}
+	get_cur_bus_info (&slot_cur);
+	switch (slot_cur->bus_on->current_speed) {
+	case BUS_SPEED_33:
+		limitation = slot_cur->bus_on->slots_at_33_conv;
+		break;
+	case BUS_SPEED_66:
+		if (slot_cur->bus_on->current_bus_mode == BUS_MODE_PCIX)
+			limitation = slot_cur->bus_on->slots_at_66_pcix;
+		else
+			limitation = slot_cur->bus_on->slots_at_66_conv;
+		break;
+	case BUS_SPEED_100:
+		limitation = slot_cur->bus_on->slots_at_100_pcix;
+		break;
+	case BUS_SPEED_133:
+		limitation = slot_cur->bus_on->slots_at_133_pcix;
+		break;
+	}
+
+	if ((count + 1) > limitation)
+		return -EINVAL;
+	return 0;
+}
+
 static inline void print_card_capability (struct slot *slot_cur)
 {
 	info ("capability of the card is ");
@@ -1136,7 +1211,28 @@
 		ibmphp_unlock_operations ();
 		return -ENODEV;
 	}
-		
+
+	/*-----------------debugging------------------------------*/
+	get_cur_bus_info (&slot_cur);
+	debug ("the current bus speed right after set_bus = %x \n", slot_cur->bus_on->current_speed); 
+	/*----------------------------------------------------------*/
+
+	rc = check_limitations (slot_cur);
+	if (rc) {
+		err ("Adding this card exceeds the limitations of this bus. \n");
+		err ("(i.e., >1 133MHz cards running on same bus, or >2 66 PCI cards running on same bus \n. Try hot-adding into another bus \n");
+		attn_off (slot_cur);
+		attn_on (slot_cur);
+
+		if (slot_update (&slot_cur)) {
+			ibmphp_unlock_operations ();
+			return -ENODEV;
+		}
+		ibmphp_update_slot_info (slot_cur);
+		ibmphp_unlock_operations ();
+		return -EINVAL;
+	}
+
 	rc = power_on (slot_cur);
 
 	if (rc) {
@@ -1151,19 +1247,24 @@
 			return -ENODEV;
 		}
 		/* Check to see the error of why it failed */
-		if (!(SLOT_PWRGD (slot_cur->status)))
+		if ((SLOT_POWER (slot_cur->status)) && !(SLOT_PWRGD (slot_cur->status)))
 			err ("power fault occured trying to power up \n");
 		else if (SLOT_BUS_SPEED (slot_cur->status)) {
 			err ("bus speed mismatch occured.  please check current bus speed and card capability \n");
 			print_card_capability (slot_cur);
-		} else if (SLOT_BUS_MODE (slot_cur->ext_status)) 
+		} else if (SLOT_BUS_MODE (slot_cur->ext_status)) {
 			err ("bus mode mismatch occured.  please check current bus mode and card capability \n");
-
+			print_card_capability (slot_cur);
+		}
 		ibmphp_update_slot_info (slot_cur);
-		ibmphp_unlock_operations (); 
+		ibmphp_unlock_operations ();
 		return rc;
 	}
 	debug ("after power_on\n");
+	/*-----------------------debugging---------------------------*/
+	get_cur_bus_info (&slot_cur);
+	debug ("the current bus speed right after power_on = %x \n", slot_cur->bus_on->current_speed);
+	/*----------------------------------------------------------*/
 
 	rc = slot_update (&slot_cur);
 	if (rc) {
@@ -1180,7 +1281,7 @@
 	
 	if (SLOT_POWER (slot_cur->status) && !(SLOT_PWRGD (slot_cur->status))) {
 		faulted = 1;
-		err ("power fault occured trying to power up...\n");
+		err ("power fault occured trying to power up... \n");
 	} else if (SLOT_POWER (slot_cur->status) && (SLOT_BUS_SPEED (slot_cur->status))) {
 		faulted = 1;
 		err ("bus speed mismatch occured.  please check current bus speed and card capability \n");
@@ -1200,8 +1301,8 @@
 			return rcpr;
 		}
 			
-		if (slot_update (&slot_cur)) {
-			ibmphp_unlock_operations ();
+		if (slot_update (&slot_cur)) {                      
+			ibmphp_unlock_operations ();	
 			return -ENODEV;
 		}
 		ibmphp_update_slot_info (slot_cur);
@@ -1278,20 +1379,24 @@
 {
 	int rc;
 	struct slot *slot_cur = (struct slot *) hotplug_slot->private;
-	u8 flag = slot_cur->flag;
+	u8 flag;
+	int parm = 0;
 
-	slot_cur->flag = TRUE;
 	debug ("DISABLING SLOT... \n"); 
 		
-	ibmphp_lock_operations (); 
-	if (slot_cur == NULL) {
-		ibmphp_unlock_operations ();
+	if (slot_cur == NULL) 
 		return -ENODEV;
-	}
-	if (slot_cur->ctrl == NULL) {
-		ibmphp_unlock_operations ();
+	
+	if (slot_cur->ctrl == NULL) 
 		return -ENODEV;
-	}
+	
+	flag = slot_cur->flag;	/* to see if got here from polling */
+	
+	if (flag)
+		ibmphp_lock_operations ();
+	
+	slot_cur->flag = TRUE;
+
 	if (flag == TRUE) {
 		rc = validate (slot_cur, DISABLE);	/* checking if powered off already & valid slot # */
 		if (rc) {
@@ -1333,10 +1438,21 @@
 		ibmphp_unlock_operations ();
 		return rc;
 	}
+        
+	/* If we got here from latch suddenly opening on operating card or 
+	a power fault, there's no power to the card, so cannot
+	read from it to determine what resources it occupied.  This operation
+	is forbidden anyhow.  The best we can do is remove it from kernel
+	lists at least */
+
+	if (!flag) {
+		attn_off (slot_cur);
+		return 0;
+	}
 
-	rc = ibmphp_unconfigure_card (&slot_cur, 0);
+	rc = ibmphp_unconfigure_card (&slot_cur, parm);
 	slot_cur->func = NULL;
-	debug ("in disable_slot. after unconfigure_card \n");
+	debug ("in disable_slot. after unconfigure_card\n");
 	if (rc) {
 		err ("could not unconfigure card.\n");
 		attn_off (slot_cur);	/* need to turn off if was blinking b4 */
@@ -1347,9 +1463,7 @@
 			return -EFAULT;
 		}
 
-		if (flag) 
-			ibmphp_update_slot_info (slot_cur);
-
+		ibmphp_update_slot_info (slot_cur);
 		ibmphp_unlock_operations ();
 		return -EFAULT;
 	}
@@ -1363,9 +1477,7 @@
 			return -EFAULT;
 		}
 
-		if (flag)
-			ibmphp_update_slot_info (slot_cur);
-
+		ibmphp_update_slot_info (slot_cur);
 		ibmphp_unlock_operations ();
 		return rc;
 	}
@@ -1375,11 +1487,7 @@
 		ibmphp_unlock_operations ();
 		return -EFAULT;
 	}
-	if (flag) 
-		rc = ibmphp_update_slot_info (slot_cur);
-	else
-		rc = 0;
-
+	rc = ibmphp_update_slot_info (slot_cur);
 	ibmphp_print_test ();
 	ibmphp_unlock_operations();
 	return rc;
@@ -1422,9 +1530,12 @@
 	int rc = 0;
 
 	init_flag = 1;
+
+	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
+
 	ibmphp_pci_root_ops = get_root_pci_ops ();
 	if (ibmphp_pci_root_ops == NULL) {
-		err ("cannot read bus operations... will not be able to read the cards.  Please check your system \n");
+		err ("cannot read bus operations... will not be able to read the cards.  Please check your system\n");
 		return -ENODEV;	
 	}
 
@@ -1439,13 +1550,13 @@
 		ibmphp_unload ();
 		return rc;
 	}
-	debug ("after ibmphp_access_ebda () \n");
+	debug ("after ibmphp_access_ebda ()\n");
 
 	if ((rc = ibmphp_rsrc_init ())) {
 		ibmphp_unload ();
 		return rc;
 	}
-	debug ("AFTER Resource & EBDA INITIALIZATIONS \n");
+	debug ("AFTER Resource & EBDA INITIALIZATIONS\n");
 
 	max_slots = get_max_slots ();
 
@@ -1463,7 +1574,6 @@
 	 * so that no one can unload us. */
 	MOD_DEC_USE_COUNT;
 
-	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 	return 0;
 }
@@ -1471,9 +1581,9 @@
 static void __exit ibmphp_exit (void)
 {
 	ibmphp_hpc_stop_poll_thread ();
-	debug ("after polling \n");
+	debug ("after polling\n");
 	ibmphp_unload ();
-	debug ("done \n");
+	debug ("done\n");
 }
 
 module_init (ibmphp_init);
diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Tue Aug  6 12:10:48 2002
+++ b/drivers/hotplug/ibmphp_ebda.c	Tue Aug  6 12:10:48 2002
@@ -161,9 +161,14 @@
 		debug ("%s - slot_count = %x\n", __FUNCTION__, ptr->slot_count);
 		debug ("%s - bus# = %x\n", __FUNCTION__, ptr->busno);
 		debug ("%s - current_speed = %x\n", __FUNCTION__, ptr->current_speed);
-		debug ("%s - supported_speed = %x\n", __FUNCTION__, ptr->supported_speed);
 		debug ("%s - controller_id = %x\n", __FUNCTION__, ptr->controller_id);
-		debug ("%s - bus_mode = %x\n", __FUNCTION__, ptr->supported_bus_mode);
+		
+		debug ("%s - slots_at_33_conv = %x\n", __FUNCTION__, ptr->slots_at_33_conv);
+		debug ("%s - slots_at_66_conv = %x\n", __FUNCTION__, ptr->slots_at_66_conv);
+		debug ("%s - slots_at_66_pcix = %x\n", __FUNCTION__, ptr->slots_at_66_pcix);
+		debug ("%s - slots_at_100_pcix = %x\n", __FUNCTION__, ptr->slots_at_100_pcix);
+		debug ("%s - slots_at_133_pcix = %x\n", __FUNCTION__, ptr->slots_at_133_pcix);
+
 	}
 }
 
@@ -455,19 +460,9 @@
 				bus_info_ptr1->index = bus_index++;
 				bus_info_ptr1->current_speed = 0xff;
 				bus_info_ptr1->current_bus_mode = 0xff;
-				if ( ((slot_ptr->slot_cap) & EBDA_SLOT_133_MAX) == EBDA_SLOT_133_MAX )
-					bus_info_ptr1->supported_speed =  3;
-				else if ( ((slot_ptr->slot_cap) & EBDA_SLOT_100_MAX) == EBDA_SLOT_100_MAX )
-					bus_info_ptr1->supported_speed =  2;
-				else if ( ((slot_ptr->slot_cap) & EBDA_SLOT_66_MAX) == EBDA_SLOT_66_MAX )
-					bus_info_ptr1->supported_speed =  1;
+				
 				bus_info_ptr1->controller_id = hpc_ptr->ctlr_id;
-				if ( ((slot_ptr->slot_cap) & EBDA_SLOT_PCIX_CAP) == EBDA_SLOT_PCIX_CAP )
-					bus_info_ptr1->supported_bus_mode = 1;
-				else
-					bus_info_ptr1->supported_bus_mode =0;
-
-
+				
 				list_add_tail (&bus_info_ptr1->bus_info_list, &bus_info_head);
 
 			} else {
@@ -486,9 +481,25 @@
 		/* init bus structure */
 		bus_ptr = hpc_ptr->buses;
 		for (bus = 0; bus < bus_num; bus++) {
-			bus_ptr->bus_num = readb (io_mem + addr_bus);
+			bus_ptr->bus_num = readb (io_mem + addr_bus + bus);
+			bus_ptr->slots_at_33_conv = readb (io_mem + addr_bus + bus_num + 8 * bus);
+			bus_ptr->slots_at_66_conv = readb (io_mem + addr_bus + bus_num + 8 * bus + 1);
+
+			bus_ptr->slots_at_66_pcix = readb (io_mem + addr_bus + bus_num + 8 * bus + 2);
+
+			bus_ptr->slots_at_100_pcix = readb (io_mem + addr_bus + bus_num + 8 * bus + 3);
+
+			bus_ptr->slots_at_133_pcix = readb (io_mem + addr_bus + bus_num + 8 * bus + 4);
+
+			bus_info_ptr2 = ibmphp_find_same_bus_num (bus_ptr->bus_num);
+			if (bus_info_ptr2) {
+				bus_info_ptr2->slots_at_33_conv = bus_ptr->slots_at_33_conv;
+				bus_info_ptr2->slots_at_66_conv = bus_ptr->slots_at_66_conv;
+				bus_info_ptr2->slots_at_66_pcix = bus_ptr->slots_at_66_pcix;
+				bus_info_ptr2->slots_at_100_pcix = bus_ptr->slots_at_100_pcix;
+				bus_info_ptr2->slots_at_133_pcix = bus_ptr->slots_at_133_pcix; 
+			}
 			bus_ptr++;
-			addr_bus += 1;
 		}
 
 		hpc_ptr->ctlr_type = temp;
@@ -511,10 +522,6 @@
 			case 2:
 				hpc_ptr->u.wpeg_ctlr.wpegbbar = readl (io_mem + addr);
 				hpc_ptr->u.wpeg_ctlr.i2c_addr = readb (io_mem + addr + 4);
-				/* following 2 lines for testing purpose */
-				if (hpc_ptr->u.wpeg_ctlr.i2c_addr == 0) 
-					hpc_ptr->ctlr_type = 4;	
-				
 
 				hpc_ptr->irq = readb (io_mem + addr + 5);
 				addr += 6;
@@ -537,6 +544,8 @@
 
 		hpc_ptr->revision = 0xff;
 		hpc_ptr->options = 0xff;
+		hpc_ptr->starting_slot_num = hpc_ptr->slots[0].slot_num;
+		hpc_ptr->ending_slot_num = hpc_ptr->slots[slot_num-1].slot_num;
 
 		// register slots with hpc core as well as create linked list of ibm slot
 		for (index = 0; index < hpc_ptr->slot_count; index++) {
@@ -573,10 +582,24 @@
 				return -ENOMEM;
 			}
 
+
 			((struct slot *)hp_slot_ptr->private)->flag = TRUE;
 			snprintf (hp_slot_ptr->name, 10, "%d", hpc_ptr->slots[index].slot_num);
 
 			((struct slot *) hp_slot_ptr->private)->capabilities = hpc_ptr->slots[index].slot_cap;
+			if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_133_MAX) == EBDA_SLOT_133_MAX)
+				((struct slot *) hp_slot_ptr->private)->supported_speed =  3;
+			else if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_100_MAX) == EBDA_SLOT_100_MAX)
+				((struct slot *) hp_slot_ptr->private)->supported_speed =  2;
+			else if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_66_MAX) == EBDA_SLOT_66_MAX)
+				((struct slot *) hp_slot_ptr->private)->supported_speed =  1;
+				
+			if ((hpc_ptr->slots[index].slot_cap & EBDA_SLOT_PCIX_CAP) == EBDA_SLOT_PCIX_CAP)
+				((struct slot *) hp_slot_ptr->private)->supported_bus_mode = 1;
+			else
+				((struct slot *) hp_slot_ptr->private)->supported_bus_mode = 0;
+
+
 			((struct slot *) hp_slot_ptr->private)->bus = hpc_ptr->slots[index].slot_bus_num;
 
 			bus_info_ptr1 = ibmphp_find_same_bus_num (hpc_ptr->slots[index].slot_bus_num);
@@ -591,7 +614,7 @@
 
 			((struct slot *) hp_slot_ptr->private)->ctlr_index = hpc_ptr->slots[index].ctl_index;
 			((struct slot *) hp_slot_ptr->private)->number = hpc_ptr->slots[index].slot_num;
-
+			
 			((struct slot *) hp_slot_ptr->private)->hotplug_slot = hp_slot_ptr;
 
 			rc = ibmphp_hpc_fillhpslotinfo (hp_slot_ptr);
diff -Nru a/drivers/hotplug/ibmphp_hpc.c b/drivers/hotplug/ibmphp_hpc.c
--- a/drivers/hotplug/ibmphp_hpc.c	Tue Aug  6 12:10:48 2002
+++ b/drivers/hotplug/ibmphp_hpc.c	Tue Aug  6 12:10:48 2002
@@ -3,7 +3,7 @@
  *
  * Written By: Jyoti Shah, IBM Corporation
  *
- * Copyright (c) 2001,2001 IBM Corp.
+ * Copyright (c) 2001-2002 IBM Corp.
  *
  * All rights reserved.
  *
@@ -27,7 +27,6 @@
  *
  */
 
-//#include <linux/delay.h>
 #include <linux/wait.h>
 #include <linux/time.h>
 #include <linux/module.h>
@@ -35,9 +34,6 @@
 #include <linux/smp_lock.h>
 #include "ibmphp.h"
 
-#define POLL_NO		0x01
-#define POLL_YES	0x00
-
 static int to_debug = FALSE;
 #define debug_polling(fmt, arg...)	do { if (to_debug) debug (fmt, arg); } while (0)
 
@@ -83,10 +79,6 @@
 //
 //----------------------------------------------------------------------------
 #define WPG_I2C_IOREMAP_SIZE	0x2044	// size of linear address interval
-#define WPG_CTLR_MAX		0x01	// max controllers
-#define WPG_SLOT_MAX		0x06	// max slots
-#define WPG_CTLR_SLOT_MAX	0x06	// max slots per controller
-#define WPG_FIRST_CTLR		0x00	// index of the controller
 
 //----------------------------------------------------------------------------
 // command index
@@ -102,19 +94,15 @@
 // if bits 20,22,25,26,27,29,30 are OFF return TRUE
 #define HPC_I2CSTATUS_CHECK(s)	((u8)((s & 0x00000A76) ? FALSE : TRUE))
 
-// return code 0:poll slots, 1-POLL_LATCH_CNT:poll latch register
-#define INCREMENT_POLLCNT(i)	((i < POLL_LATCH_CNT) ? i++ : (i=0))
 //----------------------------------------------------------------------------
 // global variables
 //----------------------------------------------------------------------------
 static int ibmphp_shutdown;
 static int tid_poll;
-static int stop_polling;		// 2 values: poll, don't poll
 static struct semaphore sem_hpcaccess;	// lock access to HPC
 static struct semaphore semOperations;	// lock all operations and
 					// access to data structures
 static struct semaphore sem_exit;	// make sure polling thread goes away
-static struct semaphore sem_poll;	// make sure poll is idle 
 //----------------------------------------------------------------------------
 // local function prototypes
 //----------------------------------------------------------------------------
@@ -127,7 +115,7 @@
 static void poll_hpc (void);
 static int update_slot (struct slot *, u8);
 static int process_changeinstatus (struct slot *, struct slot *);
-static int process_changeinlatch (u8, u8);
+static int process_changeinlatch (u8, u8, struct controller *);
 static int hpc_poll_thread (void *);
 static int hpc_wait_ctlr_notworking (int, struct controller *, void *, u8 *);
 //----------------------------------------------------------------------------
@@ -145,8 +133,6 @@
 	init_MUTEX (&sem_hpcaccess);
 	init_MUTEX (&semOperations);
 	init_MUTEX_LOCKED (&sem_exit);
-	init_MUTEX_LOCKED (&sem_poll);
-	stop_polling = POLL_YES;
 	to_debug = FALSE;
 	ibmphp_shutdown = FALSE;
 	tid_poll = 0;
@@ -277,8 +263,7 @@
 	int i;
 
 
-	debug_polling ("%s - Entry WPGBbar[%lx] index[%x] cmd[%x]\n",
-		       __FUNCTION__, (ulong) WPGBbar, index, cmd);
+	debug_polling ("%s - Entry WPGBbar[%lx] index[%x] cmd[%x]\n", __FUNCTION__, (ulong) WPGBbar, index, cmd);
 
 	rc = 0;
 	//--------------------------------------------------------------------
@@ -470,8 +455,7 @@
 	int rc = 0;
 	int busindex;
 
-	debug_polling ("%s - Entry pslot[%lx] cmd[%x] pstatus[%lx]\n",
-		       __FUNCTION__, (ulong) pslot, cmd, (ulong) pstatus);
+	debug_polling ("%s - Entry pslot[%lx] cmd[%x] pstatus[%lx]\n", __FUNCTION__, (ulong) pslot, cmd, (ulong) pstatus);
 
 	if ((pslot == NULL)
 	    || ((pstatus == NULL) && (cmd != READ_ALLSTAT) && (cmd != READ_BUSSTATUS))) {
@@ -716,11 +700,6 @@
 void ibmphp_lock_operations (void)
 {
 	down (&semOperations);
-	stop_polling = POLL_NO;
-	to_debug = TRUE;
-
-	/* waiting for polling to actually stop */
-	down (&sem_poll);
 }
 
 /*----------------------------------------------------------------------
@@ -729,8 +708,6 @@
 void ibmphp_unlock_operations (void)
 {
 	debug ("%s - Entry\n", __FUNCTION__);
-	stop_polling = POLL_YES;
-	to_debug = FALSE;
 	up (&semOperations);
 	debug ("%s - Exit\n", __FUNCTION__);
 }
@@ -738,34 +715,30 @@
 /*----------------------------------------------------------------------
 * Name:    poll_hpc()
 *---------------------------------------------------------------------*/
+#define POLL_LATCH_REGISTER	0
+#define POLL_SLOTS		1
+#define POLL_SLEEP		2
 static void poll_hpc (void)
 {
-	struct slot myslot, *pslot = NULL;
+	struct slot myslot;
+	struct slot *pslot = NULL;
 	struct list_head *pslotlist;
 	int rc;
+	int poll_state = POLL_LATCH_REGISTER;
 	u8 oldlatchlow = 0x00;
 	u8 curlatchlow = 0x00;
-	int pollcnt = 0;
+	int poll_count = 0;
 	u8 ctrl_count = 0x00;
 
-	debug ("poll_hpc - Entry\n");
+	debug ("%s - Entry\n", __FUNCTION__);
 
 	while (!ibmphp_shutdown) {
-		if (stop_polling) {
-			debug ("poll_hpc - stop_polling\n");
-			up (&sem_poll); 
-			/* to prevent deadlock */
-			if (ibmphp_shutdown)
-				break;
-			/* to make the thread sleep */
-			down (&semOperations);
-			up (&semOperations);
-			debug ("poll_hpc - after stop_polling sleep\n");
-		} else {
-			if (pollcnt) {
-				// only poll the latch register
-				oldlatchlow = curlatchlow;
+		/* try to get the lock to do some kind of harware access */
+		down (&semOperations);
 
+		switch (poll_state) {
+			case POLL_LATCH_REGISTER:
+				oldlatchlow = curlatchlow;
 				ctrl_count = 0x00;
 				list_for_each (pslotlist, &ibmphp_slot_head) {
 					if (ctrl_count >= ibmphp_get_total_controllers())
@@ -779,14 +752,16 @@
 										  &curlatchlow);
 							if (oldlatchlow != curlatchlow)
 								process_changeinlatch (oldlatchlow,
-											curlatchlow);
+										       curlatchlow,
+										       pslot->ctrl);
 						}
 					}
 				}
-			} else {
+				poll_state = POLL_SLOTS;
+				break;
+
+			case POLL_SLOTS:
 				list_for_each (pslotlist, &ibmphp_slot_head) {
-					if (stop_polling)
-						break;
 					pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
 					// make a copy of the old status
 					memcpy ((void *) &myslot, (void *) pslot,
@@ -797,31 +772,45 @@
 						process_changeinstatus (pslot, &myslot);
 				}
 
-				if (!stop_polling) {
-					ctrl_count = 0x00;
-					list_for_each (pslotlist, &ibmphp_slot_head) {
-						if (ctrl_count >= ibmphp_get_total_controllers())
-							break;
-						pslot =
-						    list_entry (pslotlist, struct slot,
-								ibm_slot_list);
-						if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
-							ctrl_count++;
-							if (READ_SLOT_LATCH (pslot->ctrl))
-								rc = ibmphp_hpc_readslot (pslot,
-											  READ_SLOTLATCHLOWREG,
-											  &curlatchlow);
-						}
+				ctrl_count = 0x00;
+				list_for_each (pslotlist, &ibmphp_slot_head) {
+					if (ctrl_count >= ibmphp_get_total_controllers())
+						break;
+					pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
+					if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
+						ctrl_count++;
+						if (READ_SLOT_LATCH (pslot->ctrl))
+							rc = ibmphp_hpc_readslot (pslot,
+										  READ_SLOTLATCHLOWREG,
+										  &curlatchlow);
 					}
 				}
-			}
-			INCREMENT_POLLCNT (pollcnt);
-			long_delay (POLL_INTERVAL_SEC * HZ);	// snooze
+				++poll_count;
+				if (poll_count >= POLL_LATCH_CNT) {
+					poll_count = 0;
+					poll_state = POLL_SLEEP;
+				}
+				break;
+
+			case POLL_SLEEP:
+				/* don't sleep with a lock on the hardware */
+				up (&semOperations);
+				long_delay (POLL_INTERVAL_SEC * HZ);
+				down (&semOperations);
+				poll_state = POLL_LATCH_REGISTER;
+				break;
 		}
+
+		/* give up the harware semaphore */
+		up (&semOperations);
+
+		/* sleep for a short time just for good measure */
+		set_current_state (TASK_INTERRUPTIBLE);
+		schedule_timeout (HZ/10);
 	}
-	up (&sem_poll);
+
 	up (&sem_exit);
-	debug ("poll_hpc - Exit\n");
+	debug ("%s - Exit\n", __FUNCTION__);
 }
 
 
@@ -917,7 +906,6 @@
 
 	// bit 0 - HPC_SLOT_POWER
 	if ((pslot->status & 0x01) != (poldslot->status & 0x01))
-		/* ????????? DO WE NEED TO UPDATE BUS SPEED INFO HERE ??? */
 		update = TRUE;
 
 	// bit 1 - HPC_SLOT_CONNECT
@@ -936,7 +924,7 @@
 	// bit 5 - HPC_SLOT_PWRGD
 	if ((pslot->status & 0x20) != (poldslot->status & 0x20))
 		// OFF -> ON: ignore, ON -> OFF: disable slot
-		if (poldslot->status & 0x20)
+		if ((poldslot->status & 0x20) && (SLOT_CONNECT (poldslot->status) == HPC_SLOT_CONNECTED) && (SLOT_PRESENT (poldslot->status))) 
 			disable = TRUE;
 
 	// bit 6 - HPC_SLOT_BUS_SPEED
@@ -947,20 +935,20 @@
 		update = TRUE;
 		// OPEN -> CLOSE
 		if (pslot->status & 0x80) {
-			if (SLOT_POWER (pslot->status)) {
+			if (SLOT_PWRGD (pslot->status)) {
 				// power goes on and off after closing latch
 				// check again to make sure power is still ON
 				long_delay (1 * HZ);
 				rc = ibmphp_hpc_readslot (pslot, READ_SLOTSTATUS, &status);
-				if (SLOT_POWER (status))
+				if (SLOT_PWRGD (status))
 					update = TRUE;
 				else	// overwrite power in pslot to OFF
 					pslot->status &= ~HPC_SLOT_POWER;
 			}
 		}
 		// CLOSE -> OPEN 
-		else if ((SLOT_POWER (poldslot->status) == HPC_SLOT_POWER_ON)
-			|| (SLOT_CONNECT (poldslot->status) == HPC_SLOT_CONNECTED)) {
+		else if ((SLOT_PWRGD (poldslot->status) == HPC_SLOT_PWRGD_GOOD)
+			&& (SLOT_CONNECT (poldslot->status) == HPC_SLOT_CONNECTED) && (SLOT_PRESENT (poldslot->status))) {
 			disable = TRUE;
 		}
 		// else - ignore
@@ -994,7 +982,7 @@
 * Return   0 or error codes
 * Value:
 *---------------------------------------------------------------------*/
-static int process_changeinlatch (u8 old, u8 new)
+static int process_changeinlatch (u8 old, u8 new, struct controller *ctrl)
 {
 	struct slot myslot, *pslot;
 	u8 i;
@@ -1004,7 +992,7 @@
 	debug ("%s - Entry old[%x], new[%x]\n", __FUNCTION__, old, new);
 	// bit 0 reserved, 0 is LSB, check bit 1-6 for 6 slots
 
-	for (i = 1; i <= 6; i++) {
+	for (i = ctrl->starting_slot_num; i <= ctrl->ending_slot_num; i++) {
 		mask = 0x01 << i;
 		if ((mask & old) != (mask & new)) {
 			pslot = ibmphp_get_slot_from_physical_num (i);
@@ -1090,7 +1078,6 @@
 	// cleanup
 	free_hpc_access ();
 	ibmphp_unlock_operations ();
-	up (&sem_poll);
 	up (&sem_exit);
 
 	debug ("ibmphp_hpc_stop_poll_thread - Exit\n");
