Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287440AbSADQaX>; Fri, 4 Jan 2002 11:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287449AbSADQaO>; Fri, 4 Jan 2002 11:30:14 -0500
Received: from fep01.swip.net ([130.244.199.129]:1453 "EHLO fep01-svc.swip.net")
	by vger.kernel.org with ESMTP id <S287440AbSADQaE>;
	Fri, 4 Jan 2002 11:30:04 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.2-pre3] Harddisk Performance
In-Reply-To: <20011229162930.GA317@elfie.cavy.de>
	<20011229181717.C1821@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 04 Jan 2002 17:28:48 +0100
In-Reply-To: <20011229181717.C1821@suse.de>
Message-ID: <m2sn9m5bcv.fsf@pengo.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Sat, Dec 29 2001, Heinz Diehl wrote:
> >
> > Running 2.5.2-pre3, hdparm shows up very poor harddisk performance
> > on my system compared to 2.4.x:
>
> Yes I just noticed that too (someone else reported it) -- seems to be
> due to missed merges, I'm investigating.

I have found that if the elevator says BACK_MERGE or FRONT_MERGE, but
the request queue doesn't allow the merge, the request will be put
last in the queue instead of next to the request where the merge would
have been done if allowed.

I first noticed this when playing with the pktcdvd.o module, where the
result was duplicated writes to the same packet, but it does happen
also for normal IDE hard disks.

I think this is a problem in 2.4 too, so it probably doesn't explain
why 2.5 is slower than 2.4. Maybe this is a problem with the "deadline
I/O scheduler" too. I haven't tested it yet, but it doesn't seem to
touch this part of ll_rw_blk.c.

This patch has been running for some time now on my system without
problem.

--- ll_rw_blk.c.old	Fri Jan  4 17:10:18 2002
+++ ll_rw_blk.c	Fri Jan  4 17:10:57 2002
@@ -1121,8 +1121,10 @@
 	switch (el_ret) {
 		case ELEVATOR_BACK_MERGE:
 			BUG_ON(!rq_mergeable(req));
-			if (!q->back_merge_fn(q, req, bio))
+			if (!q->back_merge_fn(q, req, bio)) {
+				insert_here = &req->queuelist;
 				break;
+			}
 
 			elv_merge_cleanup(q, req, nr_sectors);
 
@@ -1135,8 +1137,10 @@
 
 		case ELEVATOR_FRONT_MERGE:
 			BUG_ON(!rq_mergeable(req));
-			if (!q->front_merge_fn(q, req, bio))
+			if (!q->front_merge_fn(q, req, bio)) {
+				insert_here = req->queuelist.prev;
 				break;
+			}
 
 			elv_merge_cleanup(q, req, nr_sectors);
 
-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
