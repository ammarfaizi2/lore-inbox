Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbRAHVJ0>; Mon, 8 Jan 2001 16:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbRAHVJH>; Mon, 8 Jan 2001 16:09:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4558 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130070AbRAHVJB>;
	Mon, 8 Jan 2001 16:09:01 -0500
Date: Mon, 8 Jan 2001 16:08:58 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010108213036.T27646@athlon.random>
Message-ID: <Pine.GSO.4.21.0101081537570.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Andrea Arcangeli wrote:

> On Mon, Jan 08, 2001 at 01:04:24PM -0500, Alexander Viro wrote:
> > Racy. Nonportable. Has portable and simple equivalent. Again, don't
> > bother with chdir at all - if you know the name of directory even
> > ../name will work. It's not about the current directory. It's about
> > the invalid last component of the name.
> 
> The last component of the name isn't invalid, it's a plain valid directory. If
> according to you `rmdir ../name` and rmdir `pwd` makes sense  then according to
> me `rmdir .` makes perfect sense too.

rmdir() works on _links_, not directories. Just as every other syscall of
that sort. It's _not_ "find directory and kill what you've found", it's
"find a link and destroy it; preserve the fs consistency".

	Code from another posting has a cute little property: it may kill a
directory that has absolutely nothing to your pwd. And that's OK - you
really can't get anything better than "kill whatever my pwd was called"
without a lot of PITA. And yes, it can happen in 2.2, along with many other
fun things.

	Andrea, fix your code. Linux-only stuff is OK when there is no
portable way to achieve the same result. In your situation such way indeed
exists and is prefectly doable in userland. If you want a cute DoWhatIMean
wrapper around rmdir(2) - fine, you've just written one of the variants.
Any reasons to keep that in the kernel? None? Thank you, case closed.

	"My code stopped working on 2.4" should actually be pronouced
"My code wouldn't work on anything but 2.2 (let's ignore the related
races that _are_ in 2.2), so could you please put a fix for my code into
the 2.4? No, I don't want to put that wrapper into my code, put it in 
the kernel". Sorry, not impressed.

	If this wrapper is OK for your purposes (for 99% of situations
it indeed is) - fine, use it. If you really need to destroy the directory
that happens to be your pwd - sorry, no reliable way to do that without
interesting locking. On _any_ UNIX out there. 2.2 included. It will
happily give you -ENOENT and refuse to perform the action above in
case if some other process renames your pwd. Yes, for rmdir(".");
It will also return that if your directory had been already rmdir()'d.
Have fun. Other Unices will return -EINVAL or -EBUSY - depends on
the flavour.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
