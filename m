Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270580AbTGTALo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 20:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270578AbTGTAKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 20:10:24 -0400
Received: from mailb.telia.com ([194.22.194.6]:45030 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S270572AbTGTAIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 20:08:52 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org> <m2d6g8cg06.fsf@telia.com>
	<20030718032433.4b6b9281.akpm@osdl.org>
	<20030718152205.GA407@elf.ucw.cz> <m2el0nvnhm.fsf@telia.com>
	<20030718094542.07b2685a.akpm@osdl.org> <m2oezrppxo.fsf@telia.com>
	<20030718131527.7cf4ca5e.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 20 Jul 2003 02:22:27 +0200
In-Reply-To: <20030718131527.7cf4ca5e.akpm@osdl.org>
Message-ID: <m2wuee9hdo.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Yup.  Probaby we should not be throttling kswapd if it is making good
> progress, but this needs broad testing and thought.  Something like this,
> untested:
> 
> --- 25/mm/vmscan.c~less-kswapd-throttling	Thu Jul 17 15:35:09 2003
> +++ 25-akpm/mm/vmscan.c	Thu Jul 17 15:35:12 2003
> @@ -930,7 +930,8 @@ static int balance_pgdat(pg_data_t *pgda
>  		}
>  		if (all_zones_ok)
>  			break;
> -		blk_congestion_wait(WRITE, HZ/10);
> +		if (to_free)
> +			blk_congestion_wait(WRITE, HZ/10);
>  	}
>  	return nr_pages - to_free;
>  }
> 
> 
> > Note that I had to use HZ/5 in free_some_memory() or else the loop
> > would terminate too early. The main problem seems to be that
> > balance_pgdat() is too slow when freeing memory. The function can fail
> > to free memory in the inner loop either because the disk is congested
> > or because too few pages are scanned, but in both cases the function
> > calls blk_congestion_wait(), and in the second case the disk may be
> > idle and then blk_congestion_wait() doesn't return until the timeout
> > expires.
> 
> hm, perhaps because kswapd is throttled rather than doing work.
> 
> Try the above change, see if you still need the extended timeout in
> free_some_memory().

I have tried the change, but the writeout is still very slow. (Maybe
somewhat faster than the original code, but far from being limited by
disk bandwidth.)

It turns out the extended timeout in free_some_memory() is needed to
handle things like disk spin up time and thermal recalibration.
Ideally there should not be a timeout at all in that function. It
should wait until the congestion goes away or until all I/O is
finished. But that's probably much harder to implement. Is there some
global counter somewhere that can be used to figure out how many pages
are currently being on their way to the disk?

> Also, play around with using __GFP_WAIT|__GFP_HIGH|__GFP_NORETRY rather
> than GFP_ATOMIC.

I did, without much success.

One thing that does seem to work though, is to only throttle in
balance_pgdat() if we have called writepage() since the last
throttling, like in the patch below. (ugly, writepage_called should
not be a static variable.) With that patch I get full disk bandwidth
speed during page freeing.

Another disturbing thing I've seen is that on one of my machines, the
suspend process sometimes fails to write anything to disk. When this
happens, the suspend will fail if not enough memory is free, and the
machine hangs shortly afterwards. I've seen this with plain
2.6.0-test1 and with all patches I have tested, with and without
preempt. On another laptop, I have never seen this problem. (I'll try
to debug this further, but it is complicated by the fact that the
problematic laptop doesn't have a serial port.)


diff -u -r orig/linux-page/fs/jbd/journal.c linux-page/fs/jbd/journal.c
--- orig/linux-page/fs/jbd/journal.c	Fri Jul 18 21:07:12 2003
+++ linux-page/fs/jbd/journal.c	Sun Jul 20 01:08:56 2003
@@ -132,6 +132,8 @@
 
 	daemonize("kjournald");
 
+	current->flags |= PF_IOTHREAD;
+
 	/* Set up an interval timer which can be used to trigger a
            commit wakeup after the commit interval expires */
 	init_timer(&timer);
diff -u -r orig/linux-page/kernel/suspend.c linux-page/kernel/suspend.c
--- orig/linux-page/kernel/suspend.c	Sat Jul 19 21:07:14 2003
+++ linux-page/kernel/suspend.c	Sun Jul 20 01:17:33 2003
@@ -623,10 +623,32 @@
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
+		page = alloc_page(__GFP_HIGH | __GFP_NOWARN);
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
diff -u -r orig/linux-page/mm/pdflush.c linux-page/mm/pdflush.c
--- orig/linux-page/mm/pdflush.c	Fri Jul 18 21:08:47 2003
+++ linux-page/mm/pdflush.c	Sun Jul 20 01:08:56 2003
@@ -88,7 +88,7 @@
 {
 	daemonize("pdflush");
 
-	current->flags |= PF_FLUSHER;
+	current->flags |= PF_FLUSHER | PF_IOTHREAD;
 	my_work->fn = NULL;
 	my_work->who = current;
 	INIT_LIST_HEAD(&my_work->list);
diff -u -r orig/linux-page/mm/vmscan.c linux-page/mm/vmscan.c
--- orig/linux-page/mm/vmscan.c	Fri Jul 18 21:08:47 2003
+++ linux-page/mm/vmscan.c	Sun Jul 20 01:40:24 2003
@@ -49,6 +49,8 @@
 int vm_swappiness = 60;
 static long total_memory;
 
+static int writepage_called;
+
 #ifdef ARCH_HAS_PREFETCH
 #define prefetch_prev_lru_page(_page, _base, _field)			\
 	do {								\
@@ -339,6 +341,7 @@
 
 				SetPageReclaim(page);
 				res = mapping->a_ops->writepage(page, &wbc);
+				writepage_called = 1;
 
 				if (res == WRITEPAGE_ACTIVATE) {
 					ClearPageReclaim(page);
@@ -894,6 +897,8 @@
 	for (priority = DEF_PRIORITY; priority; priority--) {
 		int all_zones_ok = 1;
 
+		writepage_called = 0;
+
 		for (i = 0; i < pgdat->nr_zones; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_mapped = 0;
@@ -921,7 +926,7 @@
 			if (i < ZONE_HIGHMEM) {
 				reclaim_state->reclaimed_slab = 0;
 				shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
-				to_free += reclaim_state->reclaimed_slab;
+				to_free -= reclaim_state->reclaimed_slab;
 			}
 			if (zone->all_unreclaimable)
 				continue;
@@ -930,7 +935,9 @@
 		}
 		if (all_zones_ok)
 			break;
-		blk_congestion_wait(WRITE, HZ/10);
+//		if (to_free)
+		if (writepage_called)
+			blk_congestion_wait(WRITE, HZ/10);
 	}
 	return nr_pages - to_free;
 }
@@ -976,10 +983,11 @@
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
@@ -987,7 +995,8 @@
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
 		get_page_state(&ps);
-		balance_pgdat(pgdat, 0, &ps);
+		freed = balance_pgdat(pgdat, 0, &ps);
+//		printk("kswapd: freed %d pages\n", freed);
 	}
 }
 
-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
