Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSGDXud>; Thu, 4 Jul 2002 19:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSGDXr4>; Thu, 4 Jul 2002 19:47:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315198AbSGDXqR>;
	Thu, 4 Jul 2002 19:46:17 -0400
Message-ID: <3D24E040.B06236F6@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 16/27] resurrect __GFP_HIGH
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch reinstates __GFP_HIGH functionality.

__GFP_HIGH means "able to dip into the emergency pools".  However,
somewhere along the line this got broken.  __GFP_HIGH ceased to do
anything.  Instead, !__GFP_WAIT is used to tell the page allocator to
try harder.

__GFP_HIGH makes sense.  The concepts of "unable to sleep" and "should
try harder" are quite separate, and overloading !__GFP_WAIT to mean
"should access emergency pools" seems wrong.

This patch fixes a problem in mempool_alloc().  mempool_alloc() tries
the first allocation with __GFP_WAIT cleared.  If that fails, it tries
again with __GFP_WAIT enabled (if the caller can support __GFP_WAIT). 
So it is currently performing an atomic allocation first, even though
the caller said that they're prepared to go in and call the page
stealer.

I thought this was a mempool bug, but Ingo said:

> no, it's not GFP_ATOMIC. The important difference is __GFP_HIGH, which 
> triggers the intrusive highprio allocation mode. Otherwise gfp_nowait is 
> just a nonblocking allocation of the same type as the original gfp_mask.
> ...
> what i've added is a bit more subtle allocation method, with both 
> performance and balancing-correctness in mind:
>
> 1. allocate via gfp_mask, but nonblocking
> 2. if failure => try to get from the pool if the pool is 'full enough'.
> 3. if failure => allocate with gfp_mask [which might block]
> 
> there is performance data that this method improves bounce-IO performance
> significantly, because even under VM pressure (when gfp_mask would block)
> we can still use up to 50% of the memory pool without blocking (and
> without endangering deadlock-free allocation). Ie. the memory pool is also
> a fast 'frontside cache' of memory elements.

Ingo was assuming that __GFP_HIGH was still functional.  It isn't, and the
mempool design wants it.



 drivers/scsi/scsi_merge.c |    4 +++-
 include/linux/gfp.h       |   10 +++++-----
 mm/page_alloc.c           |    5 +----
 mm/slab.c                 |    4 ++--
 mm/vmscan.c               |    3 +++
 5 files changed, 14 insertions(+), 12 deletions(-)

--- 2.5.24/mm/page_alloc.c~gfp_high	Thu Jul  4 16:17:25 2002
+++ 2.5.24-akpm/mm/page_alloc.c	Thu Jul  4 16:22:09 2002
@@ -272,8 +272,6 @@ static struct page * balance_classzone(z
 	struct page * page = NULL;
 	int __freed = 0;
 
-	if (!(gfp_mask & __GFP_WAIT))
-		goto out;
 	if (in_interrupt())
 		BUG();
 
@@ -333,7 +331,6 @@ static struct page * balance_classzone(z
 		}
 		current->nr_local_pages = 0;
 	}
- out:
 	*freed = __freed;
 	return page;
 }
@@ -380,7 +377,7 @@ struct page * __alloc_pages(unsigned int
 			break;
 
 		local_min = z->pages_min;
-		if (!(gfp_mask & __GFP_WAIT))
+		if (gfp_mask & __GFP_HIGH)
 			local_min >>= 2;
 		min += local_min;
 		if (z->free_pages > min) {
--- 2.5.24/include/linux/gfp.h~gfp_high	Thu Jul  4 16:17:25 2002
+++ 2.5.24-akpm/include/linux/gfp.h	Thu Jul  4 16:17:25 2002
@@ -18,14 +18,14 @@
 #define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
 #define __GFP_FS	0x100	/* Can call down to low-level FS? */
 
-#define GFP_NOHIGHIO	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
-#define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
-#define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
+#define GFP_NOHIGHIO	(             __GFP_WAIT | __GFP_IO)
+#define GFP_NOIO	(             __GFP_WAIT)
+#define GFP_NOFS	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 #define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS | __GFP_HIGHMEM)
-#define GFP_KERNEL	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_NFS		(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_KERNEL	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_NFS		(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 #define GFP_KSWAPD	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
--- 2.5.24/mm/vmscan.c~gfp_high	Thu Jul  4 16:17:25 2002
+++ 2.5.24-akpm/mm/vmscan.c	Thu Jul  4 16:22:09 2002
@@ -52,6 +52,9 @@ static inline int is_page_cache_freeable
  * So PF_MEMALLOC is dropped here.  This causes the slab allocations to fail
  * earlier, so radix-tree nodes will then be allocated from the mempool
  * reserves.
+ *
+ * We're still using __GFP_HIGH for radix-tree node allocations, so some of
+ * the emergency pools are available - just not all of them.
  */
 static inline int
 swap_out_add_to_swap_cache(struct page *page, swp_entry_t entry)
--- 2.5.24/mm/slab.c~gfp_high	Thu Jul  4 16:17:25 2002
+++ 2.5.24-akpm/mm/slab.c	Thu Jul  4 16:17:25 2002
@@ -1153,12 +1153,12 @@ static int kmem_cache_grow (kmem_cache_t
 	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
 	 * will eventually be caught here (where it matters).
 	 */
-	if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
+	if (in_interrupt() && (flags & __GFP_WAIT))
 		BUG();
 
 	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 	local_flags = (flags & SLAB_LEVEL_MASK);
-	if (local_flags == SLAB_ATOMIC)
+	if (!(local_flags & __GFP_WAIT))
 		/*
 		 * Not allowed to sleep.  Need to tell a constructor about
 		 * this - it might need to know...
--- 2.5.24/drivers/scsi/scsi_merge.c~gfp_high	Thu Jul  4 16:17:25 2002
+++ 2.5.24-akpm/drivers/scsi/scsi_merge.c	Thu Jul  4 16:17:25 2002
@@ -74,8 +74,10 @@ int scsi_init_io(Scsi_Cmnd *SCpnt)
 	SCpnt->use_sg = count;
 
 	gfp_mask = GFP_NOIO;
-	if (in_interrupt())
+	if (in_interrupt()) {
 		gfp_mask &= ~__GFP_WAIT;
+		gfp_mask |= __GFP_HIGH;
+	}
 
 	/*
 	 * if sg table allocation fails, requeue request later.

-
