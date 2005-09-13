Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVIMWAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVIMWAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVIMWAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:00:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53915 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932221AbVIMWAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:00:46 -0400
Date: Wed, 14 Sep 2005 07:59:32 +1000
From: David Chinner <dgc@sgi.com>
To: Bharata B Rao <bharata@in.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050913215932.GA1654338@melbourne.sgi.com>
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913084752.GC4474@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> 
> Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
> to improve this dcache fragmentation problem.

FYI, in the past I've tried this patch to reduce dcache fragmentation on
an Altix (16k pages, 62 dentries to a slab page) under heavy
fileserver workloads and it had no measurable effect. It appeared
that there was almost always at least one active dentry on each page
in the slab.  The story may very well be different on 4k page
machines, however.

Typically, fragmentation was bad enough that reclaim removed ~90% of
the working set of dentries to free about 1% of the memory in the
dentry slab. We had to get down to freeing > 95% of the dentry cache
before fragmentation started to reduce and the system stopped trying to
reclaim the dcache which we then spent the next 10 minutes
repopulating......

We also tried separating out directory dentries into a separate slab
so that (potentially) longer lived dentries were clustered together
rather than sparsely distributed around the slab cache.  Once again,
it had no measurable effect on the level of fragmentation (with or
without the rbtree patch).

FWIW, the inode cache was showing very similar levels of fragmentation
under reclaim as well.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
