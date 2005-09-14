Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVINVX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVINVX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVINVX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:23:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31042
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932471AbVINVX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:23:27 -0400
Date: Wed, 14 Sep 2005 23:24:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <npiggin@novell.com>, Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: ptrace can't be transparent on readonly MAP_SHARED
Message-ID: <20050914212405.GD4966@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch went in recently:

	http://kernel.org/hg/linux-2.6/?cmd=changeset;node=04131690c4cf45c50aedc8bec2366198e52eaf4e

I think it's wrong to allow exceptions to the rule in handle_mm_fault
(i.e. to allow ptes to be marked readonly after a write fault). The
current band-aid in get_user_pages that checks the VM_FAULT_WRITE is
just a side effect of breaking that rule.

The real bug is the fact maybe_mkwrite exists in the first place, and
the other hacks in get_user_pages (I mean the lookup_write now replaced
by the VM_FAULT_WRITE hack that at least now doesn't lockup anymore).

As soon as you generate a write fault on a readonly pte, you broke
coherency with the disk data, so the app _can_ break no matter what a
kernel developer wants to do. In turn this means the userland developer
doing the debugging must know what is going on regardless of all this
unnnecessary complexity. No matter what you change in the kernel it'll
still break.

Of course we can't write to the pagecache either, so we should just cow
and leave the pte writeable, the coherency would be lost regardless,
what _pratical_ gain do we have from marking it read-write when it's not
pagecache anymore?

So I suggest to backout the patch:

	http://kernel.org/hg/linux-2.6/?cmd=changeset;node=04131690c4cf45c50aedc8bec2366198e52eaf4e;style=raw

and replace with this below code that makes the code simpler and faster
as well (removes a branch from the fast path of the page fault handler
that never does anything except for the extremely unlikely and unfixable
ptrace case).

I'm unsure if the below patch applies cleanly after reversing the above
changeset, but I can cleanup if there's some agreement that this is the
way to go.

About generating anonymous pages on top of map_shared that should be
fine with the vm, the way anon-vma works, it already happens for
map_private and it's not conceputally different for anon-vma to deal
with overlap with map-shared or map-private. So I don't think we need to
forbid ptrace (i.e. gdb) to write to a readonly map shared or stuff like
that.

Comments welcome. (especially if you see any bug in my simpler approach
please let me know because that's how I fixed the DoS in some kernel ;)
thanks!

----------------------------------

From: Andrea Arcangeli <andrea@suse.de>
Subject: better fix, no need of VM_FAULT_RACE

readonly mappings will break regardless of what we do, by the time the
cow happened we lost coherency and the app can break randomly. So I
don't think it worth the complexity and speecial case of break_cow
marking the pte readonly. Making it read-write looks cleaner and simpler
and it's the natural effect that we _wrote_ and cowed the page.

This is the 2.4 way too.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

 memory.c |   41 ++++++++---------------------------------
 1 files changed, 8 insertions(+), 33 deletions(-)

Index: sp2/mm/memory.c
--- sp2/mm/memory.c.orig	2005-09-12 23:52:42.000000000 +0200
+++ sp2/mm/memory.c	2005-09-13 00:02:08.000000000 +0200
@@ -814,8 +814,7 @@ int get_user_pages(struct task_struct *t
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map;
-			int lookup_write = write;
-			while (!(map = follow_page(mm, start, lookup_write))) {
+			while (!(map = follow_page(mm, start, write))) {
 				/*
 				 * Shortcut for anonymous pages. We don't want
 				 * to force the creation of pages tables for
@@ -823,7 +822,7 @@ int get_user_pages(struct task_struct *t
 				 * nobody touched so far. This is important
 				 * for doing a core dump for these mappings.
 				 */
-				if (!lookup_write &&
+				if (!write &&
 				    untouched_anonymous_page(mm,vma,start)) {
 					map = ZERO_PAGE(start);
 					break;
@@ -843,14 +842,6 @@ int get_user_pages(struct task_struct *t
 				default:
 					BUG();
 				}
-				/*
-				 * Now that we have performed a write fault
-				 * and surely no longer have a shared page we
-				 * shouldn't write, we shouldn't ignore an
-				 * unwritable page in the page table if
-				 * we are forcing write access.
-				 */
-				lookup_write = write && !force;
 				spin_lock(&mm->page_table_lock);
 			}
 			if (pages) {
@@ -1042,19 +1033,6 @@ int remap_page_range(struct vm_area_stru
 EXPORT_SYMBOL(remap_page_range);
 
 /*
- * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
- * servicing faults for write access.  In the normal case, do always want
- * pte_mkwrite.  But get_user_pages can cause write faults for mappings
- * that do not have writing enabled, when used by access_process_vm.
- */
-static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_flags & VM_WRITE))
-		pte = pte_mkwrite(pte);
-	return pte;
-}
-
-/*
  * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
  */
 static inline void break_cow(struct vm_area_struct * vma, struct page * new_page, unsigned long address, 
@@ -1063,8 +1041,7 @@ static inline void break_cow(struct vm_a
 	pte_t entry;
 
 	flush_cache_page(vma, address);
-	entry = maybe_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)),
-			      vma);
+	entry = pte_mkwrite(pte_mkdirty(mk_pte(new_page, vma->vm_page_prot)));
 	ptep_establish(vma, address, page_table, entry);
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
@@ -1116,8 +1093,7 @@ static int do_wp_page(struct mm_struct *
 		unlock_page(old_page);
 		if (reuse) {
 			flush_cache_page(vma, address);
-			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
-					      vma);
+			entry = pte_mkwrite(pte_mkyoung(pte_mkdirty(pte)));
 			ptep_establish(vma, address, page_table, entry);
 			update_mmu_cache(vma, address, entry);
 			lazy_mmu_prot_update(entry);
@@ -1461,7 +1437,7 @@ static int do_swap_page(struct mm_struct
 
 	pte = mk_pte(page, vma->vm_page_prot);
 	if (write_access && can_share_swap_page(page))
-		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
+		pte = pte_mkwrite(pte_mkdirty(pte));
 	unlock_page(page);
 
 	flush_icache_page(vma, page);
@@ -1520,9 +1496,8 @@ do_anonymous_page(struct mm_struct *mm, 
 		mm->rss++;
 		acct_update_integrals();
 		update_mem_hiwater();
-		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
-							 vma->vm_page_prot)),
-				      vma);
+		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
+						       vma->vm_page_prot)));
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
 		anon = 1;
@@ -1658,7 +1633,7 @@ retry:
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
-			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+			entry = pte_mkwrite(pte_mkdirty(entry));
 		set_pte(page_table, entry);
 		if (likely(pageable))
 			page_add_rmap(new_page, vma, address, anon);

