Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313996AbSEAUDF>; Wed, 1 May 2002 16:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314025AbSEAUDE>; Wed, 1 May 2002 16:03:04 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:10766 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313996AbSEAUDA>; Wed, 1 May 2002 16:03:00 -0400
Date: Wed, 1 May 2002 22:02:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.12: remove VALID_PAGE
Message-ID: <Pine.LNX.4.21.0205012136560.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes VALID_PAGE() and replaces it with pte_valid_page()/
virt_to_valid_page(). The VALID_PAGE() test is basically always too late
for configuration with discontinous memory. The real input value (the 
virtual or physical address) has to be checked. Nice side effect: the
kernel becomes 1KB smaller.
Other archs have to add a more efficient version of:
#define virt_to_valid_page(x) (VALID_PAGE(virt_to_page(x)) ? virt_to_page(x) : NULL)
#define pte_valid_page(x) (VALID_PAGE(pte_page(x)) ? pte_page(x) : NULL)
and remove the VALID_PAGE definition, all uses of it are converted by
this patch.

Please apply.

bye, Roman

Index: arch/arm/mach-arc/small_page.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/arm/mach-arc/small_page.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 small_page.c
--- arch/arm/mach-arc/small_page.c	15 Jan 2002 18:12:17 -0000	1.1.1.1
+++ arch/arm/mach-arc/small_page.c	29 Apr 2002 20:38:49 -0000
@@ -150,8 +150,8 @@ static void __free_small_page(unsigned l
 	unsigned long flags;
 	struct page *page;
 
-	page = virt_to_page(spage);
-	if (VALID_PAGE(page)) {
+	page = virt_to_valid_page(spage);
+	if (page) {
 
 		/*
 		 * The container-page must be marked Reserved
Index: arch/arm/mm/fault-armv.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/arm/mm/fault-armv.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 fault-armv.c
--- arch/arm/mm/fault-armv.c	14 Apr 2002 20:06:12 -0000	1.1.1.5
+++ arch/arm/mm/fault-armv.c	29 Apr 2002 19:18:37 -0000
@@ -240,9 +240,9 @@ make_coherent(struct vm_area_struct *vma
  */
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
-	struct page *page = pte_page(pte);
+	struct page *page = pte_valid_page(pte);
 
-	if (VALID_PAGE(page) && page->mapping) {
+	if (page && page->mapping) {
 		if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
 			__flush_dcache_page(page);
 
Index: arch/ia64/mm/init.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/ia64/mm/init.c,v
retrieving revision 1.1.1.4
diff -u -p -r1.1.1.4 init.c
--- arch/ia64/mm/init.c	1 May 2002 17:08:58 -0000	1.1.1.4
+++ arch/ia64/mm/init.c	1 May 2002 17:38:17 -0000
@@ -147,7 +147,7 @@ free_initrd_mem (unsigned long start, un
 		printk(KERN_INFO "Freeing initrd memory: %ldkB freed\n", (end - start) >> 10);
 
 	for (; start < end; start += PAGE_SIZE) {
-		if (!VALID_PAGE(virt_to_page(start)))
+		if (!virt_to_valid_page(start))
 			continue;
 		clear_bit(PG_reserved, &virt_to_page(start)->flags);
 		set_page_count(virt_to_page(start), 1);
Index: arch/mips/mm/umap.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/mips/mm/umap.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 umap.c
--- arch/mips/mm/umap.c	31 Jan 2002 22:19:02 -0000	1.1.1.2
+++ arch/mips/mm/umap.c	29 Apr 2002 19:17:45 -0000
@@ -116,8 +116,8 @@ void *vmalloc_uncached (unsigned long si
 static inline void free_pte(pte_t page)
 {
 	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		struct page *ptpage = pte_valid_page(page);
+		if (!ptpage || PageReserved(ptpage))
 			return;
 		__free_page(ptpage);
 		if (current->mm->rss <= 0)
Index: arch/mips64/mm/umap.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/mips64/mm/umap.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 umap.c
--- arch/mips64/mm/umap.c	31 Jan 2002 22:19:51 -0000	1.1.1.2
+++ arch/mips64/mm/umap.c	29 Apr 2002 19:17:29 -0000
@@ -115,8 +115,8 @@ void *vmalloc_uncached (unsigned long si
 static inline void free_pte(pte_t page)
 {
 	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		struct page *ptpage = pte_valid_page(page);
+		if (!ptpage || PageReserved(ptpage))
 			return;
 		__free_page(ptpage);
 		if (current->mm->rss <= 0)
Index: arch/sh/mm/fault.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/sh/mm/fault.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 fault.c
--- arch/sh/mm/fault.c	31 Jan 2002 22:19:42 -0000	1.1.1.2
+++ arch/sh/mm/fault.c	29 Apr 2002 19:17:11 -0000
@@ -298,8 +298,8 @@ void update_mmu_cache(struct vm_area_str
 		return;
 
 #if defined(__SH4__)
-	page = pte_page(pte);
-	if (VALID_PAGE(page) && !test_bit(PG_mapped, &page->flags)) {
+	page = pte_valid_page(pte);
+	if (page && !test_bit(PG_mapped, &page->flags)) {
 		unsigned long phys = pte_val(pte) & PTE_PHYS_MASK;
 		__flush_wback_region((void *)P1SEGADDR(phys), PAGE_SIZE);
 		__set_bit(PG_mapped, &page->flags);
Index: arch/sparc/mm/generic.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/sparc/mm/generic.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 generic.c
--- arch/sparc/mm/generic.c	31 Jan 2002 22:19:00 -0000	1.1.1.2
+++ arch/sparc/mm/generic.c	29 Apr 2002 19:16:58 -0000
@@ -19,8 +19,8 @@ static inline void forget_pte(pte_t page
 	if (pte_none(page))
 		return;
 	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		struct page *ptpage = pte_valid_page(page);
+		if (!ptpage || PageReserved(ptpage))
 			return;
 		page_cache_release(ptpage);
 		return;
Index: arch/sparc/mm/sun4c.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/sparc/mm/sun4c.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 sun4c.c
--- arch/sparc/mm/sun4c.c	14 Apr 2002 20:05:32 -0000	1.1.1.3
+++ arch/sparc/mm/sun4c.c	29 Apr 2002 20:39:35 -0000
@@ -1327,7 +1327,7 @@ static __u32 sun4c_get_scsi_one(char *bu
 	unsigned long page;
 
 	page = ((unsigned long)bufptr) & PAGE_MASK;
-	if (!VALID_PAGE(virt_to_page(page))) {
+	if (!virt_to_valid_page(page)) {
 		sun4c_flush_page(page);
 		return (__u32)bufptr; /* already locked */
 	}
@@ -2106,7 +2106,7 @@ static void sun4c_pte_clear(pte_t *ptep)
 static int sun4c_pmd_bad(pmd_t pmd)
 {
 	return (((pmd_val(pmd) & ~PAGE_MASK) != PGD_TABLE) ||
-		(!VALID_PAGE(virt_to_page(pmd_val(pmd)))));
+		(!virt_to_valid_page(pmd_val(pmd))));
 }
 
 static int sun4c_pmd_present(pmd_t pmd)
Index: arch/sparc64/kernel/traps.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/sparc64/kernel/traps.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 traps.c
--- arch/sparc64/kernel/traps.c	11 Feb 2002 18:49:01 -0000	1.1.1.3
+++ arch/sparc64/kernel/traps.c	29 Apr 2002 20:39:53 -0000
@@ -1284,9 +1284,9 @@ void cheetah_deferred_handler(struct pt_
 			}
 
 			if (recoverable) {
-				struct page *page = virt_to_page(__va(afar));
+				struct page *page = virt_to_valid_page(__va(afar));
 
-				if (VALID_PAGE(page))
+				if (page)
 					get_page(page);
 				else
 					recoverable = 0;
Index: arch/sparc64/mm/generic.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/sparc64/mm/generic.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 generic.c
--- arch/sparc64/mm/generic.c	19 Mar 2002 01:27:51 -0000	1.1.1.3
+++ arch/sparc64/mm/generic.c	29 Apr 2002 19:14:35 -0000
@@ -19,8 +19,8 @@ static inline void forget_pte(pte_t page
 	if (pte_none(page))
 		return;
 	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		struct page *ptpage = pte_valid_page(page);
+		if (!ptpage || PageReserved(ptpage))
 			return;
 		page_cache_release(ptpage);
 		return;
Index: arch/sparc64/mm/init.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/arch/sparc64/mm/init.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 init.c
--- arch/sparc64/mm/init.c	1 May 2002 17:08:40 -0000	1.1.1.7
+++ arch/sparc64/mm/init.c	1 May 2002 17:38:39 -0000
@@ -187,11 +187,10 @@ extern void __update_mmu_cache(unsigned 
 
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 {
-	struct page *page = pte_page(pte);
+	struct page *page = pte_valid_page(pte);
 	unsigned long pg_flags;
 
-	if (VALID_PAGE(page) &&
-	    page->mapping &&
+	if (page && page->mapping &&
 	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
 		int cpu = ((pg_flags >> 24) & (NR_CPUS - 1UL));
 
@@ -260,10 +259,10 @@ static inline void flush_cache_pte_range
 			continue;
 
 		if (pte_present(pte) && pte_dirty(pte)) {
-			struct page *page = pte_page(pte);
+			struct page *page = pte_valid_page(pte);
 			unsigned long pgaddr, uaddr;
 
-			if (!VALID_PAGE(page) || PageReserved(page) || !page->mapping)
+			if (!page || PageReserved(page) || !page->mapping)
 				continue;
 			pgaddr = (unsigned long) page_address(page);
 			uaddr = address + offset;
Index: fs/proc/array.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/proc/array.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 array.c
--- fs/proc/array.c	14 Apr 2002 20:01:10 -0000	1.1.1.7
+++ fs/proc/array.c	29 Apr 2002 19:12:38 -0000
@@ -424,8 +424,8 @@ static inline void statm_pte_range(pmd_t
 		++*total;
 		if (!pte_present(page))
 			continue;
-		ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		ptpage = pte_valid_page(page);
+		if (!ptpage || PageReserved(ptpage))
 			continue;
 		++*pages;
 		if (pte_dirty(page))
Index: include/asm-cris/processor.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/asm-cris/processor.h,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 processor.h
--- include/asm-cris/processor.h	31 Jan 2002 22:16:02 -0000	1.1.1.2
+++ include/asm-cris/processor.h	29 Apr 2002 20:40:17 -0000
@@ -101,8 +101,7 @@ unsigned long get_wchan(struct task_stru
     ({                  \
         unsigned long eip = 0;   \
         unsigned long regs = (unsigned long)user_regs(tsk); \
-        if (regs > PAGE_SIZE && \
-            VALID_PAGE(virt_to_page(regs))) \
+        if (regs > PAGE_SIZE && virt_to_valid_page(regs)) \
               eip = ((struct pt_regs *)regs)->irp; \
         eip; })
 
Index: include/asm-i386/page.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/asm-i386/page.h,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 page.h
--- include/asm-i386/page.h	24 Feb 2002 23:11:41 -0000	1.1.1.3
+++ include/asm-i386/page.h	30 Apr 2002 17:47:37 -0000
@@ -132,7 +132,10 @@ static __inline__ int get_order(unsigned
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+#define virt_to_valid_page(kaddr) ({ \
+	unsigned long __pnr = __pa(kaddr) >> PAGE_SHIFT; \
+	__pnr < max_mapnr ? mem_map + __pnr : NULL; \
+})
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
Index: include/asm-i386/pgtable-2level.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/asm-i386/pgtable-2level.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 pgtable-2level.h
--- include/asm-i386/pgtable-2level.h	26 Nov 2001 19:29:55 -0000	1.1.1.1
+++ include/asm-i386/pgtable-2level.h	30 Apr 2002 12:20:02 -0000
@@ -57,6 +57,7 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		(mem_map+((unsigned long)(((x).pte_low >> PAGE_SHIFT))))
+#define pte_valid_page(x)	((pte_val(x) >> PAGE_SHIFT) < max_mapnr ? pte_page(x) : NULL)
 #define pte_none(x)		(!(x).pte_low)
 #define __mk_pte(page_nr,pgprot) __pte(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
 
Index: include/asm-i386/pgtable-3level.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/asm-i386/pgtable-3level.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 pgtable-3level.h
--- include/asm-i386/pgtable-3level.h	26 Nov 2001 19:29:55 -0000	1.1.1.1
+++ include/asm-i386/pgtable-3level.h	30 Apr 2002 12:20:00 -0000
@@ -87,6 +87,7 @@ static inline int pte_same(pte_t a, pte_
 }
 
 #define pte_page(x)	(mem_map+(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT))))
+#define pte_valid_page(x) ((pte_val(x) >> PAGE_SHIFT) < max_mapnr ? pte_page(x) : NULL)
 #define pte_none(x)	(!(x).pte_low && !(x).pte_high)
 
 static inline pte_t __mk_pte(unsigned long page_nr, pgprot_t pgprot)
Index: include/asm-m68k/processor.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/asm-m68k/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 processor.h
--- include/asm-m68k/processor.h	26 Nov 2001 19:29:57 -0000	1.1.1.1
+++ include/asm-m68k/processor.h	29 Apr 2002 20:40:37 -0000
@@ -139,7 +139,7 @@ unsigned long get_wchan(struct task_stru
     ({			\
 	unsigned long eip = 0;	 \
 	if ((tsk)->thread.esp0 > PAGE_SIZE && \
-	    (VALID_PAGE(virt_to_page((tsk)->thread.esp0)))) \
+	    (virt_to_valid_page((tsk)->thread.esp0))) \
 	      eip = ((struct pt_regs *) (tsk)->thread.esp0)->pc; \
 	eip; })
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
Index: include/asm-sh/pgalloc.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/asm-sh/pgalloc.h,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 pgalloc.h
--- include/asm-sh/pgalloc.h	31 Jan 2002 22:15:51 -0000	1.1.1.2
+++ include/asm-sh/pgalloc.h	29 Apr 2002 19:11:43 -0000
@@ -105,9 +105,8 @@ static inline pte_t ptep_get_and_clear(p
 
 	pte_clear(ptep);
 	if (!pte_not_present(pte)) {
-		struct page *page = pte_page(pte);
-		if (VALID_PAGE(page)&&
-		    (!page->mapping || !(page->mapping->i_mmap_shared)))
+		struct page *page = pte_valid_page(pte);
+		if (page && (!page->mapping || !(page->mapping->i_mmap_shared)))
 			__clear_bit(PG_mapped, &page->flags);
 	}
 	return pte;
Index: mm/memory.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/mm/memory.c,v
retrieving revision 1.1.1.10
diff -u -p -r1.1.1.10 memory.c
--- mm/memory.c	1 May 2002 17:03:30 -0000	1.1.1.10
+++ mm/memory.c	1 May 2002 17:40:16 -0000
@@ -76,8 +76,8 @@ mem_map_t * mem_map;
  */
 void __free_pte(pte_t pte)
 {
-	struct page *page = pte_page(pte);
-	if ((!VALID_PAGE(page)) || PageReserved(page))
+	struct page *page = pte_valid_page(pte);
+	if (!page || PageReserved(page))
 		return;
 	if (pte_dirty(pte))
 		set_page_dirty(page);		
@@ -278,9 +278,8 @@ skip_copy_pte_range:		address = (address
 					swap_duplicate(pte_to_swp_entry(pte));
 					goto cont_copy_pte_range;
 				}
-				ptepage = pte_page(pte);
-				if ((!VALID_PAGE(ptepage)) || 
-				    PageReserved(ptepage))
+				ptepage = pte_valid_page(pte);
+				if (!ptepage || PageReserved(ptepage))
 					goto cont_copy_pte_range;
 
 				/* If it's a COW mapping, write protect it both in the parent and the child */
@@ -356,8 +355,8 @@ static inline int zap_pte_range(mmu_gath
 		if (pte_none(pte))
 			continue;
 		if (pte_present(pte)) {
-			struct page *page = pte_page(pte);
-			if (VALID_PAGE(page) && !PageReserved(page))
+			struct page *page = pte_valid_page(pte);
+			if (page && !PageReserved(page))
 				freed ++;
 			/* This will eventually call __free_pte on the pte. */
 			tlb_remove_page(tlb, ptep, address + offset);
@@ -473,7 +472,7 @@ static struct page * follow_page(struct 
 	if (pte_present(pte)) {
 		if (!write ||
 		    (pte_write(pte) && pte_dirty(pte)))
-			return pte_page(pte);
+			return pte_valid_page(pte);
 	}
 
 out:
@@ -488,8 +487,6 @@ out:
 
 static inline struct page * get_page_map(struct page *page)
 {
-	if (!VALID_PAGE(page))
-		return 0;
 	return page;
 }
 
@@ -860,12 +857,12 @@ static inline void remap_pte_range(pte_t
 		end = PMD_SIZE;
 	do {
 		struct page *page;
-		pte_t oldpage;
+		pte_t oldpage, newpage;
 		oldpage = ptep_get_and_clear(pte);
-
-		page = virt_to_page(__va(phys_addr));
-		if ((!VALID_PAGE(page)) || PageReserved(page))
- 			set_pte(pte, mk_pte_phys(phys_addr, prot));
+		newpage = mk_pte_phys(phys_addr, prot);
+		page = pte_valid_page(newpage);
+		if (!page || PageReserved(page))
+ 			set_pte(pte, newpage);
 		forget_pte(oldpage);
 		address += PAGE_SIZE;
 		phys_addr += PAGE_SIZE;
@@ -978,8 +975,8 @@ static int do_wp_page(struct mm_struct *
 {
 	struct page *old_page, *new_page;
 
-	old_page = pte_page(pte);
-	if (!VALID_PAGE(old_page))
+	old_page = pte_valid_page(pte);
+	if (!old_page)
 		goto bad_wp_page;
 
 	if (!TestSetPageLocked(old_page)) {
Index: mm/msync.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/mm/msync.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 msync.c
--- mm/msync.c	1 May 2002 17:03:32 -0000	1.1.1.3
+++ mm/msync.c	1 May 2002 17:40:16 -0000
@@ -26,8 +26,8 @@ static int filemap_sync_pte(pte_t *ptep,
 	pte_t pte = *ptep;
 
 	if (pte_present(pte) && pte_dirty(pte)) {
-		struct page *page = pte_page(pte);
-		if (VALID_PAGE(page) && !PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
+		struct page *page = pte_valid_page(pte);
+		if (page && !PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
 			flush_tlb_page(vma, address);
 			set_page_dirty(page);
 		}
Index: mm/page_alloc.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/mm/page_alloc.c,v
retrieving revision 1.1.1.9
diff -u -p -r1.1.1.9 page_alloc.c
--- mm/page_alloc.c	1 May 2002 17:03:31 -0000	1.1.1.9
+++ mm/page_alloc.c	1 May 2002 17:44:49 -0000
@@ -101,8 +101,6 @@ static void __free_pages_ok (struct page
 		BUG();
 	if (page->mapping)
 		BUG();
-	if (!VALID_PAGE(page))
-		BUG();
 	if (PageLocked(page))
 		BUG();
 	if (PageLRU(page))
@@ -295,8 +293,6 @@ static struct page * balance_classzone(z
 						BUG();
 					if (page->mapping)
 						BUG();
-					if (!VALID_PAGE(page))
-						BUG();
 					if (PageLocked(page))
 						BUG();
 					if (PageLRU(page))
@@ -478,7 +474,7 @@ void __free_pages(struct page *page, uns
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0)
-		__free_pages(virt_to_page(addr), order);
+		__free_pages(virt_to_valid_page(addr), order);
 }
 
 /*
Index: mm/slab.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/mm/slab.c,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 slab.c
--- mm/slab.c	1 May 2002 17:03:32 -0000	1.1.1.6
+++ mm/slab.c	1 May 2002 17:40:16 -0000
@@ -1415,7 +1415,7 @@ alloc_new_slab_nolock:
 #if DEBUG
 # define CHECK_NR(pg)						\
 	do {							\
-		if (!VALID_PAGE(pg)) {				\
+		if (!pg) {					\
 			printk(KERN_ERR "kfree: out of range ptr %lxh.\n", \
 				(unsigned long)objp);		\
 			BUG();					\
@@ -1439,7 +1439,7 @@ static inline void kmem_cache_free_one(k
 {
 	slab_t* slabp;
 
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(virt_to_valid_page(objp));
 	/* reduces memory footprint
 	 *
 	if (OPTIMIZE(cachep))
@@ -1519,7 +1519,7 @@ static inline void __kmem_cache_free (km
 #ifdef CONFIG_SMP
 	cpucache_t *cc = cc_data(cachep);
 
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(virt_to_valid_page(objp));
 	if (cc) {
 		int batchcount;
 		if (cc->avail < cc->limit) {
@@ -1601,7 +1601,7 @@ void kmem_cache_free (kmem_cache_t *cach
 {
 	unsigned long flags;
 #if DEBUG
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(virt_to_valid_page(objp));
 	if (cachep != GET_PAGE_CACHE(virt_to_page(objp)))
 		BUG();
 #endif
@@ -1626,7 +1626,7 @@ void kfree (const void *objp)
 	if (!objp)
 		return;
 	local_irq_save(flags);
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(virt_to_valid_page(objp));
 	c = GET_PAGE_CACHE(virt_to_page(objp));
 	__kmem_cache_free(c, (void*)objp);
 	local_irq_restore(flags);
Index: mm/vmalloc.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/mm/vmalloc.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 vmalloc.c
--- mm/vmalloc.c	24 Apr 2002 19:31:04 -0000	1.1.1.5
+++ mm/vmalloc.c	29 Apr 2002 18:59:39 -0000
@@ -45,8 +45,8 @@ static inline void free_area_pte(pmd_t *
 		if (pte_none(page))
 			continue;
 		if (pte_present(page)) {
-			struct page *ptpage = pte_page(page);
-			if (VALID_PAGE(ptpage) && (!PageReserved(ptpage)))
+			struct page *ptpage = pte_valid_page(page);
+			if (ptpage && (!PageReserved(ptpage)))
 				__free_page(ptpage);
 			continue;
 		}
Index: mm/vmscan.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/mm/vmscan.c,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 vmscan.c
--- mm/vmscan.c	1 May 2002 17:03:31 -0000	1.1.1.8
+++ mm/vmscan.c	1 May 2002 17:40:16 -0000
@@ -216,9 +216,9 @@ static inline int swap_out_pmd(struct mm
 
 	do {
 		if (pte_present(*pte)) {
-			struct page *page = pte_page(*pte);
+			struct page *page = pte_valid_page(*pte);
 
-			if (VALID_PAGE(page) && !PageReserved(page)) {
+			if (page && !PageReserved(page)) {
 				count -= try_to_swap_out(mm, vma, address, pte, page, classzone);
 				if (!count) {
 					address += PAGE_SIZE;

