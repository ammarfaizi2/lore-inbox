Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUCNTtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 14:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUCNTtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 14:49:15 -0500
Received: from hera.kernel.org ([63.209.29.2]:57251 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261597AbUCNTtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 14:49:09 -0500
Date: Sun, 14 Mar 2004 16:47:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: j-nomura@ce.jp.nec.com
cc: linux-kernel@vger.kernel.org, <akpm@osdl.org>, <andrea@suse.de>,
       <riel@redhat.com>, <torvalds@osdl.org>
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi kernel colleagues, 

At first I was skeptic to the inclusion of this patch in v2.4 (due to the
freeze), but after thinking a bit more about I have a few points in favour 
of this modification (read Nomura's message below and the patch to know 
what I'm talking about):

- It is off by default 
- It is very simple (non intrusive), it just changes the point in which 
anonymous pages are inserted into the LRU. 
- When turned on, I dont see it being a reason for introducing new 
bugs.

What you think of this? 

On Wed, 10 Mar 2004 j-nomura@ce.jp.nec.com wrote:

> After discussion with Hugh and recommendation from Andrea,
> it turns out that Andrea's 05_vm_22_vm-anon-lru-3 in 2.4.23aa2 solves
> the problem.
> ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa2/05_vm_22_vm-anon-lru-3
> 
> The patch adds a sysctl which accelerate the performance on
> huge memory machine. It doesn't affect anything if turned off.
> 
> Marcelo, could you apply this to 2.4.26-pre?
> (I attached the slightly modified patch in which the feature is turned
> off by default and which is cleanly applied to bk tree.)
> 
> 
> My test case was:
>   - there is a process with large anonymous mapping
>   - there are large amount of page caches and active I/O processes
>   - there are not much of file mappings
> 
> So the problem happens in this way:
>   - shrink_cache tries scanning inactive list in which most of pages
>     are anonymous mapped
>   - it soon fall into swap_out because of too many anonymous pages
>   - when no free swap space, it hardly frees anything
>   - it retries again but soon calls swap_out again and again
> 
> Without the patch, snapshot of readprofile looks like:
>    3590781 total
>    3289271 swap_out
>     212029 smp_call_function
>      22598 shrink_cache
>      21833 lru_cache_add
>       7787 get_user_pages
> 
> Most of the time was spent in swap_out. (contention on pagetable_lock)
> 
> After applying the patch, the snapshot is like:
>     17420 total
>      3929 copy_page
>      3677 statm_pgd_range
>      1317 try_to_free_buffers
>      1312 __copy_user
>       593 scsi_make_request
> 
> Best regards.

--- linux/include/linux/swap.h	2004/02/19 04:12:39	1.1.1.26
+++ linux/include/linux/swap.h	2004/03/10 10:09:11
@@ -116,7 +116,7 @@ extern void swap_setup(void);
 extern wait_queue_head_t kswapd_wait;
 extern int FASTCALL(try_to_free_pages_zone(zone_t *, unsigned int));
 extern int FASTCALL(try_to_free_pages(unsigned int));
-extern int vm_vfs_scan_ratio, vm_cache_scan_ratio, vm_lru_balance_ratio, vm_passes, vm_gfp_debug, vm_mapped_ratio;
+extern int vm_vfs_scan_ratio, vm_cache_scan_ratio, vm_lru_balance_ratio, vm_passes, vm_gfp_debug, vm_mapped_ratio, vm_anon_lru;
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
--- linux/include/linux/sysctl.h	2004/02/19 04:12:39	1.1.1.23
+++ linux/include/linux/sysctl.h	2004/03/10 10:09:11
@@ -156,6 +156,7 @@ enum
 	VM_MAPPED_RATIO=20,     /* amount of unfreeable pages that triggers swapout */
 	VM_LAPTOP_MODE=21,	/* kernel in laptop flush mode */
 	VM_BLOCK_DUMP=22,	/* dump fs activity to log */
+	VM_ANON_LRU=23,		/* immediatly insert anon pages in the vm page lru */
 };
 
 
--- linux/kernel/sysctl.c	2003/12/02 04:48:47	1.1.1.22
+++ linux/kernel/sysctl.c	2004/03/10 10:09:12
@@ -287,6 +287,8 @@ static ctl_table vm_table[] = {
 	 &vm_cache_scan_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MAPPED_RATIO, "vm_mapped_ratio", 
 	 &vm_mapped_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_ANON_LRU, "vm_anon_lru", 
+	 &vm_anon_lru, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_LRU_BALANCE_RATIO, "vm_lru_balance_ratio", 
 	 &vm_lru_balance_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PASSES, "vm_passes", 
--- linux/mm/memory.c	2003/12/02 04:48:47	1.1.1.31
+++ linux/mm/memory.c	2004/03/10 10:09:12
@@ -984,7 +984,8 @@ static int do_wp_page(struct mm_struct *
 		if (PageReserved(old_page))
 			++mm->rss;
 		break_cow(vma, new_page, address, page_table);
-		lru_cache_add(new_page);
+		if (vm_anon_lru)
+			lru_cache_add(new_page);
 
 		/* Free the old page.. */
 		new_page = old_page;
@@ -1215,7 +1216,8 @@ static int do_anonymous_page(struct mm_s
 		mm->rss++;
 		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-		lru_cache_add(page);
+		if (vm_anon_lru)
+			lru_cache_add(page);
 		mark_page_accessed(page);
 	}
 
@@ -1270,7 +1272,8 @@ static int do_no_page(struct mm_struct *
 		}
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
-		lru_cache_add(page);
+		if (vm_anon_lru)
+			lru_cache_add(page);
 		new_page = page;
 	}
 
--- linux/mm/vmscan.c	2004/02/19 04:12:33	1.1.1.32
+++ linux/mm/vmscan.c	2004/03/10 10:09:13
@@ -65,6 +65,27 @@ int vm_lru_balance_ratio = 2;
 int vm_vfs_scan_ratio = 6;
 
 /*
+ * "vm_anon_lru" select if to immdiatly insert anon pages in the
+ * lru. Immediatly means as soon as they're allocated during the
+ * page faults.
+ *
+ * If this is set to 0, they're inserted only after the first
+ * swapout.
+ *
+ * Having anon pages immediatly inserted in the lru allows the
+ * VM to know better when it's worthwhile to start swapping
+ * anonymous ram, it will start to swap earlier and it should
+ * swap smoother and faster, but it will decrease scalability
+ * on the >16-ways of an order of magnitude. Big SMP/NUMA
+ * definitely can't take an hit on a global spinlock at
+ * every anon page allocation. So this is off by default.
+ *
+ * Low ram machines that swaps all the time want to turn
+ * this on (i.e. set to 1).
+ */
+int vm_anon_lru = 1;
+
+/*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
  * It returns zero if it couldn't do anything,

