Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316039AbSFPIgw>; Sun, 16 Jun 2002 04:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSFPIgw>; Sun, 16 Jun 2002 04:36:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61683 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316039AbSFPIgv>;
	Sun, 16 Jun 2002 04:36:51 -0400
Date: Sun, 16 Jun 2002 04:36:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <UTC200206160747.g5G7lqX28244.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0206160418470.3507-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jun 2002 Andries.Brouwer@cwi.nl wrote:

> > Wrong.  That breaks for anything with ->follow_link() that
> > can't be expressed as a single lookup on some path.
> 
> I don't know what interesting out-of-tree filesystems you
> have in mind, but it looks like this would work for all
> systems in the current tree.

Trivial counterexample: procfs.
 
> You are replacing kdev_t by struct block device *, that I
> consider as a refcounted reference to the device. Fine.
> But kdev_t is created by the driver, at the moment the
> device is detected, while struct block device * is created
> at open() time. Thus, the question arises where you plan to

It's a bit trickier than that - on both sides (driver might
modular and then the only thing that can guarantee its presence
is opened device; OTOH, struct block_device can stay around longer
than it's opened)

> store permanent device data like size or sectorsize.

Sector size is kept in the queue.  Disk size - in per-disk objects
that are yet to be introduced in the tree.

Notice that your "permanent" data is not quite permanent - e.g.
information about partitioning can be lost (in all kernels since
2.0, if not earlier) at any moment when nobody has devices opened.
rmmod -a and there you go...

IMO correct approach to such data is that it's generated on demand
(as it is right now - again, consider modular driver; then we don't
see _anything_ about devices until somebody attempts to open one
of them and triggers module loading), cached at least until the things
are opened and forcibly invalidated by the driver when it goes away
or decide that it had lost the disk (e.g. rmmod of low-level SCSI
driver means that everything behind controllers of that type effectively
disappears).

IOW, we certainly should not forget everything upon the final close() -
instead we should leave invalidation to the driver or memory pressure.
And that includes the page cache of device - we need it to become
quiet on the final close so that no IO requests would be generated,
but we don't need it to disappear.

The next series of patches will make struct block_device keep the
information (->bd_op, page cache contents, etc.) past the final
close().  After that we can start moving the stuff in there without
breaking the warranties that exist in the current tree...

