Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264177AbTFDVzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbTFDVzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:55:21 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:18016 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264177AbTFDVzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:55:19 -0400
Message-ID: <3EDE6DF1.16109494@digeo.com>
Date: Wed, 04 Jun 2003 15:08:49 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.70-mm3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: DAC960 crash dequeueing request
References: <20030604220415.GA15621@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 22:08:49.0979 (UTC) FILETIME=[E08E10B0:01C32AE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien wrote:
> 
> In linux 2.5.70, with no patches applied, we've had one BUG of the form:
> 
> kernel BUG at include/linux/blkdev.h:407!
> 


The below should fix it.


diff -puN drivers/block/deadline-iosched.c~deadline-hash-removal-fix drivers/block/deadline-iosched.c
--- 25/drivers/block/deadline-iosched.c~deadline-hash-removal-fix	2003-06-04 00:50:36.000000000 -0700
+++ 25-akpm/drivers/block/deadline-iosched.c	2003-06-04 00:50:36.000000000 -0700
@@ -121,6 +121,15 @@ static inline void deadline_del_drq_hash
 		__deadline_del_drq_hash(drq);
 }
 
+static void
+deadline_remove_merge_hints(request_queue_t *q, struct deadline_rq *drq)
+{
+	deadline_del_drq_hash(drq);
+
+	if (q->last_merge == &drq->request->queuelist)
+		q->last_merge = NULL;
+}
+
 static inline void
 deadline_add_drq_hash(struct deadline_data *dd, struct deadline_rq *drq)
 {
@@ -310,7 +319,7 @@ static void deadline_remove_request(requ
 		struct deadline_data *dd = q->elevator.elevator_data;
 
 		list_del_init(&drq->fifo);
-		deadline_del_drq_hash(drq);
+		deadline_remove_merge_hints(q, drq);
 		deadline_del_drq_rb(dd, drq);
 	}
 }

_
