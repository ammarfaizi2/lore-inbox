Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966295AbWKTR4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966295AbWKTR4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966296AbWKTR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:56:12 -0500
Received: from brick.kernel.dk ([62.242.22.158]:34125 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S966295AbWKTR4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:56:10 -0500
Date: Mon, 20 Nov 2006 18:55:54 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Alan Stern <stern@rowland.harvard.edu>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061120175553.GC8055@kernel.dk>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061117183945.GA367@oleg> <20061118002845.GF2632@us.ibm.com> <20061118184624.GA163@oleg> <20061119210746.GD4427@us.ibm.com> <20061120071514.GB4077@kernel.dk> <20061120165923.GD8033@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120165923.GD8033@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2006, Paul E. McKenney wrote:
> On Mon, Nov 20, 2006 at 08:15:14AM +0100, Jens Axboe wrote:
> > On Sun, Nov 19 2006, Paul E. McKenney wrote:
> > > On Sat, Nov 18, 2006 at 09:46:24PM +0300, Oleg Nesterov wrote:
> > > > On 11/17, Paul E. McKenney wrote:
> > > > >
> > > > > Oleg, any thoughts about Jens's optimization?  He would code something
> > > > > like:
> > > > >
> > > > > 	if (srcu_readers_active(&my_srcu))
> > > > > 		synchronize_srcu();
> > > > > 	else
> > > > > 		smp_mb();
> > > >
> > > > Well, this is clearly racy, no? I am not sure, but may be we can do
> > > >
> > > > 	smp_mb();
> > > > 	if (srcu_readers_active(&my_srcu))
> > > > 		synchronize_srcu();
> > > >
> > > > in this case we also need to add 'smp_mb()' into srcu_read_lock() after
> > > > 'atomic_inc(&sp->hardluckref)'.
> > > >
> > > > > However, he is doing ordered I/O requests rather than protecting data
> > > > > structures.
> > > >
> > > > Probably this makes a difference, but I don't understand this.
> > >
> > > OK, one hypothesis here...
> > >
> > > 	The I/Os must be somehow explicitly ordered to qualify
> > > 	for I/O-barrier separation.  If two independent processes
> > > 	issue I/Os concurrently with a third process doing an
> > > 	I/O barrier, the I/O barrier is free to separate the
> > > 	two concurrent I/Os or not, on its whim.
> > >
> > > Jens, is the above correct?  If so, what would the two processes
> > 
> > That's completely correct, hence my somewhat relaxed approach with SRCU.
> 
> OK, less scary in that case.  ;-)

Yep, it's really not scary in any ordering sense!

> > > need to do in order to ensure that their I/O was considered to be
> > > ordered with respect to the I/O barrier?  Here are some possibilities:
> > 
> > If we consider the barrier a barrier in a certain stream of requests,
> > it is the responsibility of the issuer of that barrier to ensure that
> > the queueing is ordered. So if two "unrelated" streams of requests with
> > barriers hit __make_request() at the same time, we don't go to great
> > lengths to ensure who gets there firt.
> 
> So the "preceding" requests have to have completed their I/O system
> calls?  If this is the case, does this include normal (non-direct/raw)
> writes and asynchronous reads?  My guess is that it would include
> asynchronous I/O, but not buffered writes.

They need not have completed, but they must have been queued at the
block layer level. IOW, the io scheduler must know about them. Since
it's a block layer device property, we really don't care about system
calls since any of them could amount to 1 or lots more individual io
requests.

But now we have taken a detour from the original problem. As I wrote
above, the io scheduler must know about the requests. When the plug list
ends up in the private process context, the io scheduler doesn't know
about it yet. When a barrier is queued, the block layer does not care
about io that hasn't been issued yet (dirty data in the page cache
perhaps), since if it hasn't been seen, it's by definition not
interesting. But if some of the requests reside in a different process
private request list, then that is a violation of this rule since it
should technically belong to the block layer / io scheduler at that
point. This is where I wanted to use SRCU.

> > > 1.	I/O barriers apply only to preceding and following I/Os from
> > > 	the process issuing the I/O barrier.
> > >
> > > 2.	As for #1 above, but restricted to task rather than process.
> > >
> > > 3.	I/O system calls that have completed are ordered by the
> > > 	barrier to precede I/O system calls that have not yet
> > > 	started, but I/O system calls still in flight could legally
> > > 	land on either side of the concurrently executing I/O
> > > 	barrier.
> > >
> > > 4.	Something else entirely?
> > >
> > > Given some restriction like one of the above, it is entirely possible
> > > that we don't even need the memory barrier...
> > 
> > 3 is the closest. The request queue doesn't really know the scope of the
> > barrier, it has to rely on the issuer getting it right. If you have two
> > competing processes issuing io and process A relies on process B issuing
> > a barrier, they have to synchronize that between them. Normally that is
> > not a problem, since that's how the file systems always did io before
> > barriers on items that need to be on disk (it was a serialization point
> > anyway, it's just a stronger one now).
> 
> So something like a user-level mutex or atomic instructions must be used
> by the tasks doing the pre-barrier I/Os to announce that these I/Os have
> been started in the kernel.

We don't do barriers from user space, it's purely a feature available to
file systems to ensure ordering of writes even at the disk platter
level.

> > That said, I think the
> > 
> >         smp_mb();
> >         if (srcu_readers_active(sp))
> >                 synchronize_srcu();
> > 
> > makes the most sense.
> 
> If the user-level tasks/threads/processes must explicitly synchronize,
> and if the pre-barrier I/O-initation syscalls have to have completed,
> then I am not sure that the smp_mb() is needed.  Seems like the queuing
> mechanisms in the syscall and the user-level synchronization would have
> supplied the needed memory barriers.  Or are you using some extremely
> lightweight user-level synchronization?

Once a process holds a queue plug, any write issued to that plug list
will do an srcu_read_lock(). So as far as I can tell, the smp_mb() is
needed to ensure that an immediately following synchronize_srcu() from a
barrier write queued on a different CPU will see that srcu_read_lock().

There are no syscall or user-level synchronization.

-- 
Jens Axboe

