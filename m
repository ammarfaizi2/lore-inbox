Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTBSXaT>; Wed, 19 Feb 2003 18:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTBSXaT>; Wed, 19 Feb 2003 18:30:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27142 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262500AbTBSXaI>; Wed, 19 Feb 2003 18:30:08 -0500
Date: Wed, 19 Feb 2003 15:35:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
In-Reply-To: <20030218230150.GA15657@f00f.org>
Message-ID: <Pine.LNX.4.44.0302191527400.9786-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I wrote up this doublefault task-gate handler which has gotten some
very very minimal testing, and which is probably totally buggered on SMP
machines etc, but which has caught at least one double-fault on one of my
test-machines (which I forced to double-fault by making %esp contain an
invalid value in kernel mode).

If the reboot is due to a triple-fault, this may give out some debugging 
information and then lock up hard instead of rebooting.

Change the "ptr_ok()" to match your hardware (or just make it do

	#define ptr_ok(x) (1)

since I only really wrote it that way due to debugging the damn thing).

Anyway, this patch should apply pretty directly on top of 2.5.62, and if 
you run UP it might even work. So apply this, and try to crash the 
machine, and see if it spits out any interesting information.

NOTE NOTE NOTE! When the double-fault happens, the machine as-is will be 
COMPLETELY DEAD! Don't try to access "current" or anything like that, 
since the stack is scrogged. That's why it gets the state by actually 
reading the current value of gdt, and following it to the TSS structure.

If this approach works, we can try to make the doublefault handling less 
prone to lock up the machine (ie kill the offending task and continuing),  
but in the meantime at least it should avoid having things like stack 
errors result in triple faults and reboots.

Improvements welcome (and boy was this a bitch to debug).

		Linus

-----
===== arch/i386/kernel/Makefile 1.35 vs edited =====
--- 1.35/arch/i386/kernel/Makefile	Tue Feb 18 18:59:01 2003
+++ edited/arch/i386/kernel/Makefile	Wed Feb 19 11:56:49 2003
@@ -6,7 +6,8 @@
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o
+		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
+		doublefault.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
===== arch/i386/kernel/head.S 1.24 vs edited =====
--- 1.24/arch/i386/kernel/head.S	Tue Feb 18 18:58:53 2003
+++ edited/arch/i386/kernel/head.S	Wed Feb 19 11:56:50 2003
@@ -476,6 +476,13 @@
 	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
+	.quad 0x0000000000000000	/* 0xd0 - unused */
+	.quad 0x0000000000000000	/* 0xd8 - unused */
+	.quad 0x0000000000000000	/* 0xe0 - unused */
+	.quad 0x0000000000000000	/* 0xe8 - unused */
+	.quad 0x0000000000000000	/* 0xf0 - unused */
+	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
+
 #if CONFIG_SMP
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
 #endif
===== arch/i386/kernel/traps.c 1.44 vs edited =====
--- 1.44/arch/i386/kernel/traps.c	Sat Feb 15 19:30:17 2003
+++ edited/arch/i386/kernel/traps.c	Wed Feb 19 11:56:50 2003
@@ -775,7 +775,7 @@
 }
 #endif
 
-#define _set_gate(gate_addr,type,dpl,addr) \
+#define _set_gate(gate_addr,type,dpl,addr,seg) \
 do { \
   int __d0, __d1; \
   __asm__ __volatile__ ("movw %%dx,%%ax\n\t" \
@@ -785,7 +785,7 @@
 	:"=m" (*((long *) (gate_addr))), \
 	 "=m" (*(1+(long *) (gate_addr))), "=&a" (__d0), "=&d" (__d1) \
 	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
-	 "3" ((char *) (addr)),"2" (__KERNEL_CS << 16)); \
+	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
 } while (0)
 
 
@@ -797,22 +797,27 @@
  */
 void set_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,14,0,addr);
+	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
 }
 
 static void __init set_trap_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,0,addr);
+	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
 }
 
 static void __init set_system_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,3,addr);
+	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
 }
 
 static void __init set_call_gate(void *a, void *addr)
 {
-	_set_gate(a,12,3,addr);
+	_set_gate(a,12,3,addr,__KERNEL_CS);
+}
+
+static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
+{
+	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
 }
 
 
@@ -843,7 +848,7 @@
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
 	set_trap_gate(7,&device_not_available);
-	set_trap_gate(8,&double_fault);
+	set_task_gate(8,GDT_ENTRY_DOUBLEFAULT_TSS);
 	set_trap_gate(9,&coprocessor_segment_overrun);
 	set_trap_gate(10,&invalid_TSS);
 	set_trap_gate(11,&segment_not_present);
===== arch/i386/kernel/cpu/common.c 1.17 vs edited =====
--- 1.17/arch/i386/kernel/cpu/common.c	Sat Dec 28 09:17:17 2002
+++ edited/arch/i386/kernel/cpu/common.c	Wed Feb 19 11:56:50 2003
@@ -490,6 +490,10 @@
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
+	/* Set up doublefault TSS pointer in the GDT */
+	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
+	cpu_gdt_table[cpu][GDT_ENTRY_DOUBLEFAULT_TSS].b &= 0xfffffdff;
+
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
 
===== include/asm-i386/desc.h 1.12 vs edited =====
--- 1.12/include/asm-i386/desc.h	Sat Dec 28 09:18:49 2002
+++ edited/include/asm-i386/desc.h	Wed Feb 19 11:56:51 2003
@@ -42,10 +42,12 @@
 	"rorl $16,%%eax" \
 	: "=m"(*(n)) : "a" (addr), "r"(n), "ir"(limit), "i"(type))
 
-static inline void set_tss_desc(unsigned int cpu, void *addr)
+static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
-	_set_tssldt_desc(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (int)addr, 235, 0x89);
+	_set_tssldt_desc(&cpu_gdt_table[cpu][entry], (int)addr, 235, 0x89);
 }
+
+#define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
 
 static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
 {
===== include/asm-i386/processor.h 1.39 vs edited =====
--- 1.39/include/asm-i386/processor.h	Fri Feb 14 18:24:10 2003
+++ edited/include/asm-i386/processor.h	Wed Feb 19 11:56:51 2003
@@ -83,6 +83,7 @@
 extern struct cpuinfo_x86 boot_cpu_data;
 extern struct cpuinfo_x86 new_cpu_data;
 extern struct tss_struct init_tss[NR_CPUS];
+extern struct tss_struct doublefault_tss;
 
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
===== include/asm-i386/segment.h 1.5 vs edited =====
--- 1.5/include/asm-i386/segment.h	Sat Dec 28 09:18:49 2002
+++ edited/include/asm-i386/segment.h	Wed Feb 19 11:56:52 2003
@@ -37,6 +37,13 @@
  *  23 - APM BIOS support
  *  24 - APM BIOS support
  *  25 - APM BIOS support 
+ *
+ *  26 - unused
+ *  27 - unused
+ *  28 - unused
+ *  29 - unused
+ *  30 - unused
+ *  31 - TSS for double fault handler
  */
 #define GDT_ENTRY_TLS_ENTRIES	3
 #define GDT_ENTRY_TLS_MIN	6
@@ -64,10 +71,12 @@
 #define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
+#define GDT_ENTRY_DOUBLEFAULT_TSS	31
+
 /*
- * The GDT has 25 entries but we pad it to cacheline boundary:
+ * The GDT has 32 entries
  */
-#define GDT_ENTRIES 28
+#define GDT_ENTRIES 32
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
--- /dev/null	2002-08-30 16:31:37.000000000 -0700
+++ ./arch/i386/kernel/doublefault.c	2003-02-19 15:26:44.000000000 -0800
@@ -0,0 +1,65 @@
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/fs.h>
+
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+#include <asm/desc.h>
+
+#define DOUBLEFAULT_STACKSIZE (1024)
+static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
+#define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
+
+#define ptr_ok(x) ((x) > 0xc0000000 && (x) < 0xc1000000)
+
+static void doublefault_fn(void)
+{
+	struct Xgt_desc_struct gdt_desc = {0, 0};
+	unsigned long gdt, tss;
+
+	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");
+	gdt = gdt_desc.address;
+
+	printk("double fault, gdt at %08lx [%d bytes]\n", gdt, gdt_desc.size);
+
+	if (ptr_ok(gdt)) {
+		gdt += GDT_ENTRY_TSS << 3;
+		tss = *(u16 *)(gdt+2);
+		tss += *(u8 *)(gdt+4) << 16;
+		tss += *(u8 *)(gdt+7) << 24;
+		printk("double fault, tss at %08lx\n", tss);
+
+		if (ptr_ok(tss)) {
+			struct tss_struct *t = (struct tss_struct *)tss;
+
+			printk("eip = %08lx, esp = %08lx\n", t->eip, t->esp);
+
+			printk("eax = %08lx, ebx = %08lx, ecx = %08lx, edx = %08lx\n",
+				t->eax, t->ebx, t->ecx, t->edx);
+			printk("esi = %08lx, edi = %08lx\n",
+				t->esi, t->edi);
+		}
+	}
+
+	for (;;) /* nothing */;
+}
+
+struct tss_struct doublefault_tss __cacheline_aligned = {
+	.esp0		= STACK_START,
+	.ss0		= __KERNEL_DS,
+	.ldt		= 0,
+	.bitmap		= INVALID_IO_BITMAP_OFFSET,
+	.io_bitmap	= { [0 ... IO_BITMAP_SIZE ] = ~0 },
+
+	.eip		= (unsigned long) doublefault_fn,
+	.eflags		= 0x00000082,
+	.esp		= STACK_START,
+	.es		= __USER_DS,
+	.cs		= __KERNEL_CS,
+	.ss		= __KERNEL_DS,
+	.ds		= __USER_DS,
+
+	.__cr3		= __pa(swapper_pg_dir)
+};

