Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272603AbRHaEnW>; Fri, 31 Aug 2001 00:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272604AbRHaEnM>; Fri, 31 Aug 2001 00:43:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22989 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272603AbRHaEnF>;
	Fri, 31 Aug 2001 00:43:05 -0400
Date: Fri, 31 Aug 2001 00:43:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries Brouwer <aeb@veritas.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [RFC] lazy allocation of struct block_device
Message-ID: <Pine.GSO.4.21.0108302346050.11975-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, I've looked into that (allocating ->i_bdev upon open()).
There are several problems with this approach and none of the solutions I
can see looks like a clear winner.

1) when do we drop ->i_bdev?
2) how should we change the refcounting on struct block_device?
3) what to do with beasts that don't have major number and just set
->i_bdev when they allocate an inode?

Possible solutions:

a) once we had set ->i_bdev it's there to stay - we free it only when
inode itself is freed.  No changes in refcounting, devfs-like animals
simply do allocation earlier then the rest.

b) ->i_bdev itself doesn't contribute to block_device refcount.  We keep
struct block_device as long as it's opened by somebody.  When everyone
who had inode opened is gone we reset ->i_bdev.

c) allocation/freeing of block_device is controlled by driver (and partitioning
code).  bdcache always corresponds to the block devices that actually are
there.  ->i_bdev is set upon open() and doesn't contribute anything to
refcount.  When we set it, inode is placed on the list anchored in ->i_bdev.
When device goes away we reset ->i_bdev and take inode out of the list.

d) we trust ->i_bdev only for opened inodes.  Whenever we try to open
the thing we do cache lookup (by ->i_rdev) and set ->i_bdev.  Refcounting
on block_device - as in (b).

Each of these variants has problems.

a) Allocation and freeing logics differ.  Not pretty and we still can
overpopulate the cache.

b) We don't know when the last opener of inode goes away.  We know that
for block_device itself, but what to do if several inodes have the same
major/minor?  We can add ->i_openers or something like that, but it means
growing already bloated struct inode _and_ adding overhead to open()/close().
Cases that set ->i_bdev early are not a problem - we could just start with
non-zero ->i_openers.

c) Interesting, and might be the Right Thing(tm), but... we will have to
add register_<something> to drivers of non-partitioned devices (partitioned
ones can do that in grok_partitions()).  We also need to find a reusable
list in struct inode (shouldn't be a problem, since a lot of stuff is never
used for devices) or add a new list_head there.

d) Early-set cases are trouble - we need a new flag ("trust ->i_bdev") to
prevent cache lookups/reassigning ->i_bdev for them.


I could argue for any of these variants - (a) means minimally intrusive
changes, (c) has a potential for moving partition stuff into struct
block_device and opens a way for cleaning a lot of code in drivers/killing
a bunch of arrays/removing a lot of crap from devfs, (b) and (d) give the
smallest cache sizes.

In the long run I'd probably prefer (c), simply because it allows very nice
cleanups for 2.5 - we will need some sort of per-partition structure
allocated when we find a partition anyway and we might point ->i_bdev
to these just fine.  Moreover, we are getting rid of the "same methods
table for everyone with given major" crap, which is a Good Thing(tm).

Linus, it's your decision - it seriously affects architecture.  Either
way, patch won't be too large and all variants can be done in 2.4 just
fine.  Similar problems exist for character devices, but there we
may need more intrusive changes.

Please, comment.
								Al

