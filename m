Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTE3GIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTE3GIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:08:37 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:42368
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263285AbTE3GIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:08:10 -0400
Date: Fri, 30 May 2003 02:11:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Brian Gerst <bgerst@didntduck.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH][ANNOUNCE][1/1] 32way/8quad NUMAQ booting with NR_IRQS = 640
In-Reply-To: <Pine.LNX.4.50.0305300111300.2176-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0305300210300.2176-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0305300111300.2176-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.70-irqscale/arch/i386/kernel/doublefault.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/doublefault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 doublefault.c
--- linux-2.5.70-irqscale/arch/i386/kernel/doublefault.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/doublefault.c	30 May 2003 00:20:24 -0000
@@ -16,7 +16,7 @@ static unsigned long doublefault_stack[D
 
 static void doublefault_fn(void)
 {
-	struct Xgt_desc_struct gdt_desc = {0, 0};
+	struct Xdt_desc_struct gdt_desc = {0, 0};
 	unsigned long gdt, tss;
 
 	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");
Index: linux-2.5.70-irqscale/arch/i386/kernel/entry.S
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/entry.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 entry.S
--- linux-2.5.70-irqscale/arch/i386/kernel/entry.S	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/entry.S	28 May 2003 20:16:43 -0000
@@ -374,27 +374,17 @@ syscall_badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
 
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
+ENTRY(irq_entries)
 .rept NR_IRQS
-	ALIGN
-1:	pushl $vector-256
+1:	pushl $vector
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
 	call do_IRQ
Index: linux-2.5.70-irqscale/arch/i386/kernel/head.S
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 head.S
--- linux-2.5.70-irqscale/arch/i386/kernel/head.S	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/head.S	30 May 2003 00:20:24 -0000
@@ -249,7 +249,7 @@ is386:	movl $2,%ecx		# set MP
 	call check_x87
 	incb ready
 	lgdt cpu_gdt_descr
-	lidt idt_descr
+	lidt node_idt_descr		# we switch to the per-node IDTs later
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
 	movl %eax,%ss			# after changing gdt.
@@ -314,7 +314,7 @@ setup_idt:
 	movw %dx,%ax		/* selector = 0x0010 = cs */
 	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
 
-	lea idt_table,%edi
+	lea node_idt_table,%edi
 	mov $256,%ecx
 rp_sidt:
 	movl %eax,(%edi)
@@ -359,14 +359,16 @@ ignore_int:
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
Index: linux-2.5.70-irqscale/arch/i386/kernel/i8259.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 i8259.c
--- linux-2.5.70-irqscale/arch/i386/kernel/i8259.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/i8259.c	30 May 2003 01:17:25 -0000
@@ -427,10 +427,10 @@ void __init init_IRQ(void)
 	 * us. (some of these will be overridden and become
 	 * 'special' SMP interrupts)
 	 */
-	for (i = 0; i < NR_IRQS; i++) {
+	for (i = 0; i < NR_DEVICE_VECTORS; i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (vector != SYSCALL_VECTOR) 
-			set_intr_gate(vector, interrupt[i]);
+			set_intr_gate(vector, &irq_entries[i]);
 	}
 
 	/* setup after call gates are initialised (usually add in
Index: linux-2.5.70-irqscale/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.5.70-irqscale/arch/i386/kernel/io_apic.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/io_apic.c	30 May 2003 01:22:06 -0000
@@ -1117,24 +1117,54 @@ static inline int IO_APIC_irq_trigger(in
 }
 
 int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
-
-static int __init assign_irq_vector(int irq)
+int __initdata vector_allocated[MAX_NUMNODES][FIRST_SYSTEM_VECTOR];
+  
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
-
-	if (current_vector >= FIRST_SYSTEM_VECTOR) {
-		offset = (offset + 1) & 7;
-		current_vector = FIRST_DEVICE_VECTOR + offset;
+  
+	if (current_vector[node] >= FIRST_SYSTEM_VECTOR) {
+		offset[node] = (offset[node] + 1) & 7;
+		current_vector[node] = FIRST_DEVICE_VECTOR + offset[node];
 	}
 
-	IO_APIC_VECTOR(irq) = current_vector;
-	return current_vector;
+	if (current_vector[node] == FIRST_SYSTEM_VECTOR)
+		return -ENOSPC;
+  
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
@@ -1143,7 +1173,7 @@ static struct hw_interrupt_type ioapic_e
 void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
-	int apic, pin, idx, irq, first_notcon = 1, vector;
+	int apic, pin, idx, irq, first_notcon = 1, vector, bus, node;
 	unsigned long flags;
 
 	printk(KERN_DEBUG "init IO_APIC IRQs\n");
@@ -1160,11 +1190,12 @@ void __init setup_IO_APIC_irqs(void)
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
@@ -1174,12 +1205,21 @@ void __init setup_IO_APIC_irqs(void)
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
@@ -1193,15 +1233,20 @@ void __init setup_IO_APIC_irqs(void)
 			continue;
 
 		if (IO_APIC_IRQ(irq)) {
-			vector = assign_irq_vector(irq);
-			entry.vector = vector;
+			vector = assign_irq_vector(irq, node);
+			if (vector < 0)
+				continue;
 
+			entry.vector = vector;
 			if (IO_APIC_irq_trigger(irq))
 				irq_desc[irq].handler = &ioapic_level_irq_type;
 			else
 				irq_desc[irq].handler = &ioapic_edge_irq_type;
 
-			set_intr_gate(vector, interrupt[irq]);
+			Dprintk("irq_setup: node%d/bus%d/ioapic%d/vector0x%x - irq%d %p\n",
+				node, bus, apic, vector, irq, &irq_entries[irq]);
+
+			node_set_intr_gate(node, vector, &irq_entries[irq]);
 		
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
@@ -1896,6 +1941,7 @@ static inline void init_IO_APIC_traps(vo
 			 * so default to an old-fashioned 8259
 			 * interrupt if we can..
 			 */
+			printk(KERN_DEBUG "irq%d not serviced by IOAPIC\n", irq);
 			if (irq < 16)
 				make_8259A_irq(irq);
 			else
@@ -2034,8 +2080,10 @@ static inline void check_timer(void)
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
-	vector = assign_irq_vector(0);
-	set_intr_gate(vector, interrupt[0]);
+
+	vector = assign_irq_vector(0, cpu_to_node(smp_processor_id()));
+	/* This gets reserved on all nodes as FIRST_DEVICE_VECTOR */
+	set_intr_gate(vector, &irq_entries[0]);
 
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
@@ -2291,10 +2339,10 @@ int io_apic_set_pci_routing (int ioapic,
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	int node, bus, vector;
 
 	if (!IO_APIC_IRQ(irq)) {
-		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0/n", 
-			ioapic);
+		printk(KERN_ERR "ioapic%d invalid reference to IRQ0/n", ioapic);
 		return -EINVAL;
 	}
 
@@ -2315,7 +2363,18 @@ int io_apic_set_pci_routing (int ioapic,
 
 	add_pin_to_irq(irq, ioapic, pin);
 
-	entry.vector = assign_irq_vector(irq);
+	/* XXX verify this with an x440 and plain ACPI/SMP -zwane */
+	bus = mp_irqs[pin].mpc_srcbus;
+	node = mp_bus_id_to_node[bus];
+
+	vector = assign_irq_vector(irq, node);
+	if (vector < 0)
+		return -ENOSPC;
+	
+	entry.vector = vector;
+	printk(KERN_DEBUG "NODE[%d] IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
+		"IRQ %d)\n", node, ioapic, 
+  		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
 
 	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
 		"IRQ %d)\n", ioapic, 
@@ -2323,7 +2382,7 @@ int io_apic_set_pci_routing (int ioapic,
 
 	irq_desc[irq].handler = &ioapic_level_irq_type;
 
-	set_intr_gate(entry.vector, interrupt[irq]);
+	node_set_intr_gate(node, entry.vector, &irq_entries[irq]);
 
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
Index: linux-2.5.70-irqscale/arch/i386/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.5.70-irqscale/arch/i386/kernel/irq.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/irq.c	28 May 2003 20:16:43 -0000
@@ -354,7 +354,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	 * 0 return value means that this irq is already being
 	 * handled by some other CPU. (or is disabled)
 	 */
-	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
+	int irq = regs.orig_eax;
 	int cpu = smp_processor_id();
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
Index: linux-2.5.70-irqscale/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.5.70-irqscale/arch/i386/kernel/smpboot.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/smpboot.c	30 May 2003 00:20:25 -0000
@@ -45,6 +45,7 @@
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
+#include <asm/cpu.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
@@ -442,6 +443,7 @@ int __init start_secondary(void *unused)
 	 */
 	cpu_init();
 	smp_callin();
+	setup_cpu_idt();
 	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
 		rep_nop();
 	setup_secondary_APIC_clock();
@@ -949,7 +951,7 @@ static void __init smp_boot_cpus(unsigne
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
-
+	
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
@@ -1165,7 +1167,7 @@ void __init smp_intr_init(void)
 	 * IRQ0 must be given a fixed assignment and initialized,
 	 * because it's used before the IO-APIC is set up.
 	 */
-	set_intr_gate(FIRST_DEVICE_VECTOR, interrupt[0]);
+	set_intr_gate(FIRST_DEVICE_VECTOR, &irq_entries[0]);
 
 	/*
 	 * The reschedule interrupt is a CPU-to-CPU reschedule-helper
Index: linux-2.5.70-irqscale/arch/i386/kernel/traps.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.5.70-irqscale/arch/i386/kernel/traps.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/traps.c	30 May 2003 01:23:22 -0000
@@ -30,6 +30,7 @@
 #include <linux/ioport.h>
 #endif
 
+#include <asm/cpu.h>
 #ifdef CONFIG_MCA
 #include <linux/mca.h>
 #include <asm/processor.h>
@@ -68,7 +69,9 @@ char ignore_fpu_irq = 0;
  * F0 0F bug workaround.. We have a special link segment
  * for this.
  */
-struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
+
+struct desc_struct node_idt_table[MAX_NUMNODES][IDT_ENTRIES] __attribute__((__section__(".data.idt"))) = 
+	{[0 ... MAX_NUMNODES-1] = { {0, 0}, }};
 
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -774,14 +777,16 @@ asmlinkage void math_emulate(long arg)
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
 
@@ -800,24 +805,36 @@ do { \
 
 
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
@@ -827,7 +844,9 @@ static void __init set_call_gate(void *a
 
 static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
 {
-	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++)
+		_set_gate(&node_idt_table[node][n],5,0,0,(gdt_entry<<3));
 }
 
 
@@ -847,6 +866,7 @@ void __init trap_init(void)
 	init_apic_mappings();
 #endif
 
+	/* setup the default IDT */
 	set_trap_gate(0,&divide_error);
 	set_intr_gate(1,&debug);
 	set_intr_gate(2,&nmi);
@@ -878,6 +898,9 @@ void __init trap_init(void)
 	 */
 	set_call_gate(&default_ldt[0],lcall7);
 	set_call_gate(&default_ldt[4],lcall27);
+
+	/* setup the pernode idt tables */
+	setup_node_idts();
 
 	/*
 	 * Should be a barrier for any external CPU state.
Index: linux-2.5.70-irqscale/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 common.c
--- linux-2.5.70-irqscale/arch/i386/kernel/cpu/common.c	27 May 2003 02:20:19 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/kernel/cpu/common.c	30 May 2003 00:20:25 -0000
@@ -433,9 +433,9 @@ void __init early_cpu_init(void)
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
@@ -459,8 +459,8 @@ void __init cpu_init (void)
 	}
 
 	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
+	 * Initialize the per-CPU GDTs with the boot equivalents,
+	 * and set up the descriptors:
 	 */
 	if (cpu) {
 		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
@@ -473,7 +473,6 @@ void __init cpu_init (void)
 	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
 
 	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 
 	/*
 	 * Delete NT
@@ -517,3 +516,31 @@ void __init cpu_init (void)
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
Index: linux-2.5.70-irqscale/arch/i386/mm/fault.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fault.c
--- linux-2.5.70-irqscale/arch/i386/mm/fault.c	27 May 2003 02:20:20 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/arch/i386/mm/fault.c	30 May 2003 00:20:25 -0000
@@ -216,9 +216,9 @@ bad_area:
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
Index: linux-2.5.70-irqscale/include/asm-i386/cpu.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/cpu.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpu.h
--- linux-2.5.70-irqscale/include/asm-i386/cpu.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/cpu.h	30 May 2003 00:20:25 -0000
@@ -23,4 +23,6 @@ static inline int arch_register_cpu(int 
 	return register_cpu(&cpu_devices[num].cpu, num, parent);
 }
 
+extern void setup_cpu_idt(void);
+extern void setup_node_idts(void);
 #endif /* _ASM_I386_CPU_H_ */
Index: linux-2.5.70-irqscale/include/asm-i386/desc.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/desc.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 desc.h
--- linux-2.5.70-irqscale/include/asm-i386/desc.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/desc.h	30 May 2003 00:20:25 -0000
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
@@ -29,7 +31,8 @@ extern struct Xgt_desc_struct idt_descr,
  * something other than this.
  */
 extern struct desc_struct default_ldt[];
-extern void set_intr_gate(unsigned int irq, void * addr);
+extern void node_set_intr_gate(unsigned int node, unsigned int vector, void * addr);
+extern void set_intr_gate(unsigned int n, void *addr);
 
 #define _set_tssldt_desc(n,addr,limit,type) \
 __asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
Index: linux-2.5.70-irqscale/include/asm-i386/hardirq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/hardirq.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 hardirq.h
--- linux-2.5.70-irqscale/include/asm-i386/hardirq.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/hardirq.h	30 May 2003 01:29:53 -0000
@@ -20,20 +20,20 @@ typedef struct {
  * We put the hardirq and softirq counter into the preemption
  * counter. The bitmask has the following meaning:
  *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
+ * - bits 0-9 are the preemption count (max preemption depth: 256)
+ * - bits 10-19 are the softirq count (max # of softirqs: 256)
+ * - bits 20-29 are the hardirq count (max # of hardirqs: 256)
  *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
+ * - ( bit 31 is the PREEMPT_ACTIVE flag. )
  *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
+ * PREEMPT_MASK: 0x000003ff
+ * SOFTIRQ_MASK: 0x000ffc00
+ * HARDIRQ_MASK: 0x3ff00000
  */
 
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
-#define HARDIRQ_BITS	8
+#define PREEMPT_BITS	10
+#define SOFTIRQ_BITS	10
+#define HARDIRQ_BITS	10
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
Index: linux-2.5.70-irqscale/include/asm-i386/hw_irq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/hw_irq.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 hw_irq.h
--- linux-2.5.70-irqscale/include/asm-i386/hw_irq.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/hw_irq.h	28 May 2003 20:16:43 -0000
@@ -27,7 +27,7 @@
 extern int irq_vector[NR_IRQS];
 #define IO_APIC_VECTOR(irq)	irq_vector[irq]
 
-extern void (*interrupt[NR_IRQS])(void);
+extern char irq_entries[NR_IRQS][IRQ_STUB_SIZE];
 
 #ifdef CONFIG_SMP
 extern asmlinkage void reschedule_interrupt(void);
Index: linux-2.5.70-irqscale/include/asm-i386/numaq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/numaq.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 numaq.h
--- linux-2.5.70-irqscale/include/asm-i386/numaq.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/numaq.h	30 May 2003 00:20:25 -0000
@@ -29,6 +29,8 @@
 #ifdef CONFIG_X86_NUMAQ
 
 #define MAX_NUMNODES		8
+
+#ifndef __ASSEMBLY__
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
 
@@ -161,6 +163,7 @@ static inline unsigned long *get_zholes_
 {
 	return 0;
 }
+#endif /* __ASSEMBLY__ */
 #endif /* CONFIG_X86_NUMAQ */
 #endif /* NUMAQ_H */
 
Index: linux-2.5.70-irqscale/include/asm-i386/segment.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/segment.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 segment.h
--- linux-2.5.70-irqscale/include/asm-i386/segment.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/segment.h	30 May 2003 00:20:25 -0000
@@ -94,5 +94,5 @@
  * of tasks we can have..
  */
 #define IDT_ENTRIES 256
-
+#define IDT_SIZE (IDT_ENTRIES * 8)
 #endif
Index: linux-2.5.70-irqscale/include/asm-i386/srat.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/srat.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 srat.h
--- linux-2.5.70-irqscale/include/asm-i386/srat.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/srat.h	30 May 2003 00:20:25 -0000
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
Index: linux-2.5.70-irqscale/include/asm-i386/thread_info.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/thread_info.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 thread_info.h
--- linux-2.5.70-irqscale/include/asm-i386/thread_info.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/thread_info.h	30 May 2003 01:31:00 -0000
@@ -52,7 +52,11 @@ struct thread_info {
 
 #endif
 
-#define PREEMPT_ACTIVE		0x4000000
+#ifdef __ASSEMBLY__
+#define PREEMPT_ACTIVE	0x80000000
+#else
+#define PREEMPT_ACTIVE	0x80000000UL
+#endif
 
 /*
  * macros/functions for gaining access to the thread information structure
Index: linux-2.5.70-irqscale/include/asm-i386/mach-default/irq_vectors.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/mach-default/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.5.70-irqscale/include/asm-i386/mach-default/irq_vectors.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/mach-default/irq_vectors.h	30 May 2003 01:17:41 -0000
@@ -77,10 +77,15 @@
  * the usable vector space is 0x20-0xff (224 vectors)
  */
 #ifdef CONFIG_X86_IO_APIC
-#define NR_IRQS 224
+#define NR_IRQS 640
+#define IRQ_STUB_SIZE 16
 #else
 #define NR_IRQS 16
+#define IRQ_STUB_SIZE 8
 #endif
+
+/* number of vectors available for external interrupts in Linux */
+#define NR_DEVICE_VECTORS	190
 
 #define FPU_IRQ			13
 
Index: linux-2.5.70-irqscale/include/asm-i386/mach-pc9800/irq_vectors.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/mach-pc9800/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.5.70-irqscale/include/asm-i386/mach-pc9800/irq_vectors.h	27 May 2003 02:20:11 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/mach-pc9800/irq_vectors.h	28 May 2003 20:16:43 -0000
@@ -78,8 +78,10 @@
  */
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 #else
 #define NR_IRQS 16
+#define IRQ_STUB_SIZE 8
 #endif
 
 #define FPU_IRQ			8
Index: linux-2.5.70-irqscale/include/asm-i386/mach-visws/irq_vectors.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/mach-visws/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.5.70-irqscale/include/asm-i386/mach-visws/irq_vectors.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/mach-visws/irq_vectors.h	28 May 2003 20:16:43 -0000
@@ -50,6 +50,7 @@
  * 
  */
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 
 #define FPU_IRQ			13
 
Index: linux-2.5.70-irqscale/include/asm-i386/mach-voyager/irq_vectors.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/include/asm-i386/mach-voyager/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.5.70-irqscale/include/asm-i386/mach-voyager/irq_vectors.h	27 May 2003 02:20:10 -0000	1.1.1.1
+++ linux-2.5.70-irqscale/include/asm-i386/mach-voyager/irq_vectors.h	28 May 2003 20:16:43 -0000
@@ -56,6 +56,7 @@
 #define VIC_CPU_BOOT_ERRATA_CPI		(VIC_CPI_LEVEL0 + 8)
 
 #define NR_IRQS 224
+#define IRQ_STUB_SIZE 16
 
 #define FPU_IRQ				13
 

-- 
function.linuxpower.ca
