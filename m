Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270075AbRHGF3A>; Tue, 7 Aug 2001 01:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270076AbRHGF2u>; Tue, 7 Aug 2001 01:28:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23287 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270075AbRHGF2i>;
	Tue, 7 Aug 2001 01:28:38 -0400
Date: Tue, 7 Aug 2001 01:28:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070517.f775HEw30547@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108070121530.16817-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Richard Gooch wrote:

> > It isn't. socket_i is used only in inodes allocated by sock_alloc().
> > It is not used in the inodes that live on any fs other than sockfs.
> 
> OK. Although, where is sockfs?

net/socket.c. It's a pseudo-fs where all real sockets go. Nothing
spectacular - just a superblock + directory + bunch of dentries.
When we allocate a socket (socket(2), accept(2), socketpair(2), etc.)
its dentry is made a child of sockfs root and given the right name,
so that readlink on /proc/<pid>/fd/<n> would do the right thing
without any special-casing. Besides, we can get rid of checks for
inode->i_sb != NULL - it's _always_ non-NULL now (we have a similar
one for pipe(2)-created pipes). We also get pipe and socket struct file
out of the anonymous list - they live on the ->s_files of their
superblocks. Neither sockfs nor pipefs can be mounted by user, so it's 
not visible to user, or, for that matter, to the rest of the kernel.
Some special-casing is gone - that's it.

