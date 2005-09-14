Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVINWpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVINWpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVINWpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:45:00 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:49875
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S965082AbVINWpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:45:00 -0400
Date: Wed, 14 Sep 2005 18:40:40 -0400
From: Sonny Rao <sonny@burdell.org>
To: David Chinner <dgc@sgi.com>
Cc: Bharata B Rao <bharata@in.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050914224040.GA16627@kevlar.burdell.org>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com> <20050914154852.GB6172@kevlar.burdell.org> <20050914220222.GA2265486@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914220222.GA2265486@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:02:22AM +1000, David Chinner wrote:
> On Wed, Sep 14, 2005 at 11:48:52AM -0400, Sonny Rao wrote:
> > On Wed, Sep 14, 2005 at 07:59:32AM +1000, David Chinner wrote:
> > > On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > > > 
> > > > Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
> > > > to improve this dcache fragmentation problem.
> > > 
> > > FYI, in the past I've tried this patch to reduce dcache fragmentation on
> > > an Altix (16k pages, 62 dentries to a slab page) under heavy
> > > fileserver workloads and it had no measurable effect. It appeared
> > > that there was almost always at least one active dentry on each page
> > > in the slab.  The story may very well be different on 4k page
> > > machines, however.
> 
> ....
> 
> > I'm not surprised... With 62 dentrys per page, the likelyhood of
> > success is very small, and in fact performance could degrade since we
> > are holding the dcache lock more often and doing less useful work.
> > 
> > It has been over a year and my memory is hazy, but I think I did see
> > about a 10% improvement on my workload (some sort of SFS simulation
> > with millions of files being randomly accessed)  on an x86 machine but CPU
> > utilization also went way up which I think was the dcache lock.
> 
> Hmmm - can't say that I've had the same experience. I did not notice
> any decrease in fragmentation or increase in CPU usage...

Well, this was on an x86 machine with 8 cores but relatively poor
scalability and horrific memory latencies ... i.e. it tends to
exaggerate the effects of bad locks compared to what I would see on a
more scalable POWER machine.  We actually ran SFS on a 4-way POWER-5
machine with the patch and didn't see any real change in throughput,
and fragmentation was a little better.  I can go dig out the data if
someone is really interested.

In your case with 62 dentry objects per page (which is only going to
get much worse as we bump up base page sizes), I think the chances of
success of this approach or anything similar are horrible because we
aren't really solving any of the fundamental issues.

For me, the patch we mostly an experiment to see if the "blunderbus"
effect (to quote mjb) could be controlled any better that we do
today.  Mostly, it didn't seem worth it to me -- especially since we
wanted the global dcache lock to go away. 
 
> FWIW, SFS is just one workload that produces fragmentation.  Any
> load that mixes or switches repeatedly between filesystem traversals
> to producing memory pressure via the page cache tends to result in
> fragmentation of the inode and dentry slabs...

Yep, and that's more or less how I "simulated" SFS, just had tons of
small files.  I wasn't trying to really simulate the networking part
or op mixture etc -- just the slab fragmentation as a "worst-case".

> > Whatever happened to the  vfs_cache_pressue  band-aid/sledgehammer ?  
> > Is it not considered an option ?
> 
> All that did was increase the fragmentation levels. Instead of
> seeing a 4-5:1 free/used ratio in the dcache, it would push out to
> 10-15:1 if vfs_cache_pressue was used to prefer reclaiming dentries
> over page cache pages. Going the other way and prefering reclaim of
> page cache pages did nothing to change the level of fragmentation.
> Reclaim still freed most of the dentries in the working set but it
> took a little longer to do it.

Yes, but on systems with smaller pages it does seem to have some
positive effect.  I don't really know how well this has been
quantified. 
 
> Right now our only solution to prevent fragmentation on reclaim is
> to throw more memory at the machine to prevent reclaim from
> happening as the workload changes.

That is unfortunate, but interesting because I didn't know if this was
not a "real-problem" as some have contended.  I know SPEC SFS is a
somewhat questionable workload (really, what isn't though?), so the
evidence gathered from that didn't seem to convince many people.  

What kind of (real) workload are you seeing this on?

Thanks,

Sonny

