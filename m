Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282407AbRKXJjR>; Sat, 24 Nov 2001 04:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282409AbRKXJjH>; Sat, 24 Nov 2001 04:39:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17989 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282407AbRKXJix>; Sat, 24 Nov 2001 04:38:53 -0500
Date: Sat, 24 Nov 2001 10:38:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124103854.I1419@athlon.random>
In-Reply-To: <20011124092126.D1419@athlon.random> <Pine.GSO.4.21.0111240321470.4000-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111240321470.4000-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 24, 2001 at 03:38:07AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 03:38:07AM -0500, Alexander Viro wrote:
> 
> 
> On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> 
> > I don't think it's harder to debug, you need the per-superblock data
> > structures for ->clear_inode() also if you try to ->clear_inode in iput,
> > and I cannot see any valid reason for which the fs would be allowed to
> > screwup the superblock before returning from read_inode. As soon as you
> > call iget the superblock must be sane and there's no point in screwing
> > it up afterwards.
> 
> Sigh...
> 
> 	set per-sb structures
> 	...
> 	iget()
> 	...
> 	sanity checks
> 	...
> 	normal return
> sanity_checks_failed:
> 	iput()
> 	...
> 	free per-sb structures
> 	...
> 	return NULL;
> 
> Looks sane, doesn't it?  And that's pretty much the only way to go if

yes, it's definitely sane.

> we allocate that stuff dynamically.  With your variant we _must_ call
> invalidate_inodes() here to force eviction from icache.  What's more,
> not calling it will screw up non-deterministically - it will survive
> if inode gets evicted in the right interval and produce whatever damage
> it's going to produce if eviction happens too late.
> 
> Again, what we really want here is "don't keep inodes dropped during
> ->read_super() or ->put_super() in icache".  You propose to stick
> invalidate_inodes() in a bunch of places so that it would kill these
> inodes before it's too late.  For some filesystems it would be

correct.

> covered by ones you add in fs/super.c, for other it would need
> explicit calls, required positions may depend on the fs internals
> and change with them...  What I propose is "don't wait, kill them
> immediately and forget about the whole thing".

I don't like bloating iput with code just needed for backwards
compatibility with buggy code and for a non common case (infact it's not
even backwards compatibiltiy, if something it would be instead bugwards
compatibility 8).

OTOH I see the iget/iput semantics within the read_super/put_super (not
the code!) would be cleaner your way, so we don't even need to document
that if a per-sb ->clear_inode needs to access any per-sb special
structures, invalidate_inodes(sb) must be called before freeing the
per-sb structures [always ignoring any possible flush] (plus the fact
sb->s_op must not be clobbered before returning from read_super, so that
the vfs can see the s_op->clear_inode, but nobody should do that
anyways).  btw, even your way we should still make sure nobody is
calling iput after freeing the per-sb structures :).

In practice I had a very short look at all the ->clear_inode implemented
and none seems to need the special per-sb structures, so I think also my
patch is just fine for current tree 2.4. (I guess somebody should check
xfs and jfs too)

I think long term (2.5) the right way is to replace all the iput in the
slow fail paths with a iput_not_mounted, that will avoid both the iput
clobbering and the MS_ACTIVE tracking. The differentiation should be
quite self documenting (so people will taste that this iput_not_mounted
is kind of raw thing that will flush + ->clear_inode and destroy the
inode synchronously, so ->clear_inode has to work while recalling
iput_not_mounted).  It should be very easy to identify the iputs in the
read_super/put_super paths to replace them with the iput_not_mounted (at
least for the normal fs like ext2/minix etc..).

Andrea
