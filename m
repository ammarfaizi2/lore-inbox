Return-Path: <linux-kernel-owner+willy=40w.ods.org-S511604AbUKBC2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S511604AbUKBC2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 21:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S313821AbUKBC2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 21:28:44 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:58566 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S278873AbUKBCVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 21:21:32 -0500
Date: Tue, 2 Nov 2004 03:21:22 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041102022122.GJ3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101223419.GG3571@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 11:34:19PM +0100, Andrea Arcangeli wrote:
> On Mon, Nov 01, 2004 at 10:03:56AM -0800, Martin J. Bligh wrote:
> > [..] it was to stop cold
> > allocations from eating into hot pages [..]
> 
> exactly, and I believe that hurts. bouncing on the global lock is going to
> hurt more than preserving an hot page (at least on a 512-way). Plus the
> cold page may very soon become hot too.

I've read your reply via the web in some archive since my email is down
right now (probably some upgrade is underway).


with global I mean the buddy lock, which is global for all cpus.

The idea that the quicklist is meant to take the lock once every X pages
is limiting. The object is to never ever have to enter the buddy, not
just to "buffer" allocations. The two separated cold/hot lists prevents
that. As far as there's a single page available we should use it since
bouncing the cacheline is very costly.

It's really a question if you believe the cache effects are going to be
more significant than the cacheline bouncing on the zone lock. I do
believe the latter is several order of magnitude more severe issue.
Hence I allow fallbacks both ways (I even allow fallback across the zero
pages that carry more info than just an hot cache). Mainline doesn't
allow any fallback at all instead and that's certainly wrong.

BTW, please apply PG_zero-2-no-zerolist-reserve-1 on top of PG_zero-2
too if you're going to run any bench (PG_zero-2 alone doesn't give
zeropages to non-zero users and I don't like it that much even if it
mirrors the quicklists better). And to make a second run to disable the
idle clearing sysctl you can just write 0 into the last entry of the
per_cpu_pages syctl.

If you can run the bench with several cpus and with with mem=1G that
will put into action other bugfixes as well.

> Plus you should at least allow an hot allocation to eat into the cold
> pages (which didn't happen IIRC).

all I could see is that it doesn't fallback in 2.6.9, and that's fixed
with the single list of course ;). Plus I provide hot-cold caching on
the zero list too (zero list guarantees all pages have PG_zero set, but
that's the only difference with the hot-cold list). cold info is
retained in the zero list too so you can freely allocate with __GFP_ZERO
and __GFP_COLD, or even __GFP_ZERO|__GFP_ONLY_ZERO|__GFP_COLD etc...
