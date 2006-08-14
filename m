Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751894AbWHNHOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWHNHOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWHNHOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:14:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751441AbWHNHOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:14:43 -0400
Date: Mon, 14 Aug 2006 00:07:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Daniel Phillips <phillips@google.com>, David Miller <davem@davemloft.net>,
       riel@redhat.com, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-Id: <20060814000736.80e652bb.akpm@osdl.org>
In-Reply-To: <1155537940.5696.117.camel@twins>
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
	<20060813185309.928472f9.akpm@osdl.org>
	<1155530453.5696.98.camel@twins>
	<20060813215853.0ed0e973.akpm@osdl.org>
	<1155531835.5696.103.camel@twins>
	<20060813222208.7e8583ac.akpm@osdl.org>
	<1155537940.5696.117.camel@twins>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 08:45:40 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Sun, 2006-08-13 at 22:22 -0700, Andrew Morton wrote:
> > On Mon, 14 Aug 2006 07:03:55 +0200
> > Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > 
> > > On Sun, 2006-08-13 at 21:58 -0700, Andrew Morton wrote:
> > > > On Mon, 14 Aug 2006 06:40:53 +0200
> > > > Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > > > 
> > > > > Testcase:
> > > > > 
> > > > > Mount an NBD device as sole swap device and mmap > physical RAM, then
> > > > > loop through touching pages only once.
> > > > 
> > > > Fix: don't try to swap over the network.  Yes, there may be some scenarios
> > > > where people have no local storage, but it's reasonable to expect anyone
> > > > who is using Linux as an "enterprise storage platform" to stick a local
> > > > disk on the thing for swap.
> > > 
> > > I wish you were right, however there seems to be a large demand to go
> > > diskless and swap over iSCSI because disks seem to be the nr. 1 failing
> > > piece of hardware in systems these days.
> > 
> > We could track dirty anonymous memory and throttle.
> > 
> > Also, there must be some value of /proc/sys/vm/min_free_kbytes at which a
> > machine is no longer deadlockable with any of these tricks.  Do we know
> > what level that is?
> 
> Not sure, the theoretical max amount of memory one can 'lose' in socket
> wait queues is well over the amount of physical memory we have in
> machines today (even for SGI); this combined with the fact that we limit
> the memory in some way to avoid DoS attacks, could make for all memory
> to be stuck in wait queues. Of course this becomes rather more unlikely
> for ever larger amounts of memory. But unlikely is never a guarantee.

What is a "socket wait queue" and how/why can it consume so much memory?

Can it be prevented from doing that?

If this refers to the socket buffers, they're mostly allocated with
at least __GFP_WAIT, aren't they?

> > 
> > > > That leaves MAP_SHARED, but mm-tracking-shared-dirty-pages.patch will fix
> > > > that, will it not?
> > > 
> > > Will makes it less likely. One can still have memory pressure, the
> > > remaining bits of memory can still get stuck in socket queues for
> > > blocked processes.
> > 
> > But there's lots of reclaimable pagecache around and kswapd will free it
> > up?
> 
> Yes, however it is possible for kswapd and direct reclaim to block on
> get_request_wait() for the nbd/iscsi request queue by sheer misfortune.

Possibly there are some situations where kswapd will get stuck on request
queues.  But as long as the block layer is correctly calling
set_queue_congested(), these are easily avoidable via
bdi_write_congested().

> In that case there will be no more reclaim; of course the more active
> processes we have the unlikelier this will be. Still with the sheer
> amount of cpu time invested in Linux its not a gamble we're likely to
> never lose.

I suspect that with mm-tracking-shared-dirty-pages.patch, a bit of tuning
and perhaps some bugfixing we can make this problem go away for all
practical purposes.  Particularly if we're prepared to require local
storage for swap (the paranoid can use RAID, no?).

Seem to me that more investigation of these options is needed before we can
justify adding lots of hard-to-test complexity to networking?
