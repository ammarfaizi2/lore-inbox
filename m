Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262171AbSJFUCJ>; Sun, 6 Oct 2002 16:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262167AbSJFUCJ>; Sun, 6 Oct 2002 16:02:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11456 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262171AbSJFUCH>;
	Sun, 6 Oct 2002 16:02:07 -0400
Date: Sun, 6 Oct 2002 16:07:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] killing DEVFS_FL_AUTO_OWNER
In-Reply-To: <200210061932.g96JW3527255@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0210061550100.25699-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Oct 2002, Richard Gooch wrote:

> Well, I can't comment on the video1394 driver. I don't really know why
> they are using DEVFS_FL_AUTO_OWNER. If their device node is safe to
> have rw-rw-rw- (like with PTY slaves), then it's not a problem.
> However, if the driver allows you to do Bad Things[tm] if you can read
> or write to the device node, then the driver is buggy, and is abusing
> DEVFS_FL_AUTO_OWNER.
> 
> So we should get input from the driver maintainer as to what the
> intent is.

1) current implementation does _not_ reset uid/gid after the first open().
It either stays as it was (until the d_delete) or gets reset to root.root.666
(after d_delete) and stays that way.

Notice that your code that sets it is in the very end of devfs_open() - in
the part that is run once.  df->open is never reset, so...

Oh, BTW - you have

	if (df->open) return 0;
	df->open = TRUE;

with no locking whatsoever - you'd reduced BKL-covered area so that it doesn't
cover that place.  With obvious consequences...

2) either applications do care to do chmod/chown (and in that case
DEVFS_FL_AUTO_OWNER is simply irrelevant), or they are
	* broken on non-devfs systems
	* broken on devfs systems due to (1)

Having world-readable video camera is an obvious security problem, so
applications _must_ deal with that, for non-devfs systems if nothing
else.

3) this crap is the only thing that still uses DEVFS_FL_AUTO_OWNER.


IOW, we should remove it and send heads-up to driver authors.  End of
story.

Another thing: when you do devfs_register(), the thing creates intermediate
directories.  However, devfs_unregister() on the same node doesn't undo
the effect of devfs_register() - directories stay around, even if nothing
else holds them.

Proposal: add a counter to devfs entries of directories so that
	* result of devfs_mk_dir would have it set to 1
	* creation of child in a directory would increment it by 1
	* removal of child would decrement it by 1
	* when counter drops to 0 (which means that directory had
been created implictly by devfs_register() and all children are gone)
we unregister directory.  That, in turn, can cause unregistering its
parent, etc.

That would cut down the amount of work done in drivers (esp. block device
drivers) and allow to simplify the ad-hackery in partitions/check.c.

It's trivial to implement, so if you have objections to that - tell it now.

