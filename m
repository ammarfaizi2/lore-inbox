Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289577AbSAON4t>; Tue, 15 Jan 2002 08:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289579AbSAON4j>; Tue, 15 Jan 2002 08:56:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41231 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289577AbSAON4a>;
	Tue, 15 Jan 2002 08:56:30 -0500
Date: Tue, 15 Jan 2002 14:55:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Joel Becker <jlbec@evilplan.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O_DIRECT with hardware blocksize alignment
Message-ID: <20020115145549.M31878@suse.de>
In-Reply-To: <20020109195606.A16884@parcelfarce.linux.theplanet.co.uk> <20020112133122.I1482@inspiron.school.suse.de> <20020115032126.F1929@parcelfarce.linux.theplanet.co.uk> <20020115132026.F22791@athlon.random> <20020115140852.I31878@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115140852.I31878@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15 2002, Jens Axboe wrote:
> On Tue, Jan 15 2002, Andrea Arcangeli wrote:
> > actually we could also forbid merging at the ll_rw_block layer if b_size
> > is not equal, maybe that's the simpler solution to that problem after
> > all, merging between kiovec I/O and buffered I/O probably doesn't
> > matter.
> 
> Agreed, this is also what I suggested.

Here's the right version, sorry. This still potentially decrements
elevator sequence wrongly for a missed front merge, but that's an issue
I can definitely live with :-)

--- /opt/kernel/linux-2.4.18-pre3/drivers/block/ll_rw_blk.c	Tue Jan 15 14:06:13 2002
+++ drivers/block/ll_rw_blk.c	Tue Jan 15 14:54:20 2002
@@ -694,10 +694,11 @@
 	switch (el_ret) {
 
 		case ELEVATOR_BACK_MERGE:
-			if (!q->back_merge_fn(q, req, bh, max_segments)) {
-				insert_here = &req->queue;
+			insert_here = &req->queue;
+			if (req->current_nr_sectors != count)
+				break;
+			if (!q->back_merge_fn(q, req, bh, max_segments))
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
+			if (req->current_nr_sectors != count)
+				break;
+			if (!q->front_merge_fn(q, req, bh, max_segments))
 				break;
-			}
 			elevator->elevator_merge_cleanup_fn(q, req, count);
 			bh->b_reqnext = req->bh;
 			req->bh = bh;

-- 
Jens Axboe

