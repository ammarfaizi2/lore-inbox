Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316245AbSEKSFQ>; Sat, 11 May 2002 14:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316246AbSEKSFQ>; Sat, 11 May 2002 14:05:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42506 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316245AbSEKSFO>; Sat, 11 May 2002 14:05:14 -0400
Date: Sat, 11 May 2002 11:04:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Gerrit Huizenga <gh@us.ibm.com>
cc: Lincoln Dale <ltd@cisco.com>, Andrew Morton <akpm@zip.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14
 IDE 56) 
In-Reply-To: <E176LG9-0002cP-00@w-gerrit2>
Message-ID: <Pine.LNX.4.44.0205111047280.2355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Gerrit Huizenga wrote:
> In message <Pine.LNX.4.44.0205100854370.2230-100000@home.transmeta.com>, > : Li
> nus Torvalds writes:
> >
> > For O_DIRECT to be a win, you need to make it asynchronous.
>
> O_DIRECT is especially useful for applications which maintain their
> own cache, e.g. a database.  And adding Async to it is an even bigger
> bonus (another Oracleism we did in PTX).

The thing that has always disturbed me about O_DIRECT is that the whole
interface is just stupid, and was probably designed by a deranged monkey
on some serious mind-controlling substances [*].

It's simply not very pretty, and it doesn't perform very well either
because of the bad interfaces (where synchronocity of read/write is part
of it, but the inherent page-table-walking is another issue).

I bet you could get _better_ performance more cleanly by splitting up the
actual IO generation and the "user-space mapping" thing sanely. For
example, if you want to do an O_DIRECT read into a buffer, there is no
reason why it shouldn't be done in two phases:

 (1) readahead: allocate pages, and start the IO asynchronously
 (2) mmap the file with a MAP_UNCACHED flag, which causes read-faults to
     "steal" the page from the page cache and make it private to the
     mapping on page faults.

If you split it up like that, you can do much more interesting things than
O_DIRECT can do (ie the above is inherently asynchronous - we'll wait only
for IO to complete when the page is actually faulted in).

For O_DIRECT writes, you split it the other way around:

 (1) mmwrite() takes the pages in the memory area, and moves them into the
     page cache, removing the page from the page table (and only copies
     if existing pages already exist)
 (2) fdatasync_area(fd, offset, len)

Again, the above is likely to be a lot more efficient _and_ can do things
that O_DIRECT only dreams on.

With my suggested _sane_ interface, I can do a noncached file copy that
should be "perfect" even in the face of memory pressure by simply doing

	addr = mmap( ..  MAP_UNCACHED ..  src .. )
	mwrite(dst, addr, len);

which does true zero-copy (and, since mwrite removes it from the page
table anyway, you can actually avoid even the TLB overhead trivially: if
mwrite notices that the page isn't mapped, it will just take it directly
from the page cache).

Sadly, database people don't seem to have any understanding of good taste,
and various OS people end up usually just saying "Yes, Mr Oracle, I'll
open up any orifice I have for your pleasure".

			Linus

[*] In other words, it's an Oracleism.

