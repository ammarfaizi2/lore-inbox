Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWDTWUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWDTWUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWDTWUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:20:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932083AbWDTWUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:20:34 -0400
Date: Thu, 20 Apr 2006 15:20:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Piet Delaney <piet@bluelane.com>
cc: Jens Axboe <axboe@suse.de>, "David S. Miller" <davem@davemloft.net>,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
In-Reply-To: <1145569031.25127.64.camel@piet2.bluelane.com>
Message-ID: <Pine.LNX.4.64.0604201512070.3701@g5.osdl.org>
References: <20060419200001.fe2385f4.diegocg@gmail.com> 
 <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>  <20060420145041.GE4717@suse.de>
  <20060420.122647.03915644.davem@davemloft.net>  <20060420193430.GH4717@suse.de>
 <1145569031.25127.64.camel@piet2.bluelane.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Apr 2006, Piet Delaney wrote:
> 
> What about marking the pages Read-Only while it's being used by the
> kernel

NO!

That's a huge mistake, and anybody that does it that way (FreeBSD) is 
totally incompetent.

Once you play games with page tables, you are generally better off copying 
the data. The cost of doing page table updates and the associated TLB 
invalidates is simply not worth it, both from a performance standpoing and 
a complexity standpoint.

Basically, if you want the highest possible performance, you do not want 
to do TLB invalidates. And if you _don't_ want the highest possible 
performance, you should just use regular write(), which is actually good 
enough for most uses, and is portable and easy.

The thing is, the cost of marking things COW is not just the cost of the 
initial page table invalidate: it's also the cost of the fault eventually 
when you _do_ write to the page, even if at that point you decide that the 
page is no longer shared, and the fault can just mark the page writable 
again.

That cost is _bigger_ than the cost of just copying the page in the first 
place.

The COW approach does generate some really nice benchmark numbers, because 
the way you benchmark this thing is that you never actually write to the 
user page in the first place, so you end up having a nice benchmark loop 
that has to do the TLB invalidate just the _first_ time, and never has to 
do any work ever again later on.

But you do have to realize that that is _purely_ a benchmark load. It has 
absolutely _zero_ relevance to any real life. Zero. Nada. None. In real 
life, COW-faulting overhead is expensive. In real life, TLB invalidates 
(with a threaded program, and all users of this had better be threaded, or 
they are leaving more performance on the floor) are expensive.

I claim that Mach people (and apparently FreeBSD) are incompetent idiots. 
Playing games with VM is bad. memory copies are _also_ bad, but quite 
frankly, memory copies often have _less_ downside than VM games, and 
bigger caches will only continue to drive that point home.

		Linus
