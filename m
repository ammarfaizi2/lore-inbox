Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317526AbSFEBRG>; Tue, 4 Jun 2002 21:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317527AbSFEBRF>; Tue, 4 Jun 2002 21:17:05 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:33668 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317526AbSFEBRA>; Tue, 4 Jun 2002 21:17:00 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>
Date: Wed, 5 Jun 2002 11:16:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15613.26250.675556.878683@notabene.cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
In-Reply-To: message from Jens Axboe on Tuesday June 4
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 4, axboe@suse.de wrote:
> On Tue, Jun 04 2002, Jens Axboe wrote:
> > On Tue, Jun 04 2002, Jens Axboe wrote:
> > > plug? Wrt umem, it seems you could keep 'card' in the queuedata. Same
> > > for raid5 and conf.
> > 
> > Ok by actually looking at it, both card and conf are the queues
> > themselves. So I'd say your approach is indeed a bit overkill. I'll send
> > a patch in half an hour for you to review.
> 
> Alright here's the block part of it, you'll need to merge your umem and
> raid5 changes in with that. I'm just interested in knowing if this is
> all you want/need. It's actually just a two line changes from the last
> version posted -- set q->unplug_fn in blk_init_queue to our default
> (you'll override that for umem and raid5, or rather you'll set it
> yourself after blk_queue_make_request()), and then call that instead of
> __generic_unplug_device directly from blk_run_queues().
> 
I can work with that...

Below is a patch that fixes a couple of problems with umem and add
support for md/raid5.  I haven't tested it yet, but it looks right. It
is on top of your patch.

It irks me, though, that I need to embed a whole request_queue_t when
I don't use the vast majority of it.

What I would like is to have a 

struct blk_dev {
       	make_request_fn		*make_request_fn;
	unplug_fn		*unplug_fn;
	struct list_head	plug_list;
	unsigned long		queue_flags;
	spinlock_t		*queue_lock;
}

which I can embed in mddev_s and umem card, and you can embed in
struct request_queue.

Then struct block_device have have
     struct blk_dev bd_bdev;
instead of 
     struct request_queue bd_queue;

and we could each find the containing structure from the "struct blk_dev"
using a list_entry type macro.

There would be a bit of an issue with this in that it would then not
make sense to have a full request_queue_t in struct block_device, and
users of BLK_DEFAULT_QUEUE would need to allocate their own
request_queue_t.... is that such a bad idea?

Anyway, I can live with the current situation if you don't like the
above.

NeilBrown

-------------------------------------------------------------
Extend plugging work for md/raid5 and fix umem

We embed a request_queue_t in the mddev structure and so
have a separate one for each mddev.
This is used for plugging (in raid5).

Given this embeded request_queue_t, md_make_request no-longer
needs to make from device number to mddev, but can map from
the queue to the mddev instead.

In umem, we move blk_plug_device and blk_remove_plug
inside the lock, and device a ->queue function to return
the right queue for each device.

In ll_rw_blk.c we change blk_plug_device to avoid the check for
the queue being empty as this may not be well define for
umem/raid5.  Instead, blk_plug_device is not called when
the queue is not empty (which is mostly wasn' anyway).

 ----------- Diffstat output ------------
 ./drivers/block/ll_rw_blk.c  |   10 +++-------
 ./drivers/block/umem.c       |   20 ++++++++++++++++----
 ./drivers/md/md.c            |   25 ++++++++++++++++++++++---
 ./drivers/md/raid5.c         |   21 +++++++--------------
 ./include/linux/raid/md_k.h  |    2 ++
 ./include/linux/raid/raid5.h |    5 +----
 6 files changed, 51 insertions(+), 32 deletions(-)

--- ./include/linux/raid/md_k.h	2002/06/05 00:15:12	1.1
+++ ./include/linux/raid/md_k.h	2002/06/05 00:53:06	1.2
@@ -214,6 +214,8 @@
 	atomic_t			recovery_active; /* blocks scheduled, but not written */
 	wait_queue_head_t		recovery_wait;
 
+	request_queue_t			queue;	/* for plugging ... */
+
 	struct list_head		all_mddevs;
 };
 
--- ./include/linux/raid/raid5.h	2002/06/05 00:15:55	1.1
+++ ./include/linux/raid/raid5.h	2002/06/05 00:53:06	1.2
@@ -176,7 +176,7 @@
  * is put on a "delayed" queue until there are no stripes currently
  * in a pre-read phase.  Further, if the "delayed" queue is empty when
  * a stripe is put on it then we "plug" the queue and do not process it
- * until an unplg call is made. (the tq_disk list is run).
+ * until an unplug call is made. (blk_run_queues is run).
  *
  * When preread is initiated on a stripe, we set PREREAD_ACTIVE and add
  * it to the count of prereading stripes.
@@ -228,9 +228,6 @@
 							 * waiting for 25% to be free
 							 */        
 	spinlock_t		device_lock;
-
-	int			plugged;
-	struct tq_struct	plug_tq;
 };
 
 typedef struct raid5_private_data raid5_conf_t;
--- ./drivers/block/ll_rw_blk.c	2002/06/05 00:13:22	1.2
+++ ./drivers/block/ll_rw_blk.c	2002/06/05 00:53:06	1.3
@@ -803,12 +803,6 @@
  */
 void blk_plug_device(request_queue_t *q)
 {
-	/*
-	 * common case
-	 */
-	if (!elv_queue_empty(q))
-		return;
-
 	if (!blk_queue_plugged(q)) {
 		spin_lock(&blk_plug_lock);
 		list_add_tail(&q->plug_list, &blk_plug_list);
@@ -1381,10 +1375,12 @@
 	req = NULL;
 	insert_here = q->queue_head.prev;
 
-	if (blk_queue_empty(q) || bio_barrier(bio)) {
+	if (blk_queue_empty(q)) {
 		blk_plug_device(q);
 		goto get_rq;
 	}
+	if (bio_barrier(bio))
+		goto get_rq;
 
 	el_ret = elv_merge(q, &req, bio);
 	switch (el_ret) {
--- ./drivers/block/umem.c	2002/06/05 00:13:22	1.2
+++ ./drivers/block/umem.c	2002/06/05 00:53:06	1.3
@@ -292,7 +292,7 @@
  * Whenever IO on the active page completes, the Ready page is activated
  * and the ex-Active page is clean out and made Ready.
  * Otherwise the Ready page is only activated when it becomes full, or
- * when mm_unplug_device is called via run_task_queue(&tq_disk).
+ * when mm_unplug_device is called via blk_run_queues().
  *
  * If a request arrives while both pages a full, it is queued, and b_rdev is
  * overloaded to record whether it was a read or a write.
@@ -386,10 +386,10 @@
 	request_queue_t *q = data;
 	struct cardinfo *card = q->queuedata;
 
-	blk_remove_plug(q);
 
 	spin_lock_bh(&card->lock);
-	activate(card);
+	if (blk_remove_plug(q))
+		activate(card);
 	spin_unlock_bh(&card->lock);
 }
 
@@ -578,9 +578,9 @@
 	*card->biotail = bio;
 	bio->bi_next = NULL;
 	card->biotail = &bio->bi_next;
+	blk_plug_device(q);
 	spin_unlock_bh(&card->lock);
 
-	blk_plug_device(q);
 	return 0;
 }
 
@@ -1240,6 +1240,17 @@
 --                               mm_init
 -----------------------------------------------------------------------------------
 */
+
+static request_queue_t * mm_queue_proc(kdev_t dev)
+{
+	int c = DEVICE_NR(bio->bi_bdev->bd_dev);
+
+	if (c < MM_MAXCARDS)
+		return &cards[c].queue;
+	else
+		return BLK_DEFAULT_QUEUE(MAJOR_NR);
+}
+	
 int __init mm_init(void)
 {
 	int retval, i;
@@ -1279,6 +1290,7 @@
 	mm_gendisk.part      = mm_partitions;
 	mm_gendisk.nr_real   = num_cards;
 
+	blk_dev[MAJOR_NR].queue = mm_queue_proc;
 	add_gendisk(&mm_gendisk);
 
         blk_size[MAJOR_NR]      = mm_gendisk.sizes;
--- ./drivers/md/raid5.c	2002/06/05 00:24:34	1.1
+++ ./drivers/md/raid5.c	2002/06/05 00:53:06	1.2
@@ -1225,14 +1225,14 @@
 }
 static void raid5_unplug_device(void *data)
 {
-	raid5_conf_t *conf = (raid5_conf_t *)data;
+	request_queue_t *q = data;
+	raid5_conf_t *conf = q->queuedata;
 	unsigned long flags;
 
 	spin_lock_irqsave(&conf->device_lock, flags);
 
-	raid5_activate_delayed(conf);
-	
-	conf->plugged = 0;
+	if (blk_remove_plug(q))
+		raid5_activate_delayed(conf);
 	md_wakeup_thread(conf->thread);
 
 	spin_unlock_irqrestore(&conf->device_lock, flags);
@@ -1241,11 +1241,7 @@
 static inline void raid5_plug_device(raid5_conf_t *conf)
 {
 	spin_lock_irq(&conf->device_lock);
-	if (list_empty(&conf->delayed_list))
-		if (!conf->plugged) {
-			conf->plugged = 1;
-			queue_task(&conf->plug_tq, &tq_disk);
-		}
+	blk_plug_device(&conf->mddev->rq);
 	spin_unlock_irq(&conf->device_lock);
 }
 
@@ -1352,7 +1348,7 @@
 
 		if (list_empty(&conf->handle_list) &&
 		    atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD &&
-		    !conf->plugged &&
+		    !blk_queue_plugged(&mddev->queue) &&
 		    !list_empty(&conf->delayed_list))
 			raid5_activate_delayed(conf);
 
@@ -1443,10 +1439,7 @@
 	atomic_set(&conf->active_stripes, 0);
 	atomic_set(&conf->preread_active_stripes, 0);
 
-	conf->plugged = 0;
-	conf->plug_tq.sync = 0;
-	conf->plug_tq.routine = &raid5_unplug_device;
-	conf->plug_tq.data = conf;
+	mddev->queue.unplug_fn = raid5_unplug_device;
 
 	PRINTK("raid5: run(md%d) called.\n", mdidx(mddev));
 
--- ./drivers/md/md.c	2002/06/05 00:30:58	1.1
+++ ./drivers/md/md.c	2002/06/05 00:53:06	1.2
@@ -171,7 +171,7 @@
 
 static int md_make_request (request_queue_t *q, struct bio *bio)
 {
-	mddev_t *mddev = kdev_to_mddev(to_kdev_t(bio->bi_bdev->bd_dev));
+	mddev_t *mddev = q->queuedata;
 
 	if (mddev && mddev->pers)
 		return mddev->pers->make_request(mddev, bio_rw(bio), bio);
@@ -181,6 +181,12 @@
 	}
 }
 
+static int md_fail_request (request_queue_t *q, struct bio *bio)
+{
+	bio_io_error(bio);
+	return 0;
+}
+
 static mddev_t * alloc_mddev(kdev_t dev)
 {
 	mddev_t *mddev;
@@ -1710,6 +1716,9 @@
 	}
 	mddev->pers = pers[pnum];
 
+	blk_queue_make_request(&mddev->queue, md_make_request);
+	mddev->queue.queuedata = mddev;
+
 	err = mddev->pers->run(mddev);
 	if (err) {
 		printk(KERN_ERR "md: pers->run() failed ...\n");
@@ -3615,6 +3624,15 @@
 #endif
 }
 
+request_queue_t * md_queue_proc(kdev_t dev)
+{
+	mddev_t *mddev = kdev_to_mddev(dev);
+	if (mddev == NULL)
+		return BLK_DEFAULT_QUEUE(MAJOR_NR);
+	else
+		return &mddev->queue;
+}
+
 int __init md_init(void)
 {
 	static char * name = "mdrecoveryd";
@@ -3639,8 +3657,9 @@
 			S_IFBLK | S_IRUSR | S_IWUSR, &md_fops, NULL);
 	}
 
-	/* forward all md request to md_make_request */
-	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), md_make_request);
+	/* all requests on an uninitialised device get failed... */
+	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), md_fail_request);
+	blk_dev[MAJOR_NR].queue = md_queue_proc;
 
 	add_gendisk(&md_gendisk);
 
