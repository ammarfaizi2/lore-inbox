Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288564AbSADJVl>; Fri, 4 Jan 2002 04:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288560AbSADJVZ>; Fri, 4 Jan 2002 04:21:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65042 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288564AbSADJVG>;
	Fri, 4 Jan 2002 04:21:06 -0500
Date: Fri, 4 Jan 2002 10:21:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
Message-ID: <20020104102102.R8673@suse.de>
In-Reply-To: <20020104094334.N8673@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020104094334.N8673@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04 2002, Jens Axboe wrote:
> Against 2.5.2-pre7

There was a stupid bug in the last version (last minute change...) which
caused a non-expired write to preempt an expired read, not optimal :-).
Here's a fixed version.

diff -ur -X exclude /opt/kernel/linux-2.5.2-pre7/drivers/block/Config.in linux/drivers/block/Config.in
--- /opt/kernel/linux-2.5.2-pre7/drivers/block/Config.in	Fri Sep 14 17:04:06 2001
+++ linux/drivers/block/Config.in	Fri Jan  4 03:10:42 2002
@@ -4,6 +4,25 @@
 mainmenu_option next_comment
 comment 'Block devices'
 
+mainmenu_option next_comment
+comment 'I/O schedulers'
+
+comment 'Linus I/O scheduler'
+int '   READ passover seed (kb)' CONFIG_BLK_IOSCHED_LINUS_RL 4096
+int '   WRITE passover seed (kb)' CONFIG_BLK_IOSCHED_LINUS_WL 8192
+
+comment 'Jens I/O scheduler'
+int '   READ expire time (seconds)' CONFIG_BLK_IOSCHED_JENS_RE 1
+int '   WRITE expire time (seconds)' CONFIG_BLK_IOSCHED_JENS_WE 5
+int '   Request batch' CONFIG_BLK_IOSCHED_JENS_RB 16
+
+choice 'default scheduler' \
+	"Linus-iosched			CONFIG_BLK_IOSCHED_DEF_L \
+	 Jens-iosched			CONFIG_BLK_IOSCHED_DEF_J \
+	 Noop-iosched			CONFIG_BLK_IOSCHED_DEF_N" Jens-iosched
+
+endmenu
+
 tristate 'Normal PC floppy disk support' CONFIG_BLK_DEV_FD
 if [ "$CONFIG_AMIGA" = "y" ]; then
    tristate 'Amiga floppy support' CONFIG_AMIGA_FLOPPY
diff -ur -X exclude /opt/kernel/linux-2.5.2-pre7/drivers/block/elevator.c linux/drivers/block/elevator.c
--- /opt/kernel/linux-2.5.2-pre7/drivers/block/elevator.c	Fri Jan  4 02:31:26 2002
+++ linux/drivers/block/elevator.c	Fri Jan  4 04:07:59 2002
@@ -58,8 +58,6 @@
 
 	next_rq = list_entry(next, struct request, queuelist);
 
-	BUG_ON(next_rq->flags & REQ_STARTED);
-
 	/*
 	 * not a sector based request
 	 */
@@ -147,9 +145,10 @@
 	 */
 	if (q->last_merge) {
 		struct request *__rq = list_entry_rq(q->last_merge);
-		BUG_ON(__rq->flags & REQ_STARTED);
 
-		if ((ret = elv_try_merge(__rq, bio)))
+		if (!rq_mergeable(__rq))
+			q->last_merge = NULL;
+		else if ((ret = elv_try_merge(__rq, bio)))
 			*req = __rq;
 	}
 
@@ -231,6 +230,12 @@
 	elevator_t *e = &q->elevator;
 	int lat = 0, *latency = e->elevator_data;
 
+	/*
+	 * it's a bug to let this rq preempt an already started request
+	 */
+	if (insert_here->next != &q->queue_head)
+		BUG_ON(list_entry_rq(insert_here->next)->flags & REQ_STARTED);
+
 	if (!(rq->flags & REQ_BARRIER))
 		lat = latency[rq_data_dir(rq)];
 
@@ -255,9 +260,10 @@
 	if (!latency)
 		return -ENOMEM;
 
-	latency[READ] = 8192;
-	latency[WRITE] = 16384;
+	latency[READ] = CONFIG_BLK_IOSCHED_LINUS_RL << 1;
+	latency[WRITE] = CONFIG_BLK_IOSCHED_LINUS_WL << 1;
 
+	printk("elv_linus: r/w sequence %d/%d\n", latency[READ],latency[WRITE]);
 	e->elevator_data = latency;
 	return 0;
 }
@@ -324,6 +330,254 @@
 }
 
 /*
+ * multi-list I/O scheduler
+ */
+static kmem_cache_t *elv_jens_entries;
+extern int queue_nr_requests;
+
+int elevator_jens_init(request_queue_t *q, elevator_t *e)
+{
+	struct elv_jens_data *edat;
+	struct elv_jens_entry *ee;
+	int creat = 0, i, re, we, rb;
+
+	if (!elv_jens_entries) {
+		elv_jens_entries = kmem_cache_create("elv_jens", sizeof(struct elv_jens_entry), 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+		if (!elv_jens_entries)
+			return -ENOMEM;
+		creat = 1;
+	}
+
+	edat = kmalloc(sizeof(struct elv_jens_data), GFP_KERNEL);
+	if (!edat) {
+		if (creat)
+			kmem_cache_destroy(elv_jens_entries);
+		return -ENOMEM;
+	}
+
+	memset(edat, 0, sizeof(*edat));
+
+	INIT_LIST_HEAD(&edat->fifo_r);
+	INIT_LIST_HEAD(&edat->fifo_w);
+	INIT_LIST_HEAD(&edat->free_entry);
+
+	for (i = 0; i < queue_nr_requests; i++) {
+		ee = kmem_cache_alloc(elv_jens_entries, SLAB_KERNEL);
+		memset(ee, 0, sizeof(*ee));
+		list_add(&ee->fifo_list, &edat->free_entry);
+	}
+
+	/*
+	 * configured values
+	 */
+	re = CONFIG_BLK_IOSCHED_JENS_RE;
+	we = CONFIG_BLK_IOSCHED_JENS_WE;
+	rb = CONFIG_BLK_IOSCHED_JENS_RB;
+
+	edat->expires[READ] = re * HZ;
+	edat->expires[WRITE] = we * HZ;
+	edat->batch = rb;
+
+	e->elevator_data = edat;
+	return 0;
+}
+
+#define list_entry_fifo(entry)		\
+	list_entry((entry), struct elv_jens_entry, fifo_list)
+
+void elevator_jens_exit(request_queue_t *q, elevator_t *e)
+{
+	struct elv_jens_data *edat = e->elevator_data;
+	struct list_head *head = &edat->free_entry;
+	struct elv_jens_entry *ee;
+
+	BUG_ON(!list_empty(&edat->fifo_r));
+	BUG_ON(!list_empty(&edat->fifo_w));
+
+	while (!list_empty(head)) {
+		ee = list_entry(head->next, struct elv_jens_entry, fifo_list);
+		list_del(&ee->fifo_list);
+		kmem_cache_free(elv_jens_entries, ee);
+	}
+
+	kfree(edat);
+	e->elevator_data = NULL;
+}
+
+int elevator_jens_merge(request_queue_t *q, struct request **req,
+			struct bio *bio)
+{
+	struct list_head *entry = &q->queue_head;
+	struct request *__rq;
+	int ret;
+
+	if ((ret = elv_try_last_merge(q, req, bio)))
+		return ret;
+
+	while ((entry = entry->prev) != &q->queue_head) {
+		__rq = list_entry_rq(entry);
+
+		if (__rq->flags & REQ_BARRIER)
+			break;
+
+		/*
+		 * we can have started requests in the middle of the queue,
+		 * not a problem
+		 */
+		if (__rq->flags & REQ_STARTED)
+			continue;
+
+		if (!(__rq->flags & REQ_CMD))
+			continue;
+
+		if (!*req && bio_rq_in_between(bio, __rq, &q->queue_head))
+			*req = __rq;
+
+		if ((ret = elv_try_merge(__rq, bio))) {
+			*req = __rq;
+			q->last_merge = &__rq->queuelist;
+			return ret;
+		}
+	}
+
+	return ELEVATOR_NO_MERGE;
+}
+
+void elevator_jens_add_request(request_queue_t *q, struct request *rq,
+			       struct list_head *insert_here)
+{
+	elevator_t *e = &q->elevator;
+	struct elv_jens_data *edat = e->elevator_data;
+	struct elv_jens_entry *ee;
+
+	/*
+	 * insert into sector sorted list
+	 */
+	list_add(&rq->queuelist, insert_here);
+
+	if (unlikely(!(rq->flags & REQ_CMD)))
+		return;
+
+	/*
+	 * insert into fifo list and assign deadline
+	 */
+	BUG_ON(list_empty(&edat->free_entry));
+	ee = list_entry_fifo(edat->free_entry.next);
+	list_del(&ee->fifo_list);
+	ee->rq = rq;
+	rq->elevator_private = ee;
+
+	if (rq_data_dir(rq) == READ) {
+		ee->expire_time = jiffies + edat->expires[READ];
+		list_add_tail(&ee->fifo_list, &edat->fifo_r);
+	} else {
+		ee->expire_time = jiffies + edat->expires[WRITE];
+		list_add_tail(&ee->fifo_list, &edat->fifo_w);
+	}
+}
+
+void elevator_jens_remove_request(request_queue_t *q, struct request *rq)
+{
+	struct elv_jens_entry *ee = rq->elevator_private;
+	struct elv_jens_data *edat = q->elevator.elevator_data;
+	struct list_head *next = rq->queuelist.next;
+
+	if (next == &q->queue_head)
+		next = NULL;
+
+	/*
+	 * if we are currently following a link of the fifo list, just
+	 * adjust next_entry. if not, set to NULL and elv_next_request
+	 * will reposition it
+	 */
+	if (edat->fifo_count) {
+		edat->next_entry = next;
+		if (!--edat->fifo_count || !next)
+			edat->restart = 1;
+	} else
+		edat->next_entry = NULL;
+
+	if (ee) {
+		rq->elevator_private = NULL;
+		list_del(&ee->fifo_list);
+		list_add(&ee->fifo_list, &edat->free_entry);
+		ee->rq = NULL;
+	}
+}
+
+inline struct list_head *elevator_jens_find_request(request_queue_t *q,
+						    struct elv_jens_data *edat)
+{
+	struct list_head *entry = q->queue_head.next;
+	struct elv_jens_entry *ee = NULL, *tmp;
+
+	/*
+	 * check if fifo read queue has expired entry
+	 */
+	if (!list_empty(&edat->fifo_r)) {
+		tmp = list_entry_fifo(edat->fifo_r.next);
+		if (time_after(jiffies, tmp->expire_time))
+			ee = tmp;
+	}
+
+	/*
+	 * check if fifo write queue has expired entry, and if so should it
+	 * be served before possible read entry
+	 */ 
+	if (!list_empty(&edat->fifo_w)) {
+		tmp = list_entry_fifo(edat->fifo_w.next);
+		if (time_after(jiffies, tmp->expire_time)) {
+			/*
+			 * if they are equal, give preference to read
+			 */
+			if (ee && time_after(tmp->expire_time, ee->expire_time))
+				ee = tmp;
+		}
+	}
+
+	if (ee) {
+		edat->restart = 1;
+		entry = &ee->rq->queuelist;
+	}
+
+	return entry;
+}
+
+struct request *elevator_jens_next_request(request_queue_t *q)
+{
+	elevator_t *e = &q->elevator;
+	struct elv_jens_data *edat = e->elevator_data;
+	struct list_head *next;
+
+	if (edat->next_entry)
+		return list_entry_rq(edat->next_entry);
+
+	if (unlikely(list_empty(&q->queue_head)))
+		return NULL;
+
+	next = elevator_jens_find_request(q, edat);
+
+	if (edat->restart) {
+		edat->restart = 0;
+		edat->fifo_count = edat->batch;
+	}
+
+	edat->next_entry = next;
+	return list_entry_rq(edat->next_entry);
+}
+
+void elevator_jens_merge_req(struct request *req, struct request *next)
+{
+	struct elv_jens_entry *ereq = req->elevator_private;
+	struct elv_jens_entry *enext = next->elevator_private;
+
+	if (ereq && enext) {
+		if (time_before(enext->expire_time, ereq->expire_time))
+			ereq->expire_time = enext->expire_time;
+	}
+}
+
+/*
  * general block -> elevator interface starts here
  */
 int elevator_init(request_queue_t *q, elevator_t *e, elevator_t type)
@@ -416,10 +670,21 @@
 	elevator_add_req_fn:		elevator_noop_add_request,
 };
 
+elevator_t elevator_jens = {
+	elevator_merge_fn:		elevator_jens_merge,
+	elevator_merge_req_fn:		elevator_jens_merge_req,
+	elevator_next_req_fn:		elevator_jens_next_request,
+	elevator_add_req_fn:		elevator_jens_add_request,
+	elevator_remove_req_fn:		elevator_jens_remove_request,
+	elevator_init_fn:		elevator_jens_init,
+	elevator_exit_fn:		elevator_jens_exit,
+};
+
 module_init(elevator_global_init);
 
 EXPORT_SYMBOL(elevator_linus);
 EXPORT_SYMBOL(elevator_noop);
+EXPORT_SYMBOL(elevator_jens);
 
 EXPORT_SYMBOL(__elv_add_request);
 EXPORT_SYMBOL(__elv_next_request);
diff -ur -X exclude /opt/kernel/linux-2.5.2-pre7/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.5.2-pre7/drivers/block/ll_rw_blk.c	Fri Jan  4 02:31:26 2002
+++ linux/drivers/block/ll_rw_blk.c	Fri Jan  4 03:49:28 2002
@@ -798,12 +798,23 @@
  **/
 int blk_init_queue(request_queue_t *q, request_fn_proc *rfn, spinlock_t *lock)
 {
+	elevator_t e;
 	int ret;
 
 	if (blk_init_free_list(q))
 		return -ENOMEM;
 
-	if ((ret = elevator_init(q, &q->elevator, elevator_linus))) {
+#if defined(CONFIG_BLK_IOSCHED_DEF_L)
+	e = elevator_linus;
+#elif defined(CONFIG_BLK_IOSCHED_DEF_J)
+	e = elevator_jens;
+#elif #defined(CONFIG_BLK_IOSCHED_DEF_N)
+	e = elevator_noop;
+#else
+#error No I/O scheduler defined
+#endif
+
+	if ((ret = elevator_init(q, &q->elevator, e))) {
 		blk_cleanup_queue(q);
 		return ret;
 	}
@@ -818,7 +829,6 @@
 	q->plug_tq.data		= q;
 	q->queue_flags		= (1 << QUEUE_FLAG_CLUSTER);
 	q->queue_lock		= lock;
-	q->last_merge		= NULL;
 	
 	blk_queue_segment_boundary(q, 0xffffffff);
 
@@ -964,12 +974,6 @@
 	drive_stat_acct(req, req->nr_sectors, 1);
 
 	/*
-	 * it's a bug to let this rq preempt an already started request
-	 */
-	if (insert_here->next != &q->queue_head)
-		BUG_ON(list_entry_rq(insert_here->next)->flags & REQ_STARTED);
-
-	/*
 	 * elevator indicated where it wants this request to be
 	 * inserted at elevator_merge time
 	 */
@@ -1701,7 +1705,7 @@
 	 */
 	queue_nr_requests = 64;
 	if (total_ram > MB(32))
-		queue_nr_requests = 256;
+		queue_nr_requests = 512;
 
 	/*
 	 * Batch frees according to queue length
diff -ur -X exclude /opt/kernel/linux-2.5.2-pre7/include/linux/elevator.h linux/include/linux/elevator.h
--- /opt/kernel/linux-2.5.2-pre7/include/linux/elevator.h	Fri Jan  4 02:31:31 2002
+++ linux/include/linux/elevator.h	Fri Jan  4 03:11:13 2002
@@ -60,6 +60,49 @@
 #define elv_linus_sequence(rq)	((long)(rq)->elevator_private)
 
 /*
+ * multi-list I/O scheduler
+ */
+extern elevator_t elevator_jens;
+
+struct elv_jens_entry {
+	struct request *rq;
+	unsigned long expire_time;
+	struct list_head fifo_list;
+};
+
+struct elv_jens_data {
+	/*
+	 * "next" request to be queued
+	 */
+	struct list_head *next_entry;
+
+	/*
+	 * currently restarted from fifo head due to starvation
+	 */
+	int fifo_count;
+
+	/*
+	 * time based fifo queue, for read and write. could be one list
+	 * or a better data structure, since it should be just sorted
+	 * by expire time. later :-)
+	 */
+	struct list_head fifo_r;
+	struct list_head fifo_w;
+
+	/*
+	 * available entries
+	 */
+	struct list_head free_entry;
+
+	/*
+	 * I/O scheduler settings
+	 */
+	unsigned long expires[2];
+	int batch;
+	int restart : 1;
+};
+
+/*
  * use the /proc/iosched interface, all the below is history ->
  */
 typedef struct blkelv_ioctl_arg_s {

-- 
Jens Axboe

