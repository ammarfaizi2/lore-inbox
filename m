Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRDSQEk>; Thu, 19 Apr 2001 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRDSQEb>; Thu, 19 Apr 2001 12:04:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28425 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130507AbRDSQEX>; Thu, 19 Apr 2001 12:04:23 -0400
Date: Thu, 19 Apr 2001 09:03:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alon Ziv <alonz@nolaviz.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <023c01c0c8a9$a4bb9940$910201c0@zapper>
Message-ID: <Pine.LNX.4.31.0104190849170.3842-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Alon Ziv wrote:
>
> * the userspace struct was just a signed count and a file handle.

The main reason I wanted to avoid a filehandle is just because it's
another name space that people already use, and that people know what the
semantics are for (ie "open()" is _defined_ to return the "lowest
available file descriptor", and people depend on that).

So if you use a file handle, you'd need to do magic - open it, and then
use dup2() to move it up high, or something. Which has its own set of
problems: just _how_ high woul dyou move it? Would it potentially disturb
an application that opens thousands of files, and knows that they get
consecutive file descriptors? Which is _legal_ and well-defined in UNIX.

However, I'm not married to the secure hash version - you could certainly
use another name-space, and something more akin to file descriptors. You
should be aware of issues like the above, though. Maybe it would be ok to
say "if you use fast semaphores, they use file descriptors and you should
no longer depend on consecutive fd's".

But note how that might make it really nasty for things like libraries:
can libraries use fast semaphores behind the back of the user? They might
well want to use the semaphores exactly for things like memory allocator
locking etc. But libc certainly cant use fd's behind peoples backs.

So personally, I actually think that you must _not_ use file descriptors.
But that doesn't mean that you couldn't have a more "file-desciptor-like"
approach.

Side note: the design _should_ allow for "lazy initialization". In
particular, it should be ok for FS_create() to not actually do a system
call at all, but just initialize the count and set a "uninitialized" flag.
And then the actual initialization would be done at "FS_down()" time, and
only if contention happens.

Why? Note that there are many cases where contention simply _cannot_
happen. The classic one is a thread-safe library that is used both by
threaded applications and by single-threaded ones, where the
single-threaded one would never actually trigger contention.

For these kinds of reasons it would actually be best to make try to
abstract the interfaces (notably the system call interface) as much as
possible, so that you can change the implementation inside the kernel
without having to recompile applications that use it. So the sanest
implementation might be one where

 - FS_create is a system call that just gets a 128-byte area and an ID.
 - the contention cases are plain system calls with no user-mode part to
   them at all.

This allows people to modify the behaviour of the semaphores later,
_without_ having any real coupling between user-mode expectations and
kernel implementation.

For example, if the user-mode library actually does a physical "open()" or
plays games with file descriptors itself, we will -always- be stuck with
the fd approach, and we can never fix it. But if you have opaque system
calls, you mist start out with a system call that internally just does the
equivalent of the "open a file descriptor and hide it in the semaphore",
and later on the thing can be changed to do whatever else without the user
program ever even realizing..

		Linus

