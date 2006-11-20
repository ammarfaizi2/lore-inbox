Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966640AbWKTUVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966640AbWKTUVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966642AbWKTUVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:21:33 -0500
Received: from brick.kernel.dk ([62.242.22.158]:12626 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S966640AbWKTUVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:21:31 -0500
Date: Mon, 20 Nov 2006 21:21:16 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Alan Stern <stern@rowland.harvard.edu>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061120202115.GG8055@kernel.dk>
References: <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061117183945.GA367@oleg> <20061118002845.GF2632@us.ibm.com> <20061118184624.GA163@oleg> <20061119210746.GD4427@us.ibm.com> <20061120071514.GB4077@kernel.dk> <20061120165923.GD8033@us.ibm.com> <20061120175553.GC8055@kernel.dk> <20061120200933.GG8033@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120200933.GG8033@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2006, Paul E. McKenney wrote:
> > > So the "preceding" requests have to have completed their I/O system
> > > calls?  If this is the case, does this include normal (non-direct/raw)
> > > writes and asynchronous reads?  My guess is that it would include
> > > asynchronous I/O, but not buffered writes.
> > 
> > They need not have completed, but they must have been queued at the
> > block layer level. IOW, the io scheduler must know about them. Since
> > it's a block layer device property, we really don't care about system
> > calls since any of them could amount to 1 or lots more individual io
> > requests.
> > 
> > But now we have taken a detour from the original problem. As I wrote
> > above, the io scheduler must know about the requests. When the plug list
> > ends up in the private process context, the io scheduler doesn't know
> > about it yet. When a barrier is queued, the block layer does not care
> > about io that hasn't been issued yet (dirty data in the page cache
> > perhaps), since if it hasn't been seen, it's by definition not
> > interesting. But if some of the requests reside in a different process
> > private request list, then that is a violation of this rule since it
> > should technically belong to the block layer / io scheduler at that
> > point. This is where I wanted to use SRCU.
> 
> OK.  Beyond a certain point, I would need to see the code using SRCU.

Yeah, of course. It's actually in the 'plug' branch of the block repo
(and has been for some weeks), so it's public. I'll post the updated
patch soon again.

> > > If the user-level tasks/threads/processes must explicitly synchronize,
> > > and if the pre-barrier I/O-initation syscalls have to have completed,
> > > then I am not sure that the smp_mb() is needed.  Seems like the queuing
> > > mechanisms in the syscall and the user-level synchronization would have
> > > supplied the needed memory barriers.  Or are you using some extremely
> > > lightweight user-level synchronization?
> > 
> > Once a process holds a queue plug, any write issued to that plug list
> > will do an srcu_read_lock(). So as far as I can tell, the smp_mb() is
> > needed to ensure that an immediately following synchronize_srcu() from a
> > barrier write queued on a different CPU will see that srcu_read_lock().
> 
> Is the srcu_read_lock() invoked before actually queueing the I/O?

Yes,

> Is there any interaction with the queues befory calling synchronize_srcu()?
> If yes to both, it might be possible to remove the memory barrier.

There might, there might not be. Currently it replugs the queue to
prevent a livelock if the same process currently holds a read_lock on
the queue. And I guess that will stay, so that's a yes here as well.

> That said, the overhead of the smp_mb() is so small compared to that of
> the I/O path that it might not be worth it.

I could not convince myself that it wasn't always needed, so I'd agree.

-- 
Jens Axboe

