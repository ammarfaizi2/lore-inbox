Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbSKLDuz>; Mon, 11 Nov 2002 22:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266180AbSKLDuz>; Mon, 11 Nov 2002 22:50:55 -0500
Received: from [195.223.140.107] ([195.223.140.107]:13702 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266175AbSKLDus>;
	Mon, 11 Nov 2002 22:50:48 -0500
Date: Tue, 12 Nov 2002 04:57:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Message-ID: <20021112035723.GA17642@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I recently found and fixed a misterious hang that could hang the
kernel with tasks in D state with the disk idle.  We could reproduce
very long hangs (several hours) with tasks in D state with reiserfs
after some hour of some intensive load running (not cerberus, see below
why), but it wasn't a reiserfs specific problem, reiserfs just happens
to take the lock_super while doing the fsync_buffer_list and this leads
kupdate to get stuck in the lock_super waiting a wait_on_buffer to
return, so with kupdate stuck the background run_task_queue() doesn't
run every 5 seconds anymore and in turn if there's a missing unplug
somewhere it will lead to an hanging machine in wait_on_buffer for
indefinite/infinite time (kind of deadlock, unless somebody can trigger
a readpage or something that unplugs the disk queue, usually logging in
with ssh fixed the problem). Increasing singificantly the kupdate
interval would potentially lead to the same indefinite hang on a ext2
while running fsync.

For some time I didn't even consider the possibility of wait_on_buffer
being the problem, there are over 700 patches applied in the kernel
where we could reproduce so for some time I was looking at everything
but the buggy place.  After ruling out various other bits
(scheduler fixes/compiler/fsync corruption fixes etc..) I actually
realized the problem is a longstanding design locking problem in
wait_on_buffer (then I found the same problem in wait_on_page and
yesterday Chris found a similar problem in get_request_wait too, the
get_request_wait is not exactly the same issue, but it's quite similar
and it could lead to exactly the same hangs).

Probably nobody noticed this yet because normally with ext2/ext3 these
hangs happens in all the machines but they are resolved after a disk
idle time of 2.5 seconds in mean and they happens once in a while,
normally people would see mean delays of 2.5 sec caming from the
datacenter and they would think it's a normal I/O congestion or the
elevator or something during the fsync on ext2.  Furthmore as Chris
pointed out with very intensive load bdflush would be usually running in
the background, this race can trigger only with mid writepage loads when
bdflush/pdflush has no reason to run.

We also have the lowlatency fixes (they're fixes) inside submit_bh so we
probably opened a larger window for the race to trigger than mainline.
Chris also double checked the bug we were facing was really this race by
introducing a delay in submit_bh to make it reproducible in a reasonable
amount of time.

the race looks like this:

        CPU0                    CPU1 
        -----------------       ------------------------ 
        reiserfs_writepage 
        lock_buffer() 
                                fsync_buffers_list() under lock_super() 
                                wait_on_buffer() 
                                run_task_queue(&tq_disk) -> noop 
                                schedule() <- hang with lock_super acquired 
        submit_bh() 
        /* don't unplug here */ 
 
This example is reiserfs specific but any wait_on_buffer can definitely
hang indefinitely against any concurrent ll_rw_block or submit_bh (even
on UP since submit_bh is a blocking operation and in particular with the
lowlat fixes). There's no big kernel lock anymore serializing
wait_on_buffer/ll_rw_block.  This design locking problem was introduced
with the removal of the BKL from wait_on_buffer/wait_on_page/ll_rw_blk
during one of the 2.3 scalability efforts. So any 2.4 kernel out there
is affected by this race.

in short the problem here is that the wait_on_"something" has no clue if
the locked "something" is just inserted in the I/O queue and visible to the
device, so it has no clue if the run_task_queue may become a noop or if
it may affect the "something". And the writer side that executes the
submit_bh won't unplug the queue rightfully (to allow merging and boost
performance until somebody actually asks for the I/O completed ASAP).

I fixed the race by simply doing a wakeup of any waiter after any
submit_bh/submit_bio that left stuff pending in the I/O queue. So if the
race triggers now the wait_on_something will get a wakeup and in turn it
will trigger the unplug again closing the window for the race. This is
fixing the problem in practice and it seems the best fix at least for
2.4, and I don't see any potential performance regression, so I don't
feel the need of anything more complicated than this, the race triggers
once every several hours only under some special workload. You may try
to avoid loading the waitqueue head cacheline during submit_bh, but at
least for 2.4 I don't think it worth the complexity and it's an I/O path
anyways so it's certainly not critical.

The problem noticed by Chris with get_request_wait is similar, the
unplugging was run before adding the task to the waitqueue, so the
unplug could free the requests and somebody else could allocate the
freed requests without unplugging the queue afterwards. I fixed it simply
by unplugging the queue just before schedule(). That was really a more
genuine bug than the other subtle ones. With get_request_wait the fix is
so simple because we deal with entities that are guaranteed to be
affected by the queue unplug always (they're the I/O requests), this
isn't the case with the locked bh or locked/writeback pages, that was
infact the wrong assumption that allowed the other races to trigger in the
first place.

while doing these fixes I noticed various other bits:

1) in general the blk_run_queues()/run_task_queue()/sync_page should
always run just before schedule(), it's pointless to unplug anything if
we don't run schedule (ultramicrooptimization)
2) in 2.4 the run_task_queue() in wait_on_buffer could have its
TQ_ACTIVE executed inside the add_wait_queue critical section since
spin_unlock has inclusive semantics (literally speculative reads can
pass the spin_unlock even on x86/x86-64)
3) the __blk_put_request/blkdev_release_request was increasing the count
and reading the waitqueue contents without even a barrier() for the asm
layer, it needs an smp_mb() in between to serialize against
get_request_wait that runs locklessy

I did two patches one for 2.4.20rc1 and one for 2.5.47 (sorry no bk
tree here, I will try to make bitdropper.py available shortly so I can
access the new info encoded in proprietary form too) that will address
all these races.  However 2.5 should be analysed further, I didn't
search too hard for all the possible places that could have this race in
2.5, I searched hard in 2.4 and I only addressed all the same problems
in 2.5. The only bit I think could be problematic in 2.4 is the nfs
specualtive I/O, the reason nfs is implementing a sync_page in the first
place. That may have the same race, I heard infact of some report with
nfs hung in wait_on_page, and I wonder if this could explain it too.
I assume the fs maintainers will take care of checking their fs for
missing wakeups of page waiters in 2.4 and 2.5 now that the problem is
well known.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.20rc1/fix-pausing-1
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.5/2.5.47/fix-pausing-1

they're attached to this email too since they're tiny.

Andrea

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fix-pausing-1

diff -urNp 2.4.20rc1/drivers/block/ll_rw_blk.c hangs-2.4/drivers/block/ll_rw_blk.c
--- 2.4.20rc1/drivers/block/ll_rw_blk.c	Sat Nov  2 19:45:33 2002
+++ hangs-2.4/drivers/block/ll_rw_blk.c	Tue Nov 12 02:18:35 2002
@@ -590,12 +590,20 @@ static struct request *__get_request_wai
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
-	generic_unplug_device(q);
 	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (q->rq[rw].count == 0)
+		if (q->rq[rw].count == 0) {
+			/*
+			 * All we care about is not to stall if any request
+			 * is been released after we set TASK_UNINTERRUPTIBLE.
+			 * This is the most efficient place to unplug the queue
+			 * in case we hit the race and we can get the request
+			 * without waiting.
+			 */
+			generic_unplug_device(q);
 			schedule();
+		}
 		spin_lock_irq(&io_request_lock);
 		rq = get_request(q, rw);
 		spin_unlock_irq(&io_request_lock);
@@ -829,9 +837,11 @@ void blkdev_release_request(struct reque
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests &&
-				waitqueue_active(&q->wait_for_requests[rw]))
-			wake_up(&q->wait_for_requests[rw]);
+		if (++q->rq[rw].count >= q->batch_requests) {
+			smp_mb();
+			if (waitqueue_active(&q->wait_for_requests[rw]))
+				wake_up(&q->wait_for_requests[rw]);
+		}
 	}
 }
 
@@ -1200,6 +1210,11 @@ void submit_bh(int rw, struct buffer_hea
 
 	generic_make_request(rw, bh);
 
+	/* fix race condition with wait_on_buffer() */
+	smp_mb(); /* spin_unlock may have inclusive semantics */
+	if (waitqueue_active(&bh->b_wait))
+		wake_up(&bh->b_wait);
+
 	switch (rw) {
 		case WRITE:
 			kstat.pgpgout += count;
diff -urNp 2.4.20rc1/fs/buffer.c hangs-2.4/fs/buffer.c
--- 2.4.20rc1/fs/buffer.c	Sat Nov  2 19:45:40 2002
+++ hangs-2.4/fs/buffer.c	Tue Nov 12 02:17:56 2002
@@ -153,10 +153,23 @@ void __wait_on_buffer(struct buffer_head
 	get_bh(bh);
 	add_wait_queue(&bh->b_wait, &wait);
 	do {
-		run_task_queue(&tq_disk);
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!buffer_locked(bh))
 			break;
+		/*
+		 * We must read tq_disk in TQ_ACTIVE after the
+		 * add_wait_queue effect is visible to other cpus.
+		 * We could unplug some line above it wouldn't matter
+		 * but we can't do that right after add_wait_queue
+		 * without an smp_mb() in between because spin_unlock
+		 * has inclusive semantics.
+		 * Doing it here is the most efficient place so we
+		 * don't do a suprious unplug if we get a racy
+		 * wakeup that make buffer_locked to return 0, and
+		 * doing it here avoids an explicit smp_mb() we
+		 * rely on the implicit one in set_task_state.
+		 */
+		run_task_queue(&tq_disk);
 		schedule();
 	} while (buffer_locked(bh));
 	tsk->state = TASK_RUNNING;
@@ -1508,6 +1521,9 @@ static int __block_write_full_page(struc
 
 	/* Done - end_buffer_io_async will unlock */
 	SetPageUptodate(page);
+
+	wakeup_page_waiters(page);
+
 	return 0;
 
 out:
@@ -1539,6 +1555,7 @@ out:
 	} while (bh != head);
 	if (need_unlock)
 		UnlockPage(page);
+	wakeup_page_waiters(page);
 	return err;
 }
 
@@ -1755,6 +1772,8 @@ int block_read_full_page(struct page *pa
 		else
 			submit_bh(READ, bh);
 	}
+
+	wakeup_page_waiters(page);
 	
 	return 0;
 }
@@ -2368,6 +2387,7 @@ int brw_page(int rw, struct page *page, 
 		submit_bh(rw, bh);
 		bh = next;
 	} while (bh != head);
+	wakeup_page_waiters(page);
 	return 0;
 }
 
diff -urNp 2.4.20rc1/fs/reiserfs/inode.c hangs-2.4/fs/reiserfs/inode.c
--- 2.4.20rc1/fs/reiserfs/inode.c	Sat Nov  2 19:45:46 2002
+++ hangs-2.4/fs/reiserfs/inode.c	Tue Nov 12 02:17:56 2002
@@ -1993,6 +1993,7 @@ static int reiserfs_write_full_page(stru
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         UnlockPage(page) ;
     }
diff -urNp 2.4.20rc1/include/linux/pagemap.h hangs-2.4/include/linux/pagemap.h
--- 2.4.20rc1/include/linux/pagemap.h	Sat Nov  2 19:45:48 2002
+++ hangs-2.4/include/linux/pagemap.h	Tue Nov 12 04:35:52 2002
@@ -97,6 +97,8 @@ static inline void wait_on_page(struct p
 		___wait_on_page(page);
 }
 
+extern void wakeup_page_waiters(struct page * page);
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
diff -urNp 2.4.20rc1/kernel/ksyms.c hangs-2.4/kernel/ksyms.c
--- 2.4.20rc1/kernel/ksyms.c	Sat Nov  2 19:45:48 2002
+++ hangs-2.4/kernel/ksyms.c	Tue Nov 12 04:36:25 2002
@@ -293,6 +293,7 @@ EXPORT_SYMBOL(filemap_fdatasync);
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);
diff -urNp 2.4.20rc1/mm/filemap.c hangs-2.4/mm/filemap.c
--- 2.4.20rc1/mm/filemap.c	Sat Nov  2 19:45:48 2002
+++ hangs-2.4/mm/filemap.c	Tue Nov 12 04:35:40 2002
@@ -909,6 +909,20 @@ void lock_page(struct page *page)
 }
 
 /*
+ * This must be called after every submit_bh with end_io
+ * callbacks that would result into the blkdev layer waking
+ * up the page after a queue unplug.
+ */
+void wakeup_page_waiters(struct page * page)
+{
+	wait_queue_head_t * head;
+
+	head = page_waitqueue(page);
+	if (waitqueue_active(head))
+		wake_up(head);
+}
+
+/*
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fix-pausing-1

diff -urNp 2.5.47/drivers/block/ll_rw_blk.c hangs-2.5/drivers/block/ll_rw_blk.c
--- 2.5.47/drivers/block/ll_rw_blk.c	Tue Nov 12 01:59:41 2002
+++ hangs-2.5/drivers/block/ll_rw_blk.c	Tue Nov 12 02:37:42 2002
@@ -1281,12 +1281,13 @@ static struct request *get_request_wait(
 
 	spin_lock_prefetch(q->queue_lock);
 
-	generic_unplug_device(q);
 	do {
 		prepare_to_wait_exclusive(&rl->wait, &wait,
 					TASK_UNINTERRUPTIBLE);
-		if (!rl->count)
+		if (!rl->count){
+			generic_unplug_device(q);
 			io_schedule();
+		}
 		finish_wait(&rl->wait, &wait);
 		spin_lock_irq(q->queue_lock);
 		rq = get_request(q, rw);
@@ -1487,8 +1488,11 @@ void __blk_put_request(request_queue_t *
 		rl->count++;
 		if (rl->count >= queue_congestion_off_threshold())
 			clear_queue_congested(q, rw);
-		if (rl->count >= batch_requests && waitqueue_active(&rl->wait))
-			wake_up(&rl->wait);
+		if (rl->count >= batch_requests) {
+			smp_mb();
+			if (waitqueue_active(&rl->wait))
+				wake_up(&rl->wait);
+		}
 	}
 }
 
diff -urNp 2.5.47/fs/buffer.c hangs-2.5/fs/buffer.c
--- 2.5.47/fs/buffer.c	Tue Nov 12 01:59:42 2002
+++ hangs-2.5/fs/buffer.c	Tue Nov 12 02:47:46 2002
@@ -135,9 +135,10 @@ void __wait_on_buffer(struct buffer_head
 	get_bh(bh);
 	do {
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-		blk_run_queues();
-		if (buffer_locked(bh))
+		if (buffer_locked(bh)) {
+			blk_run_queues();
 			schedule();
+		}
 	} while (buffer_locked(bh));
 	put_bh(bh);
 	finish_wait(wqh, &wait);
@@ -1727,7 +1728,8 @@ done:
 		if (uptodate)
 			SetPageUptodate(page);
 		end_page_writeback(page);
-	}
+	} else
+		wakeup_page_waiters(page);
 	if (err == 0)
 		return ret;
 	return err;
@@ -2011,6 +2013,7 @@ int block_read_full_page(struct page *pa
 		else
 			submit_bh(READ, bh);
 	}
+	wakeup_page_waiters(page);
 	return 0;
 }
 
@@ -2315,6 +2318,8 @@ static int end_bio_bh_io_sync(struct bio
 int submit_bh(int rw, struct buffer_head * bh)
 {
 	struct bio *bio;
+	int ret;
+	wait_queue_head_t *wqh = bh_waitq_head(bh);
 
 	BUG_ON(!buffer_locked(bh));
 	BUG_ON(!buffer_mapped(bh));
@@ -2348,7 +2353,13 @@ int submit_bh(int rw, struct buffer_head
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
 
-	return submit_bio(rw, bio);
+	ret =  submit_bio(rw, bio);
+
+	smp_mb(); /* spin_unlock may have inclusive semantics */
+	if (waitqueue_active(wqh))
+		wake_up(wqh);
+
+	return ret;
 }
 
 /**
diff -urNp 2.5.47/fs/reiserfs/inode.c hangs-2.5/fs/reiserfs/inode.c
--- 2.5.47/fs/reiserfs/inode.c	Thu Oct 31 01:42:25 2002
+++ hangs-2.5/fs/reiserfs/inode.c	Tue Nov 12 02:50:47 2002
@@ -1987,6 +1987,7 @@ static int reiserfs_write_full_page(stru
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         end_page_writeback(page) ;
     }
diff -urNp 2.5.47/include/linux/pagemap.h hangs-2.5/include/linux/pagemap.h
--- 2.5.47/include/linux/pagemap.h	Tue Nov 12 01:59:43 2002
+++ hangs-2.5/include/linux/pagemap.h	Tue Nov 12 02:45:27 2002
@@ -122,4 +122,7 @@ static inline void wait_on_page_writebac
 }
 
 extern void end_page_writeback(struct page *page);
+
+extern void wakeup_page_waiters(struct page * page);
+
 #endif /* _LINUX_PAGEMAP_H */
diff -urNp 2.5.47/mm/filemap.c hangs-2.5/mm/filemap.c
--- 2.5.47/mm/filemap.c	Tue Nov 12 01:59:43 2002
+++ hangs-2.5/mm/filemap.c	Tue Nov 12 02:44:59 2002
@@ -272,9 +272,10 @@ void wait_on_page_bit(struct page *page,
 
 	do {
 		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
-		sync_page(page);
-		if (test_bit(bit_nr, &page->flags))
+		if (test_bit(bit_nr, &page->flags)) {
+			sync_page(page);
 			io_schedule();
+		}
 	} while (test_bit(bit_nr, &page->flags));
 	finish_wait(waitqueue, &wait);
 }
@@ -336,15 +337,30 @@ void __lock_page(struct page *page)
 
 	while (TestSetPageLocked(page)) {
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-		sync_page(page);
-		if (PageLocked(page))
+		if (PageLocked(page)) {
+			sync_page(page);
 			io_schedule();
+		}
 	}
 	finish_wait(wqh, &wait);
 }
 EXPORT_SYMBOL(__lock_page);
 
 /*
+ * This must be called after every submit_bh with end_io
+ * callbacks that would result into the blkdev layer waking
+ * up the page after a queue unplug.
+ */
+void wakeup_page_waiters(struct page * page)
+{
+	wait_queue_head_t * wqh;
+
+	wqh = page_waitqueue(page);
+	if (waitqueue_active(wqh))
+		wake_up(wqh);
+}
+
+/*
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */
diff -urNp 2.5.47/mm/page_io.c hangs-2.5/mm/page_io.c
--- 2.5.47/mm/page_io.c	Thu Oct 31 01:41:56 2002
+++ hangs-2.5/mm/page_io.c	Tue Nov 12 02:50:12 2002
@@ -104,6 +104,7 @@ int swap_writepage(struct page *page)
 	SetPageWriteback(page);
 	unlock_page(page);
 	submit_bio(WRITE, bio);
+	wakeup_page_waiters(page);
 out:
 	return ret;
 }
@@ -121,6 +122,7 @@ int swap_readpage(struct file *file, str
 	}
 	inc_page_state(pswpin);
 	submit_bio(READ, bio);
+	wakeup_page_waiters(page);
 out:
 	return ret;
 }
--- hangs-2.5/kernel/ksyms.c.~1~	Tue Nov 12 01:59:43 2002
+++ hangs-2.5/kernel/ksyms.c	Tue Nov 12 04:36:37 2002
@@ -336,6 +336,7 @@ EXPORT_SYMBOL(filemap_fdatawrite);
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);

--6TrnltStXW4iwmi0--
