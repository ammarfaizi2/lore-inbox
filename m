Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbRETQUo>; Sun, 20 May 2001 12:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262077AbRETQUe>; Sun, 20 May 2001 12:20:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54239 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262075AbRETQU1>;
	Sun, 20 May 2001 12:20:27 -0400
Date: Sun, 20 May 2001 12:20:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Edgar Toernig <froese@gmx.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: F_CTRLFD (was Re: Why side-effects on open(2) are evil.)
In-Reply-To: <3B07E6F6.E5C543B2@gmx.de>
Message-ID: <Pine.GSO.4.21.0105201203090.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Edgar Toernig wrote:

> IMHO any scheme that requires a special name to perform ioctl like
> functions will not work.  Often you don't known the name of the
> device you're talking to and then you're lost.

ls -l /proc/self/fd/<n>

and think of the results. We can export that as a syscall (fpath(2)), BTW.

Again, folks, there are two things that are no going to happen:

	1) sys_ioctl() going away from syscall table. Binary compatibility
with existing userland stuff that deals with networking ioctls. Unlike
special-case device ones, they really have a lot of users. Standard rules
are "2 stable releases until we remove a syscall".

	2) semi-automatic conversion of existing applications. To hell with
the way we are finding descriptor, we need to deal with arguments themselves.
And no extra logics in libc will help - the whole problem is that ioctls
have rather irregular arguments.

So "make it look as similar to ioctl() as possible" is not a good gaol.
It would be, if we were preparing to do mass switching to new mechanism
with minimal changes to existing codebase. Not realistic.

What we need is "make it sane", not "inherit as many things from the
old API as possible". And obvious first target is Linux-specific
device ioctls, simply because they have fewer programs using them.

Networking ioctls are there to stay for quite a while - we'll need
at the very least to implement old ones in a userland library.
Portability issues will be nasty, since _that_ stuff is used by
tons of programs.

