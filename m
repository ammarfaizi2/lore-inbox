Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSESFXP>; Sun, 19 May 2002 01:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314139AbSESFXO>; Sun, 19 May 2002 01:23:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25867 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313421AbSESFXN>; Sun, 19 May 2002 01:23:13 -0400
Date: Sat, 18 May 2002 22:23:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <E179HWb-0000jY-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205182210330.878-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 May 2002, Rusty Russell wrote:
> > returns 0, but a signal is delivered.  Then the only places which need
> > to be clever are the mount option copying, and the signal delivery
> > code for SIGSEGV (which uses copy_to_user).
>
> Sorry, this doesn't work here either: this would return the wrong
> value from read.

Oh, read() has to return the right value, but we should _also_ do a
SIGSEGV, in my opinion (it would also catch all those programs that didn't
expect it).

However, that apparently flies in the face of UNIX history and apparently
some standard (whether it was POSIX or SuS or something else, I can't
remember, but that discussion came up earlier..)

> Of course, everyone who does more than one copy_to_user should be
> checking that return value, and not doing:
>
> 	if (copy_to_user(uptr....)
> 	   || copy_to_user(uptr+10,....)
> 		return -EFAULT
>
> So that such gc schemes actually work,

Note that _most_ system calls are simply just re-startable, ie if your
"stat()" system call dies half-way and returns EFAULT, you can re-start it
without having to know how much of the "stat" structure you might have
filled in. So for many things a plain -EFAULT is plenty good enough, and
your "copy_to/from_user() should return 0/-EFAULT" would work for them.

But read (and particularly write) are _not_ re-startable without the
knowledge of how much was written, because they change f_pos and other
things ("write()" in particular changes a _lot_ of "other things", namely
the data in the file itself, of course).

There are other system calls that aren't re-startable, but basically
read/write are the "big ones", and thus Linux should try its best to make
them work in an environment that requires restartability. Most programs
can live without various random ioctl's and special system calls, but very
very few programs/environments can live without read/write.

("restartable" here doesn't mean that the _kernel_ would re-start them,
but that a "gc-aware library" can make wrappers around them and correctly
restart them internally, if you see my point - kind of like how stdio
already handles the issue of EINTR returns for read/write, which is
actually very similar in nature).

		Linus

