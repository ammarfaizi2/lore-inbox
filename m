Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272902AbTHPNxL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 09:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272915AbTHPNxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 09:53:11 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:26282 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S272902AbTHPNxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 09:53:05 -0400
Date: Sat, 16 Aug 2003 14:54:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: "Sergey S. Kostyliov" <rathamahata@php4.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre6aa1
In-Reply-To: <20030816115627.GE7862@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0308161339160.1236-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Welcome back.  Sergey and I have been in contact over this while you
were away, I kept it private so as not to inflate your mailbox further.

Brief summary (subject to confirmation by Sergey's testing) would be:
don't worry about it, it's not an -aa problem, it's a long-standing and
rare bug, in fact much less likely to occur in current 2.6 and 2.4.22-rc
than in 2.4.21 and earlier: seems Sergey's just been doing good testing.
So I've not bothered Marcelo with fixing it for 2.4.22, will submit fix
to 2.6.0-test and 2.4.23-pre later on.

You'll immediately counter what I've said there, by pointing out that
BUG_ON(inode->i_blocks) couldn't have triggered in 2.4.21 and earlier,
since I only added it in 2.4.22-pre.  True, but instead it would have
gone on to hit clear_inode's "if (inode->i_data.nrpages) BUG();"
(assuming I've identified the issue correctly).

On Sat, 16 Aug 2003, Andrea Arcangeli wrote:
> On Sun, Aug 03, 2003 at 09:12:00PM +0400, Sergey S. Kostyliov wrote:
> > On Friday 25 July 2003 23:02, Andrea Arcangeli wrote:
> > > On Fri, Jul 25, 2003 at 03:10:59PM +0400, Sergey S. Kostyliov wrote:
> > > > I doubt it depends on bigpages because they
> > > > are not used in my setup. But I can live with that. Rule: do not run
> > > > `swapoff -a` under load doesn't sound as impossible in my case (if this
> > > > is the only way to trigger this problem).

I believe the issue is that shmem_unuse_inode can swizzle a page
from swap cache back into page cache after deletion's or truncation's
truncate_inode_pages has cleaned out the page cache for that inode.

Not a great big deal in the truncation case (though it could depart
from spec: I can imagine fsx detecting inconsistency, seen before
2.4.22-pre, but not since), but dangerous in the deletion case - if
there were neither i_blocks nor nrpages BUG, then you'd end up with
a page in the cache with page->mapping pointing into freed inode.

There used to be nothing to prevent this (the info->sem I eliminated
was of no use in the swapoff case), but in 2.5 and 2.4.22-pre I added
those I_FREEING and i_size checks to shmem_unuse_inode to prevent it.

Or so I thought.  But faced with explaining Sergey's BUG_ON,
I eventually realized it's not good enough (when SMP) just to check
before adding into page cache, it needs to be checked after.

Or, as in the patch Sergey is currently testing below, shmem_truncate
must be prepared to truncate_inode_pages again.  That's the approach
I originally implemented in 2.5, but I grew disgusted with it every
time I thought of partial truncation trundling twice through
truncate_inode_pages (it can easily be avoided when nrpages == 0,
but that's unlikely in partial truncation).

So VM_PAGEIN flag stuff to restrict it to when it might be necessary;
extended to cover other races when reading the page at the same time
as truncating (though I think generic_file_read has a window of this
kind that we've never worried about).  I expect to split the patch
into several before sending Marcelo and Andrew.

There may be another piece needed, for even rarer race: what if the
truncated page arrives at shmem_writepage after shmem_truncate has
cleaned the swap pages, before it recalls truncate_inode_pages?
But I'll return to this later, I'm attending to other stuff right
now, this is all exceedingly rare (unless Sergey shows otherwise).

If Andrew happens to be reading this, yes, these subtle races and
oft-revisited solutions do shed further doubt on the whole business
of tmpfs swapcache swizzling: perhaps 2.7 can find a safer way.

> > > can you reproduce it with 2.4.21rc8aa1? If not, then likely it's a
> > > 2.5/2.6 bug that went in 2.4 during the backport. I spoke with Hugh an
> > > hour ago about this, he will soon look into this too.
> > 
> > Sorry for late responce. I wasn't able to reproduce neither oops nor
> > lockup with 2.4.21rc8aa1.

It (or rather, clear_inode's nrpages BUG) should be much easier to hit
with 2.4.21rc8aa1.  I wonder whether Sergey was just (un)lucky to hit
it in his 2.4.22pre6aa1 testing: he's not mentioned whether or not he
can reproduce it at will.  I've not been able to reproduce it at all.

There might be some kind of timing difference, which somehow makes it
easier to hit the narrower window in 2.4.22pre6aa1, but I don't see
what that is.

> ok good. I'm betting it's the shm backport that destabilized something.
> I had no time to look further into it during vacations ;), but the first
> suspect thing I mentioned to Hugh during OLS was this:
> 
> static void shmem_removepage(struct page *page)
> {
> 	if (!PageLaunder(page))
> 		shmem_free_blocks(page->mapping->host, 1);
> }
> 
> It's not exactly obvious how the accounting should change in function of
> the Launder bit. I mean, a writepage can happen even w/o the launder
> bitflag set (if it's not invoked by the vm) and I don't see how a msync
> or a vm pressure writepage trigger should be different in terms of
> accounting of the blocks in an inode.

I thought we'd settled this one then.  I understand you're suspicious
of using a PageLaunder test in that way, but it has worked correctly
in the -ac tree for a year or so.  The point is, shmem_removepage gets
called whenever shmem page removed from cache, so it gets called when
shmem_writepage moves page from page to swap cache: but in that case
the page must still be counted as occupying filesystem space, we must
not adjust shmem_free_blocks.  PageLaunder, set only during writepage,
identifies that case.  I guess I should add a comment there.

> Overall I need a bit more of time on Monday to digest the whole backport
> to be sure of what's going on and if the above is right after all.

If you have time to do so, that would be great: but I don't think it
need be your priority.  Certainly nobody else has reported a problem.

Hugh

