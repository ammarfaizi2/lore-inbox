Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314123AbSDZSuy>; Fri, 26 Apr 2002 14:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314126AbSDZSux>; Fri, 26 Apr 2002 14:50:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40834 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314123AbSDZSuv>;
	Fri, 26 Apr 2002 14:50:51 -0400
Date: Fri, 26 Apr 2002 14:46:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Andries.Brouwer@cwi.nl, Jeff Chua <jeffchua@silk.corp.fedex.com>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Dreher <dreher@math.tu-freiberg.de>
Subject: Re: 2.4.19-pre7: rootfs mounted twice
In-Reply-To: <Pine.LNX.4.44.0204270145140.6483-100000@boston.corp.fedex.com>
Message-ID: <Pine.GSO.4.21.0204261434280.22065-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Apr 2002, Jeff Chua wrote:

> This happens all the time if you use initrd ramdisk and switch to hard
> disk during boot up.

This happens all the time with rootfs, period.  For exactly the same
reasons.

Again, we could hide that fact (we _do_ have a filesystem mounted
underneath the final root), but I'm not sure that it's worth hiding.
The real problem is in the interaction between df(1) and /proc/mounts
and it occurs every time when mountpoint happens to be a root of
already mounted filesystem.  Which could happen at any time since
the beginning of 2.4 (actually, way back in 2.3).

Notice that the same bug happens in _all_ version for chroot environment.
Namely, df(1) will try to call statfs() for mountpoints outside chroot
jail and that will give very interesting output, since results were for
corresponsing directories _inside_ the jail.

Arguably, correct way to handle that is to leave everything outside the
process' root out of /proc/mounts.  Which would solve both the chroot
problems and rootfs one (all processes are chrooted into the "final"
root).  It _still_ doesn't solve the old problem with overmounts, but
that one could be only handled in userland (by letting df(1) notice
that several getmntent(3) have the same mountpoint and ignore all
but the last one).

Unless somebody has a good reason why /proc/mounts in chroot jail should
show objects outside it, I'm going to do it that way.

