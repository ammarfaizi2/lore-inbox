Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWDTXjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWDTXjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWDTXjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:39:12 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:50204 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S1751282AbWDTXjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:39:11 -0400
Subject: Re: Linux 2.6.17-rc2
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Piet Delaney <piet@bluelane.com>, Jens Axboe <axboe@suse.de>,
       "David S. Miller" <davem@davemloft.net>, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604201512070.3701@g5.osdl.org>
References: <20060419200001.fe2385f4.diegocg@gmail.com>
	 <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
	 <20060420145041.GE4717@suse.de>
	 <20060420.122647.03915644.davem@davemloft.net>
	 <20060420193430.GH4717@suse.de>
	 <1145569031.25127.64.camel@piet2.bluelane.com>
	 <Pine.LNX.4.64.0604201512070.3701@g5.osdl.org>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Thu, 20 Apr 2006 16:39:03 -0700
Message-Id: <1145576344.25127.120.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2006 23:39:08.0405 (UTC) FILETIME=[9E578250:01C664D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 15:20 -0700, Linus Torvalds wrote:
> 
> On Thu, 20 Apr 2006, Piet Delaney wrote:
> > 
> > What about marking the pages Read-Only while it's being used by the
> > kernel
> 
> NO!
> 
> That's a huge mistake, and anybody that does it that way (FreeBSD) is 
> totally incompetent.

Yea, we're not using it either. 

> 
> Once you play games with page tables, you are generally better off copying 
> the data. The cost of doing page table updates and the associated TLB 
> invalidates is simply not worth it, both from a performance standpoing and 
> a complexity standpoint.

I once wrote some code to find the PTE entries for user buffers;
and as I recall the code was only about 20 lines of code. I thought 
only a small part of the TLB had to be invalidated. I never tested
or profiled it and didn't consider the multi-threading issues.

Instead of COW, I just returned information in recvmsg control
structure indicating that the buffer wasn't being use by the kernel
any longer.

I kept the list of pages involved in the zero copy in a structure
and when the kernel was done with the pages it decremented the page
count via a callback, similar to what yzy <yzy@clusterfs.com> discussed
two weeks ago on the linux-net mailing list.

I thought this structure could have pointers to the PTE's and 
mmu context to clear the PTE entries. Unfortunately it gets
messy if the zero copy's overlap onto a shared page.

I didn't study the BSD implementation well enough to appreciate
how their COW implementation worked.

> 
> Basically, if you want the highest possible performance, you do not want 
> to do TLB invalidates. And if you _don't_ want the highest possible 
> performance, you should just use regular write(), which is actually good 
> enough for most uses, and is portable and easy.

We use a zero copy, and also don't mess with the TLB. In our application
99.99% of the data is looked at but not modified (we are looking through
TCP streams for a security exploitations).

> 
> The thing is, the cost of marking things COW is not just the cost of the 
> initial page table invalidate: it's also the cost of the fault eventually 
> when you _do_ write to the page, even if at that point you decide that the 
> page is no longer shared, and the fault can just mark the page writable 
> again.

Right, it's difficult for the kernel code to change the involved PTE's
when it's done with a page. Then flushing the TLB's of involved CPU's
adds to the problem.

> 
> That cost is _bigger_ than the cost of just copying the page in the first 
> place.
> 
> The COW approach does generate some really nice benchmark numbers, because 
> the way you benchmark this thing is that you never actually write to the 
> user page in the first place, so you end up having a nice benchmark loop 
> that has to do the TLB invalidate just the _first_ time, and never has to 
> do any work ever again later on.
> 
> But you do have to realize that that is _purely_ a benchmark load. It has 
> absolutely _zero_ relevance to any real life. Zero. Nada. None. In real 
> life, COW-faulting overhead is expensive. In real life, TLB invalidates 
> (with a threaded program, and all users of this had better be threaded, or 
> they are leaving more performance on the floor) are expensive.

Yea, your right, the multi-threading it a real problem,
you would have to send a interrupt with information about which part
of the TLB needs to be invalidated to each CPU. 

> 
> I claim that Mach people (and apparently FreeBSD) are incompetent idiots. 
> Playing games with VM is bad. memory copies are _also_ bad, but quite 
> frankly, memory copies often have _less_ downside than VM games, and 
> bigger caches will only continue to drive that point home.

Yep, both of the zero copy implementations that I've worked on have
used non-VM techniques to synchronize socket buffer state between the
kernel and user space. 

-piet

> 
> 		Linus
-- 
---
piet@bluelane.com

