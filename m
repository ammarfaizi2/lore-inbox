Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVDLNG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVDLNG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVDLNG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:06:28 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:54714 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262390AbVDLMyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:54:04 -0400
Message-ID: <425BC4E0.2030302@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:53:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch doh/9] mempool simplify alloc
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070202090900000803050805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070202090900000803050805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Whoops, this one should be 3/9. 3/9 should be 4/9, and so on.

-- 
SUSE Labs, Novell Inc.
quilt

--------------070202090900000803050805
Content-Type: text/plain;
 name="mempool-simplify-alloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempool-simplify-alloc.patch"

Mempool is pretty clever. Looks too clever for its own good.
It shouldn't really know so much about MM internals.

- don't guess about what effective page reclaim might involve.

- don't randomly flush out all dirty data if some unlikely thing
  happens (alloc returns NULL). page reclaim can (sort of :P) handle
  it.

I think the main motivation is trying to avoid pool->lock at all
costs. However the first allocation is attempted with __GFP_WAIT
cleared, so it will be 'can_try_harder' if it hits the page allocator.
So if allocation still fails, then we can probably afford to hit the
pool->lock - and what's the alternative? Try page reclaim and hit
zone->lru_lock?

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/mm/mempool.c
===================================================================
--- linux-2.6.orig/mm/mempool.c	2005-04-12 22:47:02.000000000 +1000
+++ linux-2.6/mm/mempool.c	2005-04-12 22:47:02.000000000 +1000
@@ -198,36 +198,22 @@ void * mempool_alloc(mempool_t *pool, un
 	void *element;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
-	int gfp_nowait;
+	int gfp_temp;
 	
+	might_sleep_if(gfp_mask & __GFP_WAIT);
+
 	gfp_mask |= __GFP_MEMPOOL;
 	gfp_mask |= __GFP_NORETRY;	/* don't loop in __alloc_pages */
 	gfp_mask |= __GFP_NOWARN;	/* failures are OK */
-	gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
 
-	might_sleep_if(gfp_mask & __GFP_WAIT);
+	gfp_temp = gfp_mask & ~__GFP_WAIT;
+
 repeat_alloc:
-	element = pool->alloc(gfp_nowait, pool->pool_data);
+
+	element = pool->alloc(gfp_temp, pool->pool_data);
 	if (likely(element != NULL))
 		return element;
 
-	/*
-	 * If the pool is less than 50% full and we can perform effective
-	 * page reclaim then try harder to allocate an element.
-	 */
-	mb();
-	if ((gfp_mask & __GFP_FS) && (gfp_mask != gfp_nowait) &&
-				(pool->curr_nr <= pool->min_nr/2)) {
-		element = pool->alloc(gfp_mask, pool->pool_data);
-		if (likely(element != NULL))
-			return element;
-	}
-
-	/*
-	 * Kick the VM at this point.
-	 */
-	wakeup_bdflush(0);
-
 	spin_lock_irqsave(&pool->lock, flags);
 	if (likely(pool->curr_nr)) {
 		element = remove_element(pool);
@@ -240,6 +226,8 @@ repeat_alloc:
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;
 
+	/* Now start performing page reclaim */
+	gfp_temp = gfp_mask;
 	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
 	mb();
 	if (!pool->curr_nr)

--------------070202090900000803050805--

