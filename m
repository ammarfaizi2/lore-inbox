Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVAEXOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVAEXOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVAEXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:14:32 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:6536 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262644AbVAEXML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:12:11 -0500
Date: Wed, 5 Jan 2005 15:11:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V3 [1/4]: Allow request for zeroed memory
In-Reply-To: <Pine.LNX.4.58.0501041724050.4111@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501051507470.9799@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
  <41C20E3E.3070209@yahoo.com.au>  <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
  <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com> 
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be> 
 <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
 <1104882342.16305.12.camel@localhost> <Pine.LNX.4.58.0501041715280.2222@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041724050.4111@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Linus Torvalds wrote:

> Please do split it up into a function of its own. It's going to look a lot
> prettier as an intermediate phase. I realize that that touches #3 in the
> series, but I suspect that one will also just be prettier as a result.

Here is the first patch redone as you wanted. I also removed all
dependencies on the second patch. This should be able to get in
on its own.
I will sent the revised second patch dealing with updating clear_page
later and keep back the last two patches until the bitmap thing has been
changed in the buddy allocator.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

This patch introduces __GFP_ZERO as an additional gfp_mask element to allow
to request zeroed pages from the page allocator.

- Modifies the page allocator so that it zeroes memory if __GFP_ZERO is set

- Replace all page zeroing after allocating pages by prior allocations with
  allocations using __GFP_ZERO

Index: linux-2.6.10/mm/page_alloc.c
===================================================================
--- linux-2.6.10.orig/mm/page_alloc.c	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-05 09:32:52.000000000 -0800
@@ -549,6 +549,12 @@
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
+static inline void prep_zero_page(struct page *page, int order) {
+	int i;
+
+	for(i = 0; i < (1 << order); i++)
+		clear_highpage(page + i);
+}

 static struct page *
 buffered_rmqueue(struct zone *zone, int order, int gfp_flags)
@@ -584,6 +590,10 @@
 		BUG_ON(bad_range(zone, page));
 		mod_page_state_zone(zone, pgalloc, 1 << order);
 		prep_new_page(page, order);
+
+		if (gfp_flags & __GFP_ZERO)
+			prep_zero_page(page, order);
+
 		if (order && (gfp_flags & __GFP_COMP))
 			prep_compound_page(page, order);
 	}
@@ -796,12 +806,9 @@
 	 */
 	BUG_ON(gfp_mask & __GFP_HIGHMEM);

-	page = alloc_pages(gfp_mask, 0);
-	if (page) {
-		void *address = page_address(page);
-		clear_page(address);
-		return (unsigned long) address;
-	}
+	page = alloc_pages(gfp_mask | __GFP_ZERO, 0);
+	if (page)
+		return (unsigned long) page_address(page);
 	return 0;
 }

Index: linux-2.6.10/include/linux/gfp.h
===================================================================
--- linux-2.6.10.orig/include/linux/gfp.h	2004-12-24 13:34:27.000000000 -0800
+++ linux-2.6.10/include/linux/gfp.h	2005-01-05 09:30:39.000000000 -0800
@@ -37,6 +37,7 @@
 #define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */
 #define __GFP_NO_GROW	0x2000	/* Slab internal usage */
 #define __GFP_COMP	0x4000	/* Add compound page metadata */
+#define __GFP_ZERO	0x8000	/* Return zeroed page on success */

 #define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
@@ -52,6 +53,7 @@
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_HIGHZERO	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM | __GFP_ZERO)

 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-05 09:30:39.000000000 -0800
@@ -1650,10 +1650,9 @@

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		page = alloc_page_vma(GFP_HIGHZERO, vma, addr);
 		if (!page)
 			goto no_mem;
-		clear_user_highpage(page, addr);

 		spin_lock(&mm->page_table_lock);
 		page_table = pte_offset_map(pmd, addr);
Index: linux-2.6.10/kernel/profile.c
===================================================================
--- linux-2.6.10.orig/kernel/profile.c	2004-12-24 13:35:28.000000000 -0800
+++ linux-2.6.10/kernel/profile.c	2005-01-05 09:30:39.000000000 -0800
@@ -326,17 +326,15 @@
 		node = cpu_to_node(cpu);
 		per_cpu(cpu_profile_flip, cpu) = 0;
 		if (!per_cpu(cpu_profile_hits, cpu)[1]) {
-			page = alloc_pages_node(node, GFP_KERNEL, 0);
+			page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 			if (!page)
 				return NOTIFY_BAD;
-			clear_highpage(page);
 			per_cpu(cpu_profile_hits, cpu)[1] = page_address(page);
 		}
 		if (!per_cpu(cpu_profile_hits, cpu)[0]) {
-			page = alloc_pages_node(node, GFP_KERNEL, 0);
+			page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 			if (!page)
 				goto out_free;
-			clear_highpage(page);
 			per_cpu(cpu_profile_hits, cpu)[0] = page_address(page);
 		}
 		break;
@@ -510,16 +508,14 @@
 		int node = cpu_to_node(cpu);
 		struct page *page;

-		page = alloc_pages_node(node, GFP_KERNEL, 0);
+		page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 		if (!page)
 			goto out_cleanup;
-		clear_highpage(page);
 		per_cpu(cpu_profile_hits, cpu)[1]
 				= (struct profile_hit *)page_address(page);
-		page = alloc_pages_node(node, GFP_KERNEL, 0);
+		page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 		if (!page)
 			goto out_cleanup;
-		clear_highpage(page);
 		per_cpu(cpu_profile_hits, cpu)[0]
 				= (struct profile_hit *)page_address(page);
 	}
Index: linux-2.6.10/mm/shmem.c
===================================================================
--- linux-2.6.10.orig/mm/shmem.c	2004-12-24 13:34:32.000000000 -0800
+++ linux-2.6.10/mm/shmem.c	2005-01-05 09:30:39.000000000 -0800
@@ -369,9 +369,8 @@
 		}

 		spin_unlock(&info->lock);
-		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping));
+		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping) | __GFP_ZERO);
 		if (page) {
-			clear_highpage(page);
 			page->nr_swapped = 0;
 		}
 		spin_lock(&info->lock);
@@ -910,7 +909,7 @@
 	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
 	pvma.vm_pgoff = idx;
 	pvma.vm_end = PAGE_SIZE;
-	page = alloc_page_vma(gfp, &pvma, 0);
+	page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
 	mpol_free(pvma.vm_policy);
 	return page;
 }
@@ -926,7 +925,7 @@
 shmem_alloc_page(unsigned long gfp,struct shmem_inode_info *info,
 				 unsigned long idx)
 {
-	return alloc_page(gfp);
+	return alloc_page(gfp | __GFP_ZERO);
 }
 #endif

@@ -1135,7 +1134,6 @@

 		info->alloced++;
 		spin_unlock(&info->lock);
-		clear_highpage(filepage);
 		flush_dcache_page(filepage);
 		SetPageUptodate(filepage);
 	}
Index: linux-2.6.10/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/pgalloc.h	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -61,9 +61,7 @@
 	pgd_t *pgd = pgd_alloc_one_fast(mm);

 	if (unlikely(pgd == NULL)) {
-		pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-		if (likely(pgd != NULL))
-			clear_page(pgd);
+		pgd = (pgd_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
 	}
 	return pgd;
 }
@@ -106,10 +104,8 @@
 static inline pmd_t*
 pmd_alloc_one (struct mm_struct *mm, unsigned long addr)
 {
-	pmd_t *pmd = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pmd_t *pmd = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);

-	if (likely(pmd != NULL))
-		clear_page(pmd);
 	return pmd;
 }

@@ -140,20 +136,16 @@
 static inline struct page *
 pte_alloc_one (struct mm_struct *mm, unsigned long addr)
 {
-	struct page *pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+	struct page *pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);

-	if (likely(pte != NULL))
-		clear_page(page_address(pte));
 	return pte;
 }

 static inline pte_t *
 pte_alloc_one_kernel (struct mm_struct *mm, unsigned long addr)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);

-	if (likely(pte != NULL))
-		clear_page(pte);
 	return pte;
 }

Index: linux-2.6.10/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.10.orig/arch/i386/mm/pgtable.c	2005-01-04 14:16:59.000000000 -0800
+++ linux-2.6.10/arch/i386/mm/pgtable.c	2005-01-05 09:30:39.000000000 -0800
@@ -140,10 +140,7 @@

 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
-	return pte;
+	return (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 }

 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
@@ -151,12 +148,10 @@
 	struct page *pte;

 #ifdef CONFIG_HIGHPTE
-	pte = alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT, 0);
+	pte = alloc_pages(GFP_KERNEL|__GFP_HIGHMEM|__GFP_REPEAT|__GFP_ZERO, 0);
 #else
-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 #endif
-	if (pte)
-		clear_highpage(pte);
 	return pte;
 }

Index: linux-2.6.10/include/asm-mips/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-mips/pgalloc.h	2004-12-24 13:34:57.000000000 -0800
+++ linux-2.6.10/include/asm-mips/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -56,9 +56,7 @@
 {
 	pte_t *pte;

-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, PTE_ORDER);
-	if (pte)
-		clear_page(pte);
+	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, PTE_ORDER);

 	return pte;
 }
Index: linux-2.6.10/arch/alpha/mm/init.c
===================================================================
--- linux-2.6.10.orig/arch/alpha/mm/init.c	2004-12-24 13:35:28.000000000 -0800
+++ linux-2.6.10/arch/alpha/mm/init.c	2005-01-05 09:30:39.000000000 -0800
@@ -42,10 +42,9 @@
 {
 	pgd_t *ret, *init;

-	ret = (pgd_t *)__get_free_page(GFP_KERNEL);
+	ret = (pgd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	init = pgd_offset(&init_mm, 0UL);
 	if (ret) {
-		clear_page(ret);
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
 		memcpy (ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
 			(PTRS_PER_PGD - USER_PTRS_PER_PGD - 1)*sizeof(pgd_t));
@@ -63,9 +62,7 @@
 pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pte;
 }

Index: linux-2.6.10/include/asm-parisc/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-parisc/pgalloc.h	2004-12-24 13:35:39.000000000 -0800
+++ linux-2.6.10/include/asm-parisc/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -120,18 +120,14 @@
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
-	if (likely(page != NULL))
-		clear_page(page_address(page));
+	struct page *page = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return page;
 }

 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (likely(pte != NULL))
-		clear_page(pte);
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pte;
 }

Index: linux-2.6.10/include/asm-sparc64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-sparc64/pgalloc.h	2004-12-24 13:35:29.000000000 -0800
+++ linux-2.6.10/include/asm-sparc64/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -73,10 +73,9 @@
 		struct page *page;

 		preempt_enable();
-		page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
+		page = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 		if (page) {
 			ret = (struct page *)page_address(page);
-			clear_page(ret);
 			page->lru.prev = (void *) 2UL;

 			preempt_disable();
Index: linux-2.6.10/include/asm-sh/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-sh/pgalloc.h	2004-12-24 13:34:45.000000000 -0800
+++ linux-2.6.10/include/asm-sh/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -44,9 +44,7 @@
 {
 	pte_t *pte;

-	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO);

 	return pte;
 }
@@ -56,9 +54,7 @@
 {
 	struct page *pte;

-   	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-	if (pte)
-		clear_page(page_address(pte));
+   	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);

 	return pte;
 }
Index: linux-2.6.10/include/asm-m32r/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-m32r/pgalloc.h	2004-12-24 13:35:28.000000000 -0800
+++ linux-2.6.10/include/asm-m32r/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -23,10 +23,7 @@
  */
 static __inline__ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
-
-	if (pgd)
-		clear_page(pgd);
+	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);

 	return pgd;
 }
@@ -39,10 +36,7 @@
 static __inline__ pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 	unsigned long address)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL);
-
-	if (pte)
-		clear_page(pte);
+	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);

 	return pte;
 }
@@ -50,10 +44,8 @@
 static __inline__ struct page *pte_alloc_one(struct mm_struct *mm,
 	unsigned long address)
 {
-	struct page *pte = alloc_page(GFP_KERNEL);
+	struct page *pte = alloc_page(GFP_KERNEL|__GFP_ZERO);

-	if (pte)
-		clear_page(page_address(pte));

 	return pte;
 }
Index: linux-2.6.10/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/mem.c	2005-01-04 14:17:00.000000000 -0800
+++ linux-2.6.10/arch/um/kernel/mem.c	2005-01-05 09:30:39.000000000 -0800
@@ -327,9 +327,7 @@
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pte;
 }

@@ -337,9 +335,7 @@
 {
 	struct page *pte;

-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-	if (pte)
-		clear_highpage(pte);
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	return pte;
 }

Index: linux-2.6.10/include/asm-sh64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-sh64/pgalloc.h	2004-12-24 13:34:00.000000000 -0800
+++ linux-2.6.10/include/asm-sh64/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -112,9 +112,7 @@
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_REPEAT|__GFP_ZERO);

 	return pte;
 }
@@ -123,9 +121,7 @@
 {
 	struct page *pte;

-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-	if (pte)
-		clear_page(page_address(pte));
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);

 	return pte;
 }
@@ -150,9 +146,7 @@
 static __inline__ pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	pmd = (pmd_t *) __get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pmd)
-		clear_page(pmd);
+	pmd = (pmd_t *) __get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pmd;
 }

Index: linux-2.6.10/include/asm-cris/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-cris/pgalloc.h	2004-12-24 13:35:25.000000000 -0800
+++ linux-2.6.10/include/asm-cris/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -24,18 +24,14 @@

 extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-  	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
+  	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
  	return pte;
 }

 extern inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
-	if (pte)
-		clear_page(page_address(pte));
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	return pte;
 }

Index: linux-2.6.10/arch/ppc/mm/pgtable.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/mm/pgtable.c	2004-12-24 13:34:26.000000000 -0800
+++ linux-2.6.10/arch/ppc/mm/pgtable.c	2005-01-05 09:30:39.000000000 -0800
@@ -85,8 +85,7 @@
 {
 	pgd_t *ret;

-	if ((ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGDIR_ORDER)) != NULL)
-		clear_pages(ret, PGDIR_ORDER);
+	ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, PGDIR_ORDER);
 	return ret;
 }

@@ -102,7 +101,7 @@
 	extern void *early_get_page(void);

 	if (mem_init_done) {
-		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 		if (pte) {
 			struct page *ptepage = virt_to_page(pte);
 			ptepage->mapping = (void *) mm;
@@ -110,8 +109,6 @@
 		}
 	} else
 		pte = (pte_t *)early_get_page();
-	if (pte)
-		clear_page(pte);
 	return pte;
 }

Index: linux-2.6.10/include/asm-alpha/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-alpha/pgalloc.h	2004-12-24 13:35:50.000000000 -0800
+++ linux-2.6.10/include/asm-alpha/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -40,9 +40,7 @@
 static inline pmd_t *
 pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (ret)
-		clear_page(ret);
+	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return ret;
 }

Index: linux-2.6.10/include/asm-m68k/motorola_pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-m68k/motorola_pgalloc.h	2004-12-24 13:35:50.000000000 -0800
+++ linux-2.6.10/include/asm-m68k/motorola_pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -12,9 +12,8 @@
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	if (pte) {
-		clear_page(pte);
 		__flush_page_to_ram(pte);
 		flush_tlb_kernel_page(pte);
 		nocache_page(pte);
@@ -31,7 +30,7 @@

 static inline struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *page = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+	struct page *page = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	pte_t *pte;

 	if(!page)
@@ -39,7 +38,6 @@

 	pte = kmap(page);
 	if (pte) {
-		clear_page(pte);
 		__flush_page_to_ram(pte);
 		flush_tlb_kernel_page(pte);
 		nocache_page(pte);
Index: linux-2.6.10/arch/sparc64/mm/init.c
===================================================================
--- linux-2.6.10.orig/arch/sparc64/mm/init.c	2004-12-24 13:34:31.000000000 -0800
+++ linux-2.6.10/arch/sparc64/mm/init.c	2005-01-05 09:30:39.000000000 -0800
@@ -1687,13 +1687,12 @@
 	 * Set up the zero page, mark it reserved, so that page count
 	 * is not manipulated when freeing the page from user ptes.
 	 */
-	mem_map_zero = alloc_pages(GFP_KERNEL, 0);
+	mem_map_zero = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
 	if (mem_map_zero == NULL) {
 		prom_printf("paging_init: Cannot alloc zero page.\n");
 		prom_halt();
 	}
 	SetPageReserved(mem_map_zero);
-	clear_page(page_address(mem_map_zero));

 	codepages = (((unsigned long) _etext) - ((unsigned long) _start));
 	codepages = PAGE_ALIGN(codepages) >> PAGE_SHIFT;
Index: linux-2.6.10/include/asm-arm/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-arm/pgalloc.h	2004-12-24 13:35:29.000000000 -0800
+++ linux-2.6.10/include/asm-arm/pgalloc.h	2005-01-05 09:30:39.000000000 -0800
@@ -50,9 +50,8 @@
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	if (pte) {
-		clear_page(pte);
 		clean_dcache_area(pte, sizeof(pte_t) * PTRS_PER_PTE);
 		pte += PTRS_PER_PTE;
 	}
@@ -65,10 +64,9 @@
 {
 	struct page *pte;

-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT, 0);
+	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
 	if (pte) {
 		void *page = page_address(pte);
-		clear_page(page);
 		clean_dcache_area(page, sizeof(pte_t) * PTRS_PER_PTE);
 	}

Index: linux-2.6.10/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.10.orig/drivers/block/pktcdvd.c	2004-12-24 13:33:49.000000000 -0800
+++ linux-2.6.10/drivers/block/pktcdvd.c	2005-01-05 09:30:39.000000000 -0800
@@ -135,12 +135,10 @@
 		goto no_bio;

 	for (i = 0; i < PAGES_PER_PACKET; i++) {
-		pkt->pages[i] = alloc_page(GFP_KERNEL);
+		pkt->pages[i] = alloc_page(GFP_KERNEL|| __GFP_ZERO);
 		if (!pkt->pages[i])
 			goto no_page;
 	}
-	for (i = 0; i < PAGES_PER_PACKET; i++)
-		clear_page(page_address(pkt->pages[i]));

 	spin_lock_init(&pkt->lock);

