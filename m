Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWHRFuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWHRFuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 01:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWHRFuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 01:50:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964830AbWHRFuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 01:50:00 -0400
Date: Thu, 17 Aug 2006 22:49:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@suse.de>, David Chinner <dgc@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
Message-Id: <20060817224952.e418c669.akpm@osdl.org>
In-Reply-To: <1155831779.5620.15.camel@localhost>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<1155818179.5662.19.camel@localhost>
	<20060817081415.f48fbb37.akpm@osdl.org>
	<1155831779.5620.15.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 12:22:59 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Thu, 2006-08-17 at 08:14 -0700, Andrew Morton wrote:
> > Take a look at blk_congestion_wait().  It doesn't know about request
> > queues.  We'd need a new
> > 
> > void writeback_congestion_end(int rw)
> > {
> > 	wake_up(congestion_wqh[rw]);
> > }
> > 
> > or similar.
> 
> ...and how often do you want us to call this? NFS doesn't know much
> about request queues either: it writes out pages on a per-RPC call
> basis. In the worst case that could mean waking up the VM every time we
> write out a single page.
> 

Once per page would work OK, but we'd save some CPU by making it less
frequent.

This stuff isn't very precise.  We could make it precise, but it would
require a really large amount of extra locking, extra locks, etc.

The way this code all works is pretty crude and simple: a process comes
in to to some writeback and it enters a polling loop:

	while (we need to do writeback) {
		for (each superblock) {
			if (the superblock's backing_dev isn't congested) {
				stuff some more IO down it()
			}
		}
		take_a_nap();
	}

so the process remains captured in that polling loop until the
dirty-memory-exceed condition subsides.  The reason why we avoid
congsted queues is so that one thread can keep multiple queues busy: we
don't want to allow writing threads to get stuck on a single queue and
we don't want to have to provision one pdflush per spindle (or, more
precisely, per backing_dev_info).


So the question is: how do we "take a nap"?  That's blk_congestion_wait(). 
The process goes to sleep in there and gets woken up when someone thinks
that a queue might be able to take some more writeout.

A caller into blk_congestion_wait() is _supposed_ to be woken by writeback
completion.  If the timeout actually expires, something isn't right.  If we
had all the new locking in place and correct, the timeout wouldn't actually
be needed.  In theory, the timeout is only there as a fallback to handle
certain races for which we don't want to implement all that new locking to
fix.

It would be good if NFS were to implement a fixed-size "request queue",
so we can't fill all memory with NFS requests.  Then, NFS can implement
a congestion threshold at "75% full" (via its backing_dev_info) and
everything is in place.

As a halfway step it might provide benefit for NFS to poke the
congestion_wq[] every quarter megabyte or so, to kick any processes out
of their sleep so they go back to poll all the superblocks again,
earlier than they otherwise would have.  It might not make any
difference - one would need to get in there and understand the dynamic
behaviour.
