Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268637AbUHTSgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268637AbUHTSgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268692AbUHTSfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:35:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5282 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268637AbUHTS2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:28:08 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/14] kexec: kexec.ppc
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:26:51 -0600
Message-ID: <m1k6vt4qdw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Finally the ppc port of kexec.  So far it has
not been tested on anything except a gamecube but it should
work in general.

Little things like fleshing out machine_shutdown still need
to happen though.

diff -uNr linux-2.6.8.1-mm2-use_mm/arch/ppc/Kconfig linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/Kconfig
--- linux-2.6.8.1-mm2-use_mm/arch/ppc/Kconfig	Fri Aug 20 11:37:59 2004
+++ linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/Kconfig	Fri Aug 20 11:28:51 2004
@@ -1220,6 +1220,26 @@
 	depends on SERIAL_SICC && UART0_TTYS1
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
+	  In the GAMECUBE implementation, kexec allows you to load and
+	  run DOL files, including kernel and homebrew DOLs.
+
 endmenu
 
 source "lib/Kconfig"
diff -uNr linux-2.6.8.1-mm2-use_mm/arch/ppc/kernel/Makefile linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/kernel/Makefile
--- linux-2.6.8.1-mm2-use_mm/arch/ppc/kernel/Makefile	Fri Aug 20 11:37:59 2004
+++ linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/kernel/Makefile	Fri Aug 20 11:28:51 2004
@@ -24,6 +24,7 @@
 obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 
 ifdef CONFIG_MATH_EMULATION
 obj-$(CONFIG_8xx)		+= softemu8xx.o
diff -uNr linux-2.6.8.1-mm2-use_mm/arch/ppc/kernel/machine_kexec.c linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/kernel/machine_kexec.c
--- linux-2.6.8.1-mm2-use_mm/arch/ppc/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/kernel/machine_kexec.c	Fri Aug 20 11:28:51 2004
@@ -0,0 +1,132 @@
+/*
+ * machine_kexec.c - handle transition of Linux booting another kernel
+ * Copyright (C) 2002-2003 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * GAMECUBE/PPC32 port Copyright (C) 2004 Albert Herranz
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
+#include <asm/mmu_context.h>
+#include <asm/io.h>
+#include <asm/hw_irq.h>
+#include <asm/cacheflush.h>
+
+typedef void (*relocate_new_kernel_t)(
+	unsigned long indirection_page, unsigned long reboot_code_buffer,
+	unsigned long start_address);
+
+const extern unsigned char relocate_new_kernel[];
+const extern unsigned int relocate_new_kernel_size;
+extern void use_mm(struct mm_struct *mm);
+
+static int identity_map_pages(struct page *pages, int order)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	int error;
+
+	mm = &init_mm;
+	vma = NULL;
+
+	down_write(&mm->mmap_sem);
+	error = -ENOMEM;
+	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	if (!vma) {
+		goto out;
+	}
+
+	memset(vma, 0, sizeof(*vma));
+	vma->vm_mm = mm;
+	vma->vm_start = page_to_pfn(pages) << PAGE_SHIFT;
+	vma->vm_end = vma->vm_start + (1 << (order + PAGE_SHIFT));
+	vma->vm_ops = NULL;
+	vma->vm_flags = VM_SHARED \
+		| VM_READ | VM_WRITE | VM_EXEC \
+		| VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC \
+		| VM_DONTCOPY | VM_RESERVED;
+	vma->vm_page_prot = protection_map[vma->vm_flags & 0xf];
+	vma->vm_file = NULL;
+	vma->vm_private_data = NULL;
+	insert_vm_struct(mm, vma);
+
+	error = remap_page_range(vma, vma->vm_start, vma->vm_start,
+		vma->vm_end - vma->vm_start, vma->vm_page_prot);
+	if (error) {
+		goto out;
+	}
+
+	error = 0;
+ out:
+	if (error && vma) {
+		kmem_cache_free(vm_area_cachep, vma);
+		vma = NULL;
+	}
+	up_write(&mm->mmap_sem);
+
+	return error;
+}
+
+/*
+ * Do what every setup is needed on image and the
+ * reboot code buffer to allow us to avoid allocations
+ * later.
+ */
+int machine_kexec_prepare(struct kimage *image)
+{
+	unsigned int order;
+	order = get_order(KEXEC_CONTROL_CODE_SIZE);
+	return identity_map_pages(image->control_code_page, order);
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+	unsigned int order;
+	order = get_order(KEXEC_CONTROL_CODE_SIZE);
+	do_munmap(&init_mm,
+		page_to_pfn(image->control_code_page) << PAGE_SHIFT,
+		1 << (order + PAGE_SHIFT));
+}
+
+void machine_shutdown(void)
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
+	/* switch to an mm where the reboot_code_buffer is identity mapped */
+	use_mm(&init_mm);
+
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+
+	reboot_code_buffer = page_to_pfn(image->control_code_page) <<PAGE_SHIFT;
+	indirection_page = image->head & PAGE_MASK;
+
+	/* copy it out */
+	memcpy((void *)reboot_code_buffer, 
+		relocate_new_kernel, relocate_new_kernel_size);
+
+	flush_icache_range(reboot_code_buffer,
+		reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
+	printk(KERN_INFO "Bye!\n");
+
+	/* now call it */
+	rnk = (relocate_new_kernel_t) reboot_code_buffer;
+	(*rnk)(indirection_page, reboot_code_buffer, image->start);
+}
+
diff -uNr linux-2.6.8.1-mm2-use_mm/arch/ppc/kernel/misc.S linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/kernel/misc.S
--- linux-2.6.8.1-mm2-use_mm/arch/ppc/kernel/misc.S	Fri Aug 20 11:37:59 2004
+++ linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/kernel/misc.S	Fri Aug 20 11:30:15 2004
@@ -1449,7 +1449,7 @@
 	.long sys_mq_timedreceive	/* 265 */
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
-	.long sys_ni_syscall		/* 268 reserved for sys_kexec_load */
+	.long sys_kexec_load
 	.long sys_perfctr_info
 	.long sys_vperfctr_open		/* 270 */
 	.long sys_vperfctr_control
diff -uNr linux-2.6.8.1-mm2-use_mm/arch/ppc/kernel/relocate_kernel.S linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/kernel/relocate_kernel.S
--- linux-2.6.8.1-mm2-use_mm/arch/ppc/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.ppc/arch/ppc/kernel/relocate_kernel.S	Fri Aug 20 11:28:51 2004
@@ -0,0 +1,127 @@
+/*
+ * relocate_kernel.S - put the kernel image in place to boot
+ * Copyright (C) 2002-2003 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * GAMECUBE/PPC32 port Copyright (C) 2004 Albert Herranz
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+
+#include <asm/kexec.h>
+                                                                                
+#define PAGE_SIZE      4096 /* must be same value as in <asm/page.h> */
+
+/* returns  r3 = relocated address of sym */
+/* modifies r0 */
+#define RELOC_SYM(sym) \
+	mflr	r3; \
+	bl	1f; \
+1:	mflr	r0; \
+	mtlr	r3; \
+	lis	r3, 1b@ha; \
+	ori	r3, r3, 1b@l; \
+	subf	r0, r3, r0; \
+	lis	r3, sym@ha; \
+	ori	r3, r3, sym@l; \
+	add	r3, r3, r0
+
+	/*
+	 * Must be relocatable PIC code callable as a C function.
+	 */
+	.globl relocate_new_kernel
+relocate_new_kernel:
+	/* r3 = indirection_page   */
+	/* r4 = reboot_code_buffer */
+	/* r5 = start_address      */
+
+	li	r0, 0
+
+	/* Set Machine Status Register to a known status */
+	mr	r8, r0
+	ori     r8, r8, MSR_RI|MSR_ME
+	mtmsr	r8
+	isync
+
+	/* from this point address translation is turned off */
+	/* and interrupts are disabled */
+
+	/* set a new stack at the bottom of our page... */
+	/* (not really needed now) */
+	addi	r1, r4, KEXEC_CONTROL_CODE_SIZE - 8 /* for LR Save+Back Chain */
+	stw	r0, 0(r1)
+
+	/* Do the copies */
+	li	r6, 0 /* checksum */
+	subi	r3, r3, 4
+
+0:	/* top, read another word for the indirection page */
+	lwzu	r0, 4(r3)
+
+	/* is it a destination page? (r8) */
+	rlwinm.	r7, r0, 0, 31, 31 /* IND_DESTINATION (1<<0) */
+	beq	1f
+ 
+	rlwinm	r8, r0, 0, 0, 19 /* clear kexec flags, page align */
+	b	0b
+
+1:	/* is it an indirection page? (r3) */
+	rlwinm.	r7, r0, 0, 30, 30 /* IND_INDIRECTION (1<<1) */
+	beq	1f
+
+	rlwinm	r3, r0, 0, 0, 19 /* clear kexec flags, page align */
+	subi	r3, r3, 4
+	b	0b
+
+1:	/* are we done? */
+	rlwinm.	r7, r0, 0, 29, 29 /* IND_DONE (1<<2) */
+	beq	1f
+	b	2f
+
+1:	/* is it a source page? (r9) */
+	rlwinm.	r7, r0, 0, 28, 28 /* IND_SOURCE (1<<3) */
+	beq	0b
+
+	rlwinm	r9, r0, 0, 0, 19 /* clear kexec flags, page align */
+
+	li	r7, PAGE_SIZE / 4
+	mtctr   r7
+	subi    r9, r9, 4
+	subi    r8, r8, 4
+9:
+	lwzu    r0, 4(r9)  /* do the copy */
+	xor	r6, r6, r0
+	stwu    r0, 4(r8)
+	dcbst	0, r8
+	sync
+	icbi	0, r8
+	bdnz    9b
+
+	addi    r9, r9, 4
+	addi    r8, r8, 4
+	b	0b
+
+2:
+
+	/* To be certain of avoiding problems with self-modifying code
+	 * execute a serializing instruction here.
+	 */
+	isync
+	sync
+
+	/* jump to the entry point, usually the setup routine */
+	mtlr	r5
+	blrl
+
+1:	b	1b
+
+relocate_new_kernel_end:
+
+	.globl relocate_new_kernel_size
+relocate_new_kernel_size:	
+	.long relocate_new_kernel_end - relocate_new_kernel
+
diff -uNr linux-2.6.8.1-mm2-use_mm/include/asm-ppc/kexec.h linux-2.6.8.1-mm2-kexec.ppc/include/asm-ppc/kexec.h
--- linux-2.6.8.1-mm2-use_mm/include/asm-ppc/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.6.8.1-mm2-kexec.ppc/include/asm-ppc/kexec.h	Fri Aug 20 11:28:51 2004
@@ -0,0 +1,26 @@
+#ifndef _PPC_KEXEC_H
+#define _PPC_KEXEC_H
+
+#ifdef CONFIG_KEXEC
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
+#endif /* CONFIG_KEXEC */
+
+#endif /* _PPC_KEXEC_H */
