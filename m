Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUHSAAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUHSAAE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUHSAAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:00:03 -0400
Received: from av1-2-sn1.fre.skanova.net ([81.228.11.108]:63672 "EHLO
	av1-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S267670AbUHRX5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:57:13 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	<20040816224749.A15510@infradead.org>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Aug 2004 01:57:09 +0200
In-Reply-To: <20040816224749.A15510@infradead.org>
Message-ID: <m3r7q4huei.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
> > - The packet-writing patches should be ready to go, but I haven't even
> >   looked at them yet, and am not sure that anyone else has reviewed the code.
> 
> It's still messing with the elevator setting directly which is a no-go.
> That's not the packet-writing drivers fault but needs solving first.

That can actually be avoided by letting the packet driver itself keep
track of how many unfinished bios there are in the CD request queue.
This is straightforward to implement.  The only small complication is
that incoming read requests need to be cloned so that the packet
driver can use a private bi_end_io function.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |  100 +++++++++++++++++++----------------
 linux-petero/include/linux/pktcdvd.h |    9 ++-
 2 files changed, 65 insertions(+), 44 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-stacked-bio drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-stacked-bio	2004-08-19 01:41:09.487329088 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-08-19 01:41:09.493328176 +0200
@@ -71,34 +71,17 @@ static struct pktcdvd_device *pkt_devs[M
 static struct proc_dir_entry *pkt_proc;
 static int pkt_major;
 static struct semaphore ctl_mutex;	/* Serialize open/close/setup/teardown */
+static mempool_t *psd_pool;
 
 
-static struct pktcdvd_device *pkt_find_dev(request_queue_t *q)
+static void pkt_bio_finished(struct pktcdvd_device *pd)
 {
-	int i;
-
-	for (i = 0; i < MAX_WRITERS; i++) {
-		struct pktcdvd_device *pd = pkt_devs[i];
-		if (pd && bdev_get_queue(pd->bdev) == q)
-			return pd;
-	}
-
-	return NULL;
-}
-
-static void pkt_lowlevel_elv_completed_req_fn(request_queue_t *q, struct request *req)
-{
-	struct pktcdvd_device *pd = pkt_find_dev(q);
-	BUG_ON(!pd);
-
-	if (elv_queue_empty(q)) {
+	BUG_ON(atomic_read(&pd->cdrw.pending_bios) <= 0);
+	if (atomic_dec_and_test(&pd->cdrw.pending_bios)) {
 		VPRINTK("pktcdvd: queue empty\n");
 		atomic_set(&pd->iosched.attention, 1);
 		wake_up(&pd->wqueue);
 	}
-
-	if (pd->cdrw.elv_completed_req_fn)
-		pd->cdrw.elv_completed_req_fn(q, req);
 }
 
 static void pkt_bio_init(struct bio *bio)
@@ -561,7 +544,7 @@ static void pkt_iosched_process_queue(st
 
 		if (pd->iosched.writing) {
 			if (high_prio_read || (!writes_queued && reads_queued)) {
-				if (!elv_queue_empty(q)) {
+				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
 					VPRINTK("pktcdvd: write, waiting\n");
 					break;
 				}
@@ -570,7 +553,7 @@ static void pkt_iosched_process_queue(st
 			}
 		} else {
 			if (!reads_queued && writes_queued) {
-				if (!elv_queue_empty(q)) {
+				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
 					VPRINTK("pktcdvd: read, waiting\n");
 					break;
 				}
@@ -607,6 +590,7 @@ static void pkt_iosched_process_queue(st
 			}
 		}
 
+		atomic_inc(&pd->cdrw.pending_bios);
 		generic_make_request(bio);
 	}
 }
@@ -714,6 +698,7 @@ static int pkt_end_io_read(struct bio *b
 		atomic_inc(&pkt->run_sm);
 		wake_up(&pd->wqueue);
 	}
+	pkt_bio_finished(pd);
 
 	return 0;
 }
@@ -731,6 +716,7 @@ static int pkt_end_io_packet_write(struc
 
 	pd->stats.pkt_ended++;
 
+	pkt_bio_finished(pd);
 	atomic_dec(&pkt->io_wait);
 	atomic_inc(&pkt->run_sm);
 	wake_up(&pd->wqueue);
@@ -1996,14 +1982,10 @@ static int pkt_open_dev(struct pktcdvd_d
 			goto out_putdev;
 		}
 	}
-	spin_lock_irq(q->queue_lock);
-	pd->cdrw.elv_completed_req_fn = q->elevator.elevator_completed_req_fn;
-	q->elevator.elevator_completed_req_fn = pkt_lowlevel_elv_completed_req_fn;
-	spin_unlock_irq(q->queue_lock);
 
 	if (write) {
 		if ((ret = pkt_open_write(pd)))
-			goto restore_queue;
+			goto out_putdev;
 		/*
 		 * Some CDRW drives can not handle writes larger than one packet,
 		 * even if the size is a multiple of the packet size.
@@ -2018,17 +2000,13 @@ static int pkt_open_dev(struct pktcdvd_d
 	}
 
 	if ((ret = pkt_set_segment_merging(pd, q)))
-		goto restore_queue;
+		goto out_putdev;
 
 	if (write)
 		printk("pktcdvd: %lukB available on disc\n", lba << 1);
 
 	return 0;
 
-restore_queue:
-	spin_lock_irq(q->queue_lock);
-	q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
-	spin_unlock_irq(q->queue_lock);
 out_putdev:
 	blkdev_put(pd->bdev);
 out:
@@ -2041,18 +2019,12 @@ out:
  */
 static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 {
-	request_queue_t *q;
-
 	if (flush && pkt_flush_cache(pd))
 		DPRINTK("pktcdvd: %s not flushing cache\n", pd->name);
 
 	pkt_lock_door(pd, 0);
 
-	q = bdev_get_queue(pd->bdev);
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-	spin_lock_irq(q->queue_lock);
-	q->elevator.elevator_completed_req_fn = pd->cdrw.elv_completed_req_fn;
-	spin_unlock_irq(q->queue_lock);
 	blkdev_put(pd->bdev);
 }
 
@@ -2118,6 +2090,32 @@ static int pkt_close(struct inode *inode
 	return ret;
 }
 
+
+static void *psd_pool_alloc(int gfp_mask, void *data)
+{
+	return kmalloc(sizeof(struct packet_stacked_data), gfp_mask);
+}
+
+static void psd_pool_free(void *ptr, void *data)
+{
+	kfree(ptr);
+}
+
+static int pkt_end_io_read_cloned(struct bio *bio, unsigned int bytes_done, int err)
+{
+	struct packet_stacked_data *psd = bio->bi_private;
+	struct pktcdvd_device *pd = psd->pd;
+
+	if (bio->bi_size)
+		return 1;
+
+	bio_put(bio);
+	bio_endio(psd->bio, psd->bio->bi_size, err);
+	mempool_free(psd, psd_pool);
+	pkt_bio_finished(pd);
+	return 0;
+}
+
 static int pkt_make_request(request_queue_t *q, struct bio *bio)
 {
 	struct pktcdvd_device *pd;
@@ -2134,12 +2132,19 @@ static int pkt_make_request(request_queu
 	}
 
 	/*
-	 * quick remap a READ
+	 * Clone READ bios so we can have our own bi_end_io callback.
 	 */
 	if (bio_data_dir(bio) == READ) {
-		bio->bi_bdev = pd->bdev;
+		struct bio *cloned_bio = bio_clone(bio, GFP_NOIO);
+		struct packet_stacked_data *psd = mempool_alloc(psd_pool, GFP_NOIO);
+
+		psd->pd = pd;
+		psd->bio = bio;
+		cloned_bio->bi_bdev = pd->bdev;
+		cloned_bio->bi_private = psd;
+		cloned_bio->bi_end_io = pkt_end_io_read_cloned;
 		pd->stats.secs_r += bio->bi_size >> 9;
-		pkt_queue_bio(pd, bio, 1);
+		pkt_queue_bio(pd, cloned_bio, 1);
 		return 0;
 	}
 
@@ -2323,6 +2328,7 @@ static int pkt_seq_show(struct seq_file 
 
 	seq_printf(m, "\nQueue state:\n");
 	seq_printf(m, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
+	seq_printf(m, "\tbios pending:\t\t%d\n", atomic_read(&pd->cdrw.pending_bios));
 	seq_printf(m, "\tcurrent sector:\t\t0x%llx\n", (unsigned long long)pd->current_sector);
 
 	pkt_count_states(pd, states);
@@ -2391,6 +2397,7 @@ static int pkt_new_dev(struct pktcdvd_de
 
 	pkt_init_queue(pd);
 
+	atomic_set(&pd->cdrw.pending_bios, 0);
 	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
 	if (IS_ERR(pd->cdrw.thread)) {
 		printk("pktcdvd: can't start kernel thread\n");
@@ -2658,10 +2665,14 @@ int pkt_init(void)
 {
 	int ret;
 
+	psd_pool = mempool_create(PSD_POOL_SIZE, psd_pool_alloc, psd_pool_free, NULL);
+	if (!psd_pool)
+		return -ENOMEM;
+
 	ret = register_blkdev(pkt_major, "pktcdvd");
 	if (ret < 0) {
 		printk("pktcdvd: Unable to register block device\n");
-		return ret;
+		goto out2;
 	}
 	if (!pkt_major)
 		pkt_major = ret;
@@ -2681,6 +2692,8 @@ int pkt_init(void)
 
 out:
 	unregister_blkdev(pkt_major, "pktcdvd");
+out2:
+	mempool_destroy(psd_pool);
 	return ret;
 }
 
@@ -2689,6 +2702,7 @@ void pkt_exit(void)
 	remove_proc_entry("pktcdvd", proc_root_driver);
 	misc_deregister(&pkt_misc);
 	unregister_blkdev(pkt_major, "pktcdvd");
+	mempool_destroy(psd_pool);
 }
 
 MODULE_DESCRIPTION("Packet writing layer for CD/DVD drives");
diff -puN include/linux/pktcdvd.h~packet-stacked-bio include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-stacked-bio	2004-08-19 01:41:09.488328936 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-08-19 01:41:09.493328176 +0200
@@ -141,7 +141,7 @@ struct packet_cdrw
 	struct list_head	pkt_active_list;
 	spinlock_t		active_list_lock; /* Serialize access to pkt_active_list */
 	struct task_struct	*thread;
-	elevator_completed_req_fn *elv_completed_req_fn;
+	atomic_t		pending_bios;
 };
 
 /*
@@ -231,6 +231,13 @@ struct pkt_rb_node {
 	struct bio		*bio;
 };
 
+struct packet_stacked_data
+{
+	struct bio		*bio;		/* Original read request bio */
+	struct pktcdvd_device	*pd;
+};
+#define PSD_POOL_SIZE		64
+
 struct pktcdvd_device
 {
 	struct block_device	*bdev;		/* dev attached */
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
