Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUDAEr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 23:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUDAEr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 23:47:59 -0500
Received: from ozlabs.org ([203.10.76.45]:15000 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262221AbUDAEru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 23:47:50 -0500
Date: Thu, 1 Apr 2004 14:45:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Allow MAP_FIXED hugepage mappings on PPC64
Message-ID: <20040401044540.GB13436@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

On PowerPC64 the "low" hugepage range (at 2-3G for use by 32-bit processes)
needs to be activated before it can be used.  hugetlb_get_unmapped_area()
automatically activates the range for hugepage mappings in 32-bit processes
which are not MAP_FIXED.  However for MAP_FIXED mmap()s, even at a suitable
address will fail if the region is not already activated, because there is
no suitable callback from the generic MAP_FIXED code path into the arch code.

This patch corrects this problem and allows PPC64 to do MAP_FIXED hugepage
mappings in the low hugepage range.



Index: working-2.6/include/asm-ppc64/page.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/page.h	2004-03-31 11:34:35.000000000 +1000
+++ working-2.6/include/asm-ppc64/page.h	2004-04-01 14:32:36.362641240 +1000
@@ -38,10 +38,17 @@
 #define TASK_HPAGE_END_32	(0xc0000000UL)
 
 #define ARCH_HAS_HUGEPAGE_ONLY_RANGE
+#define ARCH_HAS_PREPARE_HUGEPAGE_RANGE
+
+#define is_hugepage_low_range(addr, len) \
+	(((addr) > (TASK_HPAGE_BASE_32-(len))) && ((addr) < TASK_HPAGE_END_32))
+#define is_hugepage_high_range(addr, len) \
+	(((addr) > (TASK_HPAGE_BASE-(len))) && ((addr) < TASK_HPAGE_END))
+
 #define is_hugepage_only_range(addr, len) \
-	( ((addr > (TASK_HPAGE_BASE-len)) && (addr < TASK_HPAGE_END)) || \
-	  (current->mm->context.low_hpages && \
-	   (addr > (TASK_HPAGE_BASE_32-len)) && (addr < TASK_HPAGE_END_32)) )
+	(is_hugepage_high_range((addr), (len)) || \
+	 (current->mm->context.low_hpages \
+	  && is_hugepage_low_range((addr), (len))))
 #define hugetlb_free_pgtables free_pgtables
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2004-02-28 23:14:36.000000000 +1100
+++ working-2.6/include/linux/hugetlb.h	2004-04-01 14:32:36.370640024 +1000
@@ -42,6 +42,13 @@
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
 #endif
 
+#ifndef ARCH_HAS_PREPARE_HUGEPAGE_RANGE
+#define prepare_hugepage_range(addr, len)	\
+	is_aligned_hugepage_range(addr, len)
+#else
+int prepare_hugepage_range(unsigned long addr, unsigned long len);
+#endif
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
@@ -62,6 +69,7 @@
 #define mark_mm_hugetlb(mm, vma)		do { } while (0)
 #define follow_huge_pmd(mm, addr, pmd, write)	0
 #define is_aligned_hugepage_range(addr, len)	0
+#define prepare_hugepage_range(addr, len)	(-EINVAL)
 #define pmd_huge(x)	0
 #define is_hugepage_only_range(addr, len)	0
 #define hugetlb_free_pgtables(tlb, prev, start, end) do { } while (0)
Index: working-2.6/mm/mmap.c
===================================================================
--- working-2.6.orig/mm/mmap.c	2004-03-16 11:31:35.000000000 +1100
+++ working-2.6/mm/mmap.c	2004-04-01 14:32:36.382638200 +1000
@@ -807,9 +807,10 @@
 			return -EINVAL;
 		if (file && is_file_hugepages(file))  {
 			/*
-			 * Make sure that addr and length are properly aligned.
+			 * Check if the given range is hugepage aligned, and
+			 * can be made suitable for hugepages.
 			 */
-			ret = is_aligned_hugepage_range(addr, len);
+			ret = prepare_hugepage_range(addr, len);
 		} else {
 			/*
 			 * Ensure that a normal request is not falling in a
Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-01 14:32:30.430607144 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-01 14:32:36.385637744 +1000
@@ -298,6 +298,16 @@
 	return 0;
 }
 
+int prepare_hugepage_range(unsigned long addr, unsigned long len)
+{
+	if (is_hugepage_high_range(addr, len))
+		return 0;
+	else if (is_hugepage_low_range(addr, len))
+		return open_32bit_htlbpage_range(current->mm);
+
+	return -EINVAL;
+}
+
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma)
 {



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
