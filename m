Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTASBlj>; Sat, 18 Jan 2003 20:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTASBlj>; Sat, 18 Jan 2003 20:41:39 -0500
Received: from holomorphy.com ([66.224.33.161]:10629 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265306AbTASBld>;
	Sat, 18 Jan 2003 20:41:33 -0500
Date: Sat, 18 Jan 2003 17:50:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, zwane@linuxpower.ca, zab@zabbo.net,
       manfred@colorfullife.com, macro@ds2.pg.gda.pl, Martin.Bligh@us.ibm.com,
       jamesclv@us.ibm.com
Cc: andrew.grover@intel.com
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030119015013.GB780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, zwane@linuxpower.ca, zab@zabbo.net,
	manfred@colorfullife.com, macro@ds2.pg.gda.pl,
	Martin.Bligh@us.ibm.com, jamesclv@us.ibm.com,
	andrew.grover@intel.com
References: <20030115105802.GQ940@holomorphy.com> <20030119014326.GB789@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119014326.GB789@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 02:58:02AM -0800, William Lee Irwin III wrote:
>> (1) I've got 320 IRQ sources. This panic()'s in setup_IO_APIC_irqs().

On Sat, Jan 18, 2003 at 05:43:26PM -0800, William Lee Irwin III wrote:
> Where do you go for IO-APIC issues? Well, my MP tables say (Zwane
> pointed out fsmp@FreeBSD.org's mptable code):

Okay, and here is my latest attempt to deal with the issue (which is
dirty as sin code-wise, but nm that... I'm trying to debug this).

This doesn't actually work, I end up deadlocking presumably because
everything's waiting for an interrupt that's been dropped at some point.


diff -urpN mm1-2.5.59/arch/i386/kernel/io_apic.c irq-2.5.59-1/arch/i386/kernel/io_apic.c
--- mm1-2.5.59/arch/i386/kernel/io_apic.c	2003-01-17 01:04:43.000000000 -0800
+++ irq-2.5.59-1/arch/i386/kernel/io_apic.c	2003-01-18 15:15:01.000000000 -0800
@@ -647,6 +647,7 @@ static int __init find_irq_entry(int api
 
 	for (i = 0; i < mp_irq_entries; i++)
 		if (mp_irqs[i].mpc_irqtype == type &&
+		    mp_bus_id_to_node[mp_irqs[i].mpc_srcbus] == apic/2 &&
 		    (mp_irqs[i].mpc_dstapic == mp_ioapics[apic].mpc_apicid ||
 		     mp_irqs[i].mpc_dstapic == MP_APIC_ALL) &&
 		    mp_irqs[i].mpc_dstirq == pin)
@@ -696,8 +697,9 @@ int IO_APIC_get_PCI_irq_vector(int bus, 
 		int lbus = mp_irqs[i].mpc_srcbus;
 
 		for (apic = 0; apic < nr_ioapics; apic++)
-			if (mp_ioapics[apic].mpc_apicid == mp_irqs[i].mpc_dstapic ||
-			    mp_irqs[i].mpc_dstapic == MP_APIC_ALL)
+			if ((mp_ioapics[apic].mpc_apicid == mp_irqs[i].mpc_dstapic ||
+			    mp_irqs[i].mpc_dstapic == MP_APIC_ALL) &&
+		    	    mp_bus_id_to_node[mp_irqs[i].mpc_srcbus] == apic/2)
 				break;
 
 		if ((mp_bus_id_to_type[lbus] == MP_BUS_PCI) &&
@@ -914,6 +916,12 @@ static int pin_2_irq(int idx, int apic, 
 	int irq, i;
 	int bus = mp_irqs[idx].mpc_srcbus;
 
+#ifdef CONFIG_X86_NUMAQ
+	if (mp_bus_id_to_node[bus] != apic/2)
+		printk(KERN_ERR "bus %d on node %d, apic %d on node %d\n",
+			bus, mp_bus_id_to_node[bus], apic, apic/2);
+#endif
+
 	/*
 	 * Debugging check, we are in big trouble if this message pops up!
 	 */
@@ -930,6 +938,10 @@ static int pin_2_irq(int idx, int apic, 
 			break;
 		}
 		case MP_BUS_PCI: /* PCI pin */
+#ifdef CONFIG_X86_NUMAQ
+		irq = apic_pin_to_irq[apic][pin];
+		break;
+#else
 		{
 			/*
 			 * PCI IRQs are mapped in order
@@ -940,6 +952,7 @@ static int pin_2_irq(int idx, int apic, 
 			irq += pin;
 			break;
 		}
+#endif
 		default:
 		{
 			printk(KERN_ERR "unknown bus type %d.\n",bus); 
@@ -984,6 +997,80 @@ static inline int IO_APIC_irq_trigger(in
 
 int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
 
+#ifdef CONFIG_X86_NUMAQ
+
+int vector_to_irq[MAX_NUMNODES][FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR + 1];
+int apic_pin_to_irq[MAX_IO_APICS][24];
+
+/*
+ * timer vectors must always go to 0
+ * vectors < FIRST_DEVICE_VECTOR are 1:1
+ * everything else goes through the table
+ */
+
+static void __init init_vector_to_irq(void)
+{
+	int n, v;
+	for (n = 0; n < MAX_NUMNODES; ++n) {
+		for (v = 1; v <= FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR; ++v)
+			vector_to_irq[n][v] = -1;
+		vector_to_irq[n][0] = 0;
+	}
+	for (n = 0; n < MAX_IO_APICS; ++n)
+		for (v = 0; v < 24; ++v)
+			apic_pin_to_irq[n][v] = -1;
+}
+
+int irq_of_vector(int vector)
+{
+	int irq;
+	if (vector < FIRST_DEVICE_VECTOR)
+		irq = vector;
+	else
+		irq = vector_to_irq[numa_node_id()][vector-FIRST_DEVICE_VECTOR];
+	return irq;
+}
+
+static void set_irq_of_vector(int apic, int vector, int irq)
+{
+	vector_to_irq[apic/2][vector-FIRST_DEVICE_VECTOR] = irq;
+}
+
+static void set_irq_of_pin(int apic, int pin, int irq)
+{
+	apic_pin_to_irq[apic][pin] = irq;
+}
+
+static int __init next_irq_vector(int vector)
+{
+	++vector;
+	if (vector >= FIRST_SYSTEM_VECTOR)
+		vector = FIRST_DEVICE_VECTOR + 1;
+	else if (vector == SYSCALL_VECTOR)
+		++vector;
+	return vector;
+}
+
+static int __init assign_irq_vector(int irq)
+{
+	static int current_vector = FIRST_DEVICE_VECTOR+1;
+	if (!irq)
+		return FIRST_DEVICE_VECTOR;
+	else if (!irq_vector[irq]) {
+		irq_vector[irq] = current_vector;
+		current_vector = next_irq_vector(current_vector);
+	}
+	return irq_vector[irq];
+}
+
+#else
+
+#define init_vector_to_irq()		do {} while (0)
+#define set_irq_of_vector(a,v,i)	do {} while (0)
+#define set_irq_of_pin(a,v,i)	do {} while (0)
+
+int irq_of_vector(int vector)	{ return vector; }
+
 static int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
@@ -1005,6 +1092,7 @@ next:
 	IO_APIC_VECTOR(irq) = current_vector;
 	return current_vector;
 }
+#endif
 
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
@@ -1017,6 +1105,8 @@ void __init setup_IO_APIC_irqs(void)
 
 	printk(KERN_DEBUG "init IO_APIC IRQs\n");
 
+	init_vector_to_irq();
+
 	for (apic = 0; apic < nr_ioapics; apic++) {
 	for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
 
@@ -1064,13 +1154,19 @@ void __init setup_IO_APIC_irqs(void)
 		if (IO_APIC_IRQ(irq)) {
 			vector = assign_irq_vector(irq);
 			entry.vector = vector;
+			set_irq_of_vector(apic, vector, irq);
+			set_irq_of_pin(apic, pin, irq);
 
 			if (IO_APIC_irq_trigger(irq))
 				irq_desc[irq].handler = &ioapic_level_irq_type;
 			else
 				irq_desc[irq].handler = &ioapic_edge_irq_type;
 
+#ifdef CONFIG_X86_NUMAQ
+			set_intr_gate(vector, interrupt[vector]);
+#else
 			set_intr_gate(vector, interrupt[irq]);
+#endif
 		
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
@@ -1457,6 +1553,7 @@ static void __init setup_ioapic_ids_from
 	 * Set the IOAPIC ID to the value stored in the MPC table.
 	 */
 	for (apic = 0; apic < nr_ioapics; apic++) {
+		unsigned long numaq_ioapic_id;
 
 		/* Read the register 0 value */
 		spin_lock_irqsave(&ioapic_lock, flags);
@@ -1465,6 +1562,7 @@ static void __init setup_ioapic_ids_from
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
+#ifndef CONFIG_X86_NUMAQ
 		if (mp_ioapics[apic].mpc_apicid >= APIC_BROADCAST_ID) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
@@ -1495,6 +1593,7 @@ static void __init setup_ioapic_ids_from
 			printk("Setting %d in the phys_id_present_map\n", mp_ioapics[apic].mpc_apicid);
 			phys_id_present_map |= 1 << mp_ioapics[apic].mpc_apicid;
 		}
+#endif /* CONFIG_X86_NUMAQ */
 
 
 		/*
@@ -1507,14 +1606,19 @@ static void __init setup_ioapic_ids_from
 					mp_irqs[i].mpc_dstapic
 						= mp_ioapics[apic].mpc_apicid;
 
+#ifdef CONFIG_X86_NUMAQ
+		numaq_ioapic_id = (mp_ioapics[apic].mpc_apicid & 1) ? 13 : 14;
+#else
+		numaq_ioapic_id = mp_ioapics[apic].mpc_apicid;
+#endif /* CONFIG_X86_NUMAQ */
+
 		/*
 		 * Read the right value from the MPC table and
 		 * write it into the ID register.
 	 	 */
-		printk(KERN_INFO "...changing IO-APIC physical APIC ID to %d ...",
-					mp_ioapics[apic].mpc_apicid);
+		printk(KERN_INFO "...changing IO-APIC physical APIC ID to %d ...", (int)numaq_ioapic_id);
 
-		reg_00.ID = mp_ioapics[apic].mpc_apicid;
+		reg_00.ID = numaq_ioapic_id;
 		spin_lock_irqsave(&ioapic_lock, flags);
 		io_apic_write(apic, 0, *(int *)&reg_00);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
@@ -1525,7 +1629,7 @@ static void __init setup_ioapic_ids_from
 		spin_lock_irqsave(&ioapic_lock, flags);
 		*(int *)&reg_00 = io_apic_read(apic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
-		if (reg_00.ID != mp_ioapics[apic].mpc_apicid)
+		if (reg_00.ID != numaq_ioapic_id)
 			panic("could not set ID!\n");
 		else
 			printk(" ok.\n");
@@ -1741,7 +1845,7 @@ static struct hw_interrupt_type ioapic_l
 	set_ioapic_affinity,
 };
 
-static inline void init_IO_APIC_traps(void)
+static void init_IO_APIC_traps(void)
 {
 	int irq;
 
@@ -1765,9 +1869,12 @@ static inline void init_IO_APIC_traps(vo
 			 */
 			if (irq < 16)
 				make_8259A_irq(irq);
-			else
+			else {
 				/* Strange. Oh, well.. */
 				irq_desc[irq].handler = &no_irq_type;
+				printk("init_IO_APIC_traps():"
+					"unhandled irq %d\n", irq);
+			}
 		}
 	}
 }
@@ -1915,7 +2022,11 @@ static inline void check_timer(void)
 	 */
 	disable_8259A_irq(0);
 	vector = assign_irq_vector(0);
+#ifdef CONFIG_X86_NUMAQ
+	set_intr_gate(vector, interrupt[vector]);
+#else
 	set_intr_gate(vector, interrupt[0]);
+#endif
 
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
diff -urpN mm1-2.5.59/arch/i386/kernel/irq.c irq-2.5.59-1/arch/i386/kernel/irq.c
--- mm1-2.5.59/arch/i386/kernel/irq.c	2003-01-17 01:04:43.000000000 -0800
+++ irq-2.5.59-1/arch/i386/kernel/irq.c	2003-01-18 11:11:40.000000000 -0800
@@ -69,6 +69,7 @@ irq_desc_t irq_desc[NR_IRQS] __cacheline
 	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
 
 static void register_irq_proc (unsigned int irq);
+int irq_of_vector(int);
 
 /*
  * Special irq handlers.
@@ -92,6 +93,7 @@ static void ack_none(unsigned int irq)
  */
 #if CONFIG_X86
 	printk("unexpected IRQ trap at vector %02x\n", irq);
+	dump_stack();
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * Currently unexpected vectors happen only on SMP and APIC.
@@ -323,12 +325,19 @@ asmlinkage unsigned int do_IRQ(struct pt
 	 * 0 return value means that this irq is already being
 	 * handled by some other CPU. (or is disabled)
 	 */
-	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
+	/* high bits used in ret_from_ code  */
+	int irq = irq_of_vector(regs.orig_eax & 0xff);
 	int cpu = smp_processor_id();
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
 
+	if (irq < 0) {
+		printk("bad vector %ld, irq %d\n", regs.orig_eax & 0xff, irq);
+		dump_stack();
+		return 1;
+	}
+
 	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
diff -urpN mm1-2.5.59/arch/i386/pci/numa.c irq-2.5.59-1/arch/i386/pci/numa.c
--- mm1-2.5.59/arch/i386/pci/numa.c	2003-01-16 18:21:44.000000000 -0800
+++ irq-2.5.59-1/arch/i386/pci/numa.c	2003-01-18 11:11:40.000000000 -0800
@@ -117,6 +117,14 @@ struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 };
 
+void pci_fixup_child(struct pci_bus *parent, struct pci_bus *child, unsigned int buses)
+{
+	int quad = BUS2QUAD(parent->number);
+	child->primary = QUADLOCAL2BUS(quad, buses & 0xFF);
+	child->secondary = QUADLOCAL2BUS(quad, (buses >> 8) & 0xFF);
+	child->subordinate = QUADLOCAL2BUS(quad, (buses >> 16) & 0xFF);
+}
+
 static int __init pci_numa_init(void)
 {
 	int quad;
@@ -127,7 +135,7 @@ static int __init pci_numa_init(void)
 		return 0;
 
 	pci_root_bus = pcibios_scan_root(0);
-	if (numnodes > 1) {
+	if (0 && numnodes > 1) {
 		for (quad = 1; quad < numnodes; ++quad) {
 			printk("Scanning PCI bus %d for quad %d\n", 
 				QUADLOCAL2BUS(quad,0), quad);
diff -urpN mm1-2.5.59/drivers/pci/probe.c irq-2.5.59-1/drivers/pci/probe.c
--- mm1-2.5.59/drivers/pci/probe.c	2003-01-16 18:22:24.000000000 -0800
+++ irq-2.5.59-1/drivers/pci/probe.c	2003-01-18 11:11:40.000000000 -0800
@@ -244,6 +244,17 @@ struct pci_bus * __devinit pci_add_new_b
 	return child;
 }
 
+#ifdef CONFIG_X86_NUMAQ
+void pci_fixup_child(struct pci_bus *, struct pci_bus *, int);
+#else
+void pci_fixup_child(struct pci_bus *parent, struct pci_bus *child, unsigned int buses)
+{
+	child->primary = buses & 0xFF;
+	child->secondary = (buses >> 8) & 0xFF;
+	child->subordinate = (buses >> 16) & 0xFF;
+}
+#endif
+
 /*
  * If it's a bridge, configure it and scan the bus behind it.
  * For CardBus bridges, we don't scan behind as the devices will
@@ -271,9 +282,7 @@ int __devinit pci_scan_bridge(struct pci
 		if (pass)
 			return max;
 		child = pci_add_new_bus(bus, dev, 0);
-		child->primary = buses & 0xFF;
-		child->secondary = (buses >> 8) & 0xFF;
-		child->subordinate = (buses >> 16) & 0xFF;
+		pci_fixup_child(bus, child, buses);
 		child->number = child->secondary;
 		cmax = pci_do_scan_bus(child);
 		if (cmax > max) max = cmax;
diff -urpN mm1-2.5.59/include/asm-i386/hardirq.h irq-2.5.59-1/include/asm-i386/hardirq.h
--- mm1-2.5.59/include/asm-i386/hardirq.h	2003-01-16 18:22:26.000000000 -0800
+++ irq-2.5.59-1/include/asm-i386/hardirq.h	2003-01-18 11:11:40.000000000 -0800
@@ -34,7 +34,11 @@ typedef struct {
 
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
+#ifdef CONFIG_X86_NUMAQ
+#define HARDIRQ_BITS	9
+#else
 #define HARDIRQ_BITS	8
+#endif
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
diff -urpN mm1-2.5.59/include/asm-i386/mach-numaq/irq_vectors.h irq-2.5.59-1/include/asm-i386/mach-numaq/irq_vectors.h
--- mm1-2.5.59/include/asm-i386/mach-numaq/irq_vectors.h	1969-12-31 16:00:00.000000000 -0800
+++ irq-2.5.59-1/include/asm-i386/mach-numaq/irq_vectors.h	2003-01-18 11:11:40.000000000 -0800
@@ -0,0 +1,81 @@
+/*
+ * This file should contain #defines for all of the interrupt vector
+ * numbers used by this architecture.
+ *
+ * In addition, there are some standard defines:
+ *
+ *	FIRST_EXTERNAL_VECTOR:
+ *		The first free place for external interrupts
+ *
+ *	SYSCALL_VECTOR:
+ *		The IRQ vector a syscall makes the user to kernel transition
+ *		under.
+ *
+ *	TIMER_IRQ:
+ *		The IRQ number the timer interrupt comes in at.
+ *
+ *	NR_IRQS:
+ *		The total number of interrupt vectors (including all the
+ *		architecture specific interrupts) needed.
+ *
+ */			
+#ifndef _ASM_IRQ_VECTORS_H
+#define _ASM_IRQ_VECTORS_H
+
+/*
+ * IDT vectors usable for external interrupt sources start
+ * at 0x20:
+ */
+#define FIRST_EXTERNAL_VECTOR	0x20
+
+#define SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x20-0x2f are used for ISA interrupts.
+ */
+
+/*
+ * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
+ *
+ *  some of the following vectors are 'rare', they are merged
+ *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
+ *  TLB, reschedule and local APIC vectors are performance-critical.
+ *
+ *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
+ */
+#define SPURIOUS_APIC_VECTOR	0xff
+#define ERROR_APIC_VECTOR	0xfe
+#define INVALIDATE_TLB_VECTOR	0xfd
+#define RESCHEDULE_VECTOR	0xfc
+#define CALL_FUNCTION_VECTOR	0xfb
+
+#define THERMAL_APIC_VECTOR	0xf0
+/*
+ * Local APIC timer IRQ vector is on a different priority level,
+ * to work around the 'lost local interrupt if more than 2 IRQ
+ * sources per level' errata.
+ */
+#define LOCAL_TIMER_VECTOR	0xef
+
+/*
+ * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * we start at 0x31 to spread out vectors evenly between priority
+ * levels. (0x80 is the syscall vector)
+ */
+#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_SYSTEM_VECTOR	0xef
+
+#define TIMER_IRQ 0
+
+/*
+ * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * Right now the APIC is mostly only used for SMP.
+ * 256 vectors is an architectural limit. (we can have
+ * more than 256 devices theoretically, but they will
+ * have to use shared interrupts)
+ * Since vectors 0x00-0x1f are used/reserved for the CPU,
+ * the usable vector space is 0x20-0xff (224 vectors)
+ */
+#define NR_IRQS 512
+
+#endif /* _ASM_IRQ_VECTORS_H */
