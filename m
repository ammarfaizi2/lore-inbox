Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286169AbRLJGuA>; Mon, 10 Dec 2001 01:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286170AbRLJGtt>; Mon, 10 Dec 2001 01:49:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13777 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286169AbRLJGtm>;
	Mon, 10 Dec 2001 01:49:42 -0500
Date: Mon, 10 Dec 2001 01:49:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <Pine.LNX.4.33.0112092220400.13692-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112100138250.12421-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, Linus Torvalds wrote:

> Having in-core data in CPU-native byte order is _stupid_. We used to do
> that, and I winced every time I had to look at all the duplication of
> functions. I think it was early 2.3.x when Ingo did the page cache write
> stuff where I fixed that - the people who had done the original ext2
> endianness patches were just fairly lacking in brains (Hi, Davem ;), and
> didn't realize that keeping inode data in host order was the fundamental
> problem that caused them to have to duplicate all the functions.
> 
> So the _wart_ is in 2.2.x, which is just stupid and ugly, and keeps block
> numbers in host data format - which causes no end of trouble. 2.4.x
> doesn't have this problem, and could easily have a pointer to the on-disk
> representation.

	As an aside, anybody who uses SWAB... should cut down on drugs.
Code like
	native_endian = fs_endian;
	if (need_swap)
		native_endian = SWAB16(fs_endian);
or, worse yet, same with ifdef instead of if is fscking braindead.

_Never_ treat data from IO as numeric.  Incompatible by assignment.  If
you have a little-endian data and CPU and your foo_to_cpu() is identity
mapping - fine, but keep that fact in definition of foo_to_cpu().

Endian-neutral code is _easy_ - you need to try real hard to write something
that would be endian-dependent.  All you need is to ask yourself "is it
a number or a piece of on-disk data?" and then stick to that.  And these
pointers in inode are obvious pieces of on-disk data - no bloody questions
on that.

For real horror look at 2.2 UFS.  At least in ext2 DaveM et.al. had enough
sense to use le32_to_cpu() and friends.  In UFS it was SWAB...() abortion
all over the place.

