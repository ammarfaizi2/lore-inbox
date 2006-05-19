Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWESAs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWESAs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 20:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWESAs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 20:48:26 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57301 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932153AbWESAsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 20:48:25 -0400
Date: Thu, 18 May 2006 17:48:00 -0700
From: Paul Jackson <pj@sgi.com>
To: David Chinner <dgc@sgi.com>
Cc: akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, clameter@sgi.com
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Message-Id: <20060518174800.f13e2c86.pj@sgi.com>
In-Reply-To: <20060518054750.GN1390195@melbourne.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
	<20060517222543.600cb20a.akpm@osdl.org>
	<20060518054750.GN1390195@melbourne.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
> I suggested to Paul that __cpuset_zone_allowed() should check for
> __GFP_WAIT and allow the allocation if it is not set. Any allocation
> from interrupt context has to be GFP_ATOMIC so that would kill
> the need for the in_interrupt() check as well.

A couple of things going on here ...

First of all, the mm/page_alloc.c:__alloc_pages() code has been the
place where __GFP_WAIT was checked, with its local variable 'wait'.

Internal kernel code is not like network interface code.  In network
interface code, one should be conservative in what one generates
and liberal in what one accepts.  If this means both ends of a link
do a similar check, that's ok.  Within the kernel, it's best to do
things just once, to have a place to do everything, and everything done
in its place.  A good example of this was the recent discussion of
whether "kfree(p)" should check for "p == NULL", or whether the callers
of it should check. Most seemed to agree that the check should not be
done twice, and the debate was over how to accomplish that in the
various cases.

The current implementation of the cpuset hooks in __alloc_pages()
is designed to have the __GFP_WAIT check done in alloc_pages(), not
in cpuset_zone_allowed().

Putting the check you suggest in cpuset_zone_allowed() would 'obviously'
fix this particular bug, but it would partially duplicate existing
checks on 'wait' in __alloc_pages().  Not good.

It's sort of like deciding to hold up your pants with a belt, but when
a couple of belt loops break, adding suspenders, instead of fixing the
loops.  We don't want both (partially broken) belts and suspenders in
the kernel internals.

The second thing is that the current code is designed to distinguish
between the memory allocations requested in the following situations:
 [A] in interrupt,
 [B] GFP_ATOMIC (or !__GFP_WAIT, in general) in process context, and
 [C] __GFP_WAIT ok, in process context.

In situation [A], cpusets are ignored and the node closest to the
requesting ndoe with a free page is used.

In situation [B], we try every node -within- the allowed cpuset
before dropping the cpuset constraint, and allowing all nodes.

In situation [C], we stay within the cpuset, of course.

Since, unlike the rest of the __alloc_pages() code, the
cpuset_zone_allowed() check does distinguish between in_interrupt
and GFP_ATOMIC (!wait, in general), therefore it does need to
examine the "in_interrupt()" state, to know which applies.

Your proposal above, Dave, and what I suspect Andrew's proposal
would be, if he bothered to waste more time thinking about this,
amount to changing the above design from the three cases [A], [B],
and [C], to just the two cases:

 [D] __GFP_WAIT not ok, such as GFP_ATOMIC and/or in_interrupt, and
 [E] __GFP_WAIT ok.

You're suggesting we ignore cpusets in [D], and honor them in [E].

And you are both confident that just checking 'wait' covers all the
cases where one can't wait, as any correctly coded interrupt allocation
will have !__GFP_WAIT in the gfp_flag passed in.

I suspect we could do this, and it might be a good idea.  There may
well not be good enough reason to be making a special case of [B] above.

If we do this, then I think that such a change should be a separate
patch, as it intentionally changes the design, and it should sit in
*-mm for a few weeks, unlike this PATCH 01/03, which is a focused bug
fix to the current design, and which I would like to see on a faster
track.

One should separate out patches that fix bugs in the current
implementation from design changes that result in different behavior,
unless the old one is so broke it is hard to fix, not the case here I
hope.

One non-obvious (to me at least, for now) detail of such a design change
would be what do to with the __alloc_pages() code lines:

        do {
                if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
                        wakeup_kswapd(*z, order);
        } while (*(++z));

If 'wait' is set, for allocations in the current task context that
can sleep, then it's obvious enough - just wake up the kswapd's on
the nodes in the current tasks cpuset.

But what do we do if 'wait' is not set, such as when in interrupt or
for GFP_ATOMIC requests.  Calling cpuset_zone_allowed() is no longer
allowed in that case.

I can imagine doing any of the following:

    We could wake up all the swappers in the system, on the grounds
    that any node in the system is allowed to satisfy this request.

    We could just wake up the swappers in the current tasks cpuset,
    even though, if this is an interrupt, the current task is
    irrelevant?

    Maybe if (!wait) we could not wake up -any- swappers, since we
    certainly won't be able to wait around long enough for that to
    help us any on the current allocation.

    Or maybe we could just kick the current node's swapper
    (essentially, just call wakeup_kswapd() for just the first zone
    z in the zonelist.)

Though I can't coherently explain why, that last choice appeals to my
intuition the most - waking kswapd on just the first zone if (!wait).

Here's a draft patch, totally untested and probably unbuildable, that
does all the above:


---

 kernel/cpuset.c |   43 +++++++++++++++----------------------------
 mm/page_alloc.c |   32 +++++++++++++++++---------------
 2 files changed, 32 insertions(+), 43 deletions(-)

--- 2.6.17-rc4-mm1.orig/kernel/cpuset.c	2006-05-17 21:32:27.474553766 -0700
+++ 2.6.17-rc4-mm1/kernel/cpuset.c	2006-05-18 17:24:36.316549527 -0700
@@ -2224,32 +2224,21 @@ static const struct cpuset *nearest_excl
  * GFP_KERNEL allocations are not so marked, so can escape to the
  * nearest mem_exclusive ancestor cpuset.
  *
- * Scanning up parent cpusets requires callback_mutex.  The __alloc_pages()
- * routine only calls here with __GFP_HARDWALL bit _not_ set if
- * it's a GFP_KERNEL allocation, and all nodes in the current tasks
- * mems_allowed came up empty on the first pass over the zonelist.
- * So only GFP_KERNEL allocations, if all nodes in the cpuset are
- * short of memory, might require taking the callback_mutex mutex.
- *
- * The first call here from mm/page_alloc:get_page_from_freelist()
- * has __GFP_HARDWALL set in gfp_mask, enforcing hardwall cpusets, so
- * no allocation on a node outside the cpuset is allowed (unless in
- * interrupt, of course).
- *
- * The second pass through get_page_from_freelist() doesn't even call
- * here for GFP_ATOMIC calls.  For those calls, the __alloc_pages()
- * variable 'wait' is not set, and the bit ALLOC_CPUSET is not set
- * in alloc_flags.  That logic and the checks below have the combined
- * affect that:
- *	in_interrupt - any node ok (current task context irrelevant)
- *	GFP_ATOMIC   - any node ok
- *	GFP_KERNEL   - any node in enclosing mem_exclusive cpuset ok
+ * Scanning up parent cpusets requires callback_mutex, which might
+ * sleep.  Sleeping is not allowed if in interrupt or interrupts
+ * are disabled.  In such cases, all memory allocations -must- have
+ * the __GFP_WAIT -not- set in gfp_mask.
+ *
+ * So to keep it simple here:
+ *
+ * ==> Don't call this routine from __alloc_pages() if __GFP_WAIT is
+ *     not set in gfp_mask.  Don't call here from anywhere else if
+ *     one can't sleep.  Just assume that the zone is allowed.
+ *
+ * For calls from __alloc_pages, the above has the affect that:
+ *	!__GFP_WAIT (including GFP_ATOMIC, in_interrupt) - any node ok.
+ *	GFP_KERNEL   - any node in enclosing mem_exclusive cpuset ok.
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
- *
- * Rule:
- *    Don't call cpuset_zone_allowed() if you can't sleep, unless you
- *    pass in the __GFP_HARDWALL flag set in gfp_flag, which disables
- *    the code that might scan up ancestor cpusets and sleep.
  **/
 
 int __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
@@ -2258,10 +2247,8 @@ int __cpuset_zone_allowed(struct zone *z
 	const struct cpuset *cs;	/* current cpuset ancestors */
 	int allowed;			/* is allocation in zone z allowed? */
 
-	if (in_interrupt())
-		return 1;
+	might_sleep();
 	node = z->zone_pgdat->node_id;
-	might_sleep_if(!(gfp_mask & __GFP_HARDWALL));
 	if (node_isset(node, current->mems_allowed))
 		return 1;
 	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
--- 2.6.17-rc4-mm1.orig/mm/page_alloc.c	2006-05-17 21:32:27.474553766 -0700
+++ 2.6.17-rc4-mm1/mm/page_alloc.c	2006-05-18 17:08:47.509689158 -0700
@@ -877,7 +877,6 @@ failed:
 #define ALLOC_WMARK_HIGH	0x08 /* use pages_high watermark */
 #define ALLOC_HARDER		0x10 /* try to alloc harder */
 #define ALLOC_HIGH		0x20 /* __GFP_HIGH set */
-#define ALLOC_CPUSET		0x40 /* check for correct cpuset */
 
 /*
  * Return 1 if free pages are above 'mark'. This takes into account the order
@@ -916,7 +915,7 @@ int zone_watermark_ok(struct zone *z, in
  */
 static struct page *
 get_page_from_freelist(gfp_t gfp_mask, unsigned int order,
-		struct zonelist *zonelist, int alloc_flags)
+		struct zonelist *zonelist, int alloc_flags, int wait)
 {
 	struct zone **z = zonelist->zones;
 	struct page *page = NULL;
@@ -927,8 +926,7 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
 	do {
-		if ((alloc_flags & ALLOC_CPUSET) &&
-				!cpuset_zone_allowed(*z, gfp_mask))
+		if (wait && !cpuset_zone_allowed(*z, gfp_mask))
 			continue;
 
 		if (!(alloc_flags & ALLOC_NO_WATERMARKS)) {
@@ -1033,14 +1031,19 @@ restart:
 	}
 
 	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-				zonelist, ALLOC_WMARK_LOW|ALLOC_CPUSET);
+				zonelist, ALLOC_WMARK_LOW, wait);
 	if (page)
 		goto got_pg;
 
-	do {
-		if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
-			wakeup_kswapd(*z, order);
-	} while (*(++z));
+	if (wait) {
+		do {
+			if (cpuset_zone_allowed(*z, __GFP_HARDWALL))
+				wakeup_kswapd(*z, order);
+		} while (*(++z));
+	} else {
+		/* wake up first nodes kswapd in interrupt or GFP_ATOMIC */
+		wakeup_kswapd(*z, order);
+	}
 
 	/*
 	 * OK, we're below the kswapd watermark and have kicked background
@@ -1057,8 +1060,6 @@ restart:
 		alloc_flags |= ALLOC_HARDER;
 	if (gfp_mask & __GFP_HIGH)
 		alloc_flags |= ALLOC_HIGH;
-	if (wait)
-		alloc_flags |= ALLOC_CPUSET;
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
@@ -1068,7 +1069,8 @@ restart:
 	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
-	page = get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags);
+	page = get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags,
+								wait);
 	if (page)
 		goto got_pg;
 
@@ -1080,7 +1082,7 @@ restart:
 nofail_alloc:
 			/* go through the zonelist yet again, ignoring mins */
 			page = get_page_from_freelist(gfp_mask, order,
-				zonelist, ALLOC_NO_WATERMARKS);
+				zonelist, ALLOC_NO_WATERMARKS, wait);
 			if (page)
 				goto got_pg;
 			if (gfp_mask & __GFP_NOFAIL) {
@@ -1113,7 +1115,7 @@ rebalance:
 
 	if (likely(did_some_progress)) {
 		page = get_page_from_freelist(gfp_mask, order,
-						zonelist, alloc_flags);
+						zonelist, alloc_flags, wait);
 		if (page)
 			goto got_pg;
 	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
@@ -1124,7 +1126,7 @@ rebalance:
 		 * under heavy pressure.
 		 */
 		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-				zonelist, ALLOC_WMARK_HIGH|ALLOC_CPUSET);
+				zonelist, ALLOC_WMARK_HIGH, wait);
 		if (page)
 			goto got_pg;
 


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
