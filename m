Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSE1Jg6>; Tue, 28 May 2002 05:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSE1Jg5>; Tue, 28 May 2002 05:36:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28870 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313300AbSE1Jg4>;
	Tue, 28 May 2002 05:36:56 -0400
Date: Tue, 28 May 2002 11:36:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
        "chen, xiangping" <chen_xiangping@emc.com>
Subject: Re: Poor read performance when sequential write presents
Message-ID: <20020528093644.GA8539@suse.de>
In-Reply-To: <3CED4843.2783B568@zip.com.au> <XFMail.20020524105942.pochini@shiny.it> <3CEE0758.27110CAD@zip.com.au> <20020524094606.GH14918@holomorphy.com> <3CEE1035.1E67E1B8@zip.com.au> <20020527080632.GC17674@suse.de> <3CF1ECD1.A1BB2CF1@zip.com.au> <20020527085414.GD17674@suse.de> <3CF1FDF8.B775DF44@zip.com.au> <20020528092503.GJ17674@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28 2002, Jens Axboe wrote:
> > hmm.  Actually the code looks a bit odd:
> > 
> >                 if (elv_linus_sequence(__rq)-- <= 0)
> >                         break;
> >                 if (!(__rq->flags & REQ_CMD))
> >                         continue;
> >                 if (elv_linus_sequence(__rq) < bio_sectors(bio))
> >                         break;
> > 
> > The first decrement is saying that elv_linus_sequence is in units of
> > requests, but the comparison (and the later `-= bio_sectors()') seems
> > to be saying it's in units of sectors.
> 
> Well, it really is in units of sectors in 2.5, the first decrement is a
> scan aging measure.

Something like this make more sense.

diff -Nru a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	Tue May 28 11:33:38 2002
+++ b/drivers/block/elevator.c	Tue May 28 11:33:38 2002
@@ -174,21 +174,8 @@
 	while ((entry = entry->prev) != &q->queue_head) {
 		__rq = list_entry_rq(entry);
 
-		if (__rq->flags & (REQ_BARRIER | REQ_STARTED))
-			break;
-
-		/*
-		 * simply "aging" of requests in queue
-		 */
-		if (elv_linus_sequence(__rq)-- <= 0)
-			break;
 		if (!(__rq->flags & REQ_CMD))
 			continue;
-		if (elv_linus_sequence(__rq) < bio_sectors(bio))
-			break;
-
-		if (!*req && bio_rq_in_between(bio, __rq, &q->queue_head))
-			*req = __rq;
 
 		if ((ret = elv_try_merge(__rq, bio))) {
 			if (ret == ELEVATOR_FRONT_MERGE)
@@ -197,6 +184,15 @@
 			q->last_merge = &__rq->queuelist;
 			break;
 		}
+
+		if (elv_linus_sequence(__rq) < bio_sectors(bio))
+			break;
+
+		if (!*req && bio_rq_in_between(bio, __rq, &q->queue_head))
+			*req = __rq;
+
+		if (__rq->flags & (REQ_BARRIER | REQ_STARTED))
+			break;
 	}
 
 	return ret;

which basically only accounts seeks (sequence is still in sectors but
that doesn't matter). We will always try and merge (don't worry,
rq_mergeable() will check barrier and started bits), the sequence check
is postponed until right before the insertion check.

-- 
Jens Axboe

