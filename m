Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTIYR15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTIYR0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:26:21 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:8140 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261397AbTIYRVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:21:12 -0400
Date: Thu, 25 Sep 2003 19:20:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (12/19): tape driver.
Message-ID: <20030925172031.GM2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix use of tape block request queue pointer.
 - Remove unnecessary includes.

diffstat:
 drivers/s390/char/tape.h       |    1 -
 drivers/s390/char/tape_block.c |   12 ++++++------
 drivers/s390/char/tape_char.c  |    1 -
 3 files changed, 6 insertions(+), 8 deletions(-)

diff -urN linux-2.6/drivers/s390/char/tape.h linux-2.6-s390/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	Mon Sep  8 21:50:16 2003
+++ linux-2.6-s390/drivers/s390/char/tape.h	Thu Sep 25 18:33:30 2003
@@ -15,7 +15,6 @@
 #include <linux/config.h>
 #include <linux/blkdev.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/mtio.h>
 #include <linux/interrupt.h>
diff -urN linux-2.6/drivers/s390/char/tape_block.c linux-2.6-s390/drivers/s390/char/tape_block.c
--- linux-2.6/drivers/s390/char/tape_block.c	Mon Sep  8 21:50:19 2003
+++ linux-2.6-s390/drivers/s390/char/tape_block.c	Thu Sep 25 18:33:30 2003
@@ -10,7 +10,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
@@ -68,7 +67,7 @@
 		device->blk_data.block_position = -1;
 	device->discipline->free_bread(ccw_req);
 	if (!list_empty(&device->req_queue) ||
-	    elv_next_request(&device->blk_data.request_queue))
+	    elv_next_request(device->blk_data.request_queue))
 		tasklet_schedule(&device->blk_data.tasklet);
 }
 
@@ -88,7 +87,7 @@
 	   owns the device. tape_state != TS_IN_USE is NOT enough. */
 	if (device->tape_state != TS_IN_USE)
 		return;
-	queue = &device->blk_data.request_queue;
+	queue = device->blk_data.request_queue;
 	nr_queued = 0;
 	/* Count number of requests on ccw queue. */
 	list_for_each(l, &device->req_queue)
@@ -186,7 +185,7 @@
 	struct tape_device *device;
 
 	device = (struct tape_device *) data;
-	while (elv_next_request(&device->blk_data.request_queue)) {
+	while (elv_next_request(device->blk_data.request_queue)) {
 		INIT_LIST_HEAD(&new_req);
 		spin_lock_irq(get_ccwdev_lock(device->cdev));
 		__tape_process_blk_queue(device, &new_req);
@@ -219,9 +218,10 @@
 
 	spin_lock_init(&d->request_queue_lock);
 	q = blk_init_queue(tapeblock_request_fn, &d->request_queue_lock);
-	if (!q)
+	if (!q) {
+		rc = -ENXIO;
 		goto put_disk;
-
+	}
 	d->request_queue = q;
 	elevator_exit(q);
 	rc = elevator_init(q, &elevator_noop);
diff -urN linux-2.6/drivers/s390/char/tape_char.c linux-2.6-s390/drivers/s390/char/tape_char.c
--- linux-2.6/drivers/s390/char/tape_char.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/drivers/s390/char/tape_char.c	Thu Sep 25 18:33:30 2003
@@ -11,7 +11,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
