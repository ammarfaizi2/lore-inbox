Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292565AbSBVChf>; Thu, 21 Feb 2002 21:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292571AbSBVCh1>; Thu, 21 Feb 2002 21:37:27 -0500
Received: from are.twiddle.net ([64.81.246.98]:41358 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S292565AbSBVChV>;
	Thu, 21 Feb 2002 21:37:21 -0500
Date: Thu, 21 Feb 2002 18:37:20 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org
Subject: alpha update for pte highmem stuff in 2.5.5
Message-ID: <20020221183720.A13085@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.369.8.3 -> 1.369.8.4
#	include/asm-alpha/pgalloc.h	1.6     -> 1.7    
#	include/asm-alpha/system.h	1.7     -> 1.8    
#	arch/alpha/kernel/core_irongate.c	1.3     -> 1.4    
#	include/linux/highmem.h	1.11    -> 1.12   
#	include/asm-alpha/pgtable.h	1.9     -> 1.10   
#	arch/alpha/kernel/process.c	1.11    -> 1.12   
#	arch/alpha/mm/init.c	1.6     -> 1.7    
#	include/asm-alpha/smp.h	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/21	rth@fidel.sfbay.redhat.com	1.369.8.4
# Update Alpha for Ingo's page tables in highmem patch.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
--- a/arch/alpha/kernel/core_irongate.c	Thu Feb 21 18:35:40 2002
+++ b/arch/alpha/kernel/core_irongate.c	Thu Feb 21 18:35:40 2002
@@ -455,7 +455,7 @@
 	if (address >= end)
 		BUG();
 	do {
-		pte_t * pte = pte_alloc(&init_mm, pmd, address);
+		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		irongate_remap_area_pte(pte, address, end - address, 
diff -Nru a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
--- a/arch/alpha/kernel/process.c	Thu Feb 21 18:35:40 2002
+++ b/arch/alpha/kernel/process.c	Thu Feb 21 18:35:40 2002
@@ -64,7 +64,6 @@
 		while (!need_resched())
 			barrier();
 		schedule();
-		check_pgt_cache();
 	}
 }
 
diff -Nru a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
--- a/arch/alpha/mm/init.c	Thu Feb 21 18:35:40 2002
+++ b/arch/alpha/mm/init.c	Thu Feb 21 18:35:40 2002
@@ -42,12 +42,8 @@
 
 static struct pcb_struct original_pcb;
 
-#ifndef CONFIG_SMP
-struct pgtable_cache_struct quicklists;
-#endif
-
 pgd_t *
-get_pgd_slow(void)
+pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret, *init;
 
@@ -69,28 +65,26 @@
 	return ret;
 }
 
-int do_check_pgt_cache(int low, int high)
+pte_t *
+pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	int freed = 0;
-	if(pgtable_cache_size > high) {
-		do {
-			if(pgd_quicklist) {
-				free_pgd_slow(get_pgd_fast());
-				freed++;
-			}
-			if(pmd_quicklist) {
-				pmd_free_slow(pmd_alloc_one_fast(NULL, 0));
-				freed++;
-			}
-			if(pte_quicklist) {
-				pte_free_slow(pte_alloc_one_fast(NULL, 0));
-				freed++;
-			}
-		} while(pgtable_cache_size > low);
+	pte_t *pte;
+	long timeout = 10;
+
+ retry:
+	pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	if (pte)
+		clear_page(pte);
+	else if (--timeout >= 0) {
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout(HZ);
+		goto retry;
 	}
-	return freed;
+
+	return pte;
 }
 
+
 /*
  * BAD_PAGE is the page that is used for page faults when linux
  * is out-of-memory. Older versions of linux just did a
@@ -145,7 +139,6 @@
 	printk("%ld reserved pages\n",reserved);
 	printk("%ld pages shared\n",shared);
 	printk("%ld pages swap cached\n",cached);
-	printk("%ld pages in page table cache\n",pgtable_cache_size);
 	show_buffers();
 }
 #endif
@@ -260,7 +253,7 @@
 			unsigned long paddr = crb->map[i].pa;
 			crb->map[i].va = vaddr;
 			for (j = 0; j < crb->map[i].count; ++j) {
-				set_pte(pte_offset(pmd, vaddr),
+				set_pte(pte_offset_kernel(pmd, vaddr),
 					mk_pte_phys(paddr, PAGE_KERNEL));
 				paddr += PAGE_SIZE;
 				vaddr += PAGE_SIZE;
diff -Nru a/include/asm-alpha/pgalloc.h b/include/asm-alpha/pgalloc.h
--- a/include/asm-alpha/pgalloc.h	Thu Feb 21 18:35:40 2002
+++ b/include/asm-alpha/pgalloc.h	Thu Feb 21 18:35:40 2002
@@ -230,121 +230,66 @@
  * used to allocate a kernel page table - this turns on ASN bits
  * if any.
  */
-#ifndef CONFIG_SMP
-extern struct pgtable_cache_struct {
-	unsigned long *pgd_cache;
-	unsigned long *pmd_cache;
-	unsigned long *pte_cache;
-	unsigned long pgtable_cache_sz;
-} quicklists;
-#else
-#include <asm/smp.h>
-#define quicklists cpu_data[smp_processor_id()]
-#endif
-#define pgd_quicklist (quicklists.pgd_cache)
-#define pmd_quicklist (quicklists.pmd_cache)
-#define pte_quicklist (quicklists.pte_cache)
-#define pgtable_cache_size (quicklists.pgtable_cache_sz)
-
-#define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
-#define pgd_populate(mm, pgd, pmd)	pgd_set(pgd, pmd)
-
-extern pgd_t *get_pgd_slow(void);
-
-static inline pgd_t *get_pgd_fast(void)
-{
-	unsigned long *ret;
-
-	if ((ret = pgd_quicklist) != NULL) {
-		pgd_quicklist = (unsigned long *)(*ret);
-		ret[0] = 0;
-		pgtable_cache_size--;
-	} else
-		ret = (unsigned long *)get_pgd_slow();
-	return (pgd_t *)ret;
-}
-
-static inline void free_pgd_fast(pgd_t *pgd)
-{
-	*(unsigned long *)pgd = (unsigned long) pgd_quicklist;
-	pgd_quicklist = (unsigned long *) pgd;
-	pgtable_cache_size++;
-}
 
-static inline void free_pgd_slow(pgd_t *pgd)
+static inline void
+pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
 {
-	free_page((unsigned long)pgd);
+	pmd_set(pmd, (pte_t *)((pte - mem_map) << PAGE_SHIFT));
 }
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline void
+pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 {
-	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL);
-	if (ret)
-		clear_page(ret);
-	return ret;
+	pmd_set(pmd, pte);
 }
 
-static inline pmd_t *pmd_alloc_one_fast(struct mm_struct *mm, unsigned long address)
+static inline void
+pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
 {
-	unsigned long *ret;
-
-	if ((ret = (unsigned long *)pte_quicklist) != NULL) {
-		pte_quicklist = (unsigned long *)(*ret);
-		ret[0] = 0;
-		pgtable_cache_size--;
-	}
-	return (pmd_t *)ret;
+	pgd_set(pgd, pmd);
 }
 
-static inline void pmd_free_fast(pmd_t *pmd)
+extern pgd_t *pgd_alloc(struct mm_struct *mm);
+
+static inline void
+pgd_free(pgd_t *pgd)
 {
-	*(unsigned long *)pmd = (unsigned long) pte_quicklist;
-	pte_quicklist = (unsigned long *) pmd;
-	pgtable_cache_size++;
+	free_page((unsigned long)pgd);
 }
 
-static inline void pmd_free_slow(pmd_t *pmd)
+static inline pmd_t *
+pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	free_page((unsigned long)pmd);
+	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL);
+	if (ret)
+		clear_page(ret);
+	return ret;
 }
 
-static inline pte_t *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline void
+pmd_free(pmd_t *pmd)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL);
-	if (pte)
-		clear_page(pte);
-	return pte;
+	free_page((unsigned long)pmd);
 }
 
-static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm, unsigned long address)
-{
-	unsigned long *ret;
+extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
 
-	if ((ret = (unsigned long *)pte_quicklist) != NULL) {
-		pte_quicklist = (unsigned long *)(*ret);
-		ret[0] = 0;
-		pgtable_cache_size--;
-	}
-	return (pte_t *)ret;
+static inline void
+pte_free_kernel(pte_t *pte)
+{
+	free_page((unsigned long)pte);
 }
 
-static inline void pte_free_fast(pte_t *pte)
+static inline struct page *
+pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	*(unsigned long *)pte = (unsigned long) pte_quicklist;
-	pte_quicklist = (unsigned long *) pte;
-	pgtable_cache_size++;
+	return virt_to_page(pte_alloc_one_kernel(mm, addr));
 }
 
-static inline void pte_free_slow(pte_t *pte)
+static inline void
+pte_free(struct page *page)
 {
-	free_page((unsigned long)pte);
+	__free_page(page);
 }
-
-#define pte_free(pte)		pte_free_fast(pte)
-#define pmd_free(pmd)		pmd_free_fast(pmd)
-#define pgd_free(pgd)		free_pgd_fast(pgd)
-#define pgd_alloc(mm)		get_pgd_fast()
-
-extern int do_check_pgt_cache(int, int);
 
 #endif /* _ALPHA_PGALLOC_H */
diff -Nru a/include/asm-alpha/pgtable.h b/include/asm-alpha/pgtable.h
--- a/include/asm-alpha/pgtable.h	Thu Feb 21 18:35:40 2002
+++ b/include/asm-alpha/pgtable.h	Thu Feb 21 18:35:40 2002
@@ -248,8 +248,13 @@
 })
 #endif
 
-extern inline unsigned long pmd_page(pmd_t pmd)
-{ return PAGE_OFFSET + ((pmd_val(pmd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
+extern inline unsigned long
+pmd_page_kernel(pmd_t pmd)
+{
+	return ((pmd_val(pmd) & _PFN_MASK) >> (32-PAGE_SHIFT)) + PAGE_OFFSET;
+}
+
+#define pmd_page(pmd)	(mem_map + ((pmd_val(pmd) & _PFN_MASK) >> 32))
 
 extern inline unsigned long pgd_page(pgd_t pgd)
 { return PAGE_OFFSET + ((pgd_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
@@ -306,10 +311,16 @@
 }
 
 /* Find an entry in the third-level page table.. */
-extern inline pte_t * pte_offset(pmd_t * dir, unsigned long address)
+extern inline pte_t * pte_offset_kernel(pmd_t * dir, unsigned long address)
 {
-	return (pte_t *) pmd_page(*dir) + ((address >> PAGE_SHIFT) & (PTRS_PER_PAGE - 1));
+	return (pte_t *) pmd_page_kernel(*dir)
+		+ ((address >> PAGE_SHIFT) & (PTRS_PER_PAGE - 1));
 }
+
+#define pte_offset_map(dir,addr)	pte_offset_kernel((dir),(addr))
+#define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir),(addr))
+#define pte_unmap(pte)			do { } while (0)
+#define pte_unmap_nested(pte)		do { } while (0)
 
 extern pgd_t swapper_pg_dir[1024];
 
diff -Nru a/include/asm-alpha/smp.h b/include/asm-alpha/smp.h
--- a/include/asm-alpha/smp.h	Thu Feb 21 18:35:40 2002
+++ b/include/asm-alpha/smp.h	Thu Feb 21 18:35:40 2002
@@ -29,10 +29,6 @@
 	unsigned long last_asn;
 	int need_new_asn;
 	int asn_lock;
-	unsigned long *pgd_cache;
-	unsigned long *pmd_cache;
-	unsigned long *pte_cache;
-	unsigned long pgtable_cache_sz;
 	unsigned long ipi_count;
 	unsigned long irq_attempt[NR_IRQS];
 	unsigned long prof_multiplier;
diff -Nru a/include/asm-alpha/system.h b/include/asm-alpha/system.h
--- a/include/asm-alpha/system.h	Thu Feb 21 18:35:40 2002
+++ b/include/asm-alpha/system.h	Thu Feb 21 18:35:40 2002
@@ -137,6 +137,7 @@
 	check_mmu_context();						  \
 } while (0)
 
+struct task_struct;
 extern void alpha_switch_to(unsigned long, struct task_struct*);
 
 #define mb() \
diff -Nru a/include/linux/highmem.h b/include/linux/highmem.h
--- a/include/linux/highmem.h	Thu Feb 21 18:35:40 2002
+++ b/include/linux/highmem.h	Thu Feb 21 18:35:40 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/bio.h>
 #include <linux/fs.h>
+#include <asm/pgalloc.h>
 
 #ifdef CONFIG_HIGHMEM
 
