Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUD0FYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUD0FYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUD0FYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:24:21 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:52096 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263776AbUD0FXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:23:10 -0400
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
	writeback
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040426205928.58d76dbc.akpm@osdl.org>
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
	 <20040426191512.69485c42.akpm@osdl.org>
	 <1083035471.3710.65.camel@lade.trondhjem.org>
	 <20040426205928.58d76dbc.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083043386.3710.201.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 01:23:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 23:59, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> No, it's purely used by tmpfs when we discover the page was under mlock or
> we've run out of swapspace.

No: either it is a bona-fide interface, in which case it belongs in the
mm/vfs, or it is a private interface, in which case it doesn't.
I can see no reason to be playing games purely for the case of tmpfs,
but if indeed there is, then it needs a *lot* more comments in the code
than is currently the case: something along the lines of "don't ever use
this unless you are tmpfs"...

> Yes, single-page writepage off the LRU is inefficient and we want
> writepages() to do most of the work.  For most workloads, this is the case.
> It's only the whacky mmap-based test which should encounter significant
> amounts of vmscan.c writepage activity.  If you're seeing much traffic via
> that route I'd be interested in knowing what the workload is.

Err... Anything that currently ends up calling writepage() and returning
WRITEPAGE_ACTIVATE. This is a problem that you believe you are seeing
the effects of, right? 
Currently, we use this on virtually anything that trigggers writepage()
with the wbc->for_reclaim flag set.

> > The idea is mainly to prevent tasks from scheduling new writes if we are
> > in the situation of wanting to reclaim or otherwise flush out dirty
> > pages. IOW: I am assuming that the writepages() method is usually called
> > only when we are low on memory and/or if pdflush() was triggered.
> 
> writepages() is called by pdflush when the dirty memory exceeds
> dirty_background_ratio and it is called by the write(2) caller when dirty
> memory exceeds dirty_ratio.
> 
> balance_dirty_pages() will throttle the write(2) caller when we hit
> dirty_ratio.  balance_dirty_pages() attempts to prevent amount of dirty
> memory from exceeding dirty_ratio by blocking the write(2) caller.

...but if the pdflush() process hangs, due to an unavailable server or
something like that, how do we prevent other processes from hanging too?
AFAICS the backing-dev->state is the only way to ensure that alternate
pdflush processes try to free memory through other means first.

> \In the various places where the VM/VFS decides "gee, we need to wait for
> some write I/O to terminate" it will call blk_congestion_wait() (the
> function is seriously misnamed nowadays).  blk_congestion_wait() will wait
> for a certain number of milliseconds, but that wait will terminate earlier
> if the block layer completes some write requests.  So if writes are being
> retired quickly, the sleeps are shorter.

We're not using the block layer.

> What we've never had, and which I expected we'd need a year ago was a
> connection between network filesytems and blk_congestion_wait().  At
> present, if someone calls blk_congestion_wait(HZ/20) when the only write
> I/O in flight is NFS, they will sleep for 50 milliseconds no matter what's
> going on.  What we should do is to deliver a wakeup from within NFS to the
> blk_congestion_wait() sleepers when write I/O has completed.  

So exactly *how* do we define the concept "write I/O has completed"
here?

AFAICS that has to be entirely defined by the MM layer since it alone
can declare that writepages() (plus whatever was racing with
writepages() at the time) has satisfied its request for reclaiming
memory.
I certainly don't want the wretched thing to be scheduling yet more
writes while I'm still busy completing the last batch. If I happen to be
on a slow network, that can cause me to enter a vicious circle where I
keep scheduling more and more I/O simply because my write speed does not
match the bandwidth expectations of the MM.
This is why I want to be throttling *all* those processes that would
otherwise be triggering yet more writepages() calls.

Cheers,
  Trond
