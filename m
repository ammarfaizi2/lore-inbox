Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277384AbRJENmM>; Fri, 5 Oct 2001 09:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277389AbRJENmA>; Fri, 5 Oct 2001 09:42:00 -0400
Received: from hermes.toad.net ([162.33.130.251]:29642 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S277380AbRJENlf>;
	Fri, 5 Oct 2001 09:41:35 -0400
Subject: Re: [PATCH] PnPBIOS additional fixes
To: linux-kernel@vger.kernel.org
Date: Fri, 5 Oct 2001 09:41:28 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011005134128.E8EE941@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the "additional fixes" patch with some additional fixes.
(appended)

I've added checks of the return values of get_device_node() so
that the driver won't keep calling that function when it returns
an error.  This should be safer.  Stelian Pop has tested the
patch to confirm that it applies and runs cleanly on 2.4.10-ac4,
even if it unfortunately does not solve his BIOS-freaks-out-if-
asked-to-report-current-config problem.

See earlier posting for a list of the other things this patch does.

Cheers.
-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_mail.com)

The patch:
--- linux-2.4.10-ac4/drivers/pnp/pnp_bios.c	Tue Oct  2 23:41:00 2001
+++ linux-2.4.10-ac4-pnpbiosfix_b/drivers/pnp/pnp_bios.c	Thu Oct  4 23:56:52 2001
@@ -1,9 +1,10 @@
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
@@ -19,9 +20,8 @@
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
@@ -49,8 +49,6 @@
 /* PnP bios signature: "$PnP" */
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
-static void pnpbios_build_devlist(void);
-
 /*
  * This is the standard structure used to identify the entry point
  * to the Plug and Play bios
@@ -105,6 +103,7 @@
  * return to the caller if the call is within the first 64kB, and the linux
  * kernel begins at offset 3GB...
  */
+
 asmlinkage void pnp_bios_callfunc(void);
 
 __asm__(
@@ -130,7 +129,7 @@
 set_limit (gdt [(selname) >> 3], size)
 
 /*
- * Callable Functions
+ * Callable PnP BIOS functions
  */
 #define PNP_GET_NUM_SYS_DEV_NODES       0x00
 #define PNP_GET_SYS_DEV_NODE            0x01
@@ -148,8 +147,8 @@
 
 
 /*
- *	At some point we want to use this stack frame pointer to unwind
- *	after PnP BIOS oopses. 
+ * At some point we want to use this stack frame pointer to unwind
+ * after PnP BIOS oopses. 
  */
  
 u32 pnp_bios_fault_esp;
@@ -170,7 +169,7 @@
  	 *
  	 *	On some boxes IRQ's during PnP bios calls seem fatal
 	 */
-	
+
 	if(pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 		
@@ -197,10 +196,10 @@
 		"popl %%edi\n\t"
 		"popl %%ebp\n\t"
 		: "=a" (status)
-		: "0" ((func) | (arg1 << 16)),
-		  "b" ((arg2) | (arg3 << 16)),
-		  "c" ((arg4) | (arg5 << 16)),
-		  "d" ((arg6) | (arg7 << 16)),
+		: "0" ((func) | (((u32)arg1) << 16)),
+		  "b" ((arg2) | (((u32)arg3) << 16)),
+		  "c" ((arg4) | (((u32)arg5) << 16)),
+		  "d" ((arg6) | (((u32)arg7) << 16)),
 		  "i" (PNP_CS32),
 		  "i" (0)
 		: "memory"
@@ -219,9 +218,14 @@
 }
 
 /*
- * Call pnp bios with function 0x00, "get number of system device nodes"
+ *
+ * PnP BIOS ACCESS FUNCTIONS
+ *
  */
 
+/*
+ * Call PnP BIOS with function 0x00, "get number of system device nodes"
+ */
 int pnp_bios_dev_node_info(struct pnp_dev_node_info *data)
 {
 	u16 status;
@@ -233,13 +237,20 @@
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
-
 int pnp_bios_get_dev_node(u8 *nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
@@ -252,11 +263,11 @@
 }
 
 /*
- * Call pnp bios with function 0x02, "set system device node"
+ * Call PnP BIOS with function 0x02, "set system device node"
  * Input: *nodenum = desired node, 
- *        boot = whether to set static boot (!=0) or dynamic current (0) config
+ *        boot = whether to set nonvolatile boot (!=0)
+ *               or volatile current (0) config
  */
-
 int pnp_bios_set_dev_node(u8 nodenum, char boot, struct pnp_bios_node *data)
 {
 	u16 status;
@@ -267,11 +278,10 @@
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
@@ -283,10 +293,10 @@
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
@@ -299,9 +309,8 @@
 
 #ifdef CONFIG_HOTPLUG
 /*
- * Call pnp bios with function 0x05, "get docking station information"
+ * Call PnP BIOS with function 0x05, "get docking station information"
  */
-
 static int pnp_bios_dock_station_info(struct pnp_docking_station_info *data)
 {
 	u16 status;
@@ -313,11 +322,11 @@
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
@@ -329,11 +338,11 @@
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
@@ -345,10 +354,10 @@
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
@@ -361,10 +370,10 @@
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
@@ -376,10 +385,10 @@
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
@@ -391,11 +400,11 @@
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
@@ -409,10 +418,10 @@
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
@@ -426,22 +435,24 @@
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
@@ -497,9 +508,8 @@
 }
 
 /*
- *	Poll the PnP docking at a regular interval
+ * Poll the PnP docking at a regular interval
  */
- 
 static int pnp_dock_thread(void * unused)
 {
 	static struct pnp_docking_station_info now;
@@ -512,9 +522,8 @@
 		int err;
 		
 		/*
-		 *	Poll every 2 seconds
+		 * Poll every 2 seconds
 		 */
-		 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ*2);
 		if(signal_pending(current))
@@ -526,7 +535,7 @@
 		switch(err)
 		{
 			/*
-			 *	No dock to manage
+			 * No dock to manage
 			 */
 			case PNP_FUNCTION_NOT_SUPPORTED:
 				complete_and_exit(&unload_sem, 0);
@@ -554,137 +563,55 @@
 
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
 }
 
-static void __init pnpbios_add_ioresource(struct pci_dev *dev, int io, 
-					  int len, int flags)
+static void __init pnpbios_add_ioresource(struct pci_dev *dev, int io, int len)
 {
 	int i = 0;
-	while (dev->resource[i].start && i < DEVICE_COUNT_RESOURCE) i++;
+	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
 	if (i < DEVICE_COUNT_RESOURCE) {
 		dev->resource[i].start = io;
 		dev->resource[i].end = io + len;
-		dev->resource[i].flags = flags;
+		dev->resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
 	}
 }
 
-static char * __init pnpid32_to_pnpid(u32 id);
+static void __init pnpbios_add_memresource(struct pci_dev *dev, int io, int len)
+{
+	int i = 0;
+	while (!(dev->resource[i].flags & IORESOURCE_UNSET) && i < DEVICE_COUNT_RESOURCE) i++;
+	if (i < DEVICE_COUNT_RESOURCE) {
+		dev->resource[i].start = io;
+		dev->resource[i].end = io + len;
+		dev->resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+	}
+}
 
 /*
  * request I/O ports which are used according to the PnP BIOS
@@ -692,70 +619,127 @@
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
 
-/* parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev */
-static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *pci_dev)
+
+#define HEX(id,a) hex[((id)>>a) & 15]
+#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
+
+static char * __init pnpid32_to_pnpid(u32 id)
+{
+	const char *hex = "0123456789abcdef";
+	static char str[8];
+	id = be32_to_cpu(id);
+	str[0] = CHAR(id, 26);
+	str[1] = CHAR(id, 21);
+	str[2] = CHAR(id,16);
+	str[3] = HEX(id, 12);
+	str[4] = HEX(id, 8);
+	str[5] = HEX(id, 4);
+	str[6] = HEX(id, 0);
+	str[7] = '\0';
+	return str;
+}                                              
+
+#undef CHAR
+#undef HEX  
+
+/*
+ * parse PNPBIOS "Allocated Resources Block" and fill IO,IRQ,DMA into pci_dev
+ */
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
@@ -764,65 +748,62 @@
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
-}
-
-#define HEX(id,a) hex[((id)>>a) & 15]
-#define CHAR(id,a) (0x40 + (((id)>>a) & 31))
+        } /* while */
 
-static char * __init pnpid32_to_pnpid(u32 id)
-{
-	const char *hex = "0123456789abcdef";
-        static char str[8];
-	id = be32_to_cpu(id);
-	str[0] = CHAR(id, 26);
-	str[1] = CHAR(id, 21);
-	str[2] = CHAR(id,16);
-	str[3] = HEX(id, 12);
-	str[4] = HEX(id, 8);
-	str[5] = HEX(id, 4);
-	str[6] = HEX(id, 0);
-	str[7] = '\0';
-	return str;
-}                                              
-
-#undef CHAR
-#undef HEX  
+        return;
+}
 
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
@@ -836,37 +817,39 @@
  
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
+		/* For now we build the list from the "boot" config
+		 * because asking for the "current" config causes
+		 * some BIOSes to crash.
+		 */
+		if (pnp_bios_get_dev_node((u8 *)&nodenum, (char )1 , node))
+			break;
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
@@ -875,17 +858,19 @@
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
@@ -895,7 +880,7 @@
 		num=0; /* Start from beginning */
 	else
 		num=prev->devfn + 1; /* Encode node number here */
-	
+
 
 	pnpbios_for_each_dev(dev)
 	{
@@ -1018,4 +1003,106 @@
 
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
+
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
--- linux-2.4.10-ac4/drivers/pnp/pnp_proc.c	Tue Oct  2 23:41:00 2001
+++ linux-2.4.10-ac4-pnpbiosfix_b/drivers/pnp/pnp_proc.c	Thu Oct  4 23:57:02 2001
@@ -20,10 +20,11 @@
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
@@ -32,8 +33,9 @@
 	}
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	for (num = 0; num != 0xff; ) {
-		pnp_bios_get_dev_node(&num, 1, node);
+	for (i=0,nodenum=0;i<0xff && nodenum!=0xff; i++) {
+		if ( pnp_bios_get_dev_node(&nodenum, 1, node) )
+			break;
 		p += sprintf(p, "%02x\t%08x\t%02x:%02x:%02x\t%04x\n",
 			     node->handle, node->eisa_id,
 			     node->type_code[0], node->type_code[1],
@@ -44,11 +46,11 @@
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
@@ -57,7 +59,8 @@
 	}
 	node = kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	pnp_bios_get_dev_node(&num, boot, node);
+	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
+		return -EIO;
 	len = node->size - sizeof(struct pnp_bios_node);
 	memcpy(buf, node->data, len);
 	kfree(node);
@@ -65,15 +68,16 @@
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
+	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
+		return -EIO;
 	if (count != node->size - sizeof(struct pnp_bios_node))
 		return -EINVAL;
 	memcpy(node->data, buf, count);
@@ -90,29 +94,27 @@
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
@@ -132,12 +134,13 @@
 
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
