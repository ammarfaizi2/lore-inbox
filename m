Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTEWOXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 10:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbTEWOXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 10:23:13 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:45828 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263186AbTEWOXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 10:23:06 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Date: Fri, 23 May 2003 16:35:02 +0200
User-Agent: KMail/1.5.1
References: <200305231405.54599.christian.klose@freenet.de> <200305231546.27463.christian.klose@freenet.de>
In-Reply-To: <200305231546.27463.christian.klose@freenet.de>
Cc: Christian Klose <christian.klose@freenet.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WGjz+AnwEQ/FJ2z"
Message-Id: <200305231635.02497.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WGjz+AnwEQ/FJ2z
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 23 May 2003 15:46, Christian Klose wrote:

Moin Christian,

> > I have a problem since Linux Kernel 2.4.19. Copying huge amount of data
> > gives me pauses where pauses are disk io pauses, keyboard does not accept
> > input and mouse won't move. This depends, sometimes those pauses are 1 to
> > 2 seconds, sometimes even more up to 15 seconds where I can not do
> > anything with my linux but waiting :-(
> I forgot to mention that this is filesystem independant. ext2, ext3,
> reiserfs; always same problem.
it _seems_ the offending diff is the attached one. Went in into .19-pre5.

More to come.

ciao, Marc
--Boundary-00=_WGjz+AnwEQ/FJ2z
Content-Type: text/x-csrc;
  charset="iso-8859-15";
  name="pre4-to-pre5-ll_rw_blk.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pre4-to-pre5-ll_rw_blk.c"

diff -urN linux-2.4.19-pre4/drivers/block/ll_rw_blk.c linux-2.4.19-pre5/drivers/block/ll_rw_blk.c
--- linux-2.4.19-pre4/drivers/block/ll_rw_blk.c	Fri Mar 29 14:49:08 2002
+++ linux-2.4.19-pre5/drivers/block/ll_rw_blk.c	Fri Mar 29 14:49:29 2002
@@ -117,16 +117,6 @@
  */
 int * max_sectors[MAX_BLKDEV];
 
-/*
- * The total number of requests in each queue.
- */
-static int queue_nr_requests;
-
-/*
- * The threshold around which we make wakeup decisions
- */
-static int batch_requests;
-
 static inline int get_max_sectors(kdev_t dev)
 {
 	if (!max_sectors[MAJOR(dev)])
@@ -180,7 +170,7 @@
  **/
 void blk_cleanup_queue(request_queue_t * q)
 {
-	int count = queue_nr_requests;
+	int count = q->nr_requests;
 
 	count -= __blk_cleanup_queue(&q->rq[READ]);
 	count -= __blk_cleanup_queue(&q->rq[WRITE]);
@@ -330,31 +320,64 @@
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
+/** blk_grow_request_list
+ *  @q: The &request_queue_t
+ *  @nr_requests: how many requests are desired
+ *
+ * More free requests are added to the queue's free lists, bringing
+ * the total number of requests to @nr_requests.
+ *
+ * The requests are added equally to the request queue's read
+ * and write freelists.
+ *
+ * This function can sleep.
+ *
+ * Returns the (new) number of requests which the queue has available.
+ */
+int blk_grow_request_list(request_queue_t *q, int nr_requests)
+{
+	spin_lock_irq(&io_request_lock);
+	while (q->nr_requests < nr_requests) {
+		struct request *rq;
+		int rw;
+
+		spin_unlock_irq(&io_request_lock);
+		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
+		spin_lock_irq(&io_request_lock);
+		if (rq == NULL)
+			break;
+		memset(rq, 0, sizeof(*rq));
+		rq->rq_status = RQ_INACTIVE;
+		rw = q->nr_requests & 1;
+		list_add(&rq->queue, &q->rq[rw].free);
+		q->rq[rw].count++;
+		q->nr_requests++;
+	}
+	q->batch_requests = q->nr_requests / 4;
+	if (q->batch_requests > 32)
+		q->batch_requests = 32;
+	spin_unlock_irq(&io_request_lock);
+	return q->nr_requests;
+}
+
 static void blk_init_free_list(request_queue_t *q)
 {
-	struct request *rq;
-	int i;
+	struct sysinfo si;
+	int megs;		/* Total memory, in megabytes */
+	int nr_requests;
 
 	INIT_LIST_HEAD(&q->rq[READ].free);
 	INIT_LIST_HEAD(&q->rq[WRITE].free);
 	q->rq[READ].count = 0;
 	q->rq[WRITE].count = 0;
+	q->nr_requests = 0;
 
-	/*
-	 * Divide requests in half between read and write
-	 */
-	for (i = 0; i < queue_nr_requests; i++) {
-		rq = kmem_cache_alloc(request_cachep, SLAB_KERNEL);
-		if (rq == NULL) {
-			/* We'll get a `leaked requests' message from blk_cleanup_queue */
-			printk(KERN_EMERG "blk_init_free_list: error allocating requests\n");
-			break;
-		}
-		memset(rq, 0, sizeof(struct request));
-		rq->rq_status = RQ_INACTIVE;
-		list_add(&rq->queue, &q->rq[i&1].free);
-		q->rq[i&1].count++;
-	}
+	si_meminfo(&si);
+	megs = si.totalram >> (20 - PAGE_SHIFT);
+	nr_requests = 128;
+	if (megs < 32)
+		nr_requests /= 2;
+	blk_grow_request_list(q, nr_requests);
 
 	init_waitqueue_head(&q->wait_for_requests[0]);
 	init_waitqueue_head(&q->wait_for_requests[1]);
@@ -610,7 +633,7 @@
 	 */
 	if (q) {
 		list_add(&req->queue, &q->rq[rw].free);
-		if (++q->rq[rw].count >= batch_requests &&
+		if (++q->rq[rw].count >= q->batch_requests &&
 				waitqueue_active(&q->wait_for_requests[rw]))
 			wake_up(&q->wait_for_requests[rw]);
 	}
@@ -802,7 +825,7 @@
 		 * See description above __get_request_wait()
 		 */
 		if (rw_ahead) {
-			if (q->rq[rw].count < batch_requests) {
+			if (q->rq[rw].count < q->batch_requests) {
 				spin_unlock_irq(&io_request_lock);
 				goto end_io;
 			}
@@ -958,6 +981,7 @@
 		BUG();
 
 	set_bit(BH_Req, &bh->b_state);
+	set_bit(BH_Launder, &bh->b_state);
 
 	/*
 	 * First step, 'identity mapping' - RAID or LVM might
@@ -1149,12 +1173,9 @@
 	blkdev_release_request(req);
 }
 
-#define MB(kb)	((kb) << 10)
-
 int __init blk_dev_init(void)
 {
 	struct blk_dev_struct *dev;
-	int total_ram;
 
 	request_cachep = kmem_cache_create("blkdev_requests",
 					   sizeof(struct request),
@@ -1170,22 +1191,6 @@
 	memset(max_readahead, 0, sizeof(max_readahead));
 	memset(max_sectors, 0, sizeof(max_sectors));
 
-	total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
-
-	/*
-	 * Free request slots per queue.
-	 * (Half for reads, half for writes)
-	 */
-	queue_nr_requests = 64;
-	if (total_ram > MB(32))
-		queue_nr_requests = 128;
-
-	/*
-	 * Batch frees according to queue length
-	 */
-	batch_requests = queue_nr_requests/4;
-	printk("block: %d slots per queue, batch=%d\n", queue_nr_requests, batch_requests);
-
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
 #endif
@@ -1296,6 +1301,7 @@
 EXPORT_SYMBOL(io_request_lock);
 EXPORT_SYMBOL(end_that_request_first);
 EXPORT_SYMBOL(end_that_request_last);
+EXPORT_SYMBOL(blk_grow_request_list);
 EXPORT_SYMBOL(blk_init_queue);
 EXPORT_SYMBOL(blk_get_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);

--Boundary-00=_WGjz+AnwEQ/FJ2z--

