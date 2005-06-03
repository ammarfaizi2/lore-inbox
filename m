Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFCXGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFCXGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVFCXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:06:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:61146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261154AbVFCXFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:05:45 -0400
Date: Fri, 3 Jun 2005 16:06:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC for 2.6: avoid OOM at bounce buffer storm
Message-Id: <20050603160629.2acc4558.akpm@osdl.org>
In-Reply-To: <42A07BAA.4050303@fujitsu-siemens.com>
References: <42A07BAA.4050303@fujitsu-siemens.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck <martin.wilck@fujitsu-siemens.com> wrote:
>
> Hello,
> 
> I have recently seen massive problems with the bounce buffer allocation 
> implementation in 2.6. My system got OOM with an ata_piix controller 
> (4GB bounce limit), 2 P4 CPUs and 8GB of RAM with a very simple 
> copy-compare test: About 800MB worth of data are copied with cp(1) in 7 
> synchronous jobs. Each job does a sync(1) after the copy.

Fair enough.

> ...
> 
> The attached quick-and-dirty patch gives you an idea of what I figured 
> could be a useful workaround for that problem. It follows 2 main ideas:
> 
> 1 When bounce buffer allocations fail, it is wrong to trigger the page
>    reclaim mechanism which is likely to genetate even more bounce buffer
>    requests. Thus there should be no wakeup_bdflush() call for the
>    page_pool.
> 
> 2 bounce buffer allocations should not simply use alloc_page() because
>    there is no limit for allocations that way. Rather, bounce buffer
>    allocations should stop if ZONE_NORMAL is full to a certain degree
>    (my patch stops at 51% - chosen arbitrarily).

It might be neater to do this at the mempool level: that way we're adding
general-purpose infrastructure and then just using it, rather than
special-casing the bounce code.

See below a (n untested) patch against the latest devel tree.  It won't be
stunningly scalable on big SMP, but the overhead of bouncing will probably
hide that.


> I couldn't get 2.6.12-rc5 to run on my system.

Ow.  Could you please investigate further?  Any boot messages for us to
see?  it's quite possibly some missing config option..



 include/linux/mempool.h |   17 +++++++++++++++--
 mm/highmem.c            |    4 +++-
 mm/mempool.c            |   17 +++++++++++++----
 3 files changed, 31 insertions(+), 7 deletions(-)

diff -puN include/linux/mempool.h~mempool-bounce-buffer-restriction include/linux/mempool.h
--- 25/include/linux/mempool.h~mempool-bounce-buffer-restriction	Fri Jun  3 16:01:58 2005
+++ 25-akpm/include/linux/mempool.h	Fri Jun  3 16:01:58 2005
@@ -5,6 +5,7 @@
 #define _LINUX_MEMPOOL_H
 
 #include <linux/wait.h>
+#include <asm/semaphore.h>
 
 typedef void * (mempool_alloc_t)(unsigned int __nocast gfp_mask, void *pool_data);
 typedef void (mempool_free_t)(void *element, void *pool_data);
@@ -14,14 +15,26 @@ typedef struct mempool_s {
 	int min_nr;		/* nr of elements at *elements */
 	int curr_nr;		/* Current nr of elements at *elements */
 	void **elements;
+	int limit;
 
 	void *pool_data;
 	mempool_alloc_t *alloc;
 	mempool_free_t *free;
 	wait_queue_head_t wait;
+	struct semaphore limit_sem;
 } mempool_t;
-extern mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-				 mempool_free_t *free_fn, void *pool_data);
+
+extern mempool_t *mempool_create_restricted(int min_nr,
+	mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
+	void *pool_data, int limit);
+
+static inline mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
+			mempool_free_t *free_fn, void *pool_data)
+{
+	return mempool_create_restricted(min_nr, alloc_fn, free_fn,
+					pool_data, 0);
+}
+
 extern int mempool_resize(mempool_t *pool, int new_min_nr, unsigned int __nocast gfp_mask);
 extern void mempool_destroy(mempool_t *pool);
 extern void * mempool_alloc(mempool_t *pool, unsigned int __nocast gfp_mask);
diff -puN mm/highmem.c~mempool-bounce-buffer-restriction mm/highmem.c
--- 25/mm/highmem.c~mempool-bounce-buffer-restriction	Fri Jun  3 16:01:58 2005
+++ 25-akpm/mm/highmem.c	Fri Jun  3 16:01:58 2005
@@ -224,7 +224,9 @@ static __init int init_emergency_pool(vo
 	if (!i.totalhigh)
 		return 0;
 
-	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
+	page_pool = mempool_create_restricted(POOL_SIZE, page_pool_alloc,
+				page_pool_free, NULL,
+				200 * 1024 * 1024 / PAGE_SIZE);
 	if (!page_pool)
 		BUG();
 	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
diff -puN mm/mempool.c~mempool-bounce-buffer-restriction mm/mempool.c
--- 25/mm/mempool.c~mempool-bounce-buffer-restriction	Fri Jun  3 16:01:58 2005
+++ 25-akpm/mm/mempool.c	Fri Jun  3 16:01:58 2005
@@ -38,12 +38,13 @@ static void free_pool(mempool_t *pool)
 }
 
 /**
- * mempool_create - create a memory pool
+ * mempool_create_restricted - create a memory pool
  * @min_nr:    the minimum number of elements guaranteed to be
  *             allocated for this pool.
  * @alloc_fn:  user-defined element-allocation function.
  * @free_fn:   user-defined element-freeing function.
  * @pool_data: optional private data available to the user-defined functions.
+ * @limit:     maximum number of in-flight objects
  *
  * this function creates and allocates a guaranteed size, preallocated
  * memory pool. The pool can be used from the mempool_alloc and mempool_free
@@ -51,8 +52,8 @@ static void free_pool(mempool_t *pool)
  * functions might sleep - as long as the mempool_alloc function is not called
  * from IRQ contexts.
  */
-mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-				mempool_free_t *free_fn, void *pool_data)
+mempool_t *mempool_create_restricted(int min_nr, mempool_alloc_t *alloc_fn,
+			mempool_free_t *free_fn, void *pool_data, int limit)
 {
 	mempool_t *pool;
 
@@ -71,6 +72,8 @@ mempool_t * mempool_create(int min_nr, m
 	init_waitqueue_head(&pool->wait);
 	pool->alloc = alloc_fn;
 	pool->free = free_fn;
+	pool->limit = limit;
+	sema_init(&pool->limit_sem, limit);
 
 	/*
 	 * First pre-allocate the guaranteed number of buffers.
@@ -87,7 +90,7 @@ mempool_t * mempool_create(int min_nr, m
 	}
 	return pool;
 }
-EXPORT_SYMBOL(mempool_create);
+EXPORT_SYMBOL(mempool_create_restricted);
 
 /**
  * mempool_resize - resize an existing memory pool
@@ -208,6 +211,9 @@ void * mempool_alloc(mempool_t *pool, un
 
 	gfp_temp = gfp_mask & ~(__GFP_WAIT|__GFP_IO);
 
+	if (unlikely(pool->limit))
+		down(&pool->limit_sem);
+
 repeat_alloc:
 
 	element = pool->alloc(gfp_temp, pool->pool_data);
@@ -250,6 +256,9 @@ void mempool_free(void *element, mempool
 {
 	unsigned long flags;
 
+	if (unlikely(pool->limit))
+		up(&pool->limit_sem);
+
 	smp_mb();
 	if (pool->curr_nr < pool->min_nr) {
 		spin_lock_irqsave(&pool->lock, flags);
_

