Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281435AbRKLLka>; Mon, 12 Nov 2001 06:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281437AbRKLLkV>; Mon, 12 Nov 2001 06:40:21 -0500
Received: from moses.parsec.at ([212.236.50.196]:3339 "EHLO moses.parsec.at")
	by vger.kernel.org with ESMTP id <S281418AbRKLLkG>;
	Mon, 12 Nov 2001 06:40:06 -0500
Date: Mon, 12 Nov 2001 12:39:50 +0100 (CET)
From: Andreas Gruenbacher <ag@bestbits.at>
To: Alexander Viro <viro@math.psu.edu>
cc: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
In-Reply-To: <Pine.GSO.4.21.0111120132080.19192-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al,

On Mon, 12 Nov 2001, Alexander Viro wrote:
> 
> [Cc'd to Linus since API changes on that level definitely require his
> approval]
> 
> On Mon, 12 Nov 2001, Nathan Scott wrote:
> 
> > +static long
> > +extattr_inode(struct inode *i, int cmd, char *name, void *value, size_t size)
> 
> Broken.
> 	a) passing inode is an obvious mistake.  dentry or vfsmount/dentry.

There are curently two paths by which the extended attribute inode
operations can be invoked: (a) from a system call, (b) from the
permission() inode operation, when checking the access ACL of a file. We
could trivially use a dentry in (a), but unfortunately we don't have a
choice in (b), as permission() itself is not passed a dentry.
   It's planned that all inode operations use dentries somewhen in 2.5.
This would be the proper time to move to dentries in the EA code as well.

> 	b) for crying out loud, what's that with SGI and ioctl-like abortions?
> 
> Rule of the tumb: if your function got a "cmd" argument - it's broken.
> ioctl(2).  fcntl(2).  prctl(2).  quotactl(2).  sysfs(2).  Missed'em'V IPC
> syscalls.  Enough, already.

There is one difference between the interfaces you are complaining about
above and the proposed EA interface for EA's: In those interfaces you have
wildcard parameters that are used for who-knows-what, depending on a
command-like parameter, including use as a value, use as a pointer to a
value/struct, etc.

In the EA interface we have clear semantics of what the parameters' types
and sizes are, so many of the problems there are with ioctl() and friends
don't occur here. You could as well call the `cmd' parameter a `flags'
parameter here, then you're pretty close to the open() syscall.

It would be possible to split the EA syscalls in a set for retrieving and
aonther set for setting EA's, and perhaps still a third set for listing
the EA's that are present. Those syscalls would only differ in their
names. I would consider it much more useful to provide functions in a
library for dealing with EA's in user space, which in turn would use the
syscalls, though.


Cheers,
Andreas.

