Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314643AbSE0Iy1>; Mon, 27 May 2002 04:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314670AbSE0Iy0>; Mon, 27 May 2002 04:54:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20938 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314643AbSE0Iy0>;
	Mon, 27 May 2002 04:54:26 -0400
Date: Mon, 27 May 2002 10:54:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
        "chen, xiangping" <chen_xiangping@emc.com>
Subject: Re: Poor read performance when sequential write presents
Message-ID: <20020527085414.GD17674@suse.de>
In-Reply-To: <3CED4843.2783B568@zip.com.au> <XFMail.20020524105942.pochini@shiny.it> <3CEE0758.27110CAD@zip.com.au> <20020524094606.GH14918@holomorphy.com> <3CEE1035.1E67E1B8@zip.com.au> <20020527080632.GC17674@suse.de> <3CF1ECD1.A1BB2CF1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > ...
> > > But in 2.5, head-activeness went away and as far as I know, IDE and SCSI are
> > > treated the same.  Odd.
> > 
> > It didn't really go away, it just gets handled automatically now.
> > elv_next_request() marks the request as started, in which case the i/o
> > scheduler won't consider it for merging etc. SCSI removes the request
> > directly after it has been marked started, while IDE leaves it on the
> > queue until it completes. For IDE TCQ, the behaviour is the same as with
> > SCSI.
> 
> It won't consider the active request at the head of the queue for 
> merging (making the request larger).  But it _could_ consider the
> request when making decisions about insertion (adding a new request
> at the head of the queue because it's close-on-disk to the active
> one).   Does it do that?

Only when the front request isn't active is it safe to consider
insertion in front of it. 2.5 does that exactly because it knows if the
request has been started, while 2.4 has to guess by looking at the
head-active flag and the plug status.

If the request is started, we will only consider placing in front of the
2nd request not after the 1st. We could consider in between 1st and 2nd,
that should be safe. In fact that should be perfectly safe, just move
the barrier and started test down after the insert test. *req is the
insert-after point.

diff -Nru a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	Mon May 27 10:53:53 2002
+++ b/drivers/block/elevator.c	Mon May 27 10:53:53 2002
@@ -174,9 +174,6 @@
 	while ((entry = entry->prev) != &q->queue_head) {
 		__rq = list_entry_rq(entry);
 
-		if (__rq->flags & (REQ_BARRIER | REQ_STARTED))
-			break;
-
 		/*
 		 * simply "aging" of requests in queue
 		 */
@@ -189,6 +186,9 @@
 
 		if (!*req && bio_rq_in_between(bio, __rq, &q->queue_head))
 			*req = __rq;
+
+		if (__rq->flags & (REQ_BARRIER | REQ_STARTED))
+			break;
 
 		if ((ret = elv_try_merge(__rq, bio))) {
 			if (ret == ELEVATOR_FRONT_MERGE)

-- 
Jens Axboe

