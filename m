Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUBYDir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbUBYDir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:38:47 -0500
Received: from ozlabs.org ([203.10.76.45]:15557 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262416AbUBYDhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:37:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16444.6188.580683.996134@cargo.ozlabs.ibm.com>
Date: Wed, 25 Feb 2004 14:36:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH][PPC64] Clean up IRQ mapping code
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the larger ppc64 machines we remap the interrupt numbers used by
the hardware/firmware to virtual IRQ numbers < NR_IRQS.  Up until now
we have used an array for the "real" (hardware) -> virtual IRQ number
mapping, but with new machines coming out that will have 24-bit
hardware IRQ numbers, this will break.  However, in fact it is only
the XICS interrupt controller which cares about this mapping.  This
patch moves that side of the mapping (real -> virtual) into the XICS
code and makes it use a radix tree.

On iSeries we have a similar issue, where the "real" IRQ numbers that
we need are in fact an encoding of the bus/device/function address of
the device.  This patch fixes iSeries to use the virt->real IRQ
mapping, allowing us to support larger iSeries machines.  This patch
also gets rid of the temporary hack that Stephen Rothwell submitted.

On machines with OpenPIC (including the G5) the mapping is explicitly
1-1, and that hasn't changed.  For other machines this patch cleans up
and simplifies the code that sets up the virtual->real mapping.

I have tested this code and verified that G5, pSeries and iSeries boot
and run correctly with this patch.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc64/kernel/iSeries_irq.c test/arch/ppc64/kernel/iSeries_irq.c
--- linux-2.5/arch/ppc64/kernel/iSeries_irq.c	2004-02-23 12:05:11.000000000 +1100
+++ test/arch/ppc64/kernel/iSeries_irq.c	2004-02-25 13:54:12.339507740 +1100
@@ -55,19 +55,18 @@
 	.end = iSeries_end_IRQ
 };
 
-void iSeries_init_irq_desc(irq_desc_t *desc)
-{
-	desc->handler = &iSeries_IRQ_handler;
-}
+/* This maps virtual irq numbers to real irqs */
+unsigned int virt_irq_to_real_map[NR_IRQS];
+
+/* The next available virtual irq number */
+/* Note: the pcnet32 driver assumes irq numbers < 2 aren't valid. :( */
+static int next_virtual_irq = 2;
 
 /* This is called by init_IRQ.  set in ppc_md.init_IRQ by iSeries_setup.c */
 void __init iSeries_init_IRQ(void)
 {
 	/* Register PCI event handler and open an event path */
-	PPCDBG(PPCDBG_BUSWALK,
-			"Register PCI event handler and open an event path\n");
 	XmPciLpEvent_init();
-	return;
 }
 
 /*
@@ -78,25 +77,32 @@
 int __init iSeries_allocate_IRQ(HvBusNumber busNumber,
 		HvSubBusNumber subBusNumber, HvAgentId deviceId)
 {
+	unsigned int realirq, virtirq;
 	u8 idsel = (deviceId >> 4);
 	u8 function = deviceId & 7;
 
-	return ((busNumber - 1) << 6) + ((idsel - 1) << 3) + function + 1;
+	virtirq = next_virtual_irq++;
+	realirq = ((busNumber - 1) << 6) + ((idsel - 1) << 3) + function;
+	virt_irq_to_real_map[virtirq] = realirq;
+
+	irq_desc[virtirq].handler = &iSeries_IRQ_handler;
+	return virtirq;
 }
 
-#define IRQ_TO_BUS(irq)		(((((irq) - 1) >> 6) & 0xff) + 1)
-#define IRQ_TO_IDSEL(irq)	(((((irq) - 1) >> 3) & 7) + 1)
-#define IRQ_TO_FUNC(irq)	(((irq) - 1) & 7)
+#define REAL_IRQ_TO_BUS(irq)	((((irq) >> 6) & 0xff) + 1)
+#define REAL_IRQ_TO_IDSEL(irq)	((((irq) >> 3) & 7) + 1)
+#define REAL_IRQ_TO_FUNC(irq)	((irq) & 7)
 
 /* This is called by iSeries_activate_IRQs */
 static unsigned int iSeries_startup_IRQ(unsigned int irq)
 {
 	u32 bus, deviceId, function, mask;
 	const u32 subBus = 0;
+	unsigned int rirq = virt_irq_to_real_map[irq];
 
-	bus = IRQ_TO_BUS(irq);
-	function = IRQ_TO_FUNC(irq);
-	deviceId = (IRQ_TO_IDSEL(irq) << 4) + function;
+	bus = REAL_IRQ_TO_BUS(rirq);
+	function = REAL_IRQ_TO_FUNC(rirq);
+	deviceId = (REAL_IRQ_TO_IDSEL(rirq) << 4) + function;
 
 	/* Link the IRQ number to the bridge */
 	HvCallXm_connectBusUnit(bus, subBus, deviceId, irq);
@@ -104,17 +110,10 @@
 	/* Unmask bridge interrupts in the FISR */
 	mask = 0x01010000 << function;
 	HvCallPci_unmaskFisr(bus, subBus, deviceId, mask);
-	PPCDBG(PPCDBG_BUSWALK, "iSeries_activate_IRQ 0x%02X.%02X.%02X  Irq:0x%02X\n",
-				bus, subBus, deviceId, irq);
 	return 0;
 }
 
 /*
- * Temporary hack
- */
-#define get_irq_desc(irq)	&irq_desc[(irq)]
-
-/*
  * This is called out of iSeries_fixup to activate interrupt
  * generation for usable slots
  */
@@ -124,7 +123,7 @@
 	unsigned long flags;
 
 	for (irq = 0; irq < NR_IRQS; irq++) {
-		irq_desc_t *desc = get_irq_desc(irq);
+		irq_desc_t *desc = &irq_desc[irq];
 
 		if (desc && desc->handler && desc->handler->startup) {
 			spin_lock_irqsave(&desc->lock, flags);
@@ -139,11 +138,12 @@
 {
 	u32 bus, deviceId, function, mask;
 	const u32 subBus = 0;
+	unsigned int rirq = virt_irq_to_real_map[irq];
 
 	/* irq should be locked by the caller */
-	bus = IRQ_TO_BUS(irq);
-	function = IRQ_TO_FUNC(irq);
-	deviceId = (IRQ_TO_IDSEL(irq) << 4) + function;
+	bus = REAL_IRQ_TO_BUS(rirq);
+	function = REAL_IRQ_TO_FUNC(rirq);
+	deviceId = (REAL_IRQ_TO_IDSEL(rirq) << 4) + function;
 
 	/* Invalidate the IRQ number in the bridge */
 	HvCallXm_connectBusUnit(bus, subBus, deviceId, 0);
@@ -161,11 +161,12 @@
 {
 	u32 bus, deviceId, function, mask;
 	const u32 subBus = 0;
+	unsigned int rirq = virt_irq_to_real_map[irq];
 
 	/* The IRQ has already been locked by the caller */
-	bus = IRQ_TO_BUS(irq);
-	function = IRQ_TO_FUNC(irq);
-	deviceId = (IRQ_TO_IDSEL(irq) << 4) + function;
+	bus = REAL_IRQ_TO_BUS(rirq);
+	function = REAL_IRQ_TO_FUNC(rirq);
+	deviceId = (REAL_IRQ_TO_IDSEL(rirq) << 4) + function;
 
 	/* Mask secondary INTA   */
 	mask = 0x80000000;
@@ -182,11 +183,12 @@
 {
 	u32 bus, deviceId, function, mask;
 	const u32 subBus = 0;
+	unsigned int rirq = virt_irq_to_real_map[irq];
 
 	/* The IRQ has already been locked by the caller */
-	bus = IRQ_TO_BUS(irq);
-	function = IRQ_TO_FUNC(irq);
-	deviceId = (IRQ_TO_IDSEL(irq) << 4) + function;
+	bus = REAL_IRQ_TO_BUS(rirq);
+	function = REAL_IRQ_TO_FUNC(rirq);
+	deviceId = (REAL_IRQ_TO_IDSEL(rirq) << 4) + function;
 
 	/* Unmask secondary INTA */
 	mask = 0x80000000;
diff -urN linux-2.5/arch/ppc64/kernel/iSeries_pci.c test/arch/ppc64/kernel/iSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/iSeries_pci.c	2004-02-23 12:05:11.000000000 +1100
+++ test/arch/ppc64/kernel/iSeries_pci.c	2004-02-25 13:54:12.343507099 +1100
@@ -277,6 +277,7 @@
 		} else
 			printk("PCI: Device Tree not found for 0x%016lX\n",
 					(unsigned long)pdev);
+		pdev->irq = node->Irq;
 	}
 	iSeries_IoMmTable_Status();
 	iSeries_activate_IRQs();
@@ -423,8 +424,6 @@
 					      Bus, SubBus, AgentId, HvRc);
 				continue;
 			}
-			printk("connected bus unit at bus %d subbus 0x%x agentid 0x%x (idsel=%d func=%d)\n",
-			       Bus, SubBus, AgentId, IdSel, Function);
 
 			HvRc = HvCallPci_configLoad16(Bus, SubBus, AgentId,
 						      PCI_VENDOR_ID, &VendorId);
@@ -437,8 +436,8 @@
 
 			/* FoundDevice: 0x18.28.10 = 0x12AE */
 			PPCDBG(PPCDBG_BUSWALK,
-			       "PCI:- FoundDevice: 0x%02X.%02X.%02X = 0x%04X\n",
-			       Bus, SubBus, AgentId, VendorId);
+			       "PCI:- FoundDevice: 0x%02X.%02X.%02X = 0x%04X, irq %d\n",
+			       Bus, SubBus, AgentId, VendorId, Irq);
 			HvRc = HvCallPci_configStore8(Bus, SubBus, AgentId,
 						      PCI_INTERRUPT_LINE, Irq);  
 			if (HvRc != 0)
diff -urN linux-2.5/arch/ppc64/kernel/irq.c test/arch/ppc64/kernel/irq.c
--- linux-2.5/arch/ppc64/kernel/irq.c	2004-02-25 13:03:58.690768253 +1100
+++ test/arch/ppc64/kernel/irq.c	2004-02-25 13:54:12.356505018 +1100
@@ -120,6 +120,8 @@
 	if (!shared) {
 		desc->depth = 0;
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
+		if (desc->handler && desc->handler->startup)
+			desc->handler->startup(irq);
 		unmask_irq(irq);
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);
@@ -823,3 +825,79 @@
 {
 	return IRQ_NONE;
 }
+
+#ifndef CONFIG_PPC_ISERIES
+/*
+ * Virtual IRQ mapping code, used on systems with XICS interrupt controllers.
+ */
+
+#define UNDEFINED_IRQ 0xffffffff
+unsigned int virt_irq_to_real_map[NR_IRQS];
+
+/*
+ * Don't use virtual irqs 0, 1, 2 for devices.
+ * The pcnet32 driver considers interrupt numbers < 2 to be invalid,
+ * and 2 is the XICS IPI interrupt.
+ * We limit virtual irqs to 17 less than NR_IRQS so that when we
+ * offset them by 16 (to reserve the first 16 for ISA interrupts)
+ * we don't end up with an interrupt number >= NR_IRQS.
+ */
+#define MIN_VIRT_IRQ	3
+#define MAX_VIRT_IRQ	(NR_IRQS - NUM_8259_INTERRUPTS - 1)
+#define NR_VIRT_IRQS	(MAX_VIRT_IRQ - MIN_VIRT_IRQ + 1)
+
+void
+virt_irq_init(void)
+{
+	int i;
+	for (i = 0; i < NR_IRQS; i++)
+		virt_irq_to_real_map[i] = UNDEFINED_IRQ;
+}
+
+/* Create a mapping for a real_irq if it doesn't already exist.
+ * Return the virtual irq as a convenience.
+ */
+int virt_irq_create_mapping(unsigned int real_irq)
+{
+	unsigned int virq, first_virq;
+	static int warned;
+
+	if (naca->interrupt_controller == IC_OPEN_PIC)
+		return real_irq;	/* no mapping for openpic (for now) */
+
+	/* don't map interrupts < MIN_VIRT_IRQ */
+	if (real_irq < MIN_VIRT_IRQ) {
+		virt_irq_to_real_map[real_irq] = real_irq;
+		return real_irq;
+	}
+
+	/* map to a number between MIN_VIRT_IRQ and MAX_VIRT_IRQ */
+	virq = real_irq;
+	if (virq > MAX_VIRT_IRQ)
+		virq = (virq % NR_VIRT_IRQS) + MIN_VIRT_IRQ;
+
+	/* search for this number or a free slot */
+	first_virq = virq;
+	while (virt_irq_to_real_map[virq] != UNDEFINED_IRQ) {
+		if (virt_irq_to_real_map[virq] == real_irq)
+			return virq;
+		if (++virq > MAX_VIRT_IRQ)
+			virq = MIN_VIRT_IRQ;
+		if (virq == first_virq)
+			goto nospace;	/* oops, no free slots */
+	}
+
+	virt_irq_to_real_map[virq] = real_irq;
+	return virq;
+
+ nospace:
+	if (!warned) {
+		printk(KERN_CRIT "Interrupt table is full\n");
+		printk(KERN_CRIT "Increase NR_IRQS (currently %d) "
+		       "in your kernel sources and rebuild.\n", NR_IRQS);
+		warned = 1;
+	}
+	return NO_IRQ;
+}
+
+#endif
diff -urN linux-2.5/arch/ppc64/kernel/prom.c test/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2004-02-25 13:03:58.730761850 +1100
+++ test/arch/ppc64/kernel/prom.c	2004-02-25 13:54:12.379633438 +1100
@@ -152,11 +152,6 @@
  */
 static rwlock_t devtree_lock = RW_LOCK_UNLOCKED;
 
-#define UNDEFINED_IRQ 0xffff
-unsigned short real_irq_to_virt_map[NR_HW_IRQS];
-unsigned short virt_irq_to_real_map[NR_IRQS];
-int last_virt_irq = 2;	/* index of last virt_irq.  Skip through IPI */
-
 static unsigned long call_prom(const char *service, int nargs, int nret, ...);
 static void prom_panic(const char *reason);
 static unsigned long copy_device_tree(unsigned long);
@@ -1678,45 +1673,6 @@
 	return DOUBLEWORD_ALIGN(mem);
 }
 
-void
-virt_irq_init(void)
-{
-	int i;
-	for (i = 0; i < NR_IRQS; i++)
-		virt_irq_to_real_map[i] = UNDEFINED_IRQ;
-	for (i = 0; i < NR_HW_IRQS; i++)
-		real_irq_to_virt_map[i] = UNDEFINED_IRQ;
-}
-
-/* Create a mapping for a real_irq if it doesn't already exist.
- * Return the virtual irq as a convenience.
- */
-unsigned long
-virt_irq_create_mapping(unsigned long real_irq)
-{
-	unsigned long virq;
-	if (naca->interrupt_controller == IC_OPEN_PIC)
-		return real_irq;	/* no mapping for openpic (for now) */
-	virq = real_irq_to_virt(real_irq);
-	if (virq == UNDEFINED_IRQ) {
-		/* Assign a virtual IRQ number */
-		if (real_irq < NR_IRQS && virt_irq_to_real(real_irq) == UNDEFINED_IRQ) {
-			/* A 1-1 mapping will work. */
-			virq = real_irq;
-		} else {
-			while (last_virt_irq < NR_IRQS &&
-			       virt_irq_to_real(++last_virt_irq) != UNDEFINED_IRQ)
-				/* skip irq's in use */;
-			if (last_virt_irq >= NR_IRQS)
-				panic("Too many IRQs are required on this system.  NR_IRQS=%d\n", NR_IRQS);
-			virq = last_virt_irq;
-		}
-		virt_irq_to_real_map[virq] = real_irq;
-		real_irq_to_virt_map[real_irq] = virq;
-	}
-	return virq;
-}
-
 
 static int __init
 prom_next_node(phandle *nodep)
@@ -2082,7 +2038,7 @@
 	unsigned int *ints;
 	int intlen, intrcells;
 	int i, j, n;
-	unsigned int *irq;
+	unsigned int *irq, virq;
 	struct device_node *ic;
 
 	ints = (unsigned int *) get_property(np, "interrupts", &intlen);
@@ -2100,7 +2056,13 @@
 		n = map_interrupt(&irq, &ic, np, ints, intrcells);
 		if (n <= 0)
 			continue;
-		np->intrs[i].line = openpic_to_irq(virt_irq_create_mapping(irq[0]));
+		virq = virt_irq_create_mapping(irq[0]);
+		if (virq == NO_IRQ) {
+			printk(KERN_CRIT "Could not allocate interrupt "
+			       "number for %s\n", np->full_name);
+		} else
+			np->intrs[i].line = openpic_to_irq(virq);
+
 		/* We offset irq numbers for the u3 MPIC by 128 in PowerMac */
 		if (systemcfg->platform == PLATFORM_POWERMAC && ic && ic->parent) {
 			char *name = get_property(ic->parent, "name", NULL);
@@ -2941,7 +2903,7 @@
 	unsigned int *ints;
 	int intlen, intrcells;
 	int i, j, n, err = 0;
-	unsigned int *irq;
+	unsigned int *irq, virq;
 	struct device_node *ic;
  
 	node->name = get_property(node, "name", 0);
@@ -3010,7 +2972,12 @@
 		n = map_interrupt(&irq, &ic, node, ints, intrcells);
 		if (n <= 0)
 			continue;
-		node->intrs[i].line = openpic_to_irq(virt_irq_create_mapping(irq[0]));
+		virq = virt_irq_create_mapping(irq[0]);
+		if (virq == NO_IRQ) {
+			printk(KERN_CRIT "Could not allocate interrupt "
+			       "number for %s\n", node->full_name);
+		} else
+			node->intrs[i].line = openpic_to_irq(virq);
 		if (n > 1)
 			node->intrs[i].sense = irq[1];
 		if (n > 2) {
diff -urN linux-2.5/arch/ppc64/kernel/ras.c test/arch/ppc64/kernel/ras.c
--- linux-2.5/arch/ppc64/kernel/ras.c	2004-01-20 08:20:24.000000000 +1100
+++ test/arch/ppc64/kernel/ras.c	2004-02-25 13:54:12.382632958 +1100
@@ -69,12 +69,19 @@
 {
 	struct device_node *np;
 	unsigned int *ireg, len, i;
+	int virq;
 
 	if ((np = of_find_node_by_path("/event-sources/internal-errors")) &&
 	    (ireg = (unsigned int *)get_property(np, "open-pic-interrupt",
 						 &len))) {
 		for (i=0; i<(len / sizeof(*ireg)); i++) {
-			request_irq(virt_irq_create_mapping(*(ireg)) + NUM_8259_INTERRUPTS, 
+			virq = virt_irq_create_mapping(*(ireg));
+			if (virq == NO_IRQ) {
+				printk(KERN_ERR "Unable to allocate interrupt "
+				       "number for %s\n", np->full_name);
+				break;
+			}
+			request_irq(virq + NUM_8259_INTERRUPTS, 
 				    ras_error_interrupt, 0, 
 				    "RAS_ERROR", NULL);
 			ireg++;
@@ -86,7 +93,13 @@
 	    (ireg = (unsigned int *)get_property(np, "open-pic-interrupt",
 						 &len))) {
 		for (i=0; i<(len / sizeof(*ireg)); i++) {
-			request_irq(virt_irq_create_mapping(*(ireg)) + NUM_8259_INTERRUPTS, 
+			virq = virt_irq_create_mapping(*(ireg));
+			if (virq == NO_IRQ) {
+				printk(KERN_ERR "Unable to allocate interrupt "
+				       " number for %s\n", np->full_name);
+				break;
+			}
+			request_irq(virq + NUM_8259_INTERRUPTS, 
 				    ras_epow_interrupt, 0, 
 				    "RAS_EPOW", NULL);
 			ireg++;
diff -urN linux-2.5/arch/ppc64/kernel/vio.c test/arch/ppc64/kernel/vio.c
--- linux-2.5/arch/ppc64/kernel/vio.c	2004-02-07 17:58:35.000000000 +1100
+++ test/arch/ppc64/kernel/vio.c	2004-02-25 13:54:12.387632157 +1100
@@ -242,10 +242,15 @@
 	viodev->unit_address = *unit_address;
 	viodev->tce_table = vio_build_tce_table(viodev);
 
-	viodev->irq = (unsigned int) -1;
+	viodev->irq = NO_IRQ;
 	irq_p = (unsigned int *)get_property(of_node, "interrupts", 0);
 	if (irq_p) {
-		viodev->irq = openpic_to_irq(virt_irq_create_mapping(*irq_p));
+		int virq = virt_irq_create_mapping(*irq_p);
+		if (virq == NO_IRQ) {
+			printk(KERN_ERR "Unable to allocate interrupt "
+			       "number for %s\n", of_node->full_name);
+		} else
+			viodev->irq = openpic_to_irq(virq);
 	}
 
 	/* init generic 'struct device' fields: */
diff -urN linux-2.5/arch/ppc64/kernel/xics.c test/arch/ppc64/kernel/xics.c
--- linux-2.5/arch/ppc64/kernel/xics.c	2004-02-25 13:03:58.759757209 +1100
+++ test/arch/ppc64/kernel/xics.c	2004-02-25 13:54:12.392631356 +1100
@@ -17,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/signal.h>
 #include <linux/init.h>
+#include <linux/gfp.h>
+#include <linux/radix-tree.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
@@ -30,33 +32,31 @@
 
 #include "i8259.h"
 
-void xics_enable_irq(u_int irq);
-void xics_disable_irq(u_int irq);
-void xics_mask_and_ack_irq(u_int irq);
-void xics_end_irq(u_int irq);
-void xics_set_affinity(unsigned int irq_nr, cpumask_t cpumask);
+static unsigned int xics_startup(unsigned int irq);
+static void xics_enable_irq(unsigned int irq);
+static void xics_disable_irq(unsigned int irq);
+static void xics_mask_and_ack_irq(unsigned int irq);
+static void xics_end_irq(unsigned int irq);
+static void xics_set_affinity(unsigned int irq_nr, cpumask_t cpumask);
 
 struct hw_interrupt_type xics_pic = {
-	" XICS     ",
-	NULL,
-	NULL,
-	xics_enable_irq,
-	xics_disable_irq,
-	xics_mask_and_ack_irq,
-	xics_end_irq,
-	xics_set_affinity
+	.typename = " XICS     ",
+	.startup = xics_startup,
+	.enable = xics_enable_irq,
+	.disable = xics_disable_irq,
+	.ack = xics_mask_and_ack_irq,
+	.end = xics_end_irq,
+	.set_affinity = xics_set_affinity
 };
 
 struct hw_interrupt_type xics_8259_pic = {
-	" XICS/8259",
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	xics_mask_and_ack_irq,
-	NULL
+	.typename = " XICS/8259",
+	.ack = xics_mask_and_ack_irq,
 };
 
+/* This is used to map real irq numbers to virtual */
+static struct radix_tree_root irq_map = RADIX_TREE_INIT(GFP_KERNEL);
+
 #define XICS_IPI		2
 #define XICS_IRQ_OFFSET		0x10
 #define XICS_IRQ_SPURIOUS	0
@@ -214,9 +214,30 @@
 	pSeriesLP_qirr_info
 };
 
-void xics_enable_irq(u_int virq)
+static unsigned int xics_startup(unsigned int virq)
+{
+	virq -= XICS_IRQ_OFFSET;
+	if (radix_tree_insert(&irq_map, virt_irq_to_real(virq),
+			      &virt_irq_to_real_map[virq]) == -ENOMEM)
+		printk(KERN_CRIT "Out of memory creating real -> virtual"
+		       " IRQ mapping for irq %u (real 0x%x)\n",
+		       virq, virt_irq_to_real(virq));
+	return 0;	/* return value is ignored */
+}
+
+static unsigned int real_irq_to_virt(unsigned int real_irq)
 {
-	u_int irq;
+	unsigned int *ptr;
+
+	ptr = radix_tree_lookup(&irq_map, real_irq);
+	if (ptr == NULL)
+		return NO_IRQ;
+	return ptr - virt_irq_to_real_map;
+}
+
+static void xics_enable_irq(unsigned int virq)
+{
+	unsigned int irq;
 	long call_status;
 	unsigned int server;
 
@@ -237,34 +258,31 @@
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
 	if (call_status != 0) {
-		printk("xics_enable_irq: irq=%x: ibm_set_xive returned %lx\n",
-		       irq, call_status);
+		printk(KERN_ERR "xics_enable_irq: irq=%x: ibm_set_xive "
+		       "returned %lx\n", irq, call_status);
 		return;
 	}
 
 	/* Now unmask the interrupt (often a no-op) */
 	call_status = rtas_call(ibm_int_on, 1, 1, NULL, irq);
 	if (call_status != 0) {
-		printk("xics_enable_irq: irq=%x: ibm_int_on returned %lx\n",
-		       irq, call_status);
+		printk(KERN_ERR "xics_enable_irq: irq=%x: ibm_int_on "
+		       "returned %lx\n", irq, call_status);
 		return;
 	}
 }
 
-void xics_disable_irq(u_int virq)
+static void xics_disable_real_irq(unsigned int irq)
 {
-	u_int irq;
 	long call_status;
 
-	virq -= XICS_IRQ_OFFSET;
-	irq = virt_irq_to_real(virq);
 	if (irq == XICS_IPI)
 		return;
 
 	call_status = rtas_call(ibm_int_off, 1, 1, NULL, irq);
 	if (call_status != 0) {
-		printk("xics_disable_irq: irq=%x: ibm_int_off returned %lx\n",
-		       irq, call_status);
+		printk(KERN_ERR "xics_disable_real_irq: irq=%x: "
+		       "ibm_int_off returned %lx\n", irq, call_status);
 		return;
 	}
 
@@ -272,13 +290,22 @@
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, default_server,
 				0xff);
 	if (call_status != 0) {
-	printk("xics_disable_irq: irq=%x: ibm_set_xive(0xff) returned %lx\n",
-	       irq, call_status);
+		printk(KERN_ERR "xics_disable_irq: irq=%x: ibm_set_xive(0xff)"
+		       " returned %lx\n", irq, call_status);
 		return;
 	}
 }
 
-void xics_end_irq(u_int	irq)
+static void xics_disable_irq(unsigned int virq)
+{
+	unsigned int irq;
+
+	virq -= XICS_IRQ_OFFSET;
+	irq = virt_irq_to_real(virq);
+	xics_disable_real_irq(irq);
+}
+
+static void xics_end_irq(unsigned int	irq)
 {
 	int cpu = smp_processor_id();
 
@@ -287,7 +314,7 @@
 				 (virt_irq_to_real(irq-XICS_IRQ_OFFSET))));
 }
 
-void xics_mask_and_ack_irq(u_int irq)
+static void xics_mask_and_ack_irq(unsigned int irq)
 {
 	int cpu = smp_processor_id();
 
@@ -302,8 +329,8 @@
 
 int xics_get_irq(struct pt_regs *regs)
 {
-	u_int cpu = smp_processor_id();
-	u_int vec;
+	unsigned int cpu = smp_processor_id();
+	unsigned int vec;
 	int irq;
 
 	vec = ops->xirr_info_get(cpu);
@@ -321,7 +348,13 @@
 	} else if (vec == XICS_IRQ_SPURIOUS) {
 		irq = -1;
 	} else {
-		irq = real_irq_to_virt(vec) + XICS_IRQ_OFFSET;
+		irq = real_irq_to_virt(vec);
+		if (irq == NO_IRQ) {
+			printk(KERN_ERR "Interrupt 0x%x (real) is invalid,"
+			       " disabling it.\n", vec);
+			xics_disable_real_irq(vec);
+		} else
+			irq += XICS_IRQ_OFFSET;
 	}
 	return irq;
 }
@@ -469,7 +502,8 @@
 			while (1);
 		}
 		xics_irq_8259_cascade_real = *ireg;
-		xics_irq_8259_cascade = virt_irq_create_mapping(xics_irq_8259_cascade_real);
+		xics_irq_8259_cascade
+			= virt_irq_create_mapping(xics_irq_8259_cascade_real);
 		of_node_put(np);
 	}
 
@@ -526,8 +560,8 @@
 #ifdef CONFIG_SMP
 void xics_request_IPIs(void)
 {
-	real_irq_to_virt_map[XICS_IPI] = virt_irq_to_real_map[XICS_IPI] =
-		XICS_IPI;
+	virt_irq_to_real_map[XICS_IPI] = XICS_IPI;
+
 	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
 	request_irq(XICS_IPI + XICS_IRQ_OFFSET, xics_ipi_action, SA_INTERRUPT,
 		    "IPI", 0);
@@ -535,7 +569,7 @@
 }
 #endif
 
-void xics_set_affinity(unsigned int virq, cpumask_t cpumask)
+static void xics_set_affinity(unsigned int virq, cpumask_t cpumask)
 {
         irq_desc_t *desc = irq_desc + virq;
 	unsigned int irq;
@@ -556,8 +590,8 @@
 	status = rtas_call(ibm_get_xive, 1, 3, (void *)&xics_status, irq);
 
 	if (status) {
-		printk("xics_set_affinity: irq=%d ibm,get-xive returns %ld\n",
-			irq, status);
+		printk(KERN_ERR "xics_set_affinity: irq=%d ibm,get-xive "
+		       "returns %ld\n", irq, status);
 		goto out;
 	}
 
@@ -575,8 +609,8 @@
 				irq, newmask, xics_status[1]);
 
 	if (status) {
-		printk("xics_set_affinity irq=%d ibm,set-xive returns %ld\n",
-			irq, status);
+		printk(KERN_ERR "xics_set_affinity irq=%d ibm,set-xive "
+		       "returns %ld\n", irq, status);
 		goto out;
 	}
 
diff -urN linux-2.5/include/asm-ppc64/irq.h test/include/asm-ppc64/irq.h
--- linux-2.5/include/asm-ppc64/irq.h	2004-01-20 08:20:26.000000000 +1100
+++ test/include/asm-ppc64/irq.h	2004-02-25 13:54:12.393631196 +1100
@@ -15,6 +15,9 @@
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
 
+/* this number is used when no interrupt has been assigned */
+#define NO_IRQ			(-1)
+
 /*
  * this is the maximum number of virtual irqs we will use.
  */
@@ -25,19 +28,16 @@
 /* Interrupt numbers are virtual in case they are sparsely
  * distributed by the hardware.
  */
-#define NR_HW_IRQS		8192
-extern unsigned short real_irq_to_virt_map[NR_HW_IRQS];
-extern unsigned short virt_irq_to_real_map[NR_IRQS];
+extern unsigned int virt_irq_to_real_map[NR_IRQS];
+
 /* Create a mapping for a real_irq if it doesn't already exist.
  * Return the virtual irq as a convenience.
  */
-unsigned long virt_irq_create_mapping(unsigned long real_irq);
+int virt_irq_create_mapping(unsigned int real_irq);
+void virt_irq_init(void);
 
-/* These funcs map irqs between real and virtual */
-static inline unsigned long real_irq_to_virt(unsigned long real_irq) {
-	return real_irq_to_virt_map[real_irq];
-}
-static inline unsigned long virt_irq_to_real(unsigned long virt_irq) {
+static inline unsigned int virt_irq_to_real(unsigned int virt_irq)
+{
 	return virt_irq_to_real_map[virt_irq];
 }
 
