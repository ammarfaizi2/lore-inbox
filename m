Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbTG1Pid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 11:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270201AbTG1Pid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 11:38:33 -0400
Received: from lidskialf.net ([62.3.233.115]:38874 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270200AbTG1PiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 11:38:12 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Alexander Rau <al.rau@gmx.de>
Subject: [PATCH] ACPI patch which fixes all my IRQ problems on nforce2 -- linux-2.6.0-test2-acpi-irqparams-final5.patch
Date: Mon, 28 Jul 2003 16:53:30 +0100
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>, torvalds@osdl.org
References: <200307272305.12412.adq_dvb@lidskialf.net> <3F25419B.2050607@gmx.de>
In-Reply-To: <3F25419B.2050607@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307281653.30701.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 16:30, Alexander Rau wrote:
> Andrew de Quincey wrote:
> > This is version final4 of the patch now. Improvement over version final3
> > is a fix to IRQ allocation.. previously all PCI IRQs were allocated to
> > IRQ11 on my Thinkpad.
> >
> > This _may_ break ACPI IRQ routing on the Toshiba 5005-S504  (I hope I
> > have managed to support it though). Can someone check please? Quote from
> > pci_link.c:
> >          * Note that we don't validate that the current IRQ (_CRS) exists
> >          * within the possible IRQs (_PRS): we blindly assume that
> > whatever * IRQ a boot-enabled Link device is set to is the correct one. *
> > (Required to support systems such as the Toshiba 5005-S504.)
>
> I tried to apply the patch to 2.6.0-test2 in hope that this resolves my
> oops during boottime on my thinkpad t40p.
>
> Unfortunatly the compilation of the kernel fails with:

Ah, hi, found the problem... you must be compiling with ACPI debug on. Thanks for pointing it out. New patch attached

---CUT HERE---
--- linux-2.6.0-test2.orig/arch/i386/kernel/io_apic.c	2003-07-27 18:00:21.000000000 +0100
+++ linux-2.6.0-test2/arch/i386/kernel/io_apic.c	2003-07-27 22:24:11.000000000 +0100
@@ -1559,6 +1559,142 @@
 	printk(KERN_DEBUG "... PIC ELCR: %04x\n", v);
 }
 
+int io_apic_irq_read_proc (char *page, char **start, off_t off,
+   			   int count, int *eof, void *data)
+{
+	int apic, i;
+	union IO_APIC_reg_00 reg_00;
+	union IO_APIC_reg_01 reg_01;
+	union IO_APIC_reg_02 reg_02;
+	union IO_APIC_reg_03 reg_03;
+	unsigned long flags;
+        char* start_page;     
+   
+        start_page = page;
+ 	page += sprintf(page, "number of MP IRQ sources: %d.\n", mp_irq_entries);
+	for (i = 0; i < nr_ioapics; i++)
+		page += sprintf(page, "number of IO-APIC #%d registers: %d.\n",
+		       mp_ioapics[i].mpc_apicid, nr_ioapic_registers[i]);
+
+	for (apic = 0; apic < nr_ioapics; apic++) {
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	reg_00.raw = io_apic_read(apic, 0);
+	reg_01.raw = io_apic_read(apic, 1);
+	if (reg_01.bits.version >= 0x10)
+		reg_02.raw = io_apic_read(apic, 2);
+	if (reg_01.bits.version >= 0x20)
+		reg_03.raw = io_apic_read(apic, 3);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+
+	page += sprintf(page, "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
+	page += sprintf(page, ".... register #00: %08X\n", reg_00.raw);
+	page += sprintf(page, ".......    : physical APIC id: %02X\n", reg_00.bits.ID);
+	page += sprintf(page, ".......    : Delivery Type: %X\n", reg_00.bits.delivery_type);
+	page += sprintf(page, ".......    : LTS          : %X\n", reg_00.bits.LTS);
+	if (reg_00.bits.ID >= APIC_BROADCAST_ID)
+		page += sprintf(page, "UNEXPECTED_IO_APIC\n");
+	if (reg_00.bits.__reserved_1 || reg_00.bits.__reserved_2)
+		page += sprintf(page, "UNEXPECTED_IO_APIC\n");	     
+
+	page += sprintf(page, ".... register #01: %08X\n", reg_01.raw);
+	page += sprintf(page, ".......     : max redirection entries: %04X\n", reg_01.bits.entries);
+	if (	(reg_01.bits.entries != 0x0f) && /* older (Neptune) boards */
+		(reg_01.bits.entries != 0x17) && /* typical ISA+PCI boards */
+		(reg_01.bits.entries != 0x1b) && /* Compaq Proliant boards */
+		(reg_01.bits.entries != 0x1f) && /* dual Xeon boards */
+		(reg_01.bits.entries != 0x22) && /* bigger Xeon boards */
+		(reg_01.bits.entries != 0x2E) &&
+		(reg_01.bits.entries != 0x3F)
+	)
+		page += sprintf(page, "UNEXPECTED_IO_APIC\n");	     
+
+	page += sprintf(page, ".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
+	page += sprintf(page, ".......     : IO APIC version: %04X\n", reg_01.bits.version);
+	if (	(reg_01.bits.version != 0x01) && /* 82489DX IO-APICs */
+		(reg_01.bits.version != 0x10) && /* oldest IO-APICs */
+		(reg_01.bits.version != 0x11) && /* Pentium/Pro IO-APICs */
+		(reg_01.bits.version != 0x13) && /* Xeon IO-APICs */
+		(reg_01.bits.version != 0x20)    /* Intel P64H (82806 AA) */
+	)
+		page += sprintf(page, "UNEXPECTED_IO_APIC\n");
+	if (reg_01.bits.__reserved_1 || reg_01.bits.__reserved_2)
+		page += sprintf(page, "UNEXPECTED_IO_APIC\n");
+
+	/*
+	 * Some Intel chipsets with IO APIC VERSION of 0x1? don't have reg_02,
+	 * but the value of reg_02 is read as the previous read register
+	 * value, so ignore it if reg_02 == reg_01.
+	 */
+	if (reg_01.bits.version >= 0x10 && reg_02.raw != reg_01.raw) {
+		page += sprintf(page, ".... register #02: %08X\n", reg_02.raw);
+		page += sprintf(page, ".......     : arbitration: %02X\n", reg_02.bits.arbitration);
+		if (reg_02.bits.__reserved_1 || reg_02.bits.__reserved_2)
+	     		page += sprintf(page, "UNEXPECTED_IO_APIC\n");
+	}
+
+	/*
+	 * Some Intel chipsets with IO APIC VERSION of 0x2? don't have reg_02
+	 * or reg_03, but the value of reg_0[23] is read as the previous read
+	 * register value, so ignore it if reg_03 == reg_0[12].
+	 */
+	if (reg_01.bits.version >= 0x20 && reg_03.raw != reg_02.raw &&
+	    reg_03.raw != reg_01.raw) {
+		page += sprintf(page, ".... register #03: %08X\n", reg_03.raw);
+		page += sprintf(page, ".......     : Boot DT    : %X\n", reg_03.bits.boot_DT);
+		if (reg_03.bits.__reserved_1)
+	     		page += sprintf(page, "UNEXPECTED_IO_APIC\n");
+	}
+
+	page += sprintf(page, ".... IRQ redirection table:\n");
+
+	page += sprintf(page, " NR Log Phy Mask Trig IRR Pol"
+			  " Stat Dest Deli Vect:   \n");
+
+	for (i = 0; i <= reg_01.bits.entries; i++) {
+		struct IO_APIC_route_entry entry;
+
+		spin_lock_irqsave(&ioapic_lock, flags);
+		*(((int *)&entry)+0) = io_apic_read(apic, 0x10+i*2);
+		*(((int *)&entry)+1) = io_apic_read(apic, 0x11+i*2);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
+
+		page += sprintf(page, " %02x %03X %02X  ",
+			i,
+			entry.dest.logical.logical_dest,
+			entry.dest.physical.physical_dest
+		);
+
+		page += sprintf(page, "%1d    %1d    %1d   %1d   %1d    %1d    %1d    %02X\n",
+			entry.mask,
+			entry.trigger,
+			entry.irr,
+			entry.polarity,
+			entry.delivery_status,
+			entry.dest_mode,
+			entry.delivery_mode,
+			entry.vector
+		);
+	}
+	}
+	page += sprintf(page, "IRQ to pin mappings:\n");
+	for (i = 0; i < NR_IRQS; i++) {
+		struct irq_pin_list *entry = irq_2_pin + i;
+		if (entry->pin < 0)
+			continue;
+		page += sprintf(page, "IRQ%d ", i);
+		for (;;) {
+			page += sprintf(page, "-> %d:0x%x", entry->apic, entry->pin);
+			if (!entry->next)
+				break;
+			entry = irq_2_pin + entry->next;
+		}
+		page += sprintf(page, "\n");
+	}
+
+	return page - start_page;
+}
+
 static void __init enable_IO_APIC(void)
 {
 	union IO_APIC_reg_01 reg_01;
@@ -2328,7 +2464,7 @@
 }
 
 
-int io_apic_set_pci_routing (int ioapic, int pin, int irq)
+int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -2350,19 +2486,23 @@
 	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.dest_mode = INT_DEST_MODE;
 	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
-	entry.mask = 1;					 /* Disabled (masked) */
-	entry.trigger = 1;				   /* Level sensitive */
-	entry.polarity = 1;					/* Low active */
+	entry.trigger = edge_level;
+	entry.polarity = active_high_low;
+	entry.mask  = 1;
 
 	add_pin_to_irq(irq, ioapic, pin);
 
 	entry.vector = assign_irq_vector(irq);
 
 	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
-		"IRQ %d)\n", ioapic, 
-		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
+		"IRQ %d Mode:%i Active:%i)\n", ioapic, 
+		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq, edge_level, active_high_low);
 
+	if (edge_level) {
 	irq_desc[irq].handler = &ioapic_level_irq_type;
+	} else {
+		irq_desc[irq].handler = &ioapic_edge_irq_type;
+	}
 
 	set_intr_gate(entry.vector, interrupt[irq]);
 
--- linux-2.6.0-test2.orig/arch/i386/kernel/mpparse.c	2003-07-27 17:59:51.000000000 +0100
+++ linux-2.6.0-test2/arch/i386/kernel/mpparse.c	2003-07-27 22:24:11.000000000 +0100
@@ -1065,7 +1065,7 @@
 
 	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
+	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 1, 1); // Active low, edge triggered
 }
 
 #endif /*CONFIG_ACPI_HT_ONLY*/
@@ -1080,6 +1080,8 @@
 	int			ioapic_pin = 0;
 	int			irq = 0;
 	int			idx, bit = 0;
+	int			edge_level = 0;
+	int			active_high_low = 0;
 
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
@@ -1090,12 +1092,16 @@
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
-			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
 			if (!irq)
 				continue;
 		}
-		else
+		else {
+			/* Hardwired IRQ. Assume PCI standard settings */
 			irq = entry->link.index;
+			edge_level = 1;
+			active_high_low = 1;
+		}
 
 		/* Don't set up the ACPI SCI because it's already set up */
 		if (acpi_fadt.sci_int == irq)
@@ -1130,7 +1136,7 @@
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low))
 			entry->irq = irq;
 
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
@@ -1140,6 +1146,9 @@
 			entry->irq);
 	}
 	
+
+        
+   
 	return;
 }
 
--- linux-2.6.0-test2.orig/arch/i386/kernel/irq.c	2003-07-27 17:57:11.000000000 +0100
+++ linux-2.6.0-test2/arch/i386/kernel/irq.c	2003-07-27 22:24:11.000000000 +0100
@@ -1028,6 +1028,13 @@
 
 unsigned long prof_cpu_mask = -1;
 
+#ifdef CONFIG_X86_IO_APIC
+static struct proc_dir_entry * io_apic_irq_entry;
+
+extern int io_apic_irq_read_proc (char *page, char **start, off_t off,
+   			          int count, int *eof, void *data);
+#endif  
+
 void init_irq_proc (void)
 {
 	struct proc_dir_entry *entry;
@@ -1052,5 +1059,24 @@
 	 */
 	for (i = 0; i < NR_IRQS; i++)
 		register_irq_proc(i);
+   
+#ifdef CONFIG_X86_IO_APIC
+        if (smp_found_config) {
+                if (!skip_ioapic_setup && nr_ioapics) {
+	                struct proc_dir_entry* entry;
+	   
+		        /* create /proc/irq/io_apic */
+		        entry = create_proc_entry("io_apic", 0400, root_irq_dir);
+
+		        if (entry) {
+			        entry->nlink = 1;
+			        entry->read_proc = io_apic_irq_read_proc;
+		        }
+
+		        io_apic_irq_entry = entry;
+		}
+   
+	}   
+#endif	
 }
 
--- linux-2.6.0-test2.orig/drivers/acpi/pci_irq.c	2003-07-27 18:01:22.000000000 +0100
+++ linux-2.6.0-test2/drivers/acpi/pci_irq.c	2003-07-27 22:24:11.000000000 +0100
@@ -249,7 +249,7 @@
 	}
 
 	if (!entry->irq && entry->link.handle) {
-		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, NULL, NULL);
 		if (!entry->irq) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
 			return_VALUE(0);
@@ -389,7 +389,9 @@
 	}
 
 	/* Make sure all link devices have a valid IRQ. */
-	acpi_pci_link_check();
+	if (acpi_pci_link_check()) {
+		return_VALUE(-ENODEV);
+	}
 
 #ifdef CONFIG_X86_IO_APIC
 	/* Program IOAPICs using data from PRT entries. */
--- linux-2.6.0-test2.orig/drivers/acpi/pci_link.c	2003-07-27 17:57:17.000000000 +0100
+++ linux-2.6.0-test2/drivers/acpi/pci_link.c	2003-07-28 17:42:07.000000000 +0100
@@ -69,6 +69,9 @@
 
 struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
+	u8			edge_level;		/* All IRQs */
+	u8			active_high_low;	/* All IRQs */
+	u8			setonboot;
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 };
@@ -118,6 +121,8 @@
 			link->irq.possible[i] = p->interrupts[i];
 			link->irq.possible_count++;
 		}
+		link->irq.edge_level = p->edge_level;
+		link->irq.active_high_low = p->active_high_low;
 		break;
 	}
 	case ACPI_RSTYPE_EXT_IRQ:
@@ -136,6 +141,8 @@
 			link->irq.possible[i] = p->interrupts[i];
 			link->irq.possible_count++;
 		}
+		link->irq.edge_level = p->edge_level;
+		link->irq.active_high_low = p->active_high_low;
 		break;
 	}
 	default:
@@ -264,7 +271,6 @@
 	 * IRQ a boot-enabled Link device is set to is the correct one.
 	 * (Required to support systems such as the Toshiba 5005-S504.)
 	 */
-
 	link->irq.active = irq;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
@@ -294,6 +300,8 @@
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
+	/* We don't check irqs the first time round */
+	if (link->irq.setonboot) {
 	/* See if we're already at the target IRQ. */
 	if (irq == link->irq.active)
 		return_VALUE(0);
@@ -307,16 +315,18 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Target IRQ %d invalid\n", irq));
 		return_VALUE(-EINVAL);
 	}
+	}
 
 	memset(&resource, 0, sizeof(resource));
 
-	/* NOTE: PCI interrupts are always level / active_low / shared. */
+	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
+	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
+	   parameters */
 	if (irq <= 15) {
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
-		resource.res.data.irq.edge_level = ACPI_LEVEL_SENSITIVE;
-		resource.res.data.irq.active_high_low = ACPI_ACTIVE_LOW;
-		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
+		resource.res.data.irq.edge_level = link->irq.edge_level;
+		resource.res.data.irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.irq.number_of_interrupts = 1;
 		resource.res.data.irq.interrupts[0] = irq;
 	}
@@ -324,15 +334,15 @@
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
-		resource.res.data.extended_irq.edge_level = ACPI_LEVEL_SENSITIVE;
-		resource.res.data.extended_irq.active_high_low = ACPI_ACTIVE_LOW;
-		resource.res.data.extended_irq.shared_exclusive = ACPI_SHARED;
+		resource.res.data.extended_irq.edge_level = link->irq.edge_level;
+		resource.res.data.extended_irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.extended_irq.number_of_interrupts = 1;
 		resource.res.data.extended_irq.interrupts[0] = irq;
 		/* ignore resource_source, it's optional */
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
+	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
@@ -355,11 +365,13 @@
 	if (result) {
 		return_VALUE(result);
 	}
+   
 	if (link->irq.active != irq) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
 			"Attempt to enable at IRQ %d resulted in IRQ %d\n", 
 			irq, link->irq.active));
 		link->irq.active = 0;
+		acpi_ut_evaluate_object (link->handle, "_DIS", 0, NULL);	   
 		return_VALUE(-ENODEV);
 	}
 
@@ -407,7 +419,7 @@
 	ACPI_FUNCTION_TRACE("acpi_pci_link_check");
 
 	/*
-	 * Pass #1: Update penalties to facilitate IRQ balancing.
+	 * Update penalties to facilitate IRQ balancing.
 	 */
 	list_for_each(node, &acpi_link.entries) {
 
@@ -428,23 +440,23 @@
 		}
 	}
 
-	/*
-	 * Pass #2: Enable boot-disabled Links at 'best' IRQ.
-	 */
-	list_for_each(node, &acpi_link.entries) {
-		int		irq = 0;
-		int		i = 0;
+	return_VALUE(0);
+}
 
-		link = list_entry(node, struct acpi_pci_link, node);
-		if (!link || !link->irq.possible_count) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
-			continue;
-		}
+static int acpi_pci_link_allocate(struct acpi_pci_link* link) {
+	int irq;
+	int i;
 
-		if (link->irq.active)
-			continue;
+	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
+	if (link->irq.setonboot)
+		return_VALUE(0);
+
+	if (link->irq.active) {
+		irq = link->irq.active;
+	} else {
 		irq = link->irq.possible[0];
+	}
 
 		/* 
 		 * Select the best IRQ.  This is done in reverse to promote 
@@ -455,16 +467,20 @@
 				irq = link->irq.possible[i];
 		}
 
-		/* Enable the link device at this IRQ. */
-		acpi_pci_link_set(link, irq);
-
+	/* Attempt to enable the link device at this IRQ. */
+	if (acpi_pci_link_set(link, irq)) {
+		printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off\n",
+			acpi_device_name(link->device),
+			acpi_device_bid(link->device));
+		return_VALUE(-ENODEV);
+	} else {
 		acpi_irq_penalty[link->irq.active] += 100;
-
 		printk(PREFIX "%s [%s] enabled at IRQ %d\n", 
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device), link->irq.active);
 	}
 
+	link->irq.setonboot = 1;
 	return_VALUE(0);
 }
 
@@ -472,7 +488,9 @@
 int
 acpi_pci_link_get_irq (
 	acpi_handle		handle,
-	int			index)
+	int			index,
+	int*			edge_level,
+	int*			active_high_low)
 {
 	int                     result = 0;
 	struct acpi_device	*device = NULL;
@@ -498,11 +516,17 @@
 		return_VALUE(0);
 	}
 
+	if (acpi_pci_link_allocate(link)) {
+		return -ENODEV;
+	}
+	   
 	if (!link->irq.active) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link disabled\n"));
 		return_VALUE(0);
 	}
 
+	if (edge_level) *edge_level = link->irq.edge_level;
+	if (active_high_low) *active_high_low = link->irq.active_high_low;
 	return_VALUE(link->irq.active);
 }
 
--- linux-2.6.0-test2.orig/include/acpi/acpi_drivers.h	2003-07-27 18:06:07.000000000 +0100
+++ linux-2.6.0-test2/include/acpi/acpi_drivers.h	2003-07-27 22:24:11.000000000 +0100
@@ -60,7 +60,7 @@
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_pci_link_check (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index);
+int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 
--- linux-2.6.0-test2.orig/include/asm-i386/io_apic.h	2003-07-27 18:04:51.000000000 +0100
+++ linux-2.6.0-test2/include/asm-i386/io_apic.h	2003-07-27 22:24:11.000000000 +0100
@@ -170,7 +170,7 @@
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
-extern int io_apic_set_pci_routing (int ioapic, int pin, int irq);
+extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low);
 #endif /*CONFIG_ACPI_BOOT*/
 
 #else  /* !CONFIG_X86_IO_APIC */
---CUT HERE---


