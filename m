Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbSKSGYu>; Tue, 19 Nov 2002 01:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSKSGYu>; Tue, 19 Nov 2002 01:24:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:3812 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267115AbSKSGYl>;
	Tue, 19 Nov 2002 01:24:41 -0500
Message-ID: <3DD9DAC8.CF83AECE@digeo.com>
Date: Mon, 18 Nov 2002 22:31:36 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: scsi in 2.5.48
References: <3DD8AF65.BF2EF851@digeo.com> <3DD8B6B9.E9EAD230@digeo.com> <20021118135614.GA834@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Nov 2002 06:31:36.0842 (UTC) FILETIME=[4F9D8EA0:01C28F95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Mon, Nov 18 2002, Andrew Morton wrote:
> > Andrew Morton wrote:
> > >
> > > Appears to be DOA.  Just a simple mke2fs hangs in get_request_wait().
> >
> > This makes it work again.
> >
> >
> > --- 25/drivers/scsi/scsi_lib.c~scsi-plug      Mon Nov 18 01:42:40 2002
> > +++ 25-akpm/drivers/scsi/scsi_lib.c   Mon Nov 18 01:42:44 2002
> > @@ -1024,7 +1024,6 @@ void scsi_request_fn(request_queue_t * q
> >                       /* can happen if the prep fails
> >                        * FIXME: elv_next_request() should be plugging the
> >                        * queue */
> > -                     blk_plug_device(q);
> >                       break;
> >               }
> 
> Right fix would be something ala:
> 
> ===== drivers/block/ll_rw_blk.c 1.143 vs edited =====
> --- 1.143/drivers/block/ll_rw_blk.c     Mon Nov 18 08:28:08 2002
> +++ edited/drivers/block/ll_rw_blk.c    Mon Nov 18 14:45:55 2002
> @@ -1038,6 +1038,16 @@
>  }
> 
>  /**
> + * blk_run_queue - run a single device queue
> + * @q  The queue to run
> + */

That fixes it for me, thanks.

Now, I had me a little bug in blk_congestion_wait() - it was forgetting
to wait.  The net effect of this bug was to increase plug/unplug traffic
by a factor of about 200.  And the 4-way was oopsing about once per
gigabyte of IO, in blk_run_queues().  Always due to a garbage q->unplug_fn.

That local list needs spinlock protection, because blk_remove_plug()
will actually take queues off that local list while another CPU (or
this one) is walking it.

Maybe that's a logic error, but I feel a ton safer with this patch in
place, and it stopped the oopses.

It also adds a few debug checks and uninlines stuff ;)



 drivers/block/ll_rw_blk.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

--- 25/drivers/block/ll_rw_blk.c~plugbug	Mon Nov 18 21:29:23 2002
+++ 25-akpm/drivers/block/ll_rw_blk.c	Mon Nov 18 21:35:11 2002
@@ -737,7 +737,7 @@ new_segment:
 }
 
 
-inline int blk_phys_contig_segment(request_queue_t *q, struct bio *bio,
+int blk_phys_contig_segment(request_queue_t *q, struct bio *bio,
 				   struct bio *nxt)
 {
 	if (!(q->queue_flags & (1 << QUEUE_FLAG_CLUSTER)))
@@ -758,7 +758,7 @@ inline int blk_phys_contig_segment(reque
 	return 0;
 }
 
-inline int blk_hw_contig_segment(request_queue_t *q, struct bio *bio,
+int blk_hw_contig_segment(request_queue_t *q, struct bio *bio,
 				 struct bio *nxt)
 {
 	if (!(q->queue_flags & (1 << QUEUE_FLAG_CLUSTER)))
@@ -956,6 +956,7 @@ static int ll_merge_requests_fn(request_
  */
 void blk_plug_device(request_queue_t *q)
 {
+	WARN_ON(!irqs_disabled());
 	if (!blk_queue_plugged(q)) {
 		spin_lock(&blk_plug_lock);
 		list_add_tail(&q->plug_list, &blk_plug_list);
@@ -967,8 +968,9 @@ void blk_plug_device(request_queue_t *q)
  * remove the queue from the plugged list, if present. called with
  * queue lock held and interrupts disabled.
  */
-inline int blk_remove_plug(request_queue_t *q)
+int blk_remove_plug(request_queue_t *q)
 {
+	WARN_ON(!irqs_disabled());
 	if (blk_queue_plugged(q)) {
 		spin_lock(&blk_plug_lock);
 		list_del_init(&q->plug_list);
@@ -1096,28 +1098,27 @@ void __blk_run_queue(request_queue_t *q)
 #define blk_plug_entry(entry) list_entry((entry), request_queue_t, plug_list)
 void blk_run_queues(void)
 {
-	struct list_head local_plug_list;
-
-	INIT_LIST_HEAD(&local_plug_list);
+	LIST_HEAD(local_plug_list);
 
 	spin_lock_irq(&blk_plug_lock);
 
 	/*
 	 * this will happen fairly often
 	 */
-	if (list_empty(&blk_plug_list)) {
-		spin_unlock_irq(&blk_plug_lock);
-		return;
-	}
+	if (list_empty(&blk_plug_list))
+		goto out;
 
 	list_splice_init(&blk_plug_list, &local_plug_list);
-	spin_unlock_irq(&blk_plug_lock);
 	
 	while (!list_empty(&local_plug_list)) {
 		request_queue_t *q = blk_plug_entry(local_plug_list.next);
 
+		spin_unlock_irq(&blk_plug_lock);
 		q->unplug_fn(q);
+		spin_lock_irq(&blk_plug_lock);
 	}
+out:
+	spin_unlock_irq(&blk_plug_lock);
 }
 
 static int __blk_cleanup_queue(struct request_list *list)
@@ -1959,7 +1960,7 @@ int submit_bio(int rw, struct bio *bio)
 	return 1;
 }
 
-inline void blk_recalc_rq_segments(struct request *rq)
+void blk_recalc_rq_segments(struct request *rq)
 {
 	struct bio *bio;
 	int nr_phys_segs, nr_hw_segs;
@@ -1982,7 +1983,7 @@ inline void blk_recalc_rq_segments(struc
 	rq->nr_hw_segments = nr_hw_segs;
 }
 
-inline void blk_recalc_rq_sectors(struct request *rq, int nsect)
+void blk_recalc_rq_sectors(struct request *rq, int nsect)
 {
 	if (blk_fs_request(rq)) {
 		rq->hard_sector += nsect;

_
