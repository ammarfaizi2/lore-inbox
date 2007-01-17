Return-Path: <linux-kernel-owner+w=401wt.eu-S1751001AbXAQDkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbXAQDkl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 22:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbXAQDkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 22:40:41 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39757 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750747AbXAQDkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 22:40:40 -0500
Date: Tue, 16 Jan 2007 19:40:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
In-Reply-To: <20070116183406.ed777440.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <20070116135325.3441f62b.akpm@osdl.org> <Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
 <20070116154054.e655f75c.akpm@osdl.org> <Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
 <20070116170734.947264f2.akpm@osdl.org> <Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
 <20070116183406.ed777440.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Andrew Morton wrote:

> Consider: non-exclusive cpuset A consists of mems 0-15, non-exclusive
> cpuset B consists of mems 0-3.  A task running in cpuset A can freely dirty
> all of cpuset B's memory.  A task running in cpuset B gets oomkilled.
> 
> Consider: a 32-node machine has nodes 0-3 full of dirty memory.  I create a
> cpuset containing nodes 0-2 and start using it.  I get oomkilled.
> 
> There may be other scenarios.

Yes this is the result of the hierachical nature of cpusets which already 
causes issues with the scheduler. It is rather typical that cpusets are 
used to partition the memory and cpus. Overlappig cpusets seem to have 
mainly an administrative function. Paul?

> So what I suggest we do is to fix the NFS bug, then move on to considering
> the performance problems.

The NFS "bug" has been there for ages and no one cares since write 
throttling works effectively. Since NFS can go via any network technology 
(f.e. infiniband) we have many potential issues at that point that depend 
on the underlying network technology. As far as I can recall we decided 
that these stacking issues are inherently problematic and basically 
unsolvable.

> On reflection, I agree that your proposed changes are sensible-looking for
> addressing the probable, not-yet-demonstrated-and-quantified performance
> problem.  The per-inode (should be per-address_space, maybe it is?) node

The address space is part of the inode. Some of my development versions at 
the dirty_map in the address space. However, the end of the inode was a 
convenient place for a runtime sizes nodemask.

> map is unfortunate.  Need to think about that a bit more.  For a start, it
> should be dynamically allocated (from a new, purpose-created slab cache):
> most in-core inodes don't have any dirty pages and don't need this
> additional storage.

We also considered such an approach. However. it creates the problem 
of performing a slab allocation while dirtying pages. At that point we do 
not have an allocation context, nor can we block.

> But this is unrelated to the NFS bug ;)

Looks more like a design issue (given its layering on top of the 
networking layer) and not a bug. The "bug" surfaces when writeback is not 
done properly. I wonder what happens if other filesystems are pushed to 
the border of the dirty abyss.  .... The mmap tracking 
fixes that were done in 2.6.19 were done because of similar symptoms 
because the systems dirty tracking was off. This is fundamentally the 
same issue showing up in a cpuset. So we should be able to produce the
hangs (looks ... yes another customer reported issue on this one is that 
reclaim is continually running and we basically livelock the system) that 
we saw for the mmap dirty tracking issues in addition to the NFS problems 
seen so far.

Memory allocation is required in most filesystem flush paths. If we cannot 
allocate memory then we cannot clean pages and thus we continue trying -> 
Livelock. I still see this as a fundamental correctness issue in the 
kernel.
