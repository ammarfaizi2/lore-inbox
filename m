Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317651AbSFLHAk>; Wed, 12 Jun 2002 03:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317652AbSFLHAj>; Wed, 12 Jun 2002 03:00:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31839 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317651AbSFLHAj>; Wed, 12 Jun 2002 03:00:39 -0400
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Thunder from the hill <thunder@ngforever.de>,
        Dave Jones <davej@suse.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206092104.g59L4JD448386@saturn.cs.uml.edu>
	<m1vg8rutjm.fsf@frodo.biederman.org>
	<20020611174951.A24310@kushida.apsleyroad.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Jun 2002 00:50:45 -0600
Message-ID: <m1n0u1uh16.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:

> Eric W. Biederman wrote:
> > Actually by now most applications have been fixed and do not use
> > them.  The policy has been in place for several years now.
> 
> I like this policy and understand how to use it, except...
 
First early adopters of any feature have a challenge.  

> Once upon a time I wrote a program which used O_NOFOLLOW, before Glibc
> had support for that flag.
> 
> It had to read the kernel headers, as this macro is an
> architecture-dependent flag, and I did not want to write a program that
> was so non-portable it would only compile on some architectures.
> 
> Even if I'd copied all the definitions for all architectures out of the
> kernel, that wouldn't do: the program wouldn't compile on architectures
> added later, or ones that aren't part of the standard distribution.
> 
> So to keep the program relatively portable, it searched for definitions
> of O_NOFOLLOW in the kernel headers.  (It was a Glibc/kernel conflict
> nightmare).
> 
> Please can you suggest how I should write this sort of code, the next
> time it occurs?

Hmm.  I think I would do:
/* use the standard open includes */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#ifndef O_NOFOLLOW
#ifdef __i386__
#define O_NOFOLLOW  0400000
#else
#error I must have O_NOFOLLOW fix glibc
#endif
#endif

Or if it really didn't matter much:
#ifndef O_NOFOLLOW
#define O_NOFOLLOW 0
#endif

But even beyond that it makes a lot of sense to have autoconf add
a test for O_NOFOLLOW, and do something appropriate if it isn't
defined, or supported.  Otherwise your code gets brittle anyway. 

Where generic API extensions end up in the future is pretty well
defined, so you don't have to guess where libc will put them.

In most cases the kernel header rule only applies to pure linux
specific interfaces where the numbers don't change between
architectures, and to interfaces that are specific to a small subset
of programs, (device specific code like hdparm).   

But even using kernel headers doesn't help on current systems,
as you should have headers that correspond to the version of the
kernel your libc was compiled against.  So if libc didn't support
O_NOFOLLOW it is quite unlikely that user space would in any form.

Eric
