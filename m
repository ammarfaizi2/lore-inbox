Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUHCH76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUHCH76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUHCH76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:59:58 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:64650 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265211AbUHCH7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:59:55 -0400
Date: Tue, 3 Aug 2004 00:58:24 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: ak@suse.de, lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: [PATCH] subset zonelists and big numa friendly
 mempolicy MPOL_MBIND
Message-Id: <20040803005824.77358caf.pj@sgi.com>
In-Reply-To: <20040802191407.24e301e0.pj@sgi.com>
References: <20040802233516.11477.10063.34205@sam.engr.sgi.com>
	<20040803020805.060620fa.ak@suse.de>
	<20040802191407.24e301e0.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier, I (pj) wrote:
> It has poor cache performance on big iron.  For a modest job on a big
> system, the allocator has to walk down an average of 128 out of 256 zone
> pointers in the list, derefencing each one into the zone struct, then
> into the struct pglist_data, before it finds one that matches an allowed
> node id. That's a nasty memory footprint for a hot code path.

This paragraph is B.S.  Most tasks are running on CPUs that are on nodes
whose memory they are allowed to use.  That node is at the front of the
local zonelist, and they get their memory on the first node they look.

Damn ... hate it when that happens ;).

Still, either MPOL_BIND needs a more numa friendly set of zonelists
having a differently sorted list for each node in the set, or it's
usefulness for binding to more than one or a few very close nodes, if
you care about memory performance, falls off quickly as the number of
nodes increases.  As you well know, any such numa-friendly set of sorted
zonelists will require space on the Order of N**2, for N the node count,
given the NULL-terminated linear list form in which they must be handed
to __alloc_pages.

I suspect that the English phrase you are searching for now to tell me
is "if it hurts, don't use it ;)."  That is, you are clearly advising me
not to use MPOL_BIND if I need a fancy zonelist sort.

The place I ran into the most complexity doing this in the 2.4 kernel
was in the per-memory region binding.  You're dealing with this in the
2.6 kernels, and when you get to stuff like shared memory and huge
pages, it's not easy.  At least the vma splitting code is better in
2.6 than it was in 2.4.   Whatever I do for cpusets must _not_ duplicate
your virtual address range specific work (mbind).  Too much detail to be
done twice.

Andi wrote:
> My first reaction that if you really want to do that, just pass
> the policy node bitmap to alloc_pages and try_to_free_pages
> and use the normal per node zone list with the bitmap as filter. 

Pass in, or add to task_struct?  I can imagine adding a:

	nodemask_t mems_allowed;

to task_struct, and ending up with a CONFIG_CPUSET enabled macro called
in a few places in __alloc_pages() and try_to_free_pages() that amounts
to:

	if (!in_interrupt())
		if (!node_isset(z->zone_pgdat->node_id, current->mems_allowed))
			continue;

In any event, cpusets provides the larger "container" on bigger numa
systems, and mbind/mempolicy provides the more detailed, and vma
specific, placement within the container (or within the entire system
if cpusets not configured).

I'll try coding this up and see how it looks.

I welcome your further comments.

Thank-you.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
