Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264490AbRFIVpY>; Sat, 9 Jun 2001 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264491AbRFIVpP>; Sat, 9 Jun 2001 17:45:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41893 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264490AbRFIVo4>;
	Sat, 9 Jun 2001 17:44:56 -0400
Date: Sat, 9 Jun 2001 17:44:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Dawson Engler <engler@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
In-Reply-To: <Pine.LNX.4.21.0106091339090.26520-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0106091658040.19361-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Jun 2001, Linus Torvalds wrote:

> On Sat, 9 Jun 2001, Alexander Viro wrote:
> > 
> > True, but... I can easily see the situation when ->foo() and ->bar()
> > both call a helper function which needs BKL for a small piece of code.
> 
> I'd hope that we can fix the small helper functions to not need BKL -
> there are already many circumstances where you can't use the BKL anyway
> (ie you already hold a spinlock - I'd really like to have the rule that
> the BKL is the "outermost" of all spinlocks, as we could in theory some
> day use it as a point to schedule away on BKL contention).
> 
> > ObUnrelated: fs/super.c is getting to the point where it naturally
> > falls into two files - one that deals with mount cache and all things
> > vfsmount-related, mount tree manipulations, etc. and another that deals
> > with superblocks. Mind if I split the thing?
> 
> Sure. As long as there is some sane naming and not too many new non-static
> functions. Maybe just "fs/mount.c" for the vfsmount caches etc.

Umm... In the final variant of patch all interaction is done by
alloc_vfsmnt() and set_devname() on one side and kill_super(),
do_kern_mount() and do_remount_sb() on another. That is, aside
of the currently public functions (actually, some of them are
gone - kern_umount is #defined to mntput and kern_mount became
a trivial inlined wrapper around do_kern_mount, change_root is
gone, etc.).

In my variant it was called fs/namespace.c, basically since I prefer
the names along the line "what does it deal with" (answer: user-visible
namespace) to "what action is done here" ones, especially since mount(2)
is not the only syscall exported (pivot_root(2) and umount(2) are also
handled here).

After all, inode.c, dcache.c, buffer.c, locks.c, devices.c, etc. are named
that way. OTOH, open.c and namei.c are not, so... Up to you - my preference
would be a noun and namespace looks better than next contender (mntcache),
but that's your call - filenames in core kernel...

