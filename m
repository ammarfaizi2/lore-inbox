Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271634AbRIBPiz>; Sun, 2 Sep 2001 11:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271635AbRIBPie>; Sun, 2 Sep 2001 11:38:34 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:39097 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271634AbRIBPiP>; Sun, 2 Sep 2001 11:38:15 -0400
Date: Sun, 2 Sep 2001 09:38:10 -0600
Message-Id: <200109021538.f82FcAB15856@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] lazy allocation of struct block_device
In-Reply-To: <Pine.GSO.4.21.0109020719220.21487-100000@weyl.math.psu.edu>
In-Reply-To: <200109021024.KAA18358@vlet.cwi.nl>
	<Pine.GSO.4.21.0109020719220.21487-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Sun, 2 Sep 2001 Andries.Brouwer@cwi.nl wrote:
> 
> > That majors allocation is frozen is not my problem.
> > I make life simple with a 64-bit dev_t. Everybody else already has the
> > disadvantages of a 64-bit dev_t, since glibc moves 64 bits around,
> > but not the advantage of a large namespace.
> 
> Not an option for any tree I'd ever run on my box and IIRC Linus was not
> likely to inflict that on his.  As for the glibc...
> 	a) not everything uses this piece of shit

Nod.

> 	b) it would be really nice to get rid of it completely someday

Or at the very least, to selectively not compile large chunks of stuff
that went in that I will never need. Stuff that isn't there on libc5
and other Unices. Something that takes up less than half a floppy.
And having source and binary compatibility between major releases
wouldn't hurt either!

> > Concerning devfs, I don't use it and have not really thought about it.
> > I think my point of view would be that devfs provides a different object.
> > A device node in a filesystem is a pair (pathname, dev_t).
> > Opening it gives the triple (pathname, dev_t, kdev_t).
> > What devfs provides is (pathname), after opening (pathname, kdev_t).
> 
> Wait a second.  To hell with devfs, I'm talking about any synthetic
> tree containing device nodes.  Being forced to allocate a point in
> numeric namespace just to be able to associate a driver-created
> inode with (also driver-created) device...  Looks rather bogus, not
> to mention the ugliness of maintaining said numeric namespace.

Nod.

> > But I think the pointer kdev_t (or i_bcdev) must still be recomputed:
> > it remains true that modules can be unloaded.
> 
> Umm... So what? They can be unloaded only when we have device not opened.
> We might leave both allocation and freeing to driver-side code (and that
> includes grok_partitions()) and let the freeing code reset ->i_bdev and
> friends in all relevant inodes.

Yep. Having to allocate/search for a device structure during open(2)
is insane. It's wasteful. For ext2fs you can do it in lookup(), and
for devfs (or similar) you can do the ideal thing: when the device
entry is registered with the FS (i.e. only once).


				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
