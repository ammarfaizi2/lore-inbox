Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTDNPHF (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTDNPHF (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:07:05 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:25585 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263424AbTDNPHD (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 11:07:03 -0400
Date: Mon, 14 Apr 2003 17:29:47 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Timothy Miller <tmiller10@cfl.rr.com>, linux-kernel@vger.kernel.org,
       nicoya@apia.dhs.org
Subject: Re: Quick question about hyper-threading (also some NUMA stuff)
Message-ID: <20030414152947.GB14552@wind.cocodriloo.com>
References: <001301c3028a$25374f30$6801a8c0@epimetheus> <10760000.1050332136@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10760000.1050332136@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 07:55:37AM -0700, Martin J. Bligh wrote:
> > This sounds like the most sensible approach.  I like considering the
> > extremes of performance, but sometimes, the time for math required for some
> > optimization can be worse than any benefit you get out of it.  Your
> > suggestion is simple.  It increases the likelihood (10% better for little
> > extra effort is better than 10% worse) of related processes being run on the
> > same node, while not impacting the system's ability to balance load.  This,
> > as you say, is also very important for NUMA.
> 
> See my earlier email - rebalance_node() does this, and it's very cheap, as 
> we just SMP balance *within* the node -  the cross node rebalancer is a
> separate tunable background process.
> 
> > Does the NUMA support migrate pages to the node which is running a process?
> > Or would processes jump nodes often enough to make that not worth the
> > effort?
> 
> No, we don't do page migration as yet. Andi is playing with a homenode 
> concept that makes pages allocate from a predefined "home node" always, 
> instead of their current node. Last time I benchmarked that concept it 
> sucked, but the advent of the per-cpu, per-zone hot/cold page cache, and 
> the fact that he's using hardware with totally different NUMA characteristics 
> may well change that conclusion.
> 
> We don't normally migrate stuff around much on the higher-ration NUMA 
> machines. With AMD Hammer or whatever, that may change.
> 
> > In order for page migration to be worth it, node affinity would have to be
> > fairly strong.  It's particularly important when a process maps pages which
> > belong to another node.  Is there any logic there to duplicate pages in
> > cases where there is enough free memory for it?  We'd have to tag the pages
> > as duplicates so the VM could reclaim them.
> 
> Right - we're looking at read only text replication, first for the kernel
> (which ia64 has already), then for shared libs and program text. It's a 
> good concept, provided you have plenty of RAM (which big NUMA boxes tend
> to). Probably needs hooking into the address space structure, and to be
> thrown away just like anything else that's unused under memory pressure
> from the per-node LRU lists. Though it'd be nice to mark them as particularly
> cheap to retrieve, and had a reference count (a node bitmap?) and to 
> retrieve them from another node, not from disk.

Perhaps it would be good to un-COW pages:

1. fork process
2. if current node is not loaded, continue as usual
3. if current node is loaded:
3a. pick unloaded node
4b. don't do COW for data pages, but simply copy them to node-local memory

This way, read-write sharings would be replicated for each node.

Also, keeping an per-node active-page-list and then forcefully copying
the page to a node-local page-frame when accesing a page which is
active on another node could be good.

Hmm, the un-COW system could be implemented in terms of the second one,
isn't it?

Greets, Antonio.
