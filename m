Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbREZAno>; Fri, 25 May 2001 20:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262308AbREZAnY>; Fri, 25 May 2001 20:43:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18732 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262304AbREZAnV>; Fri, 25 May 2001 20:43:21 -0400
Date: Sat, 26 May 2001 02:42:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
Message-ID: <20010526024230.K9634@athlon.random>
In-Reply-To: <Pine.LNX.4.31.0105251700350.15549-100000@penguin.transmeta.com> <Pine.LNX.4.33.0105252007020.3806-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105252007020.3806-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Fri, May 25, 2001 at 08:29:38PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 08:29:38PM -0400, Ben LaHaise wrote:
> amount of bounce buffers to guarentee progress while submitting io.  The
> -ac kernels have a patch from Ingo that provides private pools for bounce
> buffers and buffer_heads.  I went a step further and have a memory
> reservation patch that provides for memory pools being reserved against a
> particular zone.  This is needed to prevent the starvation that irq
> allocations can cause.
> 
> Some of these cleanups are 2.5 fodder, but we really need something in 2.4
> right now, so...

Please merge this one in 2.4 for now (originally from Ingo, I only
improved it), this is a real definitive fix and there's no nicer way to
handle that unless you want to generalize an API for people to generate
private anti-deadlock ("make sure to always make a progress") memory
pools:

diff -urN 2.4.4/mm/highmem.c highmem-deadlock/mm/highmem.c
--- 2.4.4/mm/highmem.c	Sat Apr 28 05:24:48 2001
+++ highmem-deadlock/mm/highmem.c	Sat Apr 28 18:21:24 2001
@@ -159,6 +159,19 @@
 	spin_unlock(&kmap_lock);
 }
 
+#define POOL_SIZE 32
+
+/*
+ * This lock gets no contention at all, normally.
+ */
+static spinlock_t emergency_lock = SPIN_LOCK_UNLOCKED;
+
+int nr_emergency_pages;
+static LIST_HEAD(emergency_pages);
+
+int nr_emergency_bhs;
+static LIST_HEAD(emergency_bhs);
+
 /*
  * Simple bounce buffer support for highmem pages.
  * This will be moved to the block layer in 2.5.
@@ -203,17 +216,72 @@
 
 static inline void bounce_end_io (struct buffer_head *bh, int uptodate)
 {
+	struct page *page;
 	struct buffer_head *bh_orig = (struct buffer_head *)(bh->b_private);
+	unsigned long flags;
 
 	bh_orig->b_end_io(bh_orig, uptodate);
-	__free_page(bh->b_page);
+
+	page = bh->b_page;
+
+	spin_lock_irqsave(&emergency_lock, flags);
+	if (nr_emergency_pages >= POOL_SIZE)
+		__free_page(page);
+	else {
+		/*
+		 * We are abusing page->list to manage
+		 * the highmem emergency pool:
+		 */
+		list_add(&page->list, &emergency_pages);
+		nr_emergency_pages++;
+	}
+	
+	if (nr_emergency_bhs >= POOL_SIZE) {
 #ifdef HIGHMEM_DEBUG
-	/* Don't clobber the constructed slab cache */
-	init_waitqueue_head(&bh->b_wait);
+		/* Don't clobber the constructed slab cache */
+		init_waitqueue_head(&bh->b_wait);
 #endif
-	kmem_cache_free(bh_cachep, bh);
+		kmem_cache_free(bh_cachep, bh);
+	} else {
+		/*
+		 * Ditto in the bh case, here we abuse b_inode_buffers:
+		 */
+		list_add(&bh->b_inode_buffers, &emergency_bhs);
+		nr_emergency_bhs++;
+	}
+	spin_unlock_irqrestore(&emergency_lock, flags);
 }
 
+static __init int init_emergency_pool(void)
+{
+	spin_lock_irq(&emergency_lock);
+	while (nr_emergency_pages < POOL_SIZE) {
+		struct page * page = alloc_page(GFP_ATOMIC);
+		if (!page) {
+			printk("couldn't refill highmem emergency pages");
+			break;
+		}
+		list_add(&page->list, &emergency_pages);
+		nr_emergency_pages++;
+	}
+	while (nr_emergency_bhs < POOL_SIZE) {
+		struct buffer_head * bh = kmem_cache_alloc(bh_cachep, SLAB_ATOMIC);
+		if (!bh) {
+			printk("couldn't refill highmem emergency bhs");
+			break;
+		}
+		list_add(&bh->b_inode_buffers, &emergency_bhs);
+		nr_emergency_bhs++;
+	}
+	spin_unlock_irq(&emergency_lock);
+	printk("allocated %d pages and %d bhs reserved for the highmem bounces\n",
+	       nr_emergency_pages, nr_emergency_bhs);
+
+	return 0;
+}
+
+__initcall(init_emergency_pool);
+
 static void bounce_end_io_write (struct buffer_head *bh, int uptodate)
 {
 	bounce_end_io(bh, uptodate);
@@ -228,6 +296,82 @@
 	bounce_end_io(bh, uptodate);
 }
 
+struct page *alloc_bounce_page (void)
+{
+	struct list_head *tmp;
+	struct page *page;
+
+repeat_alloc:
+	page = alloc_page(GFP_BUFFER);
+	if (page)
+		return page;
+	/*
+	 * No luck. First, kick the VM so it doesnt idle around while
+	 * we are using up our emergency rations.
+	 */
+	wakeup_bdflush(0);
+
+	/*
+	 * Try to allocate from the emergency pool.
+	 */
+	tmp = &emergency_pages;
+	spin_lock_irq(&emergency_lock);
+	if (!list_empty(tmp)) {
+		page = list_entry(tmp->next, struct page, list);
+		list_del(tmp->next);
+		nr_emergency_pages--;
+	}
+	spin_unlock_irq(&emergency_lock);
+	if (page)
+		return page;
+
+	/* we need to wait I/O completion */
+	run_task_queue(&tq_disk);
+
+	current->policy |= SCHED_YIELD;
+	__set_current_state(TASK_RUNNING);
+	schedule();
+	goto repeat_alloc;
+}
+
+struct buffer_head *alloc_bounce_bh (void)
+{
+	struct list_head *tmp;
+	struct buffer_head *bh;
+
+repeat_alloc:
+	bh = kmem_cache_alloc(bh_cachep, SLAB_BUFFER);
+	if (bh)
+		return bh;
+	/*
+	 * No luck. First, kick the VM so it doesnt idle around while
+	 * we are using up our emergency rations.
+	 */
+	wakeup_bdflush(0);
+
+	/*
+	 * Try to allocate from the emergency pool.
+	 */
+	tmp = &emergency_bhs;
+	spin_lock_irq(&emergency_lock);
+	if (!list_empty(tmp)) {
+		bh = list_entry(tmp->next, struct buffer_head, b_inode_buffers);
+		list_del(tmp->next);
+		nr_emergency_bhs--;
+	}
+	spin_unlock_irq(&emergency_lock);
+	if (bh)
+		return bh;
+
+	/* we need to wait I/O completion */
+	run_task_queue(&tq_disk);
+
+	current->policy |= SCHED_YIELD;
+	__set_current_state(TASK_RUNNING);
+	schedule();
+	goto repeat_alloc;
+}
+
 struct buffer_head * create_bounce(int rw, struct buffer_head * bh_orig)
 {
 	struct page *page;
@@ -236,24 +380,15 @@
 	if (!PageHighMem(bh_orig->b_page))
 		return bh_orig;
 
-repeat_bh:
-	bh = kmem_cache_alloc(bh_cachep, SLAB_BUFFER);
-	if (!bh) {
-		wakeup_bdflush(1);  /* Sets task->state to TASK_RUNNING */
-		goto repeat_bh;
-	}
+	bh = alloc_bounce_bh();
 	/*
 	 * This is wasteful for 1k buffers, but this is a stopgap measure
 	 * and we are being ineffective anyway. This approach simplifies
 	 * things immensly. On boxes with more than 4GB RAM this should
 	 * not be an issue anyway.
 	 */
-repeat_page:
-	page = alloc_page(GFP_BUFFER);
-	if (!page) {
-		wakeup_bdflush(1);  /* Sets task->state to TASK_RUNNING */
-		goto repeat_page;
-	}
+	page = alloc_bounce_page();
+
 	set_bh_page(bh, page, 0);
 
 	bh->b_next = NULL;


And this one as well to avoid tight loops in getblk without reschedules
in between when normal zone is empty:

diff -urN 2.4.4pre1/fs/buffer.c 2.4.4pre1-blkdev/fs/buffer.c
--- 2.4.4pre1/fs/buffer.c	Sun Apr  1 01:17:30 2001
+++ 2.4.4pre1-blkdev/fs/buffer.c	Mon Apr  9 15:37:20 2001
@@ -628,7 +622,7 @@
    to do in order to release the ramdisk memory is to destroy dirty buffers.
 
    These are two special cases. Normal usage imply the device driver
-   to issue a sync on the device (without waiting I/O completation) and
+   to issue a sync on the device (without waiting I/O completion) and
    then an invalidate_buffers call that doesn't trash dirty buffers. */
 void __invalidate_buffers(kdev_t dev, int destroy_dirty_buffers)
 {
@@ -762,7 +756,12 @@
 	balance_dirty(NODEV);
 	if (free_shortage())
 		page_launder(GFP_BUFFER, 0);
-	grow_buffers(size);
+	if (!grow_buffers(size)) {
+		wakeup_bdflush(1);
+		current->policy |= SCHED_YIELD;
+		__set_current_state(TASK_RUNNING);
+		schedule();
+	}
 }
 
 void init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)
@@ -1027,12 +1026,13 @@
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
 	refill_freelist(size);
+	/* FIXME: getblk should fail if there's no enough memory */
 	goto repeat;
 }
 
 /* -1 -> no need to flush
     0 -> async flush
-    1 -> sync flush (wait for I/O completation) */
+    1 -> sync flush (wait for I/O completion) */
 int balance_dirty_state(kdev_t dev)
 {
 	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
@@ -1431,6 +1431,7 @@
 {
 	struct buffer_head *bh, *head, *tail;
 
+	/* FIXME: create_buffers should fail if there's no enough memory */
 	head = create_buffers(page, blocksize, 1);
 	if (page->buffers)
 		BUG();
@@ -2367,11 +2368,9 @@
 	spin_lock(&free_list[index].lock);
 	tmp = bh;
 	do {
-		struct buffer_head *p = tmp;
-
-		tmp = tmp->b_this_page;
-		if (buffer_busy(p))
+		if (buffer_busy(tmp))
 			goto busy_buffer_page;
+		tmp = tmp->b_this_page;
 	} while (tmp != bh);
 
 	spin_lock(&unused_list_lock);

Andrea
