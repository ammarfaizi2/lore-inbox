Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262199AbTCHUuF>; Sat, 8 Mar 2003 15:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbTCHUuF>; Sat, 8 Mar 2003 15:50:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9767 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262199AbTCHUuB>; Sat, 8 Mar 2003 15:50:01 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
	<20030307233916.Q17492@flint.arm.linux.org.uk>
	<m1d6l2lih9.fsf@frodo.biederman.org>
	<20030308100359.A27153@flint.arm.linux.org.uk>
	<m18yvpluw7.fsf@frodo.biederman.org>
	<20030308161309.B1896@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Mar 2003 10:28:43 -0700
In-Reply-To: <20030308161309.B1896@flint.arm.linux.org.uk>
Message-ID: <m1vfytkbsk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Sat, Mar 08, 2003 at 08:50:48AM -0700, Eric W. Biederman wrote:
> > Exactly.  And you build it for the specific purpose of just
> > configuring the system.  And by not handling the general case you
> > should be able to get another significant size reduction.
> 
> You do not want to be too specific though - a kernel with features
> X, Y, and Z in the current setup can boot using any of those features
> by just supplying the appropriate command line.
> 
> The reason HPA wanted to go down the userspace route, btw, was to
> support additional add-ons for bringing other stuff up - remember this
> is part of the initramfs spec that was reviewed by this list many
> months ago?  Or has that now gone completely out of the window?

I don't recall anything about the contents of initramfs being specified.
What I was expecting to see was a good set of general purpose policies
being included in the default kernel binary.  And just replacing
/sbin/kinit if I wanted something dramatically different.  And that is
what I remember Al Viro working on.

So I don't think building a very specific /sbin/kinit that
only does what the kernel currently does right now is a problem.

initramfs looks very nice as it cleans up a lot of problems with building
ext2fs filesystem images on the fly.  And it let's me use a ramfs filesystem
from the start.  On systems I am looking at in the future that will enable
me to compile out the block layer entirely.

Currently I have all of the features initramfs promises, and they get
routinely used.  The initramfs stuff is just an incremental
improvement that should makes things cleaner and smaller.  All of my
policy is already in user space and as I boot over the network size is
not a large constraint.  And I still boot up fast enough that I
occasionally have problems with my hard drivers not being spun up yet.

So I like the initramfs spec.

And I like the idea of having a library that makes it easy to
build new small user space binaries.

In the cases where things are sufficiently general that I need
a script interpreter I don't want klibc and /bin/sh.  I want glibc
and /bin/bash.  Because at that point I will be throwing random
executables at need from a working system anyway.  And having to
recompile everything to be tiny is not flexible.  This issue has
come up multiple times when the design of an initrd for one purpose or
another has been considered and every time the sheer flexibility and
simplicity of using the normal user space wins out over some tiny
solution.

There may be some usage point where a little extra flexibility
is paid for by having a command interpreter and separate binaries but
I don't currently see it.  Either I am very general in which point klibc
is to inflexible.  Or I am very specific at which point I can put
everything into a /sbin/kinit.

So I think we should have a very small very specific /sbin/kinit
that does in user space what the kernel does in kernel space right
now.  Regardless of klibc the default /sbin/kinit should be gpl'd
because we are moving code from code from the kernel into it, and we
shouldn't need to double check the licenses to move code from the
kernel into it.

There are things that would be nice to get in there like the lvm
configuration tools and the like so you can have some more
sophisticated mount options.  But I don't much care.  It is only the
kernel's default policy and it can be replaced.

For cases where you need a very different policy with all of the
embedded libc's currently out there.  klibc, uclibc, dietlibc it
should not be hard to make your own /sbin/kinit.

Eric
