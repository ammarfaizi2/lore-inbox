Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275530AbRJNPlG>; Sun, 14 Oct 2001 11:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275573AbRJNPk4>; Sun, 14 Oct 2001 11:40:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49933 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275530AbRJNPkg>; Sun, 14 Oct 2001 11:40:36 -0400
Date: Sun, 14 Oct 2001 08:40:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <m1lmiera0x.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0110140836440.15323-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Oct 2001, Eric W. Biederman wrote:
>
> Hmm.  read-with-PAGE_COPY may not be any faster than read as you still
> read all of the data into memory, so you have almost the same latency.
> mmap might work better because of better overlapping of I/O and cpu
> processing.

Most of the time, you either have the IO overhead (and whether you use
read or mmap won't matter all that much, because you're IO limited), or
the thing is cached.

For gcc, it's cached 99% of the time, because most of the IO ends up being
header files (this is, of course, assuming that you're compiling a big
project, but if you're not, the big overhead is in loading _gcc_, not in
the pages it reads).

> Also read-with-PAGE_COPY has some really interesting implications for the
> page out routines.  Because anytime you start the page out you have to
> copy the page.  Not exactly when you want to increase the memory presure.

No no. Read my thing again. On swap-out, you just move the thing to the
swap cache.

Sure, that removes it from the regular cache, and that's possibly a
performance problem. But

> And not at all suitable for shared libraries.

No. Why would you "read" shared libraries? read is read, mmap is mmap. If
you want mmap, use mmap. Don't mess it up with MAP_COPY, which is not mmap
at all.

		Linus

