Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbVIYRz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbVIYRz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 13:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbVIYRz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 13:55:27 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:17050 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1751545AbVIYRz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 13:55:26 -0400
Date: Sun, 25 Sep 2005 11:01:29 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Raj, Ashok" <ashok.raj@intel.com>, bjorn.helgaas@hp.com
Subject: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
Message-ID: <Pine.LNX.4.61.0509251101060.1684@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the long periods between updates, i've been doing some 
relocating.

Changes since last post:

* Current interrupt handling domain is still on a node basis, although i 
have moved over to dynamically allocated per cpu IDTs.

* MSI now allocates vectors per node too, i've introduced a policy 
whereupon the node its allocated on depends on where the code is running. 
I'd like to move towards a policy where we allocate the vector on the node 
the bus/device belongs to, objections? This code is totally untested as i 
don't have any MSI capable devices.

Thanks,
	Zwane

 arch/i386/kernel/apic.c                            |    8 -
 arch/i386/kernel/cpu/common.c                      |   36 ++++++
 arch/i386/kernel/entry.S                           |   19 ---
 arch/i386/kernel/head.S                            |   12 +-
 arch/i386/kernel/i8259.c                           |    4
 arch/i386/kernel/io_apic.c                         |  118 +++++++++++++--------
 arch/i386/kernel/irq.c                             |    3
 arch/i386/kernel/smpboot.c                         |   12 +-
 arch/i386/kernel/traps.c                           |   57 +++++++---
 arch/i386/mach-voyager/voyager_smp.c               |    4
 arch/i386/mm/fault.c                               |    6 -
 drivers/pci/msi.c                                  |  112 +++++++++++--------
 drivers/pci/msi.h                                  |    4
 include/asm-i386/cpu.h                             |    2
 include/asm-i386/desc.h                            |   10 +
 include/asm-i386/hw_irq.h                          |    2
 include/asm-i386/io_apic.h                         |    2
 include/asm-i386/mach-default/irq_vectors_limits.h |   11 +
 include/asm-i386/mach-visws/irq_vectors.h          |    3
 include/asm-i386/mach-voyager/irq_vectors.h        |    3
 include/asm-i386/segment.h                         |    2
 include/asm-i386/topology.h                        |    8 +
 include/asm-ia64/msi.h                             |    1
 include/asm-x86_64/msi.h                           |    2
 init/main.c                                        |    5
 25 files changed, 292 insertions(+), 154 deletions(-)

Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 apic.c
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/apic.c	24 Sep 2005 18:26:50 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/apic.c	25 Sep 2005 05:15:29 -0000
@@ -78,15 +78,15 @@ void __init apic_intr_init(void)
 	smp_intr_init();
 #endif
 	/* self generated IPI for local APIC timer */
-	set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
+	boot_set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
 
 	/* IPI vectors for APIC spurious and error interrupts */
-	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
-	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
+	boot_set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
+	boot_set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
 
 	/* thermal monitor LVT interrupt */
 #ifdef CONFIG_X86_MCE_P4THERMAL
-	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
+	boot_set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 #endif
 }
 
Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/entry.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/entry.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 entry.S
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/entry.S	24 Sep 2005 18:26:49 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/entry.S	25 Sep 2005 05:15:29 -0000
@@ -410,27 +410,18 @@ syscall_badsys:
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
+	pushl $vector-0x10000
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
Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/head.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 head.S
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/head.S	24 Sep 2005 18:26:49 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/head.S	25 Sep 2005 05:15:29 -0000
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/linkage.h>
+#include <linux/numa.h>
 #include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -304,7 +305,7 @@ is386:	movl $2,%ecx		# set MP
 
 	call check_x87
 	lgdt cpu_gdt_descr
-	lidt idt_descr
+	lidt cpu_idt_descr		# we switch to per cpu IDTs later
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
 	movl %eax,%ss			# after changing gdt.
@@ -370,7 +371,7 @@ setup_idt:
 	movw %dx,%ax		/* selector = 0x0010 = cs */
 	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
 
-	lea idt_table,%edi
+	lea boot_idt_table,%edi
 	mov $256,%ecx
 rp_sidt:
 	movl %eax,(%edi)
@@ -445,7 +446,7 @@ int_msg:
  */
 
 .globl boot_gdt_descr
-.globl idt_descr
+.globl cpu_idt_descr
 .globl cpu_gdt_descr
 
 	ALIGN
@@ -456,9 +457,10 @@ boot_gdt_descr:
 	.long boot_gdt_table - __PAGE_OFFSET
 
 	.word 0				# 32-bit align idt_desc.address
-idt_descr:
+cpu_idt_descr:
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
-	.long idt_table
+	.long boot_idt_table
+	.fill NR_CPUS-1,8,0
 
 # boot GDT descriptor (later on used by CPU#0):
 	.word 0				# 32 bit align gdt_desc.address
Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/i8259.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i8259.c
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/i8259.c	24 Sep 2005 18:26:50 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/i8259.c	25 Sep 2005 05:15:29 -0000
@@ -411,12 +411,12 @@ void __init init_IRQ(void)
 	 * us. (some of these will be overridden and become
 	 * 'special' SMP interrupts)
 	 */
-	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
+	for (i = 0; i < (NR_DEVICE_VECTORS); i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (i >= NR_IRQS)
 			break;
 		if (vector != SYSCALL_VECTOR) 
-			set_intr_gate(vector, interrupt[i]);
+			boot_set_intr_gate(vector, interrupt[i]);
 	}
 
 	/* setup after call gates are initialised (usually add in
Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/io_apic.c	24 Sep 2005 18:26:49 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/io_apic.c	25 Sep 2005 05:20:01 -0000
@@ -80,12 +80,13 @@ static struct irq_pin_list {
 	int apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
-int vector_irq[NR_VECTORS] __read_mostly = { [0 ... NR_VECTORS - 1] = -1};
+int vector_irq[NR_IRQ_NODES][NR_VECTORS] =
+	{ [0 ... NR_IRQ_NODES-1][0 ... NR_VECTORS - 1] = -1 };
 #ifdef CONFIG_PCI_MSI
-#define vector_to_irq(vector) 	\
-	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
+#define vector_to_irq(node, vector)    \
+	(platform_legacy_irq(vector) ? vector : vector_irq[node][vector])
 #else
-#define vector_to_irq(vector)	(vector)
+#define vector_to_irq(cpu, vector)	(vector)
 #endif
 
 /*
@@ -1121,31 +1122,43 @@ static inline int IO_APIC_irq_trigger(in
 
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0 };
+u8 vector_allocated[NR_IRQ_NODES][FIRST_SYSTEM_VECTOR] __read_mostly;
+  
+int assign_irq_vector(int irq, int node)
+{
+	static u8 current_vector[NR_IRQ_NODES] = {[0 ... NR_IRQ_NODES-1] =
+		FIRST_DEVICE_VECTOR};
+	static int offset[NR_IRQ_NODES];
+	int vector;
 
-int assign_irq_vector(int irq)
-{
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-
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
@@ -1155,7 +1168,7 @@ static struct hw_interrupt_type ioapic_e
 #define IOAPIC_EDGE	0
 #define IOAPIC_LEVEL	1
 
-static inline void ioapic_register_intr(int irq, int vector, unsigned long trigger)
+static inline void ioapic_register_intr(int node, int irq, int vector, unsigned long trigger)
 {
 	if (use_pci_vector() && !platform_legacy_irq(irq)) {
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
@@ -1163,25 +1176,25 @@ static inline void ioapic_register_intr(
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
-
+	
 	for (apic = 0; apic < nr_ioapics; apic++) {
 	for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
 
@@ -1193,8 +1206,6 @@ static void __init setup_IO_APIC_irqs(vo
 		entry.delivery_mode = INT_DELIVERY_MODE;
 		entry.dest_mode = INT_DEST_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = 
-					cpu_mask_to_apicid(TARGET_CPUS);
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -1213,12 +1224,22 @@ static void __init setup_IO_APIC_irqs(vo
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
@@ -1232,9 +1253,12 @@ static void __init setup_IO_APIC_irqs(vo
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
@@ -1929,14 +1953,14 @@ static void end_level_ioapic_irq (unsign
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
@@ -1944,14 +1968,14 @@ static void ack_edge_ioapic_vector(unsig
 
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
@@ -1959,14 +1983,14 @@ static void end_level_ioapic_vector (uns
 
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
@@ -1975,7 +1999,8 @@ static void unmask_IO_APIC_vector (unsig
 static void set_ioapic_affinity_vector (unsigned int vector,
 					cpumask_t cpu_mask)
 {
-	int irq = vector_to_irq(vector);
+	int node = cpu_to_node(first_cpu(cpu_mask));
+	int irq = vector_to_irq(node, vector);
 
 	set_native_irq_info(vector, cpu_mask);
 	set_ioapic_affinity_irq(irq, cpu_mask);
@@ -2036,7 +2061,7 @@ static inline void init_IO_APIC_traps(vo
 		int tmp = irq;
 		if (use_pci_vector()) {
 			if (!platform_legacy_irq(tmp))
-				if ((tmp = vector_to_irq(tmp)) == -1)
+				if ((tmp = vector_to_irq(0, tmp)) == -1) /* FIXME - zwane */
 					continue;
 		}
 		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
@@ -2182,7 +2207,8 @@ static inline void check_timer(void)
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
-	vector = assign_irq_vector(0);
+	vector = assign_irq_vector(0, cpu_to_node(smp_processor_id()));
+	/* This gets reserved on all nodes as FIRST_DEVICE_VECTOR */
 	set_intr_gate(vector, interrupt[0]);
 
 	/*
@@ -2531,6 +2557,7 @@ int io_apic_set_pci_routing (int ioapic,
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	int node, bus;
 
 	if (!IO_APIC_IRQ(irq)) {
 		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0\n",
@@ -2548,7 +2575,6 @@ int io_apic_set_pci_routing (int ioapic,
 
 	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.dest_mode = INT_DEST_MODE;
-	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.trigger = edge_level;
 	entry.polarity = active_high_low;
 	entry.mask  = 1;
@@ -2558,15 +2584,19 @@ int io_apic_set_pci_routing (int ioapic,
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
Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/irq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/irq.c	24 Sep 2005 18:26:49 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/irq.c	25 Sep 2005 05:15:29 -0000
@@ -53,8 +53,7 @@ static union irq_ctx *softirq_ctx[NR_CPU
  */
 fastcall unsigned int do_IRQ(struct pt_regs *regs)
 {	
-	/* high bits used in ret_from_ code */
-	int irq = regs->orig_eax & 0xff;
+	int irq = regs->orig_eax & 0xffff;
 #ifdef CONFIG_4KSTACKS
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/smpboot.c	24 Sep 2005 18:26:50 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/smpboot.c	25 Sep 2005 05:36:58 -0000
@@ -53,6 +53,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include <asm/cpu.h>
 
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
@@ -1084,6 +1085,9 @@ static void __init smp_boot_cpus(unsigne
 	int apicid, cpu, bit, kicked;
 	unsigned long bogosum = 0;
 
+	/* prepare per CPU IDTs */
+	setup_idts();
+
 	/*
 	 * Setup boot CPU information
 	 */
@@ -1389,17 +1393,17 @@ void __init smp_intr_init(void)
 	 * IRQ0 must be given a fixed assignment and initialized,
 	 * because it's used before the IO-APIC is set up.
 	 */
-	set_intr_gate(FIRST_DEVICE_VECTOR, interrupt[0]);
+	boot_set_intr_gate(FIRST_DEVICE_VECTOR, interrupt[0]);
 
 	/*
 	 * The reschedule interrupt is a CPU-to-CPU reschedule-helper
 	 * IPI, driven by wakeup.
 	 */
-	set_intr_gate(RESCHEDULE_VECTOR, reschedule_interrupt);
+	boot_set_intr_gate(RESCHEDULE_VECTOR, reschedule_interrupt);
 
 	/* IPI for invalidation */
-	set_intr_gate(INVALIDATE_TLB_VECTOR, invalidate_interrupt);
+	boot_set_intr_gate(INVALIDATE_TLB_VECTOR, invalidate_interrupt);
 
 	/* IPI for generic function call */
-	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
+	boot_set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
 }
Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/traps.c	24 Sep 2005 18:26:49 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/traps.c	25 Sep 2005 05:15:29 -0000
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
+struct desc_struct *cpu_idt_table;
+struct desc_struct __cpuinitdata boot_idt_table[IDT_ENTRIES];
 
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -1097,14 +1099,16 @@ asmlinkage void math_emulate(long arg)
 #ifdef CONFIG_X86_F00F_BUG
 void __init trap_init_f00f_bug(void)
 {
-	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
+	int cpu = smp_processor_id();
+
+	__set_fixmap(FIX_F00F_IDT, __pa(boot_idt_table), PAGE_KERNEL_RO);
 
 	/*
 	 * Update the IDT descriptor and reload the IDT so that
 	 * it uses the read-only mapped virtual address.
 	 */
-	idt_descr.address = fix_to_virt(FIX_F00F_IDT);
-	load_idt(&idt_descr);
+	cpu_idt_descr.address = fix_to_virt(FIX_F00F_IDT);
+	load_idt(&cpu_idt_descr[cpu]);
 }
 #endif
 
@@ -1123,14 +1127,38 @@ do { \
 
 
 /*
- * This needs to use 'idt_table' rather than 'idt', and
+ * This needs to use 'cpu_idt_table' rather than 'idt', and
  * thus use the _nonmapped_ version of the IDT, as the
  * Pentium F0 0F bugfix can have resulted in the mapped
  * IDT being write-protected.
  */
+void node_set_intr_gate(unsigned int node, unsigned int n, void *addr)
+{
+	cpumask_t mask;
+	int cpu;
+	struct desc_struct *idt_table;
+
+	mask = early_node_to_cpumask(node);
+	for_each_cpu_mask(cpu, mask) {
+		idt_table = per_cpu_ptr(cpu_idt_table, cpu);
+		_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+	}
+}
+
 void set_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+	int cpu;
+	struct desc_struct *idt_table;
+
+	for_each_cpu(cpu) {
+		idt_table = per_cpu_ptr(cpu_idt_table, cpu);
+		_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+	}
+}
+
+void __init boot_set_intr_gate(unsigned int n, void *addr)
+{
+	_set_gate(&boot_idt_table[n],14,0,addr,__KERNEL_CS);
 }
 
 /*
@@ -1136,25 +1164,27 @@ void set_intr_gate(unsigned int n, void 
 /*
  * This routine sets up an interrupt gate at directory privilege level 3.
  */
+
 static inline void set_system_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n, 14, 3, addr, __KERNEL_CS);
+	_set_gate(&boot_idt_table[n],14, 3, addr, __KERNEL_CS);
 }
 
 static void __init set_trap_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
+	_set_gate(&boot_idt_table[n],15,0,addr,__KERNEL_CS);
 }
 
 static void __init set_system_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
+	_set_gate(&boot_idt_table[n],15,3,addr,__KERNEL_CS);
 }
 
 static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
 {
-	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
+	_set_gate(&boot_idt_table[n],5,0,0,(gdt_entry<<3));
 }
+
 #ifdef CONFIG_KGDB
 void set_intr_usr_gate(unsigned int n, void *addr)
 {
@@ -1176,10 +1206,9 @@ void __init trap_init(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 	init_apic_mappings();
 #endif
-
 	set_trap_gate(0,&divide_error);
-	set_intr_gate(1,&debug);
-	set_intr_gate(2,&nmi);
+	boot_set_intr_gate(1,&debug);
+	boot_set_intr_gate(2,&nmi);
 #ifndef CONFIG_KGDB
 	set_system_intr_gate(3, &int3); /* int3-5 can be called from all */
 #else
@@ -1195,7 +1224,7 @@ void __init trap_init(void)
 	set_trap_gate(11,&segment_not_present);
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
-	set_intr_gate(14,&page_fault);
+	boot_set_intr_gate(14,&page_fault);
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
 	set_trap_gate(17,&alignment_check);
Index: linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 common.c
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/common.c	24 Sep 2005 18:26:50 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/common.c	25 Sep 2005 05:15:29 -0000
@@ -582,10 +582,32 @@ void __init early_cpu_init(void)
 	disable_pse = 1;
 #endif
 }
+
+/*
+ * allocate space for all the IDTs in the system and copy over
+ * the boot IDT table to the runtime one. Individual cpu IDTs
+ * will be done at cpu_init
+ */
+void __init setup_idts(void)
+{
+	int i, cpu = smp_processor_id();
+
+	cpu_idt_table = __alloc_percpu(IDT_SIZE, IDT_SIZE);
+
+	for_each_cpu(i)
+		memcpy(per_cpu_ptr(cpu_idt_table, i), boot_idt_table, IDT_SIZE);
+
+	cpu_idt_descr[cpu].size = IDT_SIZE - 1;
+	cpu_idt_descr[cpu].address = (unsigned long)per_cpu_ptr(cpu_idt_table, cpu);
+
+	/* switch cpu0's IDT */
+	load_idt(&cpu_idt_descr[cpu]);
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
@@ -627,6 +649,15 @@ void __devinit cpu_init(void)
 	cpu_gdt_descr[cpu].address =
 	    (unsigned long)&per_cpu(cpu_gdt_table, cpu);
 
+	/* Skip the BSP, it'll still use the boot IDT until runtime IDTs are
+	 * allocated later on.
+	 */
+	if (cpu) {
+		cpu_idt_descr[cpu].size = IDT_SIZE - 1;
+		cpu_idt_descr[cpu].address =
+			(unsigned long)per_cpu_ptr(cpu_idt_table, cpu);
+	}
+
 	/*
 	 * Set up the per-thread TLS descriptor cache:
 	 */
@@ -634,7 +665,8 @@ void __devinit cpu_init(void)
 		GDT_ENTRY_TLS_ENTRIES * 8);
 
 	load_gdt(&cpu_gdt_descr[cpu]);
-	load_idt(&idt_descr);
+	printk("CPU%d IDT at %lx\n", cpu, cpu_idt_descr[cpu].address);
+	load_idt(&cpu_idt_descr[cpu]);
 
 	/*
 	 * Delete NT
Index: linux-2.6.14-rc2-mm1/arch/i386/mach-voyager/voyager_smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/mach-voyager/voyager_smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 voyager_smp.c
--- linux-2.6.14-rc2-mm1/arch/i386/mach-voyager/voyager_smp.c	24 Sep 2005 18:26:50 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/mach-voyager/voyager_smp.c	25 Sep 2005 05:15:29 -0000
@@ -1389,9 +1389,9 @@ setup_profiling_timer(unsigned int multi
  *  boot sequence interferes with bug checking; enable them later
  *  on in smp_init */
 #define VIC_SET_GATE(cpi, vector) \
-	set_intr_gate((cpi) + VIC_DEFAULT_CPI_BASE, (vector))
+	boot_set_intr_gate((cpi) + VIC_DEFAULT_CPI_BASE, (vector))
 #define QIC_SET_GATE(cpi, vector) \
-	set_intr_gate((cpi) + QIC_DEFAULT_CPI_BASE, (vector))
+	boot_set_intr_gate((cpi) + QIC_DEFAULT_CPI_BASE, (vector))
 
 void __init
 smp_intr_init(void)
Index: linux-2.6.14-rc2-mm1/arch/i386/mm/fault.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fault.c
--- linux-2.6.14-rc2-mm1/arch/i386/mm/fault.c	24 Sep 2005 18:26:50 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/arch/i386/mm/fault.c	25 Sep 2005 05:15:29 -0000
@@ -409,9 +409,9 @@ bad_area_nosemaphore:
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
Index: linux-2.6.14-rc2-mm1/drivers/pci/msi.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/drivers/pci/msi.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 msi.c
--- linux-2.6.14-rc2-mm1/drivers/pci/msi.c	24 Sep 2005 18:26:35 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/drivers/pci/msi.c	25 Sep 2005 05:15:29 -0000
@@ -28,13 +28,13 @@ static struct msi_desc* msi_desc[NR_IRQS
 static kmem_cache_t* msi_cachep;
 
 static int pci_msi_enable = 1;
-static int last_alloc_vector;
-static int nr_released_vectors;
+static int last_alloc_vector[NR_IRQ_NODES];
+static int nr_released_vectors[NR_IRQ_NODES];
 static int nr_reserved_vectors = NR_HP_RESERVED_VECTORS;
 static int nr_msix_devices;
 
 #ifndef CONFIG_X86_IO_APIC
-int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
+int vector_irq[NR_IRQ_NODES][NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 #endif
 
@@ -270,9 +270,9 @@ static void msi_address_init(struct msg_
 }
 
 static int msi_free_vector(struct pci_dev* dev, int vector, int reassign);
-static int assign_msi_vector(void)
+static int assign_msi_vector(int node)
 {
-	static int new_vector_avail = 1;
+	static int new_vector_avail[NR_IRQ_NODES] = { [0 ... NR_IRQ_NODES-1] = 1};
 	int vector;
 	unsigned long flags;
 
@@ -282,7 +282,7 @@ static int assign_msi_vector(void)
 	 */
 	spin_lock_irqsave(&msi_lock, flags);
 
-	if (!new_vector_avail) {
+	if (!new_vector_avail[node]) {
 		int free_vector = 0;
 
 		/*
@@ -299,7 +299,7 @@ static int assign_msi_vector(void)
 		 * vector-to-IOxAPIC IRQ mapping.
 	 	 */
 		for (vector = FIRST_DEVICE_VECTOR; vector < NR_IRQS; vector++) {
-			if (vector_irq[vector] != 0)
+			if (vector_irq[node][vector] != 0)
 				continue;
 			free_vector = vector;
 			if (!msi_desc[vector])
@@ -311,8 +311,8 @@ static int assign_msi_vector(void)
 			spin_unlock_irqrestore(&msi_lock, flags);
 			return -EBUSY;
 		}
-		vector_irq[free_vector] = -1;
-		nr_released_vectors--;
+		vector_irq[node][free_vector] = -1;
+		nr_released_vectors[node]--;
 		spin_unlock_irqrestore(&msi_lock, flags);
 		if (msi_desc[free_vector] != NULL) {
 			struct pci_dev *dev;
@@ -330,21 +330,21 @@ static int assign_msi_vector(void)
 
 		return free_vector;
 	}
-	vector = assign_irq_vector(AUTO_ASSIGN);
-	last_alloc_vector = vector;
+	vector = assign_irq_vector(AUTO_ASSIGN, node);
+	last_alloc_vector[node] = vector;
 	if (vector  == LAST_DEVICE_VECTOR)
-		new_vector_avail = 0;
+		new_vector_avail[node] = 0;
 
 	spin_unlock_irqrestore(&msi_lock, flags);
 	return vector;
 }
 
-static int get_new_vector(void)
+static int get_new_vector(int node)
 {
 	int vector;
 
-	if ((vector = assign_msi_vector()) > 0)
-		set_intr_gate(vector, interrupt[vector]);
+	if ((vector = assign_msi_vector(node)) > 0)
+		node_set_intr_gate(node, vector, interrupt[vector]);
 
 	return vector;
 }
@@ -352,6 +352,7 @@ static int get_new_vector(void)
 static int msi_init(void)
 {
 	static int status = -ENOMEM;
+	int node = 0;	/* FIXME - Zwane */
 
 	if (!status)
 		return status;
@@ -368,22 +369,23 @@ static int msi_init(void)
 		printk(KERN_WARNING "PCI: MSI cache init failed\n");
 		return status;
 	}
-	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN);
-	if (last_alloc_vector < 0) {
+
+	last_alloc_vector[node] = assign_irq_vector(AUTO_ASSIGN, node);
+	if (last_alloc_vector[node] < 0) {
 		pci_msi_enable = 0;
 		printk(KERN_WARNING "PCI: No interrupt vectors available for MSI\n");
 		status = -EBUSY;
 		return status;
 	}
-	vector_irq[last_alloc_vector] = 0;
-	nr_released_vectors++;
+	vector_irq[node][last_alloc_vector[node]] = 0;
+	nr_released_vectors[node]++;
 
 	return status;
 }
 
-static int get_msi_vector(struct pci_dev *dev)
+static int get_msi_vector(struct pci_dev *dev, int cpu)
 {
-	return get_new_vector();
+	return get_new_vector(cpu_to_node(cpu));
 }
 
 static struct msi_desc* alloc_msi_entry(void)
@@ -504,7 +506,7 @@ void pci_scan_msi_device(struct pci_dev 
  * multiple messages. A return of zero indicates the successful setup
  * of an entry zero with the new MSI vector or non-zero for otherwise.
  **/
-static int msi_capability_init(struct pci_dev *dev)
+static int msi_capability_init(struct pci_dev *dev, int cpu)
 {
 	struct msi_desc *entry;
 	struct msg_address address;
@@ -518,7 +520,7 @@ static int msi_capability_init(struct pc
 	if (!(entry = alloc_msi_entry()))
 		return -ENOMEM;
 
-	if ((vector = get_msi_vector(dev)) < 0) {
+	if ((vector = get_msi_vector(dev, cpu)) < 0) {
 		kmem_cache_free(msi_cachep, entry);
 		return -EBUSY;
 	}
@@ -531,6 +533,7 @@ static int msi_capability_init(struct pc
 	entry->msi_attrib.default_vector = dev->irq;	/* Save IOAPIC IRQ */
 	dev->irq = vector;
 	entry->dev = dev;
+	entry->cpu = cpu;
 	if (is_mask_bit_support(control)) {
 		entry->mask_base = (void __iomem *)(long)msi_mask_bits_reg(pos,
 				is_64bit_address(control));
@@ -586,7 +589,7 @@ static int msix_capability_init(struct p
 	struct msi_desc *head = NULL, *tail = NULL, *entry = NULL;
 	struct msg_address address;
 	struct msg_data data;
-	int vector, pos, i, j, nr_entries, temp = 0;
+	int vector, pos, i, j, nr_entries, temp = 0, cpu;
 	u32 phys_addr, table_offset;
  	u16 control;
 	u8 bir;
@@ -605,12 +608,16 @@ static int msix_capability_init(struct p
 	if (base == NULL)
 		return -ENOMEM;
 
+	/* Don't migrate across cpus as we need to allocate vectors from
+	 * the same processor as this MSI target.
+	 */
+	cpu = get_cpu();
 	/* MSI-X Table Initialization */
 	for (i = 0; i < nvec; i++) {
 		entry = alloc_msi_entry();
 		if (!entry)
 			break;
-		if ((vector = get_msi_vector(dev)) < 0)
+		if ((vector = get_msi_vector(dev, cpu)) < 0)
 			break;
 
  		j = entries[i].entry;
@@ -622,6 +629,7 @@ static int msix_capability_init(struct p
 		entry->msi_attrib.default_vector = dev->irq;
 		entry->dev = dev;
 		entry->mask_base = base;
+		entry->cpu = cpu;
 		if (!head) {
 			entry->link.head = vector;
 			entry->link.tail = vector;
@@ -653,6 +661,8 @@ static int msix_capability_init(struct p
 			PCI_MSIX_ENTRY_DATA_OFFSET);
 		attach_msi_entry(entry, vector);
 	}
+	put_cpu();
+
 	if (i != nvec) {
 		i--;
 		for (; i >= 0; i--) {
@@ -680,7 +690,7 @@ static int msix_capability_init(struct p
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
-	int pos, temp, status = -EINVAL;
+	int pos, temp, cpu, node, status = -EINVAL;
 	u16 control;
 
 	if (!pci_msi_enable || !dev)
@@ -701,15 +711,17 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (control & PCI_MSI_FLAGS_ENABLE)
 		return 0;			/* Already in MSI mode */
 
+	cpu = msi_desc[temp]->cpu;
+	node = cpu_to_node(cpu);
 	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
 		/* Lookup Sucess */
 		unsigned long flags;
 
 		spin_lock_irqsave(&msi_lock, flags);
-		if (!vector_irq[dev->irq]) {
+		if (!vector_irq[node][dev->irq]) {
 			msi_desc[dev->irq]->msi_attrib.state = 0;
-			vector_irq[dev->irq] = -1;
-			nr_released_vectors--;
+			vector_irq[node][dev->irq] = -1;
+			nr_released_vectors[node]--;
 			spin_unlock_irqrestore(&msi_lock, flags);
 			enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 			return 0;
@@ -718,15 +730,15 @@ int pci_enable_msi(struct pci_dev* dev)
 		dev->irq = temp;
 	}
 	/* Check whether driver already requested for MSI-X vectors */
-   	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) > 0 &&
+	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) > 0 &&
 		!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
 			printk(KERN_INFO "PCI: %s: Can't enable MSI.  "
-			       "Device already has MSI-X vectors assigned\n",
-			       pci_name(dev));
+				"Device already has MSI-X vectors assigned\n",
+				pci_name(dev));
 			dev->irq = temp;
 			return -EINVAL;
 	}
-	status = msi_capability_init(dev);
+	status = msi_capability_init(dev, cpu);
 	if (!status) {
    		if (!pos)
 			nr_reserved_vectors--;	/* Only MSI capable */
@@ -741,7 +753,7 @@ int pci_enable_msi(struct pci_dev* dev)
 void pci_disable_msi(struct pci_dev* dev)
 {
 	struct msi_desc *entry;
-	int pos, default_vector;
+	int pos, default_vector, node;
 	u16 control;
 	unsigned long flags;
 
@@ -758,6 +770,7 @@ void pci_disable_msi(struct pci_dev* dev
 		spin_unlock_irqrestore(&msi_lock, flags);
 		return;
 	}
+	node = cpu_to_node(entry->cpu);
 	if (entry->msi_attrib.state) {
 		spin_unlock_irqrestore(&msi_lock, flags);
 		printk(KERN_WARNING "PCI: %s: pci_disable_msi() called without "
@@ -765,8 +778,8 @@ void pci_disable_msi(struct pci_dev* dev
 		       pci_name(dev), dev->irq);
 		BUG_ON(entry->msi_attrib.state > 0);
 	} else {
-		vector_irq[dev->irq] = 0; /* free it */
-		nr_released_vectors++;
+		vector_irq[node][dev->irq] = 0; /* free it */
+		nr_released_vectors[node]++;
 		default_vector = entry->msi_attrib.default_vector;
 		spin_unlock_irqrestore(&msi_lock, flags);
 		/* Restore dev->irq to its default pin-assertion vector */
@@ -779,7 +792,7 @@ void pci_disable_msi(struct pci_dev* dev
 static int msi_free_vector(struct pci_dev* dev, int vector, int reassign)
 {
 	struct msi_desc *entry;
-	int head, entry_nr, type;
+	int head, entry_nr, type, node;
 	void __iomem *base;
 	unsigned long flags;
 
@@ -789,6 +802,7 @@ static int msi_free_vector(struct pci_de
 		spin_unlock_irqrestore(&msi_lock, flags);
 		return -EINVAL;
 	}
+	node = pcibus_to_node(dev->bus->number);
 	type = entry->msi_attrib.type;
 	entry_nr = entry->msi_attrib.entry_nr;
 	head = entry->link.head;
@@ -797,8 +811,8 @@ static int msi_free_vector(struct pci_de
 	msi_desc[entry->link.tail]->link.head = entry->link.head;
 	entry->dev = NULL;
 	if (!reassign) {
-		vector_irq[vector] = 0;
-		nr_released_vectors++;
+		vector_irq[node][vector] = 0;
+		nr_released_vectors[node]++;
 	}
 	msi_desc[vector] = NULL;
 	spin_unlock_irqrestore(&msi_lock, flags);
@@ -841,7 +855,7 @@ static int msi_free_vector(struct pci_de
 static int reroute_msix_table(int head, struct msix_entry *entries, int *nvec)
 {
 	int vector = head, tail = 0;
-	int i, j = 0, nr_entries = 0;
+	int i, j = 0, nr_entries = 0, node = 0;
 	void __iomem *base;
 	unsigned long flags;
 
@@ -862,8 +876,8 @@ static int reroute_msix_table(int head, 
 	for (i = 0; i < *nvec; i++) {
 		j = msi_desc[vector]->msi_attrib.entry_nr;
 		msi_desc[vector]->msi_attrib.state = 0;	/* Mark it not active */
-		vector_irq[vector] = -1;		/* Mark it busy */
-		nr_released_vectors--;
+		vector_irq[node][vector] = -1;		/* Mark it busy */
+		nr_released_vectors[node]--;
 		entries[i].vector = vector;
 		if (j != (entries + i)->entry) {
 			base = msi_desc[vector]->mask_base;
@@ -907,7 +921,7 @@ static int reroute_msix_table(int head, 
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 {
 	int status, pos, nr_entries, free_vectors;
-	int i, j, temp;
+	int i, j, temp, node;
 	u16 control;
 	unsigned long flags;
 
@@ -961,13 +975,14 @@ int pci_enable_msix(struct pci_dev* dev,
 		return -EINVAL;
 	}
 
+	node = cpu_to_node(msi_desc[temp]->cpu);
 	spin_lock_irqsave(&msi_lock, flags);
 	/*
 	 * msi_lock is provided to ensure that enough vectors resources are
 	 * available before granting.
 	 */
-	free_vectors = pci_vector_resources(last_alloc_vector,
-				nr_released_vectors);
+	free_vectors = pci_vector_resources(last_alloc_vector[node],
+				nr_released_vectors[node]);
 	/* Ensure that each MSI/MSI-X device has one vector reserved by
 	   default to avoid any MSI-X driver to take all available
  	   resources */
@@ -993,7 +1008,7 @@ int pci_enable_msix(struct pci_dev* dev,
 
 void pci_disable_msix(struct pci_dev* dev)
 {
-	int pos, temp;
+	int pos, temp, node;
 	u16 control;
 
    	if (!dev || !(pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)))
@@ -1004,6 +1019,7 @@ void pci_disable_msix(struct pci_dev* de
 		return;
 
 	temp = dev->irq;
+	node = cpu_to_node(msi_desc[temp]->cpu);
 	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
 		int state, vector, head, tail = 0, warning = 0;
 		unsigned long flags;
@@ -1015,8 +1031,8 @@ void pci_disable_msix(struct pci_dev* de
 			if (state)
 				warning = 1;
 			else {
-				vector_irq[vector] = 0; /* free it */
-				nr_released_vectors++;
+				vector_irq[node][vector] = 0; /* free it */
+				nr_released_vectors[node]++;
 			}
 			tail = msi_desc[vector]->link.tail;
 			vector = tail;
Index: linux-2.6.14-rc2-mm1/drivers/pci/msi.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/drivers/pci/msi.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 msi.h
--- linux-2.6.14-rc2-mm1/drivers/pci/msi.h	24 Sep 2005 18:26:35 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/drivers/pci/msi.h	25 Sep 2005 05:15:29 -0000
@@ -18,8 +18,7 @@
  */
 #define NR_HP_RESERVED_VECTORS 	20
 
-extern int vector_irq[NR_VECTORS];
-extern void (*interrupt[NR_IRQS])(void);
+extern int vector_irq[NR_IRQ_NODES][NR_VECTORS];
 extern int pci_vector_resources(int last, int nr_released);
 
 #ifdef CONFIG_SMP
@@ -148,6 +147,7 @@ struct msi_desc {
 
 	void __iomem *mask_base;
 	struct pci_dev *dev;
+	int cpu;
 };
 
 #endif /* MSI_H */
Index: linux-2.6.14-rc2-mm1/include/asm-i386/cpu.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/cpu.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpu.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/cpu.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/cpu.h	25 Sep 2005 05:15:29 -0000
@@ -17,5 +17,7 @@ extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 #endif
 
+extern void __devinit setup_idts(void);
+
 DECLARE_PER_CPU(int, cpu_state);
 #endif /* _ASM_I386_CPU_H_ */
Index: linux-2.6.14-rc2-mm1/include/asm-i386/desc.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/desc.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 desc.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/desc.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/desc.h	25 Sep 2005 05:15:29 -0000
@@ -2,6 +2,7 @@
 #define __ARCH_DESC_H
 
 #include <asm/ldt.h>
+#include <asm/numnodes.h>
 #include <asm/segment.h>
 
 #define CPU_16BIT_STACK_SIZE 1024
@@ -15,6 +16,9 @@
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
+extern struct desc_struct *cpu_idt_table;
+extern struct desc_struct boot_idt_table[IDT_ENTRIES];
+
 DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
@@ -25,7 +29,7 @@ struct Xgt_desc_struct {
 	unsigned short pad;
 } __attribute__ ((packed));
 
-extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
+extern struct Xgt_desc_struct cpu_idt_descr[NR_CPUS], cpu_gdt_descr[NR_CPUS];
 
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
@@ -45,7 +49,9 @@ extern struct Xgt_desc_struct idt_descr,
  * something other than this.
  */
 extern struct desc_struct default_ldt[];
-extern void set_intr_gate(unsigned int irq, void * addr);
+extern void set_intr_gate(unsigned int vector, void * addr);
+extern void __init boot_set_intr_gate(unsigned int vector, void *addr);
+extern void node_set_intr_gate(unsigned int node, unsigned int vector, void * addr);
 
 #define _set_tssldt_desc(n,addr,limit,type) \
 __asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
Index: linux-2.6.14-rc2-mm1/include/asm-i386/hw_irq.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/hw_irq.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 hw_irq.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/hw_irq.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/hw_irq.h	25 Sep 2005 05:15:29 -0000
@@ -29,7 +29,7 @@ extern u8 irq_vector[NR_IRQ_VECTORS];
 #define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 #define AUTO_ASSIGN		-1
 
-extern void (*interrupt[NR_IRQS])(void);
+extern char interrupt[NR_IRQS][IRQ_STUB_SIZE];
 
 #ifdef CONFIG_SMP
 fastcall void reschedule_interrupt(void);
Index: linux-2.6.14-rc2-mm1/include/asm-i386/io_apic.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/io_apic.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/io_apic.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/io_apic.h	25 Sep 2005 05:15:29 -0000
@@ -208,6 +208,6 @@ extern int (*ioapic_renumber_irq)(int io
 #define io_apic_assign_pci_irqs 0
 #endif
 
-extern int assign_irq_vector(int irq);
+extern int assign_irq_vector(int irq, int node);
 
 #endif
Index: linux-2.6.14-rc2-mm1/include/asm-i386/segment.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/segment.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 segment.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/segment.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/segment.h	25 Sep 2005 05:15:29 -0000
@@ -97,5 +97,5 @@
  * of tasks we can have..
  */
 #define IDT_ENTRIES 256
-
+#define IDT_SIZE (IDT_ENTRIES * 8)
 #endif
Index: linux-2.6.14-rc2-mm1/include/asm-i386/topology.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/topology.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 topology.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/topology.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/topology.h	25 Sep 2005 05:15:35 -0000
@@ -93,6 +93,7 @@ extern unsigned long node_end_pfn[];
 extern unsigned long node_remap_size[];
 
 #define node_has_online_mem(nid) (node_start_pfn[nid] != node_end_pfn[nid])
+#define early_node_to_cpumask(nid)	node_to_cpumask(nid)
 
 #else /* !CONFIG_NUMA */
 /*
@@ -100,6 +101,13 @@ extern unsigned long node_remap_size[];
  * above macros here.
  */
 
+static inline cpumask_t early_node_to_cpumask(int nid)
+{
+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return cpu_present_map;
+
+	return cpu_online_map;
+}
 #include <asm-generic/topology.h>
 
 #endif /* CONFIG_NUMA */
Index: linux-2.6.14-rc2-mm1/include/asm-i386/mach-default/irq_vectors_limits.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/mach-default/irq_vectors_limits.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors_limits.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/mach-default/irq_vectors_limits.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/mach-default/irq_vectors_limits.h	25 Sep 2005 05:15:35 -0000
@@ -2,11 +2,15 @@
 #define _ASM_IRQ_VECTORS_LIMITS_H
 
 #ifdef CONFIG_PCI_MSI
-#define NR_IRQS FIRST_SYSTEM_VECTOR
+#define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #define NR_IRQ_VECTORS NR_IRQS
+#define NR_IRQ_NODES	MAX_NUMNODES
 #else
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
+#define NR_IRQ_NODES	MAX_NUMNODES
 # if (224 >= 32 * NR_CPUS)
 # define NR_IRQ_VECTORS NR_IRQS
 # else
@@ -14,8 +18,13 @@
 # endif
 #else
 #define NR_IRQS 16
+#define IRQ_STUB_SIZE 16
+#define NR_IRQ_NODES	1
 #define NR_IRQ_VECTORS NR_IRQS
 #endif
 #endif
 
+/* number of vectors available for external interrupts in Linux */
+#define NR_DEVICE_VECTORS	190
+
 #endif /* _ASM_IRQ_VECTORS_LIMITS_H */
Index: linux-2.6.14-rc2-mm1/include/asm-i386/mach-visws/irq_vectors.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/mach-visws/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/mach-visws/irq_vectors.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/mach-visws/irq_vectors.h	25 Sep 2005 05:15:35 -0000
@@ -51,7 +51,10 @@
  */
 #define NR_VECTORS 256
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #define NR_IRQ_VECTORS NR_IRQS
+/* number of vectors available for external interrupts in Linux */
+#define NR_DEVICE_VECTORS	190
 
 #define FPU_IRQ			13
 
Index: linux-2.6.14-rc2-mm1/include/asm-i386/mach-voyager/irq_vectors.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-i386/mach-voyager/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.6.14-rc2-mm1/include/asm-i386/mach-voyager/irq_vectors.h	24 Sep 2005 18:27:12 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-i386/mach-voyager/irq_vectors.h	25 Sep 2005 05:15:35 -0000
@@ -57,7 +57,10 @@
 
 #define NR_VECTORS 256
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #define NR_IRQ_VECTORS NR_IRQS
+/* number of vectors available for external interrupts in Linux */
+#define NR_DEVICE_VECTORS	190
 
 #define FPU_IRQ				13
 
Index: linux-2.6.14-rc2-mm1/include/asm-ia64/msi.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-ia64/msi.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 msi.h
--- linux-2.6.14-rc2-mm1/include/asm-ia64/msi.h	24 Sep 2005 18:27:13 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-ia64/msi.h	25 Sep 2005 05:15:35 -0000
@@ -10,6 +10,7 @@
 #define FIRST_DEVICE_VECTOR 	IA64_FIRST_DEVICE_VECTOR
 #define LAST_DEVICE_VECTOR	IA64_LAST_DEVICE_VECTOR
 static inline void set_intr_gate (int nr, void *func) {}
+#define node_set_intr_gate(node, vec, addr)     set_intr_gate(vec, addr)
 #define IO_APIC_VECTOR(irq)	(irq)
 #define ack_APIC_irq		ia64_eoi
 #define cpu_mask_to_apicid(mask) cpu_physical_id(first_cpu(mask))
Index: linux-2.6.14-rc2-mm1/include/asm-x86_64/msi.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/include/asm-x86_64/msi.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 msi.h
--- linux-2.6.14-rc2-mm1/include/asm-x86_64/msi.h	24 Sep 2005 18:27:06 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/include/asm-x86_64/msi.h	25 Sep 2005 05:15:35 -0000
@@ -14,5 +14,5 @@
 #define MSI_DEST_MODE			MSI_LOGICAL_MODE
 #define MSI_TARGET_CPU_SHIFT		12
 #define MSI_TARGET_CPU			logical_smp_processor_id()
-
+#define	node_set_intr_gate(node, vec, addr)	set_intr_gate(vec, addr)
 #endif /* ASM_MSI_H */
Index: linux-2.6.14-rc2-mm1/init/main.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc2-mm1/init/main.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 main.c
--- linux-2.6.14-rc2-mm1/init/main.c	24 Sep 2005 18:27:23 -0000	1.1.1.1
+++ linux-2.6.14-rc2-mm1/init/main.c	25 Sep 2005 05:15:35 -0000
@@ -314,10 +314,13 @@ extern void setup_arch(char **);
 
 #ifndef CONFIG_SMP
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86
 static void __init smp_init(void)
 {
+	setup_idts();
+#ifdef CONFIG_X86_LOCAL_APIC
 	APIC_init_uniprocessor();
+#endif
 }
 #else
 #define smp_init()	do { } while (0)
