Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVCVTZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVCVTZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVCVTZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:25:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:6294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261680AbVCVTYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:24:49 -0500
Subject: [PATCH 2.6.11] AIO panic on PPC64 caused by
	is_hugepage_only_range()
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
In-Reply-To: <20050321184113.0f5e2f6b.akpm@osdl.org>
References: <1111108348.31932.43.camel@ibm-c.pdx.osdl.net>
	 <20050321184113.0f5e2f6b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1111519474.15956.40.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Mar 2005 11:24:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 18:41, Andrew Morton wrote:
> Did we fix this yet?
> 

Here's a patch against 2.6.11 that fixes the problem.
It changes is_hugepage_only_range() to take mm as an argument
and then changes the places that call it to pass 'mm'.
It includes a change for ia64 which has not been compiled.
It applies against the latest bk with some offset.

Signed-off-by: Daniel McNeil <daniel@osdl.org>

diff -urp linux-2.6.11.orig/arch/ppc64/mm/hugetlbpage.c linux-2.6.11/arch/ppc64/mm/hugetlbpage.c
--- linux-2.6.11.orig/arch/ppc64/mm/hugetlbpage.c	2005-03-22 09:43:09.000000000 -0800
+++ linux-2.6.11/arch/ppc64/mm/hugetlbpage.c	2005-03-22 09:45:46.000000000 -0800
@@ -512,7 +512,7 @@ unsigned long arch_get_unmapped_area(str
 		vma = find_vma(mm, addr);
 		if (((TASK_SIZE - len) >= addr)
 		    && (!vma || (addr+len) <= vma->vm_start)
-		    && !is_hugepage_only_range(addr,len))
+		    && !is_hugepage_only_range(mm, addr,len))
 			return addr;
 	}
 	start_addr = addr = mm->free_area_cache;
@@ -522,7 +522,7 @@ full_search:
 	while (TASK_SIZE - len >= addr) {
 		BUG_ON(vma && (addr >= vma->vm_end));
 
-		if (touches_hugepage_low_range(addr, len)) {
+		if (touches_hugepage_low_range(mm, addr, len)) {
 			addr = ALIGN(addr+1, 1<<SID_SHIFT);
 			vma = find_vma(mm, addr);
 			continue;
@@ -583,7 +583,7 @@ arch_get_unmapped_area_topdown(struct fi
 		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
 				(!vma || addr + len <= vma->vm_start)
-				&& !is_hugepage_only_range(addr,len))
+				&& !is_hugepage_only_range(mm, addr,len))
 			return addr;
 	}
 
@@ -596,7 +596,7 @@ try_again:
 	addr = (mm->free_area_cache - len) & PAGE_MASK;
 	do {
 hugepage_recheck:
-		if (touches_hugepage_low_range(addr, len)) {
+		if (touches_hugepage_low_range(mm, addr, len)) {
 			addr = (addr & ((~0) << SID_SHIFT)) - len;
 			goto hugepage_recheck;
 		} else if (touches_hugepage_high_range(addr, len)) {
diff -urp linux-2.6.11.orig/include/asm-ia64/page.h linux-2.6.11/include/asm-ia64/page.h
--- linux-2.6.11.orig/include/asm-ia64/page.h	2005-03-01 23:37:48.000000000 -0800
+++ linux-2.6.11/include/asm-ia64/page.h	2005-03-21 16:58:54.000000000 -0800
@@ -137,7 +137,7 @@ typedef union ia64_va {
 # define htlbpage_to_page(x)	(((unsigned long) REGION_NUMBER(x) << 61)			\
 				 | (REGION_OFFSET(x) >> (HPAGE_SHIFT-PAGE_SHIFT)))
 # define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
-# define is_hugepage_only_range(addr, len)		\
+# define is_hugepage_only_range(mm, addr, len)		\
 	 (REGION_NUMBER(addr) == REGION_HPAGE &&	\
 	  REGION_NUMBER((addr)+(len)) == REGION_HPAGE)
 extern unsigned int hpage_shift;
diff -urp linux-2.6.11.orig/include/asm-ppc64/page.h linux-2.6.11/include/asm-ppc64/page.h
--- linux-2.6.11.orig/include/asm-ppc64/page.h	2005-03-01 23:37:30.000000000 -0800
+++ linux-2.6.11/include/asm-ppc64/page.h	2005-03-21 16:59:46.000000000 -0800
@@ -48,8 +48,8 @@
 #define ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define ARCH_HAS_PREPARE_HUGEPAGE_RANGE
 
-#define touches_hugepage_low_range(addr, len) \
-	(LOW_ESID_MASK((addr), (len)) & current->mm->context.htlb_segs)
+#define touches_hugepage_low_range(mm, addr, len) \
+	(LOW_ESID_MASK((addr), (len)) & mm->context.htlb_segs)
 #define touches_hugepage_high_range(addr, len) \
 	(((addr) > (TASK_HPAGE_BASE-(len))) && ((addr) < TASK_HPAGE_END))
 
@@ -61,9 +61,9 @@
 #define within_hugepage_high_range(addr, len) (((addr) >= TASK_HPAGE_BASE) \
 	  && ((addr)+(len) <= TASK_HPAGE_END) && ((addr)+(len) >= (addr)))
 
-#define is_hugepage_only_range(addr, len) \
+#define is_hugepage_only_range(mm, addr, len) \
 	(touches_hugepage_high_range((addr), (len)) || \
-	  touches_hugepage_low_range((addr), (len)))
+	  touches_hugepage_low_range((mm), (addr), (len)))
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
 #define in_hugepage_area(context, addr) \
diff -urp linux-2.6.11.orig/include/linux/hugetlb.h linux-2.6.11/include/linux/hugetlb.h
--- linux-2.6.11.orig/include/linux/hugetlb.h	2005-03-21 16:50:21.000000000 -0800
+++ linux-2.6.11/include/linux/hugetlb.h	2005-03-22 09:41:24.000000000 -0800
@@ -36,7 +36,7 @@ extern const unsigned long hugetlb_zero,
 extern int sysctl_hugetlb_shm_group;
 
 #ifndef ARCH_HAS_HUGEPAGE_ONLY_RANGE
-#define is_hugepage_only_range(addr, len)	0
+#define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
 #endif
 
@@ -71,7 +71,7 @@ static inline unsigned long hugetlb_tota
 #define is_aligned_hugepage_range(addr, len)	0
 #define prepare_hugepage_range(addr, len)	(-EINVAL)
 #define pmd_huge(x)	0
-#define is_hugepage_only_range(addr, len)	0
+#define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
 #define alloc_huge_page()			({ NULL; })
 #define free_huge_page(p)			({ (void)(p); BUG(); })
diff -urp linux-2.6.11.orig/mm/mmap.c linux-2.6.11/mm/mmap.c
--- linux-2.6.11.orig/mm/mmap.c	2005-03-21 17:00:35.000000000 -0800
+++ linux-2.6.11/mm/mmap.c	2005-03-21 17:01:20.000000000 -0800
@@ -1334,7 +1334,7 @@ get_unmapped_area(struct file *file, uns
 			 * reserved hugepage range.  For some archs like IA-64,
 			 * there is a separate region for hugepages.
 			 */
-			ret = is_hugepage_only_range(addr, len);
+			ret = is_hugepage_only_range(current->mm, addr, len);
 		}
 		if (ret)
 			return -EINVAL;
@@ -1707,7 +1707,7 @@ static void unmap_region(struct mm_struc
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 
-	if (is_hugepage_only_range(start, end - start))
+	if (is_hugepage_only_range(mm, start, end - start))
 		hugetlb_free_pgtables(tlb, prev, start, end);
 	else
 		free_pgtables(tlb, prev, start, end);


