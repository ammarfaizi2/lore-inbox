Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318952AbSIIWXP>; Mon, 9 Sep 2002 18:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSIIWXO>; Mon, 9 Sep 2002 18:23:14 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:19211 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318952AbSIIWUi>;
	Mon, 9 Sep 2002 18:20:38 -0400
Date: Mon, 9 Sep 2002 15:22:27 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.34
Message-ID: <20020909222226.GO7433@kroah.com>
References: <20020909221627.GE7433@kroah.com> <20020909221955.GG7433@kroah.com> <20020909222016.GH7433@kroah.com> <20020909222037.GI7433@kroah.com> <20020909222057.GJ7433@kroah.com> <20020909222112.GK7433@kroah.com> <20020909222128.GL7433@kroah.com> <20020909222142.GM7433@kroah.com> <20020909222201.GN7433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909222201.GN7433@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.632   -> 1.633  
#	drivers/hotplug/ibmphp_pci.c	1.2     -> 1.3    
#	drivers/hotplug/ibmphp.h	1.4     -> 1.5    
#	drivers/hotplug/ibmphp_core.c	1.10    -> 1.11   
#	drivers/hotplug/ibmphp_res.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	greg@kroah.com	1.633
# IBM PCI Hotplug driver: changed calls to pci_*_nodev() to pci_bus_*()
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp.h b/drivers/hotplug/ibmphp.h
--- a/drivers/hotplug/ibmphp.h	Mon Sep  9 15:09:26 2002
+++ b/drivers/hotplug/ibmphp.h	Mon Sep  9 15:09:26 2002
@@ -693,7 +693,7 @@
 #define PCIX66		0x05
 #define PCI66		0x04
 
-extern struct pci_ops *ibmphp_pci_root_ops;
+extern struct pci_bus *ibmphp_pci_bus;
 
 /* Variables */
 
@@ -764,7 +764,6 @@
 extern int ibmphp_update_slot_info (struct slot *);	/* This function is called from HPC, so we need it to not be be static */
 extern int ibmphp_configure_card (struct pci_func *, u8);
 extern int ibmphp_unconfigure_card (struct slot **, int);
-extern void ibmphp_increase_count (void);
 extern struct hotplug_slot_ops ibmphp_hotplug_slot_ops;
 
 static inline void long_delay (int delay)
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Mon Sep  9 15:09:26 2002
+++ b/drivers/hotplug/ibmphp_core.c	Mon Sep  9 15:09:26 2002
@@ -56,7 +56,7 @@
 MODULE_DESCRIPTION (DRIVER_DESC);
 
 static int *ops[MAX_OPS + 1];
-struct pci_ops *ibmphp_pci_root_ops;
+struct pci_bus *ibmphp_pci_bus;
 static int max_slots;
 
 static int irqs[16];    /* PIC mode IRQ's we're using so far (in case MPS tables don't provide default info for empty slots */
@@ -769,18 +769,6 @@
 	return NULL;
 }
 
-/******************************************************************
- * This function is here because we can no longer use pci_root_ops
- ******************************************************************/
-static struct pci_ops *get_root_pci_ops (void)
-{
-	struct pci_bus * bus;
-
-	if ((bus = find_bus (0)))
-		return bus->ops;
-	return NULL;
-}
-
 /*************************************************************
  * This routine frees up memory used by struct slot, including
  * the pointers to pci_func, bus, hotplug_slot, controller,
@@ -975,8 +963,8 @@
 	}
 
 	if (temp_func->dev) {
-		pci_proc_attach_device (temp_func->dev);
-		pci_announce_device_to_drivers (temp_func->dev);
+//		pci_proc_attach_device (temp_func->dev);
+//		pci_announce_device_to_drivers (temp_func->dev);
 	}
 
 	return 0;
@@ -995,22 +983,39 @@
 
 static u8 bus_structure_fixup (u8 busno)
 {
-	struct pci_bus bus_t;
-	struct pci_dev dev_t;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
 	u16 l;
 
 	if (!find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
 		return 1;
-	bus_t.number = busno;
-	bus_t.ops = ibmphp_pci_root_ops;
-	dev_t.bus = &bus_t;
-	for (dev_t.devfn=0; dev_t.devfn<256; dev_t.devfn += 8) {
-		if (!pci_read_config_word (&dev_t, PCI_VENDOR_ID, &l) &&  l != 0x0000 && l != 0xffff) {
+
+	bus = kmalloc (sizeof (*bus), GFP_KERNEL);
+	if (!bus) {
+		err ("%s - out of memory\n", __FUNCTION__);
+		return 1;
+	}
+	dev = kmalloc (sizeof (*dev), GFP_KERNEL);
+	if (!dev) {
+		kfree (bus);
+		err ("%s - out of memory\n", __FUNCTION__);
+		return 1;
+	}
+
+	bus->number = busno;
+	bus->ops = ibmphp_pci_bus->ops;
+	dev->bus = bus;
+	for (dev->devfn = 0; dev->devfn < 256; dev->devfn += 8) {
+		if (!pci_read_config_word (dev, PCI_VENDOR_ID, &l) &&  l != 0x0000 && l != 0xffff) {
 			debug ("%s - Inside bus_struture_fixup() \n", __FUNCTION__);
-			pci_scan_bus (busno, ibmphp_pci_root_ops, NULL);
+			pci_scan_bus (busno, ibmphp_pci_bus->ops, NULL);
 			break;
 		}
 	}
+
+	kfree (dev);
+	kfree (bus);
+
 	return 0;
 }
 
@@ -1602,6 +1607,7 @@
 
 static int __init ibmphp_init (void)
 {
+	struct pci_bus *bus;
 	int i = 0;
 	int rc = 0;
 
@@ -1609,11 +1615,18 @@
 
 	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
-	ibmphp_pci_root_ops = get_root_pci_ops ();
-	if (ibmphp_pci_root_ops == NULL) {
-		err ("cannot read bus operations... will not be able to read the cards.  Please check your system\n");
-		return -ENODEV;	
+	ibmphp_pci_bus = kmalloc (sizeof (*ibmphp_pci_bus), GFP_KERNEL);
+	if (!ibmphp_pci_bus) {
+		err ("out of memory\n");
+		return -ENOMEM;
+	}
+
+	bus = find_bus (0);
+	if (!bus) {
+		err ("Can't find the root pci bus, can not continue\n");
+		return -ENODEV;
 	}
+	memcpy (ibmphp_pci_bus, bus, sizeof (*ibmphp_pci_bus));
 
 	ibmphp_debug = debug;
 
diff -Nru a/drivers/hotplug/ibmphp_pci.c b/drivers/hotplug/ibmphp_pci.c
--- a/drivers/hotplug/ibmphp_pci.c	Mon Sep  9 15:09:25 2002
+++ b/drivers/hotplug/ibmphp_pci.c	Mon Sep  9 15:09:26 2002
@@ -104,11 +104,15 @@
 
 	/* For every function on the card */
 	for (function = 0x00; function < 0x08; function++) {
+		unsigned int devfn = PCI_DEVFN(device, function);
+		ibmphp_pci_bus->number = cur_func->busno;
+
 		cur_func->function = function;
 
-		debug ("inside the loop, cur_func->busno = %x, cur_func->device = %x, cur_func->funcion = %x\n", cur_func->busno, device, function);
+		debug ("inside the loop, cur_func->busno = %x, cur_func->device = %x, cur_func->funcion = %x\n",
+			cur_func->busno, cur_func->device, cur_func->function);
 
-		pci_read_config_word_nodev (ibmphp_pci_root_ops, cur_func->busno, device, function, PCI_VENDOR_ID, &vendor_id);
+		pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_VENDOR_ID, &vendor_id);
 
 		debug ("vendor_id is %x\n", vendor_id);
 		if (vendor_id != PCI_VENDOR_ID_NOTVALID) {
@@ -122,8 +126,8 @@
 			 *         |_=> 0 = single function device, 1 = multi-function device
 			 */
 
-			pci_read_config_byte_nodev (ibmphp_pci_root_ops, cur_func->busno, device, function, PCI_HEADER_TYPE, &hdr_type);
-			pci_read_config_dword_nodev (ibmphp_pci_root_ops, cur_func->busno, device, function, PCI_CLASS_REVISION, &class);
+			pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_HEADER_TYPE, &hdr_type);
+			pci_bus_read_config_dword (ibmphp_pci_bus, devfn, PCI_CLASS_REVISION, &class);
 
 			class_code = class >> 24;
 			debug ("hrd_type = %x, class = %x, class_code %x \n", hdr_type, class, class_code);
@@ -195,7 +199,7 @@
 						goto error;
 					}
 
-					pci_read_config_byte_nodev (ibmphp_pci_root_ops, cur_func->busno, device, function, PCI_SECONDARY_BUS, &sec_number);
+					pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SECONDARY_BUS, &sec_number);
 					flag = FALSE;
 					for (i = 0; i < 32; i++) {
 						if (func->devices[i]) {
@@ -267,8 +271,9 @@
 						cleanup_count = 2;
 						goto error;
 					}
-					debug ("cur_func->busno = %x, device = %x, function = %x\n", cur_func->busno, device, function);
-					pci_read_config_byte_nodev (ibmphp_pci_root_ops, cur_func->busno, device, function, PCI_SECONDARY_BUS, &sec_number);
+					debug ("cur_func->busno = %x, device = %x, function = %x\n",
+						cur_func->busno, device, function);
+					pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SECONDARY_BUS, &sec_number);
 					debug ("after configuring bridge..., sec_number = %x\n", sec_number);
 					flag = FALSE;
 					for (i = 0; i < 32; i++) {
@@ -361,13 +366,12 @@
 	struct resource_node *mem[6];
 	struct resource_node *mem_tmp;
 	struct resource_node *pfmem[6];
-	u8 device;
-	u8 function;
+	unsigned int devfn;
 
 	debug ("%s - inside\n", __FUNCTION__);
 
-	device = func->device;
-	function = func->function;
+	devfn = PCI_DEVFN(func->device, func->function);
+	ibmphp_pci_bus->number = func->busno;
 
 	for (count = 0; address[count]; count++) {	/* for 6 BARs */
 
@@ -384,8 +388,8 @@
 			pcibios_write_config_dword(cur_func->busno, cur_func->device, 
 			PCI_BASE_ADDRESS_0 + 4 * count, 0xFFFFFFFF);
 		 */
-		pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], 0xFFFFFFFF);
-		pci_read_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], &bar[count]);
+		pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0xFFFFFFFF);
+		pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &bar[count]);
 
 		if (!bar[count])	/* This BAR is not implemented */
 			continue;
@@ -421,11 +425,11 @@
 				kfree (io[count]);
 				return -EIO;
 			}
-			pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], func->io[count]->start);
+			pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], func->io[count]->start);
 	
 			/* _______________This is for debugging purposes only_____________________ */ 
 			debug ("b4 writing, the IO address is %x\n", func->io[count]->start);
-			pci_read_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], &bar[count]);
+			pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &bar[count]);
 			debug ("after writing.... the start address is %x\n", bar[count]);
 			/* _________________________________________________________________________*/
 
@@ -484,11 +488,11 @@
 					}
 				}
 
-				pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], func->pfmem[count]->start);
+				pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], func->pfmem[count]->start);
 
-				/*_______________This if for debugging purposes only______________________________*/				
+				/*_______________This is for debugging purposes only______________________________*/				
 				debug ("b4 writing, start addres is %x\n", func->pfmem[count]->start);
-				pci_read_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], &bar[count]);
+				pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &bar[count]);
 				debug ("after writing, start address is %x\n", bar[count]);
 				/*_________________________________________________________________________________*/
 
@@ -496,7 +500,7 @@
 					debug ("inside the mem 64 case, count %d\n", count);
 					count += 1;
 					/* on the 2nd dword, write all 0s, since we can't handle them n.e.ways */
-					pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], 0x00000000);
+					pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0x00000000);
 				}
 			} else {
 				/* regular memory */
@@ -526,10 +530,10 @@
 					kfree (mem[count]);
 					return -EIO;
 				}
-				pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], func->mem[count]->start);
+				pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], func->mem[count]->start);
 				/* _______________________This is for debugging purposes only _______________________*/
 				debug ("b4 writing, start address is %x\n", func->mem[count]->start);
-				pci_read_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], &bar[count]);
+				pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &bar[count]);
 				debug ("after writing, the address is %x\n", bar[count]);
 				/* __________________________________________________________________________________*/
 
@@ -538,22 +542,22 @@
 					debug ("inside mem 64 case, reg. mem, count %d\n", count);
 					count += 1;
 					/* on the 2nd dword, write all 0s, since we can't handle them n.e.ways */
-					pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], 0x00000000);
+					pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0x00000000);
 				}
 			}
 		}		/* end of mem */
 	}			/* end of for */
 
 	func->bus = 0;		/* To indicate that this is not a PPB */
-	pci_read_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_INTERRUPT_PIN, &irq);
+	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_INTERRUPT_PIN, &irq);
 	if ((irq > 0x00) && (irq < 0x05))
-		pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_INTERRUPT_LINE, func->irq[irq - 1]);
+		pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_INTERRUPT_LINE, func->irq[irq - 1]);
 
-	pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_CACHE_LINE_SIZE, CACHE);
-	pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_LATENCY_TIMER, LATENCY);
+	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_CACHE_LINE_SIZE, CACHE);
+	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_LATENCY_TIMER, LATENCY);
 
-	pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_ROM_ADDRESS, 0x00L);
-	pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_COMMAND, DEVICEENABLE);
+	pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_ROM_ADDRESS, 0x00L);
+	pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_COMMAND, DEVICEENABLE);
 
 	return 0;
 }
@@ -593,24 +597,23 @@
 		0
 	};
 	struct pci_func *func = *func_passed;
-	u8 function;
-	u8 device;
+	unsigned int devfn;
 	u8 irq;
 	int retval;
 
 	debug ("%s - enter\n", __FUNCTION__);
 
-	function = func->function;
-	device = func->device;
+	devfn = PCI_DEVFN(func->function, func->device);
+	ibmphp_pci_bus->number = func->busno;
 
 	/* Configuring necessary info for the bridge so that we could see the devices
 	 * behind it
 	 */
 
-	pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PRIMARY_BUS, func->busno);
+	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_PRIMARY_BUS, func->busno);
 
 	/* _____________________For debugging purposes only __________________________
-	pci_read_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PRIMARY_BUS, &pri_number);
+	pci_bus_config_byte (ibmphp_pci_bus, devfn, PCI_PRIMARY_BUS, &pri_number);
 	debug ("primary # written into the bridge is %x\n", pri_number);
 	 ___________________________________________________________________________*/
 
@@ -624,23 +627,23 @@
 	debug ("after find_sec_number, the number we got is %x\n", sec_number);
 	debug ("AFTER FIND_SEC_NUMBER, func->busno IS %x\n", func->busno);
 
-	pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_SECONDARY_BUS, sec_number);
+	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_SECONDARY_BUS, sec_number);
 	
 	/* __________________For debugging purposes only __________________________________
-	pci_read_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_SECONDARY_BUS, &sec_number);
+	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SECONDARY_BUS, &sec_number);
 	debug ("sec_number after write/read is %x\n", sec_number);
 	 ________________________________________________________________________________*/
 
-	pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_SUBORDINATE_BUS, sec_number);
+	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_SUBORDINATE_BUS, sec_number);
 
 	/* __________________For debugging purposes only ____________________________________
-	pci_read_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_SUBORDINATE_BUS, &sec_number);
+	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SUBORDINATE_BUS, &sec_number);
 	debug ("subordinate number after write/read is %x\n", sec_number);
 	 __________________________________________________________________________________*/
 
-	pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_CACHE_LINE_SIZE, CACHE);
-	pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_LATENCY_TIMER, LATENCY);
-	pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_SEC_LATENCY_TIMER, LATENCY);
+	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_CACHE_LINE_SIZE, CACHE);
+	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_LATENCY_TIMER, LATENCY);
+	pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_SEC_LATENCY_TIMER, LATENCY);
 
 	debug ("func->busno is %x\n", func->busno);
 	debug ("sec_number after writing is %x\n", sec_number);
@@ -653,8 +656,8 @@
 
 	/* First we need to allocate mem/io for the bridge itself in case it needs it */
 	for (count = 0; address[count]; count++) {	/* for 2 BARs */
-		pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], 0xFFFFFFFF);
-		pci_read_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], &bar[count]);
+		pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0xFFFFFFFF);
+		pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &bar[count]);
 
 		if (!bar[count]) {
 			/* This BAR is not implemented */
@@ -694,7 +697,7 @@
 				return -EIO;
 			}
 
-			pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], func->io[count]->start);
+			pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], func->io[count]->start);
 
 		} else {
 			/* This is Memory */
@@ -747,13 +750,13 @@
 					}
 				}
 
-				pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], func->pfmem[count]->start);
+				pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], func->pfmem[count]->start);
 
 				if (bar[count] & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
 					count += 1;
 					/* on the 2nd dword, write all 0s, since we can't handle them n.e.ways */
-					pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], 0x00000000);
+					pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0x00000000);
 
 				}
 			} else {
@@ -784,13 +787,13 @@
 					return -EIO;
 				}
 
-				pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], func->mem[count]->start);
+				pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], func->mem[count]->start);
 
 				if (bar[count] & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
 					count += 1;
 					/* on the 2nd dword, write all 0s, since we can't handle them n.e.ways */
-					pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, address[count], 0x00000000);
+					pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0x00000000);
 
 				}
 			}
@@ -802,6 +805,7 @@
 	if (amount_needed == NULL)
 		return -ENOMEM;
 
+	ibmphp_pci_bus->number = func->busno;
 	debug ("after coming back from scan_behind_bridge\n");
 	debug ("amount_needed->not_correct = %x\n", amount_needed->not_correct);
 	debug ("amount_needed->io = %x\n", amount_needed->io);
@@ -952,8 +956,8 @@
 			retval = rc;
 			goto error;
 		}
-		pci_read_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_BASE, &io_base);
-		pci_read_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_MEMORY_BASE, &pfmem_base);
+		pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_IO_BASE, &io_base);
+		pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_BASE, &pfmem_base);
 
 		if ((io_base & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
 			debug ("io 32\n");
@@ -965,73 +969,73 @@
 		}
 
 		if (bus->noIORanges) {
-			pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_BASE, 0x00 | bus->rangeIO->start >> 8);
-			pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_LIMIT, 0x00 | bus->rangeIO->end >> 8);	
+			pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_IO_BASE, 0x00 | bus->rangeIO->start >> 8);
+			pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_IO_LIMIT, 0x00 | bus->rangeIO->end >> 8);	
 
 			/* _______________This is for debugging purposes only ____________________
-			pci_read_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_BASE, &temp);
+			pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_IO_BASE, &temp);
 			debug ("io_base = %x\n", (temp & PCI_IO_RANGE_TYPE_MASK) << 8);
-			pci_read_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_LIMIT, &temp);
+			pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_IO_LIMIT, &temp);
 			debug ("io_limit = %x\n", (temp & PCI_IO_RANGE_TYPE_MASK) << 8);
 			 ________________________________________________________________________*/
 
 			if (need_io_upper) {	/* since can't support n.e.ways */
-				pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_BASE_UPPER16, 0x0000);
-				pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_LIMIT_UPPER16, 0x0000);
+				pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_IO_BASE_UPPER16, 0x0000);
+				pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_IO_LIMIT_UPPER16, 0x0000);
 			}
 		} else {
-			pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_BASE, 0x00);
-			pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_IO_LIMIT, 0x00);
+			pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_IO_BASE, 0x00);
+			pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_IO_LIMIT, 0x00);
 		}
 
 		if (bus->noMemRanges) {
-			pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_MEMORY_BASE, 0x0000 | bus->rangeMem->start >> 16);
-			pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_MEMORY_LIMIT, 0x0000 | bus->rangeMem->end >> 16);
+			pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_MEMORY_BASE, 0x0000 | bus->rangeMem->start >> 16);
+			pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_MEMORY_LIMIT, 0x0000 | bus->rangeMem->end >> 16);
 			
 			/* ____________________This is for debugging purposes only ________________________
-			pci_read_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_MEMORY_BASE, &temp);
+			pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_MEMORY_BASE, &temp);
 			debug ("mem_base = %x\n", (temp & PCI_MEMORY_RANGE_TYPE_MASK) << 16);
-			pci_read_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_MEMORY_LIMIT, &temp);
+			pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_MEMORY_LIMIT, &temp);
 			debug ("mem_limit = %x\n", (temp & PCI_MEMORY_RANGE_TYPE_MASK) << 16);
 			 __________________________________________________________________________________*/
 
 		} else {
-			pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_MEMORY_BASE, 0xffff);
-			pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_MEMORY_LIMIT, 0x0000);
+			pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_MEMORY_BASE, 0xffff);
+			pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_MEMORY_LIMIT, 0x0000);
 		}
 		if (bus->noPFMemRanges) {
-			pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_MEMORY_BASE, 0x0000 | bus->rangePFMem->start >> 16);
-			pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_MEMORY_LIMIT, 0x0000 | bus->rangePFMem->end >> 16);
+			pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_BASE, 0x0000 | bus->rangePFMem->start >> 16);
+			pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, 0x0000 | bus->rangePFMem->end >> 16);
 
 			/* __________________________This is for debugging purposes only _______________________
-			pci_read_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_MEMORY_BASE, &temp);
+			pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_BASE, &temp);
 			debug ("pfmem_base = %x", (temp & PCI_MEMORY_RANGE_TYPE_MASK) << 16);
-			pci_read_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_MEMORY_LIMIT, &temp);
+			pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, &temp);
 			debug ("pfmem_limit = %x\n", (temp & PCI_MEMORY_RANGE_TYPE_MASK) << 16);
 			 ______________________________________________________________________________________*/
 
 			if (need_pfmem_upper) {	/* since can't support n.e.ways */
-				pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_BASE_UPPER32, 0x00000000);
-				pci_write_config_dword_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_LIMIT_UPPER32, 0x00000000);
+				pci_bus_write_config_dword (ibmphp_pci_bus, devfn, PCI_PREF_BASE_UPPER32, 0x00000000);
+				pci_bus_write_config_dword (ibmphp_pci_bus, devfn, PCI_PREF_LIMIT_UPPER32, 0x00000000);
 			}
 		} else {
-			pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_MEMORY_BASE, 0xffff);
-			pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_PREF_MEMORY_LIMIT, 0x0000);
+			pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_BASE, 0xffff);
+			pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, 0x0000);
 		}
 
 		debug ("b4 writing control information\n");
 
-		pci_read_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_INTERRUPT_PIN, &irq);
+		pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_INTERRUPT_PIN, &irq);
 		if ((irq > 0x00) && (irq < 0x05))
-			pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_INTERRUPT_LINE, func->irq[irq - 1]);
+			pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_INTERRUPT_LINE, func->irq[irq - 1]);
 		/*    
-		pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_BRIDGE_CONTROL, ctrl);
-		pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_PARITY);
-		pci_write_config_byte_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
+		pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_BRIDGE_CONTROL, ctrl);
+		pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_PARITY);
+		pci_bus_write_config_byte (ibmphp_pci_bus, devfn, PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
 		 */
 
-		pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_COMMAND, DEVICEENABLE);
-		pci_write_config_word_nodev (ibmphp_pci_root_ops, func->busno, device, function, PCI_BRIDGE_CONTROL, 0x07);
+		pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_COMMAND, DEVICEENABLE);
+		pci_bus_write_config_word (ibmphp_pci_bus, devfn, PCI_BRIDGE_CONTROL, 0x07);
 		for (i = 0; i < 32; i++) {
 			if (amount_needed->devices[i]) {
 				debug ("device where devices[i] is 1 = %x\n", i);
@@ -1087,6 +1091,7 @@
 	u16 vendor_id;
 	u8 hdr_type;
 	u8 device, function;
+	unsigned int devfn;
 	int howmany = 0;	/*this is to see if there are any devices behind the bridge */
 
 	u32 bar[6], class;
@@ -1106,20 +1111,23 @@
 		return NULL;
 	memset (amount, 0, sizeof (struct res_needed));
 
+	ibmphp_pci_bus->number = busno;
+
 	debug ("the bus_no behind the bridge is %x\n", busno);
 	debug ("scanning devices behind the bridge...\n");
 	for (device = 0; device < 32; device++) {
 		amount->devices[device] = 0;
 		for (function = 0; function < 8; function++) {
+			devfn = PCI_DEVFN(device, function);
 
-			pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_VENDOR_ID, &vendor_id);
+			pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_VENDOR_ID, &vendor_id);
 
 			if (vendor_id != PCI_VENDOR_ID_NOTVALID) {
 				/* found correct device!!! */
 				howmany++;
 
-				pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_HEADER_TYPE, &hdr_type);
-				pci_read_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_CLASS_REVISION, &class);
+				pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_HEADER_TYPE, &hdr_type);
+				pci_bus_read_config_dword (ibmphp_pci_bus, devfn, PCI_CLASS_REVISION, &class);
 
 				debug ("hdr_type behind the bridge is %x\n", hdr_type);
 				if (hdr_type & PCI_HEADER_TYPE_BRIDGE) {
@@ -1146,14 +1154,14 @@
 				for (count = 0; address[count]; count++) {
 					/* for 6 BARs */
 					/*
-					pci_read_config_byte_nodev(ibmphp_pci_root_ops, busno, device, function, address[count], &tmp);
+					pci_bus_read_config_byte (ibmphp_pci_bus, devfn, address[count], &tmp);
 					if (tmp & 0x01) // IO
-						pci_write_config_dword_nodev(ibmphp_pci_root_ops, busno, device, function, address[count], 0xFFFFFFFD);
+						pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0xFFFFFFFD);
 					else // MEMORY
-						pci_write_config_dword_nodev(ibmphp_pci_root_ops, busno, device, function, address[count], 0xFFFFFFFF);
+						pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0xFFFFFFFF);
 					*/
-					pci_write_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, address[count], 0xFFFFFFFF);
-					pci_read_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, address[count], &bar[count]);
+					pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0xFFFFFFFF);
+					pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &bar[count]);
 
 					debug ("what is bar[count]? %x, count = %d\n", bar[count], count);
 
@@ -1237,6 +1245,7 @@
 	u32 temp_end;
 	u32 size;
 	u32 tmp_address;
+	unsigned int devfn;
 
 	debug ("%s - enter\n", __FUNCTION__);
 
@@ -1246,14 +1255,16 @@
 		return -EINVAL;
 	}
 
+	devfn = PCI_DEVFN(device, function);
+	ibmphp_pci_bus->number = busno;
 	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_read_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, address[count], &start_address);
+		pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &start_address);
 
 		/* We can do this here, b/c by that time the device driver of the card has been stopped */
 
-		pci_write_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, address[count], 0xFFFFFFFF);
-		pci_read_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, address[count], &size);
-		pci_write_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, address[count], start_address);
+		pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], 0xFFFFFFFF);
+		pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &size);
+		pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], start_address);
 
 		debug ("start_address is %x\n", start_address);
 		debug ("busno, device, function %x %x %x\n", busno, device, function);
@@ -1350,13 +1361,16 @@
 		PCI_BASE_ADDRESS_1,
 		0
 	};
+	unsigned int devfn;
 
+	devfn = PCI_DEVFN(device, function);
+	ibmphp_pci_bus->number = busno;
 	bus_no = (int) busno;
 	debug ("busno is %x\n", busno);
-	pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_PRIMARY_BUS, &pri_number);
+	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_PRIMARY_BUS, &pri_number);
 	debug ("%s - busno = %x, primary_number = %x\n", __FUNCTION__, busno, pri_number);
 
-	pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_SECONDARY_BUS, &sec_number);
+	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SECONDARY_BUS, &sec_number);
 	debug ("sec_number is %x\n", sec_number);
 	sec_no = (int) sec_number;
 	pri_no = (int) pri_number;
@@ -1365,10 +1379,10 @@
 		return -EINVAL;
 	}
 
-	pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_SECONDARY_BUS, &sec_number);
+	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SECONDARY_BUS, &sec_number);
 	sec_no = (int) sec_no;
 
-	pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_SUBORDINATE_BUS, &sub_number);
+	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SUBORDINATE_BUS, &sub_number);
 	sub_no = (int) sub_number;
 	debug ("sub_no is %d, sec_no is %d\n", sub_no, sec_no);
 	if (sec_no != sub_number) {
@@ -1388,7 +1402,7 @@
 
 	for (count = 0; address[count]; count++) {
 		/* for 2 BARs */
-		pci_read_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, address[count], &start_address);
+		pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &start_address);
 
 		if (!start_address) {
 			/* This BAR is not implemented */
@@ -1461,6 +1475,7 @@
 	u8 busno;
 	u8 function;
 	int rc;
+	unsigned int devfn;
 	u8 valid_device = 0x00; /* To see if we are ever able to find valid device and read it */
 
 	debug ("%s - enter\n", __FUNCTION__);
@@ -1471,8 +1486,10 @@
 	debug ("b4 for loop, device is %x\n", device);
 	/* For every function on the card */
 	for (function = 0x0; function < 0x08; function++) {
+		devfn = PCI_DEVFN(device, function);
+		ibmphp_pci_bus->number = busno;
 
-		pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_VENDOR_ID, &vendor_id);
+		pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_VENDOR_ID, &vendor_id);
 
 		if (vendor_id != PCI_VENDOR_ID_NOTVALID) {
 			/* found correct device!!! */
@@ -1485,8 +1502,8 @@
 			 *         |_=> 0 = single function device, 1 = multi-function device
 			 */
 
-			pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_HEADER_TYPE, &hdr_type);
-			pci_read_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_CLASS_REVISION, &class);
+			pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_HEADER_TYPE, &hdr_type);
+			pci_bus_read_config_dword (ibmphp_pci_bus, devfn, PCI_CLASS_REVISION, &class);
 
 			debug ("hdr_type %x, class %x\n", hdr_type, class);
 			class >>= 8;	/* to take revision out, class = class.subclass.prog i/f */
diff -Nru a/drivers/hotplug/ibmphp_res.c b/drivers/hotplug/ibmphp_res.c
--- a/drivers/hotplug/ibmphp_res.c	Mon Sep  9 15:09:26 2002
+++ b/drivers/hotplug/ibmphp_res.c	Mon Sep  9 15:09:26 2002
@@ -1932,7 +1932,7 @@
  */
 static int __init update_bridge_ranges (struct bus_node **bus)
 {
-	u8 sec_busno, device, function, busno, hdr_type, start_io_address, end_io_address;
+	u8 sec_busno, device, function, hdr_type, start_io_address, end_io_address;
 	u16 vendor_id, upper_io_start, upper_io_end, start_mem_address, end_mem_address;
 	u32 start_address, end_address, upper_start, upper_end;
 	struct bus_node *bus_sec;
@@ -1941,21 +1941,24 @@
 	struct resource_node *mem;
 	struct resource_node *pfmem;
 	struct range_node *range;
+	unsigned int devfn;
+
 	bus_cur = *bus;
 	if (!bus_cur)
 		return -ENODEV;
-	busno = bus_cur->busno;
+	ibmphp_pci_bus->number = bus_cur->busno;
 
 	debug ("inside %s \n", __FUNCTION__);
 	debug ("bus_cur->busno = %x\n", bus_cur->busno);
 
 	for (device = 0; device < 32; device++) {
 		for (function = 0x00; function < 0x08; function++) {
-			pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_VENDOR_ID, &vendor_id);
+			devfn = PCI_DEVFN(device, function);
+			pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_VENDOR_ID, &vendor_id);
 
 			if (vendor_id != PCI_VENDOR_ID_NOTVALID) {
 				/* found correct device!!! */
-				pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_HEADER_TYPE, &hdr_type);
+				pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_HEADER_TYPE, &hdr_type);
 
 				switch (hdr_type) {
 					case PCI_HEADER_TYPE_NORMAL:
@@ -1974,7 +1977,7 @@
 						   temp++;
 						   }
 						 */
-						pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_SECONDARY_BUS, &sec_busno);
+						pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SECONDARY_BUS, &sec_busno);
 						bus_sec = find_bus_wprev (sec_busno, NULL, 0); 
 						/* this bus structure doesn't exist yet, PPB was configured during previous loading of ibmphp */
 						if (!bus_sec) {
@@ -1982,10 +1985,10 @@
 							/* the rest will be populated during NVRAM call */
 							return 0;
 						}
-						pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_IO_BASE, &start_io_address);
-						pci_read_config_byte_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_IO_LIMIT, &end_io_address);
-						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_IO_BASE_UPPER16, &upper_io_start);
-						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_IO_LIMIT_UPPER16, &upper_io_end);
+						pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_IO_BASE, &start_io_address);
+						pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_IO_LIMIT, &end_io_address);
+						pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_IO_BASE_UPPER16, &upper_io_start);
+						pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_IO_LIMIT_UPPER16, &upper_io_end);
 						start_address = (start_io_address & PCI_IO_RANGE_MASK) << 8;
 						start_address |= (upper_io_start << 16);
 						end_address = (end_io_address & PCI_IO_RANGE_MASK) << 8;
@@ -2035,8 +2038,8 @@
 							}
 						}	
 
-						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_MEMORY_BASE, &start_mem_address);
-						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_MEMORY_LIMIT, &end_mem_address);
+						pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_MEMORY_BASE, &start_mem_address);
+						pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_MEMORY_LIMIT, &end_mem_address);
 
 						start_address = 0x00000000 | (start_mem_address & PCI_MEMORY_RANGE_MASK) << 16;
 						end_address = 0x00000000 | (end_mem_address & PCI_MEMORY_RANGE_MASK) << 16;
@@ -2086,10 +2089,10 @@
 								ibmphp_add_resource (mem);
 							}
 						}
-						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_PREF_MEMORY_BASE, &start_mem_address);
-						pci_read_config_word_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_PREF_MEMORY_LIMIT, &end_mem_address);
-						pci_read_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_PREF_BASE_UPPER32, &upper_start);
-						pci_read_config_dword_nodev (ibmphp_pci_root_ops, busno, device, function, PCI_PREF_LIMIT_UPPER32, &upper_end);
+						pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_BASE, &start_mem_address);
+						pci_bus_read_config_word (ibmphp_pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, &end_mem_address);
+						pci_bus_read_config_dword (ibmphp_pci_bus, devfn, PCI_PREF_BASE_UPPER32, &upper_start);
+						pci_bus_read_config_dword (ibmphp_pci_bus, devfn, PCI_PREF_LIMIT_UPPER32, &upper_end);
 						start_address = 0x00000000 | (start_mem_address & PCI_MEMORY_RANGE_MASK) << 16;
 						end_address = 0x00000000 | (end_mem_address & PCI_MEMORY_RANGE_MASK) << 16;
 #if BITS_PER_LONG == 64
