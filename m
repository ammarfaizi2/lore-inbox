Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTE1WTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTE1WTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:19:11 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:17538
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261216AbTE1WTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:19:00 -0400
Date: Wed, 28 May 2003 18:22:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "" <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
In-Reply-To: <Pine.LNX.4.50.0305201447460.20429-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0305281650110.4964-100000@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com>
 <Pine.LNX.4.50.0305201447460.20429-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, Zwane Mwaikambo wrote:

> Thanks for seperating this, i'm giving it a go on 2.5.69-mm7 (requires 
> some work to fit in with the removal of __DO_ACTION), i've lost my SCSI 
> HBA but i should be able to fix it, i'll report back as soon as i get it 
> working.

Ok i had a look, here is a patch for 2.5.70 which runs on single 
processor with IOAPIC (i'll be trying it on an 8way later). However, some 
places can get confusing because the variable is called 'irq' but the 
function really wants a vector, for example do_IRQ now gets the vector 
pushed to it and the ack/end functions get called with a vector as a 
parameter. Perhaps these require some variable renaming, what do you think?

           CPU0       
  0:     407700    IO-APIC-edge  timer
  1:        491    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
 12:         57    IO-APIC-edge  i8042
 14:         10    IO-APIC-edge  ide0
145:       2482   IO-APIC-level  BusLogic BT-958
153:         96   IO-APIC-level  PCnet/PCI II 79C970A
161:          0   IO-APIC-level  uhci-hcd
NMI:          0 
LOC:     402984 
ERR:          0
MIS:          0

	Zwane

Index: linux-2.5.70-vector/arch/i386/Kconfig
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.5.70-vector/arch/i386/Kconfig	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-vector/arch/i386/Kconfig	28 May 2003 04:44:56 -0000
@@ -1058,6 +1058,17 @@ config PCI_DIRECT
  	depends on PCI && ((PCI_GODIRECT || PCI_GOANY) || X86_VISWS)
 	default y
 
+config PCI_USE_VECTOR
+	bool "PCI_USE_VECTOR"
+	default n
+	help
+	   This replaces the current existing IRQ-based index interrupt scheme
+	   with the vector-base index scheme. The advantages of vector base over	   IRQ base are listed below:
+	   1) Support MSI implementation.
+	   2) Support future IOxAPIC hotplug
+
+	   If you don't know what to do here, say N.
+
 source "drivers/pci/Kconfig"
 
 config ISA
Index: linux-2.5.70-vector/arch/i386/kernel/i8259.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i8259.c
--- linux-2.5.70-vector/arch/i386/kernel/i8259.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-vector/arch/i386/kernel/i8259.c	28 May 2003 04:44:56 -0000
@@ -427,7 +427,11 @@ void __init init_IRQ(void)
 	 * us. (some of these will be overridden and become
 	 * 'special' SMP interrupts)
 	 */
+#ifdef CONFIG_PCI_USE_VECTOR
+	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
+#else
 	for (i = 0; i < NR_IRQS; i++) {
+#endif
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (vector != SYSCALL_VECTOR) 
 			set_intr_gate(vector, interrupt[i]);
Index: linux-2.5.70-vector/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.5.70-vector/arch/i386/kernel/io_apic.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-vector/arch/i386/kernel/io_apic.c	28 May 2003 21:36:28 -0000
@@ -75,6 +75,20 @@ static struct irq_pin_list {
 	int apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
+#ifdef CONFIG_PCI_USE_VECTOR
+int vector_irq[NR_IRQS] = { [0 ... NR_IRQS -1] = -1};
+ 
+static int platform_irq(int irq) 	
+{ 	
+	if (platform_legacy_irq(irq))
+		return irq;
+	else
+		return vector_irq[irq];
+}
+#else
+#define platform_irq(irq)	(irq)
+#endif 
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -105,7 +119,7 @@ static void __init replace_pin_at_irq(un
 				      int oldapic, int oldpin,
 				      int newapic, int newpin)
 {
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	while (1) {
 		if (entry->apic == oldapic && entry->pin == oldpin) {
@@ -122,7 +136,7 @@ static void __init replace_pin_at_irq(un
 static void __mask_IO_APIC_irq (unsigned int irq)
 {
 	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	for (;;) {
 		unsigned int reg;
@@ -142,7 +156,7 @@ static void __mask_IO_APIC_irq (unsigned
 static void __unmask_IO_APIC_irq (unsigned int irq)
 {
 	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	for (;;) {
 		unsigned int reg;
@@ -161,7 +175,7 @@ static void __unmask_IO_APIC_irq (unsign
 static void __mask_and_edge_IO_APIC_irq (unsigned int irq)
 {
 	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	for (;;) {
 		unsigned int reg;
@@ -181,7 +195,7 @@ static void __mask_and_edge_IO_APIC_irq 
 static void __unmask_and_level_IO_APIC_irq (unsigned int irq)
 {
 	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
+	struct irq_pin_list *entry = irq_2_pin + platform_irq(irq);
 
 	for (;;) {
 		unsigned int reg;
@@ -1121,8 +1135,10 @@ int irq_vector[NR_IRQS] = { FIRST_DEVICE
 static int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	if (IO_APIC_VECTOR(irq) > 0)
-		return IO_APIC_VECTOR(irq);
+	int vector;
+
+	if ((vector = IO_APIC_VECTOR(irq)) > 0)
+		return vector;
 next:
 	current_vector += 8;
 	if (current_vector == SYSCALL_VECTOR)
@@ -1133,7 +1149,11 @@ next:
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
+#ifdef CONFIG_PCI_USE_VECTOR
+	vector_irq[current_vector] = irq;
+#endif
 	IO_APIC_VECTOR(irq) = current_vector;
+
 	return current_vector;
 }
 
@@ -1140,6 +1160,35 @@ next:
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
+#define IOAPIC_AUTO	-1
+#define IOAPIC_EDGE	0
+#define IOAPIC_LEVEL	1
+
+static inline void ioapic_register_intr(int irq, int vector, unsigned long trigger)
+{
+#ifdef CONFIG_PCI_USE_VECTOR
+			if (!platform_legacy_irq(irq)) {
+				if ((trigger == IOAPIC_AUTO && 
+				     IO_APIC_irq_trigger(irq)) ||
+				    trigger == IOAPIC_LEVEL)
+					irq_desc[vector].handler = &ioapic_level_irq_type;
+				else
+					irq_desc[vector].handler = &ioapic_edge_irq_type;
+				set_intr_gate(vector, interrupt[vector]);
+
+			} else 
+#endif
+			{
+				if ((trigger == IOAPIC_AUTO && 
+				     IO_APIC_irq_trigger(irq)) ||
+				    trigger == IOAPIC_LEVEL)
+					irq_desc[irq].handler = &ioapic_level_irq_type;
+				else
+					irq_desc[irq].handler = &ioapic_edge_irq_type;
+				set_intr_gate(vector, interrupt[irq]);
+			}
+}
+
 void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
@@ -1195,13 +1244,7 @@ void __init setup_IO_APIC_irqs(void)
 		if (IO_APIC_IRQ(irq)) {
 			vector = assign_irq_vector(irq);
 			entry.vector = vector;
-
-			if (IO_APIC_irq_trigger(irq))
-				irq_desc[irq].handler = &ioapic_level_irq_type;
-			else
-				irq_desc[irq].handler = &ioapic_edge_irq_type;
-
-			set_intr_gate(vector, interrupt[irq]);
+			ioapic_register_intr(irq, vector, IOAPIC_AUTO);
 		
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
@@ -1806,7 +1849,13 @@ static void end_level_ioapic_irq (unsign
  * operation to prevent an edge-triggered interrupt escaping meanwhile.
  * The idea is from Manfred Spraul.  --macro
  */
+#ifdef CONFIG_PCI_USE_VECTOR
+	if (!platform_legacy_irq(irq))		/* it's already the vector */
+		i = irq;
+	else
+#endif
 	i = IO_APIC_VECTOR(irq);
+
 	v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
 
 	ack_APIC_irq();
@@ -1890,7 +1939,15 @@ static inline void init_IO_APIC_traps(vo
 	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
 	 */
 	for (irq = 0; irq < NR_IRQS ; irq++) {
+#ifdef CONFIG_PCI_USE_VECTOR
+		int tmp;
+		tmp = platform_irq(irq);
+		if (tmp == -1)
+			continue;
+		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
+#else
 		if (IO_APIC_IRQ(irq) && !IO_APIC_VECTOR(irq)) {
+#endif
 			/*
 			 * Hmm.. We don't have an entry for this,
 			 * so default to an old-fashioned 8259
@@ -2321,9 +2378,7 @@ int io_apic_set_pci_routing (int ioapic,
 		"IRQ %d)\n", ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
 
-	irq_desc[irq].handler = &ioapic_level_irq_type;
-
-	set_intr_gate(entry.vector, interrupt[irq]);
+	ioapic_register_intr(irq, entry.vector, IOAPIC_LEVEL);
 
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
Index: linux-2.5.70-vector/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mpparse.c
--- linux-2.5.70-vector/arch/i386/kernel/mpparse.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-vector/arch/i386/kernel/mpparse.c	28 May 2003 04:44:56 -0000
@@ -1125,6 +1125,11 @@ void __init mp_parse_prt (void)
 		if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 			printk(KERN_DEBUG "Pin %d-%d already programmed\n",
 				mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
+#ifdef CONFIG_PCI_USE_VECTOR
+			if (!platform_legacy_irq(irq))
+				entry->irq = IO_APIC_VECTOR(irq);
+			else
+#endif
 			entry->irq = irq;
 			continue;
 		}
@@ -1132,6 +1137,11 @@ void __init mp_parse_prt (void)
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
 		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+#ifdef CONFIG_PCI_USE_VECTOR
+			if (!platform_legacy_irq(irq))
+				entry->irq = IO_APIC_VECTOR(irq);
+			else
+#endif
 			entry->irq = irq;
 
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
Index: linux-2.5.70-vector/arch/i386/pci/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/pci/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.5.70-vector/arch/i386/pci/irq.c	27 May 2003 02:20:20 -0000	1.1.1.1
+++ linux-2.5.70-vector/arch/i386/pci/irq.c	28 May 2003 04:44:56 -0000
@@ -742,6 +742,11 @@ static void __init pcibios_fixup_irqs(vo
 							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
 				}
 				if (irq >= 0) {
+#ifdef CONFIG_PCI_USE_VECTOR
+					if (!platform_legacy_irq(irq))
+						irq = IO_APIC_VECTOR(irq);
+#endif
+
 					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
 						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
 					dev->irq = irq;
Index: linux-2.5.70-vector/include/asm-i386/hw_irq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/hw_irq.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 hw_irq.h
--- linux-2.5.70-vector/include/asm-i386/hw_irq.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-vector/include/asm-i386/hw_irq.h	28 May 2003 04:44:56 -0000
@@ -40,6 +40,7 @@ extern asmlinkage void apic_timer_interr
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void thermal_interrupt(struct pt_regs);
+#define platform_legacy_irq(irq)	((irq) < 16)
 #endif
 
 extern void mask_irq(unsigned int irq);
Index: linux-2.5.70-vector/include/asm-i386/mach-default/irq_vectors.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/mach-default/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.5.70-vector/include/asm-i386/mach-default/irq_vectors.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-vector/include/asm-i386/mach-default/irq_vectors.h	28 May 2003 04:44:56 -0000
@@ -77,7 +77,12 @@
  * the usable vector space is 0x20-0xff (224 vectors)
  */
 #ifdef CONFIG_X86_IO_APIC
+#ifndef CONFIG_PCI_USE_VECTOR
 #define NR_IRQS 224
+#else
+#define NR_VECTORS 256
+#define NR_IRQS FIRST_SYSTEM_VECTOR
+#endif
 #else
 #define NR_IRQS 16
 #endif
-- 
function.linuxpower.ca
