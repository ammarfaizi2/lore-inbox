Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUD0F7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUD0F7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUD0F7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:59:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:37581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263778AbUD0F6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:58:55 -0400
Date: Mon, 26 Apr 2004 22:58:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
 writeback
Message-Id: <20040426225834.7035d2c1.akpm@osdl.org>
In-Reply-To: <1083043386.3710.201.camel@lade.trondhjem.org>
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
	<20040426191512.69485c42.akpm@osdl.org>
	<1083035471.3710.65.camel@lade.trondhjem.org>
	<20040426205928.58d76dbc.akpm@osdl.org>
	<1083043386.3710.201.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Mon, 2004-04-26 at 23:59, Andrew Morton wrote:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > No, it's purely used by tmpfs when we discover the page was under mlock or
> > we've run out of swapspace.
> 
> No: either it is a bona-fide interface, in which case it belongs in the
> mm/vfs, or it is a private interface, in which case it doesn't.
> I can see no reason to be playing games purely for the case of tmpfs,
> but if indeed there is, then it needs a *lot* more comments in the code
> than is currently the case: something along the lines of "don't ever use
> this unless you are tmpfs"...

It was designed for tmpfs's particular problems - tmpfs is quite incestuous
with the MM.

Yes, I suppose it should be renamed to TMPFS_WRITEPAGE_FAILED or something.

> > Yes, single-page writepage off the LRU is inefficient and we want
> > writepages() to do most of the work.  For most workloads, this is the case.
> > It's only the whacky mmap-based test which should encounter significant
> > amounts of vmscan.c writepage activity.  If you're seeing much traffic via
> > that route I'd be interested in knowing what the workload is.
> 
> Err... Anything that currently ends up calling writepage() and returning
> WRITEPAGE_ACTIVATE. This is a problem that you believe you are seeing
> the effects of, right? 

I didn't report the problem - Shantanu is reporting problems where all the
NFS pages are stuck on the active list and the VM has nothing to reclaim on
the inactive list.

> Currently, we use this on virtually anything that trigggers writepage()
> with the wbc->for_reclaim flag set.

Why?  Sorry, I still do not understand the effect which you're trying to
achieve?  I thought it was an efficiency thing: send more traffic via
writepages().  But your other comments seem to indicate that this is not
the primary reason.

> ...but if the pdflush() process hangs, due to an unavailable server or
> something like that, how do we prevent other processes from hanging too?

We'll lose one pdflush thread if this happens.  After that,
writeback_acquire() will fail and no other pdflush instances will get
stuck.

After that, user processes will start entering that fs trying to write
things back and they too will get stuck.

Not good.  You could do a writeback_acquire() in writepage and writepages
perhaps.

> AFAICS the backing-dev->state is the only way to ensure that alternate
> pdflush processes try to free memory through other means first.

Certainly backing_dev_info is the right place to do this.

Again, I'd need to know more about what problems you're trying to solve to
say much more.

If the only problem is the everyone-hangs-because-of-a-dead-server problem
then we can either utilise the write-congestion state or we can introduce
an additional layer of congestion avoidance (similar to writeback_acquire)
to prevent tasks from trying to write to dead NFS servers.

> > \In the various places where the VM/VFS decides "gee, we need to wait for
> > some write I/O to terminate" it will call blk_congestion_wait() (the
> > function is seriously misnamed nowadays).  blk_congestion_wait() will wait
> > for a certain number of milliseconds, but that wait will terminate earlier
> > if the block layer completes some write requests.  So if writes are being
> > retired quickly, the sleeps are shorter.
> 
> We're not using the block layer.

That's a fairly irritating comment :(

I'm trying to explain how the current congestion/collision avoidance logic
works and how I expected that it could be generalised to network-backed
filesystems.

If we can determine beforehand that writes to the server will block then
this should fall out nicely.  NFS needs to set a backing_dev flag which
says "writes to this backing_dev will block soon" and writers can then take
avoiding action.

I assume such a thing can be implemented - there's an upper bound on the
number of writes which can be in flight on the wire?

> > What we've never had, and which I expected we'd need a year ago was a
> > connection between network filesytems and blk_congestion_wait().  At
> > present, if someone calls blk_congestion_wait(HZ/20) when the only write
> > I/O in flight is NFS, they will sleep for 50 milliseconds no matter what's
> > going on.  What we should do is to deliver a wakeup from within NFS to the
> > blk_congestion_wait() sleepers when write I/O has completed.  
> 
> So exactly *how* do we define the concept "write I/O has completed"
> here?

Simplistically: wherever NFS calls end_page_writeback().  But it would be
better to do it at a higher level if poss: nfs_writeback_done_full(),
perhaps?

> AFAICS that has to be entirely defined by the MM layer since it alone
> can declare that writepages() (plus whatever was racing with
> writepages() at the time) has satisfied its request for reclaiming
> memory.

Well...  the matter of reclaiming memory is somewhat separate from all of
this.  The code in there is all designed to throttle write()rs and memory
allocators to the rate at which the I/O system can retire writes.

It sounds like the problem which you're trying to solve here is the dead
server problem?  If so, yes, that will need additional logic somewhere.

> I certainly don't want the wretched thing to be scheduling yet more
> writes while I'm still busy completing the last batch.

OK.  In that case it would be preferable for the memory reclaim code to
just skip the page altogether (via may_write_to_queue()) and to go on and
try to reclaim the next page off the LRU.

And it would be preferable for the write(2) caller to skip this superblock
altogether and to go on and start working on a different superblock. 
Setting the congestion indicator will cause this to happen.  If there are
no additional superblocks to be written then the write() caller will block
in blk_congestion_wait() and will then retry a writeback pass across the
superblocks.

> If I happen to be
> on a slow network, that can cause me to enter a vicious circle where I
> keep scheduling more and more I/O simply because my write speed does not
> match the bandwidth expectations of the MM.
> This is why I want to be throttling *all* those processes that would
> otherwise be triggering yet more writepages() calls.

Setting BDI_write_congested should have this effect for write(2) callers.

We may need an additional backing_dev flag for may_write_to_queue() to
inspect.

Bottom line: I _think_ you need to remove the WRITEPAGE_ACTIVATE stuff, set
a bdi->state flag (as well as BDI_write_congested) when the server gets
stuck, test that new flag in may_write_to_queue().
