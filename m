Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWDRA3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWDRA3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 20:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWDRA3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 20:29:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62898 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751382AbWDRA3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 20:29:35 -0400
Date: Tue, 18 Apr 2006 10:29:28 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: shrink_dcache_sb scalability problem.
Message-ID: <20060418002928.GB7574742@melbourne.sgi.com>
References: <20060413082210.GM1484909@melbourne.sgi.com> <20060413015257.5b9d0972.akpm@osdl.org> <20060414034332.GN1484909@melbourne.sgi.com> <20060413222325.77f9ec9b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060413222325.77f9ec9b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 10:23:25PM -0700, Andrew Morton wrote:
> David Chinner <dgc@sgi.com> wrote:
> >  I've already fixed that problem with:
> > 
> >  http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1fc5d959d88a5f77aa7e4435f6c9d0e2d2236704
> > 
> >  and the machine showing the shrink_dcache_sb() problems is
> >  already running that fix. That problem masked the shrink_dcache_sb
> >  one - who notices a 10s hang when the machine has been really,
> >  really slow for 20 minutes?
> 
> So the problem is shrink_dcache_sb() and not regular memory reclaim?

*nod*

> What is happening on that machine to be triggering shrink_dcache_sb()? 
> automounts?

That was what i first suspected as themachine has lots of automounted
directories. however, breaking into kdb when the problem occurred
showed mounts of sysfs and /dev/pts.

>From what I've been told, the chroot package build environment being
used (not something we control) mounts /proc, /sys, /dev/pts, etc
when the chroot is entered, and unmounts them after the build is
complete. hence for every package build an engineer kicks off, we
get multiple mounts and unmounts occurring.

> We fixed a similar problem in the inode cache a year or so back by creating
> per-superblock inode lists, so that
> search-a-global-list-for-objects-belonging-to-this-superblock thing went
> away.  Presumably we could fix this in the same manner.  But adding two
> more pointers to struct dentry would hurt.

*nod*

I can't see æny fields we'd be able to overload, either.

> An alternative might be to remove the global LRU altogether, make it
> per-superblock.  That would reduce the quality of the LRUing, but that
> probably wouldn't hurt a lot.

That makes reclaim an interesting problem. You'd have to walk the
superblock list to get to each lru, and then how would you ensure
that you fairly reclaim inodes from each filesystem?

> Another idea would be to take shrinker_sem for writing when running
> shrink_dcache_sb() - that would prevent tasks from coming in and getting
> stuck on dcache_lock, but there are plentry of other places which want
> dcache_lock.

Yeah, the contention we are seeing is from all those other places, so I
can't see how taking the shrinker semaphore reall helps us here.

> I don't immediately see any simple tweaks which would allow us to avoid that
> long lock hold time.  Perhaps the scanning in shrink_dcache_sb() could use
> just rcu_read_lock()...

We're modifying the list as we scan it, so I can't see how we can do
this without an exclusive lock.

The other thing that I thought of over the weekend is per-node LRU
lists and a lock per node This will reduce the length of the lists,
allow some parallelism even while we scan and purge each list
using the existing algorithm, and not completely destroy the LRU-ness
of the dcache.

It would also allow parallelising prune_dcache() and allow the
shrinker to prune the local node first (i.e. where we really need
the memory).

FWIW, this is a showstopper for us. The only thing that is allowing
us to keep running a recent kernel on this machine is the fact that
someone is running `echo 3 > /proc/sys/vm/drop_caches` as soon
as the slowdown manifests to blow away the dentry cache....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
