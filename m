Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319087AbSH2Dpx>; Wed, 28 Aug 2002 23:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSH2Dpx>; Wed, 28 Aug 2002 23:45:53 -0400
Received: from holomorphy.com ([66.224.33.161]:39809 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319087AbSH2Dpv>;
	Wed, 28 Aug 2002 23:45:51 -0400
Date: Wed, 28 Aug 2002 20:49:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
Message-ID: <20020829034957.GE878@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D6C53ED.32044CAD@zip.com.au> <20020828200857.GB888@holomorphy.com> <3D6D3216.D472CBC3@zip.com.au> <20020828214243.GC888@holomorphy.com> <3D6D477C.F5116BA7@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D6D477C.F5116BA7@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I've already written the patch to address it, though of course, I can
>> post those traces along with the patch once it's rediffed. (It's trivial
>> though -- just a fresh GFP flag and a check for it before calling
>> out_of_memory(), setting it in mempool_alloc(), and ignoring it in
>> slab.c.) It requires several rounds of "un-throttling" to reproduce
>> the OOM's, the nature of which I've outlined elsewhere.

On Wed, Aug 28, 2002 at 02:58:20PM -0700, Andrew Morton wrote:
> That's a sane approach.  mempool_alloc() is designed for allocations
> which "must" succeed if you wait long enough.
> In fact it might make sense to only perform a single scan of the
> LRU if __GFP_WLI is set, rather than the increasing priority thing.
> But sigh.  Pointlessly scanning zillions of dirty pages and doing nothing
> with them is dumb.  So much better to go for a FIFO snooze on a per-zone
> waitqueue, be woken when some memory has been cleansed.  (That's effectively
> what mempool does, but it's all private and different).

Here's a stab in that direction, against 2.5.31. A trivially different
patch was tested and verified to solve the problems in practice. A
theoretical deadlock remains where a mempool allocator sleeps on general
purpose memory and is not woken when the mempool is replenished.


Cheers,
Bill


diff -urN linux-2.5.31-virgin/include/linux/gfp.h linux-2.5.31-nokill/include/linux/gfp.h
--- linux-2.5.31-virgin/include/linux/gfp.h	2002-08-10 18:41:24.000000000 -0700
+++ linux-2.5.31-nokill/include/linux/gfp.h	2002-08-28 02:22:55.000000000 -0700
@@ -17,6 +17,7 @@
 #define __GFP_IO	0x40	/* Can start low memory physical IO? */
 #define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
 #define __GFP_FS	0x100	/* Can call down to low-level FS? */
+#define __GFP_NOKILL	0x200	/* Should not OOM kill */
 
 #define GFP_NOHIGHIO	(             __GFP_WAIT | __GFP_IO)
 #define GFP_NOIO	(             __GFP_WAIT)
diff -urN linux-2.5.31-virgin/include/linux/slab.h linux-2.5.31-nokill/include/linux/slab.h
--- linux-2.5.31-virgin/include/linux/slab.h	2002-08-10 18:41:28.000000000 -0700
+++ linux-2.5.31-nokill/include/linux/slab.h	2002-08-28 02:22:55.000000000 -0700
@@ -24,7 +24,7 @@
 #define	SLAB_NFS		GFP_NFS
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_HIGHIO|__GFP_FS)
+#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_HIGHIO|__GFP_FS|__GFP_NOKILL)
 #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
 
 /* flags to pass to kmem_cache_create().
diff -urN linux-2.5.31-virgin/mm/mempool.c linux-2.5.31-nokill/mm/mempool.c
--- linux-2.5.31-virgin/mm/mempool.c	2002-08-10 18:41:19.000000000 -0700
+++ linux-2.5.31-nokill/mm/mempool.c	2002-08-28 02:22:55.000000000 -0700
@@ -186,7 +186,11 @@
 	unsigned long flags;
 	int curr_nr;
 	DECLARE_WAITQUEUE(wait, current);
-	int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
+	int gfp_nowait;
+
+	gfp_mask |= __GFP_NOKILL;
+
+	gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO | __GFP_NOKILL);
 
 repeat_alloc:
 	element = pool->alloc(gfp_nowait, pool->pool_data);
diff -urN linux-2.5.31-virgin/mm/vmscan.c linux-2.5.31-nokill/mm/vmscan.c
--- linux-2.5.31-virgin/mm/vmscan.c	2002-08-10 18:41:21.000000000 -0700
+++ linux-2.5.31-nokill/mm/vmscan.c	2002-08-28 03:17:15.000000000 -0700
@@ -401,23 +401,24 @@
 
 int try_to_free_pages(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
 {
-	int priority = DEF_PRIORITY;
-	int nr_pages = SWAP_CLUSTER_MAX;
+	int priority, status, nr_pages = SWAP_CLUSTER_MAX;
 
 	KERNEL_STAT_INC(pageoutrun);
 
-	do {
+	for (priority = DEF_PRIORITY; priority; --priority) {
 		nr_pages = shrink_caches(classzone, priority, gfp_mask, nr_pages);
-		if (nr_pages <= 0)
-			return 1;
-	} while (--priority);
+		status = (nr_pages <= 0) ? 1 : 0;
+		if (status || (gfp_mask & __GFP_NOKILL))
+			goto out;
+	}
 
 	/*
 	 * Hmm.. Cache shrink failed - time to kill something?
 	 * Mhwahahhaha! This is the part I really like. Giggle.
 	 */
 	out_of_memory();
-	return 0;
+out:
+	return status;
 }
 
 DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
