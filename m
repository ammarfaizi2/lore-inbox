Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVBQOHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVBQOHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVBQOHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:07:18 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:2691 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262146AbVBQODs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:03:48 -0500
Message-ID: <4214A437.8050900@yahoo.com.au>
Date: Fri, 18 Feb 2005 01:03:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au>
In-Reply-To: <4214A1EC.4070102@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030306070507050100030606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306070507050100030606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I am pretty surprised myself that I was able to consolidate
all "page table range" functions into a single type of iterator
(well, there are a couple of variations, but it's not too bad).

I thought at least the functions which allocate new page tables
would have to be seperate from those which don't.... it turns
out that if you slightly change the implementation of the
allocating functions, they start walking, quacking, etc. like
the other type.

This may also opens the way for things like:

#define for_each_pud(pgd, start, end, pud, pud_start, pud_end) \
if (pud = (pud_t *)pgd, pud_start = start, pud_end = end, 1)

for 2 and 3 level page tables (don't laugh if I've messed up the
above completely - you get the idea).

Then the last bit of the performance puzzle I think will just come
from inlining things. Now Andi doesn't want to do that (probably
rightly so)... what about compiling mm/ with -funit-at-a-time? It
doesn't do much harm to the stack, and it shaves off quite a few
KB...

Anyway, this iterator patch shaves off a bit itself. I haven't
looked at generated code, but I hope it is alright.

npiggin@didi:~/usr/src/linux-2.6$ size mm/memory.o.before
    text    data     bss     dec     hex filename
   11349       4     120   11473    2cd1 mm/memory.o
npiggin@didi:~/usr/src/linux-2.6$ size mm/memory.o.after
    text    data     bss     dec     hex filename
   11221       4     120   11345    2c51 mm/memory.o

Suggestions, help, etc. welcome.

Nick

--------------030306070507050100030606
Content-Type: text/plain;
 name="vm-pgt-walkers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-pgt-walkers.patch"




---

 drivers/char/mem.c                              |    0 
 linux-2.6-npiggin/arch/i386/mm/ioremap.c        |   78 +--
 linux-2.6-npiggin/include/asm-generic/pgtable.h |  128 +++++
 linux-2.6-npiggin/mm/memory.c                   |  591 ++++++++++--------------
 linux-2.6-npiggin/mm/mprotect.c                 |  118 +---
 linux-2.6-npiggin/mm/msync.c                    |  159 ++----
 linux-2.6-npiggin/mm/vmalloc.c                  |  222 +++------
 7 files changed, 600 insertions(+), 696 deletions(-)

diff -puN include/asm-generic/pgtable.h~vm-pgt-walkers include/asm-generic/pgtable.h
--- linux-2.6/include/asm-generic/pgtable.h~vm-pgt-walkers	2005-02-17 23:59:16.000000000 +1100
+++ linux-2.6-npiggin/include/asm-generic/pgtable.h	2005-02-18 00:50:19.000000000 +1100
@@ -134,4 +134,132 @@ static inline void ptep_mkdirty(pte_t *p
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
 
+/*
+ * for_each_pgd - iterates through pgd entries in a given mm structa
+ *
+ * @mm: the mm to use
+ * @start: the first address, inclusive
+ * @end: the last address, exclusive
+ * @pgd: the pgd iterator
+ * @pgd_start: the first address within the current 'pgd'
+ * @pgd_end: the last address within the current 'pgd'
+ *
+ * mm, start, end are all unchanged
+ * pgd, pgd_start, pgd_end may all be changed
+ */
+#define for_each_pgd(mm, start, end, pgd, pgd_start, pgd_end)		\
+	for (	pgd = pgd_offset(mm, start),				\
+		  pgd_start = start;					\
+		pgd_end = (pgd_start + PGDIR_SIZE) & PGDIR_MASK,	\
+		  pgd_end = ((pgd_end && pgd_end <= end) ? pgd_end : end), \
+		  pgd <= pgd_offset(mm, end-1);				\
+		pgd_start = pgd_end,					\
+		  pgd++ )
+
+/*
+ * for_each_pgd_k - iterates through pgd entries in the kernel mapping
+ *
+ * see for_each_pgd
+ */
+#define for_each_pgd_k(start, end, pgd, pgd_start, pgd_end)		\
+	for (	pgd = pgd_offset_k(start),				\
+		  pgd_start = start;					\
+		pgd_end = (pgd_start + PGDIR_SIZE) & PGDIR_MASK,	\
+		  pgd_end = ((pgd_end && pgd_end <= end) ? pgd_end : end), \
+		  pgd <= pgd_offset_k(end-1);				\
+		pgd_start = pgd_end,					\
+		  pgd++ )
+
+/*
+ * for_each_pud - iterate through pud entries in a given pgd
+ *
+ * see for_each_pgd
+ */
+#define for_each_pud(pgd, start, end, pud, pud_start, pud_end)		\
+	for (	pud = pud_offset(pgd, start),				\
+		  pud_start = start;					\
+		pud_end = (pud_start + PUD_SIZE) & PUD_MASK,		\
+		  pud_end = ((pud_end && pud_end <= end) ? pud_end : end), \
+		  pud <= pud_offset(pgd, end-1);			\
+		pud_start = pud_end,					\
+		  pud++ )
+
+/*
+ * for_each_pmd - iterate through pmd entries in a given pud
+ *
+ * see for_each_pgd
+ */
+#define for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end)		\
+	for (	pmd = pmd_offset(pud, start),				\
+		  pmd_start = start;					\
+		pmd_end = (pmd_start + PMD_SIZE) & PMD_MASK,		\
+		  pmd_end = ((pmd_end && pmd_end <= end) ? pmd_end : end), \
+		  pmd <= pmd_offset(pud, end-1);			\
+		pmd_start = pmd_end,					\
+		  pmd++ )
+
+/*
+ * for_each_pte_map - iterate through pte entries in a given pmd
+ *
+ * @pmd: the pmd to use
+ * @start: the first address, inclusive
+ * @end: the last address, exclusive
+ * @pte: the pte iterator
+ * @addr: the address of the current 'pte'
+ *
+ * for_each_pte_map maps the ptes which it iterates over.
+ *
+ * Usage:
+ * for_each_pte_map(pmd, start, end, pte, addr) {
+ * 	// do something with pte and/or addr
+ * } for_each_pte_map_end;
+ */
+#define for_each_pte_map(pmd, start, end, pte, addr) 			\
+do {									\
+	int ___i = (end - start) >> PAGE_SHIFT;				\
+	pte_t *___p = pte_offset_map(pmd, start);			\
+	pte = ___p;							\
+	for (	addr = start;						\
+		___i--;							\
+		addr += PAGE_SIZE, pte++)
+
+#define for_each_pte_map_end			 			\
+	pte_unmap(___p);						\
+} while (0)
+
+/*
+ * for_each_pte_map_nested
+ *
+ * See for_each_pte_map. Does a nested mapping of the pte.
+ */
+#define for_each_pte_map_nested(pmd, start, end, pte, addr) 		\
+do {									\
+	int ___i = (end - start) >> PAGE_SHIFT;				\
+	pte_t *___p = pte_offset_map_nested(pmd, start);		\
+	pte = ___p;							\
+	for (	addr = start;						\
+		___i--;							\
+		addr += PAGE_SIZE, pte++)
+
+#define for_each_pte_map_nested_end		 			\
+	pte_unmap_nested(___p);						\
+} while (0)
+
+/*
+ * for_each_pte_kernel
+ *
+ * See for_each_pte_map. Iterates over kernel ptes.
+ */
+#define for_each_pte_kernel(pmd, start, end, pte, addr) 		\
+do {									\
+	int ___i = (end - start) >> PAGE_SHIFT;				\
+	pte_t *___p = pte_offset_kernel(pmd, start);			\
+	pte = ___p;							\
+	for (	addr = start;						\
+		___i--;							\
+		addr += PAGE_SIZE, pte++)
+
+#define for_each_pte_kernel_end			 			\
+} while (0)
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
diff -puN mm/memory.c~vm-pgt-walkers mm/memory.c
--- linux-2.6/mm/memory.c~vm-pgt-walkers	2005-02-17 23:59:16.000000000 +1100
+++ linux-2.6-npiggin/mm/memory.c	2005-02-18 00:27:52.000000000 +1100
@@ -89,18 +89,9 @@ EXPORT_SYMBOL(vmalloc_earlyreserve);
  */
 static inline void clear_pmd_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long start, unsigned long end)
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
 	if (!((start | end) & ~PMD_MASK)) {
 		/* Only clear full, aligned ranges */
-		page = pmd_page(*pmd);
+		struct page *page = pmd_page(*pmd);
 		pmd_clear(pmd);
 		dec_page_state(nr_page_table_pages);
 		tlb->mm->nr_ptes--;
@@ -110,64 +101,50 @@ static inline void clear_pmd_range(struc
 
 static inline void clear_pud_range(struct mmu_gather *tlb, pud_t *pud, unsigned long start, unsigned long end)
 {
-	unsigned long addr = start, next;
-	pmd_t *pmd, *__pmd;
+	unsigned long pmd_start, pmd_end;
+	pmd_t *pmd;
 
-	if (pud_none(*pud))
-		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		if (pmd_none(*pmd))
+			continue;
+		if (unlikely(pmd_bad(*pmd))) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
 
-	pmd = __pmd = pmd_offset(pud, start);
-	do {
-		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		
-		clear_pmd_range(tlb, pmd, addr, next);
-		pmd++;
-		addr = next;
-	} while (addr && (addr < end));
+		clear_pmd_range(tlb, pmd, pmd_start, pmd_end);
+	}
 
 	if (!((start | end) & ~PUD_MASK)) {
 		/* Only clear full, aligned ranges */
 		pud_clear(pud);
-		pmd_free_tlb(tlb, __pmd);
+		pmd_free_tlb(tlb, pmd_offset(pud, start));
 	}
 }
 
 
 static inline void clear_pgd_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long start, unsigned long end)
 {
-	unsigned long addr = start, next;
-	pud_t *pud, *__pud;
+	unsigned long pud_start, pud_end;
+	pud_t *pud;
 
-	if (pgd_none(*pgd))
-		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
+	for_each_pud(pgd, start, end, pud, pud_start, pud_end) {
+		if (pud_none(*pud))
+			continue;
+		if (unlikely(pud_bad(*pud))) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
 
-	pud = __pud = pud_offset(pgd, start);
-	do {
-		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end || next <= addr)
-			next = end;
-		
-		clear_pud_range(tlb, pud, addr, next);
-		pud++;
-		addr = next;
-	} while (addr && (addr < end));
+		clear_pud_range(tlb, pud, pud_start, pud_end);
+	}
 
 	if (!((start | end) & ~PGDIR_MASK)) {
 		/* Only clear full, aligned ranges */
 		pgd_clear(pgd);
-		pud_free_tlb(tlb, __pud);
+		pud_free_tlb(tlb, pud_offset(pgd, start));
 	}
 }
 
@@ -178,45 +155,54 @@ static inline void clear_pgd_range(struc
  */
 void clear_page_range(struct mmu_gather *tlb, unsigned long start, unsigned long end)
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
-		clear_pgd_range(tlb, pgd, addr, next);
-		pgd++;
-		addr = next;
+	unsigned long pgd_start, pgd_end;
+	pgd_t * pgd;
+
+	for_each_pgd(tlb->mm, start, end, pgd, pgd_start, pgd_end) {
+		if (pgd_none(*pgd))
+			continue;
+		if (unlikely(pgd_bad(*pgd))) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+
+		clear_pgd_range(tlb, pgd, pgd_start, pgd_end);
 	}
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
@@ -322,90 +308,91 @@ copy_one_pte(struct mm_struct *dst_mm,  
 
 static int copy_pte_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
 		pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long start, unsigned long end)
 {
+	unsigned long address;
 	pte_t *src_pte, *dst_pte;
-	pte_t *s, *d;
+	pte_t *d;
 	unsigned long vm_flags = vma->vm_flags;
 
-	d = dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
+	d = dst_pte = pte_alloc_map(dst_mm, dst_pmd, start);
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
+	for_each_pte_map_nested(src_pmd, start, end, src_pte, address) {
+		if (pte_none(*src_pte))
+			goto next_pte;
+		copy_one_pte(dst_mm, src_mm, d, src_pte, vm_flags, address);
+
+next_pte:
+		d++;
+	} for_each_pte_map_nested_end;
 	spin_unlock(&src_mm->page_table_lock);
+
+	pte_unmap(dst_pte);
 	cond_resched_lock(&dst_mm->page_table_lock);
 	return 0;
 }
 
 static int copy_pmd_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long start, unsigned long end)
 {
+	unsigned long pmd_start, pmd_end;
 	pmd_t *src_pmd, *dst_pmd;
 	int err = 0;
-	unsigned long next;
 
-	src_pmd = pmd_offset(src_pud, addr);
-	dst_pmd = pmd_alloc(dst_mm, dst_pud, addr);
+	dst_pmd = pmd_alloc(dst_mm, dst_pud, start);
 	if (!dst_pmd)
 		return -ENOMEM;
 
-	for (; addr < end; addr = next, src_pmd++, dst_pmd++) {
-		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end)
-			next = end;
+	for_each_pmd(src_pud, start, end, src_pmd, pmd_start, pmd_end) {
 		if (pmd_none(*src_pmd))
-			continue;
+			goto next_pmd;
 		if (pmd_bad(*src_pmd)) {
 			pmd_ERROR(*src_pmd);
 			pmd_clear(src_pmd);
-			continue;
+			goto next_pmd;
 		}
-		err = copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-							vma, addr, next);
-		if (err)
+		err = copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd, vma,
+						pmd_start, pmd_end);
+		if (unlikely(err))
 			break;
+
+next_pmd:
+		dst_pmd++;
 	}
 	return err;
 }
 
 static int copy_pud_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
 		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long start, unsigned long end)
 {
+	unsigned long pud_start, pud_end;
 	pud_t *src_pud, *dst_pud;
 	int err = 0;
-	unsigned long next;
 
-	src_pud = pud_offset(src_pgd, addr);
-	dst_pud = pud_alloc(dst_mm, dst_pgd, addr);
+	dst_pud = pud_alloc(dst_mm, dst_pgd, start);
 	if (!dst_pud)
 		return -ENOMEM;
 
-	for (; addr < end; addr = next, src_pud++, dst_pud++) {
-		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end)
-			next = end;
+	for_each_pud(src_pgd, start, end, src_pud, pud_start, pud_end) {
 		if (pud_none(*src_pud))
-			continue;
+			goto next_pud;
 		if (pud_bad(*src_pud)) {
 			pud_ERROR(*src_pud);
 			pud_clear(src_pud);
-			continue;
+			goto next_pud;
 		}
-		err = copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-							vma, addr, next);
-		if (err)
+		err = copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud, vma,
+						pud_start, pud_end);
+		if (unlikely(err))
 			break;
+
+next_pud:
+		dst_pud++;
 	}
 	return err;
 }
@@ -413,23 +400,19 @@ static int copy_pud_range(struct mm_stru
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 		struct vm_area_struct *vma)
 {
+	unsigned long pgd_start, pgd_end;
+	unsigned long start, end;
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long addr, start, end, next;
 	int err = 0;
 
 	if (is_vm_hugetlb_page(vma))
 		return copy_hugetlb_page_range(dst, src, vma);
 
 	start = vma->vm_start;
-	src_pgd = pgd_offset(src, start);
+	end = vma->vm_end;
 	dst_pgd = pgd_offset(dst, start);
 
-	end = vma->vm_end;
-	addr = start;
-	while (addr && (addr < end-1)) {
-		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= addr)
-			next = end;
+	for_each_pgd(src, start, end, src_pgd, pgd_start, pgd_end) {
 		if (pgd_none(*src_pgd))
 			goto next_pgd;
 		if (pgd_bad(*src_pgd)) {
@@ -437,42 +420,27 @@ int copy_page_range(struct mm_struct *ds
 			pgd_clear(src_pgd);
 			goto next_pgd;
 		}
-		err = copy_pud_range(dst, src, dst_pgd, src_pgd,
-							vma, addr, next);
-		if (err)
+
+		err = copy_pud_range(dst, src, dst_pgd, src_pgd, vma,
+						pgd_start, pgd_end);
+		if (unlikely(err))
 			break;
 
 next_pgd:
-		src_pgd++;
 		dst_pgd++;
-		addr = next;
 	}
 
 	return err;
 }
 
 static void zap_pte_range(struct mmu_gather *tlb,
-		pmd_t *pmd, unsigned long address,
-		unsigned long size, struct zap_details *details)
+		pmd_t *pmd, unsigned long start,
+		unsigned long end, struct zap_details *details)
 {
-	unsigned long offset;
+	unsigned long address;
 	pte_t *ptep;
 
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
+	for_each_pte_map(pmd, start, end, ptep, address) {
 		pte_t pte = *ptep;
 		if (pte_none(pte))
 			continue;
@@ -503,12 +471,12 @@ static void zap_pte_range(struct mmu_gat
 					continue;
 			}
 			pte = ptep_get_and_clear(ptep);
-			tlb_remove_tlb_entry(tlb, ptep, address+offset);
+			tlb_remove_tlb_entry(tlb, ptep, address);
 			if (unlikely(!page))
 				continue;
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
-					address+offset) != page->index)
+					address) != page->index)
 				set_pte(ptep, pgoff_to_pte(page->index));
 			if (pte_dirty(pte))
 				set_page_dirty(page);
@@ -530,74 +498,71 @@ static void zap_pte_range(struct mmu_gat
 		if (!pte_file(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
 		pte_clear(ptep);
-	}
-	pte_unmap(ptep-1);
+	} for_each_pte_map_end;
 }
 
 static void zap_pmd_range(struct mmu_gather *tlb,
-		pud_t *pud, unsigned long address,
-		unsigned long size, struct zap_details *details)
+		pud_t *pud, unsigned long start,
+		unsigned long end, struct zap_details *details)
 {
+	unsigned long pmd_start, pmd_end;
 	pmd_t * pmd;
-	unsigned long end;
 
-	if (pud_none(*pud))
-		return;
-	if (unlikely(pud_bad(*pud))) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		if (pmd_none(*pmd))
+			continue;
+		if (unlikely(pmd_bad(*pmd))) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
+
+		zap_pte_range(tlb, pmd, pmd_start, pmd_end, details);
 	}
-	pmd = pmd_offset(pud, address);
-	end = address + size;
-	if (end > ((address + PUD_SIZE) & PUD_MASK))
-		end = ((address + PUD_SIZE) & PUD_MASK);
-	do {
-		zap_pte_range(tlb, pmd, address, end - address, details);
-		address = (address + PMD_SIZE) & PMD_MASK; 
-		pmd++;
-	} while (address && (address < end));
 }
 
 static void zap_pud_range(struct mmu_gather *tlb,
-		pgd_t * pgd, unsigned long address,
+		pgd_t * pgd, unsigned long start,
 		unsigned long end, struct zap_details *details)
 {
+	unsigned long pud_start, pud_end;
 	pud_t * pud;
 
-	if (pgd_none(*pgd))
-		return;
-	if (unlikely(pgd_bad(*pgd))) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
+	for_each_pud(pgd, start, end, pud, pud_start, pud_end) {
+		if (pud_none(*pud))
+			continue;
+		if (unlikely(pud_bad(*pud))) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+
+		zap_pmd_range(tlb, pud, pud_start, pud_end, details);
 	}
-	pud = pud_offset(pgd, address);
-	do {
-		zap_pmd_range(tlb, pud, address, end - address, details);
-		address = (address + PUD_SIZE) & PUD_MASK; 
-		pud++;
-	} while (address && (address < end));
 }
 
 static void unmap_page_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long address,
+		struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, struct zap_details *details)
 {
-	unsigned long next;
+	unsigned long pgd_start, pgd_end;
 	pgd_t *pgd;
-	int i;
 
-	BUG_ON(address >= end);
-	pgd = pgd_offset(vma->vm_mm, address);
+	BUG_ON(start >= end);
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
+	for_each_pgd(vma->vm_mm, start, end, pgd, pgd_start, pgd_end) {
+		if (pgd_none(*pgd))
+			continue;
+		if (unlikely(pgd_bad(*pgd))) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+
+		zap_pud_range(tlb, pgd, pgd_start, pgd_end, details);
 	}
 	tlb_end_vma(tlb, vma);
 }
@@ -987,108 +952,78 @@ out:
 
 EXPORT_SYMBOL(get_user_pages);
 
-static void zeromap_pte_range(pte_t * pte, unsigned long address,
-                                     unsigned long size, pgprot_t prot)
+static void zeromap_pte_range(pmd_t * pmd, unsigned long start,
+                                     unsigned long end, pgprot_t prot)
 {
-	unsigned long end;
+	unsigned long addr;
+	pte_t *pte;
 
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	do {
-		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(address), prot));
+	for_each_pte_map(pmd, start, end, pte, addr) {
+		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(addr), prot));
 		BUG_ON(!pte_none(*pte));
 		set_pte(pte, zero_pte);
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
+	} for_each_pte_map_end;
 }
 
-static inline int zeromap_pmd_range(struct mm_struct *mm, pmd_t * pmd,
-		unsigned long address, unsigned long size, pgprot_t prot)
+static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t * pud,
+			unsigned long start, unsigned long end, pgprot_t prot)
 {
-	unsigned long base, end;
+	unsigned long pmd_start, pmd_end;
+	pmd_t * pmd;
 
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
-		if (!pte)
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		if (!pte_alloc(mm, pmd, pmd_start))
 			return -ENOMEM;
-		zeromap_pte_range(pte, base + address, end - address, prot);
-		pte_unmap(pte);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+		zeromap_pte_range(pmd, start, end, prot);
+	}
 	return 0;
 }
 
-static inline int zeromap_pud_range(struct mm_struct *mm, pud_t * pud,
-				    unsigned long address,
-                                    unsigned long size, pgprot_t prot)
+static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t * pgd,
+					unsigned long start, unsigned long end,
+					pgprot_t prot)
 {
-	unsigned long base, end;
+	unsigned long pud_start, pud_end;
+	pud_t * pud;
 	int error = 0;
 
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	do {
-		pmd_t * pmd = pmd_alloc(mm, pud, base + address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		error = zeromap_pmd_range(mm, pmd, address, end - address, prot);
+	for_each_pud(pgd, start, end, pud, pud_start, pud_end) {
+		if (unlikely(!pmd_alloc(mm, pud, pud_start)))
+			return -ENOMEM;
+		error = zeromap_pmd_range(mm, pud, pud_start, pud_end, prot);
 		if (error)
 			break;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-	return 0;
+	}
+	return error;
 }
-
-int zeromap_page_range(struct vm_area_struct *vma, unsigned long address,
+int zeromap_page_range(struct vm_area_struct *vma, unsigned long start,
 					unsigned long size, pgprot_t prot)
 {
-	int i;
-	int error = 0;
-	pgd_t * pgd;
-	unsigned long beg = address;
-	unsigned long end = address + size;
-	unsigned long next;
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long end = start + size;
+	unsigned long pgd_start, pgd_end;
+	pgd_t * pgd;
+	int error = 0;
 
-	pgd = pgd_offset(mm, address);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(address >= end);
+	BUG_ON(start >= end);
 	BUG_ON(end > vma->vm_end);
 
+	pgd = pgd_offset(mm, start);
+	flush_cache_range(vma, start, end);
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(mm, pgd, address);
-		error = -ENOMEM;
-		if (!pud)
+	for_each_pgd(mm, start, end, pgd, pgd_start, pgd_end) {
+		if (unlikely(!pud_alloc(mm, pgd, pgd_start))) {
+			error = -ENOMEM;
 			break;
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= beg || next > end)
-			next = end;
-		error = zeromap_pud_range(mm, pud, address,
-						next - address, prot);
+		}
+		error = zeromap_pud_range(mm, pgd, pgd_start, pgd_end, prot);
 		if (error)
 			break;
-		address = next;
-		pgd++;
 	}
 	/*
 	 * Why flush? zeromap_pte_range has a BUG_ON for !pte_none()
 	 */
-	flush_tlb_range(vma, beg, end);
+	flush_tlb_range(vma, start, end);
 	spin_unlock(&mm->page_table_lock);
 	return error;
 }
@@ -1099,94 +1034,71 @@ int zeromap_page_range(struct vm_area_st
  * in null mappings (currently treated as "copy-on-access")
  */
 static inline void
-remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
+remap_pte_range(pmd_t * pmd, unsigned long start, unsigned long end,
 		unsigned long pfn, pgprot_t prot)
 {
-	unsigned long end;
+	unsigned long address;
+	pte_t * pte;
 
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	do {
+	for_each_pte_map(pmd, start, end, pte, address) {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
  			set_pte(pte, pfn_pte(pfn, prot));
-		address += PAGE_SIZE;
 		pfn++;
-		pte++;
-	} while (address && (address < end));
+	} for_each_pte_map_end;
 }
 
 static inline int
-remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address,
-		unsigned long size, unsigned long pfn, pgprot_t prot)
+remap_pmd_range(struct mm_struct *mm, pud_t * pud, unsigned long start,
+		unsigned long end, unsigned long pfn, pgprot_t prot)
 {
-	unsigned long base, end;
+	unsigned long pmd_start, pmd_end;
+	pmd_t * pmd;
 
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-	pfn -= (address >> PAGE_SHIFT);
-	do {
-		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
-		if (!pte)
+	pfn -= start >> PAGE_SHIFT;
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		if (!pte_alloc(mm, pmd, pmd_start))
 			return -ENOMEM;
-		remap_pte_range(pte, base + address, end - address,
-				(address >> PAGE_SHIFT) + pfn, prot);
-		pte_unmap(pte);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+		remap_pte_range(pmd, pmd_start, pmd_end,
+				(pmd_start >> PAGE_SHIFT) + pfn, prot);
+	}
 	return 0;
 }
 
-static inline int remap_pud_range(struct mm_struct *mm, pud_t * pud,
-				  unsigned long address, unsigned long size,
-				  unsigned long pfn, pgprot_t prot)
-{
-	unsigned long base, end;
-	int error;
-
-	base = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	pfn -= address >> PAGE_SHIFT;
-	do {
-		pmd_t *pmd = pmd_alloc(mm, pud, base+address);
-		error = -ENOMEM;
-		if (!pmd)
-			break;
-		error = remap_pmd_range(mm, pmd, base + address, end - address,
-				(address >> PAGE_SHIFT) + pfn, prot);
+static inline int remap_pud_range(struct mm_struct *mm, pgd_t * pgd,
+				unsigned long start, unsigned long end,
+				unsigned long pfn, pgprot_t prot)
+{
+	unsigned long pud_start, pud_end;
+	pud_t * pud;
+	int error = 0;
+
+	pfn -= start >> PAGE_SHIFT;
+	for_each_pud(pgd, start, end, pud, pud_start, pud_end) {
+		if (!pmd_alloc(mm, pud, pud_start))
+			return -ENOMEM;
+		error = remap_pmd_range(mm, pud, pud_start, pud_end,
+				(pud_start >> PAGE_SHIFT) + pfn, prot);
 		if (error)
 			break;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
+	}
 	return error;
 }
 
 /*  Note: this is only safe if the mm semaphore is held when called. */
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long from,
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long start,
 		    unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	int error = 0;
-	pgd_t *pgd;
-	unsigned long beg = from;
-	unsigned long end = from + size;
-	unsigned long next;
 	struct mm_struct *mm = vma->vm_mm;
-	int i;
+	unsigned long pgd_start, pgd_end;
+	unsigned long end = start + size;
+	pgd_t *pgd;
+	int error = 0;
 
-	pfn -= from >> PAGE_SHIFT;
-	pgd = pgd_offset(mm, from);
-	flush_cache_range(vma, beg, end);
-	BUG_ON(from >= end);
+	BUG_ON(start >= end);
+
+	pfn -= start >> PAGE_SHIFT;
+	flush_cache_range(vma, start, end);
 
 	/*
 	 * Physically remapped pages are special. Tell the
@@ -1199,25 +1111,20 @@ int remap_pfn_range(struct vm_area_struc
 	vma->vm_flags |= VM_IO | VM_RESERVED;
 
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(beg); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(mm, pgd, from);
-		error = -ENOMEM;
-		if (!pud)
+	for_each_pgd(mm, start, end, pgd, pgd_start, pgd_end) {
+		if (!pud_alloc(mm, pgd, pgd_start)) {
+			error = -ENOMEM;
 			break;
-		next = (from + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= from)
-			next = end;
-		error = remap_pud_range(mm, pud, from, end - from,
-					pfn + (from >> PAGE_SHIFT), prot);
+		}
+		error = remap_pud_range(mm, pgd, pgd_start, pgd_end,
+					pfn + (pgd_start >> PAGE_SHIFT), prot);
 		if (error)
 			break;
-		from = next;
-		pgd++;
 	}
 	/*
 	 * Why flush? remap_pte_range has a BUG_ON for !pte_none()
 	 */
-	flush_tlb_range(vma, beg, end);
+	flush_tlb_range(vma, start, end);
 	spin_unlock(&mm->page_table_lock);
 
 	return error;
diff -puN mm/msync.c~vm-pgt-walkers mm/msync.c
--- linux-2.6/mm/msync.c~vm-pgt-walkers	2005-02-17 23:59:16.000000000 +1100
+++ linux-2.6-npiggin/mm/msync.c	2005-02-17 23:59:16.000000000 +1100
@@ -21,7 +21,7 @@
  * Called with mm->page_table_lock held to protect against other
  * threads/the swapper from ripping pte's out from under us.
  */
-static int filemap_sync_pte(pte_t *ptep, struct vm_area_struct *vma,
+static void filemap_sync_pte(pte_t *ptep, struct vm_area_struct *vma,
 	unsigned long address, unsigned int flags)
 {
 	pte_t pte = *ptep;
@@ -35,106 +35,74 @@ static int filemap_sync_pte(pte_t *ptep,
 		     page_test_and_clear_dirty(page)))
 			set_page_dirty(page);
 	}
-	return 0;
 }
 
-static int filemap_sync_pte_range(pmd_t * pmd,
-	unsigned long address, unsigned long end, 
+static void filemap_sync_pte_range(pmd_t * pmd,
+	unsigned long start, unsigned long end, 
 	struct vm_area_struct *vma, unsigned int flags)
 {
+	unsigned long address;
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
-	do {
-		error |= filemap_sync_pte(pte, vma, address, flags);
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
-
-	pte_unmap(pte - 1);
-
-	return error;
+	for_each_pte_map(pmd, start, end, pte, address) {
+		filemap_sync_pte(pte, vma, address, flags);
+	} for_each_pte_map_end;
 }
 
-static inline int filemap_sync_pmd_range(pud_t * pud,
-	unsigned long address, unsigned long end, 
+static void filemap_sync_pmd_range(pud_t * pud,
+	unsigned long start, unsigned long end, 
 	struct vm_area_struct *vma, unsigned int flags)
 {
+	unsigned long pmd_start, pmd_end;
 	pmd_t * pmd;
-	int error;
 
-	if (pud_none(*pud))
-		return 0;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return 0;
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		if (pmd_none(*pmd))
+			continue;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
+
+		filemap_sync_pte_range(pmd, pmd_start, pmd_end, vma, flags);
 	}
-	pmd = pmd_offset(pud, address);
-	if ((address & PUD_MASK) != (end & PUD_MASK))
-		end = (address & PUD_MASK) + PUD_SIZE;
-	error = 0;
-	do {
-		error |= filemap_sync_pte_range(pmd, address, end, vma, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
-	return error;
 }
 
-static inline int filemap_sync_pud_range(pgd_t *pgd,
-	unsigned long address, unsigned long end,
+static void filemap_sync_pud_range(pgd_t *pgd,
+	unsigned long start, unsigned long end,
 	struct vm_area_struct *vma, unsigned int flags)
 {
+	unsigned long pud_start, pud_end;
 	pud_t *pud;
-	int error;
 
-	if (pgd_none(*pgd))
-		return 0;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return 0;
+	for_each_pud(pgd, start, end, pud, pud_start, pud_end) {
+		if (pud_none(*pud))
+			continue;
+		if (pud_bad(*pud)) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+
+		filemap_sync_pmd_range(pud, pud_start, pud_end, vma, flags);
 	}
-	pud = pud_offset(pgd, address);
-	if ((address & PGDIR_MASK) != (end & PGDIR_MASK))
-		end = (address & PGDIR_MASK) + PGDIR_SIZE;
-	error = 0;
-	do {
-		error |= filemap_sync_pmd_range(pud, address, end, vma, flags);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
-	return error;
 }
 
-static int __filemap_sync(struct vm_area_struct *vma, unsigned long address,
-			size_t size, unsigned int flags)
+static void __filemap_sync(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, unsigned int flags)
 {
+	unsigned long pgd_start, pgd_end;
 	pgd_t *pgd;
-	unsigned long end = address + size;
-	unsigned long next;
-	int i;
-	int error = 0;
+
+	BUG_ON(start >= end);
 
 	/* Aquire the lock early; it may be possible to avoid dropping
 	 * and reaquiring it repeatedly.
 	 */
 	spin_lock(&vma->vm_mm->page_table_lock);
 
-	pgd = pgd_offset(vma->vm_mm, address);
-	flush_cache_range(vma, address, end);
+	flush_cache_range(vma, start, end);
 
 	/* For hugepages we can't go walking the page table normally,
 	 * but that's ok, hugetlbfs is memory based, so we don't need
@@ -142,49 +110,46 @@ static int __filemap_sync(struct vm_area
 	if (is_vm_hugetlb_page(vma))
 		goto out;
 
-	if (address >= end)
-		BUG();
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= address || next > end)
-			next = end;
-		error |= filemap_sync_pud_range(pgd, address, next, vma, flags);
-		address = next;
-		pgd++;
+	for_each_pgd(vma->vm_mm, start, end, pgd, pgd_start, pgd_end) {
+		if (pgd_none(*pgd))
+			continue;
+		if (pgd_bad(*pgd)) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+
+		filemap_sync_pud_range(pgd, pgd_start, pgd_end, vma, flags);
 	}
+
 	/*
 	 * Why flush ? filemap_sync_pte already flushed the tlbs with the
 	 * dirty bits.
 	 */
-	flush_tlb_range(vma, end - size, end);
+	flush_tlb_range(vma, start, end);
  out:
 	spin_unlock(&vma->vm_mm->page_table_lock);
-
-	return error;
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
+		__filemap_sync(vma, start, start+sz, flags);
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
+	__filemap_sync(vma, start, end, flags);
 }
 #endif
 
@@ -209,9 +174,9 @@ static int msync_interval(struct vm_area
 		return -EBUSY;
 
 	if (file && (vma->vm_flags & VM_SHARED)) {
-		ret = filemap_sync(vma, start, end-start, flags);
+		filemap_sync(vma, start, end, flags);
 
-		if (!ret && (flags & MS_SYNC)) {
+		if (flags & MS_SYNC) {
 			struct address_space *mapping = file->f_mapping;
 			int err;
 
diff -puN mm/mprotect.c~vm-pgt-walkers mm/mprotect.c
--- linux-2.6/mm/mprotect.c~vm-pgt-walkers	2005-02-17 23:59:16.000000000 +1100
+++ linux-2.6-npiggin/mm/mprotect.c	2005-02-17 23:59:16.000000000 +1100
@@ -26,25 +26,13 @@
 #include <asm/tlbflush.h>
 
 static inline void
-change_pte_range(pmd_t *pmd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+change_pte_range(pmd_t *pmd, unsigned long start,
+		unsigned long end, pgprot_t newprot)
 {
+	unsigned long address;
 	pte_t * pte;
-	unsigned long end;
 
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
-	do {
+	for_each_pte_map(pmd, start, end, pte, address) {
 		if (pte_present(*pte)) {
 			pte_t entry;
 
@@ -55,62 +43,47 @@ change_pte_range(pmd_t *pmd, unsigned lo
 			entry = ptep_get_and_clear(pte);
 			set_pte(pte, pte_modify(entry, newprot));
 		}
-		address += PAGE_SIZE;
-		pte++;
-	} while (address && (address < end));
-	pte_unmap(pte - 1);
+	} for_each_pte_map_end;
 }
 
 static inline void
-change_pmd_range(pud_t *pud, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+change_pmd_range(pud_t *pud, unsigned long start,
+		unsigned long end, pgprot_t newprot)
 {
+	unsigned long pmd_start, pmd_end;
 	pmd_t * pmd;
-	unsigned long end;
 
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
-	do {
-		change_pte_range(pmd, address, end - address, newprot);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		if (pmd_none(*pmd))
+			continue;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
+
+		change_pte_range(pmd, pmd_start, pmd_end, newprot);
+	}
 }
 
 static inline void
-change_pud_range(pgd_t *pgd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+change_pud_range(pgd_t *pgd, unsigned long start,
+		unsigned long end, pgprot_t newprot)
 {
+	unsigned long pud_start, pud_end;
 	pud_t * pud;
-	unsigned long end;
 
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
-	do {
-		change_pmd_range(pud, address, end - address, newprot);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
+	for_each_pud(pgd, start, end, pud, pud_start, pud_end) {
+		if (pud_none(*pud))
+			continue;
+		if (pud_bad(*pud)) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+
+		change_pmd_range(pud, pud_start, pud_end, newprot);
+	}
 }
 
 static void
@@ -118,23 +91,24 @@ change_protection(struct vm_area_struct 
 		unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long pgd_start, pgd_end;
 	pgd_t *pgd;
-	unsigned long beg = start, next;
-	int i;
 
-	pgd = pgd_offset(mm, start);
-	flush_cache_range(vma, beg, end);
 	BUG_ON(start >= end);
+	flush_cache_range(vma, start, end);
 	spin_lock(&mm->page_table_lock);
-	for (i = pgd_index(start); i <= pgd_index(end-1); i++) {
-		next = (start + PGDIR_SIZE) & PGDIR_MASK;
-		if (next <= start || next > end)
-			next = end;
-		change_pud_range(pgd, start, next - start, newprot);
-		start = next;
-		pgd++;
+	for_each_pgd(mm, start, end, pgd, pgd_start, pgd_end) {
+		if (pgd_none(*pgd))
+			continue;
+		if (pgd_bad(*pgd)) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+
+		change_pud_range(pgd, pgd_start, pgd_end, newprot);
 	}
-	flush_tlb_range(vma, beg, end);
+	flush_tlb_range(vma, start, end);
 	spin_unlock(&mm->page_table_lock);
 }
 
diff -puN mm/vmalloc.c~vm-pgt-walkers mm/vmalloc.c
--- linux-2.6/mm/vmalloc.c~vm-pgt-walkers	2005-02-17 23:59:16.000000000 +1100
+++ linux-2.6-npiggin/mm/vmalloc.c	2005-02-17 23:59:16.000000000 +1100
@@ -23,212 +23,156 @@
 DEFINE_RWLOCK(vmlist_lock);
 struct vm_struct *vmlist;
 
-static void unmap_area_pte(pmd_t *pmd, unsigned long address,
-				  unsigned long size)
+static void unmap_area_pte(pmd_t *pmd, unsigned long start, unsigned long end)
 {
-	unsigned long end;
+	unsigned long address;
 	pte_t *pte;
 
-	if (pmd_none(*pmd))
-		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
+	for_each_pte_kernel(pmd, start, end, pte, address) {
+		pte_t page = ptep_get_and_clear(pte);
 
-	pte = pte_offset_kernel(pmd, address);
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-
-	do {
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
+		if (unlikely(!pte_none(page) && !pte_present(page))) {
+			printk(KERN_CRIT "ERROR: swapped out kernel page\n");
+			dump_stack();
+		}
+	} for_each_pte_kernel_end;
 }
 
-static void unmap_area_pmd(pud_t *pud, unsigned long address,
-				  unsigned long size)
+static void unmap_area_pmd(pud_t *pud, unsigned long start, unsigned long end)
 {
-	unsigned long end;
+	unsigned long pmd_start, pmd_end;
 	pmd_t *pmd;
 
-	if (pud_none(*pud))
-		return;
-	if (pud_bad(*pud)) {
-		pud_ERROR(*pud);
-		pud_clear(pud);
-		return;
-	}
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		if (pmd_none(*pmd))
+			continue;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			continue;
+		}
 
-	pmd = pmd_offset(pud, address);
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-
-	do {
-		unmap_area_pte(pmd, address, end - address);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
+		unmap_area_pte(pmd, pmd_start, pmd_end);
+	}
 }
 
-static void unmap_area_pud(pgd_t *pgd, unsigned long address,
-			   unsigned long size)
+static void unmap_area_pud(pgd_t *pgd, unsigned long start, unsigned long end)
 {
+	unsigned long pud_start, pud_end;
 	pud_t *pud;
-	unsigned long end;
 
-	if (pgd_none(*pgd))
-		return;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
+	for_each_pud(pgd, start, end, pud, pud_start, pud_end) {
+		if (pud_none(*pud))
+			continue;
+		if (pud_bad(*pud)) {
+			pud_ERROR(*pud);
+			pud_clear(pud);
+			continue;
+		}
+
+		unmap_area_pmd(pud, pud_start, pud_end);
 	}
+}
+
+void unmap_vm_area(struct vm_struct *area)
+{
+	unsigned long start = (unsigned long) area->addr;
+	unsigned long end = (start + area->size);
+	unsigned long pgd_start, pgd_end;
+	pgd_t *pgd;
 
-	pud = pud_offset(pgd, address);
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-
-	do {
-		unmap_area_pmd(pud, address, end - address);
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && (address < end));
+	flush_cache_vunmap(address, end);
+	for_each_pgd_k(start, end, pgd, pgd_start, pgd_end) {
+		if (pgd_none(*pgd))
+			continue;
+		if (pgd_bad(*pgd)) {
+			pgd_ERROR(*pgd);
+			pgd_clear(pgd);
+			continue;
+		}
+
+		unmap_area_pud(pgd, pgd_start, pgd_end);
+	}
+	flush_tlb_kernel_range((unsigned long) area->addr, end);
 }
 
-static int map_area_pte(pte_t *pte, unsigned long address,
-			       unsigned long size, pgprot_t prot,
+static int map_area_pte(pmd_t *pmd, unsigned long start,
+			       unsigned long end, pgprot_t prot,
 			       struct page ***pages)
 {
-	unsigned long end;
-
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
+	unsigned long address;
+	pte_t * pte;
 
-	do {
+	for_each_pte_kernel(pmd, start, end, pte, address) {
 		struct page *page = **pages;
 		WARN_ON(!pte_none(*pte));
 		if (!page)
 			return -ENOMEM;
 
 		set_pte(pte, mk_pte(page, prot));
-		address += PAGE_SIZE;
-		pte++;
 		(*pages)++;
-	} while (address < end);
+	} for_each_pte_kernel_end;
 	return 0;
 }
 
-static int map_area_pmd(pmd_t *pmd, unsigned long address,
-			       unsigned long size, pgprot_t prot,
+static int map_area_pmd(pud_t *pud, unsigned long start,
+			       unsigned long end, pgprot_t prot,
 			       struct page ***pages)
 {
-	unsigned long base, end;
+	unsigned long pmd_start, pmd_end;
+	pmd_t * pmd;
 
-	base = address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-
-	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, base + address);
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, pmd_start);
 		if (!pte)
 			return -ENOMEM;
-		if (map_area_pte(pte, address, end - address, prot, pages))
+		if (map_area_pte(pmd, pmd_start, pmd_end, prot, pages))
 			return -ENOMEM;
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address < end);
+	}
 
 	return 0;
 }
 
-static int map_area_pud(pud_t *pud, unsigned long address,
+static int map_area_pud(pgd_t *pgd, unsigned long start,
 			       unsigned long end, pgprot_t prot,
 			       struct page ***pages)
 {
-	do {
-		pmd_t *pmd = pmd_alloc(&init_mm, pud, address);
+	unsigned long pud_start, pud_end;
+	pud_t * pud;
+
+	for_each_pud(pgd, start, end, pud, pud_start, pud_end) {
+		pmd_t *pmd = pmd_alloc(&init_mm, pud, pud_start);
 		if (!pmd)
 			return -ENOMEM;
-		if (map_area_pmd(pmd, address, end - address, prot, pages))
+		if (map_area_pmd(pud, pud_start, pud_end, prot, pages))
 			return -ENOMEM;
-		address = (address + PUD_SIZE) & PUD_MASK;
-		pud++;
-	} while (address && address < end);
+	}
 
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
-	unsigned long next;
+	unsigned long start = (unsigned long) area->addr;
+	unsigned long end = start + (area->size-PAGE_SIZE);
+	unsigned long pgd_start, pgd_end;
 	pgd_t *pgd;
 	int err = 0;
-	int i;
 
-	pgd = pgd_offset_k(address);
 	spin_lock(&init_mm.page_table_lock);
-	for (i = pgd_index(address); i <= pgd_index(end-1); i++) {
-		pud_t *pud = pud_alloc(&init_mm, pgd, address);
+	for_each_pgd_k(start, end, pgd, pgd_start, pgd_end) {
+		pud_t *pud = pud_alloc(&init_mm, pgd, pgd_start);
 		if (!pud) {
 			err = -ENOMEM;
 			break;
 		}
-		next = (address + PGDIR_SIZE) & PGDIR_MASK;
-		if (next < address || next > end)
-			next = end;
-		if (map_area_pud(pud, address, next, prot, pages)) {
+		if (map_area_pud(pgd, pgd_start, pgd_end, prot, pages)) {
 			err = -ENOMEM;
 			break;
 		}
-
-		address = next;
-		pgd++;
 	}
-
 	spin_unlock(&init_mm.page_table_lock);
-	flush_cache_vmap((unsigned long) area->addr, end);
+	flush_cache_vmap(start, end);
 	return err;
 }
 
diff -puN arch/i386/mm/ioremap.c~vm-pgt-walkers arch/i386/mm/ioremap.c
--- linux-2.6/arch/i386/mm/ioremap.c~vm-pgt-walkers	2005-02-17 23:59:58.000000000 +1100
+++ linux-2.6-npiggin/arch/i386/mm/ioremap.c	2005-02-18 00:29:58.000000000 +1100
@@ -17,86 +17,72 @@
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
 
-static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
+static inline void remap_area_pte(pmd_t *pmd, unsigned long start,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
 {
-	unsigned long end;
+	unsigned long address;
 	unsigned long pfn;
+	pte_t * pte;
 
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
 	pfn = phys_addr >> PAGE_SHIFT;
-	do {
+	for_each_pte_kernel(pmd, start, end, pte, address) {
 		if (!pte_none(*pte)) {
 			printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
 		set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | _PAGE_RW | 
 					_PAGE_DIRTY | _PAGE_ACCESSED | flags)));
-		address += PAGE_SIZE;
 		pfn++;
-		pte++;
-	} while (address && (address < end));
+	} for_each_pte_kernel_end;
 }
 
-static inline int remap_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, unsigned long flags)
+static inline int remap_area_pmd(pud_t * pud, unsigned long start,
+		unsigned long end, unsigned long phys_addr, unsigned long flags)
 {
-	unsigned long end;
+	unsigned long pmd_start, pmd_end;
+	pmd_t * pmd;
 
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	phys_addr -= address;
-	if (address >= end)
-		BUG();
-	do {
-		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, address);
-		if (!pte)
+	phys_addr -= start;
+
+	for_each_pmd(pud, start, end, pmd, pmd_start, pmd_end) {
+		if (!pte_alloc_kernel(&init_mm, pmd, pmd_start))
 			return -ENOMEM;
-		remap_area_pte(pte, address, end - address, address + phys_addr, flags);
-		address = (address + PMD_SIZE) & PMD_MASK;
-		pmd++;
-	} while (address && (address < end));
+		remap_area_pte(pmd, pmd_start, pmd_end, pmd_start + phys_addr, flags);
+	}
 	return 0;
 }
 
-static int remap_area_pages(unsigned long address, unsigned long phys_addr,
+static int remap_area_pages(unsigned long start, unsigned long phys_addr,
 				 unsigned long size, unsigned long flags)
 {
-	int error;
-	pgd_t * dir;
-	unsigned long end = address + size;
+	unsigned long pgd_start, pgd_end;
+	unsigned long end = start + size;
+	pgd_t * pgd;
+	int error = 0;
+
+	BUG_ON(start >= end);
 
-	phys_addr -= address;
-	dir = pgd_offset(&init_mm, address);
 	flush_cache_all();
-	if (address >= end)
-		BUG();
+	phys_addr -= start;
 	spin_lock(&init_mm.page_table_lock);
-	do {
+	for_each_pgd(&init_mm, start, end, pgd, pgd_start, pgd_end) {
 		pud_t *pud;
 		pmd_t *pmd;
 		
+		/* We can get away with this because i386 has no
+		 * more than 3-level page tables */
 		error = -ENOMEM;
-		pud = pud_alloc(&init_mm, dir, address);
+		pud = pud_alloc(&init_mm, pgd, pgd_start);
 		if (!pud)
 			break;
-		pmd = pmd_alloc(&init_mm, pud, address);
+		pmd = pmd_alloc(&init_mm, pud, pgd_start);
 		if (!pmd)
 			break;
-		if (remap_area_pmd(pmd, address, end - address,
-					 phys_addr + address, flags))
+		if (remap_area_pmd(pud, pgd_start, pgd_end,
+					phys_addr + pgd_start, flags))
 			break;
 		error = 0;
-		address = (address + PGDIR_SIZE) & PGDIR_MASK;
-		dir++;
-	} while (address && (address < end));
+	}
 	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return error;
diff -puN include/linux/mm.h~vm-pgt-walkers include/linux/mm.h
diff -puN drivers/char/mem.c~vm-pgt-walkers drivers/char/mem.c

_

--------------030306070507050100030606--

