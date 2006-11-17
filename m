Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755586AbWKQJ3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586AbWKQJ3z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755587AbWKQJ3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:29:55 -0500
Received: from brick.kernel.dk ([62.242.22.158]:57094 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1755586AbWKQJ3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:29:54 -0500
Date: Fri, 17 Nov 2006 10:29:25 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@osdl.org>,
       Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com, oleg@tv-sign.ru
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061117092925.GT7164@kernel.dk>
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117065128.GA5452@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16 2006, Paul E. McKenney wrote:
> On Thu, Nov 16, 2006 at 10:06:25PM -0500, Alan Stern wrote:
> > On Thu, 16 Nov 2006, Linus Torvalds wrote:
> > 
> > > 
> > > 
> > > On Thu, 16 Nov 2006, Alan Stern wrote:
> > > > On Thu, 16 Nov 2006, Linus Torvalds wrote:
> > > > >
> > > > > Paul, it would be _really_ nice to have some way to just initialize 
> > > > > that SRCU thing statically. This kind of crud is just crazy.
> > > > 
> > > > I looked into this back when SRCU was first added.  It's essentially 
> > > > impossible to do it, because the per-cpu memory allocation & usage APIs 
> > > > are completely different for the static and the dynamic cases.
> > > 
> > > I don't think that's how you'd want to do it.
> > > 
> > > There's no way to do an initialization of a percpu allocation statically. 
> > > That's pretty obvious.
> > 
> > Hmmm...  What about DEFINE_PER_CPU in include/asm-generic/percpu.h 
> > combined with setup_per_cpu_areas() in init/main.c?  So long as you want 
> > all the CPUs to start with the same initial values, it should work.
> > 
> > > What I'd suggest instead, is to make the allocation dynamic, and make it 
> > > inside the srcu functions (kind of like I did now, but I did it at a 
> > > higher level).
> > > 
> > > Doing it at the high level was trivial right now, but we may well end up 
> > > hitting this problem again if people start using SRCU more. Right now I 
> > > suspect the cpufreq notifier is the only thing that uses SRCU, and it 
> > > already showed this problem with SRCU initializers.
> > > 
> > > So I was more thinking about moving my "one special case high level hack" 
> > > down lower, down to the SRCU level, so that we'll never see _more_ of 
> > > those horrible hacks. We'll still have the hacky thing, but at least it 
> > > will be limited to a single place - the SRCU code itself.
> > 
> > Another possible approach (but equally disgusting) is to use this static 
> > allocation approach, and have the SRCU structure include both a static and 
> > a dynamic percpu pointer together with a flag indicating which should be 
> > used.
> 
> I am actually taking some suggestions you made some months ago.  At the
> time, I rejected them because they injected extra branches into the
> fastpath.  However, recent experience indicates that you (Alan Stern)
> were right and I was wrong -- turns out that the update-side overhead
> cannot be so lightly disregarded, which forces memory barriers (but
> neither atomics nor cache misses) into the fastpath.  If some application
> ends up being provably inconvenienced by the read-side overhead, they old
> implementation can be re-introduced under a different name or some such.
> 
> So, here is my current plan:
> 
> o	Add NULL checks on srcu_struct_array to srcu_read_lock(),
> 	srcu_read_unlock(), and synchronize_srcu.  These will
> 	acquire the mutex and attempt to initialize.  If out
> 	of memory, they will use the new hardluckref field.
> 
> o	Add memory barriers to srcu_read_lock() and srcu_read_unlock().
> 
> o	Also add a memory barrier or two to synchronize_srcu(), which,
> 	in combination with those in srcu_read_lock() and srcu_read_unlock(),
> 	permit removing two of the three synchronize_sched() calls
> 	in synchronize_srcu(), decreasing its latency by roughly
> 	a factor of three.
> 
> 	This change should have the added benefit of making
> 	synchronize_srcu() much easier to understand.
> 
> o	I left out the super-fastpath synchronize_srcu() because
> 	after sleeping on it, it scared me silly.  Might be OK,
> 	but needs careful thought.  The fastpath is of the form:
> 
> 	if (srcu_readers_active(sp) == 0) {
> 		smp_mb();
> 		return;
> 	}
> 
> 	prior to the mutex_lock() in synchronize_srcu().

It works for me, but the overhead is still large. Before it would take
8-12 jiffies for a synchronize_srcu() to complete without there actually
being any reader locks active, now it takes 2-3 jiffies. So it's
definitely faster, and as suspected the loss of two of three
synchronize_sched() cut down the overhead to a third.

It's still too heavy for me, by far the most calls I do to
synchronize_srcu() doesn't have any reader locks pending. I'm still a
big advocate of the fastpath srcu_readers_active() check. I can
understand the reluctance to make it the default, but for my case it's
"safe enough", so if we could either export srcu_readers_active() or
export a synchronize_srcu_fast() (or something like that), then SRCU
would be a good fit for barrier vs plug rework.

> Attached is a patch that compiles, but probably goes down in flames
> otherwise.

Works here :-)

-- 
Jens Axboe

