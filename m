Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRJ0PPZ>; Sat, 27 Oct 2001 11:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273534AbRJ0PPP>; Sat, 27 Oct 2001 11:15:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23498 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273364AbRJ0PPK>;
	Sat, 27 Oct 2001 11:15:10 -0400
Date: Sat, 27 Oct 2001 11:15:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: alain@linux.lu
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
In-Reply-To: <200110271500.f9RF0vO01848@hitchhiker.org.lu>
Message-ID: <Pine.GSO.4.21.0110271103560.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Oct 2001, Alain Knaff wrote:

> Appended to this mail is a patch meant to fix the "non-cached floppy"
> problem.

a) you _still_ need to stop all pending IO (readaheads in progress)
before final ->release()

b) at which point do you flush the cache?  It definitely shouldn't
survive rmmod.  And no, unregister_blkdev() is not a solution, courtesy
of devfs with its insane devfs=only option.

There is a related problem which is much nastier than short-living caches:
code that does bdev->bd_op = <stuff from devfs>;  blkdev_get(bdev, ...);
Think what happens if rmmod comes while blkdev_get() sleeps ob ->bd_sem.
Notice that it had been there since the moment when devfs went into the
tree.  Sigh...

