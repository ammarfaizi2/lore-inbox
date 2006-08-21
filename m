Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWHUO3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWHUO3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbWHUO3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:29:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:996 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751896AbWHUO3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:29:01 -0400
Date: Tue, 22 Aug 2006 00:28:02 +1000
From: David Chinner <dgc@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: David Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Message-ID: <20060821142802.GU51703024@melbourne.sgi.com>
References: <20060815230050.GB51703024@melbourne.sgi.com> <17635.60378.733953.956807@cse.unsw.edu.au> <20060816231448.cc71fde7.akpm@osdl.org> <20060818001102.GW51703024@melbourne.sgi.com> <20060817232942.c35b1371.akpm@osdl.org> <20060818070314.GE798@suse.de> <p73hd0998is.fsf@verdi.suse.de> <17640.65491.458305.525471@cse.unsw.edu.au> <20060821031505.GQ51703024@melbourne.sgi.com> <17641.24478.496091.79901@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17641.24478.496091.79901@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 05:24:14PM +1000, Neil Brown wrote:
> On Monday August 21, dgc@sgi.com wrote:
> > On Mon, Aug 21, 2006 at 10:35:31AM +1000, Neil Brown wrote:
> > > On  August 18, ak@suse.de wrote:
> > > > Jens Axboe <axboe@suse.de> writes:
> > > > 
> > > > > On Thu, Aug 17 2006, Andrew Morton wrote:
> > > > > > It seems that the many-writers-to-different-disks workloads don't happen
> > > > > > very often.  We know this because
> > > > > > 
> > > > > > a) The 2.4 performance is utterly awful, and I never saw anybody
> > > > > >    complain and
> > > > > 
> > > > > Talk to some of the people that used DVD-RAM devices (or other
> > > > > excruciatingly slow writers) on their system, and they would disagree
> > > > > violently :-)
> > > > 
> > > > I hit this recently while doing backups to a slow external USB disk.
> > > > The system was quite unusable (some commands blocked for over a minute)
> > > 
> > > Ouch.  
> > > I suspect we are going to see more of this, as USB drive for backups
> > > is probably a very attractive option for many.
> > 
> > I can't see how this would occur on a 2.6 kernel unless the problem is
> > that all the reclaimable memory in the machine is dirty page cache pages
> > every allocation is blocking waiting for writeback to the slow device to
> > occur. That is, we filled memory with dirty pages before we got to the
> > throttle threshold.
> 
> I started writing a longish reply to this explaining how maybe that
> could happen, and then realised I had been missing important aspects
> of the code.
> 
> writeback_inodes doesn't just work on any random device as both you
> and I thought.  The 'writeback_control' structure identifies the bdi
> to be flushed and it will only call __writeback_sync_inode on inodes
> with the same bdi.

Yes, now that you point it out it is obvious :/

> This means that any process writing to a particular bdi should throttle
> against the queue limits in the bdi once we pass the dirty threshold.
> This means that it shouldn't be able to fill memory with dirty pages
> for that device (unless the bdi doesn't have a queue limit like
> nfs...).

*nod*

> But now I see another way that Jens' problem could occur... maybe.
> 
> Suppose the total Dirty+Writeback exceeds the threshold due entirely
> to the slow device, and it is slowly working its way through the
> writeback pages.
> 
> We write to some other device, make 'ratelimit_pages' pages dirty and
> then hit balance_dirty_pages.  We now need to either get the total
> dirty pages below the threshold or start writeback on 
>    1.5 * ratelimit_pages 
> pages.  As we only have 'ratelimit_pages' dirty pages we cannot start
> writeback on enough, and so must wait until Dirty+Writeback drops
> below the threshold.  And as we are waiting on the slow device, that
> could take a while (especially as it is possible that no-one is
> calling balance_dirty_pages against that bdi).

Hmm - one thing I just noticed - when we loop after sleeping, we
reset wbc->nr_to_write = write_chunk. Hence once we get into this
throttle loop, we can't break out until we drop under the threshold
even if we manage to write a few more pages.

> > That is, we allow a per-block-dev value to be set that overrides the
> > global setting for that blockdev only. Hence for slower devices
> > we can set the point at which we throttle at a much lower dirty
> > memory threshold when that block device is congested.
> > 
> 
> I don't think this would help.  The bdi with the higher threshold
> could exclude bdis with lower thresholds from making any forward
> progress. 

True - knowing the writeback is not on all superblocks changes the picture a
little :/

> Here is a question:
>   Seeing that
>       wbc.nonblocking == 0
>       wbc.older_than_this == NULL
>       wbc.range_cyclic == 0
>   in balance_dirty_pages when it calls writeback_inodes, under what
>   circumstances will writeback_inodes return with wbc.nr_to_write > 0
>   ??

The page couldn't be written out for some reason and
redirty_page_for_writepage() was called. A few filesystems call this in
different situations, generally error conditions. In that case, we end up with
wbc->pages_skipped increasing rather than wbc->nr_to_write decreasing....

> If a write error occurs it could abort early, but otherwise I think
> it will only exit early if it runs out of pages to write, because
> there aren't any dirty pages.

Yes, I think you're right, Neil.

> If that is true, then after calling writeback_inodes once,
> balance_dirty_pages should just exit.  It isn't going to find any more
> work to do next time it is called anyway.
> Either the queue was never congested, in which case we don't need to
> throttle writes, or it blocked for a while waiting for the queue to
> clean (in ->writepage) and so has successfully throttled writes.

*nod*

> So my feeling (at the moment) is that balance_dirty_pages should look
> like:
> 
>  if below threshold 
>        return
>  writeback_inodes({.bdi = mapping->backing_dev_info)} )
> 
>  while (above threshold + 10%)
>         writeback_inodes(.bdi = NULL)
>         blk_congestion_wait
> 
> and all bdis should impose a queue limit.

I don't really like the "+ 10%" in there - it's too rubbery given
the range of memory sizes Linux supports (think of an Altix with
several TBs of RAM in it ;). With bdis imposing a queue limit, the
number of writeback pages should be bound  and so we shouldn't need
headroom like this.

Hmmm - the above could put the writer to sleep on the request queue
of the slow device that holds all dirty+writeback. This could
effectively slow all writers down to the rate of the slowest device
in the system as they all attempt to do blocking writeback on the
only dirty bdi (the really slow one).

> Then we just need to deal with the case where the some of the queue
> limits of all devices exceeds the dirty threshold....
> Maybe writeout queues need to auto-adjust their queue length when some
> system-wide situation is detected.... sounds messy.

Pretty uncommon case, I think. If someone has a system like that
then tuning the system is not unreasonable....

AFAICT, all we need to do is prevent interactions between bdis and
the current problem is that we loop on clean bdis waiting for slow
dirty ones to drain.

My thoughts are along the lines of a decay in nr_to_write between
loop iterations when we don't write out enough pages (i.e. clean
bdi) so we break out of the loop sooner rather than later.
Something like:

---
 mm/page-writeback.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: 2.6.x-xfs-new/mm/page-writeback.c
===================================================================
--- 2.6.x-xfs-new.orig/mm/page-writeback.c	2006-05-29 15:14:10.000000000 +1000
+++ 2.6.x-xfs-new/mm/page-writeback.c	2006-08-21 23:53:40.849788387 +1000
@@ -195,16 +195,17 @@ static void balance_dirty_pages(struct a
 	long dirty_thresh;
 	unsigned long pages_written = 0;
 	unsigned long write_chunk = sync_writeback_pages();
+	unsigned long write_decay = write_chunk >> 2;
 
 	struct backing_dev_info *bdi = mapping->backing_dev_info;
+	struct writeback_control wbc = {
+		.bdi		= bdi,
+		.sync_mode	= WB_SYNC_NONE,
+		.older_than_this = NULL,
+		.nr_to_write	= write_chunk,
+	};
 
 	for (;;) {
-		struct writeback_control wbc = {
-			.bdi		= bdi,
-			.sync_mode	= WB_SYNC_NONE,
-			.older_than_this = NULL,
-			.nr_to_write	= write_chunk,
-		};
 
 		get_dirty_limits(&wbs, &background_thresh,
 					&dirty_thresh, mapping);
@@ -231,8 +232,14 @@ static void balance_dirty_pages(struct a
 			pages_written += write_chunk - wbc.nr_to_write;
 			if (pages_written >= write_chunk)
 				break;		/* We've done our duty */
+
+			/* Decay the remainder so we don't get stuck here
+			 * waiting for some other slow bdi to flush */
+			wbc.nr_to_write -= write_decay;
 		}
 		blk_congestion_wait(WRITE, HZ/10);
+		if (wbc.nr_to_write <= 0)
+			break;
 	}
 
 	if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh && dirty_exceeded)
---

Thoughts?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
