Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSEXTzr>; Fri, 24 May 2002 15:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314906AbSEXTzq>; Fri, 24 May 2002 15:55:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27614 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314885AbSEXTzp>;
	Fri, 24 May 2002 15:55:45 -0400
Date: Fri, 24 May 2002 15:55:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524194344.GH15703@dualathlon.random>
Message-ID: <Pine.GSO.4.21.0205241549520.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Andrea Arcangeli wrote:
 
> and they provide useful cache, they remebers the i_size and everything
> else that you need to read from disk the next time a lookup that ends in
> such inode happens. It's not a "this dentry doesn't exist" kind of
> info after an unlink, so very very unlikely to be ever needed
> information. Furthmore there cannot be an huge grow of those inodes see
> below.

That's crap, since there _IS_ such a grow.  Again, they easily sit around
for 5-7 minutes without a single attempt to access them, while the system
is swapping like hell.

> It's a "I know everything about this valid inode" that is been used in
> the past and that may be used in the future, so I feel it's an order of
> magnitude more useful information.

It's "I hadn't touched that inode in quite a while, but I'll retain it
in-core almost indefinitely".

> means there's mem pressure, so the inode as well will be collected soon,
> prune_icache is run right after prune_dcache. So only the very last
> inodes will be left there for minutes, and they will belong to the most
> hot dentries, so very likely to be required again by a later iget as
> soon as the dentry is re-created. It don't see any similarity to the
> unlink-dentry-negative issue.

Again, inodes are in that state only if there is no dentry pointing to
them.  And in _that_ state (== no references from the rest of kernel)
they happily sit around for minutes.

> But if you want to change the iput so that the inode is discared at the
> last iput that probably won't make much differnce, but I don't see any
> benefit. As said until the last prune_icache, most of the inodes are
> released anyways after they become unused.  But I just don't see a
> problem there, because those inodes won't stays there for minutes
> prune_icache will collect them, and if the last one stays for minute
> it's fine, the dcache aging made sure that if that was the last inode
> left hanging around it is more likely to be reused next and if it's
> reused we avoid a lowlevel ->read_inode. In short the part about the
> inodes destroy procedure looks all right to me.

It's always a pity when trivial testing spoils a beautiful theory, isn't it?

