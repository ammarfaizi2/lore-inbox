Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135729AbRDSVmZ>; Thu, 19 Apr 2001 17:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135725AbRDSVmQ>; Thu, 19 Apr 2001 17:42:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40201 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135729AbRDSVmC>; Thu, 19 Apr 2001 17:42:02 -0400
Date: Thu, 19 Apr 2001 14:41:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@cygnus.com>
cc: Alexander Viro <viro@math.psu.edu>,
        Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <m3pue8ziyq.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.4.31.0104191433001.1334-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Apr 2001, Ulrich Drepper wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
>
> > > I fail to see how this works across processes.
> >
> > It's up to FS_create() to create whatever shared mapping is needed.
>
> No, the point is that FS_create is *not* the one creating the shared
> mapping.  The user is explicitly doing this her/himself.

No.

Who creates the shared mapping is _irrelevant_, because it ends up being
entirely a function of what the chosen interface is.

For example, quote often you want semaphores for threading purposes only,
and then you don't need a shared mapping at all. So you'd use the proper
interfaces for that, and for that, your "thread_semaphore()" function
would just do a malloc() and initialize the memory to zero. Doing a mmap
or something like that would just be stupid, because you're protecting
only one VM space anyway.

In other cases, you may need to have process-wide semaphores, and you'd
use "process_semaphore(char *ID)" or something, which actually does a
mmap() on a shared file. Or you'd have "fork_semaphore()" that creates a
semaphore that is valid across forks, not not valid across execve's and
cannot be passed around.

So normally the user does NOT create the shared mapping himself. Normally
you'd just use the "proper interface" for your needs, nothing more.

Sure, you can have the option of saying "I've created this shared memory
region, please make it use the generic semaphore engine code", but quite
frankly I think that is a BAD IDEA. Why? Because it won't work portably
across architectures anyway. You don't know what the requirements of the
architecture are, so it should be done by a nice "semaphore library". NOT
by the user.

Remember: these semaphores are NOT a new SysV bogosity. These semaphores
are a new interface, with sane performance and sane design. And you can
have multiple external interfaces to the same "semaphore engine".

I'm not interested in re-creating the idiocies of Sys IPC.

		Linus

