Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751934AbWHNIR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWHNIR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 04:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbWHNIR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 04:17:28 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:22448 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751936AbWHNIR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 04:17:27 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Phillips <phillips@google.com>, David Miller <davem@davemloft.net>,
       riel@redhat.com, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Mike Christie <michaelc@cs.wisc.edu>
In-Reply-To: <20060814000736.80e652bb.akpm@osdl.org>
References: <20060808211731.GR14627@postel.suug.ch>
	 <44DBED4C.6040604@redhat.com> <44DFA225.1020508@google.com>
	 <20060813.165540.56347790.davem@davemloft.net>
	 <44DFD262.5060106@google.com> <20060813185309.928472f9.akpm@osdl.org>
	 <1155530453.5696.98.camel@twins> <20060813215853.0ed0e973.akpm@osdl.org>
	 <1155531835.5696.103.camel@twins> <20060813222208.7e8583ac.akpm@osdl.org>
	 <1155537940.5696.117.camel@twins>  <20060814000736.80e652bb.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 10:15:52 +0200
Message-Id: <1155543352.5696.137.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 00:07 -0700, Andrew Morton wrote:
> On Mon, 14 Aug 2006 08:45:40 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > On Sun, 2006-08-13 at 22:22 -0700, Andrew Morton wrote:
> > > On Mon, 14 Aug 2006 07:03:55 +0200
> > > Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > > 
> > > > On Sun, 2006-08-13 at 21:58 -0700, Andrew Morton wrote:
> > > > > On Mon, 14 Aug 2006 06:40:53 +0200
> > > > > Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > > > > 
> > > > > > Testcase:
> > > > > > 
> > > > > > Mount an NBD device as sole swap device and mmap > physical RAM, then
> > > > > > loop through touching pages only once.
> > > > > 
> > > > > Fix: don't try to swap over the network.  Yes, there may be some scenarios
> > > > > where people have no local storage, but it's reasonable to expect anyone
> > > > > who is using Linux as an "enterprise storage platform" to stick a local
> > > > > disk on the thing for swap.
> > > > 
> > > > I wish you were right, however there seems to be a large demand to go
> > > > diskless and swap over iSCSI because disks seem to be the nr. 1 failing
> > > > piece of hardware in systems these days.
> > > 
> > > We could track dirty anonymous memory and throttle.
> > > 
> > > Also, there must be some value of /proc/sys/vm/min_free_kbytes at which a
> > > machine is no longer deadlockable with any of these tricks.  Do we know
> > > what level that is?
> > 
> > Not sure, the theoretical max amount of memory one can 'lose' in socket
> > wait queues is well over the amount of physical memory we have in
> > machines today (even for SGI); this combined with the fact that we limit
> > the memory in some way to avoid DoS attacks, could make for all memory
> > to be stuck in wait queues. Of course this becomes rather more unlikely
> > for ever larger amounts of memory. But unlikely is never a guarantee.
> 
> What is a "socket wait queue" and how/why can it consume so much memory?
> 
> Can it be prevented from doing that?
> 
> If this refers to the socket buffers, they're mostly allocated with
> at least __GFP_WAIT, aren't they?

Wherever it is that packets go if the local end is tied up and cannot
accept them instantly. The simple but prob wrong calculation I made for
evgeniy is: suppose we have 64k sockets, each socket can buffer up to
128 packets, and each packet can be up to 16k (roundup for jumboframes)
large, that makes for 128G of memory. This calculation is wrong on
several points (we can have >64k sockets, and I have no idea on the 128)
but the order of things doesn't get better.

> > > > > That leaves MAP_SHARED, but mm-tracking-shared-dirty-pages.patch will fix
> > > > > that, will it not?
> > > > 
> > > > Will makes it less likely. One can still have memory pressure, the
> > > > remaining bits of memory can still get stuck in socket queues for
> > > > blocked processes.
> > > 
> > > But there's lots of reclaimable pagecache around and kswapd will free it
> > > up?
> > 
> > Yes, however it is possible for kswapd and direct reclaim to block on
> > get_request_wait() for the nbd/iscsi request queue by sheer misfortune.
> 
> Possibly there are some situations where kswapd will get stuck on request
> queues.  But as long as the block layer is correctly calling
> set_queue_congested(), these are easily avoidable via
> bdi_write_congested().

Right, and this might, regardless of what we're going to end up doing,
be a good thing to do.

> > In that case there will be no more reclaim; of course the more active
> > processes we have the unlikelier this will be. Still with the sheer
> > amount of cpu time invested in Linux its not a gamble we're likely to
> > never lose.
> 
> I suspect that with mm-tracking-shared-dirty-pages.patch, a bit of tuning
> and perhaps some bugfixing we can make this problem go away for all
> practical purposes.  Particularly if we're prepared to require local
> storage for swap (the paranoid can use RAID, no?).
> 
> Seem to me that more investigation of these options is needed before we can
> justify adding lots of hard-to-test complexity to networking?

Well, my aim here, as disgusting as you might think it is, is to get
swap over network working. I sympathise with your stance of: don't do
that; but I have been set this task and shall try to get something that
does not offend people.

As for hard to test, I can supply some patches that would make SROG
(still find the name horrid) the default network allocator so one could
more easily test the code paths. As for the dropping of packets, I could
supply a debug control to switch it on/off regardless of memory
pressure.

As for overall complexity, A simple fallback allocator that kicks in
when the normal allocation path fails, and some simple checks to drop
packets allocated in this fashion when not bound for critical sockets
doesn't seem like a lot of complexity to me.


