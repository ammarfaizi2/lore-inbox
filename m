Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993004AbWJUM6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993004AbWJUM6F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993006AbWJUM6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:58:05 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:31247 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S2993004AbWJUM6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:58:01 -0400
Subject: [Patch 2/5] I/O statistics through request queues: queue
	instrumentation
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 21 Oct 2006 14:57:57 +0200
Message-Id: <1161435477.3054.113.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The most important part: the addition of statistics to struct
request_queue.

A few block layer API functions are required to make this work reliably:

blk_queue_stat_create() - setup (using a name from block device driver)
blk_queue_stat_issue() - "request issued to device" marker
blk_queue_stat_complete() - "got request completion interrupt" marker

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 block/ll_rw_blk.c      |  157 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   46 ++++++++++++++
 2 files changed, 203 insertions(+)

diff -urp a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	2006-10-21 14:20:09.000000000 +0200
+++ b/include/linux/blkdev.h	2006-10-21 01:37:26.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/bio.h>
 #include <linux/module.h>
 #include <linux/stringify.h>
+#include <linux/statistic.h>
 
 #include <asm/scatterlist.h>
 
@@ -314,6 +315,12 @@ struct request {
 	 */
 	rq_end_io_fn *end_io;
 	void *end_io_data;
+
+#ifdef CONFIG_STATISTICS
+	struct timeval issued;
+	struct timeval completed;
+	int attempts;
+#endif
 };
 
 /*
@@ -362,6 +369,19 @@ struct blk_queue_tag {
 	atomic_t refcnt;		/* map can be shared */
 };
 
+enum blk_queue_stat {
+	BLK_STAT_SW,	/* request size, write */
+	BLK_STAT_SR,	/* request size, read */
+	BLK_STAT_RW,	/* residual bytes, write */
+	BLK_STAT_RR,	/* residual bytes, write */
+	BLK_STAT_LW,	/* latency, write */
+	BLK_STAT_LR,	/* latency, read */
+	BLK_STAT_AW,	/* attempts, write */
+	BLK_STAT_AR,	/* attempts, read */
+	BLK_STAT_QUD,	/* queue used depth, issued to device */
+	_BLK_STAT_NUMBER
+};
+
 struct request_queue
 {
 	/*
@@ -479,6 +499,12 @@ struct request_queue
 	unsigned int		bi_size;
 
 	struct mutex		sysfs_lock;
+
+#ifdef CONFIG_STATISTICS
+	struct statistic_interface stat_if;
+	struct statistic stat[_BLK_STAT_NUMBER];
+	atomic_t issued;
+#endif
 };
 
 #define QUEUE_FLAG_CLUSTER	0	/* cluster several segments into 1 */
@@ -773,6 +799,26 @@ request_queue_t *blk_alloc_queue(gfp_t);
 request_queue_t *blk_alloc_queue_node(gfp_t, int);
 extern void blk_put_queue(request_queue_t *);
 
+#ifdef CONFIG_STATISTICS
+extern int blk_queue_stat_create(request_queue_t *q, const char *__name);
+extern void blk_queue_stat_issue(request_queue_t *q, struct request *rq);
+extern void blk_queue_stat_complete(request_queue_t *q, struct request *rq);
+#else
+static inline int blk_queue_stat_create(request_queue_t *q, const char *__name)
+{
+	return 0;
+}
+
+static inline void blk_queue_stat_issue(request_queue_t *q, struct request *rq)
+{
+}
+
+static inline void blk_queue_stat_complete(request_queue_t *q,
+					   struct request *rq)
+{
+}
+#endif
+
 /*
  * tag stuff
  */
diff -urp a/block/ll_rw_blk.c b/block/ll_rw_blk.c
--- a/block/ll_rw_blk.c	2006-10-21 14:20:09.000000000 +0200
+++ b/block/ll_rw_blk.c	2006-10-21 13:27:10.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/blktrace_api.h>
+#include <linux/statistic.h>
 
 /*
  * for max sense size
@@ -260,6 +261,9 @@ static void rq_init(request_queue_t *q, 
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
 	rq->completion_data = NULL;
+#ifdef CONFIG_STATISTICS
+	rq->attempts = 0;
+#endif
 }
 
 /**
@@ -1780,6 +1784,10 @@ static void blk_release_queue(struct kob
 
 	blk_trace_shutdown(q);
 
+#ifdef CONFIG_STATISTICS
+	statistic_remove(&q->stat_if);
+#endif
+
 	kmem_cache_free(requestq_cachep, q);
 }
 
@@ -1855,6 +1863,154 @@ request_queue_t *blk_alloc_queue_node(gf
 }
 EXPORT_SYMBOL(blk_alloc_queue_node);
 
+#ifdef CONFIG_STATISTICS
+static struct statistic_info blk_stat_info[] = {
+	[BLK_STAT_SW] = {
+		.name	  = "size_write",
+		.x_unit	  = "bytes",
+		.y_unit	  = "request",
+		.defaults = "type=sparse entries=256"
+	},
+	[BLK_STAT_SR] = {
+		.name	  = "size_read",
+		.x_unit	  = "bytes",
+		.y_unit	  = "request",
+		.defaults = "type=sparse entries=256"
+	},
+	[BLK_STAT_RW] = {
+		.name	  = "residual_write",
+		.x_unit	  = "bytes",
+		.y_unit	  = "request",
+		.defaults = "type=sparse entries=256"
+	},
+	[BLK_STAT_RR] = {
+		.name	  = "residual_read",
+		.x_unit	  = "bytes",
+		.y_unit	  = "request",
+		.defaults = "type=sparse entries=256"
+	},
+	[BLK_STAT_LW] = {
+		.name	  = "latency_write",
+		.x_unit	  = "microsec",
+		.y_unit	  = "request",
+		.defaults = "type=histogram_log2 entries=23 "
+			    "base_interval=1 range_min=0"
+	},
+	[BLK_STAT_LR] = {
+		.name	  = "latency_read",
+		.x_unit	  = "microsec",
+		.y_unit	  = "request",
+		.defaults = "type=histogram_log2 entries=23 "
+			    "base_interval=1 range_min=0"
+	},
+	[BLK_STAT_AW] = {
+		.name	  = "times_issued_write",
+		.x_unit	  = "attempts",
+		.y_unit	  = "request",
+		.defaults = "type=histogram_lin entries=8 "
+			    "base_interval=1 range_min=0"
+	},
+	[BLK_STAT_AR] = {
+		.name	  = "times_issued_read",
+		.x_unit	  = "attempts",
+		.y_unit	  = "request",
+		.defaults = "type=histogram_lin entries=8 "
+			    "base_interval=1 range_min=0"
+	},
+	[BLK_STAT_QUD] = {
+		.name	  = "queue_used_depth",
+		.x_unit	  = "requests",
+		.y_unit   = "",
+		.defaults = "type=utilisation"
+	}
+};
+
+/**
+ * blk_queue_stat_create - setup request queue statistics
+ * @q: request queue
+ * @__name: users will see this as part of the statistics name
+ *
+ * Prepares a request queue for statistics data collection. This function
+ * might sleep. __name must be unique. For example, it could comprise a
+ * block device driver's name and the busid of the dev<driver name>-<busid>).
+ */
+int blk_queue_stat_create(request_queue_t *q, const char *__name)
+{
+	char name[64];
+
+	atomic_set(&q->issued, 0);
+ 	snprintf(name, 64, "blkq-%s", __name);
+ 	q->stat_if.stat = q->stat;
+ 	q->stat_if.info = blk_stat_info;
+ 	q->stat_if.number = _BLK_STAT_NUMBER;
+ 	return statistic_create(&q->stat_if, name);
+}
+EXPORT_SYMBOL_GPL(blk_queue_stat_create);
+
+/**
+ * blk_queue_stat_issue - notify statistics that this request is being issued
+ * @q: request queue
+ * @rq: request
+ *
+ * It's safe to call this function in any context.
+ * It is important to keep it as small as possible, as it would be called
+ * in a performance critical path of a device driver.
+ */
+void blk_queue_stat_issue(request_queue_t *q, struct request *rq)
+{
+	do_gettimeofday(&rq->issued);
+	statistic_inc(q->stat, BLK_STAT_QUD, atomic_inc_return(&q->issued));
+	rq->attempts++;
+}
+EXPORT_SYMBOL_GPL(blk_queue_stat_issue);
+
+/**
+ * blk_queue_stat_issue - notify statistics that this request is being issued
+ * @q: request queue
+ * @rq: request
+ *
+ * It's safe to call this function in any context.
+ * It is important to keep it as small as possible, as it would be called
+ * in a performance critical path of a device driver.
+ */
+void blk_queue_stat_complete(request_queue_t *q, struct request *rq)
+{
+	do_gettimeofday(&rq->completed);
+	atomic_dec(&q->issued);
+}
+EXPORT_SYMBOL_GPL(blk_queue_stat_complete);
+
+static void blk_queue_stat_end(request_queue_t *q, struct request *rq,
+			       int bytes)
+{
+	s64 latency, size, residual;
+	unsigned long flags;
+
+	latency = timeval_to_us(&rq->completed) - timeval_to_us(&rq->issued);
+	size = blk_pc_request(rq) ? rq->data_len : rq->hard_nr_sectors << 9;
+	residual = size - bytes;
+
+	local_irq_save(flags);
+	if (rq_data_dir(rq) == WRITE) {
+		_statistic_inc(q->stat, BLK_STAT_SW, size);
+		_statistic_inc(q->stat, BLK_STAT_RW, residual);
+		_statistic_inc(q->stat, BLK_STAT_LW, latency);
+		_statistic_inc(q->stat, BLK_STAT_AW, rq->attempts);
+	} else if (rq_data_dir(rq) == READ) {
+		_statistic_inc(q->stat, BLK_STAT_SR, size);
+		_statistic_inc(q->stat, BLK_STAT_RR, residual);
+		_statistic_inc(q->stat, BLK_STAT_LR, latency);
+		_statistic_inc(q->stat, BLK_STAT_AR, rq->attempts);
+	}
+	local_irq_restore(flags);
+}
+#else
+static void blk_queue_stat_end(request_queue_t *q, struct request *rq,
+			       int bytes)
+{
+}
+#endif /* CONFIG_STATISTICS */
+
 /**
  * blk_init_queue  - prepare a request queue for use with a block device
  * @rfn:  The function to be called to process requests that have been
@@ -3249,6 +3405,7 @@ static int __end_that_request_first(stru
 	struct bio *bio;
 
 	blk_add_trace_rq(req->q, req, BLK_TA_COMPLETE);
+	blk_queue_stat_end(req->q, req, uptodate ? nr_bytes : 0);
 
 	/*
 	 * extend uptodate bool to allow < 0 value to be direct io error


