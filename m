Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVA1Uph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVA1Uph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVA1UoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:44:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53169 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262771AbVA1Uib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:38:31 -0500
Date: Fri, 28 Jan 2005 12:38:18 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: page fault scalability patch V16 [4/4]: Drop page_table_lock in
 do_anonymous_page
In-Reply-To: <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501281237440.19266@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
 <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
 <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
 <20050114043944.GB41559@muc.de> <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
 <20050114170140.GB4634@muc.de> <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
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
--- linux-2.6.10.orig/mm/memory.c	2005-01-27 16:39:24.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-01-27 16:39:24.000000000 -0800
@@ -1839,12 +1839,12 @@ do_anonymous_page(struct mm_struct *mm,
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
@@ -1862,7 +1862,7 @@ do_anonymous_page(struct mm_struct *mm,

 	update_mmu_cache(vma, addr, entry);
 	pte_unmap(page_table);
-	spin_unlock(&mm->page_table_lock);
+	page_table_atomic_stop(mm);

 	return VM_FAULT_MINOR;
 }
Index: linux-2.6.10/include/linux/sched.h
===================================================================
--- linux-2.6.10.orig/include/linux/sched.h	2005-01-27 16:39:24.000000000 -0800
+++ linux-2.6.10/include/linux/sched.h	2005-01-27 16:40:24.000000000 -0800
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

