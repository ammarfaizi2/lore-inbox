Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUJ1Qoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUJ1Qoi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUJ1Qoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:44:38 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:28642 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261723AbUJ1QnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:43:00 -0400
Date: Fri, 29 Oct 2004 02:42:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] ppc64 iSeries pci cleanups
Message-Id: <20041029024251.4cf06de2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__29_Oct_2004_02_42_51_+1000_AO0EqMx2dw6GZa.c"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__29_Oct_2004_02_42_51_+1000_AO0EqMx2dw6GZa.c
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch removes two files (iSeries_IoMmTable.[ch]) by merging them into
iSeries_pci.c.  This allowed quite a few more things to become declared
static.  It then does some fairly mechanical cleanups in iSeries_pci.c
(replacing studly caps, removing the last of the PCIFR() macros and
removing a couple of empty or unused routines).  There are no semantic
changes.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Please apply and send to Linus.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/Makefile 2.6.10-rc1-bk6-cleanup.1/arch/ppc64/kernel/Makefile
--- 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/Makefile	2004-10-28 14:18:05.000000000 +1000
+++ 2.6.10-rc1-bk6-cleanup.1/arch/ppc64/kernel/Makefile	2004-10-28 14:50:05.000000000 +1000
@@ -15,8 +15,7 @@
 
 obj-$(CONFIG_PPC_OF) +=	of_device.o
 
-pci-obj-$(CONFIG_PPC_ISERIES)	+= iSeries_pci.o iSeries_pci_reset.o \
-				     iSeries_IoMmTable.o
+pci-obj-$(CONFIG_PPC_ISERIES)	+= iSeries_pci.o iSeries_pci_reset.o
 pci-obj-$(CONFIG_PPC_MULTIPLATFORM)	+= pci_dn.o pci_dma_direct.o
 
 obj-$(CONFIG_PCI)	+= pci.o pci_iommu.o iomap.o $(pci-obj-y)
diff -ruN 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/iSeries_IoMmTable.c 2.6.10-rc1-bk6-cleanup.1/arch/ppc64/kernel/iSeries_IoMmTable.c
--- 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/iSeries_IoMmTable.c	2004-02-04 17:24:34.000000000 +1100
+++ 2.6.10-rc1-bk6-cleanup.1/arch/ppc64/kernel/iSeries_IoMmTable.c	1970-01-01 10:00:00.000000000 +1000
@@ -1,169 +0,0 @@
-#define PCIFR(...)
-/************************************************************************/
-/* This module supports the iSeries I/O Address translation mapping     */
-/* Copyright (C) 20yy  <Allan H Trautman> <IBM Corp>                    */
-/*                                                                      */
-/* This program is free software; you can redistribute it and/or modify */
-/* it under the terms of the GNU General Public License as published by */
-/* the Free Software Foundation; either version 2 of the License, or    */
-/* (at your option) any later version.                                  */
-/*                                                                      */
-/* This program is distributed in the hope that it will be useful,      */ 
-/* but WITHOUT ANY WARRANTY; without even the implied warranty of       */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        */
-/* GNU General Public License for more details.                         */
-/*                                                                      */
-/* You should have received a copy of the GNU General Public License    */ 
-/* along with this program; if not, write to the:                       */
-/* Free Software Foundation, Inc.,                                      */ 
-/* 59 Temple Place, Suite 330,                                          */ 
-/* Boston, MA  02111-1307  USA                                          */
-/************************************************************************/
-/* Change Activity:                                                     */
-/*   Created, December 14, 2000                                         */
-/*   Added Bar table for IoMm performance.                              */
-/*   Ported to ppc64                                                    */
-/*   Added dynamic table allocation                                     */
-/* End Change Activity                                                  */
-/************************************************************************/
-#include <asm/types.h>
-#include <asm/resource.h>
-#include <linux/pci.h>
-#include <linux/spinlock.h>
-#include <asm/ppcdebug.h>
-#include <asm/iSeries/HvCallPci.h>
-#include <asm/iSeries/iSeries_pci.h>
-
-#include "iSeries_IoMmTable.h"
-#include "pci.h"
-
-/*
- * Table defines
- * Each Entry size is 4 MB * 1024 Entries = 4GB I/O address space.
- */
-#define Max_Entries 1024
-unsigned long iSeries_IoMmTable_Entry_Size = 0x0000000000400000; 
-unsigned long iSeries_Base_Io_Memory       = 0xE000000000000000;
-unsigned long iSeries_Max_Io_Memory        = 0xE000000000000000;
-static   long iSeries_CurrentIndex         = 0;
-
-/*
- * Lookup Tables.
- */
-struct iSeries_Device_Node **iSeries_IoMmTable;
-u8 *iSeries_IoBarTable;
-
-/*
- * Static and Global variables
- */
-static char *iSeriesPciIoText = "iSeries PCI I/O";
-static spinlock_t iSeriesIoMmTableLock = SPIN_LOCK_UNLOCKED;
-
-/*
- * iSeries_IoMmTable_Initialize
- *
- * Allocates and initalizes the Address Translation Table and Bar
- * Tables to get them ready for use.  Must be called before any
- * I/O space is handed out to the device BARs.
- * A follow up method,iSeries_IoMmTable_Status can be called to
- * adjust the table after the device BARs have been assiged to
- * resize the table.
- */
-void iSeries_IoMmTable_Initialize(void)
-{
-	spin_lock(&iSeriesIoMmTableLock);
-	iSeries_IoMmTable  = kmalloc(sizeof(void *) * Max_Entries, GFP_KERNEL);
-	iSeries_IoBarTable = kmalloc(sizeof(u8) * Max_Entries, GFP_KERNEL);
-	spin_unlock(&iSeriesIoMmTableLock);
-	PCIFR("IoMmTable Initialized 0x%p", iSeries_IoMmTable);
-	if ((iSeries_IoMmTable == NULL) || (iSeries_IoBarTable == NULL))
-		panic("PCI: I/O tables allocation failed.\n");
-}
-
-/*
- * iSeries_IoMmTable_AllocateEntry
- *
- * Adds pci_dev entry in address translation table
- *
- * - Allocates the number of entries required in table base on BAR
- *   size.
- * - Allocates starting at iSeries_Base_Io_Memory and increases.
- * - The size is round up to be a multiple of entry size.
- * - CurrentIndex is incremented to keep track of the last entry.
- * - Builds the resource entry for allocated BARs.
- */
-static void iSeries_IoMmTable_AllocateEntry(struct pci_dev *PciDev,
-		int BarNumber)
-{
-	struct resource *BarResource = &PciDev->resource[BarNumber];
-	long BarSize = pci_resource_len(PciDev, BarNumber);
-
-	/*
-	 * No space to allocate, quick exit, skip Allocation.
-	 */
-	if (BarSize == 0)
-		return;
-	/*
-	 * Set Resource values.
-	 */
-	spin_lock(&iSeriesIoMmTableLock);
-	BarResource->name = iSeriesPciIoText;
-	BarResource->start =
-		iSeries_IoMmTable_Entry_Size * iSeries_CurrentIndex;
-	BarResource->start += iSeries_Base_Io_Memory;
-	BarResource->end = BarResource->start+BarSize-1;
-	/*
-	 * Allocate the number of table entries needed for BAR.
-	 */
-	while (BarSize > 0 ) {
-		*(iSeries_IoMmTable + iSeries_CurrentIndex) =
-			(struct iSeries_Device_Node *)PciDev->sysdata;
-		*(iSeries_IoBarTable + iSeries_CurrentIndex) = BarNumber;
-		BarSize -= iSeries_IoMmTable_Entry_Size;
-		++iSeries_CurrentIndex;
-	}
-	iSeries_Max_Io_Memory = iSeries_Base_Io_Memory +
-		(iSeries_IoMmTable_Entry_Size * iSeries_CurrentIndex);
-	spin_unlock(&iSeriesIoMmTableLock);
-}
-
-/*
- * iSeries_allocateDeviceBars
- *
- * - Allocates ALL pci_dev BAR's and updates the resources with the
- *   BAR value.  BARS with zero length will have the resources
- *   The HvCallPci_getBarParms is used to get the size of the BAR
- *   space.  It calls iSeries_IoMmTable_AllocateEntry to allocate
- *   each entry.
- * - Loops through The Bar resources(0 - 5) including the ROM
- *   is resource(6).
- */
-void iSeries_allocateDeviceBars(struct pci_dev *PciDev)
-{
-	struct resource *BarResource;
-	int BarNumber;
-
-	for (BarNumber = 0; BarNumber <= PCI_ROM_RESOURCE; ++BarNumber) {
-		BarResource = &PciDev->resource[BarNumber];
-		iSeries_IoMmTable_AllocateEntry(PciDev, BarNumber);
-    	}
-}
-
-/*
- * Translates the IoAddress to the device that is mapped to IoSpace.
- * This code is inlined, see the iSeries_pci.c file for the replacement.
- */
-struct iSeries_Device_Node *iSeries_xlateIoMmAddress(void *IoAddress)
-{
-	return NULL;	   
-}
-
-/*
- * Status hook for IoMmTable
- */
-void iSeries_IoMmTable_Status(void)
-{
-	PCIFR("IoMmTable......: 0x%p", iSeries_IoMmTable);
-	PCIFR("IoMmTable Range: 0x%p to 0x%p", iSeries_Base_Io_Memory,
-			iSeries_Max_Io_Memory);
-}
diff -ruN 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/iSeries_IoMmTable.h 2.6.10-rc1-bk6-cleanup.1/arch/ppc64/kernel/iSeries_IoMmTable.h
--- 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/iSeries_IoMmTable.h	2004-02-04 17:24:34.000000000 +1100
+++ 2.6.10-rc1-bk6-cleanup.1/arch/ppc64/kernel/iSeries_IoMmTable.h	1970-01-01 10:00:00.000000000 +1000
@@ -1,85 +0,0 @@
-#ifndef _ISERIES_IOMMTABLE_H
-#define _ISERIES_IOMMTABLE_H
-/************************************************************************/
-/* File iSeries_IoMmTable.h created by Allan Trautman on Dec 12 2001.   */
-/************************************************************************/
-/* Interfaces for the write/read Io address translation table.          */
-/* Copyright (C) 20yy  Allan H Trautman, IBM Corporation                */
-/*                                                                      */
-/* This program is free software; you can redistribute it and/or modify */
-/* it under the terms of the GNU General Public License as published by */
-/* the Free Software Foundation; either version 2 of the License, or    */
-/* (at your option) any later version.                                  */
-/*                                                                      */
-/* This program is distributed in the hope that it will be useful,      */ 
-/* but WITHOUT ANY WARRANTY; without even the implied warranty of       */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        */
-/* GNU General Public License for more details.                         */
-/*                                                                      */
-/* You should have received a copy of the GNU General Public License    */ 
-/* along with this program; if not, write to the:                       */
-/* Free Software Foundation, Inc.,                                      */ 
-/* 59 Temple Place, Suite 330,                                          */ 
-/* Boston, MA  02111-1307  USA                                          */
-/************************************************************************/
-/* Change Activity:                                                     */
-/*   Created December 12, 2000                                          */
-/*   Ported to ppc64, August 30, 2001                                   */
-/* End Change Activity                                                  */
-/************************************************************************/
-
-struct pci_dev;
-struct iSeries_Device_Node;
-
-extern struct iSeries_Device_Node **iSeries_IoMmTable;
-extern u8 *iSeries_IoBarTable;
-extern unsigned long iSeries_Base_Io_Memory;
-extern unsigned long iSeries_Max_Io_Memory;
-extern unsigned long iSeries_Base_Io_Memory;
-extern unsigned long iSeries_IoMmTable_Entry_Size;
-/*
- * iSeries_IoMmTable_Initialize
- *
- * - Initalizes the Address Translation Table and get it ready for use.
- *   Must be called before any client calls any of the other methods.
- *
- * Parameters: None.
- *
- * Return: None.
- */
-extern void iSeries_IoMmTable_Initialize(void);
-extern void iSeries_IoMmTable_Status(void);
-
-/*
- * iSeries_allocateDeviceBars
- *
- * - Allocates ALL pci_dev BAR's and updates the resources with the BAR
- *   value.  BARS with zero length will not have the resources.  The
- *   HvCallPci_getBarParms is used to get the size of the BAR space.
- *   It calls iSeries_IoMmTable_AllocateEntry to allocate each entry.
- *
- * Parameters:
- * pci_dev = Pointer to pci_dev structure that will be mapped to pseudo
- *           I/O Address.
- *
- * Return:
- *   The pci_dev I/O resources updated with pseudo I/O Addresses.
- */
-extern void iSeries_allocateDeviceBars(struct pci_dev *);
-
-/*
- * iSeries_xlateIoMmAddress
- *
- * - Translates an I/O Memory address to Device Node that has been the
- *   allocated the psuedo I/O Address.
- *
- * Parameters:
- * IoAddress = I/O Memory Address.
- *
- * Return:
- *   An iSeries_Device_Node to the device mapped to the I/O address. The
- *   BarNumber and BarOffset are valid if the Device Node is returned.
- */
-extern struct iSeries_Device_Node *iSeries_xlateIoMmAddress(void *IoAddress);
-
-#endif /* _ISERIES_IOMMTABLE_H */
diff -ruN 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/iSeries_pci.c 2.6.10-rc1-bk6-cleanup.1/arch/ppc64/kernel/iSeries_pci.c
--- 2.6.10-rc1-bk6-irq.1/arch/ppc64/kernel/iSeries_pci.c	2004-10-25 15:37:12.000000000 +1000
+++ 2.6.10-rc1-bk6-cleanup.1/arch/ppc64/kernel/iSeries_pci.c	2004-10-27 18:43:41.000000000 +1000
@@ -1,4 +1,3 @@
-#define PCIFR(...)
 /*
  * iSeries_pci.c
  *
@@ -47,27 +46,19 @@
 #include <asm/iSeries/iSeries_pci.h>
 #include <asm/iSeries/mf.h>
 
-#include "iSeries_IoMmTable.h"
 #include "pci.h"
 
 extern int panic_timeout;
 
-extern unsigned long iSeries_Base_Io_Memory;    
-
-extern struct iommu_table *tceTables[256];
 extern unsigned long io_page_mask;
 
-extern void iSeries_MmIoTest(void);
-
 /*
  * Forward declares of prototypes. 
  */
 static struct iSeries_Device_Node *find_Device_Node(int bus, int devfn);
-static void iSeries_Scan_PHBs_Slots(struct pci_controller *Phb);
-static void iSeries_Scan_EADs_Bridge(HvBusNumber Bus, HvSubBusNumber SubBus,
-		int IdSel);
-static int iSeries_Scan_Bridge_Slot(HvBusNumber Bus,
-		struct HvCallPci_BridgeInfo *Info);
+static void scan_PHB_slots(struct pci_controller *Phb);
+static void scan_EADS_bridge(HvBusNumber Bus, HvSubBusNumber SubBus, int IdSel);
+static int scan_bridge_slot(HvBusNumber Bus, struct HvCallPci_BridgeInfo *Info);
 
 LIST_HEAD(iSeries_Global_Device_List);
 
@@ -88,7 +79,116 @@
 static struct pci_ops iSeries_pci_ops;
 
 /*
- * Log Error infor in Flight Recorder to system Console.
+ * Table defines
+ * Each Entry size is 4 MB * 1024 Entries = 4GB I/O address space.
+ */
+#define IOMM_TABLE_MAX_ENTRIES	1024
+#define IOMM_TABLE_ENTRY_SIZE	0x0000000000400000UL
+#define BASE_IO_MEMORY		0xE000000000000000UL
+
+static unsigned long max_io_memory = 0xE000000000000000UL;
+static long current_iomm_table_entry;
+
+/*
+ * Lookup Tables.
+ */
+static struct iSeries_Device_Node **iomm_table;
+static u8 *iobar_table;
+
+/*
+ * Static and Global variables
+ */
+static char *pci_io_text = "iSeries PCI I/O";
+static spinlock_t iomm_table_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * iomm_table_initialize
+ *
+ * Allocates and initalizes the Address Translation Table and Bar
+ * Tables to get them ready for use.  Must be called before any
+ * I/O space is handed out to the device BARs.
+ */
+static void iomm_table_initialize(void)
+{
+	spin_lock(&iomm_table_lock);
+	iomm_table = kmalloc(sizeof(*iomm_table) * IOMM_TABLE_MAX_ENTRIES,
+			GFP_KERNEL);
+	iobar_table = kmalloc(sizeof(*iobar_table) * IOMM_TABLE_MAX_ENTRIES,
+			GFP_KERNEL);
+	spin_unlock(&iomm_table_lock);
+	if ((iomm_table == NULL) || (iobar_table == NULL))
+		panic("PCI: I/O tables allocation failed.\n");
+}
+
+/*
+ * iomm_table_allocate_entry
+ *
+ * Adds pci_dev entry in address translation table
+ *
+ * - Allocates the number of entries required in table base on BAR
+ *   size.
+ * - Allocates starting at BASE_IO_MEMORY and increases.
+ * - The size is round up to be a multiple of entry size.
+ * - CurrentIndex is incremented to keep track of the last entry.
+ * - Builds the resource entry for allocated BARs.
+ */
+static void iomm_table_allocate_entry(struct pci_dev *dev, int bar_num)
+{
+	struct resource *bar_res = &dev->resource[bar_num];
+	long bar_size = pci_resource_len(dev, bar_num);
+
+	/*
+	 * No space to allocate, quick exit, skip Allocation.
+	 */
+	if (bar_size == 0)
+		return;
+	/*
+	 * Set Resource values.
+	 */
+	spin_lock(&iomm_table_lock);
+	bar_res->name = pci_io_text;
+	bar_res->start =
+		IOMM_TABLE_ENTRY_SIZE * current_iomm_table_entry;
+	bar_res->start += BASE_IO_MEMORY;
+	bar_res->end = bar_res->start + bar_size - 1;
+	/*
+	 * Allocate the number of table entries needed for BAR.
+	 */
+	while (bar_size > 0 ) {
+		iomm_table[current_iomm_table_entry] = dev->sysdata;
+		iobar_table[current_iomm_table_entry] = bar_num;
+		bar_size -= IOMM_TABLE_ENTRY_SIZE;
+		++current_iomm_table_entry;
+	}
+	max_io_memory = BASE_IO_MEMORY +
+		(IOMM_TABLE_ENTRY_SIZE * current_iomm_table_entry);
+	spin_unlock(&iomm_table_lock);
+}
+
+/*
+ * allocate_device_bars
+ *
+ * - Allocates ALL pci_dev BAR's and updates the resources with the
+ *   BAR value.  BARS with zero length will have the resources
+ *   The HvCallPci_getBarParms is used to get the size of the BAR
+ *   space.  It calls iomm_table_allocate_entry to allocate
+ *   each entry.
+ * - Loops through The Bar resources(0 - 5) including the ROM
+ *   is resource(6).
+ */
+static void allocate_device_bars(struct pci_dev *dev)
+{
+	struct resource *bar_res;
+	int bar_num;
+
+	for (bar_num = 0; bar_num <= PCI_ROM_RESOURCE; ++bar_num) {
+		bar_res = &dev->resource[bar_num];
+		iomm_table_allocate_entry(dev, bar_num);
+    	}
+}
+
+/*
+ * Log error information to system console.
  * Filter out the device not there errors.
  * PCI: EADs Connect Failed 0x18.58.10 Rc: 0x00xx
  * PCI: Read Vendor Failed 0x18.58.10 Rc: 0x00xx
@@ -99,7 +199,6 @@
 {
 	if (HvRc == 0x0302)
 		return;
-
 	printk(KERN_ERR "PCI: %s Failed: 0x%02X.%02X.%02X Rc: 0x%04X",
 	       Error_Text, Bus, SubBus, AgentId, HvRc);
 }
@@ -133,8 +232,6 @@
 	node->DevFn = PCI_DEVFN(ISERIES_ENCODE_DEVICE(AgentId), Function);
 	node->IoRetry = 0;
 	iSeries_Get_Location_Code(node);
-	PCIFR("Device 0x%02X.%2X, Node:0x%p ", ISERIES_BUS(node),
-			ISERIES_DEVFUN(node), node);
 	return node;
 }
 
@@ -160,10 +257,8 @@
 		if (ret == 0) {
 			printk("bus %d appears to exist\n", bus);
 			phb = pci_alloc_pci_controller(phb_type_hypervisor);
-			if (phb == NULL) {
-				PCIFR("Allocate pci_controller failed.");
+			if (phb == NULL)
 				return -1;
-			}
 			phb->pci_mem_offset = phb->local_number = bus;
 			phb->first_busno = bus;
 			phb->last_busno = bus;
@@ -171,10 +266,9 @@
 
 			PPCDBG(PPCDBG_BUSWALK, "PCI:Create iSeries pci_controller(%p), Bus: %04X\n",
 					phb, bus);
-			PCIFR("Create iSeries PHB controller: %04X", bus);
 
 			/* Find and connect the devices. */
-			iSeries_Scan_PHBs_Slots(phb);
+			scan_PHB_slots(phb);
 		}
 		/*
 		 * Check for Unexpected Return code, a clue that something
@@ -195,7 +289,7 @@
 void iSeries_pcibios_init(void)
 {
 	PPCDBG(PPCDBG_BUSWALK, "iSeries_pcibios_init Entry.\n"); 
-	iSeries_IoMmTable_Initialize();
+	iomm_table_initialize();
 	find_and_init_phbs();
 	io_page_mask = -1;
 	/* pci_assign_all_busses = 0;		SFRXXX*/
@@ -231,7 +325,7 @@
 			PPCDBG(PPCDBG_BUSWALK,
 					"pdev 0x%p <==> DevNode 0x%p\n",
 					pdev, node);
-			iSeries_allocateDeviceBars(pdev);
+			allocate_device_bars(pdev);
 			iSeries_Device_Information(pdev, Buffer,
 					sizeof(Buffer));
 			printk("%d. %s\n", DeviceCount, Buffer);
@@ -241,7 +335,6 @@
 					(unsigned long)pdev);
 		pdev->irq = node->Irq;
 	}
-	iSeries_IoMmTable_Status();
 	iSeries_activate_IRQs();
 	mf_displaySrc(0xC9000200);
 }
@@ -260,7 +353,7 @@
 /*
  * Loop through each node function to find usable EADs bridges.  
  */
-static void iSeries_Scan_PHBs_Slots(struct pci_controller *Phb)
+static void scan_PHB_slots(struct pci_controller *Phb)
 {
 	struct HvCallPci_DeviceInfo *DevInfo;
 	HvBusNumber bus = Phb->local_number;	/* System Bus */	
@@ -283,7 +376,7 @@
 				sizeof(struct HvCallPci_DeviceInfo));
 		if (HvRc == 0) {
 			if (DevInfo->deviceType == HvCallPci_NodeDevice)
-				iSeries_Scan_EADs_Bridge(bus, SubBus, IdSel);
+				scan_EADS_bridge(bus, SubBus, IdSel);
 			else
 				printk("PCI: Invalid System Configuration(0x%02X)"
 				       " for bus 0x%02x id 0x%02x.\n",
@@ -295,7 +388,7 @@
 	kfree(DevInfo);
 }
 
-static void iSeries_Scan_EADs_Bridge(HvBusNumber bus, HvSubBusNumber SubBus,
+static void scan_EADS_bridge(HvBusNumber bus, HvSubBusNumber SubBus,
 		int IdSel)
 {
 	struct HvCallPci_BridgeInfo *BridgeInfo;
@@ -340,7 +433,7 @@
 				if (BridgeInfo->busUnitInfo.deviceType ==
 						HvCallPci_BridgeDevice)  {
 					/* Scan_Bridge_Slot...: 0x18.00.12 */
-					iSeries_Scan_Bridge_Slot(bus, BridgeInfo);
+					scan_bridge_slot(bus, BridgeInfo);
 				} else
 					printk("PCI: Invalid Bridge Configuration(0x%02X)",
 						BridgeInfo->busUnitInfo.deviceType);
@@ -355,7 +448,7 @@
 /*
  * This assumes that the node slot is always on the primary bus!
  */
-static int iSeries_Scan_Bridge_Slot(HvBusNumber Bus,
+static int scan_bridge_slot(HvBusNumber Bus,
 		struct HvCallPci_BridgeInfo *BridgeInfo)
 {
 	struct iSeries_Device_Node *node;
@@ -593,12 +686,8 @@
 		return -1;	/* Retry Try */
 	}
 	/* If retry was in progress, log success and rest retry count */
-	if (DevNode->IoRetry > 0) {
-		PCIFR("%s: Device 0x%04X:%02X Retry Successful(%2d).",
-				TextHdr, DevNode->DsaAddr.Dsa.busNumber, DevNode->DevFn,
-				DevNode->IoRetry);
+	if (DevNode->IoRetry > 0)
 		DevNode->IoRetry = 0;
-	}
 	return 0; 
 }
 
@@ -607,8 +696,9 @@
  * Note: Make sure the passed variable end up on the stack to avoid
  * the exposure of being device global.
  */
-static inline struct iSeries_Device_Node *xlateIoMmAddress(const volatile void __iomem *IoAddress,
-		 u64 *dsaptr, u64 *BarOffsetPtr)
+static inline struct iSeries_Device_Node *xlate_iomm_address(
+		const volatile void __iomem *IoAddress,
+		u64 *dsaptr, u64 *BarOffsetPtr)
 {
 	unsigned long OrigIoAddr;
 	unsigned long BaseIoAddr;
@@ -616,17 +706,16 @@
 	struct iSeries_Device_Node *DevNode;
 
 	OrigIoAddr = (unsigned long __force)IoAddress;
-	if ((OrigIoAddr < iSeries_Base_Io_Memory) ||
-			(OrigIoAddr >= iSeries_Max_Io_Memory))
+	if ((OrigIoAddr < BASE_IO_MEMORY) || (OrigIoAddr >= max_io_memory))
 		return NULL;
-	BaseIoAddr = OrigIoAddr - iSeries_Base_Io_Memory;
-	TableIndex = BaseIoAddr / iSeries_IoMmTable_Entry_Size;
-	DevNode = iSeries_IoMmTable[TableIndex];
+	BaseIoAddr = OrigIoAddr - BASE_IO_MEMORY;
+	TableIndex = BaseIoAddr / IOMM_TABLE_ENTRY_SIZE;
+	DevNode = iomm_table[TableIndex];
 
 	if (DevNode != NULL) {
-		int barnum = iSeries_IoBarTable[TableIndex];
+		int barnum = iobar_table[TableIndex];
 		*dsaptr = DevNode->DsaAddr.DsaAddr | (barnum << 24);
-		*BarOffsetPtr = BaseIoAddr % iSeries_IoMmTable_Entry_Size;
+		*BarOffsetPtr = BaseIoAddr % IOMM_TABLE_ENTRY_SIZE;
 	} else
 		panic("PCI: Invalid PCI IoAddress detected!\n");
 	return DevNode;
@@ -647,7 +736,7 @@
 	u64 dsa;
 	struct HvCallPci_LoadReturn ret;
 	struct iSeries_Device_Node *DevNode =
-		xlateIoMmAddress(IoAddress, &dsa, &BarOffset);
+		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
 
 	if (DevNode == NULL) {
 		static unsigned long last_jiffies;
@@ -676,7 +765,7 @@
 	u64 dsa;
 	struct HvCallPci_LoadReturn ret;
 	struct iSeries_Device_Node *DevNode =
-		xlateIoMmAddress(IoAddress, &dsa, &BarOffset);
+		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
 
 	if (DevNode == NULL) {
 		static unsigned long last_jiffies;
@@ -706,7 +795,7 @@
 	u64 dsa;
 	struct HvCallPci_LoadReturn ret;
 	struct iSeries_Device_Node *DevNode =
-		xlateIoMmAddress(IoAddress, &dsa, &BarOffset);
+		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
 
 	if (DevNode == NULL) {
 		static unsigned long last_jiffies;
@@ -743,7 +832,7 @@
 	u64 dsa;
 	u64 rc;
 	struct iSeries_Device_Node *DevNode =
-		xlateIoMmAddress(IoAddress, &dsa, &BarOffset);
+		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
 
 	if (DevNode == NULL) {
 		static unsigned long last_jiffies;
@@ -770,7 +859,7 @@
 	u64 dsa;
 	u64 rc;
 	struct iSeries_Device_Node *DevNode =
-		xlateIoMmAddress(IoAddress, &dsa, &BarOffset);
+		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
 
 	if (DevNode == NULL) {
 		static unsigned long last_jiffies;
@@ -797,7 +886,7 @@
 	u64 dsa;
 	u64 rc;
 	struct iSeries_Device_Node *DevNode =
-		xlateIoMmAddress(IoAddress, &dsa, &BarOffset);
+		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
 
 	if (DevNode == NULL) {
 		static unsigned long last_jiffies;

--Signature=_Fri__29_Oct_2004_02_42_51_+1000_AO0EqMx2dw6GZa.c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBgSGL4CJfqux9a+8RAo1bAJ9CipL/Q1SUsiWHKIN39fCaDjnm2wCfSxI4
pcnIqwuSTMV6bmhyKfbtq0o=
=DThE
-----END PGP SIGNATURE-----

--Signature=_Fri__29_Oct_2004_02_42_51_+1000_AO0EqMx2dw6GZa.c--
