Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291243AbSBLXOZ>; Tue, 12 Feb 2002 18:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291245AbSBLXOS>; Tue, 12 Feb 2002 18:14:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3333 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291250AbSBLXOF>;
	Tue, 12 Feb 2002 18:14:05 -0500
Message-ID: <3C69A18A.501BAD42@zip.com.au>
Date: Tue, 12 Feb 2002 15:13:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] sys_sync livelock fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The get_request fairness patch exposed a livelock
in the buffer layer.  write_unlocked_buffers() will
not terminate while other tasks are generating write traffic.

The patch simply bales out after writing all the buffers which
were dirty at the time the function was called, rather than
keeping on trying to write buffers until the list is empty.

Given that /bin/sync calls write_unlocked_buffers() three times,
that's good enough.  sync still takes aaaaaages, but it terminates.




--- linux-2.4.18-pre9-ac2/fs/buffer.c	Tue Feb 12 12:26:41 2002
+++ ac24/fs/buffer.c	Tue Feb 12 14:39:39 2002
@@ -189,12 +189,13 @@ static void write_locked_buffers(struct 
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
@@ -213,29 +214,38 @@ static int write_some_buffers(kdev_t dev
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
 
@@ -1085,7 +1095,7 @@ void balance_dirty(void)
 	 */
 	if (state > 0) {
 		spin_lock(&lru_list_lock);
-		write_some_buffers(NODEV);
+		write_some_buffers(NODEV, NULL);
 		wait_for_some_buffers(NODEV);
 	}
 }
@@ -2846,7 +2856,7 @@ static int sync_old_buffers(void)
 		bh = lru_list[BUF_DIRTY];
 		if (!bh || time_before(jiffies, bh->b_flushtime))
 			break;
-		if (write_some_buffers(NODEV))
+		if (write_some_buffers(NODEV, NULL))
 			continue;
 		return 0;
 	}
@@ -2945,7 +2955,7 @@ int bdflush(void *startup)
 		CHECK_EMERGENCY_SYNC
 
 		spin_lock(&lru_list_lock);
-		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
+		if (!write_some_buffers(NODEV, NULL) || balance_dirty_state() < 0) {
 			wait_for_some_buffers(NODEV);
 			interruptible_sleep_on(&bdflush_wait);
 		}


-
