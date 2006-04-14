Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWDNCNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWDNCNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWDNCNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:13:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:27501 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965071AbWDNCNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:13:33 -0400
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23804883:sNHT16727102"
Subject: Re: [PATCH 1/8] IA64 various hugepage size - Add a variable to mm
	structure
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-IA64 <linux-ia64@vger.kernel.org>, Luck@vger.kernel.org,
       Tony <tony.luck@intel.com>, Chen@vger.kernel.org,
       Kenneth W <kenneth.w.chen@intel.com>
In-Reply-To: <1144974367.5817.39.camel@linux-znh>
References: <1144974367.5817.39.camel@linux-znh>
Content-Type: text/plain
Organization: 
Message-Id: <1144974667.5817.51.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2006 08:31:07 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hugepage_shift member to struct mm to make huge page size
a per mm structure.

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>


diff -Nraup a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
--- a/arch/ia64/mm/hugetlbpage.c	2006-04-11 07:42:09.000000000 +0800
+++ b/arch/ia64/mm/hugetlbpage.c	2006-04-11 08:31:20.000000000 +0800
@@ -185,3 +185,9 @@ static int __init hugetlb_setup_sz(char 
 	return 1;
 }
 __setup("hugepagesz=", hugetlb_setup_sz);
+
+void hugepage_size_init(struct mm_struct *mm)
+{
+  mm->hugepage_shift = hpage_shift;
+}
+
diff -Nraup a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
--- a/arch/ia64/mm/init.c	2006-04-11 07:42:09.000000000 +0800
+++ b/arch/ia64/mm/init.c	2006-04-11 08:22:24.000000000 +0800
@@ -408,11 +408,6 @@ ia64_mmu_init (void *my_cpu_data)
 	ia64_set_pta(pta | (0 << 8) | (vmlpt_bits << 2) | VHPT_ENABLE_BIT);
 
 	ia64_tlb_init();
-
-#ifdef	CONFIG_HUGETLB_PAGE
-	ia64_set_rr(HPAGE_REGION_BASE, HPAGE_SHIFT << 2);
-	ia64_srlz_d();
-#endif
 }
 
 #ifdef CONFIG_VIRTUAL_MEM_MAP
diff -Nraup a/include/asm-ia64/mmu_context.h b/include/asm-ia64/mmu_context.h
--- a/include/asm-ia64/mmu_context.h	2006-03-20 13:53:29.000000000 +0800
+++ b/include/asm-ia64/mmu_context.h	2006-04-11 08:29:03.000000000 +0800
@@ -127,13 +127,12 @@ destroy_context (struct mm_struct *mm)
 }
 
 static inline void
-reload_context (nv_mm_context_t context)
+reload_context (struct mm_struct *mm, nv_mm_context_t context)
 {
 	unsigned long rid;
 	unsigned long rid_incr = 0;
-	unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
+	unsigned long rr0, rr1, rr2, rr3, rr4;
 
-	old_rr4 = ia64_get_rr(RGN_BASE(RGN_HPAGE));
 	rid = context << 3;	/* make space for encoding the region number */
 	rid_incr = 1 << 8;
 
@@ -144,7 +143,10 @@ reload_context (nv_mm_context_t context)
 	rr3 = rr0 + 3*rid_incr;
 	rr4 = rr0 + 4*rid_incr;
 #ifdef  CONFIG_HUGETLB_PAGE
-	rr4 = (rr4 & (~(0xfcUL))) | (old_rr4 & 0xfc);
+	{
+                unsigned long ps = mm->hugepage_shift << 2;
+                rr4 = ((rr4 & (~(0xfcUL))) | ps);
+        }
 
 #  if RGN_HPAGE != 4
 #    error "reload_context assumes RGN_HPAGE is 4"
@@ -171,7 +173,7 @@ activate_context (struct mm_struct *mm)
 		context = get_mmu_context(mm);
 		if (!cpu_isset(smp_processor_id(), mm->cpu_vm_mask))
 			cpu_set(smp_processor_id(), mm->cpu_vm_mask);
-		reload_context(context);
+		reload_context(mm, context);
 		/*
 		 * in the unlikely event of a TLB-flush by another thread,
 		 * redo the load.
diff -Nraup a/include/asm-ia64/page.h b/include/asm-ia64/page.h
--- a/include/asm-ia64/page.h	2006-04-11 07:42:12.000000000 +0800
+++ b/include/asm-ia64/page.h	2006-04-11 08:18:59.000000000 +0800
@@ -59,6 +59,7 @@
 # define ARCH_HAS_HUGEPAGE_ONLY_RANGE
 # define ARCH_HAS_PREPARE_HUGEPAGE_RANGE
 # define ARCH_HAS_HUGETLB_FREE_PGD_RANGE
+# define ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef __ASSEMBLY__
diff -Nraup a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	2006-04-11 07:42:12.000000000 +0800
+++ b/include/linux/mm.h	2006-04-11 08:24:09.000000000 +0800
@@ -1059,5 +1059,11 @@ void drop_slab(void);
 extern int randomize_va_space;
 #endif
 
+#ifndef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
+#define hugepage_size_init(mm)
+#else
+extern void hugepage_size_init(struct mm_struct *mm);
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff -Nraup a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2006-04-11 07:42:12.000000000 +0800
+++ b/include/linux/sched.h	2006-04-11 08:17:31.000000000 +0800
@@ -350,6 +350,9 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+#ifdef  ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
+        unsigned int            hugepage_shift;
+#endif
 };
 
 struct sighand_struct {
diff -Nraup a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	2006-04-11 07:42:12.000000000 +0800
+++ b/kernel/fork.c	2006-04-11 08:25:32.000000000 +0800
@@ -333,6 +333,7 @@ static struct mm_struct * mm_init(struct
 	mm->ioctx_list = NULL;
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->cached_hole_size = ~0UL;
+	hugepage_size_init(mm);
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;


