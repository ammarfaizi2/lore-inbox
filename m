Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272661AbRHaKeP>; Fri, 31 Aug 2001 06:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272662AbRHaKd4>; Fri, 31 Aug 2001 06:33:56 -0400
Received: from ns.ithnet.com ([217.64.64.10]:47367 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272661AbRHaKdp>;
	Fri, 31 Aug 2001 06:33:45 -0400
Date: Fri, 31 Aug 2001 12:32:47 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010831123247.357bd4cd.skraw@ithnet.com>
In-Reply-To: <20010830175615Z16280-32384+1119@humbolt.nl.linux.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com>
	<20010829232929Z16206-32383+2351@humbolt.nl.linux.org>
	<20010830164634.3706d8f8.skraw@ithnet.com>
	<20010830175615Z16280-32384+1119@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001 20:02:55 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> In essence, the memory isn't consumed, it's bound to data.  Once we have
> data sitting on a page it's to our advantage to try to keep the page
> around as long as possible so it doesn't have to be re-read if we need it
> again.  So the normal situation is, we run with as little memory actually
> free and empty of data as possible, around 1-2%.
> 
> But there's a distinction between "free" and "freeable".  Of the remaining
> 98% of memory, most of it is freeable.  This is fine if your memory
> request is able to wait for the vm to go out and free some.  This happens
> often, and while the preliminary scanning work is being done the system
> tends to sit there in its absolute rock-bottom memory state (zone->pages
> == zone->min).  Along comes an interrupt with a memory allocation request
> and it must fail, because it can't wait.

Well, I do understand the strategy, only I tend to believe it is bs. The reason is pretty simple: with this strategy you cannot even add physical memory to your host if it runs low, because the system "uses" it for caching that is _mostly not needed_. No matter how much money you spend, you will always run low on memory and will always have allocation failures -  and performance drawbacks because of this. This _is_ bs. Furthermore your 1-2% free mem obviously doesn't take into account mem fragmentation. I checked my setup and found out that I really do have around 30 MB free mem, but sg driver fails to allocate ridiculous 32 KB. Tell me honestly: do you think this makes sense?
There is another thing that is not taken into account: how is the runtime situation while performing mem functions?
What I want to say, I would suspect it to be more probable that it is generally less time critical to do a _free_ than to do an _alloc_. On _allocs_ somebody needs mem and possibly _waits_ for actions to be done. On _free_ it is far more possible that you are in a cleanup and exit situation. But your strategy moves the work to be done from _free_ situation to _alloc_ situation meaning strategically you have to wait longer, although maybe _alloc_ and _free_ take the same time summed up. A quick and handsome system should give away mem _fast_ and cleanup things when a user _expects_ a cleanup, and not vice versa.
This looks like w*doze to me: do the wrong thing at the wrong time.

> > Uh, I would not do that. To a shared memory pool system this is really 
> > contra-productive (is this english?). You simply let the mem vanish in some 
> > private pools, so only _one_ process (or whatever) can use it.
> 
> It's not very much memory, that's the point.  But it sure hurts if it's not
> available at the time it's needed.

Well, you name it.

> Keep in mind we're solving an impossible problem here.  We have a task that
> can't wait, but needs an unknown (to the system) amount of memory.  We dance
> around this by decreeing that the allocation can fail, and the interrupt
> handler has to be able to deal with that.  Well, that works, but often not
> very fast.  In the network subsystem it translates into dropped packets.
> That's very, very bad if it happens often.  So it's ok to use a little memory
> in a less-than-frugal way if we reduce the frequency of packet dropping.

AHHHH! That really hurt me! Can't you see how this hurts: you buy _lots_ of mem, and anyway the system merely throws it away and drops pakets anyway, because it runs out of mem. "Help me if you can I'm feeling down, down!" (Lennon/McCartney). 
There is nothing impossible about this situation, only what vm makes out of it. Running a simple NFS-server with _one_ client runs out of mem on a server with 1 GB! And the best about it, it would be just the same if I had 2 GB!
Well, maybe that is in fact the reason for the problems of DRAM producers, nobody needs to buy it anymore: it does not help anyway.

Regards,
Stephan
