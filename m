Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282404AbRKXIid>; Sat, 24 Nov 2001 03:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282403AbRKXIiY>; Sat, 24 Nov 2001 03:38:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61159 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282404AbRKXIiL>;
	Sat, 24 Nov 2001 03:38:11 -0500
Date: Sat, 24 Nov 2001 03:38:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124092126.D1419@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240321470.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> I don't think it's harder to debug, you need the per-superblock data
> structures for ->clear_inode() also if you try to ->clear_inode in iput,
> and I cannot see any valid reason for which the fs would be allowed to
> screwup the superblock before returning from read_inode. As soon as you
> call iget the superblock must be sane and there's no point in screwing
> it up afterwards.

Sigh...

	set per-sb structures
	...
	iget()
	...
	sanity checks
	...
	normal return
sanity_checks_failed:
	iput()
	...
	free per-sb structures
	...
	return NULL;

Looks sane, doesn't it?  And that's pretty much the only way to go if
we allocate that stuff dynamically.  With your variant we _must_ call
invalidate_inodes() here to force eviction from icache.  What's more,
not calling it will screw up non-deterministically - it will survive
if inode gets evicted in the right interval and produce whatever damage
it's going to produce if eviction happens too late.

Again, what we really want here is "don't keep inodes dropped during
->read_super() or ->put_super() in icache".  You propose to stick
invalidate_inodes() in a bunch of places so that it would kill these
inodes before it's too late.  For some filesystems it would be
covered by ones you add in fs/super.c, for other it would need
explicit calls, required positions may depend on the fs internals
and change with them...  What I propose is "don't wait, kill them
immediately and forget about the whole thing".

