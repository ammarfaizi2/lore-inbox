Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSFDOXl>; Tue, 4 Jun 2002 10:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSFDOXl>; Tue, 4 Jun 2002 10:23:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311898AbSFDOXg>;
	Tue, 4 Jun 2002 10:23:36 -0400
Date: Tue, 4 Jun 2002 16:23:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020604142327.GN1105@suse.de>
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de> <20020604123856.GE1105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

I tried converting umem to see how it fit together, this is what I came
up with. This does use a queue per umem unit, but I think that's the
right split anyways. Maybe at some point we can use the per-major
statically allocated queues...

diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.20/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.20/drivers/block/ll_rw_blk.c	2002-06-03 10:35:35.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-06-04 16:14:40.000000000 +0200
@@ -49,6 +49,9 @@
  */
 static kmem_cache_t *request_cachep;
 
+/*
+ * plug management
+ */
 static struct list_head blk_plug_list;
 static spinlock_t blk_plug_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
@@ -795,8 +798,8 @@
  * force the transfer to start only after we have put all the requests
  * on the list.
  *
- * This is called with interrupts off and no requests on the queue.
- * (and with the request spinlock acquired)
+ * This is called with interrupts off and no requests on the queue and
+ * with the queue lock held.
  */
 void blk_plug_device(request_queue_t *q)
 {
@@ -806,7 +809,7 @@
 	if (!elv_queue_empty(q))
 		return;
 
-	if (!test_and_set_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags)) {
+	if (!blk_queue_plugged(q)) {
 		spin_lock(&blk_plug_lock);
 		list_add_tail(&q->plug_list, &blk_plug_list);
 		spin_unlock(&blk_plug_lock);
@@ -814,14 +817,27 @@
 }
 
 /*
+ * remove the queue from the plugged list, if present. called with
+ * queue lock held and interrupts disabled.
+ */
+inline int blk_remove_plug(request_queue_t *q)
+{
+	if (blk_queue_plugged(q)) {
+		spin_lock(&blk_plug_lock);
+		list_del_init(&q->plug_list);
+		spin_unlock(&blk_plug_lock);
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
  * remove the plug and let it rip..
  */
 static inline void __generic_unplug_device(request_queue_t *q)
 {
-	/*
-	 * not plugged
-	 */
-	if (!__test_and_clear_bit(QUEUE_FLAG_PLUGGED, &q->queue_flags))
+	if (!blk_remove_plug(q))
 		return;
 
 	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
@@ -849,11 +865,10 @@
 void generic_unplug_device(void *data)
 {
 	request_queue_t *q = data;
-	unsigned long flags;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irq(q->queue_lock);
 	__generic_unplug_device(q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irq(q->queue_lock);
 }
 
 /**
@@ -893,6 +908,12 @@
  **/
 void blk_stop_queue(request_queue_t *q)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_remove_plug(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
 	set_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
 }
 
@@ -904,45 +925,31 @@
  *   are currently stopped are ignored. This is equivalent to the older
  *   tq_disk task queue run.
  **/
+#define blk_plug_entry(entry) list_entry((entry), request_queue_t, plug_list)
 void blk_run_queues(void)
 {
-	struct list_head *n, *tmp, local_plug_list;
-	unsigned long flags;
+	struct list_head local_plug_list;
 
 	INIT_LIST_HEAD(&local_plug_list);
 
+	spin_lock_irq(&blk_plug_lock);
+
 	/*
 	 * this will happen fairly often
 	 */
-	spin_lock_irqsave(&blk_plug_lock, flags);
 	if (list_empty(&blk_plug_list)) {
-		spin_unlock_irqrestore(&blk_plug_lock, flags);
+		spin_unlock_irq(&blk_plug_lock);
 		return;
 	}
 
 	list_splice(&blk_plug_list, &local_plug_list);
 	INIT_LIST_HEAD(&blk_plug_list);
-	spin_unlock_irqrestore(&blk_plug_lock, flags);
+	spin_unlock_irq(&blk_plug_lock);
+	
+	while (!list_empty(&local_plug_list)) {
+		request_queue_t *q = blk_plug_entry(local_plug_list.next);
 
-	/*
-	 * local_plug_list is now a private copy we can traverse lockless
-	 */
-	list_for_each_safe(n, tmp, &local_plug_list) {
-		request_queue_t *q = list_entry(n, request_queue_t, plug_list);
-
-		if (!test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
-			list_del(&q->plug_list);
-			generic_unplug_device(q);
-		}
-	}
-
-	/*
-	 * add any remaining queue back to plug list
-	 */
-	if (!list_empty(&local_plug_list)) {
-		spin_lock_irqsave(&blk_plug_lock, flags);
-		list_splice(&local_plug_list, &blk_plug_list);
-		spin_unlock_irqrestore(&blk_plug_lock, flags);
+		q->unplug_fn(q);
 	}
 }
 
@@ -1085,6 +1092,7 @@
 	q->front_merge_fn      	= ll_front_merge_fn;
 	q->merge_requests_fn	= ll_merge_requests_fn;
 	q->prep_rq_fn		= NULL;
+	q->unplug_fn		= generic_unplug_device;
 	q->queue_flags		= (1 << QUEUE_FLAG_CLUSTER);
 	q->queue_lock		= lock;
 
@@ -1352,7 +1360,7 @@
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req, *freereq = NULL;
-	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier;
+	int el_ret, rw, nr_sectors, cur_nr_sectors;
 	struct list_head *insert_here;
 	sector_t sector;
 
@@ -1368,16 +1376,12 @@
 	 */
 	blk_queue_bounce(q, &bio);
 
-	spin_lock_prefetch(q->queue_lock);
-
-	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
-
 	spin_lock_irq(q->queue_lock);
 again:
 	req = NULL;
 	insert_here = q->queue_head.prev;
 
-	if (blk_queue_empty(q) || barrier) {
+	if (blk_queue_empty(q) || bio_barrier(bio)) {
 		blk_plug_device(q);
 		goto get_rq;
 	}
@@ -1477,7 +1481,7 @@
 	/*
 	 * REQ_BARRIER implies no merging, but lets make it explicit
 	 */
-	if (barrier)
+	if (bio_barrier(bio))
 		req->flags |= (REQ_BARRIER | REQ_NOMERGE);
 
 	req->errors = 0;
@@ -1489,9 +1493,7 @@
 	req->buffer = bio_data(bio);	/* see ->buffer comment above */
 	req->waiting = NULL;
 	req->bio = req->biotail = bio;
-	if (bio->bi_bdev)
-		req->rq_dev = to_kdev_t(bio->bi_bdev->bd_dev);
-	else	req->rq_dev = NODEV;
+	req->rq_dev = to_kdev_t(bio->bi_bdev->bd_dev);
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
@@ -2002,6 +2004,8 @@
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(generic_unplug_device);
+EXPORT_SYMBOL(blk_plug_device);
+EXPORT_SYMBOL(blk_remove_plug);
 EXPORT_SYMBOL(blk_attempt_remerge);
 EXPORT_SYMBOL(blk_max_low_pfn);
 EXPORT_SYMBOL(blk_max_pfn);
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.20/drivers/block/umem.c linux/drivers/block/umem.c
--- /opt/kernel/linux-2.5.20/drivers/block/umem.c	2002-05-29 20:42:54.000000000 +0200
+++ linux/drivers/block/umem.c	2002-06-04 16:13:48.000000000 +0200
@@ -128,6 +128,8 @@
 				    */
 	struct bio	*bio, *currentbio, **biotail;
 
+	request_queue_t queue;
+
 	struct mm_page {
 		dma_addr_t		page_dma;
 		struct mm_dma_desc	*desc;
@@ -141,8 +143,6 @@
 	struct tasklet_struct	tasklet;
 	unsigned int dma_status;
 
-	struct tq_struct plug_tq;
-
 	struct {
 		int		good;
 		int		warned;
@@ -383,7 +383,10 @@
 
 static void mm_unplug_device(void *data)
 {
-	struct cardinfo *card = data;
+	request_queue_t *q = data;
+	struct cardinfo *card = q->queuedata;
+
+	blk_remove_plug(q);
 
 	spin_lock_bh(&card->lock);
 	activate(card);
@@ -577,7 +580,7 @@
 	card->biotail = &bio->bi_next;
 	spin_unlock_bh(&card->lock);
 
-	queue_task(&card->plug_tq, &tq_disk);
+	blk_plug_device(q);
 	return 0;
 }
 
@@ -1064,11 +1067,12 @@
 	card->bio = NULL;
 	card->biotail = &card->bio;
 
+	blk_queue_make_request(&card->queue, mm_make_request);
+	card->queue.queuedata = card;
+	card->queue.unplug_fn = mm_unplug_device;
+
 	tasklet_init(&card->tasklet, process_page, (unsigned long)card);
 
-	card->plug_tq.sync = 0;
-	card->plug_tq.routine = &mm_unplug_device;
-	card->plug_tq.data = card;
 	card->check_batteries = 0;
 	
 	mem_present = readb(card->csr_remap + MEMCTRLSTATUS_MEMORY);
@@ -1277,9 +1281,6 @@
 
 	add_gendisk(&mm_gendisk);
 
-	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR),
-			       mm_make_request);
-
         blk_size[MAJOR_NR]      = mm_gendisk.sizes;
         for (i = 0; i < num_cards; i++) {
 		register_disk(&mm_gendisk, mk_kdev(MAJOR_NR, i<<MM_SHIFT), MM_SHIFT,
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.20/include/linux/bio.h linux/include/linux/bio.h
--- /opt/kernel/linux-2.5.20/include/linux/bio.h	2002-05-29 20:42:57.000000000 +0200
+++ linux/include/linux/bio.h	2002-06-04 16:14:59.000000000 +0200
@@ -123,7 +123,7 @@
 #define bio_offset(bio)		bio_iovec((bio))->bv_offset
 #define bio_sectors(bio)	((bio)->bi_size >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
-#define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_BARRIER))
+#define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_RW_BARRIER))
 
 /*
  * will die
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.20/include/linux/blkdev.h linux/include/linux/blkdev.h
--- /opt/kernel/linux-2.5.20/include/linux/blkdev.h	2002-06-03 10:35:40.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-06-04 16:15:22.000000000 +0200
@@ -116,7 +116,7 @@
 typedef request_queue_t * (queue_proc) (kdev_t dev);
 typedef int (make_request_fn) (request_queue_t *q, struct bio *bio);
 typedef int (prep_rq_fn) (request_queue_t *, struct request *);
-typedef void (unplug_device_fn) (void *q);
+typedef void (unplug_fn) (void *q);
 
 enum blk_queue_state {
 	Queue_down,
@@ -160,6 +160,7 @@
 	merge_requests_fn	*merge_requests_fn;
 	make_request_fn		*make_request_fn;
 	prep_rq_fn		*prep_rq_fn;
+	unplug_fn		*unplug_fn;
 
 	struct backing_dev_info	backing_dev_info;
 
@@ -209,13 +210,11 @@
 #define RQ_SCSI_DONE		0xfffe
 #define RQ_SCSI_DISCONNECTING	0xffe0
 
-#define QUEUE_FLAG_PLUGGED	0	/* queue is plugged */
-#define QUEUE_FLAG_CLUSTER	1	/* cluster several segments into 1 */
-#define QUEUE_FLAG_QUEUED	2	/* uses generic tag queueing */
-#define QUEUE_FLAG_STOPPED	3	/* queue is stopped */
+#define QUEUE_FLAG_CLUSTER	0	/* cluster several segments into 1 */
+#define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
+#define QUEUE_FLAG_STOPPED	2	/* queue is stopped */
 
-#define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
-#define blk_mark_plugged(q)	set_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
+#define blk_queue_plugged(q)	!list_empty(&(q)->plug_list)
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_empty(q)	elv_queue_empty(q)
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
@@ -295,6 +294,7 @@
 extern struct request *blk_get_request(request_queue_t *, int, int);
 extern void blk_put_request(struct request *);
 extern void blk_plug_device(request_queue_t *);
+extern int blk_remove_plug(request_queue_t *);
 extern void blk_recount_segments(request_queue_t *, struct bio *);
 extern inline int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern inline int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);

-- 
Jens Axboe

