Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUHCCO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUHCCO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 22:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUHCCO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 22:14:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1224 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264991AbUHCCOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 22:14:55 -0400
Date: Mon, 2 Aug 2004 19:14:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] subset zonelists and big numa friendly mempolicy
 MPOL_MBIND
Message-Id: <20040802191407.24e301e0.pj@sgi.com>
In-Reply-To: <20040803020805.060620fa.ak@suse.de>
References: <20040802233516.11477.10063.34205@sam.engr.sgi.com>
	<20040803020805.060620fa.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick reply, Andi.

> I suppose you need this for your cpu memset stuff, right? 
> On a large machine it will be quite cache blowing too.

Yes - subset zonelists will also be used in Simon Derr's and my cpuset
stuff.  As to cache blowing, actually I'd hope not.  Once a subset
zonelist is setup, it shouldn't hit anymore cache lines during normal
use than the system NODE_DATA zonelists.  Normal __alloc_pages() use
succeeds with the first zone pointer in the list, in any case.

> What's the worst case memory usage of all this?

They are N-squared, in the number of zones.  On a system with only
GFP_DMA memory, for a job bound to say 8 nodes, thats 72 (8 * 8, plus 8
NULL's) zone pointers, plus a linear array of 3 integer gfp indices per
CPU.  If someone tries to bind something to 254 out of 256 nodes on a
big system, then, yes, it eats about 0.5 Mbytes of space.  They are
shared and kref'd.  Of course, on such a system, the NODE_DATA zone
lists are consuming perhaps 6 Mbytes, if my math is right.  This worst
case 0.5 Mbytes could be trimmed by an order of magnitude, by cutting
off the tails of each zonelist (give up the search after 16 nodes, say)
-- I had that coded, but removed it because I didn't figure it was worth
it.

Basically, on these big numa boxes, the jobs don't overlap - they get
dedicated resources.  So the worst case is one job using _almost_ the
entire machine, needing a single 0.5 Mbyte subset zonelist (on a 256
node, GFP_DMA only, system).  Next worst is two jobs, half the machine
each, needing two subset zonelists of 0.13 Mbytes each (0.25 Mb total). 
The more jobs, the smaller each is, and the less the overall space.

When someone buys a 512 CPU, 256 node system to run a single dedicated
job, 0.5 Mbytes of memory to get the right numa placement is no problem.

> My first reaction that if you really want to do that, just pass
> the policy node bitmap to alloc_pages and try_to_free_pages
> and use the normal per node zone list with the bitmap as filter. 

Yes - you're right - that is the alternative.  And it's what occurred
to me first, as well.

It's what I coded in SGI's 2.4 kernel cpumemset patches.  It has poor
cache performance on big iron.  For a modest job on a big system, the
allocator has to walk down an average of 128 out of 256 zone pointers in
the list, derefencing each one into the zone struct, then into the
struct pglist_data, before it finds one that matches an allowed node id.
That's a nasty memory footprint for a hot code path.

Passing in a bitmap node filter to __alloc_pages() is also more intrusive
into the core allocator code.  That's one of the reasons that I liked
your approach, of preparing custom zonelists to pass in to
__alloc_pages().  It was less intrusive on the higher maintenance
__alloc_pages() code, so should be easier to maintain.

Either way, passing in a bitmap node filter to __alloc_pages, or passing
a custom zonelist, the memory policy represented by MPOL_BIND is
critical to our big iron.  We must restrict jobs from using memory
outside of their allowed set.  And either way, _within_ that set, we
must follow numa friendly placement, trying to allocate on the current
node first, and then on the closest neighbors next.  And either way, the
cpuset work of Simon and myself will make heavy use of this facility.

So - yes - complexity.  But very isolated complexity.  The coding of
your mm/mempolicy.c got a bit simpler, and no change at all is made to
__alloc_pages().  Just a single new 4 element data structure is added,
and just one new external routine - build_subset_zonelists(), which has
simple semantics - return a custom zonelist for the requested nodes. 
All the complexity is isolated on a cold code path, arch-neutral and NUMA
only, behind a simple API.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
