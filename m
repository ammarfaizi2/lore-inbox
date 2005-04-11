Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVDKMro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVDKMro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 08:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDKMro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 08:47:44 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:41348 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261564AbVDKMps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 08:45:48 -0400
Message-ID: <425A7173.802@yahoo.com.au>
Date: Mon, 11 Apr 2005 22:45:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504100328.53762.ctpm@rnl.ist.utl.pt> <20050409194746.69cfa230.akpm@osdl.org> <200504110138.51872.ctpm@rnl.ist.utl.pt> <425A4999.9010209@yahoo.com.au>
In-Reply-To: <425A4999.9010209@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090808000104070809060407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090808000104070809060407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> The common theme seems to be: try_to_free_pages, swap_writepage,
> mempool_alloc, down/down_failed in .text.lock.md. Next I would suspect
> md/raid1 - maybe some deadlock in an uncommon memory allocation
> failure path?
> 
> I'll see if I can reproduce it here.
> 

No luck yet (on SMP i386). How many disks are you using in each
raid1 array? You are using one array for swap, and one mounted as
ext3 for the working area of the `stress` program, right?

Neil, have you had a look at the traces? Do they mean much to you?

Claudio - I have attached another patch you could try. It has a more
complete set of mempool and related memory allocation fixes, as well
as some other recent patches I had which reduces atomic memory usage
by the block layer. Could you try if you get time? Thanks.

Nick

-- 
SUSE Labs, Novell Inc.

--------------090808000104070809060407
Content-Type: text/plain;
 name="diff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.patch"

Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-04-11 22:18:49.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-04-11 22:38:10.000000000 +1000
@@ -1450,7 +1450,7 @@ EXPORT_SYMBOL(blk_remove_plug);
  */
 void __generic_unplug_device(request_queue_t *q)
 {
-	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
+	if (unlikely(test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)))
 		return;
 
 	if (!blk_remove_plug(q))
@@ -1828,7 +1828,6 @@ static void __freed_request(request_queu
 		clear_queue_congested(q, rw);
 
 	if (rl->count[rw] + 1 <= q->nr_requests) {
-		smp_mb();
 		if (waitqueue_active(&rl->wait[rw]))
 			wake_up(&rl->wait[rw]);
 
@@ -1860,18 +1859,20 @@ static void freed_request(request_queue_
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queuelist)
 /*
- * Get a free request, queue_lock must not be held
+ * Get a free request, queue_lock must be held.
+ * Returns NULL on failure, with queue_lock held.
+ * Returns !NULL on success, with queue_lock *not held*.
  */
 static struct request *get_request(request_queue_t *q, int rw, int gfp_mask)
 {
+	int batching;
 	struct request *rq = NULL;
 	struct request_list *rl = &q->rq;
-	struct io_context *ioc = get_io_context(gfp_mask);
+	struct io_context *ioc = get_io_context(GFP_ATOMIC);
 
 	if (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)))
 		goto out;
 
-	spin_lock_irq(q->queue_lock);
 	if (rl->count[rw]+1 >= q->nr_requests) {
 		/*
 		 * The queue will fill after this allocation, so set it as
@@ -1884,6 +1885,8 @@ static struct request *get_request(reque
 			blk_set_queue_full(q, rw);
 		}
 	}
+	
+	batching = ioc_batching(q, ioc);
 
 	switch (elv_may_queue(q, rw)) {
 		case ELV_MQUEUE_NO:
@@ -1894,12 +1897,11 @@ static struct request *get_request(reque
 			goto get_rq;
 	}
 
-	if (blk_queue_full(q, rw) && !ioc_batching(q, ioc)) {
+	if (blk_queue_full(q, rw) && !batching) {
 		/*
 		 * The queue is full and the allocating process is not a
 		 * "batcher", and not exempted by the IO scheduler
 		 */
-		spin_unlock_irq(q->queue_lock);
 		goto out;
 	}
 
@@ -1933,11 +1935,10 @@ rq_starved:
 		if (unlikely(rl->count[rw] == 0))
 			rl->starved[rw] = 1;
 
-		spin_unlock_irq(q->queue_lock);
 		goto out;
 	}
 
-	if (ioc_batching(q, ioc))
+	if (batching)
 		ioc->nr_batch_requests--;
 	
 	rq_init(q, rq);
@@ -1950,13 +1951,14 @@ out:
 /*
  * No available requests for this queue, unplug the device and wait for some
  * requests to become available.
+ *
+ * Called with q->queue_lock held, and returns with it unlocked.
  */
 static struct request *get_request_wait(request_queue_t *q, int rw)
 {
 	DEFINE_WAIT(wait);
 	struct request *rq;
 
-	generic_unplug_device(q);
 	do {
 		struct request_list *rl = &q->rq;
 
@@ -1968,6 +1970,8 @@ static struct request *get_request_wait(
 		if (!rq) {
 			struct io_context *ioc;
 
+			__generic_unplug_device(q);
+			spin_unlock_irq(q->queue_lock);
 			io_schedule();
 
 			/*
@@ -1979,6 +1983,8 @@ static struct request *get_request_wait(
 			ioc = get_io_context(GFP_NOIO);
 			ioc_set_batching(q, ioc);
 			put_io_context(ioc);
+
+			spin_lock_irq(q->queue_lock);
 		}
 		finish_wait(&rl->wait[rw], &wait);
 	} while (!rq);
@@ -1992,10 +1998,15 @@ struct request *blk_get_request(request_
 
 	BUG_ON(rw != READ && rw != WRITE);
 
+	spin_lock_irq(q->queue_lock);
 	if (gfp_mask & __GFP_WAIT)
 		rq = get_request_wait(q, rw);
-	else
+	else {
 		rq = get_request(q, rw, gfp_mask);
+		if (!rq)
+			spin_unlock_irq(q->queue_lock);
+	}
+	/* q->queue_lock is unlocked at this point */
 
 	return rq;
 }
@@ -2558,7 +2569,7 @@ EXPORT_SYMBOL(__blk_attempt_remerge);
 
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
-	struct request *req, *freereq = NULL;
+	struct request *req;
 	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, err;
 	sector_t sector;
 
@@ -2578,19 +2589,14 @@ static int __make_request(request_queue_
 	spin_lock_prefetch(q->queue_lock);
 
 	barrier = bio_barrier(bio);
-	if (barrier && (q->ordered == QUEUE_ORDERED_NONE)) {
+	if (unlikely(barrier) && (q->ordered == QUEUE_ORDERED_NONE)) {
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}
 
-again:
 	spin_lock_irq(q->queue_lock);
 
-	if (elv_queue_empty(q)) {
-		blk_plug_device(q);
-		goto get_rq;
-	}
-	if (barrier)
+	if (elv_queue_empty(q) || unlikely(barrier))
 		goto get_rq;
 
 	el_ret = elv_merge(q, &req, bio);
@@ -2633,40 +2639,24 @@ again:
 				elv_merged_request(q, req);
 			goto out;
 
-		/*
-		 * elevator says don't/can't merge. get new request
-		 */
-		case ELEVATOR_NO_MERGE:
-			break;
-
+		/* ELV_NO_MERGE: elevator says don't/can't merge. */
 		default:
-			printk("elevator returned crap (%d)\n", el_ret);
-			BUG();
+			;
 	}
 
+get_rq:
 	/*
-	 * Grab a free request from the freelist - if that is empty, check
-	 * if we are doing read ahead and abort instead of blocking for
-	 * a free slot.
+	 * Grab a free request. This is might sleep but can not fail.
+	 * Returns with the queue unlocked.
+	 */
+	req = get_request_wait(q, rw);
+
+	/*
+	 * After dropping the lock and possibly sleeping here, our request
+	 * may now be mergeable after it had proven unmergeable (above).
+	 * We don't worry about that case for efficiency. It won't happen
+	 * often, and the elevators are able to handle it.
 	 */
-get_rq:
-	if (freereq) {
-		req = freereq;
-		freereq = NULL;
-	} else {
-		spin_unlock_irq(q->queue_lock);
-		if ((freereq = get_request(q, rw, GFP_ATOMIC)) == NULL) {
-			/*
-			 * READA bit set
-			 */
-			err = -EWOULDBLOCK;
-			if (bio_rw_ahead(bio))
-				goto end_io;
-	
-			freereq = get_request_wait(q, rw);
-		}
-		goto again;
-	}
 
 	req->flags |= REQ_CMD;
 
@@ -2679,7 +2669,7 @@ get_rq:
 	/*
 	 * REQ_BARRIER implies no merging, but lets make it explicit
 	 */
-	if (barrier)
+	if (unlikely(barrier))
 		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
 
 	req->errors = 0;
@@ -2694,10 +2684,11 @@ get_rq:
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 
+	spin_lock_irq(q->queue_lock);
+	if (elv_queue_empty(q))
+		blk_plug_device(q);
 	add_request(q, req);
 out:
-	if (freereq)
-		__blk_put_request(q, freereq);
 	if (bio_sync(bio))
 		__generic_unplug_device(q);
 
@@ -2803,7 +2794,7 @@ static inline void block_wait_queue_runn
 {
 	DEFINE_WAIT(wait);
 
-	while (test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags)) {
+	while (unlikely(test_bit(QUEUE_FLAG_DRAIN, &q->queue_flags))) {
 		struct request_list *rl = &q->rq;
 
 		prepare_to_wait_exclusive(&rl->drain, &wait,
@@ -2912,7 +2903,7 @@ end_io:
 			goto end_io;
 		}
 
-		if (test_bit(QUEUE_FLAG_DEAD, &q->queue_flags))
+		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
 			goto end_io;
 
 		block_wait_queue_running(q);
Index: linux-2.6/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-crypt.c	2005-04-11 22:18:50.000000000 +1000
+++ linux-2.6/drivers/md/dm-crypt.c	2005-04-11 22:38:08.000000000 +1000
@@ -331,25 +331,14 @@ crypt_alloc_buffer(struct crypt_config *
 	struct bio *bio;
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	int gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
-	unsigned long flags = current->flags;
 	unsigned int i;
 
-	/*
-	 * Tell VM to act less aggressively and fail earlier.
-	 * This is not necessary but increases throughput.
-	 * FIXME: Is this really intelligent?
-	 */
-	current->flags &= ~PF_MEMALLOC;
-
 	if (base_bio)
 		bio = bio_clone(base_bio, GFP_NOIO);
 	else
 		bio = bio_alloc(GFP_NOIO, nr_iovecs);
-	if (!bio) {
-		if (flags & PF_MEMALLOC)
-			current->flags |= PF_MEMALLOC;
+	if (!bio)
 		return NULL;
-	}
 
 	/* if the last bio was not complete, continue where that one ended */
 	bio->bi_idx = *bio_vec_idx;
@@ -386,9 +375,6 @@ crypt_alloc_buffer(struct crypt_config *
 		size -= bv->bv_len;
 	}
 
-	if (flags & PF_MEMALLOC)
-		current->flags |= PF_MEMALLOC;
-
 	if (!bio->bi_size) {
 		bio_put(bio);
 		return NULL;
Index: linux-2.6/fs/mpage.c
===================================================================
--- linux-2.6.orig/fs/mpage.c	2005-04-11 22:18:50.000000000 +1000
+++ linux-2.6/fs/mpage.c	2005-04-11 22:38:08.000000000 +1000
@@ -105,11 +105,6 @@ mpage_alloc(struct block_device *bdev,
 
 	bio = bio_alloc(gfp_flags, nr_vecs);
 
-	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
-		while (!bio && (nr_vecs /= 2))
-			bio = bio_alloc(gfp_flags, nr_vecs);
-	}
-
 	if (bio) {
 		bio->bi_bdev = bdev;
 		bio->bi_sector = first_sector;
Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h	2005-04-11 22:18:51.000000000 +1000
+++ linux-2.6/include/linux/gfp.h	2005-04-11 22:38:07.000000000 +1000
@@ -38,14 +38,16 @@ struct vm_area_struct;
 #define __GFP_NO_GROW	0x2000u	/* Slab internal usage */
 #define __GFP_COMP	0x4000u	/* Add compound page metadata */
 #define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
+#define __GFP_MEMPOOL	0x10000u/* Mempool allocation */
 
-#define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
+#define __GFP_BITS_SHIFT 17	/* Room for 17 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
-			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
-			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
+			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL| \
+			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_ZERO| \
+			__GFP_MEMPOOL)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
Index: linux-2.6/mm/mempool.c
===================================================================
--- linux-2.6.orig/mm/mempool.c	2005-04-11 22:18:51.000000000 +1000
+++ linux-2.6/mm/mempool.c	2005-04-11 22:38:08.000000000 +1000
@@ -198,31 +198,21 @@ void * mempool_alloc(mempool_t *pool, un
 	void *element;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
-	int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
-
+	int gfp_temp;
+	
 	might_sleep_if(gfp_mask & __GFP_WAIT);
+
+	gfp_mask |= __GFP_MEMPOOL;
+	gfp_mask |= __GFP_NOWARN;	/* failures are OK */
+
+	gfp_temp = gfp_mask & ~__GFP_WAIT;
+
 repeat_alloc:
-	element = pool->alloc(gfp_nowait|__GFP_NOWARN, pool->pool_data);
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
@@ -235,6 +225,8 @@ repeat_alloc:
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;
 
+	/* Now start performing page reclaim */
+	gfp_temp = gfp_mask;
 	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
 	mb();
 	if (!pool->curr_nr)
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2005-04-11 22:18:51.000000000 +1000
+++ linux-2.6/mm/page_alloc.c	2005-04-11 22:38:07.000000000 +1000
@@ -799,14 +799,18 @@ __alloc_pages(unsigned int __nocast gfp_
 	}
 
 	/* This allocation should allow future memory freeing. */
-	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE))) && !in_interrupt()) {
-		/* go through the zonelist yet again, ignoring mins */
-		for (i = 0; (z = zones[i]) != NULL; i++) {
-			if (!cpuset_zone_allowed(z))
-				continue;
-			page = buffered_rmqueue(z, order, gfp_mask);
-			if (page)
-				goto got_pg;
+
+	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
+			&& !in_interrupt()) {
+		if (!(gfp_mask & __GFP_MEMPOOL)) {
+			/* go through the zonelist yet again, ignoring mins */
+			for (i = 0; (z = zones[i]) != NULL; i++) {
+				if (!cpuset_zone_allowed(z))
+					continue;
+				page = buffered_rmqueue(z, order, gfp_mask);
+				if (page)
+					goto got_pg;
+			}
 		}
 		goto nopage;
 	}
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c	2005-04-11 22:18:50.000000000 +1000
+++ linux-2.6/mm/swap_state.c	2005-04-11 22:38:08.000000000 +1000
@@ -143,7 +143,6 @@ void __delete_from_swap_cache(struct pag
 int add_to_swap(struct page * page)
 {
 	swp_entry_t entry;
-	int pf_flags;
 	int err;
 
 	if (!PageLocked(page))
@@ -154,30 +153,11 @@ int add_to_swap(struct page * page)
 		if (!entry.val)
 			return 0;
 
-		/* Radix-tree node allocations are performing
-		 * GFP_ATOMIC allocations under PF_MEMALLOC.  
-		 * They can completely exhaust the page allocator.  
-		 *
-		 * So PF_MEMALLOC is dropped here.  This causes the slab 
-		 * allocations to fail earlier, so radix-tree nodes will 
-		 * then be allocated from the mempool reserves.
-		 *
-		 * We're still using __GFP_HIGH for radix-tree node
-		 * allocations, so some of the emergency pools are available,
-		 * just not all of them.
-		 */
-
-		pf_flags = current->flags;
-		current->flags &= ~PF_MEMALLOC;
-
 		/*
 		 * Add it to the swap cache and mark it dirty
 		 */
 		err = __add_to_swap_cache(page, entry, GFP_ATOMIC|__GFP_NOWARN);
 
-		if (pf_flags & PF_MEMALLOC)
-			current->flags |= PF_MEMALLOC;
-
 		switch (err) {
 		case 0:				/* Success */
 			SetPageUptodate(page);

--------------090808000104070809060407--

