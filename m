Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753039AbWKFT73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbWKFT73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbWKFT73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 14:59:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752268AbWKFT72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 14:59:28 -0500
Date: Mon, 6 Nov 2006 11:59:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061106115925.1dd41a77.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
	<20061103165854.0f3e77ad.akpm@osdl.org>
	<Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006 08:53:22 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 3 Nov 2006, Andrew Morton wrote:
> 
> > This has almost nothing to do with elapsed time.
> > 
> > How about doing, in free_pages_bulk():
> > 
> > 	if (zone->over_interleave_pages) {
> > 		zone->over_interleave_pages = 0;
> > 		node_clear(zone_to_nid(zone), full_interleave_nodes);
> > 	}
> 
> Hmmm... We would also have to compare to the mininum pages 
> required before clearing the node.

OK.

> Isnt it a bit much to have two 
> comparisons added to the page free path?

Page freeing is not actually a fastpath.  It's rate-limited by the
frequency at which the CPU can _use_ the page: by filling it from disk, or
by writing to all of the page with the CPU.

Plus this is free_pages_bulk(), so the additional test occurs once per
per_cpu_pages.batch pages, not once per page.

And I assume it could be brought down to a single comparison with some
thought.

> > > It is needlessly expensive if its done for an allocation that is not bound 
> > > to a specific node and there are other nodes with free pages. We may throw 
> > > out pages that we need later.
> > 
> > Well it grossly changes the meaning of "interleaving".  We might as well
> > call it something else.  It's not necessarily worse, but it's not
> > interleaved any more.
> 
> It is going from node to node unless there is significant imbalance with 
> some nodes being over the limit and some under. Then the allocations will 
> take place round robin from the nodes under the limit until all are under 
> the limit. Then we continue going over all nodes again.

<head spins>

> > Actually by staying on the same node for a string of successive allocations
> > it could well be quicker.  How come MPOL_INTERLEAVE doesn't already do some
> > batching?   Or does it, and I missed it?
> 
> It should do interleaving because the data is to be accessed from multiple 
> nodes.

I think you missed the point.

At present the code does interleaving by taking one page from each zone and
then advancing onto the next zone, yes?

If so, this is pretty awful frmo a cache utilsiation POV.  it'd be much
better to take 16 pages from one zone before advancing onto the next one.

> Clustering on a single node may create hotspots or imbalances. 

Umm, but that's exactly what the patch we're discussing will do.

> Hmmm... We should check how many nodes are remaining if there is just a 
> single node left then we need to ignore the limit.

yup.

