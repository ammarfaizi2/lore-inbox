Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVDYD7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVDYD7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 23:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVDYD7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 23:59:04 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:40119 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262525AbVDYD6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 23:58:49 -0400
Message-ID: <426C6AF2.9090406@yahoo.com.au>
Date: Mon, 25 Apr 2005 13:58:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] optimise loop driver a bit
Content-Type: multipart/mixed;
 boundary="------------080101040609090402070600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080101040609090402070600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paul McKenney would be proud ;)

Any good, Jens?

-- 
SUSE Labs, Novell Inc.

--------------080101040609090402070600
Content-Type: text/plain;
 name="loop-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="loop-opt.patch"

With the previous bug, I initially started looking in the loop driver
for the problem.

Looks like locking can be optimised quite a lot. Increase lock widths
slightly so lo_lock is taken fewer times per request. Also it was quite
trivial to cover lo_pending with that lock, and remove the atomic requirement.
This also makes memory ordering explicitly correct, which is nice (not that
I particularly saw any mem ordering bugs).

Test was reading 4 250MB files in parallel on ext2-on-tmpfs filesystem
(1K block size, 4K page size). System is 2 socket Xeon with HT (4 thread).

intel:/home/npiggin# umount /dev/loop0 ; mount /dev/loop0 /mnt/loop ; /usr/bin/time ./mtloop.sh

Before:
0.24user 5.51system 0:02.84elapsed 202%CPU (0avgtext+0avgdata 0maxresident)k
0.19user 5.52system 0:02.88elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
0.19user 5.57system 0:02.89elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
0.22user 5.51system 0:02.90elapsed 197%CPU (0avgtext+0avgdata 0maxresident)k
0.19user 5.44system 0:02.91elapsed 193%CPU (0avgtext+0avgdata 0maxresident)k

After:
0.07user 2.34system 0:01.68elapsed 143%CPU (0avgtext+0avgdata 0maxresident)k
0.06user 2.37system 0:01.68elapsed 144%CPU (0avgtext+0avgdata 0maxresident)k
0.06user 2.39system 0:01.68elapsed 145%CPU (0avgtext+0avgdata 0maxresident)k
0.06user 2.36system 0:01.68elapsed 144%CPU (0avgtext+0avgdata 0maxresident)k
0.06user 2.42system 0:01.68elapsed 147%CPU (0avgtext+0avgdata 0maxresident)k

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/drivers/block/loop.c
===================================================================
--- linux-2.6.orig/drivers/block/loop.c	2005-04-25 13:15:28.000000000 +1000
+++ linux-2.6/drivers/block/loop.c	2005-04-25 13:37:45.000000000 +1000
@@ -472,17 +472,11 @@ static int do_bio_filebacked(struct loop
  */
 static void loop_add_bio(struct loop_device *lo, struct bio *bio)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&lo->lo_lock, flags);
 	if (lo->lo_biotail) {
 		lo->lo_biotail->bi_next = bio;
 		lo->lo_biotail = bio;
 	} else
 		lo->lo_bio = lo->lo_biotail = bio;
-	spin_unlock_irqrestore(&lo->lo_lock, flags);
-
-	up(&lo->lo_bh_mutex);
 }
 
 /*
@@ -492,14 +486,12 @@ static struct bio *loop_get_bio(struct l
 {
 	struct bio *bio;
 
-	spin_lock_irq(&lo->lo_lock);
 	if ((bio = lo->lo_bio)) {
 		if (bio == lo->lo_biotail)
 			lo->lo_biotail = NULL;
 		lo->lo_bio = bio->bi_next;
 		bio->bi_next = NULL;
 	}
-	spin_unlock_irq(&lo->lo_lock);
 
 	return bio;
 }
@@ -509,35 +501,28 @@ static int loop_make_request(request_que
 	struct loop_device *lo = q->queuedata;
 	int rw = bio_rw(old_bio);
 
-	if (!lo)
-		goto out;
+	if (rw == READA)
+		rw = READ;
+
+	BUG_ON(!lo || (rw != READ && rw != WRITE));
 
 	spin_lock_irq(&lo->lo_lock);
 	if (lo->lo_state != Lo_bound)
-		goto inactive;
-	atomic_inc(&lo->lo_pending);
-	spin_unlock_irq(&lo->lo_lock);
-
-	if (rw == WRITE) {
-		if (lo->lo_flags & LO_FLAGS_READ_ONLY)
-			goto err;
-	} else if (rw == READA) {
-		rw = READ;
-	} else if (rw != READ) {
-		printk(KERN_ERR "loop: unknown command (%x)\n", rw);
-		goto err;
-	}
+		goto out;
+	if (unlikely(rw == WRITE && (lo->lo_flags & LO_FLAGS_READ_ONLY)))
+		goto out;
+	lo->lo_pending++;
 	loop_add_bio(lo, old_bio);
+	spin_unlock_irq(&lo->lo_lock);
+	up(&lo->lo_bh_mutex);
 	return 0;
-err:
-	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
+
 out:
+	if (lo->lo_pending == 0)
+		up(&lo->lo_bh_mutex);
+	spin_unlock_irq(&lo->lo_lock);
 	bio_io_error(old_bio, old_bio->bi_size);
 	return 0;
-inactive:
-	spin_unlock_irq(&lo->lo_lock);
-	goto out;
 }
 
 /*
@@ -560,13 +545,11 @@ static void do_loop_switch(struct loop_d
 
 static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
 {
-	int ret;
-
 	if (unlikely(!bio->bi_bdev)) {
 		do_loop_switch(lo, bio->bi_private);
 		bio_put(bio);
 	} else {
-		ret = do_bio_filebacked(lo, bio);
+		int ret = do_bio_filebacked(lo, bio);
 		bio_endio(bio, bio->bi_size, ret);
 	}
 }
@@ -594,7 +577,7 @@ static int loop_thread(void *data)
 	set_user_nice(current, -20);
 
 	lo->lo_state = Lo_bound;
-	atomic_inc(&lo->lo_pending);
+	lo->lo_pending = 1;
 
 	/*
 	 * up sem, we are running
@@ -602,26 +585,38 @@ static int loop_thread(void *data)
 	up(&lo->lo_sem);
 
 	for (;;) {
-		down_interruptible(&lo->lo_bh_mutex);
+		int pending;
+		
 		/*
-		 * could be upped because of tear-down, not because of
-		 * pending work
+		 * interruptible just to not contribute to load avg
 		 */
-		if (!atomic_read(&lo->lo_pending))
+		if (down_interruptible(&lo->lo_bh_mutex))
+			continue;
+
+		spin_lock_irq(&lo->lo_lock);
+		pending = lo->lo_pending;
+		
+		/*
+		 * could be upped because of tear-down, not pending work
+		 */
+		if (unlikely(!pending)) {
+			spin_unlock_irq(&lo->lo_lock);
 			break;
+		}
 
 		bio = loop_get_bio(lo);
-		if (!bio) {
-			printk("loop: missing bio\n");
-			continue;
-		}
+		pending--;
+		lo->lo_pending = pending;
+		spin_unlock_irq(&lo->lo_lock);
+
+		BUG_ON(!bio);
 		loop_handle_bio(lo, bio);
 
 		/*
 		 * upped both for pending work and tear-down, lo_pending
 		 * will hit zero then
 		 */
-		if (atomic_dec_and_test(&lo->lo_pending))
+		if (unlikely(!pending))
 			break;
 	}
 
@@ -900,7 +895,8 @@ static int loop_clr_fd(struct loop_devic
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
-	if (atomic_dec_and_test(&lo->lo_pending))
+	lo->lo_pending--;
+	if (!lo->lo_pending)
 		up(&lo->lo_bh_mutex);
 	spin_unlock_irq(&lo->lo_lock);
 
Index: linux-2.6/include/linux/loop.h
===================================================================
--- linux-2.6.orig/include/linux/loop.h	2005-04-25 13:15:28.000000000 +1000
+++ linux-2.6/include/linux/loop.h	2005-04-25 13:37:45.000000000 +1000
@@ -61,7 +61,7 @@ struct loop_device {
 	struct semaphore	lo_sem;
 	struct semaphore	lo_ctl_mutex;
 	struct semaphore	lo_bh_mutex;
-	atomic_t		lo_pending;
+	int			lo_pending;
 
 	request_queue_t		*lo_queue;
 };

--------------080101040609090402070600--

