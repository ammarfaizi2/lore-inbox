Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269644AbRHCWeM>; Fri, 3 Aug 2001 18:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRHCWeC>; Fri, 3 Aug 2001 18:34:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49659 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269644AbRHCWdp>;
	Fri, 3 Aug 2001 18:33:45 -0400
Date: Fri, 3 Aug 2001 18:33:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
In-Reply-To: <20010804100143.A17774@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0108031814510.5264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Chris Wedgwood wrote:

> I really like this idea. Can people please try out the attached patch?
> 
> Please note, it contains a couple of things that need not be there in
> the final version.

Like an oopsable race absolutely trivial to exploit for any user with write
access to fs?

	a) dentry can freed under you. Just rename the parent while you
are syncing it. Then you'll block on attempt to take ->i_sem on
grandparent and merrily go to hell when parent will be moved away and
rename(2) will do dput() on grandparent.

	b) access to ->d_parent requires at least one of the following:
dcache_lock, BKL, i_sem or ->i_zombie on inode of parent.

	c) as it is, you will get a hell of IO load on a dumb fs.
dumb == anything that uses file_fsync() as ->fsync() of directories.
You'll do full sync of fs on every bloody step.

	d) sequence of inodes you sync has only one property guaranteed:
at some moment nth inode is a parent of (n-1)th. That's it. E.g. it's easy
to get a situation when _none_ of the inodes you sync had ever been a
grandparent of the original inode.

