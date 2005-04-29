Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVD2UCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVD2UCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVD2UBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:01:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22245 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262924AbVD2T7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:59:20 -0400
Date: Fri, 29 Apr 2005 12:59:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20050429195917.15694.21053.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20050429195901.15694.28520.sendpatchset@schroedinger.engr.sgi.com>
References: <20050429195901.15694.28520.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/3] Page Fault Scalability V20: Avoid lock for anonymous write fault
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use the page_table_lock in do_anonymous_page. This will significantly
increase the parallelism in the page fault handler for SMP systems. The patch
also modifies the definitions of _mm_counter functions so that rss and anon_rss
become atomic (and will use atomic64_t if available).

For the benefit of these performance enhancements see the charts at
http://oss.sgi.com/projects/page_fault_performance/atomic-ptes.pdf

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/mm/memory.c
===================================================================
--- linux-2.6.11.orig/mm/memory.c	2005-04-29 10:31:50.000000000 -0700
+++ linux-2.6.11/mm/memory.c	2005-04-29 10:33:06.000000000 -0700
@@ -1790,12 +1790,12 @@ do_anonymous_page(struct mm_struct *mm, 
 	entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 						vma->vm_page_prot)),
 				vma);
-	spin_lock(&mm->page_table_lock);
+	page_table_atomic_start(mm);
 
 	if (!ptep_cmpxchg(mm, addr, page_table, orig_entry, entry)) {
 		pte_unmap(page_table);
 		page_cache_release(page);
-		spin_unlock(&mm->page_table_lock);
+		page_table_atomic_stop(mm);
 		inc_page_state(cmpxchg_fail_anon_write);
 		return VM_FAULT_MINOR;
         }
@@ -1811,7 +1811,7 @@ do_anonymous_page(struct mm_struct *mm, 
 	pte_unmap(page_table);
 	update_mmu_cache(vma, addr, entry);
 	lazy_mmu_prot_update(entry);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);
 	return VM_FAULT_MINOR;
 }
 
Index: linux-2.6.11/include/linux/sched.h
===================================================================
--- linux-2.6.11.orig/include/linux/sched.h	2005-04-29 08:25:55.000000000 -0700
+++ linux-2.6.11/include/linux/sched.h	2005-04-29 10:33:06.000000000 -0700
@@ -204,12 +204,43 @@ arch_get_unmapped_area_topdown(struct fi
 extern void arch_unmap_area(struct vm_area_struct *area);
 extern void arch_unmap_area_topdown(struct vm_area_struct *area);
 
+#ifdef CONFIG_ATOMIC_TABLE_OPS
+/*
+ * No spinlock is held during atomic page table operations. The
+ * counters are not protected anymore and must also be
+ * incremented atomically.
+*/
+#ifdef ATOMIC64_INIT
+#define set_mm_counter(mm, member, value) atomic64_set(&(mm)->_##member, value)
+#define get_mm_counter(mm, member) ((unsigned long)atomic64_read(&(mm)->_##member))
+#define add_mm_counter(mm, member, value) atomic64_add(value, &(mm)->_##member)
+#define inc_mm_counter(mm, member) atomic64_dec(&(mm)->_##member)
+#define dec_mm_counter(mm, member) atomic64_dec(&(mm)->_##member)
+typedef atomic64_t mm_counter_t;
+#else
+/*
+ * This may limit process memory to 2^31 * PAGE_SIZE which may be around 8TB
+ * if using 4KB page size
+ */
+#define set_mm_counter(mm, member, value) atomic_set(&(mm)->_##member, value)
+#define get_mm_counter(mm, member) ((unsigned long)atomic_read(&(mm)->_##member))
+#define add_mm_counter(mm, member, value) atomic_add(value, &(mm)->_##member)
+#define inc_mm_counter(mm, member) atomic_inc(&(mm)->_##member)
+#define dec_mm_counter(mm, member) atomic_dec(&(mm)->_##member)
+typedef atomic_t mm_counter_t;
+#endif
+#else
+/*
+ * No atomic page table operations. Counters are protected by
+ * the page table lock
+ */
 #define set_mm_counter(mm, member, value) (mm)->_##member = (value)
 #define get_mm_counter(mm, member) ((mm)->_##member)
 #define add_mm_counter(mm, member, value) (mm)->_##member += (value)
 #define inc_mm_counter(mm, member) (mm)->_##member++
 #define dec_mm_counter(mm, member) (mm)->_##member--
 typedef unsigned long mm_counter_t;
+#endif
 
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
