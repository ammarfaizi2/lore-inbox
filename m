Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTBPACH>; Sat, 15 Feb 2003 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBPACH>; Sat, 15 Feb 2003 19:02:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:16564 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264844AbTBPACG>;
	Sat, 15 Feb 2003 19:02:06 -0500
Date: Sat, 15 Feb 2003 16:12:36 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>, Anton Blanchard <anton@samba.org>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] elv_former_request reversion
Message-Id: <20030215161236.67ce3f24.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2003 00:11:56.0056 (UTC) FILETIME=[03F93980:01C2D550]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This morning's fix for elv_former_request() is causing oopses all over the
place in the IO scheduler.

Jens, remember that I did try that fix a while ago, and the same happened.

I believe it has exposed a new problem at the __make_request/attempt_front_merge
level: if attempt_front_merge() actually succeeds, the wrong request gets freed
up in elv_merged_request().

It may be best to back this change out until it can be fixed up for real.


diff -puN drivers/block/elevator.c~deadline-hack drivers/block/elevator.c
--- 25/drivers/block/elevator.c~deadline-hack	2003-02-15 15:56:56.000000000 -0800
+++ 25-akpm/drivers/block/elevator.c	2003-02-15 15:57:09.000000000 -0800
@@ -399,7 +399,7 @@ struct request *elv_former_request(reque
 	elevator_t *e = &q->elevator;
 
 	if (e->elevator_former_req_fn)
-		return e->elevator_former_req_fn(q, rq);
+		return e->elevator_latter_req_fn(q, rq);
 
 	prev = rq->queuelist.prev;
 	if (prev != &q->queue_head && prev != &rq->queuelist)

_

