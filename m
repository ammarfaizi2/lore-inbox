Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268671AbUHTSco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268671AbUHTSco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUHTSbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:31:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2978 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268633AbUHTSVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:21:21 -0400
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/14]: kexec: kexec.i386
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:20:06 -0600
Message-ID: <m1smah4qp5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The is the i386 implementation of kexec.

diff -uNr linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/Kconfig linux-2.6.8.1-mm2-kexec.i386/arch/i386/Kconfig
--- linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/Kconfig	Fri Aug 20 09:56:25 2004
+++ linux-2.6.8.1-mm2-kexec.i386/arch/i386/Kconfig	Fri Aug 20 11:12:46 2004
@@ -866,6 +866,23 @@
 
 source "drivers/perfctr/Kconfig"
 
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
 
 
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/Makefile linux-2.6.8.1-mm2-kexec.i386/arch/i386/kernel/Makefile
--- linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/Makefile	Fri Aug 20 09:56:25 2004
+++ linux-2.6.8.1-mm2-kexec.i386/arch/i386/kernel/Makefile	Fri Aug 20 11:12:46 2004
@@ -24,6 +24,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/entry.S linux-2.6.8.1-mm2-kexec.i386/arch/i386/kernel/entry.S
--- linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/entry.S	Fri Aug 20 09:56:25 2004
+++ linux-2.6.8.1-mm2-kexec.i386/arch/i386/kernel/entry.S	Fri Aug 20 11:14:06 2004
@@ -936,7 +936,7 @@
 	.long sys_mq_timedreceive	/* 280 */
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
-	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_kexec_load
 	.long sys_perfctr_info
 	.long sys_vperfctr_open
 	.long sys_vperfctr_control
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/machine_kexec.c linux-2.6.8.1-mm2-kexec.i386/arch/i386/kernel/machine_kexec.c
--- linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.i386/arch/i386/kernel/machine_kexec.c	Fri Aug 20 11:12:46 2004
@@ -0,0 +1,208 @@
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
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
+#include <asm/io.h>
+#include <asm/apic.h>
+#include <asm/cpufeature.h>
+
+static inline unsigned long read_cr3(void)
+{
+	unsigned long cr3;
+	asm volatile("movl %%cr3,%0": "=r"(cr3));
+	return cr3;
+}
+
+#define PAGE_ALIGNED __attribute__ ((__aligned__(PAGE_SIZE)))
+
+#define L0_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
+#define L1_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
+#define L2_ATTR (_PAGE_PRESENT)
+
+#define LEVEL0_SIZE (1UL << 12UL)
+
+#ifndef CONFIG_X86_PAE
+#define LEVEL1_SIZE (1UL << 22UL)
+static u32 pgtable_level1[1024] PAGE_ALIGNED;
+
+static void identity_map_page(unsigned long address)
+{
+	unsigned long level1_index, level2_index;
+	u32 *pgtable_level2;
+
+	/* Find the current page table */
+	pgtable_level2 = __va(read_cr3());
+
+	/* Find the indexes of the physical address to identity map */
+	level1_index = (address % LEVEL1_SIZE)/LEVEL0_SIZE;
+	level2_index = address / LEVEL1_SIZE;
+
+	/* Identity map the page table entry */
+	pgtable_level1[level1_index] = address | L0_ATTR;
+	pgtable_level2[level2_index] = __pa(pgtable_level1) | L1_ATTR;
+
+	/* Flush the tlb so the new mapping takes effect.
+	 * Global tlb entries are not flushed but that is not an issue.
+	 */
+	load_cr3(pgtable_level2);
+}
+
+#else
+#define LEVEL1_SIZE (1UL << 21UL)
+#define LEVEL2_SIZE (1UL << 30UL)
+static u64 pgtable_level1[512] PAGE_ALIGNED;
+static u64 pgtable_level2[512] PAGE_ALIGNED;
+
+static void identity_map_page(unsigned long address)
+{
+	unsigned long level1_index, level2_index, level3_index;
+	u64 *pgtable_level3;
+
+	/* Find the current page table */
+	pgtable_level3 = __va(read_cr3());
+
+	/* Find the indexes of the physical address to identity map */
+	level1_index = (address % LEVEL1_SIZE)/LEVEL0_SIZE;
+	level2_index = (address % LEVEL2_SIZE)/LEVEL1_SIZE;
+	level3_index = address / LEVEL2_SIZE;
+
+	/* Identity map the page table entry */
+	pgtable_level1[level1_index] = address | L0_ATTR;
+	pgtable_level2[level2_index] = __pa(pgtable_level1) | L1_ATTR;
+	set_64bit(&pgtable_level3[level3_index], __pa(pgtable_level2) | L2_ATTR);
+
+	/* Flush the tlb so the new mapping takes effect.
+	 * Global tlb entries are not flushed but that is not an issue.
+	 */
+	load_cr3(pgtable_level3);
+}
+#endif	
+
+
+static void set_idt(void *newidt, __u16 limit)
+{
+	unsigned char curidt[6];
+
+	/* ia32 supports unaliged loads & stores */
+	(*(__u16 *)(curidt)) = limit;
+	(*(__u32 *)(curidt +2)) = (unsigned long)(newidt);
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
+	unsigned char curgdt[6];
+
+	/* ia32 supports unaligned loads & stores */
+	(*(__u16 *)(curgdt)) = limit;
+	(*(__u32 *)(curgdt +2)) = (unsigned long)(newgdt);
+
+	__asm__ __volatile__ (
+		"lgdt %0\n"
+		: "=m" (curgdt)
+		);
+};
+
+static void load_segments(void)
+{
+#define __STR(X) #X
+#define STR(X) __STR(X)
+
+	__asm__ __volatile__ (
+		"\tljmp $"STR(__KERNEL_CS)",$1f\n"
+		"\t1:\n"
+		"\tmovl $"STR(__KERNEL_DS)",%eax\n"
+		"\tmovl %eax,%ds\n"
+		"\tmovl %eax,%es\n"
+		"\tmovl %eax,%fs\n"
+		"\tmovl %eax,%gs\n"
+		"\tmovl %eax,%ss\n"
+		);
+#undef STR
+#undef __STR
+}
+
+typedef asmlinkage void (*relocate_new_kernel_t)(
+	unsigned long indirection_page, unsigned long reboot_code_buffer,
+	unsigned long start_address, unsigned int has_pae);
+
+const extern unsigned char relocate_new_kernel[];
+extern void relocate_new_kernel_end(void);
+const extern unsigned int relocate_new_kernel_size;
+
+/*
+ * Do what every setup is needed on image and the
+ * reboot code buffer to allow us to avoid allocations
+ * later.  Currently nothing.
+ */
+int machine_kexec_prepare(struct kimage *image)
+{
+	return 0;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+}
+
+/*
+ * Do not allocate memory (or fail in any way) in machine_kexec().
+ * We are past the point of no return, committed to rebooting now.
+ */
+void machine_kexec(struct kimage *image)
+{
+	unsigned long indirection_page;
+	unsigned long reboot_code_buffer;
+	relocate_new_kernel_t rnk;
+
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+
+	/* Compute some offsets */
+	reboot_code_buffer = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	indirection_page = image->head & PAGE_MASK;
+
+	/* Set up an identity mapping for the reboot_code_buffer */
+	identity_map_page(reboot_code_buffer);
+
+	/* copy it out */
+	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
+
+	/* The segment registers are funny things, they are
+	 * automatically loaded from a table, in memory wherever you
+	 * set them to a specific selector, but this table is never
+	 * accessed again you set the segment to a different selector.
+	 *
+	 * The more common model is are caches where the behide
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
+
+	/* now call it */
+	rnk = (relocate_new_kernel_t) reboot_code_buffer;
+	(*rnk)(indirection_page, reboot_code_buffer, image->start, cpu_has_pae);
+}
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/relocate_kernel.S linux-2.6.8.1-mm2-kexec.i386/arch/i386/kernel/relocate_kernel.S
--- linux-2.6.8.1-mm2-machine_shutdown.i386/arch/i386/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.i386/arch/i386/kernel/relocate_kernel.S	Fri Aug 20 11:12:46 2004
@@ -0,0 +1,118 @@
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
+relocate_new_kernel:
+	/* read the arguments and say goodbye to the stack */
+	movl  4(%esp), %ebx /* indirection_page */
+	movl  8(%esp), %ebp /* reboot_code_buffer */
+	movl  12(%esp), %edx /* start address */
+	movl  16(%esp), %ecx /* cpu_has_pae */
+
+	/* zero out flags, and disable interrupts */
+	pushl $0
+	popfl
+
+	/* set a new stack at the bottom of our page... */
+	lea   4096(%ebp), %esp
+
+	/* store the parameters back on the stack */
+	pushl   %edx /* store the start address */
+
+	/* Set cr0 to a known state:
+	 * 31 0 == Paging disabled
+	 * 18 0 == Alignment check disabled
+	 * 16 0 == Write protect disabled
+	 * 3  0 == No task switch
+	 * 2  0 == Don't do FP software emulation.
+	 * 0  1 == Proctected mode enabled
+	 */
+	movl	%cr0, %eax
+	andl	$~((1<<31)|(1<<18)|(1<<16)|(1<<3)|(1<<2)), %eax
+	orl	$(1<<0), %eax
+	movl	%eax, %cr0
+
+	/* clear cr4 if applicable */
+	testl	%ecx, %ecx
+	jz	1f
+	/* Set cr4 to a known state:
+	 * Setting everything to zero seems safe.
+	 */
+	movl	%cr4, %eax
+	andl	$0, %eax
+	movl	%eax, %cr4
+
+	jmp 1f
+1:
+
+	/* Flush the TLB (needed?) */
+	xorl	%eax, %eax
+	movl	%eax, %cr3
+
+	/* Do the copies */
+	cld
+0:	/* top, read another word for the indirection page */
+	movl    %ebx, %ecx
+	movl	(%ebx), %ecx
+	addl	$4, %ebx
+	testl	$0x1,   %ecx  /* is it a destination page */
+	jz	1f
+	movl	%ecx,	%edi
+	andl	$0xfffff000, %edi
+	jmp     0b
+1:
+	testl	$0x2,	%ecx  /* is it an indirection page */
+	jz	1f
+	movl	%ecx,	%ebx
+	andl	$0xfffff000, %ebx
+	jmp     0b
+1:
+	testl   $0x4,   %ecx /* is it the done indicator */
+	jz      1f
+	jmp     2f
+1:
+	testl   $0x8,   %ecx /* is it the source indicator */
+	jz      0b	     /* Ignore it otherwise */
+	movl    %ecx,   %esi /* For every source page do a copy */
+	andl    $0xfffff000, %esi
+
+	movl    $1024, %ecx
+	rep ; movsl
+	jmp     0b
+
+2:
+
+	/* To be certain of avoiding problems with self-modifying code
+	 * I need to execute a serializing instruction here.
+	 * So I flush the TLB, it's handy, and not processor dependent.
+	 */
+	xorl	%eax, %eax
+	movl	%eax, %cr3
+
+	/* set all of the registers to known values */
+	/* leave %esp alone */
+
+	xorl	%eax, %eax
+	xorl	%ebx, %ebx
+	xorl    %ecx, %ecx
+	xorl    %edx, %edx
+	xorl    %esi, %esi
+	xorl    %edi, %edi
+	xorl    %ebp, %ebp
+	ret
+relocate_new_kernel_end:
+
+	.globl relocate_new_kernel_size
+relocate_new_kernel_size:
+	.long relocate_new_kernel_end - relocate_new_kernel
diff -uNr linux-2.6.8.1-mm2-machine_shutdown.i386/include/asm-i386/kexec.h linux-2.6.8.1-mm2-kexec.i386/include/asm-i386/kexec.h
--- linux-2.6.8.1-mm2-machine_shutdown.i386/include/asm-i386/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.i386/include/asm-i386/kexec.h	Fri Aug 20 11:12:46 2004
@@ -0,0 +1,25 @@
+#ifndef _I386_KEXEC_H
+#define _I386_KEXEC_H
+
+#include <asm/fixmap.h>
+
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ *
+ * Someone correct me if FIXADDR_START - PAGEOFFSET is not the correct
+ * calculation for the amount of memory directly mappable into the
+ * kernel memory space.
+ */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+/* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
+
+#define KEXEC_CONTROL_CODE_SIZE	4096
+
+#endif /* _I386_KEXEC_H */

