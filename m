Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUKOALQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUKOALQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 19:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUKOALQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 19:11:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45233 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261380AbUKOAK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 19:10:28 -0500
Date: Sun, 14 Nov 2004 18:21:55 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Chris Ross <chris@tebibyte.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Nick Piggin <piggin@cyberone.com.au>,
       Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de,
       akpm@osdl.org
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041114202155.GB2764@logos.cnet>
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114170339.GB13733@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Sun, Nov 14, 2004 at 06:03:39PM +0100, Andrea Arcangeli wrote:
> On Sun, Nov 14, 2004 at 07:44:17AM -0200, Marcelo Tosatti wrote:
> > Well, I'll wait for your correct and definitive approach.
> 
> I doubt my patch will be definitive and you're welcome to keep hacking
> without waiting ;). There are various problems, one issue is the
> try_to_free_pages side, the other severe and obvious bug is the
> invocation of the oom killer in vmscan.c that cannot know if enough
> memory is already free via racing tasks (like other context and like
> kswapd).
> 
> I'm looking at the latter first since that is easy to fix, but as you
> said the zone->all_unreclaimable is hard and it may be buggy too, so I
> doubt my fix will be definitive ;) but it'll worth a try. Feel free to
> work on the zone->all_unreclaimable for example.
> 
> Especially the fact your patch didn't help make me think my firts patch
> also won't fix it and we'll have to look into the try_to_free_pages
> internals to fix it completely.

I'm not sure about Chris's case - Nick mentions that the corrupt perzone 
accounting freepage bug might be interfering with the system. 

If its not the case, increasing the all_unreclaimable "timer" to a higher value
than 5 seconds will certainly delay the OOM killer such to a point where 
its not triggered until the VM reclaiming efforts make progress.


> My patch compared to yours will only save .text/.data/.bss bloat (i.e.
> the opposite of what Martin was worried about) to avoid message passing
> via global variable w/o locks from task context to kswapd.
> 
> Chris, since you can reproduce so easily, could you try a `vmstat 1`
> while the oom killing happens, and can you post it?

Chris, can you change the "500*HZ" in mm/vmscan.c balance_pgdat() function
to "1000*HZ" and see what you get, please?

> We've also to differentiate between true early-oom kills, and genuine
> oom-kills. The oom killing triggering is not always by mistake ;). Chris
> if you could post the vmstat 1 that would help to be sure it's really a
> kernel bug (if you already posted it in another thread just let me know
> and I'll search for such an email ;). Thanks!

This uncompiled/untested patch moves OOM killer call to page_alloc.c as you
strongly advocates.

It changes shrink_caches() to return 1 if it has scanned all zones which are 
part of the allocation zonelist. That is, it will only return 1 if all eligible 
zones do _NOT_ have zone->all_unreclaimable set.

try_to_free_pages() then uses the return value from shrink_caches() and
gfp_mask's GFP_FS capability (meaning the task can writeout data) to 
decide if it should return "-2" (just a magic value meaning 
"we have scanned all eligible zones down to priority zero without 
success"). 

This magic return value from "try_to_free_pages()" is the indicator
that the allocator can trigger the OOM killer because it tried "hard
enough" to free pages.

This has to work in combination with the all_unreclaimable timer 
(which turns off zone->all_unreclaimable after a certain period its in place).

The problem is that kswapd can turn all_unreclaimable ON again 
in the meantime on any of the zonelist's zone's

	if (zone->pages_scanned >= (zone->nr_active + zone->nr_inactive) * 4)
		zone->all_unreclaimable = 1;

which in turn can make shrink_caches() not return 1, meaning OOM killer 
will fail to be triggered.

See the problem ? 

We need some way to account for per-zone page reclaiming efforts globally and 
not thread localized, so to reliably detect per-zone OOM. 

Such accounting would make reliable OOM decision possible with 
both multiple reclaiming threads _and_ perzone all_unreclaimable logic.

The easy alternative is to assume kswapd will detect OOM reliably (which 
is what I've tried). But can not be always true as you have have noted.

Its not trivial but we will get it right.

Are you guys following me or I'm flying high alone here?

--- vmscan.c.ori	2004-11-14 19:51:30.572496864 -0200
+++ vmscan.c	2004-11-14 20:04:38.022786224 -0200
@@ -854,10 +854,11 @@
  * If a zone is deemed to be full of pinned pages then just give it a light
  * scan then give up on it.
  */
-static void
+static int
 shrink_caches(struct zone **zones, struct scan_control *sc)
 {
 	int i;
+	int scanned_all = 1;
 
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
@@ -872,11 +873,15 @@
 		if (zone->prev_priority > sc->priority)
 			zone->prev_priority = sc->priority;
 
-		if (zone->all_unreclaimable && sc->priority != DEF_PRIORITY)
+		if (zone->all_unreclaimable && sc->priority != DEF_PRIORITY) {
+			scanned_all = 0;
 			continue;	/* Let kswapd poll it */
+		}
 
 		shrink_zone(zone, sc);
 	}
+
+	return scanned_all;
 }
  
 /*
@@ -901,7 +906,7 @@
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	unsigned long lru_pages = 0;
-	int i;
+	int i, scanned_all;
 
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
@@ -923,7 +928,7 @@
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
-		shrink_caches(zones, &sc);
+		scanned_all = shrink_caches(zones, &sc);
 		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
@@ -952,8 +957,8 @@
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory(gfp_mask);
+	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY) && scanned_all)
+		ret = -2;
 out:
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];
--- page_alloc.c.orig	2004-11-14 19:50:54.536975096 -0200
+++ page_alloc.c	2004-11-14 20:11:37.254053384 -0200
@@ -773,6 +773,7 @@
 	int alloc_type;
 	int do_retry;
 	int can_try_harder;
+	int reclaim_failure;
 
 	might_sleep_if(wait);
 
@@ -857,7 +858,8 @@
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	try_to_free_pages(zones, gfp_mask, order);
+	if (try_to_free_pages(zones, gfp_mask, order) == -2)
+		reclaim_failure = 1;
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
@@ -892,6 +894,8 @@
 			do_retry = 1;
 	}
 	if (do_retry) {
+		if (reclaim_failure)
+			out_of_memory();
 		blk_congestion_wait(WRITE, HZ/50);
 		goto rebalance;
 	}
