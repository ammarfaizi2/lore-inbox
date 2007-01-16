Return-Path: <linux-kernel-owner+w=401wt.eu-S1750919AbXAPWQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbXAPWQS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXAPWQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:16:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52256 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750919AbXAPWQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:16:17 -0500
Date: Tue, 16 Jan 2007 14:15:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
In-Reply-To: <20070116135325.3441f62b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <20070116135325.3441f62b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Andrew Morton wrote:

> > On Mon, 15 Jan 2007 21:47:43 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:
> >
> > Currently cpusets are not able to do proper writeback since
> > dirty ratio calculations and writeback are all done for the system
> > as a whole.
> 
> We _do_ do proper writeback.  But it's less efficient than it might be, and
> there's an NFS problem.

Well yes we write back during LRU scans when a potentially high percentage 
of the memory in cpuset is dirty.

> > This may result in a large percentage of a cpuset
> > to become dirty without writeout being triggered. Under NFS
> > this can lead to OOM conditions.
> 
> OK, a big question: is this patchset a performance improvement or a
> correctness fix?  Given the above, and the lack of benchmark results I'm
> assuming it's for correctness.

It is a correctness fix both for NFS OOM and doing proper cpuset writeout.

> - Why does NFS go oom?  Because it allocates potentially-unbounded
>   numbers of requests in the writeback path?
> 
>   It was able to go oom on non-numa machines before dirty-page-tracking
>   went in.  So a general problem has now become specific to some NUMA
>   setups.


Right. The issue is that large portions of memory become dirty / 
writeback since no writeback occurs because dirty limits are not checked 
for a cpuset. Then NFS attempt to writeout when doing LRU scans but is 
unable to allocate memory.
 
>   So an obvious, equivalent and vastly simpler "fix" would be to teach
>   the NFS client to go off-cpuset when trying to allocate these requests.

Yes we can fix these allocations by allowing processes to allocate from 
other nodes. But then the container function of cpusets is no longer 
there.

> (But is it really bad? What actual problems will it cause once NFS is fixed?)

NFS is okay as far as I can tell. dirty throttling works fine in non 
cpuset environments because we throttle if 40% of memory becomes dirty or 
under writeback.

> I don't understand why the proposed patches are cpuset-aware at all.  This
> is a per-zone problem, and a per-zone fix would seem to be appropriate, and
> more general.  For example, i386 machines can presumably get into trouble
> if all of ZONE_DMA or ZONE_NORMAL get dirty.  A good implementation would
> address that problem as well.  So I think it should all be per-zone?

No. A zone can be completely dirty as long as we are allowed to allocate 
from other zones.

> Do we really need those per-inode cpumasks?  When page reclaim encounters a
> dirty page on the zone LRU, we automatically know that page->mapping->host
> has at least one dirty page in this zone, yes?  We could immediately ask

Yes, but when we enter reclaim most of the pages of a zone may already be 
dirty/writeback so we fail. Also when we enter reclaim we may not have
the proper process / cpuset context. There is no use to throttle kswapd. 
We need to throttle the process that is dirtying memory.

> But all of this is, I think, unneeded if NFS is fixed.  It's hopefully a
> performance optimisation to permit writeout in a less seeky fashion. 
> Unless there's some other problem with excessively dirty zones.

The patchset improves performance because the filesystem can do sequential 
writeouts. So yes in some ways this is a performance improvement. But this 
is only because this patch makes dirty throttling for cpusets work in the 
same way as for non NUMA system.
