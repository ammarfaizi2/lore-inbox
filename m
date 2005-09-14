Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVINWDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVINWDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVINWD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:03:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54971 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965042AbVINWDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:03:24 -0400
Date: Thu, 15 Sep 2005 08:02:22 +1000
From: David Chinner <dgc@sgi.com>
To: Sonny Rao <sonny@burdell.org>
Cc: Bharata B Rao <bharata@in.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050914220222.GA2265486@melbourne.sgi.com>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com> <20050914154852.GB6172@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914154852.GB6172@kevlar.burdell.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 11:48:52AM -0400, Sonny Rao wrote:
> On Wed, Sep 14, 2005 at 07:59:32AM +1000, David Chinner wrote:
> > On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > > 
> > > Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
> > > to improve this dcache fragmentation problem.
> > 
> > FYI, in the past I've tried this patch to reduce dcache fragmentation on
> > an Altix (16k pages, 62 dentries to a slab page) under heavy
> > fileserver workloads and it had no measurable effect. It appeared
> > that there was almost always at least one active dentry on each page
> > in the slab.  The story may very well be different on 4k page
> > machines, however.

....

> I'm not surprised... With 62 dentrys per page, the likelyhood of
> success is very small, and in fact performance could degrade since we
> are holding the dcache lock more often and doing less useful work.
> 
> It has been over a year and my memory is hazy, but I think I did see
> about a 10% improvement on my workload (some sort of SFS simulation
> with millions of files being randomly accessed)  on an x86 machine but CPU
> utilization also went way up which I think was the dcache lock.

Hmmm - can't say that I've had the same experience. I did not notice
any decrease in fragmentation or increase in CPU usage...

FWIW, SFS is just one workload that produces fragmentation.  Any
load that mixes or switches repeatedly between filesystem traversals
to producing memory pressure via the page cache tends to result in
fragmentation of the inode and dentry slabs...

> Whatever happened to the  vfs_cache_pressue  band-aid/sledgehammer ?  
> Is it not considered an option ?

All that did was increase the fragmentation levels. Instead of
seeing a 4-5:1 free/used ratio in the dcache, it would push out to
10-15:1 if vfs_cache_pressue was used to prefer reclaiming dentries
over page cache pages. Going the other way and prefering reclaim of
page cache pages did nothing to change the level of fragmentation.
Reclaim still freed most of the dentries in the working set but it
took a little longer to do it.

Right now our only solution to prevent fragmentation on reclaim is
to throw more memory at the machine to prevent reclaim from
happening as the workload changes.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
