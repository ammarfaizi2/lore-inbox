Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271608AbRIBKZK>; Sun, 2 Sep 2001 06:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271609AbRIBKY7>; Sun, 2 Sep 2001 06:24:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50149 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271608AbRIBKYq>;
	Sun, 2 Sep 2001 06:24:46 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 2 Sep 2001 10:24:30 GMT
Message-Id: <200109021024.KAA18358@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [RFC] lazy allocation of struct block_device
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Sun Sep  2 01:54:52 2001

    On Sat, 1 Sep 2001 Andries.Brouwer@cwi.nl wrote:

    > Since the refcount is for the device struct, we cannot do anything
    > until that count hits zero. Then the release method of the device struct
    > is called (which frees it, or decrements a refcount for the module).

    Wait a minute. You had suggested (upthread) that these objects are allocated
    by partition code and contain per-partition data. Freeing them once the device
    is closed looks very odd.

The partition data itself is in the gendisk chain.
A device struct contains a pointer to it.

But this is a separate discussion: what is the precise contents of
device struct and driver struct.

(I have used different versions. My main interest was always in
turning k[b]dev_t into a pointer and removing the arrays. Since some
of the arrays are 1-dimensional and some are 2-dimensional, the
mechanical conversion leads to a majorstruct that contains the integer
major and a name function and the contents of the 1-dimensional arrays,
and a minorstruct that contains the integer minor and the contents
of the 2-dimensional arrays and a pointer to the majorstruct.
People tend to panic "don't you know that there is no 1-1 corr.."
when they hear "majorstruct" so I started using "driverstruct".)

    > After this i_bcdev cannot be used anymore.
    > Since we don't know whether this happened already, i_bcdev must be
    > recomputed on each open or mount.

    ... and that means that we can't make devfs-like filesystems just set
    ->i_bdev (or ->i_cdev) at read_super() (or lookup()) and avoid all mess
    with major/minor allocation.  IMO that's unfortunate, especially since
    majors allocation is on the permanent freeze.

That majors allocation is frozen is not my problem.
I make life simple with a 64-bit dev_t. Everybody else already has the
disadvantages of a 64-bit dev_t, since glibc moves 64 bits around,
but not the advantage of a large namespace.
But that is a separate discussion.

Concerning devfs, I don't use it and have not really thought about it.
I think my point of view would be that devfs provides a different object.
A device node in a filesystem is a pair (pathname, dev_t).
Opening it gives the triple (pathname, dev_t, kdev_t).
What devfs provides is (pathname), after opening (pathname, kdev_t).
But I think the pointer kdev_t (or i_bcdev) must still be recomputed:
it remains true that modules can be unloaded.

    > (One might invent additional data structure to avoid this recomputation,
    > but data structures take memory and add the complication that they
    > must be kept consistent and up-to-date. Since mounting, or opening
    > a block device, are very infrequent operations, it does not matter
    > that we do a possibly superfluous bdopen().)

    Once you look at character devices (they have same set of problems)
    frequency goes up big way.

True. I still think there would be no problem - this reopen is not expensive.

Alternatives like putting these things in a list are much worse,
since that would slow down the handling of all inodes, not only
device nodes.

Andries
