Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWCaMgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWCaMgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWCaMgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:36:49 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:35915 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1751367AbWCaMgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:36:48 -0500
Date: Fri, 31 Mar 2006 14:36:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-ID: <20060331123622.GB18093@opteron.random>
References: <43C484BF.2030602@yahoo.com.au> <20060111082359.GV15897@opteron.random> <20060111005134.3306b69a.akpm@osdl.org> <20060111090225.GY15897@opteron.random> <20060111010638.0eb0f783.akpm@osdl.org> <20060111091327.GZ15897@opteron.random> <Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com> <43C75834.3040007@yahoo.com.au> <20060112234726.676c3873.akpm@osdl.org> <43C782F3.1090803@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C782F3.1090803@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 09:37:39PM +1100, Nick Piggin wrote:
> Andrew Morton wrote:
> >Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >>(I guess reclaim might be one, but quite rare -- any other significant
> >>lock_page users that we might hit?)
> >
> >
> >The only time 2.6 holds lock_page() for a significant duration is when
> >bringing the page uptodate with readpage or memset.
> >
> 
> Yes that's what I thought. And we don't really need to worry about this
> case because filemap_nopage has to deal with it anyway (ie. we shouldn't
> see a locked !uptodate page in do_no_page).
> 
> >The scalability risk here is 100 CPUs all faulting in the same file in the
> >same pattern.  Like the workload which caused the page_table_lock splitup
> >(that was with anon pages).  All the CPUs could pretty easily get into sync
> >and start arguing over every single page's lock.
> >
> 
> Yes, but in that case they're still going to hit the tree_lock anyway, and
> if they do have a chance of synching up, the cacheline bouncing from count
> and mapcount accounting is almost as likely to cause it as the lock_page
> itself.
> 
> I did a nopage microbenchmark like you describe a while back. IIRC single
> threaded is 2.5 times *more* throughput than 64 CPUs, even when those 64 are
> faulting their own NUMA memory (and obviously different pages). Thanks to
> tree_lock.

This is the discussed patch that fixes the smp race between do_no_page
and invalidate_inode_pages2.

As a reminder the race has seen the light of the day when
invalidate_inode_pages2 started dropping pages from the pagecache
without verifying that their page_count was 1 (i.e. only in pagecache)
while keeping the tree_lock held (that's what shrink_list does). In the
past (including 2.4) to implement invalidate_inode_pages2 we were
clearing only the PG_uptdate/PG_dirty bitflags while leaving the page in
pagecache exactly to avoid breaking such invariant. But that was
allowing not uptodate pagecache to be mapped in userland. Now instead we
enforced a new invariant that mapped pagecache has to be uptodate, so
we've to add synchronization between invalidate_inode_pages2 and
do_no_page using something else and not only the tree_lock + page_count.

Without this patch some pages could be mapped in userland without being
part of pagecache and without being freeable as well despite being part
of regular filebacked vmas. This was triggering crashes with sles9 after
the last invalidate_inode_pages2 from mainline, because of the more
restrictive checks with bug-ons in page_add_file_rmap equivalalents that
requried page->mapping not to be null for pagecache. It looks inferior
that you increase page->mapcount for things like the zeropage in
mainline, instead of making sure to add only filebacked pages in the
rmap layer and so verifying explicitly that page->mapping is not null in
page_add_file_rmap.

The new PG_truncate bitflag can be used as well to eliminate the
truncate_count from all vmas etc... that would save substantial memory
and remove some complexity, truncate_count grown a lot since the time we
introduced it.

The PG_truncate is needed as well because we can't know in do_no_page if
page->mapping is legitimate null or not (think bttv and other device
drivers returning page->mapping null because they're private but not
reserved pages etc..)

From: Andrea Arcangeli <andrea@suse.de>
Subject: avoid race between invalidate_inode_pages2 and do_no_page

Use page lock and new bitflag to serialize.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

 include/linux/page-flags.h |    6 ++++++
 mm/memory.c                |   18 ++++++++++++++++++
 mm/page_alloc.c            |    4 ++++
 mm/truncate.c              |    8 ++++++++
 4 files changed, 36 insertions(+)

--- linux-2.6-1/include/linux/page-flags.h	2006-03-29 19:10:03.000000000 +0200
+++ linux-2.6-2/include/linux/page-flags.h	2006-03-30 19:16:29.000000000 +0200
@@ -76,6 +76,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#define PG_truncate		20	/* Pagecache has been truncated/invalidated */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -330,6 +332,10 @@ extern void __mod_page_state_offset(unsi
 #define __SetPageCompound(page)	__set_bit(PG_compound, &(page)->flags)
 #define __ClearPageCompound(page) __clear_bit(PG_compound, &(page)->flags)
 
+#define PageTruncate(page)	test_bit(PG_truncate, &(page)->flags)
+#define SetPageTruncate(page)	set_bit(PG_truncate, &(page)->flags)
+#define ClearPageTruncate(page)	clear_bit(PG_truncate, &(page)->flags)
+
 #ifdef CONFIG_SWAP
 #define PageSwapCache(page)	test_bit(PG_swapcache, &(page)->flags)
 #define SetPageSwapCache(page)	set_bit(PG_swapcache, &(page)->flags)
--- linux-2.6-1/mm/memory.c	2006-03-29 19:10:04.000000000 +0200
+++ linux-2.6-2/mm/memory.c	2006-03-30 20:14:58.000000000 +0200
@@ -2088,6 +2088,14 @@ retry:
 		anon = 1;
 	}
 
+	lock_page(new_page);
+	if (unlikely(PageTruncate(new_page))) {
+		unlock_page(new_page);
+		page_cache_release(new_page);
+		BUG_ON(!mapping);
+		cond_resched();
+		goto retry;
+	}
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	/*
 	 * For a file-backed vma, someone could have truncated or otherwise
@@ -2096,6 +2104,7 @@ retry:
 	 */
 	if (mapping && unlikely(sequence != mapping->truncate_count)) {
 		pte_unmap_unlock(page_table, ptl);
+		unlock_page(new_page);
 		page_cache_release(new_page);
 		cond_resched();
 		sequence = mapping->truncate_count;
@@ -2128,7 +2137,9 @@ retry:
 			inc_mm_counter(mm, file_rss);
 			page_add_file_rmap(new_page);
 		}
+		unlock_page(new_page);
 	} else {
+		unlock_page(new_page);
 		/* One of our sibling threads was faster, back out. */
 		page_cache_release(new_page);
 		goto unlock;
--- linux-2.6-1/mm/page_alloc.c	2006-03-29 19:10:04.000000000 +0200
+++ linux-2.6-2/mm/page_alloc.c	2006-03-30 20:03:42.000000000 +0200
@@ -148,6 +148,7 @@ static void bad_page(struct page *page)
 			1 << PG_locked	|
 			1 << PG_active	|
 			1 << PG_dirty	|
+			1 << PG_truncate	|
 			1 << PG_reclaim |
 			1 << PG_slab    |
 			1 << PG_swapcache |
@@ -380,6 +381,8 @@ static inline int free_pages_check(struc
 		bad_page(page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
+	if (PageTruncate(page))
+		ClearPageTruncate(page);
 	/*
 	 * For now, we report if PG_reserved was found set, but do not
 	 * clear it, and do not free the page.  But we shall soon need
@@ -520,6 +523,7 @@ static int prep_new_page(struct page *pa
 			1 << PG_locked	|
 			1 << PG_active	|
 			1 << PG_dirty	|
+			1 << PG_truncate	|
 			1 << PG_reclaim	|
 			1 << PG_slab    |
 			1 << PG_swapcache |
--- linux-2.6-1/mm/truncate.c	2006-02-24 04:36:27.000000000 +0100
+++ linux-2.6-2/mm/truncate.c	2006-03-30 19:15:33.000000000 +0200
@@ -78,6 +78,14 @@ invalidate_complete_page(struct address_
 	write_unlock_irq(&mapping->tree_lock);
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
+	/*
+	 * After page truncate is set we must guarantee that
+	 * a new radix tree lookup won't find the same PG_truncate
+	 * page again. The __remove_from_page_cache has taken
+	 * care to provide this guarantee. Of course PG_truncate
+	 * can be changed only under the page_lock().
+	 */
+	SetPageTruncate(page);
 	return 1;
 }
 
