Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTFIWHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTFIWHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 18:07:08 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44766
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262176AbTFIWGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 18:06:43 -0400
Date: Tue, 10 Jun 2003 00:19:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
Message-ID: <20030609221950.GF26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <1055194762.23130.370.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jun 09, 2003 at 05:39:23PM -0400, Chris Mason wrote:
> Ok, there are lots of different problems here, and I've spent a little
> while trying to get some numbers with the __get_request_wait stats patch
> I posted before.  This is all on ext2, since I wanted to rule out
> interactions with the journal flavors.
> 
> Basically a dbench 90 run on ext2 rc6 vanilla kernels can generate
> latencies of over 2700 jiffies in __get_request_wait, with an average
> latency over 250 jiffies.
> 
> No, most desktop workloads aren't dbench 90, but between balance_dirty()
> and the way we send stuff to disk during memory allocations, just about
> any process can get stuck submitting dirty buffers even if you've just
> got one process doing a dd if=/dev/zero of=foo.
> 
> So, for the moment I'm going to pretend people seeing stalls in X are
> stuck in atime updates or memory allocations, or reading proc or some
> other silly spot.  
> 
> For the SMP corner cases, I've merged Andrea's fix-pausing patch into
> rc7, along with an altered form of Nick Piggin's queue_full patch to try
> and fix the latency problems.
> 
> The major difference from Nick's patch is that once the queue is marked
> full, I don't clear the full flag until the wait queue is empty.  This
> means new io can't steal available requests until every existing waiter
> has been granted a request.
> 
> The latency results are better, with average time spent in
> __get_request_wait being around 28 jiffies, and a max of 170 jiffies. 
> The cost is throughput, further benchmarking needs to be done but, but I
> wanted to get this out for review and testing.  It should at least help
> us decide if the request allocation code really is causing our problems.
> 
> The patch below also includes the __get_request_wait latency stats.  If
> people try this and still see stalls, please run elvtune /dev/xxxx and
> send along the resulting console output.
> 
> I haven't yet compared this to Andrea's elevator latency code, but the
> stat patch was originally developed on top of his 2.4.21pre3aa1, where
> the average wait was 97 jiffies and the max was 318.
> 
> Anyway, less talk, more code.  Treat this with care, it has only been
> lightly tested.  Thanks to Andrea and Nick whose patches this is largely
> based on:

I spent last Saturday working on this too. This is the status of my
current patches, would be interesting to compare them. they're not very
well tested yet though.

They would obsoletes the old fix-pausing and the old elevator-lowlatency
(I was going to release a new tree today, but I delayed it so I fixed
uml today too first [tested with skas and w/o skas]).

those backout the rc7 interactivity changes (the only one that wasn't in
my tree was the add_wait_queue_exclusive, that IMHO would better stay
for scalability reasons).

Of course I would be very interested to know if those two patches (or
Chris's one, you also retained the exclusive wakeup) are still greatly
improved by removing the _exclusive weakups and going wake-all (in
theory they shouldn't).

Andrea

--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=9980_fix-pausing-4

diff -urNp --exclude CVS --exclude BitKeeper xx-ref/drivers/block/ll_rw_blk.c xx/drivers/block/ll_rw_blk.c
--- xx-ref/drivers/block/ll_rw_blk.c	2003-06-07 15:22:23.000000000 +0200
+++ xx/drivers/block/ll_rw_blk.c	2003-06-07 15:22:27.000000000 +0200
@@ -596,12 +596,20 @@ static struct request *__get_request_wai
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
-	add_wait_queue(&q->wait_for_requests[rw], &wait);
+	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		generic_unplug_device(q);
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
 		spin_lock_irq(q->queue_lock);
 		rq = get_request(q, rw);
 		spin_unlock_irq(q->queue_lock);
@@ -611,6 +619,17 @@ static struct request *__get_request_wai
 	return rq;
 }
 
+static void get_request_wait_wakeup(request_queue_t *q, int rw)
+{
+	/*
+	 * avoid losing an unplug if a second __get_request_wait did the
+	 * generic_unplug_device while our __get_request_wait was running
+	 * w/o the queue_lock held and w/ our request out of the queue.
+	 */
+	if (waitqueue_active(&q->wait_for_requests[rw]))
+		wake_up(&q->wait_for_requests[rw]);
+}
+
 /* RO fail safe mechanism */
 
 static long ro_bits[MAX_BLKDEV][8];
@@ -835,8 +854,11 @@ void blkdev_release_request(struct reque
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests)
-			wake_up(&q->wait_for_requests[rw]);
+		if (++q->rq[rw].count >= q->batch_requests) {
+			smp_mb();
+			if (waitqueue_active(&q->wait_for_requests[rw]))
+				wake_up(&q->wait_for_requests[rw]);
+		}
 	}
 }
 
@@ -954,7 +976,6 @@ static int __make_request(request_queue_
 	 */
 	max_sectors = get_max_sectors(bh->b_rdev);
 
-again:
 	req = NULL;
 	head = &q->queue_head;
 	/*
@@ -963,6 +984,7 @@ again:
 	 */
 	spin_lock_irq(q->queue_lock);
 
+again:
 	insert_here = head->prev;
 	if (list_empty(head)) {
 		q->plug_device_fn(q, bh->b_rdev); /* is atomic */
@@ -1048,6 +1070,9 @@ get_rq:
 			if (req == NULL) {
 				spin_unlock_irq(q->queue_lock);
 				freereq = __get_request_wait(q, rw);
+				head = &q->queue_head;
+				spin_lock_irq(q->queue_lock);
+				get_request_wait_wakeup(q, rw);
 				goto again;
 			}
 		}
@@ -1202,8 +1227,21 @@ void __submit_bh(int rw, struct buffer_h
 	bh->b_rdev = bh->b_dev;
 	bh->b_rsector = blocknr;
 
+	/*
+	 * we play with the bh wait queue below, need to keep a
+	 * reference so the buffer doesn't get freed after the
+	 * end_io handler runs
+	 */
+	get_bh(bh);
+
 	generic_make_request(rw, bh);
 
+	/* fix race condition with wait_on_buffer() */
+	smp_mb(); /* spin_unlock may have inclusive semantics */
+	if (waitqueue_active(&bh->b_wait))
+		wake_up(&bh->b_wait);
+	put_bh(bh);
+
 	switch (rw) {
 		case WRITE:
 			kstat.pgpgout += count;
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/fs/buffer.c xx/fs/buffer.c
--- xx-ref/fs/buffer.c	2003-06-07 15:22:23.000000000 +0200
+++ xx/fs/buffer.c	2003-06-07 15:22:27.000000000 +0200
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
@@ -1471,6 +1484,7 @@ static int __block_write_full_page(struc
 
 	if (!page->buffers)
 		create_empty_buffers(page, inode->i_dev, 1 << inode->i_blkbits);
+	BUG_ON(page_count(page) < 3);
 	head = page->buffers;
 
 	block = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
@@ -1517,6 +1531,9 @@ static int __block_write_full_page(struc
 
 	/* Done - end_buffer_io_async will unlock */
 	SetPageUptodate(page);
+
+	wakeup_page_waiters(page);
+
 	return 0;
 
 out:
@@ -1548,6 +1565,7 @@ out:
 	} while (bh != head);
 	if (need_unlock)
 		UnlockPage(page);
+	wakeup_page_waiters(page);
 	return err;
 }
 
@@ -1721,6 +1739,7 @@ int block_read_full_page(struct page *pa
 	blocksize = 1 << inode->i_blkbits;
 	if (!page->buffers)
 		create_empty_buffers(page, inode->i_dev, blocksize);
+	BUG_ON(page_count(page) < 3);
 	head = page->buffers;
 
 	blocks = PAGE_CACHE_SIZE >> inode->i_blkbits;
@@ -1781,6 +1800,8 @@ int block_read_full_page(struct page *pa
 		else
 			submit_bh(READ, bh);
 	}
+
+	wakeup_page_waiters(page);
 	
 	return 0;
 }
@@ -2400,6 +2421,7 @@ int brw_page(int rw, struct page *page, 
 
 	if (!page->buffers)
 		create_empty_buffers(page, dev, size);
+	BUG_ON(page_count(page) < 3);
 	head = bh = page->buffers;
 
 	/* Stage 1: lock all the buffers */
@@ -2417,6 +2439,7 @@ int brw_page(int rw, struct page *page, 
 		submit_bh(rw, bh);
 		bh = next;
 	} while (bh != head);
+	wakeup_page_waiters(page);
 	return 0;
 }
 
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/fs/reiserfs/inode.c xx/fs/reiserfs/inode.c
--- xx-ref/fs/reiserfs/inode.c	2003-06-07 15:22:11.000000000 +0200
+++ xx/fs/reiserfs/inode.c	2003-06-07 15:22:27.000000000 +0200
@@ -2048,6 +2048,7 @@ static int reiserfs_write_full_page(stru
     */
     if (nr) {
         submit_bh_for_writepage(arr, nr) ;
+	wakeup_page_waiters(page);
     } else {
         UnlockPage(page) ;
     }
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/include/linux/pagemap.h xx/include/linux/pagemap.h
--- xx-ref/include/linux/pagemap.h	2003-06-07 15:22:23.000000000 +0200
+++ xx/include/linux/pagemap.h	2003-06-07 15:22:27.000000000 +0200
@@ -98,6 +98,8 @@ static inline void wait_on_page(struct p
 		___wait_on_page(page);
 }
 
+extern void FASTCALL(wakeup_page_waiters(struct page * page));
+
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/kernel/ksyms.c xx/kernel/ksyms.c
--- xx-ref/kernel/ksyms.c	2003-06-07 15:22:23.000000000 +0200
+++ xx/kernel/ksyms.c	2003-06-07 15:22:27.000000000 +0200
@@ -319,6 +319,7 @@ EXPORT_SYMBOL(filemap_fdatasync);
 EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 EXPORT_SYMBOL(unlock_page);
+EXPORT_SYMBOL(wakeup_page_waiters);
 
 /* device registration */
 EXPORT_SYMBOL(register_chrdev);
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/mm/filemap.c xx/mm/filemap.c
--- xx-ref/mm/filemap.c	2003-06-07 15:22:23.000000000 +0200
+++ xx/mm/filemap.c	2003-06-07 15:22:27.000000000 +0200
@@ -779,6 +779,20 @@ inline wait_queue_head_t * page_waitqueu
 	return wait_table_hashfn(page, &pgdat->wait_table);
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
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/mm/swapfile.c xx/mm/swapfile.c
--- xx-ref/mm/swapfile.c	2003-06-07 15:22:23.000000000 +0200
+++ xx/mm/swapfile.c	2003-06-07 15:22:44.000000000 +0200
@@ -984,8 +984,10 @@ asmlinkage long sys_swapon(const char * 
 		goto bad_swap;
 	}
 
+	get_page(virt_to_page(swap_header));
 	lock_page(virt_to_page(swap_header));
 	rw_swap_page_nolock(READ, SWP_ENTRY(type,0), (char *) swap_header);
+	put_page(virt_to_page(swap_header));
 
 	if (!memcmp("SWAP-SPACE",swap_header->magic.magic,10))
 		swap_header_version = 1;

--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=9981_elevator-lowlatency-5

Binary files x-ref/ID and x/ID differ
diff -urNp --exclude CVS --exclude BitKeeper x-ref/drivers/block/DAC960.c x/drivers/block/DAC960.c
--- x-ref/drivers/block/DAC960.c	2002-11-29 02:22:58.000000000 +0100
+++ x/drivers/block/DAC960.c	2003-06-07 12:37:50.000000000 +0200
@@ -19,8 +19,8 @@
 */
 
 
-#define DAC960_DriverVersion			"2.4.11"
-#define DAC960_DriverDate			"11 October 2001"
+#define DAC960_DriverVersion			"2.4.20aa1"
+#define DAC960_DriverDate			"4 December 2002"
 
 
 #include <linux/version.h>
@@ -2975,8 +2975,9 @@ static boolean DAC960_ProcessRequest(DAC
   Command->SegmentCount = Request->nr_segments;
   Command->BufferHeader = Request->bh;
   Command->RequestBuffer = Request->buffer;
+  Command->Request = Request;
   blkdev_dequeue_request(Request);
-  blkdev_release_request(Request);
+  /* blkdev_release_request(Request); */
   DAC960_QueueReadWriteCommand(Command);
   return true;
 }
@@ -3023,11 +3024,12 @@ static void DAC960_RequestFunction(Reque
   individual Buffer.
 */
 
-static inline void DAC960_ProcessCompletedBuffer(BufferHeader_T *BufferHeader,
+static inline void DAC960_ProcessCompletedBuffer(IO_Request_T *Req, BufferHeader_T *BufferHeader,
 						 boolean SuccessfulIO)
 {
-  blk_finished_io(BufferHeader->b_size >> 9);
+  blk_finished_io(Req, BufferHeader->b_size >> 9);
   BufferHeader->b_end_io(BufferHeader, SuccessfulIO);
+  
 }
 
 
@@ -3116,9 +3118,10 @@ static void DAC960_V1_ProcessCompletedCo
 	    {
 	      BufferHeader_T *NextBufferHeader = BufferHeader->b_reqnext;
 	      BufferHeader->b_reqnext = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, true);
+	      DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, true);
 	      BufferHeader = NextBufferHeader;
 	    }
+  	  blkdev_release_request(Command->Request);
 	  if (Command->Completion != NULL)
 	    {
 	      complete(Command->Completion);
@@ -3161,7 +3164,7 @@ static void DAC960_V1_ProcessCompletedCo
 	    {
 	      BufferHeader_T *NextBufferHeader = BufferHeader->b_reqnext;
 	      BufferHeader->b_reqnext = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, false);
+	      DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, false);
 	      BufferHeader = NextBufferHeader;
 	    }
 	  if (Command->Completion != NULL)
@@ -3169,6 +3172,7 @@ static void DAC960_V1_ProcessCompletedCo
 	      complete(Command->Completion);
 	      Command->Completion = NULL;
 	    }
+  	  blkdev_release_request(Command->Request);
 	}
     }
   else if (CommandType == DAC960_ReadRetryCommand ||
@@ -3180,12 +3184,12 @@ static void DAC960_V1_ProcessCompletedCo
 	Perform completion processing for this single buffer.
       */
       if (CommandStatus == DAC960_V1_NormalCompletion)
-	DAC960_ProcessCompletedBuffer(BufferHeader, true);
+	DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, true);
       else
 	{
 	  if (CommandStatus != DAC960_V1_LogicalDriveNonexistentOrOffline)
 	    DAC960_V1_ReadWriteError(Command);
-	  DAC960_ProcessCompletedBuffer(BufferHeader, false);
+	  DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, false);
 	}
       if (NextBufferHeader != NULL)
 	{
@@ -3203,6 +3207,7 @@ static void DAC960_V1_ProcessCompletedCo
 	  DAC960_QueueCommand(Command);
 	  return;
 	}
+        blkdev_release_request(Command->Request);
     }
   else if (CommandType == DAC960_MonitoringCommand ||
 	   CommandOpcode == DAC960_V1_Enquiry ||
@@ -4222,9 +4227,10 @@ static void DAC960_V2_ProcessCompletedCo
 	    {
 	      BufferHeader_T *NextBufferHeader = BufferHeader->b_reqnext;
 	      BufferHeader->b_reqnext = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, true);
+	      DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, true);
 	      BufferHeader = NextBufferHeader;
 	    }
+  	  blkdev_release_request(Command->Request);
 	  if (Command->Completion != NULL)
 	    {
 	      complete(Command->Completion);
@@ -4267,9 +4273,10 @@ static void DAC960_V2_ProcessCompletedCo
 	    {
 	      BufferHeader_T *NextBufferHeader = BufferHeader->b_reqnext;
 	      BufferHeader->b_reqnext = NULL;
-	      DAC960_ProcessCompletedBuffer(BufferHeader, false);
+	      DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, false);
 	      BufferHeader = NextBufferHeader;
 	    }
+  	  blkdev_release_request(Command->Request);
 	  if (Command->Completion != NULL)
 	    {
 	      complete(Command->Completion);
@@ -4286,12 +4293,12 @@ static void DAC960_V2_ProcessCompletedCo
 	Perform completion processing for this single buffer.
       */
       if (CommandStatus == DAC960_V2_NormalCompletion)
-	DAC960_ProcessCompletedBuffer(BufferHeader, true);
+	DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, true);
       else
 	{
 	  if (Command->V2.RequestSense.SenseKey != DAC960_SenseKey_NotReady)
 	    DAC960_V2_ReadWriteError(Command);
-	  DAC960_ProcessCompletedBuffer(BufferHeader, false);
+	  DAC960_ProcessCompletedBuffer(Command->Request, BufferHeader, false);
 	}
       if (NextBufferHeader != NULL)
 	{
@@ -4319,6 +4326,7 @@ static void DAC960_V2_ProcessCompletedCo
 	  DAC960_QueueCommand(Command);
 	  return;
 	}
+        blkdev_release_request(Command->Request);
     }
   else if (CommandType == DAC960_MonitoringCommand)
     {
diff -urNp --exclude CVS --exclude BitKeeper x-ref/drivers/block/DAC960.h x/drivers/block/DAC960.h
--- x-ref/drivers/block/DAC960.h	2002-01-22 18:54:52.000000000 +0100
+++ x/drivers/block/DAC960.h	2003-06-07 12:37:50.000000000 +0200
@@ -2282,6 +2282,7 @@ typedef struct DAC960_Command
   unsigned int SegmentCount;
   BufferHeader_T *BufferHeader;
   void *RequestBuffer;
+  IO_Request_T *Request;
   union {
     struct {
       DAC960_V1_CommandMailbox_T CommandMailbox;
@@ -4265,12 +4266,4 @@ static void DAC960_Message(DAC960_Messag
 static void DAC960_CreateProcEntries(void);
 static void DAC960_DestroyProcEntries(void);
 
-
-/*
-  Export the Kernel Mode IOCTL interface.
-*/
-
-EXPORT_SYMBOL(DAC960_KernelIOCTL);
-
-
 #endif /* DAC960_DriverVersion */
diff -urNp --exclude CVS --exclude BitKeeper x-ref/drivers/block/cciss.c x/drivers/block/cciss.c
--- x-ref/drivers/block/cciss.c	2003-06-07 12:37:40.000000000 +0200
+++ x/drivers/block/cciss.c	2003-06-07 12:37:50.000000000 +0200
@@ -1990,14 +1990,14 @@ static void start_io( ctlr_info_t *h)
 	}
 }
 
-static inline void complete_buffers( struct buffer_head *bh, int status)
+static inline void complete_buffers(struct request * req, struct buffer_head *bh, int status)
 {
 	struct buffer_head *xbh;
 	
 	while(bh) {
 		xbh = bh->b_reqnext; 
 		bh->b_reqnext = NULL; 
-		blk_finished_io(bh->b_size >> 9);
+		blk_finished_io(req, bh->b_size >> 9);
 		bh->b_end_io(bh, status);
 		bh = xbh;
 	}
@@ -2140,7 +2140,7 @@ static inline void complete_command( ctl
 		pci_unmap_page(hba[cmd->ctlr]->pdev,
 			temp64.val, cmd->SG[i].Len, ddir);
 	}
-	complete_buffers(cmd->rq->bh, status);
+	complete_buffers(cmd->rq, cmd->rq->bh, status);
 #ifdef CCISS_DEBUG
 	printk("Done with %p\n", cmd->rq);
 #endif /* CCISS_DEBUG */ 
@@ -2224,7 +2224,7 @@ next:
                 printk(KERN_WARNING "doreq cmd for %d, %x at %p\n",
                                 h->ctlr, creq->rq_dev, creq);
                 blkdev_dequeue_request(creq);
-                complete_buffers(creq->bh, 0);
+                complete_buffers(creq, creq->bh, 0);
 		end_that_request_last(creq);
 		goto startio;
         }
diff -urNp --exclude CVS --exclude BitKeeper x-ref/drivers/block/cpqarray.c x/drivers/block/cpqarray.c
--- x-ref/drivers/block/cpqarray.c	2003-06-07 12:37:38.000000000 +0200
+++ x/drivers/block/cpqarray.c	2003-06-07 12:37:50.000000000 +0200
@@ -169,7 +169,7 @@ static void start_io(ctlr_info_t *h);
 
 static inline void addQ(cmdlist_t **Qptr, cmdlist_t *c);
 static inline cmdlist_t *removeQ(cmdlist_t **Qptr, cmdlist_t *c);
-static inline void complete_buffers(struct buffer_head *bh, int ok);
+static inline void complete_buffers(struct request * req, struct buffer_head *bh, int ok);
 static inline void complete_command(cmdlist_t *cmd, int timeout);
 
 static void do_ida_intr(int irq, void *dev_id, struct pt_regs * regs);
@@ -981,7 +981,7 @@ next:
 		printk(KERN_WARNING "doreq cmd for %d, %x at %p\n",
 				h->ctlr, creq->rq_dev, creq);
 		blkdev_dequeue_request(creq);
-		complete_buffers(creq->bh, 0);
+		complete_buffers(creq, creq->bh, 0);
 		end_that_request_last(creq);
 		goto startio;
 	}
@@ -1082,14 +1082,14 @@ static void start_io(ctlr_info_t *h)
 	}
 }
 
-static inline void complete_buffers(struct buffer_head *bh, int ok)
+static inline void complete_buffers(struct request * req, struct buffer_head *bh, int ok)
 {
 	struct buffer_head *xbh;
 	while(bh) {
 		xbh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		
-		blk_finished_io(bh->b_size >> 9);
+		blk_finished_io(req, bh->b_size >> 9);
 		bh->b_end_io(bh, ok);
 
 		bh = xbh;
@@ -1131,7 +1131,7 @@ static inline void complete_command(cmdl
                         (cmd->req.hdr.cmd == IDA_READ) ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
         }
 
-	complete_buffers(cmd->rq->bh, ok);
+	complete_buffers(cmd->rq, cmd->rq->bh, ok);
 	DBGPX(printk("Done with %p\n", cmd->rq););
 	req_finished_io(cmd->rq);
 	end_that_request_last(cmd->rq);
diff -urNp --exclude CVS --exclude BitKeeper x-ref/drivers/block/ll_rw_blk.c x/drivers/block/ll_rw_blk.c
--- x-ref/drivers/block/ll_rw_blk.c	2003-06-07 12:37:48.000000000 +0200
+++ x/drivers/block/ll_rw_blk.c	2003-06-07 12:53:40.000000000 +0200
@@ -183,11 +183,12 @@ void blk_cleanup_queue(request_queue_t *
 {
 	int count = q->nr_requests;
 
-	count -= __blk_cleanup_queue(&q->rq[READ]);
-	count -= __blk_cleanup_queue(&q->rq[WRITE]);
+	count -= __blk_cleanup_queue(&q->rq);
 
 	if (count)
 		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
+	if (atomic_read(&q->nr_sectors))
+		printk("blk_cleanup_queue: leaked sectors (%d)\n", atomic_read(&q->nr_sectors));
 
 	memset(q, 0, sizeof(*q));
 }
@@ -396,7 +397,7 @@ void generic_unplug_device(void *data)
  *
  * Returns the (new) number of requests which the queue has available.
  */
-int blk_grow_request_list(request_queue_t *q, int nr_requests)
+int blk_grow_request_list(request_queue_t *q, int nr_requests, int max_queue_sectors)
 {
 	unsigned long flags;
 	/* Several broken drivers assume that this function doesn't sleep,
@@ -406,21 +407,31 @@ int blk_grow_request_list(request_queue_
 	spin_lock_irqsave(q->queue_lock, flags);
 	while (q->nr_requests < nr_requests) {
 		struct request *rq;
-		int rw;
 
 		rq = kmem_cache_alloc(request_cachep, SLAB_ATOMIC);
 		if (rq == NULL)
 			break;
 		memset(rq, 0, sizeof(*rq));
 		rq->rq_status = RQ_INACTIVE;
-		rw = q->nr_requests & 1;
-		list_add(&rq->queue, &q->rq[rw].free);
-		q->rq[rw].count++;
+		list_add(&rq->queue, &q->rq.free);
+		q->rq.count++;
 		q->nr_requests++;
 	}
+	
+	/*
+	 * Wakeup waiters after both one quarter of the
+	 * max-in-fligh queue and one quarter of the requests
+	 * are available again.
+	 */
 	q->batch_requests = q->nr_requests / 4;
 	if (q->batch_requests > 32)
 		q->batch_requests = 32;
+	q->batch_sectors = max_queue_sectors / 4;
+
+	q->max_queue_sectors = max_queue_sectors;
+
+	BUG_ON(!q->batch_sectors);
+	atomic_set(&q->nr_sectors, 0);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 	return q->nr_requests;
 }
@@ -429,23 +440,26 @@ static void blk_init_free_list(request_q
 {
 	struct sysinfo si;
 	int megs;		/* Total memory, in megabytes */
-	int nr_requests;
+	int nr_requests, max_queue_sectors = MAX_QUEUE_SECTORS;
 
-	INIT_LIST_HEAD(&q->rq[READ].free);
-	INIT_LIST_HEAD(&q->rq[WRITE].free);
-	q->rq[READ].count = 0;
-	q->rq[WRITE].count = 0;
+	INIT_LIST_HEAD(&q->rq.free);
+	q->rq.count = 0;
 	q->nr_requests = 0;
 
 	si_meminfo(&si);
 	megs = si.totalram >> (20 - PAGE_SHIFT);
-	nr_requests = 128;
-	if (megs < 32)
+	nr_requests = MAX_NR_REQUESTS;
+	if (megs < 30) {
 		nr_requests /= 2;
-	blk_grow_request_list(q, nr_requests);
+		max_queue_sectors /= 2;
+	}
+	/* notice early if anybody screwed the defaults */
+	BUG_ON(!nr_requests);
+	BUG_ON(!max_queue_sectors);
+
+	blk_grow_request_list(q, nr_requests, max_queue_sectors);
 
-	init_waitqueue_head(&q->wait_for_requests[0]);
-	init_waitqueue_head(&q->wait_for_requests[1]);
+	init_waitqueue_head(&q->wait_for_requests);
 }
 
 static int __make_request(request_queue_t * q, int rw, struct buffer_head * bh);
@@ -514,12 +528,19 @@ void blk_init_queue(request_queue_t * q,
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.  Returns NULL if there are no free requests.
  */
+static struct request * FASTCALL(get_request(request_queue_t *q, int rw));
 static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
-	struct request_list *rl = q->rq + rw;
+	struct request_list *rl;
 
-	if (!list_empty(&rl->free)) {
+	if (blk_oversized_queue(q))
+		goto out;
+
+	rl = &q->rq;
+	if (list_empty(&rl->free))
+		q->full = 1;
+	if (!q->full) {
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;
@@ -529,6 +550,7 @@ static struct request *get_request(reque
 		rq->q = q;
 	}
 
+ out:
 	return rq;
 }
 
@@ -596,10 +618,25 @@ static struct request *__get_request_wai
 	register struct request *rq;
 	DECLARE_WAITQUEUE(wait, current);
 
-	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
+	add_wait_queue_exclusive(&q->wait_for_requests, &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (q->rq[rw].count == 0) {
+
+		/*
+		 * We must read rq.count and blk_oversized_queue()
+		 * and unplug the queue atomically (with the
+		 * spinlock being held for the whole duration of the
+		 * operation). Otherwise we risk to unplug the queue
+		 * before the request is visible in the I/O queue.
+		 *
+		 * On the __make_request side we depend on get_request,
+		 * get_request_wait_wakeup and blk_started_io to run
+		 * under the q->queue_lock and to never release it
+		 * until the request is visible in the I/O queue
+		 * (i.e. after add_request).
+		 */
+		spin_lock_irq(q->queue_lock);
+		if (q->full || blk_oversized_queue(q)) {
 			/*
 			 * All we care about is not to stall if any request
 			 * is been released after we set TASK_UNINTERRUPTIBLE.
@@ -607,14 +644,16 @@ static struct request *__get_request_wai
 			 * in case we hit the race and we can get the request
 			 * without waiting.
 			 */
-			generic_unplug_device(q);
+			__generic_unplug_device(q);
+
+			spin_unlock_irq(q->queue_lock);
 			schedule();
+			spin_lock_irq(q->queue_lock);
 		}
-		spin_lock_irq(q->queue_lock);
 		rq = get_request(q, rw);
 		spin_unlock_irq(q->queue_lock);
 	} while (rq == NULL);
-	remove_wait_queue(&q->wait_for_requests[rw], &wait);
+	remove_wait_queue(&q->wait_for_requests, &wait);
 	current->state = TASK_RUNNING;
 	return rq;
 }
@@ -626,8 +665,8 @@ static void get_request_wait_wakeup(requ
 	 * generic_unplug_device while our __get_request_wait was running
 	 * w/o the queue_lock held and w/ our request out of the queue.
 	 */
-	if (waitqueue_active(&q->wait_for_requests[rw]))
-		wake_up(&q->wait_for_requests[rw]);
+	if (waitqueue_active(&q->wait_for_requests))
+		wake_up(&q->wait_for_requests);
 }
 
 /* RO fail safe mechanism */
@@ -843,7 +882,6 @@ static inline void add_request(request_q
 void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
-	int rw = req->cmd;
 
 	req->rq_status = RQ_INACTIVE;
 	req->q = NULL;
@@ -853,11 +891,13 @@ void blkdev_release_request(struct reque
 	 * assume it has free buffers and check waiters
 	 */
 	if (q) {
-		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= q->batch_requests) {
+		list_add(&req->queue, &q->rq.free);
+		if (++q->rq.count >= q->batch_requests && !blk_oversized_queue_batch(q)) {
+			if (q->full)
+				q->full = 0;
 			smp_mb();
-			if (waitqueue_active(&q->wait_for_requests[rw]))
-				wake_up(&q->wait_for_requests[rw]);
+			if (waitqueue_active(&q->wait_for_requests))
+				wake_up(&q->wait_for_requests);
 		}
 	}
 }
@@ -1003,7 +1043,7 @@ again:
 			req->bhtail->b_reqnext = bh;
 			req->bhtail = bh;
 			req->nr_sectors = req->hard_nr_sectors += count;
-			blk_started_io(count);
+			blk_started_io(req, count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			req_new_io(req, 1, count);
 			attempt_back_merge(q, req, max_sectors, max_segments);
@@ -1025,7 +1065,7 @@ again:
 			req->current_nr_sectors = req->hard_cur_sectors = count;
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += count;
-			blk_started_io(count);
+			blk_started_io(req, count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
 			req_new_io(req, 1, count);
 			attempt_front_merge(q, head, req, max_sectors, max_segments);
@@ -1058,7 +1098,7 @@ get_rq:
 		 * See description above __get_request_wait()
 		 */
 		if (rw_ahead) {
-			if (q->rq[rw].count < q->batch_requests) {
+			if (q->rq.count < q->batch_requests || blk_oversized_queue_batch(q)) {
 				spin_unlock_irq(q->queue_lock);
 				goto end_io;
 			}
@@ -1094,7 +1134,7 @@ get_rq:
 	req->rq_dev = bh->b_rdev;
 	req->start_time = jiffies;
 	req_new_io(req, 0, count);
-	blk_started_io(count);
+	blk_started_io(req, count);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
@@ -1391,7 +1431,7 @@ int end_that_request_first (struct reque
 
 	if ((bh = req->bh) != NULL) {
 		nsect = bh->b_size >> 9;
-		blk_finished_io(nsect);
+		blk_finished_io(req, nsect);
 		req->bh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		bh->b_end_io(bh, uptodate);
diff -urNp --exclude CVS --exclude BitKeeper x-ref/drivers/scsi/scsi_lib.c x/drivers/scsi/scsi_lib.c
--- x-ref/drivers/scsi/scsi_lib.c	2003-06-07 12:37:47.000000000 +0200
+++ x/drivers/scsi/scsi_lib.c	2003-06-07 12:37:50.000000000 +0200
@@ -384,7 +384,7 @@ static Scsi_Cmnd *__scsi_end_request(Scs
 	do {
 		if ((bh = req->bh) != NULL) {
 			nsect = bh->b_size >> 9;
-			blk_finished_io(nsect);
+			blk_finished_io(req, nsect);
 			req->bh = bh->b_reqnext;
 			bh->b_reqnext = NULL;
 			sectors -= nsect;
diff -urNp --exclude CVS --exclude BitKeeper x-ref/include/linux/blkdev.h x/include/linux/blkdev.h
--- x-ref/include/linux/blkdev.h	2003-06-07 12:37:47.000000000 +0200
+++ x/include/linux/blkdev.h	2003-06-07 12:49:16.000000000 +0200
@@ -64,12 +64,6 @@ typedef int (make_request_fn) (request_q
 typedef void (plug_device_fn) (request_queue_t *q, kdev_t device);
 typedef void (unplug_device_fn) (void *q);
 
-/*
- * Default nr free requests per queue, ll_rw_blk will scale it down
- * according to available RAM at init time
- */
-#define QUEUE_NR_REQUESTS	8192
-
 struct request_list {
 	unsigned int count;
 	struct list_head free;
@@ -80,7 +74,7 @@ struct request_queue
 	/*
 	 * the queue request freelist, one for reads and one for writes
 	 */
-	struct request_list	rq[2];
+	struct request_list	rq;
 
 	/*
 	 * The total number of requests on each queue
@@ -93,6 +87,21 @@ struct request_queue
 	int batch_requests;
 
 	/*
+	 * The total number of 512byte blocks on each queue
+	 */
+	atomic_t nr_sectors;
+
+	/*
+	 * Batching threshold for sleep/wakeup decisions
+	 */
+	int batch_sectors;
+
+	/*
+	 * The max number of 512byte blocks on each queue
+	 */
+	int max_queue_sectors;
+
+	/*
 	 * Together with queue_head for cacheline sharing
 	 */
 	struct list_head	queue_head;
@@ -118,13 +127,20 @@ struct request_queue
 	/*
 	 * Boolean that indicates whether this queue is plugged or not.
 	 */
-	char			plugged;
+	int			plugged:1;
 
 	/*
 	 * Boolean that indicates whether current_request is active or
 	 * not.
 	 */
-	char			head_active;
+	int			head_active:1;
+
+	/*
+	 * Booleans that indicate whether the queue's free requests have
+	 * been exhausted and is waiting to drop below the batch_requests
+	 * threshold
+	 */
+	int                     full:1;
 
 	unsigned long		bounce_pfn;
 
@@ -137,7 +153,7 @@ struct request_queue
 	/*
 	 * Tasks wait here for free read and write requests
 	 */
-	wait_queue_head_t	wait_for_requests[2];
+	wait_queue_head_t	wait_for_requests;
 };
 
 #define blk_queue_plugged(q)	(q)->plugged
@@ -221,7 +237,7 @@ extern void blkdev_release_request(struc
 /*
  * Access functions for manipulating queue properties
  */
-extern int blk_grow_request_list(request_queue_t *q, int nr_requests);
+extern int blk_grow_request_list(request_queue_t *q, int nr_requests, int max_queue_sectors);
 extern void blk_init_queue(request_queue_t *, request_fn_proc *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_headactive(request_queue_t *, int);
@@ -245,6 +261,8 @@ extern char * blkdev_varyio[MAX_BLKDEV];
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
+#define MAX_QUEUE_SECTORS (4 << (20 - 9)) /* 4 mbytes when full sized */
+#define MAX_NR_REQUESTS 1024 /* 1024k when in 512 units, normally min is 1M in 1k units */
 
 #define PageAlignSize(size) (((size) + PAGE_SIZE -1) & PAGE_MASK)
 
@@ -271,8 +289,40 @@ static inline int get_hardsect_size(kdev
 	return retval;
 }
 
-#define blk_finished_io(nsects)	do { } while (0)
-#define blk_started_io(nsects)	do { } while (0)
+static inline int blk_oversized_queue(request_queue_t * q)
+{
+	return atomic_read(&q->nr_sectors) > q->max_queue_sectors;
+}
+
+static inline int blk_oversized_queue_batch(request_queue_t * q)
+{
+	return atomic_read(&q->nr_sectors) > q->max_queue_sectors - q->batch_sectors;
+}
+
+static inline void blk_started_io(struct request * req, int nsects)
+{
+	request_queue_t * q = req->q;
+
+	if (q)
+		atomic_add(nsects, &q->nr_sectors);
+	BUG_ON(atomic_read(&q->nr_sectors) < 0);
+}
+
+static inline void blk_finished_io(struct request * req, int nsects)
+{
+	request_queue_t * q = req->q;
+
+	/* special requests belongs to a null queue */
+	if (q) {
+		atomic_sub(nsects, &q->nr_sectors);
+		if (q->rq.count >= q->batch_requests && !blk_oversized_queue_batch(q)) {
+			smp_mb();
+			if (waitqueue_active(&q->wait_for_requests))
+				wake_up(&q->wait_for_requests);
+		}
+	}
+	BUG_ON(atomic_read(&q->nr_sectors) < 0);
+}
 
 static inline unsigned int blksize_bits(unsigned int size)
 {
diff -urNp --exclude CVS --exclude BitKeeper x-ref/include/linux/elevator.h x/include/linux/elevator.h
--- x-ref/include/linux/elevator.h	2002-11-29 02:23:18.000000000 +0100
+++ x/include/linux/elevator.h	2003-06-07 12:37:50.000000000 +0200
@@ -80,7 +80,7 @@ static inline int elevator_request_laten
 	return latency;
 }
 
-#define ELV_LINUS_SEEK_COST	16
+#define ELV_LINUS_SEEK_COST	1
 
 #define ELEVATOR_NOOP							\
 ((elevator_t) {								\
@@ -93,8 +93,8 @@ static inline int elevator_request_laten
 
 #define ELEVATOR_LINUS							\
 ((elevator_t) {								\
-	2048,				/* read passovers */		\
-	8192,				/* write passovers */		\
+	128,				/* read passovers */		\
+	512,				/* write passovers */		\
 									\
 	elevator_linus_merge,		/* elevator_merge_fn */		\
 	elevator_linus_merge_req,	/* elevator_merge_req_fn */	\
diff -urNp --exclude CVS --exclude BitKeeper x-ref/include/linux/nbd.h x/include/linux/nbd.h
--- x-ref/include/linux/nbd.h	2003-04-01 12:07:54.000000000 +0200
+++ x/include/linux/nbd.h	2003-06-07 12:37:50.000000000 +0200
@@ -48,7 +48,7 @@ nbd_end_request(struct request *req)
 	spin_lock_irqsave(&io_request_lock, flags);
 	while((bh = req->bh) != NULL) {
 		nsect = bh->b_size >> 9;
-		blk_finished_io(nsect);
+		blk_finished_io(req, nsect);
 		req->bh = bh->b_reqnext;
 		bh->b_reqnext = NULL;
 		bh->b_end_io(bh, uptodate);

--3Gf/FFewwPeBMqCJ--
