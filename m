Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSEXToW>; Fri, 24 May 2002 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317247AbSEXToV>; Fri, 24 May 2002 15:44:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31050 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317209AbSEXToV>; Fri, 24 May 2002 15:44:21 -0400
Date: Fri, 24 May 2002 21:43:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
Message-ID: <20020524194344.GH15703@dualathlon.random>
In-Reply-To: <20020524185811.GF15703@dualathlon.random> <Pine.GSO.4.21.0205241502000.9792-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 03:04:26PM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 24 May 2002, Andrea Arcangeli wrote:
> 
> > > I might buy that argument if we didn't also leave around _unreferenced_
> > > inodes for minutes in the icache.  And _that_ is much stronger source of
> > 
> > I don't see it, at the last iput of an inode with i_nlink == 0 the inode
> > is freed immediatly, not like the dcache that is left floating around as
> > a negative one with no useful caching effects for most workloads.
> 
> Right.  Now look at the inodes with i_nlink != 0.  And realize that they'd
> already gone through the aging in dcache - if they get to the point of
> final iput(), they have no references remaining.  And _after_ that they
> happily stay in icache for minutes.

and they provide useful cache, they remebers the i_size and everything
else that you need to read from disk the next time a lookup that ends in
such inode happens. It's not a "this dentry doesn't exist" kind of
info after an unlink, so very very unlikely to be ever needed
information. Furthmore there cannot be an huge grow of those inodes see
below.

It's a "I know everything about this valid inode" that is been used in
the past and that may be used in the future, so I feel it's an order of
magnitude more useful information.

And most important if the dentry is collected for not deleted inodes it
means there's mem pressure, so the inode as well will be collected soon,
prune_icache is run right after prune_dcache. So only the very last
inodes will be left there for minutes, and they will belong to the most
hot dentries, so very likely to be required again by a later iget as
soon as the dentry is re-created. It don't see any similarity to the
unlink-dentry-negative issue.

But if you want to change the iput so that the inode is discared at the
last iput that probably won't make much differnce, but I don't see any
benefit. As said until the last prune_icache, most of the inodes are
released anyways after they become unused.  But I just don't see a
problem there, because those inodes won't stays there for minutes
prune_icache will collect them, and if the last one stays for minute
it's fine, the dcache aging made sure that if that was the last inode
left hanging around it is more likely to be reused next and if it's
reused we avoid a lowlevel ->read_inode. In short the part about the
inodes destroy procedure looks all right to me.

Andrea
