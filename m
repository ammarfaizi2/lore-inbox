Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261716AbTCGTKF>; Fri, 7 Mar 2003 14:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbTCGTKF>; Fri, 7 Mar 2003 14:10:05 -0500
Received: from [195.208.223.239] ([195.208.223.239]:22400 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261716AbTCGTJx>; Fri, 7 Mar 2003 14:09:53 -0500
Date: Fri, 7 Mar 2003 22:19:16 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: raarts@office.netland.nl
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, david.knierim@tekelec.com,
       alexander@netintact.se, Donald Becker <becker@scyld.com>,
       Greg KH <greg@kroah.com>, jamal <hadi@cyberus.ca>,
       Jeff Garzik <jgarzik@pobox.com>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, Robert Olsson <Robert.Olsson@data.slu.se>
Subject: [fixed] Re: PCI init issues
Message-ID: <20030307221916.A3679@localhost.park.msu.ru>
References: <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com> <3E6601A3.2010201@netland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E6601A3.2010201@netland.nl>; from raarts@netland.nl on Wed, Mar 05, 2003 at 02:54:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the BIOS on those systems is unable to handle add-on
PCI bridges properly.

The idea is to search the mp tables for at least one valid irq
entry either for such bridge itself or for any of its children.
This entry tells us at least how this PCI slot is wired to IO APIC.
Assuming that 4 INT pins inside the slot are 1:1 mapped to APIC
pins, we can add missing irq entries for this bridge to the kernel
mp tables, reprogram the APIC accordingly and use these new
entries to find correct irqs for devices behind that bridge.

The patch is for 2.4 only. In 2.5 most interesting ioapic
functions are defined for ACPI only - someone else ought to
look into that.

It cannot handle more than one level of external bridges as yet
(i.e. things like expansion chassis). This can be easily fixed though.

Ron Arts tested this on SuperMicro P4DPR-6GM-Q Dual Xeon motherboard
with Adaptec Duralink 64 and ZNYX ZX346Q quad port cards, both worked
fine.
Ron says that ZNYX board didn't worked under XP, so apparently
rumors about XP goodness are exaggerated. ;-)

Ivan.

--- 2.4.21p5/include/asm-i386/mpspec.h	Thu Mar  6 16:36:54 2003
+++ linux/include/asm-i386/mpspec.h	Thu Mar  6 16:36:36 2003
@@ -218,6 +218,7 @@ extern int mp_current_pci_id;
 extern unsigned long mp_lapic_addr;
 extern int pic_mode;
 extern int using_apic_timer;
+extern int max_irq_sources;
 
 #endif
 
--- 2.4.21p5/include/asm-i386/io_apic.h	Fri Mar  7 13:58:20 2003
+++ linux/include/asm-i386/io_apic.h	Fri Mar  7 13:30:15 2003
@@ -132,6 +132,9 @@ static inline void io_apic_sync(unsigned
 	(void) *(IO_APIC_BASE(apic)+4);
 }
 
+/* Setup one irq redirection entry. */
+extern int setup_one_IO_APIC_irq(int apic, int pin);
+
 /* 1 if "noapic" boot option passed */
 extern int skip_ioapic_setup;
 
--- 2.4.21p5/arch/i386/kernel/pci-irq.c	Fri Nov 29 02:53:09 2002
+++ linux/arch/i386/kernel/pci-irq.c	Fri Mar  7 13:48:14 2003
@@ -701,6 +701,89 @@ void __init pcibios_irq_init(void)
 	}
 }
 
+#ifdef CONFIG_X86_IO_APIC
+static void __init
+bridge_fixup_irqs(struct pci_dev *dev)
+{
+	int apic, pin, i, slot;
+	struct pci_dev *parent;
+	struct mpc_config_intsrc m;
+
+	parent = dev->bus->self;
+
+	/* HACK. We need a generic way to detect the built-in bridges;
+	   the "bridge swizzle" rule cannot be applied for those.
+	   For now check for P64H/P64H2 bridges only. */
+	if (!parent || (parent->class >> 8) != PCI_CLASS_BRIDGE_PCI ||
+	    parent->vendor != PCI_VENDOR_ID_INTEL ||
+	    (parent->device & ~0x700) != 0x1060)
+		return;
+
+	slot = PCI_SLOT(dev->devfn) << 2;
+
+	/* Check that there are mp irq entries either for this bridge itself
+	   or for its children. */
+	for (i = 0; i < mp_irq_entries; i++) {
+		int srcbus = mp_irqs[i].mpc_srcbus;
+		int srcslot = mp_irqs[i].mpc_srcbusirq & ~3;
+
+		if (mp_irqs[i].mpc_irqtype != mp_INT)
+			continue;
+
+		if ((srcbus == dev->bus->number && srcslot == slot) ||
+		    (srcbus >= dev->subordinate->number &&
+		     srcbus <= dev->subordinate->subordinate))
+			break;
+	}
+	if (i >= mp_irq_entries) {
+		printk(KERN_WARNING "PCI: no IRQ routing found for bridge %s\n",
+		       dev->slot_name);
+		return;
+	}
+
+	/* Template for new entries. */
+	m = mp_irqs[i];
+	m.mpc_srcbus = dev->bus->number;
+	m.mpc_srcbusirq = slot;
+	m.mpc_dstirq &= ~3;	/* Assume 1:1 mapping. */
+
+	for (apic = 0; apic < nr_ioapics; apic++) {
+		if (mp_ioapics[apic].mpc_apicid == m.mpc_dstapic)
+			break;
+	}
+	if (apic >= nr_ioapics) {
+		printk(KERN_WARNING "PCI: no I/O APIC found for bridge %s\n",
+		       dev->slot_name);
+		return;
+	}
+
+	for (pin = 0; pin < 4; pin++) {
+		/* Check whether or not we have matching mp entry. */
+		for (i = 0; i < mp_irq_entries; i++)
+			if (mp_irqs[i].mpc_irqtype == mp_INT &&
+			    mp_irqs[i].mpc_dstapic == m.mpc_dstapic &&
+			    mp_irqs[i].mpc_srcbusirq == slot + pin &&
+			    mp_irqs[i].mpc_srcbus == dev->bus->number)
+				break;
+		if (i < mp_irq_entries)
+			continue;
+		if (mp_irq_entries + 1 == max_irq_sources)
+			return;	/* No room in mp irq table. */
+
+		/* Create a new mp irq entry. */
+		printk(KERN_INFO "PCI: external bridge %s, INT%c fixup\n",
+		       dev->slot_name, pin + 'A');
+		mp_irqs[mp_irq_entries] = m;
+		mp_irqs[mp_irq_entries].mpc_srcbusirq += pin;
+		mp_irqs[mp_irq_entries].mpc_dstirq += pin;
+		++mp_irq_entries;
+
+		/* Now update the irq redirection entry. */
+		setup_one_IO_APIC_irq(apic, m.mpc_dstirq + pin);
+	}
+}
+#endif
+
 void __init pcibios_fixup_irqs(void)
 {
 	struct pci_dev *dev;
@@ -730,9 +813,14 @@ void __init pcibios_fixup_irqs(void)
 		 */
 		if (io_apic_assign_pci_irqs)
 		{
-			int irq;
+			int irq, irq1 = -1;
+
+			if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI)
+				bridge_fixup_irqs(dev);
 
 			if (pin) {
+				struct pci_dev *bridge = dev->bus->self;
+
 				pin--;		/* interrupt pins are numbered starting from 1 */
 				irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
 	/*
@@ -741,15 +829,18 @@ void __init pcibios_fixup_irqs(void)
 	 * parent slot, and pin number. The SMP code detects such bridged
 	 * busses itself so we should get into this branch reliably.
 	 */
-				if (irq < 0 && dev->bus->parent) { /* go back to the bridge */
-					struct pci_dev * bridge = dev->bus->self;
+				if (dev->bus->parent) { /* go back to the bridge */
 
 					pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+					irq1 = IO_APIC_get_PCI_irq_vector(bridge->bus->number,
 							PCI_SLOT(bridge->devfn), pin);
-					if (irq >= 0)
-						printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
-							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+				}
+				if (irq1 >= 0 && irq1 != irq) {
+					/* IRQ for this device doesn't match one for parent slot.
+					   Use the latter. */
+					irq = irq1;
+					printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
+						bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
 				}
 				if (irq >= 0) {
 					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
--- 2.4.21p5/arch/i386/kernel/io_apic.c	Thu Mar  6 15:58:25 2003
+++ linux/arch/i386/kernel/io_apic.c	Thu Mar  6 16:00:23 2003
@@ -614,78 +614,88 @@ extern void (*interrupt[NR_IRQS])(void);
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
-void __init setup_IO_APIC_irqs(void)
+int __init setup_one_IO_APIC_irq(int apic, int pin)
 {
 	struct IO_APIC_route_entry entry;
-	int apic, pin, idx, irq, first_notcon = 1, vector;
+	int idx, irq, vector;
 	unsigned long flags;
 
+	idx = find_irq_entry(apic,pin,mp_INT);
+	if (idx < 0)
+		return idx;
+	/*
+	 * add it to the IO-APIC irq-routing table:
+	 */
+	memset(&entry,0,sizeof(entry));
+
+	entry.delivery_mode = INT_DELIVERY_MODE;
+	entry.dest_mode = (INT_DEST_ADDR_MODE != 0);
+	entry.mask = 0;				/* enable IRQ */
+	entry.dest.logical.logical_dest = target_cpus();
+
+	entry.trigger = irq_trigger(idx);
+	entry.polarity = irq_polarity(idx);
+
+	if (irq_trigger(idx)) {
+		entry.trigger = 1;
+		entry.mask = 1;
+	}
+
+	irq = pin_2_irq(idx, apic, pin);
+	/*
+	 * skip adding the timer int on secondary nodes, which causes
+	 * a small but painful rift in the time-space continuum
+	 */
+	if ((clustered_apic_mode == CLUSTERED_APIC_NUMAQ) 
+		&& (apic != 0) && (irq == 0))
+		return 0;
+	else
+		add_pin_to_irq(irq, apic, pin);
+
+	if (!apic && !IO_APIC_IRQ(irq))
+		return 0;
+
+	if (IO_APIC_IRQ(irq)) {
+		vector = assign_irq_vector(irq);
+		entry.vector = vector;
+
+		if (IO_APIC_irq_trigger(irq))
+			irq_desc[irq].handler = &ioapic_level_irq_type;
+		else
+			irq_desc[irq].handler = &ioapic_edge_irq_type;
+
+		set_intr_gate(vector, interrupt[irq]);
+	
+		if (!apic && (irq < 16))
+			disable_8259A_irq(irq);
+	}
+	spin_lock_irqsave(&ioapic_lock, flags);
+	io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
+	io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+
+	return 0;
+}
+
+void __init setup_IO_APIC_irqs(void)
+{
+	int apic, pin, first_notcon = 1;
+
 	printk(KERN_DEBUG "init IO_APIC IRQs\n");
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
-	for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
+		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
 
-		/*
-		 * add it to the IO-APIC irq-routing table:
-		 */
-		memset(&entry,0,sizeof(entry));
-
-		entry.delivery_mode = INT_DELIVERY_MODE;
-		entry.dest_mode = (INT_DEST_ADDR_MODE != 0);
-		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = target_cpus();
+			if (setup_one_IO_APIC_irq(apic, pin) >= 0)
+				continue;
 
-		idx = find_irq_entry(apic,pin,mp_INT);
-		if (idx == -1) {
 			if (first_notcon) {
-				printk(KERN_DEBUG " IO-APIC (apicid-pin) %d-%d", mp_ioapics[apic].mpc_apicid, pin);
+				printk(KERN_DEBUG " IO-APIC (apicid-pin) %d-%d",
+					mp_ioapics[apic].mpc_apicid, pin);
 				first_notcon = 0;
 			} else
 				printk(", %d-%d", mp_ioapics[apic].mpc_apicid, pin);
-			continue;
-		}
-
-		entry.trigger = irq_trigger(idx);
-		entry.polarity = irq_polarity(idx);
-
-		if (irq_trigger(idx)) {
-			entry.trigger = 1;
-			entry.mask = 1;
-		}
-
-		irq = pin_2_irq(idx, apic, pin);
-		/*
-		 * skip adding the timer int on secondary nodes, which causes
-		 * a small but painful rift in the time-space continuum
-		 */
-		if ((clustered_apic_mode == CLUSTERED_APIC_NUMAQ) 
-			&& (apic != 0) && (irq == 0))
-			continue;
-		else
-			add_pin_to_irq(irq, apic, pin);
-
-		if (!apic && !IO_APIC_IRQ(irq))
-			continue;
-
-		if (IO_APIC_IRQ(irq)) {
-			vector = assign_irq_vector(irq);
-			entry.vector = vector;
-
-			if (IO_APIC_irq_trigger(irq))
-				irq_desc[irq].handler = &ioapic_level_irq_type;
-			else
-				irq_desc[irq].handler = &ioapic_edge_irq_type;
-
-			set_intr_gate(vector, interrupt[irq]);
-		
-			if (!apic && (irq < 16))
-				disable_8259A_irq(irq);
 		}
-		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
-		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-	}
 	}
 
 	if (!first_notcon)
