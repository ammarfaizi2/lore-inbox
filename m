Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270335AbTGRTo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270319AbTGRTo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:44:27 -0400
Received: from mailg.telia.com ([194.22.194.26]:24783 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S270345AbTGRToC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:44:02 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org> <m2d6g8cg06.fsf@telia.com>
	<20030718032433.4b6b9281.akpm@osdl.org>
	<20030718152205.GA407@elf.ucw.cz> <m2el0nvnhm.fsf@telia.com>
	<20030718094542.07b2685a.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 18 Jul 2003 21:58:43 +0200
In-Reply-To: <20030718094542.07b2685a.akpm@osdl.org>
Message-ID: <m2oezrppxo.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > I tried the patch below, but it didn't work. Nothing (or very little)
> > was swapped out to disk. I also tried using GFP_KERNEL, but that
> > seemed to cause a deadlock. (Maybe it would have gone OOM if I had
> > waited long enough). I think the problem is that pdflush and friends
> > are already frozen when this code runs.
> 
> Oh, we shouldn't be doing this sort of thing when the kernel threads are
> refrigerated.  We do need kswapd services for the trick you tried.
> 
> And all flavours of ext3_writepage() can block on kjournald activity, so if
> kjournald is refrigerated during the memory shrink the machine can deadlock.
> 
> It would be much better to freeze kernel threads _after_ doing the big
> memory shrink.

The patch below works, but doesn't really solve anything, because it
is just as slow as the original code. This is not surprising because
it is still balance_pgdat() that does the page freeing, the only
difference being that it is now called from kswapd which is woken up
by the alloc_page() call.

Note that I had to use HZ/5 in free_some_memory() or else the loop
would terminate too early. The main problem seems to be that
balance_pgdat() is too slow when freeing memory. The function can fail
to free memory in the inner loop either because the disk is congested
or because too few pages are scanned, but in both cases the function
calls blk_congestion_wait(), and in the second case the disk may be
idle and then blk_congestion_wait() doesn't return until the timeout
expires.

diff -u -r -N linux-p0/fs/jbd/journal.c linux-p1/fs/jbd/journal.c
--- linux-p0/fs/jbd/journal.c	Fri Jul 18 21:07:12 2003
+++ linux-p1/fs/jbd/journal.c	Fri Jul 18 21:13:15 2003
@@ -132,6 +132,8 @@
 
 	daemonize("kjournald");
 
+	current->flags |= PF_IOTHREAD;
+
 	/* Set up an interval timer which can be used to trigger a
            commit wakeup after the commit interval expires */
 	init_timer(&timer);
diff -u -r -N linux-p0/kernel/suspend.c linux-p1/kernel/suspend.c
--- linux-p0/kernel/suspend.c	Fri Jul 18 21:08:45 2003
+++ linux-p1/kernel/suspend.c	Fri Jul 18 21:13:18 2003
@@ -621,10 +621,32 @@
  */
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
+	LIST_HEAD(list);
+	struct page *page, *tmp;
+	int sleep_count = 0;
+	int i = 0;
+
+	while (sleep_count < 10) {
+		page = alloc_page(GFP_ATOMIC);
+		if (page) {
+			list_add(&page->list, &list);
+			sleep_count = 0;
+		} else {
+			blk_congestion_wait(WRITE, HZ/5);
+			sleep_count++;
+		}
+		i++;
+		if (!(i%1000))
+			printk(".");
+	}
 	printk("|\n");
+
+	i = 0;
+	list_for_each_entry_safe(page, tmp, &list, list) {
+		__free_page(page);
+		i++;
+	}
+	printk("%d pages freed\n", i);
 }
 
 /* Make disk drivers accept operations, again */
diff -u -r -N linux-p0/mm/pdflush.c linux-p1/mm/pdflush.c
--- linux-p0/mm/pdflush.c	Fri Jul 18 21:08:47 2003
+++ linux-p1/mm/pdflush.c	Fri Jul 18 21:13:20 2003
@@ -88,7 +88,7 @@
 {
 	daemonize("pdflush");
 
-	current->flags |= PF_FLUSHER;
+	current->flags |= PF_FLUSHER | PF_IOTHREAD;
 	my_work->fn = NULL;
 	my_work->who = current;
 	INIT_LIST_HEAD(&my_work->list);
diff -u -r -N linux-p0/mm/vmscan.c linux-p1/mm/vmscan.c
--- linux-p0/mm/vmscan.c	Fri Jul 18 21:08:47 2003
+++ linux-p1/mm/vmscan.c	Fri Jul 18 21:13:22 2003
@@ -921,7 +921,7 @@
 			if (i < ZONE_HIGHMEM) {
 				reclaim_state->reclaimed_slab = 0;
 				shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
-				to_free += reclaim_state->reclaimed_slab;
+				to_free -= reclaim_state->reclaimed_slab;
 			}
 			if (zone->all_unreclaimable)
 				continue;
@@ -976,10 +976,11 @@
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
+	tsk->flags |= PF_MEMALLOC|PF_KSWAPD|PF_IOTHREAD;
 
 	for ( ; ; ) {
 		struct page_state ps;
+		int freed;
 
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
@@ -987,7 +988,8 @@
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
 		get_page_state(&ps);
-		balance_pgdat(pgdat, 0, &ps);
+		freed = balance_pgdat(pgdat, 0, &ps);
+		printk("kswapd: freed %d pages\n", freed);
 	}
 }
 
-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
