Return-Path: <linux-kernel-owner+w=401wt.eu-S1751771AbXAUXXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbXAUXXF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXAUXXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:23:04 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:47306 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751766AbXAUXW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:22:58 -0500
X-Greylist: delayed 998 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 18:22:57 EST
Message-ID: <45B3F578.7090109@panasas.com>
Date: Mon, 22 Jan 2007 01:21:28 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       open-iscsi@googlegroups.com, Daniel.E.Messinger@seagate.com,
       Liran Schour <LIRANS@il.ibm.com>, Benny Halevy <bhalevy@panasas.com>
Subject: [RFC 1/6] bidi support: request dma_data_direction
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2007 23:21:07.0096 (UTC) FILETIME=[D3D7D980:01C73DB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Introduce a new enum dma_data_direction data_dir member in struct request.
  and remove the RW bit from request->cmd_flag
- Add new API to query request direction.
- Adjust existing API and implementation.
- Cleanup wrong use of DMA_BIDIRECTIONAL
- Introduce new blk_rq_init_unqueued_req() and use it in places ad-hoc
  requests were used and bzero'ed.

Signed-off-by: Benny Halevy <bhalevy@panasas.com>
Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>

---
 arch/um/drivers/ubd_kern.c      |    4 +-
 block/as-iosched.c              |    2 +-
 block/cfq-iosched.c             |   10 ++--
 block/deadline-iosched.c        |    8 ++--
 block/elevator.c                |    9 ++--
 block/ll_rw_blk.c               |  113 ++++++++++++++++++++++++---------------
 block/scsi_ioctl.c              |    8 +--
 drivers/block/DAC960.c          |    2 +-
 drivers/block/amiflop.c         |    4 +-
 drivers/block/ataflop.c         |    2 +-
 drivers/block/cciss.c           |    6 +-
 drivers/block/cpqarray.c        |    6 +-
 drivers/block/floppy.c          |    9 +--
 drivers/block/nbd.c             |    3 +-
 drivers/block/paride/pcd.c      |    2 +-
 drivers/block/paride/pd.c       |   29 +++++------
 drivers/block/paride/pf.c       |    9 +---
 drivers/block/pktcdvd.c         |    2 +-
 drivers/block/ps2esdi.c         |    9 ++--
 drivers/block/swim3.c           |   24 ++++----
 drivers/block/sx8.c             |    6 +-
 drivers/block/ub.c              |    8 +--
 drivers/block/viodasd.c         |    2 +-
 drivers/block/xd.c              |    4 +-
 drivers/block/z2ram.c           |    2 +-
 drivers/cdrom/cdrom.c           |    2 +-
 drivers/cdrom/cdu31a.c          |    2 +-
 drivers/cdrom/gscd.c            |    2 +-
 drivers/cdrom/sbpcd.c           |    2 +-
 drivers/cdrom/sonycd535.c       |    2 +-
 drivers/cdrom/viocd.c           |    2 +-
 drivers/ide/arm/icside.c        |    7 +--
 drivers/ide/cris/ide-cris.c     |    4 +-
 drivers/ide/ide-cd.c            |   10 ++--
 drivers/ide/ide-disk.c          |   10 ++--
 drivers/ide/ide-dma.c           |    4 +-
 drivers/ide/ide-floppy.c        |    4 +-
 drivers/ide/ide-io.c            |    4 +-
 drivers/ide/ide-tape.c          |    2 +-
 drivers/ide/ide-taskfile.c      |    6 +-
 drivers/ide/ide.c               |    4 +-
 drivers/ide/legacy/hd.c         |    6 +-
 drivers/ide/mips/au1xxx-ide.c   |    7 +--
 drivers/ide/pci/alim15x3.c      |    2 +-
 drivers/ide/pci/hpt366.c        |    2 +-
 drivers/ide/pci/pdc202xx_old.c  |    2 +-
 drivers/ide/pci/sgiioc4.c       |    4 +-
 drivers/ide/pci/trm290.c        |    2 +-
 drivers/ide/ppc/pmac.c          |    4 +-
 drivers/md/dm-emc.c             |    2 +-
 drivers/message/i2o/i2o_block.c |    8 ++--
 drivers/mmc/mmc_block.c         |   12 ++--
 drivers/mtd/mtd_blkdevs.c       |    8 ++--
 drivers/s390/block/dasd.c       |    2 +-
 drivers/s390/block/dasd_diag.c  |    4 +-
 drivers/s390/block/dasd_eckd.c  |   10 ++--
 drivers/s390/block/dasd_fba.c   |   14 +++---
 drivers/s390/char/tape_block.c  |    2 +-
 drivers/sbus/char/jsflash.c     |    2 +-
 drivers/scsi/aic7xxx_old.c      |    4 +-
 drivers/scsi/scsi_error.c       |    3 +-
 drivers/scsi/scsi_lib.c         |   18 +++----
 drivers/scsi/scsi_tgt_lib.c     |   28 +++-------
 drivers/scsi/sd.c               |   18 ++++---
 drivers/scsi/sg.c               |    2 -
 drivers/scsi/sr.c               |   15 +++---
 drivers/scsi/sun3_NCR5380.c     |    6 +-
 include/linux/blkdev.h          |   33 +++++++++--
 include/linux/blktrace_api.h    |    8 +++-
 include/linux/dma-mapping.h     |   22 ++++++++
 include/linux/elevator.h        |    4 +-
 71 files changed, 323 insertions(+), 281 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 49c047b..c01399c 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1012,7 +1012,7 @@ static int prepare_request(struct reques
 	int len;

 	/* This should be impossible now */
-	if((rq_data_dir(req) == WRITE) && !ubd_dev->openflags.w){
+	if((rq_write_dir(req) == WRITE) && !ubd_dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n",
 		       disk->disk_name);
 		end_request(req, 0);
@@ -1030,7 +1030,7 @@ static int prepare_request(struct reques
 	io_req->error = 0;
 	io_req->sector_mask = 0;

-	io_req->op = (rq_data_dir(req) == READ) ? UBD_READ : UBD_WRITE;
+	io_req->op = (rq_uni_write_dir(req) == READ) ? UBD_READ : UBD_WRITE;
 	io_req->offsets[0] = 0;
 	io_req->offsets[1] = ubd_dev->cow.data_offset;
 	io_req->buffer = req->buffer;
diff --git a/block/as-iosched.c b/block/as-iosched.c
index ef12627..824d93e 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -1285,7 +1285,7 @@ static void as_work_handler(struct work_
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }

-static int as_may_queue(request_queue_t *q, int rw)
+static int as_may_queue(request_queue_t *q, int rw, int is_sync)
 {
 	int ret = ELV_MQUEUE_MAY;
 	struct as_data *ad = q->elevator->elevator_data;
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 07b7062..e900c56 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -224,7 +224,7 @@ static inline pid_t cfq_queue_pid(struct
 	/*
 	 * Use the per-process queue, for read requests and syncronous writes
 	 */
-	if (!(rw & REQ_RW) || is_sync)
+	if (!(rw == WRITE) || is_sync)
 		return task->pid;

 	return CFQ_KEY_ASYNC;
@@ -1773,14 +1773,14 @@ static inline int __cfq_may_queue(struct
 	return ELV_MQUEUE_MAY;
 }

-static int cfq_may_queue(request_queue_t *q, int rw)
+static int cfq_may_queue(request_queue_t *q, int rw, int is_sync)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct task_struct *tsk = current;
 	struct cfq_queue *cfqq;
 	unsigned int key;

-	key = cfq_queue_pid(tsk, rw, rw & REQ_RW_SYNC);
+	key = cfq_queue_pid(tsk, rw, is_sync);

 	/*
 	 * don't force setup of a queue from here, as a call to may_queue
@@ -1807,7 +1807,7 @@ static void cfq_put_request(struct reque
 	struct cfq_queue *cfqq = RQ_CFQQ(rq);

 	if (cfqq) {
-		const int rw = rq_data_dir(rq);
+		const int rw = rq_write_dir(rq);

 		BUG_ON(!cfqq->allocated[rw]);
 		cfqq->allocated[rw]--;
@@ -1830,7 +1830,7 @@ cfq_set_request(request_queue_t *q, stru
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct task_struct *tsk = current;
 	struct cfq_io_context *cic;
-	const int rw = rq_data_dir(rq);
+	const int rw = rq_write_dir(rq);
 	const int is_sync = rq_is_sync(rq);
 	pid_t key = cfq_queue_pid(tsk, rw, is_sync);
 	struct cfq_queue *cfqq;
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index 6d673e9..eed26ae 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -53,7 +53,7 @@ struct deadline_data {

 static void deadline_move_request(struct deadline_data *, struct request *);

-#define RQ_RB_ROOT(dd, rq)	(&(dd)->sort_list[rq_data_dir((rq))])
+#define RQ_RB_ROOT(dd, rq)	(&(dd)->sort_list[rq_write_dir((rq))])

 static void
 deadline_add_rq_rb(struct deadline_data *dd, struct request *rq)
@@ -72,7 +72,7 @@ retry:
 static inline void
 deadline_del_rq_rb(struct deadline_data *dd, struct request *rq)
 {
-	const int data_dir = rq_data_dir(rq);
+	const int data_dir = rq_write_dir(rq);

 	if (dd->next_rq[data_dir] == rq) {
 		struct rb_node *rbnext = rb_next(&rq->rb_node);
@@ -92,7 +92,7 @@ static void
 deadline_add_request(struct request_queue *q, struct request *rq)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const int data_dir = rq_data_dir(rq);
+	const int data_dir = rq_write_dir(rq);

 	deadline_add_rq_rb(dd, rq);

@@ -197,7 +197,7 @@ deadline_move_to_dispatch(struct deadlin
 static void
 deadline_move_request(struct deadline_data *dd, struct request *rq)
 {
-	const int data_dir = rq_data_dir(rq);
+	const int data_dir = rq_write_dir(rq);
 	struct rb_node *rbnext = rb_next(&rq->rb_node);

 	dd->next_rq[READ] = NULL;
diff --git a/block/elevator.c b/block/elevator.c
index 536be74..6b17704 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -76,7 +76,7 @@ inline int elv_rq_merge_ok(struct reques
 	/*
 	 * different data direction or already started, don't merge
 	 */
-	if (bio_data_dir(bio) != rq_data_dir(rq))
+	if (bio_data_dir(bio) != rq_write_dir(rq))
 		return 0;

 	/*
@@ -719,7 +719,8 @@ struct request *elv_next_request(request
 			blk_add_trace_rq(q, rq, BLK_TA_ISSUE);
 		}

-		if (!q->boundary_rq || q->boundary_rq == rq) {
+		if ( (!q->boundary_rq || q->boundary_rq == rq) &&
+			!rq_bidi_dir(rq)) {
 			q->end_sector = rq_end_sector(rq);
 			q->boundary_rq = NULL;
 		}
@@ -831,12 +832,12 @@ void elv_put_request(request_queue_t *q,
 		e->ops->elevator_put_req_fn(rq);
 }

-int elv_may_queue(request_queue_t *q, int rw)
+int elv_may_queue(request_queue_t *q, int rw, int is_sync)
 {
 	elevator_t *e = q->elevator;

 	if (e->ops->elevator_may_queue_fn)
-		return e->ops->elevator_may_queue_fn(q, rw);
+		return e->ops->elevator_may_queue_fn(q, rw, is_sync);

 	return ELV_MQUEUE_MAY;
 }
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index fb67897..6511b5b 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -431,8 +431,9 @@ static inline struct request *start_orde
 	rq = &q->bar_rq;
 	rq->cmd_flags = 0;
 	rq_init(q, rq);
-	if (bio_data_dir(q->orig_bar_rq->bio) == WRITE)
-		rq->cmd_flags |= REQ_RW;
+	rq->data_dir = bio_data_dir(q->orig_bar_rq->bio) ?
+		DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
 	rq->cmd_flags |= q->ordered & QUEUE_ORDERED_FUA ? REQ_FUA : 0;
 	rq->elevator_private = NULL;
 	rq->elevator_private2 = NULL;
@@ -1958,18 +1959,22 @@ static inline void blk_free_request(requ
 }

 static struct request *
-blk_alloc_request(request_queue_t *q, int rw, int priv, gfp_t gfp_mask)
+blk_alloc_request(request_queue_t *q, enum dma_data_direction dir,
+	int priv, gfp_t gfp_mask)
 {
 	struct request *rq = mempool_alloc(q->rq.rq_pool, gfp_mask);

 	if (!rq)
 		return NULL;

-	/*
-	 * first three bits are identical in rq->cmd_flags and bio->bi_rw,
-	 * see bio.h and blkdev.h
-	 */
-	rq->cmd_flags = rw | REQ_ALLOCED;
+	rq->cmd_flags = REQ_ALLOCED;
+
+	BUG_ON( !(dma_uni_dir(dir) || (dir == DMA_BIDIRECTIONAL)) );
+	rq->data_dir = dir;
+
+	/* FIXME: Safeguard from BLACK unqueued requests that were not allocated/initted by us */
+	if (dir == DMA_BIDIRECTIONAL)
+		rq->cmd_flags |= REQ_BIDI;

 	if (priv) {
 		if (unlikely(elv_set_request(q, rq, gfp_mask))) {
@@ -2055,16 +2060,17 @@ #define blkdev_free_rq(list) list_entry(
  * Returns NULL on failure, with queue_lock held.
  * Returns !NULL on success, with queue_lock *not held*.
  */
-static struct request *get_request(request_queue_t *q, int rw_flags,
-				   struct bio *bio, gfp_t gfp_mask)
+static struct request *get_request(request_queue_t *q,
+	enum dma_data_direction dir, struct bio *bio, gfp_t gfp_mask)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = &q->rq;
 	struct io_context *ioc = NULL;
-	const int rw = rw_flags & 0x01;
 	int may_queue, priv;
+	int rw = dma_write_dir(dir);
+	int is_sync = (rw==READ) ? 1 : (bio ? bio_sync(bio) : 0);

-	may_queue = elv_may_queue(q, rw_flags);
+	may_queue = elv_may_queue(q, rw, is_sync);
 	if (may_queue == ELV_MQUEUE_NO)
 		goto rq_starved;

@@ -2112,7 +2118,7 @@ static struct request *get_request(reque

 	spin_unlock_irq(q->queue_lock);

-	rq = blk_alloc_request(q, rw_flags, priv, gfp_mask);
+	rq = blk_alloc_request(q, dir, priv, gfp_mask);
 	if (unlikely(!rq)) {
 		/*
 		 * Allocation failed presumably due to memory. Undo anything
@@ -2160,13 +2166,13 @@ out:
  *
  * Called with q->queue_lock held, and returns with it unlocked.
  */
-static struct request *get_request_wait(request_queue_t *q, int rw_flags,
-					struct bio *bio)
+static struct request *get_request_wait(request_queue_t *q,
+	enum dma_data_direction dir, struct bio *bio)
 {
-	const int rw = rw_flags & 0x01;
+	const int rw = dma_write_dir(dir);
 	struct request *rq;

-	rq = get_request(q, rw_flags, bio, GFP_NOIO);
+	rq = get_request(q, dir, bio, GFP_NOIO);
 	while (!rq) {
 		DEFINE_WAIT(wait);
 		struct request_list *rl = &q->rq;
@@ -2174,7 +2180,7 @@ static struct request *get_request_wait(
 		prepare_to_wait_exclusive(&rl->wait[rw], &wait,
 				TASK_UNINTERRUPTIBLE);

-		rq = get_request(q, rw_flags, bio, GFP_NOIO);
+		rq = get_request(q, dir, bio, GFP_NOIO);

 		if (!rq) {
 			struct io_context *ioc;
@@ -2202,17 +2208,16 @@ static struct request *get_request_wait(
 	return rq;
 }

-struct request *blk_get_request(request_queue_t *q, int rw, gfp_t gfp_mask)
+struct request *blk_get_request(request_queue_t *q,
+	enum dma_data_direction dir, gfp_t gfp_mask)
 {
 	struct request *rq;

-	BUG_ON(rw != READ && rw != WRITE);
-
 	spin_lock_irq(q->queue_lock);
 	if (gfp_mask & __GFP_WAIT) {
-		rq = get_request_wait(q, rw, NULL);
+		rq = get_request_wait(q, dir, NULL);
 	} else {
-		rq = get_request(q, rw, NULL, gfp_mask);
+		rq = get_request(q, dir, NULL, gfp_mask);
 		if (!rq)
 			spin_unlock_irq(q->queue_lock);
 	}
@@ -2223,6 +2228,23 @@ struct request *blk_get_request(request_
 EXPORT_SYMBOL(blk_get_request);

 /**
+ * blk_rq_init_unqueued_req - Initialize a request that does not come from a Q
+ *
+ * Description:
+ * Drivers that need to send a request that does not belong to a Q, like on
+ * the stack, should not bzero the request.
+ * They should call this function instead to initialize the request.
+ * It should never be called with a request that was allocated by a Q.
+ */
+void blk_rq_init_unqueued_req(struct request * rq)
+{
+	memset(rq, 0, sizeof(*rq));
+	rq->data_dir = DMA_FROM_DEVICE;
+}
+
+EXPORT_SYMBOL(blk_rq_init_unqueued_req);
+
+/**
  * blk_start_queueing - initiate dispatch of requests to device
  * @q:		request queue to kick into gear
  *
@@ -2335,7 +2357,7 @@ static int __blk_rq_map_user(request_que
 	struct bio *bio, *orig_bio;
 	int reading, ret;

-	reading = rq_data_dir(rq) == READ;
+	reading = rq_write_dir(rq) == READ;

 	/*
 	 * if alignment requirement is satisfied, map in user pages for
@@ -2479,7 +2501,7 @@ int blk_rq_map_user_iov(request_queue_t
 	/* we don't allow misaligned data like bio_map_user() does.  If the
 	 * user is using sg, they're expected to know the alignment constraints
 	 * and respect them accordingly */
-	bio = bio_map_user_iov(q, NULL, iov, iov_count, rq_data_dir(rq)== READ);
+	bio = bio_map_user_iov(q, NULL, iov, iov_count, rq_write_dir(rq)== READ);
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);

@@ -2552,7 +2574,7 @@ int blk_rq_map_kern(request_queue_t *q,
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);

-	if (rq_data_dir(rq) == WRITE)
+	if (rq_uni_write_dir(rq) == WRITE)
 		bio->bi_rw |= (1 << BIO_RW);

 	blk_rq_bio_prep(q, rq, bio);
@@ -2663,7 +2685,7 @@ EXPORT_SYMBOL(blkdev_issue_flush);

 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io)
 {
-	int rw = rq_data_dir(rq);
+	int rw = rq_write_dir(rq);

 	if (!blk_fs_request(rq) || !rq->rq_disk)
 		return;
@@ -2741,7 +2763,7 @@ void __blk_put_request(request_queue_t *
 	 * it didn't come out of our reserved rq pools
 	 */
 	if (req->cmd_flags & REQ_ALLOCED) {
-		int rw = rq_data_dir(req);
+		int rw = rq_write_dir(req);
 		int priv = req->cmd_flags & REQ_ELVPRIV;

 		BUG_ON(!list_empty(&req->queuelist));
@@ -2807,7 +2829,7 @@ static int attempt_merge(request_queue_t
 	if (req->sector + req->nr_sectors != next->sector)
 		return 0;

-	if (rq_data_dir(req) != rq_data_dir(next)
+	if (rq_dma_dir(req) != rq_dma_dir(next)
 	    || req->rq_disk != next->rq_disk
 	    || next->special)
 		return 0;
@@ -2908,7 +2930,6 @@ static int __make_request(request_queue_
 	int el_ret, nr_sectors, barrier, err;
 	const unsigned short prio = bio_prio(bio);
 	const int sync = bio_sync(bio);
-	int rw_flags;

 	nr_sectors = bio_sectors(bio);

@@ -2983,19 +3004,11 @@ static int __make_request(request_queue_

 get_rq:
 	/*
-	 * This sync check and mask will be re-done in init_request_from_bio(),
-	 * but we need to set it earlier to expose the sync flag to the
-	 * rq allocator and io schedulers.
-	 */
-	rw_flags = bio_data_dir(bio);
-	if (sync)
-		rw_flags |= REQ_RW_SYNC;
-
-	/*
 	 * Grab a free request. This is might sleep but can not fail.
 	 * Returns with the queue unlocked.
 	 */
-	req = get_request_wait(q, rw_flags, bio);
+	req = get_request_wait(q,
+		bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE, bio);

 	/*
 	 * After dropping the lock and possibly sleeping here, our request
@@ -3354,7 +3367,7 @@ static int __end_that_request_first(stru
 	}

 	if (blk_fs_request(req) && req->rq_disk) {
-		const int rw = rq_data_dir(req);
+		const int rw = rq_write_dir(req);

 		disk_stat_add(req->rq_disk, sectors[rw], nr_bytes >> 9);
 	}
@@ -3578,7 +3591,7 @@ void end_that_request_last(struct reques
 	 */
 	if (disk && blk_fs_request(req) && req != &req->q->bar_rq) {
 		unsigned long duration = jiffies - req->start_time;
-		const int rw = rq_data_dir(req);
+		const int rw = rq_write_dir(req);

 		__disk_stat_inc(disk, ios[rw]);
 		__disk_stat_add(disk, ticks[rw], duration);
@@ -3606,8 +3619,20 @@ EXPORT_SYMBOL(end_request);

 void blk_rq_bio_prep(request_queue_t *q, struct request *rq, struct bio *bio)
 {
-	/* first two bits are identical in rq->cmd_flags and bio->bi_rw */
-	rq->cmd_flags |= (bio->bi_rw & 3);
+	rq->data_dir = bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
+	if (bio->bi_rw & (1<<BIO_RW_SYNC))
+		rq->cmd_flags |= REQ_RW_SYNC;
+	else
+		rq->cmd_flags &= ~REQ_RW_SYNC;
+	/* FIXME: what about other flags, should we sync these too? */
+	/*
+	BIO_RW_AHEAD	==> ??
+	BIO_RW_BARRIER	==> REQ_SOFTBARRIER/REQ_HARDBARRIER
+	BIO_RW_FAILFAST	==> REQ_FAILFAST
+	BIO_RW_SYNC	==> REQ_RW_SYNC
+	BIO_RW_META	==> REQ_RW_META
+	*/

 	rq->nr_phys_segments = bio_phys_segments(q, bio);
 	rq->nr_hw_segments = bio_hw_segments(q, bio);
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 2528a0c..cffb02f 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -254,7 +254,7 @@ static int sg_io(struct file *file, requ
 			break;
 		}

-	rq = blk_get_request(q, writing ? WRITE : READ, GFP_KERNEL);
+	rq = blk_get_request(q, writing ? DMA_TO_DEVICE : DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!rq)
 		return -ENOMEM;

@@ -409,7 +409,7 @@ int sg_scsi_ioctl(struct file *file, str
 		memset(buffer, 0, bytes);
 	}

-	rq = blk_get_request(q, in_len ? WRITE : READ, __GFP_WAIT);
+	rq = blk_get_request(q, in_len ? DMA_TO_DEVICE : DMA_FROM_DEVICE, __GFP_WAIT);

 	cmdlen = COMMAND_SIZE(opcode);

@@ -494,10 +494,8 @@ static int __blk_send_generic(request_qu
 	struct request *rq;
 	int err;

-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq = blk_get_request(q, DMA_NONE, __GFP_WAIT);
 	rq->cmd_type = REQ_TYPE_BLOCK_PC;
-	rq->data = NULL;
-	rq->data_len = 0;
 	rq->timeout = BLK_DEFAULT_TIMEOUT;
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = cmd;
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 8d81a3a..ae0df90 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -3323,7 +3323,7 @@ static int DAC960_process_queue(DAC960_C
 	if (Command == NULL)
 		return 0;

-	if (rq_data_dir(Request) == READ) {
+	if (rq_uni_write_dir(Request) == READ) {
 		Command->DmaDirection = PCI_DMA_FROMDEVICE;
 		Command->CommandType = DAC960_ReadCommand;
 	} else {
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 5d65621..7b6fc4f 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1379,7 +1379,7 @@ #ifdef DEBUG
 		       "0x%08lx\n", track, sector, data);
 #endif

-		if ((rq_data_dir(CURRENT) != READ) && (rq_data_dir(CURRENT) != WRITE)) {
+		if ( !dma_uni_dir(CURRENT->data_dir) ) {
 			printk(KERN_WARNING "do_fd_request: unknown command\n");
 			end_request(CURRENT, 0);
 			goto repeat;
@@ -1389,7 +1389,7 @@ #endif
 			goto repeat;
 		}

-		switch (rq_data_dir(CURRENT)) {
+		switch (rq_write_dir(CURRENT)) {
 		case READ:
 			memcpy(data, floppy->trackbuf + sector * 512, 512);
 			break;
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 14d6b94..4b833ef 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1453,7 +1453,7 @@ repeat:
 	del_timer( &motor_off_timer );
 		
 	ReqCnt = 0;
-	ReqCmd = rq_data_dir(CURRENT);
+	ReqCmd = rq_uni_write_dir(CURRENT);
 	ReqBlock = CURRENT->sector;
 	ReqBuffer = CURRENT->buffer;
 	setup_req_params( drive );
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 05dfe35..ff14c04 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1237,7 +1237,7 @@ static void cciss_softirq_done(struct re
 	complete_buffers(rq->bio, rq->errors);

 	if (blk_fs_request(rq)) {
-		const int rw = rq_data_dir(rq);
+		const int rw = rq_write_dir(rq);

 		disk_stat_add(rq->rq_disk, sectors[rw], rq->nr_sectors);
 	}
@@ -2493,10 +2493,10 @@ static void do_cciss_request(request_que
 	c->Request.Type.Type = TYPE_CMD;	// It is a command.
 	c->Request.Type.Attribute = ATTR_SIMPLE;
 	c->Request.Type.Direction =
-	    (rq_data_dir(creq) == READ) ? XFER_READ : XFER_WRITE;
+	    (rq_uni_write_dir(creq) == READ) ? XFER_READ : XFER_WRITE;
 	c->Request.Timeout = 0;	// Don't time out
 	c->Request.CDB[0] =
-	    (rq_data_dir(creq) == READ) ? h->cciss_read : h->cciss_write;
+	    (rq_uni_write_dir(creq) == READ) ? h->cciss_read : h->cciss_write;
 	start_blk = creq->sector;
 #ifdef CCISS_DEBUG
 	printk(KERN_DEBUG "ciss: sector =%d nr_sectors=%d\n", (int)creq->sector,
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index b94cd1c..039279f 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -922,7 +922,7 @@ DBGPX(
 	seg = blk_rq_map_sg(q, creq, tmp_sg);

 	/* Now do all the DMA Mappings */
-	if (rq_data_dir(creq) == READ)
+	if (rq_uni_write_dir(creq) == READ)
 		dir = PCI_DMA_FROMDEVICE;
 	else
 		dir = PCI_DMA_TODEVICE;
@@ -937,7 +937,7 @@ DBGPX(
 DBGPX(	printk("Submitting %d sectors in %d segments\n", creq->nr_sectors, seg); );
 	c->req.hdr.sg_cnt = seg;
 	c->req.hdr.blk_cnt = creq->nr_sectors;
-	c->req.hdr.cmd = (rq_data_dir(creq) == READ) ? IDA_READ : IDA_WRITE;
+	c->req.hdr.cmd = (rq_uni_write_dir(creq) == READ) ? IDA_READ : IDA_WRITE;
 	c->type = CMD_RWREQ;

 	/* Put the request on the tail of the request queue */
@@ -1033,7 +1033,7 @@ static inline void complete_command(cmdl
 	complete_buffers(rq->bio, ok);

 	if (blk_fs_request(rq)) {
-		const int rw = rq_data_dir(rq);
+		const int rw = rq_write_dir(rq);

 		disk_stat_add(rq->rq_disk, sectors[rw], rq->nr_sectors);
 	}
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3f1b382..54a3a15 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2325,7 +2325,7 @@ static void request_done(int uptodate)
 		floppy_end_request(req, 1);
 		spin_unlock_irqrestore(q->queue_lock, flags);
 	} else {
-		if (rq_data_dir(req) == WRITE) {
+		if (rq_uni_write_dir(req) == WRITE) {
 			/* record write error information */
 			DRWE->write_errors++;
 			if (DRWE->write_errors == 1) {
@@ -2628,15 +2628,12 @@ static int make_raw_rw_request(void)
 	raw_cmd->flags = FD_RAW_SPIN | FD_RAW_NEED_DISK | FD_RAW_NEED_DISK |
 	    FD_RAW_NEED_SEEK;
 	raw_cmd->cmd_count = NR_RW;
-	if (rq_data_dir(current_req) == READ) {
+	if (rq_uni_write_dir(current_req) == READ) {
 		raw_cmd->flags |= FD_RAW_READ;
 		COMMAND = FM_MODE(_floppy, FD_READ);
-	} else if (rq_data_dir(current_req) == WRITE) {
+	} else {
 		raw_cmd->flags |= FD_RAW_WRITE;
 		COMMAND = FM_MODE(_floppy, FD_WRITE);
-	} else {
-		DPRINT("make_raw_rw_request: unknown command\n");
-		return 0;
 	}

 	max_sector = _floppy->sect * _floppy->head;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 090796b..de9e825 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -434,7 +434,7 @@ static void do_nbd_request(request_queue
 		BUG_ON(lo->magic != LO_MAGIC);

 		nbd_cmd(req) = NBD_CMD_READ;
-		if (rq_data_dir(req) == WRITE) {
+		if (rq_uni_write_dir(req) == WRITE) {
 			nbd_cmd(req) = NBD_CMD_WRITE;
 			if (lo->flags & NBD_READ_ONLY) {
 				printk(KERN_ERR "%s: Write on read-only\n",
@@ -502,6 +502,7 @@ static int nbd_ioctl(struct inode *inode
 	dprintk(DBG_IOCTL, "%s: nbd_ioctl cmd=%s(0x%x) arg=%lu\n",
 			lo->disk->disk_name, ioctl_cmd_to_ascii(cmd), cmd, arg);

+	blk_rq_init_unqueued_req(&sreq);
 	switch (cmd) {
 	case NBD_DISCONNECT:
 	        printk(KERN_INFO "%s: NBD_DISCONNECT\n", lo->disk->disk_name);
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index c852eed..375499e 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -722,7 +722,7 @@ static void do_pcd_request(request_queue
 		if (!pcd_req)
 			return;

-		if (rq_data_dir(pcd_req) == READ) {
+		if (rq_dma_dir(pcd_req) == DMA_FROM_DEVICE) {
 			struct pcd_unit *cd = pcd_req->rq_disk->private_data;
 			if (cd != pcd_current)
 				pcd_bufblk = -1;
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 9d9bff2..a87d605 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -442,21 +442,18 @@ static enum action do_pd_io_start(void)
 		return pd_special();
 	}

-	pd_cmd = rq_data_dir(pd_req);
-	if (pd_cmd == READ || pd_cmd == WRITE) {
-		pd_block = pd_req->sector;
-		pd_count = pd_req->current_nr_sectors;
-		if (pd_block + pd_count > get_capacity(pd_req->rq_disk))
-			return Fail;
-		pd_run = pd_req->nr_sectors;
-		pd_buf = pd_req->buffer;
-		pd_retries = 0;
-		if (pd_cmd == READ)
-			return do_pd_read_start();
-		else
-			return do_pd_write_start();
-	}
-	return Fail;
+	pd_cmd = rq_uni_write_dir(pd_req);
+	pd_block = pd_req->sector;
+	pd_count = pd_req->current_nr_sectors;
+	if (pd_block + pd_count > get_capacity(pd_req->rq_disk))
+		return Fail;
+	pd_run = pd_req->nr_sectors;
+	pd_buf = pd_req->buffer;
+	pd_retries = 0;
+	if (pd_cmd == READ)
+		return do_pd_read_start();
+	else
+		return do_pd_write_start();
 }

 static enum action pd_special(void)
@@ -717,7 +714,7 @@ static int pd_special_command(struct pd_
 	struct request rq;
 	int err = 0;

-	memset(&rq, 0, sizeof(rq));
+	blk_rq_init_unqueued_req(&rq);
 	rq.errors = 0;
 	rq.rq_disk = disk->gd;
 	rq.ref_count = 1;
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 7cdaa19..f844588 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -779,20 +779,15 @@ repeat:
 		goto repeat;
 	}

-	pf_cmd = rq_data_dir(pf_req);
+	pf_cmd = rq_uni_write_dir(pf_req);
 	pf_buf = pf_req->buffer;
 	pf_retries = 0;

 	pf_busy = 1;
 	if (pf_cmd == READ)
 		pi_do_claimed(pf_current->pi, do_pf_read);
-	else if (pf_cmd == WRITE)
+	else
 		pi_do_claimed(pf_current->pi, do_pf_write);
-	else {
-		pf_busy = 0;
-		pf_end_request(0);
-		goto repeat;
-	}
 }

 static int pf_next_buf(void)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 6246219..945db31 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -770,7 +770,7 @@ static int pkt_generic_packet(struct pkt
 	int ret = 0;

 	rq = blk_get_request(q, (cgc->data_direction == CGC_DATA_WRITE) ?
-			     WRITE : READ, __GFP_WAIT);
+			     DMA_TO_DEVICE : DMA_FROM_DEVICE, __GFP_WAIT);

 	if (cgc->buflen) {
 		if (blk_rq_map_kern(q, rq, cgc->buffer, cgc->buflen, __GFP_WAIT))
diff --git a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
index 688a4fb..60ff1f9 100644
--- a/drivers/block/ps2esdi.c
+++ b/drivers/block/ps2esdi.c
@@ -506,11 +506,12 @@ #endif
 		return;
 	}

-	switch (rq_data_dir(req)) {
-	case READ:
+	switch (rq_dma_dir(req)) {
+	case DMA_FROM_DEVICE:
+	case DMA_NONE:
 		ps2esdi_readwrite(READ, req);
 		break;
-	case WRITE:
+	case DMA_TO_DEVICE:
 		ps2esdi_readwrite(WRITE, req);
 		break;
 	default:
@@ -859,7 +860,7 @@ static void ps2esdi_normal_interrupt_han
 	case INT_TRANSFER_REQ:
 		ps2esdi_prep_dma(current_req->buffer,
 				 current_req->current_nr_sectors,
-		    (rq_data_dir(current_req) == READ)
+		    (rq_uni_write_dir(current_req) == READ)
 		    ? MCA_DMA_MODE_16 | MCA_DMA_MODE_WRITE | MCA_DMA_MODE_XFER
 		    : MCA_DMA_MODE_16 | MCA_DMA_MODE_READ);
 		outb(CTRL_ENABLE_DMA | CTRL_ENABLE_INTR, ESDI_CONTROL);
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 1a65979..74402a8 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -336,7 +336,7 @@ #endif
 			continue;
 		}

-		if (rq_data_dir(req) == WRITE) {
+		if (rq_uni_write_dir(req) == WRITE) {
 			if (fs->write_prot < 0)
 				fs->write_prot = swim3_readbit(fs, WRITE_PROT);
 			if (fs->write_prot) {
@@ -432,7 +432,7 @@ static inline void setup_transfer(struct
 		printk(KERN_ERR "swim3: transfer 0 sectors?\n");
 		return;
 	}
-	if (rq_data_dir(fd_req) == WRITE)
+	if (rq_uni_write_dir(fd_req) == WRITE)
 		n = 1;
 	else {
 		n = fs->secpertrack - fs->req_sector + 1;
@@ -445,7 +445,7 @@ static inline void setup_transfer(struct
 	out_8(&sw->nsect, n);
 	out_8(&sw->gap3, 0);
 	out_le32(&dr->cmdptr, virt_to_bus(cp));
-	if (rq_data_dir(fd_req) == WRITE) {
+	if (rq_uni_write_dir(fd_req) == WRITE) {
 		/* Set up 3 dma commands: write preamble, data, postamble */
 		init_dma(cp, OUTPUT_MORE, write_preamble, sizeof(write_preamble));
 		++cp;
@@ -460,7 +460,7 @@ static inline void setup_transfer(struct
 	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
 	in_8(&sw->error);
 	out_8(&sw->control_bic, DO_ACTION | WRITE_SECTORS);
-	if (rq_data_dir(fd_req) == WRITE)
+	if (rq_uni_write_dir(fd_req) == WRITE)
 		out_8(&sw->control_bis, WRITE_SECTORS);
 	in_8(&sw->intr);
 	out_le32(&dr->control, (RUN << 16) | RUN);
@@ -609,7 +609,7 @@ static void xfer_timeout(unsigned long d
 	out_8(&sw->intr_enable, 0);
 	out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
 	out_8(&sw->select, RELAX);
-	if (rq_data_dir(fd_req) == WRITE)
+	if (rq_uni_write_dir(fd_req) == WRITE)
 		++cp;
 	if (ld_le16(&cp->xfer_status) != 0)
 		s = fs->scount - ((ld_le16(&cp->res_count) + 511) >> 9);
@@ -618,7 +618,7 @@ static void xfer_timeout(unsigned long d
 	fd_req->sector += s;
 	fd_req->current_nr_sectors -= s;
 	printk(KERN_ERR "swim3: timeout %sing sector %ld\n",
-	       (rq_data_dir(fd_req)==WRITE? "writ": "read"), (long)fd_req->sector);
+	       (rq_write_dir(fd_req)==WRITE? "writ": "read"), (long)fd_req->sector);
 	end_request(fd_req, 0);
 	fs->state = idle;
 	start_request(fs);
@@ -636,8 +636,8 @@ static irqreturn_t swim3_interrupt(int i
 	intr = in_8(&sw->intr);
 	err = (intr & ERROR_INTR)? in_8(&sw->error): 0;
 	if ((intr & ERROR_INTR) && fs->state != do_transfer)
-		printk(KERN_ERR "swim3_interrupt, state=%d, dir=%x, intr=%x, err=%x\n",
-		       fs->state, rq_data_dir(fd_req), intr, err);
+		printk(KERN_ERR "swim3_interrupt, state=%d, dir=%d, intr=%x, err=%x\n",
+		       fs->state, rq_dma_dir(fd_req), intr, err);
 	switch (fs->state) {
 	case locating:
 		if (intr & SEEN_SECTOR) {
@@ -698,7 +698,7 @@ static irqreturn_t swim3_interrupt(int i
 		fs->timeout_pending = 0;
 		dr = fs->dma;
 		cp = fs->dma_cmd;
-		if (rq_data_dir(fd_req) == WRITE)
+		if (rq_uni_write_dir(fd_req) == WRITE)
 			++cp;
 		/*
 		 * Check that the main data transfer has finished.
@@ -733,7 +733,7 @@ static irqreturn_t swim3_interrupt(int i
 				act(fs);
 			} else {
 				printk("swim3: error %sing block %ld (err=%x)\n",
-				       rq_data_dir(fd_req) == WRITE? "writ": "read",
+				       rq_write_dir(fd_req) == WRITE? "writ": "read",
 				       (long)fd_req->sector, err);
 				end_request(fd_req, 0);
 				fs->state = idle;
@@ -742,8 +742,8 @@ static irqreturn_t swim3_interrupt(int i
 			if ((stat & ACTIVE) == 0 || resid != 0) {
 				/* musta been an error */
 				printk(KERN_ERR "swim3: fd dma: stat=%x resid=%d\n", stat, resid);
-				printk(KERN_ERR "  state=%d, dir=%x, intr=%x, err=%x\n",
-				       fs->state, rq_data_dir(fd_req), intr, err);
+				printk(KERN_ERR "  state=%d, dir=%d, intr=%x, err=%x\n",
+				       fs->state, rq_dma_dir(fd_req), intr, err);
 				end_request(fd_req, 0);
 				fs->state = idle;
 				start_request(fs);
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 54509eb..dbc67eb 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -565,7 +565,7 @@ static struct carm_request *carm_get_spe
 	if (!crq)
 		return NULL;

-	rq = blk_get_request(host->oob_q, WRITE /* bogus */, GFP_KERNEL);
+	rq = blk_get_request(host->oob_q, DMA_TO_DEVICE /* bogus */, GFP_KERNEL);
 	if (!rq) {
 		spin_lock_irqsave(&host->lock, flags);
 		carm_put_request(host, crq);
@@ -860,7 +860,7 @@ queue_one_request:

 	blkdev_dequeue_request(rq);

-	if (rq_data_dir(rq) == WRITE) {
+	if (rq_uni_write_dir(rq) == WRITE) {
 		writing = 1;
 		pci_dir = PCI_DMA_TODEVICE;
 	} else {
@@ -1053,7 +1053,7 @@ static inline void carm_handle_rw(struct

 	VPRINTK("ENTER\n");

-	if (rq_data_dir(crq->rq) == WRITE)
+	if (rq_uni_write_dir(crq->rq) == WRITE)
 		pci_dir = PCI_DMA_TODEVICE;
 	else
 		pci_dir = PCI_DMA_FROMDEVICE;
diff --git a/drivers/block/ub.c b/drivers/block/ub.c
index 2098eff..34b8fe8 100644
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -709,11 +709,7 @@ static void ub_cmd_build_block(struct ub
 	struct request *rq = urq->rq;
 	unsigned int block, nblks;

-	if (rq_data_dir(rq) == WRITE)
-		cmd->dir = UB_DIR_WRITE;
-	else
-		cmd->dir = UB_DIR_READ;
-
+	cmd->dir = rq_uni_write_dir(rq) ? UB_DIR_WRITE : UB_DIR_READ;
 	cmd->nsg = urq->nsg;
 	memcpy(cmd->sgv, urq->sgv, sizeof(struct scatterlist) * cmd->nsg);

@@ -747,7 +743,7 @@ static void ub_cmd_build_packet(struct u
 	if (rq->data_len == 0) {
 		cmd->dir = UB_DIR_NONE;
 	} else {
-		if (rq_data_dir(rq) == WRITE)
+		if (rq_uni_write_dir(rq) == WRITE)
 			cmd->dir = UB_DIR_WRITE;
 		else
 			cmd->dir = UB_DIR_READ;
diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index 68592c3..3b56b22 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -302,7 +302,7 @@ static int send_request(struct request *

 	start = (u64)req->sector << 9;

-	if (rq_data_dir(req) == READ) {
+	if (rq_uni_write_dir(req) == READ) {
 		direction = DMA_FROM_DEVICE;
 		viocmd = viomajorsubtype_blockio | vioblockread;
 		statindex = 0;
diff --git a/drivers/block/xd.c b/drivers/block/xd.c
index 0d97b7e..33d411f 100644
--- a/drivers/block/xd.c
+++ b/drivers/block/xd.c
@@ -308,7 +308,7 @@ static void do_xd_request (request_queue
 	while ((req = elv_next_request(q)) != NULL) {
 		unsigned block = req->sector;
 		unsigned count = req->nr_sectors;
-		int rw = rq_data_dir(req);
+		int rw = rq_write_dir(req);
 		XD_INFO *disk = req->rq_disk->private_data;
 		int res = 0;
 		int retry;
@@ -321,7 +321,7 @@ static void do_xd_request (request_queue
 			end_request(req, 0);
 			continue;
 		}
-		if (rw != READ && rw != WRITE) {
+		if (!dma_uni_dir(req->data_dir)) {
 			printk("do_xd_request: unknown request\n");
 			end_request(req, 0);
 			continue;
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 7cc2685..2c18422 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -89,7 +89,7 @@ static void do_z2_request(request_queue_
 			if (len < size)
 				size = len;
 			addr += z2ram_map[ start >> Z2RAM_CHUNKSHIFT ];
-			if (rq_data_dir(req) == READ)
+			if (rq_uni_write_dir(req) == READ)
 				memcpy(req->buffer, (char *)addr, size);
 			else
 				memcpy((char *)addr, req->buffer, size);
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 3105ddd..d5d5b0b 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2103,7 +2103,7 @@ static int cdrom_read_cdda_bpc(struct cd
 	if (!q)
 		return -ENXIO;

-	rq = blk_get_request(q, READ, GFP_KERNEL);
+	rq = blk_get_request(q, DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!rq)
 		return -ENOMEM;

diff --git a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
index 2157c58..c99a750 100644
--- a/drivers/cdrom/cdu31a.c
+++ b/drivers/cdrom/cdu31a.c
@@ -1342,7 +1342,7 @@ static void do_cdu31a_request(request_qu
 			end_request(req, 0);
 			continue;
 		}
-		if (rq_data_dir(req) == WRITE) {
+		if (rq_write_dir(req) == WRITE) {
 			end_request(req, 0);
 			continue;
 		}
diff --git a/drivers/cdrom/gscd.c b/drivers/cdrom/gscd.c
index fa70824..ce7b281 100644
--- a/drivers/cdrom/gscd.c
+++ b/drivers/cdrom/gscd.c
@@ -266,7 +266,7 @@ repeat:
 		goto out;

 	if (req->cmd != READ) {
-		printk("GSCD: bad cmd %u\n", rq_data_dir(req));
+		printk("GSCD: bad cmd %u\n", rq_dma_dir(req));
 		end_request(req, 0);
 		goto repeat;
 	}
diff --git a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
index a1283b1..39e79f0 100644
--- a/drivers/cdrom/sbpcd.c
+++ b/drivers/cdrom/sbpcd.c
@@ -4550,7 +4550,7 @@ #endif
 	spin_unlock_irq(q->queue_lock);

 	down(&ioctl_read_sem);
-	if (rq_data_dir(elv_next_request(q)) != READ)
+	if (rq_write_dir(elv_next_request(q)) != READ)
 	{
 		msg(DBG_INF, "bad cmd %d\n", req->cmd[0]);
 		goto err_done;
diff --git a/drivers/cdrom/sonycd535.c b/drivers/cdrom/sonycd535.c
index f77ada9..2829caa 100644
--- a/drivers/cdrom/sonycd535.c
+++ b/drivers/cdrom/sonycd535.c
@@ -816,7 +816,7 @@ do_cdu535_request(request_queue_t * q)
 			end_request(req, 0);
 			continue;
 		}
-		if (rq_data_dir(req) == WRITE) {
+		if (rq_write_dir(req) == WRITE) {
 			end_request(req, 0);
 			continue;
 		}
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index 93fbf84..a33c8ea 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -338,7 +338,7 @@ static int send_request(struct request *

 	BUG_ON(req->nr_phys_segments > 1);

-	if (rq_data_dir(req) == READ) {
+	if (rq_uni_write_dir(req) == READ) {
 		direction = DMA_FROM_DEVICE;
 		cmd = viomajorsubtype_cdio | viocdread;
 	} else {
diff --git a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
index 8a1c27f..83a8d01 100644
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -219,10 +219,7 @@ static void icside_build_sglist(ide_driv

 	ide_map_sg(drive, rq);

-	if (rq_data_dir(rq) == READ)
-		hwif->sg_dma_direction = DMA_FROM_DEVICE;
-	else
-		hwif->sg_dma_direction = DMA_TO_DEVICE;
+	hwif->sg_dma_direction = rq_dma_dir(rq);

 	hwif->sg_nents = dma_map_sg(state->dev, sg, hwif->sg_nents,
 				    hwif->sg_dma_direction);
@@ -402,7 +399,7 @@ static int icside_dma_setup(ide_drive_t
 	struct request *rq = hwif->hwgroup->rq;
 	unsigned int dma_mode;

-	if (rq_data_dir(rq))
+	if (rq_uni_write_dir(rq))
 		dma_mode = DMA_MODE_WRITE;
 	else
 		dma_mode = DMA_MODE_READ;
diff --git a/drivers/ide/cris/ide-cris.c b/drivers/ide/cris/ide-cris.c
index 5797e0b..d0b972d 100644
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -1068,7 +1068,7 @@ static int cris_dma_setup(ide_drive_t *d
 {
 	struct request *rq = drive->hwif->hwgroup->rq;

-	cris_ide_initialize_dma(!rq_data_dir(rq));
+	cris_ide_initialize_dma(!rq_uni_write_dir(rq));
 	if (cris_ide_build_dmatable (drive)) {
 		ide_map_sg(drive, rq);
 		return 1;
@@ -1090,7 +1090,7 @@ static void cris_dma_exec_cmd(ide_drive_
 static void cris_dma_start(ide_drive_t *drive)
 {
 	struct request *rq = drive->hwif->hwgroup->rq;
-	int writing = rq_data_dir(rq);
+	int writing = rq_uni_write_dir(rq);
 	int type = TYPE_DMA;

 	if (drive->current_speed >= XFER_UDMA_0)
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 5969cec..d615de3 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -774,7 +774,7 @@ static int cdrom_decode_status(ide_drive

 		if (sense_key == NOT_READY) {
 			/* Tray open. */
-			if (rq_data_dir(rq) == READ) {
+			if (rq_uni_write_dir(rq) == READ) {
 				cdrom_saw_media_change (drive);

 				/* Fail the request. */
@@ -1729,7 +1729,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	/*
 	 * check which way to transfer data
 	 */
-	if (rq_data_dir(rq) == WRITE) {
+	if (rq_uni_write_dir(rq) == WRITE) {
 		/*
 		 * write to drive
 		 */
@@ -2020,10 +2020,10 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
 			}
 			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
 		}
-		if ((rq_data_dir(rq) == READ) && IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
+		if ((rq_uni_write_dir(rq) == READ) && IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
 			action = cdrom_start_seek(drive, block);
 		} else {
-			if (rq_data_dir(rq) == READ)
+			if (rq_uni_write_dir(rq) == READ)
 				action = cdrom_start_read(drive, block);
 			else
 				action = cdrom_start_write(drive, rq);
@@ -3065,7 +3065,7 @@ static int ide_cdrom_prep_fs(request_que

 	memset(rq->cmd, 0, sizeof(rq->cmd));

-	if (rq_data_dir(rq) == READ)
+	if (rq_uni_write_dir(rq) == READ)
 		rq->cmd[0] = GPCMD_READ_10;
 	else
 		rq->cmd[0] = GPCMD_WRITE_10;
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 0a05a37..3ef95f8 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -254,7 +254,7 @@ #endif

 	if (dma) {
 		if (!hwif->dma_setup(drive)) {
-			if (rq_data_dir(rq)) {
+			if (rq_uni_write_dir(rq)) {
 				command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 				if (drive->vdma)
 					command = lba48 ? WIN_WRITE_EXT: WIN_WRITE;
@@ -271,7 +271,7 @@ #endif
 		ide_init_sg_cmd(drive, rq);
 	}

-	if (rq_data_dir(rq) == READ) {
+	if (rq_uni_write_dir(rq) == READ) {

 		if (drive->mult_count) {
 			hwif->data_phase = TASKFILE_MULTI_IN;
@@ -319,8 +319,8 @@ static ide_startstop_t ide_do_rw_disk (i

 	ledtrig_ide_activity();

-	pr_debug("%s: %sing: block=%llu, sectors=%lu, buffer=0x%08lx\n",
-		 drive->name, rq_data_dir(rq) == READ ? "read" : "writ",
+	pr_debug("%s: %s: block=%llu, sectors=%lu, buffer=0x%08lx\n",
+		 drive->name, dma_dir_to_string(rq->data_dir),
 		 (unsigned long long)block, rq->nr_sectors,
 		 (unsigned long)rq->buffer);

@@ -714,7 +714,7 @@ static int idedisk_issue_flush(request_q
 	if (!drive->wcache)
 		return 0;

-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq = blk_get_request(q, DMA_TO_DEVICE, __GFP_WAIT);

 	idedisk_prepare_flush(q, rq);

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 56efed6..a779e00 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -207,7 +207,7 @@ int ide_build_sglist(ide_drive_t *drive,

 	ide_map_sg(drive, rq);

-	if (rq_data_dir(rq) == READ)
+	if (rq_uni_write_dir(rq) == READ)
 		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	else
 		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
@@ -553,7 +553,7 @@ int ide_dma_setup(ide_drive_t *drive)
 	unsigned int reading;
 	u8 dma_stat;

-	if (rq_data_dir(rq))
+	if (rq_uni_write_dir(rq))
 		reading = 0;
 	else
 		reading = 1 << 3;
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index d33717c..8741997 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1232,7 +1232,7 @@ static void idefloppy_create_rw_cmd (ide
 {
 	int block = sector / floppy->bs_factor;
 	int blocks = rq->nr_sectors / floppy->bs_factor;
-	int cmd = rq_data_dir(rq);
+	int cmd = rq_uni_write_dir(rq);

 	debug_log("create_rw1%d_cmd: block == %d, blocks == %d\n",
 		2 * test_bit (IDEFLOPPY_USE_READ12, &floppy->flags),
@@ -1250,7 +1250,7 @@ static void idefloppy_create_rw_cmd (ide
 	pc->callback = &idefloppy_rw_callback;
 	pc->rq = rq;
 	pc->b_count = cmd == READ ? 0 : rq->bio->bi_size;
-	if (rq->cmd_flags & REQ_RW)
+	if (cmd == WRITE)
 		set_bit(PC_WRITING, &pc->flags);
 	pc->buffer = NULL;
 	pc->request_transfer = pc->buffer_size = blocks * floppy->block_size;
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 2614f41..c1b5397 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -516,7 +516,7 @@ static ide_startstop_t ide_ata_error(ide
 		}
 	}

-	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ && hwif->err_stops_fifo == 0)
+	if ((stat & DRQ_STAT) && rq_uni_write_dir(rq) == READ && hwif->err_stops_fifo == 0)
 		try_to_flush_leftover_data(drive);

 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
@@ -1685,7 +1685,7 @@ #endif /* CONFIG_BLK_DEV_IDEPCI */

 void ide_init_drive_cmd (struct request *rq)
 {
-	memset(rq, 0, sizeof(*rq));
+	blk_rq_init_unqueued_req(rq);
 	rq->cmd_type = REQ_TYPE_ATA_CMD;
 	rq->ref_count = 1;
 }
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index b3bcd1d..1a0cf44 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1775,7 +1775,7 @@ static void idetape_create_request_sense

 static void idetape_init_rq(struct request *rq, u8 cmd)
 {
-	memset(rq, 0, sizeof(*rq));
+	blk_rq_init_unqueued_req(rq);
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->cmd[0] = cmd;
 }
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 30175c7..45cba31 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -473,7 +473,7 @@ static int ide_diag_taskfile(ide_drive_t
 {
 	struct request rq;

-	memset(&rq, 0, sizeof(rq));
+	ide_init_drive_cmd(&rq);
 	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
 	rq.buffer = buf;

@@ -498,8 +498,8 @@ static int ide_diag_taskfile(ide_drive_t
 		rq.hard_nr_sectors = rq.nr_sectors;
 		rq.hard_cur_sectors = rq.current_nr_sectors = rq.nr_sectors;

-		if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
-			rq.cmd_flags |= REQ_RW;
+		rq.data_dir = (args->command_type == IDE_DRIVE_TASK_RAW_WRITE) ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	}

 	rq.special = args;
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 1689076..7351fd1 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1218,7 +1218,7 @@ static int generic_ide_suspend(struct de
 	struct request_pm_state rqpm;
 	ide_task_t args;

-	memset(&rq, 0, sizeof(rq));
+	ide_init_drive_cmd(&rq);
 	memset(&rqpm, 0, sizeof(rqpm));
 	memset(&args, 0, sizeof(args));
 	rq.cmd_type = REQ_TYPE_PM_SUSPEND;
@@ -1239,7 +1239,7 @@ static int generic_ide_resume(struct dev
 	struct request_pm_state rqpm;
 	ide_task_t args;

-	memset(&rq, 0, sizeof(rq));
+	ide_init_drive_cmd(&rq);
 	memset(&rqpm, 0, sizeof(rqpm));
 	memset(&args, 0, sizeof(args));
 	rq.cmd_type = REQ_TYPE_PM_RESUME;
diff --git a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
index 45ed035..ca8dd47 100644
--- a/drivers/ide/legacy/hd.c
+++ b/drivers/ide/legacy/hd.c
@@ -627,13 +627,13 @@ #ifdef DEBUG
 		cyl, head, sec, nsect, req->buffer);
 #endif
 	if (blk_fs_request(req)) {
-		switch (rq_data_dir(req)) {
-		case READ:
+		switch (rq_dma_dir(req)) {
+		case DMA_FROM_DEVICE:
 			hd_out(disk,nsect,sec,head,cyl,WIN_READ,&read_intr);
 			if (reset)
 				goto repeat;
 			break;
-		case WRITE:
+		case DMA_TO_DEVICE:
 			hd_out(disk,nsect,sec,head,cyl,WIN_WRITE,&write_intr);
 			if (reset)
 				goto repeat;
diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
index c7854ea..337defc 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -259,10 +259,7 @@ static int auide_build_sglist(ide_drive_

 	ide_map_sg(drive, rq);

-	if (rq_data_dir(rq) == READ)
-		hwif->sg_dma_direction = DMA_FROM_DEVICE;
-	else
-		hwif->sg_dma_direction = DMA_TO_DEVICE;
+	hwif->sg_dma_direction = rq_dma_dir(rq);

 	return dma_map_sg(ahwif->dev, sg, hwif->sg_nents,
 			  hwif->sg_dma_direction);
@@ -278,7 +275,7 @@ static int auide_build_dmatable(ide_driv
 	_auide_hwif *ahwif = (_auide_hwif*)hwif->hwif_data;
 	struct scatterlist *sg;

-	iswrite = (rq_data_dir(rq) == WRITE);
+	iswrite = (rq_uni_write_dir(rq) == WRITE);
 	/* Save for interrupt context */
 	ahwif->drive = drive;

diff --git a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
index 89109be..34a8895 100644
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -567,7 +567,7 @@ no_dma_set:
 static int ali15x3_dma_setup(ide_drive_t *drive)
 {
 	if (m5229_revision < 0xC2 && drive->media != ide_disk) {
-		if (rq_data_dir(drive->hwif->hwgroup->rq))
+		if (rq_uni_write_dir(drive->hwif->hwgroup->rq))
 			return 1;	/* try PIO instead of DMA */
 	}
 	return ide_dma_setup(drive);
diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index 08119da..f5d9dda 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -915,7 +915,7 @@ static void hpt3xxn_set_clock(ide_hwif_t
 static void hpt3xxn_rw_disk(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 wantclock		= rq_data_dir(rq) ? 0x23 : 0x21;
+	u8 wantclock		= rq_uni_write_dir(rq) ? 0x23 : 0x21;

 	hpt3xxn_set_clock(hwif, wantclock);
 }
diff --git a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
index 184cdac..fcfd950 100644
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -394,7 +394,7 @@ static void pdc202xx_old_ide_dma_start(i

 		hwif->OUTB(clock|(hwif->channel ? 0x08 : 0x02), high_16+0x11);
 		word_count = (rq->nr_sectors << 8);
-		word_count = (rq_data_dir(rq) == READ) ?
+		word_count = (rq_uni_write_dir(rq) == READ) ?
 					word_count | 0x05000000 :
 					word_count | 0x06000000;
 		hwif->OUTL(word_count, atapi_reg);
diff --git a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
index cfad09a..c512d72 100644
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -564,7 +564,7 @@ static int sgiioc4_ide_dma_setup(ide_dri
 	unsigned int count = 0;
 	int ddir;

-	if (rq_data_dir(rq))
+	if (rq_uni_write_dir(rq))
 		ddir = PCI_DMA_TODEVICE;
 	else
 		ddir = PCI_DMA_FROMDEVICE;
@@ -575,7 +575,7 @@ static int sgiioc4_ide_dma_setup(ide_dri
 		return 1;
 	}

-	if (rq_data_dir(rq))
+	if (rq_uni_write_dir(rq))
 		/* Writes TO the IOC4 FROM Main Memory */
 		ddir = IOC4_DMA_READ;
 	else
diff --git a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
index 2a28252..0afd189 100644
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -194,7 +194,7 @@ static int trm290_ide_dma_setup(ide_driv
 	struct request *rq = hwif->hwgroup->rq;
 	unsigned int count, rw;

-	if (rq_data_dir(rq)) {
+	if (rq_uni_write_dir(rq)) {
 #ifdef TRM290_NO_DMA_WRITES
 		/* always use PIO for writes */
 		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 91c5344..1d9de5e 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1582,7 +1582,7 @@ pmac_ide_build_dmatable(ide_drive_t *dri
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
 	volatile struct dbdma_regs __iomem *dma = pmif->dma_regs;
 	struct scatterlist *sg;
-	int wr = (rq_data_dir(rq) == WRITE);
+	int wr = (rq_uni_write_dir(rq) == WRITE);

 	/* DMA table is already aligned */
 	table = (struct dbdma_cmd *) pmif->dma_table_cpu;
@@ -1859,7 +1859,7 @@ pmac_ide_dma_setup(ide_drive_t *drive)

 	/* Apple adds 60ns to wrDataSetup on reads */
 	if (ata4 && (pmif->timings[unit] & TR_66_UDMA_EN)) {
-		writel(pmif->timings[unit] + (!rq_data_dir(rq) ? 0x00800000UL : 0),
+		writel(pmif->timings[unit] + (!rq_uni_write_dir(rq) ? 0x00800000UL : 0),
 			PMAC_IDE_REG(IDE_TIMING_CONFIG));
 		(void)readl(PMAC_IDE_REG(IDE_TIMING_CONFIG));
 	}
diff --git a/drivers/md/dm-emc.c b/drivers/md/dm-emc.c
index 265c467..347c2b6 100644
--- a/drivers/md/dm-emc.c
+++ b/drivers/md/dm-emc.c
@@ -103,7 +103,7 @@ static struct request *get_failover_req(
 	struct request_queue *q = bdev_get_queue(bdev);

 	/* FIXME: Figure out why it fails with GFP_ATOMIC. */
-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+	rq = blk_get_request(q, DMA_TO_DEVICE, __GFP_WAIT);
 	if (!rq) {
 		DMERR("get_failover_req: blk_get_request failed");
 		return NULL;
diff --git a/drivers/message/i2o/i2o_block.c b/drivers/message/i2o/i2o_block.c
index da9859f..432a7ff 100644
--- a/drivers/message/i2o/i2o_block.c
+++ b/drivers/message/i2o/i2o_block.c
@@ -342,7 +342,7 @@ static inline int i2o_block_sglist_alloc
 	ireq->dev = &c->pdev->dev;
 	nents = blk_rq_map_sg(ireq->req->q, ireq->req, ireq->sg_table);

-	if (rq_data_dir(ireq->req) == READ)
+	if (rq_uni_write_dir(ireq->req) == READ)
 		direction = PCI_DMA_FROMDEVICE;
 	else
 		direction = PCI_DMA_TODEVICE;
@@ -362,7 +362,7 @@ static inline void i2o_block_sglist_free
 {
 	enum dma_data_direction direction;

-	if (rq_data_dir(ireq->req) == READ)
+	if (rq_uni_write_dir(ireq->req) == READ)
 		direction = PCI_DMA_FROMDEVICE;
 	else
 		direction = PCI_DMA_TODEVICE;
@@ -789,7 +789,7 @@ static int i2o_block_transfer(struct req

 	mptr = &msg->body[0];

-	if (rq_data_dir(req) == READ) {
+	if (rq_uni_write_dir(req) == READ) {
 		cmd = I2O_CMD_BLOCK_READ << 24;

 		switch (dev->rcache) {
@@ -854,7 +854,7 @@ #ifdef CONFIG_I2O_EXT_ADAPTEC
 		 * SIMPLE_TAG
 		 * RETURN_SENSE_DATA_IN_REPLY_MESSAGE_FRAME
 		 */
-		if (rq_data_dir(req) == READ) {
+		if (rq_uni_write_dir(req) == READ) {
 			cmd[0] = READ_10;
 			scsi_flags = 0x60a0000a;
 		} else {
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index 8771357..adfd3af 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -245,7 +245,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 		brq.stop.arg = 0;
 		brq.stop.flags = MMC_RSP_R1B | MMC_CMD_AC;

-		mmc_set_data_timeout(&brq.data, card, rq_data_dir(req) != READ);
+		mmc_set_data_timeout(&brq.data, card, rq_uni_write_dir(req) != READ);

 		/*
 		 * If the host doesn't support multiple block writes, force
@@ -253,7 +253,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 		 * this rule as they support querying the number of
 		 * successfully written sectors.
 		 */
-		if (rq_data_dir(req) != READ &&
+		if (rq_uni_write_dir(req) != READ &&
 		    !(card->host->caps & MMC_CAP_MULTIWRITE) &&
 		    !mmc_card_sd(card))
 			brq.data.blocks = 1;
@@ -269,7 +269,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 			writecmd = MMC_WRITE_BLOCK;
 		}

-		if (rq_data_dir(req) == READ) {
+		if (rq_uni_write_dir(req) == READ) {
 			brq.cmd.opcode = readcmd;
 			brq.data.flags |= MMC_DATA_READ;
 		} else {
@@ -299,7 +299,7 @@ static int mmc_blk_issue_rq(struct mmc_q
 			goto cmd_err;
 		}

-		if (rq_data_dir(req) != READ) {
+		if (rq_uni_write_dir(req) != READ) {
 			do {
 				int err;

@@ -354,7 +354,7 @@ #endif
 	 * For reads we just fail the entire chunk as that should
 	 * be safe in all cases.
 	 */
- 	if (rq_data_dir(req) != READ && mmc_card_sd(card)) {
+ 	if (rq_uni_write_dir(req) != READ && mmc_card_sd(card)) {
 		u32 blocks;
 		unsigned int bytes;

@@ -368,7 +368,7 @@ #endif
 			ret = end_that_request_chunk(req, 1, bytes);
 			spin_unlock_irq(&md->lock);
 		}
-	} else if (rq_data_dir(req) != READ &&
+	} else if (rq_uni_write_dir(req) != READ &&
 		   (card->host->caps & MMC_CAP_MULTIWRITE)) {
 		spin_lock_irq(&md->lock);
 		ret = end_that_request_chunk(req, 1, brq.data.bytes_xfered);
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 178b53b..dc529e1 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -52,14 +52,14 @@ static int do_blktrans_request(struct mt
 	if (block + nsect > get_capacity(req->rq_disk))
 		return 0;

-	switch(rq_data_dir(req)) {
-	case READ:
+	switch(rq_dma_dir(req)) {
+	case DMA_FROM_DEVICE:
 		for (; nsect > 0; nsect--, block++, buf += 512)
 			if (tr->readsect(dev, block, buf))
 				return 0;
 		return 1;

-	case WRITE:
+	case DMA_TO_DEVICE:
 		if (!tr->writesect)
 			return 0;

@@ -69,7 +69,7 @@ static int do_blktrans_request(struct mt
 		return 1;

 	default:
-		printk(KERN_NOTICE "Unknown request %u\n", rq_data_dir(req));
+		printk(KERN_NOTICE "Unknown request %u\n", rq_dma_dir(req));
 		return 0;
 	}
 }
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 492b68b..419e222 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1215,7 +1215,7 @@ __dasd_process_blk_queue(struct dasd_dev
 		req = elv_next_request(queue);

 		if (device->features & DASD_FEATURE_READONLY &&
-		    rq_data_dir(req) == WRITE) {
+		    rq_write_dir(req) == WRITE) {
 			DBF_DEV_EVENT(DBF_ERR, device,
 				      "Rejecting write request %p",
 				      req);
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 53db58a..cf7228e 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -478,9 +478,9 @@ dasd_diag_build_cp(struct dasd_device *
 	unsigned char rw_cmd;
 	int i;

-	if (rq_data_dir(req) == READ)
+	if (rq_dma_dir(req) == DMA_FROM_DEVICE)
 		rw_cmd = MDSK_READ_REQ;
-	else if (rq_data_dir(req) == WRITE)
+	else if (rq_dma_dir(req) == DMA_TO_DEVICE)
 		rw_cmd = MDSK_WRITE_REQ;
 	else
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index fdaa471..9c7f938 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1147,9 +1147,9 @@ dasd_eckd_build_cp(struct dasd_device *
 	int i;

 	private = (struct dasd_eckd_private *) device->private;
-	if (rq_data_dir(req) == READ)
+	if (rq_dma_dir(req) == DMA_FROM_DEVICE)
 		cmd = DASD_ECKD_CCW_READ_MT;
-	else if (rq_data_dir(req) == WRITE)
+	else if (rq_dma_dir(req) == DMA_TO_DEVICE)
 		cmd = DASD_ECKD_CCW_WRITE_MT;
 	else
 		return ERR_PTR(-EINVAL);
@@ -1216,7 +1216,7 @@ #endif
 		if (dasd_page_cache) {
 			char *copy = kmem_cache_alloc(dasd_page_cache,
 						      GFP_DMA | __GFP_NOWARN);
-			if (copy && rq_data_dir(req) == WRITE)
+			if (copy && rq_uni_write_dir(req) == WRITE)
 				memcpy(copy + bv->bv_offset, dst, bv->bv_len);
 			if (copy)
 				dst = copy + bv->bv_offset;
@@ -1232,7 +1232,7 @@ #endif
 					rcmd |= 0x8;
 					count = dasd_eckd_cdl_reclen(recid);
 					if (count < blksize &&
-					    rq_data_dir(req) == READ)
+					    rq_uni_write_dir(req) == READ)
 						memset(dst + count, 0xe5,
 						       blksize - count);
 				}
@@ -1312,7 +1312,7 @@ dasd_eckd_free_cp(struct dasd_ccw_req *c
 				else
 					cda = (char *)((addr_t) ccw->cda);
 				if (dst != cda) {
-					if (rq_data_dir(req) == READ)
+					if (rq_uni_write_dir(req) == READ)
 						memcpy(dst, cda, bv->bv_len);
 					kmem_cache_free(dasd_page_cache,
 					    (void *)((addr_t)cda & PAGE_MASK));
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index b857fd5..878268c 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -244,9 +244,9 @@ dasd_fba_build_cp(struct dasd_device * d
 	int i;

 	private = (struct dasd_fba_private *) device->private;
-	if (rq_data_dir(req) == READ) {
+	if (rq_dma_dir(req) == DMA_FROM_DEVICE) {
 		cmd = DASD_FBA_CCW_READ;
-	} else if (rq_data_dir(req) == WRITE) {
+	} else if (rq_dma_dir(req) == DMA_TO_DEVICE) {
 		cmd = DASD_FBA_CCW_WRITE;
 	} else
 		return ERR_PTR(-EINVAL);
@@ -293,7 +293,7 @@ #endif
 		return cqr;
 	ccw = cqr->cpaddr;
 	/* First ccw is define extent. */
-	define_extent(ccw++, cqr->data, rq_data_dir(req),
+	define_extent(ccw++, cqr->data, rq_uni_write_dir(req),
 		      device->bp_block, req->sector, req->nr_sectors);
 	/* Build locate_record + read/write ccws. */
 	idaws = (unsigned long *) (cqr->data + sizeof(struct DE_fba_data));
@@ -301,7 +301,7 @@ #endif
 	/* Locate record for all blocks for smart devices. */
 	if (private->rdc_data.mode.bits.data_chain != 0) {
 		ccw[-1].flags |= CCW_FLAG_CC;
-		locate_record(ccw++, LO_data++, rq_data_dir(req), 0, count);
+		locate_record(ccw++, LO_data++, rq_uni_write_dir(req), 0, count);
 	}
 	recid = first_rec;
 	rq_for_each_bio(bio, req) bio_for_each_segment(bv, bio, i) {
@@ -309,7 +309,7 @@ #endif
 		if (dasd_page_cache) {
 			char *copy = kmem_cache_alloc(dasd_page_cache,
 						      GFP_DMA | __GFP_NOWARN);
-			if (copy && rq_data_dir(req) == WRITE)
+			if (copy && rq_uni_write_dir(req) == WRITE)
 				memcpy(copy + bv->bv_offset, dst, bv->bv_len);
 			if (copy)
 				dst = copy + bv->bv_offset;
@@ -319,7 +319,7 @@ #endif
 			if (private->rdc_data.mode.bits.data_chain == 0) {
 				ccw[-1].flags |= CCW_FLAG_CC;
 				locate_record(ccw, LO_data++,
-					      rq_data_dir(req),
+					      rq_uni_write_dir(req),
 					      recid - first_rec, 1);
 				ccw->flags = CCW_FLAG_CC;
 				ccw++;
@@ -386,7 +386,7 @@ dasd_fba_free_cp(struct dasd_ccw_req *cq
 				else
 					cda = (char *)((addr_t) ccw->cda);
 				if (dst != cda) {
-					if (rq_data_dir(req) == READ)
+					if (rq_uni_write_dir(req) == READ)
 						memcpy(dst, cda, bv->bv_len);
 					kmem_cache_free(dasd_page_cache,
 					    (void *)((addr_t)cda & PAGE_MASK));
diff --git a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
index c8a89b3..276374d 100644
--- a/drivers/s390/char/tape_block.c
+++ b/drivers/s390/char/tape_block.c
@@ -174,7 +174,7 @@ tapeblock_requeue(struct work_struct *wo
 		nr_queued < TAPEBLOCK_MIN_REQUEUE
 	) {
 		req = elv_next_request(queue);
-		if (rq_data_dir(req) == WRITE) {
+		if (rq_write_dir(req) == WRITE) {
 			DBF_EVENT(1, "TBLOCK: Rejecting write request\n");
 			blkdev_dequeue_request(req);
 			tapeblock_end_request(req, 0);
diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index 14631ac..0653822 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -199,7 +199,7 @@ static void jsfd_do_request(request_queu
 			continue;
 		}

-		if (rq_data_dir(req) != READ) {
+		if (rq_write_dir(req) != READ) {
 			printk(KERN_ERR "jsfd: write\n");
 			end_request(req, 0);
 			continue;
diff --git a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
index 7d1fec6..a0b72f5 100644
--- a/drivers/scsi/aic7xxx_old.c
+++ b/drivers/scsi/aic7xxx_old.c
@@ -2850,7 +2850,7 @@ #endif
     int x, i;


-    if (rq_data_dir(cmd->request) == WRITE)
+    if (rq_write_dir(cmd->request) == WRITE)
     {
       aic_dev->w_total++;
       ptr = aic_dev->w_bins;
@@ -3859,7 +3859,7 @@ aic7xxx_calculate_residual (struct aic7x
       {
         printk(INFO_LEAD "Underflow - Wanted %u, %s %u, residual SG "
           "count %d.\n", p->host_no, CTL_OF_SCB(scb), cmd->underflow,
-          (rq_data_dir(cmd->request) == WRITE) ? "wrote" : "read", actual,
+          (rq_write_dir(cmd->request) == WRITE) ? "wrote" : "read", actual,
           hscb->residual_SG_segment_count);
         printk(INFO_LEAD "status 0x%x.\n", p->host_no, CTL_OF_SCB(scb),
           hscb->target_status);
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 2ecb6ff..4f2b29a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1662,6 +1662,7 @@ scsi_reset_provider(struct scsi_device *
 	unsigned long flags;
 	int rtn;

+	blk_rq_init_unqueued_req(&req);
 	scmd->request = &req;
 	memset(&scmd->eh_timeout, 0, sizeof(scmd->eh_timeout));

@@ -1674,7 +1675,7 @@ scsi_reset_provider(struct scsi_device *

 	scmd->cmd_len			= 0;

-	scmd->sc_data_direction		= DMA_BIDIRECTIONAL;
+	scmd->sc_data_direction		= DMA_NONE;

 	init_timer(&scmd->eh_timeout);

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f02f48a..433d269 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -181,10 +181,9 @@ int scsi_execute(struct scsi_device *sde
 		 unsigned char *sense, int timeout, int retries, int flags)
 {
 	struct request *req;
-	int write = (data_direction == DMA_TO_DEVICE);
 	int ret = DRIVER_ERROR << 24;

-	req = blk_get_request(sdev->request_queue, write, __GFP_WAIT);
+	req = blk_get_request(sdev->request_queue, data_direction, __GFP_WAIT);

 	if (bufflen &&	blk_rq_map_kern(sdev->request_queue, req,
 					buffer, bufflen, __GFP_WAIT))
@@ -259,8 +258,10 @@ static int scsi_merge_bio(struct request
 	struct request_queue *q = rq->q;

 	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
-	if (rq_data_dir(rq) == WRITE)
+	if (rq_uni_write_dir(rq))
 		bio->bi_rw |= (1 << BIO_RW);
+	else
+		bio->bi_rw &= ~(1 << BIO_RW);
 	blk_queue_bounce(q, &bio);

 	if (!rq->bio)
@@ -386,14 +387,13 @@ int scsi_execute_async(struct scsi_devic
 	struct request *req;
 	struct scsi_io_context *sioc;
 	int err = 0;
-	int write = (data_direction == DMA_TO_DEVICE);

 	sioc = kmem_cache_alloc(scsi_io_context_cache, gfp);
 	if (!sioc)
 		return DRIVER_ERROR << 24;
 	memset(sioc, 0, sizeof(*sioc));

-	req = blk_get_request(sdev->request_queue, write, gfp);
+	req = blk_get_request(sdev->request_queue, data_direction, gfp);
 	if (!req)
 		goto free_sense;
 	req->cmd_type = REQ_TYPE_BLOCK_PC;
@@ -1120,17 +1120,13 @@ static int scsi_setup_blk_pc_cmnd(struct
 		cmd->request_buffer = NULL;
 		cmd->use_sg = 0;
 		req->buffer = NULL;
+		req->data_dir = DMA_NONE;
 	}

 	BUILD_BUG_ON(sizeof(req->cmd) > sizeof(cmd->cmnd));
 	memcpy(cmd->cmnd, req->cmd, sizeof(cmd->cmnd));
 	cmd->cmd_len = req->cmd_len;
-	if (!req->data_len)
-		cmd->sc_data_direction = DMA_NONE;
-	else if (rq_data_dir(req) == WRITE)
-		cmd->sc_data_direction = DMA_TO_DEVICE;
-	else
-		cmd->sc_data_direction = DMA_FROM_DEVICE;
+	cmd->sc_data_direction = rq_dma_dir(req);
 	
 	cmd->transfersize = req->data_len;
 	cmd->allowed = req->retries;
diff --git a/drivers/scsi/scsi_tgt_lib.c b/drivers/scsi/scsi_tgt_lib.c
index d402aff..05fce08 100644
--- a/drivers/scsi/scsi_tgt_lib.c
+++ b/drivers/scsi/scsi_tgt_lib.c
@@ -80,7 +80,6 @@ struct scsi_cmnd *scsi_host_get_command(
 					enum dma_data_direction data_dir,
 					gfp_t gfp_mask)
 {
-	int write = (data_dir == DMA_TO_DEVICE);
 	struct request *rq;
 	struct scsi_cmnd *cmd;
 	struct scsi_tgt_cmd *tcmd;
@@ -93,7 +92,7 @@ struct scsi_cmnd *scsi_host_get_command(
 	if (!tcmd)
 		goto put_dev;

-	rq = blk_get_request(shost->uspace_req_q, write, gfp_mask);
+	rq = blk_get_request(shost->uspace_req_q, data_dir, gfp_mask);
 	if (!rq)
 		goto free_tcmd;

@@ -191,17 +190,8 @@ static void scsi_tgt_cmd_destroy(struct
 		container_of(work, struct scsi_tgt_cmd, work);
 	struct scsi_cmnd *cmd = tcmd->rq->special;

-	dprintk("cmd %p %d %lu\n", cmd, cmd->sc_data_direction,
-		rq_data_dir(cmd->request));
-	/*
-	 * We fix rq->cmd_flags here since when we told bio_map_user
-	 * to write vm for WRITE commands, blk_rq_bio_prep set
-	 * rq_data_dir the flags to READ.
-	 */
-	if (cmd->sc_data_direction == DMA_TO_DEVICE)
-		cmd->request->cmd_flags |= REQ_RW;
-	else
-		cmd->request->cmd_flags &= ~REQ_RW;
+	dprintk("cmd %p %d %d\n", cmd, cmd->sc_data_direction,
+		rq_dma_dir(cmd->request));

 	scsi_unmap_user_pages(tcmd);
 	scsi_host_put_command(scsi_tgt_cmd_to_host(cmd), cmd);
@@ -346,7 +336,7 @@ static void scsi_tgt_cmd_done(struct scs
 {
 	struct scsi_tgt_cmd *tcmd = cmd->request->end_io_data;

-	dprintk("cmd %p %lu\n", cmd, rq_data_dir(cmd->request));
+	dprintk("cmd %p %d\n", cmd, rq_dma_dir(cmd->request));

 	scsi_tgt_uspace_send_status(cmd, tcmd->tag);
 	queue_work(scsi_tgtd, &tcmd->work);
@@ -357,7 +347,7 @@ static int __scsi_tgt_transfer_response(
 	struct Scsi_Host *shost = scsi_tgt_cmd_to_host(cmd);
 	int err;

-	dprintk("cmd %p %lu\n", cmd, rq_data_dir(cmd->request));
+	dprintk("cmd %p %d\n", cmd, rq_dma_dir(cmd->request));

 	err = shost->hostt->transfer_response(cmd, scsi_tgt_cmd_done);
 	switch (err) {
@@ -398,8 +388,8 @@ static int scsi_tgt_init_cmd(struct scsi

 	cmd->request_bufflen = rq->data_len;

-	dprintk("cmd %p addr %p cnt %d %lu\n", cmd, tcmd->buffer, cmd->use_sg,
-		rq_data_dir(rq));
+	dprintk("cmd %p addr %p cnt %d %d\n", cmd, tcmd->buffer, cmd->use_sg,
+		rq_dma_dir(rq));
 	count = blk_rq_map_sg(rq->q, rq, cmd->request_buffer);
 	if (likely(count <= cmd->use_sg)) {
 		cmd->use_sg = count;
@@ -617,8 +607,8 @@ int scsi_tgt_kspace_exec(int host_no, u6
 	}
 	cmd = rq->special;

-	dprintk("cmd %p result %d len %d bufflen %u %lu %x\n", cmd,
-		result, len, cmd->request_bufflen, rq_data_dir(rq), cmd->cmnd[0]);
+	dprintk("cmd %p result %d len %d bufflen %u %d %x\n", cmd,
+		result, len, cmd->request_bufflen, rq_dma_dir(rq), cmd->cmnd[0]);

 	if (result == TASK_ABORTED) {
 		scsi_tgt_abort_cmd(shost, cmd);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 978bfc1..a2012e6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -433,23 +433,25 @@ static int sd_init_command(struct scsi_c
 			this_count = this_count >> 3;
 		}
 	}
-	if (rq_data_dir(rq) == WRITE) {
+
+	SCpnt->sc_data_direction = rq_dma_dir(rq);
+	switch (SCpnt->sc_data_direction) {
+	case DMA_TO_DEVICE:
 		if (!sdp->writeable) {
 			return 0;
 		}
 		SCpnt->cmnd[0] = WRITE_6;
-		SCpnt->sc_data_direction = DMA_TO_DEVICE;
-	} else if (rq_data_dir(rq) == READ) {
+		break;
+	case DMA_FROM_DEVICE:
 		SCpnt->cmnd[0] = READ_6;
-		SCpnt->sc_data_direction = DMA_FROM_DEVICE;
-	} else {
-		printk(KERN_ERR "sd: Unknown command %x\n", rq->cmd_flags);
+		break;
+	default:
+		printk(KERN_ERR "sd: Unknown command %x data_dir %d\n", rq->cmd_flags ,rq_dma_dir(rq));
 		return 0;
 	}

 	SCSI_LOG_HLQUEUE(2, printk("%s : %s %d/%ld 512 byte blocks.\n",
-		disk->disk_name, (rq_data_dir(rq) == WRITE) ?
-		"writing" : "reading", this_count, rq->nr_sectors));
+		disk->disk_name, dma_dir_to_string(rq->data_dir), this_count, rq->nr_sectors));

 	SCpnt->cmnd[1] = 0;
 	
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 81e3bc7..46a1f7e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -733,8 +733,6 @@ sg_common_write(Sg_fd * sfp, Sg_request
 		data_dir = DMA_TO_DEVICE;
 		break;
 	case SG_DXFER_UNKNOWN:
-		data_dir = DMA_BIDIRECTIONAL;
-		break;
 	default:
 		data_dir = DMA_NONE;
 		break;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index fae6e95..59ac89d 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -335,16 +335,18 @@ static int sr_init_command(struct scsi_c
 		return 0;
 	}

-	if (rq_data_dir(SCpnt->request) == WRITE) {
+	SCpnt->sc_data_direction = rq_dma_dir(SCpnt->request);
+	switch (SCpnt->sc_data_direction) {
+	case DMA_TO_DEVICE:
 		if (!cd->device->writeable)
 			return 0;
 		SCpnt->cmnd[0] = WRITE_10;
-		SCpnt->sc_data_direction = DMA_TO_DEVICE;
  	 	cd->cdi.media_written = 1;
-	} else if (rq_data_dir(SCpnt->request) == READ) {
+		break;
+	case DMA_FROM_DEVICE:
 		SCpnt->cmnd[0] = READ_10;
-		SCpnt->sc_data_direction = DMA_FROM_DEVICE;
-	} else {
+		break;
+	default:
 		blk_dump_rq_flags(SCpnt->request, "Unknown sr command");
 		return 0;
 	}
@@ -378,8 +380,7 @@ static int sr_init_command(struct scsi_c

 	SCSI_LOG_HLQUEUE(2, printk("%s : %s %d/%ld 512 byte blocks.\n",
 				cd->cdi.name,
-				(rq_data_dir(SCpnt->request) == WRITE) ?
-					"writing" : "reading",
+				dma_dir_to_string(SCpnt->request->data_dir),
 				this_count, SCpnt->request->nr_sectors));

 	SCpnt->cmnd[1] = 0;
diff --git a/drivers/scsi/sun3_NCR5380.c b/drivers/scsi/sun3_NCR5380.c
index 98e3fe1..35d05a2 100644
--- a/drivers/scsi/sun3_NCR5380.c
+++ b/drivers/scsi/sun3_NCR5380.c
@@ -1206,7 +1206,7 @@ static void NCR5380_dma_complete( struct
 	       HOSTNO, NCR5380_read(BUS_AND_STATUS_REG),
 	       NCR5380_read(STATUS_REG));

-    if((sun3scsi_dma_finish(rq_data_dir(hostdata->connected->request)))) {
+    if((sun3scsi_dma_finish(rq_uni_write_dir(hostdata->connected->request)))) {
 	    printk("scsi%d: overrun in UDC counter -- not prepared to deal with this!\n", HOSTNO);
 	    printk("please e-mail sammy@sammy.net with a description of how this\n");
 	    printk("error was produced.\n");
@@ -2024,7 +2024,7 @@ #ifdef REAL_DMA
 		{
 			if(blk_fs_request(cmd->request)) {
 				sun3scsi_dma_setup(d, count,
-						   rq_data_dir(cmd->request));
+						   rq_uni_write_dir(cmd->request));
 				sun3_dma_setup_done = cmd;
 			}
 		}
@@ -2636,7 +2636,7 @@ #ifdef REAL_DMA
 	    /* setup this command for dma if not already */
 	    if((count > SUN3_DMA_MINSIZE) && (sun3_dma_setup_done != tmp))
 	    {
-		    sun3scsi_dma_setup(d, count, rq_data_dir(tmp->request));
+		    sun3scsi_dma_setup(d, count, rq_uni_write_dir(tmp->request));
 		    sun3_dma_setup_done = tmp;
 	    }
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 36a6eac..c592900 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -14,6 +14,7 @@ #include <linux/mempool.h>
 #include <linux/bio.h>
 #include <linux/module.h>
 #include <linux/stringify.h>
+#include <linux/dma-mapping.h>

 #include <asm/scatterlist.h>

@@ -178,10 +179,9 @@ enum {
 };

 /*
- * request type modified bits. first three bits match BIO_RW* bits, important
+ * request type modified bits.
  */
 enum rq_flag_bits {
-	__REQ_RW,		/* not set, read. set, write */
 	__REQ_FAILFAST,		/* no low level driver retries */
 	__REQ_SORTED,		/* elevator knows about this request */
 	__REQ_SOFTBARRIER,	/* may not be passed by ioscheduler */
@@ -200,9 +200,10 @@ enum rq_flag_bits {
 	__REQ_ALLOCED,		/* request came from our alloc pool */
 	__REQ_RW_META,		/* metadata io request */
 	__REQ_NR_BITS,		/* stops here */
+	__REQ_BIDI,		/* FIXME: Will be removed. It is only for some quirks checking */
 };

-#define REQ_RW		(1 << __REQ_RW)
+#define REQ_BIDI	(1 << __REQ_BIDI)
 #define REQ_FAILFAST	(1 << __REQ_FAILFAST)
 #define REQ_SORTED	(1 << __REQ_SORTED)
 #define REQ_SOFTBARRIER	(1 << __REQ_SOFTBARRIER)
@@ -233,6 +234,7 @@ struct request {
 	request_queue_t *q;

 	unsigned int cmd_flags;
+	enum dma_data_direction data_dir;
 	enum rq_cmd_type_bits cmd_type;

 	/* Maintain bio traversal state for part by part I/O submission.
@@ -546,12 +548,30 @@ #define blk_fua_rq(rq)		((rq)->cmd_flags

 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)

-#define rq_data_dir(rq)		((rq)->cmd_flags & 1)
+#define rq_dma_dir(rq)		((rq)->data_dir)
+#define rq_uni_dir(rq)		dma_uni_dir((rq)->data_dir)
+
+static inline int rq_bidi_dir(struct request* rq)
+{
+	/* FIXME: the (req->cmd_flags & REQ_BIDI) will be removed once all the warnings go away */
+	return (rq_dma_dir(rq) == DMA_BIDIRECTIONAL) && (rq->cmd_flags & REQ_BIDI);
+}
+
+static inline int rq_write_dir(struct request* rq)
+{
+	return dma_write_dir(rq->data_dir) ? WRITE : READ;
+}
+
+static inline int rq_uni_write_dir(struct request* rq)
+{
+	WARN_ON(!dma_uni_dir(rq->data_dir));
+	return (rq->data_dir == DMA_TO_DEVICE) ? WRITE : READ;
+}

 /*
  * We regard a request as sync, if it's a READ or a SYNC write.
  */
-#define rq_is_sync(rq)		(rq_data_dir((rq)) == READ || (rq)->cmd_flags & REQ_RW_SYNC)
+#define rq_is_sync(rq)		(rq_dma_dir((rq)) == DMA_FROM_DEVICE || (rq)->cmd_flags & REQ_RW_SYNC)
 #define rq_is_meta(rq)		((rq)->cmd_flags & REQ_RW_META)

 static inline int blk_queue_full(struct request_queue *q, int rw)
@@ -631,7 +651,8 @@ extern void generic_make_request(struct
 extern void blk_put_request(struct request *);
 extern void __blk_put_request(request_queue_t *, struct request *);
 extern void blk_end_sync_rq(struct request *rq, int error);
-extern struct request *blk_get_request(request_queue_t *, int, gfp_t);
+extern struct request *blk_get_request(request_queue_t *, enum dma_data_direction, gfp_t);
+extern void blk_rq_init_unqueued_req(struct request *);
 extern void blk_insert_request(request_queue_t *, struct request *, int, void *);
 extern void blk_requeue_request(request_queue_t *, struct request *);
 extern void blk_plug_device(request_queue_t *);
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 3680ff9..ef6ddd7 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -161,7 +161,13 @@ static inline void blk_add_trace_rq(stru
 				    u32 what)
 {
 	struct blk_trace *bt = q->blk_trace;
-	int rw = rq->cmd_flags & 0x03;
+	/* blktrace.c prints them according to bio flags */
+	int rw = (((rq_write_dir(rq) == WRITE) << BIO_RW) |
+	          (((rq->cmd_flags & (REQ_SOFTBARRIER|REQ_HARDBARRIER)) != 0) <<
+	           BIO_RW_BARRIER) |
+	          (((rq->cmd_flags & REQ_FAILFAST) != 0) << BIO_RW_FAILFAST) |
+	          (((rq->cmd_flags & REQ_RW_SYNC) != 0) << BIO_RW_SYNC) |
+	          (((rq->cmd_flags & REQ_RW_META) != 0) << BIO_RW_META));

 	if (likely(!bt))
 		return;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ff203c4..abbca7b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -13,6 +13,28 @@ enum dma_data_direction {
 	DMA_NONE = 3,
 };

+static inline int dma_write_dir(enum dma_data_direction dir)
+{
+	return (dir == DMA_TO_DEVICE) || (dir == DMA_BIDIRECTIONAL);
+}
+
+static inline int dma_uni_dir(enum dma_data_direction dir)
+{
+	return (dir == DMA_TO_DEVICE) || (dir == DMA_FROM_DEVICE) ||
+	       (dir == DMA_NONE);
+}
+
+static inline char* dma_dir_to_string(enum dma_data_direction dir)
+{
+	switch(dir){
+	case DMA_BIDIRECTIONAL:   return "bidirectional";
+	case DMA_TO_DEVICE:       return "writing";
+	case DMA_FROM_DEVICE:     return "reading";
+	case DMA_NONE:            return "no-data";
+	default:                  return "invalid";
+	}
+}
+
 #define DMA_64BIT_MASK	0xffffffffffffffffULL
 #define DMA_48BIT_MASK	0x0000ffffffffffffULL
 #define DMA_40BIT_MASK	0x000000ffffffffffULL
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index e88fcbc..c947f71 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -20,7 +20,7 @@ typedef void (elevator_add_req_fn) (requ
 typedef int (elevator_queue_empty_fn) (request_queue_t *);
 typedef struct request *(elevator_request_list_fn) (request_queue_t *, struct request *);
 typedef void (elevator_completed_req_fn) (request_queue_t *, struct request *);
-typedef int (elevator_may_queue_fn) (request_queue_t *, int);
+typedef int (elevator_may_queue_fn) (request_queue_t *, int, int);

 typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, gfp_t);
 typedef void (elevator_put_req_fn) (struct request *);
@@ -111,7 +111,7 @@ extern struct request *elv_former_reques
 extern struct request *elv_latter_request(request_queue_t *, struct request *);
 extern int elv_register_queue(request_queue_t *q);
 extern void elv_unregister_queue(request_queue_t *q);
-extern int elv_may_queue(request_queue_t *, int);
+extern int elv_may_queue(request_queue_t *, int, int);
 extern void elv_completed_request(request_queue_t *, struct request *);
 extern int elv_set_request(request_queue_t *, struct request *, gfp_t);
 extern void elv_put_request(request_queue_t *, struct request *);


