Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753446AbWKFQx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbWKFQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbWKFQx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:53:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2797 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753446AbWKFQxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:53:25 -0500
Date: Mon, 6 Nov 2006 08:53:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061103165854.0f3e77ad.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org> <Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
 <20061103165854.0f3e77ad.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Andrew Morton wrote:

> This has almost nothing to do with elapsed time.
> 
> How about doing, in free_pages_bulk():
> 
> 	if (zone->over_interleave_pages) {
> 		zone->over_interleave_pages = 0;
> 		node_clear(zone_to_nid(zone), full_interleave_nodes);
> 	}

Hmmm... We would also have to compare to the mininum pages 
required before clearing the node. Isnt it a bit much to have two 
comparisons added to the page free path?

> > It is needlessly expensive if its done for an allocation that is not bound 
> > to a specific node and there are other nodes with free pages. We may throw 
> > out pages that we need later.
> 
> Well it grossly changes the meaning of "interleaving".  We might as well
> call it something else.  It's not necessarily worse, but it's not
> interleaved any more.

It is going from node to node unless there is significant imbalance with 
some nodes being over the limit and some under. Then the allocations will 
take place round robin from the nodes under the limit until all are under 
the limit. Then we continue going over all nodes again.

> Actually by staying on the same node for a string of successive allocations
> it could well be quicker.  How come MPOL_INTERLEAVE doesn't already do some
> batching?   Or does it, and I missed it?

It should do interleaving because the data is to be accessed from multiple 
nodes. Clustering on a single node may create hotspots or imbalances. 
Hmmm... We should check how many nodes are remaining if there is just a 
single node left then we need to ignore the limit.
