Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289561AbSAONJr>; Tue, 15 Jan 2002 08:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSAONJe>; Tue, 15 Jan 2002 08:09:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38157 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289561AbSAONJ1>;
	Tue, 15 Jan 2002 08:09:27 -0500
Date: Tue, 15 Jan 2002 14:08:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Joel Becker <jlbec@evilplan.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O_DIRECT with hardware blocksize alignment
Message-ID: <20020115140852.I31878@suse.de>
In-Reply-To: <20020109195606.A16884@parcelfarce.linux.theplanet.co.uk> <20020112133122.I1482@inspiron.school.suse.de> <20020115032126.F1929@parcelfarce.linux.theplanet.co.uk> <20020115132026.F22791@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115132026.F22791@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15 2002, Andrea Arcangeli wrote:
> actually we could also forbid merging at the ll_rw_block layer if b_size
> is not equal, maybe that's the simpler solution to that problem after
> all, merging between kiovec I/O and buffered I/O probably doesn't
> matter.

Agreed, this is also what I suggested.

--- /opt/kernel/linux-2.4.18-pre3/drivers/block/ll_rw_blk.c	Tue Jan 15 14:06:13 2002
+++ drivers/block/ll_rw_blk.c	Tue Jan 15 14:07:23 2002
@@ -694,10 +694,11 @@
 	switch (el_ret) {
 
 		case ELEVATOR_BACK_MERGE:
-			if (!q->back_merge_fn(q, req, bh, max_segments)) {
-				insert_here = &req->queue;
+			insert_here = &req->queue;
+			if (!q->back_merge_fn(q, req, bh, max_segments))
+				break;
+			if (req->current_nr_sectors != (bh->b_size >> 9))
 				break;
-			}
 			elevator->elevator_merge_cleanup_fn(q, req, count);
 			req->bhtail->b_reqnext = bh;
 			req->bhtail = bh;
@@ -708,10 +709,11 @@
 			goto out;
 
 		case ELEVATOR_FRONT_MERGE:
-			if (!q->front_merge_fn(q, req, bh, max_segments)) {
-				insert_here = req->queue.prev;
+			insert_here = req->queue.prev;
+			if (!q->front_merge_fn(q, req, bh, max_segments))
+				break;
+			if (req->current_nr_sectors != (bh->b_size >> 9))
 				break;
-			}
 			elevator->elevator_merge_cleanup_fn(q, req, count);
 			bh->b_reqnext = req->bh;
 			req->bh = bh;

-- 
Jens Axboe

