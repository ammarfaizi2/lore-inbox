Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUB0O3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUB0O3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:29:40 -0500
Received: from dp.samba.org ([66.70.73.150]:7630 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261692AbUB0O2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:28:49 -0500
Date: Sat, 28 Feb 2004 01:28:28 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] ppc64 TLB flush rework
Message-ID: <20040227142827.GH5801@krispykreme>
References: <20040227142225.GG5801@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227142225.GG5801@krispykreme>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ppc64 tlb flush rework from Paul Mackerras

Instead of doing a double pass of the pagetables, we batch things 
up in the pte flush routines and then shoot the batch down in 
flush_tlb_pending.

Our page aging was broken, we never flushed entries out of the ppc64
hashtable. We now flush in ptep_test_and_clear_young.

A number of other things were fixed up in the process:

- change ppc64_tlb_batch to per cpu data
- remove some LPAR debug code
- be more careful with ioremap_mm inits
- clean up arch/ppc64/mm/init.c, create tlb.c

---

 forakpm-anton/arch/ppc64/kernel/pSeries_htab.c |    2 
 forakpm-anton/arch/ppc64/kernel/pSeries_lpar.c |   10 
 forakpm-anton/arch/ppc64/kernel/process.c      |   12 
 forakpm-anton/arch/ppc64/mm/Makefile           |    2 
 forakpm-anton/arch/ppc64/mm/hash_utils.c       |    3 
 forakpm-anton/arch/ppc64/mm/init.c             |  376 +++++--------------------
 forakpm-anton/arch/ppc64/mm/tlb.c              |  155 ++++++++++
 forakpm-anton/include/asm-ppc64/pgtable.h      |  122 ++++++--
 forakpm-anton/include/asm-ppc64/tlb.h          |   61 ----
 forakpm-anton/include/asm-ppc64/tlbflush.h     |   43 +-
 10 files changed, 388 insertions(+), 398 deletions(-)

diff -puN arch/ppc64/kernel/pSeries_htab.c~tlb_flush_rework arch/ppc64/kernel/pSeries_htab.c
--- forakpm/arch/ppc64/kernel/pSeries_htab.c~tlb_flush_rework	2004-02-27 23:16:07.034524533 +1100
+++ forakpm-anton/arch/ppc64/kernel/pSeries_htab.c	2004-02-27 23:16:07.099519592 +1100
@@ -300,7 +300,7 @@ static void pSeries_flush_hash_range(uns
 	int i, j;
 	HPTE *hptep;
 	Hpte_dword0 dw0;
-	struct ppc64_tlb_batch *batch = &ppc64_tlb_batch[smp_processor_id()];
+	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 
 	/* XXX fix for large ptes */
 	unsigned long large = 0;
diff -puN arch/ppc64/kernel/pSeries_lpar.c~tlb_flush_rework arch/ppc64/kernel/pSeries_lpar.c
--- forakpm/arch/ppc64/kernel/pSeries_lpar.c~tlb_flush_rework	2004-02-27 23:16:07.040524077 +1100
+++ forakpm-anton/arch/ppc64/kernel/pSeries_lpar.c	2004-02-27 23:16:07.102519363 +1100
@@ -422,10 +422,8 @@ static long pSeries_lpar_hpte_updatepp(u
 
 	lpar_rc = plpar_pte_protect(flags, slot, (avpn << 7));
 
-	if (lpar_rc == H_Not_Found) {
-		udbg_printf("updatepp missed\n");
+	if (lpar_rc == H_Not_Found)
 		return -1;
-	}
 
 	if (lpar_rc != H_Success)
 		panic("bad return code from pte protect rc = %lx\n", lpar_rc);
@@ -523,10 +521,8 @@ static void pSeries_lpar_hpte_invalidate
 	lpar_rc = plpar_pte_remove(H_AVPN, slot, (avpn << 7), &dummy1,
 				   &dummy2);
 
-	if (lpar_rc == H_Not_Found) {
-		udbg_printf("invalidate missed\n");
+	if (lpar_rc == H_Not_Found)
 		return;
-	}
 
 	if (lpar_rc != H_Success)
 		panic("Bad return code from invalidate rc = %lx\n", lpar_rc);
@@ -541,7 +537,7 @@ void pSeries_lpar_flush_hash_range(unsig
 {
 	int i;
 	unsigned long flags;
-	struct ppc64_tlb_batch *batch = &ppc64_tlb_batch[smp_processor_id()];
+	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 
 	spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
 
diff -puN arch/ppc64/kernel/process.c~tlb_flush_rework arch/ppc64/kernel/process.c
--- forakpm/arch/ppc64/kernel/process.c~tlb_flush_rework	2004-02-27 23:16:07.047523545 +1100
+++ forakpm-anton/arch/ppc64/kernel/process.c	2004-02-27 23:16:07.104519211 +1100
@@ -49,14 +49,20 @@
 #include <asm/hardirq.h>
 #include <asm/cputable.h>
 #include <asm/sections.h>
+#include <asm/tlbflush.h>
 
 #ifndef CONFIG_SMP
 struct task_struct *last_task_used_math = NULL;
 struct task_struct *last_task_used_altivec = NULL;
 #endif
 
-struct mm_struct ioremap_mm = { pgd             : ioremap_dir  
-                               ,page_table_lock : SPIN_LOCK_UNLOCKED };
+struct mm_struct ioremap_mm = {
+	.pgd		= ioremap_dir,
+	.mm_users	= ATOMIC_INIT(2),
+	.mm_count	= ATOMIC_INIT(1),
+	.cpu_vm_mask	= CPU_MASK_ALL,
+	.page_table_lock = SPIN_LOCK_UNLOCKED,
+};
 
 char *sysmap = NULL;
 unsigned long sysmap_size = 0;
@@ -146,6 +152,8 @@ struct task_struct *__switch_to(struct t
 		new->thread.regs->msr |= MSR_VEC;
 #endif /* CONFIG_ALTIVEC */
 
+	flush_tlb_pending();
+
 	new_thread = &new->thread;
 	old_thread = &current->thread;
 
diff -puN arch/ppc64/mm/Makefile~tlb_flush_rework arch/ppc64/mm/Makefile
--- forakpm/arch/ppc64/mm/Makefile~tlb_flush_rework	2004-02-27 23:16:07.052523165 +1100
+++ forakpm-anton/arch/ppc64/mm/Makefile	2004-02-27 23:16:07.105519135 +1100
@@ -4,6 +4,6 @@
 
 EXTRA_CFLAGS += -mno-minimal-toc
 
-obj-y := fault.o init.o imalloc.o hash_utils.o hash_low.o
+obj-y := fault.o init.o imalloc.o hash_utils.o hash_low.o tlb.o
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff -puN arch/ppc64/mm/hash_utils.c~tlb_flush_rework arch/ppc64/mm/hash_utils.c
--- forakpm/arch/ppc64/mm/hash_utils.c~tlb_flush_rework	2004-02-27 23:16:07.058522709 +1100
+++ forakpm-anton/arch/ppc64/mm/hash_utils.c	2004-02-27 23:16:07.107518983 +1100
@@ -326,8 +326,7 @@ void flush_hash_range(unsigned long cont
 		ppc_md.flush_hash_range(context, number, local);
 	} else {
 		int i;
-		struct ppc64_tlb_batch *batch =
-			&ppc64_tlb_batch[smp_processor_id()];
+		struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 
 		for (i = 0; i < number; i++)
 			flush_hash_page(context, batch->addr[i], batch->pte[i],
diff -puN arch/ppc64/mm/init.c~tlb_flush_rework arch/ppc64/mm/init.c
--- forakpm/arch/ppc64/mm/init.c~tlb_flush_rework	2004-02-27 23:16:07.064522253 +1100
+++ forakpm-anton/arch/ppc64/mm/init.c	2004-02-27 23:16:07.113518527 +1100
@@ -76,11 +76,6 @@ extern struct task_struct *current_set[N
 extern pgd_t ioremap_dir[];
 pgd_t * ioremap_pgd = (pgd_t *)&ioremap_dir;
 
-static void * __ioremap_com(unsigned long addr, unsigned long pa, 
-			    unsigned long ea, unsigned long size, 
-			    unsigned long flags);
-static void map_io_page(unsigned long va, unsigned long pa, int flags);
-
 unsigned long klimit = (unsigned long)_end;
 
 HPTE *Hash=0;
@@ -91,59 +86,6 @@ unsigned long _ASR=0;
 /* max amount of RAM to use */
 unsigned long __max_memory;
 
-/* This is declared as we are using the more or less generic 
- * include/asm-ppc64/tlb.h file -- tgall
- */
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
-unsigned long pte_freelist_forced_free;
-
-#ifdef CONFIG_SMP
-static void pte_free_smp_sync(void *arg)
-{
-	/* Do nothing, just ensure we sync with all CPUs */
-}
-#endif
-
-/* This is only called when we are critically out of memory
- * (and fail to get a page in pte_free_tlb).
- */
-void pte_free_now(struct page *ptepage)
-{
-	pte_freelist_forced_free++;
-
-	smp_call_function(pte_free_smp_sync, NULL, 0, 1);
-
-	pte_free(ptepage);
-}
-
-static void pte_free_rcu_callback(void *arg)
-{
-	struct pte_freelist_batch *batch = arg;
-	unsigned int i;
-
-	for (i = 0; i < batch->index; i++)
-		pte_free(batch->pages[i]);
-	free_page((unsigned long)batch);
-}
-
-void pte_free_submit(struct pte_freelist_batch *batch)
-{
-	INIT_RCU_HEAD(&batch->rcu);
-	call_rcu(&batch->rcu, pte_free_rcu_callback, batch);
-}
-
-void pte_free_finish(void)
-{
-	/* This is safe as we are holding page_table_lock */
-	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
-	
-	if (*batchp == NULL)
-		return;
-	pte_free_submit(*batchp);
-	*batchp = NULL;
-}
-
 void show_mem(void)
 {
 	int total = 0, reserved = 0;
@@ -173,17 +115,99 @@ void show_mem(void)
 	printk("%d pages swap cached\n",cached);
 }
 
+#ifdef CONFIG_PPC_ISERIES
+
+void *ioremap(unsigned long addr, unsigned long size)
+{
+	return (void *)addr;
+}
+
+extern void *__ioremap(unsigned long addr, unsigned long size,
+		       unsigned long flags)
+{
+	return (void *)addr;
+}
+
+void iounmap(void *addr)
+{
+	return;
+}
+
+#else
+
+/*
+ * map_io_page currently only called by __ioremap
+ * map_io_page adds an entry to the ioremap page table
+ * and adds an entry to the HPT, possibly bolting it
+ */
+static void map_io_page(unsigned long ea, unsigned long pa, int flags)
+{
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+	unsigned long vsid;
+
+	if (mem_init_done) {
+		spin_lock(&ioremap_mm.page_table_lock);
+		pgdp = pgd_offset_i(ea);
+		pmdp = pmd_alloc(&ioremap_mm, pgdp, ea);
+		ptep = pte_alloc_kernel(&ioremap_mm, pmdp, ea);
+
+		pa = absolute_to_phys(pa);
+		set_pte(ptep, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
+		spin_unlock(&ioremap_mm.page_table_lock);
+	} else {
+		unsigned long va, vpn, hash, hpteg;
+
+		/*
+		 * If the mm subsystem is not fully up, we cannot create a
+		 * linux page table entry for this mapping.  Simply bolt an
+		 * entry in the hardware page table.
+		 */
+		vsid = get_kernel_vsid(ea);
+		va = (vsid << 28) | (ea & 0xFFFFFFF);
+		vpn = va >> PAGE_SHIFT;
+
+		hash = hpt_hash(vpn, 0);
+
+		hpteg = ((hash & htab_data.htab_hash_mask)*HPTES_PER_GROUP);
+
+		/* Panic if a pte grpup is full */
+		if (ppc_md.hpte_insert(hpteg, va, pa >> PAGE_SHIFT, 0,
+				       _PAGE_NO_CACHE|_PAGE_GUARDED|PP_RWXX,
+				       1, 0) == -1) {
+			panic("map_io_page: could not insert mapping");
+		}
+	}
+}
+
+
+static void * __ioremap_com(unsigned long addr, unsigned long pa,
+			    unsigned long ea, unsigned long size,
+			    unsigned long flags)
+{
+	unsigned long i;
+
+	if ((flags & _PAGE_PRESENT) == 0)
+		flags |= pgprot_val(PAGE_KERNEL);
+	if (flags & (_PAGE_NO_CACHE | _PAGE_WRITETHRU))
+		flags |= _PAGE_GUARDED;
+
+	for (i = 0; i < size; i += PAGE_SIZE) {
+		map_io_page(ea+i, pa+i, flags);
+	}
+
+	return (void *) (ea + (addr & ~PAGE_MASK));
+}
+
+
 void *
 ioremap(unsigned long addr, unsigned long size)
 {
-#ifdef CONFIG_PPC_ISERIES
-	return (void*)addr;
-#else
 	void *ret = __ioremap(addr, size, _PAGE_NO_CACHE);
 	if(mem_init_done)
 		return eeh_ioremap(addr, ret);	/* may remap the addr */
 	return ret;
-#endif
 }
 
 void *
@@ -329,7 +353,7 @@ static void unmap_im_area_pmd(pgd_t *dir
  *
  * XXX	what about calls before mem_init_done (ie python_countermeasures())	
  */
-void pSeries_iounmap(void *addr)
+void iounmap(void *addr)
 {
 	unsigned long address, start, end, size;
 	struct mm_struct *mm;
@@ -355,29 +379,18 @@ void pSeries_iounmap(void *addr)
 	spin_lock(&mm->page_table_lock);
 
 	dir = pgd_offset_i(address);
-	flush_cache_all();
+	flush_cache_vunmap(address, end);
 	do {
 		unmap_im_area_pmd(dir, address, end - address);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	__flush_tlb_range(mm, start, end);
+	flush_tlb_kernel_range(start, end);
 
 	spin_unlock(&mm->page_table_lock);
 	return;
 }
 
-void iounmap(void *addr) 
-{
-#ifdef CONFIG_PPC_ISERIES
-	/* iSeries I/O Remap is a noop              */
-	return;
-#else
-	/* DRENG / PPPBBB todo */
-	return pSeries_iounmap(addr);
-#endif
-}
-
 int iounmap_explicit(void *addr, unsigned long size)
 {
 	struct vm_struct *area;
@@ -402,216 +415,7 @@ int iounmap_explicit(void *addr, unsigne
 	return 0;
 }
 
-static void * __ioremap_com(unsigned long addr, unsigned long pa, 
-			    unsigned long ea, unsigned long size, 
-			    unsigned long flags)
-{
-	unsigned long i;
-	
-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= pgprot_val(PAGE_KERNEL);
-	if (flags & (_PAGE_NO_CACHE | _PAGE_WRITETHRU))
-		flags |= _PAGE_GUARDED;
-
-	for (i = 0; i < size; i += PAGE_SIZE) {
-		map_io_page(ea+i, pa+i, flags);
-	}
-
-	return (void *) (ea + (addr & ~PAGE_MASK));
-}
-
-/*
- * map_io_page currently only called by __ioremap
- * map_io_page adds an entry to the ioremap page table
- * and adds an entry to the HPT, possibly bolting it
- */
-static void map_io_page(unsigned long ea, unsigned long pa, int flags)
-{
-	pgd_t *pgdp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-	unsigned long vsid;
-	
-	if (mem_init_done) {
-		spin_lock(&ioremap_mm.page_table_lock);
-		pgdp = pgd_offset_i(ea);
-		pmdp = pmd_alloc(&ioremap_mm, pgdp, ea);
-		ptep = pte_alloc_kernel(&ioremap_mm, pmdp, ea);
-
-		pa = absolute_to_phys(pa);
-		set_pte(ptep, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
-		spin_unlock(&ioremap_mm.page_table_lock);
-	} else {
-		unsigned long va, vpn, hash, hpteg;
-
-		/*
-		 * If the mm subsystem is not fully up, we cannot create a
-		 * linux page table entry for this mapping.  Simply bolt an
-		 * entry in the hardware page table. 
-		 */
-		vsid = get_kernel_vsid(ea);
-		va = (vsid << 28) | (ea & 0xFFFFFFF);
-		vpn = va >> PAGE_SHIFT;
-
-		hash = hpt_hash(vpn, 0);
-
-		hpteg = ((hash & htab_data.htab_hash_mask)*HPTES_PER_GROUP);
-
-		/* Panic if a pte grpup is full */
-		if (ppc_md.hpte_insert(hpteg, va, pa >> PAGE_SHIFT, 0,
-				       _PAGE_NO_CACHE|_PAGE_GUARDED|PP_RWXX,
-				       1, 0) == -1) {
-			panic("map_io_page: could not insert mapping");
-		}
-	}
-}
-
-void
-flush_tlb_mm(struct mm_struct *mm)
-{
-	struct vm_area_struct *mp;
-
-	spin_lock(&mm->page_table_lock);
-
-	for (mp = mm->mmap; mp != NULL; mp = mp->vm_next)
-		__flush_tlb_range(mm, mp->vm_start, mp->vm_end);
-
-	/* XXX are there races with checking cpu_vm_mask? - Anton */
-	cpus_clear(mm->cpu_vm_mask);
-
-	spin_unlock(&mm->page_table_lock);
-}
-
-/*
- * Callers should hold the mm->page_table_lock
- */
-void
-flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
-{
-	unsigned long context = 0;
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *ptep;
-	pte_t pte;
-	int local = 0;
-	cpumask_t tmp;
-
-	switch( REGION_ID(vmaddr) ) {
-	case VMALLOC_REGION_ID:
-		pgd = pgd_offset_k( vmaddr );
-		break;
-	case IO_REGION_ID:
-		pgd = pgd_offset_i( vmaddr );
-		break;
-	case USER_REGION_ID:
-		pgd = pgd_offset( vma->vm_mm, vmaddr );
-		context = vma->vm_mm->context;
-
-		/* XXX are there races with checking cpu_vm_mask? - Anton */
-		tmp = cpumask_of_cpu(smp_processor_id());
-		if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
-			local = 1;
-
-		break;
-	default:
-		panic("flush_tlb_page: invalid region 0x%016lx", vmaddr);
-	
-	}
-
-	if (!pgd_none(*pgd)) {
-		pmd = pmd_offset(pgd, vmaddr);
-		if (pmd_present(*pmd)) {
-			ptep = pte_offset_kernel(pmd, vmaddr);
-			/* Check if HPTE might exist and flush it if so */
-			pte = __pte(pte_update(ptep, _PAGE_HPTEFLAGS, 0));
-			if ( pte_val(pte) & _PAGE_HASHPTE ) {
-				flush_hash_page(context, vmaddr, pte, local);
-			}
-		}
-		WARN_ON(pmd_hugepage(*pmd));
-	}
-}
-
-struct ppc64_tlb_batch ppc64_tlb_batch[NR_CPUS];
-
-void
-__flush_tlb_range(struct mm_struct *mm, unsigned long start, unsigned long end)
-{
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *ptep;
-	pte_t pte;
-	unsigned long pgd_end, pmd_end;
-	unsigned long context = 0;
-	struct ppc64_tlb_batch *batch = &ppc64_tlb_batch[smp_processor_id()];
-	unsigned long i = 0;
-	int local = 0;
-	cpumask_t tmp;
-
-	switch(REGION_ID(start)) {
-	case VMALLOC_REGION_ID:
-		pgd = pgd_offset_k(start);
-		break;
-	case IO_REGION_ID:
-		pgd = pgd_offset_i(start);
-		break;
-	case USER_REGION_ID:
-		pgd = pgd_offset(mm, start);
-		context = mm->context;
-
-		/* XXX are there races with checking cpu_vm_mask? - Anton */
-		tmp = cpumask_of_cpu(smp_processor_id());
-		if (cpus_equal(mm->cpu_vm_mask, tmp))
-			local = 1;
-
-		break;
-	default:
-		panic("flush_tlb_range: invalid region for start (%016lx) and end (%016lx)\n", start, end);
-	}
-
-	do {
-		pgd_end = (start + PGDIR_SIZE) & PGDIR_MASK;
-		if (pgd_end > end)
-			pgd_end = end;
-		if (!pgd_none(*pgd)) {
-			pmd = pmd_offset(pgd, start);
-			do {
-				pmd_end = (start + PMD_SIZE) & PMD_MASK;
-				if (pmd_end > end)
-					pmd_end = end;
-				if (pmd_present(*pmd)) {
-					ptep = pte_offset_kernel(pmd, start);
-					do {
-						if (pte_val(*ptep) & _PAGE_HASHPTE) {
-							pte = __pte(pte_update(ptep, _PAGE_HPTEFLAGS, 0));
-							if (pte_val(pte) & _PAGE_HASHPTE) {								
-								batch->pte[i] = pte;
-								batch->addr[i] = start;
-								i++;
-								if (i == PPC64_TLB_BATCH_NR) {
-									flush_hash_range(context, i, local);
-									i = 0;
-								}
-							}
-						}
-						start += PAGE_SIZE;
-						++ptep;
-					} while (start < pmd_end);
-				} else {
-					WARN_ON(pmd_hugepage(*pmd));
-					start = pmd_end;
-				}
-				++pmd;
-			} while (start < pgd_end);
-		} else {
-			start = pgd_end;
-		}
-		++pgd;
-	} while (start < end);
-
-	if (i)
-		flush_hash_range(context, i, local);
-}
+#endif
 
 void free_initmem(void)
 {
diff -puN /dev/null arch/ppc64/mm/tlb.c
--- /dev/null	2004-01-30 12:31:14.000000000 +1100
+++ forakpm-anton/arch/ppc64/mm/tlb.c	2004-02-27 23:40:05.881458153 +1100
@@ -0,0 +1,155 @@
+/*
+ * This file contains the routines for flushing entries from the
+ * TLB and MMU hash table.
+ *
+ *  Derived from arch/ppc64/mm/init.c:
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
+ *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
+ *    Copyright (C) 1996 Paul Mackerras
+ *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
+ *
+ *  Derived from "arch/i386/mm/init.c"
+ *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ *
+ *  Dave Engebretsen <engebret@us.ibm.com>
+ *      Rework for PPC64 port.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+#include <asm/hardirq.h>
+#include <linux/highmem.h>
+#include <asm/rmap.h>
+
+DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
+
+/* This is declared as we are using the more or less generic
+ * include/asm-ppc64/tlb.h file -- tgall
+ */
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
+unsigned long pte_freelist_forced_free;
+
+/*
+ * Update the MMU hash table to correspond with a change to
+ * a Linux PTE.  If wrprot is true, it is permissible to
+ * change the existing HPTE to read-only rather than removing it
+ * (if we remove it we should clear the _PTE_HPTEFLAGS bits).
+ */
+void hpte_update(pte_t *ptep, unsigned long pte, int wrprot)
+{
+	struct page *ptepage;
+	struct mm_struct *mm;
+	unsigned long addr;
+	int i;
+	unsigned long context = 0;
+	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
+
+	ptepage = virt_to_page(ptep);
+	mm = (struct mm_struct *) ptepage->mapping;
+	addr = ptep_to_address(ptep);
+
+	if (REGION_ID(addr) == USER_REGION_ID)
+		context = mm->context;
+	i = batch->index;
+
+	/*
+	 * This can happen when we are in the middle of a TLB batch and
+	 * we encounter memory pressure (eg copy_page_range when it tries
+	 * to allocate a new pte). If we have to reclaim memory and end
+	 * up scanning and resetting referenced bits then our batch context
+	 * will change mid stream.
+	 */
+	if (unlikely(i != 0 && context != batch->context)) {
+		flush_tlb_pending();
+		i = 0;
+	}
+
+	if (i == 0) {
+		batch->context = context;
+		batch->mm = mm;
+	}
+	batch->pte[i] = __pte(pte);
+	batch->addr[i] = addr;
+	batch->index = ++i;
+	if (i >= PPC64_TLB_BATCH_NR)
+		flush_tlb_pending();
+}
+
+void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
+{
+	int i;
+	cpumask_t tmp = cpumask_of_cpu(smp_processor_id());
+	int local = 0;
+
+	BUG_ON(in_interrupt());
+
+	i = batch->index;
+	if (cpus_equal(batch->mm->cpu_vm_mask, tmp))
+		local = 1;
+
+	if (i == 1)
+		flush_hash_page(batch->context, batch->addr[0], batch->pte[0],
+				local);
+	else
+		flush_hash_range(batch->context, i, local);
+	batch->index = 0;
+}
+
+#ifdef CONFIG_SMP
+static void pte_free_smp_sync(void *arg)
+{
+	/* Do nothing, just ensure we sync with all CPUs */
+}
+#endif
+
+/* This is only called when we are critically out of memory
+ * (and fail to get a page in pte_free_tlb).
+ */
+void pte_free_now(struct page *ptepage)
+{
+	pte_freelist_forced_free++;
+
+	smp_call_function(pte_free_smp_sync, NULL, 0, 1);
+
+	pte_free(ptepage);
+}
+
+static void pte_free_rcu_callback(void *arg)
+{
+	struct pte_freelist_batch *batch = arg;
+	unsigned int i;
+
+	for (i = 0; i < batch->index; i++)
+		pte_free(batch->pages[i]);
+	free_page((unsigned long)batch);
+}
+
+void pte_free_submit(struct pte_freelist_batch *batch)
+{
+	INIT_RCU_HEAD(&batch->rcu);
+	call_rcu(&batch->rcu, pte_free_rcu_callback, batch);
+}
+
+void pte_free_finish(void)
+{
+	/* This is safe as we are holding page_table_lock */
+	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+
+	if (*batchp == NULL)
+		return;
+	pte_free_submit(*batchp);
+	*batchp = NULL;
+}
diff -puN include/asm-ppc64/pgtable.h~tlb_flush_rework include/asm-ppc64/pgtable.h
--- forakpm/include/asm-ppc64/pgtable.h~tlb_flush_rework	2004-02-27 23:16:07.071521720 +1100
+++ forakpm-anton/include/asm-ppc64/pgtable.h	2004-02-27 23:16:07.118518147 +1100
@@ -12,6 +12,7 @@
 #include <asm/processor.h>		/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
+#include <asm/tlbflush.h>
 #endif /* __ASSEMBLY__ */
 
 /* PMD_SHIFT determines what a second-level page table entry can map */
@@ -288,72 +289,141 @@ static inline pte_t pte_mkyoung(pte_t pt
 	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 
 /* Atomic PTE updates */
-
-static inline unsigned long pte_update( pte_t *p, unsigned long clr,
-					unsigned long set )
+static inline unsigned long pte_update(pte_t *p, unsigned long clr)
 {
 	unsigned long old, tmp;
-	
+
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%3		# pte_update\n\
-	andi.	%1,%0,%7\n\
+	andi.	%1,%0,%6\n\
 	bne-	1b \n\
 	andc	%1,%0,%4 \n\
-	or	%1,%1,%5 \n\
 	stdcx.	%1,0,%3 \n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
-	: "r" (p), "r" (clr), "r" (set), "m" (*p), "i" (_PAGE_BUSY)
+	: "r" (p), "r" (clr), "m" (*p), "i" (_PAGE_BUSY)
 	: "cc" );
 	return old;
 }
 
+/* PTE updating functions */
+extern void hpte_update(pte_t *ptep, unsigned long pte, int wrprot);
+
 static inline int ptep_test_and_clear_young(pte_t *ptep)
 {
-	return (pte_update(ptep, _PAGE_ACCESSED, 0) & _PAGE_ACCESSED) != 0;
+	unsigned long old;
+
+	old = pte_update(ptep, _PAGE_ACCESSED | _PAGE_HPTEFLAGS);
+	if (old & _PAGE_HASHPTE) {
+		hpte_update(ptep, old, 0);
+		flush_tlb_pending();	/* XXX generic code doesn't flush */
+	}
+	return (old & _PAGE_ACCESSED) != 0;
 }
 
+/*
+ * On RW/DIRTY bit transitions we can avoid flushing the hpte. For the
+ * moment we always flush but we need to fix hpte_update and test if the
+ * optimisation is worth it.
+ */
+#if 1
 static inline int ptep_test_and_clear_dirty(pte_t *ptep)
 {
-	return (pte_update(ptep, _PAGE_DIRTY, 0) & _PAGE_DIRTY) != 0;
+	unsigned long old;
+
+	old = pte_update(ptep, _PAGE_DIRTY | _PAGE_HPTEFLAGS);
+	if (old & _PAGE_HASHPTE)
+		hpte_update(ptep, old, 0);
+	return (old & _PAGE_DIRTY) != 0;
 }
 
-static inline pte_t ptep_get_and_clear(pte_t *ptep)
+static inline void ptep_set_wrprotect(pte_t *ptep)
 {
-	return __pte(pte_update(ptep, ~_PAGE_HPTEFLAGS, 0));
+	unsigned long old;
+
+	old = pte_update(ptep, _PAGE_RW | _PAGE_HPTEFLAGS);
+	if (old & _PAGE_HASHPTE)
+		hpte_update(ptep, old, 0);
+}
+
+/*
+ * We currently remove entries from the hashtable regardless of whether
+ * the entry was young or dirty. The generic routines only flush if the
+ * entry was young or dirty which is not good enough.
+ *
+ * We should be more intelligent about this but for the moment we override
+ * these functions and force a tlb flush unconditionally
+ */
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+#define ptep_clear_flush_young(__vma, __address, __ptep)		\
+({									\
+	int __young = ptep_test_and_clear_young(__ptep);		\
+	flush_tlb_page(__vma, __address);				\
+	__young;							\
+})
+
+#define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
+#define ptep_clear_flush_dirty(__vma, __address, __ptep)		\
+({									\
+	int __dirty = ptep_test_and_clear_dirty(__ptep);		\
+	flush_tlb_page(__vma, __address);				\
+	__dirty;							\
+})
+
+#else
+static inline int ptep_test_and_clear_dirty(pte_t *ptep)
+{
+	unsigned long old;
+
+	old = pte_update(ptep, _PAGE_DIRTY);
+	if ((~old & (_PAGE_HASHPTE | _PAGE_RW | _PAGE_DIRTY)) == 0)
+		hpte_update(ptep, old, 1);
+	return (old & _PAGE_DIRTY) != 0;
 }
 
 static inline void ptep_set_wrprotect(pte_t *ptep)
 {
-	pte_update(ptep, _PAGE_RW, 0);
+	unsigned long old;
+
+	old = pte_update(ptep, _PAGE_RW);
+	if ((~old & (_PAGE_HASHPTE | _PAGE_RW | _PAGE_DIRTY)) == 0)
+		hpte_update(ptep, old, 1);
 }
+#endif
 
-static inline void ptep_mkdirty(pte_t *ptep)
+static inline pte_t ptep_get_and_clear(pte_t *ptep)
 {
-	pte_update(ptep, 0, _PAGE_DIRTY);
+	unsigned long old = pte_update(ptep, ~0UL);
+
+	if (old & _PAGE_HASHPTE)
+		hpte_update(ptep, old, 0);
+	return __pte(old);
 }
 
-/*
- * Macro to mark a page protection value as "uncacheable".
- */
-#define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
+static inline void pte_clear(pte_t * ptep)
+{
+	unsigned long old = pte_update(ptep, ~0UL);
 
-#define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
+	if (old & _PAGE_HASHPTE)
+		hpte_update(ptep, old, 0);
+}
 
 /*
  * set_pte stores a linux PTE into the linux page table.
- * On machines which use an MMU hash table we avoid changing the
- * _PAGE_HASHPTE bit.
  */
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	pte_update(ptep, ~_PAGE_HPTEFLAGS, pte_val(pte) & ~_PAGE_HPTEFLAGS);
+	if (pte_present(*ptep))
+		pte_clear(ptep);
+	*ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS;
 }
 
-static inline void pte_clear(pte_t * ptep)
-{
-	pte_update(ptep, ~_PAGE_HPTEFLAGS, 0);
-}
+/*
+ * Macro to mark a page protection value as "uncacheable".
+ */
+#define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED))
+
+#define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
 extern unsigned long ioremap_bot, ioremap_base;
 
diff -puN include/asm-ppc64/tlb.h~tlb_flush_rework include/asm-ppc64/tlb.h
--- forakpm/include/asm-ppc64/tlb.h~tlb_flush_rework	2004-02-27 23:16:07.077521264 +1100
+++ forakpm-anton/include/asm-ppc64/tlb.h	2004-02-27 23:16:07.120517995 +1100
@@ -12,11 +12,9 @@
 #ifndef _PPC64_TLB_H
 #define _PPC64_TLB_H
 
-#include <asm/pgtable.h>
 #include <asm/tlbflush.h>
-#include <asm/page.h>
-#include <asm/mmu.h>
 
+struct mmu_gather;
 static inline void tlb_flush(struct mmu_gather *tlb);
 
 /* Avoid pulling in another include just for this */
@@ -29,66 +27,13 @@ static inline void tlb_flush(struct mmu_
 #define tlb_start_vma(tlb, vma)	do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
 
-/* Should make this at least as large as the generic batch size, but it
- * takes up too much space */
-#define PPC64_TLB_BATCH_NR 192
-
-struct ppc64_tlb_batch {
-	unsigned long index;
-	pte_t pte[PPC64_TLB_BATCH_NR];
-	unsigned long addr[PPC64_TLB_BATCH_NR];
-	unsigned long vaddr[PPC64_TLB_BATCH_NR];
-};
-
-extern struct ppc64_tlb_batch ppc64_tlb_batch[NR_CPUS];
-
-static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
-					unsigned long address)
-{
-	int cpu = smp_processor_id();
-	struct ppc64_tlb_batch *batch = &ppc64_tlb_batch[cpu];
-	unsigned long i = batch->index;
-	pte_t pte;
-	cpumask_t local_cpumask = cpumask_of_cpu(cpu);
-
-	if (pte_val(*ptep) & _PAGE_HASHPTE) {
-		pte = __pte(pte_update(ptep, _PAGE_HPTEFLAGS, 0));
-		if (pte_val(pte) & _PAGE_HASHPTE) {
-
-			batch->pte[i] = pte;
-			batch->addr[i] = address;
-			i++;
-
-			if (i == PPC64_TLB_BATCH_NR) {
-				int local = 0;
-
-				if (cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask))
-					local = 1;
-
-				flush_hash_range(tlb->mm->context, i, local);
-				i = 0;
-			}
-		}
-	}
-
-	batch->index = i;
-}
+#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
 
 extern void pte_free_finish(void);
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	int cpu = smp_processor_id();
-	struct ppc64_tlb_batch *batch = &ppc64_tlb_batch[cpu];
-	int local = 0;
-	cpumask_t local_cpumask = cpumask_of_cpu(smp_processor_id());
-
-	if (cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask))
-		local = 1;
-
-	flush_hash_range(tlb->mm->context, batch->index, local);
-	batch->index = 0;
-
+	flush_tlb_pending();
 	pte_free_finish();
 }
 
diff -puN include/asm-ppc64/tlbflush.h~tlb_flush_rework include/asm-ppc64/tlbflush.h
--- forakpm/include/asm-ppc64/tlbflush.h~tlb_flush_rework	2004-02-27 23:16:07.083520808 +1100
+++ forakpm-anton/include/asm-ppc64/tlbflush.h	2004-02-27 23:16:07.121517919 +1100
@@ -1,10 +1,6 @@
 #ifndef _PPC64_TLBFLUSH_H
 #define _PPC64_TLBFLUSH_H
 
-#include <linux/threads.h>
-#include <linux/mm.h>
-#include <asm/page.h>
-
 /*
  * TLB flushing:
  *
@@ -15,22 +11,39 @@
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
  */
 
-extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void __flush_tlb_range(struct mm_struct *mm,
-			    unsigned long start, unsigned long end);
-#define flush_tlb_range(vma, start, end) \
-	__flush_tlb_range(vma->vm_mm, start, end)
+#include <linux/percpu.h>
+#include <asm/page.h>
+
+#define PPC64_TLB_BATCH_NR 192
 
-#define flush_tlb_kernel_range(start, end) \
-	__flush_tlb_range(&init_mm, (start), (end))
+struct mm_struct;
+struct ppc64_tlb_batch {
+	unsigned long index;
+	unsigned long context;
+	struct mm_struct *mm;
+	pte_t pte[PPC64_TLB_BATCH_NR];
+	unsigned long addr[PPC64_TLB_BATCH_NR];
+	unsigned long vaddr[PPC64_TLB_BATCH_NR];
+};
+DECLARE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
-static inline void flush_tlb_pgtables(struct mm_struct *mm,
-				      unsigned long start, unsigned long end)
+extern void __flush_tlb_pending(struct ppc64_tlb_batch *batch);
+
+static inline void flush_tlb_pending(void)
 {
-	/* PPC has hw page tables. */
+	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
+
+	if (batch->index)
+		__flush_tlb_pending(batch);
 }
 
+#define flush_tlb_mm(mm)			flush_tlb_pending()
+#define flush_tlb_page(vma, addr)		flush_tlb_pending()
+#define flush_tlb_range(vma, start, end) \
+		do { (void)(start); flush_tlb_pending(); } while (0)
+#define flush_tlb_kernel_range(start, end)	flush_tlb_pending()
+#define flush_tlb_pgtables(mm, start, end)	do { } while (0)
+
 extern void flush_hash_page(unsigned long context, unsigned long ea, pte_t pte,
 			    int local);
 void flush_hash_range(unsigned long context, unsigned long number, int local);

_
