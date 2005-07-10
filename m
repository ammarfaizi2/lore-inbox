Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVGJWjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVGJWjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVGJWjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 18:39:46 -0400
Received: from fsmlabs.com ([168.103.115.128]:62142 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262165AbVGJWhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 18:37:10 -0400
Date: Sun, 10 Jul 2005 16:41:29 -0600 (MDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: "Raj, Ashok" <ashok.raj@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>
Subject: [RFC][PATCH] i386: Per node IDT
Message-ID: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As most are aware there is a growing need for more devices on i386/x86_64 
based platforms and with that, support for interrupt servicing for all 
these devices. The proliferation of MSI based devices will also drive that 
requirement higher due to some devices requiring multiple vectors. Natalie 
and others have worked on ways of alleviating this recently, but i'd like 
to put the following forward as well, which should be able to work with 
other methodologies in place.

The general idea behind it is to setup an IDT per node to be shared 
between all processors on that node, with the definition of 'node' 
currently based on the NUMA topology. This could, of course, be changed in 
future to some form of interrupt handling domain/node for finer control 
over the number of participating cpus in a node. The following patch is a 
functioning proof of concept, tested on 32 processor, 8 node NUMA system 
with 320 irq lines and i believe Natalie tested it with 576 interrupts.

There is basic MSI support (it'll boot) although i haven't added node 
awareness to it yet. I'd like to collect opinions on general approach. The 
patch is currently i386 only, but adding x86_64 for example, should be 
easy.

Thanks

 arch/i386/kernel/cpu/common.c                      |   31 +++++
 arch/i386/kernel/entry.S                           |   19 ---
 arch/i386/kernel/head.S                            |   12 +-
 arch/i386/kernel/i8259.c                           |    2
 arch/i386/kernel/io_apic.c                         |  112 +++++++++++++--------
 arch/i386/kernel/irq.c                             |    3
 arch/i386/kernel/smpboot.c                         |    2
 arch/i386/kernel/traps.c                           |   41 +++++--
 arch/i386/mm/fault.c                               |    6 -
 drivers/pci/msi.c                                  |    6 -
 drivers/pci/msi.h                                  |    1
 include/asm-i386/cpu.h                             |    3
 include/asm-i386/desc.h                            |    5
 include/asm-i386/hw_irq.h                          |    2
 include/asm-i386/io_apic.h                         |    2
 include/asm-i386/mach-default/irq_vectors_limits.h |    8 +
 include/asm-i386/mach-visws/irq_vectors.h          |    3
 include/asm-i386/mach-voyager/irq_vectors.h        |    3
 include/asm-i386/segment.h                         |    2
 19 files changed, 176 insertions(+), 87 deletions(-)

Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 entry.S
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S	3 Jul 2005 13:20:43 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S	10 Jul 2005 22:33:37 -0000
@@ -407,27 +407,18 @@ syscall_badsys:
 	FIXUP_ESPFIX_STACK \
 28:	popl %eax;
 
-/*
- * Build the entry stubs and pointer table with
- * some assembler magic.
- */
-.data
-ENTRY(interrupt)
-.text
-
+/* Build the IRQ entry stubs */
 vector=0
-ENTRY(irq_entries_start)
+	.align IRQ_STUB_SIZE,0x90
+ENTRY(interrupt)
 .rept NR_IRQS
 	ALIGN
-1:	pushl $vector-256
+	pushl $vector
 	jmp common_interrupt
-.data
-	.long 1b
-.text
+	.align IRQ_STUB_SIZE,0x90
 vector=vector+1
 .endr
 
-	ALIGN
 common_interrupt:
 	SAVE_ALL
 	movl %esp,%eax
Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/head.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 head.S
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/head.S	3 Jul 2005 13:20:43 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/head.S	4 Jul 2005 21:39:56 -0000
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/linkage.h>
+#include <linux/numa.h>
 #include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -300,7 +301,7 @@ is386:	movl $2,%ecx		# set MP
 
 	call check_x87
 	lgdt cpu_gdt_descr
-	lidt idt_descr
+	lidt node_idt_descr		# we switch to per node IDTs later
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
 	movl %eax,%ss			# after changing gdt.
@@ -366,7 +367,7 @@ setup_idt:
 	movw %dx,%ax		/* selector = 0x0010 = cs */
 	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
 
-	lea idt_table,%edi
+	lea node_idt_table,%edi
 	mov $256,%ecx
 rp_sidt:
 	movl %eax,(%edi)
@@ -441,7 +442,7 @@ int_msg:
  */
 
 .globl boot_gdt_descr
-.globl idt_descr
+.globl node_idt_descr
 .globl cpu_gdt_descr
 
 	ALIGN
@@ -452,9 +453,10 @@ boot_gdt_descr:
 	.long boot_gdt_table - __PAGE_OFFSET
 
 	.word 0				# 32-bit align idt_desc.address
-idt_descr:
+node_idt_descr:
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
-	.long idt_table
+	.long node_idt_table
+	.fill MAX_NUMNODES-1,8,0
 
 # boot GDT descriptor (later on used by CPU#0):
 	.word 0				# 32 bit align gdt_desc.address
Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/i8259.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i8259.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/i8259.c	3 Jul 2005 13:20:44 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/i8259.c	10 Jul 2005 21:21:44 -0000
@@ -412,7 +412,7 @@ void __init init_IRQ(void)
 	 * us. (some of these will be overridden and become
 	 * 'special' SMP interrupts)
 	 */
-	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
+	for (i = 0; i < (NR_DEVICE_VECTORS); i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (i >= NR_IRQS)
 			break;
Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/io_apic.c	3 Jul 2005 13:20:43 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/io_apic.c	10 Jul 2005 21:20:50 -0000
@@ -78,12 +78,13 @@ static struct irq_pin_list {
 	int apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
-int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
+int vector_irq[MAX_NUMNODES][NR_VECTORS] =
+	{ [0 ... MAX_NUMNODES-1][0 ... NR_VECTORS - 1] = -1 };
 #ifdef CONFIG_PCI_MSI
-#define vector_to_irq(vector) 	\
-	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
+#define vector_to_irq(node, vector) 	\
+	(platform_legacy_irq(vector) ? vector : vector_irq[node][vector])
 #else
-#define vector_to_irq(vector)	(vector)
+#define vector_to_irq(node, vector)	(vector)
 #endif
 
 /*
@@ -1120,31 +1121,43 @@ static inline int IO_APIC_irq_trigger(in
 
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
+u8 vector_allocated[MAX_NUMNODES][FIRST_SYSTEM_VECTOR];
 
-int assign_irq_vector(int irq)
+int assign_irq_vector(int irq, int node)
 {
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	static u8 current_vector[MAX_NUMNODES] = {[0 ... MAX_NUMNODES-1] =
+		FIRST_DEVICE_VECTOR};
+	static int offset[MAX_NUMNODES];
+	int vector;
 
-	BUG_ON(irq >= NR_IRQ_VECTORS);
-	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
-		return IO_APIC_VECTOR(irq);
+	vector = IO_APIC_VECTOR(irq);
+	if ((vector > 0) && (irq != AUTO_ASSIGN)) {
+		vector_allocated[node][vector] = 1;
+		return vector;
+	}
 next:
-	current_vector += 8;
-	if (current_vector == SYSCALL_VECTOR)
+	current_vector[node] += 8;
+	if (current_vector[node] == SYSCALL_VECTOR)
 		goto next;
-
-	if (current_vector >= FIRST_SYSTEM_VECTOR) {
-		offset++;
-		if (!(offset%8))
-			return -ENOSPC;
-		current_vector = FIRST_DEVICE_VECTOR + offset;
+	
+	if (current_vector[node] >= FIRST_SYSTEM_VECTOR) {
+		offset[node] = (offset[node] + 1) & 7;
+		current_vector[node] = FIRST_DEVICE_VECTOR + offset[node];
 	}
 
-	vector_irq[current_vector] = irq;
+	if (current_vector[node] == FIRST_SYSTEM_VECTOR)
+		return -ENOSPC;
+
+	vector = current_vector[node];
+	vector_irq[node][vector] = irq;
+	if (vector_allocated[node][vector])
+		goto next;
+	
+	vector_allocated[node][vector] = 1;
 	if (irq != AUTO_ASSIGN)
-		IO_APIC_VECTOR(irq) = current_vector;
+		IO_APIC_VECTOR(irq) = vector;
 
-	return current_vector;
+	return vector;
 }
 
 static struct hw_interrupt_type ioapic_level_type;
@@ -1154,7 +1167,7 @@ static struct hw_interrupt_type ioapic_e
 #define IOAPIC_EDGE	0
 #define IOAPIC_LEVEL	1
 
-static inline void ioapic_register_intr(int irq, int vector, unsigned long trigger)
+static inline void ioapic_register_intr(int node, int irq, int vector, unsigned long trigger)
 {
 	if (use_pci_vector() && !platform_legacy_irq(irq)) {
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
@@ -1162,21 +1175,21 @@ static inline void ioapic_register_intr(
 			irq_desc[vector].handler = &ioapic_level_type;
 		else
 			irq_desc[vector].handler = &ioapic_edge_type;
-		set_intr_gate(vector, interrupt[vector]);
+		node_set_intr_gate(node, vector, interrupt[vector]);
 	} else	{
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger == IOAPIC_LEVEL)
 			irq_desc[irq].handler = &ioapic_level_type;
 		else
 			irq_desc[irq].handler = &ioapic_edge_type;
-		set_intr_gate(vector, interrupt[irq]);
+		node_set_intr_gate(node, vector, interrupt[irq]);
 	}
 }
 
 static void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
-	int apic, pin, idx, irq, first_notcon = 1, vector;
+	int apic, pin, idx, irq, first_notcon = 1, vector, bus, node;
 	unsigned long flags;
 
 	apic_printk(APIC_VERBOSE, KERN_DEBUG "init IO_APIC IRQs\n");
@@ -1192,8 +1205,6 @@ static void __init setup_IO_APIC_irqs(vo
 		entry.delivery_mode = INT_DELIVERY_MODE;
 		entry.dest_mode = INT_DEST_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = 
-					cpu_mask_to_apicid(TARGET_CPUS);
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -1212,12 +1223,22 @@ static void __init setup_IO_APIC_irqs(vo
 		entry.trigger = irq_trigger(idx);
 		entry.polarity = irq_polarity(idx);
 
+		bus = mp_irqs[idx].mpc_srcbus;
+		node = mp_bus_id_to_node[bus];
+		entry.dest.logical.logical_dest = cpu_mask_to_apicid(node_to_cpumask(node));
+
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
+		if (irq >= NR_IRQS) {
+			apic_printk(APIC_VERBOSE, KERN_DEBUG
+				"IO-APIC: out of IRQS node%d/bus%d/ioapic%d/irq%d\n",
+					node, bus, apic, irq);
+			continue;
+		}
 		/*
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
@@ -1231,9 +1252,12 @@ static void __init setup_IO_APIC_irqs(vo
 			continue;
 
 		if (IO_APIC_IRQ(irq)) {
-			vector = assign_irq_vector(irq);
+			vector = assign_irq_vector(irq, node);
+			if (vector < 0)
+				continue;
+
 			entry.vector = vector;
-			ioapic_register_intr(irq, vector, IOAPIC_AUTO);
+			ioapic_register_intr(node, irq, vector, IOAPIC_AUTO);
 		
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
@@ -1928,14 +1952,14 @@ static void end_level_ioapic_irq (unsign
 #ifdef CONFIG_PCI_MSI
 static unsigned int startup_edge_ioapic_vector(unsigned int vector)
 {
-	int irq = vector_to_irq(vector);
+	int irq = vector_to_irq(cpu_to_node(smp_processor_id()), vector);
 
 	return startup_edge_ioapic_irq(irq);
 }
 
 static void ack_edge_ioapic_vector(unsigned int vector)
 {
-	int irq = vector_to_irq(vector);
+	int irq = vector_to_irq(cpu_to_node(smp_processor_id()), vector);
 
 	move_irq(vector);
 	ack_edge_ioapic_irq(irq);
@@ -1943,14 +1967,14 @@ static void ack_edge_ioapic_vector(unsig
 
 static unsigned int startup_level_ioapic_vector (unsigned int vector)
 {
-	int irq = vector_to_irq(vector);
+	int irq = vector_to_irq(cpu_to_node(smp_processor_id()), vector);
 
 	return startup_level_ioapic_irq (irq);
 }
 
 static void end_level_ioapic_vector (unsigned int vector)
 {
-	int irq = vector_to_irq(vector);
+	int irq = vector_to_irq(cpu_to_node(smp_processor_id()), vector);
 
 	move_irq(vector);
 	end_level_ioapic_irq(irq);
@@ -1958,14 +1982,14 @@ static void end_level_ioapic_vector (uns
 
 static void mask_IO_APIC_vector (unsigned int vector)
 {
-	int irq = vector_to_irq(vector);
+	int irq = vector_to_irq(cpu_to_node(smp_processor_id()), vector);
 
 	mask_IO_APIC_irq(irq);
 }
 
 static void unmask_IO_APIC_vector (unsigned int vector)
 {
-	int irq = vector_to_irq(vector);
+	int irq = vector_to_irq(cpu_to_node(smp_processor_id()), vector);
 
 	unmask_IO_APIC_irq(irq);
 }
@@ -1974,7 +1998,8 @@ static void unmask_IO_APIC_vector (unsig
 static void set_ioapic_affinity_vector (unsigned int vector,
 					cpumask_t cpu_mask)
 {
-	int irq = vector_to_irq(vector);
+	int node = cpu_to_node(first_cpu(cpu_mask));
+	int irq = vector_to_irq(node, vector);
 
 	set_native_irq_info(vector, cpu_mask);
 	set_ioapic_affinity_irq(irq, cpu_mask);
@@ -2035,7 +2060,7 @@ static inline void init_IO_APIC_traps(vo
 		int tmp = irq;
 		if (use_pci_vector()) {
 			if (!platform_legacy_irq(tmp))
-				if ((tmp = vector_to_irq(tmp)) == -1)
+				if ((tmp = vector_to_irq(0, tmp)) == -1) /* FIXME - zwane */
 					continue;
 		}
 		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
@@ -2181,7 +2206,8 @@ static inline void check_timer(void)
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
-	vector = assign_irq_vector(0);
+	vector = assign_irq_vector(0, cpu_to_node(smp_processor_id()));
+	/* This gets reserved on all nodes as FIRST_DEVICE_VECTOR */
 	set_intr_gate(vector, interrupt[0]);
 
 	/*
@@ -2528,6 +2554,7 @@ int io_apic_set_pci_routing (int ioapic,
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	int node, bus;
 
 	if (!IO_APIC_IRQ(irq)) {
 		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0\n",
@@ -2545,7 +2572,6 @@ int io_apic_set_pci_routing (int ioapic,
 
 	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.dest_mode = INT_DEST_MODE;
-	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.trigger = edge_level;
 	entry.polarity = active_high_low;
 	entry.mask  = 1;
@@ -2555,15 +2581,19 @@ int io_apic_set_pci_routing (int ioapic,
 	 */
 	if (irq >= 16)
 		add_pin_to_irq(irq, ioapic, pin);
-
-	entry.vector = assign_irq_vector(irq);
+	bus = mp_irqs[pin].mpc_srcbus;
+	node = mp_bus_id_to_node[bus];
+	entry.dest.logical.logical_dest = cpu_mask_to_apicid(node_to_cpumask(node));
+	entry.vector = assign_irq_vector(irq, node);
+	if (entry.vector < 0)
+		return -ENOSPC;
 
 	apic_printk(APIC_DEBUG, KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry "
 		"(%d-%d -> 0x%x -> IRQ %d Mode:%i Active:%i)\n", ioapic,
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq,
 		edge_level, active_high_low);
 
-	ioapic_register_intr(irq, entry.vector, edge_level);
+	ioapic_register_intr(node, irq, entry.vector, edge_level);
 
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/irq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/irq.c	3 Jul 2005 13:20:43 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/irq.c	4 Jul 2005 21:39:56 -0000
@@ -53,8 +53,7 @@ static union irq_ctx *softirq_ctx[NR_CPU
  */
 fastcall unsigned int do_IRQ(struct pt_regs *regs)
 {	
-	/* high bits used in ret_from_ code */
-	int irq = regs->orig_eax & 0xff;
+	int irq = regs->orig_eax;
 #ifdef CONFIG_4KSTACKS
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/smpboot.c	3 Jul 2005 13:20:43 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/smpboot.c	10 Jul 2005 21:23:15 -0000
@@ -53,6 +53,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include <asm/cpu.h>
 
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
@@ -483,6 +484,7 @@ static void __devinit start_secondary(vo
 	 */
 	cpu_init();
 	smp_callin();
+	setup_cpu_idt();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
 		rep_nop();
 	setup_secondary_APIC_clock();
Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/traps.c	3 Jul 2005 13:20:43 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/traps.c	4 Jul 2005 21:39:56 -0000
@@ -51,6 +51,7 @@
 #include <asm/smp.h>
 #include <asm/arch_hooks.h>
 #include <asm/kdebug.h>
+#include <asm/cpu.h>
 
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -70,7 +71,8 @@ char ignore_fpu_irq = 0;
  * F0 0F bug workaround.. We have a special link segment
  * for this.
  */
-struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
+struct desc_struct node_idt_table[MAX_NUMNODES][IDT_ENTRIES]
+	__attribute__((__section__(".data.idt"))) = {[0 ... MAX_NUMNODES-1] = {{0, 0}, }};
 
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -1085,14 +1087,16 @@ asmlinkage void math_emulate(long arg)
 #ifdef CONFIG_X86_F00F_BUG
 void __init trap_init_f00f_bug(void)
 {
-	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
+	int node = cpu_to_node(smp_processor_id());
+
+	__set_fixmap(FIX_F00F_IDT, __pa(&node_idt_table[node]), PAGE_KERNEL_RO);
 
 	/*
 	 * Update the IDT descriptor and reload the IDT so that
 	 * it uses the read-only mapped virtual address.
 	 */
-	idt_descr.address = fix_to_virt(FIX_F00F_IDT);
-	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
+	node_idt_descr.address = fix_to_virt(FIX_F00F_IDT);
+	__asm__ __volatile__("lidt %0" : : "m" (node_idt_descr[node]));
 }
 #endif
 
@@ -1111,14 +1115,21 @@ do { \
 
 
 /*
- * This needs to use 'idt_table' rather than 'idt', and
+ * This needs to use 'node_idt_table' rather than 'idt', and
  * thus use the _nonmapped_ version of the IDT, as the
  * Pentium F0 0F bugfix can have resulted in the mapped
  * IDT being write-protected.
  */
+void node_set_intr_gate(unsigned int node, unsigned int n, void *addr)
+{
+	_set_gate(&node_idt_table[node][n],14,0,addr,__KERNEL_CS);
+}
+
 void set_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++)
+		node_set_intr_gate(node, n, addr);
 }
 
 /*
@@ -1126,22 +1137,30 @@ void set_intr_gate(unsigned int n, void 
  */
 static inline void set_system_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n, 14, 3, addr, __KERNEL_CS);
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++)
+		_set_gate(&node_idt_table[node][n], 14, 3, addr, __KERNEL_CS);
 }
 
 static void __init set_trap_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++)
+		_set_gate(&node_idt_table[node][n],15,0,addr,__KERNEL_CS);
 }
 
 static void __init set_system_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++)
+		_set_gate(&node_idt_table[node][n],15,3,addr,__KERNEL_CS);
 }
 
 static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
 {
-	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++)
+		_set_gate(&node_idt_table[node][n],5,0,0,(gdt_entry<<3));
 }
 #ifdef CONFIG_KGDB
 void set_intr_usr_gate(unsigned int n, void *addr)
@@ -1194,6 +1213,8 @@ void __init trap_init(void)
 
 	set_system_gate(SYSCALL_VECTOR,&system_call);
 
+	setup_node_idts();
+
 	/*
 	 * Should be a barrier for any external CPU state.
 	 */
Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 common.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/cpu/common.c	3 Jul 2005 13:20:44 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/cpu/common.c	4 Jul 2005 21:42:08 -0000
@@ -562,10 +562,38 @@ void __init early_cpu_init(void)
 	disable_pse = 1;
 #endif
 }
+
+/*
+ * copy over the boot node idt across all nodes, we currently only have
+ * non-unique idt entries for device io interrupts.
+ */
+void __devinit setup_node_idts(void)
+{
+	int node = MAX_NUMNODES;
+
+	/* we can skip setting up node0 since it's done in head.S */
+	while (--node) {
+		memcpy(node_idt_table[node], node_idt_table[0], IDT_SIZE);
+		node_idt_descr[node].size = IDT_SIZE - 1;
+		node_idt_descr[node].address = (unsigned long)node_idt_table[node];
+	}
+}
+
+void __devinit setup_cpu_idt(void)
+{
+	int cpu = smp_processor_id(), node =  cpu_to_node(cpu);
+
+	printk(KERN_DEBUG "CPU%d IDT at 0x%08lx\n", 
+		cpu, node_idt_descr[node].address);
+
+	/* reload the idt on all processors as they come up */
+	__asm__ __volatile__("lidt %0": "=m" (node_idt_descr[node]));
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
- * and IDT. We reload them nevertheless, this function acts as a
+ * We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
  */
 void __devinit cpu_init(void)
@@ -614,7 +642,6 @@ void __devinit cpu_init(void)
 		GDT_ENTRY_TLS_ENTRIES * 8);
 
 	__asm__ __volatile__("lgdt %0" : : "m" (cpu_gdt_descr[cpu]));
-	__asm__ __volatile__("lidt %0" : : "m" (idt_descr));
 
 	/*
 	 * Delete NT
Index: linux-2.6.13-rc1-mm1/arch/i386/mm/fault.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fault.c
--- linux-2.6.13-rc1-mm1/arch/i386/mm/fault.c	3 Jul 2005 13:20:44 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/mm/fault.c	4 Jul 2005 21:39:56 -0000
@@ -400,9 +400,9 @@ bad_area_nosemaphore:
 	 * Pentium F0 0F C7 C8 bug workaround.
 	 */
 	if (boot_cpu_data.f00f_bug) {
-		unsigned long nr;
-		
-		nr = (address - idt_descr.address) >> 3;
+		unsigned long nr, node;
+		node = cpu_to_node(smp_processor_id());
+		nr = (address - node_idt_descr[node].address) >> 3;
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
Index: linux-2.6.13-rc1-mm1/drivers/pci/msi.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/drivers/pci/msi.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 msi.c
--- linux-2.6.13-rc1-mm1/drivers/pci/msi.c	3 Jul 2005 13:20:28 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/drivers/pci/msi.c	10 Jul 2005 21:24:44 -0000
@@ -330,7 +330,7 @@ static int assign_msi_vector(void)
 
 		return free_vector;
 	}
-	vector = assign_irq_vector(AUTO_ASSIGN);
+	vector = assign_irq_vector(AUTO_ASSIGN, 0); /* FIXME - Zwane */
 	last_alloc_vector = vector;
 	if (vector  == LAST_DEVICE_VECTOR)
 		new_vector_avail = 0;
@@ -344,7 +344,7 @@ static int get_new_vector(void)
 	int vector;
 
 	if ((vector = assign_msi_vector()) > 0)
-		set_intr_gate(vector, interrupt[vector]);
+		set_intr_gate(vector, interrupt[vector]); /* FIXME - Zwane */
 
 	return vector;
 }
@@ -368,7 +368,7 @@ static int msi_init(void)
 		printk(KERN_WARNING "PCI: MSI cache init failed\n");
 		return status;
 	}
-	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN);
+	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN, 0); /* FIXME - Zwane */
 	if (last_alloc_vector < 0) {
 		pci_msi_enable = 0;
 		printk(KERN_WARNING "PCI: No interrupt vectors available for MSI\n");
Index: linux-2.6.13-rc1-mm1/drivers/pci/msi.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/drivers/pci/msi.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 msi.h
--- linux-2.6.13-rc1-mm1/drivers/pci/msi.h	3 Jul 2005 13:20:28 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/drivers/pci/msi.h	10 Jul 2005 21:20:18 -0000
@@ -19,7 +19,6 @@
 #define NR_HP_RESERVED_VECTORS 	20
 
 extern int vector_irq[NR_VECTORS];
-extern void (*interrupt[NR_IRQS])(void);
 extern int pci_vector_resources(int last, int nr_released);
 
 #ifdef CONFIG_SMP
Index: linux-2.6.13-rc1-mm1/include/asm-i386/cpu.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/include/asm-i386/cpu.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpu.h
--- linux-2.6.13-rc1-mm1/include/asm-i386/cpu.h	3 Jul 2005 13:21:15 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/include/asm-i386/cpu.h	4 Jul 2005 21:43:58 -0000
@@ -17,5 +17,8 @@ extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 #endif
 
+extern void __devinit setup_cpu_idt(void);
+extern void __devinit setup_node_idts(void);
+
 DECLARE_PER_CPU(int, cpu_state);
 #endif /* _ASM_I386_CPU_H_ */
Index: linux-2.6.13-rc1-mm1/include/asm-i386/desc.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/include/asm-i386/desc.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 desc.h
--- linux-2.6.13-rc1-mm1/include/asm-i386/desc.h	3 Jul 2005 13:21:15 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/include/asm-i386/desc.h	4 Jul 2005 21:39:57 -0000
@@ -2,6 +2,7 @@
 #define __ARCH_DESC_H
 
 #include <asm/ldt.h>
+#include <asm/numnodes.h>
 #include <asm/segment.h>
 
 #define CPU_16BIT_STACK_SIZE 1024
@@ -15,6 +16,7 @@
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
+extern struct desc_struct node_idt_table[MAX_NUMNODES][IDT_ENTRIES];
 DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
@@ -25,7 +27,7 @@ struct Xgt_desc_struct {
 	unsigned short pad;
 } __attribute__ ((packed));
 
-extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
+extern struct Xgt_desc_struct node_idt_descr[MAX_NUMNODES], cpu_gdt_descr[NR_CPUS];
 
 #define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (GDT_ENTRY_LDT*8))
@@ -36,6 +38,7 @@ extern struct Xgt_desc_struct idt_descr,
  */
 extern struct desc_struct default_ldt[];
 extern void set_intr_gate(unsigned int irq, void * addr);
+extern void node_set_intr_gate(unsigned int node, unsigned int vector, void * addr);
 
 #define _set_tssldt_desc(n,addr,limit,type) \
 __asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
Index: linux-2.6.13-rc1-mm1/include/asm-i386/hw_irq.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/include/asm-i386/hw_irq.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 hw_irq.h
--- linux-2.6.13-rc1-mm1/include/asm-i386/hw_irq.h	3 Jul 2005 13:21:15 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/include/asm-i386/hw_irq.h	10 Jul 2005 21:16:51 -0000
@@ -29,7 +29,7 @@ extern u8 irq_vector[NR_IRQ_VECTORS];
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 #define AUTO_ASSIGN		-1
 
-extern void (*interrupt[NR_IRQS])(void);
+extern char interrupt[NR_IRQS][IRQ_STUB_SIZE];
 
 #ifdef CONFIG_SMP
 fastcall void reschedule_interrupt(void);
Index: linux-2.6.13-rc1-mm1/include/asm-i386/io_apic.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/include/asm-i386/io_apic.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.h
--- linux-2.6.13-rc1-mm1/include/asm-i386/io_apic.h	3 Jul 2005 13:21:15 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/include/asm-i386/io_apic.h	4 Jul 2005 21:39:57 -0000
@@ -208,6 +208,6 @@ extern int (*ioapic_renumber_irq)(int io
 #define io_apic_assign_pci_irqs 0
 #endif
 
-extern int assign_irq_vector(int irq);
+extern int assign_irq_vector(int irq, int node);
 
 #endif
Index: linux-2.6.13-rc1-mm1/include/asm-i386/segment.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/include/asm-i386/segment.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 segment.h
--- linux-2.6.13-rc1-mm1/include/asm-i386/segment.h	3 Jul 2005 13:21:15 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/include/asm-i386/segment.h	4 Jul 2005 21:39:57 -0000
@@ -97,5 +97,5 @@
  * of tasks we can have..
  */
 #define IDT_ENTRIES 256
-
+#define IDT_SIZE (IDT_ENTRIES * 8)
 #endif
Index: linux-2.6.13-rc1-mm1/include/asm-i386/mach-default/irq_vectors_limits.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/include/asm-i386/mach-default/irq_vectors_limits.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors_limits.h
--- linux-2.6.13-rc1-mm1/include/asm-i386/mach-default/irq_vectors_limits.h	3 Jul 2005 13:21:15 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/include/asm-i386/mach-default/irq_vectors_limits.h	10 Jul 2005 20:13:50 -0000
@@ -2,11 +2,13 @@
 #define _ASM_IRQ_VECTORS_LIMITS_H
 
 #ifdef CONFIG_PCI_MSI
-#define NR_IRQS FIRST_SYSTEM_VECTOR
+#define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #define NR_IRQ_VECTORS NR_IRQS
 #else
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 # if (224 >= 32 * NR_CPUS)
 # define NR_IRQ_VECTORS NR_IRQS
 # else
@@ -14,8 +16,12 @@
 # endif
 #else
 #define NR_IRQS 16
+#define IRQ_STUB_SIZE 8
 #define NR_IRQ_VECTORS NR_IRQS
 #endif
 #endif
 
+/* number of vectors available for external interrupts in Linux */
+#define NR_DEVICE_VECTORS	190
+
 #endif /* _ASM_IRQ_VECTORS_LIMITS_H */
Index: linux-2.6.13-rc1-mm1/include/asm-i386/mach-visws/irq_vectors.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/include/asm-i386/mach-visws/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.6.13-rc1-mm1/include/asm-i386/mach-visws/irq_vectors.h	3 Jul 2005 13:21:15 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/include/asm-i386/mach-visws/irq_vectors.h	4 Jul 2005 21:39:57 -0000
@@ -52,7 +52,10 @@
  */
 #define NR_VECTORS 256
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #define NR_IRQ_VECTORS NR_IRQS
+/* number of vectors available for external interrupts in Linux */
+#define NR_DEVICE_VECTORS	190
 
 #define FPU_IRQ			13
 
Index: linux-2.6.13-rc1-mm1/include/asm-i386/mach-voyager/irq_vectors.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/include/asm-i386/mach-voyager/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.6.13-rc1-mm1/include/asm-i386/mach-voyager/irq_vectors.h	3 Jul 2005 13:21:15 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/include/asm-i386/mach-voyager/irq_vectors.h	4 Jul 2005 21:39:57 -0000
@@ -57,7 +57,10 @@
 
 #define NR_VECTORS 256
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #define NR_IRQ_VECTORS NR_IRQS
+/* number of vectors available for external interrupts in Linux */
+#define NR_DEVICE_VECTORS	190
 
 #define FPU_IRQ				13
 
