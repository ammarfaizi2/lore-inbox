Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbULUT7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbULUT7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbULUT7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:59:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:25472 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261579AbULUT4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:56:35 -0500
Date: Tue, 21 Dec 2004 11:56:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Luck, Tony" <tony.luck@intel.com>, Robin Holt <holt@sgi.com>,
       Adam Litke <agl@us.ibm.com>, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Increase page fault rate by prezeroing V1 [1/3]: Introduce __GFP_ZERO
In-Reply-To: <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412211155340.1313@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces __GFP_ZERO as an additional gfp_mask element to allow
to request zeroed pages from the page allocator.

- Modifies the page allocator so that it zeroes memory if __GFP_ZERO is set

- Replace all page zeroing after allocating pages by request for
  zeroed pages.

- Add an arch specific call zero_page to clear pages greater than
  order 0 and a fallback to repeated calles to clear_page if an
  architecture does not support zero_page(address, order) yet.

- Add ia64 zero_page function
- Add i386 zero_page function
- Add x86_64 zero_page function (untested, unverified)

Index: linux-2.6.9/mm/page_alloc.c
===================================================================
--- linux-2.6.9.orig/mm/page_alloc.c	2004-12-17 14:40:17.000000000 -0800
+++ linux-2.6.9/mm/page_alloc.c	2004-12-21 10:19:37.000000000 -0800
@@ -575,6 +575,18 @@
 		BUG_ON(bad_range(zone, page));
 		mod_page_state_zone(zone, pgalloc, 1 << order);
 		prep_new_page(page, order);
+
+		if (gfp_flags & __GFP_ZERO) {
+#ifdef CONFIG_HIGHMEM
+			if (PageHighMem(page)) {
+				int n = 1 << order;
+
+				while (n-- >0)
+					clear_highpage(page + n);
+			} else
+#endif
+			zero_page(page_address(page), order);
+		}
 		if (order && (gfp_flags & __GFP_COMP))
 			prep_compound_page(page, order);
 	}
@@ -767,12 +779,9 @@
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

Index: linux-2.6.9/include/linux/gfp.h
===================================================================
--- linux-2.6.9.orig/include/linux/gfp.h	2004-10-18 14:53:44.000000000 -0700
+++ linux-2.6.9/include/linux/gfp.h	2004-12-21 10:19:37.000000000 -0800
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
Index: linux-2.6.9/mm/memory.c
===================================================================
--- linux-2.6.9.orig/mm/memory.c	2004-12-17 14:40:17.000000000 -0800
+++ linux-2.6.9/mm/memory.c	2004-12-21 10:19:37.000000000 -0800
@@ -1445,10 +1445,9 @@

 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
-		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		page = alloc_page_vma(GFP_HIGHZERO, vma, addr);
 		if (!page)
 			goto no_mem;
-		clear_user_highpage(page, addr);

 		spin_lock(&mm->page_table_lock);
 		page_table = pte_offset_map(pmd, addr);
Index: linux-2.6.9/kernel/profile.c
===================================================================
--- linux-2.6.9.orig/kernel/profile.c	2004-12-17 14:40:16.000000000 -0800
+++ linux-2.6.9/kernel/profile.c	2004-12-21 10:19:37.000000000 -0800
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
Index: linux-2.6.9/mm/shmem.c
===================================================================
--- linux-2.6.9.orig/mm/shmem.c	2004-12-17 14:40:17.000000000 -0800
+++ linux-2.6.9/mm/shmem.c	2004-12-21 10:19:37.000000000 -0800
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
Index: linux-2.6.9/mm/hugetlb.c
===================================================================
--- linux-2.6.9.orig/mm/hugetlb.c	2004-10-18 14:54:37.000000000 -0700
+++ linux-2.6.9/mm/hugetlb.c	2004-12-21 10:19:37.000000000 -0800
@@ -77,7 +77,6 @@
 struct page *alloc_huge_page(void)
 {
 	struct page *page;
-	int i;

 	spin_lock(&hugetlb_lock);
 	page = dequeue_huge_page();
@@ -88,8 +87,7 @@
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
 	page[1].mapping = (void *)free_huge_page;
-	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
-		clear_highpage(&page[i]);
+	zero_page(page_address(page), HUGETLB_PAGE_ORDER);
 	return page;
 }

Index: linux-2.6.9/arch/ia64/lib/Makefile
===================================================================
--- linux-2.6.9.orig/arch/ia64/lib/Makefile	2004-10-18 14:55:28.000000000 -0700
+++ linux-2.6.9/arch/ia64/lib/Makefile	2004-12-21 10:19:37.000000000 -0800
@@ -6,7 +6,7 @@

 lib-y := __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o			\
 	__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o			\
-	bitop.o checksum.o clear_page.o csum_partial_copy.o copy_page.o	\
+	bitop.o checksum.o clear_page.o zero_page.o csum_partial_copy.o copy_page.o	\
 	clear_user.o strncpy_from_user.o strlen_user.o strnlen_user.o	\
 	flush.o ip_fast_csum.o do_csum.o				\
 	memset.o strlen.o swiotlb.o
Index: linux-2.6.9/include/asm-ia64/page.h
===================================================================
--- linux-2.6.9.orig/include/asm-ia64/page.h	2004-10-18 14:53:21.000000000 -0700
+++ linux-2.6.9/include/asm-ia64/page.h	2004-12-21 10:19:37.000000000 -0800
@@ -57,6 +57,8 @@
 #  define STRICT_MM_TYPECHECKS

 extern void clear_page (void *page);
+extern void zero_page (void *page, int order);
+
 extern void copy_page (void *to, void *from);

 /*
Index: linux-2.6.9/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.9.orig/include/asm-ia64/pgalloc.h	2004-10-18 14:53:06.000000000 -0700
+++ linux-2.6.9/include/asm-ia64/pgalloc.h	2004-12-21 10:19:37.000000000 -0800
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
@@ -107,10 +105,8 @@
 static inline pmd_t*
 pmd_alloc_one (struct mm_struct *mm, unsigned long addr)
 {
-	pmd_t *pmd = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+	pmd_t *pmd = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);

-	if (likely(pmd != NULL))
-		clear_page(pmd);
 	return pmd;
 }

@@ -141,20 +137,16 @@
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

Index: linux-2.6.9/arch/ia64/lib/zero_page.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9/arch/ia64/lib/zero_page.S	2004-12-21 10:19:37.000000000 -0800
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 1999-2002 Hewlett-Packard Co
+ *	Stephane Eranian <eranian@hpl.hp.com>
+ *	David Mosberger-Tang <davidm@hpl.hp.com>
+ * Copyright (C) 2002 Ken Chen <kenneth.w.chen@intel.com>
+ *
+ * 1/06/01 davidm	Tuned for Itanium.
+ * 2/12/02 kchen	Tuned for both Itanium and McKinley
+ * 3/08/02 davidm	Some more tweaking
+ * 12/10/04 clameter	Make it work on pages of order size
+ */
+#include <linux/config.h>
+
+#include <asm/asmmacro.h>
+#include <asm/page.h>
+
+#ifdef CONFIG_ITANIUM
+# define L3_LINE_SIZE	64	// Itanium L3 line size
+# define PREFETCH_LINES	9	// magic number
+#else
+# define L3_LINE_SIZE	128	// McKinley L3 line size
+# define PREFETCH_LINES	12	// magic number
+#endif
+
+#define saved_lc	r2
+#define dst_fetch	r3
+#define dst1		r8
+#define dst2		r9
+#define dst3		r10
+#define dst4		r11
+
+#define dst_last	r31
+#define totsize		r14
+
+GLOBAL_ENTRY(zero_page)
+	.prologue
+	.regstk 2,0,0,0
+	mov r16 = PAGE_SIZE/L3_LINE_SIZE	// main loop count
+	mov totsize = PAGE_SIZE
+	.save ar.lc, saved_lc
+	mov saved_lc = ar.lc
+	;;
+	.body
+	adds dst1 = 16, in0
+	mov ar.lc = (PREFETCH_LINES - 1)
+	mov dst_fetch = in0
+	adds dst2 = 32, in0
+	shl r16 = r16, in1
+	shl totsize = totsize, in1
+	;;
+.fetch:	stf.spill.nta [dst_fetch] = f0, L3_LINE_SIZE
+	adds dst3 = 48, in0		// executing this multiple times is harmless
+	br.cloop.sptk.few .fetch
+	add r16 = -1,r16
+	add dst_last = totsize, dst_fetch
+	adds dst4 = 64, in0
+	;;
+	mov ar.lc = r16			// one L3 line per iteration
+	adds dst_last = -PREFETCH_LINES*L3_LINE_SIZE, dst_last
+	;;
+#ifdef CONFIG_ITANIUM
+	// Optimized for Itanium
+1:	stf.spill.nta [dst1] = f0, 64
+	stf.spill.nta [dst2] = f0, 64
+	cmp.lt p8,p0=dst_fetch, dst_last
+	;;
+#else
+	// Optimized for McKinley
+1:	stf.spill.nta [dst1] = f0, 64
+	stf.spill.nta [dst2] = f0, 64
+	stf.spill.nta [dst3] = f0, 64
+	stf.spill.nta [dst4] = f0, 128
+	cmp.lt p8,p0=dst_fetch, dst_last
+	;;
+	stf.spill.nta [dst1] = f0, 64
+	stf.spill.nta [dst2] = f0, 64
+#endif
+	stf.spill.nta [dst3] = f0, 64
+(p8)	stf.spill.nta [dst_fetch] = f0, L3_LINE_SIZE
+	br.cloop.sptk.few 1b
+	;;
+	mov ar.lc = saved_lc		// restore lc
+	br.ret.sptk.many rp
+END(zero_page)
Index: linux-2.6.9/include/asm-i386/page.h
===================================================================
--- linux-2.6.9.orig/include/asm-i386/page.h	2004-12-17 14:40:16.000000000 -0800
+++ linux-2.6.9/include/asm-i386/page.h	2004-12-21 10:19:37.000000000 -0800
@@ -20,6 +20,7 @@

 #define clear_page(page)	mmx_clear_page((void *)(page))
 #define copy_page(to,from)	mmx_copy_page(to,from)
+#define zero_page(page, order)	mmx_zero_page(page, order)

 #else

@@ -29,6 +30,7 @@
  */

 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define zero_page(page, ordeR)	memset((void *)(page), 0, PAGE_SIZE << order)
 #define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)

 #endif
Index: linux-2.6.9/include/asm-x86_64/page.h
===================================================================
--- linux-2.6.9.orig/include/asm-x86_64/page.h	2004-12-17 14:40:16.000000000 -0800
+++ linux-2.6.9/include/asm-x86_64/page.h	2004-12-21 10:19:37.000000000 -0800
@@ -33,6 +33,7 @@
 #ifndef __ASSEMBLY__

 void clear_page(void *);
+void zero_page(void *, int);
 void copy_page(void *, void *);

 #define clear_user_page(page, vaddr, pg)	clear_page(page)
Index: linux-2.6.9/include/asm-sparc/page.h
===================================================================
--- linux-2.6.9.orig/include/asm-sparc/page.h	2004-10-18 14:53:45.000000000 -0700
+++ linux-2.6.9/include/asm-sparc/page.h	2004-12-21 10:19:37.000000000 -0800
@@ -29,6 +29,7 @@
 #ifndef __ASSEMBLY__

 #define clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
+#define zero_page(page,order)	 memset((void *)(page), 0, PAGE_SIZE <<(order))
 #define copy_page(to,from) 	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 #define clear_user_page(addr, vaddr, page)	\
 	do { 	clear_page(addr);		\
Index: linux-2.6.9/include/asm-s390/page.h
===================================================================
--- linux-2.6.9.orig/include/asm-s390/page.h	2004-10-18 14:53:22.000000000 -0700
+++ linux-2.6.9/include/asm-s390/page.h	2004-12-21 10:19:37.000000000 -0800
@@ -33,6 +33,17 @@
 		      : "+&a" (rp) : : "memory", "cc", "1" );
 }

+static inline void zero_page(void *page, int order)
+{
+	register_pair rp;
+
+	rp.subreg.even = (unsigned long) page;
+	rp.subreg.odd = (unsigned long) 4096 << order;
+        asm volatile ("   slr  1,1\n"
+		      "   mvcl %0,0"
+		      : "+&a" (rp) : : "memory", "cc", "1" );
+}
+
 static inline void copy_page(void *to, void *from)
 {
         if (MACHINE_HAS_MVPG)
Index: linux-2.6.9/arch/i386/lib/mmx.c
===================================================================
--- linux-2.6.9.orig/arch/i386/lib/mmx.c	2004-10-18 14:54:23.000000000 -0700
+++ linux-2.6.9/arch/i386/lib/mmx.c	2004-12-21 10:55:00.000000000 -0800
@@ -161,6 +161,39 @@
 	kernel_fpu_end();
 }

+static void fast_zero_page(void *page, int order)
+{
+	int i;
+
+	kernel_fpu_begin();
+
+	__asm__ __volatile__ (
+		"  pxor %%mm0, %%mm0\n" : :
+	);
+
+	for(i=0;i<((4096/64) << order);i++)
+	{
+		__asm__ __volatile__ (
+		"  movntq %%mm0, (%0)\n"
+		"  movntq %%mm0, 8(%0)\n"
+		"  movntq %%mm0, 16(%0)\n"
+		"  movntq %%mm0, 24(%0)\n"
+		"  movntq %%mm0, 32(%0)\n"
+		"  movntq %%mm0, 40(%0)\n"
+		"  movntq %%mm0, 48(%0)\n"
+		"  movntq %%mm0, 56(%0)\n"
+		: : "r" (page) : "memory");
+		page+=64;
+	}
+	/* since movntq is weakly-ordered, a "sfence" is needed to become
+	 * ordered again.
+	 */
+	__asm__ __volatile__ (
+		"  sfence \n" : :
+	);
+	kernel_fpu_end();
+}
+
 static void fast_copy_page(void *to, void *from)
 {
 	int i;
@@ -293,6 +326,42 @@
 	kernel_fpu_end();
 }

+static void fast_zero_page(void *page, int order)
+{
+	int i;
+
+	kernel_fpu_begin();
+
+	__asm__ __volatile__ (
+		"  pxor %%mm0, %%mm0\n" : :
+	);
+
+	for(i=0;i<((4096/128) << order);i++)
+	{
+		__asm__ __volatile__ (
+		"  movq %%mm0, (%0)\n"
+		"  movq %%mm0, 8(%0)\n"
+		"  movq %%mm0, 16(%0)\n"
+		"  movq %%mm0, 24(%0)\n"
+		"  movq %%mm0, 32(%0)\n"
+		"  movq %%mm0, 40(%0)\n"
+		"  movq %%mm0, 48(%0)\n"
+		"  movq %%mm0, 56(%0)\n"
+		"  movq %%mm0, 64(%0)\n"
+		"  movq %%mm0, 72(%0)\n"
+		"  movq %%mm0, 80(%0)\n"
+		"  movq %%mm0, 88(%0)\n"
+		"  movq %%mm0, 96(%0)\n"
+		"  movq %%mm0, 104(%0)\n"
+		"  movq %%mm0, 112(%0)\n"
+		"  movq %%mm0, 120(%0)\n"
+		: : "r" (page) : "memory");
+		page+=128;
+	}
+
+	kernel_fpu_end();
+}
+
 static void fast_copy_page(void *to, void *from)
 {
 	int i;
@@ -359,7 +428,7 @@
  *	Favour MMX for page clear and copy.
  */

-static void slow_zero_page(void * page)
+static void slow_clear_page(void * page)
 {
 	int d0, d1;
 	__asm__ __volatile__( \
@@ -369,15 +438,34 @@
 		:"a" (0),"1" (page),"0" (1024)
 		:"memory");
 }
+
+static void slow_zero_page(void * page, int order)
+{
+	int d0, d1;
+	__asm__ __volatile__( \
+		"cld\n\t" \
+		"rep ; stosl" \
+		: "=&c" (d0), "=&D" (d1)
+		:"a" (0),"1" (page),"0" (1024 << order)
+		:"memory");
+}

 void mmx_clear_page(void * page)
 {
 	if(unlikely(in_interrupt()))
-		slow_zero_page(page);
+		slow_clear_page(page);
 	else
 		fast_clear_page(page);
 }

+void mmx_zero_page(void * page, int order)
+{
+	if(unlikely(in_interrupt()))
+		slow_zero_page(page, order);
+	else
+		fast_zero_page(page, order);
+}
+
 static void slow_copy_page(void *to, void *from)
 {
 	int d0, d1, d2;
Index: linux-2.6.9/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.9.orig/arch/i386/mm/pgtable.c	2004-12-17 14:40:10.000000000 -0800
+++ linux-2.6.9/arch/i386/mm/pgtable.c	2004-12-21 10:19:37.000000000 -0800
@@ -132,10 +132,7 @@

 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		clear_page(pte);
-	return pte;
+	return (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 }

 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
@@ -143,12 +140,10 @@
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

Index: linux-2.6.9/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux-2.6.9.orig/arch/i386/kernel/i386_ksyms.c	2004-12-17 14:40:10.000000000 -0800
+++ linux-2.6.9/arch/i386/kernel/i386_ksyms.c	2004-12-21 10:19:37.000000000 -0800
@@ -126,6 +126,7 @@
 #ifdef CONFIG_X86_USE_3DNOW
 EXPORT_SYMBOL(_mmx_memcpy);
 EXPORT_SYMBOL(mmx_clear_page);
+EXPORT_SYMBOL(mmx_zero_page);
 EXPORT_SYMBOL(mmx_copy_page);
 #endif

Index: linux-2.6.9/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.9.orig/drivers/block/pktcdvd.c	2004-12-17 14:40:12.000000000 -0800
+++ linux-2.6.9/drivers/block/pktcdvd.c	2004-12-21 10:19:37.000000000 -0800
@@ -125,22 +125,19 @@
 	int i;
 	struct packet_data *pkt;

-	pkt = kmalloc(sizeof(struct packet_data), GFP_KERNEL);
+	pkt = kmalloc(sizeof(struct packet_data), GFP_KERNEL|__GFP_ZERO);
 	if (!pkt)
 		goto no_pkt;
-	memset(pkt, 0, sizeof(struct packet_data));

 	pkt->w_bio = pkt_bio_alloc(PACKET_MAX_SIZE);
 	if (!pkt->w_bio)
 		goto no_bio;

 	for (i = 0; i < PAGES_PER_PACKET; i++) {
-		pkt->pages[i] = alloc_page(GFP_KERNEL);
+		pkt->pages[i] = alloc_page(GFP_KERNEL|__GFP_ZERO);
 		if (!pkt->pages[i])
 			goto no_page;
 	}
-	for (i = 0; i < PAGES_PER_PACKET; i++)
-		clear_page(page_address(pkt->pages[i]));

 	spin_lock_init(&pkt->lock);

Index: linux-2.6.9/arch/x86_64/lib/zero_page.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9/arch/x86_64/lib/zero_page.S	2004-12-21 10:19:37.000000000 -0800
@@ -0,0 +1,52 @@
+/*
+ * Zero a page.
+ * rdi	page
+ */
+	.globl zero_page
+	.p2align 4
+zero_page:
+	xorl   %eax,%eax
+	movl   $4096/64,%ecx
+	shl	%ecx, %esi
+	.p2align 4
+.Lloop:
+	decl	%ecx
+#define PUT(x) movq %rax,x*8(%rdi)
+	movq %rax,(%rdi)
+	PUT(1)
+	PUT(2)
+	PUT(3)
+	PUT(4)
+	PUT(5)
+	PUT(6)
+	PUT(7)
+	leaq	64(%rdi),%rdi
+	jnz	.Lloop
+	nop
+	ret
+zero_page_end:
+
+	/* C stepping K8 run faster using the string instructions.
+	   It is also a lot simpler. Use this when possible */
+
+#include <asm/cpufeature.h>
+
+	.section .altinstructions,"a"
+	.align 8
+	.quad  zero_page
+	.quad  zero_page_c
+	.byte  X86_FEATURE_K8_C
+	.byte  zero_page_end-clear_page
+	.byte  zero_page_c_end-clear_page_c
+	.previous
+
+	.section .altinstr_replacement,"ax"
+zero_page_c:
+	movl $4096/8,%ecx
+	shl	%ecx, %esi
+	xorl %eax,%eax
+	rep
+	stosq
+	ret
+zero_page_c_end:
+	.previous
Index: linux-2.6.9/arch/x86_64/lib/Makefile
===================================================================
--- linux-2.6.9.orig/arch/x86_64/lib/Makefile	2004-10-18 14:53:22.000000000 -0700
+++ linux-2.6.9/arch/x86_64/lib/Makefile	2004-12-21 10:19:37.000000000 -0800
@@ -7,7 +7,7 @@
 obj-y := io.o

 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
-	usercopy.o getuser.o putuser.o  \
+	usercopy.o getuser.o putuser.o zero_page.S \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
 lib-y += memcpy.o memmove.o memset.o copy_user.o

Index: linux-2.6.9/include/asm-x86_64/mmx.h
===================================================================
--- linux-2.6.9.orig/include/asm-x86_64/mmx.h	2004-10-18 14:54:30.000000000 -0700
+++ linux-2.6.9/include/asm-x86_64/mmx.h	2004-12-21 10:19:37.000000000 -0800
@@ -9,6 +9,7 @@

 extern void *_mmx_memcpy(void *to, const void *from, size_t size);
 extern void mmx_clear_page(void *page);
+extern void mmx_zero_page(void *page, int order);
 extern void mmx_copy_page(void *to, void *from);

 #endif
Index: linux-2.6.9/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.9.orig/arch/x86_64/kernel/x8664_ksyms.c	2004-12-17 14:40:11.000000000 -0800
+++ linux-2.6.9/arch/x86_64/kernel/x8664_ksyms.c	2004-12-21 10:19:37.000000000 -0800
@@ -110,6 +110,7 @@

 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(zero_page);

 EXPORT_SYMBOL(cpu_pda);
 #ifdef CONFIG_SMP

