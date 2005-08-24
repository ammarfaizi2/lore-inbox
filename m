Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVHXJ2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVHXJ2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 05:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVHXJ2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 05:28:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7850 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750821AbVHXJ2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 05:28:40 -0400
Date: Wed, 24 Aug 2005 11:28:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050824092838.GB28272@suse.de>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20050824072501.GA27992@suse.de>
X-IMAPbase: 1124875140 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 24 2005, Jens Axboe wrote:
> On Wed, Aug 24 2005, Nathan Scott wrote:
> > On Wed, Aug 24, 2005 at 09:08:10AM +0200, Jens Axboe wrote:
> > > ...
> > > This isn't msec precision, it's usec. sched_clock() is in ns! I already
> > > decided that msec is too coarse, but usec _should_ be enough.
> > 
> > Right you are (I was thinking m-for-micro, not m-for-milli in my head ;)
> > - but still, there doesn't seem to be any reason for that divide-by-1000
> > and reducing the precision in the kernel rather than in userspace, does
> > there?  Doing it the other way means you wont ever have to worry about
> > whether it is/isn't sufficient precision for all possible block devices,
> > and the precision the tool displays will just be a userspace decision.
> 
> I was just worried about wrapping of ->time, but I did make it a 64-bit
> unit. So I guess we could go to nsec granularity, there should be plenty
> [*] of space. I'll change that too, I'll post an update version later.

Ok, updated version. The tool at:

http://www.kernel.org/pub/linux/kernel/people/axboe/tools/blktrace.c

has been updated as well, the protocol version was increased to
accomodate the trace structure changes.

Changes:

- Include full nsec resolution in ->time
- Bump ->pid to full 32-bit
- Include barrier and sync request options
- Move requeue to seperate trace category

Patch attached is against 2.6.13-rc6-mm2. Still a good idea to apply the
relayfs read update from the previous mail [*] as well.

[*] http://marc.theaimsgroup.com/?l=linux-kernel&m=112480046405961&w=2

-- 
Jens Axboe


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="blk-trace-2.6.13-rc6-mm2-B1"

diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/Kconfig linux-2.6.13-rc6-mm2/drivers/block/Kconfig
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/Kconfig	2005-08-24 13:17:28.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/Kconfig	2005-08-24 11:52:14.000000000 +0200
@@ -419,6 +419,14 @@ config LBD
 	  your machine, or if you want to have a raid or loopback device
 	  bigger than 2TB.  Otherwise say N.
 
+config BLK_DEV_IO_TRACE
+	bool "Support for tracing block io actions"
+	select RELAYFS
+	help
+	  Say Y here, if you want to be able to trace the block layer actions
+	  on a given queue.
+
+
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
 	depends on !UML
diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/Makefile linux-2.6.13-rc6-mm2/drivers/block/Makefile
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/Makefile	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/Makefile	2005-08-24 11:52:14.000000000 +0200
@@ -45,3 +45,5 @@ obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
 obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
 
+obj-$(CONFIG_BLK_DEV_IO_TRACE)	+= blktrace.o
+
diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/blktrace.c linux-2.6.13-rc6-mm2/drivers/block/blktrace.c
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/blktrace.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-rc6-mm2/drivers/block/blktrace.c	2005-08-24 13:22:11.000000000 +0200
@@ -0,0 +1,124 @@
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/blktrace.h>
+#include <asm/uaccess.h>
+
+void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
+		     int rw, u32 what, int error, int pdu_len, char *pdu_data)
+{
+	struct blk_io_trace t;
+	unsigned long flags;
+
+	if (rw & (1 << BIO_RW_BARRIER))
+		what |= BLK_TC_ACT(BLK_TC_BARRIER);
+	if (rw & (1 << BIO_RW_SYNC))
+		what |= BLK_TC_ACT(BLK_TC_SYNC);
+
+	if (rw & WRITE)
+		what |= BLK_TC_ACT(BLK_TC_WRITE);
+	else
+		what |= BLK_TC_ACT(BLK_TC_READ);
+		
+	if (((bt->act_mask << BLK_TC_SHIFT) & what) == 0)
+		return;
+
+	t.magic		= BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+	t.sequence	= atomic_add_return(1, &bt->sequence);
+	t.time		= sched_clock();
+	t.sector	= sector;
+	t.bytes		= bytes;
+	t.action	= what;
+	t.pid		= current->pid;
+	t.error		= error;
+	t.pdu_len	= pdu_len;
+
+	local_irq_save(flags);
+	__relay_write(bt->rchan, &t, sizeof(t));
+	if (pdu_len)
+		__relay_write(bt->rchan, pdu_data, pdu_len);
+	local_irq_restore(flags);
+}
+
+int blk_stop_trace(struct block_device *bdev)
+{
+	request_queue_t *q = bdev_get_queue(bdev);
+	struct blk_trace *bt = NULL;
+	int ret = -EINVAL;
+
+	if (!q)
+		return -ENXIO;
+
+	down(&bdev->bd_sem);
+
+	spin_lock_irq(q->queue_lock);
+	if (q->blk_trace) {
+		bt = q->blk_trace;
+		q->blk_trace = NULL;
+		ret = 0;
+	}
+	spin_unlock_irq(q->queue_lock);
+
+	up(&bdev->bd_sem);
+
+	if (bt) {
+		relay_close(bt->rchan);
+		kfree(bt);
+	}
+
+	return ret;
+}
+
+int blk_start_trace(struct block_device *bdev, char __user *arg)
+{
+	request_queue_t *q = bdev_get_queue(bdev);
+	struct blk_user_trace_setup buts;
+	struct blk_trace *bt;
+	char b[BDEVNAME_SIZE];
+	int ret = 0;
+
+	if (!q)
+		return -ENXIO;
+
+	if (copy_from_user(&buts, arg, sizeof(buts)))
+		return -EFAULT;
+
+	if (!buts.buf_size || !buts.buf_nr)
+		return -EINVAL;
+
+	strcpy(buts.name, bdevname(bdev, b));
+
+	if (copy_to_user(arg, &buts, sizeof(buts)))
+		return -EFAULT;
+
+	down(&bdev->bd_sem);
+	ret = -EBUSY;
+	if (q->blk_trace)
+		goto err;
+
+	ret = -ENOMEM;
+	bt = kmalloc(sizeof(*bt), GFP_KERNEL);
+	if (!bt)
+		goto err;
+
+	atomic_set(&bt->sequence, 0);
+
+	bt->rchan = relay_open(bdevname(bdev, b), NULL, buts.buf_size,
+				buts.buf_nr, NULL);
+	ret = -EIO;
+	if (!bt->rchan)
+		goto err;
+
+	bt->act_mask = buts.act_mask;
+	if (!bt->act_mask)
+		bt->act_mask = (u16) -1;
+
+	spin_lock_irq(q->queue_lock);
+	q->blk_trace = bt;
+	spin_unlock_irq(q->queue_lock);
+	ret = 0;
+err:
+	up(&bdev->bd_sem);
+	return ret;
+}
+
diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/elevator.c linux-2.6.13-rc6-mm2/drivers/block/elevator.c
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/elevator.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/elevator.c	2005-08-24 11:52:14.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/compiler.h>
+#include <linux/blktrace.h>
 
 #include <asm/uaccess.h>
 
@@ -371,6 +372,9 @@ struct request *elv_next_request(request
 	int ret;
 
 	while ((rq = __elv_next_request(q)) != NULL) {
+
+		blk_add_trace_rq(q, rq, BLK_TA_ISSUE);
+
 		/*
 		 * just mark as started even if we don't start it, a request
 		 * that has been delayed should not be passed by new incoming
diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/ioctl.c linux-2.6.13-rc6-mm2/drivers/block/ioctl.c
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/ioctl.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/ioctl.c	2005-08-24 11:52:14.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
+#include <linux/blktrace.h>
 #include <asm/uaccess.h>
 
 static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user *arg)
@@ -188,6 +189,10 @@ static int blkdev_locked_ioctl(struct fi
 		return put_ulong(arg, bdev->bd_inode->i_size >> 9);
 	case BLKGETSIZE64:
 		return put_u64(arg, bdev->bd_inode->i_size);
+	case BLKSTARTTRACE:
+		return blk_start_trace(bdev, (char __user *) arg);
+	case BLKSTOPTRACE:
+		return blk_stop_trace(bdev);
 	}
 	return -ENOIOCTLCMD;
 }
diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/ll_rw_blk.c linux-2.6.13-rc6-mm2/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/ll_rw_blk.c	2005-08-24 13:17:28.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/ll_rw_blk.c	2005-08-24 11:52:14.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/swap.h>
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
+#include <linux/blktrace.h>
 
 /*
  * for max sense size
@@ -1625,6 +1626,12 @@ void blk_cleanup_queue(request_queue_t *
 	if (q->queue_tags)
 		__blk_queue_free_tags(q);
 
+	if (q->blk_trace) {
+		relay_close(q->blk_trace->rchan);
+		kfree(q->blk_trace);
+		q->blk_trace = NULL;
+	}
+
 	blk_queue_ordered(q, QUEUE_ORDERED_NONE);
 
 	kmem_cache_free(requestq_cachep, q);
@@ -1971,6 +1978,8 @@ rq_starved:
 	
 	rq_init(q, rq);
 	rq->rl = rl;
+
+	blk_add_trace_generic(q, bio, rw, BLK_TA_GETRQ);
 out:
 	return rq;
 }
@@ -1999,6 +2008,8 @@ static struct request *get_request_wait(
 		if (!rq) {
 			struct io_context *ioc;
 
+			blk_add_trace_generic(q, bio, rw, BLK_TA_SLEEPRQ);
+
 			__generic_unplug_device(q);
 			spin_unlock_irq(q->queue_lock);
 			io_schedule();
@@ -2052,6 +2063,8 @@ EXPORT_SYMBOL(blk_get_request);
  */
 void blk_requeue_request(request_queue_t *q, struct request *rq)
 {
+	blk_add_trace_rq(q, rq, BLK_TA_REQUEUE);
+
 	if (blk_rq_tagged(rq))
 		blk_queue_end_tag(q, rq);
 
@@ -2665,6 +2678,8 @@ static int __make_request(request_queue_
 			if (!q->back_merge_fn(q, req, bio))
 				break;
 
+			blk_add_trace_bio(q, bio, BLK_TA_BACKMERGE);
+
 			req->biotail->bi_next = bio;
 			req->biotail = bio;
 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
@@ -2680,6 +2695,8 @@ static int __make_request(request_queue_
 			if (!q->front_merge_fn(q, req, bio))
 				break;
 
+			blk_add_trace_bio(q, bio, BLK_TA_FRONTMERGE);
+
 			bio->bi_next = req->bio;
 			req->bio = bio;
 
@@ -2705,6 +2722,8 @@ static int __make_request(request_queue_
 	}
 
 get_rq:
+	blk_add_trace_bio(q, bio, BLK_TA_QUEUE);
+
 	/*
 	 * Grab a free request. This is might sleep but can not fail.
 	 * Returns with the queue unlocked.
@@ -2981,6 +3000,10 @@ end_io:
 		blk_partition_remap(bio);
 
 		ret = q->make_request_fn(q, bio);
+
+		if (ret)
+			blk_add_trace_bio(q, bio, BLK_TA_QUEUE);
+
 	} while (ret);
 }
 
@@ -3099,6 +3122,8 @@ static int __end_that_request_first(stru
 	int total_bytes, bio_nbytes, error, next_idx = 0;
 	struct bio *bio;
 
+	blk_add_trace_rq(req->q, req, BLK_TA_COMPLETE);
+
 	/*
 	 * extend uptodate bool to allow < 0 value to be direct io error
 	 */
diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/blkdev.h linux-2.6.13-rc6-mm2/include/linux/blkdev.h
--- /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/blkdev.h	2005-08-24 13:17:35.000000000 +0200
+++ linux-2.6.13-rc6-mm2/include/linux/blkdev.h	2005-08-24 11:52:14.000000000 +0200
@@ -22,6 +22,7 @@ typedef struct request_queue request_que
 struct elevator_queue;
 typedef struct elevator_queue elevator_t;
 struct request_pm_state;
+struct blk_trace;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -412,6 +413,8 @@ struct request_queue
 	 */
 	struct request		*flush_rq;
 	unsigned char		ordered;
+
+	struct blk_trace	*blk_trace;
 };
 
 enum {
diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/blktrace.h linux-2.6.13-rc6-mm2/include/linux/blktrace.h
--- /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/blktrace.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-rc6-mm2/include/linux/blktrace.h	2005-08-24 13:22:24.000000000 +0200
@@ -0,0 +1,145 @@
+#ifndef BLKTRACE_H
+#define BLKTRACE_H
+
+#include <linux/config.h>
+#include <linux/blkdev.h>
+#include <linux/relayfs_fs.h>
+
+/*
+ * Trace categories
+ */
+enum {
+	BLK_TC_READ	= 1 << 0,	/* reads */
+	BLK_TC_WRITE	= 1 << 1,	/* writes */
+	BLK_TC_BARRIER	= 1 << 2,	/* barrier */
+	BLK_TC_SYNC	= 1 << 3,	/* barrier */
+	BLK_TC_QUEUE	= 1 << 4,	/* queueing/merging */
+	BLK_TC_REQUEUE	= 1 << 5,	/* requeueing */
+	BLK_TC_ISSUE	= 1 << 6,	/* issue */
+	BLK_TC_COMPLETE	= 1 << 7,	/* completions */
+	BLK_TC_FS	= 1 << 8,	/* fs requests */
+	BLK_TC_PC	= 1 << 9,	/* pc requests */
+
+	BLK_TC_END	= 1 << 15,	/* only 16-bits, reminder */
+};
+
+#define BLK_TC_SHIFT		(16)
+#define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
+
+/*
+ * Basic trace actions
+ */
+enum {
+	__BLK_TA_QUEUE = 1,		/* queued */
+	__BLK_TA_BACKMERGE,		/* back merged to existing rq */
+	__BLK_TA_FRONTMERGE,		/* front merge to existing rq */
+	__BLK_TA_GETRQ,			/* allocated new request */
+	__BLK_TA_SLEEPRQ,		/* sleeping on rq allocation */
+	__BLK_TA_REQUEUE,		/* request requeued */
+	__BLK_TA_ISSUE,			/* sent to driver */
+	__BLK_TA_COMPLETE,		/* completed by driver */
+};
+
+/*
+ * Trace actions in full. Additionally, read or write is masked
+ */
+#define BLK_TA_QUEUE		(__BLK_TA_QUEUE | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_BACKMERGE	(__BLK_TA_BACKMERGE | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_FRONTMERGE	(__BLK_TA_FRONTMERGE | BLK_TC_ACT(BLK_TC_QUEUE))
+#define	BLK_TA_GETRQ		(__BLK_TA_GETRQ | BLK_TC_ACT(BLK_TC_QUEUE))
+#define	BLK_TA_SLEEPRQ		(__BLK_TA_SLEEPRQ | BLK_TC_ACT(BLK_TC_QUEUE))
+#define	BLK_TA_REQUEUE		(__BLK_TA_REQUEUE | BLK_TC_ACT(BLK_TC_REQUEUE))
+#define BLK_TA_ISSUE		(__BLK_TA_ISSUE | BLK_TC_ACT(BLK_TC_ISSUE))
+#define BLK_TA_COMPLETE		(__BLK_TA_COMPLETE| BLK_TC_ACT(BLK_TC_COMPLETE))
+
+#define BLK_IO_TRACE_MAGIC	0x65617400
+#define BLK_IO_TRACE_VERSION	0x02
+
+/*
+ * The trace itself
+ */
+struct blk_io_trace {
+	u32 magic;		/* MAGIC << 8 | version */
+	u32 sequence;		/* event number */
+	u64 time;		/* in microseconds */
+	u64 sector;		/* disk offset */
+	u32 bytes;		/* transfer length */
+	u32 action;		/* what happened */
+	u32 pid;		/* who did it */
+	u16 error;		/* completion error */
+	u16 pdu_len;		/* length of data after this trace */
+};
+
+struct blk_trace {
+	struct rchan *rchan;
+	atomic_t sequence;
+	u16 act_mask;
+};
+
+/*
+ * User setup structure passed with BLKSTARTTRACE
+ */
+struct blk_user_trace_setup {
+	char name[BDEVNAME_SIZE];	/* output */
+	u16 act_mask;			/* input */
+	u32 buf_size;			/* input */
+	u32 buf_nr;			/* input */
+};
+
+#if defined(CONFIG_BLK_DEV_IO_TRACE)
+extern int blk_start_trace(struct block_device *, char __user *);
+extern int blk_stop_trace(struct block_device *);
+extern void __blk_add_trace(struct blk_trace *, sector_t, int, int, u32, int, int, char *);
+
+static inline void blk_add_trace_rq(struct request_queue *q, struct request *rq,
+				    u32 what)
+{
+	struct blk_trace *bt = q->blk_trace;
+	int rw = rq->flags & 0x07;
+
+	if (likely(!bt))
+		return;
+
+	if (blk_pc_request(rq)) {
+		what |= BLK_TC_ACT(BLK_TC_PC);
+		__blk_add_trace(bt, 0, rq->data_len, rw, what, rq->errors, sizeof(rq->cmd), rq->cmd);
+	} else  {
+		what |= BLK_TC_ACT(BLK_TC_FS);
+		__blk_add_trace(bt, rq->hard_sector, rq->hard_nr_sectors << 9, rw, what, rq->errors, 0, NULL);
+	}
+}
+
+static inline void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
+				     u32 what)
+{
+	struct blk_trace *bt = q->blk_trace;
+
+	if (likely(!bt))
+		return;
+
+	__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio->bi_rw, what, !bio_flagged(bio, BIO_UPTODATE), 0, NULL);
+}
+
+static inline void blk_add_trace_generic(struct request_queue *q,
+					 struct bio *bio, int rw, u32 what)
+{
+	struct blk_trace *bt = q->blk_trace;
+
+	if (likely(!bt))
+		return;
+
+	if (bio)
+		blk_add_trace_bio(q, bio, what);
+	else
+		__blk_add_trace(bt, 0, 0, rw, what, 0, 0, NULL);
+}
+
+#else /* !CONFIG_BLK_DEV_IO_TRACE */
+#define blk_start_trace(bdev, arg)		(-EINVAL)
+#define blk_stop_trace(bdev)			(-EINVAL)
+#define blk_add_trace_rq(q, rq, what)		do { } while (0)
+#define blk_add_trace_bio(q, rq, what)		do { } while (0)
+#define blk_add_trace_generic(q, rq, rw, what)	do { } while (0)
+#endif /* CONFIG_BLK_DEV_IO_TRACE */
+
+#endif
diff -urpN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/fs.h linux-2.6.13-rc6-mm2/include/linux/fs.h
--- /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/fs.h	2005-08-24 13:17:35.000000000 +0200
+++ linux-2.6.13-rc6-mm2/include/linux/fs.h	2005-08-24 11:52:14.000000000 +0200
@@ -196,6 +196,8 @@ extern int dir_notify_enable;
 #define BLKBSZGET  _IOR(0x12,112,size_t)
 #define BLKBSZSET  _IOW(0x12,113,size_t)
 #define BLKGETSIZE64 _IOR(0x12,114,size_t)	/* return device size in bytes (u64 *arg) */
+#define BLKSTARTTRACE _IOWR(0x12,115,struct blk_user_trace_setup)
+#define BLKSTOPTRACE _IO(0x12,116)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */

--AqsLC8rIMeq19msA--
