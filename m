Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbTGADvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTGADvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:51:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14314
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265350AbTGADvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:51:00 -0400
Date: Tue, 1 Jul 2003 06:04:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: Andrew Morton <akpm@digeo.com>, mel@csn.ul.ie, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030701040459.GO3040@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030630200237.473d5f82.akpm@digeo.com> <20030701032248.GM3040@dualathlon.random> <Pine.LNX.4.55L.0307010327250.1638@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307010327250.1638@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 03:29:54AM +0000, Rik van Riel wrote:
> On Tue, 1 Jul 2003, Andrea Arcangeli wrote:
> 
> > Also think if you've a 1G box, the highmem list would be very small and
> > if you shrink it first, you'll waste an huge amount of cache. Maybe you
> > go shrink the zone normal list first in such case of unbalance?
> 
> That's why you have low and high watermarks and try to balance
> the shrinking and allocating in both zones.  Not sure how
> classzone would influence this balancing though, maybe it'd be
> harder maybe it'd be easier, but I guess it would be different.
> 
> > Overall I think rotating too fast a global list sounds much better in this
> > respect (with less infrequent GFP_KERNELS compared to the
> > highmem/pagecache/anonmemory allocation rate) as far as I can tell, but
> > I admit I didn't do any math (I didn't feel the need of a demonstration
> > but maybe we should?).
> 
> Remember that on large systems ZONE_NORMAL is often under much
> more pressure than ZONE_HIGHMEM.  Need any more arguments ? ;)

we run out of ZONE_NORMAL but until we run oom it doesn't mean we shrink
it frequently, those are pretty static allocations (the mem_map is the
most static and in turn the biggest one ;), but it doesn't mean, we
allocate 500M and release 500M in a few seconds of zone normal. Also
many like selects are released and reallocated before you've a chance to
need a shrink.

The shrinkers are the ones allocating huge chunks in a loop and never
releasing it except through the VM (an updatedb would do it with the
lots of metadata overhead, but it's not really as common as the
highmem ones).

So your argument about ZONE_NORMAL being uner much more pressure doesn't
make sense to me, in line with my answer to Andrew that the frequency
of allocations (NOTE: without later explicit deallocations but relaying
on the cache collecting in the vm).

Andrea
