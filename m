Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993003AbWJUM7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993003AbWJUM7E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161489AbWJUM7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:59:03 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:26426 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161486AbWJUM67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:58:59 -0400
Subject: [Patch 5/5] I/O statistics through request queues: DASD
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 21 Oct 2006 14:58:56 +0200
Message-Id: <1161435536.3054.117.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gets us the following statistics data for DASD devices:

[root@t2930041 statistics]# ll /sys/kernel/debug/statistics/
total 0
drwxr-xr-x  2 root root 0 Oct 21 11:57 blkq-dasd-0.0.e978
drwxr-xr-x  2 root root 0 Oct 21 11:57 blkq-dasd-0.0.e979
drwxr-xr-x  2 root root 0 Oct 21 11:57 blkq-dasd-0.0.e97a

[root@t2930041 statistics]# cat blkq-dasd-0.0.e978/data
size_write missed 0x0
size_write 0x1000 25900
size_write 0xc000 569
size_write 0x80000 406
size_write 0x10000 276
size_write 0x14000 255
...
size_write 0x9000 40
size_read missed 0x0
size_read 0x14000 46287
size_read 0xd000 40738
size_read 0x1000 26480
size_read 0xc000 22606
size_read 0x8000 2091
...
size_read 0x60000 322
residual_write missed 0x0
residual_write 0x0 52362
residual_read missed 0x0
residual_read 0x0 205178
latency_write <=0 0
latency_write <=1 0
latency_write <=2 0
latency_write <=4 0
latency_write <=8 0
latency_write <=16 0
latency_write <=32 0
latency_write <=64 0
latency_write <=128 0
latency_write <=256 0
latency_write <=512 15043
latency_write <=1024 10374
latency_write <=2048 6306
latency_write <=4096 9260
latency_write <=8192 9647
latency_write <=16384 1421
latency_write <=32768 221
latency_write <=65536 66
latency_write <=131072 15
latency_write <=262144 6
latency_write <=524288 3
latency_write <=1048576 0
latency_write >1048576 0
latency_read <=0 0
latency_read <=1 0
latency_read <=2 0
latency_read <=4 0
latency_read <=8 0
latency_read <=16 1501
latency_read <=32 11681
latency_read <=64 66507
latency_read <=128 40401
latency_read <=256 14771
latency_read <=512 2312
latency_read <=1024 4886
latency_read <=2048 32787
latency_read <=4096 19781
latency_read <=8192 7917
latency_read <=16384 2449
latency_read <=32768 115
latency_read <=65536 57
latency_read <=131072 11
latency_read <=262144 1
latency_read <=524288 0
latency_read <=1048576 1
latency_read >1048576 0
times_issued_write <=0 0
times_issued_write <=1 52362
times_issued_write <=2 0
times_issued_write <=3 0
times_issued_write <=4 0
times_issued_write <=5 0
times_issued_write <=6 0
times_issued_write >6 0
times_issued_read <=0 0
times_issued_read <=1 205178
times_issued_read <=2 0
times_issued_read <=3 0
times_issued_read <=4 0
times_issued_read <=5 0
times_issued_read <=6 0
times_issued_read >6 0
queue_used_depth samples 257540
queue_used_depth minimum 1
queue_used_depth average 1.000
queue_used_depth maximum 1
queue_used_depth variance 0.1000

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
Acked-by: Horst Hummel <Horst.Hummel@de.ibm.com>
---

 dasd.c      |   25 ++++++++++++++++++++++++-
 dasd_diag.c |    4 ++++
 dasd_int.h  |    2 ++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff -urp a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c	2006-10-21 00:50:25.000000000 +0200
+++ b/drivers/s390/block/dasd.c	2006-10-21 11:39:56.000000000 +0200
@@ -756,6 +756,22 @@ dasd_term_IO(struct dasd_ccw_req * cqr)
 	return rc;
 }
 
+static void dasd_end_request_cb(struct dasd_ccw_req *cqr, void *data);
+
+void dasd_blkq_profiling(struct dasd_ccw_req *cqr, int complete)
+{
+	struct request_queue *q = cqr->device->request_queue;
+	struct request *rq = cqr->callback_data;
+
+	if (cqr->callback != dasd_end_request_cb)
+		return;
+	if (complete)
+		blk_queue_stat_complete(q, rq);
+	else
+		blk_queue_stat_issue(q, rq);
+}
+EXPORT_SYMBOL_GPL(dasd_blkq_profiling);
+
 /*
  * Start the i/o. This start_IO can fail if the channel is really busy.
  * In that case set up a timer to start the request later.
@@ -781,6 +797,7 @@ dasd_start_IO(struct dasd_ccw_req * cqr)
 	cqr->startclk = get_clock();
 	cqr->starttime = jiffies;
 	cqr->retries--;
+	dasd_blkq_profiling(cqr, 0);
 	rc = ccw_device_start(device->cdev, cqr->cpaddr, (long) cqr,
 			      cqr->lpm, 0);
 	switch (rc) {
@@ -997,6 +1014,9 @@ dasd_int_handler(struct ccw_device *cdev
 		return;
 	}
 
+	if (!cqr->refers)
+		dasd_blkq_profiling(cqr, 1);
+
 	/* Check for clear pending */
 	if (cqr->status == DASD_CQR_CLEAR &&
 	    irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC) {
@@ -1179,7 +1199,6 @@ dasd_end_request_cb(struct dasd_ccw_req 
 	spin_unlock_irq(&device->request_queue_lock);
 }
 
-
 /*
  * Fetch requests from the block device queue.
  */
@@ -1740,6 +1759,7 @@ static int
 dasd_alloc_queue(struct dasd_device * device)
 {
 	int rc;
+	char name[BUS_ID_SIZE + 5];
 
 	device->request_queue = blk_init_queue(do_dasd_request,
 					       &device->request_queue_lock);
@@ -1748,6 +1768,9 @@ dasd_alloc_queue(struct dasd_device * de
 
 	device->request_queue->queuedata = device;
 
+	sprintf(name, "dasd-%s", device->cdev->dev.bus_id);
+	blk_queue_stat_create(device->request_queue, name);
+
 	elevator_exit(device->request_queue->elevator);
 	rc = elevator_init(device->request_queue, "deadline");
 	if (rc) {
diff -urp a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
--- a/drivers/s390/block/dasd_diag.c	2006-10-21 00:50:25.000000000 +0200
+++ b/drivers/s390/block/dasd_diag.c	2006-10-21 11:55:28.000000000 +0200
@@ -178,9 +178,12 @@ dasd_start_diag(struct dasd_ccw_req * cq
 	cqr->starttime = jiffies;
 	cqr->retries--;
 
+	dasd_blkq_profiling(cqr, 0);
+
 	rc = dia250(&private->iob, RW_BIO);
 	switch (rc) {
 	case 0: /* Synchronous I/O finished successfully */
+		dasd_blkq_profiling(cqr, 1);
 		cqr->stopclk = get_clock();
 		cqr->status = DASD_CQR_DONE;
 		/* Indicate to calling function that only a dasd_schedule_bh()
@@ -266,6 +269,7 @@ dasd_ext_handler(__u16 code)
 		return;
 	}
 
+	dasd_blkq_profiling(cqr, 1);
 	cqr->stopclk = get_clock();
 
 	expires = 0;
diff -urp a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
--- a/drivers/s390/block/dasd_int.h	2006-10-21 00:50:25.000000000 +0200
+++ b/drivers/s390/block/dasd_int.h	2006-10-21 11:51:57.000000000 +0200
@@ -513,6 +513,8 @@ int dasd_generic_set_online(struct ccw_d
 int dasd_generic_set_offline (struct ccw_device *cdev);
 int dasd_generic_notify(struct ccw_device *, int);
 
+extern void dasd_blkq_profiling(struct dasd_ccw_req *cqr, int complete);
+
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
 extern int dasd_probeonly;


