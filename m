Return-Path: <linux-kernel-owner+w=401wt.eu-S1751492AbXAQEFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbXAQEFv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXAQEFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:05:50 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40760 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbXAQEFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:05:50 -0500
Date: Tue, 16 Jan 2007 20:05:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070116200506.d19eacf5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116135325.3441f62b.akpm@osdl.org>
	<Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
	<20070116154054.e655f75c.akpm@osdl.org>
	<Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
	<20070116170734.947264f2.akpm@osdl.org>
	<Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
	<20070116183406.ed777440.akpm@osdl.org>
	<Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 16 Jan 2007 19:40:17 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:
> On Tue, 16 Jan 2007, Andrew Morton wrote:
> 
> > Consider: non-exclusive cpuset A consists of mems 0-15, non-exclusive
> > cpuset B consists of mems 0-3.  A task running in cpuset A can freely dirty
> > all of cpuset B's memory.  A task running in cpuset B gets oomkilled.
> > 
> > Consider: a 32-node machine has nodes 0-3 full of dirty memory.  I create a
> > cpuset containing nodes 0-2 and start using it.  I get oomkilled.
> > 
> > There may be other scenarios.
> 
> Yes this is the result of the hierachical nature of cpusets which already 
> causes issues with the scheduler. It is rather typical that cpusets are 
> used to partition the memory and cpus. Overlappig cpusets seem to have 
> mainly an administrative function. Paul?

The typical usage scenarios don't matter a lot: the examples I gave show
that the core problem remains unsolved.  People can still hit the bug.

> > So what I suggest we do is to fix the NFS bug, then move on to considering
> > the performance problems.
> 
> The NFS "bug" has been there for ages and no one cares since write 
> throttling works effectively. Since NFS can go via any network technology 
> (f.e. infiniband) we have many potential issues at that point that depend 
> on the underlying network technology. As far as I can recall we decided 
> that these stacking issues are inherently problematic and basically 
> unsolvable.

The problem you refer to arises from the inability of the net driver to
allocate memory for an outbound ack.  Such allocations aren't constrained to
a cpuset.

I expect that we can solve the NFS oom problem along the same lines as
block devices.  Certainly it's dumb of us to oom-kill a process rather than
going off-cpuset for a small and short-lived allocation.  It's also dumb of
us to allocate a basically unbounded number of nfs requests rather than
waiting for some of the ones which we _have_ allocated to complete.


> > On reflection, I agree that your proposed changes are sensible-looking for
> > addressing the probable, not-yet-demonstrated-and-quantified performance
> > problem.  The per-inode (should be per-address_space, maybe it is?) node
> 
> The address space is part of the inode.

Physically, yes.  Logically, it is not.  The address_space controls the
data-plane part of a file and is the appropriate place in which to store
this nodemask.

> Some of my development versions at 
> the dirty_map in the address space. However, the end of the inode was a 
> convenient place for a runtime sizes nodemask.
> 
> > map is unfortunate.  Need to think about that a bit more.  For a start, it
> > should be dynamically allocated (from a new, purpose-created slab cache):
> > most in-core inodes don't have any dirty pages and don't need this
> > additional storage.
> 
> We also considered such an approach. However. it creates the problem 
> of performing a slab allocation while dirtying pages. At that point we do 
> not have an allocation context, nor can we block.

Yes, it must be an atomic allocation.  If it fails, we don't care.  Chances
are it'll succeed when the next page in this address_space gets dirtied.

Plus we don't waste piles of memory on read-only files.

> > But this is unrelated to the NFS bug ;)
> 
> Looks more like a design issue (given its layering on top of the 
> networking layer) and not a bug. The "bug" surfaces when writeback is not 
> done properly. I wonder what happens if other filesystems are pushed to 
> the border of the dirty abyss.  .... The mmap tracking 
> fixes that were done in 2.6.19 were done because of similar symptoms 
> because the systems dirty tracking was off. This is fundamentally the 
> same issue showing up in a cpuset. So we should be able to produce the
> hangs (looks ... yes another customer reported issue on this one is that 
> reclaim is continually running and we basically livelock the system) that 
> we saw for the mmap dirty tracking issues in addition to the NFS problems 
> seen so far.
> 
> Memory allocation is required in most filesystem flush paths. If we cannot 
> allocate memory then we cannot clean pages and thus we continue trying -> 
> Livelock. I still see this as a fundamental correctness issue in the 
> kernel.

I'll believe all that once someone has got down and tried to fix NFS, and
has failed ;)

