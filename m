Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262096AbTCRFiP>; Tue, 18 Mar 2003 00:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262161AbTCRFiP>; Tue, 18 Mar 2003 00:38:15 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:18516
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262096AbTCRFiD>; Tue, 18 Mar 2003 00:38:03 -0500
Date: Tue, 18 Mar 2003 00:44:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Martin Bligh <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] Per node IDTs/vectors
Message-ID: <Pine.LNX.4.50.0303172028500.28354-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a more indepth explanation behind the purpose of this patch please 
refer to message:
Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com

before: Uninode SMP
   text    data     bss     dec     hex filename
2312949  577348  395044 3285341  32215d vmlinux

after: Uninode SMP
   text    data     bss     dec     hex filename
2313429  578364  395076 3286869  322755 vmlinux

before: Multinode SMP
   text    data     bss     dec     hex filename
2232720  720796  453376 3406892  33fc2c vmlinux

after: Multinode SMP
   text    data     bss     dec     hex filename
2233456  742804  453408 3429668  345524 vmlinux

The patch has been tested and survived stress testing on;
(hardware courtesy of OSDL)
UP i686 w/ and w/o IOAPIC
8way PIII 700 Walmart/SMP
32way PIII 500 NUMAQ/SMP

/proc/interrupts from 32way
http://www.osdl.org/projects/numaqhwspprt/results/interrupts

Untested on;
UP w/ ACPI/IOAPIC
ACPI/SMP

 arch/i386/kernel/cpu/common.c  |   39 ++++++++++++---
 arch/i386/kernel/doublefault.c |    2
 arch/i386/kernel/head.S        |   12 ++--
 arch/i386/kernel/io_apic.c     |  105 ++++++++++++++++++++++++++++++-----------
 arch/i386/kernel/smpboot.c     |    2
 arch/i386/kernel/traps.c       |   40 ++++++++++++---
 arch/i386/mm/fault.c           |    6 +-
 include/asm-i386/cpu.h         |    2
 include/asm-i386/desc.h        |    9 ++-
 include/asm-i386/numaq.h       |    3 +
 include/asm-i386/segment.h     |    2
 include/asm-i386/srat.h        |    3 -
 12 files changed, 168 insertions(+), 57 deletions(-)

Index: linux-2.5.65-numaq/arch/i386/kernel/doublefault.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/i386/kernel/doublefault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 doublefault.c
--- linux-2.5.65-numaq/arch/i386/kernel/doublefault.c	17 Mar 2003 23:08:55 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/i386/kernel/doublefault.c	18 Mar 2003 00:51:38 -0000
@@ -16,7 +16,7 @@
 
 static void doublefault_fn(void)
 {
-	struct Xgt_desc_struct gdt_desc = {0, 0};
+	struct Xdt_desc_struct gdt_desc = {0, 0};
 	unsigned long gdt, tss;
 
 	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");
Index: linux-2.5.65-numaq/arch/i386/kernel/head.S
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/arch/i386/kernel/head.S	17 Mar 2003 23:08:54 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/i386/kernel/head.S	18 Mar 2003 00:51:38 -0000
@@ -249,7 +249,7 @@
 	call check_x87
 	incb ready
 	lgdt cpu_gdt_descr
-	lidt idt_descr
+	lidt node_idt_descr		# we switch to the per-node IDTs later
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
 	movl %eax,%ss			# after changing gdt.
@@ -314,7 +314,7 @@
 	movw %dx,%ax		/* selector = 0x0010 = cs */
 	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
 
-	lea idt_table,%edi
+	lea node_idt_table,%edi
 	mov $256,%ecx
 rp_sidt:
 	movl %eax,(%edi)
@@ -359,14 +359,16 @@
  * segment size, and 32-bit linear address value:
  */
 
-.globl idt_descr
+.globl node_idt_descr
 .globl cpu_gdt_descr
 
 	ALIGN
 	.word 0				# 32-bit align idt_desc.address
-idt_descr:
+node_idt_descr:
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
-	.long idt_table
+	.long node_idt_table
+	
+	.fill MAX_NUMNODES-1,8,0
 
 # boot GDT descriptor (later on used by CPU#0):
 	.word 0				# 32 bit align gdt_desc.address
Index: linux-2.5.65-numaq/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/arch/i386/kernel/io_apic.c	17 Mar 2003 23:08:54 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/i386/kernel/io_apic.c	18 Mar 2003 04:50:19 -0000
@@ -1020,27 +1020,54 @@
 }
 
 int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
+int __initdata vector_allocated[MAX_NUMNODES][FIRST_SYSTEM_VECTOR];
 
-static int __init assign_irq_vector(int irq)
+/*
+ * This is the per node vector allocator, it will only work for systems which have ioapics
+ * which can only deliver vectors to cpus on the same node and thus have hardware enforced
+ * ioapic/irq node affinity. However currently the only i386 systems which have this interrupt
+ * dispatching/servicing architecture are NUMAQ and x440. We try and 'share' vectors where
+ * possible to simplify cases where an irq can be serviced on multiple nodes due to it being
+ * present on multiple busses/nodes. The first pass on node0 will ensure we catch these node
+ * 'shared' irqs.
+ */
+static int __init assign_irq_vector(int irq, int node)
 {
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	if (IO_APIC_VECTOR(irq) > 0)
-		return IO_APIC_VECTOR(irq);
+	static int current_vector[MAX_NUMNODES] = {[0 ... MAX_NUMNODES-1] = FIRST_DEVICE_VECTOR},
+		offset[MAX_NUMNODES];
+	int vector;
+
+	Dprintk("requesting vector for node%d/irq%d\n", node, irq);
+	vector = IO_APIC_VECTOR(irq);
+	if (vector > 0) {
+		Dprintk("returning previous allocation vector0x%x\n", vector);
+		vector_allocated[node][vector] = 1;
+		return vector;
+	}
+	
 next:
-	current_vector += 8;
-	if (current_vector == SYSCALL_VECTOR)
+	current_vector[node] += 8;
+	if (current_vector[node] == SYSCALL_VECTOR)
 		goto next;
 
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
-		offset++;
-		current_vector = FIRST_DEVICE_VECTOR + offset;
+	if (current_vector[node] > FIRST_SYSTEM_VECTOR) {
+		offset[node]++;
+		current_vector[node] = FIRST_DEVICE_VECTOR + offset[node];
 	}
 
-	if (current_vector == FIRST_SYSTEM_VECTOR)
-		panic("ran out of interrupt sources!");
+	if (current_vector[node] == FIRST_SYSTEM_VECTOR)
+		panic("ran out of interrupt vectors!");
 
-	IO_APIC_VECTOR(irq) = current_vector;
-	return current_vector;
+	vector = current_vector[node];
+	if (vector_allocated[node][vector])
+		goto next;
+
+	vector_allocated[node][vector] = 1;
+	IO_APIC_VECTOR(irq) = vector;
+	Dprintk("returning new allocation node%d/irq%d -> vector0x%x\n",
+		node, irq, vector);
+
+	return vector;
 }
 
 static struct hw_interrupt_type ioapic_level_irq_type;
@@ -1049,7 +1076,7 @@
 void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
-	int apic, pin, idx, irq, first_notcon = 1, vector;
+	int apic, pin, idx, irq, first_notcon = 1, vector, bus, node;
 	unsigned long flags;
 
 	printk(KERN_DEBUG "init IO_APIC IRQs\n");
@@ -1066,11 +1093,12 @@
 		entry.dest_mode = INT_DEST_MODE;
 		entry.mask = 0;				/* enable IRQ */
 		entry.dest.logical.logical_dest = TARGET_CPUS;
-
+		
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
 			if (first_notcon) {
-				printk(KERN_DEBUG " IO-APIC (apicid-pin) %d-%d", mp_ioapics[apic].mpc_apicid, pin);
+				printk(KERN_DEBUG " IO-APIC (apicid-pin) %d-%d",
+					mp_ioapics[apic].mpc_apicid, pin);
 				first_notcon = 0;
 			} else
 				printk(", %d-%d", mp_ioapics[apic].mpc_apicid, pin);
@@ -1080,12 +1108,21 @@
 		entry.trigger = irq_trigger(idx);
 		entry.polarity = irq_polarity(idx);
 
+		bus = mp_irqs[idx].mpc_srcbus;
+		node = mp_bus_id_to_node[bus];
+
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
+		if (irq >= NR_IRQS) {
+			printk("skipping irq%d on node%d/bus%d/ioapic%d out of IRQs!\n",
+				irq, node, bus, apic);
+			continue;
+		}
+		
 		/*
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
@@ -1099,7 +1136,7 @@
 			continue;
 
 		if (IO_APIC_IRQ(irq)) {
-			vector = assign_irq_vector(irq);
+			vector = assign_irq_vector(irq, node);
 			entry.vector = vector;
 
 			if (IO_APIC_irq_trigger(irq))
@@ -1107,11 +1144,15 @@
 			else
 				irq_desc[irq].handler = &ioapic_edge_irq_type;
 
-			set_intr_gate(vector, interrupt[irq]);
-		
+			Dprintk("irq_setup: node%d/bus%d/ioapic%d/vector0x%x - irq%d %p\n",
+				node, bus, apic, vector, irq, interrupt[irq]);
+
+			node_set_intr_gate(node, vector, interrupt[irq]);
+	
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
 		}
+		
 		spin_lock_irqsave(&ioapic_lock, flags);
 		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
 		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
@@ -1801,6 +1842,7 @@
 			 * so default to an old-fashioned 8259
 			 * interrupt if we can..
 			 */
+			printk(KERN_DEBUG "irq%d not serviced by IOAPIC\n", irq);
 			if (irq < 16)
 				make_8259A_irq(irq);
 			else
@@ -1939,9 +1981,10 @@
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
-	vector = assign_irq_vector(0);
+	vector = assign_irq_vector(0, cpu_to_node(smp_processor_id()));
+	/* This gets reserved on all nodes as FIRST_DEVICE_VECTOR */
 	set_intr_gate(vector, interrupt[0]);
-
+	
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
 	 * mode for the 8259A whenever interrupts are routed
@@ -2196,10 +2239,10 @@
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	int node;
 
 	if (!IO_APIC_IRQ(irq)) {
-		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0/n", 
-			ioapic);
+		printk(KERN_ERR "ioapic%d invalid reference to IRQ0/n", ioapic);
 		return -EINVAL;
 	}
 
@@ -2219,17 +2262,23 @@
 	entry.polarity = 1;					/* Low active */
 
 	add_pin_to_irq(irq, ioapic, pin);
+	
+	/* XXX verify this with an x440 and plain ACPI/SMP -zwane */
+	bus = mp_irqs[idx].mpc_srcbus;
+	node = mp_bus_id_to_node[bus];
 
-	entry.vector = assign_irq_vector(irq);
+	entry.vector = assign_irq_vector(irq, node);
 
-	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
-		"IRQ %d)\n", ioapic, 
+	printk(KERN_DEBUG "NODE[%d] IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
+		"IRQ %d)\n", node, ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
 
 	irq_desc[irq].handler = &ioapic_level_irq_type;
 
-	set_intr_gate(entry.vector, interrupt[irq]);
-
+	printk(KERN_DEBUG "irq_route: node%d/bus%d/ioapic%d/vector0x%x - irq%d %p\n",
+		node, bus, ioapic, vector, irq, interrupt[irq]);
+	node_set_intr_gate(node, vector, interrupt[irq]);
+	
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
 
Index: linux-2.5.65-numaq/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/arch/i386/kernel/smpboot.c	17 Mar 2003 23:08:55 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/i386/kernel/smpboot.c	18 Mar 2003 04:56:46 -0000
@@ -45,6 +45,7 @@
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
+#include <asm/cpu.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
@@ -442,6 +443,7 @@
 	 */
 	cpu_init();
 	smp_callin();
+	setup_cpu_idt();
 	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
 		rep_nop();
 	setup_secondary_APIC_clock();
Index: linux-2.5.65-numaq/arch/i386/kernel/traps.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.5.65-numaq/arch/i386/kernel/traps.c	17 Mar 2003 23:08:54 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/i386/kernel/traps.c	18 Mar 2003 05:04:26 -0000
@@ -30,6 +30,7 @@
 #include <linux/ioport.h>
 #endif
 
+#include <asm/cpu.h>
 #ifdef CONFIG_MCA
 #include <linux/mca.h>
 #include <asm/processor.h>
@@ -63,7 +64,9 @@
  * F0 0F bug workaround.. We have a special link segment
  * for this.
  */
-struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
+
+struct desc_struct node_idt_table[MAX_NUMNODES][IDT_ENTRIES] __attribute__((__section__(".data.idt"))) = 
+	{[0 ... MAX_NUMNODES-1] = { {0, 0}, }};
 
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -762,14 +765,16 @@
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
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	node_idt_descr[node].address = fix_to_virt(FIX_F00F_IDT);
+	__asm__ __volatile__("lidt %0": "=m" (node_idt_descr[node]));
 }
 #endif
 
@@ -788,24 +793,36 @@
 
 
 /*
- * This needs to use 'idt_table' rather than 'idt', and
+ * This needs to use 'node_idt_table' rather than 'idt', and
  * thus use the _nonmapped_ version of the IDT, as the
  * Pentium F0 0F bugfix can have resulted in the mapped
  * IDT being write-protected.
  */
+
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
+ 		node_set_intr_gate(node, n, addr);
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
 
 static void __init set_call_gate(void *a, void *addr)
@@ -815,7 +832,9 @@
 
 static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
 {
-	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++)
+		_set_gate(&node_idt_table[node][n],5,0,0,(gdt_entry<<3));
 }
 
 
@@ -869,6 +888,9 @@
 	 */
 	set_call_gate(&default_ldt[0],lcall7);
 	set_call_gate(&default_ldt[4],lcall27);
+
+	/* setup the pernode idt tables */
+	setup_node_idts();
 
 	/*
 	 * Should be a barrier for any external CPU state.
Index: linux-2.5.65-numaq/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/arch/i386/kernel/cpu/common.c	17 Mar 2003 23:08:55 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/i386/kernel/cpu/common.c	18 Mar 2003 04:47:29 -0000
@@ -429,9 +429,9 @@
 }
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
- * initialized (naturally) in the bootstrap process, such as the GDT
- * and IDT. We reload them nevertheless, this function acts as a
- * 'CPU state barrier', nothing should get across.
+ * initialized (naturally) in the bootstrap process, such as the GDT.
+ * We reload them nevertheless, this function acts as a 'CPU state barrier',
+ * nothing should get across.
  */
 void __init cpu_init (void)
 {
@@ -455,8 +455,8 @@
 	}
 
 	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
+	 * Initialize the per-CPU GDTs with the boot equivalents,
+	 * and set up the descriptors:
 	 */
 	if (cpu) {
 		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
@@ -469,7 +469,6 @@
 	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
 
 	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 
 	/*
 	 * Delete NT
@@ -513,3 +512,31 @@
 	current->used_math = 0;
 	stts();
 }
+
+/*
+ * copy over the boot node idt across all nodes, we currently only have
+ * non-unique idt entries for device io interrupts.
+ */
+void __init setup_node_idts(void)
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
+void __init setup_cpu_idt(void)
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
Index: linux-2.5.65-numaq/arch/i386/mm/fault.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/arch/i386/mm/fault.c	17 Mar 2003 23:08:56 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/i386/mm/fault.c	18 Mar 2003 00:51:38 -0000
@@ -297,9 +297,9 @@
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
Index: linux-2.5.65-numaq/include/asm-i386/cpu.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/include/asm-i386/cpu.h,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/include/asm-i386/cpu.h	17 Mar 2003 23:08:36 -0000	1.1.1.1
+++ linux-2.5.65-numaq/include/asm-i386/cpu.h	18 Mar 2003 00:51:38 -0000
@@ -23,4 +23,6 @@
 	return register_cpu(&cpu_devices[num].cpu, num, parent);
 }
 
+extern void setup_cpu_idt(void);
+extern void setup_node_idts(void);
 #endif /* _ASM_I386_CPU_H_ */
Index: linux-2.5.65-numaq/include/asm-i386/desc.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/include/asm-i386/desc.h,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/include/asm-i386/desc.h	17 Mar 2003 23:08:36 -0000	1.1.1.1
+++ linux-2.5.65-numaq/include/asm-i386/desc.h	18 Mar 2003 00:51:38 -0000
@@ -2,6 +2,7 @@
 #define __ARCH_DESC_H
 
 #include <asm/ldt.h>
+#include <asm/numnodes.h>
 #include <asm/segment.h>
 
 #ifndef __ASSEMBLY__
@@ -12,14 +13,15 @@
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
+extern struct desc_struct node_idt_table[MAX_NUMNODES][IDT_ENTRIES];
 
-struct Xgt_desc_struct {
+struct Xdt_desc_struct {
 	unsigned short size;
 	unsigned long address __attribute__((packed));
 	unsigned short pad;
 } __attribute__ ((packed));
 
-extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
+extern struct Xdt_desc_struct node_idt_descr[MAX_NUMNODES], cpu_gdt_descr[NR_CPUS]; 
 
 #define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (GDT_ENTRY_LDT*8))
@@ -29,7 +31,8 @@
  * something other than this.
  */
 extern struct desc_struct default_ldt[];
-extern void set_intr_gate(unsigned int irq, void * addr);
+extern void node_set_intr_gate(unsigned int node, unsigned int vector, void * addr);
+extern void set_intr_gate(unsigned int n, void *addr);
 
 #define _set_tssldt_desc(n,addr,limit,type) \
 __asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
Index: linux-2.5.65-numaq/include/asm-i386/numaq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/include/asm-i386/numaq.h,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/include/asm-i386/numaq.h	17 Mar 2003 23:08:36 -0000	1.1.1.1
+++ linux-2.5.65-numaq/include/asm-i386/numaq.h	18 Mar 2003 03:59:38 -0000
@@ -29,6 +29,8 @@
 #ifdef CONFIG_X86_NUMAQ
 
 #define MAX_NUMNODES		8
+
+#ifndef __ASSEMBLY__
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
 
@@ -161,6 +163,7 @@
 {
 	return 0;
 }
+#endif /* __ASSEMBLY__ */
 #endif /* CONFIG_X86_NUMAQ */
 #endif /* NUMAQ_H */
 
Index: linux-2.5.65-numaq/include/asm-i386/segment.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/include/asm-i386/segment.h,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/include/asm-i386/segment.h	17 Mar 2003 23:08:36 -0000	1.1.1.1
+++ linux-2.5.65-numaq/include/asm-i386/segment.h	18 Mar 2003 00:51:38 -0000
@@ -94,5 +94,5 @@
  * of tasks we can have..
  */
 #define IDT_ENTRIES 256
-
+#define IDT_SIZE (IDT_ENTRIES * 8)
 #endif
Index: linux-2.5.65-numaq/include/asm-i386/srat.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/include/asm-i386/srat.h,v
retrieving revision 1.1.1.1
--- linux-2.5.65-numaq/include/asm-i386/srat.h	17 Mar 2003 23:08:36 -0000	1.1.1.1
+++ linux-2.5.65-numaq/include/asm-i386/srat.h	18 Mar 2003 04:00:00 -0000
@@ -28,8 +28,9 @@
 #define _ASM_SRAT_H_
 
 #define MAX_NUMNODES		8
+#ifndef __ASSEMBLY__
 extern void get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);
 #define get_memcfg_numa() get_memcfg_from_srat()
-
+#endif
 #endif /* _ASM_SRAT_H_ */
