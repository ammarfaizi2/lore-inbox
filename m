Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271635AbRIBQHs>; Sun, 2 Sep 2001 12:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271637AbRIBQHi>; Sun, 2 Sep 2001 12:07:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9114 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271635AbRIBQH0>;
	Sun, 2 Sep 2001 12:07:26 -0400
Date: Sun, 2 Sep 2001 12:07:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] lazy allocation of struct block_device
In-Reply-To: <200109021538.f82FcAB15856@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0109021156050.21487-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Sep 2001, Richard Gooch wrote:

> Yep. Having to allocate/search for a device structure during open(2)
> is insane. It's wasteful. For ext2fs you can do it in lookup(), and
> for devfs (or similar) you can do the ideal thing: when the device
> entry is registered with the FS (i.e. only once).

No.  We _must_ do it on ->open() for cases when it had been NULL.  Driver
might be not there at ->lookup() time and hunting down all inodes with
give major/minor is insanity.

Now, if inode had been created by the driver - sure, we create the association
between it and <whatever>_device from the very beginning.

We must support device nodes on normal filesystems.  Period.  They are there
on tons of boxen and current support for device nodes on synthetic trees
is _not_ suitable for general use (== I'd question sanity of anyone using
it on production multiuser boxen).

Support for such beasts is there to stay.  However, we shouldn't do things
that make allocation of new majors mandatory.  IOW, as far as I'm concerned
solutions that do not allow "establish connection with foo_device upon
inode creation and don't bother with device number for that one" are
broken.

