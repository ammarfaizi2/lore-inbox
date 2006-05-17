Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWEQJ4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWEQJ4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 05:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWEQJ4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 05:56:52 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:5313 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750803AbWEQJ4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 05:56:50 -0400
Date: Wed, 17 May 2006 05:56:00 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Paul Mackerras <paulus@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
       kenneth.w.chen@intel.com, sam@ravnborg.org, clameter@sgi.com,
       kiran@scalex86.org
Subject: [RFC PATCH 01/09] robust VM per_cpu core
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170555190.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the VM per_cpu core patch.  It includes the mm/per_cpu.c file
that is used to initialize and update per_cpu variables at startup
and module load.

To use this, the arch must define CONFIG_HAS_VM_PERCPU and
__ARCH_HAS_VM_PERCPU.

Also the following must be defined:

PERCPU_START - start of the percpu VM area
PERCPU_SIZE - size of the percpu VM area for each CPU so that the
		total size would be PERCPU_SIZE * NR_CPUS

As well as the following three functions:

pud_t *pud_boot_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
                     int cpu);
pmd_t *pmd_boot_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
                     int cpu);
pte_t *pte_boot_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
                     int cpu);

The above functions are to allocate page tables from bootmem because the
percpu is initialized right after setup_arch in init/main.c

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/mm/percpu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-test/mm/percpu.c	2006-05-17 04:39:52.000000000 -0400
@@ -0,0 +1,287 @@
+/*
+ *  linux/mm/percpu.c
+ *
+ *  Copyright (C) 2006 Steven Rostedt <rostedt@goodmis.org>
+ *
+ *  Some of this code was influenced by mm/vmalloc.c
+ *
+ *  The percpu variables need to always have the same offset from one CPU to
+ *  the next no matter if the percpu variable is defined in the kernel or
+ *  inside a module.  So to guarentee that the offset is the same for both,
+ *  they are mapped into virtual memory.
+ *
+ *  Since the percpu variables are used before memory is initialized, the
+ *  inital setup must be done with bootmem, and thus vmalloc code can not be
+ *  used.
+ *
+ *  Credits:
+ *  -------
+ *   This goes to lots of people that inspired me on LKML, and responded to
+ *   my first (horrible) implementation of robust per_cpu variables.
+ *
+ *   Also many thanks to Rusty Russell in his generic per_cpu implementation.
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include <linux/bootmem.h>
+
+#include <asm/uaccess.h>
+#include <asm/tlbflush.h>
+
+static int __init percpu_boot_alloc(unsigned long addr, unsigned long size,
+				    int node);
+
+/*
+ * percpu_allocated keeps track of the actual allocated memory. It
+ * always points to the page after the last page in VM that was allocated.
+ *
+ * Yes this is also a per_cpu variable :)
+ * It gets updated after the copys are made.
+ */
+static DEFINE_PER_CPU(unsigned long, percpu_allocated);
+
+static char * __init per_cpu_allocate_init(unsigned long size, int cpu)
+{
+	unsigned long addr;
+
+	addr = PERCPU_START+(cpu*PERCPU_SIZE);
+	BUG_ON(percpu_boot_alloc(addr, size, cpu));
+
+	return (char*)addr;
+
+}
+
+/**
+ *	setup_per_cpu_areas  - initialization of VM per_cpu variables
+ *
+ *	Allocate pages in VM for the per_cpu variables
+ *	of the kernel.
+ */
+void __init setup_per_cpu_areas(void)
+{
+	unsigned long size, i;
+	char *ptr;
+
+	/* Copy section for each CPU (we discard the original) */
+	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
+
+	for (i = 0; i < NR_CPUS; i++, ptr += size) {
+		ptr = per_cpu_allocate_init(size, i);
+		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
+		wmb();
+		per_cpu(percpu_allocated, i) =
+			PAGE_ALIGN((unsigned long)ptr + size);
+	}
+}
+
+static __init int percpu_boot_pte_alloc(pmd_t *pmd, unsigned long addr,
+					  unsigned long end, int node)
+{
+	pte_t *pte;
+
+	pte = pte_boot_alloc(&init_mm, pmd, addr, node);
+	if (!pte)
+		return -ENOMEM;
+	do {
+		void *page;
+		WARN_ON(!pte_none(*pte));
+		page = alloc_bootmem_pages(PAGE_SIZE);
+		if (!page)
+			return -ENOMEM;
+		set_pte_at(&init_mm, addr, pte, mk_pte(virt_to_page(page),
+						       PAGE_KERNEL));
+	} while (pte++, addr += PAGE_SIZE, addr < end);
+	return 0;
+}
+
+static __init int percpu_boot_pmd_alloc(pud_t *pud, unsigned long addr,
+					unsigned long end, int node)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_boot_alloc(&init_mm, pud, addr, node);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pmd_addr_end(addr, end);
+		if (percpu_boot_pte_alloc(pmd, addr, next, node))
+			return -ENOMEM;
+	} while (pmd++, addr = next, addr < end);
+	return 0;
+}
+
+static __init int percpu_boot_pud_alloc(pgd_t *pgd, unsigned long addr,
+					unsigned long end, int node)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_boot_alloc(&init_mm, pgd, addr, node);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pud_addr_end(addr, end);
+		if (percpu_boot_pmd_alloc(pud, addr, next, node))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr < end);
+	return 0;
+}
+
+static int __init percpu_boot_alloc(unsigned long addr, unsigned long size,
+				    int node)
+{
+	pgd_t *pgd;
+	unsigned long end = addr + size;
+	unsigned long next;
+	int err;
+
+	pgd = pgd_offset_k(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		err = percpu_boot_pud_alloc(pgd, addr, next, node);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr < end);
+	return err;
+}
+
+static __init int percpu_pte_alloc(pmd_t *pmd, unsigned long addr,
+				   unsigned long end, int node)
+{
+	pte_t *pte;
+
+	pte = pte_alloc_kernel(pmd, addr);
+	if (!pte)
+		return -ENOMEM;
+	do {
+		void *page;
+		if (unlikely(!pte_none(*pte))) {
+			printk("bad pte: %p->%p\n", pte, (void*)pte_val(*pte));
+			BUG();
+			return -EFAULT;
+		}
+		page = (void*)__get_free_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+		set_pte_at(&init_mm, addr, pte, mk_pte(virt_to_page(page),
+						       PAGE_KERNEL));
+	} while (pte++, addr += PAGE_SIZE, addr < end);
+	__flush_tlb();
+	return 0;
+}
+
+static __init int percpu_pmd_alloc(pud_t *pud, unsigned long addr,
+				   unsigned long end, int node)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_alloc(&init_mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
+	do {
+		next = pmd_addr_end(addr, end);
+		if (percpu_pte_alloc(pmd, addr, next, node))
+			return -ENOMEM;
+	} while (pmd++, addr = next, addr < end);
+	return 0;
+}
+
+static __init int percpu_pud_alloc(pgd_t *pgd, unsigned long addr,
+				   unsigned long end, int node)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_alloc(&init_mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next = pud_addr_end(addr, end);
+		if (percpu_pmd_alloc(pud, addr, next, node))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr < end);
+	return 0;
+}
+
+static int percpu_alloc(unsigned long addr, unsigned long size,
+			int node)
+{
+	pgd_t *pgd;
+	unsigned long end = addr + size;
+	unsigned long next;
+	int err;
+
+	pgd = pgd_offset_k(addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		err = percpu_pud_alloc(pgd, addr, next, node);
+		if (err)
+			break;
+	} while (pgd++, addr = next, addr < end);
+	return err;
+}
+
+static int percpu_module_update(void *pcpudst, unsigned long size, int cpu)
+{
+	int err = 0;
+	/*
+	 * These two local variables are only used to keep the code
+	 * looking simpler.  Since this function is only called on
+	 * module load, it's not time critical.
+	 */
+	unsigned long needed_address = (unsigned long)
+		((pcpudst) + __PERCPU_OFFSET_ADDRESS(cpu)+size);
+	unsigned long allocated = per_cpu(percpu_allocated, cpu);
+
+	if (allocated < needed_address) {
+		unsigned long alloc = needed_address - allocated;
+		err = percpu_alloc(allocated, alloc, cpu);
+		if (!err)
+			per_cpu(percpu_allocated, cpu) =
+				PAGE_ALIGN(needed_address);
+	}
+	return err;
+}
+
+/**
+ *	per_cpu_modcopy  -  copy and allocate module VM per_cpu variables
+ *
+ *	@pcpudst:	Destination of module per_cpu section
+ *	@src:		Source of module per_cpu data section
+ *	@size:		Size of module per_cpu data section
+ *
+ *	Copy the module's data per_cpu section into each VM per_cpu section
+ *	stored in the kernel.  If need be, allocate more pages in VM
+ *	if they are not yet allocated.
+ *
+ *	protected by module_mutex
+ */
+int percpu_modcopy(void *pcpudst, void *src, unsigned long size)
+{
+	unsigned int i;
+	int err = 0;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) {
+			err = percpu_module_update(pcpudst, size, i);
+			if (err)
+				break;
+			memcpy((pcpudst)+__PERCPU_OFFSET_ADDRESS(i),
+			       (src), (size));
+		}
+	return err;
+}
+
+/*
+ * We use the __per_cpu_start for the indexing of
+ * per_cpu variables, even in modules.
+ */
+EXPORT_SYMBOL(__per_cpu_start);
Index: linux-2.6.16-test/mm/Makefile
===================================================================
--- linux-2.6.16-test.orig/mm/Makefile	2006-05-17 04:32:27.000000000 -0400
+++ linux-2.6.16-test/mm/Makefile	2006-05-17 04:39:52.000000000 -0400
@@ -22,3 +22,4 @@ obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
+obj-$(CONFIG_HAS_VM_PERCPU) += percpu.o
\ No newline at end of file

