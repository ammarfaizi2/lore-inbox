Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284914AbRLKHI0>; Tue, 11 Dec 2001 02:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284918AbRLKHIS>; Tue, 11 Dec 2001 02:08:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:64272 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284914AbRLKHIK>; Tue, 11 Dec 2001 02:08:10 -0500
Message-ID: <3C15B0B3.1399043B@zip.com.au>
Date: Mon, 10 Dec 2001 23:07:31 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva> <3C151F7B.44125B1@zip.com.au>,
		<3C151F7B.44125B1@zip.com.au>; from akpm@zip.com.au on Mon, Dec 10, 2001 at 12:47:55PM -0800 <20011211011158.A4801@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Mon, Dec 10, 2001 at 12:47:55PM -0800, Andrew Morton wrote:
> > Marcelo Tosatti wrote:
> > >
> > > Andrea,
> > >
> > > Could you please start looking at any 2.4 VM issues which show up ?
> > >
> >
> > Just fwiw, I did some testing on this yesterday.
> >
> > Buffers and cache data are sitting on the active list, and shrink_caches()
> > is *not* getting them off the active list, and onto the inactive list
> > where they can be freed.
> 
> please check 2.4.17pre4aa1, see the per-classzone info, they will
> prevent all the problems with the refill inactive with highmem.

This is not highmem-related.  But the latest -aa patch does
appear to have fixed this bug.  Stale memory is no longer being
left on the active list, and all buffercache memory is being reclaimed
before the oom-killer kicks in (swapless case).

Also, (and this is in fact the same problem), the patched kernel
has less tendency to push in-use memory out to swap while leaving
tens of megs of old memory on the active list.  This is all good.

Which of your changes has caused this?

Could you please separate this out into one or more specific patches for
the 2.4.17 series?





Why does this code exist at the end of refill_inactive()?

        if (entry != &active_list) {
                list_del(&active_list);
                list_add(&active_list, entry);
        }





This test on a 64 megabyte machine, on ext2:

	time (tar xfz /nfsserver/linux-2.4.16.tar.gz ; sync)

On 2.4.17-pre7 it takes 21 seconds.  On -aa it is much slower: 36 seconds.

This is probably due to the write scheduling changes in fs/buffer.c.
This chunk especially will, under some conditions, cause bdflush
to madly spin in a loop unplugging all the disk queues:

@@ -2787,7 +2795,7 @@
 
                spin_lock(&lru_list_lock);
                if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
-                       wait_for_some_buffers(NODEV);
+                       run_task_queue(&tq_disk);
                        interruptible_sleep_on(&bdflush_wait);
                }
        }

Why did you make this change?





Execution time for `make -j12 bzImage' on a 64meg RAM/512 meg swap
dual x86:

-aa:					4 minutes 20 seconds
2.4.7-pre8				4 minutes 8 seconds
2.4.7-pre8 plus the below patch:	3 minutes 55 seconds

Now it could be that this performance regression is due to the
write merging mistake in fs/buffer.c.  But with so much unrelated
material in the same patch it's hard to pinpoint the source.



--- linux-2.4.17-pre8/mm/vmscan.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/mm/vmscan.c	Mon Dec 10 22:34:18 2001
@@ -537,7 +537,7 @@ static void refill_inactive(int nr_pages
 
 	spin_lock(&pagemap_lru_lock);
 	entry = active_list.prev;
-	while (nr_pages-- && entry != &active_list) {
+	while (nr_pages && entry != &active_list) {
 		struct page * page;
 
 		page = list_entry(entry, struct page, lru);
@@ -551,6 +551,7 @@ static void refill_inactive(int nr_pages
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
 		SetPageReferenced(page);
+		nr_pages--;
 	}
 	spin_unlock(&pagemap_lru_lock);
 }
@@ -561,6 +562,12 @@ static int shrink_caches(zone_t * classz
 	int chunk_size = nr_pages;
 	unsigned long ratio;
 
+	shrink_dcache_memory(priority, gfp_mask);
+	shrink_icache_memory(priority, gfp_mask);
+#ifdef CONFIG_QUOTA
+	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
+#endif
+
 	nr_pages -= kmem_cache_reap(gfp_mask);
 	if (nr_pages <= 0)
 		return 0;
@@ -568,17 +575,13 @@ static int shrink_caches(zone_t * classz
 	nr_pages = chunk_size;
 	/* try to keep the active list 2/3 of the size of the cache */
 	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
+	if (ratio == 0)
+		ratio = nr_pages;
 	refill_inactive(ratio);
 
 	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
 	if (nr_pages <= 0)
 		return 0;
-
-	shrink_dcache_memory(priority, gfp_mask);
-	shrink_icache_memory(priority, gfp_mask);
-#ifdef CONFIG_QUOTA
-	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
-#endif
 
 	return nr_pages;
 }

> ...
> 
> >
> > In my swapless testing, I burnt HUGE amounts of CPU in flush_tlb_others().
> > So we're madly trying to swap pages out and finding that there's no swap
> > space.  I beleive that when we find there's no swap left we should move
> > the page onto the active list so we don't keep rescanning it pointlessly.
> 
> yes, however I think the swap-flood with no swap isn't a very
> interesting case to optimize.

Running swapless is a valid configuration, and the kernel is doing
great amounts of pointless work.  I would expect a diskless workstation
to suffer from this.  The problem remains in latest -aa.  It would be
useful to find a fix.
 
> 
> I don't have any pending bug report. AFIK those bugs are only in
> mainline. If you can reproduce with -aa please send me a bug report.
> thanks,

Bugs which are only fixed in -aa aren't much use to anyone.

The VM code lacks comments, and nobody except yourself understands
what it is supposed to be doing.  That's a bug, don't you think?

-
