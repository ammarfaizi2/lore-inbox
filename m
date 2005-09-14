Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVINPxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVINPxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVINPxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:53:11 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:5805
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1030205AbVINPxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:53:10 -0400
Date: Wed, 14 Sep 2005 11:48:52 -0400
From: Sonny Rao <sonny@burdell.org>
To: David Chinner <dgc@sgi.com>
Cc: Bharata B Rao <bharata@in.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050914154852.GB6172@kevlar.burdell.org>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913215932.GA1654338@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 07:59:32AM +1000, David Chinner wrote:
> On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > 
> > Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
> > to improve this dcache fragmentation problem.
> 
> FYI, in the past I've tried this patch to reduce dcache fragmentation on
> an Altix (16k pages, 62 dentries to a slab page) under heavy
> fileserver workloads and it had no measurable effect. It appeared
> that there was almost always at least one active dentry on each page
> in the slab.  The story may very well be different on 4k page
> machines, however.
> 
> Typically, fragmentation was bad enough that reclaim removed ~90% of
> the working set of dentries to free about 1% of the memory in the
> dentry slab. We had to get down to freeing > 95% of the dentry cache
> before fragmentation started to reduce and the system stopped trying to
> reclaim the dcache which we then spent the next 10 minutes
> repopulating......
> 
> We also tried separating out directory dentries into a separate slab
> so that (potentially) longer lived dentries were clustered together
> rather than sparsely distributed around the slab cache.  Once again,
> it had no measurable effect on the level of fragmentation (with or
> without the rbtree patch).

I'm not surprised... With 62 dentrys per page, the likelyhood of
success is very small, and in fact performance could degrade since we
are holding the dcache lock more often and doing less useful work.

It has been over a year and my memory is hazy, but I think I did see
about a 10% improvement on my workload (some sort of SFS simulation
with millions of files being randomly accessed)  on an x86 machine but CPU
utilization also went way up which I think was the dcache lock.

Whatever happened to the  vfs_cache_pressue  band-aid/sledgehammer ?  
Is it not considered an option ?

