Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWHDCVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWHDCVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWHDCVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:21:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:32817 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030286AbWHDCVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:21:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cbsJ9mqFGopWf2RvaGWlgYrXCxlPfkPonl8tNxxAl2lzsKPKhZTrdWLN0KUNXh11JZ58GxpwwoVvTn6qQlBrGDLUYyqbT4ns5wxiHdvjcct2c+IuHxILMySSbtZ7Vgk3aOQmCOvltV/1hgPTjphTMPZm05QAPslnLrzBuOzSHq0=
Message-ID: <5c49b0ed0608031921o7f140a80g3c4f860e9890186e@mail.gmail.com>
Date: Thu, 3 Aug 2006 19:21:45 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jens Axboe" <axboe@suse.de>
Subject: [PATCH -mm] [3/3] Add the Elevator I/O scheduler
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Elevator I/O scheduler.  It is a simple one-way elevator,
with a couple tunables for reducing latency or starvation.  It also
has a performance-oriented tracing facility to help debug strange or
specialized workloads.

Tested and benchmarked extensively on several platforms with several
disk controllers and multiple brands of disk.  Subsequently ported
forward from 2.6.14, compile and boot tested on 2.6.18-rc1-mm2.

- Made the worst of the #defines into static functions
- Moved the elv_extended_request API and the list_merge function to
seperate patches
- Moved most of the big comments to Documentation/
- Removed the ra_pages tunable, since it duplicates read_ahead_kb
- Fixed extraneous changes in Kconfig.iosched, ll_rw_blk.c and elevator.c
- Other small fixes

Thanks to Dave Jones, Adrian Bunk, and Daniel Phillips for their comments.

Signed-off-by: Nate Diller <nate.diller@gmail.com>

---
 Documentation/block/elevator-iosched.txt |  191 +++++
 block/Kconfig.iosched                    |   35 +
 block/Makefile                           |    1
 block/elevator-iosched.c                 | 1056 +++++++++++++++++++++++++++++++
 4 files changed, 1283 insertions(+)
---

diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/block/elevator-iosched.c
linux-dput/block/elevator-iosched.c
--- linux-2.6.18-rc1-mm2/block/elevator-iosched.c	1969-12-31
16:00:00.000000000 -0800
+++ linux-dput/block/elevator-iosched.c	2006-08-03 18:49:06.000000000 -0700
@@ -0,0 +1,1056 @@
+/*
+ *  linux/block/elevator-iosched.c
+ *
+ *  Elevator I/O scheduler.  This implementation is intended to be much
+ *  closer to the standard CS one-way elevator algorithm (aka C-LOOK) than
+ *  linux has had in the past.  It also has some little enhancements as
+ *  tunables, and is capable of collecting lots of per-sweep performance
+ *  stats and traces.
+ *
+ *  Written by Nate Diller
+ *  Copyright (C) 2006 Digeo Inc.
+ *  Copyright (C) 2006 Nate Diller
+ */
+
+/*
+ *  Special thanks to Hans for explaining the previous linux elevator, and
+ *  giving me confidence that this would be an improvement.
+ */
+
+/*
+ * see Documentation/block/elevator-iosched.txt for more design overview,
+ * and explanations of some implementation details.
+ *
+ *   Design
+ *
+ * There are two primary queues, the main elevator ordering queue (head),
+ * and the outgoing queue (q->queue_head).  All normal requests enter the
+ * head queue and are inserted into it in elevator order (increasing ->start
+ * sector).
+ *
+ * The "presumed" disk head position is represented by the 'fake' el_req
+ * contained in el_data->head.  Its ->request field is NULL, and its length
+ * is 0.  Its ->start sector is the one just after the last sector submitted
+ * to disk.
+ *
+ * We usually wish to take the next request from the head queue.  However,
+ * if we receive a barrier request, we have to freeze all the requests on
+ * the head queue into a solid mass to prevent further insertions.  So we
+ * move the whole head queue unmodified onto the outgoing list behind
+ * anything that is already on it, and insertions continue to occur only on
+ * the head queue.  If there are requests on the dipatch list, they
are submitted
+ * before anything from the head queue.
+ *
+ * The head queue is based on the list_head in struct el_req, but the
+ * outgoing queue uses the list_head in struct request.  There is usually
+ * only one request in the outgoing queue at a time; next_req keeps
+ * re-submitting the first request on the queue until the queue is empty.
+ * Only then does it check the dispatch and head queues for another request.
+ */
+
+/*
+ *    Operations
+ *
+ * As disks continue to grow in size, the optimal size for requests grows as
+ * well.  It used to be that requests which were larger than the disk's
+ * hardware limit for request length were relatively rare, since they would
+ * take a long time to complete.  Now, it's not only commonplace, but
+ * desireable for request length to exceed the hardware limit.  However,
+ * since struct request is still limited by this hardware size, a single
+ * logical request may be split into many request structures, each submitted
+ * to the disk seperately.
+ *
+ * In order to continue to treat logical requests as a single entity, even
+ * when they are composed of many request structures, contiguous request
+ * structures are chained together into headless linked lists.  I term these
+ * logical requests "operations", and they represent a single disk head
+ * seek.  Many of the internal statistics are gathered in units of
+ * operations.
+ *
+ * The comment above next_operation() gives an overview of how these lists
+ * can be manipulated.  It should be noted that while it is rare, two
+ * requests which are contiguous but are not the same direction (one is
+ * read, the other write) are still placed into the contig list.  However,
+ * there is an option to treat "mixed" r/w operations differently, see
+ * the comment in next_request() regarding PURE_OPERATION.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/elevator.h>
+#include <linux/bio.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/compiler.h>
+#include <linux/backing-dev.h>	/* for queue congestion function */
+
+#ifdef CONFIG_IOSCHED_EL_PERF_DEBUG
+	#define EL_DEBUG 1
+#else
+	#define EL_DEBUG 0
+#endif
+
+#ifdef CONFIG_IOSCHED_EL_SSTF
+	#define EL_SSTF 1
+#endif
+
+/* the default readahead value for elevator */
+#define EL_RA_PAGES 128
+
+/* default values for sysfs variables */
+/* 0 means turned off by default but settable in sysfs */
+#define PRINT_INTERVAL 0	/* trace period in sweeps (inverse frequency) */
+#define MAX_WRITE 0
+#define MAX_CONTIG 0
+#define PURE_OPERATION 0	/* this has strange performance implications */
+
+#define is_head(e) ((e)->request == NULL)
+#define is_write(e) ((e)->request->flags & REQ_RW)
+#define req_rw(e) (is_write(e) ? 2 : 1)
+
+#define is_contig_prev(prev, start) (!is_head(prev) &&
((prev)->request->sector + (prev)->request->nr_sectors == start))
+#define is_contig_next(start, next) (!is_head(next) && (start ==
(next)->request->sector))
+
+#define next_in_queue(e) (list_entry((e)->queue.next, struct el_req, queue))
+#define prev_in_queue(e) (list_entry((e)->queue.prev, struct el_req, queue))
+
+#define next_req_in_queue(e) (is_head(next_in_queue(e)) ?
next_in_queue(next_in_queue(e)) : next_in_queue(e))
+#define prev_req_in_queue(e) (is_head(prev_in_queue(e)) ?
prev_in_queue(prev_in_queue(e)) : prev_in_queue(e))
+
+#define next_contig(e) (list_entry((e)->contiguous.next, struct
el_req, contiguous))
+#define prev_contig(e) (list_entry((e)->contiguous.prev, struct
el_req, contiguous))
+
+#define is_first_in_op(e) (prev_contig(e)->start > e->start)
+#define is_last_in_op(e) (next_contig(e)->start < e->start)
+
+#define active_req(q) ((q)->rq.count[0] + (q)->rq.count[1])
+#define active_ops(el) ((el)->ops[0] + (el)->ops[1])
+
+#define sweep_sec(el) ((el)->sec_this_sweep[0] + (el)->sec_this_sweep[1])
+
+#define ops_count(el, req) ((el)->ops[req->flags & REQ_RW ? 1 : 0])
+#define sec_count(el, req) ((el)->sec[req->flags & REQ_RW ? 1 : 0])
+#define sweep_latency(el, req) ((el)->sweep_latency[(req)->flags &
REQ_RW ? 1 : 0])
+
+static kmem_cache_t *e_req_slab;
+
+/*
+ * Per-request private data
+ */
+struct el_req {
+	/* the elevator queue in which requests accumulate before going to
+	 * disk, and get sorted. */
+	struct list_head queue;
+	struct list_head contiguous;
+	sector_t start;
+	unsigned int len;
+	unsigned long this_contig;
+	unsigned long op_rw;
+	void *owner;		/* thread that submitted this request */
+
+	struct request *request;
+};
+
+/*
+ * Private data for the queue_head
+ */
+struct el_data {
+	struct el_req head;	/* the head's start sector is the head position,
request is NULL */
+	unsigned long head_jiffies;	/* last time the head was moved */
+	unsigned long next_jiffies;	/* last time next_req completed */
+
+	unsigned int ops[2];	/* how many operations there are on the queue */
+	unsigned int sec[2];	/* how many sectors are enqueued */
+
+	unsigned int max_contig;	/* this queue's tunables */
+	unsigned int max_write;
+	unsigned int print_interval;
+	unsigned int pure_operation;	/* binary that prohibits operations
mixing read/write */
+
+	unsigned int count_since_last_trace;	/* number of requests since we
dumped a trace */
+
+	unsigned int sec_this_sweep[2]; /* number of sectors submitted this sweep */
+	unsigned int ops_this_sweep[2]; /* number of operations submitted
this sweep */
+	unsigned long sweep_latency[2];
+	sector_t first_sweep_sector;
+	unsigned long req_this_sweep;
+	unsigned long sweep_start_time;
+
+	elevator_t *e;
+	struct request_queue *q;
+	mempool_t *req_pool;	/* mempool from which el_reqs are allocated */
+};
+
+static inline void inc_sweep_sec_count(struct el_data *el, struct request *req)
+{
+	if (req->flags & REQ_RW)
+		el->sec_this_sweep[1] += req->nr_sectors;
+	else
+		el->sec_this_sweep[0] += req->nr_sectors;
+}
+
+static inline void inc_sweep_ops_count(struct el_data *el, struct request *req)
+{
+	if (req->flags & REQ_RW)
+		el->ops_this_sweep[1]++;
+	else
+		el->ops_this_sweep[0]++;
+}
+
+/*
+ * Move the head position just past @e, and update its fields.
+ */
+static inline void move_head_past(struct el_data *el, struct el_req *e)
+{
+	list_move(&el->head.queue, &e->queue);
+	el->head.start = e->start + e->len;
+	el->head_jiffies = jiffies;
+}
+
+/*
+ * Reset all the per-sweep statistics.
+ */
+static inline void reset_sweep(struct el_data *el, sector_t start)
+{
+	el->sec_this_sweep[0] = el->sec_this_sweep[1] = \
+	el->ops_this_sweep[0] = el->ops_this_sweep[1] = \
+	el->sweep_latency[0] = el->sweep_latency[1] = \
+	el->req_this_sweep = 0;
+
+	el->first_sweep_sector = start;
+	el->sweep_start_time = jiffies;
+}
+
+/*
+ * Show per-sweep statistics
+ */
+static inline void print_sweep(struct el_data *el)
+{
+	printk("\nsec <%6d,%6d>  ops <%2u,%3u>  req%4lu,  cov%6lluKi,
time%4lu,  lat <%5lu,%5lu>\n",
+		el->sec_this_sweep[0], el->sec_this_sweep[1],
+		el->ops_this_sweep[0], el->ops_this_sweep[1],
+		el->req_this_sweep,
+		(unsigned long long) ((el->head.start - el->first_sweep_sector) >> 10),
+		jiffies - el->sweep_start_time,
+		el->ops_this_sweep[0] ? el->sweep_latency[0] / el->ops_this_sweep[0] : 0,
+		el->ops_this_sweep[1] ? el->sweep_latency[1] / el->ops_this_sweep[1] : 0);
+}
+
+/*
+ * Summarize the state of the queue
+ */
+static inline void print_el_data(struct el_data *el)
+{
+	printk("(%9lu)  %6lu %4lu  req <%3u,%3u>  ops <%3u,%3u>  sec <%7u,%7u>\n",
+		(unsigned long) el->head.start,
+		jiffies - el->head_jiffies, jiffies - el->next_jiffies,
+		el->q->rq.count[0], el->q->rq.count[1],
+		el->ops[0], el->ops[1],
+		el->sec[0], el->sec[1]);
+}
+
+static inline char contig_char(struct el_request *e)
+{
+	if (list_empty(&e->contiguous))
+		return '0';
+	if (prev_contig(e)->start > e->start)
+		return 'v';
+	if (next_contig(e)->start < e->start)
+		return '^';
+	return '|';
+}
+
+static inline void print_head(struct el_request *e)
+{
+	printk(KERN_ALERT "(%9lu, %4lu)\n", (unsigned long) e->start, 0ul);
+}
+
+static inline void print_request(struct el_request *e)
+{
+	printk(KERN_ALERT "(%9lu, %4lu) %6lu  %p  %c  %c  %c\n",
+		(unsigned long) e->request->sector,
+		e->request->nr_sectors,
+		jiffies - e->request->start_time,
+		e->owner,
+		(e->request->flags & REQ_RW) ? 'w' : 'r',
+		contig_char(e),
+		(e->request->flags & REQ_FAILFAST) ? 's' : 'a' );
+}
+
+/*
+ * Print the elevator statistics, and the entire queue.
+ */
+static void print_queue(struct request_queue *q, struct el_data *el)
+{
+	struct el_req *e;
+
+	printel(el);
+	list_for_each_entry(e, &el->head.queue, queue) {
+		is_head(e) ? print_head(e) : print_request(e);
+	}
+}
+
+/*
+ * Resets the sweep counter and triggers the trace printouts.
+ */
+static inline void do_trace(struct el_data *el, sector_t start)
+{
+ 	if (likely(!el->print_interval) || start >= el->head.start)
+		return;
+
+	if (el->count_since_last_trace < el->print_interval)
+		el->count_since_last_trace++;
+	else {
+		el->count_since_last_trace = 0;
+ 		print_sweep(el);
+ 		print_queue(el->q, el);
+	}
+	reset_sweep(el, start);
+}
+
+/*
+ * These two functions are a little complicated.  They are intended to
+ * allow iterating over all the operations in the queue, a la
+ * queue_for_each_op().  However, due to the structure of contig
+ * lists, the functions only work for the "ends", that is, the edge
+ * request of the operation.  To illustrate:
+ *
+ * /--------------------- queue list ----------------------------\
+ * \-/ 100 --- 101 --- 102 \--/ 141 \--/ 170 --- 171 \--/ head \-/
+ *   \---------------------/  \-----/  \-------------/  \------/
+ *                       contig lists
+ *
+ * Our goal is to return 141 given next_operation(100).  Thus
+ * we take the prev_contig(100) to get 102, and next_in_queue(102)
+ * to get 141.  This obviously would fail if we called next_operation(101).
+ * So we test for that case with (next_op == e), since prev_contig(101)
+ * is 100, and next_in_queue(100) is 101 again.  Note that this function
+ * works correctly for single request operations, since prev_contig(141)
+ * is 141, so next_in_queue(141) returns 170, the correct value.  It also
+ * works correctly for the head, since its contig list is also empty.
+ */
+static inline struct el_req *next_operation(struct el_req *e)
+{
+	struct el_req *next_op = next_in_queue(prev_contig(e));
+	return (next_op == e) ? NULL : next_op;
+}
+
+static inline struct el_req *prev_operation(struct el_req *e)
+{
+	struct el_req *prev_op = next_contig(prev_in_queue(e));
+	return (prev_op == e) ? NULL : prev_op;
+}
+
+/*
+ * Find the insertion point for a request starting at sector @new.
+ */
+static struct el_req *find_request(struct el_data *el, sector_t new)
+{
+	struct el_req *prev, *next = &el->head;
+
+	/*
+	 * If the new sector is equal to the head position, the insertion
+	 * point should be *before* the head position if a back merge is
+	 * possible, *after* it otherwise.
+	 */
+	if (new == next->start) {
+		prev = prev_in_queue(next);
+		if (is_contig_prev(prev, new))
+			return prev;
+		return next;
+	}
+
+	prev = next;
+	list_for_each_entry(next, &el->head.queue, queue) {
+		/*
+		 * If you are seeing this warning, and you aren't using
+		 * Direct I/O, something is wrong.
+		 */
+#if EL_DEBUG
+		if (unlikely(new == next->start))
+			printk(KERN_ALERT "nate 0000: identical starting points\n");
+#endif
+		if (new >= prev->start && new < next->start)
+			break;
+		/*
+		 * If we are at the sweep transition point, and the new
+		 * position is lower than the lowest or higher than the
+		 * highest numbered request in the queue, insert here.
+		 */
+		if (prev->start > next->start &&
+		    (new > prev->start || new < next->start))
+			break;
+
+		prev = next;
+	}
+	return prev;
+}
+
+/*
+ * Keep track of contiguous submitted requests, and move the head forward to
+ * skip the remaining requests in the current operation if more than
+ * max_contig number of sectors have already been submitted.
+ *
+ * Returns True if it moved the head.
+ */
+static inline int enforce_max_contig(struct el_data *el, struct el_req *e)
+{
+	next_contig(e)->op_rw = req_rw(e);
+
+	if (likely(!el->max_contig))
+		return 0;
+
+	if (e->this_contig + e->len < el->max_contig) {
+		next_contig(e)->this_contig = e->this_contig + e->len;
+		return 0;
+	}
+
+#if EL_DEBUG
+	if (!is_first_in_op(e))
+		printk(KERN_ALERT "nate 1977: max_contig went backwards\n");
+#endif
+	/*
+	 * See comment above next_operation() to see why this works.
+	 */
+	move_head_past(el, prev_contig(e));
+	return 1;
+}
+
+/*
+ * Remove the selected request from the queue, and update all internal
+ * state.
+ *
+ * This is called when the request is being submitted to the controller.  If
+ * the controller's queue is full, the request gets added back into the
+ * outgoing queue.
+ */
+static void remove_req(request_queue_t *q, struct request *req)
+{
+	struct el_req *e = req->elevator_private;
+	struct el_data *el = (struct el_data *) q->elevator->elevator_data;
+
+	/*
+	 * This function can get called more than once if the disk's queue
+	 * becomes full, or if there is a barrier (see insert_req).  It
+	 * should only actually run the first time.
+	 */
+	if (list_empty(&e->queue))
+		return;
+
+	/*
+	 * This check is for all the SCSI drivers, to make sure that the
+	 * request actually being submitted is the closest to the head.  The
+	 * IDE drivers, for historical reasons, tend to leave requests on
+	 * the queue until they have completed.  We check for these "head
+	 * active" situations with the REQ_STARTED flag, and ignore them.
+	 */
+#if EL_DEBUG
+	if (unlikely(!is_head(prev_in_queue(e)) && !(req->flags & REQ_STARTED)))
+		printk(KERN_ALERT "nate 0001: removing request out of elevator order\n");
+#endif
+
+	/*
+	 * Update the elevator statistics.
+	 */
+	if (list_empty(&e->contiguous))
+		ops_count(el, req)--;
+	sec_count(el, req) -= e->len;
+
+	/*
+	 * Update the per-request sweep statistics, and print them.
+	 */
+	inc_sweep_sec_count(el, req);
+	el->req_this_sweep++;
+
+	do_trace(el, e->start);
+
+	/*
+	 * Move the head position to the end of this request, then let
+	 * enforce_max_contig() decide whether to move it to the end of this
+	 * operation.
+	 *
+	 * Update per-operation sweep statistics if max_contig is enforced,
+	 * or if the request is its own operation.
+	 */
+	move_head_past(el, e);
+	if (enforce_max_contig(el, e) || list_empty(&e->contiguous)) {
+		inc_sweep_ops_count(el, req);
+		sweep_latency(el, req) += jiffies - req->start_time;
+	}
+
+	list_del_init(&e->queue);
+	list_del_init(&e->contiguous);
+}
+
+/*
+ * Insert a new request into the contig lists, and update the head position
+ * if needed.
+ *
+ * This has to cover a lot of different cases, since @req can be new, or
+ * only extended (via a bio merge).  Also, the head is never supposed to be
+ * in between contiguous requests, so if we do a merge around the head, we
+ * have to move it to the end of the resulting operation (we can't go to the
+ * beginning, because we don't want to seek backwards).
+ *
+ * First, set @next and @prev to the two requests we might merge with. After
+ * the merge, @first and @last conceptually represent the first and last
+ * request in the resulting operation.  However, since we may have already
+ * merged into @next, the is_contig_prev code can't use the next_contig()
+ * trick (see prev_operation()'s comment for an overview).  Thus, @first is
+ * set to @prev, not necessarily the actual first request.  This is
+ * sufficient to @ensure that @head is positioned properly afterward, so no
+ * worries.
+ *
+ * If no merge happened, @first and @last are the request in question, since
+ * it's its own operation.  Either way, the head should not be anywhere in
+ * the area that the operation covers, so if needed, we move it before
+ * returning.
+ */
+static void make_contiguous(struct el_data *el, struct request *req)
+{
+	struct el_req *e = req->elevator_private;
+	struct el_req *next = next_req_in_queue(e), *prev = prev_req_in_queue(e);
+	struct el_req *head = &el->head, *first = e, *last = e;
+
+#if EL_DEBUG
+	if (unlikely(!e->len))
+		printk(KERN_ALERT "nate 0101: zero length request\n");
+	if (unlikely(!(list_empty(&e->contiguous) || is_first_in_op(e) ||
is_last_in_op(e))))
+		printk(KERN_ALERT "nate 1111: request is already contiguous\n");
+#endif
+
+	if (is_contig_next(e->start + e->len, next)) {
+		last = prev_contig(next);
+		if (next != next_contig(e)) {
+			list_merge(&next->contiguous, &e->contiguous);
+			ops_count(el, req)--;
+		}
+	}
+	if (is_contig_prev(prev, e->start)) {
+		first = prev;
+		if (prev != prev_contig(e)) {
+			list_merge(&e->contiguous, &prev->contiguous);
+			ops_count(el, req)--;
+		}
+	}
+
+	if (first->start < head->start && head->start < last->start + last->len)
+		move_head_past(el, last);
+}
+
+/*
+ * Insert a new request in elevator order.
+ *
+ * Initialize private data, insert the request, update the queue accounting,
+ * and merge it into the contig lists.
+ */
+static void add_req(struct request_queue *q, struct request *req)
+{
+	struct el_data *el = q->elevator->elevator_data;
+	struct el_req *prev, *e = req->elevator_private;
+
+	if (unlikely(e->this_contig))
+		printk(KERN_ALERT "nate 144: request didn't get zeroed out\n");
+	e->start = req->sector;
+	e->len = req->nr_sectors;
+	e->owner = current;
+
+	prev = find_request(el, e->start);
+	list_add(&e->queue, &prev->queue);
+
+	ops_count(el, req)++;
+	sec_count(el, req) += e->len;
+
+	if (unlikely(!list_empty(&e->contiguous)))
+		printk(KERN_ALERT "nate 110: request shouldn't be contiguous yet\n");
+	make_contiguous(el, req);
+}
+
+/*
+ * Update private bookkeeping for a successful bio merge with @req.
+ *
+ * Aside from sychronizing the sector counts, we also have to check to see
+ * if this merge closed a gap between requests, causing them to become
+ * contiguous.  We always update the contig lists in this case, because we
+ * can't count on doing a double merge (the requests may be too big, or a
+ * mix of reads and writes).  @direction tells us whether it was a front or
+ * back merge, but I haven't modified make_contiguous() to use it.
+ */
+static void extended_request(request_queue_t *q, struct request *req,
+			int direction, int nr_sectors)
+{
+	struct el_req *e = req->elevator_private;
+	struct el_data *el = q->elevator->elevator_data;
+
+#if EL_DEBUG
+	if (unlikely(e->len + nr_sectors != req->nr_sectors))
+		printk(KERN_ALERT "nate 1990: mismatched sector counts in bio merge\n");
+#endif
+
+	e->start = req->sector;
+	e->len = req->nr_sectors;
+
+	sec_count(el, req) += nr_sectors;
+
+	make_contiguous(el, req);
+}
+
+/*
+ * Here we update our private bookkeeping for merge of @old into @req.
+ *
+ * This is only for the case where a double merge has occurred, that is, a
+ * bio was added to @req which caused it to become contiguous, and
+ * mergeable, with @old.
+ */
+static void merge_requests(request_queue_t *q, struct request *req,
+			 struct request *old)
+{
+	struct el_req *e = req->elevator_private, *next = old->elevator_private;
+
+	if (unlikely(list_empty(&next->queue)))
+		printk(KERN_ALERT "nate 894: request is not on the queue\n");
+	if (unlikely(!list_empty(&req->queuelist)))
+		printk(KERN_ALERT "nate 898: merge_req on already dispatched req\n");
+	if (unlikely(is_head(prev_in_queue(next)) || is_head(next_in_queue(e))))
+		printk(KERN_ALERT "nate 896: merging with the queue head\n");
+#if EL_DEBUG
+	if (unlikely(next_contig(e) != next))
+		printk(KERN_ALERT "nate 8897: merging non-contiguous requests\n");
+#endif
+
+	e->len += next->len;
+
+	list_del_init(&next->queue);
+	list_del_init(&next->contiguous);
+}
+
+/*
+ * Initial check to see if we are allowed to merge @bio with a currently
+ * enqueued request.  Returns the direction to merge, and the request to
+ * merge with in @req.
+ *
+ * We avoid front merges if possible, this allows us to simplify
+ * merge_requests(), since we know that a front merged bio could not have
+ * happened.
+ */
+static int merge(request_queue_t *q, struct request **req, struct bio *bio) {
+	struct el_data *el = (struct el_data *) q->elevator->elevator_data;
+	struct el_req *e;
+	struct request *last = q->last_merge;
+
+	if (last && elv_rq_merge_ok(last, bio) &&
+	    last->sector + last->nr_sectors == bio->bi_sector) {
+		*req = last;
+		return ELEVATOR_BACK_MERGE;
+	}
+
+	e = find_request(el, bio->bi_sector);
+	if (is_contig_prev(e, bio->bi_sector)
+				&& elv_rq_merge_ok(e->request, bio)) {
+		*req = q->last_merge = e->request;
+		return ELEVATOR_BACK_MERGE;
+	}
+
+	e = next_in_queue(e);
+	if (is_contig_next(bio->bi_sector + bio_sectors(bio), e)
+				&& elv_rq_merge_ok(e->request, bio)) {
+		*req = q->last_merge = e->request;
+		return ELEVATOR_FRONT_MERGE;
+	}
+	return ELEVATOR_NO_MERGE;
+}
+
+/*
+ * Select the first request which starts after the head position.
+ */
+# ifndef EL_SSTF
+static struct el_req *scan_select(struct el_data *el)
+{
+	struct el_req *target = next_in_queue(&el->head);
+
+	/*
+	 * if (write throttling is on) && (there are reads in the queue) &&
+	 *     (we have exceeded this sweep's write sector limit)
+	 * {
+	 *         while (requests are writes) && (they are part of this sweep)
+	 *                 try the next request
+	 * }
+	 */
+	if (el->max_write && el->ops[0] &&
+	    el->sec_this_sweep[1] >= el->max_write)
+	{
+		while (is_write(target) && target->start >= el->head.start)
+			target = next_in_queue(target);
+	}
+
+	/*
+	 * This lets us avoid sending mixed (r/w) operations.
+	 * op_rw's first bit is read, second is write.  So if pure_operation
+	 * has the first bit set, we prevent transitions from read to write.
+	 */
+	if (unlikely(el->pure_operation & target->op_rw) && target->op_rw !=
req_rw(target)) {
+		target = next_operation(target);
+		if (is_head(target))
+			target = next_in_queue(target);
+	}
+
+	return target;
+}
+#else	/* EL_SSTF */
+
+/*
+ * Select the request whose starting sector is closest to the head position.
+ *
+ * Currently ignores max_write and pure_operation.
+ */
+static struct el_req *seek_select(struct el_data *el)
+{
+	struct el_req *head = &el->head;
+	struct el_req *next = next_in_queue(head);
+	struct el_req *prev = prev_operation(head);
+
+	/*
+	 * Avoid math underflow when both requests are before/after the head
+	 */
+	if (prev->start > next->start)
+		return (head->start < prev->start) ? next : prev;
+
+	return (head->start - prev->start > next->start - head->start) ? next : prev;
+}
+#endif	/* EL_SSTF */
+
+/*
+ * Identify which request should be submitted to the disk next.
+ *
+ * Note that the request is not actually submitted, but it is added to
+ * the outgoing queue.  This is solely to maintain compatability with the
+ * device drivers and libraries, which all expect q->queue_head to be used.
+ * The outgoing queue is also used for requests frozen before a barrier, and
+ * special requests.  These requests must go out before anything on the head
+ * queue.
+ *
+ * However, if a request is submitted on an otherwise empty outgoing queue,
+ * and it doesn't get de-queued immediately, other requests can be inserted
+ * into the head queue which are before it in elevator order.  So instead of
+ * blindly returning the first request on the outgoing queue, the loop at top
+ * checks if the request has been de-queued by remove_request() yet.  If so,
+ * it is part of a barrier or command, and it must go out.  If not, it is
+ * removed from the outgoing queue.  Then if outgoing is empty, the next
+ * request from the head queue is selected.
+ */
+static struct request *next_req(request_queue_t *q, int force)
+{
+	struct el_req *target = NULL;
+	struct el_data *el = q->elevator->elevator_data;
+	struct request *next, *n;
+	
+	/*
+	 * Find the first request on the outgoing queue which has already
+	 * been de-queued from head, and submit it.  A request which has not
+	 * been de-queued should be removed, and possibly re-submitted
+	 * below.
+	 */
+	list_for_each_entry_safe(next, n, &q->queue_head, queuelist) {
+		target = next->elevator_private;
+		if (!force && (next->flags & REQ_STARTED || !target ||
list_empty(&target->queue)))
+			return next;
+		list_del_init(&next->queuelist);
+	}
+
+	if (!list_empty(&el->head.queue))
+#ifndef EL_SSTF
+		target = scan_select(el);
+#else
+		target = seek_select(el);
+#endif
+	else
+		return NULL;
+
+	el->next_jiffies = jiffies;
+
+	/*
+	 * put the request on the outgoing queue
+	 */
+	if (unlikely(!list_empty(&target->request->queuelist)))
+		printk(KERN_ALERT "nate 202: request is already queued\n");
+
+	list_add(&target->request->queuelist, &q->queue_head);
+	return target->request;
+}
+
+static int dispatch_req(request_queue_t *q, int force)
+{
+	struct request *req = next_req(q, force);
+	if (!req)
+		return 0;
+	remove_req(q, req);
+	return 1;
+}
+
+/*
+ * Indicate whether next_request() has anything to submit.
+ *
+ * We check both queues here, since either one could be empty.
+ */
+static int queue_empty(request_queue_t *q)
+{
+	struct el_data *el = (struct el_data *) q->elevator->elevator_data;
+
+	return (list_empty(&q->queue_head) && list_empty(&el->head.queue));
+}
+
+/*
+ * These two functions are used to perform request merging when a bio merge
+ * has bridged the gap between two requests.  Since we have already done the
+ * work merging the contig lists in make_contiguous(), we only return
+ * something here if we know it is contiguous, to save CPU cycles when no
+ * merge is possible.
+ *
+ * TODO: benchmark with NULL functions here, since the work to do the merge
+ * may be more than the overhead of keeping another request lying around.
+ */
+static struct request *former_req(request_queue_t *q, struct request *req)
+{
+	struct el_req *e = req->elevator_private, *prev = prev_contig(e);
+
+	return is_contig_prev(prev, e->start) ? prev->request : NULL;
+}
+
+static struct request *latter_req(request_queue_t *q, struct request *req)
+{
+	struct el_req *e = req->elevator_private, *next = next_contig(e);
+
+	return is_contig_next(e->start + e->len, next) ? next->request : NULL;
+}
+
+/*
+ * Free any per-queue private resources and reset the backing-dev-info
+ * fields to the defaults.
+ *
+ * This is called for each queue when it is destroyed.  It is block device
+ * specific.  We have to reset the backing_dev stuff since we messed with
+ * the congestion and readahead values.
+ */
+static void el_exit_queue(elevator_t *e)
+{
+	struct el_data *el = e->elevator_data;
+
+	BUG_ON(!list_empty(&el->head.queue));
+
+	el->q->backing_dev_info.congested_fn = NULL;
+	el->q->backing_dev_info.congested_data = NULL;
+	el->q->backing_dev_info.ra_pages = (VM_MAX_READAHEAD * 1024) /
PAGE_CACHE_SIZE;
+
+	mempool_destroy(el->req_pool);
+	kfree(el);
+}
+
+/*
+ * Fortunately, we get to define a device-specific congestion function.
+ * This is fortunate because we have yet to find a case where we
+ * benefit from any of the effects of being 'congested', so we just
+ * turn it off.
+ *
+ * Read congestion just disables "optional" reads, from readahead and
+ * fadvise and such, which is *very* wrong for our application.  Probably
+ * I will implement dynamic tuning of ra_pages instead.
+ *
+ * Write congestion signals pdflush or FS specific flush code to stop
+ * submitting pages, but really it's better to get a lot of pages at once.
+ * The max_contig and max_write tunables should address writes-starve-reads
+ * problems in our case.
+ */
+static int congested(void *data, int rw_mask)
+{
+	return 0;
+}
+
+/*
+ * Initialize elevator private data (el_data), and allocate an el_req for
+ * each request on the free lists.
+ *
+ * This gets called for each actual queue when it is created.  It is block
+ * device specific.  Also initialize tunables to their default values, and
+ * install the congestion handler.
+ */
+static void *el_init_queue(request_queue_t *q, elevator_t *e)
+{
+	struct el_data *el;
+
+	if (!e_req_slab)
+		return NULL;
+
+	el = kmalloc_node(sizeof(struct el_data), GFP_KERNEL, q->node);
+	if (!el)
+		return NULL;
+	memset(el, 0, sizeof(struct el_data));
+
+	el->req_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
+				mempool_free_slab, e_req_slab, q->node);
+	if (!el->req_pool) {
+		kfree(el);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&el->head.queue);
+	INIT_LIST_HEAD(&el->head.contiguous);
+
+	el->max_contig = MAX_CONTIG;
+	el->max_write = MAX_WRITE;
+	el->print_interval = PRINT_INTERVAL;
+	el->pure_operation = PURE_OPERATION;
+
+	q->backing_dev_info.congested_fn = congested;
+	q->backing_dev_info.congested_data = el;
+	q->backing_dev_info.ra_pages = EL_RA_PAGES;
+
+	el->q = q;
+	el->e = e;
+
+	return el;
+}
+
+/*
+ * Free this requests private resources.
+ *
+ * This is only called when the request is already unused.
+ */
+static void put_req(request_queue_t *q, struct request *req)
+{
+	struct el_data *el = q->elevator->elevator_data;
+	struct el_req *e = req->elevator_private;
+
+	if (e) {
+		mempool_free(e, el->req_pool);
+		req->elevator_private = NULL;
+	}
+}
+
+/*
+ * Allocate and initialize the private data for the new request.
+ *
+ * Don't do anything specific to adding a request; the remaining
+ * initialization happens in add_request or insert_request.
+ */
+static int set_req(request_queue_t *q, struct request *req, struct
bio *bio, gfp_t gfp_mask)
+{
+	struct el_data *el = q->elevator->elevator_data;
+	struct el_req *e;
+
+	e = mempool_alloc(el->req_pool, gfp_mask);
+	if (!e) return 1;
+
+	memset(e, 0, sizeof(struct el_req));
+	INIT_LIST_HEAD(&e->queue);
+	INIT_LIST_HEAD(&e->contiguous);
+	e->request = req;
+
+	req->elevator_private = e;
+	return 0;
+}
+
+/*
+ * SysFS Functions for Run-Time Tunables
+ *
+ * Exports:   queue/iosched/max_contig	(units of 512B sectors)
+ *            queue/iosched/print_interval  (units of sweeps)
+ *            queue/iosched/max_write  (units of 512B sectors)
+ *            queue/iosched/pure_operation  (0, 1, 2, or 3)
+ */
+
+#define MAKE_FUNCTION(__NAME, __VAR)					\
+static ssize_t el_##__NAME##_show(elevator_t *e, char *page)		\
+{									\
+	struct el_data *el = e->elevator_data;				\
+	return sprintf(page, "%u\n", (unsigned int) __VAR);		\
+}									\
+static ssize_t el_##__NAME##_store(elevator_t *e, const char *page,
size_t count)	\
+{									\
+	struct el_data *el = e->elevator_data;				\
+	(__VAR) = (unsigned int) simple_strtoul(page, NULL, 10);	\
+	return count;							\
+}
+
+MAKE_FUNCTION(max_contig, el->max_contig);
+MAKE_FUNCTION(print_interval, el->print_interval);
+MAKE_FUNCTION(max_write, el->max_write);
+MAKE_FUNCTION(pure_operation, el->pure_operation);
+
+#undef MAKE_FUNCTION
+
+#define EL_ATTR(__NAME) \
+{			\
+	.attr = {.name = # __NAME, .mode = S_IRUGO | S_IWUSR },		\
+	.show = el_##__NAME##_show,					\
+	.store = el_##__NAME##_store,					\
+}
+
+static struct elv_fs_entry default_attrs[] = {
+	EL_ATTR(max_contig),
+	EL_ATTR(print_interval),
+	EL_ATTR(max_write),
+	EL_ATTR(pure_operation),
+	__ATTR_NULL,
+};
+
+static struct elevator_type iosched_elevator = {
+	.ops = {
+		.elevator_merge_fn = 		merge,
+		.elevator_extended_req_fn = 	extended_request,
+		.elevator_merge_req_fn =	merge_requests,
+
+		.elevator_add_req_fn =		add_req,
+		.elevator_dispatch_fn =		dispatch_req,
+
+		.elevator_queue_empty_fn =	queue_empty,
+
+		.elevator_former_req_fn =	former_req,
+		.elevator_latter_req_fn =	latter_req,
+
+		.elevator_set_req_fn =		set_req,
+		.elevator_put_req_fn = 		put_req,
+
+		.elevator_init_fn =		el_init_queue,
+		.elevator_exit_fn =		el_exit_queue,
+	},
+
+	.elevator_attrs = default_attrs,
+	.elevator_name = "elevator",
+	.elevator_owner = THIS_MODULE,
+};
+
+/*
+ * Register the scheduler, and create the slab allocator
+ * for private request data
+ */
+static int __init el_init(void)
+{
+	int err = 0;
+
+	e_req_slab = kmem_cache_create("elevator_request", sizeof(struct el_req),
+				     0, 0, NULL, NULL);
+
+	if (!e_req_slab)
+		return -ENOMEM;
+
+	err = elv_register(&iosched_elevator);
+	if (err)
+		kmem_cache_destroy(e_req_slab);
+
+	return err;
+}
+
+static void __exit el_exit(void)
+{
+	kmem_cache_destroy(e_req_slab);
+	elv_unregister(&iosched_elevator);
+}
+
+module_init(el_init);
+module_exit(el_exit);
+
+MODULE_AUTHOR("Nate Diller");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Elevator I/O scheduler");
diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/block/Kconfig.iosched
linux-dput/block/Kconfig.iosched
--- linux-2.6.18-rc1-mm2/block/Kconfig.iosched	2006-07-18
14:52:29.000000000 -0700
+++ linux-dput/block/Kconfig.iosched	2006-08-03 18:42:00.000000000 -0700
@@ -38,6 +38,37 @@ config IOSCHED_CFQ
 	  among all processes in the system. It should provide a fair
 	  working environment, suitable for desktop systems.

+config IOSCHED_ELEVATOR
+	tristate "Elevator I/O scheduler"
+	default y
+	---help---
+	  This is a simple BSD style one-way elevator.  It avoids the complexity
+	  of deadlines, and uses a limit on contiguous I/O sectors to keep things
+	  moving and reduce latency.
+
+config IOSCHED_EL_SSTF
+	bool "Alternate Heuristic: Shortest Seek Time First" if IOSCHED_ELEVATOR
+	default n
+	---help---
+	  Elevator normally uses the C-SCAN one-way elevator algorithm,
+	  which is useful in most situations to avoid queue congestion and
+	  request starvation.  In some cases, SSTF might be higher
+	  performance, particularly with certain localized workloads.
+
+	  If you don't know that you want this, you don't.
+
+config IOSCHED_EL_PERF_DEBUG
+	bool "Debug Elevator I/O performance" if IOSCHED_ELEVATOR
+	default y
+	---help---
+	  This enables extra checking to ensure that Elevator I/O scheduling
+	  is occurring without errors that could effect performance.  It
+	  will print messages into the system log if it detects problems.
+	  If your performance under Elevator is lower than you expect, or if
+	  you would like to monitor for degradation, enable this option.
+
+	  This has negligible overhead, and does not change Elevator's behavior.
+
 choice
 	prompt "Default I/O scheduler"
 	default DEFAULT_CFQ
@@ -54,6 +85,9 @@ choice
 	config DEFAULT_CFQ
 		bool "CFQ" if IOSCHED_CFQ=y

+	config DEFAULT_ELEVATOR
+		bool "Elevator" if IOSCHED_ELEVATOR=y
+
 	config DEFAULT_NOOP
 		bool "No-op"

@@ -64,6 +98,7 @@ config DEFAULT_IOSCHED
 	default "anticipatory" if DEFAULT_AS
 	default "deadline" if DEFAULT_DEADLINE
 	default "cfq" if DEFAULT_CFQ
+	default "elevator" if DEFAULT_ELEVATOR
 	default "noop" if DEFAULT_NOOP

 endmenu
diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/block/Makefile
linux-dput/block/Makefile
--- linux-2.6.18-rc1-mm2/block/Makefile	2006-06-17 18:49:35.000000000 -0700
+++ linux-dput/block/Makefile	2006-08-03 18:42:00.000000000 -0700
@@ -8,5 +8,6 @@ obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosch
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
+obj-$(CONFIG_IOSCHED_ELEVATOR)	+= elevator-iosched.o

 obj-$(CONFIG_BLK_DEV_IO_TRACE)	+= blktrace.o
diff -urpN -X dontdiff
linux-2.6.18-rc1-mm2/Documentation/block/elevator-iosched.txt
linux-dput/Documentation/block/elevator-iosched.txt
--- linux-2.6.18-rc1-mm2/Documentation/block/elevator-iosched.txt	1969-12-31
16:00:00.000000000 -0800
+++ linux-dput/Documentation/block/elevator-iosched.txt	2006-08-03
18:42:00.000000000 -0700
@@ -0,0 +1,191 @@
+linux/block/elevator-iosched.c
+
+Elevator I/O scheduler.  This implementation is intended to be much
+closer to the standard CS one-way elevator algorithm (aka C-LOOK) than
+linux has had in the past.  It also has some little enhancements as
+tunables, and is capable of collecting lots of per-sweep performance
+stats and traces.
+
+Written by Nate Diller
+Copyright (C) 2006 Digeo Inc.
+Copyright (C) 2006 Nate Diller
+
+
+
+****************
+
+Advantages of the Textbook Elevator Algorithms
+by Hans Reiser
+
+In people elevators, they ensure that the elevator never changes direction
+before it reaches the last floor in a given direction to which there is a
+request to go to it.  A difference with people elevators is that disk drives
+have a preferred direction due to disk spin direction being fixed, and large
+seeks are relatively cheap, and so we (and every textbook) have a one way
+elevator in which we go back to the beginning of the disk after we reach the
+end.  This algorithm is well studied, considered to be very robust, and
+widely used outside of Linux.
+
+It is hard to do a better job of minimizing total seek distance unless for
+some reason you know more than the elevator does about future requests not
+yet in its queues, or more about its geometry.  Its property of attending to
+the requests for the portion of the disk drive least recently attended to is
+a nice one, both for starvation avoidance, and for allowing requests to pile
+up into a dense batch before servicing them.  It also has the powerful
+advantage that it is simple to the point that filesystem authors and disk
+drive makers and other persons can optimize their code for it easily.
+
+In pure form its largest weakness is starvation of other processes due to
+one process writing a very large number of contiguous requests (e.g.
+tarring a very large tar file while other processes are trying to run).  In
+this implementation that weakness is compensated for in the starvation
+avoidance mechanisms described later, which are governed by MAX_CONTIG and
+MAX_WRITE.
+
+Another weakness occurs when there are just a few requests slowly
+accumulating at the far end of the disk drive, and a lot of requests close
+to each other in one local area that are rapidly arriving.  In such a
+circumstance it may be optimal to allow the requests that are far away to
+accumulate for a bit before servicing them.  The current algorithms do not
+compensate for that, though Nate is studying a heuristic for determining
+when it is optimal to backtrack to the beginning of a local area of heavy
+traffic rather than perform a long seek away.
+
+Historical note: What Linux originally called an "elevator" was actually a
+lowest block number first out algorithm.  That was less optimal than a real
+elevator.
+
+***************
+
+
+ Design
+
+There are two primary queues, the main elevator ordering queue (head), and
+the outgoing queue (q->queue_head).  All normal requests enter the head
+queue and are inserted into it in elevator order (increasing ->start
+sector).
+
+The "presumed" disk head position is represented by the 'fake' el_req
+contained in el_data->head.  Its ->request field is NULL, and its length is
+0.  Its ->start sector is the one just after the last sector submitted to
+disk.
+
+We usually wish to take the next request from the head queue.  However, if
+we receive a barrier request, we have to freeze all the requests on the head
+queue into a solid mass to prevent further insertions.  So we move the whole
+head queue unmodified onto the outgoing list behind anything that is already
+on it, and insertions continue to occur only on the head queue.  If there
+are requests on the dipatch list, they are submitted before anything from
+the head queue.
+
+The head queue is based on the list_head in struct el_req, but the outgoing
+queue uses the list_head in struct request.  I had planned to ignore this
+field entirely, in order to make the barrier code more convenient.
+Unfortunately, the drivers like to do a list_del() on all the requests they
+receive, so in next_req we put the request onto that queue before submitting
+it.  The outgoing queue is also used for front insertions, since there may
+not be any private structures available anyway, eg. SCSI cache sync commands
+at shutdown.  There is usually only one request in the outgoing queue at a
+time; next_req keeps re-submitting the first request on the queue until the
+queue is empty.  Only then does it check the dispatch and head queues for
+another request.
+
+
+  Operations
+
+As disks continue to grow in size, the optimal size for requests grows as
+well.  It used to be that requests which were larger than the disk's
+hardware limit for request length were relatively rare, since they would
+take a long time to complete.  Now, it's not only commonplace, but
+desireable for request length to exceed the hardware limit.  However, since
+struct request is still limited by this hardware size, a single logical
+request may be split into many request structures, each submitted to the
+disk seperately.
+
+In order to continue to treat logical requests as a single entity, even when
+they are composed of many request structures, contiguous request structures
+are chained together into headless linked lists.  I term these logical
+requests "operations", and they represent a single disk head seek.  Many of
+the internal statistics are gathered in units of operations.
+
+The comment above next_operation() gives an overview of how these lists can
+be manipulated.  It should be noted that while it is rare, two requests
+which are contiguous but are not the same direction (one is read, the other
+write) are still placed into the contig list.  However, there is an option
+to treat "mixed" r/w operations differently, see the comment in
+next_request() regarding PURE_OPERATION.
+
+
+  Tunables
+
+Although any scheduler has the option to modify the maximum number of
+readahead pages allowed for its queue, so far this one is the first to
+actually change it.  It's set to a relatively large value by default, and is
+also tunable from sysfs.  This is actually critical to performance, since
+the elevator isn't fancy enough to anticipate a process, and doesn't let any
+process monopolize the queue.  It's important that the requests which do get
+submitted are large enough to be worth the seek penalty, since the process's
+next chance to submit I/O may be delayed if the queue is full.
+
+The fact that requests are coalesced into operations in this scheduler
+introduces a problem that has not been seen in other linux schedulers.
+Since an operation is not bounded in size, it is possible for a single
+operation to grow so large that it causes very high latencies for other
+requests in the queue.  This phenomenon is known as "starvation" in the
+literature on schedulers, and although starvation has been a problem for
+some schedulers and workloads on linux, this particular problem of very
+large operations has not been present.
+
+The max_contig and max_write tunables are two (imperfect) solutions. They
+differ slightly in what they limit; max_contig is a per-operation limit,
+max_write is per-sweep.  When requests are being submitted, they are checked
+to see how many blocks have previously been submitted as part of the current
+operation.  If this number exceeds max_contig, the rest of the requests in
+the operation are skipped, and the elevator continues upward.  If the
+request is a write, the per-sweep counter of write sectors is checked
+against max_write, and if it is exceeded, all the remaining writes in that
+sweep are skipped.
+
+These two tunables are still under construction, but they have proven
+somewhat useful in practice.  Usually, max_contig should be the same size
+(in bytes) as ra_pages.  Making it smaller obviously negates the advantage
+of readahead.  Both variables should probably have some hysteresis, so that
+they don't cause highly sub-optimal behavior, like splitting requests into a
+very large and a very small segment.  It may also be worthwhile to add a
+self-tuning controller, which changes the value of ra_pages and max_contig
+in unison, in response to measured latency on the queue.
+
+The pure_operation tunable is a strange one.  In benchmarking various drives
+with heavy mixes of simultaneous reads and writes, I found that behavior can
+vary a great deal across drives, interfaces, and even motherboards.  One
+hypothesis I had was that asking a drive to read one sector and then
+immediately write the following sector could cause a full rotation latency,
+if the heads had not settled suffuciently to perform a write.  So I created
+this tunable.
+
+It works by preventing transitions, either read-to-write transitions, like I
+described, or write-to-read, or both.  It uses a bitwise operation, so echo
+1, 2, or 3 into the sysfs variable to use it.
+
+The results showed that this can effect performance, a few percent is the
+most I saw.  Sometimes, it seems to do nothing.  It's highly dependent on
+drive firmware.  And workload, obviously.  So have fun, folks.
+
+
+  Tracing
+
+There is a substantial tracing facility built into this implementation, in
+fact this scheduler's primary reason for being is to debug performance
+problems for specialized workloads.  To use the per-sweep trace, simply echo
+a value into the print_interval sysfs tunable.  For example, an interval of
+4 means that every 4 sweeps, a summary of the queue contents is printed.
+The trace macros make it really easy to add other traces as well as
+summarize the queue status for debugging.  I really need to use something
+like relayfs for this, but anyway, printk serves for the moment.
+
+
+  SSTF
+
+The SSTF feature was added on a whim.  It ignores the tunables, and probably
+breaks tracing.  I didn't ever see it perform better than SCAN, but who
+knows?
