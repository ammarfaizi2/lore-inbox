Return-Path: <linux-kernel-owner+w=401wt.eu-S1751736AbXAPXlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbXAPXlN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 18:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbXAPXlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 18:41:13 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55689 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbXAPXlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 18:41:12 -0500
Date: Tue, 16 Jan 2007 15:40:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070116154054.e655f75c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116135325.3441f62b.akpm@osdl.org>
	<Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 16 Jan 2007 14:15:56 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:
>
> ...
>
> > > This may result in a large percentage of a cpuset
> > > to become dirty without writeout being triggered. Under NFS
> > > this can lead to OOM conditions.
> > 
> > OK, a big question: is this patchset a performance improvement or a
> > correctness fix?  Given the above, and the lack of benchmark results I'm
> > assuming it's for correctness.
> 
> It is a correctness fix both for NFS OOM and doing proper cpuset writeout.

It's a workaround for a still-unfixed NFS problem.

> > - Why does NFS go oom?  Because it allocates potentially-unbounded
> >   numbers of requests in the writeback path?
> > 
> >   It was able to go oom on non-numa machines before dirty-page-tracking
> >   went in.  So a general problem has now become specific to some NUMA
> >   setups.
> 
> 
> Right. The issue is that large portions of memory become dirty / 
> writeback since no writeback occurs because dirty limits are not checked 
> for a cpuset. Then NFS attempt to writeout when doing LRU scans but is 
> unable to allocate memory.
>  
> >   So an obvious, equivalent and vastly simpler "fix" would be to teach
> >   the NFS client to go off-cpuset when trying to allocate these requests.
> 
> Yes we can fix these allocations by allowing processes to allocate from 
> other nodes. But then the container function of cpusets is no longer 
> there.

But that's what your patch already does!

It asks pdflush to write the pages instead of the direct-reclaim caller. 
The only reason pdflush doesn't go oom is that pdflush lives outside the
direct-reclaim caller's cpuset and is hence able to obtain those nfs
requests from off-cpuset zones.

> > (But is it really bad? What actual problems will it cause once NFS is fixed?)
> 
> NFS is okay as far as I can tell. dirty throttling works fine in non 
> cpuset environments because we throttle if 40% of memory becomes dirty or 
> under writeback.

Repeat: NFS shouldn't go oom.  It should fail the allocation, recover, wait
for existing IO to complete.  Back that up with a mempool for NFS requests
and the problem is solved, I think?

> > I don't understand why the proposed patches are cpuset-aware at all.  This
> > is a per-zone problem, and a per-zone fix would seem to be appropriate, and
> > more general.  For example, i386 machines can presumably get into trouble
> > if all of ZONE_DMA or ZONE_NORMAL get dirty.  A good implementation would
> > address that problem as well.  So I think it should all be per-zone?
> 
> No. A zone can be completely dirty as long as we are allowed to allocate 
> from other zones.

But we also can get into trouble if a *zone* is all-dirty.  Any solution to
the cpuset problem should solve that problem too, no?

> > Do we really need those per-inode cpumasks?  When page reclaim encounters a
> > dirty page on the zone LRU, we automatically know that page->mapping->host
> > has at least one dirty page in this zone, yes?  We could immediately ask
> 
> Yes, but when we enter reclaim most of the pages of a zone may already be 
> dirty/writeback so we fail.

No.  If the dirty limits become per-zone then no zone will ever have >40%
dirty.

The obvious fix here is: when a zone hits 40% dirty, perform dirty-memory
reduction in that zone, throttling the dirtying process.  I suspect this
would work very badly in common situations with, say, typical i386 boxes.


