Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWBFLzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWBFLzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWBFLzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:55:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58507 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751099AbWBFLzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:55:15 -0500
Date: Mon, 6 Feb 2006 22:55:00 +1100
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-ID: <20060206115500.GK43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <20060206054815.GJ43335175@melbourne.sgi.com> <20060205222215.313f30a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205222215.313f30a9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 10:22:15PM -0800, Andrew Morton wrote:
> David Chinner <dgc@sgi.com> wrote:
> >
> > > >From a quick peek, this code:
> > > 
> > > 			if (wbc->for_kupdate) {
> > > 				/*
> > > 				 * For the kupdate function we leave the inode
> > > 				 * at the head of sb_dirty so it will get more
> > > 				 * writeout as soon as the queue becomes
> > > 				 * uncongested.
> > > 				 */
> > > 				inode->i_state |= I_DIRTY_PAGES;
> > > 				list_move_tail(&inode->i_list, &sb->s_dirty);
> > > 
> > > 
> > > isn't working right any more.
> > 
> > If the intent is to continue writing it back until fully
> > sync'd, then shouldn't we be moving that to the tail of I/O list so
> > we don't have to iterate over the dirty list again before we try to
> > write another chunk out?
> 
> Only if dirtied_when has expired.  Until that's true I think it's right to
> move onto other (potentially expired) inodes.

The inode I'm seeing being starved has long since passed it's dirty_when
expiry....

> Your patch leaves these inodes on s_io, actually.

Correct and as intended, because wb_kupdate comes back to the s_io
list, not the s_dirty list.

> > > > It appears that it is intended to handle congested devices. The thing
> > > > is, 1024 pages on writeback is not enough to congest a single disk,
> > > > let alone a RAID box 10 or 100 times faster than a single disk.
> > > > Hence we're stopping writeback long before we congest the device.
> > > 
> > > I think the comment is misleading.  The writeout pass can terminate because
> > > wbc->nr_to_write was satisfied, as well as for queue congestion.
> > 
> > Exactly my point and what the patch addresses - it allows writeback on
> > that inode to continue from where it left off if the device was not
> > congested.
> 
> But what will it do to other inodes?  Say, ones which have expired?

Writeback for them gets delayed for a short while because we have an
inode with large amounts of aged dirty data that needs to be flushed.

XFS has behaved like this for a long time. The only problems this
caused were I/o latency and blocking pdflush incorrectly. It
could keep pdflush flushing the one inode for minutes on end.
However, I've never seen anyone report it as a bug, and the only
side effects I noticed were under high bandwidths with many parallel
write streams.

The change I sent does effectively the same as XFS did, but without
any of the subtle side effects caused by blocking and monopolising
pdflush on one inode.

> This
> inode could take many minutes to write out if it's all fragmented.

And if it's fragmented, seeking the disks will make them become congested
far faster, and we'll move onto the next inode sooner.....

> s_dirty is supposed to be kept in dirtied_when order, btw.

Yes, but that doesn't take into account s_io.

    306 static void
    307 sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
    308 {
    309         const unsigned long start = jiffies;    /* livelock avoidance */
    310
    311         if (!wbc->for_kupdate || list_empty(&sb->s_io))
    312                 list_splice_init(&sb->s_dirty, &sb->s_io);
    313
    314         while (!list_empty(&sb->s_io)) {

Correct me if I'm wrong, but my reading of this is that for
wb_kupdate, we only ever move s_dirty to s_io when s_io is empty.
then we iterate over s_io until all inodes are moved off this list
or we hit someother termination criteria. This is why i left the
large inode on the head of the s_io list until congestion was
encountered - so that wb_kupdate returned to it first in it's next
pass.

So when we get to a young inode on the s_io list, we abort the
writeback loop for that filesystem with wbc->nr_to_write > 0 and
return to wb_kupdate....

However, we still have an inode with lots of dirty data on the head of
s_dirty, which we can do nothing with until s_io is emptied by
wb_kupdate.

> > > I suspect what's happened here is that someone other than pdflush has tried
> > > to do some writeback and didn't set for_kupdate, so we ended up resetting
> > > dirtied_when.
> > 
> > If it's not wb_kupdate that is trying to write it back, and we have little
> > memory pressure, and we completed writing the file long ago, then what behaves
> > exactly like wb_kupdate for hours on end apart from wb_kupdate?
> 
> Don't know.   I'm not sure that we exactly know what's going on yet?
> The list_move_tail is supposed to put the inode at the *head* of s_dirty. 
> So it's the first one which gets encountered on the next pdflush pass.
> And I guess that's working OK.

Well, no, it's not working OK because pdflush won't come back to s_dirty
unless s_io is empty.

> Except we only write 4MB of it each five
> seconds.  Is that the case?

We write 1024 (16k) pages roughly every dirty_expire_centisecs, not every
dirty_writeback_centisecs.

> If so, why would that happen?  Take a look at wb_kupdate().

I have.

>  It's supposed
> to work *continuously* on the inodes until writeback_inodes() failed to
> write back enough pages.  It takes this as an indication that there's no
> more work to do at this time.

That indication is incorrect, then.

What nr_to_write > 0 indicates is that the *s_io list* for each
filesystem have nothing more to do, not that there is nothing
left to flush. We've moved anyhitng that has more work to onto
s_dirty, so this inidication from s_io is always going to be incorrect.

Basically, This is why I chose to leave the inode on the head
of the s_io list - that's the list pdflush returns to on it's
next iteration, it's what we indicate completion from and we've
still got work to do on this inode....

> It'd be interesting to take a look at what's happening in wb_kupdate().
> > > > Therefore, lets only move the inode back onto the dirty list if the device
> > > > really is congested. Patch against 2.6.15-rc2 below.
> > > 
> > > This'll break something else, I bet :(
> > 
> > Wonderful. What needs testing to indicate something else hasn't broken?
> 
> Hard.

Yes. And...?

> > Does anyone have any regression tests for this code?
> 
> No.

Ok.

I've done basic QA on the change i.e. sync(1) still works, fsync(2) still
works, etc. and I can run XFSQA over it, but without further guidance  as to
what the necessary testing is, I'm just handwaving saying it Works For Me....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
