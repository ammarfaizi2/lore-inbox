Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318631AbSHEQLE>; Mon, 5 Aug 2002 12:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318589AbSHEQLD>; Mon, 5 Aug 2002 12:11:03 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:6860 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318658AbSHEQJ2>; Mon, 5 Aug 2002 12:09:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
Organization: IBM Deutschland Entwicklung GmbH
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 15/18 better pte invalidation
Date: Mon, 5 Aug 2002 19:54:55 +0200
User-Agent: KMail/1.4.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com>
In-Reply-To: <200208051830.50713.arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208051954.55546.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch that changes the memory management to allow s390/s390x to
make best use of its memory subsystem. There are three problems:

1) the dirty and the referenced bit is kept in the storage key (there is
   one for every physical page) and not in the page table entries. 
   Because of this difference the following piece of code is suboptimal:

        if (pte_present(pte)) {
                struct page *page = pte_page(pte);
                if (VALID_PAGE(page) && !PageReserved(page) &&
                    ptep_test_and_clear_dirty(ptep)) {
                        flush_tlb_page(vma, address);
                        set_page_dirty(page);
                }
        }

   The dirty bit is tested and cleared with ptep_test_and_clear_dirty and
   if it is set the tlb for the page is flushed. But the tlb flush is
   completly superflous on s/390 because ptep_test_and_clear_dirty has
   already done everything that is needed (the magic behind that is
   the sske instruction - see include/asm-s390/pgtable.h). To allow
   s/390 to optimize the ptep_test_and_clear_and_flush_dirty function
   is introduced that does what its name implies.

2) s/390 has an instruction called ipte (invalidate page table entry) that
   is used to get rid of virtual pages. It does two things, first it set
   the invalid bit in the pte and second it flushes the tlbs for this
   page on all cpus. Very handy but it requires that the pte it should
   flush is still valid. The introduction of establish_pte was a step
   into the right direction but it is defined in mm/memory.c. We need
   to be able to replace this function with a special s/390 variant.
   I tried to move establish_pte to include/asm/pgtable.h but this
   failed because of include order conflicts. Therefore I moved it
   to include/asm/pgalloc.h (and renamed it to ptep_establish). To make
   ptep_establish available on architectures that do not want to replace
   it (all others), I added asm-generic/pgalloc.h and an include in
   asm-<arch>/pgalloc.h for all architectures != s390. The same problem
   as with establish_pte exists with invalidating ptes. The sequence
   used in e.g. mm/vmscan.c is

        flush_cache_page(vma, address);
        pte = ptep_get_and_clear(page_table);
        flush_tlb_page(vma, addess);

   Again this makes it impossible to use the ipte in flush_tlb_page. The
   sequence of these tree lines is replaced by ptep_invalidate. The "old"
   implementation is moved to asm-generic/pgalloc.h and s/390 has its own
   implementation with ipte.

3) The 4 pages middle directory problem. This is related to the order2 patch
   for 64 bit s/390. The page size for 64 bit is 4096K but a full page middle
   directories requires 16K = 4 pages. This is bad because get_free_pages
   won't guarantee us that we can get 4 consecutive pages. The idea behind
   the order2 patch is to use a hardware feature of 64 bit s/390 that allows
   to use incomplete page middle directories. To pages is enough in 99.9% of
   all cases. To make use of this feature we have to be able to "replace"
   the pmd __pmd_alloc allocated by a large unit that contains a full page
   middle directory:

        #if defined(CONFIG_ARCH_S390X)
                new = pgd_populate(mm, pgd, new);
                if (!new)
                        return NULL;
        #else
                pgd_populate(mm, pgd, new);
        #endif

See arch/s390x/mm/init.c and include/asm-s390x/pgalloc.h for the details.

And finally the last change is a pure pure compiler optimization: move
pte_alloc and make in extern inline. The compiler will generate a copy
that can be called from other modules AND inline it in mm/memory.c. This
saves a function call on the minor fault path and function calling is
expensive on s/390.


diff -urN linux-2.4.19-rc3/include/asm-alpha/pgalloc.h linux-2.4.19-s390/include/asm-alpha/pgalloc.h
--- linux-2.4.19-rc3/include/asm-alpha/pgalloc.h	Tue Jul 30 09:02:30 2002
+++ linux-2.4.19-s390/include/asm-alpha/pgalloc.h	Tue Jul 30 09:02:56 2002
@@ -347,4 +347,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ALPHA_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-arm/pgalloc.h linux-2.4.19-s390/include/asm-arm/pgalloc.h
--- linux-2.4.19-rc3/include/asm-arm/pgalloc.h	Sun Aug 12 20:14:00 2001
+++ linux-2.4.19-s390/include/asm-arm/pgalloc.h	Tue Jul 30 09:01:23 2002
@@ -138,4 +138,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif
diff -urN linux-2.4.19-rc3/include/asm-generic/pgalloc.h linux-2.4.19-s390/include/asm-generic/pgalloc.h
--- linux-2.4.19-rc3/include/asm-generic/pgalloc.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.19-s390/include/asm-generic/pgalloc.h	Tue Jul 30 09:01:23 2002
@@ -0,0 +1,37 @@
+#ifndef _ASM_GENERIC_PGALLOC_H
+#define _ASM_GENERIC_PGALLOC_H
+
+static inline int ptep_test_and_clear_and_flush_young(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{
+	if (!ptep_test_and_clear_young(ptep))
+		return 0;
+	flush_tlb_page(vma, address);
+	return 1;
+}
+
+static inline int ptep_test_and_clear_and_flush_dirty(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{
+	if (!ptep_test_and_clear_dirty(ptep))
+		return 0;
+	flush_tlb_page(vma, address);
+	return 1;
+}
+
+static inline void ptep_establish(struct vm_area_struct *vma, unsigned long address, pte_t *ptep, pte_t entry)
+{
+	set_pte(ptep, entry);
+	flush_tlb_page(vma, address);
+	update_mmu_cache(vma, address, entry);
+}
+
+static inline pte_t ptep_invalidate(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
+{
+	pte_t pte;
+
+	flush_cache_page(vma, address);
+        pte = ptep_get_and_clear(ptep);
+	flush_tlb_page(vma, address);
+	return pte;
+}
+
+#endif /* _ASM_GENERIC_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-i386/pgalloc.h linux-2.4.19-s390/include/asm-i386/pgalloc.h
--- linux-2.4.19-rc3/include/asm-i386/pgalloc.h	Tue Jul 30 09:02:30 2002
+++ linux-2.4.19-s390/include/asm-i386/pgalloc.h	Tue Jul 30 09:02:56 2002
@@ -235,4 +235,6 @@
 	flush_tlb_mm(mm);
 }
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _I386_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-ia64/pgalloc.h linux-2.4.19-s390/include/asm-ia64/pgalloc.h
--- linux-2.4.19-rc3/include/asm-ia64/pgalloc.h	Fri Nov  9 23:26:17 2001
+++ linux-2.4.19-s390/include/asm-ia64/pgalloc.h	Tue Jul 30 09:01:23 2002
@@ -268,4 +268,6 @@
 	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
 }
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ASM_IA64_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-m68k/pgalloc.h linux-2.4.19-s390/include/asm-m68k/pgalloc.h
--- linux-2.4.19-rc3/include/asm-m68k/pgalloc.h	Tue Jul 30 09:02:31 2002
+++ linux-2.4.19-s390/include/asm-m68k/pgalloc.h	Tue Jul 30 09:02:57 2002
@@ -164,4 +164,6 @@
 #include <asm/motorola_pgalloc.h>
 #endif
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* M68K_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-mips/pgalloc.h linux-2.4.19-s390/include/asm-mips/pgalloc.h
--- linux-2.4.19-rc3/include/asm-mips/pgalloc.h	Tue Jul 30 09:02:31 2002
+++ linux-2.4.19-s390/include/asm-mips/pgalloc.h	Tue Jul 30 09:02:57 2002
@@ -194,4 +194,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ASM_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-mips64/pgalloc.h linux-2.4.19-s390/include/asm-mips64/pgalloc.h
--- linux-2.4.19-rc3/include/asm-mips64/pgalloc.h	Tue Jul 30 09:02:31 2002
+++ linux-2.4.19-s390/include/asm-mips64/pgalloc.h	Tue Jul 30 09:02:57 2002
@@ -198,4 +198,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ASM_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-parisc/pgalloc.h linux-2.4.19-s390/include/asm-parisc/pgalloc.h
--- linux-2.4.19-rc3/include/asm-parisc/pgalloc.h	Tue Jul 30 09:02:32 2002
+++ linux-2.4.19-s390/include/asm-parisc/pgalloc.h	Tue Jul 30 09:02:57 2002
@@ -404,4 +404,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif
diff -urN linux-2.4.19-rc3/include/asm-ppc/pgalloc.h linux-2.4.19-s390/include/asm-ppc/pgalloc.h
--- linux-2.4.19-rc3/include/asm-ppc/pgalloc.h	Tue May 22 00:02:06 2001
+++ linux-2.4.19-s390/include/asm-ppc/pgalloc.h	Tue Jul 30 09:01:23 2002
@@ -146,5 +146,7 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _PPC_PGALLOC_H */
 #endif /* __KERNEL__ */
diff -urN linux-2.4.19-rc3/include/asm-sh/pgalloc.h linux-2.4.19-s390/include/asm-sh/pgalloc.h
--- linux-2.4.19-rc3/include/asm-sh/pgalloc.h	Sat Sep  8 21:29:09 2001
+++ linux-2.4.19-s390/include/asm-sh/pgalloc.h	Tue Jul 30 09:01:23 2002
@@ -153,4 +153,7 @@
 	pte_t old_pte = *ptep;
 	set_pte(ptep, pte_mkdirty(old_pte));
 }
+
+#include <asm-generic/pgalloc.h>
+
 #endif /* __ASM_SH_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-sparc/pgalloc.h linux-2.4.19-s390/include/asm-sparc/pgalloc.h
--- linux-2.4.19-rc3/include/asm-sparc/pgalloc.h	Tue Jul 30 09:02:32 2002
+++ linux-2.4.19-s390/include/asm-sparc/pgalloc.h	Tue Jul 30 09:02:57 2002
@@ -141,4 +141,6 @@
 
 #define pte_free(pte)		free_pte_fast(pte)
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _SPARC_PGALLOC_H */
diff -urN linux-2.4.19-rc3/include/asm-sparc64/pgalloc.h linux-2.4.19-s390/include/asm-sparc64/pgalloc.h
--- linux-2.4.19-rc3/include/asm-sparc64/pgalloc.h	Tue Jul 30 09:02:32 2002
+++ linux-2.4.19-s390/include/asm-sparc64/pgalloc.h	Tue Jul 30 09:02:57 2002
@@ -304,4 +304,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _SPARC64_PGALLOC_H */
diff -urN linux-2.4.19-rc3/mm/filemap.c linux-2.4.19-s390/mm/filemap.c
--- linux-2.4.19-rc3/mm/filemap.c	Tue Jul 30 09:02:32 2002
+++ linux-2.4.19-s390/mm/filemap.c	Tue Jul 30 09:02:57 2002
@@ -1296,7 +1296,7 @@
  * bit. Otherwise, just mark it for future
  * action..
  */
-void mark_page_accessed(struct page *page)
+inline void mark_page_accessed(struct page *page)
 {
 	if (!PageActive(page) && PageReferenced(page)) {
 		activate_page(page);
@@ -2062,8 +2062,8 @@
 
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
-		if (VALID_PAGE(page) && !PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
-			flush_tlb_page(vma, address);
+		if (VALID_PAGE(page) && !PageReserved(page) &&
+                    ptep_test_and_clear_and_flush_dirty(vma, address, ptep)) {
 			set_page_dirty(page);
 		}
 	}
diff -urN linux-2.4.19-rc3/mm/memory.c linux-2.4.19-s390/mm/memory.c
--- linux-2.4.19-rc3/mm/memory.c	Tue Jul 30 09:02:32 2002
+++ linux-2.4.19-s390/mm/memory.c	Tue Jul 30 09:02:57 2002
@@ -166,6 +166,84 @@
 #define PMD_TABLE_MASK	((PTRS_PER_PMD-1) * sizeof(pmd_t))
 
 /*
+ * Allocate page middle directory.
+ *
+ * We've already handled the fast-path in-line, and we own the
+ * page table lock.
+ *
+ * On a two-level page table, this ends up actually being entirely
+ * optimized away.
+ */
+pmd_t *__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
+{
+	pmd_t *new;
+
+	/* "fast" allocation can happen without dropping the lock.. */
+	new = pmd_alloc_one_fast(mm, address);
+	if (!new) {
+		spin_unlock(&mm->page_table_lock);
+		new = pmd_alloc_one(mm, address);
+		spin_lock(&mm->page_table_lock);
+		if (!new)
+			return NULL;
+
+		/*
+		 * Because we dropped the lock, we should re-check the
+		 * entry, as somebody else could have populated it..
+		 */
+		if (!pgd_none(*pgd)) {
+			pmd_free(new);
+			goto out;
+		}
+	}
+#if defined(CONFIG_ARCH_S390X)
+	new = pgd_populate(mm, pgd, new);
+	if (!new)
+		return NULL;
+#else
+	pgd_populate(mm, pgd, new);
+#endif
+out:
+	return pmd_offset(pgd, address);
+}
+
+/*
+ * Allocate the page table directory.
+ *
+ * We've already handled the fast-path in-line, and we own the
+ * page table lock.
+ */
+inline pte_t *
+pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+{
+	if (pmd_none(*pmd)) {
+		pte_t *new;
+
+		/* "fast" allocation can happen without dropping the lock.. */
+		new = pte_alloc_one_fast(mm, address);
+		if (!new) {
+			spin_unlock(&mm->page_table_lock);
+			new = pte_alloc_one(mm, address);
+			spin_lock(&mm->page_table_lock);
+			if (!new)
+				return NULL;
+
+			/*
+			 * Because we dropped the lock, we should re-check the
+			 * entry, as somebody else could have populated it..
+			 */
+			if (!pmd_none(*pmd)) {
+				pte_free(new);
+				goto out;
+			}
+		}
+		pmd_populate(mm, pmd, new);
+	}
+out:
+	return pte_offset(pmd, address);
+}
+
+/*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.
@@ -900,20 +978,6 @@
 	return error;
 }
 
-/*
- * Establish a new mapping:
- *  - flush the old one
- *  - update the page tables
- *  - inform the TLB about the new one
- *
- * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
- */
-static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
-{
-	set_pte(page_table, entry);
-	flush_tlb_page(vma, address);
-	update_mmu_cache(vma, address, entry);
-}
 
 /*
  * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
@@ -923,7 +987,8 @@
 {
 	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
-	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
+	ptep_establish(vma, address, page_table,
+		pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
 
 /*
@@ -960,7 +1025,8 @@
 		unlock_page(old_page);
 		if (reuse) {
 			flush_cache_page(vma, address);
-			establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
+			ptep_establish(vma, address, page_table,
+				pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
 			spin_unlock(&mm->page_table_lock);
 			return 1;	/* Minor fault */
 		}
@@ -1354,7 +1420,7 @@
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
-	establish_pte(vma, address, pte, entry);
+	ptep_establish(vma, address, pte, entry);
 	spin_unlock(&mm->page_table_lock);
 	return 1;
 }
@@ -1385,77 +1451,6 @@
 	}
 	spin_unlock(&mm->page_table_lock);
 	return -1;
-}
-
-/*
- * Allocate page middle directory.
- *
- * We've already handled the fast-path in-line, and we own the
- * page table lock.
- *
- * On a two-level page table, this ends up actually being entirely
- * optimized away.
- */
-pmd_t *__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
-{
-	pmd_t *new;
-
-	/* "fast" allocation can happen without dropping the lock.. */
-	new = pmd_alloc_one_fast(mm, address);
-	if (!new) {
-		spin_unlock(&mm->page_table_lock);
-		new = pmd_alloc_one(mm, address);
-		spin_lock(&mm->page_table_lock);
-		if (!new)
-			return NULL;
-
-		/*
-		 * Because we dropped the lock, we should re-check the
-		 * entry, as somebody else could have populated it..
-		 */
-		if (!pgd_none(*pgd)) {
-			pmd_free(new);
-			goto out;
-		}
-	}
-	pgd_populate(mm, pgd, new);
-out:
-	return pmd_offset(pgd, address);
-}
-
-/*
- * Allocate the page table directory.
- *
- * We've already handled the fast-path in-line, and we own the
- * page table lock.
- */
-pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
-{
-	if (pmd_none(*pmd)) {
-		pte_t *new;
-
-		/* "fast" allocation can happen without dropping the lock.. */
-		new = pte_alloc_one_fast(mm, address);
-		if (!new) {
-			spin_unlock(&mm->page_table_lock);
-			new = pte_alloc_one(mm, address);
-			spin_lock(&mm->page_table_lock);
-			if (!new)
-				return NULL;
-
-			/*
-			 * Because we dropped the lock, we should re-check the
-			 * entry, as somebody else could have populated it..
-			 */
-			if (!pmd_none(*pmd)) {
-				pte_free(new);
-				goto out;
-			}
-		}
-		pmd_populate(mm, pmd, new);
-	}
-out:
-	return pte_offset(pmd, address);
 }
 
 int make_pages_present(unsigned long addr, unsigned long end)
diff -urN linux-2.4.19-rc3/mm/vmscan.c linux-2.4.19-s390/mm/vmscan.c
--- linux-2.4.19-rc3/mm/vmscan.c	Tue Jul 30 09:02:32 2002
+++ linux-2.4.19-s390/mm/vmscan.c	Tue Jul 30 09:02:57 2002
@@ -68,9 +68,7 @@
 	 * is needed on CPUs which update the accessed and dirty
 	 * bits in hardware.
 	 */
-	flush_cache_page(vma, address);
-	pte = ptep_get_and_clear(page_table);
-	flush_tlb_page(vma, address);
+	pte = ptep_invalidate(vma, address, page_table);
 
 	if (pte_dirty(pte))
 		set_page_dirty(page);


