Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRADSoW>; Thu, 4 Jan 2001 13:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131086AbRADSoC>; Thu, 4 Jan 2001 13:44:02 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:16277 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S129387AbRADSnx>; Thu, 4 Jan 2001 13:43:53 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200101041843.TAA27837@faui11.informatik.uni-erlangen.de>
Subject: Re: [RFC, PATCH] TLB flush changes for S/390
To: davem@redhat.com, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Date: Thu, 4 Jan 2001 19:43:43 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ton@de.ibm.com
In-Reply-To: <200101040628.WAA01899@pizda.ninka.net> from "David S. Miller" at Jan 03, 2001 10:28:07 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Miller wrote:
>    From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
>    Date: 	Mon, 1 Jan 2001 23:15:26 +0100 (MET)
> 
>     * Is there some reason why ptep_test_and_clear_young should
>       *not*, after all, flush the TLB?
> 
> Yes, because the accuracy of that state bit is not required to
> be %100 perfect.  Less SMP tlb flushing traffic from vmscan
> runs is desirable, thus no flush.

Ah, I see.  I've made a new patch that leaves the accessed bit
alone.   (It doesn't matter on 390 anyway, as the accessed bit
does not reside in the page table, but in the storage key ...)

The patch is against the current (01/04) prerelease.  Note that
this patch now should not change *anything* for non-S/390
architectures.

I think I've solved the pgtable.h/pgalloc.h interdependencies
by moving the new routines to pgalloc.h.  To avoid copying them
to all architectures, I've introduced an asm-generic/pgalloc.h
file analogous to asm-generic/pgtable.h.  Is this solution
acceptable?  The alternative would be to use #ifdef in the
common code ...


Bye,
Ulrich


diff -urN linux-2.4.0-prerelease/include/asm-alpha/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-alpha/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-alpha/pgalloc.h	Fri Dec 29 23:07:23 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-alpha/pgalloc.h	Thu Jan  4 14:08:59 2001
@@ -371,4 +371,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ALPHA_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-arm/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-arm/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-arm/pgalloc.h	Tue Sep 19 00:15:24 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-arm/pgalloc.h	Thu Jan  4 14:09:36 2001
@@ -212,4 +212,6 @@
 #endif
 }
 
+#include <asm-generic/pgalloc.h>
+
 #endif
diff -urN linux-2.4.0-prerelease/include/asm-generic/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-generic/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-generic/pgalloc.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.0-prerelease-tlb/include/asm-generic/pgalloc.h	Thu Jan  4 14:14:41 2001
@@ -0,0 +1,34 @@
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
+	pte_t pte = ptep_get_and_clear(ptep);
+	flush_tlb_page(vma, address);
+	return pte;
+}
+
+#endif /* _ASM_GENERIC_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-i386/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-i386/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-i386/pgalloc.h	Sun Dec 31 20:10:17 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-i386/pgalloc.h	Thu Jan  4 14:19:02 2001
@@ -230,4 +230,6 @@
 	/* i386 does not keep any page table caches in TLB */
 }
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _I386_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-ia64/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-ia64/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-ia64/pgalloc.h	Tue Oct 10 02:54:59 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-ia64/pgalloc.h	Thu Jan  4 14:09:50 2001
@@ -269,4 +269,6 @@
 	flush_tlb_range(mm, ia64_thash(start), ia64_thash(end));
 }
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ASM_IA64_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-m68k/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-m68k/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-m68k/pgalloc.h	Tue Dec  5 21:43:48 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-m68k/pgalloc.h	Thu Jan  4 14:10:02 2001
@@ -162,4 +162,6 @@
 #include <asm/motorola_pgalloc.h>
 #endif
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* M68K_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-mips/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-mips/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-mips/pgalloc.h	Mon May 15 21:10:26 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-mips/pgalloc.h	Thu Jan  4 14:10:10 2001
@@ -213,4 +213,6 @@
 #endif
 }
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ASM_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-mips64/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-mips64/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-mips64/pgalloc.h	Wed Nov 29 06:42:04 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-mips64/pgalloc.h	Thu Jan  4 14:10:18 2001
@@ -202,4 +202,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _ASM_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-parisc/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-parisc/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-parisc/pgalloc.h	Tue Dec  5 21:29:39 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-parisc/pgalloc.h	Thu Jan  4 14:10:26 2001
@@ -401,4 +401,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif
diff -urN linux-2.4.0-prerelease/include/asm-ppc/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-ppc/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-ppc/pgalloc.h	Sun Nov 12 03:23:11 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-ppc/pgalloc.h	Thu Jan  4 14:10:45 2001
@@ -173,5 +173,7 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _PPC_PGALLOC_H */
 #endif /* __KERNEL__ */
diff -urN linux-2.4.0-prerelease/include/asm-s390/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-s390/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-s390/pgalloc.h	Fri May 12 20:41:44 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-s390/pgalloc.h	Thu Jan  4 14:38:52 2001
@@ -342,4 +342,39 @@
         /* S/390 does not keep any page table caches in TLB */
 }
 
+
+static inline int ptep_test_and_clear_and_flush_young(struct vm_area_struct *vma, 
+                                                      unsigned long address, pte_t *ptep)
+{
+	/* No need to flush TLB; bits are in storage key */
+	return ptep_test_and_clear_young(ptep);
+}
+
+static inline int ptep_test_and_clear_and_flush_dirty(struct vm_area_struct *vma, 
+                                                      unsigned long address, pte_t *ptep)
+{
+	/* No need to flush TLB; bits are in storage key */
+	return ptep_test_and_clear_dirty(ptep);
+}
+
+static inline pte_t ptep_invalidate(struct vm_area_struct *vma, 
+                                    unsigned long address, pte_t *ptep)
+{
+	pte_t pte = *ptep;
+	if (!(pte_val(pte) & _PAGE_INVALID)) {
+		/* S390 has 1mb segments, we are emulating 4MB segments */
+		pte_t *pto = (pte_t *) (((unsigned long) ptep) & 0x7ffffc00);
+		__asm__ __volatile__ ("ipte %0,%1" : : "a" (pto), "a" (address));
+	}
+	pte_clear(ptep);
+	return pte;
+}
+
+static inline void ptep_establish(struct vm_area_struct *vma, 
+                                  unsigned long address, pte_t *ptep, pte_t entry)
+{
+	ptep_invalidate(vma, address, ptep);
+	set_pte(ptep, entry);
+}
+
 #endif /* _S390_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-sh/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-sh/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-sh/pgalloc.h	Fri Oct 13 21:06:52 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-sh/pgalloc.h	Thu Jan  4 14:11:31 2001
@@ -165,4 +165,6 @@
 {
 }
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* __ASM_SH_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-sparc/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-sparc/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-sparc/pgalloc.h	Mon Oct 16 22:36:08 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-sparc/pgalloc.h	Thu Jan  4 14:11:38 2001
@@ -139,4 +139,6 @@
 #define pgd_free(pgd) BTFIXUP_CALL(pgd_free)(pgd)
 #define pgd_alloc() BTFIXUP_CALL(pgd_alloc)()
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _SPARC64_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/include/asm-sparc64/pgalloc.h linux-2.4.0-prerelease-tlb/include/asm-sparc64/pgalloc.h
--- linux-2.4.0-prerelease/include/asm-sparc64/pgalloc.h	Mon Dec 11 21:37:03 2000
+++ linux-2.4.0-prerelease-tlb/include/asm-sparc64/pgalloc.h	Thu Jan  4 14:11:44 2001
@@ -316,4 +316,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
+#include <asm-generic/pgalloc.h>
+
 #endif /* _SPARC64_PGALLOC_H */
diff -urN linux-2.4.0-prerelease/mm/filemap.c linux-2.4.0-prerelease-tlb/mm/filemap.c
--- linux-2.4.0-prerelease/mm/filemap.c	Thu Jan  4 13:43:29 2001
+++ linux-2.4.0-prerelease-tlb/mm/filemap.c	Thu Jan  4 14:21:24 2001
@@ -1587,9 +1587,9 @@
 {
 	pte_t pte = *ptep;
 
-	if (pte_present(pte) && ptep_test_and_clear_dirty(ptep)) {
+	if (   pte_present(pte) 
+            && ptep_test_and_clear_and_flush_dirty(vma, address, ptep)) {
 		struct page *page = pte_page(pte);
-		flush_tlb_page(vma, address);
 		set_page_dirty(page);
 	}
 	return 0;
diff -urN linux-2.4.0-prerelease/mm/memory.c linux-2.4.0-prerelease-tlb/mm/memory.c
--- linux-2.4.0-prerelease/mm/memory.c	Thu Jan  4 13:43:29 2001
+++ linux-2.4.0-prerelease-tlb/mm/memory.c	Thu Jan  4 13:56:20 2001
@@ -776,18 +776,6 @@
 	return error;
 }
 
-/*
- * Establish a new mapping:
- *  - flush the old one
- *  - update the page tables
- *  - inform the TLB about the new one
- */
-static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
-{
-	set_pte(page_table, entry);
-	flush_tlb_page(vma, address);
-	update_mmu_cache(vma, address, entry);
-}
 
 static inline void break_cow(struct vm_area_struct * vma, struct page *	old_page, struct page * new_page, unsigned long address, 
 		pte_t *page_table)
@@ -795,7 +783,7 @@
 	copy_cow_page(old_page,new_page,address);
 	flush_page_to_ram(new_page);
 	flush_cache_page(vma, address);
-	establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
+	ptep_establish(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot))));
 }
 
 /*
@@ -853,7 +841,7 @@
 		/* FallThrough */
 	case 1:
 		flush_cache_page(vma, address);
-		establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
+		ptep_establish(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
 		spin_unlock(&mm->page_table_lock);
 		return 1;	/* Minor fault */
 	}
@@ -1181,7 +1169,7 @@
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
-	establish_pte(vma, address, pte, entry);
+	ptep_establish(vma, address, pte, entry);
 	spin_unlock(&mm->page_table_lock);
 	return 1;
 }
diff -urN linux-2.4.0-prerelease/mm/vmscan.c linux-2.4.0-prerelease-tlb/mm/vmscan.c
--- linux-2.4.0-prerelease/mm/vmscan.c	Thu Jan  4 13:43:29 2001
+++ linux-2.4.0-prerelease-tlb/mm/vmscan.c	Thu Jan  4 13:59:28 2001
@@ -80,8 +80,7 @@
 	 * is needed on CPUs which update the accessed and dirty
 	 * bits in hardware.
 	 */
-	pte = ptep_get_and_clear(page_table);
-	flush_tlb_page(vma, address);
+	pte = ptep_invalidate(vma, address, page_table);
 
 	/*
 	 * Is the page already in the swap cache? If so, then


-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
