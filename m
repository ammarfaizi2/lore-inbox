Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbREPXcM>; Wed, 16 May 2001 19:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262138AbREPXcC>; Wed, 16 May 2001 19:32:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25076 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261339AbREPXb5>;
	Wed, 16 May 2001 19:31:57 -0400
Date: Wed, 16 May 2001 19:31:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <3B030C11.3270CFA7@transmeta.com>
Message-ID: <Pine.GSO.4.21.0105161925420.26191-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 May 2001, H. Peter Anvin wrote:

> Alexander Viro wrote:
> > 
> > In full variant of patch I don't _have_ mount_root(9). It's done by
> > mount(2). Period. Initrd or not. Notice that rootfs stays absolute root
> > forever - it's much more convenient for fs/super.c, since you can get rid
> > of many kludges that way. So I'm not too happy about populating rootfs with
> > tons of files. BTW, loading initrd is done by open(2), read(2) and write(2) -
> > none of this fake struct file business anymore.
> > 
> 
> OK, I see what you're doing now.  However, I'm confused what you mean
> with "rootfs stays absolute root forever" -- does that mean that you
> mount the new root on top of /, and so the rootfs remains in the system
> never to be reclaimed, as opposed to pivot_root-ing it?

Yes. Pivot_root works, all right, but it rotates (your process' root, old, new).
So it works in chroot correctly now. And since we chroot out of the
absolute root when we mount initrd (or final root, for that matter) any
setup that used pivot_root keeps working as it did.

As for "never to be reclaimed"... Let's see:
	1 struct super_block
	1 struct vfsmount
	couple of struct dentry
	couple of struct inode
(for values of couple from 1 to 4; we can reduce it to 1 but I didn't bother
with that; all it takes is a couple of calls of sys_rmdir()/sys_unlink()).

Compared to the amount of space we free in .code of fs/super.c it's noise.

