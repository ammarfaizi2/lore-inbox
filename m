Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRJNS7d>; Sun, 14 Oct 2001 14:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276912AbRJNS7X>; Sun, 14 Oct 2001 14:59:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35908 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276877AbRJNS7F>; Sun, 14 Oct 2001 14:59:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110140836440.15323-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2001 12:49:25 -0600
In-Reply-To: <Pine.LNX.4.33.0110140836440.15323-100000@penguin.transmeta.com>
Message-ID: <m1bsjaqcp6.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 14 Oct 2001, Eric W. Biederman wrote:
> >
> > Hmm.  read-with-PAGE_COPY may not be any faster than read as you still
> > read all of the data into memory, so you have almost the same latency.
> > mmap might work better because of better overlapping of I/O and cpu
> > processing.
> 
> Most of the time, you either have the IO overhead (and whether you use
> read or mmap won't matter all that much, because you're IO limited), or
> the thing is cached.

Thanks that makes sense for where you are targeting the performance
improvement.

> For gcc, it's cached 99% of the time, because most of the IO ends up being
> header files (this is, of course, assuming that you're compiling a big
> project, but if you're not, the big overhead is in loading _gcc_, not in
> the pages it reads).

O.k.  So the case that matters is when you are repeatedly reading from
the cache.

> > Also read-with-PAGE_COPY has some really interesting implications for the
> > page out routines.  Because anytime you start the page out you have to
> > copy the page.  Not exactly when you want to increase the memory presure.
> 
> No no. Read my thing again. On swap-out, you just move the thing to the
> swap cache.
> 
> Sure, that removes it from the regular cache, and that's possibly a
> performance problem. But

On swap-out the optimization to steal the page from the page cache
makes it much less of a problem.  But you still have to be prepared to
do the copy.  As there might be multiple users of the page, in which
case you can't steal the page cache copy. 

> > And not at all suitable for shared libraries.
> 
> No. Why would you "read" shared libraries? read is read, mmap is mmap. If
> you want mmap, use mmap. Don't mess it up with MAP_COPY, which is not mmap
> at all.

Linus I'm sure you realized that.  I'm not certain the whole rest of the world
did.  And the shared library topic is what got this discussion going.

Hmm.  So what you are looking at is something similiar to O_DIRECT,
but that will instead of doing the I/O and bypassing the page cache,
will instead borrow the page cache copies pages.

Eric

