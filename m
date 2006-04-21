Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWDUAJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWDUAJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWDUAJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:09:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750889AbWDUAJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:09:10 -0400
Date: Thu, 20 Apr 2006 17:09:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Piet Delaney <piet@bluelane.com>
cc: Jens Axboe <axboe@suse.de>, "David S. Miller" <davem@davemloft.net>,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
In-Reply-To: <1145576344.25127.120.camel@piet2.bluelane.com>
Message-ID: <Pine.LNX.4.64.0604201649100.3701@g5.osdl.org>
References: <20060419200001.fe2385f4.diegocg@gmail.com> 
 <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>  <20060420145041.GE4717@suse.de>
  <20060420.122647.03915644.davem@davemloft.net>  <20060420193430.GH4717@suse.de>
  <1145569031.25127.64.camel@piet2.bluelane.com>  <Pine.LNX.4.64.0604201512070.3701@g5.osdl.org>
 <1145576344.25127.120.camel@piet2.bluelane.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Apr 2006, Piet Delaney wrote:
> 
> I once wrote some code to find the PTE entries for user buffers;
> and as I recall the code was only about 20 lines of code. I thought 
> only a small part of the TLB had to be invalidated. I never tested
> or profiled it and didn't consider the multi-threading issues.

Looking up the page table entry is fairly quick, and is definitely worth 
it. It's usually just a few memory loads, and it may even be cached. So 
that part of the "VM tricks" is fine.

The cost comes when you modify it. Part of it is the initial TLB 
invalidate cost, but that actually tends to be the smaller part (although 
it can be pretty steep already, if you have to do a cross-CPU invalidate: 
that alone may already have taken more time than it would to just do a 
straightforward copy).

The bigger part tends to be that any COW approach will obviously have to 
be undone later, usually when the user writes to the page. Even if (by the 
time the fault is taken) the page is no longer shared, and undoing the COW 
is just a matter of touching the page tables again, just the cost of 
taking the fault is easily thousands of cycles.

At which point the optimization is very debatable indeed. If the COW 
actually causes a real copy and a new page to be allocated, you've lost 
everything, and you're solidly in "that sucks" territory.

> Instead of COW, I just returned information in recvmsg control
> structure indicating that the buffer wasn't being use by the kernel
> any longer.

That is very close to what I propose with vmsplice(), and yes, once you 
avoid the COW, it's a clear win to just look up the page in the page 
tables and increment a usage count.

So basically:

 - just looking up the page is cheap, and that's what vmsplice() does 
   (if people want to actually play with it, Jens now has a vmsplice() 
   implementation in his "splice" branch in his git tree on 
   brick.kernel.dk).

   It does mean that it's up to the _user_ to not write to the page again 
   until the page is no longer shared, and there are different approaches 
   to handling that. Sometimes the answer may even be that synchronization 
   is done at a much higher level (ie there's some much higher-level 
   protocol where the other end acknowledges the data).

   The fact that it's up to the user obviously means that the user has to 
   be more careful, but the upside is that you really _do_ get very high 
   performance. If there are no good synchronization mechanisms, the 
   answer may well be "don't use vmsplice()", but the point is that if you 
   _can_ synchronize some other way, vmsplice() runs like a bat out of 
   hell.

 - playing VM games where you actually modify the VM is almost always a 
   loss. It does have the advantage that the user doesn't have to be aware 
   of the VM games, but if it means that performance isn't really all that 
   much better than just a regular "write()" call, what's the point?

I'm of the opinion that we already have robust and user-friendly 
interfaces (the regular read()/write()/recvmsg/sendmgs() interfaces that 
are "synchronous" wrt data copies, and that are obviously portable). We've 
even optimized them as much as we can, so they actually perform pretty 
well.

So there's no point in a half-assed "safe VM" trick with COW, which isn't 
all that much faster. Playing tricks with zero-copy only makes sense if 
they are a _lot_ faster, and that implies that you cannot do COW. You 
really expose the fact that user-space gave a real reference to its own 
pages away, and that if user space writes to it, it writes to a buffer 
that is already in flight.

(Some users may even be able to take _advantage_ of the fact that the 
buffer is "in flight" _and_ mapped into user space after it has been 
submitted. You could imagine code that actually goes on modifying the 
buffer even while it's being queued for sending. Under some strange 
circumstances that may actually be useful, although with things like 
checksums that get invalidated by you changing the data while it's queued 
up, it may not be acceptable for everything, of course).

		Linus
