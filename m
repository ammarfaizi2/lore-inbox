Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbUCRXSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbUCRXRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:17:07 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32387
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263272AbUCRXFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:39 -0500
Date: Fri, 19 Mar 2004 00:06:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-ID: <20040318230628.GA2050@dualathlon.random>
References: <20040318022201.GE2113@dualathlon.random> <Pine.LNX.4.44.0403181928210.16385-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403181928210.16385-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 08:41:45PM +0000, Hugh Dickins wrote:
> On Thu, 18 Mar 2004, Andrea Arcangeli wrote:
> 
> > This implements anon_vma for the anonymous memory unmapping and objrmap
> > for the file mappings, effectively removing rmap completely and
> > replacing it with more efficient algorithms (in terms of memory
> > utilization and cpu cost for the fast paths).
> 
> There's a lot about this that I like.
> 
> I think your use of anonymous vm_pgoff is brilliant.  I spent the
> afternoon vacillating between believing it does the (mremap move)
> job so smoothly we don't notice, and believing it's all a con trick
> and does nothing at all.  Currently I believe it does the job!
> 
> And very satisfying how anon and obj converge in page_referenced
> and try_to_unmap: although they converge in my version too, I still
> have to use find_vma on anons at the inner level, yours much nicer.
> 
> I think the winning answer will actually lie between yours and mine:
> the anon vmas linked into one tree belonging to the whole fork group.
> Some of the messier aspects of your design come from dealing with the
> vmas separately, with merging issues currently unresolved.  A lot of
> that goes away if you lump all the anon vmas of the same fork group
> into the same list.  Yes, of course the _list_ would be slower to
> search; but once we have the right tree structure for the obj vmas,
> I believe it should apply just as effectively to the anon vmas.

the problem is that they will still not be mergeable if we obey to the
vm_pgoff. We could merge some more though. The other main issue is the
search in this single object for all mm, that has again the downside of
searching all mm. I keep track of exactly which mm to track instead,
this is more finegrined (after all I was competing with the rmap
pte_chains that are overkill finegrined).

But I certainly agree we could mix the two things and have 1 anon_vma
object per-mm instad of per-vma by losing some granularity in the
tracking and making the search more expensive, but then we'd need a
prio_tree there too and that doesn't come for free either, so I'd rather
spend the 12 bytes for the finegrined tracking, the prio_tree can't get
right which mm to scan and which not for every page, the current
anon_vma can.

> I am disappointed that you're persisting with that "as" union: many
> source files remain to be converted to page->as.mapping, and I don't
> think it's worth it at all.  mm/objrmap.c is the _only_ file needing
> a cast there for the anon case, please don't demand edits of so many
> filesystems and others, not at this stage anyway.  You've been very

Ok, I don't think it's the right way to go but you quite convinced me on
this for the short term (now that it swaps heavily just fine and I'm not
scared anymore), the patch will become quite a lot smaller.

> A couple of filesystems history has left in my standard .config but
> apparently not in yours.  Some over-enthusiastic BUG_ONs which will

yep, I didn't compile those fs.

> trigger when shmem_writepage swizzles a tmpfs page to swap at the
> wrong moment (I saw the filemap.c in practice; I think truncate.c
> ones could hit too; didn't search very hard for others).
> 
> And impressive though your saving on page tables was ;)
> PageTables:          0 kB
> a patch to correct that.  Yes, I've left inc out of pte_offset_kernel:

Great spotting, obviously I don't truncate on shmfs often ;), nor I
check the pagetable size often either. This is a greatly appreciated set
of fixes.

> should it have been there anyway? and it's not clear to me whether ppc

Dunno.

> and ppc64 can manage an early per-cpu increment.  You'll find you've
> broken ppc and ppc64, which have grown to use the pgtable rmap stuff
> for themselves, you'll probably want to grab some of my arch patches.

Oh well, this is the next blocker now... Where can I find your arch
patches? PPC folks comments?

BTW, the only scary thing that happened so far was the crash during
heavy swapping, I'm now running with this fix applied and I couldn't
reproduce anymore (usually it always happen in 6 hours or less, so it's
not 100% certain it's bulletproof yet). But I'm quite optimistic I got
rid of one bad race condition now, since everything made sense, both
the oops and the bug. You can see my last email to l-k for details.

So now I will merge your fixes and I will remove the union (so the
breakages gets dominated).

Thank you very much for all your help and great feedback!

--- ./fs/exec.c.~1~	2004-03-17 22:37:53.000000000 +0100
+++ ./fs/exec.c	2004-03-18 23:21:46.572083608 +0100
@@ -324,9 +324,8 @@ void put_dirty_page(struct task_struct *
 	}
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
-	SetPageAnon(page);
 	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, prot))));
-	page_add_rmap(page, vma, address);
+	page_add_rmap(page, vma, address, 1);
 	pte_unmap(pte);
 	tsk->mm->rss++;
 	spin_unlock(&tsk->mm->page_table_lock);
--- ./include/linux/objrmap.h.~1~	2004-03-17 22:37:53.000000000 +0100
+++ ./include/linux/objrmap.h	2004-03-18 23:20:44.169570232 +0100
@@ -53,7 +53,7 @@ extern void FASTCALL(anon_vma_link(struc
 extern void FASTCALL(__anon_vma_link(struct vm_area_struct * vma));
 
 /* objrmap tracking functions */
-void FASTCALL(page_add_rmap(struct page *, struct vm_area_struct *, unsigned long));
+void FASTCALL(page_add_rmap(struct page *, struct vm_area_struct *, unsigned long, int));
 void FASTCALL(page_remove_rmap(struct page *));
 
 /*
--- ./mm/objrmap.c.~1~	2004-03-17 22:37:53.000000000 +0100
+++ ./mm/objrmap.c	2004-03-18 23:34:21.986243200 +0100
@@ -23,6 +23,8 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/objrmap.h>
+#include <linux/init.h>
+#include <asm/tlbflush.h>
 
 kmem_cache_t * anon_vma_cachep;
 
@@ -248,13 +250,32 @@ static inline void anon_vma_page_link(st
  * Add a new pte reverse mapping to a page.
  */
 void fastcall page_add_rmap(struct page *page, struct vm_area_struct * vma,
-			    unsigned long address)
+			    unsigned long address, int anon)
 {
+	int last_anon;
+
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
+	BUG_ON(vma->vm_flags & VM_RESERVED);
 
 	page_map_lock(page);
 
+	/*
+	 * Setting and clearing PG_anon must always happen inside
+	 * page_map_lock to avoid races between mapping and
+	 * unmapping on different processes of the same
+	 * shared cow swapcache page. And while we take the
+	 * page_map_lock PG_anon cannot change from under us.
+	 * Actually PG_anon cannot change under fork either
+	 * since fork holds a reference on the page so it cannot
+	 * be unmapped under fork and in turn copy_page_range is
+	 * allowed to read PG_anon outside the page_map_lock.
+	 */
+	last_anon = PageAnon(page);
+	if (anon && !last_anon)
+		SetPageAnon(page);
+	BUG_ON(!anon && last_anon);
+
 	if (!page->mapcount++)
 		inc_page_state(nr_mapped);
 
@@ -266,16 +287,17 @@ void fastcall page_add_rmap(struct page 
 		 * We can find the mappings by walking the object
 		 * vma chain for that object.
 		 */
-		BUG_ON(!page->as.mapping);
 		BUG_ON(PageSwapCache(page));
+		BUG_ON(!page->as.mapping);
 	}
 
 	page_map_unlock(page);
 }
 
 /* this needs the page->flags PG_map_lock held */
-static void inline anon_vma_page_unlink(struct page * page)
+static inline void anon_vma_page_unlink(struct page * page)
 {
+	BUG_ON(!page->as.mapping);
 	/*
 	 * Cleanup if this anon page is gone
 	 * as far as the vm is concerned.
@@ -304,6 +326,8 @@ void fastcall page_remove_rmap(struct pa
 	if (!page_mapped(page))
 		goto out_unlock;
 
+	BUG_ON(vma->vm_flags & VM_RESERVED);
+
 	if (!--page->mapcount)
 		dec_page_state(nr_mapped);
 
@@ -387,8 +411,7 @@ try_to_unmap_one(struct vm_area_struct *
 	BUG_ON(!page->mapcount);
 
 	mm->rss--;
-	page->mapcount--;
-	if (PageAnon(page))
+	if (!--page->mapcount && PageAnon(page))
 		anon_vma_page_unlink(page);
 	page_cache_release(page);
 
--- ./mm/fremap.c.~1~	2004-03-17 22:37:53.000000000 +0100
+++ ./mm/fremap.c	2004-03-18 23:22:06.747016552 +0100
@@ -77,7 +77,7 @@ int install_page(struct mm_struct *mm, s
 	mm->rss++;
 	flush_icache_page(vma, page);
 	set_pte(pte, mk_pte(page, prot));
-	page_add_rmap(page, vma, addr);
+	page_add_rmap(page, vma, addr, 0);
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
--- ./mm/memory.c.~1~	2004-03-18 00:55:19.000000000 +0100
+++ ./mm/memory.c	2004-03-18 23:25:29.042263000 +0100
@@ -324,7 +324,7 @@ skip_copy_pte_range:
 					 */
 					BUG_ON(!page_mapped(page));
 					BUG_ON(!page->as.mapping);
-					page_add_rmap(page, vma, address);
+					page_add_rmap(page, vma, address, PageAnon(page));
 				} else {
 					BUG_ON(page_mapped(page));
 					BUG_ON(page->as.mapping);
@@ -1056,8 +1056,7 @@ static int do_wp_page(struct mm_struct *
 			++mm->rss;
 		page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
-		SetPageAnon(new_page);
-		page_add_rmap(new_page, vma, address);
+		page_add_rmap(new_page, vma, address, 1);
 		lru_cache_add_active(new_page);
 
 		/* Free the old page.. */
@@ -1291,8 +1290,7 @@ static int do_swap_page(struct mm_struct
 
 	flush_icache_page(vma, page);
 	set_pte(page_table, pte);
-	SetPageAnon(page);
-	page_add_rmap(page, vma, address);
+	page_add_rmap(page, vma, address, 1);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
@@ -1314,7 +1312,7 @@ do_anonymous_page(struct mm_struct *mm, 
 {
 	pte_t entry;
 	struct page * page = ZERO_PAGE(addr);
-	int ret;
+	int ret, anon = 0;
 
 	/* Read-only mapping of ZERO_PAGE. */
 	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
@@ -1348,7 +1346,7 @@ do_anonymous_page(struct mm_struct *mm, 
 				      vma);
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
-		SetPageAnon(page);
+		anon = 1;
 	}
 
 	set_pte(page_table, entry);
@@ -1360,7 +1358,7 @@ do_anonymous_page(struct mm_struct *mm, 
 	ret = VM_FAULT_MINOR;
 
 	/* ignores ZERO_PAGE */
-	page_add_rmap(page, vma, addr);
+	page_add_rmap(page, vma, addr, anon);
 
 	return ret;
 }
@@ -1384,7 +1382,7 @@ do_no_page(struct mm_struct *mm, struct 
 	struct page * new_page;
 	struct address_space *mapping = NULL;
 	pte_t entry;
-	int sequence = 0, reserved, clear_anon_page;
+	int sequence = 0, reserved, anon;
 	int ret = VM_FAULT_MINOR;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
@@ -1435,7 +1433,7 @@ retry:
 	/*
 	 * Should we do an early C-O-W break?
 	 */
-	clear_anon_page = 0;
+	anon = 0;
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
 		struct page * page;
 		if (unlikely(anon_vma_prepare(vma)))
@@ -1446,9 +1444,8 @@ retry:
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
 		lru_cache_add_active(page);
-		SetPageAnon(page);
-		clear_anon_page = 1;
 		new_page = page;
+		anon = 1;
 	}
 
 	spin_lock(&mm->page_table_lock);
@@ -1461,8 +1458,6 @@ retry:
 	      (unlikely(sequence != atomic_read(&mapping->truncate_count)))) {
 		sequence = atomic_read(&mapping->truncate_count);
 		spin_unlock(&mm->page_table_lock);
-		if (unlikely(clear_anon_page))
-			ClearPageAnon(new_page);
 		page_cache_release(new_page);
 		goto retry;
 	}
@@ -1488,7 +1483,7 @@ retry:
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte(page_table, entry);
 		if (likely(!reserved))
-			page_add_rmap(new_page, vma, address);
+			page_add_rmap(new_page, vma, address, anon);
 		pte_unmap(page_table);
 	} else {
 		/* One of our sibling threads was faster, back out. */
--- ./mm/swapfile.c.~1~	2004-03-17 22:37:53.000000000 +0100
+++ ./mm/swapfile.c	2004-03-18 23:25:42.224259032 +0100
@@ -391,8 +391,7 @@ unuse_pte(struct vm_area_struct *vma, un
 	get_page(page);
 	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	BUG_ON(!vma->anon_vma);
-	SetPageAnon(page);
-	page_add_rmap(page, vma, address);
+	page_add_rmap(page, vma, address, 1);
 	swap_free(entry);
 }
 
