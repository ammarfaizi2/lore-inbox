Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbTCLMtO>; Wed, 12 Mar 2003 07:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263169AbTCLMtO>; Wed, 12 Mar 2003 07:49:14 -0500
Received: from [80.190.48.67] ([80.190.48.67]:51204 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S263167AbTCLMtI>; Wed, 12 Mar 2003 07:49:08 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Charles-Edouard Ruault <kernel@ruault.com>, linux-kernel@vger.kernel.org
Subject: Re: [kernel 2.4.21-pre5 : process stuck in D state
Date: Wed, 12 Mar 2003 13:59:32 +0100
User-Agent: KMail/1.4.3
References: <3E6F199E.5000001@ruault.com>
In-Reply-To: <3E6F199E.5000001@ruault.com>
MIME-Version: 1.0
Message-Id: <200303121241.41914.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_830N0HPZW9R8BOFSX1YG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_830N0HPZW9R8BOFSX1YG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 12 March 2003 12:27, Charles-Edouard Ruault wrote:

Hi Charles-Edouard,

> i've been running kernel 2.4.21-preX series for a while on my ASUS A7V8=
X
> motherboard ( with an athlon XP 2400+ )  and i've noticed the following
> annoying problem.
> Very often, mozilla ( 1.2.1 ) dies and is stuck in D state, waiting on =
a
> semaphore, here's the output of ps :
>
> ps -elf | grep mozill
> 000 S userX 2615  1462  0  69   0    -   972 wait4  00:50 ?
> 00:00:00 /bin/sh /usr/local/mozilla/run-mozilla.sh
> /usr/local/mozilla/mozilla-bin
> 000 D userX   2621  2615  0  69   0    - 13623 down   00:50 ?
> 00:00:02 /usr/local/mozilla/mozilla-bin
>
> Has anyone noticed the same behaviour ? Is this a well known problem ?
> Thanks for your help.
There is a patch from Andrea for a long long time now. You may try it.

ciao, Marc





--------------Boundary-00=_830N0HPZW9R8BOFSX1YG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-pausing-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-pausing-2.patch"

diff -urNp x-ref/drivers/block/ll_rw_blk.c x/drivers/block/ll_rw_blk.c
--- x-ref/drivers/block/ll_rw_blk.c	Tue Nov 19 19:45:56 2002
+++ x/drivers/block/ll_rw_blk.c	Tue Nov 19 19:46:19 2002
@@ -596,12 +596,20 @@ static struct request *__get_request_wai
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
@@ -611,6 +619,17 @@ static struct request *__get_request_wai
 	return rq;
 }
 
+static void get_request_wait_wakeup(request_queue_t *q, int rw)
+{
+	/*
+	 * avoid losing an unplug if a second __get_request_wait did the
+	 * generic_unplug_device while our __get_request_wait was running
+	 * w/o the io_request_lock held and w/ our request out of the queue.
+	 */
+	if (waitqueue_active(&q->wait_for_requests[rw]))
+		wake_up(&q->wait_for_requests[rw]);
+}
+
 /* RO fail safe mechanism */
 
 static long ro_bits[MAX_BLKDEV][8];
@@ -835,9 +854,11 @@ void blkdev_release_request(struct reque
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
 
@@ -955,7 +976,6 @@ static int __make_request(request_queue_
 	 */
 	max_sectors = get_max_sectors(bh->b_rdev);
 
-again:
 	req = NULL;
 	head = &q->queue_head;
 	/*
@@ -964,6 +984,7 @@ again:
 	 */
 	spin_lock_irq(&io_request_lock);
 
+again:
 	insert_here = head->prev;
 	if (list_empty(head)) {
 		q->plug_device_fn(q, bh->b_rdev); /* is atomic */
@@ -1049,6 +1070,9 @@ get_rq:
 			if (req == NULL) {
 				spin_unlock_irq(&io_request_lock);
 				freereq = __get_request_wait(q, rw);
+				head = &q->queue_head;
+				spin_lock_irq(&io_request_lock);
+				get_request_wait_wakeup(q, rw);
 				goto again;
 			}
 		}
@@ -1206,6 +1230,11 @@ void __submit_bh(int rw, struct buffer_h
 
 	generic_make_request(rw, bh);
 
+	/* fix race condition with wait_on_buffer() */
+	smp_mb(); /* spin_unlock may have inclusive semantics */
+	if (waitqueue_active(&bh->b_wait))
+		wake_up(&bh->b_wait);
+
 	switch (rw) {
 		case WRITE:
 			kstat.pgpgout += count;
diff -urNp x-ref/fs/buffer.c x/fs/buffer.c
--- x-ref/fs/buffer.c	Tue Nov 19 19:45:56 2002
+++ x/fs/buffer.c	Tue Nov 19 19:46:19 2002
@@ -158,10 +158,23 @@ void __wait_on_buffer(struct buffer_head
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
@@ -1531,6 +1544,9 @@ static int __block_write_full_page(struc
 
 	/* Done - end_buffer_io_async will unlock */
 	SetPageUptodate(page);
+
+	wakeup_page_waiters(page);
+
 	return 0;
 
 out:
@@ -1562,6 +1578,7 @@ out:
 	} while (bh != head);
 	if (need_unlock)
 		UnlockPage(page);
+	wakeup_page_waiters(page);
 	return err;
 }
 
@@ -1796,6 +1813,8 @@ int block_read_full_page(struct page *pa
 		else
 			submit_bh(READ, bh);
 	}
+
+	wakeup_page_waiters(page);
 	
 	return 0;
 }
@@ -2424,6 +2443,7 @@ int brw_page(int rw, struct page *page, 
 		submit_bh(rw, bh);
 		bh = next;
 	} while (bh != head);
+	wakeup_page_waiters(page);
 	return 0;
 }
 
diff -urNp x-ref/fs/reiserfs/inode.c x/fs/reiserfs/inode.c
--- x-ref/fs/reiserfs/inode.c	Tue Nov 19 19:45:46 2002
+++ x/fs/reiserfs/inode.c	Tue Nov 19 19:46:19 2002
@@ -1999,6 +1999,7 @@ static int reiserfs_write_full_page(stru
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         UnlockPage(page) ;
     }
diff -urNp x-ref/include/linux/pagemap.h x/include/linux/pagemap.h
--- x-ref/include/linux/pagemap.h	Tue Nov 19 19:45:56 2002
+++ x/include/linux/pagemap.h	Tue Nov 19 19:46:19 2002
@@ -98,6 +98,8 @@ static inline void wait_on_page(struct p
 		___wait_on_page(page);
 }
 
+extern void FASTCALL(wakeup_page_waiters(struct page * page));
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
diff -urNp x-ref/kernel/ksyms.c x/kernel/ksyms.c
--- x-ref/kernel/ksyms.c	Tue Nov 19 19:45:56 2002
+++ x/kernel/ksyms.c	Tue Nov 19 19:46:25 2002
@@ -315,6 +315,7 @@ EXPORT_SYMBOL(filemap_fdatasync);
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);
diff -urNp x-ref/mm/filemap.c x/mm/filemap.c
--- x-ref/mm/filemap.c	Tue Nov 19 19:45:56 2002
+++ x/mm/filemap.c	Tue Nov 19 19:46:19 2002
@@ -771,6 +771,20 @@ inline wait_queue_head_t * page_waitqueu
 	return &wait[hash];
 }
 
+/*
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
 /* 
  * Wait for a page to get unlocked.
  *

--------------Boundary-00=_830N0HPZW9R8BOFSX1YG--


