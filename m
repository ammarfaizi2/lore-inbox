Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285165AbRLHUmu>; Sat, 8 Dec 2001 15:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284813AbRLHUml>; Sat, 8 Dec 2001 15:42:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:52477 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285165AbRLHUm1>;
	Sat, 8 Dec 2001 15:42:27 -0500
Date: Sat, 8 Dec 2001 15:42:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for idiocy in mount_root cleanups.
In-Reply-To: <Pine.LNX.4.33.0112080957530.16918-100000@athlon.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112081514540.7302-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Dec 2001, Linus Torvalds wrote:

> "errno" is one of those few _really_ bad stupidities in UNIX. Linux has
> fixed it, and doesn't use it internally, and never shall. Too bad that
> user space has to fix up the _correct_ error code returning that the
> kernel does, and turn it into the "errno" stupidity for backwards
> compatibility.
> 
> (If you care why "errno" is stupid, just think about threading and
> performance)

Oh, I know why errno is stupid and normally my reaction would be the
same.  However, in this case I would prefer to add

static int errno;

to do_mounts.c and be done with that.  Reasons:

a) eventually it's going to userland, at which point the issue becomes moot
(we won't share memory with anybody and don't do signal handlers).

b) within this file we have at most two threads of execution (do_linuxrc()
and the rest).  mount_root() is called only while do_linuxrc() is either
not started yet or had already exited.  IOW, even in kernel it's safe.

c) when it's in userland we will be really better off with _syscall5 for
mount() - we can rewrite it by hands to return the value in sane manner,
but that means bringing a _lot_ of arch-specific inline assmebler into
the file.  Which we might have to do anyway, OTOH...

Dunno.  At this stage I'd prefer the patch I've posted + static int errno;
in do_mounts.c.  Alternatively, we can replace mount() with sys_mount() in
that place (everything else simply doesn't give a damn for errno) and deal
with that when we move code to userland.

