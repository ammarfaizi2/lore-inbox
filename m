Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbTCQFPZ>; Mon, 17 Mar 2003 00:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbTCQFPY>; Mon, 17 Mar 2003 00:15:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:17956
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262785AbTCQFPN>; Mon, 17 Mar 2003 00:15:13 -0500
Date: Mon, 17 Mar 2003 00:21:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Mark Haverkamp <markh@osdl.org>
Subject: [PATCH][ANNOUNCE] 32way/8quad NUMAQ booting with 16 IOAPICs, 223
 IRQs
Message-ID: <Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've managed to put together a patch which allows a NUMAQ box with 
more than 8 IOAPICs to boot, the current workaround is to force it to 8 
or lower. This was achieved by setting up percpu idts thus allowing 
us to implement per node vector spaces. The previous hurdle was running out 
of vectors to assign, the current one is running out of irqs, something 
which i'll further be looking at.

Later on i'm planning to move to per node IDTs so that i can fix f00f 
workaround and also save space on nodeless systems. To do this will 
probably require early_cpu_to_node workalikes (or perhaps just use 
logical_smp_processor_id and apic_to_node).

Thanks to the folks at OSDL (and Mark for giving up his 4quad for so 
long) for providing me access to the 8quad.

http://www.osdl.org/projects/numaqhwspprt/results/dmesg-32way-8quad-2.5.64-highirq
http://www.osdl.org/projects/numaqhwspprt/results/lspci-numaq-8quad
http://www.osdl.org/projects/numaqhwspprt/results/mptable-32way-8quad

Running Configuration:
8Quads, 16 IOAPICs, 320 Interrupt sources
32x PIII 500
32G RAM

->sysdef -l
sysdef: System1: dev16-002              State: (Operating System Booting, IQ-Link Init, Running NT)
sysdef:    MDC0: quad0  (Quad_4      ) State: Active          Net: 10.0.0.103 (8.0.47.2.14.D0)
sysdef:    MDC1: quad1  (Quad_5      ) State: Active          Net: 10.0.0.101 (8.0.47.2.15.F4)
sysdef:    MDC2: quad2  (Quad_6      ) State: Active          Net: 10.0.0.104 (8.0.47.2.16.16)
sysdef:    MDC3: quad3  (Quad_7      ) State: Active          Net: 10.0.0.100 (8.0.47.2.15.B5)
sysdef:    MDC4: quad4  (Quad_0      ) State: Active          Net: 10.0.0.109 (8.0.47.2.1B.CF)
sysdef:    MDC5: quad5  (Quad_1      ) State: Active          Net: 10.0.0.107 (8.0.47.2.1A.78)
sysdef:    MDC6: quad6  (Quad_2      ) State: Active          Net: 10.0.0.108 (8.0.47.2.1A.6D)
sysdef:    MDC7: quad7  (Quad_3      ) State: Active          Net: 10.0.0.105 (8.0.47.2.19.9A)
sysdef:    MDC8: lash8  (Lash_8      ) State: Active          Net: 10.0.0.102 (8.0.47.2.1A.5F)
sysdef:    MDC9: lash9  (Lash_4      ) State: Active          Net: 10.0.0.106 (8.0.47.2.1F.3D)

 arch/i386/kernel/apic.c        |    6 +-
 arch/i386/kernel/cpu/common.c  |   11 +++-
 arch/i386/kernel/doublefault.c |    2
 arch/i386/kernel/head.S        |   12 ++--
 arch/i386/kernel/i8259.c       |    2
 arch/i386/kernel/io_apic.c     |  107 ++++++++++++++++++++++++++++-------------
 arch/i386/kernel/smpboot.c     |   10 +--
 arch/i386/kernel/traps.c       |   81 ++++++++++++++++++-------------
 arch/i386/mm/fault.c           |    2
 include/asm-i386/desc.h        |    8 +--
 include/asm-i386/segment.h     |    2
 include/asm-i386/topology.h    |    5 +
 12 files changed, 158 insertions(+), 90 deletions(-)

Patch is against unpatched 2.5.64

Index: linux-2.5.64-numaq/arch/i386/kernel/apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 apic.c
--- linux-2.5.64-numaq/arch/i386/kernel/apic.c	5 Mar 2003 05:08:03 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/kernel/apic.c	7 Mar 2003 07:23:13 -0000
@@ -40,11 +40,11 @@ void __init apic_intr_init(void)
 	smp_intr_init();
 #endif
 	/* self generated IPI for local APIC timer */
-	set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
+	set_intr_gate_all(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
 
 	/* IPI vectors for APIC spurious and error interrupts */
-	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
-	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
+	set_intr_gate_all(SPURIOUS_APIC_VECTOR, spurious_interrupt);
+	set_intr_gate_all(ERROR_APIC_VECTOR, error_interrupt);
 }
 
 /* Using APIC to generate smp_local_timer_interrupt? */
Index: linux-2.5.64-numaq/arch/i386/kernel/doublefault.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/doublefault.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 doublefault.c
--- linux-2.5.64-numaq/arch/i386/kernel/doublefault.c	5 Mar 2003 05:08:04 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/kernel/doublefault.c	7 Mar 2003 07:50:59 -0000
@@ -16,7 +16,7 @@ static unsigned long doublefault_stack[D
 
 static void doublefault_fn(void)
 {
-	struct Xgt_desc_struct gdt_desc = {0, 0};
+	struct Xdt_desc_struct gdt_desc = {0, 0};
 	unsigned long gdt, tss;
 
 	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");
Index: linux-2.5.64-numaq/arch/i386/kernel/head.S
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 head.S
--- linux-2.5.64-numaq/arch/i386/kernel/head.S	5 Mar 2003 05:08:03 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/kernel/head.S	7 Mar 2003 07:23:13 -0000
@@ -249,7 +249,7 @@ is386:	movl $2,%ecx		# set MP
 	call check_x87
 	incb ready
 	lgdt cpu_gdt_descr
-	lidt idt_descr
+	lidt cpu_idt_descr		# we switch to the percpu IDTs later
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
 	movl %eax,%ss			# after changing gdt.
@@ -314,7 +314,7 @@ setup_idt:
 	movw %dx,%ax		/* selector = 0x0010 = cs */
 	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
 
-	lea idt_table,%edi
+	lea cpu_idt_table,%edi
 	mov $256,%ecx
 rp_sidt:
 	movl %eax,(%edi)
@@ -359,14 +359,16 @@ ignore_int:
  * segment size, and 32-bit linear address value:
  */
 
-.globl idt_descr
+.globl cpu_idt_descr
 .globl cpu_gdt_descr
 
 	ALIGN
 	.word 0				# 32-bit align idt_desc.address
-idt_descr:
+cpu_idt_descr:
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
-	.long idt_table
+	.long cpu_idt_table
+	
+	.fill NR_CPUS-1,8,0
 
 # boot GDT descriptor (later on used by CPU#0):
 	.word 0				# 32 bit align gdt_desc.address
Index: linux-2.5.64-numaq/arch/i386/kernel/i8259.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 i8259.c
--- linux-2.5.64-numaq/arch/i386/kernel/i8259.c	5 Mar 2003 05:08:04 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/kernel/i8259.c	7 Mar 2003 07:23:13 -0000
@@ -418,7 +418,7 @@ void __init init_IRQ(void)
 	for (i = 0; i < NR_IRQS; i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (vector != SYSCALL_VECTOR) 
-			set_intr_gate(vector, interrupt[i]);
+			set_intr_gate_all(vector, interrupt[i]);
 	}
 
 	/* setup after call gates are initialised (usually add in
Index: linux-2.5.64-numaq/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 io_apic.c
--- linux-2.5.64-numaq/arch/i386/kernel/io_apic.c	5 Mar 2003 05:08:03 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/kernel/io_apic.c	17 Mar 2003 03:58:36 -0000
@@ -35,6 +35,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
+#include <asm/topology.h>
 
 #include <mach_apic.h>
 
@@ -1003,27 +1004,45 @@ static inline int IO_APIC_irq_trigger(in
 }
 
 int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
+int __initdata vector_allocated[MAX_NUMNODES][FIRST_SYSTEM_VECTOR];
 
-static int __init assign_irq_vector(int irq)
+static int __init assign_irq_vector(int irq, int node)
 {
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	if (IO_APIC_VECTOR(irq) > 0)
-		return IO_APIC_VECTOR(irq);
+	static int current_vector[MAX_NUMNODES] = {[0 ... MAX_NUMNODES-1] = FIRST_DEVICE_VECTOR},
+		offset[MAX_NUMNODES];
+	int vector;
+
+	printk("requesting vector for node%d/irq%d\n", node, irq);
+	vector = IO_APIC_VECTOR(irq);
+	if (vector > 0) {
+		printk("returning previous allocation vector0x%x\n", vector);
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
+
+	vector = current_vector[node];
+	if (vector_allocated[node][vector])
+		goto next;
+
+	vector_allocated[node][vector] = 1;
+	IO_APIC_VECTOR(irq) = vector;
+	printk("returning new allocation node%d/irq%d -> vector0x%x\n",
+		node, irq, vector);
 
-	IO_APIC_VECTOR(irq) = current_vector;
-	return current_vector;
+	return vector;
 }
 
 static struct hw_interrupt_type ioapic_level_irq_type;
@@ -1032,14 +1051,13 @@ static struct hw_interrupt_type ioapic_e
 void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
-	int apic, pin, idx, irq, first_notcon = 1, vector;
-	unsigned long flags;
+	int apic, pin, idx, irq, first_notcon = 1, vector, i, bus, node;
+	unsigned long flags, cpu_mask;
 
 	printk(KERN_DEBUG "init IO_APIC IRQs\n");
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
 	for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
-
 		/*
 		 * add it to the IO-APIC irq-routing table:
 		 */
@@ -1049,11 +1067,12 @@ void __init setup_IO_APIC_irqs(void)
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
@@ -1063,12 +1082,21 @@ void __init setup_IO_APIC_irqs(void)
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
+			printk(KERN_DEBUG "skipping irq%d on node%d/bus%d/ioapic%d out of IRQs!\n",
+				irq, node, bus, apic);
+			continue;
+		}
+		
 		/*
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
@@ -1082,7 +1110,7 @@ void __init setup_IO_APIC_irqs(void)
 			continue;
 
 		if (IO_APIC_IRQ(irq)) {
-			vector = assign_irq_vector(irq);
+			vector = assign_irq_vector(irq, node);
 			entry.vector = vector;
 
 			if (IO_APIC_irq_trigger(irq))
@@ -1090,11 +1118,15 @@ void __init setup_IO_APIC_irqs(void)
 			else
 				irq_desc[irq].handler = &ioapic_edge_irq_type;
 
-			set_intr_gate(vector, interrupt[irq]);
-		
+			printk("irq_setup: node%d/bus%d/ioapic%d/vector0x%x - irq%d %p\n",
+				node, bus, apic, vector, irq, interrupt[irq]);
+			for_each_cpu_on_node(i, node, cpu_mask)
+				set_intr_gate(i, vector, interrupt[irq]);
+	
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
 		}
+		
 		spin_lock_irqsave(&ioapic_lock, flags);
 		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
 		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
@@ -1767,7 +1799,7 @@ static struct hw_interrupt_type ioapic_l
 
 static inline void init_IO_APIC_traps(void)
 {
-	int irq;
+	int irq, node;
 
 	/*
 	 * NOTE! The local APIC isn't very good at handling
@@ -1787,6 +1819,7 @@ static inline void init_IO_APIC_traps(vo
 			 * so default to an old-fashioned 8259
 			 * interrupt if we can..
 			 */
+			printk("irq%d not serviced by IOAPIC\n", irq);
 			if (irq < 16)
 				make_8259A_irq(irq);
 			else
@@ -1925,9 +1958,9 @@ static inline void check_timer(void)
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
-	vector = assign_irq_vector(0);
-	set_intr_gate(vector, interrupt[0]);
-
+	vector = assign_irq_vector(0, cpu_to_node(smp_processor_id()));
+	set_intr_gate_all(vector, interrupt[0]);
+	
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
 	 * mode for the 8259A whenever interrupts are routed
@@ -2181,11 +2214,14 @@ int __init io_apic_get_redir_entries (in
 int io_apic_set_pci_routing (int ioapic, int pin, int irq)
 {
 	struct IO_APIC_route_entry entry;
-	unsigned long flags;
+	unsigned long flags, cpu_mask;
+	int node, bus, i;
 
-	if (!IO_APIC_IRQ(irq)) {
-		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0/n", 
-			ioapic);
+#error FIXME you need to lookup bus irq mappings to determine destination node
+
+	if (!IO_APIC_IRQ(irq, node)) {
+		printk(KERN_ERR "node%d/ioapic%d invalid reference to IRQ0/n",
+			node, ioapic);
 		return -EINVAL;
 	}
 
@@ -2206,15 +2242,20 @@ int io_apic_set_pci_routing (int ioapic,
 
 	add_pin_to_irq(irq, ioapic, pin);
 
-	entry.vector = assign_irq_vector(irq);
+	entry.vector = assign_irq_vector(irq, node);
 
-	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
-		"IRQ %d)\n", ioapic, 
+	printk(KERN_DEBUG "NODE[%d] IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
+		"IRQ %d)\n", node, ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
 
 	irq_desc[irq].handler = &ioapic_level_irq_type;
 
-	set_intr_gate(entry.vector, interrupt[irq]);
+	/* do all the cpus on this node */
+	for_each_cpu_on_node(i, node, cpu_mask) {
+		printk("irq_route: node%d/bus%d/ioapic%d/cpu%d/vector0x%x - irq%d %p\n",
+			node, bus, ioapic, i, vector, irq, interrupt[irq]);
+		set_intr_gate(i, vector, interrupt[irq]);
+	}
 
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
Index: linux-2.5.64-numaq/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 smpboot.c
--- linux-2.5.64-numaq/arch/i386/kernel/smpboot.c	5 Mar 2003 05:08:04 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/kernel/smpboot.c	7 Mar 2003 07:23:13 -0000
@@ -1163,22 +1163,22 @@ void __init smp_intr_init()
 	 * IRQ0 must be given a fixed assignment and initialized,
 	 * because it's used before the IO-APIC is set up.
 	 */
-	set_intr_gate(FIRST_DEVICE_VECTOR, interrupt[0]);
+	set_intr_gate_all(FIRST_DEVICE_VECTOR, interrupt[0]);
 
 	/*
 	 * The reschedule interrupt is a CPU-to-CPU reschedule-helper
 	 * IPI, driven by wakeup.
 	 */
-	set_intr_gate(RESCHEDULE_VECTOR, reschedule_interrupt);
+	set_intr_gate_all(RESCHEDULE_VECTOR, reschedule_interrupt);
 
 	/* IPI for invalidation */
-	set_intr_gate(INVALIDATE_TLB_VECTOR, invalidate_interrupt);
+	set_intr_gate_all(INVALIDATE_TLB_VECTOR, invalidate_interrupt);
 
 	/* IPI for generic function call */
-	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
+	set_intr_gate_all(CALL_FUNCTION_VECTOR, call_function_interrupt);
 
 	/* thermal monitor LVT interrupt */
 #ifdef CONFIG_X86_MCE_P4THERMAL
-	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
+	set_intr_gate_all(THERMAL_APIC_VECTOR, thermal_interrupt);
 #endif
 }
Index: linux-2.5.64-numaq/arch/i386/kernel/traps.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 traps.c
--- linux-2.5.64-numaq/arch/i386/kernel/traps.c	5 Mar 2003 05:08:03 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/kernel/traps.c	12 Mar 2003 06:21:29 -0000
@@ -63,7 +63,9 @@ struct desc_struct default_ldt[] = { { 0
  * F0 0F bug workaround.. We have a special link segment
  * for this.
  */
-struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
+
+struct desc_struct cpu_idt_table[NR_CPUS][IDT_ENTRIES] __attribute__((__section__(".data.idt"))) =
+								{[0 ... NR_CPUS-1] = { {0, 0}, }};
 
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -761,14 +763,17 @@ asmlinkage void math_emulate(long arg)
 #ifdef CONFIG_X86_F00F_BUG
 void __init trap_init_f00f_bug(void)
 {
-	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
+#warning This needs fixing which can be done by switching to per node IDTs
+	int cpu = smp_processor_id();
+
+	__set_fixmap(FIX_F00F_IDT, __pa(&cpu_idt_table[cpu]), PAGE_KERNEL_RO);
 
 	/*
 	 * Update the IDT descriptor and reload the IDT so that
 	 * it uses the read-only mapped virtual address.
 	 */
-	idt_descr.address = fix_to_virt(FIX_F00F_IDT);
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	cpu_idt_descr[cpu].address = fix_to_virt(FIX_F00F_IDT);
+	__asm__ __volatile__("lidt %0": "=m" (cpu_idt_descr[cpu]));
 }
 #endif
 
@@ -787,24 +792,32 @@ do { \
 
 
 /*
- * This needs to use 'idt_table' rather than 'idt', and
+ * This needs to use 'cpu_idt_table' rather than 'idt', and
  * thus use the _nonmapped_ version of the IDT, as the
  * Pentium F0 0F bugfix can have resulted in the mapped
  * IDT being write-protected.
  */
-void set_intr_gate(unsigned int n, void *addr)
+
+void set_intr_gate_all(unsigned int n, void *addr)
+{
+	int cpu;
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+ 		set_intr_gate(cpu, n, addr);
+}
+
+void set_intr_gate(unsigned int cpu, unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+	_set_gate(&cpu_idt_table[cpu][n],14,0,addr,__KERNEL_CS);
 }
 
-static void __init set_trap_gate(unsigned int n, void *addr)
+static void __init set_trap_gate(unsigned int cpu, unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
+	_set_gate(&cpu_idt_table[cpu][n],15,0,addr,__KERNEL_CS);
 }
 
-static void __init set_system_gate(unsigned int n, void *addr)
+static void __init set_system_gate(unsigned int cpu, unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
+	_set_gate(&cpu_idt_table[cpu][n],15,3,addr,__KERNEL_CS);
 }
 
 static void __init set_call_gate(void *a, void *addr)
@@ -812,9 +825,9 @@ static void __init set_call_gate(void *a
 	_set_gate(a,12,3,addr,__KERNEL_CS);
 }
 
-static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
+static void __init set_task_gate(unsigned int cpu, unsigned int n, unsigned int gdt_entry)
 {
-	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
+	_set_gate(&cpu_idt_table[cpu][n],5,0,0,(gdt_entry<<3));
 }
 
 
@@ -837,30 +850,30 @@ void __init trap_init(void)
 	init_apic_mappings();
 #endif
 
-	set_trap_gate(0,&divide_error);
-	set_intr_gate(1,&debug);
-	set_intr_gate(2,&nmi);
-	set_system_gate(3,&int3);	/* int3-5 can be called from all */
-	set_system_gate(4,&overflow);
-	set_system_gate(5,&bounds);
-	set_trap_gate(6,&invalid_op);
-	set_trap_gate(7,&device_not_available);
-	set_task_gate(8,GDT_ENTRY_DOUBLEFAULT_TSS);
-	set_trap_gate(9,&coprocessor_segment_overrun);
-	set_trap_gate(10,&invalid_TSS);
-	set_trap_gate(11,&segment_not_present);
-	set_trap_gate(12,&stack_segment);
-	set_trap_gate(13,&general_protection);
-	set_intr_gate(14,&page_fault);
-	set_trap_gate(15,&spurious_interrupt_bug);
-	set_trap_gate(16,&coprocessor_error);
-	set_trap_gate(17,&alignment_check);
+	set_trap_gate(0,0,&divide_error);
+	set_intr_gate(0,1,&debug);
+	set_intr_gate(0,2,&nmi);
+	set_system_gate(0,3,&int3);	/* int3-5 can be called from all */
+	set_system_gate(0,4,&overflow);
+	set_system_gate(0,5,&bounds);
+	set_trap_gate(0,6,&invalid_op);
+	set_trap_gate(0,7,&device_not_available);
+	set_task_gate(0,8,GDT_ENTRY_DOUBLEFAULT_TSS);
+	set_trap_gate(0,9,&coprocessor_segment_overrun);
+	set_trap_gate(0,10,&invalid_TSS);
+	set_trap_gate(0,11,&segment_not_present);
+	set_trap_gate(0,12,&stack_segment);
+	set_trap_gate(0,13,&general_protection);
+	set_intr_gate(0,14,&page_fault);
+	set_trap_gate(0,15,&spurious_interrupt_bug);
+	set_trap_gate(0,16,&coprocessor_error);
+	set_trap_gate(0,17,&alignment_check);
 #ifdef CONFIG_X86_MCE
-	set_trap_gate(18,&machine_check);
+	set_trap_gate(0,18,&machine_check);
 #endif
-	set_trap_gate(19,&simd_coprocessor_error);
+	set_trap_gate(0,19,&simd_coprocessor_error);
 
-	set_system_gate(SYSCALL_VECTOR,&system_call);
+	set_system_gate(0,SYSCALL_VECTOR,&system_call);
 
 	/*
 	 * default LDT is a single-entry callgate to lcall7 for iBCS
Index: linux-2.5.64-numaq/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 common.c
--- linux-2.5.64-numaq/arch/i386/kernel/cpu/common.c	5 Mar 2003 05:08:04 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/kernel/cpu/common.c	7 Mar 2003 07:37:40 -0000
@@ -454,13 +454,18 @@ void __init cpu_init (void)
 	}
 
 	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
+	 * Initialize the per-CPU GDT and IDTs with the boot equivalents,
+	 * and set up the descriptors:
 	 */
 	if (cpu) {
 		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
 		cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
 		cpu_gdt_descr[cpu].address = (unsigned long)cpu_gdt_table[cpu];
+
+		memcpy(cpu_idt_table[cpu], cpu_idt_table[0], IDT_SIZE);
+		cpu_idt_descr[cpu].size = IDT_SIZE - 1;
+		cpu_idt_descr[cpu].address = (unsigned long)cpu_idt_table[cpu];
+		printk("CPU%d IDT at 0x%08lx\n", cpu, cpu_idt_descr[cpu].address);
 	}
 	/*
 	 * Set up the per-thread TLS descriptor cache:
@@ -468,7 +473,7 @@ void __init cpu_init (void)
 	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
 
 	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	__asm__ __volatile__("lidt %0": "=m" (cpu_idt_descr[cpu]));
 
 	/*
 	 * Delete NT
Index: linux-2.5.64-numaq/arch/i386/mm/fault.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 fault.c
--- linux-2.5.64-numaq/arch/i386/mm/fault.c	5 Mar 2003 05:08:04 -0000	1.1.1.1
+++ linux-2.5.64-numaq/arch/i386/mm/fault.c	7 Mar 2003 07:23:13 -0000
@@ -299,7 +299,7 @@ bad_area:
 	if (boot_cpu_data.f00f_bug) {
 		unsigned long nr;
 		
-		nr = (address - idt_descr.address) >> 3;
+		nr = (address - cpu_idt_descr[smp_processor_id()].address) >> 3;
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
Index: linux-2.5.64-numaq/include/asm-i386/desc.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/include/asm-i386/desc.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 desc.h
--- linux-2.5.64-numaq/include/asm-i386/desc.h	5 Mar 2003 05:07:59 -0000	1.1.1.1
+++ linux-2.5.64-numaq/include/asm-i386/desc.h	7 Mar 2003 07:23:13 -0000
@@ -12,14 +12,15 @@
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
+extern struct desc_struct cpu_idt_table[NR_CPUS][IDT_ENTRIES];
 
-struct Xgt_desc_struct {
+struct Xdt_desc_struct {
 	unsigned short size;
 	unsigned long address __attribute__((packed));
 	unsigned short pad;
 } __attribute__ ((packed));
 
-extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
+extern struct Xdt_desc_struct cpu_idt_descr[NR_CPUS], cpu_gdt_descr[NR_CPUS]; 
 
 #define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (GDT_ENTRY_LDT*8))
@@ -29,7 +30,8 @@ extern struct Xgt_desc_struct idt_descr,
  * something other than this.
  */
 extern struct desc_struct default_ldt[];
-extern void set_intr_gate(unsigned int irq, void * addr);
+extern void set_intr_gate(unsigned int cpu, unsigned int vector, void * addr);
+extern void set_intr_gate_all(unsigned int n, void *addr);
 
 #define _set_tssldt_desc(n,addr,limit,type) \
 __asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
Index: linux-2.5.64-numaq/include/asm-i386/segment.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/include/asm-i386/segment.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 segment.h
--- linux-2.5.64-numaq/include/asm-i386/segment.h	5 Mar 2003 05:07:59 -0000	1.1.1.1
+++ linux-2.5.64-numaq/include/asm-i386/segment.h	7 Mar 2003 07:23:13 -0000
@@ -94,5 +94,5 @@
  * of tasks we can have..
  */
 #define IDT_ENTRIES 256
-
+#define IDT_SIZE (IDT_ENTRIES * 8)
 #endif
Index: linux-2.5.64-numaq/include/asm-i386/topology.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/include/asm-i386/topology.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 topology.h
--- linux-2.5.64-numaq/include/asm-i386/topology.h	5 Mar 2003 05:07:59 -0000	1.1.1.1
+++ linux-2.5.64-numaq/include/asm-i386/topology.h	7 Mar 2003 17:13:54 -0000
@@ -82,4 +82,9 @@ static inline unsigned long pcibus_to_cp
 
 #endif /* CONFIG_NUMA */
 
+#define for_each_cpu_on_node(cpu, node, mask) \
+        for(mask = node_to_cpumask(node); \
+            cpu = __ffs(mask), (mask != 0); \
+            mask &= ~(1UL<<cpu))
+
 #endif /* _ASM_I386_TOPOLOGY_H */

