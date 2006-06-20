Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWFTACZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWFTACZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 20:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFTACZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 20:02:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48027 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932558AbWFTACY (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 20:02:24 -0400
Date: Tue, 20 Jun 2006 10:01:33 +1000
From: David Chinner <dgc@sgi.com>
To: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       "Vladimir V. Saveliev" <vs@namesys.com>, hch@infradead.org,
       Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: batched write
Message-ID: <20060620000133.GB8770394@melbourne.sgi.com>
References: <20060524175312.GA3579@zero> <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de> <1149766000.6336.29.camel@tribesman.namesys.com> <20060608121006.GA8474@infradead.org> <1150322912.6322.129.camel@tribesman.namesys.com> <20060617100458.0be18073.akpm@osdl.org> <20060619162740.GA5817@schatzie.adilger.int> <4496D606.8070402@namesys.com> <20060619185049.GH5817@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619185049.GH5817@schatzie.adilger.int>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 12:50:49PM -0600, Andreas Dilger wrote:
> On Jun 19, 2006  09:51 -0700, Hans Reiser wrote:
> > Andreas Dilger wrote:
> > >With the caveat that I didn't see the original patch, if this can be a step
> > >down the road toward supporting delayed allocation at the VFS level then
> > >I'm all for such changes.
> >
> > What do you mean by supporting delayed allocation at the VFS level?  Do
> > you mean calling to the FS or maybe just not stepping on the FS's toes
> > so much or?  Delayed allocation is very fs specific in so far as I can
> > imagine it.
> 
> Currently the VM/VFS call into the filesystem in ->prepare_write for each
> page to do block allocation for the filesystem.  This is the filesystem's
> chance to return -ENOSPC, etc, because after that point the dirty pages
> are written asynchronously and there is no guarantee that the application
> will even be around when they are finally written to disk.
> 
> If the VFS supported delayed allocation it would call into the filesystem
> on a per-sys_write basis to allow the filesystem to RESERVE space for all
> of the pages in the write call,

The VFS doesn't need to support delalloc as delalloc is fundamentally a
filesystem property. The VFS it already provides a hook for delalloc space
reservation that can return ENOSPC - it's called ->prepare_write().

Sure, a batch interface would be nice, but that's an optimisation that
needs to be done regardless of whether the filesystem supports delalloc or
not.  The current ->prepare_write() interface shows its limits when having to
do hundreds of thousands (millions, even) of ->prepare_write() calls per
second. This makes for entertaining scaling problems that batching would
make less of a problem.

> and then later (under memory pressure,
> page aging, or even "pull" from the fs) submit a whole batch of contiguous
> pages to the fs efficiently (via ->fill_pages() or whatever).

Can be done right now - XFS does this probe-and-pull operation already for
writes. See xfs_probe_cluster(), xfs_cluster_write() and friends.

Yes, it would be nice to have the VM pass us clusters of adjacent pages, but
given that the file layout drives the cluster size it is more appropriate
to do this from the filesystem. Also, the pages do not contain the state
necessary for the VM to cluster pages in an way that results in efficient
I/O patterns.

Basically, the only thing really needed from the VFS/VM is a method of tagging
delalloc (or unwritten) pages so that the writepage path knows how to treat
the page being written. Currently we keep that state in bufferheads (e.g. see
buffer_delay() usage) attached to the page......

> The fs can know at that time the final file size (if the file isn't still
> being dirtied), can allocate all these blocks in a contiguous chunk, can
> submit all of the IO in a single bio to the block layer or RPC/RDMA to net.

You don't need to know the final file size - just what is contiguous in the
page cache and in the same state as the page being flushed.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
