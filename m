Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbTJKQCd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTJKQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:02:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12748
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263236AbTJKQC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:02:28 -0400
Date: Sat, 11 Oct 2003 18:03:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Matt_Domsch@Dell.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] page->flags corruption fix
Message-ID: <20031011160318.GK16013@velociraptor.random>
References: <Pine.LNX.4.44.0310081648560.3138-100000@localhost.localdomain> <Pine.LNX.4.44.0310081156320.5568-100000@chimarrao.boston.redhat.com> <20031011134831.GJ16013@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011134831.GJ16013@velociraptor.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 03:48:31PM +0200, Andrea Arcangeli wrote:
> On Wed, Oct 08, 2003 at 11:59:06AM -0400, Rik van Riel wrote:
> > On Wed, 8 Oct 2003, Hugh Dickins wrote:
> > > On Wed, 8 Oct 2003 Matt_Domsch@Dell.com wrote:
> > 
> > > > We've seen a similar failure with the RHEL2.1 kernel w/o RMAP patches
> > > > too.  So we fully believe it's possible in stock 2.4.x.
> > > 
> > > A similar failure - but what exactly?
> > > And what is the actual race which would account for it?
> > > 
> > > I don't mind you and Rik fixing bugs!
> > > I'd just like to understand the bug before it's fixed.
> > 
> > 1) cpu A adds page P to the swap cache, loading page->flags
> >    and modifying it locally
> > 
> > 2) a second thread scans a page table entry and sees that
> >    the page was accessed, so cpu B moves page P to the
> >    active list
> > 
> > 3) cpu A undoes the PG_inactive -> PG_active bit change,
> >    corrupting the page->flags of P
> > 
> > The -rmap VM doesn't do anything to this bug, except making
> > it easy to trigger due to some side effects.
> 
> I believe the more correct fix is to hold the pagemap_lru_lock during
> __add_to_page_cache. The race exists between pages with PG_lru set (in
> the lru) that are being added to the pagecache/swapcache. Holding both
> spinlocks really avoids the race, your patch sounds less obviously safe
> (since the race still happens but it's more "controlled") and a single
> spinlock should be more efficient than the flood of atomic bitops
> anyways. Comments?  Hugh?

basically the race could only happen by running __add_to_page_cache on a
page that was in the lru already. So it could happen with anon pages and
shm too, never with plain pagecache. It's all about the PG_lru and
PG_active bitflag. Both of them can only be changed inside the
pagemap_lru_lock. So taking the pagemap_lru_lock will avoid the race.
Can anybody see any race with this patch applied on top of 2.4.23pre7?

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.23pre7/anon-lru-race-better-fix-1

I believe this is cleaner and faster than the flood of bitops, since
it's 2 atomic instructions only and it only happens in the paths where
the race had a chance to trigger, so all the critical pagecache paths
aren't affected at all anymore by the slowdown.

For the page_alloc.c changes, they must not make a difference so I
backed them out.

Comments welcome, thanks.

side note: this won't break any architectural code.

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
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.4.23pre7/mm/filemap.c race/mm/filemap.c
--- 2.4.23pre7/mm/filemap.c	2003-10-10 08:08:32.000000000 +0200
+++ race/mm/filemap.c	2003-10-11 17:48:32.000000000 +0200
@@ -656,19 +656,10 @@ static inline void __add_to_page_cache(s
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
@@ -690,6 +681,7 @@ int add_to_page_cache_unique(struct page
 	int err;
 	struct page *alias;
 
+	spin_lock(&pagemap_lru_lock);
 	spin_lock(&pagecache_lock);
 	alias = __find_page_nolock(mapping, offset, *hash);
 
@@ -700,6 +692,7 @@ int add_to_page_cache_unique(struct page
 	}
 
 	spin_unlock(&pagecache_lock);
+	spin_unlock(&pagemap_lru_lock);
 	if (!err)
 		lru_cache_add(page);
 	return err;
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

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
