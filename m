Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVHWMcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVHWMcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 08:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVHWMcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 08:32:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31134 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932150AbVHWMcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 08:32:36 -0400
Date: Tue, 23 Aug 2005 14:32:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] blk queue io tracing support
Message-ID: <20050823123235.GG16461@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This is a little something I have played with. It allows you to see
exactly what is going on in the block layer for a given queue. Currently
it can logs request queueing and building, dispatches, requeues, and
completions. I've uploaded a little silly app to do dumps here:

http://www.kernel.org/pub/linux/kernel/people/axboe/tools/blktrace.c

Sample output looks like this:

wiggum:~ # ./blktrace /dev/sda
relay name: /relay/sda0
           0  3765 Q R 192-200
           5  3765 G R
          13  3765 M R [200-208]
          15  3765 M R [208-216]
          17  3765 M R [216-224]
          18  3765 M R [224-232]
          19  3765 M R [232-240]
          20  3765 M R [240-248]
          21  3765 M R [248-256]
         154  3765 M R [256-264]
         156  3765 M R [264-272]
         157  3765 M R [272-280]
         159  3765 M R [280-288]
         160  3765 M R [288-296]
         161  3765 M R [296-304]
         162  3765 M R [304-312]
         163  3765 M R [312-320]
         164  3765 M R [320-328]
         170  3765 M R [328-336]
         171  3765 M R [336-344]
         172  3765 M R [344-352]
         173  3765 M R [352-360]
         174  3765 M R [360-368]
         175  3765 M R [368-376]
         177  3765 M R [376-384]
         178  3765 M R [384-392]
         179  3765 Q R 392-400
         180  3765 G R
         181  3765 M R [400-408]
         182  3765 M R [408-416]
         183  3765 M R [416-424]
         184  3765 M R [424-432]
         185  3765 M R [432-440]
         186  3765 M R [440-448]
         187  3765 M R [448-456]
         189  3765 M R [456-464]
         190  3765 M R [464-472]
         191  3765 M R [472-480]
         193  3765 M R [480-488]
         194  3765 M R [488-496]
         196  3765 M R [496-504]
         197  3765 M R [504-512]
         228  3765 D R 192-392
         245  3765 D R 392-512
       14049     0 C R 192-392 [0]
       14067     0 D R 392-512
       14807     0 C R 392-512 [0]
Reads:  Queued:           2,      160KiB
        Completed:        2,      160KiB
        Merges:          38
Writes: Queued:           0,        0KiB
        Completed:        0,        0KiB
        Merges:           0
Events: 47
Missed events: 0

This is a log of a dd if=/dev/sda of=/dev/null bs=64k count=2 and it
shows queueing (Q) and allocation (G) of two requests, along with the
merges (M) that happens there. Finally you see dispatch (D) and
completion (C) of them as well. When sigint is received, blktrace dumps
stats of the current run.

It will work for scsi commands as well, so you can see what is going on
when cdrecord is talking to the device (the cdb is dumped, not the
data). The final integer printed in [] after a completion is the error,
0 for correct completion.

You can register interest in various events, see blktrace.c (grep for
buts and BLKSTARTTRACE).

Patch is against 2.6.13-rc6-mm2. I'm attaching a relayfs update from Tom
Zanussi as well, which is required to handle sub-buffer wrapping
correctly. You need to apply both patches to play with this - and make
sure to enable CONFIG_BLK_DEV_IO_TRACE in your .config, of course. And
blktrace.c relies on relayfs being mounted on /relay, add something ala

none                 /relay               relayfs    defaults 0 0

to your /etc/fstab to accomplish that (or do it manually, only
mentioning it for completeness).

-- 
Jens Axboe


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="blk-trace-2.6.13-rc6-mm2-A0"

diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/blktrace.c linux-2.6.13-rc6-mm2/drivers/block/blktrace.c
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/blktrace.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-rc6-mm2/drivers/block/blktrace.c	2005-08-23 13:34:17.000000000 +0200
@@ -0,0 +1,119 @@
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
+	if (rw == WRITE)
+		what |= BLK_TC_ACT(BLK_TC_WRITE);
+	else
+		what |= BLK_TC_ACT(BLK_TC_READ);
+		
+	if (((bt->act_mask << BLK_TC_SHIFT) & what) == 0)
+		return;
+
+	t.magic		= BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+	t.sequence	= atomic_add_return(1, &bt->sequence);
+	t.time		= sched_clock() / 1000;
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
diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/elevator.c linux-2.6.13-rc6-mm2/drivers/block/elevator.c
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/elevator.c	2005-08-23 08:23:51.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/elevator.c	2005-08-23 08:24:34.000000000 +0200
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
diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/ioctl.c linux-2.6.13-rc6-mm2/drivers/block/ioctl.c
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/ioctl.c	2005-08-23 08:23:51.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/ioctl.c	2005-08-23 08:33:28.000000000 +0200
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
diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/Kconfig linux-2.6.13-rc6-mm2/drivers/block/Kconfig
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/Kconfig	2005-08-23 08:23:51.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/Kconfig	2005-08-23 08:30:20.000000000 +0200
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
diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/ll_rw_blk.c linux-2.6.13-rc6-mm2/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/ll_rw_blk.c	2005-08-23 08:23:51.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/ll_rw_blk.c	2005-08-23 08:24:34.000000000 +0200
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
diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/Makefile linux-2.6.13-rc6-mm2/drivers/block/Makefile
--- /opt/kernel/linux-2.6.13-rc6-mm2/drivers/block/Makefile	2005-08-23 08:23:51.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/block/Makefile	2005-08-23 08:51:55.000000000 +0200
@@ -45,3 +45,5 @@ obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
 obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
 
+obj-$(CONFIG_BLK_DEV_IO_TRACE)	+= blktrace.o
+
diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/blkdev.h linux-2.6.13-rc6-mm2/include/linux/blkdev.h
--- /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/blkdev.h	2005-08-23 08:24:10.000000000 +0200
+++ linux-2.6.13-rc6-mm2/include/linux/blkdev.h	2005-08-23 08:24:34.000000000 +0200
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
diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/blktrace.h linux-2.6.13-rc6-mm2/include/linux/blktrace.h
--- /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/blktrace.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-rc6-mm2/include/linux/blktrace.h	2005-08-23 13:35:52.000000000 +0200
@@ -0,0 +1,142 @@
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
+	BLK_TC_QUEUE	= 1 << 2,	/* queueing/merging */
+	BLK_TC_ISSUE	= 1 << 3,	/* issue */
+	BLK_TC_COMPLETE	= 1 << 4,	/* completions */
+	BLK_TC_FS	= 1 << 5,	/* fs requests */
+	BLK_TC_PC	= 1 << 6,	/* pc requests */
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
+#define	BLK_TA_REQUEUE		(__BLK_TA_REQUEUE | BLK_TC_ACT(BLK_TC_QUEUE))
+#define BLK_TA_ISSUE		(__BLK_TA_ISSUE | BLK_TC_ACT(BLK_TC_ISSUE))
+#define BLK_TA_COMPLETE		(__BLK_TA_COMPLETE| BLK_TC_ACT(BLK_TC_COMPLETE))
+
+#define BLK_IO_TRACE_MAGIC	0x65617400
+#define BLK_IO_TRACE_VERSION	0x01
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
+	u16 pid;		/* who did it */
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
+	int rw = rq_data_dir(rq);
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
+	__blk_add_trace(bt, bio->bi_sector, bio->bi_size, bio_data_dir(bio), what, !bio_flagged(bio, BIO_UPTODATE), 0, NULL);
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
diff -urpN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/fs.h linux-2.6.13-rc6-mm2/include/linux/fs.h
--- /opt/kernel/linux-2.6.13-rc6-mm2/include/linux/fs.h	2005-08-23 08:24:10.000000000 +0200
+++ linux-2.6.13-rc6-mm2/include/linux/fs.h	2005-08-23 08:24:34.000000000 +0200
@@ -196,6 +196,8 @@ extern int dir_notify_enable;
 #define BLKBSZGET  _IOR(0x12,112,size_t)
 #define BLKBSZSET  _IOW(0x12,113,size_t)
 #define BLKGETSIZE64 _IOR(0x12,114,size_t)	/* return device size in bytes (u64 *arg) */
+#define BLKSTARTTRACE _IOWR(0x12,115,struct blk_user_trace_setup)
+#define BLKSTOPTRACE _IO(0x12,116)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */

--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=relayfs-read-update

--- linux-2.6.13-rc6-mm2/fs/relayfs/inode.c~	2005-08-23 14:29:11.000000000 +0200
+++ linux-2.6.13-rc6-mm2/fs/relayfs/inode.c	2005-08-23 14:29:54.000000000 +0200
@@ -302,94 +302,73 @@
  *	return the original value.
  */
 static inline size_t relayfs_read_start(size_t read_pos,
-					size_t avail,
-					size_t start_subbuf,
 					struct rchan_buf *buf)
 {
-	size_t read_subbuf, adj_read_subbuf;
-	size_t padding, padding_start, padding_end;
+	size_t read_subbuf, padding, padding_start, padding_end;
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
-
+	
 	read_subbuf = read_pos / subbuf_size;
-	adj_read_subbuf = (read_subbuf + start_subbuf) % n_subbufs;
-
-	if ((read_subbuf + 1) * subbuf_size <= avail) {
-		padding = buf->padding[adj_read_subbuf];
-		padding_start = (read_subbuf + 1) * subbuf_size - padding;
-		padding_end = (read_subbuf + 1) * subbuf_size;
-		if (read_pos >= padding_start && read_pos < padding_end) {
-			read_subbuf = (read_subbuf + 1) % n_subbufs;
-			read_pos = read_subbuf * subbuf_size;
-		}
+	padding = buf->padding[read_subbuf];
+	padding_start = (read_subbuf + 1) * subbuf_size - padding;
+	padding_end = (read_subbuf + 1) * subbuf_size;
+	if (read_pos >= padding_start && read_pos < padding_end) {
+		read_subbuf = (read_subbuf + 1) % n_subbufs;
+		read_pos = read_subbuf * subbuf_size;
 	}
 
 	return read_pos;
 }
 
 /**
- *	relayfs_read_end - return the end of available bytes to read
- *
- *	If the read_pos is in the middle of a full sub-buffer, return
- *	the padding-adjusted end of that sub-buffer, otherwise return
- *	the position after the last byte written to the buffer.  At
- *	most, 1 sub-buffer can be read at a time.
+ *	relayfs_read_avail - return total available along with buffer start
  *
+ *	Because buffers are circular, the 'beginning' of the buffer
+ *	depends on where the buffer was last written.  If the writer
+ *	has cycled around the buffer, the beginning is defined to be
+ *	the beginning of the sub-buffer following the last sub-buffer
+ *	written to, otherwise it's the beginning of sub-buffer 0.
+ *	
  */
-static inline size_t relayfs_read_end(size_t read_pos,
-				      size_t avail,
-				      size_t start_subbuf,
-				      struct rchan_buf *buf)
+static inline size_t relayfs_read_avail(size_t read_pos,
+					struct rchan_buf *buf)
 {
-	size_t padding, read_endpos, buf_offset;
-	size_t read_subbuf, adj_read_subbuf;
+	size_t padding, avail = 0;
+	size_t read_subbuf, read_offset, write_subbuf, write_offset;
 	size_t subbuf_size = buf->chan->subbuf_size;
-	size_t n_subbufs = buf->chan->n_subbufs;
 
-	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
+	write_subbuf = (buf->data - buf->start) / subbuf_size;
+	write_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
 	read_subbuf = read_pos / subbuf_size;
-	adj_read_subbuf = (read_subbuf + start_subbuf) % n_subbufs;
+	read_offset = read_pos % subbuf_size;
+	padding = buf->padding[read_subbuf];
 
-	if ((read_subbuf + 1) * subbuf_size <= avail) {
-		padding = buf->padding[adj_read_subbuf];
-		read_endpos = (read_subbuf + 1) * subbuf_size - padding;
+	if (read_subbuf == write_subbuf) {
+		if (read_offset + padding < write_offset)
+			avail = write_offset - (read_offset + padding);
 	} else
-		read_endpos = read_subbuf * subbuf_size + buf_offset;
+		avail = (subbuf_size - padding) - read_offset;
 
-	return read_endpos;
+	return avail;
 }
 
-/**
- *	relayfs_read_avail - return total available along with buffer start
- *
- *	Because buffers are circular, the 'beginning' of the buffer
- *	depends on where the buffer was last written.  If the writer
- *	has cycled around the buffer, the beginning is defined to be
- *	the beginning of the sub-buffer following the last sub-buffer
- *	written to, otherwise it's the beginning of sub-buffer 0.
- *
- */
-static inline size_t relayfs_read_avail(struct rchan_buf *buf,
-					size_t *start_subbuf)
+static void relayfs_read_consume(struct rchan_buf *buf,
+				 size_t read_pos,
+				 size_t bytes_consumed)
 {
-	size_t avail, complete_subbufs, cur_subbuf, buf_offset;
 	size_t subbuf_size = buf->chan->subbuf_size;
-	size_t n_subbufs = buf->chan->n_subbufs;
+	size_t read_subbuf;
+	size_t tmp;
 
-	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
+	buf->bytes_consumed += bytes_consumed;
+	read_subbuf = read_pos / buf->chan->subbuf_size;
 
-	if (buf->subbufs_produced >= n_subbufs) {
-		complete_subbufs = n_subbufs - 1;
-		cur_subbuf = (buf->data - buf->start) / subbuf_size;
-		*start_subbuf = (cur_subbuf + 1) % n_subbufs;
-	} else {
-		complete_subbufs = buf->subbufs_produced;
-		*start_subbuf = 0;
+	if (buf->bytes_consumed + buf->padding[read_subbuf] == subbuf_size) {
+		tmp = buf->subbufs_consumed;
+		relay_subbufs_consumed(buf->chan, buf->cpu, 1);
+		if (buf->subbufs_consumed != tmp)
+			buf->bytes_consumed = 0;
 	}
-
-	avail = complete_subbufs * subbuf_size + buf_offset;
-
-	return avail;
 }
 
 /**
@@ -401,7 +380,7 @@
  *
  *	Reads count bytes or the number of bytes available in the
  *	current sub-buffer being read, whichever is smaller.
- *
+ *	
  *	NOTE: The results of reading a relayfs file which is currently
  *	being written to are undefined.  This is because the buffer is
  *	circular and an active writer in the kernel could be
@@ -416,31 +395,40 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
-	size_t read_start, read_end, avail, start_subbuf;
-	size_t buf_size = buf->chan->subbuf_size * buf->chan->n_subbufs;
+	size_t read_start, avail;
 	void *from;
+	long long produced, consumed;
+	size_t subbuf_size = buf->chan->subbuf_size;
+	size_t n_subbufs = buf->chan->n_subbufs;
+	size_t write_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
 
-	avail = relayfs_read_avail(buf, &start_subbuf);
-	if (*ppos >= avail)
-		return 0;
+	if (buf->offset > subbuf_size)
+		produced = (buf->subbufs_produced - 1) * subbuf_size + write_offset;
+	else
+		produced = buf->subbufs_produced * subbuf_size + write_offset;
+	consumed = buf->subbufs_consumed * subbuf_size + buf->bytes_consumed;
 
-	read_start = relayfs_read_start(*ppos, avail, start_subbuf, buf);
-	if (read_start == 0 && *ppos)
+	if (produced == consumed)
 		return 0;
 
-	read_end = relayfs_read_end(read_start, avail, start_subbuf, buf);
-	if (read_end == read_start)
-		return 0;
+	relayfs_read_consume(buf, *ppos, 0);
 
-	from = buf->start + start_subbuf * buf->chan->subbuf_size + read_start;
-	if (from >= buf->start + buf_size)
-		from -= buf_size;
+	read_start = relayfs_read_start(*ppos, buf);
 
-	count = min(count, read_end - read_start);
+	avail = relayfs_read_avail(read_start, buf);
+	if (!avail)
+		return 0;
+	
+	from = buf->start + read_start;
+	count = min(count, avail);
 	if (copy_to_user(buffer, from, count))
 		return -EFAULT;
 
 	*ppos = read_start + count;
+	if (*ppos >= subbuf_size * n_subbufs)
+		*ppos = 0;
+
+	relayfs_read_consume(buf, read_start, count);
 
 	return count;
 }
--- linux-2.6.13-rc6-mm2/fs/relayfs/relay.c~	2005-08-23 14:29:08.000000000 +0200
+++ linux-2.6.13-rc6-mm2/fs/relayfs/relay.c	2005-08-23 14:29:48.000000000 +0200
@@ -58,6 +58,14 @@
 					  void *prev_subbuf,
 					  size_t prev_padding)
 {
+	if (relay_buf_full(buf)) {
+//		if (smp_processor_id() == 0) {
+//			printk("buf full, cpu %u\n", smp_processor_id());
+//			klog_printk("buf full, cpu %u\n", smp_processor_id());
+//		}
+		return 0;
+	}
+	
 	return 1;
 }
 
@@ -262,6 +270,7 @@
 	for_each_online_cpu(i) {
 		sprintf(tmpname, "%s%d", base_filename, i);
 		chan->buf[i] = relay_open_buf(chan, tmpname, parent);
+		chan->buf[i]->cpu = i;
 		if (!chan->buf[i])
 			goto free_bufs;
 	}
@@ -328,7 +337,7 @@
 	return length;
 
 toobig:
-	printk(KERN_WARNING "relayfs: event too large (%u)\n", length);
+	printk(KERN_WARNING "relayfs: event too large (%lu)\n", length);
 	WARN_ON(1);
 	return 0;
 }
--- linux-2.6.13-rc6-mm2/include/linux/relayfs_fs.h~	2005-08-23 14:29:21.000000000 +0200
+++ linux-2.6.13-rc6-mm2/include/linux/relayfs_fs.h	2005-08-23 14:29:31.000000000 +0200
@@ -22,7 +22,7 @@
 /*
  * Tracks changes to rchan_buf struct
  */
-#define RELAYFS_CHANNEL_VERSION		4
+#define RELAYFS_CHANNEL_VERSION		5
 
 /*
  * Per-cpu relay channel buffer
@@ -44,6 +44,8 @@
 	unsigned int finalized;		/* buffer has been finalized */
 	size_t *padding;		/* padding counts per sub-buffer */
 	size_t prev_padding;		/* temporary variable */
+	size_t bytes_consumed;		/* bytes consumed in cur read subbuf */
+	unsigned int cpu;		/* this buf's cpu */
 } ____cacheline_aligned;
 
 /*

--ZwgA9U+XZDXt4+m+--
