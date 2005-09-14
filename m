Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVINWtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVINWtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVINWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:49:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:16514 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030261AbVINWtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:49:15 -0400
Date: Thu, 15 Sep 2005 08:48:05 +1000
From: David Chinner <dgc@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Bharata B Rao <bharata@in.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050914224805.GB2265486@melbourne.sgi.com>
References: <20050911105709.GA16369@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com> <200509141101.16781.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509141101.16781.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 11:01:15AM +0200, Andi Kleen wrote:
> On Tuesday 13 September 2005 23:59, David Chinner wrote:
> > On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > > Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
> > > to improve this dcache fragmentation problem.
> >
> > FYI, in the past I've tried this patch to reduce dcache fragmentation on
> > an Altix (16k pages, 62 dentries to a slab page) under heavy
> > fileserver workloads and it had no measurable effect. It appeared
> > that there was almost always at least one active dentry on each page
> > in the slab.  The story may very well be different on 4k page
> > machines, however.
> 
> I always thought dentry freeing would work much better if it
> was turned upside down.
> 
> Instead of starting from the high level dcache lists it could
> be driven by slab: on memory pressure slab tries to return pages with unused 
> cache objects. In that case it should check if there are only
> a small number of pinned objects on the page set left, and if 
> yes use a new callback to the higher level user (=dcache) and ask them
> to free the object.

If you add a slab free object callback, then you have the beginnings
of a more flexible solution to memory reclaim from the slabs.

For example, you can easily implement a reclaim-not-allocate method
for new slab allocations for when there is no memory available or the
size of the slab is passed some configurable high water mark...

Right now these is no way to control the size of a slab cache.  Part
of the reason for the fragmentation I have seen is the massive
changes in size of the caches due to the OS making wrong decisions
about memory reclaim when small changes in the workload occur. We
currently have no way to provide hints to help the OS make the right
decision for a given workload....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
