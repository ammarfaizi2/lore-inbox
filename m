Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSLLT0r>; Thu, 12 Dec 2002 14:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSLLT0r>; Thu, 12 Dec 2002 14:26:47 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:16529 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S264901AbSLLT0p>; Thu, 12 Dec 2002 14:26:45 -0500
Date: Thu, 12 Dec 2002 19:35:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill __GFP_HIGHIO
Message-ID: <Pine.LNX.4.44.0212121852010.2319-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed that __GFP_HIGHIO has played no real part since bounce
buffering was converted to mempool in 2.5.12: so this patch (over
2.5.51-mm2) removes it and GFP_NOHIGHIO and SLAB_NOHIGHIO.

Also removes GFP_KSWAPD, in 2.5 same as GFP_KERNEL; leaves GFP_USER,
which can be a useful comment, even though in 2.5 same as GFP_KERNEL.

One anomaly needs comment: strictly, if there's no __GFP_HIGHIO, then
GFP_NOHIGHIO translates to GFP_NOFS; but GFP_NOFS looks wrong in the
block layer, and if you follow them down, you find that GFP_NOFS and
GFP_NOIO behave the same way in mempool_alloc - so I've used the
less surprising GFP_NOIO to replace GFP_NOHIGHIO.

Hugh

--- 2.5.51-mm2/drivers/block/ll_rw_blk.c	Thu Dec 12 12:30:32 2002
+++ linux/drivers/block/ll_rw_blk.c	Thu Dec 12 17:02:25 2002
@@ -284,7 +284,7 @@
 		init_emergency_isa_pool();
 		q->bounce_gfp = GFP_NOIO | GFP_DMA;
 	} else
-		q->bounce_gfp = GFP_NOHIGHIO;
+		q->bounce_gfp = GFP_NOIO;
 
 	/*
 	 * keep this for debugging for now...
--- 2.5.51-mm2/include/linux/blkdev.h	Thu Dec 12 12:30:33 2002
+++ linux/include/linux/blkdev.h	Thu Dec 12 17:02:25 2002
@@ -302,7 +302,7 @@
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
 extern int init_emergency_isa_pool(void);
-inline void blk_queue_bounce(request_queue_t *q, struct bio **bio);
+extern void blk_queue_bounce(request_queue_t *q, struct bio **bio);
 
 #define rq_for_each_bio(bio, rq)	\
 	if ((rq->bio))			\
--- 2.5.51-mm2/include/linux/gfp.h	Thu Dec 12 12:30:33 2002
+++ linux/include/linux/gfp.h	Thu Dec 12 17:02:25 2002
@@ -14,20 +14,17 @@
 /* Action modifiers - doesn't change the zoning */
 #define __GFP_WAIT	0x10	/* Can wait and reschedule? */
 #define __GFP_HIGH	0x20	/* Should access emergency pools? */
-#define __GFP_IO	0x40	/* Can start low memory physical IO? */
-#define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
-#define __GFP_FS	0x100	/* Can call down to low-level FS? */
-#define __GFP_COLD	0x200	/* Cache-cold page required */
-#define __GFP_NOWARN	0x400	/* Suppress page allocation failure warning */
+#define __GFP_IO	0x40	/* Can start physical IO? */
+#define __GFP_FS	0x80	/* Can call down to low-level FS? */
+#define __GFP_COLD	0x100	/* Cache-cold page required */
+#define __GFP_NOWARN	0x200	/* Suppress page allocation failure warning */
 
-#define GFP_NOHIGHIO	(             __GFP_WAIT | __GFP_IO)
-#define GFP_NOIO	(             __GFP_WAIT)
-#define GFP_NOFS	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
 #define GFP_ATOMIC	(__GFP_HIGH)
-#define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS | __GFP_HIGHMEM)
-#define GFP_KERNEL	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_KSWAPD	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_NOIO	(__GFP_WAIT)
+#define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
+#define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
+#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
+#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
--- 2.5.51-mm2/include/linux/slab.h	Thu Dec 12 12:30:33 2002
+++ linux/include/linux/slab.h	Thu Dec 12 17:02:25 2002
@@ -17,13 +17,12 @@
 /* flags for kmem_cache_alloc() */
 #define	SLAB_NOFS		GFP_NOFS
 #define	SLAB_NOIO		GFP_NOIO
-#define SLAB_NOHIGHIO		GFP_NOHIGHIO
 #define	SLAB_ATOMIC		GFP_ATOMIC
 #define	SLAB_USER		GFP_USER
 #define	SLAB_KERNEL		GFP_KERNEL
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_HIGHIO|__GFP_FS|__GFP_COLD|__GFP_NOWARN)
+#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS|__GFP_COLD|__GFP_NOWARN)
 #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
 
 /* flags to pass to kmem_cache_create().
--- 2.5.51-mm2/mm/highmem.c	Tue Nov  5 11:31:54 2002
+++ linux/mm/highmem.c	Thu Dec 12 17:02:25 2002
@@ -366,7 +366,7 @@
 	return 0;
 }
 
-void __blk_queue_bounce(request_queue_t *q, struct bio **bio_orig, int bio_gfp,
+static void __blk_queue_bounce(request_queue_t *q, struct bio **bio_orig,
 			mempool_t *pool)
 {
 	struct page *page;
@@ -387,7 +387,7 @@
 		 * irk, bounce it
 		 */
 		if (!bio)
-			bio = bio_alloc(bio_gfp, (*bio_orig)->bi_vcnt);
+			bio = bio_alloc(GFP_NOIO, (*bio_orig)->bi_vcnt);
 
 		to = bio->bi_io_vec + i;
 
@@ -447,10 +447,9 @@
 	*bio_orig = bio;
 }
 
-inline void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)
+void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)
 {
 	mempool_t *pool;
-	int bio_gfp;
 
 	BUG_ON((*bio_orig)->bi_idx);
 
@@ -462,20 +461,16 @@
 	if (!(q->bounce_gfp & GFP_DMA)) {
 		if (q->bounce_pfn >= blk_max_pfn)
 			return;
-
-		bio_gfp = GFP_NOHIGHIO;
 		pool = page_pool;
 	} else {
 		BUG_ON(!isa_page_pool);
-
-		bio_gfp = GFP_NOIO;
 		pool = isa_page_pool;
 	}
 
 	/*
 	 * slow path
 	 */
-	__blk_queue_bounce(q, bio_orig, bio_gfp, pool);
+	__blk_queue_bounce(q, bio_orig, pool);
 }
 
 #if defined(CONFIG_DEBUG_HIGHMEM) && defined(CONFIG_HIGHMEM)
--- 2.5.51-mm2/mm/vmscan.c	Thu Dec 12 12:30:33 2002
+++ linux/mm/vmscan.c	Thu Dec 12 17:02:25 2002
@@ -887,9 +887,9 @@
 				max_scan = to_reclaim * 2;
 			if (max_scan < SWAP_CLUSTER_MAX)
 				max_scan = SWAP_CLUSTER_MAX;
-			to_free -= shrink_zone(zone, max_scan, GFP_KSWAPD,
+			to_free -= shrink_zone(zone, max_scan, GFP_KERNEL,
 					to_reclaim, &nr_mapped, ps, priority);
-			shrink_slab(max_scan + nr_mapped, GFP_KSWAPD);
+			shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
 			if (zone->all_unreclaimable)
 				continue;
 			if (zone->pages_scanned > zone->present_pages * 2)

