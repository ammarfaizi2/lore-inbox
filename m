Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbSJUIp3>; Mon, 21 Oct 2002 04:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSJUIp3>; Mon, 21 Oct 2002 04:45:29 -0400
Received: from 213.237.116.70.adsl.oebr.worldonline.dk ([213.237.116.70]:63824
	"EHLO thor.jiffies.dk") by vger.kernel.org with ESMTP
	id <S261282AbSJUIpQ>; Mon, 21 Oct 2002 04:45:16 -0400
Date: Mon, 21 Oct 2002 10:51:13 +0200
To: Jens Axboe <axboe@suse.de>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Priorities for I/O
Message-ID: <20021021085113.GA15770@jiffies.dk>
References: <20021021072629.GD6630@nbkurt.casa-etp.nl> <20021021082429.GE11594@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20021021082429.GE11594@suse.de>
User-Agent: Mutt/1.3.28i
From: Christoffer Hall-Frederiksen <hall@jiffies.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've worked on this a well.

Here is a patch that does what you want.

I don't know if it applies cleanly to the latest 2.5. I worked fine
around 2.5.40. I havent' given the patch the extensive testing that is
needed but it works for me ;)

On Mon, Oct 21, 2002 at 10:24:29AM +0200, Jens Axboe wrote:
|>  On Mon, Oct 21 2002, Kurt Garloff wrote:
|>  > Hi Jens,
|>  > 
|>  > one of the shortcomings of Linux process priority system is that it only
|>  > affects CPU resources (and even those are not affected strongly enough for
|>  > some applications). 
|>  > As soon as processes waits for I/O, they are all equal.
|>  
|>  I agree that it's a feature that would be nice to have, but I also don't
|>  think it's that important.
|>  
|>  > I wonder how difficult it was to just add priorities to your I/O scheduler.
|>  > Basically, I think everything is there: You sort requests already and we
|>  > have deadlines. For sorting scores are used.
|>  > So the idea is: Why not just give I/O submitted on behalf of -19 processes
|>  > (and RT) some higher score and a shorter deadline than +19 ones?
|>  > Probably, it would only affect reads, as there we have the processes wait
|>  > on them; writes are often triggered asynchronously anyway.
|>  
|>  You are missing one little detail -- yes there is an expire list for
|>  reads, and it is indeed sorted by deadline. Right now this operates in
|>  O(1) time for insert and retrieval, since it's a plain FIFO (well
|>  sometimes we move entries from the middle of the list as well).
|>  
|>  So if you want to starting basing deadlines on process priority, you
|>  would have to sort insert instead.
|>  
|>  It's not a big issue, but cycles spent in the io scheduler was very much
|>  considered when I wrote it (it's faster than the old one). And we could
|>  always just replace the simple doubly linked list with something else.
|>  Back in the early days of bio, I actually had the sorting changed to a
|>  binomial heap. Given that both the read+write sort lists and expire
|>  lists are just priority queues now, it would work easily. Anyways,
|>  getting off track...
|>  
|>  > This should have the effects that we want: When there's no fight for I/O
|>  > bandwidth, everybody just gets maximum performance as the I/O scheduler's
|>  > queue will be short. As soon as processes fight for reads, unniced processes
|>  > have a higher chance of getting served first.
|>  > 
|>  > Just think of nightly updatedb on a webserver for a real-world example why
|>  > this may matter.
|>  > 
|>  > Looks like something not too difficult to do, but my current knowledge on
|>  > 2.5 code is somewhat sparse :-(
|>  
|>  If you want to give it a try, it's pretty easy to add. dd->read_fifo is
|>  our fifo expire list right now, you'd want to change that to
|>  dd->read_prio or something. And in deadline_add_request(), the very last
|>  thing we do is add the read to the tail of the expire list:
|>  
|>  	drq->expires = jiffies + dd->read_expire;
|>  	list_add_tail(&drq->fifo, &dd->read_fifo);
|>  
|>  you'd just want something ala
|>  
|>  	struct list_head *foo = &dd->read_prio;
|>  	struct deadline_rq *__drq;
|>  
|>  	drq->expires = jiffies + deadline_process_expire();
|>  	while ((foo = foo->prev) != &dd->read_prio) {
|>  		__drq = list_entry_fifo(foo);
|>  		if (__drq->expires > drq->expires)
|>  			break;
|>  	}
|>  
|>  	list_add(&drq->fifo, foo);
|>  
|>  you get the picture. And that should be it, really. Everything else
|>  should just work as-is, iirc.

-- 
	Christoffer

--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bio-prio.patch-2"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.675   -> 1.677  
#	drivers/block/ll_rw_blk.c	1.115   -> 1.117  
#	include/linux/blkdev.h	1.70    -> 1.72   
#	  include/linux/fs.h	1.165   -> 1.166  
#	include/linux/backing-dev.h	1.3     -> 1.4    
#	 include/linux/bio.h	1.21    -> 1.22   
#	drivers/block/deadline-iosched.c	1.4     -> 1.5    
#	               (new)	        -> 1.2     include/linux/blk_io_prio.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	hall@thor.jiffies.dk	1.676
# 
# Added priorities to bio's.
# Changed the allocation of requests. Allocation groups are now used.
# --------------------------------------------
# 02/10/06	hall@thor.jiffies.dk	1.677
# Fixes.
# --------------------------------------------
#
diff -Nru a/drivers/block/deadline-iosched.c b/drivers/block/deadline-iosched.c
--- a/drivers/block/deadline-iosched.c	Sun Oct  6 14:55:47 2002
+++ b/drivers/block/deadline-iosched.c	Sun Oct  6 14:55:47 2002
@@ -24,7 +24,8 @@
  * fifo_batch is how many steps along the sorted list we will take when the
  * front fifo request expires.
  */
-static int read_expire = HZ / 2;	/* 500ms start timeout */
+static int write_expire = HZ * 4;	/* 2s start timeout for writes */
+static int read_expire = HZ / 2;	/* 500ms start timeout for read */
 static int fifo_batch = 32;		/* 4 seeks, or 64 contig */
 static int seek_cost = 16;		/* seek is 16 times more expensive */
 
@@ -49,7 +50,8 @@
 	 * run time data
 	 */
 	struct list_head sort_list[2];	/* sorted listed */
-	struct list_head read_fifo;	/* fifo list */
+	struct list_head read_fifo;	/* prio list */
+	struct list_head write_fifo;	/* prio list */
 	struct list_head *dispatch;	/* driver dispatch queue */
 	struct list_head *hash;		/* request hash */
 	sector_t last_sector;		/* last sector sent to drive */
@@ -61,6 +63,7 @@
 	 */
 	unsigned int fifo_batch;
 	unsigned long read_expire;
+	unsigned long write_expire;
 	unsigned int seek_cost;
 	unsigned int writes_starved;
 };
@@ -322,17 +325,21 @@
  * returns 0 if there are no expired reads on the fifo, 1 otherwise
  */
 #define list_entry_fifo(ptr)	list_entry((ptr), struct deadline_rq, fifo)
-static inline int deadline_check_fifo(struct deadline_data *dd)
+static inline int deadline_check_fifo(struct deadline_data *dd, int ddir)
 {
-	if (!list_empty(&dd->read_fifo)) {
-		struct deadline_rq *drq = list_entry_fifo(dd->read_fifo.next);
+	struct deadline_rq *drq = NULL;
 
-		/*
-		 * drq is expired!
-		 */
-		if (time_after(jiffies, drq->expires))
+	if (ddir==READ && !list_empty(&dd->read_fifo))
+		drq = list_entry_fifo(dd->read_fifo.next);
+
+	if (ddir==WRITE && !list_empty(&dd->write_fifo))
+		drq = list_entry_fifo(dd->write_fifo.next);
+
+	/*
+	 * drq is expired?
+	 */
+	if (drq && time_after(jiffies, drq->expires))
 			return 1;
-	}
 
 	return 0;
 }
@@ -360,7 +367,7 @@
 	/*
 	 * if we have expired entries on the fifo list, move some to dispatch
 	 */
-	if (deadline_check_fifo(dd)) {
+	if (deadline_check_fifo(dd, READ)) {
 		if (writes && (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
@@ -385,8 +392,15 @@
 	 */
 	if (writes) {
 dispatch_writes:
-		nxt = dd->sort_list[WRITE].next;
-		deadline_move_requests(dd, list_entry_rq(nxt));
+		if (deadline_check_fifo(dd, WRITE)) {
+			nxt = dd->write_fifo.next;
+			drq = list_entry_fifo(nxt);
+			deadline_move_requests(dd, drq->request);
+		} else {
+			nxt = dd->sort_list[WRITE].next;
+			deadline_move_requests(dd, list_entry_rq(nxt));
+		}
+
 		dd->starved = 0;
 		goto dispatch;
 	}
@@ -396,12 +410,63 @@
 	return NULL;
 }
 
+static inline 
+void deadline_add_request_sorted(struct deadline_rq *drq, struct list_head *prio_list)
+{
+	struct list_head *entry;
+	struct deadline_rq *tmp;
+
+	entry = prio_list;
+	while ((entry = entry->prev) != prio_list) {
+		tmp = list_entry_fifo(entry);
+
+		if (tmp->expires <= drq->expires)
+			break;
+	}
+
+	list_add_tail(&drq->fifo, entry);
+}
+
+static inline
+int deadline_prio_to_expire(int expire, int prio)
+{
+
+	int expire_tmp 		= expire / 2;
+	int ticks_pr_prio	= expire/BIO_PRIO_MAX; 
+
+	if (prio == BIO_PRIO_IDLE)
+		return 0;
+
+	return expire_tmp + prio * ticks_pr_prio;
+}
+
+int deadline_calc_expire(struct deadline_data *dd, struct request *rq)
+{
+	int prio, ddir, expire = 0;
+
+	ddir	= rq_data_dir(rq);
+	prio	= bio_prio(rq->bio);
+
+	switch(ddir) {
+	case READ:	
+		expire = dd->read_expire;
+		break;
+	case WRITE:	
+		expire = dd->write_expire;
+		break;
+	default:
+		BUG();
+	};
+
+	return deadline_prio_to_expire(expire, prio);
+}
+
 static void
 deadline_add_request(request_queue_t *q, struct request *rq, struct list_head *insert_here)
 {
 	struct deadline_data *dd = q->elevator.elevator_data;
 	struct deadline_rq *drq = RQ_DATA(rq);
-	const int data_dir = rq_data_dir(rq);
+	int expire, data_dir = rq_data_dir(rq);
 
 	/*
 	 * flush hash on barrier insert, as not to allow merges before a
@@ -430,12 +495,23 @@
 			q->last_merge = &rq->queuelist;
 	}
 
+	expire = deadline_calc_expire(dd, rq);
+
+	if (!expire) /* Idle priority doesn't expire */
+		return;
+
 	if (data_dir == READ) {
 		/*
-		 * set expire time and add to fifo list
+		 * set expire time and add to prio list
+		 */
+		drq->expires = jiffies + expire;
+		deadline_add_request_sorted(drq, &dd->read_fifo);
+	} else if (data_dir == WRITE) {
+		/*
+		 * set expire time and add to prio list
 		 */
-		drq->expires = jiffies + dd->read_expire;
-		list_add_tail(&drq->fifo, &dd->read_fifo);
+		drq->expires = jiffies + expire;
+		deadline_add_request_sorted(drq, &dd->write_fifo);
 	}
 }
 
@@ -459,6 +535,7 @@
 		return 0;
 
 	BUG_ON(!list_empty(&dd->read_fifo));
+	BUG_ON(!list_empty(&dd->write_fifo));
 	return 1;
 }
 
@@ -475,27 +552,30 @@
 	struct deadline_data *dd = e->elevator_data;
 	struct deadline_rq *drq;
 	struct request *rq;
-	int i;
+	int j, i;
 
 	BUG_ON(!list_empty(&dd->read_fifo));
+	BUG_ON(!list_empty(&dd->write_fifo));
 	BUG_ON(!list_empty(&dd->sort_list[READ]));
 	BUG_ON(!list_empty(&dd->sort_list[WRITE]));
 
-	for (i = READ; i <= WRITE; i++) {
-		struct request_list *rl = &q->rq[i];
-		struct list_head *entry = &rl->free;
+	for (j = 0; j < QUEUE_NR_AGS; j++) {
+		for (i = READ; i <= WRITE; i++) {
+			struct request_list *rl = &q->ags[j].rq[i];
+			struct list_head *entry = &rl->free;
 
-		if (list_empty(&rl->free))
-			continue;
-	
-		while ((entry = entry->next) != &rl->free) {
-			rq = list_entry_rq(entry);
-
-			if ((drq = RQ_DATA(rq)) == NULL)
+			if (list_empty(&rl->free))
 				continue;
 
-			rq->elevator_private = NULL;
-			kmem_cache_free(drq_pool, drq);
+			while ((entry = entry->next) != &rl->free) {
+				rq = list_entry_rq(entry);
+
+				if ((drq = RQ_DATA(rq)) == NULL)
+					continue;
+
+				rq->elevator_private = NULL;
+				kmem_cache_free(drq_pool, drq);
+			}
 		}
 	}
 
@@ -512,7 +592,7 @@
 	struct deadline_data *dd;
 	struct deadline_rq *drq;
 	struct request *rq;
-	int i, ret = 0;
+	int j, i, ret = 0;
 
 	if (!drq_pool)
 		return -ENOMEM;
@@ -532,37 +612,42 @@
 		INIT_LIST_HEAD(&dd->hash[i]);
 
 	INIT_LIST_HEAD(&dd->read_fifo);
+	INIT_LIST_HEAD(&dd->write_fifo);
 	INIT_LIST_HEAD(&dd->sort_list[READ]);
 	INIT_LIST_HEAD(&dd->sort_list[WRITE]);
 	dd->dispatch = &q->queue_head;
 	dd->fifo_batch = fifo_batch;
 	dd->read_expire = read_expire;
+	dd->read_expire = write_expire;
+	dd->write_expire = write_expire;
 	dd->seek_cost = seek_cost;
 	dd->hash_valid_count = 1;
 	dd->writes_starved = writes_starved;
 	e->elevator_data = dd;
 
-	for (i = READ; i <= WRITE; i++) {
-		struct request_list *rl = &q->rq[i];
-		struct list_head *entry = &rl->free;
+	for (j = 0; j < QUEUE_NR_AGS; j++) {
+		for (i = READ; i <= WRITE; i++) {
+			struct request_list *rl = &q->ags[j].rq[i];
+			struct list_head *entry = &rl->free;
 
-		if (list_empty(&rl->free))
-			continue;
-	
-		while ((entry = entry->next) != &rl->free) {
-			rq = list_entry_rq(entry);
-
-			drq = kmem_cache_alloc(drq_pool, GFP_KERNEL);
-			if (!drq) {
-				ret = -ENOMEM;
-				break;
-			}
+			if (list_empty(&rl->free))
+				continue;
 
-			memset(drq, 0, sizeof(*drq));
-			INIT_LIST_HEAD(&drq->fifo);
-			INIT_LIST_HEAD(&drq->hash);
-			drq->request = rq;
-			rq->elevator_private = drq;
+			while ((entry = entry->next) != &rl->free) {
+				rq = list_entry_rq(entry);
+
+				drq = kmem_cache_alloc(drq_pool, GFP_KERNEL);
+				if (!drq) {
+					ret = -ENOMEM;
+					break;
+				}
+
+				memset(drq, 0, sizeof(*drq));
+				INIT_LIST_HEAD(&drq->fifo);
+				INIT_LIST_HEAD(&drq->hash);
+				drq->request = rq;
+				rq->elevator_private = drq;
+			}
 		}
 	}
 
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Sun Oct  6 14:55:47 2002
+++ b/drivers/block/ll_rw_blk.c	Sun Oct  6 14:55:47 2002
@@ -60,10 +60,13 @@
 unsigned long blk_max_low_pfn, blk_max_pfn;
 int blk_nohighio = 0;
 
-static struct congestion_state {
-	wait_queue_head_t wqh;
-	atomic_t nr_congested_queues;
-} congestion_states[2];
+static struct queue_ag_congestion {
+	struct congestion_state {
+		wait_queue_head_t wqh;
+		atomic_t nr_congested_queues;
+	} states[2];
+} congestion_states[QUEUE_NR_AGS];
+
 
 /*
  * Return the threshold (number of free requests) at which the queue is
@@ -93,27 +96,27 @@
 	return ret;
 }
 
-static void clear_queue_congested(request_queue_t *q, int rw)
+static void clear_queue_congested(request_queue_t *q, int ag, int rw)
 {
-	enum bdi_state bit;
-	struct congestion_state *cs = &congestion_states[rw];
+	enum bdi_ag_state bit;
+	struct congestion_state *cs = &congestion_states[ag].states[rw];
 
 	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
 
-	if (test_and_clear_bit(bit, &q->backing_dev_info.state))
+	if (test_and_clear_bit(bit, &q->backing_dev_info.agstate[ag]))
 		atomic_dec(&cs->nr_congested_queues);
 	if (waitqueue_active(&cs->wqh))
 		wake_up(&cs->wqh);
 }
 
-static void set_queue_congested(request_queue_t *q, int rw)
+static void set_queue_congested(request_queue_t *q, int ag, int rw)
 {
-	enum bdi_state bit;
+	enum bdi_ag_state bit;
 
 	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
 
-	if (!test_and_set_bit(bit, &q->backing_dev_info.state))
-		atomic_inc(&congestion_states[rw].nr_congested_queues);
+	if (!test_and_set_bit(bit, &q->backing_dev_info.agstate[ag]))
+		atomic_inc(&congestion_states[ag].states[rw].nr_congested_queues);
 }
 
 /**
@@ -1112,10 +1115,10 @@
  **/
 void blk_cleanup_queue(request_queue_t * q)
 {
-	int count = (queue_nr_requests*2);
+	int i, count = (queue_nr_requests*2*QUEUE_NR_AGS);
 
-	count -= __blk_cleanup_queue(&q->rq[READ]);
-	count -= __blk_cleanup_queue(&q->rq[WRITE]);
+	for (i = 0; i < QUEUE_NR_AGS; i++)
+		count -= __blk_cleanup_queue(&q->ags[i].rq[READ]);
 
 	if (count)
 		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
@@ -1132,36 +1135,42 @@
 {
 	struct request_list *rl;
 	struct request *rq;
-	int i;
+	int i, j;
 
-	INIT_LIST_HEAD(&q->rq[READ].free);
-	INIT_LIST_HEAD(&q->rq[WRITE].free);
-	q->rq[READ].count = 0;
-	q->rq[WRITE].count = 0;
 
-	/*
-	 * Divide requests in half between read and write
-	 */
-	rl = &q->rq[READ];
-	for (i = 0; i < (queue_nr_requests*2); i++) {
-		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
-		if (!rq)
-			goto nomem;
+	for (j = 0; j < QUEUE_NR_AGS; j++) {
+		INIT_LIST_HEAD(&q->ags[j].rq[READ].free);
+		INIT_LIST_HEAD(&q->ags[j].rq[WRITE].free);
+		q->ags[j].rq[READ].count	= 0;
+		q->ags[j].rq[WRITE].count	= 0;
+		q->ags[j].rq[READ].ag 		= j;
+		q->ags[j].rq[WRITE].ag 		= j;
 
 		/*
-		 * half way through, switch to WRITE list
+		 * Divide requests in half between read and write
 		 */
-		if (i == queue_nr_requests)
-			rl = &q->rq[WRITE];
+		rl = &q->ags[j].rq[READ];
+		for (i = 0; i < (queue_nr_requests*2); i++) {
+			rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
+			if (!rq)
+				goto nomem;
 
-		memset(rq, 0, sizeof(struct request));
-		rq->rq_status = RQ_INACTIVE;
-		list_add(&rq->queuelist, &rl->free);
-		rl->count++;
+			/*
+			 * half way through, switch to WRITE list
+			 */
+			if (i == queue_nr_requests)
+				rl = &q->ags[j].rq[WRITE];
+
+			memset(rq, 0, sizeof(struct request));
+			rq->rq_status = RQ_INACTIVE;
+			list_add(&rq->queuelist, &rl->free);
+			rl->count++;
+		}
+
+		init_waitqueue_head(&q->ags[j].rq[READ].wait);
+		init_waitqueue_head(&q->ags[j].rq[WRITE].wait);
 	}
 
-	init_waitqueue_head(&q->rq[READ].wait);
-	init_waitqueue_head(&q->rq[WRITE].wait);
 	return 0;
 nomem:
 	blk_cleanup_queue(q);
@@ -1232,27 +1241,34 @@
 	return 0;
 }
 
+
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, queuelist)
 /*
  * Get a free request. queue lock must be held and interrupts
  * disabled on the way in.
  */
-static struct request *get_request(request_queue_t *q, int rw)
+static struct request *get_request(request_queue_t *q, int rw, int prio)
 {
+	int i, ag;
 	struct request *rq = NULL;
-	struct request_list *rl = q->rq + rw;
 
-	if (!list_empty(&rl->free)) {
-		rq = blkdev_free_rq(&rl->free);
-		list_del(&rq->queuelist);
-		rl->count--;
-		if (rl->count < queue_congestion_on_threshold())
-			set_queue_congested(q, rw);
-		rq->flags = 0;
-		rq->rq_status = RQ_ACTIVE;
-		rq->special = NULL;
-		rq->q = q;
-		rq->rl = rl;
+	ag = prio_to_ag(prio);
+	for(i = ag; i >= 0; i--) {
+		struct request_list *rl = &q->ags[i].rq[rw];
+		if (!list_empty(&rl->free)) {
+			rq = blkdev_free_rq(&rl->free);
+			list_del(&rq->queuelist);
+			rl->count--;
+			if (rl->count < queue_congestion_on_threshold())
+				set_queue_congested(q, i, rw); 
+			rq->flags = 0;
+			rq->rq_status = RQ_ACTIVE;
+			rq->special = NULL;
+			rq->q = q;
+			rq->rl = rl;
+			rq->rl->ag = i;
+			break;
+		}
 	}
 
 	return rq;
@@ -1261,10 +1277,11 @@
 /*
  * No available requests for this queue, unplug the device.
  */
-static struct request *get_request_wait(request_queue_t *q, int rw)
+static struct request *get_request_wait(request_queue_t *q, int rw, int prio)
 {
 	DEFINE_WAIT(wait);
-	struct request_list *rl = &q->rq[rw];
+	int ag = prio_to_ag(prio);
+	struct request_list *rl = &q->ags[ag].rq[rw];
 	struct request *rq;
 
 	spin_lock_prefetch(q->queue_lock);
@@ -1277,7 +1294,7 @@
 			schedule();
 		finish_wait(&rl->wait, &wait);
 		spin_lock_irq(q->queue_lock);
-		rq = get_request(q, rw);
+		rq = get_request(q, rw, prio);
 		spin_unlock_irq(q->queue_lock);
 	} while (rq == NULL);
 	return rq;
@@ -1290,11 +1307,11 @@
 	BUG_ON(rw != READ && rw != WRITE);
 
 	spin_lock_irq(q->queue_lock);
-	rq = get_request(q, rw);
+	rq = get_request(q, rw, BIO_PRIO_MED);
 	spin_unlock_irq(q->queue_lock);
 
 	if (!rq && (gfp_mask & __GFP_WAIT))
-		rq = get_request_wait(q, rw);
+		rq = get_request_wait(q, rw, BIO_PRIO_MED);
 
 	if (rq) {
 		rq->flags = 0;
@@ -1314,7 +1331,7 @@
 
 	BUG_ON(rw != READ && rw != WRITE);
 
-	rq = get_request(q, rw);
+	rq = get_request(q, rw, BIO_PRIO_MED);
 
 	if (rq) {
 		rq->flags = 0;
@@ -1437,6 +1454,7 @@
 	__elv_add_request(q, req, insert_here);
 }
 
+
 /*
  * Must be called with queue lock held and interrupts disabled
  */
@@ -1459,20 +1477,15 @@
 	 * it didn't come out of our reserved rq pools
 	 */
 	if (rl) {
-		int rw = 0;
+		int rw = rq_data_dir(req);
+		int ag = rl->ag;
 
 		list_add(&req->queuelist, &rl->free);
 
-		if (rl == &q->rq[WRITE])
-			rw = WRITE;
-		else if (rl == &q->rq[READ])
-			rw = READ;
-		else
-			BUG();
-
 		rl->count++;
 		if (rl->count >= queue_congestion_off_threshold())
-			clear_queue_congested(q, rw);
+			clear_queue_congested(q, ag, rw);
+
 		if (rl->count >= batch_requests && waitqueue_active(&rl->wait))
 			wake_up(&rl->wait);
 	}
@@ -1490,7 +1503,9 @@
 void blk_congestion_wait(int rw, long timeout)
 {
 	DEFINE_WAIT(wait);
-	struct congestion_state *cs = &congestion_states[rw];
+	int prio	= get_io_prio(current);
+	int ag		= prio_to_ag(prio);
+	struct congestion_state *cs = &congestion_states[ag].states[rw];
 
 	if (atomic_read(&cs->nr_congested_queues) == 0)
 		return;
@@ -1591,14 +1606,16 @@
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
 	struct request *req, *freereq = NULL;
-	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier;
+	int el_ret, rw, prio, nr_sectors, cur_nr_sectors, barrier;
 	struct list_head *insert_here;
 	sector_t sector;
 
+
 	sector = bio->bi_sector;
 	nr_sectors = bio_sectors(bio);
 	cur_nr_sectors = bio_iovec(bio)->bv_len >> 9;
 	rw = bio_data_dir(bio);
+	prio = bio_prio(bio);
 
 	/*
 	 * low level driver can indicate that it wants pages above a
@@ -1689,7 +1706,7 @@
 	if (freereq) {
 		req = freereq;
 		freereq = NULL;
-	} else if ((req = get_request(q, rw)) == NULL) {
+	} else if ((req = get_request(q, rw, prio)) == NULL) {
 		spin_unlock_irq(q->queue_lock);
 
 		/*
@@ -1698,7 +1715,7 @@
 		if (bio_flagged(bio, BIO_RW_AHEAD))
 			goto end_io;
 
-		freereq = get_request_wait(q, rw);
+		freereq = get_request_wait(q, rw, prio);
 		spin_lock_irq(q->queue_lock);
 		goto again;
 	}
@@ -1841,9 +1858,9 @@
 		ret = q->make_request_fn(q, bio);
 	} while (ret);
 }
-
 /**
- * submit_bio: submit a bio to the block device layer for I/O
+ * submit_bio: submit a bio with default task I/O priority to the block device
+ * layer for I/O 
  * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
  * @bio: The &struct bio which describes the I/O
  *
@@ -1854,6 +1871,24 @@
  */
 int submit_bio(int rw, struct bio *bio)
 {
+	int  prio = get_io_prio(current);
+	return submit_bio_prio(rw, prio, bio);
+}
+
+
+/**
+ * submit_bio_prio: submit a bio to the block device layer for I/O
+ * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
+ * @prio: the I/O priority of the request
+ * @bio: The &struct bio which describes the I/O
+ *
+ * submit_bio() is very similar in purpose to generic_make_request(), and
+ * uses that function to do most of the work. Both are fairly rough
+ * interfaces, @bio must be presetup and ready for I/O.
+ *
+ */
+int submit_bio_prio(int rw, int prio, struct bio *bio)
+{
 	int count = bio_sectors(bio);
 
 	/*
@@ -1864,7 +1899,9 @@
 	BIO_BUG_ON(!bio->bi_size);
 	BIO_BUG_ON(!bio->bi_io_vec);
 
-	bio->bi_rw = rw;
+	/*bio->bi_rw = rw; */
+	bio_set_rw(bio, rw);
+	bio_set_prio(bio, prio);
 
 	if (rw & WRITE)
 		kstat.pgpgout += count;
@@ -2016,7 +2053,7 @@
 int __init blk_dev_init(void)
 {
 	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
-	int i;
+	int i, j;
 
 	request_cachep = kmem_cache_create("blkdev_requests",
 			sizeof(struct request), 0,
@@ -2048,9 +2085,11 @@
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
 
-	for (i = 0; i < ARRAY_SIZE(congestion_states); i++) {
-		init_waitqueue_head(&congestion_states[i].wqh);
-		atomic_set(&congestion_states[i].nr_congested_queues, 0);
+	for (j = 0; j < QUEUE_NR_AGS; j++) {
+		for (i = 0; i < ARRAY_SIZE(congestion_states); i++) {
+			init_waitqueue_head(&congestion_states[j].states[i].wqh);
+			atomic_set(&congestion_states[j].states[i].nr_congested_queues, 0);
+		}
 	}
 	return 0;
 };
diff -Nru a/include/linux/backing-dev.h b/include/linux/backing-dev.h
--- a/include/linux/backing-dev.h	Sun Oct  6 14:55:47 2002
+++ b/include/linux/backing-dev.h	Sun Oct  6 14:55:47 2002
@@ -9,21 +9,26 @@
 #define _LINUX_BACKING_DEV_H
 
 #include <asm/atomic.h>
+#include <linux/blk_io_prio.h>
 
 /*
  * Bits in backing_dev_info.state
  */
 enum bdi_state {
 	BDI_pdflush,		/* A pdflush thread is working this device */
+	BDI_unused,		/* Available bits start here */
+};
+
+enum bdi_ag_state {
 	BDI_write_congested,	/* The write queue is getting full */
 	BDI_read_congested,	/* The read queue is getting full */
-	BDI_unused,		/* Available bits start here */
 };
 
 struct backing_dev_info {
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
 	unsigned long state;	/* Always use atomic bitops on this */
 	int memory_backed;	/* Cannot clean pages with writepage */
+	unsigned long agstate[QUEUE_NR_AGS];	/* State per allocation group */
 };
 
 extern struct backing_dev_info default_backing_dev_info;
@@ -32,14 +37,28 @@
 int writeback_in_progress(struct backing_dev_info *bdi);
 void writeback_release(struct backing_dev_info *bdi);
 
+static inline int bdi_read_congested_prio(struct backing_dev_info *bdi, int prio)
+{
+	int ag = prio_to_ag(prio);
+	return test_bit(BDI_read_congested, &bdi->agstate[ag]);
+}
+
 static inline int bdi_read_congested(struct backing_dev_info *bdi)
 {
-	return test_bit(BDI_read_congested, &bdi->state);
+	int prio = get_io_prio(current);
+	return bdi_read_congested_prio(bdi, prio);
+}
+
+static inline int bdi_write_congested_prio(struct backing_dev_info *bdi, int prio)
+{
+	int ag = prio_to_ag(prio);
+	return test_bit(BDI_write_congested, &bdi->agstate[ag]);
 }
 
 static inline int bdi_write_congested(struct backing_dev_info *bdi)
 {
-	return test_bit(BDI_write_congested, &bdi->state);
+	int prio = get_io_prio(current);
+	return bdi_write_congested_prio(bdi, prio);
 }
 
 #endif		/* _LINUX_BACKING_DEV_H */
diff -Nru a/include/linux/bio.h b/include/linux/bio.h
--- a/include/linux/bio.h	Sun Oct  6 14:55:47 2002
+++ b/include/linux/bio.h	Sun Oct  6 14:55:47 2002
@@ -110,10 +110,26 @@
  * bit 0 -- read (not set) or write (set)
  * bit 1 -- rw-ahead when set
  * bit 2 -- barrier
+ *
+ * bit 8  -- first prio bit
+ * bit 15 -- last prio bit
+ *
  */
 #define BIO_RW		0
 #define BIO_RW_AHEAD	1
 #define BIO_RW_BARRIER	2
+#define BIO_PRIO_IDLE  0
+#define BIO_PRIO_LOW   10
+#define BIO_PRIO_MED   20
+#define BIO_PRIO_HIGH  30
+
+#define BIO_PRIO_MIN   BIO_PRIO_IDLE
+#define BIO_PRIO_MAX   42
+
+
+#define BIO_PRIO_START 8
+#define BIO_PRIO_MASK  (255 << BIO_PRIO_START)
+
 
 /*
  * various member access, note that bio_data should of course not be used
@@ -126,6 +142,15 @@
 #define bio_sectors(bio)	((bio)->bi_size >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
 #define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_RW_BARRIER))
+
+#define bio_prio(bio)		(((bio)->bi_rw & BIO_PRIO_MASK)>>BIO_PRIO_START)
+#define bio_set_prio(bio, prio)	do { \
+					int __n = ((prio)<<BIO_PRIO_START); \
+					__n &= BIO_PRIO_MASK; \
+					(bio)->bi_rw &= ~BIO_PRIO_MASK; \
+					(bio)->bi_rw |= __n; \
+				} while (0) 
+
 
 /*
  * will die
diff -Nru a/include/linux/blk_io_prio.h b/include/linux/blk_io_prio.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/blk_io_prio.h	Sun Oct  6 14:55:47 2002
@@ -0,0 +1,51 @@
+/*
+ *   include/linux/blk_io_prio.
+ *
+ *   Copyright (C) 2002 Christoffer Hall-Frederiksen <hall@jiffies.dk>
+ */
+
+#ifndef __LINUX_BIO_IO_PRIO_H
+#define __LINUX_BIO_IO_PRIO_H
+
+#include <linux/sched.h>
+#include <linux/bio.h>
+
+/*
+ * Number of queues that requests can be allocated from (allocation groups)
+ */
+
+#define QUEUE_NR_AGS 	4
+
+#define PRIOS_PR_AG		(BIO_PRIO_MAX/QUEUE_NR_AGS)
+
+static inline int get_io_prio(struct task_struct *task)
+{
+	int prio;
+
+	BUG_ON(task == NULL);
+
+	/* prio = task->static_prio - MAX_RT_PRIO; */
+	prio = MAX_PRIO - task->static_prio - 1;
+
+	if (prio > BIO_PRIO_MAX)
+		prio = BIO_PRIO_MAX;
+
+	BUG_ON(prio < BIO_PRIO_MIN);
+
+	return prio;
+}
+
+static inline int prio_to_ag(int prio)
+{
+	int ag;
+
+	BUG_ON(prio < BIO_PRIO_MIN || prio > BIO_PRIO_MAX);
+	ag = prio / (PRIOS_PR_AG+1);
+
+	BUG_ON(ag >= QUEUE_NR_AGS);
+	BUG_ON(ag < 0);
+
+	return ag;
+}
+
+#endif /*  __LINUX_BIO_IO_PRIO_H*/
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Sun Oct  6 14:55:47 2002
+++ b/include/linux/blkdev.h	Sun Oct  6 14:55:47 2002
@@ -16,7 +16,7 @@
 typedef struct elevator_s elevator_t;
 
 struct request_list {
-	unsigned int count;
+	unsigned int count, ag;
 	struct list_head free;
 	wait_queue_head_t wait;
 };
@@ -139,6 +139,14 @@
 };
 
 /*
+ * Request allocation group
+ */
+struct request_ag {
+	struct request_list rq[2];	/* one list list for writes and one for read */
+	int outstanding[2]; 		/* # allocated requests read/write */
+};
+
+/*
  * Default nr free requests per queue, ll_rw_blk will scale it down
  * according to available RAM at init time
  */
@@ -156,7 +164,7 @@
 	/*
 	 * the queue request freelist, one for reads and one for writes
 	 */
-	struct request_list	rq[2];
+	struct request_ag	ags[QUEUE_NR_AGS];
 
 	request_fn_proc		*request_fn;
 	merge_request_fn	*back_merge_fn;
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sun Oct  6 14:55:47 2002
+++ b/include/linux/fs.h	Sun Oct  6 14:55:47 2002
@@ -1129,6 +1129,11 @@
  * return READ, READA, or WRITE
  */
 #define bio_rw(bio)		((bio)->bi_rw & (RW_MASK | RWA_MASK))
+#define bio_set_rw(bio,rw)	do {\
+				((bio)->bi_rw &= ~(RW_MASK|RWA_MASK)); \
+				((bio)->bi_rw |= (rw & (RW_MASK|RWA_MASK))); \
+			} while (0)
+
 
 /*
  * return data direction, READ or WRITE
@@ -1234,6 +1239,7 @@
 extern void file_move(struct file *f, struct list_head *list);
 struct bio;
 extern int submit_bio(int, struct bio *);
+extern int submit_bio_prio(int, int, struct bio *);
 extern int bdev_read_only(struct block_device *);
 extern int set_blocksize(struct block_device *, int);
 extern int sb_set_blocksize(struct super_block *, int);

--98e8jtXdkpgskNou--
