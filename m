Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVBWCLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVBWCLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 21:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVBWCLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 21:11:02 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:63953 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261386AbVBWCHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 21:07:43 -0500
Date: Wed, 23 Feb 2005 02:06:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
In-Reply-To: <421B0163.3050802@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> 
    <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston> 
    <20050217230342.GA3115@wotan.suse.de> 
    <20050217153031.011f873f.davem@davemloft.net> 
    <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au> 
    <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com> 
    <421B0163.3050802@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005, Nick Piggin wrote:
> 
> Also, the implementation of the macros is not insanely difficult
> to understand, so the details are still accessible.

True, they're okay; but I do think they've got one argument too
many, and I'd prefer to avoid that extra evaluation of the limit,
which comes from your move from "do while ()" to "for (;;)".

> Lastly, they fold to 2 and 3 levels easily, which is something
> that couldn't sanely be done with the open-coded implementation.
> I think with an infinitely smart compiler, there shouldn't need
> to be any folding here. But in practice I see quite a large
> speedup, which is something we shouldn't ignore.

Ben made the same point, yes, that is the real value of it.
But I rather think the same can be done without for_each_* macros:
compiling with gcc 3.3.4 suggests my *_limit macros may result in
slightly bigger code, but shorter codepath (no extra eval).

> I do think that they are probably not ideal candidates for a
> more general abstraction that would allow for example the
> transparent drop in of Dave's bitmap walking functions (it
> would be possible, but would not be pretty AFAIKS). I have some
> other ideas to work towards those goals, but before that I
> think these macros do help with the deficiencies of the current
> situation.

As I said before, I am keen on regularizing the implementations
and speeding them up; but not so keen on forcing into the
straitjacket of for_each_* macros instead of opencoded loops.
I've not seen Dave's bitmap walking functions (for clearing?),
would they fit in better with my way?

I'm off to bed, but since your appetite for looking at patches
is greater than mine, I'll throw what I'm currently testing over
the wall to you now.  Against 2.6.11-rc4-bk9, but my starting point
was obviously your patches.  Not yet split up, but clearly should be.
Includes mm/swapfile.c which you missed.  I'm inlining pmd and pud
levels, but not pte and pgd levels.  No description yet, sorry.
One point worth making, I do believe throughout that whatever the
address layout, "end" cannot be 0 - BUG_ON(addr >= end) assures.

Hugh

--- 2.6.11-rc4-bk9/arch/i386/mm/ioremap.c	2005-02-21 12:03:54.000000000 +0000
+++ linux/arch/i386/mm/ioremap.c	2005-02-22 23:57:48.000000000 +0000
@@ -17,86 +17,85 @@
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
 
-static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
+static inline void remap_area_pte(pmd_t *pmd, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
 {
-	unsigned long end;
 	unsigned long pfn;
+	pte_t *pte;
 
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
 	pfn = phys_addr >> PAGE_SHIFT;
+	pte = pte_offset_kernel(pmd, addr);
 	do {
-		if (!pte_none(*pte)) {
-			printk("remap_area_pte: page already exists\n");
-			BUG();
-		}
+		BUG_ON(!pte_none(*pte));
 		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
 					_PAGE_DIRTY | _PAGE_ACCESSED | flags)));
-		address += PAGE_SIZE;
 		pfn++;
-		pte++;
-	} while (address && (address < end));
+	} while (pte++, addr += PAGE_SIZE, addr < end);
 }
 
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
+static inline int remap_area_pmd(pud_t *pud, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
 {
-	unsigned long end;
+	unsigned long next;
+	pmd_t *pmd;
 
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
+	phys_addr -= addr;
+	pmd = pmd_offset(pud, addr);
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
-		if (!pte)
+		next = pmd_limit(addr, end);
+		if (!pte_alloc_kernel(&init_mm, pmd, addr))
 			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+		remap_area_pte(pmd, addr, next, phys_addr + addr, flags);
+	} while (pmd++, addr = next, addr < end);
 	return 0;
 }
 
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
+static inline int remap_area_pud(pgd_t *pgd, unsigned long addr,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
+{
+	unsigned long next;
+	pud_t *pud;
+	int error;
+
+	phys_addr -= addr;
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_limit(addr, end);
+		if (pmd_alloc(&init_mm, pud, addr))
+			error = remap_area_pmd(pud, addr, next,
+						phys_addr + addr, flags);
+		else
+			error = -ENOMEM;
+		if (error)
+			break;
+	} while (pud++, addr = next, addr < end);
+	return error;
+}
+
+static int remap_area_pages(unsigned long addr, unsigned long phys_addr,
 				 unsigned long size, unsigned long flags)
 {
+	unsigned long end = addr + size;
+	unsigned long next;
+	pgd_t *pgd;
 	int error;
-	pgd_t * dir;
-	unsigned long end = address + size;
 
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
+	BUG_ON(addr >= end);
+
 	flush_cache_all();
-	if (address >= end)
-		BUG();
+	phys_addr -= addr;
+	pgd = pgd_offset_k(addr);
 	spin_lock(&init_mm.page_table_lock);
 	do {
-		pud_t *pud;
-		pmd_t *pmd;
-		
-		error = -ENOMEM;
-		pud = pud_alloc(&init_mm, dir, address);
-		if (!pud)
-			break;
-		pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
-			break;
-		if (remap_area_pmd(pmd, address, end - address,
-					 phys_addr + address, flags))
+		next = pgd_limit(addr, end);
+		if (pud_alloc(&init_mm, pgd, addr))
+			error = remap_area_pud(pgd, addr, next,
+						phys_addr + addr, flags);
+		else
+			error = -ENOMEM;
+		if (error)
 			break;
-		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
+	} while (pgd++, addr = next, addr < end);
 	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return error;
--- 2.6.11-rc4-bk9/include/asm-generic/pgtable-nopmd.h	2005-02-21 12:04:08.000000000 +0000
+++ linux/include/asm-generic/pgtable-nopmd.h	2005-02-22 23:26:44.000000000 +0000
@@ -5,6 +5,8 @@
 
 #include <asm-generic/pgtable-nopud.h>
 
+#define __PAGETABLE_PMD_FOLDED
+
 /*
  * Having the pmd type consist of a pud gets the size right, and allows
  * us to conceptually access the pud entry that this pmd is folded into
@@ -55,6 +57,9 @@ static inline pmd_t * pmd_offset(pud_t *
 #define pmd_free(x)				do { } while (0)
 #define __pmd_free_tlb(tlb, x)			do { } while (0)
 
+#undef  pmd_limit
+#define pmd_limit(addr, end)			(end)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _PGTABLE_NOPMD_H */
--- 2.6.11-rc4-bk9/include/asm-generic/pgtable-nopud.h	2005-02-21 12:04:08.000000000 +0000
+++ linux/include/asm-generic/pgtable-nopud.h	2005-02-22 23:25:42.000000000 +0000
@@ -3,6 +3,8 @@
 
 #ifndef __ASSEMBLY__
 
+#define __PAGETABLE_PUD_FOLDED
+
 /*
  * Having the pud type consist of a pgd gets the size right, and allows
  * us to conceptually access the pgd entry that this pud is folded into
@@ -52,5 +54,8 @@ static inline pud_t * pud_offset(pgd_t *
 #define pud_free(x)				do { } while (0)
 #define __pud_free_tlb(tlb, x)			do { } while (0)
 
+#undef  pud_limit
+#define pud_limit(addr, end)			(end)
+
 #endif /* __ASSEMBLY__ */
 #endif /* _PGTABLE_NOPUD_H */
--- 2.6.11-rc4-bk9/include/asm-generic/pgtable.h	2004-10-18 22:56:28.000000000 +0100
+++ linux/include/asm-generic/pgtable.h	2005-02-22 23:42:53.000000000 +0000
@@ -134,4 +134,23 @@ static inline void ptep_mkdirty(pte_t *p
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
 
+#ifndef pmd_limit
+#define pmd_limit(addr, end)						\
+({	unsigned long __limit = ((addr) + PMD_SIZE) & PMD_MASK;		\
+	(__limit <= (end) && __limit)? __limit: (end);			\
+})
+#endif
+
+#ifndef pud_limit
+#define pud_limit(addr, end)						\
+({	unsigned long __limit = ((addr) + PUD_SIZE) & PUD_MASK;		\
+	(__limit <= (end) && __limit)? __limit: (end);			\
+})
+#endif
+
+#define pgd_limit(addr, end)						\
+({	unsigned long __limit = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
+	(__limit <= (end) && __limit)? __limit: (end);			\
+})
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
--- 2.6.11-rc4-bk9/mm/memory.c	2005-02-21 12:04:51.000000000 +0000
+++ linux/mm/memory.c	2005-02-22 23:19:52.000000000 +0000
@@ -87,20 +87,12 @@ EXPORT_SYMBOL(vmalloc_earlyreserve);
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static inline void clear_pmd_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long start, unsigned long end)
+static inline void clear_pmd_range(struct mmu_gather *tlb,
+		pmd_t *pmd, unsigned long addr, unsigned long end)
 {
-	struct page *page;
-
-	if (pmd_none(*pmd))
-		return;
-	if (unlikely(pmd_bad(*pmd))) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-	if (!((start | end) & ~PMD_MASK)) {
+	if (!((addr | end) & ~PMD_MASK)) {
 		/* Only clear full, aligned ranges */
-		page = pmd_page(*pmd);
+		struct page *page = pmd_page(*pmd);
 		pmd_clear(pmd);
 		dec_page_state(nr_page_table_pages);
 		tlb->mm->nr_ptes--;
@@ -108,66 +100,57 @@ static inline void clear_pmd_range(struc
 	}
 }
 
-static inline void clear_pud_range(struct mmu_gather *tlb, pud_t *pud, unsigned long start, unsigned long end)
+static inline void clear_pud_range(struct mmu_gather *tlb,
+		pud_t *pud, unsigned long addr, unsigned long end)
 {
-	unsigned long addr = start, next;
-	pmd_t *pmd, *__pmd;
-
-	if (pud_none(*pud))
-		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
+	unsigned long start = addr;
+	unsigned long next;
+	pmd_t *pmd, *start_pmd;
 
-	pmd = __pmd = pmd_offset(pud, start);
+	start_pmd = pmd = pmd_offset(pud, addr);
 	do {
-		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		
+		next = pmd_limit(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (unlikely(pmd_bad(*pmd))) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
 		clear_pmd_range(tlb, pmd, addr, next);
-		pmd++;
-		addr = next;
-	} while (addr && (addr < end));
+	} while (pmd++, addr = next, addr < end);
 
 	if (!((start | end) & ~PUD_MASK)) {
 		/* Only clear full, aligned ranges */
 		pud_clear(pud);
-		pmd_free_tlb(tlb, __pmd);
+		pmd_free_tlb(tlb, start_pmd);
 	}
 }
 
-
-static inline void clear_pgd_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long start, unsigned long end)
+static inline void clear_pgd_range(struct mmu_gather *tlb,
+		pgd_t *pgd, unsigned long addr, unsigned long end)
 {
-	unsigned long addr = start, next;
-	pud_t *pud, *__pud;
-
-	if (pgd_none(*pgd))
-		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
+	unsigned long start = addr;
+	unsigned long next;
+	pud_t *pud, *start_pud;
 
-	pud = __pud = pud_offset(pgd, start);
+	start_pud = pud = pud_offset(pgd, addr);
 	do {
-		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		
+		next = pud_limit(addr, end);
+		if (pud_none(*pud))
+			continue;
+		if (unlikely(pud_bad(*pud))) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
 		clear_pud_range(tlb, pud, addr, next);
-		pud++;
-		addr = next;
-	} while (addr && (addr < end));
+	} while (pud++, addr = next, addr < end);
 
 	if (!((start | end) & ~PGDIR_MASK)) {
 		/* Only clear full, aligned ranges */
 		pgd_clear(pgd);
-		pud_free_tlb(tlb, __pud);
+		pud_free_tlb(tlb, start_pud);
 	}
 }
 
@@ -176,47 +159,60 @@ static inline void clear_pgd_range(struc
  *
  * Must be called with pagetable lock held.
  */
-void clear_page_range(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+void clear_page_range(struct mmu_gather *tlb,
+		unsigned long addr, unsigned long end)
 {
-	unsigned long addr = start, next;
-	pgd_t * pgd = pgd_offset(tlb->mm, start);
-	unsigned long i;
-
-	for (i = pgd_index(start); i <= pgd_index(end-1); i++) {
-		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		
+	unsigned long next;
+	pgd_t *pgd;
+
+	BUG_ON(addr >= end);
+
+	pgd = pgd_offset(tlb->mm, addr);
+	do {
+		next = pgd_limit(addr, end);
+		if (pgd_none(*pgd))
+			continue;
+		if (unlikely(pgd_bad(*pgd))) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
 		clear_pgd_range(tlb, pgd, addr, next);
-		pgd++;
-		addr = next;
-	}
+	} while (pgd++, addr = next, addr < end);
 }
 
-pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+static int pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
-	if (!pmd_present(*pmd)) {
-		struct page *new;
+	struct page *new;
 
-		spin_unlock(&mm->page_table_lock);
-		new = pte_alloc_one(mm, address);
-		spin_lock(&mm->page_table_lock);
-		if (!new)
-			return NULL;
-		/*
-		 * Because we dropped the lock, we should re-check the
-		 * entry, as somebody else could have populated it..
-		 */
-		if (pmd_present(*pmd)) {
-			pte_free(new);
-			goto out;
-		}
-		mm->nr_ptes++;
-		inc_page_state(nr_page_table_pages);
-		pmd_populate(mm, pmd, new);
+	if (pmd_present(*pmd))
+		return 1;
+
+	spin_unlock(&mm->page_table_lock);
+	new = pte_alloc_one(mm, address);
+	spin_lock(&mm->page_table_lock);
+	if (!new)
+		return 0;
+	/*
+	 * Because we dropped the lock, we should re-check the
+	 * entry, as somebody else could have populated it..
+	 */
+	if (pmd_present(*pmd)) {
+		pte_free(new);
+		return 1;
 	}
-out:
-	return pte_offset_map(pmd, address);
+	mm->nr_ptes++;
+	inc_page_state(nr_page_table_pages);
+	pmd_populate(mm, pmd, new);
+
+	return 1;
+}
+
+pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
+{
+	if (pte_alloc(mm, pmd, address))
+		return pte_offset_map(pmd, address);
+	return NULL;
 }
 
 pte_t fastcall * pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
@@ -253,23 +249,8 @@ out:
  * but may be dropped within p[mg]d_alloc() and pte_alloc_map().
  */
 
-static inline void
-copy_swap_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm, pte_t pte)
-{
-	if (pte_file(pte))
-		return;
-	swap_duplicate(pte_to_swp_entry(pte));
-	if (list_empty(&dst_mm->mmlist)) {
-		spin_lock(&mmlist_lock);
-		list_add(&dst_mm->mmlist, &src_mm->mmlist);
-		spin_unlock(&mmlist_lock);
-	}
-}
-
-static inline void
-copy_one_pte(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, unsigned long vm_flags,
-		unsigned long addr)
+static inline int copy_one_pte(pte_t *dst_pte, pte_t *src_pte,
+				unsigned long vm_flags)
 {
 	pte_t pte = *src_pte;
 	struct page *page;
@@ -277,10 +258,13 @@ copy_one_pte(struct mm_struct *dst_mm,  
 
 	/* pte contains position in swap, so copy. */
 	if (!pte_present(pte)) {
-		copy_swap_pte(dst_mm, src_mm, pte);
 		set_pte(dst_pte, pte);
-		return;
+		if (pte_file(pte))
+			return 0;	/* no special action */
+		swap_duplicate(pte_to_swp_entry(pte));
+		return 1;		/* check swapoff's mmlist */
 	}
+
 	pfn = pte_pfn(pte);
 	/* the pte points outside of valid memory, the
 	 * mapping is assumed to be good, meaningful
@@ -293,7 +277,7 @@ copy_one_pte(struct mm_struct *dst_mm,  
 
 	if (!page || PageReserved(page)) {
 		set_pte(dst_pte, pte);
-		return;
+		return 0;		/* no special action */
 	}
 
 	/*
@@ -306,63 +290,71 @@ copy_one_pte(struct mm_struct *dst_mm,  
 	}
 
 	/*
-	 * If it's a shared mapping, mark it clean in
-	 * the child
+	 * If it's a shared mapping, mark it clean in the child
 	 */
 	if (vm_flags & VM_SHARED)
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 	get_page(page);
-	dst_mm->rss++;
-	if (PageAnon(page))
-		dst_mm->anon_rss++;
 	set_pte(dst_pte, pte);
 	page_dup_rmap(page);
+
+	return 2 + !!PageAnon(page);	/* count rss and anon_rss */
 }
 
-static int copy_pte_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
-		pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
+static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long vm_flags,
 		unsigned long addr, unsigned long end)
 {
 	pte_t *src_pte, *dst_pte;
-	pte_t *s, *d;
-	unsigned long vm_flags = vma->vm_flags;
+	int count[4] = {0, 0, 0, 0};
 
-	d = dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
+	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
 	if (!dst_pte)
 		return -ENOMEM;
 
 	spin_lock(&src_mm->page_table_lock);
-	s = src_pte = pte_offset_map_nested(src_pmd, addr);
-	for (; addr < end; addr += PAGE_SIZE, s++, d++) {
-		if (pte_none(*s))
-			continue;
-		copy_one_pte(dst_mm, src_mm, d, s, vm_flags, addr);
-	}
-	pte_unmap_nested(src_pte);
-	pte_unmap(dst_pte);
+	src_pte = pte_offset_map_nested(src_pmd, addr);
+
+	do {
+		if (!pte_none(*src_pte))
+			count[copy_one_pte(dst_pte, src_pte, vm_flags)]++;
+	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr < end);
+
+	pte_unmap_nested(src_pte - 1);
 	spin_unlock(&src_mm->page_table_lock);
+
+	/* Make sure dst_mm is on mmlist if it has any swap */
+	if (count[1] && list_empty(&dst_mm->mmlist)) {
+		spin_lock(&mmlist_lock);
+		list_add(&dst_mm->mmlist, &src_mm->mmlist);
+		spin_unlock(&mmlist_lock);
+	}
+	if (count[2] += count[3])
+		dst_mm->rss += count[2];
+	if (count[3])
+		dst_mm->anon_rss += count[3];
+
+	pte_unmap(dst_pte - 1);
 	cond_resched_lock(&dst_mm->page_table_lock);
 	return 0;
 }
 
-static int copy_pmd_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
-		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+static inline int copy_pmd_range(struct mm_struct *dst_mm,
+		struct mm_struct *src_mm, pud_t *dst_pud, pud_t *src_pud,
+		unsigned long vm_flags, unsigned long addr, unsigned long end)
 {
+	unsigned long next;
 	pmd_t *src_pmd, *dst_pmd;
 	int err = 0;
-	unsigned long next;
 
-	src_pmd = pmd_offset(src_pud, addr);
 	dst_pmd = pmd_alloc(dst_mm, dst_pud, addr);
 	if (!dst_pmd)
 		return -ENOMEM;
 
-	for (; addr < end; addr = next, src_pmd++, dst_pmd++) {
-		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end || next <= addr)
-			next = end;
+	src_pmd = pmd_offset(src_pud, addr);
+	do {
+		next = pmd_limit(addr, end);
 		if (pmd_none(*src_pmd))
 			continue;
 		if (pmd_bad(*src_pmd)) {
@@ -371,30 +363,28 @@ static int copy_pmd_range(struct mm_stru
 			continue;
 		}
 		err = copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-							vma, addr, next);
-		if (err)
+						vm_flags, addr, next);
+		if (unlikely(err))
 			break;
-	}
+	} while (dst_pmd++, src_pmd++, addr = next, addr < end);
 	return err;
 }
 
-static int copy_pud_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
-		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+static inline int copy_pud_range(struct mm_struct *dst_mm,
+		struct mm_struct *src_mm, pgd_t *dst_pgd, pgd_t *src_pgd,
+		unsigned long vm_flags, unsigned long addr, unsigned long end)
 {
+	unsigned long next;
 	pud_t *src_pud, *dst_pud;
 	int err = 0;
-	unsigned long next;
 
-	src_pud = pud_offset(src_pgd, addr);
 	dst_pud = pud_alloc(dst_mm, dst_pgd, addr);
 	if (!dst_pud)
 		return -ENOMEM;
 
-	for (; addr < end; addr = next, src_pud++, dst_pud++) {
-		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end || next <= addr)
-			next = end;
+	src_pud = pud_offset(src_pgd, addr);
+	do {
+		next = pud_limit(addr, end);
 		if (pud_none(*src_pud))
 			continue;
 		if (pud_bad(*src_pud)) {
@@ -403,82 +393,58 @@ static int copy_pud_range(struct mm_stru
 			continue;
 		}
 		err = copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-							vma, addr, next);
-		if (err)
+						vm_flags, addr, next);
+		if (unlikely(err))
 			break;
-	}
+	} while (dst_pud++, src_pud++, addr = next, addr < end);
 	return err;
 }
 
-int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
+int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		struct vm_area_struct *vma)
 {
+	unsigned long addr, end, next;
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long addr, start, end, next;
 	int err = 0;
 
 	if (is_vm_hugetlb_page(vma))
-		return copy_hugetlb_page_range(dst, src, vma);
-
-	start = vma->vm_start;
-	src_pgd = pgd_offset(src, start);
-	dst_pgd = pgd_offset(dst, start);
+		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
 
+	addr = vma->vm_start;
 	end = vma->vm_end;
-	addr = start;
-	while (addr && (addr < end-1)) {
-		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= addr)
-			next = end;
+	dst_pgd = pgd_offset(dst_mm, addr);
+	src_pgd = pgd_offset(src_mm, addr);
+	do {
+		next = pgd_limit(addr, end);
 		if (pgd_none(*src_pgd))
-			goto next_pgd;
+			continue;
 		if (pgd_bad(*src_pgd)) {
 			pgd_ERROR(*src_pgd);
 			pgd_clear(src_pgd);
-			goto next_pgd;
+			continue;
 		}
-		err = copy_pud_range(dst, src, dst_pgd, src_pgd,
-							vma, addr, next);
-		if (err)
+		err = copy_pud_range(dst_mm, src_mm, dst_pgd, src_pgd,
+					vma->vm_flags, addr, next);
+		if (unlikely(err))
 			break;
-
-next_pgd:
-		src_pgd++;
-		dst_pgd++;
-		addr = next;
-	}
-
+	} while (dst_pgd++, src_pgd++, addr = next, addr < end);
 	return err;
 }
 
 static void zap_pte_range(struct mmu_gather *tlb,
-		pmd_t *pmd, unsigned long address,
-		unsigned long size, struct zap_details *details)
+		pmd_t *pmd, unsigned long addr, unsigned long end,
+		struct zap_details *details)
 {
-	unsigned long offset;
-	pte_t *ptep;
+	pte_t *pte;
 
-	if (pmd_none(*pmd))
-		return;
-	if (unlikely(pmd_bad(*pmd))) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-	ptep = pte_offset_map(pmd, address);
-	offset = address & ~PMD_MASK;
-	if (offset + size > PMD_SIZE)
-		size = PMD_SIZE - offset;
-	size &= PAGE_MASK;
-	if (details && !details->check_mapping && !details->nonlinear_vma)
-		details = NULL;
-	for (offset=0; offset < size; ptep++, offset += PAGE_SIZE) {
-		pte_t pte = *ptep;
-		if (pte_none(pte))
+	pte = pte_offset_map(pmd, addr);
+	do {
+		pte_t entry = *pte;
+		if (pte_none(entry))
 			continue;
-		if (pte_present(pte)) {
+		if (pte_present(entry)) {
 			struct page *page = NULL;
-			unsigned long pfn = pte_pfn(pte);
+			unsigned long pfn = pte_pfn(entry);
 			if (pfn_valid(pfn)) {
 				page = pfn_to_page(pfn);
 				if (PageReserved(page))
@@ -502,19 +468,19 @@ static void zap_pte_range(struct mmu_gat
 				     page->index > details->last_index))
 					continue;
 			}
-			pte = ptep_get_and_clear(ptep);
-			tlb_remove_tlb_entry(tlb, ptep, address+offset);
+			entry = ptep_get_and_clear(pte);
+			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
-					address+offset) != page->index)
-				set_pte(ptep, pgoff_to_pte(page->index));
-			if (pte_dirty(pte))
+					addr) != page->index)
+				set_pte(pte, pgoff_to_pte(page->index));
+			if (pte_dirty(entry))
 				set_page_dirty(page);
 			if (PageAnon(page))
 				tlb->mm->anon_rss--;
-			else if (pte_young(pte))
+			else if (pte_young(entry))
 				mark_page_accessed(page);
 			tlb->freed++;
 			page_remove_rmap(page);
@@ -527,78 +493,79 @@ static void zap_pte_range(struct mmu_gat
 		 */
 		if (unlikely(details))
 			continue;
-		if (!pte_file(pte))
-			free_swap_and_cache(pte_to_swp_entry(pte));
-		pte_clear(ptep);
-	}
-	pte_unmap(ptep-1);
+		if (!pte_file(entry))
+			free_swap_and_cache(pte_to_swp_entry(entry));
+		pte_clear(pte);
+	} while (pte++, addr += PAGE_SIZE, addr < end);
+	pte_unmap(pte - 1);
 }
 
-static void zap_pmd_range(struct mmu_gather *tlb,
-		pud_t *pud, unsigned long address,
-		unsigned long size, struct zap_details *details)
+static inline void zap_pmd_range(struct mmu_gather *tlb,
+		pud_t *pud, unsigned long addr, unsigned long end,
+		struct zap_details *details)
 {
-	pmd_t * pmd;
-	unsigned long end;
+	unsigned long next;
+	pmd_t *pmd;
 
-	if (pud_none(*pud))
-		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
-	pmd = pmd_offset(pud, address);
-	end = address + size;
-	if (end > ((address + PUD_SIZE) & PUD_MASK))
-		end = ((address + PUD_SIZE) & PUD_MASK);
+	pmd = pmd_offset(pud, addr);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address, details);
-		address = (address + PMD_SIZE) & PMD_MASK; 
-		pmd++;
-	} while (address && (address < end));
+		next = pmd_limit(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (unlikely(pmd_bad(*pmd))) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
+		zap_pte_range(tlb, pmd, addr, next, details);
+	} while (pmd++, addr = next, addr < end);
 }
 
-static void zap_pud_range(struct mmu_gather *tlb,
-		pgd_t * pgd, unsigned long address,
-		unsigned long end, struct zap_details *details)
+static inline void zap_pud_range(struct mmu_gather *tlb,
+		pgd_t *pgd, unsigned long addr, unsigned long end,
+		struct zap_details *details)
 {
-	pud_t * pud;
+	unsigned long next;
+	pud_t *pud;
 
-	if (pgd_none(*pgd))
-		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
-	pud = pud_offset(pgd, address);
+	pud = pud_offset(pgd, addr);
 	do {
-		zap_pmd_range(tlb, pud, address, end - address, details);
-		address = (address + PUD_SIZE) & PUD_MASK; 
-		pud++;
-	} while (address && (address < end));
+		next = pud_limit(addr, end);
+		if (pud_none(*pud))
+			continue;
+		if (unlikely(pud_bad(*pud))) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+		zap_pmd_range(tlb, pud, addr, next, details);
+	} while (pud++, addr = next, addr < end);
 }
 
-static void unmap_page_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long address,
+static void zap_pgd_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long addr,
 		unsigned long end, struct zap_details *details)
 {
 	unsigned long next;
 	pgd_t *pgd;
-	int i;
 
-	BUG_ON(address >= end);
-	pgd = pgd_offset(vma->vm_mm, address);
+	BUG_ON(addr >= end);
+	if (details && !details->check_mapping && !details->nonlinear_vma)
+		details = NULL;
+
 	tlb_start_vma(tlb, vma);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= address || next > end)
-			next = end;
-		zap_pud_range(tlb, pgd, address, next, details);
-		address = next;
-		pgd++;
-	}
+	pgd = pgd_offset(vma->vm_mm, addr);
+	do {
+		next = pgd_limit(addr, end);
+		if (pgd_none(*pgd))
+			continue;
+		if (unlikely(pgd_bad(*pgd))) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+		zap_pud_range(tlb, pgd, addr, next, details);
+	} while (pgd++, addr = next, addr < end);
 	tlb_end_vma(tlb, vma);
 }
 
@@ -676,7 +643,7 @@ int unmap_vmas(struct mmu_gather **tlbp,
 				unmap_hugepage_range(vma, start, end);
 			} else {
 				block = min(zap_bytes, end - start);
-				unmap_page_range(*tlbp, vma, start,
+				zap_pgd_range(*tlbp, vma, start,
 						start + block, details);
 			}
 
@@ -987,109 +954,80 @@ out:
 
 EXPORT_SYMBOL(get_user_pages);
 
-static void zeromap_pte_range(pte_t * pte, unsigned long address,
-                                     unsigned long size, pgprot_t prot)
+static void zeromap_pte_range(pmd_t *pmd, unsigned long addr,
+		unsigned long end, pgprot_t prot)
 {
-	unsigned long end;
+	pte_t *pte;
 
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pte = pte_offset_map(pmd, addr);
 	do {
-		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(address), prot));
+		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(addr), prot));
 		BUG_ON(!pte_none(*pte));
 		set_pte(pte, zero_pte);
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
+	} while (pte++, addr += PAGE_SIZE, addr < end);
+	pte_unmap(pte - 1);
 }
 
-static inline int zeromap_pmd_range(struct mm_struct *mm, pmd_t * pmd,
-		unsigned long address, unsigned long size, pgprot_t prot)
+static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t *pud,
+		unsigned long addr, unsigned long end, pgprot_t prot)
 {
-	unsigned long base, end;
+	unsigned long next;
+	pmd_t *pmd;
 
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
+	pmd = pmd_offset(pud, addr);
 	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
-		if (!pte)
+		next = pmd_limit(addr, end);
+		if (!pte_alloc(mm, pmd, addr))
 			return -ENOMEM;
-		zeromap_pte_range(pte, base + address, end - address, prot);
-		pte_unmap(pte);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+		zeromap_pte_range(pmd, addr, next, prot);
+	} while (pmd++, addr = next, addr < end);
 	return 0;
 }
 
-static inline int zeromap_pud_range(struct mm_struct *mm, pud_t * pud,
-				    unsigned long address,
-                                    unsigned long size, pgprot_t prot)
-{
-	unsigned long base, end;
-	int error = 0;
-
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
+static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t *pgd,
+		unsigned long addr, unsigned long end, pgprot_t prot)
+{
+	unsigned long next;
+	pud_t *pud;
+	int error;
+
+	pud = pud_offset(pgd, addr);
 	do {
-		pmd_t * pmd = pmd_alloc(mm, pud, base + address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		error = zeromap_pmd_range(mm, pmd, base + address,
-					  end - address, prot);
+		next = pud_limit(addr, end);
+		if (pmd_alloc(mm, pud, addr))
+			error = zeromap_pmd_range(mm, pud, addr, next, prot);
+		else
+			error = -ENOMEM;
 		if (error)
 			break;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-	return 0;
+	} while (pud++, addr = next, addr < end);
+	return error;
 }
 
-int zeromap_page_range(struct vm_area_struct *vma, unsigned long address,
-					unsigned long size, pgprot_t prot)
+int zeromap_page_range(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long size, pgprot_t prot)
 {
-	int i;
-	int error = 0;
-	pgd_t * pgd;
-	unsigned long beg = address;
-	unsigned long end = address + size;
-	unsigned long next;
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long end = addr + size;
+	unsigned long next;
+	pgd_t *pgd;
+	int error;
 
-	pgd = pgd_offset(mm, address);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(address >= end);
+	BUG_ON(addr >= end);
 	BUG_ON(end > vma->vm_end);
 
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(mm, pgd, address);
-		error = -ENOMEM;
-		if (!pud)
-			break;
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= beg || next > end)
-			next = end;
-		error = zeromap_pud_range(mm, pud, address,
-						next - address, prot);
+	do {
+		next = pgd_limit(addr, end);
+		if (pud_alloc(mm, pgd, addr))
+			error = zeromap_pud_range(mm, pgd, addr, next, prot);
+		else
+			error = -ENOMEM;
 		if (error)
 			break;
-		address = next;
-		pgd++;
-	}
-	/*
-	 * Why flush? zeromap_pte_range has a BUG_ON for !pte_none()
-	 */
-	flush_tlb_range(vma, beg, end);
+	} while (pgd++, addr = next, addr < end);
 	spin_unlock(&mm->page_table_lock);
 	return error;
 }
@@ -1099,95 +1037,74 @@ int zeromap_page_range(struct vm_area_st
  * mappings are removed. any references to nonexistent pages results
  * in null mappings (currently treated as "copy-on-access")
  */
-static inline void
-remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
+static void remap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		unsigned long pfn, pgprot_t prot)
 {
-	unsigned long end;
+	pte_t *pte;
 
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pte = pte_offset_map(pmd, addr);
 	do {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
  			set_pte(pte, pfn_pte(pfn, prot));
-		address += PAGE_SIZE;
 		pfn++;
-		pte++;
-	} while (address && (address < end));
+	} while (pte++, addr += PAGE_SIZE, addr < end);
+	pte_unmap(pte - 1);
 }
 
-static inline int
-remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address,
-		unsigned long size, unsigned long pfn, pgprot_t prot)
+static inline int remap_pmd_range(struct mm_struct *mm,
+		pud_t *pud, unsigned long addr, unsigned long end,
+		unsigned long pfn, pgprot_t prot)
 {
-	unsigned long base, end;
+	unsigned long next;
+	pmd_t *pmd;
 
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-	pfn -= (address >> PAGE_SHIFT);
+	pfn -= addr >> PAGE_SHIFT;
+	pmd = pmd_offset(pud, addr);
 	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
-		if (!pte)
+		next = pmd_limit(addr, end);
+		if (!pte_alloc(mm, pmd, addr))
 			return -ENOMEM;
-		remap_pte_range(pte, base + address, end - address,
-				(address >> PAGE_SHIFT) + pfn, prot);
-		pte_unmap(pte);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+		remap_pte_range(pmd, addr, next,
+				pfn + (addr >> PAGE_SHIFT), prot);
+	} while (pmd++, addr = next, addr < end);
 	return 0;
 }
 
-static inline int remap_pud_range(struct mm_struct *mm, pud_t * pud,
-				  unsigned long address, unsigned long size,
-				  unsigned long pfn, pgprot_t prot)
+static inline int remap_pud_range(struct mm_struct *mm,
+		pgd_t *pgd, unsigned long addr, unsigned long end,
+		unsigned long pfn, pgprot_t prot)
 {
-	unsigned long base, end;
+	unsigned long next;
+	pud_t *pud;
 	int error;
 
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	pfn -= address >> PAGE_SHIFT;
+	pfn -= addr >> PAGE_SHIFT;
+	pud = pud_offset(pgd, addr);
 	do {
-		pmd_t *pmd = pmd_alloc(mm, pud, base+address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		error = remap_pmd_range(mm, pmd, base + address, end - address,
-				(address >> PAGE_SHIFT) + pfn, prot);
+		next = pud_limit(addr, end);
+		if (pmd_alloc(mm, pud, addr))
+			error = remap_pmd_range(mm, pud, addr, next,
+					pfn + (addr >> PAGE_SHIFT), prot);
+		else
+			error = -ENOMEM;
 		if (error)
 			break;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
+	} while (pud++, addr = next, addr < end);
 	return error;
 }
 
 /*  Note: this is only safe if the mm semaphore is held when called. */
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		    unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	int error = 0;
-	pgd_t *pgd;
-	unsigned long beg = from;
-	unsigned long end = from + size;
-	unsigned long next;
 	struct mm_struct *mm = vma->vm_mm;
-	int i;
+	unsigned long next;
+	unsigned long end = addr + size;
+	pgd_t *pgd;
+	int error;
 
-	pfn -= from >> PAGE_SHIFT;
-	pgd = pgd_offset(mm, from);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(from >= end);
+	BUG_ON(addr >= end);
 
 	/*
 	 * Physically remapped pages are special. Tell the
@@ -1199,28 +1116,21 @@ int remap_pfn_range(struct vm_area_struc
 	 */
 	vma->vm_flags |= VM_IO | VM_RESERVED;
 
+	pfn -= addr >> PAGE_SHIFT;
+	flush_cache_range(vma, addr, end);
+	pgd = pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(beg); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(mm, pgd, from);
-		error = -ENOMEM;
-		if (!pud)
-			break;
-		next = (from + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= from)
-			next = end;
-		error = remap_pud_range(mm, pud, from, end - from,
-					pfn + (from >> PAGE_SHIFT), prot);
+	do {
+		next = pgd_limit(addr, end);
+		if (pud_alloc(mm, pgd, addr))
+			error = remap_pud_range(mm, pgd, addr, next,
+					pfn + (addr >> PAGE_SHIFT), prot);
+		else
+			error = -ENOMEM;
 		if (error)
 			break;
-		from = next;
-		pgd++;
-	}
-	/*
-	 * Why flush? remap_pte_range has a BUG_ON for !pte_none()
-	 */
-	flush_tlb_range(vma, beg, end);
+	} while (pgd++, addr = next, addr < end);
 	spin_unlock(&mm->page_table_lock);
-
 	return error;
 }
 
@@ -2100,6 +2010,8 @@ int handle_mm_fault(struct mm_struct *mm
 }
 
 #ifndef __ARCH_HAS_4LEVEL_HACK
+
+#ifndef __PAGETABLE_PUD_FOLDED
 /*
  * Allocate page upper directory.
  *
@@ -2131,7 +2043,9 @@ pud_t fastcall *__pud_alloc(struct mm_st
  out:
 	return pud_offset(pgd, address);
 }
+#endif /* __PAGETABLE_PUD_FOLDED */
 
+#ifndef __PAGETABLE_PMD_FOLDED
 /*
  * Allocate page middle directory.
  *
@@ -2163,7 +2077,9 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
  out:
 	return pmd_offset(pud, address);
 }
-#else
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+#else /* __ARCH_HAS_4LEVEL_HACK */
 pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	pmd_t *new;
--- 2.6.11-rc4-bk9/mm/mprotect.c	2005-02-21 12:04:11.000000000 +0000
+++ linux/mm/mprotect.c	2005-02-22 20:01:08.000000000 +0000
@@ -25,25 +25,12 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static inline void
-change_pte_range(pmd_t *pmd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+static void change_pte_range(pmd_t *pmd, unsigned long addr,
+				unsigned long end, pgprot_t newprot)
 {
-	pte_t * pte;
-	unsigned long end;
+	pte_t *pte;
 
-	if (pmd_none(*pmd))
-		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-	pte = pte_offset_map(pmd, address);
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	pte = pte_offset_map(pmd, addr);
 	do {
 		if (pte_present(*pte)) {
 			pte_t entry;
@@ -55,86 +42,73 @@ change_pte_range(pmd_t *pmd, unsigned lo
 			entry = ptep_get_and_clear(pte);
 			set_pte(pte, pte_modify(entry, newprot));
 		}
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
+	} while (pte++, addr += PAGE_SIZE, addr < end);
 	pte_unmap(pte - 1);
 }
 
-static inline void
-change_pmd_range(pud_t *pud, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+static inline void change_pmd_range(pud_t *pud, unsigned long addr,
+				unsigned long end, pgprot_t newprot)
 {
-	pmd_t * pmd;
-	unsigned long end;
+	unsigned long next;
+	pmd_t *pmd;
 
-	if (pud_none(*pud))
-		return;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
-	pmd = pmd_offset(pud, address);
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
+	pmd = pmd_offset(pud, addr);
 	do {
-		change_pte_range(pmd, address, end - address, newprot);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+		next = pmd_limit(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
+		change_pte_range(pmd, addr, next, newprot);
+	} while (pmd++, addr = next, addr < end);
 }
 
-static inline void
-change_pud_range(pgd_t *pgd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+static inline void change_pud_range(pgd_t *pgd, unsigned long addr,
+				unsigned long end, pgprot_t newprot)
 {
-	pud_t * pud;
-	unsigned long end;
+	unsigned long next;
+	pud_t *pud;
 
-	if (pgd_none(*pgd))
-		return;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
-	pud = pud_offset(pgd, address);
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
+	pud = pud_offset(pgd, addr);
 	do {
-		change_pmd_range(pud, address, end - address, newprot);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
+		next = pud_limit(addr, end);
+		if (pud_none(*pud))
+			continue;
+		if (pud_bad(*pud)) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+		change_pmd_range(pud, addr, next, newprot);
+	} while (pud++, addr = next, addr < end);
 }
 
-static void
-change_protection(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, pgprot_t newprot)
+static void change_protection(struct vm_area_struct *vma, unsigned long addr,
+				unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long start = addr;
+	unsigned long next;
 	pgd_t *pgd;
-	unsigned long beg = start, next;
-	int i;
 
-	pgd = pgd_offset(mm, start);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(start >= end);
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(start); i <= pgd_index(end-1); i++) {
-		next = (start + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= start || next > end)
-			next = end;
-		change_pud_range(pgd, start, next - start, newprot);
-		start = next;
-		pgd++;
-	}
-	flush_tlb_range(vma, beg, end);
+	do {
+		next = pgd_limit(addr, end);
+		if (pgd_none(*pgd))
+			continue;
+		if (pgd_bad(*pgd)) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+		change_pud_range(pgd, addr, next, newprot);
+	} while (pgd++, addr = next, addr < end);
+	flush_tlb_range(vma, start, end);
 	spin_unlock(&mm->page_table_lock);
 }
 
--- 2.6.11-rc4-bk9/mm/msync.c	2005-02-21 12:04:11.000000000 +0000
+++ linux/mm/msync.c	2005-02-22 19:59:51.000000000 +0000
@@ -21,170 +21,125 @@
  * Called with mm->page_table_lock held to protect against other
  * threads/the swapper from ripping pte's out from under us.
  */
-static int filemap_sync_pte(pte_t *ptep, struct vm_area_struct *vma,
-	unsigned long address, unsigned int flags)
-{
-	pte_t pte = *ptep;
-	unsigned long pfn = pte_pfn(pte);
-	struct page *page;
-
-	if (pte_present(pte) && pfn_valid(pfn)) {
-		page = pfn_to_page(pfn);
-		if (!PageReserved(page) &&
-		    (ptep_clear_flush_dirty(vma, address, ptep) ||
-		     page_test_and_clear_dirty(page)))
-			set_page_dirty(page);
-	}
-	return 0;
-}
 
-static int filemap_sync_pte_range(pmd_t * pmd,
-	unsigned long address, unsigned long end, 
-	struct vm_area_struct *vma, unsigned int flags)
+static void sync_pte_range(pmd_t *pmd,
+		unsigned long addr, unsigned long end, 
+		struct vm_area_struct *vma, unsigned int flags)
 {
 	pte_t *pte;
-	int error;
 
-	if (pmd_none(*pmd))
-		return 0;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return 0;
-	}
-	pte = pte_offset_map(pmd, address);
-	if ((address & PMD_MASK) != (end & PMD_MASK))
-		end = (address & PMD_MASK) + PMD_SIZE;
-	error = 0;
+	pte = pte_offset_map(pmd, addr);
 	do {
-		error |= filemap_sync_pte(pte, vma, address, flags);
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
-
+		pte_t entry = *pte;
+		unsigned long pfn;
+		struct page *page;
+
+		if (!pte_present(entry))
+			continue;
+		pfn = pte_pfn(entry);
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		if (PageReserved(page))
+			continue;
+		if (ptep_clear_flush_dirty(vma, addr, pte) ||
+		    page_test_and_clear_dirty(page))
+			set_page_dirty(page);
+	} while (pte++, addr += PAGE_SIZE, addr < end);
 	pte_unmap(pte - 1);
-
-	return error;
 }
 
-static inline int filemap_sync_pmd_range(pud_t * pud,
-	unsigned long address, unsigned long end, 
-	struct vm_area_struct *vma, unsigned int flags)
+static inline void sync_pmd_range(pud_t *pud,
+		unsigned long addr, unsigned long end, 
+		struct vm_area_struct *vma, unsigned int flags)
 {
-	pmd_t * pmd;
-	int error;
+	unsigned long next;
+	pmd_t *pmd;
 
-	if (pud_none(*pud))
-		return 0;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return 0;
-	}
-	pmd = pmd_offset(pud, address);
-	if ((address & PUD_MASK) != (end & PUD_MASK))
-		end = (address & PUD_MASK) + PUD_SIZE;
-	error = 0;
+	pmd = pmd_offset(pud, addr);
 	do {
-		error |= filemap_sync_pte_range(pmd, address, end, vma, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return error;
+		next = pmd_limit(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
+		sync_pte_range(pmd, addr, next, vma, flags);
+	} while (pmd++, addr = next, addr < end);
 }
 
-static inline int filemap_sync_pud_range(pgd_t *pgd,
-	unsigned long address, unsigned long end,
-	struct vm_area_struct *vma, unsigned int flags)
+static inline void sync_pud_range(pgd_t *pgd,
+		unsigned long addr, unsigned long end,
+		struct vm_area_struct *vma, unsigned int flags)
 {
+	unsigned long next;
 	pud_t *pud;
-	int error;
 
-	if (pgd_none(*pgd))
-		return 0;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return 0;
-	}
-	pud = pud_offset(pgd, address);
-	if ((address & PGDIR_MASK) != (end & PGDIR_MASK))
-		end = (address & PGDIR_MASK) + PGDIR_SIZE;
-	error = 0;
+	pud = pud_offset(pgd, addr);
 	do {
-		error |= filemap_sync_pmd_range(pud, address, end, vma, flags);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-	return error;
+		next = pud_limit(addr, end);
+		if (pud_none(*pud))
+			continue;
+		if (pud_bad(*pud)) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+		sync_pmd_range(pud, addr, next, vma, flags);
+	} while (pud++, addr = next, addr < end);
 }
 
-static int __filemap_sync(struct vm_area_struct *vma, unsigned long address,
-			size_t size, unsigned int flags)
+static void sync_pgd_range(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long end, unsigned int flags)
 {
-	pgd_t *pgd;
-	unsigned long end = address + size;
+	struct mm_struct *mm = vma->vm_mm;
 	unsigned long next;
-	int i;
-	int error = 0;
-
-	/* Aquire the lock early; it may be possible to avoid dropping
-	 * and reaquiring it repeatedly.
-	 */
-	spin_lock(&vma->vm_mm->page_table_lock);
-
-	pgd = pgd_offset(vma->vm_mm, address);
-	flush_cache_range(vma, address, end);
+	pgd_t *pgd;
 
 	/* For hugepages we can't go walking the page table normally,
 	 * but that's ok, hugetlbfs is memory based, so we don't need
 	 * to do anything more on an msync() */
 	if (is_vm_hugetlb_page(vma))
-		goto out;
-
-	if (address >= end)
-		BUG();
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= address || next > end)
-			next = end;
-		error |= filemap_sync_pud_range(pgd, address, next, vma, flags);
-		address = next;
-		pgd++;
-	}
-	/*
-	 * Why flush ? filemap_sync_pte already flushed the tlbs with the
-	 * dirty bits.
-	 */
-	flush_tlb_range(vma, end - size, end);
- out:
-	spin_unlock(&vma->vm_mm->page_table_lock);
+		return;
 
-	return error;
+	pgd = pgd_offset(mm, addr);
+	flush_cache_range(vma, addr, end);
+	spin_lock(&mm->page_table_lock);
+	do {
+		next = pgd_limit(addr, end);
+		if (pgd_none(*pgd))
+			continue;
+		if (pgd_bad(*pgd)) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+		sync_pud_range(pgd, addr, next, vma, flags);
+	} while (pgd++, addr = next, addr < end);
+	spin_unlock(&mm->page_table_lock);
 }
 
 #ifdef CONFIG_PREEMPT
-static int filemap_sync(struct vm_area_struct *vma, unsigned long address,
-			size_t size, unsigned int flags)
+static void filemap_sync(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, unsigned int flags)
 {
 	const size_t chunk = 64 * 1024;	/* bytes */
-	int error = 0;
 
-	while (size) {
-		size_t sz = min(size, chunk);
+	while (start < end) {
+		size_t sz = min((size_t)(end-start), chunk);
 
-		error |= __filemap_sync(vma, address, sz, flags);
+		sync_pgd_range(vma, start, start+sz, flags);
+		start += sz;
 		cond_resched();
-		address += sz;
-		size -= sz;
 	}
-	return error;
 }
 #else
-static int filemap_sync(struct vm_area_struct *vma, unsigned long address,
-			size_t size, unsigned int flags)
+static void filemap_sync(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, unsigned int flags)
 {
-	return __filemap_sync(vma, address, size, flags);
+	sync_pgd_range(vma, start, end, flags);
 }
 #endif
 
@@ -209,9 +164,9 @@ static int msync_interval(struct vm_area
 		return -EBUSY;
 
 	if (file && (vma->vm_flags & VM_SHARED)) {
-		ret = filemap_sync(vma, start, end-start, flags);
+		filemap_sync(vma, start, end, flags);
 
-		if (!ret && (flags & MS_SYNC)) {
+		if (flags & MS_SYNC) {
 			struct address_space *mapping = file->f_mapping;
 			int err;
 
--- 2.6.11-rc4-bk9/mm/swapfile.c	2005-02-21 12:04:11.000000000 +0000
+++ linux/mm/swapfile.c	2005-02-22 20:00:26.000000000 +0000
@@ -427,162 +427,124 @@ void free_swap_and_cache(swp_entry_t ent
  * share this swap entry, so be cautious and let do_wp_page work out
  * what to do if a write is requested later.
  */
-/* vma->vm_mm->page_table_lock is held */
-static void
-unuse_pte(struct vm_area_struct *vma, unsigned long address, pte_t *dir,
-	swp_entry_t entry, struct page *page)
+static void unuse_pte(struct vm_area_struct *vma, pte_t *pte,
+		unsigned long addr, swp_entry_t entry, struct page *page)
 {
 	vma->vm_mm->rss++;
 	get_page(page);
-	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
-	page_add_anon_rmap(page, vma, address);
+	set_pte(pte, pte_mkold(mk_pte(page, vma->vm_page_prot)));
+	page_add_anon_rmap(page, vma, addr);
 	swap_free(entry);
 	acct_update_integrals();
 	update_mem_hiwater();
 }
 
-/* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pmd(struct vm_area_struct *vma, pmd_t *dir,
-	unsigned long address, unsigned long end,
-	swp_entry_t entry, struct page *page)
+static int unuse_pte_range(struct vm_area_struct *vma,
+		pmd_t *pmd, unsigned long addr, unsigned long end,
+		swp_entry_t entry, struct page *page)
 {
-	pte_t *pte;
 	pte_t swp_pte = swp_entry_to_pte(entry);
+	pte_t *pte;
 
-	if (pmd_none(*dir))
-		return 0;
-	if (pmd_bad(*dir)) {
-		pmd_ERROR(*dir);
-		pmd_clear(dir);
-		return 0;
-	}
-	pte = pte_offset_map(dir, address);
+	pte = pte_offset_map(pmd, addr);
 	do {
 		/*
 		 * swapoff spends a _lot_ of time in this loop!
 		 * Test inline before going to call unuse_pte.
 		 */
 		if (unlikely(pte_same(*pte, swp_pte))) {
-			unuse_pte(vma, address, pte, entry, page);
+			unuse_pte(vma, pte, addr, entry, page);
 			pte_unmap(pte);
-
-			/*
-			 * Move the page to the active list so it is not
-			 * immediately swapped out again after swapon.
-			 */
-			activate_page(page);
-
-			/* add 1 since address may be 0 */
-			return 1 + address;
+			return 1;
 		}
-		address += PAGE_SIZE;
-		pte++;
-	} while (address < end);
+	} while (pte++, addr += PAGE_SIZE, addr < end);
 	pte_unmap(pte - 1);
 	return 0;
 }
 
-/* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pud(struct vm_area_struct *vma, pud_t *pud,
-        unsigned long address, unsigned long end,
-	swp_entry_t entry, struct page *page)
+static inline int unuse_pmd_range(struct vm_area_struct *vma,
+		pud_t *pud, unsigned long addr, unsigned long end,
+		swp_entry_t entry, struct page *page)
 {
-	pmd_t *pmd;
 	unsigned long next;
-	unsigned long foundaddr;
+	pmd_t *pmd;
 
-	if (pud_none(*pud))
-		return 0;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return 0;
-	}
-	pmd = pmd_offset(pud, address);
+	pmd = pmd_offset(pud, addr);
 	do {
-		next = (address + PMD_SIZE) & PMD_MASK;
-		if (next > end || !next)
-			next = end;
-		foundaddr = unuse_pmd(vma, pmd, address, next, entry, page);
-		if (foundaddr)
-			return foundaddr;
-		address = next;
-		pmd++;
-	} while (address < end);
+		next = pmd_limit(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
+		if (unuse_pte_range(vma, pmd, addr, next, entry, page))
+			return 1;
+	} while (pmd++, addr = next, addr < end);
 	return 0;
 }
 
-/* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pgd(struct vm_area_struct *vma, pgd_t *pgd,
-	unsigned long address, unsigned long end,
-	swp_entry_t entry, struct page *page)
+static inline int unuse_pud_range(struct vm_area_struct *vma,
+		pgd_t *pgd, unsigned long addr, unsigned long end,
+		swp_entry_t entry, struct page *page)
 {
-	pud_t *pud;
 	unsigned long next;
-	unsigned long foundaddr;
+	pud_t *pud;
 
-	if (pgd_none(*pgd))
-		return 0;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return 0;
-	}
-	pud = pud_offset(pgd, address);
+	pud = pud_offset(pgd, addr);
 	do {
-		next = (address + PUD_SIZE) & PUD_MASK;
-		if (next > end || !next)
-			next = end;
-		foundaddr = unuse_pud(vma, pud, address, next, entry, page);
-		if (foundaddr)
-			return foundaddr;
-		address = next;
-		pud++;
-	} while (address < end);
+		next = pud_limit(addr, end);
+		if (pud_none(*pud))
+			continue;
+		if (pud_bad(*pud)) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+		if (unuse_pmd_range(vma, pud, addr, next, entry, page))
+			return 1;
+	} while (pud++, addr = next, addr < end);
 	return 0;
 }
 
-/* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_vma(struct vm_area_struct *vma,
-	swp_entry_t entry, struct page *page)
+static int unuse_vma(struct vm_area_struct *vma,
+		swp_entry_t entry, struct page *page)
 {
+	unsigned long addr, end, next;
 	pgd_t *pgd;
-	unsigned long address, next, end;
-	unsigned long foundaddr;
 
 	if (page->mapping) {
-		address = page_address_in_vma(page, vma);
-		if (address == -EFAULT)
+		addr = page_address_in_vma(page, vma);
+		if (addr == -EFAULT)
 			return 0;
 		else
-			end = address + PAGE_SIZE;
+			end = addr + PAGE_SIZE;
 	} else {
-		address = vma->vm_start;
+		addr = vma->vm_start;
 		end = vma->vm_end;
 	}
-	pgd = pgd_offset(vma->vm_mm, address);
+
+	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || !next)
-			next = end;
-		foundaddr = unuse_pgd(vma, pgd, address, next, entry, page);
-		if (foundaddr)
-			return foundaddr;
-		address = next;
-		pgd++;
-	} while (address < end);
+		next = pgd_limit(addr, end);
+		if (pgd_none(*pgd))
+			continue;
+		if (pgd_bad(*pgd)) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+		if (unuse_pud_range(vma, pgd, addr, next, entry, page))
+			return 1;
+	} while (pgd++, addr = next, addr < end);
 	return 0;
 }
 
-static int unuse_process(struct mm_struct * mm,
-			swp_entry_t entry, struct page* page)
+static int unuse_mm(struct mm_struct *mm, swp_entry_t entry, struct page *page)
 {
-	struct vm_area_struct* vma;
-	unsigned long foundaddr = 0;
+	struct vm_area_struct *vma;
 
-	/*
-	 * Go through process' page directory.
-	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		/*
 		 * Our reference to the page stops try_to_unmap_one from
@@ -594,16 +556,19 @@ static int unuse_process(struct mm_struc
 	}
 	spin_lock(&mm->page_table_lock);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (vma->anon_vma) {
-			foundaddr = unuse_vma(vma, entry, page);
-			if (foundaddr)
-				break;
+		if (vma->anon_vma && unuse_vma(vma, entry, page)) {
+			/*
+			 * Move the page to the active list so it is not
+			 * immediately swapped out again after swapon.
+			 */
+			activate_page(page);
+			break;
 		}
 	}
 	spin_unlock(&mm->page_table_lock);
 	up_read(&mm->mmap_sem);
 	/*
-	 * Currently unuse_process cannot fail, but leave error handling
+	 * Currently unuse_mm cannot fail, but leave error handling
 	 * at call sites for now, since we change it from time to time.
 	 */
 	return 0;
@@ -747,7 +712,7 @@ static int try_to_unuse(unsigned int typ
 			if (start_mm == &init_mm)
 				shmem = shmem_unuse(entry, page);
 			else
-				retval = unuse_process(start_mm, entry, page);
+				retval = unuse_mm(start_mm, entry, page);
 		}
 		if (*swap_map > 1) {
 			int set_start_mm = (*swap_map >= swcount);
@@ -779,7 +744,7 @@ static int try_to_unuse(unsigned int typ
 					set_start_mm = 1;
 					shmem = shmem_unuse(entry, page);
 				} else
-					retval = unuse_process(mm, entry, page);
+					retval = unuse_mm(mm, entry, page);
 				if (set_start_mm && *swap_map < swcount) {
 					mmput(new_start_mm);
 					atomic_inc(&mm->mm_users);
--- 2.6.11-rc4-bk9/mm/vmalloc.c	2005-02-21 12:04:11.000000000 +0000
+++ linux/mm/vmalloc.c	2005-02-22 23:17:29.000000000 +0000
@@ -23,104 +23,90 @@
 DEFINE_RWLOCK(vmlist_lock);
 struct vm_struct *vmlist;
 
-static void unmap_area_pte(pmd_t *pmd, unsigned long address,
-				  unsigned long size)
+static void unmap_area_pte(pmd_t *pmd, unsigned long addr, unsigned long end)
 {
-	unsigned long end;
 	pte_t *pte;
 
-	if (pmd_none(*pmd))
-		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-
-	pte = pte_offset_kernel(pmd, address);
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-
+	pte = pte_offset_kernel(pmd, addr);
 	do {
-		pte_t page;
-		page = ptep_get_and_clear(pte);
-		address += PAGE_SIZE;
-		pte++;
-		if (pte_none(page))
-			continue;
-		if (pte_present(page))
-			continue;
-		printk(KERN_CRIT "Whee.. Swapped out page in kernel page table\n");
-	} while (address < end);
+		pte_t entry = ptep_get_and_clear(pte);
+		if (unlikely(!pte_none(entry) && !pte_present(entry))) {
+			printk(KERN_CRIT "ERROR: swapped out kernel page\n");
+			dump_stack();
+		}
+	} while (pte++, addr += PAGE_SIZE, addr < end);
 }
 
-static void unmap_area_pmd(pud_t *pud, unsigned long address,
-				  unsigned long size)
+static inline void unmap_area_pmd(pud_t *pud,
+		unsigned long addr, unsigned long end)
 {
-	unsigned long end;
+	unsigned long next;
 	pmd_t *pmd;
 
-	if (pud_none(*pud))
-		return;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
-
-	pmd = pmd_offset(pud, address);
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-
+	pmd = pmd_offset(pud, addr);
 	do {
-		unmap_area_pte(pmd, address, end - address);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
+		next = pmd_limit(addr, end);
+		if (pmd_none(*pmd))
+			continue;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
+		unmap_area_pte(pmd, addr, next);
+	} while (pmd++, addr = next, addr < end);
 }
 
-static void unmap_area_pud(pgd_t *pgd, unsigned long address,
-			   unsigned long size)
+static inline void unmap_area_pud(pgd_t *pgd,
+		unsigned long addr, unsigned long end)
 {
+	unsigned long next;
 	pud_t *pud;
-	unsigned long end;
 
-	if (pgd_none(*pgd))
-		return;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_limit(addr, end);
+		if (pud_none(*pud))
+			continue;
+		if (pud_bad(*pud)) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+		unmap_area_pmd(pud, addr, next);
+	} while (pud++, addr = next, addr < end);
+}
 
-	pud = pud_offset(pgd, address);
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
+void unmap_vm_area(struct vm_struct *area)
+{
+	unsigned long addr = (unsigned long) area->addr;
+	unsigned long end = addr + area->size;
+	unsigned long next;
+	pgd_t *pgd;
 
+	BUG_ON(addr >= end);
+	pgd = pgd_offset_k(addr);
+	flush_cache_vunmap(addr, end);
 	do {
-		unmap_area_pmd(pud, address, end - address);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-}
-
-static int map_area_pte(pte_t *pte, unsigned long address,
-			       unsigned long size, pgprot_t prot,
-			       struct page ***pages)
-{
-	unsigned long end;
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+		next = pgd_limit(addr, end);
+		if (pgd_none(*pgd))
+			continue;
+		if (pgd_bad(*pgd)) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+		unmap_area_pud(pgd, addr, next);
+	} while (pgd++, addr = next, addr < end);
+	flush_tlb_kernel_range((unsigned long) area->addr, end);
+}
+
+static int map_area_pte(pmd_t *pmd, unsigned long addr,
+		unsigned long end, pgprot_t prot, struct page ***pages)
+{
+	pte_t *pte;
 
+	pte = pte_offset_kernel(pmd, addr);
 	do {
 		struct page *page = **pages;
 		WARN_ON(!pte_none(*pte));
@@ -128,108 +114,68 @@ static int map_area_pte(pte_t *pte, unsi
 			return -ENOMEM;
 
 		set_pte(pte, mk_pte(page, prot));
-		address += PAGE_SIZE;
-		pte++;
 		(*pages)++;
-	} while (address < end);
+	} while (pte++, addr += PAGE_SIZE, addr < end);
 	return 0;
 }
 
-static int map_area_pmd(pmd_t *pmd, unsigned long address,
-			       unsigned long size, pgprot_t prot,
-			       struct page ***pages)
-{
-	unsigned long base, end;
-
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
+static inline int map_area_pmd(pud_t *pud, unsigned long addr,
+	       unsigned long end, pgprot_t prot, struct page ***pages)
+{
+	unsigned long next;
+	pmd_t *pmd;
 
+	pmd = pmd_offset(pud, addr);
 	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, base + address);
-		if (!pte)
+		next = pmd_limit(addr, end);
+		if (!pte_alloc_kernel(&init_mm, pmd, addr))
 			return -ENOMEM;
-		if (map_area_pte(pte, address, end - address, prot, pages))
+		if (map_area_pte(pmd, addr, next, prot, pages))
 			return -ENOMEM;
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
-
+	} while (pmd++, addr = next, addr < end);
 	return 0;
 }
 
-static int map_area_pud(pud_t *pud, unsigned long address,
-			       unsigned long end, pgprot_t prot,
-			       struct page ***pages)
+static inline int map_area_pud(pgd_t *pgd, unsigned long addr,
+		unsigned long end, pgprot_t prot, struct page ***pages)
 {
+	unsigned long next;
+	pud_t *pud;
+
+	pud = pud_offset(pgd, addr);
 	do {
-		pmd_t *pmd = pmd_alloc(&init_mm, pud, address);
-		if (!pmd)
+		next = pud_limit(addr, end);
+		if (!pmd_alloc(&init_mm, pud, addr))
 			return -ENOMEM;
-		if (map_area_pmd(pmd, address, end - address, prot, pages))
+		if (map_area_pmd(pud, addr, next, prot, pages))
 			return -ENOMEM;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && address < end);
-
+	} while (pud++, addr = next, addr < end);
 	return 0;
 }
 
-void unmap_vm_area(struct vm_struct *area)
-{
-	unsigned long address = (unsigned long) area->addr;
-	unsigned long end = (address + area->size);
-	unsigned long next;
-	pgd_t *pgd;
-	int i;
-
-	pgd = pgd_offset_k(address);
-	flush_cache_vunmap(address, end);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= address || next > end)
-			next = end;
-		unmap_area_pud(pgd, address, next - address);
-		address = next;
-	        pgd++;
-	}
-	flush_tlb_kernel_range((unsigned long) area->addr, end);
-}
-
 int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page ***pages)
 {
-	unsigned long address = (unsigned long) area->addr;
-	unsigned long end = address + (area->size-PAGE_SIZE);
+	unsigned long addr = (unsigned long) area->addr;
+	unsigned long end = addr + area->size - PAGE_SIZE;
 	unsigned long next;
 	pgd_t *pgd;
-	int err = 0;
-	int i;
+	int error;
 
-	pgd = pgd_offset_k(address);
+	BUG_ON(addr >= end);
+	pgd = pgd_offset_k(addr);
 	spin_lock(&init_mm.page_table_lock);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(&init_mm, pgd, address);
-		if (!pud) {
-			err = -ENOMEM;
-			break;
-		}
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next < address || next > end)
-			next = end;
-		if (map_area_pud(pud, address, next, prot, pages)) {
-			err = -ENOMEM;
+	do {
+		next = pgd_limit(addr, end);
+		if (pud_alloc(&init_mm, pgd, addr))
+			error = map_area_pud(pgd, addr, next, prot, pages);
+		else
+			error = -ENOMEM;
+		if (error)
 			break;
-		}
-
-		address = next;
-		pgd++;
-	}
-
+	} while (pgd++, addr = next, addr < end);
 	spin_unlock(&init_mm.page_table_lock);
 	flush_cache_vmap((unsigned long) area->addr, end);
-	return err;
+	return error;
 }
 
 #define IOREMAP_MAX_ORDER	(7 + PAGE_SHIFT)	/* 128 pages */
