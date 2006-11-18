Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756096AbWKRAhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096AbWKRAhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756101AbWKRAhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:37:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:44494 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1756096AbWKRAhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:37:50 -0500
Date: Fri, 17 Nov 2006 16:38:59 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com, oleg@tv-sign.ru
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061118003859.GG2632@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061117191538.GA2632@us.ibm.com> <Pine.LNX.4.44L0.0611171421270.2627-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611171421270.2627-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 02:27:15PM -0500, Alan Stern wrote:
> On Fri, 17 Nov 2006, Paul E. McKenney wrote:
> 
> > > It works for me, but the overhead is still large. Before it would take
> > > 8-12 jiffies for a synchronize_srcu() to complete without there actually
> > > being any reader locks active, now it takes 2-3 jiffies. So it's
> > > definitely faster, and as suspected the loss of two of three
> > > synchronize_sched() cut down the overhead to a third.
> > 
> > Good to hear, thank you for trying it out!
> > 
> > > It's still too heavy for me, by far the most calls I do to
> > > synchronize_srcu() doesn't have any reader locks pending. I'm still a
> > > big advocate of the fastpath srcu_readers_active() check. I can
> > > understand the reluctance to make it the default, but for my case it's
> > > "safe enough", so if we could either export srcu_readers_active() or
> > > export a synchronize_srcu_fast() (or something like that), then SRCU
> > > would be a good fit for barrier vs plug rework.
> > 
> > OK, will export the interface.  Do your queues have associated locking?
> > 
> > > > Attached is a patch that compiles, but probably goes down in flames
> > > > otherwise.
> > > 
> > > Works here :-)
> > 
> > I have at least a couple bugs that would show up under low-memory
> > situations, will fix and post an update.
> 
> Perhaps a better approach to the initialization problem would be to assume 
> that either:
> 
>     1.  The srcu_struct will be initialized before it is used, or
> 
>     2.  When it is used before initialization, the system is running
> 	only one thread.

Are these assumptions valid?  If so, they would indeed simplify things
a bit.

> In other words, statically allocated SRCU strucures that get used during
> system startup must be initialized before the system starts multitasking.  
> That seems like a reasonable requirement.
> 
> This eliminates worries about readers holding mutexes.  It doesn't 
> solve the issues surrounding your hardluckref, but maybe it makes them 
> easier to think about.

For the moment, I cheaped out and used a mutex_trylock.  If this can block,
I will need to add a separate spinlock to guard per_cpu_ref allocation.

Hmmm...  How to test this?  Time for the wrapper around alloc_percpu()
that randomly fails, I guess.  ;-)

						Thanx, Paul
