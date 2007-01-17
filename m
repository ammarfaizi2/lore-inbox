Return-Path: <linux-kernel-owner+w=401wt.eu-S1750845AbXAQBaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbXAQBaq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 20:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbXAQBaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 20:30:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37516 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750845AbXAQBap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 20:30:45 -0500
Date: Tue, 16 Jan 2007 17:30:26 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
In-Reply-To: <20070116170734.947264f2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <20070116135325.3441f62b.akpm@osdl.org> <Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
 <20070116154054.e655f75c.akpm@osdl.org> <Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
 <20070116170734.947264f2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Andrew Morton wrote:

> Nope.  You've completely omitted the little fact that we'll do writeback in
> the offending zone off the LRU.  Slower, maybe.  But it should work and the
> system should recover.  If it's not doing that (it isn't) then we should
> fix it rather than avoiding it (by punting writeback over to pdflush).

pdflush is not running *at* all nor is dirty throttling working. That is 
correct behavior? We could do background writeback but we choose not to do 
so? Instead we wait until we hit reclaim and then block (well it seems 
that we do not block the blocking there also fails since we again check 
global ratios)?

> > The patchset does not allow processes to allocate from other nodes than 
> > the current cpuset.
> 
> Yes it does.  It asks pdflush to perform writeback of the offending zone(s)
> rather than (or as well as) doing it directly.  The only reason pdflush can
> sucessfuly do that is because pdflush can allocate its requests from other
> zones.

Ok pdflush is able to do that. Still the application is not able to 
extend its memory beyond the cpuset. What about writeback throttling? 
There it all breaks down. The cpuset is effective and we are unable to 
allocate any more memory. 

The reason this works is because not all of memory is dirty. Thus reclaim 
will be able to free up memory or there is enough memory free.

> > AFAIK any filesyste/block device can go oom with the current broken 
> > writeback it just does a few allocations. Its a matter of hitting the 
> > sweet spots.
> 
> That shouldn't be possible, in theory.  Block IO is supposed to succeed if
> *all memory in the machine is dirty*: the old
> dirty-everything-with-MAP_SHARED-then-exit problem.  Lots of testing went
> into that and it works.  It also failed on NFS although I thought that got
> "fixed" a year or so ago.  Apparently not.

Humm... Really?

> > Nope. Why would a dirty zone pose a problem? The proble exist if you 
> > cannot allocate more memory.
> 
> Well one example would be a GFP_KERNEL allocation on a highmem machine in
> whcih all of ZONE_NORMAL is dirty.

That is a restricted allocation which will lead to reclaim.

> > If we have multiple zones then other zones may still provide memory to 
> > continue (same as in UP).
> 
> Not if all the eligible zones are all-dirty.

They are all dirty if we do not throttle the dirty pages.

> Right now, what we have is an NFS bug.  How about we fix it, then
> reevaluate the situation?

The "NFS bug" only exists when using a cpuset. If you run NFS without 
cpusets then the throttling will kick in and everything is fine.

> A good starting point would be to show us one of these oom-killer traces.

No traces. Since the process is killed within a cpuset we only get 
messages like:

Nov 28 16:19:52 ic4 kernel: Out of Memory: Kill process 679783 (ncks) score 0 and children.
Nov 28 16:19:52 ic4 kernel: No available memory in cpuset: Killed process 679783 (ncks).
Nov 28 16:27:58 ic4 kernel: oom-killer: gfp_mask=0x200d2, order=0

Probably need to rerun these with some patches.

> > Lets say we have a cpuset with 4 nodes (thus 4 zones) and we are running 
> > on the first node. Then we copy a large file to disk. Node local 
> > allocation means that we allocate from the first node. After we reach 40% 
> > of the node then we throttle? This is going to be a significant 
> > performance degradation since we can no longer use the memory of other 
> > nodes to buffer writeout.
> 
> That was what I was referring to.

Note that this was describing the behavior you wanted not the way things 
work. It is desired behavior not to use all the memory resources of the 
cpuset and slow down the system?


