Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbUKHOlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUKHOlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUKHOjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:39:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261849AbUKHOdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:33:05 -0500
Date: Mon, 8 Nov 2004 14:32:41 GMT
Message-Id: <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] VM routine fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes a number of problems in the VM routines:

 (1) Some inline funcs don't compile if CONFIG_MMU is not set.

 (2) swapper_pml4 needn't exist if CONFIG_MMU is not set.

 (3) __free_pages_ok() doesn't counter set_page_refs() different behaviour if
     CONFIG_MMU is not set.

 (4) swsusp.c invokes TLB flushing functions without including the header file
     that declares them.

Signed-Off-By: dhowells@redhat.com
---
diffstat mmu-fixes-2610rc1mm3.diff
 include/linux/mm.h    |   10 ++++++++++
 init/Kconfig          |    5 +++--
 kernel/power/swsusp.c |    1 +
 kernel/sysctl.c       |    4 ++++
 mm/Makefile           |    4 ++--
 mm/bootmem.c          |   10 ++++++----
 mm/internal.h         |   13 +++++++++++++
 mm/page_alloc.c       |   13 +++++++++++--
 mm/tiny-shmem.c       |    2 ++
 9 files changed, 52 insertions(+), 10 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/mm.h linux-2.6.10-rc1-mm3-frv/include/linux/mm.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/mm.h	2004-11-05 13:15:50.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/include/linux/mm.h	2004-11-05 17:44:09.120160519 +0000
@@ -37,6 +37,10 @@ extern int sysctl_legacy_va_layout;
 #include <asm/processor.h>
 #include <asm/atomic.h>
 
+#ifndef CONFIG_MMU
+#define swapper_pml4 NULL
+#endif
+
 #ifndef MM_VM_SIZE
 #define MM_VM_SIZE(mm)	TASK_SIZE
 #endif
@@ -640,6 +674,7 @@ extern void remove_shrinker(struct shrin
  * inlining and the symmetry break with pte_alloc_map() that does all
  * of this out-of-line.
  */
+#ifdef CONFIG_MMU
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
 {
 	if (pgd_none(*pgd))
@@ -660,6 +695,7 @@ static inline pgd_t *pgd_alloc_k(struct 
 		return __pgd_alloc(mm, pml4, address);
 	return pml4_pgd_offset_k(pml4, address);
 }
+#endif
 
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat,
@@ -682,12 +718,14 @@ struct vm_area_struct *vma_prio_tree_nex
 	for (prio_tree_iter_init(iter, root, begin, end), vma = NULL;	\
 		(vma = vma_prio_tree_next(vma, iter)); )
 
+#ifdef CONFIG_MMU
 static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
 					struct list_head *list)
 {
 	vma->shared.vm_set.parent = NULL;
 	list_add_tail(&vma->shared.vm_set.list, list);
 }
+#endif
 
 /* mmap.c */
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
@@ -801,6 +839,7 @@ static inline void __vm_stat_account(str
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_MMU
 static inline void vm_stat_account(struct vm_area_struct *vma)
 {
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
@@ -812,6 +851,7 @@ static inline void vm_stat_unaccount(str
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
 							-vma_pages(vma));
 }
+#endif
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/init/Kconfig linux-2.6.10-rc1-mm3-frv/init/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/init/Kconfig	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/init/Kconfig	2004-11-05 14:13:04.481446957 +0000
@@ -327,8 +327,9 @@ config CC_OPTIMIZE_FOR_SIZE
 	  If unsure, say N.
 
 config SHMEM
-	default y
-	bool "Use full shmem filesystem" if EMBEDDED && MMU
+	bool "Use full shmem filesystem"
+	default y if EMBEDDED
+	depends on MMU
 	help
 	  The shmem is an internal filesystem used to manage shared memory.
 	  It is backed by swap and manages resource limits. It is also exported
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/power/swsusp.c linux-2.6.10-rc1-mm3-frv/kernel/power/swsusp.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/power/swsusp.c	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/kernel/power/swsusp.c	2004-11-05 14:13:04.000000000 +0000
@@ -67,6 +67,7 @@
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
+#include <asm/tlbflush.h>
 #include <asm/io.h>
 
 #include "power.h"
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/sysctl.c linux-2.6.10-rc1-mm3-frv/kernel/sysctl.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/sysctl.c	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/kernel/sysctl.c	2004-11-05 17:36:16.857528949 +0000
@@ -755,6 +755,7 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
+#ifdef CONFIG_MMU
 	{
 		.ctl_name	= VM_MAX_MAP_COUNT,
 		.procname	= "max_map_count",
@@ -763,6 +764,7 @@ static ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec
 	},
+#endif
 	{
 		.ctl_name	= VM_LAPTOP_MODE,
 		.procname	= "laptop_mode",
@@ -816,6 +818,7 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+#ifdef CONFIG_MMU
 	{
 		.ctl_name	= VM_HEAP_STACK_GAP,
 		.procname	= "heap-stack-gap",
@@ -824,6 +827,7 @@ static ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#endif
 	{ .ctl_name = 0 }
 };
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/mm/bootmem.c linux-2.6.10-rc1-mm3-frv/mm/bootmem.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/mm/bootmem.c	2004-11-05 13:15:52.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/mm/bootmem.c	2004-11-05 14:13:04.617435471 +0000
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <asm/dma.h>
 #include <asm/io.h>
+#include "internal.h"
 
 /*
  * Access to this subsystem has to be serialized externally. (this is
@@ -280,17 +281,18 @@ static unsigned long __init free_all_boo
 	for (i = 0; i < idx; ) {
 		unsigned long v = ~map[i / BITS_PER_LONG];
 		if (gofast && v == ~0UL) {
-			int j;
+			int j, order;
 
 			count += BITS_PER_LONG;
 			__ClearPageReserved(page);
-			set_page_count(page, 1);
+			order = ffs(BITS_PER_LONG) - 1;
+			set_page_refs(page, order);
 			for (j = 1; j < BITS_PER_LONG; j++) {
 				if (j + 16 < BITS_PER_LONG)
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
 			}
-			__free_pages(page, ffs(BITS_PER_LONG)-1);
+			__free_pages(page, order);
 			i += BITS_PER_LONG;
 			page += BITS_PER_LONG;
 		} else if (v) {
@@ -299,7 +301,7 @@ static unsigned long __init free_all_boo
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
-					set_page_count(page, 1);
+					set_page_refs(page, 0);
 					__free_page(page);
 				}
 			}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/mm/internal.h linux-2.6.10-rc1-mm3-frv/mm/internal.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/mm/internal.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/mm/internal.h	2004-11-05 14:13:04.621435134 +0000
@@ -0,0 +1,13 @@
+/* internal.h: mm/ internal definitions
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/* page_alloc.c */
+extern void set_page_refs(struct page *page, int order);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/mm/Makefile linux-2.6.10-rc1-mm3-frv/mm/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/mm/Makefile	2004-10-19 10:42:19.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/mm/Makefile	2004-11-05 14:13:04.624434880 +0000
@@ -5,10 +5,10 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   vmalloc.o
+			   vmalloc.o prio_tree.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
-			   page_alloc.o page-writeback.o pdflush.o prio_tree.o \
+			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   $(mmu-y)
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/mm/page_alloc.c linux-2.6.10-rc1-mm3-frv/mm/page_alloc.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/mm/page_alloc.c	2004-11-05 13:15:52.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/mm/page_alloc.c	2004-11-05 14:13:04.654432347 +0000
@@ -35,6 +35,7 @@
 #include <linux/nodemask.h>
 
 #include <asm/tlbflush.h>
+#include "internal.h"
 
 nodemask_t node_online_map = NODE_MASK_NONE;
 nodemask_t node_possible_map = NODE_MASK_ALL;
@@ -326,6 +328,13 @@ void __free_pages_ok(struct page *page, 
 	arch_free_page(page, order);
 
 	mod_page_state(pgfree, 1 << order);
+
+#ifndef CONFIG_MMU
+	if (order > 0)
+		for (i = 1 ; i < (1 << order) ; ++i)
+			__put_page(page + i);
+#endif
+
 	for (i = 0 ; i < (1 << order) ; ++i)
 		free_pages_check(__FUNCTION__, page + i);
 	list_add(&page->lru, &list);
@@ -366,7 +375,7 @@ expand(struct zone *zone, struct page *p
 	return page;
 }
 
-static inline void set_page_refs(struct page *page, int order)
+void set_page_refs(struct page *page, int order)
 {
 #ifdef CONFIG_MMU
 	set_page_count(page, 1);
@@ -376,9 +385,10 @@ static inline void set_page_refs(struct 
 	/*
 	 * We need to reference all the pages for this order, otherwise if
 	 * anyone accesses one of the pages with (get/put) it will be freed.
+	 * - eg: access_process_vm()
 	 */
 	for (i = 0; i < (1 << order); i++)
-		set_page_count(page+i, 1);
+		set_page_count(page + i, 1);
 #endif /* CONFIG_MMU */
 }
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/mm/tiny-shmem.c linux-2.6.10-rc1-mm3-frv/mm/tiny-shmem.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/mm/tiny-shmem.c	2004-10-27 17:32:38.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/mm/tiny-shmem.c	2004-11-05 14:13:05.000000000 +0000
@@ -112,7 +112,9 @@ int shmem_zero_setup(struct vm_area_stru
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	vma->vm_file = file;
+#ifdef CONFIG_MMU
 	vma->vm_ops = &generic_file_vm_ops;
+#endif
 	return 0;
 }
 
