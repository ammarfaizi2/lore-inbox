Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVC2Bsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVC2Bsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVC2Bsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:48:37 -0500
Received: from fmr24.intel.com ([143.183.121.16]:47805 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262140AbVC2Bse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:48:34 -0500
Message-Id: <200503290148.j2T1mOg25279@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] new fifo I/O elevator that really does nothing at all
Date: Mon, 28 Mar 2005 17:48:21 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0AWMgzSNIkftjR7OZXy5xfWGLMA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The noop elevator is still too fat for db transaction processing workload.
Since the db application already merged all blocks before sending it down,
the I/O presented to the elevator are actually not merge-able anymore. Since
I/O are also random, we don't want to sort them either.  However the noop
elevator is still doing a linear search on the entire list of requests in
the queue.  A noop elevator after all isn't really noop.

We are proposing a true no-op elevator algorithm, no merge, no nothing. Just
do first in and first out list management for the I/O request.  The best name
I can come up with is "FIFO".  I also piggy backed the code onto noop-iosched.c.
I can easily pull those code into a separate file if people object.  Though, I
hope Jens is OK with it.


--- linux-2.6.11/drivers/block/noop-iosched.c.orig	2005-03-28 16:37:30.000000000 -0800
+++ linux-2.6.11/drivers/block/noop-iosched.c	2005-03-28 16:43:57.000000000 -0800
@@ -74,6 +74,21 @@ static struct request *elevator_noop_nex
 	return NULL;
 }

+static void elevator_fifo_add_request(request_queue_t *q, struct request *rq,
+				      int where)
+{
+	list_add_tail(&rq->queuelist, &q->queue_head);
+}
+
+static struct elevator_type elevator_fifo = {
+	.ops = {
+		.elevator_next_req_fn		= elevator_noop_next_request,
+		.elevator_add_req_fn		= elevator_fifo_add_request,
+	},
+	.elevator_name = "fifo",
+	.elevator_owner = THIS_MODULE,
+};
+
 static struct elevator_type elevator_noop = {
 	.ops = {
 		.elevator_merge_fn		= elevator_noop_merge,
@@ -87,12 +102,14 @@ static struct elevator_type elevator_noo

 static int __init noop_init(void)
 {
-	return elv_register(&elevator_noop);
+	return (elv_register(&elevator_noop) ||
+		elv_register(&elevator_fifo));
 }

 static void __exit noop_exit(void)
 {
 	elv_unregister(&elevator_noop);
+	elv_unregister(&elevator_fifo);
 }

 module_init(noop_init);


