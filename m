Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSE1ItB>; Tue, 28 May 2002 04:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSE1ItB>; Tue, 28 May 2002 04:49:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24770 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313189AbSE1Isz>;
	Tue, 28 May 2002 04:48:55 -0400
Date: Tue, 28 May 2002 10:48:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH][RFC] block plugging reworked
Message-ID: <20020528084829.GI17674@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch provides the ability for a block driver to signal it's too
busy to receive more work and temporarily halt the request queue. In
concept it's similar to the networking netif_{start,stop}_queue helpers.

To do this cleanly, I've ripped out the old tq_disk task queue. Instead
an internal list of plugged queues is maintained which will honor the
current queue state (see QUEUE_FLAG_STOPPED bit). Execution of
request_fn has been moved to tasklet context. blk_run_queues() provides
similar functionality to the old run_task_queue(&tq_disk).

Now, this only works at the request_fn level and not at the
make_request_fn level. This is on purpose: drivers working at the
make_request_fn level are essentially providing a piece of the block
level infrastructure themselves. There are basically two reasons for
doing make_request_fn style setups:

o block remappers. start/stop functionality will be done at the target
  device in this case, which is the level that will signal hardware full
  (or continue) anyways.

o drivers who wish to receive single entities of "buffers" and not
  merged requests etc. This could use the start/stop functionality. I'd
  suggest _still_ using a request_fn for these, but set the queue
  options so that no merging etc ever takes place. This has the added
  bonus of providing the usual request depletion throttling at the block
  level.

So in short, I see no problem in this, only advantages for possible
cleanups.

block-plug-1 is the test patch, cciss-cpqarray-misc-1 implements it for
cciss and cpqarray (along with a few other fixes to make it work again).
There are most likely still tq_disk references left, I didn't bother
checking them all just for this test announce.

-- 
Jens Axboe


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=block-plug-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.588   -> 1.589  
#	      kernel/ksyms.c	1.93    -> 1.94   
#	         fs/buffer.c	1.105   -> 1.106  
#	include/linux/tqueue.h	1.4     -> 1.5    
#	        mm/mempool.c	1.7     -> 1.8    
#	      mm/readahead.c	1.8     -> 1.9    
#	drivers/block/ll_rw_blk.c	1.72    -> 1.73   
#	 mm/page-writeback.c	1.18    -> 1.19   
#	         mm/vmscan.c	1.72    -> 1.73   
#	drivers/block/floppy.c	1.25    -> 1.26   
#	include/linux/blkdev.h	1.46    -> 1.47   
#	 fs/jbd/checkpoint.c	1.4     -> 1.5    
#	  include/linux/fs.h	1.123   -> 1.124  
#	     drivers/md/md.c	1.56    -> 1.57   
#	          fs/iobuf.c	1.7     -> 1.8    
#	fs/reiserfs/buffer2.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/28	axboe@burns.home.kernel.dk	1.589
# tq_disk removal and plugging reworked
# --------------------------------------------
#
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Tue May 28 10:33:57 2002
+++ b/drivers/block/floppy.c	Tue May 28 10:33:57 2002
@@ -3900,7 +3900,7 @@
 	bio.bi_end_io = floppy_rb0_complete;
 
 	submit_bio(READ, &bio);
-	run_task_queue(&tq_disk);
+	generic_unplug_device(bdev_get_queue(bdev));
 	process_fd_request();
 	wait_for_completion(&complete);
 
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Tue May 28 10:33:57 2002
+++ b/drivers/block/ll_rw_blk.c	Tue May 28 10:33:57 2002
@@ -49,6 +49,9 @@
  */
 static kmem_cache_t *request_cachep;
 
+static struct list_head blk_plug_list;
+static spinlock_t blk_plug_lock = SPIN_LOCK_UNLOCKED;
+
 /*
  * The "disk" task queue is used to start the actual requests
  * after a plug
@@ -791,8 +794,12 @@
 	if (!elv_queue_empty(q))
 		return;
 
-	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
-		queue_task(&q->plug_tq, &tq_disk);
+	if (test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+		return;
+
+	spin_lock(&blk_plug_lock);
+	list_add_tail(&q->plug.list, &blk_plug_list);
+	spin_unlock(&blk_plug_lock);
 }
 
 /*
@@ -803,8 +810,13 @@
 	/*
 	 * not plugged
 	 */
-	if (!test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+	if (!__test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+		return;
+
+	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
+		printk("queue was stopped\n");
 		return;
+	}
 
 	/*
 	 * was plugged, fire request_fn if queue has stuff to do
@@ -815,7 +827,7 @@
 
 /**
  * generic_unplug_device - fire a request queue
- * @q:    The &request_queue_t in question
+ * @data:    The &request_queue_t in question
  *
  * Description:
  *   Linux uses plugging to build bigger requests queues before letting
@@ -827,6 +839,16 @@
  **/
 void generic_unplug_device(void *data)
 {
+	request_queue_t *q = data;
+
+	tasklet_schedule(&q->plug.task);
+}
+
+/*
+ * the plug tasklet
+ */
+static void blk_task_run(unsigned long data)
+{
 	request_queue_t *q = (request_queue_t *) data;
 	unsigned long flags;
 
@@ -835,6 +857,49 @@
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
+/*
+ * clear top flag and schedule tasklet for execution
+ */
+void blk_start_queue(request_queue_t *q)
+{
+	if (test_and_clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
+		tasklet_enable(&q->plug.task);
+
+	tasklet_schedule(&q->plug.task);
+}
+
+/*
+ * set stop bit and disable any pending tasklet
+ */
+void blk_stop_queue(request_queue_t *q)
+{
+	if (!test_and_set_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
+		tasklet_disable(&q->plug.task);
+}
+
+/*
+ * the equivalent of the previous tq_disk run
+ */
+void blk_run_queues(void)
+{
+	struct list_head *tmp, *n;
+	unsigned long flags;
+
+	/*
+	 * we could splice to the stack prior to running
+	 */
+	spin_lock_irqsave(&blk_plug_lock, flags);
+	list_for_each_safe(tmp, n, &blk_plug_list) {
+		request_queue_t *q = list_entry(tmp, request_queue_t,plug.list);
+
+		if (!test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
+			list_del(&q->plug.list);
+			tasklet_schedule(&q->plug.task);
+		}
+	}
+	spin_unlock_irqrestore(&blk_plug_lock, flags);
+}
+
 static int __blk_cleanup_queue(struct request_list *list)
 {
 	struct list_head *head = &list->free;
@@ -974,9 +1039,6 @@
 	q->front_merge_fn      	= ll_front_merge_fn;
 	q->merge_requests_fn	= ll_merge_requests_fn;
 	q->prep_rq_fn		= NULL;
-	q->plug_tq.sync		= 0;
-	q->plug_tq.routine	= &generic_unplug_device;
-	q->plug_tq.data		= q;
 	q->queue_flags		= (1 << QUEUE_FLAG_CLUSTER);
 	q->queue_lock		= lock;
 
@@ -987,6 +1049,10 @@
 
 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
+
+	INIT_LIST_HEAD(&q->plug.list);
+	tasklet_init(&q->plug.task, blk_task_run, (unsigned long) q);
+
 	return 0;
 }
 
@@ -1867,6 +1933,8 @@
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
 
+	INIT_LIST_HEAD(&blk_plug_list);
+
 #if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_HD)
 	hd_init();
 #endif
@@ -1910,3 +1978,7 @@
 EXPORT_SYMBOL(blk_queue_start_tag);
 EXPORT_SYMBOL(blk_queue_end_tag);
 EXPORT_SYMBOL(blk_queue_invalidate_tags);
+
+EXPORT_SYMBOL(blk_start_queue);
+EXPORT_SYMBOL(blk_stop_queue);
+EXPORT_SYMBOL(blk_run_queues);
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Tue May 28 10:33:57 2002
+++ b/drivers/md/md.c	Tue May 28 10:33:57 2002
@@ -491,7 +491,7 @@
 	bio.bi_private = &event;
 	bio.bi_end_io = bi_complete;
 	submit_bio(rw, &bio);
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 	wait_for_completion(&event);
 
 	return test_bit(BIO_UPTODATE, &bio.bi_flags);
@@ -2955,7 +2955,7 @@
 		run = thread->run;
 		if (run) {
 			run(thread->data);
-			run_task_queue(&tq_disk);
+			blk_run_queues();
 		}
 		if (signal_pending(current))
 			flush_curr_signals();
@@ -3411,7 +3411,7 @@
 
 		last_check = j;
 
-		run_task_queue(&tq_disk);
+		blk_run_queues();
 
 	repeat:
 		if (jiffies >= mark[last_mark] + SYNC_MARK_STEP ) {
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Tue May 28 10:33:57 2002
+++ b/fs/buffer.c	Tue May 28 10:33:57 2002
@@ -138,7 +138,7 @@
 	get_bh(bh);
 	add_wait_queue(wq, &wait);
 	do {
-		run_task_queue(&tq_disk);
+		blk_run_queues();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!buffer_locked(bh))
 			break;
@@ -487,7 +487,7 @@
 
 	wakeup_bdflush();
 	try_to_free_pages(zone, GFP_NOFS, 0);
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 	__set_current_state(TASK_RUNNING);
 	yield();
 }
@@ -1004,7 +1004,7 @@
 	 * the reserve list is empty, we're sure there are 
 	 * async buffer heads in use.
 	 */
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 
 	free_more_memory();
 	goto try_again;
@@ -2452,7 +2452,7 @@
 
 int block_sync_page(struct page *page)
 {
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 	return 0;
 }
 
diff -Nru a/fs/iobuf.c b/fs/iobuf.c
--- a/fs/iobuf.c	Tue May 28 10:33:57 2002
+++ b/fs/iobuf.c	Tue May 28 10:33:57 2002
@@ -112,7 +112,7 @@
 repeat:
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	if (atomic_read(&kiobuf->io_count) != 0) {
-		run_task_queue(&tq_disk);
+		blk_run_queues();
 		schedule();
 		if (atomic_read(&kiobuf->io_count) != 0)
 			goto repeat;
diff -Nru a/fs/jbd/checkpoint.c b/fs/jbd/checkpoint.c
--- a/fs/jbd/checkpoint.c	Tue May 28 10:33:57 2002
+++ b/fs/jbd/checkpoint.c	Tue May 28 10:33:57 2002
@@ -179,7 +179,7 @@
 
 	spin_unlock(&journal_datalist_lock);
 	ll_rw_block(WRITE, *batch_count, bhs);
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 	spin_lock(&journal_datalist_lock);
 	for (i = 0; i < *batch_count; i++) {
 		struct buffer_head *bh = bhs[i];
diff -Nru a/fs/reiserfs/buffer2.c b/fs/reiserfs/buffer2.c
--- a/fs/reiserfs/buffer2.c	Tue May 28 10:33:57 2002
+++ b/fs/reiserfs/buffer2.c	Tue May 28 10:33:57 2002
@@ -32,7 +32,7 @@
 			bh, repeat_counter, buffer_journaled(bh) ? ' ' : '!',
 			buffer_journal_dirty(bh) ? ' ' : '!');
     }
-    run_task_queue(&tq_disk);
+    blk_run_queues();
     yield();
   }
   if (repeat_counter > 30000000) {
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Tue May 28 10:33:57 2002
+++ b/include/linux/blkdev.h	Tue May 28 10:33:57 2002
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
+#include <linux/interrupt.h>
 
 #include <asm/scatterlist.h>
 
@@ -136,6 +137,11 @@
 	int max_depth;
 };
 
+struct blk_plug {
+	struct list_head list;
+	struct tasklet_struct task;
+};
+
 /*
  * Default nr free requests per queue, ll_rw_blk will scale it down
  * according to available RAM at init time
@@ -177,10 +183,7 @@
 	unsigned long		bounce_pfn;
 	int			bounce_gfp;
 
-	/*
-	 * This is used to remove the plug when tq_disk runs.
-	 */
-	struct tq_struct	plug_tq;
+	struct blk_plug		plug;
 
 	/*
 	 * various queue flags, see QUEUE_* below
@@ -217,6 +220,7 @@
 #define QUEUE_FLAG_PLUGGED	0	/* queue is plugged */
 #define QUEUE_FLAG_CLUSTER	1	/* cluster several segments into 1 */
 #define QUEUE_FLAG_QUEUED	2	/* uses generic tag queueing */
+#define QUEUE_FLAG_STOPPED	3	/* queue is stopped */
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_mark_plugged(q)	set_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
@@ -303,6 +307,8 @@
 extern inline int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern inline int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern int block_ioctl(struct block_device *, unsigned int, unsigned long);
+extern void blk_start_queue(request_queue_t *q);
+extern void blk_stop_queue(request_queue_t *q);
 
 /*
  * get ready for proper ref counting
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Tue May 28 10:33:57 2002
+++ b/include/linux/fs.h	Tue May 28 10:33:57 2002
@@ -1079,6 +1079,7 @@
 extern int blkdev_put(struct block_device *, int);
 extern int bd_claim(struct block_device *, void *);
 extern void bd_release(struct block_device *);
+extern void blk_run_queues(void);
 
 /* fs/devices.c */
 extern const struct block_device_operations *get_blkfops(unsigned int);
diff -Nru a/include/linux/tqueue.h b/include/linux/tqueue.h
--- a/include/linux/tqueue.h	Tue May 28 10:33:57 2002
+++ b/include/linux/tqueue.h	Tue May 28 10:33:57 2002
@@ -66,7 +66,7 @@
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
 #define TQ_ACTIVE(q)		(!list_empty(&q))
 
-extern task_queue tq_timer, tq_immediate, tq_disk, tq_bdflush;
+extern task_queue tq_timer, tq_immediate, tq_bdflush;
 
 /*
  * To implement your own list of active bottom halfs, use the following
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue May 28 10:33:57 2002
+++ b/kernel/ksyms.c	Tue May 28 10:33:57 2002
@@ -337,7 +337,6 @@
 EXPORT_SYMBOL(grok_partitions);
 EXPORT_SYMBOL(register_disk);
 EXPORT_SYMBOL(read_dev_sector);
-EXPORT_SYMBOL(tq_disk);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL(wipe_partitions);
 
diff -Nru a/mm/mempool.c b/mm/mempool.c
--- a/mm/mempool.c	Tue May 28 10:33:57 2002
+++ b/mm/mempool.c	Tue May 28 10:33:57 2002
@@ -220,7 +220,7 @@
 	if (gfp_mask == gfp_nowait)
 		return NULL;
 
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 
 	add_wait_queue_exclusive(&pool->wait, &wait);
 	set_task_state(current, TASK_UNINTERRUPTIBLE);
diff -Nru a/mm/page-writeback.c b/mm/page-writeback.c
--- a/mm/page-writeback.c	Tue May 28 10:33:57 2002
+++ b/mm/page-writeback.c	Tue May 28 10:33:57 2002
@@ -148,7 +148,7 @@
 		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, NULL);
 		min_pages -= MAX_WRITEBACK_PAGES - nr_to_write;
 	} while (nr_to_write <= 0);
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 }
 
 /*
@@ -206,7 +206,7 @@
 	next_jif = start_jif + wb_writeback_jifs;
 	nr_to_write = ps.nr_dirty;
 	writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, &oldest_jif);
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 	yield();
 
 	if (time_before(next_jif, jiffies + HZ))
diff -Nru a/mm/readahead.c b/mm/readahead.c
--- a/mm/readahead.c	Tue May 28 10:33:57 2002
+++ b/mm/readahead.c	Tue May 28 10:33:57 2002
@@ -161,7 +161,7 @@
 	/*
 	 * Do this now, rather than at the next wait_on_page_locked().
 	 */
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 
 	if (!list_empty(&page_pool))
 		BUG();
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Tue May 28 10:33:57 2002
+++ b/mm/vmscan.c	Tue May 28 10:33:57 2002
@@ -808,7 +808,7 @@
 		 * up on a more timely basis.
 		 */
 		kswapd_balance();
-		run_task_queue(&tq_disk);
+		blk_run_queues();
 	}
 }
 

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cciss-cpqarray-misc-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.589   -> 1.590  
#	drivers/block/cciss.h	1.10    -> 1.11   
#	drivers/block/cpqarray.c	1.35    -> 1.36   
#	drivers/block/smart1,2.h	1.3     -> 1.4    
#	drivers/block/cpqarray.h	1.6     -> 1.7    
#	drivers/block/cciss.c	1.42    -> 1.43   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/28	axboe@burns.home.kernel.dk	1.590
# various cpqarray and cciss updates
# --------------------------------------------
#
diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	Tue May 28 10:34:16 2002
+++ b/drivers/block/cciss.c	Tue May 28 10:34:16 2002
@@ -281,7 +281,7 @@
                 	i = find_first_zero_bit(h->cmd_pool_bits, NR_CMDS);
                         if (i == NR_CMDS)
                                 return NULL;
-                } while(test_and_set_bit(i & 31, h->cmd_pool_bits+(i/32)) != 0);
+                } while(test_and_set_bit(i & (BITS_PER_LONG - 1), h->cmd_pool_bits+(i/BITS_PER_LONG)) != 0);
 #ifdef CCISS_DEBUG
 		printk(KERN_DEBUG "cciss: using command buffer %d\n", i);
 #endif
@@ -327,7 +327,7 @@
 	} else 
 	{
 		i = c - h->cmd_pool;
-		clear_bit(i%32, h->cmd_pool_bits+(i/32));
+		clear_bit(i&(BITS_PER_LONG-1), h->cmd_pool_bits+(i/BITS_PER_LONG));
                 h->nr_frees++;
         }
 }
@@ -338,7 +338,7 @@
 static void cciss_geninit( int ctlr)
 {
 	drive_info_struct *drv;
-	int i,j;
+	int i;
 	
 	/* Loop through each real device */ 
 	hba[ctlr]->gendisk.nr_real = 0; 
@@ -1883,6 +1883,7 @@
 
 	goto queue;
 startio:
+	blk_stop_queue(q);
 	start_io(h);
 }
 
@@ -1943,8 +1944,8 @@
 	/*
 	 * See if we can queue up some more IO
 	 */
-	do_cciss_request(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
 	spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
+	blk_start_queue(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
 }
 /* 
  *  We cannot read the structure directly, for portablity we must use 
@@ -2448,8 +2449,7 @@
 		free_hba(i);
 		return(-1);
 	}
-	hba[i]->cmd_pool_bits = (__u32*)kmalloc(
-        	((NR_CMDS+31)/32)*sizeof(__u32), GFP_KERNEL);
+	hba[i]->cmd_pool_bits = kmalloc(((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long), GFP_KERNEL);
 	hba[i]->cmd_pool = (CommandList_struct *)pci_alloc_consistent(
 		hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct), 
 		&(hba[i]->cmd_pool_dhandle));
@@ -2484,7 +2484,7 @@
 	pci_set_drvdata(pdev, hba[i]);
 	/* command and error info recs zeroed out before 
 			they are used */
-        memset(hba[i]->cmd_pool_bits, 0, ((NR_CMDS+31)/32)*sizeof(__u32));
+        memset(hba[i]->cmd_pool_bits, 0, ((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));
 
 #ifdef CCISS_DEBUG	
 	printk(KERN_DEBUG "Scanning for drives on controller cciss%d\n",i);
diff -Nru a/drivers/block/cciss.h b/drivers/block/cciss.h
--- a/drivers/block/cciss.h	Tue May 28 10:34:16 2002
+++ b/drivers/block/cciss.h	Tue May 28 10:34:16 2002
@@ -76,7 +76,7 @@
 	dma_addr_t		cmd_pool_dhandle; 
 	ErrorInfo_struct 	*errinfo_pool;
 	dma_addr_t		errinfo_pool_dhandle; 
-        __u32   		*cmd_pool_bits;
+        unsigned long  		*cmd_pool_bits;
 	int			nr_allocs;
 	int			nr_frees; 
 
diff -Nru a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c	Tue May 28 10:34:16 2002
+++ b/drivers/block/cpqarray.c	Tue May 28 10:34:16 2002
@@ -166,7 +166,7 @@
 
 static void ida_geninit(int ctlr)
 {
-	int i,j;
+	int i;
 	drv_info_t *drv;
 
 	for(i=0; i<NWD; i++) {
@@ -409,8 +409,7 @@
 		hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
 				hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t), 
 				&(hba[i]->cmd_pool_dhandle));
-		hba[i]->cmd_pool_bits = (__u32*)kmalloc(
-				((NR_CMDS+31)/32)*sizeof(__u32), GFP_KERNEL);
+		hba[i]->cmd_pool_bits = kmalloc(((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long), GFP_KERNEL);
 		
 	if(hba[i]->cmd_pool_bits == NULL || hba[i]->cmd_pool == NULL)
 		{
@@ -441,7 +440,7 @@
 	
 		}
 		memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
-		memset(hba[i]->cmd_pool_bits, 0, ((NR_CMDS+31)/32)*sizeof(__u32));
+		memset(hba[i]->cmd_pool_bits, 0, ((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));
 		printk(KERN_INFO "cpqarray: Finding drives on %s", 
 			hba[i]->devname);
 		getgeometry(i);
@@ -916,6 +915,7 @@
 	goto queue_next;
 
 startio:
+	blk_stop_queue(q);
 	start_io(h);
 }
 
@@ -1066,8 +1066,8 @@
 	/*
 	 * See if we can queue up some more IO
 	 */
-	do_ida_request(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
 	spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags);
+	blk_start_queue(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
 }
 
 /*
@@ -1333,7 +1333,7 @@
 			i = find_first_zero_bit(h->cmd_pool_bits, NR_CMDS);
 			if (i == NR_CMDS)
 				return NULL;
-		} while(test_and_set_bit(i%32, h->cmd_pool_bits+(i/32)) != 0);
+		} while(test_and_set_bit(i&(BITS_PER_LONG-1), h->cmd_pool_bits+(i/BITS_PER_LONG)) != 0);
 		c = h->cmd_pool + i;
 		cmd_dhandle = h->cmd_pool_dhandle + i*sizeof(cmdlist_t);
 		h->nr_allocs++;
@@ -1353,7 +1353,7 @@
 			c->busaddr);
 	} else {
 		i = c - h->cmd_pool;
-		clear_bit(i%32, h->cmd_pool_bits+(i/32));
+		clear_bit(i&(BITS_PER_LONG-1), h->cmd_pool_bits+(i/BITS_PER_LONG));
 		h->nr_frees++;
 	}
 }
diff -Nru a/drivers/block/cpqarray.h b/drivers/block/cpqarray.h
--- a/drivers/block/cpqarray.h	Tue May 28 10:34:16 2002
+++ b/drivers/block/cpqarray.h	Tue May 28 10:34:16 2002
@@ -104,7 +104,7 @@
 	cmdlist_t *cmpQ;
 	cmdlist_t *cmd_pool;
 	dma_addr_t cmd_pool_dhandle;
-	__u32	*cmd_pool_bits;
+	unsigned long *cmd_pool_bits;
 	spinlock_t lock;
 
 	unsigned int Qdepth;
diff -Nru a/drivers/block/smart1,2.h b/drivers/block/smart1,2.h
--- a/drivers/block/smart1,2.h	Tue May 28 10:34:16 2002
+++ b/drivers/block/smart1,2.h	Tue May 28 10:34:16 2002
@@ -252,7 +252,9 @@
 
 		outb(CHANNEL_CLEAR, h->ioaddr + SMART1_LOCAL_DOORBELL);
 
-#error Please convert me to Documentation/DMA-mapping.txt
+		/*
+		 * this is x86 (actually compaq x86) only, so it's ok
+		 */
 		if (cmd) ((cmdlist_t*)bus_to_virt(cmd))->req.hdr.rcode = status;
 	} else {
 		cmd = 0;

--2oS5YaxWCcQjTEyO--
