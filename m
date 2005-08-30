Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVH3WlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVH3WlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVH3WlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:41:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47581 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932256AbVH3WlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:41:10 -0400
Message-Id: <200508302241.j7UMf8ag018433@d01av03.pok.ibm.com>
Subject: [PATCH 1/1] block: CFQ refcounting fix
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, brking@us.ibm.com
From: brking@us.ibm.com
Date: Tue, 30 Aug 2005 17:41:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I ran across a memory leak related to the cfq scheduler. The cfq
init function increments the refcnt of the associated request_queue.
This refcount gets decremented in cfq's exit function. Since blk_cleanup_queue
only calls the elevator exit function when its refcnt goes to zero, the
request_q never gets cleaned up. It didn't look like other io schedulers were
incrementing this refcnt, so I removed the refcnt increment and it fixed the
memory leak for me.

To reproduce the problem, simply use cfq and use the scsi_host scan sysfs
attribute to scan "- - -" repeatedly on a scsi host and watch the memory
vanish.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6-bjking1/drivers/block/cfq-iosched.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/block/cfq-iosched.c~cfq_refcnt_fix drivers/block/cfq-iosched.c
--- linux-2.6/drivers/block/cfq-iosched.c~cfq_refcnt_fix	2005-08-30 17:26:55.000000000 -0500
+++ linux-2.6-bjking1/drivers/block/cfq-iosched.c	2005-08-30 17:26:55.000000000 -0500
@@ -2318,7 +2318,6 @@ static int cfq_init_queue(request_queue_
 	e->elevator_data = cfqd;
 
 	cfqd->queue = q;
-	atomic_inc(&q->refcnt);
 
 	cfqd->max_queued = q->nr_requests / 4;
 	q->nr_batching = cfq_queued;
_
