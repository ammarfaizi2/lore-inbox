Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSBKJm7>; Mon, 11 Feb 2002 04:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSBKJmu>; Mon, 11 Feb 2002 04:42:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21010 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287647AbSBKJmh>;
	Mon, 11 Feb 2002 04:42:37 -0500
Message-ID: <3C6791C0.63CA2677@zip.com.au>
Date: Mon, 11 Feb 2002 01:41:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C639060.A68A42CA@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Here's a patch which addresses the get_request starvation problem.
> 

Sharp-eyed Suparna noticed that the algorithm still works if the
low-water mark is set to zero (ie: rip it out) so I did that and
the code is a little simpler.   Updated patch at
http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/make_request.patch

Also, here's a patch which fixes the /bin/sync livelock in
write_unlocked_buffers().  It simply bales out after writing
all the buffers which were dirty at the time the function
was called, rather than keeping on trying to write buffers
until the list is empty.

Given that /bin/sync calls write_unlocked_buffers() three times,
that's good enough.  sync still takes aaaaaages, but it terminates.

The similar livelock in invalidate_bdev() is a bit trickier.  I'm
not really sure what the semantics of invalidate_bdev() against a
device which has an r/w filesystem mounted on it are supposed to be.
I suspect we should just not call the function if the device is in
use, or call fsync_dev() or something.





--- linux-2.4.18-pre9/fs/buffer.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/fs/buffer.c	Sun Feb 10 21:50:48 2002
@@ -188,12 +188,13 @@ static void write_locked_buffers(struct 
  * return without it!
  */
 #define NRSYNC (32)
-static int write_some_buffers(kdev_t dev)
+static int write_some_buffers(kdev_t dev, signed long *nr_to_write)
 {
 	struct buffer_head *next;
 	struct buffer_head *array[NRSYNC];
 	unsigned int count;
 	int nr;
+	int ret;
 
 	next = lru_list[BUF_DIRTY];
 	nr = nr_buffers_type[BUF_DIRTY];
@@ -212,29 +213,38 @@ static int write_some_buffers(kdev_t dev
 			array[count++] = bh;
 			if (count < NRSYNC)
 				continue;
-
-			spin_unlock(&lru_list_lock);
-			write_locked_buffers(array, count);
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto writeout;
 		}
 		unlock_buffer(bh);
 		__refile_buffer(bh);
 	}
+	ret = 0;
+writeout:
 	spin_unlock(&lru_list_lock);
-
-	if (count)
+	if (count) {
 		write_locked_buffers(array, count);
-	return 0;
+		if (nr_to_write)
+			*nr_to_write -= count;
+	}
+	return ret;
 }
 
 /*
- * Write out all buffers on the dirty list.
+ * Because we drop the locking during I/O it's not possible
+ * to write out all the buffers.  So the only guarantee that
+ * we can make here is that we write out all the buffers which
+ * were dirty at the time write_unlocked_buffers() was called.
+ * fsync_dev() calls in here three times, so we end up writing
+ * many more buffers than ever appear on BUF_DIRTY.
  */
 static void write_unlocked_buffers(kdev_t dev)
 {
+	signed long nr_to_write = nr_buffers_type[BUF_DIRTY] * 2;
+
 	do {
 		spin_lock(&lru_list_lock);
-	} while (write_some_buffers(dev));
+	} while (write_some_buffers(dev, &nr_to_write) && (nr_to_write > 0));
 	run_task_queue(&tq_disk);
 }
 
@@ -1079,7 +1089,7 @@ void balance_dirty(void)
 
 	/* If we're getting into imbalance, start write-out */
 	spin_lock(&lru_list_lock);
-	write_some_buffers(NODEV);
+	write_some_buffers(NODEV, NULL);
 
 	/*
 	 * And if we're _really_ out of balance, wait for
@@ -2852,7 +2862,7 @@ static int sync_old_buffers(void)
 		bh = lru_list[BUF_DIRTY];
 		if (!bh || time_before(jiffies, bh->b_flushtime))
 			break;
-		if (write_some_buffers(NODEV))
+		if (write_some_buffers(NODEV, NULL))
 			continue;
 		return 0;
 	}
@@ -2951,7 +2961,7 @@ int bdflush(void *startup)
 		CHECK_EMERGENCY_SYNC
 
 		spin_lock(&lru_list_lock);
-		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
+		if (!write_some_buffers(NODEV, NULL) || balance_dirty_state() < 0) {
 			wait_for_some_buffers(NODEV);
 			interruptible_sleep_on(&bdflush_wait);
 		}


-
