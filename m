Return-Path: <linux-kernel-owner+w=401wt.eu-S1751662AbXAQBH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbXAQBH5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 20:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXAQBH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 20:07:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60748 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbXAQBH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 20:07:56 -0500
Date: Tue, 16 Jan 2007 17:07:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070116170734.947264f2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116135325.3441f62b.akpm@osdl.org>
	<Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
	<20070116154054.e655f75c.akpm@osdl.org>
	<Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 16 Jan 2007 16:16:30 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:
> On Tue, 16 Jan 2007, Andrew Morton wrote:
> 
> > It's a workaround for a still-unfixed NFS problem.
> 
> No its doing proper throttling. Without this patchset there will *no* 
> writeback and throttling at all. F.e. lets say we have 20 nodes of 1G each
> and a cpuset that only spans one node.
> 
> Then a process runniung in that cpuset can dirty all of memory and still 
> continue running without writeback continuing. background dirty ratio
> is at 10% and the dirty ratio at 40%. Neither of those boundaries can ever
> be reached because the process will only ever be able to dirty memory on 
> one node which is 5%. There will be no throttling, no background 
> writeback, no blocking for dirty pages.
> 
> At some point we run into reclaim (possibly we have ~99% of of the cpuset 
> dirty) and then we trigger writeout. Okay so if the filesystem / block 
> device is robust enough and does not require memory allocations then we 
> likely will survive that and do slow writeback page by page from the LRU.
> 
> writback is completely hosed for that situation. This patch restores 
> expected behavior in a cpuset (which is a form of system partition that 
> should mirror the system as a whole). At 10% dirty we should start 
> background writeback and at 40% we should block. If that is done then even 
> fragile combinations of filesystem/block devices will work as they do 
> without cpusets.

Nope.  You've completely omitted the little fact that we'll do writeback in
the offending zone off the LRU.  Slower, maybe.  But it should work and the
system should recover.  If it's not doing that (it isn't) then we should
fix it rather than avoiding it (by punting writeback over to pdflush).

Once that's fixed, if we determine that there are remaining and significant
performance issues then we can take a look at that.

> 
> > > Yes we can fix these allocations by allowing processes to allocate from 
> > > other nodes. But then the container function of cpusets is no longer 
> > > there.
> > But that's what your patch already does!
> 
> The patchset does not allow processes to allocate from other nodes than 
> the current cpuset.

Yes it does.  It asks pdflush to perform writeback of the offending zone(s)
rather than (or as well as) doing it directly.  The only reason pdflush can
sucessfuly do that is because pdflush can allocate its requests from other
zones.

> 
> AFAIK any filesyste/block device can go oom with the current broken 
> writeback it just does a few allocations. Its a matter of hitting the 
> sweet spots.

That shouldn't be possible, in theory.  Block IO is supposed to succeed if
*all memory in the machine is dirty*: the old
dirty-everything-with-MAP_SHARED-then-exit problem.  Lots of testing went
into that and it works.  It also failed on NFS although I thought that got
"fixed" a year or so ago.  Apparently not.

> > But we also can get into trouble if a *zone* is all-dirty.  Any solution to
> > the cpuset problem should solve that problem too, no?
> 
> Nope. Why would a dirty zone pose a problem? The proble exist if you 
> cannot allocate more memory.

Well one example would be a GFP_KERNEL allocation on a highmem machine in
whcih all of ZONE_NORMAL is dirty.

> If a cpuset contains a single node which is a 
> single zone then this patchset will also address that issue.
> 
> If we have multiple zones then other zones may still provide memory to 
> continue (same as in UP).

Not if all the eligible zones are all-dirty.

> > > Yes, but when we enter reclaim most of the pages of a zone may already be 
> > > dirty/writeback so we fail.
> > 
> > No.  If the dirty limits become per-zone then no zone will ever have >40%
> > dirty.
> 
> I am still confused as to why you would want per zone dirty limits?

The need for that has yet to be demonstrated.  There _might_ be a problem,
but we need test cases and analyses to demonstrate that need.

Right now, what we have is an NFS bug.  How about we fix it, then
reevaluate the situation?

A good starting point would be to show us one of these oom-killer traces.

> Lets say we have a cpuset with 4 nodes (thus 4 zones) and we are running 
> on the first node. Then we copy a large file to disk. Node local 
> allocation means that we allocate from the first node. After we reach 40% 
> of the node then we throttle? This is going to be a significant 
> performance degradation since we can no longer use the memory of other 
> nodes to buffer writeout.

That was what I was referring to.


