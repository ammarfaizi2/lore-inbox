Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTJLNUi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 09:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTJLNUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 09:20:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62182
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263466AbTJLNUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 09:20:18 -0400
Date: Sun, 12 Oct 2003 15:21:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, Matt_Domsch@Dell.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] page->flags corruption fix
Message-ID: <20031012132132.GN16013@velociraptor.random>
References: <20031011160318.GK16013@velociraptor.random> <Pine.LNX.4.44.0310121213080.4598-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310121213080.4598-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Sun, Oct 12, 2003 at 12:15:23PM +0100, Hugh Dickins wrote:
> But I thought it almost coincidental that the racy cases happen to use
> add_to_page_cache_unique rather than add_to_page_cache, and deserved
> comment: until I noticed _nothing_ now uses add_to_page_cache, so

correct, nothing uses it. I also found it in the process and yes it's
not exported.

> please just delete it from filemap.c and pagemap.h - it wasn't

agreed. I didn't touch it because it was not related to this bug, likely
gcc drops it during linking anyways. But I can clean it up of course.

> exported, so no issue with out-of-tree modules (sorry, looks like
> cleanup I should have done when I updated shmem.c in 2.4.22).
> 
> And maybe add __lru_cache_add (inline? FASTCALL?) for the
> 		if (!TestSetPageLRU(page))
> 			add_page_to_inactive_list(page);
> so you don't have to drop pagemap_lru_lock before lru_cache_add.

I thought about it too, I just didn't think it was a big issue, if we
already took the lock, it'll be still in l1 cache since the unlock and
relock are immediate (and even in cpus using load locked store
conditional for all atomic ops, 1 single additional additional spinlock
didn't sound like a painful thing). But I can optimize this bit agreed
(this is especially useful in my tree with the vm_anon_lru sysctl set to
0 by default).

> > For the page_alloc.c changes, they must not make a difference so I
> > backed them out.
> 
> I agree on that too: I think Rik did it for atomicity throughout,
> to make the safety obvious; but in practice it was already safe.

Agreed.

> However, I'm still not satisfied by your patch.  The patch
> which will satisfy me is to remove all that bit clearing from
> __add_to_page_cache, leaving just a LockPage, doing the clearing
> in one go in __free_pages_ok.  In most cases, a page cannot be added
> to page cache more than once before it's freed, so in those cases
> it doesn't matter which stage we clear them.

;) Well, this goes well beyond the scope of this race condition, I agree
but I didn't consider merging those changes in the same patch ;)

> The exceptions are normal swap (being deleted from swap cache under
> pressure then readded later) and tmpfs: but __add_to_page_cache's
> clearing does not help those cases, they compensate for it as much
> as benefit.  PG_arch_1 needs more checking than I've time for now
> (though I think it'll turn out okay), and probably -pre8 is the
> wrong point for a change of this kind.

yes, I think pre8 isn't the best point, and this change has nothing to
do with the race condition in question anyways.

So I would suggest to cook a patch for this orthogonal optimization
during 2.4.24pre.

So this is a new patch addressing the removal of
add_to_page_cache, and the microoptimization to avoid a suprious
unlock/relock cycle and I added some commentary.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.23pre7/anon-lru-race-better-fix-2

I would be very interested if Dell could test this (so far untested ;)
patch, to be sure this really fixes all the troubles they've experienced
in practice.

Thanks,

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.4.23pre7/include/linux/mm.h race/include/linux/mm.h
--- 2.4.23pre7/include/linux/mm.h	2003-10-10 08:08:27.000000000 +0200
+++ race/include/linux/mm.h	2003-10-11 17:32:02.000000000 +0200
@@ -322,11 +322,9 @@ typedef struct page {
 #define TryLockPage(page)	test_and_set_bit(PG_locked, &(page)->flags)
 #define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
-#define ClearPageChecked(page)	clear_bit(PG_checked, &(page)->flags)
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
 #define ClearPageLaunder(page)	clear_bit(PG_launder, &(page)->flags)
-#define ClearPageArch1(page)	clear_bit(PG_arch_1, &(page)->flags)
 
 /*
  * The zone field is never updated after free_area_init_core()
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.4.23pre7/include/linux/pagemap.h race/include/linux/pagemap.h
--- 2.4.23pre7/include/linux/pagemap.h	2003-10-10 08:08:28.000000000 +0200
+++ race/include/linux/pagemap.h	2003-10-12 14:42:47.000000000 +0200
@@ -85,7 +85,6 @@ extern void FASTCALL(unlock_page(struct 
 	__find_lock_page(mapping, index, page_hash(mapping, index))
 extern struct page *find_trylock_page(struct address_space *, unsigned long);
 
-extern void add_to_page_cache(struct page * page, struct address_space *mapping, unsigned long index);
 extern void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index);
 extern int add_to_page_cache_unique(struct page * page, struct address_space *mapping, unsigned long index, struct page **hash);
 
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.4.23pre7/include/linux/swap.h race/include/linux/swap.h
--- 2.4.23pre7/include/linux/swap.h	2003-10-10 08:08:29.000000000 +0200
+++ race/include/linux/swap.h	2003-10-12 15:02:08.000000000 +0200
@@ -103,6 +103,7 @@ struct sysinfo;
 struct zone_t;
 
 /* linux/mm/swap.c */
+extern void FASTCALL(__lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(__lru_cache_del(struct page *));
 extern void FASTCALL(lru_cache_del(struct page *));
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.4.23pre7/mm/filemap.c race/mm/filemap.c
--- 2.4.23pre7/mm/filemap.c	2003-10-10 08:08:32.000000000 +0200
+++ race/mm/filemap.c	2003-10-12 15:06:36.000000000 +0200
@@ -656,33 +656,16 @@ static inline void __add_to_page_cache(s
 	struct address_space *mapping, unsigned long offset,
 	struct page **hash)
 {
-	/*
-	 * Yes this is inefficient, however it is needed.  The problem
-	 * is that we could be adding a page to the swap cache while
-	 * another CPU is also modifying page->flags, so the updates
-	 * really do need to be atomic.  -- Rik
-	 */
-	ClearPageUptodate(page);
-	ClearPageError(page);
-	ClearPageDirty(page);
-	ClearPageReferenced(page);
-	ClearPageArch1(page);
-	ClearPageChecked(page);
-	LockPage(page);
+	unsigned long flags;
+
+	flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_dirty | 1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked);
+	page->flags = flags | (1 << PG_locked);
 	page_cache_get(page);
 	page->index = offset;
 	add_page_to_inode_queue(mapping, page);
 	add_page_to_hash_queue(page, hash);
 }
 
-void add_to_page_cache(struct page * page, struct address_space * mapping, unsigned long offset)
-{
-	spin_lock(&pagecache_lock);
-	__add_to_page_cache(page, mapping, offset, page_hash(mapping, offset));
-	spin_unlock(&pagecache_lock);
-	lru_cache_add(page);
-}
-
 int add_to_page_cache_unique(struct page * page,
 	struct address_space *mapping, unsigned long offset,
 	struct page **hash)
@@ -690,6 +673,23 @@ int add_to_page_cache_unique(struct page
 	int err;
 	struct page *alias;
 
+	/*
+	 * This function is the only pagecache entry point that
+	 * is allowed to deal with pages outside the pagecache/swapcache,
+	 * but that might be already queued in the VM lru lists
+	 * (one example is the anonymous ram).
+	 *
+	 * For this reason here we have to execute the
+	 * __add_to_page_cache under the pagemap_lru_lock too,
+	 * to avoid VM lru operations like activate_page to
+	 * race with the page->flags clearing in __add_to_page_cache
+	 * or whatever else similar race condition. It's just
+	 * much safer, simpler and more performant (more performant for
+	 * the other common pagecache operations), to avoid the race,
+	 * rather than trying to control it to avoid damages when
+	 * it triggers.
+	 */
+	spin_lock(&pagemap_lru_lock);
 	spin_lock(&pagecache_lock);
 	alias = __find_page_nolock(mapping, offset, *hash);
 
@@ -701,7 +701,8 @@ int add_to_page_cache_unique(struct page
 
 	spin_unlock(&pagecache_lock);
 	if (!err)
-		lru_cache_add(page);
+		__lru_cache_add(page);
+	spin_unlock(&pagemap_lru_lock);
 	return err;
 }
 
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.4.23pre7/mm/page_alloc.c race/mm/page_alloc.c
--- 2.4.23pre7/mm/page_alloc.c	2003-10-10 08:08:32.000000000 +0200
+++ race/mm/page_alloc.c	2003-10-11 17:32:02.000000000 +0200
@@ -109,8 +109,7 @@ static void __free_pages_ok (struct page
 		BUG();
 	if (PageActive(page))
 		BUG();
-	ClearPageReferenced(page);
-	ClearPageDirty(page);
+	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
 
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.4.23pre7/mm/swap.c race/mm/swap.c
--- 2.4.23pre7/mm/swap.c	2003-10-10 08:08:33.000000000 +0200
+++ race/mm/swap.c	2003-10-12 15:02:54.000000000 +0200
@@ -54,6 +54,19 @@ void activate_page(struct page * page)
 /**
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
+ *
+ * This function is for when the caller already holds
+ * the pagemap_lru_lock.
+ */
+void __lru_cache_add(struct page * page)
+{
+	if (!PageLRU(page) && !TestSetPageLRU(page))
+		add_page_to_inactive_list(page);
+}
+
+/**
+ * lru_cache_add: add a page to the page lists
+ * @page: the page to add
  */
 void lru_cache_add(struct page * page)
 {

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
