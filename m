Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVCIUZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVCIUZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVCIUYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:24:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:1437 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262153AbVCIUNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:13:45 -0500
Date: Wed, 9 Mar 2005 12:13:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20050309201344.29721.26698.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com>
References: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com>
Subject: Page Fault Scalability patch V19 [4/4]: Drop use of page_table_lock in do_anonymous_page
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use the page_table_lock in do_anonymous_page. This will significantly
increase the parallelism in the page fault handler in SMP systems. The patch
also modifies the definitions of _mm_counter functions so that rss and anon_rss
become atomic.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/mm/memory.c
===================================================================
--- linux-2.6.11.orig/mm/memory.c	2005-03-09 10:43:28.000000000 -0800
+++ linux-2.6.11/mm/memory.c	2005-03-09 10:43:29.000000000 -0800
@@ -1825,12 +1825,12 @@ do_anonymous_page(struct mm_struct *mm, 
 						 vma->vm_page_prot)),
 			      vma);
 
-	spin_lock(&mm->page_table_lock);
+	page_table_atomic_start(mm);
 	
 	if (!ptep_cmpxchg(page_table, orig_entry, entry)) {
 		pte_unmap(page_table);
 		page_cache_release(page);
-		spin_unlock(&mm->page_table_lock);
+		page_table_atomic_stop(mm);
 		inc_page_state(cmpxchg_fail_anon_write);
 		return VM_FAULT_MINOR;
 	}
@@ -1848,7 +1848,7 @@ do_anonymous_page(struct mm_struct *mm, 
 	SetPageReferenced(page);
 	update_mmu_cache(vma, addr, entry); 
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);
 
 	return VM_FAULT_MINOR;
 }
Index: linux-2.6.11/include/linux/sched.h
===================================================================
--- linux-2.6.11.orig/include/linux/sched.h	2005-03-09 10:43:26.000000000 -0800
+++ linux-2.6.11/include/linux/sched.h	2005-03-09 10:43:29.000000000 -0800
@@ -203,10 +203,26 @@ arch_get_unmapped_area_topdown(struct fi
 extern void arch_unmap_area(struct vm_area_struct *area);
 extern void arch_unmap_area_topdown(struct vm_area_struct *area);
 
+#ifdef CONFIG_ATOMIC_TABLE_OPS
+/*
+ * Atomic page table operations require that the counters are also
+ * incremented atomically
+*/
+#define set_mm_counter(mm, member, value) atomic_set(&(mm)->member, value)
+#define get_mm_counter(mm, member) ((unsigned long)atomic_read(&(mm)->member))
+#define update_mm_counter(mm, member, value) atomic_add(value, &(mm)->member)
+#define MM_COUNTER_T atomic_t
+
+#else
+/*
+ * No atomic page table operations. Counters are protected by
+ * the page table lock 
+ */
 #define set_mm_counter(mm, member, value) (mm)->member = (value)
 #define get_mm_counter(mm, member) ((mm)->member)
 #define update_mm_counter(mm, member, value) (mm)->member += (value)
 #define MM_COUNTER_T unsigned long
+#endif
 
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
