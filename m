Return-Path: <linux-kernel-owner+willy=40w.ods.org-S320251AbUKBFNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S320251AbUKBFNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S317689AbUKBFNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:13:51 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:20406 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S286148AbUKAWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:34:34 -0500
Date: Mon, 1 Nov 2004 23:34:19 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041101223419.GG3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161650000.1099332236@flay>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 10:03:56AM -0800, Martin J. Bligh wrote:
> [..] it was to stop cold
> allocations from eating into hot pages [..]

exactly, and I believe that hurts. bouncing on the global lock is going to
hurt more than preserving an hot page (at least on a 512-way). Plus the
cold page may very soon become hot too.

Plus you should at least allow an hot allocation to eat into the cold
pages (which didn't happen IIRC).

I simply believe using the lru ordering is a more efficient way to
implement hot/cold behaviour and it will save some minor ram too (with
big lists the reservation might even confuse the oom conditions, if the
allocation is hot, but the VM frees in the cold "stopped" list). I know
the cold list was a lot smaller so this is probably only a theoretical
issue.

> Yeah, we got bugger-all benefit out of it. The only think it might do
> is lower the latency on inital load-spikes, but basically you end up
> paying the cache fetch cost twice. But ... numbers rule - if you can come
> up with something that helps a real macro benchmark, I'll eat my non-existant
> hat ;-)

I've no idea if it will help... I only knows it helps the micro ;), but I
don't measure any slowdown.

Note that my PG_zero will boost 200% the micro benchmark even without
the idle zeroing enabled, if a big app quits all ptes will go in PG_zero
quicklist and the next 2M allocation of anonymous memory won't require
clearing. That has no downside at all. That's not something that can be
achieved with slab, plus slab wastes ram as well and it has more
overhead than PG_zero.
