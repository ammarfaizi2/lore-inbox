Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbUJ0GQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbUJ0GQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbUJ0GO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:14:57 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:38021 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261668AbUJ0GMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:12:19 -0400
Date: Wed, 27 Oct 2004 08:11:56 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027061156.GX14325@dualathlon.random>
References: <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <417F025F.5080001@yahoo.com.au> <20041027022920.GS14325@dualathlon.random> <417F0FA2.4090800@yahoo.com.au> <20041027032338.GU14325@dualathlon.random> <417F1746.2080607@yahoo.com.au> <20041026204308.73ee438b.akpm@osdl.org> <20041027044445.GV14325@dualathlon.random> <20041026223335.6a1dad18.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026223335.6a1dad18.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 10:33:35PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@novell.com> wrote:
> >
> > So after allocating the highmem pages we invoke kswapd
> >  again
> 
> Nope.  We don't wake kswapd until the lower zones are below pages_low as
> well.  Then we rebalance all the zones which are below pages_high.

the lower zones will always be below pages_low+lowmem_reserve forever
since the reservation is 800M of ram.

The allocator isn't using pages_low, the allocator is always using
pages_low+lowmem_reserve. This is why only highmem will be allocated and
then immediatly kswapd will be invoked again.

the lower zones are above pages_high all the time, but they're also
below pages_low+lowmem_reserve all the time.

I'm not talking about 2.6.9 with protection disabled, I'm talking about
2.6.9+lowmem_reserve enabled.

So there will definitely be a rolling on the highmem, but it's probably
ok see below:

> As I say: run a workload mix and monitor /proc/vmstat:
> 
> 	pgscan_kswapd_high
> 	pgscan_kswapd_normal
> 	pgscan_kswapd_dma
> 
> These should be increasing at rates which are proportional to their size,
> if most allocations have __GFP_HIGHMEM.

they should yes. And this is also why it shouldn't be a problem this
behaviour of kswapd despite the rolling (after all we're shrinking cache
from the lower zones too, except the highmem cache will be rolled).

I'll try to measure the above soon (and I already applied it to all
relevant trees so it'll get some beating, since the aging details are
somewhat less severe than potential deadlocks or oom kills with lots of
ram and ptes, espcially now without the incremental min we have to
enable it).
