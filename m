Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSEBUhd>; Thu, 2 May 2002 16:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315412AbSEBUhc>; Thu, 2 May 2002 16:37:32 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:7941 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315411AbSEBUhU>; Thu, 2 May 2002 16:37:20 -0400
Date: Thu, 2 May 2002 22:37:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.12: remove VALID_PAGE
In-Reply-To: <Pine.LNX.4.44.0205012153310.2272-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205022231180.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 1 May 2002, Linus Torvalds wrote:

> .. but the _design_ is bad (limited usability anywhere else). And my
> suggested interface is actually likely to generate better code, ie instead
> of having two tests (one inside "pte_valid_page()", and one on the return
> value), you'd only have one (in "valid_pfn()").

Ok, here is a new patch and it does indeed generate better code. :)
virt_to_valid_page() also became virt_addr_valid().

bye, Roman

Index: arch/arm/mach-arc/small_page.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/arm/mach-arc/small_page.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 small_page.c
--- arch/arm/mach-arc/small_page.c	2002/02/04 16:13:00	1.1.1.1
+++ arch/arm/mach-arc/small_page.c	2002/05/02 14:03:39
@@ -150,8 +150,8 @@
 	unsigned long flags;
 	struct page *page;
 
-	page = virt_to_page(spage);
-	if (VALID_PAGE(page)) {
+	if (virt_addr_valid(spage)) {
+		page = virt_to_page(spage);
 
 		/*
 		 * The container-page must be marked Reserved
Index: arch/arm/mm/fault-armv.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/arm/mm/fault-armv.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 fault-armv.c
--- arch/arm/mm/fault-armv.c	2002/04/16 08:42:51	1.1.1.5
+++ arch/arm/mm/fault-armv.c	2002/05/02 14:03:39
@@ -240,9 +240,13 @@
  */
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
-	struct page *page = pte_page(pte);
+	unsigned long pfn = pte_pfn(pte);
+	struct page *page;
 
-	if (VALID_PAGE(page) && page->mapping) {
+	if (!pfn_valid(pfn))
+		return;
+	page = pfn_to_page(pfn);
+	if (page->mapping) {
 		if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
 			__flush_dcache_page(page);
 
Index: arch/ia64/mm/init.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/ia64/mm/init.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 init.c
--- arch/ia64/mm/init.c	2002/05/01 08:54:00	1.1.1.4
+++ arch/ia64/mm/init.c	2002/05/02 14:03:39
@@ -109,6 +109,7 @@
 void
 free_initrd_mem (unsigned long start, unsigned long end)
 {
+	struct page *page;
 	/*
 	 * EFI uses 4KB pages while the kernel can use 4KB  or bigger.
 	 * Thus EFI and the kernel may have different page sizes. It is
@@ -147,11 +148,12 @@
 		printk(KERN_INFO "Freeing initrd memory: %ldkB freed\n", (end - start) >> 10);
 
 	for (; start < end; start += PAGE_SIZE) {
-		if (!VALID_PAGE(virt_to_page(start)))
+		if (!virt_addr_valid(start))
 			continue;
-		clear_bit(PG_reserved, &virt_to_page(start)->flags);
-		set_page_count(virt_to_page(start), 1);
-		free_page(start);
+		page = virt_to_page(start);
+		clear_bit(PG_reserved, &page->flags);
+		set_page_count(page, 1);
+		__free_page(page);
 		++totalram_pages;
 	}
 }
Index: arch/mips/mm/umap.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/mips/mm/umap.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 umap.c
--- arch/mips/mm/umap.c	2002/02/04 16:39:40	1.1.1.2
+++ arch/mips/mm/umap.c	2002/05/02 14:03:39
@@ -116,8 +116,12 @@
 static inline void free_pte(pte_t page)
 {
 	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		unsigned long pfn = pte_pfn(page);
+		struct page *ptpage;
+		if (!pfn_valid(pfn))
+			return;
+		ptpage = pfn_to_page(pfn);
+		if (PageReserved(ptpage))
 			return;
 		__free_page(ptpage);
 		if (current->mm->rss <= 0)
Index: arch/mips64/mm/umap.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/mips64/mm/umap.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 umap.c
--- arch/mips64/mm/umap.c	2002/02/04 16:39:42	1.1.1.2
+++ arch/mips64/mm/umap.c	2002/05/02 14:03:39
@@ -115,8 +115,12 @@
 static inline void free_pte(pte_t page)
 {
 	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		unsigned long pfn = pte_pfn(page);
+		struct page *ptpage;
+		if (!pfn_valid(pfn))
+			return;
+		ptpage = pfn_to_page(pfn);
+		if (PageReserved(ptpage))
 			return;
 		__free_page(ptpage);
 		if (current->mm->rss <= 0)
Index: arch/sh/mm/fault.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/sh/mm/fault.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 fault.c
--- arch/sh/mm/fault.c	2002/02/04 16:39:48	1.1.1.2
+++ arch/sh/mm/fault.c	2002/05/02 14:03:39
@@ -290,6 +290,7 @@
 	unsigned long vpn;
 #if defined(__SH4__)
 	struct page *page;
+	unsigned long pfn;
 	unsigned long ptea;
 #endif
 
@@ -298,11 +299,14 @@
 		return;
 
 #if defined(__SH4__)
-	page = pte_page(pte);
-	if (VALID_PAGE(page) && !test_bit(PG_mapped, &page->flags)) {
-		unsigned long phys = pte_val(pte) & PTE_PHYS_MASK;
-		__flush_wback_region((void *)P1SEGADDR(phys), PAGE_SIZE);
-		__set_bit(PG_mapped, &page->flags);
+	pfn = pte_pfn(pte);
+	if (pfn_valid(pfn)) {
+		page = pfn_to_page(pfn);
+		if (!test_bit(PG_mapped, &page->flags)) {
+			unsigned long phys = pte_val(pte) & PTE_PHYS_MASK;
+			__flush_wback_region((void *)P1SEGADDR(phys), PAGE_SIZE);
+			__set_bit(PG_mapped, &page->flags);
+		}
 	}
 #endif
 
Index: arch/sparc/mm/generic.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/sparc/mm/generic.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 generic.c
--- arch/sparc/mm/generic.c	2002/02/04 16:39:50	1.1.1.2
+++ arch/sparc/mm/generic.c	2002/05/02 14:03:39
@@ -19,8 +19,12 @@
 	if (pte_none(page))
 		return;
 	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		unsigned long pfn = pte_pfn(page);
+		struct page *ptpage;
+		if (!pfn_valid(pfn))
+			return;
+		ptpage = pfn_to_page(pfn);
+		if (PageReserved(ptpage))
 			return;
 		page_cache_release(ptpage);
 		return;
Index: arch/sparc/mm/sun4c.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/sparc/mm/sun4c.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 sun4c.c
--- arch/sparc/mm/sun4c.c	2002/04/16 08:43:36	1.1.1.3
+++ arch/sparc/mm/sun4c.c	2002/05/02 14:03:39
@@ -1327,7 +1327,7 @@
 	unsigned long page;
 
 	page = ((unsigned long)bufptr) & PAGE_MASK;
-	if (!VALID_PAGE(virt_to_page(page))) {
+	if (!virt_addr_valid(page)) {
 		sun4c_flush_page(page);
 		return (__u32)bufptr; /* already locked */
 	}
@@ -2106,7 +2106,7 @@
 static int sun4c_pmd_bad(pmd_t pmd)
 {
 	return (((pmd_val(pmd) & ~PAGE_MASK) != PGD_TABLE) ||
-		(!VALID_PAGE(virt_to_page(pmd_val(pmd)))));
+		(!virt_addr_valid(pmd_val(pmd))));
 }
 
 static int sun4c_pmd_present(pmd_t pmd)
Index: arch/sparc64/kernel/traps.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/sparc64/kernel/traps.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 traps.c
--- arch/sparc64/kernel/traps.c	2002/02/11 14:43:56	1.1.1.3
+++ arch/sparc64/kernel/traps.c	2002/05/02 14:03:39
@@ -1284,10 +1284,8 @@
 			}
 
 			if (recoverable) {
-				struct page *page = virt_to_page(__va(afar));
-
-				if (VALID_PAGE(page))
-					get_page(page);
+				if (pfn_valid(afar >> PAGE_SHIFT))
+					get_page(pfn_to_page(afar >> PAGE_SHIFT));
 				else
 					recoverable = 0;
 
Index: arch/sparc64/mm/generic.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/sparc64/mm/generic.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 generic.c
--- arch/sparc64/mm/generic.c	2002/03/28 15:01:51	1.1.1.3
+++ arch/sparc64/mm/generic.c	2002/05/02 14:03:39
@@ -19,8 +19,12 @@
 	if (pte_none(page))
 		return;
 	if (pte_present(page)) {
-		struct page *ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		unsigned long pfn = pte_pfn(page);
+		struct page *ptpage;
+		if (!pfn_valid(pfn))
+			return;
+		ptpage = pfn_to_page(page);
+		if (PageReserved(ptpage))
 			return;
 		page_cache_release(ptpage);
 		return;
Index: arch/sparc64/mm/init.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/arch/sparc64/mm/init.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 init.c
--- arch/sparc64/mm/init.c	2002/05/01 08:54:34	1.1.1.7
+++ arch/sparc64/mm/init.c	2002/05/02 14:03:39
@@ -187,11 +187,13 @@
 
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 {
-	struct page *page = pte_page(pte);
+	struct page *page;
+	unsigned long pfn;
 	unsigned long pg_flags;
 
-	if (VALID_PAGE(page) &&
-	    page->mapping &&
+	pfn = pte_pfn(pte);
+	if (pfn_valid(pfn) &&
+	    (page = pfn_to_page(pfn), page->mapping) &&
 	    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
 		int cpu = ((pg_flags >> 24) & (NR_CPUS - 1UL));
 
@@ -260,10 +262,14 @@
 			continue;
 
 		if (pte_present(pte) && pte_dirty(pte)) {
-			struct page *page = pte_page(pte);
+			struct page *page;
 			unsigned long pgaddr, uaddr;
+			unsigned long pfn = pte_pfn(pte);
 
-			if (!VALID_PAGE(page) || PageReserved(page) || !page->mapping)
+			if (!pfn_valid(pfn))
+				continue;
+			page = pfn_to_page(pfn);
+			if (PageReserved(page) || !page->mapping)
 				continue;
 			pgaddr = (unsigned long) page_address(page);
 			uaddr = address + offset;
Index: fs/proc/array.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/fs/proc/array.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 array.c
--- fs/proc/array.c	2002/04/16 08:45:32	1.1.1.7
+++ fs/proc/array.c	2002/05/02 14:03:39
@@ -416,6 +416,7 @@
 	do {
 		pte_t page = *pte;
 		struct page *ptpage;
+		unsigned long pfn;
 
 		address += PAGE_SIZE;
 		pte++;
@@ -424,8 +425,11 @@
 		++*total;
 		if (!pte_present(page))
 			continue;
-		ptpage = pte_page(page);
-		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
+		pfn = pte_pfn(page);
+		if (!pfn_valid(pfn))
+			continue;
+		ptpage = pfn_to_page(pfn);
+		if (PageReserved(ptpage))
 			continue;
 		++*pages;
 		if (pte_dirty(page))
Index: include/asm-cris/processor.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/asm-cris/processor.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 processor.h
--- include/asm-cris/processor.h	2002/02/04 16:41:16	1.1.1.2
+++ include/asm-cris/processor.h	2002/05/02 14:03:39
@@ -102,7 +102,7 @@
         unsigned long eip = 0;   \
         unsigned long regs = (unsigned long)user_regs(tsk); \
         if (regs > PAGE_SIZE && \
-            VALID_PAGE(virt_to_page(regs))) \
+            virt_addr_valid(regs)) \
               eip = ((struct pt_regs *)regs)->irp; \
         eip; })
 
Index: include/asm-i386/page.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/asm-i386/page.h,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 page.h
--- include/asm-i386/page.h	2002/02/25 13:57:28	1.1.1.3
+++ include/asm-i386/page.h	2002/05/02 14:15:52
@@ -41,11 +41,13 @@
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
+#define pte_pfn(x)	(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT)))
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low)
+#define pte_pfn(x)	((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
 #endif
 #define PTE_MASK	PAGE_MASK
 
@@ -131,8 +133,11 @@
 #define MAXMEM			((unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE))
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+#define pfn_to_page(pfn)	(mem_map + (pfn))
+#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
Index: include/asm-i386/pgtable-2level.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/asm-i386/pgtable-2level.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pgtable-2level.h
--- include/asm-i386/pgtable-2level.h	2002/02/04 15:41:30	1.1.1.1
+++ include/asm-i386/pgtable-2level.h	2002/05/02 14:03:39
@@ -56,7 +56,7 @@
 }
 #define ptep_get_and_clear(xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
-#define pte_page(x)		(mem_map+((unsigned long)(((x).pte_low >> PAGE_SHIFT))))
+#define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
 #define __mk_pte(page_nr,pgprot) __pte(((page_nr) << PAGE_SHIFT) | pgprot_val(pgprot))
 
Index: include/asm-i386/pgtable-3level.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/asm-i386/pgtable-3level.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pgtable-3level.h
--- include/asm-i386/pgtable-3level.h	2002/02/04 15:41:30	1.1.1.1
+++ include/asm-i386/pgtable-3level.h	2002/05/02 14:03:39
@@ -86,7 +86,7 @@
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
 }
 
-#define pte_page(x)	(mem_map+(((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT))))
+#define pte_page(x)	pfn_to_page(pte_pfn(x))
 #define pte_none(x)	(!(x).pte_low && !(x).pte_high)
 
 static inline pte_t __mk_pte(unsigned long page_nr, pgprot_t pgprot)
Index: include/asm-m68k/processor.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/asm-m68k/processor.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 processor.h
--- include/asm-m68k/processor.h	2002/02/04 15:41:31	1.1.1.1
+++ include/asm-m68k/processor.h	2002/05/02 14:03:39
@@ -139,7 +139,7 @@
     ({			\
 	unsigned long eip = 0;	 \
 	if ((tsk)->thread.esp0 > PAGE_SIZE && \
-	    (VALID_PAGE(virt_to_page((tsk)->thread.esp0)))) \
+	    (virt_addr_valid((tsk)->thread.esp0))) \
 	      eip = ((struct pt_regs *) (tsk)->thread.esp0)->pc; \
 	eip; })
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
Index: include/asm-sh/pgalloc.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/asm-sh/pgalloc.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 pgalloc.h
--- include/asm-sh/pgalloc.h	2002/02/04 16:41:25	1.1.1.2
+++ include/asm-sh/pgalloc.h	2002/05/02 14:03:39
@@ -105,10 +105,13 @@
 
 	pte_clear(ptep);
 	if (!pte_not_present(pte)) {
-		struct page *page = pte_page(pte);
-		if (VALID_PAGE(page)&&
-		    (!page->mapping || !(page->mapping->i_mmap_shared)))
-			__clear_bit(PG_mapped, &page->flags);
+		struct page *page;
+		unsigned long pfn = pte_pfn(pte);
+		if (pfn_valid(pfn)) {
+			page = pfn_to_page(page);
+			if (!page->mapping || !page->mapping->i_mmap_shared)
+				__clear_bit(PG_mapped, &page->flags);
+		}
 	}
 	return pte;
 }
Index: mm/memory.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/mm/memory.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 memory.c
--- mm/memory.c	2002/05/01 08:57:37	1.1.1.10
+++ mm/memory.c	2002/05/02 14:03:39
@@ -76,8 +76,12 @@
  */
 void __free_pte(pte_t pte)
 {
-	struct page *page = pte_page(pte);
-	if ((!VALID_PAGE(page)) || PageReserved(page))
+	struct page *page;
+	unsigned long pfn = pte_pfn(pte);
+	if (!pfn_valid(pfn))
+		return;
+	page = pfn_to_page(pfn);
+	if (PageReserved(page))
 		return;
 	if (pte_dirty(pte))
 		set_page_dirty(page);		
@@ -269,6 +273,7 @@
 			do {
 				pte_t pte = *src_pte;
 				struct page *ptepage;
+				unsigned long pfn;
 				
 				/* copy_one_pte */
 
@@ -278,10 +283,12 @@
 					swap_duplicate(pte_to_swp_entry(pte));
 					goto cont_copy_pte_range;
 				}
-				ptepage = pte_page(pte);
-				if ((!VALID_PAGE(ptepage)) || 
-				    PageReserved(ptepage))
+				pfn = pte_pfn(pte);
+				if (!pfn_valid(pfn))
 					goto cont_copy_pte_range;
+				ptepage = pfn_to_page(pfn);
+				if (PageReserved(ptepage))
+					goto cont_copy_pte_range;
 
 				/* If it's a COW mapping, write protect it both in the parent and the child */
 				if (cow && pte_write(pte)) {
@@ -356,9 +363,13 @@
 		if (pte_none(pte))
 			continue;
 		if (pte_present(pte)) {
-			struct page *page = pte_page(pte);
-			if (VALID_PAGE(page) && !PageReserved(page))
-				freed ++;
+			struct page *page;
+			unsigned long pfn = pte_pfn(pte);
+			if (pfn_valid(pfn)) {
+				page = pfn_to_page(pfn);
+				if (!PageReserved(page))
+					freed++;
+			}
 			/* This will eventually call __free_pte on the pte. */
 			tlb_remove_page(tlb, ptep, address + offset);
 		} else {
@@ -451,6 +462,7 @@
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
+	unsigned long pfn;
 
 	pgd = pgd_offset(mm, address);
 	if (pgd_none(*pgd) || pgd_bad(*pgd))
@@ -472,8 +484,11 @@
 	preempt_enable();
 	if (pte_present(pte)) {
 		if (!write ||
-		    (pte_write(pte) && pte_dirty(pte)))
-			return pte_page(pte);
+		    (pte_write(pte) && pte_dirty(pte))) {
+			pfn = pte_pfn(pte);
+			if (pfn_valid(pfn))
+				return pfn_to_page(pfn);
+		}
 	}
 
 out:
@@ -488,8 +503,6 @@
 
 static inline struct page * get_page_map(struct page *page)
 {
-	if (!VALID_PAGE(page))
-		return 0;
 	return page;
 }
 
@@ -860,11 +873,10 @@
 		end = PMD_SIZE;
 	do {
 		struct page *page;
-		pte_t oldpage;
-		oldpage = ptep_get_and_clear(pte);
+		pte_t oldpage = ptep_get_and_clear(pte);
+		unsigned long pfn = phys_addr >> PAGE_SHIFT;
 
-		page = virt_to_page(__va(phys_addr));
-		if ((!VALID_PAGE(page)) || PageReserved(page))
+		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
  			set_pte(pte, mk_pte_phys(phys_addr, prot));
 		forget_pte(oldpage);
 		address += PAGE_SIZE;
@@ -977,10 +989,11 @@
 	unsigned long address, pte_t *page_table, pmd_t *pmd, pte_t pte)
 {
 	struct page *old_page, *new_page;
+	unsigned long pfn = pte_pfn(pte);
 
-	old_page = pte_page(pte);
-	if (!VALID_PAGE(old_page))
+	if (!pfn_valid(pfn))
 		goto bad_wp_page;
+	old_page = pfn_to_page(pfn);
 
 	if (!TestSetPageLocked(old_page)) {
 		int reuse = can_share_swap_page(old_page);
Index: mm/msync.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/mm/msync.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 msync.c
--- mm/msync.c	2002/05/01 08:57:37	1.1.1.3
+++ mm/msync.c	2002/05/02 14:03:39
@@ -26,10 +26,14 @@
 	pte_t pte = *ptep;
 
 	if (pte_present(pte) && pte_dirty(pte)) {
-		struct page *page = pte_page(pte);
-		if (VALID_PAGE(page) && !PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
-			flush_tlb_page(vma, address);
-			set_page_dirty(page);
+		struct page *page;
+		unsigned long pfn = pte_pfn(pte);
+		if (pfn_valid(pfn)) {
+			page = pfn_to_page(pfn);
+			if (!PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
+				flush_tlb_page(vma, address);
+				set_page_dirty(page);
+			}
 		}
 	}
 	return 0;
Index: mm/page_alloc.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/mm/page_alloc.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 page_alloc.c
--- mm/page_alloc.c	2002/05/01 08:57:37	1.1.1.9
+++ mm/page_alloc.c	2002/05/02 15:03:17
@@ -101,8 +101,6 @@
 		BUG();
 	if (page->mapping)
 		BUG();
-	if (!VALID_PAGE(page))
-		BUG();
 	if (PageLocked(page))
 		BUG();
 	if (PageLRU(page))
@@ -295,8 +293,6 @@
 						BUG();
 					if (page->mapping)
 						BUG();
-					if (!VALID_PAGE(page))
-						BUG();
 					if (PageLocked(page))
 						BUG();
 					if (PageLRU(page))
@@ -477,8 +473,10 @@
 
 void free_pages(unsigned long addr, unsigned int order)
 {
-	if (addr != 0)
+	if (addr != 0) {
+		BUG_ON(!virt_addr_valid(addr));
 		__free_pages(virt_to_page(addr), order);
+	}
 }
 
 /*
Index: mm/slab.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/mm/slab.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 slab.c
--- mm/slab.c	2002/05/01 08:57:37	1.1.1.6
+++ mm/slab.c	2002/05/02 14:03:39
@@ -1415,15 +1415,16 @@
 #if DEBUG
 # define CHECK_NR(pg)						\
 	do {							\
-		if (!VALID_PAGE(pg)) {				\
+		if (!virt_addr_valid(pg)) {			\
 			printk(KERN_ERR "kfree: out of range ptr %lxh.\n", \
 				(unsigned long)objp);		\
 			BUG();					\
 		} \
 	} while (0)
-# define CHECK_PAGE(page)					\
+# define CHECK_PAGE(addr)					\
 	do {							\
-		CHECK_NR(page);					\
+		struct page *page = virt_to_page(addr);		\
+		CHECK_NR(addr);					\
 		if (!PageSlab(page)) {				\
 			printk(KERN_ERR "kfree: bad ptr %lxh.\n", \
 				(unsigned long)objp);		\
@@ -1439,7 +1440,7 @@
 {
 	slab_t* slabp;
 
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(objp);
 	/* reduces memory footprint
 	 *
 	if (OPTIMIZE(cachep))
@@ -1519,7 +1520,7 @@
 #ifdef CONFIG_SMP
 	cpucache_t *cc = cc_data(cachep);
 
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(objp);
 	if (cc) {
 		int batchcount;
 		if (cc->avail < cc->limit) {
@@ -1601,7 +1602,7 @@
 {
 	unsigned long flags;
 #if DEBUG
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(objp);
 	if (cachep != GET_PAGE_CACHE(virt_to_page(objp)))
 		BUG();
 #endif
@@ -1626,7 +1627,7 @@
 	if (!objp)
 		return;
 	local_irq_save(flags);
-	CHECK_PAGE(virt_to_page(objp));
+	CHECK_PAGE(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
 	__kmem_cache_free(c, (void*)objp);
 	local_irq_restore(flags);
Index: mm/vmalloc.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/mm/vmalloc.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 vmalloc.c
--- mm/vmalloc.c	2002/04/24 12:36:58	1.1.1.5
+++ mm/vmalloc.c	2002/05/02 14:03:39
@@ -45,8 +45,12 @@
 		if (pte_none(page))
 			continue;
 		if (pte_present(page)) {
-			struct page *ptpage = pte_page(page);
-			if (VALID_PAGE(ptpage) && (!PageReserved(ptpage)))
+			struct page *ptpage;
+			unsigned long pfn = pte_pfn(page);
+			if (!pfn_valid(pfn))
+				continue;
+			ptpage = pfn_to_page(pfn);
+			if (!PageReserved(ptpage))
 				__free_page(ptpage);
 			continue;
 		}
Index: mm/vmscan.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/mm/vmscan.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 vmscan.c
--- mm/vmscan.c	2002/05/01 08:57:37	1.1.1.8
+++ mm/vmscan.c	2002/05/02 14:03:39
@@ -216,9 +216,10 @@
 
 	do {
 		if (pte_present(*pte)) {
-			struct page *page = pte_page(*pte);
+			unsigned long pfn = pte_pfn(*pte);
+			struct page *page = pfn_to_page(pfn);
 
-			if (VALID_PAGE(page) && !PageReserved(page)) {
+			if (pfn_valid(pfn) && !PageReserved(page)) {
 				count -= try_to_swap_out(mm, vma, address, pte, page, classzone);
 				if (!count) {
 					address += PAGE_SIZE;

