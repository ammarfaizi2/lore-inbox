Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVCBEBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVCBEBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 23:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVCBEB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 23:01:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45280 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262164AbVCBDxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 22:53:11 -0500
Date: Tue, 1 Mar 2005 19:52:23 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Page fault scalability patch V18: No page table lock in do_anonymous_page
In-Reply-To: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0503011951510.25441@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use the page_table_lock in do_anonymous_page. This will significantly
increase the parallelism in the page fault handler in SMP systems. The patch
also modifies the definitions of _mm_counter functions so that rss and anon_rss
become atomic.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-02-24 19:42:21.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-02-24 19:42:25.000000000 -0800
@@ -1832,12 +1832,12 @@ do_anonymous_page(struct mm_struct *mm,
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
@@ -1855,7 +1855,7 @@ do_anonymous_page(struct mm_struct *mm,

 	update_mmu_cache(vma, addr, entry);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);

 	return VM_FAULT_MINOR;
 }
Index: linux-2.6.10/include/linux/sched.h
===================================================================
--- linux-2.6.10.orig/include/linux/sched.h	2005-02-24 19:42:17.000000000 -0800
+++ linux-2.6.10/include/linux/sched.h	2005-02-24 19:42:25.000000000 -0800
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

