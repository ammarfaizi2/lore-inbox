Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933376AbWFXKUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933376AbWFXKUb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 06:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933381AbWFXKUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 06:20:31 -0400
Received: from mail.suse.de ([195.135.220.2]:1483 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933376AbWFXKUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 06:20:30 -0400
Date: Sat, 24 Jun 2006 12:20:24 +0200
From: Nick Piggin <npiggin@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul McKenney <Paul.McKenney@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Userspace RCU+rtth hack (was Re: [patch 3/3] radix-tree: RCU lockless readside)
Message-ID: <20060624102024.GA27865@wotan.suse.de>
References: <20060408134635.22479.79269.sendpatchset@linux.site> <20060408134707.22479.33814.sendpatchset@linux.site> <20060622014949.GA2202@us.ibm.com> <20060622154518.GA23109@wotan.suse.de> <20060622163032.GC1295@us.ibm.com> <20060622165551.GB23109@wotan.suse.de> <20060622174057.GF1295@us.ibm.com> <20060622182343.GA29003@wotan.suse.de> <20060622202552.GH1295@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622202552.GH1295@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 01:25:53PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 22, 2006 at 08:23:43PM +0200, Nick Piggin wrote:
> > 
> > Just out of interest, attached is my userspace RCU implementation
> > and RCU radix-tree concurrent tests for Andrew Morton's radix-tree
> > test harness.
> > 
> > The RCU implementation is only 100 lines. Awful performance, of
> > course, but I've stretched the rcu_read_lock/unlock over large
> > periods so that we can get full concurrency at the cost of a
> > bit of memory build up. And it still seems to catch use-after
> > RCU-freed errors pretty easily.
> 
> Interesting approach!  One caution -- this approach can result in
> RCU callbacks being invoked in the context of either call_rcu() or
> rcu_read_unlock().  In some legitimate uses of RCU, this can result
> in deadlock.  See Documentation/RCU/UP.txt for more info.
> 
> One solution is to have some other context (perhaps just a separate
> pthread, given that performance is not critical) to invoke the callbacks.

Ah that's true. And I knew that, but it didn't occur to me ;)

> 
> Another user-level RCU implementation is available here:
> 
> 	http://www.cs.toronto.edu/~tomhart/perflab/ipdps06.tgz

Interesting, thanks.

> I have a few user-mode implementations myself, but the lawyers won't
> let me release them.  :-(

I imagine they're quite a bit faster than my quick hack, too ;)


> 
> > Question - our kernel's call_rcu implies a smp_wmb, right? Because
> > that did catch me out initially, because I initially had no barrier
> > to prevent the freeing of the object becoming visible before
> > removal of its last reference becoming visible (fixed by adding
> > smp_wmb() in my call_rcu).
> 
> No and yes...  The kernel's call_rcu() itself does not have an smp_wmb(),
> but the Classic RCU grace-period mechanism forces a memory barrier on each
> CPU as part of grace-period detection -- which is why rcu_read_lock()
> and rcu_read_unlock() don't need memory barriers.  Looks like your need
> for an smp_wmb() in call_rcu() itself is due to the fact that you can
> execute callbacks in the context of the call_rcu() itself.

That makes sense. Thanks for clearing that up.
