Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272545AbRH3X57>; Thu, 30 Aug 2001 19:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272558AbRH3X5v>; Thu, 30 Aug 2001 19:57:51 -0400
Received: from mailb.telia.com ([194.22.194.6]:26119 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S272545AbRH3X5l>;
	Thu, 30 Aug 2001 19:57:41 -0400
Message-Id: <200108302357.BAA11235@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: [PATCH] __alloc_pages cleanup -R6 Was: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Fri, 31 Aug 2001 01:53:24 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com> <20010829232929Z16206-32383+2351@humbolt.nl.linux.org> <20010830164634.3706d8f8.skraw@ithnet.com>
In-Reply-To: <20010830164634.3706d8f8.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A new version of the __alloc_pages{_limit} cleanup.
This time for 2.4.10-pre2

Some ideas implemented in this code:
* Reserve memory below min for atomic and recursive allocations.
* When being min..low on free pages, free one more than you want to allocate.
* When being low..high on free pages, free one less than wanted.
* When above high - don't free anything.
* First select zones with more than high free memory.
* Then those with more than high 'free + inactive_clean - inactive_target'
* When freeing - do it properly. Don't steal direct reclaimed pages
(questionable due to locking issues on SMP)
This will "regulate" the number of FREE_PAGES towards the PAGES_LOW.
Possibility for success of an atomic high order alloc is in some way 
proportional with number of pages free.

I have not been able to notice any performance degradation with this
patch. But I do not have a SMP PC...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden


*******************************************
Patch prepared by: roger.larsson@norran.net
Name of file: /home/roger/patches/patch-2.4.10-pre2-alloc_pages_limit-R6b

--- linux/mm/page_alloc.c.orig	Thu Aug 30 23:20:01 2001
+++ linux/mm/page_alloc.c	Fri Aug 31 00:56:20 2001
@@ -212,9 +212,13 @@
 	return NULL;
 }
 
-#define PAGES_MIN	0
-#define PAGES_LOW	1
-#define PAGES_HIGH	2
+#define PAGES_MEMALLOC    0
+#define PAGES_CRITICAL    1
+#define PAGES_MIN_FREE	  2
+#define PAGES_NORMAL_FREE 3
+#define PAGES_HIGH_FREE   4
+#define PAGES_HIGH        5
+#define PAGES_INACTIVE_TARGET    6
 
 /*
  * This function does the dirty work for __alloc_pages
@@ -228,7 +232,7 @@
 
 	for (;;) {
 		zone_t *z = *(zone++);
-		unsigned long water_mark;
+		unsigned long water_mark, free_min, pages_to_reclaim;
 
 		if (!z)
 			break;
@@ -239,26 +243,85 @@
 		 * We allocate if the number of free + inactive_clean
 		 * pages is above the watermark.
 		 */
+
+		free_min = z->pages_min;
+
+
 		switch (limit) {
+			case PAGES_MEMALLOC:
+				free_min = 1;
+				water_mark = 0; /* there might be inactive_clean pages */
+				break;
+			case PAGES_CRITICAL:
+				/* XXX: is pages_min/4 a good amount to reserve for this? */
+				free_min = water_mark = z->pages_min / 4;
+				break;
 			default:
-			case PAGES_MIN:
+				printk(KERN_ERR 
+				       "__alloc_pages_limit unknown limit (%d) using default\n",
+				       limit);
+			case PAGES_MIN_FREE:
 				water_mark = z->pages_min;
 				break;
-			case PAGES_LOW:
-				water_mark = z->pages_low;
+			case PAGES_NORMAL_FREE:
+				water_mark = (z->pages_min + z->pages_low) / 2;
 				break;
-			case PAGES_HIGH:
+			case PAGES_INACTIVE_TARGET:
+				water_mark = z->pages_high +
+					inactive_target -  z->inactive_clean_pages;
+				break;
+			case PAGES_HIGH_FREE:
 				water_mark = z->pages_high;
+				break;
+			case PAGES_HIGH:
+				water_mark = z->pages_high - z->inactive_clean_pages;
+				break;
 		}
 
-		if (z->free_pages + z->inactive_clean_pages >= water_mark) {
-			struct page *page = NULL;
-			/* If possible, reclaim a page directly. */
-			if (direct_reclaim)
-				page = reclaim_page(z);
-			/* If that fails, fall back to rmqueue. */
-			if (!page)
-				page = rmqueue(z, order);
+
+
+		if (z->free_pages < water_mark) 
+			continue;
+		
+
+		/*
+		 * Reclaim a page from the inactive_clean list.
+		 * low water mark. Free all reclaimed pages to
+		 * give them a chance to merge to higher orders.
+		 */
+		if (direct_reclaim) {
+			/* Our goal for free pages is z->pages_low
+			 * if there are less try to free one more than needed
+			 * when more, free one less
+			 */
+			pages_to_reclaim = 1 << order; /* pages to try to reclaim at free_pages 
level */
+			if (z->free_pages < z->pages_low)
+				pages_to_reclaim++;
+			else if (z->free_pages < z->pages_high)
+				pages_to_reclaim--;
+			else /* free >= high */
+				pages_to_reclaim = 0;
+
+			while (z->inactive_clean_pages &&
+			       (z->free_pages < z->pages_min ||
+				pages_to_reclaim--)) { /* note: lazy evaluation! decr. only when free > 
min */ 
+				struct page *reclaim = reclaim_page(z);
+				if (reclaim) {
+					__free_page(reclaim);
+				}
+				else {
+					if (z->inactive_clean_pages > 0)
+						printk(KERN_ERR "reclaim_pages failed but there are 
inactive_clean_pages\n");
+
+					break;
+				}
+			}
+		}
+				
+		/* Always alloc via rmqueue */
+		if (z->free_pages >= free_min)
+		{
+			struct page *page = rmqueue(z, order);
 			if (page)
 				return page;
 		}
@@ -268,6 +331,7 @@
 	return NULL;
 }
 
+
 #ifndef CONFIG_DISCONTIGMEM
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned long order)
 {
@@ -281,7 +345,6 @@
  */
 struct page * __alloc_pages(unsigned int gfp_mask, unsigned long order, 
zonelist_t *zonelist)
 {
-	zone_t **zone;
 	int direct_reclaim = 0;
 	struct page * page;
 
@@ -291,6 +354,14 @@
 	memory_pressure++;
 
 	/*
+	 * To get a hint on who is requesting higher order atomically.
+	 */
+	if (order > 0 && !(gfp_mask & __GFP_WAIT)) {
+		printk("%s; __alloc_pages(gfp=0x%x, order=%ld, ...)\n", current->comm, 
gfp_mask, order);
+		show_trace(NULL);
+	}
+	  
+	/*
 	 * (If anyone calls gfp from interrupts nonatomically then it
 	 * will sooner or later tripped up by a schedule().)
 	 *
@@ -299,70 +370,69 @@
 	 */
 
 	/*
-	 * Can we take pages directly from the inactive_clean
-	 * list?
-	 */
-	if (order == 0 && (gfp_mask & __GFP_WAIT))
-		direct_reclaim = 1;
-
-try_again:
-	/*
 	 * First, see if we have any zones with lots of free memory.
 	 *
 	 * We allocate free memory first because it doesn't contain
 	 * any data ... DUH!
 	 */
-	zone = zonelist->zones;
-	for (;;) {
-		zone_t *z = *(zone++);
-		if (!z)
-			break;
-		if (!z->size)
-			BUG();
+	page = __alloc_pages_limit(zonelist, order, PAGES_HIGH_FREE, 0);
+	if (page)
+		return page;
 
-		if (z->free_pages >= z->pages_low) {
-			page = rmqueue(z, order);
-			if (page)
-				return page;
-		} else if (z->free_pages < z->pages_min &&
-					waitqueue_active(&kreclaimd_wait)) {
-				wake_up_interruptible(&kreclaimd_wait);
-		}
-	}
+	/*
+	 * Can we take pages directly from the inactive_clean
+	 * list? __alloc_pages_limit now handles any 'order'.
+	 */
+	if (gfp_mask & __GFP_WAIT)
+		direct_reclaim = 1;
+
+	/* Lots of free and inactive memory? i.e. more than target for
+	 * the next second.
+	 */
+	page = __alloc_pages_limit(zonelist, order, PAGES_INACTIVE_TARGET, 
direct_reclaim);
+	if (page)
+		return page;
 
 	/*
-	 * Try to allocate a page from a zone with a HIGH
-	 * amount of free + inactive_clean pages.
+	 * Hmm. Too few pages inactive to reach our inactive_target.
+	 *
+	 * We wake up kswapd, in the hope that kswapd will
+	 * resolve this situation before memory gets tight.
 	 *
-	 * If there is a lot of activity, inactive_target
-	 * will be high and we'll have a good chance of
-	 * finding a page using the HIGH limit.
 	 */
+
+	wakeup_kswapd();
+
+
 	page = __alloc_pages_limit(zonelist, order, PAGES_HIGH, direct_reclaim);
 	if (page)
 		return page;
 
 	/*
-	 * Then try to allocate a page from a zone with more
-	 * than zone->pages_low free + inactive_clean pages.
+	 * Then try to allocate a page from a zone with slightly less
+	 * than zone->pages_low free pages. Since this is the goal
+	 * of free pages this alloc will dynamically change among
+	 * zones.
 	 *
 	 * When the working set is very large and VM activity
 	 * is low, we're most likely to have our allocation
 	 * succeed here.
 	 */
-	page = __alloc_pages_limit(zonelist, order, PAGES_LOW, direct_reclaim);
+try_again:
+	page = __alloc_pages_limit(zonelist, order, PAGES_NORMAL_FREE, 
direct_reclaim);
 	if (page)
 		return page;
 
-	/*
-	 * OK, none of the zones on our zonelist has lots
-	 * of pages free.
-	 *
-	 * We wake up kswapd, in the hope that kswapd will
-	 * resolve this situation before memory gets tight.
-	 *
-	 * We also yield the CPU, because that:
-	 * - gives kswapd a chance to do something
+
+	/* "all" zones has less than NORMAL free, i.e. our reclaiming in 
__alloc_pages_limit
+	 * has not kept up with demand, possibly too few allocs with reclaim
+	 */
+	if (waitqueue_active(&kreclaimd_wait)) {
+		wake_up_interruptible(&kreclaimd_wait);
+	}
+
+	/* We also yield the CPU, because that:
+	 * - gives kswapd and kreclaimd a chance to do something
 	 * - slows down allocations, in particular the
 	 *   allocations from the fast allocator that's
 	 *   causing the problems ...
@@ -371,13 +441,13 @@
 	 * - if we don't have __GFP_IO set, kswapd may be
 	 *   able to free some memory we can't free ourselves
 	 */
-	wakeup_kswapd();
 	if (gfp_mask & __GFP_WAIT) {
 		__set_current_state(TASK_RUNNING);
 		current->policy |= SCHED_YIELD;
 		schedule();
 	}
 
+
 	/*
 	 * After waking up kswapd, we try to allocate a page
 	 * from any zone which isn't critical yet.
@@ -385,7 +455,7 @@
 	 * Kswapd should, in most situations, bring the situation
 	 * back to normal in no time.
 	 */
-	page = __alloc_pages_limit(zonelist, order, PAGES_MIN, direct_reclaim);
+	page = __alloc_pages_limit(zonelist, order, PAGES_MIN_FREE, direct_reclaim);
 	if (page)
 		return page;
 
@@ -398,40 +468,21 @@
 	 * - we're /really/ tight on memory
 	 * 	--> try to free pages ourselves with page_launder
 	 */
-	if (!(current->flags & PF_MEMALLOC)) {
+	if (!(current->flags & PF_MEMALLOC) &&
+	    (gfp_mask & __GFP_WAIT)) { /* implies direct_reclaim==1 */
 		/*
-		 * Are we dealing with a higher order allocation?
-		 *
-		 * Move pages from the inactive_clean to the free list
-		 * in the hope of creating a large, physically contiguous
-		 * piece of free memory.
+		 * Move pages from the inactive_dirty to the inactive_clean
 		 */
-		if (order > 0 && (gfp_mask & __GFP_WAIT)) {
-			zone = zonelist->zones;
-			/* First, clean some dirty pages. */
-			current->flags |= PF_MEMALLOC;
-			page_launder(gfp_mask, 1);
-			current->flags &= ~PF_MEMALLOC;
-			for (;;) {
-				zone_t *z = *(zone++);
-				if (!z)
-					break;
-				if (!z->size)
-					continue;
-				while (z->inactive_clean_pages) {
-					struct page * page;
-					/* Move one page to the free list. */
-					page = reclaim_page(z);
-					if (!page)
-						break;
-					__free_page(page);
-					/* Try if the allocation succeeds. */
-					page = rmqueue(z, order);
-					if (page)
-						return page;
-				}
-			}
-		}
+
+		/* First, clean some dirty pages. */
+		current->flags |= PF_MEMALLOC;
+		page_launder(gfp_mask, 1);
+		current->flags &= ~PF_MEMALLOC;
+
+		page = __alloc_pages_limit(zonelist, order, PAGES_MIN_FREE, 
direct_reclaim); 
+		if (page)
+			return page;
+
 		/*
 		 * When we arrive here, we are really tight on memory.
 		 * Since kswapd didn't succeed in freeing pages for us,
@@ -447,22 +498,23 @@
 		 * any progress freeing pages, in that case it's better
 		 * to give up than to deadlock the kernel looping here.
 		 */
-		if (gfp_mask & __GFP_WAIT) {
-			if (!order || free_shortage()) {
-				int progress = try_to_free_pages(gfp_mask);
-				if (progress || (gfp_mask & __GFP_FS))
-					goto try_again;
-				/*
-				 * Fail in case no progress was made and the
-				 * allocation may not be able to block on IO.
-				 */
-				return NULL;
-			}
+		if (!order || free_shortage()) {
+			int progress = try_to_free_pages(gfp_mask);
+			if (progress || (gfp_mask & __GFP_FS))
+				goto try_again;
 		}
+
+		/*
+		 * Fail in case no further progress can be made.
+		 */
+		return NULL;
 	}
 
 	/*
-	 * Final phase: allocate anything we can!
+	 * Final phase: atomic and recursive only - allocate anything we can!
+	 *
+	 * Note: very high order allocs are not that important and are unlikely
+	 * to succeed with this anyway.
 	 *
 	 * Higher order allocations, GFP_ATOMIC allocations and
 	 * recursive allocations (PF_MEMALLOC) end up here.
@@ -471,39 +523,18 @@
 	 * in the system, otherwise it would be just too easy to
 	 * deadlock the system...
 	 */
-	zone = zonelist->zones;
-	for (;;) {
-		zone_t *z = *(zone++);
-		struct page * page = NULL;
-		if (!z)
-			break;
-		if (!z->size)
-			BUG();
-
-		/*
-		 * SUBTLE: direct_reclaim is only possible if the task
-		 * becomes PF_MEMALLOC while looping above. This will
-		 * happen when the OOM killer selects this task for
-		 * instant execution...
-		 */
-		if (direct_reclaim) {
-			page = reclaim_page(z);
-			if (page)
-				return page;
-		}
-
-		/* XXX: is pages_min/4 a good amount to reserve for this? */
-		if (z->free_pages < z->pages_min / 4 &&
-				!(current->flags & PF_MEMALLOC))
-			continue;
-		page = rmqueue(z, order);
-		if (page)
-			return page;
-	}
-
+ 	page = __alloc_pages_limit(zonelist, order,
+ 				   current->flags & PF_MEMALLOC 
+				   ? PAGES_MEMALLOC : PAGES_CRITICAL,
+ 				   direct_reclaim); 
+ 	if (page)
+ 		return page;
+  
 	/* No luck.. */
-	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed 
(gfp=0x%x/%i).\n",
-		order, gfp_mask, !!(current->flags & PF_MEMALLOC));
+	printk(KERN_ERR
+	       "%s; __alloc_pages: %lu-order allocatioa failed. (gfp=0x%x/%d)\n",
+	       current->comm, order, gfp_mask,
+	       !!(current->flags & PF_MEMALLOC));
 	return NULL;
 }
 
