Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275750AbRJFV7Z>; Sat, 6 Oct 2001 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRJFV7Q>; Sat, 6 Oct 2001 17:59:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3336 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275750AbRJFV7H>; Sat, 6 Oct 2001 17:59:07 -0400
Date: Sat, 6 Oct 2001 14:59:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
cc: Simon Kirby <sim@netnation.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11pre4 swapping out all over the place
In-Reply-To: <Pine.LNX.4.33.0110061948280.30116-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.33.0110061457570.1454-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Oct 2001, Tobias Ringstrom wrote:
>
> Sure, replacing try_to_free_pages() in 2.4.11-pre4 with the one in
> 2.4.11-pre3 solves the problem.

Ok, can you try this slightly more involved patch instead? It basically
keeps the old try_to_free_pages() (it _looks_ different, but the logic is
the same), but also should honour the OOM-killer.

		Linus

-----
diff -u --recursive --new-file pre4/linux/mm/oom_kill.c linux/mm/oom_kill.c
--- pre4/linux/mm/oom_kill.c	Thu Oct  4 19:52:11 2001
+++ linux/mm/oom_kill.c	Fri Oct  5 13:13:43 2001
@@ -241,13 +241,12 @@
 		return 0;

 	/*
-	 * If the buffer and page cache (excluding swap cache) are over
+	 * If the buffer and page cache (including swap cache) are over
 	 * their (/proc tunable) minimum, we're still not OOM.  We test
 	 * this to make sure we don't return OOM when the system simply
 	 * has a hard time with the cache.
 	 */
 	cache_mem = atomic_read(&page_cache_size);
-	cache_mem -= swapper_space.nrpages;
 	limit = 2;
 	limit *= num_physpages / 100;

diff -u --recursive --new-file pre4/linux/mm/page_alloc.c linux/mm/page_alloc.c
--- pre4/linux/mm/page_alloc.c	Thu Oct  4 19:52:11 2001
+++ linux/mm/page_alloc.c	Sat Oct  6 14:54:59 2001
@@ -357,6 +357,7 @@

 	/* here we're in the low on memory slow path */

+rebalance:
 	if (current->flags & PF_MEMALLOC) {
 		zone = zonelist->zones;
 		for (;;) {
@@ -371,48 +372,28 @@
 		return NULL;
 	}

- rebalance:
 	page = balance_classzone(classzone, gfp_mask, order, &freed);
 	if (page)
 		return page;

 	zone = zonelist->zones;
-	if (likely(freed)) {
-		for (;;) {
-			zone_t *z = *(zone++);
-			if (!z)
-				break;
+	for (;;) {
+		zone_t *z = *(zone++);
+		if (!z)
+			break;

-			if (zone_free_pages(z, order) > z->pages_min) {
-				page = rmqueue(z, order);
-				if (page)
-					return page;
-			}
-		}
-		goto rebalance;
-	} else {
-		/*
-		 * Check that no other task is been killed meanwhile,
-		 * in such a case we can succeed the allocation.
-		 */
-		for (;;) {
-			zone_t *z = *(zone++);
-			if (!z)
-				break;
-
-			if (zone_free_pages(z, order) > z->pages_min) {
-				page = rmqueue(z, order);
-				if (page)
-					return page;
-			}
+		if (zone_free_pages(z, order) > z->pages_min) {
+			page = rmqueue(z, order);
+			if (page)
+				return page;
 		}
-
-		goto rebalance;
 	}

-	printk(KERN_NOTICE "__alloc_pages: %u-order allocation failed (gfp=0x%x/%i) from %p\n",
-	       order, gfp_mask, !!(current->flags & PF_MEMALLOC), __builtin_return_address(0));
-	return NULL;
+	/* Yield for kswapd, and try again */
+	current->policy |= SCHED_YIELD;
+	__set_current_state(TASK_RUNNING);
+	schedule();
+	goto rebalance;
 }

 /*
diff -u --recursive --new-file pre4/linux/mm/vmscan.c linux/mm/vmscan.c
--- pre4/linux/mm/vmscan.c	Thu Oct  4 19:52:11 2001
+++ linux/mm/vmscan.c	Sat Oct  6 14:54:59 2001
@@ -553,14 +556,16 @@
 int try_to_free_pages(zone_t * classzone, unsigned int gfp_mask, unsigned int order)
 {
 	int ret = 0;
+	int priority = DEF_PRIORITY;
 	int nr_pages = SWAP_CLUSTER_MAX;

-	nr_pages = shrink_caches(DEF_PRIORITY, classzone, gfp_mask, nr_pages);
+	do {
+		nr_pages = shrink_caches(priority, classzone, gfp_mask, nr_pages);
+		if (nr_pages <= 0)
+			return 1;

-	if (nr_pages < SWAP_CLUSTER_MAX)
-		ret |= 1;
-
-	ret |= swap_out(DEF_PRIORITY, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
+		ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
+	} while (--priority);

 	return ret;
 }

