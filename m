Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933986AbWKTHPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933986AbWKTHPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 02:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933987AbWKTHPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 02:15:32 -0500
Received: from brick.kernel.dk ([62.242.22.158]:35679 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S933986AbWKTHPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 02:15:31 -0500
Date: Mon, 20 Nov 2006 08:15:14 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061120071514.GB4077@kernel.dk>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061117183945.GA367@oleg> <20061118002845.GF2632@us.ibm.com> <20061118184624.GA163@oleg> <20061119210746.GD4427@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119210746.GD4427@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19 2006, Paul E. McKenney wrote:
> On Sat, Nov 18, 2006 at 09:46:24PM +0300, Oleg Nesterov wrote:
> > On 11/17, Paul E. McKenney wrote:
> > >
> > > Oleg, any thoughts about Jens's optimization?  He would code something
> > > like:
> > >
> > > 	if (srcu_readers_active(&my_srcu))
> > > 		synchronize_srcu();
> > > 	else
> > > 		smp_mb();
> > 
> > Well, this is clearly racy, no? I am not sure, but may be we can do
> > 
> > 	smp_mb();
> > 	if (srcu_readers_active(&my_srcu))
> > 		synchronize_srcu();
> > 
> > in this case we also need to add 'smp_mb()' into srcu_read_lock() after
> > 'atomic_inc(&sp->hardluckref)'.
> > 
> > > However, he is doing ordered I/O requests rather than protecting data
> > > structures.
> > 
> > Probably this makes a difference, but I don't understand this.
> 
> OK, one hypothesis here...
> 
> 	The I/Os must be somehow explicitly ordered to qualify
> 	for I/O-barrier separation.  If two independent processes
> 	issue I/Os concurrently with a third process doing an
> 	I/O barrier, the I/O barrier is free to separate the
> 	two concurrent I/Os or not, on its whim.
> 
> Jens, is the above correct?  If so, what would the two processes

That's completely correct, hence my somewhat relaxed approach with SRCU.

> need to do in order to ensure that their I/O was considered to be
> ordered with respect to the I/O barrier?  Here are some possibilities:

If we consider the barrier a barrier in a certain stream of requests,
it is the responsibility of the issuer of that barrier to ensure that
the queueing is ordered. So if two "unrelated" streams of requests with
barriers hit __make_request() at the same time, we don't go to great
lengths to ensure who gets there firt.

> 1.	I/O barriers apply only to preceding and following I/Os from
> 	the process issuing the I/O barrier.
> 
> 2.	As for #1 above, but restricted to task rather than process.
> 
> 3.	I/O system calls that have completed are ordered by the
> 	barrier to precede I/O system calls that have not yet
> 	started, but I/O system calls still in flight could legally
> 	land on either side of the concurrently executing I/O
> 	barrier.
> 
> 4.	Something else entirely?
> 
> Given some restriction like one of the above, it is entirely possible
> that we don't even need the memory barrier...

3 is the closest. The request queue doesn't really know the scope of the
barrier, it has to rely on the issuer getting it right. If you have two
competing processes issuing io and process A relies on process B issuing
a barrier, they have to synchronize that between them. Normally that is
not a problem, since that's how the file systems always did io before
barriers on items that need to be on disk (it was a serialization point
anyway, it's just a stronger one now).

That said, I think the

        smp_mb();
        if (srcu_readers_active(sp))
                synchronize_srcu();

makes the most sense.

-- 
Jens Axboe

