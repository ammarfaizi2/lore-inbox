Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWBVLFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWBVLFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWBVLFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:05:32 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:27844 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S932075AbWBVLFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:05:30 -0500
From: Jan Beulich <jbeulich@novell.com>
To: akpm@osdl.org
Subject: [PATCH] i386 double fault enhancements
Date: Wed, 22 Feb 2006 11:59:08 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221159.08969.jbeulich@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the double fault handler use CPU-specific stacks. Add some
abstraction to simplify future change of other exception handlers to go
through task gates. Change the pointer validity checks in the double
fault handler to account for the fact that both GDT and TSS aren't in
static kernel space anymore. Add a new notification of the event
through the die notifier chain, also providing some environmental
adjustments so that various infrastructural things work independent of
the fact that the fault and the callbacks are running on other then the
normal kernel stack.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>
Acked-By: Andi Kleen <ak@suse.de>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/cpu/common.c 2.6.16-rc4-i386-doublefault/arch/i386/kernel/cpu/common.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/cpu/common.c	2006-02-20 09:12:32.000000000 +0100
+++ 2.6.16-rc4-i386-doublefault/arch/i386/kernel/cpu/common.c	2006-01-25 11:15:51.000000000 +0100
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/bootmem.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
@@ -569,6 +570,7 @@ void __init early_cpu_init(void)
 void __devinit cpu_init(void)
 {
 	int cpu = smp_processor_id();
+	unsigned i;
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
@@ -621,9 +623,54 @@ void __devinit cpu_init(void)
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
-#ifdef CONFIG_DOUBLEFAULT
-	/* Set up doublefault TSS pointer in the GDT */
-	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
+#ifdef N_EXCEPTION_TSS
+# if EXCEPTION_STACK_ORDER > THREAD_ORDER
+#  error Assertion failed: EXCEPTION_STACK_ORDER <= THREAD_ORDER
+# endif
+	for (i = 0; i < N_EXCEPTION_TSS; ++i) {
+		unsigned long stack;
+
+		/* Set up exception handling TSS */
+		exception_tss[cpu][i].ebx = (unsigned long)&exception_tss[cpu][i];
+
+		/* Set up exception handling stacks */
+# ifdef CONFIG_SMP
+		if (cpu) {
+			stack = __get_free_pages(GFP_ATOMIC, THREAD_ORDER);
+			if (!stack)
+				panic("Cannot allocate exception stack %u %d\n",
+				      i,
+				      cpu);
+		}
+		else
+# endif
+			stack = (unsigned long)__alloc_bootmem(EXCEPTION_STKSZ,
+			                                       THREAD_SIZE,
+			                                       __pa(MAX_DMA_ADDRESS));
+		stack += EXCEPTION_STKSZ;
+		exception_tss[cpu][i].esp = exception_tss[cpu][i].esp0 = stack;
+# ifdef CONFIG_SMP
+		if (cpu) {
+			unsigned j;
+
+			for (j = EXCEPTION_STACK_ORDER; j < THREAD_ORDER; ++j) {
+				/* set_page_refs sets the page count only for the first
+				   page, but since we split the larger-order page here,
+				   we need to adjust the page count before freeing the
+				   pieces. */
+				struct page * page = virt_to_page((void *)stack);
+
+				BUG_ON(page_count(page));
+				set_page_count(page, 1);
+				free_pages(stack, j);
+				stack += (PAGE_SIZE << j);
+			}
+		}
+# endif
+
+		/* Set up exception handling TSS pointer in the GDT */
+		__set_tss_desc(cpu, GDT_ENTRY_EXCEPTION_TSS + i, &exception_tss[cpu][i]);
+	}
 #endif
 
 	/* Clear %fs and %gs. */
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/doublefault.c 2.6.16-rc4-i386-doublefault/arch/i386/kernel/doublefault.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/doublefault.c	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc4-i386-doublefault/arch/i386/kernel/doublefault.c	2006-01-25 11:36:53.000000000 +0100
@@ -8,58 +8,81 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/desc.h>
+#include <asm/kdebug.h>
 
-#define DOUBLEFAULT_STACKSIZE (1024)
-static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
-#define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
+extern unsigned long max_low_pfn;
+#define ptr_ok(x, l) ((x) >= PAGE_OFFSET \
+                      && (x) + (l) <= PAGE_OFFSET + max_low_pfn * PAGE_SIZE - 1)
 
-#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + 0x1000000)
+#define THREAD_INFO_FROM(x) ((struct thread_info *)((x) & ~(THREAD_SIZE - 1)))
 
-static void doublefault_fn(void)
+register const struct tss_struct *self __asm__("ebx");
+
+void doublefault_fn(void)
 {
-	struct Xgt_desc_struct gdt_desc = {0, 0};
+	struct Xgt_desc_struct gdt_desc;
 	unsigned long gdt, tss;
 
 	store_gdt(&gdt_desc);
 	gdt = gdt_desc.address;
 
-	printk("double fault, gdt at %08lx [%d bytes]\n", gdt, gdt_desc.size);
+	printk("double fault, gdt at %08lx [%d bytes]\n", gdt, gdt_desc.size + 1);
 
-	if (ptr_ok(gdt)) {
+	if (ptr_ok(gdt, gdt_desc.size)) {
 		gdt += GDT_ENTRY_TSS << 3;
 		tss = *(u16 *)(gdt+2);
 		tss += *(u8 *)(gdt+4) << 16;
 		tss += *(u8 *)(gdt+7) << 24;
 		printk("double fault, tss at %08lx\n", tss);
 
-		if (ptr_ok(tss)) {
-			struct tss_struct *t = (struct tss_struct *)tss;
+		if (ptr_ok(tss, *(u16 *)gdt)) {
+			const struct tss_struct *t = (struct tss_struct *)tss;
+			struct {
+				struct pt_regs common;
+				struct {
+					unsigned long es;
+					unsigned long ds;
+					unsigned long fs;
+					unsigned long gs;
+				} vm86;
+			} regs;
+
+			/* for current/current_thread_info to work... */
+			*THREAD_INFO_FROM(self->esp) = *THREAD_INFO_FROM(t->esp0 - 1);
 
 			printk("eip = %08lx, esp = %08lx\n", t->eip, t->esp);
 
 			printk("eax = %08lx, ebx = %08lx, ecx = %08lx, edx = %08lx\n",
 				t->eax, t->ebx, t->ecx, t->edx);
-			printk("esi = %08lx, edi = %08lx\n",
-				t->esi, t->edi);
+			printk("esi = %08lx, edi = %08lx, ebp = %08lx\n",
+				t->esi, t->edi, t->ebp);
+
+			regs.common.ebx = t->ebx;
+			regs.common.ecx = t->ecx;
+			regs.common.edx = t->edx;
+			regs.common.esi = t->esi;
+			regs.common.edi = t->edi;
+			regs.common.ebp = t->ebp;
+			regs.common.eax = t->eax;
+			regs.common.xds = t->ds;
+			regs.common.xes = t->es;
+			regs.common.orig_eax = -1;
+			regs.common.eip = t->eip;
+			regs.common.xcs = t->cs;
+			regs.common.eflags = t->eflags;
+			regs.common.esp = t->esp;
+			regs.common.xss = t->ss;
+			if (t->eflags & X86_EFLAGS_VM) {
+				regs.common.xds = 0;
+				regs.common.xes = 0;
+				regs.vm86.es = t->es;
+				regs.vm86.ds = t->ds;
+				regs.vm86.fs = t->fs;
+				regs.vm86.gs = t->gs;
+			}
+			notify_die(DIE_DOUBLE_FAULT, "double fault", &regs.common, 0, 8, SIGKILL);
 		}
 	}
 
 	for (;;) /* nothing */;
 }
-
-struct tss_struct doublefault_tss __cacheline_aligned = {
-	.esp0		= STACK_START,
-	.ss0		= __KERNEL_DS,
-	.ldt		= 0,
-	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
-
-	.eip		= (unsigned long) doublefault_fn,
-	.eflags		= X86_EFLAGS_SF | 0x2,	/* 0x2 bit is always set */
-	.esp		= STACK_START,
-	.es		= __USER_DS,
-	.cs		= __KERNEL_CS,
-	.ss		= __KERNEL_DS,
-	.ds		= __USER_DS,
-
-	.__cr3		= __pa(swapper_pg_dir)
-};
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/traps.c 2.6.16-rc4-i386-doublefault/arch/i386/kernel/traps.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/traps.c	2006-02-20 09:12:32.000000000 +0100
+++ 2.6.16-rc4-i386-doublefault/arch/i386/kernel/traps.c	2006-01-30 09:58:51.000000000 +0100
@@ -61,6 +61,26 @@ asmlinkage int system_call(void);
 struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
 		{ 0, 0 }, { 0, 0 } };
 
+void doublefault_fn(void);
+
+#ifdef N_EXCEPTION_TSS
+struct tss_struct exception_tss[NR_CPUS][N_EXCEPTION_TSS] __cacheline_aligned = {
+	[0 ... NR_CPUS-1] = {
+		[0 ... N_EXCEPTION_TSS-1] = {
+			.cs       = __KERNEL_CS,
+			.ss       = __KERNEL_DS,
+			.ss0      = __KERNEL_DS,
+			.__cr3    = __pa(swapper_pg_dir),
+			.io_bitmap_base = INVALID_IO_BITMAP_OFFSET,
+			.ds       = __USER_DS,
+			.es       = __USER_DS,
+			.eflags	  = X86_EFLAGS_SF | 0x2, /* 0x2 bit is always set */
+		},
+		[DOUBLEFAULT_TSS].eip = (unsigned long)doublefault_fn
+	}
+};
+#endif
+
 /* Do we ignore FPU interrupts ? */
 char ignore_fpu_irq = 0;
 
@@ -1086,10 +1106,12 @@ static void __init set_system_gate(unsig
 	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
 }
 
+#ifdef N_EXCEPTION_TSS
 static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
 {
 	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
 }
+#endif
 
 
 void __init trap_init(void)
@@ -1114,7 +1136,9 @@ void __init trap_init(void)
 	set_trap_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
 	set_trap_gate(7,&device_not_available);
-	set_task_gate(8,GDT_ENTRY_DOUBLEFAULT_TSS);
+#ifdef DOUBLEFAULT_TSS
+	set_task_gate(8,GDT_ENTRY_EXCEPTION_TSS + DOUBLEFAULT_TSS);
+#endif
 	set_trap_gate(9,&coprocessor_segment_overrun);
 	set_trap_gate(10,&invalid_TSS);
 	set_trap_gate(11,&segment_not_present);
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/kdebug.h 2.6.16-rc4-i386-doublefault/include/asm-i386/kdebug.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/kdebug.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc4-i386-doublefault/include/asm-i386/kdebug.h	2006-01-27 16:29:53.000000000 +0100
@@ -39,6 +39,7 @@ enum die_val {
 	DIE_CALL,
 	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
+	DIE_DOUBLE_FAULT
 };
 
 static inline int notify_die(enum die_val val, const char *str,
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/processor.h 2.6.16-rc4-i386-doublefault/include/asm-i386/processor.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/processor.h	2006-02-20 09:13:29.000000000 +0100
+++ 2.6.16-rc4-i386-doublefault/include/asm-i386/processor.h	2006-01-25 17:08:53.000000000 +0100
@@ -90,7 +90,9 @@ struct cpuinfo_x86 {
 
 extern struct cpuinfo_x86 boot_cpu_data;
 extern struct cpuinfo_x86 new_cpu_data;
-extern struct tss_struct doublefault_tss;
+#ifdef N_EXCEPTION_TSS
+extern struct tss_struct exception_tss[NR_CPUS][N_EXCEPTION_TSS];
+#endif
 DECLARE_PER_CPU(struct tss_struct, init_tss);
 
 #ifdef CONFIG_SMP
@@ -486,6 +488,9 @@ struct thread_struct {
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0 },		\
 }
 
+#define EXCEPTION_STACK_ORDER 0
+#define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
+
 static inline void load_esp0(struct tss_struct *tss, struct thread_struct *thread)
 {
 	tss->esp0 = thread->esp0;
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/segment.h 2.6.16-rc4-i386-doublefault/include/asm-i386/segment.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/segment.h	2006-02-20 09:13:29.000000000 +0100
+++ 2.6.16-rc4-i386-doublefault/include/asm-i386/segment.h	2006-01-30 09:57:02.000000000 +0100
@@ -43,7 +43,8 @@
  *  28 - unused
  *  29 - unused
  *  30 - unused
- *  31 - TSS for double fault handler
+ *  31 - TSS for first exception handler (double fault)
+ *  32+  TSSes for further exception handlers
  */
 #define GDT_ENTRY_TLS_ENTRIES	3
 #define GDT_ENTRY_TLS_MIN	6
@@ -74,12 +75,22 @@
 #define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
 #define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
 
-#define GDT_ENTRY_DOUBLEFAULT_TSS	31
+#define GDT_ENTRY_EXCEPTION_TSS	31
+#ifdef CONFIG_DOUBLEFAULT
+# define DOUBLEFAULT_TSS 0
+# define N_EXCEPTION_TSS 1
+#else
+# undef GDT_ENTRY_EXCEPTION_TSS
+#endif
 
 /*
- * The GDT has 32 entries
+ * The GDT has 31+ entries
  */
-#define GDT_ENTRIES 32
+#ifdef N_EXCEPTION_TSS
+# define GDT_ENTRIES (31 + N_EXCEPTION_TSS)
+#else
+# define GDT_ENTRIES 31
+#endif
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/thread_info.h 2.6.16-rc4-i386-doublefault/include/asm-i386/thread_info.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/thread_info.h	2006-02-20 09:13:29.000000000 +0100
+++ 2.6.16-rc4-i386-doublefault/include/asm-i386/thread_info.h	2006-01-25 10:41:49.000000000 +0100
@@ -54,10 +54,11 @@ struct thread_info {
 
 #define PREEMPT_ACTIVE		0x10000000
 #ifdef CONFIG_4KSTACKS
-#define THREAD_SIZE            (4096)
+#define THREAD_ORDER 0
 #else
-#define THREAD_SIZE		(8192)
+#define THREAD_ORDER 1
 #endif
+#define THREAD_SIZE (4096 << THREAD_ORDER)
 
 #define STACK_WARN             (THREAD_SIZE/8)
 /*

