Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbRE3Gvq>; Wed, 30 May 2001 02:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbRE3Gvf>; Wed, 30 May 2001 02:51:35 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:52475 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262078AbRE3GvT>; Wed, 30 May 2001 02:51:19 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105300649.f4U6naMl021300@webber.adilger.int>
Subject: Re: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are deref'd
In-Reply-To: <Pine.GSO.4.21.0105300134520.12645-100000@weyl.math.psu.edu>
 "from Alexander Viro at May 30, 2001 01:45:00 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Wed, 30 May 2001 00:49:35 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:
> On Tue, 29 May 2001, Andreas Dilger wrote:
> > For ext2 it is pretty much the same, except ext2_delete_entry() called
> > ext2_check_dir_entry() with a NULL input (for some reason), but it could
> > easily supply a valid input value.  All callers to ext2_delete_entry()
> > dereference the dir parameter before calling ext2_delete_entry().  All
> > other paths dereference dir before ext2_check_dir_entry() is called.
> 
> Wrong fix. It
> 	a) doesn't close all potential problems (think what happens if you
> run too close to the end of buffer)

No, it doesn't fix all the problems of ext2.  It fixes only this one issue.

> 	b) doesn't fix anything that could be triggered - ext2_delete_entry()
> can happen only if you've already done lookup. I.e. no problems had been
> found in that block back when we were finding the entry.

That means there is no need to check dir in ext2_check_dir_entry(),
is there?  If all callers to ext2_delete_entry() already verify the
buffer in ext2_find_entry() (which they appear to do), then there is
no point in calling ext2_check_dir_entry() at all.

> 	c) makes ugly code uglier.

Did you even look at the patch?  I didn't ADD extra checks, I REMOVED the
(useless) checking for dir == NULL in ext2_check_dir_entry().  How can
that be "uglier"?

> 	d) real fix exists and got a lot of testing over that last 5 months.

Yes, I know all about it, I need it as part of the ext2 indexed directory
code.  That doesn't mean your directory-in-pagecache will make it in to
2.4, so may as well fix the minor "problem" that exists now (it is not a
BUG, but a waste of a few cycles in a function that is called a LOT).

If your patch makes it into 2.4 then even better.  If not, then my fix is
still better than leaving it as is, and it is "obviously correct" while
your patch changes a LOT of code.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
