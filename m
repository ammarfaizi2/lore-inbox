Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSEXUhK>; Fri, 24 May 2002 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315096AbSEXUhJ>; Fri, 24 May 2002 16:37:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12114 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315091AbSEXUhH>; Fri, 24 May 2002 16:37:07 -0400
Date: Fri, 24 May 2002 22:36:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
Message-ID: <20020524203630.GJ15703@dualathlon.random>
In-Reply-To: <20020524194344.GH15703@dualathlon.random> <Pine.GSO.4.21.0205241549520.9792-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 03:55:45PM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 24 May 2002, Andrea Arcangeli wrote:
>  
> > and they provide useful cache, they remebers the i_size and everything
> > else that you need to read from disk the next time a lookup that ends in
> > such inode happens. It's not a "this dentry doesn't exist" kind of
> > info after an unlink, so very very unlikely to be ever needed
> > information. Furthmore there cannot be an huge grow of those inodes see
> > below.
> 
> That's crap, since there _IS_ such a grow.  Again, they easily sit around
> for 5-7 minutes without a single attempt to access them, while the system
> is swapping like hell.

no-way, that's because your vm is broken then, apply vm-35 and it
shouldn't really happen, if the system swaps inodes will be pruned
correcty too, an inode will never stay around for minutes while the
system is swapping. Actually really you may want to apply also my last
fix for the inode highmem balance to be sure to rotate the list, maybe
that could make the difference for this case, but again, if something goes
wrong in this sense it's a prune_icache bug, not a design bug in iput.

> 
> > It's a "I know everything about this valid inode" that is been used in
> > the past and that may be used in the future, so I feel it's an order of
> > magnitude more useful information.
> 
> It's "I hadn't touched that inode in quite a while, but I'll retain it
> in-core almost indefinitely".

disagree, you can apply the same argument to the whole dcache in the
first place (not even the negative one!).

> 
> > means there's mem pressure, so the inode as well will be collected soon,
> > prune_icache is run right after prune_dcache. So only the very last
> > inodes will be left there for minutes, and they will belong to the most
> > hot dentries, so very likely to be required again by a later iget as
> > soon as the dentry is re-created. It don't see any similarity to the
> > unlink-dentry-negative issue.
> 
> Again, inodes are in that state only if there is no dentry pointing to
> them.  And in _that_ state (== no references from the rest of kernel)
> they happily sit around for minutes.

there is no difference at all from the inode side prospective if there's
a dentry or not, nothing guarantees that the dentry will be used soon.

As said unless your vm is broken, freeing the inode at the last iput, so
to have it allocated only when some dentry is pointing to it, shouldn't
nearly make any difference in practice, if it makes big difference that's
a vm problem.

> 
> > But if you want to change the iput so that the inode is discared at the
> > last iput that probably won't make much differnce, but I don't see any
> > benefit. As said until the last prune_icache, most of the inodes are
> > released anyways after they become unused.  But I just don't see a
> > problem there, because those inodes won't stays there for minutes
> > prune_icache will collect them, and if the last one stays for minute
> > it's fine, the dcache aging made sure that if that was the last inode
> > left hanging around it is more likely to be reused next and if it's
> > reused we avoid a lowlevel ->read_inode. In short the part about the
> > inodes destroy procedure looks all right to me.
> 
> It's always a pity when trivial testing spoils a beautiful theory, isn't it?

well, try 2.4.19pre8aa3 + the inode fix I posted this morning, and then
try to spol the theory with the trivial testing again :) I think you
won't spoil it, but I'd like to know if you can reproduce the problem
such way too.

Andrea
