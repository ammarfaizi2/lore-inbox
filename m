Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUJNWOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUJNWOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUJNWNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:13:23 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5984 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267934AbUJNVtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:49:50 -0400
Date: Thu, 14 Oct 2004 22:49:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@novell.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: per-process shared information
In-Reply-To: <20041013231042.GQ17849@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410142205450.2702-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Andrea Arcangeli wrote:

> The 2.6 kernel dropped the shared information for each task, the third
> field in /proc/<pid>/statem is a fake largely overstimating the number
> of shared pages (it gets even bigger than the rss, that's why people
> noticed, because the shared information was even bigger than the rss of
> the task, so clearly those pages couldn't be shared if they didn't
> exist).

Yes, in 2.4 they were pte counts (seventh always 0), but in 2.6 all but
the second field (rss) are just extents (fifth and seventh now always 0).
Very wasteful to support the old, often meaningless, counts.

> Nothing important goes wrong in practice, but some statistics gets
> screwed (gets underflows since they're rightfully used to compute rss -
> shared to find the "private" not shared anonymous data).

Is "shared" generally expected to pair with rss?  Would it make
sense to revert shared to a pte count, but leave size, text, and
data as extents?  I don't know.
 
> I guess I can simply resurrect the O(N) pagetable scanning and check for
> page_mapcount > 1 out of order in task_mmu.c? I want to add a new file
> "statm_phys_shared" instead of doing it in statm, to avoid slowing down
> ps xav. So special apps can still get the information out of the kernel.
> 
> At first I considered providing the "shared" information in O(log(N))
> but I believe it would waste quite some cpu in the fast paths (it would
> require walking the prio trees or the anon-vmas in each page fault, and
> it would need to keep track of each vma->mm that we already updated
> during the prio-tree walking), so I'd prefer the statistics to be slow
> in O(N) instead of hurting the fast paths. If I allow rescheduling and I
> trap signals there should be no DoS involved even in the very huge
> boxes.

Sounds horrid to me!  I'm not inclined to volunteer for that: plus this
is very much Bill's territory, though he might be glad to surrender it!

But how about the patch below?  Really a mixture of four patches...

One, support anon_rss as a subset of rss, "shared" being (rss - anon_rss).
Yes, that's a slight change in meaning of "shared" from in 2.4, but easy
to support and I think very reasonable.  On the one hand, yes, of course
we know an anon page may actually be shared between several mms of the
fork group, whereas it won't be counted in "shared" with this patch. But
the old definition of "shared" was considerably more stupid, wasn't it?
for example, a private page in pte and swap cache got counted as shared.
Would this new meaning of "shared" suit your purposes well enough?

Two, more dubious, report this new "shared" as the third field
in /proc/pid/statm, instead of the current "shared_vm".  Maybe we
shouldn't change that now, but add your statm_phys_shared; whatever,
this patch at least allows you to see if it makes sense.

Three, I see negative "data" sometimes: since "text" is (always?) a
subset of "shared_vm", we're subtracting that twice from total_vm.
Fix that, just say data is total_vm-shared_vm: same as VmData+VmStk
from /proc/pid/status.

Four, the __vm_stat_accounting in do_mmap_pgoff didn't work quite
right in the test I happened to try, didn't balance with munmap -
shared anon starts off with NULL file, then gets given a vm_file
at the end, __vm_stat_account needs to use that.  And a driver is
likely to change vm_flags too (adding VM_IO or VM_RESERVED for
example), so better pick that up.  (I've also thrown in updating
pgoff for the vma_merge there: noticed that in an earlier audit,
though in fact all the drivers which adjust vm_pgoff happen to
set one of the VM_SPECIAL flags which prevent merging.)

Hugh

--- 2.6.9-rc4/fs/proc/task_mmu.c	2004-10-11 11:58:22.000000000 +0100
+++ linux/fs/proc/task_mmu.c	2004-10-14 21:33:48.744401000 +0100
@@ -35,9 +35,9 @@ unsigned long task_vsize(struct mm_struc
 int task_statm(struct mm_struct *mm, int *shared, int *text,
 	       int *data, int *resident)
 {
-	*shared = mm->shared_vm;
+	*shared = mm->rss - mm->anon_rss;
 	*text = (mm->end_code - mm->start_code) >> PAGE_SHIFT;
-	*data = mm->total_vm - mm->shared_vm - *text;
+	*data = mm->total_vm - mm->shared_vm;
 	*resident = mm->rss;
 	return mm->total_vm;
 }
--- 2.6.9-rc4/include/linux/sched.h	2004-10-11 11:58:32.000000000 +0100
+++ linux/include/linux/sched.h	2004-10-14 21:33:48.745400848 +0100
@@ -225,7 +225,7 @@ struct mm_struct {
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm, shared_vm;
+	unsigned long rss, anon_rss, total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags;
 
 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
--- 2.6.9-rc4/kernel/fork.c	2004-10-11 11:58:33.000000000 +0100
+++ linux/kernel/fork.c	2004-10-14 21:33:48.747400544 +0100
@@ -297,6 +297,7 @@ static inline int dup_mmap(struct mm_str
 	mm->free_area_cache = oldmm->mmap_base;
 	mm->map_count = 0;
 	mm->rss = 0;
+	mm->anon_rss = 0;
 	cpus_clear(mm->cpu_vm_mask);
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
--- 2.6.9-rc4/mm/memory.c	2004-10-11 11:58:34.000000000 +0100
+++ linux/mm/memory.c	2004-10-14 21:33:48.749400240 +0100
@@ -326,6 +326,8 @@ skip_copy_pte_range:
 				pte = pte_mkold(pte);
 				get_page(page);
 				dst->rss++;
+				if (PageAnon(page))
+					dst->anon_rss++;
 				set_pte(dst_pte, pte);
 				page_dup_rmap(page);
 cont_copy_pte_range_noset:
@@ -416,7 +418,9 @@ static void zap_pte_range(struct mmu_gat
 				set_pte(ptep, pgoff_to_pte(page->index));
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			if (pte_young(pte) && !PageAnon(page))
+			if (PageAnon(page))
+				tlb->mm->anon_rss--;
+			else if (pte_young(pte))
 				mark_page_accessed(page);
 			tlb->freed++;
 			page_remove_rmap(page);
@@ -1095,6 +1099,8 @@ static int do_wp_page(struct mm_struct *
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (likely(pte_same(*page_table, pte))) {
+		if (PageAnon(old_page))
+			mm->anon_rss--;
 		if (PageReserved(old_page))
 			++mm->rss;
 		else
--- 2.6.9-rc4/mm/mmap.c	2004-10-11 11:58:34.000000000 +0100
+++ linux/mm/mmap.c	2004-10-14 21:33:48.751399936 +0100
@@ -988,9 +988,12 @@ munmap_back:
 	 *         f_op->mmap method. -DaveM
 	 */
 	addr = vma->vm_start;
+	pgoff = vma->vm_pgoff;
+	vm_flags = vma->vm_flags;
 
 	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
 			vma->vm_flags, NULL, file, pgoff, vma_policy(vma))) {
+		file = vma->vm_file;
 		vma_link(mm, vma, prev, rb_link, rb_parent);
 		if (correct_wcount)
 			atomic_inc(&inode->i_writecount);
@@ -1005,6 +1008,7 @@ munmap_back:
 	}
 out:	
 	mm->total_vm += len >> PAGE_SHIFT;
+	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
@@ -1015,7 +1019,6 @@ out:	
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
 	}
-	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	return addr;
 
 unmap_and_free_vma:
--- 2.6.9-rc4/mm/rmap.c	2004-10-11 11:58:34.000000000 +0100
+++ linux/mm/rmap.c	2004-10-14 21:33:48.752399784 +0100
@@ -431,6 +431,8 @@ void page_add_anon_rmap(struct page *pag
 	BUG_ON(PageReserved(page));
 	BUG_ON(!anon_vma);
 
+	vma->vm_mm->anon_rss++;
+
 	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 	index = (address - vma->vm_start) >> PAGE_SHIFT;
 	index += vma->vm_pgoff;
@@ -578,6 +580,7 @@ static int try_to_unmap_one(struct page 
 		swap_duplicate(entry);
 		set_pte(pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
+		mm->anon_rss--;
 	}
 
 	mm->rss--;

