Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268530AbTCAI2T>; Sat, 1 Mar 2003 03:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268533AbTCAI2T>; Sat, 1 Mar 2003 03:28:19 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:859
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268530AbTCAI2K>; Sat, 1 Mar 2003 03:28:10 -0500
Date: Sat, 1 Mar 2003 03:36:41 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][RFC][1/2] per-CPU IDTs
Message-ID: <Pine.LNX.4.50.0303010335290.2365-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.62-numaq/arch/i386/kernel/apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apic.c
--- linux-2.5.62-numaq/arch/i386/kernel/apic.c	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/kernel/apic.c	24 Feb 2003 02:40:47 -0000
@@ -40,11 +40,11 @@
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
Index: linux-2.5.62-numaq/arch/i386/kernel/head.S
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 head.S
--- linux-2.5.62-numaq/arch/i386/kernel/head.S	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/kernel/head.S	24 Feb 2003 04:20:38 -0000
@@ -233,7 +233,7 @@
 	call check_x87
 	incb ready
 	lgdt cpu_gdt_descr
-	lidt idt_descr
+	lidt cpu_idt_descr		# we switch to the percpu IDTs later
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
 	movl %eax,%ss			# after changing gdt.
@@ -298,7 +298,7 @@
 	movw %dx,%ax		/* selector = 0x0010 = cs */
 	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
 
-	lea idt_table,%edi
+	lea cpu_idt_table,%edi
 	mov $256,%ecx
 rp_sidt:
 	movl %eax,(%edi)
@@ -343,14 +343,16 @@
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
Index: linux-2.5.62-numaq/arch/i386/kernel/i8259.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/i8259.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 i8259.c
--- linux-2.5.62-numaq/arch/i386/kernel/i8259.c	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/kernel/i8259.c	24 Feb 2003 02:50:45 -0000
@@ -421,7 +421,7 @@
 	for (i = 0; i < NR_IRQS; i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
 		if (vector != SYSCALL_VECTOR) 
-			set_intr_gate(vector, interrupt[i]);
+			set_intr_gate_all(vector, interrupt[i]);
 	}
 
 	/* setup after call gates are initialised (usually add in
Index: linux-2.5.62-numaq/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 io_apic.c
--- linux-2.5.62-numaq/arch/i386/kernel/io_apic.c	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/kernel/io_apic.c	24 Feb 2003 03:27:05 -0000
@@ -1020,7 +1020,7 @@
 	}
 
 	if (current_vector == FIRST_SYSTEM_VECTOR)
-		panic("ran out of interrupt sources!");
+		panic("ran out of interrupt vectors");
 
 	IO_APIC_VECTOR(irq) = current_vector;
 	return current_vector;
@@ -1090,8 +1090,8 @@
 			else
 				irq_desc[irq].handler = &ioapic_edge_irq_type;
 
-			set_intr_gate(vector, interrupt[irq]);
-		
+			set_intr_gate_all(vector, interrupt[irq]);
+			
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
 		}
@@ -1940,8 +1940,8 @@
 	 */
 	disable_8259A_irq(0);
 	vector = assign_irq_vector(0);
-	set_intr_gate(vector, interrupt[0]);
-
+	set_intr_gate_all(vector, interrupt[0]);
+	
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
 	 * mode for the 8259A whenever interrupts are routed
@@ -2228,7 +2228,7 @@
 
 	irq_desc[irq].handler = &ioapic_level_irq_type;
 
-	set_intr_gate(entry.vector, interrupt[irq]);
+	set_intr_gate_all(entry.vector, interrupt[irq]);
 
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
Index: linux-2.5.62-numaq/arch/i386/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 irq.c
--- linux-2.5.62-numaq/arch/i386/kernel/irq.c	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/kernel/irq.c	24 Feb 2003 01:47:45 -0000
@@ -65,7 +65,7 @@
 /*
  * Controller mappings for all interrupt sources:
  */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
+irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =  
 	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
 
 static void register_irq_proc (unsigned int irq);
Index: linux-2.5.62-numaq/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smpboot.c
--- linux-2.5.62-numaq/arch/i386/kernel/smpboot.c	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/kernel/smpboot.c	24 Feb 2003 04:38:06 -0000
@@ -1163,22 +1165,22 @@
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
Index: linux-2.5.62-numaq/arch/i386/kernel/traps.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 traps.c
--- linux-2.5.62-numaq/arch/i386/kernel/traps.c	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/kernel/traps.c	24 Feb 2003 05:57:37 -0000
@@ -63,7 +63,9 @@
  * F0 0F bug workaround.. We have a special link segment
  * for this.
  */
-struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
+
+struct desc_struct cpu_idt_table[NR_CPUS][256] __attribute__((__section__(".data.idt"))) =
+	{[0 ... NR_CPUS-1] = { {0, 0}, }};
 
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
@@ -764,14 +766,16 @@
 #ifdef CONFIG_X86_F00F_BUG
 void __init trap_init_f00f_bug(void)
 {
-	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
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
 
@@ -790,24 +794,34 @@
 
 
 /*
- * This needs to use 'idt_table' rather than 'idt', and
+ * This needs to use 'cpu_idt_table' rather than 'idt', and
  * thus use the _nonmapped_ version of the IDT, as the
  * Pentium F0 0F bugfix can have resulted in the mapped
  * IDT being write-protected.
  */
-void set_intr_gate(unsigned int n, void *addr)
+void set_intr_gate(unsigned int cpu, unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,14,0,addr);
+	_set_gate(&cpu_idt_table[cpu][n],14,0,addr);
 }
 
-static void __init set_trap_gate(unsigned int n, void *addr)
+void set_intr_gate_all(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,0,addr);
+	int cpu;
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		set_intr_gate(cpu, n, addr);
 }
 
-static void __init set_system_gate(unsigned int n, void *addr)
+/* during boot we will copy the initial IDT from the boot processor,
+ * so only populate the BSP from here
+ */
+static void __init set_trap_gate(unsigned int cpu, unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,3,addr);
+	_set_gate(&cpu_idt_table[cpu][n],15,0,addr);
+}
+
+static void __init set_system_gate(unsigned int cpu, unsigned int n, void *addr)
+{
+	_set_gate(&cpu_idt_table[cpu][n],15,3,addr);
 }
 
 static void __init set_call_gate(void *a, void *addr)
@@ -834,32 +848,30 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 	init_apic_mappings();
 #endif
-
-	set_trap_gate(0,&divide_error);
-	set_intr_gate(1,&debug);
-	set_intr_gate(2,&nmi);
-	set_system_gate(3,&int3);	/* int3-5 can be called from all */
-	set_system_gate(4,&overflow);
-	set_system_gate(5,&bounds);
-	set_trap_gate(6,&invalid_op);
-	set_trap_gate(7,&device_not_available);
-	set_trap_gate(8,&double_fault);
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
+	set_trap_gate(0,8,&double_fault);
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
-
-	set_system_gate(SYSCALL_VECTOR,&system_call);
-
+	set_trap_gate(0,19,&simd_coprocessor_error);
+	set_system_gate(0,SYSCALL_VECTOR,&system_call);
+	
 	/*
 	 * default LDT is a single-entry callgate to lcall7 for iBCS
 	 * and a callgate to lcall27 for Solaris/x86 binaries
Index: linux-2.5.62-numaq/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 common.c
--- linux-2.5.62-numaq/arch/i386/kernel/cpu/common.c	18 Feb 2003 00:16:06 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/kernel/cpu/common.c	24 Feb 2003 05:58:50 -0000
@@ -454,13 +454,17 @@
 	}
 
 	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
+	 * Initialize the per-CPU GDT and IDT with the boot equivalents,
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
 	}
 	/*
 	 * Set up the per-thread TLS descriptor cache:
@@ -468,7 +472,7 @@
 	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_ENTRIES * 8);
 
 	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	__asm__ __volatile__("lidt %0": "=m" (cpu_idt_descr[cpu]));
 
 	/*
 	 * Delete NT
Index: linux-2.5.62-numaq/arch/i386/mm/fault.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fault.c
--- linux-2.5.62-numaq/arch/i386/mm/fault.c	18 Feb 2003 00:16:07 -0000	1.1.1.1
+++ linux-2.5.62-numaq/arch/i386/mm/fault.c	24 Feb 2003 04:01:36 -0000
@@ -299,7 +299,7 @@
 	if (boot_cpu_data.f00f_bug) {
 		unsigned long nr;
 		
-		nr = (address - idt_descr.address) >> 3;
+		nr = (address - cpu_idt_descr[smp_processor_id()].address) >> 3;
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
Index: linux-2.5.62-numaq/include/asm-i386/desc.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/include/asm-i386/desc.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 desc.h
--- linux-2.5.62-numaq/include/asm-i386/desc.h	18 Feb 2003 00:15:59 -0000	1.1.1.1
+++ linux-2.5.62-numaq/include/asm-i386/desc.h	24 Feb 2003 04:30:40 -0000
@@ -12,6 +12,7 @@
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
+extern struct desc_struct cpu_idt_table[NR_CPUS][256];
 
 struct Xgt_desc_struct {
 	unsigned short size;
@@ -19,7 +20,8 @@
 	unsigned short pad;
 } __attribute__ ((packed));
 
-extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
+#define IDT_SIZE	(256*8)
+extern struct Xgt_desc_struct cpu_idt_descr[NR_CPUS], cpu_gdt_descr[NR_CPUS]; 
 
 #define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (GDT_ENTRY_LDT*8))
@@ -29,7 +31,8 @@
  * something other than this.
  */
 extern struct desc_struct default_ldt[];
-extern void set_intr_gate(unsigned int irq, void * addr);
+extern void set_intr_gate(unsigned int cpu, unsigned int irq, void * addr);
+extern void set_intr_gate_all(unsigned int n, void *addr);
 
 #define _set_tssldt_desc(n,addr,limit,type) \
 __asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
