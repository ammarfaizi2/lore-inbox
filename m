Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317156AbSEXPh0>; Fri, 24 May 2002 11:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317144AbSEXPhY>; Fri, 24 May 2002 11:37:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11050 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317156AbSEXPhO>; Fri, 24 May 2002 11:37:14 -0400
Date: Fri, 24 May 2002 17:36:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: negative dentries wasting ram
Message-ID: <20020524153624.GL21164@dualathlon.random>
In-Reply-To: <20020524071657.GI21164@dualathlon.random> <20020524081043.GB9485@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 02:10:43AM -0600, Andreas Dilger wrote:
> On May 24, 2002  09:16 +0200, Andrea Arcangeli wrote:
> > I actually noticed that after an unlink the dentry wasn't released (the
> > inode was released the dentry wasn't). At first I thought it was a bug,
> > then while reading the code I noticed this is intentional.
> 
> The benefits of negative dentries are also there, although in some cases
> (such as with many thousands of use-once files are deleted) the drawbacks
> probably outweigh the benefits.  The benefits are that the VFS does not
> need to do _very_slow_ access to the filesystem (=disk) when resolving
> executables in the PATH or dynamic libraries in ld.so.

The fs access will be exactly the same, only the dentry won't be
allocated because it's just in the hash, but it has no inode and it
doesn't correspond to any on-disk dentry, we simply cannot defer the
removal of the dentry on disk otherwise if we SYSRQ+B after some hour
those stale deleted dentries would showup at the next reboot. So I don't
see any possible difference in disk access. Furthmore to resolve
executables in path etc.. those exec or libs will never be negative
dentries, the dentries are turned to negative only once they're deleted,
and of course they're finally collected when the parent dir is rmdirred.
If it was beneficial to keep them hanging around, why don't you also
turn the parent dir into a negative dentry and you want somebody to
recreate the dir and all its subdirs? (if you did that, then you whould
notice the waste of ram even while doing normal cp -a and rm -r of the
kernel)

> 
> What I did to fix this problem was to put negative dentries at the end of
> the dentry_unused list and not mark them referenced until the second time
> they are used.  This allows these unused negative dentries to be reaped
> easily, even if we are under memory pressure from a non-GFP_FS allocator
> (which would otherwise not allow the dcache to be scanned because of
> deadlock problems).

that certainly helps but it's still not enough, still the vm will start
shrinking the dcache when there's the first remote sign of pagecache
shortage, so if there are giga of clean pagecache such negative dentries
will keep wasting ram because prune_dcache won't be invoked during such
workload. this isn't going to change easily in 2.4 also because doing so
is a sane algorithm (it's the same in 2.2 and 2.5 too indeed, in 2.5 we
may consider changing the dentry recalamtion logic, but still it make
sense to first work on the pagecache or under pagecache pollution the
dcache would be turned down to zero immediatly basically dropping all
the caching benefits of avoiding the i_op->lookup and only adding
overhead in building the in-core lookup mechanism, so it's not that 2.4
is very bad in doing that, it's ok)

So in short those useless negative dentries will always cause useful
caching pagecache to be dropped.

> Otherwise, these dentries must go through the LRU twice before they
> are freed (once to clear referenced flag, again to get to the end of
> the list).  The old code also didn't allow pruning any dentries under
> a non-GFP_FS allocator, so you couldn't free these dentries at the time
> you need to free them.
> 
> The patch I've had in my tree for a long time is below.  In my testing
> at the time I wrote this patch, it didn't totally eliminate dentry
> cache growth, but it did cap it at a reasonable level (i.e. when memory
> pressure started up the dcache was shrunk until it held a steady size).

For an efficient vm all useless cache that could grow to an huge level
(in particular if it's an high prio cache that is shrunk later) must be
collected away as soon as possible, not lazily relying on the vm. low
prio caches that are shrunk immediatly like slab are fine to be
collected lazily, that is the whole point behind their design, they're
like free ram, dcache negative dentries aren't like free ram.

At the very least if they really provide any kind of benefit that I
cannot see all negative dentries should be put in a separate list that
is shrunk by the vm constantly in front of kmem_cache_reap, that would
fix the problem too, but I think it's simpler to avoid them to be stale
around, at least until I see some benefit from having them hanging
around.

thanks for the feedback!

Andrea
