Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272253AbRH3Orv>; Thu, 30 Aug 2001 10:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272248AbRH3Orl>; Thu, 30 Aug 2001 10:47:41 -0400
Received: from ns.ithnet.com ([217.64.64.10]:4882 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272245AbRH3Or2>;
	Thu, 30 Aug 2001 10:47:28 -0400
Date: Thu, 30 Aug 2001 16:46:34 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010830164634.3706d8f8.skraw@ithnet.com>
In-Reply-To: <20010829232929Z16206-32383+2351@humbolt.nl.linux.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com>
	<20010829232929Z16206-32383+2351@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001 01:36:10 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> > Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
> > Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
> > Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
> > Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
> > Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
> > Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
> > Aug 29 13:43:34 admin kernel:    [system_call+51/56] 
> 
> OK, I see what the problem is.  Regular memory users are consuming memory
> right down to the emergency reserve limit, beyond which only PF_MEMALLOC
> users can go.  Unfortunately, since atomic memory allocators can't wait,
> they tend to fail with high frequency in this state.  Duh.

Aehm, excuse my ignorance, but why is a "regular memory user" effectively _consuming_ the memory? I mean how does CD reading and NFS writing _consume_ memory (to such an extent)? Where _is_ this memory gone? If I stop I/O the memory is still gone. I can make at least quite a bit appear again as free, if I delete all the files I have copied via NFS before. After that I receive lots of free mem right away. Why? I would not expect the memory as validly consumed by knfsd during writing files. I mean what for? I guess from "Inact_dirty" list being _huge_, that the mem is in fact already freed again by the original allocator, but the vm holds it, until ... well I don't know. Or am I wrong?

> First, there's an effective way to make these particular atomic failures
> go away almost entirely.  The atomic memory user (in this case a network
> interrupt handler) keeps a list of pages for its private use, starting with
> an empty list.  Each time it needs a page it gets it from its private list,
> but if that list is empty it gets it from alloc_pages, and when done with
> it, returns it to its private list.  The alloc_pages call can still fail of
> course, but now it will only fail a few times as it expands its list up to
> the size required for normal traffic.  The effect on throughput should be
> roughly nothing.

Uh, I would not do that. To a shared memory pool system this is really contra-productive (is this english?). You simply let the mem vanish in some private pools, so only _one_ process (or whatever) can use it. To tell the full truth, you do not even know, if he really uses it. If he allocated it in a heavy load situation and does not give it back (or has his own weird strategy of returning it) you run out of mem only because of one flaky driver. It will not be easy as external spectator of a driver to find out if it performs well or has some memory leakage inside. You simply can't tell.
In fact I do trust kernel mem management more :-), even if it isn't performing very well currently.

> Let's try another way of dealing with it.  What I'm trying to do with the
> patch below is leave a small reserve of 1/12 of pages->min, above the
> emergency reserve, to be consumed by non-PF_MEMALLOC atomic allocators.
> Please bear in mind this is completely untested, but would you try it
> please and see if the failure frequency goes down?

Well, I will try. But must honestly mention, that the whole idea looks like a patch to patch a patch. Especially because nobody can tell what the right reserve may be. I guess this may very much depend on host layout. How do you want to make an acceptable kernel-patch for all the world out of this idea? The idea sounds obvious, but looks not very helpful for solving the basic problem.

Regards,
Stephan

