Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130869AbRAHR6p>; Mon, 8 Jan 2001 12:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131876AbRAHR6f>; Mon, 8 Jan 2001 12:58:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12174 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130869AbRAHR6Y>;
	Mon, 8 Jan 2001 12:58:24 -0500
Date: Mon, 8 Jan 2001 12:58:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010108180857.A26776@athlon.random>
Message-ID: <Pine.GSO.4.21.0101081236440.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Andrea Arcangeli wrote:

> Hello Al,
> 
> why `rmdir .` is been deprecated in 2.4.x?  I wrote software that depends on
> `rmdir .` to work (it's local software only for myself so I don't care that it
> may not work on unix) and I'm getting flooded by failing cronjobs since I put
> 2.4.0 on such machine.  `rmdir .` makes perfect sense, the cwd dentry remains
> pinned by me until I `cd ..`, when it gets finally deleted from disk.  I'd like
> if we could resurrect such fine feature (adapting userspace is just a few liner
> but that isn't the point). Comments?

It's a hell of a pain wrt locking. You need to lock the parent, but it can
cease to be your parent while you were locking it. rmdir() (and especially
rename()) are major PITA as is. Adding lock/check/retry everything if
we had been moved was way over the top. Again, rename() was the main
offender, but rmdir() also wasn't nice.

rmdir() and rename() act on links. Yes, for directory there is a special
link - one from the parent and we could try to find it and assume that
caller wanted to do the thing on said link. However, it _is_ overloading
the operation. Adds quite a bit of complexity into the place where we
already have too much. For no good reason, since rmdir(pwd) does the same
thing quite fine, is portable (unlike the rmdir(".") which will fail on
every UNIX except Linux) and does not require special-casing.

All namespace-modifying operation (create/remove/rename) act on the links,
not fs objects. Pathname you are passing identifies the directory entry
that should be affected. Conceptually, actual removal of the inode is a
side effect.

The bottom line: rmdir(".") is gone. Replace it with portable equivalent,
namely
	p = getcwd(pwd, sizeof(pwd));
	if (!p)
		/* handle error - ERANGE or ENOENT */
	rmdir(p);
Shell equivalent is rmdir `pwd`. Also portable.
Same goes for rename(). Notice that _all_ pathes that end on . or .. are
off-limits. Explicit POSIX requirement and in that case I'm 100% agree
with them. Linux used to provide an extension that
	* added complexity (and was handled with races in 2.2)
	* was absolutely nonportable
	* was inconsistent with the semantics of other operations (and
in case of rename() - with other parts of rename() semantics)
	* had simple portable replacement.

He's dead, Jim.

PS: try your code on any other UNIX and see it misbehave.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
