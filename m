Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRAJR3G>; Wed, 10 Jan 2001 12:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132041AbRAJR24>; Wed, 10 Jan 2001 12:28:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59283 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131958AbRAJR2m>;
	Wed, 10 Jan 2001 12:28:42 -0500
Date: Wed, 10 Jan 2001 12:28:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <20010110160359.E19503@athlon.random>
Message-ID: <Pine.GSO.4.21.0101101216370.13614-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Andrea Arcangeli wrote:

> > Do we have enough protection to ensure this for other filesystems?
> 
> Note that this has nothing to do with `rmdir .`. You will run into the
> mentioned issue just now with '''rmdir "`pwd`"'''. I've not checked
> the other fses but I would put such support into the VFS rather than in ext2
> (vfs can do that for you, if you do that the lowlevel fs will never get a
> readdir for a delete dentry).

That's precisely what I've already done. grep for IS_DEADDIR() and notice
that it's only checked under ->i_zombie. Both rmdir() and rename() hold
it on victim, readdir() holds it on directory it wants to read and everything
that creates or removes objects holds it on parent. Successful rmdir()
and rename()-over-directory set S_DEAD in the ->i_flags before dropping
->i_zombie.

The only thing that can happen with the dead directory is ->lookup().

IOW, in 2.4 most of filesystems had dropped the -EBUSY on rmdir() they
used to have. And ext2 got rid of the special handling of dead directories -
these checks are done in VFS now. The only fs with special treatment of
rmdir()/rename() wrt busy victims is NFS, IIRC.

Filesystems still can refuse to remove busy directories (same test as in
2.2) but there's almost no reasons for that.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
