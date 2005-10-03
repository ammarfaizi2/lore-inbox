Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVJCOjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVJCOjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVJCOjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:39:10 -0400
Received: from mgw-ext04.nokia.com ([131.228.20.96]:48558 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1750872AbVJCOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:39:09 -0400
Date: Mon, 3 Oct 2005 17:36:34 +0300
From: Paul Mundt <paul.mundt@nokia.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] mempool_alloc() pre-allocated object usage
Message-ID: <20051003143634.GA1702@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 03 Oct 2005 14:38:54.0880 (UTC) FILETIME=[2E2BDA00:01C5C828]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently mempool_create() will pre-allocate min_nr objects in the pool
for later usage. However, the current semantics of mempool_alloc() are to
first attempt the ->alloc() path and then fall back to using a
pre-allocated object that already exists in the pool.

This is somewhat of a problem if we want to build up a pool of relatively
high order allocations (backed with a slab cache for example) for
gauranteeing contiguity early on, as sometimes we are able to satisfy the
->alloc() path and end up growing the pool larger than we would like.

The easy way around this would be to first fetch objects out of the pool
and then try ->alloc() in the case where we have no free objects left in
the pool. ie:

diff --git a/mm/mempool.c b/mm/mempool.c
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -216,11 +216,6 @@ void * mempool_alloc(mempool_t *pool, un
 	gfp_temp = gfp_mask & ~(__GFP_WAIT|__GFP_IO);
 
 repeat_alloc:
-
-	element = pool->alloc(gfp_temp, pool->pool_data);
-	if (likely(element != NULL))
-		return element;
-
 	spin_lock_irqsave(&pool->lock, flags);
 	if (likely(pool->curr_nr)) {
 		element = remove_element(pool);
@@ -229,6 +224,10 @@ repeat_alloc:
 	}
 	spin_unlock_irqrestore(&pool->lock, flags);
 
+	element = pool->alloc(gfp_temp, pool->pool_data);
+	if (likely(element != NULL))
+		return element;
+
 	/* We must not sleep in the GFP_ATOMIC case */
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;

The downside to this is that some people may be expecting that
pre-allocated elements are used as reserve space for when regular
allocations aren't possible. In which case, this would break that
behaviour.

Both usage patterns seem valid from my point of view, would you be open
to something that would accomodate both? (ie, possibly adding in a flag
to determine pre-allocated object usage?) Or should I not be using
mempool for contiguity purposes?
