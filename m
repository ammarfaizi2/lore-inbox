Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270577AbRIBLjB>; Sun, 2 Sep 2001 07:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271329AbRIBLiw>; Sun, 2 Sep 2001 07:38:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31891 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270577AbRIBLii>;
	Sun, 2 Sep 2001 07:38:38 -0400
Date: Sun, 2 Sep 2001 07:38:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFC] lazy allocation of struct block_device
In-Reply-To: <200109021024.KAA18358@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0109020719220.21487-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Sep 2001 Andries.Brouwer@cwi.nl wrote:

> That majors allocation is frozen is not my problem.
> I make life simple with a 64-bit dev_t. Everybody else already has the
> disadvantages of a 64-bit dev_t, since glibc moves 64 bits around,
> but not the advantage of a large namespace.

Not an option for any tree I'd ever run on my box and IIRC Linus was not
likely to inflict that on his.  As for the glibc...
	a) not everything uses this piece of shit
	b) it would be really nice to get rid of it completely someday

> But that is a separate discussion.

<nod>

> Concerning devfs, I don't use it and have not really thought about it.
> I think my point of view would be that devfs provides a different object.
> A device node in a filesystem is a pair (pathname, dev_t).
> Opening it gives the triple (pathname, dev_t, kdev_t).
> What devfs provides is (pathname), after opening (pathname, kdev_t).

Wait a second.  To hell with devfs, I'm talking about any synthetic tree
containing device nodes.  Being forced to allocate a point in numeric
namespace just to be able to associate a driver-created inode with
(also driver-created) device...  Looks rather bogus, not to mention the
ugliness of maintaining said numeric namespace.

> But I think the pointer kdev_t (or i_bcdev) must still be recomputed:
> it remains true that modules can be unloaded.

Umm... So what? They can be unloaded only when we have device not opened.
We might leave both allocation and freeing to driver-side code (and that
includes grok_partitions()) and let the freeing code reset ->i_bdev and
friends in all relevant inodes.
 
> Alternatives like putting these things in a list are much worse,
> since that would slow down the handling of all inodes, not only
> device nodes.

???
blkdev_open() would do list_add()
freeing foo_device would go through the list and reset ->i_bdev/do list_del()
for each element.

Where's the overhead for non-device inodes?

