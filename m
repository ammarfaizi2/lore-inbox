Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276430AbRI2Dvs>; Fri, 28 Sep 2001 23:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276431AbRI2Dvn>; Fri, 28 Sep 2001 23:51:43 -0400
Received: from sushi.toad.net ([162.33.130.105]:48776 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276430AbRI2DvZ>;
	Fri, 28 Sep 2001 23:51:25 -0400
Message-ID: <3BB5452F.6814CB3F@yahoo.co.uk>
Date: Fri, 28 Sep 2001 23:51:11 -0400
From: Thomas Hood <jdthood@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stelian Pop <stelian.pop@fr.alcove.com>
Subject: [PATCH] PnPBIOS 2.4.9-ac1[56] additional fixes
Content-Type: multipart/mixed;
 boundary="------------2DFD675411042CF0052647E6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2DFD675411042CF0052647E6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stelian,

Here is a SECOND patch (called thood-pnpbiosfix-patch-20010928-2)
which applies on top of the one I previously sent (called
thood-pnpbiosvaiofix-patch-20010928-1).  It implements all the
other changes to the PnP BIOS driver that I've come up with:

-  Change typo "struct ressource" to "struct resource".
-  build_devlist() contained a memory leak: struct pci_devs were
   kmalloc()ed but not freed if left unused.  Fix.
-  Make all printk()s consistent: start messages with "PnPBIOS:"
-  Limit for-all-nodes loops to 254 iterations.
-  EXPORT set_dev_node
-  Make some code formatting and many other trivial changes
-  Incorrect nodenum was recorded in dev->devfn.  Fix.
-  But most importantly, make the driver distinguish between
   resource data that has not been set and resources that are
   reported by the PnP BIOS as extant but disabled.  Whereas
   previously a struct resource .start value of 0 was ambiguous
   between  "resource not reported" and "resource disabled",
   now use the .flags field (specifically, the IORESOURCE_UNSET bit)
   to indicate an unused struct, and use a .start value of -1
   to indicate a disabled irq or dma.  This should be backward
   compatible since unused structs .start values are initialized
   to -1.  In any case, SFAIK only the parport driver calls the
   PnP BIOS driver ATM, and I submit a patch hereafter which 
   makes it use the new semantics.

Please test this patch on your Vaio: boot with the "nobioscurrpnp"
option and get back to me.  It works fine on my ThinkPad.

Alan: In the patched driver, the devlist is built by getting all
the nodes in the boot configuration.  Obviously this is the best we
can do in the case of Vaio laptops.  For other laptops we want to
query the "current" configuration because that configuration is
the actual state of the hardware; and it can change.  It think it
might be best not to build a devlist at all. Why maintain a copy
of information which may go out of date?  Even on the Vaio we can
query the ("boot") configuration _repeatedly_ if we have to, 
without the help of a devlist.

--
Thomas
--------------2DFD675411042CF0052647E6
Content-Type: text/plain; charset=us-ascii;
 name="thood-pnpbiosfix-patch-20010928-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thood-pnpbiosfix-patch-20010928-2"

diff -Naur -5 linux-2.4.9-ac16-pnpbiosviaofix/drivers/pnp/pnp_bios.c linux-2.4.9-ac16-pnpbiosfix/drivers/pnp/pnp_bios.c
--- linux-2.4.9-ac16-pnpbiosviaofix/drivers/pnp/pnp_bios.c	Fri Sep 28 22:28:31 2001
+++ linux-2.4.9-ac16-pnpbiosfix/drivers/pnp/pnp_bios.c	Fri Sep 28 23:19:58 2001
@@ -1,11 +1,12 @@
 /*
- * PnP bios services
+ * PnP BIOS services
  * 
  * Originally (C) 1998 Christian Schmidt (chr.schmidt@tu-bs.de)
  * Modifications (c) 1998 Tom Lees <tom@lpsg.demon.co.uk>
  * Minor reorganizations by David Hinds <dahinds@users.sourceforge.net>
+ * More modifications by Thomas Hood <jdthood_AT_yahoo.co.uk>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
  * later version.
@@ -17,13 +18,12 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
- *   Reference:
- *   Compaq Computer Corporation, Phoenix Technologies Ltd., Intel 
- *   Corporation. 
+ *   References:
+ *   Compaq Computer Corporation, Phoenix Technologies Ltd., Intel Corporation
  *   Plug and Play BIOS Specification, Version 1.0A, May 5, 1994
  *   Plug and Play BIOS Clarification Paper, October 6, 1994
  *
  */
 
@@ -46,14 +46,10 @@
 #include <linux/spinlock.h>
 
 /* PnP bios signature: "$PnP" */
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
-extern int is_sony_vaio_laptop;
-
-static void pnpbios_build_devlist(void);
-
 /*
  * This is the standard structure used to identify the entry point
  * to the Plug and Play bios
  */
 #pragma pack(1)
@@ -104,10 +100,11 @@
  * This is the only way to get the bios to return into the kernel code,
  * because the bios code runs in 16 bit protected mode and therefore can only
  * return to the caller if the call is within the first 64kB, and the linux
  * kernel begins at offset 3GB...
  */
+
 asmlinkage void pnp_bios_callfunc(void);
 
 __asm__(
 	".text			\n"
 	__ALIGN_STR "\n"
@@ -129,11 +126,11 @@
 #define Q2_SET_SEL(selname, address, size) \
 set_base (gdt [(selname) >> 3], (u32)(address)); \
 set_limit (gdt [(selname) >> 3], size)
 
 /*
- * Callable Functions
+ * Callable PnP BIOS functions
  */
 #define PNP_GET_NUM_SYS_DEV_NODES       0x00
 #define PNP_GET_SYS_DEV_NODE            0x01
 #define PNP_SET_SYS_DEV_NODE            0x02
 #define PNP_GET_EVENT                   0x03
@@ -147,12 +144,12 @@
 #define PNP_READ_ESCD                   0x42
 #define PNP_WRITE_ESCD                  0x43
 
 
 /*
- *	At some point we want to use this stack frame pointer to unwind
- *	after PnP BIOS oopses. 
+ * At some point we want to use this stack frame pointer to unwind
+ * after PnP BIOS oopses. 
  */
  
 u32 pnp_bios_fault_esp;
 u32 pnp_bios_fault_eip;
 u32 pnp_bios_is_utter_crap = 0;
@@ -169,11 +166,11 @@
 	 *	PnPBIOS is generally not terribly re-entrant.
 	 *	Also don't rely on it to save everything correctly
  	 *
  	 *	On some boxes IRQ's during PnP bios calls seem fatal
 	 */
-	
+
 	if(pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 		
 	spin_lock_irqsave(&pnp_bios_lock, flags);
 	__cli();
@@ -218,11 +215,17 @@
 		
 	return status;
 }
 
 /*
- * Call pnp bios with function 0x00, "get number of system device nodes"
+ *
+ * PnP BIOS ACCESS FUNCTIONS
+ *
+ */
+
+/*
+ * Call PnP BIOS with function 0x00, "get number of system device nodes"
  */
 
 int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
 	u16 status;
@@ -232,14 +235,22 @@
 	status = call_pnp_bios(PNP_GET_NUM_SYS_DEV_NODES, 0, PNP_TS1, 2, PNP_TS1, PNP_DS, 0, 0);
 	data->no_nodes &= 0xff;
 	return status;
 }
 
+/*
+ * Note that some PnP BIOSes (on Sony Vaio laptops) die a horrible
+ * death if they are asked to access the "current" configuration
+ * Therefore, if it's a matter of indifference, it's better to call
+ * get_dev_node() and set_dev_node() with boot=1 rather than with boot=0.
+ */
+
 /* 
- * Call pnp bios with function 0x01, "get system device node"
+ * Call PnP BIOS with function 0x01, "get system device node"
  * Input: *nodenum = desired node, 
- *        boot = whether to get static boot (!=0) or dynamic current (0) config
+ *        boot = whether to get nonvolatile boot (!=0)
+ *               or volatile current (0) config
  * Output: *nodenum=next node or 0xff if no more nodes
  */
 
 int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
@@ -251,13 +262,14 @@
 	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0);
 	return status;
 }
 
 /*
- * Call pnp bios with function 0x02, "set system device node"
+ * Call PnP BIOS with function 0x02, "set system device node"
  * Input: *nodenum = desired node, 
- *        boot = whether to set static boot (!=0) or dynamic current (0) config
+ *        boot = whether to set nonvolatile boot (!=0)
+ *               or volatile current (0) config
  */
 
 int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
@@ -266,15 +278,14 @@
 	Q2_SET_SEL(PNP_TS1, data, /* *((u16 *) data)*/ 65536);
 	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0);
 	return status;
 }
 
+#if needed
 /*
- * Call pnp bios with function 0x03, "get event"
+ * Call PnP BIOS with function 0x03, "get event"
  */
-#if needed
-
 static int pnp_bios_get_event(u16 *event)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
@@ -282,14 +293,14 @@
 	status = call_pnp_bios(PNP_GET_EVENT, 0, PNP_TS1, PNP_DS, 0, 0 ,0 ,0);
 	return status;
 }
 #endif
 
+#if needed
 /* 
- * Call pnp bios with function 0x04, "send message"
+ * Call PnP BIOS with function 0x04, "send message"
  */
-#if needed
 static int pnp_bios_send_message(u16 message)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
@@ -298,11 +309,11 @@
 }
 #endif
 
 #ifdef CONFIG_HOTPLUG
 /*
- * Call pnp bios with function 0x05, "get docking station information"
+ * Call PnP BIOS with function 0x05, "get docking station information"
  */
 
 static int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
 {
 	u16 status;
@@ -312,15 +323,15 @@
 	status = call_pnp_bios(PNP_GET_DOCKING_STATION_INFORMATION, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
 	return status;
 }
 #endif
 
+#if needed
 /*
- * Call pnp bios with function 0x09, "set statically allocated resource
+ * Call PnP BIOS with function 0x09, "set statically allocated resource
  * information"
  */
-#if needed
 static int pnp_bios_set_stat_res(char *info)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
@@ -328,15 +339,15 @@
 	status = call_pnp_bios(PNP_SET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
 	return status;
 }
 #endif
 
+#if needed
 /*
- * Call pnp bios with function 0x0a, "get statically allocated resource
+ * Call PnP BIOS with function 0x0a, "get statically allocated resource
  * information"
  */
-#if needed
 static int pnp_bios_get_stat_res(char *info)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
@@ -344,14 +355,14 @@
 	status = call_pnp_bios(PNP_GET_STATIC_ALLOCED_RES_INFO, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
 	return status;
 }
 #endif
 
+#if needed
 /*
- * Call pnp bios with function 0x0b, "get APM id table"
+ * Call PnP BIOS with function 0x0b, "get APM id table"
  */
-#if needed
 static int pnp_bios_apm_id_table(char *table, u16 *size)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
@@ -360,14 +371,14 @@
 	status = call_pnp_bios(PNP_GET_APM_ID_TABLE, 0, PNP_TS2, 0, PNP_TS1, PNP_DS, 0, 0);
 	return status;
 }
 #endif
 
+#if needed
 /*
- * Call pnp bios with function 0x40, "get isa pnp configuration structure"
+ * Call PnP BIOS with function 0x40, "get isa pnp configuration structure"
  */
-#if needed
 static int pnp_bios_isapnp_config(struct pnp_isa_config_struc *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return PNP_FUNCTION_NOT_SUPPORTED;
@@ -375,14 +386,14 @@
 	status = call_pnp_bios(PNP_GET_PNP_ISA_CONFIG_STRUC, 0, PNP_TS1, PNP_DS, 0, 0, 0, 0);
 	return status;
 }
 #endif
 
+#if needed
 /*
- * Call pnp bios with function 0x41, "get ESCD info"
+ * Call PnP BIOS with function 0x41, "get ESCD info"
  */
-#if needed
 static int pnp_bios_escd_info(struct escd_info_struc *data)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
@@ -390,15 +401,15 @@
 	status = call_pnp_bios(PNP_GET_ESCD_INFO, 0, PNP_TS1, 2, PNP_TS1, 4, PNP_TS1, PNP_DS);
 	return status;
 }
 #endif
 
+#if needed
 /*
- * Call pnp bios function 0x42, "read ESCD"
+ * Call PnP BIOS function 0x42, "read ESCD"
  * nvram_base is determined by calling escd_info
  */
-#if needed
 static int pnp_bios_read_escd(char *data, u32 nvram_base)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
@@ -408,14 +419,14 @@
 	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0);
 	return status;
 }
 #endif
 
+#if needed
 /*
- * Call pnp bios function 0x43, "write ESCD"
+ * Call PnP BIOS function 0x43, "write ESCD"
  */
-#if needed
 static int pnp_bios_write_escd(char *data, u32 nvram_base)
 {
 	u16 status;
 	if (!pnp_bios_present ())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
@@ -425,26 +436,28 @@
 	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0);
 	return status;
 }
 #endif
 
-int pnp_bios_present(void)
-{
-	return (pnp_bios_inst_struc != NULL);
-}
-
-#ifdef CONFIG_HOTPLUG
+EXPORT_SYMBOL(pnp_bios_dev_node_info);
+EXPORT_SYMBOL(pnp_bios_get_dev_node);
+EXPORT_SYMBOL(pnp_bios_set_dev_node);
 
 /*
- *	Manage PnP docking
+ *
+ * PnP DOCKING FUNCTIONS
+ *
  */
 
+#ifdef CONFIG_HOTPLUG
+
 static int unloading = 0;
+
 static struct completion unload_sem;
 
 /*
- *	Much of this belongs in a shared routine somewhere
+ * (Much of this belongs in a shared routine somewhere)
  */
  
 static int pnp_dock_event(int dock, struct pnp_docking_station_info *info)
 {
 	char *argv [3], **envp, *buf, *scratch;
@@ -496,11 +509,11 @@
 	kfree (envp);
 	return 0;
 }
 
 /*
- *	Poll the PnP docking at a regular interval
+ * Poll the PnP docking at a regular interval
  */
  
 static int pnp_dock_thread(void * unused)
 {
 	static struct pnp_docking_station_info now;
@@ -511,13 +524,12 @@
 	while(!unloading && !signal_pending(current))
 	{
 		int err;
 		
 		/*
-		 *	Poll every 2 seconds
+		 * Poll every 2 seconds
 		 */
-		 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ*2);
 		if(signal_pending(current))
 			break;
 
@@ -525,11 +537,11 @@
 
 
 		switch(err)
 		{
 			/*
-			 *	No dock to manage
+			 * No dock to manage
 			 */
 			case PNP_FUNCTION_NOT_SUPPORTED:
 				complete_and_exit(&unload_sem, 0);
 			case PNP_SYSTEM_NOT_DOCKED:
 				d = 0;
@@ -553,137 +565,57 @@
 	complete_and_exit(&unload_sem, 0);
 }
 
 #endif
 
-/* 
- * Searches the defined area (0xf0000-0xffff0) for a valid PnP BIOS
- * structure and, if found one, sets up the selectors and entry points
+/*
+ *
+ * NODE DATA HANDLING FUNCTIONS
+ *
  */
 
-static int pnp_bios_disabled;
-static int pnp_bios_dont_use_current_config;
-
-static int disable_pnp_bios(char *str)
-{
-	pnp_bios_disabled=1;
-	return 0;
-}
-
-static int disable_use_of_current_config(char *str)
-{
-	pnp_bios_dont_use_current_config=1;
-	return 0;
-}
-
-__setup("nobiospnp", disable_pnp_bios);
-__setup("nobioscurrpnp", disable_use_of_current_config);
-
-void pnp_bios_init(void)
-{
-	union pnpbios *check;
-	u8 sum;
-	int i, length;
-
-	spin_lock_init(&pnp_bios_lock);
-
-	if(pnp_bios_disabled)
-	{
-		printk(KERN_INFO "PNP BIOS services disabled.\n");
-		return;
-	}
-
-	if ( is_sony_vaio_laptop )
-		pnp_bios_dont_use_current_config = 1;
-
-	for (check = (union pnpbios *) __va(0xf0000);
-	     check < (union pnpbios *) __va(0xffff0);
-	     ((void *) (check)) += 16) {
-		if (check->fields.signature != PNP_SIGNATURE)
-			continue;
-		length = check->fields.length;
-		if (!length)
-			continue;
-		for (sum = 0, i = 0; i < length; i++)
-			sum += check->chars[i];
-		if (sum)
-			continue;
-		if (check->fields.version < 0x10) {
-			printk(KERN_WARNING "PnP: unsupported version %d.%d",
-			       check->fields.version >> 4,
-			       check->fields.version & 15);
-			continue;
-		}
-		printk(KERN_INFO "PnP: PNP BIOS installation structure at 0x%p\n",
-		       check);
-		printk(KERN_INFO "PnP: PNP BIOS version %d.%d, entry at %x:%x, dseg at %x\n",
-                       check->fields.version >> 4, check->fields.version & 15,
-		       check->fields.pm16cseg, check->fields.pm16offset,
-		       check->fields.pm16dseg);
-		Q2_SET_SEL(PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
-		Q_SET_SEL(PNP_CS16, check->fields.pm16cseg, 64 * 1024);
-		Q_SET_SEL(PNP_DS, check->fields.pm16dseg, 64 * 1024);
-		pnp_bios_callpoint.offset = check->fields.pm16offset;
-		pnp_bios_callpoint.segment = PNP_CS16;
-		pnp_bios_inst_struc = check;
-		break;
-	}
-	pnpbios_build_devlist();
-#ifdef CONFIG_PROC_FS
-	pnp_proc_init( pnp_bios_dont_use_current_config );
-#endif
-#ifdef CONFIG_HOTPLUG	
-	init_completion(&unload_sem);
-	if(kernel_thread(pnp_dock_thread, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL)>0)
-		unloading = 0;
-#endif		
-}
-
-#ifdef MODULE
-/* We have to run it early and specifically in non modular.. */
-module_init(pnp_bios_init);
-
-#ifdef CONFIG_HOTPLUG
-static void pnp_bios_exit(void)
-{
-	unloading = 1;
-	wait_for_completion(&unload_sem);
-}
-
-module_exit(pnp_bios_exit);
-#endif
-#endif
-
-EXPORT_SYMBOL(pnp_bios_get_dev_node);
-EXPORT_SYMBOL(pnp_bios_present);
-EXPORT_SYMBOL(pnp_bios_dev_node_info);
-
 static void inline pnpbios_add_irqresource(struct pci_dev *dev, int irq)
 {
+	// Permit irq==-1 which signifies "disabled"
 	int i = 0;
-	while (dev->irq_resource[i].start && i < DEVICE_COUNT_IRQ) i++;
-	if (i < DEVICE_COUNT_IRQ)
+	while (!(dev->irq_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_IRQ) i++;
+	if (i < DEVICE_COUNT_IRQ) {
 		dev->irq_resource[i].start = irq;
+		dev->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+	}
 }
 
 static void inline pnpbios_add_dmaresource(struct pci_dev *dev, int dma)
 {
+	// Permit dma==-1 which signifies "disabled"
 	int i = 0;
-	while (dev->dma_resource[i].start && i < DEVICE_COUNT_DMA) i++;
-	if (i < DEVICE_COUNT_DMA)
+	while (!(dev->dma_resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_DMA) i++;
+	if (i < DEVICE_COUNT_DMA) {
 		dev->dma_resource[i].start = dma;
+		dev->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+	}
+}
+
+static void __init pnpbios_add_ioresource(struct pci_dev *dev, int io, int len)
+{
+	int i = 0;
+	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
+	if (i < DEVICE_COUNT_RESOURCE) {
+		dev->resource[i].start = io;
+		dev->resource[i].end = io + len;
+		dev->resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+	}
 }
 
-static void __init pnpbios_add_ioresource(struct pci_dev *dev, int io, 
-					  int len, int flags)
+static void __init pnpbios_add_memresource(struct pci_dev *dev, int io, int len)
 {
 	int i = 0;
-	while (dev->resource[i].start && i < DEVICE_COUNT_RESOURCE) i++;
+	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
 	if (i < DEVICE_COUNT_RESOURCE) {
 		dev->resource[i].start = io;
 		dev->resource[i].end = io + len;
-		dev->resource[i].flags = flags;
+		dev->resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
 	}
 }
 
 static char * __init pnpid32_to_pnpid(u32 id);
 
@@ -691,120 +623,162 @@
  * request I/O ports which are used according to the PnP BIOS
  * to avoid I/O conflicts.
  */
 static void mboard_request(char *pnpid, int io, int len)
 {
-    struct ressource *res;
+	struct resource *res;
     
-    if (0 != strcmp(pnpid,"PNP0c01") &&  /* memory controller */
-	0 != strcmp(pnpid,"PNP0c02"))    /* system peripheral: other */
-	return;
+	if (
+		0 != strcmp(pnpid,"PNP0c01") &&  /* memory controller */
+		0 != strcmp(pnpid,"PNP0c02")     /* system peripheral: other */
+	) {
+		return;
+	}
+
+	if (io < 0x100) {
+		/*
+		 * below 0x100 is only standard PC hardware
+		 * (pics, kbd, timer, dma, ...)
+		 *
+		 * We should not get resource conflicts there,
+		 * and the kernel reserves these anyway
+		 * (see arch/i386/kernel/setup.c).
+		 */
+		return;
+	}
 
-    if (io < 0x100) {
 	/*
-	 * below 0x100 is only standard PC hardware
-	 * (pics, kbd, timer, dma, ...)
+	 * anything else we'll try reserve to avoid these ranges are
+	 * assigned to someone (CardBus bridges for example) and thus are
+	 * triggering resource conflicts.
 	 *
-	 * We should not get ressource conflicts there,
-	 * and the kernel reserves these anyway
-	 * (see arch/i386/kernel/setup.c).
+	 * failures at this point are usually harmless. pci quirks for
+	 * example do reserve stuff they know about too, so we might have
+	 * double reservations here.
 	 */
-	return;
-    }
+	res = request_region(io,len,pnpid);
+	printk("PnPBIOS: %s: request 0x%x-0x%x%s\n",
+		pnpid,io,io+len,NULL != res ? " ok" : "");
 
-    /*
-     * anything else we'll try reserve to avoid these ranges are
-     * assigned to someone (CardBus bridges for example) and thus are
-     * triggering resource conflicts.
-     *
-     * failures at this point are usually harmless. pci quirks for
-     * example do reserve stuff they know about too, so we might have
-     * double reservations here.
-     */
-    res = request_region(io,len,pnpid);
-    printk("PnPBIOS: %s: request 0x%x-0x%x%s\n",
-	   pnpid,io,io+len,NULL != res ? " ok" : "");
+	return;
 }
 
 /* parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev */
-static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *pci_dev)
+static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *dev)
 {
 	unsigned char *p = node->data, *lastp=NULL;
-        int mask,i,io,irq,len,dma;
+	int i;
 
-	memset(pci_dev, 0, sizeof(struct pci_dev));
+	/*
+	 * First, set dev contents to default values
+	 */
+	memset(dev,0,sizeof(struct pci_dev));
+	for (i=0;i<DEVICE_COUNT_RESOURCE;i++) {
+	/*	dev->resource[i].start = 0; */
+		dev->resource[i].flags = IORESOURCE_UNSET;
+	}
+	for (i=0;i<DEVICE_COUNT_IRQ;i++) {
+		dev->irq_resource[i].start = (unsigned long)-1;  // "disabled"
+		dev->irq_resource[i].flags = IORESOURCE_UNSET;
+	}
+	for (i=0;i<DEVICE_COUNT_DMA;i++) {
+		dev->dma_resource[i].start = (unsigned long)-1;  // "disabled"
+		dev->dma_resource[i].flags = IORESOURCE_UNSET;
+	}
+
+	/*
+	 * Fill in dev info
+	 */
         while ( (char *)p < ((char *)node->data + node->size )) {
         	if(p==lastp) break;
 
                 if( p[0] & 0x80 ) {// large item
 			switch (p[0] & 0x7f) {
 			case 0x01: // memory
-				io = *(short *) &p[4];
-				len = *(short *) &p[10];
-				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+			{
+				int io = *(short *) &p[4];
+				int len = *(short *) &p[10];
+				pnpbios_add_memresource(dev, io, len);
 				break;
+			}
 			case 0x02: // device name
-				len = *(short *) &p[1];
-				memcpy(pci_dev->name, p + 3, len >= 80 ? 79 : len);
+			{
+				int len = *(short *) &p[1];
+				memcpy(dev->name, p + 3, len >= 80 ? 79 : len);
 				break;
+			}
 			case 0x05: // 32-bit memory
-				io = *(int *) &p[4];
-				len = *(int *) &p[16];
-				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+			{
+				int io = *(int *) &p[4];
+				int len = *(int *) &p[16];
+				pnpbios_add_memresource(dev, io, len);
 				break;
+			}
 			case 0x06: // fixed location 32-bit memory
-				io = *(int *) &p[4];
-				len = *(int *) &p[8];
-				pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_MEM);
+			{
+				int io = *(int *) &p[4];
+				int len = *(int *) &p[8];
+				pnpbios_add_memresource(dev, io, len);
 				break;
 			}
+			} /* switch */
                         lastp = p+3;
                         p = p + p[1] + p[2]*256 + 3;
                         continue;
                 }
                 if ((p[0]>>3) == 0x0f) // end tag
                         break;
                 switch (p[0]>>3) {
                 case 0x04: // irq
-                        irq = -1;
+                {
+                        int i, mask, irq = -1; // "disabled"
                         mask= p[1] + p[2]*256;
                         for (i=0;i<16;i++, mask=mask>>1)
-                                if(mask &0x01) irq=i;
-			pnpbios_add_irqresource(pci_dev, irq);
+                                if(mask & 0x01) irq=i;
+			pnpbios_add_irqresource(dev, irq);
                         break;
+                }
                 case 0x05: // dma
-                        dma = -1;
+                {
+                        int i, mask, dma = -1; // "disabled"
                         mask = p[1];
                         for (i=0;i<8;i++, mask = mask>>1)
-                                if(mask&0x01) dma=i;
-			pnpbios_add_dmaresource(pci_dev, dma);
+                                if(mask & 0x01) dma=i;
+			pnpbios_add_dmaresource(dev, dma);
                         break;
+                }
                 case 0x08: // io
-			io= p[2] + p[3] *256;
-			len = p[7];
-			pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_IO);
+                {
+			int io= p[2] + p[3] *256;
+			int len = p[7];
+			pnpbios_add_ioresource(dev, io, len);
 			mboard_request(pnpid32_to_pnpid(node->eisa_id),io,len);
                         break;
+                }
 		case 0x09: // fixed location io
-			io = p[1] + p[2] * 256;
-			len = p[3];
-			pnpbios_add_ioresource(pci_dev, io, len, IORESOURCE_IO);
+		{
+			int io = p[1] + p[2] * 256;
+			int len = p[3];
+			pnpbios_add_ioresource(dev, io, len);
 			break;
-                }
+		}
+                } /* switch */
                 lastp=p+1;
                 p = p + (p[0] & 0x07) + 1;
 
-        }
+        } /* while */
+
+        return;
 }
 
 #define HEX(id,a) hex[((id)>>a) & 15]
 #define CHAR(id,a) (0x40 + (((id)>>a) & 31))
 
 static char * __init pnpid32_to_pnpid(u32 id)
 {
 	const char *hex = "0123456789abcdef";
-        static char str[8];
+	static char str[8];
 	id = be32_to_cpu(id);
 	str[0] = CHAR(id, 26);
 	str[1] = CHAR(id, 21);
 	str[2] = CHAR(id,16);
 	str[3] = HEX(id, 12);
@@ -817,15 +791,24 @@
 
 #undef CHAR
 #undef HEX  
 
 /*
- *	PnPBIOS public device management layer
+ *
+ * PnP BIOS PUBLIC DEVICE MANAGEMENT LAYER FUNCTIONS
+ *
  */
 
 static LIST_HEAD(pnpbios_devices);
 
+int pnp_bios_present(void)
+{
+	return (pnp_bios_inst_struc != NULL);
+}
+
+EXPORT_SYMBOL(pnp_bios_present);
+
 static int __init pnpbios_insert_device(struct pci_dev *dev)
 {
 	/* FIXME: Need to check for re-add of existing node */
 	list_add_tail(&dev->global_list, &pnpbios_devices);
 	return 0;
@@ -835,70 +818,70 @@
  *	Build the list of pci_dev objects from the PnP table
  */
  
 static void __init pnpbios_build_devlist(void)
 {
-	int i, devs = 0;
+	int i;
+	int nodenum;
+	int nodes_got = 0;
 	struct pnp_bios_node *node;
-        struct pnp_dev_node_info node_info;
+	struct pnp_dev_node_info node_info;
 	struct pci_dev *dev;
-	int num;
 	char *pnpid;
 
 	
-        if (!pnp_bios_present ())
-                return;
+	if (!pnp_bios_present ())
+		return;
 
-        if (pnp_bios_dev_node_info(&node_info) != 0)
-                return;
+	if (pnp_bios_dev_node_info(&node_info) != 0)
+		return;
 
-        node = kmalloc(node_info.max_node_size, GFP_KERNEL);
-        if (!node)
-                return;
+	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
+	if (!node)
+		return;
 
-	for(i=0;i<0xff;i++) {
+	for(i=0,nodenum=0;i<0xff && nodenum!=0xff;i++) {
+		int thisnodenum = nodenum;
+		if (pnp_bios_get_dev_node((u8 *)&nodenum, (char )1 , node))
+			continue;
+		nodes_got++;
 		dev =  kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
 		if (!dev)
 			break;
-
-		// For now we scan the "boot" config because some BIOSes
-		// oops when their "current" configs are accessed
-                if (pnp_bios_get_dev_node((u8 *)&num, (char )1 , node))
-			continue;
-
-		devs++;
 		pnpbios_rawdata_2_pci_dev(node,dev);
-		dev->devfn=num;
+		dev->devfn=thisnodenum;
 		pnpid = pnpid32_to_pnpid(node->eisa_id);
 		memcpy(dev->name,"PNPBIOS",8);
 		memcpy(dev->slot_name,pnpid,8);
 		if(pnpbios_insert_device(dev)<0)
 			kfree(dev);
 	}
 	kfree(node);
 
-	if (devs)
-		printk(KERN_INFO "PnP: %i device%s detected total\n", devs, devs > 1 ? "s" : "");
-	else
-		printk(KERN_INFO "PnP: No devices found\n");
+	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS\n", nodes_got, nodes_got != 1 ? "s" : "");
 }
 
 
 /*
- *	The public interface to PnP BIOS enumeration
+ *
+ * PUBLIC INTERFACE FUNCTIONS to PnP BIOS ENUMERATION
+ *
+ */
+
+/*
+ * Find device in list
  */
- 
 struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prev)
 {
 	struct pci_dev *dev;
 	int num;
 
 	if(prev==NULL)
 		num=0; /* Start from beginning */
 	else
 		num=prev->devfn + 1; /* Encode node number here */
-	
+
 
 	pnpbios_for_each_dev(dev)
 	{
 		if(dev->devfn >= num)
 		{
@@ -1017,6 +1000,108 @@
 	}
 }
 
 EXPORT_SYMBOL(pnpbios_unregister_driver);
 
+/* 
+ *
+ * INIT AND EXIT
+ *
+ *
+ * Search the defined area (0xf0000-0xffff0) for a valid PnP BIOS
+ * structure and, if one is found, sets up the selectors and
+ * entry points
+ */
+
+extern int is_sony_vaio_laptop;
+
+static int pnp_bios_disabled;
+static int pnp_bios_dont_use_current_config;
+
+static int disable_pnp_bios(char *str)
+{
+	pnp_bios_disabled=1;
+	return 0;
+}
+
+static int disable_use_of_current_config(char *str)
+{
+	pnp_bios_dont_use_current_config=1;
+	return 0;
+}
+
+__setup("nobiospnp", disable_pnp_bios);
+__setup("nobioscurrpnp", disable_use_of_current_config);
+
+void pnp_bios_init(void)
+{
+	union pnpbios *check;
+	u8 sum;
+	int i, length;
+
+	spin_lock_init(&pnp_bios_lock);
+
+	if(pnp_bios_disabled) {
+		printk(KERN_INFO "PnPBIOS: driver disabled.\n");
+		return;
+	}
+
+	if ( is_sony_vaio_laptop )
+		pnp_bios_dont_use_current_config = 1;
+
+	for (check = (union pnpbios *) __va(0xf0000);
+	     check < (union pnpbios *) __va(0xffff0);
+	     ((void *) (check)) += 16) {
+		if (check->fields.signature != PNP_SIGNATURE)
+			continue;
+		length = check->fields.length;
+		if (!length)
+			continue;
+		for (sum = 0, i = 0; i < length; i++)
+			sum += check->chars[i];
+		if (sum)
+			continue;
+		if (check->fields.version < 0x10) {
+			printk(KERN_WARNING "PnPBIOS: unsupported version %d.%d",
+			       check->fields.version >> 4,
+			       check->fields.version & 15);
+			continue;
+		}
+		printk(KERN_INFO "PnPBIOS: PnP BIOS installation structure at 0x%p\n",
+		       check);
+		printk(KERN_INFO "PnPBIOS: PnP BIOS version %d.%d, entry at 0x%x:0x%x, dseg at 0x%x\n",
+                       check->fields.version >> 4, check->fields.version & 15,
+		       check->fields.pm16cseg, check->fields.pm16offset,
+		       check->fields.pm16dseg);
+		Q2_SET_SEL(PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
+		Q_SET_SEL(PNP_CS16, check->fields.pm16cseg, 64 * 1024);
+		Q_SET_SEL(PNP_DS, check->fields.pm16dseg, 64 * 1024);
+		pnp_bios_callpoint.offset = check->fields.pm16offset;
+		pnp_bios_callpoint.segment = PNP_CS16;
+		pnp_bios_inst_struc = check;
+		break;
+	}
+	pnpbios_build_devlist();
+#ifdef CONFIG_PROC_FS
+	pnp_proc_init( pnp_bios_dont_use_current_config );
+#endif
+#ifdef CONFIG_HOTPLUG	
+	init_completion(&unload_sem);
+	if(kernel_thread(pnp_dock_thread, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL)>0)
+		unloading = 0;
+#endif		
+}
 
+#ifdef MODULE
+/* We have to run it early and specifically in non modular.. */
+module_init(pnp_bios_init);
+
+#ifdef CONFIG_HOTPLUG
+static void pnp_bios_exit(void)
+{
+	unloading = 1;
+	wait_for_completion(&unload_sem);
+}
+
+module_exit(pnp_bios_exit);
+#endif
+#endif
diff -Naur -5 linux-2.4.9-ac16-pnpbiosviaofix/drivers/pnp/pnp_proc.c linux-2.4.9-ac16-pnpbiosfix/drivers/pnp/pnp_proc.c
--- linux-2.4.9-ac16-pnpbiosviaofix/drivers/pnp/pnp_proc.c	Fri Sep 28 22:28:31 2001
+++ linux-2.4.9-ac16-pnpbiosfix/drivers/pnp/pnp_proc.c	Fri Sep 28 23:07:53 2001
@@ -18,64 +18,65 @@
 static struct proc_dir_entry *proc_pnp = NULL;
 static struct proc_dir_entry *proc_pnp_boot = NULL;
 static struct pnp_dev_node_info node_info;
 
 static int proc_read_devices(char *buf, char **start, off_t pos,
-			     int count, int *eof, void *data)
+                             int count, int *eof, void *data)
 {
 	struct pnp_bios_node *node;
-	u8 num;
+	int i;
+	u8 nodenum;
 	char *p = buf;
 
 	if (pos != 0) {
 	    *eof = 1;
 	    return 0;
 	}
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	for (num = 0; num != 0xff; ) {
-		pnp_bios_get_dev_node(&num, 1, node);
+	for (i=0,nodenum=0;i<0xff && nodenum!=0xff; i++) {
+		pnp_bios_get_dev_node(&nodenum, 1, node);
 		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
 			     node->handle, node->eisa_id,
 			     node->type_code[0], node->type_code[1],
 			     node->type_code[2], node->flags);
 	}
 	kfree(node);
 	return (p-buf);
 }
 
 static int proc_read_node(char *buf, char **start, off_t pos,
-			  int count, int *eof, void *data)
+                          int count, int *eof, void *data)
 {
 	struct pnp_bios_node *node;
 	int boot = (long)data >> 8;
-	u8 num = (long)data;
+	u8 nodenum = (long)data;
 	int len;
 
 	if (pos != 0) {
 	    *eof = 1;
 	    return 0;
 	}
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	pnp_bios_get_dev_node(&num, boot, node);
+	pnp_bios_get_dev_node(&nodenum, boot, node);
 	len = node->size - sizeof(struct pnp_bios_node);
 	memcpy(buf, node->data, len);
 	kfree(node);
 	return len;
 }
 
 static int proc_write_node(struct file *file, const char *buf,
-			   unsigned long count, void *data)
+                           unsigned long count, void *data)
 {
 	struct pnp_bios_node *node;
 	int boot = (long)data >> 8;
-	u8 num = (long)data;
+	u8 nodenum = (long)data;
 
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	pnp_bios_get_dev_node(&num, boot, node);
+	pnp_bios_get_dev_node(&nodenum, boot, node);
 	if (count != node->size - sizeof(struct pnp_bios_node))
 		return -EINVAL;
 	memcpy(node->data, buf, count);
 	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
 	    return -EINVAL;
@@ -88,33 +89,31 @@
 void pnp_proc_init( int dont_use_current )
 {
 	struct pnp_bios_node *node;
 	struct proc_dir_entry *ent;
 	char name[3];
-	u8 num;
+	int i;
+	u8 nodenum;
 
 	pnp_proc_dont_use_current_config = dont_use_current;
 
 	if (!pnp_bios_present()) return;
-	if (pnp_bios_dev_node_info(&node_info) != 0)
-		return;
+	if (pnp_bios_dev_node_info(&node_info) != 0) return;
 	
 	proc_pnp = proc_mkdir("pnp", proc_bus);
 	if (!proc_pnp) return;
 	proc_pnp_boot = proc_mkdir("boot", proc_pnp);
 	if (!proc_pnp_boot) return;
-	create_proc_read_entry("devices", 0, proc_pnp,
-			       proc_read_devices, NULL);
+	create_proc_read_entry("devices", 0, proc_pnp, proc_read_devices, NULL);
 	
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return;
-	for (num = 0; num != 0xff; ) {
-		//sprintf(name, "%02x", num);
-		if (pnp_bios_get_dev_node(&num, 1, node) != 0)
+	for (i=0,nodenum = 0; i<0xff && nodenum != 0xff; i++) {
+		if (pnp_bios_get_dev_node(&nodenum, 1, node) != 0)
 			break;
 		sprintf(name, "%02x", node->handle);
-		if ( !dont_use_current ) {
+		if ( !pnp_proc_dont_use_current_config ) {
 			ent = create_proc_entry(name, 0, proc_pnp);
 			if (ent) {
 				ent->read_proc = proc_read_node;
 				ent->write_proc = proc_write_node;
 				ent->data = (void *)(long)(node->handle);
@@ -130,16 +129,17 @@
 	kfree(node);
 }
 
 void pnp_proc_done(void)
 {
-	u8 num;
+	int i;
 	char name[3];
 	
 	if (!proc_pnp) return;
-	for (num = 0; num != 0xff; num++) {
-		sprintf(name, "%02x", num);
+
+	for (i=0; i<0xff; i++) {
+		sprintf(name, "%02x", i);
 		if ( !pnp_proc_dont_use_current_config )
 			remove_proc_entry(name, proc_pnp);
 		remove_proc_entry(name, proc_pnp_boot);
 	}
 	remove_proc_entry("boot", proc_pnp);

--------------2DFD675411042CF0052647E6--

