Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWBFFse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWBFFse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 00:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWBFFsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 00:48:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45451 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751007AbWBFFsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 00:48:32 -0500
Date: Mon, 6 Feb 2006 16:48:15 +1100
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-ID: <20060206054815.GJ43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205202733.48a02dbe.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 08:27:33PM -0800, Andrew Morton wrote:
> David Chinner <dgc@sgi.com> wrote:
> > The problem is that when you are creating thousands of files per second
> > with some data in them, the superblock I/O list blows out to approximately
> > (create rate * expiry age) inodes, and any one inode in this list will
> > get a maximum of 1024 pages written back per iteration on the list.
> 
> That code does so many different things it ain't funny.  This is why when
> one thing gets changed, something else gets broken.
> 
> The intention here is that once an inode has "expired" (dirtied_when is
> more than dirty_expire_centisecs ago), the inode will get fully synced.

Sure. And it works just fine when you're not creating lots of small
files at the same time because we iterate across s_io and s_dirty
very quickly.

However, you can't fully sync anything from pdflush with the
writeback parameters it uses without multiple passes through
this code.

> >From a quick peek, this code:
> 
> 			if (wbc->for_kupdate) {
> 				/*
> 				 * For the kupdate function we leave the inode
> 				 * at the head of sb_dirty so it will get more
> 				 * writeout as soon as the queue becomes
> 				 * uncongested.
> 				 */
> 				inode->i_state |= I_DIRTY_PAGES;
> 				list_move_tail(&inode->i_list, &sb->s_dirty);
> 
> 
> isn't working right any more.

If the intent is to continue writing it back until fully
sync'd, then shouldn't we be moving that to the tail of I/O list so
we don't have to iterate over the dirty list again before we try to
write another chunk out?

FWIW, we've never seen this problem before with XFS because prior to
2.6.15 XFS ignored wbc and block device congestion and just wrote as
much as it could cluster into a single extent in a single
do_writepages() call.  hence it would have written the 8GB in one
hit, hence we never saw this problem.

We made XFS behave nicely because it solved several problems
including preventing pdflush from sleeping on full block device
queues during writeback...

> > Looking at this comment in __sync_single_inode():
> > 
> >     196             if (wbc->for_kupdate) {
> >     197                 /*              
> >     198                  * For the kupdate function we leave the inode
> >     199                  * at the head of sb_dirty so it will get more
> >     200                  * writeout as soon as the queue becomes
> >     201                  * uncongested.
> >     202                  */
> >     203                 inode->i_state |= I_DIRTY_PAGES;
> >     204                 list_move_tail(&inode->i_list, &sb->s_dirty);
> >     205             } else {    
> > 
> > It appears that it is intended to handle congested devices. The thing
> > is, 1024 pages on writeback is not enough to congest a single disk,
> > let alone a RAID box 10 or 100 times faster than a single disk.
> > Hence we're stopping writeback long before we congest the device.
> 
> I think the comment is misleading.  The writeout pass can terminate because
> wbc->nr_to_write was satisfied, as well as for queue congestion.

Exactly my point and what the patch addresses - it allows writeback on
that inode to continue from where it left off if the device was not
congested.

> I suspect what's happened here is that someone other than pdflush has tried
> to do some writeback and didn't set for_kupdate, so we ended up resetting
> dirtied_when.

If it's not wb_kupdate that is trying to write it back, and we have little
memory pressure, and we completed writing the file long ago, then what behaves
exactly like wb_kupdate for hours on end apart from wb_kupdate?

> > Therefore, lets only move the inode back onto the dirty list if the device
> > really is congested. Patch against 2.6.15-rc2 below.
> 
> This'll break something else, I bet :(

Wonderful. What needs testing to indicate something else hasn't broken?
Does anyone have any regression tests for this code?

> I'll take a look.   Another approach would be to look at nr_to_write. ie:
> 
> 	if (wbc->for_kupdate || wmb->nr_to_write <= 0)

I just tested this and it doesn't change the default behaviour.
After writing the 4GB file ~5 minutes ago, I've seen ~10k pages go to
disk, and I still have another 140k to go. IOWs, exactly the same 
behaviour as the current code.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
