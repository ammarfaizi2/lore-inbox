Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUHTS1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUHTS1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbUHTS1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:27:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65441 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268632AbUHTSPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:15:37 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/14] kexec: kexec.x86_64
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:14:17 -0600
Message-ID: <m11xi165ja.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the kexec implementation for x86_64

diff -uNr linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/Kconfig linux-2.6.8.1-mm2-kexec.x86_64/arch/x86_64/Kconfig
--- linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/Kconfig	Fri Aug 20 09:56:29 2004
+++ linux-2.6.8.1-mm2-kexec.x86_64/arch/x86_64/Kconfig	Fri Aug 20 10:15:30 2004
@@ -401,6 +401,23 @@
 	depends on IA32_EMULATION
 	default y
 
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.   And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similiarity to the exec system call.
+
+	  It is an ongoing process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+
 endmenu
 
 source drivers/Kconfig
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/kernel/Makefile linux-2.6.8.1-mm2-kexec.x86_64/arch/x86_64/kernel/Makefile
--- linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/kernel/Makefile	Fri Aug 20 09:56:29 2004
+++ linux-2.6.8.1-mm2-kexec.x86_64/arch/x86_64/kernel/Makefile	Fri Aug 20 10:15:30 2004
@@ -18,6 +18,7 @@
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_PM)		+= suspend.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/kernel/machine_kexec.c linux-2.6.8.1-mm2-kexec.x86_64/arch/x86_64/kernel/machine_kexec.c
--- linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.x86_64/arch/x86_64/kernel/machine_kexec.c	Fri Aug 20 10:15:30 2004
@@ -0,0 +1,246 @@
+/*
+ * machine_kexec.c - handle transition of Linux booting another kernel
+ * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/mm.h>
+#include <linux/kexec.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/reboot.h>
+#include <asm/pda.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
+#include <asm/io.h>
+#include <asm/apic.h>
+#include <asm/cpufeature.h>
+#include <asm/hw_irq.h>
+
+#define LEVEL0_SIZE (1UL << 12UL)
+#define LEVEL1_SIZE (1UL << 21UL)
+#define LEVEL2_SIZE (1UL << 30UL)
+#define LEVEL3_SIZE (1UL << 39UL)
+#define LEVEL4_SIZE (1UL << 48UL)
+
+#define L0_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
+#define L1_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE)
+#define L2_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
+#define L3_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
+
+static void init_level2_page(
+	uint64_t *level2p, unsigned long addr)
+{
+	unsigned long end_addr;
+	addr &= PAGE_MASK;
+	end_addr = addr + LEVEL2_SIZE;
+	while(addr < end_addr) {
+		*(level2p++) = addr | L1_ATTR;
+		addr += LEVEL1_SIZE;
+	}
+}
+
+static int init_level3_page(struct kimage *image,
+	uint64_t *level3p, unsigned long addr, unsigned long last_addr)
+{
+	unsigned long end_addr;
+	int result;
+	result = 0;
+	addr &= PAGE_MASK;
+	end_addr = addr + LEVEL3_SIZE;
+	while((addr < last_addr) && (addr < end_addr)) {
+		struct page *page;
+		uint64_t *level2p;
+		page = kimage_alloc_control_pages(image, 0);
+		if (!page) {
+			result = -ENOMEM;
+			goto out;
+		}
+		level2p = (uint64_t *)page_address(page);
+		init_level2_page(level2p, addr);
+		*(level3p++) = __pa(level2p) | L2_ATTR;
+		addr += LEVEL2_SIZE;
+	}
+	/* clear the unused entries */
+	while(addr < end_addr) {
+		*(level3p++) = 0;
+		addr += LEVEL2_SIZE;
+	}
+out:
+	return result;
+}
+
+
+static int init_level4_page(struct kimage *image, 
+	uint64_t *level4p, unsigned long addr, unsigned long last_addr)
+{
+	unsigned long end_addr;
+	int result;
+	result = 0;
+	addr &= PAGE_MASK;
+	end_addr = addr + LEVEL4_SIZE;
+	while((addr < last_addr) && (addr < end_addr)) {
+		struct page *page;
+		uint64_t *level3p;
+		page = kimage_alloc_control_pages(image, 0);
+		if (!page) {
+			result = -ENOMEM;
+			goto out;
+		}
+		level3p = (uint64_t *)page_address(page);
+		result = init_level3_page(image, level3p, addr, last_addr);
+		if (result) {
+			goto out;
+		}
+		*(level4p++) = __pa(level3p) | L3_ATTR;
+		addr += LEVEL3_SIZE;
+	}
+	/* clear the unused entries */
+	while(addr < end_addr) {
+		*(level4p++) = 0;
+		addr += LEVEL3_SIZE;
+	}
+ out:
+	return result;
+}
+
+
+static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
+{
+	uint64_t *level4p;
+	level4p = (uint64_t *)__va(start_pgtable);
+	return init_level4_page(image, level4p, 0, end_pfn << PAGE_SHIFT);
+}
+
+static void set_idt(void *newidt, __u16 limit)
+{
+	unsigned char curidt[10];
+
+	/* x86-64 supports unaliged loads & stores */
+	(*(__u16 *)(curidt)) = limit;
+	(*(__u64 *)(curidt +2)) = (unsigned long)(newidt);
+
+	__asm__ __volatile__ (
+		"lidt %0\n"
+		: "=m" (curidt)
+		);
+};
+
+
+static void set_gdt(void *newgdt, __u16 limit)
+{
+	unsigned char curgdt[10];
+
+	/* x86-64 supports unaligned loads & stores */
+	(*(__u16 *)(curgdt)) = limit;
+	(*(__u64 *)(curgdt +2)) = (unsigned long)(newgdt);
+
+	__asm__ __volatile__ (
+		"lgdt %0\n"
+		: "=m" (curgdt)
+		);
+};
+
+static void load_segments(void)
+{
+	__asm__ __volatile__ (
+		"\tmovl $"STR(__KERNEL_DS)",%eax\n"
+		"\tmovl %eax,%ds\n"
+		"\tmovl %eax,%es\n"
+		"\tmovl %eax,%ss\n"
+		"\tmovl %eax,%fs\n"
+		"\tmovl %eax,%gs\n"
+		);
+#undef STR
+#undef __STR
+}
+
+typedef void (*relocate_new_kernel_t)(
+	unsigned long indirection_page, unsigned long control_code_buffer,
+	unsigned long start_address, unsigned long pgtable);
+
+const extern unsigned char relocate_new_kernel[];
+extern void relocate_new_kernel_end(void);
+const extern unsigned long relocate_new_kernel_size;
+
+int machine_kexec_prepare(struct kimage *image)
+{
+	unsigned long start_pgtable, control_code_buffer;
+	int result;
+
+	/* Calculate the offsets */
+	start_pgtable       = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	control_code_buffer = start_pgtable + 4096UL;
+
+	/* Setup the identity mapped 64bit page table */
+	result = init_pgtable(image, start_pgtable);
+	if (result) {
+		return result;
+	}
+
+	/* Place the code in the reboot code buffer */
+	memcpy(__va(control_code_buffer), relocate_new_kernel, relocate_new_kernel_size);
+
+	return 0;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+	return;
+}
+
+/*
+ * Do not allocate memory (or fail in any way) in machine_kexec().
+ * We are past the point of no return, committed to rebooting now.
+ */
+void machine_kexec(struct kimage *image)
+{
+	unsigned long indirection_page;
+	unsigned long control_code_buffer;
+	unsigned long start_pgtable;
+	relocate_new_kernel_t rnk;
+
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+
+	/* Calculate the offsets */
+	indirection_page    = image->head & PAGE_MASK;
+	start_pgtable       = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	control_code_buffer = start_pgtable + 4096UL;
+
+	/* Set the low half of the page table to my identity mapped
+	 * page table for kexec.  Leave the high half pointing at the
+	 * kernel pages.   Don't bother to flush the global pages
+	 * as that will happen when I fully switch to my identity mapped
+	 * page table anyway.
+	 */
+	memcpy((void *)read_pda(level4_pgt), __va(start_pgtable), PAGE_SIZE/2);
+	__flush_tlb();
+
+
+	/* The segment registers are funny things, they are
+	 * automatically loaded from a table, in memory wherever you
+	 * set them to a specific selector, but this table is never
+	 * accessed again unless you set the segment to a different selector.
+	 *
+	 * The more common model are caches where the behide
+	 * the scenes work is done, but is also dropped at arbitrary
+	 * times.
+	 *
+	 * I take advantage of this here by force loading the
+	 * segments, before I zap the gdt with an invalid value.
+	 */
+	load_segments();
+	/* The gdt & idt are now invalid.
+	 * If you want to load them you must set up your own idt & gdt.
+	 */
+	set_gdt(phys_to_virt(0),0);
+	set_idt(phys_to_virt(0),0);
+	/* now call it */
+	rnk = (relocate_new_kernel_t) control_code_buffer;
+	(*rnk)(indirection_page, control_code_buffer, image->start, start_pgtable);
+}
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/kernel/relocate_kernel.S linux-2.6.8.1-mm2-kexec.x86_64/arch/x86_64/kernel/relocate_kernel.S
--- linux-2.6.8.1-mm2-machine_shutdown.x86_64/arch/x86_64/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.x86_64/arch/x86_64/kernel/relocate_kernel.S	Fri Aug 20 10:15:30 2004
@@ -0,0 +1,141 @@
+/*
+ * relocate_kernel.S - put the kernel image in place to boot
+ * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/linkage.h>
+
+	/*
+	 * Must be relocatable PIC code callable as a C function, that once
+	 * it starts can not use the previous processes stack.
+	 */
+	.globl relocate_new_kernel
+	.code64
+relocate_new_kernel:
+	/* %rdi indirection_page
+	 * %rsi reboot_code_buffer
+	 * %rdx start address
+	 * %rcx page_table
+	 * %r8  arg5
+	 * %r9  arg6
+	 */		
+
+	/* zero out flags, and disable interrupts */
+	pushq $0
+	popfq
+
+	/* set a new stack at the bottom of our page... */
+	lea   4096(%rsi), %rsp
+
+	/* store the parameters back on the stack */
+	pushq	%rdx /* store the start address */	
+
+	/* Set cr0 to a known state:
+	 * 31 1 == Paging enabled
+	 * 18 0 == Alignment check disabled
+	 * 16 0 == Write protect disabled
+	 * 3  0 == No task switch
+	 * 2  0 == Don't do FP software emulation.
+	 * 0  1 == Proctected mode enabled
+	 */
+	movq	%cr0, %rax
+	andq	$~((1<<18)|(1<<16)|(1<<3)|(1<<2)), %rax
+	orl	$((1<<31)|(1<<0)), %eax
+	movq	%rax, %cr0
+
+	/* Set cr4 to a known state:
+	 * 10 0 == xmm exceptions disabled
+	 * 9  0 == xmm registers instructions disabled
+	 * 8  0 == performance monitoring counter disabled
+	 * 7  0 == page global disabled
+	 * 6  0 == machine check exceptions disabled	
+	 * 5  1 == physical address extension enabled	
+	 * 4  0 == page size extensions	disabled
+	 * 3  0 == Debug extensions disabled 	
+	 * 2  0 == Time stamp disable (disabled) 	
+	 * 1  0 == Protected mode virtual interrupts disabled
+	 * 0  0 == VME disabled
+	 */
+
+	movq	$((1<<5)), %rax
+	movq	%rax, %cr4
+
+	jmp 1f
+1:
+
+	/* Switch to the identity mapped page tables,
+	 * and flush the TLB.	
+	*/
+	movq	%rcx, %cr3
+
+	/* Do the copies */
+	movq	%rdi, %rbx	/* Put the indirection page in %rbx */
+	xorq	%rdi, %rdi
+	xorq	%rsi, %rsi
+	
+0:	/* top, read another word for the indirection page */
+	
+	movq	(%rbx), %rcx
+	addq	$8,	%rbx
+	testq	$0x1,	%rcx  /* is it a destination page? */
+	jz	1f
+	movq	%rcx,	%rdi
+	andq	$0xfffffffffffff000, %rdi
+	jmp	0b
+1:
+	testq	$0x2,	%rcx  /* is it an indirection page? */
+	jz	1f
+	movq	%rcx,   %rbx
+	andq	$0xfffffffffffff000, %rbx
+	jmp	0b
+1:
+	testq	$0x4,	%rcx  /* is it the done indicator? */
+	jz	1f
+	jmp	2f
+1:
+	testq	$0x8,	%rcx  /* is it the source indicator? */
+	jz	0b	      /* Ignore it otherwise */
+	movq	%rcx,   %rsi  /* For ever source page do a copy */
+	andq	$0xfffffffffffff000, %rsi
+
+	movq	$512,   %rcx
+	rep ; movsq
+	jmp	0b
+2:
+
+	/* To be certain of avoiding problems with self-modifying code
+	 * I need to execute a serializing instruction here.
+	 * So I flush the TLB by reloading %cr3 here, it's handy, 
+	 * and not processor dependent.
+	 */
+	movq	%cr3, %rax
+	movq	%rax, %cr3
+
+	/* set all of the registers to known values */
+	/* leave %rsp alone */
+
+	xorq	%rax, %rax
+	xorq	%rbx, %rbx
+	xorq    %rcx, %rcx
+	xorq    %rdx, %rdx
+	xorq    %rsi, %rsi
+	xorq    %rdi, %rdi
+	xorq    %rbp, %rbp
+	xorq	%r8,  %r8
+	xorq	%r9,  %r9
+	xorq	%r10, %r9
+	xorq	%r11, %r11
+	xorq	%r12, %r12
+	xorq	%r13, %r13
+	xorq	%r14, %r14
+	xorq	%r15, %r15
+
+	ret
+relocate_new_kernel_end:
+
+	.globl relocate_new_kernel_size
+relocate_new_kernel_size:
+	.quad relocate_new_kernel_end - relocate_new_kernel
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.x86_64/include/asm-x86_64/kexec.h linux-2.6.8.1-mm2-kexec.x86_64/include/asm-x86_64/kexec.h
--- linux-2.6.8.1-mm2-machine_shutdown.x86_64/include/asm-x86_64/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.x86_64/include/asm-x86_64/kexec.h	Fri Aug 20 10:15:30 2004
@@ -0,0 +1,25 @@
+#ifndef _X86_64_KEXEC_H
+#define _X86_64_KEXEC_H
+
+#include <asm/page.h>
+#include <asm/proto.h>
+
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ *
+ * So far x86_64 is limited to 40 physical address bits.
+ */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT      (0xFFFFFFFFFFUL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (0xFFFFFFFFFFUL)
+/* Maximum address we can use for the control pages */
+#define KEXEC_CONTROL_MEMORY_LIMIT     (0xFFFFFFFFFFUL)
+
+/* Allocate one page for the pdp and the second for the code */
+#define KEXEC_CONTROL_CODE_SIZE  (4096UL + 4096UL)
+
+#endif /* _X86_64_KEXEC_H */
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.x86_64/include/asm-x86_64/unistd.h linux-2.6.8.1-mm2-kexec.x86_64/include/asm-x86_64/unistd.h
--- linux-2.6.8.1-mm2-machine_shutdown.x86_64/include/asm-x86_64/unistd.h	Fri Aug 20 09:56:44 2004
+++ linux-2.6.8.1-mm2-kexec.x86_64/include/asm-x86_64/unistd.h	Fri Aug 20 11:03:03 2004
@@ -553,7 +553,7 @@
 #define __NR_mq_getsetattr 	245
 __SYSCALL(__NR_mq_getsetattr, sys_mq_getsetattr)
 #define __NR_kexec_load 	246
-__SYSCALL(__NR_kexec_load, sys_ni_syscall)
+__SYSCALL(__NR_kexec_load, sys_kexec_load)
 #define __NR_perfctr_info	247
 __SYSCALL(__NR_perfctr_info, sys_perfctr_info)
 #define __NR_vperfctr_open	(__NR_perfctr_info+1)
