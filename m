Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUKAX4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUKAX4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S383770AbUKAXzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:55:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:63634 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266692AbUKAXsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 18:48:03 -0500
Date: Mon, 01 Nov 2004 15:47:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@novell.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <176650000.1099352843@flay>
In-Reply-To: <20041101223419.GG3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies to akpm if you're not getting this directly ... OSDL is spitting
my email back as spam.

> On Mon, Nov 01, 2004 at 10:03:56AM -0800, Martin J. Bligh wrote:
>> [..] it was to stop cold
>> allocations from eating into hot pages [..]
> 
> exactly, and I believe that hurts. bouncing on the global lock is going to
> hurt more than preserving an hot page (at least on a 512-way). Plus the
> cold page may very soon become hot too.

? which global lock are we talking about now? the buddy allocator? mmm,
yes, might well do. OTOH, with hot/cold pages the lock should hardly
be contended at all (512-ways scare me, yes ... but they're broken in
lots of other ways ;-) ... do we have lockmeter data from one?
 
> Plus you should at least allow an hot allocation to eat into the cold
> pages (which didn't happen IIRC).

I think the hotlist was set to refill from the cold list before it refilled
from the buddy ... or it was at one point.
 
> I simply believe using the lru ordering is a more efficient way to
> implement hot/cold behaviour and it will save some minor ram too (with
> big lists the reservation might even confuse the oom conditions, if the
> allocation is hot, but the VM frees in the cold "stopped" list). I know
> the cold list was a lot smaller so this is probably only a theoretical
> issue.

well, it'd only save RAM in theory on SMP systems where the load was
very unevenly distributed across CPUs ... it's out of the reserved pool.

>> Yeah, we got bugger-all benefit out of it. The only think it might do
>> is lower the latency on inital load-spikes, but basically you end up
>> paying the cache fetch cost twice. But ... numbers rule - if you can come
>> up with something that helps a real macro benchmark, I'll eat my non-existant
>> hat ;-)
> 
> I've no idea if it will help... I only knows it helps the micro ;), but I
> don't measure any slowdown.
> 
> Note that my PG_zero will boost 200% the micro benchmark even without
> the idle zeroing enabled, if a big app quits all ptes will go in PG_zero
> quicklist and the next 2M allocation of anonymous memory won't require
> clearing. That has no downside at all. That's not something that can be
> achieved with slab, plus slab wastes ram as well and it has more
> overhead than PG_zero.

Let's see what it does on the macro-benchmarks ;-)

M.

