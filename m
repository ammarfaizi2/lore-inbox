Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVASHvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVASHvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVASHvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:51:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50623 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261622AbVASHdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:14 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 19/29] x86_64-kexec
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the x86_64 implementation of machine kexec.
32bit compatibility support has been implemented, and machine_kexec
has been enhanced to not care about the changing internal kernel paget
table structures.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 arch/x86_64/Kconfig                  |   17 ++
 arch/x86_64/ia32/ia32entry.S         |    2 
 arch/x86_64/kernel/Makefile          |    1 
 arch/x86_64/kernel/crash.c           |   40 +++++
 arch/x86_64/kernel/machine_kexec.c   |  245 +++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/relocate_kernel.S |  143 ++++++++++++++++++++
 include/asm-x86_64/kexec.h           |   28 ++++
 include/asm-x86_64/unistd.h          |    2 
 8 files changed, 476 insertions(+), 2 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/Kconfig linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/Kconfig
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/Kconfig	Tue Jan 18 22:46:57 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/Kconfig	Tue Jan 18 23:14:06 2005
@@ -370,6 +370,23 @@
 	  the panic-ed kernel.
           
 	  Don't change this unless you know what you are doing.
+
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
 endmenu
 
 #
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/ia32/ia32entry.S linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/ia32/ia32entry.S	Fri Jan 14 04:32:23 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/ia32/ia32entry.S	Tue Jan 18 23:14:06 2005
@@ -589,7 +589,7 @@
 	.quad compat_sys_mq_timedreceive	/* 280 */
 	.quad compat_sys_mq_notify
 	.quad compat_sys_mq_getsetattr
-	.quad quiet_ni_syscall		/* reserved for kexec */
+	.quad compat_sys_kexec_load
 	.quad sys32_waitid
 	.quad quiet_ni_syscall		/* sys_altroot */
 	.quad sys_add_key
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/Makefile linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/Makefile
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/Makefile	Fri Jan 14 04:32:23 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/Makefile	Tue Jan 18 23:14:06 2005
@@ -20,6 +20,7 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o \
 		genapic.o genapic_cluster.o genapic_flat.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_PM)		+= suspend.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/crash.c linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/crash.c
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/crash.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/crash.c	Tue Jan 18 23:14:06 2005
@@ -0,0 +1,40 @@
+/*
+ * Architecture specific (x86_64) functions for kexec based crash dumps.
+ *
+ * Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
+ *
+ * Copyright (C) IBM Corporation, 2004. All rights reserved.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+#include <linux/reboot.h>
+#include <linux/kexec.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
+
+#include <asm/processor.h>
+#include <asm/hardirq.h>
+#include <asm/nmi.h>
+#include <asm/hw_irq.h>
+
+#define MAX_NOTE_BYTES 1024
+typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
+
+note_buf_t crash_notes[NR_CPUS];
+
+void machine_crash_shutdown(void)
+{
+	/* This function is only called after the system
+	 * has paniced or is otherwise in a critical state.
+	 * The minimum amount of code to allow a kexec'd kernel
+	 * to run successfully needs to happen here.
+	 *
+	 * In practice this means shooting down the other cpus in
+	 * an SMP system.
+	 */
+}
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/machine_kexec.c linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/machine_kexec.c
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/machine_kexec.c	Tue Jan 18 23:14:06 2005
@@ -0,0 +1,245 @@
+/*
+ * machine_kexec.c - handle transition of Linux booting another kernel
+ * Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
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
+	u64 *level2p, unsigned long addr)
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
+	u64 *level3p, unsigned long addr, unsigned long last_addr)
+{
+	unsigned long end_addr;
+	int result;
+	result = 0;
+	addr &= PAGE_MASK;
+	end_addr = addr + LEVEL3_SIZE;
+	while((addr < last_addr) && (addr < end_addr)) {
+		struct page *page;
+		u64 *level2p;
+		page = kimage_alloc_control_pages(image, 0);
+		if (!page) {
+			result = -ENOMEM;
+			goto out;
+		}
+		level2p = (u64 *)page_address(page);
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
+	u64 *level4p, unsigned long addr, unsigned long last_addr)
+{
+	unsigned long end_addr;
+	int result;
+	result = 0;
+	addr &= PAGE_MASK;
+	end_addr = addr + LEVEL4_SIZE;
+	while((addr < last_addr) && (addr < end_addr)) {
+		struct page *page;
+		u64 *level3p;
+		page = kimage_alloc_control_pages(image, 0);
+		if (!page) {
+			result = -ENOMEM;
+			goto out;
+		}
+		level3p = (u64 *)page_address(page);
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
+	u64 *level4p;
+	level4p = (u64 *)__va(start_pgtable);
+	return init_level4_page(image, level4p, 0, end_pfn << PAGE_SHIFT);
+}
+
+static void set_idt(void *newidt, u16 limit)
+{
+	unsigned char curidt[10];
+
+	/* x86-64 supports unaliged loads & stores */
+	(*(u16 *)(curidt)) = limit;
+	(*(u64 *)(curidt +2)) = (unsigned long)(newidt);
+
+	__asm__ __volatile__ (
+		"lidt %0\n"
+		: "=m" (curidt)
+		);
+};
+
+
+static void set_gdt(void *newgdt, u16 limit)
+{
+	unsigned char curgdt[10];
+
+	/* x86-64 supports unaligned loads & stores */
+	(*(u16 *)(curgdt)) = limit;
+	(*(u64 *)(curgdt +2)) = (unsigned long)(newgdt);
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
+typedef NORET_TYPE void (*relocate_new_kernel_t)(
+	unsigned long indirection_page, unsigned long control_code_buffer,
+	unsigned long start_address, unsigned long pgtable) ATTRIB_NORET;
+
+const extern unsigned char relocate_new_kernel[];
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
+NORET_TYPE void machine_kexec(struct kimage *image)
+{
+	unsigned long page_list;
+	unsigned long control_code_buffer;
+	unsigned long start_pgtable;
+	relocate_new_kernel_t rnk;
+
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+
+	/* Calculate the offsets */
+	page_list           = image->head;
+	start_pgtable       = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	control_code_buffer = start_pgtable + 4096UL;
+
+	/* Set the low half of the page table to my identity mapped
+	 * page table for kexec.  Leave the high half pointing at the
+	 * kernel pages.   Don't bother to flush the global pages
+	 * as that will happen when I fully switch to my identity mapped
+	 * page table anyway.
+	 */
+	memcpy(__va(read_cr3()), __va(start_pgtable), PAGE_SIZE/2);
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
+	(*rnk)(page_list, control_code_buffer, image->start, start_pgtable);
+}
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/relocate_kernel.S linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/relocate_kernel.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/relocate_kernel.S	Tue Jan 18 23:14:06 2005
@@ -0,0 +1,143 @@
+/*
+ * relocate_kernel.S - put the kernel image in place to boot
+ * Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
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
+	/* %rdi page_list
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
+	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
+	xorq	%rdi, %rdi
+	xorq	%rsi, %rsi
+	jmp	1f
+
+0:	/* top, read another word for the indirection page */
+
+	movq	(%rbx), %rcx
+	addq	$8,	%rbx
+1:	
+	testq	$0x1,	%rcx  /* is it a destination page? */
+	jz	2f
+	movq	%rcx,	%rdi
+	andq	$0xfffffffffffff000, %rdi
+	jmp	0b
+2:
+	testq	$0x2,	%rcx  /* is it an indirection page? */
+	jz	2f
+	movq	%rcx,   %rbx
+	andq	$0xfffffffffffff000, %rbx
+	jmp	0b
+2:
+	testq	$0x4,	%rcx  /* is it the done indicator? */
+	jz	2f
+	jmp	3f
+2:
+	testq	$0x8,	%rcx  /* is it the source indicator? */
+	jz	0b	      /* Ignore it otherwise */
+	movq	%rcx,   %rsi  /* For ever source page do a copy */
+	andq	$0xfffffffffffff000, %rsi
+
+	movq	$512,   %rcx
+	rep ; movsq
+	jmp	0b
+3:
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
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/include/asm-x86_64/kexec.h linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/include/asm-x86_64/kexec.h
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/include/asm-x86_64/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/include/asm-x86_64/kexec.h	Tue Jan 18 23:14:06 2005
@@ -0,0 +1,28 @@
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
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_X86_64
+
+#endif /* _X86_64_KEXEC_H */
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/include/asm-x86_64/unistd.h linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/include/asm-x86_64/unistd.h
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/include/asm-x86_64/unistd.h	Fri Jan 14 04:32:27 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/include/asm-x86_64/unistd.h	Tue Jan 18 23:14:06 2005
@@ -554,7 +554,7 @@
 #define __NR_mq_getsetattr 	245
 __SYSCALL(__NR_mq_getsetattr, sys_mq_getsetattr)
 #define __NR_kexec_load 	246
-__SYSCALL(__NR_kexec_load, sys_ni_syscall)
+__SYSCALL(__NR_kexec_load, sys_kexec_load)
 #define __NR_waitid		247
 __SYSCALL(__NR_waitid, sys_waitid)
 #define __NR_add_key		248
