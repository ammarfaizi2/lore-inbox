Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbSJFT0a>; Sun, 6 Oct 2002 15:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262140AbSJFT0a>; Sun, 6 Oct 2002 15:26:30 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:41092 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262139AbSJFT03>; Sun, 6 Oct 2002 15:26:29 -0400
Date: Sun, 6 Oct 2002 13:32:03 -0600
Message-Id: <200210061932.g96JW3527255@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] killing DEVFS_FL_AUTO_OWNER
In-Reply-To: <Pine.GSO.4.21.0210061428540.25699-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0210061428540.25699-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	Devfs supports an interesting "feature" (read: gaping security
> hole waiting to happen).  Namely, there is one (1) driver that asks
> for the following behaviour:
> 	its nodes (/dev/video1394/*) are created with root.root rw-rw-rw-
> 	opening a node sets (with feel^Wraces) ownership to that of opening
> task and mode to rw-------.
> 	if you close it, wait for dentry to be evicted and open it again -
> you get root.root rw-rw-rw- and it will stay that way after open().
> 
> Now, I might try and guess WTF had been intended (reversion to
> permissions of the Beast upon final close() and subsequent open()
> acting as the first one), but even if it would behave that way...

The orginal use for DEVFS_FL_AUTO_OWNER was for PTY slaves,
particularly the BSD-style ones. It allows a non-suid root process to
open an unused PTY and be given ownership of it. Good for non-suid
xterms.

Later, I created DEVFS_FL_CURRENT_OWNER, and used that (in combination
with unregistering PTY slaves when the master is closed). That seemed
a cleaner approach.

> Just ask yourself what will happen to any program that relies on
> this behavior on a system where /dev is not on devfs.  And that,
> BTW, is the setup suggested by vidoe1394 folks on their homepage.
> 
> Now, I don't ask WTF had been smoked to produce that code - I don't
> want to know and it's probably illegal anywhere (if it isn't, it
> should be).  The question is could we fscking please remove that
> idiocy?  Unless somebody gives a good reason why behaviour of
> DEVFS_FL_AUTO_OWNER is _not_ a security hole - I'm submitting a
> patch that removes this crap in a couple of hours.

Well, I can't comment on the video1394 driver. I don't really know why
they are using DEVFS_FL_AUTO_OWNER. If their device node is safe to
have rw-rw-rw- (like with PTY slaves), then it's not a problem.
However, if the driver allows you to do Bad Things[tm] if you can read
or write to the device node, then the driver is buggy, and is abusing
DEVFS_FL_AUTO_OWNER.

So we should get input from the driver maintainer as to what the
intent is.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
