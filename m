Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbUKSTuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbUKSTuC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUKSTqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:46:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45242 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261561AbUKSTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:43:40 -0500
Date: Fri, 19 Nov 2004 11:43:30 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: page fault scalability patch V11 [1/7]: sloppy rss
In-Reply-To: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0411191142540.24095@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain>
  <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> 
 <419D581F.2080302@yahoo.com.au>  <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com>
  <419D5E09.20805@yahoo.com.au>  <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com>
 <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Enable the sloppy use of mm->rss and mm->anon_rss atomic without locking
	* Insure that negative rss values are not given out by the /proc filesystem
	* remove 3 checks of rss in mm/rmap.c
	* Prerequisite for page table scalability patch

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/include/linux/sched.h
===================================================================
--- linux-2.6.9.orig/include/linux/sched.h	2004-11-15 11:13:39.000000000 -0800
+++ linux-2.6.9/include/linux/sched.h	2004-11-18 13:04:30.000000000 -0800
@@ -216,7 +216,7 @@
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
-	spinlock_t page_table_lock;		/* Protects page tables, mm->rss, mm->anon_rss */
+	spinlock_t page_table_lock;		/* Protects page tables */

 	struct list_head mmlist;		/* List of maybe swapped mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
@@ -252,6 +252,21 @@
 	struct kioctx		default_kioctx;
 };

+/*
+ * rss and anon_rss are incremented and decremented in some locations without
+ * proper locking. This function insures that these values do not become negative.
+ */
+static long inline get_rss(struct mm_struct *mm)
+{
+	long rss = mm->rss;
+
+	if (rss < 0)
+		 mm->rss = rss = 0;
+	if ((long)mm->anon_rss < 0)
+		mm->anon_rss = 0;
+	return rss;
+}
+
 struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
Index: linux-2.6.9/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.9.orig/fs/proc/task_mmu.c	2004-11-15 11:13:38.000000000 -0800
+++ linux-2.6.9/fs/proc/task_mmu.c	2004-11-18 12:56:26.000000000 -0800
@@ -22,7 +22,7 @@
 		"VmPTE:\t%8lu kB\n",
 		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
+		get_rss(mm) << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib,
 		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10);
@@ -37,7 +37,9 @@
 int task_statm(struct mm_struct *mm, int *shared, int *text,
 	       int *data, int *resident)
 {
-	*shared = mm->rss - mm->anon_rss;
+	*shared = get_rss(mm) - mm->anon_rss;
+	if (*shared <0)
+		*shared = 0;
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->total_vm - mm->shared_vm;
Index: linux-2.6.9/fs/proc/array.c
===================================================================
--- linux-2.6.9.orig/fs/proc/array.c	2004-11-15 11:13:38.000000000 -0800
+++ linux-2.6.9/fs/proc/array.c	2004-11-18 12:53:16.000000000 -0800
@@ -420,7 +420,7 @@
 		jiffies_to_clock_t(task->it_real_value),
 		start_time,
 		vsize,
-		mm ? mm->rss : 0, /* you might want to shift this left 3 */
+		mm ? get_rss(mm) : 0, /* you might want to shift this left 3 */
 	        rsslim,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
Index: linux-2.6.9/mm/rmap.c
===================================================================
--- linux-2.6.9.orig/mm/rmap.c	2004-11-15 11:13:40.000000000 -0800
+++ linux-2.6.9/mm/rmap.c	2004-11-18 12:26:45.000000000 -0800
@@ -263,8 +263,6 @@
 	pte_t *pte;
 	int referenced = 0;

-	if (!mm->rss)
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -504,8 +502,6 @@
 	pte_t pteval;
 	int ret = SWAP_AGAIN;

-	if (!mm->rss)
-		goto out;
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
@@ -788,8 +784,7 @@
 			if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
 				continue;
 			cursor = (unsigned long) vma->vm_private_data;
-			while (vma->vm_mm->rss &&
-				cursor < max_nl_cursor &&
+			while (cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
 				try_to_unmap_cluster(cursor, &mapcount, vma);
 				cursor += CLUSTER_SIZE;

