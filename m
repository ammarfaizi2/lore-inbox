Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTH2D5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 23:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTH2D5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 23:57:32 -0400
Received: from dp.samba.org ([66.70.73.150]:61162 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264379AbTH2D53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 23:57:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Thu, 28 Aug 2003 01:21:52 MST."
             <20030828012152.1294f183.akpm@osdl.org> 
Date: Fri, 29 Aug 2003 13:46:21 +1000
Message-Id: <20030829035729.E126C2C0BD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030828012152.1294f183.akpm@osdl.org> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >  But this means it could be called quite often.
> 
> Moving pages to and from swapcache really is not a fastpath at all,
> so I wouldn't be worrying about that.
> 
> And even if the code is sucky, it will only be sucky when there is a lot of
> swapcache activity AND a lot of futexes are in use.

Well, the patch I posted adds a futex_rehash to ___add_to_page_cache,
which seems to get called more often (ie. even new pages added to the
page cache), but is by far the most logical and simple solution
(ie. where you actually change the mapping, the locking *has* to be
sufficient).

Walking a 256 entry hash table isn't free even if it's empty.  Example
patch below.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Futexes Rehash Optimization
Author: Rusty Russell
Status: Experimental
Depends: Misc/futex-swap.patch.gz

D: The current futex_rehash() call walks the entire hash table, which
D: is slow.  The simplest optimization is to have a page->flags bit
D: which indicates a futex has been placed in this page: we can clear
D: it if futex_rehash() finds no futexes.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5816-2.6.0-test4-bk2-futex-page-bit.pre/include/linux/page-flags.h .5816-2.6.0-test4-bk2-futex-page-bit/include/linux/page-flags.h
--- .5816-2.6.0-test4-bk2-futex-page-bit.pre/include/linux/page-flags.h	2003-06-23 10:52:59.000000000 +1000
+++ .5816-2.6.0-test4-bk2-futex-page-bit/include/linux/page-flags.h	2003-08-29 13:43:32.000000000 +1000
@@ -75,6 +75,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_futexed		20	/* Has/had a futex waiting in it */
 
 
 /*
@@ -267,6 +268,10 @@ extern void get_full_page_state(struct p
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
+#define PageFutexed(page)	test_bit(PG_futexed, &(page)->flags)
+#define SetPageFutexed(page)	set_bit(PG_futexed, &(page)->flags)
+#define ClearPageFutexed(page)	clear_bit(PG_futexed, &(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5816-2.6.0-test4-bk2-futex-page-bit.pre/kernel/futex.c .5816-2.6.0-test4-bk2-futex-page-bit/kernel/futex.c
--- .5816-2.6.0-test4-bk2-futex-page-bit.pre/kernel/futex.c	2003-08-29 13:43:32.000000000 +1000
+++ .5816-2.6.0-test4-bk2-futex-page-bit/kernel/futex.c	2003-08-29 13:43:32.000000000 +1000
@@ -130,6 +131,10 @@ void futex_rehash(struct page *page,
 	static int rehash_count = 0;
 
 	spin_lock_irqsave(&futex_lock, flags);
+	if (likely(!PageFutexed(page)))
+		goto out;
+
+	ClearPageFutexed(page);
 	rehash_count++;
 	for (i = 0; i < 1 << FUTEX_HASHBITS; i++) {
 		struct list_head *l, *next;
@@ -141,6 +145,7 @@ void futex_rehash(struct page *page,
 			if (page_matches(page, q)) {
 				list_del(&q->list);
 				list_add(&q->list, &gather);
+				SetPageFutexed(page);
 				printk("futex_rehash %i: offset %i %p -> %p\n",
 				       rehash_count,
 				       q->offset, page->mapping, new_mapping);
@@ -156,6 +161,7 @@ void futex_rehash(struct page *page,
 		list_add(&q->list,
 			 hash_futex(new_mapping, new_index, page, q->offset));
 	}
+out:
 	spin_unlock_irqrestore(&futex_lock, flags);
 }
 
@@ -348,6 +354,7 @@ static inline void __queue_me(struct fut
 	q->mapping = page->mapping;
 	q->index = page->index;
 	q->page = page;
+	SetPageFutexed(page);
 
 	list_add_tail(&q->list, head);
 	/*
