Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbUKHPxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUKHPxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUKHPxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:53:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261850AbUKHOfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:25 -0500
Date: Mon, 8 Nov 2004 14:34:18 GMT
Message-Id: <200411081434.iA8EYIwT023562@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 11/20] FRV: Fujitsu FR-V CPU arch implementation part 9
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches provides part 9 of an architecture implementation
for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-arch_9-2610rc1mm3.diff
 Makefile      |    9 
 cache-page.c  |   66 ++++++
 dma-alloc.c   |  186 +++++++++++++++++
 elf-fdpic.c   |  123 +++++++++++
 extable.c     |   91 ++++++++
 fault.c       |  323 +++++++++++++++++++++++++++++
 highmem.c     |   33 +++
 init.c        |  244 ++++++++++++++++++++++
 kmap.c        |   56 +++++
 mmu-context.c |  210 +++++++++++++++++++
 pgalloc.c     |  159 ++++++++++++++
 tlb-flush.S   |  185 +++++++++++++++++
 tlb-miss.S    |  631 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 unaligned.c   |  218 ++++++++++++++++++++
 14 files changed, 2534 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/cache-page.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/cache-page.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/cache-page.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/cache-page.c	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,66 @@
+/* cache-page.c: whole-page cache wrangling functions for MMU linux
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <asm/pgalloc.h>
+
+/*****************************************************************************/
+/*
+ * DCF takes a virtual address and the page may not currently have one
+ * - temporarily hijack a kmap_atomic() slot and attach the page to it
+ */
+void flush_dcache_page(struct page *page)
+{
+	unsigned long dampr2;
+	void *vaddr;
+
+	dampr2 = __get_DAMPR(2);
+
+	vaddr = kmap_atomic(page, __KM_CACHE);
+
+	frv_dcache_writeback((unsigned long) vaddr, (unsigned long) vaddr + PAGE_SIZE);
+
+	kunmap_atomic(vaddr, __KM_CACHE);
+
+	if (dampr2) {
+		__set_DAMPR(2, dampr2);
+		__set_IAMPR(2, dampr2);
+	}
+
+} /* end flush_dcache_page() */
+
+/*****************************************************************************/
+/*
+ * ICI takes a virtual address and the page may not currently have one
+ * - so we temporarily attach the page to a bit of virtual space so that is can be flushed
+ */
+void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+			     unsigned long start, unsigned long len)
+{
+	unsigned long dampr2;
+	void *vaddr;
+
+	dampr2 = __get_DAMPR(2);
+
+	vaddr = kmap_atomic(page, __KM_CACHE);
+
+	start = (start & ~PAGE_MASK) | (unsigned long) vaddr;
+	frv_cache_wback_inv(start, start + len);
+
+	kunmap_atomic(vaddr, __KM_CACHE);
+
+	if (dampr2) {
+		__set_DAMPR(2, dampr2);
+		__set_IAMPR(2, dampr2);
+	}
+
+} /* end flush_icache_user_range() */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/dma-alloc.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/dma-alloc.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/dma-alloc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/dma-alloc.c	2004-11-05 16:57:33.000000000 +0000
@@ -0,0 +1,186 @@
+/* dma-alloc.c: consistent DMA memory allocation
+ *
+ * Derived from arch/ppc/mm/cachemap.c
+ *
+ *  PowerPC version derived from arch/arm/mm/consistent.c
+ *    Copyright (C) 2001 Dan Malek (dmalek@jlc.net)
+ *
+ *  linux/arch/arm/mm/consistent.c
+ *
+ *  Copyright (C) 2000 Russell King
+ *
+ * Consistent memory allocators.  Used for DMA devices that want to
+ * share uncached memory with the processor core.  The function return
+ * is the virtual address and 'dma_handle' is the physical address.
+ * Mostly stolen from the ARM port, with some changes for PowerPC.
+ *						-- Dan
+ * Modified for 36-bit support.  -Matt
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/stddef.h>
+#include <linux/vmalloc.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/pgalloc.h>
+#include <asm/io.h>
+#include <asm/hardirq.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/mmu.h>
+#include <asm/uaccess.h>
+#include <asm/smp.h>
+
+static int map_page(unsigned long va, unsigned long pa, pgprot_t prot)
+{
+	pgd_t *pge;
+	pmd_t *pme;
+	pte_t *pte;
+	int err = -ENOMEM;
+
+	spin_lock(&init_mm.page_table_lock);
+
+	/* Use upper 10 bits of VA to index the first level map */
+	pge = pml4_pgd_offset_k(pml4_offset_k(va), va);
+	pme = pmd_offset(pge, va);
+
+	/* Use middle 10 bits of VA to index the second-level map */
+	pte = pte_alloc_kernel(&init_mm, pme, va);
+	if (pte != 0) {
+		err = 0;
+		set_pte(pte, mk_pte_phys(pa & PAGE_MASK, prot));
+	}
+
+	spin_unlock(&init_mm.page_table_lock);
+	return err;
+}
+
+/*
+ * This function will allocate the requested contiguous pages and
+ * map them into the kernel's vmalloc() space.  This is done so we
+ * get unique mapping for these pages, outside of the kernel's 1:1
+ * virtual:physical mapping.  This is necessary so we can cover large
+ * portions of the kernel with single large page TLB entries, and
+ * still get unique uncached pages for consistent DMA.
+ */
+void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
+{
+	struct vm_struct *area;
+	unsigned long page, va, pa;
+	void *ret;
+	int order, err, i;
+
+	if (in_interrupt())
+		BUG();
+
+	/* only allocate page size areas */
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+
+	page = __get_free_pages(gfp, order);
+	if (!page) {
+		BUG();
+		return NULL;
+	}
+
+	/* allocate some common virtual space to map the new pages */
+	area = get_vm_area(size, VM_ALLOC);
+	if (area == 0) {
+		free_pages(page, order);
+		return NULL;
+	}
+	va = VMALLOC_VMADDR(area->addr);
+	ret = (void *) va;
+
+	/* this gives us the real physical address of the first page */
+	*dma_handle = pa = virt_to_bus((void *) page);
+
+	/* set refcount=1 on all pages in an order>0 allocation so that vfree() will actually free
+	 * all pages that were allocated.
+	 */
+	if (order > 0) {
+		struct page *rpage = virt_to_page(page);
+
+		for (i = 1; i < (1 << order); i++)
+			set_page_count(rpage + i, 1);
+	}
+
+	err = 0;
+	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
+		err = map_page(va + i, pa + i, PAGE_KERNEL_NOCACHE);
+
+	if (err) {
+		vfree((void *) va);
+		return NULL;
+	}
+
+	/* we need to ensure that there are no cachelines in use, or worse dirty in this area
+	 * - can't do until after virtual address mappings are created
+	 */
+	frv_cache_invalidate(va, va + size);
+
+	return ret;
+}
+
+/*
+ * free page(s) as defined by the above mapping.
+ */
+void consistent_free(void *vaddr)
+{
+	if (in_interrupt())
+		BUG();
+	vfree(vaddr);
+}
+
+/*
+ * make an area consistent.
+ */
+void consistent_sync(void *vaddr, size_t size, int direction)
+{
+	unsigned long start = (unsigned long) vaddr;
+	unsigned long end   = start + size;
+
+	switch (direction) {
+	case PCI_DMA_NONE:
+		BUG();
+	case PCI_DMA_FROMDEVICE:	/* invalidate only */
+		frv_cache_invalidate(start, end);
+		break;
+	case PCI_DMA_TODEVICE:		/* writeback only */
+		frv_dcache_writeback(start, end);
+		break;
+	case PCI_DMA_BIDIRECTIONAL:	/* writeback and invalidate */
+		frv_dcache_writeback(start, end);
+		break;
+	}
+}
+
+/*
+ * consistent_sync_page make a page are consistent. identical
+ * to consistent_sync, but takes a struct page instead of a virtual address
+ */
+
+void consistent_sync_page(struct page *page, unsigned long offset,
+			  size_t size, int direction)
+{
+	void *start;
+
+	start = page_address(page) + offset;
+	consistent_sync(start, size, direction);
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/elf-fdpic.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/elf-fdpic.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/elf-fdpic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/elf-fdpic.c	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,123 @@
+/* elf-fdpic.c: ELF FDPIC memory layout management
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/elf-fdpic.h>
+
+/*****************************************************************************/
+/*
+ * lay out the userspace VM according to our grand design
+ */
+#ifdef CONFIG_MMU
+void elf_fdpic_arch_lay_out_mm(struct elf_fdpic_params *exec_params,
+			       struct elf_fdpic_params *interp_params,
+			       unsigned long *start_stack,
+			       unsigned long *start_brk)
+{
+	*start_stack = 0x02200000UL;
+
+	/* if the only executable is a shared object, assume that it is an interpreter rather than
+	 * a true executable, and map it such that "ld.so --list" comes out right
+	 */
+	if (!(interp_params->flags & ELF_FDPIC_FLAG_PRESENT) &&
+	    exec_params->hdr.e_type != ET_EXEC
+	    ) {
+		exec_params->load_addr = PAGE_SIZE;
+
+		*start_brk = 0x80000000UL;
+	}
+	else {
+		exec_params->load_addr = 0x02200000UL;
+
+		if ((exec_params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) ==
+		    ELF_FDPIC_FLAG_INDEPENDENT
+		    ) {
+			exec_params->flags &= ~ELF_FDPIC_FLAG_ARRANGEMENT;
+			exec_params->flags |= ELF_FDPIC_FLAG_CONSTDISP;
+		}
+	}
+
+} /* end elf_fdpic_arch_lay_out_mm() */
+#endif
+
+/*****************************************************************************/
+/*
+ * place non-fixed mmaps firstly in the bottom part of memory, working up, and then in the top part
+ * of memory, working down
+ */
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len,
+				     unsigned long pgoff, unsigned long flags)
+{
+	struct vm_area_struct *vma;
+	unsigned long limit;
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	/* only honour a hint if we're not going to clobber something doing so */
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(current->mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			goto success;
+	}
+
+	/* search between the bottom of user VM and the stack grow area */
+	addr = PAGE_SIZE;
+	limit = (current->mm->start_stack - 0x00200000);
+	if (addr + len <= limit) {
+		limit -= len;
+
+		if (addr <= limit) {
+			vma = find_vma(current->mm, PAGE_SIZE);
+			for (; vma; vma = vma->vm_next) {
+				if (addr > limit)
+					break;
+				if (addr + len <= vma->vm_start)
+					goto success;
+				addr = vma->vm_end;
+			}
+		}
+	}
+
+	/* search from just above the WorkRAM area to the top of memory */
+	addr = PAGE_ALIGN(0x80000000);
+	limit = TASK_SIZE - len;
+	if (addr <= limit) {
+		vma = find_vma(current->mm, addr);
+		for (; vma; vma = vma->vm_next) {
+			if (addr > limit)
+				break;
+			if (addr + len <= vma->vm_start)
+				goto success;
+			addr = vma->vm_end;
+		}
+
+		if (!vma && addr <= limit)
+			goto success;
+	}
+
+#if 0
+	printk("[area] l=%lx (ENOMEM) f='%s'\n",
+	       len, filp ? filp->f_dentry->d_name.name : "");
+#endif
+	return -ENOMEM;
+
+ success:
+#if 0
+	printk("[area] l=%lx ad=%lx f='%s'\n",
+	       len, addr, filp ? filp->f_dentry->d_name.name : "");
+#endif
+	return addr;
+} /* end arch_get_unmapped_area() */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/extable.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/extable.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/extable.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/extable.c	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,91 @@
+/*
+ * linux/arch/frv/mm/extable.c
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <asm/uaccess.h>
+
+extern const struct exception_table_entry __attribute__((aligned(8))) __start___ex_table[];
+extern const struct exception_table_entry __attribute__((aligned(8))) __stop___ex_table[];
+extern const void __memset_end, __memset_user_error_lr, __memset_user_error_handler;
+extern const void __memcpy_end, __memcpy_user_error_lr, __memcpy_user_error_handler;
+extern spinlock_t modlist_lock;
+
+/*****************************************************************************/
+/*
+ *
+ */
+static inline unsigned long search_one_table(const struct exception_table_entry *first,
+					     const struct exception_table_entry *last,
+					     unsigned long value)
+{
+        while (first <= last) {
+		const struct exception_table_entry __attribute__((aligned(8))) *mid;
+		long diff;
+
+		mid = (last - first) / 2 + first;
+		diff = mid->insn - value;
+                if (diff == 0)
+                        return mid->fixup;
+                else if (diff < 0)
+                        first = mid + 1;
+                else
+                        last = mid - 1;
+        }
+        return 0;
+} /* end search_one_table() */
+
+/*****************************************************************************/
+/*
+ * see if there's a fixup handler available to deal with a kernel fault
+ */
+unsigned long search_exception_table(unsigned long pc)
+{
+	unsigned long ret = 0;
+
+	/* determine if the fault lay during a memcpy_user or a memset_user */
+	if (__frame->lr == (unsigned long) &__memset_user_error_lr &&
+	    (unsigned long) &memset <= pc && pc < (unsigned long) &__memset_end
+	    ) {
+		/* the fault occurred in a protected memset
+		 * - we search for the return address (in LR) instead of the program counter
+		 * - it was probably during a clear_user()
+		 */
+		return (unsigned long) &__memset_user_error_handler;
+	}
+	else if (__frame->lr == (unsigned long) &__memcpy_user_error_lr &&
+		 (unsigned long) &memcpy <= pc && pc < (unsigned long) &__memcpy_end
+		 ) {
+		/* the fault occurred in a protected memset
+		 * - we search for the return address (in LR) instead of the program counter
+		 * - it was probably during a copy_to/from_user()
+		 */
+		return (unsigned long) &__memcpy_user_error_handler;
+	}
+
+#ifndef CONFIG_MODULES
+	/* there is only the kernel to search.  */
+	ret = search_one_table(__start___ex_table, __stop___ex_table - 1, pc);
+	return ret;
+
+#else
+	/* the kernel is the last "module" -- no need to treat it special */
+	unsigned long flags;
+	struct module *mp;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+
+	for (mp = module_list; mp != NULL; mp = mp->next) {
+		if (mp->ex_table_start == NULL || !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+			continue;
+		ret = search_one_table(mp->ex_table_start, mp->ex_table_end - 1, pc);
+		if (ret)
+			break;
+	}
+
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	return ret;
+#endif
+} /* end search_exception_table() */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/fault.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/fault.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/fault.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/fault.c	2004-11-05 15:43:56.000000000 +0000
@@ -0,0 +1,323 @@
+/*
+ *  linux/arch/frv/mm/fault.c
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * - Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/m68knommu/mm/fault.c
+ *   - Copyright (C) 1998  D. Jeff Dionne <jeff@lineo.ca>,
+ *   - Copyright (C) 2000  Lineo, Inc.  (www.lineo.com)
+ *
+ *  Based on:
+ *
+ *  linux/arch/m68k/mm/fault.c
+ *
+ *  Copyright (C) 1995  Hamish Macdonald
+ */
+
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/hardirq.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/gdb-stub.h>
+
+/*****************************************************************************/
+/*
+ * This routine handles page faults.  It determines the problem, and
+ * then passes it off to one of the appropriate routines.
+ */
+asmlinkage void do_page_fault(int datammu, unsigned long esr0, unsigned long ear0)
+{
+	struct vm_area_struct *vma, *prev_vma;
+	struct mm_struct *mm;
+	unsigned long _pme, lrai, lrad, fixup;
+	siginfo_t info;
+	pml4_t *pml4e;
+	pgd_t *pge;
+	pte_t *pte;
+	int write;
+
+#if 0
+	const char *atxc[16] = {
+		[0x0] = "mmu-miss", [0x8] = "multi-dat", [0x9] = "multi-sat",
+		[0xa] = "tlb-miss", [0xc] = "privilege", [0xd] = "write-prot",
+	};
+
+	printk("do_page_fault(%d,%lx [%s],%lx)\n",
+	       datammu, esr0, atxc[esr0 >> 20 & 0xf], ear0);
+#endif
+
+	mm = current->mm;
+
+	/*
+	 * We fault-in kernel-space virtual memory on-demand. The
+	 * 'reference' page table is init_mm.pgd.
+	 *
+	 * NOTE! We MUST NOT take any locks for this case. We may
+	 * be in an interrupt or a critical region, and should
+	 * only copy the information from the master page table,
+	 * nothing more.
+	 *
+	 * This verifies that the fault happens in kernel space
+	 * and that the fault was a page not present (invalid) error
+	 */
+	if (!user_mode(__frame) && (esr0 & ESR0_ATXC) == ESR0_ATXC_AMRTLB_MISS) {
+		if (ear0 >= VMALLOC_START && ear0 < VMALLOC_END)
+			goto kernel_pte_fault;
+		if (ear0 >= PKMAP_BASE && ear0 < PKMAP_END)
+			goto kernel_pte_fault;
+	}
+
+	info.si_code = SEGV_MAPERR;
+
+	/*
+	 * If we're in an interrupt or have no user
+	 * context, we must not take the fault..
+	 */
+	if (in_interrupt() || !mm)
+		goto no_context;
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_vma(mm, ear0);
+	if (!vma)
+		goto bad_area;
+	if (vma->vm_start <= ear0)
+		goto good_area;
+	if (!(vma->vm_flags & VM_GROWSDOWN))
+		goto bad_area;
+
+	if (user_mode(__frame)) {
+		/*
+		 * accessing the stack below %esp is always a bug.
+		 * The "+ 32" is there due to some instructions (like
+		 * pusha) doing post-decrement on the stack and that
+		 * doesn't show up until later..
+		 */
+		if ((ear0 & PAGE_MASK) + 2 * PAGE_SIZE < __frame->sp) {
+#if 0
+			printk("[%d] ### Access below stack @%lx (sp=%lx)\n",
+			       current->pid, ear0, __frame->sp);
+			show_registers(__frame);
+			printk("[%d] ### Code: [%08lx] %02x %02x %02x %02x %02x %02x %02x %02x\n",
+			       current->pid,
+			       __frame->pc,
+			       ((u8*)__frame->pc)[0],
+			       ((u8*)__frame->pc)[1],
+			       ((u8*)__frame->pc)[2],
+			       ((u8*)__frame->pc)[3],
+			       ((u8*)__frame->pc)[4],
+			       ((u8*)__frame->pc)[5],
+			       ((u8*)__frame->pc)[6],
+			       ((u8*)__frame->pc)[7]
+			       );
+#endif
+			goto bad_area;
+		}
+	}
+
+	/* find_vma_prev is just a bit slower, because it cannot use
+	 * the mmap_cache, so we run it only in the growsdown slow
+	 * path and we leave find_vma in the fast path.
+	 */
+	find_vma_prev(current->mm, ear0, &prev_vma);
+	if (expand_stack(vma, ear0, prev_vma))
+		goto bad_area;
+
+/*
+ * Ok, we have a good vm_area for this memory access, so
+ * we can handle it..
+ */
+ good_area:
+	info.si_code = SEGV_ACCERR;
+	write = 0;
+	switch (esr0 & ESR0_ATXC) {
+	default:
+		/* handle write to write protected page */
+	case ESR0_ATXC_WP_EXCEP:
+#ifdef TEST_VERIFY_AREA
+		if (!(user_mode(__frame)))
+			printk("WP fault at %08lx\n", __frame->pc);
+#endif
+		if (!(vma->vm_flags & VM_WRITE))
+			goto bad_area;
+		write = 1;
+		break;
+
+		 /* handle read from protected page */
+	case ESR0_ATXC_PRIV_EXCEP:
+		goto bad_area;
+
+		 /* handle read, write or exec on absent page
+		  * - can't support write without permitting read
+		  * - don't support execute without permitting read and vice-versa
+		  */
+	case ESR0_ATXC_AMRTLB_MISS:
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
+			goto bad_area;
+		break;
+	}
+
+	/*
+	 * If for any reason at all we couldn't handle the fault,
+	 * make sure we exit gracefully rather than endlessly redo
+	 * the fault.
+	 */
+	switch (handle_mm_fault(mm, vma, ear0, write)) {
+	case 1:
+		current->min_flt++;
+		break;
+	case 2:
+		current->maj_flt++;
+		break;
+	case 0:
+		goto do_sigbus;
+	default:
+		goto out_of_memory;
+	}
+
+	up_read(&mm->mmap_sem);
+	return;
+
+/*
+ * Something tried to access memory that isn't in our memory map..
+ * Fix it, but check if it's kernel or user first..
+ */
+ bad_area:
+	up_read(&mm->mmap_sem);
+
+	/* User mode accesses just cause a SIGSEGV */
+	if (user_mode(__frame)) {
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		/* info.si_code has been set above */
+		info.si_addr = (void *) ear0;
+		force_sig_info(SIGSEGV, &info, current);
+		return;
+	}
+
+ no_context:
+	/* are we prepared to handle this kernel fault? */
+	if ((fixup = search_exception_table(__frame->pc)) != 0) {
+		__frame->pc = fixup;
+		return;
+	}
+
+/*
+ * Oops. The kernel tried to access some bad page. We'll have to
+ * terminate things with extreme prejudice.
+ */
+
+	bust_spinlocks(1);
+
+	if (ear0 < PAGE_SIZE)
+		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
+	else
+		printk(KERN_ALERT "Unable to handle kernel paging request");
+	printk(" at virtual addr %08lx\n", ear0);
+	printk("  PC  : %08lx\n", __frame->pc);
+	printk("  EXC : esr0=%08lx ear0=%08lx\n", esr0, ear0);
+
+	asm("lrai %1,%0,#1,#0,#0" : "=&r"(lrai) : "r"(ear0));
+	asm("lrad %1,%0,#1,#0,#0" : "=&r"(lrad) : "r"(ear0));
+
+	printk(KERN_ALERT "  LRAI: %08lx\n", lrai);
+	printk(KERN_ALERT "  LRAD: %08lx\n", lrad);
+
+	__break_hijack_kernel_event();
+
+	pml4e = pml4_offset(current->mm, ear0);
+	pge = pml4_pgd_offset(pml4e, ear0);
+	_pme = pge->pge[0].ste[0];
+
+	printk(KERN_ALERT "  PGE : %8p { PME %08lx }\n", pge, _pme);
+
+	if (_pme & xAMPRx_V) {
+		unsigned long dampr, damlr, val;
+
+		asm volatile("movsg dampr2,%0 ! movgs %2,dampr2 ! movsg damlr2,%1"
+			     : "=&r"(dampr), "=r"(damlr)
+			     : "r" (_pme | xAMPRx_L|xAMPRx_SS_16Kb|xAMPRx_S|xAMPRx_C|xAMPRx_V)
+			     );
+
+		pte = (pte_t *) damlr + __pte_index(ear0);
+		val = pte_val(*pte);
+
+		asm volatile("movgs %0,dampr2" :: "r" (dampr));
+
+		printk(KERN_ALERT "  PTE : %8p { %08lx }\n", pte, val);
+	}
+
+	die_if_kernel("Oops\n");
+	do_exit(SIGKILL);
+
+/*
+ * We ran out of memory, or some other thing happened to us that made
+ * us unable to handle the page fault gracefully.
+ */
+ out_of_memory:
+	up_read(&mm->mmap_sem);
+	printk("VM: killing process %s\n", current->comm);
+	if (user_mode(__frame))
+		do_exit(SIGKILL);
+	goto no_context;
+
+ do_sigbus:
+	up_read(&mm->mmap_sem);
+
+	/*
+	 * Send a sigbus, regardless of whether we were in kernel
+	 * or user mode.
+	 */
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code = BUS_ADRERR;
+	info.si_addr = (void *) ear0;
+	force_sig_info(SIGBUS, &info, current);
+
+	/* Kernel mode? Handle exceptions or die */
+	if (!user_mode(__frame))
+		goto no_context;
+	return;
+
+/*
+ * The fault was caused by a kernel PTE (such as installed by vmalloc or kmap)
+ */
+ kernel_pte_fault:
+	{
+		/*
+		 * Synchronize this task's top level page-table
+		 * with the 'reference' page table.
+		 *
+		 * Do _not_ use "tsk" here. We might be inside
+		 * an interrupt in the middle of a task switch..
+		 */
+		int index = pgd_index(ear0);
+		pgd_t *pgd, *pgd_k;
+		pmd_t *pmd, *pmd_k;
+		pte_t *pte_k;
+
+		pgd = (pgd_t *) __get_TTBR();
+		pgd = (pgd_t *)__va(pgd) + index;
+		pgd_k = ((pgd_t *)(init_mm.pml4)) + index;
+
+		if (!pgd_present(*pgd_k))
+			goto no_context;
+		set_pgd(pgd, *pgd_k);
+
+		pmd = pmd_offset(pgd, ear0);
+		pmd_k = pmd_offset(pgd_k, ear0);
+		if (!pmd_present(*pmd_k))
+			goto no_context;
+		set_pmd(pmd, *pmd_k);
+
+		pte_k = pte_offset(pmd_k, ear0);
+		if (!pte_present(*pte_k))
+			goto no_context;
+		return;
+	}
+} /* end do_page_fault() */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/highmem.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/highmem.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/highmem.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/highmem.c	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,33 @@
+/* highmem.c: arch-specific highmem stuff
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/highmem.h>
+
+void *kmap(struct page *page)
+{
+	might_sleep();
+	if (page < highmem_start_page)
+		return page_address(page);
+	return kmap_high(page);
+}
+
+void kunmap(struct page *page)
+{
+	if (in_interrupt())
+		BUG();
+	if (page < highmem_start_page)
+		return;
+	kunmap_high(page);
+}
+
+struct page *kmap_atomic_to_page(void *ptr)
+{
+	return virt_to_page(ptr);
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/init.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/init.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/init.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/init.c	2004-11-05 14:52:13.000000000 +0000
@@ -0,0 +1,244 @@
+/* init.c: memory initialisation for FRV
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Derived from:
+ *  - linux/arch/m68knommu/mm/init.c
+ *    - Copyright (C) 1998  D. Jeff Dionne <jeff@lineo.ca>, Kenneth Albanowski <kjahds@kjahds.com>,
+ *    - Copyright (C) 2000  Lineo, Inc.  (www.lineo.com) 
+ *  - linux/arch/m68k/mm/init.c
+ *    - Copyright (C) 1995  Hamish Macdonald
+ */
+
+#include <linux/config.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/bootmem.h>
+#include <linux/highmem.h>
+
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+#include <asm/virtconvert.h>
+#include <asm/sections.h>
+#include <asm/tlb.h>
+
+#undef DEBUG
+
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+
+/*
+ * BAD_PAGE is the page that is used for page faults when linux
+ * is out-of-memory. Older versions of linux just did a
+ * do_exit(), but using this instead means there is less risk
+ * for a process dying in kernel mode, possibly leaving a inode
+ * unused etc..
+ *
+ * BAD_PAGETABLE is the accompanying page-table: it is initialized
+ * to point to BAD_PAGE entries.
+ *
+ * ZERO_PAGE is a special page that is used for zero-initialized
+ * data and COW.
+ */
+static unsigned long empty_bad_page_table;
+static unsigned long empty_bad_page;
+unsigned long empty_zero_page;
+
+/*****************************************************************************/
+/*
+ * 
+ */
+void show_mem(void)
+{
+	unsigned long i;
+	int free = 0, total = 0, reserved = 0, shared = 0;
+
+	printk("\nMem-info:\n");
+	show_free_areas();
+	i = max_mapnr;
+	while (i-- > 0) {
+		struct page *page = &mem_map[i];
+
+		total++;
+		if (PageReserved(page))
+			reserved++;
+		else if (!page_count(page))
+			free++;
+		else
+			shared += page_count(page) - 1;
+	}
+
+	printk("%d pages of RAM\n",total);
+	printk("%d free pages\n",free);
+	printk("%d reserved pages\n",reserved);
+	printk("%d pages shared\n",shared);
+
+} /* end show_mem() */
+
+/*****************************************************************************/
+/*
+ * paging_init() continues the virtual memory environment setup which
+ * was begun by the code in arch/head.S.
+ * The parameters are pointers to where to stick the starting and ending
+ * addresses  of available kernel virtual memory.
+ */
+void __init paging_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+
+	/* allocate some pages for kernel housekeeping tasks */
+	empty_bad_page_table	= (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
+	empty_bad_page		= (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
+	empty_zero_page		= (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
+
+	memset((void *) empty_zero_page, 0, PAGE_SIZE);
+
+#if CONFIG_HIGHMEM
+	if (num_physpages - num_mappedpages) {
+		pgd_t *pge;
+		pmd_t *pme;
+
+		pkmap_page_table = alloc_bootmem_pages(PAGE_SIZE);
+
+		memset(pkmap_page_table, 0, PAGE_SIZE);
+
+		pge = swapper_pg_dir + pgd_index_k(PKMAP_BASE);
+		pme = pmd_offset(pge, PKMAP_BASE);
+		__set_pmd(pme, virt_to_phys(pkmap_page_table) | _PAGE_TABLE);
+	}
+#endif
+
+	/* distribute the allocatable pages across the various zones and pass them to the allocator
+	 */
+	zones_size[ZONE_DMA]     = 0 >> PAGE_SHIFT;
+	zones_size[ZONE_NORMAL]  = max_low_pfn - min_low_pfn;
+#ifdef CONFIG_HIGHMEM
+	zones_size[ZONE_HIGHMEM] = num_physpages - num_mappedpages;
+#endif
+
+	free_area_init(zones_size);
+
+#ifdef CONFIG_MMU
+	/* high memory (if present) starts after the last mapped page
+	 * - this is used by kmap()
+	 */
+	highmem_start_page = mem_map + num_mappedpages;
+
+	/* initialise init's MMU context */
+	init_new_context(&init_task, &init_mm);
+#endif
+
+} /* end paging_init() */
+
+/*****************************************************************************/
+/*
+ * 
+ */
+void __init mem_init(void)
+{
+	unsigned long npages = (memory_end - memory_start) >> PAGE_SHIFT;
+	unsigned long tmp;
+#ifdef CONFIG_MMU
+	unsigned long loop, pfn;
+	int datapages = 0;
+#endif
+	int codek = 0, datak = 0;
+
+	/* this will put all memory onto the freelists */
+	totalram_pages = free_all_bootmem();
+
+#ifdef CONFIG_MMU
+	for (loop = 0 ; loop < npages ; loop++)
+		if (PageReserved(&mem_map[loop]))
+			datapages++;
+
+#ifdef CONFIG_HIGHMEM
+	for (pfn = num_physpages - 1; pfn >= num_mappedpages; pfn--) {
+		struct page *page = &mem_map[pfn];
+
+		ClearPageReserved(page);
+		set_bit(PG_highmem, &page->flags);
+		set_page_count(page, 1);
+		__free_page(page);
+		totalram_pages++;
+	}
+#endif
+	
+	codek = ((unsigned long) &_etext - (unsigned long) &_stext) >> 10;
+	datak = datapages << (PAGE_SHIFT - 10);
+
+#else
+	codek = (_etext - _stext) >> 10;
+	datak = 0; //(_ebss - _sdata) >> 10;
+#endif
+
+	tmp = nr_free_pages() << PAGE_SHIFT;
+	printk("Memory available: %luKiB/%luKiB RAM, %luKiB/%luKiB ROM (%dKiB kernel code, %dKiB data)\n",
+	       tmp >> 10,
+	       npages << (PAGE_SHIFT - 10),
+	       (rom_length > 0) ? ((rom_length >> 10) - codek) : 0,
+	       rom_length >> 10,
+	       codek,
+	       datak
+	       );
+
+} /* end mem_init() */
+
+/*****************************************************************************/
+/*
+ * free the memory that was only required for initialisation
+ */
+void __init free_initmem(void)
+{
+#if defined(CONFIG_RAMKERNEL) && !defined(CONFIG_PROTECT_KERNEL)
+	unsigned long start, end, addr;
+
+	start = PAGE_ALIGN((unsigned long) &__init_begin);	/* round up */
+	end   = ((unsigned long) &__init_end) & PAGE_MASK;	/* round down */
+
+	/* next to check that the page we free is not a partial page */
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(addr));
+		set_page_count(virt_to_page(addr), 1);
+		free_page(addr);
+		totalram_pages++;
+	}
+
+	printk("Freeing unused kernel memory: %ldKiB freed (0x%lx - 0x%lx)\n",
+	       (end - start) >> 10, start, end);
+#endif
+} /* end free_initmem() */
+
+/*****************************************************************************/
+/*
+ * free the initial ramdisk memory
+ */
+#ifdef CONFIG_BLK_DEV_INITRD
+void __init free_initrd_mem(unsigned long start, unsigned long end)
+{
+	int pages = 0;
+	for (; start < end; start += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(start));
+		set_page_count(virt_to_page(start), 1);
+		free_page(start);
+		totalram_pages++;
+		pages++;
+	}
+	printk("Freeing initrd memory: %dKiB freed\n", (pages * PAGE_SIZE) >> 10);
+} /* end free_initrd_mem() */
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/kmap.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/kmap.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/kmap.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/kmap.c	2004-11-05 14:13:03.385539521 +0000
@@ -0,0 +1,56 @@
+/*
+ *  linux/arch/m68knommu/mm/kmap.c
+ *
+ *  Copyright (C) 2000 Lineo, <davidm@lineo.com>
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/io.h>
+#include <asm/system.h>
+
+#undef DEBUG
+
+/*****************************************************************************/
+/*
+ * Map some physical address range into the kernel address space.
+ */
+
+void *__ioremap(unsigned long physaddr, unsigned long size, int cacheflag)
+{
+	return (void *)physaddr;
+}
+
+/*
+ * Unmap a ioremap()ed region again
+ */
+void iounmap(void *addr)
+{
+}
+
+/*
+ * __iounmap unmaps nearly everything, so be careful
+ * it doesn't free currently pointer/page tables anymore but it
+ * wans't used anyway and might be added later.
+ */
+void __iounmap(void *addr, unsigned long size)
+{
+}
+
+/*
+ * Set new cache mode for some kernel address space.
+ * The caller must push data for that range itself, if such data may already
+ * be in the cache.
+ */
+void kernel_set_cachemode(void *addr, unsigned long size, int cmode)
+{
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/Makefile linux-2.6.10-rc1-mm3-frv/arch/frv/mm/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/Makefile	2004-11-05 14:13:03.388539268 +0000
@@ -0,0 +1,9 @@
+#
+# Makefile for the arch-specific parts of the memory manager.
+#
+
+obj-y := init.o kmap.o
+
+obj-$(CONFIG_MMU) += \
+	pgalloc.o highmem.o fault.o extable.o cache-page.o tlb-flush.o tlb-miss.o \
+	mmu-context.o dma-alloc.o unaligned.o elf-fdpic.o
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/mmu-context.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/mmu-context.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/mmu-context.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/mmu-context.c	2004-11-05 15:59:15.000000000 +0000
@@ -0,0 +1,210 @@
+/* mmu-context.c: MMU context allocation and management
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/tlbflush.h>
+
+#define NR_CXN	4096
+
+static unsigned long cxn_bitmap[NR_CXN / (sizeof(unsigned long) * 8)];
+static LIST_HEAD(cxn_owners_lru);
+static spinlock_t cxn_owners_lock = SPIN_LOCK_UNLOCKED;
+
+int __nongpreldata cxn_pinned = -1;
+
+
+/*****************************************************************************/
+/*
+ * initialise a new context
+ */
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	memset(&mm->context, 0, sizeof(mm->context));
+	INIT_LIST_HEAD(&mm->context.id_link);
+	mm->context.itlb_cached_pge = 0xffffffffUL;
+	mm->context.dtlb_cached_pge = 0xffffffffUL;
+
+	return 0;
+} /* end init_new_context() */
+
+/*****************************************************************************/
+/*
+ * make sure a kernel MMU context has a CPU context number
+ * - call with cxn_owners_lock held
+ */
+static unsigned get_cxn(mm_context_t *ctx)
+{
+	struct list_head *_p;
+	mm_context_t *p;
+	unsigned cxn;
+
+	if (!list_empty(&ctx->id_link)) {
+		list_move_tail(&ctx->id_link, &cxn_owners_lru);
+	}
+	else {
+		/* find the first unallocated context number
+		 * - 0 is reserved for the kernel
+		 */
+		cxn = find_next_zero_bit(&cxn_bitmap, NR_CXN, 1);
+		if (cxn < NR_CXN) {
+			set_bit(cxn, &cxn_bitmap);
+		}
+		else {
+			/* none remaining - need to steal someone else's cxn */
+			p = NULL;
+			list_for_each(_p, &cxn_owners_lru) {
+				p = list_entry(_p, mm_context_t, id_link);
+				if (!p->id_busy && p->id != cxn_pinned)
+					break;
+			}
+
+			BUG_ON(_p == &cxn_owners_lru);
+
+			cxn = p->id;
+			p->id = 0;
+			list_del_init(&p->id_link);
+			__flush_tlb_mm(cxn);
+		}
+
+		ctx->id = cxn;
+		list_add_tail(&ctx->id_link, &cxn_owners_lru);
+	}
+
+	return ctx->id;
+} /* end get_cxn() */
+
+/*****************************************************************************/
+/*
+ * restore the current TLB miss handler mapped page tables into the MMU context and set up a
+ * mapping for the page directory
+ */
+void change_mm_context(mm_context_t *old, mm_context_t *ctx, pml4_t *pml4)
+{
+	unsigned long _pgd;
+	pgd_t *pgd;
+
+	pgd = pml4_pgd_offset(pml4, 0);
+	_pgd = virt_to_phys(pgd);
+
+	/* save the state of the outgoing MMU context */
+	old->id_busy = 0;
+
+	asm volatile("movsg scr0,%0"   : "=r"(old->itlb_cached_pge));
+	asm volatile("movsg dampr4,%0" : "=r"(old->itlb_ptd_mapping));
+	asm volatile("movsg scr1,%0"   : "=r"(old->dtlb_cached_pge));
+	asm volatile("movsg dampr5,%0" : "=r"(old->dtlb_ptd_mapping));
+
+	/* select an MMU context number */
+	spin_lock(&cxn_owners_lock);
+	get_cxn(ctx);
+	ctx->id_busy = 1;
+	spin_unlock(&cxn_owners_lock);
+
+	asm volatile("movgs %0,cxnr"   : : "r"(ctx->id));
+
+	/* restore the state of the incoming MMU context */
+	asm volatile("movgs %0,scr0"   : : "r"(ctx->itlb_cached_pge));
+	asm volatile("movgs %0,dampr4" : : "r"(ctx->itlb_ptd_mapping));
+	asm volatile("movgs %0,scr1"   : : "r"(ctx->dtlb_cached_pge));
+	asm volatile("movgs %0,dampr5" : : "r"(ctx->dtlb_ptd_mapping));
+
+	/* map the PGD into uncached virtual memory */
+	asm volatile("movgs %0,ttbr"   : : "r"(_pgd));
+	asm volatile("movgs %0,dampr3"
+		     :: "r"(_pgd | xAMPRx_L | xAMPRx_M | xAMPRx_SS_16Kb |
+			    xAMPRx_S | xAMPRx_C | xAMPRx_V));
+
+} /* end change_mm_context() */
+
+/*****************************************************************************/
+/*
+ * finished with an MMU context number
+ */
+void destroy_context(struct mm_struct *mm)
+{
+	mm_context_t *ctx = &mm->context;
+
+	spin_lock(&cxn_owners_lock);
+
+	if (!list_empty(&ctx->id_link)) {
+		if (ctx->id == cxn_pinned)
+			cxn_pinned = -1;
+
+		list_del_init(&ctx->id_link);
+		clear_bit(ctx->id, &cxn_bitmap);
+		__flush_tlb_mm(ctx->id);
+		ctx->id = 0;
+	}
+
+	spin_unlock(&cxn_owners_lock);
+} /* end destroy_context() */
+
+/*****************************************************************************/
+/*
+ * display the MMU context currently a process is currently using
+ */
+#ifdef CONFIG_PROC_FS
+char *proc_pid_status_frv_cxnr(struct mm_struct *mm, char *buffer)
+{
+	spin_lock(&cxn_owners_lock);
+	buffer += sprintf(buffer, "CXNR: %u\n", mm->context.id);
+	spin_unlock(&cxn_owners_lock);
+
+	return buffer;
+} /* end proc_pid_status_frv_cxnr() */
+#endif
+
+/*****************************************************************************/
+/*
+ * (un)pin a process's mm_struct's MMU context ID
+ */
+int cxn_pin_by_pid(pid_t pid)
+{
+	struct task_struct *tsk;
+	struct mm_struct *mm = NULL;
+	int ret;
+
+	/* unpin if pid is zero */
+	if (pid == 0) {
+		cxn_pinned = -1;
+		return 0;
+	}
+
+	ret = -ESRCH;
+
+	/* get a handle on the mm_struct */
+	read_lock(&tasklist_lock);
+	tsk = find_task_by_pid(pid);
+	if (tsk) {
+		ret = -EINVAL;
+
+		task_lock(tsk);
+		if (tsk->mm) {
+			mm = tsk->mm;
+			atomic_inc(&mm->mm_users);
+			ret = 0;
+		}
+		task_unlock(tsk);
+	}
+	read_unlock(&tasklist_lock);
+
+	if (ret < 0)
+		return ret;
+
+	/* make sure it has a CXN and pin it */
+	spin_lock(&cxn_owners_lock);
+	cxn_pinned = get_cxn(&mm->context);
+	spin_unlock(&cxn_owners_lock);
+
+	mmput(mm);
+	return 0;
+} /* end cxn_pin_by_pid() */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/pgalloc.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/pgalloc.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/pgalloc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/pgalloc.c	2004-11-05 15:28:55.000000000 +0000
@@ -0,0 +1,159 @@
+/* pgalloc.c: page directory & page table allocation
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <asm/pgalloc.h>
+#include <asm/page.h>
+#include <asm/cacheflush.h>
+
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((aligned(PAGE_SIZE)));
+kmem_cache_t *pgd_cache;
+
+pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	if (pte)
+		clear_page(pte);
+	return pte;
+}
+
+struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page *page;
+
+#ifdef CONFIG_HIGHPTE
+	page = alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT, 0);
+#else
+	page = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+#endif
+	if (page)
+		clear_highpage(page);
+	flush_dcache_page(page);
+	return page;
+}
+
+void __set_pmd(pmd_t *pmdptr, unsigned long pmd)
+{
+	unsigned long *__ste_p = pmdptr->ste;
+	int loop;
+
+	if (!pmd) {
+		memset(__ste_p, 0, PME_SIZE);
+	}
+	else {
+		BUG_ON(pmd & xAMPRx_SS);
+
+		for (loop = PME_SIZE; loop > 0; loop -= 4) {
+			*__ste_p++ = pmd;
+			pmd += __frv_PT_SIZE;
+		}
+	}
+
+	frv_dcache_writeback((unsigned long) pmdptr, (unsigned long) (pmdptr + 1));
+}
+
+/*
+ * List of all pgd's needed for non-PAE so it can invalidate entries
+ * in both cached and uncached pgd's; not needed for PAE since the
+ * kernel pmd is shared. If PAE were not to share the pmd a similar
+ * tactic would be needed. This is essentially codepath-based locking
+ * against pageattr.c; it is the unique case in which a valid change
+ * of kernel pagetables can't be lazily synchronized by vmalloc faults.
+ * vmalloc faults work because attached pagetables are never freed.
+ * If the locking proves to be non-performant, a ticketing scheme with
+ * checks at dup_mmap(), exec(), and other mmlist addition points
+ * could be used. The locking scheme was chosen on the basis of
+ * manfred's recommendations and having no core impact whatsoever.
+ * -- wli
+ */
+spinlock_t pgd_lock = SPIN_LOCK_UNLOCKED;
+struct page *pgd_list;
+
+static inline void pgd_list_add(pgd_t *pgd)
+{
+	struct page *page = virt_to_page(pgd);
+	page->index = (unsigned long) pgd_list;
+	if (pgd_list)
+		pgd_list->private = (unsigned long) &page->index;
+	pgd_list = page;
+	page->private = (unsigned long) &pgd_list;
+}
+
+static inline void pgd_list_del(pgd_t *pgd)
+{
+	struct page *next, **pprev, *page = virt_to_page(pgd);
+	next = (struct page *) page->index;
+	pprev = (struct page **) page->private;
+	*pprev = next;
+	if (next)
+		next->private = (unsigned long) pprev;
+}
+
+void pgd_ctor(void *pgd, kmem_cache_t *cache, unsigned long unused)
+{
+	unsigned long flags;
+
+	if (PTRS_PER_PMD == 1)
+		spin_lock_irqsave(&pgd_lock, flags);
+
+	memcpy((pgd_t *) pgd + USER_PGDS_IN_LAST_PML4,
+	       swapper_pg_dir + USER_PGDS_IN_LAST_PML4,
+	       (PTRS_PER_PGD - USER_PGDS_IN_LAST_PML4) * sizeof(pgd_t));
+
+	if (PTRS_PER_PMD > 1)
+		return;
+
+	pgd_list_add(pgd);
+	spin_unlock_irqrestore(&pgd_lock, flags);
+	memset(pgd, 0, USER_PGDS_IN_LAST_PML4 * sizeof(pgd_t));
+}
+
+/* never called when PTRS_PER_PMD > 1 */
+void pgd_dtor(void *pgd, kmem_cache_t *cache, unsigned long unused)
+{
+	unsigned long flags; /* can be called from interrupt context */
+
+	spin_lock_irqsave(&pgd_lock, flags);
+	pgd_list_del(pgd);
+	spin_unlock_irqrestore(&pgd_lock, flags);
+}
+
+pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
+{
+	pgd_t *pgd;
+
+	pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
+	if (!pgd)
+		return pgd;
+
+	return pgd;
+}
+
+void pgd_free(pgd_t *pgd)
+{
+	/* in the non-PAE case, clear_page_tables() clears user pgd entries */
+	kmem_cache_free(pgd_cache, pgd);
+}
+
+void __init pgtable_cache_init(void)
+{
+	pgd_cache = kmem_cache_create("pgd",
+				      PTRS_PER_PGD * sizeof(pgd_t),
+				      PTRS_PER_PGD * sizeof(pgd_t),
+				      0,
+				      pgd_ctor,
+				      pgd_dtor);
+	if (!pgd_cache)
+		panic("pgtable_cache_init(): Cannot create pgd cache");
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/tlb-flush.S linux-2.6.10-rc1-mm3-frv/arch/frv/mm/tlb-flush.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/tlb-flush.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/tlb-flush.S	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,185 @@
+/* tlb-flush.S: TLB flushing routines
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sys.h>
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/page.h>
+#include <asm/ptrace.h>
+#include <asm/spr-regs.h>
+
+.macro DEBUG ch
+#	sethi.p		%hi(0xfeff9c00),gr4
+#	setlo		%lo(0xfeff9c00),gr4
+#	setlos		#\ch,gr5
+#	stbi		gr5,@(gr4,#0)
+#	membar
+.endm
+
+	.section	.rodata
+
+	# sizes corresponding to TPXR.LMAX
+	.balign		1
+__tlb_lmax_sizes:
+	.byte		0, 64, 0, 0
+	.byte		0, 0, 0, 0
+	.byte		0, 0, 0, 0
+	.byte		0, 0, 0, 0
+
+	.section	.text
+	.balign		4
+
+###############################################################################
+#
+# flush everything
+# - void __flush_tlb_all(void)
+#
+###############################################################################
+	.globl		__flush_tlb_all
+	.type		__flush_tlb_all,@function
+__flush_tlb_all:
+	DEBUG		'A'
+
+	# kill cached PGE value
+	setlos		#0xffffffff,gr4
+	movgs		gr4,scr0
+	movgs		gr4,scr1
+
+	# kill AMPR-cached TLB values
+	movgs		gr0,iamlr1
+	movgs		gr0,iampr1
+	movgs		gr0,damlr1
+	movgs		gr0,dampr1
+
+	# find out how many lines there are
+	movsg		tpxr,gr5
+	sethi.p		%hi(__tlb_lmax_sizes),gr4
+	srli		gr5,#TPXR_LMAX_SHIFT,gr5
+	setlo.p		%lo(__tlb_lmax_sizes),gr4
+	andi		gr5,#TPXR_LMAX_SMASK,gr5
+	ldub		@(gr4,gr5),gr4
+
+	# now, we assume that the TLB line step is page size in size
+	setlos.p	#PAGE_SIZE,gr5
+	setlos		#0,gr6
+1:
+	tlbpr		gr6,gr0,#6,#0
+	subicc.p	gr4,#1,gr4,icc0
+	add		gr6,gr5,gr6
+	bne		icc0,#2,1b
+
+	DEBUG		'B'
+	bralr
+
+	.size		__flush_tlb_all, .-__flush_tlb_all
+
+###############################################################################
+#
+# flush everything to do with one context
+# - void __flush_tlb_mm(unsigned long contextid [GR8])
+#
+###############################################################################
+	.globl		__flush_tlb_mm
+	.type		__flush_tlb_mm,@function
+__flush_tlb_mm:
+	DEBUG		'M'
+
+	# kill cached PGE value
+	setlos		#0xffffffff,gr4
+	movgs		gr4,scr0
+	movgs		gr4,scr1
+
+	# specify the context we want to flush
+	movgs		gr8,tplr
+
+	# find out how many lines there are
+	movsg		tpxr,gr5
+	sethi.p		%hi(__tlb_lmax_sizes),gr4
+	srli		gr5,#TPXR_LMAX_SHIFT,gr5
+	setlo.p		%lo(__tlb_lmax_sizes),gr4
+	andi		gr5,#TPXR_LMAX_SMASK,gr5
+	ldub		@(gr4,gr5),gr4
+
+	# now, we assume that the TLB line step is page size in size
+	setlos.p	#PAGE_SIZE,gr5
+	setlos		#0,gr6
+0:
+	tlbpr		gr6,gr0,#5,#0
+	subicc.p	gr4,#1,gr4,icc0
+	add		gr6,gr5,gr6
+	bne		icc0,#2,0b
+
+	DEBUG		'N'
+	bralr
+
+	.size		__flush_tlb_mm, .-__flush_tlb_mm
+
+###############################################################################
+#
+# flush a range of addresses from the TLB
+# - void __flush_tlb_page(unsigned long contextid [GR8],
+#			  unsigned long start [GR9])
+#
+###############################################################################
+	.globl		__flush_tlb_page
+	.type		__flush_tlb_page,@function
+__flush_tlb_page:
+	# kill cached PGE value
+	setlos		#0xffffffff,gr4
+	movgs		gr4,scr0
+	movgs		gr4,scr1
+
+	# specify the context we want to flush
+	movgs		gr8,tplr
+
+	# zap the matching TLB line and AMR values
+	setlos		#~(PAGE_SIZE-1),gr5
+	and		gr9,gr5,gr9
+	tlbpr		gr9,gr0,#5,#0
+
+	bralr
+
+	.size		__flush_tlb_page, .-__flush_tlb_page
+
+###############################################################################
+#
+# flush a range of addresses from the TLB
+# - void __flush_tlb_range(unsigned long contextid [GR8],
+#			   unsigned long start [GR9],
+#			   unsigned long end [GR10])
+#
+###############################################################################
+	.globl		__flush_tlb_range
+	.type		__flush_tlb_range,@function
+__flush_tlb_range:
+	# kill cached PGE value
+	setlos		#0xffffffff,gr4
+	movgs		gr4,scr0
+	movgs		gr4,scr1
+
+	# specify the context we want to flush
+	movgs		gr8,tplr
+
+	# round the start down to beginning of TLB line and end up to beginning of next TLB line
+	setlos.p	#~(PAGE_SIZE-1),gr5
+	setlos		#PAGE_SIZE,gr6
+	subi.p		gr10,#1,gr10
+	and		gr9,gr5,gr9
+	and		gr10,gr5,gr10
+2:
+	tlbpr		gr9,gr0,#5,#0
+	subcc.p		gr9,gr10,gr0,icc0
+	add		gr9,gr6,gr9
+	bne		icc0,#0,2b		; most likely a 1-page flush
+
+	bralr
+
+	.size		__flush_tlb_range, .-__flush_tlb_range
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/tlb-miss.S linux-2.6.10-rc1-mm3-frv/arch/frv/mm/tlb-miss.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/tlb-miss.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/tlb-miss.S	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,631 @@
+/* tlb-miss.S: TLB miss handlers
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sys.h>
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/highmem.h>
+#include <asm/spr-regs.h>
+
+	.section	.text
+	.balign		4
+
+	.globl		__entry_insn_mmu_miss
+__entry_insn_mmu_miss:
+	break
+	nop
+
+	.globl		__entry_insn_mmu_exception
+__entry_insn_mmu_exception:
+	break
+	nop
+
+	.globl		__entry_data_mmu_miss
+__entry_data_mmu_miss:
+	break
+	nop
+
+	.globl		__entry_data_mmu_exception
+__entry_data_mmu_exception:
+	break
+	nop
+
+###############################################################################
+#
+# handle a lookup failure of one sort or another in a kernel TLB handler
+# On entry:
+#   GR29 - faulting address
+#   SCR2 - saved CCR
+#
+###############################################################################
+	.type		__tlb_kernel_fault,@function
+__tlb_kernel_fault:
+	# see if we're supposed to re-enable single-step mode upon return
+	sethi.p		%hi(__break_tlb_miss_return_break),gr30
+	setlo		%lo(__break_tlb_miss_return_break),gr30
+	movsg		pcsr,gr31
+
+	subcc		gr31,gr30,gr0,icc0
+	beq		icc0,#0,__tlb_kernel_fault_sstep
+
+	movsg		scr2,gr30
+	movgs		gr30,ccr
+	movgs		gr29,scr2			/* save EAR0 value */
+	sethi.p		%hi(__kernel_current_task),gr29
+	setlo		%lo(__kernel_current_task),gr29
+	ldi.p		@(gr29,#0),gr29			/* restore GR29 */
+
+	bra		__entry_kernel_handle_mmu_fault
+
+	# we've got to re-enable single-stepping
+__tlb_kernel_fault_sstep:
+	sethi.p		%hi(__break_tlb_miss_real_return_info),gr30
+	setlo		%lo(__break_tlb_miss_real_return_info),gr30
+	lddi		@(gr30,0),gr30
+	movgs		gr30,pcsr
+	movgs		gr31,psr
+
+	movsg		scr2,gr30
+	movgs		gr30,ccr
+	movgs		gr29,scr2			/* save EAR0 value */
+	sethi.p		%hi(__kernel_current_task),gr29
+	setlo		%lo(__kernel_current_task),gr29
+	ldi.p		@(gr29,#0),gr29			/* restore GR29 */
+	bra		__entry_kernel_handle_mmu_fault_sstep
+	
+	.size		__tlb_kernel_fault, .-__tlb_kernel_fault
+
+###############################################################################
+#
+# handle a lookup failure of one sort or another in a user TLB handler
+# On entry:
+#   GR28 - faulting address
+#   SCR2 - saved CCR
+#
+###############################################################################
+	.type		__tlb_user_fault,@function
+__tlb_user_fault:
+	# see if we're supposed to re-enable single-step mode upon return
+	sethi.p		%hi(__break_tlb_miss_return_break),gr30
+	setlo		%lo(__break_tlb_miss_return_break),gr30
+	movsg		pcsr,gr31
+	subcc		gr31,gr30,gr0,icc0
+	beq		icc0,#0,__tlb_user_fault_sstep
+
+	movsg		scr2,gr30
+	movgs		gr30,ccr
+	bra		__entry_uspace_handle_mmu_fault
+
+	# we've got to re-enable single-stepping
+__tlb_user_fault_sstep:
+	sethi.p		%hi(__break_tlb_miss_real_return_info),gr30
+	setlo		%lo(__break_tlb_miss_real_return_info),gr30
+	lddi		@(gr30,0),gr30
+	movgs		gr30,pcsr
+	movgs		gr31,psr
+	movsg		scr2,gr30
+	movgs		gr30,ccr
+	bra		__entry_uspace_handle_mmu_fault_sstep
+
+	.size		__tlb_user_fault, .-__tlb_user_fault
+
+###############################################################################
+#
+# Kernel instruction TLB miss handler
+# On entry:
+#   GR1   - kernel stack pointer
+#   GR28  - saved exception frame pointer
+#   GR29  - faulting address
+#   GR31  - EAR0 ^ SCR0
+#   SCR0  - base of virtual range covered by cached PGE from last ITLB miss (or 0xffffffff)
+#   DAMR3 - mapped page directory
+#   DAMR4 - mapped page table as matched by SCR0
+#
+###############################################################################
+	.globl		__entry_kernel_insn_tlb_miss
+	.type		__entry_kernel_insn_tlb_miss,@function
+__entry_kernel_insn_tlb_miss:
+#if 0
+	sethi.p		%hi(0xe1200004),gr30
+	setlo		%lo(0xe1200004),gr30
+	st		gr0,@(gr30,gr0)
+	sethi.p		%hi(0xffc00100),gr30
+	setlo		%lo(0xffc00100),gr30
+	sth		gr30,@(gr30,gr0)
+	membar
+#endif
+
+	movsg		ccr,gr30			/* save CCR */
+	movgs		gr30,scr2
+
+	# see if the cached page table mapping is appropriate
+	srlicc.p	gr31,#26,gr0,icc0
+	setlos		0x3ffc,gr30
+	srli.p		gr29,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bne		icc0,#0,__itlb_k_PTD_miss
+
+__itlb_k_PTD_mapped:
+	# access the PTD with EAR0[25:14]
+	# - DAMLR4 points to the virtual address of the appropriate page table
+	# - the PTD holds 4096 PTEs
+	# - the PTD must be accessed uncached
+	# - the PTE must be marked accessed if it was valid
+	#
+	and		gr31,gr30,gr31
+	movsg		damlr4,gr30
+	add		gr30,gr31,gr31
+	ldi		@(gr31,#0),gr30			/* fetch the PTE */
+	andicc		gr30,#_PAGE_PRESENT,gr0,icc0
+	ori.p		gr30,#_PAGE_ACCESSED,gr30
+	beq		icc0,#0,__tlb_kernel_fault	/* jump if PTE invalid */
+	sti.p		gr30,@(gr31,#0)			/* update the PTE */
+	andi		gr30,#~_PAGE_ACCESSED,gr30
+
+	# we're using IAMR1 as an extra TLB entry
+	# - punt the entry here (if valid) to the real TLB and then replace with the new PTE
+	# - need to check DAMR1 lest we cause an multiple-DAT-hit exception
+	# - IAMPR1 has no WP bit, and we mustn't lose WP information
+	movsg		iampr1,gr31
+	andicc		gr31,#xAMPRx_V,gr0,icc0
+	setlos.p	0xfffff000,gr31
+	beq		icc0,#0,__itlb_k_nopunt		/* punt not required */
+
+	movsg		iamlr1,gr31
+	movgs		gr31,tplr			/* set TPLR.CXN */
+	tlbpr		gr31,gr0,#4,#0			/* delete matches from TLB, IAMR1, DAMR1 */
+
+	movsg		iampr1,gr31
+	ori		gr31,#xAMPRx_V|DAMPRx_WP,gr31	/* entry was invalidated by tlbpr #4 */
+	movgs		gr31,tppr
+	movsg		iamlr1,gr31			/* set TPLR.CXN */
+	movgs		gr31,tplr
+	tlbpr		gr31,gr0,#2,#0			/* save to the TLB */
+	movsg		tpxr,gr31			/* check the TLB write error flag */
+	andicc.p	gr31,#TPXR_E,gr0,icc0
+	setlos		#0xfffff000,gr31
+	bne		icc0,#0,__tlb_kernel_fault
+
+__itlb_k_nopunt:
+
+	# assemble the new TLB entry
+	and		gr29,gr31,gr29
+	movsg		cxnr,gr31
+	or		gr29,gr31,gr29
+	movgs		gr29,iamlr1			/* xAMLR = address | context number */
+	movgs		gr30,iampr1
+	movgs		gr29,damlr1
+	movgs		gr30,dampr1
+
+	# return, restoring registers
+	movsg		scr2,gr30
+	movgs		gr30,ccr
+	sethi.p		%hi(__kernel_current_task),gr29
+	setlo		%lo(__kernel_current_task),gr29
+	ldi		@(gr29,#0),gr29
+	rett		#0
+	beq		icc0,#3,0			/* prevent icache prefetch */
+
+	# the PTE we want wasn't in the PTD we have mapped, so we need to go looking for a more
+	# appropriate page table and map that instead
+	#   - access the PGD with EAR0[31:26]
+	#   - DAMLR3 points to the virtual address of the page directory
+	#   - the PGD holds 64 PGEs and each PGE/PME points to a set of page tables
+__itlb_k_PTD_miss:
+	srli		gr29,#26,gr31			/* calculate PGE offset */
+	slli		gr31,#8,gr31			/* and clear bottom bits */
+
+	movsg		damlr3,gr30
+	ld		@(gr31,gr30),gr30		/* access the PGE */
+
+	andicc.p	gr30,#_PAGE_PRESENT,gr0,icc0
+	andicc		gr30,#xAMPRx_SS,gr0,icc1
+
+	# map this PTD instead and record coverage address
+	ori.p		gr30,#xAMPRx_L|xAMPRx_SS_16Kb|xAMPRx_S|xAMPRx_C|xAMPRx_V,gr30
+	beq		icc0,#0,__tlb_kernel_fault	/* jump if PGE not present */
+	slli.p		gr31,#18,gr31
+	bne		icc1,#0,__itlb_k_bigpage
+	movgs		gr30,dampr4
+	movgs		gr31,scr0
+
+	# we can now resume normal service
+	setlos		0x3ffc,gr30
+	srli.p		gr29,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bra		__itlb_k_PTD_mapped
+
+__itlb_k_bigpage:
+	break
+	nop
+
+	.size		__entry_kernel_insn_tlb_miss, .-__entry_kernel_insn_tlb_miss
+
+###############################################################################
+#
+# Kernel data TLB miss handler
+# On entry:
+#   GR1   - kernel stack pointer
+#   GR28  - saved exception frame pointer
+#   GR29  - faulting address
+#   GR31  - EAR0 ^ SCR1
+#   SCR1  - base of virtual range covered by cached PGE from last DTLB miss (or 0xffffffff)
+#   DAMR3 - mapped page directory
+#   DAMR5 - mapped page table as matched by SCR1
+#
+###############################################################################
+	.globl		__entry_kernel_data_tlb_miss
+	.type		__entry_kernel_data_tlb_miss,@function
+__entry_kernel_data_tlb_miss:
+#if 0
+	sethi.p		%hi(0xe1200004),gr30
+	setlo		%lo(0xe1200004),gr30
+	st		gr0,@(gr30,gr0)
+	sethi.p		%hi(0xffc00100),gr30
+	setlo		%lo(0xffc00100),gr30
+	sth		gr30,@(gr30,gr0)
+	membar
+#endif
+
+	movsg		ccr,gr30			/* save CCR */
+	movgs		gr30,scr2
+
+	# see if the cached page table mapping is appropriate
+	srlicc.p	gr31,#26,gr0,icc0
+	setlos		0x3ffc,gr30
+	srli.p		gr29,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bne		icc0,#0,__dtlb_k_PTD_miss
+
+__dtlb_k_PTD_mapped:
+	# access the PTD with EAR0[25:14]
+	# - DAMLR5 points to the virtual address of the appropriate page table
+	# - the PTD holds 4096 PTEs
+	# - the PTD must be accessed uncached
+	# - the PTE must be marked accessed if it was valid
+	#
+	and		gr31,gr30,gr31
+	movsg		damlr5,gr30
+	add		gr30,gr31,gr31
+	ldi		@(gr31,#0),gr30			/* fetch the PTE */
+	andicc		gr30,#_PAGE_PRESENT,gr0,icc0
+	ori.p		gr30,#_PAGE_ACCESSED,gr30
+	beq		icc0,#0,__tlb_kernel_fault	/* jump if PTE invalid */
+	sti.p		gr30,@(gr31,#0)			/* update the PTE */
+	andi		gr30,#~_PAGE_ACCESSED,gr30
+
+	# we're using DAMR1 as an extra TLB entry
+	# - punt the entry here (if valid) to the real TLB and then replace with the new PTE
+	# - need to check IAMR1 lest we cause an multiple-DAT-hit exception
+	movsg		dampr1,gr31
+	andicc		gr31,#xAMPRx_V,gr0,icc0
+	setlos.p	0xfffff000,gr31
+	beq		icc0,#0,__dtlb_k_nopunt		/* punt not required */
+
+	movsg		damlr1,gr31
+	movgs		gr31,tplr			/* set TPLR.CXN */
+	tlbpr		gr31,gr0,#4,#0			/* delete matches from TLB, IAMR1, DAMR1 */
+
+	movsg		dampr1,gr31
+	ori		gr31,#xAMPRx_V,gr31		/* entry was invalidated by tlbpr #4 */
+	movgs		gr31,tppr
+	movsg		damlr1,gr31			/* set TPLR.CXN */
+	movgs		gr31,tplr
+	tlbpr		gr31,gr0,#2,#0			/* save to the TLB */
+	movsg		tpxr,gr31			/* check the TLB write error flag */
+	andicc.p	gr31,#TPXR_E,gr0,icc0
+	setlos		#0xfffff000,gr31
+	bne		icc0,#0,__tlb_kernel_fault
+
+__dtlb_k_nopunt:
+
+	# assemble the new TLB entry
+	and		gr29,gr31,gr29
+	movsg		cxnr,gr31
+	or		gr29,gr31,gr29
+	movgs		gr29,iamlr1			/* xAMLR = address | context number */
+	movgs		gr30,iampr1
+	movgs		gr29,damlr1
+	movgs		gr30,dampr1
+
+	# return, restoring registers
+	movsg		scr2,gr30
+	movgs		gr30,ccr
+	sethi.p		%hi(__kernel_current_task),gr29
+	setlo		%lo(__kernel_current_task),gr29
+	ldi		@(gr29,#0),gr29
+	rett		#0
+	beq		icc0,#3,0			/* prevent icache prefetch */
+
+	# the PTE we want wasn't in the PTD we have mapped, so we need to go looking for a more
+	# appropriate page table and map that instead
+	#   - access the PGD with EAR0[31:26]
+	#   - DAMLR3 points to the virtual address of the page directory
+	#   - the PGD holds 64 PGEs and each PGE/PME points to a set of page tables
+__dtlb_k_PTD_miss:
+	srli		gr29,#26,gr31			/* calculate PGE offset */
+	slli		gr31,#8,gr31			/* and clear bottom bits */
+
+	movsg		damlr3,gr30
+	ld		@(gr31,gr30),gr30		/* access the PGE */
+
+	andicc.p	gr30,#_PAGE_PRESENT,gr0,icc0
+	andicc		gr30,#xAMPRx_SS,gr0,icc1
+
+	# map this PTD instead and record coverage address
+	ori.p		gr30,#xAMPRx_L|xAMPRx_SS_16Kb|xAMPRx_S|xAMPRx_C|xAMPRx_V,gr30
+	beq		icc0,#0,__tlb_kernel_fault	/* jump if PGE not present */
+	slli.p		gr31,#18,gr31
+	bne		icc1,#0,__dtlb_k_bigpage
+	movgs		gr30,dampr5
+	movgs		gr31,scr1
+
+	# we can now resume normal service
+	setlos		0x3ffc,gr30
+	srli.p		gr29,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bra		__dtlb_k_PTD_mapped
+
+__dtlb_k_bigpage:
+	break
+	nop
+
+	.size		__entry_kernel_data_tlb_miss, .-__entry_kernel_data_tlb_miss
+
+###############################################################################
+#
+# Userspace instruction TLB miss handler (with PGE prediction)
+# On entry:
+#   GR28  - faulting address
+#   GR31  - EAR0 ^ SCR0
+#   SCR0  - base of virtual range covered by cached PGE from last ITLB miss (or 0xffffffff)
+#   DAMR3 - mapped page directory
+#   DAMR4 - mapped page table as matched by SCR0
+#
+###############################################################################
+	.globl		__entry_user_insn_tlb_miss
+	.type		__entry_user_insn_tlb_miss,@function
+__entry_user_insn_tlb_miss:
+#if 0
+	sethi.p		%hi(0xe1200004),gr30
+	setlo		%lo(0xe1200004),gr30
+	st		gr0,@(gr30,gr0)
+	sethi.p		%hi(0xffc00100),gr30
+	setlo		%lo(0xffc00100),gr30
+	sth		gr30,@(gr30,gr0)
+	membar
+#endif
+
+	movsg		ccr,gr30			/* save CCR */
+	movgs		gr30,scr2
+
+	# see if the cached page table mapping is appropriate
+	srlicc.p	gr31,#26,gr0,icc0
+	setlos		0x3ffc,gr30
+	srli.p		gr28,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bne		icc0,#0,__itlb_u_PTD_miss
+
+__itlb_u_PTD_mapped:
+	# access the PTD with EAR0[25:14]
+	# - DAMLR4 points to the virtual address of the appropriate page table
+	# - the PTD holds 4096 PTEs
+	# - the PTD must be accessed uncached
+	# - the PTE must be marked accessed if it was valid
+	#
+	and		gr31,gr30,gr31
+	movsg		damlr4,gr30
+	add		gr30,gr31,gr31
+	ldi		@(gr31,#0),gr30			/* fetch the PTE */
+	andicc		gr30,#_PAGE_PRESENT,gr0,icc0
+	ori.p		gr30,#_PAGE_ACCESSED,gr30
+	beq		icc0,#0,__tlb_user_fault	/* jump if PTE invalid */
+	sti.p		gr30,@(gr31,#0)			/* update the PTE */
+	andi		gr30,#~_PAGE_ACCESSED,gr30
+
+	# we're using IAMR1/DAMR1 as an extra TLB entry
+	# - punt the entry here (if valid) to the real TLB and then replace with the new PTE
+	movsg		dampr1,gr31
+	andicc		gr31,#xAMPRx_V,gr0,icc0
+	setlos.p	0xfffff000,gr31
+	beq		icc0,#0,__itlb_u_nopunt		/* punt not required */
+
+	movsg		dampr1,gr31
+	movgs		gr31,tppr
+	movsg		damlr1,gr31			/* set TPLR.CXN */
+	movgs		gr31,tplr
+	tlbpr		gr31,gr0,#2,#0			/* save to the TLB */
+	movsg		tpxr,gr31			/* check the TLB write error flag */
+	andicc.p	gr31,#TPXR_E,gr0,icc0
+	setlos		#0xfffff000,gr31
+	bne		icc0,#0,__tlb_user_fault
+
+__itlb_u_nopunt:
+
+	# assemble the new TLB entry
+	and		gr28,gr31,gr28
+	movsg		cxnr,gr31
+	or		gr28,gr31,gr28
+	movgs		gr28,iamlr1			/* xAMLR = address | context number */
+	movgs		gr30,iampr1
+	movgs		gr28,damlr1
+	movgs		gr30,dampr1
+	
+	# return, restoring registers
+	movsg		scr2,gr30
+	movgs		gr30,ccr
+	rett		#0
+	beq		icc0,#3,0			/* prevent icache prefetch */
+
+	# the PTE we want wasn't in the PTD we have mapped, so we need to go looking for a more
+	# appropriate page table and map that instead
+	#   - access the PGD with EAR0[31:26]
+	#   - DAMLR3 points to the virtual address of the page directory
+	#   - the PGD holds 64 PGEs and each PGE/PME points to a set of page tables
+__itlb_u_PTD_miss:
+	srli		gr28,#26,gr31			/* calculate PGE offset */
+	slli		gr31,#8,gr31			/* and clear bottom bits */
+
+	movsg		damlr3,gr30
+	ld		@(gr31,gr30),gr30		/* access the PGE */
+
+	andicc.p	gr30,#_PAGE_PRESENT,gr0,icc0
+	andicc		gr30,#xAMPRx_SS,gr0,icc1
+
+	# map this PTD instead and record coverage address
+	ori.p		gr30,#xAMPRx_L|xAMPRx_SS_16Kb|xAMPRx_S|xAMPRx_C|xAMPRx_V,gr30
+	beq		icc0,#0,__tlb_user_fault	/* jump if PGE not present */
+	slli.p		gr31,#18,gr31
+	bne		icc1,#0,__itlb_u_bigpage
+	movgs		gr30,dampr4
+	movgs		gr31,scr0
+
+	# we can now resume normal service
+	setlos		0x3ffc,gr30
+	srli.p		gr28,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bra		__itlb_u_PTD_mapped
+
+__itlb_u_bigpage:
+	break
+	nop
+
+	.size		__entry_user_insn_tlb_miss, .-__entry_user_insn_tlb_miss
+
+###############################################################################
+#
+# Userspace data TLB miss handler
+# On entry:
+#   GR28  - faulting address
+#   GR31  - EAR0 ^ SCR1
+#   SCR1  - base of virtual range covered by cached PGE from last DTLB miss (or 0xffffffff)
+#   DAMR3 - mapped page directory
+#   DAMR5 - mapped page table as matched by SCR1
+#
+###############################################################################
+	.globl		__entry_user_data_tlb_miss
+	.type		__entry_user_data_tlb_miss,@function
+__entry_user_data_tlb_miss:
+#if 0
+	sethi.p		%hi(0xe1200004),gr30
+	setlo		%lo(0xe1200004),gr30
+	st		gr0,@(gr30,gr0)
+	sethi.p		%hi(0xffc00100),gr30
+	setlo		%lo(0xffc00100),gr30
+	sth		gr30,@(gr30,gr0)
+	membar
+#endif
+
+	movsg		ccr,gr30			/* save CCR */
+	movgs		gr30,scr2
+
+	# see if the cached page table mapping is appropriate
+	srlicc.p	gr31,#26,gr0,icc0
+	setlos		0x3ffc,gr30
+	srli.p		gr28,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bne		icc0,#0,__dtlb_u_PTD_miss
+
+__dtlb_u_PTD_mapped:
+	# access the PTD with EAR0[25:14]
+	# - DAMLR5 points to the virtual address of the appropriate page table
+	# - the PTD holds 4096 PTEs
+	# - the PTD must be accessed uncached
+	# - the PTE must be marked accessed if it was valid
+	#
+	and		gr31,gr30,gr31
+	movsg		damlr5,gr30
+
+__dtlb_u_using_iPTD:
+	add		gr30,gr31,gr31
+	ldi		@(gr31,#0),gr30			/* fetch the PTE */
+	andicc		gr30,#_PAGE_PRESENT,gr0,icc0
+	ori.p		gr30,#_PAGE_ACCESSED,gr30
+	beq		icc0,#0,__tlb_user_fault	/* jump if PTE invalid */
+	sti.p		gr30,@(gr31,#0)			/* update the PTE */
+	andi		gr30,#~_PAGE_ACCESSED,gr30
+
+	# we're using DAMR1 as an extra TLB entry
+	# - punt the entry here (if valid) to the real TLB and then replace with the new PTE
+	movsg		dampr1,gr31
+	andicc		gr31,#xAMPRx_V,gr0,icc0
+	setlos.p	0xfffff000,gr31
+	beq		icc0,#0,__dtlb_u_nopunt		/* punt not required */
+
+	movsg		dampr1,gr31
+	movgs		gr31,tppr
+	movsg		damlr1,gr31			/* set TPLR.CXN */
+	movgs		gr31,tplr
+	tlbpr		gr31,gr0,#2,#0			/* save to the TLB */
+	movsg		tpxr,gr31			/* check the TLB write error flag */
+	andicc.p	gr31,#TPXR_E,gr0,icc0
+	setlos		#0xfffff000,gr31
+	bne		icc0,#0,__tlb_user_fault
+
+__dtlb_u_nopunt:
+
+	# assemble the new TLB entry
+	and		gr28,gr31,gr28
+	movsg		cxnr,gr31
+	or		gr28,gr31,gr28
+	movgs		gr28,iamlr1			/* xAMLR = address | context number */
+	movgs		gr30,iampr1
+	movgs		gr28,damlr1
+	movgs		gr30,dampr1
+
+	# return, restoring registers
+	movsg		scr2,gr30
+	movgs		gr30,ccr
+	rett		#0
+	beq		icc0,#3,0			/* prevent icache prefetch */
+
+	# the PTE we want wasn't in the PTD we have mapped, so we need to go looking for a more
+	# appropriate page table and map that instead
+	#   - first of all, check the insn PGE cache - we may well get a hit there
+	#   - access the PGD with EAR0[31:26]
+	#   - DAMLR3 points to the virtual address of the page directory
+	#   - the PGD holds 64 PGEs and each PGE/PME points to a set of page tables
+__dtlb_u_PTD_miss:
+	movsg		scr0,gr31			/* consult the insn-PGE-cache key */
+	xor		gr28,gr31,gr31
+	srlicc		gr31,#26,gr0,icc0
+	srli		gr28,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bne		icc0,#0,__dtlb_u_iPGE_miss
+
+	# what we're looking for is covered by the insn-PGE-cache
+	setlos		0x3ffc,gr30
+	and		gr31,gr30,gr31
+	movsg		damlr4,gr30
+	bra		__dtlb_u_using_iPTD
+
+__dtlb_u_iPGE_miss:	
+	srli		gr28,#26,gr31			/* calculate PGE offset */
+	slli		gr31,#8,gr31			/* and clear bottom bits */
+
+	movsg		damlr3,gr30
+	ld		@(gr31,gr30),gr30		/* access the PGE */
+
+	andicc.p	gr30,#_PAGE_PRESENT,gr0,icc0
+	andicc		gr30,#xAMPRx_SS,gr0,icc1
+
+	# map this PTD instead and record coverage address
+	ori.p		gr30,#xAMPRx_L|xAMPRx_SS_16Kb|xAMPRx_S|xAMPRx_C|xAMPRx_V,gr30
+	beq		icc0,#0,__tlb_user_fault	/* jump if PGE not present */
+	slli.p		gr31,#18,gr31
+	bne		icc1,#0,__dtlb_u_bigpage
+	movgs		gr30,dampr5
+	movgs		gr31,scr1
+
+	# we can now resume normal service
+	setlos		0x3ffc,gr30
+	srli.p		gr28,#12,gr31			/* use EAR0[25:14] as PTE index */
+	bra		__dtlb_u_PTD_mapped
+
+__dtlb_u_bigpage:
+	break
+	nop
+
+	.size		__entry_user_data_tlb_miss, .-__entry_user_data_tlb_miss
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/unaligned.c linux-2.6.10-rc1-mm3-frv/arch/frv/mm/unaligned.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/mm/unaligned.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/mm/unaligned.c	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,218 @@
+/* unaligned.c: unalignment fixup handler for CPUs on which it is supported (FR451 only)
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/user.h>
+#include <linux/string.h>
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+#include <asm/setup.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#if 0
+#define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
+#else
+#define kdebug(fmt, ...) do {} while(0)
+#endif
+
+#define _MA_SIGNED	0x01
+#define _MA_HALF	0x02
+#define _MA_WORD	0x04
+#define _MA_DWORD	0x08
+#define _MA_SZ_MASK	0x0e
+#define _MA_LOAD	0x10
+#define _MA_STORE	0x20
+#define _MA_UPDATE	0x40
+#define _MA_IMM		0x80
+
+#define _MA_LDxU	_MA_LOAD | _MA_UPDATE
+#define _MA_LDxI	_MA_LOAD | _MA_IMM
+#define _MA_STxU	_MA_STORE | _MA_UPDATE
+#define _MA_STxI	_MA_STORE | _MA_IMM
+
+static const uint8_t tbl_LDGRk_reg[0x40] = {
+	[0x02] = _MA_LOAD | _MA_HALF | _MA_SIGNED,	/* LDSH  @(GRi,GRj),GRk */
+	[0x03] = _MA_LOAD | _MA_HALF,			/* LDUH  @(GRi,GRj),GRk */
+	[0x04] = _MA_LOAD | _MA_WORD,			/* LD	 @(GRi,GRj),GRk */
+	[0x05] = _MA_LOAD | _MA_DWORD,			/* LDD	 @(GRi,GRj),GRk */
+	[0x12] = _MA_LDxU | _MA_HALF | _MA_SIGNED,	/* LDSHU @(GRi,GRj),GRk */
+	[0x13] = _MA_LDxU | _MA_HALF,			/* LDUHU @(GRi,GRj),GRk */
+	[0x14] = _MA_LDxU | _MA_WORD,			/* LDU	 @(GRi,GRj),GRk */
+	[0x15] = _MA_LDxU | _MA_DWORD,			/* LDDU	 @(GRi,GRj),GRk */
+};
+
+static const uint8_t tbl_STGRk_reg[0x40] = {
+	[0x01] = _MA_STORE | _MA_HALF,			/* STH   @(GRi,GRj),GRk */
+	[0x02] = _MA_STORE | _MA_WORD,			/* ST	 @(GRi,GRj),GRk */
+	[0x03] = _MA_STORE | _MA_DWORD,			/* STD	 @(GRi,GRj),GRk */
+	[0x11] = _MA_STxU  | _MA_HALF,			/* STHU  @(GRi,GRj),GRk */
+	[0x12] = _MA_STxU  | _MA_WORD,			/* STU	 @(GRi,GRj),GRk */
+	[0x13] = _MA_STxU  | _MA_DWORD,			/* STDU	 @(GRi,GRj),GRk */
+};
+
+static const uint8_t tbl_LDSTGRk_imm[0x80] = {
+	[0x31] = _MA_LDxI | _MA_HALF | _MA_SIGNED,	/* LDSHI @(GRi,d12),GRk */
+	[0x32] = _MA_LDxI | _MA_WORD,			/* LDI   @(GRi,d12),GRk */
+	[0x33] = _MA_LDxI | _MA_DWORD,			/* LDDI  @(GRi,d12),GRk */
+	[0x36] = _MA_LDxI | _MA_HALF,			/* LDUHI @(GRi,d12),GRk */
+	[0x51] = _MA_STxI | _MA_HALF,			/* STHI  @(GRi,d12),GRk */
+	[0x52] = _MA_STxI | _MA_WORD,			/* STI   @(GRi,d12),GRk */
+	[0x53] = _MA_STxI | _MA_DWORD,			/* STDI  @(GRi,d12),GRk */
+};
+
+
+/*****************************************************************************/
+/*
+ * see if we can handle the exception by fixing up a misaligned memory access
+ */
+int handle_misalignment(unsigned long esr0, unsigned long ear0, unsigned long epcr0)
+{
+	unsigned long insn, addr, *greg;
+	int GRi, GRj, GRk, D12, op;
+
+	union {
+		uint64_t _64;
+		uint32_t _32[2];
+		uint16_t _16;
+		uint8_t _8[8];
+	} x;
+
+	if (!(esr0 & ESR0_EAV) || !(epcr0 & EPCR0_V) || !(ear0 & 7))
+		return -EAGAIN;
+
+	epcr0 &= EPCR0_PC;
+
+	if (__frame->pc != epcr0) {
+		kdebug("MISALIGN: Execution not halted on excepting instruction\n");
+		BUG();
+	}
+
+	if (__get_user(insn, (unsigned long *) epcr0) < 0)
+		return -EFAULT;
+
+	/* determine the instruction type first */
+	switch ((insn >> 18) & 0x7f) {
+	case 0x2:
+		/* LDx @(GRi,GRj),GRk */
+		op = tbl_LDGRk_reg[(insn >> 6) & 0x3f];
+		break;
+
+	case 0x3:
+		/* STx GRk,@(GRi,GRj) */
+		op = tbl_STGRk_reg[(insn >> 6) & 0x3f];
+		break;
+
+	default:
+		op = tbl_LDSTGRk_imm[(insn >> 18) & 0x7f];
+		break;
+	}
+
+	if (!op)
+		return -EAGAIN;
+
+	kdebug("MISALIGN: pc=%08lx insn=%08lx ad=%08lx op=%02x\n", epcr0, insn, ear0, op);
+
+	memset(&x, 0xba, 8);
+
+	/* validate the instruction parameters */
+	greg = (unsigned long *) &__frame->tbr;
+
+	GRi = (insn >> 12) & 0x3f;
+	GRk = (insn >> 25) & 0x3f;
+
+	if (GRi > 31 || GRk > 31)
+		return -ENOENT;
+
+	if (op & _MA_DWORD && GRk & 1)
+		return -EINVAL;
+
+	if (op & _MA_IMM) {
+		D12 = insn & 0xfff;
+		asm ("slli %0,#20,%0 ! srai %0,#20,%0" : "=r"(D12) : "0"(D12)); /* sign extend */
+		addr = (GRi ? greg[GRi] : 0) + D12;
+	}
+	else {
+		GRj = (insn >>  0) & 0x3f;
+		if (GRj > 31)
+			return -ENOENT;
+		addr = (GRi ? greg[GRi] : 0) + (GRj ? greg[GRj] : 0);
+	}
+
+	if (addr != ear0) {
+		kdebug("MISALIGN: Calculated addr (%08lx) does not match EAR0 (%08lx)\n",
+		       addr, ear0);
+		return -EFAULT;
+	}
+
+	/* check the address is okay */
+	if (user_mode(__frame) && ___range_ok(ear0, 8) < 0)
+		return -EFAULT;
+
+	/* perform the memory op */
+	if (op & _MA_STORE) {
+		/* perform a store */
+		x._32[0] = 0;
+		if (GRk != 0) {
+			if (op & _MA_HALF) {
+				x._16 = greg[GRk];
+			}
+			else {
+				x._32[0] = greg[GRk];
+			}
+		}
+		if (op & _MA_DWORD)
+			x._32[1] = greg[GRk + 1];
+
+		kdebug("MISALIGN: Store GR%d { %08x:%08x } -> %08lx (%dB)\n",
+		       GRk, x._32[1], x._32[0], addr, op & _MA_SZ_MASK);
+
+		if (__memcpy_user((void *) addr, &x, op & _MA_SZ_MASK) != 0)
+			return -EFAULT;
+	}
+	else {
+		/* perform a load */
+		if (__memcpy_user(&x, (void *) addr, op & _MA_SZ_MASK) != 0)
+			return -EFAULT;
+
+		if (op & _MA_HALF) {
+			if (op & _MA_SIGNED)
+				asm ("slli %0,#16,%0 ! srai %0,#16,%0"
+				     : "=r"(x._32[0]) : "0"(x._16));
+			else
+				asm ("sethi #0,%0"
+				     : "=r"(x._32[0]) : "0"(x._16));
+		}
+
+		kdebug("MISALIGN: Load %08lx (%dB) -> GR%d, { %08x:%08x }\n",
+		       addr, op & _MA_SZ_MASK, GRk, x._32[1], x._32[0]);
+
+		if (GRk != 0)
+			greg[GRk] = x._32[0];
+		if (op & _MA_DWORD)
+			greg[GRk + 1] = x._32[1];
+	}
+
+	/* update the base pointer if required */
+	if (op & _MA_UPDATE)
+		greg[GRi] = addr;
+
+	/* well... we've done that insn */
+	__frame->pc = __frame->pc + 4;
+
+	return 0;
+} /* end handle_misalignment() */
