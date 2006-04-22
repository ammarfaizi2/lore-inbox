Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWDVTcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWDVTcG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWDVTcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:32:06 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:63676 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751062AbWDVTcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:32:04 -0400
Date: Fri, 21 Apr 2006 23:52:22 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Piet Delaney <piet@bluelane.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       "David S. Miller" <davem@davemloft.net>, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-ID: <20060422045222.GP15855@narn.hozed.org>
References: <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org> <20060420145041.GE4717@suse.de> <20060420.122647.03915644.davem@davemloft.net> <20060420193430.GH4717@suse.de> <1145569031.25127.64.camel@piet2.bluelane.com> <Pine.LNX.4.64.0604201512070.3701@g5.osdl.org> <1145576344.25127.120.camel@piet2.bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1145576344.25127.120.camel@piet2.bluelane.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> > Basically, if you want the highest possible performance, you do not want 
> > to do TLB invalidates. And if you _don't_ want the highest possible 
> > performance, you should just use regular write(), which is actually good 
> > enough for most uses, and is portable and easy.
> 
> We use a zero copy, and also don't mess with the TLB. In our application
> 99.99% of the data is looked at but not modified (we are looking through
> TCP streams for a security exploitations).
> 
> > 
> > The thing is, the cost of marking things COW is not just the cost of the 
> > initial page table invalidate: it's also the cost of the fault eventually 
> > when you _do_ write to the page, even if at that point you decide that the 
> > page is no longer shared, and the fault can just mark the page writable 
> > again.
> 
> Right, it's difficult for the kernel code to change the involved PTE's
> when it's done with a page. Then flushing the TLB's of involved CPU's
> adds to the problem.
> 
> > 
> > That cost is _bigger_ than the cost of just copying the page in the first 
> > place.
> > 
> > The COW approach does generate some really nice benchmark numbers, because 
> > the way you benchmark this thing is that you never actually write to the 
> > user page in the first place, so you end up having a nice benchmark loop 
> > that has to do the TLB invalidate just the _first_ time, and never has to 
> > do any work ever again later on.
> > 
> > But you do have to realize that that is _purely_ a benchmark load. It has 
> > absolutely _zero_ relevance to any real life. Zero. Nada. None. In real 
> > life, COW-faulting overhead is expensive. In real life, TLB invalidates 
> > (with a threaded program, and all users of this had better be threaded, or 
> > they are leaving more performance on the floor) are expensive.
> 
> Yea, your right, the multi-threading it a real problem,
> you would have to send a interrupt with information about which part
> of the TLB needs to be invalidated to each CPU. 
> 
> > 
> > I claim that Mach people (and apparently FreeBSD) are incompetent idiots. 
> > Playing games with VM is bad. memory copies are _also_ bad, but quite 
> > frankly, memory copies often have _less_ downside than VM games, and 
> > bigger caches will only continue to drive that point home.
> 
> Yep, both of the zero copy implementations that I've worked on have
> used non-VM techniques to synchronize socket buffer state between the
> kernel and user space. 

Do any of these zero-copy implementations allow you to maintain the old
fashioned read/write semantics? I'm quite sure I can find a real-world
computational chemistry application that wants plain old read/write
for network and filesystem access (and network filesystem access), that
is going to hand you a write() of 256M that is never going to fit into
any CPU cache, and you will always be better off playing COW games
rather than saturating the memory bus with memory copies.. particularly 
because the application already saturated the memory bus of the system
doing computations on 16GB of data.

I would like to see some real numbers of *when*, not if a COW scheme
actually starts to be worth the page table flushing. This is a
trade-off, not some absolute 'COW is always bad'.

Lets also not forget that sometimes what an application cares about is
latency, not absolute performance.. so taking a *possible*, but not
certain future hit on TLB invalidates and reloads can be a win if you
get back to executing user code sooner and don't have to synchronize
with the kernel to find out you can use a page again.
